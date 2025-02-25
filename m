Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4040BC021BB
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 20:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52C6C80977;
	Tue, 25 Feb 2025 21:43:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ft1L9Pf5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C4668081A; Tue, 25 Feb 2025 19:18:21 +0100 (CET)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA92E807EE
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 19:18:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jonathanbaror@gmail.com
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4be5556aa27so1631144137.3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 10:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740507497; x=1741112297; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mmwS2AkQSbqBck5DcD/kPL98u8U+cAdcaPfJ+vFuQC0=;
 b=Ft1L9Pf5xNtP1hr8Q48FZdjvCkr4qbseBGr4iTt2BQr9gdJFWkkxAZFZMz141bvEtS
 osLdDFXxNihd/Tu0ykUxEaMGv8m0hmvjGjVVvTmb3er3ZVkpK4Wn5K+dhWCiQ3n3NZvC
 bGuNSKeg2ze51i4WbvSFyF4tZJq2zGJD/4HKveg36o9Z5GSMvNqRQUCIZ5RfQVJBCQyG
 VzCoNic+vgeOL4v1QSmNO4JNV9/pcK44qRDJgaxKq4eMS00cpWegb5ykARapknnGu4/i
 1uGI/YZX/C0eeF4w8r7q/TGeRdnPWxdcvPYhBAfZR2WRSKihZVkyu2WS3M+MKwJUIiJ7
 voKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740507497; x=1741112297;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mmwS2AkQSbqBck5DcD/kPL98u8U+cAdcaPfJ+vFuQC0=;
 b=YSp7P6UEgBImQXgwxDDi5RPvzxvFLp7MwFbaUQzxQzn29YFIGFv9eNh/M0jY9IyVOk
 mbnw4aR0OXDRjLekX45Zphik78I1Fld3PG9jswRso5vZDoPTMiucqAIydHQRtURz1FZU
 al5wkOkBJ8l7FZwFs8VEJcsBnmiqJ2VXsHrUaemM+73G4dJSBzybmrHL5dYw4uZwwk3v
 oLFE2zDXIE3TnXl4tT0cttIVWt8mKypT8K4+EM9amhE6QM4VINmxWrMBO3vh0fTZlT75
 DyThOizmGP4Yrh/XZf+vfiOAvjGwaYfNIqDvLgMJ0fjdynMMV+G7MkP8kpQr/p5pc0Bb
 8Oqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhgxYDYlvbZb9zjqIWR6+VO9U9astMnlg9WRY82NOH0rKfWr5F4xLp4gvJeNwWpMWFeNOOMTA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx22KNYdTeN5hnxU5czc2xUnCIuM4/sDPXigORAW000CuKqP6kK
 i5BEZpPWEc403Tqxy1MwbhYCvuX3l/lcUk7/Z2YufKCoB0g1fR8qQg+lFiminuzr7Ry/0xgaLgP
 0O8I1L49VJ6lVqwz8lDGlwUpZCts=
X-Gm-Gg: ASbGnctkzzZ5hj6fRl5hvoxLTvSsVN5s9F0jH8JsSDAVliaYqu25SFRgLZibQO/h3UJ
 Pj2KacgqLIiOyn560JMczdLKQWC9Y8of6GzRDv56H5z3MZ3Kz/NvxoVsZZmoHofKuLKJRglRUVh
 y/J2W0tX1aHwiHFn9VkLRfmNypuj2Kq4nJ+/oR
X-Google-Smtp-Source: AGHT+IGdVZPzAjvIPrpUHJMFObAoP7915Ib/5ZeV8XkqWoteqSHyRAp5B8xR2CpjEX1rS8BiZz9lKwGHdxc5xj0shyo=
X-Received: by 2002:a05:6102:a48:b0:4bb:d7f0:6e7d with SMTP id
 ada2fe7eead31-4c01e2fa034mr183842137.25.1740507497609; Tue, 25 Feb 2025
 10:18:17 -0800 (PST)
MIME-Version: 1.0
References: <20250207155048.GX1233568@bill-the-cat>
 <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
 <20250210164151.GN1233568@bill-the-cat>
 <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
 <CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com>
 <20250211212909.GI1233568@bill-the-cat> <8734gjsh8t.fsf@bootlin.com>
 <CABMsoEGq+s2qudAHVwydpwXw_ROVfgw90yU7+VKYO6x27AWdew@mail.gmail.com>
 <CABMsoEFcL-D2OzJWQM685TfLq20L+d2gNmy4XD7yW6aDwpKb4w@mail.gmail.com>
 <CABMsoEEQPvHM7jKYZZE1UaTgVTuN-TneVi8X9LRsr3+bD7xH3Q@mail.gmail.com>
 <20250225175918.GQ1233568@bill-the-cat>
