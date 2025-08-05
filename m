Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3733DC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 18:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AD8F841CF;
	Tue,  5 Aug 2025 20:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=wolfssl-com.20230601.gappssmtp.com header.i=@wolfssl-com.20230601.gappssmtp.com header.b="i4+Cxq7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FC7C838AB; Tue,  5 Aug 2025 17:31:47 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6623983890
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 17:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-61585dfc8f8so1819996eaf.0
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 08:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20230601.gappssmtp.com; s=20230601; t=1754407901; x=1755012701;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gOJMEfR4EJk8Louk/+XZbkOSvtksXUSnFPDdrpprOvo=;
 b=i4+Cxq7cGsMexOjYqWgc4dv+bgBAwuxcv/GeK2sQrzg8xPGloHCP++BqxKcnvoB+Sp
 095t71smS9XgGETZWqkqUmQ61mG9s6tBBSzJjTQaWT3O4YXOzu0g4pdRRUwwjZj39Cn0
 q3c7Octo8mrbX0i88QYaI5U+XxFbXmrp75/WDXGsI6gPo2vhy9zRPrUzjZjKCr4l6rI1
 c6vAy1y6yMwZWIgmxpRmfe2rBuS4N7mepWwa9wMlqSOBIeucbUGfyo2VQwMxsghfvtYN
 AD8xv2XNu5DtrBh5hcshIgVSWY+4inM+2KxYwEym1DmzwZJgQM9nGeYNsL4i8yoymFdg
 8Odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754407901; x=1755012701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gOJMEfR4EJk8Louk/+XZbkOSvtksXUSnFPDdrpprOvo=;
 b=B82h7cLVZ1OuuSFruO2peEGIKRxvJ3cXECUuT6EKNL8SmuQ7peZASJp0kd5ZkeOvGJ
 lUP67Zu8mdfhJ37X7feDWCaTX933Qe/TbSE9HODMMoe+k5+IhRSegDxx0GJY6nZivyja
 NLHC/stIu/dKcD0crYsxCuh4Ou76SPNbHdZQy4dojbGrzwwI3+LxA67bF9J9zumnneHM
 WIgQe0KnlESXl42wOq1ZIkCRfw1ER/ixlRVzyl/+DwgCMwkmTC6Fe5ylKDcB25K2IIEU
 VFfqz1jLWNsxHM4QunDM4MxGBOOtabUtWi31r3bqZmk43qe1ooo4jTUh/xAfQGS3N1tD
 SAww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXoc1p/buUKv6IXzDSJP5wE7VYtBaLQ2umScFf1UgUhxafsl4NvEKtql9ipMuBtslXZvs7kXE=@lists.denx.de
X-Gm-Message-State: AOJu0YxTl8fqhG+g/+kJU2TNrTGMGo+oemlZM4XKHe+8n9Qc73/tmUtu
 eUJoLiySFylRUZkh1ESdZcdnN7o+2GiVR51D341fsN3w0xGs8mjDDM7EvUmBppBr8Y/+fiBsD1r
 9TMrwp/MuiCkCEUfgvxAdpyQsaLIt3tiLQugJpMSUguxYuxrW27rspb0=
X-Gm-Gg: ASbGncsDLqlWAy/PjVpD+8gQP+8BvPhs2XowfKM5jKvxwQWuf10wjRHKgnHuqJFQXjC
 //BaCnOeuurC50RaGdhOyuqcbjFfnXjUm8LUBdsehj61y8XrY1GHFdE7ollI/c1EtRIn77Cg9DB
 hxv5YuNjr3AzSqn+kd/EemNiXVr1yHpB7jx5zwJMglkvLDAeNfdunfridc/nvC6F4kT2Up2MAPQ
 Y7rk+OD
X-Google-Smtp-Source: AGHT+IGgt1BVSY+IEBS53sTcmMZ2OYYMk6ihUPGOb8x1fJ27g1wcxKf2rr6NCvuhEO97+p8OmoIze/LXoYXLNZtXTIs=
X-Received: by 2002:a05:6820:290a:b0:615:a91b:8e7b with SMTP id
 006d021491bc7-6198f24aaf0mr8241153eaf.4.1754407900668; Tue, 05 Aug 2025
 08:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <145501C2-B034-44EC-A16D-4F1A150347FB@wolfssl.com>
 <CAFLszTjgsSj47P6u2JohHv3vV1=sOWQxQ7qS3RDuBYBQsejKWA@mail.gmail.com>
 <CANqXHyEShK3bCA-5K4K=zH_b19i9+o9DRPYW8LHo-gFpMB2Hkg@mail.gmail.com>
 <CANqXHyH3OwPEpo=rv6E+uSP01quOQisEJ3_aD2-r=DkNDK4_+g@mail.gmail.com>
 <CAC_iWjLKotX4X9mD1qnJbnkbh9xBHfnyF+b=b--XvMjjbCrU-g@mail.gmail.com>
