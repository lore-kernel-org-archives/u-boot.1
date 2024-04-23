Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C5CC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2243885CA;
	Tue, 23 Apr 2024 13:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X/4M0XdG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D26CD885AB; Tue, 23 Apr 2024 13:43:24 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E47208859A
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a44f2d894b7so535198966b.1
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 04:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713872602; x=1714477402; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TVZbiZXwW1lJA0ABqkZ7Oro6rzMOm/4ns4cIoN4R4ig=;
 b=X/4M0XdGYOmgYrvEowCMIo0SII97jEFZK55k2mAZJc0dvT5k1v+HxbJ4lrU5YEpm6Q
 Z4ZpLn3/HeSdpfOQTESALKlbwW4JfDl9fuDU8oFlxmklKydAjuq1/BrnYSWypyUnSyeG
 pqADIugxTlIOheBYSW9JehZiTURrabliN5AV4Mn1McX5DUAYkw1LyIJjzT+/hCPXF6xj
 YfkngxuX9f6KLJSqRRxYahpyGmUhVfUtey1ca539gmCPxkimNQHE2xqHCXRV+MfyoG8d
 LRNVFNg1wCR6YdiuI5A22q+cXdm+a/grrwnrGoo3Lfd3c1UBkgD5D1lA+q1dwDtu356D
 5F0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713872602; x=1714477402;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TVZbiZXwW1lJA0ABqkZ7Oro6rzMOm/4ns4cIoN4R4ig=;
 b=MMVxdvU1A4mDISdzTbnXWohtnQJADqMaMURtAymVzHMK0Txcauiq3PxHFwgKwrpLOW
 mLk6TNf07oOhztUd09dSCB5YxCQkKdCwHIat9/NBOElKxCk4Lx84ujzy/OzSuDV4hlYH
 FcPu1eJN5foP9hf5smmuo5rmVQ/P7mm+q4f67mybc6uOqJlpyxrmxUMtDs6XLS/y+Zb/
 P5OKHhsxBb/9+h08P1+WNCpzaBaVfh8Yj20IAb95WtPp95IjM62Nr3FCZp+cjYeQnCeX
 +06XQyA+xDzuVCD/jjiHMkUl6jAlxaYbVPoV5TtNXUvRBl1J8QFFLChctPKmbn7PKV4i
 t+Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcxoO3mMGikTs/vm+GvAVZcKdwSw7qI7EZtzkXXIPbbZmqvXZrZc2qJp319DK24n3KeUIDi21y+b40VdZhaxE1mc4QAQ==
X-Gm-Message-State: AOJu0YzIs+cRYJ79LysNiGiPHnu1lUEknI9hcXhQ8E11HFTOZ3Y52rOf
 7HV7RRmvg6S1CtV1zZxVXqSIq2s0JCX3NbeYX+mgK7ulfcjFgrO9Q+vLHCFaL3Q=
X-Google-Smtp-Source: AGHT+IE3gp7ZyD1Ypi6PI12A5K3fRg0cp0mgMEy1pvv/hZzxsrhxTNUtvmeLDQdaNV97WeP5Z9snAw==
X-Received: by 2002:a17:906:a206:b0:a52:2c00:9850 with SMTP id
 r6-20020a170906a20600b00a522c009850mr9020300ejy.59.1713872602468; 
 Tue, 23 Apr 2024 04:43:22 -0700 (PDT)
Received: from [192.168.0.114] ([2a02:8109:aa0d:be00::1795])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170906164400b00a55967a9038sm4507528ejd.95.2024.04.23.04.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 04:43:21 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
References: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
Subject: Re: [PATCH 0/9] qcom: RBx fixes and USB support
Message-Id: <171387260164.2280908.4172759252961758741.b4-ty@linaro.org>
Date: Tue, 23 Apr 2024 13:43:21 +0200
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


On Thu, 18 Apr 2024 18:25:43 +0100, Caleb Connolly wrote:
> This series is a few loosely connected patches to get the RB1 and 2
> boards booting from USB with upstream U-Boot, and a few preperatory
> patches for rb5.
> 
> Unfortunately the RB5 board requires a regulator on the RPMh peripheral
> to be turned on for the USB VBUS rail. Support for this will be added in
> future patches.
> 
> [...]

Applied, thanks!

[1/9] gpio: qcom_pmic: add pm6125
      commit: 733f6d982099c639c0872ed535be9eede2765a2d
[2/9] gpio: qcom_pmic: add pm8150l
      commit: 8bf1eb9a2e1e68ee18db084f24e8961e655926c4
[3/9] iommu: qcom-smmu: add qcom generic compatible
      commit: 2bd5bcaf7d23fc6ad9b2caf351fdb0b1bf712999
[4/9] phy: qcom: snps-femto-v2: drop clocks
      commit: 82a99b3ab8f022656a13e6dffdac93f5b1bc1d54
[5/9] arm: dts: qrb4210-rb2-u-boot: add u-boot fixups
      commit: 956f6e4de48f5f6c549d403a9f6db78a8deef689
[6/9] mach-snapdragon: implement ft_board_setup() for USB role selection
      commit: e64503f1fcdfa4e836c192ab7d16075fda864d19
[7/9] qcom_defconfig: enable OF_BOARD_SETUP
      commit: 9050686c1b9d9d9ac03a3f685458ab5eb2969e15
[8/9] qcom_defconfig: define safe default SYS_LOAD_ADDR
      commit: 9861ebac77d46674243886136275aac1deb7f982
[9/9] qcom_defconfig: generate SMBIOS tables
      commit: d286220078505727c8c0baf9cd9c832a1fcad805

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

