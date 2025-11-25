Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA55FD0EE00
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 17:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69D3584101;
	Tue, 25 Nov 2025 18:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="I7lYZgeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8CE784109; Tue, 25 Nov 2025 18:01:44 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2846C840ED
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 18:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-657509d761dso2883078eaf.0
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 09:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1764090101; x=1764694901; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8nEEWeNAUjiCCKHOptUR7FBuMOaX+9U51Pk9pcd1PXM=;
 b=I7lYZgeSMqbIlkFFaQtv5r0Xg+uDrXTs1GiHMX6m5ch0oJ/U9SE7S/c1MJOY+Gmcsp
 pp/l0EKtnq1dvfnXwNprvsXkhTm4SzOf8RrRP5v+fBUUDRHUURLdmYcZ4W86OJPmqku6
 Lmxe/RZtF8NOcrfzWPN5SS7S72XU/2QNACI35fMC5noEs+9vKCgATiDtsu4J6AcdRw6S
 5bwaFxWZI8/L3SJuP+jNw+smAKdhQQoqybmJyZUZEoHTmOFfdVIbTb+06IlUCmRkesO+
 sKXIgL6xBoOov736BHAhyDNnCJfu94gtJ9tbLvyXfuB/PPaBp4fygZ32OCCCBrr/D9/S
 HYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764090101; x=1764694901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8nEEWeNAUjiCCKHOptUR7FBuMOaX+9U51Pk9pcd1PXM=;
 b=hAWI9Ddb6SILnDIEwavAtwwQFMNhDgyTWBbL9MLThRyr+gAA4wS90OrxV7tnRoDXJk
 NJslahERuKZN622nBoFba4rzIT7aWnW9DWbsOcbEgJQ8d3sifUzpcRPIiSowtMuoLXC3
 VH/ZJmmELSFgJacLe3me6Cur83qZXvT6Kn02SSI3qCwIfVoQzn8qrlIS9wUm5CJEInJ5
 mKcd90mIf7a2BU9m0jH/XBQMI5KBZejSAkG9G5RnTj69Jdkrvs3CJIQjeaOnCGmzZMge
 2rOCStojKUoG5xKOWIXlEmv6PkeK1eWugqMCJUkVZvjrladYtrDgPPLeM3iSOo0D3cLk
 vHVg==
X-Gm-Message-State: AOJu0Yysq+CVr/SiEMZDeJpSNGSSH7ZOd6fqas3A9mCoQwGhf5nUpQYF
 KPeZsEQzHonql8XKP2ZVsbBFDr4/bLfqcBOKD3jE4RIuTNLZs5amWnPyRRxvaWzYyw2msdAkUg4
 7w2UPS6XEWQWH6MS1RhVjW8QhDs3w17khbTh4lYD8x9L6E7TM5/OMynw=
X-Gm-Gg: ASbGncs6XtA925l/zl2APfyLKg9gYrCZsK0APPblKJ4Vlt/1IgtCk/TsuTUycJw6g2Z
 03OsDkfWObavB56mhfmqLMl4bvkyeyw1PouJAli3iehRxhgOwO3zg0A/6dpAdblzGipNigTY+yp
 H+m3pGIebUYGRv43xr9Pn+Dv50RRARCxWwfRnp98w2/taSunnZts3d9lloya3QrQt8ReSL9LjwO
 eYGNjCMnY5h+imViBMhgndHdNYAecMPEpvgbkDeDnP8ft+eSA6tm6wd21Y4Xorc6Uw=
X-Google-Smtp-Source: AGHT+IHtaj6M1uXmjLL5FazqMpuWdL4dUYza2GRgCJypIwaNvv9wRX3EBIxbCnk3dd7q+/f7C1FlL4/lovxCYRsY5YE=
X-Received: by 2002:a05:6820:a0a:b0:657:63b1:660 with SMTP id
 006d021491bc7-65792500ce1mr6257785eaf.4.1764090098888; Tue, 25 Nov 2025
 09:01:38 -0800 (PST)
MIME-Version: 1.0
References: <20251118180345.590913-1-trini@konsulko.com>
In-Reply-To: <20251118180345.590913-1-trini@konsulko.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 25 Nov 2025 09:01:27 -0800
X-Gm-Features: AWmQ_blM_Nq-Dz0ucH-qiekhQ-FdhmuW64iEe1MEXCq9cwBXRqIqu86dAwv14M0
Message-ID: <CAJ+vNU3yBoZSYSkwu1o9gmz3zXk5fwzKUd13tqGoFyfpWRG0fg@mail.gmail.com>
Subject: Re: [PATCH] gw_ventana: Stop disabling device tree relocation
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Tue, Nov 18, 2025 at 10:03=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> If there is some window of memory that must be used for where the device
> tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
> or bootm_mapsize are the correct way do this. Please see
> doc/usage/environment.rst for more details.
>
> Cc: Tim Harvey <tharvey@gateworks.com>
> ---
>  board/gateworks/gw_ventana/gw_ventana.env | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/board/gateworks/gw_ventana/gw_ventana.env b/board/gateworks/=
gw_ventana/gw_ventana.env
> index 9a316c74f215..4322baa3d8a2 100644
> --- a/board/gateworks/gw_ventana/gw_ventana.env
> +++ b/board/gateworks/gw_ventana/gw_ventana.env
> @@ -13,7 +13,6 @@ hwconfig=3D_UNKNOWN_
>  disk=3D0
>  part=3D1
>
> -fdt_high=3D0xffffffff
>  fdt_addr=3D0x18000000
>  initrd_high=3D0xffffffff
>  fixfdt=3Dfdt addr ${fdt_addr}
> --
> 2.43.0
>

Hi Tom,

Acked-By: Tim Harvey <tharvey@gateworks.com>

Best Regards,

Tim
