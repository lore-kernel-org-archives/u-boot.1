Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B464C7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 09:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C463D82C2F;
	Wed, 18 Jun 2025 11:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d90Fip0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 778E982C55; Wed, 18 Jun 2025 11:32:59 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CCDD82BCD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 11:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rui.silva@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-453426170b6so3098775e9.1
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 02:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750239177; x=1750843977; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i9gs5KFsj/hBGQL0IzTeMCSpBH40nsDfJeHMjvL2o9g=;
 b=d90Fip0ykkycZrhavcqlzXBkGOMh3rH1kRThQK+vbwGLFkQjiEPmq90Gr8K5Ak0bL4
 zPa/s4Mv8cyKrqDqmu2abtej4rQqYS56XTz4OzmWzZNO24cFNbL2XHYPnQgQRcjOTIgV
 lvhSYnBzCdgqdLFzLDxbnwiNENr0q1NiZYbV6DSvqiPsBDbr9ctTBW0dT2olXjwXsYYI
 XIcVdcrTkxljwCGBVVsiHoUmyfoMiSawpwpls6sqIMXu9O0J49kzo+k56lyz2M/aO8Po
 L900sF3oTM/x1EHzEM5eHTrzpzvr1Jlr8LbSzIe4NtFPdH1+meZkcg6BFNuwqdTMV9XW
 CvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750239177; x=1750843977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i9gs5KFsj/hBGQL0IzTeMCSpBH40nsDfJeHMjvL2o9g=;
 b=lpG9AC5sM57tSFF8mFg655P2kenD9Ua5Q0uBWnqNvh6cQco4usHNqQi6IZgclOw2qR
 tkITZQ8DrRpNYn09OdSCPd1Xp3t2m5q+5IWSaLlrJWMYVzwGqSfc+kxIJD/uJbCQiM2V
 J2o43/JsTPN/b+uKCLPWrBO2zIOaDst7kNnoKqOjmsD6im4kFqLzCGQjz9L8g/f6q8CE
 IrSpR+/3D9+lwiZZ2MqdHpfw5A1a6iC44q9MG5g/87keAKTPU1FsF93mQSGOZXybrsPb
 Zp8okNtW2jFJdLYgoTpLIPy4di6ZBLsOolXci18n/T3RWulV4//nvHm1PCuDhloE6/t6
 PjEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCMKC8lg1qziVgwiO9Uo5uhYT8q/zHpHUWKlHD6BWYO1ztRcEXlZv1WYna9THgyM+fGdhYNHk=@lists.denx.de
X-Gm-Message-State: AOJu0YypQ0/VfsZYumIAUaA2cNBkSd2PItF0dgmapPES6mHa3UN4HOo9
 jQSgg68ZnT3N3gQyddEaBzBJO9dRk8ueeQz7iBUkJzRU5kHkA0LX29PHACTq5QhxoQc=
X-Gm-Gg: ASbGnct+PkrBEtIHfTXbk1q4VTrzTl3rReBd0nlCDW9zkjpLwgWcqPAbGOgg95qh3Vd
 xqalbHU9BEHyoVAL+UbRzAD8txvZrqqhkGyXIGmrKTg9swYzHLmIJmz+rrFCeINUdbA4k76/0BP
 XXbX8Fn7t8GikT7xeCFlY1QevgbClg+vkACzlZbZmCPrSVATBk6Mc8oNRpaKsNQRf3+GVbXIvZ/
 fWEV7ScT7iG++5KDyUOO1ZKjvp9ojC7eeJ8F2y9JjXjD9g30ocOf+uZqCGglAPBeUmf03Ou2QVS
 OZLQgC9IFZ+1mUjuwpb+bMY0ia1jOwyFwhVxDCfFGw+OyCU+ySsO/wI5NjKHdHIMtnHBTA9Gl8U
 vcKEaQdni1NPWJGbxZMkAJ1k=
X-Google-Smtp-Source: AGHT+IFzltdoRebgsvBLlhg+jG7tIP3oElh5TAVpbXw2neexFXuesJhrH20d8jQpJAKdsxmjieRGrg==
X-Received: by 2002:a5d:5f8d:0:b0:3a4:eee4:f73a with SMTP id
 ffacd0b85a97d-3a58e26956dmr1573808f8f.22.1750239176589; 
 Wed, 18 Jun 2025 02:32:56 -0700 (PDT)
Received: from arch-thunder.lan (a95-94-245-170.cpe.netcabo.pt.
 [95.94.245.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a57b2bfc69sm10414461f8f.76.2025.06.18.02.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 02:32:56 -0700 (PDT)
From: Rui Miguel Silva <rui.silva@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH] clk: qcom: sm8650: add usb3 noc clk
Date: Wed, 18 Jun 2025 10:32:16 +0100
Message-ID: <20250618093253.225929-1-rui.silva@linaro.org>
X-Mailer: git-send-email 2.50.0
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

Commit [0] introduced, correctly, the bubble of qcom clock errors to
make it easy to spot missing clocks in the platforms, and this is a case
of that, add the GCC_CFG_NOC_USB3_PRIM_AXI_CLK clock to sm8650 clock
pool.

0: 7c5460afec3f ("clk/qcom: bubble up qcom_gate_clk_en() errors")

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 drivers/clk/qcom/clock-sm8650.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clock-sm8650.c b/drivers/clk/qcom/clock-sm8650.c
index 364454644a69..7c49e99c005c 100644
--- a/drivers/clk/qcom/clock-sm8650.c
+++ b/drivers/clk/qcom/clock-sm8650.c
@@ -193,6 +193,7 @@ static const struct gate_clk sm8650_clks[] = {
 	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK,		0x39060, BIT(0)),
 	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK,		0x39064, BIT(0)),
 	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK,		0x39068, BIT(0)),
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK,		0x39088, BIT(0)),
 };
 
 static int sm8650_enable(struct clk *clk)
-- 
2.50.0

