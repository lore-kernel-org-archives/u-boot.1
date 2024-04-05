Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09433CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8E62884B0;
	Fri,  5 Apr 2024 10:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uVi1XCVp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FA6388499; Fri,  5 Apr 2024 10:22:04 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C3288849D
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-343e70dd405so288951f8f.3
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712305322; x=1712910122; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dk21LyGHImJBYNFvztEgUb33gmCnQ5zbMfQ4IK8Cb8A=;
 b=uVi1XCVpRxStAp2dE53Z/yoe00hAMFeTcKj4Tpp4s5v+eUgd7Ft6cQ4WEYc8763uO+
 LnFWF3bNjXhNHM+ln+jJnrWnjZyBZumn2i2ZaA8IVJ49bhjCSwqX7/EFDyz1F9a5JYvu
 9bil3ho9f+dBveZImjnazCKXV7wRnGS/sKw4/lCorYSG1qgESJO53EOh8Txz+cb/k1GI
 dgkLDDK8R5+CW4VlmlJspcvTFZLQ5WqzJlwuMQDuWPkedBNOEEkKiSl7GH2yZb9UpNmI
 z26twxbMc8v2870g6x3PV79oxR6IR4H/lsf770ZoESLsb/E7il6C7KaFhJUdAFvrGNkG
 F3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712305322; x=1712910122;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dk21LyGHImJBYNFvztEgUb33gmCnQ5zbMfQ4IK8Cb8A=;
 b=GrW1Ey994iNC8NWBfMqX8gH3w+EKImtDEqpWtLdvtQX15H5pCxwnzPkz8zKn5IZJAU
 oqgKCFmsi7tbaZEmVmD9CRvI19ju3qceFK/kKyTZDjKjDBsd2/WRseD+KRS2jf+pynMO
 WGb/fgApLWffqdG6L/wGJYkheLgo09Pa/G/zIvXLmp42mj5PJpjnCAk4GjHWO7PnE2J3
 rWaa8FMMEGvJB7sAckK1jJ16MAMzpSv1vQDlg33YZmnxCEfo1lvRkf+EbgujJJNdhSE9
 rk0n0yhAIcvzMCELiDWHHWCjMSAcqb+zkz4+JrsE314S9zLsTWXpSIN7fCvb8BIaPs+z
 dDTA==
X-Gm-Message-State: AOJu0YynQqYEZmNV3Y3UXM+w5Mv9bzQZ5YTBEx09uVsywdZI40YNqwP3
 zilu1QVaHc+pzUUJZx0zcNgMNSAPwJWQijzGuiAzaBBjqFQq9tmMYfYbi/lJGFc=
X-Google-Smtp-Source: AGHT+IHgN8+lPm80FUdsZAgk4Cv8hurT9n3lo6gG2NnOv6Xa7C5iNerEOPEjYYXeTCGAHjY8YPUp4A==
X-Received: by 2002:a5d:44cc:0:b0:341:c673:f1e8 with SMTP id
 z12-20020a5d44cc000000b00341c673f1e8mr764388wrr.9.1712305321686; 
 Fri, 05 Apr 2024 01:22:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 j27-20020adfb31b000000b00341d84f641asm1452326wrd.8.2024.04.05.01.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 01:22:01 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 05 Apr 2024 10:21:56 +0200
Subject: [PATCH 4/4] spmi: msm: support controller version 7
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-topic-sm8x50-spmi-fixes-v1-4-031a9e5efab4@linaro.org>
References: <20240405-topic-sm8x50-spmi-fixes-v1-0-031a9e5efab4@linaro.org>
In-Reply-To: <20240405-topic-sm8x50-spmi-fixes-v1-0-031a9e5efab4@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Dzmitry Sankouski <dsankouski@gmail.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3483;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Of+sSRftRSuNrLL/g86jacc8masXQy+VXZvuP0XsLXk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmD7SlqG9NPSk1Uk5UfTjb64cR5ZP1gD6rz4hjHRri
 6C6RZb+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg+0pQAKCRB33NvayMhJ0Um0EA
 DCF5lLzcm7kH4xwmMOoXsI93QuGerqSfeQxof/D4bSdKCmaLguwcCrZYIBG1hHONbjvX1StpHOTaQu
 fXslTYYr6tnOibF/2VcokpMvIvr4mJX+0JEDYDvfD1aw02jZJl1vBj/C5Tx6nDfxinn5V+FZ9TrYkc
 RB7sqHRKqUY2eDHlhKNccHsiBUIsaY8a9oeIEFhC0P6tDswSOHeV9mqnQQfMNN49KOGNZBUP2zCFAl
 1e7AukNIDmDyLXsjX1CC3EQhz7GxbUeiqSYT61VxxZpC0/eEEjeUd5IM40EBONsNmAnAaSeK9f7g2D
 ikBk+FpPj1Vf6ML6TlDva7OmWMsYKMCuzK91mZHSjzuw27dWUWs38tsUyQd15RxmkEfsbn9ovGfV3r
 UdNR7kKQWFRIxo+fbKyFXL7gV8vBtU6Iewx/HouqfpKlVEw5TQ0DhUS2UpaGly8lrNqrayo4n6MUA/
 ViDensG+H3r6uW7vUVI708vTMGHf3h5+6vxL+31/aBlFg5lhu5vnbOyxZ0Wt2lD7SA4jFHqBAoFdCz
 Yk3C1QF4kzPq9FpAsc99f+32x9oLw6OLp+HuKYZIGpUtdLQI/XibLDxD2tHd92SMXl5t1S6IZCd+cR
 uOa0CGQ+T/rWjR77iDqpMc0NLaDyJwXmVAhfczHRZL6S8oH8RGoK6v0HbOTA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add the defines and support for SPMI arbiters version 7,
