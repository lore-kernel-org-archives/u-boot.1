Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FF1CD1292
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 11:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45F1F8808B;
	Mon,  1 Apr 2024 13:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nnjEZxFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8B61882F0; Mon,  1 Apr 2024 13:15:25 +0200 (CEST)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B50D87FDA
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 13:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7e31fd5553dso1081830241.0
 for <u-boot@lists.denx.de>; Mon, 01 Apr 2024 04:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711970122; x=1712574922; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NmDXxoifPmTpF8CxlDVud48OHqSFXc1yYltwtK5A88k=;
 b=nnjEZxFTximnXXAkS+6z3MsyUUVQxAMO7YwAM+Rkt9TyiJCS2I1+7+QWDMNWpdVOoY
 xeaMrqgLP0Rueb0iwtWNojz7Mj3h0sCsIHFMtzdlcaO+TKOUHAL+PpPoXkcYEPg2WDtm
 yDlDewECe5mykU3dVB2ZyC3bkhZBALDe4cMl/Hj6emXFFKHHWti25kobCRAWoOEc+vmh
 P2kQ7vMjeu8R4PoOjy7MFYbKHCN3PM6SzfBITcjpNWpV3l8Wycxo75qET+0XlgjrZk4Z
 +3ja3PSXreNamUkoCFAtw5oGkg6UJslAIl/VClR2TlL7FqXzTxGysNFBEjFxLd6MISU0
 njmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711970122; x=1712574922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NmDXxoifPmTpF8CxlDVud48OHqSFXc1yYltwtK5A88k=;
 b=GgM5MWMgq+XlEA7oASdwl0xECfyKXmOWDdf5v2p9x7mv1WYfUOlcpoV2MmI5Icx6dZ
 XjNq+T1N58MY1pYPScqmmAlaN+iq0D1/R9vdSZ9oHnl7kAq2Y+ak6eKg3qhxWBiYr/U1
 PoDE4JOtyATTaltlqp12ouA1fFJuk2V3yCfAqQbSYhkGyJz1evxL1+bK9/WapDSFctSd
 ptUFgpxJMfQWnqa0fe8pKqwI9GVi+Tq2dyBrU6214zck71r+CW3FOYCuE7/raPrg9oCv
 TxiFsU0U/o8/S7gCyUIVElezfqkKOt/sqtLaTxUQi0nhNufR/bosR6pb9kcjl4pBRFyz
 L8Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWXb2oEpTU/qWYB9uH+0iDlUCZ2PYtK63XYyIttq8j9s2nBgcorh50vSqJjJtI+IzGpXhpm6uDuFK/pfPHok54xqRGhA==
X-Gm-Message-State: AOJu0YypwQef/cR7YP0LcFpg/kh/WCzS5bPWHjSG1wPVn69635n0WGUA
 /XoyE4c+4jb4kFDuyjfhTg8QnfzUqTwlYxtRZSiJ99yACBVcEd/bXcZb93HMAUiNnkQmsz2Xp5m
 B2skfnVz+U1tep236YqUG5B7k4WT0mp1QxTHI8Q==
X-Google-Smtp-Source: AGHT+IFdEcY1zNL6anGWe8G9OrZxCBK800kXVskMLDZ0pRoQI74fjuKbMZeMysS3C23hwNzuTc59pfW6HsaKYfEUSlw=
X-Received: by 2002:a05:6102:52f:b0:476:c08d:1093 with SMTP id
 m15-20020a056102052f00b00476c08d1093mr6193916vsa.10.1711970121835; Mon, 01
 Apr 2024 04:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <CAFA6WYPMqRQRpcN--3Mz7czh6MK10W75e19h9VWWp5P6KKbBJA@mail.gmail.com>
 <63f29606-ad3f-4883-9e8b-4d80194c12ab@kwiboo.se>
 <CAFA6WYMGLuftoVcL8WD9DR_QZf=rwe_wLWV6XARG0MTncXJCqA@mail.gmail.com>
 <91326c6e-444f-42f7-bfe6-59cb2fb059d4@kwiboo.se>
