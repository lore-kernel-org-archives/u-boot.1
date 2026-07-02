Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED7DC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 13:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76F18849F6;
	Thu,  2 Jul 2026 15:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m6urxaDW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4444A849FB; Thu,  2 Jul 2026 15:07:42 +0200 (CEST)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B236F849B1
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 15:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-664d78637f8so2457869d50.3
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 06:07:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782997658; cv=none;
 d=google.com; s=arc-20260327;
 b=Iip2/v9Disl8ES0UlsNfpuM1erL9PnT7WRENroVpm1WeR3lJkPba9Q9wQJQNgDwtHN
 U+U/IRuQDPZeoaG/T8+tYoNbJTpnFlbibdtaqR7FJkn4G0I4AAU4ZfFrrnmb4Sfdj/l2
 zBafottCep/r6OzY0efHPtkW8zE41Mjwzjg9/okBEIRFACWR2EpRsU6N5S5goRMMzkWw
 dCoPfGcSX/CNWB0lHcKAlSKrqTFv7zaErY/6YL1Ca4eM/ElfO35TRf/1L+1wcCoaxJzT
 0jQE0zgEtAUgd8ui4Z1Z3Z1hbEOKxnsJ5HVqVSY2fa3+BNB01IMCiTu+5OCUiGY/BKCy
 DAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lKOODBng/jE3azaokX7YGAadiTLn506rlC8zLQ3gdjo=;
 fh=/Nsu4KeIY/BckAkrFd38YurCorn6dwrZh11nSZtiKSE=;
 b=eYpIW6/CcuvLtX1QLZoP8/6NIbq1oIcvXdOeDEAjVlbqhghbAXuPUr/g2dQW/YuOXI
 D5MaumtnmtUfkxPJh3dwB6KGhtHqwBLlwcgWIHIvTW1ai4+3RFWyg0CACPaeFN+54zSZ
 2Wsp66f3TCnlwDT8tb8Fk0gY2u+L8E9BFxwb82p56GZ7OKIq0O/F2BAmdw8gHZ76JMH1
 91hkQYDgjbxo1hEdxoWuX8uTWb4095UG63yvpBGortQP1Lw7EEK5gZC2M5Tp5KMgaNPB
 PWzfIJXYyliTa3W6ijGu88NHfSyVBBoPcQr3yfM7TJ7/ut27Ek4gecHYLtTiFhvOkQYX
 f5Ag==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782997658; x=1783602458; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lKOODBng/jE3azaokX7YGAadiTLn506rlC8zLQ3gdjo=;
 b=m6urxaDW/iQgSl1MLT1Q5yxQ/lNx29v30rExcuLN8/roxoKOxf6DxBqLoi5hcmYklj
 1NxOZW/P3jlAz2nmagzfdfkjaUUGffZEVFxCkpazHGg0LDwL8iQEObkPOZ6QJkNByXYg
 wKjyTk5UOd8UTVhPsdLC9rcDOTlySlI6hz0th69qXyfB2otg+QXgaglmAl59jl75hfVO
 OxnTRE9lnxDJp2KV13JgGNlnPrSIJ9LFC7AzrKXfqssF2P/pKnOl2IvG0Kv3zC+uNmX+
 AboCNjLiNPSe7FuobiU1JgjRj5yyk27wxWxDi8SNLwC3jGupxdBuS4M3udco3STi1hs5
 dl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782997658; x=1783602458;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lKOODBng/jE3azaokX7YGAadiTLn506rlC8zLQ3gdjo=;
 b=MaBy8zLq00mf7R6724kGgmtNUVhvRII4SuRyBu/pnfLRLBJgHFGM19mHj49WXx+O5b
 7305tp+mllO50zbZQ2tgcQOyZncMH+FdEG1MimgRAKLguR0/6SZlIBbcKGFKjHg+Ix1p
 NmGCi+daRkD8kVGZ0Qm5ao7k3eztTmTvYzb+Ltq+uDgF2JFklZqJj3LQEBMSLLeZEm95
 YyQGtgoldv0wVLTg8gIR5JGdUJYkDXCciN7cmvpsO8inUVVfMT/pxZKlPEeKl6NBgi4w
 uxwUysupvOKOhwTHYBdtWxZNlUEkFBP/1DeMCTA5v5Vf7TkXvgr/yPPw6460eS3HEDKr
 IXdg==
X-Gm-Message-State: AOJu0Yyr+zqJEh25qbgNTrLiORGBruAHxtdSoq89OgO9Fj4ubkj1n0aE
 3zLYyCe4IjaCKvEVWq3yhnmwGbB9bMkHMMsJ8kN9obVTBfYOfyq3gHKOUPpHtQ+KpXBj0zTO+Tv
 3tCqkJa5PrWGOZ4iRbP7xFuksQipzI5Kb8PXvEDjDTw==
