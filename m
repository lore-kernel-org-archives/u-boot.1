Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE677D3ABCA
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 16:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 388FB88EC9;
	Mon, 11 Nov 2024 17:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SEIcxEj/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC6A888EC9; Mon, 11 Nov 2024 17:11:59 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 647F088E75
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 17:11:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4613162181dso35422911cf.3
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 08:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731341516; x=1731946316; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JMRMhY9/3sDLiIt78BTgjQKgfEZozy9af1wHD2Yi828=;
 b=SEIcxEj/AY+dt1LhFfZTIu0tQOXaXXq9mcDDgVJrBkXDSesAH7j3vPJM05wZUOTzRl
 5k9oujkEnvywqZfYcBRl+AvJOhITXhejiUXKD7xRGqPw3wV6fgzn/mn9w9AoJqCJYyOC
 29nsh00VXvMcIAHHWBE2gNbGgpm9FLmbRS1F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731341516; x=1731946316;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JMRMhY9/3sDLiIt78BTgjQKgfEZozy9af1wHD2Yi828=;
 b=aZ0JBsX3BD9bpUJKmwgvyTCZj49XZuE3K9uxhb0AzRqYXcl/Rnn2HWihqpIH+jTT2q
 R4sZm04EyRa6/Yyp1G5YWJGKilqP6CCKVZEZOFhND8kfGv946nP1hkdHe0ktI8Gh87gv
 9D/xWReYi9xMFAUDhMceyKUxw+2XtoFgIsPLcgLv/1DGoyJvFCWAbVKDrf21wsluLgrc
 unD7TggiUE9gKZbz0iIB0HVwUOWE1kWOWfpLK0rloo3owgzVUHQXcKJ7uyM5ljlTGDD1
 jb8tfZ6jif4AeCjM2XbZ3tiFzoSdboPj3cFZUZzWlsKLhZzGoRnx8IpGNAul79m7WFqJ
 g+tw==
X-Gm-Message-State: AOJu0YyxPOd7G5QYOyTw3QjQymIFkv9Mh+afKaEdJGlOUQyXpC5B2adu
 YRhwTMMLwSSmQMWFHeuWMhmkL/wximY4V0GtKrEbUePDp/VtAd2qk/faYKwhw4Hblno5ac8AZYV
 NMO4=
X-Google-Smtp-Source: AGHT+IGSF/RmXlwYLo0easw2wb/bsAZ4ulodvZr3uzGCk7rZUAe+2G8Srm1XbkoCnQuquxLOJ2wjLQ==
X-Received: by 2002:ac8:6784:0:b0:463:17d2:4b8e with SMTP id
 d75a77b69052e-46317d24eb4mr82793971cf.55.1731341516134; 
 Mon, 11 Nov 2024 08:11:56 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ff3df2d8sm64234291cf.7.2024.11.11.08.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 08:11:55 -0800 (PST)
Date: Mon, 11 Nov 2024 10:11:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-20241111
Message-ID: <20241111161153.GU3600562@bill-the-cat>
References: <20241111095800.293704-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QtuixkMUNbb3mBPz"
Content-Disposition: inline
In-Reply-To: <20241111095800.293704-1-kever.yang@rock-chips.com>
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


--QtuixkMUNbb3mBPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 05:58:00PM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> Please pull the updates for rockchip platform:
> - Add board:
> 	rk3328: FriendlyElec NanoPi R2S Plus
> 	rk3568: Qnap TS433
> 	rk3588: Cool Pi CM5 GenBook
> - Move rk3399_force_power_on_reset to TPL for puma board;
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/23280
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit 56accc56b9aab87ef4809ccc588e1257969cd2=
71:
>=20
>   bios_emulator: fix first argument of pci_{read,write}_config_* function=
 calls (2024-11-04 18:01:58 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-20241111
>=20
> for you to fetch changes up to 0a17123dedf827f4ca9b158252279adf03906307:
>=20
>   rockchip: rk3399: move sysreset-gpio logic to TPL (2024-11-11 15:14:15 =
+0800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--QtuixkMUNbb3mBPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcyLMgACgkQFHw5/5Y0
tyza/wv/U6uzWTZoid+r5g6sS3B7NnV9bKVxrFZOzvcKiB4E3AmNaedE/39Hei7G
4AY0gYMm0zKBeQ400+jnVjA3cBTxhWfXrNNOJUlp0E9m2hfU8/NfqqmJzh/Ovxfd
VjUwTlruhrUQDzteHOChPgIqF9KyTTMm9iANjfDJKTT1lquiRSB5tyXWkIKi5qH1
owJYpYgqwp+2EYzCqoBward823EcQ5W0rx3je4q9siJRsUwxqnwjQywIMOuWP6/n
lRVVTFPAOn7zSyRvxY0d3/iFwUs66U7NRH3W9n5vrIH8CassntX8dw0Op4+jVMAj
SEeU6HfQfbJJmf4HbMnSB/jBNlTtmT7beSevVZg0B3tU/mb6G/JFfAS0sr+JRtwR
DQsJKTMR+1Tn/5NmVIHVItPoFkCBkxM1RFulbkXVCqlqXgIE2j4Tw1UrCebMjec9
B4ErdXM3cS3o4lrEczOCJ/6UpJoE0wsnn5cedykPrE05VCAaX+sHyjWbso51omW8
Nq3vXzwd
=Tkpg
-----END PGP SIGNATURE-----

--QtuixkMUNbb3mBPz--
