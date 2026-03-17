Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3455BFD875C
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 12:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D84A2842D7;
	Tue, 17 Mar 2026 13:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b92X1Ri9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C531F842C4; Tue, 17 Mar 2026 13:29:24 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52553842C4
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 13:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-664f8bef4e7so3485125a12.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 05:29:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773750562; cv=none;
 d=google.com; s=arc-20240605;
 b=IBQlsuzgas1IctGsNOrni3dqtYWSjWycSTsYResT6epd+d8Z2DubqvqSu/ZC5MaToS
 KeXLzE1Ztd8By3NojZjPClt8tCqpwsTg1xyC646uVarlg6LAhut7jrbjOKxKbl4ezG7V
 I/B4sKi89mBLS8O5v5rbJCUpBOygejjld+h32znT/L9VMIrBkF5LYK1kC6OrBB7JR7NX
 ++8yFnTlR3iLKugUI5FUJfYHB6+iMQqVGRlIEox/oe85FiH4s+UKRZfuN/Kejaiei+jy
 NU/h/OuefsZtB6PubBbeHp6CO5zfC5udLDs/Lyn2PlySjc/Gpb71M4V8d8gi9S8HIOsP
 qHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=InmyURmPPZO1Js/mDiEPNhe8lNCDd2vOXrzmX5ucmfQ=;
 fh=zGyDxAB0bCS1uClR71JKAdydwMJVnVqCuINIX7CBvkM=;
 b=G67njo0b54PvMhDjsmr/TujBz81XhNxBM3XP8GmEPFBnQhxHBCqqVYlXoMvjCXi3CA
 O/4+tfXbYCDFUBBGraElz2tdYCI2IGeezTRjWeDyNSedsdBMw62/hfMMTV/knbR+1qsA
 tBJVF0BzRZgkmSgO64QNzknYHO9yUBX2SY8mr8g+hRvR3yIo0Rg0z2Y//9iCibYlSW4s
 A5CDItpcGFNYylteqYZbvqMT8bW8dR/meepJimgq4WUEv7KejLtoFrz1dMMX1O3OZpah
 VoLUNZKKfrmwsOjVnngUaka6afx1+F31eNjgKDEzVPjKfCsixus8Q+JtUb62Z30VyvcK
 k1dA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773750562; x=1774355362; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=InmyURmPPZO1Js/mDiEPNhe8lNCDd2vOXrzmX5ucmfQ=;
 b=b92X1Ri9UdT+lCA/GTtz1JrB65dV41f5Al6l/jtpmkFMuN3yqmOPbF/w2cbEsrvxpM
 2QDXvVwmpA9HlaD/D43A2NsUmnQgEmjJrsKh7ReChk3SAnMprChTx6pLRQMQDBk4183W
 SJ3t3ZF8WcUfVi9AZQUb7ZlUwd/G2bAGFHy7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773750562; x=1774355362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=InmyURmPPZO1Js/mDiEPNhe8lNCDd2vOXrzmX5ucmfQ=;
 b=BcEwIRQJExbUdjQi4i1m0fJ1U+sEtk0fdB0oF2PHIU9hlkqyjwGWFUqyYV3v0b6F+A
 D1zwoSaMCZQzC5vHFiX04fZxWOFTDz8EMO4eT5hu9zKmYyBx86c5CFHxVBo5B2NnyN2L
 KeTS0AFi0XunLNe9LguBPHnOISVysZ0hAK9WjQEpFKmRMxuweiufQdRbKunXKqCMa7Hb
 10pbolQeyT3HDXrU2VBMK80Vwh7f2TnsKYBsYfFN+yXAKbuePs3V33XMpEuY2haOvVRR
 mRSiQ/vt4ge0K/CQf5P1w+dVh/XSf4Xm0YN/Wol4akBtk6VYPCY8X8/uGx1M51QiTgog
 R+Ow==
X-Gm-Message-State: AOJu0YyZNLs8rW0xzxcySp0H62jAz3VWpl3gc/dROnoLUhVklbVOU6Fh
 TtKmbmNDJSxhdFwPeZf5kF3JJ68SJNYPV1Rh6m3nQZPH86DqtMqJeGdKQ5nQjvMtAydCOBcj69H
 bKY+eKuaTFsXcQg/iN7gBRbumHMkZcYo64IeGhzq7SaHLqdQ0Hxs=
