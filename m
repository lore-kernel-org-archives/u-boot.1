Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F5ECFD2F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 15:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7D5683E70;
	Tue,  2 Dec 2025 16:29:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZbI9eOjG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B8C683E83; Tue,  2 Dec 2025 16:29:39 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71CF583BFE
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 16:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c7613db390so2836246a34.2
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 07:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764689375; x=1765294175; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ENRJfpI7z1KCDST+29g78FuT0k4ZdHXezzBiNDoDT3w=;
 b=ZbI9eOjGIXhut0Ztr6caVyTT+pmTyyOcJYN4Ylib8SpIQr0OMeXEq+2YY7iB5NhM/k
 4fa9rELEnoMJvgDa1pVA8tVr6XgbCeW+0RoNAK1M9ItNfx85nEn9fRb6wR0OIEYI2O5h
 ZQ80iS49na6idsCxc3Wc+MAtOAfatmklKP2To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764689375; x=1765294175;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ENRJfpI7z1KCDST+29g78FuT0k4ZdHXezzBiNDoDT3w=;
 b=EVA9wcY1NnH21X+2RwyAp0QhLtjSNBDe4nrDoMnp9eNlHlHw87sYL1dJ2NjL/qrNEL
 jJkG614LhDwESzLXihw5CsrzRBHWYeFnepfJ9mDEAnsb4ELkXCOwC/FGKrKU4CTtgxS1
 Ik1OK+941tLqx+9NJp1vatTjwJYQwcZPVp7XKqNDULpqCwgUsKq9IW8HwiWOzxHFyweF
 1iBhjY4LKL0E/NdFnYACjlWJplziN2ESl3rFgRlFGBwWDB9RhgM6sfLxNwyAN1jwvX7k
 Nt7Jea/PTB85iXxGUZaUuK9qX3t6pZfGxueKMPd8WugTAVaVd+GfCx9IaT4lPGFIzCZc
 Hxdg==
X-Gm-Message-State: AOJu0YzeP07uXrKz+Q1eZzT0ciVg02A0qGatc7Untls2cFQbEjVsLSCc
 ad8l+9+0doAeOg1IPMBwfGN9vKSwYP42QzgFs7Cp/gI5NtllsDFD1oULtEgfrJmnOm5BviNKfp+
 uJeKXJrY=
X-Gm-Gg: ASbGncujPDWZp4YUIi0dIQ9tlTnJf7ZKIpRu/+PpH2bWyAABaiHRwYpL7PEXAnoctwu
 rk7DChPjjfll2BWcKlLgsjlo+ansRd8cbBUWugtIP+pZ0HPVg6xBwtvZzfXvPSnXmZr3ncJYP8q
 P4DynWzq4Xps/h5S6OS/XFjtSbFTu94ySdNGQLwghq7lKFR13GuLNnTYx9aDZBo4Qf1SIdH/isw
 FW7N+fHKW0jYUeyj8sx0CgWtM8QL4I9NpY3vzhlg6EDrcNyKOxWz32TGv/RZwq2A2aFOEwqbTfa
 yYxy2mE8vyfdDUavnmKMj5si0a7erQQeU5ciXY9QyvYg4r2I8XH7k1iWmjQVLKhaE3QW75QLx/X
 Tf/a9gb708dyFQrs2ZOQEiN+qlAp959281ovvo/+5ERYIpsxJJQPsLGj3mww2iH6cDgcMurW1bV
 nbyHXhlfnzGc13QJ2/vIs67GicSKboaJN+McJSsOwnc0L+6/W/xg==
X-Google-Smtp-Source: AGHT+IHaDxiKJTjhzxHqgPo8l4kDel0brBu/ur38PDEUwqjmauVs/G4ysKvTZ+Joc+6v8zW27p83yA==
X-Received: by 2002:a05:6830:3152:b0:7c7:54e1:a3ad with SMTP id
 46e09a7af769-7c798db1b8emr23298864a34.17.1764689375029; 
 Tue, 02 Dec 2025 07:29:35 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90f5d7d82sm6757298a34.6.2025.12.02.07.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 07:29:34 -0800 (PST)
Date: Tue, 2 Dec 2025 09:29:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
Cc: u-boot@lists.denx.de, Leah Rowe <leah@libreboot.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v2] test: correct strlcat license information
Message-ID: <20251202152932.GD303283@bill-the-cat>
References: <20251124194556.GM2125796@bill-the-cat>
 <20251202152055.12467-1-GNUtoo@cyberdimension.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jkYcVvu7ATLmzVvr"
Content-Disposition: inline
In-Reply-To: <20251202152055.12467-1-GNUtoo@cyberdimension.org>
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


--jkYcVvu7ATLmzVvr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 04:20:55PM +0100, Denis 'GNUtoo' Carikli wrote:

> The GPL-2.1 isn't a valid license.
>=20
> The copyright header says that "These tests adapted from glibc's
> string/test-strncat.c" and test-strncat.c is under the
> LGPL-2.1-or-later.
>=20
> This was reported to us by Leah Rowe.
>=20
> Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--jkYcVvu7ATLmzVvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS8F2AAKCRAr4qD1Cr/k
CoHEAQCSyo5RX49s6bxSiTDZCvF7cOYg7OG2lJEENNBDJJEPfwD/eK/zhSWsDJLw
28WzqmkWYv6tq0E9tyLp6hTD0anLSw8=
=CeFc
-----END PGP SIGNATURE-----

--jkYcVvu7ATLmzVvr--
