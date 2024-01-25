Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591BDC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 16:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC5B686DEE;
	Thu, 25 Jan 2024 17:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G9usHiwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93D5587B5F; Thu, 25 Jan 2024 17:09:24 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EB10807EC
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 17:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5100cb64e7dso3381501e87.0
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 08:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706198962; x=1706803762; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wMMkKI1AZnv1LfvNqVNO26N6heRIABFQkBCegtYBLZ0=;
 b=G9usHiwDq/VMHGAWVL2laN08scccD21LRtY66/98MMEjH/lUzXRQvz6GCYBJ8571K8
 KiopT105MzRwjGEKRDyKO+7uEqi6bIgqNDAcJIRb7nyJSxrU/BwrGbdMpNzKx4H4RQPT
 S+dlVLWTMhOw6IEv8SGYBPHv0yFwRbdwNFDQs+LrBUpzdE3Hjd9FGm/puTlKX5TVlfx4
 1+N7AX/w4ElRYtj1SxBq4m4lElgNoDdX6UXl5x3j8pYqtiZPsQ0Yz2BZWpzyZyQJUDSC
 ZSvKNgSmJsXV9YsbfnkSkV0lZBhcDUcprBeNQ0QJa8+di1fipNgBrAF42UZ5flfZ3Ffy
 jd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706198962; x=1706803762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wMMkKI1AZnv1LfvNqVNO26N6heRIABFQkBCegtYBLZ0=;
 b=f7VWbcjlMxgtisIXFD9kG76MCsWglXC3NTmvXL1Elli9gPc6Qe15ozYDSV0qSmZxPR
 AWMTG74W9IZ5YdAh9bIzjIo+luYmSKOY1B1wMYOmRnDTWiPkyXXtfhPWj+PpOq+5X/1K
 1C/Kxo5usRCGKZjp1R+4AAUp5WCz1fCxSfLezv1Vsjz1CJ8KMCxdHA94y1+jwdhWPrJR
 E7N0I9f52VyALh33q05EQ/VC0re0r1Ed0XKF+l3OoiCxx4HE6PWeQoIZoKiymbeCpRTE
 93C14XRyPo5oNeR6Tff89F1B/Fi8xYP4Fy5mTMUUdqZ++C3+b54KVvkE68scC1/v+m0O
 xDeg==
X-Gm-Message-State: AOJu0YwlwRfqQgkjZ66nUHVa3aED0y/AZlgPgQRzb91T5dZVTQjYKWG3
 tpOM2JEh4MmBJ36pgM+uC6PNESvWk75htaEEKXKK0b3fH20IDEjRMkpHPAAGjF/HE8ntfl6QLse
 PGh2cOTi7+vytp9FI0LM6E8NxlLtb1NsqqUk5mA==
X-Google-Smtp-Source: AGHT+IEyq2e9wZbfwKQEuZUyMFfHh6+EqG6C4gpoXIyJqV19hXqym7s+t9zSU43Vm6tHdb9F8+cW+C7fwYYCyCv7vIU=
X-Received: by 2002:a05:6512:488c:b0:510:51a:5f20 with SMTP id
 eq12-20020a056512488c00b00510051a5f20mr6349lfb.34.1706198961877; Thu, 25 Jan
 2024 08:09:21 -0800 (PST)
MIME-Version: 1.0
References: <20240125155438.47617-1-heinrich.schuchardt@canonical.com>
 <20240125155438.47617-7-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240125155438.47617-7-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 25 Jan 2024 18:08:45 +0200
Message-ID: <CAC_iWj+SMXSa56UgMj6JPUG3xyF4ZGmTgrdqHTZM4oQe4=2nnQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] configs: enable smbios command on
 qemu_arm64_defconfig
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, u-boot@lists.denx.de
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

On Thu, 25 Jan 2024 at 17:55, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We have a Python test the copying of SMBIOS tables from QEMU.
> To make use of the test we need the smbios command.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
>         no change
> ---
>  configs/qemu_arm64_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> index 5100e193be6..631d8866f62 100644
> --- a/configs/qemu_arm64_defconfig
> +++ b/configs/qemu_arm64_defconfig
> @@ -27,6 +27,7 @@ CONFIG_USE_PREBOOT=y
>  # CONFIG_DISPLAY_CPUINFO is not set
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_PCI_INIT_R=y
> +CONFIG_CMD_SMBIOS=y
>  CONFIG_CMD_BOOTZ=y
>  CONFIG_CMD_BOOTEFI_SELFTEST=y
>  CONFIG_CMD_NVEDIT_EFI=y
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
