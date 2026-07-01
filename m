Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6E6C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 13:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D805884B92;
	Wed,  1 Jul 2026 15:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cUopCj3G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55EAF84BBF; Wed,  1 Jul 2026 15:50:13 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C8C984B53
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 15:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-664ae993e4bso554707d50.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 06:50:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782913809; cv=none;
 d=google.com; s=arc-20260327;
 b=IgNBu2FEmN32OcQ4SDPwiVLRdVBD7bjTCvZvVtHeMNUO9ulTVI2B8ATRZDTG+K55g4
 DMwsWD6EWX8B9StVsTwxAIWzZbXthojjHHJd7b134wg/DfnR8miX25WWKCgFciqWIEfA
 638DrJnjz0U7JgNmKA2CGoojMLVaL9MQ7zxApRhG5z438oVhxwj0o1RYon0i0WkULeYI
 Fab4wTirUT+Z1BOhYv1hA9T50PuTh4qbD5q1TSUu7KqJpBQSDT0wAd/AxZPnDB854jpY
 qVslNCaRv2pX6ciBXDLvX8CLbm68MADtOH3n+4Gtz8nqzXNXoqY0P1j5ruQa8d7k9UuU
 djNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6cuViU/pxrIRVEqUhrVtugPMJoGNuxQrUenwwUwznP0=;
 fh=ImUlq5X5PTm8yLMTWig4dzxPpH7liUFxG2zCFCr2ynk=;
 b=dcFvwdX/v1QNU7MXVqpS78yFySwG5kkKzcAk84fz2QSuNsbxMAK0hTbFldwSuqlWPR
 soViNgBu+ePM8lZA6ebhW8HojUf5a/CUDNu0hr7+wzUGHyE58bz2nw8pVZi3D8O6WbVT
 rA0IFQXFHwWyoKrZSfoZmNwV1dATRwGxc5R7ZfEIbnTtrs3hLrKePreGjOzSkxSTjPRW
 Xym3yRCCLG0bbVxRYpqSllOwgMQgLyRXisHB1b4ULttB3/Hc2nUqsOol1NF5LkNgsMHn
 C0JgLqRj7VsAbaevuWWJHMGvmA468zlHuf9xh2VuCRWgTcCJZjSEJPdeZCmSEV8CdqSm
 8ogA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782913809; x=1783518609; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6cuViU/pxrIRVEqUhrVtugPMJoGNuxQrUenwwUwznP0=;
 b=cUopCj3G850YrotgCDjbCaGg63EstwVp3XAdyp4oi8y1BytfWKqK4KCX0YSq8I6aKQ
 DAVM2SG0wm/bAhfuweJyWlxaCVBkFB48fYFZDIwJg64mA4n0QAVlyYOqFeI8uPf7iekD
 Kn9RLAVLewgjQFqYBzHSjmzWq+WYTombIiGUICO67OWcfzeBI1ESp/jxNiUj2GNpSpNI
 jlp9O3rXeD+JkgQRQtsn5xr9PFUfyFObiuF8hR+TmhjuwrlA23g1rq+kQmVCii3O3InL
 qgVs3Cu/qF3PwP059rCKc9ylHkfAUuSXjSQbhPI8t9+kVSpFHtyAg41OyRTS9h2v8WbV
 Y2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782913809; x=1783518609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6cuViU/pxrIRVEqUhrVtugPMJoGNuxQrUenwwUwznP0=;
 b=DiM1YhBOdmhb5Ou1t9nbjjlJ+Y24J4/gzf30hENuFXh4JBzMIHR2cm50+F9y/34xfx
 /f0/azssRl08sSaTrMdA63HtS8BQkAzZlYwymEODcboiPYIdQpz0PRm5D4pJQVS8Ipfp
 NuFd0bdwYy6cWrY8rdY65IVlSDPpscxicxhS0utGqHyYqP8yfJncnp6oT615LhWsz3fb
 8ZGSD1X9qM4DkkKwSgYhiBIZxac68PHiYx7OEei1fR1JzoSBZsfGXEjQAdaQL2ckko66
 7FcBcbfAAZYBJqpzjS7msi9cnHNMhoN8cIwXrbH1VjLTaauPLGRBXajEseE4i2SWV4pX
 ugNg==