In-Reply-To: <CAC_iWjLKotX4X9mD1qnJbnkbh9xBHfnyF+b=b--XvMjjbCrU-g@mail.gmail.com>
From: Aidan Garske <aidan@wolfssl.com>
Date: Tue, 5 Aug 2025 08:31:29 -0700
X-Gm-Features: Ac12FXzimuN-wOcgT8bdNZQhqmnUkJZf5AYZwIVSCQDnQVb6Yvh8mqVTZWQ3ii8
Message-ID: <CANqXHyGZSGybzchkqSE0-7s3HgfY=UBjpkjS1wjuRkZzOLDMWQ@mail.gmail.com>
Subject: Re: U-Boot support for wolfTPM and firmware update for SLB9672/SLB9673
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, David Garske <david@wolfssl.com>,
 u-boot@lists.denx.de, 
 Todd Ouska <todd@wolfssl.com>, Larry Stefonic <larry@wolfssl.com>, 
 Wolfram Kusterer <wolfram@wolfssl.com>
X-Mailman-Approved-At: Tue, 05 Aug 2025 20:49:16 +0200
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

Hi Ilias,

Sounds good, I will keep them in cmd/wolftpm.c. I guess Simon can probably
answer the other question the best.
He had asked if I could "put the driver code into drivers/ with just the
command code in cmd/" so I am just trying
to get clarity on what driver code he is specifically referring to.

Thanks for the help,
Aidan
-------------------------------------
Aidan Garske
Engineering Intern, wolfSSL
+1 (916) 337-1246
-------------------------------------


On Tue, Aug 5, 2025 at 1:17=E2=80=AFAM Ilias Apalodimas <ilias.apalodimas@l=
inaro.org>
wrote:

> Hi Aidan,
>
>
> On Sat, 2 Aug 2025 at 01:59, Aidan Garske <aidan@wolfssl.com> wrote:
> >
> > Hi Simon and Ilias,
> >
> > Thank you for the great feedback. Currently I am working in the refacto=
r
> you suggested and I wanted to ask a question about some of your comments.
> >
> > 1. What exactly is the "driver code" you are referring to in this case?
> > 2. Do you want me to separate out our helper functions into a
> `cmd/wolftpm-common.c` or should I keep them in `cmd/wolftpm.c`?
> >
> > Looking forward to your response,
> > Aidan
> > -------------------------------------
> > Aidan Garske
> > Engineering Intern, wolfSSL
> > +1 (916) 337-1246
> > -------------------------------------
> >
> >
> > On Wed, Jul 30, 2025 at 8:40=E2=80=AFAM Aidan Garske <aidan@wolfssl.com=
> wrote:
> >>
> >> Hi Simon,
> >>
> >> Thank you for the great feedback. Currently I am working in the
> refactor you suggested and I wanted to ask a question about some of your
> comments.
> >>
> >> 1. What exactly is the "driver code" you are referring to in this case=
?
>
> It's been a while and I am not sure I am following on that
>
> >> 2. Do you want me to separate out our helper functions into a
> `cmd/wolftpm-common.c` or should I keep them in `cmd/wolftpm.c`?
>
> Are you expecting it to be reusable by something else? If not just
> keep it to cmd/wolftpm.c
>
> Thanks
> /Ilias
>
> >>
> >> Looking forward to your response,
> >> Aidan
> >> -------------------------------------
> >> Aidan Garske
> >> Engineering Intern, wolfSSL
> >> +1 (916) 337-1246
> >> -------------------------------------
> >>
> >>
> >>
> >> On Sat, May 10, 2025 at 4:25=E2=80=AFAM Simon Glass <sjg@chromium.org>=
 wrote:
> >>>
> >>> Hi David,
> >>>
> >>> On Thu, 8 May 2025 at 00:41, David Garske <david@wolfssl.com> wrote:
> >>> >
> >>> > Hi Denx,
> >>> >
> >>> > We at wolfSSL have developed a port for wolfTPM in U-Boot. The patc=
h
> allows using the current built-in TPM 2.0 support or switching to wolfTPM
> via CONFIG_TPM_WOLF=3Dy. It also supports TPM 2.0 firmware update for the
> Infineon SLB9672 and SLB9673.
> >>> >
> >>> > I think there is probably some more cleanup and testing needed, but
> I wanted to submit this to start the discussion and see your thoughts.
> >>> >
> >>> > The wolfTPM library is GPLv2 and added as a submodule. If the
> license or submodule is an issue let=E2=80=99s discuss! I=E2=80=99m posit=
ive we can resolve
> anything.
> >>> >
> >>> > Attached is the patch based on latest master 3b6760ddeb4 to review.
> >>>
> >>> Thank you for doing this!
> >>>
> >>> Here are a few thoughts:
> >>>
> >>> - Use lower case for function names
> >>> - Avoid camel case
> >>> - What is XMEMSET()? - Can you use memset() ?
> >>> - Convert most prinf() functions to log_debug()
> >>> - Can you use subcommands (from command.h) instead of parsing the
> >>> subcommand yourself?
> >>> - put the FIRMWARE_UPGRADE thing into Kconfig, as well as
> WOLFTPM_SLB9672/3
> >>> - put the driver code into drivers/ with just the command code in cmd=
/
> >>> - add config WOLFTPM, separate from CMD_WOLFTPM
> >>> - can you add a test in test/ and docs in doc/usage/cmd/  ?
> >>>
> >>> Regards,
> >>> Simon
> >>>
> >>>
> >>> >
> >>> > =EF=BF=BC
> >>> >
> >>> > Thanks,
> >>> > David Garske
> >>> > Software Engineer, wolfSSL
> >>> > +1 (530) 409-2990
> >>> > https://www.wolfssl.com <https://www.wolfssl.com/>
> >>> > https://github.com/wolfssl
> >>> >
>
