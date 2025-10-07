Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672E7CCD184
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 08:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 307A2838E3;
	Tue,  7 Oct 2025 10:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="JU11ePjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B185838D5; Tue,  7 Oct 2025 10:18:21 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B17FD838C2
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 10:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3DCE7C9A4C; Tue,  7 Oct 2025 10:18:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1759825099; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=2YbeKWpB10w5smkJgPPjEsb6AE6wqZ8R8WvkLjR1oAw=;
 b=JU11ePjI3Fwaj8K5mG0E3MpVE7/WyNhEuneOSniEO8uD6Ul8C1KAkmK2EvOAuNy4Z9Dwef
 pMiSad6VmFzF0qOErfbpEFaSFh78M2O9NSB+jLgi1oMEHxTRy2Ij8+7sDGTMOkre68Yn8r
 S6uStW9wuomBgWFTCr8omUnep3mmCotCu9A9bTGZ7Q4Dp0uMDNA+DO6mkHiU+iigM2HXDR
 fmjRnQfgjehIifp9FIyO2p1ZiTwpjujyLCseiQqWvNYX55wMOa50W326h8H2OZt9YxFMNI
 a5qUBz+PtA3cuCkboZ+21Y2blRghHz4fvpStGvvXAp32mlRQGcLQaOohMRU1Hw==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Eberhard Stoll <eberhard.stoll@kontron.de>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH 06/13] imx: kontron-sl-mx8mm: Use eMMC boot part for
 environment if booting from eMMC
Date: Tue,  7 Oct 2025 10:16:03 +0200
Message-ID: <20251007081640.61772-7-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007081640.61772-1-frieder@fris.de>
References: <20251007081640.61772-1-frieder@fris.de>
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Depending on the MMC boot device, select the proper location for the
environment.

* SD card and eMMC main partition: use offsets from CONFIG_ENV_OFFSET
  and CONFIG_ENV_OFFSET_REDUND.
* eMMC boot partition: use offset -2*ENV_SIZE and -ENV_SIZE from the
  end of the partition.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 board/kontron/sl-mx8mm/sl-mx8mm.c | 45 ++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/board/kontron/sl-mx8mm/sl-mx8mm.c b/board/kontron/sl-mx8mm/sl-mx8mm.c
index 2e387038395..405ac0fb03f 100644
--- a/board/kontron/sl-mx8mm/sl-mx8mm.c
+++ b/board/kontron/sl-mx8mm/sl-mx8mm.c
@@ -142,7 +142,8 @@ enum env_location env_get_location(enum env_operation op, int prio)
 	 * the MMC if we are running from SD card or eMMC.
 	 */
 	if (CONFIG_IS_ENABLED(ENV_IS_IN_MMC) &&
-	    (boot_dev == SD1_BOOT || boot_dev == SD2_BOOT))
+	    (boot_dev == SD1_BOOT || boot_dev == SD2_BOOT ||
+	     boot_dev == MMC1_BOOT || boot_dev == MMC2_BOOT))
 		return ENVL_MMC;
 
 	if (CONFIG_IS_ENABLED(ENV_IS_IN_SPI_FLASH))
@@ -156,4 +157,46 @@ int board_mmc_get_env_dev(int devno)
 {
 	return devno;
 }
+
+uint mmc_get_env_part(struct mmc *mmc)
+{
+	if (IS_SD(mmc))
+		return EMMC_HWPART_DEFAULT;
+
+	switch (EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config)) {
+	case EMMC_BOOT_PART_BOOT1:
+		return EMMC_HWPART_BOOT1;
+	case EMMC_BOOT_PART_BOOT2:
+		return EMMC_HWPART_BOOT2;
+	default:
+		return EMMC_HWPART_DEFAULT;
+	}
+}
+
+int mmc_get_env_addr(struct mmc *mmc, int copy, u32 *env_addr)
+{
+	/* use normal offset for SD card */
+	if (IS_SD(mmc)) {
+		*env_addr = CONFIG_ENV_OFFSET;
+		if (copy)
+			*env_addr = CONFIG_ENV_OFFSET_REDUND;
+
+		return 0;
+	}
+
+	switch (EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config)) {
+	case EMMC_BOOT_PART_BOOT1:
+	case EMMC_BOOT_PART_BOOT2:
+		*env_addr = mmc->capacity - CONFIG_ENV_SIZE - CONFIG_ENV_SIZE;
+		if (copy)
+			*env_addr = mmc->capacity - CONFIG_ENV_SIZE;
+	break;
+	default:
+		*env_addr = CONFIG_ENV_OFFSET;
+		if (copy)
+			*env_addr = CONFIG_ENV_OFFSET_REDUND;
+	}
+
+	return 0;
+}
 #endif
-- 
2.51.0

