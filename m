Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68937CAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 16:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88BC7832DA;
	Tue, 16 Sep 2025 18:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kRVyqNLd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6375F83280; Tue, 16 Sep 2025 18:13:11 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4518F803CC
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 18:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-74526ca79c2so2199842a34.3
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 09:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758039187; x=1758643987; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R/CZkh7+hhvp0Fu9bq3+Q4DRH3XNjyumEgOILc1y7Co=;
 b=kRVyqNLdQlV0V+v0zH6SGhNlVngpX4N7sZIdlQTA3f+xWh5QPuh8uyBc3+pLXArs7m
 Yr1WGRuQWsZfvjlqb7RG6uW0pPDxmLLHt23+G13ln/R7XtXjF0kAWhHbr1I0JNLLHTq4
 y5plRvqq/VCfQ/j+Jvv7cp+L10csHxHtm10hI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758039187; x=1758643987;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/CZkh7+hhvp0Fu9bq3+Q4DRH3XNjyumEgOILc1y7Co=;
 b=X+R8YFJ5F2jFDWe3o5rZIH6ThhBk9+GZF1dAA8763W62mPiI7zieevS9sykeg/jlDh
 Rr2cnKPoDrh8/iuiFUgMNgXv2o823NwQkDfILjc7sTBozxqyBdqxNMgfsWR0A6YkGZv9
 qFl12JUMXUwBk1dwYfvbQEvTrjb58cYVwCkzqmFZyI6oTNlLJO7ovGm2eQ8K3s6emQ/z
 z4tYulV9kGwTjN2+KyhcRpMJCQnt7sqa2lGWAJlJ6LQbOEYTCF13lsqHO3NOSdw0JKvJ
 n7a6jSF8A0qiGnwpvTaLXM0vlZZ7QzhwOGX4l1Co0Suz6oB/fHzqKe676wkw3v/xn6vK
 YYAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMbre/dEdP9NVJqd8cTTXOIjXJ+x2qOdS13FtBc9ue5cCijyX9bsoQKtEtwDCxW7sz5W5p1Jk=@lists.denx.de
X-Gm-Message-State: AOJu0YyVB/VWxc93pvbQ9Ra4ELuoMVcM51sCyjNerdCaKbkE0o+0RRQT
 Y2KziyP6ZNqpGCWel1oDtq6iYzTen4lYsfnyjMwgTTkQUkTxnXiKX0oHuL8HSy9j+1E=
X-Gm-Gg: ASbGnctztvm7ZJ1qFrdkZVgPQOa7QqD+7HhkGe1igdzKiqvHZ8wOnpaTds3/zn7JFPg
 HNH2Zr06Z2LXaiTwtiGNqDZju/xQjAl0IAYKQJaRbP/kmK2b26Iw3kvurjIeAEZx8L0e2FogQjr
 zIZc2kXkkWnNrrRKFMLpSL2/uffmgkEfOySROIBtUQ+nES72O/dybouVPmsSPM7uo5gv3yv7i2u
 qzfL8kq9ydvGIjNaDKW2MAMLJVTitg3STnjr9+gC2Q5ntp4yvOKfcOudAM9xFxwHZi5dnZEWC+w
 HXMHp0Evqcp7hefqOkOlUpgaz7Tt5w3CBoL2RhddXMziDBtWJM/FMPO7kKSOpOPcb3dPZm7dpRp
 ev0sfg4pQLjAtGv6okKiL10FPKSTi50Z2FuLPyX5OBDIBl6tft9m3HFSj
X-Google-Smtp-Source: AGHT+IGpKumuLT2ycYM8r0Ik8KbQtqMggl6qY8RStB3gNWi/FB+gEH5JdZ3ApIc0uu04CHnUDoOFwg==
X-Received: by 2002:a05:6830:6a88:b0:745:9f05:a233 with SMTP id
 46e09a7af769-753551db39dmr9608670a34.22.1758039186916; 
 Tue, 16 Sep 2025 09:13:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-75906b4aa9asm1655287a34.28.2025.09.16.09.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 09:13:06 -0700 (PDT)
Date: Tue, 16 Sep 2025 10:13:03 -0600
From: Tom Rini <trini@konsulko.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 alice.guo@nxp.com, u-boot@lists.denx.de, ye.li@nxp.com,
 peng.fan@nxp.com, ping.bai@nxp.com
Subject: Re: [v2 12/12] imx94_evk: Add i.MX943 EVK board support
Message-ID: <20250916161303.GU124814@bill-the-cat>
References: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
 <20250906203743.3352805-13-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o+8rX15tkRZZd3Vs"
Content-Disposition: inline
In-Reply-To: <20250906203743.3352805-13-alice.guo@oss.nxp.com>
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


--o+8rX15tkRZZd3Vs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 07, 2025 at 04:37:42AM +0800, Alice Guo (OSS) wrote:

> From: Ye Li <ye.li@nxp.com>
>=20
> Add board-level code and defconfig for the i.MX943 EVK board, supporting
> multiple SOM variants: 19x19 LPDDR5, 19x19 LPDDR4 and 15x15 LPDDR4.
>=20
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Acked-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
[snip]
> +initrd_addr=3D0x93800000
> +initrd_high=3D0xffffffffffffffff

NAK. You can't disable initrd relocation (nor device tree relocation) in
default environments. That's just setting others up for harder to
explain failures later on.

--=20
Tom

--o+8rX15tkRZZd3Vs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMmMjAAKCRAr4qD1Cr/k
CrteAPoDqxbyXerTH2uDcr5TY58ZfvRT9MkR6P9s46xbD72PQAD/WHspD26LyNps
1lwVBz1fKJIvEx3ODljrOxh6Pz65+Q4=
=dvSg
-----END PGP SIGNATURE-----

--o+8rX15tkRZZd3Vs--
