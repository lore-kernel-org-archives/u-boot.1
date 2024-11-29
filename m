Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F036D729FC
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 19:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2E7A89470;
	Fri, 29 Nov 2024 20:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PLWy6twv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D0FF89021; Fri, 29 Nov 2024 20:27:48 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FA8C89488
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 20:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-46695dd02e8so21241291cf.2
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 11:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732908463; x=1733513263; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I+wGvNdEXS1T29Lh+7D2kDBfZ29q/nFwBQjwGzLtUC0=;
 b=PLWy6twvLiFHhbeJrm9GjpwCOZZUZku2YKZu1NAH2YqjNEfnKQ6bjScgExo8w01rzj
 JYjtdWmYHK7Vd27ycX1/Ypwoc7wrlDTzUhjntR8DB3jd1A0AQNJoP80boBpz1x9RSfWn
 QwUiO23YPaeeRR3s3slsKhaOZ6Gs9KTS+BU/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732908463; x=1733513263;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+wGvNdEXS1T29Lh+7D2kDBfZ29q/nFwBQjwGzLtUC0=;
 b=Com/UJd9Mkz+CVxsEybOdZZ7QN0Vcl67XrXfr1CmrPMjzPSRw0UiHQf18iTsyMrXJ3
 KBHMsJWSwtDYuAx/uAlf2A9kSqkL21NbI81kq3gpYbkN0c30alsk5p/GZZFlfweWXoR9
 2Syzln0NirdYUGa7sJ0thUAkDhr0y+Jvu+VruBxRb8gmctGrZsWbXuMN7ewIhnZ4bfpo
 x5++AWPc5m+SBS1O9FcLOnvreMg2OWWltJEb6JLvNrSVbRcIHPIrVCgHBYldVmAyKDX0
 APqSQNEqLyFazYrrxI2IqhqGfffWlkFUYxjYIG4Q5TEcBr3+EegDjG5L2D0Lz77I+xo1
 IVaA==
X-Gm-Message-State: AOJu0Ywkeh4ctOQFk/7nLGnTw1dD0BPd1O1VaX8veGXdHIj0aPEv8o31
 o50oyCd0RWNjfHufQPoolx0OwHKjT5XmrraJo6XkwEP6LVvKdM8FHl0hlxY1bPE=
X-Gm-Gg: ASbGncuN6DCfuH3WVpPSJvxirVdGdYGpL6xTD9AVxtFdTo09AD51VPWlu0u11nZqDpw
 ikfR7Ar785gqGdZOFNlTxWlVxPvAkmrpl3itdRCPvow3shxoebSEP9R6Vtmxcjr4yVzptHLE2kj
 GFAGLds0BKJrcHE0AZ5Flgy2s3dDxxH5nqdMXagiWA6wiNH9qaLHetLV6TrtgA2DSnNji7IEdpc
 jK9Tqtd1S/kOsyFLwZolatVP8Z0OnWV2B6bZMTL3RYGvCHyDw==
X-Google-Smtp-Source: AGHT+IFJi8f+h5wfm7CkhvLE1+Q0a9z9XaVoL88d/Okd99UjsJKvfRMqvf6ryuBlPM1VXwQRvKMyog==
X-Received: by 2002:a05:622a:113:b0:463:648d:23 with SMTP id
 d75a77b69052e-466b359cb05mr184757501cf.14.1732908463402; 
 Fri, 29 Nov 2024 11:27:43 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c421ef6esm19808891cf.57.2024.11.29.11.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 11:27:42 -0800 (PST)
Date: Fri, 29 Nov 2024 13:27:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL next] u-boot-at91-2025.04-a
Message-ID: <20241129192739.GN3600562@bill-the-cat>
References: <9c200bc9-e481-4c2f-a4f0-2ef594c2a512@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tFGlZ8PNrgA7Gm1T"
Content-Disposition: inline
In-Reply-To: <9c200bc9-e481-4c2f-a4f0-2ef594c2a512@linaro.org>
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


--tFGlZ8PNrgA7Gm1T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 03:46:16PM +0200, Eugen Hristev wrote:

> Hello Tom,
>=20
> Please pull tag u-boot-at91-2025.04-a , the first set of features and
> fixes for the next 2025.04 cycle.
>=20
> This feature set includes the at91 gpio driver function alternate mode
> for pins, and some fixes.
>=20
> Thanks,
> Eugen
>=20
>=20
> The following changes since commit 62224280d9e89648ae90346c0aede76f9b7e76=
10:
>=20
>   Merge tag 'u-boot-dfu-next-20241126' of
> https://source.denx.de/u-boot/custodians/u-boot-dfu into next
> (2024-11-26 10:50:05 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-at91.git
> tags/u-boot-at91-2025.04-a
>=20
> for you to fetch changes up to bf424a110dc6180b65e6cdf05897428ca7cac98d:
>=20
>   mtd: nand: raw: atmel: Remove redundant PMECC probe (2024-11-29
> 12:59:27 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--tFGlZ8PNrgA7Gm1T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdKFacACgkQFHw5/5Y0
tyxVRQv5AX9HcehVl92d0Df2fWaAxH/8LUCjqAb3JHGC9rUowCJnBxig089HAPAW
O7dWXqcccwwt9RqFiwDVOtcBPxKY32ftl5Ho5KAqkiZ9QBth2Io2XZIg6KdPV63a
GVUaqnLoHkP6wNsiOVpp5oN3RvKudhinRV+N0SFO7KtWQBvrT8sQ+5q1z2gv6fBQ
7VAK/wp1PYXrmUgqAAO2CttcTUo7YeqxXfnqYmn/hWn7iTzPc/qKYWbcWgUTpzmE
hlSQIub2IavoG+Kl58eV2MNfKfmR6xUOK7ZI8eFbox70i0qcDjfqq6uUXKUXU+VP
ZKQgC59DMMEbvFVrQj8yDpfj/MENF7MJAGTrQ2D6r6cS/OtNkEYzGDjg1b2VfK0f
XEwmMN0OXAunC9LZst6cw6IqSANS+2HO/E2Ai6N7EF5VtR5dRlY+WduK6ovMsbbm
Bt0+Vdt12bN8BqGo7WvLQhvhNmNcq+bHtmmymr7c8jgpccY6K9ZsEG0AN1JGOYhp
atWFTV5k
=dzBU
-----END PGP SIGNATURE-----

--tFGlZ8PNrgA7Gm1T--
