Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A06CDB482
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 15:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77FE286F48;
	Wed, 18 Oct 2023 17:24:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J/6ZJ2it";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E7B986FAA; Wed, 18 Oct 2023 17:23:58 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBE4A803AC
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 17:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9c5b313b3ffso362235766b.0
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 08:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697642634; x=1698247434; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KBL8Tf/R1q2KueEwQ+BSHAF/2k1xY3NRIdHsPb0DJXU=;
 b=J/6ZJ2itgVGDoXWqBziGWAF08n92dAcjVA/6lfPNZmJNFOx/WlbWaUHcOe9iafDNzh
 wzC6NVzHgJpHrcAbfMHMR3Bl+ZylqyAL+upj9OQ3gWfeoT+h9TGLOxbo7feTU3mrX+aa
 +BR2dggcbe4x0FdBVcQe5EWHSFAQlzWW+kHVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697642634; x=1698247434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KBL8Tf/R1q2KueEwQ+BSHAF/2k1xY3NRIdHsPb0DJXU=;
 b=bTvoP0ixJeden+fcsdvkXpaj0lTisFFxqU3a6yuYFQlvtS8ioG4A8OjiOcJuyhLPDY
 FrFCsChX73MfIsPK5rH6uppMZsbjGx9asa9IsfyLcdWdE8ytqiNKExLaNaz8N1QvaP43
 oHrZ28cbwgHzQm2KInIIc3RMKtttT5SghBJxslmOASfPHNlYQFBygLot5l8EHzx51h3V
 RXgmvQuZXaSak6bcUu0QEyzf68PFfbXxABkeJQ9GAsZksae3WdZ6TcrQtqJtiJohvQuG
 FRtOcNT/JIGuN/8gkoMC+R2J0WUS4obAi77+COXZK+YKJwQNaGo7cD+6mbdorBIVE18c
 Hl2A==
X-Gm-Message-State: AOJu0Yxt2tM9X1OAW3ihAYaUkibVPodPsJaisUXdNSynpDkG77gerjBS
 qeVx7clOFtxWbb5qEJfybF+6mbWxm5BySGvt25PqR2OU98OUx9Nk8FJ3sg==
X-Google-Smtp-Source: AGHT+IHNXQjzUQVsLDoOPxFIUK+Fuqjv1B+KTgpAqvXU4LiZPi1cH4jS2k03v2yqXeHdem/D46zmA/kBZ8Jdmeib4bw=
X-Received: by 2002:a17:907:3e12:b0:9be:ab38:a361 with SMTP id
 hp18-20020a1709073e1200b009beab38a361mr5417897ejc.8.1697642634254; Wed, 18
 Oct 2023 08:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-23-sjg@chromium.org>
 <20231018133709.GA3765642@bill-the-cat>
In-Reply-To: <20231018133709.GA3765642@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 18 Oct 2023 09:23:42 -0600
Message-ID: <CAPnjgZ2qG7XgcbYyrpZaTef21MJA-B7SMm9jGMzk8G7M=mVv1w@mail.gmail.com>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Wed, 18 Oct 2023 at 07:37, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:
>
> > Since efi_device_path.c calls eth_get_dev() and assumes that Ethernet is
> > available, add it as an explicit dependency.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - Add new patch to update EFI_LOADER to depend on DM_ETH
> >
> >  lib/efi_loader/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index 13cad6342c36..fca4b3eef270 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -11,6 +11,7 @@ config EFI_LOADER
> >       # We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> >       depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
> >       depends on BLK
> > +     depends on DM_ETH
> >       depends on !EFI_APP
> >       default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
> >       select CHARSET
>
> I don't think this is needed.  After reconfiguring qemu_arm64 to be able
> to disable networking entirely, we still are able to build with
> EFI_LOADER enabled, and no warning / link errors.

Fair enough.

As of this patch the following errors are generated with -a ~CMDLINE :

+lib/efi_loader/efi_device_path.c:985:(.text+0xca4): undefined
reference to `eth_get_dev'
+/bin/ld: lib/efi_loader/efi_device_path.c:987:(.text+0xca9):
undefined reference to `eth_get_dev'
+/bin/ld: lib/efi_loader/efi_device_path.c:993:(.text+0xcc9):
undefined reference to `eth_get_dev'
+/bin/ld: lib/efi_loader/efi_device_path.o: in function `efi_dp_from_name':
+lib/efi_loader/efi_device_path.c:1095:(.text+0xe00): undefined
reference to `efi_get_image_parameters'

which is why I added this patch. A later patch disables networking
entirely with ~CMDLINE so that is why this problem goes away.

This series was basically built up by disabling CMDLINE and then
fixing the errors one by one. I didn't go back and check whether (at
the end) all the patches were needed.

I could do that and send a v4, if your more general concerns can be sorted out.

Regards,
Simon
