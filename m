Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F91C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 19:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2419187947;
	Wed, 17 Jan 2024 20:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uaecyBlw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE50D87947; Wed, 17 Jan 2024 20:36:44 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70F68878B3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 20:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5f0c0ca5ef1so112167787b3.2
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 11:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705520201; x=1706125001; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PQRXr3Vg7tHMDy4mC91TOR1Q2ORELskPdPK/RtATl60=;
 b=uaecyBlw7bJbCzmdgV8Pc6Rs4IzOOkxODA70VmtxC/Aa1123y0lbMPnfOEUAQM5tmx
 Kiu71MLHgEQUiObtYTs8IWi7JXz6M9Ovl77osos6rY9gSVBhxkJOuNi9mgICBnPJXIVC
 r7Pbs2iRCkuOkHK+gfzkHI2TTKOzB807mPhcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705520201; x=1706125001;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQRXr3Vg7tHMDy4mC91TOR1Q2ORELskPdPK/RtATl60=;
 b=fOLE5m0SDxUHBSeg08nAEAki1ItrGdPzXooYV8aY4SK02WCgGyPi44CvH4KYaEaFXR
 /tzA/a8QJ6w6DET+gSD9uiw5iQzLlWHgwK4tUQ2uR0cPCdpEi6+NsJ4ZvACYnhsszpOL
 1ov9K8P8uEDVYi+2AUlKeJJvnBNYxH/T34K2t1bBLpWQLN5ZVlexS3AU9nxe1AGv0txL
 2H+un/qVef8keBtqyJwG5AM/bTsGnkc5v13B8qy23Qmurj4lyOeg3oAEoZhasD0n/daj
 DqeGliyvA0xiuHlmtNQ2bKlpI96nN2JuTn+cScde21ylexN7gnpxTwY1DOzfEjjUKxRJ
 /z5w==
X-Gm-Message-State: AOJu0YxkpQr5Ei6Yur2MD/yh0RIJhjUf8gOrwPDj8D8fa1TAENpyU4nS
 5W7NLgwommeglHtG9s6DbfD5rpMW+gm5Nw==
X-Google-Smtp-Source: AGHT+IF95Evk/l0acrSgYuEGIPAsrjKMHAyxOpX1PJIinyraUFnACfzsdgJFSU3Mtgoi1DTOx7Qz6w==
X-Received: by 2002:a81:c809:0:b0:5f5:1b6:37b7 with SMTP id
 n9-20020a81c809000000b005f501b637b7mr7621761ywi.12.1705520199597; 
 Wed, 17 Jan 2024 11:36:39 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 cd15-20020a05690c088f00b005cb1bf4d466sm6043966ywb.82.2024.01.17.11.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 11:36:39 -0800 (PST)
Date: Wed, 17 Jan 2024 14:36:37 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: Pull request efi-2024-04-rc1-2
Message-ID: <20240117193637.GX12635@bill-the-cat>
References: <0f47c120-3c4a-44a9-9aa3-0a99fdb5696d@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HXRq6N9E1o6u/OZi"
Content-Disposition: inline
In-Reply-To: <0f47c120-3c4a-44a9-9aa3-0a99fdb5696d@gmx.de>
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


--HXRq6N9E1o6u/OZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 11:57:33AM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 043ca8c8a9b181cf6f17441e9b89b5ee332063=
09:
>=20
>   Merge tag 'qcom-2024.04-rc1' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-snapdragon (2024-01-16
> 09:51:16 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-04-rc1-2
>=20
> for you to fetch changes up to 21c856797e2735fbd4e8b900803e6c42eae8d434:
>=20
>   riscv: qemu: imply GOLDFISH_RTC (2024-01-17 09:03:43 +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19345
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--HXRq6N9E1o6u/OZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWoLEIACgkQFHw5/5Y0
tyylfAv/bANitDQQSn2ee5y91Jpi9BfHmmgibnG7RhNEk0WEjniX6yUC6Gj2Ya9q
DIb3qohWaPnfnwQFsOrK/wHHv/6SQXv7KlTzr4R5ZoqhKDz0tdqTJsaWmhQxsqIF
PmrdmfQCWzG8MeMk+fZOsLhygK8Rke6Xv1Y2X7VCTU0QyUzLYpqNaqPBgrtza1MW
OTD8HIEZIkv//TmnFej9kVZYIbaBkHyHQwoKErbJqctq7UdHRlzGryGguEn2zeQC
eZArjGqRuBZl5ERE2hJzkgIyfHjmqbGbQd8X127cshjbg4Ak5naXWQiiYHd0904l
PCnupxtAZfBhAsuPQLH4aF5tNslY4wI6qIU9SHN/tKhJlGR+3n7s116j9tj6hwcz
pd0NEbP3nKPYJLOaPaHMTPJUXtTVGyxTYXV+87OUWdGfVM0WLOp+7lRi4sfLqdgI
kZElB0pkIHi5UXehC/XxfEUDNXMbwpmHpQzb4kqYTOHWJgyAnF8bgkKjpe+loVJF
aqUcS88X
=dCbc
-----END PGP SIGNATURE-----

--HXRq6N9E1o6u/OZi--
