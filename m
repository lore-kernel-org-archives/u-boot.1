Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCA4C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:56:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 528D187F5E;
	Thu, 15 Feb 2024 21:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ArKpYqxp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF5FC87E62; Thu, 15 Feb 2024 21:53:27 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8087F87EDE
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33d01faf711so60126f8f.1
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030359; x=1708635159; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NKasSF8OfZq+DEY4uBwsa0q3Q/WOr5tzMGKZL1xqImg=;
 b=ArKpYqxprB3qoguew0m6Sakr7yEMO5D58nkO85Tc2cb/iNRPt+9Xr8Yvqby4u3M6Xk
 jCU57sJZIP0MGPTz15GYGqQ6XLnRE89eb5oT9Ob5yLXAlf46z5zB5Fv5Kecv3eoBfYRu
 HzMdMMJK7PoO06QHduJjD+XubBCiMosBiUcq4D11DiWGhROoV++69+pKY+WNzuBhmltl
 /C1Yh4pMhbINajd2QnD500X/nrHHMb4KxgwJutIn6+k3IQb6hqXdHG+1KZex4oKSADA3
 9ltEh/r0vuWqp+WWZ2NQdyo09FKl7JDXqy7/68c3HAYnG5pyWFkHnJ+bmKiET1uCb0DX
 85Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030359; x=1708635159;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NKasSF8OfZq+DEY4uBwsa0q3Q/WOr5tzMGKZL1xqImg=;
 b=DiJ6YlbpJiB2vyUMthRp3o8GK3POR3MEdPDhe2PPU3cjfG5QcrjCqwr2gZGCnKsY20
 nf/yBf6I+UDKOpBKip4rI8oewunYUcAWZ4IV3aKuRjux5lGuvCjwrp4Qyljpv7+ezNRk
 cgng/846zJqmDi5XobBF2V25udvpcmuNT32esyv72y7bReELYN2tts5mYpVEujoWlyqv
 daiVIHFza2Wpa6pXf3bY+ZvZRUvrH4OZg/u6boWNajEIEUbHHuQiMLdwKN1VC1m9r6Ur
 /Vxp0ZQBXBgt7gPa6zUKxG6nzReIdt9NRmzPfto2pgfZsBF2KLiexFTCiKFb3ZSmk4tK
 Sugw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+GoX2YRBtngwbkpVrvSB6sRYwuQrP7HxOr7Z+aqyNSLSBByHfA4pGg1aBQKSxaJoVctO6TbYbKh/OfPh1f/qVyd1UtA==
X-Gm-Message-State: AOJu0Yz/sVMpXr/mkxY0wgZAibuo2pFucfaax913kYiEqy56hKBv8h5g
 KfeJj0eq5nPOoZo1sgLAcfFwR8rp2iB4r/7gCOwAM1e9aoDf3OE7cv/UhlO+5IDhovLFcLfNX8O
 0
X-Google-Smtp-Source: AGHT+IH0kRH8heA8cUTMeBbdlW8EIB8KIKcH/fVW0GRdPQwB8b54xl6Yz+zoqx15JYz7ExxAbekjxQ==
X-Received: by 2002:a5d:58cf:0:b0:33b:3b86:b845 with SMTP id
 o15-20020a5d58cf000000b0033b3b86b845mr1739666wrf.58.1708030359751; 
 Thu, 15 Feb 2024 12:52:39 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:39 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:33 +0000
Subject: [PATCH v4 15/39] pinctrl: qcom: apq8016: init pre-reloaction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-15-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=949;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=GAaiqNbWVYur2JUrdOHiHlFIXvgQ05KnAxYmIZN9LvM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzla3bDwe/PWgdYekdddnj574jb40XbFnkp6BrY8zux
 CVmmvG9o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAExkSxXDX7m+oOotPcys0UE/
 2q5/lTmqJhiVt8H6lD/nUxfjsuz/Mxn+h/5QnBtxtr605ILn2Y7+ZpHuMNnUd4xvZhyeFB4vJrB
 5PQA=
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
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-apq8016.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
index 10796710ba7a..df5bd1c19f6e 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
@@ -73,4 +73,5 @@ U_BOOT_DRIVER(pinctrl_apq8016) = {
 	.of_match	= msm_pinctrl_ids,
 	.ops		= &msm_pinctrl_ops,
 	.bind		= msm_pinctrl_bind,
+	.flags		= DM_FLAG_PRE_RELOC,
 };

-- 
2.43.1

