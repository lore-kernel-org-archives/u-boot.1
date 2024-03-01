Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A1DC5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 18:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C38F8815E;
	Fri,  1 Mar 2024 19:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tKb22A4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 458718815E; Fri,  1 Mar 2024 19:54:05 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3584D87903
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 19:54:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-607e60d01b2so16154227b3.1
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 10:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709319242; x=1709924042; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2uK/EhQ0p0JpqqYlO/D2vSwq9j+DqT/KwWqCvsIe8oM=;
 b=tKb22A4AHC0f6KHh1qvC3AjKoaMdH+P0godcwD7P4gf4h7Tk2pKQ/LGfdb2wqueZG5
 f66K0AFfLifOdPb4B+/KTT+AaI4yrb7xJeCfHpNt6wg2psoBB6Qb6yOjsEiikjktVh6q
 OsvuoyVXIaWZ/qpYFjHQvZnxCzeSZbYprkjlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709319242; x=1709924042;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2uK/EhQ0p0JpqqYlO/D2vSwq9j+DqT/KwWqCvsIe8oM=;
 b=i+CH0jljitZz547EIG5EmNG0gioPnbmDmXUUcnEM0l1K9iZFGHMdKJasRIok9cOXi9
 capZ1/oHD9v+KbG7h2MtwwjRv/dDLp14HJxohX8rWaolrxZ/yyyScUx7XuzmbwKtPvjH
 FyPDYzDo/+6tQbt9OxXhZrEDmT3qtDjObLxeG36S2DWc5UtIiLrf+8SdLopZ7JVu4s5f
 PRnlUCVTdJhzLBPqwZe/jEUYVsmPqod6kdxOGre/5BSx2d2G0+0jsKmkJ6LxC3wH5zga
 79Q7KHi71iQk+l8NF2Cg3YmKjrF6KK1LGLg+jEE18A1Du5YAIrkI7H3dU9Vn7HgrzRmB
 0t8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmXMwcgOGdJHaeuwG9wL+41r6cSVoCmboYS+y2qCdk6iDb0fXmaaoR2df+QNYKuzhq1jpHVTULrTvZhN7KFOXORCX1PA==
X-Gm-Message-State: AOJu0YyqAZ5mP/FO/VXkeaQVgyYpvgABvZL6Z7OIoqeqi2Me/T0PQ7HB
 T4T09iO8MpqOXGstIwa4TsizhBOFm0wOExl+qJkjTiqBnxBZ8ajyGNpQOrguxyo=
X-Google-Smtp-Source: AGHT+IH65SzTZV4diTPL5WPxYTJiePzFnToQ4auUaooZE9PLEiawaC/LqCUleQNsfufOqq9N/Da7YA==
X-Received: by 2002:a81:83d2:0:b0:608:ced0:eb2f with SMTP id
 t201-20020a8183d2000000b00608ced0eb2fmr2425767ywf.48.1709319241903; 
 Fri, 01 Mar 2024 10:54:01 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 l18-20020a81ad52000000b005fff0d150adsm1082549ywk.122.2024.03.01.10.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 10:54:01 -0800 (PST)
Date: Fri, 1 Mar 2024 13:53:59 -0500
From: Tom Rini <trini@konsulko.com>
To: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
 Bryan Brattlof <bb@ti.com>, u-boot Mailing List <u-boot@lists.denx.de>,
 Vignesh Raghavendra <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Jai Luthra <j-luthra@ti.com>,
 Aniket Limaye <a-limaye@ti.com>
Subject: Re: [PATCH v2] arm: mach-k3: Refactor QoS settings
Message-ID: <20240301185359.GC3040305@bill-the-cat>
References: <20240212100635.879272-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1mvGW5wYz11/gwj7"
Content-Disposition: inline
In-Reply-To: <20240212100635.879272-1-a-bhatia1@ti.com>
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


--1mvGW5wYz11/gwj7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 03:36:35PM +0530, Aradhya Bhatia wrote:

> Refactor common QoS code into a new common header file, and the soc
> specific setup_qos functions into a common API.
>=20
> Rename $(soc)_qos_count and $(soc)_qos_data variables to qos_count and
> qos_data. When QoS settings of more SoCs are added, only one pair will
> be defined at a time, based on the config SOC_K3_$(soc).
>=20
> This refactoring has been done for 2 major purposes.
>=20
> - The auto-generated $(soc)_qos_data.c and $(soc)_qos.h files cannot
>   have any code that is specific to any bootloader. Those files have to
>   remain agnostic of different bootloader implementations and their
>   header files.
>=20
> - The existing implementation was less than ideal and would have enabled
>   multiple $(soc)_qos_count and $(soc)_qos_data variables for all SoC
>   variants.
>=20
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--1mvGW5wYz11/gwj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXiJEcACgkQFHw5/5Y0
tyxseQv/SDfku2KQyk81fjcDTa3/ySSeUurcOWliW/KA3k5fJZ6+AB32xb9NacCh
Wu8hXOl3vRO1GI3Kf6V5LDKrN/5mSvt84FdhXHmUTKNihTcvvKkXQ9qRKg8Mh82z
rklmy1Gy4H4ovoGoPtQIKr0vpFihza/nuw7r2BBZ8uHDJq8FQQ8lb35TWBN7Zjqz
PuzgKiqhdLZU8oCSixXc/AYCd0Bar38fLrjyFTCkc7YjeZMeXX/BNjLULSXeEQan
V8EzPXYBabWTmy1yo4b5PljP2r2Ab9onu5ZDCo09hmP8XK7SLKSwOnwU8DbwxLzM
QDp42hg68W3BUjALVrLu7s6bQ48u6DXIkjW59PTCMclZ8+mqyQEj8MINLQtU2OuB
hiEY2Mn1jh8DSYsoJIZ2e7JEbmD+/qnNivTMuT8UCVc/1bVOkQtqWWjrZXYQ/iSY
xIrELcJM1IhUS0Ax8PzM0Ni5ml0KROvbKKuKdgJ0CYjcermdSfstHzQwrb5bRki7
Ux2MT88c
=9Y9Y
-----END PGP SIGNATURE-----

--1mvGW5wYz11/gwj7--
