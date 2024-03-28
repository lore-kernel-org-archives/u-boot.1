Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007C7C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 10:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FA7788159;
	Thu, 28 Mar 2024 11:30:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AHnrp1vu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9D9688141; Thu, 28 Mar 2024 11:30:30 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D506B88127
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 11:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a46cca2a979so44917466b.3
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 03:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711621827; x=1712226627; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIjA+IHP02KgDl1pzDSRClzJQWzEm1L1Mtnzae8MkkE=;
 b=AHnrp1vuAkJPpyRSZRhqlpXC3+FJSK/Nb4YpTJ+ISPqvCPT09O8wLp4rHrwpx5fl6t
 0i+flUqQT/t0rC5CH/07UyWlg+DUURrkbDIEwk1m40wTZc6rnGM7zLIBISK+egkGbFdS
 znt4uq9c1PIKJjYDYo2LK3i0FlqUF+csh2tyZVEKAnUbfzar+Sphy9FheYpP1plmzdOd
 IsoqT6asYW+t1jRYL8ZmfjQtxDUbhymHZpYIn5K8XaKQ2iAzKt4fQoqtXIpNV/s15Bpx
 lj8ylfhpbOp9kNotvMgEuV0d8u8grhUAl7iA/AY7tjLKs7ds76n/rZ2N7PsDu6+x8MZA
 ihIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711621827; x=1712226627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wIjA+IHP02KgDl1pzDSRClzJQWzEm1L1Mtnzae8MkkE=;
 b=YMenGQpim+vNQCJw0eRl5G3VXxTRW4yde8iIzWfy1ZLiebNSItEIaHWlrfYLX4iiYL
 5g/I8wqAtBy5OaRGEfZa6EkxSZPDW2hW9siGn33gK57mcdfe2IILFfoKChwPzHXqR15N
 1isjs/HBbVD9ox+CtQmy2O05icbgptG22yqv0CKoNhTtHt53ubQmeNm6PknfApWoNu8I
 FWbQoYsDYa/K37TbYaNP4UIdm3BRlLtG+hmv4KM5TzdSnNGHGMvExPHcuKs4JhtNh4w9
 aJT0Gk7JPk1RhDEQ7OL9gmXVQRzEA4wz0Dn+nOUuZjiU8GBf8Wr/Sfob4Ai1QBABRGKQ
 7yKQ==
X-Gm-Message-State: AOJu0YzTmjLLe7o1hLsNTk/lybVMASFWl//RLDhE9zYLbZGXwbewTFe6
 Jii9Stj6dWZ5o8BJuacKsnC++/3cX92LaSl0wZ4sx+So7v8/Hy8srqm8mt/2AZw=
X-Google-Smtp-Source: AGHT+IGIOPbGtFs15oPIp94MMP5Di/KSmEOCoJsexGJ4MBlM1l6izZoGbAjtD+3VFtc+cd0qMGl5Tg==
X-Received: by 2002:a05:6402:34d0:b0:56c:1735:57a2 with SMTP id
 w16-20020a05640234d000b0056c173557a2mr1515524edc.31.1711621827256; 
 Thu, 28 Mar 2024 03:30:27 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:baf6:ec90:82d5:a261])
 by smtp.gmail.com with ESMTPSA id
 s2-20020aa7cb02000000b0056c0d96e099sm653099edt.89.2024.03.28.03.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 03:30:26 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Gaurav Jain <gaurav.jain@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Breno Matheus Lima <breno.lima@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Subject: [PATCH v2 2/3] configs: colibri-imx7: set non-secure boot mode as
 default
Date: Thu, 28 Mar 2024 11:30:13 +0100
Message-Id: <20240328101724.127371-3-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328101724.127371-1-ghidoliemanuele@gmail.com>
References: <20240328101724.127371-1-ghidoliemanuele@gmail.com>
 <20240328101724.127371-2-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Linux kernel is supposed to run in non-secure world,
fix the defconfig accordingly.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 configs/colibri_imx7_emmc_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/colibri_imx7_emmc_defconfig b/configs/colibri_imx7_emmc_defconfig
index 9d4423cd0d6a..8dd9fe6e6a38 100644
--- a/configs/colibri_imx7_emmc_defconfig
+++ b/configs/colibri_imx7_emmc_defconfig
@@ -8,7 +8,6 @@ CONFIG_DEFAULT_DEVICE_TREE="imx7d-colibri-emmc-eval-v3"
 CONFIG_TARGET_COLIBRI_IMX7=y
 CONFIG_TARGET_COLIBRI_IMX7_EMMC=y
 CONFIG_OF_LIBFDT_OVERLAY=y
-CONFIG_ARMV7_BOOT_SEC_DEFAULT=y
 CONFIG_IMX_RDC=y
 CONFIG_IMX_BOOTAUX=y
 CONFIG_IMX_HAB=y
-- 
2.34.1

