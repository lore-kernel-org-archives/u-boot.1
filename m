Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3F9C36005
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 02:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07002819B1;
	Tue, 25 Mar 2025 03:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="grHGfHxN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFC9880EEF; Tue, 25 Mar 2025 03:01:38 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D589D81BC0
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 03:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223a7065ff8so27770325ad.0
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742868093; x=1743472893; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KhVAljmmQ2Nz9CLnLhCK45JTgQL0Yb9Zh65IsQ7tk2U=;
 b=grHGfHxNLPW4SyvL4TN2qCimu4A527eBuiCL6CAlj9lRCiV662WDLsNmv8kaTfYGYe
 a6NvDactDTIkIsAntFOXmQxaUMufN26yuj4nG7ZY4KIr0iq/QA4o7+GhUnQcRoG3SXcg
 nXvmv8lQQpsu6GdY4N2r8hSOt/y9pOa8UhsTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742868093; x=1743472893;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KhVAljmmQ2Nz9CLnLhCK45JTgQL0Yb9Zh65IsQ7tk2U=;
 b=EJ8NOGWrLP/5sKKWnQGdO84tAQmbch3SXpWBxxYBz3lqW8SFhTWCscd+JklLM5/lLP
 +g3l6tFV7G798d+hpIiuAPVdZbqSD70JcwlLN3jDz/uuCNng4MzzkTBWfLlWlrRWV+D/
 45DInRWCOtPpbUQW767aRcoP9PizthxxjP8S/cK0MEzcnU02WXszXk/NdxTgTigTtQze
 pKd2CwNN4UmnKDD32ubRvxUGnVu8F8yfY39uYJ+3njVvgfdZstuYHU6smsaQ+82haDXN
 27lWE3TZo0RBySJOiYfdlZnYpAF3t1U318NuabbIk0rOlpNenqkAlDomC4febWR0vVJ+
 LSmg==
X-Gm-Message-State: AOJu0YwT5yMnHfpJMtE8aj5hHuJtgEzGbnR+q3Tp2M2CoB9ZRe9C6qkO
 aRe0RjEFwud5MyQrm+9aS831KLE0/F/zb/uAAjRTE62nXL8I2uu0l5ix4IhrLlUZ1tcd2R9UF09
 U
X-Gm-Gg: ASbGncuKhIBkV/Qe09syKHtCGN0E0aoFZ45rZk6vd9V0/RUTg0ZyPKc694M13DYYavt
 XivaRL81UeeT3qxNoXJvUI0H3qUPDwIMvIKOLdXdX+jKSZDgfAjH7S781oQ2RKhsTq2HD4hrNVk
 W7XFDlUCnlMQ7yMKGcZZj+X5lWMC5obY0cQioIq1wtLXzbZXBG1kBJo68w4V4wamFl1SHR+s2qj
 3+NEA+ghzuvCsJIbjIiaoC9Eclp5BzGd5OsgpYpNcdSh7Rw8ra8pT4O0y0O9qJyU/uBY+sB8+cX
 HFVWh/VYmuX4rBUhmfDJSu0ck4p9Y+xK1M+dnrx/sEM=
X-Google-Smtp-Source: AGHT+IEHYN8oeMhy4kLPpywWl9zWLLdTrCIronkA19oiZ51g7FeU5qF5XOFb1FnMbQg6U0FR+wpmKA==
X-Received: by 2002:a17:902:d48f:b0:224:1579:5e91 with SMTP id
 d9443c01a7336-22780e2f849mr212173415ad.47.1742868093134; 
 Mon, 24 Mar 2025 19:01:33 -0700 (PDT)
Received: from bill-the-cat ([2806:2f0:5140:4ba6:9e6b:ff:fe16:a05f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811f6549sm78279395ad.208.2025.03.24.19.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 19:01:32 -0700 (PDT)
Date: Mon, 24 Mar 2025 20:01:30 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.04-rc5 released
Message-ID: <20250325020130.GF93000@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KNx/PHt08IhbGHfe"
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


--KNx/PHt08IhbGHfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out. This will
be merged to -next shortly.

One thing to note is that just today a bug was reported due to a missing
'fallthrough;' line and in turn we need to fix that in a number of
places and ensure it doesn't return. This will happen between now and
the release as I think it's clear enough.

While we have been having regular meetings after an -rc release, I have
assorted personal appointments this week and need to reschedule for next
week instead.

Repeating what I said on the -rc3 release,
I've been looking in to seeing how we could get modern project
governance setup and some umbrella organization to handle financial
matters, etc. To that end, I've been talking with the Software Freedom
Conservancy (https://sfconservancy.org/). I continue to need to post a
bit longer of an email explaining my thoughts and looking for volunteers
to help with organization.

In terms of a changelog,=20
git log --merges v2025.04-rc4..v2025.04-rc5
As always, more details in pull requests (or the tags referenced by
them) will result in more details here.

I plan to have the final release will be 07 April 2025.

Thanks all!

--=20
Tom

--KNx/PHt08IhbGHfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfiDnoACgkQFHw5/5Y0
tyylKQv/dcC/ae7iJ4lqDc0qvxQrE2HzctLHsRhZPLuwt/6YtDco8indO3YB+E0J
mmmH06TDf9yGyTYNtCyAzEVXWum/tHOJNSqwIBQPJ6JGVvgv487B0jiwsuC6Zdy/
0jYVBrGVYHJ375IOfhEvZ85a0Ix+yGnakBGFGqPlPKXpEkAD0+NbXYUiiD9Zmne8
ae5cHSDOc91oj5YqDDAJgnEH/xdmMUTmFhKSsySYY5KDZuU62mXEJFhXgWZtIKbW
YwdXvLLGoc6EK98imXRnAVcYWvBRISRC7iG8dwHMx7HA52WkJ0oBWSTo5jTeX0aG
qIGGbPLby1pBM9e/RTnoA4fVlqyIWjcVNAvQh//+qyCbgO+4C67LWBDV2MA7XyCG
AJos1nEIas/4lcwNG1Qp9zYWIiUhYSOqv1PFZ2Nt0epxdzTZQBIbBIgYQ5AY9HdN
b0+JVMqcKAFbgEjM1SamRSOxkNh63pv9vcJKTb1/3ll37A2q7TwaovLBKr5pAHyr
joGYVlkX
=LzdZ
-----END PGP SIGNATURE-----

--KNx/PHt08IhbGHfe--
