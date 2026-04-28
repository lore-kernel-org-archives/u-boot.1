Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF727FF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 12:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CC1D84150;
	Tue, 28 Apr 2026 14:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lH0SPjis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3149284255; Tue, 28 Apr 2026 14:04:24 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 194A184119
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 14:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64d5a7926cfso11253063d50.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:04:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777377860; cv=none;
 d=google.com; s=arc-20240605;
 b=hPn/mXSc7BFS+k0K9ap9CzmxOmxq0w9WzpZGHOaBQgplVu/Y/76csDo0VaXOE27ZD5
 X0lHUZBjnQMa9XsArmYjzjNIGTJN4rQacmVUEoJlrepV0C9UdrTEEigLaNvcnTFy0Qhb
 pDpo37GkA9mILTNims4KbpG+OxY6YbDmbcKAUhLwvIrw9WA5F9zzmkq4MoFMOLKhKPT+
 aEPhHcyyfY4s5i6Dp4+jsnye72fb1RBTheK5HbaiJfk2N+6k2153usYNG4nsS76GJLFy
 Fnxz9jPuoNQWdNaRPFXB7eAbAvgHxgfq99qUDvLEU885zrwyplJ2tQt9i38U6xqbc9/Q
 tH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4eOkyteCiWA9CD6pG6xHxiQ+J2Zi8o4F0aMX78eue9U=;
 fh=ImUlq5X5PTm8yLMTWig4dzxPpH7liUFxG2zCFCr2ynk=;
 b=RAUt29fe3klXBsJqxjXdJpF+FXY0BMMKjPsSl1Rr0B5jIht1ZbeuaYtXE6xI6GrSlN
 tMJ41E7Nr6Td4RvBIrzlgmZmC/Gvz67Rd69ES8uHBhqtjPnAdgrDrj+Fa68b7VDGMNDx
 6xLQDlQKdiUI6usJLekoepyJ4U8FSj8JFGdj17Y+3Qv8NQRypqQCmko9ncEtokwLWhDs
 eO6zhvmkz+OyzKNxYa6StaL/hTt0YMxdQckoDhgvp6fGOsfHQwcvkVqxDRVTX1gwfCNh
 ZmXEO0r6ceogZSmL3AE9xVSAHo7MKfMaUCh3TiFWZAshewDKO3sGC88050+EjW/H+SbQ
 N5Lw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777377860; x=1777982660; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4eOkyteCiWA9CD6pG6xHxiQ+J2Zi8o4F0aMX78eue9U=;
 b=lH0SPjisDzRsN1brwfhdR71sDc976rwlqroFKNXzNM6dDPusFlvrdR5Gjb4Rq132Hu
 HkLvvoARtXcBt1lw9glh/mSE0/cLOlZgCc29N94YVBpCPaK3LBZYKH7aoTFX8Vc7vT2b
 hPMbCcUdNjEZed36ZosP+0grjrsZ7uKet4toTzKjmc5XiE9ZQU6Yqm8tM4Nk9dWUiIzz
 zMWnyi/mjDj+Aqw0Cc5fkHFLuYRBh9kJ1q+T5uD1rewAdC6lPkcriUSvNJkNVSK14Tcv
 qRfUXcJPAPzttEazSrrpgtBjDHjxo9wEE1BRDmqjc5XmkKyxu8DIyVwOAOEx9hG15oYX
 2mKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777377860; x=1777982660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4eOkyteCiWA9CD6pG6xHxiQ+J2Zi8o4F0aMX78eue9U=;
 b=lvbTQuIMfdfvPGd+8C6Pxk/glGbC/bLtkenirPcU7tsUldHuiHxo8pXeCObnh3KNE1
 pTYaPOOsxSv8qSj+3QEZ3UJZO8Kvu1azMycp3ckU03cbI/PuOP4G62J34Q2ntGbugRvE
 YD/DrPtc0s7grOPIUpAFDTILQlvONtglDeEKU7+s26djw4Ghlzue9+GVAoHDYXY+8sQv
 Kc6AlE22qF/74Iod1RQfyPQL4rIrOluvnHoz2x/hZ62KD54wgo8iSekP66x+mPk8Ge58
 TsDbFXhoAmqHcgbwnxnFS3oBBGuo/28fof7OZS0HHnVQRz1NH8QKN/DWcCY6SzdXGcKE
 JMKA==
