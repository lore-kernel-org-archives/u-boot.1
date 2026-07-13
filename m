Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112E4C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 15:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6248484BCB;
	Mon, 13 Jul 2026 17:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aM4wz7i3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19DAE84BCB; Mon, 13 Jul 2026 17:17:50 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72A2584AED
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 17:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-69c7697d523so2522176a12.2
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783955867; cv=none;
 d=google.com; s=arc-20260327;
 b=NZEXdCPtrULV2N3QqDLEp0JbkXuB3x+3DnUto1jA0KrdIjUU4d/WpmKS8fkUwgAO3V
 18kEF0iFGWhxXqQOnYMbcXenSn1mY31HOuSNcrJqp1ifxvj12c+cUmea6+rdziALU8nn
 AOwLv33NBgZPamYCRcxmQiSyyyB4rLdvLGOJSLqc8lrADMsFPAhMq8CTFcLtt0TjuytP
 45uYPYZe4YCKnu+dA117hp7GbN17gv1sY7r+ri8Ru0Ei1agDoIzV3le0R2Uz4TCqoKHc
 EhMO4IQmN+bGUWrTkDwwCcSZ++43tHTn3MNqXUJ/nPZETcp3BwQSiyWWBBpqSIcMpt7E
 nJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A3se4h86yNpwcgdBRU+daf88YWZ2OsMT35FRHWj9qWk=;
 fh=7+GNXzPJ9KVFWpYW8596/+Gqjn0jx3C+5feqsxM199M=;
 b=qFm5unMAR7FK7RiP2gCNwuSy4N6sckoVCP2aK4qP5F90dPsOrH74MrwJON+vZT1zVE
 cdt5mIsv9WC61kAo6ka3Hew9EyF28xnEORcHgywJbyIY6cb2aW3+fsqVVKxg5LgkprA6
 Z0urE+r7JDOsw41eht6187XGs9v0l0YQM16HPJUTB0uVkSqAs8KPd1zvvMyxT7Lv6OGL
 /nsD6Eh8y8Wx0uW32phPKm3sCjSMKYj563666/MuCwXfwpyhsjKYQJHHNh0I47o3g4G8
 K1BB01w1VOc8lIH/Mea6LB5mKlVCbxzj+ashPHrLB6tt8fUP9ho8DYGJju7lr7EYrxkW
 xGWQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783955867; x=1784560667; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=A3se4h86yNpwcgdBRU+daf88YWZ2OsMT35FRHWj9qWk=;
 b=aM4wz7i3PwCJXJzEz3fJb79ceXWhmf9ZmEqUOrZKLkxPWca7LitNQbwx0SEP0Honrh
 8+qV9ksRHKMXYNKZq4pZWPMZ7/faqvPeaOvACGCmFyr3oHIY6vWS5zA91Ifige3Nc815
 Lf7pygvAju0rdZdzQ1TWWVQFQZRUWvjDPJjEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783955867; x=1784560667;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=A3se4h86yNpwcgdBRU+daf88YWZ2OsMT35FRHWj9qWk=;
 b=ozbDbg2sUdgf8d5+sHmupaTY2QR0oEk+gGyXkbMIdMaYsgFLoLvyA5rKwBMxx5wGRN
 FumOSvpDGt77mqJVzUCgKISBekPG0k7gEFR13s7sp/FOsHdh7bG/UbRt/IW+J1p6Ajro
 TY4hxNe1aUu/VPPJqlhXshSvAx822aXqTGnX75fvxdfdS5vdgiOB+SYyuhU5kK/M2V5d
 GOdpfx2pfPwy9H5XP5FGgwaLU54UglKh7gbVIzcinsZJwtniGhu8gnCGQsTX01VkgVkM
 I0sR90Q9LEfUDE6jaY3+ckMjYxXUwRXTZeS1ASCki/ZBz4Xh0ZtGg3Ri8cFcflAQ1gfd
 pbxw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpESB64Figc3lvUK9OrPPXlv/NnTZjSAxLMK+jX1c2/UO9pvuR9T9e8TfKZk2lvtn6lqiKy/To=@lists.denx.de
