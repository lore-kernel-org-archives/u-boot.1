Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74710C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 00:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4883186F6F;
	Fri,  3 Nov 2023 01:22:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="do/Lghsc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 569C686F26; Fri,  3 Nov 2023 01:22:10 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C39F187053
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 01:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-77774120c6eso82707385a.2
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 17:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698970924; x=1699575724; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cM5DNUxqvznT+ndGofyUIFLcY1SBHHRgkRzzDrn3pWI=;
 b=do/LghscbtPzLjCsi95C1gKnqmlqjCZA3yWGv5lp4mnmJ6Ig0QtmhbiQ+Qql19dGbz
 YlRsuJ6XC2aNGude5ybKMehsuAJ/CEpyVZTW2/6uJUFK6hzDNZG8T1YdqgTukjS8bq+z
 54UoArucJao6NpzJzjmJ+TZJNXvkj6I7S/pPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698970924; x=1699575724;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cM5DNUxqvznT+ndGofyUIFLcY1SBHHRgkRzzDrn3pWI=;
 b=ge38PbL7CZZGleMIFxJ43oazJPG/LvIWlmp1fRwBjHx7MJD/jrcBlWzPzkyZGa2VQZ
 P6CX3j1qv1Ku1GyEBYa/BhmxNa7sVzp/wkkSHNspEreiEMxkZrslny55ptLhG9PbkRC2
 /Rkdzbgn+E5JQ01t9kXF50SMja/s6yxZOP+2JyJigkTdDfrOqSd6Hf6sZA3RbqeNsqUS
 Xi+nkKwkUoU3SxFaw36cff2E4Eqt6ceNCIg1bkPAsNTKm/VSQOCLEgKJ1lcuUHCCV3em
 QRC6VudzOA6ZtQuDtxUJZlkwlkmPspEyTeBcNxP5+6vss7meQmZst+17A2jd4wToxZPL
 +ylA==
X-Gm-Message-State: AOJu0YzP6zZVuceeUlW2cBCY5wChS/c4goyBrVl9hu5vdW7N8GzUybg8
 VprjQJuOu8tYdw6S32OtM3lpgw==
X-Google-Smtp-Source: AGHT+IGXWyqld4alHOAWpGrp1RcoSx1x4MSMRXUPeDLjwvy8W03uN5g+L7IZtoBi8DBIsPM9ff5nsg==
X-Received: by 2002:ae9:c202:0:b0:76f:1d96:4eb5 with SMTP id
 j2-20020ae9c202000000b0076f1d964eb5mr16385222qkg.36.1698970924431; 
 Thu, 02 Nov 2023 17:22:04 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 m6-20020a05620a290600b0076c701c3e71sm216443qkp.121.2023.11.02.17.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 17:22:03 -0700 (PDT)
Date: Thu, 2 Nov 2023 20:22:01 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: Re: [PULL] u-boot-sh/master_common_h_cleanup
Message-ID: <20231103002201.GN496310@bill-the-cat>
References: <20231102220304.86045-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sTf7cbDj0e7WlxB1"
Content-Disposition: inline
In-Reply-To: <20231102220304.86045-1-marek.vasut+renesas@mailbox.org>
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


--sTf7cbDj0e7WlxB1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 11:02:51PM +0100, Marek Vasut wrote:

> The following changes since commit a803f87202aa48974bdff4d8100464a8288931=
e4:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-mmc (2023-11-01 0=
9:44:33 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master_common_h_=
cleanup
>=20
> for you to fetch changes up to 7d824618d7eb5340e63892c919abc62d831e7482:
>=20
>   board: rzg2l: Drop <common.h> (2023-11-02 11:30:19 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--sTf7cbDj0e7WlxB1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVEPSMACgkQFHw5/5Y0
tyx47wv+Lb5ddEIIJzCcYldNR8UVl+FfTqJyqbcbS9Y9o6hDG1zAQ14xZ4e/676/
iOwYmxyK3mavg/3AQFnDd1jjMCW8l7liE9lcc6b6zOIopuBUuS2LHT2dMUehsgB2
/wzUpijWELGQiGfKsTPi/DfMLR8GT8+PLnnYe4NPeHCHCdaZoFsl7Xv9t//6tvMk
qiNrXO/1JV53rr6jdIINR1wb8yMWmujmkTv2AwbbZUynfE/vOmLMqX7kHx7Wt0oN
sIdUH1So4rVhLR0VJjwHIs3ajGQogvaLSAHxe98tfPf2t17xaFEtYa10/6VQPNCs
VB/GxqTBwZR95ZBq/Kav8JzB6foLHSXqkT74nZ0nBquozJtzPFRQhxVqUla9isAN
QPQTRKZF0Ju6FOtnDnCIQJUvpZBcQYBbn+4qpiYpaR4s1bLIjX2dOFeD/dX+7hRg
NXuLD5KsC8k+SCmXKitbPRYWFYMQuts4SKJEc4SZgSsmgsqyzIoyhnE1+1AhaJlb
UvjusAn2
=9tMN
-----END PGP SIGNATURE-----

--sTf7cbDj0e7WlxB1--