X-Gm-Message-State: AOJu0YwvJ5HdeiUH51zOXqM7WAltUM+539blGED5JPzT2LDJbJG38ce4
 Bg5Xogc4p1bOPG6zVwn9NCN9F5WWf5T/eiMsdULPZAWq2o6uCh9MYDPsaH2I39PZ54d7XbknLdv
 kPRRz/Tz1AMXc4DsAp+2Q0Aupqxzy9AytZA+O1uVSkw==
X-Gm-Gg: AeBDieuDxpdErSdA4sDbCcyQWY2op3mZmMzAUJsoE3zjAXDvrMQ5JS7Mz9IT9rP75NY
 C7LwRhcUhmnryA0XTIJhAZKHOwZ4f6uJUYNHUl1rNT8+TagZHN2cnSAQA+fyaxjISpAlmU8/exF
 uS112yqEzmXJR9yJ1OK3n+SvweDApyHxBdP4eejVbMRuGOy0fUuPfgr3UZ6OPpZSs15yWaG5Hwc
 C1FFXpbY6PPyOpX5ZYBDWRQ/ioqyM5Lcs8VbRIjyaSe/ns+7jnNHh4seQbR4U/twc9gkdSR+ObP
 3STAMyRBV+09fF5eO5S3FXZl09zAvZzC4qZ1Sl2xBZ3Qx13oWwFPO9EUl+fhMxS7PqbwlcDy4gz
 EKj5vvqzAGEWZ90aCK0wimk3RC9yEDC7KD+u6wTn30lJYJ1uUdbsuPPOVRMdLtW08xG3UOu4+z0
 S1K9/vbii795uaSrvOyrLzXC1Jgx2Dr7UZdbFEDGWhwEBoVW717pd+IL9nQniU6y0TUUGF2+9eI
 A8SN0GAL3lpWbUbMpnoQki7VpXn2l1RjKPe90ZgrS0dRby2yuIEB9QWV4JRZCuEHci137JOhgPN
 68aAzmKh/9ivbDJbEa5RfvueTg4v17XIWc2uwRP8ESFX5Ayu/3aC9oN92GiTg/PhY62zESEhsaz
 s9AM1sD9CdSGbqeV/
X-Received: by 2002:a05:690e:13c9:b0:654:5d65:9fe1 with SMTP id
 956f58d0204a3-65beed1d942mr2318562d50.8.1777377859443; Tue, 28 Apr 2026
 05:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-6-harsimransingh.tungal@arm.com>
In-Reply-To: <20260424173151.371134-6-harsimransingh.tungal@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 Apr 2026 15:03:43 +0300
X-Gm-Features: AVHnY4IPQ-lFpffzabT-1T-OE-ivAR9zNMCDrk1cu-vPJnW2YzlB096U78_HImw
Message-ID: <CAC_iWjLeroR7T1dgrULkOjx93-=enGHuwuY7Wn9i-t0oBn+mJg@mail.gmail.com>
Subject: Re: [PATCH 05/12] efi_loader: move runtime GetVariable() helpers to
 efi_variable.c
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
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

Hi Harsiman,

On Fri, 24 Apr 2026 at 20:32, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> Consolidate runtime GetVariable helpers to avoid duplicates
>
> The functions efi_get_variable_runtime() and
> efi_get_next_variable_name_runtime() were implemented in
> efi_variable_tee.c as part of the FF-A runtime variable handling work.
> However, default implementations for these same runtime helpers also
> exist in efi_var_common.c.

