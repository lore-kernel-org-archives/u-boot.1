Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5B7C27C79
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 17:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BA758839C;
	Wed, 19 Jun 2024 19:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T3WMyObf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 188738839C; Wed, 19 Jun 2024 19:22:40 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A22F086EB5
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 19:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6fa0d077694so2520a34.0
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718817755; x=1719422555; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gAjl3UjvmCcwD1XNhe8rRf9fDigt6VjQfbslQIaA4+A=;
 b=T3WMyObfmjoixznWASd01NkH3P3XB7T41H7hfqM7b4fxMAQ3XxU9/e0Ka7o9KJ2pvW
 XtzAhnDTmFj5B3OoFW5H/yi7RR7Pdk9kOBJFRqPuSp5qyMeGKA+JSMlxAVgGy0ZCHbQa
 ubv7xDPKISRs+xpAlE4U1o7OA4sjQyplysHHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718817755; x=1719422555;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gAjl3UjvmCcwD1XNhe8rRf9fDigt6VjQfbslQIaA4+A=;
 b=EdFrJJdos4hTgwZL2vAjMUPlL7BBw/7Uhw9ncwpAHJXxK2s/aPYSiI8eApx8QOCXAo
 AlrdSQXPeb3Us/P9e380GAnt63/EO8baqrPnPKAHwOEiloOTkMDy0COxAxCMH1eucdzU
 o8xioSU5326mH+bmG3ohyw0WbTXSnRdX5zdFmVo11bFKGbeeplsjBA0GxTJ2Eam0Aca2
 +9wOY9fk89ErRXvg8ZIbpYt+BLNaEWTcSJSBh1nnuFtZQ7AXIXj0OaBdLOatfMlXn67j
 O/MuYZzs29Jz6mb7YwFc0C2KG0Gtu0bSgzxFEO0cBsRaAT+SXTT14hfPhMX/FMLfKMe6
 IH5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSAxh5LkQgS5+cWYIz/fyO5wQgBKL/m+kQ2EX/Qa0HHi6t2oQH1+Y/7XG8lUIPjVcbeUbFT1CqnvGVgh+DDZgkZBtJ6g==
X-Gm-Message-State: AOJu0Yxg5TbrVFdZk+eHu/QC72MHzeXTcTGUQG90X4sBpqiRXvyyogTk
 waYeex2qBbYGfZVUHVJ45/nPpICk+J5AfQQtGZjWLMtxF++N8ZuW4G1wUrEh67Q=
X-Google-Smtp-Source: AGHT+IET9MB+XqHsadubpiV8EGe0Mbf4UNuz21SC8V357iijX/I67bPKi3JSbX29xGB+0gIWJzt5oQ==
X-Received: by 2002:a05:6830:16cf:b0:700:5090:7081 with SMTP id
 46e09a7af769-70074117519mr3664299a34.7.1718817755343; 
 Wed, 19 Jun 2024 10:22:35 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb5afab892sm2233443a34.7.2024.06.19.10.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 10:22:34 -0700 (PDT)
Date: Wed, 19 Jun 2024 11:22:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] efi_loader: avoid duplicate weak
 invalidate_icache_all()
Message-ID: <20240619172232.GA3435012@bill-the-cat>
References: <20240616173105.7430-1-heinrich.schuchardt@canonical.com>
 <20240616173105.7430-4-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gIf2QHc8E7muECtB"
Content-Disposition: inline
In-Reply-To: <20240616173105.7430-4-heinrich.schuchardt@canonical.com>
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


--gIf2QHc8E7muECtB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 07:31:05PM +0200, Heinrich Schuchardt wrote:

> If multiple weak implementations of a weak function exist, it is unclear
> which one the linker should chose. cmd/cache.c already defines a weak
> invalidate_icache_all().
>=20
> We don't need a call to invalidate_icache_all() on x86.
> ARM, RISC-V, and Sandbox provide an implementation.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--gIf2QHc8E7muECtB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZzE9gACgkQFHw5/5Y0
tyxRKAv3UkGBHU/YHeXEZkvUqL/KBx3l6uLwLdW9HWBc3l/FErjnKpCQ+EgmMyOJ
tU8Jv+Le0XOQGUKk8F0zqfoYPaZxFVQZ2GQrv8NeVUBwnSWAofS+C8wTJEGfY7bk
YAs0iwaRAho+ZG74vvRJeNuEDRA75BPV//BNclVaWqmXU/cO4ThnPxkubHbeYggK
4IvsUS+mEw3uKMBqAZpuJaHA38OgB5t/9opqak+fkOM6OtaDyHEPWH+19fSDFGVs
6EppIBiTCoCBhxQ2TL4hkijBU5ILQVV4okUfkW2hYo/yL++OnbdIfAJ7yMgCgyO9
PeEt3znTiHS+CCMl8rTH93SCX3l0ShlAQDSvWJg1nuGWpwIdfWtZElMbyPyBzmHi
5vwsz1bFn6CvCcVASPUVv/QLwWsRaBgTExyEnP+37M+quz9/Dj/hUsF9QV/mIpD6
+SabCm+7uRxyeN4VCkstSGmTAgaB0zi/Qp9vezoGH+JFHVEfKvHY09zZ+/Zp3Uvg
pxQ4YFM=
=7Tay
-----END PGP SIGNATURE-----

--gIf2QHc8E7muECtB--
