Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7142D216BB
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 14:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CEDC88606;
	Tue, 15 Oct 2024 16:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QEu3qdDf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F3F488606; Tue, 15 Oct 2024 16:38:45 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 289BA8880B
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 16:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbd092f7f0so37300986d6.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 07:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729003121; x=1729607921; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CLZ9x7PvrDIuGMJXxDOklvsfmsNgyLlHdf7AqJsdqzo=;
 b=QEu3qdDfSNs4lA0mraatMvlRl9cLsxPQq0ds+kz9alUy0VhEsN4RHTR2bV5cDpur75
 W16O9M0cXHITS11ueoXwkC/r65pqqLJ5NoCS0+3AQnuXR97LuwTUKo8ii3Pf8eFJ0nKk
 AdgiXbF6BOPD9IcWjTnM1NGucZSt9T3HOMf1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729003121; x=1729607921;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CLZ9x7PvrDIuGMJXxDOklvsfmsNgyLlHdf7AqJsdqzo=;
 b=SPq7PDnJJWCtwtyWwRuGt9XVaJ3XdvXzELmcQIGEz7xEWtY/YbCxfJhAo8RWOyDy9j
 OtscMInNcVLgy1E6dxH/WLtbNk+mxL/cx5HCC+fB5kDnYPDrgshG6Hv8csCrJmPsaALY
 3/UHX5YihGXzN56OfjUwwy6j8i70CsxOSlv0pvbtvtcvDtWztJdWJ5NSyRkb6haH8x2J
 ULDP7+CWRnj/jVvdr53xR91qv+11sQf5VMKUU8Z1PLXSXRG/o08CRUtdaW9Kkew1V3/2
 T3qmoNLRDeI2f5KLJ3XkDgPiU6bvBzebuFpWXX9gewlz0767yBgsZTUkYaWygwZs+ma2
 BdIg==
X-Gm-Message-State: AOJu0YzRakZkBxm+YLMWTr2h1Q2N74IEZZOTHo9xUMqIxhZM1njvNNGZ
 KIZZgPMD0ffRE9+LO92ZKLtpmsbkrr5osc7ewQ883kSvabCjz89r8tBpzpwGGTk=
X-Google-Smtp-Source: AGHT+IEVfW5rKXkP9Fc2XDHqHAWiJXdHG8X+iMgIqb8XccUvX6DwcRkfKzfvc/Wpe2Y0aoS7kKjf3g==
X-Received: by 2002:a05:6214:5911:b0:6cb:e798:5589 with SMTP id
 6a1803df08f44-6cbf0084ad0mr236863466d6.28.1729003120953; 
 Tue, 15 Oct 2024 07:38:40 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc2292f4cesm7292216d6.71.2024.10.15.07.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:38:40 -0700 (PDT)
Date: Tue, 15 Oct 2024 08:38:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: Re: [PATCH v3 7/7] cmd: Update the meminfo command to show the
 memory map
Message-ID: <20241015143837.GO53053@bill-the-cat>
References: <20241015133304.2874735-1-sjg@chromium.org>
 <20241015133304.2874735-8-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S/9imzslXmD5BkZx"
Content-Disposition: inline
In-Reply-To: <20241015133304.2874735-8-sjg@chromium.org>
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


--S/9imzslXmD5BkZx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 07:33:04AM -0600, Simon Glass wrote:

> U-Boot has a fairly rigid memory map which is normally not visible
> unless debugging is enabled in board_f.c
>=20
> Update the 'meminfo' command to show it. This command does not cover
> arch-specific pieces but gives a good overview of where things are.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Please add dumping the lmb to this command, thanks.

--=20
Tom

--S/9imzslXmD5BkZx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcOfm0ACgkQFHw5/5Y0
tywOEgv9GRX8QHvp6LYSsXs8zgkOJ7W+u4MdLYXG35WHCa6pYlgoARmYrLyjW7Pp
CrNHcQOBfwhOsJ5sPtDS+s5n1rXRXbBcNILopsYp1Jjy/eCt0WnGqL9oP6nf8679
jDC/4PObxpogn3btvGxxP5H9CvmtUXD8iQ2saPOyP3b5IRVOtKVdfOL7f1wtRm6/
28ryIjDWVVzALjriOd81B1EwVSFk2XrBgFshh6ZyD3ckzE5V3W+3sizrVL/ZkF+I
fgvwu8r8ladjKOuT4R2GNtv6rvcfnw5wRYmRkb8M8xU/l5cjTzBfi/Z5UerSbJf/
nQRqfoAx7be6m3U9GlY0Zgn7aKKbXdEk6g4xUfFaW9D21cO3tPelhxrcYAekSCvX
SOzKDffyzUrMDlZB3EPYb6wFxs0sQ2koCuQyHXW8vC4n1LtxswYYneTj5XgFb5wn
aZYOdThLy2ePnJR11F3+rjvLW2ai271hChS0bI6iEFlSgQZYhA9DIEjV+LsP3ouI
yMUZhAlU
=pSuN
-----END PGP SIGNATURE-----

--S/9imzslXmD5BkZx--
