Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7641DEC874B
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 18:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCA29869D7;
	Thu,  7 Sep 2023 20:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qotnsYWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82D92869F7; Thu,  7 Sep 2023 20:14:18 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5513F8644F
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 20:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-58cbdf3eecaso12549687b3.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 11:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694110454; x=1694715254; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fpWWnD3jfs5kkJVrfGLd9ZSZzv9B7RoW+CRhyua9P9c=;
 b=qotnsYWb/W4ScAlevYHoMLl2a/2H8KheK9D9JVb3/Gkazp2hjE9sIbYaScHWqVPH71
 jESIZWZAS+MwDvB3xUuAxU310RXw5wFCI3gtSWU6rqehHQ1Re805X/pVwnRpQzER6Vxk
 dCUNOVGCiAEiKYrCkNdjrybUitvUMq+HqMMeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694110454; x=1694715254;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fpWWnD3jfs5kkJVrfGLd9ZSZzv9B7RoW+CRhyua9P9c=;
 b=AeHPSumPd6G3rPmWesumO4OMoLNPtr4tPuSJZP/yKrg8m1PbGHfU3gDRgkwbH1HOtb
 /Cd9DiPFFOqSAMycU5wJBGiOo6bJ16tCV7eLd3JHL7WBVm/mo6F4exZrf2JsxRUMK5ri
 nTDUA3SPLGwBv/PTq5Bku5XpCC3RKYNY6kocN0AV3BQgEGBxWa/WeVjTina7DAPWpuGp
 /i0nDgO1lZJ8ox4pOR2MFfITwi3S60SM7b4nOwnbr7tayi6+BnXpCJzbPcUeVPlCP4yb
 W537LufGm3mg9DkpLXt8bjws/sdwbjCiOSRA21RBE4SmjVP9ClnxPOr3lwyyIb/rX7hH
 Ql2w==
X-Gm-Message-State: AOJu0YyoB2FfcO6korTFiUU0ys2CGkcZt9QAEM7eUZuvTKwbu75ajZY9
 8R9dlc4cRN+QoHSy94wp/hNE3w==
X-Google-Smtp-Source: AGHT+IH91uuV8o5c/m6XeX18E00kFPJ5cqaBW79oSBWVb+gh2IAeWff+BtDL78P6B9+C9HF3ydr8ag==
X-Received: by 2002:a0d:dc42:0:b0:595:89b0:6b56 with SMTP id
 f63-20020a0ddc42000000b0059589b06b56mr424861ywe.28.1694110454010; 
 Thu, 07 Sep 2023 11:14:14 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-27f1-c90c-e8ad-e559.res6.spectrum.com.
 [2603:6081:7b00:6400:27f1:c90c:e8ad:e559])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a81f204000000b0059af121d0b8sm2008604ywm.52.2023.09.07.11.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 11:14:13 -0700 (PDT)
Date: Thu, 7 Sep 2023 14:14:11 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: sandbox trace errors in CI loop
Message-ID: <20230907181411.GX305624@bill-the-cat>
References: <7d128f4a-b972-0535-ac06-bd600ba2e37c@monstr.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VInCTK0/m+LQjl2A"
Content-Disposition: inline
In-Reply-To: <7d128f4a-b972-0535-ac06-bd600ba2e37c@monstr.eu>
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


--VInCTK0/m+LQjl2A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 05:30:03PM +0200, Michal Simek wrote:
> Hi Simon and Tom,
>=20
> I am preparing pull request and I see that CI loop is reporting issue with
> sandbox trace and I have no idea what's going wrong here.
>=20
> This is the first problematic commit but have no clue what it has to do w=
ith trace.
>=20
> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/commit/8c5f8=
0d11b29536979ac41a6087fb8938f45bbf2
>=20
> If you have an access you can take a look at my queue to see that only th=
is
> job is failing.
> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelines
>=20
> Thanks,
> Michal
>=20
> collected 1152 items / 1151 deselected / 1 selected
> test/py/tests/test_trace.py F                                            =
[100%]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> __________________________________ test_trace ___________________________=
_______
> test/py/tests/test_trace.py:292: in test_trace
>     check_function(cons, fname, proftool, map_fname, trace_dat)
> test/py/tests/test_trace.py:117: in check_function
>     out =3D util.run_and_log(cons, ['sh', '-c', cmd])
> test/py/u_boot_utils.py:181: in run_and_log
>     output =3D runner.run(cmd, ignore_errors=3Dignore_errors, stdin=3Dstd=
in, env=3Denv)
> test/py/multiplexed_log.py:183: in run
>     raise exception
> E   ValueError: Exit code: 1
> ---------------------------- Captured stdout setup ----------------------=
-------
> /u-boot
> trace: early enable at 00100000
> sandbox_serial serial: pinctrl_select_state_full:
> uclass_get_device_by_phandle_id: err=3D-19
> =3D>

I don't get it either since I see this on master with trace options
enabled per CI:
$ ./u-boot -T arch/sandbox/dts/test.dtb
trace: early enable at 00100000
sandbox_serial serial: pinctrl_select_state_full: uclass_get_device_by_phan=
dle_id: err=3D-19
=2E.. rest of boot proceeds ...

So the test should be failing already if that was the problem.

--=20
Tom

--VInCTK0/m+LQjl2A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT6Eu0ACgkQFHw5/5Y0
tyzVpwwAmlmMu6JCMejnY4WrnOf1CD6mFWAyLVpkftiCPOHybV/jmgMy6WERbsMl
2rV0Nwb6Cv5cGJKckodnMzwc75PZVE9gbliBhsXfs7EFmo8VSW9TDsOdoQDx79od
HQ2XpTlM/1+kgw3NXKS7noOMmAqozoxgcCAaU9iPFPQngGiXNxyi8LnVOn5KESge
GSf70/tX61AlGsFC3sDakKQFvgDupWWZ1rHihkRrA5JJQxdaHH7mTyFnIbhYW4MF
tTXteur+QllHDwDmu4HeE3gDNzdfZrqcI08AHkpECVG1fXtG61mFjfcozR/6SBnp
uDbwxbDK6KnwyrK5PsoCe3IyH7HlVD9C1xo306t0eszrw7hdj14xL4yI30RdYfyD
T1ua76ZAROPSoOLZ+FKTC9JIZCtNiiguf7vEDPK+u8dlJPdqyr+nzfgxi2LOmM4Z
orUoYDBQ5HFkG9Yj2pLBAQv2PPuJ4AcExjLG6HvpX9R7lncndaQLS0agp0oGp/Mb
072u++vD
=lULc
-----END PGP SIGNATURE-----

--VInCTK0/m+LQjl2A--
