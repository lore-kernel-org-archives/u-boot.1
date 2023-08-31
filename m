Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EC9C83F2C
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C3268655E;
	Thu, 31 Aug 2023 05:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NwL8r2Ws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED3368655E; Thu, 31 Aug 2023 05:38:19 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E25F9862F1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52a39a1c4d5so346383a12.3
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693453096; x=1694057896; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+TBDO8JqA8Pf9p0rgCblrIY62nYVu3+o0sUrr3BC2qQ=;
 b=NwL8r2WsLyHlxnBnwMZKPwmMK8TY7KjWtxCYLPwpC04U7DZrO1xWLavD7kgdqHNJEo
 LH9TrDuGFyklz6sII2y90ywCP/KdlXz6pCnIYBu3oB47glSVPDhGvHdSUyttSI/3+5Mg
 OR8GybL7xn6ZkHB/MebnmhyPBwMfmgLXizrlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693453096; x=1694057896;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+TBDO8JqA8Pf9p0rgCblrIY62nYVu3+o0sUrr3BC2qQ=;
 b=FXgllzRuiSmts8pvOs4PIQFXxXkCgDwHIjKBun/yoVmVZN/SBiePvohElooRHyA73d
 dk9LcLXdxOz98tmtPuNSZOCmAx3LW8QWRKPjQw1ugSndkUesCQ7QemkwpZC/JMiI+5MS
 u3oE0iRCBE14Jbpk4BbfZ9Lb/BCphYak/5El2iH7nF3pDAGxEocZfoDMBTDtl8kyWBVX
 7J/DtvER1x5L/lH+cEad+xNmLDj0C1/cR7v90Rrg6NkAmO0tkZfTr2LHlbw+b2D8vzBb
 LVW/aAQ9v3KICfcND1YsSVHa1LHR9CoB0Dj9vUZAHc/agHpatojUpDRWtyMj3rDt5WBW
 ozdA==
X-Gm-Message-State: AOJu0Yy3XzvkqkmNxB3UaoilqdozR1AIVqh34JLzRyR5O9SyCp8Zf3lP
 1Y/tqk1XY5MarZnqMNZC1ycT7mgLuHpD3Gl1SyCbEQ==
X-Google-Smtp-Source: AGHT+IEjFiu62u5N67UVTqm5UbxRyyA+VXGOA+J0tJ8IwfoU8mL918TT7EIDoE5gsrtUg2ftN13ejRtlXTj9gKcJOgY=
X-Received: by 2002:aa7:c657:0:b0:525:6d9e:67c0 with SMTP id
 z23-20020aa7c657000000b005256d9e67c0mr3389762edr.23.1693453096168; Wed, 30
 Aug 2023 20:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <CV61D7ULLVZ0.3OCFZ743L1KSE@flaptop>
In-Reply-To: <CV61D7ULLVZ0.3OCFZ743L1KSE@flaptop>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Aug 2023 21:37:59 -0600
Message-ID: <CAPnjgZ2iff6F3CFjnjEMUVoX3bO=kv3za4Q45YOcVeZqc96=rw@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] meson: Demonstration of using binman to produce
 the image
To: Ferass El Hafidi <vitali64pmemail@protonmail.com>
Cc: christianshewitt@gmail.com, mark.kettenis@xs4all.nl, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org, 
 alpernebiyasak@gmail.com, neil.armstrong@linaro.org, da@lessconfused.com
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

Hi Ferass,

On Wed, 30 Aug 2023 at 11:53, Ferass El Hafidi
<vitali64pmemail@protonmail.com> wrote:
>
> Hi Simon,
>
> > So I wonder how best to move this forward so that we can build things
> > using binman and everything works?
>
> It's still not ready yet, but I'm working on porting U-Boot SPL to some
> Amlogic SoCs [1]. I'm currently working on Amlogic S905 boards, but
> eventually I'll work on Amlogic S905X devices too. And speaking of
> signing, Jonas Karlman wrote amlimage, and integrated it into mkimage,
> and I applied his patch to my tree. There's a few things to be aware of
> about Amlogic signing and binaries in general, however.
>
> amlimage was intended for use with U-Boot SPL, which obviously has
> no support for Amlogic's FIP format and as such amlimage will only do as
> little as possible to get the bootROM to load U-Boot SPL. Most of the
> packaging format is handled by BL2. The fact that the signing process is
> completly different across SoC generations makes it difficult to
> implement them all into one single tool (and by which I mean all of it,
> not just signing BL2 for the bootROM to run it, that's mostly the same
> across SoCs). amlimage has been confirmed to work on GXBB (ODROID-C2 and
> the KII Pro set-top box), GXL (librecomputer lepotato), and SM1 (ODROID-C4).
>
> My U-Boot SPL port is still rather incomplete. As of today, it still
> can't boot anything from any storage device. The goal eventually is to
> be able to load upstream TF-A BL31 and U-Boot+linux.
>
> While Amlogic distributes proprietary BL31 binaries upstream Trusted
> Firmware-A has a port for some Amlogic SoCs [2], but as far as I know
> SM1 (which is the SoC generation your ODROID-C4 is using) is still
> unsupported. GXBB, GXL, AXG, and G12A are all supported however, but the
> overall port still lacks some features the proprietary implementation
> has.
>
> As for the SCP firmware (aka. BL30) I'm not aware of any
> reverse-engineering efforts for that.
>

Thanks for your efforts on this. I look forward to seeing where it ends up.

> Honestly, in my opinion, including proprietary and poorly-written
> Amlogic utilities lacking a proper license, into U-Boot looks like a bad idea.

With Binman, we don't really include them in U-Boot; we allow them to
be fetched easily so that a complete build can be produced.

I don't like it either, but for users it is better than doing the
build manually.

>
> [1]: https://git.vitali64.duckdns.org/misc/u-boot-kii-pro.git/log/?h=wip/spl
> [2]: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/plat/amlogic
>
> Cheers.
>

Regards,
Simon
