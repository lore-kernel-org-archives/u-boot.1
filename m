Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94142E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 01:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E01458031D;
	Fri,  3 Jan 2025 02:41:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T0z+2/zR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B9328036D; Fri,  3 Jan 2025 02:41:03 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C4F980196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 02:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6d8fa32d3d6so50262186d6.2
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 17:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735868455; x=1736473255; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sefTFltH0kgCuzIKwP/+rtWR83wsOVPoJtO7Pm3qnik=;
 b=T0z+2/zR9hBa56Cut5EhS1/DXC2LBVf1Q+KMUF6SoOWR8iBxu66P47EzSNdo1B+5DZ
 0DQazbees3HuOX0c6IYgTvBN4Rwe1zmFlVkeoVm9Al9zrMbycAlKaoS84gRz1wtP+3Ej
 0Owr+pZ7w6cgaA/6lM9y4TJKTGLplQmwvViaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735868455; x=1736473255;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sefTFltH0kgCuzIKwP/+rtWR83wsOVPoJtO7Pm3qnik=;
 b=WqWG0R9fdWVNlfZzpiWExL+iXTU/d9olr7Eiy8DDA77TYWaz34VzJCiVSLKYx6z91a
 oSdXvl+P6AB7pXtaXTJBj3OIioahrLOnfXZnz+ZfaTglwO2imeIctr/cclYEuyKqkDSn
 BBRh9L9I6xGgskIy/iM3191TueO09JG50wB2l/W2vLLfSW8sFWx4ydqmZN5pQN3EBsh2
 NHa0wlVZHYzScXjqSZa5fKyF4PLr4E3DFRxoDxB3YQsLF0bUeYUDZxZwZXTKCz/LYJe7
 PAUCPhy4bYJPHuJSf7Ek2eqQON0ePhx9Yr892c1AbSDbIgYEsvFi5IlE39EAgZf5oArZ
 ByNA==
X-Gm-Message-State: AOJu0YzkBu1f1JVwt1/lJ1L+PPaWJ7nl48du8/e3aIkvdhZxMYZzP1lb
 Gg1UWDUNiTtqGUqzKKRJjHoJY+xGr1nVxU3j61N8SkdCzo8sdy1iUmFl0f9vm2Ayi+Z/ZG5CtyZ
 u6tg=
X-Gm-Gg: ASbGncsLClRLUixmaOWWfUel4bNUNkIPalAUaAfLyzUHaKfQlQWwtMR6PRAVmf3kU/D
 kUqQP0aG+fe44vlKUqa865Z8RExAOw7ptZbE36tEnA8e36rjd2HcKflY6ou3UhoUIpYyS7ESLuL
 d6/MxxeM3AY9fUKUygVkjGIww7PCVpS+2cfWxw2g43IPES5D0izNhpnKcU40V5ZEdGMzelbrbzi
 2j8erkQq16KLscS4QOA+9cNW9eJrned6f4+BTKHU+mmwSxqdXzqR86aZg==
X-Google-Smtp-Source: AGHT+IFg5EDHaIHXLmm+artzqC+FoOOXnFlSRt7fIpaU8n2m4kkGwdQdtqhRrt3fOS9il89Pd8TpNA==
X-Received: by 2002:a05:6214:19c9:b0:6d8:a0c8:e468 with SMTP id
 6a1803df08f44-6dd2335d779mr716542556d6.24.1735868454966; 
 Thu, 02 Jan 2025 17:40:54 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd4194937bsm102785356d6.95.2025.01.02.17.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 17:40:53 -0800 (PST)
Date: Thu, 2 Jan 2025 19:40:49 -0600
From: Tom Rini <trini@konsulko.com>
To: E Shattow <e@freeshell.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: LwIP and multiple network interfaces
Message-ID: <20250103014049.GT3476@bill-the-cat>
References: <de7bf6b3-fd45-4c8f-a492-bd41db2aa904@freeshell.de>
 <20250102224724.GS3476@bill-the-cat>
 <aa6d5dce-473c-447f-91b9-fe802f0f520d@freeshell.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a2EtCrdZqR+JWZir"
Content-Disposition: inline
In-Reply-To: <aa6d5dce-473c-447f-91b9-fe802f0f520d@freeshell.de>
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


--a2EtCrdZqR+JWZir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2025 at 05:34:57PM -0800, E Shattow wrote:

> Tom sorry about sending this reply twice, struggle here is with Thunderbi=
rd
> mail UI sometimes hiding "Reply All" and it missed the mail list first ti=
me
> around.

No problem.

