Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A213C48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 11:44:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC25587D7E;
	Tue, 13 Feb 2024 12:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="brYsoASR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88EBD87D64; Tue, 13 Feb 2024 12:44:11 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE09987D72
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 12:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d7517fe9d4so2327585ad.0
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 03:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707824639; x=1708429439; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/FZ3Ft6sY/vOZSfvhp1W8eOaeAbdwaCxGFfQJZuFj98=;
 b=brYsoASRiEDfJnCwnoFu99BLo5WUe2EfEcignEglrmDEY0Tq9dXWINahoSGHy4H2l8
 hSGcPxXlwZf6J1RYQu0RJ7uNnQjCGoftHT1TADEdp2epjnMONBzC1zmZ7fzwPR7PCWmC
 Z+ai0l/jNHLrqEmTLuVAxr4+NpP+keQkh9ft2c1VXj5O/oft+uEO/c0qIxVh3Y8hQ5TW
 KmScnsCQdAm1bfbOneOiXOszjmoxBa08Pglh1CSwni7FsU68K+MGqDjIVMy1mG/2BDUs
 pX48x96s4QJYEFjqqiem+xHi8PJZySL6k3tqB4xzktP/JTN6RsDGqNQGFt+UYnDGhTdl
 G0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707824639; x=1708429439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/FZ3Ft6sY/vOZSfvhp1W8eOaeAbdwaCxGFfQJZuFj98=;
 b=GUV68vTDgDxBohDPD6uGg19PN3t7efwXrQMP53MKriRKioB7N3cskcdb5ghoBqdoOi
 CFGJOGIyBCDSfAjY4U3ud9y+dXL6eVLvDBJDy7vtWSwjN3PwmkU9rLRqbUvyUiXAM1kb
 8CWo4QXNj28hxzGNeEVMDyJyNMmqlqekzRCWttg1sVo0nicbeJjrdWt+LU0MF7G/bS4L
 4+b7KZRQXJ6ix2+MVaYLPJnZ6kBokcWz5Vzlga+mzCv67Xmoyf1pyHaQLv9GpJtGJXEd
 Qj3dfgLtJQXDQ85PV8GlGz7UfypV82FIblRIyN2yg6YmBg/BdkVNledNiDlx0L0S2w7J
 ehkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf2+DVPN90m0d2PrqpJOAL8LWi7AMk96APNdqxVEx96S8T8huBig1OWoll9/IY0YUv3K2f1WDCCq7oTGPQrUJTl7I6yw==
X-Gm-Message-State: AOJu0Ywj8Ui89FlxLO37LWC8k+EFaz5SECCoW3b07f/idA6qkoIMQiEz
 dx4Fb7OazndGO1k/RvBQaUbJUaJLRC236C8B3wqDbTeBwcLc+V+p
X-Google-Smtp-Source: AGHT+IEAUpZDbI/+glymUi5xqQFEXqUA4WHV0oLuMac86kysKDKup6iXzdPSVspHduKmRHuSmo++lQ==
X-Received: by 2002:a17:903:2303:b0:1d9:9c61:55f2 with SMTP id
 d3-20020a170903230300b001d99c6155f2mr10754292plh.2.1707824639257; 
 Tue, 13 Feb 2024 03:43:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXhKV1jN1B3Q4sDUe9sXz6284/w1A846uqpaBw8Lu8KPJJCgHTFeeUTv1fQlNNyn+miouio/1p9UPZj+Ud23MIjMNx1aeyze4esgrb8eWbNZSWYlSNnW7wv/Z7pv6cAbe7QjJG2gWt/ybLI+brRT6jywhg=
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:c0bb:2b3:6958:833])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a170902f28500b001d8f0e4bc32sm350795plc.144.2024.02.13.03.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 03:43:58 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: ian.ray@ge.com, martyn.welch@collabora.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH 5/5] msc_sm2s_imx8mp: Fix CONFIG_DEFAULT_FDT_FILE
Date: Tue, 13 Feb 2024 08:43:42 -0300
Message-Id: <20240213114342.2728075-5-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213114342.2728075-1-festevam@gmail.com>
References: <20240213114342.2728075-1-festevam@gmail.com>
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

There is no imx8mp-msc-sm2s.dtb file in upstream Linux.

Change it to imx8mp-msc-sm2s-ep1.dtb.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 configs/msc_sm2s_imx8mp_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/msc_sm2s_imx8mp_defconfig b/configs/msc_sm2s_imx8mp_defconfig
index 3a49b7d55c..5688c7a64d 100644
--- a/configs/msc_sm2s_imx8mp_defconfig
+++ b/configs/msc_sm2s_imx8mp_defconfig
@@ -28,7 +28,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_DEFAULT_FDT_FILE="imx8mp-msc-sm2s.dtb"
+CONFIG_DEFAULT_FDT_FILE="imx8mp-msc-sm2s-ep1.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 CONFIG_SPL_MAX_SIZE=0x26000
-- 
2.34.1

