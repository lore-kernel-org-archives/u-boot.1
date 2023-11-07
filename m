Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36ADCC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 23:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D6EB876B5;
	Wed,  8 Nov 2023 00:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="otIsiLgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC2A1875FC; Wed,  8 Nov 2023 00:35:32 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD409876DC
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 00:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-41cd4cc515fso42941861cf.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 15:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699400110; x=1700004910; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cRAfuF5iWz6jNd0jUFQcizWvkmEkzmUFH+zECNI0AG4=;
 b=otIsiLgEdHbxePihHm4+lCeH0eIY1NI8Y9j5Ca+iBTowWZJd2Mxx5CoxiWwXiiFGmA
 8MNUPYSmUJDkWZYqt5nIMxZrGhbQT3/qRJmFm4+wGssljwISh6A/ehJXREmk4G3REkjI
 4hqiXrbP1jIQ8ux7jBygdkdc0eT0uLS9eLpUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699400110; x=1700004910;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRAfuF5iWz6jNd0jUFQcizWvkmEkzmUFH+zECNI0AG4=;
 b=o1dgmCroJQyT5fNKaCoS0YvbRbMOGh/LD7VarGBoV93nPOu5ilTpSVywAIdG1+Xclw
 g6Tg2qCkQOFPHn3Andyf9C+AQlW4aC/E/O68nids4dc6OuQwJAdYaXOyw+CB/mPDyxpg
 r/vY6cxnj5r5Lx57ofDl9kEAuzJVVjzS9RJK+fT958sqMNak8bVNLI7ul3Umqkz7VNs+
 W9y6JV7cT1u4u+VXnv+SQqHCGf+itkR4g/6Y3KJ8JGbsaEQa7XPqImCu42MqW/XHxvwW
 onrIM/52T2TE/1kV9CkYepVbkZ+sF8IKYbxULs14hCjDSxQpAxhl8GXLuZv5ymfLJcjs
 R/RQ==
X-Gm-Message-State: AOJu0YzUe16YHjQjmhK/tYL/xBMvyw/uIdM/Ar4KTH2u8WIrcN+if/ne
 tMYfpcodzvsDyemyhB1vWoKqfRtE1GfzpDVKwPtn/Q==
X-Google-Smtp-Source: AGHT+IGXMl4XJ8GAVO/x9dVV/x1vqfP+EYyfwCu4ey/hqu7k/3ekt8PIjiDpx9t8qrbyoiqx2wSnaQ==
X-Received: by 2002:a0c:b214:0:b0:66d:6526:d605 with SMTP id
 x20-20020a0cb214000000b0066d6526d605mr206399qvd.63.1699400110341; 
 Tue, 07 Nov 2023 15:35:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 j8-20020ad453a8000000b0064c1b27bf2dsm400222qvv.140.2023.11.07.15.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 15:35:09 -0800 (PST)
Date: Tue, 7 Nov 2023 18:35:08 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: Re: [v5 02/30] buildman: Use oldconfig when adjusting the config
Message-ID: <20231107233508.GA690448@bill-the-cat>
References: <20231026183138.636948-1-trini@konsulko.com>
 <20231026183138.636948-2-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y8K/MYCvNAifz7/3"
Content-Disposition: inline
In-Reply-To: <20231026183138.636948-2-trini@konsulko.com>
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


--Y8K/MYCvNAifz7/3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 02:31:10PM -0400, Tom Rini wrote:

> From: Simon Glass <sjg@chromium.org>
>=20
> We cannot be sure that the new config is consistent, particularly when
> changing a major item like CONFIG_CMDLINE. Use 'make oldconfig' to
> check that and avoid any such problems.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

For this and the rest of this series (patch 1 is already applied),
applied to u-boot/next, thanks!

--=20
Tom

--Y8K/MYCvNAifz7/3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKyawACgkQFHw5/5Y0
tywhrQwAiaxFbPfWZR6RloyOJpNYz6fX62am+RFgFVmCLVAJ6NVCOgJlIxf/70qg
4v3Kd7eNmNBS+Da3x2/5dx6DKvq8PMNCGe6rXtVWUpwlCL0LC/QRITyExXWrgdAl
cKRHCkJT5/nJVYV7NXAA3Cf92gO5lX99JCI0tomxcNBiRQjwSHyRpbAvMRNBUr8m
/dRoawrzFZ9VQuJ/c1uFJm1nFrK/GU2qn+L+Ay+flDicd8Zcud9bH8ztVaLrve9O
Ts3JXPu/n6PqFc2t+menMzf7tFUIljL5+jbcMa20mdz7tUwPNjFEWAzUdVcrWakh
iUafUUn3KgCRfPNZ44XRnox7/Ete8vIY3Y8GYWooaAhM/lkdHl99L8+Z33s7CU4e
qM9tmNpk/h2RYqRT91CHAq8SPpiVwmx+qBZ8B54ygPRI9VYTx1TjWM14zd0rhnXl
fY3B7Zs0LUI/LTslmKW/T3p6ct35BXh+KiEkEv3u7haKTCnvEgCwgXiLKCGth3Pa
VGrCUFrN
=6q68
-----END PGP SIGNATURE-----

--Y8K/MYCvNAifz7/3--
