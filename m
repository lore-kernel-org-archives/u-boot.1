Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E4CC35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 22:48:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82D4E87C68;
	Fri, 15 Dec 2023 23:48:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AU6tc6oZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F186C87C6B; Fri, 15 Dec 2023 23:48:31 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6A1E87C68
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 23:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-77f3183f012so76431285a.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702680508; x=1703285308; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bIdV4eRBk/eIQFDjL8lOLM5bXPubK6i3vVqUbkoO7nk=;
 b=AU6tc6oZDaDrNUcrAjRllt1XjioYgk4aq/ssb7XNYL7p6uSAlMjUO+D24qRQAKYads
 r1YyoY88AiuAm9J3cxfmf0eLRPgg0FdK7ll3UkXgURp7O8G42Kz37dTpbqkGx8vnnLBl
 Hh3+LqE52QQES98oE106EXzjfJVjwJQvXSQCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702680508; x=1703285308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bIdV4eRBk/eIQFDjL8lOLM5bXPubK6i3vVqUbkoO7nk=;
 b=ZPUAeoGTboal8UNsDyZXvDyFUf7TGQXjaptaAgsnalGXfEIeY/2qw6tK4UgsSdtUX6
 cxkot5860YFO6lkpZ/oKwp/PNT7Y1YbFF8oTW1gFAQy7sf5NE3oNpKUa25EepM3BAeyY
 sEixdPTwllptxGAn52vAnkjgXo1LXsB4yiU9X/bsQT4b8Y7EaGTQeiEvo6xaH6OEh/0X
 nMOvQvUHiam5k5MhxNfLAYEzBp0HSujGlOLeLH2e8X4MTTfP82nRlVNHCjimL/tYfsc+
 W7PBB+elZmkRXQkuls/8blPw7nl9q76f0MCrOJ/vX/is4tEP5vc4F/SpnvZeQieE7OhB
 W6Aw==
X-Gm-Message-State: AOJu0YzeugL6ZUwHl0y+kt+fWDx29OOnGb/YUfbpsmpZQBfjbh2pjGVM
 na0vfJxxtC1YROLk3ppdtlmPNA==
X-Google-Smtp-Source: AGHT+IGXre8JdpMEYzMfKRajb6j6gUrf7VUfQrAZhgAjABgHQEkiJJ3QpIX23zglKBBMdtxmJU0wAw==
X-Received: by 2002:a05:620a:2910:b0:77f:964:1797 with SMTP id
 m16-20020a05620a291000b0077f09641797mr14872579qkp.132.1702680508693; 
 Fri, 15 Dec 2023 14:48:28 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 qh10-20020a05620a668a00b0076cbcf8ad3bsm6381288qkn.55.2023.12.15.14.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 14:48:28 -0800 (PST)
Date: Fri, 15 Dec 2023 17:48:26 -0500
From: Tom Rini <trini@konsulko.com>
To: Vishal Mahaveer <vishalm@ti.com>
Cc: u-boot@lists.denx.de, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
Subject: Re: [PATCH 2/4] board: ti: am62ax: Add C7x resource allocation
 entries to board config
Message-ID: <20231215224826.GI2513409@bill-the-cat>
References: <20231128194024.20809-1-vishalm@ti.com>
 <20231128194024.20809-3-vishalm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G0Q4dHd2lWQNOMwe"
Content-Disposition: inline
In-Reply-To: <20231128194024.20809-3-vishalm@ti.com>
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


--G0Q4dHd2lWQNOMwe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 01:40:22PM -0600, Vishal Mahaveer wrote:

> Update am62ax rm-cfg with allocation entries for C7x core. Following
> updates are added for C7x:
> - Share split BCDMA tx and rx channels between DM R5 and C7x
> - Share rings for split BCDMA tx and rx channels between DM R5 and C7x
> - Add Global events and Virtual interrupts for C7x
>=20
> Signed-off-by: Vishal Mahaveer <vishalm@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--G0Q4dHd2lWQNOMwe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV817oACgkQFHw5/5Y0
tyzwIAwAhrf5l+gLjWrxMwcxWUEecTUsPRnqpz4wUdbTYczbZxbhiXCw7JVvXuLk
rEs8eNjBK7Z6SVwZBQq0zUAxp6xCbNoJencQ51X4CtXXvEMX6BMYtufBKrxp7obD
xnqcje+Zu2rADnSzEZ6mzL3jbTp4X/lPZgUbkTulkoMx2UKcoL2OObw/gTiwDjN4
cZQI8L9062O42c9a3ugYgUni7BLZdoNcLzBwr4vbYvCoCrm53Q8jdqWhUg6vh5LQ
E3hdjqPbQU3llfHO5cS6SWUt4dZS4hZelLyprDqxPhADt/KN+LXaq3z8d/+yEeV9
DGuuofGj2sBN8CcBvSJcm4cIFU8saDfH0uJKNsxpdLkANcDLyWW/ih6vS3Tx9/3P
Nm9EfOgew5g9cYVzlEdSizco4ys7mlMd2AUuauxImcm+OfO4sadTIrO7n3LwHk8e
JfVLYxrUVIKnF2OpIAcTw5BcAa3aX8nqLLLCbn3vbcVGa87It/cOXgiMh2ybFECR
B1zCFT1z
=pXOh
-----END PGP SIGNATURE-----

--G0Q4dHd2lWQNOMwe--
