Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FF1C87FCB
	for <u-boot@archiver.kernel.org>; Sun,  3 Aug 2025 13:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC87583D13;
	Sun,  3 Aug 2025 15:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=wolfssl-com.20230601.gappssmtp.com header.i=@wolfssl-com.20230601.gappssmtp.com header.b="GX50rGTF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7267983B86; Sat,  2 Aug 2025 00:59:09 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00D5983B6C
 for <u-boot@lists.denx.de>; Sat,  2 Aug 2025 00:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-73e810dbf5aso1666640a34.0
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 15:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20230601.gappssmtp.com; s=20230601; t=1754089143; x=1754693943;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TJp7PRwQFM3/Dk0I3Pp2e99WMWGl1sGtaX62zLsErrU=;
 b=GX50rGTFiIoxxEeDVTEBmypdiH+zaeHXbV5QxUtLFlRcYdPG+6gLKWNN+G1RG1vJdN
 4sM+jHx9ZmvJ6UKa8jMbc6lseoFQruxva5iKBkk9MYN301FfpzOeUqDWNcswmLHXMMwu
 7TKhHHCqB0dN3pu3xPD7ufAblRSczAaxtqRcdelBS5gYT1lknLrTw/V0/dwkswKwIfj5
 8WFstIOL+7DrLKwfhMcQP8v/P4/pXy5BP3Q3WWSpk/cpqr0c7BSInnWvB/g3wGG8AtDe
 /2nn7yAyGddPkp8OVAnubr4hOlVbLakTUIpK9+kJi/WkzemKUYGWOBSwmWsiDipvH3tf
 oWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754089144; x=1754693944;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TJp7PRwQFM3/Dk0I3Pp2e99WMWGl1sGtaX62zLsErrU=;
 b=DGq2KgaHCS5UE6bg9Td+K9dfH0oZaraA4iusxbYRF1LpOZpJkPITgyms/VeCeTr7kk
 /WNXqEAyw2JIQZWBVW0InHXWPQyxF95FVbFxnGTKZRfyQ92uYeSi7w9gcDHC84nnndTz
 KAEx3Caf8V3l1U8OVhXW3B2u1c/7BRVr46O7Zq8gWHY5ZB0mAt4oCgAnB33DsklGw3u1
 PNG7grjDtp+RYxVR903cEliiHJdJ8T+44hZ2zW1kTQ+vQgBGojrpr+uSkCxSbQT7DNpf
 P9qko9D8golfmu5aaw286leRDzRwVCZ1SvJkbQpsmWGdcD9J0KgLGcyDOnLmhFlizgRZ
 LaWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVao0MewLwVke6oP946MQycPVqsDpBuoasteeW4vbBGPM1d0/jISs/7/SwPbT5c7DR2XpW0dSM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy50jGs1umKDz1+TE7hhk1tg300mNYm/H4/ZrusBMUb+dDLEqBI
 Lq807LNhWf/Uhg0WqSzBt1SKRDVr3IDvowqDMSUa9oIR3n8ATgRB2lhtXyDC7H4hBcFr3MucQA7
 GN9kLUkJY7L7e9bqp/oqikXSR5ApGmKi2FNhEvCREtQ==
X-Gm-Gg: ASbGncshPRqQ9EcLjTa8RDDw4YxcmjMIepOgrt8FxV4FoYRv4TrMQMkdfC9dB+ukRGE
 PZaBZjpkXSvYhinKV07gkKBumxpUEnmA8001DMVTHy7WUFqHWv/qbAoNKXSjP92LRosiAEYpfA5
 v4BV6YRDgoL5FZPDslcuEuiwrfA3zox+3i4ELPZh/BnE/vY67le/3C0cyc1geiG8uXhcvU+JDF7
 DBNQ8vf
X-Google-Smtp-Source: AGHT+IHTIzvNNf22DZcr0n0KMRt0oYkTenhZR+nwybrLHPR1IIYoEpo97W6e4bXqyaDkEnrAJBRQWJbksDBdlLyo6/M=
X-Received: by 2002:a05:6808:1393:b0:3f8:150b:f571 with SMTP id
 5614622812f47-433f02fe3a6mr1153394b6e.21.1754089143595; Fri, 01 Aug 2025
 15:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <145501C2-B034-44EC-A16D-4F1A150347FB@wolfssl.com>
 <CAFLszTjgsSj47P6u2JohHv3vV1=sOWQxQ7qS3RDuBYBQsejKWA@mail.gmail.com>
 <CANqXHyEShK3bCA-5K4K=zH_b19i9+o9DRPYW8LHo-gFpMB2Hkg@mail.gmail.com>
