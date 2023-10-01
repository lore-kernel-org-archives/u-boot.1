Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7F7E748ED
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 15:55:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 549EB870B4;
	Sun,  1 Oct 2023 17:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XHdYpaQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4AA38646E; Sun,  1 Oct 2023 17:55:29 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2FB886DA8
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 17:55:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a200028437so64603997b3.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 08:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696175726; x=1696780526; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+XvMF9CHtw1W1iW5FjHm2EM1j10i3MlPIQanmJZJn8=;
 b=XHdYpaQJd5wEmilIrGGUAB6Pqdks+n7o0elBJftZ2IFDMMVAonRWsBSw8xYcL3u7r7
 1Gmbz4027LXRdfVmkODb8NDKmYkS3K2WqlEwCd4fCHQJuAcNxOlPc6WO90AZG58XhBQz
 Xky4aSjcMOcNF7k+bSTxK6WHZLm+PCChEDg08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696175726; x=1696780526;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q+XvMF9CHtw1W1iW5FjHm2EM1j10i3MlPIQanmJZJn8=;
 b=lnJG3MwkMTqs/XDqKA9RY3BHWHgW1hZ4fUkUwt53ZqDaFsxZ0TlI112tYURSCCKPcj
 FGIoW+uLhnzpAzA8QcIASOx5RkzEQt3GthQRsUMLd/nR5/zsWUi5gRkA3A/VV3Wq9axV
 3/TBjwoQOjlX9I5F2FciV1198YE4+IzakT7dP3ppwqgfLxFioQDFQH5BT+RK7jTdF5Fp
 LS0W2m1+L/wfpX5xI4ifDt4npWhLLZGy5Y2nCGCeV2VHfJL7+Ix6Z2rnghcqwaufiB1e
 CuA/09pGnP/EFXTnGJ64aljI3gUeW4r6wPu2pN+3D/FDRwYeq5/8lkn3RN4pK6lzqwfl
 BxKw==
X-Gm-Message-State: AOJu0YycW0djU/Vhb3QhFDOjvyVWnvX9w8JgFNWAozNU+MXvdvYY3rYN
 clanVNM/QOwIkWuGPqasCKj6KA==
X-Google-Smtp-Source: AGHT+IGe6FsNWbfnvfeqV96R5kwONfHcUPbb/8DmtpY1Tec8YId3fLAzo9wYOKPLZkPPLifB0JjiVw==
X-Received: by 2002:a0d:dc47:0:b0:59b:c0a8:2882 with SMTP id
 f68-20020a0ddc47000000b0059bc0a82882mr8271222ywe.46.1696175726489; 
 Sun, 01 Oct 2023 08:55:26 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-13fb-ab5b-9ebe-9b3a.res6.spectrum.com.
 [2603:6081:7b00:6400:13fb:ab5b:9ebe:9b3a])
 by smtp.gmail.com with ESMTPSA id
 hd10-20020a05690c488a00b0056d51c39c1fsm5428976ywb.23.2023.10.01.08.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 08:55:25 -0700 (PDT)
Date: Sun, 1 Oct 2023 11:55:23 -0400
From: Tom Rini <trini@konsulko.com>
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [PATCH v2] CI: allow jobs to be run in merge requests
Message-ID: <20231001155523.GD2763665@bill-the-cat>
References: <20230913141536.109844-1-andrejs.cainikovs@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RlW3OGgpyHAqBuiZ"
Content-Disposition: inline
In-Reply-To: <20230913141536.109844-1-andrejs.cainikovs@gmail.com>
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


--RlW3OGgpyHAqBuiZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 04:15:36PM +0200, Andrejs Cainikovs wrote:

> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
>=20
> Out-of-tree users could run an out-of-tree CI with limited coverage,
> however it is convenient to be able to run the upstream CI from time
> to time. To enable that we would need to change job rules to be able
> to run on any GitLab event. Excerpt from GitLab documentation:
>=20
> > Jobs with no rules default to except: merge_requests
>=20
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/next, thanks!

--=20
Tom

--RlW3OGgpyHAqBuiZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUZlmsACgkQFHw5/5Y0
tyxdSQwApjlLqMwlAn9LawyyKuG5iHQGhiaSgs+3Jbjl5h0AKpiaGomMTn61G8LC
7HwZohlkDBptTHLVUP545ukoCpLwklZmMMKSW2H10zP5foxvnC5lSEot+Uz6Lwqm
krGEK05mJDvOwfUEM9SbB4eZgdGuIUzsIXgRP4FenFqAWqTXBdKk2e/Zg0AhvHM8
d4Fc59f9eyfJvuc6H0UdD4gS1TWB+j9WMvbVJDwE/ptbZWECMwLTwvbE+L/fxz1g
Ci7YlyRE/fr1RGPy9jhCL4qAMJ0wPHt4kWOrcN6jrDNrNyKw5uKYtYpkpfS+9lr4
V+R4w2PpiW3uBfuShro/7h9pi/nwj9rNf1xDS6HllhropTNtu0DR5ZmaLlQ6eX0r
1WZFzLckEToe/xJoypenPz5uVc2HSIqTRHaHgnW16J+9rj8zJIN0HuvDjhcNAlPf
5d8YcILGiy08c2N6dKCdnib+JrCQtlAZ3MHykH7PgubXoxfZMLraUcIB1N9JDyD4
vkqMJOXj
=FO/1
-----END PGP SIGNATURE-----

--RlW3OGgpyHAqBuiZ--
