Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A800C021B2
	for <u-boot@archiver.kernel.org>; Sun, 23 Feb 2025 14:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2CF180079;
	Sun, 23 Feb 2025 15:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hd19wXqe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB31780F3F; Sat, 22 Feb 2025 21:47:59 +0100 (CET)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B18380AE6
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 21:47:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jonathanbaror@gmail.com
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-866faa61728so1881851241.2
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 12:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740257276; x=1740862076; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tcLRcReYHNg+jHASaYLW15SWxOcxWSRO/Z6Fnu09K4c=;
 b=hd19wXqeBNYAEvQnmeMtCG0ZSJbJ/X48/A61jQLCOFjD1vHZ02HHwZi0Xgm38CfVgB
 V0vNRGTRvKY3aHguPfT+KlF5Vbhb93JnGlDshisdYPuJLhrGYfFASdlK3l0PQzilTMoQ
 WqGDPI2xkwG/ptLuRxbGJwpyGGwFBokaNPmwifmGXPPA1RcxRbauLcJH+1e+DfS1xMfR
 12J7EoQVt/rV8Ko+8xoJONB00gpIHVFIFg4w239kWLbLVQo87DRRr5RZBDdiBxGjTMfo
 NjTlYKkgdiFwc9qdFwTmVGI+WWMLia5Ukh9Yt8UF7oYBAsvvn3zYIXQhncbpkrU6RWC2
 c66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740257276; x=1740862076;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tcLRcReYHNg+jHASaYLW15SWxOcxWSRO/Z6Fnu09K4c=;
 b=Kw2Zw7JO3MRyfNObC6TavJXl/FTS/F4AdWD+7yIQD2dwprDCZRw/rOSqiH2d1Zjv8d
 7tubtOn6OK+3ohJfe6gNFQMC8GYtRoECCvxjECGaVBsPXIfSFe/rkdSJ2fI4XSuW1vbP
 G7OmErkcP61TVYhi7dODpWoL6WJVlhLN8cbopzhvNnd7qkVmW7KTdTd3dGkf11yKvfNa
 SFGOHGYVOzd2SXVDvoUpqeLhHPsoIR6wCRZadFyRigGW2Tqt3yDVEVJr7F51FF5HVClP
 rxdiUnVaEzt/ey2HBWygag6gZGDRUSVPFHiEdOsi8nyps1R0wTr2TntsyXFbT5patdme
 8TUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpq5OvQcAtDbni4CuLEG2j/I4ymkt1MyYMlWYlHEPFv57kxUF+3pIRbnf1bJ5MJAQktElRzxE=@lists.denx.de
X-Gm-Message-State: AOJu0YxsXSbbXBKTLvqMZ+IFlWwSp9gHofs+Yz7ezZmihMagRz1W5+fb
 lMM4BHunz9QnyTnmz/y5VGTfb9uItio1Eo0zh6+/pcdOVtTGdO/0wsJhURqBabU0a9nkUXZL5EG
 3pfBv18mKGxo8xgLWXzv/RtM0nl0=
X-Gm-Gg: ASbGncuahsDf45DHJXpEC2cOAZAKwTGYmV8RHKeHCV1BIZ4+zB84CnGDNo8jzvXJKXM
 qBxHMfqEcbMFWbInC3AmayIjRDPN9SHBuxVN9nLP3HLlFpnyOOkEQzICXr6YxU1SCKiKf0hTQ2w
 UM6sHlM+g2h9clRTrnT6bUX7wZ6Sh1gHOcn1+2sg==
X-Google-Smtp-Source: AGHT+IFq5w9QVYB027ZgOUqp+q6hXHguOwg+4CMia/YUW7un5v3K2GCkkIoG/lcYJ8vEziig2WnCj3PkX5kmS7lrxzw=
X-Received: by 2002:a05:6102:d8d:b0:4bb:e8c5:b162 with SMTP id
 ada2fe7eead31-4bfc00689b3mr4519512137.10.1740257276346; Sat, 22 Feb 2025
 12:47:56 -0800 (PST)
