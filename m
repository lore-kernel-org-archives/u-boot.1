Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF1CCAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 18:09:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B2FD8329F;
	Fri, 19 Sep 2025 20:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gGfqrlHe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C579832AD; Fri, 19 Sep 2025 20:09:07 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCAC583285
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 20:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-62344b7b69cso1446041eaf.0
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 11:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758305343; x=1758910143; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XBJgoD+1zmWOMPi1BG5uvl7HIlYcacUbRUAdcBe+854=;
 b=gGfqrlHe/ZtpZK7h8taVRqGUVnwYanoTqmjcN3CiJxycpjxK5eoNiFJINuIuH+AWEc
 WqnraMOcAUBxD7EGeIh9OfrTxL+RuA738IKko58DAuXx+QMyHIsCIfmUaImmMcNAF8OX
 Nc/va5CZNtlCX5PFI0OkkxnQpx2mNb3r4Ptrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758305343; x=1758910143;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XBJgoD+1zmWOMPi1BG5uvl7HIlYcacUbRUAdcBe+854=;
 b=Nk9bFFMz2Nl/94ij6PFeQXu9tvcM9IIjOsOblz1qQdQjerxkf+XWrHRWm90cRibY+k
 abhC386Z/rX4KEHkddo4/wFw1LqQGbx0iNXLBA6h+giK39pSxanP9f6U3JQtaR1UPjrw
 fxihLEhLg/Fsw6DqQKqgpD+tU1V+jiuEIDgZMP2DdRhLiKaieX+H2D07szKSPunwQKtA
 SMwMcXEz+Qx9YryDWlSgpjm3zahtYDxFWjT6OjOJwfwXCKLR5ERWWk3Fn/Bw29rTXBOG
 0VWrzolr/gz7mOd2xqxTzxnSJy4+5pNeCGxjPdOuJ5E+rOsRgZe9VhsAfgHV1cLRynfW
 EXQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6RjbmfxVwWQsv5A4jFOPnNvMCrEeMhcvE6yxW/01gOOZaXUGkRIIsVW0ay2BcFn6adOKIpgI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4bxSfegEYT9U97QPOOpEkTlq+Tc25+MlN4/gEGI8l28txDzqS
 y93UIOJcOklfBTgCYz6+pz76kfSf7VrpjSm/he8cltqfjYLoSuY2g9tTYQk/tBDJD4oI3LR93fC
 cAkDmzVk=
X-Gm-Gg: ASbGncugjeWxsIeioYYizVUiC+NfdwEXgbUqFMOKbk7JcodhirxEPLNjuQCnnAePfYw
 i+ZsigdSaYpD8W8VmffLGnq20p0kUWoS82S3BcWXHSbYOEz8p1it1v+7+/V2Jq01H0V0Dpj212z
 E37rPpgHM+WdmxiGNkMhzX9OfApJhMoNixF9gbcr76hDChH68v7ZPz5CxKkgWCDmtavXUMfdrWR
 W4lPMvq4/vUhVTdkhMUdB2pzyx/2DU06FgaL0NB/aQ5yj8gzb9UA1JTnO8DpsG/viZgfs2o2f3/
 V1wXzvdpEUzFncHYSibghJDHdENhfPtxVlqCmK+ozaSnBXwRo5lS4f+my3PDQkSUFW8/luG1r2o
 wqo+jEtSGHv7RwfiY3G/k68wJtnvX5juakygIQlGXKm+UmD9RsBxlDcHc
X-Google-Smtp-Source: AGHT+IGVnWx2HkZ5XCzb2U4IZ8xRRGzabXIkFkSklKRWHa2aZVcTmoqmNA8FFLk7hgKLry8Vt/SPtQ==
X-Received: by 2002:a05:6820:2228:b0:620:ea78:ceb4 with SMTP id
 006d021491bc7-62724fdda2bmr1809270eaf.0.1758305343325; 
 Fri, 19 Sep 2025 11:09:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7691c44ef20sm2645107a34.17.2025.09.19.11.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 11:09:02 -0700 (PDT)
Date: Fri, 19 Sep 2025 12:09:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] bootstd: make it possible to use tftp for netboot with
 standardboot
Message-ID: <20250919180900.GA1107020@bill-the-cat>
References: <20250911-ip_dyn_bootstd-v1-1-74f74507cc18@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7ejInKUdZwGoVmzL"
Content-Disposition: inline
In-Reply-To: <20250911-ip_dyn_bootstd-v1-1-74f74507cc18@phytec.de>
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


--7ejInKUdZwGoVmzL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 12:34:07PM +0200, Benjamin Hahn wrote:

> Add the option to load the bootscript with the tftp command (static IP)
> instead of the dhcp command (dynamic IP). For this a new function
> tftpb_run similar to dhcp_run, is needed. The selection of which command
> to use can be done with the ip_dyn environment variable, which can be
> set to yes or no. The ip_dyn variable was chosen as it is already in use
> on the imx platforms.
> Also edit the bootstd doc.
>=20
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>

This leads to failure to build when CMD_TFTPBOOT is not set.

--=20
Tom

--7ejInKUdZwGoVmzL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaM2cMgAKCRAr4qD1Cr/k
CgnCAP99Hsse5e2L255NsOxGUBu0uRJ8zN44rdUJm2Y4HWTCGgD/cHOrtynouime
8YwMgMbT8sykZCO26wkfZieSC8eV9wI=
=Qao8
-----END PGP SIGNATURE-----

--7ejInKUdZwGoVmzL--
