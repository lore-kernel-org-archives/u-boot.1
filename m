Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8DFEB1070
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD01C83FED;
	Tue, 10 Mar 2026 16:31:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jcvn9rda";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25DE383FE9; Tue, 10 Mar 2026 15:21:06 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DC2983F53
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 15:21:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-89a00e8dc04so90333606d6.0
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 07:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773152460; cv=none;
 d=google.com; s=arc-20240605;
 b=XaImtv7qEXhzQw8ERwEt7cGnsreSVPsI1wMqkRnKzKQF1HjlaHKINl3RvInylbRGZx
 LwiFy9P/jbyZiHlWXrhSCkgQU/NkTIDkvbKEkLCpsM4lA2ysJOsOWQqGvsRze3cObqWB
 vdeahas5sCIC9zk+tu4PoZbzzcmKzo+SeUJyKwLam4O7eSG/xuvytBSViYYYDgXMc1te
 LjDopVGwAfKu39tTA+mCj/yu1zf857k6o1TxPfYwHjVRGIy3ewbqjLsqQgUjLrbxHkaU
 dVKp8qKCRsvSx+k62yzSh34iA/aDkaoBCyOyX7/MrG/tAkBdESiR5f+9rMjEgOd7RIx4
 zkqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Cx7QwcZHaMpUUbmCcvrDUSSQSZ4iJrO07FpCq95+LEk=;
 fh=mSmNMztr/GSWdBlG+v/te0stRsD/if1NVNY3WS9jYac=;
 b=cYW0tf5ahZq+i4cBnLAR/WhAMHxpMde2LnA8O964JTYArAgmVWkvDAykvI3iotV67Q
 a/5z9HQYrBbWnvsFlUNfKUTRn6mPaCYNeDsBhpMFjyjs7QQh/S+ThEeB9kfA3XBm0b+t
 KUJWhTKrmR3ecorMSOC1V4hssTanFPRC6TW3WFl75AgQjJd2S7XXKVSgKp3PBM/gpIKE
 7ki0puqtY4rU4hdNycFAJ/XJgenQKxFUVWIExTggSmah7BAZbA3ssD7H37NXs3R+kLOS
 9HbCXqWOYZX+sY7wwQFkiFfCHobNN0IZXM+rsYmRRv2C7pdaBNb+I3iBDQ/mzsCGg49w
 AE9Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773152460; x=1773757260; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cx7QwcZHaMpUUbmCcvrDUSSQSZ4iJrO07FpCq95+LEk=;
 b=Jcvn9rda80Me94wPs6aV1yp6XTbCEAqtmdgXpj1zvE1fm8sYps/2oRwH0ddwtfLJNw
 9bHdfpz5kwUBvHTBuf96jQPnIbZJIdIvABECv8NLyFOaZo8Ixvs/5SvPjQrlcPoQ4Hwg
 4brbuH4kwXmmWRHRo/3yUAD9SsZBrS4WNhN9qCifHrobrcHW/wdrfZrlNQJMFGJ/9gwp
 1SQ/X82MoGezPMIdQjSHUsw2JErQmly9VxC/zv3DmSUViwJh4JXwK9/CsfNSvERzI2rX
 I/Dm3anzSbvFZOz3ATEroLHMjoVJhysSz/xxs/YAu0Oibk4Hg3p2WEBLjfoKDcOQ1pce
 WrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773152460; x=1773757260;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cx7QwcZHaMpUUbmCcvrDUSSQSZ4iJrO07FpCq95+LEk=;
 b=huXakO3f84tJTLJ++WaTNQtcIiV4mg8aAp8Rtw10D8Ud0p0wZwt+UkSCeavDUlrdaT
 oTA2cuWTvZmT6pNXhRkR0lJ6jw0bvYuwbVJlDpWXpy7edfA2M0QlE6ldeiLMaFEus8cm
 GKvaAyFxxsDTITFrbCimQfPawfBSFIhElIlbsT9oL+w4Gx7BgMwLGw68xZEENBPNyIxX
 hUU+w17VKxtdKaPrKmQwziDKJCWc/+9g9kTEuTTv6j28St5yaNl6duQBhh7Hk/FWLajg
 KuF+i6mK8OxAunZo/9ek3WyoYMIy/rmaNodROS2PE1QacnPDRF/zNiUlFzBYzPuQijo7
 lnOA==
X-Gm-Message-State: AOJu0YyQESp7jkLX05AbazLVVSgUwyxjop4oxf1o8fO7qiqgLv9MoKza
 xHbqrLCQxWgrEwPAMC3VMIKE/xIKfJeppSbWZdh1hEVuQMA2BcIeQR0rSBbHTTyy1ms0rFJXVXV
 ESKpEEg/b4f0Khn89q92LCNWL0k6XNn0=
