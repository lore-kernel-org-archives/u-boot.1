Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C0CC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 05:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75134843F6;
	Thu,  7 Aug 2025 07:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P8xGpcwL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FF2D843FF; Thu,  7 Aug 2025 07:32:58 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7996B843BC
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 07:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b427094abdeso514060a12.3
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 22:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754544773; x=1755149573; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmF6iGZhnjs8vss7cDQ3NhBf80J54pA7zzh91i/TK/Q=;
 b=P8xGpcwLB0kQyzn3HivuA5CoyrEElMAbnlLU7W6ERomY7So2ht3DQqU04RVmRCFmU3
 w8qYPP7p25OWr+AAJItWoYa/BKnoKWm5xi61qjYjuqSIV4Lxb0gR/yC2GWVy3CnJV2AT
 k9BIEvaODmPPNoqgQVBlAitpwjKGyMG6xZMT0MaNcaNPkr7xh3zmxkcesK6dcDgSqFeE
 k3xpK1cRMXGKXqUajYIBdew6rXsa7xXImSlj1XkOpssPTOp6epQkgU9Gbt96UtLnv1+c
 umQ37c7GH4PLz+ITD2teJGOxYsfjVHSQUaIrVIcoyNSF0JpXDN4eAAQsN5EDUhcVJjgE
 ixDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754544773; x=1755149573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmF6iGZhnjs8vss7cDQ3NhBf80J54pA7zzh91i/TK/Q=;
 b=AzAZzoQmA6MAFd8jYXhGOuoSvSc93FKuzN+37u3YTQNEH93ITyaPU5WPyKur6Z212m
 YcOmvR7O3GOyJNkk0rVRY2ow+5Xums0vYdT/Wv+jY+mAZnbQDno2sx+9QqmID2D2g3lJ
 1ltmgbTkOEfW/74LWy7ocknQJYRVnufhaydZ9vNdE6DVtTfTtlpVE46YagSN6pDkpkEb
 f2hJvKfzZeHQwkk6CxHW5/VlNl8fls0uCIeMDRv/80Z5oKE7Kip7Yr0uz6r25MRrlv/U
 xXwsipXrTsMvth4WdnERgxodeRVxpcuPKR2bH201+p3M/O75a8/fgX2DnIjP0ImN15wB
 Sx6Q==
X-Gm-Message-State: AOJu0Yyi8iyhgVJIP7SSBB+eQ1Pw+ianBJ45N/SdtLjN9WGd4uyMgSF2
 bIM7IjBx5zQ1o6jhGNsJ6nDCH3fb3J7SgkZ/NNe3uXC2Bl96ZErXrhbk
X-Gm-Gg: ASbGncuBnjMxkvgxT7LMVhNSyA3eMJJL3I6nljiBwj5dcNuW/K7KrM1baL//ry1SQLP
 o4Z65xYtEGNbpF+QufZG5gJ+tweME7wSy7v4g8n+BKeKm0sN5KAefhbiTqpPKIQ1Ynm6r6sRD2J
 sQUo7i0cfF92PZ5cPZx//1RAIXEEGkOhmpzECtCLVF90/J/1hNFWbvTvMzt01efOUFlxH/bjEO6
 QDal8rg1ONixy1v8zEjrzAztDgKOcsiCXzjBJrdD0uCliPoC9sw72gnIAqE46QNz678l4vs1DNH
 Pi/KJ4d3CeIoIzsnlrd2360AGX9AOF2QLke6WM/4IvpPvCw+VkPnrwdmdi6w5caYFtvk56RhZIa
 1YDKQcQOWpr40tFIGtYhDiTbk8UpxKWu3c2qZrWI9Sn4K
X-Google-Smtp-Source: AGHT+IFlusoBz8dWfcjkksEm5jVT331qK7a7ZQAKZ5VRRumkkfOGluNDOuEQ9vdPsK9hNgNjnfsc3A==
X-Received: by 2002:a17:902:ef0a:b0:240:9f9:46b1 with SMTP id
 d9443c01a7336-2429f5489afmr79749225ad.37.1754544772947; 
 Wed, 06 Aug 2025 22:32:52 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3216126c98fsm4384084a91.21.2025.08.06.22.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 22:32:52 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 YSCHU@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 4/7] arm: dts: nuvoton: Change timer node
Date: Thu,  7 Aug 2025 13:32:21 +0800
Message-Id: <20250807053224.2169557-5-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807053224.2169557-1-JJLIU0@nuvoton.com>
References: <20250807053224.2169557-1-JJLIU0@nuvoton.com>
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

npcm_timer driver is changed to use SECCNT counter.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 arch/arm/dts/nuvoton-common-npcm8xx.dtsi | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi b/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
index db7517cc9ba..be06b2a0cae 100644
--- a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
+++ b/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
@@ -62,6 +62,11 @@
 			reg = <0x0 0xf0801000 0x0 0x1000>;
 		};
 
+		timer0: timer@f0801068 {
+			compatible = "nuvoton,npcm845-timer";
+			reg = <0x0 0xf0801068 0x0 0x8>;
+		};
+
 		sdhci0: sdhci@f0842000 {
 			compatible = "nuvoton,npcm845-sdhci";
 			reg = <0x0 0xf0842000 0x0 0x100>;
@@ -157,14 +162,6 @@
 				status = "disabled";
 			};
 
-			timer0: timer@8000 {
-				compatible = "nuvoton,npcm845-timer";
-				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x8000 0x1C>;
-				clocks = <&clk NPCM8XX_CLK_REFCLK>;
-				clock-names = "refclk";
-			};
-
 			serial0: serial@0 {
 				compatible = "nuvoton,npcm845-uart", "nuvoton,npcm750-uart";
 				reg = <0x0 0x1000>;
-- 
2.34.1

