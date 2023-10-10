Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9957ECD80B0
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 11:39:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC65F8693C;
	Tue, 10 Oct 2023 13:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="NaP5Xy/I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CEAA8690B; Tue, 10 Oct 2023 13:39:31 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C625E8693C
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 13:39:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: aace31a0-6761-11ee-91e6-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id aace31a0-6761-11ee-91e6-005056994fde;
 Tue, 10 Oct 2023 13:39:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=dqnWCVbSuMkyxVWUsUtDUokm9lMLUbwOSl2nwdBkp2Q=;
 b=NaP5Xy/IpyQN4DUhK9gskQTDx5SZ4OHcQebhemglZAvWWN2hyOuewuVtoZHhji1GgAXeI7YRS+WPx
 PSgn41pAmf3HyohClTRH/fBNDwlNMJYLxTKvSDNMNXgT/4nE7/NxoOjtNuL23Asn9KSZG8rSCO7g1M
 XqEBlfB7hFIB7+MHbxkcZoqPISGdjYv6iCGRaxpTYHgnFlCd4d2aowk1p1EAKjFXotHrP/WN9Vvfla
 aQ0HfVJDEvMqiaErPBVqeiqJZLbL02j+WJI0bXcr4jzC9V1imkqIy7McZUaK7F7obEU6Z3/qKut4er
 TgOcW/jP61MmXdO1zO4mfU/ZGFdNKxw==
X-KPN-MID: 33|2GIEcFsBu4N04mZkbzgk0KedTM5re3cuuZZEwA/YoSt0ZzFe2IHQI0Wnodimi+3
 ru6rjZWWkJ7PY5XVnhP/JljlChg1kcQoxX+2R4eCBorM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|n/WJu+GnuUjAsUzkmKnkPAdKSxKMybK9jNtKFfJZCRSowzcA0HyXjFxvn4LDwWJ
 P16WHvOxKfUEEkkfmnVMsxg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id aa4073d7-6761-11ee-ad2d-005056998788;
 Tue, 10 Oct 2023 13:39:26 +0200 (CEST)
Date: Tue, 10 Oct 2023 13:39:26 +0200
Message-Id: <878r8ahfkh.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: lukma@denx.de, seanga2@gmail.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.denx.de, chenjh@rock-chips.com, zhangqing@rock-chips.com
In-Reply-To: <20231010085155.31027-2-zhangqing@rock-chips.com> (message from
 Elaine Zhang on Tue, 10 Oct 2023 16:51:49 +0800)
Subject: Re: [PATCH v1 1/7] rockchip: dts: rk3568: Resync from kernel-4.19
References: <20231010085155.31027-1-zhangqing@rock-chips.com>
 <20231010085155.31027-2-zhangqing@rock-chips.com>
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

> From: Elaine Zhang <zhangqing@rock-chips.com>
> Date: Tue, 10 Oct 2023 16:51:49 +0800
> 
> Resync from kernel-4.19:
> (a6cf6aca12c0 drivers: rkflash: Ajudst the dll strategy)

Linux 4.19 is ancient; why are you not synching from 6.5 or a 6.6
release candidate?

> Change-Id: I7b7134946b76dbd8963cfaafdc5b56750622855e
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  include/dt-bindings/clock/rk3568-cru.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/rk3568-cru.h b/include/dt-bindings/clock/rk3568-cru.h
> index c1942422a438..251445cf7632 100644
> --- a/include/dt-bindings/clock/rk3568-cru.h
> +++ b/include/dt-bindings/clock/rk3568-cru.h
> @@ -478,6 +478,13 @@
>  #define CPLL_50M		415
>  #define CPLL_25M		416
>  #define CPLL_100M		417
> +#define SCLK_DDRCLK		418
> +#define I2S1_MCLKOUT		419
> +#define I2S3_MCLKOUT		420
> +#define I2S1_MCLK_RX_IOE	421
> +#define I2S1_MCLK_TX_IOE	422
> +#define I2S2_MCLK_IOE		423
> +#define I2S3_MCLK_IOE		424
>  
>  #define PCLK_CORE_PVTM		450
>  
> -- 
> 2.17.1
> 
> 
