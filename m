Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE81FE95A8E
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 21:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C4E086C15;
	Sun,  8 Oct 2023 22:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i/gD5KVX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DB9B86D59; Sun,  8 Oct 2023 22:59:55 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA72A8655F
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 22:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-692af7b641cso581900b3a.1
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 13:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696798791; x=1697403591; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ra30ZTpn0QvSkXr55CRdvxjM8c2XlM3NEAqZP/F8mhs=;
 b=i/gD5KVXUpkFXUeGq0StdOePwrtuahqEb/s3sVrmGhd+bLWQI0luX6z6sQmvr7mwDL
 E1VZnc1NY2FsUzKd17avpRIASW3cv08SbBQZKTPWB0LtAxLloy6Lh4Vsn38IkR9Y2Sc/
 Sl4QZd/zW3QXJI0Y7PDlZqotgA46ZbMua40K2l+sOYYvR+bj3OUbftsaNOftKINcbga6
 /l+mv02tAjjZ+WA8ccpp3Wt9P1HmklvD2kQkzogtK7A8Ikk9AfVBh8ie+sJeGVrEkaIL
 zNSnT8jBU+zGr1/s5wgoHwFiEg45XMe7DfNvuX2PygukGnBJzv+bHDYznycusOy3Snh7
 JcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696798791; x=1697403591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ra30ZTpn0QvSkXr55CRdvxjM8c2XlM3NEAqZP/F8mhs=;
 b=iUyE76qzRlTTFAh9jGDSm32u5kGytdQl7Hz0vt3i4Hndn3JgTAKjjdRYHpZJsgnbWW
 b/2YFFPw7YaLi5TRA88gDyI4ZlIVTf/RTwznVJ7Igs2hF3AbTJcOHcxavdGzqvyl40zp
 NAd7lulPnIkunumgfj7BrJXlEx4hg03D0c3GldS3dL32ENFZBOdpgD8zZfvgkB9BLwnQ
 +MYijn/ILkQID7cz4ajzG4k6/iT00CdbMGccq4kj3ExayXtsNZVGfCmtq3ICxRjo6i7B
 /T7hyuyQgpDJfSmjAkKXUXNtGlr2ttVUuonu9W0O598LqVCU/hrYGId9E+QC6lK41V39
 ouIQ==
X-Gm-Message-State: AOJu0YyLMgUAHmq18kDTu7le/f88Awa77FMg3OFPbLFwL/mFwUDLSrZJ
 v0xOah890zm3wZMBBq3LKSpgLYZhjJo=
X-Google-Smtp-Source: AGHT+IEiIvHW6vrYleBGMC4fVRvVqjiCyeaT6nD5XK4Ke0XuvqRdGP06oHFDKlGaJCjdyoY6CDbe9g==
X-Received: by 2002:a05:6a20:1584:b0:15d:f804:6907 with SMTP id
 h4-20020a056a20158400b0015df8046907mr17110958pzj.0.1696798791212; 
 Sun, 08 Oct 2023 13:59:51 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3eae:c867:7cc4:36a5])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a62bd0c000000b0068e49cb1692sm4919550pff.1.2023.10.08.13.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 13:59:50 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: marex@denx.de
Cc: sbabic@denx.de,
	u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 3/3] mx28evk: Add USB Mass Storage support
Date: Sun,  8 Oct 2023 17:59:39 -0300
Message-Id: <20231008205939.3332647-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231008205939.3332647-1-festevam@gmail.com>
References: <20231008205939.3332647-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Select the USB options to allow running "ums 0 mmc 0".

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Remove unrelated config options. (Marek)

 configs/mx28evk_defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/configs/mx28evk_defconfig b/configs/mx28evk_defconfig
index df0cceaea719..0b7c4b252ff0 100644
--- a/configs/mx28evk_defconfig
+++ b/configs/mx28evk_defconfig
@@ -32,6 +32,8 @@ CONFIG_CMD_DM=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND_TRIMFFS=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_DATE=y
 CONFIG_CMD_EXT4=y
@@ -65,3 +67,13 @@ CONFIG_RTC_MXS=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_USB=y
+CONFIG_SPL_USB_HOST=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_MAX_CONTROLLER_COUNT=2
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_CI_UDC=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_SPL_USB_SDP_SUPPORT=y
-- 
2.34.1

