Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F74CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 09:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CD0086D01;
	Tue, 17 Oct 2023 11:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kEaVj3cV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4315486D01; Tue, 17 Oct 2023 11:14:54 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A2F286B38
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 11:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507bd644a96so582407e87.3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 02:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697534091; x=1698138891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5CcC6oTzAbyKJSroxlDugKnnel1BlmgxdSGhc1Ll2Cc=;
 b=kEaVj3cV6q5F1CAUmEfziXcAFELBg/KiSUFyLt/F69FudCs9tMqt6hywTo41w0RXzV
 2hlLxyvcswzMnmsRhbuvaPb63PhN5PdH1osUjoChLzmz54DplvLkGa7+Qm7vB86MwWr3
 4miBHfiov5ClWNuQusMo8Ys36VHfHKk1Q+kOLrmps/j79Hq9YgknJ6E8muQK2DeT66d8
 m/01KnFl5GPT/5ZRD8pVHMGR5Piw5x1nJ7pv2lPkzmiUErt/dNZ+d+iAO9BJHSWTINmr
 vD1DmWPcFJoflhukGygZICkODJA9EPe/Y2h+bS/wA+FedsfkYiECgY4fSIT1HtfjDcW1
 NWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697534091; x=1698138891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5CcC6oTzAbyKJSroxlDugKnnel1BlmgxdSGhc1Ll2Cc=;
 b=RLRuPTQ9YFYxnoIYJeCmwH3xjEDsOOajU1wdgwKZCp2Kol4HbinPqBCbYQAIicbWAy
 zO1jIuGSPQ0LXfcntTqDBIuQXaKOR3gQBQX+M6/Mff/9XBgEwUpK3g3ok8vETG7oEY89
 TZfbtUPY+8c4Zhmv6V0+eaWkLt6DMtcNBY2NVCWsTAYxKt18flJZiDPiwmcu5fkB2Qa2
 YvYn2WGoQuuNUOXOzT/ZMsJgsnL4Od2He9qKQ0A1EXMnm1gEAg1LhL1wgBKYVnR4XrQ1
 BQhw/6JmuI8hNmU3wEvt1Gh6Hm0cNW/2ICQI3H4nbiqu2HsZXs6G7tT13OCNyJ3Sk56U
 0SBA==
X-Gm-Message-State: AOJu0YzYs2iKT9raO3q+z8fppzPWZkne3wy+nIJKZMwEmeqMbbAxmDXd
 tmglhHGMMDzfFPW8jM91UFAqAaxSuijt/ikaxfwaxZuzbYfXcMbewus=
X-Google-Smtp-Source: AGHT+IE+tlbkuFyDjEJ4+41JiunQP8ufKMZCMi5+jQY7i3G82LeIrKBtpKAtWHwKM91jkbHVT2XwlOTyuHuL1Q4/jYA=
X-Received: by 2002:ac2:44cd:0:b0:4f9:586b:dba1 with SMTP id
 d13-20020ac244cd000000b004f9586bdba1mr1249373lfm.4.1697534091231; Tue, 17 Oct
 2023 02:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231017085507.12094-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231017085507.12094-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Oct 2023 12:14:15 +0300
Message-ID: <CAC_iWjLgt0USVOQxp6WE_1edxMYMdGzfhvEFM67e91m-_iYn-A@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: expose the device-tree file name
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Heinrich,

On Tue, 17 Oct 2023 at 11:55, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> Forward and backward compatibility of Linux kernel device-trees is
> sometimes missing. One solution approach is to load a kernel specific
> device-tree. This can either be done via a U-Boot scripts (like the one
> generated by Debian package flash-kernel or by a boot loader like GRUB.
> The boot loader approach currently requires to know the device-tree name
> before first boot which makes it unusable for generic images.
>
> Expose the device-tree file name as EFI variable FdtFile.
> This will allow bootloaders to load a kernel specific device-tree.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_setup.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index e6de685e87..b24feb94dc 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -26,6 +26,27 @@ void __weak allow_unaligned(void)
>  {
>  }
>
> +/**
> + * efi_init_fdtfile() - set EFI variable FdtFile
> + *
> + * Return:     status code
> + */
> +static efi_status_t efi_init_fdtfile(void)
> +{
> +       char *val;
> +
> +       val = env_get("fdtfile");
> +       if (!val)
> +               return EFI_SUCCESS;
> +
> +       return efi_set_variable_int(u"FdtFile",
> +                                   &efi_u_boot_guid,
> +                                   EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                                   EFI_VARIABLE_RUNTIME_ACCESS |
>

Why is runtime access needed?  Wouldn't the choice be done before
ExitBootServices?

[...]


Thanks
/Ilias
