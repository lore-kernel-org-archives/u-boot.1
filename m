Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17A1E74AC3
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 16:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5095C893DE;
	Tue,  3 Dec 2024 17:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Re6Xfy3w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D0F5893F9; Tue,  3 Dec 2024 17:51:40 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5101E893A9
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 17:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4668978858aso40075781cf.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 08:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733244697; x=1733849497; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NdPUfLdGo2G2vGwpPsLVv7OVvvy9DZ4bK/zxZu0neKQ=;
 b=Re6Xfy3wktQ8SlIWcSMGzIXyWKBA+fTq1KgPiG09EXXrvjhs5IemS11K81Zi5wgpKW
 4FSiw9hYGfa3zJM0i3Eyk9hHyLo65GsHrMREQvHR9589r9f3cd1x4DESDxNnd+Mqzwr7
 27IZGZbxaJaclz8o72HsnZxEi5MzQbG9goXJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733244697; x=1733849497;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NdPUfLdGo2G2vGwpPsLVv7OVvvy9DZ4bK/zxZu0neKQ=;
 b=f81ao9/YsAOaicwg7jjwyim0nE6DlubX+x68/cTUjrJMHc073icUgk81Ruki94T2Wm
 0oDm6vRUmMI6FT8SzcQVvwgqpcfZV8Vnmp0DZHotx3LrTuF+PijiaereEO09BLE4M/hT
 TnSV37Z4GsCYcLWLtuAhfpIPUEMluqC/K4ZdXa7tWmKFc2u4EFd9k1Y/GNs7zaPIO6AH
 f1J9kZaTaYCUus/hlMcCvzCrve7neW5rtOkGD4KbKsaMu1Wzwp6a8LBE4Ha37K0zdent
 IfcgFcobWqX5SPsIW3HcQk7S9PGHIzActox4VyhDJb2ePGzLRvCwOgtzUeJ/NSZi2rGY
 5g0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+yLvoa/3wCpJJjBrIvRlNwt1MYGy4qwskjqwdwSlnYrqTQKZOKtP9o3T4zc+GKy8k9Lh3hKY=@lists.denx.de
X-Gm-Message-State: AOJu0YyAWqt+y2Zfrx7WtaZ9brXKoGquIiv5230pBDq0M4gWqwJi+8Tk
 xoJvngxJiT7ccQEYhrHDdJb4CyWIdu1zawihIv4ZeG93+0DXcnvXfWSyK64Le/g=
X-Gm-Gg: ASbGncvwzRrqAWqOy+i1CRzzREAEXhpOlqYsbRqR/QKDZIziAT3xwT5iTdIYQFuJ4AH
 fpB4v7sCCyp7R2c0cPgPnuak2B2JiXmU2NQyAHhRdR+2k8q3MUinE1NCAH2MSvt89/nZNk4nsi6
 7XEz83qFzLBGo0nVcE1nElO/80xm04+GnGfNVQ31qgNq6Wnd2ORDkxW0xpckVXhntEH75KKtV/S
 /hKxhCcX3iTOH9DizgHGGOrUPHY0L9YxoPnpFVOcR50gV9SkQ==
X-Google-Smtp-Source: AGHT+IFC/nlsRP6GqPvjbKjVotdXnn0OnJpg2+tvd9xVDdce6ddz5RL7yeku9gGFm7zV6b4FhOulcg==
X-Received: by 2002:a05:622a:134e:b0:466:b21a:4788 with SMTP id
 d75a77b69052e-4670c0b5520mr45762941cf.23.1733244697225; 
 Tue, 03 Dec 2024 08:51:37 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6849aaca3sm524913985a.70.2024.12.03.08.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 08:51:35 -0800 (PST)
Date: Tue, 3 Dec 2024 10:51:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sumit Garg <sumit.garg@linaro.org>, mason1920 <mason1920@use.startmail.com>
Subject: Re: [PATCH 4/8] Revert "fdt: Allow the devicetree to come from a
 bloblist"
