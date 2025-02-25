Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46A9C021A4
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 02:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12DBB80EC0;
	Tue, 25 Feb 2025 03:29:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q2GnmQTX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE1B580F56; Tue, 25 Feb 2025 03:29:41 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAFE280C66
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 03:29:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-abbae92be71so566457666b.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 18:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740450578; x=1741055378; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iKxGhqET2CvMRP5ImT/PYKWaLUz4sbuHBrLp14tYDpg=;
 b=Q2GnmQTX2afWMyk+/tlPG+1YIiq0HqShhWSQuxS0FkH0iluXlwee61LwNfCShVgHBq
 DhxbtsO8vyeHnLY5U19Ae7ccmG7C5GvIxYVICyKUAK0zWZkimOKZNurOS4B6uPQxC7WY
 CSAFgKbURnmrm8jypeNeOXHIqIERKnklknufWcahvPkBbWKrPRcMEziSaHRYUhFBcQeG
 veTE/IAuDRL2d6qgzhDBFs8LYTOXNFBBwji3RKpdBJEt3o/8VcyuxbHMxOQ3KaymPIy0
 bWo06norMw4rTZx1WTcHMmYm5V+UWjosIF3uglY8cIWJAc+ZvR4qY8krH8oF4lh+SIo8
 gF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740450578; x=1741055378;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iKxGhqET2CvMRP5ImT/PYKWaLUz4sbuHBrLp14tYDpg=;
 b=dCn8Z/YRK7ljgz79VA22g7+U2P7VitxFcD+XdovoLRMhZivTlLFxTNakG1WHtvnb5R
 Ld3lW2w2u4T1TYLNBs4qepx9xDSTyh/AMjLV/v7bsimmgs/C/KOSTksCcaG6jIg9/7D+
 LJiMhyLaAo9uHRXVgi+qSalnrVHPQMb/deGFZJCacxCMi3KPR5LfTeklLxvD0FJiC1bz
 hJa+iyP/MiwUILwbxIQIxlq3xxJxF3vpgP/n6USeWUXtBJJwlT32wdDKJSTm7HhlciCh
 tQLFucro8JThDp8GtOO2fLcJduTESAC9CpiT0+lyywFvd5jf/ZyO2Bhk/gS75S//aZP4
 HZIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp/gbUNJSpl/TxxyClBEv5HUF+50aMINWKLVNzB2u6tb1sl6BzNmaneDLb5ay7/2BHrKtr9w4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/k6jyuoYOZ1YsJ4kfNyQYvrMnswms47Skz7WPLnq6U82AZq2N
 EMq5Oatml6V3NR9peQwqV953fAJl9oijRwPSsl5FMbNIlFt/wT9KsXpKqW4hspWM/FDx6uixtv9
 oJa0uEk8d3JI5WeJCgSOmzHz6twA=
X-Gm-Gg: ASbGncvoEu75lsx4JHwElGD+1YclacNfDaugvHnK13C9iXsKAgK3HM52ab2kvI5gT4c
 Z8BXBCbvTaQc1sNzDK4O2+RBKPV+zsAHTg5e6KkKVzdiK7WJrqxxgyT2YMvfm+l4WMoLptYnkfA
 G2S3BrO68QMG06cG8cnc1h6SpAXoqRr6Q/RvkDj1Sl
X-Google-Smtp-Source: AGHT+IHLLKaN8la2vv7SfeLCTYt2nhhmNttntSd60VRr5ayZCa2Xx7M4554px0xFtD1LKIgM+WohCd8N3QOyfY5LfCk=
X-Received: by 2002:a05:6402:350f:b0:5d0:bf5e:eb8 with SMTP id
 4fb4d7f45d1cf-5e44a256d6amr2630639a12.23.1740450577924; Mon, 24 Feb 2025
 18:29:37 -0800 (PST)
MIME-Version: 1.0
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-10-CFSworks@gmail.com>
 <3382d476-c1b3-461a-b8f0-c47cccb6899d@gmx.de>
 <20250224145407.GC1233568@bill-the-cat>
In-Reply-To: <20250224145407.GC1233568@bill-the-cat>
From: Sam Edwards <cfsworks@gmail.com>
Date: Mon, 24 Feb 2025 18:29:26 -0800
X-Gm-Features: AWEUYZl_EsPTOFd6aStvdB-gBZJ7TDkX2gX2IQP_joktJBklPnhN-Qr_R5NX5-E
Message-ID: <CAH5Ym4h7Q=4jiQP4YCXn7PSFtt8i+UbCoMnDuzjUOJxJSMVecw@mail.gmail.com>
Subject: Re: [PATCH 09/17] spl: riscv: opensbi: Error on misaligned FDT
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Rick Chen <rick@andestech.com>
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

On Mon, Feb 24, 2025 at 6:54=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Mon, Feb 24, 2025 at 09:54:56AM +0100, Heinrich Schuchardt wrote:
> > On 2/24/25 06:55, Sam Edwards wrote:
> > > libfdt 1.6.1+ requires the FDT to be 8-byte aligned and returns an er=
ror
> > > if not. OpenSBI 1.0+ includes this version of libfdt and will also
> > > reject misaligned FDTs.
> > >
> > > However, OpenSBI cannot indicate the error to the user: since it cann=
ot
> > > access the serial console, it can only silently hang. This can be ver=
y
> > > difficult to diagnose without proper debugging facilities. Therefore,
> > > give the U-Boot SPL, which *can* print error messages, an additional
> > > check for proper FDT alignment.
> > >
> > > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > > ---
> > >   common/spl/spl_opensbi.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > >
> > > diff --git a/common/spl/spl_opensbi.c b/common/spl/spl_opensbi.c
> > > index 5a26d7c31a4..0ed6afeacc6 100644
> > > --- a/common/spl/spl_opensbi.c
> > > +++ b/common/spl/spl_opensbi.c
> > > @@ -57,6 +57,11 @@ void __noreturn spl_invoke_opensbi(struct spl_imag=
e_info *spl_image)
> > >             hang();
> > >     }
> > >
> > > +   if (!IS_ALIGNED((uintptr_t)spl_image->fdt_addr, 8)) {
> > > +           pr_err("SPL image loaded an improperly-aligned device tre=
e\n");
> >
> > We only use pr_err() in drivers when we copy code from Linux. Otherwise
> > use log_err().
> >
> > As this code is for RISC-V, this patch should have been sent to the
> > RISC-V maintainers.
> >
> > cc: Leo, Rick
> >
> > SPL size is very restricted on boards where it is responsible for
> > initializing DRAM and therefore has to fit into cache. We should only
> > add code that is strictly needed to SPL.
> >
> > What makes you think that this problem can realistically occur?
>
> I would like to know if Sam hit this in practice as well. But we have
> had more than one place where because we don't ensure 8-byte alignment
> and have use-in-place, that we've broken things. Picking up one of the
> patches that would address this within U-Boot is on my list now that
> we've had confirmation of some padding command that's sufficiently
> portable.

Hi gents,

I have indeed hit this in practice; I will elaborate how in my reply
to patch 10/17. But this whole series is sanding down various sharp
corners that snagged me while trying to build with LLVM. :)

I agree with the aim of conserving space in the SPL, but since I spent
a fair amount of time debugging why OpenSBI was hanging, I believe the
need for a sanity check on the assumption of 8-byte alignment *before*
passing control to OpenSBI is the greater concern. I would be more
favorable to putting an assert in the common SPL code; my only aim
here is to catch this problem with a diagnosable error message, as I
suspect we have not seen the last of it.

Cheers,
Sam

>
> --
> Tom
