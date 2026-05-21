Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19816CD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 15:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 611B4846FA;
	Thu, 21 May 2026 17:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O0z8T92b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9A2484705; Thu, 21 May 2026 17:32:42 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2133846F1
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 17:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso56388105e9.2
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779377559; x=1779982359; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=clR6Ake0J+ABjVidrsWoHEec2q1jGsihLnxgTJR3Cgw=;
 b=O0z8T92bsIi9y+gUY2IZO/WnrHRsE2meF0R5o44lQG7ifmoIuXJnCWiNS2D8Qia8n0
 l1msDORn8bdm8nl4n/iGW1FfS0BEq6FuW88hq/kIEvxlaal4Zl8w/4B1ooDuMkiyI2EF
 5cgBwgZaPL9cLnGdyJQQL0zxNiuq/SJI+nMyhSoq9kSrNydQIJaBsWZvGsrWInSZQtfn
 g7vcIvaYHrmCAgRXlcM/ejJY3bKDHSuWxXvlyxUSUzUcLCxebFgOrW1apbCA+75EIBID
 /iPnvXQIz7tSApPuxqvk4lfGpmG/7SzTiWQPk4wvYee0rbfwjXhz3KpWbGoLmqtJA0vS
 zDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779377559; x=1779982359;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=clR6Ake0J+ABjVidrsWoHEec2q1jGsihLnxgTJR3Cgw=;
 b=XqqkXZAXZeVwClCJgsfwWNcPLMQe8W+yc1agmrfbIrOiFPmfQ+xifBS9J+BcSJE7P8
 6uo1opVTNR1NL3PMCMK3BUS5FXEh5X740ZQ5TcCbysBH47MInCp+8N0YhcLjtNTQCbIY
 WKYagjDR+ekC+sNskxbqqHj2v3qhTimTaaZkMq8SXQVfw9+SEXjL68/G441SSjA/miHj
 Doh8so1ybUWqFx/f1Or7FBmTJBv0+OpDbLTTBClhTrQCjvcGqZIB1OF9a2dyhoHhgDLG
 jtzTNeUwJIFmrL/wG7QjyhdF4p0XlVZtd/xhYyEc5xq1u2xFHNCMzV0ac3HvkCeZcjJp
 u7HA==
X-Gm-Message-State: AOJu0YxtXz7q7x4kTqgcXpRi+igRbEwXSrWJOXMsPCB2or5D36eDWV4Y
 Mv3NILhEcrUjhQVfUhvokSVuJaTuKLDYWJLCCs1XkLqgIVGeol97yX+dn4Ouu1pzekM=
X-Gm-Gg: Acq92OFNhQLG68jCGZX/tw3R36ulkwcAGIwM1ivV5cjr78zQhLvRGDKS/FvglqK6FwM
 ROaRqcGZvK2rRKBZrwqPrbbtcP/HvBlIIKT4ytH8F8JorB+0DQyFF3ZbfI8H4bIIGjBv9++Zmge
 9cKKYOa45dj+SfJnAu31YmFQCsZulmIAZBx1hrG9PSOkW1pZ494UHPNlU3fcJNoDnnYPQDLP+x6
 sPXh9Gs/7gmla28Q314lVrI0PQc/FFK1ZN1jdGex0z807lLdHhRYhuRkMCmeIyMe5EYj/yo8uvy
 B0rFnHkC+HUk9t52foODVvcONnsrEGQRQP9rNY/XXyEz/UEbwdmlaPdAxkh4/qf8umD/+8KU1Lf
 sdWw2vdJ01R0nHBtz22LDJDxwCES6qfyiR/1OvlWCylBcNLEpDsZG93adTwNYhwuB7XraqDRVsi
 FchFFxbXWey1SDyjveV/iRH3145FRCRbWkZl3FF9sH1cx5fZ7PtMPHvTTZF1StdokB2w==
X-Received: by 2002:a05:600c:3587:b0:488:ab1d:dcc5 with SMTP id
 5b1f17b1804b1-490360b3322mr46648455e9.27.1779377559006; 
 Thu, 21 May 2026 08:32:39 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903cae778asm31864145e9.13.2026.05.21.08.32.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 08:32:38 -0700 (PDT)
Message-ID: <7b61004a-6166-4566-869b-7157e5563ff3@linaro.org>
Date: Thu, 21 May 2026 17:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board/qualcomm: use bootflow for default boot
Content-Language: en-US
To: "Ricardo de Araujo (Salveti)" <ricardo.salveti@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, sumit.garg@kernel.org
References: <20260514205759.3553253-1-ricardo.salveti@oss.qualcomm.com>
 <ae4eec1e-1c5b-42d3-a26f-3911b1a2839d@linaro.org>
 <CAA_5yov+8_G2FUQ-QrKBtykt_vwZPdU-KGEzzmguYBJsUveqeQ@mail.gmail.com>
 <e13fe55d-1f43-4c07-a92a-045b0db9cf38@linaro.org>
 <CAA_5yosVpB6L6yN8gBAnMmxV7uSNjvyKtxeBV7ELGF+z18aibw@mail.gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <CAA_5yosVpB6L6yN8gBAnMmxV7uSNjvyKtxeBV7ELGF+z18aibw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 20/05/2026 18:32, Ricardo de Araujo (Salveti) wrote:
> On Wed, May 20, 2026 at 12:08 PM Casey Connolly
> <casey.connolly@linaro.org> wrote:
>> On 18/05/2026 21:15, Ricardo de Araujo (Salveti) wrote:
>>> On Mon, May 18, 2026 at 4:59 AM Casey Connolly
>>> <casey.connolly@linaro.org> wrote:
>>>>
>>>> Hi Ricardo,
>>>>
>>>> On 14/05/2026 22:57, Ricardo Salveti wrote:
>>>>> The Qualcomm default environment currently boots only with
>>>>> 'bootefi bootmgr'. This bypasses the standard boot flow used to
>>>>> discover extlinux and script boot entries, which are commonly used
>>>>> for FIT-based Linux boots.
>>>>
>>>> We intentionally don't support these alternative boot methods upstream
>>>> as they aren't standardised or supported by typical distros. There are
>>>> also plenty of inconsistencies in Linux userspace depending on if SMBIOS
>>>> (DMI data) is provide or not as well as EFI runtime services.
>>>>
>>>> Could you explain a bit more why you want to support extlinux and custom
>>>> scripts?
>>>
>>> My main use case is for the target to automatically find and load fit
>>> images by default (based on the config used), which is a quite common
>>> use case for embedded distributions and products (see that it is also
>>> enabled by default on several other platforms in u-boot).
>>
>> That's understandable, and yeah I'm aware that embedded distros have and
>> continue to use this approach. I'm kinda wary of (and should have
>> disabled) bootflow, the code for it is a challenge to understand and it
>> has caused me headaches in the past. But aside from that, the default
>> environments we ship upstream are the ones that are actively maintained
>> and used, for qcom that's EFI.
>>
>> I'd love it if we /did/ actually directly have users of upstream U-Boot,
>> but as it stands today anyone shipping it will be making some
>> customisations to it.
> 
> We expect to have meta-qcom and u-boot upstream supporting both FIT
> and EFI-based boots, the end user can decide which one to use, and
> that is why bootflow is useful here.

If the idea is to have qcom docs suggest using upstream u-boot directly,
I'd propose submitting a config fragment and a custom .env for the
dragonwing platforms.

I'd also strongly recommend against bootflow, you can just chain
commands together "bootefi bootmgr; bootm ..." to implement fallbacks.

> 
> I agree that EFI is more suitable for generic distributions, but we
> expect that some embedded products will leverage FIT directly, and
> disable EFI entirely (e.g. faster boot, reduced complexity, etc).

I'd expect those products to fork U-Boot already and/or send specific
support for their board configuration upstream.

> 
> Since FIT is already widely known and used in u-boot, I think it is
> good to also support it by default here.

Appeals to popularity go directly against the point from my last email,
booting without EFI might be justified for your product but that doesn't
mean the /reference/ Qualcomm env in upstream U-Boot should support it.

The reference env upstream is there primarily for testing.

> 
>> In any case, the other reason I'm wary to use any other boot methods by
>> default is because as I mentioned we don't support them upstream, and I
>> don't want to have to care if a change breaks FIT booting (for example).
> 
> I don't think that there is anything blocking us to support it
> directly from upstream, and I expect that pure upstream should be
> fully functional quite soon on multiple targets (some even including
> SPL support).
> 
>>> As u-boot provides support for bootflow, supporting several mechanisms
>>> which are probed at runtime (including EFI boot), I believe it is a
>>> better default as it supports a wider range of use cases.
>>
>> In general supporting more usecases is better, but when it's something
>> like how to boot the OS I do think it's much better to push folks
>> towards standardising and EFI is that standard.
>>
>> Just because products and embedded distros today use other boot methods
>> doesn't necessarily mean it's a good thing and to me at least it's clear
>> that we should just switch to EFI...
>>
>> There's no reason not to adopt something like UKI, or even to write an
>> EFI app that implements FIT booting.... But yeah, it's easy enough to
>> carry a patch or point to a custom .env file if need-be.
> 
> That would be up to the user I would say, and FIT is widely used in
> u-boot on other targets. From the u-boot side I believe both should be
> supported, I don't think FIT support will be removed from u-boot.

> 
> Thanks,
> 
> Ricardo

-- 
// Casey (she/her)