X-Gm-Gg: ATEYQzyYErHijHx703tJT90+4LbJx9nexN1oVAaRFxLkJhf3uD6Dw/iva2XCNZubwVW
 elJgqWmq1KroEsBHw3S0WnAs3eZRNb8HA+DOcv7bYZxncU7w/b4uH52misGEF6ALwdIU8f+EF9s
 Wxxl4+6WA+0TUnpMerkESNXHr7iaAwOyxKC4OG90lPVz7t97IXcYJ2MOdj26uOGgRWbG6tBBHv1
 mxCAOp5aoSU7Z91L3l0fSjS9axoWq4VGZY1Jh9XJ3zLrBy7J/WSzCmQeOqGinhEc3I+fopAnkPD
 m/lcnT4=
X-Received: by 2002:a05:622a:1998:b0:509:1dc8:e9e7 with SMTP id
 d75a77b69052e-5091dc8f00amr71262521cf.51.1773152459975; Tue, 10 Mar 2026
 07:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260120-rk3576-ufs-v5-0-0edb61b301b7@gmail.com>
 <CABjd4Yz6J_uQG5WknghbhEWcxzL1G4BirLG37QMT1-OTdjzWRg@mail.gmail.com>
 <a7a6e9e9-065b-460c-91d9-316ddfc4eb79@linaro.org>
In-Reply-To: <a7a6e9e9-065b-460c-91d9-316ddfc4eb79@linaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 10 Mar 2026 18:20:48 +0400
X-Gm-Features: AaiRm50IDtOlmXf78w84bD7xX8JxnG7_0biBa1n2dLey0dyYzUSH6stmrQhrnlI
Message-ID: <CABjd4Yzth2zJ_xk8cPidNCnNc81=wAWq7EN=U=R6xxXQuLXP0A@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Enable full UFS boot on Rockchip RK3576
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Greg Malysa <malysagreg@gmail.com>,
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
X-Mailman-Approved-At: Tue, 10 Mar 2026 16:31:45 +0100
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

