Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8D1C25B48
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DDDB879FC;
	Wed, 25 Oct 2023 01:17:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pTk+I1OP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E5FD879ED; Wed, 25 Oct 2023 01:16:33 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1FF886FE3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:16:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-da0344eb3fdso1386828276.3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189386; x=1698794186; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bvKBP33rRooVRqSH4K6XAEC7YWERmSdQZN3FgjfCR2Y=;
 b=pTk+I1OPFXMemUy4SmiEvr7usojtTc1x2oPA/uon5msKxy/7ooOQEj82LGps8wzUax
 f8EBQ/TZu8X+k4V2LpHQkJII/n6uCSmnhqYWuK3/zlYxqNJ3QrbluCrAj1GYwN61Te89
 9C8BJ4v4bPr6BQFMFZARCy0OAYq3TZJ1pgOdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189386; x=1698794186;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvKBP33rRooVRqSH4K6XAEC7YWERmSdQZN3FgjfCR2Y=;
 b=CgDtQd8c+NXi34xI8XEpAy9Ti8pnC4HYkVU8CnKJNgFt5q8MLwEgZSHAwvBa/cgoN0
 mh3rtFb8g/xWEcYv5hvc9zthuj/2p7g9vDpVoDv4VUO9KYz6w5AqgDD1o4Q6SVBnhdhb
 QqMuHj0dUj/FJvudNazO5/lHtBP9GC2SIIsBUw4ejSDQzHwLjgnK4M1+vkndnDY9oAgO
 EyP6f2AWfp1L3pIIlClOHUTJctsHB7cMs6BrQODMwStWJwSluA0I82HdOo3jNPBtOYOQ
 +18t1sZDTmWMxEa7hxWKWXpf/b557Uu6hIBWhw5eDY8T7N9JJKJS9bj4jiGit6E0HXsu
 j55Q==
X-Gm-Message-State: AOJu0YxHHt1wKekVNGZcOguYv/MENW8Mv/nSEgbo2KpA7ivvPpaJK1MC
 VdHQA3c/jPY6erZkhreBahv++w==
X-Google-Smtp-Source: AGHT+IEyAgfvtuuI5LyC2WN4qE7kSMUHcLwlNylAu3uJf0kWqLbu/Ayl+rQXTe9xUkQhC0Wxcrgbtw==
X-Received: by 2002:a25:d3d3:0:b0:d9a:d16f:dddf with SMTP id
 e202-20020a25d3d3000000b00d9ad16fdddfmr13395278ybf.24.1698189386358; 
 Tue, 24 Oct 2023 16:16:26 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 z3-20020a056902054300b00d7e96c6eaf5sm3869435ybs.46.2023.10.24.16.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:16:25 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:16:24 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 2/2] patman: Add a little documentation on the
 checkpatch tests
Message-ID: <20231024231624.GW496310@bill-the-cat>
References: <20231013162836.1911982-1-sjg@chromium.org>
 <20231013162836.1911982-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZBkMNFrIuAbSSKFD"
Content-Disposition: inline
In-Reply-To: <20231013162836.1911982-2-sjg@chromium.org>
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


--ZBkMNFrIuAbSSKFD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 09:28:33AM -0700, Simon Glass wrote:

> These texts lack comments. Add some so that it is clearer what is going
> on.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--ZBkMNFrIuAbSSKFD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UEgACgkQFHw5/5Y0
tyxXQQwAkRmxrmeJ8s3+XPHsXf+IuuMnUtSTDqWDl1sLotGTbgkxw8VRo4gr4aOT
IGWz6lGIGOGLB0waV+hKON8BcU+H4KqSAlbDW6VF6zaTPtdZmB8qzW5jAEUTL0Xp
hP8oOcz9qvpASdYforX/ylFGjYmeCdTtqmPpvC2vrUfSCocmKvE1QpwL0RPJC5kk
IIZFkwG33t0LfpI/fhAwRjXjxkXXTLX1K4TCmEy4cYbDcGvkJnSfNTWvEoynrrS8
E/LNs6cB9Ld/jwhJtjOfXY5FGcuU3sDjWSf0bKQG1CPeZyVSfAYLehF1Sg1IA6nk
PVD0o0JnXoNioEDnsmGq/Mi8Yuc6wa5/Irpx8BK89du4dTcDjJ6SQ9XBwfO499TC
7w3vB8Z2n4vngP1TnbdLGdSwT3kYb3ff78GRJeFMxU0PoYefnzL6n1G7kPafy3wf
ujFvfRm10GEY0sN/YgLebDUPQaiU3QUFBIH7loRGM0nf6MW6nGSUkRSViG+EwFdQ
zYpXFTHI
=171Z
-----END PGP SIGNATURE-----

--ZBkMNFrIuAbSSKFD--
