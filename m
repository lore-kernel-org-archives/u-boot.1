Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD94C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 12:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEA808091A;
	Thu,  6 Feb 2025 13:34:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LXWPBgRl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB14180A09; Thu,  6 Feb 2025 13:34:07 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8445807FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:34:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5dcd9c38f66so3786087a12.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 04:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738845243; x=1739450043; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gHqkAdcIlZr83Jxhut0FO7fEQOGkYW/42vDl87S/VGs=;
 b=LXWPBgRlaCjG4lNuEDlKCHGByF5/ekx0/+0s9NBN9DiunIhaVtrWKVDoWLzGgKq38a
 pemBE4/LV52Qi9Z/MLvySKSGhP8yzcCeyvPIm952bt2vhMqJPIRTOZfabysjiJwixeGH
 pUqjVdQcCnWzMg8cC0c/EvIWl5IoEVUXmEbMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738845243; x=1739450043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gHqkAdcIlZr83Jxhut0FO7fEQOGkYW/42vDl87S/VGs=;
 b=Ieejigm+2+G1C0Y/HE92JDrFNdV0ly99VK4xDSeao73bpK5Syn0PxsI7cxXpB6+dLV
 plOJMT5E+imL2IAjB8U12vCKJfn54nfVh70iVihITieLtTVB8kGzE9wNgi5Go8OTjSQp
 zbVO/tbEcFTUoAfTFFJkZe+a10ZWBjeejSpUJ9jui3eGYnlpE85+Ahhis/JEp3+HC+BZ
 mq7ABF9p8iIVWPJfgbF5i82zctO6y9cAlRkGNh83W4N3UGgdterblmLs6C7cbHxrKALg
 L2OYcVdEOtiSnPUh4yqpFSBySPCvNS2X4/lwuWItZk4B8UPA2jcRM2ZvyAGG2op5hN6L
 6vNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQLWG2LsjS33S78j7tKxHGUT18M0yzS8+4Wzq2FXs+NVpJJOFarYDxDjHlEouJvAk3RMfcB18=@lists.denx.de
X-Gm-Message-State: AOJu0Yzte9UIZigoh86+/sa8dQvLWyYD7mdAxAlkgWeJQm79Aj0iITe3
 t+0Rj1bostLTXefaJZtUuIZPcYiD39M8hbj+hFCPrJqbQtIva6xpVXsQ8LJe29Klag7+Vt1x1tI
 n5ga9Xj8cdoYvEjMMSXTH3p4HJRtdm/fP1lXg
X-Gm-Gg: ASbGncu9l/Px+g616fx+yOUo4DzzgRHMfLC9NzUvTxPGSQbs0RMmn0myO+Af06TKcFM
 ynAngSD1noqXLwxXKn3G6FPwShPabFAy/Q5DsTzuEl1uebFVBSIulbry+ljUtshT2aDLTzfNpkQ
 ==
X-Google-Smtp-Source: AGHT+IG9/zVcwPAgaQzYXPFyO74fEe9R1b/W0DUiyy85R7TIIFG9HV07K1RcZ0MdZZgKxYEWIsdghqLOY6akBOvkjh8=
X-Received: by 2002:a05:6402:3508:b0:5dc:dfc4:4aa0 with SMTP id
 4fb4d7f45d1cf-5dcecc96b83mr3036531a12.8.1738845243132; Thu, 06 Feb 2025
 04:34:03 -0800 (PST)
MIME-Version: 1.0
References: <20250205-bootsource-v1-1-95f4ba69ac27@cherry.de>
In-Reply-To: <20250205-bootsource-v1-1-95f4ba69ac27@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 05:33:51 -0700
X-Gm-Features: AWEUYZm87uehcjS7OzT_e3knKYWvxlwQT02wiUO5a6yjHi-b0-AvjI4387WgLH8
Message-ID: <CAFLszThr_vLbhU7A0_0VTLCGW03k6NmtxLVoW7OzrtxGFertZg@mail.gmail.com>
Subject: Re: [PATCH] Add 'bootsource' /chosen property
To: Quentin Schulz <foss+dt@0leil.net>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>, 
 devicetree-spec@vger.kernel.org, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Quentin,

On Wed, 5 Feb 2025 at 02:12, Quentin Schulz <foss+dt@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Bootloaders typically can be loaded from different storage media, such
> as eMMC, SD card, SPI flash, EEPROM, but also from non-persistent media
> such as USB (via proprietary protocols loading directly into SRAM, or
> fastboot, DFU, etc..), JTAG, ...
>
> This information is usually reported by the SoC-ROM via some proprietary
> mechanism (some specific address in registers/DRAM for example).
>
> It would be useful to know which medium was used to load the first stage
> of the bootloader. SoC-ROM shall be ignored and not reported in this
> property.
>
> This can allow client programs to detect which medium to write to when
> updating the boot program, or detect if fallback mechanisms to
> unexpected medium were used to reach the client program's execution.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Bootloaders typically can be loaded from different storage media, such
> as eMMC, SD card, SPI flash, EEPROM, but also from non-persistent media
> such as USB (via proprietary protocols loading directly into SRAM, or
> fastboot, DFU, etc..), JTAG, ...
>
> This information is usually reported by the SoC-ROM via some proprietary
> mechanism (some specific address in registers/DRAM for example).
>
> It would be useful to know which medium was used to load the first stage
> of the bootloader. SoC-ROM shall be ignored and not reported in this
> property.
>
> This can allow client programs to detect which medium to write to when
> updating the boot program, or detect if fallback mechanisms to
> unexpected medium were used to reach the client program's execution.
>
> Note that this property is already set by Barebox and I'm planning on
> adding it to U-Boot as well, specifically for Rockchip SoCs.
>
> I have some doubts about the wording, especially in the case of
> hypervisors or chained boot programs. I'm not entirely sure what would
> make the most sense to put in the property for those scenario.
> ---
>  source/chapter3-devicenodes.rst | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/source/chapter3-devicenodes.rst b/source/chapter3-devicenodes.rst
> index 8080321d6e60d6b1e86c81af86c6850246a0223b..defd1a46e4ffaa4bb085306b5e153d38b740ac66 100644
> --- a/source/chapter3-devicenodes.rst
> +++ b/source/chapter3-devicenodes.rst
> @@ -456,6 +456,9 @@ time. It shall be a child of the root node.
>                                                         the client program. The value could
>                                                         potentially be a null string if no boot
>                                                         arguments are required.
> +   ``bootsource``          O     ``<string>``          A string that specifies the full path to the
> +                                                       node representing the device the BootROM used
> +                                                       to load the initial boot program.

Could/shoud this be a phandle instead? It might be more efficient.

>     ``stdout-path``         O     ``<string>``          A string that specifies the full path to the
>                                                         node representing the device to be used for
>                                                         boot console output. If the character ":" is
>
> ---
> base-commit: 5688e1c0b961d2ca5a32e3b624a9f4a9b433184f
> change-id: 20250205-bootsource-84df255e9e6c
>
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
>
>

Regards,
SImon