efi_variable.c is there to deal with variables stored in the
non-secure world and efi_variable_tee.c for the variables stored on
the non secure world.
You can't compile both. By moving efi_get_next_variable_name_runtime
out of common you will break efi_variable_tee.c for example.

The reason these are in common is that U-Boot exposes the memory
backend to the kernel for get/setvariable. Then the kernel at runtime
decides to ignore the u-boot runtime functions and rewires them to
internal op-tee functions. If you want a variable variant for FF-A
that belongs into efi_variable_tee.c

Thanks
/Ilias


> This results in duplicate symbol definitions.
> To resolve the conflict and centralize the runtime API, this patch moves
> the default implementations of the two runtime GetVariable() helpers
> from efi_var_common.c to efi_variable.c. This ensures that:
>
>  - only a single definition of each runtime helper exists,
>  - backend-specific implementations can override these cleanly,
>  - the EFI runtime variable service table continues to reference the
>    correct functions.
>
> No functional changes are introduced; this is a structural cleanup to
> avoid build-time conflicts and consolidate EFI runtime variable support
> in the appropriate file.
>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> ---
>  lib/efi_loader/efi_var_common.c | 24 ------------------------
>  lib/efi_loader/efi_variable.c   | 24 ++++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
> index d63c2d1b1cd..7cbf098c64a 100644
> --- a/lib/efi_loader/efi_var_common.c
> +++ b/lib/efi_loader/efi_var_common.c
> @@ -173,30 +173,6 @@ efi_status_t EFIAPI efi_query_variable_info(
>         return EFI_EXIT(ret);
>  }
>
> -efi_status_t __efi_runtime EFIAPI
> -efi_get_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
> -                        u32 *attributes, efi_uintn_t *data_size, void *data)
> -{
> -       efi_status_t ret;
> -
> -       ret = efi_get_variable_mem(variable_name, guid, attributes, data_size,
> -                                  data, NULL, EFI_VARIABLE_RUNTIME_ACCESS);
> -
> -       /* Remove EFI_VARIABLE_READ_ONLY flag */
> -       if (attributes)
> -               *attributes &= EFI_VARIABLE_MASK;
> -
> -       return ret;
> -}
> -
> -efi_status_t __efi_runtime EFIAPI
> -efi_get_next_variable_name_runtime(efi_uintn_t *variable_name_size,
> -                                  u16 *variable_name, efi_guid_t *guid)
> -{
> -       return efi_get_next_variable_name_mem(variable_name_size, variable_name,
> -                                             guid, EFI_VARIABLE_RUNTIME_ACCESS);
> -}
> -
>  /**
>   * efi_set_secure_state - modify secure boot state variables
>   * @secure_boot:       value of SecureBoot
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index 9923936c1b5..f2e0e1ad4e2 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -579,6 +579,30 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *vendor,
>         return EFI_SUCCESS;
>  }
>
> +efi_status_t __efi_runtime EFIAPI
> +efi_get_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
> +                        u32 *attributes, efi_uintn_t *data_size, void *data)
> +{
> +       efi_status_t ret;
> +
> +       ret = efi_get_variable_mem(variable_name, guid, attributes, data_size,
> +                                  data, NULL, EFI_VARIABLE_RUNTIME_ACCESS);
> +
> +       /* Remove EFI_VARIABLE_READ_ONLY flag */
> +       if (attributes)
> +               *attributes &= EFI_VARIABLE_MASK;
> +
> +       return ret;
> +}
> +
> +efi_status_t __efi_runtime EFIAPI
> +efi_get_next_variable_name_runtime(efi_uintn_t *variable_name_size,
> +                                  u16 *variable_name, efi_guid_t *guid)
> +{
> +       return efi_get_next_variable_name_mem(variable_name_size, variable_name,
> +                                             guid, EFI_VARIABLE_RUNTIME_ACCESS);
> +}
> +
>  /**
>   * efi_variables_boot_exit_notify() - notify ExitBootServices() is called
>   */
> --
> 2.34.1
>
