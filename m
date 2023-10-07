Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC62E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC19786DC3;
	Sat,  7 Oct 2023 23:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X5SEQF3X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A26D86E16; Sat,  7 Oct 2023 23:57:04 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CE3786DCB
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 23:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c61c511cbeso6500305ad.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 14:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696715819; x=1697320619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FhJHKIYgSC/tqtBXfFj0jdz1MKsvsi+SBha6NTiEWC4=;
 b=X5SEQF3XcSRqkkefK3xtgoUZrtYLXy/w8ZFLn1znCchLgFR1fQInqbsWgMb9pmqd4T
 MjcpFNVMp9OChBW3uUD9QB8OJRg/bHsMUjVmBWw3qhSpgWRT3qK1l1TH+T4Il9MYJaUr
 Dvqx87IEIlXCm05X1Nk5H8QWtLYuxcrsAGJP8a0sUErRd8jPBiux+p4dtumePvaRv3Wi
 Ov7/CoGzhnewGzEFN5fblOppGYdCbJtJtPyxmix6s1wIfXcjAcLR6VdGt0HsHiQF0ZJf
 4Brju7t+0e9UyQXhlEy0/sjO4sJLNidA16PD1xZQeoyYy+ydWKjmZQogUKzy3e2JDGaY
 hCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696715819; x=1697320619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FhJHKIYgSC/tqtBXfFj0jdz1MKsvsi+SBha6NTiEWC4=;
 b=Rq8LWChtGz6JsCC7ZqkGpZVRn3qOnDLuMJoQ5NdL9xwJO8X75BAi0peb7AlYKVXUEq
 B8+pEnJHXjp0LB5tCsLmAkQ5hQYIy0vbRTXsYhJ1uX29q1bTtBDlcwIXn80RcytXSkKs
 hghNrzT8NNPcmfDbc5b0/cgrbAuHuTePig9ZsYOVaqEvDSA312LEM+6DXr+K1eFtoIMk
 uiRtdCZLPOS4b5JvTYIIkOxOgtggx9FVm21m5ZUy27DCPbx8GIoSutEAH4fRFRfttRND
 i8GRWEq0FbKti9BMxHN3S1gsSrgnXXVBplTrQ8FdznoCz0bT864HlaovniWI1PLN0lpG
 04XA==
X-Gm-Message-State: AOJu0Yy+6mfB8myn1huQfQhUq8CPniDOxpmG1Yy+WHQjbqCntY1I2ge0
 1fxjIaKx4jqyTUVCJp7vvptjKzZkX1E=
X-Google-Smtp-Source: AGHT+IGys6WMOeyMMpceiJteKM/QLVkcdKtZ/L3NsRMsU3hd4ED42OnnaC03KiEcwbFK8J4eAnqNNw==
X-Received: by 2002:a17:90a:3da1:b0:274:60c7:e15a with SMTP id
 i30-20020a17090a3da100b0027460c7e15amr10251475pjc.4.1696715818883; 
 Sat, 07 Oct 2023 14:56:58 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:d82a:6c03:129b:26f2])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a170902ecc400b001c74df14e6esm6346487plh.51.2023.10.07.14.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 14:56:58 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: marex@denx.de
Cc: sbabic@denx.de,
	u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 3/3] mx28evk: Add USB Mass Storage support
Date: Sat,  7 Oct 2023 18:56:48 -0300
Message-Id: <20231007215648.3156877-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231007215648.3156877-1-festevam@gmail.com>
References: <20231007215648.3156877-1-festevam@gmail.com>
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
 configs/mx28evk_defconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/configs/mx28evk_defconfig b/configs/mx28evk_defconfig
index df0cceaea719..15cc99684c05 100644
--- a/configs/mx28evk_defconfig
+++ b/configs/mx28evk_defconfig
@@ -32,6 +32,9 @@ CONFIG_CMD_DM=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND_TRIMFFS=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_SDP=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_DATE=y
 CONFIG_CMD_EXT4=y
@@ -65,3 +68,14 @@ CONFIG_RTC_MXS=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_USB=y
+CONFIG_SPL_USB_HOST=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_MAX_CONTROLLER_COUNT=2
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_CI_UDC=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_SPL_USB_SDP_SUPPORT=y
-- 
2.34.1

