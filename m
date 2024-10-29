Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6199ED5B84D
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 00:05:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E53389152;
	Tue, 29 Oct 2024 01:04:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ON/EIGUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 493A88915C; Tue, 29 Oct 2024 01:04:58 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD35B8907E
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 01:04:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b161fa1c7bso362865885a.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 17:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730160294; x=1730765094; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KvFH7i+r5Q9bTsx5EQLI4pNHfFZ6RfI3982DgRTR1QQ=;
 b=ON/EIGUGK5HJNBsoNiu947+B0UfsBdwMOyUookK03/Tx8NlxfdgxKjFT+p/dB+AEUF
 krbrpEn0bUA5t9PYs+k+0eI3YZGynGjBneRyxxaoAAuinMcDUXlPfl6x5lFsG3ssjvED
 0rPbkfOOtByqdYsI2N6MI6PLrTmhvvIpywpgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730160294; x=1730765094;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KvFH7i+r5Q9bTsx5EQLI4pNHfFZ6RfI3982DgRTR1QQ=;
 b=wza8Aah8fKPUoQ4ouJiEmrbiNT8s/GN+aLPgZfmSginZCQUc4Dn1EUULJ7BfmUn7nc
 6aq8BwO66cBeEiLl0dEEB3hYozzbcAMUKDNNqNZIpLp3H3yE4VW5UY/e8l1i6LRa89aL
 IDuIMZSpJXhYRW0b27eHX8qJCtmPO51Cg/A/5ia8DsdHt1gY8GoHLsmlj/259yC1CcbN
 S77GfPx/+Rmrhcag+OC3wn5P29gSdxr1lzk5ebFxC40Eaz3S+LvQ1uDdN5N0CQXBNndq
 IpkVO3WRx3O3hB6WjEyrXqHI2Lv50flVOGEoRBqSKphI8L+g+Ow1IBgTb0edUGHCAbaX
 w8Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFhvgWM61gCyn35UtwmDVlXouw+mmf69vdVEKQ7VI/VJNpOsTiivwezVzO4lgnVA2oQGb5cTE=@lists.denx.de
X-Gm-Message-State: AOJu0YzEcQY4dNEqTswgnftmwMTUDoGe3+7VE0FOyrL99BzI/QjrNFS0
 hu/NWIdiHAZRhq4m8wBn8qPqLT8XVuPO65+GTf+p8mkYeKOYzgYxU3oDLqp67vo=
X-Google-Smtp-Source: AGHT+IHFoBkboWLUn7P92DEzUDtgxfQsSjrt7USARs6Tqs7SCtfaa47ruqY9LRvTYAJFWulRFmjNeA==
X-Received: by 2002:a05:620a:4502:b0:7a9:bd59:8de6 with SMTP id
 af79cd13be357-7b193efdeb5mr1445360085a.27.1730160294553; 
 Mon, 28 Oct 2024 17:04:54 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d292c88sm370974385a.30.2024.10.28.17.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 17:04:53 -0700 (PDT)
Date: Mon, 28 Oct 2024 18:04:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 11/13] smbios: Fill UUID from sysinfo when available
Message-ID: <20241029000449.GY4959@bill-the-cat>
References: <cover.1729577070.git.jan.kiszka@siemens.com>
 <9e440edc2a6bdcb7d768d277dd6afb02ab941ecd.1729577070.git.jan.kiszka@siemens.com>
 <20241025010854.GX4959@bill-the-cat>
 <ff2c2611-e650-40cb-86aa-275a930fcf87@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ePwoRGiVn2ztwjMp"
Content-Disposition: inline
In-Reply-To: <ff2c2611-e650-40cb-86aa-275a930fcf87@siemens.com>
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


