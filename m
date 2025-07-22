Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34E2C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 17:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F2C6833C0;
	Tue, 22 Jul 2025 19:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uDVkfPYE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E8B833D7; Tue, 22 Jul 2025 19:27:57 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17A828339C
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 19:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2ebb468cbb4so5081532fac.2
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753205273; x=1753810073; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TF37lrux7T+6Ic6y7Hq+vws44hjeLrgTqbe2jliiz70=;
 b=uDVkfPYE+BAU5Tu/q1e5DVHct74fb3UCq+uiAw1L7qB/ZDS0cSMbRoKwcL/eGMZERm
 Xcqwt6KhTJVBOo+iO3dc8McImb7bpFo8EWojZ4MbaJYZNwMZnjdMDZPFZabmfkPteHml
 Dopyq74TZlN4qrIPH8QhPTSo05Td4KbmKKpTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753205273; x=1753810073;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TF37lrux7T+6Ic6y7Hq+vws44hjeLrgTqbe2jliiz70=;
 b=iUNtnjIEPBDZzb7q1f9CJYtMjsH1FoQARfjMtygCxKMhsNh6cecr0xZMp6wphDhkSd
 kyws+mvVCn8mUJAfufXTrR8lZYE7fHOHX+1K5+xC4sT2q9zy9z9Q2/p9VyJy3MpKfJLQ
 ssLl4FVfKPEZ1n6oPHF53Y9YuTpl9y2Cnw7l3riqycV/foPZNdeuXWTJukrsF4rqxE/y
 dQQuprFJKc68hSs53dz8pllbp7AsL2sQVhUJwaYMyeuYr8K0jsYhnNsHFJBxemK8OPxh
 DDtGZH0oUgKb1I4MFgEY4g+3EwM+13NYGYjGzKzcAwIPNwmY04NrI2Rpge+PQpDI6Qw/
 xptQ==
X-Gm-Message-State: AOJu0YzdbfcrKETc/Jlyvj2jlofKJNael3tP/2YHSn2iZn/SqdBVfeUw
 q3h2WBSFd1Zrqx2rGPv15bGbJMjj6v3EsO77IFCJb4GvnZRuG0yeKDrA4s2zRuEvkhA=
X-Gm-Gg: ASbGncuWxY0dyjH+tCvATb85cXLhZMYXpI9XnqIdY0LqF/9xeF6I6YvEeTa1BNxFpQs
 m08NHymoXXEPEz5r4df/kJXvJPZq7vUkUaHn/MBYLdxF/gEtHKOcSVClPALVr37GAULQ3LiA1PH
 0mxAPp79PT7hG49ZlAKQ8y7Uq849TZHOgzwqh4olYxF3H9oUf9Q71QdoO8xW/UzBlZzFNAEhLhM
 1xjuLDFCSovPLYHn2XMaEJwNBLskNJlqXU8hzUiWrCZFpaXRQLIHISEAQxXR/gVjXQEyvI6IdGX
 Rdg4LSbongjLrXYkdTDJKVXACp6v/bFCuJn4GHgYmxXKi57Y5BYxZSPTbkVQ+sd85n3OFqgwy5F
 f53Jkw8JnTkllejwuJ0dS+Si/RRRTDjH+Ojfjf7WQtv6FKTNU9Nazf7y1
X-Google-Smtp-Source: AGHT+IFwaboNe1t6Q729enxeK0Jn2uCaYJPyxS+uEJiyjPztZJouEQOYU3RaAL1LrZX+VXBTjWVy1A==
X-Received: by 2002:a05:6870:71c5:b0:2d5:ba2d:80ed with SMTP id
 586e51a60fabf-2ffb243382emr16686725fac.25.1753205272688; 
 Tue, 22 Jul 2025 10:27:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30101790f62sm4599009fac.4.2025.07.22.10.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 10:27:52 -0700 (PDT)
Date: Tue, 22 Jul 2025 11:27:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: Re: [PATCH] binman: include <CONFIG_SYS_BOARD>-u-boot.dtsi if exists
Message-ID: <20250722172749.GA43479@bill-the-cat>
References: <20250714030327.132114-1-weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t8H1e892lkS0+8gl"
Content-Disposition: inline
In-Reply-To: <20250714030327.132114-1-weijie.gao@mediatek.com>
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


--t8H1e892lkS0+8gl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 11:03:27AM +0800, Weijie Gao wrote:

> This patch makes it possible to automatically include board-specific
> additions to the device tree.
>=20
> Change-Id: If8cacca58696969fbdd3ede6457d8526b05ebe4f
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
>  doc/develop/devicetree/control.rst | 1 +
>  scripts/Makefile.lib               | 2 ++
>  tools/binman/binman.rst            | 1 +
>  3 files changed, 4 insertions(+)

While this is conceptually good, it breaks some existing boards such as
mt7988_rfb mt7988_sd_rfb mt7623a_unielec_u7623_02 mt7623n_bpir2.

--=20
Tom

--t8H1e892lkS0+8gl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaH/KEgAKCRAr4qD1Cr/k
Ciu6AP91/ZYTAGtVXvgtUTE+g7hQyKSRZKgtAwpUuw8YPOthzwD+P8c0KJ5ybvoM
0Saa979357eX5ckd+fVtf9TnTBfxQAE=
=Yase
-----END PGP SIGNATURE-----

--t8H1e892lkS0+8gl--
