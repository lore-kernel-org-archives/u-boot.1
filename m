Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA37ACD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54212848F0;
	Mon,  8 Jun 2026 15:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="w1Q/z1R8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7181E848E2; Mon,  8 Jun 2026 15:09:34 +0200 (CEST)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35B7D84894
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 20260608130931fd9fc034a400020725 for <u-boot@lists.denx.de>;
 Mon, 08 Jun 2026 15:09:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LYkxQ1pqDZi6fvRFg1htcFuSsadZr58cgXuoa+Z5TSU=;
 b=w1Q/z1R8j8gIOaDElCZ6S6XB6Pu5k/P/qN59jTdyrfjLVcD+sCv71RQZP/5T6jwpQYsfVM
 cCT9P0Yn02S6O61UeDiJmPCSD1RQj4ieSXxbX/kiSHMiosiuxDLtNw+FGt5SNkEpWCG8u8DS
 FudFLY+ISkxxbA+C+dnyW9lbPMyWhf8OCsweqPC6gVUL0GM+JbbO/643XBr5b2GlLLtha38r
 0TbV2ZbZaGNOh8PGB16XEVhccLTZJi5kWwV9erxTvtUozabfniadSfxzwlfNdgcwJmyc0K52
 tk2rF6POvOmeUc1L9EEVYspPT7rG8ttkse1mlyR4agsVddSZQht53vFA==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v6 1/7] qemu-arm64: merge built-in DT
Date: Mon,  8 Jun 2026 15:08:47 +0200
Message-ID: <20260608150852.v6.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
In-Reply-To: <20260608130924.112831-1-ludwig.nussel@siemens.com>
References: <20260608130924.112831-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

The keys trusted for FIT signature verification are supposed to be
embedded in the device tree built into u-boot. When running in Qemu it's
convenient to use the device tree provided by the VM which doesn't know
about signatures though. So merge both device trees at startup.

Make sure CONFIG_OF_OMIT_DTB is not set in qemu_arm64_defconfig to take
advantage of the feature by default.

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

Changes in v6:
- fix comment style and typos
- fix error message
- return error from board_fdt_blob_setup() if dt couldn't be resized or
  merged. Unfortunately fdtdec_ret_to_errno() is static elsewere so
  -EINVAL has to suffice
- mention CONFIG_OF_OMIT_DTB in commit message

Changes in v4:
- mention arm in subject
- correctly change defconfig

Changes in v3:
- enable CONFIG_OF_OMIT_DTB=n in defconfig
- add error returns
- document decission about dt merging direction

 board/emulation/qemu-arm/qemu-arm.c | 48 +++++++++++++++++++++++++++--
 configs/qemu_arm64_defconfig        |  1 +
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index 38f0ec5f2fb..a0de46b6b0a 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -144,10 +144,54 @@ int dram_init_banksize(void)
 	return 0;
 }
 
+/*
+ * QEMU loads a generated DTB for us at the start of RAM.
+ * When using signatures we may have a built-in FDT that contains
+ * our known public keys nevertheless. So merge the built-in FDT
+ * into QEMU's. We cannot merge the other way around (e.g. in
+ * fdtdec_board_setup()) or board_fix_fdt() at this stage as U-Boot
+ * might be started from a ROM location. At the same time U-Boot
+ * needs QEMU's FDT to initialize serial devices even before
+ * relocation.
+ */
 int board_fdt_blob_setup(void **fdtp)
 {
-	/* QEMU loads a generated DTB for us at the start of RAM. */
-	*fdtp = (void *)CFG_SYS_SDRAM_BASE;
+	void *qemu_fdt = (void *)CFG_SYS_SDRAM_BASE;
+	int ret;
+
+	if (fdt_check_header(qemu_fdt) != 0) {
+		log_err("Invalid QEMU FDT at %p\n", qemu_fdt);
+		return -EINVAL;
+	}
+
+	if (fdt_check_header(*fdtp) != 0) {
+		/* this was a perfectly normal condition before
+		 * (CONFIG_OF_OMIT_DTB was set for qemu). So to avoid
+		 * breaking existing configs don't error out. This
+		 * might mean that we don't have keys in case
+		 * FIT_SIGNATURE is on. We can't know though as
+		 * existing setups might have injected them into
+		 * QEMU's FDT already.
+		 */
+		goto out;
+	}
+
+	log_debug("Found built-in FDT at %p. Merging into %p...\n", *fdtp, qemu_fdt);
+
+	ret = fdt_increase_size(qemu_fdt, 1024 + fdt_totalsize(*fdtp));
+	if (ret) {
+		log_err("Failed to grow QEMU FDT: %s\n", fdt_strerror(ret));
+		return -EINVAL;
+	}
+
+	ret = fdt_overlay_apply_node(qemu_fdt, 0, *fdtp, 0);
+	if (ret) {
+		log_err("Failed to apply FDT overlay: %s\n", fdt_strerror(ret));
+		return -EINVAL;
+	}
+
+out:
+	*fdtp = qemu_fdt;
 
 	return 0;
 }
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 5bdbd6fb59a..0fd7016c045 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -38,6 +38,7 @@ CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TPM=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_SPAWN=y
+# CONFIG_OF_OMIT_DTB is not set
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_AHCI=y
 CONFIG_SCSI_AHCI=y
-- 
2.43.0

