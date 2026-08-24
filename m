Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C61C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:24:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E475080C66;
	Mon, 24 Aug 2026 16:24:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LFAKf3yYzHtH; Mon, 24 Aug 2026 16:24:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787588673;
	bh=KAyVYkVB6eiFCXee60ViG76dr2Bdhrwt2QZvz1EiUko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nvdYnix/xgW6pzZWMECOMdSSJr3e+NlnILWOpJf2gr65DQJeVkjOp8EH1JmEg8eN5
	 ttBsuoejdfi8k2SYGt8PGBHRM/91Wu5JlJQSK2hB5nOTVFCUqUCaGdzIhJPBHWkSOk
	 VF9VdwlQSBFySyg8NqJ4j+xyJ49lleFNEI9lCGyff6YcZ9BXggWqvMdy4I34lBjWru
	 zEswoVwxtR8Iu7U3T6p9eX8e2D1pQKSq0PgZ85Gr+q6hYmEcyygDGH1oDXYdbfsK0L
	 avkS53p/0mnACK92+ewCapNCGqgltEllZxDO+q45VnXXSh3uED21kxQxwcHqGqf1Oc
	 d/abUkTm4F1kQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D896480C67;
	Mon, 24 Aug 2026 16:24:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B924279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:24:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D16A40586
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:24:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xhDt1-2_N0hs for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 16:24:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=l4XhpL4o
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 08F4240575
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:24:30 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7f3f52143cdso3555556a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 09:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787588669; x=1788193469;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KAyVYkVB6eiFCXee60ViG76dr2Bdhrwt2QZvz1EiUko=;
 b=l4XhpL4o3uEhplvQy9RGot/LXBlBADLyBihi1LOqwAVKSwAOgrWP2OuSwiqISHbw/a
 MVVyLgsjqiZm198rO9XRFc1+BnXnFKHSqRkrXpIkAz1+71cfpSaoOH7e6drK7LLx2aRu
 rcGKdmBqYYeUHAfaSiwEivn0N5HohpnaEcLws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787588669; x=1788193469;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KAyVYkVB6eiFCXee60ViG76dr2Bdhrwt2QZvz1EiUko=;
 b=qwks8xAeAgOUiAJF6Wrw7nCPl6wOyjKIQW+DoYPLbEqm3UnffgvIiGEsiJvUFRU/Wp
 PRpTp4EemYLh3e/1AQVjPoR6Pssz5iM/oUBrObIpsW57GD4zcyp/jhcZAiazTqtKoiqV
 WUMbApK4r/jJ7wZeZ+swj52F1C4FT78w9DwIRju2DvR9t8FDjGXx5hdwW6o/FYMQe1Gk
 ifSl8Bx5Uxh/0fCxRS3RX8pmS6coTlG1lg1tcw88CvZleWYfSJvD7yOQZ8HGxsMEjGa4
 yhbxmq8nCvZv9CRjuc/chBe19MBNf3n45kxMtW2fbL4EYX1esGMENkMI06et/T9AG/v8
 ACbw==
X-Gm-Message-State: AFuF++mRGcEfwX5jyJPASCz5CbDNjm48CDZ6cEFJuabpGwDrdHCH4QL5
 iq3N+6KiQdYKohFCpVI9267IcAEtPpdlAyxvE8j5TVUyGbSyrJroBNh7oQAIwSTFd5khssRmKpC
 ge4TrPB5ukhCn
