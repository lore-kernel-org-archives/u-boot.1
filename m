Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45112C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 17:53:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 755AB80FF7;
	Tue, 22 Apr 2025 19:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B5W999EY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 604E3810F4; Tue, 22 Apr 2025 19:53:03 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B8A380FEC
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 19:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72ecc30903cso3107087a34.0
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745344376; x=1745949176; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HbqrgL+kyEpoak1lTEI4nlzocyE2QDYN/ZInn9aIxIQ=;
 b=B5W999EYAWoz2Nvvnn9/hffs5lUmjTtZugzt0p3gQKVBi3Cep6s8ZK9kH2E5EaD2gN
 PpGqO8VHMaW8kW2S8jTMlErizZeLy78SAyCMGZXksIwH+gIdIjyhFeoi06wrWIShK1qv
 DDxAzRISTuRci4YYeeBehi5t1fcSf6Vs3lzSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745344376; x=1745949176;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HbqrgL+kyEpoak1lTEI4nlzocyE2QDYN/ZInn9aIxIQ=;
 b=rICPdcMbpvwUPyTW7CRNZ3ykMFpQYXef9TZq6A0WtNWdIHKQ8iMqQWHUQneuDfSTCN
 j+KzMm5EMyOkV7sDCCQ01qrgJu/vadTjBEn1xA9Z7yMG482PxuL+FrRWCAimtKMq/Utm
 v22aKvHxzrEKUZUX4Y+9nlUpyHhfuXSMDauFdmW6UZurPENOKa8DHkMMVQWlcCl2o1Pb
 leLF2Cr3Ku/PMdPz8EqznRN0ojYykHNGVKCFYJx0a7AB5nOL27o4xSsfztC8YSbfRha+
 KpqRtW0w+OQr9dKvcoa8MJhbzAnCi/KZQj0+0MGlRQEAjfV2/GwfdL/nEIica0jQSfHE
 ZEmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWEpjdYZet8+X5PLJdOiDIwIkx+QLlM5hT1MkTaUOFNV0CUs9mn+7t7SEikvnkrdcj6P6jbvE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3ha5Em0shWTU2R4kTHJ+4Qsxd4w2BQyxAqjquRSy/PBsxA0MD
 dizxRfjtflP5hhYJR3MKOLUcSONG98drmhXhoOf7FWvLD+/oBPI95+lNu+oXQ28xKzm84MrOEjc
 +
X-Gm-Gg: ASbGncvvDtIQi8pBkE+o/4wcr8/vZy067EzLZ5SjOVJp7DG9iA/petgOlJm63QESauJ
 TRNBC5uz7BLvMCZ9uAPEGBabIff42wDjakvq6mvbkAxg/Eymwz8ynovt2nt5rwRa87nvuhbFZUE
 sQXmhtMWNsJgQBeUaoMx0xgSRleZbdS85JRy+diak2ySPteyo+FOPT9Y/VRfpOc4eap1pRx9Euk
 jld8dlI4g2wiEKFesOefvxJ3bFginWFQr7rYsvP+HExCe8RmrimYhkx/s6IBcHZk+6gly68OCgH
 vihidydA3Pi5wZa56fp2NRA1hETem20hLvX9K7YytQgaGDdNMUNnyqFon7gaFejynQpqoMY8TjU
 Kdw==
X-Google-Smtp-Source: AGHT+IG8UKZbmMv8OdrvPsrs0WaE9gtWMgge3oa4duroV+uBjIr0lzmXj/m6jru13fWGDzQxE6geGg==
X-Received: by 2002:a05:6830:7182:b0:72b:80b8:8c67 with SMTP id
 46e09a7af769-73006333e6fmr9819328a34.28.1745344375889; 
 Tue, 22 Apr 2025 10:52:55 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-730047caf24sm2073502a34.38.2025.04.22.10.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 10:52:55 -0700 (PDT)
Date: Tue, 22 Apr 2025 11:52:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-20250422
Message-ID: <20250422175253.GA5495@bill-the-cat>
References: <20250422162945.26797-1-kever.yang@rock-chips.com>
 <35fcf81a-34d3-41b1-8e73-3243654b4e17@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9Dwf2Y+e53siDrrk"
Content-Disposition: inline
In-Reply-To: <35fcf81a-34d3-41b1-8e73-3243654b4e17@kwiboo.se>
X-Clacks-Overhead: GNU Terry Pratchett
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


