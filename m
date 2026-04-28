Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B5FFF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:01:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16CCD8465E;
	Tue, 28 Apr 2026 20:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yt2Bany7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F4F684662; Tue, 28 Apr 2026 20:01:23 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4126B84659
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso868355666b.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777399280; cv=none;
 d=google.com; s=arc-20240605;
 b=TDjle7I+ybcarrq3e/NXeL6x/1IZJhvTu/DXkDXTbKLaHGtvCf78FZHn1IQxx1fdIH
 2EWxYX7BHoK8ELqh3csWOy48Zq4UZjHUg1EXfdqDhtrDyBzyF+6I9bExIZvHrdX1O0PN
 EalYQybmN7BQNRQyEVXdNDYGjOKYp4BjOTX/4k6FvrdFrYws2u4bcQC0+RAT2bZrprer
 moEyzjJNScg58lacUa7/Yk+vDcqlWEVMdmH/+gxJpNP+lnEZVkk4DfT6xI8kxFmcbFo2
 2WVuG7LzBqQ6kGUKjWLl15aqce0PiIecB533oqHi0RJQgbFvDMj9S4NzoX8HQVEXt2Hi
 5DoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IWRgGHbGzpfozRR84Xutj3ss8ue5QUrm9uvqT7xnBZI=;
 fh=GYIekQEhESPWanXHuipF/cx0w9AeOdHDaa7vPtUoRvA=;
 b=Lf/TCeua/Y3pX6XySiFto6pFASqCKxpV/FmmLVEkpwmRTDajEc5uS/loNOPDIuaZch
 ox024En3V2SsvUJNACYrNcwfQ9MTvO10dZVbl3SyTc60BLSTPJCEgTtkzF458BP05Nxc
 ic8EtX15p4SxDc3B9vD35Gmi9FCeVN8kQbqcN3NmjgY/UJ4TzKzTcXsxki5MBI3FuOzL
 3Dr5JYwJ2BBgJPTRIZdRmTlpODB0vBVR4EtafZMjw2Qca3RWnu7qMc1LleSAUi09C14f
 GenVeMaWfb4phHroSACuWZnh7laP6FlK4m+4KoOBwg0hBMNva94FuOGq54pW6xvrK3e0
 w8RQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777399280; x=1778004080; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IWRgGHbGzpfozRR84Xutj3ss8ue5QUrm9uvqT7xnBZI=;
 b=Yt2Bany7AUPLzKFXY9pKUTMb08qD/JeB13rWfRzzYSH1t7CCdMUVeqWWwiM0R/W9r7
 NhlHhGkBBihCTZ1b9HO+8wWSW2sEXNfe8UQxraY5Xac8SRdafbZNfSTEMgMQAh6TCSnx
 unR05+qQX0T3bq3Nkx9W6jzBIiWUNoebnNdjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777399280; x=1778004080;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWRgGHbGzpfozRR84Xutj3ss8ue5QUrm9uvqT7xnBZI=;
 b=f7QhXLDd4UnrzX2k7JsxaEeRaM38wiXwMJJ/XySy1RSuG0perCTMmaBXUEZBrXCwrE
 n2HMRfaMDmdWXALzO2NbJCHhLPOyLfsRtJ6ylOw1IbZN9g8GC1PrdYIF9Kki/DVb4XVz
 ZCQ0QQg4SCZiR1MjSGPlx0eCn09dpvmhtYewt7a1AmIjFHrYlYX7Yo6Wcnau/dtTKXzj
 buSFj7KXzJmiqDSVMJDdbxfzi0RhcEj0AixJpFe85+u67+1pu7SxgeCZZHowiiCiyj2g
 UDQXytedkz08z/Og1cGQf0nOWBcS+yuyEVY9pQZzK2wn+YTPp2i3YXKuR79egpakvLfU
 s1ew==
X-Gm-Message-State: AOJu0YxN00q06ynlbNiKdODuc6iITFJ2Bl/zo7v8hj8/R8B/JKYfoY0I
 X4GvXYqjrot7GVJ8q58n4JjjcVFYwljZQwW3U9CRpm28Zp+4ssGIB/lXwvwgU10o71AarRx9DM9
 E7g72t30iaB5QnKx3XAdDhx+sUJFpWS2+edF5nzp3
