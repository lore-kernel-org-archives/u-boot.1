Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBA9C25B79
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 16:06:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DA73886D5;
	Mon, 20 May 2024 18:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IvYZPR26";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA74B886B0; Mon, 20 May 2024 18:06:43 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A238886CF
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 18:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6aad7449f22so3108326d6.2
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716221199; x=1716825999; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O52dAGPuN1JZswusml3jULe7mXemYfeDhcZR2eN5byw=;
 b=IvYZPR26tLR/CFNQfjFQrlTSKjemmngYVHqzwCB4lxsyuuAzgSl7y95QOfpfuZ7fZl
 x+i/LnSmlgFwEUlYn01xTBNyEzjGFe0HhAc54lX1xODroyt6Swzt1w/p3fdf/mM2klRp
 KzvYA+2DqvMXPubI9WhH/ke1axWRF2G8wOT7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716221199; x=1716825999;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O52dAGPuN1JZswusml3jULe7mXemYfeDhcZR2eN5byw=;
 b=D43UKpFhhkUcsSu4tJ4hRfmt6Rd91vqmDoG7k+u5uLFD8H8yjL4DZ+rcOWfqykDQMq
 ygXGik44ZCsd7qw28byC3VIVLmrIZvdAwN1hs6sWNBBSTpvI0aQ+UID/vZKT9RjH5xHT
 4BSDEbT+kjrJ9cR4CUyvd0QVU2Omvw3/1KtP8fcnJ+PU39QPsRxLD0hIG1OisSFpPeMy
 6hy8VUNzxK8Ep3cXjMJecVctcpVbkk3qrvyx3CxEP8aWI1bjdZ/vg4mKcAOCugTo2E1f
 CRKBRDVwcdUxLTp8d4bssSUfmQy3yW6eWuuRE/Y9Vi2Px9M/ke8075u5AqeM8S0hdN/Z
 fekw==
X-Gm-Message-State: AOJu0YzPLd02ujzSf5vGJU1xU0+uudWRjyWpp/5LadyVo44ns8uxe3Xm
 tOa+pdfB94o0zw0m3e53OSd/TqcW5VSYtpsfcpXm03RZ5fEBL06G1Kbgj9ONQHNZ6TrNUkNtf19
 9
X-Google-Smtp-Source: AGHT+IHNE9ApfN2ZlNnR2cFykZPge/oQIGAcu5fzqIL08AXuKJIK1ms4JpAR7QAzsD9/zAM16PBhYg==
X-Received: by 2002:a05:6214:5788:b0:6aa:dc36:5cb1 with SMTP id
 6a1803df08f44-6aadc365f31mr29969156d6.25.1716221198767; 
 Mon, 20 May 2024 09:06:38 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1ccd4esm114467786d6.97.2024.05.20.09.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 09:06:38 -0700 (PDT)
Date: Mon, 20 May 2024 10:06:35 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.07-rc3 released
Message-ID: <20240520160635.GQ2568172@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ONWCF+9u14uSxHAj"
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


--ONWCF+9u14uSxHAj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and here is -rc3. At this point, I think we're firmly
on "bug fix and documentation" ground moving forward for changes to
v2024.07 and the next branch is open and ready for use and pull
requests.

In terms of a changelog,=20
git log --merges v2024.07-rc2..v2024.07-rc3
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

I hope to remain on schedule and that means the rest of the rcs every
other Monday, and with final release on Monday, July 1st, 2024. Thanks
all!

--=20
Tom

--ONWCF+9u14uSxHAj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZLdQsACgkQFHw5/5Y0
tyzi8wwAtT5LWb4RzYHpnfmX9VtKR5xGqEHJPPhAMol6vtRvcwqyae2DLSlIaMOc
oMAlUXgRR6oJnvk7XvnCs4E3r5REdzH1OdcazWjRWoerm7R25SzhHN6CeNysnZ4k
2V7l1hvcjW3gjh0fuZX6j6UnaDfIKNuqcDJ5ySeMey0WxoVWFBdfIRcdpfClokNP
tfF0wmoqMZgoAFZscp7taQ5+z4RohGhVmn9xTcMANfFhnxlmMwOCNLQWnMJRoFMo
4WKK30Y+0lMcTBkGqCEZ2GJNvwHOn27OxFFiI4zjy8cVjKAiRF7UKgqJqkCD4nmq
1syTSmbs+sVFzaL/8kBe6wV0rmqAPNedw88M5ovAcGl5xaL+IrB+DxydN4uS3OaQ
5++dKu1q5NqV4n8KOob47sZJnIL8XR7NQJt7+/EwuQ4PssdJbyIs2vc5QvUl8vJT
gm/OxottOKLkN3SsSfNti24aydrkTl3BDThXRtIFgsGLVe1D8O1THDZZ7Og2tMX0
sOuxIZ/g
=MBrK
-----END PGP SIGNATURE-----

--ONWCF+9u14uSxHAj--
