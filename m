Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F55BC83F26
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 15:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F724831D3;
	Mon, 21 Jul 2025 17:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W3JvUfJJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B86E3831D6; Mon, 21 Jul 2025 17:33:55 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80724831B5
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 17:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-41cbc8da42aso2518537b6e.2
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 08:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753112032; x=1753716832; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zHS5kuN8QGPCqO4Ds0DhYdx1OATWcONLuY2uFi23tuE=;
 b=W3JvUfJJnuk6M8qeQ/WGv67wwAkYCxyHfr2KgYFPq6bSnsaIt0T+PpIHb0TrA4HNcz
 1SKV07opXGwrwVIS9RapL55loVJrMbnnc6YvOcGuY4tfiOHa643YrFAsB3TKx9DEqqeN
 uP2rxMRytAN3lLP+md2Tsbe+dnf04PqYGZciY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753112032; x=1753716832;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHS5kuN8QGPCqO4Ds0DhYdx1OATWcONLuY2uFi23tuE=;
 b=PckHJ92TiuqDymBzq3HFWe1bsi6tlm1JVvm4hDD+wYihGabxDJs05NYgzuLwxB6Mpe
 1pbAp7zJYE7tGRk59KBHJySo0GNc2LkXi7mAoVYLio73Xg/wmYvFnNnvvmO2JT5udZNt
 8Ak2MieD9xMoqk58DMrLJkrUMoitmVzhZkfEUEcA1/7nbT2eGL6VcGPbe9sicy8voZuJ
 5fUnsFEPvM3fuPNdMxrke826DPzIUpiW6por/gCrDMH1yJ46MM1aRRHXnXm+lu3zQVbR
 TeI27MspxBpdd9SDQAVIZiPn1KC+0mihAl6g6JbG7BXtvYmJE+F25m9LP3a/iUYd/x/v
 gSzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsLOwGeDVbZ5tkh6KHXGhTquhn8j2Eg9DQAAATNmeD8YLxI62hgeTCVdUYykj0NF8RyLQS0uk=@lists.denx.de
X-Gm-Message-State: AOJu0YyNEHu6GwDdXdVUoZURzZ+TEQbplqs3TfUegO2jbKlWTIx5vIbs
 vEl5ipFDyCQqdrJSD88NazBn2meoInZrJ2A5/kyht5uXzCVLFk/vFOZnz3atiel5Y5E=
X-Gm-Gg: ASbGncvel0WkksQ+XjRhf11H2sFhxrWNJ46h66D/ofc2+h6+YL5Eq8kth+/a6wt+lye
 xaFwd+ncP7aqn2NBO6snp1lKJxyRFQ7xn40OQq7P7yMF05NTdez+oQh2vsCQohJVO4mNA72pWqZ
 l3cyjPiab3A3a5WcF3KMV5+YnAoAsaTl/1z/ZbdN38EeaH37SM3v4jwOI0QHJRYlDqR3lSXzOH+
 3GOwiQxMaFXjbMlwHe2YRcNhAzrOJUJ3i47V3HO/g/sS+gyeCs0dQSmkYxfi82MKpdDtNSppXT2
 MlpHS4cg3XGF6hfv+3DKITCAYiMijqv8e1XPUjvKZmkqMt/Rc2wsCEp1aOE7DcYggEochEqhlew
 lSUDFiNS1Cij0589JaLrmLy7hDAt3UH9DbCS6a0ThxtEZZsIGhA2kCmEW
X-Google-Smtp-Source: AGHT+IELkWhOOgVMEuRCi3SVhtf0wymRu+yaq79El08d7wcOOULD6xo+4Z8npa/5xpPJrIv4FtwSKQ==
X-Received: by 2002:a05:6808:2120:b0:40c:f402:96f with SMTP id
 5614622812f47-41d037e382cmr12417064b6e.14.1753112032033; 
 Mon, 21 Jul 2025 08:33:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-41fd1ca5832sm2312682b6e.17.2025.07.21.08.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 08:33:50 -0700 (PDT)
Date: Mon, 21 Jul 2025 09:33:48 -0600
From: Tom Rini <trini@konsulko.com>
To: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 marek.vasut+renesas@mailbox.org, tien.fong.chee@altera.com,
 sjg@chromium.org, xypron.glpk@gmx.de, seanga2@gmail.com,
 lucien.jheng@airoha.com, frank-w@public-files.de,
 daniel@makrotopia.org, albert-al.lee@airoha.com
Subject: Re: [U-Boot, v1, 1/1] misc: fs_loader: Add
 request_firmware_into_buf_via_env API for environment-based firmware loading
