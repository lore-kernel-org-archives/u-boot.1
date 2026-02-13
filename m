Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB788EF48E8
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 08:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B50983CBD;
	Fri, 13 Feb 2026 09:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CxQJmCKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F28983CEE; Fri, 13 Feb 2026 09:45:31 +0100 (CET)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36F8D83015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64937edbc9eso601690d50.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 00:45:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770972323; cv=none;
 d=google.com; s=arc-20240605;
 b=b2yd5GvTakRL2jdi3VdkdYLvJU/GPsYi66BTp9hvNzDmmWKKBbyOjYsrlo1kIerxqa
 JuV/eML09moZAykwR6kqs2JiX/x+zbbqKTuobOlBSINADboDuBOuT+ebAxk/7RR9l29M
 qvCKIlBoshQdzWpd2z19v+jWzRLnDl8ihOxpBTEzNg5CkHDUwIGTukOm7YqXXHewoTC+
 vr7eAdvGVMNwx0T7Dogm2scRH8x97zh1fDnR4n05bmVrGU7ghLgGbpfWde8KRc5DuWyf
 fa0436WrGuwELtNtSN+n1bX8rS+klDB2DIZMhulFLicHPqvUjlUKjXsbPxrKr2E5LVyA
 k4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GUlfm6qGspxXOa0QnPo0hWqCA6Nd1HDpE60B2lTSPcs=;
 fh=UFoti2DNaCecsXJ+QLc3OQuuxe1GVYbcBL2cOS1A6SU=;
 b=BrW4rQXEdgzmkOw2OkoYlNP4uqxIWFrc6TkEkpgTzv+0ADrjS4RwOz1S31nlPCYHh8
 JuD9enDIeFurZ8EluF/5Y2A/bBCCdJIE7yLm7gKKCgjmX1xNjWr0hQmMwzTpoSiPcV/+
 +Oc2dT/Sb1qrWzKqQjpAVVDDfSJhWHMXIlqRcz0Hc3oJnJzjWY7sfvNBXV1qEpBk3i0J
 o52Ap7/c6LXCl1IL2Sa6tHDAS4YYFeyLStnAGMzcLmCVcgmX9H0yGwbxEHDb2I/1ioja
 FW6/3yENFp7/Cf2kDujddcYW55jlvLaZOizuS06FmQmzIThja/ehdS7U1NTticTa2cPI
 VLXQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770972323; x=1771577123; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GUlfm6qGspxXOa0QnPo0hWqCA6Nd1HDpE60B2lTSPcs=;
 b=CxQJmCKd754rnN3TL3x0H5wS2qSGCxcxYdqoeBGMlmnHDcBozXGnwG68z00WoryBje
 CO6/0qZ3grrHu7lYrnqbB4lvIl7Kevd70EyATSmKWWAjVI2CSrkofpj/K5TABI5Pe43N
 r9r7N+cKKA2LTLK64E7nqxVSEWfaWhSAImoIHpNji9fwlKMksbvSxf0XUX+7NUcVmKeQ
 nWQ2clIIl+3iqzS6hTwM79p6dTHPQW7LNy2Lnh0VqxoXldkZvpuWo8BtMaA0tw4zaqDw
 9kUM+uz2B5qEyTLZ3VhOoV8sWn32yRhyvlczT1jeo5g8nzNjbmrnfeTudmXkyvZS2C/O
 mr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770972323; x=1771577123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GUlfm6qGspxXOa0QnPo0hWqCA6Nd1HDpE60B2lTSPcs=;
 b=tfk2lqGCDCF5NpfwzAmTUbpcASkdjqIh/Ku/iYEp9cUuP7NJB8uDhcfj/XEUF5K1sv
 p4qgzk6RK03tgTjmd8tPjdGk08He8l5/m/z3DVR4YAf4GowFvNkKo3qU9cuSP+UvrHTO
 w/vTe8G0b/KNFJ9+L067zAybHs8owvjfu3wTZZvpADulFAnlsWUYtc5HaRHxMXWcs9k7
 KHlKnw2LHpDYT46lll7FCGd54qK3bWsYndQHjZ1GT2gXcf7lw5b+S+ZRiisz/TPy8vYO
 4M/9IzmSl9POGfD2fKYeEkLAHIaOUQSzpOTL/INaF+bYiwDblDA/nbkgWg+FxYmRKIcR
 tuZQ==
