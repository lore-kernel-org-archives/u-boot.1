Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428FEC02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 16:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9620808E6;
	Sun,  9 Feb 2025 17:33:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aoMzGc3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39C328091A; Sun,  9 Feb 2025 15:30:28 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28DEB80141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fa488351ffso1359802a91.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 06:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739111424; x=1739716224; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xaW5hlwOlh2arBCvq8v5owEI+6TCthXAz4hF9ksXi3c=;
 b=aoMzGc3Voukgky5kogHwlsMNPNyUWwUoDVJtzgyqkKzwZqf3DHkx3QYt18ohHeDMpo
 FapCjdXJB4Wm72TUEDa4MbyWQAWtN3PZCEkht1vN1sY5n3jfFFiEYDdAqdRbuO4cX+5S
 Zd07Wb69/ssbsuBMbN92DxRCBe//HTU0rK/Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739111424; x=1739716224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xaW5hlwOlh2arBCvq8v5owEI+6TCthXAz4hF9ksXi3c=;
 b=EycbVp27J0JP7oZDd/l+VEIXL5s5RmjIrD6JZryLe0XZ53THhEeZnFmNEM9RVcFkeU
 JFy7LO3EZs8TSg+BfRp+e94yR6NLV31MwlJHCaXHAi8bJMWdsEHVh+JSuBzbsy2brlr5
 E4rOmxj6V8CcRrV7kEH/WBLm8SOJEji137U6/NXMptzefriichM7fIBRjLjeCwZreBY2
 ZHeEs5XPHB2T2WSr/vyYNMUVgZAqhaN3hpQAOZe0lIAOGKCgYSsd6NLouOl4Yn1kqJgq
 4YUYfo98HxK5myymT43U2Jz/uHapDzmBwc7Z4vPsC+MhZRMZfe+RJgR0+BtvK4u+ZUmz
 2JoQ==
X-Gm-Message-State: AOJu0YwHeg2RL3Bt+WCAWAPkFSoJBVwt0bofYQi/a40LA9XVEzrMpbIV
 qINs6AbSuOsIbdxlGtelB0OBGVDMeWsG6ekJomQu4HZyq99qwZcwy5la/A3HMvNG6sRob8REOym
 p1ITMUR1dMWhXo0ppn9S4uNT2kld0ZZA8ONWn
X-Gm-Gg: ASbGncu9gZvutWw9uhCF9+JrtjjsBczp6/Cxgr2bGfVeExEEvm2N2sdMzuNBljkOuEG
 SJ29wzC4ninokLe/1G5MIRlzLhixddFlv9vg0NMk+I5bVrBYss8UeF9n7rQjsSdTYKY9WRh4CHg
 ==
X-Google-Smtp-Source: AGHT+IH0HpkRwKN4xXQj5R3W9UoC6qCXDlmJqeIGGI7ha7T4Ko0O+sHXuH8FR4uVZ+CBiRXcmJoK+XuzdMWlf9jtDeU=
X-Received: by 2002:a17:90b:3fc3:b0:2fa:2217:531b with SMTP id
 98e67ed59e1d1-2fa2417827dmr14314371a91.21.1739111423561; Sun, 09 Feb 2025
 06:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <034c0ec9-0a3f-4864-81b1-0cbe130b0d97@kwiboo.se>
In-Reply-To: <034c0ec9-0a3f-4864-81b1-0cbe130b0d97@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 07:30:10 -0700
X-Gm-Features: AWEUYZk1IpqqvIZaf3gYM4PwA9al-KYRfw8DVxVxzIiYIYqEa2y-6vGNTN6k398
Message-ID: <CAFLszTi2+O=-kLt9GfdXHKJKcXW1LADnsRy4cSeKUBhZjv1=1g@mail.gmail.com>
Subject: Re: [PATCH 00/29] VBE serial part H: Implement VBE on Rockchip RK3399
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Akash Gajjar <gajjar04akash@gmail.com>, 
 Albert Aribaud <albert.u.boot@aribaud.net>, Alex Shumsky <alexthreed@gmail.com>,
 Alexandre Vicenzi <linux@alxd.me>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, 
 Chris Morgan <macromorgan@hotmail.com>, David Bauer <mail@david-bauer.net>, 
 Deepak Das <deepakdas.linux@gmail.com>, Dragan Simic <dsimic@manjaro.org>, 
 Elon Zhang <zhangzj@rock-chips.com>, Frank Wunderlich <frank-w@public-files.de>,
 Gary Bisson <bisson.gary@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Johan Jonker <jbx6244@gmail.com>, 
 Joshua Riek <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Klaus Goger <klaus.goger@cherry.de>, Loic Devulder <ldevulder@suse.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Raymond Mao <raymond.mao@linaro.org>,
 Ricardo Pardini <ricardo@pardini.net>, Sean Anderson <seanga2@gmail.com>, 
 Sebastian Kropatsch <seb-dev@mail.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, Tim Lunn <tim@feathertop.org>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Tom Rini <trini@konsulko.com>, 
 Wadim Egorov <w.egorov@phytec.de>, huang lin <hl@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 09 Feb 2025 17:33:22 +0100
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

