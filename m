Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF32D35669
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 04:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F320E841FF;
	Wed, 28 Jan 2026 05:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IMZiLOWr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31FC584207; Wed, 28 Jan 2026 05:26:42 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA991841E7
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 05:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-65807298140so10288895a12.2
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 20:26:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769574399; cv=none;
 d=google.com; s=arc-20240605;
 b=A6jaDRcdaB8F/dWfwlJUlUhSKthvYWvY0cJH0t1OmdwW771MHoCcY7B5O/TbFBvWCy
 9T1wB9wdT6Kn1SAKVraPMJWXygwnak4EfaFXbfM7OzN2LgaRQuocw9FFmV3JlXNvAs6J
 ABZk8R2Oc8PjnhvnJXvbiGlPEMP/silD1akcap4dRmENsE1dCmCBleaPH9swf5epFc3w
 HWwzlGeDykdWVuHD55njTuvGHRTV+PU2iR77o90yCbCO4h1m4lbzI2XQEut2VdWZwrBn
 G1QUK6g+CsuxUfglnjR5ndxirXcr5e6GKJ5Z9WwKRSASoA+4Kei6yMDohKmG5BqE30WC
 j2HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=g7fwbQUadOGS3deXU+U2CuJf6bf3WBbZpdPGtrriiLc=;
 fh=xsiJ2RE3qztzlh97btP+FMGnI6QNiTPEsE85jZyBWDM=;
 b=bW1NgVXW9HDqU9ZRw1Vdvvxv1TSeUCRMkrsrtsoaszD3vc/ceRKywmmw+sum7UChGt
 spzZs/Z9EEdcB3betHPdbsrhHfKspNpAuAwRdidTkcelvhJY76GsPk3xchoCkCumDEgG
 1OsssfGMAbuv+ewCITNYdKih0o7VGZR9BFyTcLM/QUcEL8wVi7183xmsoGEjFULOV6NI
 /GKCzWyDX14UIHQoda/4SBLiorEuKH59zEfVEIYZmGjH6xwvztQwOLmWFtCNq6Jis/lG
 gDMshy+3bXJb7PWIObhmtBFiCnsUOJUOW0nVn6UUU/Y3f5l/QPyLiEv6tc+C3UQWGO8S
 RjVA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769574399; x=1770179199; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7fwbQUadOGS3deXU+U2CuJf6bf3WBbZpdPGtrriiLc=;
 b=IMZiLOWrBO/dDMzKdRrobvlTXzXN+Kakdm0NGKIjSLnaO01mTtahTg18c1/mtqjBox
 Pxm4XzbwQmIalTzuSrQ/atSM0K12+DEBFNuWLydsifHAMcx8T4iS62KjOKv6u4soDJRv
 X36L/EIFvPVaYTXWTPkz/PD8NTRbbRSEFhL35orVs/EgR4g5AgWiv2CDJtNmwBlG1afP
 Ic3blNiEj8o3G0xePdQ3n/hPOjWgmqmqXkEtYtxCRGawNdohmzG+/FAUpDyaelcU9TyQ
 CqZa3GTbD1OGtQJyEqF6cuKssORls9uWrH6qe5TQxxJuZSSRIcaMSjnkhzC2KhyEMEY1
 CnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769574399; x=1770179199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g7fwbQUadOGS3deXU+U2CuJf6bf3WBbZpdPGtrriiLc=;
 b=Jhc2zRzG75QoO+WijMnYRcLWFYbQ4iD2t8pPYCUzy49eIlYANGg38Q2iSwL1+JPwVY
 JhIE7FvpZQoZMTp8wCK3Ywkjb7wzwfFLEeRF5D86EGHM3vOGY3VAcQHkoanRbbzSZfRf
 wzgsTxrRRCEaUpA4VzrK2DLHytf4pbHXxtnq4V8994lkm5A/SwHlB+04VAWcQdgE173n
 0osf5UmT4FlYrvvicxcp5yr2sd/hMDDeHQK+jGkvaP1/V9H7RZQLXAomNrZyVSBQFv+c
 klSg1UrfF8g8dCoWuv4re8A44oCRwZHyKO9+Q7oNVEwXR3Hu5zFIXibSTOtj21qy40eL
 7uuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSeGz6cEOfBTtcS46oBBWntzDkfEcEaxUUJrzd0JOYFf6NFLkRcsKkBzXAsPhL5LQVKB24ZS0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7ffSrsSG5oWHOdF6Reunl84djw8shdPxSvWpM5rTdsmM2T2Jt
 40BQjGoZSi92sDqIB7B40FJHghEQEGPQGgl5/b8GyS0Tb2QQuRE/8hMtwQgf3YkKVwr9ogZuR9Z
 Nl9N7GOwcjYo4ITQMKVLjCNsRPjMT5ro=
