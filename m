Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54417E66889
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD41689434;
	Sat, 23 Nov 2024 22:49:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64569893AA; Sat, 23 Nov 2024 20:57:42 +0100 (CET)
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F4E893D2
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 20:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mjg59@codon.org.uk
Received: from fedora.. (23-93-16-71.fiber.dynamic.sonic.net [23.93.16.71])
 by cavan.codon.org.uk (Postfix) with ESMTPSA id B5A71407EA;
 Sat, 23 Nov 2024 19:57:38 +0000 (GMT)
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: u-boot@lists.denx.de
Cc: Matthew Garrett <mgarrett@aurora.tech>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/10] Use the correct ramdisk address
Date: Sat, 23 Nov 2024 11:55:07 -0800
Message-ID: <20241123195616.305687-9-mjg59@srcf.ucam.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241123195616.305687-1-mjg59@srcf.ucam.org>
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 23 Nov 2024 22:49:00 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Matthew Garrett <mgarrett@aurora.tech>

CONFIG_SYS_BOOT_RAMDISK_HIGH copies the initrd out of the FIT and into
correctly aligned RAM, but the addresses used for this are then discarded
by the x86 bootm code. Fix that.

Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
---

 arch/x86/lib/bootm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index c4446b1f9c6..cabf18fccb7 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -72,6 +72,7 @@ int arch_fixup_memory_node(void *blob)
 /* Subcommand: PREP */
 static int boot_prep_linux(struct bootm_headers *images)
 {
+	ulong initrd_start, initrd_size;
 	char *cmd_line_dest = NULL;
 	struct legacy_img_hdr *hdr;
 	int is_zimage = 0;
@@ -134,10 +135,16 @@ static int boot_prep_linux(struct bootm_headers *images)
 		goto error;
 	}
 
+	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH)) {
+		initrd_start = images->initrd_start;
+		initrd_size = images->initrd_end - images->initrd_start;
+	} else {
+		initrd_start = images->rd_start;
+		initrd_size = images->rd_end - images->rd_start;
+	}
 	printf("Setup at %#08lx\n", images->ep);
 	ret = setup_zimage((void *)images->ep, cmd_line_dest,
-			0, images->rd_start,
-			images->rd_end - images->rd_start, 0);
+			   0, initrd_start, initrd_size, 0);
 
 	if (ret) {
 		printf("## Setting up boot parameters failed ...\n");
-- 
2.47.0

