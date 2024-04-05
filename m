Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F95BC67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 580AC884A6;
	Fri,  5 Apr 2024 10:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JAF7MU5K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87A0C88498; Fri,  5 Apr 2024 10:22:01 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4ED98849D
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-343e70dd405so288922f8f.3
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712305319; x=1712910119; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6dKpRGmyPkdUIGV+k5unKfus8cERlzrz7D8lFITEH4k=;
 b=JAF7MU5Kq/r+gMttnW1/XoITQZhf6Sk5Df8uhyB9LnfcIFqGt0JvmMkul6SJnLi+Ah
 rIgqM0nEPt0803TSY4agsYwpzSLFg3LquJ+9BMHQUxL6L37YuRv7P9Rh7hwQd7BVW2+I
 cPK+Y05tvq3Eo+8a/iSXspJ9L24CRlv7Mkm5kmXv2nFNzp4LmjTwabfxpEb45dRvtnAq
 Gm7IzaQhlz+BJWhQIZBxfnEUYEq9rxj4F4gxSS2vcwGyea3GJk7EiQc6UUTC+lG7nYGB
 vy10ky5v+RWez9s69E0ktLc3sakdFIWv5CWh4DFFW9K0bLScXS0sLYk7ozB/9E9/AHAw
 aUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712305319; x=1712910119;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6dKpRGmyPkdUIGV+k5unKfus8cERlzrz7D8lFITEH4k=;
 b=whnr/5ML+YL+o31sm8RHztN/oCbyzh+m6F7fKTHgI7KaiL3yLqXa6D/SQoyK62pSzS
 RmgbOcQhVUtJQOJfgbRY7TikAn8XpibUXgg5iBGuFFEaZAz79aTJuxPC+sjLMh3FuJYS
 Trl5riquK7FnnOucZHk+M/e3boqHOKDUBl56GUTuYmbKhzxZT1J0tN+glihV0B452IZv
 hqi75iTqBm47ZNHGmNxtij6Hzmw0S3unS6WlS/v5KF4dFmuB/HaYIieTJoi9qEUk1o4A
 RvPRKPT3OH4m1nNJENmQaJ/o/FqemmyRCQ77AZ4aweMQQ9GXVEqa1r/LsgQvbfHx8FV6
 gIkg==
X-Gm-Message-State: AOJu0YwUKIUF19R4XyoS8vO+KOyBvxkuv7iUZZYX96laaiEiQB8lQlEV
 jZooagjR80u0HLUkFZHlz/pyihQn8G+PwzxV5CK7k4j6KzHsEWNxXbm7KNFjSx8=
X-Google-Smtp-Source: AGHT+IG0RZ111smx/9Z/2Bh4iIm9pWm+zz2fD/fKNIsYzM5QFR1SFtyfoldTBabQcArgvTAueKUACA==
X-Received: by 2002:adf:f9cc:0:b0:343:7653:ad14 with SMTP id
 w12-20020adff9cc000000b003437653ad14mr767204wrr.30.1712305318937; 
 Fri, 05 Apr 2024 01:21:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 j27-20020adfb31b000000b00341d84f641asm1452326wrd.8.2024.04.05.01.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 01:21:58 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 05 Apr 2024 10:21:53 +0200
