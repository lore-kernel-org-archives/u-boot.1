Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E10C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:26:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03605883BA;
	Mon, 24 Jun 2024 23:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kwOUl9yC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF156866EB; Mon, 24 Jun 2024 23:26:47 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53C26883DE
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-25cba5eea69so2326591fac.2
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719264404; x=1719869204; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eVRso0Ja7n4RC7Yfp9drtGRrppRWfi2angdFmVPs1Qg=;
 b=kwOUl9yCYenj7bZjUaOa3qa8cTPsNFM30vCKq0iK6pf+kUcyTvdEfflcGWVD7fi5JA
 Vpc/QGVhK7GFhtKOpqBZzEXkn768+SDCmL90w0cIkwWEIs9q+Dq5hssKiCdp35vRm/6b
 ppc4P9MHeNlaM6Se0wo4Fwxk3pHYdurTMvjFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719264404; x=1719869204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVRso0Ja7n4RC7Yfp9drtGRrppRWfi2angdFmVPs1Qg=;
 b=xRk8al6chxxyHtMHMnNCgmoHeFiX1d/if37pSDULNgNgfPlpPo4FqzaTDKBCU/Vxuh
 RFtcKmEI6shcpBbG3dKg5GQ59mZijbqd0jGzoEGIx6FkA479tCx7mNW55C9JDcpUUpgU
 3w5i9FU+IjyUhIzRH/4J/FI1YSaBItTdRKIG005k4m+RLkf8odo9myT7qECWXHkpdTaF
 s3vognXh0krbhyrQ3HB6YyyJqZ1/SQUQvPr31ZZydzvriBWyO4fdjoh65CKtq7oAVJf+
 WWI3xwxYmqo8Tk/tNqZ7NR7Sy6jSmEdpYxHf7BFAqgdy4wtO0NgMAOPp+UGLGi8DNcsK
 ITJg==
X-Gm-Message-State: AOJu0YwLNPrzI4SxhvZmtIbRXKfWSBKir9hg7RX2gfvF5+M1vBnpf+g3
 MJ9/c6rlb4KT4esLHY/1geRhLY8XOdYbCIS9QYx3cVq60xlWsGZXgI1rzglmKoc=
X-Google-Smtp-Source: AGHT+IFbmgXnURzF9KSLN3gAD2bbp1aNF69ZNICDihmi0t8wB6s0FxMyLsolRi7chAuXacyuVyhf2A==
X-Received: by 2002:a05:6870:4709:b0:254:ccac:134d with SMTP id
 586e51a60fabf-25d0163eab8mr6692428fac.2.1719264404001; 
 Mon, 24 Jun 2024 14:26:44 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25cd49881bcsm2100508fac.20.2024.06.24.14.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:26:43 -0700 (PDT)
Date: Mon, 24 Jun 2024 15:26:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20240624
Message-ID: <20240624212641.GL38804@bill-the-cat>
References: <20240624133553.104708-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JG04Frs6cALZF5tg"
Content-Disposition: inline
In-Reply-To: <20240624133553.104708-1-festevam@gmail.com>
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


--JG04Frs6cALZF5tg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 10:35:53AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/next, thanks.
>=20
> The following changes since commit 81e2b69880566a90e909a7e2c02dff0c39a8c1=
e5:
>=20
>   Merge patch series "boot: fix crash in bootflow menu with EFI BOOTMGR s=
upport + typos" (2024-06-20 11:41:43 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20240624
>=20
> for you to fetch changes up to b7f677dc40429a8172c7ba5edcf3b426097e2881:
>=20
>   ARM: imx: Enable SPL DTO application support for i.MX8MP DHCOM PDK2 (20=
24-06-24 09:24:16 -0300)
>=20
> u-boot-imx-next-20240624

Applied to u-boot/next, thanks!

--=20
Tom

--JG04Frs6cALZF5tg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ55I8ACgkQFHw5/5Y0
tywO5wv+Kw3yuCKTk8AXSeCjBkb+764liOwcSCMmC5eBsBu501wQi22bQPEtXHxr
lmRBqiOfzxVe1lJNuDu7GySgIboHh+2C1cDIoRZt+Pzgb+NlFLAPhQtXhSs6nNXi
EbB/Es9LudEjVNLPvDIihLHs4Ix/wqS6sGKG+h1RmaHqGuVwQDHYCUb028ljTSRl
zLebdR8BUQlPifDMAX9Gz5O1ylooZKJ2Z3sNQkkN64xhaQsnKobM2ecNlNS6KxZY
N7m+N9Tdddhk2CCVtWYYW902Sy56vvL3F4V0+U/hJqC58VH0UQG8gPGIM6nVHEj4
dI1Xfn5Losi54PPhrMIRxCCO/0qwkS/a/e7Oi481H5+Zcj/s2CdYaluXvrT2icuR
F9InM3mQuJ5AfYkPdqsbx8/r5mKMqdF5B4OPG7yEegTDanL0rs7ctphgNTXoR6Oz
eK0BkdlTNxcHxXAzkoFlFo3kGMEFC/4tV2b5CQ/Csu743StrvAPPYfExof8nYl38
joIwzpuR
=cjbX
-----END PGP SIGNATURE-----

--JG04Frs6cALZF5tg--
