Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2224AC197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:43:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD815874B9;
	Fri, 17 Nov 2023 14:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RDIN7FaR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56AAC86FF7; Fri, 17 Nov 2023 14:41:40 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8542E874BB
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:41:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7788fb06997so120810185a.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228489; x=1700833289; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lIhSKvnlj6ry70RhO0TyvV/loxcgdS9QGPnYQrTbjrc=;
 b=RDIN7FaR2GaQWglmBarLNa3YePu6kKWDRVKrKnh+ePUBYI00NroRNx0q7HtbL0KnPo
 5vtTcbnSW0gi4fcSUFvu6NNWSVVoQn1Fz/y2hLa14p0/Pe41YeYfXmVSGSGJRIEqr4t+
 f4MWSgR3+pe8dvCrbiK87lJRLOLNbYrEiYiZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228489; x=1700833289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lIhSKvnlj6ry70RhO0TyvV/loxcgdS9QGPnYQrTbjrc=;
 b=YhX28otCTGoqrA2VqeXsmRH92512qkRHKijGc6vSJ3Zl+KbdGuT4a8MQMSKGJxFfHK
 iy1oHN4Y6IMaiSRaXCSAkMW80cuTvW7KtRTcaD7D+3aw5XQJlCgLIjMLy7/BjrhbWCRD
 tKyKtWO0FNmiU8hXIyyMjSHRJzji68XMXgaZHZ+FWXWoZpfnfDORH+tiJe557eTVjoxr
 bULgkG58Ly8BszCVqq9sW4agEuT9VuOU4LveFQ6qHH2+u1GzVNL1wtb3iC0WfJxUmB2c
 TpDnk/klVn02QsuCPqM4gd7DIVJeXgH3jbmaCr875Sw+0BJj5jUi71afwLoryKsVFpxP
 CWiA==
X-Gm-Message-State: AOJu0YxLv/B0/F+tNnVlR87CBxdz0RM+AntPGMRut7nQh9Zqwk1PI8vi
 tJyYDRMlXwxpfo5wTOkTCp2p6YOpWBo6dRiUD6Gm/w==
X-Google-Smtp-Source: AGHT+IElTCZ3sAQAnAHAXN0q3Thfu2693Ghs2uzuJMgM++D4dSr1b/0Cm1ZnDuKwvx6BLK2/2jlicw==
X-Received: by 2002:a05:620a:40d1:b0:774:131c:854d with SMTP id
 g17-20020a05620a40d100b00774131c854dmr13181661qko.72.1700228489386; 
 Fri, 17 Nov 2023 05:41:29 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 br15-20020a05620a460f00b0076e672f535asm603153qkb.57.2023.11.17.05.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:41:29 -0800 (PST)
Date: Fri, 17 Nov 2023 08:41:27 -0500
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] test: eth: Don't crash if env_get returns NULL
Message-ID: <20231117134127.GO170968@bill-the-cat>
References: <20231028225727.1046361-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uwllXeV5T/9xpMi7"
Content-Disposition: inline
In-Reply-To: <20231028225727.1046361-1-seanga2@gmail.com>
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


--uwllXeV5T/9xpMi7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2023 at 06:57:27PM -0400, Sean Anderson wrote:

> env_get can return NULL if it fails to find the variable. Check its result
> before using it.
>=20
> Fixes: 6d9764c2a87 ("dm: test: Add a new test case against dm eth codes f=
or NULL pointer access")
> Fixes: df33fd28897 ("test: eth: Add test for ethernet addresses")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--uwllXeV5T/9xpMi7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbYcACgkQFHw5/5Y0
tyw8mAv9EFqEx9CRsjj2tPRCOaUhxu93U1lRj+23Bp9JcZNdpPeD6zApVGfzSgA2
tVcow4jVZ6Gc74E5hfShM1yBgzsuZKP46WGOxtzP/tWcmrVRj43CPEPC1vO8wNrV
umKP0l/fXW7HJZZ61nBHSWp2PMHUALsnrKc+QDIJosEwxBXvB1EQPQNxUVQ3QwNP
/RpXY6QJ+rebuxGNRs5Qj4GQKqf9UjnpNAp/pmHoMDDcRBIRl1fN/UP/dohCxPAy
iDIzNC7Ji5Bx39OdD7UaBP9hmqalWGEUcmqMlg2ogBauZQ5V+9e7izdqguXk5d5j
4wbL9mFvBsqjAVJBZtVMt+gwN17TEEin2iaqoLLyFXsqtJ5BSqHco4i1KyMU+Qhp
2zFZsCAr3aoqcgq5INm5FhuELYeX4oussBAw/UOZtxrUWzk7A3/r78okAwXBGLvG
3ZbJFAXdkHHzZYe4QVDzJYWUhX8un2rjkSXDSjb9nXOhxnI8H8fPeVJsWNJ9+g23
VtaaUhMO
=+EEW
-----END PGP SIGNATURE-----

--uwllXeV5T/9xpMi7--
