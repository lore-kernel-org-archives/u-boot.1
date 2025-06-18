Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C89AC7115B
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 07:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C992F82C8D;
	Wed, 18 Jun 2025 09:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x1qk8OCk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D19A582CE7; Wed, 18 Jun 2025 09:32:03 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA1AF82BCD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-606ddbda275so12846925a12.1
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 00:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750231921; x=1750836721; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uHfDQa3bP8nQLY3cJUu3Jme8/LWESzMCqgf2mZkmlLE=;
 b=x1qk8OCk9kchVaS1kId4sNgjREQAxkvPGODVAyh4/QuKF5vWyH1qjGypX5Elxqe7B2
 rxKVBzH/mHQR7H842SktKy3DRuu+XGbHUOEeVXOUHvgd4aeVFK7APK1/WYOg20zBCuU1
 K1EpoSFat2m1VZBJbYep+c7kVIr+losHXNl7HWq2+p1/mntw96oVD9dBT1pwFcmB+nFs
 /XJ0nIFL0LJ7u3cDGsxJ+tcQ27+gX51vr9YWq3PgH1xTNbd3Cn90zPe82Ujd/ebM+R8k
 tfAHB/SYW7oNA3aDuci/ulCD5nvf8Q6yvMTz35NLqC8IdlMLlGcUendKESgpkWEdBtpA
 1R5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750231921; x=1750836721;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uHfDQa3bP8nQLY3cJUu3Jme8/LWESzMCqgf2mZkmlLE=;
 b=cMOWg97Rmq8esBNHG3N2Z7Q+s5ZxpKHPUC8jHT+I/2YXH9K3daZhavDkkeFcuUnVZc
 XM1eKcHC1Q1JKvFGIDxOICWiPh8E/lWI01j1nWPcvK8gYPbU8TRjyIU9heg+bDnfGpkz
 rxxcII+UqIc1iDPilt1CPdvechHWEH1TbwRr8sYkvGFcvFxvJ9gbOTRxd8zq6oBsulEA
 SmRguxE/JBNI2nV6kGxmksykBYNCXo7O/UmQN+5xsZBCD2fXgk+xY6YfvbuxS2GWscsb
 Gj44i5Qvx4JUWGJX4tg+yCojU53AKNNU/q4IxpzWxQUd9Nyr3TMzf0s/3ztQtxfAQ7fy
 mBow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYPRIdiGEU/dKadUqZUVRBNmo4I8RaAjcNUIUUMxaVDKKh5noXVtY6qktHxGCxteV1xjDUkq8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1gqV2cIQvGkeDZwpzPZkFJtoVcaD03+vBt1itMjKJXnRSgn9v
 E1fiNrEllJR5FIoftto2U9b+LNkogUrdN/2G+gbeGdVxSfJj2aka5Rg3AyIMHapQmw4=
X-Gm-Gg: ASbGncuDLn/oSwMOusV+Cls4tZg0hOqy9LXJkrlX9xomdAZitOWQZgwbGcEuxIo2qBx
 HuO1866/U5wcP+jNQuKlZ2kPXsiR6PYUU097OTqc8SDY+rj9ppojvd/4ZIxgLsfSwEyO4pFzqWK
 WLtzBD2aWHWf4A097CGMhb2gj3WqzMwryfZcAMAdf5dbRHBYBFjYZUQo/kVJKLyaqxwrp2Ts+ac
 9rqEKFOkhr21xSo6GQAQ6dP4NcwAXvn96C/8jpGAYAAv48F42Bym+FkOCcuTWBMBUKlHgU6NB1t
 LULr/uhBM3IZ32zdnSEVkc8zI0mCjyvOj9bjWRL7C14GflalfJuk47g7QuE9l/EQ0zDOBg==
X-Google-Smtp-Source: AGHT+IGITfNSSAburckxJkfHz7HB5R0MATI95YppPLUdW885a5JY3ROkv96h2pPHMKFyESkqh1GZBQ==
X-Received: by 2002:a17:907:3d88:b0:adb:229a:f8bd with SMTP id
 a640c23a62f3a-adfad40c25bmr1697721666b.29.1750231921290; 
 Wed, 18 Jun 2025 00:32:01 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec88ff6a9sm985126666b.83.2025.06.18.00.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 00:32:00 -0700 (PDT)
Message-ID: <b77fdf58-7d94-43c9-967c-50d3c72a5b12@linaro.org>
Date: Wed, 18 Jun 2025 10:31:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] ARM: dts: at91: sam9x75_curiosity: add tweaks for
 sam9x75 curiosity board
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
 Lukasz Majewski <lukma@denx.de>, seanga2@gmail.com, sjg@chromium.org,
 Oliver.Gaskell@analog.com, malysagreg@gmail.com,
 nathan.morrison@timesys.com, mkorpershoek@kernel.org,
 robert.marko@sartura.hr, jerome.forissier@linaro.org,
 sebastian.reichel@collabora.com, duje.mihanovic@skole.hr,
 sumit.garg@kernel.org, patrice.chotard@foss.st.com,
 nicolas.ferre@microchip.com, u-boot@lists.denx.de
References: <20250603050556.80851-1-manikandan.m@microchip.com>
 <20250603050556.80851-8-manikandan.m@microchip.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250603050556.80851-8-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 6/3/25 08:05, Manikandan Muralidharan wrote:
> Since the SoC and board DT are already available in dts/upstream,
> add the difference from upstream DTS to at91-sam9x75_curiosity-u-boot.dtsi
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
