Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A2BC54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 09:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E79582C8B;
	Tue, 27 May 2025 11:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="WYSoFStI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CF2782FE1; Tue, 27 May 2025 11:33:47 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4923C82B07
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 11:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4dd5f69e7so1030120f8f.0
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 02:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1748338424; x=1748943224; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sm0y89k9exDo7B0s59RKotpEh6qwAfikB+9aNpPvhkA=;
 b=WYSoFStIWfJnGinCTpiXY2wgEPhaYzHHxA4qXgCIVbzCnq5+Ow7Uaqyh5rt/fff/35
 SwrMLilK/D3PiNkml1SRvtRe6hg8srGLxriLWFWh6xMJ/u1SMPd5APyJfhW3x5STpogn
 A8WyBzFUWffTuhnm4uz9is1UA/brDqBELvv2H78DXBsTCnUFDzOfe4C0lxyhemacosfw
 HoLWWiEuvHm3sTz/XOZQuJp3al3TI8WMC80kEsHJSDtVwAK2MqIgEzRSoX3ORzr4hsti
 8hYFBSHPIKGoM/6quWSYXJBoQNchIDyTLVWgja6oYidys0yKUn7yMUmLJyoUqFn9v+FN
 Nr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748338424; x=1748943224;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sm0y89k9exDo7B0s59RKotpEh6qwAfikB+9aNpPvhkA=;
 b=r5U0ZwG+X0mpKkfhwmNkJWIM/qlHfcc3LQVa3HmcY1E+qkV0kq3PtTKAEHn8U99T3U
 FY/qtVEQsmgG5MG39TVJx5gmFQgiqBlREuiL46vtZoquyoDAQ4URuCpv/YMxOcwrwjId
 VwO+rYeRSpBizmyaf0EOVMbxMOG6sUZIvWN63fFmHVE0VpEnPqCKZA8CFTo6dOgpV1Ra
 Qor1a1LEru2jNTrBsJVewiRx+nkralgQ9yAnxJ9hnMFokzK2WFt+5w3wGKkSHEFxRfIe
 bwii6o9miAM1QoFmUkKMn6iDWgrAhlZnmB4J6rFBfF1JDIbic6+koCwAeNxWUqc4Fzx/
 uN1w==
X-Gm-Message-State: AOJu0Ywp+ajYzdZp6wMQeBekYTW8oAo7XKZZwNd6Zu0AUtTJpA0TxSJo
 YVGFKKBCgv12fBfKG1Ov5WbQ2Ac57xQUrKhsTprOYLV1ZuHmb8hMjLnmLfuIbcKeJBA=
X-Gm-Gg: ASbGnctzV2GNaPAiXcl2459Cvc4OsZymwdkTIJBtunPZOkWMtgYmrc04vkYkpz4Suhz
 1HcZ8BKSoY4WSvopQb64Iy9LjtrUaWIBXgLylZbdDizD5p/B0PLGvXqMqOaBGcnB736yc4dmS6B
 GJ1pA5v02UoDp0iu+rJZAqRgmd++t8WAKx5e/jC8eZZIce58/rztxWf9bI+sZYwmXku4WvkdfD1
 HQiKP/wsGf83f0aYaOquLw2ydBNInLMS5ls2/A4JWyOdgkHoUCPS9M8iAqidarZTI6c1kh5ELH6
 ynPDh31t0X2SP+3r7SXYrss4Z7lavxubE79r4OISL4d/C1gWAh5V8ZFzOKEgQJ8vj+K/MA++U9W
 tHrjqEA6mmEjq8PwYs12jWNFUFyk0rWiXquGhPpVLt+78iRoWVEqIWCJXP4Fv2d8=
X-Google-Smtp-Source: AGHT+IFOqIbQ37N+1ZpJGUTBkNuWEWDUbODqnAOfvjbpfi4vcomPw31gVGJ9/E6OMQh9Pw0QY2CJWA==
X-Received: by 2002:a05:6000:178b:b0:3a4:d6ed:8df7 with SMTP id
 ffacd0b85a97d-3a4d6eda61amr6901385f8f.59.1748338424379; 
 Tue, 27 May 2025 02:33:44 -0700 (PDT)
Received: from T14sGen4.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4db4e6f15sm4592294f8f.81.2025.05.27.02.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 02:33:43 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Tom Rini <trini@konsulko.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] arm/dts/qemu-sbsa: Fix interrupt
Date: Tue, 27 May 2025 11:33:31 +0200
Message-ID: <20250527093332.518931-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.49.0
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

Change the vcpumntirq in the GICv3 node from SPI to PPI.

Prevents Linux from complaining:
'[Firmware Bug]: CPU interface incapable of MMIO access'

Fixes: 6d722894fd48 "board: emulation: Add QEMU sbsa support"

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 arch/arm/dts/qemu-sbsa.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/qemu-sbsa.dts b/arch/arm/dts/qemu-sbsa.dts
index 099b51b927f..a7718d6c29e 100644
--- a/arch/arm/dts/qemu-sbsa.dts
+++ b/arch/arm/dts/qemu-sbsa.dts
@@ -91,7 +91,10 @@
 		#interrupt-cells = <3>;
 		status = "okay";
 		interrupt-controller;
-		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+		/* vcpumntirq: virtual CPU interface maintenance interrupt */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
 		reg = /bits/ 64 <SBSA_GIC_DIST_BASE_ADDR SBSA_GIC_DIST_LENGTH>,
 		      /bits/ 64 <SBSA_GIC_REDIST_BASE_ADDR SBSA_GIC_REDIST_LENGTH>,
 		      /bits/ 64 <0 0>,
-- 
2.49.0

