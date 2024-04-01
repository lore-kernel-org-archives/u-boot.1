Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2521CCD1292
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 10:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C4E38810D;
	Mon,  1 Apr 2024 12:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yNEOe+el";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5689882AF; Mon,  1 Apr 2024 12:54:06 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FA238803B
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 12:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4786634d1e2so418411137.0
 for <u-boot@lists.denx.de>; Mon, 01 Apr 2024 03:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711968843; x=1712573643; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yxc7FcMJLnsR7iJ6GGv+p1T6PmYM1iSOQW474HhuWos=;
 b=yNEOe+elPiqv3M/hRFBRLdQE4l1687voPYqpJBrKA79HmsZg7DE+e/3tIanFqKpLTn
 PVPPZi8at0wp7YlJVwHfGHmhs2hqeNEp2jvtSXcGyiz61vaNcblzbihnofgGtStr78Ej
 Jy0lQ+w7eNkfBJnlj70wEY2w94lo2EQ5UjOaYTOEm+w/0nSvEWdKvXoz8D4lWXzCGhw0
 vzepzgbE+Ki59ZLzuYshW6le2/dDFwKV4pIvklGyMFgeO1RxfzwWebF5LwMw4YS0b7UJ
 ZMDiZXLt/BW6vKABwqfFdH+hOX61XRBqVYGRgla81YMvcI5+gzNBOrJaQ0S3UbyNrl5y
 3gTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711968843; x=1712573643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yxc7FcMJLnsR7iJ6GGv+p1T6PmYM1iSOQW474HhuWos=;
 b=hPLfMtgqIaUzD2LJP7V8PvY0D2Zx0dscQhYNOVpUI7H4lAbo7T/jOrWAZ5O3QsN52f
 YGopq/ujRqtkc2UnbbJKXhEc4p5RHIkizKCND383/mJy5GYbrQR/3cPFLRMr0t1emQVK
 XsoJHyEET+pjJ24Q2K2Qe9FnYkuMLM0UNTOVS6GrpfwdYeQg8KGLb+S1txxuiwttLliV
 qgUtlExCZK4c6AfbQIDBWtLpu5wNJtJPb2lVlqyuG7Okv3kwkLcR52o8t1qIiTudLuiC
 5CDEikit9MGk4IA6fijl/0PrRDR1LubB9+/OG1Nucn8owHpBD9Kypkebt9/rBtVuRpgp
 kRBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+hTnTwLAvtA/POVnY2dMgJvw0ChROngqip27iRQeNijmlk1zObZs03F3r8B+PcF7bQlQaOxlWH5fwLv/NeuWprc4S2w==
X-Gm-Message-State: AOJu0YwWalR6KzVQ4SshJFY65Ktdr4bLBqqcmUZhJe3sc6Sr53Wxwe9a
 53x+UfPOpDFDcmXrtH/WqoVo6h8ieKU2PusnftJjJBQZska8hTxiKmXy0JUqUfHgn2+m5t7I7Yv
 3VloUJtLnnFOXtFlqwlThGqkkKZHCS1IEGesbsA==
X-Google-Smtp-Source: AGHT+IEB6ABwPfa/BLukOLTT2entDYeTVhb0i5IqBPlJeMOx35Ku1csHhhYVdQFtMYWRfzx9tdsEcV+ErYzHgsRk0k0=
X-Received: by 2002:a67:f149:0:b0:478:6430:a22d with SMTP id
 t9-20020a67f149000000b004786430a22dmr3129635vsm.20.1711968842804; Mon, 01 Apr
 2024 03:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <CAFA6WYPMqRQRpcN--3Mz7czh6MK10W75e19h9VWWp5P6KKbBJA@mail.gmail.com>
 <63f29606-ad3f-4883-9e8b-4d80194c12ab@kwiboo.se>
 <fc5a4ae1-21d6-4b72-a9d8-a551e3753f17@kwiboo.se>
In-Reply-To: <fc5a4ae1-21d6-4b72-a9d8-a551e3753f17@kwiboo.se>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 1 Apr 2024 16:23:51 +0530
Message-ID: <CAFA6WYPtay4Z6W7GWsJQA+ejd2XhmSkcVPnDX0xhjPrAf1essA@mail.gmail.com>
Subject: Re: [PATCH 00/31] rockchip: rk3399: Sync DT with linux v6.8 and
 update defconfigs
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Mon, 1 Apr 2024 at 15:31, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> On 2024-04-01 11:45, Jonas Karlman wrote:
> > Hi Sumit,
> >
> > On 2024-04-01 10:52, Sumit Garg wrote:
> >> Hi Jonas,
> >>
> >> On Mon, 1 Apr 2024 at 01:59, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>>
> >>> This series adds support for new clocks used in linux v6.8 device trees,
> >>> enables use of FIT signature check for checksum validation and fixes
> >>> loading FIT from SD-card when loading FIT from eMMC fails.
> >>>
> >>> After this series it should be possible to move RK3399 boards to use
> >>> OF_UPSTREAM in a future patch once dts/upstream move to a v6.8+ tag.
> >>>
> >>
> >> Thanks for putting this effort together. A switch to v6.8 tag for
> >> OF_UPSTREAM will happen as part of patch [1]. So if you want to save
> >> further effort then you can just rebase with a switch to OF_UPSTREAM
> >> once that patch [1] lands in next.
> >
> > Because this is a jump of device tree files from v5.14-rc1 to v6.8,
> > reviewability and being able to cherry-pick these changes to my
> > rk3xxx-2024.04 branch, I think it is much more appropriate to first sync
> > everything to v6.8 and then in a separate series move to OF_UPSTREAM.
> > Else it can be very hard to understand some of the changes that has been
> > and was needed to be made to u-boot.dtsi files.
>
> Also forgot to mention that these synced DT files still contains some
> minor modification in #include dtsi paths of files that is shared
> between rk3288 (armv7) and rk3399 (armv8),

I can only see rockchip-u-boot.dtsi being shared which should be
handled automatically. Is there anything else I am missing here?

-Sumit
