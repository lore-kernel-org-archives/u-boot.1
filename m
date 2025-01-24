Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC11C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 19:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32D9E80C96;
	Fri, 24 Jan 2025 20:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TTCyPc/G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EB7980C69; Fri, 24 Jan 2025 20:18:48 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 394EC80E90
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 20:18:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b6e5ee6ac7so203852085a.0
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 11:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737746324; x=1738351124; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=larncJrmdDYtLn3J8N2XzcLKASI13muOER96gZIgmqU=;
 b=TTCyPc/GKM8zibWwsHfgt69bIaGZa9CeJzlkLrphc8LIcEcHm+rVJczjIHFI/TjSbg
 DYVbwdVT7ULZtCAoOV+EMqcnwr01oITwAQ9CVc/PKz1vHXgeZqKXe6K3XLhcDZ7l6oSC
 Wl5Iu5g6Wg0JtMLTruTQBjrxAuJPwHePQw5SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737746324; x=1738351124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=larncJrmdDYtLn3J8N2XzcLKASI13muOER96gZIgmqU=;
 b=gTqG8SlO4+tq3sa7lsR2751GPZefq4ik1lFQmol89m3W6YjzV4U55Wi+s14nYuufMu
 gcMjJH2xaDgrASs+Q6o2qKFaw5amI40apZt7QRud0AuVm1pKh+Y/ojCFFQMPFwv6Kacc
 Df0Xe9FH2R80R81KSyA9yGBnJLnIU5bHfJqldUlaoskAK6LWv+5SCjCV53q1fINYIkpc
 NxKUqzh0QZBcxGSMSRlLsMBhFUrinvHcnT1CuD3EivNJv3+7O8H8y3Bf9HUHEwTvKckS
 KHSiRb7MLzFPAZ/2MuhGq/l0Eo5Mc8MvuEB+7PJ8K9KcrRqVR93jqR9L06dHniCS5coe
 N6DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFBIhJOzC/IA32qreNNL1CpKkhh8mQ7ssRNPH5OzZMYcgPugo5oWBB6XtwueBbNSKAhPoT/5Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwPsclecLBypv7XtJXiWdQkObr66mx7v6mAyX3aY7xa/OHvYhjT
 S6FC+1ImWHvsagsHUBn15kWj8tuiFpIcNqs77h7MJ2KpQKrDAuix5OVk9PdwpwE=
X-Gm-Gg: ASbGnctKIZRkyK4+IWmPQdJMkRCLe3s2NdKdBgy80LQut10biKn2ag5Jhoi9PfelkLy
 LRJ53Fq+tR3Vz1wFNcIQlbwbRZ12rX88ENBoshdVk4vsQHKs73N6lZxpubF2tjpjk10KOXbo3Eh
 z6IgRXQ4fTPsC9K70xSu0IyKFomcCGYjljEJO3xEBes5K92293V49a+yW/XQ0sITtSFqchSzJhz
 Y0q3pU8WIhrppIIsV0zy7odLfKbB470Nw7rmdhTuwuyE5Hz+Zr6x6BiAqGu/bkI8zWw0/5Gz7BS
 I+Rj
X-Google-Smtp-Source: AGHT+IH43f/pZIaegaLciI15mmV5o0jgePPtvCAYRwKjbMl0dFV7r23atvSkOp0o178ngItWsTMljQ==
X-Received: by 2002:a05:620a:4442:b0:7b6:d6dd:8826 with SMTP id
 af79cd13be357-7be63289dccmr5603599785a.55.1737746324082; 
 Fri, 24 Jan 2025 11:18:44 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9af0d1efsm122104885a.101.2025.01.24.11.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 11:18:43 -0800 (PST)
Date: Fri, 24 Jan 2025 13:18:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>
Subject: Re: [PATCH v3 0/5] Add pmem node for preserving distro ISO's
Message-ID: <20250124191840.GT60249@bill-the-cat>
References: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
 <CAC_iWjJtjNE0-VJJT1+aCoaADDNYyy-niZSizo-Sn6898ArLHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CChDn/kKeqnGGPbN"
Content-Disposition: inline
In-Reply-To: <CAC_iWjJtjNE0-VJJT1+aCoaADDNYyy-niZSizo-Sn6898ArLHg@mail.gmail.com>
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


--CChDn/kKeqnGGPbN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 01:39:45PM +0200, Ilias Apalodimas wrote:
> Heinrich, Tobias
>=20
> There's a slight problem that I forgot when commenting v2.
>=20
> Heinrich's idea of plugging this into blkmap is eventually the right
> thing to do.
>=20
> However, when I started coding this I only added the pmem memory as
> 'reserved' in the DT hoping that would work.
> Unfortunately, this depends on a kernel config option. I've managed to
> track down the problem here[0], but I haven't found time to test it
> properly and send it upstream.
> So for this feature to work reliably we *need* to remove the memory
> map we hand over to the OS.
>=20
> Since using EFI memmap function into the blkmap code makes no sense,
> can we perhaps merge v2 (or a variant of it), which only targets EFI,
> with an explanation of *why* while I try to sort out the kernel issue?
>=20
>=20
> [0] https://git.linaro.org/people/ilias.apalodimas/net-next.git/commit/?h=
=3Dmain

I think this is a reasonable path forward, FWIW.

--=20
Tom

--CChDn/kKeqnGGPbN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeT55AACgkQFHw5/5Y0
tyz1BgwAluLaEVTqBwwxSEbfRvUafcvsDO6ETS2332goyOQsXGzqd6T82yr0Ux+i
qELBFGx5SVaLvvVGXDXdG97fnM+Cn3aEbQqbOLrJ25+eferlTHT2qWxq8AITonSr
y/8RC6Dv+0pJZesZcTPJIkkQ25muVZQ9d/5luHE4/6c8SKxta9/f+3H6dn4FNDg9
wPs2jbC84cvI7Y789pFi/43iq/rfttwMJP4xrGucT87XY6FgaLOqGyfbnGktlbjK
i+peUHBSH4gMj4DyGCraqmA0nsg3wTV59Bi7Hn/t4jdt3asHA6oGAC9ImAGsXSR9
zM4FLOMh9OzpuG60WU9/PCS1INZ2nQk+Jjz3a3j9ULE5/yyKZi1bWu2JQ9Sw6TMO
8WpuIzErSLhh4sLIYnf24wB0db+Aw2MYXmJpNr4sZbNQZkEYvaWH86nxhgGYgz85
XkeiKPRomPzbeh0WWnwfOt6Yvp6YZrYYfj9N0iHJ9/6TmVDB3MyWnmns4RbKlyNp
Lo8SruBm
=hN7Y
-----END PGP SIGNATURE-----

--CChDn/kKeqnGGPbN--
