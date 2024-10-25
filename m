Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A738D10399
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 01:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDAD088FAF;
	Fri, 25 Oct 2024 03:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cgs0VcMB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17C7F88FBA; Fri, 25 Oct 2024 03:09:04 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66D5388FB7
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 03:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b18da94ba9so2685985a.0
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 18:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729818538; x=1730423338; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FMlKIuTRxGKl9aZm58SvckeeJ5+QNcx1dn+lE/FbevQ=;
 b=cgs0VcMBKAjI9YJUDmbJdNoa6hAuzE0AIdTPSat/C7y6YSsWLSqQcOnNTwLfSYN0dT
 ay8oaRzwzaksTpAZYdOc0TVm7q98LNlSn7GHh8zO1cpRCX2ZSWMDZ/3J7KO/VISlEln5
 jhV2EDvCIA46P+ncS7wR3tkKPix+J3RqX9D44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729818538; x=1730423338;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMlKIuTRxGKl9aZm58SvckeeJ5+QNcx1dn+lE/FbevQ=;
 b=aoxBFBnOZyhMZoNuXz8tYXqbaausmhb4FRfBdTVh5MTckaOHsobVzCZRPFqAU5WgXq
 wmUTh0bsZvpUcaE68dEEAPhjfwI9lnrmhUasavlIG75UBqctHsiFCrnUKmL+t7U1MJJ+
 c+C642WJKOdkMuEGsnmFt6DR+YkGXyAxwbhG8+azHPCiI8EDIr0zhveH+UPbyNng0rix
 fF6D+NbUi3DvXZfjgbWOQ0BKI0Mozf3p8oA4llhBFzGqIUIMHmCw0oWvq5s1oDC78Doq
 OvozutiWkPPf+d+GF682kkYLLi7xLtIfooE5iziMYU8wc9Osb+bjf5gxwoHfMju/IL/n
 SQdQ==
X-Gm-Message-State: AOJu0YyPUGlKZ5odjWnkz6o0IciXUnH2FONbC970UzhrX+QpI9z5iEJi
 nYRoG4sfuq+QpwUQdGJyX85OvLXXzUaixQzH3iwUnpIf24tncnVSwCWf+INQQ0Y=
X-Google-Smtp-Source: AGHT+IFeMCFnQCmc0h3oT+1Kq3TeofxN5kZXNfSnGOYLHZfl5y6D0jZ2QlyxVYwgledaehGAipX5sA==
X-Received: by 2002:a05:620a:198a:b0:7b1:4783:aa2 with SMTP id
 af79cd13be357-7b1865c79bemr577156585a.7.1729818538256; 
 Thu, 24 Oct 2024 18:08:58 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d359743sm7433285a.135.2024.10.24.18.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 18:08:57 -0700 (PDT)
Date: Thu, 24 Oct 2024 19:08:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 11/13] smbios: Fill UUID from sysinfo when available
Message-ID: <20241025010854.GX4959@bill-the-cat>
References: <cover.1729577070.git.jan.kiszka@siemens.com>
 <9e440edc2a6bdcb7d768d277dd6afb02ab941ecd.1729577070.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9MW74U9pkx4j9HNO"
Content-Disposition: inline
In-Reply-To: <9e440edc2a6bdcb7d768d277dd6afb02ab941ecd.1729577070.git.jan.kiszka@siemens.com>
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


--9MW74U9pkx4j9HNO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 08:04:28AM +0200, Jan Kiszka wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Allow for the sysinfo drivers to provide a system UUID to SMBIOS. Will
> be first used by the IOT2050 boards.
>=20
> Based on original patch by Li Hua Qian.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  include/sysinfo.h | 1 +
>  lib/smbios.c      | 4 ++++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/include/sysinfo.h b/include/sysinfo.h
> index 8a77ef44856..1c5008b5f23 100644
> --- a/include/sysinfo.h
> +++ b/include/sysinfo.h
> @@ -49,6 +49,7 @@ enum sysinfo_id {
>  	SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
>  	SYSINFO_ID_SMBIOS_SYSTEM_SKU,
>  	SYSINFO_ID_SMBIOS_SYSTEM_FAMILY,
> +	SYSINFO_ID_SMBIOS_SYSTEM_UUID,
>  	SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
>  	SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
>  	SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
> diff --git a/lib/smbios.c b/lib/smbios.c
> index 7c24ea129eb..1441fa4cde6 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -387,6 +387,7 @@ static int smbios_write_type1(ulong *current, int han=
dle,
>  	struct smbios_type1 *t;
>  	int len =3D sizeof(struct smbios_type1);
>  	char *serial_str =3D env_get("serial#");
> +	char uuid[sizeof(t->uuid)];
> =20
>  	t =3D map_sysmem(*current, len);
>  	memset(t, 0, sizeof(struct smbios_type1));
> @@ -409,6 +410,9 @@ static int smbios_write_type1(ulong *current, int han=
dle,
>  						      SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
>  						      NULL);
>  	}
> +	if (!sysinfo_get_str(ctx->dev, SYSINFO_ID_SMBIOS_SYSTEM_UUID,
> +			     sizeof(uuid), uuid))
> +		strncpy((char *)t->uuid, uuid, sizeof(t->uuid));
>  	t->wakeup_type =3D SMBIOS_WAKEUP_TYPE_UNKNOWN;
>  	t->sku_number =3D smbios_add_prop_si(ctx, "sku",
>  					   SYSINFO_ID_SMBIOS_SYSTEM_SKU, NULL);

This commit leads to sandbox (and sandbox with clang) failing a ton of
tests:
https://source.denx.de/u-boot/u-boot/-/jobs/929474

Without this commit in the series, iot2050 fails to build.

--=20
Tom

--9MW74U9pkx4j9HNO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmca76YACgkQFHw5/5Y0
tyy54gwApBp9+JpYkR2C4tnE1gPTeGL/l9BVSGoe4cP8DOEkyk3kprQCb1ftb50g
/1Hjr6SHsQNTjFh35fIwSi70PhPf9xwoi1/ixdWETT0VAmXYoKto2ozx1kHkG5wX
HKs51vATrRsQhdOgbxotoHDKBLBtej49FuoCi4Ezr+Z07RV8kYaAwxoEp2uArHSM
1dEHUmB3GEBGYjBqXuEo+TU59Ymf+YBTXVTYStW81rRvvHchXLCdAOGqgQqZ7rUR
uSzhd3vIMPc4KDTH4I//aw5s5YxQltiWNcBRuauYvtkSH3aQgD1dNS/jnDkOfZAQ
ZSYP9xLeafbcClOYycoYre2Yd7U0fypvN+n6dYG4xyXfTHbQCbwpivwZHdUrMeVq
kSFTpmwj6HNghEYxJON/3H10rn9KUXp6LaTQieAH4KavjHAMNxYxf+HXRL9FcnEj
I/fUkvOWRPaNcuWzfzx8RNdqL/UaMnHbvvBT66DJHxjOLIkdQs5HoPlvfwToXw2u
VMA8WDmk
=gFoG
-----END PGP SIGNATURE-----

--9MW74U9pkx4j9HNO--
