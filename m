Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B3EC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 19:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56D078269F;
	Thu,  8 May 2025 21:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fJVJsX1v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01508828A2; Thu,  8 May 2025 21:33:46 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCC8A82162
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 21:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2da14a6f89aso645838fac.2
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 12:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746732822; x=1747337622; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e/H5l2SCWfI30WcIVdQWoyG74aNfNZPSO8Tm7goSDEo=;
 b=fJVJsX1v0CDVQODT7/rbKF7xITyrFOr1xeHw3Z2HgFgmu5EyicQHlCB+hve3fmlXOa
 jIpNbUWnEXBad1eKTBd0VO2Yr5GkRkKOzwGUredQrcxA6oIVBnR/uC+hLfhDkt7bdOlK
 HXwtE/QZ+nhbU8fw12F47DMdYuI86tTO8yX9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746732822; x=1747337622;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/H5l2SCWfI30WcIVdQWoyG74aNfNZPSO8Tm7goSDEo=;
 b=ISXCLl7ES5w7YUuvRRI2KM4zdlscy2iQA9fJ1GugO7o5vl+r2eNdlQARKzzki4jE6B
 +2V2Hzkpf+K6s+JNRHSqxCEMyIZSI1TLg5R833n9HoDI/evMwG1Z0VSPCzLYJ2x9Te2B
 o89zFQUz1KbqNYactjDkC1bafZp/pNEg+Pn+hgl+rPH8zQzQ1eroKiGdul/G8L15lEBa
 Ydpc9oWduJ5jKraRg56rSDMz3//QKPYkk/qCLb+tWmNNRx6gA/p+Zux608O67EGMUQGs
 AaZsj9Q8j7QcV1GYmy4FT8cbgMUAjvzj6jL841UaHHEyS5phdsnPjZ4aG6xauNJrLwqk
 uN2w==
X-Gm-Message-State: AOJu0YyDD8ZPTL5i4H6s57Z+W+oXxxsyKGk6RsoVAvucxJP4a8IijfhC
 Y/5e8N4+MielXiXteJFxpQ139E/aZlWAc2bapHrd9oPlBdsXAz4q8gSpqf6lOzceM44uX480BeV
 4
X-Gm-Gg: ASbGncs6X0V8pqzxdmrA92g3XhLTJO1FNK8bkzKzhHpwKnMtIsfnIo1eAJSVU9bqlgf
 3g4P2N/4BWj8MSv2n9NPaeQkrlzcD9IeuQl6yuYKpffvZLOQW/datpXM74F6Or2yPxp8SvaHvUC
 z2Z/AHvilAsLC5d2XAqvzhFc9zbLMDHg1a5Z3T2G/A0VvUMcTEx8Pq9Y8LvO31XGJDTmCO5eB21
 tRhl8s556bErQ8xZfCRuZcALYy9I0gPDazvvaJPVGNGl9Tef8ogeAb4FQWva6Kk7QulOnlAngjS
 Axy5+sD3qKcVDs1Q6IsTUcgiewd8XDgn+zA5S0KijAgkVBCVJkfqcy3BubN6NzNVvgTpdGSgE7H
 e6Q==
X-Google-Smtp-Source: AGHT+IE34KOgr8ABwmNU1Osfc7YsKNLQkVs9dHDsLvhsr+TiLf1b6vw3Xr5Wva6KwHDnEbGG6LdA9w==
X-Received: by 2002:a05:6870:2419:b0:29e:5de2:cffb with SMTP id
 586e51a60fabf-2dba434aeeemr429093fac.17.1746732822472; 
 Thu, 08 May 2025 12:33:42 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba0afcc4asm239831fac.40.2025.05.08.12.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 12:33:41 -0700 (PDT)
Date: Thu, 8 May 2025 13:33:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Johannes Krottmayer <johannes@krotti42.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] arm: cpu: armv7m: add ENTRY/ENDPROC macros
Message-ID: <20250508193340.GE603748@bill-the-cat>
References: <20250507060739.326096-1-johannes@krotti42.com>
 <20250507060739.326096-2-johannes@krotti42.com>
 <20250507165533.GO5430@bill-the-cat>
 <6d3af68a-15a7-4dd4-8095-ee2ac6037c0e@krotti42.com>
 <a138ecb5-680e-4272-8211-dbb354745247@krotti42.com>
 <20250507225123.GR5430@bill-the-cat>
 <20250508185943.628503-1-johannes@krotti42.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8swVkB/IfxUVqZmb"
Content-Disposition: inline
In-Reply-To: <20250508185943.628503-1-johannes@krotti42.com>
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


--8swVkB/IfxUVqZmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2025 at 07:00:28PM +0000, Johannes Krottmayer wrote:

> Since GNU binutils version 2.44, assembly functions must include
> the assembler directive .type name, %function. If not a call to
> these functions fails with the error message 'Unknown destination
> type (ARM/Thumb)' and the error message 'dangerous relocation:
> unsupported relocation' at linking.
>=20
> The macros ENTRY/ENDPROC includes this directive and should be
> used for all assembly functions.
>=20
> Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
> Cc: Tom Rini <trini@konsulko.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--8swVkB/IfxUVqZmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgdBxQACgkQFHw5/5Y0
tywOxwv/a19BVmnCnalPOc982Tliq1GHsfBVAs60g/p70GkV9zUaIPDtXxAOvmZJ
MNj+gW8syZt7E5+ilBndkzSmHDasj3cV+SuHqht94BJrekai3aot+hHvRd7NI+w6
sTIMfMGgmP/4TOwxFDReoGy/SSRLxmYkk8voESTSfeAi2Xd0w1JDuJvaZdsaaev7
48QZ/z6H2UIJSSQH9T3Ba85bqzfAYKeXIJ+K1HmI3S+g8AtnP9iTfFCA5l4rx2+8
PCphpiadgnkpOHZ7nqSpwP0WXjSkZoK5S1hqR2yfBRVkTz2gn1/54tc3l/dPEd/y
wVQfZQl/nOK2V8/HFyae8X9dDWg0ymzR3JQXV0RYcgDUgLdtWf9zhKVCzJVvy7od
QyZtu6MEFBgHpPcu2s6KAp+XuD+6V8Miw48JsEz8JRhXPyOHGKK1spftDQXeOO2H
TvRyPduO2KBSLmXrgY6096G8ki+KcGxMf5LNhS6ddt7ZaOnhnDkeZRpq6rakous6
tJDrbV7s
=m/iH
-----END PGP SIGNATURE-----

--8swVkB/IfxUVqZmb--
