Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE514C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90F2C84183;
	Tue,  5 Aug 2025 10:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VqDBsnff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2CCD84179; Tue,  5 Aug 2025 10:17:10 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45CE1831E0
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e8fd59485d8so3290537276.3
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 01:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754381827; x=1754986627; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DDAzoHDZDv0OvSQui9Rkf/9pJSSW2JX7bQe2F6HeDo8=;
 b=VqDBsnff2jUWTMvL8c9nJYuhJOflYgWUEV9UqdxPFuS6fcwtflyVqNHX984OMJQLC9
 XTaxJWpmGJc8uYi9OY8nEwnEsyYHB9gMsk9QM/wv64Ukn6VIMYq2AiX0Fm1gYV+wHDKc
 oGd4RVfuFXgYU5D2/B2G/Dk2g64vPQVLfjS3V1xPnvUkLBR/9/xt837/14TD47WprJOw
 USrD3kqq4ug/nPU1ehsEZ+XfRFGMaYZZRIXz9Y2m/EmHFX34UFFNcWKnF4G9IHEqGFzr
 inwrw/4wMY2N4R4cJMK9Ka3rdElYraKEOWEB5SCE6r4+usHvykjk3PMV/W66jUsitAhB
 euiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754381827; x=1754986627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DDAzoHDZDv0OvSQui9Rkf/9pJSSW2JX7bQe2F6HeDo8=;
 b=Gw2eBNtWJ75d40UkEtu6mTJmuGwGKImcyP9/lt/z0xSDqavHmMFEVAmLx1qb6Sy13a
 b/EpDFRVGoiSNdGaWlR9dO/aC77P8tz5AMqFvsmnPWVLm+N/OkUXWU58ulvaImDYK2wT
 7CZHXJU2y27slKEroeyVwTzMzbxHNg+Of2eRFC+21bgqYmJvpvaUD7CqmGO7coDa3H+2
 73tUNCniND1cZB8aDNzppYudWLJdyYr+aZJwd6AvsQCnGXQ9eKCY5GhlKJCfsTRZ1X8W
 /yyDvEoKxks9wzWU9Im2vVxNI2uFV3HDAS4PxYosCXp0ssIxoJH6wwu4gTsapgkh2b6G
 sU0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfR/EEyhB4KpqkVyjjU7uPg5unBqGDH3cloWyxGihAPFr7ACEe79HGhtFOqOoIvrGswbgpu50=@lists.denx.de
X-Gm-Message-State: AOJu0YwFAcyRRntlJUhK+9Z0aKxTenQPUL4Vklof5ecXyozobKjxGBpP
 sJGiZrVWowLuMN1w3yUovsHY1S4kYlx0GEqKB/J1xKoSw7z3BTHfT7nIH+8OdaB1QSdtbYDs25y
 GmyF+andTbIDQ7cnNMfORgkUgLCSt2TiMTx4XpmVMhw==
X-Gm-Gg: ASbGnctBwpT26mBJFm1fw3u4XoUrlv03oBWBmO2+J0hpkrHXJOiRF6TCEOby41z0C6T
 qpmESwKtb+J7c0wfcpr/LkUlZ6q5SK9PDzxFojmYMv1ov3ZtaGaOviMKdj320rlyrxnIvOAktAf
 pLz/3+P6XN7bNacBmKwRgL3Qu+arjQuQPREij1rbJuiOciOjPLB7zZNfLUB0WBaSLXxLxZ3IKCT
 kAcoj42
X-Google-Smtp-Source: AGHT+IGkZouZpF6OUIY4Jf+bHleRQny+1m8Z52PoCjexla099fq6guaNqL8kdT9Uf/LS4H2xBGqTp3C9+FnaOeeeuEg=
X-Received: by 2002:a05:690c:c92:b0:71a:3484:abe8 with SMTP id
 00721157ae682-71b7f085304mr156552007b3.34.1754381826822; Tue, 05 Aug 2025
 01:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <145501C2-B034-44EC-A16D-4F1A150347FB@wolfssl.com>
 <CAFLszTjgsSj47P6u2JohHv3vV1=sOWQxQ7qS3RDuBYBQsejKWA@mail.gmail.com>
 <CANqXHyEShK3bCA-5K4K=zH_b19i9+o9DRPYW8LHo-gFpMB2Hkg@mail.gmail.com>
 <CANqXHyH3OwPEpo=rv6E+uSP01quOQisEJ3_aD2-r=DkNDK4_+g@mail.gmail.com>
