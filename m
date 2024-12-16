Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B01E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 15:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11203800D7;
	Mon, 16 Dec 2024 16:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iyTkPg0f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 118C080214; Mon, 16 Dec 2024 16:17:14 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00A4C8003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 16:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a9f1c590ecdso718208266b.1
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734362231; x=1734967031; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ca8B7s3CrTsyVyJnWpFUYeiecIjM/tPsBSfH/c6uhYQ=;
 b=iyTkPg0fns50X2ku04coVrMsLFH0zUrD1QIhMSDFjQs4ICd1cMFKTsc/pjwb4BXtPk
 Rvh+AnKQFbArF0xXuf7LUhloxPRg+1zf874V65I/TR5i/Bsb2aPqRSwczR7RfORFviBT
 ZB46zzNRsiQFen4O1+6ZB2vIg9T01KsOfD93o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734362231; x=1734967031;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ca8B7s3CrTsyVyJnWpFUYeiecIjM/tPsBSfH/c6uhYQ=;
 b=H2+3wEiFyXMxWFle0+CbPwvN5hdqR0CF1pqkUC2bPypIGMpjg5jDNxGP+MsAn8auCx
 gsY8ci9Da9ERbvALMSRKasgyruMPwianJpSlgo9lHapgVbbLuMvQi1ygLBoGMALQaNHf
 G+pIFqu6uvc9owjWAHCUJ6A0z+yipdY/3N79W7ljCKLuc5iyGyWWfwi/PdBxLR5q/Xcj
 CQH23STSazYktgVeCSDVif64mJda7t1YppUOWsW7WOVMhPfFO9RfTRmTUr06lLW0shhs
 nT9HAeNMVmW8AQAh6TL3jHWRilq51iJBJO8c2cozuHGJL8NpncsowKtvUODy1R3gPtTv
 VRQQ==
X-Gm-Message-State: AOJu0Yxp8ZK6oblHgG6mFZAlcqo2uoqoRy2TQp88xf4fREruSDSS0jpH
 m6SuUlOpPNM4W2Dlz5fVNCH1zpSCUJ3M8yjgSbE5+kPuE42E8gAVRfl3vF2N6ohbxDWNEYKUuiF
 /1dGRfZx/qgW1Yi0keYhAFTxXkuEDfTlG5p6d
X-Gm-Gg: ASbGncuIGuBw5hBiOvoriV7xp+lHhXT77o/nZ1llfBty9V6RI6tIi7D2rRbeG2e7zfR
 ujN8DqxSkd4IUpfiFmyQ1YMjuylxy/AZwcX/4+k4=
X-Google-Smtp-Source: AGHT+IEK/0QfwBGtK2zGFRC5RJZAV3QYj51N1mvu8TNUUZkqUhGpVKca3lWo+dYO/mP9Prcx/upSYysBnomhRuw0usc=
X-Received: by 2002:a17:906:30c3:b0:aa6:c161:9935 with SMTP id
 a640c23a62f3a-aab77e7b8bfmr1161534866b.44.1734362231337; Mon, 16 Dec 2024
 07:17:11 -0800 (PST)
MIME-Version: 1.0
References: <20241209195528.730260-1-sjg@chromium.org>
 <20241209195528.730260-3-sjg@chromium.org>
 <CALeDE9P3GJitSOCA3w2RfZc-nJp3zdYQgz2rpg_CzCbhep84Ew@mail.gmail.com>
 <CAFLszTiCQ9kPCkZ7wrMGv3ENwB59KBp87vzq1qNQYEO-bdrVbQ@mail.gmail.com>
In-Reply-To: <CAFLszTiCQ9kPCkZ7wrMGv3ENwB59KBp87vzq1qNQYEO-bdrVbQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Dec 2024 08:16:59 -0700
Message-ID: <CAFLszTgeTbL2-sLhwM5x1K9gZQRiomvasp=grcnXoSJeRF9ZEg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] rpi: Set bootm_size to 512MB
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>,
 Matthias Brugger <mbrugger@suse.com>
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

Hi Peter,

On Wed, 11 Dec 2024 at 10:26, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Peter,
>
> On Wed, 11 Dec 2024 at 09:27, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> >
> >
> > On Mon, 9 Dec 2024 at 19:55, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Set this option so that all boot images stay within the bottom 512MB of
> >> memory. This should allow us to drop the fdt_high and initrd_high
> >> options.
> >
> >
> > How does this work for a device with < 256Mb of RAM? There's a number of the original RPi series that have 256Mb of RAM and that equates to less than that due to reservations for the vendor firmware.
>
> Looking at boot_relocate_fdt(), this is just a maximum, and lmb is
> used to allocate the FDT / cmdline. So this patch shouldn't affect
> that.
>
> But the later patch to move the ramdisk up will cause problems. Based
> on the comment, a 256MB (I assume you mean) device can have as little
> as 64MB of RAM available to the ARM core, which is not enough to load
> a ramdisk from the new start-address of about 90MB.
>
> I found an old rpi1 which I could hook up to my lab, perhaps. Could
> you point me to a distro-image that boots OK on that, ideally with
> only 64MB available?

Well I set it up with Raspbian. It seems to boot OK into the kernel.
But unfortunately I only have a 512MB device.

"When I were a lad, we had hard drives of 20MB and were grateful for it!"

>
> >
> >>
> >> Signed-off-by: Simon Glass <sjg@chromium.org>
> >> Reviewed-by: Tom Rini <trini@konsulko.com>
> >> Suggested-by: Tom Rini <trini@konsulko.com>
> >> ---
> >>
> >> Changes in v3:
> >> - Add to the existing comment block
> >>
> >> Changes in v2:
> >> - Add new patch to set bootm_size
> >>
> >>  board/raspberrypi/rpi/rpi.env | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
> >> index 30228285edd..a327fccc77f 100644
> >> --- a/board/raspberrypi/rpi/rpi.env
> >> +++ b/board/raspberrypi/rpi/rpi.env
> >> @@ -60,7 +60,12 @@ dfu_alt_info+=zImage fat 0 1
> >>   * Even with the smallest possible CPU-GPU memory split of the CPU getting
> >>   * only 64M, the remaining 25M starting at 0x02700000 should allow quite
> >>   * large initrds before they start colliding with U-Boot.
> >> + *
> >> + * Limit bootm_size to 512MB so that all boot images stay within the bottom
> >> + * 512MB of memory
> >>   */
> >> +bootm_size=0x20000000
> >> +
> >>  #ifdef CONFIG_ARM64
> >>  fdt_high=ffffffffffffffff
> >>  initrd_high=ffffffffffffffff
> >> --
> >> 2.34.1
> >>

Regards,
Simon