X-Gm-Gg: ATEYQzxeB6Tj6IFuApBKOL3YZ/NfSm1GcV9Vra6K+NRApQ2GqR25EPdhQgwj279ySQ+
 cizmnb2RnCNQkYswAGsZcAc+1IDsC95qON3pJ/ZeEqARSt9V0UbxDfDCHsifT+HUDzT8yZsgL74
 RdMT1H1agLStlCf+V1XwptnugRDp1OLfLdG9EFORSbhwNzH0ESEhzuAYNU9ku1xg4wopx7zuJia
 W6FnoQtQFXTgLGvgdhj0DWK+mqKGqfFTtbfWknBp452+Wp+7hqyw4U/vUOIg1Zh54l+oxClpgft
 WqdwcA==
X-Received: by 2002:a17:907:72c3:b0:b97:9569:5161 with SMTP id
 a640c23a62f3a-b9795695a75mr793001366b.40.1773750561679; Tue, 17 Mar 2026
 05:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260317021756.196402-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260317021756.196402-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Mar 2026 06:29:07 -0600
X-Gm-Features: AaiRm53LzHkMbIiaCCc1MdGGnyWEVH2aASJt0d3VqstvAqp0jN9MiqvJUOwSJaw
Message-ID: <CAFLszTipuwWnMzBhWSDEzAumVRK1zKQLOLTbmVLt7QKmkngz8Q@mail.gmail.com>
Subject: Re: [PATCH v2] console: Prefer currently selected serial console as
 stdio device
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>
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

On Mon, 16 Mar 2026 at 20:18, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Adjust the scan for default console stdio device to prefer the
> currently selected serial device. This is useful in combination
> with CONFIG_SERIAL_PROBE_ALL=y, in which case the system would
> instantiate all serial devices as stdio devices in the order in
> which they are listed in control DT. The currently selected serial
> device may not be the first device listed in DT, in which case the
> current console_init_r() implementation unexpectedly switches to
> another serial console after listing stderr using "Err:" line, and
> just before showing U-Boot shell, which is not the desired behavior.
>
> The scan now iterates over the entire list of stdio devices. If the
> current iterator stdio device is the current serial device, or there
> is no input or output stdio device assigned to the input or output
> stream yet, then the current iterator stdio device is assigned to that
> stream. This way, the first suitable stdio device is assigned to the
> stream, but the current serial console stdio device can override that
> assignment.
>
> As a small optimization, if the current iterator stdio device is the
> current serial device and both input and output streams as assigned,
> then the loop can terminate, because the current serial device has a
> chance to be used as a stdio device at this point.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: Merge the two loops into one
> ---
>  common/console.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/common/console.c b/common/console.c
> index 48586fd2166..22e554cf203 100644
> --- a/common/console.c
> +++ b/common/console.c
> @@ -1212,13 +1212,16 @@ int console_init_r(void)
>         list_for_each(pos, list) {
>                 dev = list_entry(pos, struct stdio_dev, list);
>
> -               if ((dev->flags & DEV_FLAGS_INPUT) && (inputdev == NULL)) {
> +               if ((dev->flags & DEV_FLAGS_INPUT) &&
> +                   (dev->priv == gd->cur_serial_dev || !inputdev))
>                         inputdev = dev;
> -               }
> -               if ((dev->flags & DEV_FLAGS_OUTPUT) && (outputdev == NULL)) {
> +
> +               if ((dev->flags & DEV_FLAGS_OUTPUT) &&
> +                   (dev->priv == gd->cur_serial_dev || !outputdev))
>                         outputdev = dev;
> -               }
> -               if(inputdev && outputdev)
> +
> +               /* The current serial console is the preferred stdio. */
> +               if (dev->priv == gd->cur_serial_dev && inputdev && outputdev)
>                         break;
>         }
>
> --
> 2.51.0
>

Reviewed-by: Simon Glass <sjg@chromium.org>
