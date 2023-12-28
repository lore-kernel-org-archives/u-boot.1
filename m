Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71390C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C25A879F9;
	Thu, 28 Dec 2023 16:10:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c1Qq/BjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 165F487A9C; Thu, 28 Dec 2023 16:09:59 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D778C87A68
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-67f8d9fe99fso45945786d6.2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 07:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703776195; x=1704380995; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pkz4J/8+nVEQpXVgepevNMHhqJX8dafT9AM54x7SEto=;
 b=c1Qq/BjCUDkCPoG8xXAYuwwSvrMu3zuukVO/z0wk+36975sPpPGMyFg4xBBnY5Q7Jv
 16DG07sZ7B3coIna2F+ZCC08XEzjn0pSGFIaBbYJGosSKcLDIRI8FWT3jKV/NqDaKVOv
 nE8Rb5w2vy2FE05ZVXPaLQkT4MunjPluE2KbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703776195; x=1704380995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pkz4J/8+nVEQpXVgepevNMHhqJX8dafT9AM54x7SEto=;
 b=DBPDZfa7Ky5nwBLAFTwdalUOZXGUdLsHv6KTl4FrTYHJU6HiPDCshb83wKAClTSlGE
 vYtDu9Qj3eKBXCAw5xUTnj7UXMBbeI9Zrz9SiTxvRtKTmp1wH+TwdaHEvDE7knXndO7g
 0tVEBc/BciY4yoOFqQfT7pD13nPI0tplyZ4ZsfAMPDE/ehCnSh9zTeyk9aLDqkDsp8zf
 2qE/kSSKcuQIYQ/8Abje8/a71bGffGczsxRDFPBdnU2XcBEzXSMZAkXK1aorzMIqs4pq
 ypljwt21+mAJJLiIEtXkEgNRZrZRq2hg5r6BRGGxsRCZ0mm8jpBLvYYsGjEoqpUeLwia
 HmeA==
X-Gm-Message-State: AOJu0Yx7gkRYm1Wd4GiQLdvuWNY3jcDIoFBg30x2dJziz0dwOwLW+TwH
 cUDd5BGUaoBxAauGgXsgSmQ4Vplvu20nYUhgGUaSMw7t4SYy
X-Google-Smtp-Source: AGHT+IF+EUmIQBbgYA2yZyw1wByyIN6OJC1V+ePchYDe52P3I/7IDQbErrr8UDjUdCIjF1FB4PuRBLS7YCrwQPQ/gSs=
X-Received: by 2002:a0c:d7cd:0:b0:67f:f29f:93d6 with SMTP id
 g13-20020a0cd7cd000000b0067ff29f93d6mr6213099qvj.129.1703776195637; Thu, 28
 Dec 2023 07:09:55 -0800 (PST)
MIME-Version: 1.0
References: <20231226094625.221671-1-sjg@chromium.org>
 <20231226120710.GH2652760@bill-the-cat>
 <CAC_iWjLy1E9wEW3zX2waN9mc=tz7PTKE0gJ4RucqMmZR2cA6_Q@mail.gmail.com>
 <CAFLszTgqS9TF1F-RxO1dpZPZGG6QBiKm0n_e0yVHAume+xT3eA@mail.gmail.com>
 <20231227201130.GV2652760@bill-the-cat>
 <CAFLszThJc04Zh1tFA4Cp7+oKVv2oKtk2015F37eMzPcXgqW7bw@mail.gmail.com>
 <20231228134809.GZ2652760@bill-the-cat>
In-Reply-To: <20231228134809.GZ2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 15:09:45 +0000
Message-ID: <CAFLszTj+gVLyGr82mf5VT3KS86pkH+gjpM525o973WKYQcNv4w@mail.gmail.com>
Subject: Re: [PATCH v4] fdt: Allow the devicetree to come from a bloblist
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>,
 Baruch Siach <baruch@tkos.co.il>, 
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Qu Wenruo <wqu@suse.com>, Sean Anderson <seanga2@gmail.com>
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

On Thu, Dec 28, 2023 at 1:48=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Dec 28, 2023 at 01:37:39PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> >
> > On Wed, Dec 27, 2023 at 8:06=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Wed, Dec 27, 2023 at 05:48:42PM +0000, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, Dec 26, 2023 at 12:07=E2=80=AFPM Tom Rini <trini@konsulko.c=
om> wrote:
> > > > >
> > > > > On Tue, Dec 26, 2023 at 09:46:25AM +0000, Simon Glass wrote:
> > > > >
> > > > > > Standard passage provides for a bloblist to be passed from one =
firmware
> > > > > > phase to the next. That can be used to pass the devicetree alon=
g as well.
> > > > > > Add an option to support this.
> > > > > >
> > > > > > Tests for this will be added as part of the Universal Payload w=
ork.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > > The discussion on this was not resolved and is now important du=
e to the
> > > > > > bloblist series from Raymond. So I am sending it again since I =
believe
> > > > > > this is a better starting point than building on OF_BOARD
> > > > >
> > > > > I really don't like adding another option for "DT is given to us"=
. Why
> > > > > isn't adding another enum to fdt_source_t sufficient
> > > >
> > > > That is added by this patch, but...
> > > >
> > > > >, and if we have
> > > > > bloblist enabled, that will look for and use if found?
> > > >
> > > > ...this is the question. I would like to be able to enable bloblist
> > > > without *requiring* the DT to come from there, hence the separate
> > > > Kconfig option.
> > > >
> > > > > Maybe some other
> > > > > code needs to be restructured and cleaned up too?
> > > >
> > > > Possibly, but I really am not keen on this board-specific solution.=
 I
