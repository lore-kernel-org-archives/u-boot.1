Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCA6C36011
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 14:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A3698144A;
	Sun, 30 Mar 2025 16:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h8M8sVwU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A7FB81DE3; Sun, 30 Mar 2025 16:07:29 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED8D180F9C
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 16:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christopher.obbard@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-399749152b4so1358268f8f.3
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 07:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743343646; x=1743948446; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ccJ7tOB5ESsXewfasMkA66JD2D/12VSeUm2mfAn9kIg=;
 b=h8M8sVwU4OHY5NHGtcqoFkY5meaTIqAuK7GacO528E1reU4CO5kkUqVGnFFUguyxEY
 qf71Zjl0MJb4gsmhBDUqFdLWdE8xZaUS4uCZv/Yy2kF1fKsEMsbGdg3WhShFC454Ni73
 OXInuk9oZN6YvxEhPbuTiC1rqYwTgjz25USy/eB23VS6CqrawywHtDaZLNo0QUm0kSu0
 5t6e8w4oV4hAZyNp/jGiCWBYh1a1osjId7dKfyl3sSNtUddaNdCuH1e4GPxaVy1OYCUC
 bQnJBcqfu/pkYqvaAfdra5RPY4sApTsAF4NdDUSPweFXVbQBiajPcvXaYFUDI959sc33
 W2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743343646; x=1743948446;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ccJ7tOB5ESsXewfasMkA66JD2D/12VSeUm2mfAn9kIg=;
 b=TAEur4hWXrIJbXUoZVFadRXowfkKNn+Ds52e7xm6LcFhQwH/tm+l26xYNxBP2DlOgY
 ScwLYS2BfJVzHEm6yr9JVVS6wGfSZ03f/2v9ubdHiH/teNgjL5yTFzSzWzuJEuhvinOT
 3S1XGnBhSTsWN9fVR/C9PefeXpeHq7W4poFUb48Ypvr/3A7EXloSsNm6xOXtRPwsSHkP
 WZrOJVPneF6bDG4njQHeJUlKWy03NczG9nTwOVgrs+mPaVzJxpYl4Lst/dlGhaWj54oA
 21wJyj7Y1bxDR47U99NpaRgl8trS4wtcrckvm12PkNrIBT5d+uiDOXC+LPugKFB9uGVn
 h2WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS03ymgXNErkcJqugB4OEsaXrUYYMnitQ75mQzpC/qDXdYKEGidzK+W397Rv0f7iXdt9sg4w8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/uZvJffRXjoGojIWm9IdKe/O+M2OKwrlchZEXP25PnI37UMW3
 5dwQD+z1Y2wNRaUec2jBJDwDbByJxj/onnDDF3G1yYSS7/mgZDx/Ki7S1cX5Xpo=
X-Gm-Gg: ASbGncu+oLrRR/ptCnH3kbvo25lXOLPOhQJjxryBa4EdoFPwcerDXQjMEgKJku4U4bK
 aCJQTxkZjiqPZq90Y624aPOxM+FKNLDBcQqcBlHYXz8hF5Ah4HRzyp+jPu+2q+veFSaKGcxqBhC
 8KtxTzEwO9io5xt6I8+q3in/vE14J0D1OEd6Gnjhz7+7xJYp2NqM6vt1qa+PtlFGMBiYtailKaw
 h3vv0A93sGejjRQWwisn/lOYIYHmDTmF4TQDv8ipAx/Lwxp5Jv39OrnEUbYJA6//B//hJSpydR4
 s2cXz4wGuEVszA8Tii7VpUdyYOuDtHspuVk3H+gC1yii4JdbXNIyVEMg8zXbJaLmG0umA6fTu6u
 hY169zSCqKO5d0m+ZbqqpMuanws8q
X-Google-Smtp-Source: AGHT+IHjQdvjSKhVYn5H0iuQst7eYm9ipFZq53KCQ+YnKeMpDNao5ZGrpOa/kTp5/BOx0yTJIQyFKg==
X-Received: by 2002:a5d:598d:0:b0:391:6fd:bb65 with SMTP id
 ffacd0b85a97d-39c120ca6c1mr4669207f8f.9.1743343646282; 
 Sun, 30 Mar 2025 07:07:26 -0700 (PDT)