X-Gm-Message-State: AOJu0YwG7bqn+/dYdW3oKiOTCY3J7MPGNb3DQirSkD8pdPyWZsD85NNX
 OYm2twfzawWQB8P1HaS/LLiMG9Wj+eYZy5xCzc2a7cC+5cp04VKh3nZ2A1IdMrNdMf3K1Vh2e/6
 21mZHxtXbq3GKwy0lEL9Jar4gs9Qrq4yGhpS2iJW5cg==
X-Gm-Gg: AZuq6aLrr5X/pBMeyS84xcsH4FVhJHhXs+TDaFNPPNIjNTwJHGW4yck8xQVs6IBS/Pb
 QFEl90W9Hs6Qo/eyl/Ldnv0OnPxMx2o0Yya2ixLBsSCEv5wD6b+c8K1B8NwSXV5z+6KWF+mOQwS
 34eqioYRUK5xAbyu78LbXyOR64Ymr3BQdnXWol34NXXYWYhM+ingybnSA39zH9Hn6jcjZAkC0hr
 wqEygP3hJUb9CTVPcpMPrfG9klXjcTDtbpC+P8m03+0UC36I1EXEG9kXnTViBJRt7+NC3JTN6Pc
 MQfRIfDDzLXqjoLDAoD/5415wa5DlHiK6PQtMFZ4i4Gt4xuXmwsviqM3fHA1mzd8qMN+11J1mAG
 /e0sDwThcjZiaPdUrMkUHsJ04P95c5Vht5TC/RPSeY843AaIhgUx7V29tffLvFswTIMsWBxtFca
 axraodptw1oYcXXrWABENl5Djl7KS5vLNNzzUBMkXJhu/AOvN3xdnNp8BkqA5ljpYRaof5NBD4S
 vRDbmqL9ETRJHwF1ZyY3Rc9jKr64IR5HptWkXZJAqldnqm4ZcmsINvUs3aFoBYfYJzwSq30vBp9
 DV42oIBXodhKemVt195ez+HaDRc1vZoEVqbEpHoZz/oy3m+FeZwDATA=
X-Received: by 2002:a53:cc43:0:b0:649:45a0:a29a with SMTP id
 956f58d0204a3-64c19b5d271mr463360d50.75.1770972322889; Fri, 13 Feb 2026
 00:45:22 -0800 (PST)
MIME-Version: 1.0
References: <20260212204511.619392-1-javierm@redhat.com>
 <20260212204511.619392-7-javierm@redhat.com>
In-Reply-To: <20260212204511.619392-7-javierm@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Feb 2026 10:44:47 +0200
X-Gm-Features: AZwV_QhxzMRwMBiGRdDpsjsBP5D5Hp-olZM873gtRciX9uugS13lasVMVre7pJA
Message-ID: <CAC_iWj+kAtEg0OKoUAV6BfmFe8w6r31HDVboONV00oZP_n4owg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] efi_loader: disk: Extend
 EFI_PARTITION_INFO_PROTOCOL to support MBR
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 eballetb@redhat.com, 
 Tom Rini <trini@konsulko.com>, Maks Mishin <maks.mishinfz@gmail.com>, 
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

On Thu, 12 Feb 2026 at 22:45, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> The EFI_PARTITION_INFO_PROTOCOL provides detailed information about
> partitions. The UEFI specification mentions that both GPT and MBR
> partition schemes are supported, but the U-Boot implementation only
> supports the former.
>
> This can cause compatibility issues for platforms whose boot ROM only
> supports MBR. This change adds support for MBR partition tables to
> the protocol, making U-Boot compatible with systems that require a
> legacy MBR table.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> (no changes since v1)
>
>  lib/efi_loader/efi_disk.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index 130c4db9606f..f8a57539ec61 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -475,9 +475,12 @@ static efi_status_t efi_disk_add_dev(
>  #if CONFIG_IS_ENABLED(DOS_PARTITION)
>                 case PART_TYPE_DOS:
>                         info->type = PARTITION_TYPE_MBR;
> -
> -                       /* TODO: implement support for MBR partition types */
> -                       log_debug("EFI_PARTITION_INFO_PROTOCOL doesn't support MBR\n");
> +                       ret = part_get_mbr(desc, part, &info->info.mbr);
> +                       if (ret) {
> +                               log_debug("get MBR for part %d failed %ld\n",
> +                                         part, ret);
> +                               goto error;
> +                       }
>                         break;
>  #endif
>                 default:
> --
> 2.53.0
>
