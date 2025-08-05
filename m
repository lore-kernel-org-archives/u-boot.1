Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2ECC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 09:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1EC18343F;
	Tue,  5 Aug 2025 11:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a6b/1wyS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABEA78343F; Tue,  5 Aug 2025 11:20:07 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 281938343F
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 11:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76bc61152d8so4363816b3a.2
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754385603; x=1754990403; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmF6iGZhnjs8vss7cDQ3NhBf80J54pA7zzh91i/TK/Q=;
 b=a6b/1wySOeQArfat5GmmkeBMHtmIffXTkhkpQo3ZuM60BE/XKjQzS5GC140obFU6WH
 PnWhOBnWNABD8fdy9yhAlYaBuOOj7qOPWCJbPACZr6dfJcXF1/ppN2GfttxGMxEfkNeW
 o9TrAIuF30BbNPq2mVYZWIAgKjhLdLr2Ywzk3yepfbcKK6o30pEljlAUI48xRy8EyrGV
 mQgUfpvik2DTRPp7PGyPvB34Ohwf3HYi3Kwphq60dyte8cPBmtyMKVm1AoVdZh11NWn8
 PNJCQuUo4FnsqAXHELUS5+QNJt88fm6LrAG/MUprru+sgF/MGKBhyEtaicI6l87ATHe8
 /qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754385603; x=1754990403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmF6iGZhnjs8vss7cDQ3NhBf80J54pA7zzh91i/TK/Q=;
 b=U4PaSDPMXnWhe64ZXKZoCxFXM3lcbbA4QjMoyD9K024OedSpmraWOPrsMoH0c8hKNh
 HCmSHZ53iCIoanozRxSSnEQT0myWYydTYQATRalCA3XBV2b+ivLWGMHdhvF5GjN65g+D
 rS224mN8+MyLsISYj7qOGTo0N3XEETmtBnrXFCIo/i7fatF7wDRDdd4zawk4X4LlxYn3
 T1s0pFR1bp1wsIvBr157gB1k7s2J7AKH3GBi9ZJwyI0bk6EJbxruo+EbtbJr64KtPaHX
 XYYS4IFhSwMd43PZjZuv7sT1iFHBFtk5V7asslq8q8XajBCnVgsEpf6WPoVYxuVHgoX/
 Qzag==
X-Gm-Message-State: AOJu0Yzt2D3EKDkqwSskHdDjA1lQ0vc5HYG6MxgyT2ieNICSeLtfMwLu
 EvT/qO7dohPi451BYDkc9cBVeyeMRulgTWgQ5lYAuH5HIjr7yF8emXNYSr0fvRM8
X-Gm-Gg: ASbGncsMQUd6mrcRTFHz9UlCQrhJscd2tEVaWyIhExqT+G+T/dfG+fd2L0YVyAD7w/2
 G0/DcvIoXHUAfDZTGW+2FkoPzxyJ6oR6YzlWsxriQLbRaSlAwRStabfQRkypAVvL6QflwTw2iGU
 ugqEdtxjSvCd1JwmNfIQlcQZhmZ38wKVUrdN9srdoRDhTLw7TKtxClbePstQ13FE8DIw+R10YzI
 4jXoAAqklV1Om2V3aa+L5iK5YRv8ipOmez+knllVSDws4CBsIsGq7eCjZoXSIlpa7GXxm9ZFh6P
 UVFmTLcW5Lov6mjOGE34ufsHgEbhGjv1F9x+d6/Wqrssu4TsGpNm0xHTNWRQw8GsWZCQ3IUDdS3
 TYnvpC6El+wgGVTRFkg1OhCqzsaH9zgi/Rw==
X-Google-Smtp-Source: AGHT+IGXL86lmWg6MHD59b6gr1c8wbmiZVoAkAqQPi9sAjJxNRgztX8MqG2SGi3u8zrgS6kps9diaA==
X-Received: by 2002:a05:6a00:21d4:b0:740:9d7c:aeb9 with SMTP id
 d2e1a72fcca58-76bec508b6cmr19065290b3a.21.1754385602636; 
 Tue, 05 Aug 2025 02:20:02 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce89125sm12495185b3a.33.2025.08.05.02.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 02:20:02 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, YSCHU@nuvoton.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 5/9] arm: dts: nuvoton: Change timer node
Date: Tue,  5 Aug 2025 17:18:46 +0800
Message-Id: <20250805091850.2051096-6-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805091850.2051096-1-JJLIU0@nuvoton.com>
References: <20250805091850.2051096-1-JJLIU0@nuvoton.com>
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

