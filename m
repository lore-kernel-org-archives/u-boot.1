Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92FAC87FCA
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 16:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9582383914;
	Thu, 31 Jul 2025 18:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W/4u2HFn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E80B58391A; Thu, 31 Jul 2025 18:05:42 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 379E983914
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 18:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-73e88bc38bbso650706a34.3
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753977939; x=1754582739; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sZvtY6BXKR0mt3NuU1TTc8bYZtKmd+blT/dkYXQwHYI=;
 b=W/4u2HFnhsbTYOPdhVBxd+9IbVFQR7SsAgwACMbE5+zpwWSGApYr+dvj0vLnp0u37v
 SdYjqUezI+CFIo9vpdSSUMtZRINjkmlVITS79nTt1Me8OUqXnCR4l7E/5W1k6kShKXIu
 fd26RmDGRP+2Du+fzcXRIdUZCARM9I6XQrxcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753977939; x=1754582739;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sZvtY6BXKR0mt3NuU1TTc8bYZtKmd+blT/dkYXQwHYI=;
 b=Y+1KaRg+k80Ic4/sHJv/eS4r2g0oqAS9UuLlYmKH2+x4rL1pc68aZY2SC7kb6X822+
 5WilIHlAB9GQrJWKuTe4TWbiz5UcpqI5kE7Rl8nW6TIUfB3uZeMKy0X8Q2sh70fqDoyw
 ebrvjauwud6vQFFLazFOTxGsoaO5sZcuGGbGuAUQ+6XMXeStgnBY+ftOcGPEjdIywjZX
 rnmsN1km+bG9V9+PROYrxKb/gGq5OgFC5gikNJLAqQ5JNJsbe5Zc36dfhMLZB/R1HKU2
 GwrZUl85A4BPpreL5bzOdNO0gqtoa7DmKJimuxM7JqKKYag3K1vNjbQd9quH+FHmaZVx
 TtwQ==
X-Gm-Message-State: AOJu0Yw170lLaOqllwN2laBjTCed0ORam/ghCnOtzHqiHL8sfvPkvSEB
 0oPnv57E3ulBziPD/TMiE4KNWQwRWwMdqZOWeLCVuDFCUgKWtJMujyDRW7EQogA+daA=
X-Gm-Gg: ASbGncvgYMxLwyWNOTMzzzGI2U6/CaOyAwTWFhS3YqR5ZVslUeQFq0lnnSjhuplPsTa
 qjAq469RZYapyyN9AoGqaqeN74gTxdmP5A7BOwYtS/IPxdLMz9OgtOBvmZzlqfgtFhybsZovCa8
 X7xFiqAcpPbtAul5OR46vOXWZ87F8WJNDYw1ynJSxsYdesWdyYk5fpsszg3VYcjGXBFZKLjgBiB
 OimFMjhRIYKnF6S6vTdzB8/dNQr2gZRKN+2mMLNdEx9jrVWlqPv8ijR9URvmOV7JK8EKyqMEz5T
 KdaS6bVXnu66RcOemx4mjbwjaCblzXk5TJjh0q80k1CwN6/wSp7Hh7oPGdL+lFJIUWnw5nhq8PN
 DQ/nGkjaZ+SEgKMr0RfmA74Xc3mjvNR3cPZkFg+/aiYGiVvfcvRraAX9o
X-Google-Smtp-Source: AGHT+IFcbHpBd2/Gdwa6pH0RvHyv+Q5bI/H8vBWSBX+YjINGXSRwk7oyRXAMMYeiIwQutRmbHq1g/w==
X-Received: by 2002:a05:6830:390b:b0:73e:9fea:f2bd with SMTP id
 46e09a7af769-74177e24375mr5747568a34.26.1753977938838; 
 Thu, 31 Jul 2025 09:05:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74186cc4d97sm338080a34.17.2025.07.31.09.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 09:05:38 -0700 (PDT)
Date: Thu, 31 Jul 2025 10:05:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: Re: [PATCH V5 0/4] cmd: env: select: Add output for available
 environment targets
Message-ID: <20250731160535.GB1807455@bill-the-cat>
References: <20250718170602.10746-1-cniedermaier@dh-electronics.com>
 <20250728190320.GA1732232@bill-the-cat>
 <3770ea5747c249d49499737f4889f177@dh-electronics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l/JxzhSs1pBwXto9"
Content-Disposition: inline
In-Reply-To: <3770ea5747c249d49499737f4889f177@dh-electronics.com>
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


--l/JxzhSs1pBwXto9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 09:58:27AM +0000, Christoph Niedermaier wrote:
> From: Tom Rini <trini@konsulko.com>
> Sent: Monday, July 28, 2025 9:03 PM
> > On Fri, Jul 18, 2025 at 07:05:58PM +0200, Christoph Niedermaier wrote:
> >=20
> >> Add the "-l" parameter to the "env select" command to print the availa=
ble
> >> environment targets, convert all argument parsing in the file nvedit.c=
 to
> >> getopt() and check that with unit tests.
> >>
> >> The first patch converts the parsing of arguments to getopt() for all =
env
> >> commands. The second one avoids stopping unit test on console output
> >> "## Error: ". The third one adds unit tests for checking the env comma=
nd.
> >> These were used to check the env commands before and after the convers=
ion.
> >> The fourth patch adds the actual new parameter "-l" for the "env selec=
t"
> >> command.
> >>
> >> Christoph Niedermaier (3):
> >>   cmd: nvedit: Convert the parsing of arguments to getopt()
> >>   test/py: Avoid stopping the test on console output "## Error: "
> >>   test: cmd: nvedit: Add basic unit tests
> >>   cmd: env: select: Add output for available environment targets
> >=20
> > I'm sorry, but it seems like a lot of the tests fail in CI?
> > https://source.denx.de/u-boot/u-boot/-/jobs/1209804
> > https://source.denx.de/u-boot/u-boot/-/jobs/1209794
> > For example.
>=20
> I think I fixed my test, but broke other tests in the process.
> I'm very sorry. I will try to fix the problem, but it is difficult
> to reproduce the entire CI locally. I will try my best, sorry again.

You can trigger CI runs too via GitHub / Azure, BTW:
https://docs.u-boot.org/en/latest/develop/ci_testing.html

--=20
Tom

--l/JxzhSs1pBwXto9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIuUTgAKCRAr4qD1Cr/k
CopRAP4g4k7VtinvdDyQb6csBQ2MWMip0F3aYNpPWucF0J3QRAD+LplWMBXgXgrm
qDOItq17y/kMWO6YG1hI877mh2h6bAE=
=VJ9Y
-----END PGP SIGNATURE-----

--l/JxzhSs1pBwXto9--