X-Gm-Message-State: AOJu0YwwCuEjtve+JY8L2EaaHOB7SCoxiz6NN4aM7P5NJujIWSoYb8Re
 uLw86EFGfd41Bzoy1Mj/7yjIDp36abT42Z87s7wOESrsKgDmVFX8+dvgHTyVAKIu8gSRP9y1EeL
 GRGCG/3cfDYvH2gRiJGnhtwClNgfPWqOxNrxwq01G
X-Gm-Gg: AfdE7clOWi4aEBCk0O5ztFmK5Sc3Xi5UK7YTmfDOWXZ4hYj9PBkN0IrxDUIVGEh45AY
 mxZnACyCV4Bi/1WzMKKv7CaQRwOOeIIstD9riAH7aKlGMLXRW+NlHy2n8SYFMrccM2e6aR8I7CV
 LW5aJH+AJKtNja8w1SYELOZT3ua5tkFoKg7gfnD8VRB82zg0Sg7nAQIVE6A9JYM2+0a3HUj68mH
 Af7M5X2Jwu/cfPqgrfoIKvgEvdrMlMisdfYxM8IofI4t4QUiPaB/KmbGW/LyV2Mhs7PNVhr+zzp
 WggLgw==
X-Received: by 2002:a05:6402:3707:b0:697:e93d:6da6 with SMTP id
 4fb4d7f45d1cf-69c5ef86648mr3951544a12.1.1783955866753; Mon, 13 Jul 2026
 08:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-9-jonas@kwiboo.se>
 <CAFLszThMyQzP4FaF4DDhdkiJ_Rs6b41tUK36=x6bA2xQBYX-LA@mail.gmail.com>
 <587d0ac0-000e-4b32-a806-f7bf69f284fd@kwiboo.se>
In-Reply-To: <587d0ac0-000e-4b32-a806-f7bf69f284fd@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 09:17:35 -0600
X-Gm-Features: AUfX_mx7JC7UfyMNrz0hHmGrr7B2z4crXIx42ZPmsdrYfHX3jjj5iXu0AEuIR2I
Message-ID: <CAFLszTh1pD=JLjhX012n-W3gm-uaO+wt1SmLWMBTjgNg0Ouf7g@mail.gmail.com>
Subject: Re: [PATCH 08/11] Kconfig: i2c: Depend on correct xPL symbol
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>,
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

Hi Jonas,

On Mon, 13 Jul 2026 at 09:02, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 7/13/2026 4:28 PM, Simon Glass wrote:
> > Hi Jonas,
> >
> > On 2026-07-08T22:05:26, Jonas Karlman <jonas@kwiboo.se> wrote:
> >> Kconfig: i2c: Depend on correct xPL symbol
> >>
> >> Change to depend on the xPL symbol instead of the SUPPORT_xPL symbol to
> >> only make the xPL_SYS_I2C_LEGACY symbols available when xPL is enabled.
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>
> >> drivers/i2c/Kconfig | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> >> @@ -78,14 +78,14 @@ config SYS_I2C_LEGACY
> >>  config TPL_SYS_I2C_LEGACY
> >>       bool "Enable legacy I2C subsystem and drivers in TPL"
> >> -     depends on SUPPORT_TPL && !SPL_DM_I2C
> >> +     depends on TPL && !TPL_DM_I2C
> >
> > This also changes !SPL_DM_I2C to !TPL_DM_I2C, which fixes what looks
> > like a copy-paste error, similar to the DM_SERIAL fix in the next
> > patch. Please can you mention this in the commit message too? I
> > checked the boards that enable TPL_SYS_I2C_LEGACY (the mpc85xx
> > P1010RDB / P1020RDB / P2020RDB NAND configs) and none enables SPL_DM
> > or TPL_DM, so there should no functional change, but it is worth
> > recording that this dependency is also being corrected.
>
> Sure and great, I will update commit message in v2.
>
> >
> > With that (assuming you figure out what Tom raised):
>
> It looked like SYS_I2C_EARLY_INIT is the culprit for size change.
>
> See [1] for my findings, and I am still not sure if we can live without
> the call to i2c_early_init_f() for the handful of possible affected
> boards.
>
> My gut feeling, without knowing anything about the affected platform,
> says we should accept the dropped call to i2c_early_init_f() ;-)

No argument from ,e...there has been plenty of time to migrate those boards!

>
> [1] https://lore.kernel.org/u-boot/975a650f-88cf-4b2d-8f83-2df3f93ab25d@kwiboo.se/
>
> Regards,
> Jonas
>
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