X-Gm-Message-State: AOJu0Yw8lybzXC2RZ5AzekPAknAopNZk2Id0TpZqX+2Q5E4giC8BgfxY
 mPcEi5jS+QDiUvLiPiRYCFicO8VaXiXg7EsHH6ipg2+Qle+6qylyLpdZZOEjeuNxMGetf/w/RtY
 f9Z9HyExJ2bRJKfDyH81u24/TGRQlGw0HMc9nishSng==
X-Gm-Gg: AfdE7cl/ngzPUJggCBKs5gJVJkoWPCO/SBpzeVWN+8pWtO8XSsfJU3tCi1t3xrxJx0v
 6aiGDIH5RtXaD/lYNva+Q97u3REAf4jspMEDk5lpMSkv0Pwy7Q1SqF/phOydvR4/Mot1FGkMAIA
 0g1k3Pxw84nKr6ngyOibr4KjzGT8kQO/Mdtx9VJSEc5cv3rA9TKrvidI87IRN65GnCvT749NZ1b
 JXIp05y8FYnxLQQSxqaVX66rHRidt8HuDG77eBjzTMvIwV04opAWdpGsKpK4j7QGh9Pd1sFy/Eq
 5E7WUTLC7IKogZSfJPzoVyyrUa1xAkAT9Ya71L5oxTV5FGHVRKgTmmtaIw2ZENSLpOArbPmZBgn
 LOm4k3efCRLeFYc95byXBZW0eGes3mXURPDBPTY95KBasvGGCuioRLGooJURDnQY0bc3ClUFHuU
 Qs4vnoy8lF0Tq+bEaGCGzpETZcviPJxsUALx8Sw7AmdQwumnr69vWM9XeZpAFPXoHhv3TUUMGD2
 BYOVHSniLIkVVNgBQoa3sJV2eTJMKJyObN7XBtLH5B3K5aj3mJieIvuN+eY7xA8hdB378BBhWJT
 7Faugsl4fLZ60dsQmnxAQjU80epCZ4umu2HGaoJXEt45uTp6S9/2deevUEqrMSaK4l3lPus=
X-Received: by 2002:a05:690e:d0b:b0:664:a4e6:3dde with SMTP id
 956f58d0204a3-66507991df2mr5567922d50.9.1782913808771; Wed, 01 Jul 2026
 06:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
 <20260627144421.2067410-5-harsimransingh.tungal@arm.com>
In-Reply-To: <20260627144421.2067410-5-harsimransingh.tungal@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Jul 2026 16:49:31 +0300
X-Gm-Features: AVVi8CdRaJd1GedO1OfndIM-rTginzlfQk-nfnrQXfq6JUD5WGCaKbHqsPdfD4Y
Message-ID: <CAC_iWjLSnOmY2xUuGmzGZH5kipd_SZYssQKZMPZsq+UtZ67QRg@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] efi_loader: enable EFI runtime
 SetVariable()/GetVariable() using FF-A transport
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

Hi Harsimran,

Thanks for fixingthe callbacks. The logic is correct now but please
split these into 4 different patches on the next revision, one for
each runtime call that changes.

Thanks
/Ilias


