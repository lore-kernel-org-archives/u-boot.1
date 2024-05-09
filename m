Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A74EC25B74
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 22:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9075C88719;
	Fri, 10 May 2024 00:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BYjxH97K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 727F788479; Fri, 10 May 2024 00:23:46 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6234888294
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 00:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-69b44071a07so12186976d6.3
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 15:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715293423; x=1715898223; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L2kGa5Lq/WioqyqqtbdXhyphT+iSM5CDZYjNH0CZh54=;
 b=BYjxH97Kuv+bY2iNb9sKx3AHMCJiH6u0awwihh+yzauLSRYMCBAH3HX9zzSmf+dmzf
 jNxurq0FR2aJ2FwtwAfkoqBbK7EC00FB72Z+7arrfcf/TGKXgmZLUYAMLC14aB8wWnZ8
 L4KpfY5kq9lpb9x4ElByLXyjNokcoJ3bhGba0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715293423; x=1715898223;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2kGa5Lq/WioqyqqtbdXhyphT+iSM5CDZYjNH0CZh54=;
 b=N2+4Kdy6yaMugBK6JribThjdU5PRj3yRhwOdBhCIcSgFo54NdEsuDmgRlwd52F+Kw/
 7xLUyQ8wo19InPriPd72VzEyOGR8A0xXby1LmV298hwFsVxuA3zt3H3bNQm1mM5JxJUn
 hd3SPPAvOsdH8+meAW8hkvwifMbFXcMC6xmEfuxXulRhjzT3wNT+3DBwE1ODIhZPg4AC
 IBHq4PPtGj3oe2UBa+4XOIahxBQND4tkTduPoEYzzjOG4hMLrGUqJk5ysOIpJz58GFpo
 Vu17qOX1imRpwhn3l7XmRUePRPLa8OKkuXxdcmMuzzDIDad3zNdYHyJcadkoWX7Qn3JL
 8NRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMHcW4CWY73OufmBdhsut2R5A7ra67aFSR6TPzZPo7Xv4MxkhrfBKE71+HsCx99VBSfNL7U3K8EWO27Ul7t3UT7KCzqQ==
X-Gm-Message-State: AOJu0YxMDS77mVskD/b+Lzv/sSG8Xts4GJaPvcGEHYT1PQv32PvAfUUm
 2gOVEts4utGmQHAygj0GMLoX8RN567CsHRBiQ0dEoucb51IMTcM7qYkMylvGk30=
X-Google-Smtp-Source: AGHT+IGMon+2dsESlC8392I9gj9ibyk94m/1QB2CmM2YkFdM5tWi0YHmILGoaKxPsEtCGJN1W8nqcw==
X-Received: by 2002:a05:6214:33c2:b0:6a0:cad1:9ccf with SMTP id
 6a1803df08f44-6a16824bb59mr7100096d6.51.1715293423209; 
 Thu, 09 May 2024 15:23:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1d8e7dsm11098896d6.121.2024.05.09.15.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 15:23:42 -0700 (PDT)
Date: Thu, 9 May 2024 16:23:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 07/19] doc: board: ti: j721e: document OSPI layout
Message-ID: <20240509222338.GN2568172@bill-the-cat>
References: <20240509164123.1753050-1-j-humphreys@ti.com>
 <20240509164123.1753050-8-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QB8yfzgo/QQ4Rc+8"
Content-Disposition: inline
In-Reply-To: <20240509164123.1753050-8-j-humphreys@ti.com>
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


--QB8yfzgo/QQ4Rc+8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 11:41:11AM -0500, Jonathan Humphreys wrote:

> Updated OSPI flash layout diagram.
>=20
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--QB8yfzgo/QQ4Rc+8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY9TOoACgkQFHw5/5Y0
tyy/rAv6AtiqUkkeAm0h1Ipjq5SZs5neVR93cDjEpOQbj8e9VA+lLjl6Gc2doYH/
ykOTeeQQ4Rq35M/7o027trX98mpGWuA/rp4QgTHUBsUssqt+LKfTUlQIexDSmMGQ
9N/m2JVNO3++K4OUyJ07YFgOKD7epTM78AXcrL/MPYJ9LjyKf3nWbSJAmrjR9u2h
6PHC6wCVeGOWgEb6mRPtnHjcvHJtR5Y8N5kqCg+DZyl4pd75GnJbjPlIvFqtFr5z
51c/1am9AR4eP0QQAPjKmlHdrAEm98frZ4I3tWPRidJeufJVQb01wfTyOQTphATw
dImAlpR6dEPUvBM8zu3x/amgn1aa3ifGp5Gwmr65LzkKqUYkv7B1JW6ZEsWmm8VH
2mnRS618Tde/V/Q6IQV1HXWtek2dYADcN/eHcroDKJacTvr0Jaas/CQ/gZbaAtvJ
VcXVnMaunfBm/F3F1vGnSH+uG6Ck8y6YEpj21txGuvxupAT9CTHKLjuXfAIHPxLb
fY4aJjM/
=bEVX
-----END PGP SIGNATURE-----

--QB8yfzgo/QQ4Rc+8--
