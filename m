Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988B1CD98D2
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 21:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0053848BF;
	Tue, 16 Jun 2026 23:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ONaRSxst";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 618A5848D8; Tue, 16 Jun 2026 23:44:57 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFBAA848BA
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 23:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-69e8d815c3dso2152042eaf.1
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 14:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781646293; x=1782251093; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TzOR5AW0d0AC6m46MGU0dWQVklRJw87RqSllaWsf89Y=;
 b=ONaRSxstbYI0PflUSuEOzVYmkjejCTv07UqD0smEXIe7R9b7i5abHojDVQgUlRoS55
 bkJKcpILQRS/TTa2diO4xK9kKnHfikfLD1V+DyBT+lRqsOya8AS3GoR/xVeaC92vp9xB
 FqxNiu3AaPMvNlOPYYUivrBAWoD3XXMNW41a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781646293; x=1782251093;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TzOR5AW0d0AC6m46MGU0dWQVklRJw87RqSllaWsf89Y=;
 b=HcD9kHnN56WHnORiMd8htXrjrdChyOKdIy2ERNUGJvyyYE/MsnRUvfy75uExnDAhei
 pFqWbfuoi7TUWqzpArooxrnvfSwgki85ixoctqOTyJZq9WGTL9BhXS9bT4vzN/s3Wm+j
 1KsWw6VGGhX28aje0ObteU7o7H9aPFtQn5loBowdteGt5Yekili8n5+F5Im51/BPrWhb
 HwR3HaniQsSCYFzHXWbphdv9e7vJr83nSBBMgvsJtO0r6JYqqEa1id7D7brf7syrukEB
 5PJJvAgJxXj6oZnO7KU6vgILL57rggB0nRM8ZEFS3oXULgPGfV0vojE1EBMNYTCIqz+e
 lIjQ==
X-Gm-Message-State: AOJu0YyQA/bLv6ktWADF0asl3xeaotLK740GIrN5Y9UTZZDeqCimQOEw
 wZ3nYpS9xTstgZwoqjJanTS4NBsehQgKxopAFBPRj5Afatxwga4hQJzJPlbc7Amx/sQJd1Pz3TZ
 cCSZw1pg=
X-Gm-Gg: Acq92OGMJ63zSwhfs1HNV2iG8sBwSkdq+LyAu6zNusgQTVebrIHr12AXpxD9cLjdXiz
 PLlv6blf3qq6Tul0eHOOkLNBx5sXrSNghI+JXEAw67nKbvPRVuLl6Lt7fEJj4xUqKiWd7qLjW/i
 1K+JYi+rMSVLHQafeoPVseW4QgFi2uB2x7Gx89NMDQNoNROpCHPIQOudMTsXqG6doQZ6UX7itoz
 EBlDhfWDER4QUx6TzkR9tn6J4E8U1z5TYLpB+bmNG42Y/K1EI6Swv4C7eyVuBTGbwfOEfnZEY28
 0MXooG/C5VmMXB5sH3RSX5oOnQ08kTVVdKuZANmqNvcLJjMbDP/RHW6qceI3AvO1zUJdcVN8phw
 cQRus0szSvQQnyp8L6jyZ4NXkVQG5tVGlUWiVXkYaUuhc7pBeCZnlx+1uD0txn9jMXJpI0BAOYJ
 HmnWnpNIL9RXDHYh6r+FMcrVTDKiVMi0f53QJCxxnZ+Ia6SgvwPMbS5Xx65MIulZLu8TT69oTHA
 HjLcNcy7p1uTYCBG7VJpQkdkuMV0zSQRhQavvTaXwu/G4KzJOk=
X-Received: by 2002:a05:6820:4d09:b0:69d:9e3d:4e19 with SMTP id
 006d021491bc7-6a0b607e970mr786296eaf.30.1781646293518; 
 Tue, 16 Jun 2026 14:44:53 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0b5e4ab15sm459198eaf.8.2026.06.16.14.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:44:52 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:44:50 -0600
From: Tom Rini <trini@konsulko.com>
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: [PATCH v4 2/7] reset: Add explicit cold reset support
Message-ID: <20260616214450.GA1740849@bill-the-cat>
References: <20260603070743.1268544-1-dmukhin@ford.com>
 <20260603070743.1268544-3-dmukhin@ford.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ut85rbyKPGXICQSW"
Content-Disposition: inline
In-Reply-To: <20260603070743.1268544-3-dmukhin@ford.com>
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


--ut85rbyKPGXICQSW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2026 at 12:07:38AM -0700, dmukhin@ford.com wrote:

> Some prototype boards default to a non-cold reset type, e.g. warm reset.
>=20
> Add 'reset -c' so users can explicitly request a cold reset when needed.
>=20
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> ---
> Changes since v3:
> - preserved existing behavior for 'reset -edl' handling
> - corrected commit message formatting

This, and the subsequent test add growth in SPL on platforms that aren't
using it, and then one of them is now too large to link. Looking harder
at the code, we need to start out with some sort of re-factoring to move
do_reset / do_poweroff out of drivers/sysreset/sysreset-uclass.c and in
to something under cmd/ (and not conflict with the non-DM implementation
of those functions).
https://docs.u-boot-project.org/en/latest/develop/ci_testing.html is a
pointer on running CI which I forget if I'd given you for something else
or not yet, but would also show the current series failing on the
rockchip world build job.

--=20
Tom

--ut85rbyKPGXICQSW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajHDzwAKCRAr4qD1Cr/k
CrBRAQDprCajXAd1MWsVcOmQAFSDX9h1lzKpl3fMyM2U+NOX8gD+PanTAlh/lVNv
kCuU1PykvpgoRFRrGPc5cnxRxMbOtAs=
=CX1F
-----END PGP SIGNATURE-----

--ut85rbyKPGXICQSW--
