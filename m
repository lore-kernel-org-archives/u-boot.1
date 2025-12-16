Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2340D5C0C0
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 02:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06D8A8334F;
	Tue, 16 Dec 2025 03:48:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jrtkrj4p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E196D8036B; Tue, 16 Dec 2025 03:48:15 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AED088334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 03:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7b9387df58cso6235474b3a.3
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 18:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765853292; x=1766458092; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UuHp0RwOGDtyB85V3TLaRscTFht/MjcPtqUp5OaVvb8=;
 b=jrtkrj4po0+3Y+Yfr58FoNO9JQ9FSzjKsm924wdaMKWxvueBB5Qauhd2qUNv0z6MdS
 Iq8gEGwuyFi25oaluNQ6oxG008zMWCzVPvNjkwPHY3i0aT0RnzQ71FF/pTZS79ZTNL4z
 ZHHa2m8XV8BNr8GyAhzMgM6sHR2yTCdUT8Dz7u8qOLDt+/V4/o1/e6R1UazBRmhpsmEa
 NnUUly80E0p1x608dVDLoe+5GHLvL372VeJt5vBvWc6l6sWfXipGUR/bQpx4VzsYZS8n
 hLJ8183GCpJUmrfz9+JNPHxxkWO/1kwzyJBx651raHRZppjDm1zN1VjtRTdpdVW0AMNj
 PzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765853292; x=1766458092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UuHp0RwOGDtyB85V3TLaRscTFht/MjcPtqUp5OaVvb8=;
 b=MJlGppcHiNsaeUDG36v6qO2KaQIWSbdSs7g46yUot1KnSNhDtu4g9RA2fAfvmIVZlD
 kAWfxYjMSksRclld3vZRM8AsUv4LXSUesA1/fRq1DF35oaijGswEZu1ItkjAvRfu0yme
 zk3t9x6yk/CMnpzbM9jaBMNOW7Q3oBfPcm7RO6Tx61YrwpQjZJS8QRcqqVkFjUb/P5kN
 rHHfkt0NEebNudVZm4efXDXM0jq6Yu/mzyMSC2lLRxr0cuWWvC0IqWQaw4eX5VRljrzX
 D+BOpiGyDkZ/0WFP1uOnQLctyCQyQUdDFQ8V5ilDwK48KPztbcQ2k3y40egInN0Yy91r
 SArg==
X-Gm-Message-State: AOJu0Yy8KyusVf+RREo1EhchjFvG9eiZw2BCTSnpPq7MnrcK5nOkrzhj
 dXLy1GwuWGwIP+qjPb/a5v4/uEKnxncF1DWlQ0giFfLsnRmg6lCGVn8n
X-Gm-Gg: AY/fxX4sS4LRStC0/Vq9juasBR8Jd4nihYUxuL6GjbFxf0ByviYyNM5DqlUlmn8dUiC
 brXCiCT5lKhShTG9TlWbPiZcke9lGvK21PwC0kDSYzekBgdNkYOCl/iJz9gJGM13MXeS+vbFnGG
 yn7sx3ODNRJLwJ830Po9A2TzCLciR7GZJ/F0gZEjjwJILhf/3W6ThUynNlbumk9Lrci6dwU6ETK
 TG5cUktWIEYclQ0YdHgFYjHphs68GFlXPHyuRJSHdjM76VBGpxqIZj4u4JVYByo2E2QLCgmTa+D
 GyQrJalsCY5kXhNSsL0GzVyFVfiGRaHlGCSOMI6jE9bjcGMl1jU8WmtWfpNjJgoAyM/z/FWu+rr
 TkBN2Qm3JL7DV44cXz6mfpGYP67JlxDOAZmsbicjzkDTX7sSfM7KZBRqYpfClkPz2XH8XqSD6W3
 RxDtebqfAIF8XWZVzHTIdAEw==
X-Google-Smtp-Source: AGHT+IFspqAWta3MCQtoee9Zz1iRNAD0Y5vWbMwDBOIYEFtbXnzTtVxrHoiYwIIjxKACSFixPCHung==
X-Received: by 2002:a05:6a20:e210:b0:366:c321:9ff4 with SMTP id
 adf61e73a8af0-369afa00b6emr12238006637.52.1765853292145; 
 Mon, 15 Dec 2025 18:48:12 -0800 (PST)
