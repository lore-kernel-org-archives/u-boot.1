Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FE7CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 15:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 164F08409B;
	Wed,  8 Oct 2025 17:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a/cxt1Cz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C7F684054; Wed,  8 Oct 2025 17:32:28 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1470E840CA
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 17:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7ab0012e05aso4975869a34.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 08:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759937545; x=1760542345; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gl1J/IA6iN+3pZd4BNuCmERuHk4uhkCvXJSfsjAkoNs=;
 b=a/cxt1CzX/TJ/JIHAZLQGq90hozTb1HFskahrFRfpwo+we4s60Ya78IQC5oM1IeIdC
 gA+v+7s3xBEMSIIgkDmQ1ln9bPIlMop65zkbD9DSd3b5HcMK1XHY5QpNUQ0NDIcUSlZC
 +E1q4092te3tM06QAvWNd0cinpweroXeyrMRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759937545; x=1760542345;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gl1J/IA6iN+3pZd4BNuCmERuHk4uhkCvXJSfsjAkoNs=;
 b=WyP8OKNATOxdwlmODGWKg0mOPzt5o7QC+TDX6kewXEuwPGj7skYceA3zunewunxzhC
 Sid4k80tK3qwRKbriisJuNhHe7vQbFRfFXZxmrSXlfXGVl6q5GF+dYpmtHMW2y7kX0l6
 I64vSthv3RrmabIP+N7aukEqasL4lw5w/KOkOUOaCPYiULLeWjEiH3OzyfKeESHzLlc0
 VklHc70jCovHi9ZtMSBHpXcEdeO5cy8aTRnYzDD/WiKw24eKew4oAMAJeCdN9/LpE/4Q
 Cezmgzwitu6359/W/ASCahm2tH9BEKMBc78jWae1aLUk0oCuO9PgMGSIdNJ2yVKuP7Ph
 6h2w==
X-Gm-Message-State: AOJu0YyYtCJlrVHPrjaV1v7PBuXcMXeVIgqdUzhAWC+7d+a+UPz+WD7U
 R633qhZWW5usnAG9mfkXmsQrQkXxTvWu02deotO6mr+JCtic54NB+HKPT8NyyD5+PJY=
X-Gm-Gg: ASbGncvbMpFH3jRbwZRKZMY5krqPuJlQKX8MdRgxafg1y/Wl2qsx6Nm8sOkxIva5R1s
 YvZqkEkEst56DpIsoJkl+wX68/tUrTAZQeJSNt6PyIepL2xMI6CzZJRM2tqX3zEciw7Tq7BkcCk
 4BRjzZpoHBJy0W19G5kjMEs58cvOr5C6DKNPMNiP7q342vSjSLtsNXfEpsFRpE/X0JvG5gIeyyE
 loyRgnxLJCRY77ZxIWqMNU26OP2ynlhyKO80TzzRrLzKUMohku3vcayVTVrbhtyWc+8/lE4a4zx
 pZS67j6jYyjiVERvyS8iq8syjzJ2oBO0sacDODw3bsnyYTBg1MvU9P+IW31eg5HR9qekBaXacfy
 njourHASEd2qh0W08jJg6m9tR/LENGLQxBXzMhLI1+Z4/HnouwXKDQb/o80WygSCySIAUSlz9dz
 +N2dG9VMilAw==
X-Google-Smtp-Source: AGHT+IE57LbLCi36atmnTtNB8VT6596dwYNiATruTE+TAAQcV3ZYTrJnH2wWr2nPXLxVAqEZkWG1FA==
X-Received: by 2002:a05:6808:3094:b0:43b:9e0b:4bff with SMTP id
 5614622812f47-4417b2fa0b6mr1977007b6e.19.1759937544526; 
 Wed, 08 Oct 2025 08:32:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44189aab87esm43865b6e.16.2025.10.08.08.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 08:32:23 -0700 (PDT)
Date: Wed, 8 Oct 2025 09:32:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v2 06/17] boot: Add a new test for global bootmeths
Message-ID: <20251008153221.GY298503@bill-the-cat>
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-7-sjg@chromium.org>
 <20251007175849.GN298503@bill-the-cat>
 <CAFLszTjEDa-YueKQu7i5E7C=qP15HnEhLour0xynvws7P76SZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QatSN5HJ2SqN9iYR"
Content-Disposition: inline
In-Reply-To: <CAFLszTjEDa-YueKQu7i5E7C=qP15HnEhLour0xynvws7P76SZg@mail.gmail.com>
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


