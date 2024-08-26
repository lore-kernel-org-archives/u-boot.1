Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F4FC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 06:35:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC64F889B3;
	Mon, 26 Aug 2024 08:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OteYkrQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EF9687B84; Mon, 26 Aug 2024 08:34:58 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1D4A88A03
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 08:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42ab99fb45dso44266385e9.1
 for <u-boot@lists.denx.de>; Sun, 25 Aug 2024 23:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724654094; x=1725258894;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BWbqDKrdwEwNw7CfJcnO4pGmk+O7y9FqReoQYQ5MMcs=;
 b=OteYkrQQAqDCjlM5i5zAiFIE8fOtw6X+uy43PHBVcnEau/42nWDSwlY38ILrIKrD5d
 7ZR7+gdjZM2CjDCSYTj5B8OydwImzm2NAVKwTC/6HY0YorYnPbCaY6Vuempa6eiwIleZ
 oUTVXj/Z56WMzCQJwrW17sctdgnUDZZxL9dnEzSq1TYgOc8MGR8B0B2CQqlNq1XYwomg
 +PtPJJbCHc/MdoZZmwj2epXwI/IOGUK688xAbGsuDEbCS0vUaMo1+LAFOmj85FqxGQDa
 iL/Z6GLTBlYFWc2onNpt3LKJaUvckVar+pjf5TmmespWXw7lqPgWMO2RwBAS4ZjkHr6O
 ZNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724654094; x=1725258894;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWbqDKrdwEwNw7CfJcnO4pGmk+O7y9FqReoQYQ5MMcs=;
 b=PRP1+gROhezFls12/isXxVBed6SxZpd6c7KLzsapgEuOnHGW6nc4Kzao2aMM0xGwET
 oIVwrCHQ6jU1slXt3lKwoirGjtBfJVYevwB6XMCZj8oQKri/19c43Vlp431iSHzF9+CN
 Yo+94FsOjkhb8PQk4/pyyYww+GilWAGQQb55zXeDiVgxyy2ZLsCkfOPh/mVlEdLgwiqR
 2yVdlnXIZ2TsURR8hRFlplvtPWbfMhUMNRSRp/Xibp4x9peFcFsHibzTnF203M8EZDu9
 DWi9xsxUowLB4cDZd9rQPGRpGU7toa0v+xxInq3WI6c8YbHGGK/hBR7EIBATiTpsjj8A
 Hh6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkocyOs4NpvXiT/xNS5830qZjS6aA1rkxYT4tlDIxk2hpz0qhMCVxH54oZpJTzUe3AWOjpSWE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywgc4NUDDNxLynj56QbnXyekef28Uk2HbhaVZPr0OX6h6MmKUA6
 008zVTFbSKNaHcoMoEe+X4sVLv1MKHWOKbu0b3bv4Iq3ef37f6K6Z01ri8s9qOs=
X-Google-Smtp-Source: AGHT+IGw33QMuvAMpROZeUlYclsvhzv4Vul0EDbfrF8YZ6fHmstwdBQ9hz6j6t7X76sqUKZZOnsRbA==
X-Received: by 2002:a5d:490e:0:b0:371:8dc0:f90b with SMTP id
 ffacd0b85a97d-373118e33ecmr6775063f8f.55.1724654093606; 
 Sun, 25 Aug 2024 23:34:53 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ff5c4sm9923316f8f.78.2024.08.25.23.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Aug 2024 23:34:53 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Eddie James
 <eajames@linux.ibm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/2] bootm: adjust the print format
In-Reply-To: <20240825122617.3708982-1-dario.binacchi@amarulasolutions.com>
References: <20240825122617.3708982-1-dario.binacchi@amarulasolutions.com>
Date: Mon, 26 Aug 2024 08:34:52 +0200
Message-ID: <87ed6bdc6r.fsf@baylibre.com>
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

Hi Dario,

Thank you for the patch.

On dim., ao=C3=BBt 25, 2024 at 14:26, Dario Binacchi <dario.binacchi@amarul=
asolutions.com> wrote:

> All three addresses printed are in hexadecimal format, but only the
> first two have the "0x" prefix. The patch aligns the format of the
> "end" address with the other two by adding the "0x" prefix.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
>  boot/bootm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 480f8e6a0e6e..951e549f19ff 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -703,7 +703,7 @@ static int bootm_load_os(struct bootm_headers *images=
, int boot_progress)
>=20=20
>  		/* Handle BOOTM_STATE_LOADOS */
>  		if (relocated_addr !=3D load) {
> -			printf("Moving Image from 0x%lx to 0x%lx, end=3D%lx\n",
> +			printf("Moving Image from 0x%lx to 0x%lx, end=3D0x%lx\n",
>  			       load, relocated_addr,
>  			       relocated_addr + image_size);
>  			memmove((void *)relocated_addr, load_buf, image_size);
> --=20
> 2.43.0
