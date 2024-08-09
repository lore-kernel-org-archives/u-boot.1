Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A58C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 17:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A98D882F0;
	Fri,  9 Aug 2024 19:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GPdAU8ZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0345887D4; Fri,  9 Aug 2024 19:42:12 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D88388113
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 19:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=srinivas.kandagatla@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42817bee9e8so16915745e9.3
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723225330; x=1723830130; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VamUtaKsdnMO3Xj/IeNiDDarpPSNzAwlcfOY5Y0XulA=;
 b=GPdAU8ZJXZWVH8h9em65CCo5mhmIVD8u9b6Qdc2zIY61gQjsW+h9UjrgrDkS7ETfIL
 F5uvBnr6JoeeVExoagwcTprYI7sjB/fotK6GsAYZUYeT5CDy68xH1ZygrVVWEdmO0/Ik
 j3+JxCr6zTvrmY1SDk9B3gJVJG+JXLyFmanSvstQ/wm7UDI1YiXwAa+5FGEzidGMr0YA
 tC6D6Pa2EQNRru4uhGFTz3iEu/1qQO4FaApN4IKjS8y8T39XC5pPl3O0GK8kjh/USm9U
 uLphy96pSS/SjSUhCl2lntElrFc7Jy4UniXSYykVr3wD4RqVH7DNElyt3KYujemzNrpL
 a//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723225330; x=1723830130;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VamUtaKsdnMO3Xj/IeNiDDarpPSNzAwlcfOY5Y0XulA=;
 b=rdpbs+Mhlf8gqddeCYB+SPjf4JKPRURQusJvEWhwnHePl49NkUHUq6lHhRcgbOO3RE
 HtDVYNTQJiTS+5Qk3mS0YhQtrZqnjvSSWGXAhxBSevh9j553oGTFofDZfkoToxWCVbxq
 v8As1+/tKi9kVaDDI75ypbe5u8pOGmtDBmzmdRdcGW6URCOdGhlcE20snoaBHf1lBNjL
 Rfwelwr3ubrRYp0W1bIeHpDi3w/UgwXr9XT+NKJNri9odAp4yxjWt211JaY+WC/NhCda
 kG67WLKmhW4b062KSCNrcRqHTLh97nRoezyS3ExyBkJpWCWXBh4XVF1TZiJZCreMIcZF
 qoGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUghSOL8ujpi041roI465iYmfClNFNPUA7ZYmVQwV+AqeuaGPFsI81mA9jfDll9ZbjUP3QJj5g=@lists.denx.de
X-Gm-Message-State: AOJu0Yzu2vjZFmO/sW4AIdh76yPd4leptO3V6p5R2MUBTcjrop13qfBd
 Pz1cjz+7EEKvWuPXYeIa0czqFrSb0aSv1SyoWuHskpEG5rTwdj+fYXdK3vhXm8U=
X-Google-Smtp-Source: AGHT+IGx9DDT4b4iSnts3ZE5LnnsizuK3egrq2q0nfjCRLIg7gJH+YoQ/HeD8f5UDBhmZse6UJatjQ==
X-Received: by 2002:a05:600c:3b89:b0:426:62c5:4741 with SMTP id
 5b1f17b1804b1-429c3a18df4mr16561655e9.2.1723225330233; 
 Fri, 09 Aug 2024 10:42:10 -0700 (PDT)
Received: from [192.168.68.116] ([5.133.47.210])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c750ec0bsm1080765e9.15.2024.08.09.10.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 10:42:09 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michael Walle <michael@walle.cc>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
In-Reply-To: <20240808055710.19292-1-zajec5@gmail.com>
References: <20240808055710.19292-1-zajec5@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update path for U-Boot environment
 variables YAML
Message-Id: <172322532687.402259.7753078917073034445.b4-ty@linaro.org>
Date: Fri, 09 Aug 2024 18:42:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
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


On Thu, 08 Aug 2024 07:57:10 +0200, Rafał Miłecki wrote:
> This file was moved to the layouts/ subdirectory.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Update path for U-Boot environment variables YAML
      commit: f6d1cddd76b2da190462d84546e5202d3b2aa92b

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

