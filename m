Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B763CAC59B
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 18:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52D058329F;
	Tue, 16 Sep 2025 20:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="flFSCe19";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56D4E8323A; Tue, 16 Sep 2025 20:27:54 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 309398338C
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 20:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-3318dd36a8fso2839566fac.1
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758047271; x=1758652071; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YeMzjw61Q7NIMRFmHNFFW0Z1LVaGWNB/yNRoei4Quw0=;
 b=flFSCe19v1hXj9pDjLCEvZe5nEUC5pKJftVaLivAjKQSYvijPZsf1b5ZKdEhX9U3NC
 a58MzVRey38TRtpzjXak9086BqOFnVovteD6RVXzT1SZZGHTrcmabPIG5vnkVSv0KAxE
 sogIO05y7e56wffbWfR3/aJyVZNGDmgQ+0T+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758047271; x=1758652071;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YeMzjw61Q7NIMRFmHNFFW0Z1LVaGWNB/yNRoei4Quw0=;
 b=s7RCtgCf5xsVCFaN8VQuCKOzUM2ox36VXDXQ21aPZuvi4uY9AFj3/TWuUcJzrTU3Xw
 u1wdxSM3kBPCMM7050pEmcfJkYN2UMDxIQ+6ePIZa4qVsxQnVV9xEmH+6d/JRmlvtQfJ
 O861iYE0Ykr3LjlnzWfwlGJB1kGal95zRT1EcclVJdCZJy6YqN+5iixy3B90KdFcvCt1
 wLnFyAF/fZx+mPgxKi9L/EoXfbxF4KScq2GPOHkqZrxHd5omSVhk3HnVBt/Y1+NDc24s
 6LsfpcINkFSv8YvImjqMye7/jW2v9CZiEODnEPAALPCORni4vuTOztU9E9Y0cYUQQPmG
 mNwQ==
X-Gm-Message-State: AOJu0YwRkL1d+BmqSKkEkNEltWBtv17k6UZY1E//aOM4QXJjOonjcRA9
 /ujNP4MlkGJDRQMwUHKjtHPOkNB45GPeY11n1r3EbFzypb/5TJwwbq9VhuNzkIy8erk=
X-Gm-Gg: ASbGncvXb/hgKad5DiE8+0SiI5y3Itk8+bqTx7/67VhQlhLLkaLWDNP4j+oKVgil1Xo
 Az0dgQDghBtByV7H7hiN9xqAJcAW9QNwnEY1DHPxsEznx2TJpxL6Tsp/sylhZmnRquEDyTR61Ru
 3b8ISim5pljXkCnjOVN3X2vI/A4kArxB4jsURB+plG0AQXr68+IqlMfv/zhHgU9pf8d9hQpVApV
 JMkUntzYaM+JP3kN0M9Vz3/HGnudMEfMmEK5p6cMECTi7xSSrQfKyuRFaB83QkGpAkE8d/kjgpu
 bVszCzlluOZB98UTGX5f2taI9YPzzBPdh3H1rIxIKtwjJDtB25RsuC2rCRtQHiHMRCgWwTdOGky
 +8qiX44NESNYQ03AYcxDFkrwyD9zI+9r6P7pKRwxmP7bOyiMq8Gp4ArEz0LfyNjlkJgE=
X-Google-Smtp-Source: AGHT+IGz9Q+A7y5B1djhgGNWy1GlMR8i7R1CJYQiO5WnmTYYU6mnGzolitlpNMryNzI0DH6SonBYPw==
X-Received: by 2002:a05:6870:c18c:b0:333:d80:763 with SMTP id
 586e51a60fabf-3330d800bb4mr4240456fac.45.1758047270861; 
 Tue, 16 Sep 2025 11:27:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d35de8809sm5019052fac.31.2025.09.16.11.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:27:50 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:27:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 3/5] pytest: add test script to validate Firmware Handoff
Message-ID: <20250916182747.GA124814@bill-the-cat>
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-4-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u0rN44Ch5GC73nfL"
Content-Disposition: inline
In-Reply-To: <20250916161426.32259-4-raymond.mao@linaro.org>
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


--u0rN44Ch5GC73nfL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 09:14:19AM -0700, Raymond Mao wrote:
> Add test cases to validate FDT and TPM eventlog handoff from TF-A
> and OP-TEE via bloblist.
>=20
> For FDT, the nodes 'reserved-memory' and 'firmware' appended by
> OP-TEE indicates a successful handoff.
>=20
> For TPM eventlog, the events 'SECURE_RT_EL3', 'SECURE_RT_EL1_OPTEE'
> and 'SECURE_RT_EL1_OPTEE_EXTRA1' created by TF-A indicates a
> successful handoff.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  test/py/tests/test_fw_handoff.py | 94 ++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 test/py/tests/test_fw_handoff.py
>=20
> diff --git a/test/py/tests/test_fw_handoff.py b/test/py/tests/test_fw_han=
doff.py
> new file mode 100644
> index 00000000000..4cdf51a4375
> --- /dev/null
> +++ b/test/py/tests/test_fw_handoff.py
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (c) 2025 Linaro Limited
> +# Author: Raymond Mao <raymond.mao@linaro.org>
> +#
> +# Validate Firmware Handoff from TF-A and OP-TEE
> +
> +import pytest
> +import re
> +
> +def _norm_ws(s: str) -> str:
> +    """Normalize whitespace for robust comparisons."""
> +    return re.sub(r"\s+", " ", s).strip()
> +
> +@pytest.mark.buildconfigspec("bloblist")
> +@pytest.mark.buildconfigspec("cmd_bloblist")
> +@pytest.mark.buildconfigspec("of_control")
> +@pytest.mark.buildconfigspec("cmd_fdt")
> +def test_fw_handoff_dt(ubman):
> +    """Validate FDT handoff via bloblist."""
> +
> +    if (ubman.config.board_type !=3D 'qemu_arm64' or
> +        ubman.config.board_identity !=3D 'fw_handoff_tfa_optee'):
> +        pytest.skip("Test only for qemu_arm64 with ID fw_handoff_tfa_opt=
ee")

This (and the other tests) should be more pytest.mark.buildconfigspec
but for TARGET_QEMU_ARM_64BIT and then relevant TF-A/OP-TEE options. And
even then, possibly just the relevant TF-A/OP-TEE options as it should
work on other platforms too, yes? Thanks.

--=20
Tom

--u0rN44Ch5GC73nfL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMmsIwAKCRAr4qD1Cr/k
Ciz+AQCz2+p5ZDLvY2vjmDPDT39L3aeaOUiUUz1i++3jv5VP2AD/YkBoYUxQjQTT
ppI6ElMG71cjKj5GHy+BiowVyRUsxAQ=
=WH/E
-----END PGP SIGNATURE-----

--u0rN44Ch5GC73nfL--
