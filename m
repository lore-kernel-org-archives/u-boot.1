Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B8CC282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 13:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9B0B8144F;
	Mon, 10 Mar 2025 14:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IV8dV+9i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE25881703; Mon, 10 Mar 2025 14:56:04 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B2888141D
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 14:56:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2240b4de12bso68198055ad.2
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 06:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741614961; x=1742219761; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9rj1laawougBTViAuEEsATeo1cYVbI6lIsgSPR2Wo0s=;
 b=IV8dV+9iptuQ0oGtXQNeNDV+whZzu3xJuHZDu+z/KCA12c8yFR+GPVs9DNvNQLqpLU
 DvVtzNq2nwVF3vr6tObABd7f9JU0x39MFxFY7IbGmflzHoBkfESn6kFl3PFgU+zUANfW
 H3dq5R4LEG9ay2WFsR/QP4zywta8NwaMLqwEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741614961; x=1742219761;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9rj1laawougBTViAuEEsATeo1cYVbI6lIsgSPR2Wo0s=;
 b=HJr9/j9EzJewAOPuFOyA5v2Kr9my2Q9GGWPbPC8fxGNCrRstjEHhxGAKaQFOhdtlwg
 n+bdJ+pGPNP8wPOAKfqzzcLi0pJU/R24YDtau0y0bqcwnHVOA4qL7e9S2JU3oKIX14Kh
 h5QwiMUcLbgyYHohoEusb8TXEkgKAbJAZKgjSC4YxyaQHFy6I2N+y3VXN9eZBie/BIzv
 yehpZWXqF/N9qp/0OamhGjjRf436SYsb6+k85/u+Xd4Qab7Kf3Drw1+lkfQysF5Mfhu/
 FPXDfgfoqIYWyGJY3QRbg9Eq53S8Mt9A0Zz5a5n94fvS3yI6TSBsPBfv7MwhZ2wy1th9
 nkRQ==
X-Gm-Message-State: AOJu0YwOjhOzqSJA3MN1/kBqxyf9u7gKV2PEZ99dl71OKf6S6NK1u72I
 uhiwAsI2jRqkl4+KrLeYYDueRVTVZy15Alb78FZkDzc073hRBSMCYqMThPw0CI1N+lbNOYa/5e4
 T
X-Gm-Gg: ASbGncuZAiGn+EZe6GdIRJ8UAQZwrgymYW24/y4wOiA0AWghtIe64tGKZlA6oQDeuPC
 MKfTHL7iN67EEUFhwA07Jy29ISQjT3RUlz/M2jceuyWgOU9AsgCCG1VBhw2ggzYd4DlZuiWWdU6
 8JdiyVSw/mhN5bL7un54nfmcN7K/rI64kdzrQp5aYsFWkao2AY8WxUzsKtWifMR0fMVqv0e4we+
 0HHtjYebty8cOfL9zGcYqv9tVNmRllOpy6HkN3nZD7Pj3Kky2CeDo94HM7HblV9pkRfS3+MtpLQ
 pbU9YZ04UTOIczGhlfIkucpCJaiAGXj+E5gSYe9kkwDImQ==
X-Google-Smtp-Source: AGHT+IG0xqIjMsKZyizowsWlZ6PPN0Nw+oZyz6QwmSraseHm1uIJN5zy7E7Y4l2h2UXiOehkSMjBiA==
X-Received: by 2002:a17:902:fc48:b0:215:7421:262 with SMTP id
 d9443c01a7336-2242888a6a1mr248344265ad.12.1741614960998; 
 Mon, 10 Mar 2025 06:56:00 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a7f700sm78221455ad.144.2025.03.10.06.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 06:56:00 -0700 (PDT)
Date: Mon, 10 Mar 2025 07:55:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 11/12] pytest: requirements.txt: Include setuptools
Message-ID: <20250310135557.GW2640854@bill-the-cat>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-12-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZbyXdVAteI6bI9S0"
Content-Disposition: inline
In-Reply-To: <20250308201533.1315951-12-marex@denx.de>
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


--ZbyXdVAteI6bI9S0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 08, 2025 at 09:12:15PM +0100, Marek Vasut wrote:

> This seems to be needed for filesystem tests at least on
> ubuntu 22.04 machines. Add setuptools into requirements.txt .
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Hiago De Franco <hiago.franco@toradex.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Nam Cao <namcao@linutronix.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  test/py/requirements.txt | 1 +
>  1 file changed, 1 insertion(+)

This belongs in the requirements.txt for the tool that requires
setuptools, not pytest. It's also listed as a required host tool /
package in doc/builds/gcc.rst. Having just re-created the
requirements.txt file, I don't want to add things that will get dropped
again the next time.

--=20
Tom

--ZbyXdVAteI6bI9S0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfO720ACgkQFHw5/5Y0
tyx2PQv/a+4LMvhVI9dkT7nU5/9Kf5He3Il2BjgmfWo5qGEKW9TSt9xJf0q7IlIy
V8f154Z6VXoFtVuOcxe7YIzJsqxy3JVgFYlgn+seUmifxFRy0UPAPNuLYfEEBzF4
4+LTBLBWLvQm7FPPH06rSldEELCE12USzGm/TFlTrS8J8tymyVTC4FTt4+5abpv5
3eylxD4f70w9K8wmIc0nuVERZOYUzx8VGdWGfVboCHRkrvHlaBrKLQcTHwJAp2QF
idq/3+toyn4GqPsimYIKqp92AncSi04tjb9+uWt+nJ5zifC1xkvIhVE9F8VYM3LM
/fpoqu+IvuMfjqcxp85qfKxqmommCVbW0A8H3Jvf4Mla47ghbv8Q+VU/CpxZUhi5
WpmZkpR0efQaVV1RdnAM7CYULviFUoeInIbFeK3rRfIW5p3cMAxiAL5RiHAn6pVd
unhBf1U0wu0Q9dSiQGs5j3i6abwu8o5gISHuOX4wIOL/+kccrbqaGLgFdl2oR6WC
bpjP1oPG
=Miqr
-----END PGP SIGNATURE-----

--ZbyXdVAteI6bI9S0--
