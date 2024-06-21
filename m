Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D34C2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 09:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B12988013;
	Fri, 21 Jun 2024 11:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OYB9S0Tu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5656487FBC; Fri, 21 Jun 2024 11:37:52 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E181388013
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 11:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ebe40673d8so19540001fa.3
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 02:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718962669; x=1719567469; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P0lKVOQFA5RuuBJxZh5HTPs38+is3hRn339hBWL2kok=;
 b=OYB9S0TuS5Cvb1rHFcPu17g9ne8azq3tSSa0sNMK8u7V1OuS5kTOa3xgY9QkMvDC8I
 jqsMO23IeKKB4JZuA/CPCuBnqzUg+Iq1/X/6116J71rCEJcZUBdqiKyPNxCM0o7sLO3a
 VVDrVJAbBDB8ElqYKkY5iU7l9vOZOUjfJLTEFQHaJgtAMDVB2ggeWeirzidA+et0o5zk
 LWn3I5ctZny5WmgNrJg9xX7QPAUVQVxhyE0LS4RNpJQaSwW/VscgGJzLuBskAXjOBo8Z
 8e62dhBjapO+8QLPhj//A0/Iw1PuAbb71eIjnxybhPXJgC3KEWvje1DRFkWOCgfqdJPB
 YUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718962669; x=1719567469;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P0lKVOQFA5RuuBJxZh5HTPs38+is3hRn339hBWL2kok=;
 b=Nefh4QSmDLfIq+rWJOMB/U9gyrnFdxywsaqk1osK182yovxUn3scimSJlfbrf8HNxW
 N1EzvJOXO0vtK8e0Y78/LaguSU5dozqZQfb90KWq79pMMLRU96RP9hAsj43KADIwqYVS
 /NchMxNbEmceOSXFq3DdtbyzzJ4W7K+artxy6SBNLquy1qvWFVgonNOmerw+gcVYwod+
 CqxydfQpzOm72BaYwrTYqiLBywZyNJqtsJN19ryGqO9goyDDbZI0L9pcbCKk44CGamXF
 O8Docb50LjdKWPhrCDj3Y31ur2APwcFmEy+PMheSn8YymLB74flLg6KJxtiNzPJ6ZW1s
 w/pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6ShI+1sqD6RtL8HIfxhp+2Ev3Y4bh1iSnkcOq+GaezpG3L3P+Pry8T03Reuc73IpzrXmAz86V9e6RDE/WN43a4jTSOA==
X-Gm-Message-State: AOJu0YwoNkUSn//OpimUHImboNLQEWjofTYEt5mlIm6phOeN5DtQQbeD
 eO8aqtwGESQDddGZzV/9WbIXx7uI4o92kywT9sga6wJyH0HKwpw+ULzvfZnqBc33yuniFqJ18k4
 a7ZRATTjL6x/xbvmAYfw97ehj/3o=
X-Google-Smtp-Source: AGHT+IFD35jSJHW4jWYz4XNMDhSzskzwRue0DQWyOGOU93kmc2DKj7OCJNmkO73155DxGAbWSBIrFHRF0OUJq5eX1as=
X-Received: by 2002:a2e:818e:0:b0:2ea:8308:841e with SMTP id
 38308e7fff4ca-2ec3cecb48fmr47523001fa.24.1718962668782; Fri, 21 Jun 2024
 02:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240620213539.ftmjhphypssxp5n4@desolate>
 <a7cca1a2-5ba8-487b-9fce-1553da93c56e@cherry.de>
 <CALeDE9Ojza7T3gMxBJP5L0s0CA6CfxeO_6AAvnoUKDevG+_eBw@mail.gmail.com>
 <6d80a505-3374-406e-ab1f-959a1794cae1@cherry.de>
 <CALeDE9O=5_LnvFMLKCU3gKruTnsRBAs1jNqRD4EjkufP+HAtfA@mail.gmail.com>
 <b0380bd4-2754-4091-8917-aeb6cc57a531@cherry.de>
In-Reply-To: <b0380bd4-2754-4091-8917-aeb6cc57a531@cherry.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 21 Jun 2024 10:37:37 +0100
Message-ID: <CALeDE9NXGw4CtXu5BNqLyR46p94kW4TMKpG7GV9YNdJVwq8Abw@mail.gmail.com>
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

> > Well it could go there, but I currently build ATF for all Rockchip
> > platforms we support.
> >
>
> That's nice to hear :)
>
> >> It doesn't matter whose fault it is for not being upstreamed earlier,
> >
> > I agree. There's also  no reason something can't be included and then
> > dropped at a later time when things land upstream in appropriate
> > places.
> >
>
> True BUT every now and then we get someone who wants to keep using the
> blobs for some reason. It's up to us to allow this or not though but
> wanted to let you know that this happens sometimes. (not our clients,
> people from the community).

