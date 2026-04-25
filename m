Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A0BFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D05E9840AB;
	Sat, 25 Apr 2026 19:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B3N/ovs8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D986840AB; Sat, 25 Apr 2026 19:00:19 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6987980087
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7de5badb627so949786a34.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777136416; x=1777741216; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TmOMAn1opitZpTjhV1Cc0rCp9qU05c/+yOokwsrnd/o=;
 b=B3N/ovs80SO7Cr2N9qS1DQ5EDKG1ZimossJrP7X83+GU8oKrUaptWFUAVpOBKd/8ze
 KdjlFPa+shSAGTnWEuGNUJJMT+Aj70rULF57DGkXGafHuvZ7cjPeQ0bo88/k2rJvE7dd
 yWsh66yuFkahQ8RoW7uMqTNn7DPynRg4fCVrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777136416; x=1777741216;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TmOMAn1opitZpTjhV1Cc0rCp9qU05c/+yOokwsrnd/o=;
 b=cPwFlbwW+9LTHx68lTh9mOx6yJGt7WauJETjH2sn9oKGeCJD1qouJzLH/iySIZn7CP
 lpSXBlbCn4JhUl8iT/LBQ69DsKlCavQMxLFeOMSP+F3wc8siUuZa4C4jPUooNDtHnCD3
 UCygI+/KUrgHisQnJqa00gyCITzHuJRfgv21Sx1pmuKHH7EZcPg1PhKCnMAh1tkHcm97
 ZfJ5KrSxc0N5BpF29xxp8fzd23Ps0Qd1YOI1cxu/PAHr0eKuyqn0HW/wqZV2tBAAgjJS
 fx/RwnDIrYfaLDfZB/xkHRVLSl+Ys4nEFDQk/8nGTeiHJMso5kwuXoDnEgQuUDoChR9e
 gr0w==
X-Gm-Message-State: AOJu0YzNG+bnSl3k2XkidFBihwvdb5237aiHx40pnXmJ3OOmH1lYniqz
 mJH68cfODWsleY/f7xEsCqkxVrxY2ZROdVu+lyyQF3QNzHhWU8oKI5Hn5QNUBohgssuT0PrASC2
 dGiL/QYzLYg==
X-Gm-Gg: AeBDiesA2xICYQLVuLp4ys2BOryQmWPUEeHYtijbyM7bWetaW/C9LnJMJdJ8WBPaOwR
 Jd/GpxQCFxKdETAzwJi3RxJuV1uEfWi+bDQN9C+z1ymQLQDCJMvIel+5XAa+hGSUTkkwhtID+mr
 zrtsRL1O3MdfqiGmJgzTSM5674Gs+TTyznQwgH8fuGxkCr5ewdVmPdHYYg1TMBwohCBgFhurwCE
 CDT/FMqLAKUqZZqH6CvS0TiIoF15KMTIOivVDSZ6hlwO91Vd8AcuwVC5qVta3W4Wd91FoLfyCU1
 yeTmmLVXV+iSH1lVMLGWtXhHWKxdLrmznYrNmlaHxfowdAx+gQlDxWPC+C3N86pnisURUC+ljmB
 sVzMKB9g9XvxQmYEaRFBgt+iGleU4zjZUrJWVEhepv1KRwKuS1Y0YjNHeSB0CfII5/qQluZp5U9
 k0lMei1mUVOK/glEZ2eZCk2SeZgroBDqQ4zStgcMupL00JoEkT+xc81cQNyj5p2qqcB11R1w3GW
 t4do4cxv/EteOCkPzWmQ5keychBspfTjgYcps3sDbWTEt+qUiQdys9ylYmDaA==
X-Received: by 2002:a05:6830:3890:b0:7dc:dd91:b5b1 with SMTP id
 46e09a7af769-7dcdd91b6f5mr12236031a34.5.1777136416207; 
 Sat, 25 Apr 2026 10:00:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dcc892c515sm15906543a34.21.2026.04.25.10.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 10:00:15 -0700 (PDT)
Date: Sat, 25 Apr 2026 11:00:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <ehristev@kernel.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] MAINTAINERS, mailmap: Change email for Eugen Hristev
Message-ID: <20260425170013.GY41863@bill-the-cat>
References: <20260425-maintainers-v1-1-114f12ce0656@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+ZIDa/VXH2su7Vfd"
Content-Disposition: inline
In-Reply-To: <20260425-maintainers-v1-1-114f12ce0656@kernel.org>
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


--+ZIDa/VXH2su7Vfd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 04:17:12PM +0300, Eugen Hristev wrote:

> Replace old bouncing emails with ehristev@kernel.org
>=20
> Signed-off-by: Eugen Hristev <ehristev@kernel.org>
> ---
>  .mailmap    | 5 +++--
>  MAINTAINERS | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)

Can you please update the various board MAINTAINER files you're listed
in as well? Thanks!

--=20
Tom

--+ZIDa/VXH2su7Vfd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaezzHQAKCRAr4qD1Cr/k
Cta4AP9WDjnZB6iL3thOxG8WP1pOJHlQB9TnvIVizcKeA4K9PAEA96BMxboRH8SB
gnK+rd0sYjCg7Pb/3Td62PViMf+3ogo=
=w/2N
-----END PGP SIGNATURE-----

--+ZIDa/VXH2su7Vfd--
