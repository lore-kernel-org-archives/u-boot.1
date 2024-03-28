Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E1CCD11DF
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 18:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D34AD88158;
	Thu, 28 Mar 2024 19:00:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PYyDMVWE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4059887A0E; Thu, 28 Mar 2024 19:00:00 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C295881B5
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 18:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-341808b6217so756271f8f.3
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711648796; x=1712253596; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P6XcPr9pfYOEmSnzHa2qooJBhM9QEIsjkS+to/+R8LA=;
 b=PYyDMVWEkqfbt4GupZqzxrx1h+QyB3CO6gP2nD9semrI5XTQLuFRN3RswXvhLcFsJA
 h1pOn7aaxes85ypBg18pBu8We+VXpYtFOvwRDXZ/LsOmGxNcOB0k7nEZPVRM5IXPglwC
 uaN42Gu6ddSPsC/k7l8KAIWfFXIRlWGHYx+yVlvqedSXW8HNpwBJgZ1Mla6PKDgk6W/C
 41sEiYFAMoqpPQ+AyDgowriCHy49A6Va0jY3tKnIf1CkzZdaVS2+U9+XorGTaWTXfJnY
 XsgBspSAZYO9sHCRDowpA7TpoSIxpP1ktZ8nPqLcJaQvLyOl8xnMbPQswk9mumnmFGeJ
 mLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711648796; x=1712253596;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P6XcPr9pfYOEmSnzHa2qooJBhM9QEIsjkS+to/+R8LA=;
 b=iqU+rMFSOXpdTyzsrDUipbUJBE0hrcA096voKCYM7zIeIZ7KppaEeqizmmL+AD/OW8
 GLiPZERcLc/6qlAnGlgw7R1VHzCvXsMjnQLmM1BsA+Ir0O25/A0fXwJ/3M651sIBi+P5
 CXLbGlQOHjd2RDeH2vw90qrc9Rv2wdK2hwUJHvYFM5P2aDnXyse1ewONcue7SoYd/vvp
 5TO2QRImCIVYmqHxMknF1PpONB3K7+p87qAr7bBgdnyeUoHMtQjTgHZ2bLaPk03qGYD+
 bcAGwGP54bMfviMQEXJJcZxhekZbG3xatDPs2UH+CZ8mpOpey2gGjtCXeC97ejED8HAA
 kjjA==
X-Gm-Message-State: AOJu0YyXOCql0T1iAn5xOpuBKcHJ2wFnOZZsT+tQ7nYfKT2HMAIJb9k6
 cq1wETcSrjNeNdljhR+8sjzdn9XhIw9YfvYt6rPHoYhkXaTZo0kovYx9k5nXsPg=
X-Google-Smtp-Source: AGHT+IHDkKgSt6wbzKkxqgf/Au+PqgQNKB1SIaXPZZBoqif1AAfFvgTCaH7qsysXIkS/tY+57K4eaQ==
X-Received: by 2002:a05:6000:18cf:b0:341:7269:e4d0 with SMTP id
 w15-20020a05600018cf00b003417269e4d0mr2584939wrq.54.1711648795760; 
 Thu, 28 Mar 2024 10:59:55 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a5d4acd000000b00341e5f487casm2292237wrs.46.2024.03.28.10.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 10:59:54 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 28 Mar 2024 17:59:20 +0000
Subject: [PATCH v5 14/16] qcom_defconfig: enable livetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-qcom-livetree-v5-14-4e98228b3d03@linaro.org>
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=nJRZofJGcS/sPbnQvIzqGqi1p7++HEANmQebMMxA9oM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTWDVzTLTIydadF8F1TNogwO+B97qrlhu2da42K7HaJH
 JPu3SbRUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACay24ORYf2GO6rn5qqcmSpR
 9qGERUZWZ98iHYlj69g6TUMrBZbOf8jwzyS0qG+mzuFQt7tsIWbPtQQXzPrIflErXC/ktmSccMz
 vEAA=
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

Qualcomm FDTs are on the larger size, and with the addition of DT
modifications during board_init() it makes sense to enable OF_LIVE
globally. The cost of building the tree should be offset by the
increased efficiency at which we can walk it.

Some rough measurements with CONFIG_BOOTSTAGE suggests that this might
add 0.1-0.2ms to the boot-to-console time. However the reset-to-reset
timer difference is in the range of 0.5ms so this could just be noise.

Suffice to say, no significant slow down.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index cbc612b44bd9..8c4402e8f780 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -25,8 +25,9 @@ CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_LOG=y
+CONFIG_OF_LIVE=y
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_SDM845=y

-- 
2.44.0