In-Reply-To: <CANqXHyH3OwPEpo=rv6E+uSP01quOQisEJ3_aD2-r=DkNDK4_+g@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 Aug 2025 11:16:31 +0300
X-Gm-Features: Ac12FXzdUQ3BXLSc-TlYUOs-x3yizE_PWhqkBw_Nq3Gtw3kuRIgU7LaqrwhfCg4
Message-ID: <CAC_iWjLKotX4X9mD1qnJbnkbh9xBHfnyF+b=b--XvMjjbCrU-g@mail.gmail.com>
Subject: Re: U-Boot support for wolfTPM and firmware update for SLB9672/SLB9673
To: Aidan Garske <aidan@wolfssl.com>
Cc: Simon Glass <sjg@chromium.org>, David Garske <david@wolfssl.com>,
 u-boot@lists.denx.de, 
 Todd Ouska <todd@wolfssl.com>, Larry Stefonic <larry@wolfssl.com>, 
 Wolfram Kusterer <wolfram@wolfssl.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Aidan,


On Sat, 2 Aug 2025 at 01:59, Aidan Garske <aidan@wolfssl.com> wrote:
>
> Hi Simon and Ilias,
>
> Thank you for the great feedback. Currently I am working in the refactor =
you suggested and I wanted to ask a question about some of your comments.
>
> 1. What exactly is the "driver code" you are referring to in this case?
> 2. Do you want me to separate out our helper functions into a `cmd/wolftp=
m-common.c` or should I keep them in `cmd/wolftpm.c`?
>
> Looking forward to your response,
> Aidan
> -------------------------------------
> Aidan Garske
> Engineering Intern, wolfSSL
> +1 (916) 337-1246
> -------------------------------------
>
>
> On Wed, Jul 30, 2025 at 8:40=E2=80=AFAM Aidan Garske <aidan@wolfssl.com> =
wrote:
>>
>> Hi Simon,
>>
>> Thank you for the great feedback. Currently I am working in the refactor=
 you suggested and I wanted to ask a question about some of your comments.
>>
>> 1. What exactly is the "driver code" you are referring to in this case?

It's been a while and I am not sure I am following on that

>> 2. Do you want me to separate out our helper functions into a `cmd/wolft=
pm-common.c` or should I keep them in `cmd/wolftpm.c`?

Are you expecting it to be reusable by something else? If not just
keep it to cmd/wolftpm.c

Thanks
/Ilias

>>
>> Looking forward to your response,
>> Aidan
>> -------------------------------------
>> Aidan Garske
>> Engineering Intern, wolfSSL
>> +1 (916) 337-1246
>> -------------------------------------
>>
>>
>>
>> On Sat, May 10, 2025 at 4:25=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
>>>
>>> Hi David,
>>>
>>> On Thu, 8 May 2025 at 00:41, David Garske <david@wolfssl.com> wrote:
>>> >
>>> > Hi Denx,
>>> >
>>> > We at wolfSSL have developed a port for wolfTPM in U-Boot. The patch =
allows using the current built-in TPM 2.0 support or switching to wolfTPM v=
ia CONFIG_TPM_WOLF=3Dy. It also supports TPM 2.0 firmware update for the In=
fineon SLB9672 and SLB9673.
>>> >
>>> > I think there is probably some more cleanup and testing needed, but I=
 wanted to submit this to start the discussion and see your thoughts.
>>> >
>>> > The wolfTPM library is GPLv2 and added as a submodule. If the license=
 or submodule is an issue let=E2=80=99s discuss! I=E2=80=99m positive we ca=
n resolve anything.
>>> >
>>> > Attached is the patch based on latest master 3b6760ddeb4 to review.
>>>
>>> Thank you for doing this!
>>>
>>> Here are a few thoughts:
>>>
>>> - Use lower case for function names
>>> - Avoid camel case
>>> - What is XMEMSET()? - Can you use memset() ?
>>> - Convert most prinf() functions to log_debug()
>>> - Can you use subcommands (from command.h) instead of parsing the
>>> subcommand yourself?
>>> - put the FIRMWARE_UPGRADE thing into Kconfig, as well as WOLFTPM_SLB96=
72/3
>>> - put the driver code into drivers/ with just the command code in cmd/
>>> - add config WOLFTPM, separate from CMD_WOLFTPM
>>> - can you add a test in test/ and docs in doc/usage/cmd/  ?
>>>
>>> Regards,
>>> Simon
>>>
>>>
>>> >
>>> > =EF=BF=BC
>>> >
>>> > Thanks,
>>> > David Garske
>>> > Software Engineer, wolfSSL
>>> > +1 (530) 409-2990
>>> > https://www.wolfssl.com <https://www.wolfssl.com/>
>>> > https://github.com/wolfssl
>>> >