--ePwoRGiVn2ztwjMp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 07:12:46AM +0100, Jan Kiszka wrote:
> On 25.10.24 03:08, Tom Rini wrote:
> > On Tue, Oct 22, 2024 at 08:04:28AM +0200, Jan Kiszka wrote:
> >=20
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> Allow for the sysinfo drivers to provide a system UUID to SMBIOS. Will
> >> be first used by the IOT2050 boards.
> >>
> >> Based on original patch by Li Hua Qian.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> Reviewed-by: Simon Glass <sjg@chromium.org>
> >> ---
> >>  include/sysinfo.h | 1 +
> >>  lib/smbios.c      | 4 ++++
> >>  2 files changed, 5 insertions(+)
> >>
> >> diff --git a/include/sysinfo.h b/include/sysinfo.h
> >> index 8a77ef44856..1c5008b5f23 100644
> >> --- a/include/sysinfo.h
> >> +++ b/include/sysinfo.h
> >> @@ -49,6 +49,7 @@ enum sysinfo_id {
> >>  	SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
> >>  	SYSINFO_ID_SMBIOS_SYSTEM_SKU,
> >>  	SYSINFO_ID_SMBIOS_SYSTEM_FAMILY,
> >> +	SYSINFO_ID_SMBIOS_SYSTEM_UUID,
> >>  	SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
> >>  	SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
> >>  	SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
> >> diff --git a/lib/smbios.c b/lib/smbios.c
> >> index 7c24ea129eb..1441fa4cde6 100644
> >> --- a/lib/smbios.c
> >> +++ b/lib/smbios.c
> >> @@ -387,6 +387,7 @@ static int smbios_write_type1(ulong *current, int =
handle,
> >>  	struct smbios_type1 *t;
> >>  	int len =3D sizeof(struct smbios_type1);
> >>  	char *serial_str =3D env_get("serial#");
> >> +	char uuid[sizeof(t->uuid)];
> >> =20
> >>  	t =3D map_sysmem(*current, len);
> >>  	memset(t, 0, sizeof(struct smbios_type1));
> >> @@ -409,6 +410,9 @@ static int smbios_write_type1(ulong *current, int =
handle,
> >>  						      SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
> >>  						      NULL);
> >>  	}
> >> +	if (!sysinfo_get_str(ctx->dev, SYSINFO_ID_SMBIOS_SYSTEM_UUID,
> >> +			     sizeof(uuid), uuid))
> >> +		strncpy((char *)t->uuid, uuid, sizeof(t->uuid));
> >>  	t->wakeup_type =3D SMBIOS_WAKEUP_TYPE_UNKNOWN;
> >>  	t->sku_number =3D smbios_add_prop_si(ctx, "sku",
> >>  					   SYSINFO_ID_SMBIOS_SYSTEM_SKU, NULL);
> >=20
> > This commit leads to sandbox (and sandbox with clang) failing a ton of
> > tests:
> > https://source.denx.de/u-boot/u-boot/-/jobs/929474
> >=20
> > Without this commit in the series, iot2050 fails to build.
> >=20
>=20
> Strange on first sight - we will look into this. As this patch and the
> following 2 are only adding a feature, maybe you could already merge the
> first 10 patches? Would make v3 shorter for us.

OK, I'll see how just the first 10 go shortly.

--=20
Tom

--ePwoRGiVn2ztwjMp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcgJp4ACgkQFHw5/5Y0
tywh/gwAqBQ7V/upAkVDuccsPjFBuGtjhJ5DOiVjV7sDbLKnVTlYnSVLo+enC3wC
eUkqIS1N0zwgJO7wFZok9bXDZqC0picx4qlwhiaUNlsKumcE5I8IAgSIj4g/znRS
GfXxOsmXd6OH80I04YPpYrGzqPIB/6F0jMuD8DiItPqcsrxa5f2GyVrNFlMnPQ5K
u4D8zDcTAMNWPVtKRQ1HwJcmu2Hqi4m2wjN9WtBOLhTG8zJajm88uxgRlXW+3O1Y
U9YyxnvM6/PQRrr5i7B5wCGSMUum6hhCYOtn3ip/HRs6zyK0a+L3DjrrGBfxyjoA
bN/lq214tmT4w4YwROuSp68ly4uol3xAMl6QZRmUw3gctoff3Ex2e1GAqZBHwpTW
OB9obU5CRpz0cyNqL94XN+kz5Rbvn45udu7mKUGd+4CSCa9wI2J8eb6cNM6xyNRR
udJaW/LoI0p/OH1pHJezUUSLrvt+52Ot8rfwIUf2XdDNt/+U/RkldoWQ5ACHz/gy
0leSJOpE
=ypC8
-----END PGP SIGNATURE-----

--ePwoRGiVn2ztwjMp--
