Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8704CC4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 15:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7271E86314;
	Mon,  5 Feb 2024 16:41:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ag2Dlk6n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17240875E9; Mon,  5 Feb 2024 16:41:29 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AA5986308
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 16:41:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6861538916cso26897176d6.3
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 07:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707147686; x=1707752486; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QO+TdPmaxkANhFkMnn953Ru/9GsAeUJoHOZNJiLSjdg=;
 b=Ag2Dlk6nAUBJU3w6Tt/yBUgbLq6hRehSIgu8wYHjaMuwPzAFSnkiZeCpzMSRa+8U4W
 An+8NM1pLIKtM3Y8qtn/Bqq3QmdvVaRZBs9dhSH+Ui9fVPuCf1SBIvXmbl8AFT7YI2Zj
 lzUs/RMIypqGEfS8865VMedC6tm8ztLH8766k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707147686; x=1707752486;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QO+TdPmaxkANhFkMnn953Ru/9GsAeUJoHOZNJiLSjdg=;
 b=vcdGHJeBU8kmeF3rHjfUHIZBpygPeOtzIvo2Fpvwi5DkN0dGZfmdDT5meFCGz7hsiB
 hmpP29kI3O++pg9sdL9PzYMlkOFnDyI3uasSR++YQlHF8HQM8/dkhXDqmSaAW+xiS/wE
 tkPe/vyhIBZLaN0BODMcBE2STR002tMhOFi0GrebpsdF/JGXUXQP0PnQPpwuv+gk75Av
 93L9osh3jswMF6eLpwc8FcvxHRum8Otyz90RBJNj2M3qhuuEP1j+XjrkO6FoB1pzRUAb
 KgO/wvbjIEfYtk5vljgWxBMtV50CPy7mCbteMb3/tcKv9+k8LX+jGARRHjHbSs9rbIB+
 pvAg==
X-Gm-Message-State: AOJu0YzUsjK23Edbj2gu0DVj6WG76WWNhpaVlJei4SU4+pEdPf9clqFP
 WXmlhTe97JF31MpI+akNatSzqqnk4iSrLMaLuq+VK3053cHhdjrNcg4jRgwMwvc=
X-Google-Smtp-Source: AGHT+IHPuC3cLnlv34Pw0JS9LGP0luESOLXjo+KDe5SisqLRgOw/QJCfZO5HUzhL5STRPjpbKMHIUQ==
X-Received: by 2002:ad4:5aec:0:b0:68c:6a65:895f with SMTP id
 c12-20020ad45aec000000b0068c6a65895fmr8461455qvh.10.1707147685783; 
 Mon, 05 Feb 2024 07:41:25 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWdAnH33We3/A/PC03uvJ+Q+1iJW+B5qzLBj81EKHTUHNVRHyzHsoF7dNVi3w2vJsa4sivlObiXL6Ut759QFnaVAyjx7soYFOI2W8fi/aCjHYU9Sf5PQg==
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 qj11-20020a056214320b00b006869485d9eesm70991qvb.82.2024.02.05.07.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 07:41:25 -0800 (PST)
Date: Mon, 5 Feb 2024 10:41:23 -0500
From: Tom Rini <trini@konsulko.com>
To: Minkyu Kang <promsoft@gmail.com>
Cc: Stefan Bosch <stefan_b@posteo.net>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3 0/2] arm: s5p4418: fix relocation
Message-ID: <20240205154123.GJ1152441@bill-the-cat>
References: <20240126125056.16439-1-stefan_b@posteo.net>
 <CALrBrZ2k5ZyK7C27gnq+SfaLAo=VfyR4XVm-7PaBfeOFnf2j5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gufDSnoRE3xgqptN"
Content-Disposition: inline
In-Reply-To: <CALrBrZ2k5ZyK7C27gnq+SfaLAo=VfyR4XVm-7PaBfeOFnf2j5w@mail.gmail.com>
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


--gufDSnoRE3xgqptN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 06:35:07PM +0900, Minkyu Kang wrote:
> Hi, Tom.
>=20
> Could you please pick this patchset up?

Aren't there other patches you could pick up as well for a PR? I can
pull this directly otherwise if not.

--=20
Tom

--gufDSnoRE3xgqptN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXBAZ8ACgkQFHw5/5Y0
tyyVrgwAk4wF7LNzSQ7/sEIcbweWYo6vIppP8CQ2GCUxns9nLV4vGlOVJVFbXOHT
KXpC+Tc2uT4wa6mBUgpLKVE1YcKN7+J/zlC4WcAN2JVt4v4gF1gxuBuv6RWJh4Nm
FXmhuGCDUSIL6IDJqfV3KkiEyS5jacfrc4zuPR11/DofqBySPZZXieJTQjUiygcK
lCtbTQNZ3js+pHCW8cqljahGQZ8v16x9GfC0h6RjisjSXdwg086hSR9HSiN4oPIG
pYgt6I+5ZSGP1L65NqgvOXloK98DWC3CA+mR1c67Vozc1n/0D03qkV8ltdIX9Agm
NW7dyWEZ2JIeF3INxoFsJzg+rNffoX5q8syhuO7MjiqEBLB7RsG7KnZ1lvznDZQ0
rekgF8garY+DgK877LVyQoZ3nccPtEL+yWyoW8WtHoh/qGfBxvUSkSNiyyOw6bqk
03hJiM5W7wwhLHMMp+LO3mI9hknZJK3DIQOLR+5m16vmp3eYCom5TDvleAZhGJRs
oBlvMFCC
=NWhZ
-----END PGP SIGNATURE-----

--gufDSnoRE3xgqptN--
