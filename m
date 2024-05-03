Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3582C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 15:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06C248844C;
	Fri,  3 May 2024 17:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c1ilWwk/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6AFE88603; Fri,  3 May 2024 17:53:15 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 746CB8844C
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 17:53:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-518a56cdbcfso14428989e87.2
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714751593; x=1715356393; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bLnxc9sjK43o/7OczEblTRj9IeolweAC3WMMtRQGtWg=;
 b=c1ilWwk/bwf48t12kzJQhgDo3o0606swlKQ7o3m575mZZK+L2pkVDsH+tqAMQhKliv
 Bxs3hMtb4NAh3bXcmUHi+JG8dX2M2fgDzYdG6N3+Nkgiqex1ELJtMZ0plb/EJE7VZs63
 wzGdvYYR0vBgkKUXOw1TFa1oX0jnClLwlBhgg+sXKA1VKVMHBT/qfIt+JqorfR0m63/W
 44x9IRIv+xpLqfzhTxGtu6LIQ0EsdIJPLlpFi86bzlTBva3wWDIVZ3LA9AVyZEYNvpiz
 innBnQLNiKtDPGmxkXdlCtTs1uxoD/e0YMIGJS2FEr5+4nzpqn+zf1OCQi6VJ20WqGXf
 BUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714751593; x=1715356393;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bLnxc9sjK43o/7OczEblTRj9IeolweAC3WMMtRQGtWg=;
 b=gv/+fWf0zrhbFe1r39e7NgV+DA5Sg9L6MlnGUaTHYLq79H1di3CHpSd54PLei8F4Ug
 mKxSaEnycJNnwJCqOwwaGe8hiJUPrsFudEphpompsFmZEXrkb2CihuvmWZb3ch1JLj86
 MQUweNpt211HIFOf1Bb6RXv3Mjbxg4iadEK5HjUbclyHVYRy+OitYsboNBIQPIsDWTrh
 OZtAAjjtCo9kct3Lvn0NTsJWWFy2JLDB0dAiXQLtmm2jHj2juBzgO8AG/oWF2qiCOtVf
 XGf2bP7p6O3tsiSL3kjiReAoRLtXzGFCS6Q2qPUvOYt560UF5wTb+AD7vAVpvpmYhfa9
 janA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHuKGFs/PKusCoIFqi//tCjmfMhu9VXBO1z9k4TW3d8OByY5gD59/8nZUac+1ILwiSRsrX1B15VLp9rSBVBgLFNgvfZQ==
X-Gm-Message-State: AOJu0YwYDmuh/Erevu8u/1gdnxGjgfvc1XJOL20RFeNFV/G4GpPN7xcW
 fDRc0BIXCJ57pXfJqEhZ+WcKOt9tlUfUlDw7TK48lD8cWJdby8QURE4+hhQLiJ0=
X-Google-Smtp-Source: AGHT+IG0AerqNHGYH0iSGK6K9NlNqRjFTW9dGccDgYFPHqGwoJ7WwZKTWvPuDJ3h7klIFlgITeK8mA==
X-Received: by 2002:a19:c214:0:b0:512:e02f:9fa7 with SMTP id
 l20-20020a19c214000000b00512e02f9fa7mr2602170lfc.1.1714751592609; 
 Fri, 03 May 2024 08:53:12 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::11db? ([2a02:8109:aa0d:be00::11db])
 by smtp.gmail.com with ESMTPSA id
 q6-20020a1709060e4600b00a5875dd74c2sm1835730eji.131.2024.05.03.08.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 08:53:12 -0700 (PDT)
Message-ID: <e7ccadfb-6ba8-4106-be0a-9fffcf2067e2@linaro.org>
Date: Fri, 3 May 2024 17:53:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dm: core: add support for fallback drivers
To: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20240410-b4-stub-drivers-v1-0-6935bd2c07d1@linaro.org>
 <20240410-b4-stub-drivers-v1-1-6935bd2c07d1@linaro.org>
 <1EFAA3ED-7C3B-43DA-AA0A-FC520FF16290@gmx.de>
 <20240410194452.GG2493117@bill-the-cat>
 <61d7423a-5240-c746-b724-4d51b7d5ad74@gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <61d7423a-5240-c746-b724-4d51b7d5ad74@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi all,

Sorry for the slow follow-up.

