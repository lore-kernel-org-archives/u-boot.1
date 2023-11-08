Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F99FC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 22:57:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53DF4870DD;
	Wed,  8 Nov 2023 23:57:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UnHEmVoX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE92487033; Wed,  8 Nov 2023 23:57:05 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B56AC8712D
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 23:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a7b3d33663so3006257b3.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 14:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699484222; x=1700089022; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vTcs1RDOCNYeyDqbF5I2plwyy/2yxkIKBjR7yek86FE=;
 b=UnHEmVoX7NnasbbV9VRPl28ULiEBWkz7fWlJyOiewf4+e/dv7KMzhgfVVecb/mumNq
 3lvL5ewIAVIAwL834iapQoRjEPdOztxGefcNGwESqOmT0tAaRL8wL+sQ8zR3AlNlrRsK
 KeTuaU2FyCt2cV1vhUXCEI0RCl/1jjGodQz4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699484222; x=1700089022;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vTcs1RDOCNYeyDqbF5I2plwyy/2yxkIKBjR7yek86FE=;
 b=l6DqkSyb6808Jzdjr6G95gqUYFMlLlBL0Wf7weFgIQ17JcMU+A+wiQ/M6xaFLbNryK
 RfJLvDITfb/tAm2KXmY/Eb5wEIFVJaC55YadZ+R4Z7H0TFcYqcw6LfzTmUh/wQNDyalw
 eYaxva/yyc5ShgPsRoplPEDf6uIMDRM+C3qyKPm7oCpH9CL2X93DI9ld7quowGUTvSsm
 IAvZNJRUb822suBT81lL5cuqX5xk2CEEUWYRZ9JtKGBRdPjLBIzhaRhVgkjHJ4RL8+Al
 F3O7Na/sHpsL3aTrLv4osqlEq2AmBInR0BF1+Dxmwg2ksfzWu5KRXOv0BqkpayrIO3hg
 x5kA==
X-Gm-Message-State: AOJu0YzLZGK14Vs7nURWen/+RKC1sDdOfponG9b+avPe+DrN3h9dhNLA
 JUkk6sslSc4tItJHgfAtiOfrfg==
X-Google-Smtp-Source: AGHT+IGPK9Pp/y7nEHnLWDPAlL9PEy8HxtF+lXFx43QEma21evhuk1ORxrgx1sHAxErwxTm5imYfew==
X-Received: by 2002:a0d:e543:0:b0:5a7:bd2b:d4ec with SMTP id
 o64-20020a0de543000000b005a7bd2bd4ecmr3118559ywe.3.1699484222383; 
 Wed, 08 Nov 2023 14:57:02 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 nd10-20020a056214420a00b0066d0ab215b5sm1541591qvb.13.2023.11.08.14.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 14:57:01 -0800 (PST)
Date: Wed, 8 Nov 2023 17:56:59 -0500
From: Tom Rini <trini@konsulko.com>
To: Francis Laniel <francis.laniel@amarulasolutions.com>
Cc: u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v11 24/24] DO NOT MERGE: ci: Build the world in any case.
Message-ID: <20231108225659.GW6601@bill-the-cat>
References: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
 <20231107214121.132079-25-francis.laniel@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QO0dwM6iPgE+eEP+"
Content-Disposition: inline
In-Reply-To: <20231107214121.132079-25-francis.laniel@amarulasolutions.com>
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


--QO0dwM6iPgE+eEP+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 11:41:21PM +0200, Francis Laniel wrote:

> The CI can fails previously for reasons which are not tied to hush 2021.
> Let's build the world in any case to check everything is OK there too.
>=20
> Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
> ---
>  .azure-pipelines.yml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index d6f3fa423c..4eaf0e9062 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -469,6 +469,7 @@ stages:
>          retryCountOnTaskFailure: 2 # QEMU may be too slow, etc.
> =20
>  - stage: world_build
> +  condition: always()
>    jobs:
>    - job: build_the_world
>      timeoutInMinutes: 0 # Use the maximum allowed

I _think_ this patch can just be dropped from your series as well at
this point. Azure now has some automatic retry logic that catches most
of the cases of when the job fails but it's not our codebase that caused
the problem and it's something transient to the CI hosts/etc.

--=20
Tom

--QO0dwM6iPgE+eEP+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVMEjQACgkQFHw5/5Y0
tyyamQv+Kn7DzZCrlg4unrNVrrrxBF9xV06rBhVryjEh3TxWqqIthRWv9Tavw6Rh
W4DbxmVDegGatmkDfFq0fXd/aHJxo9glwgiL/yO8mLIeFvUDdWIICjkQH7stGQnb
YM8m6kDQvoY5z/tZPrq8H7hc5tSKSlawBQmqbRoqei6Nxace5TuQv5M9Ev8ubl7s
6b7fvNS4ZzzSQ4GMLQko905aLLwdOVGGChEERgI+HEkkWs1ts8Ki2Gy+YQL+vaDj
755Z1NAG9OKq9+M/dmbC79eKCxxf6gv9qgAGEu9I78vVaS7hb7iuHfBayblqptUd
/UJf8xJ89TtcjMsCr+nDBVcrxFPfuvSzIhYbtOhb5j/e+TK+Qq8NWn3HeQTJsMca
12oA+umJnArwR+fPuiAtKJP5oApoGcjtR7hm9jIpIqowl+VrY9lb2hT6RGM/Iwik
quPX2cvi4PKYkLZEp/kT2iq0wvfgIMgIjlfr2iaprAKQ7BqjZBNJnqOipNaaf8pz
DZcMXU84
=rwDo
-----END PGP SIGNATURE-----

--QO0dwM6iPgE+eEP+--
