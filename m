Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC55C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 14:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1E3E8164E;
	Mon, 10 Mar 2025 15:33:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OBg+yTZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B6298168B; Mon, 10 Mar 2025 15:33:56 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8AF48144F
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 15:33:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-224191d92e4so72693665ad.3
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 07:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741617232; x=1742222032; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DxmKTOcQdSOM5XH6Xj6FoCo9BdMjVjwFoa+nJH2ryIs=;
 b=OBg+yTZA4M6LQkfpQMzsGkJqh/otSDH4Aoy+aUB11+rZPBxc1svHZkiKSLLd63dR+U
 xDfnUhHT+Nxv1t8vzlPEX+QV+or6RF2Fhu0bwrRj3+qOnONgqfHiMRkXZMIFI5YZeqOb
 WHQhks/KGuxZTQxmyFAZVGpdduyNDZq+kwNiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741617232; x=1742222032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxmKTOcQdSOM5XH6Xj6FoCo9BdMjVjwFoa+nJH2ryIs=;
 b=hkjjqi2lVSoQa+uk08x+k3yP5HPcbPNrsnkEp7YrFbcR2JFeMrZB7Qa6QX4ACq/Czk
 N1tPUq/eomBvamqzjLTaJwQi3YbvyAzJfiXTckutJ/HABYKFxDiS5AG3m6X3/4bIKx8w
 aFwlOzKvbPaV2/zIGxGRvq3sfrEnJI0rYGksPNVzosAjNmCPk63FKF9m8Iyk4jfurYNs
 fSZ5NEurMFWrB/e4XWxfsgh4J96oyEGRaZ/0NrB/HOxI7ar25Pih87YxKKkrhd03roj8
 XJ78+6Frs9tMptXY4oBn1VMfmO9S6jXqbN0MIkaMVLUDQQRy1iV0eVapu9mJ7TqxglyL
 pReA==
X-Gm-Message-State: AOJu0YwPyGQ8kTMOkshsUBIkD4Y5KSwxcmY0t6C+F2M7URodOf3sXJRd
 VHQG9tJTvzLXdoHJfr9AHp32wYJ4s/+xM8uL+kVG9BaXf++pK65Iq7XgoihdGMk=
X-Gm-Gg: ASbGncsnIxNkmwY/4aifP6+TBAhWGb8YR+632MYiXPLK0HlUAGk8cZC1CpP/BzuybAI
 NYGVwaEv5dF1EnJWZwGNgDUyngjatfqokeu5aHdmOvR8O7w1qr23EZlStlQILhggZZGMIrBP+pw
 /8uKxdEicEukyuXy25cbL6No1KYEBsUXsMErkywtYLXgo3fRVauaQad0UkLvVneK7oUXxHannZA
 atN2NC9KLqspC48lZQTn2Q0aJ4cH3bWSGgTBlzUL+npS6XnFtvaFdOVIzJRO0RyHZN4mpE6iLEY
 x646vtoPJlw4YQR6SAGyGvqfCjBvvmGBcBBcCOa0+e2rGQ==
X-Google-Smtp-Source: AGHT+IGSgNvYlRkHvm5bpQKEnOn+zxMiEJOzN+pxrg+Q4VaGdPI3QYoyLpGEw0qV0yNaC97EJ0pVfQ==
X-Received: by 2002:a17:902:d48c:b0:223:5de7:6c81 with SMTP id
 d9443c01a7336-22428aa193bmr206081115ad.27.1741617232276; 
 Mon, 10 Mar 2025 07:33:52 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91585sm78600865ad.173.2025.03.10.07.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 07:33:51 -0700 (PDT)
Date: Mon, 10 Mar 2025 08:33:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 06/12] fs: exfat: Import libexfat from fuse-exfat
Message-ID: <20250310143348.GE2640854@bill-the-cat>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-7-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="25/AvmV+5wC5GA2m"
Content-Disposition: inline
In-Reply-To: <20250308201533.1315951-7-marex@denx.de>
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


--25/AvmV+5wC5GA2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 08, 2025 at 09:12:10PM +0100, Marek Vasut wrote:

> Import most of libexfat from [1] except for log.c verbatim. The code
> does not even compile and further adjustments and integration into
> U-Boot filesystem code is in the next patch.
>=20
> [1] https://github.com/relan/exfat
>     0b41c6d3560d ("CI: bump FreeBSD to 13.1.")
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

I see there's a v1.4.0 tag and this is only slightly ahead of that (in
easy to manage in the future ways) so I'm OK with taking this as our
starting point, thanks.

Acked-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--25/AvmV+5wC5GA2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfO+EwACgkQFHw5/5Y0
tyzFgQv6A7n5coT7JfOzETn5l+m5RHpxkRR4LPwbYJYnmZkOcV+foKZbKlDOuNgF
zLZe4l2012sciFXNPSMCtrKqr3VS79yqpQJpSeq4r7lOyhMpp/2Y5ISKQt1Goqka
2b4l7PU9sXeeH7TC7E/tfnKdPNCb6+r6yDKcQzJgHo46KQGeaY0DSHbIgusAuGal
YIxgZv8HAojun/fnfrO2tmHkpSxU5G6ZhUqwk9wPDn+nErcqp8DcRLFd4JQz2IK1
D/ib4IJyFOAWmBWVrIqh3UbcGFFqYrgsA/SoVRwVFIViez3lNnaQuiZL9FYhaR9Z
dgBv3fHnml4syIj3OpsVmdU3OpLfUIiZBP8n5AOphfDXQzui9hvj9Sf+heHjGx0B
SUacMe/8K8I6Si98LVkeZ5N+qBVSpQP7Ji/D3ZoytiKn+vb/mj2hpaJUsk+qbXqR
Bs/g778ABnlyPsS/ze9A4QVeJlN83OWOKYwgFloXSrsXk+hEvGSQ4gZBtlCNctUT
ncWanipa
=3AnP
-----END PGP SIGNATURE-----

--25/AvmV+5wC5GA2m--