> On 1/2/25 14:47, Tom Rini wrote:
> > On Thu, Jan 02, 2025 at 02:26:06PM -0800, E Shattow wrote:
> > > Problem: 'dhcp' must be ran twice when the network cable is plugged i=
nto a
> > > port other than the first network port.
> > >=20
> > > Network cable plugged into bottom (first) Ethernet port:
> > > 1. Power on
> > > 2. StarFive # dhcp
> > >=20
> > > ethernet@16030000 Waiting for PHY auto negotiation to complete.......=
 done
> > > DHCP client bound to address 192.168.2.51 (3678 ms)
> > >=20
> > >=20
> > > Network cable plugged into top (second) Ethernet port:
> > > 1. Power on
> > > 2. StarFive # dhcp
> > > ethernet@16030000 Waiting for PHY auto negotiation to complete.......=
=2E.
> > > TIMEOUT !
> > > phy_startup() failed: -110
> > > FAILED: -110
> > > ethernet@16040000 Waiting for PHY auto negotiation to complete...... =
done
> > > ethernet@16030000 Waiting for PHY auto negotiation to complete.......=
=2E.
> > > TIMEOUT !
> > > phy_startup() failed: -110
> > > FAILED: -110
> > > Could not start ethernet@16030000
> > > 3. StarFive # dhcp
> > > DHCP client bound to address 192.168.2.77 (31 ms)
> >=20
> > What happens when you set ethact to 1 first?
> >=20
>=20
>=20
> '1' literal does not seem to do something so I guess it is meant the id of
> the first ethernet interface:

Yes, I misspoke sorry.

> From power-on:
>=20
> ...
> starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
> starfive_7110_pcie pcie@2c000000: Starfive PCIe bus probed.
> In:    serial@10000000
> Out:   serial@10000000
> Err:   serial@10000000
> Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
> starting USB...
> No USB controllers found
> Working FDT set to ff700a10
> StarFive # env print ethact
> ## Error: "ethact" not defined
> StarFive # env set ethact 1
> StarFive # dhcp
> ethernet@16030000 Waiting for PHY auto negotiation to complete.........
> TIMEOUT !
> phy_startup() failed: -110
> FAILED: -110
> ethernet@16040000 Waiting for PHY auto negotiation to complete...... done
> EQOS_DMA_MODE_SWR stuck
> FAILED: -110
> Could not start ethernet@16030000
>=20
> Again, from power-on:
>=20
> starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
> starfive_7110_pcie pcie@2c000000: Starfive PCIe bus probed.
> In:    serial@10000000
> Out:   serial@10000000
> Err:   serial@10000000
> Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
> starting USB...
> No USB controllers found
> Working FDT set to ff700a10
> StarFive # env print ethact
> ## Error: "ethact" not defined
> StarFive # env set ethact ethernet@16040000
> StarFive # dhcp
> ethernet@16040000 Waiting for PHY auto negotiation to complete...... done
> DHCP client bound to address 192.168.2.77 (149 ms)

So then yes, the second interface works when ethact is set to use that
directly. This is the same behavior as the legacy stack I believe.

--=20
Tom

--a2EtCrdZqR+JWZir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd3QBoACgkQFHw5/5Y0
tyxL+Av+JHZ+jAb7wR1kNMX0ZoOxb3yvEaCXEfeFlSn88WUCHSKhNirqf2ts0NOd
4otrVTiYhxHo1uNuuRuk6ytC5/loprSrgsZWChiOfucwllg2be6hsv+lCXAoAmIP
zgahSj6PYI79KMyBKYiN4JyzU+56gUN4dbLn4dVP95huyLPPwd1XcIAlSviqL0Pt
ozPFaqv+mgPwnuHWqNYdu8Dn//5MV9TFne5BVsylCUKvZEDR6d/caMRHbHr8U5wx
l9jOOhyk4IP5t8GPMxu/+JTpMo6ciQpbG8lFOngINegJucHw5KAicKwlJgpqVQFP
BatLSGTPU7LvVoSmMJdaRLBsg1FIwHX65tLT4F2VITFpfoMjOS/j2FZd4hDEfYIN
UIQyJSn4o2td90QAS/wCBk26gKxHi1yZeYCF1eUcX+cJGGWVRKEE+4H/82e7OuFn
fZNtBro3uFGUahhb0Wvm/PTaClAjIzBmChzceuzng2jOEvoLyZnCVhePCEyhE1UZ
ucjbZPp0
=APwv
-----END PGP SIGNATURE-----

--a2EtCrdZqR+JWZir--