--9Dwf2Y+e53siDrrk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 07:34:04PM +0200, Jonas Karlman wrote:
> Hi Kever,
>=20
> This is missing "[v2,25/30] rng: rockchip: Add support for rkrng variant"
> from the RK3528 series, should apply after you picked up the rng patches.
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20250407224743.2423921-2=
6-jonas@kwiboo.se/
>=20
> Also please drop "rockchip: avoid rebuilding most binaries for
> u-boot-rockchip-spi.bin" and pick up "[v6,0/7] rockchip: binman: Use a
> template for FIT and other improvements" in its place.
> Or should I rebase this series and include an indirect revert (all
> changes in that patch is replaced with use of a fit template).
>=20
> https://patchwork.ozlabs.org/project/uboot/cover/20250413195949.432730-1-=
jonas@kwiboo.se/

Unless it's really hard on Kever's side, I would prefer a new clean PR
(and follow up PR). Thanks!

>=20
> On 2025-04-22 18:29, Kever Yang wrote:
> > Hi Tom,
> >=20
> > Please pull the updates for rockchip platform:
> > - New SoC support: RK3528, RK3576
> > - New Board support: rk3528 Radxa E20C, rk3576 Firefly ROC-RK3576-PC;
> > - Add generic board for rk3288 and rk3399;
>=20
> Commits for the generic boards are also missing ;-)
>=20
> Regards,
> Jonas
>=20
> > - rng driver binding update;
> > - misc updates on board level or header files;
> >=20
> >=20
> > CI:
> > https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/25=
886
> >=20
> > Thanks,
> > - Kever
> >=20
> >=20
> > The following changes since commit 185fdf5e94731df05748b1c576effb52ff7a=
3ec5:
> >=20
> >   fs/squashfs: avoid illegal free() in sqfs_opendir() (2025-04-21 11:08=
:03 -0600)
> >=20
> > are available in the Git repository at:
> >=20
> >   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-b=
oot-rockchip-20250422
> >=20
> > for you to fetch changes up to 30ac31ab1f167f55bb1206e3ec95048b6fc88371:
> >=20
> >   rng: rockchip_rng: Update compatible for RK3588 (2025-04-22 23:31:02 =
+0800)
> >=20
> > ----------------------------------------------------------------
> > Chukun Pan (2):
> >       arm64: dts: rockchip: Add rk3528 QoS register node
> >       arm64: dts: rockchip: enable SCMI clk for RK3528 SoC
> >=20
> > Elaine Zhang (2):
> >       clk: rockchip: Add rk3576 clk support
> >       reset: rockchip: implement rk3576 lookup table
> >=20
> > Heiko Stuebner (10):
> >       rockchip: sdram: honor CFG_SYS_SDRAM_BASE when defining ram regio=
ns
> >       ram: rockchip: Add rk3576 ddr driver support
> >       rockchip: otp: Add support for RK3576
> >       mmc: rockchip_sdhci: Add support for RK3576
> >       mmc: rockchip_dw_mmc: Add support for rk3576
> >       net: dwc_eth_qos_rockchip: Add support for RK3576
> >       arm64: dts: rockchip: add rk3576 otp node
> >       dt-bindings: arm: rockchip: Add Firefly ROC-RK3576-PC binding
> >       arm64: dts: rockchip: Add devicetree for the ROC-RK3576-PC
> >       rockchip: rk3576: Add support for ROC-RK3576-PC board
> >=20
> > Jonas Karlman (42):
> >       rockchip: rk3308: Drop unused rk_board_init()
> >       rockchip: Move imply TPL_ROCKCHIP_COMMON_BOARD under SoC Kconfig =
symbol
> >       rockchip: Make ROCKCHIP_COMMON_STACK_ADDR depend on TPL
> >       rockchip: Improve ARMv7 support for ROCKCHIP_COMMON_STACK_ADDR
> >       rockchip: Move imply ROCKCHIP_COMMON_STACK_ADDR under SoC Kconfig=
 symbol