X-Gm-Gg: AZuq6aLR5nRJAqIc83jvR9lh7T2NSu+/iNOAFlZTs75i0qSwr4KFB1DRfmuIt9/y0qb
 boyNKaMMqqhGiou1Xz/tpFCN8q+qdZkACkP9NRZyc5Z+ZPa/sZ/Z+1OMuVUMaQvJWnyBi7Yo+ik
 /G9bPGfcWNpqwka/S78eMWQvct5k7mPQADA6HWOvkgDkkzllI23aaiyB1JPeDQ216FcfrNztqTB
 WTqBnq65J2JhG2cExTquCQvLChvECmPWNu3rnn39kzruhGwQLTrVrBDta9A6TyFRxG3aZ6LjgNt
 qWnfQwxvx09LKEpFcWsHrjakFeMKdpiPwGbCS209J/qeKXZtl6463xaUvImKKT3oPMN1Nd4KugJ
 z1V5kVpdxcj4GdWNTOtkQYZ5dwODkjCHmnke5
X-Received: by 2002:a17:907:97d1:b0:b87:1f21:f09d with SMTP id
 a640c23a62f3a-b8dab195a15mr283193366b.19.1769574399031; Tue, 27 Jan 2026
 20:26:39 -0800 (PST)
MIME-Version: 1.0
References: <145501C2-B034-44EC-A16D-4F1A150347FB@wolfssl.com>
 <CAFLszTjgsSj47P6u2JohHv3vV1=sOWQxQ7qS3RDuBYBQsejKWA@mail.gmail.com>
 <CANqXHyEShK3bCA-5K4K=zH_b19i9+o9DRPYW8LHo-gFpMB2Hkg@mail.gmail.com>
 <CANqXHyH3OwPEpo=rv6E+uSP01quOQisEJ3_aD2-r=DkNDK4_+g@mail.gmail.com>
 <CAC_iWjLKotX4X9mD1qnJbnkbh9xBHfnyF+b=b--XvMjjbCrU-g@mail.gmail.com>
 <CANqXHyGZSGybzchkqSE0-7s3HgfY=UBjpkjS1wjuRkZzOLDMWQ@mail.gmail.com>
 <430A021B-7511-4C08-B30C-72C153A25A27@wolfssl.com>
In-Reply-To: <430A021B-7511-4C08-B30C-72C153A25A27@wolfssl.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 28 Jan 2026 04:26:27 +0000
X-Gm-Features: AZwV_QgiOJ7eUxoEiO-m5YeKFOWnpClqCWR6kWLT8IcCqWOkp39uIY2bNjf_-PM
Message-ID: <CALeDE9M7ENPccTD18b3YKrvYEu8yU0cXT1ePXM_tagV4Ou+Z0w@mail.gmail.com>
Subject: Re: U-Boot support for wolfTPM and firmware update for SLB9672/SLB9673
To: David Garske <david@wolfssl.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Todd Ouska <todd@wolfssl.com>, Larry Stefonic <larry@wolfssl.com>, 
 Wolfram Kusterer <wolfram@wolfssl.com>, Aidan Garske <aidan@wolfssl.com>
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

Hi David,

> We have made the U-Boot changes requested and attached a patch for upstre=
am. Let me know if you have any issues or questions.

Please send the patch using 'git send-emaiil' or a similar tool.

Regards,
Peter

