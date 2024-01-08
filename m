Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B833C47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 18:27:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 851EF87A35;
	Mon,  8 Jan 2024 19:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jMBt1kFZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 162DD87A35; Mon,  8 Jan 2024 19:27:34 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 905B587536
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 19:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-78315243c11so163382185a.3
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 10:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704738450; x=1705343250; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=egDvNfTX1gkMACd1qGavZ1sIFR1NKqQSX5uQl3aGHeA=;
 b=jMBt1kFZdCzYubK8N7lcWH4c6faR0yc2Gmhpz6GQTCRaLSW22tqPfjrkmxBkhE3Kyj
 dMySHz1GMCEX3aiR0vC3rMTQ3C9hGE0cfMS5hyDCafDJ9/o+NtOV7rCRZLBjxLGoqWuS
 hGex9mvuQoNUqhGJi2WUND98nCFtvnLZ+EhW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704738450; x=1705343250;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=egDvNfTX1gkMACd1qGavZ1sIFR1NKqQSX5uQl3aGHeA=;
 b=xJkws1FcyCsd88jNKY8JII4bmCb8QCIZfbdVuCBpGlo8Okwx2w93FE+fmqkt/pBwIm
 lkvywl3NIOA/iL14JRX6hCl96EubjSyw1oY6VrPRwyRbLgyOdFH7ypFN3mPTZ9YoFxPv
 Z0I0NA0N2wE5T+SmZCKYTNOKCC4ratVwu0PeWIK/7JgH1jllK6pc0avLjv2i6k53uadn
 wpbFi/6peIeVPwMr8t1lrcDxRHLm1XopgSRGsSfkmZQbrJYCDRfar8Y2yVGlGU2QqHop
 G9l1TzgFAbWQaIOTnbfl3Wqy1u5RJ5q8EOh1rXfe4G/o/yuhR6ylrxOEv4VGox6yvq35
 Rxbg==
X-Gm-Message-State: AOJu0YySNE6NQtbu9OcvNDtIr9HwkBp3O5OIY/vTSpdoLFPXPpZ3OSlC
 f7fUrtpR0K9eudvKUavgpiL3B0gnYZJ8dQ==
X-Google-Smtp-Source: AGHT+IFKy16onF2dg0yOm1hN2HENglkCYohBB9ICoTUCcRVlCb+JU5xqPvxkOGyfgoIWk563+RCPzg==
X-Received: by 2002:a05:620a:1728:b0:783:1afa:b5a5 with SMTP id
 az40-20020a05620a172800b007831afab5a5mr3232074qkb.11.1704738450330; 
 Mon, 08 Jan 2024 10:27:30 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 y17-20020a05620a25d100b007831b08c01fsm90940qko.109.2024.01.08.10.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 10:27:29 -0800 (PST)
Date: Mon, 8 Jan 2024 13:27:27 -0500
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Roger Quadros <rogerq@kernel.org>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, u-boot@lists.denx.de,
 Jon Humphreys <j-humphreys@ti.com>
Subject: Re: [PATCH 00/10] board/ti:  k3 boards: Stop using findfdt
Message-ID: <20240108182727.GN1610741@bill-the-cat>
References: <20240108173301.2692332-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d6Ai+u5uCxFSxZGZ"
Content-Disposition: inline
In-Reply-To: <20240108173301.2692332-1-nm@ti.com>
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


--d6Ai+u5uCxFSxZGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 11:32:51AM -0600, Nishanth Menon wrote:

> This is a wide cleanup to switch to setting fdtfile using env_set
> instead of scripted magic. 'fdtfile' is expected to be set by default.
> This allows the stdboot triggered efi loaders to find the correct OS
> device tree file.
>=20
> This is a refresh of
> https://lore.kernel.org/all/86le9dwz4d.fsf@udb0321960.dhcp.ti.com/ which
> was the wrong approach.
>=20
> Bootlogs: https://gist.github.com/nmenon/2f4a142c1bcaa09d544b1f2e206ea134
>=20
> NOTE: There are a couple of checkpatch WARN (around LATE_INIT) and
> CHECK (fdt_ops #ifdeffery) that on closer inspection looks fine and
> consistent with other similar usage.
>=20
> Based on next branch at: c2c598e87cfe Merge branch 'staging' of https://s=
ource.denx.de/u-boot/custodians/u-boot-tegra into next

This overall seems fine, thanks.

--=20
Tom

--d6Ai+u5uCxFSxZGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWcPo8ACgkQFHw5/5Y0
tyzuCgv/UK2Z51ZJDQET74q2F7KtN41jZIpQqEW8H7uk4QQb4jTZn56/h0MrYPFL
pDkaANQwRbCCIOxANn5GwadOFW8XHhWeAl91MwXW+1aJfbO6ok/aS2MNuU81oOyb
eo05VU2+eIWl2fVLM/ZqRPFzC7m2rbAkRHHfh20f+YUhsyWMySoyiNTF9hGek6tw
KjY42ZgrjP4nQSlfVpU2rAh+QH9htqke7jTTWia1QF9JVSLOw6bk9WFFxtQYXxO1
ezxXPSereKaJaGoS2O67Mz94zgmHaXhlVMxhpZtAe/yZPcpHrihM9wEKawCYvDdX
Qo+7Sc9fgYBWcT8K/UGT/mrz3axJhMb1qhoyJRRYxM1B1wyaGlMWNi3W8geoqUH0
I3h1/V3xKGPtThU2Pwcly1fJ+Ct7x8kcwoZ5xD5jLhOE7ck9RuJ681UWhUNIRCB5
wc/d3qaCvT7fUGn7BImxcRyZc5cteD75Y+obDoIYZs4yUi4TAXJurPF2Gvs7l8AP
EJpEwxDf
=/l8C
-----END PGP SIGNATURE-----

--d6Ai+u5uCxFSxZGZ--
