Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7B3C83F26
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 16:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C143580C93;
	Wed, 30 Jul 2025 18:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=wolfssl-com.20230601.gappssmtp.com header.i=@wolfssl-com.20230601.gappssmtp.com header.b="tTqb7sqx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00698805D7; Wed, 30 Jul 2025 17:40:41 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D44801BE
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 17:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7416d362e7aso1097477a34.1
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20230601.gappssmtp.com; s=20230601; t=1753890036; x=1754494836;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=poo9FquyQkfoPGHeFHCUa/xOn+THm2DT/AhJxNFM4VU=;
 b=tTqb7sqxIEntX68IhKH5Kz+P/WMOJR4SPOg+JbaTWZFBM5gnX8mHDIxgwWCBFtpNrr
 liXze7cAqkPe+7zXYt9g74hX/n4cwpafoDXqZ09b0UmSaeEegT6oejppPiBhTIdH4oUy
 ncKbvgaYoC6w7ZDvOMQozCXCbY958T/tBFr1UGU+G9j2E/8q1+AIHfysoodWGNh6FEbw
 gjpGuJSiEyxwsV7zp+7pBcjz7BL0n8/aj0/59QMyrT2MvgKUq0tveZnd9FlbYUzRpepY
 i5iUZUYxEIWv6ICjIlO8WUSDMjDg/EqdN9YvcEK1oFpBVr06Gs6Zo09vmc8a6jU/ZiU3
 0puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753890036; x=1754494836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=poo9FquyQkfoPGHeFHCUa/xOn+THm2DT/AhJxNFM4VU=;
 b=REvZx4XLKiIRwPIaaQD9YaOE29F5RKYhnclERGO/BexACB0qv6v6nn4v5nPRLbi7AD
 52BnrLZPCYZG8IfZwF9nq64iF6sy+M9CgSUnCBa0YHn4rYAecL5ncb/8c9iK/5948aWK
 UJrvuU5ywKSHefOaVWPX2Hu2mK5vjLbTLC0VQjs+2QXEbgjuP0yKMD3B/GyjO1yrLevq
 tGK1enE2OPJdqB78lc+k+d3wu8CBA24JamwmSnJiOnGFKc2rz+WLxS7BfMTFvkdykfej
 xbnxNDe6dYNi5w878vsiEFK+K4dIINfdNbpjk76S3aZO2Q6stFY5UGZRZZ7KAVn8NmA6
 hWKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh0/u5PxxjCQ+ifZ7qE7AJYU4+DcA8KVr2NvnH4tql7GZsu22BoIObVZ9nlGMgPJGME+6kkY0=@lists.denx.de
X-Gm-Message-State: AOJu0Yzx1EG11WfFSuDdp2WFvU1BNPpCJPm6PkJqqRQ4O6rQUNdB0VpN
 3y+g3Zp1NMkrCkiETWR0yOrForV0JEwKmUJGyDBaK3NCtNnqngT1nMm7f52DmVtJdXIody+XAe2
 AWpQQp8vZzfZ5y3EwTHme5oItiyoFUocG1iEkv+qJeA==
X-Gm-Gg: ASbGnctYKDjOs0oyDWGdQKGjm2CsKKKwZytEs6zqfwW/gGQZmeDgZ8Rnt6V6lu/JGoP
 RFg3JBXf788vV67dpjvvP7/cNFqgeTI6wAvHA3BDdRdTdIvP7PTEsocFiwOmVcP+qXw+AEvzz3u
 CDI/fwujWqabavABKBH3T/jDBlD2tLd/APrnhNIxMW/Vpkx6roM8e/2UKv+MSaSr3QN+NyB8skM
 qj+KuQJ
X-Google-Smtp-Source: AGHT+IEpBo8AS1hGPvhwao2ZpyYp3F80/KJrTwULoHTbnnLDzjJiqg73eLhQZJPm7pQ1hWYXxB6Eiqt+YiwcLcH9lT4=
X-Received: by 2002:a05:6808:221e:b0:40b:4208:8038 with SMTP id
 5614622812f47-431998a2a0cmr2340560b6e.4.1753890036534; Wed, 30 Jul 2025
 08:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <145501C2-B034-44EC-A16D-4F1A150347FB@wolfssl.com>
 <CAFLszTjgsSj47P6u2JohHv3vV1=sOWQxQ7qS3RDuBYBQsejKWA@mail.gmail.com>
In-Reply-To: <CAFLszTjgsSj47P6u2JohHv3vV1=sOWQxQ7qS3RDuBYBQsejKWA@mail.gmail.com>
From: Aidan Garske <aidan@wolfssl.com>
Date: Wed, 30 Jul 2025 08:40:25 -0700
X-Gm-Features: Ac12FXyqsgQOuBgAgLBcAkO3myyZhQklL2SqgM-sJMCe13QG7ah9eqQ4z5jGZ2Q
Message-ID: <CANqXHyEShK3bCA-5K4K=zH_b19i9+o9DRPYW8LHo-gFpMB2Hkg@mail.gmail.com>
Subject: Re: U-Boot support for wolfTPM and firmware update for SLB9672/SLB9673
To: Simon Glass <sjg@chromium.org>
Cc: David Garske <david@wolfssl.com>, u-boot@lists.denx.de,
 Todd Ouska <todd@wolfssl.com>, 
 Larry Stefonic <larry@wolfssl.com>, Wolfram Kusterer <wolfram@wolfssl.com>
X-Mailman-Approved-At: Wed, 30 Jul 2025 18:42:01 +0200
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

Hi Simon,

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



On Sat, May 10, 2025 at 4:25=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:

> Hi David,
>
> On Thu, 8 May 2025 at 00:41, David Garske <david@wolfssl.com> wrote:
> >
> > Hi Denx,
> >
> > We at wolfSSL have developed a port for wolfTPM in U-Boot. The patch
> allows using the current built-in TPM 2.0 support or switching to wolfTPM
> via CONFIG_TPM_WOLF=3Dy. It also supports TPM 2.0 firmware update for the
> Infineon SLB9672 and SLB9673.
> >
> > I think there is probably some more cleanup and testing needed, but I
> wanted to submit this to start the discussion and see your thoughts.
> >
> > The wolfTPM library is GPLv2 and added as a submodule. If the license o=
r
> submodule is an issue let=E2=80=99s discuss! I=E2=80=99m positive we can =
resolve anything.
> >
> > Attached is the patch based on latest master 3b6760ddeb4 to review.
>
> Thank you for doing this!
>
> Here are a few thoughts:
>
> - Use lower case for function names
> - Avoid camel case
> - What is XMEMSET()? - Can you use memset() ?
> - Convert most prinf() functions to log_debug()
> - Can you use subcommands (from command.h) instead of parsing the
> subcommand yourself?
> - put the FIRMWARE_UPGRADE thing into Kconfig, as well as WOLFTPM_SLB9672=
/3
> - put the driver code into drivers/ with just the command code in cmd/
> - add config WOLFTPM, separate from CMD_WOLFTPM
> - can you add a test in test/ and docs in doc/usage/cmd/  ?
>
> Regards,
> Simon
>
>
> >
> > =EF=BF=BC
> >
> > Thanks,
> > David Garske
> > Software Engineer, wolfSSL
> > +1 (530) 409-2990
> > https://www.wolfssl.com <https://www.wolfssl.com/>
> > https://github.com/wolfssl
> >
>
