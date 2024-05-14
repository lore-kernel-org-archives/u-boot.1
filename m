Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2A8C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 16:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 951F888321;
	Tue, 14 May 2024 18:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lg+WIqak";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2EBD87CF8; Tue, 14 May 2024 18:15:19 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC89B88321
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 18:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-78f05341128so451318685a.0
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 09:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715703317; x=1716308117; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PmSq8LdSETr27QShODFUJ0WMKXmQBe6VpCIzY796WRM=;
 b=Lg+WIqakQBPvHsrCiarzGKXuHrnEkFBxK6lyS3Jj+eqnndRWwz6N7HY0x/lx5SzT8C
 /OJOqdbFYPAoCTzCDylhkkhP0/fydrPjaA3bokUHzCn0VrjQl4VVvI6fAqxybjldtD2p
 ubFB6LuWom67DMUqnL8vIRDan27oQQY6VW00E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715703317; x=1716308117;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PmSq8LdSETr27QShODFUJ0WMKXmQBe6VpCIzY796WRM=;
 b=GKwIMkPSQ3DjN2wHuH27c6HTstFm5GLb/jLN3T+q9bRvxST6Pf32Y1PG461kxHXxc/
 OTdT1y9QtDuvcMOAJjrRPSus74pkcbfD7QgBpqSR5cF13fopiZxs01UYV9I+bAnf2Rdu
 trW6GhPPIkbbIIjs5RGxCoCBc0TSpwNN6/Cn4rNlMNA/0Q/22eW7QCKQZ+xsiJATk24z
 NoF3aZOYdCPq7LORiNmQXo3FF+OU/jdhCYPJIbZL5EAX5Lxkjok947YHrzpVh/5LbnGG
 KjozAS27VFImN5+Wx4b5i5MJQF5lmqNKAa2a5gpy6m9cOlu2yE7A5BRAzPc0ye5KK3j2
 k03Q==
X-Gm-Message-State: AOJu0YwRMvVVxVkUG5pv42QLn2yLkFlpcd230NSsnOKBTXhkuSDHs7jk
 KkpDohCdj5T+k7scfVeWFFy6jf6SRDalk9tj1ykvrrUQrk6Ts26oNhGJmT5BQRPIqvSvrXlltYq
 jIvc=
X-Google-Smtp-Source: AGHT+IE0X6AihpRhgKbkR7JZUP0efmK7Her4TQ93UvEd8KtDCMue9RPSDJuBbThQAnmTt0WnP3PJRw==
X-Received: by 2002:a05:620a:941:b0:792:bc47:4064 with SMTP id
 af79cd13be357-792c75a0f26mr1350050885a.25.1715703316634; 
 Tue, 14 May 2024 09:15:16 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792dbc57811sm265533385a.14.2024.05.14.09.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 09:15:16 -0700 (PDT)
Date: Tue, 14 May 2024 10:15:13 -0600
From: Tom Rini <trini@konsulko.com>
To: WHR <whr@rivoreo.one>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3] sandbox: make function 'do_undefined' properly
 compiles for PowerPC
Message-ID: <20240514161513.GM2568172@bill-the-cat>
References: <98e71d2cd17cd9992e60190ede4a5b03.squirrel@_>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rhiphOAujL+mV3Qe"
Content-Disposition: inline
In-Reply-To: <98e71d2cd17cd9992e60190ede4a5b03.squirrel@_>
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


--rhiphOAujL+mV3Qe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 12:55:10AM +0800, WHR wrote:

> The 2 bytes 0xffff is too short for being a PowerPC instruction, resulting
> in an error similar to:
>     /tmp/ccW8yjie.s: Assembler messages:
>     /tmp/ccW8yjie.s: Error: unaligned opcodes detected in executable segm=
ent
>     /tmp/ccW8yjie.s:223: Error: instruction address is not a multiple of =
4=20
>     make[2]: *** [/tmp/ccyF4HIC.mk:17: /tmp/ccCKUFuF.ltrans5.ltrans.o] Er=
ror 1
>=20
> Signed-off-by: WHR <msl0000023508@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--rhiphOAujL+mV3Qe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZDjhEACgkQFHw5/5Y0
tyzrqQv/byQH9+Kq0hEEgVnrR/nuoM02RXcGSmR86uKZ5+UH3Mghia892Cq4Ugk1
llgvg45bqiTNI9lAZJFdQU4sLaKSSzX6q8DWGmhcOzCLjSI6vgo8cTT8XaW5lKKz
TI3zeQTERmnjeGcmMMDBdo9RE4+J9LuVhdSesEQXMku29DV/izj0dfD6iDk4iuMl
1PaGCMzqWqqf1L7u70zjGsnKMQqZBqccGb+gWgvDe8WyW5WE3anPn9uFnW8XfDeJ
D0XnIf6By21xOPL0B5Mj0wCEJIdC0gkPsGtGY41aDE3VK9Pr6DRusR/Q1JR3iZG1
qNzXfKJTivuctZZMrXpmg6O96mTEPOf7cQJ97uEYbXfo/Gs/BB2iv7gMyqBknXFS
Z4PKHvcaWcvRwKyQMF3CgUe3cG1QvBlxMYYEXbm2Sxe8eI2WxyXrkhEdVe3S2sLY
Cq6RS7PVyIjqAtctxpIyGnRTQGJu45LcdOb+M2wpsKhRFlEJjqIBaosh5x87nNtV
Q9S5XD7D
=/HSP
-----END PGP SIGNATURE-----

--rhiphOAujL+mV3Qe--