--QatSN5HJ2SqN9iYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 06:54:21AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 7 Oct 2025 at 11:58, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 01, 2025 at 03:26:31PM -0600, Simon Glass wrote:
> >
> > > These have different behaviour from normal bootmeths and we are about=
 to
> > > enhance it. So add a test and also an extra check in bootflow_iter()
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > [snip]
> > > @@ -388,6 +390,49 @@ static int bootflow_iter(struct unit_test_state =
*uts)
> > >  BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
> > >
> > >  #if defined(CONFIG_SANDBOX) && defined(CONFIG_BOOTMETH_GLOBAL)
> > > +
> > > +/* Check iterating through available bootflows to test global bootme=
ths */
> > > +static int bootflow_iter_glob(struct unit_test_state *uts)
> > > +{
> > > +     struct bootflow_iter iter;
> > > +     struct bootflow bflow;
> > > +
> > > +     bootstd_clear_glob();
> > > +
> > > +     /* we should get the global bootmeth initially */
> > > +     ut_asserteq(-EINVAL,
> > > +                 bootflow_scan_first(NULL, NULL, &iter, BOOTFLOWIF_A=
LL |
> > > +                                     BOOTFLOWIF_SHOW, &bflow));
> > > +     bootflow_show(0, &bflow, true);
> >
> > Here is the one call of bootflow_show outside of where show_bootflow is
> > called today, and bootflow_show is called by the end of this series.
> >
> > > +     ut_asserteq(3, iter.num_methods);
> > > +     ut_assert(iter.doing_global);
> > > +     ut_asserteq(2, iter.first_glob_method);
> > > +
> > > +     ut_asserteq(2, iter.cur_method);
> > > +     ut_asserteq(0, iter.part);
> > > +     ut_asserteq(0, iter.max_part);
> > > +     ut_asserteq_str("firmware0", iter.method->name);
> > > +     ut_asserteq(0, bflow.err);
> > > +     bootflow_free(&bflow);
> > > +
> > > +     /* next we should get the first non-global bootmeth */
> > > +     ut_asserteq(-EPROTONOSUPPORT, bootflow_scan_next(&iter, &bflow)=
);
> > > +
> > > +     /* at this point the global bootmeths are stranded above num_me=
thods */
> > > +     ut_asserteq(2, iter.num_methods);
> > > +     ut_asserteq(2, iter.first_glob_method);
> > > +     ut_assert(!iter.doing_global);
> > > +
> > > +     ut_asserteq(0, iter.cur_method);
> > > +     ut_asserteq(0, iter.part);
> > > +     ut_asserteq(0, iter.max_part);
> > > +     ut_asserteq_str("extlinux", iter.method->name);
> > > +     ut_asserteq(0, bflow.err);
> >
> > Nothing in the rest of this test is checking the output of strings, and
> > nor should it since the test is checking the struct itself to be as
> > expected. Am I missing something? If not, I don't think we should bother
> > with the previous patch.
>=20
> You're missing that when the test fails you need to try to figure out
> why...it is much easier to do that if it prints out info on the
> bootflow. In my case it was printing a completely different one.

I want to come back to this for a moment, because (along with a few
other parts of this series) it shows the hard question of:

- After debugging a problem, how much logging / debug statements should
  remain?

More comments are always good. There's no size cost, there's no run time
cost and it helps everyone who comes along later understand the code
better.

Given that CONFIG_LOG isn't usually enabled, on the one hand log_debug
should be fine as that should be compile-time optimized out. On the
other hand, is that information that we should have available already?
Do we need a debug statement about returning -EFOO vs the caller(s)
printing "got %d as ret" ?

And then it's also a question of "will anyone use this again? Is the
churn to git blame for adding '{' here worth it?"

I often lean towards the last question being answered with "No" and so
just making sure comments are correct. That also means not keeping in
things like show_bootflow being a public function now even if I had
exposed it as a quick "what does this number mean again?".

--=20
Tom

--QatSN5HJ2SqN9iYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOaEAQAKCRAr4qD1Cr/k
CmzYAP9poU5xBkEv+Ne0nImz3uCs/rk8q4izHmFgbjVDGgnTcgEA/k5oauWjv5bN
AwGHONhA2Nwir+Tl4OyQVBpAd5LjxQY=
=PbWL
-----END PGP SIGNATURE-----

--QatSN5HJ2SqN9iYR--
