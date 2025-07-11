Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E032CC83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 17:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C4E782B07;
	Fri, 11 Jul 2025 19:41:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SA+bI6ET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F376382C84; Fri, 11 Jul 2025 19:41:13 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 943E08277D
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 19:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72c47631b4cso1529888a34.1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 10:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752255670; x=1752860470; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YKeTk2SgMkQndQZdRc0CBXhXJ4r54NtQpYnX6OSbhG8=;
 b=SA+bI6ETjApG3jpkpmc0MdrVwF6StnW0Uhh/+Fhu7+EM9wGm1BwAvwDfUp68gzo7F+
 +pz6w1QPFB5sycl4YGeQsukimPaT+7YGNgqVAh2C9yzMQa8MwfbkRxt53itjGOcNDWk4
 23mcKBqHBIqCenGY23vCZV/0hvVkGG0Mja5fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752255670; x=1752860470;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YKeTk2SgMkQndQZdRc0CBXhXJ4r54NtQpYnX6OSbhG8=;
 b=CAmythCa9y9AVl9YAcfCAEfkm0ODa8SLKarSRPyhQ+PujR3NrcmfWRKKQGIGGnApIG
 UKHrd3zO79e8QU4bhERnievH4dCg1WdnSmqj7MGTu+m+6PMUZD5BoRSwLRqF1CNsPaJ/
 IRQL3KQKC+sDGHVdqQNdJYdXrAc8HPtVT6Gpk8R0G0ohdoWxNOumOUI+ZDZ/Cgxs7Oqz
 kHNJgpytIcINZglhUbGC9gnwxdLHOsopQeNJQfcCjBvcsNk9mzansGpKs6I1l5FHlutT
 mH6bL8wl4gvVqq8QO5XqB97g753uSfDOYVMDBGkmmF/L7xAvmBmt1jqgQDhrjt7wZeBA
 o/ww==
X-Gm-Message-State: AOJu0YzezCMAWnhWlcXmDMUNvbniZwyUDcHWzz+hpfsS1y8ZBS6esGDv
 Yhw+MUaQRD51jKsHWMIbDSk8PnJfPerBsfgGQgR+RgsNrsDf7UsMrwU32IdP5rpv0j8=
X-Gm-Gg: ASbGncvReMkRXuxqotc5TC/UBO7OhZ+okjw4QbfJUZd+thp9HeOkgZTJXNY/WnOZ5L2
 ab7kSzwcjtybacL9oCk+NkIM0oXJvvY7j0gE24fNlBQtw5hC9L2bzV/plbiF74rppALt02EOdjs
 ENsEzWunqnK+bssUCWlTAi8UdMI3kikHCpsid3xQlm0oKGLDHNygylVqlhYqglxPsBmu/wYWL4i
 DrYq+bfdIM08kztC8tzX0uRX+lskJg2leRtCAu57C4hEd5c0O2uqF63bOTWPx9eSGJxT5DdPkH1
 ZcW+Si+5hk4XRDwRD4Og0qzXOEPdHrttyXllvzabpTW9IyyK8d7pu4OBY6yi10+c+6KUbOmLhTU
 rBGcSWOd12Ps55Nj92sml+N4P7PmCiRY9LAg4V1MmUWWYS38u/GCLOEsiKRhcbA74zpY=
X-Google-Smtp-Source: AGHT+IFQ+I62C3uwB5SErREjSDLvgfDdyZepKHRh/Tr9fyuJi2DF0fy1Og2LTHTlYdzyTBCeJMH02A==
X-Received: by 2002:a05:6808:11ca:b0:406:7a50:947a with SMTP id
 5614622812f47-41539d95efemr2832129b6e.27.1752255670191; 
 Fri, 11 Jul 2025 10:41:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-41418c0c266sm617456b6e.1.2025.07.11.10.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 10:41:09 -0700 (PDT)
Date: Fri, 11 Jul 2025 11:41:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH V4 0/3] cmd: env: select: Add output for available
 environment targets
Message-ID: <20250711174107.GK6424@bill-the-cat>
References: <20250630151232.39100-1-cniedermaier@dh-electronics.com>
 <20250710015826.GY6424@bill-the-cat>
 <7d8b712b9e71485ca6f057e95f19af1e@dh-electronics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/1PYQtLMfT3bagmc"
Content-Disposition: inline
In-Reply-To: <7d8b712b9e71485ca6f057e95f19af1e@dh-electronics.com>
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


--/1PYQtLMfT3bagmc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 05:37:55PM +0000, Christoph Niedermaier wrote:
> From: Tom Rini <trini@konsulko.com>
> Sent: Thursday, July 10, 2025 3:58 AM
> > Subject: Re: [PATCH V4 0/3] cmd: env: select: Add output for available =
environment targets
> >=20
> > On Mon, Jun 30, 2025 at 05:12:29PM +0200, Christoph Niedermaier wrote:
> >=20
> >> Add the "-l" parameter to the "env select" command to print the availa=
ble
> >> environment targets, convert all argument parsing in the file nvedit.c=
 to
> >> getopt() and check that with unit tests.
> >>
> >> The first patch converts the parsing of arguments to getopt() for all =
env
> >> commands. The second one adds unit tests for checking the env command.
> >> These were used to check the env commands before and after the convers=
ion.
> >> The third patch adds the actual new parameter "-l" for the "env select"
> >> command.
> >>
> >> Christoph Niedermaier (3):
> >>   cmd: nvedit: Convert the parsing of arguments to getopt()
> >>   test: cmd: nvedit: Add basic unit tests
> >>   cmd: env: select: Add output for available environment targets
> >=20
> > Can you please make a v5 that's run through CI? I saw that am64x_evm_a53
> > fails to build now and I'm seeing the tests fail too:
> > https://source.denx.de/u-boot/u-boot/-/jobs/1196652
>=20
> Sorry, I will have a look at it and make a new version.
> Are my patches also the cause of the build issue with am64x_evm_a53?

Yes, something in the series was leading to at least that platform and
likely many others (I saw that in my local board testing, CI failed the
pipeline before getting to the world stage so I don't know all of the
ones that failed).

--=20
Tom

--/1PYQtLMfT3bagmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhxTLMACgkQFHw5/5Y0
tyxAJAv+Mr92TBVOtnZvy5bpZa88wBct/4euwO4tBVajrs7Iwb0cpu1sUXh+Rejp
95+OPnHI6RkWE6xKxv4G5Cu0mzTviTDYwooGbDGiDng6tj0xAJJre+23mX6zKxNW
4F5PIRmQnXCTmj5+2BL+heyW96yvm+4QQcKLFHpufC9EBzHF2jqP/4L6g+qso3qT
iaZohzUEpcj2XvaCgRd5DEqRe6f/ur8Zxo6xG61cVo9d0Yws/V+OfDdtJKLUTdrI
4TNxheFVhv1yOK49+CmjlpcROgJZj7OK4+YQS67SmKhGTgnIpVul5Yx1lDRWLYSK
6oaOykhdQhESynniZp9uhuf7X/SF49pfeSkh9yWpbyOOGE4+NPr/QVExCIhKq3HV
cW/MP7QBAtT9nHrx38Ev8rPCUSSXGBoZMe9AhM2d2J9HVP5k/OGSYwTRhg/TZw+V
w8jtJIpxxhfU2X+g/g8OGUK1XIh+5IE6BuSRX6pqMEXPX3Rl+s+LBPpfHyTB/kB7
FjIsarE8
=Flsv
-----END PGP SIGNATURE-----

--/1PYQtLMfT3bagmc--
