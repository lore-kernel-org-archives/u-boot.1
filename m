Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED748CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66282848EB;
	Wed, 27 May 2026 03:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mX791pL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 799CC848F0; Wed, 27 May 2026 03:16:28 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91C5A848EB
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 03:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-67c4aaf76ecso17622517a12.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:16:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779844585; cv=none;
 d=google.com; s=arc-20240605;
 b=Y7UhUe2sU+L7B3UNXid8WgB/LBkybPeaSyGdteA4lnxoTc14bLyc6sIGoh0KZ81Fyj
 X6PDMaHbZ/F4YZkoX5eua4nebroRi767PUtQ6UEBnacXF4XPY9eFQpasBDK1d0/5A79E
 lWqQtm3CH4rxYJJuOetyt104mONf3Rf4t3kLHtk01SH5jMNLP0sIUtq3qj7yrQbvtbd2
 SPV15eYTOh5Ch9F2GLI/SoE10z+auItvkYOlxDg8lnblMazUcJNagAjCBSfFYtYIUqdZ
 Y4XngYM46crHJB5bHzXwPJlVKO8XLG7UMneBuh9TF1HJCQ3VqjvsyUOjtGg6zXb+/caQ
 bHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OBd52PqAwe+CiHBSEd25Vc5youWkub/ILZvoU3GM0p4=;
 fh=SDG10Jarq5MW7534cBW5kKFynf3YXbLpFXcuVBAxMfM=;
 b=UjXF6qINe7QRdDf6FTqLTjjaLpf3QkEYbzpR+o7mi48N49Ter9hdAd+8EeflY9Td51
 988Frud4dWhUx4T9JB6pGT/FY1V56F0RQtSY833A0DCxa9im/Kx+4NxyYjLzTF7tUuDP
 w8tbQiI3ARbFXsA3Vz2qcP5TRehNC+9okMGdYIDtx2WwMqIZ9AK8pzEyHbV5t6rEdvIR
 3iAI0IkIL4JWkJ9UeY3lBlOl7WtzBh0S7SRUmMiARrqXG6oQz+O0I5VfYk3yeMMFZKB0
 TA1esJDRTJl1S8kiPvMU6Y7qXcfggAf7/ecHgpcwa1skE9ADmreNpPSR90hxi1dDacQr
 s8Ag==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779844585; x=1780449385; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OBd52PqAwe+CiHBSEd25Vc5youWkub/ILZvoU3GM0p4=;
 b=mX791pL7Any8S2NFX8t0fs6us1R3Iv6xQ7TBRJdZakWd1I+Ecw5+MCcwixsktY86Lo
 aKApojlwtoiXv6e8pD/aevreclXnr1RVLQv9GTO30GwWGGhB/RKjIUdi6NsdiSwD3rHR
 7ZAYKVM/YhJq4VB9E0l3t4nx4l9SHiD1WXmfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779844585; x=1780449385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OBd52PqAwe+CiHBSEd25Vc5youWkub/ILZvoU3GM0p4=;
 b=bVpza3E5aWxcrs8IE2Uv4D/F7Wz3QyLYpscFqGRtjUvvi6ES4U84ud7LaqSVCLxLxr
 26vacgn1AyS3l8KATA5C0ygKXCGEALKIagQDGNmm9JJguZjud2mJN1+DWYVa39+jXEne
 BDUb4YrqMJ14x6/drG1b0HEdT64J3YGLz9mfvvf8XlclScpfRymXhdXPqDE84W9WZmSJ
 tG/v3lUobzK4eus0Hkn+4fDZrmsva7AUDOIv1GW3dVWDgrniNgNT92GEYuzYFuFY1wsa
 YGIlBVTqRXJ28vqXXSubLGY6uWMpQ/yFB8Zrbd1VZTTwp7h3LyiB1/nsv24QRm8t4Lxk
 neew==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bsCrYm1YhkJy1Ma6YCZcLH9SkH9Y+rQcLdfVn7loLHg5uy/CSATDfZLFyg3gBqo5oXyqXnGQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwUa/bpvatZ8+IhB0zloIX1yImV8QglBHRG5wITrKVX1oxtgqLD
 jO7VR7fvEjUumK63sj7KvNWKf6N4MgUh4GXgN1SjJPrW8XHnAiYJVGpYZEAAm1+RAKrV/Z9axwV
 qoI5fIYMUjUpTkoA6YxttkWFni4/AoUlM+mGx4wTk
X-Gm-Gg: Acq92OEF8p1WXQLGnsMVlBIxB94eugVnyw+5CTi0ea8URSScuz5RZjzv08Fe53DXcml
 eZrXLWrA/BkFlXFXKCAPlXXMqrWp+LYZxe3farZvUaVgXW9xVE53Z+1OtDqyyyyzwrkdQhW7Otk
 +sTWkQN9sox9PGzcEjbRuTGUEeOFBVSEYYcTSRoWKYcuiQc9L/M/5eAreg0PGbCr6ZOfXcueFV0
 MkV7L+VaBRHLdkDgcpJx1UVdsIQJPLSxyiIwnem8qmdfzWCuapVI81zWmVbsttBrN3J7gEsdpRT
 28O89Kk05YP8yTpW
X-Received: by 2002:a17:907:75cd:b0:bd3:897c:7800 with SMTP id
 a640c23a62f3a-bdd25cee478mr963710666b.15.1779844584956; Tue, 26 May 2026
 18:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260526124044.354578-1-Alexander.Feilke@ew.tq-group.com>
 <20260526124044.354578-4-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260526124044.354578-4-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 20:16:13 -0500
X-Gm-Features: AVHnY4LNTujqe2qK3rBB3V3rD2WpkA4_r4Py8EF1NowKnfE-FYXrib4SOGh5N9Q
Message-ID: <CAFLszTjJ=AQWm17EF6DoA1MvWbXb_OsqFfGMOWKHPfGo6O2zvg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] sysinfo: tq_eeprom: new driver
To: Alexander.Feilke@ew.tq-group.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
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

Hi Nora,

On 2026-05-26T12:40:39, Feilke, Alexander
<Alexander.Feilke@ew.tq-group.com> wrote:
> sysinfo: tq_eeprom: new driver
>
> Introduce a sysinfo driver that can be instantiated from the device,
> which will provide information from the EEPROM found on all TQ-Systems
> SoMs.
>
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> MAINTAINERS                                        |   1 +
>  configs/tqma7_common.config                        |   1 +
>  .../sysinfo/tq,eeprom-sysinfo.txt                  |  36 ++++
>  drivers/sysinfo/Kconfig                            |   8 +
>  drivers/sysinfo/Makefile                           |   1 +
>  drivers/sysinfo/tq_eeprom.c                        | 203 +++++++++++++++++++++
>  include/sysinfo/tq_eeprom.h                        |  24 +++
>  7 files changed, 274 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

> +static int sysinfo_tq_eeprom_detect(struct udevice *dev)
> +{
> +     ret = nvmem_cell_read(&priv->device_info_cell, (u8 *)&data, sizeof(data));
> +     if (ret < 0) {
> +             dev_err(dev, "EEPROM read failed: %d\n", ret);
> +             return -EIO;
> +     }

It would normally be better to return ret rather than masking failures
as -EIO, unless you have a particular reason.

Regards,
Simon
