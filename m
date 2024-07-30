Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3C8C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 08:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CEFD883A9;
	Tue, 30 Jul 2024 10:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HWtFP44r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AABA8780A; Tue, 30 Jul 2024 10:43:20 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AF43887E4
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 10:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so31401535e9.2
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 01:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722328997; x=1722933797;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=p2Jqdm6ZDwMp0s2hV7aXFq6aWeQetNdkWyTJtT/I3J4=;
 b=HWtFP44rj9qjFdPK2+4uCVD+TdbNxCp8Ui3NM2dr5xDLxqpSPziqzpIpdc9ana8sMf
 HR7lNsL/GIGfm4rSU3WWJkIwCwkGyxKsZhZHbgaNZErNSH/hFIP2x/kpM3OgEFd1j+FM
 U37iBkqcg8AADL68mdvzDn+6lMZFN+Oanz4VnMX0IBXLAhpmp4pty7hLxqRaI0bsabLv
 ywh5TUXpxZUaHIgINhLisOT13S8clLPHpy2hpGaN3nBpL+dK5AdmZH58owPcjrLf6uUO
 5+i6fxS+UROA5LVzn/s+pgohrz0sDcdhY/paTlTFtBv4pZJ8h5DKC9wtCW2z1stZ74B+
 Cung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722328997; x=1722933797;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p2Jqdm6ZDwMp0s2hV7aXFq6aWeQetNdkWyTJtT/I3J4=;
 b=K86spipWwRs1xtRRbKMxGQJwfY6IFEnlOG1YFNWoRZv8yhM+6j0VpCvgOZ277s2yjo
 oXkp41Yz3OME2J8HDzXLYNyfV/VujKQh1qkTi1OzyvUGg7AonVrG3daM9w9ZjdR1qIy3
 Bs7aTife8B7seUQiOhx4DG/YKjNJuZjIsjg9wi+UEkoZOOtW4efhvHk/sgmIMUwiClf6
 6m5KMxHw06KhwlNLAUlv1a1FPuZgR/kxMR8dXCsj8ChF0MOlV2hUPB/H4c+8Dl8K6JzS
 sPgRGyCo4nU3/YQtmNOqAx9PHVdtzWbZPKfYSiZKevo6mjMe9UnPljsFkg1XkMGuc6h3
 UXug==
X-Gm-Message-State: AOJu0YwbraMr24JprhGeisIdUuadN7pQYnY5TNnyANlaFlZKGg8NblnY
 q50pmfXu3votKmNZBHiDWfjQuASUqO/QgOMcO+SbzFqkRIHbh2Mp5BezBH7l/i4=
X-Google-Smtp-Source: AGHT+IFN9c/3y+T4opRzVoVTbsJez/kFsUaTBHG2huT2XfCtGgCxnOi7QIBYRiWAd/0nlUmbw4txeg==
X-Received: by 2002:a05:600c:1c02:b0:426:5e1c:1ac2 with SMTP id
 5b1f17b1804b1-42811d77894mr87846955e9.8.1722328997125; 
 Tue, 30 Jul 2024 01:43:17 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428029e32fesm222662825e9.25.2024.07.30.01.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 01:43:16 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, igor.opaniuk@gmail.com,
 semen.protsenko@linaro.org, trini@konsulko.com,
 colin.mcallister@garmin.com, 4.shket@gmail.com, avromanov@salutedevices.com
Cc: u-boot@lists.denx.de, kernel@salutedevices.com, rockosov@gmail.com,
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v1 4/4] common: android_ab: fix slot suffix for abc block
In-Reply-To: <20240725194716.32232-5-ddrokosov@salutedevices.com>
References: <20240725194716.32232-1-ddrokosov@salutedevices.com>
 <20240725194716.32232-5-ddrokosov@salutedevices.com>
Date: Tue, 30 Jul 2024 10:43:13 +0200
Message-ID: <878qxjqnha.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Dmitry,

Thank you for the patch.

On jeu., juil. 25, 2024 at 22:47, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> To align with the official Android BCB (Boot Control Block)
> specifications, it's important to note that the slot_suffix should start
> with an underscore symbol.
>
> For a comprehensive understanding of the expected slot_suffix format in
> userspace, please refer to the provided reference [1].
>
> Links:
> [1] - https://source.android.com/docs/core/architecture/bootloader/updating#slots
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Can we point to the AOSP change on which this is based in the commit message?

https://android-review.googlesource.com/c/platform/external/u-boot/+/1446439

With that added:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  boot/android_ab.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index 359cc1a00428..45c154b10f1a 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -53,7 +53,7 @@ static int ab_control_default(struct bootloader_control *abc)
>  	if (!abc)
>  		return -EFAULT;
>  
> -	memcpy(abc->slot_suffix, "a\0\0\0", 4);
> +	memcpy(abc->slot_suffix, "_a\0\0", 4);
>  	abc->magic = BOOT_CTRL_MAGIC;
>  	abc->version = BOOT_CTRL_VERSION;
>  	abc->nb_slot = NUM_SLOTS;
> @@ -319,7 +319,8 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>  		 * or the device tree.
>  		 */
>  		memset(slot_suffix, 0, sizeof(slot_suffix));
> -		slot_suffix[0] = BOOT_SLOT_NAME(slot);
> +		slot_suffix[0] = '_';
> +		slot_suffix[1] = BOOT_SLOT_NAME(slot);
>  		if (memcmp(abc->slot_suffix, slot_suffix,
>  			   sizeof(slot_suffix))) {
>  			memcpy(abc->slot_suffix, slot_suffix,
> -- 
> 2.43.0
