Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329AEC4706F
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C26C875FA;
	Fri, 22 Dec 2023 22:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N2ieXOqn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9290787652; Fri, 22 Dec 2023 22:23:20 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BF83875A0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:23:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4279007fb34so14048971cf.3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703280197; x=1703884997; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e/t5zEfj7N370K7glUEj4uw6piZdpCQrnyrVuyCxi2U=;
 b=N2ieXOqn9vN72SC6BdNlG26P7mhF73LPpY7R6c8co5jLdxiU5ant2vqjORLcOp7a0p
 xSQ/kPBDrjea4f3l/pkVhZj7tZGN0iL8kXujpRevQ7F9Pzh9GVQ4IPbCmITd3gfFQrOq
 ycXow8Gwrm5onaiQj05FxV0nQNOi4du1l1X+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703280197; x=1703884997;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/t5zEfj7N370K7glUEj4uw6piZdpCQrnyrVuyCxi2U=;
 b=BvkUgkxKqrlRNB5tOtENjUKnwnNxs5yz89QPoVLrS0iEmLGy9e5rFUyi0GWLrNShwA
 B2Ekq+xTNQN4kVPoT0ns2AKKesGApXxK6thNl/zri9t41EsFt9ZDAaEMLVe0RduE6CSU
 EM9OWYgNDhNPjQyaY6Xj4ImLxkJDNv6gZ/HkTwfPU84VRVJohMftG4NIaWbZs5E7/Nyo
 xrH6B1NjGQUYSV4AHNMUPWa84cV5GYp5eXDBsuzQffB0V+03eNO/Y6/yuYiw7ascKUqY
 SHEeNGm1aIw1HjKsLjMqJjMp3/Wlf2PvGUh4hcPkoPCe09GobBqtA3eM2KMxKKH3oMjf
 icCA==
X-Gm-Message-State: AOJu0YywGBDQbzTWTvYItl4AnBfwvrEhpxZmM7Wsg5NfxccCxWMlDlml
 S7C/bbD+Y0KDK8ee4CNN9i1QXCCsMYssHw==
X-Google-Smtp-Source: AGHT+IHroxKighvWp9XEE1+Vz04Pje9JY9aa9Mlwfc9g0ezOJB99uMRu8pDcXnqWdxOD5GQdeFzxFw==
X-Received: by 2002:a05:622a:174a:b0:427:82a2:e70c with SMTP id
 l10-20020a05622a174a00b0042782a2e70cmr2254500qtk.115.1703280197092; 
 Fri, 22 Dec 2023 13:23:17 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 fa4-20020a05622a4cc400b0042783eface8sm2175902qtb.81.2023.12.22.13.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:23:15 -0800 (PST)
Date: Fri, 22 Dec 2023 16:23:12 -0500
From: Tom Rini <trini@konsulko.com>
To: Francis Laniel <francis.laniel@amarulasolutions.com>
Cc: u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>, Marek Vasut <marex@denx.de>,
 Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH v13 15/24] cli: add modern hush as parser for
 run_command*()
Message-ID: <20231222212312.GE2652760@bill-the-cat>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
 <20231222210244.91830-16-francis.laniel@amarulasolutions.com>
 <5739012.DvuYhMxLoT@pwmachine>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qi7+wN+2P6aNeQZx"
Content-Disposition: inline
In-Reply-To: <5739012.DvuYhMxLoT@pwmachine>
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