which can handle up to 1024 peripherals, and can also drive
a secondary bus which is not implemented yet.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/spmi/spmi-msm.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index 46e2e09dc26..244de69b359 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -23,13 +23,17 @@ DECLARE_GLOBAL_DATA_PTR;
 #define PMIC_ARB_VERSION_V2_MIN 0x20010000
 #define PMIC_ARB_VERSION_V3_MIN 0x30000000
 #define PMIC_ARB_VERSION_V5_MIN 0x50000000
+#define PMIC_ARB_VERSION_V7_MIN	0x70000000
 
 #define APID_MAP_OFFSET_V1_V2_V3 (0x800)
 #define APID_MAP_OFFSET_V5 (0x900)
+#define APID_MAP_OFFSET_V7 (0x2000)
 #define ARB_CHANNEL_OFFSET(n) (0x4 * (n))
 #define SPMI_CH_OFFSET(chnl) ((chnl) * 0x8000)
 #define SPMI_V5_OBS_CH_OFFSET(chnl) ((chnl) * 0x80)
+#define SPMI_V7_OBS_CH_OFFSET(chnl) ((chnl) * 0x20)
 #define SPMI_V5_RW_CH_OFFSET(chnl) ((chnl) * 0x10000)
+#define SPMI_V7_RW_CH_OFFSET(chnl) ((chnl) * 0x1000)
 
 #define SPMI_OWNERSHIP_PERIPH2OWNER(x)	((x) & 0x7)
 
@@ -52,6 +56,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 #define SPMI_MAX_CHANNELS 128
 #define SPMI_MAX_CHANNELS_V5	512
+#define SPMI_MAX_CHANNELS_V7	1024
 #define SPMI_MAX_SLAVES 16
 #define SPMI_MAX_PERIPH 256
 
@@ -62,7 +67,8 @@ enum arb_ver {
 	V1 = 1,
 	V2,
 	V3,
-	V5 = 5
+	V5 = 5,
+	V7 = 7
 };
 
 /*
@@ -133,6 +139,12 @@ static int msm_spmi_write(struct udevice *dev, int usid, int pid, int off,
 	case V5:
 		ch_offset = SPMI_V5_RW_CH_OFFSET(channel);
 
+		reg = pmic_arb_fmt_cmd_v2(SPMI_CMD_EXT_REG_WRITE_LONG, off);
+		break;
+
+	case V7:
+		ch_offset = SPMI_V7_RW_CH_OFFSET(channel);
+
 		reg = pmic_arb_fmt_cmd_v2(SPMI_CMD_EXT_REG_WRITE_LONG, off);
 		break;
 	}
@@ -196,6 +208,13 @@ static int msm_spmi_read(struct udevice *dev, int usid, int pid, int off)
 	case V5:
 		ch_offset = SPMI_V5_OBS_CH_OFFSET(channel);
 
+		/* Prepare read command */
+		reg = pmic_arb_fmt_cmd_v2(SPMI_CMD_EXT_REG_READ_LONG, off);
+		break;
+
+	case V7:
+		ch_offset = SPMI_V7_OBS_CH_OFFSET(channel);
+
 		/* Prepare read command */
 		reg = pmic_arb_fmt_cmd_v2(SPMI_CMD_EXT_REG_READ_LONG, off);
 		break;
@@ -250,10 +269,16 @@ static int msm_spmi_probe(struct udevice *dev)
 		priv->arb_ver = V3;
 		priv->arb_chnl = core_addr + APID_MAP_OFFSET_V1_V2_V3;
 		priv->max_channels = SPMI_MAX_CHANNELS;
-	} else {
+	} else if (hw_ver < PMIC_ARB_VERSION_V7_MIN) {
 		priv->arb_ver = V5;
 		priv->arb_chnl = core_addr + APID_MAP_OFFSET_V5;
-		priv->max_channels = SPMI_MAX_CHANNELS_V5;
+		priv->max_channels = SPMI_MAX_CHANNELS;
+		priv->spmi_cnfg = dev_read_addr_name(dev, "cnfg");
+	} else {
+		/* TOFIX: handle second bus */
+		priv->arb_ver = V7;
+		priv->arb_chnl = core_addr + APID_MAP_OFFSET_V7;
+		priv->max_channels = SPMI_MAX_CHANNELS_V7;
 		priv->spmi_cnfg = dev_read_addr_name(dev, "cnfg");
 	}
 
@@ -276,7 +301,7 @@ static int msm_spmi_probe(struct udevice *dev)
 		priv->channel_map[slave_id][pid] = i;
 
 		/* Mark channels read-only when from different owner */
-		if (priv->arb_ver == V5) {
+		if (priv->arb_ver == V5 || priv->arb_ver == V7) {
 			uint32_t cnfg = readl(priv->spmi_cnfg + ARB_CHANNEL_OFFSET(i));
 			uint8_t owner = SPMI_OWNERSHIP_PERIPH2OWNER(cnfg);
 

-- 
2.34.1

