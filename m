Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD02C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 15:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADA3981FC0;
	Tue,  1 Apr 2025 17:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NCLbC9g/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96D098171B; Tue,  1 Apr 2025 17:52:32 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A3A381FC0
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 17:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-226185948ffso111435905ad.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 08:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743522749; x=1744127549; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jpmUHQJgP5dG0WB1H6xTNHyypDdXJo2ra++NRaJIojE=;
 b=NCLbC9g/ZnOYxhAhf/QYdo2bWWbVIl8UASY/5B6xoVkd+kXE7VVo68UEO4P0wLWVWz
 4wZrq6C7B5C40Us/Fe51TdDF3epZuNNZ41Y5psWHwfI/hYPzhxNvGLPfNyPkXu5Oyc10
 FLY3WOa/XH18oPbJVn7rVk9Cp1VZBzfphMA54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743522749; x=1744127549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jpmUHQJgP5dG0WB1H6xTNHyypDdXJo2ra++NRaJIojE=;
 b=m3gtWanfuOOh7rjxEpvUNa/28lEoy/OvS5XCEN07F24KHd/fqnQiDzAO1B5TVFyLAl
 zBKy8zgSR+bnK9VWa4Orc34gZwdbxKLHb7iy8h+CSqVlC87VN2y36J4dRn0aU9Wd2A7a
 WgVQwEA3y4COG4a3dozjVaSO3lPBo+UdRsni9et/VXSBzCNrxQlKT8OoBLLXgCkTDmOs
 EQyDDpkPFLr60fCzK0ttdN7cSZFW6n2tq+pPD12wU8UqsJOUE1+VG1SQk4eCD8SzDWx0
 WUA1samTDY+pSWQQ6CoJDNCzn3Lyn4WxrYp5gAwWmMzrT9Npt4wi8dBLfOp9ZxMwsIr7
 6/lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvSCn6tesCs6+dkNBSgO+9hpa9sAuqEDIjOlzU4ir3ijc2w4EomVdhZE4/MqZWmGjWJrYmYRk=@lists.denx.de
X-Gm-Message-State: AOJu0YzLBj/Ggv3/GtpoWlqMPHlLIxvFpyU0VRyhnkNVoGyKmuAIiKen
 GjoCcoFZyNO4GjWOFPqe4totKwHEk1nMpV+pKQJCdsBXWENVtyJLSxaB3Dk/WHMxfh9gxiEl58H
 ut2jMavpUIF3d9IC7+Fh+mjG3z09IOQQakUk5
X-Gm-Gg: ASbGncupisOEdtInOHCpkAAC+lcZ52SDS6g/JHCWaI0ru/jGXGDegof52DGA7QdlPnA
 aEilubgrtDbSFjA6yx/ROodmp1p4MHurulP/mRWufl0qYQ35fWPmHmbxEvQsUy5/Pbc/QfpNVDf
 poeIV3msp3Gx6kjMQqT/dojD1mld+Q
X-Google-Smtp-Source: AGHT+IHO8W/ZxeU4GbMuTgWMK2QoaWiuOF8uYpLXBHT67cc99Wdi8IpBXsRVUkqKGiRGkFz6wOHv7L8HUt8SDy04JKA=
X-Received: by 2002:a17:902:e882:b0:223:50f0:b97 with SMTP id
 d9443c01a7336-2292fa0ae06mr158168035ad.52.1743522748806; Tue, 01 Apr 2025
 08:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250401083830.2320479-1-heiko@sntech.de>
In-Reply-To: <20250401083830.2320479-1-heiko@sntech.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Apr 2025 04:51:48 +1300
X-Gm-Features: AQ5f1Jp2bgOSzvMBoHX94B-AazM-mB-0YmcCVyc_4HP_fUVuermhchsXvGjc2IQ
Message-ID: <CAFLszTihxUb8+fsFPztzx0cShG96uXb32pAQ3hyEEFE0Z+JzeA@mail.gmail.com>
Subject: Re: [PATCH] Revert "net: eth_bootdev_hunt() should not run DHCP"
To: Heiko Stuebner <heiko@sntech.de>
Cc: trini@konsulko.com, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 xypron.glpk@gmx.de, u-boot@lists.denx.de, quentin.schulz@cherry.de
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

On Tue, 1 Apr 2025 at 21:38, Heiko Stuebner <heiko@sntech.de> wrote:
>
> This reverts commit 1f68057e03206e6597ca8b2be8bb1c49d4bd47d0.
>
> Commit 1f68057e0320 ("net: eth_bootdev_hunt() should not run DHCP")
> aims to reduce EFI boot times by disabling the dhcp_run when
> checking ethernet bootdevices, by preventing it from running double,
> with the reasoning
>
>     We need to call eth_bootdev_hunt() when setting up the EFI sub-system to
>     supply the simple network protocol. We don't need an IP address set up.
>
> That might by true for EFI, but not for everything else, because when
> running distro-boot and for example the PXE method in it, nothing will
> set up an IP address now.
>
> So for example in my setup of Rockchip boards, no dhcp runs and pxe then
> fails with messages like:
>
>   Retrieving file: pxelinux.cfg/01-....
>   Speed: 100, full duplex
>   *** ERROR: `serverip' not set
>   Retrieving file: pxelinux.cfg/00000000
>   Speed: 100, full duplex
>   *** ERROR: `serverip' not set
>
> As the original commit message talks about speed efficiencies for the EFI
> side mostly, reverting this should just restore previous functionality
> (and in fact does so on my Rockchip boards).
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  net/eth_bootdev.c | 30 ++++++++++++------------------
>  1 file changed, 12 insertions(+), 18 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
