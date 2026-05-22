Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342D7CD5BB3
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 18:32:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 573258488A;
	Fri, 22 May 2026 20:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dla4AoSy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6EEA848A2; Fri, 22 May 2026 20:32:34 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 181D484879
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 20:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e582b3bcaaso6392665a34.3
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 11:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779474751; x=1780079551; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jqh2XuBCX8IqYdBA7rYRBNjAIv65sWqfOkKEmbSJdlE=;
 b=dla4AoSyR4jg4kjv7ggRFCk1goCO6GF7j5vji1Ex2sRYnC8f7w1WrR0QcrlDrhGblu
 Gpe2NrhfXSE8mByxL/rSdc29v/nIvFX3PjfQ447MBOYggHbROrj0rtjKl177oh2eq2uE
 VPN8yUYEZn+kU0bYMw0nxqDCP8Lp3WidcPQX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474751; x=1780079551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqh2XuBCX8IqYdBA7rYRBNjAIv65sWqfOkKEmbSJdlE=;
 b=YZwrBry1xQvrSTvypa0OzUxaxEqYRrQXHDX3ybVKWkR01UZo2f7vfKYDO9OuyMFpWk
 tKbYcJwdAvPi/amXVs+TIB7WkANJsFDZtvvEJbO3pSdyV7ca1pSnn5dO3Abv8L3r09QB
 lE7krbnroGKSxDeOPsY0crbMZ/HwJNKYiHpL2DShz7mZdPx+zE52agcgeknlbcNW41eB
 i7eQWfEVgASJVa+S8U6tdNoWMsH5nIHlj+LNOkqaAqryeWm/oIBb1UnegpUtfMyBJtCR
 sVEwGZhuDsZ1M/AbxkBxoZK10td49AsCkM1ICHh6gOw/rCoJtqj05tuChHyNqvvyePe1
 GPNw==
X-Gm-Message-State: AOJu0Ywy5qxto6PdWN1F++qVq8ti5OsH0hEH+A1ufcGy2CL//C0lG72p
 krH9plMUgG1ZDEeTYgSFhkqrI6X4+CuaqoV7oPFPFrQz+wh9tYrfUuyQI01WFN3P4FU=
X-Gm-Gg: Acq92OGXld4HU+LcHeOOW333zMQcGD6kO+a20jxlWqyd/RHdiee3zkRU4vViOTmrYp1
 k++KT7peX842YQ4izHxG5WOIuGv7Fus5Tf3IcWJgieoJMs66PAKcaFsi89f5IZ6kAl4GJyToOCk
 FEDug1aJTtZKEmPTfTr1J6U9rfmKbB86tCNqjk2rFwgDU+w5UPwi0hEIuhWueuL3LDOmLa9c+5x
 Ez0inyIugPO3B+8XtZRTVV7pPGTBeIOtayNmtiRqPUp0YlCRei7z5W/jEvS5DPWoZL9v7IxJ1DM
 k6SVguwSHqpvHx+/kwtGuwRV5Vhg/Dah13MotvsCqjcdcY3f+7XJcBDBjQXQoDXsPNvZGmiu4zi
 tDxezgrhbamjsKYM0oLjcGMBx2jOEfIRseopsrRHFLQFBUhKeaoA81+Uozp5eBM8ofQc4aftDrc
 73luvzrkDl9zrC8AQSvf8UTMQiYywMR1DUupZLbv1fPrr/ZWLOdoK+a+CV7uaJdT25K1gurQfKd
 IGQ7Hgm6jIJeALlD//KROi2UIsLSPfuv8paycr5vyzHkQ==
X-Received: by 2002:a05:6830:4988:b0:7dc:3db6:f02 with SMTP id
 46e09a7af769-7e5fed893demr2826294a34.9.1779474750714; 
 Fri, 22 May 2026 11:32:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6064aa0bbsm1574914a34.12.2026.05.22.11.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:32:30 -0700 (PDT)
Date: Fri, 22 May 2026 12:32:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Anton Ivanov <anton@binarly.io>
Cc: u-boot@lists.denx.de, vr@binarly.io
Subject: Re: [PATCH] fdt: Check return value and len of fdt_get_name() calls
Message-ID: <20260522183228.GZ1858239@bill-the-cat>
References: <20260522123024.6292-1-anton@binarly.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="01lpZS/rGepQdWyQ"
Content-Disposition: inline
In-Reply-To: <20260522123024.6292-1-anton@binarly.io>
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


--01lpZS/rGepQdWyQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 01:30:20PM +0100, Anton Ivanov wrote:

> From: Binarly Vulnerability Research <vr@binarly.io>
>=20
> fdt_get_name() in scripts/dtc/libfdt/fdt_ro.c can return a null
> pointer. This happens when the fdt_ro_probe_() or
> fdt_check_node_offset_() check fails, as well as when the
> '!can_assume(LATEST) && fdt_version(fdt) < 0x10' condition is true
> and the FDT node name doesn't contain the '/' character:
>=20
> 	const char *fdt_get_name(const void *fdt, int nodeoffset, int *len)
> 	{
> 		const struct fdt_node_header *nh =3D fdt_offset_ptr_(fdt, nodeoffset);
> 		const char *nameptr;
> 		int err;
>=20
> 		if (((err =3D fdt_ro_probe_(fdt)) < 0)
> 			|| ((err =3D fdt_check_node_offset_(fdt, nodeoffset)) < 0))
> 				goto fail;
>=20
> 		nameptr =3D nh->name;
>=20
> 		if (!can_assume(LATEST) && fdt_version(fdt) < 0x10) {
> 			/*
> 			* For old FDT versions, match the naming conventions of V16:
> 			* give only the leaf name (after all /). The actual tree
> 			* contents are loosely checked.
> 			*/
> 			const char *leaf;
> 			leaf =3D strrchr(nameptr, '/');
> 			if (leaf =3D=3D NULL) {
> 				err =3D -FDT_ERR_BADSTRUCTURE;
> 				goto fail;
> 			}
> 			nameptr =3D leaf+1;
> 		}
>=20
> 		if (len)
> 			*len =3D strlen(nameptr);
>=20
> 		return nameptr;
>=20
> 	fail:
> 		if (len)
> 			*len =3D err;
> 		return NULL;
> 	}
>=20
> The fdt_get_name() function is used in fdt_find_regions() in
> boot/fdt_region.c:
>=20
> 	int fdt_find_regions(const void *fdt, char * const inc[], int inc_count,
> 				char * const exc_prop[], int exc_prop_count,
> 				struct fdt_region region[], int max_regions,
> 				char *path, int path_len, int add_string_tab)
> 	{
> 		int stack[FDT_MAX_DEPTH] =3D { 0 };
> 		char *end;
> 		int nextoffset =3D 0;
> 		uint32_t tag;
> 		int count =3D 0;
> 		int start =3D -1;
> 		int depth =3D -1;
> 		int want =3D 0;
> 		int base =3D fdt_off_dt_struct(fdt);
> 		bool expect_end =3D false;
>=20
> 		end =3D path;
> 		*end =3D '\0';
> 		do {
> 			const struct fdt_property *prop;
> 			const char *name;
> 			const char *str;
> 			int include =3D 0;
> 			int stop_at =3D 0;
> 			int offset;
> 			int len;
>=20
> 			offset =3D nextoffset;
> 			tag =3D fdt_next_tag(fdt, offset, &nextoffset);
> 			stop_at =3D nextoffset;
>=20
> 			/* If we see two root nodes, something is wrong */
> 			if (expect_end && tag !=3D FDT_END)
> 				return -FDT_ERR_BADLAYOUT;
>=20
> 			switch (tag) {
> 			case FDT_PROP:
> 				include =3D want >=3D 2;
> 				stop_at =3D offset;
> 				prop =3D fdt_get_property_by_offset(fdt, offset, NULL);
> 				str =3D fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
> 				if (!str)
> 					return -FDT_ERR_BADSTRUCTURE;
> 				if (str_in_list(str, exc_prop, exc_prop_count))
> 					include =3D 0;
> 				break;
>=20
> 			case FDT_NOP:
> 				include =3D want >=3D 2;
> 				stop_at =3D offset;
> 				break;
>=20
> 			case FDT_BEGIN_NODE:
> 				depth++;
> 				if (depth =3D=3D FDT_MAX_DEPTH)
> 					return -FDT_ERR_BADSTRUCTURE;
> 				name =3D fdt_get_name(fdt, offset, &len);
>=20
> 				/* The root node must have an empty name */
> 				if (!depth && *name)
> 					return -FDT_ERR_BADLAYOUT;
> 				if (end - path + 2 + len >=3D path_len)
> 					return -FDT_ERR_NOSPACE;
> 				if (end !=3D path + 1)
> 					*end++ =3D '/';
> 				strcpy(end, name);
> 				end +=3D len;
> 				stack[depth] =3D want;
> 				if (want =3D=3D 1)
> 					stop_at =3D offset;
> 				if (str_in_list(path, inc, inc_count))
> 					want =3D 2;
> 				else if (want)
> 					want--;
> 				else
> 					stop_at =3D offset;
> 				include =3D want;
> 				break;
> 			...
>=20
> There is no check that the value returned by fdt_get_name() is not
> null, which leads to a null pointer dereference (at *name and
> strcpy(end, name)) and a potential stack overflow of the 'end'
> buffer. However, if the strcpy call succeeds, the subsequent
> 'end +=3D len' decreases the 'end' pointer, since 'len' is set to the
> negative error code returned by fdt_get_name(). As a result, the next
> iteration of the loop writes data to a stack location before the
> start of the 'path' buffer, which can be used to overwrite the
> return address of fdt_find_regions() and achieve code execution in
> the context of the bootloader. This attack is possible when the page
> at address 0x0 is mapped, which is common for embedded devices, so
> the strcpy() call doesn't fail.
>=20
> The same lack of validation exists in fdt_next_region() in
> boot/fdt_region.c, fdt_check_full() in scripts/dtc/libfdt/fdt_ro.c,
> and display_fdt_by_regions() in tools/fdtgrep.c.
>=20
> Fix: Validate both the returned pointer and the length before use.
>=20
> Signed-off-by: Binarly Vulnerability Research <vr@binarly.io>
> ---
>  boot/fdt_region.c           | 4 ++++
>  scripts/dtc/libfdt/fdt_ro.c | 2 ++
>  tools/fdtgrep.c             | 2 ++
>  3 files changed, 8 insertions(+)

So scripts/dtc/libfdt/fdt_ro.c comes from https://github.com/dgibson/dtc
and should be sent upstream there too (and all of scripts/dtc/ is, for
reference for the other patches), so that we don't drop this part when
re-syncing later via the linux kernel.

Next, please rewrite the commit message to be concise and follow best
practices and examples found throughout the codebase. This applies to
all of the patches you posted, thanks.

--=20
Tom

--01lpZS/rGepQdWyQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahChOAAKCRAr4qD1Cr/k
Cmn7AP4ztR7BX67NL4sSZ8rKKVgxyeOIfuMQ9tx6S9Xh5JWbJgD8Cx/jO86wscXz
B2a0gFXpErp/+nmK9dmNM2fGjyP6DAU=
=tqaf
-----END PGP SIGNATURE-----

--01lpZS/rGepQdWyQ--
