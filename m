Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE12C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:01:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 992914068F;
	Mon, 24 Aug 2026 08:01:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V6rF2HxjwANN; Mon, 24 Aug 2026 08:01:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787558494;
	bh=UWnNrnrpcDBWrIDZBVLWPG2tnxkl6nfF3sBwGPtCml4=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sXj3nUo5BfJrgNrpTf4As3GtFfrzMNf9xqxNJREWS4mXJOn725+TOiv6bkneiaOkG
	 O+ETL84y50XE1blnuF05sZsLKXB4L6gNrXF8kAaSrRyV8nUJS/lTRj9Gsgdc8jlpLn
	 k79eGpPddwYgJOkEmcL4rBmfnMUSKPJHLA4PeAoD7DxVUcz48J58udyOEuJkUX/khf
	 g+n2d6RcYIJswva9zh8v1g5nrk6cPVmyOIrvImiiFC7qWbKbdA25TGeCOJZtRQaH41
	 Xrq646+/2+gQrgTO+z6APsc78eht3MmZqPkbF4BYzwzeK1Q22+BEzg+AnrMxyxrRJg
	 RcXB+iPeZ/qqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94B9E4065C;
	Mon, 24 Aug 2026 08:01:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C0A9B396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A65824065B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:01:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CU3oF7E_ET9F for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:01:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LPTNDEi5
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7CA354065F
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:01:31 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a1f56768baso473279a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787558490; x=1788163290;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UWnNrnrpcDBWrIDZBVLWPG2tnxkl6nfF3sBwGPtCml4=;
 b=LPTNDEi5g7v63Ysxu6XzldPsGlCrN0utnlUlsqV4RqEZkb1/Ba0Lc+1LJP7sKVQ2Te
 8TZAALx6vyOc7REIwZYPTqwaiJQ4AOUjQB+2LhaZCgCq/b3pLqUr9U51vgf7GzDR0H3F
 BEVy6aJWX2+emOlWgFKYLF5J3dcU0k0I4jQCev86A0JTAOBJZMy1vimxPk17OXR+/g8H
 SaB/VvKVdgo4prsLiNQzfKxrA4h0yzAc+kmt3w6sKrB1actn2ObPyXw+//LxB2F0TIqG
 p5/JyPqC6VkD5zuQXacypcGz5Ek1QmeZ08WZdRKF0CnRx60FB4agOp+e3X0yAeoCmgmf
 l/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787558490; x=1788163290;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UWnNrnrpcDBWrIDZBVLWPG2tnxkl6nfF3sBwGPtCml4=;
 b=GPXFTnRecoXQuImLaPEdJP+xg1TeTVjD8Nfz4rh3/TN7QORZfgu9QSDc68oP1Agfdv
 /X20aa3lZ4nFOwVLdVEyjCAthOg/GhWT0GckQ+b2hzwy2m4cLiTTWBirE8OWEH82Ttr7
 GsRU1mPkx4XKPjlVQDJEvVvuk5uLslxkgLUohfAx10vB4CouKwYy1Y2LELiUzn9It4OG
 ULZDt6o58PMANZNXaJuvRWHC5WJQzOnhoPnDz/+r7p0Hvnk42Veoa8LXu6eMPrdq7ZbC
 wZK3Smy4PAUZ6QJ0+ASf2z0cuHz0mWs6W3dLQCtdrGsu2cSAeaN1+9X9ZgtzZ3bwWmkf
 BjRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGCY/2RSfTzBcC7gMlkq7TKKCqjeKuq4e++cxmKhCZ9XYNQP25YJE8JbvCjZgzAxuA5VMAQA8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kmfzT62GoBx+d+5oOZn3i6XyaEpn9k/k7A2P2zC7QexPxh8vJ3
 mG0mLxIwT6pfprQ8YSr83rpG+M++NQpyqxMdBlLwTwBRtnfNUzaci1Wp
X-Gm-Gg: AR+sD12CCMYPIcjhRgpvWEqhMmjORNHW5ADnZfy/HxfEaXKyPgKdnLzGZxBTwysUSYf
 O04fN7xfrfZbrIUt2Ok7QqEpXHQDZ2o1KtK/Q9hViuafkLfmDFrTSwSIaqhbE5MKabmnjlfy3zO
 1pujNocVCLzL7quE+0VAKDApETwcuuR1SsQnqchQOwx0PgYdBdgzOuwZQrYSbYN5Z5WcKMwvRcg
 pFwzBkUkByqeBxU3+IrAfNfvXHgowgmJl/+QgdHqX7H2D1ubHmZdhK0afINfd+22arUPSuOCLF9
 sghpR51Rqq12BCXNx60RhRLVw5lvEC7z9YdmzqkHul/tszGywDeBUV7bCQlhJVFYrG5D0SeVL5T
 37NDFePMQnFqfRvU4d5F24f2CbepFoI6oh28GVDg+O3w+yC8uzNeZTldldOcOPnLPPOEAsJVohp
 PSU4+vn6B1rGlKnnpBUdbdcQlsvx9A0EANYF2gE388FYBoccbA/UzDQXQIbvAriloLUvmv+1Li9
 tJ2Nkpg6aUjF1tJ5pe5DJSnb1Y=
X-Received: by 2002:a05:6402:5186:b0:6a3:eb13:e74c with SMTP id
 4fb4d7f45d1cf-6a42f1a8bfdmr16141480a12.1.1787558489597; 
 Mon, 24 Aug 2026 01:01:29 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e2e2826sm7158941a12.31.2026.08.24.01.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 01:01:29 -0700 (PDT)
Message-ID: <6ae0a139-cc0b-4d58-958b-50564f357cfd@gmail.com>
Date: Mon, 24 Aug 2026 10:01:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>
References: <cover.1787555916.git.michal.simek@amd.com>
 <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
Content-Language: en-US, ar-EG
From: Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi,

On 8/24/26 09:18, Michal Simek wrote:
> A number of file (F:) entries across the MAINTAINERS files pointed to
> files or directories which had been renamed or removed over time. Drop
> these stale references so that every F: entry resolves to an existing
> path.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
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
> [..]

> diff --git a/board/coolpi/genbook_cm5_rk3588/MAINTAINERS b/board/coolpi/genbook_cm5_rk3588/MAINTAINERS
> index 0496cc93b599..8f677f3170b2 100644
> --- a/board/coolpi/genbook_cm5_rk3588/MAINTAINERS
> +++ b/board/coolpi/genbook_cm5_rk3588/MAINTAINERS
> @@ -1,7 +1,6 @@
>  GENBOOK-CM5-RK3588
>  M:	Andy Yan <andyshrk@163.com>
>  S:	Maintained

> -F:	board/coolpi/genbook-cm5-rk3588

Change dir name:
board/coolpi/genbook_cm5_rk3588/

>  F:	include/configs/genbook-cm5-rk3588.h
>  F:	configs/coolpi-cm5-genbook-rk3588_defconfig
>  F:	arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi

[..]

> diff --git a/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS b/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
> index 79981aa43f13..0c7906acc992 100644
> --- a/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
> +++ b/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
> @@ -1,6 +1,5 @@
>  ORANGEPI-5-RK3588-ULTRA
>  M:	Niu Zhihong <zhihong@nzhnb.com>
>  S:	Maintained

> -F:	board/xunlong/orangepi-5-rk3588-ultra

Change dir name:
board/xunlong/orangepi-5-ultra-rk3588

>  F:	configs/orangepi-5-ultra-rk3588_defconfig
>  F:	arch/arm/duts/rk3588-orangepi-5-ultra*
