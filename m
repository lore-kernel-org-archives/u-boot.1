Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974F2EF5877
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 13:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CBA483C72;
	Tue, 17 Feb 2026 14:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nsaNNxsw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C69A83CB9; Tue, 17 Feb 2026 14:32:20 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F71880325
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 14:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-65b94e0a875so5771172a12.0
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 05:32:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771335138; cv=none;
 d=google.com; s=arc-20240605;
 b=cX+ws6FYAeix2KTf+QT+1iZl//83HR8dcBb5pJ5V/0iKn5piLiw8F38tU/iwt8P7Ht
 lKTkMwnr3yett9ZTPc7NzsDcs9+PjRNUK43AhzzLRBDQebgm76I2RJTkJoZzYxeRBuHo
 +ywVIkX9bZCJkuJUq18OI2RH5y+TkDuVqMft2c9x3iL1xnZJZnc4hVRgj77xf/PXu1XF
 J4BM0CnyUhGyWKbXTFC3MhxlcrAom+3eBvo14IPp32YqUdP3gLivUN4z2KhLGAfmgh9i
 2cCyBwys0GIfcjuk/vI99UrYIeCeVo3wrdb7RBINcQV5OXyD9g1zTsGfOULArB7fZ1Az
 fTyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vggr6rL+mVRd8yivNSe5u9kTfoVcimKIOccZJqgmhq8=;
 fh=hH4qI41eIhWFQFz5WKG5dFQ3f3OQFRbs2ytdYoy3UjU=;
 b=W1kIsVIP7d7cdvAV6fvqwGes8pHJ0d8Fvn+gEoqZA71Ov/Ff08mx4D/6Pq5A59Ygke
 nPasWsaKHCaNCUEzaMK7g7uYrK4Vad8lXvhhRRVyyT0mVumuAkPtYbMY7OvSy1l4xZFz
 2IJWij8iNL61u8RaTPsbEH9aFq8CC7OVBTt4UOviBJS98vDW7sgp7qe3/fwGno/NZGJz
 WeS5ckSzUhR17UdpXIA4gPPrEb5GZZ3WdJtJ8lqg+z5h+xdzpCF9XilxiW6Cqa51iR1X
 BEZAKuJsQoIlvkGBzD26bAQpnmuQY6Kmlpcrh24pA4MldShl63sMzKpdLwgl8m1s99wJ
 x3Og==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771335138; x=1771939938; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vggr6rL+mVRd8yivNSe5u9kTfoVcimKIOccZJqgmhq8=;
 b=nsaNNxswsHwRXzxKIW9Qx3EK2VU339+7Iy4p4bubVeViriMwXsE61pEweXBoXfJXB3
 WrAbT7S0+nWj1rsXnpeGqD5YhHrKlA3vXNhadbi8eLMayKbxcC+kLqmjN3+JjPH14wJU
 1bjcI+wwLW42IBruZJgZwuFEouUFrgHDTfKCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771335138; x=1771939938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vggr6rL+mVRd8yivNSe5u9kTfoVcimKIOccZJqgmhq8=;
 b=flq/MuRsRcEOR2V02ySQ1O2Dcj0NLoaBgeRQLr4vWBq5ZBv5Z62aknkAS5Pwfo+Ezs
 oEClDQX8XZKHnk/yDujbYl5JWpe43Y5+eMCLB/TsVak42alhGU3/iivAO9kCewzaxXjk
 8mAxk4guhgQemmdwfufsnjwwIyu6v0GlJDRj1bZIafvmbmjvy9EgPuRLgTdnX7dr3JBk
 MS2eixs5+XRhwyE1mFfB9AfIfeevu0Kmy6EH5CE8xsmHQibzyczSBziAtwu4SvTuvxxr
 d/CfI3K8MwFRaJeMxKuewoFmTrQ3xvVCOcMr0vMCUqlE86FsnSrIfjcQGYr6HST85mKJ
 mB9w==