MIME-Version: 1.0
References: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
 <20250207155048.GX1233568@bill-the-cat>
 <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
 <20250210164151.GN1233568@bill-the-cat>
 <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
 <CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com>
 <20250211212909.GI1233568@bill-the-cat> <8734gjsh8t.fsf@bootlin.com>
 <CABMsoEGq+s2qudAHVwydpwXw_ROVfgw90yU7+VKYO6x27AWdew@mail.gmail.com>
 <CABMsoEFcL-D2OzJWQM685TfLq20L+d2gNmy4XD7yW6aDwpKb4w@mail.gmail.com>
In-Reply-To: <CABMsoEFcL-D2OzJWQM685TfLq20L+d2gNmy4XD7yW6aDwpKb4w@mail.gmail.com>
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Sat, 22 Feb 2025 12:47:45 -0800
X-Gm-Features: AWEUYZmxqtkIhHB2xdwy-6M0RUTehhAYi9TC1JJc0-bUL3X1fsJxX-lpnSyA0r8
Message-ID: <CABMsoEEQPvHM7jKYZZE1UaTgVTuN-TneVi8X9LRsr3+bD7xH3Q@mail.gmail.com>
Subject: Re: Security vulnerabilities report to Das-U-Boot
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, 
 Huang Jianan <jnhuang95@gmail.com>, Joao Marcos Costa <jmcosta944@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 23 Feb 2025 15:28:24 +0100
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

Hello Tom and team,

Looks like all of the issues were fixed and merged - am I correct?
I intend to make a public disclosure March 19th, is that okay?

Best,
       Jonathan

On Fri, Feb 14, 2025 at 7:24=E2=80=AFPM Jonathan Bar Or <jonathanbaror@gmai=
l.com> wrote:
>
> Please disregard the previous message, those are the actual CVE numbers:
>
> - CVE-2025-26726 :SquashFS directory table parsing buffer overflow
> - CVE-2025-26727: SquashFS inode parsing buffer overflow.
> - CVE-2025-26728: SquashFS nested file reading buffer overflow.
> - CVE-2025-26729: EroFS symlink resolution buffer overflow.
>
> Best regards,
>            Jonathan
>
>
> On Fri, Feb 14, 2025 at 7:17=E2=80=AFPM Jonathan Bar Or <jonathanbaror@gm=
ail.com> wrote:
> >
> > Hi folks.
> >
> > Here are the CVEs assigned by MITRE:
> > - CVE-2025-26721: buffer overflow in the persistent storage for file cr=
eation
> > - CVE-2025-26722: buffer overflow in SquashFS symlink resolution
> > - CVE-2025-26723: buffer overflow in EXT4 symlink resolution
> > - CVE-2025-26724: buffer overflow in CramFS symlink resolution
> > - CVE-2025-26724: buffer overflow in JFFS2 dirent parsing
> >
> > Best regards,
> >            Jonathan
> >
> > On Wed, Feb 12, 2025 at 12:24=E2=80=AFAM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hello Tom,
> > >
> > > On 11/02/2025 at 15:29:09 -06, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > > On Tue, Feb 11, 2025 at 08:26:37AM -0800, Jonathan Bar Or wrote:
> > > >> Hi Tom and the rest of the team,
> > > >>
> > > >> Please let me know about fix time, whether this is acknowledged an=
d
> > > >> whether you're going to request CVE IDs for those or if I should d=
o
> > > >> it.
> > > >> The reason is that I found similar issues in other bootloaders, so=
 I'm
> > > >> trying to synchronize all of them. For what it's worth, Barebox ha=
s
> > > >> similar issues and are currently fixing.
> > > >
> > > > Yes, these seem valid. We don't have a CVE requesting authority so =
if
> > > > you want them, go ahead and request them. You saw Gao Xiang's respo=
nse
> > > > for erofs, and I'm hoping one of the squashfs maintainers will chim=
e
> > > > in.
> > >
> > > Either Jo=C3=A3o or me, we will have a look.
> > >
> > > Thanks,
> > > Miqu=C3=A8l
