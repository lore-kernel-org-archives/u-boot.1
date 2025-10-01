Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D19CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 20:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7C2283700;
	Wed,  1 Oct 2025 22:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SKJoqmDs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A3A783775; Wed,  1 Oct 2025 22:31:04 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AC58836D3
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 22:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3544c64380eso370762fac.3
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 13:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759350661; x=1759955461; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=LFoS+6pEzPt5XNlLPCURFvKZkebiYtFqa2Fqn+xqI10=;
 b=SKJoqmDsE34hO+vbdzkm+v0rShLdtRvKxrbZtuOx7viU4mzjoC01PjTR1HPCoO2TWw
 4n+8WCZkz5a6eRpS4bNDtzOggZ9M+GQ3QRgPK4sq3NpfG9R2waSWml9weojHWvPmmn9v
 o1ms+x4DV7I2k+wSp5jF5ilmclnG4id0eqM7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350661; x=1759955461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LFoS+6pEzPt5XNlLPCURFvKZkebiYtFqa2Fqn+xqI10=;
 b=dQXuUMwidXsijti8GlvZ2XgtWEgsWFvD9aaUsaAste9EWcRtcBU9SJL8YsyOKTxzXc
 OjG7914/uUrHd9uNuIt63ORSBUJkuvx/UawClM0bNYVwLRl/lC4cPRzhQd8yddUA0s44
 Y/Bfi0IugFm3gHnj5MEplDEoTc6sqmJIpwqbW0rYCMTaYE1SOYF+qKnXTnHPezOz5abI
 NcXNbAca6iBzrFWlue7E5e7QB8O97ABIxCQ/rP9fw9LkDeqQJuigBAlaMhMh7NhCbuRG
 lmfbZkKTkrqOh+ZwK2SsHStPg0NRKAzlzdTpeJ7cahkfHzGIaTeGycNDw+Tnc0n9rvsL
 PLtg==
X-Gm-Message-State: AOJu0YwdLtwyrY0uwgqlibI8e/wLY5mw/68RIMwXG/cWrFcFI4MJVtV2
 pxO4NG+kQ7hJPZcNE8bb6lqlfrMPYpRwjaNXTQt5D/at5x/TPGwlNFWBS35o4OxJLL5Ejz1TlDJ
 tgUVTuqY=
X-Gm-Gg: ASbGnctvzPNzzGw8DepBdw2mFDEv7TUtaHqwvko66qTdYYOBfmIyVv4pi4Hvdfw8jwk
 kiICJeIDPkwaphQY1sqR9t/mW/iYbiVa3LoxmXBosQel32G5zzugSe2iZ/al3HNVIAA+w0eHedc
 RgtlSVuBA867x6szGnWg2CN3AgfELkrRgzfFiloE8rSQcFUfUpXdeIbWEa6/8wLtS9nWVOUVKoQ
 XrdzrNXqi8163OqsTkrZXZaJOPRUZGEFtohMb8GvMtrvhempNJf3bKDhEhOFgtPEifLizlV1Azv
 SZOQd6tZ8NMJZhtFcbvpguq3N7G69gtAhEnAjjl1SCkopreRj2MNaDvPIO5425uYLbM0fImpd9R
 27rCRHSzhre8Z6eDZ4PpWm3YKVI6Ez79/geGk1QGAyt3+7bhkGMewWvW5V0Ye3arvLpENTQtRne
 raXiOFysY=
X-Google-Smtp-Source: AGHT+IH0IqO1X0yrNS3G3etauNPDLQDRyGUCxlEWd5FdW/QTB7Vss5mje7SndVa/FizNYwz4sChBRw==
X-Received: by 2002:a05:6870:71c4:b0:395:b63a:520a with SMTP id
 586e51a60fabf-39cd931c580mr2580795fac.22.1759350660914; 
 Wed, 01 Oct 2025 13:31:00 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf439d58e2sm112892a34.39.2025.10.01.13.30.59
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:31:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] boot: vbe: Make BOOTMETH_VBE_xxx a choice
Date: Wed,  1 Oct 2025 14:30:59 -0600
Message-ID: <20251001203059.2828551-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

It is not valid to enable multiple BOOTMETH_VBE_xxx methods, so make it
a choice as to which will be enabled, and make the default choice be the
current default.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index eff05948b3a1..f21a67b2d3ee 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -712,9 +712,12 @@ config SPL_BOOTMETH_VBE_REQUEST
 
 	  This is only useful if you are booting an OS direct from SPL.
 
+choice
+	prompt "Method for VBE to find the correct bootdev"
+	default BOOTMETH_VBE_SIMPLE
+
 config BOOTMETH_VBE_SIMPLE
 	bool "Bootdev support for VBE 'simple' method"
-	default y
 	imply SPL_CRC8 if SPL
 	imply VPL_CRC8 if VPL
 	help
@@ -734,6 +737,8 @@ config BOOTMETH_VBE_ABREC
 	  verification step, a recovery image is booted. This method will
 	  eventually provide rollback protection as well.
 
+endchoice
+
 if BOOTMETH_VBE_SIMPLE
 
 config BOOTMETH_VBE_SIMPLE_OS
-- 
2.43.0

