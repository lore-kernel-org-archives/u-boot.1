Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D60BC5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 14:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7499882AF6;
	Sat,  7 Jun 2025 16:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p7bfQnXH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 109FE82B0F; Sat,  7 Jun 2025 16:09:55 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB75E82ADA
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 16:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4067ac8f6cdso2475814b6e.2
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 07:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749305391; x=1749910191; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e5OVg5F6vVIJPQydXLf01aHs+ZA8KcgffZpJ/hMxsgI=;
 b=p7bfQnXHG7TVbcgYrUgagngbtxm5FFBWUD+eKM2bl3UfT4xS/u692j8yV1QigWt390
 K49tTxZdiu+T2MKdD62D/StTWk5qlfWObGuWcAp0AVNtwCUeNrth67cYohOMKMz+7tL7
 BSabiUGTNOex35/quERspxbKFp5MpEGTtbD9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749305391; x=1749910191;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e5OVg5F6vVIJPQydXLf01aHs+ZA8KcgffZpJ/hMxsgI=;
 b=ipKdsEeukKBEzcH9oEluShcIQbXeJNA7jz3MkZObwK/WbSIaCsruj/VyS5Fux7mHEh
 B0YNKX1NF5/68GSUu5xLb7uTqoC7XbIUY4Ofio5HJjraRZy+I4DYgANuJNzVtKpfX3iA
 17vqVAXWAxVTW7eEmSpt9o3JUtB7CCAm366jJtJksakES9C1e/72MArgGAOxudXWD0RN
 h1i4esx4PQnmhLaGEPhS4+fDNUBTDptL0+MQrT+S/1162agAjdjAknt8s0ukeqlkPtng
 nDEPYmten7ed37iEaHcPAmb6LvMNjnqpP2UgyMvnyc6Um+PiYR5YuD8mLvkcZ9ow2rNa
 uGfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUykJjvqLiJBmeKeV+OUk7Zn7Gv4Q+A3acubD4hwDXne60NcIDIZLcYWSKOtqj1EibfVP9rd0=@lists.denx.de
X-Gm-Message-State: AOJu0YyfXCnLVf/m+t9nQyqwkjasyMy4qJYiolq0cEPMt8MSfBBAiIF1
 hGKNfDWLN7dHxTLF2eJ0ijFxdrg65NdGFBUXSYULlYliVkYw/JoJzuehFlajNzntg4o=
X-Gm-Gg: ASbGncudoLhWVAlkw+QfiLcX+Cj+ENzdWdQqC779lY7JNA4qbRt4JrnYDVZOpNjPoBd
 2Fu0LvDTuB7dkPHwHW+zRVl/v25DbDTSUEyYzZQ5wbuVNPDJqCHwPZFRmKlNejnRBjudCrTqI7v
 ti6CTXuuobJ9SXq2jJtPTKd5qn6JOELkFo1qA7whRNsp/B27Lb6svy84f45AKTt+rbFB8kg27n/
 z2+vm3p+chTZ66hs+rlsAq94Ca1wlfU9uYPEp7c4jGTHAJPZ1GrEIuZWjhwl+Dl2gv/LCI9p8/V
 Q6jb8SD6TmuqkWzjVwOn+54ibHJ4NQlIpXR8vQ/9ioIa3qZe9sIp7vjfVv4xAyT95Qi/HzekPdF
 LwvUetbSaSThV8Qwk+k8+VOI=
X-Google-Smtp-Source: AGHT+IFPjYgsSsxHDeNEHM5pPxZC8BBe0YJsc2YFg2FePcax+8j8ozPUA0ndpLyTq/+Nl3WHaUOqIw==
X-Received: by 2002:a05:6808:6c8e:b0:3f8:e55c:16ea with SMTP id
 5614622812f47-40905232edamr5143731b6e.24.1749305391657; 
 Sat, 07 Jun 2025 07:09:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40906a2e0f8sm910511b6e.50.2025.06.07.07.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 07:09:50 -0700 (PDT)
Date: Sat, 7 Jun 2025 08:09:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] arm/airoha: reset_cpu() does not take any params
Message-ID: <20250607140948.GG1382132@bill-the-cat>
References: <20250606210805.GE1382132@bill-the-cat>
 <20250606223923.503086-1-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uacazjHF+EesptxJ"
Content-Disposition: inline
In-Reply-To: <20250606223923.503086-1-mikhail.kshevetskiy@iopsys.eu>
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


--uacazjHF+EesptxJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 07, 2025 at 01:39:23AM +0300, Mikhail Kshevetskiy wrote:

> According to include/sysreset.h the reset_cpu() function does not take an=
y args
>=20
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--uacazjHF+EesptxJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhESCwACgkQFHw5/5Y0
tyxlYAv/fHycd9hM/zhy12EtfnaWFAuZkx5Kg6yXiob6aTnCeH40Lzqz5m7exfsf
+pS2aN6rAQLCJh5FKAT/6BDhkIUZ+S5WUHcHVtZOERptJY8CGbYmh/rw/adqZyxZ
tzTDIDNdnhDpKtiHrnOuiimn3lrxq9YWRuT9dRxjYch61/DiwLQ+PiHeGWDE4pGn
ckS1EhZBptZ6x7lwuFO9DoWv0hm7gUPnnsc0Qt+RepGZHdvu2YOfg0yKC2C5JFS2
74Y1eANJ1a1YL9RRZNy7povE+24Axct+pYvsaGjvkqXRHHMZYkGAujeArIsagA0b
R0amV0KX1/utDk6jHnuqZvD2MW4ErLiba07jIe5jkri9ubLS94h4tcpsS19Bp04p
BE7UpIB1rk+FyVk3fCdJ4uXm6vJt0LvT3+1oj+bxUKX4kdc5V0xhePGNHNCrQHqV
tGM0bPZBsLESmFFDm9D9mPM51w6t8PrSY7n3K3F4DNyDQcC5jH1tzIhEViqdGQVW
hdiQRshb
=j/72
-----END PGP SIGNATURE-----

--uacazjHF+EesptxJ--
