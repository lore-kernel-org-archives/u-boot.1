Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE0AC2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 08:56:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A92EA87FBC;
	Fri, 21 Jun 2024 10:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UNfTrM9o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C219588001; Fri, 21 Jun 2024 10:56:47 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DD9A879AF
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 10:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57d21b1c8efso1739330a12.3
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718960205; x=1719565005; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aZjja/+lKZffQmHNU4HTQGt6LiIvm36GhBuCrybl0z0=;
 b=UNfTrM9org04CuEzFQMJawxNjLoVC1ddo2eqGxrom45QLLVBh1f7+Hz2xq/u2NIqNL
 PcZXMge+DEqZT+VqJzBWMkDL90bmWiu06pW3lAfeiKhSkmIsvIkfPiRk2JE14oO7pHOg
 dQXdgNYWUXkYL+GbTDXxR0CYThNeyA9Bjl09WW9qDvf1Y4GTtEpSCfxKnapdy9sSJkGu
 /rp9iC1mday24Fp2ZgtNaY6PWbv898gVTzs4PBL3ZNxaug3sCgDVT3H4v2PvEUltYimk
 /oe5vZWtMjJlw0wgQHfUnQh7bhBhwav7L4GwjAa/qr309xPiIcBni+AOGwQe39pcqUdZ
 u9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718960205; x=1719565005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aZjja/+lKZffQmHNU4HTQGt6LiIvm36GhBuCrybl0z0=;
 b=l2VeC2Lr5QkRf/OmPIFTCtxI3qTx0q2rx91L4uz8rokPBsqsB2Oj9L1BIeQtNVZrx4
 LteDlXZE81OsgHJ67BjT32BIEoJjDQlki1f+Bwa4zHrla+728m4M33vNWfu55Sc1LvoD
 YzVZ5TPK552CcmXO7jOSy2SryC4/XWXMxonhvIrIkj2KEqaTjOWbRQ2bylzp1gyMfnnw
 DPpfop3gNiNxvyNCTy2hQVIh00D9si+e8LGyX1YhaJte1U2LEc47FC33BHfTaII3uYGz
 rO5Ru9vT6R6wxH1ZUskYa234ltg9gNg9TY1nm9NhpeEn8y+e5YVtFtWicgZ0TE3Bc0VO
 vcuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeQJcJLYE2Ld6i51agltF182wrTWJBhTcR2Fpph5z+p86TGvCvkhqBzO70ue/F+SPvFJiXy/TQ6mN7i7LmzZLkfWUP+w==
X-Gm-Message-State: AOJu0YyLNEj6UuSPrtEZ4Uma0OVXxFVaL0wcuSU6EpIs/IpSD3PoYbbQ
 RIMa5O5+kfLaWrd2C8yhnmjiZWIs+O+RNLgQCz8TH3Eqhp61gX23TD7RtkqjrcclyeZeeGMlbwj
 VGrsGTtN3psNsis3i0uWCVaEuKCc=
X-Google-Smtp-Source: AGHT+IFF9FdnF2MQpjDJW1f3UyKb1QBQEZJc7joUtIt4vBzQX+ImO50PReroMdouQHc0VbbSU5v8sXJY9q0NSpIcaBc=
X-Received: by 2002:a50:930e:0:b0:57d:477:56b6 with SMTP id
 4fb4d7f45d1cf-57d07eaab7fmr5148725a12.31.1718960204478; Fri, 21 Jun 2024
 01:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240620213539.ftmjhphypssxp5n4@desolate>
 <a7cca1a2-5ba8-487b-9fce-1553da93c56e@cherry.de>
 <CALeDE9Ojza7T3gMxBJP5L0s0CA6CfxeO_6AAvnoUKDevG+_eBw@mail.gmail.com>
 <6d80a505-3374-406e-ab1f-959a1794cae1@cherry.de>
In-Reply-To: <6d80a505-3374-406e-ab1f-959a1794cae1@cherry.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 21 Jun 2024 09:56:33 +0100
Message-ID: <CALeDE9O=5_LnvFMLKCU3gKruTnsRBAs1jNqRD4EjkufP+HAtfA@mail.gmail.com>
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

> > rk3568 is now upstream, there was a PR upstream for this for some
> > time, similar to rk3588, albeit not as long as rk56x. In some cases
> > the issue here is the speed of review of upstream ATF. I don't think
> > that means it should go into something like this.
> >
>
> If the BL31 blob doesn't go into boot-firmware, I don't see the benefit
> of boot-firmware for Rockchip platforms to be honest. Instead of telling
> people to get their firmware from github.com/rockchip-linux/rkbin we'll
> tell them to get one from rkbin and the other from boot-firmware. And I
> have a feeling that if that's how it'll go that the vendor will just not
> care about boot-firmware as they would anyway need to keep updating
> rkbin as well.

Well it could go there, but I currently build ATF for all Rockchip
platforms we support.

> It doesn't matter whose fault it is for not being upstreamed earlier,

I agree. There's also  no reason something can't be included and then
dropped at a later time when things land upstream in appropriate
places.

> the fact is, we still don't have a **merged** open-source BL31 for
> RK3588 2 and half years after the Rock5B from Radxa was announced. So in
> that whole timeframe, we have to work with blobs (or maintain your own
> forked TF-A whenever patches are posted and hope it works well enough).

Agreed, the rk356x has *finally* been merged[1], it was sent as a PR
around 2 years before. I have highlighted this to Linaro/arm in the
past that this delay really isn't good enough.

[1] https://github.com/ARM-software/arm-trusted-firmware/tree/master/plat/rockchip/rk3568

The point I was trying to make, and I clearly didn't was. In the case
where there's open source code do we want to include vendor binaries?

> >> FYI, the DDR bin is printing stuff on the console, so we had to modify
> >> it (with a tool from Rockchip) to remove the gibberish breaking the
> >> terminal by setting the appropriate controller, mux and baudrate (for
> >> our products, there's no one size fits all :) ). The question is how to
> >> handle this since we cannot realistically store every possible
> >> permutation of that binary for each UART controller, mux of UART
> >> controller and baudrate (the only parameters **we** modify, but there
> >> are tons of others).
> >
> > I think those sort of things should be mostly quiet TBH.
>
> Mostly != fully. The console doesn't break consistently so I assume that
> if it even prints a tiny bit of info it would still be able to break
> stuff. I assume we could have binman run some logic to replace the uart
> controller, mux and baudrate. Not sure we want that but we could.

Adjusting binaries on the fly sounds problematic to me. Is the process
open or something that's NDA between rockchip and their customers?

> Also, the DDR bin is passing the console info to the BL31 binary through
> ATAGS, so if you don't fix the DDR bin baudrate, controller and mux, the
> BL31 will also not be fixed.

Ultimately we should work with the vendor to fix those so they're
consistent? Why do you're products have issues, are they using
baudrate that is different to all the other rockchip devices?