On Sat, 27 Jun 2026 at 17:44, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> Route EFI runtime variable APIs through FF-A MM communication
>
> Route EFI runtime variable services through the FF-A/MM backend in
> lib/efi_loader/efi_variable_tee.c. After ExitBootServices(),
> GetVariable(), SetVariable(), GetNextVariableName(), and
> QueryVariableInfo() use the runtime entry points and continue to reach
> the MM secure partition.
>
> Keep the existing boot-time helpers unchanged and add runtime service
> wrappers for variable access and property handling. Reuse the
> runtime-safe setup_mm_hdr() and common mm_communicate() path, which
> selects the FF-A transport appropriate for the current phase, and use
> the EFI runtime-safe memory helpers in the runtime-only code.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> ---
>  lib/efi_loader/efi_variable_tee.c | 344 ++++++++++++++++++++++++++++--
>  1 file changed, 326 insertions(+), 18 deletions(-)
>
> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> index fe205bdf966..474dd186a3e 100644
> --- a/lib/efi_loader/efi_variable_tee.c
> +++ b/lib/efi_loader/efi_variable_tee.c
> @@ -716,6 +716,38 @@ out:
>         return ret;
>  }
>
> +static efi_status_t __efi_runtime set_property_int_runtime(const u16 *variable_name,
> +                                                          efi_uintn_t name_size,
> +                                                          const efi_guid_t *vendor,
> +                                                          struct var_check_property *var_property)
> +{
> +       struct smm_variable_var_check_property *smm_property;
> +       efi_uintn_t payload_size;
> +       u8 *comm_buf = NULL;
> +       efi_status_t ret;
> +
> +       payload_size = sizeof(*smm_property) + name_size;
> +       if (payload_size > max_payload_size) {
> +               ret = EFI_INVALID_PARAMETER;
> +               return ret;
> +       }
> +       comm_buf = setup_mm_hdr((void **)&smm_property, payload_size,
> +                               SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_SET,
> +                               &ret);
> +       if (!comm_buf)
> +               return ret;
> +
> +       efi_memcpy_runtime(&smm_property->guid, vendor, sizeof(*vendor));
> +       smm_property->name_size = name_size;
> +       efi_memcpy_runtime(&smm_property->property, var_property,
> +                          sizeof(smm_property->property));
> +       efi_memcpy_runtime(smm_property->name, variable_name, name_size);
> +
> +       ret = mm_communicate(comm_buf, payload_size);
> +
> +       return ret;
> +}
> +
>  static efi_status_t get_property_int(const u16 *variable_name,
>                                      efi_uintn_t name_size,
>                                      const efi_guid_t *vendor,
> @@ -761,6 +793,49 @@ out:
>         return ret;
>  }
>
> +static efi_status_t __efi_runtime get_property_int_runtime(const u16 *variable_name,
> +                                                          efi_uintn_t name_size,
> +                                                          const efi_guid_t *vendor,
> +                                                          struct var_check_property *var_property)
> +{
> +       struct smm_variable_var_check_property *smm_property;
> +       efi_uintn_t payload_size;
> +       u8 *comm_buf = NULL;
> +       efi_status_t ret;
> +
> +       efi_memset_runtime(var_property, 0, sizeof(*var_property));
> +       payload_size = sizeof(*smm_property) + name_size;
> +       if (payload_size > max_payload_size) {
> +               ret = EFI_INVALID_PARAMETER;
> +               return ret;
> +       }
> +       comm_buf = setup_mm_hdr((void **)&smm_property, payload_size,
> +                               SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET,
> +                               &ret);
> +       if (!comm_buf)
> +               return ret;
> +
> +       efi_memcpy_runtime(&smm_property->guid, vendor, sizeof(smm_property->guid));
> +       smm_property->name_size = name_size;
> +       efi_memcpy_runtime(smm_property->name, variable_name, name_size);
> +
> +       ret = mm_communicate(comm_buf, payload_size);
> +       /*
> +        * Currently only R/O property is supported in StMM.
> +        * Variables that are not set to R/O will not set the property in StMM
> +        * and the call will return EFI_NOT_FOUND. We are setting the
> +        * properties to 0x0 so checking against that is enough for the
> +        * EFI_NOT_FOUND case.
> +        */
> +       if (ret == EFI_NOT_FOUND)
> +               return EFI_SUCCESS;
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +       efi_memcpy_runtime(var_property, &smm_property->property, sizeof(*var_property));
> +
> +       return EFI_SUCCESS;
> +}
> +
>  efi_status_t efi_get_variable_int(const u16 *variable_name,
>                                   const efi_guid_t *vendor,
>                                   u32 *attributes, efi_uintn_t *data_size,
> @@ -848,6 +923,93 @@ out:
>         return ret;
>  }
>
> +efi_status_t __efi_runtime EFIAPI
> +efi_get_variable_int_runtime(u16 *variable_name, const efi_guid_t *vendor,
> +                            u32 *attributes, efi_uintn_t *data_size, void *data)
> +{
> +       struct var_check_property var_property;
> +       struct smm_variable_access *var_acc;
> +       efi_uintn_t payload_size;
> +       efi_uintn_t name_size;
> +       efi_uintn_t tmp_dsize;
> +       u8 *comm_buf = NULL;
> +       efi_status_t ret, tmp;
> +       u32 var_attr = 0;
> +
> +       if (!variable_name || !vendor || !data_size) {
> +               ret = EFI_INVALID_PARAMETER;
> +               return ret;
> +       }
> +
> +       /* Check payload size */
> +       name_size = u16_strsize(variable_name);
> +       if (name_size > max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE) {
> +               ret = EFI_INVALID_PARAMETER;
> +               return ret;
> +       }
> +
> +       /* Trim output buffer size */
> +       tmp_dsize = *data_size;
> +       if (name_size + tmp_dsize >
> +                       max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE) {
> +               tmp_dsize = max_payload_size -
> +                               MM_VARIABLE_ACCESS_HEADER_SIZE -
> +                               name_size;
> +       }
> +
> +       /* Get communication buffer and initialize header */
> +       payload_size = MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + tmp_dsize;
> +       comm_buf = setup_mm_hdr((void **)&var_acc, payload_size,
> +                               SMM_VARIABLE_FUNCTION_GET_VARIABLE, &ret);
> +       if (!comm_buf)
> +               return ret;
> +
> +       /* Fill in contents */
> +       efi_memcpy_runtime(&var_acc->guid, vendor, sizeof(var_acc->guid));
> +       var_acc->data_size = tmp_dsize;
> +       var_acc->name_size = name_size;
> +       var_acc->attr = attributes ? *attributes : 0;
> +       efi_memcpy_runtime(var_acc->name, variable_name, name_size);
> +
> +       /* Communicate */
> +       ret = mm_communicate(comm_buf, payload_size);
> +       if (ret != EFI_SUCCESS && ret != EFI_BUFFER_TOO_SMALL)
> +               return ret;
> +
> +       /* Update with reported data size for trimmed case */
> +       *data_size = var_acc->data_size;
> +       if (attributes)
> +               var_attr = var_acc->attr;
> +
> +       /* Copy the data if ret is EFI_SUCCESS  */
> +       if (ret == EFI_SUCCESS) {
> +               if (data)
> +                       efi_memcpy_runtime(data, (u8 *)var_acc->name + var_acc->name_size,
> +                                          var_acc->data_size);
> +               else
> +                       ret = EFI_INVALID_PARAMETER;
> +       }
> +
> +       /*
> +        * UEFI > 2.7 needs the attributes set even if the buffer is
> +        * smaller
> +        */
> +       if (attributes) {
> +               tmp = get_property_int_runtime(variable_name, name_size, vendor,
> +                                              &var_property);
> +               if (tmp != EFI_SUCCESS) {
> +                       ret = tmp;
> +                       return ret;
> +               }
> +               *attributes = var_attr;
> +               if (var_property.property &
> +                   VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY)
> +                       *attributes |= EFI_VARIABLE_READ_ONLY;
> +       }
> +
> +       return ret;
> +}
> +
>  efi_status_t efi_get_next_variable_name_int(efi_uintn_t *variable_name_size,
>                                             u16 *variable_name,
>                                             efi_guid_t *guid)
> @@ -912,6 +1074,68 @@ out:
>         return ret;
>  }
>
> +efi_status_t __efi_runtime EFIAPI
> +efi_get_next_variable_name_int_runtime(efi_uintn_t *variable_name_size,
> +                                      u16 *variable_name, efi_guid_t *guid)
> +{
> +       struct smm_variable_getnext *var_getnext;
> +       efi_uintn_t payload_size;
> +       efi_uintn_t out_name_size;
> +       efi_uintn_t in_name_size;
> +       u8 *comm_buf = NULL;
> +       efi_status_t ret;
> +
> +       if (!variable_name_size || !variable_name || !guid) {
> +               ret = EFI_INVALID_PARAMETER;
> +               return ret;
> +       }
> +
> +       out_name_size = *variable_name_size;
> +       in_name_size = u16_strsize(variable_name);
> +
> +       if (out_name_size < in_name_size) {
> +               ret = EFI_INVALID_PARAMETER;
> +               return ret;
> +       }
> +
> +       if (in_name_size > max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE) {
> +               ret = EFI_INVALID_PARAMETER;
> +               return ret;
> +       }
> +
> +       /* Trim output buffer size */
> +       if (out_name_size > max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE)
> +               out_name_size = max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE;
> +
> +       payload_size = MM_VARIABLE_GET_NEXT_HEADER_SIZE + out_name_size;
> +       comm_buf = setup_mm_hdr((void **)&var_getnext, payload_size,
> +                               SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME,
> +                               &ret);
> +       if (!comm_buf)
> +               return ret;
> +
> +       /* Fill in contents */
> +       efi_memcpy_runtime(&var_getnext->guid, guid, sizeof(*guid));
> +       var_getnext->name_size = out_name_size;
> +       efi_memcpy_runtime(var_getnext->name, variable_name, in_name_size);
> +       efi_memset_runtime((u8 *)var_getnext->name + in_name_size, 0x0,
> +                          out_name_size - in_name_size);
> +
> +       /* Communicate */
> +       ret = mm_communicate(comm_buf, payload_size);
> +       if (ret == EFI_SUCCESS || ret == EFI_BUFFER_TOO_SMALL) {
> +               /* Update with reported data size for trimmed case */
> +               *variable_name_size = var_getnext->name_size;
> +       }
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +
> +       efi_memcpy_runtime(guid, &var_getnext->guid, sizeof(*guid));
> +       efi_memcpy_runtime(variable_name, var_getnext->name, var_getnext->name_size);
> +
> +       return ret;
> +}
> +
>  efi_status_t efi_set_variable_int(const u16 *variable_name,
>                                   const efi_guid_t *vendor, u32 attributes,
>                                   efi_uintn_t data_size, const void *data,
> @@ -994,7 +1218,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>                 var_property.property |= VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY;
>                 var_property.attributes = attributes;
>                 var_property.minsize = 1;
> -               var_property.maxsize = var_acc->data_size;
> +               var_property.maxsize = data_size;
>                 ret = set_property_int(variable_name, name_size, vendor, &var_property);
>         }
>
> @@ -1045,7 +1269,7 @@ out:
>  }
>
>  /**
> - * efi_query_variable_info() - get information about EFI variables
> + * efi_query_variable_info_int_runtime() - get information about EFI variables
>   *
>   * This function implements the QueryVariableInfo() runtime service.
>   *
> @@ -1054,24 +1278,50 @@ out:
>   *
>   * @attributes:                                bitmask to select variables to be
>   *                                     queried
> - * @maximum_variable_storage_size:     maximum size of storage area for the
> + * @max_variable_storage_size:         maximum size of storage area for the
>   *                                     selected variable types
> - * @remaining_variable_storage_size:   remaining size of storage are for the
> + * @remain_variable_storage_size:      remaining size of storage are for the
>   *                                     selected variable types
> - * @maximum_variable_size:             maximum size of a variable of the
> + * @max_variable_size:                 maximum size of a variable of the
>   *                                     selected type
>   * Return:                             status code
>   */
>  efi_status_t EFIAPI __efi_runtime
> -efi_query_variable_info_runtime(u32 attributes, u64 *max_variable_storage_size,
> -                               u64 *remain_variable_storage_size,
> -                               u64 *max_variable_size)
> +efi_query_variable_info_int_runtime(u32 attributes, u64 *max_variable_storage_size,
> +                                   u64 *remain_variable_storage_size,
> +                                   u64 *max_variable_size)
>  {
> -       return EFI_UNSUPPORTED;
> +       struct smm_variable_query_info *mm_query_info;
> +       efi_uintn_t payload_size;
> +       efi_status_t ret;
> +       u8 *comm_buf;
> +
> +       if (!max_variable_storage_size ||
> +           !remain_variable_storage_size ||
> +           !max_variable_size || !attributes)
> +               return EFI_INVALID_PARAMETER;
> +
> +       payload_size = sizeof(*mm_query_info);
> +       comm_buf = setup_mm_hdr((void **)&mm_query_info, payload_size,
> +                               SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
> +                               &ret);
> +       if (!comm_buf)
> +               return ret;
> +
> +       mm_query_info->attr = attributes;
> +       ret = mm_communicate(comm_buf, payload_size);
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +       *max_variable_storage_size = mm_query_info->max_variable_storage;
> +       *remain_variable_storage_size =
> +                       mm_query_info->remaining_variable_storage;
> +       *max_variable_size = mm_query_info->max_variable_size;
> +
> +       return ret;
>  }
>
>  /**
> - * efi_set_variable_runtime() - runtime implementation of SetVariable()
> + * efi_set_variable_int_runtime() - runtime implementation of SetVariable()
>   *
>   * @variable_name:     name of the variable
>   * @guid:              vendor GUID
> @@ -1081,11 +1331,69 @@ efi_query_variable_info_runtime(u32 attributes, u64 *max_variable_storage_size,
>   * Return:             status code
>   */
>  static efi_status_t __efi_runtime EFIAPI
> -efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
> -                        u32 attributes, efi_uintn_t data_size,
> -                        const void *data)
> +efi_set_variable_int_runtime(u16 *variable_name, const efi_guid_t *guid,
> +                            u32 attributes, efi_uintn_t data_size,
> +                            const void *data)
>  {
> -       return EFI_UNSUPPORTED;
> +       efi_status_t ret, mm_communicate_ret = EFI_SUCCESS;
> +       struct var_check_property var_property;
> +       struct smm_variable_access *var_acc;
> +       efi_uintn_t payload_size;
> +       efi_uintn_t name_size;
> +       u8 *comm_buf = NULL;
> +       bool ro;
> +
> +       if (!variable_name || variable_name[0] == 0 || !guid)
> +               return EFI_INVALID_PARAMETER;
> +
> +       if (data_size > 0 && !data)
> +               return EFI_INVALID_PARAMETER;
> +
> +       /* Check payload size */
> +       name_size = u16_strsize(variable_name);
> +       payload_size = MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + data_size;
> +       if (payload_size > max_payload_size)
> +               return EFI_INVALID_PARAMETER;
> +
> +       ro = !!(attributes & EFI_VARIABLE_READ_ONLY);
> +       attributes &= EFI_VARIABLE_MASK;
> +
> +       ret = get_property_int_runtime(variable_name, name_size, guid,
> +                                      &var_property);
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +
> +       if (var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY)
> +               return EFI_WRITE_PROTECTED;
> +
> +       comm_buf = setup_mm_hdr((void **)&var_acc, payload_size,
> +                               SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
> +       if (!comm_buf)
> +               return ret;
> +
> +       /* Fill in contents */
> +       efi_memcpy_runtime(&var_acc->guid, guid, sizeof(*guid));
> +       var_acc->data_size = data_size;
> +       var_acc->name_size = name_size;
> +       var_acc->attr = attributes;
> +       efi_memcpy_runtime(var_acc->name, variable_name, name_size);
> +       efi_memcpy_runtime((u8 *)var_acc->name + name_size, data, data_size);
> +
> +       /* Communicate */
> +       ret = mm_communicate(comm_buf, payload_size);
> +       if (ret != EFI_SUCCESS)
> +               mm_communicate_ret = ret;
> +
> +       if (ro && !(var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY)) {
> +               var_property.revision = VAR_CHECK_VARIABLE_PROPERTY_REVISION;
> +               var_property.property |= VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY;
> +               var_property.attributes = attributes;
> +               var_property.minsize = 1;
> +               var_property.maxsize = data_size;
> +               ret = set_property_int_runtime(variable_name, name_size, guid, &var_property);
> +       }
> +
> +       return (mm_communicate_ret == EFI_SUCCESS) ? ret : mm_communicate_ret;
>  }
>
>  /**
> @@ -1118,11 +1426,11 @@ void efi_variables_boot_exit_notify(void)
>
>         /* Update runtime service table */
>         efi_runtime_services.query_variable_info =
> -                       efi_query_variable_info_runtime;
> -       efi_runtime_services.get_variable = efi_get_variable_runtime;
> +                       efi_query_variable_info_int_runtime;
> +       efi_runtime_services.get_variable = efi_get_variable_int_runtime;
>         efi_runtime_services.get_next_variable_name =
> -                       efi_get_next_variable_name_runtime;
> -       efi_runtime_services.set_variable = efi_set_variable_runtime;
> +                       efi_get_next_variable_name_int_runtime;
> +       efi_runtime_services.set_variable = efi_set_variable_int_runtime;
>         efi_update_table_header_crc32(&efi_runtime_services.hdr);
>
>         /* Record that ExitBootServices() has been called */
> --
> 2.34.1
>
