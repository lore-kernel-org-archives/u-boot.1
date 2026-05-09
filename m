Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8802ACD37B2
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 01:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D18D884B1E;
	Sun, 10 May 2026 03:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1778377334;
	bh=Bfg8iaGghhB0W1QrIJqJAI5lKojZS0AkPtdEQV1pSPY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WhhY+EZGtmgeWyL1fld1q1Uvnuyp3fPYetu4Gsrk5ob6r1SIqMNs5J2LkD53kJCtk
	 Sglyh0nyZy+oGq2zaq0VvURmFgw3CcgN2PBtmevZPx/PbALJ4b/zBo/YLxISciPJ9J
	 vmBqX/IVJl5VBRxTm3E8Rb6q3/9CDR9fIMbvJ+wTZDlAp1DHAAfV94blNwETWGBnhM
	 +uBIJGSZ8jbLRTwmHYOn0omCCpfnQjoYUQvEpRWavlFahamdBajBjf/1ya5WuEaAah
	 cn4psa8/Wivw6Xc8ONFDzzjtk1hW/RwNms0wSbpf+lz8ceQl9JfLjcbLmp6zU16IJc
	 yyiKH3/G3r3TQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BEAF846EB; Sat,  9 May 2026 23:06:47 +0200 (CEST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B526B846DF
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 23:06:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liel.harel@gmail.com
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-488ba840146so26974205e9.1
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 14:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778360805; x=1778965605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bfg8iaGghhB0W1QrIJqJAI5lKojZS0AkPtdEQV1pSPY=;
 b=RezjFe2bVm0VOaUfGgOvvK4NTULiAYUbMSvo79nYbAtKJuTjKknf8ezYBulenfcym9
 LZzSn0mi4vIerY+dDX/IcHhnHYVueuvAyeEMHSitStcjrN6t7vStJduUlcwyg+UuJpa8
 AW45kxvt9hGkSafYTOJDvIkYmaEEbg02i/GL1ZSb8Hbjz4J/qnCG7CjzsLb9ujuP3D1t
 nEQygK9iKc27UxM/aF866ra+n+2vUeC1D9yhfxwX99xVFkKqWy5Gm9okmRmSCA3N/pfZ
 cxrN/C8/VjSRALWc9vrwDVd4NPBKEPyeJaA7iPduxQCVnHCjwGsw01YxzdkpMbQqYGSc
 moLw==
X-Gm-Message-State: AOJu0Yz6I5mbEHk/Y/fzSw7kRSv0b5vREVgdWEPyBQvlvu3KKTG1axUm
 663aVfqxkgYtA+jaMg2NAi/cixzVTU+ni82377ws4JuPARYwusqDFd3/EZdvVi7GIZY=
X-Gm-Gg: Acq92OG9G22Wco7FN9nlJFJay0JZMBInCFzn7QG6BEszIsXWMhTHFWqOKl6N1/Gy+FF
 MsPVQngw1bVFOBTDO8cb77G0Ak2r//u6VPnfrWxfATN20pLfQeg7RI29Khn32LuWQ9QHBsMwM9u
 9ujkhmt9YppNRaleBjbwlA0iJmCJYWSPa3yvBKq7w+K8Fq7Bcj0T1E7RYM3QZzpZMcx6mXOUFgi
 UPmOLdUSrB+M8vVL3GA6/J7rfjwPIx3BN68oXLChQcUqpRAkzCgR1+0YUbbgQaaDdBK+3se4+bI
 SXc0E8BcfPW4kLxIW/DGT9AL05+i5jcdAc3IKsHDtEnuoTE9G1Wh9QKUMkgcPb3cvZXLxpVRBnF
 abw3hTiuM+MwiDcHLcy/ja6cxWF+/EZT+BSwosb/vE+h71oY9Myr8HFmsX4SV8Te8OaWMyLJHBE
 atpWj7FCGVz1C+vKrsafBRGep+I6Rvh8SV
X-Received: by 2002:a5d:5f47:0:b0:449:c1e8:7655 with SMTP id
 ffacd0b85a97d-4515cf125bbmr28880505f8f.27.1778360804385; 
 Sat, 09 May 2026 14:06:44 -0700 (PDT)
Received: from Liel.localdomain ([77.137.77.46])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491f8d4c3sm13600391f8f.34.2026.05.09.14.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 14:06:43 -0700 (PDT)
From: Liel@denx.de, Harel@denx.de, liel.harel@gmail.com
To: u-boot@lists.denx.de
Cc: Liel Harel <liel.harel@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] mmc: bcm2835_sdhci: Parse generic MMC device tree properties
Date: Sun, 10 May 2026 00:06:07 +0300
Message-ID: <20260509210607.51303-1-liel.harel@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 10 May 2026 03:42:13 +0200
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

From: Liel Harel <liel.harel@gmail.com>

The bcm2835 SDHCI driver sets up the MMC host configuration via
sdhci_setup_cfg(), but does not parse generic MMC device tree
properties.

As a result, properties such as bus-width are ignored. On Raspberry Pi
Compute Module 4, the eMMC node describes an 8-bit bus, but U-Boot
initialized the device as 4-bit.

Call mmc_of_parse() before sdhci_setup_cfg() so that generic MMC
properties are folded into the host configuration before the MMC core
selects the bus width.

Before this change, mmc info reported:

    Bus Speed: 52000000
    Bus Width: 4-bit

After this change, mmc info reports:

    Bus Speed: 52000000
    Bus Width: 8-bit

Tested on Raspberry Pi Compute Module 4 with onboard eMMC.

Signed-off-by: Liel Harel <liel.harel@gmail.com>
---
 drivers/mmc/bcm2835_sdhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/bcm2835_sdhci.c b/drivers/mmc/bcm2835_sdhci.c
index 655d9902dfa..efa4d14f5da 100644
--- a/drivers/mmc/bcm2835_sdhci.c
+++ b/drivers/mmc/bcm2835_sdhci.c
@@ -219,6 +219,10 @@ static int bcm2835_sdhci_probe(struct udevice *dev)
 	host->mmc = &plat->mmc;
 	host->mmc->dev = dev;
 
+	ret = mmc_of_parse(dev, &plat->cfg);
+	if (ret)
+		return ret;
+
 	ret = sdhci_setup_cfg(&plat->cfg, host, emmc_freq, MIN_FREQ);
 	if (ret) {
 		debug("%s: Failed to setup SDHCI (err=%d)\n", __func__, ret);
-- 
2.43.0

