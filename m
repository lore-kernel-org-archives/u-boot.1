Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D3CC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E17E885B7;
	Tue, 23 Apr 2024 13:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tKgmWKdK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05BBD885B3; Tue, 23 Apr 2024 13:43:27 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09C938859C
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-516ef30b16eso6888557e87.3
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713872603; x=1714477403; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MKl3+6qXx8hrF1FjZqOOqk56Oh7+QJiVs9ShEjnC91U=;
 b=tKgmWKdKmG5cBOutnE5fgpmjHjYK1XQLWWoR3mrTX7Zn2s+mvK6XQBB+5vJ5ru2jO+
 1reYwQYOK4sHqJeRHg78VnZpY6CwIuHmDSYWiZb+IYTuCiRkVszc4nGla05J9lAzo+kc
 +p1hXvQ7E8QNv5UgpOZSRi2qT7UJQEDw50k4gFPel8zXcCtPHYslG7JIP8tmdrkTmN9d
 OSLFBRIYluoGfoQeAl28cXbyhSvIcKRb8izlQ/IeXpMBoZNFHXvruTpT6Mqmf0TuD5mY
 r18g/8Gb980i5aZCGgeWlfZHi21Rvr88P5JJ64cJluZ+JAAsnVR6w3IAXiypRhQxu0T9
 U/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713872603; x=1714477403;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MKl3+6qXx8hrF1FjZqOOqk56Oh7+QJiVs9ShEjnC91U=;
 b=E/UmRLL+ezH6wrJA69JwDOw1srE31LSwCLBJR2vAyrsvwBETXZT2oxVYtqn/bN+Bn9
 j1TJDnErDmVcenU4qt/Yh5+9OyjnHg7hdLdvTc97DXSq8+zRi+PfXEkFQsPrXu1nDxAH
 Q8DAbMgvgqqikOh2EyOeE2M0nsrINAXyn1Rf/lfO1p8zcfHIyP/zjsYjzqGSEuJC0bs2
 RRrMwkGF77IGbe9Fs4yESu05RC5P/gpKbIvyqaW89mpgHI3r5kFBeNf8/ZmXiv1XGhpg
 l5ycdh7TZChRT71TEkPmRCmFAUW3MnprVAbMCDBIDE7ttDX8aoAPASk7GXosRmU6wgzH
 Wu4w==
X-Gm-Message-State: AOJu0YxrCrqwkCIOFZTcMvx790PF1bsOFgQNMj6K4NedV8yQW+FqmYNy
 U/g5myPQQ26l0Ky775rnMdZkPNtBv89KJf7ve0CjY+Vah0tfKG2xNsGnlc8I3e8=
X-Google-Smtp-Source: AGHT+IFQx7zR49aeeUe7d8O75wjhk5TwudF5qhU+5yB69buKhUeXEa72DjehAoKqPMlONx9Q6gsajQ==
X-Received: by 2002:a05:6512:3e9:b0:518:ef66:b797 with SMTP id
 n9-20020a05651203e900b00518ef66b797mr6360342lfq.1.1713872603265; 
 Tue, 23 Apr 2024 04:43:23 -0700 (PDT)
Received: from [192.168.0.114] ([2a02:8109:aa0d:be00::1795])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170906164400b00a55967a9038sm4507528ejd.95.2024.04.23.04.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 04:43:22 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240422-topic-sm8x50-i2c-v2-0-f9ad61c33b07@linaro.org>
References: <20240422-topic-sm8x50-i2c-v2-0-f9ad61c33b07@linaro.org>
Subject: Re: [PATCH v2 0/2] i2c: Add support for Qualcomm Generic Interface
 (GENI) I2C controller
Message-Id: <171387260254.2280908.3755821257633373339.b4-ty@linaro.org>
Date: Tue, 23 Apr 2024 13:43:22 +0200
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


On Mon, 22 Apr 2024 11:33:51 +0200, Neil Armstrong wrote:
> Add Support for the Qualcomm Generic Interface (GENI) I2C interface
> found on newer Qualcomm SoCs.
> 
> The Generic Interface (GENI) is a firmware based Qualcomm Universal
> Peripherals (QUP) Serial Engine (SE) Wrapper which can support multiple
> bus protocols depending on the firmware type loaded at early boot time
> based on system configuration.
> 
> [...]

Applied, thanks!

[1/2] i2c: Add support for Qualcomm Generic Interface (GENI) I2C controller
      commit: 75db9ede12d06693a3ced8c901b74065a1922a23
[2/2] configs: qcom_defconfig: enable GENI I2C Driver
      commit: ad12acd7a8f5aeea5816d5c2fc37c205c403eee0

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

