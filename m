Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472EAC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 22:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89094874F6;
	Mon, 18 Dec 2023 23:41:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WgHe0FCd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 537FF8747A; Mon, 18 Dec 2023 23:41:14 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15D9C87186
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 23:41:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5d7a47d06eeso31634117b3.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 14:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702939271; x=1703544071; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sou0yFGzaWpbXLGdMlf56s/B6B5c4nB0V9YQkAMxXBg=;
 b=WgHe0FCd8EGtu6rSnmcy//N34DGwCd6ImLjFEN3gD3gXMAQ691mML9eQnt1o4/m/9W
 DAOtIWFIraHU/bpO6fAFPYdVfR+v2qYixGlc5i72w8Tk1uBn+hCXBDEbgdqNDrtKtqbO
 jwWTmQ12Zc5wLtFAbUli7N8XJI8cRcCr1TmFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702939271; x=1703544071;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sou0yFGzaWpbXLGdMlf56s/B6B5c4nB0V9YQkAMxXBg=;
 b=e93ZO7NRlF5fFKh6Ffd7JquldCoEI+J27jqglPrlFGHSRSWTBgGseJEwPCZ/AxXq4e
 UUVEFexWrhxVZ3EneGsyCIodqyi4luqk4St52L6DSJpDbyXWxRt5XMeWqK0P9sBaWX/s
 RnlRGzwdJdV4sKi1Qp9cZNX6Sq8TT0uAxYMQ0uL7GXe5LP5jSxPgCbLluEG9iL4ZoI+A
 dIAWCchsfx/EHetQFsCwvIpwlZXoJLUKRZTXNUXCw4ZaGIyhRHZ8r69vT7sn+vEPRR83
 nZJ5qcYfpa4njvhnqRaClLojx+XlUHyvGZvDFsOq00Ih4dppDpbQIg3An7aINs9xeBa7
 gqUQ==
X-Gm-Message-State: AOJu0YwO/AQuaSdMtvc8WDLLtnLGlzuz0DPiDNMgKBl8Bc3MlgKQLey0
 izBkLEbbTPCMFpzVa99ShhAfgA==
X-Google-Smtp-Source: AGHT+IFWC8gzPgDx8zDR0emrVOZBmAdw/FCbzl0LYdk/iHI5p4Q/CAM2IhcT5moqqy2/hsCLLlJ6iw==
X-Received: by 2002:a81:4887:0:b0:5e5:1d9c:4996 with SMTP id
 v129-20020a814887000000b005e51d9c4996mr3370143ywa.16.1702939270763; 
 Mon, 18 Dec 2023 14:41:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 4-20020a251804000000b00d9abff76f5csm8164044yby.9.2023.12.18.14.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 14:41:10 -0800 (PST)
Date: Mon, 18 Dec 2023 17:41:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Proposal: U-Boot memory management
Message-ID: <20231218224108.GN2513409@bill-the-cat>
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <a55d0848-c70e-43a9-9223-60515aea8052@gmx.de>
 <CAPnjgZ0r1xM-bky6VQXV4N-FkBC-YFsX1ibJRiJ_17XXAe5ang@mail.gmail.com>
 <D7A16A62-0C71-4374-AAF6-9D021A6C42A2@gmx.de>
 <CAPnjgZ0YBJ9bN4VHbYkR-r3V8winGmm5TA0UXvh-mBLeRgza3g@mail.gmail.com>
 <3A9B3E83-545B-4CAC-9D65-737BD9D6BE0C@gmx.de>
 <CAPnjgZ1=JBEh49G654DfkYM-fcOEhwh=Xuu1scXTLsNkZk2SNQ@mail.gmail.com>
 <DEECD6D4-58C6-4032-BBF9-28A65B9096DD@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GgxcIfI6dtA76jWU"
Content-Disposition: inline
In-Reply-To: <DEECD6D4-58C6-4032-BBF9-28A65B9096DD@gmx.de>
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


--GgxcIfI6dtA76jWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 11:34:16PM +0100, Heinrich Schuchardt wrote:

[snip]
> Or take:
>=20
> load host 0:1 $c kernel.efi
> load host 0:1 $d initrd.img
>=20
> How could we ensure that initrd.img is not overwriting a part of kernel.e=
fi without memory allocation?

Today, invalid checksum as part of some part of the kernel fails. But
how do we do this tomorrow, are you suggesting that "load" perform
malloc() in some predefined size? If $c is below $d and $c + kernel.efi
is now above $d we can throw an error before trying to load, yes. But
what about:
load host 0:1 $d initrd.img
load host 0:1 $c kernel.efi

In that case (which is only marginally contrived, the more real case is
loading device tree in to unexpectedly large ramdisk because someone
didn't understand the general advice on why device tree is lower than
ramdisk address) I'm fine with an error that amounts to "you just
corrupted another allocation" and then "fail, reset the board" or so.

--=20
Tom

--GgxcIfI6dtA76jWU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWAyoEACgkQFHw5/5Y0
tyz+Nwv9HUQ9vRxcBnMm2wTOgmj5pGF3iNvK7bIhweydXUtGyxEMJTmhypC1EI83
ucZCEtnrHYBX094rJrsPf5j4rlHyhMAtncdHJcIhoKrwDUoXBASvwQj3ksajdlvL
bK+C44AFsJRNB0AIXFyxINnWcMyvOKeTntqgZSsG/xqm1Hr5oSpW5z8+xNcWNlmE
c299tQ9Elki5VNR2qG4mR85NG1qWCqgyLUT7KaSjJzLRfCREn9inYVcZkBMQKubu
C4yazyyZ37KVpZkiOjCEtH7fFGIZqNcHDpRwWEkplC81ZBeVPVEa+NF+2W1gd2LV
jO+1V28R/QRkZ6xcQZ4tuO9i8MOw2haC/vsphW+NZo1O0G5wY0PWR1bhsgiBAV3O
3r6lkpzXUH5caVR3cz7SV7Uoy/HO8wilOEyAxKChm/n5uhCE8v3raJHDz/6VtFhL
ZtfZ7rODPT9BIDXNvS9vRHhNN5H5tQ2MxUuNLHg+CaPHPOXVtHqE8HO3M7cFNJOX
hsrGfGmb
=WU0j
-----END PGP SIGNATURE-----

--GgxcIfI6dtA76jWU--
