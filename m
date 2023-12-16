Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B29BC46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84AEA87C53;
	Sat, 16 Dec 2023 19:48:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dXEY/7iS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D91B87C7D; Sat, 16 Dec 2023 19:48:38 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9428C87C42
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5e490137a9aso12380157b3.2
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752514; x=1703357314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FApuY/R6qJLpiFX3QwDlOkuGKCvnVIG1Ob29bQuwSqw=;
 b=dXEY/7iS9kJLVOKl6YDjldWcRpwjXOmJ47x+lrd7IA1eSCGS0+P4MTtQw699ugH0xS
 aVS85k9jAFiuJqhJnz2drtaRAJKSBY2e/AYOoybJ7JOEZMQYoOUZY8YAffbqF0TeGjeC
 7fWZyuGlaHqyt2uAWAXvQpT3ol8cO/CPGpuOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752514; x=1703357314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FApuY/R6qJLpiFX3QwDlOkuGKCvnVIG1Ob29bQuwSqw=;
 b=NBlVducw56THWHZk2Nhwr82/VHjTpUhSyEyNTnyo3qK2e6lA9TnuRMjuzLntDfw3KC
 kZZ894ncrD4/pc6ayR//PamJmJCnHoAh7tHozMiFnWO9u0hfxGttp0r+FP3mZbD5F9Oa
 fBDNQHAatS2iPjsbLlfeMF4qFvc9iPWPY4mK+L+0sXwUrb4jf8f7GWomrzZIbQXXdnkK
 Q4qhT/LWTMSo1uRLqQJ3HVFC1oPktjNlRMkg2bfICObUWimaP+rxupD6hRWaWla75VMd
 C+ax+cZ265zTOa0T1CN2M7GIGFzHkTptCwqFfFH1xZgeJz6ia2JCRetU2RRGDRwjCYBL
 OQLA==
X-Gm-Message-State: AOJu0YzkJbsh44ugba2+KJyuJnXTtaZnqO1FUnOXkWokXgCriak3upKc
 RMT9EocUsM7mrwveMHImug9RsFgIFoHUb977n+75Bk6eh9tTyxMhBJ8=
X-Google-Smtp-Source: AGHT+IEbO73f4fdHFm8NQE+JQg7bKu2o0lsT6y2wXbaifOCHDDqhFp/i92PEGLMf90rujmO7XeGDkBBVIr+bJYbvFCE=
X-Received: by 2002:a81:6042:0:b0:5d8:e5e8:b775 with SMTP id
 u63-20020a816042000000b005d8e5e8b775mr10654266ywb.15.1702752514129; Sat, 16
 Dec 2023 10:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20231214181658.3359902-1-trini@konsulko.com>
 <20231214181658.3359902-13-trini@konsulko.com>
In-Reply-To: <20231214181658.3359902-13-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:45:42 -0700
Message-ID: <CAPnjgZ09_hwBEY++smgiYio8jfN7p0E-QL5EaeL__Wz5cnwFQA@mail.gmail.com>
Subject: Re: [v2 13/16] efi_loader: Remove <common.h>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Thu, 14 Dec 2023 at 11:19, Tom Rini <trini@konsulko.com> wrote:
>
> We largely do not need <common.h> in these files, so drop it. The only
> exception here is that efi_freestanding.c needs <linux/types.h> and had
> been getting that via <common.h>.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  lib/efi_loader/dtbdump.c                   | 1 -
>  lib/efi_loader/efi_acpi.c                  | 1 -
>  lib/efi_loader/efi_bootmgr.c               | 1 -
>  lib/efi_loader/efi_boottime.c              | 1 -
>  lib/efi_loader/efi_capsule.c               | 1 -
>  lib/efi_loader/efi_conformance.c           | 1 -
>  lib/efi_loader/efi_console.c               | 1 -
>  lib/efi_loader/efi_device_path.c           | 1 -
>  lib/efi_loader/efi_device_path_to_text.c   | 1 -
>  lib/efi_loader/efi_device_path_utilities.c | 1 -
>  lib/efi_loader/efi_disk.c                  | 1 -
>  lib/efi_loader/efi_dt_fixup.c              | 1 -
>  lib/efi_loader/efi_esrt.c                  | 1 -
>  lib/efi_loader/efi_file.c                  | 1 -
>  lib/efi_loader/efi_firmware.c              | 1 -
>  lib/efi_loader/efi_freestanding.c          | 2 +-
>  lib/efi_loader/efi_gop.c                   | 1 -
>  lib/efi_loader/efi_helper.c                | 1 -
>  lib/efi_loader/efi_hii.c                   | 1 -
>  lib/efi_loader/efi_hii_config.c            | 1 -
>  lib/efi_loader/efi_image_loader.c          | 1 -
>  lib/efi_loader/efi_load_initrd.c           | 1 -
>  lib/efi_loader/efi_load_options.c          | 1 -
>  lib/efi_loader/efi_memory.c                | 1 -
>  lib/efi_loader/efi_net.c                   | 1 -
>  lib/efi_loader/efi_riscv.c                 | 1 -
>  lib/efi_loader/efi_rng.c                   | 1 -
>  lib/efi_loader/efi_root_node.c             | 1 -
>  lib/efi_loader/efi_runtime.c               | 1 -
>  lib/efi_loader/efi_setup.c                 | 1 -
>  lib/efi_loader/efi_signature.c             | 1 -
>  lib/efi_loader/efi_smbios.c                | 1 -
>  lib/efi_loader/efi_string.c                | 1 -
>  lib/efi_loader/efi_tcg2.c                  | 1 -
>  lib/efi_loader/efi_unicode_collation.c     | 1 -
>  lib/efi_loader/efi_var_common.c            | 1 -
>  lib/efi_loader/efi_var_file.c              | 1 -
>  lib/efi_loader/efi_var_mem.c               | 1 -
>  lib/efi_loader/efi_variable.c              | 1 -
>  lib/efi_loader/efi_variable_tee.c          | 1 -
>  lib/efi_loader/efi_watchdog.c              | 1 -
>  lib/efi_loader/initrddump.c                | 1 -
>  42 files changed, 1 insertion(+), 42 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
