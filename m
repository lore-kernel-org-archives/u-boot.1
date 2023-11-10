Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FB0C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 16:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD9FD87838;
	Fri, 10 Nov 2023 17:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IT00rpZG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A528287838; Fri, 10 Nov 2023 17:21:29 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BFBC8782E
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 17:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-77bb668d941so138032985a.3
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 08:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699633286; x=1700238086; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fgA/xluAI1ZmID0p5CeJBY7Pg+FJsZgjz74l0jq1UaU=;
 b=IT00rpZGJwAsap4AIZxYIEGk+FUg0VEJTgy7VxRo9gZYqeApixNRDui9LW4rmzV7HV
 fOsR3T1I1X9avSp32qxaxnHHG64bdB+sZ46sRoBQARoUI9svBLtOry8iYdwcEY6l5jAK
 PCPPGD9a6sk2KjCp7S0NYNG88/37gnu8uwnao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699633286; x=1700238086;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgA/xluAI1ZmID0p5CeJBY7Pg+FJsZgjz74l0jq1UaU=;
 b=RUN0PQhxqbSp2x7621j57WoVuirXQtn1ZT3EwLy9zHDEqjnr7MVDGkBn7MlWj/ykue
 HxCjKXHi1mCXk+1srQ01fuOfMoRWRJm2rU4Vhvu2P8v9sZONcdXHK+GvXRw/7vL+VmuY
 OrGPf8iBZhekK7RwIDNXVkOEhY9/DacAzqxgy6HCgeJZDw224nH+mIAqSFIVhBmRxuC6
 2OFaJUm/HIWo0lXqDa7rMoCJSOKVypEPTIPkPLdcAkQ0eezJX9HNjMgcAtM4+BhhlckG
 jqGBNCMoptQ96jxDKs76mPaFLZCtZKo7dozyHyPfkxqQyAVgSZYkI1fTE3pwYDVn3oxW
 +z1A==
X-Gm-Message-State: AOJu0YyeJcaFpPpo6ADiNkLuUmdWr22iUBYdFgb26gA0ASnXh6Zt9MvC
 wqV3L0yfWCrl/Z0L98z/l18ldqyugIDh9uPdthy1Yw==
X-Google-Smtp-Source: AGHT+IGn3/BtAfjJ//aB2wbUpkBfaP3kIlqgybfUw4lkucDrqq5QNaP/c3Y21+ka/9NuV3JlYLmcBA==
X-Received: by 2002:a05:6214:c81:b0:65b:2660:f577 with SMTP id
 r1-20020a0562140c8100b0065b2660f577mr7868148qvr.3.1699633286195; 
 Fri, 10 Nov 2023 08:21:26 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-046c-8850-3cc9-4453.res6.spectrum.com.
 [2603:6081:7b00:6400:46c:8850:3cc9:4453])
 by smtp.gmail.com with ESMTPSA id
 mx4-20020a0562142e0400b0066d132b1c8bsm2968096qvb.102.2023.11.10.08.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 08:21:25 -0800 (PST)
Date: Fri, 10 Nov 2023 11:21:24 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH] scsi: Have scsi_init_dev_desc_priv() use memset
Message-ID: <20231110162124.GV6601@bill-the-cat>
References: <20231108192811.1844338-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e8nRt75uiwxmsJ/J"
Content-Disposition: inline
In-Reply-To: <20231108192811.1844338-1-trini@konsulko.com>
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


--e8nRt75uiwxmsJ/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 02:28:11PM -0500, Tom Rini wrote:

> When we do not have CONFIG_BOUNCE_BUFFER enabled, inside of
> scsi_init_dev_desc_priv we never set the 'bb' field to false, we only
> initialize it to true when CONFIG_BOUNCE_BUFFER is set. Given that we
> have a number of other fields here we had been explicitly setting to
> zero, change to first calling memset to clear the struct and then
> initialize only the fields that need non-zero default values.
>=20
> Addresses-Coverity-ID: 467407 ("Uninitialized variables (UNINIT)")
> Fixes: 81bd22e935dc ("rockchip: block: blk-uclass: add bounce buffer flag=
 to blk_desc")
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--e8nRt75uiwxmsJ/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVOWIQACgkQFHw5/5Y0
tyyL9wv/WcuipjNao6Pr2lXib3ek+pstAp/5Le9pk8d37z6W92NlRn/UDlD9PLhf
qCd79VVCZlWXRv55tyvQgGzOoT1ZJOew7HhQXxua2ND2k+oAfomXjsR3KXCE1tZT
knQ2e/0EJbKwSAotINjvB2W0DhrWm3w19qtvFWnJMlPxwnsRADWMf20tJS7yEBz7
NHal+FUOT8PM/n7Are7f6FqeFDd0dE2nZRuALZZQHQCJLO4DbfUqDEEnXimRJUv9
zURfbz4c2k5WFntXyH0YwvdPt5B9IA31DFdR5zv1cQnX0dy1jhqPlnK4FSoCxYpY
p0D6ZtOQde6i2gThVU+U+hO1+GmB1gYoHkn0RR5bc4MqlDeRrO5MA7Er9XgmxOlh
GgdMbNTZZ7VObZTXA66t5ui4q/mb+sGtsOkdbgy1cW6lGf9OiA64oupseIs/cXIS
Dg39hUILGddRX3jSpBFLS9kBbQdz3OvFRgVFWJJS7QodexjnPA6PqSAhNwqJ6E7q
sxvYsEXT
=3iQ/
-----END PGP SIGNATURE-----

--e8nRt75uiwxmsJ/J--
