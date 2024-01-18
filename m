Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FD4C47DAF
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 21:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFFDE87B84;
	Thu, 18 Jan 2024 22:00:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MRsdgVhq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B47987B84; Thu, 18 Jan 2024 22:00:43 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DFA787B6C
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 22:00:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=twoerner@gmail.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-598cf18b259so49636eaf.1
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 13:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705611638; x=1706216438; darn=lists.denx.de;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EHo4xj2D4fN5dNMjVjZubHxofIwIFejnR6xqqLZP3Vk=;
 b=MRsdgVhqy6DpVI4QaKkqd21j9XEtjX/fLpGDX/5suZvQQKsA5A+RxTShGf84q/SNC6
 g7e9iY8S8pvrF5galRoaE0Ef0jzw6LGAT67HVhbCyLM36TMHeoCceK0FG6yTn3Pv60Oq
 IGhVNrdIa5dE9NOfl/tJW+L8GNPIAbfpKqp7s0/he/oOpyxeKf+tLNdBZAhhPK5ovdG/
 56t8+5pCmv1lHu52Zf8yX6Qq3uz/2Wf21uWoEniD28V0rD2Nt2QJRwwRdvTZewbMEjUs
 3QbwzA2mUR7j0olyaJkcqsAZxE51aFOL6zUZOClMb/YTBV1VsBITjkKqaBuV5lpj07ZS
 IsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705611638; x=1706216438;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EHo4xj2D4fN5dNMjVjZubHxofIwIFejnR6xqqLZP3Vk=;
 b=S2Ms5vnEhQnBIiUdQQ/yw982/ZS6PfXHQfibEDByLEjgrY8SYnSB4Du8HxkJ/Mc5Jw
 Z78NqppkOItJ/l3ho/Twc1oXN2e7l3teY3wCW7vmm+kqp3VfRYhiyQhIOTN80StPbREU
 JsmPRKjn540trCqLi9MGSJ5WQPsM8He2NG3QW6kUZcZWaqsyVrzaXmBmcQelpKCCG6cP
 rElZYVKSGg2JvvysN1SMgWnMBDO1azNKNIFuOQ65G2rQpCfBOu3k7PvjAlI4uRGMsdT8
 6++DaKEu7FXVfH1du2akeHdg7/YOHyIDCm7TaqRiIFBCFavFbEESew+GJUdxAHtc2kiH
 8HZw==
X-Gm-Message-State: AOJu0YyQt2GnWIOANSK6TUrgm20Kmsr8opbUePPoxik3gBZq/UDmHiiC
 HX6wqkjrTsK2nyGnla3hlcjpf3MbwqcHl6B5Bvi3U1Ak8NXrH2+1
X-Google-Smtp-Source: AGHT+IGApFtSNtao+brhwlRZVFmVAscm9vvJ08cTYYUvjQrXFk9+/iyLHVLf04cxlBPOQL6cY//ipA==
X-Received: by 2002:a05:6358:7058:b0:175:7908:25ec with SMTP id
 24-20020a056358705800b00175790825ecmr933748rwp.38.1705611638513; 
 Thu, 18 Jan 2024 13:00:38 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a0cfd8d000000b0067f2559fd5esm6144410qvr.34.2024.01.18.13.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 13:00:37 -0800 (PST)
Date: Thu, 18 Jan 2024 16:00:35 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>,
 Banglang Huang <banglang.huang@foxmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] rockchip: Fix ethernet on Radxa ROCK Pi E v1.21
Message-ID: <20240118210035.GA17102@localhost>
References: <20240118071949.927089-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240118071949.927089-1-jonas@kwiboo.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Hi Jonas,

On Thu 2024-01-18 @ 07:19:44 AM, Jonas Karlman wrote:
> Ethernet on a Radxa ROCK Pi E v1.21 with a RTL8211F ethernet PHY
> currently fails with the following message:
> 
>   Could not get PHY for ethernet@ff540000: addr -1
> 
> This happens because the ethernet PHY is never reset before a phy-id is
> read back from the MDIO bus.
> 
> This series fixes this issue by calling eth_phy_set_mdio_bus() from the
> designware ethernet driver to issue a PHY reset before the phy_connect()
> call.
> 
> With the driver change and DM_ETH_PHY and PHY_REALTEK enabled the PHY
> can be identified and etherent works:
> 
>   => mdio list
>   ethernet@ff540000:
>   1 - RealTek RTL8211F <--> ethernet@ff540000
> 
> This was tested with and without the DM_MDIO option enabled. Decided to
> leave it disabled in this series.

This works great, thank you! As you suspected, both boards/PHYs work fine now
work under Linux (in addition to U-Boot).

Tested-By: Trevor Woerner <twoerner@gmail.com>

> Jonas Karlman (2):
>   net: designware: Reset eth phy before phy connect
>   rockchip: rk3328-rock-pi-e: Enable DM_ETH_PHY and PHY_REALTEK
> 
>  configs/rock-pi-e-rk3328_defconfig | 2 ++
>  drivers/net/designware.c           | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> -- 
> 2.43.0
> 
