Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0D2C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 287A487A88;
	Thu, 28 Dec 2023 16:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BWDMAyTq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E3F887A88; Thu, 28 Dec 2023 16:09:54 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6447387A6E
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-781600ab3d8so101523185a.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 07:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703776191; x=1704380991; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYnhnt+sxtOocTMdqnptKxdJ0m9SJpYhIGQV3XxI1zc=;
 b=BWDMAyTquuV1lPjqLPnZNoi3h0H3Zlp9KXO3Q2YSF4sHCfRWqHCNhYSQDu8F1JYcLg
 ThFLq1I3w9ccJwnMcL1CzSYNC2ztmxsX4+P+L35wLfGmErfGsLaEK4EOwUgZgZYLieNl
 X33TuYD39WzCTEXOyS4yVJS+g+rdqsz4WUVbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703776191; x=1704380991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TYnhnt+sxtOocTMdqnptKxdJ0m9SJpYhIGQV3XxI1zc=;
 b=oj23fcISN7V+SS9+VkOOlTtYoM4kj6sTLsS6ei/Gk53RkdQn9ZO/PYttPqc4RsYrKs
 /11ddLJ4cjoI0qfnGVpOTFZ3Jy+d0lCy7xEYsqITJAHOtdppHM3pQNOPJ9ikf/vnKykJ
 wz9Ux87dOVwaFTxgUZgeNQ1eDL/UcGLepzrxFJmT2YnPbF3WbSeKVjtlFcULarozZVjM
 M+n+NdApJYOfTZWoZiaArmOIQklLAWaDGqlMoNNkaBeG+ZbxQqKCceFsAldqSjbuZv5D
 ja5zmwmQ/vYQuuPFoYGvgXqycwunAP6u46TRg+CG4/u5Rx2i+dh6In9x7fhCmtZiOsZ7
 Zb2g==
X-Gm-Message-State: AOJu0YzZc6C9V38o/1mPqyz73TBB1Pkv+sVSujR1umQQSIGKEAvmuT4n
 24fTXgumFE+5Lrdb37aH139kFBSlieek1+SyGiphgQjXycgO
X-Google-Smtp-Source: AGHT+IElELxUyV5AEdtRIG/GiIYdh4LuSnFw/TiLYCG6u12pjG+bXb3iUOt+dWcKii8Ho6MHpd6p7cE0Kr1/r6IL0O8=
X-Received: by 2002:a05:6214:e63:b0:67f:40f0:acb1 with SMTP id
 jz3-20020a0562140e6300b0067f40f0acb1mr15924657qvb.63.1703776191199; Thu, 28
 Dec 2023 07:09:51 -0800 (PST)
MIME-Version: 1.0
References: <20231227082405.2202246-1-sjg@chromium.org>
 <20231227132156.GQ2652760@bill-the-cat>
 <CAFLszThBrAVSH2jYxhxFSETqr4za+BqjZBBjLaDokc1ZdrXXRw@mail.gmail.com>
 <20231228142311.GD2652760@bill-the-cat>
In-Reply-To: <20231228142311.GD2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 15:09:40 +0000
Message-ID: <CAFLszTghB1ZObpxUe+afAp2zzQOfn2M9198ofsgnyW9cseG2Ew@mail.gmail.com>
Subject: Re: [PATCH 0/9] dts: Move to SoC-specific build rules
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 =?UTF-8?Q?Andreas_Bie=C3=9Fmann?= <andreas@biessmann.org>, 
 Michal Simek <michal.simek@amd.com>, Michal Simek <monstr@monstr.eu>, 
 Minkyu Kang <mk7.kang@samsung.com>, Scott McNutt <smcnutt@psyent.com>, 
 Thomas Chou <thomas@wytron.com.tw>
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

Hi Tom,

On Thu, Dec 28, 2023 at 2:23=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Dec 28, 2023 at 01:37:07PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, Dec 27, 2023 at 1:21=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Wed, Dec 27, 2023 at 08:23:56AM +0000, Simon Glass wrote:
> > >
> > > > U-Boot builds devicetree binaries from its source tree. As part of =
the
> > > > Kconfig conversion, the Makefiles were updated to align with how th=
is
> > > > is done in Linux: a single target for each SoC is used to build all=
 the
> > > > .dtb files for that SoC.
> > > >
> > > > Since then, the Makefiles have devolved in some cases, resulting in
> > > > lots of target-specific build rules. Also Linux has moved to using
> > > > subdirectories for each vendor.
> > > >
> > > > Recent work aims to allow U-Boot to directly use devicetree files f=
rom
> > > > Linux. This would be easier if the directory structure were the sam=
e.
> > > > Another recent discussion involved dropping the build rules altoget=
her.
> > > >
> > > > This series makes a start at cleaning up some of the build rules, t=
o
> > > > reduce the amount of code and make it easier to add new boards for =
the
> > > > same SoC.
> > > >
> > > > One issue is that the ARCH_xxx Kconfig options between U-Boot and L=
inux
> > > > are not always the same. Given the large number of SoCs and boards
> > > > supported by U-Boot, it would be useful to align these where possib=
le.
> > >
> > > I don't know why we should start with this now, and further not being=
 on
> > > top of Sumit's series to remove our duplicate dts files. And that's
> > > where we can have the conversation about for which cases it even make=
s
> > > sense to build all of the dts files for a given SoC.
> >
> > This is a completely different series - there are no conflicts with
> > Sumit's series so it can be applied before or after it.
> >
> > My goal here is to clean up our build rules, rather than just throwing
> > them all away, for reasons we have discussed previously. I filed [1]
> > to track that.
>
> Yes, I'm saying we shouldn't be doing anything this series does until
> after Sumit's series has landed. Along with the fact that I don't like
> what's going on in this series.

This seems to again be the disagreement over whether a single DT
should be build for each board, or all the DTs for an SoC?

Regards,
Simon
