Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4403ED59D7F
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 23:00:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01D2389A18;
	Tue, 26 Nov 2024 00:00:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R1GxWxBx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E98ED8975D; Tue, 26 Nov 2024 00:00:18 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A07BB89A13
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 00:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-466a0ac9211so5435771cf.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 15:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732575614; x=1733180414; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OHg3aLC6NoNxO6gBoQTDTGRv9QfoWnhcKc/5eeq1koU=;
 b=R1GxWxBxlI73D3UVEtX8D/BHCWVKcoQgLkPmo7L4ckM+cN1vMPc/KY4r7Fqc6qtPef
 +BXjw6iuNj7FWFDoMOnyLjshnR/lVSLubV/Wv8dEqhNfGngp81GVYt4mSSJoqR+AP3gB
 Xw063/ohXO7ddKr/pn3B3ppbUdlka+7DRx8Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732575614; x=1733180414;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OHg3aLC6NoNxO6gBoQTDTGRv9QfoWnhcKc/5eeq1koU=;
 b=c2/Q0EFQqxhFwFW/EB5pIuPUAPTK6HprTBqVDPBla4DGZlH+P62h44HPWU1dicxqqZ
 EtzUvhQEY9OLI9ndyj+XxZzlXbIKnqG0jLgi8VwxIM9NBkZt6a1MDQZSoo+gp8KU9Hln
 +bRAZ1aEGr6MCyv6qufuYhSVWcJDQ5CR2OfjbZ7aG3sVK+NlCqymJHsDhuWo+Z7anKDj
 B9yqMK2SU+5IKSiADG70yakqZDMRpQHWPEEc2SZ+duNLRxkwe8mTeGutbtmQlg4gLM7R
 LpVtcXj2wa4/Hn0Kq7yrAXrq2b6HW73hcHEXj91JcWssZDiIHaWmaWU5DI9RkoZGDwHE
 1L5Q==
X-Gm-Message-State: AOJu0YwTSAzGoJ6+Q5BDWCLA5kw//4T+XgHI9/ORT6exbpzm3yKD0fi/
 NMwdQ0D0mGja2nWkagvroM+hbWdQI4ct2mMf/o4AKeVbQIrQL7TSIn6lxGihRUzmuekcLZLu8nU
 3oT8=
X-Gm-Gg: ASbGncu4OnOJEtYWFk84I5zZljIXs8nJvnrNBXDYvVM97AHm7yFlWdW9hkmOZqK1yRE
 1QUb4H4MAtL9p3B6+h4puajQziEcL1W523OHUWhx5VqprSYtXL72rHzseEpugSsYt70qDWZY589
 8rON7Ni6FT2FpYlL0wVKG89oGGghQhFgSZ7qM+kWyJTBabuQEbsIMHkPPSHbW839G2W5gAZGZGY
 vBb3fQzAbN3hY+26zDeg2jXM4tl9tjihcMowYvwzXHwD8iqHw==
X-Google-Smtp-Source: AGHT+IGBdaWo0YvF5LcsA7g0TarUVMp6TJwsEiUseBBCTQKC/LpH1aNpmux6KlrTciS6/rTzA+5Wbw==
X-Received: by 2002:a05:622a:90c:b0:463:5344:b9a3 with SMTP id
 d75a77b69052e-4653d5ae3e9mr209302531cf.25.1732575614208; 
 Mon, 25 Nov 2024 15:00:14 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4653c47f065sm51282841cf.61.2024.11.25.15.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 15:00:13 -0800 (PST)
Date: Mon, 25 Nov 2024 17:00:10 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.01-rc3 released
Message-ID: <20241125230010.GP3600562@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="boymTQnZmqtiZrSi"
Content-Disposition: inline
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


--boymTQnZmqtiZrSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Once again it's release day and so here's v2025.01-rc3 and I'll update
the -next branch soon.

At this point, the biggest outstanding changes I see are what fixes are
still requires to the spi subsystem to bring spi-nor functionality back
in to line with v2024.10, and what further cleanups are needed to lwIP
or LMB now and shouldn't wait until v2025.04.

In terms of a changelog,=20
git log --merges v2025.01-rc2..v2025.01-rc3
As always, more details in pull requests (or the tags referenced by
them) will result in more details here.

I continue to plan to do an rc release every two weeks with the exception
of I'm also doing -rc6 on Monday, December 30th to have one more tag
over the end of year holidays, to see if that helps with people finding
time to test.  We'll how that went in January.

Thanks all!

--=20
Tom

--boymTQnZmqtiZrSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdFAXoACgkQFHw5/5Y0
tywEKQv+Pdh+btXhB21AbQiqjBVrBWsrD1j12y3C09VLZfbXH+zBUAHnKqrhtP1M
T/ZWhYGBfcyUVWZYTkyxA+mlM6JNgdIM0O9betH1jhDctidME/kjXXn5TDdktH4f
HsF2jDHliuCStLLSK9a/kpaSWLuvdvt8F0vMqK8UmpLT47VPsTwekSFDfuqYL/Xs
OAJORNjBCrIjSaXeo36gomswDF/YiWvmtkxIn6ZOqXLzltfba/wzIVJIvI+0oWRm
uqw8EEBlKiJOq7JrZx6JrVoLc2wfz8B0d6lwRMorWS1ZwYI25vcRXKe8gkwHDqLA
paGh5uZf0EvQVjXjajf0EvGW+JTIX3JccxtR8NCwa2iwPK7My2rteKzrCLkwOTjH
UiL2CBFJZBCeCyoEunxFBw0GRnSPgmMj7SMjBBKXjMLWiw1V3r4si5xXn4/1qoyI
TjDhSBfrraV8xd13fCKlDnj8KDPbR6zFgXhLeGruFOsYEsKcgmq3yOByRVJNciQo
jTXKsW+M
=LvVI
-----END PGP SIGNATURE-----

--boymTQnZmqtiZrSi--
