Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D753FD2D77
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9378C8400F;
	Tue, 10 Mar 2026 14:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l8pbW9oo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2185983F9A; Tue, 10 Mar 2026 09:44:54 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9066083981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 09:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-899f79df682so95620646d6.2
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 01:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773132290; cv=none;
 d=google.com; s=arc-20240605;
 b=VXxmEGqXcs4WrjxVxYrUfkogrugqYBRTl2NG9kXQ3mtHGDwswcsvj/azSKxVsgzL62
 R/+7NHo7XOGrNpHJrxKcn+R+nOPHFscVMZ93cMoXXG1CopMHWwWWJbzc3Rkk5OPn3x46
 Z40dDXgpL4bEQbnMojK96tAeLmIttovXy9CP++fiTu1MVR0xaOqarxbutHsVkQNfurFi
 njzWH8qgu8TGMcPQKMBT5xLQkpFpigW/nYnNQgfQGAgsjmmkrPjmYrEiKa9vm/vKdsmn
 ceJSjDcYPJrmph4xe6yhtJnRRM0Vqlak6jrD+mx674CS6M7U4PXwF3ftUnx7jMk2clWR
 yS4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GRGqA5Y3EmWiODnj5DtbAOP4WySYjf2mPIisSzSr9Uw=;
 fh=9LWNWqGKk+/pw5OxpZcPi9JRtMC3vRl9oHdx6ar4xKg=;
 b=P3R/PmW6pmNd51/xzvFHq8F1Gi0iQmXxK5Dk5L3teSwV5GKFK5wtKpQkVZzBh/PeKp
 PtL8Ohu3gmBN8e6Pp17i/6Rhc8kzaa7aKeNiVls6WT/zeSJO1Peep4gqnN1hy4MgOZL6
 rjOCJ7oGK74/74St/ySmzTzPyPFY/hqI0o6LoVZXl55Ze5psoiLhKvmKBe/Y/f3n40lu
 ho6IZguz0Tdeo/zABqc49+/IWWrmwMCadtWH6vMRxPFP+YPfNrjg/WzvJeA2QEaxuNQ8
 8kNGfmGg1eUzido9ddotsa3sORiJ4GuOwoQAnv81LOlbh0hffo9lI/ldJOlV3nI/5r2Y
 6wOw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773132290; x=1773737090; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRGqA5Y3EmWiODnj5DtbAOP4WySYjf2mPIisSzSr9Uw=;
 b=l8pbW9oobrlUGMeMzIbbQODJxcrxpslFOjzeF6LUOB6LlyZOCiXw1aDik17Ek3TVX2
 nkFwiJ1ZndeIdPOg/GXmgdddANUlxA+wcMKw/hvMpFOz6xg8d5eo79eJCMEN4QUiiCTD
 oD/cA+2IZKLphTx8IV8T4UtxskQ2MXlBRNv9UfFZXSMZO7RyMuDhOubRnjtPCD9zlhN3
 WJcVPz+BqheBCvzOE8G6ytzDhZT5sG//C+qfzmxJkuuf9OZanwqKmj5CXXkz6b2teKiC
 MBPbzPI2beaMUT7M7+D9SmojjnXawioAh3Vj9i/RJy3tZDHdG7tj1yiZ3m1wMQFw/nkO
 Z6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773132290; x=1773737090;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GRGqA5Y3EmWiODnj5DtbAOP4WySYjf2mPIisSzSr9Uw=;
 b=H3iR+2b33NwWZb0e/o2kcj6kqMRMVvzzi9fByGiYz0RAalEkmB2aMKdgw+KGb1v0xs
 fyCH+yk/HUimKZOVhVk5s89C6N6zmrINbPZ/hiYYpRB4nx/gFPuM3Q+DzGidh1NB5yPI
 01FezAG5QWDTCpLVqSbtaveFFs0jClpTtquwHTjjR3mgRPi72yAgA83jrkOCl1UPcqT+
 5HyQv/08jY8dO5YTgb/o/ZRj9tQm3YLPcdv1NT8uBsPnNUeXcLuUw58wDBoomz0U07a0
 2ZgP6dWT2GO8Zy27BGkgKvoeIckC3RWUFSf+Uq2Ob3o2ySctYPI4PB/DDj+lISG79NNv
 8YCQ==
X-Gm-Message-State: AOJu0YyFlfjse+RuegFX1+WFDKY40j51wYpqhd3XNl9q+KcYJmWTMwdL
 29Bu8L7lr0i3zl8KAeDCR1cbCV4Crc/NNsCGyWX7gqE8i4srXmHt3PIPiYM+ufVJSGUvEU47rvw
 0fOatIr3QqodOgY7K8zGjS4sXJkaO0uboMI9p+/M=