In-Reply-To: <CANqXHyEShK3bCA-5K4K=zH_b19i9+o9DRPYW8LHo-gFpMB2Hkg@mail.gmail.com>
From: Aidan Garske <aidan@wolfssl.com>
Date: Fri, 1 Aug 2025 15:58:52 -0700
X-Gm-Features: Ac12FXwup-yHRonHP9Q2s6SQ8I12W_nZpTYm6tS_44N8ZcpRygaUrrtAZsF5Ng8
Message-ID: <CANqXHyH3OwPEpo=rv6E+uSP01quOQisEJ3_aD2-r=DkNDK4_+g@mail.gmail.com>
Subject: Re: U-Boot support for wolfTPM and firmware update for SLB9672/SLB9673
To: Simon Glass <sjg@chromium.org>, ilias.apalodimas@linaro.org
Cc: David Garske <david@wolfssl.com>, u-boot@lists.denx.de,
 Todd Ouska <todd@wolfssl.com>, 
 Larry Stefonic <larry@wolfssl.com>, Wolfram Kusterer <wolfram@wolfssl.com>
X-Mailman-Approved-At: Sun, 03 Aug 2025 15:22:51 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon and Ilias,

Thank you for the great feedback. Currently I am working in the refactor
you suggested and I wanted to ask a question about some of your comments.

1. What exactly is the "driver code" you are referring to in this case?
2. Do you want me to separate out our helper functions into a
`cmd/wolftpm-common.c` or should I keep them in `cmd/wolftpm.c`?

Looking forward to your response,
Aidan
-------------------------------------
Aidan Garske
Engineering Intern, wolfSSL
+1 (916) 337-1246
-------------------------------------


On Wed, Jul 30, 2025 at 8:40=E2=80=AFAM Aidan Garske <aidan@wolfssl.com> wr=
ote:

> Hi Simon,
>
> Thank you for the great feedback. Currently I am working in the refactor
> you suggested and I wanted to ask a question about some of your comments.
>
> 1. What exactly is the "driver code" you are referring to in this case?
> 2. Do you want me to separate out our helper functions into a
> `cmd/wolftpm-common.c` or should I keep them in `cmd/wolftpm.c`?
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
>
> On Sat, May 10, 2025 at 4:25=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
>
>> Hi David,
>>
>> On Thu, 8 May 2025 at 00:41, David Garske <david@wolfssl.com> wrote:
>> >
>> > Hi Denx,
>> >
>> > We at wolfSSL have developed a port for wolfTPM in U-Boot. The patch
>> allows using the current built-in TPM 2.0 support or switching to wolfTP=
M
>> via CONFIG_TPM_WOLF=3Dy. It also supports TPM 2.0 firmware update for th=
e
>> Infineon SLB9672 and SLB9673.
>> >
>> > I think there is probably some more cleanup and testing needed, but I
>> wanted to submit this to start the discussion and see your thoughts.
>> >
>> > The wolfTPM library is GPLv2 and added as a submodule. If the license
>> or submodule is an issue let=E2=80=99s discuss! I=E2=80=99m positive we =
can resolve
>> anything.
>> >
>> > Attached is the patch based on latest master 3b6760ddeb4 to review.
>>
>> Thank you for doing this!
>>
>> Here are a few thoughts:
>>
>> - Use lower case for function names
>> - Avoid camel case
>> - What is XMEMSET()? - Can you use memset() ?
>> - Convert most prinf() functions to log_debug()
>> - Can you use subcommands (from command.h) instead of parsing the
>> subcommand yourself?
>> - put the FIRMWARE_UPGRADE thing into Kconfig, as well as
>> WOLFTPM_SLB9672/3
>> - put the driver code into drivers/ with just the command code in cmd/
>> - add config WOLFTPM, separate from CMD_WOLFTPM
>> - can you add a test in test/ and docs in doc/usage/cmd/  ?
>>
>> Regards,
>> Simon
>>
>>
>> >
>> > =EF=BF=BC
>> >
>> > Thanks,
>> > David Garske
>> > Software Engineer, wolfSSL
>> > +1 (530) 409-2990
>> > https://www.wolfssl.com <https://www.wolfssl.com/>
>> > https://github.com/wolfssl
>> >
>>
>
