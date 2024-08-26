Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D90C5472F
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 19:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42EDE88CA3;
	Mon, 26 Aug 2024 21:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z9aTCbrm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF28988C90; Mon, 26 Aug 2024 21:12:32 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6872088C5D
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2d3c098792bso3741108a91.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724699549; x=1725304349; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t47v4quQ30K33gizPhauvedGXnpyk+5aHqmOWTs0Wfo=;
 b=Z9aTCbrma8OBXGCIK1ymUXgmGMlb2tB0GRJRuq18WsG/cn1cYoSMFy9XV90VE11p0i
 XDegoFBtmXZdcy9F+ZxgFHj42weOtkRRrLry64yW9D1Jlmq12wCL3cMydFe7azSqGCpR
 NXJvTGLYWjAmTRfej1vZfj83ne95bYn13UDsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724699549; x=1725304349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t47v4quQ30K33gizPhauvedGXnpyk+5aHqmOWTs0Wfo=;
 b=L8MIU3sF/Ilal2SUFHFg8VbzLFcLQGQljuD2/KXx2jcAUv3/6nLRjB7Hb+4NEuaau/
 PNrtqGcmzr6Mtu7kgpb5Fgoo/ZSOpba97ZquexCBo7tR678xmf4Y0JhOV2NS3yotYzbR
 vK644ns93gVJS2WZCowBlsnLEvgB/6eciWmQn1+fXCjD4WxZdBiQOgXs2fMAxOp3K0+X
 z9xbOXcWrLdxi2ASUUfuXy6dNWhyb0S6o6DPUzy9qoGswH71l3ojnoGiGhQuc2VYMEeB
 PRSTp/Mc+Mc9fmEq9PArwtw7vxBYfh2Lwqx8ieGlzrfSuZrsnpajkCxp14fHDhjGT9Vk
 cVJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMLHsKr500zn/qH40Mnb5DYSnhshbFRQmYS2gv105+6WpZNUZQ00p6UlrlhYCqLD99ubhe+Kg=@lists.denx.de
X-Gm-Message-State: AOJu0YxW2eIcj10pxHbvDn8ve0WvX7doOGrFUsXmiYneE7PQeG+14QTj
 a9QCFWrnR8aA3gkBGtxQshQqMUV+Md+WCKcYcTUCfS5FzfSYYUuxqbGtVJks3Um8T/NmETwZsZF
 zmTPno4SgoFyTvE4qWSTRCoqf0hd2ttbPrqgH
X-Google-Smtp-Source: AGHT+IGClOQ6fVqYhvWjBNjxzkAEkRsAwIBcWCGVX8Fo/cnvSdTNzadSksjo+oTXkz/x9vGxaHO46mxTCgLS1EZNLGc=
X-Received: by 2002:a17:90b:3787:b0:2cd:2992:e8e5 with SMTP id
 98e67ed59e1d1-2d8259b8c86mr647420a91.33.1724699548907; Mon, 26 Aug 2024
 12:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <CAFLszTjE+8BmdmtFXER94LmEYshNDEA4x_MDTqvyGhHYed2OCw@mail.gmail.com>
 <ffeb90f8-4f3b-4455-83db-d7b03b872c84@linaro.org>
 <CAFLszTg8gM53pcbHGj-LoA9GDSU-X294_q6ZRnP_QjYFppG0sw@mail.gmail.com>
 <20240826182345.GJ2479150@bill-the-cat>
In-Reply-To: <20240826182345.GJ2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Aug 2024 13:12:16 -0600
Message-ID: <CAFLszTiD4A2eCMfnnKvrbm__urLu+vdi_L1T1iiwU-qOY-yYJQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] SMBIOS improvements
To: Tom Rini <trini@konsulko.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Stefan Roese <sr@denx.de>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>, 
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 26 Aug 2024 at 12:23, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Aug 26, 2024 at 11:58:54AM -0600, Simon Glass wrote:
> > Hi Caleb,
> >
> > On Mon, 19 Aug 2024 at 17:03, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > > As a general comment, this is adding a load of code which is used by a
> > > > lot of platforms. As more and more aarch64 platforms are created, this
> > > > data grows. Why not use the devicetree for this hardware information?
> > > > That is what it is for.
> > >
> > > This data does not belong in devicetree, the various system registers
> > > exist to describe this information... Putting it in DT would be
> > > duplicating it.
> >
> > I am not wanting to duplicate info which can be read from system registers.
> >
> > >
> > > Using DT for this would additionally require having bindings accepted
> > > upstream and for all SoCs to add them. To what end?
> >
> > To get the correct information in there. How are boards supposed to
> > add SMBIOS info? Do we end up creating a whole infra in U-Boot just
> > for the driver to read it out? It just doesn't make any sense to me...
> >
> > Let's put hardware info in the DT where it belongs.
>
> I'm a little confused here because of some older threads on this overall
> topic. Part of the issue here is that in user space, "everyone" has
> SMBIOS-based tooling today, and wants to have that work, rather than
> inventing new tooling or modify existing tooling. And you were concerned
> I thought that we had tied SMBIOS too much to EFI being present when
> indeed it should be possible to pass the location along to the OS
> without EFI, but at the time Linux at least only supported that notion
> on MIPS I think?

That is a whole other concern I have, that we are perpetuating this
legacy format which is a real pain to work with, when we already have
devicetree. Let's leave that issue aside as I have not detected any
interest in solving that problem, or even any agreement that it is a
problem.

But for this particular series, I am just wanting to get the correct
info in there. Having the CPU-detection code provide an opinion about
what type of chassis is in use (just to take an example, the patch
pieces I highlighted have been dropped from the email I am replying
to) just seems a bit daft to me. Only the board vendor would know that
info.

Regards,
Simon
