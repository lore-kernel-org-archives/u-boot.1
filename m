Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397ECC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 21:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 992F080B9B;
	Thu, 30 Jan 2025 22:58:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="1a1h9RIe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24E9180EEB; Thu, 30 Jan 2025 22:58:22 +0100 (CET)
Received: from smtp-out.freemail.hu (fmfe34.freemail.hu [46.107.16.239])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4C0680AE2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 22:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
Received: from localhost.localdomain (catv-178-48-208-49.catv.fixed.one.hu
 [178.48.208.49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.freemail.hu (Postfix) with ESMTPSA id 4YkXvt0MZXz1Bm;
 Thu, 30 Jan 2025 22:58:18 +0100 (CET)
From: egyszeregy@freemail.hu
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, love.kumar@amd.com,
 =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH] zynqmp: Dynamic setting mmcdev and mmcroot
Date: Thu, 30 Jan 2025 22:57:06 +0100
Message-ID: <20250130215706.291-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.1.windows.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1738274298; 
 s=20181004; d=freemail.hu;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 l=2585; bh=JemaHWl22vuoVyJpA4jshnCb9KHAUNiQj0GFxcnMjPQ=;
 b=1a1h9RIeEBKBG1MNZ7swlcR6xnNSRTxVhepW4PJWcLI7NEk64oKqds/knwLawfkU
 6aDviKvN7q3jiBiJMGuDr6Hb9eCDu8d4ZR3kxishpegg2Nuell0yWgDncvjZTxKezbC
 bsILq1bRd7hrZ1A3uNOc45vUO4aCOaHRBHiE6a1nYsCESLo1VAP8vuwgLXyhPUDowbs
 hIAeuZzVs/VZV51joGzlNh+WZwThjHE95rj3xVAZ4bfv8FIklMbY7TXP8IbxHm5KXHH
 5OJoSGB+OcTt6lXgpriWo5rkCu8BCVt/+clPGv0YJZ0CVusOZZMTz8M+kvNnH1VeRsB
 uTvR7BA9dQ==
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

From: Benjamin Szőke <egyszeregy@freemail.hu>

Dynamic setting mmcdev and mmcroot.
Then when boot linux, we can have correct "root=/dev/mmcblk[x]p2"

ref: board/freescale/common/mmc.c
https://github.com/u-boot/u-boot/blob/master/board/freescale/common/mmc.c

Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
---
 board/xilinx/zynqmp/zynqmp.c    | 18 ++++++++++++++++++
 include/configs/xilinx_zynqmp.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 8cdd9d8600..d450b53982 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -401,10 +401,14 @@ static int boot_targets_setup(void)
 	struct udevice *dev;
 	int bootseq = -1;
 	int bootseq_len = 0;
+	int mmc_dev_no = -1;
 	int env_targets_len = 0;
 	const char *mode = NULL;
 	char *new_targets;
 	char *env_targets;
+	char *autodetect_str = env_get("mmcautodetect");
+	char cmd[32];
+	char mmcblk[32];
 
 	bootmode = zynqmp_get_bootmode();
 
@@ -438,6 +442,7 @@ static int boot_targets_setup(void)
 		debug("mmc0 device found at %p, seq %d\n", dev, dev_seq(dev));
 
 		mode = "mmc";
+		mmc_dev_no = 0;
 		bootseq = dev_seq(dev);
 		env_set("modeboot", "emmcboot");
 		break;
@@ -453,6 +458,7 @@ static int boot_targets_setup(void)
 		debug("mmc0 device found at %p, seq %d\n", dev, dev_seq(dev));
 
 		mode = "mmc";
+		mmc_dev_no = 0;
 		bootseq = dev_seq(dev);
 		env_set("modeboot", "sdboot");
 		break;
@@ -471,6 +477,7 @@ static int boot_targets_setup(void)
 		debug("mmc1 device found at %p, seq %d\n", dev, dev_seq(dev));
 
 		mode = "mmc";
+		mmc_dev_no = 1;
 		bootseq = dev_seq(dev);
 		env_set("modeboot", "sdboot");
 		break;
@@ -513,6 +520,17 @@ static int boot_targets_setup(void)
 
 		env_set("boot_targets", new_targets);
 		free(new_targets);
+
+		if ((autodetect_str && !strcmp(autodetect_str, "yes")) && (mmc_dev_no >= 0)) {
+			env_set_ulong("mmcdev", (unsigned long)mmc_dev_no);
+
+			/* Set mmcblk env */
+			sprintf(mmcblk, "/dev/mmcblk%dp2 rootwait rw", mmc_dev_no);
+			env_set("mmcroot", mmcblk);
+
+			sprintf(cmd, "mmc dev %d", mmc_dev_no);
+			run_command(cmd, 0);
+		}
 	}
 
 	return 0;
diff --git a/include/configs/xilinx_zynqmp.h b/include/configs/xilinx_zynqmp.h
index bb0db7c5ca..1113101717 100644
--- a/include/configs/xilinx_zynqmp.h
+++ b/include/configs/xilinx_zynqmp.h
@@ -180,6 +180,7 @@
 #define CFG_EXTRA_ENV_SETTINGS \
 	ENV_MEM_LAYOUT_SETTINGS \
 	BOOTENV
+	"mmcautodetect=yes\0"
 #endif
 
 /* SPL can't handle all huge variables - define just DFU */
-- 
2.47.1.windows.2

