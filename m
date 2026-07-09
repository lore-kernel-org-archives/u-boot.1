Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F86C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 18:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8454E84B3B;
	Thu,  9 Jul 2026 20:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K22Bb6LE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACE5A84B73; Thu,  9 Jul 2026 20:41:15 +0200 (CEST)
Received: from mail-ed2-x01.google.com (mail-ed2-x01.google.com
 [IPv6:2a00:1450:4864:33::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CED384A78
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 20:41:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=coiaprant@gmail.com
Received: by mail-ed2-x01.google.com with SMTP id
 4fb4d7f45d1cf-69850336c9cso49163a12.1
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 11:41:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783622473; cv=none;
 d=google.com; s=arc-20260327;
 b=gDDz0wVjqRgUz5c2JvOZ/MSH5c4vsQQ8eTYtLUQcXhXlK5oI7zgvuWv7IF9KaRT1l6
 pzZiBihU7m9HVLbg6Sfn81/N7lgZp+0ArRzP25WLuMCDHV2LJ2tkJb0F24poWhGZOQEr
 HJWV/4YWXEU37xEZDkj0Tb/Cpf+lE0WVeapnMWRLi7K7MWm3RW4L1M0G3e7blhb5wpEs
 BiGOCPLfTauCFXHKQA9yBENHQH48mLtLfwuIVSFHv/oFEudvhIV6PFkmX1a28OfCn5DE
 ClRmdvefZ372DRzoWQ1wmkUhsIdyJUwRqyUVvcTcnRlAn9v/WsKf6ItZl8vr6iqfcshr
 Bj/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7JMtX61LhQpjUcIoSI+nU3EfDNI0EJjVwl2Wy830DFw=;
 fh=g1vppUl4QHxN7ytj8qA6rpkcQwr6jdB5fVbHGDZJXvo=;
 b=Z4WraiERdBLJYs0Ef9A5L3+8NWT+ljrqRHsNW67dtwniZGRXaxBvUWZ0yUGABUFz8m
 3DzHx4Le49BeGaMUiPXIf0v3vU81xOu9fY9zOCic8Htgw3Qpz+GzcUwZx4s3VeXg9Cyt
 dqaNeWBvCyDFCQi6C50x2rbg6oAM9TusXTGp7HW4kQljmAnq8l+EiiQvxfLX/SdzdxPg
 SwOBB3eWt5Tyky246RP49zfDkV+fKHKlKaHNhT21HuLRD8HTMz2tnFTo36c8UW9JCWLm
 DxTnTTlyH+ls3M5QKyxudiC1z5u7oC38oAEvSbI3zCyeQMMT1rMqmajIRuhWbJPUfM8u
 /xQg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783622473; x=1784227273; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7JMtX61LhQpjUcIoSI+nU3EfDNI0EJjVwl2Wy830DFw=;
 b=K22Bb6LEgf9iIla2xArXqwuYcxjq0CmtsVOyoPD2DHFQ+h7F8dlm550LBEJz8ICzuv
 klgbklT/etCbxowPc8ThrVHwxORWBjAbsGQqKMRNpteq26uQGNwSAEhuLLP9PYCTRBqf
 hVLZ0VVy6DcimmwzrT9hJaRZbMnKoNDfzd1LmG/WZCgtOHl7FjAryhQraDmdSTiiODcg
 E3/3++5CEtdBDdE2jnK5WoeY26tShJ9qAv9dscsnMARxW/l/2pVJUB5jaJtdNJec4JLo
 4YUchgun0UVD/9II824d5Py/f5EYNRSuf5QgwIFuv8gfhY72/qmV+z2DLOFWs6f5dFKV
 LC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783622473; x=1784227273;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7JMtX61LhQpjUcIoSI+nU3EfDNI0EJjVwl2Wy830DFw=;
 b=XMBp8Xu4nQ97zmAeOawEp+l2Y0j8Bq1dUkDgtv96XbkdW3OmK09AkYRnSYBd6k/fwm
 05lUHe44UxpGeFUJEQ7Wm+9F9tjQwTsKVK7w64UWDlOnHjLAFtBD2/x1/bIFSRO45A/j
 bfQQsi193curv4v9LPI9fVm7Pz6D2BoFtSSFH7fmSM6IkFWQzVAxx8KtspR3ySwcyxU0
 X/d6rgQYmTwW6nKON2HN/MifFVdLynrv2WR8zxKEKxqoZvnYpWUQRftDqSt/Sym3gki9
 WI/4skiB7z21CrLmBb+xbbkIazBnnyYb0j/iYcN3rb5Kd1cg1x1spKpnuMQvi0dw89qv
 Oy4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqFa/CyDlgXllbCeu+QE42MerXcpZGdKfiOXmZuJUYG0piOfJ8Ubbom9K9JPqNvT9kTDsXGqk=@lists.denx.de
X-Gm-Message-State: AOJu0YzbLNdnFymZmcsSTzOq0gT7ARmpqBvFKURc17toZNqHD2VH1Lqa
 310VI6Gc2oq1fHxxrYLRpefvcBXcSyuuHBdnY2yj2AmRKmh0YB8WnfmvXBQCAN8Gu7wl6EMGfDH
 ZHUpRBCLr6X2LLqhmwIq0KDfrNBewdx4=
X-Gm-Gg: AfdE7cmOIZ/3ncapc/ltNbdk/va4Ob7SfBHF/hm4P7TNhfdEj+zexX3AVXaCtq4qWTU
 vEyC+5ws+dyzRsY/WODcL7LXWWeF0aa/2ch+W9s3mYPR/FGd7xCpcKgBe15pC9JEcB/oKtP/UEK
 gdqKnOZP+rRk33LXUokH7RErzGWT2XR5uNPwHDV8+flxm3pK1wSrvn6QgfN9J9CEl3Edwt/ifVw
 IliWyGDU05EndG+cMZtLwiZXB5D79v/t0T8O6ixSf5HOCLT0M4GUcAgaNMhcJQZi+xZ7ZpF5d4=
X-Received: by 2002:a17:907:e90:b0:beb:b53d:4839 with SMTP id
 a640c23a62f3a-c15ce0d2fdbmr421167766b.33.1783622472459; Thu, 09 Jul 2026
 11:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260625155021.2269190-2-coiaprant@gmail.com>
 <a71f2d27-4ba0-4abe-af1b-0ac409c2ba74@cherry.de>
In-Reply-To: <a71f2d27-4ba0-4abe-af1b-0ac409c2ba74@cherry.de>
From: Coia Prant <coiaprant@gmail.com>
Date: Fri, 10 Jul 2026 02:41:01 +0800
X-Gm-Features: AVVi8Cec2qigP5R1Aj37cuVEoII2N8Pq-texz2syX5QDUtIlKQ8QUuWKKwNxSng
Message-ID: <CALj3r0g-S6+Kzr97MHzKqdmw6RC2--2VxWs_FYc_JGMorPzE9g@mail.gmail.com>
Subject: Re: [PATCH v2] board: rockchip: Add for 9Tripod X3568 v4
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
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

> > --- /dev/null
> > +++ b/configs/9tripod-x3568-v4-rk3568_defconfig
> > @@ -0,0 +1,79 @@
> > +CONFIG_ARM=y
> > +CONFIG_SKIP_LOWLEVEL_INIT=y
> > +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>
> This cannot be enabled because you don't have CONFIG_RTL8169 enabled.
>
> There are a bunch of other symbols that are in this defconfig that don't
> need to be or are not applicable. Can you please send a v3 after running
> make savedefconfig and copying defconfig to
> configs/9tripod-x3568-v4-rk3568_defconfig?
>
> If you edited the defconfig by hand, please avoid as it's error-prone,
> simply use make menuconfig and enable the options you want through the
> menu (and save before exiting). Then run make savedefconfig as
> instructed above to get the defconfig to put into the source code.
>
> Cheers,
> Quentin

Yeah, Let me use "make savedefconfig".
Thanks.

Cheers,
Coia