Subject: [PATCH 1/4] spmi: msm: fix version 5 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-topic-sm8x50-spmi-fixes-v1-1-031a9e5efab4@linaro.org>
References: <20240405-topic-sm8x50-spmi-fixes-v1-0-031a9e5efab4@linaro.org>
In-Reply-To: <20240405-topic-sm8x50-spmi-fixes-v1-0-031a9e5efab4@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Dzmitry Sankouski <dsankouski@gmail.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=LaXl9zWgypJuMb/3QiSIxEc5AI6hOk7WqkoxmZNe4lw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmD7SjIqVUicjlR9KwI334QwwllUSzQacDLhtU2ySw
 JrkOcc2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg+0owAKCRB33NvayMhJ0YRlD/
 42OLZUM0UUQUUsHaMoE2jWOBEptTx3+jhp5wift7QSh838oo/GH9Jkz/1p+yFzOm0lBtc1vpMuatpg
 ybAtB9fJ5p5zdivBF30uXimBd6J4B7Drh4qUiyPzBOncRtMCQcZdDF37Q7BLU96ijJDE3Xgs9b7CvZ
 52qc0IPO6JHmMGOOpqV4U+O4aazNk6SdQsZmeK6Vux+RsoSqnH6WCuzKbZVklVoeIlB1vDsWkR8kAD
 OvkqZYGmvLJFCr1uK2AEsdbhR0BBQJ/o55A3mTCVh8Qj8CFIVdPGCw8pAp9hciSqsD8l8Id8x79Sf4
 pU/9oGYUIkMOgg6oCT1UTBqs15PuCbaaLmM4flnqtTsBTUg8H8cmig/uAwbC+xabjP4AA/v4XKXu9C
 xhq0r4iJwbS8QBNm5V0QzSuFGgfaUeHNpGGrOMlL/HSYj+0OJDNEn4PLL1bedTUGEaTSc2F8qBIZ1N
 smddUytRSUAIj5UtkYmkXr4uIdOi15PUo97dsXJc1WkYBlvClgCzUA7VHCcrxyLqjl47a9lj7JpD5v
 LwA+jEfqARTtKhoMl9DHZFDBQi6kGz8bOpy0goZvHCFfYFbjPtpEGhFqZNbxIHWc9A82YMPG7yenJa
 WDmR8bSjet/NvXzAsKZ02u4C4vdLkciAS75X+XnriLzssbODdcuC87IYeYAA==
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

Properly use ch_offset in msm_spmi_write() reg access.

Fixes: f5a2d6b4b03 ("spmi: msm: add arbiter version 5 support")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/spmi/spmi-msm.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index 5fe8a70abca..97383d8c7b8 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -93,12 +93,16 @@ static int msm_spmi_write(struct udevice *dev, int usid, int pid, int off,
 
 	channel = priv->channel_map[usid][pid];
 
+	if (priv->arb_ver == V5)
+		ch_offset = SPMI_V5_RW_CH_OFFSET(channel);
+	else
+		ch_offset = SPMI_CH_OFFSET(channel);
+
 	/* Disable IRQ mode for the current channel*/
-	writel(0x0,
-	       priv->spmi_chnls + SPMI_CH_OFFSET(channel) + SPMI_REG_CONFIG);
+	writel(0x0, priv->spmi_chnls + ch_offset + SPMI_REG_CONFIG);
 
 	/* Write single byte */
-	writel(val, priv->spmi_chnls + SPMI_CH_OFFSET(channel) + SPMI_REG_WDATA);
+	writel(val, priv->spmi_chnls + ch_offset + SPMI_REG_WDATA);
 
 	/* Prepare write command */
 	reg |= SPMI_CMD_EXT_REG_WRITE_LONG << SPMI_CMD_OPCODE_SHIFT;
@@ -107,18 +111,13 @@ static int msm_spmi_write(struct udevice *dev, int usid, int pid, int off,
 	reg |= (off << SPMI_CMD_ADDR_OFFSET_SHIFT);
 	reg |= 1; /* byte count */
 
-	if (priv->arb_ver == V5)
-		ch_offset = SPMI_V5_RW_CH_OFFSET(channel);
-	else
-		ch_offset = SPMI_CH_OFFSET(channel);
-
 	/* Send write command */
-	writel(reg, priv->spmi_chnls + SPMI_CH_OFFSET(channel) + SPMI_REG_CMD0);
+	writel(reg, priv->spmi_chnls + ch_offset + SPMI_REG_CMD0);
 
 	/* Wait till CMD DONE status */
 	reg = 0;
 	while (!reg) {
-		reg = readl(priv->spmi_chnls + SPMI_CH_OFFSET(channel) +
+		reg = readl(priv->spmi_chnls + ch_offset +
 			    SPMI_REG_STATUS);
 	}
 

-- 
2.34.1

