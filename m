Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C37D2E9EB
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 13:25:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3C148936B;
	Mon, 11 Nov 2024 14:25:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qBwccwtZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20F4F89110; Mon, 11 Nov 2024 14:25:05 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFAB288EBB
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 14:25:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b31b66d2e3so221498685a.2
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 05:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731331501; x=1731936301; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FPPzLTio8DWoKCLf/LJ9vO7ObikfWthLEOtAmzGkDmk=;
 b=qBwccwtZXahE+XYc3tJOzg4GYavtlI5AkS23lEPfj1E0WNGyXSC+oPtoA5CNDoSibI
 76FQjK/rdVr6a8PnTERqgwdX8HSYGAzvEv7ZmJKECoSStyNtXbWm0sajxdx1Lw9wo7ug
 w1DNdVqOAYaV6uP7i8NfcoVoXW5JJM1asuOvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731331501; x=1731936301;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FPPzLTio8DWoKCLf/LJ9vO7ObikfWthLEOtAmzGkDmk=;
 b=Tc1HKIIgyX5/wnlSrc+DVywi+ERblv/VYTUzuo6WvJTNVWk9Y4XKPJFpvmaOGxmA6E
 2PKU/S3Sp9tt8gQjerVMYH2V16aInihSRIntZ0dCL9ppiRmfj+U8dYhheGePohkV5kB8
 WHBkjHnwq/Jf2o6mxYYxoNrRJoCj4IIL12mLnga16Em8h3fLFy6sVbDdAliny4gBIQVJ
 g+SLRIe/6C7lyCa25amfxfvuAdCwOVr7eJb3uQiVdlH9AzsLqWelZoPd7b0HLHG5UMai
 jr7LIBMAlohaP4/mB9sLVqCdH0aUhfCDdVWVVzCNqVqA8Afic+EmhYFvoIuXocEerosj
 sMNQ==
X-Gm-Message-State: AOJu0Yy2BOS70O36R8bYpkl/FMQyDecMabU7KjCyXnLFJqQFT6q+TEMJ
 DET2qUWnJNZ9kC4TPrwl+75Pz85gtA15OSE7IsFj08hlTfBq75syE8QJvO4Y2u4=
X-Google-Smtp-Source: AGHT+IEDjYgAO4XSPMXmtGbC3nbecQ1FzBmMySHBpMGqCxKI27QKEHgqYWt0ibrEzV9/B/8NmQen5g==
X-Received: by 2002:a05:620a:2481:b0:7a9:d115:90eb with SMTP id
 af79cd13be357-7b331f2ec1amr1623102485a.52.1731331501551; 
 Mon, 11 Nov 2024 05:25:01 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32acae49fsm493098385a.84.2024.11.11.05.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 05:25:00 -0800 (PST)
Date: Mon, 11 Nov 2024 07:24:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Chris Paterson <chris.paterson2@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: Re: [PULL] u-boot-sh/master
Message-ID: <20241111132458.GS3600562@bill-the-cat>
References: <20241110214345.900733-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iiIVLJgYt6JUT4v5"
Content-Disposition: inline
In-Reply-To: <20241110214345.900733-1-marek.vasut+renesas@mailbox.org>
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


--iiIVLJgYt6JUT4v5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 10:43:15PM +0100, Marek Vasut wrote:

> The following changes since commit 9c25cd563179cf32cf3b119d5ae78ef8348d03=
35:
>=20
>   Merge tag 'u-boot-imx-master-20241105' of https://gitlab.denx.de/u-boot=
/custodians/u-boot-imx (2024-11-09 11:26:14 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
>=20
> for you to fetch changes up to 5fb5ed2f78656f8f562de37037d58c10b4cc456b:
>=20
>   board: hoperun: Switch to use complete DTS files from upstream DTS (202=
4-11-10 19:38:46 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--iiIVLJgYt6JUT4v5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcyBaoACgkQFHw5/5Y0
tyzf2AwAjCeiX/E24GIm+EURHLXJSTctneEnPJ7SnpFpH8PTWh2halbUGtB8AsDE
+7aSte3ZiiKCVVkYLDQzgGxWfDWzBvXY2Q1wrKgdOA4WmEqTd+l7T0yutWJelece
PhrIC2kvG7BKlyJQ5lHHO9V/+5moBrsZ6KhIAFaeDfSGFeLPRSiIqF+KgVFDl0BY
75Tyz9nO98bo0ijXX3P94dbWgGaEOChWXnBhq1PkFM4nAoo76HJmC8DpJ+t3wqbr
GqM6OyVR7djH5BJlzPsQcU569bONlKK4pDYnmtN6dQRjHxIBrPaHm4SvFjKLQchn
IVy91qHUDxBrOl3W2mIwk7oviweZQPa8EY6Ok4OFHDecXvPhawezL/kxdrhW2wRj
tqnGvmYVxPsb1/iYOYLXewg2QRO9YNHpd+VGcGUi5kU3iC2ulN91ofk5xMjT9Ff3
iCPSOwI6KeQ4DMzsXwwE4yiog7Eu7r9QLlGbptyEz6NgiBC1xk5Ke2+0lXifoXqt
VCFTI+TR
=ui3d
-----END PGP SIGNATURE-----

--iiIVLJgYt6JUT4v5--
