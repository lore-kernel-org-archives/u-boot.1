Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F6CEA7188
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 03:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 337AD8425F;
	Sun, 19 Apr 2026 05:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U9K2jktd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E31A4839D9; Sun, 19 Apr 2026 05:52:40 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F21784258
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 05:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so352538866b.1
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 20:52:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776570758; cv=none;
 d=google.com; s=arc-20240605;
 b=hhKCBjJYPEXK1LAa2rHz0xyWixsoK4dmrBwDX9AU0ADUwJRBpSQeZ0nV/BzpgmKpj8
 GiI3FH8YK1liKsd9FqmnZUJZR4Kro+oBRohDkJpkXH6pUryiwpSnpogiN8YDr2mIDRTx
 JTNGf811cdu2xNCv/jbXryZ559WyZjiyQcN665vecI1kSruqJgxdj7c+JXIz0XSKYc7h
 KVZPKEdxbcWHXcQoHGTxnJAK3FNNOPc8W0NgiNEvveARMLOBSt9ucU5033Uap1Vcc4k6
 mGOIqtf4TN/TcGbXefNyf3qr26zh7J+mxBGY2VkRleYRz3LAJXHXOJHoTKJ8iWktHe+5
 wodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=W5ebACbgUkJEsZg3YOc/mqzm1o7okVJpL5M9P78hqxA=;
 fh=W4FGA4PtBpAUc3kuNZe7JlIueODGNEvC0VCY7h2Ohks=;
 b=a4KxOtXI0fnu1SvdN4RlupE6Dwv5fm/GibvnBj7ylnLkkA+bSeO/iVeeqmb+2f162a
 MgTHNglgEZ7+D7bz9gP+Me86e3PdifubRusT9++wBhzFTE8q1D4/oiTruDbBJEuH+FVB
 /dkOvn1rUddTgUhS7kzdQSRmQ+Pls8C86OtheBo2VAtyT/zKB1Y1jGYlDCQ2Z/DzamSr
 OeIRGryW+nU4HUfI56InoTWuixbJtGceBaOvtzRNpNMpqpSj+SBvgp/RN8kcKeJ7OQNI
 bQfZlt9MOyClQj4R/GlZdgKalyvzjc7FShrcD/p+Iu5/IHFF02I4e0Ern5aF0f6jzxxs
 snyQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776570758; x=1777175558; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W5ebACbgUkJEsZg3YOc/mqzm1o7okVJpL5M9P78hqxA=;
 b=U9K2jktdpeJMks1fdhNJqmkUVjqSbPT0dvB8xSuAhJLwVzvvpuQuqmmpLUM2vvM4Ye
 2TXhpcvs8wHrihMWDKBqchBuXFMRaCAngXgWhP4VQVjKcY7/XH420+eaIu+rte5n3Duj
 Jndu92hkVNHDr8+7MJqrw3YYNNIDejOC9fgHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776570758; x=1777175558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5ebACbgUkJEsZg3YOc/mqzm1o7okVJpL5M9P78hqxA=;
 b=RooRsxa9mJrncGGLqci00TSDbHZyLlSdV59a+tWdFrQzJLa0oLW0T6SnV8fvE2KieQ
 zNpUox28OB66uyC5IuiBKyx/E8mnQrLnMRWesz2BhkV6JA96p3MprOV5ykCZdeEyZDgV
 VDPyCGi1V7V2ZwWTmc9jVEfBe8HutKQ/yd6wgV7MQea10S8KPOB5LooUrLQPex//NUFf
 kDmHts/QYZT9UDIxVOVzu6gPKJsMd2BgK4/gQWvYHgnZu1qdkmnca4fMZfdpECXW9/FT
 vUcGJeGFjOOCpiIMLI8vy4QA1J5eEL5sA0pFELlDrU41SUfX3V84XZejSSeMlcucBlcA
 KQww==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tBlHEG92nFOSZV2zFpU/5tbhLcpc+/idwGiD33evwSH6FRLjVEwhCwviSD/Rg6w+yx4yHNEs=@lists.denx.de
X-Gm-Message-State: AOJu0YyKxn1+qYgszzoRYu+U4Vb6tEbnRJqSKvJtzERCRRlKhPFzOBUK
 lihI8nHgdTnJ0QsyXIRcDP0oa26mVdqIU5WpMGGhA+wJ+UajpaXeU2yPmt+di3S1tlj/jjh8BC6
 POULDSfuZJHnCjzCR7EfN6Cao7QvLJwK4yhZehJ7s
X-Gm-Gg: AeBDievydDbdg0aDYLtGcQwgatTtaj4oiNLR8WG1s53Nxl35rICv77KNC8xE0gWXS0L
 +1YUJxCcOrxmsVedL0ssquwmUf2XaUe5cBjW+Flp5UeK0OjKbUGhz9FpnB7FBJzTdCxGKzq93J8
 0kv1oRuBHqoDL30/r4ntEwcNKGc/gE+HClWsIcDQdp+K19dZdwBZhNJwttQRIVJ7SI6Wu6JhkUF
 y5KQCHXCVC8driMIDRiukmPJOfeqzig8TwmvyD4TSzO6Asn4UTVW+Dj6x5ExAWFFFykMOHTuTx5
 e9D7+ULsH5NEb1aKgPZF
X-Received: by 2002:a17:907:6e8d:b0:b98:32c1:246e with SMTP id
 a640c23a62f3a-ba41916ee1fmr483730266b.8.1776570758480; Sat, 18 Apr 2026
 20:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-4-rs@ti.com>
In-Reply-To: <20260413203555.1990337-4-rs@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Apr 2026 15:52:22 +1200
X-Gm-Features: AQROBzBt8Mn6HfNbsELyPpceipihyLbwBuBCf3sSKpEobPrp8INQDTX-WIDHO_I
Message-ID: <CAFLszThPB-YVe_j4LJ_reEoC2D9uG2t-FF1W9aM+VGvE7ybwdA@mail.gmail.com>
Subject: Re: [PATCHv3 3/6] efi_dt_fixup: use fdtdec_get_bool
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de
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

On 2026-04-13T20:35:52, Randolph Sapp <rs@ti.com> wrote:
> efi_dt_fixup: use fdtdec_get_bool
>
> Use the more straightforward fdtdec_get_bool instead of fdt_getprop and
> a return code check.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Anshul Dalal <anshuld@ti.com>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> lib/efi_loader/efi_dt_fixup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
