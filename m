Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21632C83F26
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 19:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A37182E52;
	Mon, 28 Jul 2025 21:03:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SN9+y0EL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1474482EB8; Mon, 28 Jul 2025 21:03:29 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85CA882CFA
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 21:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-73e7bb65255so3117621a34.0
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 12:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753729404; x=1754334204; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ap8BmSSX/bM7SCkFpZjXa/fWqjKynspfPyaeUiebX7Q=;
 b=SN9+y0ELpP/DsLN4jnJsHSeWzI4aZzjgvE0ATDeFGFkRlZAuuhxNUqjdqhZau4VZFP
 /9Mf8qQ4DMTCzSAQa1X1nYrEbi3oDf5+lmttWIW3Nb48IrAtDWZxCfE6fqljEBQpL8u+
 G6dJcgHhlq/0MSnIAq3JaNjcm1UcfZcEzXnAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753729404; x=1754334204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ap8BmSSX/bM7SCkFpZjXa/fWqjKynspfPyaeUiebX7Q=;
 b=J6pUr043BPUVvPIqlE/AC5YZpDev2F/CvIw7HvlTtT0Wi3cittbNZZ+gNsdYJajdLc
 oLCA1NUha+wXlpiAipkAiJawl5A1L9ec0u5FULcJmHAIbNbMbzQw8xT5IoSn+LMlsVm0
 /gA09InvxDwBtZ4bGnkQhMUwfZNzywmM/2o52oMHS/2EOqpfpFW3K6iVGb4ilopA7UsH
 1TrDjV5RSAVOq2RDv6qrbhUifO6sfSGh2CE0Vv9etnx1zMv397JKgvLHI7f6EXNZUaIA
 4XHbT2fWVV3roS8EAfYFOZJqsAQjzllV0I/IKNN+gyQ6IFWOcTa+BTS7cjVYlWWqeXab
 9VEQ==
X-Gm-Message-State: AOJu0YyBQXIcBl6oiVpJ6VJ5Cw5AZp+keCychzzXuQeRIiHnY83kWlYB
 kz5tQh+VTGtERTQBBd78pf+6fnZnuGT9Cq7VJASIBFiNjNjTmquqPUctbSZUWKK27Jk=
X-Gm-Gg: ASbGncuyBiupSudo6liR7SwbQYPvRI8KxpmwcmdaZ/1WrEJw73PEYsZS6tjLB/mNV7D
 RvGTO7U+XdUmAvaPz8bI5YkePp5iGTqEG3kQt7G56ZlpyY0wjlpxOwH2zLiKDnaVcREpEW4i4nX
 ZeRHSXq4aXc69Azey5MwazwPK2336sEs9tEs5ipuYqPyx8nJ5bR+5BUnfzdBAl2BNTkT7T/0tjq
 zZkZtJ8XFhcprtW0FPT0ywwoNWhF0EjUGl3F9XDnqc44J3zNldMIvZY/6lMP+ALT7sLsqIdXLIo
 8klXSscUfuM8nB6jULCt96YsqnwOawlP3uh5HyP7muMiH9rVw72UVX+tJg73dU7LQ9Lry0ag+mO
 JrHUAieMy+XjIXrMwd1Zn+6vtXA088D2JnZDdjfoYpVFYv2WXAzWieSLU
X-Google-Smtp-Source: AGHT+IHAbAb8kqkB2Tbk7559qtYVVQ6U7UqcvrjUXQsNvoE3/ZYjcFXjJRNzyGjOIvlVGUAPV5lgxQ==
X-Received: by 2002:a05:6808:250c:b0:41c:2a71:86e6 with SMTP id
 5614622812f47-42bb83a38e6mr8301706b6e.10.1753729404197; 
 Mon, 28 Jul 2025 12:03:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-42c7d8b7ee8sm1238282b6e.34.2025.07.28.12.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 12:03:23 -0700 (PDT)
Date: Mon, 28 Jul 2025 13:03:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: u-boot@lists.denx.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <20250728190320.GA1732232@bill-the-cat>
References: <20250718170602.10746-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fJklBLdbdT+3WEgN"
Content-Disposition: inline
In-Reply-To: <20250718170602.10746-1-cniedermaier@dh-electronics.com>
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


--fJklBLdbdT+3WEgN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 07:05:58PM +0200, Christoph Niedermaier wrote:

> Add the "-l" parameter to the "env select" command to print the available
> environment targets, convert all argument parsing in the file nvedit.c to
> getopt() and check that with unit tests.
>=20
> The first patch converts the parsing of arguments to getopt() for all env
> commands. The second one avoids stopping unit test on console output
> "## Error: ". The third one adds unit tests for checking the env command.
> These were used to check the env commands before and after the conversion.
> The fourth patch adds the actual new parameter "-l" for the "env select"
> command.
>=20
> Christoph Niedermaier (3):
>   cmd: nvedit: Convert the parsing of arguments to getopt()
>   test/py: Avoid stopping the test on console output "## Error: "
>   test: cmd: nvedit: Add basic unit tests
>   cmd: env: select: Add output for available environment targets

I'm sorry, but it seems like a lot of the tests fail in CI?
https://source.denx.de/u-boot/u-boot/-/jobs/1209804
https://source.denx.de/u-boot/u-boot/-/jobs/1209794
For example.

--=20
Tom

--fJklBLdbdT+3WEgN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIfJdQAKCRAr4qD1Cr/k
CtoJAP9/Y2QFoJKiJhD+ymdll85X9CrZXuvADxRgdXC+j7FoOwD9Fp25Pc1g/XGb
xU05x974MjfveGznnmcoPHM1PTCxOAQ=
=ULGg
-----END PGP SIGNATURE-----

--fJklBLdbdT+3WEgN--
