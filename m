Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B651CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 16:50:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F658319C;
	Mon, 29 Sep 2025 18:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qX+FEaXY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13E9B8329F; Mon, 29 Sep 2025 18:50:49 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5B0D82A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 18:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-378aa12c13dso1088942fac.2
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 09:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759164645; x=1759769445; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xVITTbuBxeGx6OIdbQWQyCg9woLTv2+YWViT0NWrw9U=;
 b=qX+FEaXYCLaXJlkgaPDqXIXFLSkdKLjMf9J0t/HkaR0BDCAbkYyhwHJUcOlyMj284y
 nWUilXSU3y4ZZbct8rCRvFItLG9CfwIwjNuw/YXh36t2Y6lU7nO5oSHnx+U06WBgL+b0
 +YIIuKZle6aVon1zidKN3gg0JQUPaz9FStWIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759164645; x=1759769445;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVITTbuBxeGx6OIdbQWQyCg9woLTv2+YWViT0NWrw9U=;
 b=GpYxQGvMVtBBbHw/TYih2Q8gm+sRHKn/+Zlw+ZtwY9xRVzuLu+SNvJBtdsBm2bKRT6
 CNKNRNMeMXd55wnxfNwSXdKG37VTjX0f9nRqBuZucZl6WCPyHjkJNd//tx9B3fMea+y/
 ZT8K8vPPB2qZkaGxobxzPrYpjM9/UmCH/gSu2rkunAK0nLPIB1hBGBx7mpu2XygP+U9N
 q4SIXR9Q7x8UaG05/yN2jFTAE1Aa2fjN28yIMocBl3ImSZJCaks3qsdIgINmLlSHhw2v
 atjXOW4Q/lpfWSAuKz1bcTMBZ/kk0bRKLMULZtBKd2penQwnU0IL80ciHJPUXP7hzJ8K
 9bDw==
X-Gm-Message-State: AOJu0Yzn16D/P7fmq4C9oHNMs1Q7Or3dB4JqUH6yU+dmtZe/XNkbEuuY
 ri8Ta3zgAq9/NkcaO2sLCO1w/aHsZ9aQA33paKXv26lkMpDs564CVvgmJOCx2kSX1BM=
X-Gm-Gg: ASbGncuFm4ALhfrmK3v4lv5cWo4SYDAPn2t7uAKQkcqSFC8WAK83AR6LbT4nKGBVF6i
 vrawNWW2s2Ow6icVCXgclX56mU1FBXHcd+MXIzzYMv8wsXXNHxwJK1gBsPtLil9BIu9pykrbZGY
 HXibcHkvhYjYoecOOE5jxmqG/aLjl0krnERSeRxaLuYe5ius71R6UktAabDIcwiYRquzqfmQACJ
 2NVxi22OZnvVTNeJQ0c4q7YjejZl6hoGjHOSKKt7CcL+GyhWJ/ZZMs+OAVnWG3uk4cm52C4LJq/
 ufSZkBVxqxCUpnCIox9U7NX/YqT8qlzzFpLYOTndfvvsb7bmShNQnjNipuN7K09pidBuzZFlJzu
 ZxmjjQKMGZm7Y6iXETgTr4zYoN11jwoNqvAsnrsjEXfuzZMcGhmNJXxgkDNmboqgQGcA=
X-Google-Smtp-Source: AGHT+IGnTawSTgw3BfyUZ/2B9SWpn0rEQp/X7xGSPUnfAlxtHgopSm9TGFZP3PIYbWLmNtLSU3c52Q==
X-Received: by 2002:a05:6871:691:b0:376:bfb7:18a with SMTP id
 586e51a60fabf-376bfb704femr4711405fac.12.1759164645643; 
 Mon, 29 Sep 2025 09:50:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-363a15c108csm3722237fac.6.2025.09.29.09.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 09:50:45 -0700 (PDT)
Date: Mon, 29 Sep 2025 10:50:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: u-boot@lists.denx.de, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] link principle license to COPYING
Message-ID: <20250929165042.GJ6093@bill-the-cat>
References: <20250929155142.1647606-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YqbDlfIF4tdO4Ff2"
Content-Disposition: inline
In-Reply-To: <20250929155142.1647606-1-alex.bennee@linaro.org>
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


--YqbDlfIF4tdO4Ff2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 04:51:42PM +0100, Alex Benn=E9e wrote:

> Some license scanners are particularly dumb and when combined with
> automatic license scanning for FLOSS accreditation on forges cause
> problems on renewal. As GPL 2.0 applies to the core code link the main
> licence text to COPYING to keep everything happy.
>=20
> This caused issues for the QEMU project recently as we mirror (two!)
> copies of u-boot in our project.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>

Since Daniel Berrang=E9 posted a similar patch 3 days ago, I assume the
gitlab license renewal is coming up quickly.

In principal, I'm fine with this and will apply a patch shortly.

In practice, we've always had to get a human involved at Gitlab to get
our license renewed as we're clearly within the required terms, it's
just that we've also got some further reading people should do.

--=20
Tom

--YqbDlfIF4tdO4Ff2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNq43wAKCRAr4qD1Cr/k
Cu55AQCHmOMrjFDOG0RcfUGNutZVV+3+e4LXNu/lm/0P5J5R7AEAmG7+T2HefuPo
83fOeiF+BgJr6K15atQpptf267RUGQE=
=YlHs
-----END PGP SIGNATURE-----

--YqbDlfIF4tdO4Ff2--
