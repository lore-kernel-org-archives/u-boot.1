Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCA0D729E9
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 16:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 122C88941F;
	Fri, 29 Nov 2024 17:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nive3GeR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B03B289454; Fri, 29 Nov 2024 17:34:05 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9578689364
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 17:34:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-46686a258f7so16974211cf.1
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 08:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732898041; x=1733502841; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hv8y0tI4+r1tEcQKiDhqTRWOpRqsV1hYc+tS6o+KrnI=;
 b=nive3GeRi7zBnKnp6WZGR2iUYZ8ZL22VBbjxYrYKOPdkk4gQnWyltuWQI5cnRyYChh
 lU/qJz+8ZTUATVtDnRix/1MmMIPKzMsDj0WGdHLNstbqs7iyhnO1dMMlNwcYsrxhUMUp
 2pjNxhcCXo8zUruBv5VwaixkwlHvtzxmwxHT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732898041; x=1733502841;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hv8y0tI4+r1tEcQKiDhqTRWOpRqsV1hYc+tS6o+KrnI=;
 b=txBTT5vfbLnrWHOKUt/ECAcb+R6F0+ifTjnHxsVqUGMwJoNuPOPQrAm3saHrnwoBMo
 HOf3YxqEaorYE+BhhADi6gCxdlit6X4Clu243+RGLAtN8/dQVlguGftE4+oTMmA+fhjq
 0ZAspXRcYrQbvy8FYhTRlzxeMpEZX9W+z3GrqoYvtOC7REisUXxZeXjyUCwL6xi9TI0i
 AAIyumVO2xMX8p21XkPwZOe8V1P6yKi23vjt9Taors+xPyXM1V1BPoN7eAB+MK/3j+GL
 PGjppwCSnTliE6SiZPfYI2WAkCAFZr64HurArj20JRMTJ5g70fHGW84s7edjKEGDmLin
 2ZhQ==
X-Gm-Message-State: AOJu0YwWG62C4M9ycMYqihSaU9cVAU7+4V9BGC1Wr7ulMrcw0FJ2+hbi
 3sZZgpdBJ6zfezrciXLppx3EXqULAWUu5Zx13kw2NbRRzp9t7JwzbW/Sy1+GOK0=
X-Gm-Gg: ASbGncsiOK+ly6KXj8A65Je19IkwaUluCFJ/Q2ZHWWVcw56IEBZMYWfUShSdOHA91Um
 aM+DRz5hq8dWlBQpJLUHMxK6xhUa06VrEd1tdBaXIg2zVeZ/FLR/WWFZ9pMBIqKnLVST5sbTkid
 2pLIhsAuvuNZVHSBeujviNT2dnIG/gzMU9k9/vthcqRV71vAAaXKp7VpkY9JFMOfTeCUo65aTd8
 ETmvr+15v2Yz02XhC1efaiCC5UK8eQo5cuOvWrngMHLXjEnAA==
X-Google-Smtp-Source: AGHT+IEcIeKWcXOrFP1NVWGoARcE/XC87zNfqpRwhHK7KPh8LInlKmKKSVsRlxwM/QHcPaRDWwRp2A==
X-Received: by 2002:a05:622a:5b96:b0:466:c7c5:644a with SMTP id
 d75a77b69052e-466c7c5886dmr89790301cf.40.1732898041238; 
 Fri, 29 Nov 2024 08:34:01 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c421e323sm18352521cf.59.2024.11.29.08.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 08:34:00 -0800 (PST)
Date: Fri, 29 Nov 2024 10:33:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>
Subject: Re: [PATCH v2] test/cmd/wget.c: move net_test_wget() to the cmd test
 suite
Message-ID: <20241129163357.GM3600562@bill-the-cat>
References: <20241115164514.2186763-1-jerome.forissier@linaro.org>
 <20241119155939.GA3493897@bill-the-cat>
 <37f469bc-5610-401d-81c1-1e2a99ababdb@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EjMtJ24aHFKJL6Pk"
Content-Disposition: inline
In-Reply-To: <37f469bc-5610-401d-81c1-1e2a99ababdb@linaro.org>
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


