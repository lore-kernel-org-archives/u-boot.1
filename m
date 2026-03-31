Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF22FF60D5
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 19:41:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD2D983E7A;
	Tue, 31 Mar 2026 21:41:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EonUnTRw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEF1383F5B; Tue, 31 Mar 2026 21:41:55 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF52D83AA9
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 21:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b932fe2e1a7so797103066b.1
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774986113; cv=none;
 d=google.com; s=arc-20240605;
 b=brZ8QEjvylR+kYsf/2C2T0W8G/tVMvlOkgYJIz6JIMHxFdUfkONysUF5WCcDH/MydZ
 +2esyvUEGU19JBcZ+9CqRu91sL48nbyG0vn25Q85pRCpKyVJArxKInsJQZ+bUP6UV2y7
 nf9E9VOwipGR3NTnoXiVCTzQ/3DdQ30tKLCDpeN0enSt5jzU2WkxZlhuXDqFLcz5y8+N
 7Bt6ap3335TGVVnHQPR4lhPGFDLw/N+BKPx9AZ2SjTGD+eZ7zVYyhsGg3Ddp7urz/0p3
 YSz247DlpGfcHiD0/RZGDrUFQ+JMlCzEWWFZVitaXD2b8VYnya4/UkhXK4CJ1LhfwKGR
 mtLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vC97TnjfI1VfvOe+ao+8NwbWlzNNdMkZFQkQk/xHeak=;
 fh=FkuXq/OfkMip5YZlTI+LCSfno4mMtrRxTs7/A6NPiiY=;
 b=N3D1Rzz1SwESjgFcdIPLYoIk7uktSg+GF0oiOZ/3ZynfSF8U11QaJ04riLQXy/GUyV
 efWKIzWrRAF6SGz2bgakqcyKIYQYZAZPo8ihHbqJGTP+fxgnydEzEFOnguVd4ysQHKLS
 7lUgxAzb2eSQ7o0JPpje1e9tBsfWINWBkRSVKLDBwjqV4ttOEQakC+cKtX/H/0gZRsIX
 mtJgttOF7BwlKd1NsmL4sKbcryZQ/tLuAuozN6R12IDDUIwzvCDKm+vK9vsyDBTeyb7G
 o6R8e5JnHSaCjRJ2T6EH0Jjy6sMYD1OTbKyK66N82SgAvsKyHznadZMxqJLxJAbNYRGB
 auWw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774986113; x=1775590913; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vC97TnjfI1VfvOe+ao+8NwbWlzNNdMkZFQkQk/xHeak=;
 b=EonUnTRwXbTJ4vpC3XadKWHwCNoB8d26wZGrpmOcHOw+72mhBTiAI0dolqqKtpmzW6
 4GRdoQRP2+P4gMe1VQXnbRhoYPRUYm28djRxmbQhP3yozjAIdXoEVTyD84zY80oqkqKt
 zjs9hXeHw6v3qXypJGO/wS4On4Ff8zU4R1v2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774986113; x=1775590913;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vC97TnjfI1VfvOe+ao+8NwbWlzNNdMkZFQkQk/xHeak=;
 b=OIqd0zAfISf5eeIncxJxrIIyhz0vJjQdPWah8sgbjD+zHHqYT69Y6uiY0nVyeLPDOk
 b+z0ADK4krYA2vpcpIGVKWsE5LfNbCdAe+4xT6G85yW3kdhdBrN71ePrr/eXNiZFAy4X
 Aa94lpiV/ofcplwQqgAgmz4GPP3vzW/SqHhZs8jvPSlPhDt/yUv/oq9+LuKOKmsqC9In
 zB0Vu3IkKqyyWJviwqomePT0TXEU1ZYUnUx/wW7wFNkPq/OjrCrfwGhv71gu1VsaRBsA
 wrVrOjllo3kKbFNBkbJMSNxSxshiaTxtYkmLtPjSFms4xbX7FFL97EUKS8FN5TFGwLMS
 D5/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2OBy6nXaEEGwF8QGBwDpnPgn5j54zbgOFZ3ZCXy7wy/xs+Dg219eD0J9rqe+zKcWFo3uqOKk=@lists.denx.de
X-Gm-Message-State: AOJu0YzgDq7z7kUw+wx9ybHJN0voVlIVYvvoOBdIjAFYJ20zjOmNwo5f
 cSCsDhaLxFVavkuROxzOYiKC8izPIZOFTu2qmqBWXcsvamhXzlu1ISyqOI9DrSks677tvORqbi4
 1QPVegFqLDNfPggLfTGOHSRJLCiyFYkn25xO3BGbK