> > > > believe Ilias & I agreed that OF_BOARD should fade away, so I don't
> > > > like adding another thing onto it.
> > >
> > > I think you're missing something then. It should not be board specifi=
c
> > > to just find the dtb via bloblist, without a new CONFIG.
> >
> > Yes, that is what I am looking for.
> >
> > > Whatever is
> > > stopping that is what needs to be refactored and then you can just
> > > extend fdt_source_t without a new CONFIG option.
> >
> > OK, but I need a way to turn it off, at least for development.
> >
> > [merging in the other thread:]
> >
> > On Wed, Dec 27, 2023 at 8:11=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Wed, Dec 27, 2023 at 05:48:44PM +0000, Simon Glass wrote:
> > > > Hi Ilias,
> > > >
> > > > On Wed, Dec 27, 2023 at 6:44=E2=80=AFAM Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 26 Dec 2023 at 14:07, Tom Rini <trini@konsulko.com> wrote=
:
> > > > > >
> > > > > > On Tue, Dec 26, 2023 at 09:46:25AM +0000, Simon Glass wrote:
> > > > > >
> > > > > > > Standard passage provides for a bloblist to be passed from on=
e firmware
> > > > > > > phase to the next. That can be used to pass the devicetree al=
ong as well.
> > > > > > > Add an option to support this.
> > > > > > >
> > > > > > > Tests for this will be added as part of the Universal Payload=
 work.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > > The discussion on this was not resolved and is now important =
due to the
> > > > > > > bloblist series from Raymond. So I am sending it again since =
I believe
> > > > > > > this is a better starting point than building on OF_BOARD
> > > > > >
> > > > > > I really don't like adding another option for "DT is given to u=
s". Why
> > > > > > isn't adding another enum to fdt_source_t sufficient, and if we=
 have
> > > > > > bloblist enabled, that will look for and use if found? Maybe so=
me other
> > > > > > code needs to be restructured and cleaned up too?
> > > > >
> > > > > Same here. On top of that the bloblist has a few items in there, =
e.g a
> > > > > TPM eventlog. What are we going to do? Add a Kconfig for each ite=
m?
> > > >
> > > > No, but that is just a straw man. The DT is special and U-Boot repo=
rts
> > > > where it comes from.
> > > >
> > > > >
> > > > > This has been going back and forth for a while. I've lost count o=
f how
> > > > > many times I repeated the same proposal, but here it goes again. =
We
> > > > > have OF_BOARD and BLOBLIST options. The bloblist and its properti=
es
> > > > > are scannable at runtime. Can't we use the combination of these 2=
 can
> > > > > be used to imply we expect things from a bloblist. If we want to =
be
> > > > > stricter in the future and explicitly expect the DT from a blobli=
st,
> > > > > we could add a Kconfig option failing the boot if that's missing.
> > > >
> > > > I would like to have that Kconfig option now, not later. In my mind=
,
> > > > the boot must be deterministic, so that if OF_BLOBLIST is enabled, =
the
> > > > DT must come from there, or it is an error.
> > >
> > > Determinism doesn't require a CONFIG option, it just requires an if/e=
lse
> > > tree where we say what the "correct" priority list should be and then
> > > set a flag so that we can tell the user where we found it too. This a=
lso
> > > means that we can get whatever is going to use this mechanism to
> > > migrate over, and have less of a chicken-and-egg type of problem.
> >
> > OK I think I understand what is going on here. We need a way to enable
> > OF_BLOBLIST while still allowing the prior stage to NOT provide a
> > bloblist, at least for a transition period (=3D forever, I suspect, but
> > that's another discussion).
> >
> > How about if OF_BLOBLIST enables the option, but we allow a fallback
> > to OF_BOARD if the DT is not there?
>
> Oh, OK, so your use case is development. Why don't we just make
> OF_EMBEDDED be the first clause in the if/else (and yes, if
> (IS_ENABLED(CONFIG_OF_EMBEDDED) :)) and move on still not needing a knob
> for "bloblist has it"?

Because OF_EMBED doesn't work with binman, and takes a lot of
different code paths, etc. It is somewhat useful when loading U-Boot
using a debugger, but that is about it.

I sent a v5 that I hope does what is needed.

Regards,
Simon
