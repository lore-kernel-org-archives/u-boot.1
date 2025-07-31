Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6779C87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 16:06:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49A7A83918;
	Thu, 31 Jul 2025 18:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nKvHTbXT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4A588309D; Thu, 31 Jul 2025 18:05:36 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7585283914
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 18:05:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2ffb85aed35so708977fac.0
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 09:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753977932; x=1754582732; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vom0EiFYXoy00k0eQ94zWi6ThZnFOKxGYN+H8upquIM=;
 b=nKvHTbXTNLYAp6WkTL47APhanrHn3a8RBBJHeHDvbWn66l4q2n3x9FtL4EjRFVv6t8
 qY3N6lbqxRZkMrKOT7LQjT9/Kdr84uuhWRLrBYRxl1OU+nhWQU4XUf6xrH2M5O4D2Z4/
 +JKMVa1PKuezFAX8oEgcc7cz7xDKZwEDs4l+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753977932; x=1754582732;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vom0EiFYXoy00k0eQ94zWi6ThZnFOKxGYN+H8upquIM=;
 b=Tu3gxuFgtSd0NiY6MpNL+WLvD0mFb/hqjbkAEjZoZwL7jzkghTfHc50xk+kTXY0NdJ
 J9UqO4g1OVD16T398jxFcsXdrpNG1tjfP6KJJfO2X5/LLmpolattXZtFtPzTnLlO5SoE
 ivSAAACOHrcDs4JB+RuLpFIa4H7rASWXhvUhMzHAigv1lirK0wewd6WH7VavfD66BrA+
 H8FNsUFOpQz11PKVK2l6GjunlZXIVNkuQPDgWrEhISxxGB4tQcKdwwzEYZGOigd45xGT
 4dtMPw9NqaMH8CNzme9kEk4FqWhFdYJ0JDyJAhU7dIeKOIz/llvXnNTulwAHBLqxsoac
 43lg==
X-Gm-Message-State: AOJu0YyysejD3qFLExmjtDnhqnb/Qn5GJ8FJ7nylR/sXP/OqQRsPMWtA
 PJ8Ypfo3WCXuuat1qo7S2R85LCQ/DXYmVW1u7fnGGKjZU0u9928TB7Q045nUchpEdwA=
X-Gm-Gg: ASbGncummzuflAzT3bQRUwzmQQVGwqIuRu2ZsdFjVqsURUFVR0iy+tN0vfDqVwBv8Us
 bbK9bCPIzPBsO3yNBY3lZHtPaxqyIW30CgM59xf6HkWTeNC/WsYid5Q+Q3GgzAfPbaprik4VESg
 +7CG3CasLfvG1vQoOw3Ut7yzVEiocjUvQYPcG+F1iZ6usmII5dv0Y4VxE9FNV7fiDzsDa69zgyt
 MsdlDPd4L7hPUhmjKmSOb/sKOjUYfftT5q2yAssuST29Oq0ddcr0qOzflooHiyN44QwbDDaOroM
 vBi8E/3P50Fj+O1rtMTG02ru+iZbN070Z/twq3PqNvkC9UgKoWCfS0N9SLXILhyptauxcaPvnX0
 xR3hkUtWK65+T6nbT37F4DI7Q+04alJp1A+5M7OT0zZ1Au4RGYnzrG+IN0VS3GK/GshM=
X-Google-Smtp-Source: AGHT+IErEYQrh0qGwRjXXbgVtgW4zFhEhrieHj/XTRr/VVjB/yZBQkxWERKbbeEEQQSmZgwv5nMydQ==
X-Received: by 2002:a05:6870:5b9e:b0:2d5:2534:ac19 with SMTP id
 586e51a60fabf-307859d571emr5535248fac.4.1753977932014; 
 Thu, 31 Jul 2025 09:05:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-307a7120beesm441012fac.6.2025.07.31.09.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 09:05:31 -0700 (PDT)
Date: Thu, 31 Jul 2025 10:05:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2] CI: Wire mbv32 combinations
Message-ID: <20250731160528.GA1807455@bill-the-cat>
References: <02e5c14552b05200ece94136db0077cbdd47738c.1753945577.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZLrL+y4cmZ+x+gja"
Content-Disposition: inline
In-Reply-To: <02e5c14552b05200ece94136db0077cbdd47738c.1753945577.git.michal.simek@amd.com>
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


--ZLrL+y4cmZ+x+gja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 09:06:18AM +0200, Michal Simek wrote:

> After upgrading to QEMU 10 by commit 1d782a3f229c ("Docker, CI: Update to
> latest Ubuntu and Dockerfile") let's wire mbv32 which is the part of QEMU
> to have it under regression.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ZLrL+y4cmZ+x+gja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIuUSAAKCRAr4qD1Cr/k
Cqw6AP4vws3uNX1sdSmd2ZifHP5o5v34UY5j7hcAdKkRolX3rgD8CUEgBkGcPs1s
Pu1Goq5H0xG3tuckrMx66LLWKxgsJw4=
=ZmY1
-----END PGP SIGNATURE-----

--ZLrL+y4cmZ+x+gja--
