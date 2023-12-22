Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAA3C46CD4
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 17:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50BB686FF7;
	Fri, 22 Dec 2023 18:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I2xOobr4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D65D186611; Fri, 22 Dec 2023 18:43:37 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49FF4874D5
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 18:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-78102c516a7so144248785a.2
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 09:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703267013; x=1703871813; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vwzQTYOLhB6xOKoKbNgzr6Q+26eVrZ0ia53G95eOM60=;
 b=I2xOobr4pqzom8GlnrlWerGhzHEzna8yCexih7NQfGPIuJROAf8rp/EQfIX7kZYkea
 HtP30x1R8NK9sEdlMcUzRA/FRuGk0ZMKWF60LiRaPCxawVyzZyMmaFf2yXv/rxP/Vcn1
 9V0HDRwfYCk2pq6tFsiLzAxEYdejUBJWdapnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703267013; x=1703871813;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwzQTYOLhB6xOKoKbNgzr6Q+26eVrZ0ia53G95eOM60=;
 b=Eboq6YybWGr+XlDfSwSgfDOYun5vBDcBQPMIewhJOk2E2SbEF1J2bIpuiJVn0Ftj7S
 e6WinqrWW8zh0L+WJi1yCEtErcvsjPNBWK/0QNHAgLNOJKVAiTsnKGPZp59/LwrVw6Y2
 bqCbJwAhjH43ZYmGLpFBxT9z7OGMIY5UCaFWVmGiQvina3BQy4MwDZx+e4UvZLu6PZGA
 vOCx1OySlSz0UQ2EgDhB8GJlUDCr3lJwsyXJeTcV933p49GwEu0jzSmsnqttUsrWIP7j
 Y7guUevaD0B/WM3A8sUPjYUhNJLjeue5gZIq6HA3wXts3Tjase/OPv4q0NGJd8AOLc8q
 qX/w==
X-Gm-Message-State: AOJu0Yx8DykN9AAIDXDQ1n/43pqncIARXgjLyXwMUlEGa2Z6exofZ7JR
 dwcCzgT/teYL5rdqf5ami9md0aiAxpPa/w==
X-Google-Smtp-Source: AGHT+IEXAwb0u+Nf+PIT8Yi91k/+au+WdoILkGxSEH/n9LwXMcvKg1rIrT5BLB1/+wW7jcqtSuh/Pg==
X-Received: by 2002:ae9:e10f:0:b0:77f:53ca:2e95 with SMTP id
 g15-20020ae9e10f000000b0077f53ca2e95mr2032531qkm.96.1703267013068; 
 Fri, 22 Dec 2023 09:43:33 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a6f1-1968-9d2f-89bf.res6.spectrum.com.
 [2603:6081:7b00:6400:a6f1:1968:9d2f:89bf])
 by smtp.gmail.com with ESMTPSA id
 j26-20020a05620a147a00b007812e1cff27sm457617qkl.78.2023.12.22.09.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 09:43:32 -0800 (PST)
Date: Fri, 22 Dec 2023 12:43:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rick Chen <rick@andestech.com>, Roger Knecht <rknecht@pm.me>,
 Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH 00/13] Complete decoupling of zboot logic from commands
Message-ID: <20231222174329.GD2652760@bill-the-cat>
References: <20231204002944.897949-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IsS4JwXViBiYbc1T"
Content-Disposition: inline
In-Reply-To: <20231204002944.897949-1-sjg@chromium.org>
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


--IsS4JwXViBiYbc1T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2023 at 05:29:25PM -0700, Simon Glass wrote:

> This series refactors the zboot code to allow it to be used with
> CONFIG_COMMAND disabled.
>=20
> A new zboot_run() function is used to boot a zimage.
>=20
> This is cmde (part e of CMDLINE refactoring)
> It depends on dm/cmdd-working
> which depends on dm/bootstda-working
> which depends on dm/cmdc-working

Just FYI, at this point all of the required series are now in -next so
this could come in via the x86 tree now.

--=20
Tom

--IsS4JwXViBiYbc1T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWFyroACgkQFHw5/5Y0
tyzYvgwAmuqIodNCu0CPofE8z4ZXVAP5Bam9S4UL1OHrIS+o0a1hNUJALM4vDsjU
n3KKoEJIzNiU9/uHW/hprnlcjvSxgt+ro0YLdBvsiCxWUdMIlX6UhVNaDup6/a16
lZKx09tRAUFHXbc4G0IJRr35ApyLGzc1HUBgxsVKjycVLNEegBDHLueB1iUaGFrO
Gv271rJOuyuF5NYhkcaFm6ijtIX3zhsxAgHwU4s1+XrAp6icUn3rlESwNAeTE6Q4
MWv6MtvtrZYAmXAz1545ZGseonJUxahUmFA7a85UXARhxH4gQHvN/2boY+i1FRp1
Nxb4LW7SWA0NkN6bQnQfJ6P6XiEHoQfo7+ayOLITjY/QfpmN9wyFUIFLlGgE6f4R
fvbfjwBfksRyBuiPCTwdJSvzNl3nrQFc04fq2l7eKZNQwqXl8ggt3P3CDz2Wb0+M
rSs5h/pYMqre3o1VKK0x5ZhKdDmRn+lnYDkdVbmSNUO/n9fvTSWitJu4hyrLFQld
AMcXT+6a
=1JNl
-----END PGP SIGNATURE-----

--IsS4JwXViBiYbc1T--
