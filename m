Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE62C02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 02:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9941280087;
	Wed,  5 Feb 2025 03:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s4/OkFmA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9D56801FD; Tue,  4 Feb 2025 15:13:57 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95FBE80040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 15:13:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso57850275e9.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 06:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738678435; x=1739283235;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+NRXsTncHFlJKC7KE+WkyAtjrhDeK3prvX/0JBDg7N8=;
 b=s4/OkFmALdr/yL2Y3lL38gHSMMj5jbiY6iFMwEl+fT7kYQTTiVMgHuQmKHMkL+kUuE
 BtWNGEvYp1NMY+a9F5d2iIq2pLfjsJyl5Fx+4sHg9oZaWOeTyVmfqXvT1ipL2uugix7I
 hwwZg/uT6G4TGNPXZJgiXcZ1NaXKPWZdgR0Dht5ZBPDKe/GIhCAKefcoziP2LuBQ8wTv
 hyRnv7nIt8g2zo3O2wUXisarm08D1u3XGgb2TQQZdVYfafRmUwxKKh0tdz9I0gCO4U7B
 RyJn6Es/BFMb4n9ICqFgftJ+YIN+Mi/bm0TqgpBKoQWyIKK6y+EWYF3GXhGf34m559Hq
 UJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738678435; x=1739283235;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+NRXsTncHFlJKC7KE+WkyAtjrhDeK3prvX/0JBDg7N8=;
 b=nldF9fLyGueF+ae6qe5O3Vb5yy9HL/iXjVN1QzFCqlNriy0gGHa11RqFePna4LUM4E
 bjBOKg71VoyAgRSohbZDj5dVosEz4Ojl7XdO4unSkmVG+1vxXxzMOg1M8g1ZsRmD6oj6
 BjZYZdEYlOzWQPeqKKpLbsxW7CfFTVMfNN5p5oM/1i9HqBX7Pb0pqPNtDsQCCQD2QOA0
 FiaF9AXHJjmdSAnj8D9ZYSQNBilfz63FCsfSZqm+ko5hQLuiqDjLgBLW7Fgg/YECBTdV
 KqLkAfSkFzoM9oOoR4g3TemS+S4ohKn/5J5odLIC1j6wYFmnC+XcibMEiBRkuZLyS0+5
 6cqQ==
X-Gm-Message-State: AOJu0YwFpovVgtt/TzL1tUgpEBxDH74io/oIYS20zHQRzQXAR1VjajcW
 k7UJJsOtHQnkAGfi/7yYOgjtOMcrGciqnPWrJ83qjgN8Yjhkd/QJb/l+F68mQ8c=
X-Gm-Gg: ASbGnctOtry7bhWY8fruCXZ3HSEMavw35eon4Y1i8RvVl7ylH1b3AIqWJ0QjWjbKKNG
 /Fri5hThYjT4lulwk8BK+zf4moIDM56zoi3I3Hm99PpBDqzbtLYcwFlJcRYre06gJZA3QqqfRv9
 ICU5uTC0Qw4lm7mm99IpDcElH90Fb5IQ4hXeo5/1ThBjYoB/Ri/+D/YieCm5+U1TVlJFhePbq2N
 FoaJJfuF5/iI5cfOf848tFqvTESkmfoeOibBY9Pu8uDeXdTy5xmXu7QyoVkiJQ+xm8xoQkzGPsW
 55rd4PIdWsVJzK7RndE=
X-Google-Smtp-Source: AGHT+IFwJXApv5OTKlBy2A/QxgQZS+Cs52QCp0gDkRLGhi42C1LeT0tHkiN8QPlMu347asOZoDEnRg==
X-Received: by 2002:a05:600c:1c91:b0:436:ed38:5c7f with SMTP id
 5b1f17b1804b1-438dc3c38c6mr221889675e9.12.1738678434926; 
 Tue, 04 Feb 2025 06:13:54 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42d4sm197036495e9.6.2025.02.04.06.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 06:13:54 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jonathan Humphreys <j-humphreys@ti.com>, Raymond Mao
 <raymond.mao@linaro.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal
 Simek <michal.simek@amd.com>, Udit Kumar <u-kumar1@ti.com>, Simon Glass
 <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>, Hari Nagalla
 <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Santhosh Kumar K
 <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Daniel Schultz
 <d.schultz@phytec.de>, Viacheslav Bocharov <adeep@lexina.in>, Neil
 Armstrong <neil.armstrong@linaro.org>, Aashvij Shenai <a-shenai@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Jonathan Humphreys
 <j-humphreys@ti.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Apurva Nandan <a-nandan@ti.com>, Bryan Brattlof
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>, Robert Nelson
 <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Lukasz Majewski <lukma@denx.de>, s-vadapalli@ti.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] efi_firmware: set EFI capsule dfu_alt_info env
 explicitly
