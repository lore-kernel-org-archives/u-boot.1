Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7058DC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 19:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A663382103;
	Tue,  3 Jun 2025 21:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZFWvq1qo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C8888283E; Tue,  3 Jun 2025 21:22:13 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 724EC807B1
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 21:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2d0d25cebfeso4409698fac.2
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 12:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748978530; x=1749583330; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tg03LktMv9VddZlpo8tq6W/JIU7+nhouLPIx5oRhyh0=;
 b=ZFWvq1qo16Omg1GQbftXtmQ3LO93WBP0UyM/Vqn+e+QkvzFqH4nrp1+8I9gnLu+T1c
 ZpMpeX4opr3k+eKJuGb8K0ZqieRV+ZxMbaXH4Ht2vuj5c5nq7nwi2QBauyIxRDHny7nE
 ZbPtyg8YLrrVWDiBnvKWSIO0aaRtKqUjkT5vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748978530; x=1749583330;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tg03LktMv9VddZlpo8tq6W/JIU7+nhouLPIx5oRhyh0=;
 b=u+XjjpTudSjfTq+jQOxFHcQP4yM+6w/aKZS2Pm6X8LUDig3wuUiY0h5W6zyAF1HKMa
 ekvOf0dzG6h657NdpIUrCd+I6Y6BS0HmbU7GwFijT3swIeAEtw9xM8RP1c8QkXS2YrGW
 1NG1cDmmT/+b2w0KjzlKgMs4qcQQqFohR8lwY9H3Ig+SRfifdqbn4h7EOZLIfV1ZWgIG
 3xN2qecbOR5Kif4kItw1Ed8H5k4tezhBIosoMZkzQbtfzWzgsGKI9mfsQhJB7kr7+Gv0
 csfA97oivDIc0zm/bObkrt41PndCy+W2kuE/zFkcG7W0l+cnR5/IFwwHLP2cci8OxC9t
 Cy0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvL2cqMVQt04ntAJ4vUv96IEs1QrpimGO9MSpUqafAYXEEF6iahRhsGF+1EmazHey9BWKWJek=@lists.denx.de
X-Gm-Message-State: AOJu0YzMWh3xilpaMDJmLvmwi2/4UHRNAMc9z5NPf4AWopxCQ1S2Bs3T
 8Q5nhDZt/fv+Bc6+AZD2Nw4RcP1fK3juI96Yo5Hptu9grMNxETVEe+pF9q3lML/4d3E=
X-Gm-Gg: ASbGnctLjAT//vHWgT+jvnOmuyqv19cVYdIBrKGD+bViHeKgIOthnYvQuPvxIpVbY2K
 3YL4FBISq1/lL4K+eD0lreIqTWpsl6AlIBJsUU65d6JwUr8Z4J1pNeRKlQCZnZ/lUv22vMvpC3q
 S50XsrvstJDVvnELeAd4K8amwBt1+zZsS+VztoevcPIgxT2OhSqNHBk/VlqaCAsMPzJ6tDsRjCk
 DiY9U++054AQyqNDoyHjJM4n/+zR1KdaekUtsbPDUX6udMrJKq+tLgUSvlxcaQeJYGR/6XyDCGz
 WLLvb94jsC45tShadL01deVQe8RH5hMwlOwCsMZeDHhe5rFYFOzcpyWH1Z5O5XGg/i1ahmXc/qa
 DPOANubxWja2P
X-Google-Smtp-Source: AGHT+IHEa5kbvC4m4i5is4wbVR6Zml+hvCuCpVapSsTrQZo+u/NIF9SJCUMVywuSvhI457D8qkecaw==
X-Received: by 2002:a05:6870:9f8c:b0:2c3:1651:ca78 with SMTP id
 586e51a60fabf-2e94884371cmr9354037fac.14.1748978529980; 
 Tue, 03 Jun 2025 12:22:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e906c13c13sm2344237fac.45.2025.06.03.12.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 12:22:08 -0700 (PDT)
Date: Tue, 3 Jun 2025 13:22:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, quic_varada@quicinc.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 seanga2@gmail.com, ilias.apalodimas@linaro.org, me@samcday.com,
 christopher.obbard@linaro.org, sughosh.ganu@linaro.org,
 sjg@chromium.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v2 0/5] Introduce support for QCS615 SoC based Platform
Message-ID: <20250603192206.GK1382132@bill-the-cat>
References: <20250521035324.1182833-1-aswin.murugan@oss.qualcomm.com>
 <e6bd9135-3ab2-4eef-81c2-f08f1197247b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EmFL9N1lIoOSAtYj"
Content-Disposition: inline
In-Reply-To: <e6bd9135-3ab2-4eef-81c2-f08f1197247b@linaro.org>
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


--EmFL9N1lIoOSAtYj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 06:25:22PM +0200, Casey Connolly wrote:
> Hi Aswin, Varadaraja,
>=20
> Since we're expecting to do some more cleanup after adding all these
> dragonwing platforms, would you be up for adding MAINTAINERS entries for
> them? This way you'll actually get emails when there are changes affecting
> them.
>=20
> My suggestion would be to add a MAINTAINERS file inside board/qualcomm wi=
th
> something like the following:
>=20
> QUALCOMM DRAGONWING QCS615
> M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> R:	Varadarajan Narayanan <quic_varada@quicinc.com>
> S:	Maintained
> F:	arch/arm/dts/qcs615-ride-u-boot.dtsi
> F:	configs/qcom_qcs615_defconfig
> F:	drivers/clk/qcom/clock-qcs615.c
>=20
> And repeat for each platform, set the maintainers and reviewers entries as
> you see fit.

Note that if "dragonwing" is also "qcs615" you can do:
N:	qcs615

And it will catch all files with qcs615 in the filename.

--=20
Tom

--EmFL9N1lIoOSAtYj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg/S1YACgkQFHw5/5Y0
tyyl7wv/QmQHXqsKnmbCE2gk/dWx9T3U72wOpqeI32QIob1HD1/yDnOOtDhjgSpn
QVTE+sOhf0yaVp2XTIBb0atSoLBaonvq6asTWzUsLRBsSzepB8wQCsgY0kkHJnqP
z2QUZ++cMxJdLvysSKSAe1K17slSSCpcD2Bwh0H/iI0h3FASvpQa2NXFmAP4bHo+
my8Q7NRknz9g2jPRF14HfLQv2nuysMwC+dvUQIu3cDQSSvxD8/rT7pNfzNeXd9NQ
i320ghpAMFsae/gngnsn1uGfEpTzxHJxe0LaSGGf5khHMp+rCpDCaj8YDOMGye/A
1xGfQGpKrZhTqAdkdYZ85tUjuRe8n9rBDTtUdXSj34mqwD4EOleb7PoD2k02ZuD+
dAe6errg1OY3AQgOZAhBHkfP8tFPporqIRZYk7E7CgMrHRZ5/fQDohYolN4btWV4
5xr/ZgSn/GS40XU9IIq+B2jMThrgxv20Hl+tRySWCv3l5sMlC3lzX0foZJsqsSSn
tW+BBKeS
=Nmw+
-----END PGP SIGNATURE-----

--EmFL9N1lIoOSAtYj--
