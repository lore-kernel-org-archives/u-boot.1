Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0F7C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 11:04:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA0D688A92;
	Wed, 14 Aug 2024 13:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 361A088A79; Wed, 14 Aug 2024 13:02:22 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B80A588A35
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 13:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28B07DA7;
 Wed, 14 Aug 2024 04:02:44 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A98933F58B;
 Wed, 14 Aug 2024 04:02:13 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 21/32] spl: sandbox: initialise the ram banksize in spl
Date: Wed, 14 Aug 2024 16:29:58 +0530
Message-Id: <20240814110009.45310-22-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814110009.45310-1-sughosh.ganu@linaro.org>
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Initialise the ram bank information for sandbox in SPL. This is needed
for adding available memory to the LMB memory map, which is done as
part of the initialisation sequence.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1:
* Update the commit message to explain why this change is being done.

 arch/sandbox/cpu/spl.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index bcb1ca10a5..1b9896bc68 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -127,6 +127,15 @@ static int load_from_image(struct spl_image_info *spl_image,
 }
 SPL_LOAD_IMAGE_METHOD("sandbox_image", 7, BOOT_DEVICE_BOARD, load_from_image);
 
+int dram_init_banksize(void)
+{
+	/* These are necessary so TFTP can use LMBs to check its load address */
+	gd->bd->bi_dram[0].start = gd->ram_base;
+	gd->bd->bi_dram[0].size = get_effective_memsize();
+
+	return 0;
+}
+
 void spl_board_init(void)
 {
 	struct sandbox_state *state = state_get_current();
@@ -134,10 +143,6 @@ void spl_board_init(void)
 	if (!CONFIG_IS_ENABLED(UNIT_TEST))
 		return;
 
-	/* These are necessary so TFTP can use LMBs to check its load address */
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = get_effective_memsize();
-
 	if (state->run_unittests) {
 		struct unit_test *tests = UNIT_TEST_ALL_START();
 		const int count = UNIT_TEST_ALL_COUNT();
-- 
2.34.1