In-Reply-To: <20250225175918.GQ1233568@bill-the-cat>
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Tue, 25 Feb 2025 10:18:06 -0800
X-Gm-Features: AQ5f1JozKP8s1krTh-yyiWCUjRRD4jXvWfTY-N6OgYhiH7MBQSOwMksWfr1KoMc
Message-ID: <CABMsoEE-WD00LDKVrk9+JcEz09LPEBn=VLut4kziaWPExejdcQ@mail.gmail.com>
Subject: Re: Security vulnerabilities report to Das-U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>, 
 Huang Jianan <jnhuang95@gmail.com>, Joao Marcos Costa <jmcosta944@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 linux-erofs@lists.ozlabs.org
X-Mailman-Approved-At: Tue, 25 Feb 2025 21:43:02 +0100
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

Awesome, thanks for the update!

On Tue, Feb 25, 2025, 9:59=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote:

> On Sat, Feb 22, 2025 at 12:47:45PM -0800, Jonathan Bar Or wrote:
>
> > Hello Tom and team,
> >
> > Looks like all of the issues were fixed and merged - am I correct?
> > I intend to make a public disclosure March 19th, is that okay?
>
> Yes, I've merged all of the patches I'm aware of at this point.
>
> >
> > Best,
> >        Jonathan
> >
> > On Fri, Feb 14, 2025 at 7:24=E2=80=AFPM Jonathan Bar Or <jonathanbaror@=
gmail.com>
> wrote:
> > >
> > > Please disregard the previous message, those are the actual CVE
> numbers:
> > >
> > > - CVE-2025-26726 :SquashFS directory table parsing buffer overflow
> > > - CVE-2025-26727: SquashFS inode parsing buffer overflow.
> > > - CVE-2025-26728: SquashFS nested file reading buffer overflow.
> > > - CVE-2025-26729: EroFS symlink resolution buffer overflow.
> > >
> > > Best regards,
> > >            Jonathan
> > >
> > >
> > > On Fri, Feb 14, 2025 at 7:17=E2=80=AFPM Jonathan Bar Or <
> jonathanbaror@gmail.com> wrote:
> > > >
> > > > Hi folks.
> > > >
> > > > Here are the CVEs assigned by MITRE:
> > > > - CVE-2025-26721: buffer overflow in the persistent storage for fil=
e
> creation
> > > > - CVE-2025-26722: buffer overflow in SquashFS symlink resolution
> > > > - CVE-2025-26723: buffer overflow in EXT4 symlink resolution
> > > > - CVE-2025-26724: buffer overflow in CramFS symlink resolution
> > > > - CVE-2025-26724: buffer overflow in JFFS2 dirent parsing
> > > >
> > > > Best regards,
> > > >            Jonathan
> > > >
> > > > On Wed, Feb 12, 2025 at 12:24=E2=80=AFAM Miquel Raynal
> > > > <miquel.raynal@bootlin.com> wrote:
> > > > >
> > > > > Hello Tom,
> > > > >
> > > > > On 11/02/2025 at 15:29:09 -06, Tom Rini <trini@konsulko.com>
> wrote:
> > > > >
> > > > > > On Tue, Feb 11, 2025 at 08:26:37AM -0800, Jonathan Bar Or wrote=
:
> > > > > >> Hi Tom and the rest of the team,
> > > > > >>
> > > > > >> Please let me know about fix time, whether this is acknowledge=
d
> and
> > > > > >> whether you're going to request CVE IDs for those or if I
> should do
> > > > > >> it.
> > > > > >> The reason is that I found similar issues in other bootloaders=
,
> so I'm
> > > > > >> trying to synchronize all of them. For what it's worth, Barebo=
x
> has
> > > > > >> similar issues and are currently fixing.
> > > > > >
> > > > > > Yes, these seem valid. We don't have a CVE requesting authority
> so if
> > > > > > you want them, go ahead and request them. You saw Gao Xiang's
> response
> > > > > > for erofs, and I'm hoping one of the squashfs maintainers will
> chime
> > > > > > in.
> > > > >
> > > > > Either Jo=C3=A3o or me, we will have a look.
> > > > >
> > > > > Thanks,
> > > > > Miqu=C3=A8l
>
> --
> Tom
>
