Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E5BE6C61A
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 08:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F356E893DB;
	Tue,  3 Dec 2024 09:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fa5EibNG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB127895F7; Tue,  3 Dec 2024 09:49:03 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9993D89305
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 09:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6efa1e49ef0so17220127b3.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 00:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733215740; x=1733820540; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vry8WQzQTwPCss16l9b2EIu4gLrC+lAnlLGK9sw/boU=;
 b=fa5EibNG66ICJa/oXK3K8lt7SuR9u+8uv38IMxSKKwlkeal11HdrY6VLzxfSMTc77I
 omiac7a6Mefh5Q1+nW5kEPsNE8krgl3/5/CVwHaLBJiGE2fgF/QQO4a/2QxKl5cgCbd4
 T6IRbd2G2A7bTRFTrBgpJxkIZeAi6mjeuJ6egOm+PwISzuMMtSwutSlTx4b8U9z3vSx7
 FqPBgSc1tJ3bw3BEUmSvDFnHfji73iLicRu9sDB6JVZHEFY7c8H1izwlSFDlSWsFZaRK
 G48xJxsXCiRYDojfQVKURHtyQyQhgcHT1KohvmhnJZUIRAI5nH7MkOoPXmkepx0Odcgc
 h8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733215740; x=1733820540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vry8WQzQTwPCss16l9b2EIu4gLrC+lAnlLGK9sw/boU=;
 b=ixTtfEAjLEMgQ05SFrPR20PGk6AL+0wn5zCtptU7BaEIyQ8QFI6/Xbw2mX8SpJPZxS
 0CYLP15Xd/a2z4ZaEFVp2aI/8SgaHSExGw/z8HdY1D01XOJTC3SlEpwttoE2GJBQPSAO
 avrR71BZe44lfRMNQvtrjWMP4K9fa4Kd74InnxkfkQ5ZuQa+ZucKl47pbVfYWQp6zjgs
 Y6tGGw0fURRE7AhEAS3oIR973wFHqQ9VO0clGLt31QVpg3ihXBPCXyDCOrn2ECtXuaIL
 su+AZXo7w6rJlmN3Ot4vLBI2aeiongou5flNMI4ZO2Q/ckaCWe7/aZfHi9MM4q5HfHXj
 /E8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaIdmkgO5K5e8PFPmeoPcWjW+rlBQBanVguK1mWB3SbSKTOiPoT8wcr2oIAa9UF41vUeRbcG8=@lists.denx.de
X-Gm-Message-State: AOJu0YxNrbOepP5Ynknoe2B3cY3vv2Got//V5ICFpwdpAts+/PELtpXi
 qohMKFf8qnqIev+RcIojf/NeDHzibWT1y3DjQ/brSlk6ferGoebb4tn4/9FXSS3MNO8zVzLYGkM
 cSiljRTSoY5aQRPQvOhT+EUT4hCAuCO6K9YIYOA==
X-Gm-Gg: ASbGncufH72Xy5/jOqVqpHcUfvX11G8wOJN71bRHGU8kkaeZOyQ6TwMlhxpryy9WBU+
 NqM5nq43qdfJUseMaRw4ccfTwoeoVfPs=
X-Google-Smtp-Source: AGHT+IGQ08P75BOcazbAnPleb+kU98JFRaMTp0Ki+Sv34MhzBapi0XWsOMZ4JOSxN980RlVZr7sL2rPjmb/FwxJBccw=
X-Received: by 2002:a05:690c:6106:b0:6ef:910d:7847 with SMTP id
 00721157ae682-6efad1be677mr24633607b3.24.1733215740483; Tue, 03 Dec 2024
 00:49:00 -0800 (PST)
MIME-Version: 1.0
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-5-sjg@chromium.org>
 <20241202201832.GH2457179@bill-the-cat>
 <CAFLszTitE4Gq+LUEm64ro2eL4_VME+gDh7s2jEnBTmVvkgX9sg@mail.gmail.com>
In-Reply-To: <CAFLszTitE4Gq+LUEm64ro2eL4_VME+gDh7s2jEnBTmVvkgX9sg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 3 Dec 2024 10:48:24 +0200
Message-ID: <CAC_iWjLex4Z41CDpx4u07XeCYgjB7H+Ynd8aQYL-wruH7yRmQA@mail.gmail.com>
Subject: Re: [PATCH v4 04/25] efi_loader: Add comments where incorrect
 addresses are used
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Simon,

On Tue, 3 Dec 2024 at 02:22, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Mon, 2 Dec 2024 at 13:18, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Dec 01, 2024 at 08:24:23AM -0700, Simon Glass wrote:
> >
> > > Some functions are passing addresses instead of pointers to the
> > > efi_add_memory_map() function. This confusion is understandable since
> > > the function arguments indicate an address.
> > >
> > > Make a note of the 8 places where there are problems, which would break
> > > usage in sandbox tests.
> > >
> > > Future work will resolve these problems.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > Please just resolve these rather than introducing a patch to then fix
> > them later. This is something that should have been fixup'd before
> > posting. Thanks.
>
> That was deliberate, as I wanted people to see the problems. It will
> save discussion on later patches where the problems are fixed, if we
> can agree that these are actual problems. If people are happy to add
> review tags to the later patches then I'm happy to redo it.

I am pretty sure Heinrich has repeated this in the past. Why do we
have to sprinkle around map_sysmem/unmap sysmem for sandbox?
Polluting the entire u-boot to support a special platform is less than
ideal. Why can't sandbox limit this internally and do whatever
mappings it needs when it receives an address?

Thanks
/Ilias
>
> Regards,
> Simon
