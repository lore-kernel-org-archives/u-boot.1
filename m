Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9949C982D4
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 16:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C636283942;
	Fri, 16 Jan 2026 17:14:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gcc/2dfd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 237F78309A; Fri, 16 Jan 2026 16:52:53 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85A8D8003E
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 16:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-5014e8a42aeso22992751cf.2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 07:52:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768578769; cv=none;
 d=google.com; s=arc-20240605;
 b=BgdVIMN0cyNG0yMaluq9v5KavA/QfiuNdZoAXkhS6idj9snlLTfnvZqznnHJvwJDr1
 Ediqv9v51u+2W2zDPrkVo743NnwhKqfWa6j2/MK0bExYIh95epyAh+uSbs57bO4UDJ4B
 iF+XfsmSMlStkvL59hsGyVv4HIXTavnmc0q14D4zbuvw1kBvIx+Jg7uinYNn8shHZNe7
 croPCTGV4G0rvfhIWLdAlg66xtJac2U6JeZ0BWQ4GqleTTAGFH73h54+p7phNI+Krvym
 2vx8qzTbRuxLafBAknZnlyzLzO4UTS49bVfilryyIzWvzrkzVqseTm3g4oSzhgoEeFV4
 j+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9qB6o9Xr+8Jr2vvr5nnf25T1BUf/2DvUmvl0ak1RGDY=;
 fh=8VqwTZ7piYjPWQEFUarO0F8pZOq/0cPbU4RFz6Q+04g=;
 b=Os/kuVaDME8aGFw1wXGHTeQA0yJKh046Fx6+rk9MUaCoQLjMget+4Eaw+qceBeQn4D
 pVY8+LHlx1Xlg0piJJutt7IlRp2EKK11HSgno86MLIoblhuHNgBIGMs1CtmAgl5k3vwt
 VVivfqHXxTk904xAsAzVStfY8BGhXYvhAMP+F9sKdJcJOxRkuDxRkNogQ8XZ6cLXiP6R
 MNHF5gY6ER3y65rxLU49LAuxiYuo+a8ngQLDq9+SBUrCXJ9Ceangq0QQYS/WO9OXehQT
 BVY3BE6wAd3NiPiLjGL/etG0AZwOWVjCqoWPRFiZHejuOnFeuP4zoW1PzwLoxW1lMGdZ
 Vw/A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768578769; x=1769183569; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qB6o9Xr+8Jr2vvr5nnf25T1BUf/2DvUmvl0ak1RGDY=;
 b=gcc/2dfdmvu5XaMMmBpwoqYRliT3itE70kbOXKw+cA28/QsoKTwmdcBlVWeLygaPb1
 tPfKwppP9/A8p/WRtBMTDmxt/50EC6L81dzOk/faUD50mNr/GU2ugsXc86vxWz4BxTsA
 3BMHhZv3UV6YW3uTAzpFjWh5JfmCZC+B2NVf7ia5/NybBOFqHv0395TV9eHwcS1L8zgJ
 FB7RDY+HOlOJnm4GqEqCc2U55OPG0eYuYHvfhUerEy+i08ZsoYpl9RY2H58n+dKX/95T
 5fgAc+FEg3S+pkuyHi2zDMNry452OZfv1mqHv+R05IunavM3PWYdUvQfrBVefjzr86kV
 RuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768578769; x=1769183569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9qB6o9Xr+8Jr2vvr5nnf25T1BUf/2DvUmvl0ak1RGDY=;
 b=MMmeA+3ENxZnYLV411IwVUUc86wfuTkNaPlWBGAdu8urfWbHNDLdjYS+A1NsH2nOa4
 CY+Z9hG/C/62dku4a7l4o8NWJbSLf7n8FeYhLt8lCx5Z8fIOCy7tcqTuGAdGHDM9jz3N
 vrK/YIB8SGLRHMGb1LCzoxLHWI5UtcsHGMIkkFGbFBDuTiwiIMu++b1380q77QvmuChU
 DmFMqw06L1b3Dr8jlxsMrIMY16XJqXMBzXet1crixEeViUSS94ZiPtweZHBM9PZ6HNi4
 zovh2Fo72uf0HkkRSjGGa+2zrp+vKtcyxJKsOhoHqSB08kQGnXD0khkgP8uQXjbi1s67
 pSzw==
