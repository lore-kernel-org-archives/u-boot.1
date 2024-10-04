Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB5ACF8854
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 18:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F1E188C98;
	Fri,  4 Oct 2024 20:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g1O5TjUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D65088B63; Fri,  4 Oct 2024 20:28:30 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DA8688C98
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 20:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4581ec0e00eso17067431cf.3
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 11:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728066507; x=1728671307; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aqSpKE9mXUw3koFwDW5KHlJB6RX+IySqe4eMZR1F5XE=;
 b=g1O5TjUH0diib1Ymzy2NdkyaTME8of3HiAaFTCu+AByvu15dN/rCCpwCGd6ErUovPM
 /0IYT6VRoGap193Z7OQY2zO/OrqnxhxZAD+Oy9fUx+Bg9KPChyOdcELriE/UAwOyQf0z
 8vhsS/my3KDXZ5P0mi9R2cu6cENpz+P2tD5SM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728066507; x=1728671307;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqSpKE9mXUw3koFwDW5KHlJB6RX+IySqe4eMZR1F5XE=;
 b=bNkAK/CuUxZ05Ycf+SoD0/N0W5sZ96Y9yQyJBxb+3Iw5RViI1BrKPSGKjfNRi4dPHz
 uet7hVDypY8zqxghSroOOAidF4x1Ba6Jn9+v6myHfMEuak8r16/uV+HYn1hevc0rxqY9
 8VzpLalspgH9P5WebX+5kfMoT6qRUFPSlOJZ4/vDEXNHvYSupAIRl3Oz+e3S+kYWJjfY
 k4ty9BKtiXSdrfa1cnWiGHkz6o4RkDtzW2Wb2Ks45YL/64hFrINMgL/QQxhTALeRSjpo
 IaMHaL8+N0h3042I0RosSYAkUYOxB357M251/tBojqZ70yEgFpWmAnotCQBh9F3dxrLx
 wyhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLbEfto+STZTXKml+ZivhHUDuj9/Go94zrPhfOPtHDYmin1JKSn0t78lmz7cUchE1GIAOFSSc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5OFmieZO7KxBubmmWqviX2m4p6/dTCmsJoBIGH8EIVZLtiaV3
 srL9OHA258oMuUKr6KY1IBt782NGFpjoahW3SEEkJpZmhIwNdIKZyZk/3S1JZtI=
X-Google-Smtp-Source: AGHT+IFK3/gtqbgmHkawWGv8jCmec2m/wTrmHU+0732+fqgKcE1ZpRhfU1uIGaTRe4elfhRNbHLDeg==
X-Received: by 2002:a05:622a:cf:b0:458:294c:39e7 with SMTP id
 d75a77b69052e-45d9bacdd05mr48481101cf.38.1728066506832; 
 Fri, 04 Oct 2024 11:28:26 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45da74fac93sm1446611cf.36.2024.10.04.11.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 11:28:25 -0700 (PDT)
Date: Fri, 4 Oct 2024 12:28:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v11 03/29] linker_lists: set LINKER_LIST_ALIGN to 8 for
 CPU_MIPS64
Message-ID: <20241004182822.GH4737@bill-the-cat>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <1699de5384a71c0d0ad535cdc48cc2b95087719d.1727968902.git.jerome.forissier@linaro.org>
 <5c4686da-f39f-4a48-ba57-4d2f7fb3e66a@gmx.de>
 <c9f50143-4e49-43df-913e-43bf5f5484cc@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vBXsRx8voPGNau1m"
Content-Disposition: inline
In-Reply-To: <c9f50143-4e49-43df-913e-43bf5f5484cc@linaro.org>
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


