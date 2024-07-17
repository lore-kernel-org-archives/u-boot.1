Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37588C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:06:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8574D886FD;
	Wed, 17 Jul 2024 10:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="X5Q6c8Le";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B48388A1A; Wed, 17 Jul 2024 10:06:39 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6545188602
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:06:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B3D320007;
 Wed, 17 Jul 2024 08:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1721203597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q6UUnDR8AOhGJQyg97qh2KnZ9Kqbx4AcXHjnB3agHrA=;
 b=X5Q6c8LeNwGD+pWu+jCT1RzU1TmFZzR7/iIzYBNg8XrufDXEDjkTx2oY7LbBf6aSTo7Ncc
 J3Kq183pEsEi6WsAmaDdZ6Ux5K6snYDG7BI6bvICvIGbyOAsCj2ZM8qv+EbArM/g4qexiB
 RfJaxnVIa0j7+41BrwIs+cmQgs9xr0uW7xaPV1Ny4BGAJD/AltD4lzdwe+SJP8rcBLpAgq
 1COLBkr8tpwxi0dZBX4vskLJu+lYLHr5XNs07HpNEz8vzkvUrlF0UY5GnmYIM+aPuQvYby
 AjFPyRUIiczfrobvLF4OcWP4X3PrPJsJUU0GNMX0X5cmR+1ZEUShHEDTp0NT2Q==
Date: Wed, 17 Jul 2024 10:06:35 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
Cc: u-boot@lists.denx.de, jmcosta944@gmail.com,
 thomas.petazzoni@bootlin.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at
Subject: Re: [PATCH 4/4] squashfs: Fix stack overflow while symlink resolving
Message-ID: <20240717100635.19491668@xps-13>
In-Reply-To: <20240712082344.8655-4-richard@nod.at>
References: <20240712082344.8655-1-richard@nod.at>
 <20240712082344.8655-4-richard@nod.at>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hi Richard,

richard@nod.at wrote on Fri, 12 Jul 2024 10:23:44 +0200:

> The squashfs driver blindly follows symlinks, and calls sqfs_size()
> recursively. So an attacker can create a crafted filesystem and with
> a deep enough nesting level a stack overflow can be achieved.
>=20
> Fix by limiting the nesting level to 8.

As this is I believe an arbitrary value, could we define this value
somewhere and flag it with a comment as "arbitrary" with some details
from the commit log? Right now the value '8' is hardcoded at least in 3
different places. Also, 8 seems rather small, any reason for choosing
that? I believe this is easy to cross even in non-evil filesystems and
could perhaps be (again, arbitrarily) increased a bit?

> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  fs/squashfs/sqfs.c | 74 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 59 insertions(+), 15 deletions(-)
>=20

...

>  		/* Check for symbolic link and inode type sanity */
>  		if (get_unaligned_le16(&dir->inode_type) =3D=3D SQFS_SYMLINK_TYPE) {
> +			if (++symlinknest =3D=3D 8) {
> +				ret =3D -ELOOP;
> +				goto out;
> +			}

...

> @@ -1421,9 +1441,14 @@ int sqfs_read(const char *filename, void *buf, lof=
f_t offset, loff_t len,
>  		break;
>  	case SQFS_SYMLINK_TYPE:
>  	case SQFS_LSYMLINK_TYPE:
> +		if (++symlinknest =3D=3D 8) {
> +			ret =3D -ELOOP;
> +			goto out;
> +		}


...

>  	case SQFS_LSYMLINK_TYPE:
> +		if (++symlinknest =3D=3D 8) {
> +			*size =3D 0;
> +			return -ELOOP;
> +		}

Thanks,
Miqu=C3=A8l