X-Gm-Gg: AfdE7ck/YueJYGWzScHj5dsYnVX54S3hIo19oYXbsD/hfBtMu/kNrzGTTkjxdoxO6bv
 RWfmnWHDOnpWw1b2OmWP7X1as4ZcmQYCOxrYoClsSmBknoxOf8GrHviyGIgseGxosKg3LiJMSbp
 wvw4RHi7toFaG2W72RDfmscZ90y5m+ex503nk3GeW0NmYqfFTrK44GOI4pYms34SWgywGbItPAW
 XHmd1moIHrPOH7afbKobHtg1ExtF2hsqWaBeDVi2PzKKv8+wGXSgb5kJjrSD204ExXV9E2eKiCm
 2cscY4CmEm6h/ecSlh8RNNOlaWKsLKpv/19uY4qEYeZ253dqfmLDCNTQUcnqk/5BrVI7MoWT7O7
 nhzBdeip+EwQKIekpQHb0xz5yUSli+aWOh4n07+iC6ZWIe0AUMlN0AnqaecDQb5u0zGfflzBq7b
 z48fGZjMcZ/LEGAHDHdXkrHDeoVqdA6CjoKeuVL1KM7/HSzqoBU7j8RqhbG826AvntzAql4xKaK
 JaVvTdKLWHpiW9VicZTggsq7bgSobKB8Bc8ytzWmWDHw97IvcSJd1BeRvUfiBJI6O8XBMJHYPQN
 XEKD+d/6051O06RSP6CVuY3X0vzXFujTY/8TaDRCbPGd27RPvbeLsuF/tvepbybufDQSWfI=
X-Received: by 2002:a05:690e:4193:b0:666:1ff5:fc26 with SMTP id
 956f58d0204a3-6661ff6053emr4170047d50.76.1782997658408; Thu, 02 Jul 2026
 06:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <0bd1a1b8bbe48fa3a9b89673c1e1357d50d0684a.1782825467.git.michal.simek@amd.com>
 <5e5241d02a04871a06dd44d3f8638f5da10893ff.1782825467.git.michal.simek@amd.com>
 <CAC_iWjKeFMqXqo9tcf27Yuofyvbvr34Hqf5hFpK4zB8crtw8Yg@mail.gmail.com>
 <f63906f9-29a6-422f-a111-855cdc8d1f2b@amd.com>
 <CAC_iWjLfC_U=q+iPCy-BXLXwLiwjXBe3UHqH5XuvU1gkyVxKkA@mail.gmail.com>
 <08e98c15-80a0-40d8-bc7c-8d8edfbf3f99@amd.com>
 <CAC_iWjKH89ibj3KNvJW9HHXbQ4MhDLb2qWaYytU0S9Q_3xqkgw@mail.gmail.com>
 <fa17c2ff-866b-40ec-ae10-847f2ff84572@amd.com>
 <CAC_iWj+VqjpWPDRVGvCYpWMg4hmjeS1YzPBZiMvvQqvRRLe+Vg@mail.gmail.com>
 <a9285398-9e71-4767-a34e-2dc767c11538@amd.com>
 <CAC_iWjJiqU8KavYyHEavj+pszLxN-oq9EoucBi=bsjRuVqNMmw@mail.gmail.com>
 <207fe44d-e18e-4983-b152-be820d720275@amd.com>
In-Reply-To: <207fe44d-e18e-4983-b152-be820d720275@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Jul 2026 16:07:02 +0300
X-Gm-Features: AVVi8Cfslkk2Q_5-3BNrgl1T3_6KZ8QMrCGmyTSG5nwrb4hqSF6TwEA26KSOUeg
Message-ID: <CAC_iWjJ2z2TCZT63U5ve53LL80GnZ6PsuR1hOG4EMtizq3+LwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fwu: Gracefully handle missing FWU metadata device
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
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

On Thu, 2 Jul 2026 at 15:40, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 7/2/26 14:24, Ilias Apalodimas wrote:
> > Hi Michal,
> >
> > [...]
> >
> >>>>>
> >>>>> The prints below are just from fwu and efidebug for the ESRT table.
> >>>>> Those will work.
> >>>>> But what happens if you try to run a capsule update?
> >>>>> Eg. efi_capsule_update_firmware() will call
> >>>>> fwu_plat_get_update_index() which will fail,. no ?
> >>>>
> >>>> it fails on fwu_update_checks_pass() before fwu_plat_get_update_index().
> >>>>
> >>>> versal2> efidebug capsule update -v 0x40000000
> >>>> Capsule guid: 6dcbd5ed-e82d-4c44-bda1-7194199ad92a
> >>>> Capsule flags: 0x18000
> >>>> Capsule header size: 0x1c
> >>>> Capsule image size: 0x41434
> >>>> FWU checks failed. Cannot start update
> >>>> Cannot handle a capsule at 0000000040000000
> >>>
> >>> Ah yes, that ret 0; will never update boottime_check properly.
> >>
> >> I think the question is if this is acceptable or not.
> >> Because none checked error code before
> >> 583efb504058 ("event: Check return value from event_notify_null()")
> >> and then
> >> 353166279c32 ("fwu: Move boottime checks to EVT_POST_PREBOOT")
> >> it checks it too.
> >> It means in past fwu code error out but u-boot continue to work with above
> >> behavior.
> >
> > That's also a bug imho then.
> >
> >>
> >> Pretty much this patch is bringing back old behavior before these two patches
> >> have been applied to the repo.
> >
> > It doesn't make sense to update to or run a firmware that won't be
> > able to use capsule updates ever again.
>
> It means that can be consider as misconfiguration. Which ends up today in
> forever loop (1/2 will at least tell now what it is happening).
>
> , eth1: ethernet@ed920000
> Cannot find fwu device
> Cannot find fwu device
> Cannot find fwu device
> Cannot find fwu device
> Cannot find fwu device
> Cannot find fwu device
> Cannot find fwu device
> Cannot find fwu device
> Cannot find fwu device
> Cannot find fwu device
>
> But shouldn't be there different action? Go back to second image or reset for
> example?

At this point, either your metadata is gone, in which case you can
either try to recreate them and hope for the best or an update broke
the fwu mechanism indeed.
In theory the board will automatically revert to the secondary
partition after X reboots since no one is providing an acceptance
capsule (or variable) so reseting should be fine.

Cheers
/Ilias
>
> Thanks,
> Michal