X-Gm-Gg: AR+sD13/NwgTxOXChZAPTkZkH8/Z9D5czGlMYADwF4QmqdCGtzAop0JL9/6PWbpLhzN
 ToFZ/SkyfQiNg+4ujxgTDt7NBL7xGyzmORQVUeevxvgZ5A0p7qz/EWD/mssne7qbSR/2G38W6GS
 4b+EF7sFN4twzUSHTBCL3XSiiHUopBtk9NteoetsU6qUhBOy8oOwJxEJZr/uZBH6SUMSI/e2W8s
 FMWc+Kky+ICnfhxpPvWRcVW74FgNJ51lOEl4lKyv+4pRLPdNuXfFQXhSstLk8YZZD532d2bAAxG
 W72xbsWK9L7R7eHBnaD4z6vciWyg4+yE/c21brHep8fGnn0cr2CLKQnWXvqoNGBg+8KNAvJfOUU
 RkhqizmK0iXMnKOr0mw9+0mp2k5xX1C7lxLj7ei9hkOd7cC0AYETY4XX678DB92G65TVtOsHE+D
 yF26UM9yetSDA7Bo/bTJmtbKLqhfhT0W1TArluLJzee9uzAPBJMFr7hxnZeK3pPbiI+/RPse8k6
 umhgHwlX6EegfpiO96K+1ZaXDTb6Avr1r6sJ6bwIwHw/ew2GnedWr5CeKgJCaW8MtsFGRJUV/kp
 47rBXI387Q==
X-Received: by 2002:a05:6820:a090:b0:6b1:4806:f218 with SMTP id
 006d021491bc7-6b15924b646mr22871028eaf.14.1787588669349; 
 Mon, 24 Aug 2026 09:24:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b17c813af1sm3904080eaf.3.2026.08.24.09.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 09:24:28 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:24:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
Message-ID: <20260824162426.GG523975@bill-the-cat>
References: <cover.1787555916.git.michal.simek@amd.com>
 <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vKJDoOfEgsPVAQ/8"
Content-Disposition: inline
In-Reply-To: <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
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


--vKJDoOfEgsPVAQ/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 09:18:48AM +0200, Michal Simek wrote:

