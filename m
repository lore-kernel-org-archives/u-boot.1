Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9708C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 14:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24987807EE;
	Wed, 26 Feb 2025 15:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oIKW4v9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DAE3805C3; Wed, 26 Feb 2025 15:49:48 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B61A5805C3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 15:49:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43aac0390e8so22123525e9.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 06:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740581349; x=1741186149; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s6SIwsEg73sx5kR4FlJxXMzn81SnS35hH+Qv8llsulA=;
 b=oIKW4v9NoOd+4DBPE8YYXU0ZQi0VIrm9FvPq+IEKV4iTZiVWERsy6TeR1RG8Omh+36
 DwspSmgf/L+z+puDCn1roupDkUf0Gyl/rJQL0vgSkZuFK3YckSIFuR2QRkpMFy1ZYvkZ
 m/N58DZRyCW1MqGhIzREySiHhr8BsbpC0KV5LVTl8wxAy1pSJkRPhi8q93S+xZSxSDYF
 RuOERUaJ0KO3OqB8TB22sftlDX40dlffYUPhSdtF0zG51IwStW2ALLK6QDazUMjA4Snb
 at10i2NUblncH7ri03rZtQQzVnj4SfQIPp6NSPBmdyZZ58e0XboUXBbW6hxKPu0sYdOC
 HLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740581349; x=1741186149;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s6SIwsEg73sx5kR4FlJxXMzn81SnS35hH+Qv8llsulA=;
 b=YORnQgAK2p0zQqZz599g4l/qKZ/YgLVQztLKVdNXtJ4lsPqWDmbNDOVhjVIhsClYs+
 oelfdlOsSL1+o3MgpSxi2uB3YMpn/Q5HLPqSdbxLPwjJk3Ew8JJI6AAG7o92b/mfuOMw
 rzjDpLdQqyNlx0aGmKlSr1h68rldZX/70oY/Z8ZUa4BRPourVKRTDkfDKX67FXUgTwJN
 2Fp3vMS6R6//cP2PQ20TyU/boowapPIKoPgr/RsCo3sNN2UID1yJDJi4YXUqhYjxcfp8
 4WDurFkYq4nUXBuyC3MyXMZD7Yy3lpl89fULR4XfzVkp3zndvnYZ3/8FET4tV8O/AkC8
 R8uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzIxK1F9lXMz8aEuWg9bEMisUZ3M/8DapHEZs2DCFuwWCFifPkdd98cfGHkd1sJ01MKDDfTGI=@lists.denx.de
X-Gm-Message-State: AOJu0YxY1GNY40otIF4JOYIBtLdty6Jjk4Ohxcu60TYWpEl5CR8o+TA8
 WXRf9Rxi5SayhQCTpOqiZktiVsmxP6xsMhvl+1Zor1XQsA2uMCc7Gut+Z2Gw3sU=
X-Gm-Gg: ASbGncuoTcs/J8PxQstXyu66YGnDMOYN9z8inG9EasebJqoYK4wJHJswJz+kvtgZy1X
 M62DDuWSKKIv1WqBysvBQ14TBOHSDcAZnkqPrC3hoRf4+HtP4gl31nOfZ3evXDYicCV/Y9xCMxC
 YNsb8IaUaXOTq3GhjBsMANxFktBhtNAeJvbc8dYqUnt8YO8DsjFUzGG2J1JUVthzfpAIwpS+QGL
 6Txt9Dah0/L2DrENvhdlVoj9buwr2Y6AmlLrrsYwDjCURCJkVlpfGSXnVLhwqDgsLCF/fLhCysG
 U5TMExt+rgFZImFBdilu1G5T7DiblWIEzyRmjPlY42clUEF4PU0Y0ctRbQf8Lx2Up3bN5IGcPM3
 Sxu2ZVd4=
X-Google-Smtp-Source: AGHT+IEj0FHdT3EM3ER9nl4u3QQ6qs/mQMic5vKlZwe537NnPGwhacWQ5GYMbbOu26rSL7m/8HZibw==
X-Received: by 2002:a05:600c:5103:b0:439:9377:fa17 with SMTP id
 5b1f17b1804b1-43ab2ee3607mr63404035e9.18.1740581349091; 
 Wed, 26 Feb 2025 06:49:09 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:3b78:3dbb:221d:d3e2?
 ([2a0a:ef40:1d11:ab01:3b78:3dbb:221d:d3e2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5393e5sm23993165e9.20.2025.02.26.06.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 06:49:08 -0800 (PST)
Message-ID: <04598e2e-a9fe-4726-87ac-bda1c19e30c7@linaro.org>
Date: Wed, 26 Feb 2025 14:49:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL] Please pull qcom-fixes-2025.04-rc4
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Sam Day <me@samcday.com>
References: <20250226144531.41542-1-caleb.connolly@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250226144531.41542-1-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 2/26/25 14:34, Caleb Connolly wrote:
> Hi Tom,
> 
> Sorry this is a bit later than expected.
> 
> The clk_stub, regulator, and pinctrl fixes enable the sdcard on the RB5 dev
> board (and sm8250 devices broadly). clk_stub is only enabled in qcom_defconfig
> and the others are qcom specific so these shouldn't affect other platforms.
> 
> Lastly, a small ufetch fix from Sam which gets color rendering correctly on
> U-Boots framebuffer video device.
> 
> Kind regards,
> Caleb
> 
> The following changes since commit dc0ee458f1afae4cb5c8a7b2c875bb24ffdf71ca:
> 
>    Prepare v2025.04-rc3 (2025-02-24 16:53:59 -0600)
> 
> are available in the Git repository at:
> 
>    git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git tags/qcom-fixes-2025.04-rc4

The actual CI run is at 
https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/24841

Made the mistake of having a branch and tag with the same name.
> 
> for you to fetch changes up to 6267ce556595e0586aee3a7d63042d105dc3fa4e:
> 
>    cmd: ufetch: use 3-bit colour ANSI codes (2025-02-26 13:48:27 +0000)
> 
> ----------------------------------------------------------------
> Caleb Connolly (4):
>        clk: add stub clock driver
>        qcom_defconfig: enable stub clock
>        power: regulator: add additional supported LDOs for pm8150l
>        pinctrl: qcom: sm8250: fix pin count
> 
> Julius Lehmann (1):
>        clk: stub: add sm8150 compatible id
> 
> Sam Day (1):
>        cmd: ufetch: use 3-bit colour ANSI codes
> 
>   cmd/ufetch.c                                  |  4 +-
>   configs/qcom_defconfig                        |  1 +
>   drivers/clk/Kconfig                           |  7 +++
>   drivers/clk/Makefile                          |  1 +
>   drivers/clk/clk-stub.c                        | 67 +++++++++++++++++++++++++++
>   drivers/pinctrl/qcom/pinctrl-sm8250.c         |  2 +-
>   drivers/power/regulator/qcom-rpmh-regulator.c |  7 +++
>   7 files changed, 86 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/clk/clk-stub.c

-- 
Caleb (they/them)

