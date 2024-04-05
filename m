Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32A2C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:22:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEFCE8849D;
	Fri,  5 Apr 2024 10:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rco2PrCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15866884A5; Fri,  5 Apr 2024 10:22:03 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 634F18849F
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4162c2107d3so8016245e9.0
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712305320; x=1712910120; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YVOcC+aJP/zP5nYNTwZP7yZVupvu+P2kFrJ8Oh6HoF4=;
 b=rco2PrCGKB8inuuQBvnzxug5R6C+QxIYo4TCB9gf182m5f2ZXJefgN+9U+ceIexJIr
 CIAYkHY8qddFoQUOAaIN8ftD0Wnjd0C661/HjfloLgZ+X2Ao0cHP9yURcrKZH76i52RO
 Kw3rc++A5w2IVwfYKSHysnLCKVaMTz8yxz3A2TmAKIlyq8dONnMG3rnfa/U1JpgIh45W
 Yt2LWGJcpgOXGTZGCOK8iovbUQGzi092UQRPOR8+Zdx/LC2aUJHZRdE8X/9IKZ/8vVPe
 1frpASu5EP3oY6UGjXKz39PaJUXf2/YOdM3ORk4svPUl5XxBR3H55scH1JBjo1IY0x3I
 bHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712305320; x=1712910120;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YVOcC+aJP/zP5nYNTwZP7yZVupvu+P2kFrJ8Oh6HoF4=;
 b=isKqfZ4H9MbOSDInwNiP3zrBeRoAlr+MRxaxru2YraKDY/SNL5K2HINgbBD0ijgxK/
 +IBwpFuHQLEtvV5gj3eFQK01mgAFEtPbdXcdbPs25jR4t9SBzAwv1x4Z3lC8CFB4LK7s
 j/8dB31Mh2/7e+qjXsOEucE1G4c809fQ5TghHoYWmFh3BnNjAaQfR4jRJYHBAVvnEcDC
 PNiobln6HI/qJTHwq5MERQVOeXiejmtgFx6VIoyOADMtsfhlbiKO2fG9aC/A3q5al8lI
 CBKJMWrOw6Z9/CSKxhbO75CkO9UJNB9j/g7qgaGqbxywSRnOKR9WAaLgQq0ceY81Bj4p
 Sc8g==
X-Gm-Message-State: AOJu0YwnYkMiCE/6O6CZ95wHRn0xDY7tNyI0WdLGxTKviO5aR4BCyY3B
 3DeWB9zbqEWpphcJTGPLa3AyvbQNjeua/gGOdEyeVKfbMi7nlx0BREtIwifyeoA=
X-Google-Smtp-Source: AGHT+IEF0LYChUKijfxq04oWImYbQq2QqP2KF2foQK4MY7/DnHtBQ83OZ6iisnRhVVHAdf4KAs7fjA==
X-Received: by 2002:a5d:5146:0:b0:33e:6366:5f2a with SMTP id
 u6-20020a5d5146000000b0033e63665f2amr648184wrt.5.1712305319633; 
 Fri, 05 Apr 2024 01:21:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 j27-20020adfb31b000000b00341d84f641asm1452326wrd.8.2024.04.05.01.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 01:21:59 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 05 Apr 2024 10:21:54 +0200
Subject: [PATCH 2/4] spmi: msm: properly format command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-topic-sm8x50-spmi-fixes-v1-2-031a9e5efab4@linaro.org>
References: <20240405-topic-sm8x50-spmi-fixes-v1-0-031a9e5efab4@linaro.org>
In-Reply-To: <20240405-topic-sm8x50-spmi-fixes-v1-0-031a9e5efab4@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Dzmitry Sankouski <dsankouski@gmail.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3605;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=L7dT0VNmPI3dYsmh0xmaANK0mnY7T76P4RWPgWp44w8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmD7SkhdfKS6R+LA5YCAeJ68mm04B/mMBSeVGzZ5Ho
 XhpKCLWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg+0pAAKCRB33NvayMhJ0f/oD/
 9w0YQxl7GiqzKQ9/qpwhsDqAhP29yxXq4bas6rAoPJf70u/WZB8UKLKxX/+kb2l8+ObXFv+iyjTfbV
 pjlrZrV/7wgEom2cgQG5amM6tt/EXsX/duZvs/j5L76Oa9RqTApsSIh7774Bo5CRPVyF2l2YIoV5Kl
 sUc8yV8IEe7ZXyC3FFWjJHN/32uaps/7/aeOIqgzcDfyOubW0lhSXzNGB26BAI46xxLpOQhVaYhXkj
 npLyyVpV6yXCjTqmroNPgy0tDbq22s73pM6G9jk2PtckrIIPR2h9eISNpU24sUHGcUWQXUtSxz7vsq
 I13JpX1HhLC7+dEnJHmvcax3FHhwGWwufI095oEa0TGGQbKn+H/it5MWpvxcnHsYApX9tuiT6m2LVX
 YLQRzWXljkQZ2yBmLGNIEgzMp9dbs+fyVHC/ZKByHIuU5wkTtflxmUamGURHgZODn8rTP3fD5Ydhhp
 8a+kbKKGBO/vaP6IdkVaba+76eCnGtQnSgQpnYGObjp+k5Es2ON4X7F4vBR/xXSRiZKsQaJuSXcGRV
 7D5KQf/5pbBUl2WXb+9ODdcWDiWKBYC2prhPPCdix90qnbAYlvvh7CU9A1NQ/1NWKKhqJa7M+AviLc
 +m2/qfMj+TB+HFKTMpdjPwQH4HLaHSuXodKg5ztTkFKOzcEmJyqgkwD2nHkw==
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

