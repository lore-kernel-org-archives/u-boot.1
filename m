Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EF9C2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 08:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D4CE87FBC;
	Fri, 21 Jun 2024 10:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ecZ4mRri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42AB988001; Fri, 21 Jun 2024 10:58:00 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EECC0879AF
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 10:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57d2fc03740so414389a12.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718960277; x=1719565077; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JuOpYKCYq6QGUpUx7ozwI6xDNo/gullDReeERxyDlfI=;
 b=ecZ4mRrizvYgXj4HOpuQilpO6bVPCD6lMQFJrvR8ID6alAviObW8beWv2dnfj7/7Ic
 ycBMwL9Mv3o11dVywY6dNBm2TTm4lRVY0tjwfFFqq+pYGIWheIGVMeuYbtH0/+cRhsgf
 A1fpngumEuA8tVgerfe5zG/KxS90QgcypcAPAG3PLuR64v8gZuO70ArveMqiRLARkkAU
 BCX6Zj6aHHqjPtk7sHnCC76RGBepNFJ2C+s52B612n+lj51bx7dLV8N2jylIpwREfaer
 kWtOcwhF5YUkhdBYTLZOWKVx2Q/evnU5INmCGlQ94x4xMj8ZQDz7VznFAMx/Pn0gYz/T
 LcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718960277; x=1719565077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JuOpYKCYq6QGUpUx7ozwI6xDNo/gullDReeERxyDlfI=;
 b=H5bbfRpsgw2TKZTBhq5J8KsGZEKumuSmqTI7afct8kKlwC3uirKEkZepgJxLdw5QkE
 YDiOXDS4+yY+stU0gUiVlGiViiu3ZPtJby52WxGQpspIwFM+VFBw/QrymGxUcj12xJre
 tVdN6X4keczM8VkyfWdG2r7WvJfoNGYa7t8FE6FG9OLXzUKXALKN1iNkLVAEXctVIBYl
 Sp0lOS+brPhoSh19RsSE95+NSOYqA/qq6swfAbE3I0qUJto0gz3KWVN9GMY9fwu1fH3C
 XHC4ura8f4C4UXTc6KqFuzbnxgMQj2k1asogp1YCn+o7F3Q46svIk5ORGIPmH2gI0OJn
 4oAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp0NFPVEr8IjSO7bsOZGRmLvDgIfO/MH9Y7aWGM/uv7GSaSTDQl6nyhxDjXCONT8PUqboIrtuxuk0AWN8zANS4MprN0Q==
X-Gm-Message-State: AOJu0YzGF5gJRuH+e29soA1OEJTRnJUbS7EZ/DhMhsrMUTMulepMJ9HT
 mf+R4RNPnPHjgUDxvlrMw3l6JmT+Cf1tA71kNzc6GFJGMYiRr/G1T2DAmJ+cyVcnCe0XHSdGPUX
 q3xAq3++DVe0TJo+QSNg8DBsg+0g=
X-Google-Smtp-Source: AGHT+IHcGn4Ywh5uAW2txBPsC8UcjmpioTLPn2cpCwlYOfaRAzdr1JMMXeCI72+K048irCANjb2mzBTI5AqjPiesnsU=
X-Received: by 2002:a50:96cf:0:b0:57d:730:e0d5 with SMTP id
 4fb4d7f45d1cf-57d07e7a4edmr4848645a12.15.1718960277168; Fri, 21 Jun 2024
 01:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240620213539.ftmjhphypssxp5n4@desolate>
 <a7cca1a2-5ba8-487b-9fce-1553da93c56e@cherry.de>
 <CALeDE9Ojza7T3gMxBJP5L0s0CA6CfxeO_6AAvnoUKDevG+_eBw@mail.gmail.com>
 <6d80a505-3374-406e-ab1f-959a1794cae1@cherry.de>
 <CALeDE9O=5_LnvFMLKCU3gKruTnsRBAs1jNqRD4EjkufP+HAtfA@mail.gmail.com>
In-Reply-To: <CALeDE9O=5_LnvFMLKCU3gKruTnsRBAs1jNqRD4EjkufP+HAtfA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 21 Jun 2024 09:57:46 +0100
Message-ID: <CALeDE9Pgrhau98t4eKPZVGKbAxs7we2Lha+LqnrMABpFB=C4hA@mail.gmail.com>
Subject: Re: Request for hosting a boot-firmware repository in u-boot git
 (denx and GitHub)
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Enric Balletbo i Serra <eballetb@redhat.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Josh Boyer <jwboyer@redhat.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
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

On Fri, 21 Jun 2024 at 09:56, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> > > rk3568 is now upstream, there was a PR upstream for this for some
> > > time, similar to rk3588, albeit not as long as rk56x. In some cases
> > > the issue here is the speed of review of upstream ATF. I don't think
> > > that means it should go into something like this.
> > >
> >
> > If the BL31 blob doesn't go into boot-firmware, I don't see the benefit
> > of boot-firmware for Rockchip platforms to be honest. Instead of telling
> > people to get their firmware from github.com/rockchip-linux/rkbin we'll
> > tell them to get one from rkbin and the other from boot-firmware. And I
> > have a feeling that if that's how it'll go that the vendor will just not
> > care about boot-firmware as they would anyway need to keep updating
> > rkbin as well.
>
> Well it could go there, but I currently build ATF for all Rockchip
> platforms we support.
>
> > It doesn't matter whose fault it is for not being upstreamed earlier,
>
> I agree. There's also  no reason something can't be included and then
> dropped at a later time when things land upstream in appropriate
> places.
>
> > the fact is, we still don't have a **merged** open-source BL31 for
> > RK3588 2 and half years after the Rock5B from Radxa was announced. So in
> > that whole timeframe, we have to work with blobs (or maintain your own
> > forked TF-A whenever patches are posted and hope it works well enough).
>
> Agreed, the rk356x has *finally* been merged[1], it was sent as a PR
> around 2 years before. I have highlighted this to Linaro/arm in the
> past that this delay really isn't good enough.

Also I don't believe this repository should be used as a band-aid for
other problems.

> [1] https://github.com/ARM-software/arm-trusted-firmware/tree/master/plat/rockchip/rk3568
>
> The point I was trying to make, and I clearly didn't was. In the case
> where there's open source code do we want to include vendor binaries?
>
> > >> FYI, the DDR bin is printing stuff on the console, so we had to modify
> > >> it (with a tool from Rockchip) to remove the gibberish breaking the
> > >> terminal by setting the appropriate controller, mux and baudrate (for
> > >> our products, there's no one size fits all :) ). The question is how to
> > >> handle this since we cannot realistically store every possible
> > >> permutation of that binary for each UART controller, mux of UART
> > >> controller and baudrate (the only parameters **we** modify, but there
> > >> are tons of others).
> > >
> > > I think those sort of things should be mostly quiet TBH.
> >
> > Mostly != fully. The console doesn't break consistently so I assume that
> > if it even prints a tiny bit of info it would still be able to break
> > stuff. I assume we could have binman run some logic to replace the uart
> > controller, mux and baudrate. Not sure we want that but we could.
>
> Adjusting binaries on the fly sounds problematic to me. Is the process
> open or something that's NDA between rockchip and their customers?
>
> > Also, the DDR bin is passing the console info to the BL31 binary through
> > ATAGS, so if you don't fix the DDR bin baudrate, controller and mux, the
> > BL31 will also not be fixed.
>
> Ultimately we should work with the vendor to fix those so they're
> consistent? Why do you're products have issues, are they using
> baudrate that is different to all the other rockchip devices?
