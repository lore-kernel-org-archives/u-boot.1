Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEABCA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 14:28:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64C0E83984;
	Thu, 14 Aug 2025 16:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="phhYcuA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DF2083984; Thu, 14 Aug 2025 16:28:31 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D2A283939
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 16:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-88428b19ea9so67701139f.0
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 07:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755181706; x=1755786506; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QDWz24VMjBjWw9uaGcjVxy2lXZ7y/r1WcUkKHnJGLII=;
 b=phhYcuA/posOh7dRzC6nhmAToSxH3tOMMbEqbtD08R8bQ/O3Niw8nLJBBbO8esX4Yx
 2dX8/oY/zHZ+qM/Fur86tndwmxK5hSHa2Ck32o7YWvNj6niGObNXqXrumCx9Oekrx76m
 oeUVSFfMrJ9wBjt6gMP7V4Oktj8ZQdzW1Cj9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755181706; x=1755786506;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QDWz24VMjBjWw9uaGcjVxy2lXZ7y/r1WcUkKHnJGLII=;
 b=hmZtxd/AC9gPU9MG5o1WhgZ4wBHYOsumJPII1IOvFHHLlRTJpdHtLrN33LMi9G5nL9
 arVoVlu5STzZ0WEBJWSSF9KeeSXZnWRY5M0ABaBvEQxNcHhU64dhU/Dq1M0EeZVV6RgL
 snxjaPa357aXY1krVO29/QQ7pN9n31/OkzsS927VafFsx1QBcxlUHJwdPEeCbS4FuLlg
 IDhP3HcCeFqXIAHZqFSD9iMUIaLudIti3lFkqdtGkg4HASkoEXUhzS0XxpMRSTE/QQ4p
 2VW9QoTC7i26Cx5gyTQauQ8nvlxtnwKjQtz/ATFI2eR7B4UNR3zlhgzr2dZd4VX8EY1c
 sY5A==
X-Gm-Message-State: AOJu0YxE0ZFR6P8XZrIKqA97J2GAD7I+P9Vlhbyq3nxfchPkeVPGOMg1
 mvGIDb/BhGiHyiBu+hU+9uK02Uvn4lOobu0aqsL4mbC0eho8s7UPz6JeHRmfWIfJqxw=
X-Gm-Gg: ASbGncsb8ebpRrFy6QAA7IpABrOjsiU3hALa+i3nM/+8NZIa/CtjAgVCLyGoZhLNRYe
 8c0QUkmdGf595SHFv5TnQnkVuonOoRhfTR5y5jlNo55d2MboLzVYKQd27Uak61n9TPuRzNbUejY
 w1AAle2TPIJ5OcBZ+yUA8w0V6dvO6YyNEJ++4Awy7e+gKBhP+PiWNTQgKNVsR2XGRaRqW9Y9nZH
 KP0mvY0zAVueGi4lzwKpW0jgsrsRgmc/WU40c0EXTmsTqCRhiO+1ytCE+qh3xmTu3K0LM7K4Y2k
 R/wqKp76YzDrRevBmLA8OJ4lPGp/H9QR5wOyU0485kYydOwTkN/0ciZosd7dL8rJ99UEe8Nxe/t
 OqwSm1leg36volYmqhVXG830/di6K+Jto3sHlrogupz41+Akbp3Dix95b
X-Google-Smtp-Source: AGHT+IEqgxBRs+inSkv1xLOnXNMWcUKZKAJmm8Xl6NZ92alCM7pbP/vmBYNuDEW7yxxY/Fg5aLt59A==
X-Received: by 2002:a05:6e02:1c2b:b0:3e5:4816:8bab with SMTP id
 e9e14a558f8ab-3e571c4b936mr48793935ab.7.1755181705913; 
 Thu, 14 Aug 2025 07:28:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e545da3189sm49141125ab.56.2025.08.14.07.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 07:28:25 -0700 (PDT)
Date: Thu, 14 Aug 2025 08:28:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: U-boot Openlist <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mahesh Rao <mahesh.rao@altera.com>
Subject: Re: [PATCH v2 2/3] cache: Check dcache availability before calling
 cache functions
Message-ID: <20250814142822.GH124814@bill-the-cat>
References: <20250814031741.4887-1-boon.khai.ng@altera.com>
 <20250814031741.4887-3-boon.khai.ng@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0juydG2nyMCqyNwl"
Content-Disposition: inline
In-Reply-To: <20250814031741.4887-3-boon.khai.ng@altera.com>
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


--0juydG2nyMCqyNwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 11:17:40AM +0800, Boon Khai Ng wrote:

> When the data cache (dcache) is disabled, calling related
> status functions can lead to compilation errors due to
> undefined references.
>=20
> Adding a !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) check before
> invoking dcache_status() (used in common/memsize.c:get_ram_size())
> and mmu_status() (from arch/arm/include/asm/io.h).
>=20
> Without this check, builds with dcache disabled will fail to compile.
>=20
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--0juydG2nyMCqyNwl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJ3yhgAKCRAr4qD1Cr/k
ClziAP9wFs9J2UuLj8E16BCZBZN1S2GqxJ0SoukB2Hm8hHDvrAD/Um2OmczHFZFq
oZ4wAdk0R+xLH5poCtPCaBG/1LQaMA0=
=fiNB
-----END PGP SIGNATURE-----

--0juydG2nyMCqyNwl--
