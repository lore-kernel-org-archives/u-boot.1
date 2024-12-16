Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B18E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 15:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71FFC800D2;
	Mon, 16 Dec 2024 16:38:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bOS6dfFU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22AFD800D7; Mon, 16 Dec 2024 16:38:53 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 964A28005B
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 16:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6f53c12adso254977085a.1
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 07:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734363529; x=1734968329; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VjMcou3uuzmJ4HFbBKfO9YBwoF0MTYcnvCYxWxQdmrg=;
 b=bOS6dfFUmgU5sVkiUfTsK2j7Dz0V+j0LvMhNh2IQVPKvxbMdHFFzISwdfCdm4DxX8I
 R3xhyMsQ+xbEEIwGWEQM6PMMKcRMK2N9KBN07ReV0QSWjUc/wc5qXClBO7MeWvSG+C8V
 MWExya1chD4eawK8d6jXQznxgzMTf9GWOkQNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734363529; x=1734968329;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VjMcou3uuzmJ4HFbBKfO9YBwoF0MTYcnvCYxWxQdmrg=;
 b=CSxH4+zpKJc/WCPnbHfzlrGwX9N6x6z+aQKCUcjYm0dv76gEqKT4hG/s1oRX17V0tk
 mqvdwTiQYW/BIetHc389A4C4yDYmc2mYtsXDn8agDyRAH+uyeWmXsAZdtOvGPWtIPT0f
 tsoluiDHlYHhr5aegZn/J5V0kiqsrR635yOXflK2PTkOzZ2n/dcC/M2ypfZmYzUml7W8
 FRcwH03qf07ocyA/BNrPmG3/GS18ZyM7NQf6SdA2ltLfU1yE+TFgZVxR5cmvuSKA/AY6
 kzeZOX95AXw9J8iZT1Fcn8BwpX01Dgdl8h89V42MF6rHmPLAG/gH/6kf8wdM0maqayAA
 Iegg==
X-Gm-Message-State: AOJu0Yz7Cd0DKZw2z0l2BT/TFakGzvZBBC0dw2b0r/LPJeZnmO+32UOy
 7dRoF5O/nH6B2n2h2nMe47Wqx3ocOfJmGCwRFRmuMlV54V2RhwHV2ikQ65qhnjwCVnUCWH8/YLR
 HNAU=
X-Gm-Gg: ASbGncsWI1GjhBzYoePSezps+oOoBRB/9+XiFS03ZBzFALn1+x5YZ3Z8XbYkPpdWg96
 5NtCbsFHZ2DTI5AmkWxLs8udAsJMEuyZmUzAf8Y232qzwefKgBpUrzoqo3xGj+F4maP3uLkaNLz
 KT11AzsOxlqbqK2jJCEKs0gD9jvB7S/aKjczqrt2U5Ir+c+JSns7j3yxE7ASOSz27jkVFmJcboY
 UmQJERRzVQvN9JtuvvMCuBIIBxOwHpw2qz3HVREeRAMGWGgRwMHkF3Y
X-Google-Smtp-Source: AGHT+IEh3Bd2zWGc4TaaOi2rPfFIZrKj5mE+g5kfrsjXR2AH1yREomRmi265dTy3WDeNjGXFHy0STA==
X-Received: by 2002:a05:6214:2a4c:b0:6d8:821d:7370 with SMTP id
 6a1803df08f44-6dc9698f0afmr192188856d6.49.1734363529239; 
 Mon, 16 Dec 2024 07:38:49 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd26d38fsm28495846d6.60.2024.12.16.07.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 07:38:48 -0800 (PST)
Date: Mon, 16 Dec 2024 09:38:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] scripts/spelling.txt: add GPL-2.0+
Message-ID: <20241216153845.GG1505244@bill-the-cat>
References: <20241215023732.68902-1-heinrich.schuchardt@canonical.com>
 <2ebed5a8-002c-4792-a474-7cf31b6c0bad@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NhwzCxJhyxPaWIH5"
Content-Disposition: inline
In-Reply-To: <2ebed5a8-002c-4792-a474-7cf31b6c0bad@canonical.com>
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


--NhwzCxJhyxPaWIH5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 03:55:35AM +0100, Heinrich Schuchardt wrote:
> On 12/15/24 03:37, Heinrich Schuchardt wrote:
> > The correct SPDX identifier for the 'GNU General Public License v2.0 or
> > later' is GPL-2.0-or-later.
> >=20
> > Checkpatch.pl uses the misspelled words from spelling.txt both as keys =
of a
> > hash and as part of a regular expression. For usage in the regular
> > expression special characters like the plus sign need to be escaped.
> >=20
> > Heinrich Schuchardt (2):
> >    scripts/checkpatch.pl: allow special characters in spelling.txt
> >    scripts/spelling.txt: add GPL-2.0+
> >=20
> >   scripts/checkpatch.pl | 2 +-
> >   scripts/spelling.txt  | 1 +
> >   2 files changed, 2 insertions(+), 1 deletion(-)
> >=20
>=20
> I sent similar patches send to the Linux kernel list:
>=20
> https://lore.kernel.org/lkml/20241215025104.70096-1-heinrich.schuchardt@c=
anonical.com/T/#t

Thanks for trying this upstream. As they seem uninterested, adding this
to the existing function of "sub u_boot_line" in our checkpatch.pl is
fine as an alternative.

--=20
Tom

--NhwzCxJhyxPaWIH5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdgSYIACgkQFHw5/5Y0
tyyuaAwAjYZN0P+1UPenZvlWWQ6BwXkR/p91LCHgFoiD0X76Dyx/ltOtHKD77GAd
DUWVyxpYO6jrF0A3PakIC3RzXtHywAtSfcr45RPGcq5qK7oouvtpDxcd2oV1I1Wt
r16YJIcJxtSXxNiqtrWez0Wv2I8J6Xp7Ne61oyv15lFmah25SRMrRhhup8y4ie0s
u+J94y8cirRgMuODO7bPCstGD8YCyvi//x/2WoiyWfPH/L03PKrvnryzOnPOdjg1
Dj/PgJEOvwfDZ/0TxpctP/YxDkDpw2jDs2sptHoBLOtXbuewulUAGtQJSOIT0ZSV
Ns2LafWJivfN8jRka0cTuXkzHrhDMcOPpGeCb1fMJGN2zC/O6y0MmkKvlhnRCvvy
XVkenash9Idv7/f/RW+1gsnQfuzDqWXuN9L/5ltvvrmY+iRtzi6ABoFVUFkY4ROM
TnZTZW8AOuA5Gs2C83gUL8bOBb5ezQ18TBGAHaOJp7jVX7fETJYFQXMg6Zg6sYOa
cdM1bkMA
=yGZV
-----END PGP SIGNATURE-----

--NhwzCxJhyxPaWIH5--
