Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC407D1D88D
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 16:35:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4935988936;
	Tue, 15 Oct 2024 18:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sd1CmfJY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4259688916; Tue, 15 Oct 2024 18:35:02 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A16A88A24
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 18:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-46063b6b82eso20279201cf.3
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 09:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729010098; x=1729614898; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m9IfZCiMXfJteCGCYJN6udhoSL0BqUIIkjBsxXlBaOg=;
 b=sd1CmfJYBuxmH9K/fF9Y0iBhHs+6mRiASWJLHpks9wptItizrkZsOiW5g07zcKArcj
 XStJmJcPO5hcxdBAXykVHVtP6tEnT3Ruc0+dzVyzl9yksIXfgDU+xp72N/+l4oJdLULR
 gWYBLYwqknwgimv24FXYCWSwpfDN4+v3uqIps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729010098; x=1729614898;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m9IfZCiMXfJteCGCYJN6udhoSL0BqUIIkjBsxXlBaOg=;
 b=glfmEu4FKQL5C0IrRjdrSPcYTR1k6LcsL3OCoq3lZJksLAOTRGhTcNPbaCkLx5BLXs
 aWp3rhiRLtmtF1P/PsOwi49lEqr/8K52pIcHflqpYPXVcOA7jjRjaMLSRmIpJeeciQKv
 Nqwe/nRQBX0mvHZl1J429BjDJQSgev5YWsuDbqXaNkX9LxvetHAouWoLTAu8RfvN/7B+
 H7kqyiXLR4jpD47jCE8auUDt6r17yNf2NsxPwttpP6FHa8z8X2VPh4kvsFAw+28YkA4h
 u7SYRaGcxgGfz8ZelhmlFJXTGdVBSmCNg/5ZDw2MVl5ue/tEWZb0VknI0m37ip8f7Sj5
 7+IQ==
X-Gm-Message-State: AOJu0YwBv4p1n+9XHcWWnas0etUgA5/R/VOfSS4P4Duc/TWqBAtujyMb
 0r1lpTKPI3drURa2y0XdHVkjibog2zb9i7qhGk5kggyYaoKlwPJeL4Gdyls3tcg=
X-Google-Smtp-Source: AGHT+IGS6TtVe7Yr6i32KbXLgG+BEyrD7yELCPKfjyPQvQHjPJWyzDIPHOrDP1tyxbA17MwDuUT/sg==
X-Received: by 2002:a05:622a:15d4:b0:45f:8ee:185c with SMTP id
 d75a77b69052e-46058239a36mr208954251cf.0.1729010098294; 
 Tue, 15 Oct 2024 09:34:58 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4607b0e1485sm8206441cf.30.2024.10.15.09.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 09:34:57 -0700 (PDT)
Date: Tue, 15 Oct 2024 10:34:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v3 13/20] docker: Update coreboot
Message-ID: <20241015163454.GP53053@bill-the-cat>
References: <20241014223212.2212442-1-sjg@chromium.org>
 <20241014223212.2212442-14-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zM2ouCNF4VSp2Le5"
Content-Disposition: inline
In-Reply-To: <20241014223212.2212442-14-sjg@chromium.org>
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


--zM2ouCNF4VSp2Le5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 04:32:05PM -0600, Simon Glass wrote:

> Update to a newer version which supports settings in CMOS RAM and
> linear framebuffer.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--zM2ouCNF4VSp2Le5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcOmaYACgkQFHw5/5Y0
tywUbAwAmSRsllTJkkv28PoLlw2h/6VvsbiRn8Goxe4e8akN4RquEh+2BC3MY6nD
2j4JAtdM+Smo/40k/bodIDRkLMUQ5xQRavYYXIY+IA++hPXPxPCTeFf14Mkjo6tF
DStBdoEIthMY/Ew61642+FwtnYwk4UG1AlExRWxAlrrtsOd32wui/S4BR9GjiX5j
RvMn5R0dLnpEgE4Wmzyy4kHkkXkMNGFVxWNoKnJdG6SKCWE/d5xrAxF0ZHbY196g
KmhfFko6nzxJbpnp+gqpma2NChEOKVfPeThrR2Sx7HI1bH9pvXdyfjEbo8SavAVH
qM/q+zUEGj5tXuzSBhxVNXrehfZ3FYilLihqmPjo6YPV+r0DjlpqjJjJ1qPL6nec
y/BON/tCJNhtqiSovx+QVCuaQO0I8oPRcjMttCs7Lq3Oxphebmyn/mE6VQlxBNQd
F21d7qg9JSra361OQP1UY+XCy/NgZPix42Y8RvV2ap58b2FCTVBC1MyxT8gZV+QR
iSrvM7Ye
=qq+h
-----END PGP SIGNATURE-----

--zM2ouCNF4VSp2Le5--
