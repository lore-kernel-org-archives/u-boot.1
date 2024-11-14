Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665D1D6A221
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 18:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 637FC8964F;
	Thu, 14 Nov 2024 19:13:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BiGamPTq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 011718964F; Thu, 14 Nov 2024 19:13:33 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1720B89652
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 19:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ff550d37a6so9838681fa.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 10:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731608004; x=1732212804; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tM0kYghE6LPxa9ihb7hxZybz5o2cn1ai88/YnwENIAg=;
 b=BiGamPTq3e4TvHDyYx07KWYSTRApuLd0CDo/z7wF9Q9OXHYCd/OES3RIvnuj8WV/re
 17kHjsr3arrfDJo3fCVOAfX0paACRvtfNAEPjFynS8DbC2fYZ/EBGp41LOs4x0NjTbDR
 xPFpNZVwqKrxcZZ4+EdvZeFKehoPPBwC24wcj0dFwuWmBBF9TnFm7tbVlfZnzQz/4Tcf
 mKpOweje3QZF/kTX+zQb9c1FpT0aKNKK6o47QpPSv6n5+4JK5EFvATTWo7iIIWO3igGt
 NaHwwoiWThrkQqy7RWINgydOXdbMj6h8ftKw8bWU7YXM9gJDCDNoDsNVXCTA3diIVn90
 UlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731608004; x=1732212804;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tM0kYghE6LPxa9ihb7hxZybz5o2cn1ai88/YnwENIAg=;
 b=eJ4Bu+M9xO7fAl0YxxZAk8HD6PzYJqo/PdwGs5LV20KWaeLwPdtmCeaXx3MhIRxG7/
 km0lSsPD5OFUWHu+79JBLB1NVXraFlYgKsdt2u1Fh53+IMS54Vv3dWBNa3Zr9v9psZ8Y
 zYMy6fRLQ2nHgxUUWfbtpc4UVw9h9DNbDEAA1Nhlgif4xOdkgAZZL3B5yaXcGvFP2RBk
 G8vKpGkXYQSezxZMxRCGXYHMPuv//re/tX0NBmmW0KIzK6xYYDuLMNU+5t+2HcWL36xo
 wUNiJWBrPp8Oi55LwWlRQiAciZpDIHQjgJLJkQ2xXYllSkiQA4aXcZ2B3tFrfkKWEIDo
 E3cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURmoCK5mtP5PrTfHTd06vnk9+wdCmK0eZoIVydc4RfoPGVrMo21SUqjHIT8GgR3vz5+8eFCIY=@lists.denx.de
X-Gm-Message-State: AOJu0YzXbtUZBKFKzVcSAqE5lD2OCSazoHn39Y5OeWJtZc8C74cTCiV+
 PV+wRHf/cfFSEQZy6AA3LnUeg5w1HN4FJ65589bfBnJFzzSm89zPfQrTwTZc7STOkXIGOpTPiLC
 g
X-Google-Smtp-Source: AGHT+IEPKT9KM2rVweI/lHCP7iCQVk/puaujuDlHle9QQCpal/U+/fHdMkEaSwYSDSdyUksABq2+Dg==
X-Received: by 2002:a2e:bc16:0:b0:2ff:55fb:e5f2 with SMTP id
 38308e7fff4ca-2ff6056f4d8mr554311fa.0.1731608004504; 
 Thu, 14 Nov 2024 10:13:24 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e0860d5sm89590366b.186.2024.11.14.10.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 10:13:23 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20241016-topic-sm8x50-qcom-pmic-re-add-quirk-v1-1-6d4917d9063f@linaro.org>
References: <20241016-topic-sm8x50-qcom-pmic-re-add-quirk-v1-1-6d4917d9063f@linaro.org>
Subject: Re: [PATCH] gpio: qcom_pmic: add again the quirk to skip GPIO
 configuration on PM8550
Message-Id: <173160800229.3344230.5009404315285010195.b4-ty@linaro.org>
Date: Thu, 14 Nov 2024 19:13:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Wed, 16 Oct 2024 11:16:18 +0200, Neil Armstrong wrote:
> The qcom_pmic code is broken for new PMICs and should be fixed,
> without the QUIRK the code is broken and the GPIOs don't work
> anymore on SM8550 and SM8650 platforms.
> 
> Partially revert the revert and only add the quirk on the PM8550
> PMIC, making the buttons and MMC detect gpio work again.
> 
> [...]

Applied, thanks!

[1/1] gpio: qcom_pmic: add again the quirk to skip GPIO configuration on PM8550
      commit: 1729a1988193eabcf6ac350923bbdfd32643a0c4

Best regards,
-- 
// Caleb (they/them)


