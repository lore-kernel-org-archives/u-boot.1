Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EDAC531DC
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 08:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01DF488ADE;
	Fri, 16 Aug 2024 10:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Wgxu6xeB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47F9688ADE; Fri, 16 Aug 2024 10:23:33 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 362BE88618
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 10:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4281ca54fd3so12315895e9.2
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 01:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723796610; x=1724401410;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AsK8slmQSZSlY5cf65R5FkQP1gmIFy1emmi/0CW2ClU=;
 b=Wgxu6xeBrq0O16q2JlKCKIvwKnIhE10iUGlIb9EWO4f/810pcr6qXv2TnBJy/qFZca
 V9gg1x1/ezlijSLakKUX6lFRvQMYNQEEL99dBbob1mmoq2x4B2+yx1eS3+qZaCoxvxtZ
 itJ9PZQfVFI46+n3XLgtITfrJHbTvOFRIUM/WLnu90/gGw8YtVMDDVOR6rrh+W02Z+/x
 FBq6hPk8VF4Y7Yb9lGur4+7juEtLBxOxNHqHKrqooIbT/ty1DIjZG5mJmBfgBLhUb9Mw
 oS+0n8eOf8r9Y85t5uLpurlk2KoyB7zx6WdVFemGfFhXoc5GWo03A18iE+EmWjm1D/K4
 YmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723796610; x=1724401410;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AsK8slmQSZSlY5cf65R5FkQP1gmIFy1emmi/0CW2ClU=;
 b=MRcYZ6m34HGxyc06RNV90Y7caVIY9BjMRTJicUXBUB7zHtHZvKSNI0BHGZnNyP7ayE
 TVwUZbWsmTPLhU7GQZ+nm3bOOe29EP7hnNza0yxq80HmdSB+IuVgfrAMCmrolvPucpsD
 nc8nWXnluCCoLW7eczIvEXbMC6PIqfC2cB+fnxP06SBob7kXwcNzmW6cb34SA8/LJJ3v
 dnJWCK8C6+LinX+T82IAyjWN27IqBidPAhicdGhti63xWraKYopFxuGrL15JEdRIIDV9
 IKDnm83us9LuML7eu1oMmxugm3iUid8pG3gcoNR/ghVvqGn7U6IEh0XFa09nGL+0xa6+
 2hIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgjrqAbXeieKUve61clQjsstrstDHz7BwNXgfUPFbM3JcHC82vz+vD67KGc3g+ZzkYJYLHlucxBman3lj0jjQYAS6Y0g==
X-Gm-Message-State: AOJu0YxdODXB8b91oDj9dbFRyyU/GA1A+DdYo9jQusPovIg5uBPWUrTg
 vmr998pj6BlyiZadjhD7Sb0ZA7RF72RqgBnn8fKKkCli6etmd1o6k3+bfM1d6So=
X-Google-Smtp-Source: AGHT+IEasPWg1pNkqPNwZ8P8tEO+t95mBhoby5IQKelg1WKaVugGA3q71uW2mKQU692xxoOYfzQ/xQ==
X-Received: by 2002:a05:600c:1d94:b0:426:60b8:d8ba with SMTP id
 5b1f17b1804b1-429ed7d20e8mr13284575e9.28.1723796609506; 
 Fri, 16 Aug 2024 01:23:29 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded17ce0sm71259055e9.8.2024.08.16.01.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 01:23:28 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Joshua Watt <jpewhacker@gmail.com>, u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, Tom
 Rini <trini@konsulko.com>
Subject: Re: [PATCH] android_ab: Fix backup offset calculation
In-Reply-To: <20240807141434.733085-1-JPEWhacker@gmail.com>
References: <20240807141434.733085-1-JPEWhacker@gmail.com>
Date: Fri, 16 Aug 2024 10:23:27 +0200
Message-ID: <87zfpclvuo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Joshua,

Thank you for the patch.

On mer., ao=C3=BBt 07, 2024 at 08:13, Joshua Watt <jpewhacker@gmail.com> wr=
ote:

> The backup offset is in bytes, but was incorrectly be interpreted as
> blocks, leading to it being written to the wrong location. Fix the
> calculation and clarify that ANDROID_AB_BACKUP_OFFSET is in bytes and
> must be a multiple of the block size.

Nice finding !

>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  boot/android_ab.c | 4 ++--
>  common/Kconfig    | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index 143f373aae..b253200161 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -139,8 +139,8 @@ static int ab_control_store(struct blk_desc *dev_desc,
>  {
>  	ulong abc_offset, abc_blocks, ret;
>=20=20

Can we add a safeguard in here to make sure that offset
is always blksz aligned ?

We could do something similar to ab_control_create_from_disk():

	if (offset % part_info->blksz) {
		log_err("ANDROID: offset not block aligned.\n");
		return -EINVAL;
	}

> -	abc_offset =3D offset +
> -		     offsetof(struct bootloader_message_ab, slot_suffix) /
> +	abc_offset =3D (offset +
> +		      offsetof(struct bootloader_message_ab, slot_suffix)) /
>  		     part_info->blksz;
>  	abc_blocks =3D DIV_ROUND_UP(sizeof(struct bootloader_control),
>  				  part_info->blksz);

I've also noticed that ab_control_store()'s documentation does not
document the @param[in] offset.

Could we add that as well (either in a seperate patch or in this one) ?

> diff --git a/common/Kconfig b/common/Kconfig
> index 83c81edac2..e1b8557e0c 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -986,7 +986,8 @@ config ANDROID_AB_BACKUP_OFFSET
>  	help
>  	  If non-zero, a backup bootloader message starting at this offset in
>  	  the partition will tried in the event that the primary one (starting
> -	  at offset 0) fails its checksum.
> +	  at offset 0) fails its checksum. The offset is in bytes and must be
> +	  multiple of the block size.
>=20=20
>  endmenu
>=20=20
> --=20
> 2.45.2
