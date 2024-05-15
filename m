Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CB9C25B77
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 08:50:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 177BB88216;
	Wed, 15 May 2024 10:50:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IxoJ9FhV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEC1388229; Wed, 15 May 2024 10:50:00 +0200 (CEST)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE30D8812F
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 10:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-47f0a45375aso1793362137.1
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 01:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715762997; x=1716367797; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MibIGIXjMowow8FXPHQ5SN7qYBacNo7Lu5zPFXKkZc0=;
 b=IxoJ9FhVjUG6G81xqGEl7v+tesFQemBYsIkeE8/WZy/Ip0r5YJ2QjyLyiAdTHTYIPg
 mmsYYp1F3UnhW0zD4JZWr3DgnXwFefbBU0ngxiyEDS7CvXJYE19a/kFA5leZnYbevH/g
 JgDlv+bHBhdvqAesgpvUKpiKGqFF1iQVmhHpptzFlHxtQdEr4iki9Xd1oAjXeO2sGNEa
 0cZy6FnD83gxzY+FIUrrj3WR/8PlBCY9tlkSyMfXNzB47v8CbS/ErbrwoLCRXBkXe8RZ
 b6NwbP/0FLEjmwkc7DioRIIM1tTuLHYH0Cbv0/cWlB5ZU+ALRa+HxcN43RKWGaA9HAR2
 9Msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715762997; x=1716367797;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MibIGIXjMowow8FXPHQ5SN7qYBacNo7Lu5zPFXKkZc0=;
 b=Ee9sUYntS/racDDwJVSQMkbHk0BEoPkFym4dgnBCxAXfFyHtv/hNwe4EnJNHHUtn6u
 EvN0zkFw/ur+ZEP8aeU9Ak8k3URmRhsJwMHeoyV2W5u2xDhWdYQ3gXHrvrqgc4XRnhGc
 GVWpOVyv9pLuifXzq4jZk3fZpT63dCwc49rTz49F3MEgVSz9ghZxtfgxOPiJiiBSaJ7C
 We2LksJotS6YdOS01ThPElFrU9NaSW7Z5aK+ahWpGXfuvfJK8QYWCC90ObSfC1fJo1/V
 wD0aDbGryp/MH1WSdUF7TNi2cNg3PDIFecrIKFdfpdIv832djRO6O76ZeWzn4oW0kVoa
 1Vvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVuUsU6DNY1qXs70zd7c9oTLhx/ADsTpkEnpWjW6ILv5BLnlnsr3Duwz7PU/f8rPiilYUzvi/xx36OgK9+NlLAexPYZg==
X-Gm-Message-State: AOJu0Yyx8PtnMMXjY+BUWv4cN8jZ3c87wjfOKyhlWP+ukvlsLpaPe2i5
 1djuRWl4PP7IFxY95sZW8L+/CyXTNRksbTFIFZ79QMMRP7cblSpXH6MgFl9tKAZUQGHMb36CL5Z
 01b7qV0XE1IwgdXRIDRJEgSXFScDaApfKr4cDNWRQkgA3+jrXFNo=
X-Google-Smtp-Source: AGHT+IGWtWqzhEIVEYnLLPkF/j6piUeYEY5YcjBKmzOruUdNbnbkKQlr+eF/r9twpzZcYtbllp3YqS+a7K0Ew3cjqgg=
X-Received: by 2002:a05:6102:3f13:b0:47b:d23d:281a with SMTP id
 ada2fe7eead31-48077ea7e6amr16048646137.30.1715762994785; Wed, 15 May 2024
 01:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240514164236.516595-1-trini@konsulko.com>
 <b12a9b07-2c92-4651-b6ba-3aff6ecc9219@kwiboo.se>
In-Reply-To: <b12a9b07-2c92-4651-b6ba-3aff6ecc9219@kwiboo.se>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 15 May 2024 14:19:43 +0530
Message-ID: <CAFA6WYPsicMrtrDg7T8m=4-vg-QAPUY1D5E=_T8gZYgT=o2b4Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] Squashed 'dts/upstream/' changes from
 b35b9bd1d4ee..7e08733c96c8
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Jonas,

On Wed, 15 May 2024 at 13:11, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Tom,
>
> On 2024-05-14 18:42, Tom Rini wrote:>
> > git-subtree-dir: dts/upstream
> > git-subtree-split: 7e08733c96c84eb323f47e9b248c924e2ac6272a
> > ---
> > This moves OF_UPSTREAM to be tracking the v6.9 release and is for the
> > -next branch. To test these changes yourself locally, either use my
> > "WIP/14May2024-next" branch or run:
> > ./dts/update-dts-subtree.sh pull v6.9-dts
> > yourself locally. I intend to wait a few days to apply this to -next, to
> > give people time to test.
> >
>
> There are currently more boards/SoCs that use OF_UPSTREAM in master
> branch than in next branch, a few Rockchip SoCs and other boards/SoCs.

Glad to see more OF_UPSTREAM adoption.

> Next dts/upstream sync will probably be good to do together with a merge
> of master into next :-)

I don't have any particular opinion here and rather leave it upto Tom
how he would like to merge stuff.

>
> Also what is the expected sync cadence of dts/upstream? Linux v6.10 will
> probably be released shortly after U-Boot v2024.07. So will next sync be
> to v6.10-dts if that happens in the U-Boot merge window or do we expect
> 2024.10 to use v6.9 DTs if the v6.10 release gets delayed and miss the
> U-Boot merge window?
>
> Linux kernel typically have all major DT changes in -rc1 and fixes in
> later -rcX, so for next branch I would suggest an early sync to a
> v6.10-rcX-dts tag, and then sync to the final v6.10-dts tag once v6.10
> gets released. That should give more time for testing, migration and
> cleanup using v6.10 DTs in time for a 2024.10 release.

I can see the reasoning for an aggressive DT syncing approach, it has
been brought up in the past too. And the major reason for the current
moderate sync approach [1] is to limit any DT ABI breakages for
U-Boot, we are even prone to breakages with syncs against major Linux
kernel releases (eg. v6.10-dts etc.). It has been a long time
discussion topic where we have been advocating about requirements for
DT ABI stability [2].

So having DT syncs done during the merge window will shorten the
testing window for developers/maintainers. And more syncs means a
multiplicative factor for testing. However, time will tell with more
and more platforms adopting OF_UPSTREAM, if there are any real DT ABI
breakages seen in the future. But surely if they are very rare then I
am open to adopting aggressive DT sync approaches.

[1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing
[2] https://www.mail-archive.com/boot-architecture@lists.linaro.org/msg02162.html

-Sumit

>
> Regards,
> Jonas
