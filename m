Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F642C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED9C0826AA;
	Fri, 11 Jul 2025 17:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ow96yPb/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9546C826AA; Fri, 11 Jul 2025 17:19:34 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85C3882063
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-73a44512c8aso619858a34.0
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752247171; x=1752851971; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ihLDIhaHz1DMapZpFmlsxzumLtMgFWcmJSQwaK5eTZ8=;
 b=ow96yPb/RMMCenX+NCUWYcPnCwRF/P6Ulfwbq5Cqivh7aWpeXvvQ3joFLx7kFRrB15
 SJwP9zUqUCUB/gChOQLH1XfSlhEqOtT2S912XYJR6vZTo4mKU5GAi/kIz32dxhXUNHqZ
 lEhXoVS8+MxuK6hg3EBTVh3p25eXIwBtoYzH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752247171; x=1752851971;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ihLDIhaHz1DMapZpFmlsxzumLtMgFWcmJSQwaK5eTZ8=;
 b=PSpFD81z0ZhQrNLi1Pn4kb2eu/L6gCh3UK3QqgOCs72nWJgAj/diXAKWOAm7FzeMfU
 lfcGzJzHdCBp47Tob5DqQk/ZtpXeox8HUuDnWafRHfJQtgXKASzUFblrcK/prfe6JzQo
 MiMG3lvN35nFOzL2xP4BkX1Ajqpl9ehGlMbF+dFt8kcGaoGQzwCMtkULRkKlRrdsLlD0
 yN3UtVAO5/+MZMZ2CTGf8CtrvobX2t0HptzM5rZ2OmRHbKRZ2vMkJT7RU0Snuu3IU5ku
 362B74HNbb2tQ+avAb5YioO3ECWRo5ZdWaRIem7uGLpG1II2ymENyDrGplYJFsPJTMPV
 Sf2A==
X-Gm-Message-State: AOJu0Yzo9iqIlnGAnjjdHVc+EKdnkmGEPFqc+3RDqzUqX2te93ddt3pv
 UAAJm1l0N7B7k4im79vRHjkn4jngk2sZsM2dLWsubhyi4huB1djHHs66OzSyEttEnPilesX8uYH
 rdvIjEME=
X-Gm-Gg: ASbGncuTenKgL5XEJA5lqvjH3EC68TWIdrOwGN95tSZyxiDBHGWy5sqm8I7QVcHvmNt
 hZQOep8L3v5gFxLmjSBuZzBrnu9TIVHxaJUhj5eoJktBogQLeRu0ftxlKSw6oJIzoTR6wt4us+t
 0JSSVm5xFWW7T+Vj1wP15SnyZxLh+cZtbcvQKBNxABKRUobsi52MWBhhRQfpIISuT0wtTbbx2mg
 l8IdDcgNBdcESzvmaW8cEtBu+TBXl1f3HZX127Yy77SkZo4jDNPXckBaVV9DPemteUeT2cZyPgF
 JSNRcALjYErrkPWRTT+N2VhS3EKI90v75JsVF0MQFsVteaK8foytqePyKdW/9eyEInF8nvaNS/O
 9nhcW3Ogld/8ogfC7eocBKu3KCjaprdLGHDq2tA0q4VegGUx3AYXe9uu+
X-Google-Smtp-Source: AGHT+IE41zHEFsL/qi7Xfe822J1LYCCwo3r7V9adXuJOR3KI23yqZ/EvWc7wP/mdaCvirIj4LatPbg==
X-Received: by 2002:a05:6830:d1b:b0:73c:c494:a032 with SMTP id
 46e09a7af769-73cf9e3ff7dmr2905663a34.2.1752247171250; 
 Fri, 11 Jul 2025 08:19:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12a6e4esm582321a34.57.2025.07.11.08.19.30
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:19:30 -0700 (PDT)
Date: Fri, 11 Jul 2025 09:19:28 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] mtd: nand: raw: Remove unused octeontx_nand driver
 REWORDME
Message-ID: <20250711151928.GG6424@bill-the-cat>
References: <20250711151612.2224296-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NzJf4omsHlF3nESB"
Content-Disposition: inline
In-Reply-To: <20250711151612.2224296-1-trini@konsulko.com>
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


--NzJf4omsHlF3nESB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 09:16:12AM -0600, Tom Rini wrote:

> Signed-off-by: Tom Rini <trini@konsulko.com>

Oops, I hit send too quick on this part, I'll v2 with a non-empty commit
message now.

--=20
Tom

--NzJf4omsHlF3nESB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhxK3wACgkQFHw5/5Y0
tyx3IQwAloyF851xX5ouexBipet90oRQVVayOvdboaYs8EX1sgIwQfuC7Fr2JDne
FjtGuuvleTTgXR7aJkP6PCjSRE7hzvUSewLJ0rZLW9qRv/u8vSFXfKB7FbY22vwq
wf3qRo7/cMNBmJShi9TSsO9KXiGFK9PhM+xXAh1lCSuYq3dtDjAa8OHAzVcxxJsU
TEieZumSRQda3RYkwrCMPNUTkQYK+gm3otd5CZYrVE/EQGg0nawKalTEFh2uh0wN
MP9A+hL8bfmZ9VxJKQpA4iXes3ksKu8QepsNp85ia5meqVxL2H4sR28rxn1a0wIz
6p8qu28lGzefHeoeX6C8PXUwZ/wkyPAlIuCsNSpGrTk9oIVVXYJwCrejYPV+PQdF
S5wUWr9Ch8zZSBTSZcZE+JiT5f2nQQ2rMp3hB9E31CXmpb95DPtieabgPdU+kwTL
ZMosJjUBrNxXlTtq7cA3LWISXEtFQyvU20ysrI6AfZ8VzV17dUPisUWNRAnDHzUn
mAbejmib
=rKXh
-----END PGP SIGNATURE-----

--NzJf4omsHlF3nESB--
