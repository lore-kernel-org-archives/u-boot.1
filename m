Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEB1C83F12
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 10:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A1158655C;
	Thu, 31 Aug 2023 12:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="YPjwsahd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93B658656A; Thu, 31 Aug 2023 12:26:03 +0200 (CEST)
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch
 [185.70.40.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8336F86558
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vitali64pmemail@protonmail.com
Date: Thu, 31 Aug 2023 10:25:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1693477559; x=1693736759;
 bh=v1SgijnNSc5kit2PCJSIPerjrDrm3hZq06k3CBpj9oc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=YPjwsahdUGLjaI9QY+70aOxtevPome452d/8ae2NWDX8haCQtGw3riDFLUPNaMdvO
 Oc/I6un5gtj2y/qgiAsLB0vCOIb5RRLrwlVIJq07THFtesnLIKGCn84synvYhIuSZ7
 fnY+YyzxJURwlKEmQC3Aj11qTTJj5RzdZ3vDy1ZY2tsONcRoKByozM5gBdvb1rvwgi
 YRSDcQgnNbFeyEORJaE3utj+12LUgFhCEA54aYHHguU4EgLwhJx3xIssb+Sz41gSK4
 4iFF+uFS18GrPiGRU+OtJpkCEUs2Wcr6G3vkP9W5tJL+Q/Q2YyybSUDb9RessZK+XW
 kpAudQq1LoMFQ==
To: neil.armstrong@linaro.org, Simon Glass <sjg@chromium.org>
From: Ferass El Hafidi <vitali64pmemail@protonmail.com>
Cc: christianshewitt@gmail.com, mark.kettenis@xs4all.nl, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org,
 alpernebiyasak@gmail.com, da@lessconfused.com
Subject: Re: [PATCH v2 0/1] meson: Demonstration of using binman to produce
 the image
Message-ID: <CV6NO816M3FH.30VZXHR4KDM49@flaptop>
In-Reply-To: <d94b0cae-99cc-4f8b-9d0d-52a5858f6e33@linaro.org>
References: <CV61D7ULLVZ0.3OCFZ743L1KSE@flaptop>
 <CAPnjgZ2iff6F3CFjnjEMUVoX3bO=kv3za4Q45YOcVeZqc96=rw@mail.gmail.com>
 <d94b0cae-99cc-4f8b-9d0d-52a5858f6e33@linaro.org>
Feedback-ID: 37421466:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Simon,

On Thu Aug 31, 2023 at 9:54 AM CEST, neil.armstrong wrote:
> > Thanks for your efforts on this. I look forward to seeing where it ends=
 up.

I hope we can get it to at least boot!

> >> Honestly, in my opinion, including proprietary and poorly-written
> >> Amlogic utilities lacking a proper license, into U-Boot looks like a b=
ad idea.
> >
> > With Binman, we don't really include them in U-Boot; we allow them to
> > be fetched easily so that a complete build can be produced.

Acknowledged.

> > I don't like it either, but for users it is better than doing the
> > build manually.
>
> I'll rather spend time and effort to have a fully-upstream TF-A boot chai=
n
> for Amlogic SoC (when possible) that maintaining support for bulky closed=
-source
> x86-64 binary only tools. The tools aren't even officially distributed.

I agree with Neil here. I think having U-Boot SPL for Amlogic SoCs, along w=
ith=20
a unified way to sign it across all SoCs, is more worth the effort than
trying to get poorly-written Amlogic utilities to work, along with a
fully proprietary "Trusted Firmware" (it's not that secure) boot chain.
I also forgot to point out that these tools are x86_64-only, so if you
wanted to compile U-Boot on any other architecture it wouldn't work at
all.

But this RFC patch does show how binman can be used for making all that
complex signing automatically. I appreciate the effort.

>
> Neil
>
> >
> >>
> >> [1]: https://git.vitali64.duckdns.org/misc/u-boot-kii-pro.git/log/?h=
=3Dwip/spl
> >> [2]: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/=
plat/amlogic
> >>
> >> Cheers.
> >>
> >
> > Regards,
> > Simon

Cheers.