--Qi7+wN+2P6aNeQZx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 10:10:42PM +0100, Francis Laniel wrote:
> Hi!
>=20
>=20
> Le vendredi 22 d=E9cembre 2023, 22:02:35 CET Francis Laniel a =E9crit :
> > Enables using, in code, modern hush as parser for run_command function
> > family. It also enables the command run to be used by CLI user of modern
> > hush.
> >=20
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
[snip]
> > diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> > index a9b555c779..104f49deef 100644
> > --- a/test/boot/bootflow.c
> > +++ b/test/boot/bootflow.c
> > @@ -710,7 +710,21 @@ static int bootflow_scan_menu_boot(struct
> > unit_test_state *uts) ut_assert_skip_to_line("(2 bootflows, 2 valid)");
> >=20
> >  	ut_assert_nextline("Selected: Armbian");
> > -	ut_assert_skip_to_line("Boot failed (err=3D-14)");
> > +
> > +	if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
> > +		/*
> > +		 * With old hush, despite booti failing to boot, i.e. returning
> > +		 * CMD_RET_FAILURE, run_command() returns 0 which leads=20
> bootflow_boot(),
> > as +		 * we are using bootmeth_script here, to return -EFAULT.
> > +		 */
> > +		ut_assert_skip_to_line("Boot failed (err=3D-14)");
> > +	} else if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
> > +		/*
> > +		 * While with modern one, run_command() propagates=20
> CMD_RET_FAILURE
> > returned +		 * by booti, so we get 1 here.
> > +		 */
> > +		ut_assert_skip_to_line("Boot failed (err=3D1)");
> > +	}
>=20
> I would like to give a bit of context here.
> With the following patch:
> diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> index c169c835e3..cc5adda0a3 100644
> --- a/test/py/tests/test_ut.py
> +++ b/test/py/tests/test_ut.py
> @@ -173,7 +173,7 @@ else
>         fi
>  fi
>  booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
> -
> +echo $?
>  # Recompile with:
>  # mkimage -C none -A arm -T script -d /boot/boot.cmd /boot/boot.scr
>  ''' % (mmc_dev)
> We can easily see that booti is failing while running the test:
> $ ./test/py/test.py -o log_cli=3Dtrue -s --build -v -k=20
> 'test_ut[ut_bootstd_bootflow_scan_menu_boot'
> ...
> Aborting!
> Failed to load '/boot/dtb/rockchip/overlay/-fixup.scr'
> 1
>=20
> The problem with old hush, is that the 1 returned here, which corresponds=
 to=20
> CMD_RET_FAILURE, is not propagated as the return value of run_command().
> So, this lead the -EFAULT branch here to be taken:
> int bootflow_boot(struct bootflow *bflow)
> {
> 	/* ... */
>=20
> 	ret =3D bootmeth_boot(bflow->method, bflow);
> 	if (ret)
> 		return log_msg_ret("boot", ret);
>=20
> 	/*
> 	 * internal error, should not get here since we should have booted
> 	 * something or returned an error
> 	 */
>=20
> 	return log_msg_ret("end", -EFAULT);
> }
>=20
> With modern hush, CMD_RET_FAILURE is propagated as the return value of=20
> run_command().
> As a consequence, we return with log_mst_ret("boot", 1), which leaded to =
this=20
> test to fail.
> The above modification consists in adapting the expected output to the cu=
rrent=20
> shell flavor.
> I think this is the good thing to do, as I find modern hush behavior bett=
er=20
> than the old one, i.e. it propagates CMD_RET_FAILURE as return of=20
> run_command().

Oh very nice, thanks for digging in to this and explaining!

--=20
Tom

--Qi7+wN+2P6aNeQZx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWF/jkACgkQFHw5/5Y0
tyzhwAv/ZuY0CzxEUlzj24unwyAlsO5cSlZtc7e6nWKb0MSedmDfuG1CiL314J/B
4zHyA8Fwep0VKXcSuamZFgZ1NB6AUi7y39ZxKI9SN8DBCd3QaSoclkn0Bv63ScwO
ORdwpsxuTXzSkZZnwtnF+86uP0hz/h/c2lgv+MosVaxfbpkHPqjd/ci/snHh7ioB
CCWSCNkC5rjIrX9gMiI86XgZY8wGUBReXS9jj4hRhSpb/ALkobKIfMZqzHYBY/DD
Znp4hU74FMe5TNxlx2KjQC5NHIRNBoNDRxdbepm2L8ahES+qWTPNq2x0igVHMNHA
Vso6g0OvpoMhMhlRq3pr0ai20SLKuZXYU4w0pr89MF2UL2vTTAh6yNT166YP146j
PcvN4p0X3+GJ2RwEqIjhJdyMBCaQQ7PjISFLOiMcFgbNmBpP2744HNNO3Z3Hhw9t
J1kfTBi58JSTgslaOixFQ6feASfBFVVHKwLHKZIK0HFNKwMgHB8RgDrvetMhMSL/
xEsJUAdn
=O3XT
-----END PGP SIGNATURE-----

--Qi7+wN+2P6aNeQZx--
