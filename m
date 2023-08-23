Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB61EE49A3
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3EF0864AD;
	Wed, 23 Aug 2023 16:41:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V6xKY7ER";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86D7186473; Wed, 23 Aug 2023 16:41:55 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39AF2863F5
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5922380064bso31751497b3.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801712; x=1693406512;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FYOQ7mUSYkLO8i7j99v8oEPdBVKczcB03k88rv5Plf0=;
 b=V6xKY7ERmKAQjfVbOhoP3HXvsu0hNLP7q0nESddactq9vYZKnA44tKW4WVp1qUiwef
 dYbgKAvFnfzoEyzuBTejleuWBVCaqapr7Mpwku2yb/80K8m6K2M0a0/uoEfaH6oswD3F
 ktQD6HZAb3nP8zPbYmAUuYnH5zgTtQVnTtODs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801712; x=1693406512;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYOQ7mUSYkLO8i7j99v8oEPdBVKczcB03k88rv5Plf0=;
 b=Jpe1MRW9HuoeF9Y0nzZ2l/EFRMx1ne+VL+2YiSp/lfn5jNIUD/yZYtKSr0Qy4yd0WJ
 6ouh2LWCF+ecz210QKhgzZAzcCnhRD3GNjROJJDShoCt/GxXZ5Vl4cA4xzGyX8Vq5G9N
 hFfQJv+2Iqf0R/Swk/90qBZKrMSPX8JhxrMSHzgz7Bbye9pXxNVDZ8d8OWUeBk7F/qR8
 nkTwnAmerZSGDQff2Y4IrrDv2CeYPBwGyUcIlJ3tHZGvToCStNuo6Zy5mU3bGfzpdcUd
 iYH3qLt09/fBSdWqDPK7w1VIwzPxiitBb0CqHCqert2zRJO12kUSflZmHlqpKaIPJwh/
 SgIg==
X-Gm-Message-State: AOJu0YxhzXGnbsdLd81HtdQY5sOzfLzwb0SHeylLw7Ro/hI2TrjAfDUS
 NhFWKsRwGPFs6rHrJBfRPz5mwQ==
X-Google-Smtp-Source: AGHT+IHfLzjr9dQ/mVmCT00WlEzUE7sBPor0ZrysNVCFN/HedzuR5Z164OBsB+LUAAclMHP49sw3BQ==
X-Received: by 2002:a0d:ca0b:0:b0:58d:f1fe:5954 with SMTP id
 m11-20020a0dca0b000000b0058df1fe5954mr13307066ywd.32.1692801711941; 
 Wed, 23 Aug 2023 07:41:51 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 m139-20020a0dca91000000b0058c55d40765sm907612ywd.106.2023.08.23.07.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:41:51 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:41:50 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm
Message-ID: <20230823144150.GP3953269@bill-the-cat>
References: <CAPnjgZ1h135x7Sp7yXj2FxFdwr8zvVvM-JgzB_s+Ra=9yDMObQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2LmLkleafCXzBp0a"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1h135x7Sp7yXj2FxFdwr8zvVvM-JgzB_s+Ra=9yDMObQ@mail.gmail.com>
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


--2LmLkleafCXzBp0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 01:46:36PM -0600, Simon Glass wrote:

> Hi Tom.
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/17476
>=20
>=20
> The following changes since commit 976fb2ffa3875a7bed9866bf5cf939a81c423e=
f8:
>=20
>   Prepare v2023.10-rc3 (2023-08-21 16:19:59 -0400)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-pull-22aug23
>=20
> for you to fetch changes up to 1c55d62fb9ccc107cb4fefa9bb04cb16395ca84c:
>=20
>   riscv: cpu: make riscv_cpu_probe to EVT_DM_POST_INIT_R callback
> (2023-08-22 08:07:54 -0600)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--2LmLkleafCXzBp0a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGq0ACgkQFHw5/5Y0
tyxVzgv/UUCvXDBX0UmXBk8sh5m6lFTR7LUv0esUV/KpdU6xX20Wd68xgmAka92i
QHJnRCmMhILLtl51Hu8nk2jE9MdBQrUnQf76i04nDNTjAfxJh05jenu6FKOB0Bnh
O8H7n+wtE4lKhknCjYS3QWZcMnrhsCPLPYGfoaATZkOWgGZN31vupC6MfBKNvpRT
npgLDUPLOGChmYVz4c0RlJRXk0kSt8AGep5X2+O2YI0dMddz9M/zLynPP6apJTgc
8CT65Venv2mBJBh4Hlyt/NH1lE/qO6Z1aXvEfQTJzkZ+4QNSzAYEYi93wD7lQn7I
QL4AyX3AUkxALY4061wH+caGKeWXupRuYPV2OK8D3B6mNTt9SWlyEBBbO1vU59mE
LbXE5w6fnS3hLLKY693hU3E/lzQf3vLtDUxdt3LPqpDGz6yWN06zGB/dy8Mid2vd
8yMEi77/LcgScouoKO8K4DHYzMdhYcyLjfKcFqD7gqPLpz0zQOoYkoQDENS0jovt
yd4jxq6k
=lfV4
-----END PGP SIGNATURE-----

--2LmLkleafCXzBp0a--
