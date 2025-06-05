Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E414AC5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 20:05:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E73D8091A;
	Thu,  5 Jun 2025 22:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hl5kdfoz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3630C8091A; Thu,  5 Jun 2025 22:05:13 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAADF80050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 22:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-73502b47f24so831113a34.3
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 13:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749153909; x=1749758709; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I+x31L1hVhhGWOuAh8R7go16kolj+p7tx8JoxdSdZrs=;
 b=Hl5kdfozsKzChXseaawJms14ReZVyjDqoZTmawxUiDfqPYFNT7h5Z7e7/dZ2M5SqlF
 Q1f+IXoLFz+jQ1hllE1bcMe1t3d8w7HcsskWCYA4LMyfNTwzffDfWcbBtmR/CbVmm2md
 ck/55dxu5hpuA2wXUXkauprR3rvOOHggBZrK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749153909; x=1749758709;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+x31L1hVhhGWOuAh8R7go16kolj+p7tx8JoxdSdZrs=;
 b=hZ0hxHZ0uh7v8TzcBjeKIxK1t/6AbYQ5RSoLQo7XRNpEtdiFRK8Sd95gaDO4pB/GAh
 CjeLCa+qLQuuGWL0wBIw43eP6tuXu1Y+6bTjh1aOV5xGxq0WEZNCXj5H8n2tyIIdnK/X
 WCjeTnSWA6ph/cduEGpF1jpslKCChZsHzVVho/+zDRlyVDx/4IdpGrRdZ+ol32zAEIqq
 K9sVYCjDgm489OSaCWS/bAylx1SvaFrmIbjK5nCie/qDjcTrSvQ/RdmSkrZqKMvNho4Z
 FOIUEyCGBcbKB2bXPbTJylDNCxdBzAe1UPaNX0Eermvc9JeVhHW8pqivvLv7u+1vqmXi
 yc6A==
X-Gm-Message-State: AOJu0Yxx0LnYVVzFEReq7vuvuKfe1MeyQ4LoUULRIHS+EIrp6jfWFdFs
 JXCGUpU8GZgU5x8xYZs6yy9b+oUJ4QUzkc66xq3xPsnneh9/r8Kqylrh7cToiRb5iDiene/EXJk
 pUClM5mE=
X-Gm-Gg: ASbGncs+Sw9C83RHFZxXtMYC4sPyqquqJD/PwEF3tOFUlYIlwvAu4nv/nMT8HcOqaA7
 V8rLRWWl6QN9OJhkmnFk6nQsnObzS+/11JOadXhJoB5xhoVt4YTrahXxDcWIQDqB4k6bbypXXfa
 idNOefbdJiBSHWxIP4adI6Yn585qoIQu1DH+kjnhexhKST1xgHmPe/CnFzTgnPtakdoNSsmVyGi
 8nhXzqWiW6qmIh6lSLpb/b1JcBA2NDPjfXrxYDrLg7iNS0TnO3MXsjs3j5vl/+PUs1XNvtTbKGZ
 e5L3SssWp/IBC7CxXA/P3uDObxuCfogUS3eQBWJn3UxNUrIrJ/4kiqblBF+x8kw/ry/5iLpyyEN
 /bQUY6z5ij8BA
X-Google-Smtp-Source: AGHT+IFAJzzCX3NaPtO1m6dIeWy5gdb6/h2AAkvo48ulZryQczjCG0IDgYvdVxMkQIu69+sFAWE68g==
X-Received: by 2002:a05:6830:700c:b0:72b:9014:f5cc with SMTP id
 46e09a7af769-73888f430eamr647268a34.25.1749153909513; 
 Thu, 05 Jun 2025 13:05:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73889f5a1a1sm36451a34.17.2025.06.05.13.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 13:05:08 -0700 (PDT)
Date: Thu, 5 Jun 2025 14:05:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [PULL] u-boot-riscv/next
Message-ID: <20250605200506.GF1382132@bill-the-cat>
References: <aD6aAdsMpatCgcIn@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fINPpu5Ksj5R4ASy"
Content-Disposition: inline
In-Reply-To: <aD6aAdsMpatCgcIn@swlinux02>
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


--fINPpu5Ksj5R4ASy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 02:45:21PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit d45b1d4ac94710f88902adc2173d7930700e28=
69:
>=20
>   Merge tag 'u-boot-dfu-next-20250602' of https://source.denx.de/u-boot/c=
ustodians/u-boot-dfu into next (2025-06-02 08:43:10 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
>=20
> for you to fetch changes up to b911af6d60d3be570469b92df751874dc376336b:
>=20
>   MAINTAINERS: riscv: cpu: th1520: Assign myself as maintainer (2025-06-0=
3 14:17:46 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/26483
> ----------------------------------------------------------------
> - board: Convert Lichee Pi 4A to use S-Mode proper U-Boot
> - RISC-V: configs: Raise SPL_SYS_MALLOC_SIZE to 8 MiB
> - driver: Add SD card support to the Beagle-V-Fire
> - MAINTAINERS: Add Yao Zi as maintainer for th1520
> ----------------------------------------------------------------

This introduces a failure to build on microchip_mpfs_icicle currently in
-next.

--=20
Tom

--fINPpu5Ksj5R4ASy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhB+HIACgkQFHw5/5Y0
tyyntAv8C70q0GlIXfRbUfdmE20PdVkvRA+ctr7X0pCCYWXxzr4Kkw3ASzHS3C1e
a6tpLgCOF8cW2t9BENUtWCdhmhnyItFzff2178/9AvWhTqa2qgJWSYNN1IYT0UmB
qFJUfSfca/KAZ7vDqe3QMzubFlnr70NRrE7ZljQIYQRpq7I3qxf7jtSfX33iUWWn
gMIkZ8eHYkhLTCTofMVqE2tuaRnd/nTvcU8Ggp/v5tAgAxkyxyYjT2p0urYBzHv/
uJpEmLCNY8reEqObZjOP5/LI8KfPH0PY8JfWNVHdXDNnDDUcKfkj7MhRyGmwgKeq
zobKztGewHo7ao1sLd4uxTL6TMj8uv5pmiPox1n9B9BMhRia1DfQpFRfVKVet2I3
Thon2SrEZcQUzoJWLXCJztM9FQCVRa7GX4RB3GRukWxgLjsricnsLqvBluq6zJo2
zPwfn5k04rVWkeREio0Kwp72/UD5JTl4eXIFaFVBxNH16Hx16Q+/7TGlug9OWef3
IniD+z+q
=laOW
-----END PGP SIGNATURE-----

--fINPpu5Ksj5R4ASy--
