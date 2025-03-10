Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24516C35FF3
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 15:19:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A08981417;
	Mon, 10 Mar 2025 16:19:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pLoTjWIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB18881430; Mon, 10 Mar 2025 16:19:05 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D311811C1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 16:19:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-223fd89d036so85613335ad.1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 08:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741619942; x=1742224742; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sk3tTCwpF02lkh/gQcRNAAb0W6lHDW/T68odsuqxjrw=;
 b=pLoTjWIVH249SE6H6v6L/+qMiVOOfzAQnnlbJl/KiULxFDyDQH6smK/bMjWvZt/W2p
 npEAlRqb1kz0ndtcHKe5sJgE+2wGeOO4RyUB6fNBqCum2A9m8oS32qTC6jghddwl3kFM
 v3JBKwCdETPBeqhE1BlUSo7qdCsFQV3bhQHuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741619942; x=1742224742;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sk3tTCwpF02lkh/gQcRNAAb0W6lHDW/T68odsuqxjrw=;
 b=IfSeFykeLYhOstYqsS9qtWMOOlYcL0w6foMfitHCroDI7PZezdGE7C0kJZli59XacM
 frmkyO6EjN4aemo1AdjSolvsCPjKzQV9feBIFUScMv69jFeDvzUNEyvtIHcsd4IXX2Ht
 rDgbyFtJu7YnjtSGY853Ppuhxt+fZkmerLgDg4J1CQyiLdZEvMJLAFt9c/FwU3BRTeeT
 wP/CzPmy7k6Tj13QFe1PWT7Vn35sUBbOoQ8qPlzCcIf+1rV3WxhSubnngPxdCGZqJOtB
 kACcTry+83S3KqofexVITNeCNdkn1uxTgpPamPVkQbJMwmn5qTeRnMJqvzdu79XIHA6q
 46Vw==
X-Gm-Message-State: AOJu0YxxeI2Lpog7SpZyLiSlmO2+57jqNf5RAW+FAK0+9mHbzQeVSVAc
 VNNeB9VsYQJwgMjidABiro1twov3v1KoVIhgkTd+muSjkzqSREQsEEN75zqEOB8=
X-Gm-Gg: ASbGnct9EPxDKl0MCmSlU6h49SPu6KoxglZsdSx8N876JkHia+OFXK7LuKqOpcUJpAB
 equiBdkwy/JDMFYarN0HHmlWaO4TzU4XGvrOQ3QxBld7W7AEpXuZqUcY5ktZwDBfzVnZ4//CAC2
 SntpoiUa+JnigWpcYue4s07GDeekA33cwF19048W3NarLa6F1O1DE7+5YoM6npEmmE3+98VFaI7
 /TlUmQH8kP/aIHth8jKSPSzHjZtqA5qsvRXhxQ/rfQxbOYf+nzPT9sgK4ennjdwiK2PDsO40dEb
 149bLTLfC/u/3zaEbjC8j642wwf6PH+Lj/B4u4j1rYW2yw==
X-Google-Smtp-Source: AGHT+IGcdFvQEqrRsWhbF/ypoRLhQdygZbo8ldNMoVvxDdvTpowKM1Xlj22OSX3dWed/2O1cg/AUeA==
X-Received: by 2002:a17:902:ec92:b0:223:569d:9a8b with SMTP id
 d9443c01a7336-22428898155mr202270155ad.18.1741619942232; 
 Mon, 10 Mar 2025 08:19:02 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bb029402sm5235371b3a.27.2025.03.10.08.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 08:19:01 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:18:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 07/12] fs: exfat: Add U-Boot porting layer
Message-ID: <20250310151858.GF2640854@bill-the-cat>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-8-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w9SFIpIK4sPja5Pj"
Content-Disposition: inline
In-Reply-To: <20250308201533.1315951-8-marex@denx.de>
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


--w9SFIpIK4sPja5Pj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 08, 2025 at 09:12:11PM +0100, Marek Vasut wrote:

> Add U-Boot adjustments to the libexfat code and integrate
> the result into U-Boot filesystem layer. This provides full
> read-write exfat support for U-Boot available via generic
> filesystem interface.
[snip]
> diff --git a/fs/exfat/Kconfig b/fs/exfat/Kconfig
> new file mode 100644
> index 00000000000..9f2703a01ee
> --- /dev/null
> +++ b/fs/exfat/Kconfig
> @@ -0,0 +1,4 @@
> +config FS_EXFAT
> +	bool "Enable EXFAT filesystem support"
> +	help
> +	  This provides read/write support for EXFAT filesystem.

Since it looks like you're intentionally not adding exfat-prefixed
commands and only using the generic_fs commands, this needs to imply
CMD_FS_GENERIC if CMDLINE so that it can be used.

> diff --git a/fs/exfat/Makefile b/fs/exfat/Makefile
> new file mode 100644
> index 00000000000..824237b6c26
> --- /dev/null
> +++ b/fs/exfat/Makefile
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +
> +obj-$(CONFIG_FS_EXFAT) =3D \

Filesystems are where we have all of the anti-patterns of "obj-... =3D"
rather than "+=3D". It's not a you-must change, but it'd be good to be
consistent with most of the tree.

The rest seems fine, thanks.

--=20
Tom

--w9SFIpIK4sPja5Pj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfPAt8ACgkQFHw5/5Y0
tyxW4QwAmP7Es/519Fh/QnRAPD2SnPeg4eru9kHFdbXRPYRDV/Y2trQmrt9fulWL
vsGh/q4B3UyXGVNT6nyPf22TplGyqtjDsI1kwxCFwUtK4pIwCjTTUOCASsnQ6ych
m/8ELdm9ON94MwqQRRO0b6CcYPeTR6wcbRCrZwjuoFOc99KFmgIOJrYTJ2+auRK1
uaDLJtvXfFxGbUrxRp9oPvcLhSCyJA+pdrbG+VSVK29XZyI8PUVcMl06ARYvi1P+
UneuYxZI+E1RDQoJJNrhwwRY01vpAordNoMC9HsFwWVppFXdPKy8Iy8LfGkxXna1
bzpqi1dsASrGnjizqmH/xptwrAcWTri8XczwzeCpkQcBBUyVMnxzhnyPBzekK7cW
8mmlhFhkXKP52fAuM1nmhpu8PCLAhIaF0x2aLvOcAUpg0VtFCrp6RYn4ZPfrDd++
7vGHV4CymNl+VJxNQ4lMKbehIenyaBVsi8KA8lcIZdBAEiWzfdNtDGt4Vl9j78Ud
xI5OAGpb
=TTu3
-----END PGP SIGNATURE-----

--w9SFIpIK4sPja5Pj--
