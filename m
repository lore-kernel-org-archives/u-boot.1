Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEE8C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 21:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3918059D;
	Thu, 15 May 2025 23:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hu9KQ6Am";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B477806D8; Thu, 15 May 2025 23:31:00 +0200 (CEST)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE63480050
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 23:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-4ddc845dd45so475561137.3
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 14:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747344654; x=1747949454; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=agf7jX6K+XBAHSMnL2Xfh9bJA43S/6CIKtXJxHbChY0=;
 b=Hu9KQ6AmWCgem2E8rYwGKQT6qyURTwmUeOgo1mntY0daEw/hhH7+TLESoDAKQS9mbp
 KYDbdhT3UUvMpxE9cMb0AkM/m3doJAD0zl2om4g+Du4wzvCm1esuQLhxLUWG1RB3Q6Cv
 ENhFQchiQCeZGawDKPXxzQx2/kXcdTa1uw5dqYeK/cXwzC+/p9QdNvY5j81TzHXwktJD
 PaVvemIYhep9DiwpQ0v8+o3t4fB5mZ+5LBzSla/DtLdeR5tOwPQKX3tDQG0PLOYCdwRN
 pX2Pkrgj1dR2gfvrpg4QgIYLUqozJtyB8cfm2NeC333d2ONGGywFZj5U3TJs+g27oHhH
 jtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747344654; x=1747949454;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=agf7jX6K+XBAHSMnL2Xfh9bJA43S/6CIKtXJxHbChY0=;
 b=nolDkxwMbUoy5If+9q60jSEGtWzsnfDnCWxTLtWJTkhakHcjqnKa/AhYrF18rI4xH5
 MDxfftsPbd2lbDsAenuT10JrR+RaSsExmQAcBbUpmQUKIUec84s2nnHlJVRueK6Fe//R
 rtz901odywspBEPhuibPbYB+V765xbgIDFmI1oT0lFCvHbZ4cHgxirgBCFhkAtT2tIBs
 MJuc/lsWVvHopui4Z7qeWl+e5TNXPsAuMCtw29BbVQ61ozhdB+ofro08PghL+hwvFUiv
 /sIyUdm8DSqYSmNH2kWbzp0jGc+WtfeYCuQRiIexjrW1NONCz5s+51FsTHEv32gRWTBO
 LVqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVznZEsH/hv+InnWbzKMN/TP+hoTMCKD+flfbpeZe37BqDBB2xgfOZS0iULFxRnNZCjk9W5opE=@lists.denx.de
X-Gm-Message-State: AOJu0YzZS5bWGpvMWNnQLmHNY/UxSeQPdr/D1UkdLdrNEuVg5buwAon4
 PtdBx/+d+ufyjppHP+0XYB5mvoqwcK/3Snmo5xNrDlPu1YkntowBPDB/OeMwSsjSjPqSVhC70To
 Kxoa3vnQUTGPVDUfYME/Z1pczaW2Dy/0=
X-Gm-Gg: ASbGncssEWnuIvkWtTJHuQZP45aNUTDzZ9GLMgoB+efUNT2goyW0BFmkLpEIzaEb9u1
 p7U9EpnAyYmvaYatVMx0uVVBQD/I+m0uMv1g5VKRP+4uqRsdcpaGGB1cfqgNGLeSt9lDkzBboDA
 q3aMx2ef99/lJ0SzpqYlwKfqsTueze96h9
X-Google-Smtp-Source: AGHT+IGQE6u89uyUhwRRU6xVnXM7lfWDCAp7Q1zJ/6ZCMfTTFPVLsb530pRpJqPfTbusqqDt1WiJRoKbdxzhJL+nUkc=
X-Received: by 2002:a05:6102:f14:b0:4dc:9486:b055 with SMTP id
 ada2fe7eead31-4dfa693fba4mr2624146137.0.1747344654417; Thu, 15 May 2025
 14:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250505100852.9364-1-aristo.chen@canonical.com>
 <0cb64c56-8f11-4cff-b1a6-a1b6a4194c86@cherry.de>
 <CAFLszTg-4HKF0ZD9h0h2LVSGsSv0adX_=6B84EX6wuGP=oQxzg@mail.gmail.com>
 <c91a8565-7bbc-43c2-8aab-fdb32fbe995f@cherry.de>
 <20250515-contently-headlock-12cc2640f050@thorsis.com>
In-Reply-To: <20250515-contently-headlock-12cc2640f050@thorsis.com>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Thu, 15 May 2025 23:30:18 +0200
X-Gm-Features: AX0GCFvTWCu07aTV3VEVpjiYrzVSzk67Uf-UV2bbr09796a_ECUp0q8vc4whHqY
Message-ID: <CAJwFiGKFoWsyRKrLjj-w0S7BovMk2MNp3NTYZKq3PVgV014tNA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools: mkimage: validate image references in FIT
 configurations
To: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <jj251510319013@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, carlos.lopezr4096@gmail.com, aristo.chen@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 15 May 2025 23:48:32 +0200
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

Alexander Dahl <ada@thorsis.com> =E6=96=BC 2025=E5=B9=B45=E6=9C=8815=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8812:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hei hei,
>
> Am Thu, May 15, 2025 at 09:35:34AM +0200 schrieb Quentin Schulz:
> > Hi Simon,
> >
> > On 5/14/25 9:44 PM, Simon Glass wrote:
> > > Hi,
> > >
> > > On Tue, 13 May 2025 at 17:28, Quentin Schulz <quentin.schulz@cherry.d=
e> wrote:
> > > >
> > > > Hi Aristo,
> > > >
> > > > On 5/5/25 12:08 PM, Aristo Chen wrote:
> > > > > When parsing a FIT image source (ITS), mkimage does not currently=
 check
> > > > > whether the image names referenced in the /configurations section=
 (e.g.
> > > > > "kernel", "fdt", "ramdisk", "loadables") actually exist in the /i=
mages
> > > > > node.
> > > > >
> > > > > This patch introduces a validation step during FIT import that it=
erates
> > > > > over each configuration and verifies that all referenced image na=
mes are
> > > > > defined under /images. If a missing image is detected, an appropr=
iate
> > > > > error is reported and mkimage exits with FDT_ERR_NOTFOUND.
> > > > >
> > >
> > > One option (for boards which use Binman) would be to put these sorts
> > > of checks in there, since it might be easier to code? But having it i=
n
> > > mkimage as well seems reasonable to me.
> > >
> >
> > mkimage can be used to generate images from outside of U-Boot. I believ=
e
> > this is what Yocto does for example to generate kernel FIT (see
> > UBOOT_MKIMAGE and others), so having an additional check in mkimage is
> > probably a good idea.
>
> Not sure about Yocto, but ptxdist [1] does exactly this: using mkimage
> to build signed FIT images, even if U-Boot is not used as bootloader.
>
> (ptxdist also uses mkimage when optionally packing U-Boot scripts.
> Those need to be put into an image so U-Boot can execute it.)
>
> Greets
> Alex
>
> [1] https://www.ptxdist.org/

Thank you very much for the reviews and all the helpful suggestions!

Previously, I verified my patch using `./test/py/test.py -ra --bd
sandbox --build`, and AFAICT everything looked fine. However, I just
ran `make tests` and noticed that my patch causes some binman related
test failures.

I'll take some time to investigate the root cause before sending out
the v2 patch.

Best regards,
Aristo
