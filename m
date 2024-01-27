Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D96C46CD2
	for <u-boot@archiver.kernel.org>; Sat, 27 Jan 2024 15:25:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F4EF87E43;
	Sat, 27 Jan 2024 16:25:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k1Q1wHRZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88E4687E43; Sat, 27 Jan 2024 16:25:32 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2732087E46
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 16:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7810827e54eso118041285a.2
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 07:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706369129; x=1706973929; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0e0rpafvr+LLQzPeDccjQbskzkF+sK/KAVzsJYn9/Gg=;
 b=k1Q1wHRZ62OcgTva5scnNQCZ/p79oUABaf2OhMO0WAUyZl9WlURrp+DL4TETGjMhM5
 XVvp9mDhi3lkkssFEjHzSVs1JUC9IPGXYFSl+3nBiorhUkJfGgWFc+EF+unQymHwoaMG
 AKNw02kxhxks5E5Kdc8g9luwba3i+G48uDnUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706369129; x=1706973929;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0e0rpafvr+LLQzPeDccjQbskzkF+sK/KAVzsJYn9/Gg=;
 b=ZhGHPUj1I0G+n54jguVppNIDLWHTYCt6zBpBJoJfLEOay9412CekoGh7HRjZ/nvKpZ
 sCZwhPqP0x/e0WT2ag5qf0da3m/2bKpTUN1js0Ziqlo1FFkKyGtpVb0wxZ+ZHD+IRXLk
 uedXgFh7bgqWLIcznPHTKW0TaRfX+q4HmfrtUistkMtpA59j8sGq2PcRU6ltqIBCJ61A
 eRE07l7057GsHML8wQScHuAkfnu6cU3d5/slHOCdONLlIZs885NiWISkB8JicKBgLoTh
 wY0NANpo+4fJQwlf6C562OjAxsWXCQ3bWD7W6Q0mulu5sgpghbaSAGdoGII+r7XqMxZP
 eOIw==
X-Gm-Message-State: AOJu0YyCvhg6SpDe+ulf/2kiJ36BFeD/S/KTwDdDAR2ZuEUrF3HVfxMY
 IQo7JjiZkpyj5WxCWPz7bFlKXop+wZipFbials4qjzVMLgxLmHas0DpjnB0mbIU=
X-Google-Smtp-Source: AGHT+IGgqWzV0uMFSrnIGmjETkXslKfGPve/IQHa85MgEFPizL8Ltm5Z6P81v3dX7A9H2nOs9bf3Yw==
X-Received: by 2002:ae9:c005:0:b0:783:9011:67f0 with SMTP id
 u5-20020ae9c005000000b00783901167f0mr1600308qkk.61.1706369128848; 
 Sat, 27 Jan 2024 07:25:28 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 o19-20020a05620a22d300b007811da87cefsm1470110qki.127.2024.01.27.07.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 07:25:28 -0800 (PST)
Date: Sat, 27 Jan 2024 10:25:26 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: Pull request smbios-2024-04-rc1-2
Message-ID: <20240127152526.GB785631@bill-the-cat>
References: <a52b7ce1-1737-47e2-a2ca-aaa36cc6db7d@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3o1+SxFL+AClECSS"
Content-Disposition: inline
In-Reply-To: <a52b7ce1-1737-47e2-a2ca-aaa36cc6db7d@gmx.de>
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


--3o1+SxFL+AClECSS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 09:55:04AM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit e7f9e5eb584dd0b5d1b1ff82fe607d6da9940c=
c6:
>=20
>   Merge branch '2024-01-24-assorted-fixes-and-updates' (2024-01-25
> 11:01:38 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/smbios-2024-04-rc1-2
>=20
> for you to fetch changes up to 91cc06bcab76dd4b9d07c221b4962283f0984c8e:
>=20
>   lib: support SMBIOS3 table in uuid_guid_get_str() (2024-01-26
> 14:17:55 +0100)
>=20
> Gitlab CI did not report any issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19447
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--3o1+SxFL+AClECSS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW1IGMACgkQFHw5/5Y0
tyz9WgwAprUOpmnkb+/SHmz4QmDyVbHy7tl2RQzYpjHATkeHcHAzTkgpjRok5KqU
XVPlzKalDHx+lZ0w44e7+S5smBvHBep3/Xc+jAbz6hIdaKQA3332ypRG2ah2EZc/
ZjTrRmUs9fjBCHkE4ydDNx1WgXuagVD32udkkbQjX+PooidQ8p3HhqJ+hUjvIgIf
M/xNrx5pJZ4H+h1tZQf2HiLuUm3exonxJdz0+dfdDtFb0wGmhY9hBIlvY6O4uRO4
/ShQzjorIRrtJnEK4GVOId6MxKApwOcZsfyfokuG2UquQZR/pdBOreACe9LGZd1j
CQrplXmskh2hXRcEtVmuWd+PoGOM0SHCtREH3STBC4vPfj0mCxSnMCLXAb7OCbs8
q+Kck75IxurkhMwOThEWTFD2rltJHvwyiaRxImNbm3xAbMCs3/bB7s1Y/NeYQtIz
zmhVp1cn29zcu2nfZMeyNVo0dL7sHquMzrQNKAaFE8E4um152q2NEpBBaeNloZWp
pJzY1aTf
=CM/j
-----END PGP SIGNATURE-----

--3o1+SxFL+AClECSS--
