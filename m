Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54D6C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 19:44:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2521187197;
	Tue, 21 Nov 2023 20:44:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OJV0ttwN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50C0C87499; Tue, 21 Nov 2023 20:44:18 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DFB487156
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 20:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-77891f362cfso10356285a.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 11:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700595854; x=1701200654; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D0SovwhaZhb8KrQrPOUeiKws/pG2KVuMcbDBw8vYAvM=;
 b=OJV0ttwNtmeZZy80SorlYOWexqW4kqYm9ol0XIutCqRv7hoKhMazleBpi6zHG//ILh
 D/z6zhXrL07UZHhUAD7glBy9sYoe8vlZaUUeT0tQeB0cDSHDisak71z8H1ubIE0Se6RX
 EePH0cfe+lHrbse8SaJlgl8IOHB51suA/ZRfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700595854; x=1701200654;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D0SovwhaZhb8KrQrPOUeiKws/pG2KVuMcbDBw8vYAvM=;
 b=iVSceRVOuP8Z2ChODCxxOr/Vt31GPnwm8iVawJHGcCfyZPwpVASmXw0Y7zpgdz1GDr
 iUf9oWKcLQs2CJwVWIet5PfXuynh1PsB0FyE0v7U6hFIOoSKj9PZXT9dArbtUwlM41gs
 9tnzeCgA6oVZQHYJg65lvJ71wuBw4aCoE2uAARR1ivvlnOD9UXs2XnQcNNHtAn0Cavk9
 aHOZHaATuIBm06o1SR3jDEYT5m4LMbd8t5m+v7TERPZN83MfMM6kZ0oB2q9GEH7e4mAc
 axsjSAIQbkAPGTobVsTY82Y6PUZLEpbKogs3+vUyR1NV8YatbV469lnZwpfMqtazATKn
 9cyw==
X-Gm-Message-State: AOJu0YzHbXBQv00CmbEOLe7gsWkobkBOSYdNIa7Y8KNAIU/fLS2UPtXc
 L44S35GBgDi8OXINavPOAEg6pQ==
X-Google-Smtp-Source: AGHT+IGnSzUeqXMLW7YS2QdvUbwguHMF/boWekLbz3R1zIvL7vJSaGmb9k+hDzBMQ05yn5PyDe8xpQ==
X-Received: by 2002:a05:620a:24c3:b0:77d:5ec1:966a with SMTP id
 m3-20020a05620a24c300b0077d5ec1966amr2737837qkn.14.1700595853887; 
 Tue, 21 Nov 2023 11:44:13 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a0cfd90000000b0064c1b27bf2dsm4203058qvr.140.2023.11.21.11.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 11:44:13 -0800 (PST)
Date: Tue, 21 Nov 2023 14:44:11 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miao Yan <yanmiaobest@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/7] acpi: Kconfig symbol CONFIG_QFW_ACPI
Message-ID: <20231121194411.GI2513409@bill-the-cat>
References: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
 <20231121152740.24783-2-heinrich.schuchardt@canonical.com>
 <20231121190000.GA2513409@bill-the-cat>
 <28fdf7b8-8e6f-47c9-81f5-9b95acccc3ab@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k4ECMN0HF7VF2vrU"
Content-Disposition: inline
In-Reply-To: <28fdf7b8-8e6f-47c9-81f5-9b95acccc3ab@canonical.com>
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


--k4ECMN0HF7VF2vrU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 08:30:34PM +0100, Heinrich Schuchardt wrote:
> On 11/21/23 20:00, Tom Rini wrote:
> > On Tue, Nov 21, 2023 at 04:27:34PM +0100, Heinrich Schuchardt wrote:
> >=20
> > > We have two implementations of write_acpi_tables(). One for writing A=
CPI
> > > tables based on ACPI_WRITER() entries another based on copying tables=
 from