It's in git, they can continue to use a specific commit, tag or
snapshot, removing them doesn't stop that.

> Also, it's nice to be able to debug stuff by comparing the blob and
> open-source implementation behaviors. And sometimes even if there's an
> OSS implementation it isn't necessarily featureful, c.f. crypto support
> on the current patch series for RK3588 TF-A.

Sure, there's all sorts of user cases, we can't cover everything here
and it shouldn't be a dumping ground.

> Also, I am not sure it brings any benefit to remove binaries once they
> are in the git history to be honest, maybe in terms of checkout size if
> you don't bring the history (shallow clone I think it's called?).

It would indicate they should no longer be used. It might be due to
bugs, CVEs or that the version is no longer supported by the vendor or
even U-Boot. Upstream linux-firmware removes things once the last
supported associated LTS is EOL. As you state, it's still in the git
history.

> >> the fact is, we still don't have a **merged** open-source BL31 for
> >> RK3588 2 and half years after the Rock5B from Radxa was announced. So in
> >> that whole timeframe, we have to work with blobs (or maintain your own
> >> forked TF-A whenever patches are posted and hope it works well enough).
> >
> > Agreed, the rk356x has *finally* been merged[1], it was sent as a PR
> > around 2 years before. I have highlighted this to Linaro/arm in the
> > past that this delay really isn't good enough.
> >
> > [1] https://github.com/ARM-software/arm-trusted-firmware/tree/master/plat/rockchip/rk3568
> >
>
> Thanks, I agree this isn't really a nice situation. We cannot complain
> the vendors aren't doing their job of mainlining stuff if we take too
> long when they do (baring normal review process highlighting mistakes,
> errors, etc...).
>
> > The point I was trying to make, and I clearly didn't was. In the case
> > where there's open source code do we want to include vendor binaries?
> >
>
> Then I guess we had the same problem in failing to expose our point
> since I had the same one, would those open-source based blobs be allowed
> in that repo?
>
> I would suggest the following limitations:
> - blobs from vanilla/unpatched upstreamed open-source projects aren't
> allowed
> - blobs based on open-source projects with permissive licensing that
> allow those blobs to be shared as blobs without sources,
>
> >>>> FYI, the DDR bin is printing stuff on the console, so we had to modify
> >>>> it (with a tool from Rockchip) to remove the gibberish breaking the
> >>>> terminal by setting the appropriate controller, mux and baudrate (for
> >>>> our products, there's no one size fits all :) ). The question is how to
> >>>> handle this since we cannot realistically store every possible
> >>>> permutation of that binary for each UART controller, mux of UART
> >>>> controller and baudrate (the only parameters **we** modify, but there
> >>>> are tons of others).
> >>>
> >>> I think those sort of things should be mostly quiet TBH.
> >>
> >> Mostly != fully. The console doesn't break consistently so I assume that
> >> if it even prints a tiny bit of info it would still be able to break
> >> stuff. I assume we could have binman run some logic to replace the uart
> >> controller, mux and baudrate. Not sure we want that but we could.
> >
> > Adjusting binaries on the fly sounds problematic to me. Is the process
> > open or something that's NDA between rockchip and their customers?
> >
>
> All I can say is that I asked this tool to be open-sourced to Rockchip,
> it's currently an x86_64-only blob here:
> https://github.com/rockchip-linux/rkbin/blob/master/tools/ddrbin_tool
>
> Mark Kettenis has written something to change the baudrate:
> https://github.com/openbsd/ports/blob/master/sysutils/u-boot/rk3588/files/rkbinpatch.c
>
> >> Also, the DDR bin is passing the console info to the BL31 binary through
> >> ATAGS, so if you don't fix the DDR bin baudrate, controller and mux, the
> >> BL31 will also not be fixed.
> >
> > Ultimately we should work with the vendor to fix those so they're
> > consistent? Why do you're products have issues, are they using
>
> Consistent in which way? I didn't get what you were suggesting.
>
> > baudrate that is different to all the other rockchip devices?
>
> Rockchip binaries default to 1.5MBaud while Theobroma boards are all
> 115.2KBaud so we are consistent across all our product base.
>
> As for the controller and mux, each controller has like 2 to 4 muxes and
> there are ten controllers on RK3588 for example. Rockchip provides a
> reference design for each SoC but nothing prevents you from using a
> different controller/mux than the one in the reference design. Which is
> what our HW department has done for the three devices I've brought up in
> the last two years. I assume because we wanted to use the functions
> exposed on the controller+mux used in the reference design and you only
> have so many permutations possible.
>
> I suspect that the other HW board vendors just want to limit the amount
> of work to do in SW and just follow as close as possible the reference
> design.
>
> Cheers,
> Quentin
