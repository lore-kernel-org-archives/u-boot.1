Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC86C61DD6
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 20:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3608A60607;
	Sat, 29 Aug 2026 20:17:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HROc0527aY6V; Sat, 29 Aug 2026 20:17:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788034635;
	bh=cr4L0mHcE6uV7EwWKc+euTejItR4gFtk+a2659Xqnmc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tJWkBLrunb1cmO0GAbxA+eEC0KgPoi4kNoG4813hHO08WvHZpSvblh0HULRNqnM2h
	 sravBVMZExnQ9X+CVvzdX+a+AnTQLIxXa0rYvhRsEJLPwIBFTDT6Lu2LAKsTeIj/6/
	 b5x0FWqCNWMH0pFv30ObZU80ZPF7Zky7B/AkwMcnv77tf0Bmm8t59lBBX4wWvJcz6e
	 cuGkUuH8jX3davtN+W+ciJy+FLggE9V0phGIhLuQv77IVOjbHESDXlrBw1ra1VP9yC
	 vyq8O1yGJGj+dhpBK+ngbLtagD+1aBXZZMe9Bck05az7lORz64tH5pGpHbC/kl8gM6
	 fNybS0hQ+GR8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFE86605ED;
	Sat, 29 Aug 2026 20:17:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C876E118
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 20:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE70140303
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 20:17:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VDAmf5n8hi9w for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 20:17:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1130; helo=mail-yw1-x1130.google.com;
 envelope-from=mibodhi@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=d3arUG6n
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C0252406A5
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 20:17:11 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-857ff9fef54so25345467b3.1
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 13:17:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788034630; cv=none;
 d=google.com; s=arc-20260327;
 b=g2PfrK7cSSybZlF9ZY06Z6g1LEJ/ycpV5QqKZxFm9kFXU92EujDmpJxMZ2/MW4Iaf9
 0Dz5LVeGWN3zvxQACPu31Axoxr8CTg1VUVC3ihqMJjOTljgtqA+nCPK1APByWjshvH9w
 I9LHTKVch0ZA+74ivKH30wJYLQDMQ4y+VdESDCnAGzwjAe7yDbqYIoxlxg+fw96ehwJy
 0pm9tHLLruL4LilxMorztNJEJOTG8GBB7TZUBryWHmAZMyhJgZeGFOaU5zTBol0/qHKa
 KjSQC1l8JaBETSCxQdRJt6kX7bw/BLq3Ro8Of3PlJRc/3daExNh83cRy1IhcwfeZ9gGk
 SERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cr4L0mHcE6uV7EwWKc+euTejItR4gFtk+a2659Xqnmc=;
 fh=UkgmGQN8CtqB4gNDKIGntEsPzO149o9znMRey2UBX3I=;
 b=BXYi4AG24LJevv5tgv1tRm/UDP6/pb/LoRT7UnNnlC1xIjQqjaMyKDCSvUVexgBzAj
 ehlChd6v+OwIW8+miOe/gK04QxJ6tCRfCQl3+By4Ilr4vMz/w0EuC1TVMkPPK0EByo6g
 M6kMtxt6yBHTAKyCUp3lliU+Cgb/DJDIrn3s10KH23h5ibbktM7fqzySmA+H6TwruW++
 HomXvBfDcMusgNghzpBl5XgFBZTzAfH67l5wzsGSfK/Y3bU3Zqb/u/se8y9OQTMINyRn
 jJrBjtdOSM2HRz6lBcNpQf/affehFxiE6b6R5mVP0193W9xJ+/VjKqrHVcr/37vggtak
 f4zQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788034630; x=1788639430;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cr4L0mHcE6uV7EwWKc+euTejItR4gFtk+a2659Xqnmc=;
 b=d3arUG6n/x4XR5vx/BbvHkx/QSMEcHGRDuT5adpMf2Bon4Yac/7s69iX79E5BK2max
 Yb8DeZW243EyTsWpSH3YAbi8rW0syM/NM58Ny3vIfd2mp0DKUZhffc5MICEg5c1UBktP
 0IMcq0WiYkmfqKwv9jZRYY3lBqOQIw4DISiNK5OgGF5JWp2jam972yKGdC+DeOMIRzXX
 JhwJ8RR4OVS8uqeOC0kUPsJ2LfzH6iv/ILMObxfwvfTB0Bm/VMbGfuQAcmi4ev7eOz1g
 o2/JgpJEdoBndj1TUqrjfaom8jOu/Fm5QJQIOhOVq5kFF0TOymjHxZ6/oIgmvBk0sgPb
 /gAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788034630; x=1788639430;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cr4L0mHcE6uV7EwWKc+euTejItR4gFtk+a2659Xqnmc=;
 b=KcREpkCTReS5KYTWwubw211Kdq4XR+pq30wAsBpUBiRmBy6ySATmb7X/jPoOnxEZ5T
 6W0lZKRyGdVqIlTUzWN2e86Xxpy92Inqs/sLYh0/ZLeHXlNyxBNh6kbaqjgMp46b00u+
 NGdltCkqg3SStFmSSLqL8F/jchR5r+Mygv1ynq/8r9/XYvMp9rXK2l86l5eP3nAUIiBj
 Dq0iBu1OUBnsYhP0kYq0aHZ5+EX/f4yb7bKDf6CMoKkuMXOZnTpJ0H6j5uCIIEOEPQ5k
 sm8dDQqXmFgrChW5UEhhYLo2f1uGAaluv8YkOb3H4U1kzAZWqd+0625OQAB+YuTWvUVB
 ywCA==
X-Gm-Message-State: AFuF++n0CXc+FxwZO+GQ5HUtxqfT7rhy7W4zW0K1AkO2vZWOVS6fS7fv
 dHoDVC9OGbEIWB3elU5Fw1qqAiW9Z9/hH48jgZk5a2qJJ8hfwatoiBkdXqS4e4lopIQisGyObYI
 fMV3IQyeUD971FMFzlM3PccdbIt3um8Y=
X-Gm-Gg: AYBFou2VqcfQHFAsJJfSriQJT3XDc7EamxiMqswZ5kaIkbDPv2KEvbmkGbrB1fdb4yG
 /LFz7lRymA0KMpN3y3iKELzQRKPG5tGewp67cXWKVeT8WoWJ+IkHocO17t8FHumLh7pVBIt+r+r
 um/bB9D3axgrMb4n9FJWUH97GjTjYJ6VDPckxgWWfF4iMeBQkQM5qvk8yaRqovNUFf0TKnXly0K
 7DkwG0WxGug0BhR75A0I+jZe75HLh0lUYYpUwPCWwEYFkFKyeHpIwFdtAPQoDDoMiXdVPeSy54T
 svRCj9sMHVtRoSHj/6ckQ2wNYAQ7DW3g2/2VczZpyWeGZbE=
X-Received: by 2002:a53:c242:0:b0:66e:4aab:9f50 with SMTP id
 956f58d0204a3-66e4c6d33c9mr3292784d50.28.1788034626794; Sat, 29 Aug 2026
 13:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260829015026.473134-1-trini@konsulko.com>
 <20260829015026.473134-7-trini@konsulko.com>
