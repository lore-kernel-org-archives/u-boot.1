Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D8FC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9CB1886AC;
	Thu, 18 Apr 2024 19:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xaM2NV++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5EAC8869D; Thu, 18 Apr 2024 19:26:32 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 950A1886A7
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3476dcd9c46so768001f8f.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 10:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713461190; x=1714065990; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LuY4IJnS3xAD09urZivC55YkvTtWrEUFIrmTWhylKUg=;
 b=xaM2NV++3SuMXdaQysSs8skgPWK7PqV0JF4YMq3WB9wayAbJpmBH5C0PA6qKJ9I3EO
 XcESgJANKoxwxvDGE/+dlHh3l/64x+6MSKIR75pt5/wQlcpTURbyOagd+vj+HfaLh+4i
 B+cO9PO7VpQN7ttruuvbHHymXK7943Y8gEjgo1rKpUQ4d9pcAI4w3TG6Yy7m4iULiwlu
 PnIiGSMTE4A4R/G9ipufn26Xqn7H8wqrT1Ui08fln02feQroE7EdZFIwNyX7mh5ec3Hy
 8i2Gie1cgH0WLwlSXTUdzyruu8+qFj+dlRZQoieuGdiB4IHUxiIkOVsW1v1K6yLYBg5X
 SJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713461190; x=1714065990;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LuY4IJnS3xAD09urZivC55YkvTtWrEUFIrmTWhylKUg=;
 b=FSVCHo879//6fE+PCzTw5xCE1tRBXjsumeqfrI8Ozp5JGsSlwPO4NXrDj24z4qSSvX
 ykVdZhz4/2lBelG/F0rtCHKJ7ggEoSiH6hQ3G0vLtaFLbISiZgG4T5uVpWHfYROS3ykl
 5bZnJoTWWNMJ/TS2N88JY+VFCDMegMaiJagQsMdwA9kEDszzExJZevT+wo2U9oEawkOX
 xJwxCHebfgr7Jzng63Y1t+2h5CDJAQwUC83mB/ge0L5NPyzNWo5WjvVFtASCSaL24Jbv
 KDFLNTK0NZmw0AoBAObbidOVwBfMEpr93zgvzq821ytHGk2RvLocJoviiaqXSP+4QKXU
 SIuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxYhJNLcRDbDe8OnBTbOIDyxOZ8MWHjo4NHPbXlwTMySb3IC2ec1hhsKZ+bzGcrDpt8F9EK5tXpRUc7xxSqWXstY/rRA==
X-Gm-Message-State: AOJu0Yy5ALZVrtnKTj3d8anbZN5ixwfjvNnm5IM98IcSzY1bpLCQN9Oy
 MUopsUKUlcIU2OILhTIlzdqhKVufGkouNC9TXrgZ2GkteZkZheZoMgVMQMWAS+c=
X-Google-Smtp-Source: AGHT+IF+0enlssfK7HDY6iQNddRZpHMN3o+sIhHMP9HwJ7lr0M9P3ukhtt87ntxmW43jfe4/3TiWAg==
X-Received: by 2002:adf:db46:0:b0:346:9903:d10f with SMTP id
 f6-20020adfdb46000000b003469903d10fmr2178935wrj.12.1713461190114; 
 Thu, 18 Apr 2024 10:26:30 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b00416b163e52bsm7166057wmq.14.2024.04.18.10.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 10:26:29 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 18 Apr 2024 18:25:50 +0100
Subject: [PATCH 7/9] qcom_defconfig: enable OF_BOARD_SETUP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-b4-qcom-rbx-fixes-v1-7-f5f19d52969e@linaro.org>
References: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
In-Reply-To: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=577;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=KWVbTvhUmSkAmdAG6mFU79kzv6VdwapreGlEz7VrjFI=;
 b=kA0DAAgReTBFn7kwMhcByyZiAGYhV76giO3I8/wmzkurrAzAqdzeaBkp9apr/RnZFTiyDE4Id
 Ih1BAARCAAdFiEEF8imOYKt0z8ot6DQeTBFn7kwMhcFAmYhV74ACgkQeTBFn7kwMhd7JwD8CJac
 8lDMUYpvCn3AQt36M+zrvS4CGYJcJLr0HkxEQ3MA/09j/ZQL2P7glTTX6v/S7y7ee1/yAnAfX+d
 XgADndQSA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Use our new ft_board_setup().

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 7b589f0bf7a7..209a7ba324d0 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -33,8 +33,9 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y

-- 
2.44.0

