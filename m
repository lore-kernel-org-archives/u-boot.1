Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C28C71159
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 14:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26E7386E98;
	Fri, 18 Aug 2023 16:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bbBwIXTQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90F4386E97; Fri, 18 Aug 2023 16:55:28 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A279586E9A
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 16:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-525bd0b2b48so1342376a12.0
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692370525; x=1692975325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MwB5AQ2h1dqVInRQSVvG3OphljZOD27E6GfbtEtB6ns=;
 b=bbBwIXTQHEZuKGyEibKpiyfyuPwWsGU2qheixa+gWTv11MPl9VEDuc47yKeC24HWFz
 JZUrhi/HpTYD3p/KBBhS7y+7IKdO1rlEcsji+HMam9VAM8S8WXO71j63k4ZrZ0anAJQp
 mMUwkNV940Goh9FHxdSoYZaTY/c0gqQuhhb68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692370525; x=1692975325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MwB5AQ2h1dqVInRQSVvG3OphljZOD27E6GfbtEtB6ns=;
 b=CGTw6InAOPqOPYIvHbQS5xaR6pWQlwygXtmmiOPUXwM7iitTA7MZNTyzq863lDjb+A
 Hq2GB0+txG2KPLjcLA34tyYBl2kicgA7Q5tVEzh14nKWPYWcp8aqMLMOaOALxwq2hgvT
 hh5dY+q9rPUr4uU23L9yhA8/fdWKzX+Q6qi9mJwWhxXJuzGw4lXVNnnFvQeGmHMW5eAt
 uLUokel2eVtxexWpYIRu0jcY0aq6yWpOGn007Pbhq7weBndSwfq2CmjMDRSLv9cBmVOa
 S1csVqQl4FMHqU3y3CjNYGXevczcHMnBtY7lyv6875Pq/oCMB1SGOXeNoPLER91QjzE/
 eH2g==
X-Gm-Message-State: AOJu0YzngBgpsHxtfkSUP7Kq4bIpyfPuKdXe68w1vRqNBp1AJLBOv96L
 if2mPFXDHWUjYYDsifs3Rb+JP3CIWfQ/V1X+s34lKw==
X-Google-Smtp-Source: AGHT+IEpbdWHgo4wiR+Voz/q75j3CyxiT9+baWcAB7IZHzIPzAT5zNA4XbHlU3LtP8bxen/1HIyqY1AXukMbCBXNxLo=
X-Received: by 2002:a05:6402:328:b0:523:37ff:1170 with SMTP id
 q8-20020a056402032800b0052337ff1170mr2593698edw.16.1692370524958; Fri, 18 Aug
 2023 07:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230818002706.853550-1-sjg@chromium.org>
 <20230818002706.853550-12-sjg@chromium.org>
 <66F95452-EFB7-4A8B-AE7A-9533CE12C0CA@gmx.de>
In-Reply-To: <66F95452-EFB7-4A8B-AE7A-9533CE12C0CA@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Aug 2023 08:55:13 -0600
Message-ID: <CAPnjgZ2wgdzGFLTHzOhqpzBosVt7yjP4hcH7S0FgUvRuKzQGow@mail.gmail.com>
Subject: Re: [PATCH v2 11/20] efi: x86: Correct the condition for installing
 ACPI tables
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Heinrich,

On Thu, 17 Aug 2023 at 19:35, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
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
>
> It would help my review work if you would stop suppressing half of your patch series when sending mails.

Do you mean you only receive some of the emails? If so, the whole
series was emailed to you. I checked my 'sent' box and see you in each
one.

If you mean something else, please let me know.

Regards,
Simon
