Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00538C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 13:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A99A828C2;
	Thu,  8 May 2025 15:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LU98rFgh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F11982905; Thu,  8 May 2025 15:47:17 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D98828BC
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 15:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70a2d8a8404so8768237b3.3
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 06:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746712034; x=1747316834; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOCCm5y9WUHcld/Ai5mO7EmEYazcwbvDXKKb9pH/68k=;
 b=LU98rFghjccBR57GLNvPtjsaxjIJjcEbf3czz7ugK7qz8Gx+bby+srAc7cezMtDjgH
 qb49G8wqDd8q1dZvQykeqKZAEht1l+SFGhfu0w6lDGheHBtscIfi1xDLPQnkZt7ZKS4R
 sLEYf/lYNiUh6s0Y3bqdlW2RQvgidYQ3NLmS458/BYFA3M9fhGCrzc0YSNDYromnG4XU
 YnEGRnJcfS1MI7y1dpgL9b3p3GFlNol62HSbt30qe3kXUlKCdYd1cGLC4wU0JAwZfzqe
 H1QST0X4Px3/NY7H6wP586f3OFg2R5pMlil+Y7D4AHlWGhCcqKV4j4yGRJzyL+/is04s
 oTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746712034; x=1747316834;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gOCCm5y9WUHcld/Ai5mO7EmEYazcwbvDXKKb9pH/68k=;
 b=qweZ2vu7hIZH+GKGpFHg74IcUDT0dLPCIOjTdhJk7mED8buDBxxXLtXThCOn7dXfcz
 d718tDUP97M8Kno40gnc8tU7VuT5VJK+pj4HxsqiWE2mSkRWTa3fmAGXyypclnxC3Xeb
 h12ZB/HIXKgasWlkgTrBaBNaPwlCvU80fOOCqkC4yrUfpQfXpQBKsVrR7z6Uho62+LBd
 2KORgWOGrM2210VG9pdWT7Cc0NFMgeaGenUjytbzD7f5sbNeZtG7dwIZsyVfCc9NSlpy
 uwz+Yhm9eeNxiN5xo8yBaKB6kS4cZHpIuNYYiSGh2DBXXvXOwRSqhbc1G2hhTxD8tv9B
 AHZA==
X-Gm-Message-State: AOJu0Yw1wDZ0A7Btn2gsjTsFo3lVl+KJQms84uW8hdHrprfmoBqy9n75
 2mJYNU6GtVp4S51Sgo/MZEsPIol6LRBkNigncQ4EVhNaavJSmW+hrZFkxe9qGixYCSUFnrZDlLH
 WEWnLjCVHnVCT/W0cAG6XMeKYdBU=
X-Gm-Gg: ASbGncvydQaOssH45xIqdlcqedTUdgl3RxP8fF7RMGwevm7JrulLOuX7haqXpAzBkmV
 Fc0E06DB1BCcjgmGx8a/zs9Fi2s5HQEaosre0mySXLf0TjS1v3PYasGOfKfk2i40ba+nvw8B4c8
 sOBcuVhKrmLwILwnAaL1yelUo=
X-Google-Smtp-Source: AGHT+IGs1NPXZyhjJ3/2O9IZI9cxsGODGPPZ9DHXVQUojxR1m6OMw9LvqN1QLiKVQIJRZon4ibYgo+iR7aKE3jHaZ/4=
X-Received: by 2002:a05:690c:7204:b0:6fd:2762:9d11 with SMTP id
 00721157ae682-70a1da3d210mr95192717b3.8.1746712033729; Thu, 08 May 2025
 06:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <lwLOMBoGHvyWyzNQ0igIWfrYyCNzX0ysxEnABgiN06zEZI7EclnJBSNQRLdfbnRBkz32jsrnu36Bsnrx82GhS_Z7oh2c7VnRHOJB0UbwZqo=@protonmail.com>
In-Reply-To: <lwLOMBoGHvyWyzNQ0igIWfrYyCNzX0ysxEnABgiN06zEZI7EclnJBSNQRLdfbnRBkz32jsrnu36Bsnrx82GhS_Z7oh2c7VnRHOJB0UbwZqo=@protonmail.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Thu, 8 May 2025 08:46:46 -0500
X-Gm-Features: ATxdqUFkxGWFmTke-4Od0wa3s1wyX9oDmG5mxYRKnyVe2wSmyLB1nWPETVccRw8
Message-ID: <CAOCHtYiebsx-Tt2nNzpsFwPXe4Ktc6iwikfg8dRDfhBJQ=DxZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] BeagleBoard: Bring it back with updates.
To: OMAP at BSF <omapbsf@protonmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, May 8, 2025 at 7:50=E2=80=AFAM OMAP at BSF <omapbsf@protonmail.com>=
 wrote:
>
> * Converted to using DM_I2C.
> * New config file for xM.
> * Run 'patman' on patches.

Thank you for looking into this!

> Signed-off-by: Nevets Llih <omapbsf@protonmail.com>
> ---
>  arch/arm/dts/Makefile                       |   9 +
>  arch/arm/dts/omap3-beagle-u-boot.dtsi       |  14 +
>  arch/arm/dts/omap3-beagle-xm-ab-u-boot.dtsi |  14 +
>  arch/arm/dts/omap3-beagle-xm-ab.dts         |  13 +
>  arch/arm/dts/omap3-beagle-xm-u-boot.dtsi    |  14 +
>  arch/arm/dts/omap3-beagle-xm.dts            | 406 +++++++++++++++
>  arch/arm/dts/omap3-beagle.dts               | 433 ++++++++++++++++

We should be able to use CONFIG_OF_UPSTREAM now:

voodoo@hestia:/opt/github/u-boot$ find . | grep omap3-beagle-xm
./dts/upstream/src/arm/ti/omap/omap3-beagle-xm.dts
./dts/upstream/src/arm/ti/omap/omap3-beagle-xm-ab.dts

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
