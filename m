Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACD4D6A221
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 18:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0EBA89584;
	Thu, 14 Nov 2024 19:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wbk7Qp8n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 064AB8964B; Thu, 14 Nov 2024 19:05:53 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC993890FC
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 19:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9f1c590ecdso148138266b.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 10:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607550; x=1732212350; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=umO8Er80RkTv+fvTR7Kr30Gl+c6SRJNKjrOkzjCfa1Q=;
 b=wbk7Qp8n+tf7b1KjCKjCmNzu5WqNx4dxyYxMSdUYyUhsFn55VYf96zTi4ShfhE2z1j
 TTE9v7lWrnlqqnfpXZ5lsNJ7BZDU42nmag0sUSOX6lkScNpuicOcbmF0JvIrbTskI+ZQ
 J+A0GJdfILXwrriqKqxhvle3qXe/d025McIqZ4n52KEa7TLejHD3nHwmA/cdk3NQ7ig/
 QuyIaGk+V4R0+eVj0caImL1mLhWJ/xG9ulChVLoSytMiLBxZnPj8ZZiUCUezPH12kuSB
 UaECWqe2KYYnUSqrp5werc9XaQKTOeJZLrWd3x0AeeOfBlHHwiyUbxLU4qhzkypv/PuC
 zFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607550; x=1732212350;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=umO8Er80RkTv+fvTR7Kr30Gl+c6SRJNKjrOkzjCfa1Q=;
 b=ERWKYtEpkPfzVnfrkbTyvnaOxmdtfr0oBbEWKp0uzX2MOlJx2IqTrn/T9Q4envXEDN
 QhoWi1Uam7RBuytRuR2VWOne8geQaiPZDI1VtbvA+PpnPCK1NQiUffTMuzR6XpBtI5Fi
 x4KHdIXHXi7iBhffiRq0H9hrF+WitQ8jZFD8RLeb6ELgHy1Hvbhat3cbY+2vou8/USOm
 8aFb9HwnSntpI+kOv2VWGvZHPR2sarGn6I52okl6AYyFlJQHAANRNwOoyXWPwDvCHrOX
 xlwlvXr4MQ0ddD8lqMxVj7zjk+NRn2/2lkXZN9AAkGOed1aiFZpqAlNYRI4ndoIXFKld
 AF6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7xR5iYsFtXSQc5PrZ68r4EZyYYZ/3wVsKx6SaibpkRJhuhljaoG579I/aNKtLOyJPChz3tr0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy33vDzQESBRVXA4XqsZHairbpKlxUszvPUyqEYeQVx9czhXKeD
 shSnpd8aG6OrLPsbaQEdXTNqQFwSFyaWOxVOsrvdiOKnUXiUsuB0zfvpEmd1HyI=
X-Google-Smtp-Source: AGHT+IEo+YOUhLJzczGi4F2a6qeaEsi0S/jXREL4S4y3qp9Ws74JZxIQU/of24blqRiouVdB4koOgw==
X-Received: by 2002:a17:906:4783:b0:a9a:533b:56e3 with SMTP id
 a640c23a62f3a-aa1f8076dacmr766578066b.26.1731607550211; 
 Thu, 14 Nov 2024 10:05:50 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df26a40sm87283066b.4.2024.11.14.10.05.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:05:49 -0800 (PST)
Message-ID: <46b5f2c5-efbd-41b1-bd93-2f1ecc81eea4@linaro.org>
Date: Thu, 14 Nov 2024 19:05:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: don't print 'MMC:' if there are no MMC devices
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 u-boot@lists.denx.de
References: <20241113053023.1870736-1-caleb.connolly@linaro.org>
 <20241113142437.GM3600562@bill-the-cat>
 <5fb2f6ab-c47d-4ea0-83bf-a14d8e737cb1@linaro.org>
 <20241114180244.GK3600562@bill-the-cat>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241114180244.GK3600562@bill-the-cat>
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

Hi Tom,

On 14/11/2024 19:02, Tom Rini wrote:
> On Wed, Nov 13, 2024 at 03:47:16PM +0100, Caleb Connolly wrote:
>>
>>
>> On 13/11/2024 15:24, Tom Rini wrote:
>>> On Wed, Nov 13, 2024 at 06:30:08AM +0100, Caleb Connolly wrote:
>>>
>>>> It may be the case that MMC support is enabled even though the board
>>>> we're booting on doesn't have any MMC devices. Move the print over to
>>>> the print_mmc_devices() function where we can only print it if we
>>>> actually have MMC devices.
>>>>
>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>
>>> I'm not sure I like this. What we do / don't find on startup is part of
>>> the not-exactly-API. It's true that if we don't print an MMC line at
>>> all, and we should have MMC, the user (and any scripts that parse
>>> console output) but now we're also increasing the code size a little bit
>>> too. I can be convinced this is a good idea, but I'm not there yet.
>>
>> Hmm, fair enough. I'll offer some more context, maybe there's a smarter
>> approach here I'm not seeing.
>>
>> The main place this shows up is on Qualcomm boards. Since all Qualcomm
>> armv8 targets are supported with qcom_defconfig (just by adjusting which
>> DTB is used), we can't know at build time whether the board has MMC.
>>
>> I guess my thinking behind this patch comes from a bigger picture desire
>> to get UFS and MMC more aligned. The number of devices with UFS is
>> definitely going up, and I would argue that U-Boot's inconsistent
>> treatment of these two storage classes (obviously a result of their
>> relative age and support in the codebase) is really unintuitive and
>> weird for users (nevermind that the "scsi" command is used for UFS
>> devices, cute though it is).
>>
>> I'm really wary to open this whole can of worms, since I guess it would
>> require some larger efforts and collaboration to fix. But maybe this
>> patch (or one like it) would be better suited in the context of some
>> larger effort to unify storage backends?
> 
> I get it now, thanks. And yeah, this is part of our inconsistency in
> printing information. I'd rather leave things alone here (assuming the
> MMC: printout is reasonable in the case of no devices, similar to how
> the Net: printout is reasonable in that case) and wait for a longer term
> / high level solution wherein for example as we go down the device tree
> we give some consistent level of information for everything (and more or
> less info depending on verbosity configured perhaps).
> 

Thanks for taking a look. Something like what you're suggesting sounds
good to me, and I agree it's fine to leave things as-is until we have
such a plan.

Kind regards,

-- 
// Caleb (they/them)

