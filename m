Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71462C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 13:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95FE886EA3;
	Wed, 29 Nov 2023 14:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UXiQhjJz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9173886F38; Wed, 29 Nov 2023 14:43:25 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F5CE86E88
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 14:43:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5cc5988f85eso69213487b3.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 05:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701265402; x=1701870202; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fcbHlv120eO2UNk+Qs+OQ9ztFm2Sdvck946zcwLR3ms=;
 b=UXiQhjJzeU7wZvOqUeKJKRDyPtVtOEMEZumIWbM74J1FN6dRuTA5At6regKAFXdEAg
 2oursoLOkqzxfFN0VYKWmgByZw6kQ8IH/tptv2amTgMfhnRuvqTJpLz2Z+36nFkFZESz
 SOd9oqifNDMbpNhnbOgnI8mTsLe3ewWHi4EaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701265402; x=1701870202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fcbHlv120eO2UNk+Qs+OQ9ztFm2Sdvck946zcwLR3ms=;
 b=RtnBqz1K4ylTM2cmJaSA4a+PxQIPL9Gtm+GhrIIAcWvoqBni1/eBzZx/m2GVlks29r
 6uovEBUGfn847LlIeVp4EvJ8YrHXE9bsNYNo1Rzb380KhWDe3/W7FJufps8xqDbdMxEZ
 ASWKGsHQLG6Jutm/sL9qw8o7TdSBmYpPyCy41A43dr7m1BXTe3hG13g7sR0swK6Ovjgz
 HddZZtCIaYyI+Y9NeO56DU5jv77pb3AtH6FD2l4KyoRXf0h2Mpfb8usVk71ztuCUnMCX
 yGZ0lFEsAjIImFz58GYryOkpXnT5CvBlBi8kBdb1jxDSASQR2j7cNh8i5ZUBmQtGQPUE
 r9YA==
X-Gm-Message-State: AOJu0Yz6mP2ZhF3RamYUe46iVH3cCICbPF7rkZqb6UH8J4hfpQJZo40P
 AmCgnP9bw/Vz25GcXw/edPRljQ==
X-Google-Smtp-Source: AGHT+IHL4SvS5fO7WBOr3B0b7f3fOpHlceaet3TDHMVcyvOi4v3LNUt/xyXc42hfqK430P/I/VuGjw==
X-Received: by 2002:a81:92d7:0:b0:5ca:e49:c98b with SMTP id
 j206-20020a8192d7000000b005ca0e49c98bmr20295681ywg.8.1701265401796; 
 Wed, 29 Nov 2023 05:43:21 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-9fa4-b7c8-6a9a-173e.res6.spectrum.com.
 [2603:6081:7b00:6400:9fa4:b7c8:6a9a:173e])
 by smtp.gmail.com with ESMTPSA id
 n21-20020a81af15000000b005cd091e885dsm3657169ywh.30.2023.11.29.05.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 05:43:21 -0800 (PST)
Date: Wed, 29 Nov 2023 08:43:19 -0500
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, u-boot@lists.denx.de,
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v5 0/8] ATF and OP-TEE Firewalling for K3 devices.
Message-ID: <20231129134319.GA841579@bill-the-cat>
References: <20231113-binman-firewalling-v5-0-b3ba6f839606@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4XHvsZmrIiqNJDm5"
Content-Disposition: inline
In-Reply-To: <20231113-binman-firewalling-v5-0-b3ba6f839606@ti.com>
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


--4XHvsZmrIiqNJDm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 03:48:59PM +0530, Manorit Chawdhry wrote:

> K3 devices have firewalls that are used to prevent illegal accesses to
> memory regions that are deemed secure. The series prevents the illegal
> accesses to ATF and OP-TEE regions that are present in different K3
> devices.=20
>=20
> AM62X, AM62AX and AM64X are currently in hold due to some firewall
> configurations that our System Controller (TIFS) needs to handle.=20
> The devices that are not configured with the firewalling nodes will not
> be affected and can continue to work fine until the firewall nodes are
> added so will be a non-blocking merge.=20
>=20
> Test Logs: https://gist.github.com/manorit2001/c929e6ccab03f55b3828896fbd=
04184b
> CICD Run: https://github.com/u-boot/u-boot/pull/442
>=20
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Can you please rebase this on top of current -next? Thanks.

--=20
Tom

--4XHvsZmrIiqNJDm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVnP/MACgkQFHw5/5Y0
tyxO0wv9G+1vFdh6R+wDgSDdwypDU0VUtlIOCUNu6XfplW5BggMUaPJfWCCuzyp4
eBdG3EtyAAyV+H+mAjisSHS10GYHuSDENcxOXnlwhfYrIWnoF6xzfEsYQ54P7cdd
y0eLr9RSS++1YIi5YIXnNs96oFxcBsR9uwHpaf6cB4lNsR26bfDuh99d5pS+PCEJ
a2sADn8cMeNW3BiqasVxXxUzQjbJV2CSM9k+Fx1NeNs6IQ/q4GfgyfLzl+wtm//9
2TxWmZMev2X0vg+7BERHcKe65Tl8ySb1GRgOpT8uDg5lbCw/yqQlfBNnf1Yuc0Io
Im2T1ywxQTY3o+jMimBiMXLmlOpw49u2TAqZZzGkAQjRCThBggUyiFLKmZ3U6EU4
F0fr2v4PsIrKxowxgELBkaO6S1LtLWxZIRpbaVqlAUpjdBm0l7Y91eQPO8wqmUv/
Ja9xclvZ+XSxGVnTv8NUkzRGU6hTjSoOCFsw33rZkjWuktgwweuCYTYePIrtCwHP
kCqZwBUN
=DLvT
-----END PGP SIGNATURE-----

--4XHvsZmrIiqNJDm5--
