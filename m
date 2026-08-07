Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7977FC5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 13:54:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E32E460A78;
	Fri,  7 Aug 2026 13:54:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mCdljRqdmZsm; Fri,  7 Aug 2026 13:54:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 04C6960907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786110847;
	bh=QBCKUnEc5Kw9SFVF/5GgSYU/jQut3YOVwb3RvZbSuFc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A4xkygEdungWKJ3c5KciAKKKA1TWRoUGZMXx6atdH0XD7O3UW4XGWPXEUVo45Kd45
	 8nlj7wTH1+poDKRG1bjTkKEpScYUxud0Bfn64IL00WilBnRhE9aSi6h+NZVUsX8uKg
	 6mxXUlc2+VhxXf/lGFkxWEv1l0mltTmmzBoMvjcCc3v33QOPChnQQbc0q2UChpI+Sq
	 ap/VZU9rcWyLEAHvyRMrorXKiKuiJGHig/DcQj6PBHodinE1QVfaS9ht9MP1F6o/AX
	 WtoNzKEOmn3PZ+Vud+kNpv/JJZiKIGt+8qCU0iQMB10o9q1L7AJojDQ4RC6ZZqx2I2
	 uSNQqjiFBipPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04C6960907;
	Fri,  7 Aug 2026 13:54:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DCE54259
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:54:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE79D812E1
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:54:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MHP5hAdjZp11 for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 13:54:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 92AF1812D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 92AF1812D4
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 92AF1812D4
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:54:03 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so104660266b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 06:54:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786110841; cv=none;
 d=google.com; s=arc-20260327;
 b=T1aOZ+HchOZ3VgCgomYa/SUqbntEX61PDeSU2Z+ysBaUgpVoBAX525ySXXJoDu1Wsm
 vyhapWr5VQ686J3V305CQbDNSPbUHzqNTnki7llfkVEDrKaDD5Q7zj8OCtDrNRHW0Qkn
 SNOMWUGkc+2/D4rSR1isiInlFzjDCp9mUPu7XB+Af2Rfh9PFiZUL/ocdDb7/xCDO4vkC
 CFScpyBn/JaeBA7DPvpd5FbayYTaQ2/wU1r538bDwhpLGcX7Y/LEYNvRWIvKE763k6sk
 0ABqcg9rWU7/9iO7OAOeIVmER/s/cVLO+zUCxcZjlgR2ZdFLIgc+aQDm4T2Y+rEDAURi
 rcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QBCKUnEc5Kw9SFVF/5GgSYU/jQut3YOVwb3RvZbSuFc=;
 fh=okTAUjIOwGbOfzJ0e0NYVxNRMKmCHhX7rWLChO4J1WU=;
 b=dZ3YVaJo4JEpJXd/AMuhhkN6SW09T9kl/aCL0UrUQcW7oqpke9hVzgkXKOgvI+a09d
 SCnT/iDFzkJCdeongHro+2UAQ4MTYqmEvfgXy62dtSaHYTY5HRmX8oiaC5r+u31JIlJK
 x0fiu9jsEWzE5xUb0i65a81eiTmCb+yTyz3KVF6aU8/ZNgFq1BcX/ru0Yx7arQ4yUNMN
 gqj/drSeVRyV2mdMvbZs26WCFnN1mm3qPMmuDZJN7w7voWGd9RyKKGYquohmwUBnd5fB
 omL5Mu/sR8LUiA7BbAG/R6jbmsBIHOM/qSmSUOlkze7ecW3KPhv1wD1YCWqbcxN0BLe8
 0lrg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786110841; x=1786715641;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QBCKUnEc5Kw9SFVF/5GgSYU/jQut3YOVwb3RvZbSuFc=;
 b=Ylz+0jxSSZ3ng3a2wqFWbTpc6n7JQ9b1BofxCM58PbO+U41TN9prb0zkwyZE26rlrI
 Ucy/xfYNc6UAk69N4H6oFyghqVnCM+2BNNwmOfOmPNv1HK8uckf4xhenSgosbqoUa/6D
 iK62wvENb2fGNZ3S24nz42EQaDpuEHkZ/m0PoTwXBmgmtohrpFcCp8s/JJOX+ZP8o0X7
 Rw9SgEajxmKuUz6wA3ilzETCBdy9iwThMfjmzf7XNzQXn5ZcGnyp43S1ytXx2Epf1XZv
 s+lmotlCZyoqcnjO/VV0nWgMiRUL8PzZ8hqg0cNp4tb8WuVkKZ1QbzIJKvY9XKXYczuS
 hu3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzaIlhyySpNmf7MkajvYK3iO304DGhV7miRkQ0dmp8t52hM9Gcj7eZkmq11zYvP87/ZmBxthw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yypt0WZRXp7vnl3RYWgAh1NJcdNk1XoiXvfHPz83Jkd2+Ltlfra
 yq/kJJ5CyiNmzN3btXc7ywgwocRb8rsnj2dGf08hrqo+V4G2RWMt9G0NNwQCvnCU3fi4H3E1p4m
 30C8dZHsmyCO8En8k6RHRWiMlUFoPInELPCMvfvcRkA==