In-Reply-To: <20260829015026.473134-7-trini@konsulko.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sat, 29 Aug 2026 13:16:29 -0700
X-Gm-Features: AcwNN1WGnwSuSIBZ38lkiJAHSQMgF-a9vC1Nkm16HUvbKc1PNgbrbf_8-Bzu4wk
Message-ID: <CAJaLiFx1L6FQcR=egqMuE4zew7eoNq38BcKmLTgqXeV-ESiLew@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] MAINTAINERS: Removed files
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Aug 28, 2026 at 6:50=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> Correct MAINTAINERS entries for files that have been removed. In most
> cases this is because a given platform has moved to using OF_UPSTREAM
> and so the local version of the file does not exist. In other cases,
> sample defconfigs have either been merged or simply removed.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Tony Dinh <mibodhi@gmail.com>
(for net2big_v2, netspace_v2, ds116, nsa325)

Thanks,
Tony
> ---
> Cc: Michal Simek <michal.simek@amd.com>
> ---
>  board/LaCie/net2big_v2/MAINTAINERS             |  4 ----
>  board/LaCie/netspace_v2/MAINTAINERS            |  6 ------
>  board/Synology/ds116/MAINTAINERS               |  1 -
>  board/altera/stratix10-socdk/MAINTAINERS       |  1 -
>  board/atmel/at91sam9260ek/MAINTAINERS          |  1 -
>  board/beacon/beacon-rzg2m/MAINTAINERS          |  3 ---
>  board/embest/mx6boards/MAINTAINERS             |  1 -
>  board/gardena/smart-gateway-mt7688/MAINTAINERS |  1 -
>  board/gateworks/gw_ventana/MAINTAINERS         |  6 ------
>  board/ge/bx50v3/MAINTAINERS                    |  3 ---
>  board/intel/agilex-socdk/MAINTAINERS           |  1 -
>  board/intel/agilex7m-socdk/MAINTAINERS         |  1 -
>  board/intel/n5x-socdk/MAINTAINERS              |  1 -
>  board/khadas/khadas-edge2-rk3588s/MAINTAINERS  |  1 -
>  board/kontron/sl-mx6ul/MAINTAINERS             |  7 +++----
>  board/mediatek/mt7981/MAINTAINERS              |  2 --
>  board/mediatek/mt7986/MAINTAINERS              |  4 ----
>  board/nxp/imx93_evk/MAINTAINERS                |  1 -
>  board/nxp/ls1012afrdm/MAINTAINERS              | 12 ++++--------
>  board/nxp/ls1012aqds/MAINTAINERS               |  1 -
>  board/nxp/ls1012ardb/MAINTAINERS               |  3 ---
>  board/nxp/ls1043aqds/MAINTAINERS               |  7 -------
>  board/nxp/ls1043ardb/MAINTAINERS               |  6 ------
>  board/nxp/ls1046aqds/MAINTAINERS               |  7 -------
>  board/nxp/ls1046ardb/MAINTAINERS               |  7 -------
>  board/nxp/ls1088a/MAINTAINERS                  |  9 ---------
>  board/nxp/ls2080aqds/MAINTAINERS               |  4 ----
>  board/nxp/ls2080ardb/MAINTAINERS               |  6 ------
>  board/nxp/lx2160a/MAINTAINERS                  |  2 --
>  board/nxp/mpc837xerdb/MAINTAINERS              |  1 -
>  board/nxp/mx6slevk/MAINTAINERS                 |  2 --
>  board/nxp/p2041rdb/MAINTAINERS                 |  3 ---
>  board/nxp/t104xrdb/MAINTAINERS                 | 13 -------------
>  board/nxp/t208xqds/MAINTAINERS                 |  5 -----
>  board/nxp/t208xrdb/MAINTAINERS                 |  1 -
>  board/phytec/phycore_am68x/MAINTAINERS         |  1 -
>  board/polyhex/imx8mp_debix_model_a/MAINTAINERS |  1 -
>  board/renesas/blanche/MAINTAINERS              |  1 -
>  board/seeed/linkit-smart-7688/MAINTAINERS      |  1 -
>  board/sunxi/MAINTAINERS                        |  2 --
>  board/toradex/colibri-imx6ull/MAINTAINERS      |  1 -
>  board/traverse/ten64/MAINTAINERS               |  1 -
>  board/xilinx/zynqmp/MAINTAINERS                |  1 -
>  board/zyxel/nsa325/MAINTAINERS                 |  3 ---
>  44 files changed, 7 insertions(+), 139 deletions(-)
>
> diff --git a/board/LaCie/net2big_v2/MAINTAINERS b/board/LaCie/net2big_v2/=
MAINTAINERS
> index 66e82196794e..41a7f07e4a3d 100644
> --- a/board/LaCie/net2big_v2/MAINTAINERS
> +++ b/board/LaCie/net2big_v2/MAINTAINERS
> @@ -1,12 +1,8 @@
>  NET2BIG_V2 BOARD
>  M:     Simon Guinot <simon.guinot@sequanux.org>
>  S:     Maintained
> -F:     arch/arm/dts/kirkwood-d2net.dts
>  F:     arch/arm/dts/kirkwood-d2net-u-boot.dtsi
> -F:     arch/arm/dts/kirkwood-d2net.dtsi
> -F:     arch/arm/dts/kirkwood-net2big.dts
>  F:     arch/arm/dts/kirkwood-net2big-u-boot.dtsi
> -F:     arch/arm/dts/kirkwood-netxbig.dtsi
>  F:     board/LaCie/common/
>  F:     board/LaCie/net2big_v2/
>  F:     include/configs/lacie_kw.h
> diff --git a/board/LaCie/netspace_v2/MAINTAINERS b/board/LaCie/netspace_v=
2/MAINTAINERS
> index 03bc7874c164..1e0a50240781 100644
> --- a/board/LaCie/netspace_v2/MAINTAINERS
> +++ b/board/LaCie/netspace_v2/MAINTAINERS
> @@ -1,15 +1,9 @@
>  NETSPACE_V2 BOARDS
>  M:     Simon Guinot <simon.guinot@sequanux.org>
>  S:     Maintained
> -F:     arch/arm/dts/kirkwood-is2.dts
>  F:     arch/arm/dts/kirkwood-is2-u-boot.dtsi
> -F:     arch/arm/dts/kirkwood-ns2-common.dtsi
> -F:     arch/arm/dts/kirkwood-ns2.dts
> -F:     arch/arm/dts/kirkwood-ns2lite.dts
>  F:     arch/arm/dts/kirkwood-ns2lite-u-boot.dtsi
> -F:     arch/arm/dts/kirkwood-ns2max.dts
>  F:     arch/arm/dts/kirkwood-ns2max-u-boot.dtsi
> -F:     arch/arm/dts/kirkwood-ns2mini.dts
>  F:     arch/arm/dts/kirkwood-ns2mini-u-boot.dtsi
>  F:     arch/arm/dts/kirkwood-ns2-u-boot.dtsi
>  F:     board/LaCie/common/
> diff --git a/board/Synology/ds116/MAINTAINERS b/board/Synology/ds116/MAIN=
TAINERS
> index 8d3cc24fbef4..048ec9f10a1d 100644
> --- a/board/Synology/ds116/MAINTAINERS
> +++ b/board/Synology/ds116/MAINTAINERS
> @@ -1,7 +1,6 @@
>  DS116 BOARD
>  M:     Tony Dinh <mibodhi@gmail.com>
>  S:     Maintained
> -F:     arch/arm/dts/armada-385-synology-ds116.dts
>  F:     board/Synology/ds116/
>  F:     board/Synology/common
>  F:     include/configs/ds116.h
> diff --git a/board/altera/stratix10-socdk/MAINTAINERS b/board/altera/stra=
tix10-socdk/MAINTAINERS
> index 6efd0cfc0560..6192bc917465 100644
> --- a/board/altera/stratix10-socdk/MAINTAINERS
> +++ b/board/altera/stratix10-socdk/MAINTAINERS
> @@ -4,5 +4,4 @@ M:      Dinh Nguyen <dinh.nguyen@intel.com>
>  S:     Maintained
>  F:     board/altera/stratix10-socdk/
>  F:     include/configs/socfpga_stratix10_socdk.h
> -F:     configs/socfpga_stratix10_atf_defconfig
>  F:     configs/socfpga_stratix10_defconfig
> diff --git a/board/atmel/at91sam9260ek/MAINTAINERS b/board/atmel/at91sam9=
260ek/MAINTAINERS
> index aa7898ef7469..28b11243feb5 100644
> --- a/board/atmel/at91sam9260ek/MAINTAINERS
> +++ b/board/atmel/at91sam9260ek/MAINTAINERS
> @@ -9,7 +9,6 @@ F:      configs/at91sam9260ek_nandflash_defconfig
>  F:     configs/at91sam9g20ek_2mmc_nandflash_defconfig
>  F:     configs/at91sam9g20ek_dataflash_cs0_defconfig
>  F:     configs/at91sam9g20ek_dataflash_cs1_defconfig
> -F:     configs/at91sam9g20ek_mmc_defconfig
>  F:     configs/at91sam9g20ek_2mmc_defconfig
>  F:     configs/at91sam9g20ek_nandflash_defconfig
>  F:     configs/at91sam9xeek_dataflash_cs0_defconfig
> diff --git a/board/beacon/beacon-rzg2m/MAINTAINERS b/board/beacon/beacon-=
rzg2m/MAINTAINERS
> index a4a920a017b0..b28272c58ee0 100644
> --- a/board/beacon/beacon-rzg2m/MAINTAINERS
> +++ b/board/beacon/beacon-rzg2m/MAINTAINERS
> @@ -7,9 +7,6 @@ F:      include/configs/beacon-rzg2m.h
>  F:     configs/rzg2_beacon_defconfig
>  F:     arch/arm/dts/beacon-renesom-baseboard.dtsi
>  F:     arch/arm/dts/beacon-renesom-som.dtsi
> -F:     arch/arm/dts/r8a774a1-beacon-rzg2m-kit.dts
> -F:     arch/arm/dts/r8a774b1-beacon-rzg2n-kit.dts
> -F:     arch/arm/dts/r8a774e1-beacon-rzg2h-kit.dts
>  F:     arch/arm/dts/r8a774a1-beacon-rzg2m-kit-u-boot.dtsi
>  F:     arch/arm/dts/r8a774b1-beacon-rzg2n-kit-u-boot.dtsi
>  F:     arch/arm/dts/r8a774e1-beacon-rzg2h-kit-u-boot.dtsi
> diff --git a/board/embest/mx6boards/MAINTAINERS b/board/embest/mx6boards/=
MAINTAINERS
> index 02756c58b3c8..0ffd4668b42d 100644
> --- a/board/embest/mx6boards/MAINTAINERS
> +++ b/board/embest/mx6boards/MAINTAINERS
> @@ -5,4 +5,3 @@ F:      board/embest/mx6boards/
>  F:     include/configs/embestmx6boards.h
>  F:     configs/marsboard_defconfig
>  F:     configs/riotboard_defconfig
> -F:     configs/riotboard_spl_defconfig
> diff --git a/board/gardena/smart-gateway-mt7688/MAINTAINERS b/board/garde=
na/smart-gateway-mt7688/MAINTAINERS
> index bbb491c1ce6d..f241d5c3a5e5 100644
> --- a/board/gardena/smart-gateway-mt7688/MAINTAINERS
> +++ b/board/gardena/smart-gateway-mt7688/MAINTAINERS
> @@ -4,5 +4,4 @@ S:      Maintained
>  F:     board/gardena/smart-gateway-mt7688
>  F:     include/configs/gardena-smart-gateway-mt7688.h
>  F:     configs/gardena-smart-gateway-mt7688_defconfig
> -F:     configs/gardena-smart-gateway-mt7688-ram_defconfig
>  F:     arch/mips/dts/gardena-smart-gateway-mt7688.dts
> diff --git a/board/gateworks/gw_ventana/MAINTAINERS b/board/gateworks/gw_=
ventana/MAINTAINERS
> index f9872806c0c5..3d604b725b2c 100644
> --- a/board/gateworks/gw_ventana/MAINTAINERS
> +++ b/board/gateworks/gw_ventana/MAINTAINERS
> @@ -15,7 +15,6 @@ F:    arch/arm/dts/imx6dl-gw553x.dts
>  F:     arch/arm/dts/imx6dl-gw560x.dts
>  F:     arch/arm/dts/imx6dl-gw5903.dts
>  F:     arch/arm/dts/imx6dl-gw5904.dts
> -F:     arch/arm/dts/imx6dl-gw5905.dts
>  F:     arch/arm/dts/imx6dl-gw5907.dts
>  F:     arch/arm/dts/imx6dl-gw5910.dts
>  F:     arch/arm/dts/imx6dl-gw5912.dts
> @@ -30,7 +29,6 @@ F:    arch/arm/dts/imx6qdl-gw553x.dtsi
>  F:     arch/arm/dts/imx6qdl-gw560x.dtsi
>  F:     arch/arm/dts/imx6qdl-gw5903.dtsi
>  F:     arch/arm/dts/imx6qdl-gw5904.dtsi
> -F:     arch/arm/dts/imx6qdl-gw5905.dtsi
>  F:     arch/arm/dts/imx6qdl-gw5907.dtsi
>  F:     arch/arm/dts/imx6qdl-gw5910.dtsi
>  F:     arch/arm/dts/imx6qdl-gw5912.dtsi
> @@ -38,17 +36,13 @@ F:  arch/arm/dts/imx6qdl-gw5913.dtsi
>  F:     arch/arm/dts/imx6q-gw51xx.dts
>  F:     arch/arm/dts/imx6q-gw52xx.dts
>  F:     arch/arm/dts/imx6q-gw53xx.dts
> -F:     arch/arm/dts/imx6q-gw5400-a.dts
>  F:     arch/arm/dts/imx6q-gw54xx.dts
>  F:     arch/arm/dts/imx6q-gw551x.dts
>  F:     arch/arm/dts/imx6q-gw552x.dts
>  F:     arch/arm/dts/imx6q-gw553x.dts
>  F:     arch/arm/dts/imx6q-gw560x.dts
> -F:     arch/arm/dts/imx6q-gw5901.dts
> -F:     arch/arm/dts/imx6q-gw5902.dts
>  F:     arch/arm/dts/imx6q-gw5903.dts
>  F:     arch/arm/dts/imx6q-gw5904.dts
> -F:     arch/arm/dts/imx6q-gw5905.dts
>  F:     arch/arm/dts/imx6q-gw5907.dts
>  F:     arch/arm/dts/imx6q-gw5910.dts
>  F:     arch/arm/dts/imx6q-gw5912.dts
> diff --git a/board/ge/bx50v3/MAINTAINERS b/board/ge/bx50v3/MAINTAINERS
> index 53a8d88a9043..9dacfaf99974 100644
> --- a/board/ge/bx50v3/MAINTAINERS
> +++ b/board/ge/bx50v3/MAINTAINERS
> @@ -7,8 +7,5 @@ F:      arch/arm/dts/imx6q-b650v3.dts
>  F:     arch/arm/dts/imx6q-b850v3.dts
>  F:     arch/arm/dts/imx6q-bx50v3*
>  F:     board/ge/bx50v3/
> -F:     configs/ge_b450v3_defconfig
> -F:     configs/ge_b650v3_defconfig
> -F:     configs/ge_b850v3_defconfig
>  F:     configs/ge_bx50v3_defconfig
>  F:     include/configs/ge_bx50v3.h
> diff --git a/board/intel/agilex-socdk/MAINTAINERS b/board/intel/agilex-so=
cdk/MAINTAINERS
> index fd05e9a4afb3..a90e9e91bb5a 100644
> --- a/board/intel/agilex-socdk/MAINTAINERS
> +++ b/board/intel/agilex-socdk/MAINTAINERS
> @@ -4,7 +4,6 @@ M:      Chee Hong Ang <chee.hong.ang@intel.com>
>  S:     Maintained
>  F:     board/intel/agilex-socdk/
>  F:     include/configs/socfpga_agilex_socdk.h
> -F:     configs/socfpga_agilex_atf_defconfig
>  F:     configs/socfpga_agilex_defconfig
>
>  SOCFPGA BOARD WITH VAB
> diff --git a/board/intel/agilex7m-socdk/MAINTAINERS b/board/intel/agilex7=
m-socdk/MAINTAINERS
> index eea2810d3287..c7cf80eb7e1f 100644
> --- a/board/intel/agilex7m-socdk/MAINTAINERS
> +++ b/board/intel/agilex7m-socdk/MAINTAINERS
> @@ -3,7 +3,6 @@ M:      Tien Fong Chee <tien.fong.chee@altera.com>
>  M:     Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>  S:     Maintained
>  F:     arch/arm/dts/socfpga_soc64_u-boot.dtsi
> -F:     arch/arm/dts/socfpga_agilex7m*
>  F:     arch/arm/mach-socfpga/spl_agilex7m.c
>  F:     board/intel/agilex7m-socdk/
>  F:     include/configs/socfpga_agilex7m_socdk.h
> diff --git a/board/intel/n5x-socdk/MAINTAINERS b/board/intel/n5x-socdk/MA=
INTAINERS
> index ca063a9f3f1d..0ef39964412c 100644
> --- a/board/intel/n5x-socdk/MAINTAINERS
> +++ b/board/intel/n5x-socdk/MAINTAINERS
> @@ -5,5 +5,4 @@ S:      Maintained
>  F:     board/intel/n5x-socdk/
>  F:     include/configs/socfpga_n5x_socdk.h
>  F:     configs/socfpga_n5x_defconfig
> -F:     configs/socfpga_n5x_atf_defconfig
>  F:     configs/socfpga_n5x_vab_defconfig
> diff --git a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS b/board/khadas=
/khadas-edge2-rk3588s/MAINTAINERS
> index c43f469589dd..2e7f43042ba3 100644
> --- a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
> +++ b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
> @@ -3,4 +3,3 @@ M:      Jacobe Zang <jacobe.zang@wesion.com>
>  S:     Maintained
>  F:     configs/khadas-edge2-rk3588s_defconfig
>  F:     include/configs/khadas-edge2-rk3588s.h
> -F:     arch/arm/dts/rk3588s-khadas-edge2*
> diff --git a/board/kontron/sl-mx6ul/MAINTAINERS b/board/kontron/sl-mx6ul/=
MAINTAINERS
> index 9e9dff0361ce..8f23adeeae82 100644
> --- a/board/kontron/sl-mx6ul/MAINTAINERS
> +++ b/board/kontron/sl-mx6ul/MAINTAINERS
> @@ -1,10 +1,9 @@
>  Kontron SL/BL i.MX6UL/ULL Boards (N63xx/N64xx)
>  M:     Frieder Schrempf <frieder.schrempf@kontron.de>
>  S:     Maintained
> -F:     arch/arm/dts/imx6ul-kontron-sl*
> -F:     arch/arm/dts/imx6ul-kontron-bl*
> -F:     arch/arm/dts/imx6ull-kontron-sl*
> -F:     arch/arm/dts/imx6ull-kontron-bl*
> +F:     arch/arm/dts/imx6ul-kontron-bl-common-u-boot.dtsi
> +F:     arch/arm/dts/imx6ul-kontron-bl-u-boot.dtsi
> +F:     arch/arm/dts/imx6ull-kontron-bl-u-boot.dtsi
>  F:     board/kontron/sl-mx6ul
>  F:     configs/kontron-sl-mx6ul_defconfig
>  F:     doc/board/kontron/sl-mx6ul.rst
> diff --git a/board/mediatek/mt7981/MAINTAINERS b/board/mediatek/mt7981/MA=
INTAINERS
> index e7592a7a548a..b75a5b0bfcfd 100644
> --- a/board/mediatek/mt7981/MAINTAINERS
> +++ b/board/mediatek/mt7981/MAINTAINERS
> @@ -6,5 +6,3 @@ F:      include/configs/mt7981.h
>  F:     configs/mt7981_emmc_rfb_defconfig
>  F:     configs/mt7981_rfb_defconfig
>  F:     configs/mt7981_sd_rfb_defconfig
> -F:     configs/mt7981_spim_nand_rfb_defconfig
> -F:     configs/mt7981_spim_nor_rfb_defconfig
> diff --git a/board/mediatek/mt7986/MAINTAINERS b/board/mediatek/mt7986/MA=
INTAINERS
> index ddc078a567a8..ab09615f0bcf 100644
> --- a/board/mediatek/mt7986/MAINTAINERS
> +++ b/board/mediatek/mt7986/MAINTAINERS
> @@ -6,7 +6,3 @@ F:      include/configs/mt7986.h
>  F:     configs/mt7986_rfb_defconfig
>  F:     configs/mt7986a_bpir3_emmc_defconfig
>  F:     configs/mt7986a_bpir3_sd_defconfig
> -F:     configs/mt7986a_emmc_rfb_defconfig
> -F:     configs/mt7986a_sd_rfb_defconfig
> -F:     configs/mt7986b_emmc_rfb_defconfig
> -F:     configs/mt7986b_sd_rfb_defconfig
> diff --git a/board/nxp/imx93_evk/MAINTAINERS b/board/nxp/imx93_evk/MAINTA=
INERS
> index da0540307c6a..d962cb1b7eb7 100644
> --- a/board/nxp/imx93_evk/MAINTAINERS
> +++ b/board/nxp/imx93_evk/MAINTAINERS
> @@ -4,4 +4,3 @@ S:      Maintained
>  F:     board/nxp/imx93_evk/
>  F:     include/configs/imx93_evk.h
>  F:     configs/imx93_11x11_evk_defconfig
> -F:     configs/imx93_11x11_evk_ld_defconfig
> diff --git a/board/nxp/ls1012afrdm/MAINTAINERS b/board/nxp/ls1012afrdm/MA=
INTAINERS
> index a69c268e53b7..d931383e65be 100644
> --- a/board/nxp/ls1012afrdm/MAINTAINERS
> +++ b/board/nxp/ls1012afrdm/MAINTAINERS
> @@ -3,15 +3,11 @@ M:    Pramod Kumar <pramod.kumar_1@nxp.com>
>  S:     Maintained
>  F:     board/nxp/ls1012afrdm/
>  F:     include/configs/ls1012afrdm.h
> -F:     configs/ls1012afrdm_qspi_defconfig
>  F:     configs/ls1012afrdm_tfa_defconfig
> -F:     configs/ls1012afrwy_tfa_defconfig
> -F:     configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
>
>  LS1012AFRWY BOARD
>  M:     Pramod Kumar <pramod.kumar_1@nxp.com>
> -S:      Maintained
> -F:      board/nxp/ls1012afrwy/
> -F:      include/configs/ls1012afrwy.h
> -F:      configs/ls1012afrwy_qspi_defconfig
> -F:     configs/ls1012afrwy_qspi_SECURE_BOOT_defconfig
> +S:     Maintained
> +F:     include/configs/ls1012afrwy.h
> +F:     configs/ls1012afrwy_tfa_defconfig
> +F:     configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
> diff --git a/board/nxp/ls1012aqds/MAINTAINERS b/board/nxp/ls1012aqds/MAIN=
TAINERS
> index 2178df909929..52bf79ebd6fb 100644
> --- a/board/nxp/ls1012aqds/MAINTAINERS
> +++ b/board/nxp/ls1012aqds/MAINTAINERS
> @@ -3,6 +3,5 @@ M:      Pramod Kumar <pramod.kumar_1@nxp.com>
>  S:     Maintained
>  F:     board/nxp/ls1012aqds/
>  F:     include/configs/ls1012aqds.h
> -F:     configs/ls1012aqds_qspi_defconfig
>  F:     configs/ls1012aqds_tfa_defconfig
>  F:     configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
> diff --git a/board/nxp/ls1012ardb/MAINTAINERS b/board/nxp/ls1012ardb/MAIN=
TAINERS
> index 5dd2858a86c7..dfb852f5f537 100644
> --- a/board/nxp/ls1012ardb/MAINTAINERS
> +++ b/board/nxp/ls1012ardb/MAINTAINERS
> @@ -3,15 +3,12 @@ M:    Pramod Kumar <pramod.kumar_1@nxp.com>
>  S:     Maintained
>  F:     board/nxp/ls1012ardb/
>  F:     include/configs/ls1012ardb.h
> -F:     configs/ls1012ardb_qspi_defconfig
>  F:     configs/ls1012ardb_tfa_defconfig
>  F:     configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
>  F:     configs/ls1012a2g5rdb_tfa_defconfig
> -F:     configs/ls1012ardb_qspi_SECURE_BOOT_defconfig
>
>  LS1012A2G5RDB BOARD
>  M:     Pramod Kumar <pramod.kumar_1@nxp.com>
>  S:      Maintained
>  F:      board/nxp/ls1012ardb/
>  F:      include/configs/ls1012a2g5rdb.h
> -F:      configs/ls1012a2g5rdb_qspi_defconfig
> diff --git a/board/nxp/ls1043aqds/MAINTAINERS b/board/nxp/ls1043aqds/MAIN=
TAINERS
> index daea64483d2a..9e82c2c9f20c 100644
> --- a/board/nxp/ls1043aqds/MAINTAINERS
> +++ b/board/nxp/ls1043aqds/MAINTAINERS
> @@ -3,12 +3,5 @@ M:     Mingkai Hu <mingkai.hu@nxp.com>
>  S:     Maintained
>  F:     board/nxp/ls1043aqds/
>  F:     include/configs/ls1043aqds.h
> -F:     configs/ls1043aqds_defconfig
> -F:     configs/ls1043aqds_nor_ddr3_defconfig
> -F:     configs/ls1043aqds_nand_defconfig
> -F:     configs/ls1043aqds_sdcard_ifc_defconfig
> -F:     configs/ls1043aqds_sdcard_qspi_defconfig
> -F:     configs/ls1043aqds_qspi_defconfig
> -F:     configs/ls1043aqds_lpuart_defconfig
>  F:     configs/ls1043aqds_tfa_defconfig
>  F:     configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
> diff --git a/board/nxp/ls1043ardb/MAINTAINERS b/board/nxp/ls1043ardb/MAIN=
TAINERS
> index 4df5940ab713..14ea4d2492f1 100644
> --- a/board/nxp/ls1043ardb/MAINTAINERS
> +++ b/board/nxp/ls1043ardb/MAINTAINERS
> @@ -3,11 +3,5 @@ M:     Mingkai Hu <mingkai.hu@nxp.com>
>  S:     Maintained
>  F:     board/nxp/ls1043ardb/
>  F:     include/configs/ls1043ardb.h
> -F:     configs/ls1043ardb_defconfig
> -F:     configs/ls1043ardb_nand_defconfig
> -F:     configs/ls1043ardb_sdcard_defconfig
>  F:     configs/ls1043ardb_tfa_defconfig
>  F:     configs/ls1043ardb_tfa_SECURE_BOOT_defconfig
> -F:     configs/ls1043ardb_SECURE_BOOT_defconfig
> -F:     configs/ls1043ardb_sdcard_SECURE_BOOT_defconfig
> -F:     configs/ls1043ardb_nand_SECURE_BOOT_defconfig
> diff --git a/board/nxp/ls1046aqds/MAINTAINERS b/board/nxp/ls1046aqds/MAIN=
TAINERS
> index 792531f7f3ae..86c1c7e2c81f 100644
> --- a/board/nxp/ls1046aqds/MAINTAINERS
> +++ b/board/nxp/ls1046aqds/MAINTAINERS
> @@ -3,12 +3,5 @@ M:     Mingkai Hu <Mingkai.Hu@nxp.com>
>  S:     Maintained
>  F:     board/nxp/ls1046aqds/
>  F:     include/configs/ls1046aqds.h
> -F:     configs/ls1046aqds_defconfig
> -F:     configs/ls1046aqds_nand_defconfig
> -F:     configs/ls1046aqds_sdcard_ifc_defconfig
> -F:     configs/ls1046aqds_sdcard_qspi_defconfig
> -F:     configs/ls1046aqds_qspi_defconfig
> -F:     configs/ls1046aqds_lpuart_defconfig
>  F:     configs/ls1046aqds_tfa_defconfig
>  F:     configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
> -F:     configs/ls1046aqds_SECURE_BOOT_defconfig
> diff --git a/board/nxp/ls1046ardb/MAINTAINERS b/board/nxp/ls1046ardb/MAIN=
TAINERS
> index bb5f6a64d7b4..ef5f7002002e 100644
> --- a/board/nxp/ls1046ardb/MAINTAINERS
> +++ b/board/nxp/ls1046ardb/MAINTAINERS
> @@ -4,13 +4,6 @@ S:     Maintained
>  F:     board/nxp/ls1046ardb/
>  F:     board/nxp/ls1046ardb/ls1046ardb.c
>  F:     include/configs/ls1046ardb.h
> -F:     configs/ls1046ardb_qspi_defconfig
> -F:     configs/ls1046ardb_qspi_spl_defconfig
> -F:     configs/ls1046ardb_sdcard_defconfig
> -F:     configs/ls1046ardb_emmc_defconfig
>  F:     configs/ls1046ardb_tfa_defconfig
>  F:     configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
> -F:     configs/ls1046ardb_SECURE_BOOT_defconfig
> -F:     configs/ls1046ardb_sdcard_SECURE_BOOT_defconfig
> -F:     configs/ls1046ardb_qspi_SECURE_BOOT_defconfig
>  F:     doc/board/nxp/ls1046ardb.rst
> diff --git a/board/nxp/ls1088a/MAINTAINERS b/board/nxp/ls1088a/MAINTAINER=
S
> index 85f38fcf0c72..412ddc54599b 100644
> --- a/board/nxp/ls1088a/MAINTAINERS
> +++ b/board/nxp/ls1088a/MAINTAINERS
> @@ -3,8 +3,6 @@ M:      Ashish Kumar <Ashish.Kumar@nxp.com>
>  S:     Maintained
>  F:     board/nxp/ls1088a/
>  F:     include/configs/ls1088ardb.h
> -F:     configs/ls1088ardb_qspi_defconfig
> -F:     configs/ls1088ardb_sdcard_qspi_defconfig
>  F:     configs/ls1088ardb_tfa_defconfig
>  F:     configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
>
> @@ -13,23 +11,16 @@ M:  Ashish Kumar <Ashish.Kumar@nxp.com>
>  S:     Maintained
>  F:     board/nxp/ls1088a/
>  F:     include/configs/ls1088aqds.h
> -F:     configs/ls1088aqds_qspi_defconfig
> -F:     configs/ls1088aqds_sdcard_qspi_defconfig
> -F:     configs/ls1088aqds_defconfig
> -F:     configs/ls1088aqds_sdcard_ifc_defconfig
>  F:     configs/ls1088aqds_tfa_defconfig
>
>  LS1088AQDS_QSPI_SECURE_BOOT BOARD
>  M:     Udit Agarwal <udit.agarwal@nxp.com>
>  S:     Maintained
> -F:     configs/ls1088aqds_qspi_SECURE_BOOT_defconfig
>
>  LS1088ARDB_QSPI_SECURE_BOOT BOARD
>  M:     Udit Agarwal <udit.agarwal@nxp.com>
>  S:     Maintained
> -F:     configs/ls1088ardb_qspi_SECURE_BOOT_defconfig
>
>  LS1088ARDB_SD_SECURE_BOOT BOARD
>  M:     Udit Agarwal <udit.agarwal@nxp.com>
>  S:     Maintained
> -F:     configs/ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig
> diff --git a/board/nxp/ls2080aqds/MAINTAINERS b/board/nxp/ls2080aqds/MAIN=
TAINERS
> index 3659cec4cd86..9328a084e41e 100644
> --- a/board/nxp/ls2080aqds/MAINTAINERS
> +++ b/board/nxp/ls2080aqds/MAINTAINERS
> @@ -3,11 +3,7 @@ M:     Priyanka Jain <priyanka.jain@nxp.com>
>  M:     Wasim Khan <wasim.khan@nxp.com>
>  S:     Maintained
>  F:     board/nxp/ls2080aqds/
> -F:     board/nxp/ls2080a/ls2080aqds.c
>  F:     include/configs/ls2080aqds.h
> -F:     configs/ls2080aqds_defconfig
>  F:     configs/ls2080aqds_nand_defconfig
>  F:     configs/ls2080aqds_qspi_defconfig
> -F:     configs/ls2080aqds_sdcard_defconfig
>  F:     configs/ls2088aqds_tfa_defconfig
> -F:     configs/ls2080aqds_SECURE_BOOT_defconfig
> diff --git a/board/nxp/ls2080ardb/MAINTAINERS b/board/nxp/ls2080ardb/MAIN=
TAINERS
> index 867ebe99cace..8341609b6e99 100644
> --- a/board/nxp/ls2080ardb/MAINTAINERS
> +++ b/board/nxp/ls2080ardb/MAINTAINERS
> @@ -3,30 +3,24 @@ M:    Priyanka Jain <priyanka.jain@nxp.com>
>  M:     Wasim Khan <wasim.khan@nxp.com>
>  S:     Maintained
>  F:     board/nxp/ls2080ardb/
> -F:     board/nxp/ls2080a/ls2080ardb.c
>  F:     include/configs/ls2080ardb.h
> -F:     configs/ls2080ardb_defconfig
>  F:     configs/ls2080ardb_nand_defconfig
>
>  LS2088A_QSPI-boot BOARD
>  M:     Priyanka Jain <priyanka.jain@nxp.com>
>  M:     Wasim Khan <wasim.khan@nxp.com>
>  S:     Maintained
> -F:     configs/ls2088ardb_qspi_defconfig
>  F:     configs/ls2088ardb_tfa_defconfig
>  F:     configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
>
>  LS2081ARDB BOARD
>  M:     Priyanka Jain <priyanka.jain@nxp.com>
>  S:     Maintained
> -F:     configs/ls2081ardb_defconfig
>
>  LS2080A_SECURE_BOOT BOARD
>  M:     Udit Agarwal <udit.agarwal@nxp.com>
>  S:     Maintained
> -F:     configs/ls2080ardb_SECURE_BOOT_defconfig
>
>  LS2088A_QSPI_SECURE_BOOT BOARD
>  M:     Udit Agarwal <udit.agarwal@nxp.com>
>  S:     Maintained
> -F:     configs/ls2088ardb_qspi_SECURE_BOOT_defconfig
> diff --git a/board/nxp/lx2160a/MAINTAINERS b/board/nxp/lx2160a/MAINTAINER=
S
> index abdac1372d28..945366a99861 100644
> --- a/board/nxp/lx2160a/MAINTAINERS
> +++ b/board/nxp/lx2160a/MAINTAINERS
> @@ -19,7 +19,6 @@ LX2160AQDS BOARD
>  M:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
>  M:     Wasim Khan <wasim.khan@nxp.com>
>  S:     Maintained
> -F:     board/nxp/lx2160a/eth_lx2160aqds.h
>  F:     include/configs/lx2160aqds.h
>  F:     configs/lx2160aqds_tfa_defconfig
>  F:     arch/arm/dts/fsl-lx2160a-qds.dts
> @@ -33,7 +32,6 @@ LX2162AQDS BOARD
>  M:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
>  M:     Wasim Khan <wasim.khan@nxp.com>
>  S:     Maintained
> -F:     board/nxp/lx2160a/eth_lx2162aqds.h
>  F:     include/configs/lx2162aqds.h
>  F:     configs/lx2162aqds_tfa_defconfig
>  F:     arch/arm/dts/fsl-lx2162a-qds.dts
> diff --git a/board/nxp/mpc837xerdb/MAINTAINERS b/board/nxp/mpc837xerdb/MA=
INTAINERS
> index 9b05a6ad4217..cc0a6acd8c38 100644
> --- a/board/nxp/mpc837xerdb/MAINTAINERS
> +++ b/board/nxp/mpc837xerdb/MAINTAINERS
> @@ -4,4 +4,3 @@ S:      Maintained
>  F:     board/nxp/mpc837xerdb/
>  F:     include/configs/MPC837XERDB.h
>  F:     configs/MPC837XERDB_defconfig
> -F:     configs/MPC837XERDB_SLAVE_defconfig
> diff --git a/board/nxp/mx6slevk/MAINTAINERS b/board/nxp/mx6slevk/MAINTAIN=
ERS
> index 4410358ea08c..6b8d5f2ca2c8 100644
> --- a/board/nxp/mx6slevk/MAINTAINERS
> +++ b/board/nxp/mx6slevk/MAINTAINERS
> @@ -5,5 +5,3 @@ S:      Maintained
>  F:     board/nxp/mx6slevk/
>  F:     include/configs/mx6slevk.h
>  F:     configs/mx6slevk_defconfig
> -F:     configs/mx6slevk_spl_defconfig
> -F:     configs/mx6slevk_spinor_defconfig
> diff --git a/board/nxp/p2041rdb/MAINTAINERS b/board/nxp/p2041rdb/MAINTAIN=
ERS
> index f0d5c1192ac6..d139dd518747 100644
> --- a/board/nxp/p2041rdb/MAINTAINERS
> +++ b/board/nxp/p2041rdb/MAINTAINERS
> @@ -4,8 +4,5 @@ S:      Maintained
>  F:     board/nxp/p2041rdb/
>  F:     include/configs/P2041RDB.h
>  F:     configs/P2041RDB_defconfig
> -F:     configs/P2041RDB_NAND_defconfig
>  F:     configs/P2041RDB_SDCARD_defconfig
> -F:     configs/P2041RDB_SECURE_BOOT_defconfig
>  F:     configs/P2041RDB_SPIFLASH_defconfig
> -F:     configs/P2041RDB_SRIO_PCIE_BOOT_defconfig
> diff --git a/board/nxp/t104xrdb/MAINTAINERS b/board/nxp/t104xrdb/MAINTAIN=
ERS
> index 5542530698d9..d0b5709df81f 100644
> --- a/board/nxp/t104xrdb/MAINTAINERS
> +++ b/board/nxp/t104xrdb/MAINTAINERS
> @@ -3,24 +3,11 @@ M:    Priyanka Jain <priyanka.jain@nxp.com>
>  S:     Maintained
>  F:     board/nxp/t104xrdb/
>  F:     include/configs/T104xRDB.h
> -F:     configs/T1040RDB_defconfig
> -F:     configs/T1040RDB_NAND_defconfig
> -F:     configs/T1040RDB_SPIFLASH_defconfig
> -F:     configs/T1040D4RDB_defconfig
> -F:     configs/T1040D4RDB_NAND_defconfig
> -F:     configs/T1040D4RDB_SPIFLASH_defconfig
> -F:     configs/T1042RDB_defconfig
>  F:     configs/T1042D4RDB_defconfig
>  F:     configs/T1042D4RDB_NAND_defconfig
>  F:     configs/T1042D4RDB_SPIFLASH_defconfig
> -F:     configs/T1042RDB_PI_defconfig
> -F:     configs/T1042RDB_PI_NAND_defconfig
> -F:     configs/T1042RDB_PI_SPIFLASH_defconfig
>
>  T1040RDB_SDCARD BOARD
>  M:     Priyanka Jain <priyanka.jain@nxp.com>
>  S:     Maintained
> -F:     configs/T1040RDB_SDCARD_defconfig
> -F:     configs/T1040D4RDB_SDCARD_defconfig
>  F:     configs/T1042D4RDB_SDCARD_defconfig
> -F:     configs/T1042RDB_PI_SDCARD_defconfig
> diff --git a/board/nxp/t208xqds/MAINTAINERS b/board/nxp/t208xqds/MAINTAIN=
ERS
> index 56911e8fd154..3c94352ec997 100644
> --- a/board/nxp/t208xqds/MAINTAINERS
> +++ b/board/nxp/t208xqds/MAINTAINERS
> @@ -8,11 +8,6 @@ F:     configs/T2080QDS_NAND_defconfig
>  F:     configs/T2080QDS_SDCARD_defconfig
>  F:     configs/T2080QDS_SPIFLASH_defconfig
>  F:     configs/T2080QDS_SRIO_PCIE_BOOT_defconfig
> -F:     configs/T2081QDS_defconfig
> -F:     configs/T2081QDS_NAND_defconfig
> -F:     configs/T2081QDS_SDCARD_defconfig
> -F:     configs/T2081QDS_SPIFLASH_defconfig
> -F:     configs/T2081QDS_SRIO_PCIE_BOOT_defconfig
>
>  T2080QDS_SECURE_BOOT BOARD
>  M:     Ruchika Gupta <ruchika.gupta@nxp.com>
> diff --git a/board/nxp/t208xrdb/MAINTAINERS b/board/nxp/t208xrdb/MAINTAIN=
ERS
> index db58c79c2544..aa70c2424b5a 100644
> --- a/board/nxp/t208xrdb/MAINTAINERS
> +++ b/board/nxp/t208xrdb/MAINTAINERS
> @@ -7,7 +7,6 @@ F:      configs/T2080RDB_defconfig
>  F:     configs/T2080RDB_NAND_defconfig
>  F:     configs/T2080RDB_SDCARD_defconfig
>  F:     configs/T2080RDB_SPIFLASH_defconfig
> -F:     configs/T2080RDB_SRIO_PCIE_BOOT_defconfig
>  F:     configs/T2080RDB_revD_defconfig
>  F:     configs/T2080RDB_revD_NAND_defconfig
>  F:     configs/T2080RDB_revD_SDCARD_defconfig
> diff --git a/board/phytec/phycore_am68x/MAINTAINERS b/board/phytec/phycor=
e_am68x/MAINTAINERS
> index 5e175fdb9efe..ca61746f244b 100644
> --- a/board/phytec/phycore_am68x/MAINTAINERS
> +++ b/board/phytec/phycore_am68x/MAINTAINERS
> @@ -3,7 +3,6 @@ M:      Dominik Haller <d.haller@phytec.de>
>  L:     upstream@lists.phytec.de
>  W:     https://www.phytec.eu/en/produkte/system-on-modules/phycore-am68x=
-tda4x/
>  S:     Maintained
> -F:     arch/arm/dts/k3-am68-phycore-som-ddr4-4gb.dtsi
>  F:     arch/arm/dts/k3-am68-phyboard-izar-u-boot.dtsi
>  F:     arch/arm/dts/k3-am68-phycore-som-binman.dtsi
>  F:     arch/arm/dts/k3-am68-r5-phycore-som-4gb.dts
> diff --git a/board/polyhex/imx8mp_debix_model_a/MAINTAINERS b/board/polyh=
ex/imx8mp_debix_model_a/MAINTAINERS
> index d3afa91c1188..0e07186413ae 100644
> --- a/board/polyhex/imx8mp_debix_model_a/MAINTAINERS
> +++ b/board/polyhex/imx8mp_debix_model_a/MAINTAINERS
> @@ -1,7 +1,6 @@
>  DEBIX MODEL A BOARD (i.MX8M Plus)
>  M:     Gilles Talis <gilles.talis@gmail.com>
>  S:     Maintained
> -F:     arch/arm/dts/imx8mp-debix-model-a.dts
>  F:     arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi
>  F:     board/polyhex/imx8mp_debix_model_a/
>  F:     include/configs/imx8mp_debix_model_a.h
> diff --git a/board/renesas/blanche/MAINTAINERS b/board/renesas/blanche/MA=
INTAINERS
> index 39fb93ed0836..c6d70a78ce69 100644
> --- a/board/renesas/blanche/MAINTAINERS
> +++ b/board/renesas/blanche/MAINTAINERS
> @@ -2,7 +2,6 @@ BLANCHE BOARD
>  M:     Marek Vasut <marek.vasut+renesas@mailbox.org>
>  M:     Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>
>  S:     Maintained
> -F:     arch/arm/dts/r8a7792*
>  F:     board/renesas/blanche/
>  F:     configs/blanche_defconfig
>  F:     include/configs/blanche.h
> diff --git a/board/seeed/linkit-smart-7688/MAINTAINERS b/board/seeed/link=
it-smart-7688/MAINTAINERS
> index f2186c1b9d72..5f24c9cecb57 100644
> --- a/board/seeed/linkit-smart-7688/MAINTAINERS
> +++ b/board/seeed/linkit-smart-7688/MAINTAINERS
> @@ -4,5 +4,4 @@ S:      Maintained
>  F:     board/seeed/linkit-smart-7688
>  F:     include/configs/linkit-smart-7688.h
>  F:     configs/linkit-smart-7688_defconfig
> -F:     configs/linkit-smart-7688-ram_defconfig
>  F:     arch/mips/dts/linkit-smart-7688.dts
> diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
> index 775d0f7ae83c..df745f146494 100644
> --- a/board/sunxi/MAINTAINERS
> +++ b/board/sunxi/MAINTAINERS
> @@ -50,10 +50,8 @@ F:   configs/Bananapi_defconfig
>  F:     configs/Bananapro_defconfig
>  F:     configs/i12-tvbox_defconfig
>  F:     configs/Linksprite_pcDuino3_defconfig
> -F:     configs/Linksprite_pcDuino3_fdt_defconfig
>  F:     configs/Orangepi_defconfig
>  F:     configs/Orangepi_mini_defconfig
> -F:     configs/qt840a_defconfig
>  F:     configs/Wits_Pro_A20_DKT_defconfig
>  F:     include/configs/sun8i.h
>  F:     configs/sun8i_a23_evb_defconfig
> diff --git a/board/toradex/colibri-imx6ull/MAINTAINERS b/board/toradex/co=
libri-imx6ull/MAINTAINERS
> index 6c93e35cc65f..1ceb1c8eb1b3 100644
> --- a/board/toradex/colibri-imx6ull/MAINTAINERS
> +++ b/board/toradex/colibri-imx6ull/MAINTAINERS
> @@ -9,7 +9,6 @@ F:      arch/arm/dts/imx6ull-colibri-emmc-nonwifi.dtsi
>  F:     arch/arm/dts/imx6ull-colibri-eval-v3.dts
>  F:     arch/arm/dts/imx6ull-colibri-eval-v3.dtsi
>  F:     arch/arm/dts/imx6ull-colibri-nonwifi.dtsi
> -F:     arch/arm/dts/imx6ull-colibri-u-boot.dtsi
>  F:     board/toradex/colibri-imx6ull/
>  F:     board/toradex/common/
>  F:     configs/colibri-imx6ull_defconfig
> diff --git a/board/traverse/ten64/MAINTAINERS b/board/traverse/ten64/MAIN=
TAINERS
> index 7b53e8793858..590327b8d829 100644
> --- a/board/traverse/ten64/MAINTAINERS
> +++ b/board/traverse/ten64/MAINTAINERS
> @@ -1,7 +1,6 @@
>  TEN64 BOARD
>  M:     Mathew McBride <matt@traverse.com.au>
>  S:     Maintained
> -F:     arch/arm/dts/fsl-ls1088a-ten64.dts
>  F:     board/traverse/ten64/
>  F:     board/traverse/common/
>  F:     include/configs/ten64.h
> diff --git a/board/xilinx/zynqmp/MAINTAINERS b/board/xilinx/zynqmp/MAINTA=
INERS
> index 3db240782f4d..de753c8fe4e5 100644
> --- a/board/xilinx/zynqmp/MAINTAINERS
> +++ b/board/xilinx/zynqmp/MAINTAINERS
> @@ -8,4 +8,3 @@ F:      board/xilinx/common/
>  F:     board/xilinx/zynqmp/
>  F:     include/configs/xilinx_zynqmp*
>  F:     configs/xilinx_zynqmp*
> -F:     configs/avnet_ultra96_rev1_defconfig
> diff --git a/board/zyxel/nsa325/MAINTAINERS b/board/zyxel/nsa325/MAINTAIN=
ERS
> index 013cb84b99d2..4a84d2437c3c 100644
> --- a/board/zyxel/nsa325/MAINTAINERS
> +++ b/board/zyxel/nsa325/MAINTAINERS
> @@ -1,9 +1,6 @@
>  NSA325 BOARD
>  M:     Tony Dinh <mibodhi@gmail.com>
>  S:     Maintained
> -F:     arch/arm/dts/kirkwood-6282.dtsi
> -F:     arch/arm/dts/kirkwood-nsa325.dts
> -F:     arch/arm/dts/kirkwood-nsa3x0-common.dtsi
>  F:     board/zyxel/nsa325/
>  F:     include/configs/nsa325.h
>  F:     configs/nsa325_defconfig
> --
> 2.43.0
>
