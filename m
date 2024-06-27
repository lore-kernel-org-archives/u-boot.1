Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D042CC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD0E087D40;
	Thu, 27 Jun 2024 10:31:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b9z4AD5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 164C587D40; Thu, 27 Jun 2024 10:31:59 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00E6187C69
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b5932383e0so2664226d6.0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719477116; x=1720081916; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fgWxJayf53GFSLhLuz+EYAeCjEC1FlDA0rY4V00ks8w=;
 b=b9z4AD5gvTlzyv+xTHbbLw9bid/xx3xgIv9roWPaRQVYpZkGiIx9mrpqdlf2ZSWD8e
 dYzrKevmy4oSC1Y6hRZPx667aayZp4ALlJPUTslMct6M41glkyj9ugX+Tp0H29CMyb2g
 EzCffk5Sw9SjdMCgYidB+vVUv+cgUYwzEyfV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719477116; x=1720081916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fgWxJayf53GFSLhLuz+EYAeCjEC1FlDA0rY4V00ks8w=;
 b=eRa7Iw/qWSC0e5MvyQ/fP5bgf8mZA+byiAng3EYCwYBi8z+w/u47h4orlxcGM6pquy
 CsrbuP31RMuFUpcpfAFoTeln7+sNKkhajmx93S7lhK5wt/3zpjKcKVBs6KpzmXMt5aw1
 mPzGRlIUsFKFCPG+V05YcCxy4wyJA9vVypMCiZSjTa0Kjqkf1vVxhUq38UxhNFA4jhQg
 O/uuCeQ/dG4r2/1YioVKx4bJT3tuGQSv85hUWaSgiWlN4NJKGLKFu7EY+yeKRBlpY9IN
 geiiSLgDitc21gbLPK7jVNCwZ+u22XzJGrG+FxDb8U2c40deS013AD1bAhL1vKa2kVID
 r1IQ==
X-Gm-Message-State: AOJu0YyYRhpBZML4KHW259aeV2G1iYXxv96R40Q8aMvmgp4TKlc+NAwT
 ORD1/O3QShXva5r9E4BLayd+qGUKkVdOV9hsCXe8ZtDeBTu0lDc7+rone6GkxLu6T8T3oTc9CbS
 agh5IlRQJplq5ntN8KnTbxD/5PbDiL/NLCvDdYxbL8CVCnbWRxg==
X-Google-Smtp-Source: AGHT+IFs8UEb0YPa/IIZnbg0OWeaOX3z9yPs1AHDDf7GJyyGtOVyW1bW0K7oMlkC1n9FlQub4j+WiEzdJYvtAaJnm4A=
X-Received: by 2002:a05:6214:21c6:b0:6b5:1584:62bf with SMTP id
 6a1803df08f44-6b59317b05cmr17522846d6.6.1719477115812; Thu, 27 Jun 2024
 01:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240626155945.278640-1-sjg@chromium.org>
 <20240626163443.GY38804@bill-the-cat>
In-Reply-To: <20240626163443.GY38804@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 09:31:45 +0100
Message-ID: <CAFLszTjDt6MKCoc3vzeUc=fscZ7CBmjQOj=gsvqenEtY_znL0g@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] Bug-fixes for a few boards
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Jerry Van Baren <vanbaren@cideas.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Lukasz Majewski <l.majewski@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 huang lin <hl@rock-chips.com>
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

Hi Tom,

On Wed, 26 Jun 2024 at 17:34, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jun 26, 2024 at 04:59:29PM +0100, Simon Glass wrote:
>
> > This series includes fixes to get some rockchip and nvidia boards
> > working again. It also drops the broken Beaglebone Black config and
> > provides a devicetree fix for coral (x86).
> >
> > Note that since this series fixes bugs, it is targeted at -master
> [snip]
> > Simon Glass (16):
> >   mkeficapsule: Add a --version argument
> >   binman: Collect the version number for mkeficapsule
> >   binman: Deal with mkeficapsule being missing
> >   binman: Return failure when a usage() message is generated
> >   binman: Keep the efi_capsule input file
>
> Can you please split these out from this series? At this point in the
> cycle I just want obvious regression fixes.
>
> >   nvidia: nyan-big: Disable debug UART
>
> This is fine.
>
> >   tpm: Avoid code bloat when not using EFI_TCG2_PROTOCOL
> >   x86: Set a board-size limit for chromebook_link
>
> These two combined are fine.
>
> >   rockchip: veyron: Add logging for power init
> >   power: regulator: Handle autoset in regulators_enable_boot_on()
>
> These have acks and are fine.
>
> >   fdt: Correct condition for bloblist existing
>
> I'm waiting for review tags on this one.
>
> >   spl: Allow ATF to work when dcache is disabled
>
> This is fine.
>
> >   rockchip: Ensure memory size is available in RK3399 SPL
> >   rockchip: Avoid #ifdefs in RK3399 SPL
> >   rockchip: bob: kevin: Disable dcache in SPL
>
> These keep being iterated on?

I believe the last one is OK...the other two don't help my boards
anyway, but I'll continue trying to figure out what is needed.

>
> >   Drop the special am335x_boneblack_vboot target
>
> This is fine.
>
> It might be best for right now to split out the patches that I've listed
> as fine above, to one series that I'll pick up today after my current
> queue of next testing is done, another of the binman/mkeficapsule
> changes, and another of the remaining fixes. Thanks.

OK done, except I added the 'Disable dcache in SPL' patch.

As noted in the series, I would like the FDT bloblist thing sorted out
/ applied, even if it is a stopgap in -master.

Regards,
Simon