X-Gm-Gg: AR+sD13Bw77eZRxMAfn0af54g55QGZ0OaEOKgo20PSbrCJoo3jEJjoEfF6jFD+As0hb
 tD0pGg4W2NVmw2WaTaIUAsoSgMesnWu2dHeFOrmu9ADpmwQ0gBWmZM1GouZOvLEfyliX4ARo+pI
 J+1EmdN1zncuoSeiq0SJm/Zgoaa2S3UkvOUKWH3XHfNeaFV0ng3I/u8smqNgPIRQtdbAEvp3J3M
 9WgGEy4AmHj4YGyDrP7HHh5N6khxYk3Ktf8DJqLS3mSqXgQdQqAYmzafWjvDY8hROHOh/aTPUR4
 4d+bg2PacH0gr0Xdws60ZqU4HfjCgNbOdiZIAW4K6/2mLQeDqZjwhLsYBWpX1U0/phVPkfh+b28
 X5Bk3a9NDrWBgVRWkXt2orBfTp+hUYKtpyYUd7i/wdHF/imKVwXW0QCwesDeCnFM=
X-Received: by 2002:a17:907:ea87:b0:c12:5a0e:3e0 with SMTP id
 a640c23a62f3a-c2039ef01b6mr1107707566b.19.1786110841248; Fri, 07 Aug 2026
 06:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com>
In-Reply-To: <20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 7 Aug 2026 15:53:50 +0200
X-Gm-Features: AUfX_mwg-ZQvQ965zCVf3VYXNrUaXFsGCO9TnElCafORxklYj2j_pPBsigyHYbA
Message-ID: <CAEHHSvb1PhXXiRj-fdWKQghsF428K+Y1K4uBDaYXHR88ja_LfA@mail.gmail.com>
Subject: Re: [PATCH 0/6] arm: mediatek: Genio 360 EVK bringup
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Irving-CH Lin <irving-ch.lin@mediatek.com>, 
 Deep Pani <deep.pani@mediatek.com>, Chris Chen <chris-qj.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786110841; x=1786715641;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QBCKUnEc5Kw9SFVF/5GgSYU/jQut3YOVwb3RvZbSuFc=;
 b=axalVtbuCKq7BeOH+xsOFoBV5K2tdkhQDby+Lbb6AGND20GCh7fnmdOUXDaWEFmxF3
 POq44DxLuYiAgmZDe2OSUR/4f5PJIivE3o15ou/fVKB5aKRJ4D/OmNQQF5dyZhzKDzp+
 cnj2rvzq90XNz36jUOihGRFI/A52JjTMYcKaPGxzxJ35ADWGoQkijBWpj4BVeUr3dRo0
 4cKU3SAzoFTB31ZQVro8owsQ9zwq5bd1XOevKV3lUV0V2/t+Q3A/SgCkiR0HRxoOFml6
 PEILG0Hj2+dnNio8fJesY3jj/bXc1XXU2RvrchLn0Yyt40hxd4YR7WxwXkCred2J2I0Y
 cZPQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=axalVtbu
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Le mar. 4 ao=C3=BBt 2026 =C3=A0 01:21, David Lechner <dlechner@baylibre.com=
> a =C3=A9crit :
>
> This series is doing a basic bringup of the MediaTek Genio 360
> Evaluation Kit board. This contains a new application processor
> (MT8366) that hasn't been seen in U-Boot yet, so basic support for
> that is added as well. Clock and pinctrl drivers were sent as
> standalone patches.
>
Hi David,

I already did the review of clock driver but I realize that it should
be part of this series (or at least depends on it) for mt8366-clk.h

> There isn't an upstream devicetree at this point, so most of this is
> picking up the downstream devicetree along with a little init code
> and a defconfig.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Chris Chen (1):
>       arm: mediatek: add MT8366 application processor
>
> Deep Pani (1):
>       dt-bindings: pinctrl: add MT8366 pin function header
>
> Irving-CH Lin (1):
>       dt-bindings: clock: add MT8366 clock header
>
> Macpaul Lin (3):
>       arm: dts: add MT8366 application processor
>       arm: dts: mediatek: add Genio 360 EVK
>       board: mediatek: add Genio 360 EVK defconfig
>
>  arch/arm/dts/Makefile                              |    1 +
>  arch/arm/dts/mt8366-genio-360-evk-common.dtsi      |  405 ++++++++
>  arch/arm/dts/mt8366-genio-360-evk.dts              |   14 +
>  arch/arm/dts/mt8366.dtsi                           |  662 ++++++++++++
>  arch/arm/mach-mediatek/Kconfig                     |   12 +-
>  arch/arm/mach-mediatek/Makefile                    |    1 +
>  arch/arm/mach-mediatek/cpu.c                       |    3 +-
>  arch/arm/mach-mediatek/mt8366/Makefile             |    3 +
>  arch/arm/mach-mediatek/mt8366/init.c               |   58 ++
>  board/mediatek/MAINTAINERS                         |    8 +
>  configs/mt8366_genio_360_evk_defconfig             |   25 +
>  include/dt-bindings/clock/mt8366-clk.h             |  342 +++++++
>  .../dt-bindings/pinctrl/mediatek,mt8366-pinfunc.h  | 1069 ++++++++++++++=
++++++
>  13 files changed, 2601 insertions(+), 2 deletions(-)
> ---
> base-commit: 54930fd153a443a67fe56b89df16541048132513
> change-id: 20260729-mtk-genio-360-bringup-de3bedc2ec94
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>
