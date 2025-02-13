Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3D0C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 14:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFD2B80F0B;
	Thu, 13 Feb 2025 15:01:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QXno0IOr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17DFA80F03; Thu, 13 Feb 2025 15:01:26 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 125C9807D9
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 15:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5de4d3bbc76so1437340a12.3
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 06:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739455283; x=1740060083; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VzrQvDj6s3sBAjxcJMc9gIpheXJQ1Lz1hSr4sa947gg=;
 b=QXno0IOr0Czlax5Gl/814Lc0Ny3Vt0rYaySomtLlz4KvtVXnpIoNnUCk0uIGU22+5+
 BmXVKlY5FOQk+AYiLmwQtTYXAUJ3KnyhZEMSWKgLy/lGRoV+GnUUtaSghW/unZ+kBe3I
 68oY7RGIBAr2P8nRviruHQosGwFBRFrbhrdpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739455283; x=1740060083;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VzrQvDj6s3sBAjxcJMc9gIpheXJQ1Lz1hSr4sa947gg=;
 b=CjpDUQVhmzrvlAvnPnnDbvyCDpjWutpjHHtullfW6qoWhO+htv4eIXTW5bTptau1gw
 AjGk6VN4df1eAEkFkJxgcHWAQlPWP75+w/yITIIAZ2PPeFOVI+YRODsECy87yozbtY0n
 k3Lk0cz/nQWlUb9jX3IaUcLiS/bLenJT4F9TMUMDw6SEEgvdHzJcSD8RL7AzINiyqM/H
 yfyki1N2G3u9MCyfrHh0zNulHGPKNKjfWCKa1KKV6+o9JWZaG0XgInCj0XqKzCiCq/Ts
 l9RXOyRWNMwLFBO7AYUQ0W8zzbFjaY2XRNunK2D71/vfGd/7sfXHJhWttCiQqu7FFZMQ
 qH2Q==
X-Gm-Message-State: AOJu0YyOdn4EfdJL5CHt5FWiQmk8cLxADmiprx7zMf9g7U2IO/jWsNsO
 WDLHKQDfomCJEBbtd7WKiqvWTTDQu2NVy+EPXh6ZwQZcenIyvnwCgwK4Ndk90e7+GTyEHiTv3V2
 pLwez9e+2iFKJhgD/J6+kOz92l25S5uuy62LS
X-Gm-Gg: ASbGncsaJH2TNze7UStaZFuw646Pd/Kbzz0F8N3SZX9F351AaPLs7ECmYE6ztsFZ4Ec
 89J4Gvp4YfYgd55KvPH6sMHUSMiGbOca/r/SZXlMRTgRGC2CZz7u2XmSj7ag94RPGTcT/oqSHBP
 E6dkBqhHCab6sXN434l9GD6/UJk+2m
X-Google-Smtp-Source: AGHT+IHCwikF8utFB4k2BEfP0t7rsdzrgBM8/3DH1DDNoA/t9BXTKqqhpWOs3viWaOkN2lDY3coRT+r/KQU1fQZUWpo=
X-Received: by 2002:a05:6402:3510:b0:5d0:bcdd:ff8f with SMTP id
 4fb4d7f45d1cf-5deadd7801fmr5838854a12.4.1739455283251; Thu, 13 Feb 2025
 06:01:23 -0800 (PST)
MIME-Version: 1.0
References: <20250212091820.213895-1-m-shah@ti.com>
 <20250212091820.213895-2-m-shah@ti.com>
In-Reply-To: <20250212091820.213895-2-m-shah@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Feb 2025 07:01:06 -0700
X-Gm-Features: AWEUYZmFmxLt2rxF1ZgcKJknL5-2ectjqi2_U01sEf4aA-biwEHnvlVXwvZ5BiY
Message-ID: <CAFLszTjCT7ubR=k0Gd5AAt+m9cH7qgQzT1S8z5LCVHSrgAnCow@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2 v1] arch: arm: Kconfig: Add config to use
 subnode's bootph property for binding drivers
To: Moteen Shah <m-shah@ti.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, m-chawdhry@ti.com, 
 n-francis@ti.com, vigneshr@ti.com, u-kumar1@ti.com, a-chavda@ti.com
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

Hi Moteen,

On Wed, 12 Feb 2025 at 02:18, Moteen Shah <m-shah@ti.com> wrote:
>
> Add a new config when set will traverse through all the subnodes of
> a given node scanning for bootph-all property and propagate it to
> all of its parent node up the hierarchy.
>
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
>  arch/arm/Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 314916527c9..51fc952b0db 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -805,6 +805,7 @@ config ARCH_K3
>         select FIT
>         select REGEX
>         select FIT_SIGNATURE if ARM64
> +       imply BIND_FROM_CHILD_BOOTPH
>         imply TI_SECURE_DEVICE
>
>  config ARCH_OMAP2PLUS
> @@ -2232,6 +2233,16 @@ config SYS_KWD_CONFIG
>           Path within the source directory to the kwbimage.cfg file to use
>           when packaging the U-Boot image for use.
>
> +
> +config BIND_FROM_CHILD_BOOTPH

How about DM_F_STRICT_BOOTPH ?  or DM_F_CHILD_BOOTPH ?

It indicates that it relates to driver model before relocation.

This behaviour is actually required by the schema. I agree it should
be optional, but only due to its performance issues.

A Binman solution would not have any performance issues.

> +       bool "Bind drivers from bootph* in subnode"
> +       depends on ARCH_K3
> +       help
> +        This config must be set to bind drivers in pre reloc stage whose
> +        compatible parent nodes are implicitly declared to be bound to
> +        their respective drivers by having bootph* property in one of
> +        their subnodes.
> +
>  source "arch/arm/mach-apple/Kconfig"
>
>  source "arch/arm/mach-aspeed/Kconfig"
> --
> 2.34.1
>

Regards,
Simon