X-Gm-Gg: ATEYQzxyLpbvfMajYqjH7VzknqDCrzRNEEe9bG56W9ufAjghvBQeo90ETkmy/d8OPWe
 enAFUKf0ASRwS4TkxcuulE9+iSam924beUfHGujQ6qW6xtzxHOwu8U7FsYsc0Bupj3+wliNjhc/
 8+McvKHwlrhFBqr+YKlCe9GSg+owAIzXdkAMR1RmBK7Rt0VzIR40WwJKjUMgiY5yCiKy/Fds/Lf
 QAWgzHYoVEejUAiyFFfkJuPyz+FtCGc9G1EY4CElB7dG/TReMZdyEbvLAEcU5bSyQzGX8Y0LClH
 x3lFSA==
X-Received: by 2002:a17:907:8b8a:b0:b8e:d4ed:5eab with SMTP id
 a640c23a62f3a-b9c13b047c7mr62698666b.31.1774986113007; Tue, 31 Mar 2026
 12:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
 <20260330171419.1117817-2-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260330171419.1117817-2-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 31 Mar 2026 15:41:41 -0400
X-Gm-Features: AQROBzDXIb8Bj0HEXBuTI5JaFvP6Ap_R-9_YsCEtZkm_-OO51MSXEwyz0-ypgLk
Message-ID: <CAFLszTjMsRNZJKh7SanNnoDGChb-6jzLEDA0YB7n2Q7hCYkchw@mail.gmail.com>
Subject: Re: [v3,1/7] misc: Add support for bit fields in NVMEM cells
To: aswin.murugan@oss.qualcomm.com
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, sjg@chromium.org, seanga2@gmail.com, 
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, gchan9527@gmail.com, 
 mkorpershoek@kernel.org, hs@nabladev.com, marek.vasut+renesas@mailbox.org, 
 msp@baylibre.com, dinesh.maniyam@altera.com, peng.fan@nxp.com, 
 quentin.schulz@cherry.de, kever.yang@rock-chips.com, 
 jamie.gibbons@microchip.com, justin@tidylabs.net, xypron.glpk@gmx.de, 
 n-francis@ti.com, h-vm@ti.com, ycliang@andestech.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
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

Hi Aswin,

On 2026-03-30T17:14:12, Aswin Murugan <aswin.murugan@oss.qualcomm.com> wrote:
> diff --git a/drivers/misc/nvmem.c b/drivers/misc/nvmem.c
> @@ -121,13 +222,27 @@ int nvmem_cell_get_by_index(...)
> -             dev_dbg(cell->nvmem, "missing address or size for %s\n",
> +             dev_err(cell->nvmem, "missing address or size for %s\n",

This change from 'dev_dbg' to 'dev_err' is unrelated to bit field
support. Please can you either drop it or split it into its own patch?

> diff --git a/drivers/misc/nvmem.c b/drivers/misc/nvmem.c
> @@ -12,55 +12,156 @@
> +int nvmem_cell_write(struct nvmem_cell *cell, const void *buf, size_t size)
> +{
> ...
> +             value = *(u32 *)buf;
> +             value &= (1U << cell->nbits) - 1;
> +             value <<= cell->bit_offset;
> +
> +             mask = ((1U << cell->nbits) - 1) << cell->bit_offset;
> +
> +             *(u32 *)buf = (current & ~mask) | value;

You should not write to a const pointer.

Second, when 'nbits == 32' the expression '(1U << cell->nbits) - 1' is
undefined behaviour (shift equal to type width). I suspect you want
something like 'GENMASK(cell->nbits - 1, 0)' for both read and write.

> diff --git a/drivers/misc/nvmem.c b/drivers/misc/nvmem.c
> @@ -12,55 +12,156 @@
> +     if ((cell->nbits && size < cell->size) || (!cell->nbits && size != cell->size)) {

This condition is checked identically in both 'nvmem_cell_read' and
'nvmem_cell_write'. For the bit field path you then require 'size ==
MAX_NVMEM_CELL_SIZE' a few lines later, so 'size < cell->size' is
always subsumed by that second check. Hard to follow How about
consolidating the size checks so the requirements for each mode are
clear in one place?

Regards,
Simon
