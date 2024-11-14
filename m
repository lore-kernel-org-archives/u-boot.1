Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D51D6A224
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 18:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B1228964E;
	Thu, 14 Nov 2024 19:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lm1RcqSB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FF098966D; Thu, 14 Nov 2024 19:13:40 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B4F48965A
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 19:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9ed7d8d4e0so132549066b.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 10:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731608014; x=1732212814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BmEx3XVW8IO1Qzzy6Z9VS6viU/cZuoymRce+mOCTzUw=;
 b=lm1RcqSBUYi7+Od8I8+FO+RyBOP0tY/Y5NHUxh630zvRYH16N7xOM/KWTtdtLQVWll
 NOL+fQnjZG5tRj0oH7R/QiDYmRI8Wizg6Z98n+Li2vTAFeK7m9ITtjG3XVqc7Qvy4KVT
 ei6+B2yLmZ+mstnPCCFHewZ6glX9m7FNCx3f8E/IgwqzIG9QwhmShHBAYh5IWCN94565
 rcptca1104MA9Liuy3jcGcxs9a+4QqiWOuIn74eCU1TsrsSmBHYAxonLS28x+UdJI8TF
 Qe7odpUCyr75KBlH4Dua2MNu51A4fCYOH/uI5CPRfvdju1ZD/kvE4Z6sVT4bFTW3KUhp
 w3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731608014; x=1732212814;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BmEx3XVW8IO1Qzzy6Z9VS6viU/cZuoymRce+mOCTzUw=;
 b=ErMBhXXVU5uHaz8FeiI48yx6biwRxT7g3eKAeOQhA2HyiwiMilS4x/2wxm6GIsh87Y
 cJkjLwQmAU7a40ydEyGHkVr2+jpJFPv0+yQW1q37qtZ3dfaSZD2CcPO6+rhF5kY4Fy5u
 YIf9osIVGDVkWNo2K8gUcynQfzijGPZyIUAkGyjE5tjxqKuuVZPtxmtwalfN1pRuebSC
 rbaoH/FI9tUAZjD9sKlwFxE049WETVNjrXFbtkdz/ppxcxgbR6qXCQFmPnfOEWe7KTkp
 DMtFOC6t5mOdzE/HDerLeTjbxZ6hMRgq5SngeDdF9wcvYEES+tWFgoK+Kjulz2U+nKZE
 VXTg==
X-Gm-Message-State: AOJu0Yx0AUUUj0HHuaeNXAhyavJOko/PfPPKd4qaRHichZCxmLDgetLF
 /9USjFsD7cWz4RNYJNrJvwH6ybufBHLGhbqy1jp4eDqnO2F2ropwczFXJvx9WaY066X82ZHBr1u
 J
X-Google-Smtp-Source: AGHT+IGFyNa8Ap1kr9qANWwUnAogRF7X/mLeMv3yeIU6Of1egPoz0QX05GBtYYvuf2sqZDEZ90cTVA==
X-Received: by 2002:a17:907:2d8a:b0:a99:61d1:348f with SMTP id
 a640c23a62f3a-aa20cdfa633mr315961766b.52.1731608013742; 
 Thu, 14 Nov 2024 10:13:33 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e0860d5sm89590366b.186.2024.11.14.10.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 10:13:31 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
In-Reply-To: <20241012132251.1840147-1-caleb.connolly@linaro.org>
References: <20241012132251.1840147-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] phy: qcom: ufs: add sc7280
Message-Id: <173160801136.3344230.2625681767206232615.b4-ty@linaro.org>
Date: Thu, 14 Nov 2024 19:13:31 +0100
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


On Sat, 12 Oct 2024 15:22:05 +0200, Caleb Connolly wrote:
> Add configuration for the SC7280, copied from Linux 6.11
> 
> 

Applied, thanks!

[1/1] phy: qcom: ufs: add sc7280
      commit: 6a8be4e2924ab0a978d5175a8c28d92f014df19a

Best regards,
-- 
// Caleb (they/them)


