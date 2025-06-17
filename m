Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F94C71136
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 22:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ABDE82B20;
	Wed, 18 Jun 2025 00:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uNXUzTFB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A6B782BCD; Wed, 18 Jun 2025 00:43:03 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29F1B82B18
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 00:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-407a3c0654aso4299958b6e.3
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 15:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750200180; x=1750804980; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=slsXDUJ6S80GM2gzYLnMzIIDAo9pp+XdUAAwxcgMPD8=;
 b=uNXUzTFBYX9ZBNyxXe+PZvu9zxOD5Q1grdLXABxTFvvqZbqLZexE84GLO51zViuIO9
 hWlpzYvN39UNqqlOJLYQCDdWSZkee1G7u0DCMYWTmaZAAX7/dTZNC4s4qiHjIFDUmGPN
 jDtDCIwkZXdatF0fIK98ueaJnfyEiqaF88CVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750200180; x=1750804980;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=slsXDUJ6S80GM2gzYLnMzIIDAo9pp+XdUAAwxcgMPD8=;
 b=VzgH1k7FfrRa//jpemmTKDSIvBJRlxTKdibIrdMHUnAKQYKad4Q6KfgoXqAY4471nk
 vouoTDixWWad7R3/rlSIHTxcJ3RgT9ZI5W9LvyfT/pRw0JpfWDUPkZ8RRItNXMSc7hTO
 fsnFxqDFtQTmeyep9ex7wc3vWOWXhve8UHrgl/qe/ocI17VDyBR3GlQTRvQUqzV1FgZR
 RWQL5sWlQiM/MO4xWzFyf25l1Fe8N1cyJPUvKpF4cxuk+LnVGBQhvUoHQN+d1X9VWcBK
 hQwPhzzZQoo3EP+dU/UQbxYDvUxAlpVuNDBixDs2jozeFrCdqrVbhWvzY7CL/QQdu7Qw
 M3Sg==
X-Gm-Message-State: AOJu0Yy8m6ohqQFQOU2Vk7esPq6hzHoYUYq0pQ2QYeR46y604jxFeTHL
 aEzKWI6J2RnQaRq1ZpLrUYpYUVhH+XXodUAB5rocLZ6fvpHmMm8eoMy6mWSUery01Rc=
X-Gm-Gg: ASbGncvEXtm7o45YbJNO6ED/+BQdf0c2J0Wc2qcEbLAKCZmAjk/N49LstEBHWuVCK5q
 5mrq2ZgwSOVsI9L127W5S2KTWHg9kuWV9webPaa8/6n6LDuXtZWiuMsi2feerWrHWXtEwcYQ1+A
 ir9tziMBj8Ha/n9pIMrXWhmlNxS0fo0uDOH9hH9JCoO+hD1Mpf0x7Lkk7RpZ5sYPZId+u0+0Zev
 7lxKcKUXl1j6ZyqDIgNOXSijAbWHwzVvuolN7nNm9iEbY4pbvhb9oexTSLM4BJFSZlmChLnEiNP
 ynvB1DVGb0F78hH2H9+gFNqEm8VqFMCtu6uJvJ3Toc3w/9yVTgMdz3t69DQWTEeEXRZW7aZ+S2p
 Mm1rPsuwhJrPP2YcNbjuTxTo=
X-Google-Smtp-Source: AGHT+IFFQgEG4KpzYx/33DK/PR4DA5vGSFQZUQpI42JUKB45q3GwTavDvaoRRC6KgCgV+PO7B+R4LQ==
X-Received: by 2002:a05:6808:318c:b0:409:10a6:41b6 with SMTP id
 5614622812f47-40a7c1043c8mr9390754b6e.1.1750200179775; 
 Tue, 17 Jun 2025 15:42:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a741b8f22sm2082523b6e.43.2025.06.17.15.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 15:42:58 -0700 (PDT)
Date: Tue, 17 Jun 2025 16:42:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Harsha Vardhan V M <h-vm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Wang Jie <dave.wang@rock-chips.com>
Subject: Re: [PATCH v3 12/13] doc: add doc/cmd/sntp.rst and remove
 doc/README.SNTP
Message-ID: <20250617224256.GP1382132@bill-the-cat>
References: <20250617100720.2544758-1-jerome.forissier@linaro.org>
 <20250617100720.2544758-13-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eOVfqf/TT7sYlLKJ"
Content-Disposition: inline
In-Reply-To: <20250617100720.2544758-13-jerome.forissier@linaro.org>
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


--eOVfqf/TT7sYlLKJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 12:04:02PM +0200, Jerome Forissier wrote:

> Add a proper documentation file for the cntp command in RST format and

sntp :)

> drop doc/README.SNTP. The documentation now includes the NET_LWIP
> specificities.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> - Create a new RST file and delete doc/README.SNTP

Thanks for doing this. I see a small problem:

[snip]
> diff --git a/doc/usage/cmd/sntp.rst b/doc/usage/cmd/sntp.rst
> new file mode 100644
> index 00000000000..eab7c664728
> --- /dev/null
> +++ b/doc/usage/cmd/sntp.rst
> @@ -0,0 +1,72 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +.. index::
> +   single: wget (command)
> +
> +wget command
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This isn't wget but I assume you started from that file.

--=20
Tom

--eOVfqf/TT7sYlLKJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhR72wACgkQFHw5/5Y0
tyzppwv/c3nj/zNdn4fNaV1oGoKsDC0I8Iz7UXtpk5GhRB5IJkG10WbRbKjzhQqP
S+tLmJtlN4i+3DVTsbSvyPQG9Zl3vUqt1sCju28kSZnsTPtlzMcfO/lWHcUZLDj9
AXiPGRnw2OXQTdD+w13aDuF1bZc7d2K4lWo9DpjuKB9Qm8IsCK/S6jBSFkPDPmdF
7mRdRrWKsxXpdyM4vDXFtdSAsT1mBo33bH4Y/Hwimb9MgwLc1fGp0G3Tjbm9fJ3U
EjpRq1iW6lSNbchDOWHEc4s4vesEEV/rgilMyamqcdZ5yLhYAIMhBr0khHDCKMLf
VfkKU0GG9OmfiTm9PBaSV5KxGE6t5RuNbkAZJTHmqazVLY8RrNUdJ/yXbe7EmTV4
SITNKvXd2lj8VtCI8WdaUlyAia0wAcCXQhUu+RDxmngc4E69Bq1jDc/z7KsIjdG4
F9PWAfg4tq0vT4BFTgrAwB91x3Xjg/+hMhrQ7jXNLXKbX84HHgTIC1uYktvbrkVq
ricaaHzL
=Uz7K
-----END PGP SIGNATURE-----

--eOVfqf/TT7sYlLKJ--
