Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422E1D68BF5
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 19:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AF298932C;
	Sat, 16 Nov 2024 20:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BbWtVR4S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C5D48932D; Sat, 16 Nov 2024 20:22:27 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF083891BB
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 20:22:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6d41b209858so719196d6.3
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 11:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731784944; x=1732389744; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E4hQH2fzlJnxptdOs66ouoif8z091SvJ9OCWT5xl1es=;
 b=BbWtVR4SZVdPG3YuM9g9jBQsZ0zoJVYPKYEq0SNImnycMY6wR/nbitlXhyOdrB6IF2
 53zQkqWeJyGCDC/KJlsxQ8WHarguXZ7B/tgyduls46EYxb4zbeDYr/lBckxc2HPgJm9y
 cvVPJE44x3QSFMO3R7PI6vrSY1uQAtxZqXRZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731784944; x=1732389744;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4hQH2fzlJnxptdOs66ouoif8z091SvJ9OCWT5xl1es=;
 b=KzJ91ONFKlmClDvEsfIvKsqJGvKHf3pc2eWs//VPq8Dptoo38mXk8DUbsZ6s+ykboy
 lhk1edkDZ9P9IxrIBkkMnqN0kYlpdbMGZOAQj/PUKAdvUjc234mYD3BqEiODiK9kXYyS
 tMgO0Bdq/E8SSpke/84Z+q+Vttv/pw4qX6MBH9BoTA2UIIng4cCVKRS13lpdLE+ljuv7
 TMIU+6UWKs3/eKissbzGIVyZ9a49OaPe1ErofaJixToJVH8a1ZKcOZ8PTXkfiv3yeNlA
 dut9DMjCgZ/0L+Hli5Egq607RnGCIBlGeZJCyTjyjAwp0wnAS0MFnra1lEbFPb2TKYvF
 1PKA==
X-Gm-Message-State: AOJu0YxOyojasYCjYeFqGE7ampRKrIBCP8bgitHNVj6TX8uGNAxXYP6S
 cmlhJpPD2C2A7VCC6/L9JbUjcYoRmYL7hezlrqLmwicfj0mQ0rC36EGU0BA/EuA=
X-Google-Smtp-Source: AGHT+IFi4gAGle7aQ8ibRHzvFRTnX/lHqFo0BXPAsAekmL3B8MekdTXI+UeazvqbQc4DOt6E9rkk+w==
X-Received: by 2002:a05:6214:5c09:b0:6d3:5265:608c with SMTP id
 6a1803df08f44-6d3fb78f53emr93844096d6.3.1731784943902; 
 Sat, 16 Nov 2024 11:22:23 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d40ddddfe2sm11972216d6.130.2024.11.16.11.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Nov 2024 11:22:23 -0800 (PST)
Date: Sat, 16 Nov 2024 13:22:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de
Subject: Re: Pull request for tpm-master-16112024
Message-ID: <20241116192220.GF3600562@bill-the-cat>
References: <20241116190658.112452-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="thgFYTmrSXRobeYV"
Content-Disposition: inline
In-Reply-To: <20241116190658.112452-1-ilias.apalodimas@linaro.org>
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


--thgFYTmrSXRobeYV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 09:06:58PM +0200, Ilias Apalodimas wrote:

> Hi Tom,
>=20
> Not much for the  TPM subsystem on this cycle. Just two patches from Hein=
rich,
> adding missing tpm libraries to the maintenance list and fix for a covert=
i issue
>=20
> The following changes since commit f39199e8096dab68fe4a8e15f8ff60026a5fe4=
91:
>=20
>   km: disable CMD_JFFS2 for all PPC boards (2024-11-15 13:11:51 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-master-16=
112024
>=20
> for you to fetch changes up to c0231ede0f555b098dc7418926a8f9b407cc9928:
>=20
>   MAINTAINERS: add lib/tpm* to TPM DRIVERS (2024-11-16 19:23:11 +0200)
>=20
> The CI at https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines=
/23393
> worked as expected
>=20
> Please pull!
> /Ilias
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--thgFYTmrSXRobeYV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc48OQACgkQFHw5/5Y0
tywjwwv/YRq+gOn7Ex7GIm49fdwOF4SP3wE812w0cTdi4WITh+hD/UzadgRatiSc
pET7yXl6uRYHWo1/Z8Fsh/tzVVZDSCvSz6kD5agDtA103In/ro4MkvcJGIHd05+G
DUhassynBgl1U/E7nkIl4JQIWzL0Yydo0i0bIohrteXtlsj3RnvNzwdxq9gPiwfK
7WECP9T+QbVnt2UcTWLH/3Z8N77ZWPaPBJhHW07hTiYF+LZKaAoKP8CkeFscbeje
D8+hp6/Zdpfg47ztX/sGD/O4jDXeo0ZXxoHUuJu5vrxfRM4MntE6QwLx4gm0iXNk
laRjW/VlQH4VD6ZjfMXN09hZ/1RadJLvzDUGs9Wgjyb8sEqOG55otL5B1ICmlQ9D
rQG6fFP2q4pIPObITnq7XAvwD1ClHG8yviAdJEwXn4REF1Mzes90RRzfu0d2jD4V
63SUReW3Pb4bx2g/B1tn5nYURWv9d7NKfSXAMtWUUtrHG9GiFiP9eGNUoRWk7WsQ
fb+XEtgt
=65rW
-----END PGP SIGNATURE-----

--thgFYTmrSXRobeYV--
