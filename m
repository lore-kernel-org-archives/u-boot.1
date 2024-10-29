Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2830AD7494E
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 23:53:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA9E8891AC;
	Wed, 30 Oct 2024 00:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mcApVMyd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5502C891D1; Wed, 30 Oct 2024 00:53:26 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2967891AC
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 00:53:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbe9e8bbb1so41274826d6.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 16:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730246002; x=1730850802; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CExPWMiKQRIutTrLO2T7VUUJnvWUo/bGEZ+u4sF94uQ=;
 b=mcApVMydGK4Yt4tWKAbdcdLx8tKNGxAikWtdI0IjG5HZXGy/O3ZWvDM+pO9fDykHCJ
 k5INhisLNEz7xaXb0l38+c/i8nZ/37rT8KDoDSUGkW9PN7LWyOSsgIwyC/BeuNNjRJBY
 nu2ogUZr5iC1Qumup59ZL0lXbRiKpwPWEw6AA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730246002; x=1730850802;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CExPWMiKQRIutTrLO2T7VUUJnvWUo/bGEZ+u4sF94uQ=;
 b=hZFzwW0HAMCjRKFkZHXVy1cY+HEW1syQ3QBNRDkSSGkOzPlK1Fhz7yX2wnS2FzYGXZ
 7ttCGV8sp5xOBKIMR/LSBcdyCgEi5P/uEATwPd7Ta2nZ1Yvlx0do5Mqpn6WVWWzKioyW
 V6dphid1Kmp+xz8kFFpluKU+bSOvDDRfxMdG4qcDTgdCD/M/EgC3L7KpQicuqn3QBY98
 VGvqDTmOf/H63KPJMRVyjDli6NlYsxI/LsNkaBeiaM5tjJpHkyIiAp80bu5vyvT/qFKq
 HDdPKKdWUqh5CvkeF4duKtN7kXVrJSqM9jtTlyCLYN1f5yaqK+KLVk0jIzmFCDvXTDpk
 6jLg==
X-Gm-Message-State: AOJu0YzS39JX7E2zqz8BonE2RSpdU9MoDoZgdQeGsHxiw4Wqm7UMHZXr
 5wR5polcqguMCEk9g6ro4r1nzSjgpUx5xzIWQB83Nkscc48WglF9TdC+r5nfsQNBQvhAW07XDFs
 QWxs=
X-Google-Smtp-Source: AGHT+IEogDpXmOaJZcvbx0GmvlcRXepKa9NXXEJBBp49EXNskhZ4zqOSpuuzW2R6+MrG8xrTJp5Tpg==
X-Received: by 2002:a05:6214:5a0b:b0:6cc:2d3c:6472 with SMTP id
 6a1803df08f44-6d1856b4898mr179856886d6.14.1730246001844; 
 Tue, 29 Oct 2024 16:53:21 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d179a2b114sm47008066d6.114.2024.10.29.16.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 16:53:21 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:53:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v7 05/11] test: Introduce lab mode
Message-ID: <20241029235319.GF2558755@bill-the-cat>
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ogHCkxw4Ng2P9Zhm"
Content-Disposition: inline
In-Reply-To: <20241010015145.1977999-6-sjg@chromium.org>
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


--ogHCkxw4Ng2P9Zhm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 07:51:39PM -0600, Simon Glass wrote:

> There is quite a bit of code in pytest to try to start up U-Boot on a
> board, with timeouts, expects, etc.
>=20
> This is tedious to maintain and is peripheral to the test system's
> purpose. It seems better to put this logic in the lab itself, where is
> can provide such support.
>=20
> With Labgrid we can use the UbootStrategy class to get the board into a
> useful state, however it needs to do it. Then it can report to pytest
> by writing a suitable string along with the U-Boot version it detected.
>=20
> Add support for detecting 'lab mode' and simply assume that all is well
> in that case. Collect the version string when Labgrid says it is ready.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

First, I worry that this kind of change will make verifying boards can
reset harder, not easier. But second, taking the "tedious" part and
putting in another project's config file instead makes it no less
"tedious". If I follow the labgrid code right, it's got the same kind of
"check for a string" that we have, except it's not caring about the
correct number / order of banner prints. Which I find worrisome and a
problem because of the times I've caught "oops, didn't actually test the
right stuff" because that was wrong.

--=20
Tom

--ogHCkxw4Ng2P9Zhm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchdW4ACgkQFHw5/5Y0
tyzcxAv/Z2iC4Juz+pBYNkUDjz+hD5lgdZJpfsCIRy3mzpY1KLzPZNgqEIVeNUaJ
njoWWJftk4iVuBaFF0bNt33rc/dLL53dcwDJFSsXRkkHyFiooAWkqnmV8r1eWOrG
cSVP5ZEI6RbD51vjfnzPQFFnZ7USgVnQBN/8WHnEufr/8XttAwPKql+OrW3MQFrw
fC9O2+5m+Upap7mqlWQFAiYRKTD7BCdqmkIs6VRjJZO03Ej43223oXMLz+2/GLcJ
Im/O9hULc0jDYhZP7SnwyxRnRrxA9LonWbfxVHAehy0QbUsMYFbrEcXs0/Wf8wcY
zwoEyGfwWV93UBIvxMKXD3Z/MNrAmkuSH8ZkinhesgoHlJ+zL41U1LgNlJPkGnnQ
Dd9qGComh5kHex1wxWc4Ef36IfLjh2/t0jg5wLjq2IcXxFeldGOeVWa0Rd7twyUQ
bGnWKw0c8bphK84/w960WHbEeKljrpwEuGvTw7mauTeIL2vxfezn87IxLkAsbojk
Jem/eNFP
=EWWW
-----END PGP SIGNATURE-----

--ogHCkxw4Ng2P9Zhm--