Since version 2, the cmd format has changed, takes helpers
from Linux driver and use a switch/case to handle all
versions in msm_spmi_write/read() command.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/spmi/spmi-msm.c | 75 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 20 deletions(-)

diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index 97383d8c7b8..68bb8a38c3c 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -78,6 +78,16 @@ struct msm_spmi_priv {
 	u32 arb_ver;
 };
 
+static u32 pmic_arb_fmt_cmd_v1(u8 opc, u8 sid, u8 pid, u8 off)
+{
+	return (opc << 27) | (sid << 20) | (pid << 12) | (off << 4) | 1;
+}
+
+static u32 pmic_arb_fmt_cmd_v2(u8 opc, u8 off)
+{
+	return (opc << 27) | (off << 4) | 1;
+}
+
 static int msm_spmi_write(struct udevice *dev, int usid, int pid, int off,
 			  uint8_t val)
 {
@@ -93,24 +103,35 @@ static int msm_spmi_write(struct udevice *dev, int usid, int pid, int off,
 
 	channel = priv->channel_map[usid][pid];
 
-	if (priv->arb_ver == V5)
-		ch_offset = SPMI_V5_RW_CH_OFFSET(channel);
-	else
+	dev_dbg(dev, "[%d:%d] %s: channel %d\n", usid, pid, __func__, channel);
+
+	switch (priv->arb_ver) {
+	case V1:
+		ch_offset = SPMI_CH_OFFSET(channel);
+
+		reg = pmic_arb_fmt_cmd_v1(SPMI_CMD_EXT_REG_WRITE_LONG,
+					  usid, pid, off);
+		break;
+
+	case V2:
 		ch_offset = SPMI_CH_OFFSET(channel);
 
+		reg = pmic_arb_fmt_cmd_v2(SPMI_CMD_EXT_REG_WRITE_LONG, off);
+		break;
+
+	case V5:
+		ch_offset = SPMI_V5_RW_CH_OFFSET(channel);
+
+		reg = pmic_arb_fmt_cmd_v2(SPMI_CMD_EXT_REG_WRITE_LONG, off);
+		break;
+	}
+
 	/* Disable IRQ mode for the current channel*/
 	writel(0x0, priv->spmi_chnls + ch_offset + SPMI_REG_CONFIG);
 
 	/* Write single byte */
 	writel(val, priv->spmi_chnls + ch_offset + SPMI_REG_WDATA);
 
-	/* Prepare write command */
-	reg |= SPMI_CMD_EXT_REG_WRITE_LONG << SPMI_CMD_OPCODE_SHIFT;
-	reg |= (usid << SPMI_CMD_SLAVE_ID_SHIFT);
-	reg |= (pid << SPMI_CMD_ADDR_SHIFT);
-	reg |= (off << SPMI_CMD_ADDR_OFFSET_SHIFT);
-	reg |= 1; /* byte count */
-
 	/* Send write command */
 	writel(reg, priv->spmi_chnls + ch_offset + SPMI_REG_CMD0);
 
@@ -143,21 +164,35 @@ static int msm_spmi_read(struct udevice *dev, int usid, int pid, int off)
 
 	channel = priv->channel_map[usid][pid];
 
-	if (priv->arb_ver == V5)
-		ch_offset = SPMI_V5_OBS_CH_OFFSET(channel);
-	else
+	dev_dbg(dev, "[%d:%d] %s: channel %d\n", usid, pid, __func__, channel);
+
+	switch (priv->arb_ver) {
+	case V1:
+		ch_offset = SPMI_CH_OFFSET(channel);
+
+		/* Prepare read command */
+		reg = pmic_arb_fmt_cmd_v1(SPMI_CMD_EXT_REG_READ_LONG,
+					  usid, pid, off);
+		break;
+
+	case V2:
 		ch_offset = SPMI_CH_OFFSET(channel);
 
+		/* Prepare read command */
+		reg = pmic_arb_fmt_cmd_v2(SPMI_CMD_EXT_REG_READ_LONG, off);
+		break;
+
+	case V5:
+		ch_offset = SPMI_V5_OBS_CH_OFFSET(channel);
+
+		/* Prepare read command */
+		reg = pmic_arb_fmt_cmd_v2(SPMI_CMD_EXT_REG_READ_LONG, off);
+		break;
+	}
+
 	/* Disable IRQ mode for the current channel*/
 	writel(0x0, priv->spmi_obs + ch_offset + SPMI_REG_CONFIG);
 
-	/* Prepare read command */
-	reg |= SPMI_CMD_EXT_REG_READ_LONG << SPMI_CMD_OPCODE_SHIFT;
-	reg |= (usid << SPMI_CMD_SLAVE_ID_SHIFT);
-	reg |= (pid << SPMI_CMD_ADDR_SHIFT);
-	reg |= (off << SPMI_CMD_ADDR_OFFSET_SHIFT);
-	reg |= 1; /* byte count */
-
 	/* Request read */
 	writel(reg, priv->spmi_obs + ch_offset + SPMI_REG_CMD0);
 

-- 
2.34.1

