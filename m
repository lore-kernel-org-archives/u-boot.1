Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C737DC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 23:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C669885FA;
	Tue, 20 Aug 2024 01:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F52bRiwu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C11D885FA; Tue, 20 Aug 2024 01:03:22 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E9F488155
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 01:03:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a7a9cf7d3f3so625211766b.1
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724108599; x=1724713399; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ioh976rh3cgM2PWNLrqO15hk5kBjKu6zUdFW4HWWGAc=;
 b=F52bRiwu6fjMNGoqbcvB7k1LpauYGu6lSxWugvFTRZF+hlhKoG1qUu18nSrN8fg7/C
 6K5WdM7M5JpSEjXoVsm7yPpWhlObK8CrSB431bblrFEC9Y8hHvdTie1ur8F5OOCUFRBb
 FQtnGcex/6w0pwNmK3FFKZbh2t62ZEvETNaG3+gH97N54H0plOlPz9h/jAxo6ondgp02
 xE0mi5KJIJM4vJOpDbKAw2ZsyqbVNQm7m2sKwY2sh6ICbkx/5e1xCHDG3417kNckEFiQ
 b/9MBKu67mq4LFMFooMQ+WOP0gvXzAvjaLYa5XA5Sa1oHEqqWk+1QQsaaAPjl3HfPmIW
 dIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724108599; x=1724713399;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ioh976rh3cgM2PWNLrqO15hk5kBjKu6zUdFW4HWWGAc=;
 b=m2abNC+MdMnyswZwAs00KgyPmLR+PhjPDFYpLkEoEAPAIt72vZwLkrIQ9VGoIOfhG5
 /M6ZagaWlNv5uEsXVcjEc7osuVCQj4kiFdLc4RrVtENYv146YloFEtuFtNzeGPkrrmV6
 Krtvxl79FWIfxRHMtNej8aPnd//Y3CJ35t+aEtxAlVNr5G3JvdOuYA7RLdfMgYO6zxQ+
 R9RCPRKIYuSq5CxySG7UmV80sz4x0qO8S7Impgb03fe1TMixxlJPoTRb2KeFHRVo8JeN
 UKBfCXKyVRnQT99MnSGjDxDx/oTG5dfohTaT10cwOxq0sslT77aQnWvtQEtADzPU5GU8
 bmlA==
X-Gm-Message-State: AOJu0YxpEJeq79SCi0Og4Y6D6laYtkftPhJBVAcLw/ZpqHaf0lzJVwH9
 hAx3VW6H2gMLMsJvWVuLF9pCCQoiNnZb1I2G/92ntd4lTi0sgjDUWN/1TC2C6Og=
X-Google-Smtp-Source: AGHT+IF24jboCknnP0ynA3qCdD2mnPkIZq7K1ELOAWpLfTFXzdHFx/WkaOP1CgyUYhw9P5FDF4Bo4Q==
X-Received: by 2002:a17:906:d553:b0:a7a:a5ae:11b7 with SMTP id
 a640c23a62f3a-a8647b0b096mr30557266b.49.1724108599296; 
 Mon, 19 Aug 2024 16:03:19 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::676e? ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838c6a42sm684552466b.44.2024.08.19.16.03.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 16:03:18 -0700 (PDT)
Message-ID: <ffeb90f8-4f3b-4455-83db-d7b03b872c84@linaro.org>
Date: Tue, 20 Aug 2024 01:03:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] SMBIOS improvements
To: Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bin Meng
 <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <CAFLszTjE+8BmdmtFXER94LmEYshNDEA4x_MDTqvyGhHYed2OCw@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTjE+8BmdmtFXER94LmEYshNDEA4x_MDTqvyGhHYed2OCw@mail.gmail.com>
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

Hi Simon,

> As a general comment, this is adding a load of code which is used by a
> lot of platforms. As more and more aarch64 platforms are created, this
> data grows. Why not use the devicetree for this hardware information?
> That is what it is for.

This data does not belong in devicetree, the various system registers 
exist to describe this information... Putting it in DT would be 
duplicating it.

Using DT for this would additionally require having bindings accepted 
upstream and for all SoCs to add them. To what end?

That being said, it would maybe be good to know what the size diff is 
with this series before getting into the weeds.

> 
> Some of the information detected makes sense, such as cache setup, but
> some of it seems like an approximation, or is missing, but suggests it
> is authoritative.

Could you give some examples?

Kind regards,
> 
> Regards,
> Simon

-- 
// Caleb (they/them)
