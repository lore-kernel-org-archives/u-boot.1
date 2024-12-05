Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF0DE7716D
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 16:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 601628947B;
	Thu,  5 Dec 2024 17:24:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EOMDfe1u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA1618903C; Thu,  5 Dec 2024 17:24:52 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 430C786DBD
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 17:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-46689dba2fbso6261411cf.2
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 08:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733415889; x=1734020689; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yJm6QFRewUOxFjOJvxbVtQUKyiC1EaMk2xI+SFR9wjE=;
 b=EOMDfe1uOv2Js0YHgq2GZ2XQyEqlm5RO54qzS6W17sinKZTeigFSNcpirCECFlxpJC
 /vJcGzR9XEr1pBKEkpL1BXBLtMMxRXo8ghCrT4nyNZ83v59QR34vplvx3lIEOZ6BLMAn
 H+rzniIIlhF7EZxyFaV9oo3tMi8bki609hEpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733415889; x=1734020689;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJm6QFRewUOxFjOJvxbVtQUKyiC1EaMk2xI+SFR9wjE=;
 b=JNBh2bVbkXWLdsErL7ZPzDgaXdol+QrZodjewF14CG2qVNU+6DMDwPFxail4oLsgT3
 qFbNhl/e9lv0yqbgDpVvthLuWx10lpkDJynWyFMuJ316LtqhwFcRNlB6JO43gnKFLb8P
 DHPdjHH95va/fP82Nd3WjDRL6Scn5JyP6xPvBaGZmum+1aTWHm9Bx4B6miFwsvPzGUtD
 RKRTwevqdKmDqd/HgKQBKQNiW2N+HJqiRYArfs2EghbgXvln/jqcz9S34mxeaQnaeeZJ
 oikHOfOy0xqpFFhnb6Q3ut8LLDQfWdbUc2Eei616rAVMOEYJsg4tQmJCJT+TVVr4A75K
 PTRA==
X-Gm-Message-State: AOJu0Yxlbs0kpKnccwHOLd3ve46mSisbbUb9Y2mDucB9ksW953KGoOFt
 2hGnFXeUEsay9Denmc9u7axiv3BdnsY/A0Zl6xSQOIxhBx1yESFoY/PcUbgmfyc=
X-Gm-Gg: ASbGncvL9JELjeqexd/79XaFh9WgpQeM9PYpowJhjt62DtdjnChZhWeMNffQWfjeZMa
 klJRL/r2ippiaShGnlgkdgNpRPgF6F8niph8rx+sjbzJ6WnaA5KOS7cLRLPlfM/iO74h+9zxNhH
 myWlNBkNTbuJx+Rc7u0d+rPo9wv+VGXwx6gNAZ643Szs2drzmhgQbpIdleHeCV1zPa87NFkIIxE
 X4ahJuUoaI3hIPTZJfjZfAbcuuJRxyxZ023vUn/wlgAl1RaPw==
X-Google-Smtp-Source: AGHT+IHZCqWOGyG6i9PdSt7SlkMu4EwGUpmNepeeIoHRo9oJXPkprv5ZMFD0DHScne6rh1rXH0yFFw==
X-Received: by 2002:ac8:57c3:0:b0:460:8f80:909a with SMTP id
 d75a77b69052e-4670c3cc078mr135350251cf.32.1733415889046; 
 Thu, 05 Dec 2024 08:24:49 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4672969e35esm9374571cf.13.2024.12.05.08.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 08:24:48 -0800 (PST)
Date: Thu, 5 Dec 2024 10:24:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org
Subject: Re: Pull request for efi-master-05122024
Message-ID: <20241205162445.GM2457179@bill-the-cat>
References: <20241205105800.1953747-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0ZV5ZcWwARCgyA51"
Content-Disposition: inline
In-Reply-To: <20241205105800.1953747-1-ilias.apalodimas@linaro.org>
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


--0ZV5ZcWwARCgyA51
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 12:57:59PM +0200, Ilias Apalodimas wrote:

> Hi Tom
>=20
> The following changes since commit f96e5133184aac377b54bd61f8abf78710f2ee=
56:
>=20
>   Merge branch 'master' of https://gitlab.denx.de/u-boot/custodians/u-boo=
t-samsung (2024-12-03 12:37:20 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/efi-master-05=
122024
>=20
> for you to fetch changes up to 1d9aa4a283daa1e609130b5457c9857d62f1d1cb:
>=20
>   lmb: Fix the allocation of overlapping memory areas with !LMB_NONE (202=
4-12-05 09:01:44 +0200)
>=20
> The lmb patches are soaking in the mailing list for more than a week and
> unfortunately haven't been reviewed. All the our sefltests pass though
> and the SCT is fixed so hopefully I haven't missed anything. The change s=
hould
> be harmless apart from some extra delay when someone is trying to allocat=
e an
> already allocate area with identical flags.
>=20
> The CI at https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines=
/23719
> looks fine. Please pull!
>=20
> /Ilias
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--0ZV5ZcWwARCgyA51
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdR08YACgkQFHw5/5Y0
tyzwTwv9F8IrUnDkwMIjDEjLKRJD4ROm3PkZ4NJRQrVPBxiUc+xxvcJ+P4e38CY6
Tv8KD7Y06TveoJyeJKRlY88UnsEvi81yayldEwZdf5O0St8wV32w0kC4MiWQzIfh
nduq1ehGjyQJVM6cBdXe4AlCJuDzVkRGJrYx0xbyyLd9VgPqFcVW7VpDGRvmcs4Z
cT/Qd0I6jDPKjf6aHgUtTkClEQ4kf7nA9ENKvwtzg+cC+CsKcq8Fx+K8tAa1gUSF
hF9cRYvc2BczQCGkSIbXaa9ugLZO9i9vJtSgtGGffoRESM8rs5F09/rNdygImoWa
UBYUW0uxx/RsQMAidBhibQxKQhZHDXlKtWq0jUbYNph/oca0vWwijiiHMJvh/zMh
xAGUTAff7sP9M3aLp2gGUgSrqMcuVP9a3Ffvu503FI2DkenVU0lG81wEi8JPDDC+
QsoAu8+alN5B7CO929YfBIipI4VeE/6WSibNMFeFbA27ZBAE2XxOFIsKqpultZSC
bT5U/L4Z
=xqvv
-----END PGP SIGNATURE-----

--0ZV5ZcWwARCgyA51--
