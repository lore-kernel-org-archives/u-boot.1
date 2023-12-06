Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B94C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 20:35:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30367874F3;
	Wed,  6 Dec 2023 21:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vz39qNjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB72C87158; Wed,  6 Dec 2023 21:35:53 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C765F87015
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 21:35:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6cb55001124so1003069b3a.0
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 12:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701894949; x=1702499749; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lZnoUCjEvCfh0KTUqbDoRBqTXegCIrbCcjO2ZIBWHZk=;
 b=Vz39qNjIKod+AUOGL9/LQBYinFkALhg9al28OCQU51rPS/YrAdSoMDibK7TbrRzgpb
 2a9aEIYCAM5BD9qnR6aDyoCn7L99QF+pAXXrah+KHZPAkIqBhf8wUKSz3f1cscrLTn+N
 16ttHPVFE33THwm80uTwXA4ll6fYJDzHIaFuSClyp6kdW9NBBHqXtc4epuIs9ga7S+YK
 SVB9u9ptjHBva9AoE5S0z4rvycNVERlgfiTsRpfETw2F6g2hKrTvT6l94SYo46KGtb4I
 dc0UAC60pQzr+Z3P+LyeXTcl1cPvMcma2E90x0Gd3THPNEuL5slEJN/Z9Jt/J2V52EUB
 xjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701894949; x=1702499749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lZnoUCjEvCfh0KTUqbDoRBqTXegCIrbCcjO2ZIBWHZk=;
 b=a1f44iH6PjF5sAfZaSAfHIj6zjZDea9UsczlcTkYeVxfgtXlxevsfrf3MxphhvfCK/
 2tmm3uFuBhanOTK7Wja6VEjFpJd2EFpiSenTBJTQKshxGVMW7v3bKbBEQFutIe9QYE1Q
 5XvmVEOjBt+71JeemFFaOmE4E6MJcrVrOxsc5W7J49XKfTgx6QUiZlTRPqACsmYKCJ//
 aI0Pw6OQRY5tRbhY6MWXu3L7CgMXdOQ/o7NNIvrF3uqR3eMe72S9GjaZVn62vNSeWy+e
 MxJADM1egXsXNbgv5Nrzwqovf3Rg4NVVbY9wicYixsgFA4gKJTmxkzMvOYFLcuMF6vwu
 w/vg==
X-Gm-Message-State: AOJu0YzaJuM1XMAbMSppkpWFh7Oqrs36K5B+1RKgMttcsxy7vLCRLr2/
 3UrqfYIFmQzH20RUHyQdZomvL07icsFyrOmnzMzziA==
X-Google-Smtp-Source: AGHT+IG5jOx2pOyBGV9vKJPm9YKHb+OaIeSLbntxNBVnLyzlJvDez00vst75th8OgbC8GqZPmUAr9jYoeHijWCST7d8=
X-Received: by 2002:a05:6a00:198c:b0:6ce:4efe:4db2 with SMTP id
 d12-20020a056a00198c00b006ce4efe4db2mr4239651pfl.17.1701894948934; Wed, 06
 Dec 2023 12:35:48 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-16-raymond.mao@linaro.org>
 <CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com>
 <CAEfUkUKaBotDRyReCLc_R628VzZ1CmaNdq_nCp=kd8iCn5R6-Q@mail.gmail.com>
 <CAPnjgZ0Hxsbv7EHbcnvLtmRSrPgMDfOFS+KmvYBcZgVC1Je4Ng@mail.gmail.com>
 <CAC_iWjKhmJ4BrH73-5sg8XGjMfJbsx8oWLsz3sGKdP8jdoHBDg@mail.gmail.com>
 <CAPnjgZ2QqOW_GGUUbM6EvmDN6gPJ0XKxk6SDNGiRChsTz8Y2Cw@mail.gmail.com>
In-Reply-To: <CAPnjgZ2QqOW_GGUUbM6EvmDN6gPJ0XKxk6SDNGiRChsTz8Y2Cw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 6 Dec 2023 15:35:38 -0500
Message-ID: <CAEfUkU+hXKDxcWpeMqOfuc2jyUOALwcG2a9pP2=0wKLFTscP7A@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] fdt: Allow the devicetree to come from a bloblist
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

> The other thing missing here is SPL. The bloblist is designed such
> that it can be set up in any phase of U-Boot, then is passed to
> following phases. So using IS_ENABLED(BLOBLIST) doesn't do what we
> need. As I noted, it breaks sandbox_spl. What happens if a board wants
> to use bloblist in SPL but doesn't want the SPL DT to come from a
> prior stage? What happens if SPL wants doesn't want to pass the U-Boot
> DT through to U-Boot in the bloblist? It is all just horribly
> confusing.
I think the logic to decide whether to take the DT from bloblist really
depends
on the board vendor.
I will move this kind of logics into board specific functions from fdtdec.c
in the
next revision.
Board vendors can decide the behaviors they want. This can answer the
question
above and for example whether they want a fallback when no DT exists in the
bloblist or the DT from bloblis is corrupted, or just print a warning
message.
For Qemu-arm, as an example of design reference, I prefer to take the DT
from the
bloblist automatically when (BLOBLIST && OF_BOARD) and keep the fallback
compatibility to load from `CFG_SYS_SDRAM_BASE` when DT from bloblist is
corrupted.
I will take a look into the sandbox_spl failures you mentioned.

Thanks and regards,
Raymond


On Tue, 5 Dec 2023 at 22:57, Simon Glass <sjg@chromium.org> wrote:

> Hi Ilias,
>
> On Mon, 4 Dec 2023 at 23:22, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > We did discuss this in OSFC but perhaps you forgot.  The discussion
> > was based on the mail here [0].
>
> Perhaps I did? Or perhaps we had a different understanding of it?
>
> >
> > On Tue, 5 Dec 2023 at 02:52, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Raymond,
> > >
> > > On Mon, 4 Dec 2023 at 12:25, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > When `OF_BOARD` is defined, the FDT should be from one of  the
> board-specific mechanisms:
> > > > 1. FDT from a bloblist via boot args
> > > > 2. FDT in memory
> > > > I don't think we need a new build option to distinguish these two,
> since it can be done in runtime by checking whether the boot args follow
> the FW Handoff spec conventions and the FDT exists in the bloblist.
> > >
> > > No, I would really like this to be deterministic, so we can fail if
> > > something goes wrong. The bloblist should be 'declared' as the way to
> > > boot, for a board.
> >
> > We *are* deterministic. I am just going to repeat what we discussed in
> > OSFC for completeness.
> > OF_BLOBLIST makes little sense because we are not going to add a
> > Kconfig per blolblist entry.
> > I haven't looked at what the patch does yet but the idea was really
> simple.
> > - Under OF_BOARD (which can arguably be renamed to OF_PREVIOUS_STAGE
> > or something like that)  if CONFIG_BLOB is enabled we scan for a
> > bloblist
> > - If CONFIG_BLOB is enabled but no bloblist is provided we fail the boot
> > - If CONFIG_BLOB is not enabled we do what we did up to now, maybe
> > with a message that this is going to be obsoleted once enough boards
> > migrate to a bloblist
> >
> > IOW if support for a bloblist is enabled we expect to find one from
> > the previous bootloader. I've lost count of how many times I repeated
> > this, but here it goes again
> > The device tree can come
> > - From u-boot
> > - From a previous stage loader *somehow* (eg. passed on a bloblist,
> > passed on a register, read from an EEPROM etc)
> >
> > We should keep that distinction and create subcategories for the
> > 'comes from a previous stage loader', rather than adding arbitrary
> > config options which only confuse people
>
> I don't know why you are so frustrated about this. This patch does not
> even do what you have listed above, so far as I can tell.
>
> We have:
> - OF_HAS_PRIOR_STAGE which indicates that U-Boot is not the first phase
> - OF_BOARD which indicates that the board can do anything it likes
> - BLOBLIST which indicates that there is a bloblist
>
> I proposed adding:
> - OF_BLOBLIST which indicates that U-Boot gets the DT from the bloblist
>
> I understood that your intention OF_BOARD would go away since there
> are almost no cases that need it. I was skeptical it could be done but
> I definitely agreed (and still do) that it would be great if that
> could go away, as we would not need OF_BLOBLIST since OF_BOARD would
> effectively mean the same thing.
>
> But when I look at this patch, that is not what is happening. In fact,
> there is no indication that the DT came from the bloblist. U-Boot will
> just report 'devicetree: board'. We must say where it came from.
>
> The other thing missing here is SPL. The bloblist is designed such
> that it can be set up in any phase of U-Boot, then is passed to
> following phases. So using IS_ENABLED(BLOBLIST) doesn't do what we
> need. As I noted, it breaks sandbox_spl. What happens if a board wants
> to use bloblist in SPL but doesn't want the SPL DT to come from a
> prior stage? What happens if SPL wants doesn't want to pass the U-Boot
> DT through to U-Boot in the bloblist? It is all just horribly
> confusing.
>
> So I believe, in fact, that we cannot get rid of OF_BOARD now, and
> perhaps for quite a long time. There is another discussion about
> Qualcomm where they want a gzipped DT attached to the end of U-Boot,
> for example. Perhaps the key problem with this patch is that it would
> ensure that OF_BOARD sticks around, since it means both a) Get the DT
> from bloblist if BLOBLIST; b) Get the DT from a board-specific
> mechanism if !BLOBLIST. That is not what we discussed.
>
> Why not just take my original patch and work from there? It will save
> a lot of time. We can then progressively migrate boards from OF_BOARD
> to OF_BLOBLIST and then perhaps one day remove OF_BOARD (I remain
> skeptical, but hopeful). The whole 'standard passage' thing [1] was
> carefully thought out *two years ago* and (I believe) dealt with all
> of the issues above.
>
> For now, we should apply the patches which bring in the spec changes,
> so we can figure out the rest of it. I have added my review tag for
> those.
>
> Regards,
> SImon
> >
> > Regards
> > /Ilias
> > >
> > > If in the future all boards a reusing bloblist for this feature, then
> > > sure, we can drop it. But we have things like rpi which do their own
> > > thing.
> > >
> > > > If it fulfills the above conditions, we can take the FDT from
> bloblist, otherwise from the predefined memory address.
> > > > This is fully backward compatible without adding a new build option.
> > >
> > > Again, we need to obtain the FDT from the bloblist if and only if the
> > > board requires it. It creates a lot of confusion to have it as an
> > > optional feature, when we know which way it should be.
> > >
> > > Ultimately OF_BOARD should go away. We just need to push bloblist to
> > > other projects and closed-source firmware as the correct way to pass a
> > > DT.
> > >
> > > Regards,
> > > Simon
> > > [.]
> >
> > [0]
> https://lore.kernel.org/u-boot/CAPnjgZ0SqVyj_drLEQrP21zPYCco3HOP-rYD+nKJMa0BVYpMDA@mail.gmail.com/
>
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
>