> >       rockchip: Move imply ROCKCHIP_EXTERNAL_TPL under SoC Kconfig symb=
ol
> >       rockchip: Add RK3576 support for ROCKCHIP_COMMON_STACK_ADDR
> >       rockchip: rk3588: Use hptimer reg names in rockchip_stimer_init
> >       rockchip: Remove partitions env variable for RK356x
> >       rockchip: Remove partitions env variable for RK3588
> >       rockchip: Ensure device settings is defined before rk3568_common.h
> >       rockchip: Ensure device settings is defined before rk3588_common.h
> >       rockchip: Use rk3568_common.h by default for RK356x boards
> >       rockchip: Use rk3588_common.h by default for RK3588 boards
> >       rockchip: rk3568: Drop BOARD_LATE_INIT from target config
> >       rockchip: rk3588: Drop BOARD_LATE_INIT from target config
> >       rockchip: Enable meminfo and rng commands for Generic RK3566/RK35=
68
> >       rockchip: Enable meminfo and rng commands for Generic RK3588
> >       arm64: dts: rockchip: Add pinctrl and gpio nodes for RK3528
> >       arm64: dts: rockchip: Add SARADC node for RK3528
> >       arm64: dts: rockchip: Add SDHCI controller for RK3528
> >       arm64: dts: rockchip: Add uart0 pinctrl to Radxa E20C
> >       arm64: dts: rockchip: Add leds node to Radxa E20C
> >       arm64: dts: rockchip: Add user button to Radxa E20C
> >       arm64: dts: rockchip: Add maskrom button to Radxa E20C
> >       arm64: dts: rockchip: Enable onboard eMMC on Radxa E20C
> >       ram: rockchip: Add basic support for RK3528
> >       arm: dts: rockchip: Add rk3528-u-boot.dtsi
> >       arch: arm: rockchip: Add initial support for RK3528
> >       mmc: rockchip_sdhci: Extend variant configuration
> >       mmc: rockchip_sdhci: Add initial support for RK3528
> >       mmc: rockchip_sdhci: Gate clock for glitch free phase switching
> >       rockchip: otp: Add support for RK3528
> >       adc: rockchip-saradc: Add support for RK3528
> >       phy: rockchip-inno-usb2: Add support for clkout_ctl_phy
> >       phy: rockchip-inno-usb2: Add support for RK3528
> >       net: dwc_eth_qos_rockchip: Add support for RK3528
> >       board: rockchip: Add minimal generic RK3528 board
> >       board: rockchip: Add Radxa E20C
> >       rng: rockchip_rng: Add compatible for RK3568
> >       rockchip: rk356x: Remove rng node from u-boot.dtsi
> >       rng: rockchip_rng: Update compatible for RK3588
> >=20
> > Joseph Chen (1):
> >       clk: rockchip: Add support for RK3528
> >=20
> > Nicolas Frattaroli (1):
> >       arm64: dts: rockchip: Add rng node to RK3588
> >=20
> > Quentin Schulz (7):
> >       rockchip: theobroma-systems: use HAVE_VENDOR_COMMON_LIB to simpli=
fy Makefile
> >       rockchip: px30: enable RNG for all boards
> >       rockchip: px30: add fdtoverlay_addr_r default value to support FD=
TO
> >       rockchip: ringneck-px30: enable DT overlay support
> >       rockchip: rk3399: do not generate u-boot.rom anymore
> >       rockchip: rk3288: do not generate u-boot.rom anymore
> >       rockchip: avoid rebuilding most binaries for u-boot-rockchip-spi.=
bin
> >=20
> > Steven Liu (2):
> >       pinctrl: rockchip: Add support for RK3528
> >       pinctrl: rockchip: support rk3576 pinctrl
> >=20
> > Xuhui Lin (2):
> >       rockchip: mkimage: Add rk3576 support
> >       arm: rockchip: Add RK3576 arch core support
> >=20
> > Yao Zi (3):
> >       dt-bindings: clock: Document clock and reset unit of RK3528
> >       arm64: dts: rockchip: Add clock generators for RK3528 SoC
> >       arm64: dts: rockchip: Add UART clocks for RK3528 SoC
> >=20
> > Yifeng Zhao (1):
> >       rockchip: mkimage: Add support for RK3528
>=20
> [snip]
>=20

--=20
Tom

--9Dwf2Y+e53siDrrk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgH13EACgkQFHw5/5Y0
tyxgPgwAilKoCPpTFGa2lPnJDK6YRvfJFZ6nA3xFYOij2b8cHUQi+QfzYE/VU/dX
zZO/nuii7wNIiJoqxsmxnnyKF006FGKL86GOdn4rg+65P6BKPGbRvkgqzv9jIdID
rKAp2znkuEsmPuH11mjAdXGSKfpHEsPuheXbkdaAHYfFYCQ5Dh8QSStVwZMgzCFe
86Zs5DtUW2vWQ8wwZJAtCnQHlrHS4YY3LKkLAPkxrRS/XLt40P58cNyhw8GdyjuQ
d2vdDYny9VStwl9kFmZZ5GM4ABwlW4cI3Egybfx1r/WcQYV9Re2fuboIijBDa39b
VT9Tat+AjxOKwH35O71NaCkQK5OMHjKUH254SRlESGRXduoJOU8q13SJ74x6+9IZ
OCtxMTJgbg4h0z5Bq68uhHqZunppJAR1d+K4eEFu5DrIYRP1o0stb22mpEQJPh4z
iTlO9BQPcy9hcjTpiEe7JrwBk53HoR+2KWn+bNOBeJ/b8dItiTk2q+SHoknt3r92
Vf158YZw
=3s8G
-----END PGP SIGNATURE-----

--9Dwf2Y+e53siDrrk--
