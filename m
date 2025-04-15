Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736CFC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 22:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9DE482C7C;
	Wed, 16 Apr 2025 00:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bfhEmiOU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48C4C82C7F; Wed, 16 Apr 2025 00:46:40 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 490F382C4C
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 00:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sbellary@baylibre.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2264aefc45dso91228635ad.0
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 15:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744757196; x=1745361996;
 darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jzJ0Rwf0DrkqLknqoXdzwUHIJI7/0kFzstpVsbkLgYs=;
 b=bfhEmiOUcRdb0MO34+TFS2w+1BjWwv752a7WOvhVI1rkUjo0uxPddvQkfxI+mD9ety
 dpWAAqlXAeMcGiMw4QD47Srs+ErET51vPrFt/baL7Bv5hr4eztqfGccivH7mZrfPoopv
 oc8df+wV86siBDdMXaJo9HEdGwEhvx/cnfzo4OZVcqLLsoEW0gn0T2N1Raszg0ZYB4kt
 ghjr5u+ZSKrP46Agh/19qON1ZL+wNmmi73VEJwT/Wa1vZLGT2r9sLpO3qgG4qZZoq1y3
 XQMW7CYqM2ei4iQeah7/gTE4tKiYs2XLouot4Qruil7Qb8KRvbFSyO3QsTq8bjwKeaFO
 TezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744757196; x=1745361996;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jzJ0Rwf0DrkqLknqoXdzwUHIJI7/0kFzstpVsbkLgYs=;
 b=WIN8V3cNhH4kpx1zrTXwPIo2mIEkrFXeAhRHSpUqAeoOSR1gS1+kwF5zTIT8BW/l1+
 YO7JAkNzU+1O7iCXbeRbOYm7L3tNRKtOvEjYBVISriBHx9F4oDcK2XvlOKUYMxYA9FIg
 EdTkTR57LqomNhm4bGw0phBq2xgo8qyWg/lClUcefvmT5R3lITyXiRxMigD7pug3H0Zx
 3ohSlSZBbzIOsEq9oGMz+KINPEV9LsFXZjNKsYHgBNJ+Nyp2ZYWTvUF19zM28xCfphgH
 2hDYS1fYXSV/ZA6EdT37Dfm3Fr39qUv98D3itWHmjRO29NmMoGENjhXq8wARhTThYcB7
 BXhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvHxBplJvyFBlGHbpQXewuk3yVc6Ewl+V1KhpWrbjozcRKEazyPylHUhwqaydsjq8FlNIpN+A=@lists.denx.de
X-Gm-Message-State: AOJu0YxT1G2VooZcZTL3CT12XJxaClLm4ClgxY7MLjbwpsmSE4rdZ2ER
 TxSwsNvvS4Hm27lJCHP3NeYYIUIgeMueyf1U+ZsIPZKA5L3ggcBckzneJrGts44=
X-Gm-Gg: ASbGncvEyFdrPrboKyfBM4g0kwWKXKi9G9/kiMIOhZwEBwZa8PY2HaI17JKS9hn8bru
 +FbFtGKywffdnSpkVF28ZvfnjgsMwFauxTqfK3ltzrodDq1unULla33Tkw0gvmNBnidl/F8YRRC
 cv14OO1hcCcebIDqjgLqZJ156WLkGWnHfKn8ER+Y0fwPX2ypzUHCzaK0ogW+82JFUiTGtE92t0f
 0y1WTVlSY2IMcJ5Tbr0FGqNITMze/Vm1Xk0szobGKAA/p8pFLT44VhUylQr6NlDRAXeXSQgvon6
 yqOwXien5l4IMqJcwiid68wucYrmSG2NDMCIeZkBEiQAV8KPr/0tpoBxVGSvlsMQl1Ell19/eJS
 w
X-Google-Smtp-Source: AGHT+IGGwMbl56PmkqDeX2KkZGgr/Z/EmKnkpRHxEKWExaqQuWaar2KeeLri/HLQH2Ri2ghA3QxvZA==
X-Received: by 2002:a17:903:192:b0:224:26f5:9c1e with SMTP id
 d9443c01a7336-22c318a8ee0mr11164405ad.2.1744757195821; 
 Tue, 15 Apr 2025 15:46:35 -0700 (PDT)
Received: from dev-linux (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fe7105sm569845ad.230.2025.04.15.15.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 15:46:35 -0700 (PDT)
Date: Tue, 15 Apr 2025 15:46:32 -0700
From: Sukrut Bellary <sbellary@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] arm: dts: am335x: Add nodes for lcdc, panel and
 backlight
Message-ID: <Z/7hyM22GguAlnx+@dev-linux>
References: <20250319202516.3300444-1-sbellary@baylibre.com>
 <20250319202516.3300444-4-sbellary@baylibre.com>
 <20250324172009.GB93000@bill-the-cat> <Z+MEeuDZNr7z0mZh@dev-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+MEeuDZNr7z0mZh@dev-linux>
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

On Tue, Mar 25, 2025 at 12:31:06PM -0700, Sukrut Bellary wrote:
> On Mon, Mar 24, 2025 at 11:20:09AM -0600, Tom Rini wrote:
> > On Wed, Mar 19, 2025 at 01:25:16PM -0700, Sukrut Bellary wrote:
> > 
> > > For AM335x EVM[1], enable nodes required to enable the support for LCD
> > > and PWM backlight.
> > > This is required for the splash screen support.
> > > 
> > > [1] AM335x EVM - https://www.ti.com/tool/TMDXEVM3358
> > > 
> > > Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
> > > ---
> > >  arch/arm/dts/am335x-evm.dts | 15 ++++++++++++++-
> > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > Can you see how hard moving to OF_UPSTREAM here is first please? Thanks.
> >
> 
> Sure, I will check.
> Thanks.

I checked OF_UPSTREAM for AM335x.
For the panel driver, timings are fetched differently in the u-boot and kernel.
For OF_UPSTREAM, we need to change the lcdc panel driver in u-boot to be in
sync with kernel dts or see if we can reuse the simple_panel driver.

We plan to take care of OF_UPSTREAM later.
So, For now, can we split this series into two as
1. Enable Auxillary PWM using eCAP and pin muxing(These are independent
of OF_UPSTREAM)
2. Handle dts changes once we have OF_UPSTREAM for AM33xx.
If this is ok, I will post the patches per pt.1

Thanks.

> > -- 
> > Tom
> 
> 