> A number of file (F:) entries across the MAINTAINERS files pointed to
> files or directories which had been renamed or removed over time. Drop
> these stale references so that every F: entry resolves to an existing
> path.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>=20
>  arch/arm/mach-rockchip/rk3576/MAINTAINERS         |  1 -
>  board/CZ.NIC/turris_omnia/MAINTAINERS             |  1 -
>  board/LaCie/net2big_v2/MAINTAINERS                |  4 ----
>  board/LaCie/netspace_v2/MAINTAINERS               |  6 ------
>  board/Marvell/octeontx/MAINTAINERS                |  2 --
>  board/Marvell/octeontx2/MAINTAINERS               |  2 --
>  board/Synology/ds116/MAINTAINERS                  |  1 -
>  board/acer/picasso/MAINTAINERS                    |  1 -
>  board/advantech/imx8mp_rsb3720a1/MAINTAINERS      |  1 -
>  board/advantech/imx8qm_dmsse20_a1/MAINTAINERS     |  1 -
>  board/alliedtelesis/SBx81LIFKW/MAINTAINERS        |  1 -
>  board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS      |  1 -
>  board/altera/stratix10-socdk/MAINTAINERS          |  1 -
>  board/amlogic/p212/MAINTAINERS                    |  1 -
>  board/amlogic/q200/MAINTAINERS                    |  1 -
>  board/amlogic/s400/MAINTAINERS                    |  1 -
>  board/andestech/voyager/MAINTAINERS               |  1 -
>  board/asus/grouper/MAINTAINERS                    |  1 -
>  board/asus/transformer-t114/MAINTAINERS           |  1 -
>  board/asus/transformer-t20/MAINTAINERS            |  1 -
>  board/asus/transformer-t30/MAINTAINERS            |  1 -
>  board/atmel/at91sam9260ek/MAINTAINERS             |  1 -
>  board/atmel/sama5d29_curiosity/MAINTAINERS        |  1 -
>  board/atmel/sama7d65_curiosity/MAINTAINERS        |  1 -
>  board/atmel/sama7g54_curiosity/MAINTAINERS        |  1 -
>  board/atmel/sama7g5ek/MAINTAINERS                 |  1 -
>  board/avionic-design/medcom-wide/MAINTAINERS      |  1 -
>  board/avionic-design/plutux/MAINTAINERS           |  1 -
>  board/avionic-design/tec-ng/MAINTAINERS           |  1 -
>  board/avionic-design/tec/MAINTAINERS              |  1 -
>  board/beacon/beacon-rzg2m/MAINTAINERS             |  3 ---
>  board/bosch/acc/MAINTAINERS                       |  1 -
>  board/cei/cei-tk1-som/MAINTAINERS                 |  1 -
>  board/compal/paz00/MAINTAINERS                    |  1 -
>  board/compulab/trimslice/MAINTAINERS              |  1 -
>  board/comtrend/vr3032u/MAINTAINERS                |  1 -
>  board/comtrend/wap5813n/MAINTAINERS               |  1 -
>  board/coolpi/genbook_cm5_rk3588/MAINTAINERS       |  1 -
>  board/davinci/da8xxevm/MAINTAINERS                |  1 -
>  board/embest/mx6boards/MAINTAINERS                |  1 -
>  board/engicam/imx6ul/MAINTAINERS                  |  3 ---
>  board/friendlyarm/nanopi2/MAINTAINERS             |  1 -
>  board/gardena/smart-gateway-at91sam/MAINTAINERS   |  1 -
>  board/gardena/smart-gateway-mt7688/MAINTAINERS    |  1 -
>  board/gateworks/gw_ventana/MAINTAINERS            |  6 ------
>  board/ge/bx50v3/MAINTAINERS                       |  3 ---
>  board/htc/endeavoru/MAINTAINERS                   |  1 -
>  board/imgtec/xilfpga/MAINTAINERS                  |  1 -
>  board/intel/agilex-socdk/MAINTAINERS              |  1 -
>  board/intel/agilex7m-socdk/MAINTAINERS            |  2 --
>  board/intel/n5x-socdk/MAINTAINERS                 |  1 -
>  board/keymile/km83xx/MAINTAINERS                  |  2 --
>  board/khadas/khadas-edge2-rk3588s/MAINTAINERS     |  1 -
>  board/kontron/sl-mx6ul/MAINTAINERS                |  2 --
>  board/lenovo/ideapad-yoga-11/MAINTAINERS          |  1 -
>  board/lg/x3-t30/MAINTAINERS                       |  1 -
>  board/libre-computer/aml-a311d-cc/MAINTAINERS     |  1 -
>  board/libre-computer/aml-s805x-ac/MAINTAINERS     |  1 -
>  board/libre-computer/aml-s905d3-cc/MAINTAINERS    |  1 -
>  board/mediatek/mt7981/MAINTAINERS                 |  2 --
>  board/mediatek/mt7986/MAINTAINERS                 |  4 ----
>  board/microsoft/surface-rt/MAINTAINERS            |  1 -
>  board/myir/mys_6ulx/MAINTAINERS                   |  1 -
>  board/nvidia/beaver/MAINTAINERS                   |  1 -
>  board/nvidia/cardhu/MAINTAINERS                   |  1 -
>  board/nvidia/dalmore/MAINTAINERS                  |  1 -
>  board/nvidia/harmony/MAINTAINERS                  |  1 -
>  board/nvidia/jetson-tk1/MAINTAINERS               |  1 -
>  board/nvidia/nyan-big/MAINTAINERS                 |  1 -
>  board/nvidia/p2371-0000/MAINTAINERS               |  1 -
>  board/nvidia/p2371-2180/MAINTAINERS               |  1 -
>  board/nvidia/p2571/MAINTAINERS                    |  1 -
>  board/nvidia/p2771-0000/MAINTAINERS               |  1 -
>  board/nvidia/p3450-0000/MAINTAINERS               |  1 -
>  board/nvidia/seaboard/MAINTAINERS                 |  1 -
>  board/nvidia/tegratab/MAINTAINERS                 |  1 -
>  board/nvidia/venice2/MAINTAINERS                  |  1 -
>  board/nvidia/ventana/MAINTAINERS                  |  1 -
>  board/nxp/imx93_evk/MAINTAINERS                   |  1 -
>  board/nxp/ls1012afrdm/MAINTAINERS                 |  4 ----
>  board/nxp/ls1012aqds/MAINTAINERS                  |  1 -
>  board/nxp/ls1012ardb/MAINTAINERS                  |  3 ---
>  board/nxp/ls1043aqds/MAINTAINERS                  |  7 -------
>  board/nxp/ls1043ardb/MAINTAINERS                  |  6 ------
>  board/nxp/ls1046aqds/MAINTAINERS                  |  7 -------
>  board/nxp/ls1046ardb/MAINTAINERS                  |  7 -------
>  board/nxp/ls1088a/MAINTAINERS                     |  9 ---------
>  board/nxp/ls2080aqds/MAINTAINERS                  |  4 ----
>  board/nxp/ls2080ardb/MAINTAINERS                  |  6 ------
>  board/nxp/lx2160a/MAINTAINERS                     |  2 --
>  board/nxp/mpc837xerdb/MAINTAINERS                 |  1 -
>  board/nxp/mx6slevk/MAINTAINERS                    |  2 --
>  board/nxp/p2041rdb/MAINTAINERS                    |  3 ---
>  board/nxp/t104xrdb/MAINTAINERS                    | 13 -------------
>  board/nxp/t208xqds/MAINTAINERS                    |  5 -----
>  board/nxp/t208xrdb/MAINTAINERS                    |  1 -
>  board/ouya/ouya/MAINTAINERS                       |  1 -
>  board/phytec/phycore_am62ax/MAINTAINERS           |  1 -
>  board/phytec/phycore_am68x/MAINTAINERS            |  1 -
>  board/phytec/phycore_imx8mm/MAINTAINERS           |  1 -
>  board/polyhex/imx8mp_debix_model_a/MAINTAINERS    |  1 -
>  board/qualcomm/dragonboard410c/MAINTAINERS        |  1 -
>  board/qualcomm/dragonboard820c/MAINTAINERS        |  1 -
>  board/qualcomm/dragonboard845c/MAINTAINERS        |  2 --
>  board/qualcomm/qcs404-evb/MAINTAINERS             |  2 --
>  board/renesas/blanche/MAINTAINERS                 |  1 -
>  board/renesas/eagle/MAINTAINERS                   |  1 -
>  board/renesas/grpeach/MAINTAINERS                 |  1 -
>  board/renesas/v3msk/MAINTAINERS                   |  1 -
>  board/samsung/starqltechn/MAINTAINERS             |  2 --
>  board/seeed/linkit-smart-7688/MAINTAINERS         |  1 -
>  board/siemens/iot2050/MAINTAINERS                 |  1 -
>  board/sifive/unmatched/MAINTAINERS                |  1 -
>  board/sunxi/MAINTAINERS                           |  2 --
>  board/ti/am62ax/MAINTAINERS                       |  1 -
>  board/ti/am62dx/MAINTAINERS                       |  1 -
>  board/ti/am62px/MAINTAINERS                       |  1 -
>  board/ti/j7200/MAINTAINERS                        |  1 -
>  board/toradex/apalis-tk1/MAINTAINERS              |  1 -
>  board/toradex/apalis_t30/MAINTAINERS              |  2 --
>  board/toradex/colibri-imx6ull/MAINTAINERS         |  1 -
>  board/toradex/colibri-imx8x/MAINTAINERS           |  2 --
>  board/toradex/colibri_imx7/MAINTAINERS            |  6 ------
>  board/toradex/colibri_t20/MAINTAINERS             |  2 --
>  board/toradex/colibri_t30/MAINTAINERS             |  2 --
>  board/toradex/colibri_vf/MAINTAINERS              |  1 -
>  board/toradex/smarc-imx8mp/MAINTAINERS            |  1 -
>  board/traverse/ten64/MAINTAINERS                  |  1 -
>  board/wandboard/MAINTAINERS                       |  1 -
>  board/wexler/qc750/MAINTAINERS                    |  1 -
>  board/xiaomi/mocha/MAINTAINERS                    |  1 -
>  board/xilinx/zynqmp/MAINTAINERS                   |  1 -
>  board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS |  1 -
>  board/zyxel/nsa325/MAINTAINERS                    |  3 ---
>  134 files changed, 241 deletions(-)

