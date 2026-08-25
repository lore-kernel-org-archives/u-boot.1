Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6034CC61DC2
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 14:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2308A80CA2;
	Tue, 25 Aug 2026 14:28:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VWe1hghB0qeo; Tue, 25 Aug 2026 14:28:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787668122;
	bh=SeWS2iqqf2fzScZN6gI+n16vvep4aYeNEI5nzMr/ZG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GHMmPGrE3ua3W68b2YWTpnp+K07FG4gC0VAq5jG2IKc+X8i2/5AxL+Izac1pGSbVv
	 uy3omds13STLwugNVm2WQdU6fd84MfS7J2oQsCjQWbHdH/Wzw5tJlfKDDsx5k7A3kD
	 +w1KghR/wiGsSoIhbMFlbiqPaxWbjH3xL5ujzWY75MnL6hZ5251ep4eDDO70Ae85g7
	 vka1hsJ/2GZ7vzUO6id6gzl46j7VbM84fsFlXDp0bPUBi5ZxJnaR2MSTB1b5wcgvYW
	 sOcNBTwi2Mcws9l5d3/p63R+8BECLxZJnrhLK9xSdC40i5/pAqr5FU5ANP7n8DNyzB
	 GFLvMcjsV8UFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2762F80CA6;
	Tue, 25 Aug 2026 14:28:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 142E2230
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0098E60604
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:28:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ppr-EUS8a06F for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 14:28:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=sAhRcR6g
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E291760603
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:28:38 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7eb787dec99so4431631a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787668117; x=1788272917;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SeWS2iqqf2fzScZN6gI+n16vvep4aYeNEI5nzMr/ZG4=;
 b=sAhRcR6gLr7H4AkS8vxJkHdYFMXmqD/H3Cugzg9G9r1hkx3a8IGhlwgchiFOICMwIF
 c4nn3C6q2PPmQ+SyBm111s+GsmPqZvEi9NnbiR02wShZDoOk+siMD6BGANANdlixZ8lq
 Tt3u/lAubKQmivhUZO3JJmGt/40osCxZMLJ0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787668117; x=1788272917;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SeWS2iqqf2fzScZN6gI+n16vvep4aYeNEI5nzMr/ZG4=;
 b=ena5W07VEThUhnjSQXVodsta8Op3yQDdQCYUPUP2+HfvWd1QcpiNsezR/mQcod+nZu
 YCusEsQn+EqGu1u0I2yl+Nc+wugA4KvkLrgbkR9PjGlaNwEhuhrSD2i+FAEt/zoi9E5V
 dIVMqWyaCrP+OXRMR5ckzxlCgXs+pAAc5MD7di8uGXbzaiK9h1n+msNUAAkXx9gGxUnp
 UeE/9Vx3/BYyfp2P0QlOOJMtwr6FF1A2TRZvcmcoYSFhfsD9cmwOhGtutNDfwf4lnGSD
 7IFtR7EILJ7Nb1ynrQ3w+Y5JPRVuZ/qh/tHfQP1p1gF3FGnIC+153Yf0NZ6VY0bXPmQd
 gAOw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoPEBroKHgoLj9lUSZnhalh1Qp3cnDdCjoMs9b+X2wYEHbl/SZXCa9QhKUkzDITvinZZk1ppvk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l/SZG/0E2jG+RW2dkIspjP3/lWjqfcl0K1D15VgbGj2l8eUcuQ
 lsXAAqAZYAlpOXboEC6/cbs7ZP8eGLbNA2SvPPybA9LJokiteC6AyIdZafnpx1+5g9zYZRe4dM6
 6d1lITbohha1R
X-Gm-Gg: AR+sD108fcGuvGujJSieFI5oJGL86oFQ5rIzQpJx6R+lRJopkGoxz6WFFoKFDESoyz1
 KifQtFIulvnj6kWj3YLjCb4z3Vp7aFTGS3j6bpGoj6rEj1u/4IWAPm08SqaRLJGhBHTdNRnXCuo
 R2MzRP8F1x4J/hg6ubhDtu5OVcfy1cJXiR9pJIyCk0vBdvBPu1oEoc7w4CB+0wr51TbfWe4vdpY
 HmKGwemsqku01+8Ymm4Hm9mI81LKNUF4htpq0glAfNtG2i48+ferx8nzPTRp3WKFwUzs1iqxVRz
 keoHQMUyuzp9dFJ8AK6MN3Ot7CqmljDKNOgHBH/z9EHQhZYkE/EuyhajJYoFzhcW3ew9C2uUT9Z
 zJBGU9jG0fvDukS+t+i253g0KWmaZoElQ/yMvQszl8DB2oO8BHAxar2fk0kI3L2G5/pp2D+wvif
 IP/Y+NrYP1eC2pFT/i/TKUu13XMAcsMylYFYZIekPWbofLZ1t+gEIDOXpmfRq20bWIoA9ATeWG9
 fy7Dyeg/tgCGMaJJ5OkvjeLlc0USLoPCXUoKuZb7zwAyn8OSw8YPCbCdQx6T7+7L4cQ08z7BABS
 jN06H4Fl8Q==
