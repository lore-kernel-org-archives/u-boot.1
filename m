Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF26ECD6E5D
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 11:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CE13848BC;
	Fri,  5 Jun 2026 13:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JFBHgbLI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89FD784879; Fri,  5 Jun 2026 13:04:57 +0200 (CEST)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60A8D848DC
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 13:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65eb226b1ceso1761025d50.0
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 04:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780657492; cv=none;
 d=google.com; s=arc-20240605;
 b=H9yH3j8wwoxk9X+5jTVw9ZAvyurloNfFWY2mDbqsUhqcd+KbOe5tq3GldpBNbl0fbq
 /YoBeNBLdWnEd4ArmMyheEdceEVso7mMKqtHx7LX32r+//NDJ+Q1rJ6ED3EWdrgqmBCT
 e4QVwaqZ90eZYgodxya0hsPJ95jXTzSQVv/bZTQzNT0pMY3+lGiS78NxdapN8uoBrmNZ
 bAN9yDQ0ZQfugkolvm3hHqyYlKYz3xavzsrK3mSbxRLYqPRYbqSvVgGgTglmUnfVCibU
 MbLjueqkcPT/0oK9tjpI2XFkSO2iMHTOuPB01J/f4bM2Ct7fB2kEQ/2c8nhpsbN0wFq7
 ILFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DWoaYAM/mNmv9ZN3jMXWnmHxeffBHb9BwMHT8dnk8S0=;
 fh=4q5C7hKOtTOGKSQ7kUBmqlGmZOdIMJKEMMNq7T/PWfc=;
 b=BX7Rhuz15hqTlos291lzV+7gxk9qlN2GCECojQ3PlKD+Q/nOMetCCVmivGpYVfN12g
 RKLWlp49skh9OZs2qR/wYaBZBzcDL95WRFIhb/j4T//F2XnSG/nF5mCTh0XT1t4FzFtq
 JVh//ZyleRRZbn9/Cv836TGm1ge0YvimLm+CckPsrL2aO/V4CmV+myouYI7QT+shvUtS
 I+jlAFyHOw/acZnksM6suAfbUS7Rq26k5nQxyP+ZsN6H2SvFzTELshn3MM0Gzm3OTcPi
 r4BF1Ord5hmiZTVwTu8Z2IcraMX9Cfekr3WfU1x9xDu2sK7wAaLc3Shgo4y8sXgwjQWL
 9Dhw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780657492; x=1781262292; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DWoaYAM/mNmv9ZN3jMXWnmHxeffBHb9BwMHT8dnk8S0=;
 b=JFBHgbLI+7xt6Xg8RKG+V0EugXmJZHZMjmsT5jlHB9k0vACtIlUHcwNPE/+XXdXMNF
 FHPa/ucsg/Fa/NDHmDJbk/PfkEgbpfj1T0HhfdgZRQzFfsijsHJevXdyAOMBad7YLey0
 BZ9OR16iS8yANHCiha8CIuD/fuoIcVXRNeY05uB6zIBEl9FtTAsunmobcNuqf5U1eOY3
 b3eU2ImoXKg2/QKTM1I7rgUVZX8JY0hxThqNAaPFhz48cRPl01uDLsIdSn1dzdPGOWK8
 o+URSXAXVlrCiRO7MRHwI5UjOyovb0B61UefAiJE5lvdnqcFY5QraPj7/9BIcStoyuJq
 k/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780657492; x=1781262292;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWoaYAM/mNmv9ZN3jMXWnmHxeffBHb9BwMHT8dnk8S0=;
 b=pXPuniOHnFsC0C4T7hUbwtn8BvDxFy+WFIqsYGYop5RL5EpjLoFZEiuchLFR/9cDyF
 ggcA1Ru/9WnBz8w2/M1tTBkreP0IYtno4Fsd/5riEdBq0vAyOdQAMdo0gQ/u3Lhvuj0c
 Bt8QkqnSNgXUIUr705nPH96qgV0sq54tk9b0hm1+t2rhDNuEUfIxBHZR8gRK2WY+/+c0
 P8sdMrMlsGUGo+bFbVX+x+YwLA9R/S7TCssQge/ksmhp/AFS0LHQSUTPPSar5wNstuCe
 LDQc7WKLMinKt1ZUfxTELGSNEluRbThgR/UIh7DZ/e+24FfNC3ozpHbKuA3uHeRCQS1K
 cmJQ==
