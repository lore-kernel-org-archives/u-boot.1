Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126EBD17122
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 18:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67E0488365;
	Mon, 21 Oct 2024 20:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ee1IsP6o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB6A18811C; Mon, 21 Oct 2024 20:17:25 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E6DF88365
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 20:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b15d330ce1so251874085a.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729534640; x=1730139440; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dDWICrz7zdGT/d9OYkg71oIYOETk8a9J0DA+YxEvO0Y=;
 b=Ee1IsP6oo9L7XuCk8HNoNidl8B1xxOlGm+n++sDeeGNR/cz31/Cwm1wJ363zAyEd76
 6d0cHsOFqx5zk9gWaD5tBG3US1qPGxQoBhCfmDB3wYOLmZ3pxap565++F/PHLtnBxniR
 8o7MpqQyUu3NViI5jSt1nJ7MBvjQc6X5TOrfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729534640; x=1730139440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dDWICrz7zdGT/d9OYkg71oIYOETk8a9J0DA+YxEvO0Y=;
 b=oVhRElz4XqELKl/h02fNZGn9Gz42PLua79/tzE50Q1tjSHZ/Y/6K28S8W1kInolUYB
 +a1ZqD7rZOYytY9LOQUL0CAFf00PJ1dW8KcM88Bitxs3aWvehnzS/v9nn4MRCno89RME
 gap7wqi3jZzik5DEDa6Iujf1LC3+1K14tr4JozZkhMI1YpCTGMI/tZf/tzDyhcbkYoYN
 af466hkGlxqpE0h9geUAMc6UyPlUbMbChvuWrc8BmhaE4tGUctcbMrxjjJ65oBZ9eNpq
 oHBDq2uLpZpNcpXpm8VWpRA7IASX4sLxCjv4D+pKktEebMFo98C3fciu8VgaYKBacxhH
 zuGw==
X-Gm-Message-State: AOJu0YxeA8zy2fMv92647A0FBIwtx4cjQ3GuxJ3FXNE5PXcHu5qD8Qyb
 A8rpeQZzmCwCir5RkyPUBN9ApO9Wvz+M88q19GJv0th2BqXT5EDXNbltxSDohDw=
X-Google-Smtp-Source: AGHT+IH7b44YniS2Jc2YgdhU2bL43b0WTTDLktivaln+CtIYUeyq86qPj+NKt3Kh0Tdp6ES9UrUVUA==
X-Received: by 2002:a05:620a:2a03:b0:7a9:acd5:1b08 with SMTP id
 af79cd13be357-7b157be3155mr1549566585a.51.1729534640533; 
 Mon, 21 Oct 2024 11:17:20 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a5c605sm195867685a.74.2024.10.21.11.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 11:17:19 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:17:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Svyatoslav <clamor95@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH 1/3] common: Drop check for DM in initf_dm()
Message-ID: <20241021181716.GR4959@bill-the-cat>
References: <20241021155133.29557-1-sjg@chromium.org>
 <20241021155133.29557-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i20yiY22o9PnqOpj"
Content-Disposition: inline
In-Reply-To: <20241021155133.29557-2-sjg@chromium.org>
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


--i20yiY22o9PnqOpj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 05:51:29PM +0200, Simon Glass wrote:

> This is enabled by all boards, so drop the condition.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--i20yiY22o9PnqOpj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcWmqwACgkQFHw5/5Y0
tyzpuQv5ARez0pnakBJXAie6ZnbNh3/kp2AWs2r/MJILgPdcUf69QXsBayqeY+hN
N8x2/40w3pTgOvwOpQg5DnNVz4Rif/GbwKEcAwShq7HzNmfNChIhSFhHtGzqcELp
W6yCNEPpUv+yFilukMf/s14xnpQfYi5sfg6azE4xy2KkpM/BUUqYHZ73mI9SrVCo
mIWluBDuiJ5N26x+i8XPXtzpl6hf7jy5KJFyGiYj3YO/zw7FPX/09zO0gmo/qbXe
hvNaUbE87KX5LauEh2mifVVRTqGr2dzBqMZpHaCdzxhS7coLQjGYjjcaEqp72h8N
nGHUpjA5I124jsqYdpMV9DuXP0lqr8H2eAM//W3CwQwSVhbJScC63pk605kyHjnp
WtegrVsVIQQmOv6mef/0EORocZzfRNhB/ezApKQ4tDWmM0ohR4OSIPrTyv8JSyxk
uoPDrxnKEB7DxLuvIEVbibfoxLV1WYP3H05/cWX8MUTm/SoFUg04CxFffY2YMZBJ
Obl5KHSV
=4CLb
-----END PGP SIGNATURE-----

--i20yiY22o9PnqOpj--