> > > QEMU.
> > >=20
> > > Create a symbol CONFIG_QFW_ACPI that signifies copying ACPI tables fr=
om
> > > QEMU and use it consistently.
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > > v2:
> > > 	new patch
> > > ---
> > >   drivers/misc/Kconfig   | 7 +++++++
> > >   drivers/misc/qfw.c     | 4 ++--
> > >   lib/acpi/Makefile      | 2 +-
> > >   lib/acpi/acpi_writer.c | 4 ++--
> > >   4 files changed, 12 insertions(+), 5 deletions(-)
> >=20
> > I still feel like this is a weird direction to go in and that:
> > > diff --git a/lib/acpi/acpi_writer.c b/lib/acpi/acpi_writer.c
> > > index 946f90e8e7..9b9fdc190b 100644
> > > --- a/lib/acpi/acpi_writer.c
> > > +++ b/lib/acpi/acpi_writer.c
> > > @@ -48,7 +48,7 @@ int acpi_write_one(struct acpi_ctx *ctx, const stru=
ct acpi_writer *entry)
> > >   	return 0;
> > >   }
> > > -#ifndef CONFIG_QEMU
> > > +#ifndef CONFIG_QFW_ACPI
> > >   static int acpi_write_all(struct acpi_ctx *ctx)
> > >   {
> > >   	const struct acpi_writer *writer =3D
> > > @@ -115,7 +115,7 @@ ulong acpi_get_rsdp_addr(void)
> > >   	return map_to_sysmem(gd->acpi_ctx->rsdp);
> > >   }
> > > -#endif /* QEMU */
> > > +#endif /* QFW_ACPI */
> > >   void acpi_setup_ctx(struct acpi_ctx *ctx, ulong start)
> > >   {
> >=20
> > Will need to be tweaked later on still with some other symbol to denote
> > "ACPI tables were passed along on real hardware by $mechanism". But we
> > can cross that when we come to it.
> >=20
>=20
> QFW is only about QEMU. What I did here is separating the transfer of ACPI
> tables from QEMU from the code co-used by the sandbox. Do you think this =
is
> wrong?

This part is right, yes. But I quoted the generic code here and not the
QEMU part of the code.

> Probably when booting U-Boot via Coreboot we should be able to copy ACPI
> tables. But this will not involve QFW. Is there any code, yet, where U-Bo=
ot
> is picking up ACPI tables from Coreboot?

Is there, or should there, or could there be? I don't know the answer
there, and is what I'm driving at. And that is..

> In this case you would not set symbol CONFIG_GENERATE_ACPI_TABLES. Do we
> really need yet another symbol?

Yes, I think a number of our symbols are oddly named, and confusing and
we probably do need a new symbol or two. We have platforms which use
CONFIG_GENERATE_ACPI_TABLES to mean "allocate and populate ACPI
structures" and other platforms to mean "copy ACPI tables someone
generated for us and pass them along to the OS".

--=20
Tom

--k4ECMN0HF7VF2vrU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVdCIsACgkQFHw5/5Y0
tywmDgv+Pg5NSwJzaTw25P9OJXZeNDN5zSyJjIsD4VNS5EPKI0JEm8l0OB37v2K5
0cwdV3IZ03aTbjGOXR3oxuWIZ4NRbryxFcESYb/cVFW0yFLUCDlvuB2smxlf/Jow
XUT48OroyrlPcku2kS6vbwQdfa9wsjdf6QtoTXUP4atyRrnj9XrflyJEMsKeT006
cMTtxtZCCJ/zCrr+BGeeTdIgAE+/+7IERwZ6XR5doe4Sdh7gZzPMGF4DQyUunZJj
j/4yNRxnS7jVPiZGkFPC7Of9+V+JMaCkHM06xheBM4sObr6LRBdsRH0Mhp3uzui/
rdhCr5QDBWyVkdehrXEdLQlNUnP/xA6/Cy3azjWUa7EmLMoix4kjbKEp1m/+1NIb
urNm1AXErZQECwZze4zyGEOPAZ+yVM3XTlAX1hwKkLGfYw5d1p13cPj1uKt/v0tC
Tf7ZSGdxDQObOZ221iXz1Q8GJskLIhmfnvCGundqUVe9MVKl/qaU9R9bRaxMQdl8
C5EM8Joy
=PtJM
-----END PGP SIGNATURE-----

--k4ECMN0HF7VF2vrU--