On Tue, Mar 10, 2026 at 5:04=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Hi,
>
> On 3/10/26 09:44, Alexey Charkov wrote:
> > On Tue, Jan 20, 2026 at 10:09=E2=80=AFPM Alexey Charkov <alchark@gmail.=
com> wrote:
> >>
> >> Rockchip RK3576 can load its bootloader from UFS among other options,
> >> so this series adds the necessary bits and pieces to enable an end-to-=
end
> >> boot from UFS (boot ROM -> SPL -> U-boot proper -> kernel).
> >>
> >> To achieve the above, this series goes through the following:
> >>   - Patch 1 introduces arch-independent code to enable SPL images to u=
se
> >>     UFS devices, including build system tweaks and a function to locat=
e
> >>     a U-boot image at a fixed UFS offset and LUN (SCSI device number)
> >>   - Patch 2 adds an option to build the Rockchip reset driver for SPL
> >>   - Patch 3 adds device-reset functionality to the Rockchip UFS glue c=
ode,
> >>     which is required for (at least some) UFS modules to respond to
> >>     controller commands upon initial enumeration
> >>   - Patch 4 ties it all together for Rockchip RK3576
> >>
> >> This has been tested on a FriendlyElec NanoPi M5 board with a Biwin
> >> BWU3AKC46C256G UFS module. Note that booting directly from UFS masks t=
he
> >> issue which patch 3 aims to address, because the boot ROM initializes =
the
> >> UFS module before handing over to U-boot. If, however, one boots SPL f=
rom
> >> FSPI1 with the same driver code, the module fails to respond unless pa=
tch
> >> 3 is applied.
> >>
> >> This depends on Jonas' recent series [3] enabling DMA writes to PMU SR=
AM,
> >> without which the UFS controller will fail to load ATF and end up in a=
n
> >> unrecoverable error state requiring a hard reset.
> >>
> >> Note that in my experience none of the RK3576 boards actually boot cur=
rent
> >> mainline U-boot versions without a single-word SRAM write before jumpi=
ng
> >> to DDR initialization, as done in Kwiboo's commit at [1]. Therefore, t=
o
> >> test this series I additionally applied commits 6b152999908b..d43031c4=
045e
> >> from Kwiboo's rk3576 branch [2] (including 6b152999908b), so any teste=
rs
> >> might want to:
> >>
> >> git cherry-pick 6b152999908b^..d43031c4045e
> >>
> >> from there before or after applying this series
> >>
> >> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commit/=
d43031c4045ef8aaf29c467b910207e721dabce0
> >> [2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits=
/rk3576?ref_type=3Dheads
> >> [3] https://lore.kernel.org/all/20260108133234.4001390-1-jonas@kwiboo.=
se/
> >>
> >> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >> ---
> >> Changes in v5:
> >> - Reverse X-mas tree in spl_ufs:spl_ufs_load_image (thanks Quentin)
> >> - Explicit "depends on UFS" from CONFIG_SPL_UFS_SUPPORT (thanks Quenti=
n).
> >>    This also pulls in SCSI to avoid compilation errors.
> >> - Split out the patch enabling the Rockchip reset driver for SPL build=
s
> >>    (thanks Quentin)
> >> - Reworded the error message when requesting the UFS reset GPIO fails
> >>    (thanks Quentin)
> >> - Added a note in the commit message about reset-gpios being required =
by
> >>    the DT binding (thanks Quentin)
> >> - Dropped the redundant check of GPIO validity in the reset function
> >>    (thanks Quentin)
> >> - Added a note about GPIO4_D0 being the only GPIO usable for UFS reset
> >>    on RK3576 (thanks Shawn)
> >> - Dropped "imply" symbols from the arch Kconfig, now that both GPIO
> >>    and RESET drivers are explicitly depended on from the UFS driver
> >>    (thanks Quentinq)
> >> - Link to v4: https://lore.kernel.org/r/20260108-rk3576-ufs-v4-0-e8e67=
649f3f8@gmail.com
> >>
> >> Changes in v4:
> >> - Added a dependency in b4 metadata on Jonas' new series enabling DMA
> >>    writes to PMU SRAM (thanks Jonas)
> >> - Dropped the bounce buffer quirk altogether, as it now works as-is
> >> - Link to v3: https://lore.kernel.org/r/20260106-rk3576-ufs-v3-0-bfe25=
9fd6d17@gmail.com
> >>
> >> Changes in v3:
> >> - Added a UFSHC quirk to use the SCSI bounce buffer for addresses outs=
ide
> >>    SDRAM, and enabled it on Rockchip (thanks Neil and Tom)
> >> - Dropped the open-coded bounce buffer from spl_ufs.c, now unneeded
> >> - Link to v2: https://lore.kernel.org/r/20260105-rk3576-ufs-v2-0-caba9=
79a0d6b@gmail.com
> >>
> >> Changes in v2:
> >> - Rename the SPL UFS read helper function more self-descriptively (tha=
nks Neil)
> >> - Add an option to configure the UFS LUN used to look for the U-boot i=
mage
> >>    in raw offset mode - or rather the SCSI device number, which most o=
f the
> >>    time coincides with the UFS LUN as long as the UFS device is the on=
ly
> >>    SCSI block device the SPL sees (thanks Neil)
> >> - Add an option to use a bounce buffer in RAM while loading U-boot fro=
m UFS,
> >>    which helps avoid changes to common spl_fit.c code which in v1 achi=
eved a
> >>    similar result at a performance cost to unrelated platforms (thanks=
 Jonas)
> >> - Link to v1: https://lore.kernel.org/r/20251210-rk3576-ufs-v1-0-a3f9e=
76eb66e@gmail.com
> >>
> >> ---
> >> Alexey Charkov (4):
> >>        spl: Make UFS available for SPL builds
> >>        reset: rockchip: make device resets available in SPL
> >>        ufs: rockchip: Add device reset support
> >>        rockchip: spl: Add support for booting from UFS
> >>
> >>   MAINTAINERS                                  |  1 +
> >>   arch/arm/dts/rk3576-u-boot.dtsi              | 16 ++++++++-
> >>   arch/arm/include/asm/arch-rockchip/bootrom.h |  1 +
> >>   arch/arm/include/asm/spl.h                   |  1 +
> >>   arch/arm/mach-rockchip/rk3576/rk3576.c       |  1 +
> >>   arch/arm/mach-rockchip/spl-boot-order.c      | 14 ++++++++
> >>   common/spl/Kconfig                           | 30 +++++++++++++++++
> >>   common/spl/Makefile                          |  1 +
> >>   common/spl/spl_ufs.c                         | 49 ++++++++++++++++++=
++++++++++
> >>   drivers/Makefile                             |  1 +
> >>   drivers/reset/Kconfig                        |  9 +++++
> >>   drivers/reset/Makefile                       |  2 +-
> >>   drivers/scsi/Makefile                        |  3 ++
> >>   drivers/ufs/Kconfig                          |  4 +++
> >>   drivers/ufs/ufs-rockchip.c                   | 22 +++++++++++++
> >>   drivers/ufs/ufs-rockchip.h                   |  1 +
> >>   lib/Makefile                                 |  1 +
> >>   17 files changed, 155 insertions(+), 2 deletions(-)
> >> ---
> >> base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
> >> change-id: 20251210-rk3576-ufs-ac3bf4e87156
> >> prerequisite-message-id: 20260108133234.4001390-1-jonas@kwiboo.se
> >> prerequisite-patch-id: 3748e3880ac841dc25628911608140ebb4d4382f
> >> prerequisite-patch-id: 671586e63ec9021b624d6cdc3b75aef53ed84972
> >
> > Hi Neil, Kever,
> >
> > Now that Kever has applied the patch from Jonas [1] which lets this
> > one work without bounce buffers on Rockchip RK3576, would you mind
> > giving this series another look?
>
> Applied patches 1 & 3 and passing it to CI, but seems without #2 UFS will=
 probably
> probe error so who is supposed to pick #2 ?

#2 and #4 are both Rockchip specific, so maybe Kever could take them?

#3 should still work in U-boot proper without #2, and to get UFS in
SPL all four patches are required, so the ordering of #2 vs #3
shouldn't matter much.

Thanks a lot,
Alexey