On 11/04/2024 04:37, Sean Anderson wrote:
> On 4/10/24 15:44, Tom Rini wrote:
>> On Wed, Apr 10, 2024 at 07:27:17PM +0200, Heinrich Schuchardt wrote:
>>>
>>>
>>> Am 10. April 2024 19:06:57 MESZ schrieb Caleb Connolly 
>>> <caleb.connolly@linaro.org>:
>>>> Introduce support for a uclass to provide a fallback/stub driver which
>>>> can be used when no device is found for a given node. This might be
>>>> useful for handling non-essential clock controllers like the RPMh on
>>>> Qualcomm platforms, or during early bringup to get UART output before a
>>>> real clock driver has been created.
>>>>
>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>> ---
>>>> drivers/core/Kconfig  | 10 ++++++++++
>>>> drivers/core/uclass.c | 24 +++++++++++++++++++++++-
>>>> include/dm/uclass.h   |  3 +++
>>>> 3 files changed, 36 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
>>>> index 1081d61fcf01..09075b9b7a15 100644
>>>> --- a/drivers/core/Kconfig
>>>> +++ b/drivers/core/Kconfig
>>>> @@ -466,5 +466,15 @@ config BOUNCE_BUFFER
>>>>
>>>>       A second possible use of bounce buffers is their ability to
>>>>       provide aligned buffers for DMA operations.
>>>>
>>>> +menuconfig FALLBACK_DRIVERS
>>>
>>> Wouldn't it be preferable to mark individual drivers as fallback 
>>> drivers in their declaration?
>>>
>>> This would allow alternative fallback drivers and would not require 
>>> any definitions at uclass level.
>>>
>>> Just by building a fallback driver you would enable the fallback 
>>> behavior for its uclass.
>>
>> I think some of this is addressed in the cover letter. My concern /
>> questions come down to I think just a matter of naming. Both "fallback"
>> and "stub" are used at times. As a concept, we have some areas where we
>> need a no-op driver because whereas the DT describes a relationship in
>> the hardware, here in U-Boot we can just accept things as configured. To
>> me "fallback" implies more functionality of the driver when it's really
>> just a generic no-op driver to fill in the dependencies within the tree.
>> Can we rename things a bit along those lines?

Yes, will do. I originally used "stub" but then decided "fallback" was 
better, but I think you're right that stub is the right way to go here. 
As I agree that "fallback" implies some kind of real implementation.
>>
> 
> I would rather just have a stub driver with compatibles for all clocks 
> we want
> it to match. I think having a generic fallback driver could cause issues 
> in the
> future if we need to switch over to using a real driver.

I don't think either approach is significantly better from a developer 
perspective. With my patches if there a driver with a matching 
compatible available then you will NEVER bind the stub, even if probe 
fails on the real driver. With your proposal we'd have to remember to 
remove the compatible from the stub driver or risk the race condition 
when binding drivers.

There is another subtle but important difference if we were to use a 
compatible list in the stub. It turns out that CONFIG_OF_LIVE affects 
the bind behaviour - U-Boot won't try to bind the children of a node 
with no driver when using the livetree. This is arguably more "correct", 
as usually child devices depend on their parent, so we save some cycles 
by not binding unsupported devices.

But, the RPM clock controller which I originally implemented this 
feature for is such a case, this is the DT (simplified for brevity):

rpm: remoteproc {
     compatible = "qcom,sm6115-rpm-proc", "qcom,rpm-proc";

     glink-edge {
         compatible = "qcom,glink-rpm";

         rpm_requests: rpm-requests {
             compatible = "qcom,rpm-sm6115";

             rpmcc: clock-controller {
                 compatible = "qcom,rpmcc-sm6115", "qcom,rpmcc";
             };
     };
};

With livetree (which we use on qcom) we would need to stub not just the 
rpmcc but also the rpm-requests, the glink bus, and the remoteproc (yeah 
these platforms are a bit silly, I know XD).

However with the fallback solution as implemented in these patches, we 
totally sidestep this issue by directly binding the node on-demand, 
something we can only safely do for a stub driver as we don't need the 
parent devices.

So I can either:

1) Make OF_LIVE behave like flattree and descend into all nodes (I don't 
know if this would cause any issues, but I think the livetree behaviour 
is more "correct" tbh).
2) Add stubs for all 3 of the parent nodes (and manually maintain a 
table of compatibles for clock drivers we want to stub).
3) Stick with this approach of binding the stub as a last resort.

Obviously I've already put the time into 3, and that would still be my 
preferred approach, but I'm open to other ideas.

> 
> --Sean

-- 
// Caleb (they/them)
