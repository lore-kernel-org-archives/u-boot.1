Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FE9C4725D
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39A018794F;
	Fri, 12 Jan 2024 14:50:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YueJx4ay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B89948794F; Fri, 12 Jan 2024 14:50:50 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDB93876C6
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:50:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-dbe344a6cf4so5543219276.0
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 05:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705067446; x=1705672246; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=av2IT+CfDHRjvSc6wQo5npFgzeNd4td/p3XgPivVLno=;
 b=YueJx4aySdeDCvBapSHvmQho56JZl8pj4kcSrAEp0RV1Hw6gFKCtqDCpePLYBMy9dD
 6QTnu265Z1fGTpdPJh9c+I1Nn5QI09DZt3zjt9szyaiPYpLfmCNRajuVaqzGab1Tpk+I
 Fra2TNoil0t8dGrwXVqexSLasLdz+4miCOkP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705067446; x=1705672246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=av2IT+CfDHRjvSc6wQo5npFgzeNd4td/p3XgPivVLno=;
 b=agbxjmRk7Wc1zH65x90tmfJL5foOdt8FdG3/wcyZq+Gh+dQHRiBrZZ4rSiMEVqt0q7
 OqUZxdBgqvz1pQA1BJdjzz4r5F23LDJtTG4lxDdpx2wGdpeDqUpjoPa4zF82aiITspvN
 pZ14zstYEhp0Kev81VY0BtXdS7Ew+C94qQhRizlVg0jaYJXX48P2xnW+FtxcPU+hiP35
 LZjBMNnwGRDHmfTK9Lh4iQX5Q1YSRmUSpkfh18kB0QTqZt9MP9Y9O/9y1N+EEhHcEfI+
 catVgeoSIRZMGxj2zggIYgcGwMCkDxbMgYEs+2TPw7ZYMjF1WY6Nm9gRWma+JhB+wXuR
 ndDg==
X-Gm-Message-State: AOJu0YxzCwxtpLZajJsSXtzNtItAXsawB0PjVUDN6jRwChgOxBgmbyJM
 cJJ10TWIiEsnitwhNCSPA+XiW7q2wbhXhw==
X-Google-Smtp-Source: AGHT+IGIxW64XgJx+nIVgoRpZtQmYKQ6yojgvmbOiXYTJ2q0MSEFWr878m+8FxaLSyagkbnpjKdujg==
X-Received: by 2002:a05:6902:260a:b0:dbf:23c4:de4e with SMTP id
 dw10-20020a056902260a00b00dbf23c4de4emr809385ybb.78.1705067446526; 
 Fri, 12 Jan 2024 05:50:46 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 p6-20020a25d806000000b00d8674371317sm1220995ybg.36.2024.01.12.05.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:50:46 -0800 (PST)
Date: Fri, 12 Jan 2024 08:50:44 -0500
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] MAINTAINERS: add Mattijs for Android AB / AVB
Message-ID: <20240112135044.GA1610741@bill-the-cat>
References: <20240112-maintainers-ab-v1-0-f2a538eab18a@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lYqygIHP5i84cBvo"
Content-Disposition: inline
In-Reply-To: <20240112-maintainers-ab-v1-0-f2a538eab18a@baylibre.com>
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


--lYqygIHP5i84cBvo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 09:40:43AM +0100, Mattijs Korpershoek wrote:

> Igor has not been active for quite some time on lore:
> https://lore.kernel.org/all/?q=3Digor.opaniuk@gmail.com
>=20
> It seems that Android AB and AVB could use some help maintaining.
>=20
> I'm interested in helping with maintaining the android_ab
> command. I'm a long time android/aosp developer and my daily job is
> still doing android work.
>=20
> Add myself as maintainer for Android AB and for Android AVB.
>=20
> Note: the patches are split because I discussed taking over AB
> privately with Sam, but I did not discuss taking over AVB.
>=20
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
> Mattijs Korpershoek (2):
>       MAINTAINERS: add Mattijs for Android AB
>       MAINTAINERS: add Mattijs for Android AVB
>=20
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

Thanks for volunteering to take this work on. Please use the u-boot-dfu
tree for this as well.

--=20
Tom

--lYqygIHP5i84cBvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWhQ7QACgkQFHw5/5Y0
tyzx5Av/fs7+iYSro0LQ5XOVrqVgETSgjxRNSh9N+GYP9exCJ63vnJFr16mX6YU6
bvu6GNlvPtfHo/3arj/wN/KHj0tqLDssyMvfGgMXKaKH5nj2ipbxNQ0HrHy/TpJo
O6B1o00V/GnZNrCJ4SoAZWAIBzv7MukAtT15Nvci/AFSOBKHMDDzh3jIjIfNhn75
YcZHfQQnKFjns/szCE1/DyNgYwbbrofc2T00xpM5nmEtCAnp8sroRPnVporB+4ek
8Z9VT24KeIHTTtXmvDNPE6A+mjM9v2CSHOzp745bsz+ZiPVv6D+e1fXXEM4Z7LZH
ZCOLWHoc9pdPaesAOF6O7I/kADY1VGtpH2HT7w8XTL/eCG/rjjyRCQbFyZ4yhYzR
7Jad73xpvU+ao5wvQRZu62fwDBa8bufP46a/DsTT/nnCCLZQiLsPz6KKnODuFVPl
B8SBNHBGLobaOxPw71uV+Ad3iBqKJv7UyH4gFBFQpxI9+UHZA+A9UKG/LSMQtrLE
gDVd+a2u
=aDk1
-----END PGP SIGNATURE-----

--lYqygIHP5i84cBvo--
