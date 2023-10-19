Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB22CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 20:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A839A871E7;
	Thu, 19 Oct 2023 22:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o3hITV4V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90CC887243; Thu, 19 Oct 2023 22:29:06 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A8CE871BD
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 22:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7a80a96dbso10817617b3.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697747343; x=1698352143; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d1PmwlcCa7FCo1YNwNEipE5coFTKEzgO0JrcLJ49Y9M=;
 b=o3hITV4VEwF/tPVt42t/+w9LLwe85ljR05hMqJObxB1WAOcL3RLOqqiUVwXvEnHo+f
 VtMaOT85o0aBZ24Nx7A3Z/DISNJpT5zTlXPwN9ykjg/Sq82b7aTDiFVEncq7TJj+rh1L
 LF4GcGXvqMqrduGt6z9FoCcmGLVJxcv3ptpJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697747343; x=1698352143;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d1PmwlcCa7FCo1YNwNEipE5coFTKEzgO0JrcLJ49Y9M=;
 b=thcOLet65wHD7zxawMkn7P3H2hDuHXjC/f0IyOHmMoc0St2J/Q2nhHB7Tg+AdaMjkH
 pv2YkvShHS8FWA52IEDyJb5CtDTzhyajqcOk95Bom05moldWZmFUz+onHGdBJEnBb9OQ
 CmKEA05LcpN9+9UpSduJDMzq71aY8BBZ932T67q/hKhkWTI0oMO9pr/5/i94wK8TFQ/J
 Wt4caC/I+DLnhjQxhr41owLQpgc69WsgDSiFyRw/q8a75X2JtoMlgGqZ6G323DWpw2iQ
 sd5aO/b+t5KF0N7e5eDi/GbW7uY2WEdvrR8AjcyJ0AHLoM+Mh6YjDjMyOl4+fv41yeYR
 RL2w==
X-Gm-Message-State: AOJu0YxfPwvdZONLrwHVyIjcT6+zI5xrgo5i2uYjn7XntZffRTBZCJ2E
 gVfuR9TmdcEZsOnos1blAtQBXQ==
X-Google-Smtp-Source: AGHT+IGeEfZFNkECRu80pS7AHP5aCEPH17UgfgrlxXnLOQ2jQ7meXFg3/voVLWI0YXS3ZrqnXouVwg==
X-Received: by 2002:a0d:dfc3:0:b0:5a8:1a54:ba4b with SMTP id
 i186-20020a0ddfc3000000b005a81a54ba4bmr2355251ywe.13.1697747343054; 
 Thu, 19 Oct 2023 13:29:03 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 u2-20020a0dd202000000b0057a44e20fb8sm108020ywd.73.2023.10.19.13.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 13:29:02 -0700 (PDT)
Date: Thu, 19 Oct 2023 16:29:00 -0400
From: Tom Rini <trini@konsulko.com>
To: Martin =?iso-8859-1?Q?F=E4cknitz?= <faecknitz@hotsplots.de>
Cc: u-boot@lists.denx.de
Subject: Re: CONFIG_SPL_SKIP_RELOCATE in non-SPL build
Message-ID: <20231019202900.GF3119521@bill-the-cat>
References: <cf04d59d-f598-5dfa-64b8-3ba0135a66a9@hotsplots.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eZgPG3S8sFVXDCkw"
Content-Disposition: inline
In-Reply-To: <cf04d59d-f598-5dfa-64b8-3ba0135a66a9@hotsplots.de>
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


--eZgPG3S8sFVXDCkw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 03:30:25PM +0200, Martin F=E4cknitz wrote:
> Hello,
>=20
> The patch
>   Convert CONFIG_SPL_INIT_MINIMAL et al to Kconfig
>   (b35316fb67cb7aeaf022032ce078135251372f39)
>=20
> changes the behaviour for non-SPL builds when relocating code. The patch
> sets the CONFIG_SPL_SKIP_RELOCATE option in a few freescale boards, e.g.
> T1024RDB_SDCARD_defconfig.
>=20
> Before, CONFIG_SPL_SKIP_RELOCATE was only defined when building the SPL i=
mage:
>=20
>  #ifdef CONFIG_SPL_BUILD
> -#define CONFIG_SPL_SKIP_RELOCATE
>  #define CONFIG_SPL_COMMON_INIT_DDR
>  #define CONFIG_SYS_CCSR_DO_NOT_RELOCATE
>  #endif
>=20
> Now, the relocate_code function in arch/powerpc/cpu/mpc85xx/start.S does =
no
> relocation because CONFIG_SPL_SKIP_RELOCATE is always defined:
>=20
> relocate_code:
>   ...
> #ifndef CONFIG_SPL_SKIP_RELOCATE
>   ... relocate code from SYS_MONITOR_BASE to gd->relocaddr ..
> #endif
>=20
> When jump_to_copy is called (common/board_f.c), the
>=20
>   relocate_code(gd->start_addr_sp, gd->new_gd, gd->relocaddr)
>=20
> would not relocate u-boot (located at SYS_MONITOR_BASE) to gd->relocaddr.
>=20
> For example, SYS_MONITOR_BASE is 0x3000.0000 and gd->relocaddr is 0x7bf7.=
0000:
>=20
> Relocation Offset is: 4bf70000
>=20
>=20
> Relocating to 7bf70000, new gd at 7bb6de50, sp at 7bb6b540
>=20
> Any access to memory 7bf70000+ is invalid, because no relocation was done.
>=20
> When patching
>=20
>   -#ifndef CONFIG_SPL_SKIP_RELOCATE
>   +#if !defined(CONFIG_SPL_SKIP_RELOCATE) || !defined(CONFIG_SPL_BUILD)
>=20
> relocation is done in non-SPL builds and booting works.
>=20
> Testet on T1042E board using U-Boot 2023.10.02-01420.

Thanks for the report.  Can you submit a full patch to correct this?
Unfortunately there's few people available to test those platforms which
is why they're in the state they are in.

--=20
Tom

--eZgPG3S8sFVXDCkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUxkYIACgkQFHw5/5Y0
tyx98Qv+M8jBYVyVA68pWwLktmpZ5Jp+VkPhQxQjYXsYMOcOk4UxiegHzNxdYF4K
xdbk0UZyXiHXsZsCGZJC7O6Xk02cNON8IAuHmAq/4Wae76gzVId0bsqnHiinRXPx
1oDTO+oV36ePQ+/k7l3mI1fYIgFG6F28sxmFLmKdYRrzkcWqav7/YYIgfaYgycaO
bbkUczzF8koqQa4W1TOjn+wmrqA+mAHPkFsokjfeY6qickjeGf5hKIyiznzirBR0
GeAZxqfR09pI3YbbyIIduYSA0tSHf8KPcgdjGTBriZKQn3+5skYSLYNdwIYc2YOu
g9bQyuJ48GdjRik5S2aWjMvB7+S0K+HhpGag0VWYV6qfsQif+GxTM5o3iaJlFdWc
ci7WJQKJtvauGcwHnGp73W/OiDBicQdkAxoGGxjRFFLoj3OCkirlNu4/clOTD6wf
oe+DGFHUTGxgV4MBmTZmFfSYgwbSXAh7d40vj75SaNCCzxJeYagXMLi0++nxZbEj
uofcs6+z
=Xcer
-----END PGP SIGNATURE-----

--eZgPG3S8sFVXDCkw--
