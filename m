Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23153C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 23:45:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6644F87FC1;
	Tue,  5 Mar 2024 00:44:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ueW8o6da";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73F1387D7F; Tue,  5 Mar 2024 00:44:41 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71CFF87FB1
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 00:44:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5a1206ba5cbso1247221eaf.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 15:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709595877; x=1710200677; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=63R62Ti01Y62Bk3NoIZ4byvfeQD7FQGRz8YJ3pgPNrI=;
 b=ueW8o6da8aLp2uYafOwPQFyg+qYR+D9qXWjL3/YGEaPF6R8wOR60NnHSOI9FKgChWZ
 GPKg7fv8h3tR4dgaPRximOIy0fzg4aAm9M5AcRh0nnHBMurNe+YgJXE2ZZOnmrpesPqf
 ERwqPcenW3DtZqpcK7nv5+lK+ggMbkSU2OLww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709595877; x=1710200677;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=63R62Ti01Y62Bk3NoIZ4byvfeQD7FQGRz8YJ3pgPNrI=;
 b=f68egvTcoMqymNrmQBHCa2tpnr0Cz10vMKd2OFtW9FYEJWYdoodtiObiNcePCOwCFZ
 4//ASOg4eohXNg/ssSrplGvwiAvr9bu6vwGxp7cgEf6H5T9EZFCVgZyNUwQ3fS2xsUam
 frcesJvt178Qq4XGg5H2yxcs9NHTuwpmhc9F4C3xvljBZ7b5fy4rECFoDJ1VJel/+QEQ
 TcSCYTekozun6+r1SLiy94S8QKEv8lbijJTKYUt287AuV1Q2E7q8iZExz8pdPoj7WEZF
 N/MqT4kuZmKH9QdlIoFi21shOR8yuXr42iDCPqnFsHaIzWD+oFLlxC58BXCj+7/DML1O
 meug==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0mtbBBOp8kMC6DX+Pg+WqAG7prYXTqvK4ElSfRJcVprSscalDzWkuL6GSilaXaUTkxsWjO1+gkwxqQVq38KaaCU8cJA==
X-Gm-Message-State: AOJu0YzjPzD3M2oJw/8fl0M1ENStFw1+zw0zVxgwYFsmhC4p1ZhBHY33
 loUXizr27Vn4n90Io/Hk6SR67jkluoHJ6fZIIJuKAYi23Qj8bNwaOCG0v+GowsI=
X-Google-Smtp-Source: AGHT+IELzIyZdmZaZAcCtnNS/V1kCBJIS9JJDUFCD4K11y/Hnc0RqOol9JlS1wV3HAsw6OAFwjWzNg==
X-Received: by 2002:a05:6359:4588:b0:17c:1bef:4077 with SMTP id
 no8-20020a056359458800b0017c1bef4077mr162533rwb.3.1709595877009; 
 Mon, 04 Mar 2024 15:44:37 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 mf15-20020a0562145d8f00b0068cc0b46682sm5662374qvb.4.2024.03.04.15.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 15:44:36 -0800 (PST)
Date: Mon, 4 Mar 2024 18:44:34 -0500
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/6] arm: mach-k3: Move SYS_K3_SPL_ATF definition into R5
 Kconfig
Message-ID: <20240304234434.GW1523872@bill-the-cat>
References: <20240202002448.1116407-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Lt0rbnSlMMrOEcnh"
Content-Disposition: inline
In-Reply-To: <20240202002448.1116407-1-afd@ti.com>
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


--Lt0rbnSlMMrOEcnh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 06:24:43PM -0600, Andrew Davis wrote:

> Loading ATF is only supported from the R5, move the Kconfig symbol
> definition to match.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--Lt0rbnSlMMrOEcnh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXmXOIACgkQFHw5/5Y0
tyxGcAv8CLZmlTbYa71t5NCkNL0fSz1eU97VJxpiJ0rq0UtD5G/520FyL+kEJUPY
cGKPV2IGEjpJ3bq1kT86FiHMpbuDhthHZ4gRkRwwmn81H0wJ1FSyCqnPZybB53Xg
YWGY7sNkx2CCsjGKU8dyVQrIrcy6knkjX6f+9sEIbadAJ9HLjJJFxOEuuRWn0rix
0ZJxeKlmtC+dG0AekKkQjjH/KqINnc+2zIds3Bk3PwtsBeYZdsNpGfEP5dcY3XV+
WgrEPgeekqw8jP23GeJTlY3OlEjA6AVh3/oJ2voSCPJoOAX32+j7YMSrTDt96XWl
Z2ousCWxIPMxntECS07cJUFxnlY4uhoD3g0Wz0SsQNoQg4TxpGOOcop+ZAt6RJui
NWxSgu8RCnhIYHRmxcp+V6MbCI4Cs3be8OQtHqeVQzZSZq7PNvcXAeF4Rke5Tx1f
3ha/+bgNmw7qMpZcpAskwfE+PPnIZNJkpz5gYPe5lW/3OguXv2fYXpErVb/bQP7y
Uoo+7XV6
=rC1I
-----END PGP SIGNATURE-----

--Lt0rbnSlMMrOEcnh--
