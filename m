Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661DDC54747
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD39B88B6C;
	Wed, 28 Aug 2024 03:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D2TvrVjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA1B188AB1; Wed, 28 Aug 2024 03:46:01 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D62AF88B6C
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-81fd9251d99so229921939f.0
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809558; x=1725414358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85MVtXj5zp860aygEGPDMjxemuQ2AMvejoqdn7hgOBs=;
 b=D2TvrVjdFgdX/3bCBhgOYdOZX8iUXkvv9bbuAkn9wOJ2Pa3Fak3R71WLkM9Tfybz31
 qbQNMs1JdfL+hrYrMSCg+BKpr+2JGWPVkRS60ucU4ZDqkxEHDGKnexnYOh2AgbjWLJmO
 DsPv6L3FebPjULWK9fSqOmv67cgp9OXNhr3w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809558; x=1725414358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=85MVtXj5zp860aygEGPDMjxemuQ2AMvejoqdn7hgOBs=;
 b=hx9fCx1g+l2IH2stgGuQbamURvuiw9NDMGUdCSymrAjxoolp/URs9IK6+LQjeJ9UJX
 15zCLsdlAjrK4Qm2tKxMhBYweF//dqD+nkrAX7DQC8LnseDOcvzdzhP886VVfbkzX6aZ
 ZU+rBB0fIM1bVQB6QKdmfcGvB6/DF4jX+XCuhRUgXC3CWnxpvmnMPcXSEDnp/JwC0rFp
 8tMlcQ1k1NMPkESY1O26rKOkeQ6GR3veMF6t2NkMWm+l6OCoqcb8GyQhF+EJ776DxDbj
 zEwW7qPB+C+2XSu455t3c5VOlyKcVTgTOLHFS+Mi43Pgp5bBw1u2o5K+UvbrQyrJvsxR
 QNIg==
X-Gm-Message-State: AOJu0YzQlknD4bIKEmaL4JBObJCvbRZvHAFYLEUDM9SCfIWKt0N7OEuM
 beki53I0CsAwrxgZt/Ol/g14heZdpElS6OU+bb21YKDEdxt/OREkq4IKd64jvOHDpEgyGabgOuY
 =
X-Google-Smtp-Source: AGHT+IFW40XZbcuKsqyIjaR4Bo/EucDYa2he9SPqYd/+VkRMoNXhM3F2YdFGFfTHh3hZLcJ4/trsWA==
X-Received: by 2002:a05:6602:6d12:b0:827:87c4:363a with SMTP id
 ca18e2360f4ac-82787c437e9mr1429860639f.7.1724809558488; 
 Tue, 27 Aug 2024 18:45:58 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5ca7csm2898342173.63.2024.08.27.18.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:45:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/18] mmc: Add more debugging for SPL
Date: Tue, 27 Aug 2024 19:45:32 -0600
Message-Id: <20240828014538.3322013-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014538.3322013-1-sjg@chromium.org>
References: <20240828014538.3322013-1-sjg@chromium.org>
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

 common/spl/spl_mmc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 3fd81608e9f..c0e8d407e5d 100644
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
@@ -91,6 +98,10 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
 		       mmc_dev, ret);
 		return ret;
 	}
+#if CONFIG_IS_ENABLED(DM_MMC)
+	log_debug("mmc %d: %s\n", mmc_dev,
+		  CONFIG_IS_ENABLED(DM_MMC) ? (*mmcp)->dev->name : "?");
+#endif
 
 	return 0;
 }
@@ -342,6 +353,8 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 
 	/* Perform peripheral init only once for an mmc device */
 	mmc_dev = spl_mmc_get_device_index(bootdev->boot_device);
+	log_debug("boot_device=%d, mmc_dev=%d\n", bootdev->boot_device,
+		  mmc_dev);
 	if (!mmc || spl_mmc_get_mmc_devnum(mmc) != mmc_dev) {
 		ret = spl_mmc_find_device(&mmc, mmc_dev);
 		if (ret)
-- 
2.34.1

