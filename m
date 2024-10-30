Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB8FD6B6C0
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 19:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1928F89245;
	Wed, 30 Oct 2024 20:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U+pwB0KK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A8B989241; Wed, 30 Oct 2024 20:01:14 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C613D891DD
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 20:01:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4611abb6bd5so1530131cf.1
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 12:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730314870; x=1730919670; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8+OsR6lUS2t1JA6zlHrWdb9TAxULqvVMVLNYA+3rHfs=;
 b=U+pwB0KKjwys5TYstz2hwid76OsdUL2+stYDk8OgGihZ7YxSJjt1NhcdJHrRyA/HkQ
 AVug3EPOswEVcGcL0CrL6b1bUqbDkEgX76IYzZGFD7Aq2uczZX2pH8hV/FmsLPtv+uky
 SXz+SOBH+DGH3+RbAG/qbiM2ZsKqqoczr4X/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730314870; x=1730919670;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8+OsR6lUS2t1JA6zlHrWdb9TAxULqvVMVLNYA+3rHfs=;
 b=Ws49T6DdCXcJHKniTK/TFSnver1TXcNPY90rcMrafigKqhuSuZeaSD9B3RPc35hwEd
 aSZu/iCv9eCNzjx1mJucBDt/kDIuzc/rx4gn5MBNC0CcBTlwqRhS7MFjgrvwZ+HJ30/J
 xDs7dVKoK1V1v2ga187vfSsy+tQ4L8cnkC+9dT/qbpevGe8ovtiZLaZEHoMtSd1gjKJu
 LvVoymBNV5oCWKbjyEdReWS6zN9fm9c62nbCsxadsl7TbZ1NwoBrSrDmZgLDoiYe+H9i
 kti9h1G0LxrWms6GgS73IafcZs/DqlamUc4agaLHVtARQ8+vGm8SyMBIYQesMB11jqPK
 q9Zg==
X-Gm-Message-State: AOJu0YyKOLRO0r10Z6v2a6aMfbf69Nq0pz39PhyxbkrGiiYnJdixu3qd
 5vRb4uq/dB0Z1R8dbV5GgCSYLoFCfKYxZNLm1jEc9LjOWbrnYqKY2QcVlMRefs0=
X-Google-Smtp-Source: AGHT+IHQ06kbaQVqQhRQ9C4spUSKSxyyuf/kxUtKs26dfS2QEzDszs7Hqcg1GKzeVJjO6ajPldWsPQ==
X-Received: by 2002:ac8:7e8b:0:b0:461:2b8b:52db with SMTP id
 d75a77b69052e-4613c19d37amr252893601cf.37.1730314870604; 
 Wed, 30 Oct 2024 12:01:10 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-461323a1fb3sm57347841cf.85.2024.10.30.12.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 12:01:09 -0700 (PDT)
Date: Wed, 30 Oct 2024 13:01:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Markus Volk <f_l_k@t-online.de>, Rudi Heitbaum <rudi@heitbaum.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] scripts/dtc/pylibfdt/libfdt.i_shipped: Use
 SWIG_AppendOutput
Message-ID: <20241030190107.GQ2558755@bill-the-cat>
References: <20241030050716.854676-1-f_l_k@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ia/7xfCv7V/7sKmC"
Content-Disposition: inline
In-Reply-To: <20241030050716.854676-1-f_l_k@t-online.de>
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


--ia/7xfCv7V/7sKmC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 06:07:16AM +0100, Markus Volk wrote:

> Swig has changed language specific AppendOutput functions. The helper
> macro SWIG_AppendOutput remains unchanged. Use that instead
> of SWIG_Python_AppendOutput, which would require an extra parameter
> since swig 4.3.0.
>=20
> /home/flk/poky/build-test/tmp/work/qemux86_64-poky-linux/u-boot/2024.10/g=
it/arch/x86/cpu/u-boot-64.lds
> | scripts/dtc/pylibfdt/libfdt_wrap.c: In function =E2=80=98_wrap_fdt_next=
_node=E2=80=99:
> | scripts/dtc/pylibfdt/libfdt_wrap.c:5581:17: error: too few arguments to=
 function =E2=80=98SWIG_Python_AppendOutput=E2=80=99
> |  5581 |     resultobj =3D SWIG_Python_AppendOutput(resultobj, val);
> |       |                 ^~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Signed-off-by: Markus Volk <f_l_k@t-online.de>

Ah, I see this has been merged upstream now as well. Rudi posted the
same patch to U-Boot a bit sooner, but since you have the change merged
upstream I'll apply yours shortly and give Rudi a Reported-by tag on the
commit as well, to try and be fair. Thanks!

So that patchwork/b4/etc pick it up:
Reported-by: Rudi Heitbaum <rudi@heitbaum.com>
Link: https://github.com/dgibson/dtc/pull/154

--=20
Tom

--ia/7xfCv7V/7sKmC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcigm8ACgkQFHw5/5Y0
tyxJTAv/QpXP9NShrwN1YWS5988rCbGi2TKJfDtsUZw8x4INIYwEpFBqMz1fixPJ
R8/W0RIXN4y0XROt8irqjlhpFMoczu4tQFchH+VayMTjpoQWY0GqnVdaq8PiYXdh
6Wro6G65UBjlofaW/hnDA0wGWHjBIy2CvVxcS5o8GGjIY38zfj0at71UakLX4WpD
9d9p2AzlkcyTyzYSqm3Sudgi1769KaKsYolTjj/6n9Io5/Ry+F4FnZiArDUyQz3u
aAQ+YRB4cu6S0Ev/7lSkKwm+Tt3JX4ZE8PJdK16FD5QKDQFkQGmzkEibwZ7usRKP
uoFAN2AgIiO+GU61uTJqQOYxcx5x5zFf5WcFUsjmVc12Kcf6XI/KGP6HxQiDqWqm
A8h2h5GCf62SO3S0t3fDX98Vuy6ux3kFIcDOx54azOu124hTklk851wg/QN+XE0P
Y4E3OmDwk2wsvMpU6dgJKGKPPx4mCi4SgdcmhwtYQnzNlnrO9qSqGdeJUyxRvLqe
8+Lmm5VT
=mW34
-----END PGP SIGNATURE-----

--ia/7xfCv7V/7sKmC--
