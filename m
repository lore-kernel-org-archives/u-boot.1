Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFEBC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 17:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF794828BC;
	Wed, 28 May 2025 19:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CrffWa75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBBB482B20; Wed, 28 May 2025 19:59:08 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F03682116
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 19:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72c13802133so35023a34.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748455145; x=1749059945; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NlDas/wAYwuX26JY6td0JrqHSZEgfyG0b06iiDs9ti0=;
 b=CrffWa7561+STkkWa8L8rk7npw/Di7tl/vYQmQlkjOyZDN6lmQ/PtSRqm4gERInuGl
 pLnf+0Z7+yrbA5TZ0a1lFmWUAXdafP86vXK8nPlJ1UFoeAQ3hL4udLXcAG9jR+0Ed9I+
 eLHSTxXy4O7NpfKS33m7TyvvToMeCjlkXR048=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748455145; x=1749059945;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NlDas/wAYwuX26JY6td0JrqHSZEgfyG0b06iiDs9ti0=;
 b=td3B/r9TZfHlRCLNMcHEyzLYyf4eAziulU5ax0TzgOjITsjPxqz/WNvWagqu/SS+KB
 q3s8Zp/Bh6wWkxY+xWXKE56ue3HepiX21iolNbacXTHFSPP+2VuBFbw0lu2fnT+qcNLj
 VaQ2e5rh5AqT3kCBowCQ+8sLgINpT4OWVzSaA9N0k3+IolY7gRnZgt3sADocn0or+rki
 es/Lm1MvEGKKhpLUJ4xYLAo53OMsw82QokTxEVrfsBNq9Fwd1mf/XgF0JfXYrs1dwoKk
 C3lJv7vcAJU5DZ+DG5BGg5waETK/mrQaVA+OJHbvWwI26JgQ25lo3IbmeTUr6hf7G/1J
 lERw==
X-Gm-Message-State: AOJu0Ywli2yojYGj0G6kj9KF1/NDObZwvbYCDXPqRQgqDV30pdTKA0DI
 JEJUzqr4anT/aewi8DbuAMh6znQvxNojBA5/loIq3K7WDqacHris87Shx6uMVSvEULT9UG1oq4A
 BZJ0YGyA=
X-Gm-Gg: ASbGnctP1qAqSv2yNbRv2FaWiCWAe4W335DvB5Bx1HegUiYVbneGVrWJbk/lNKVYZqW
 SBkDnDUv/zk+nrjbt18I4DQxkdlsfnaHZ9okJrY4P5HV+pVL8dN1oqFZvZ+3/rbbq6AWpFYASGx
 EQkgEVh23YrEYL05IGEygrzj8ADQOL2BhF+kGJvQKUQZ3vDBZ5ewKsMS5G0ovxBdaCsHvBX4yjh
 UfzoYqYs/bz5Uqm4C3lYhRfANJSAZx+ytYjLiU/zbw9HGXCns4GcRN/ZzseQO+n/Fc9K8ZemOJR
 cP5DJFMT5WHKMuqEooxDOuzhkYrQ8vjCY3miToBpcrDRhVlTUng+Pci2B1ZDWIj4JVTe18w4YNi
 vbxeaY5vS+UBk
X-Google-Smtp-Source: AGHT+IGlaaeqke7gwKhS/uHdJFDLmYEH3Uf1eX45Gx6vEl2LtOTa0cCnKiSYd7OOTUmhfdVeT60QRg==
X-Received: by 2002:a05:6808:320f:b0:401:e61b:5f73 with SMTP id
 5614622812f47-406467d8956mr11783988b6e.11.1748455144876; 
 Wed, 28 May 2025 10:59:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40665472aabsm263189b6e.31.2025.05.28.10.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 10:59:04 -0700 (PDT)
Date: Wed, 28 May 2025 11:59:01 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: Determining Simon Glass's future in the U-Boot project
Message-ID: <20250528175901.GG100073@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fugm3uamNDvz/g1U"
Content-Disposition: inline
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


--fugm3uamNDvz/g1U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

First, I am not happy to be writing this email. But at this point, I
feel I have no other choice, for the good of the overall project and
community.

Back in January[0] of this year I made a post with almost this same
subject line. At that point there had already been a number of problems
working with Simon and the overall community. I did not include a list
of links. At that point the easiest answer would be to go to the mailing
list archive, pick any thread that Simon and I had and see the long
disagreements. This trend has fundamentally not changed. And while I
started this out with some threads and my summaries of them, instead I
want to point to this email I sent this mornig:
https://lore.kernel.org/u-boot/20250528170533.GE100073@bill-the-cat/

And to repeat what I said there, Simon needs to decide if it's more
important to work with the community or have his way every time. Simon
cannot have both. Simon needs to accept that some things he think are
good ideas have been rejected or he needs to fork off from U-Boot. Or he
can ask the community to take over as the project head. If the community
wants Simon to run things, I will step down and just be an individual
contributor again. Five months of this experiment shows me that it's not
working at all and will only be a bigger problem as time goes on.

And, I mean it. I cannot take the additional stress of what new problems
await me every morning. I do not take the above lightly, but I do not
think the project can become healthy moving forward without some
resolution here and quickly. While I won't claim my time as the head of
the project has been perfect, I have tried my best to always be honest
and fair and to seek compromise.

With respect to voting, would anyone volunteer to run a poll from
https://civs1.civs.us/ (which is used by the Yocto Project /
OpenEmbedded and likely other FOSS projects/communities) ?

--=20
Tom

--fugm3uamNDvz/g1U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg3TuIACgkQFHw5/5Y0
tywSywwAiVJ28gbaGxIDUfPQ5BUryPEXGRib+aJ0VW5EyBkpmpo5S3HwDCgDHI5u
w3jcDKCc+7tFztMsGVRDf4Aclu1wEMEx4GW4lzn7n45XbZIexZQGinTjOso1i1wz
6iarkaviOT3ibIfBo/C2ZcUUB86akeODYasMbLMhrflI4cgdTtneilVJ4oq9/gYk
xmmO5L579h5iqrlm68JYBPHLsn9Qx70z8trKX3EsjoI16zpZHiTaY/1An3Dd7oqp
Vvz6ztR84iksit3mh63OjStoDZudYkuFnPFNXf+SN/PUPTfzSLZaZpOlCx1L0QuT
JQgzWPFVVSyF0sist4U5UfabjuNQyX5Uz+TR5sEI/8jFHFqE1rPs4L9kBjTkG6vs
UdjrBK+ELlYp3oA41/wNOpoqbfqWtVn3Y1H40b40wZoA32IG4IHl6rO21EbTn066
XZZ48tz8fyb1JnYG+Uxgv3jIwdYXGP6lPLVbYySqxndGtS2LgNw4EtL5wyc033Ln
AFsENrMB
=DAaX
-----END PGP SIGNATURE-----

--fugm3uamNDvz/g1U--
