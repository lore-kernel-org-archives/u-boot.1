Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5627C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 17:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36E73883A4;
	Mon, 17 Jun 2024 19:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GGsmGS2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3FF7883A8; Mon, 17 Jun 2024 19:23:54 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DFFD88263
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 19:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3c9cc681e4fso2305687b6e.0
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718645031; x=1719249831; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u7kghxB3dwZC5zy9Dzlq03TjHw9/uTR6Z3trlgyMn44=;
 b=GGsmGS2+aga5EDWj1HD5eMIyfNgsfx1stnUQsc4QnTHkdCtELshyZNtZ7obqWvyi9c
 40ushQDA8oGuIWCKgVcmCJ07+R44lKFXhysX/Hs1mXUiGFSmPk5tRGESB1Lzj9kTTA8R
 YbyMUH2vJG30YwH9BlgnFgi5SATOF78+2BYkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718645031; x=1719249831;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u7kghxB3dwZC5zy9Dzlq03TjHw9/uTR6Z3trlgyMn44=;
 b=u4cOsC0a29+DhqVMMbwKW8MSq1cVE0bhGOXYI1uVGfZ94sAneDQui+0mT+dQQ+ubjj
 rjccuLjn7m0g93ztzewXq8i74YHGI15D36OH8wdX2G//5qvhDh0JjX99cwTVvJUbp12b
 HQeB+jY/bXH6b9vzCzXrcIPFqXk8x/zrpTrTafxuFBtr3gw+QoUsDF8NaTnkf0LioAj6
 zHJ39SkehViAjY/eK/xNz9O41xhNkDaHQmTwb+N8di3uSIfXfmM4Cm1AaAx2XLk8WqAE
 B4H7tlPZ22YjQ75RpJH+GwM4hTlGF2fiM0GVVgNmWJKGa/Xvjo/QIAgINJp7gHLu6uo1
 qDVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL1fXlhLSqxlU0wGjcy9HR2JZMRlgiFdclP+hLd8o3u/0ZvrxSLe4C5zFg34kaL6zI5v/M4qeOfnz4w8Xqs+vGBh+L5Q==
X-Gm-Message-State: AOJu0YwWq0Ipl4FdAl5m6QKJ06Kig7474L/0tUN8+J4FxbaNDL9hHbyU
 ZptQ5kd9pzSLoaDBf40Ve7TUQ7m7vAs3ungBZgIbwcYiddnhRrw1kKLRjd8IeQc=
X-Google-Smtp-Source: AGHT+IHO+3s1f6MWOIN3NJOWSxJWHzWX5We8l5wP78tHT+Tvw5qPJFsUmA6fkJ6wf6F+9Rsh9yJ2ZQ==
X-Received: by 2002:a05:6808:bce:b0:3d2:17c9:23e9 with SMTP id
 5614622812f47-3d24e8c0060mr12712865b6e.4.1718645030717; 
 Mon, 17 Jun 2024 10:23:50 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d24770c946sm1543603b6e.58.2024.06.17.10.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 10:23:50 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:23:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Marek Vasut <marex@denx.de>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: Re: [PULL] Pull request for u-boot master / v2024.07 =
 u-boot-stm32-20240617
Message-ID: <20240617172347.GA68077@bill-the-cat>
References: <37292e6f-b25d-4cdd-aab3-e851cc879009@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zVGdlERd+YOlR5Ci"
Content-Disposition: inline
In-Reply-To: <37292e6f-b25d-4cdd-aab3-e851cc879009@foss.st.com>
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


--zVGdlERd+YOlR5Ci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 11:06:24AM +0200, Patrice CHOTARD wrote:

> Please pull the STM32 related fixes for u-boot/master, v2024.07: u-boot-s=
tm32-20240617
>=20
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipeline=
s/21155
>=20
> The following changes since commit 2248c96ea1cf0b65377040d9f87ce7d8cf534c=
63:
>=20
>   Merge tag 'u-boot-stm32-20240614' of https://source.denx.de/u-boot/cust=
odians/u-boot-stm (2024-06-14 08:13:54 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm=
32-20240617
>=20
> for you to fetch changes up to 9968e8dbf3887c692dd7f2f83bd43678acd394a5:
>=20
>   ARM: dts: stm32: Ping IWDG on exit from PSCI suspend code (2024-06-17 0=
9:52:38 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--zVGdlERd+YOlR5Ci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZwcSMACgkQFHw5/5Y0
tyytvQv8Ca2WiakFYX0idO0c74jXpa1vS9d6iax1k1g0aYeCnANJ76ovQEwxZwBY
3cIwd5n3Rm5vbq5xuUWf040zW8hCcMYAF2oJVj6+DgeUTYTT+d1y+IM1bdHfr7RJ
6dZJ8HVfoSimLnOwUEXJ2qrIfJtmwKD+Dg2qZAIYUoiJyiuPaGUBXyz8NqiwDnBv
KUatWYn6kX8sWxVi+ZMN2S+6AHgXpBcpIt/4n0bOX+n8Ap9wF5Apfq+lH3LxS0qt
P1LuoNzi0Ky+valWkWghlt74jrvxSR7YasoBOwa8dY5aXtnIN8OKCtaDtw5ZEGo/
ZtwbK/U10JlFnkaguHS/s9ibWIsvyMiKnSe7GGjmeq12a4fz2dUEZ1HLnKsJMRGZ
LS8QWA3X36OoZDH7tpMrTdn3IqxuMfGi6WC+FnYfqx5qm9QrSCgQdGq7e1osr8Eb
FTUBWI3KpPEONZuru43xjq3JscCnNob+EniL10pSiG9P/BoS1Td+muwZflTGjMyP
Nrnb7sdu
=f6Z2
-----END PGP SIGNATURE-----

--zVGdlERd+YOlR5Ci--
