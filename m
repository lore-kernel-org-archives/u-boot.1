Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F683C48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 18:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 821EE87E7B;
	Fri,  9 Feb 2024 19:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nv+xbD7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 318ED87E7E; Fri,  9 Feb 2024 19:13:00 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E3CA86564
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 19:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-68c431c6c91so5463206d6.0
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 10:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707502375; x=1708107175; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RTnuwkP+yAMOw92+wzqX4BnEVlqczsGdDKuPfgHYnik=;
 b=Nv+xbD7cFeDhIFK51wnIIjWos21IZO3Oxg8YuzctJ9DwiGOenSzWn70U3AlfvGMb6v
 34wkdY9GngCzNMS66uYBxyy7ZOjFnO7gHJsrROeaLc3Cs09BvKYbNuwUiiI0MxuuDcJx
 m+1UExFjjzsuwpwDg6gkjQSBj+aonafL+3BQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707502375; x=1708107175;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTnuwkP+yAMOw92+wzqX4BnEVlqczsGdDKuPfgHYnik=;
 b=KYVpfZxtYDD/oDRkJqG+LbCqzHaZwBcmcXvHqK5/tobUSjdGuFwt1Czvqp8gmgODmj
 Dke6hZwR/FsPV+hpYqXGD6b6e0usQivO96EAEs8K7bSI3qP96Ns0wTJfDuF4nn5ZtcT2
 ae0Nj8LpvWdhW9b33JidZXkOUEHgPTZ63Eoyge9SF5Thgdr3T/+e76vPQ9TcpXHYPYlw
 +/ud0YQpTGZkK/QWvS1zxfVQu9OoAzjmHktWZQJlBnIon5aEVW+ReAnja5sU7OYzTYE6
 vsEeRVtpDod80hlDq6IKGuAppcsDWt7Kre7S0tyx3D1WGSqnCwWzOssrqycwYJAVm3Rp
 rsLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+Svp7aYA4XczXsax7t+l4F81HkcE5+xJQmZ3RU6QDHShuxzjsUjfVU6YvKW2YT11Pvdad5UXU+9aSKtrg3Y8xRU5Kjg==
X-Gm-Message-State: AOJu0Yw5uoA3yP4oTPwstqm21QpipQJxT6A+ObQZVNKG8ISuACqRf8Z+
 ctSJBn1dx1TVhJhgA02I8Oa+Up190SrSc/SyKTkQWS5QigBB2GCP6Bjo08C9iu8=
X-Google-Smtp-Source: AGHT+IHTHQ6PQDW0kprI94z3ExTvSMAZ7HdeQBxlmSMplX/t1FVL1XZ2WhtY+9du4aE+S3wSDxGiiA==
X-Received: by 2002:a05:6214:d0c:b0:68c:87ed:ef36 with SMTP id
 12-20020a0562140d0c00b0068c87edef36mr2539334qvh.29.1707502375025; 
 Fri, 09 Feb 2024 10:12:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXN3+Gu0CUvsW5O7LVSnQds0eHpssudnbB1DScAVQbvrk4/qyhBIB4s1YGius+reFjM0CN5RG388138lou2YU02ESaJb1r3M8tGyCm/+MeV+8XiyjCwksSHwpK/tjQTowLMfaumpvo9e0C5MTZ242/4jjmV3KEof7Masg==
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 me17-20020a0562145d1100b0068ca40389besm1026379qvb.101.2024.02.09.10.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 10:12:54 -0800 (PST)
Date: Fri, 9 Feb 2024 13:12:51 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v2 2/2] smbios: fill wake-up type
Message-ID: <20240209181251.GO1152441@bill-the-cat>
References: <20240209155115.102957-1-heinrich.schuchardt@canonical.com>
 <20240209155115.102957-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ubogWzJg90VQIC3N"
Content-Disposition: inline
In-Reply-To: <20240209155115.102957-3-heinrich.schuchardt@canonical.com>
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


--ubogWzJg90VQIC3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 04:51:15PM +0100, Heinrich Schuchardt wrote:

> We should not use the reserved value 0x00 for the wake up type but
> use 0x02 (Unknown).
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
[snip]
> @@ -108,6 +108,16 @@ struct __packed smbios_type0 {
>  	char eos[SMBIOS_STRUCT_EOS_BYTES];
>  };
> =20
> +#define SMBIOS_WAKEUP_TYPE_RESERVED		0x00
> +#define SMBIOS_WAKEUP_TYPE_OTHER		0x01
> +#define SMBIOS_WAKEUP_TYPE_UNKNOWN		0x02
> +#define SMBIOS_WAKEUP_TYPE_APM_TIME		0x03
> +#define SMBIOS_WAKEUP_TYPE_MODEM_RING		0x04
> +#define SMBIOS_WAKEUP_TYPE_LAN_REMOTE		0x05
> +#define SMBIOS_WAKEUP_TYPE_POWER_SWITCH		0x06
> +#define SMBIOS_WAKEUP_TYPE_PCI_PME		0x07
> +#define SMBIOS_WAKEUP_TYPE_AC_POWER_RESTORED	0x08

Shouldn't we do this as an enum these days?

--=20
Tom

--ubogWzJg90VQIC3N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXGayAACgkQFHw5/5Y0
tyxcgAwAg4VUQDkBaYhbCHXdmQZ+dtAAcz3NScND+a2EHAMj2v2qt66gewIU6V6F
6Q05FKO9AADf+YUBjArtpBt+FpMKNfe19DI3VzDOVAz5c5pPhJqz2Bj6ko9kcbsk
/9iLzbmjKcySklMU8FmkPIZcmQLg4n/vQjvKAwMTcWiSrCniNvHj4HiFVbngusrT
LaGLHO31Z4CgE0tv1Xak2wWTjNVKS2H6e5zmDppDwhmnLh5N0cY6QJJrwUGne0GI
aHM4QMzZeohditAwQ4PaSeya8BqD1z/gKZX9+qZo4h1sy03JKb5qNJnXUSnAIt7k
O32xEi7smEueVpe+s4bBmUVa2mkktcQH5Ue0fRBBUPEPd/nt2uWJdep8MnFFSZRM
Ghisu77PEhUQ6J8pHUfUZWUAhKag1CQeXOxgBR0weJ1iaeEDZUpGigbyO0NIo4BL
OlOIIYahBJI3ePKgng3rfGTX1icjjAuriP58X/qE+vE4hha8X7b+FCX9Rsma4kun
6XD8DsUb
=MbPI
-----END PGP SIGNATURE-----

--ubogWzJg90VQIC3N--
