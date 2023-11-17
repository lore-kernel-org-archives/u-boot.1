Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95D0C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2272D87525;
	Fri, 17 Nov 2023 14:42:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dtY/6tjY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1F26874D5; Fri, 17 Nov 2023 14:42:56 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AEA9874BF
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:42:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7789a4c01ddso120431585a.1
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228567; x=1700833367; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cA8xhAeqn+SLCdfp8P/2RqiY/TeYYpu7jt4Tr5V2FxA=;
 b=dtY/6tjY247ncO/KDqSU5EBPN1c3/DeVRXMl7rg2dSLqcJOolbV46L1qe3p6fbWsOM
 +4enqh9XZzGISDfy6/xCrIUSE3IK90bQV3CKbgpOKArXNwIv7R6TC1ra7vxKV2rMI0kO
 +eyshkBLJwn45NO5lH14HZjlnvMh+v8uUQvYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228567; x=1700833367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cA8xhAeqn+SLCdfp8P/2RqiY/TeYYpu7jt4Tr5V2FxA=;
 b=p4YaRc3zZQQtWrsDkRfUo1rYg4MQ0aJYPKzDIFaaIENeCo0ofwiBixoI7m0Q+vG7oG
 R7LkpYK7Xnum++RvVC/fBIizB6tjRW5rSzJ0mHhrlpqq9p4aACgjZGoPdwRM2uGdBxKK
 ELgjdL2VWq41wolUYlb9O8eEkeYJyfGCNSVWNu/k/Q2NdMtTBhBf70YFYjX9hIu5Jxsy
 gWnQTK6Yqh5GjVVuePxEr7r/PQFU5rXfsQ6NQLQEmXhg3hPztH3737wmy5IvNetA+6BA
 HXgoJxbh7b9Bm5eFQzjqNFkeK3mG2o3fqcL9rHlzKG05y6pRN+IFwJgY787gEBbL31xv
 bYHw==
X-Gm-Message-State: AOJu0YyFnpyfnDNNJIQltn/TA9y1CX4OxULIR1QSynAirDdyQctqpdyM
 emZf2T1rVT4Bj1KgdssxYPTnMA==
X-Google-Smtp-Source: AGHT+IFXlr4XDlVgVhQN6UbN+m2JOtawxGssK0tOHAzmRjMnLwvh19Biips8OHKGq8ufIx8wZ/WO1A==
X-Received: by 2002:a0c:f908:0:b0:66d:1fcf:e1c9 with SMTP id
 v8-20020a0cf908000000b0066d1fcfe1c9mr11744356qvn.35.1700228567017; 
 Fri, 17 Nov 2023 05:42:47 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 f10-20020ad4558a000000b006655cc8f872sm634569qvx.99.2023.11.17.05.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:42:46 -0800 (PST)
Date: Fri, 17 Nov 2023 08:42:44 -0500
From: Tom Rini <trini@konsulko.com>
To: Dmitrii Merkurev <dimorinny@google.com>
Cc: u-boot@lists.denx.de, rammuthiah@google.com,
 Eugeniu Rosca <erosca@de.adit-jv.com>,
 Ying-Chun Liu <paul.liu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Cody Schuffelen <schuffelen@google.com>
Subject: Re: [PATCH v2 1/2] cmd: bcb: support various block device interfaces
 for BCB command
Message-ID: <20231117134244.GZ170968@bill-the-cat>
References: <20231110055955.3370681-1-dimorinny@google.com>
 <20231110055955.3370681-2-dimorinny@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VzM6pmDv8icYG3+4"
Content-Disposition: inline
In-Reply-To: <20231110055955.3370681-2-dimorinny@google.com>
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


--VzM6pmDv8icYG3+4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 05:59:54AM +0000, Dmitrii Merkurev wrote:

> Currently BCB command-line, C APIs and implementation only
> support MMC interface. Extend it to allow various block
> device interfaces.
>=20
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
> Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Cc: Cody Schuffelen <schuffelen@google.com>
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Applied to u-boot/next, thanks!

--=20
Tom

--VzM6pmDv8icYG3+4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbdQACgkQFHw5/5Y0
tyxDrwv8CHC4h3r7Fgsq+DVtBIULKuH5PPxDWwope0JuS6IGtjMuEdUtdMFF76Pc
m8EN1T+7ZyfDtnBwcJK8CoOSlLGqG9pkj+M+fc9HfCjTKlMlwrZVidkDrN4La/3m
7Kf/r0QaswFoGwAx+hrS98BGSsT5bRgLjWjHRHe8057bsGbNH0Ws4kPzyVgGXUWF
f5BGjYc5clemV8Vc35WjdJC5LHIoBj3T/R07+wKwsrfEnWL5e0S/fN/RHqS5Oyhd
0ZxIoCVNIE6X3YLKfKqWRqqFPPveNrZjwK+hW6Au/71fCZmyp58wgHKvFVZsHsuK
dmnhsXoIEKS6RQ7Mmuh5hptN0lz+Atx7h2XAQJwFv+uz5uESH98i7ChQDM7bDOG1
008laYAmNB5oikB93S91Y9HGtCwdb3gC1JS3CKNphnr3b3fTWDX/XaMF60SpmYrJ
kvYBZ2doIudqTQmgGfWoTPAQvsHG0ereOWGN58Pshouv8deK2T0MVrUh4jG/dUSh
aTojgWUv
=l1/o
-----END PGP SIGNATURE-----

--VzM6pmDv8icYG3+4--