Received: from ?IPv6:2a00:23c8:b70a:ae01:9cf7:b69:fc50:980f?
 ([2a00:23c8:b70a:ae01:9cf7:b69:fc50:980f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66a991sm8629271f8f.49.2025.03.30.07.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 07:07:26 -0700 (PDT)
Message-ID: <ac7234cc70a2bf7eee2ce12213cf1f170d58b54f.camel@linaro.org>
Subject: Re: [PATCH v4 5/5] rpi: Use the U-Boot control FDT for fdt_addr
From: Christopher Obbard <christopher.obbard@linaro.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren
 <swarren@nvidia.com>,  Matthias Brugger	 <mbrugger@suse.com>, Tom Rini
 <trini@konsulko.com>, Francois Berder	 <fberder@outlook.fr>, "Ivan T.
 Ivanov" <iivanov@suse.de>, Patrick Rudolph	
 <patrick.rudolph@9elements.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date: Sun, 30 Mar 2025 15:07:25 +0100
In-Reply-To: <20241220003447.2913443-6-sjg@chromium.org>
References: <20241220003447.2913443-1-sjg@chromium.org>
 <20241220003447.2913443-6-sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
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

Hi Simon,

[resending as I used the wrong e-mail address which isn't on the list,
oops]

On Thu, 2024-12-19 at 17:34 -0700, Simon Glass wrote:
> The fdt_addr variable is used in extlinux as a fallback devicetree if
> none is provided by the boot command. Otherwise the only use in U-
> Boot
> seems to me efi_install_fdt() when the internal FDT is required.
>=20
> The existing mechanism uses the devicetree provided to U-Boot, but in
> its original, unrelocated position. In my testing on an rpi_4, this
> ends
> up at 2b35ef00 which is not a convenient place in memory, if the
> ramdisk
> is large.
>=20
> U-Boot already deals with this sort of problem by relocating the FDT
> to a safe address.
>=20
> So use the control-FDT address instead.
>=20
> Remove the existing comment, which is confusing, since the FDT is not
> actually passed unmodified to the kernel: U-Boot adds various things
> using its FDT-fixup mechanism.
>=20
> Note that board_get_usable_ram_top() reduces the RAM top for boards
> with
> less RAM. This behaviour is left unchanged as there is no other
> mechanism for U-Boot to handle this.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
Tested-by: Christopher Obbard <christopher.obbard@linaro.org> # CM4 1G

> ---
>=20
> Changes in v4:
> - Expand the comment on set_fdt_addr()
> - Update the commit message to talk in terms of my testing
>=20
> Changes in v2:
> - Drop patch to allow expanding the devicetree during relocation
>=20
> =C2=A0board/raspberrypi/rpi/rpi.c | 20 ++++++++++----------
> =C2=A01 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/board/raspberrypi/rpi/rpi.c
> b/board/raspberrypi/rpi/rpi.c
> index c46fe4b2350..f74006e0968 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -3,6 +3,8 @@
> =C2=A0 * (C) Copyright 2012-2016 Stephen Warren
> =C2=A0 */
> =C2=A0
> +#define LOG_CATEGORY	LOGC_BOARD
> +
> =C2=A0#include <config.h>
> =C2=A0#include <dm.h>
> =C2=A0#include <env.h>
> @@ -326,18 +328,13 @@ static void set_fdtfile(void)
> =C2=A0}
> =C2=A0
> =C2=A0/*
> - * If the firmware provided a valid FDT at boot time, let's expose
> it in
> - * ${fdt_addr} so it may be passed unmodified to the kernel.
> + * Allow U-Boot to use its control FDT with extlinux if one is not
> provided.
> + * This will then go through the usual fixups that U-Boot does,
> before being
> + * handed off to Linux
> =C2=A0 */
> =C2=A0static void set_fdt_addr(void)
> =C2=A0{
> -	if (env_get("fdt_addr"))
> -		return;
> -
> -	if (fdt_magic(fw_dtb_pointer) !=3D FDT_MAGIC)
> -		return;
> -
> -	env_set_hex("fdt_addr", fw_dtb_pointer);
> +	env_set_hex("fdt_addr", (ulong)gd->fdt_blob);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -571,7 +568,10 @@ int ft_board_setup(void *blob, struct bd_info
> *bd)
> =C2=A0{
> =C2=A0	int node;
> =C2=A0
> -	update_fdt_from_fw(blob, (void *)fw_dtb_pointer);
> +	if (blob =3D=3D gd->fdt_blob)
> +		log_debug("Same FDT: nothing to do\n");
> +	else
> +		update_fdt_from_fw(blob, (void *)gd->fdt_blob);
> =C2=A0
> =C2=A0	node =3D fdt_node_offset_by_compatible(blob, -1, "simple-
> framebuffer");
> =C2=A0	if (node < 0)
