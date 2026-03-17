Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29344FD8769
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 13:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 995EF84308;
	Tue, 17 Mar 2026 14:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AI8olKeu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96AB88430A; Tue, 17 Mar 2026 14:38:50 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5852284307
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 14:38:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-40f0e14b9f9so3892890fac.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 06:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773754727; x=1774359527; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+tnu8V5w8kMnCAvEVXPPxe7sPTI9FjKfYjv2Q+HQraU=;
 b=AI8olKeuByndb4FSyA5YWqMZv1Vw0zTAfqISwrrzmSBHKPm+tT2xdKtdW0hR7INDfn
 8eFq6pH3PBWd465gQOa++McRaO83ONWnPIEI6DG4JzNT+CSKRqbD6PZ1SCtu9S4T/EF3
 AWtbdYIxhD8m7Zh2JnBE2lkirn9xYS5dZKXXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773754727; x=1774359527;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+tnu8V5w8kMnCAvEVXPPxe7sPTI9FjKfYjv2Q+HQraU=;
 b=ireNZYEqMg7bgFk0nwqGzfgxNC/0+fydEuTecIKNHXHERcA6UpAIpAbSqUxb3a9LvD
 2e5FvTu7TTkPhsl2oQVZ65GSpd6t9HoOg+5bB0tcqxq4Is01KnM7jVt3E3SnzCrOWexi
 LFAIDhz/RpiKb8a8MMJXvfeZ1h1fTvv4I1ysSuoNtFxOKkE4a5pB6UW3zCL9SP6Y0oo9
 5kFUEO1wCCBdgUBRVh3EwJ4M9mV6Rg2DhVXaAetHB4f1G6GtGZJtkb4ONncQGi37O35x
 2FVdG2vUrKegpjCEWdQVI6TtnRfTQWZov7uQrlSEBqK9KBaDPh5VOopHtyEsiGWoTZDw
 nyqw==
X-Gm-Message-State: AOJu0Yx6YDPn+wJeTw+gQAypuMESmIlQLNNcbJafsNhcztB0bQcbACKc
 fVs32SrJV6Nk0dDGaeKQLuXdwwm0KeMw7UjMVTkQ+4cK7BX78Qxbco4/Kl5zGV1sUBc=
X-Gm-Gg: ATEYQzzd79H8qMIy9ntWVZFUh0FkE8iqx50idWxq2Qyi2SrsU5L7jrrNJE1sM5V5S25
 vAqObWMH0DC3jCWJBVmFiGZ06gsdK2UQEgqBd3zgWvFH/0E62EIZh/v4FMxgZ9u/Oq5bPT6ig6/
 n4I4/g+fZKqsGox5DleQDTE5KmcOC2xYFtTLvZprfU26PtFZnhuv4UJTiQLflJDP8BIKJP/n0S3
 zYZ3393H6KMc0Hq6xfVY/y2ML9pOvQ2PFGp3z38OVAZMRqOY4xegRYsf5YNuvRXkolBKeTkOrOt
 NAUUu9EYRANyYELjyGE9TyyIwYMIV0UfphKFSGVEJvN9+eHa7Jt3mio9Aj5A3QUpDbjI2snkS5n
 7j9QR4cTdAVybIrdttR6O0Sh8aF68rPhrTuz4mob+0xiX1c8SoH31zEKq8VeIoNvxKHKbAmFLJE
 N8el5MOSSQfRI98NKJzgMzL/QB8/rZ2ImZzMAIOPMdM0ANdkeuXe9G37XZebFKHJ5RhbAHR/+Bi
 X27NFRA5iREwr36utmBCzNMu8gKfiwddoTxvdnGZX6dscrP
X-Received: by 2002:a05:6871:2e91:b0:417:298d:a23b with SMTP id
 586e51a60fabf-417b93e2c54mr10703950fac.43.1773754726788; 
 Tue, 17 Mar 2026 06:38:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e268f37sm18515081fac.6.2026.03.17.06.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 06:38:46 -0700 (PDT)
Date: Tue, 17 Mar 2026 07:38:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com
Subject: Re: [PATCH] optee: Correct dependencies for BOOTM_OPTEE
Message-ID: <20260317133843.GP502704@bill-the-cat>
References: <20260317012452.4162719-1-trini@konsulko.com>
 <533317d3-76f5-4e6f-a8f1-d879fc642de2@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uRoVI/z++nf7Af6z"
Content-Disposition: inline
In-Reply-To: <533317d3-76f5-4e6f-a8f1-d879fc642de2@mailbox.org>
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


--uRoVI/z++nf7Af6z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 03:32:16AM +0100, Marek Vasut wrote:
> On 3/17/26 2:24 AM, Tom Rini wrote:
> > As exposed by "make randconfig", we have an issue with the dependencies
> > for BOOTM_OPTEE. This symbol needs to select BOOTM_LINUX and in turn
> > that is only valid for CMD_BOOTM or CMD_BOOTZ. Add this dependency.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > I am looking for feedback on this, so I've added the board maintainers
> > for the platforms which enable this option. It looks like this is only
> > valid on 32bit ARM platforms, to start with and not 64bit, is that
> > correct? That's why I excluded CMD_BOOTI from the list. I suspect that
> > this should really depend on CMD_BOOT{M,Z} and BOOTM_LINUX, and not
> > select it. If someone can confirm, I can do that instead, or someone can
> > just do the replacement patch for this. Thanks!
> >=20
> > Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: Marek Vasut <marek.vasut@mailbox.org>
> > Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > Cc: u-boot@dh-electronics.com
> > ---
> >   lib/optee/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/lib/optee/Kconfig b/lib/optee/Kconfig
> > index 34b9d8afe675..9251faf73cd7 100644
> > --- a/lib/optee/Kconfig
> > +++ b/lib/optee/Kconfig
> > @@ -40,6 +40,7 @@ config OPTEE_TZDRAM_SIZE
> >   config BOOTM_OPTEE
> >   	bool "Support OPTEE bootm command"
> > +	depends on CMD_BOOTM || CMD_BOOTZ
> ARM32 SPL arch/arm/lib/spl.c has this piece of code, which does not depend
> on "bootm" command. This is used by falcon boot to jump into optee-os , w=
ith
> the optee-os return address being Linux kernel entry point. So I don't th=
ink
> depending on CMD_BOOT{M,Z,I} is enough ?
>=20
> 77 #if defined(CONFIG_BOOTM_OPTEE) && defined(CONFIG_ARM) &&
> !defined(CONFIG_ARM64)
> 78         if (spl_image->optee_addr)
> 79                 boot_jump_linux_via_optee((void
> *)(spl_image->entry_point),

Ah right, I forgot about xPL_LIB_BOOTM. But, is this 32bit only?

--=20
Tom

--uRoVI/z++nf7Af6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCablZYAAKCRAr4qD1Cr/k
CrtSAQCJNGwbMKssabkxLSXm78Qbg+/+dkTiyJccje0WnM1BQAD/VWrCWmZgOHyY
tKTFtKpmS3vN/fv9a/ip8O8248dWPwo=
=E7O/
-----END PGP SIGNATURE-----

--uRoVI/z++nf7Af6z--
