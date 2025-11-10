Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240DFCCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 12:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8938D839B7;
	Mon, 10 Nov 2025 13:41:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="AdoOcbD8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A1DA83A07; Mon, 10 Nov 2025 13:41:20 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A7908391C
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 13:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D7D4A108BCE; Mon, 10 Nov 2025 13:41:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1762778477; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=xm5+/qBT2UGHvqxy3lh5PsqY7ZQWjo4wLhVNJVHrP9Y=;
 b=AdoOcbD85dLlkK1sbvt8LAkWZXSPr8R/xuabTYFLck2hTUozL6oi4/RE4vPRv2z8JDrFQj
 +jf2vVBCblKnytLQGC7lD+9fpLFPTGSztJx7utdrfjGPFxl5zKY1TUQzirZMkAGjKr9cA7
 nD/5N3yA9ezkCUup01GNaZnmkFl6Qv5H7N98uDgcgc1l0N8RgkbuDITpKX11AVdT0keoXy
 53a65QEmkEpllbKqwxawfVdO3RwJfltP2YnBgSVRsiWUN+nxDGxFuxU+oFkHKtw9KU0ICH
 3d3OHCh+jukHpx2j9b43I0icxvUUsh66SYE6C2bC9HzhpA/R0HqbPBJKxLmPiw==
From: Lukasz Majewski <lukma@nabladev.com>
To: Stefano Babic <sbabic@nabladev.com>,
	Fabio Estevam <festevam@gmail.com>
Cc: uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 John Ripple <john.ripple@keysight.com>, Peng Fan <peng.fan@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Lukasz Majewski <lukma@nabladev.com>
Subject: [PATCH] arm: imx: Add command to get offset of first image in AHAB OS
 container
Date: Mon, 10 Nov 2025 13:41:00 +0100
Message-Id: <20251110124100.4193259-1-lukma@nabladev.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

With current mainline it is possible to check with AHAB if system OS image
can be trusted (with 'auth_cntr' command).
However, after the validation one needs to use the image (fitImage in this
case) itself. Such operation requires getting the offset in the image
eligible for AHAB validation to start execution of the fitImage.

Command in this patch allows it, so with:
auth_cntr_offset ${addr} auth_cntr_os_offset;
setexpr addr ${kernel_addr_r} + ${auth_cntr_os_offset};

it is possible to boot the fitImage after AHAB IP block vaidation.

Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
---
 arch/arm/mach-imx/imx8/ahab.c | 50 +++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/mach-imx/imx8/ahab.c b/arch/arm/mach-imx/imx8/ahab.c
index f13baa871cc..da0e1f3382b 100644
--- a/arch/arm/mach-imx/imx8/ahab.c
+++ b/arch/arm/mach-imx/imx8/ahab.c
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <imx_container.h>
 #include <log.h>
+#include <env.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <firmware/imx/sci/sci.h>
@@ -424,6 +425,55 @@ static int do_ahab_commit(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
+static int do_ahab_get_offset(struct cmd_tbl *cmdtp, int flag, int argc,
+			      char *const argv[])
+{
+	struct container_hdr *phdr;
+	const char *name = argv[2];
+	struct boot_img_t *img;
+	u16 length;
+	ulong cntr;
+	int err;
+
+	if (argc != 3)
+		return CMD_RET_USAGE;
+
+	if (!name)
+		return CMD_RET_USAGE;
+
+	cntr = hextoul(argv[1], NULL);
+
+	phdr = (struct container_hdr *)cntr;
+	length = phdr->length_lsb + (phdr->length_msb << 8);
+
+	err = ahab_auth_cntr_hdr(phdr, length);
+	if (err) {
+		printf("Authenticate OS container header has failed!\n");
+		return 1;
+	}
+
+	ahab_auth_release();
+
+	/*
+	 * Get the offset for first image (Image0Offset at Fitgure 1.
+	 * of AN12312)
+	 */
+	img = (struct boot_img_t *)
+		((ulong)phdr + sizeof(struct container_hdr));
+
+	debug("%s=0x%x\n", name, img->offset);
+
+	return env_set_hex(name, img->offset);
+}
+
+U_BOOT_CMD(auth_cntr_offset, CONFIG_SYS_MAXARGS, 1, do_ahab_get_offset,
+	   "provide first image offset from AHAB OS container",
+	   "addr name\n"
+	   "addr - OS container hex address\n"
+	   "name - name of the env variable to store offset of the first\n"
+	   "       image from AHAB OS container\n"
+);
+
 U_BOOT_CMD(auth_cntr, CONFIG_SYS_MAXARGS, 1, do_authenticate,
 	   "autenticate OS container via AHAB",
 	   "addr\n"
-- 
2.39.5