--vBXsRx8voPGNau1m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2024 at 02:55:58PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 10/4/24 14:04, Heinrich Schuchardt wrote:
> > On 03.10.24 17:22, Jerome Forissier wrote:
> >> Note: Patch posted separately [0].
> >>
> >> [0] https://patchwork.ozlabs.org/project/uboot/patch/20241003142030.16=
10222-1-jerome.forissier@linaro.org/
> >>
> >> CPU_MIPS64 needs 8-byte alignment on the linker lists, otherwise an
> >> exception may occur. Fixes an issue found on malta64 with QEMU:
> >>
> >> =A0 Breakpoint 1, lists_driver_lookup_name (name=3D0xffffffffbe043578 =
"root_driver") at /home/uboot/u-boot/drivers/core/lists.c:31
> >> =A0 31=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
if (!strcmp(name, entry->name))
> >> =A0 [...]
> >> =A0 ld=A0=A0=A0=A0=A0 a1,0(s0)
> >>
> >> =A0 (gdb) p/x &entry->name
> >> =A0 0xffffffffbe04b0d4
> >> =A0 (gdb) p/x $s0
> >> =A0 0xffffffffbe04b0d4
> >>
> >> =A0 $ grep __u_boot_list /tmp/malta64/u-boot.objdump
> >> =A0 4 __u_boot_list 000018e0=A0 ffffffffbe04a4d4=A0 ffffffffbe04a4d4=
=A0 0004a584=A0 2**2
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> ---
> >> =A0 arch/Kconfig | 2 +-
> >> =A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/Kconfig b/arch/Kconfig
> >> index 8f1f4667012..8f4df849801 100644
> >> --- a/arch/Kconfig
> >> +++ b/arch/Kconfig
> >> @@ -45,7 +45,7 @@ config SYS_CACHELINE_SIZE
> >> =A0 config LINKER_LIST_ALIGN
> >> =A0=A0=A0=A0=A0 int
> >> =A0=A0=A0=A0=A0 default 32 if SANDBOX
> >> -=A0=A0=A0 default 8 if ARM64 || X86
> >> +=A0=A0=A0 default 8 if ARM64 || X86 || CPU_MIPS64
> >=20
> > Shouldn't we set 8 byte alignment on all 64bit architectures including
> > riscv64?
> >=20
> > =A0=A0=A0 default 8 if 64BIT
>=20
> Makes sense.
>=20
> >=20
> > @Simon
> > I would not know why 32bit X86 should need 8 byte alignment.
> > I am a bit astonished that you chose 32 byte alignment for the Sandbox.
> > Is there any justification to use more than 4 on the 32bit Sandbox and
> > more than 8 on the 64bit Sandbox? If yes, we should document it via a
> > comment.
>=20
> I tried running what CI does manually (.azure_pipelines.yml) with
> "default 32 if SANDBOX" removed, and I got SIGSEGV with
> TEST_PY_BD=3Dsandbox. OTOH, TEST_PY_BD=3Dsandbox64 worked fine but it mig=
ht
> have been a fluke.

I think we can leave sandbox as a future cleanup, and perhaps file an
issue at https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/ so
it doesn't get lost.

--=20
Tom

--vBXsRx8voPGNau1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcAM8YACgkQFHw5/5Y0
tywhxQv+PsctjJDly/mrNLx33Bkvowm9Hx7/2TQ9guRG2bg0BXRHtzoQrmcJlayS
8sBhSJEoW5queE0fmexwA2g752cq83Z7YGaDsYuKz4Psgy+tq44korcGwyqS3lMo
Inu90HcqVGnc8r8WpHTvS1kUFWNHu/+8TohiSs/iEK0LXTBORLu2cIyzIaz49NsG
NOqdBfFmzlM1YmPC05ZGOZPIU1d+A4KV9ig5GWIyW0Oo2Av1Vl9Xp7QMoTzcmcgn
KvcoWNEiYivvbpPRrJMdmBe0hM+fvUwU4WvW3j1y380rYhy1cgLodbs0f6YvHSFv
MoWUpYctDcQ6znn/NUnUpcXRIyigsRH3/7xbHHl08bmeh+upq2su5Jd763IuobFu
beSLk/tB7JqXvYSeFkza19cOBCAcoEqqvZKbI8WKTnttHMMZa9whou1+XciwyUeB
GFUkSk1T+uJH5YHr0nG33qIWlXgI1kwX/qTytQTHX5jABiLZvWbtmNien3S6QwrI
2N2sa+WI
=iyI+
-----END PGP SIGNATURE-----

--vBXsRx8voPGNau1m--