X-Gm-Gg: ATEYQzwh9goLwrtv341GdxrWVCHAYJiRbqIBsA6nMIUGMDuo74A8kRyI0BrvjuTPA9n
 9VeApFlRWdqcmF6jWryAp4+ISOEtbz8A059yF4KIXbe3W46Ez3OKRfIlCUmuSDOt2bgBwUVFe1K
 9+P7h5YaifMdkXDIt5nu4GMn1O6F50aoYAf4AZeOqTdBQAiRBl+/aiX1jEknH2lGoS7DyV2JP1+
 3nFE++fXvHqRhDgffz7njSoPJ1oKzkxI5GATbdRy9sACGNKvZf6MlpQAmhO1t70AtJtxra1FTtP
 kl8SOprqHSQeNoKDkA==
X-Received: by 2002:a05:6214:528e:b0:89a:2f:2ff6 with SMTP id
 6a1803df08f44-89a30c2b963mr193677776d6.65.1773132289803; Tue, 10 Mar 2026
 01:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260120-rk3576-ufs-v5-0-0edb61b301b7@gmail.com>
In-Reply-To: <20260120-rk3576-ufs-v5-0-0edb61b301b7@gmail.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 10 Mar 2026 12:44:41 +0400
X-Gm-Features: AaiRm50Su_Hkk4OzUXKpx4V2dNUUf4BZiFLycCmYmryX3Mvkn94GEjltUilUTkg
Message-ID: <CABjd4Yz6J_uQG5WknghbhEWcxzL1G4BirLG37QMT1-OTdjzWRg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Enable full UFS boot on Rockchip RK3576
To: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
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
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Andrew Davis <afd@ti.com>, 
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
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:11 +0100
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

On Tue, Jan 20, 2026 at 10:09=E2=80=AFPM Alexey Charkov <alchark@gmail.com>=
 wrote:
>
> Rockchip RK3576 can load its bootloader from UFS among other options,
> so this series adds the necessary bits and pieces to enable an end-to-end
> boot from UFS (boot ROM -> SPL -> U-boot proper -> kernel).
>
> To achieve the above, this series goes through the following:
>  - Patch 1 introduces arch-independent code to enable SPL images to use
>    UFS devices, including build system tweaks and a function to locate
>    a U-boot image at a fixed UFS offset and LUN (SCSI device number)
>  - Patch 2 adds an option to build the Rockchip reset driver for SPL
>  - Patch 3 adds device-reset functionality to the Rockchip UFS glue code,
>    which is required for (at least some) UFS modules to respond to
>    controller commands upon initial enumeration
>  - Patch 4 ties it all together for Rockchip RK3576
>
> This has been tested on a FriendlyElec NanoPi M5 board with a Biwin
> BWU3AKC46C256G UFS module. Note that booting directly from UFS masks the
> issue which patch 3 aims to address, because the boot ROM initializes the
> UFS module before handing over to U-boot. If, however, one boots SPL from
> FSPI1 with the same driver code, the module fails to respond unless patch
> 3 is applied.
>
> This depends on Jonas' recent series [3] enabling DMA writes to PMU SRAM,
> without which the UFS controller will fail to load ATF and end up in an
> unrecoverable error state requiring a hard reset.
>
> Note that in my experience none of the RK3576 boards actually boot curren=
t
> mainline U-boot versions without a single-word SRAM write before jumping
> to DDR initialization, as done in Kwiboo's commit at [1]. Therefore, to
> test this series I additionally applied commits 6b152999908b..d43031c4045=
e
> from Kwiboo's rk3576 branch [2] (including 6b152999908b), so any testers
> might want to:
>
> git cherry-pick 6b152999908b^..d43031c4045e
>
> from there before or after applying this series
>
> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commit/d43=
031c4045ef8aaf29c467b910207e721dabce0
> [2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk=
3576?ref_type=3Dheads
> [3] https://lore.kernel.org/all/20260108133234.4001390-1-jonas@kwiboo.se/
>
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
> Changes in v5:
> - Reverse X-mas tree in spl_ufs:spl_ufs_load_image (thanks Quentin)
> - Explicit "depends on UFS" from CONFIG_SPL_UFS_SUPPORT (thanks Quentin).
>   This also pulls in SCSI to avoid compilation errors.
> - Split out the patch enabling the Rockchip reset driver for SPL builds
>   (thanks Quentin)
> - Reworded the error message when requesting the UFS reset GPIO fails
>   (thanks Quentin)
> - Added a note in the commit message about reset-gpios being required by
>   the DT binding (thanks Quentin)
> - Dropped the redundant check of GPIO validity in the reset function
>   (thanks Quentin)
> - Added a note about GPIO4_D0 being the only GPIO usable for UFS reset
>   on RK3576 (thanks Shawn)
> - Dropped "imply" symbols from the arch Kconfig, now that both GPIO
>   and RESET drivers are explicitly depended on from the UFS driver
>   (thanks Quentinq)
> - Link to v4: https://lore.kernel.org/r/20260108-rk3576-ufs-v4-0-e8e67649=
f3f8@gmail.com
>
> Changes in v4:
> - Added a dependency in b4 metadata on Jonas' new series enabling DMA
>   writes to PMU SRAM (thanks Jonas)
> - Dropped the bounce buffer quirk altogether, as it now works as-is
> - Link to v3: https://lore.kernel.org/r/20260106-rk3576-ufs-v3-0-bfe259fd=
6d17@gmail.com
>
> Changes in v3:
> - Added a UFSHC quirk to use the SCSI bounce buffer for addresses outside
>   SDRAM, and enabled it on Rockchip (thanks Neil and Tom)
> - Dropped the open-coded bounce buffer from spl_ufs.c, now unneeded
> - Link to v2: https://lore.kernel.org/r/20260105-rk3576-ufs-v2-0-caba979a=
0d6b@gmail.com
>
> Changes in v2:
> - Rename the SPL UFS read helper function more self-descriptively (thanks=
 Neil)
> - Add an option to configure the UFS LUN used to look for the U-boot imag=
e
>   in raw offset mode - or rather the SCSI device number, which most of th=
e
>   time coincides with the UFS LUN as long as the UFS device is the only
>   SCSI block device the SPL sees (thanks Neil)
> - Add an option to use a bounce buffer in RAM while loading U-boot from U=
FS,
>   which helps avoid changes to common spl_fit.c code which in v1 achieved=
 a
>   similar result at a performance cost to unrelated platforms (thanks Jon=
as)
> - Link to v1: https://lore.kernel.org/r/20251210-rk3576-ufs-v1-0-a3f9e76e=
b66e@gmail.com
>
> ---
> Alexey Charkov (4):
>       spl: Make UFS available for SPL builds
>       reset: rockchip: make device resets available in SPL
>       ufs: rockchip: Add device reset support
>       rockchip: spl: Add support for booting from UFS
>
>  MAINTAINERS                                  |  1 +
>  arch/arm/dts/rk3576-u-boot.dtsi              | 16 ++++++++-
>  arch/arm/include/asm/arch-rockchip/bootrom.h |  1 +
>  arch/arm/include/asm/spl.h                   |  1 +
>  arch/arm/mach-rockchip/rk3576/rk3576.c       |  1 +
>  arch/arm/mach-rockchip/spl-boot-order.c      | 14 ++++++++
>  common/spl/Kconfig                           | 30 +++++++++++++++++
>  common/spl/Makefile                          |  1 +
>  common/spl/spl_ufs.c                         | 49 ++++++++++++++++++++++=
++++++
>  drivers/Makefile                             |  1 +
>  drivers/reset/Kconfig                        |  9 +++++
>  drivers/reset/Makefile                       |  2 +-
>  drivers/scsi/Makefile                        |  3 ++
>  drivers/ufs/Kconfig                          |  4 +++
>  drivers/ufs/ufs-rockchip.c                   | 22 +++++++++++++
>  drivers/ufs/ufs-rockchip.h                   |  1 +
>  lib/Makefile                                 |  1 +
>  17 files changed, 155 insertions(+), 2 deletions(-)
> ---
> base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
> change-id: 20251210-rk3576-ufs-ac3bf4e87156
> prerequisite-message-id: 20260108133234.4001390-1-jonas@kwiboo.se
> prerequisite-patch-id: 3748e3880ac841dc25628911608140ebb4d4382f
> prerequisite-patch-id: 671586e63ec9021b624d6cdc3b75aef53ed84972

Hi Neil, Kever,

Now that Kever has applied the patch from Jonas [1] which lets this
one work without bounce buffers on Rockchip RK3576, would you mind
giving this series another look?

Please let me know if I should rebase / resubmit / adjust in any way.
Would be great to have it merged.

Thanks a lot,
Alexey

[1] https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/commit/4015f=
aa32342fd9c494c318c21de106f98dd4674
