Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB674C47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 15:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4AA987708;
	Sun, 21 Jan 2024 16:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ae1F1ZRK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 134628772A; Sun, 21 Jan 2024 16:17:29 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD620874B1
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 16:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dc22597dbfeso2572628276.3
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 07:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705850245; x=1706455045; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tZr2OKAyCHvzFAI5AbcRSyoxj8LIRm/ltnvYOXHGJAE=;
 b=ae1F1ZRK9hEwxwk9EpGktsjy0TrsOIaz6ZsqbtMNbGj7Cc71OxeZUuKHytHf5ZXfhZ
 x3CKXv/w6RWzAWIdo87z/6ZB6zKABRZt2a+bQ+EmTs11rLhBwiIk7fgT6CUgdjENR6G+
 RHrN9zLLkNjMHDS5Cc2v7MhVHNil4yw9iEu+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705850245; x=1706455045;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZr2OKAyCHvzFAI5AbcRSyoxj8LIRm/ltnvYOXHGJAE=;
 b=KBulaZgxANYmHTRSCDe35GoLiUD38peJ8znr/jlRtnYCGJGoL3ONqiLI1J71tV0bPJ
 8BrnbzYVsHnCSiKObK2nbaUyGFiJzfjNqPhliMgd6DMnre11lp8zczUk1xiDBtbUvr9U
 YlLXaq3dtyUBAfE106DH3fI3amyCsT1pEUrXoVPqFzp/STgxxJVO4t8l83DrM7R4EKE6
 jecd3cX+UnLunP/WGKu3I4V5yyrxyiq1OFLFsRHOrpz9KPNaICLKetS++C2mnEF+o3sd
 xMVa5HfuQu33n8o4wlmBFyrVl9RljxRWzBGaUw1EglqM3/BXswGmPFQ/A2tXGR6e9nhZ
 Mwag==
X-Gm-Message-State: AOJu0YyknOI69o9TsFHfv1IddAEfAaJoeyUH+ATAOCGWCYOsKKa6dOHT
 qIjxM21/CmpC5pnnQdW6KYkR0LmHCpIVV7McAfFA7szmeIiaBTWGDuGs1jeejcs=
X-Google-Smtp-Source: AGHT+IHsf9j/X9G2G+d+PoeiOW5Iux30TUCV+WuagRqJd80hdnNZG9VcV50tLFz2FLqzvHBlNdX13w==
X-Received: by 2002:a25:d895:0:b0:dc2:3853:c79b with SMTP id
 p143-20020a25d895000000b00dc23853c79bmr1433298ybg.102.1705850244438; 
 Sun, 21 Jan 2024 07:17:24 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 z15-20020a25868f000000b00dc252f785c3sm1044671ybk.17.2024.01.21.07.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jan 2024 07:17:23 -0800 (PST)
Date: Sun, 21 Jan 2024 10:17:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: ACPI Vendor ID Request
Message-ID: <20240121151722.GD3652023@bill-the-cat>
References: <e72c7ad5-e1db-4065-99f6-326b55e7556e@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a8p4u1xQUq6o5VXa"
Content-Disposition: inline
In-Reply-To: <e72c7ad5-e1db-4065-99f6-326b55e7556e@canonical.com>
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


--a8p4u1xQUq6o5VXa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 03:42:16PM +0100, Heinrich Schuchardt wrote:
> Hello Tom,
>=20
> as we have started to generate ACPI tables in U-Boot we should request an
> ACPI vendor ID for the U-Boot project.
>=20
> As described in https://uefi.org/PNP_ACPI_Registry this is done by sendin=
g a
> mail to vid-request@uefi.org.
>=20
> As the ID is meant to have 4 letters I suggest to use 'UBOO'.
>=20
> https://uefi.org/ACPI_ID_List shows existing IDs. I don't know if the own=
er
> must be a legal company (which probably needs to be member of the UEFI
> forum) or we simply can have "Das U-Boot project" as owner.

I see from the list that Coreboot has "BOOT" so presumably we can
request UBOO for the project, and I've done so now.

--=20
Tom

--a8p4u1xQUq6o5VXa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWtNYIACgkQFHw5/5Y0
tyzi2wv/fXWwzfUm/PnYXLH8TYSd1ZxZhLkYEvutobIO/8bQJ4VpkWC/J8rMl8+1
HXwX6LfstjiaGfIdQNGWD4tQfw7Q9vHwIj7aUGquF49tnPNpSohe/aOIRISZmOiA
chmYTYu6vRbHRZuiXafShl2LGsxjXj0z9DMty36nUjfuL7xkQ7Ly4esP4VfqKXbG
MJa1/YxBoGtzvAw3vkSJunX8S2Vwt7DZzufwQxYf5+85Q5efHiQv+7fkgvYuhNbH
Lutsjrx0ljgmYOUwoxPl0/I+cwLuvDaQqs0z2oVpIWgBswKShM5Uz8Kb6SZQzdyq
GkgftYApfpQo2h7niCPV4VXNlGziHwIZvqeZGRimH8r62w/p2NvGjh2uAHBK0niZ
yGB+8b6/UiTepHzTmoxe+88eDuB2VAC4TdNfd+xIIvV/5JAYhNXP+7BdVqz3NVHK
FXQbd3gAHrmRyTRoPL6ErpcyvHuJOfyw4wRHL3tEdXtvCgddgWDvrnK3zvM78Jwa
65zcloKN
=xaoq
-----END PGP SIGNATURE-----

--a8p4u1xQUq6o5VXa--