X-Gm-Message-State: AOJu0YzdrvTjyBAxEYIRPaKZXtSI5ESMp8ILZtDSy5ZPR450kjTcSF/G
 2yzrmk9yRYt1+XfnbC07/m30Xe+atp3w1M8hOZ/oVb/2wK0cQq6hJ7HLQ7WRlXHHStlEnvaHSkZ
 nWLjGCjQRzFA5BgJjb4tcvllz5hZftPs=
X-Gm-Gg: AY/fxX7IedPKHp0pNyXXcaQtEdSANnukKz72m0iH5AUoYB3hVkcdmZd4C+GDiGtbTtx
 z+zJqWftv5uPUodPsX9VL00Id/3SGBFOAV91kG9qRThCpJzuPMlYPkHTYX4GPCmxZFTHTB7SWSV
 XEXfyyEyk9vPY2CPLe/R/nHpJlouu+LWLNeLpHxVqFVM9ytq9RF3qfsDMA43bmhrj8WDEAFB4VJ
 gb9IxMO6eY3nKwmy6LrYkaYzMPOOQ9fcfIupC9U0pnMWYCz8Gn1URLfVrOe25e4ERCf+hr4NeHT
 BIbaIiVZHTRVx6RokWtpu0P1Xy8=
X-Received: by 2002:a05:622a:1794:b0:4f1:ba52:2529 with SMTP id
 d75a77b69052e-502a162a974mr43538711cf.2.1768578768995; Fri, 16 Jan 2026
 07:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20260108-rk3576-ufs-v4-0-e8e67649f3f8@gmail.com>
 <20260108-rk3576-ufs-v4-3-e8e67649f3f8@gmail.com>
 <f6e97d23-4f92-43d1-a3b9-beeef3211145@cherry.de>
 <CABjd4Yzf-y05Qp3+5LVFrHeN_MMZu9TOXozrkjnXVU2MJU_WoQ@mail.gmail.com>
 <3b1184ab-f995-4b86-a2f0-65a5163be9c1@cherry.de>
 <CABjd4YxGYd6TVJEE3Nh9Qd6DQ+aKN09BP2u5+OBPcc8tNwpTJA@mail.gmail.com>
 <259fc358-f72b-4a24-9a71-ad90f2081335@cherry.de>
In-Reply-To: <259fc358-f72b-4a24-9a71-ad90f2081335@cherry.de>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 16 Jan 2026 19:52:37 +0400
X-Gm-Features: AZwV_QhijrzvoTj3tkL86nAcACgxqXtIo7fjrkx3DtjLG3UqGbYkWnooHO9YvIA
Message-ID: <CABjd4YzRv90qv3rU7Oyd_O0DeuYoatb5mCL-jtkRAfc8LZJSqA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] rockchip: spl: Add support for booting from UFS
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Dhruva Gole <d-gole@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 16 Jan 2026 17:14:21 +0100
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

