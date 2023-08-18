Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0814C001DE
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 06:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D10A286AF3;
	Fri, 18 Aug 2023 08:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y3EkKLHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73D3E86B11; Fri, 18 Aug 2023 08:49:51 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2BE286AEB
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 08:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2b9338e4695so8733061fa.2
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 23:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692341388; x=1692946188;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cGpDLWulV2AnFcgdbWZpYyEh3J2cofFA3VMUwTmrP0M=;
 b=y3EkKLHVSOkkPlhJmFjkJHMzpgc/Nlroex1LVBP+wm3nroe/wJNkBe+eEu6yGvqoTk
 9ol+3ADe+sknavqhIEQOSkK3vLKwTPP1vp4DFeCXgPZQLUsxLhCKxl0G5wRuI+xA+Ga8
 DU40ugR0GYKVItmKyWxegcvF1oz1EQy9eHNf4V6L5ZXwu7/oqqP3d4P7UER0w4e4p+A8
 7Bo84FcqUUW992aUUNATxfQzNq00u8KtwxZ73WknCmMeq5AzdnXttpv+4BTI8vCrBjfc
 91ouKFPtcgYoPbS7i/dMlKyk9HMvyNAdquU3ZzNbL+dQAy30DfYbRxdKZlAKRyTG5BH0
 Vinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692341388; x=1692946188;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cGpDLWulV2AnFcgdbWZpYyEh3J2cofFA3VMUwTmrP0M=;
 b=KOK5ZW7lM/YP7dHrtstMWkIXmK6VWh63nkNINhL0pzoHSDSAg/dlE2/j9He/+Vt2Dr
 +rU4ff865hRgo8ILkK8yLHnJkNjMR65NBiM2VwtGgd0nlfxykxJlLt4P3voQmJX0N6ve
 64d6jljwEX8HIbWOj7ZbpOf0MFoVJqwaeYeIlAI/mpi/PUwsi7+p75nd0kEruUSdptf3
 JWU6laurNeIG4JvKBtU9R/TKyu3kTitNX5oLL2A/13NQI6VLl9CmmVOBkS2FTBAlCwmJ
 bUNc+F3HhIwfVIgHVeCzS/2M8uBAMNGQuxlhkqXq0RHeZAIuGwv8dggFf0VTpOn2gfkC
 OQjA==
X-Gm-Message-State: AOJu0YwU3bgbbV/ipJdiS2ESOL8OYBpG7zmmVrKlUmiPSrcKWkiKx+0p
 F0+0+UbXEAX5CeKcI0K6zRrajpuwg2pNriemVRybEg==
X-Google-Smtp-Source: AGHT+IHQKORkilQNd2bYOmOZj+MWU9t/9HLmfX9hFxJSgb0WY7UOVUm8OGSmUqY3MFed1RAMv9kkgTYeQWGycvLTZ8g=
X-Received: by 2002:a2e:b60e:0:b0:2b9:dd96:5340 with SMTP id
 r14-20020a2eb60e000000b002b9dd965340mr984531ljn.50.1692341387971; Thu, 17 Aug
 2023 23:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230818002706.853550-1-sjg@chromium.org>
 <20230818002706.853550-12-sjg@chromium.org>
 <66F95452-EFB7-4A8B-AE7A-9533CE12C0CA@gmx.de>
In-Reply-To: <66F95452-EFB7-4A8B-AE7A-9533CE12C0CA@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 18 Aug 2023 09:49:11 +0300
Message-ID: <CAC_iWj+-SmhjU5fXDg8U76W93jqxJWTev-yOTOx5K4mYBDW23g@mail.gmail.com>
Subject: Re: [PATCH v2 11/20] efi: x86: Correct the condition for installing
 ACPI tables
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>
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

On Fri, 18 Aug 2023 at 04:40, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 18. August 2023 02:26:50 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >It is not always the case that U-Boot builds the ACPI tables itself. For
> >example, when booting from coreboot, the ACPI tables are built by
> >coreboot.
> >
> >Correct the Makefile condition so that U-Boot can pass on tables built
> >by a previous firmware stage.
> >
> >Tidy up the installation-condition code while we are here.
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >---
> >
> >Changes in v2:
> >- Add new patch
> >
> > lib/efi_loader/Makefile    |  2 +-
> > lib/efi_loader/efi_setup.c | 10 +++++-----
> > 2 files changed, 6 insertions(+), 6 deletions(-)
> >
> >diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> >index 1a8c8d7cab5c..0eb748ff1a59 100644
> >--- a/lib/efi_loader/Makefile
> >+++ b/lib/efi_loader/Makefile
> >@@ -78,7 +78,7 @@ obj-$(CONFIG_EFI_ESRT) += efi_esrt.o
> > obj-$(CONFIG_VIDEO) += efi_gop.o
> > obj-$(CONFIG_BLK) += efi_disk.o
> > obj-$(CONFIG_NETDEVICES) += efi_net.o
> >-obj-$(CONFIG_GENERATE_ACPI_TABLE) += efi_acpi.o
> >+obj-$(CONFIG_ACPI) += efi_acpi.o
> > obj-$(CONFIG_GENERATE_SMBIOS_TABLE) += efi_smbios.o
> > obj-$(CONFIG_EFI_RNG_PROTOCOL) += efi_rng.o
> > obj-$(CONFIG_EFI_TCG2_PROTOCOL) += efi_tcg2.o
> >diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> >index 58d4e1340233..ad719afd6328 100644
> >--- a/lib/efi_loader/efi_setup.c
> >+++ b/lib/efi_loader/efi_setup.c
> >@@ -321,11 +321,11 @@ efi_status_t efi_init_obj_list(void)
> >       if (ret != EFI_SUCCESS)
> >               goto out;
> > #endif
> >-#ifdef CONFIG_GENERATE_ACPI_TABLE
> >-      ret = efi_acpi_register();
> >-      if (ret != EFI_SUCCESS)
> >-              goto out;
> >-#endif
> >+      if (IS_ENABLED(CONFIG_ACPI)) {
> >+              ret = efi_acpi_register();
> >+              if (ret != EFI_SUCCESS)
> >+                      goto out;
> >+      }
> > #ifdef CONFIG_GENERATE_SMBIOS_TABLE
>
> Shouldn't this become CONFIG_SMBIOS?

This is renamed on a later patch

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> It would help my review work if you would stop suppressing half of your patch series when sending mails.
>
> Best regards
>
> Heinrich
>
> >       ret = efi_smbios_register();
> >       if (ret != EFI_SUCCESS)
