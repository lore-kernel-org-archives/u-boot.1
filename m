Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77674D41D41
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 14:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA4978389A;
	Thu, 11 Dec 2025 15:14:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FvGtHAO3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADDAC839DE; Thu, 11 Dec 2025 15:14:18 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92F628312A
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 15:14:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6496c4ed38aso200172a12.1
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 06:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765462456; x=1766067256; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Quf//nawr91qVjpDUM81lB+EUItw06tEVljMWzee2l4=;
 b=FvGtHAO3eWiDF7LvM1iTKsXSGfn4XDZ3NscSqVcsWKALVEEyWzWQQh+0ki7jTYlBYg
 ffTJzmcMxXkOlFutaeoOkDnwQOWnNtdpgtcYjXMzzs9lco3UhZdlNpfv5yUTAvMJOoOo
 qw3PVxvbNZCIdhgTzDjih+IV1jG5zcGZYHgIiaz2Y5XlW0NGSnGw45vatk62J9JAmiO2
 vUCJ7JjFshIl7xeP+M7H++OYBhNPQtyPi7kxRDmheI7hnPvcWznl5BEUlj6V/saOMYFe
 2DRT4w6ftg2c4P7BBhX12NDEkjsJP/K1PCS414RFPsd5MiSs69P71j+V+ab5GMe/M6Wq
 ZhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765462456; x=1766067256;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Quf//nawr91qVjpDUM81lB+EUItw06tEVljMWzee2l4=;
 b=j62x+3hwTtgWLBa+kieT7O4mymESg9Vv84jlP59kDWJbyka0x9WmBhYMJ62+q69YMv
 a52OZEhXfbNSkovVPUjeGgpExWO+mh7AGzuBpyz6d3pNpuo681foyGUnnQAXAzrYqhfu
 62WPj3ZA4bjlOBcDPFeXaaYOhs4C/BlfmA1UPDAxu3yg404bVFeVdPIlZ2tRkPlG0l2g
 Rcsd9gMqEGKWyN0tr2w2PP9Yt25pGcVYWlnmjuO0lgOJkh/WKFEUO2v6lkpupj2UDvWK
 3rwPj7AXdglg8GWN/D46bwfWktwE8a6dlUAKyxLFsdmkiH/cvMebIJqgKynjgd2VgOKs
 aJ7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK9V/wih67Z98RMnu6sbPxUDVFwJKccn1IbPDLgOATjrDw6sUiaouuriVhoaDkeKtCXgRSEyg=@lists.denx.de
X-Gm-Message-State: AOJu0YzqO6Fih0+PCNZS7QUzn/bieCu0U0/GX6WKGy7h5Z8Pv+AYfmV1
 rw9AE/fHInEHyCaYE/kRZiD5Ms6bmY9pWuSJrwdbgf5CNd5sg2aeMfa4zK4h+BupB0WrsDt17cN
 TrCMCHGROZCxC6LT9Xq7WqKrzvCuWVbo=
X-Gm-Gg: AY/fxX74LaCS90vVnwak/OoGA1wzmbfhango4aGcKX6d3wZKL2TLMvDJimyvhjkwzzi
 8US0Oeui4uI8nUWMS5DsSKVZzBC/lWIXgstDQNfGGI89s+MCJdNL6YwHn9tzfVJW7JsFbm4ruF2
 9CfUumGaAK1lj/Pv20xj3Y1eIg5kOOIt23ruIVDbjeqdlfYKGZytQXbHZkWhZqDQJz1T4yb8RyR
 2dyuR97L4CqXvN41HRxaMsG0LiKZFGRA5kDGY1Y0B8LQkH0RIw+E8se4fdHECkNmKvJFjFT+zqd
 NX0cP1rOQlqHjMaF0H+6YnaEjsbIySZDxQXr3V/i3/Lw/n3D0Ah+K6fo31I8OCUTjsMWie8rIP2
 4++mH8YhGinymKhL+/1QEJLTNtMoEZC74gAbqKa4dXdJluHlGJot2gNZV/pN3u8dKurF2Zjq6sq
 4=
X-Google-Smtp-Source: AGHT+IHPFbuGIoMRuwevo6siRqThjINSdb1s839g/AP+AZPC/SJw3jvIuL87gW6EEuIdfUgN20gM2jhkgYNzkIwuDzQ=
X-Received: by 2002:a05:6402:518b:b0:647:54ba:6c42 with SMTP id
 4fb4d7f45d1cf-6496cb686dfmr6278691a12.4.1765462455734; Thu, 11 Dec 2025
 06:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20251209211807.497095-1-pbrobinson@gmail.com>
 <7fa7ee4e-94ab-4338-bb01-481a68768922@cherry.de>
 <d74fb99d-f9aa-4417-915c-6b8a00a443b2@kwiboo.se>
In-Reply-To: <d74fb99d-f9aa-4417-915c-6b8a00a443b2@kwiboo.se>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 11 Dec 2025 14:14:04 +0000
X-Gm-Features: AQt7F2q4EZnrstXdLHNg4ooPSH_ghEh7tFnK1opD9nGXt-9S9_6oCVELTM6vdOg
Message-ID: <CALeDE9NMnY+N2psmYr63O5nXA3+ibb87amKFWLWdDL5F9M0zxw@mail.gmail.com>
Subject: Re: [PATCH] rockchip: rk356x: Stop overriding sdhci/mmc aliases
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
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

> Hi,
>
> On 12/11/2025 11:56 AM, Quentin Schulz wrote:
> > Hi Peter,
> >
> > On 12/9/25 10:18 PM, Peter Robinson wrote:
> >> Upstream device tree has rules where the aliases are board
> >> specific settings, no SoC settings. Looking at upstream
> >> rk356x boards there's a lot of variation in the setting of
> >> mmc0/mmc1 based on the device so we should not be overriding
> >> this here and now we sync to upstream we should just consume
> >> those settings, to do otherwise confuses users.
> >>
> >
> > Do all boards with DM_SEQ_ALIAS config set have these aliases set?
> > Otherwise the MMC device index may change between reboots.
> >
> > While this change is appropriate, we should care to not break users just
> > for the sake of being correct. The easiest check could be to build all
> > rk356* DTB before and after your patch and see if it changes something
> > and for those boards whose DTB changed, whether they use DM_SEQ_ALIAS in
> > some U-Boot phase or not.
>
> To my knowledge all rk33/rk35 boards should be using DM_SEQ_ALIAS in SPL
> and proper in defconfig, at least that is something I have been tested
> or patched in the past for most Rockchip rk33/rk35 SoCs.
>
> The mmc0/mmc1 aliases have been added to the u-boot.dtsi to ensure that
> mmc1  and mmc0 used in e.g. boot_targets env is predictable, similar to
> all older RK SoCs where mmc0=eMMC and mmc1=SD-card (in U-Boot).
>
> Removing these aliases will most likely change boot targets order in
> U-Boot proper, please do not remove these aliases and without first
> having a fix/replacement for the boot targets change in place.

The problem we have is that in cases where Linux is also using the DT
provided by U-Boot we end up with things that can change and we should
not be changing/overriding what the board is specifying, and it's
explicitly forbidden to do this in the upstream DT so we should not be
overriding this.

The reason this came to my attention is because of bug reports of the
way it worked in Linux where they were named differently depending on
whether the U-Boot DT was used in Linux or whether one built from the
Linux kernel tree did.

If there are specific boards that regress with this we should fix the
individual boards rather than use a sledge hammer approach, which is
disallowed for upstream DTs, and which causes other problems for
boards that are doing it correctly.

Peter
