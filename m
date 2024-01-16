Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFAEC47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 16:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A97C8879E7;
	Tue, 16 Jan 2024 17:49:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZPNnPBPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1747879E7; Tue, 16 Jan 2024 17:49:13 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7361187985
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 17:49:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5fa52e173f7so66570117b3.3
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 08:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705423749; x=1706028549; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Migj71t+Wdexg9n8o0A3HH8rup6/oQMT7jgOv3/l8m8=;
 b=ZPNnPBPdWK052y8g/GrlSfEwMlrtnyvWszLFHIbfq3j1pb+maA9hq1aF3Xq/kqla3I
 BSUra494mtX5H9Qn5cXE5nsCHlR/LkqhYlZ2GIEMmhfwmVfbDG8qVMnh/HwH55UDY30/
 TXrIPPmpoDJ0gmLag4Z5RAawSJM4V0eXQL3yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705423749; x=1706028549;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Migj71t+Wdexg9n8o0A3HH8rup6/oQMT7jgOv3/l8m8=;
 b=GDf/VR4QaJ3z4dDIz8mIwLz7JYxcKwGyAI0tY+ZPmjeZl5mi7YbIHC/l0/vjpwPu3r
 svl1H5yypfVbp6TqTZTtAbmohT2TrL7qjXQeHEOKhU+5WYJKW0H+ybyowAJ4tgmnFFHF
 eE/YHOHf2gPLI9XPB6ZgbA6W63APBnAZM8Qf5SJufd06GZcjTIAlHy7n0G0mSgUoOh5Z
 ZD5IWT/EqnmLEDJ+Pd3EchCn4AhBg8ak6J225gMgqyitQwXJLNqMC7s5mzELYo82qlrA
 loXXxO92ZK+fpoLweiECs8T88mQM+D7tsLj+QRpgOo0D1N90TMKjOb8vAmlyzltErJOY
 vfyA==
X-Gm-Message-State: AOJu0YyivyZOSg3SMXwGVLvVHVw3x6bJyy33fzkUeB6f5PYZO5f1uKFj
 aR/HlQpSPAxWuJfB1sgDzHxV6U9iadW+F/mGfFpqJCceX5c=
X-Google-Smtp-Source: AGHT+IEzvxBTAParDLHParXxdwDRj8CsTQT7iZ7xUNcwn8gCch4AIaZ1zm8gTB5f1x/CuGP+fHWlLA==
X-Received: by 2002:a05:690c:e0a:b0:5fb:a07d:bfc2 with SMTP id
 cp10-20020a05690c0e0a00b005fba07dbfc2mr5893162ywb.28.1705423749247; 
 Tue, 16 Jan 2024 08:49:09 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 o8-20020a817308000000b005ff58f04043sm459286ywc.106.2024.01.16.08.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 08:49:08 -0800 (PST)
Date: Tue, 16 Jan 2024 11:49:06 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de
Subject: Re: Pull request: Please pull u-boot-imx-20240115
Message-ID: <20240116164906.GE12635@bill-the-cat>
References: <20240116024554.3316040-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SE5zktj0Z+kYkX4W"
Content-Disposition: inline
In-Reply-To: <20240116024554.3316040-1-festevam@gmail.com>
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


--SE5zktj0Z+kYkX4W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 11:45:54PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx, thanks.
>=20
> The following changes since commit 547d3dd28a46a18d59e00a153c8becca8d4e8c=
f9:
>=20
>   Merge branch '2024-01-12-assorted-fixes' (2024-01-12 08:34:50 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-20240115
>=20
> for you to fetch changes up to 662e7ef7f0e84114dd58d77ccdcfdf61d1a0df31:
>=20
>   arm: xea: Add support for boot image source descriptor in SPL (2024-01-=
15 10:55:42 -0300)
>=20
> u-boot-imx-20240115

I would appreciate a brief summary I can paste in to the merge commit in
the future please.

Applied to u-boot/master, thanks!

--=20
Tom

--SE5zktj0Z+kYkX4W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWms4IACgkQFHw5/5Y0
tywCXgv/SRgoNSC0Gf1K6cRoQmZwUC7sMtm3R1exxte0F9d68A4ws+J0VtUcWoTP
E9B5H2o9JLUU6xiVvFK6xfp8Fcu5XWCTkfoFFOoYBdoH8bezTyndxsWAB0ADmAlv
3GYAfCahtVUwL+Jq8x5klAIOHNZhEBma83FLC4RVj+hbzddSr1VCGKsFD4ZVSThV
zSkbkMu3EMNoneIdJB/eq3aNwxM3dVSeLlcM0CKhbfwRWbBQSs/0WXWd8tShWRpl
DsWN2DGr0q3cipHP7R8t1anWyEaG2Sa2W7R6BDOqc1o75wWxkvhOQCS/tAFSgBaN
H5p90qplv1T9ujMGFg74n5MOdYHz2FVjpL0yEqC8fEtv5YQAx/QHn7aEiPuAONIv
tXltmbAr3+2J9nzRWZhQTi1VAvl9bkwKk+FhxMCSkr6s+bHpnqYzOYnPue0tcqF8
eEe1gXt7wNOmwbbxFgYGUSVbahzAVs0FX/w53iGC3dlE8YppwPoBfqWQLHDOQetx
coMVIO+s
=0kv1
-----END PGP SIGNATURE-----

--SE5zktj0Z+kYkX4W--