Message-ID: <20250721153348.GD193579@bill-the-cat>
References: <20250720150404.25844-1-lucienzx159@gmail.com>
 <f97fbf07-39c1-406a-9349-0ec84bf0300b@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jKA9cyG3NP3srMcY"
Content-Disposition: inline
In-Reply-To: <f97fbf07-39c1-406a-9349-0ec84bf0300b@mailbox.org>
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


--jKA9cyG3NP3srMcY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 10:47:50PM +0200, Marek Vasut wrote:
> On 7/20/25 5:04 PM, Lucien.Jheng wrote:
> > This commit adds request_firmware_into_buf_via_env() to the fs_loader d=
river,
> > enabling firmware loading into a buffer
> > using environment variables for path and size.
> > It supports multiple entries via indexed variable names
> > (e.g., "fw_dir0", "fw_size0").
> > This provides flexible, scriptable firmware loading without hardcoded d=
etails.
> >=20
> > Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
> > ---
> > Change log:
> > - Re-sending as previous version and add more maintainers to review.
> >=20
> >   drivers/misc/fs_loader.c | 59 ++++++++++++++++++++++++++++++++++++++++
> >   include/fs_loader.h      | 18 ++++++++++++
> >   2 files changed, 77 insertions(+)
> >=20
> > diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
> > index 66803f4b997..a4f4448f5cc 100644
> > --- a/drivers/misc/fs_loader.c
> > +++ b/drivers/misc/fs_loader.c
> > @@ -228,6 +228,65 @@ int request_firmware_into_buf(struct udevice *dev,
> >   	return ret;
> >   }
> >=20
> > +/**
> > + * request_firmware_into_buf_via_env - Load firmware using environment=
 variables.
> > + * @dev: An instance of a driver.
> > + * @buf: Address of buffer to load firmware into.
> > + * @offset: Offset of a file for start reading into buffer.
> > + * @fw_index: Index of the firmware entry to load.
> > + *
> > + * This function loads firmware into the provided buffer using environ=
ment
> > + * variables to determine the firmware file path, address, and size. I=
t supports
> > + * multiple firmware entries by using indexed environment variable nam=
es such as
> > + * "fw_dir0", "fw_size0", etc.
>=20
> To make this really scriptable, this code has to run a script which does =
the
> firmware loading and then points the U-Boot code to the buffer with data =
in
> it.
>=20
> Instead of "fw_index", use "char *script_name" or some such. Then, run the
> script. The script should set up two environment variables, call them e.g.
> "fw_addr" and "fw_size" or some such . Then, this code should read the two
> environment variables, validate them, and possibly copy their content into
> $buf . Finally, the code should always unset fw_addr and fw_size .
>=20
> Note that request_firmware_into_buf_via_env() should also have 'size'
> parameter which describes the maximum size of loaded firmware, so the code
> could verify whether the copy of firmware into $buf would write past the
> buffer and prevent that.

And for v4, can we please put this patch and the patch using it in the
same series? I see there's some feedback right now from Frank on the
other patch about how maybe this part should be implemented.

--=20
Tom

--jKA9cyG3NP3srMcY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh+XdgACgkQFHw5/5Y0
tyzBuwv9Hzfr5bNgHf4+ICu5++DGI9EALcIVSzTHIIMmXIgIQ8ewB81OL/luasDH
uW3hESNyd/cwWjzCZZeC6UB2fyx83l77lh/zjRGsmzLYQp2wrJ4J7Ly5tfZPGaCR
YvPpZsw6m11gUwa3Uy2Nc287zAA9ehqwpIdIYV5Q0jGLmIKlzqcAPAgCSD+xAcnt
lJSWPf1ypjeE1rVPiibDw5gMckE2L/K4sJvou7Yn2VGrXApaX9UHouZlSJB1cq6f
ZDPS7RQ3ESHv7stoIZq+5sfh3DBfcMAP9g8cqsOwocMKxeu0qjd9vnGcxrUZaaLc
8YwHHFnICNT6ZqzpaVuWgEo+sDoJFgcDjGyHKkCut/0y6+B/zq0+XVQJ/I2sMiDy
0hggOMYjXrqVv7WFgVrT7c3AslrQSIQ1jU1zOmtZBqFiJg3hTuDx2ntLU+IeOdJf
kcVz4RFgkV/e8VoD2GgWxAbHUNii2faB5yUMnK7KES6aTrY1vRRwVOCTJOD0Lzhy
K1SvP0ZJ
=9AhX
-----END PGP SIGNATURE-----

--jKA9cyG3NP3srMcY--