Message-ID: <20241203165132.GY2457179@bill-the-cat>
References: <20241201144240.1664398-5-sjg@chromium.org>
 <CAEfUkUKGKMb3rXS7sSDQnPTHs2iOcYFN8zbViajjDSp+aHzXZQ@mail.gmail.com>
 <20241202162239.GE2457179@bill-the-cat>
 <CAFLszTjvnyE4vFQ=Z=Ma1bOjH_Z4JEdUWM51Vc_nRmSUkRzF4Q@mail.gmail.com>
 <20241203005541.GP2457179@bill-the-cat>
 <CAFLszTi6koMMr0ggVLxKQK5LCBv+hCunewacBxDAZYH+rERGiw@mail.gmail.com>
 <20241203140133.GT2457179@bill-the-cat>
 <CAFLszThLAYQfMxE_fVuTYX57vNBfi0PyvBzuUGCw0_1EsXk7ag@mail.gmail.com>
 <20241203160131.GW2457179@bill-the-cat>
 <CAFLszTgx6BacGQyiMOoCzYDM3vsOBgfr2XbzBEsNOZ_Gzj3=ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jn1jVVl/DL6vmvEy"
Content-Disposition: inline
In-Reply-To: <CAFLszTgx6BacGQyiMOoCzYDM3vsOBgfr2XbzBEsNOZ_Gzj3=ig@mail.gmail.com>
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


--jn1jVVl/DL6vmvEy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 09:37:34AM -0700, Simon Glass wrote:

> Hi Tom,
>=20
> If you like, you can apply the reverts first, since they break boards.
> That should not be controversial, particularly as I explained at the
> time that this was likely to cause problems.
>=20
> Then you can leave the discussion on OF_BLOBLIST open.
>=20
> Just a thought.

Absolutely not. Again, 70fe23859437ffe4efe0793423937d8b78ebf9d6 says:
"Standard passage provides for a bloblist to be passed from one firmware
phase to the next. That can be used to pass the devicetree along as well.
Add an option to support this.

Tests for this will be added as part of the Universal Payload work."

And your new patch says exactly the same thing, but then:
"Note: This is the correct way to deal with bloblist, since it allows
boards to choose whether they want to use the devicetree from there, or
not." and a large number of patchwork links. And after squashing the
three commits together to see what's being changed, yes, you're
rewriting a whole bunch of the logic without any explanation of why. It
seems to fix 3 Chromebooks and isn't tested on anything else. This is
why I'm saying it's unreviewable.

So no, at the moment I'm inclined to wait for further reports of
problems, and we're coming up on a year since 70fe23859437 was merged,
before making any sort of last-minute change here.

--=20
Tom

--jn1jVVl/DL6vmvEy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdPNxAACgkQFHw5/5Y0
tyw6LgwAoD3vNUg8vd6yAURDFGhB2SiQiFa4FlKDunstYJ22gs81ZBYQP7Gga4FO
91/sZhdmko7PklVIt8TIxYuQdBvdzbsHGHaJJoi9GOxBMEhZNL8VLfIYyTlyPTAl
E6v0Fm4io74htT3lyfIQNVNWrzv/mAVUkJm7lff3yeOfSuAIYu9lo5hLuW7tHnLZ
4C3woyqil+KUs+PPPrrV4yqpGGs11A7Xv0EbSPmh4sO19Ubyp+jftODuAl14Yck8
RXPksmf9oI0+jFph1eQGOstuSg8zbBsYm6HKKJs1UMpj1TOMIydWH/e0D8nQjpwq
J/+753lmA2MC4CaSo8dEVrvrLaZg+yjoqqvg9CJaBb1jeYfzulsoMXcNXJcU/prH
rU2fm3R7E4nMVrBkhgBkU/l+iUkdb//AAXd0kYYkn5pDZS+MJ3mo6eJW9Fqes4eE
JT0krHQzM0S4EqC8nh6uyTBSMi6R7bY/Sx7aeZ+4rIxHY76RuL+TN2Is09PjyqtS
F9dU5uBe
=B9eS
-----END PGP SIGNATURE-----

--jn1jVVl/DL6vmvEy--
