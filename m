Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43FACDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 16:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 006FE86ED6;
	Fri, 13 Oct 2023 18:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WERI040M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CD4786EDE; Fri, 13 Oct 2023 18:52:50 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF4AE86B95
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-775810b032aso149482685a.1
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697215966; x=1697820766; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KYjWE49wT3Qyzhmpmw7LnTVoAtSkwlP2Out0Hu3G1kQ=;
 b=WERI040MfAsxVXL6DJF+X/xI0ZdAAvUmzypZ/kEJfcdKApjJVZeaCCPDGRtmdhSfFC
 4dWMj5OJh9iqAYkdAppU+nsSt8BgcYI0dC3lxPu9tUxPMGYfznNcGHq1WisskurXVh/I
 UUrjabs6NKhtnbbr5DQVCsL7f+cIKnzcz7PTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697215966; x=1697820766;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYjWE49wT3Qyzhmpmw7LnTVoAtSkwlP2Out0Hu3G1kQ=;
 b=jFt8XN5waL3d7cGroUEPV/c67RON3ATB/2Q7RzZSRrQl5HctNaar0QRGZi123sJ168
 vuEHKcamVyLBfGsSa16POpZNSdEeSsR+ODVN/mefeYYuR70mOEDEhf8OshaiggqGKfqk
 vCMw80E5TTpNDDzRztrfu5KYeZCu1U/N5w4qc4MGkyvnaK55u6WqgOm+1Nt431ZGT0I4
 +79yZPkQGyGaxcwgM3oD/MFBT3Bmb++DAdmDAhjMG3YwrstnQTzNXTii9/0GViLl6kPG
 HI1D708DMZjdmGGQDDPP6t8whwO/BjYhHHk1mBNvythrz2MwUICXXX3xIeJIAhhUFkPw
 pU9g==
X-Gm-Message-State: AOJu0YxnqcsaQANjchDebXDZF2P8mXjfjCy4GvvPcaMT0zm1Ja/ZrGWx
 3VnC1j+YcsR5OLtfiBR27g1Tow==
X-Google-Smtp-Source: AGHT+IE8xz7G4bJf4UWdDbLbbzElteqpsyPfpQ3soGEE8dU4i/xa3HkXATg5Pa/o8pVwBcGEqBMU0w==
X-Received: by 2002:a05:620a:46a3:b0:767:261d:1ef6 with SMTP id
 bq35-20020a05620a46a300b00767261d1ef6mr32624517qkb.59.1697215966480; 
 Fri, 13 Oct 2023 09:52:46 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b33e-4d05-2330-607e.res6.spectrum.com.
 [2603:6081:7b00:6400:b33e:4d05:2330:607e])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a05620a140a00b0077706084c32sm762068qkj.105.2023.10.13.09.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 09:52:46 -0700 (PDT)
Date: Fri, 13 Oct 2023 12:52:44 -0400
From: Tom Rini <trini@konsulko.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 U-Boot-Denx <u-boot@lists.denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: Re: Pull request for u-boot-nand-20230417
Message-ID: <20231013165244.GN3119521@bill-the-cat>
References: <CABGWkvqnzkji8pTJ9upj0YY7rtYtwmt0CouCQk26eC2UWLDB9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PARWUDzfprUy9f50"
Content-Disposition: inline
In-Reply-To: <CABGWkvqnzkji8pTJ9upj0YY7rtYtwmt0CouCQk26eC2UWLDB9g@mail.gmail.com>
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


--PARWUDzfprUy9f50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 02:40:32PM +0200, Dario Binacchi wrote:

> Hello Tom,
>=20
> The following changes since commit 86700279645921fb2c28c41711deb7d7ed75bc=
29:
>=20
>   Merge branch '2023-10-12-assorted-TI-platform-updates' (2023-10-12
> 17:02:51 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git
> tags/u-boot-nand-20231013
>=20
> for you to fetch changes up to be0da1257f189c09604b01bc04a7e8411bf18e5c:
>=20
>   dfu: mtd: mark bad the MTD block on erase error (2023-10-13 10:49:07 +0=
200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/18=
106
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--PARWUDzfprUy9f50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUpddwACgkQFHw5/5Y0
tyzHoAwAqAA5ZxIkVKS3+tuxCTac7R/C+LqZ7bn/CxPZsIqRcX6eQ80lmw955cSC
HBJtAQKuIJuYyai9+TVgArlZtW0L2T3jyCsVrus8c0rBxqO1Bh52LWj4sz4jPf8S
0FYY/QqatA4KWTgjUEGjCngP80pRM0+jqwky0kowfiKCXRmATFXyy4uAYL32RnZX
e2jy/bN1gRwpi9xDBJ52kBNoEkCuTRbVSi56pEDLc/L31mFABqcXRa23ibR5azZu
7LPVaR9+3HC+PTUll4KnxB5ADFrZLmPt2RZ53aXEUcBsF1DBEVWeN1BLM4mQvntJ
hDFkw60YaOomTIsXpyv45lNbKAA6189m8nwkQvxSOUhEYsZJdMkWfSeLqrYWVsAw
MY+cQbW/yZwwx8JtTf1/uphEHFcEIhvHLpiEVJar2cWwIAvUXtJcQjv0o5WEyII0
KlRUGeUTCJEjE3tPl6vo2cj6T72jIoM9muQGI+sQitudfxU60fQTQKZzxShYqdS8
q6H2ivtE
=EIYE
-----END PGP SIGNATURE-----

--PARWUDzfprUy9f50--