X-Gm-Message-State: AOJu0YzPvD6DFiyT3BVyX/iJediuR3ofIom+g8WxB2jebjGgChBPyBCS
 uzxn0UfDSgXMnZ0svVYbKllm5oOLvkX1ywnj9n9TWZ/QmqENM2jZYeVMbziQ4dbXDtHQNj4lAc4
 elD/HV1mCDQy0FOlOePHUGCMQzXhObD7Anb9X6LB7FQ==
X-Gm-Gg: Acq92OF9N/GO14oslIwsMeq81CBlMvc55re5k6/mvxEfVSLLXPfRU5tzuzutDItntkg
 r5nxM7aYuooKp1+rJghtCkSGurOet8sSsLr8scZAh+20w/ZHnxB1A2oSY5igjq6AX8+STFQQ9MF
 LUtQNIUfJNRPokGLXmtZ+bmTf6RMES0XIw8JVafJag09Qc9Svl7P6LZBBrU0zkoNUa26CB7eWZg
 ysz++++gu64ehAM6Aq1WxBbEMdM8M9TleGRpXJFy28hSvolz7pGc8uqkPzlkAfIONvf6IJdOhre
 A7Myykl4LYn9UHrVjMMl9I+n52vaXltNXwXXQSV38ktSKqr0h/qLCBnT15Difpa8zmKyvDGOsg8
 9Bmf9WL02/llwXTrcwtNCHBKgr+H4msTExTFiNnBhuovf6iHUV7ToQPtswm+qdEWb5dhSrCI4lT
 IsaqrkSdmu/BHDM56FqJ6bWJdtr66TgPSVWxfeSOgJbbKq3dMk8v13eoLETgiZIXIR+bT0N6yXQ
 Zb7RNSM5mOrdWs0l7Q/4ZRDpJJmR0/Dupqu/e9hGtA9yA9OtjsxtGcGQSug50MDUn3BO+k/5yxD
 SN729b2NgULyuHFvjxPv2esqo9hJwilnV/E8MkdGc7J+x/s864BOJGYdRfWZa9uO4sS86vArOtg
 lCUr3Nyqyimc14vTn
X-Received: by 2002:a05:690e:12c2:b0:65e:5110:a60d with SMTP id
 956f58d0204a3-66106f87bd8mr2561107d50.50.1780657492014; Fri, 05 Jun 2026
 04:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-7-harsimransingh.tungal@arm.com>
In-Reply-To: <20260514124924.1804332-7-harsimransingh.tungal@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 5 Jun 2026 14:04:16 +0300
X-Gm-Features: AVHnY4I2-yN_vEM-kVggkQrjLu6E6Oi9YqjJeFhgwihh5hibKDWSa3WUuY0nH68
Message-ID: <CAC_iWjLBc2sCTeO-voXRaJu34vft+cq4s2qbF=cpqNvNYxZc_w@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] efi_loader: move runtime variable read helpers
 to efi_variable.c
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, abdellatif.elkhlifi@arm.com, trini@konsulko.com, 
 xypron.glpk@gmx.de, hugues.kambampiana@arm.com, sjg@chromium.org
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

Hi Harsiman

On Thu, 14 May 2026 at 15:50, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> Relocate the generic runtime variable read helpers from
> efi_var_common.c to efi_variable.c.
>
> efi_var_common.c is always built, while efi_variable.c is only built
> when CONFIG_EFI_MM_COMM_TEE is unset. Earlier patches in this series
> add TEE/FF-A-specific runtime read helpers in efi_variable_tee.c.
> Leaving the generic definitions in efi_var_common.c would therefore
> cause a symbol clash in EFI_MM_COMM_TEE builds.
>
> Move efi_get_variable_runtime() and
> efi_get_next_variable_name_runtime() into efi_variable.c so the
> non-TEE backend keeps the generic memory-backed implementations,
> while the TEE/FF-A backend continues to provide its own runtime read
> helpers in efi_variable_tee.c.
>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> ---
>
> Changelog:
> ===============
>
> v2:
>
> Ilias, Simon:
>
> - Reword commit message to include relocation of generic non-TEE
>   helpers and broaden the wording to cover both runtime read helpers
>
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

I think I mentioned this on the previous version as well.
The reason that we represent variables in memory at runtime, is that
it works for both secure and non secure world storage. In the secure
world case, Linux scans that OP-TEE can support variables at runtime
and swtiches get/setVariable to point in op-tee functions.
Due to the above we were less strict wth the API, since evenryone just
called the _mem variant for runtime calls and it saved us a function
call.

 If we want to change this, the right fix would be to define _int
variants in the efi_variable.c and efi_variable_tee.c and call them
from efi_var_common.c. This basically boils down to calling the _int
version in efi_get_variable_runtime and efi_get_next_variable_runtime
on the common code.

Thanks
/Ilias


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
