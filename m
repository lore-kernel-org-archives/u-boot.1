Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF61ECCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5AA983631;
	Fri, 24 Oct 2025 16:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gHyHCa1F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FDB483655; Fri, 24 Oct 2025 16:47:56 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 649CF82A9E
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 16:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c52ce8cbe7so69293a34.0
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 07:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761317273; x=1761922073; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HfLkiZg6NjwJm4V8R5s4GVn5Zeovp1vq5xzECfTiIDY=;
 b=gHyHCa1FlqWr+QZ9Le7hTIHzhf4eoHnAIsJm59HbzfNJ1zddHa8Y8CKmZoqk5BzNvs
 9whdPZ3Y8SbsH92y7QZDNYTzBzDxxhIIQjqHRujUwe/5ychQLfgQwoYlOVeedeeLGl9a
 2o9hjbA+OrxWReJ3oXJyCQP8mEw475QE8HxQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761317273; x=1761922073;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HfLkiZg6NjwJm4V8R5s4GVn5Zeovp1vq5xzECfTiIDY=;
 b=Jnf/c5R1PcZx86q4Si1q/+JdHIawHjMDJbUhvVYYj+D4odFQ/YKNng9cBhjc/Uh6ey
 QzXPaYAbQypVQy7bCrU9fwt0F9DY2Frobq6yj5+rHX84SiOCzNmJNflOX+rKPp+LKOn9
 1hL2ULbVVidIa7MFCulfFUIeNSjkSh8QIXXbcFhb6X+u1ek3PESC1jC0agteIE5nTk/P
 0Sz8p1OBCHyJzPhwUYe2X8KucUCYapzodE4cNBVTwkUykOjoEzq6OUF65sULvfgeGbQF
 rRXxKqP/Rwyy3hS4W3n7igNNnPA7CXbTPmh25yR9wUB60MqyAcIRnYSjGO8JHuqxUoRo
 hbcQ==
X-Gm-Message-State: AOJu0YzmEolroY/RLdbC6qew/6f6fsEiOidCJo1zTCxWqyT71cqg7O7X
 rkPpZdUzb9bA5qcjjogIPSZZFDtU0ohpvNL/Ccr/s6hp62bql0v6246ucqJLEw8kFjg=
X-Gm-Gg: ASbGncth4i3PcydZnUapaS4/ncsAnh7NyZrQYPWQHmX6V/Zm6ie5CwZia+SDKvucBaR
 U8Pvr/gRcl/1YXsJQ6q65B2Ni74lzmpXeJj4VdIOPDDkFelmTPm0npCX2HCMBJlELVd2I7uqJj7
 8FlVJ70jIZ82QP02i85WuAm4Y+r3Cb/u75e4szfFPa5/Qz5oKV7hopztV+mgjSd99H2nIlVkhDM
 PnwpzEQB5JOopFcvvKUP2BEU/o3DgI/QMmIeJkppp/RlNvnyjnyC/rGH/LtV3/cOVDvjYbo66yw
 e0OjjaA9jDWiToEM1DBLovD01Pw2sPZCoBGgUHUZHKLHQxwDo04HhFkj8Bq8Y1K9lI9EtnveBcm
 368ZFiRgxJm8hDBr3Qd/STRYMjcCwfPJuimhWqTFZ0j2pMRb3mz7EuSfedBpZJLG0k8z/w4fkbt
 8RKBvxQp7zXcDxelEl/yTPtgtR/7iHJq+TibTGh5g=
X-Google-Smtp-Source: AGHT+IGT4igNTAy/7zhkNyOTsqNM9iLmZF6AxBq3Bs88o7Av0cCb1RjNYXttpxRC+elhXXvew42PAA==
X-Received: by 2002:a05:6830:d06:b0:78d:a443:8c93 with SMTP id
 46e09a7af769-7c27ca2b3fdmr14670931a34.6.1761317273072; 
 Fri, 24 Oct 2025 07:47:53 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c511189fd5sm1597830a34.9.2025.10.24.07.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 07:47:50 -0700 (PDT)
Date: Fri, 24 Oct 2025 08:47:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v8 1/2] spl: remove usage of CMD_BOOTx from image parsing
Message-ID: <20251024144748.GO6688@bill-the-cat>
References: <20251024-fix_cmd_bootx-v8-0-230f70c5e5f8@ti.com>
 <20251024-fix_cmd_bootx-v8-1-230f70c5e5f8@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d6R/XHXCc9v+aZBg"
Content-Disposition: inline
In-Reply-To: <20251024-fix_cmd_bootx-v8-1-230f70c5e5f8@ti.com>
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


--d6R/XHXCc9v+aZBg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 12:56:08PM +0530, Anshul Dalal wrote:

> Using CMD_* configs from spl doesn't make logical sense. Therefore this
> patch replaces the checks for CMD_BOOTx with newly added library symbols
> BOOTI, BOOTM and BOOTZ which are enabled by their respective CMD_* or
> SPL_* counterparts.

You didn't update the commit message here to reflect the new symbol
names.

> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index ade42d0ca4370b7df3aec59615f12e28a96874cd..9f3c30156d22330515e408ec0=
30a3ced3b81ab38 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -7,6 +7,13 @@ lib-$(CONFIG_USE_PRIVATE_LIBGCC) +=3D ashldi3.o ashrdi3.=
o lshrdi3.o \
>  				    lib1funcs.o uldivmod.o div0.o \
>  				    div64.o muldi3.o
> =20
> +obj-$(CONFIG_$(PHASE_)LIB_BOOTI) +=3D image.o
> +obj-$(CONFIG_$(PHASE_)LIB_BOOTZ) +=3D zimage.o
> +
> +ifndef CONFIG_XPL_BUILD
> +obj-$(CONFIG_LIB_BOOTM) +=3D bootm.o
> +endif

Since we have $(PHASE_) now for LIB_BOOTM this too should be like the
other two.

--=20
Tom

--d6R/XHXCc9v+aZBg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPuRkQAKCRAr4qD1Cr/k
CuqpAP4/WFtFFcOFYPYs2IjtIj1Y/2QBOJr7/yScy6Rh8WlFYAD/RfRT0yZVZNc3
Pi6YdgrKfeG82lP9VJsgVTxWncuKJg8=
=D2Bx
-----END PGP SIGNATURE-----

--d6R/XHXCc9v+aZBg--
