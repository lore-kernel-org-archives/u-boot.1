Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D3DEE14C0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 17:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BEEC869C7;
	Wed,  6 Sep 2023 19:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KmIbVAEM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12BD6868BC; Wed,  6 Sep 2023 19:50:30 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F22F6865A8
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 19:50:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-d74a012e613so38479276.1
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 10:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694022625; x=1694627425; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=POBdhhbRS747zIXKnDZWxzgpcJ+W/q11eEmOrPUL8is=;
 b=KmIbVAEMkJg6omT52bw3kxGU1lprqIsEshf7bfVkTihy8KVDCPG3rGl9dmaXh34sjS
 kvKj9yp5Jgbulee122oKY7dB5N+VmY8qM+bbbNFLbAEdaEQW4K+FpgQ76t/K/9a04z3S
 S0SYNChbJPWnO4qzMZ0o4tTS7Ygfz3tp+IfPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694022625; x=1694627425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=POBdhhbRS747zIXKnDZWxzgpcJ+W/q11eEmOrPUL8is=;
 b=l8z8FntPZfm1/kiWbnrb4Ihp/owTvGXY0tY6H2uYPWtri+FLsb76Yo7BElovIb4SAN
 DRsBOxuVTieAVMk4+kLJa8rEZhxmdWa+OMpSKgijChb/1khCt4+btEx1J97qVVHaQbYi
 ie2fnQGhYcTA82A2Bf3D958uf/Ezqg/S1kCmvk/ZQPEbNVdYHKKI+PPA04GAQzxcj8o6
 b0sdckAo63n75P1gXazDJdEh2iZifGdL5DhA9jHHMLbZXY6SlEgc7wOizLzb1DEAR4uv
 F4uMNiuL8JsJYAixMdJLbKkjdx1bWkzGiYFwFOWhMo59TqfGllmd+2yPB/Zo/3yKuYow
 hPCA==
X-Gm-Message-State: AOJu0YyVS7yYz4tcxLUTgpaHyvsh7uZZFWBcm+d/DiO8qPxyFbPVGIzm
 mXZ+kZEgnEyqUwydgoMwSynBhg==
X-Google-Smtp-Source: AGHT+IETrZKX4W4hSRvHPK2H99W9220a5Pcl7tKoev03uEjcdBToAHFZCK0d/YIfOA1D8/JpSUCR+A==
X-Received: by 2002:a25:2601:0:b0:d71:6f6f:73da with SMTP id
 m1-20020a252601000000b00d716f6f73damr341946ybm.6.1694022625704; 
 Wed, 06 Sep 2023 10:50:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-06dc-de6d-386e-5d48.res6.spectrum.com.
 [2603:6081:7b00:6400:6dc:de6d:386e:5d48])
 by smtp.gmail.com with ESMTPSA id
 z66-20020a25a148000000b00d7b9fab78bfsm3406296ybh.7.2023.09.06.10.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 10:50:25 -0700 (PDT)
Date: Wed, 6 Sep 2023 13:50:23 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/next
Message-ID: <20230906175023.GH305624@bill-the-cat>
References: <20230905134915.15105-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yc0Kobznxugg/MTV"
Content-Disposition: inline
In-Reply-To: <20230905134915.15105-1-marek.vasut+renesas@mailbox.org>
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


--yc0Kobznxugg/MTV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 03:49:15PM +0200, Marek Vasut wrote:

> The following changes since commit b53ab97150314674edc25508f4fc528be2baa7=
3f:
>=20
>   event.h: Documented some newly added portions better (2023-09-04 11:19:=
50 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git next
>=20
> for you to fetch changes up to 733fab7177ea3c0402bab9db07422d5dce495139:
>=20
>   ARM: rmobile: Clean up rmobile_cpuinfo_idx() (2023-09-05 01:13:35 +0200)
>=20

With a quick rewording of the commit to fix a typo, applied to
u-boot/next, thanks!

--=20
Tom

--yc0Kobznxugg/MTV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT4u98ACgkQFHw5/5Y0
tyy6lAv9HkXgjcjbYn7h8U3eg8s13SNfFetl0up4Zc+C73on5/BNtGpIyPpHczj2
EiDvuCiO23ynYKegVis/RsJBf63HU8vKfuFhfOXhvugVMZT3cfObRjaCvRbBBtIL
cV3UcfpFisB9gaEpIiiHdS95Ula9rBBusGR0+h0/Xx4r16uGl5PPjynm6C7WQ1td
asIypLDM7B5YZMQ03fRDoIL7nA/2C17mV587SvqHhM6mAcSFl5Nu9mlszWvWpzyp
ttazOYMhUsJbxwYbvPdqfZQiSEDCI15QXKMKGt/Xxew9X6qJ56K6MdQAFZ6ue1wP
CjhcJcOrp6ZKb9KMlcIL1JHDqSzS4HaufNcB2jc4Of4qqQhJ7WktIKpRxIG27uTz
SyPNs5lXq805gpcUnOwjZM8fJvw9GDNWnHaJVTTtC6yhUX15469WkW3vQtcd8mj/
PWLwM0LQc28JY+7PZ1Wflib8ZoxKqkLlOI+fuRD4I65lpLPqNxe+Fy3ZPLVl22Ad
1JTvtc/+
=5wVw
-----END PGP SIGNATURE-----

--yc0Kobznxugg/MTV--
