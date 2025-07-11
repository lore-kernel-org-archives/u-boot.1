Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFF5C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39D598277D;
	Fri, 11 Jul 2025 17:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PRTs4sBb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC9F482E37; Fri, 11 Jul 2025 17:45:44 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7F1582D21
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2ff1ed124deso671096fac.0
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752248741; x=1752853541; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MPU0zFzTTR7eCUrannp70tx+/IFEcS0Hq6xX3jxKTqo=;
 b=PRTs4sBbjHViBbtTLHoZGc9ik2XVZq89wO7M71RLGlRSNy2dHA/qeEOu+tiraaKiuK
 5xKTf/patUJfiDOMTckVkc0eZa5MHxMamfoy7IF/gsG/eNjfz6O+DI/LNJ6IvZEtkJLt
 tzv40LuD42f/CQz8AtSI+M5GzPD3pRsslbA+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752248741; x=1752853541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MPU0zFzTTR7eCUrannp70tx+/IFEcS0Hq6xX3jxKTqo=;
 b=Z2rzM7VO0bTT6aHABp1jSr2UNXaV4mftQzTZDW8yLLkkl3W+Gh98RVFgfirJUBYF5m
 j+gfpk/ds9YffqUZp4LPjiK1h1EWK6HbWiIAyEM92RjvIrFvhU/gXf8NwQ6nHComK8rg
 tBAmV95Q1ETGoC5bggsxNkC2vZKaqBHrPFZC17YAw/gL+q/ImqsqnvTcY5bGrxvRAE1e
 yXnc4evzusLKDCxosc6DpxRgsrtsDG9D7JTFazhv/l3WrGBpAvvO7tzPSBPaiANc8kb8
 VeTSKIxNtTtGmfH2Fwsil3nxcSz5UnqwslWOXDkMciUlb9cPV6bAGcVfh7NZqtCMBWc8
 2j4g==
X-Gm-Message-State: AOJu0Yym7w88PHXmHfK96wJcoC9lNm0dR9sLCb/SYsBoLTnjNjDzKhsB
 HZ70tfhAxnWipIrqZsu6W7WEIke2xGE6758/pnn52qdYpo1NDL8Q79evPOHZZ6TSNhQ=
X-Gm-Gg: ASbGncvEZa1cyRLmVhu+b53uCBRJp5KJN5r49j7vgqnXUvo4joFpbvJe7CdqXZTj69A
 vHejt8U3BDeYA9BofDeb4OzYdWdoa3CWyXSdauudrAzArMx69p6AczJpjG39wcmEoi/GwOj6c6G
 Mw6pIvoLtC172rV0Cj/dWjI4VbUa0atoy6f3knhVvVeOUKLQqBh1/lH2yBDHEAgOvwLmG2oAShc
 9vLJQlIGFIGxFQjGs//LaO0LnxTIk2nv0afZGpunQdfDsx7LWz0EK4wPmj0iFDNnmivp1RML386
 M7h/RWjXfgxwOCphJNK4NGtOXl1ZuiCiAh9h7boN3M5A5NKLFneXyr7KHS4O4d+7bMuMWJzuTCD
 JFKbKe5aCuq6VphNc4eRHrhyPvjD5IsdKlxIq7IGCma1wq1wI72QH3nu0
X-Google-Smtp-Source: AGHT+IExET3W1o39WZD6/zTILU9g3XWoDqsk568NNlpmRiPvh6I1lZgYO2giEz4yAAcL7RG3nheP4Q==
X-Received: by 2002:a05:6871:e250:b0:2d5:2955:aa58 with SMTP id
 586e51a60fabf-2ff3f379272mr283918fac.0.1752248741275; 
 Fri, 11 Jul 2025 08:45:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff111c5011sm770593fac.4.2025.07.11.08.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:45:40 -0700 (PDT)
Date: Fri, 11 Jul 2025 09:45:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Levi Yun <yeoreum.yun@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2 0/6] Add support for DT overlays handoff
Message-ID: <20250711154538.GI6424@bill-the-cat>
References: <20250704134208.2895595-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="172cyDJgGYsS9ZYE"
Content-Disposition: inline
In-Reply-To: <20250704134208.2895595-1-raymond.mao@linaro.org>
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


--172cyDJgGYsS9ZYE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2025 at 06:41:59AM -0700, Raymond Mao wrote:
> The series include refactoring on bloblist and fdtdec to support handoff
> of multiple DT overlays and applying them into the DT base during setup.
> All changes are aligned to the spec update for supporting DT overlay
> handoff[1].

Which for the record and my tracking, isn't merged yet, and links to
the doc update which also isn't applied yet. I'm fine with the concept
but also thinking that applying this here to master isn't the first step
towards getting all the relevant projects in agreement FYI.

--=20
Tom

--172cyDJgGYsS9ZYE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhxMaIACgkQFHw5/5Y0
tyyhCgv+OIpA5ggY7L4iZ0nYkFpDKeNlqe1d1IC/3H68bQX6ALcKonchFuVma9yb
VoGOgSOaFYuUTge6udaWHAcWIt0wmHSuTYvIxEpqDIe8Codr5oAN6tWmffiq4dyf
/exjK52vyMHQ/bQkboBImVGMMhJMd+8Xj1jlmJmLMMjmXTl3D0MAaYVuG3nFL3wO
KRqWcUyBSBMpML4bJvTsDMi55+ZDcL7VnybY6BGqvHDZURW3s0nqTARIuAEWQ4Oi
8JyOdPgV9MGTq9eypKJT0/6CQBRnysUD7pRx8yGK5yYstJDR4FNgdEY3J43SjDvc
y0BhnqbT4KNv2nhbtxDa4Yj96JJsOGsnSdaRiEGO5CneUp7dFvwZRsNe3QsDUXsw
+T0lrgkfbyvXbPQWrn8OG4pvOHYOujwVe5aw0qK7UEiOXLCF2bom1NZ2shGvuUk4
b+W1c6YiJZGRjjKtQ6RS/ll4NdiOcrVYRfjTgHFSCT79L5xfylDOof00F6Mlc6z+
a/d0hCWy
=THRb
-----END PGP SIGNATURE-----

--172cyDJgGYsS9ZYE--
