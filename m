Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93328C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 21:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B434387C3C;
	Wed, 24 Jan 2024 22:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZM3QwJdQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0FC687C46; Wed, 24 Jan 2024 22:17:04 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CF1E87C38
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 22:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dc371d6eb5aso2032838276.0
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 13:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706131021; x=1706735821; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TJFne8V7s4bzDbgP8MRGFhqODZOvAz1HTljBR9WdbeM=;
 b=ZM3QwJdQ9BMqq2pTppeyO9Q6Ph6K/nrEbh89NLPwu3rElQZc+5QnW/wtvurJKcLJ/R
 5vpOwA70iOG0n4wlX47/MWb0sdyM/rvJ/odfLO9ho7Xg18nXEng3Y3MTzxJ8ogjJDs6P
 VG7+imrbql/JQ9SWCId+GlJmEzG1uudfrax1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706131021; x=1706735821;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJFne8V7s4bzDbgP8MRGFhqODZOvAz1HTljBR9WdbeM=;
 b=VbZrFDIDAV13QquimBqFTzgvLh4e9y3it+pcFeb5vSXJEJk4Wx6h7+aV5hDO4/xxef
 beiItY2nyrsMRC5ImfDAqLbwMwwzayQpck1vemIfATXNrZ9/vwReuOTlB74N4S7i2stb
 06IE8V0+EMPJWMU0/LIFgqXK84UAfVJro4Lg/knjrD5LRTDcw8MrVeMp7Pl1rQZ5iydT
 HiobsRmYLrchjcwSl8S2BunM8qaCKpe4LGbO5PoV31/W9+qUJEWyNTzbO5426YzGM6Bx
 zwhEGK155knYMZ1bJkLm2ATkG7tsKnpdCY9KDEclkeLFj1PCREYpKM9Lr3dlP/eJDyj4
 0XiQ==
X-Gm-Message-State: AOJu0YyyBNFc0H54zpqpXbYmmKAIYYaSou8v11IOh/nC7ADpt/hEKltF
 vM14rS0DEyR8UqzRIdZAZ5swJn5r3m3XUn8XXliqPDk3Y9Cr5kERTzrwVFNe+6w=
X-Google-Smtp-Source: AGHT+IErgpGeVsWaFjmsVs//VkCzW5/rAApsmD6V6eC5/qCEb3ovdVWiRyWf9uKJwrqYkmIa3SzWmw==
X-Received: by 2002:a25:fc5:0:b0:dc2:3607:8ef7 with SMTP id
 188-20020a250fc5000000b00dc236078ef7mr6975ybp.6.1706131021266; 
 Wed, 24 Jan 2024 13:17:01 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 e80-20020a25d353000000b00dc2233f74fesm3064121ybf.25.2024.01.24.13.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 13:17:00 -0800 (PST)
Date: Wed, 24 Jan 2024 16:16:58 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/4] cmd: provide command to display SMBIOS information
Message-ID: <20240124211658.GA493567@bill-the-cat>
References: <20240117153347.85074-1-heinrich.schuchardt@canonical.com>
 <20240117153347.85074-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ND5YcJTUTUWlIXl6"
Content-Disposition: inline
In-Reply-To: <20240117153347.85074-2-heinrich.schuchardt@canonical.com>
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


--ND5YcJTUTUWlIXl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 04:33:45PM +0100, Heinrich Schuchardt wrote:

> U-Boot can either generated an SMBIOS table or copy it from a prior boot
> stage, e.g. QEMU.
>=20
> Provide a command to display the SMBIOS information.
>=20
> Currently only type 1 and 2 are translated to human readable text.
> Other types may be added later. Currently only a hexdump and the list of
> strings is provided for these.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
[snip]
> @@ -227,6 +227,13 @@ config CMD_SBI
>  	help
>  	  Display information about the SBI implementation.
> =20
> +config CMD_SMBIOS
> +	bool "smbios"
> +	depends on SMBIOS
> +	default y
> +	help
> +	  Display the SMBIOS information.
> +

So this would be enabled (today) on 888 boards and is a bit more than a
kilobyte. I think we can just let this be enabled as needed in
defconfigs?

--=20
Tom

--ND5YcJTUTUWlIXl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWxfkcACgkQFHw5/5Y0
tyzKRQv8DXNblaqEg9AeBQOb+caBabnIeV2wmzrazw9cvNjvAR+gSq8q2x3Z0EkD
L04hOrf2fmpLEnlFe3tad9yZRl9XCEUEM6yR8UcuGbohH7WkyDYsl72h94Hk2/GD
/76aWPMn+Vbs8UyzDp7v6Z+LdDNm98JroNEkkshhmj/n0X0M2Efz5hl8y5VG5qkR
BlA38Ctsxm9yfW14PbxHdYBxIKgM5Jyilip0KWHmGYGoiajWE8xVcfOL1pk9hENK
5+dN54AOX4Q8hYb0ftX1ihUVR92hhScaNY27zzOTvWMwmgyAp8cx2JBe6+I1TkxM
isboFq9RRoMtWi9nWlacMqkWCZ8NqF17WzSeYIfp1TkNNddKFkb3KrT2A6zKqlLX
LHm9QMBKOBjBQ5LkC8erXTzYqH4sXP03kroDLIIzLt1sEb/ernYMx05KiHuwAW4F
TWFj7ZNCeZFCEiRUrw8EyzgYDIjik72giZN9xzM/rEMQv2TnZd28tAUPvFjbyxkb
NuXoq2GM
=mDxb
-----END PGP SIGNATURE-----

--ND5YcJTUTUWlIXl6--
