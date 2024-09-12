Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC512EED631
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 17:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 765A5890E9;
	Thu, 12 Sep 2024 19:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tHaYClhx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B35B88D7B; Thu, 12 Sep 2024 19:45:02 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FBED88D7B
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 19:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7a99de9beb2so76649685a.3
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 10:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726163099; x=1726767899; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Wbj5it9R/YDh7k8RY8R56VSmW3GMgjTNW5k2UqxTBKo=;
 b=tHaYClhxSJZi3Iu/PXTBViqRIYunOj4sWKqLvyijAwHqD2HrRpC4qaCR+pT3QCvgYU
 XAX+GAZQfxKfgS6RXwGdEJPOgtds/se71UIzbQ+BsKCoeUOOXZY1RGxlfkpygHwhhfT3
 Gz0XQgCNvkj4usvaeNnj20+7vXw7I9FOgxepc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726163099; x=1726767899;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wbj5it9R/YDh7k8RY8R56VSmW3GMgjTNW5k2UqxTBKo=;
 b=ScTrgjC9nNE/r66pvLEDQSDChkYcCJ1d/p4DUTRcHWlNy50Z4iXbtVCwb4tLpsKvVM
 SIDg+C4P5Y7/oBTgL/e+YG5hxnb/I+n/MAmvWRp08wuQAmk3hq+dQDtpxCsuGrT0MaT6
 Q3Ff6Er4WSn7DtBTBQHJCCELNVhYoPoc/MzNoq2yVlQE9F7OotnW60x7JwWlGAK6Z6JH
 aee9YPAmXxZbMZ2qwF4dcAnTCOR4t1uor1UxfifR4oEtV5gD0DtykO639+u1lITXpok2
 xZLU8ij9tRpNRrwiPxVISJyxUuTpbR+EYqOYc8ThNpkccxOVNfUy7ZFUM50YLkWAq3lg
 EWhQ==
X-Gm-Message-State: AOJu0YyBWr71wWLb/GvIEZWhZ567OyZfwtN7mWTgzYd3Grs9mdtqY+DH
 Lgza+3tRlXZLsQ3F7tWLEw25hLTdWrigKoPG6rhHI/HgQeoE8zNNzsLDcHleJ+Ngw4scuv1CrUI
 Kxgo=
X-Google-Smtp-Source: AGHT+IGDpGpgwI4Uo5WM462sSLMkUC2xS9oftmV757FiPOXShbYzozhN6JYyL+/Bf1rEXAELNG9DzA==
X-Received: by 2002:a05:620a:198e:b0:79e:fb23:1eea with SMTP id
 af79cd13be357-7a9e5f1a2bcmr428567685a.31.1726163098827; 
 Thu, 12 Sep 2024 10:44:58 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7946633sm564113985a.13.2024.09.12.10.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 10:44:58 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:44:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [PULL] u-boot-riscv/next
Message-ID: <20240912174455.GT4252@bill-the-cat>
References: <ZuKMnMooFpwVVhy7@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KNfi8AzIRBXU5THP"
Content-Disposition: inline
In-Reply-To: <ZuKMnMooFpwVVhy7@swlinux02>
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


--KNfi8AzIRBXU5THP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 02:39:24PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit 78d898eec080b02059c8dc09318b8761044fea=
85:
>=20
>   Merge patch series "phycore-am62/4: Add more boot sources" (2024-09-10 =
14:56:12 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
>=20
> for you to fetch changes up to 2db018d2ca5ebd7acc717f0b1959ee67fcd2b0a1:
>=20
>   configs: ibex-ast2700: Enable DRAM and timer driver (2024-09-11 20:35:0=
4 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/22315

Applied to u-boot/next, thanks!

--=20
Tom

--KNfi8AzIRBXU5THP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbjKJcACgkQFHw5/5Y0
tyz54gv/UuWmAsx8DKr3dZkY1c+qa9jOVUpoUfmaprFM5gRzI/2oR5dzhPdzXo6T
t0zeA0FfH+ZdntOIOauu/Cj9oIhWGyD8PWYseN9Cy3iwp7hqw1LXr7kYpRWQUKLw
ZMBBb8wcyYv1l/FO0jv6Cc7Mo9Xc+XAvJDHJ+6aJNLvMID7orhlacb7I2uP2Kvao
sEdvvL8ICt43uFx9x/EeRpF1wJvQuec5OVnnu3braHH5FW5yG6WqV/gfch5yPgif
zLVcaMt8NOgb0UldXgT6D/41Porm4upzv/Q5K3iVklvitlp/xUVdZ/AU7G17R1ks
HmvXzlhZ8b9r9dw8C2U1ADaLEIq3zJHV+ayWCOVkZsOUpeWltNjdwm0vZNUDp1d0
Ov5j4A3lJVHXxlwrnT7wNjDx+ylZemwb7xERoiOn979j8zRFPySlKbhrUdqpY7yp
Jvv6+SziH6N41HFFF8ynzgNDD82FfhAzGUkesmmC+0vBCX8QVBd7eIe/RQhxpp8o
z+LiIZX9
=qRfN
-----END PGP SIGNATURE-----

--KNfi8AzIRBXU5THP--
