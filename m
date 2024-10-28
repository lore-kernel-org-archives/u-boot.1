Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65321D13570
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 11:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2FBB8907D;
	Mon, 28 Oct 2024 12:29:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tbDjUX1v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E38F48907D; Mon, 28 Oct 2024 12:29:45 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19BBE8907B
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 12:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a5f555cfbso273549666b.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 04:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730114975; x=1730719775; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rFjCfYVgzDjGL0W48u/jshX0QFKr2Gt7/EP3PX4nyIY=;
 b=tbDjUX1vV0aPGOhHCzQCY/JoTjj9x9T4vq9f9LHoi9mCGvQl6l015u7dMRlJ2Kn6z6
 whIIs5P990Tvdz0gcT8znIg3T29Oj9rcaU5KgPqGv1/MJuwc5R5NaxczuCKmTfpD7+xX
 SyAhdGJLcXvLGloVRSC0S8w1g6w/l+NS/6c8YYAAi+1VpVMmNaFS/N29UNB2jyJi/R+J
 WoqJqmYN/I5Ve4PXxacqscNWjNMOo4EzZWGV4pYInCUh4GdKzV7WR1Ki/GBPe7p6DFOi
 gi2pJknkalldYwPtobZiOhBVwzLZ1FgFPY3MZPeTXgLiZyP8ak5RuaZB6l2kZMNixO0b
 RUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730114975; x=1730719775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rFjCfYVgzDjGL0W48u/jshX0QFKr2Gt7/EP3PX4nyIY=;
 b=s1Z2oPD+lTEr9CITMBYN5J6HFGveWkQ2TaJ8LXS1kymi9xSKEwQd67WjMInLtVlpjS
 ZJ57Mi0Xffb+2bPf2+Y5fjeXuWl2UtRuUf1TnUVuPkgsZpbfliTxo6Z+QBljtO/5fecj
 Ilp88EmcOzxN/YNePsZKK2Gjt+9YI4VHKYvFLtNJQykvnbx3onDgr4ijF6pUmbdchI5b
 eMVJf4QQLo85pCB6NsMY1G559zBjpSPhMWozp4XXumnQLY2UnfkC6BfXHyiLOsn+vXSX
 E7O0ApNv/dFN/LdHr2nQdqXn19t7btjgWN9Nt+lbeedqf36W3IsyxsTS/9c65szCxwON
 zfew==
X-Gm-Message-State: AOJu0YzIfl9wUW2dyKNwVh+0nXoCqYoDZ6TyeBBEtfq8X8x4A/lXruGF
 8n5PzIPVe7m2+vIYb7hyXhft9H1dZzkL/eE2x+UlF9AlcyqQfy6vyzydwwpXx0tFg64ft5z+Vx1
 yhp/5fsV02JgwCW0Qmzeiu/zwcTxEpRlc7y9GtQ==
X-Google-Smtp-Source: AGHT+IETT+pd0NNqWfZAA4FiSzngYOWTcbaYEWH8St5zA4xq2sB6NIWEtn0JDqyHg0n32dYV0wMuosPJeVOLo0bsY8E=
X-Received: by 2002:a05:6402:28c5:b0:5cb:bebb:38d8 with SMTP id
 4fb4d7f45d1cf-5cbbf8c2365mr7760405a12.14.1730114975351; Mon, 28 Oct 2024
 04:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
 <20241025111411.165904-2-sughosh.ganu@linaro.org>
 <CAFLszTgpUOpjMogv5q0EhLHe-i=VBYHtdaGyBp6as99BkbE0pg@mail.gmail.com>
In-Reply-To: <CAFLszTgpUOpjMogv5q0EhLHe-i=VBYHtdaGyBp6as99BkbE0pg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 28 Oct 2024 16:59:24 +0530
Message-ID: <CADg8p95SAYvhTaAYWOSHmZXNbyuNdB2=_2Mhwdn8eU+aBtNioQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] fdt: add support for adding pmem nodes
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Sun, 27 Oct 2024 at 20:30, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Fri, 25 Oct 2024 at 13:15, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > From: Masahisa Kojima <kojima.masahisa@socionext.com>
> >
> > One of the problems OS installers face, when running in EFI, is that
> > the mounted ISO after calling ExitBootServices goes away. For some
> > distros this is a problem since they rely on finding some core packages
> > before continuing the installation. Distros have works around this --
> > e.g Fedora has a special kernel command line parameter called
> > inst.stage2 [0].
> >
> > ACPI has NFIT and NVDIMM support to provide ramdisks to the OS, but we
> > don't have anything in place for DTs. Linux and device trees have support
> > for persistent memory devices. So add a function that can inject a pmem
> > node in a DT, so we can use it when launhing OS installers with EFI.
> >
> > [0]
> > https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/installation_guide/chap-anaconda-boot-options#sect-boot-options-installer
> >
> > Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >  boot/fdt_support.c    | 41 +++++++++++++++++++++++++++++++++++++++--
> >  include/fdt_support.h | 13 +++++++++++++
> >  2 files changed, 52 insertions(+), 2 deletions(-)
>
> Can you please use the ofnode interface for this? We are trying not to
> add more of this kind of fixup, as it means someone will have to port
> it over later.
>
> See EVT_FT_FIXUP

Are you suggesting using the EVT_FT_FIXUP interface for adding the
pmem node? If so, how does this work on platforms which enable
livetree? Looking at the code, I see that the EVT_FT_FIXUP gets called
only when the livetree is not active. However, I am not able to find
any place where the livetree is getting disabled. We do have a
function, oftree_to_fdt() which flattens a livetree, but I don't see
it getting called from anywhere except from a 'upl' command. The
of_root pointer does get set in initr_of_live(), but apart from
dm_test_pre_run(), I do not see where we disable the livetree and set
of_root to NULL.

So on platforms which do enable livetree, how does this fixup work?
What am I missing?

-sughosh

>
> Regards,
> Simon
