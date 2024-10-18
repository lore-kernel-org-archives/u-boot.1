Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D623ED2FFFD
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 12:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6420388FBA;
	Fri, 18 Oct 2024 14:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GOPErolz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7D4389234; Fri, 18 Oct 2024 07:37:23 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0DBF891A5
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcin.juszkiewicz@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539f2b95775so2147685e87.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 22:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729229841; x=1729834641; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ef06defWPeH8/E6dpYVJZrG12Sz35+9mfebKTF8W2T0=;
 b=GOPErolzwDWfm/8EVnjn0nb0NE5VhA/9DG4zwjdI/EcCbc0fkquAFS+neuiVWafimF
 2PGs5KtldQOSmG/R+J6mu6/lEO4bmc0OTzpTx6znfnhgOII8mTjpjj3cwh0HmQ/wBukT
 PA0QnBpXcfav7XvD/1o1WwmcDJm+aMEgIXoiWp/wViFutCTW/WeZIub+IxUU/8M5E6MX
 Ra+CiDpV/rXcoqXHrbJ3eR5o3ngzFR4yQ5VQwVOd2i/17yzTBBL1ulOsL7mUXXKBP0aE
 ryV9Hr7AsmcD+ljqSbcBUjSqOr288ZBmne5Ay7i89zUPEwHcJ9RXzifSUePDBiP0ypcx
 6pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729229841; x=1729834641;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ef06defWPeH8/E6dpYVJZrG12Sz35+9mfebKTF8W2T0=;
 b=b+jO7F0dCGL/VYBSMycN3wgEL7BwFd5oafxab+XvOKBAYBZbNVahbogoHWbZUnQkm8
 9c8/uo61lkZBMmtPIJZLquaUnofFJ/jy3NMXlrei5Ksd5Gr21Cy6ypqEfIuMCaVKqiE/
 EInfr7aGEua3elmVJBKlm06cwooJ79kFlziwWirIEQXra3yqVIxrCYD2D0+Zt+wPn3kb
 HQu09kh9rK9L1/BYU35TWpGQ25uVzWQ6oGod9FtLM1QkDxItTk4pfOJ+kcG0AyaFsyC9
 pkiUExl5iywtKNDPh6v0BjtVYvKBDImkeYvHD9q7JyMWhh34cgvmrwwupgp0ekY27T+V
 JCFQ==
X-Gm-Message-State: AOJu0Yx+cJavoDUnHHFtEF+aXEhkUp/W3RNs+vpUJ61f4ArYQOvZdnQU
 Y30FwLsEWhiq3gScG79WZLTxOFdnYqx1iZhlv5zdm9KwzQHWBJhL5ELPtLAN4Tv2aWOJ/gedH0P
 BKyw=
X-Google-Smtp-Source: AGHT+IFgm6uVIpO8btEjCkrkVpJac+YpAFoRU4TgIKaxCEWotUERO+XUd92ws21ULPHi9foPm90atA==
X-Received: by 2002:a05:6512:104c:b0:52e:fa5f:b6a7 with SMTP id
 2adb3069b0e04-53a154443e2mr990804e87.13.1729229840709; 
 Thu, 17 Oct 2024 22:37:20 -0700 (PDT)
Received: from [192.168.210.26] (83.11.13.124.ipv4.supernova.orange.pl.
 [83.11.13.124]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53a151b00cfsm124887e87.1.2024.10.17.22.37.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 22:37:20 -0700 (PDT)
Message-ID: <d6715dbe-82d9-4b45-a73b-6f64364a6dca@linaro.org>
Date: Fri, 18 Oct 2024 07:37:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] rockchip: Add support for FriendlyElec NanoPC-T6 LTS
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 John Clark <inindev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241017200039.1235524-1-jonas@kwiboo.se>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <20241017200039.1235524-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Oct 2024 14:32:49 +0200
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

W dniu 17.10.2024 o 22:00, Jonas Karlman pisze:

> Finally board specific code is added to help detect non-LTS vs LTS
> variant at runtime and nanopc-t6-rk3588_defconfig is extended to enable
> Kconfig options for updated DTs.
> 
> Please note that this has only been runtime tested on a non-LTS variant
> of a NanoPC-T6 board.

As owner of NanoPC-T6 LTS variant I report that it detects it properly:

U-Boot 2024.10-01079-g096e83da0bc7 (Oct 18 2024 - 07:31:07 +0200)

Model: FriendlyElec NanoPC-T6 LTS
DRAM:  16 GiB
PMIC:  RK806 (on=0x10, off=0x00)
Core:  375 devices, 33 uclasses, devicetree: separate
MMC:   mmc@fe2c0000: 1, mmc@fe2e0000: 0
Loading Environment from nowhere... OK
In:    serial@feb50000
Out:   serial@feb50000
Err:   serial@feb50000
Model: FriendlyElec NanoPC-T6 LTS
Net:   No ethernet found.
Hit any key to stop autoboot:  0
=>

Tested-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