X-Gm-Message-State: AOJu0YzYzHnq4V+y6YTvulvU7B9/EUDwEMC5Gu/NRbQ5LiK3nG5PedhU
 nH76JyM8OGLs1lKbrCPLbAEKRgw9K787MHCgZAzyP2AqszphwrcH3PPhhX5ARxQrife8ayIScyt
 FXdUZYABfE6gOx8ZUhJ+GKINxhoAa5os6ylQszvOeW5v81ZncOsw=
X-Gm-Gg: AZuq6aKeyKcyjb17Ic0NGyMnIP/LipeW5UpA/uTUMHqrv3DaOFW/mHzZtD0LyF8z+aw
 VMGyeBiuoBzFXidfj57Mg/2EVMiunxVfEQAZrs/lni9eiRpC+zTjKaGf7yRTMOqdwVGP+KH8BVP
 DIUeJGeNWJSAwapPAmLNV4iFfJqG/VlSeaHiHCRJGi36WklM19d7A0kumfkGq8i1Wpqu5k0LdVG
 NqHISaYQNqK85pM6L5fo5WVp01VNO8qKOOoki47yVc2oPQEj5qObqmnubv4XkS29k5xrkxYyoA0
 xIRPZg==
X-Received: by 2002:a05:6402:1d48:b0:65a:37f2:2447 with SMTP id
 4fb4d7f45d1cf-65bb129f55cmr6566937a12.32.1771335137947; Tue, 17 Feb 2026
 05:32:17 -0800 (PST)
MIME-Version: 1.0
References: <87qzr1z0tf.fsf@jcompost-mobl.amr.corp.intel.com>
In-Reply-To: <87qzr1z0tf.fsf@jcompost-mobl.amr.corp.intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Feb 2026 06:32:06 -0700
X-Gm-Features: AaiRm50fsQvF48U512eAhUcWo_DfCsR27Ui2dmmQ9BR6yCgaqdFzmO-9trFxtks
Message-ID: <CAFLszTg51H5xDRM0nNbck9Lvk_abz_GA0Hnf2Jo4VFAG_=tTaw@mail.gmail.com>
Subject: Re: [PATCH] x86/coreboot: Exclude memory regions starting above 4GB
To: Jeremy Compostella <jeremy.compostella@intel.com>
Cc: u-boot@lists.denx.de
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

On Tue, 3 Feb 2026 at 19:42, Jeremy Compostella
<jeremy.compostella@intel.com> wrote:
>
> This commit updates the RAM region filtering logic in
> board_get_usable_ram_top() to skip any memory regions whose start address
> is above 4GB. Previously, only the end address was capped at 4GB, but
> regions entirely above this threshold were still considered.
>
> Typically, the following memory map entries would cause
> board_get_usable_ram_top() to return 0x100000000, which is incorrect.
>
>     start=00000000, end=00001000, type=16
>     start=00001000, end=000a0000, type=1
>     start=000a0000, end=000f6000, type=2
>     start=000f6000, end=000f7000, type=16
>     start=000f7000, end=00100000, type=2
>     start=00100000, end=6f170000, type=1
>     start=6f170000, end=70000000, type=16
>     start=70000000, end=80800000, type=2
>     start=e0000000, end=f8000000, type=2
>     start=fa000000, end=fc000000, type=2
>     start=fc800000, end=fc880000, type=2
>     start=fd800000, end=fe800000, type=2
>     start=feb00000, end=feb80000, type=2
>     start=fec00000, end=fed00000, type=2
>     start=fed20000, end=fed80000, type=2
>     start=feda1000, end=feda2000, type=2
>     start=fedc0000, end=fede0000, type=2
>     start=100000000, end=102400000, type=2
>     start=102400000, end=47f800000, type=1
>     start=4000000000, end=4020000000, type=2
>
> By adding a check to continue the loop if the region's start address
> exceeds 0xffffffffULL, the function now properly ignores regions that are
> not usable in 32-bit address space.
>
> Change-Id: I8cbe0281aeea67a2f5bb9f6669456f5c7df9b409
> Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
> ---
>  arch/x86/cpu/coreboot/sdram.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <simon.glass@canonical.com>
