Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4C2C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 05:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A63968893B;
	Tue, 16 Jul 2024 07:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zf8R0IcA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18D4A88939; Tue, 16 Jul 2024 07:40:39 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA80088907
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 07:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5b53bb4bebaso2905249eaf.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 22:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721108436; x=1721713236; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IDV+r28rZ++trzQyTucKNTLfVwZP1Jy1mN478rdQwhs=;
 b=Zf8R0IcAFRHS5xRgrWzz+t5GDSnRU66I+Mnnt2o2FkDvhRFaeecc21R4rJA+QU7tGy
 RAYezY7ovwYwIacXWB+7y5hTLK/wKHcugY0mvAF0NYt5K5aCj8qYlc8PQplmhoxcE9+E
 DPZ9prdJaFxiGHtQ+moTcGsu+9mHJ8v8VuVRdd5+YWHVg/SfAUOZPP1sjoanIOCwb1cB
 JAyYSlRyMr/COplRMLyteatWRPt8QLin2ubhyWvAiv5fa39keFml1xsz5MtyiLHlQzv4
 C2rmWV/o6N3Hzc8dHfsvmgjVvNwxPGHe3DJSZM+cz89fPeng8BoQrqZ6fnqN0mbRhupB
 HnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721108436; x=1721713236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IDV+r28rZ++trzQyTucKNTLfVwZP1Jy1mN478rdQwhs=;
 b=dyzhD9NOC6Ck/72wh4ja5QuCXYeCfSF5EoZ+41HmbOri3e0MVVcyVtL3zol1yO1adt
 w61nGsDFygy04gFv+8MtlXcJ+EXVTrF0WJsZBSBJCE2JkEOP0+P5PxkLT28eUyY4u+z9
 ulWA19JlEDO4p90nDeLcmupSc+xB3YVH82MbVLXVqWaBWzlcv0ir8/HItubkH82KKxNF
 4tb8h8WhPr8wmYmu9DbGtFM7zSTmhUNfAaMdIpAAkhExK48xPxK7g++pj3nUkUeCZhGT
 FYyQK7TK2AgQcUM0A3t07UwkueW+myqOovYbGeDQQpKwPerUlIMO3Qoj+OBs0h7beXTk
 xrRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV78Zkfp/1Ux3OKnsQfgiGc5qxTzhOLJmVuIxtb2sKFgoWMdHwRGV7eWjpWCmuRMj7JY5CmjD9EByA+HbzNeZ9g6ovr3Q==
X-Gm-Message-State: AOJu0YxC3c7LZLG7cBVN/IUxcatVv53GSyBs0Rxpikri5qgi29CF9jar
 R91OBSO2X74+Cguyuv0BjRPnn01S91g6X3tSpzgyBdVgCOuTlsfp8nyvu8LF9wJNSXjNg0dY719
 OFrTy7j7Ku6M/vgxW7KL4cFWIV5I=
X-Google-Smtp-Source: AGHT+IF9PDKdgf8sr2fW95Xi9QplGSWeJSbIDKulb1vy2isVwpJXrHK4g06nvSTU5oTfCKMbonknv0ujIZAla0+/ig4=
X-Received: by 2002:a05:6820:2688:b0:5ce:e851:7356 with SMTP id
 006d021491bc7-5d286d18b24mr1339777eaf.1.1721108435657; Mon, 15 Jul 2024
 22:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240531141837.13189-1-linux.amoon@gmail.com>
 <20240531141837.13189-2-linux.amoon@gmail.com>
 <91a7502e-2b9d-4692-b1b0-5cbb506d00f2@rock-chips.com>
In-Reply-To: <91a7502e-2b9d-4692-b1b0-5cbb506d00f2@rock-chips.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 16 Jul 2024 11:10:19 +0530
Message-ID: <CANAwSgTJw3zsvF2h=B04rAVqR8eDq8oZouj75BUy4pJyUmeuQg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 01/23] rockchip: RK3328: Read the reset cause from
 clock reset unit for RK3328 SoC
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jagan Teki <jagan@edgeble.ai>, 
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Anand Moon <anand@edgeble.ai>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Kever,

On Tue, 16 Jul 2024 at 07:58, Kever Yang <kever.yang@rock-chips.com> wrote:
>
> Hi Anand,
>
> On 2024/5/31 22:18, Anand Moon wrote:
>
> From: Anand Moon <anand@edgeble.ai>
>
> Read the reset cause from clock reset unit for RK3328 SoC.
>
> Cc: Jagan Teki <jagan@edgeble.ai>
> Signed-off-by: Anand Moon <anand@edgeble.ai>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>
> I thing one signature is enough for you, right?

Ok, earlier the emails were bouncing back
>
> ---
>  arch/arm/include/asm/arch-rockchip/cru.h | 2 ++
>  arch/arm/mach-rockchip/cpu-info.c        | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/arch-rockchip/cru.h b/arch/arm/include/asm/arch-rockchip/cru.h
> index 9778790f34..a1499e9652 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru.h
> @@ -13,6 +13,8 @@
>
>  #if defined(CONFIG_ROCKCHIP_RK3288)
>  # include <asm/arch-rockchip/cru_rk3288.h>
> +#elif defined(CONFIG_ROCKCHIP_RK3328)
> +#include <asm/arch-rockchip/cru_rk3328.h>
>  #elif defined(CONFIG_ROCKCHIP_RK3399)
>  # include <asm/arch-rockchip/cru_rk3399.h>
>  #elif defined(CONFIG_ROCKCHIP_RK3568)
> diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
> index a62ff53c6a..86b0c02970 100644
> --- a/arch/arm/mach-rockchip/cpu-info.c
> +++ b/arch/arm/mach-rockchip/cpu-info.c
> @@ -14,7 +14,9 @@
>
>  char *get_reset_cause(void)
>  {
> - struct rockchip_cru *cru = rockchip_get_cru();
> +#if IS_ENABLED(CONFIG_ROCKCHIP_RK3328)
> + struct rk3328_cru *cru = rockchip_get_cru();
> +#endif
>
> I think we can use "rockchip_cru" for all the SoC with below define in cru_rk3568.h?
>
> #define rockchip_cru rk3328_cru
>
Ok, I will follow this in the next version.
>
> Thanks,
> - Kever
Thanks
-Anand
