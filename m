Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E4CCF58E3
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B9C4893F7;
	Fri, 20 Sep 2024 09:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nCDiiXtO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C007893BF; Fri, 20 Sep 2024 09:25:22 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 366B9893EA
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cb8dac900so15379885e9.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817116; x=1727421916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JbTIGpC+evrLANuDqrcssj6YExlsFZCF39qeWy98Sdc=;
 b=nCDiiXtOcALZPoUK2C7fUSMyYIgpNaGdjVBpaov8oOBayZazrOJIzr9+6SOt2xvsAu
 eHJkulgZMDlp4ryxR1CFFe44+Z/9YkW26uxSgMyUym2U4mn3V2HGnSFtHf5y0hMPOmzr
 mAFIensb0Z7fram6S7qrsKQ53cTxv+tJ0wA04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817116; x=1727421916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JbTIGpC+evrLANuDqrcssj6YExlsFZCF39qeWy98Sdc=;
 b=J8bRalDpoAyXpDCfkfxp3jixmf1EAXvT1Ip4jzJI9/mwRx0XTbAYY5HCpSt8OpAeug
 /71fMKgPOktEULBGrvGguihzzx8pO5M2ruwTSwkKEDD/Ru+36YHNe1d2LLNoFMXcpaSK
 VK26c1Qt1qw3IIEW5mXXrYDSgNsVNQtEsU4XpcFsIFH7M47+tSYvCDI6e5vmoDRjelaW
 OU+xOLa6zmcXFLoWiND5G6msrljlWmJVeBeSo8wueK7LlG5T1n8HPsSxH1BL0INeZceE
 uLbGl7nV3NIwgJc+51atrd5xS+TeOqdEzHkSB4POLL9ZmjO961Xy9x4LFIA0FmKX9zYT
 GSXQ==
X-Gm-Message-State: AOJu0Yzgg6Efr9m7ojux2Q6LKeaaWHR8QCkWRoJTqRv6SELRPEQ6CwYj
 Ue428iBIafVbQ8v0unp3YerG3BdHpgCYE3G+5fcnSwHeOgRBbcAM6unK3Pk3NDorSBVnwUQqZxJ
 GMkb4
X-Google-Smtp-Source: AGHT+IFm8vKtdVErPJUGnKLCTIECv7GooNp2AUHl0j/82XVgTGECjB8bUEd+kPLnSRruPccT6dIDeA==
X-Received: by 2002:a05:600c:8718:b0:42c:b4f2:7c30 with SMTP id
 5b1f17b1804b1-42e7c1a2e78mr9794785e9.23.1726817116483; 
 Fri, 20 Sep 2024 00:25:16 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7540e32fsm41504535e9.9.2024.09.20.00.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 00:25:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 13/18] mmc: Add more debugging for SPL
Date: Fri, 20 Sep 2024 09:24:37 +0200
Message-ID: <20240920072444.134997-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920072444.134997-1-sjg@chromium.org>
References: <20240920072444.134997-1-sjg@chromium.org>
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

When MMC booting fails it is sometimes hard to figure out what went
wrong as there is no error code. It isn't even clear which MMC device
was chosen, since SPL can have its own numbering.

Add some debugging to help with this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Drop the unnecessary interior check for CONFIG_IS_ENABLED(DM_MMC)

 common/spl/spl_mmc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 1337596eca0..1f696593216 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -50,6 +50,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
 	ret = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
 	if (ret) {
 		puts("mmc_load_image_raw_sector: mmc block read error\n");
+		log_debug("(error=%d)\n", ret);
 		return ret;
 	}
 
@@ -76,6 +77,12 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
 	int ret;
 
 #if CONFIG_IS_ENABLED(DM_MMC)
+	struct udevice *dev;
+	struct uclass *uc;
+
+	log_debug("Selecting MMC dev %d; seqs:\n", mmc_dev);
+	uclass_id_foreach_dev(UCLASS_MMC, dev, uc)
+		log_debug("%d: %s\n", dev_seq(dev), dev->name);
 	ret = mmc_init_device(mmc_dev);
 #else
 	ret = mmc_initialize(NULL);
@@ -91,6 +98,9 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
 		       mmc_dev, ret);
 		return ret;
 	}
+#if CONFIG_IS_ENABLED(DM_MMC)
+	log_debug("mmc %d: %s\n", mmc_dev, (*mmcp)->dev->name);
+#endif
 
 	return 0;
 }
@@ -342,6 +352,8 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 
 	/* Perform peripheral init only once for an mmc device */
 	mmc_dev = spl_mmc_get_device_index(bootdev->boot_device);
+	log_debug("boot_device=%d, mmc_dev=%d\n", bootdev->boot_device,
+		  mmc_dev);
 	if (!mmc || spl_mmc_get_mmc_devnum(mmc) != mmc_dev) {
 		ret = spl_mmc_find_device(&mmc, mmc_dev);
 		if (ret)
-- 
2.43.0

