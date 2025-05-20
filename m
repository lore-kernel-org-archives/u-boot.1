Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D3AC54E65
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 14:46:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E351782C87;
	Tue, 20 May 2025 16:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HPV1usms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE70682C96; Tue, 20 May 2025 16:45:57 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F33B82C55
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 16:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-73044329768so4720148a34.3
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747752354; x=1748357154; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jeSxiKYENBC9UtK6WDFG3bFqKQ9hvZQcVUyJdeMQiAk=;
 b=HPV1usmst/YB+pCYFRcMlj4oVAajpOAkhYhN2cBiqClYQ0sAq7ilu3x06vV1BEg65B
 EP2embDc2uDCHmpojV1G0neJSe78aeXJm1KWLX+s9cgDTA3y77pBWdnLEjlZQIZLrUlm
 FPuO09OV7WhCuFP7LKgucbHHkwrXCEuDS5WZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747752354; x=1748357154;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jeSxiKYENBC9UtK6WDFG3bFqKQ9hvZQcVUyJdeMQiAk=;
 b=N6o9dTqxPmUlib7PjdD0ay2bEOuKNMBjnvLv/awzTbTlRekaMYxvkgbVMJUAQ99yX+
 S11y3K97EYuIIDua0ERHrfzkwD5yok7Hz6brK45kA8J3Q7gfyArbMnu6l5RNZtrTYQYp
 M2M25Q/Y0ltMx4ypq4O8FQoqjxg37awL6IZU7+fxgXaKGc8p72dm7a4D3995guh05s4l
 Dv1rRoEc0wilW+nh41cOxh03D+9vKRvAXpYQXxiKxR75BtU5TUDQTg/jaaQ+s3/d/val
 tBWfVKfPRNeAMIUC7kKZ2IGQccjEU8Tvcc/+xV8HUxyx2CzWV/U1eXgsbvIWfUHUwIrq
 sw2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc4+Go/0hXRY5TJpvvJh4Js4EaCLpRGlCfwd8YyJXnO5drM68IHFF9iOs5mLgdu2vvU/geSBg=@lists.denx.de
X-Gm-Message-State: AOJu0YwI0idCV9i/zG7VqP8uTZCaB50VMwamP3NkFkejpz4lIay1LOB2
 Rp6vQHUa56KE5ZEFblqPVsAQsKY5gKsHqrLLwbbC7E33QUP/s0uCuUg06omM3tjQMUM=
X-Gm-Gg: ASbGncvDhq9Ne1ekb8y8g/Zn85b15KhIByFadqx82B6iN6jEHuD7bJdoq2huVerIIeH
 MxPQLq8JoX2mhA9i87rdLItMSkF8n4YF8wdGkqbtGh8gaKOf0Nbpvn8wkmU6B0j1GXrqqjNbfdX
 DqQWpwLhPVdEPpf7c8q1MH2RKRGouIir4f17WzFiNkaq2ItSmK2Dbx9anvXHzuOsxiUulbw4W2x
 NuJvYMXW9D4rvCG8yopdTVy3VU/Ks2qQEM2ASnjWl7diFnHy3YSxLRZFF4jhSJAwcnu63vxKzR/
 CHCyrqgYwUBjCm4/21Vaxla9NhHsBijwwOXjuS/H9WT+7AIfaVafwv3AgOABZnbr7LwYghDNA9b
 fceH4++AfRLlR
X-Google-Smtp-Source: AGHT+IHA0C+PLlJsIw247FEYC+7sIv17MZ8q3LMFN7KCxLelTr30oj7YqKp2wRnmB/SKwsrAXMf/HQ==
X-Received: by 2002:a05:6870:8983:b0:2d5:ba2d:80ed with SMTP id
 586e51a60fabf-2e3c1ec04b2mr9287150fac.25.1747752354250; 
 Tue, 20 May 2025 07:45:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c060c502sm2227770fac.2.2025.05.20.07.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 07:45:53 -0700 (PDT)
Date: Tue, 20 May 2025 08:45:51 -0600
From: Tom Rini <trini@konsulko.com>
To: gchan9527@gmail.com
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH 3/4] boot: bootmeth_android: Conditionally dependent on
 abootimg
Message-ID: <20250520144551.GB100073@bill-the-cat>
References: <20250520-sc7180-android-boot-v1-0-3075a84ea094@gmail.com>
 <20250520-sc7180-android-boot-v1-3-3075a84ea094@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="psZZPZhwc+UrMwfy"
Content-Disposition: inline
In-Reply-To: <20250520-sc7180-android-boot-v1-3-3075a84ea094@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--psZZPZhwc+UrMwfy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 10:25:58PM +0800, George Chan via B4 Relay wrote:

> From: George Chan <gchan9527@gmail.com>
>=20
> If target u-boot img do not support androidboot v3 or greater,
> abootimg might not be necessary.
>=20
> aarch64-linux-gnu-ld.bfd: boot/bootmeth_android.o: in function `boot_andr=
oid_normal':
> /home/user/sources/u-boot-next/boot/bootmeth_android.c:541:(.text.boot_an=
droid_normal+0xd0): undefined reference to `set_avendor_bootimg_addr'
> aarch64-linux-gnu-ld.bfd: /home/user/sources/u-boot-next/boot/bootmeth_an=
droid.c:543:(.text.boot_android_normal+0xd8): undefined reference to `set_a=
bootimg_addr'
> Segmentation fault (core dumped)
>=20
> Signed-off-by: George Chan <gchan9527@gmail.com>
> ---
>  boot/bootmeth_android.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
[snip]
> @@ -533,6 +533,7 @@ static int boot_android_normal(struct bootflow *bflow)
>  	if (ret < 0)
>  		return log_msg_ret("read boot", ret);
> =20
> +#ifdef CONFIG_CMD_ABOOTIMG
>  	if (priv->header_version >=3D 3) {

Can't we do:
	if (IS_ENABLED(CONFIG_CMD_ABOOTIMG) && priv->header_version >=3D 3) {
	..

And then also skip the __maybe_unused?

--=20
Tom

--psZZPZhwc+UrMwfy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgslZ8ACgkQFHw5/5Y0
tyyZXQwAnwFK9SbA5mwCNIEQ2SYWGlAUrJTg7wIUR4yCtVn+noAUU3um0g2OQds5
5/kufYsC7SMzmQThMaZLYjELGw7wXHFosYbyALdv3APz0R59/PiQI2hloB8qfjCp
pw8z25B/8badeJFGHmNit9Czf4wNcyh40k8nqIbFm8ZwzdDabg/ceMIThUU+LeHi
EEzMihD3O/n+IZ2+vUDr4NCjz3T1TuPI+MjtSSN9LAlyj7pXCwVhW8r8N9nbVy13
PRINBdHnr0o/faAsTOvnmIYERqZ3CO/uGnpuFsup6rv+Jq65ngAIJMotzHB28G04
PiUd/QIJtf+vKMpZPy71I/IhLBqfPMGsFtI5gfFOukA+2vbW9kY/SBQ1ZyB1bP2l
71eUp8hPLEOLlHurkWvIDiVP35uKCEWsNxRTpxP6tJ+ss8hR6ACNIM9x1M+084zy
4tdOaXs8Zk2qDmqnQqPSOyggxHHuGY+T3Fd+iF63BopQ4SR7xXhY9Fa7mtN1yacx
wXWfVERq
=/bxw
-----END PGP SIGNATURE-----

--psZZPZhwc+UrMwfy--
