Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79259C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 06:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D56A98813A;
	Mon, 22 Jul 2024 08:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UCg+cCue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F4768800C; Mon, 22 Jul 2024 08:48:13 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53A81881E7
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 08:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2cb5787b4a5so1964593a91.2
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 23:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721630890; x=1722235690; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1w0X3xcn5xHbrYtqA/klguqEjJF21L5b+xEcQ1oc79c=;
 b=UCg+cCuenGjf1NsRUs6EZby858G+vn0AyUhyB/jA/AxoUGuT/jFeHlRy5V4fVrajV9
 swbVafO1HyA0OH5DhryfF82da+IniYcJmF4+WQ8S4i5SGa5fVVpbzfhIG85sIHL4BKJU
 EiwAvJUCol49iKYzwOBeLg3f7aKShFn+ms5sxZKkMTMrUZjNnerdSFhcXjkOXJVIMY2t
 vmQc6aqsqcbl4bmqpIZRdQKU2res5TGbaBi1OjM+JDw9KFXF6FXrN09QqJGXwupTuE7Y
 9Gok17+xW//dx2WO/+rliV76GZd4AJGVuXGyK9Jx+sN6RdMibD7KbCV2Lzhk0uC1NTh7
 ynVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721630890; x=1722235690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1w0X3xcn5xHbrYtqA/klguqEjJF21L5b+xEcQ1oc79c=;
 b=DCi86uEtSXU/VfYhZs9E5xgsa++asxOz+pEeAkVMo5WN1zK8pPEjm3/MZ9MQHIuqDa
 WZMzcGfmKF0oKLePD4qGt7Hg73FyKJHF8BI843UlE6R4jaYwvk5Bxmf/E3hfUvhoTS8w
 iFHQW0SavUZOV/ZJD/gvbKsKuvU7cfJESDgdMeLRwSaWMeCVcspNYvNGT4c/6NtsnsAj
 85YX+9pY+ZKia0Ad8s8LDfpba+jz+shFWy3rPEECQq2GMn8MdW+o9ydpJReaYVmbbdmN
 ef7O9bROWAhbpZQQm4TN5bILg3hQ9HDqim5CrY5gAELHombK1WWHLpqXVRpe5c92WwxA
 SSdw==
X-Gm-Message-State: AOJu0YwVPX6LQZRVZ3RGImiK9nLcpIwvDlvMujmya0ZbZumC+xAE0zG3
 H3rLzohu0+ghSpNMm0hpv1ocBUcppiwfD+IO2nFEOqJgv0jLM2ocT/uEaDNGbJDhGECC02zftfh
 ndS6ziMlVYj0/1TE14L6x9k0ObJHtZPKagebiig==
X-Google-Smtp-Source: AGHT+IFi85kaXNjUnCxNEtYXnm3n0nesWaSOo9UMRWcHP4jGXlgoZybkaCxJR5c/EO+91laiUx07YKpzgiwiyi7aoRY=
X-Received: by 2002:a17:90b:1e01:b0:2c9:6632:a12b with SMTP id
 98e67ed59e1d1-2cd274adf2emr2400357a91.36.1721630889580; Sun, 21 Jul 2024
 23:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240718120509.105758-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240718120509.105758-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Jul 2024 09:47:33 +0300
Message-ID: <CAC_iWj+X1+BefqdEjdJfkCYyZAD8REnb0WhaPCm2Zx5G1W8YTg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: require EFI boot manager for EBBR
 compliance
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Thu, 18 Jul 2024 at 15:05, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> A system has to support booting via the boot manager to be EBBR compliant.
> See the reference to variables Boot#### in the specification.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 2fb24d7af9a..3b703fea007 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -486,6 +486,7 @@ config EFI_ECPT
>
>  config EFI_EBBR_2_1_CONFORMANCE
>         bool "Add the EBBRv2.1 conformance entry to the ECPT table"
> +       depends on BOOTMETH_EFI_BOOTMGR
>         depends on EFI_ECPT
>         depends on EFI_LOADER_HII
>         depends on EFI_RISCV_BOOT_PROTOCOL || !RISCV
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