In-Reply-To: <20250203215351.2840144-2-j-humphreys@ti.com>
References: <20250203215351.2840144-1-j-humphreys@ti.com>
 <20250203215351.2840144-2-j-humphreys@ti.com>
Date: Tue, 04 Feb 2025 15:13:51 +0100
Message-ID: <87wme5kdb4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 05 Feb 2025 03:09:25 +0100
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

Hi Jon,

Thank you for the patch.

On lun., f=C3=A9vr. 03, 2025 at 15:53, Jonathan Humphreys <j-humphreys@ti.c=
om> wrote:

> The current implementation of EFI capsule update uses set_dfu_alt_info() =
to
> set the dfu_alt_info environment variable with the settings it requires.
> However, set_dfu_alt_info() is doing this for all DFU operations, even
> those unrelated to capsule update.
>
> Thus other uses of DFU, such as DFU boot which sets its own value for the
> dfu_alt_info environment variable, will have that setting overwritten with
> the capsule update setting. Similarly, any user defined value for the
> dfu_alt_info environment variable would get overwritten when any DFU
> operation was performed, including simply performing a "dfu 0 list"
> command.
>
> The solution is stop using the set_dfu_alt_info() mechanism to set the
> dfu_alt_info environment variable and instead explicitly set it to the
> capsule update's setting just before performing the capsule update's DFU
> operation, and then restore the environment variable back to its original
> value.
>
> This patch implements the explicit setting and restoring of the
> dfu_alt_info environment variable as part of the EFI capsule update
> operation.
>
> The fix is fully implemented in a subsequent patch that removes the capsu=
le
> update dfu_alt_info support in set_dfu_alt_info().
>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  lib/efi_loader/efi_firmware.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index 5a754c9cd03..d8b6d34ccab 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -649,8 +649,10 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
>  	efi_status_t (*progress)(efi_uintn_t completion),
>  	u16 **abort_reason)
>  {
> +	int ret;
>  	efi_status_t status;
>  	struct fmp_state state =3D { 0 };
> +	char *orig_dfu_env;
>=20=20
>  	EFI_ENTRY("%p %d %p %zu %p %p %p\n", this, image_index, image,
>  		  image_size, vendor_code, progress, abort_reason);
> @@ -663,9 +665,22 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
>  	if (status !=3D EFI_SUCCESS)
>  		return EFI_EXIT(status);
>=20=20
> +	orig_dfu_env =3D env_get("dfu_alt_info");
> +	ret =3D env_set("dfu_alt_info", update_info.dfu_string);
> +	if (ret) {
> +		pr_err("unable to set env variable \"dfu_alt_info\"!\n");

I could not find any other usage of pr_err() in this file so I think
we should use the log_err() instead of pr_err() here.

> +		return -EINVAL;
> +	}
> +
>  	if (fit_update(image))

Should we restore to orig_dfu_env in case fit_update() fails?
If not, why not? Maybe we can state this in the commit message or in a
code comment?

>  		return EFI_EXIT(EFI_DEVICE_ERROR);
>=20=20
> +	ret =3D env_set("dfu_alt_info", orig_dfu_env);
> +	if (ret) {
> +		pr_err("unable to set env variable \"dfu_alt_info\"!\n");

pr_err() -> log_err()

> +		return -EINVAL;
> +	}
> +
>  	efi_firmware_set_fmp_state_var(&state, image_index);
>=20=20
>  	return EFI_EXIT(EFI_SUCCESS);
> @@ -717,6 +732,7 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
>  	u8 dfu_alt_num;
>  	efi_status_t status;
>  	struct fmp_state state =3D { 0 };
> +	char *orig_dfu_env;
>=20=20
>  	EFI_ENTRY("%p %d %p %zu %p %p %p\n", this, image_index, image,
>  		  image_size, vendor_code, progress, abort_reason);
> @@ -747,10 +763,23 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
>  		}
>  	}
>=20=20
> +	orig_dfu_env =3D env_get("dfu_alt_info");
> +	ret =3D env_set("dfu_alt_info", update_info.dfu_string);
> +	if (ret) {
> +		pr_err("unable to set env variable \"dfu_alt_info\"!\n");

pr_err() -> log_err()

> +		return -EINVAL;
> +	}
> +
>  	if (dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
>  			     NULL, NULL))
>  		return EFI_EXIT(EFI_DEVICE_ERROR);
>=20=20
> +	ret =3D env_set("dfu_alt_info", orig_dfu_env);
> +	if (ret) {
> +		pr_err("unable to set env variable \"dfu_alt_info\"!\n");

pr_err() -> log_err()

> +		return -EINVAL;
> +	}
> +
>  	efi_firmware_set_fmp_state_var(&state, image_index);
>=20=20
>  	return EFI_EXIT(EFI_SUCCESS);
> --=20
> 2.34.1
