Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2C9C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 16:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4F0A80977;
	Wed, 22 Jan 2025 17:13:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z1BD0F20";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25B9B80A45; Wed, 22 Jan 2025 17:12:58 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2C91807EC
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 17:12:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaec61d0f65so1489566066b.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 08:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737562375; x=1738167175; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bR/n2vBI51q5LzOPI90sckKB2lcCOfN80S/SllDQrlM=;
 b=z1BD0F20whGMv3HY2vMZPmmmH9g7lQSF4/3Ssv7nWmSfnSL4xgDgKoQ9Og/VJDt9kD
 b4xmc98iNJERioUgpeTQ8OIHg2eghGEpRer5Vr1d3epJynFRxmf/1QGDzuZ6MBzQboDJ
 yoOCDVZCtzEjm5ou0Vou2u+n2seqjxDzxfgv2n8Ppqbs27otbJ34WDj/oAvLIHBQa76l
 YS14ZDuWuVG0dDu12lcpWbupvaq5oq5603MSksy7pnpcB4thEue0a4if0fF9fXkkeg8w
 +OkF6zvR8LUEEz627KaYliBJsTte3bFNQ1m6U7QfR+CB7lqreR5HMujZoyGsUL40mBEO
 A+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737562375; x=1738167175;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bR/n2vBI51q5LzOPI90sckKB2lcCOfN80S/SllDQrlM=;
 b=IEy7tf4UOYWT5ia5/Li4yLddz1ZBAEQCRfJFI1w0dGT9W+/0hVwrNvib8aDyPfSo8f
 1klvbVwSz9SuZZlwu3m68XDE5dxzd8SZmobQ6GLLZuNIGqEfIJJDG+7hJf1ideNHHB68
 vYy5xq3ydqXZ+T5K37yyXfMX/VCGTOgBI+NbT/39CE/4257ehFC5yAcbXnKMEDc4MUTS
 Q3wim4KSZ/8W+OyiB0xn7/3o1O/zD0h3vT8Tt3VEvQHdGIXMSK7fhHDR5po0LEWPKXiB
 z03a544YkU6z+GOnXjZzhAjJw9NCucKBEvsdL/rx8qKIX6Z9ZhkPfIMmR7R33mEkWV6j
 ATmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtEAdZf07hogiLPZVQVycIQ29h5gGY1UzTghiRUrAEIlBS9kdNI+OfF6MxHuR2FZ3tLIkfRCg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0/1AeyFG9+8PAbDa4l9Gz+U3XBOLpIAvGb3MJOsL+x7uE75zu
 mf1DeYRmFMu/inXeZ4zZLm43cTDNTe9ZYsrR4FBmMmYZa84KkuA5mhVJXRUl/IM=
X-Gm-Gg: ASbGncvgGMWvMb8zXjMIIpagdyjnhKzxZd5TLbEoxVScu7ZeDb6iyIXgiWm2MPnYTNz
 l8QZdZ4fvz5RyZDAJbp46XCZkNk6HHcYh+0ZQ65IPPU77qRqnJxHgmHB0BL00U4pPjrS6EdG6n7
 MW+XtP32DXLEqOaYBlwnanFcWHiz9rgF8VS0Hi7ZjRMCDCxymko5+X54lM4Hd3GYVdcnIeK0g67
 SkOfBILyc4kFs4Y2lsFfB/S4UJro1hVVGHYilW6vg5OGCSe1xWLBBphdV3SywmcqYb9Pj7KG/9c
 zE2AIYiNszyw
X-Google-Smtp-Source: AGHT+IGQ9G/vg7MeD4XagjQC9b3j37Ocd3HqPfpLf6vRCTiYwSn5nJZy4Zy3X8d8bS7jXsUpeUEHfA==
X-Received: by 2002:a17:907:1c95:b0:aae:8490:9429 with SMTP id
 a640c23a62f3a-ab38b1c4d26mr2237603966b.34.1737562375358; 
 Wed, 22 Jan 2025 08:12:55 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce105dsm924966866b.39.2025.01.22.08.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:12:54 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20241125-topic-hamoa-pmc8380-rpmh-regulators-v1-1-695c44ea8586@linaro.org>
References: <20241125-topic-hamoa-pmc8380-rpmh-regulators-v1-1-695c44ea8586@linaro.org>
Subject: Re: [PATCH] regulator: qcom-rpmh-regulator: add support for
 pmc8380 regulators
Message-Id: <173756237424.1864727.7121652422736141676.b4-ty@linaro.org>
Date: Wed, 22 Jan 2025 17:12:54 +0100
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


On Mon, 25 Nov 2024 09:24:47 +0100, Neil Armstrong wrote:
> Add the PMC8380 regulator data found on the Snapdragon X Elite platforms.
> The tables are imported from the Linux driver.
> 
> 

Applied, thanks!

[1/1] regulator: qcom-rpmh-regulator: add support for pmc8380 regulators
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/bc09b58e2ab2

Best regards,
-- 
// Caleb (they/them)