Received: from cs20-buildserver.. ([2402:7500:502:d4da:9fd1:87b1:de1a:188c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c26eb1d05sm13401606a12.13.2025.12.15.18.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 18:48:11 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v1 4/6] dts: fix typo in the pin name of GPIO191/GPIO192
Date: Tue, 16 Dec 2025 10:47:27 +0800
Message-Id: <20251216024729.1031306-5-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216024729.1031306-1-JJLIU0@nuvoton.com>
References: <20251216024729.1031306-1-JJLIU0@nuvoton.com>
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

From: Stanley Chu <yschu@nuvoton.com>

Fix typos in the pin name of GPIO191 and GPIO192

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 arch/arm/dts/nuvoton-npcm845-pincfg.dtsi  | 10 +++++-----
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/nuvoton-npcm845-pincfg.dtsi b/arch/arm/dts/nuvoton-npcm845-pincfg.dtsi
index 65de96b1f57..f73eb0494ec 100644
--- a/arch/arm/dts/nuvoton-npcm845-pincfg.dtsi
+++ b/arch/arm/dts/nuvoton-npcm845-pincfg.dtsi
@@ -1619,27 +1619,27 @@
 			output-low;
 		};
 		gpio191o_pins: gpio191o-pins {
-			pins = "GPIO191/SPI1_D1/FANIN17/FM1_D1/STRAP10";
+			pins = "GPIO191/SPI1_D2/SPI1_nCS2/FM1_D2/SMB15B_SDA";
 			bias-disable;
 			output-high;
 		};
 		gpio191ol_pins: gpio191ol-pins {
-			pins = "GPIO191/SPI1_D1/FANIN17/FM1_D1/STRAP10";
+			pins = "GPIO191/SPI1_D2/SPI1_nCS2/FM1_D2/SMB15B_SDA";
 			bias-disable;
 			output-low;
 		};
 		gpio192_pins: gpio192-pins {
-			pins = "GPIO192/SPI1_D3/SPI_nCS3/FM1_D3/SMB15_SCL";
+			pins = "GPIO192/SPI1_D3/SPI_nCS3/FM1_D3/SMB15B_SCL";
 			bias-disable;
 			input-enable;
 		};
 		gpio192o_pins: gpio192o-pins {
-			pins = "GPIO192/SPI1_D3/SPI_nCS3/FM1_D3/SMB15_SCL";
+			pins = "GPIO192/SPI1_D3/SPI_nCS3/FM1_D3/SMB15B_SCL";
 			bias-disable;
 			output-high;
 		};
 		gpio192ol_pins: gpio192ol-pins {
-			pins = "GPIO192/SPI1_D3/SPI_nCS3/FM1_D3/SMB15_SCL";
+			pins = "GPIO192/SPI1_D3/SPI_nCS3/FM1_D3/SMB15B_SCL";
 			bias-disable;
 			output-low;
 		};
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index 0d089110df3..29536f556ad 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -572,9 +572,9 @@ static const struct pin_info npcm8xx_pins[] = {
 	{189, "GPIO189/SPI3_D3/SPI3_nCS3", {FN_spi3quad, FN_spi3cs3, FN_gpio1889}, 3,
 	      DS(8, 12) | SLEW | GPIO_ALT | GPIO_IDX(2)},
 	{190, "GPIO190/nPRD_SMI", {FN_nprd_smi}, 1, DS(2, 4)},
-	{191, "GPIO191/SPI1_D1/FANIN17/FM1_D1/STRAP10",
+	{191, "GPIO191/SPI1_D2/SPI1_nCS2/FM1_D2/SMB15B_SDA",
 	      {FN_spi1d23, FN_spi1cs2, FN_fm1, FN_smb15}, 4, SLEW},
-	{192, "GPIO192/SPI1_D3/SPI_nCS3/FM1_D3/SMB15_SCL",
+	{192, "GPIO192/SPI1_D3/SPI_nCS3/FM1_D3/SMB15B_SCL",
 	      {FN_spi1d23, FN_spi1cs3, FN_fm1, FN_smb15}, 4, SLEW},
 	{193, "GPIO193/R1_CRSDV", {FN_r1}, 1, 0},
 	{194, "GPIO194/SMB0B_SCL/FM0_CK", {FN_smb0b, FN_fm0}, 2, SLEW},
-- 
2.34.1

