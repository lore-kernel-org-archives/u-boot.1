Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9538DC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 12:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0B5384AFD;
	Mon, 13 Jul 2026 14:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="ju4Wjico";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05A8D84AFF; Mon, 13 Jul 2026 14:47:48 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7E8B84AE7
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 14:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c1601d552a8so307986666b.2
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 05:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783946865; cv=none;
 d=google.com; s=arc-20260327;
 b=egNDMsKmYwhr/jGddYswnM51C5lKe8PcXoASRMVcWHlcathkbUJf4Jl5IgudHhWBUR
 Kl90846Wkzg+5w9M4TrA19TDBp8Jvz1PeLtInK+bIC5wnPCxBxeefGo6NriNuws4wHC0
 m4kO5z26o3V+6ee8q3QNxZqPKeFqIH4JWmMMgdnFEore6E0FPEm4Q8J+ZZnp8hlkNrPI
 4Q3KGBQts6GTbdAPrhIsbWJt0gqc73NQZDISNXzKy4YIqgRhqnNiil++MbNEjoUJXmIN
 W0GZd4ZrElefBXkNrM9vxOxPLOATDuqKXc++918H9+VKPfTF/7vQIDbsTcGQ1AiwQ7cZ
 k8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XkiRRpNumb+wBCH1+zFHzspMRZx8bAGn/wqSxsdyS+8=;
 fh=UFHAlT3cks6Ib2q4zWS0gwBormE1w5fITlWGjjdiCuA=;
 b=kGFGtLwgFHTuHzOOpFRQgv6ldLw3bG5JFxYRAbgtQu70u0+DCYAKLfSrpAvIzbG5e1
 GEbcGtznaMCSamgWkrmA7ytIFd7ifsh4tuFKrZjflO03nURkqvT2VC8EiytlnbiVRU4q
 yLFn8Mnc+EPeWuLRzuX32xAZuaxX9mB/pOVyaRySMlPg70Gg0vOb0bCdrSM1NRigcsuW
 hZVyD7NbjJXkMSD2+aN5Ej1Mx+p6vfzmq+UG/vsAT9eJdpuYei6q8mQieJjgn+snlDMT
 0J09h9VmN0JViP9IGWVh8pyv1uKvcyI/Vmv3Et2MuwEZl9uU5FtvRyK3dyEwrqODOtI0
 7NfQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1783946865; x=1784551665; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XkiRRpNumb+wBCH1+zFHzspMRZx8bAGn/wqSxsdyS+8=;
 b=ju4WjicoAkqWUsnHp2DBsx+Vwx1V5oqR9al0E9DPEai61OM0cEuZgtsfQSmZI0FBkz
 g+a3jOIRSNuwgR4OSpoRyDy6oAlcvnYry7sckHlpyhlQn9Zs+pvP1OzBgR6zR6fOB9qQ
 2ZCxepyl6hRXdvAAUyEtIxoZ35wNuDtEBkrlRk6/CWoM/omJXzG2ufz0yjR1jSOaYWAf
 pKOHYEn5PGhX/+Bl4VCp8yUJSx/FSTYAdFJa2zhrqqRk2yv6pxoPQHfEaFHecq9geMRI
 8ZVN/gennfAkEPzworE1eJNcefleRZEEIzzT0C0IZughfA3xWovROAY80TxpOL1nMYK3
 Jx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783946865; x=1784551665;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XkiRRpNumb+wBCH1+zFHzspMRZx8bAGn/wqSxsdyS+8=;
 b=ez6zQXwZ+BhePxOtqc/oG7w0VBAKiDxKqmnwwby0WIfiasZ6MtZMlUVPIiriq50gwH
 xWdLHEYIl3XIIcZxvGlzDmwNii9FE//WibDSgvuyQQ6x9kYHGrd6tI3mWIqe9bUpLRTv
 EE8TKeCxMS4OaSKauqrMFVQ0nLY8/3bPdCyT+oKPxS+JSdPFWPOknwpyri5DnreVES+M
 +arg9KshkE4b2XxIzhjC6tQOAESd3nNb89HBsfxzjzPJUiHVrcgbmgB6OwzvOVbRbXJk
 M/9wMccLYClXHK6VsTb9PY8M6BH0+ZGCen0ne2NE4lYiJHJOjkJP0+Kz4aW4J0HbpXFr
 OY2g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOwnnfrOK4kYJAsgxkOIRto4PA8Mx1eKfcyseWVdhELdAvTlQNBtUqpo7hEU2uNMgCOru9VVc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5EDTCiuavLfsdeqzmhs3iDXUen07x/qGUo/+23ULuTbkOCiWE
 Sq9Fatu+8Np6gA2G8l/fLbgyBVWRXF3ZxZsmLlJ74IRhz49HJPsxOKPQbACVTyt8gHBQD++Y8Gd
 7sj01GAAu6r8q2jjOJdt923IJQkNrWlSyNx+PCb69AKlJ4/vxQH4VliI=
X-Gm-Gg: AfdE7cl1JsWpaeLft7JEX9OWZgmz+NMDQCHMdxPreUNkAxb6MccGn34h/Wdrko9ikN+
 vFfuQ73yO+j49xqlmPx8jzXASTQJDQccf2YxwTFP1vDy5KDPALtWK20mN0S52EOtSCfHveRQuIo
 n84UPErvdd2Z/d35gt87WduUJvAj40doYe4b/C+B3YuFrOreBOxte5UnxV8GOz6HJ9/PVSzcjGq
 iX+PhM5SZCoz+1Hu/0Mb2ZgBzqQzy7Gfo1UZxO8I2BlAgUL5yseDQtKMw5gXVY74RWK/9tM1uSd
 rvIgmWWe7O6ir5gmKQp6x8IEqlk=
