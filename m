Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65FBC48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 11:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2F0287F47;
	Mon, 19 Feb 2024 12:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hMx6IcqM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 597BC87F4B; Mon, 19 Feb 2024 12:50:08 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93F2587DEF
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 12:49:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6083cabc2f9so6718817b3.1
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 03:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1708343395; x=1708948195;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lyUMpyvjPAzrqvw/rgcN9KcVd/OboH5PCbhM+XQQu5E=;
 b=hMx6IcqMv2K2mtJ8QQ8HREvT05dspmTrLGJ641cX0QZeptqMoUmuNTtFGg/RUsYSnl
 DSbzONSyTOVHfa2sWrBOfmKHPQ0zbYgX8x3EN1QnromHwr6qEuPvD8KNIkuKxqc8cMMW
 xV6nDH3Sr+Hh+/2ZK2CSUvyXX30UvskrNDhFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708343395; x=1708948195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lyUMpyvjPAzrqvw/rgcN9KcVd/OboH5PCbhM+XQQu5E=;
 b=DdGYum/9qZvwFwMm2AY15wwf10XAmccWpaFLrXn9DzQwWO3ggJyJaTqfuElFxaIJCn
 CKWNl6Y1yrcEmmaycyCYVbva9jjxGZiDpKrnDCCzFOZteYcUt8beJlXXIpFpN3vLw3S8
 vfDkepeYk0syHa/K8umhuLFSOHR6biI7q3UFsTrwfk65fRBmOlhN6jks7r8VKjyyG/Sf
 biV1ZR9/n/Ypxd41IMvzyYRV/3oqqKhyJIjBIa/jABNnLfLgLH5XjifCsEaQtOXURcwe
 SKud3YTrrYqaUW2w/4uWZX+BRrjp9aTcZqpkRv3Almz1e9UDT7BNcAs9QmybcmFGQShD
 je+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIuIXL4NNYBYmnQcBgFT/1leuxSPxiaykvITP0z7B3ejIrGfrS1/yO9O1+sGsN6v0E7qOA/KdqlSgFRYz1Ipv7hZ0bpg==
X-Gm-Message-State: AOJu0YzDy9gIQ0Z4cAslmfuT+5WKmninN8aNTugOerLePh7oOakgBCbG
 6uXl/EVwTl+IEhpdMxraN3B5RiLI+STvdzsNAPwT6ilbrYWVmYqWRqKwbot5cOda3jWvgVAU2Cx
 ep/jHHZ92sG6Z1RB/ESXqzdU8aIxxuU/3iES0bQ==
X-Google-Smtp-Source: AGHT+IGYKrmT95fNAatsz3p9eYktPMvt0+CqdrAFopZOsrou+/7/l8V5aGdPSQX9SzHSIVomdT0ubs6ya910jZ+mNE4=
X-Received: by 2002:a0d:e2d6:0:b0:604:e15:81a with SMTP id
 l205-20020a0de2d6000000b006040e15081amr10329984ywe.52.1708343395262; 
 Mon, 19 Feb 2024 03:49:55 -0800 (PST)
MIME-Version: 1.0
References: <20240117075154.58747-1-jagan@amarulasolutions.com>
In-Reply-To: <20240117075154.58747-1-jagan@amarulasolutions.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 19 Feb 2024 17:19:44 +0530
Message-ID: <CAMty3ZACUq6_hf_y7uM30EVmaVGtnqRH01sDWwZgKMNoLXw=CA@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] video: dw_hdmi: Support Vendor PHY
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>, Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de, 
 Jagan Teki <jagan@edgeble.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Anatolij,

On Wed, Jan 17, 2024 at 1:22=E2=80=AFPM Jagan Teki <jagan@amarulasolutions.=
com> wrote:
>
> From: Jagan Teki <jagan@edgeble.ai>
>
> Unlike RK3399, Sunxi/Meson DW HDMI the new Rockchip SoC Rk3328 would
> support external vendor PHY with DW HDMI chip.
>
> Support this vendor PHY by adding new platform PHY ops via DW HDMI
> driver and call the respective generic phy from platform driver code.
>
> This series tested in RK3328 with 1080p (1920x1080) resolution.
>
> Patch 0001/0005: Support Vendor PHY
> Patch 0006/0008: VOP extension for win, dsp offsets
> Patch 0009/0010: RK3328 VOP, HDMI clocks
> Patch 0011:      Rockchip Inno HDMI PHY
> Patch 0012:      RK3328 HDMI driver
> Patch 0013:      RK3328 VOP driver
> Patch 0014/0017: Enable HDMI Out for RK3328
>
> Changes for v3:
> - updated phy_ops logic
> - tested in BPI-M64
> - updated handoff logic for rk3328
>
> Changes for v2:
> - Use proper cfg function for meson
> - Add VOP cleanup code.
> - Add DCLK get rate
>
> Linux VOP/HDMI out issues seems resolved with explicit WIN0 disable.
>
> Any inputs?
> Jagan.
>
> Jagan Teki (17):
>   video: rockchip: hdmi: Detect hpd after controller init
>   video: dw_hdmi: Add Vendor PHY handling
>   video: dw_hdmi: Extend the HPD detection
>   video: dw_hdmi: Add read_hpd hook
>   video: dw_hdmi: Add setup_hpd hook
>   video: rockchip: vop: Simplify rkvop_enable
>   video: rockchip: vop: Add win offset support
>   video: rockchip: vop: Add dsp offset support
>   clk: rockchip: rk3328: Add VOP clk support
>   clk: rk3328: Add get hdmiphy clock
>   phy: rockchip: Add Rockchip INNO HDMI PHY driver
>   video: rockchip: Add rk3328 hdmi support
>   video: rockchip: Add rk3328 vop support
>   ARM: dts: rk3328: Enable VOP for bootph-all
>   rockchip: Enable preconsole for rk3328
>   configs: evb-rk3328: Enable vidconsole for rk3328
>   configs: Enable HDMI Out for ROC-RK3328-CC

Any comments on this? Or is it okay if I send a PR for this?

Jagan.
