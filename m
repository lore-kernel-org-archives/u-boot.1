Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570C5C25B46
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 16:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A06A8794F;
	Mon, 23 Oct 2023 18:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hK52IQU6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A17598794E; Mon, 23 Oct 2023 18:59:15 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 514C087952
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 18:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a8ee23f043so36798037b3.3
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698080352; x=1698685152; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=crZDCoG0PYXpoSnIUgc6dcQvAGxSOwG7bU0W4nH1aqs=;
 b=hK52IQU6adqZ+s6fZg3zTODzzs/VEE+1iCXzmkCJ1esiJEFdaWmWah+vTwPjFWt6YB
 HpsKhAGO6/TANbex/QKdfiERMlh8/YqSs8Y12d1g00SF5URU5xgmTqL9ECsI0hJ7VyIV
 Qb09qLQXnJIo/SWNrNF4ZGtOxoWuG/IuE9baU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698080352; x=1698685152;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=crZDCoG0PYXpoSnIUgc6dcQvAGxSOwG7bU0W4nH1aqs=;
 b=XVSMDZ/MwV2beb6p9NkA48cF3LWX86IANMwjfTmzR3hlJfeLc1rUMPV288nQtxPVAB
 lL69Cu6tNHFb7hHn0biIb8ZbXD665n4G/PZIMzNL5ahj57taMIgMgDdDVWa9XwNQMLFk
 0rUUsvQyRFaEzOXM6fBl1mvwEQSSo+UzHIpHNcPGxPU2WFzQb/KWmqHYx5szzPhsN0rw
 XOdSh7RSjzDgh/KkQJ2WLVX2tRNRZ8iBynamHjLbR7/wCsUQpCXNDZUj5cvhl9Ttu4pV
 zXzxwLu52cEaErxD8b2CIKq8L4LO6vVRGgDepyCcgWyNmY4p71s1LhQYW4hJwVcxnN46
 dkrA==
X-Gm-Message-State: AOJu0YxMqe9xBTqzw7DYzFRq+RMyle9jX/DeDM4NSyGyIGUU/3UDvQI9
 YaXfhdijNu0H8rtJcklaxtxWD57+UAUMBTFIap89FQ==
X-Google-Smtp-Source: AGHT+IHgMVolhlSg1h9OgTz/L//Okc1ElE7v4tETp5t8odH4UCFdmXbIzi5xiglK6A3Yo5OHk6cDQA==
X-Received: by 2002:a05:690c:fc4:b0:5a7:bff2:12fd with SMTP id
 dg4-20020a05690c0fc400b005a7bff212fdmr11372202ywb.10.1698080351790; 
 Mon, 23 Oct 2023 09:59:11 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 b72-20020a0dd94b000000b00592548b2c47sm3294391ywe.80.2023.10.23.09.59.11
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 09:59:11 -0700 (PDT)
Date: Mon, 23 Oct 2023 12:59:09 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] CI: Re-enable maintainer check
Message-ID: <20231023165909.GS496310@bill-the-cat>
References: <20231023153747.1967540-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hVxJrUR93Xjw3dcR"
Content-Disposition: inline
In-Reply-To: <20231023153747.1967540-1-trini@konsulko.com>
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


--hVxJrUR93Xjw3dcR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 11:37:47AM -0400, Tom Rini wrote:

> At this point we have all of the defconfigs maintained again, so
> re-enable the check to prevent further regressions.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--hVxJrUR93Xjw3dcR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU2pl0ACgkQFHw5/5Y0
tywoPwv8CjO00uuGlU4k3HzbCJkvqeFm7k3lZLlGapgfQyLT3tDqB3YrpmN8alui
zbjX4nzMRCqsKD8x038xIiUd0VXAzFedvEAJzEFoK83HflxlDfrbIdVGcds5nv5L
kLXlA+xIslabKcvHTgx4uYWuyBPvS+pg9Pu+iDK4GN01Y/hyBotQVEtOVjy1SLNB
NlQ9xxGTitOpVqUIIeXe4wSKu6bjpEHG/5JC0fIHgw381ezNcaIc7AjXD69nspLb
koojGL7fdZl3R8KzySAo6VFYDIPpz5Jkegv4wpKe5zTSwjNrD1ttwR6vbw/yt/bz
RJHOqSlv1LmBjB1V5zAoAsy6PSES9U3l27aUKogEGtK5K3qcCNw5iLjia7Duzaue
63NgqDvmn6aOAmNJX49eXxcym7Z9F9+gYhyEv/4nB11iAPcZKoZygLI1wPswSYGX
ABqpQ9VaWwswKN7DtvFQIjRX7jNCfcG8zEr/OFbVPZahYmACT4OPIXbhyeSV9mLA
e2SqpRx1
=yR1m
-----END PGP SIGNATURE-----

--hVxJrUR93Xjw3dcR--
