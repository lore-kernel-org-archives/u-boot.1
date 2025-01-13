Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD3CE77188
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 01:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E38D9805C5;
	Mon, 13 Jan 2025 02:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZGuc2M3S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64001805DA; Mon, 13 Jan 2025 02:51:17 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3201780079
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 02:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6d900c27af7so36493686d6.2
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 17:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736733074; x=1737337874; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UAq9QmMCEb/3cYu43spMeU4mw/F14/gC9mQ4/GPDi/s=;
 b=ZGuc2M3SOvIwZRgeS2PdHBmAZWKpZH7Y7vo2JT8Gos2fDcIH0sRUxQv4bodkoe7+g0
 oITBaY3CE+TwgPVsjG+nQ2hIXCyTmzomhf9FlP8xNPVAUmCHSFvfxVhBQL1fkedW20zn
 pydYvTqNCkWhFziH6wmDl3bBBDN0LtY+p2Yx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736733074; x=1737337874;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UAq9QmMCEb/3cYu43spMeU4mw/F14/gC9mQ4/GPDi/s=;
 b=jVW5yEZ9Xqh0W1UFznrdCooX2X2f7fKuY/Dp7WLrxr66chAXJJWvN8NyWTSlrDjrJJ
 0PdCLbexLBnx3TUXts8sQrCAuBD3eqpMPVj/OE5C9u60QTARZ7UvAE8ltCC/We1hRrZE
 29bgoc4horrqK24kgQGSjLPJ7S3LhksH9Lrj8A8yZhA0fvfedJWUJlg5dTJpKSZhKUSb
 YKfzDPr2XxdgnhL73LfH+OfET5FBFYK6QJlv2ZLdUpx7oSTen1k1iAOMNLlLcSudapFe
 9MKEhRMl5ip63BmPbB/9/kWYB72lC3e7ps9rBDqp9qZ0cvE+xQXnELCoEdDcfOfirCtr
 ng2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm9qED1YOGzpPwenrHtulPodJPFo32rmFHHOEIGVecsvG0I/oufkdg1IuNfw9TJffrmt70lg0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4S5mXUSTrLBbNDt+PBKkUHdWM1bOHLjFJGW8bzTB1U2b2K/nP
 JY1TJRhZVXjNqY5Rjeg1091EQ2zRk7a9vGwHco9eM8z9Qmf1eFlu8dWgTKHG23Y=
X-Gm-Gg: ASbGnct5ol/jzmYd5ia+5ohB06KgUmOCPjpE7obfur66yo1ubzCjiL8488MVwaRKg20
 zvbvl/CgZbOfbXILooyywAjBiV18hPFyg4t2OZGS0jc1VgLkE/9VdIgx48Nu8xZ+V2cLWGAoQ2m
 fUaSfkRtyP2PS6d6pa9/x/PuJAwXjmzrq4Xs57ttwUQlrQy6Pgi+1d8c7XdXn8cdd4VvICsjkuk
 6yDCA+dP+fN+JG1fHRLYkgmJsdLsKQLxw9qtoIDw7mimw8l5m47SAY=
X-Google-Smtp-Source: AGHT+IGJreF6ZXfkDFF8W+JXXfdK55AjhkK3IjmkUMfxSkW7u33kMqjk3NI9xsQIHqb+mycqdycTCg==
X-Received: by 2002:a05:6214:3bc8:b0:6d8:9bbe:392d with SMTP id
 6a1803df08f44-6df9b1cfdc8mr300577176d6.6.1736733073984; 
 Sun, 12 Jan 2025 17:51:13 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfadec2acbsm35710556d6.122.2025.01.12.17.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jan 2025 17:51:13 -0800 (PST)
Date: Sun, 12 Jan 2025 19:51:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 5/6] cmd: bootmenu: add parameter -e for UEFI boot
 options
Message-ID: <20250113015108.GT3476@bill-the-cat>
References: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
 <20241127070631.16412-6-heinrich.schuchardt@canonical.com>
 <20250110224554.GA2278614@bill-the-cat>
 <CAM=mAOmee=By9ErZrvk0hVbZyLH_viguu_wMfOsV3LzTwddArw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SAm9EdvwSso+oTtr"
Content-Disposition: inline
In-Reply-To: <CAM=mAOmee=By9ErZrvk0hVbZyLH_viguu_wMfOsV3LzTwddArw@mail.gmail.com>
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


--SAm9EdvwSso+oTtr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 08:08:13PM +0100, Heinrich Schuchardt wrote:
> Tom Rini <trini@konsulko.com> schrieb am Fr., 10. Jan. 2025, 23:46:
>=20
> > On Wed, Nov 27, 2024 at 08:06:30AM +0100, Heinrich Schuchardt wrote:
> >
> > > The bootmenu command can display
> > >
> > > * menu entries defined by environment variables
> > > * menu entries defined by UEFI boot options
> > >
> > > Not in all cases showing the UEFI boot options is desired.
> > > Provide a new parameter '-e' to select the display of UEFI boot optio=
ns.
> > >
> > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >
> > Very strangely, this leads to the EFI selftest "Executing 'random number
> > generator'" test failing on Pi 4, where was was passing previously (and
> > Pi 4 has an RNG, unlike Pi 3), and this is
>=20
> Do you have a link to the log?

Here's the failing part:
Setting up 'random number generator'
ESC[0;37;40mESC[1;32;40mSetting up 'random number generator' succeeded
ESC[0;37;40mESC[1;34;40m
Executing 'random number generator'
ESC[0;37;40mESC[1;31;40mlib/efi_selftest/efi_selftest_rng.c(52):
ERROR: ESC[0;37;40mESC[1;31;40mRandom number generator protocol not
available
ESC[0;37;40mESC[1;31;40mlib/efi_selftest/efi_selftest.c(114):
ERROR: ESC[0;37;40mESC[1;31;40mExecuting 'random number generator'
failed
ESC[0;37;40mESC[1;34;40m

--=20
Tom

--SAm9EdvwSso+oTtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeEcYUACgkQFHw5/5Y0
tyw9rwwAuGDoukBdq5q6ZkuCDpTQutXGSLBoYpm0ytoB4+1U3S1VvLtxH2Ir00uN
IsgKXgx/tYx2izxpi7WqhIZClg/9QGBytJsNQhN9PqgrKzhXCTfvLOmwoa5vLQU2
0OGJpYfhNuKqaIRbQKL36FwsaB8TnfBGu8zVLpgDSBRate4jNbP0nDDZ3Nt9XakJ
WqKwgFL5hhIDgj9jIzn2fDFEh4eWABCs9IieCcsRKlRJM58Anxmx4UxlndYXpY3Y
xCgVuKPsSYDiNOte0OAaKOA/r/4WjnTNv2UKn/rAQ1piELASLoTpxCdp4CuSUPYj
9NPeHgxn/P2FmyGLUHRAoQCF4v1sWktlK++cDB3DVuBQTui3gur5oMgb+Q9FmDFG
0kIWhb+2tclLf0RCrSXetGrruPz/HtjgChP0QzgSFaMDuUqCNgIFwcgdnIZ2ExtE
myHO3XVjqQxdDOV23+49YeyMcRgjvtexIaBP64T7gv7+DtQHETH2Xisj2DfGtr/r
NIx+nCKT
=M4k9
-----END PGP SIGNATURE-----

--SAm9EdvwSso+oTtr--
