Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A50C021AA
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 19:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCE7E80F6C;
	Mon, 17 Feb 2025 20:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MQh4fBG0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB63780BAE; Mon, 17 Feb 2025 20:23:34 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93CA580F1C
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 20:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22100006bc8so42797765ad.0
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 11:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739820211; x=1740425011; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9Hg6mukfhFzCnJ4MVNvyuXBPR6E+IEXVuiXthFCKUx4=;
 b=MQh4fBG0dwq9bzgVn/Q5BYnw4TYMiGIeOKZj+H1aEO/ZCggXcI8/x+iGGwaQGd2GaD
 jcLgjdHNagB/TSdFpqQgGoMqdVxF5mEeuXPYVtPUcXeM+rTsy88Gn5zMeWi29KvM3LpH
 sqBfwa+ozOYGYBR4agm2IBhVDm9HzMD0GxJQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820211; x=1740425011;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Hg6mukfhFzCnJ4MVNvyuXBPR6E+IEXVuiXthFCKUx4=;
 b=n7vYi2SOKrbmaXhHGvM/np1DjPReZmNgFN1/TT5R4riSdArFAC3BUPqO+6lARoxkXS
 o+KjdNMJFMDbxKSHJFnf7lFNzDtmrpFUZ9mb+RejPKULXQSiYuxkK6X6eknuaLfxZ1bV
 /kt7V0Ub/1itYqosSbZlvsfxPXD+3qgQfYjeWkZLDcMN9l6wxKASCuuRFN0H/VgIIp6d
 JFo3HCKZWm6iH9y32VJ5Z3Eb/XjM28DrA5zeDoCVEGaphp1/obGIb5mZuycAbLpYewgW
 CnBMaJSDfZr294fId8dRw+bMKc/kJU+nsfpyRkIr7PFmNsCjR62r11dZmD0GlYi81RzA
 8OBQ==
X-Gm-Message-State: AOJu0Yy5hkMfo76fYhjQPCukdZmisYEaW95GExYrfwLTGXM9ntm1f8+J
 Nm+/E7x/l+JKbKuNzaTCWGQTIh37BJ+EPuFCFzHVzzZf7kBIFfc/Vqele4dlvCQ=
X-Gm-Gg: ASbGncv2fYBDRCENkM1G2y9Tu7w+uo/g38B73YndC7NvC9oFdvz1NEAOEMf2+X08x9Q
 /yNQXGG5e1Gool9pRTNUdBJ3aiKdOu5SP9sDKVWQOcN3vHtAQCDdH7Ibmk7Wm6vy3/nUg6rjXYt
 VTwARjyuyfysPwysSwl/EcjeXV7QCNgB3npRjKitbxwPiVLvVMcxHapC19/vE7VklJ5PUCNJA1L
 wAq/OCFmSgtOKPppDkc4FILR5aZKvOXnRBFZpx6Ozka9LnIfbk8WPERLN5bD6fI91Gk5lkpOHFI
 znWCLaxrGygLiw==
X-Google-Smtp-Source: AGHT+IFwis8dS0XY0rgtQjDC/C7rWKbGzJsKMTeYgkE6DgfnMVvusNVYk7ucYwD/Tgbs48eE31VNOg==
X-Received: by 2002:a17:902:ef49:b0:220:fe51:1aab with SMTP id
 d9443c01a7336-221040b1359mr202509155ad.38.1739820211164; 
 Mon, 17 Feb 2025 11:23:31 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5349056sm75475745ad.22.2025.02.17.11.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:23:30 -0800 (PST)
Date: Mon, 17 Feb 2025 13:23:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bryan Brattlof <bb@ti.com>, Marek Vasut <marex@denx.de>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v4 01/29] Makefile: Avoid using TEXT_BASE with the EFI APP
Message-ID: <20250217192327.GX1233568@bill-the-cat>
References: <20250215032254.4121030-1-sjg@chromium.org>
 <20250215032254.4121030-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PosfbxXeLvb39V7B"
Content-Disposition: inline
In-Reply-To: <20250215032254.4121030-2-sjg@chromium.org>
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


--PosfbxXeLvb39V7B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 08:22:22PM -0700, Simon Glass wrote:

> This value is not available with the EFI app. Add a condition to avoid
> introducing errors when linking.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--PosfbxXeLvb39V7B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezjK8ACgkQFHw5/5Y0
tywYYQv+IJNO0saZI9KjianFiGAPc6/KC8ekW+5fe8wluKD7YQ20lCdRGZpUYD7E
S0V0CdXrDj0a1Eri5Fc3rzM+49NxhWs67KZtDpdXidDxsOlfM18sGP+ksFhgJpLJ
/JpWGQaWCl0IOhok3dmAAn7LvPAEKvnsAQLsVDu4+0oK5X6hbl+v4Nios4/ig4lq
u/mZ4/2OWoJG3mvDXY/t9S19yKXUdYFxYLnpvzDeS3GTb/VTXtmGK6jxnZm2GXPL
TeMTYMegkEPCI7dwwioTPBFS6sNyg7DF38dNzHwodljl7DLM0uW/BsViAzM6ELvv
Pg/aNi7IINYAZdYgikjnk/VJEy6twnD1H3GQXxuQCtN+xt2kb8MZ5jwPmyo7UnvV
GKX2SBPS13DtwjAvScVPyMzIXWFZik9fI8P4qVRPcAmgCdfQNSVftwwJ796LUk8Z
TYQUgsZVj7GrDH72DaIfZLCLULIlmbQY6M7YVbT+aWlnLXlKwHCvTDbPqQlxfKHh
MEblilj9
=tqJI
-----END PGP SIGNATURE-----

--PosfbxXeLvb39V7B--
