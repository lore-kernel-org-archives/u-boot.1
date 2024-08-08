Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCE7C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 13:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD2988AE3;
	Thu,  8 Aug 2024 15:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B/6YIbUA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9792C88AF9; Thu,  8 Aug 2024 15:15:54 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BB0A88AAE
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 15:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52f04b4abdcso1272531e87.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723122944; x=1723727744; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5UkkAqbun4lM+EHr6Jo848ti9g4BjmL6W4OEm8dGdxY=;
 b=B/6YIbUAzZeWcSaArSttUdWG4IOsb2bvOjqEXOppb5ALFqPP9mdnXdK6wL08WKsulm
 BBlECSH2QIjMvM+HS1VP04WHlqCNKjk4xnXOaj+w5JWRx/1hCUaYh+8xF9kgjr73FxbZ
 jx6OmMq80xh3U738hDMUa98+sYUKMgdDpbmBMtz9ugfASeS5dfAGVEZ+m+CDLUPHqBYJ
 Mgdqb1Q2jY30EYDHpVhe1NOG3MPzS6Q2Yfw2+5b4FxUYKEJC71fxXFNP30RL15wD7Ocy
 azUtojRJqo4iv4fWG7qJLkbQZMjwHy2MSZ+0IQbsrjdCFTeBBP6dFzNZCFC//7+/gf41
 c/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723122944; x=1723727744;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5UkkAqbun4lM+EHr6Jo848ti9g4BjmL6W4OEm8dGdxY=;
 b=gmmoT7PV4l4/Uw5Xjm3C8Knf/064RZRN+2aSQy4hWbmHQWJxj7/Thb18iLwLa/q92A
 O3aeVA0nt+ayXZjrz/aFi6ZcbZWaQeE0iD3o4AfbcaF5WzKR8Qtgqo1MDJ2aSl45hRSa
 mGYVtkMyDrW5npstsxPZLa3zo8KLXoUjMzw8eq0EEFN7M7IQOts769O/kbQCfWroB0Yd
 HTNk+aMeaPKHMRieAikDmjrSgBYDMR7mm+OSRqMpV0TuzqSVnwzfhKYC3en25oPuo2wr
 9n4jfSGhRrCb43FH3ByGoiP4lZU6BjrE2g5OCK/qwX7+MUMiJX7DFt0TrWctqyWNxcd5
 hOhA==
X-Gm-Message-State: AOJu0Yzo2WSddsi8X6/2igp47jh+lJoVX83yzOL9jFKO0X6qCaDgzVXt
 2KbS4XH5isQBoTVhJwo6xVVrFVhN83459STTD4jQsA0APXhOw4Kh39yy43i+L34=
X-Google-Smtp-Source: AGHT+IEeAC5etC93/ZZovA+wi8tyf85HOjIdvTQOiDt3U4C+iSO99x/irPrc2ZMQ+riHiQe2lRpkyw==
X-Received: by 2002:a05:6512:3d8f:b0:52e:9a91:bba3 with SMTP id
 2adb3069b0e04-530e5825822mr1426118e87.15.1723122943554; 
 Thu, 08 Aug 2024 06:15:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:76c8:eeba:d244:1830?
 ([2a01:e0a:3cb:7bb0:76c8:eeba:d244:1830])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9bc3bccsm748740866b.16.2024.08.08.06.15.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 06:15:43 -0700 (PDT)
Message-ID: <d471db54-da50-4530-a41d-44b855e4db29@linaro.org>
Date: Thu, 8 Aug 2024 15:15:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 22/23] test/py: add HTTP (wget) test for the EFI loader
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
 <9b055b18f84755d775bf0cf4064e66801608839c.1723050310.git.jerome.forissier@linaro.org>
 <20240807175247.GG1626301@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240807175247.GG1626301@bill-the-cat>
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



On 8/7/24 19:52, Tom Rini wrote:
> On Wed, Aug 07, 2024 at 07:12:06PM +0200, Jerome Forissier wrote:
> 
>> Add a test to test_efi_loader.py similar to the TFTP test but for HTTP
>> with the wget command.
>>
>> Suggested-by: Tom Rini <trini@konsulko.com>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> [snip]
>> +@pytest.mark.buildconfigspec('of_control')
>> +@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
>> +def test_efi_helloworld_net_tftp(u_boot_console):
> 
> This should also depend on cmd_tftpboot (existing bug).

Patch added to v9.
 
>> +    """Run the helloworld.efi binary via TFTP.
>> +
>> +    The helloworld.efi file is downloaded from the TFTP server and is executed
>> +    using the fallback device tree at $fdtcontroladdr.
>> +    """
>> +
>> +    do_test_efi_helloworld_net(u_boot_console, PROTO_TFTP);
>> +
>> +@pytest.mark.buildconfigspec('of_control')
>> +@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
>> +def test_efi_helloworld_net_http(u_boot_console):
> 
> Then this needs to depend on cmd_wget as well.

Right. Fixed in v9.

> Kicking my local build
> scripts to add wget and moving on...

Thanks for testing!

-- 
Jerome
 