X-Received: by 2002:a05:6820:4cc5:b0:6b1:4061:4193 with SMTP id
 006d021491bc7-6b18f266a98mr6681416eaf.0.1787668117150; 
 Tue, 25 Aug 2026 07:28:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46383539b74sm7239177fac.14.2026.08.25.07.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:28:36 -0700 (PDT)
Date: Tue, 25 Aug 2026 08:28:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
Message-ID: <20260825142736.GV523975@bill-the-cat>
References: <cover.1787555916.git.michal.simek@amd.com>
 <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
 <20260825134812.nlq25ymj5gsnmdvb@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6mi0u4nxJP8QaRt/"
Content-Disposition: inline
In-Reply-To: <20260825134812.nlq25ymj5gsnmdvb@bryanbrattlof.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--6mi0u4nxJP8QaRt/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 08:48:12AM -0500, Bryan Brattlof wrote:
> On August 24, 2026 thus sayeth Michal Simek:
> > A number of file (F:) entries across the MAINTAINERS files pointed to
> > files or directories which had been renamed or removed over time. Drop
> > these stale references so that every F: entry resolves to an existing
> > path.
> >=20
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > ---
> >=20
> >  arch/arm/mach-rockchip/rk3576/MAINTAINERS         |  1 -
> >  board/CZ.NIC/turris_omnia/MAINTAINERS             |  1 -
> >  board/LaCie/net2big_v2/MAINTAINERS                |  4 ----
> >  board/LaCie/netspace_v2/MAINTAINERS               |  6 ------
> >  board/Marvell/octeontx/MAINTAINERS                |  2 --
> >  board/Marvell/octeontx2/MAINTAINERS               |  2 --
> >  board/Synology/ds116/MAINTAINERS                  |  1 -
> >  board/acer/picasso/MAINTAINERS                    |  1 -
> >  board/advantech/imx8mp_rsb3720a1/MAINTAINERS      |  1 -
> >  board/advantech/imx8qm_dmsse20_a1/MAINTAINERS     |  1 -
> >  board/alliedtelesis/SBx81LIFKW/MAINTAINERS        |  1 -
> >  board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS      |  1 -
> >  board/altera/stratix10-socdk/MAINTAINERS          |  1 -
> >  board/amlogic/p212/MAINTAINERS                    |  1 -
> >  board/amlogic/q200/MAINTAINERS                    |  1 -
> >  board/amlogic/s400/MAINTAINERS                    |  1 -
> >  board/andestech/voyager/MAINTAINERS               |  1 -
> >  board/asus/grouper/MAINTAINERS                    |  1 -
> >  board/asus/transformer-t114/MAINTAINERS           |  1 -
> >  board/asus/transformer-t20/MAINTAINERS            |  1 -
> >  board/asus/transformer-t30/MAINTAINERS            |  1 -
> >  board/atmel/at91sam9260ek/MAINTAINERS             |  1 -
> >  board/atmel/sama5d29_curiosity/MAINTAINERS        |  1 -
> >  board/atmel/sama7d65_curiosity/MAINTAINERS        |  1 -
> >  board/atmel/sama7g54_curiosity/MAINTAINERS        |  1 -
> >  board/atmel/sama7g5ek/MAINTAINERS                 |  1 -
> >  board/avionic-design/medcom-wide/MAINTAINERS      |  1 -
> >  board/avionic-design/plutux/MAINTAINERS           |  1 -
> >  board/avionic-design/tec-ng/MAINTAINERS           |  1 -
> >  board/avionic-design/tec/MAINTAINERS              |  1 -
> >  board/beacon/beacon-rzg2m/MAINTAINERS             |  3 ---
> >  board/bosch/acc/MAINTAINERS                       |  1 -
> >  board/cei/cei-tk1-som/MAINTAINERS                 |  1 -
> >  board/compal/paz00/MAINTAINERS                    |  1 -
> >  board/compulab/trimslice/MAINTAINERS              |  1 -
> >  board/comtrend/vr3032u/MAINTAINERS                |  1 -
> >  board/comtrend/wap5813n/MAINTAINERS               |  1 -
> >  board/coolpi/genbook_cm5_rk3588/MAINTAINERS       |  1 -
> >  board/davinci/da8xxevm/MAINTAINERS                |  1 -
> >  board/embest/mx6boards/MAINTAINERS                |  1 -
> >  board/engicam/imx6ul/MAINTAINERS                  |  3 ---
> >  board/friendlyarm/nanopi2/MAINTAINERS             |  1 -
> >  board/gardena/smart-gateway-at91sam/MAINTAINERS   |  1 -
> >  board/gardena/smart-gateway-mt7688/MAINTAINERS    |  1 -
> >  board/gateworks/gw_ventana/MAINTAINERS            |  6 ------
> >  board/ge/bx50v3/MAINTAINERS                       |  3 ---
> >  board/htc/endeavoru/MAINTAINERS                   |  1 -
> >  board/imgtec/xilfpga/MAINTAINERS                  |  1 -
> >  board/intel/agilex-socdk/MAINTAINERS              |  1 -
> >  board/intel/agilex7m-socdk/MAINTAINERS            |  2 --
> >  board/intel/n5x-socdk/MAINTAINERS                 |  1 -
> >  board/keymile/km83xx/MAINTAINERS                  |  2 --
> >  board/khadas/khadas-edge2-rk3588s/MAINTAINERS     |  1 -
> >  board/kontron/sl-mx6ul/MAINTAINERS                |  2 --
> >  board/lenovo/ideapad-yoga-11/MAINTAINERS          |  1 -
> >  board/lg/x3-t30/MAINTAINERS                       |  1 -
> >  board/libre-computer/aml-a311d-cc/MAINTAINERS     |  1 -
> >  board/libre-computer/aml-s805x-ac/MAINTAINERS     |  1 -
> >  board/libre-computer/aml-s905d3-cc/MAINTAINERS    |  1 -
> >  board/mediatek/mt7981/MAINTAINERS                 |  2 --
> >  board/mediatek/mt7986/MAINTAINERS                 |  4 ----
> >  board/microsoft/surface-rt/MAINTAINERS            |  1 -
> >  board/myir/mys_6ulx/MAINTAINERS                   |  1 -
> >  board/nvidia/beaver/MAINTAINERS                   |  1 -
> >  board/nvidia/cardhu/MAINTAINERS                   |  1 -
> >  board/nvidia/dalmore/MAINTAINERS                  |  1 -
> >  board/nvidia/harmony/MAINTAINERS                  |  1 -
> >  board/nvidia/jetson-tk1/MAINTAINERS               |  1 -
> >  board/nvidia/nyan-big/MAINTAINERS                 |  1 -
> >  board/nvidia/p2371-0000/MAINTAINERS               |  1 -
> >  board/nvidia/p2371-2180/MAINTAINERS               |  1 -
> >  board/nvidia/p2571/MAINTAINERS                    |  1 -
> >  board/nvidia/p2771-0000/MAINTAINERS               |  1 -
> >  board/nvidia/p3450-0000/MAINTAINERS               |  1 -
> >  board/nvidia/seaboard/MAINTAINERS                 |  1 -
> >  board/nvidia/tegratab/MAINTAINERS                 |  1 -
> >  board/nvidia/venice2/MAINTAINERS                  |  1 -
> >  board/nvidia/ventana/MAINTAINERS                  |  1 -
> >  board/nxp/imx93_evk/MAINTAINERS                   |  1 -
> >  board/nxp/ls1012afrdm/MAINTAINERS                 |  4 ----
> >  board/nxp/ls1012aqds/MAINTAINERS                  |  1 -
> >  board/nxp/ls1012ardb/MAINTAINERS                  |  3 ---
> >  board/nxp/ls1043aqds/MAINTAINERS                  |  7 -------
> >  board/nxp/ls1043ardb/MAINTAINERS                  |  6 ------
> >  board/nxp/ls1046aqds/MAINTAINERS                  |  7 -------
> >  board/nxp/ls1046ardb/MAINTAINERS                  |  7 -------
> >  board/nxp/ls1088a/MAINTAINERS                     |  9 ---------
> >  board/nxp/ls2080aqds/MAINTAINERS                  |  4 ----
> >  board/nxp/ls2080ardb/MAINTAINERS                  |  6 ------
> >  board/nxp/lx2160a/MAINTAINERS                     |  2 --
> >  board/nxp/mpc837xerdb/MAINTAINERS                 |  1 -
> >  board/nxp/mx6slevk/MAINTAINERS                    |  2 --
> >  board/nxp/p2041rdb/MAINTAINERS                    |  3 ---
> >  board/nxp/t104xrdb/MAINTAINERS                    | 13 -------------
> >  board/nxp/t208xqds/MAINTAINERS                    |  5 -----
> >  board/nxp/t208xrdb/MAINTAINERS                    |  1 -
> >  board/ouya/ouya/MAINTAINERS                       |  1 -
> >  board/phytec/phycore_am62ax/MAINTAINERS           |  1 -
> >  board/phytec/phycore_am68x/MAINTAINERS            |  1 -
> >  board/phytec/phycore_imx8mm/MAINTAINERS           |  1 -
> >  board/polyhex/imx8mp_debix_model_a/MAINTAINERS    |  1 -
> >  board/qualcomm/dragonboard410c/MAINTAINERS        |  1 -
> >  board/qualcomm/dragonboard820c/MAINTAINERS        |  1 -
> >  board/qualcomm/dragonboard845c/MAINTAINERS        |  2 --
> >  board/qualcomm/qcs404-evb/MAINTAINERS             |  2 --
> >  board/renesas/blanche/MAINTAINERS                 |  1 -
> >  board/renesas/eagle/MAINTAINERS                   |  1 -
> >  board/renesas/grpeach/MAINTAINERS                 |  1 -
> >  board/renesas/v3msk/MAINTAINERS                   |  1 -
> >  board/samsung/starqltechn/MAINTAINERS             |  2 --
> >  board/seeed/linkit-smart-7688/MAINTAINERS         |  1 -
> >  board/siemens/iot2050/MAINTAINERS                 |  1 -
> >  board/sifive/unmatched/MAINTAINERS                |  1 -
> >  board/sunxi/MAINTAINERS                           |  2 --
> >  board/ti/am62ax/MAINTAINERS                       |  1 -
> >  board/ti/am62dx/MAINTAINERS                       |  1 -
> >  board/ti/am62px/MAINTAINERS                       |  1 -
> >  board/ti/j7200/MAINTAINERS                        |  1 -
> >  board/toradex/apalis-tk1/MAINTAINERS              |  1 -
> >  board/toradex/apalis_t30/MAINTAINERS              |  2 --
> >  board/toradex/colibri-imx6ull/MAINTAINERS         |  1 -
> >  board/toradex/colibri-imx8x/MAINTAINERS           |  2 --
> >  board/toradex/colibri_imx7/MAINTAINERS            |  6 ------
> >  board/toradex/colibri_t20/MAINTAINERS             |  2 --
> >  board/toradex/colibri_t30/MAINTAINERS             |  2 --
> >  board/toradex/colibri_vf/MAINTAINERS              |  1 -
> >  board/toradex/smarc-imx8mp/MAINTAINERS            |  1 -
> >  board/traverse/ten64/MAINTAINERS                  |  1 -
> >  board/wandboard/MAINTAINERS                       |  1 -
> >  board/wexler/qc750/MAINTAINERS                    |  1 -
> >  board/xiaomi/mocha/MAINTAINERS                    |  1 -
> >  board/xilinx/zynqmp/MAINTAINERS                   |  1 -
> >  board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS |  1 -
> >  board/zyxel/nsa325/MAINTAINERS                    |  3 ---
> >  134 files changed, 241 deletions(-)
> >=20
>=20
> Thanks for the cleanup!
>=20
> For the TI boards
>=20
> Reviewed-by: Bryan Brattlof <bb@ti.com>

I want to call out the TI borads here, because I'd like to see the
entries fixed as the first thing I noticed was "it was called
am62a7_evm.h downstream, not am62a_evm.h upstream" and we should have
an entry for the include/config/ file :)

--=20
Tom

--6mi0u4nxJP8QaRt/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao2mkgAKCRAr4qD1Cr/k
CoPWAQDpvtTsCvHeAboj66qxosBwXG3TE0LlJpMantcy7V3h8wD/XC3zWOvquKVg
cxTQYBSlJPPxTailsfu1P7wPgaoAvAY=
=Ifzm
-----END PGP SIGNATURE-----

--6mi0u4nxJP8QaRt/--
