Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5E8C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E3C1874F6;
	Fri, 17 Nov 2023 14:43:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R66ZdD5q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC989874CC; Fri, 17 Nov 2023 14:42:58 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEE1E87515
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7781b176131so106276285a.1
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228573; x=1700833373; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CjcSm3dmzUjK3uNow3QDF/TSLIvkXr2VxTknFTbICss=;
 b=R66ZdD5qyuAjinHYwcaKGNOKUj6U40Ke4c7kLYJ6VmXzHK+6usah7/ocojAOonNoKZ
 qb7vRGZ8NWBNBc9KG5YnMHicyqJUXvjkiOmvOgNyAxwrQ20mg6uUN12kztEuKF/vjm28
 sGRkGOydVVSADYA2JJXpVEOkrm4VePTera3zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228573; x=1700833373;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CjcSm3dmzUjK3uNow3QDF/TSLIvkXr2VxTknFTbICss=;
 b=aExJJfa74kJcwM/XT7jDx2QhXZeT7NfW7oL9hD7V8Z7VVzgnvXSCRQfQYT9s4rSxz+
 IrVBMI8GmvJ/GWfwj8B/iwSOXe/njqcoaNzH2G4c3o+8rrRCqqTYCQ+cTnYtfatlFFSr
 uhGUfVFeUHBeWUkj8JBYeHDxrYEbbxRxr9VEuP86ikepWqb9pGawc+LcqaOz5GP9H8WF
 1LG02/KU/Ug8UXqJtETysa6f5P7ksyMwouFLrgdgq4d00J3BHWRkkJsLX7iev0tjCqfi
 thQ+nFliHiNCNa5ZuVLq4KNVLgUiVd8n5TwC8gxPdau6l9j1gmpaZ2kmaHwIoyHNWO8H
 E7yg==
X-Gm-Message-State: AOJu0YyQcaOC5YN5/jhPgyxGG4+NxbDol89VKdKq2E9DRfJOSjurJdOZ
 6eSpZAY+TgRn/r4mbMZ3cKZjcw==
X-Google-Smtp-Source: AGHT+IF9NvJUbIkk43lM+SsKlUjwF6YICxDCveinVaSV1SqrV3h6LTsXCpxU7aFKAOUkFou7KGWGOA==
X-Received: by 2002:a05:620a:4c86:b0:776:f761:670d with SMTP id
 to6-20020a05620a4c8600b00776f761670dmr10093373qkn.23.1700228573665; 
 Fri, 17 Nov 2023 05:42:53 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 bn2-20020a05620a2ac200b0076cdc3b5beasm601204qkb.86.2023.11.17.05.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:42:53 -0800 (PST)
Date: Fri, 17 Nov 2023 08:42:51 -0500
From: Tom Rini <trini@konsulko.com>
To: Dmitrii Merkurev <dimorinny@google.com>
Cc: u-boot@lists.denx.de, rammuthiah@google.com,
 Cody Schuffelen <schuffelen@google.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>,
 Ying-Chun Liu <paul.liu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v2 2/2] cmd: bcb: extend BCB C API to allow read/write
 the fields
Message-ID: <20231117134251.GA170968@bill-the-cat>
References: <20231110055955.3370681-1-dimorinny@google.com>
 <20231110055955.3370681-3-dimorinny@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PQWb/uhCJB4bitkm"
Content-Disposition: inline
In-Reply-To: <20231110055955.3370681-3-dimorinny@google.com>
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


--PQWb/uhCJB4bitkm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 05:59:55AM +0000, Dmitrii Merkurev wrote:

> Currently BCB C API only allows to modify 'command' BCB field.
> Extend it so that we can also read and modify all the available
> BCB fields (command, status, recovery, stage).
>=20
> Co-developed-by: Cody Schuffelen <schuffelen@google.com>
> Signed-off-by: Cody Schuffelen <schuffelen@google.com>
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
> Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Cc: Cody Schuffelen <schuffelen@google.com>
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Applied to u-boot/next, thanks!

--=20
Tom

--PQWb/uhCJB4bitkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbdsACgkQFHw5/5Y0
tywvdwv7Bw87dMiEXU1MvAj/MKkquNwdbq3tiDx27onvk1EJOcSzqx0cflUpQ3bP
aoqOPDJigJ/DQACQK7dhK+sQHZFgmybtHCiAJyyLhgznqL/7G3W2hfT61LeJFWWU
bOZ2G6yxAFiZxBnbSl8fbf2sALqeF0ttRRNk8OxtK1sV5A5rbolg2LvIkpIOfPL+
BbwOKbt87Z5reTaKg84qBJ3iu+IC0r0+ofbgDuZ7LDgnctJzfYsRullmEcnr6tjm
rX9nYHtjOyP1vdA5yN7JAL1jpRtoyvNojVw8rFjaTIaJgrhwZSvI6ZQ+S1gNZEhE
7EKDyqfBQithVZemWAS5J0JrMs7nCj9B+2yk4q/nHoD6M2QkUv+jXk0pUqfqSPgb
OOG+JkrO7qmkBBiFA3UiYNORqBGgmeLmigzzFem5sfTI87NDdymKgVxWKK9l9ifC
gweRaeVRXYKLMd2LRwJtp1DcVKHJaTzAx/Wef9GGnTIaTT01JKhYSgsIM0YLibuG
xVUZk8Ij
=z9Pf
-----END PGP SIGNATURE-----

--PQWb/uhCJB4bitkm--