--EjMtJ24aHFKJL6Pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 04:37:13PM +0100, Jerome Forissier wrote:
>=20
>=20
> On 11/19/24 16:59, Tom Rini wrote:
> > On Fri, Nov 15, 2024 at 05:45:14PM +0100, Jerome Forissier wrote:
> >=20
> >> Since net_test_wget() is testing a command and is in test/cmd it should
> >> be in the 'cmd' test suite, not 'lib'.
> >>
> >> Saving and restoring the values of the environment variables that the
> >> test manipulates is necessary to avoid a regression when running the
> >> whole ut test suite. A minimal reproducer is:
> >>
> >>  $ ./u-boot -T -c "ut cmd net_test_wget; ut dm dm_test_eth_act" | \
> >>      grep -E "(Test:|Failures:)"
> >>
> >> Reported-by: Simon Glass <sjg@chromium.org>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> ---
> >>  test/cmd/wget.c | 12 ++++++++++--
> >>  1 file changed, 10 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/test/cmd/wget.c b/test/cmd/wget.c
> >> index fe26fee54c9..7570c065a10 100644
> >> --- a/test/cmd/wget.c
> >> +++ b/test/cmd/wget.c
> >> @@ -19,7 +19,7 @@
> >>  #include <dm/test.h>
> >>  #include <dm/device-internal.h>
> >>  #include <dm/uclass-internal.h>
> >> -#include <test/lib.h>
> >> +#include <test/cmd.h>
> >>  #include <test/test.h>
> >>  #include <test/ut.h>
> >> =20
> >> @@ -206,6 +206,10 @@ static int sb_http_handler(struct udevice *dev, v=
oid *packet,
> >> =20
> >>  static int net_test_wget(struct unit_test_state *uts)
> >>  {
> >> +	char *prev_ethact =3D env_get("ethact");
> >> +	char *prev_ethrotate =3D env_get("ethrotate");
> >> +	char *prev_loadaddr =3D env_get("loadaddr");
> >> +
> >>  	sandbox_eth_set_tx_handler(0, sb_http_handler);
> >>  	sandbox_eth_set_priv(0, uts);
> >> =20
> >> @@ -223,6 +227,10 @@ static int net_test_wget(struct unit_test_state *=
uts)
> >>  	ut_assert_nextline("md5 for 00020000 ... 0002001f =3D=3D> 234af48e94=
b0085060249ecb5942ab57");
> >>  	ut_assert_console_end();
> >> =20
> >> +	env_set("ethact", prev_ethact);
> >> +	env_set("ethrotate", prev_ethrotate);
> >> +	env_set("loadaddr", prev_loadaddr);
> >> +
> >>  	return 0;
> >>  }
> >> -LIB_TEST(net_test_wget, UTF_CONSOLE);
> >> +CMD_TEST(net_test_wget, UTF_CONSOLE);
> >=20
> > I don't know why / how, but now this causes the "hash" unit test to
> > fail, in both Azure and GitLab.
>=20
> CI passed on https://github.com/u-boot/u-boot/pull/700. How do I reproduce
> the problem?

Sigh. I think we managed to hit one of those bugs that disappears when
we re-order objects slightly. This is also passing for me now, so I'll
apply this later today.

--=20
Tom

--EjMtJ24aHFKJL6Pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdJ7O0ACgkQFHw5/5Y0
tyyuHgv9EBEeZ1x/4EQKVcUgl18F/illsV6+ckcOinOOzudDOZ+pb9U8rjhw9izz
8uDghyqsp7UAD2ow8Xl/2HcPelZINwDfwdot6hLLy1uSZMGFnC3LiwHdASLevx7y
2id/aZDRRXan9yZiSVLMuoQ0jM+/IE6KApVc6rZSx+tyla5uRzAUYYQKcJoemTCq
EJ7US+aF2GC/11mVlRgGHQiBWsNTpjxXuuupLn4MhARxrg2qHyBvnN5z8zl2Wxb9
hK4nh0Etb+kcGeQ7ikvFRXIhWD/RCB5gjbNe5ZfAFyxZQH0uj7AwWa7hArBW2DIA
VLO4LgL2q0hAcXEFGqQlwWqTUa82xQN1iLYiRw7uHpiZCrGlzrYq/Pqd7ffIkG3n
HA8N6zEXqdOjQXOLRCz2BDn/hUdPCo3zoo49DFSqGBlA4vjwlsIzAZdT4RQ33ur5
EMRxsEEAdc0XZiuEJLDgvMK7mQtjGlNxG4cT/mfmMrrh5Fv9RmOzAhFTXrAQgY1T
ikDqhqLe
=6MG2
-----END PGP SIGNATURE-----

--EjMtJ24aHFKJL6Pk--
