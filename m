Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604C0C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69E9487F36;
	Mon, 26 Feb 2024 18:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tkkwrQRt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBDFC87F78; Mon, 26 Feb 2024 18:26:47 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC8087F47
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33dd2f0a0c4so984757f8f.0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968396; x=1709573196; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0B3Pm1egxIpPDgXLN/1qgugTQ02Yeu9efC5KpFdqusQ=;
 b=tkkwrQRtmu+NAtPpFpzipy6wk64/v9At2uKlY7o0U2jQm941U3dOm09qCEKPEUY5r2
 D3luCt1l4NJnvfN+CValeXYu7+yLkYkOqIselk5YS5A6fKmZegEuShZmZ4yoMkLYIfY+
 a2Dj6p/PVdaJ2Fm4mMR4MGCtECV8fGYa1wMeq02ERyCzWaO5s4K1DvuIp9z/YiACMPvK
 YusQQ+PDC9ty/Vj9drNCxM1ehgA3A8CESWFhMTZCuyJ3tODVm7xq/gqFeS+A5rI/6uPh
 OOj0g8IVVo7tEP1T7Weh6Z6SDSuNspCRzRB6+4F8Mh26YUJTVM+00obXe00S71eL/HJn
 sqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968396; x=1709573196;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0B3Pm1egxIpPDgXLN/1qgugTQ02Yeu9efC5KpFdqusQ=;
 b=fmstoWtN/v2N0sn7WmGOTWPL9tF0vE1Zq+CV43iqHBYEqvfHrEFEUqcL0iwF5uckCB
 nrfjRRUnlN+gj4UOEntFmAQTuJUKqPplqSkJR+cTeRKRP6SAQVTO3e2ryu/F1DIHGMc5
 Ac+NlQyusUi6ERL3gadcH14eBMbU0g5Mjy9LBpIG4lt146PkneZQc6UHrsPztJovqLhG
 /qAJO3CW5iLKXbAnRQtxDEU7hsq2k0PEy3AWuz6stdcI5vJhDjQacnPlg6ZTMBBFmYMX
 v9LV7yT8crB5mR0a5JgPW5IOyNjtjnV9Yhn05A2GA0tuAxC+38+75XSpvkG7vDx1i4YH
 OLtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1lEbNe7tRzAh1Q6ZOJdH97luv0V0hk85jGzaLNPGqTflM3zSiM/0/Kj8NgJ4HtdsZYaOOr2zQCOAxNu8PIyF3RNmKug==
X-Gm-Message-State: AOJu0Yz6hPITpICMQB1US/uC13L+oKKoV1Bnph9qG8Oe/JWS0dm7Aqcr
 rUMeoNPuV2S9FdRTJuxtWXxNRF0oX3tvnm0jLdHaavdQnKqLZvgjmYZphconaig=
X-Google-Smtp-Source: AGHT+IF5hlj1oGDBYieB0NiT4vKSFD4O6Tn4TTAAoU7TxdJO4v0qGR/IyWc4SzZ/DO4I1GjXoVywsA==
X-Received: by 2002:adf:dd82:0:b0:33d:64a3:9bc8 with SMTP id
 x2-20020adfdd82000000b0033d64a39bc8mr4726779wrl.45.1708968395903; 
 Mon, 26 Feb 2024 09:26:35 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:35 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:19 +0000
Subject: [PATCH v5 15/39] pinctrl: qcom: apq8016: init pre-reloaction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-15-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=HKoQTxKtBqw7jI3iylSvuagOiihXVhg/tcAQ9jNpm64=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3cducfGJfMos/aX2M6aX1r7XNtarb222a6csXKi/
 ucfvbesO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEjlxi+Gf559j5Se7W3Ieu
 tq076cy/iUduC3MSh+bxZ/zTJvAUzl3G8E+/uPnBRZl804/a7kfz27/kJmzN8p/3br/NBZ/WqWp
 z9p8HAA==
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

On the DB410c we support running as a first stage bootloader. This
requires initialising the GPIOs which are muxed to UART before they can
be used. Add DM_FLAG_PRE_RELOC to the apq8016 pinctrl driver to ensure
that we do this early enough.

This is required to prevent the first few lines of UART log from being
dropped.

Reported-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org> #qcs404
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-apq8016.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
index 796c4b49d578..eb9bf87b6c2e 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
@@ -75,5 +75,6 @@ U_BOOT_DRIVER(pinctrl_apq8016) = {
 	.id		= UCLASS_NOP,
 	.of_match	= msm_pinctrl_ids,
 	.ops		= &msm_pinctrl_ops,
 	.bind		= msm_pinctrl_bind,
+	.flags		= DM_FLAG_PRE_RELOC,
 };

-- 
2.43.1

