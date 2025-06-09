Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B20C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 15:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAA0782AA7;
	Mon,  9 Jun 2025 17:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IB+mOwYL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ADE782B07; Mon,  9 Jun 2025 17:35:58 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18FD682998
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 17:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72bc3987a05so2931748a34.1
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 08:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749483355; x=1750088155; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ELs0XkV4THbFM9g4Bt2uJi0/n+DHBL2cqhXrA4kPueQ=;
 b=IB+mOwYLmrwl14T0CAvmCAPq05ceP6Fl2AG+N/wxjUY0QGSa5wqQEU33ESqJeH+dt3
 IeZ1m4t5UfnetHjnl7lWzyDIWzcf4FSeUoorFi7nXu66ZZZUb63gGd8PBXv8vfcCOmOp
 k2X0ZdfnlM0dwx3pCObiDUHrvyUFMdW26GQzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749483355; x=1750088155;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELs0XkV4THbFM9g4Bt2uJi0/n+DHBL2cqhXrA4kPueQ=;
 b=Zf/DDNz6E/06X9ZIRpNIqWUASKebbPwjVktT05nbMOJP9h71cDp0t/CsL8rIPBBAbR
 Xh134lkJjEr8gGV87T37KIKfDLJGMiBNv1QW8/T4lszBGnQJJXuMWrgU6oqTvEiXI3km
 YxAqJ64yMnx5k02Rt6wZrUDhYH5UGpCtq5Pur2gfW9oo7c21fUGoDZacfX0Mg1V2p0SI
 jSLrFoGSLyi2RcW4bW0DXj9EQ9WzTuXe9+3S2YnHzw1/LAZ7i766Wo/Bu58BTH/iZWH7
 vceukXIu4hYgDv2N+Arn22X+7Qrcb4mbYNqaFc69nBpN7WB50aYLaOfzkhuuArdismcr
 5JbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqc2hhLDM8yLGWJR1GbrCdiLeutx2THvRU7hjGqqytGzZRA5lglbuxVvgmgpCnnGx2keChVPU=@lists.denx.de
X-Gm-Message-State: AOJu0YyzrEZC7U4LBs7EJVIlcEZFgTbonwtySUTB5vK0/f70YJAhiixN
 3oHWv8/uwi31mvf1ik0Q1wvq57Kno+NYqDsMLAYMvveDMZeR3O2lYfo/1wIkOGXIgpnFqnaJn7d
 OzVuTUMM=
X-Gm-Gg: ASbGncu8+uYvPLXfLZ8MwZQsbkxDOpyiz6758Ma9gwizqu7jOqJ5lB6sVYbsg/nwtYz
 pW5G3CH7PwGPdPQQgIDfKAVvseC3hXbX0/xxQZ1I1/gz+K/2wg/WaUQ47CWimGZizOv49Tbpupq
 i1Q9SZnLuTmOTE+NqncyBc6Zpb7ax/e6JBBkaxTdP1+kDP3t7qltdV5oKTiHmOLMpXe1Oh5lfM9
 to77tyvgGfEe0gpDVODj2jZ/YPgZjc5BisaiyKOKp0laDnM2iAe7O2C9EiO4NI/rhEFEILxLOXW
 ro38pIiGNpc+rNfROokT69YBqwfr32i6rsNATkNyBOFNV3WIGsJoC0QcrRaIAnSkV6G9Qd8nEub
 YYzj/UcSyxjl4
X-Google-Smtp-Source: AGHT+IHcePKFZz/lRrxLejLug3m+EaZT4rb5ugHGQD9r5t0EiB03a4lODVjiOXEtoua8Pb/cfgAKWg==
X-Received: by 2002:a05:6808:3098:b0:407:9d24:af03 with SMTP id
 5614622812f47-40a53b49ed0mr223422b6e.14.1749483342352; 
 Mon, 09 Jun 2025 08:35:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4090692dfffsm1846854b6e.2.2025.06.09.08.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 08:35:41 -0700 (PDT)
Date: Mon, 9 Jun 2025 09:35:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/3] net: consolidate PXE processor architecture type
 Kconfig
Message-ID: <20250609153538.GQ1382132@bill-the-cat>
References: <20250608074228.12407-1-heinrich.schuchardt@canonical.com>
 <20250608074228.12407-4-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y05oGtpsexvC1r0S"
Content-Disposition: inline
In-Reply-To: <20250608074228.12407-4-heinrich.schuchardt@canonical.com>
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


--y05oGtpsexvC1r0S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 08, 2025 at 09:42:28AM +0200, Heinrich Schuchardt wrote:

> DHCP and DHCPv6 use the same value defined in
> https://www.iana.org/assignments/dhcpv6-parameters#processor-architecture
> to encode the processor architecture type. We should only use a single
> Kconfig symbol for both protocols.
>=20
> Furthermore we should make the value customizable. This allows for instan=
ce
> to choose between "x86 BIOS" or "x64 UEFI".
>=20
> As "x86 BIOS" is encoded as 0, we should not use this value to switch
> off transmission of the DHCP option. Use 0xFF instead.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--y05oGtpsexvC1r0S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhG/0oACgkQFHw5/5Y0
tyw8HQwAnnho7+b9IMS/aOGNzqJsI+dlbi4gC7lPJaSyNqX0GTEmiceNF7mRIXTy
+ymYeYNA7eJZnTP6zxg8KBIHnN17TFpVjsyEmbI+u08SIIufdDpW1rhnq95/Drdc
uP7flVCukl0NrGPh52SUyL8Ofyv/xc4Gz+6H5o8IqUFG7FDQgFasOm6cF2RzcHNa
vMZe2e+ZANOdul7epMYsmRPfIZOG1mBTQlUKDSav/gapMqtFiQMzicJ1Vi9OBUMd
xJPMI03bgsiLO3EKDfH5/R7moG+I0lViy9rQuLzRXzpWhAl1mM/p82GMMk3tiLlk
kcsCDQD9eZU61+Y21vU+RhDM2W5ca+9pkK9bepQ8tKPkWysWfnXtASxA8iVa43fF
teUa/7npj4RDKe0JBmiSQlv5ZqC7QmSyj4EbsYHiod9pjph/mWtJGG42qnXmhJsu
xWoYqs46IV4S05B98b7QUm60OH6j9I+A/MQKibFWRdLeqVoLjyog2GZBasaevs3a
RGqmXY9S
=LVLt
-----END PGP SIGNATURE-----

--y05oGtpsexvC1r0S--
