Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BC0C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 22:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 628858754B;
	Sat,  9 Dec 2023 23:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TL53qQqW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F240D8761B; Sat,  9 Dec 2023 23:03:55 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C761A87517
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 23:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6d9f8578932so975427a34.2
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 14:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702159432; x=1702764232; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BWUJqCSblUtW06vbd0AS0H2nsiI0FW29XnOoGEwUdJA=;
 b=TL53qQqW6bjcEPjbf6rKABcytwSH/cBPNDftUD1RC+nkZjXSHbtpmVl+yKAzR0gdsR
 vEO5gJmTsOCpMNiRJDADOseuILe/OWhGwP+6LO12sM4rULrtePwEHh0Ea5dVApW94VgH
 O2jhAsNB2IzeYXfcpUmgLlQej6snh9dpkBBZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702159432; x=1702764232;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWUJqCSblUtW06vbd0AS0H2nsiI0FW29XnOoGEwUdJA=;
 b=JULvO8rRtfzubgsPVnnUZZjGMeNdEazLIlEs1skg860BBSZICiwgMlUsQDpVo4OZgq
 Roy1ZAaS7nCINBRuMsLkgxSINBJrHwEicW8zo1yt2MjLgRntEtQ6ACtAjCrPJPs0sdED
 u1gFMpU32sHYUPp3Q1s0lQNHbVY7WevjUtDziy3qex8PmHAyUhYd80LgTsk8s7q78zWS
 fGeXuvjrIfEP7/70B8sopDFExMaWqhiz6pUQwcF+YH7kV5iixLQ5lrWq8jdTZPn8TzNX
 T3kpsHFvkCyHfRuEeOLrKq8z0oMubHwtGh3Ro/lMVLmsvtOBULnk6n3lEBlBmzIdKnfv
 r7nQ==
X-Gm-Message-State: AOJu0Yx03wcCfngR2oIzFbgVrJB5oHuP7cJhm5SvMK5bxv+EQ+alNZFQ
 NqWCh3aMZ/il4fn09MRfceKoQQ==
X-Google-Smtp-Source: AGHT+IEHhLg+MGVQhQjf8Q6ZFbP+yq9XdkipgCLp8EdtXJ+FBodToXtSyR9HGlcY/wLe3cdeFkuzPg==
X-Received: by 2002:a9d:7981:0:b0:6d8:5421:1e0c with SMTP id
 h1-20020a9d7981000000b006d854211e0cmr2317374otm.34.1702159432327; 
 Sat, 09 Dec 2023 14:03:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8dee-9b11-e8b3-3204.res6.spectrum.com.
 [2603:6081:7b00:6400:8dee:9b11:e8b3:3204])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a0de701000000b005cb1bf4d466sm1765692ywe.82.2023.12.09.14.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 14:03:51 -0800 (PST)
Date: Sat, 9 Dec 2023 17:03:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 conor+dt@kernel.org, Caleb Connolly <caleb.connolly@linaro.org>,
 neil.armstrong@linaro.org, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Boot Architecture Mailman List <boot-architecture@lists.linaro.org>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
Message-ID: <20231209220349.GM2513409@bill-the-cat>
References: <20231122140100.GT2513409@bill-the-cat>
 <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
 <20231122142758.GU2513409@bill-the-cat>
 <c47b163b-d0d9-4de6-8ea8-ebe884b28e4b@linaro.org>
 <CAFA6WYO_Dk+7FWDGjUdDub27YCwVKRjS+vZfMrT8otjvv-QO_Q@mail.gmail.com>
 <22b2c2e2-9ce1-4a5f-8cda-565184eec120@linaro.org>
 <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
 <CAFA6WYMeg6B7Ozb42u79U43=26JmK3CaxfO29uuqQnGipFowEA@mail.gmail.com>
 <20231130143512.GQ2513409@bill-the-cat>
 <CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bMYqinvgNj0S7H9s"
Content-Disposition: inline
In-Reply-To: <CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com>
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


--bMYqinvgNj0S7H9s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 11:02:57AM +0530, Sumit Garg wrote:

[snip]
> But currently u-boot doesn't have a proper way to validate those DTS
> against DT bindings (maintained in Linux kernel). Although there are
> Devicetree schema tools available here [2], there isn't a versioned
> release package of DT bindings which one should use to validate DTS
> files.

I will have more / other things to say but I want to chime in here. That
U-Boot cannot validate the DTS files is a bug, not a feature. I would
very much appreciate if someone(s) with time and skills to do so would
re-sync us with the kernel Kbuild again so that we can both stay in sync
again and have the validation targets / functionality available here
too.

--=20
Tom

--bMYqinvgNj0S7H9s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV05EIACgkQFHw5/5Y0
tyyaVwv/T4uCG1TzBf/sYW3PKZLrw2tCrXqlScrZqpgFnp3XqELqS4nswQlyS0E5
np6apeN6Sq3NKiYsK53KfcNJBvvZFRy4YAu3BEbgV3/R1DuUHWX5oRteKESd1nLU
xt7zpEzzVd79YUnlC3YkySXbXDAfx/soODDQNeYhz2wnX+OF1oclWcQWaapkr1Lz
eZ/omBmqR2SMD8nQpKzVXfh+RL9vl6sSDHnsyPn/Cjn7tiVR9GrAciehLHE7g7vJ
nOcbVdNHPWjCw88jo9tYDQfeGc7VQl+H/8rfA1HSackDoro6NrYWm3QYEAAfndKl
zRI0G1/ZtmpyfEOjOKQiRC/Dmrc6dZHyzPSpNouAKSglKNoYh+wQ7uOFS0bkOyWz
tPtU5WdlyemhabNaLCICjCIbi12VeQlnPqSarm1sNsF64HDhkoYB9GoBe94mDUqW
0pMgV8S1c9CxoG6CYbG50pHlWb4cnc9/Yo/3+O89LHBwjBvPzirSpJ4myh2Gcjsa
xrX7ik5q
=MOCH
-----END PGP SIGNATURE-----

--bMYqinvgNj0S7H9s--