My concern with doing a big change this way is that similar to the
xilinx platforms, there's a lot of mistakes to correct, rather than
drop. With some detective work (and, time) I think most of these get
corrected rather than dropped. For examples:

[snip]
> diff --git a/board/CZ.NIC/turris_omnia/MAINTAINERS b/board/CZ.NIC/turris_=
omnia/MAINTAINERS
> index effce8a753b4..530ca5b420fc 100644
> --- a/board/CZ.NIC/turris_omnia/MAINTAINERS
> +++ b/board/CZ.NIC/turris_omnia/MAINTAINERS
> @@ -5,5 +5,4 @@ F:	arch/arm/dts/armada-385-turris-omnia*.dts*
>  F:	board/CZ.NIC/turris_atsha_otp.*
>  F:	board/CZ.NIC/turris_omnia/
>  F:	configs/turris_omnia_defconfig
> -F:	drivers/gpio/turris_omnia_mcu.c

This was committed as drivers/misc/turris_omnia_mcu.c

[snip]
> diff --git a/board/Marvell/octeontx/MAINTAINERS b/board/Marvell/octeontx/=
MAINTAINERS
> index 1f3b12b1abf2..c66607c01d5a 100644
> --- a/board/Marvell/octeontx/MAINTAINERS
> +++ b/board/Marvell/octeontx/MAINTAINERS
> @@ -2,7 +2,5 @@ OCTEONTX BOARD
>  M:	Aaron Williams <awilliams@marvell.com>
>  S:	Maintained
>  F:	board/Marvell/octeontx/
> -F:	include/configs/octeontx_81xx.h
> -F:	include/configs/octeontx_83xx.h
>  F:	configs/octeontx_81xx_defconfig
>  F:	configs/octeontx_83xx_defconfig
> diff --git a/board/Marvell/octeontx2/MAINTAINERS b/board/Marvell/octeontx=
2/MAINTAINERS
> index eec1d77dd108..8502c119c352 100644
> --- a/board/Marvell/octeontx2/MAINTAINERS
> +++ b/board/Marvell/octeontx2/MAINTAINERS
> @@ -2,7 +2,5 @@ OCTEONTX2 BOARD
>  M:	Aaron Williams <awilliams@marvell.com>
>  S:	Maintained
>  F:	board/Marvell/octeontx2/
> -F:	include/configs/octeontx2_96xx.h
> -F:	include/configs/octeontx2_95xx.h
>  F:	configs/octeontx2_96xx_defconfig
>  F:	configs/octeontx2_95xx_defconfig


Looking at board/Marvell/*/MAINTAINERS those files are gone, but=20
include/configs/octeontx2_common.h include/configs/octeontx_common.h
exist and should be somewhere, probably one and one.

And so on. So, I'd be happy to take over this part of the series, if it
looks like a lot of work you'd rather not take on at the moment.

--=20
Tom

--vKJDoOfEgsPVAQ/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoxwNwAKCRAr4qD1Cr/k
CrYYAP9IHUpljgq5M3eHfBuIds5KKXfrQfxRncjm+2L3UlLUmAEA12mPxNoQh52n
3beV0Hf323a98I20FB8VUB+C3wmp8Qc=
=d9tb
-----END PGP SIGNATURE-----

--vKJDoOfEgsPVAQ/8--