In-Reply-To: <91326c6e-444f-42f7-bfe6-59cb2fb059d4@kwiboo.se>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 1 Apr 2024 16:45:10 +0530
Message-ID: <CAFA6WYOWDHFOOhOOE0m9Ek5sx-QojnT8a7WPoxAQA2R3KRWKbg@mail.gmail.com>
Subject: Re: [PATCH 00/31] rockchip: rk3399: Sync DT with linux v6.8 and
 update defconfigs
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Mon, 1 Apr 2024 at 15:54, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> On 2024-04-01 12:08, Sumit Garg wrote:
> > On Mon, 1 Apr 2024 at 15:15, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Hi Sumit,
> >>
> >> On 2024-04-01 10:52, Sumit Garg wrote:
> >>> Hi Jonas,
> >>>
> >>> On Mon, 1 Apr 2024 at 01:59, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>>>
> >>>> This series adds support for new clocks used in linux v6.8 device trees,
> >>>> enables use of FIT signature check for checksum validation and fixes
> >>>> loading FIT from SD-card when loading FIT from eMMC fails.
> >>>>
> >>>> After this series it should be possible to move RK3399 boards to use
> >>>> OF_UPSTREAM in a future patch once dts/upstream move to a v6.8+ tag.
> >>>>
> >>>
> >>> Thanks for putting this effort together. A switch to v6.8 tag for
> >>> OF_UPSTREAM will happen as part of patch [1]. So if you want to save
> >>> further effort then you can just rebase with a switch to OF_UPSTREAM
> >>> once that patch [1] lands in next.
> >>
> >> Because this is a jump of device tree files from v5.14-rc1 to v6.8,
> >> reviewability and being able to cherry-pick these changes to my
> >> rk3xxx-2024.04 branch, I think it is much more appropriate to first sync
> >> everything to v6.8 and then in a separate series move to OF_UPSTREAM.
> >> Else it can be very hard to understand some of the changes that has been
> >> and was needed to be made to u-boot.dtsi files.
> >
> > That's fair given it's a long pending DT sync.
> >
> >>
> >> Reviewability is one of the shortcomings with a switch to OF_UPSTREAM.
> >
> > I suppose the reasoning behind this thinking can be that people are
> > used to reviewing DTs alongside driver changes. However, these patches
> > aren't actual DT changes but rather DT imports which IMHO is a
> > distraction for the reviewer. The actual DT can be looked into
> > dts/upstream/ directory while reviewing the changes.
>
> Things like following was easier to spot when reviewing DT syncs:
> - A property that U-Boot depends on gets removed, as in [1].

That seems to be due to DT bindings compliance check where DT bindings
are the ABI. Although it is unfortunate due to dependency on legacy
DT, now we have the same dtbs_check in U-Boot too:

$ make <target>_defconfig
$ make -j`nproc` dtbs_check

This shall keep U-Boot in compliance with DT bindings and help avoid
such dependencies.

> - Some DT changes can break changes that has been made to u-boot.dtsi
>   files, e.g. a symbol to a node is no longer available in upstream but
>   referenced in u-boot.dtsi files (happened in this series).

Node names aren't a DT ABI so we should expect some changes there.

> - Changes in DT may require a workaround in a u-boot.dtsi file.
> - u-boot.dtsi contains workarounds that has not yet been upstream but
>   can be removed in a future DT sync.

Agree, we should try to minimize modifications via u-boot.dtsi
especially all the bootph* related properties should be posted
upstream.

> - Driver incompatibilities due to initial driver imported from vendor
>   ended up not fully compatible with upstream linux driver / dt-binding.

Given all the above and the big jump in DT sync for Rockchip
platforms, I am fine with the transition being step by step.

-Sumit

>
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=4d08b19629495b29601991d09d07865694c25199
>
