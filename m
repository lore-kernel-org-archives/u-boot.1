Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27177C25B6E
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 12:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B40587B5E;
	Thu, 26 Oct 2023 14:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FkUZBsYY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3567987B5A; Thu, 26 Oct 2023 14:47:59 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9F7E874FA
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 14:47:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-66fa16092c0so6412736d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 05:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698324475; x=1698929275; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aSsYY4jz6nTIGKSfDyOacct9ee6EXVB7RlVv7Gr62po=;
 b=FkUZBsYYgjGeH1sNQ7rjQKoVtWi5gCvqdGtgteSaoXV8Ox6uYgSVK6OB2LxhyrLIWl
 XJI9yNtQty2XQrdOukPFoWmDOPi3GzFi0n3lxv1sgDp6iH/AkojItLigANvI73hVQT8t
 8leb+0qGl1ny//+f5uoiUzNSDamdr5fHwGmHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698324475; x=1698929275;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aSsYY4jz6nTIGKSfDyOacct9ee6EXVB7RlVv7Gr62po=;
 b=ia4BEOswvlLNbTuo9SjO8pCMBMv3yn+j71JS55ZYRis3Bf/A3VZ9e5lSCu4LEV2CJf
 s/H+6ouIFiJ4VGsZR0Pg6meVG9N4t8auz1u/AbpU9kMqZq8P+xAWVJiPYXnXP5hWjyS9
 Thjy2TPIlBcSH5u1IdLWCWmrtjO5OidHT9Ln2S9/k85HXnzawHIFtVH0BZXeMyaOvwcg
 NRBgDAeEkFXYUVHKGfWxoVAdMUq9W1/lbgNYvzwSr8N4CVWnf0dvwyf/pkgDo2gdDZaE
 GWmdCCVDycBNLnEPkkGLAccpCp8KZJcto2bbKGCxo3HIJYfSn41YFf5SbMpbdHty/YXN
 i+yA==
X-Gm-Message-State: AOJu0YwvkXMnYHZMSrbn0hJXyc/K0CroApO0g4yfOBERZIdxPjuebrfR
 uxTFt4oclCcVy3HYezzCJv3PPw==
X-Google-Smtp-Source: AGHT+IGjEaeLItTE3W1FQgwvoFrVH8/25V+8colI4ypMiPRM0HgsHBnOY1ghu+ILapd6i6hWZjm7Fw==
X-Received: by 2002:a05:6214:f6a:b0:66d:a73f:d067 with SMTP id
 iy10-20020a0562140f6a00b0066da73fd067mr18029314qvb.19.1698324475305; 
 Thu, 26 Oct 2023 05:47:55 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-7a1b-75c0-d849-e3ce.res6.spectrum.com.
 [2603:6081:7b00:6400:7a1b:75c0:d849:e3ce])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a0cfb02000000b0065d05c8bb5dsm5118173qvp.64.2023.10.26.05.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 05:47:54 -0700 (PDT)
Date: Thu, 26 Oct 2023 08:47:52 -0400
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, sjg@chromium.org,
 ilias.apalodimas@linaro.org, jbx6244@gmail.com, u-boot@lists.denx.de
Subject: Re: [RFC 11/13] fs: remove explicit efi configuration dependency
Message-ID: <20231026124752.GF496310@bill-the-cat>
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
 <20231026053052.622453-12-takahiro.akashi@linaro.org>
 <1276E605-F0B0-47A3-A80C-F17C6F8A7F3F@gmx.de>
 <ZTon3nThWP/XmkGd@octopus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wWWMEZ3Bw73cF4c9"
Content-Disposition: inline
In-Reply-To: <ZTon3nThWP/XmkGd@octopus>
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


--wWWMEZ3Bw73cF4c9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 05:48:30PM +0900, AKASHI Takahiro wrote:
> On Thu, Oct 26, 2023 at 09:58:53AM +0200, Heinrich Schuchardt wrote:
> >=20
> >=20
> > Am 26. Oktober 2023 07:30:50 MESZ schrieb AKASHI Takahiro <takahiro.aka=
shi@linaro.org>:
> > >Now it is clear that the feature actually depends on efi interfaces,
> > >not "bootefi" command. efi_set_bootdev() will automatically be nullifi=
ed
> > >if necessary efi component is disabled.
> > >
> > >Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > >---
> > > fs/fs.c | 7 +++----
> > > 1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > >diff --git a/fs/fs.c b/fs/fs.c
> > >index 4cb4310c9cc2..70cdb594c4c8 100644
> > >--- a/fs/fs.c
> > >+++ b/fs/fs.c
> > >@@ -791,10 +791,9 @@ int do_load(struct cmd_tbl *cmdtp, int flag, int =
argc, char *const argv[],
> > > 		return 1;
> > > 	}
> > >=20
> > >-	if (IS_ENABLED(CONFIG_CMD_BOOTEFI))
> > >-		efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
> > >-				(argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
> > >-				len_read);
> > >+	efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
> >=20
> > This function should not exist for CONFIG_EFI_LOADER=3Dn. There are oth=
er places where the function is invoked. Please, review all of them.
>=20
> Please go through the whole patch set, especially patch#8
> "efi_loader: split unrelated code from efi_bootmgr.c".
>=20
> efi_[set|clear]_bootdev() will be nullified if not necessary.

In this case I think what we have here today is more readable / clearer.
We don't need empty functions as we can either do like this section of
the code does today or the linker will discard things correctly as it's
a case of funcB() calls funcA() and nothing calls funcB() so it will be
discarded. I don't know without digging through the series more what the
correct IS_ENABLED() guard should be here (and then also in patch #10).

--=20
Tom

--wWWMEZ3Bw73cF4c9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU6X/gACgkQFHw5/5Y0
tywHAAv+KYZmQihOn/9Xc7EEMGu1089djrhMVS6q/pAMtB/ia/cbgD/9LN9Qrf03
/KrS8iCPeSUbxzhYIDgOOF/wi+WM9Vbq+R3w4QLREvVtfKqNW2lfWPGE7goKPaR6
zKP+zj/GQDxAvRJ7Xf36He+qzYUHKM/i7IYDaYDNNmA4UBQltfi8aC9ZIcQpGboe
oXe/g3KE6s1/pUiXeytoISgtj+n6e8de7YKJU0p5uLKSHpPqVyaNOVMSlvsp6wFl
7EIFgiCVVupKSJHdU5bf+cv0ebZSlNiKhu+jwWWRU0Z3juZUSLpt6fQRbsxpiPvf
RuL+Ix1exy3Kpur3SHCEnjy2e9EeNnpXyE3TXb07U0Alpo2JwwwfUYz+oePIO1kq
eByDo5NNhYL4k0mkhraPq3Pk7JQyoPj7OUvWaDNkys60L1fM4Lc1fo8kPXdhusj8
l43bqVREMN9fi6jpcv+1PhWKLrTIhVK9Qs58/7Pm1q+p+dOpR0EDYM8ZSm4uS0Q+
LbfXvy48
=q5SX
-----END PGP SIGNATURE-----

--wWWMEZ3Bw73cF4c9--