On Fri, Jan 16, 2026 at 6:50=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 1/16/26 3:29 PM, Alexey Charkov wrote:
> > On Fri, Jan 16, 2026 at 2:50=E2=80=AFPM Quentin Schulz <quentin.schulz@=
cherry.de> wrote:
> >>
> >> Hi Alexey,
> >>
> >> On 1/16/26 11:08 AM, Alexey Charkov wrote:
> >>> Hi Quentin,
> >>>
> >>> On Wed, Jan 14, 2026 at 10:05=E2=80=AFPM Quentin Schulz
> >>> <quentin.schulz@cherry.de> wrote:
> >>>>
> >>>> Hi Alexey,
> >>>>
> >>>> On 1/8/26 6:50 PM, Alexey Charkov wrote:
> [...]
> >>>>> +&gpio4 {
> >>>>> +     /* Used for resetting the UFS device during initialization */
> >>>>> +     bootph-pre-ram;
> >>>>> +     bootph-some-ram;
> >>>>> +};
> >>>>> +
> >>>>
> >>>> Is it always GPIO4 for the reset GPIO for UFS? Seems like something =
that
> >>>> should probably be put in a board -u-boot.dtsi instead?
> >>>
> >>> It is in fact always GPIO4 pin D0. It's multiplexed to a
> >>
> >> This is probably the typical Rockchip BS :) It is the "same" for SD CD
> >> or WP pins. They have a hardware-controlled mode for pin A which is
> >> usually a black box for SW (nothing to do, it "works"). But nothing
> >> prevents you from using another GPIO for that (just have to be careful
> >> about the voltage level I guess, here it seems to be 1.2V for the
> >> domain, which isn't that usual I guess.
> >
> > I bet that the boot ROM might get picky there, and only work with
> > GPIO4_D0. But if the UFS chip is not meant to be used as the primary
> > boot device - sure, can't see why not. On the other hand, there's not
> > much direct gain for board designers from using a different pin, and
> > people tend to just stick with Rockchip reference schematics unless
> > something different is explicitly required for their design, so my
> > money is on "it will be GPIO4 for all RK3576 boards".
> >
> > Extra consideration in the same stream: the pin itself is defined in
> > rk3576.dtsi upstream, not in board-specific .dts files.
> >
>
> OK, I see that rk3576.dtsi specifies the reset-gpios here. I guess it
> should be seen as a default value, like we have for pinmuxes. Also, this
> is lacking a pinmux for the GPIO, so there's no guarantee the pin will
> be muxed into the GPIO function before you control it.

Indeed. This must have been overlooked upon addition, given that GPIO
function is supposed to be the power-on default for this pin. So in
the end it's either reconfigured by the boot ROM to the
hardware-controlled reset mode (then it leaves the UFS controller in a
magically working state), or it's left at the power-on default GPIO
state - end result is a working UFS controller in both cases, but
possibly with traces of dark magic.

Sounds like a patch to the upstream .dtsi is warranted - will do that.

> >>> controlled mode would also deviate from the upstream DT binding, as i=
t
> >>> stipulates a GPIO for device resets [3].
> >>>
> >>
> >> Not asking for this, rather wondering if we should really have this at
> >> the SoC level rather than the board level. If it can be any GPIO why
> >> forcing all boards to have GPIO4 bank "enabled" in SPL + U-Boot proper
> >> before reloc. It isn't the first SoC to have that (also see all SoC
> >> u-boot.dtsi having the UART controller from the reference design
> >> "enabled"), and I don't think it's planned for us to have a product on
> >> it, so... not a blocker from my side :)
> >
> > I believe that the boards which don't use UFS for early boot will just
> > compile it out, together with the respective GPIO code. Then the only
> > downside for them is a marginally larger SPL DTB - but not on a scale
> > that matters for RK3576. And those that use UFS for early boot will
> > likely want it to be on the pin expected by the boot ROM, then having
> > the prerequisites already defined makes life easier for them (and it's
> > not much different from having e.g. FSPI0/1 and eMMC enabled by
> > default even for boards that don't use them).
> >
>
> My hunch is the BootROM may not even attempt to reset the UFS chip and
> rely on it having lost power (see different ways for the PMIC to reset
> its regulators when it's itself reset in SW). But I have nothing to
> prove this :)

I took my JTAG out. Boot ROM at its code address 0x6448 writes
0xff0011 to 0x2604b398, where:
 - 0x2604b398 is VCCIO7_IOC_GPIOD4_IOMUX_SEL_L
 - 0xff << 16 is the write mask
 - 0x10 is GPIO4_D1 mux (=3DUFS_REFCLK, not GPIO mode)
 - 0x01 is GPIO4_D0 mux (=3DUFS_RSTn, not GPIO mode)

Further down the line at its code address 0x6480 it writes 0x100010 to
0x2604b400, where:
 - 0x2604b400 is VCCIO7_IOC_XIN_UFS_CON
 - 0x10 << 16 is the write mask
 - 0x10 is ufs_rstn_out a.k.a. UFS reset IO configuration (presumably
enabling the hardware-controlled device reset mode)

This only applies to when UFS is identified as the boot storage -
otherwise the registers stay at their power-on reset defaults (i.e.
zeros for these fields)

> >>> [1] https://github.com/torvalds/linux/blob/master/drivers/ufs/host/uf=
s-rockchip.c#L220-L231
> >>> [2] https://github.com/rockchip-linux/u-boot/blob/next-dev/drivers/uf=
s/ufs-rockchip.c#L222
> >>> [3] https://github.com/torvalds/linux/blob/master/Documentation/devic=
etree/bindings/ufs/rockchip%2Crk3576-ufshc.yaml#L53-L58
> >>>
> >>>>>     &ioc_grf {
> >>>>>         bootph-all;
> >>>>>     };
> >>>>> @@ -176,6 +182,11 @@
> >>>>>         bootph-pre-ram;
> >>>>>     };
> >>>>>
> >>>>> +&ufshc {
> >>>>> +     bootph-pre-ram;
> >>>>> +     bootph-some-ram;
> >>>>> +};
> >>>>> +
> >>>>>     &xin24m {
> >>>>>         bootph-all;
> >>>>>     };
> >>>>> diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/ar=
m/include/asm/arch-rockchip/bootrom.h
> >>>>> index b15938c021d6..f9ecb6858f04 100644
> >>>>> --- a/arch/arm/include/asm/arch-rockchip/bootrom.h
> >>>>> +++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
> >>>>> @@ -51,6 +51,7 @@ enum {
> >>>>>         BROM_BOOTSOURCE_SPINOR =3D 3,
> >>>>>         BROM_BOOTSOURCE_SPINAND =3D 4,
> >>>>>         BROM_BOOTSOURCE_SD =3D 5,
> >>>>> +     BROM_BOOTSOURCE_UFS =3D 7,
> >>>>
> >>>> Hopefully this will be the same value for all upcoming SoCs with UFS
> >>>> (and not used for something else :) ).
> >>>
> >>> Well it's hard to guarantee (otherwise Jonas wouldn't have had to add
> >>> a translation function [4] for the IDs that changed in RK3576). Maybe
> >>> at some point we'll have to switch to a lookup table per each SoC
> >>> variant if these keep changing, but thankfully that point is not toda=
y
> >>> :)
> >>>
> >>
> >> See
> >> https://lore.kernel.org/devicetree-spec/ebc08400-c16d-4ed0-b487-9aabe1=
3bbf0f@pengutronix.de/
> >
> > Ooooh that sounds like a discussion that can potentially stretch out
> > for a long time. I'd much rather use a value that works for the only
>
> Anything to be added to the dt spec is taking months if not year, even
> when agreed upon.
>
> > chip where it matters now (RK3576), then solve the problem whenever it
> > arises (if it does). After all, bootrom.h is not ABI, and DT is, so it
> > is much easier to fix up bootrom.h without stepping on too many toes.
> >
>
> I'm saying this will solve the problem, not that we have to rely on it
> now :)
>
> > Furthermore, I'm not even sure that /chosen/bootsource can address the
>
> It's not /chosen/bootsource, this has merged already in the spec and
> won't be usable for this mapping (lots to read but it's explained
> somewhere in the thread).
>
> > issue here, because boot ROM's won't magically start passing DT
> > phandles to the bootloader, so there will still be an ID->node lookup
> > table somewhere in early code (with potentially per-SoC overrides).
>
> No, that's the point of the thread I linked. The idea is to provide in
> DTS the mapping between the value in the register set by the BootROM to
> a controller/flash node somehow (via phandle or something else) so that
> we don't have to have this table in code at all. After all, this is
> hardware description (albeit based on BootROM "API" but that cannot
> change anyway, it's silicon (if it does, good luck all may the odds be
> in your favor)) so there's no reason for all bootloaders to have to
> reinvent their own sauce (see barebox doing something different than
> U-Boot there).
>
> I read the BootROM register value, I read the DT property with the
> mapping, then I know which device it is. Bonus point, you don't need to
> keep the DT node path in sync in your table, because the mapping is in
> the same DT as what it refers to.
>
> This is not for now (and I should probably revive the topic), just
> wanted to tell you there's another way to do that and we should probably
> aim at doing that in the mid/long term (and then all this in-code
> mapping won't need to maintained anymore, and there won't be conflicts
> between SoCs having the same value for different meanings, or differnet
> values for the same meaning).

Oh, I got it now. Yes, that sounds like a beautiful longer-term
solution, separating data from code cleanly and avoiding if-then-else
trees.

Best regards,
Alexey
