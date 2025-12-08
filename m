Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2326ED3B7EA
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 19:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EEDC83981;
	Mon,  8 Dec 2025 20:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uWyetGns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 594DB8398D; Mon,  8 Dec 2025 20:04:56 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3631183A57
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 20:04:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-450063be247so2179034b6e.2
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 11:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765220690; x=1765825490; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z4c+2BB4nnUmThyklQzh9kqU7bV3qxqmMvfwO+jGOvU=;
 b=uWyetGnslexGOiYbkWGJhp04TcMPdAGEFfds9w5y3pqbg6fw/RCTg6mxYaueAJlwBJ
 LAScIUpfl8lZFD0Gtlp2NGWU9wPMCDCjyToiKAeoBCA8lsIYIa31jPqwZGsyEzpNw7RF
 InKMx0JUG2MGaMVmAqbbZvKygslQQsOA8tdY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765220690; x=1765825490;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z4c+2BB4nnUmThyklQzh9kqU7bV3qxqmMvfwO+jGOvU=;
 b=o/g55gTN9U5cKvII6f6n5JlNqeOnZ7vCqIoOqre5vKrTEg9x+OgutZn5bRg0gFWCZr
 Xvv/evXsIRFANavSW+mG22A4aQCRpJg8h/UNdYmx2t79mlJMABu9NjnixJxKpOola56o
 A8FVYkozR7ytGaBIHeplI1OJXMO/bzjnaT1SdF9JE8wTSUTMP0H6tEH4I7u45DAla7Fs
 WGBLwjijHUgQzfhuAtw6xokVKLnGu/MthhGQkHmT2j7gRlFkUD443LHMpgFl6Ou2wFTE
 fJriT3khxwaLmdL8DLw03lusYawhWKOuLzycj2FrP7TZxx9ktUd0/2aekWGcaE3vsr5A
 s3ZQ==
X-Gm-Message-State: AOJu0YztxMch69ct/ObNC9VnslOFGkMeqt9ub7HSCHCGu9ZiMLoGs43p
 gc35iG5CyQKv8c4VQ7YE2NBQP7Ys72fSmEEj5pt0KlLT3iUjkg7Y//sN/8WL6yGPGEQhQIWpB2K
 v70V1KHk=
X-Gm-Gg: ASbGncvrDqr9Ws84WLiEbzUxo14xMZJ0hP5gcEzmLzzqbCdQXkv5PkI2H+3q5x9VAst
 fWYMRPDDasSf2QQ+TbmkINRBYE1FHhQx6/y3fjuvBVWLkufg66pITx3YdRDFc7cfzyw5Im1vWYG
 ofc84ZlhzBJbLu9tYDrFwecwiEhyaips0SIEDOagGPwxXofu4K7lkePtA9fA+Krq67o0K+g7SQV
 x0VjXedtd+s4uzsrQTwVmhBQCBc+8U/foTpc2M3b0jv+44Fh6BvJvoT2U4+2hJwxt3U2Thb/YOF
 +x+Z091T5f0vSrThdrqRRUIH5Xz6KXSS7r7BbJjAr0h9DkQMF7qIZXzAXhv0GMRq5lCFTB0zpK5
 X9go5Wyw3f2oAss3PUrTkuKRYZIGEZW/YKTX65HpRILVnxex7UsG0hkhsNdDKnLgc7wO8aRcgFN
 kPgYKVcVpArcrEfcXJQnV+wqRl4G7Z/N4MU13WLEwJPxApIoUXd3OsmOuXjr3z
X-Google-Smtp-Source: AGHT+IGiut3Htsi/QehtBnX2OJhumbS90i61ZhHLilznCpLPWBSkdamzl5mPcleVLKI4Q09iESJonQ==
X-Received: by 2002:a05:6808:16a7:b0:44f:da6f:edb1 with SMTP id
 5614622812f47-4539df930aemr3646706b6e.13.1765220689755; 
 Mon, 08 Dec 2025 11:04:49 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-453800cc729sm6579139b6e.10.2025.12.08.11.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 11:04:49 -0800 (PST)
Date: Mon, 8 Dec 2025 13:04:47 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2026.01-rc4 released
Message-ID: <20251208190447.GQ303283@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i1pWBi+WbUoCsEP4"
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


--i1pWBi+WbUoCsEP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out. In my own
patchwork queue, things are fairly solidly for the next branch, with
just a few things like MAINTAINER entires to update. Which means that in
general, I'm hoping custodians are looking at their queue and seeing
what they have which can go to the next branch now as well.

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DZGNsNT=
h2YWQ2YTB0ajAzZXRkdDVhdjFuNmpfMjAyNTEwMjhUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwN=
mE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=3D=
89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.ca=
lendar.google.com&scp=3DALL
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/btj-wgcg-euw
December 10th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

In terms of a rough changelog:

We have one mroe rc release to go before the final release which will be
on 05 January 2026.

Thanks all!

--=20
Tom

--i1pWBi+WbUoCsEP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTchTwAKCRAr4qD1Cr/k
Cs+cAQDmOhLeP66J1lioZJ9HK+IXA9zyi/lTdG/jMDtrUGp7sAEAo+27II/dABms
2UsJkbdHeQ/UBoDB2vklSjgYCBXXLQc=
=e04u
-----END PGP SIGNATURE-----

--i1pWBi+WbUoCsEP4--