Hi Jonas,

On Wed, 5 Feb 2025 at 02:51, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> It does not look like this is based on the master branch and cannot be
> applied for review/testing. Please rebase on top of the master branch.
>
> Some quick feedback:
> - Some of these could/should be a standalone patch, i.e. os=u-boot fix.

OK, I'll move them earlier in case you want to apply them sooner.

> - All experimental VBE/VPL addition to rockchip-u-boot.dtsi should
>   probably be moved to a separate file not to clutter the regular binman
>   image.

OK

> - rk3399-generic is not generic, it is just pinepro64 with a new name?

It is loosely based on firefly-rk3399 which is a board I have in my lab.

>   Please see [1] for the addition of a generic target I sent out, matching
>   existing minimal generic targets for rk35xx.
>
> Will get back with a more in depth feedback later.

Thanks for looking at this.

Regards,
Simon


>
> [1] https://lore.kernel.org/r/20250204072710.468610-3-jonas@kwiboo.se/
>
> Regards,
> Jonas
>
> On 2025-02-05 02:54, Simon Glass wrote:
> > This series completes the work to enable VBE on a suitable board. Most
> > of it is rockchip-specific patches to support the VPL phase, i.e. the
> > one which decides which boot patch to take (A, B or recovery).
> >
> > A good chunk of this series is adding an image for VBE, by creating a
> > new Binman image. Future work in Binman may make this more automated /
> > easier, but for now it is written out in full. The work is undertaken
> > piecemeal so it is easier to review the steps.
> >
> > VBE allows similar boards to share firmware images, with perhaps just
> > TPL (around 75K) being different for each board. Using a common image
> > for VPL, SPL and U-Boot saves a lot of space in the image and makes
> > builds easier. Of course, each board still needs a separate devicetree.
> >
> > Here is the layout of the image:
> >
> > Name                          Image-pos  Size      Entry-type          Offset    Uncomp-size
> > ----------------------------------------------------------------------------------------------
> > image                                 0   1b960cf  section                    0
> >   alternates-fdt                   8000     31000  alternates-fdt          8000
> >     mkimage                        8000     31000  mkimage                    0
> >       u-boot-tpl                   8048     12a11  u-boot-tpl                48
> >   vpl                            208000     16200  fit                   208000
> >     image-vpl                    209400      a5a3  section                 1400
> >       section                    209400      a5a3  section                    0
> >         u-boot-vpl-nodtb                    10348  u-boot-vpl-nodtb           0
> >         u-boot-vpl-bss-pad                     20  u-boot-vpl-bss-pad     10348
> >     @fdt-SEQ                          0         0  section                    0
> >   vbe-a                          800000    39b200  section               800000
> >     spl-a                        800000    100000  fit                        0
> >       spl                        801400     10c97  section                 1400
> >         section                  801400     10c97  section                    0
> >           u-boot-spl-nodtb                  1a908  u-boot-spl-nodtb           0
> >           u-boot-spl-bss-pad                  1b0  u-boot-spl-bss-pad     1a908
> >       @fdt-SEQ                        0         0  section                    0
> >     u-boot-a                     900000    29b200  fit                   100000
> >       spl                        902400     10c97  section                 2400
> >         section                  902400     10c97  section                    0
> >           u-boot-spl-nodtb                  1a908  u-boot-spl-nodtb           0
> >           u-boot-spl-bss-pad                  1b0  u-boot-spl-bss-pad     1a908
> >       u-boot                     913200     e4250  section                13200
> >         u-boot-nodtb             913200     e4250  u-boot-nodtb               0
> >       @atf-SEQ                        0         0  section                    0
> >         atf-bl31                      0         0  atf-bl31                   0
> >       @tee-SEQ                        0         0  section                    0
> >         tee-os                        0         0  tee-os                     0
> >       @fdt-SEQ                        0         0  section                    0
> >   vbe-b                         1000000    39b200  section              1000000
> >     spl-b                       1000000    100000  fit                        0
> >       spl                       1001400     10c97  section                 1400
> >         section                 1001400     10c97  section                    0
> >           u-boot-spl-nodtb                  1a908  u-boot-spl-nodtb           0
> >           u-boot-spl-bss-pad                  1b0  u-boot-spl-bss-pad     1a908
> >       @fdt-SEQ                        0         0  section                    0
> >     u-boot-b                    1100000    29b200  fit                   100000
> >       spl                       1102400     10c97  section                 2400
> >         section                 1102400     10c97  section                    0
> >           u-boot-spl-nodtb                  1a908  u-boot-spl-nodtb           0
> >           u-boot-spl-bss-pad                  1b0  u-boot-spl-bss-pad     1a908
> >       u-boot                    1113200     e4250  section                13200
> >         u-boot-nodtb            1113200     e4250  u-boot-nodtb               0
> >       @atf-SEQ                        0         0  section                    0
> >         atf-bl31                      0         0  atf-bl31                   0
> >       @tee-SEQ                        0         0  section                    0
> >         tee-os                        0         0  tee-os                     0
> >       @fdt-SEQ                        0         0  section                    0
> >   vbe-recovery                  1800000    39b200  section              1800000
> >     spl-recovery                1800000    100000  fit                        0
> >       spl                       1801400     10c97  section                 1400
> >         section                 1801400     10c97  section                    0
> >           u-boot-spl-nodtb                  1a908  u-boot-spl-nodtb           0
> >           u-boot-spl-bss-pad                  1b0  u-boot-spl-bss-pad     1a908
> >       @fdt-SEQ                        0         0  section                    0
> >     u-boot-recovery             1900000    29b200  fit                   100000
> >       spl                       1902400     10c97  section                 2400
> >         section                 1902400     10c97  section                    0
> >           u-boot-spl-nodtb                  1a908  u-boot-spl-nodtb           0
> >           u-boot-spl-bss-pad                  1b0  u-boot-spl-bss-pad     1a908
> >       u-boot                    1913200     e4250  section                13200
> >         u-boot-nodtb            1913200     e4250  u-boot-nodtb               0
> >       @atf-SEQ                        0         0  section                    0
> >         atf-bl31                      0         0  atf-bl31                   0
> >       @tee-SEQ                        0         0  section                    0
> >         tee-os                        0         0  tee-os                     0
> >       @fdt-SEQ                        0         0  section                    0
> >   fdtmap                        1b9b200      2ecf  fdtmap               1b9b200
> >
> > Unfortunately I got a bit lost trying to figure out the bloblist code,
> > despite my being the original author. So for now I have included a
> > revert of a recent patch, so that the logic can be simplified and more
> > in keeping with the original intent. We may in fact need a symbol which
> > specifically says which phase creates the bloblist, but I'm not
> > completely sure of what the reverted patch was trying to achieve.
> >
> > This is (mostly) the final VBE series, but there are a few loose ends to
> > tidy up:
> >
> > - cache is disabled in SPL, which slows the boot a little
> > - pinctrl init needs to be tidied up to avoid warnings
> >
> > Other things may become apparently after more usage / testing.
> >
> >
> > Simon Glass (29):
> >   arm: Support a separate stack for VPL
> >   spl: Adjust xPL symbols
> >   spl: Allow VBE to handle xPL size
> >   vbe: Show the margin when using SPL_RELOC
> >   rockchip: Allow RAM init to happen in SPL on rk3399
> >   rockchip: dts: Factor out arch and compression
> >   rockchip: Add an fdtmap
> >   rockchip: Add more space below the stack pointer with kevin
> >   rockchip: dts: Create a template for the FIT
> >   rockchip: dts: Un-indent the FIT template
> >   rockchip: dts: Correct the OS for U-Boot
> >   rockchip: Specify the phase in the image
> >   rockchip: Provide a bootstd configuration
> >   rockchip: Add SPL into the main FIT
> >   rockchip: Include a compatible string in each configuration
> >   rockchip: Set the skip-at-start property correctly
> >   rockchip: Add a template for SPL
> >   rockchip: Add a VPL image
> >   rockchip: Add TPL alternatives
> >   rockchip: Update rk3399 bootph-tags for VPL
> >   rockchip: Provide a VPL phase on rk3399
> >   rockchip: Add symbols for spl_reloc
> >   rockchip: Adjust rk3399 TPL-stack to the same as SPL
> >   rockchip: Allow SPL to set up SDRAM
> >   rockchip: Add a generic rk3399 board
> >   rockchip: Add documentation for VBE
> >   gitlab: Add an VBE board to the sjg lab
> >   Revert "bloblist: Load the bloblist from the previous loader"
> >   bloblist: Allow relocation at the end of the SPL phase
> >
> >  .gitlab-ci.yml                                |   6 +
> >  arch/arm/dts/rk3399-generic-u-boot.dtsi       |  32 ++
> >  arch/arm/dts/rk3399-generic.dts               |  30 ++
> >  arch/arm/dts/rk3399-u-boot.dtsi               |   9 +-
> >  arch/arm/dts/rockchip-u-boot.dtsi             | 455 +++++++++++++-----
> >  arch/arm/include/asm/spl.h                    |   1 +
> >  arch/arm/lib/crt0_64.S                        |   4 +-
> >  arch/arm/mach-rockchip/Kconfig                |  25 +-
> >  arch/arm/mach-rockchip/Makefile               |   6 +-
> >  arch/arm/mach-rockchip/rk3399/Kconfig         |  11 +-
> >  arch/arm/mach-rockchip/spl-boot-order.c       |   3 +-
> >  arch/arm/mach-rockchip/spl.c                  |   3 +
> >  arch/arm/mach-rockchip/tpl.c                  |  12 +-
> >  arch/arm/mach-rockchip/u-boot-tpl-v8.lds      |  13 +
> >  arch/arm/mach-rockchip/u-boot-vpl-v8.lds      | 107 ++++
> >  arch/arm/mach-rockchip/vpl.c                  |  53 ++
> >  board/rockchip/evb_rk3399/MAINTAINERS         |   5 +
> >  cmd/vbe.c                                     |   8 +-
> >  common/Kconfig                                |  20 +
> >  common/bloblist.c                             |  77 ++-
> >  common/spl/Kconfig                            |   1 +
> >  common/spl/Kconfig.vpl                        |  13 +
> >  common/spl/spl.c                              |  11 +
> >  common/spl/spl_reloc.c                        |  14 +-
> >  configs/anbernic-rgxx3-rk3566_defconfig       |   2 +-
> >  configs/bpi-r2-pro-rk3568_defconfig           |   2 +-
> >  configs/chromebit_mickey_defconfig            |   2 +-
> >  configs/chromebook_bob_defconfig              |   4 +-
> >  configs/chromebook_jerry_defconfig            |   2 +-
> >  configs/chromebook_kevin_defconfig            |   4 +-
> >  configs/chromebook_minnie_defconfig           |   2 +-
> >  configs/chromebook_speedy_defconfig           |   2 +-
> >  configs/cm3588-nas-rk3588_defconfig           |   2 +-
> >  configs/coolpi-4b-rk3588s_defconfig           |   2 +-
> >  configs/coolpi-cm5-evb-rk3588_defconfig       |   2 +-
> >  configs/coolpi-cm5-genbook-rk3588_defconfig   |   2 +-
> >  configs/eaidk-610-rk3399_defconfig            |   2 +-
> >  configs/evb-px30_defconfig                    |   2 +-
> >  configs/evb-px5_defconfig                     |   2 +-
> >  configs/evb-rk3036_defconfig                  |   2 +-
> >  configs/evb-rk3229_defconfig                  |   2 +-
> >  configs/evb-rk3288_defconfig                  |   2 +-
> >  configs/evb-rk3308_defconfig                  |   2 +-
> >  configs/evb-rk3328_defconfig                  |   2 +-
> >  configs/evb-rk3399_defconfig                  |   2 +-
> >  configs/evb-rk3568_defconfig                  |   2 +-
> >  configs/evb-rk3588_defconfig                  |   2 +-
> >  configs/ficus-rk3399_defconfig                |   2 +-
> >  configs/firefly-px30_defconfig                |   2 +-
> >  configs/firefly-rk3288_defconfig              |   2 +-
> >  configs/firefly-rk3399_defconfig              |   2 +-
> >  configs/generic-rk3568_defconfig              |   2 +-
> >  configs/generic-rk3588_defconfig              |   2 +-
> >  configs/jaguar-rk3588_defconfig               |   2 +-
> >  configs/khadas-edge-captain-rk3399_defconfig  |   2 +-
> >  configs/khadas-edge-rk3399_defconfig          |   2 +-
> >  configs/khadas-edge-v-rk3399_defconfig        |   2 +-
> >  configs/kylin-rk3036_defconfig                |   2 +-
> >  configs/leez-rk3399_defconfig                 |   2 +-
> >  configs/lubancat-2-rk3568_defconfig           |   2 +-
> >  configs/miqi-rk3288_defconfig                 |   2 +-
> >  configs/mk808_defconfig                       |   2 +-
> >  configs/nanopc-t4-rk3399_defconfig            |   2 +-
> >  configs/nanopc-t6-rk3588_defconfig            |   2 +-
> >  configs/nanopi-m4-2gb-rk3399_defconfig        |   2 +-
> >  configs/nanopi-m4-rk3399_defconfig            |   2 +-
> >  configs/nanopi-m4b-rk3399_defconfig           |   2 +-
> >  configs/nanopi-neo4-rk3399_defconfig          |   2 +-
> >  configs/nanopi-r2c-plus-rk3328_defconfig      |   2 +-
> >  configs/nanopi-r2c-rk3328_defconfig           |   2 +-
> >  configs/nanopi-r2s-plus-rk3328_defconfig      |   2 +-
> >  configs/nanopi-r2s-rk3328_defconfig           |   2 +-
> >  configs/nanopi-r4s-rk3399_defconfig           |   2 +-
> >  configs/nanopi-r5c-rk3568_defconfig           |   2 +-
> >  configs/nanopi-r5s-rk3568_defconfig           |   2 +-
> >  configs/nanopi-r6c-rk3588s_defconfig          |   2 +-
> >  configs/nanopi-r6s-rk3588s_defconfig          |   2 +-
> >  configs/neu2-io-rv1126_defconfig              |   2 +-
> >  configs/neu6a-io-rk3588_defconfig             |   2 +-
> >  configs/neu6b-io-rk3588_defconfig             |   2 +-
> >  configs/nova-rk3588s_defconfig                |   2 +-
> >  configs/odroid-go2_defconfig                  |   2 +-
> >  configs/odroid-m1-rk3568_defconfig            |   2 +-
> >  configs/odroid-m1s-rk3566_defconfig           |   2 +-
> >  configs/odroid-m2-rk3588s_defconfig           |   2 +-
> >  configs/orangepi-3b-rk3566_defconfig          |   2 +-
> >  configs/orangepi-5-plus-rk3588_defconfig      |   2 +-
> >  configs/orangepi-5-rk3588s_defconfig          |   2 +-
> >  configs/orangepi-r1-plus-lts-rk3328_defconfig |   2 +-
> >  configs/orangepi-r1-plus-rk3328_defconfig     |   2 +-
> >  configs/orangepi-rk3399_defconfig             |   2 +-
> >  configs/phycore-rk3288_defconfig              |   2 +-
> >  configs/pinebook-pro-rk3399_defconfig         |   2 +-
> >  configs/pinephone-pro-rk3399_defconfig        |   2 +-
> >  configs/pinetab2-rk3566_defconfig             |   2 +-
> >  configs/popmetal-rk3288_defconfig             |   2 +-
> >  configs/powkiddy-x55-rk3566_defconfig         |   2 +-
> >  configs/puma-rk3399_defconfig                 |   2 +-
> >  configs/px30-core-ctouch2-of10-px30_defconfig |   2 +-
> >  configs/px30-core-ctouch2-px30_defconfig      |   2 +-
> >  configs/px30-core-edimm2.2-px30_defconfig     |   2 +-
> >  configs/qnap-ts433-rk3568_defconfig           |   2 +-
> >  configs/quartz64-a-rk3566_defconfig           |   2 +-
> >  configs/quartz64-b-rk3566_defconfig           |   2 +-
> >  configs/quartzpro64-rk3588_defconfig          |   2 +-
> >  configs/radxa-cm3-io-rk3566_defconfig         |   2 +-
> >  configs/radxa-e25-rk3568_defconfig            |   2 +-
> >  configs/radxa-zero-3-rk3566_defconfig         |   2 +-
> >  configs/rk3399-generic_defconfig              | 133 +++++
> >  configs/roc-cc-rk3308_defconfig               |   2 +-
> >  configs/roc-cc-rk3328_defconfig               |   2 +-
> >  configs/roc-pc-mezzanine-rk3399_defconfig     |   2 +-
> >  configs/roc-pc-rk3399_defconfig               |   2 +-
> >  configs/rock-3a-rk3568_defconfig              |   2 +-
> >  configs/rock-3b-rk3568_defconfig              |   2 +-
> >  configs/rock-3c-rk3566_defconfig              |   2 +-
> >  configs/rock-4c-plus-rk3399_defconfig         |   2 +-
> >  configs/rock-4se-rk3399_defconfig             |   2 +-
> >  configs/rock-5-itx-rk3588_defconfig           |   2 +-
> >  configs/rock-pi-4-rk3399_defconfig            |   2 +-
> >  configs/rock-pi-4c-rk3399_defconfig           |   2 +-
> >  configs/rock-pi-e-rk3328_defconfig            |   2 +-
> >  configs/rock-pi-e-v3-rk3328_defconfig         |   2 +-
> >  configs/rock-pi-n10-rk3399pro_defconfig       |   2 +-
> >  configs/rock-pi-n8-rk3288_defconfig           |   2 +-
> >  configs/rock-pi-s-rk3308_defconfig            |   2 +-
> >  configs/rock-s0-rk3308_defconfig              |   2 +-
> >  configs/rock2_defconfig                       |   2 +-
> >  configs/rock5a-rk3588s_defconfig              |   2 +-
> >  configs/rock5b-rk3588_defconfig               |   2 +-
> >  configs/rock64-rk3328_defconfig               |   2 +-
> >  configs/rock960-rk3399_defconfig              |   2 +-
> >  configs/rock_defconfig                        |   2 +-
> >  configs/rockpro64-rk3399_defconfig            |   2 +-
> >  configs/sige7-rk3588_defconfig                |   2 +-
> >  configs/sonoff-ihost-rv1126_defconfig         |   2 +-
> >  configs/soquartz-blade-rk3566_defconfig       |   2 +-
> >  configs/soquartz-cm4-rk3566_defconfig         |   2 +-
> >  configs/soquartz-model-a-rk3566_defconfig     |   2 +-
> >  configs/tiger-rk3588_defconfig                |   2 +-
> >  configs/tinker-rk3288_defconfig               |   2 +-
> >  configs/tinker-s-rk3288_defconfig             |   2 +-
> >  configs/toybrick-rk3588_defconfig             |   2 +-
> >  configs/turing-rk1-rk3588_defconfig           |   2 +-
> >  configs/vyasa-rk3288_defconfig                |   2 +-
> >  doc/board/rockchip/rockchip.rst               |  13 +
> >  drivers/ram/rockchip/sdram_rk3399.c           |   6 +-
> >  include/bloblist.h                            |  10 -
> >  include/vbe.h                                 |   3 +
> >  149 files changed, 1016 insertions(+), 312 deletions(-)
> >  create mode 100644 arch/arm/dts/rk3399-generic-u-boot.dtsi
> >  create mode 100644 arch/arm/dts/rk3399-generic.dts
> >  create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
> >  create mode 100644 arch/arm/mach-rockchip/vpl.c
> >  create mode 100644 configs/rk3399-generic_defconfig
> >
>
