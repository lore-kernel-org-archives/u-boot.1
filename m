Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C26C4451B
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 16:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA4768494B;
	Fri, 17 Jul 2026 18:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PK7iJAkm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D4584979; Fri, 17 Jul 2026 18:17:03 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24798846F8
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 18:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6a37e8b3725so2882756eaf.3
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 09:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784305016; x=1784909816; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aizfAqoUTiihfHb9qmOcoUkz8YR8g4LBTV+j+rBRzvs=;
 b=PK7iJAkmxFyI61Eah+xYFaJw29HNbtdI59uTzEc7I8bDRuLDQDD8kw3ymUzd307tzk
 oSGdVmXqjJrXg4SskboqK6wePTn9qNvMeCSk1YL7HkBv68QEL5G12Pp5CbmEzPvqNEwS
 nYX+3NmebE+6woGIgWHy15CAk49/islP+PtDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784305016; x=1784909816;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aizfAqoUTiihfHb9qmOcoUkz8YR8g4LBTV+j+rBRzvs=;
 b=pAgkXkBeAmOPhUCw6629+96mdIPt6nhLaMyrh/ij1D4I+ekNo4LfLMHIwnCKSO/KjT
 xOvnQTdKKm21+C1223B9agHUCkG+Vlvbxb3z821cCxqKYvhXCos8SEqY7x90F5Y+ccdR
 dz2CtbGnZSW805Ih0WF8DYWrsDK5Z3kGwrbcmfIFCmcxQIxleicSmSwT1Tk0Yytu+j+w
 drDbdmA4iUnuI9YJ0Bmu0Wx0G80qAu312XFtiYJAxQ7S46fEECbZm2pbEWbEdJH04+np
 oouXpva9jO8iZgGG9STRyHtX+lMM8JN/g5szs0fizTk/S0xTI0DcBtuGBr7r/zbDHMXX
 OF1Q==
X-Gm-Message-State: AOJu0Yw+PIijMTe3ae9gO22lNUR6mqsqto3BKs3seDNIMY6k95Bj9hwX
 fkMDgEimkf8cfRcCk2RkIRO3cdFqI03SpBwW7268DINGnaVndMf9SRajjjfVqzeeI+c=
X-Gm-Gg: AfdE7cmhIdk2mrW699So5QVmc2mbC09LHitUI0OobrRcxaBkxvk9nDMjiA6gHlGylTC
 YO61RUvjAW8Bxu3Ei6YLUF7iuoqLtHpdC4O3Yps4h/oeQfYD0WVFC9W7hJI1JeTwa3f2t6+OU10
 qO35qagPNR3glTyn454BJksLuN5ANCNgBYhCkR8y5JYYPdbo234nC0K6NukgdwcFc3vC7X2jWpN
 qvfXh4AsjNeSdVyD7cG6uIdwL9KIk8C9QGMzhCDohbeqMuyzLIO9H1J4XvtvliAQdynwEdRXP5o
 NLgQ1DeAarAhsWzoIcqLNAvnHPwxfwdkvYhCQkqauYUUiGL8NRrLWJp9sa3h6NMEUGRTs3ILpLy
 zwZqdk6ghjGh2JNy31TV0u8OYv2y10Q+278suQ817JjVAQbMxmkT5OqzS79vKZJs2xq0wBe7X7D
 i8QemrtOTFNKWxWw/JXe1fjSnp8XwKz2e4nhy0GP8JDe4NKK2bDVATl0/+PjSmu40CVrVPfeq5l
 1UahAHy6Fbpw1OsyL0ATKsA6Jw=
X-Received: by 2002:a05:6820:4de7:b0:6a3:8ffa:2d25 with SMTP id
 006d021491bc7-6a536897756mr1464431eaf.62.1784305015868; 
 Fri, 17 Jul 2026 09:16:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a51a253d56sm1439977eaf.12.2026.07.17.09.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 09:16:54 -0700 (PDT)
Date: Fri, 17 Jul 2026 10:16:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Paresh Bhagat <p-bhagat@ti.com>
Cc: u-boot@lists.denx.de, praneeth@ti.com, vigneshr@ti.com, u-kumar1@ti.com,
 msp@baylibre.com, v-singh1@ti.com, anshuld@ti.com, afd@ti.com,
 m-chawdhry@ti.com, joao.goncalves@toradex.com, bb@ti.com,
 n-francis@ti.com, sebin.francis@ti.com
Subject: Re: [PATCH v2 0/4] Add DM firmware reserved memory support
Message-ID: <20260717161652.GS749385@bill-the-cat>
References: <20260701075021.3626094-1-p-bhagat@ti.com>
 <178424431179.1470194.2877717920905276533.b4-ty@konsulko.com>
 <d14d9e3a-2969-41da-8ed5-4c9ec465bc15@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HRcZArLhFsCbV615"
Content-Disposition: inline
In-Reply-To: <d14d9e3a-2969-41da-8ed5-4c9ec465bc15@ti.com>
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


--HRcZArLhFsCbV615
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 12:11:21PM +0530, Paresh Bhagat wrote:
> Hi Tom,
>=20
> On 17/07/26 04:55, Tom Rini wrote:
> > On Wed, 01 Jul 2026 13:20:17 +0530, Paresh Bhagat wrote:
> >=20
> > > This series adds support for DM firmware reserved memory fixup in dev=
ice
> > > tree for K3 SoCs that use separate DM firmware (K3_DM_FW enabled).
> > >=20
> > > The series includes:
> > > 1. Fix for phandle corruption in FDT reserved memory fixup
> > > 2. Enable OF_SYSTEM_SETUP for AM62D2 to allow device tree fixups
> > > 3. Add Kconfig options for DM firmware reserved memory for other K3 S=
oCs
> > > 4. Add DM reserved memory fixup implementation
> > >=20
> > > [...]
> > Applied to u-boot/main, thanks!
>=20
>=20
> If possible could we revert this patch?
> This series conflicts from one other series and needs changes in approach
> how to fixup the DM reserved memory region.
> If this is merged without the corresponding device tree changes to include
> "dm", there will be a new node with same region causing memory overlap.
> Please refer to this:
> https://lore.kernel.org/all/20260706064104.138000-1-p-bhagat@ti.com/

Sorry I had missed that, reverted. I will note that if you register with
patchwork you should be able to manage the status of your own patches at
least.

--=20
Tom

--HRcZArLhFsCbV615
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalpVcAAKCRAr4qD1Cr/k
CgaUAQC1zrQfojiDOhyymN51YUrHBsacYOPOYYa4rep1hRKlFgEArj6EEomGUxg5
C8xaaaDoHHQvQ9McC/SkX2thyW0ItwM=
=scPJ
-----END PGP SIGNATURE-----

--HRcZArLhFsCbV615--
