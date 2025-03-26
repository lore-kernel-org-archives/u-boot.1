Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A00EC36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 07:32:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD2A9808B6;
	Wed, 26 Mar 2025 08:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nx5vr+CB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B030D81B4B; Wed, 26 Mar 2025 08:32:17 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A21B8083E
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 08:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e455bf1f4d3so5123102276.2
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 00:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742974333; x=1743579133; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IAl3CBMbQIKVG2RQfVw8wdAIFwuBssjiXxXhHPczY8Q=;
 b=Nx5vr+CBQHvgWr+DE8AM5VxvZifnZhc2U6y0hBdlD9S9BpB86toHe1pYS7WSZsODJk
 JT4OIisksUQMCnGqP9c9u328YFlRo5wf+bV78y2x/nMaS+kxtlen3k0WVKEXgfjnv6US
 zRgvKUncWfus5F+OeUsbBTHU15T6+x3nYp6BnaflkXJdLpWCZxxSXFC/FSVI3Q4tai95
 mxfblUElMeXKvOv/4rXx/9wAStC+aWdClvvdbT1KpNiVGyqk8tB7gdtCOLZYyZKfekW4
 dUIVHWCe3KSzqmZ7nqS6ithOfgxhB7o3p5YzXIufa3ixe79ssVF8qCyaOTKjgbPUhxrg
 WHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742974333; x=1743579133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IAl3CBMbQIKVG2RQfVw8wdAIFwuBssjiXxXhHPczY8Q=;
 b=mhpqYCQvEtOtcmO25LUV8Og529yFtFuqz4qHZ8l0hL6kLisI99GOGQxwYjPL3Pspr2
 z+/8T4LtIUX1WuYYI368Kw19S9U5LFzCPyVUP6oyqMUeX+aMT/lvzjEIbTZXjKCUoz8k
 nmJaNPtc4Wp1GoVk5UcP7nG8Ac5dfapklqkhnN0v2H8F3EuKW5HZ8SNxg9CNUop/I9kQ
 HLPaCEb35/sEFaubJ686DM61tfD8PYL2LGm5lpB0xjz3IjsFZWO9pKgqbWMdwHCpymla
 TqMt8sxqt2m+Mk58pmrKYkoMeh0br7/PTcS54E7FqLWEF5DoJhaJ23UOdC+iiAKDZ0PK
 yTtg==
X-Gm-Message-State: AOJu0Yy5N8Q8hE8eGxLP7gpcSUreO8/teGUIjEWEBblH5Ygf275x5PXN
 9wPYPUK3vLwzJgO6AKqG108ll7poQEMLfft48sMb3nQ12W8s16FXsAV1e4chxDAaR2XBOuqO0O6
 zqe9KpuD/m1+hHsFy3oVZ70eDCck6HzgMxx1+dg==
X-Gm-Gg: ASbGncs0GMRZenDTcIgthMusN+x8MzbUqxao30OneG1linejUUJev3xymzNom7N3qWD
 RlUaTly/Wc6qOabWySIJzHPkAJhU1iYztVulg4ivi/dkNLlD6zZqdxa6Ouols+nB/2JDtdl68yt
 sauER/dxF1aCt4opqfTpNPJWNZOlc=
X-Google-Smtp-Source: AGHT+IFwUtlH8XburCakaU3hyvIirPfoqM/ymfJXyGO8vSdNgCDF0TJSVgagakZcYUF9MiOxew3xgtIaX1ddBHBVrI4=
X-Received: by 2002:a05:6902:2781:b0:e5d:c5f3:13e1 with SMTP id
 3f1490d57ef6-e66a4faa663mr20682373276.35.1742974332884; Wed, 26 Mar 2025
 00:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250324083443.1537006-1-vincent.stehle@arm.com>
In-Reply-To: <20250324083443.1537006-1-vincent.stehle@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Mar 2025 09:31:36 +0200
X-Gm-Features: AQ5f1Jpe20cRwr1XCIhC_X8TCOfGkGbhIrR1JE-8gjLBp_E-3uzYCdX3urIi-UI
Message-ID: <CAC_iWjLcxKvouVTzZvJq4i_Vc82PU8aJOe6eU43KmRawj6z=0A@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: fix ipv4 device path node conversion
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Adriano Cordova <adrianox@gmail.com>,
 Tom Rini <trini@konsulko.com>
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

Thanks Vincent!

On Mon, 24 Mar 2025 at 10:35, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> =
wrote:
>
> When converting an IPv4 device path node to text, the
> EFI_DEVICE_PATH_TO_TEXT_PROTOCOL will produce the following string:
>
>   IPv4(5.6.7.8,TCP,UDP,0x6,DHCP,1.2.3.4,9.10.11.12,255.255.255.0)
>
> This string erroneously contains multiple protocols: TCP, UDP and 0x6.
>
> Add the missing `break' statements in the dp_msging() function to fix thi=
s
> and obtain the following expected string instead:
>
>   IPv4(5.6.7.8,TCP,DHCP,1.2.3.4,9.10.11.12,255.255.255.0)
>
> Fixes: aaf63429a112 ("efi_loader: add IPv4() to device path to text proto=
col")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Adriano Cordova <adrianox@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  lib/efi_loader/efi_device_path_to_text.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/efi_loader/efi_device_path_to_text.c b/lib/efi_loader/ef=
i_device_path_to_text.c
> index f6889cb7399..452ec1b2e8b 100644
> --- a/lib/efi_loader/efi_device_path_to_text.c
> +++ b/lib/efi_loader/efi_device_path_to_text.c
> @@ -181,10 +181,13 @@ static char *dp_msging(char *s, struct efi_device_p=
ath *dp)
>                 switch (idp->protocol) {
>                 case IPPROTO_TCP:
>                         s +=3D sprintf(s, "TCP,");
> +                       break;
>                 case IPPROTO_UDP:
>                         s +=3D sprintf(s, "UDP,");
> +                       break;
>                 default:
>                         s +=3D sprintf(s, "0x%x,", idp->protocol);
> +                       break;
>                 }
>                 s +=3D sprintf(s, idp->static_ip_address ? "Static" : "DH=
CP");
>                 s +=3D sprintf(s, ",%pI4", &idp->local_ip_address);
> --
> 2.47.2
>
