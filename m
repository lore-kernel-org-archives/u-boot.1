Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AB9F45A0F
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 23:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B37584099;
	Sat, 11 Apr 2026 01:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e5cr+57a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCAE184198; Sat, 11 Apr 2026 01:03:31 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB89683DC9
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 01:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b9c6680aaf8so455936966b.3
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 16:03:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775862209; cv=none;
 d=google.com; s=arc-20240605;
 b=SmCMtqKHHdEgbAy/iqfTPByqBQoDrPHLrejBBW7ICxuYMFSR+n5C2BJ5y9Jj8LPOTl
 LHo5hr1NqbC41VnLtpjA1WY0iQxaEmre7nuyPcDKGncWoV7dwF+vDUCATjHABWFsoUXM
 Y9yTkHuzJKVFQcqYqRekuW4N8bcBBCbe0iWzgDMAYmEMS0K4pU8x06epGQWi8PDA1S9+
 yUcIPABCvpF6cU/KWg8n6U+4M4AcBwbBzNXf6LyTZGhRcehdk/cPWPg3EdRn25MZcVxa
 R/BHeNsDJBjIhbqrwc/AyOuWmDsnbMlbDIxpH0WR/FDseLXKTb5zuM+JvlIKdC3aDqDu
 LCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w+ndny9RxxMOp/80b2WVV/gV/jF69djiAHJdvy4fJkk=;
 fh=KyqqMVHoOATPJJUJrgL0MX+76c8wowopIm454Fh8ALE=;
 b=MELAcrWaKh7SUXLxaKdd82zEBuaGhYaxS49uUTGuKeHuRtBwnq4ummG/nOHL6yG5SK
 t9li0vXUZBzsI5dAjkrhuiH3Qg4X7KvUBpu+dbNbwJqHDqs09PWu7qh0GKWHK5bI+jra
 7h0eKOP8VIn8cbXbw6otPOf1yu2im0QaWN1ZHDq1ds0UZxnSAUC4hk5QOrkr4WsK2QSn
 Zl66Yw1raGqm/JY/6Cx08As4YeV+UQP7yY+UG5ec3vr6JDrqutwTizKGqwuYwdpp0UCW
 d553rHa5mvDLZoghi7atgNftkohGTHlcHAeYwYMxMXAfNlzzaCoAy/IfskaUZn8l8cRz
 YF+g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775862209; x=1776467009; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w+ndny9RxxMOp/80b2WVV/gV/jF69djiAHJdvy4fJkk=;
 b=e5cr+57akd4EYRd7zfOiqkYmbwDezzKFr9oC8YFKq4gAi5wIMHUDF5Ue359Jl2gh78
 9hfCzbx72598bLM+ZBK+NeRWyZzntTjSnh8WwouiN9TDFOn+QTy9t1kYDzJEabdr3iTk
 J0moocckMNxA36Q1AlzyZs3PfiCvCwnKdMLbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775862209; x=1776467009;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+ndny9RxxMOp/80b2WVV/gV/jF69djiAHJdvy4fJkk=;
 b=JLVzYEgBmrdmzJGGqlsmPu+MMCX1THIwjlbzJo9q1I7H+oEOMu1gjrX51SHDEhVP/y
 JodLVuNmXTzhlbTOA0jlMJKKzlAj8Jy7i0CIFL22JzQKjyTRfHedfynBUS6aldBB7OYY
 sGEtQ3c7ZNNkIDpy+Pz8d2I02BMPXHvOBswykh3Ncjx0eMoHov8m1AteI0Tm5VZmKPK9
 3j74d3JIm9MLzig1mc3ccv745dHHZlBgYJ1v7mNgLO+V0Qf3deqght0Km7VfkREQrkcg
 Mwu2nJ9mE2q/ObrwqqXTsc933P2kKqQk5NMNfd+/mwv32hX7oHGHcrNBJiWszikOjqPa
 YCpQ==
X-Gm-Message-State: AOJu0Yx6aaRkkvrabFhzBzHwYJmNByzw8lrDRGBSjEvHh0kl8BFO8Ivs
 ODdcLejPMLeMF4iM4X+X4duOPdw8mXClrKVEFBNKYNVz9wuuQQI7wO+aDC3R6Sn3Os4z7iZQAV4
 NRlRq0LmMZpT7/osvIHgM5YFvQt0COxRg3J4+Ik9I
X-Gm-Gg: AeBDiesi5AvN8yn9gQ7P8vXbKg3bXKLij05O41I9RxXiYw5ZlVKbVNYE8D3HUO6HkpA
 rmrC4QmEBbfBKINK6OcXtpk3O+Pv4ndqG7GWownArI78FC9Nk/R5nWTunuhHJA8dCfuJ1iTbCOk
 KIliaP4J2DCUbOj1wu36jhm8ZN+T9jUwElhgcoQo9/NccgmoA0eGpRtfZ/4QVKhLMIP8LGWZ4s6
 IRLdg8XF5rW1+FL6+9TccmbSSzS1hlQ8ShFVsS+s/7k/27nV76sU1PFfvQeXU9AgFVRc2MyMnZt
 ZSQrHgbaWT+rMpmF
X-Received: by 2002:a17:907:3d51:b0:b9b:38d4:2cea with SMTP id
 a640c23a62f3a-b9d724caa11mr330547766b.23.1775862209376; Fri, 10 Apr 2026
 16:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260404152640.3297713-1-dario.binacchi@amarulasolutions.com>
 <20260404152640.3297713-7-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260404152640.3297713-7-dario.binacchi@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Apr 2026 17:03:17 -0600
X-Gm-Features: AQROBzBC1olBemXufML4T8TQkBI_skYwRbm9ntoeOfON97lD-qLKSMEl5w_7pYI
Message-ID: <CAFLszTh+r=SiVh+HgF1Gx5+wN=9nWMWVPH34GK+vXX=XgMs7ng@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] fwu: add helper to get image GUID by type and bank
 index
To: dario.binacchi@amarulasolutions.com
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Michal Simek <michal.simek@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
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

Hi Dario,

On 2026-04-04T15:23:27, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
> fwu: add helper to get image GUID by type and bank index
>
> Introduce fwu_mdata_get_image_guid() to retrieve a specific image GUID
> from the FWU metadata based on the bank index and image type GUID.
>
> This allows identifying the correct partition in multi-bank (A/B)
> scenarios, ensuring the correct image is targeted depending on the
> current bank.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> include/fwu.h         |  3 +++
>  lib/fwu_updates/fwu.c | 33 +++++++++++++++++++++++++++++++++
>  test/hooks/bin/u      |  1 +
>  3 files changed, 37 insertions(+)

> diff --git a/include/fwu.h b/include/fwu.h
> @@ -396,6 +396,9 @@ void fwu_populate_mdata_image_info(struct fwu_data *data);
> +int fwu_mdata_get_image_guid(efi_guid_t *image_guid,
> +                          const efi_guid_t *image_type_guid, u32 bank_index);

The cover letter mentions 'Add kerneldoc comment for
fwu_mdata_get_image_guid()' but the header declaration has no
kerneldoc. Please can you add it before the declaration in fwu.h to
match other functions in this file? The comment in fwu.c is good, but
the U-Boot convention is to document public APIs in the header.

Regards,
Simon