X-Received: by 2002:a17:907:3f0c:b0:c16:29eb:e84a with SMTP id
 a640c23a62f3a-c1629ec2d63mr373020766b.53.1783946865073; Mon, 13 Jul 2026
 05:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
 <b09297f9-f22d-493a-974f-47749955e532@kwiboo.se>
In-Reply-To: <b09297f9-f22d-493a-974f-47749955e532@kwiboo.se>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 13 Jul 2026 16:47:34 +0400
X-Gm-Features: AVVi8CdMf-h-Qmb1_PFprcpUC321qLEpEiZuODGrjv8HIHV0p2kf9kU0p2KwwAo
Message-ID: <CAKTNdwFWMKoA3fkXUWXJYJSDROHhrqbPbJ3RTCjvnOAF7UCfQw@mail.gmail.com>
Subject: Re: [PATCH 0/7] rockchip: fix boot from SDMMC on RK3576
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
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

On Mon, Jul 13, 2026 at 2:44=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi Alexey,
>
> On 7/13/2026 12:02 PM, Alexey Charkov wrote:
> > This aims to upstream Jonas Karlman's long-standing patch series fixing
> > the boot from SDMMC on RK3576, which requires a hotfix to the boot ROM'=
s
> > global state area before any SDMMC reads are initiated to avoid clobbin=
g
> > the ROM's state and breaking the boot process.
> >
> > The preparatory patches for the image tools are submitted verbatim from
> > Jonas' version, while the "boost" code doing the actual hotfix is
> > converted from using a pre-built tiny binary to a from-source build usi=
ng
> > the existing U-Boot build system.
>
> Thanks for re-sending this, this should likely have been labeled v2 and
> there are review comments on my original series [1] that should be
> addressed.
>
> I was planning on sending a v2 of the preparation series now that we
> once again have an active maintainer for Rockchip, but unsure how to
> handle that now :-)
>
> [1] https://patch.msgid.link/20250129223641.1888833-1-jonas@kwiboo.se/

Oops, here I am again, missing things already reviewed on the ML. My
changes, though, are only concerning the very last patch in the series
(which hadn't been sent out back then), and I haven't touched the
other code in any way.

Would you like to give the mkimage-related patches another go then,
and then we bring in the boost.bin changes on top? I'm also happy to
help incorporating Quentin's feedback if you'd like, although I don't
know if that enters "too many cooks" territory :)

> > From-source build also alleviates the problem with parallel out-of-tree
> > builds, which could skip the pre-built binary but which always pick up =
the
> > from-source build.
>
> My original intent was to try and embed the generated code to possible
> match what I did to support emmc boot with the amlimage format, see [2].
>
> Building the boost blob ourself the way you do here seem like a better
> option, however we should probably change to include the blob and
> setting the required parameters using binman instead.
>
> For e.g. RK3572 and RK3538 there may be dboot/rboot blobs needed prior
> to ddr-init, along with choosing to load SPL to a different DRAM address.
> So we should prepare for being able to pass parameters, how I do not yet
> know, possible using a new rkimage etype in binman.

Having everything in binman sounds neat, but on the other hand the
current mkimage-based approach seems to work fine, so why fix what's
not (yet?) broken? :)

For RK3576 that would mostly mean "reimplement mkimage in binman",
from what I can see, as we still need to give the boot ROM the
combined idbloader header it's built for and which mkimage produces.

> [2] https://patch.msgid.link/20250103215904.2590769-3-jonas@kwiboo.se/
>
> > Tested on a number of RK3576 boards, including the Rockchip RK3576 EVB1=
,
> > ArmSoM Sige5, FriendlyElec NanoPi M5, Luckfox Omni3576, Radxa Rock 4D a=
nd
> > Flipper One, all of which fail to boot from SDMMC without this series b=
ut
> > boot fine with it applied.
>
> It has always been possible to boot from an SD-card if you compose an
> alternative idbloader.img using boost+ddr blobs and u-boot-spl.bin from
> U-Boot using the boot_merger tool from rkbin and write that and u-boot.it=
b
> to the SD-card.

Rockchip's boost.bin blob does exactly the same thing as your
assembly, plus setting UFS power mode parameters - and that's it.
Power mode parameters at pre-TPL stage don't make any meaningful
difference in any of the workloads I tried, so I'm not even sure why
that part is included. So yes, using their blob and their tool should
work too, but that doesn't count in the context of mainline IMO :)

> > I've also done some JTAG debugging of the boot process, and the single-
> > word write which the boost binary performs to the SRAM at 0x3ff803b0
> > appears to be relocating the base of the SDMMC IDMAC DMA descriptor buf=
fer
> > to the top of SRAM, which prevents large multi-page SDMMC reads from
> > overrunning adjacent ROM state and thus breaking the boot process. A
> > comment has been added to the boost code to reflect this.
>
> Awesome, thanks for this information :-)

Cutting down magic in this world, one memory store instruction at a time :-=
D

Best regards,
Alexey
