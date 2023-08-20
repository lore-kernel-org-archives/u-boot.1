Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E2DEE4993
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 17:38:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B450869B4;
	Sun, 20 Aug 2023 19:38:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h9YxBGjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB01B86A18; Sun, 20 Aug 2023 19:38:20 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE87A86993
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 19:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d63c0a6568fso2729058276.0
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692553096; x=1693157896;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RDhzmy4F1oQ2f+EtjEon8T5E96VDQjvW40xHtJ9juDk=;
 b=h9YxBGjBlg/d5C/WILA4yTrJa/YNLclPgpUZ4TfZwn15KQ0C3Tz5YF9GKFRFHdLz95
 qCZxOcx0Lr/m+iQBcSQcNw+kCPLRjq8jbELwRpFOwIGcCi7xaFPffp6v5PCicCA1T1I4
 NJrMt5Z/Z/XOr8t6xJtbzLs7dZzDOq0AFOoDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692553096; x=1693157896;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RDhzmy4F1oQ2f+EtjEon8T5E96VDQjvW40xHtJ9juDk=;
 b=DhvhlGtkXj5uXkuHOuVR6iDkXWzLKJogxmalG5QAISfT6bkkOwizHuSE1ZWWrMlBtA
 Gyu3A8jAeSy00xqtEdhL+J3124ERQFSPwXtnkT4EFo9kdL70H5fmAvaR8UP9fWwjaX4W
 uEmxSyMXPrBtJL3ocUQbfDpb6sXCsdmHHwTrLn50Ab5YainX9BMkYZUMVTAPtLZRTfku
 t4H+SmsgnUsnfXbxYkdnX4iBapPgrSB8WrI3dcWeLocjnBvljLutoUSlEXQ0/11+DV1l
 6nWb6wf6F3gK7qbQnvBCIKU8KJbUUbmVLO9PwM2u6RlLNprm6GACurTikxagCMTeKhXf
 ALoA==
X-Gm-Message-State: AOJu0YxzaxNnDZcV+BwAL9l5jJTnCNypsSXUPcnkPUnTmhEzC7e5aWce
 ul+YuHGELrCh9cVGuXibGqLIBvEnTxfFsxbZPr01ZA==
X-Google-Smtp-Source: AGHT+IGUQpRX+xzpD3s5yX1yC/6sALUhSryQBivL6G8COXshX4mDtQTyQrxEJs/x/8eUmjiQNsv3xQ==
X-Received: by 2002:a25:54c:0:b0:d63:1fde:6cb0 with SMTP id
 73-20020a25054c000000b00d631fde6cb0mr5391548ybf.14.1692553096501; 
 Sun, 20 Aug 2023 10:38:16 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2d48-63ba-cc6c-366e.res6.spectrum.com.
 [2603:6081:7b00:6400:2d48:63ba:cc6c:366e])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a5b0ccd000000b00d74c54dea92sm155782ybr.25.2023.08.20.10.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 10:38:15 -0700 (PDT)
Date: Sun, 20 Aug 2023 13:38:14 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Puhan Zhou <puh4n.zhou@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: Pull request doc-2023-10-rc3-2
Message-ID: <20230820173814.GP1515023@bill-the-cat>
References: <bfc45c31-83b8-1011-7832-eff51452b2dd@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ub5XWzYvMZUb6Zhk"
Content-Disposition: inline
In-Reply-To: <bfc45c31-83b8-1011-7832-eff51452b2dd@canonical.com>
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


--Ub5XWzYvMZUb6Zhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 05:54:25AM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit e34efcf51df86eb2b07d9deb171596940586c6=
66:
>=20
>   rockchip: rk3566-anbernic-rgxx3: Rename defconfig to include SoC name
> (2023-08-18 10:25:03 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/doc-2023-10-rc3-2
>=20
> for you to fetch changes up to 951d63000e2daf8b128139cfed343fe2b2da5a93:
>=20
>   doc: csf_examples: csf.sh: Remove unneeded export ATF_LOAD_ADDR line
> (2023-08-19 04:12:53 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/17431
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Ub5XWzYvMZUb6Zhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTiT4MACgkQFHw5/5Y0
tywerwwAhpfzHTbGgJ5DsmCmW8dHuoYxGPNi5whkIA57WhEpr9xv8T4aMAWieb5t
qOo4PAk2Vq5g4PWf5EQzA62dGEZYbCPEAiiDJs9+ILwqC39FnvVkW8OdRuYI3+Xu
4COZ+yGiG///OIvPhtkf8YVTa1pHyGHGEtHLSSk8v/vNyO39tBzf13Mro8q7/qcc
+FZvR8T1JxaiY0x7RRQlIXSpaDQGBagYoo7eU4NKr8p1yxRdStP3/PRv1MB2OEIt
1alCqXh7UzSgS3ZQcwSoggNwcXNoneSWG8LxSNVO4Nir+1ADUZAyszwDAkQGVdTl
4RRSsNrxmwwqNPsO6A6Qw0l31UhiAoNmfn6OMIeXJgK31QjhJV56jlvPJ7QOsxI5
k09sSHRPnX+JSVlO3LAL7yyJQwCEv9CsHYcEvjb/Lg1mBGn4Jivea0wlcqoD7Ari
dLjxe9ov1H2Djaj0kLyw/bvLVSBxcKpJBeysyBAZmrOFaH1U8D9PLRjg7U/u8s4w
wFBHdTkS
=dcyW
-----END PGP SIGNATURE-----

--Ub5XWzYvMZUb6Zhk--
