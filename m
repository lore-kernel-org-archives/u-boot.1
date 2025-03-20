Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1051EC28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 23:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A969B80756;
	Fri, 21 Mar 2025 00:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FmlvImQM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 180F7807D7; Fri, 21 Mar 2025 00:40:44 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33989803CC
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 00:40:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-225df540edcso52661045ad.0
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 16:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742514036; x=1743118836; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GqlRlrUA9oQomcmdb9fIYwfzqnZU++FfrIoN29GXcCA=;
 b=FmlvImQMEBhfVBh3Nls2w6cgD7Pz6yG7DZYh0OS/g78R11AB8qKSm1fxxmX+FMgSII
 jewmAmVMr9lsnh6t8XEEFBJFSkxKr2vYfcznQZ31jz0bEUoEDYI8VhJTcHxqyEP298P4
 Xc6dfUtGVWyHdzTPWYidiB6FeV5KoiTj4uTZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742514036; x=1743118836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GqlRlrUA9oQomcmdb9fIYwfzqnZU++FfrIoN29GXcCA=;
 b=UaTaBR3zaixXBimIFMfERpc7M9AOsZTU6ReSSGJEUgA/p++yQ7bcvydemY21q0DPHL
 DyTbiXgBjEZJ12Mh+Nkv1M7oWkv2qGTbDQ/rJqo6S0XaA02lA+L60OwZYU9nxAr++FI5
 nNtay1Mfe2qabjMzhzpTgg7ZL+Pa19/uS+ipmHfphwvO2G2VBjyuJIZ/MVBRiBWzb8l5
 pt/Zdfc/SgWbrayJuvnKS4dFVQifhOK/ybXDkO8oF3YOBhHK5Vj0CV8cumCp8hN7peTx
 h08mEGlec3a4baK4U7c2OI1LUzfadP5jBnIrfzNofNE3ZdXufYszyswMuHqKtw9rlnCE
 oYXA==
X-Gm-Message-State: AOJu0Yyo8PlkHbgdNhkm94Z6duwxbsf5Z++x9hXidFfPD1rlT+wBfMcN
 BRuZkzZ8J97sYkRe8qxSGo8yxe0USd9m21PEQpVbQAaB/elGwVGya1CUT5fNTCQ=
X-Gm-Gg: ASbGncsylIJ7XpZucXn1MshyQV+Eou5natHt8zO+eTi7EMjLt58J6F4gdIsEXDhHM6G
 5KXiMQ8yGhlW/4lF5oqJEje0OsdwjC+ialWBsQ3xKnwTRhuMzIzboVUH2Htpn/Qtc9/HFt9Q2Aa
 b3o6fQjRxexepnm9txjV4U4NEfsRag0El3rdRQtlEVrqk3CD34KVKCkv1AII6kV/mtR+nB7jyvX
 rD/KB9pduvcIVgbAAym6m7l5lYuimhaWWgV2wHdlb3kOze0Orm4M5pern8pJwynimq7Ec6Use7R
 y4FOSs7l/MBa1IsvAWsG7hFpCuVCw3l58YbxYDBVIBs7iK7d9jJVXBzL
X-Google-Smtp-Source: AGHT+IG+rTeDLFrlGO+em2/Iieo5isyh4r7bcILE+JEnRlE15EKNRz2+Vk147mJ5EdbY1enbWX13cw==
X-Received: by 2002:a05:6a00:1892:b0:736:3ea8:4813 with SMTP id
 d2e1a72fcca58-73905942e19mr2124119b3a.2.1742514036106; 
 Thu, 20 Mar 2025 16:40:36 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390618e5absm442977b3a.175.2025.03.20.16.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 16:40:35 -0700 (PDT)
Date: Thu, 20 Mar 2025 17:40:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Benedikt Spranger <b.spranger@linutronix.de>,
 Simon Glass <sjg@chromium.org>, John Ogness <john.ogness@linutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH V2] tiny-printf: Improve %X formatting
Message-ID: <20250320234032.GT2640854@bill-the-cat>
References: <20250320190147.1050427-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eiiiOOH1/OrA7Tby"
Content-Disposition: inline
In-Reply-To: <20250320190147.1050427-1-cniedermaier@dh-electronics.com>
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


--eiiiOOH1/OrA7Tby
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 08:01:47PM +0100, Christoph Niedermaier wrote:

> If tiny printf is used with 0x%08X (upper case X) the output is
> always 0x00000000. It could be confusing if upper case instead
> of lower case is used intentionally or accidentally because the
> actual value is not output. To avoid this confusion, treat output
> of %X as %x. As a compromise for tiny printf, the hex value is
> then output correctly, but in lower case. This is done to keep it
> tiny printf small.
>=20
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--eiiiOOH1/OrA7Tby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfcp2UACgkQFHw5/5Y0
tyzJbwwAk4Lm88OugqPmrTULSorgPu6ZTI4owPc+tTdKLolpFJM3A+gNE43CD5VV
0PbeQEGTE/cROSffWjiKUEOsqSKBKWzcuteyRS7N+jV4DXgFiEzcwypeP5IFKEqe
O0/FzztQyGmv2hpMr05/2ywITvH1Y+bh4NachoO4QC5YcBaPjH3fmCvE3TjZvcz1
YDiGnadfRqbKvjopzwnXmyNJKdqsW1refhZTLqCbjaQBcG8P20IFAW/JswsrxpA5
wx1UPtYb47b5CWkA3WHKvJaaphirekrSq50ZrPajps07CTQx9Lt3JHwSpTxN5mTV
rfEcOs21n6JhqU0Eseijb3K5L0F7cODh5g7OPxOK+9Eo40pKiFfru6FovaP0Phi5
KOU2XjKdXEcz9eWNB7khXggNWhOvnaIOpgi0OVYZAWKmhZDjAnxddi6cZQgzNI40
Oink13lxj029VRW/EkmKD+YUMxyjyzVi3IOfOfvwzBGIFSdUz5oiax/yCF17KYOc
m1gvuYyW
=uU8/
-----END PGP SIGNATURE-----

--eiiiOOH1/OrA7Tby--