> Fork: https://github.com/aidangarske/u-boot/tree/rpi4-wolftpm-uboot
> Instructions: https://github.com/aidangarske/rpi4-wolftpm-uboot/tree/mast=
er
>
> =EF=BF=BC
>
> Thanks,
> David Garske
> Software Engineer, wolfSSL
> +1 (530) 409-2990
> https://www.wolfssl.com <https://www.wolfssl.com/>
> https://github.com/wolfssl
>
> > On Aug 5, 2025, at 8:31=E2=80=AFAM, Aidan Garske <aidan@wolfssl.com> wr=
ote:
> >
> > Hi Ilias,
> >
> > Sounds good, I will keep them in cmd/wolftpm.c. I guess Simon can proba=
bly answer the other question the best.
> > He had asked if I could "put the driver code into drivers/ with just th=
e command code in cmd/" so I am just trying
> > to get clarity on what driver code he is specifically referring to.
> >
> > Thanks for the help,
> > Aidan
> > -------------------------------------
> > Aidan Garske
> > Engineering Intern, wolfSSL
> > +1 (916) 337-1246
> > -------------------------------------
> >
> >
> > On Tue, Aug 5, 2025 at 1:17=E2=80=AFAM Ilias Apalodimas <ilias.apalodim=
as@linaro.org <mailto:ilias.apalodimas@linaro.org>> wrote:
> >> Hi Aidan,
> >>
> >>
> >> On Sat, 2 Aug 2025 at 01:59, Aidan Garske <aidan@wolfssl.com <mailto:a=
idan@wolfssl.com>> wrote:
> >> >
> >> > Hi Simon and Ilias,
> >> >
> >> > Thank you for the great feedback. Currently I am working in the refa=
ctor you suggested and I wanted to ask a question about some of your commen=
ts.
> >> >
> >> > 1. What exactly is the "driver code" you are referring to in this ca=
se?
> >> > 2. Do you want me to separate out our helper functions into a `cmd/w=
olftpm-common.c` or should I keep them in `cmd/wolftpm.c`?
> >> >
> >> > Looking forward to your response,
> >> > Aidan
> >> > -------------------------------------
> >> > Aidan Garske
> >> > Engineering Intern, wolfSSL
> >> > +1 (916) 337-1246
> >> > -------------------------------------
> >> >
> >> >
> >> > On Wed, Jul 30, 2025 at 8:40=E2=80=AFAM Aidan Garske <aidan@wolfssl.=
com <mailto:aidan@wolfssl.com>> wrote:
> >> >>
> >> >> Hi Simon,
> >> >>
> >> >> Thank you for the great feedback. Currently I am working in the ref=
actor you suggested and I wanted to ask a question about some of your comme=
nts.
> >> >>
> >> >> 1. What exactly is the "driver code" you are referring to in this c=
ase?
> >>
> >> It's been a while and I am not sure I am following on that
> >>
> >> >> 2. Do you want me to separate out our helper functions into a `cmd/=
wolftpm-common.c` or should I keep them in `cmd/wolftpm.c`?
> >>
> >> Are you expecting it to be reusable by something else? If not just
> >> keep it to cmd/wolftpm.c
> >>
> >> Thanks
> >> /Ilias
> >>
> >> >>
> >> >> Looking forward to your response,
> >> >> Aidan
> >> >> -------------------------------------
> >> >> Aidan Garske
> >> >> Engineering Intern, wolfSSL
> >> >> +1 (916) 337-1246
> >> >> -------------------------------------
> >> >>
> >> >>
> >> >>
> >> >> On Sat, May 10, 2025 at 4:25=E2=80=AFAM Simon Glass <sjg@chromium.o=
rg <mailto:sjg@chromium.org>> wrote:
> >> >>>
> >> >>> Hi David,
> >> >>>
> >> >>> On Thu, 8 May 2025 at 00:41, David Garske <david@wolfssl.com <mail=
to:david@wolfssl.com>> wrote:
> >> >>> >
> >> >>> > Hi Denx,
> >> >>> >
> >> >>> > We at wolfSSL have developed a port for wolfTPM in U-Boot. The p=
atch allows using the current built-in TPM 2.0 support or switching to wolf=
TPM via CONFIG_TPM_WOLF=3Dy. It also supports TPM 2.0 firmware update for t=
he Infineon SLB9672 and SLB9673.
> >> >>> >
> >> >>> > I think there is probably some more cleanup and testing needed, =
but I wanted to submit this to start the discussion and see your thoughts.
> >> >>> >
> >> >>> > The wolfTPM library is GPLv2 and added as a submodule. If the li=
cense or submodule is an issue let=E2=80=99s discuss! I=E2=80=99m positive =
we can resolve anything.
> >> >>> >
> >> >>> > Attached is the patch based on latest master 3b6760ddeb4 to revi=
ew.
> >> >>>
> >> >>> Thank you for doing this!
> >> >>>
> >> >>> Here are a few thoughts:
> >> >>>
> >> >>> - Use lower case for function names
> >> >>> - Avoid camel case
> >> >>> - What is XMEMSET()? - Can you use memset() ?
> >> >>> - Convert most prinf() functions to log_debug()
> >> >>> - Can you use subcommands (from command.h) instead of parsing the
> >> >>> subcommand yourself?
> >> >>> - put the FIRMWARE_UPGRADE thing into Kconfig, as well as WOLFTPM_=
SLB9672/3
> >> >>> - put the driver code into drivers/ with just the command code in =
cmd/
> >> >>> - add config WOLFTPM, separate from CMD_WOLFTPM
> >> >>> - can you add a test in test/ and docs in doc/usage/cmd/  ?
> >> >>>
> >> >>> Regards,
> >> >>> Simon
> >> >>>
> >> >>>
> >> >>> >
> >> >>> > =EF=BF=BC
> >> >>> >
> >> >>> > Thanks,
> >> >>> > David Garske
> >> >>> > Software Engineer, wolfSSL
> >> >>> > +1 (530) 409-2990
> >> >>> > https://www.wolfssl.com <https://www.wolfssl.com/> <https://www.=
wolfssl.com/>
> >> >>> > https://github.com/wolfssl
> >> >>> >
>
