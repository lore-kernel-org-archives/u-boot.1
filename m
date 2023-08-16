Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BD5C001E0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 13:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7D548677D;
	Wed, 16 Aug 2023 15:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GeDaO9Oe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89774867F6; Wed, 16 Aug 2023 15:14:53 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D683F8638B
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 15:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fe27849e6aso10190082e87.1
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692191690; x=1692796490;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GXAOUUIBcPGUuP7df2HvpBp5RZJaLeU+N8u7d2yABNk=;
 b=GeDaO9OeckgowfY4KU5YXBEQuP07Madd2KWksKlo6UEBkkWegG9xuOqkyybC/LjE4g
 m6ThmNNVH0jr9T7VrBB+KeQ9gK5fOEtrdBRHbBdCxeIebMiztDbcRKJeGSMDCl8muDcX
 fyD/Equc96+PPeWkHfYLgRFWg3ktzP1WyxJKZgWX9+2yeRVuHGJAerz7EpzOPthZucgK
 UN6+6H8Zn/b3/JM68KVStx1Fk3vFaJmBmmLBrf2rY8bTvc2QS3gcO+PpPr0nAjPQmIgw
 KSsDaY/akxZYxvQb0ZgoRhEREWUmkozXFRQJ/AMz+VNfSTVdJKopdF/26mjRkgJuNiGt
 F2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692191690; x=1692796490;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GXAOUUIBcPGUuP7df2HvpBp5RZJaLeU+N8u7d2yABNk=;
 b=ZRSevAlFnqtoOEz9kIPb5Rj93rix1EPGmMHaituPsdRWQP2uyXhnoUeDcGOqHxxqWr
 385T+DUL6vfwVW8j5fLXbBYszrKwIkpPqPzpSH4c9QAbpN1/Vi+FYDzR+hzOHh1JUMLn
 R+3p4Hh9EyFCHWffI/ONBw/aFXvqDb1npCbXX6n5msqDQhXSHGGhosd41bIsY+GnbunM
 F/im+9pxtvbGEmHPtl+8/liUs3vy+PBpKWDRURHNQritqwTCD49ohX6WBLlM7Fds23FZ
 S51isJoXbg/TZlRAAe6FtbII8plfQjfxxW9Ew2FVNsHddeICQ+dg3sHbK24ZuVxbgBoc
 3EJw==
X-Gm-Message-State: AOJu0YzWusOHrhxaRRxq/Vf70BdliiWsq8XHpY3gEzFjskpvQhEOO2l3
 vOmzkXAgkRWyBKR7M7jC8HYp6lth9nKKvpTHxIlsA1HJpyGwTokXt7/chA==
X-Google-Smtp-Source: AGHT+IF5WWbAPOVx+wFf2MkjF0ZnHTfQAoaS9BQiQRqJqg7pgpWNQzX7F5fpz55/8GkhDmWDFPljkpw4sTyedYcAOqE=
X-Received: by 2002:a05:6512:15a2:b0:4fd:c83b:a093 with SMTP id
 bp34-20020a05651215a200b004fdc83ba093mr2127731lfb.1.1692191688993; Wed, 16
 Aug 2023 06:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230812002823.82576-1-seanedmond@linux.microsoft.com>
 <20230812002823.82576-2-seanedmond@linux.microsoft.com>
In-Reply-To: <20230812002823.82576-2-seanedmond@linux.microsoft.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 16 Aug 2023 16:14:12 +0300
Message-ID: <CAC_iWj+YsrbYY1TNTmqX-rvsjgQi2t-dYHK9W--WqFv=SfbaFQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] drivers: security: Add security devices to driver
 model
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, stcarlso@linux.microsoft.com, 
 abdellatif.elkhlifi@arm.com
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

Hi Sean

On Sat, 12 Aug 2023 at 03:28, <seanedmond@linux.microsoft.com> wrote:
>
> From: Stephen Carlson <stcarlso@linux.microsoft.com>
>
> Security devices currently implement operations to store an OS
> anti-rollback monotonic counter. Existing devices such as the Trusted
> Platform Module (TPM) already support this operation, but this uclass
> provides abstraction for current and future devices that may support
> different features.
>
> - New Driver Model uclass UCLASS_SECURITY.
> - New config CONFIG_DM_SECURITY to enable security device support.
> - New driver sandbox_security matching "security,sandbox", enabled with
>   new config CONFIG_SECURITY_SANDBOX.
>

[...]

>
>  source "drivers/scsi/Kconfig"
>
> +source "drivers/security/Kconfig"
> +
>  source "drivers/serial/Kconfig"
>
>  source "drivers/smem/Kconfig"
> diff --git a/drivers/Makefile b/drivers/Makefile
> index efc2a4afb2..b670aae5fd 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -98,6 +98,7 @@ obj-$(CONFIG_PCH) += pch/
>  obj-$(CONFIG_DM_REBOOT_MODE) += reboot-mode/
>  obj-y += rtc/
>  obj-y += scsi/
> +obj-y += security/
>  obj-y += sound/
>  obj-y += spmi/
>  obj-y += watchdog/
> diff --git a/drivers/security/Kconfig b/drivers/security/Kconfig
> new file mode 100644
> index 0000000000..f7af5c4e78
> --- /dev/null
> +++ b/drivers/security/Kconfig
> @@ -0,0 +1,25 @@
> +config DM_SECURITY
> +       bool "Support security devices with driver model"
> +       depends on DM
> +       help
> +         This option enables support for the security uclass which supports
> +         devices intended to provide additional security features during
> +         boot. These devices might encapsulate existing features of TPM
> +         or TEE devices, but can also be dedicated security processors
> +         implemented in specific hardware.
> +
> +config SECURITY_SANDBOX
> +       bool "Enable sandbox security driver"
> +       depends on DM_SECURITY
> +       help
> +         This driver supports a simulated security device that uses volatile
> +         memory to store secure data and begins uninitialized. This
> +         implementation allows OS images with security requirements to be
> +         loaded in the sandbox environment.
> +
> +config SECURITY_TPM
> +       bool "Enable TPM security driver"
> +       depends on TPM && TPM_V2 && DM_SECURITY
> +       help
> +         This driver supports a security device based on existing TPM
> +         functionality.


I think this is generally a good idea.  But we need to define a bit
better what we consider 'security' and what is supported by this
uclass.  One example would be a TPM RNG device.  We already support
that and we even use it as an RNG in certain cases.  Is this something
that we should move here?  Because atm the new class seems to only
support a rollback counter (which is fine, we might just have to pick
a different name)

[...]

Thanks
/Ilias