X-Gm-Gg: AeBDietI8kbP1upMBIQp706yzJP4PKzyoH2yY5o0bR5zcOgmr5J6S15yDQKMN0xFbZN
 EaX64DRo4Hr5B1nTvYK8BfvHO4TEnxSUvzuN0DlDpgho1j5QEypLddfwZ1ftPQzGYz6NCn1jfzv
 G46BfyGTDWEltcWsdy9vzwfwOEB8Egtdw/iCbJmP3F43RiAaiDRLVQv3DgPGVILfiWuPjG+tINl
 k1xhY2WFSAZ5fQQpXURw0RqQkSIIrzSdQv+yv9d8hPJSkjFThDG4vOSO0RnEB9NLqkQMTV5JObN
 oiWxGMoqDL6/eSvo
X-Received: by 2002:a17:907:cb81:b0:ba7:b198:7d35 with SMTP id
 a640c23a62f3a-bb8023b8a56mr289097366b.19.1777399279540; Tue, 28 Apr 2026
 11:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-7-harsimransingh.tungal@arm.com>
In-Reply-To: <20260424173151.371134-7-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 12:01:05 -0600
X-Gm-Features: AVHnY4L4CJ2cOJhJmfz10noxHc5zjx86jkhtFkG9BsFEvk45i0OC0hISzq0BqS0
Message-ID: <CAFLszThtGo1n_fpMF4S8EYvUGPpaUu4mDwbjt8P5RF++pBo4UQ@mail.gmail.com>
Subject: Re: [PATCH 06/12] corstone1000: enable bootefi selftest
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>, 
 Simon Glass <sjg@chromium.org>
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

Hi Harsimran,

On 2026-04-24T17:31:50, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
> corstone1000: enable bootefi selftest
>
> Enable UEFI selftest command in Corstone-1000 defconfig
>
> Turn on CONFIG_CMD_BOOTEFI_SELFTEST in the Corstone-1000 defconfig
> so the board can run the built-in UEFI self-test suite during
> development and validation.
>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> configs/corstone1000_defconfig | 3 +++
>  1 file changed, 3 insertions(+)

> diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
> @@ -63,6 +65,7 @@ CONFIG_SYSRESET=y
>  CONFIG_SYSRESET_PSCI=y
>  CONFIG_TEE=y
>  CONFIG_OPTEE=y
> +# CONFIG_CMD_POWEROFF is not set
>  CONFIG_USB=y

Why is this disabled? It's not mentioned in the commit message and
looks unrelated to enabling the bootefi selftest. If it's a stray
byproduct of 'make savedefconfig' please drop it; if intentional it
should be a separate patch with its own justification.

> diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
> @@ -32,6 +32,8 @@ CONFIG_SYS_PROMPT="corstone1000# "
>  # CONFIG_CMD_CONSOLE is not set
>  CONFIG_CMD_FWU_METADATA=y
>  CONFIG_CMD_BOOTZ=y
> +# CONFIG_CMD_BOOTEFI_HELLO is not set
> +CONFIG_CMD_BOOTEFI_SELFTEST=y

The commit message says only that selftest is being enabled, but
you're also explicitly disabling CMD_BOOTEFI_HELLO (which would
otherwise default to y once SELFTEST is set). Please mention this, and
ideally state the real motivation - that this is needed so patch 7 of
the series can run the runtime variable selftest on this board, right?

> Enable UEFI selftest command in Corstone-1000 defconfig

>
> Turn on CONFIG_CMD_BOOTEFI_SELFTEST in the Corstone-1000 defconfig
> so the board can run the built-in UEFI self-test suite during
> development and validation.

The first paragraph just restates the subject. Please drop it and keep
the second paragraph, which actually explains the change. Referencing
the runtime-variable selftest added later in the series would also
help, since that is the real reason for enabling it now.

Regards,
Simon
