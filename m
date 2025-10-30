Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F023ECCF9E5
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 05:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A90083885;
	Thu, 30 Oct 2025 06:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DKh1teYb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF7A583887; Thu, 30 Oct 2025 06:01:40 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C968C836D1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 06:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-63c3d7e2217so911461a12.3
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 22:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761800498; x=1762405298; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r0ybn3KmtmK7gLsJHnNmza9wbHr+EyVfoBi6AWi+wdg=;
 b=DKh1teYbuY+NUyTJCdCGX1B04FscfxG0qAZT1X3zR2rus2cqb1NA/sn6a62QgX8Ahx
 75KNRRFWNN8TdDxUE+7hSmgYCkibiq/+D6M8OwAPdGQ3HhEzSVUiFhCojoiSPLV+vgkT
 27fWLt3U3FqsH9d5eY88JzwUBulSvFMITK0Vgminwecf0/yfIG+TsalFA1rhBkR7ipkp
 OECOo0x4fk1ia0mVYqSdDWxf93dp9DFXAK5s8A7RBG60kx+vohXQLYKhq2j1eHP0wUiX
 ovz7iRtWew1okg0vYrWnPX0Guoib4wBM6C/2GEtqb2MVSp8TbiCWt3sgbk9ra4o31BIW
 gHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761800498; x=1762405298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r0ybn3KmtmK7gLsJHnNmza9wbHr+EyVfoBi6AWi+wdg=;
 b=WQnx7ZiLWT2xDT4sez9bTOYN0HI9USNuIaUu0vcpmdcVcIj+TkI2UGz6aY2yJGeZEp
 OSclljKEoySSQcxWaRDyqlEbejgCJ+zo2OigQGZetJvlQC4bfRafi8vg4rKE2NC+Dy4L
 cvz7w47cZcl03Zx+PH6gfkNeiOtqPjXUoVw/uaqiano9tvoRC39e8E+eJ+9b1b4IntKe
 toHIpDUU5x+Qq94d7iKg0tqFcBd332gC3KJVLDBBRnDgnB1yAKUBS0B/yafThEytNlYO
 TQbrhhVZtm5PZ9u75kQyQWrwaqpgl8qEywKfGcheeWtjcL0tDWSTX2gihCZ4/bGcMrO2
 wYbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZvyPI/rDY9ZBj1/ff5zwcdvT6mHzJBkv8sPLPYLVbq8BhR6nr5hpMzQyB9R9Npw6ZEUjXXX4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4xRyruaeFyJiEGZes1OgaM0Hz0PM5KWTIW/ywNbvoj1Ss/p9w
 XreKrja4M5/2bz7Fmcp4+G4QXNjIr/Qqjex876VYusXJzeYQv/GcYwEMq5kcsCN862uQb0dNZIR
 OramimxsDq+XpFmuPN+76SNmqabd8vRc=
X-Gm-Gg: ASbGncvUq/7rxiT6VOPmVjHeFE21HDtsXS3OcWG8T5cCoXaK+oYWLZU45gUY47R4q9B
 V4ce01qo9/gXOoCAOK444xBOXhWF3zXxOsgI0u57zGkRRB9v6qZWWGe7NM7DNZYdnrkMiptv1pq
 LpxRACUwvULvHH/MaTBsDG6gIynpRQk/0DoCXMMBdazYa9lMzn9VjhqMgO1dKu9S2m3KagOTZi1
 owvsUfb+UHChydVT99PRqpbYtfQn8f3M38vzR59ux0MB/6YGCwXY5pKmBB1uwK+vsoUa8MxkpJy
 nzQv
X-Google-Smtp-Source: AGHT+IGROfvPZt3KnrvNGcGzDKhL3x0fN+83X31fiYo0hYyH99x4ZxSN78EZyY9ga+/Bqi+L4U23vJO8ZUV62N0fhHs=
X-Received: by 2002:a05:6402:2354:b0:63b:f1aa:11d1 with SMTP id
 4fb4d7f45d1cf-640441aee39mr4466520a12.1.1761800498145; Wed, 29 Oct 2025
 22:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20251026010658.19271-1-semen.protsenko@linaro.org>
 <20251026010658.19271-3-semen.protsenko@linaro.org>
In-Reply-To: <20251026010658.19271-3-semen.protsenko@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 30 Oct 2025 10:31:17 +0530
X-Gm-Features: AWmQ_bnxEdoc1OVBmdzVxGfw0PvUSUFsFV7ol5hdhgcpAIO6FhFRIE5TsebhsAY
Message-ID: <CANAwSgT6N1WFvxQyUkLChCBga9NPq9XbkiWhek2Wdz4S1Tb=vQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] mmc: dw_mmc: Do not export dwmci_send_cmd() and
 dwmci_set_ios()
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Simon Glass <sjg@chromium.org>, 
 Lukas Timmermann <uboot@timmermann.space>, u-boot@lists.denx.de
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

Hi Sam,

On Sun, 26 Oct 2025 at 06:37, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Do not over-expose the private dw_mmc API. The glue layer drivers at
> this point shouldn't be aware and shouldn't use the generic
> dwmci_send_cmd() and dwmci_set_ios() functions. Making those functions
> public causes a "leaky abstraction" issue. It clutters the public
> interface of generic dw_mmc driver and possibly leads to improper usage
> of those functions, so it's a bad design.
>
> If struct dm_dwmci_ops has to be extended, do so by copying it first
> (like it's done for example in snps_dw_mmc driver). That also makes sure
> the future changes to struct dm_dwmci_ops in dw_mmc driver will be
> automatically reflected in all extended copies, and avoid code
> duplication.
>
> This effectively reverts commit ef3b16bb8e73 ("mmc: dw_mmc: export
> dwmci_send_cmd() and dwmci_set_ios()").
>
> No functional change.
>
> Fixes: ef3b16bb8e73 ("mmc: dw_mmc: export dwmci_send_cmd() and dwmci_set_ios()")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
