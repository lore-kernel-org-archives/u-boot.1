Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24892CD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 06:24:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 699F0845C8;
	Wed, 13 May 2026 08:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ul1AilZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 641C384674; Wed, 13 May 2026 08:24:54 +0200 (CEST)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75715838BB
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 08:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-651bf695701so6946788d50.2
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 23:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778653488; cv=none;
 d=google.com; s=arc-20240605;
 b=FeukrOINTZjcWysBcQ04gq4n4rTN8zlSV0yNsI51MYchYUOneax4izHzB7Yfc8Ij63
 1AvDSiX8Mk3wjqwa3l95DXA8Kn9vWh1B91xcs8OXfdVsXaEnUqselERe5v2X6vT8Zabk
 JNpt3264yW5WdPcPlh8HFQtH3mg+k7Qjy7IC/NtpSMT+2RP3QwmUcYTEQDqhpZVLRAwr
 e7GN8NCweqyD+xg1cAntpMGjfiqLrcnQTvNB8uDk1bmcube8IO3MbDjWJg3bGUH59ver
 mOch9Ivlusoogl8pkZtNL266NEadlPd64umuPECbCSw6PLdCZwNGnzbIxnEZKCGXtLnj
 vlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=H1+iruKUikKjV9fzHKspGkcVSdQIURaazocYW83GqTI=;
 fh=hCa6m4Of+hIKLn5iMraX0T8Pb93s1LVYBWe0TimrM1E=;
 b=E/EP4qv29+LvJ+gvI9hJv+NqoRv7p6FxA0c9mPA39yEZXtyseIkoz8WqBEAN6lhLKb
 Bxo6+WSEUTL4BI6zdEhuG8+KsUOHMKpImL41Jk6BAlO8pIXYkurpPm15wFaq6cR5vn/J
 ZFfFl//11VCoS5aWpa/yXgzAs07Oujr6CLRvvqsvnDl7W4Equ2YVr67dZuIYON3dbMWa
 dlwmwhBvBabHPP9r517vsU7e6NOAPSNAJeLJMHYbpLBFncqJKj3MNgcEjaMVILdomCm7
 DYphQrDDK0eMFMw2jv0prv6XqPsyPMmgqHIyLmjH/LS+qO2U+r6tjNO9FobUXNeK3Oe0
 IGiQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778653488; x=1779258288; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H1+iruKUikKjV9fzHKspGkcVSdQIURaazocYW83GqTI=;
 b=ul1AilZWTC8dWGtQc4ID3Wt9M3IURN45lJR7cs5mHEu7J2/xgv7ZPxUA1//6qYhXRr
 T64/IvrqvKoEx7DHDv1RlXgFVsYmcAGhkxsXlaIpEAAOqeiCxTCabx6SAO5kwMgWdTea
 H4BkheJk2LYOh1Qms6XOwEpHm21oJwLeExdK5TspmdRPrxdiDN3X9nPHyYRyh+Nx5WXk
 rRuY2zqs8MKOwsD4SyyOCqdtPTpUSa4399Qt758NVYgir1f8yr4f6GcycQvLqhI+/Kau
 wVAiSPT6GAVDDyt+DnjSho9fSZ+ezgLF5Qs9c9kg5u7N0Y2sZBzcH5FoQ1zraCg0X3tf
 ZgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778653488; x=1779258288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H1+iruKUikKjV9fzHKspGkcVSdQIURaazocYW83GqTI=;
 b=EaYcyC8NYH1dg1EZUamJ1X9XU12xcJoSPstjNnz23Tvx85pcMkos+usIlo8XmXT4ad
 XOCzpKCUtPS7u+R8HMJxP+avtilpd/57EMkxkZaBslOb0EDZqKnd/B7s2D/BF/lyQD3l
 DHS2F19akpwEc4JX2Pw4hXSuP7wZr6woK2mSnOTol7Rur08rt173qwUuvMzPbHb901Kb
 Am763Nk4FzdF/VQaElUsMM2pbyGVTvbiTj+W54e1CtVZKhWvZovk1lAWpFB+WBKpAEqo
 fzWg6phYdEb2tzQiVgiWb61C8tP0/j96jQcMh8K8FJze5Yfo6ZomUisLdV40We3fExoN
 3A9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+ZcTrlprxef+fi52ZgXRJ4FWsDpJiA7CubFrxDwL3NEBdnTGu+UjaiSW4e/3WBG69Bn/XFeY=@lists.denx.de
X-Gm-Message-State: AOJu0YyVs7JDLXNP04+i4xDFUfTmKDParcV+6BpngEbdfDgOdUQaEACE
 CUCIk5HjGldnsNvdE8ucT6H8dJ8VU0yUQQMl5a++/Y/vLRJrA9i7UDx3rJ/FfOX4kne+4mjAK7H
 afgb/GfsZ/gPkummeMTJj2wEvhZE72GkJSmng29tnRg==
X-Gm-Gg: Acq92OEyRpFztLcQJsRNUdhgK7OWGQWjix2iM0mh8igsS1DOtPD+EGaPxXERpJcliD7
 Vl7Cx5PB8ZB9d+srtmYT8c9s35V+YEMSLqr5WwaJbPOZXvOYrPw8Y0scnsPUaZR8wcSkglcrmKL
 TkrqgNGsn/TpqnhS7b5DQKW/h1lplAmuUBU6pJ3aSthUxNMXiUVWvgYY/hhoR8lv5WwajHa4jFc
 JxVa1iHoi4q2mLxK5CD4owo2yA2VTADR2Mtcm3+sqeGmnklRgGRRYU/k7QeT3lq2e/bEkUGilqs
 okwVbgItnSaGNEfmC2fMZamltID7I3JdL05m0LGuMvazGM+TJVoW3aOW40Z+8xLGZNXqr3HvkXB
 S4+udXAsOpCtCqQi+s2AposmhD5tRuDh1Tt/tdqK6+JKD4DWV3r/KJxG4m6e+TJLiaKkNFz8rUw
 HL2fpQMZ/T7dxG5EPKr10MvN7yppPpDggLZ03McfBaYm3rcIbf7scjtgxSDIi0ZPHHiGkpxPukl
 hIkSj1WiBTzrSEUHxXuiqK8vIXLyoEV4lHQoIGVWYGVUKFyelV6XUIcay6j/OEn2WS5/PzsAMwn
 OLGfJn6rCzCs8jePqZFvmGHqe/fH9JUtZmQmsXmeRAAutcqLu24rgMLsHSxxZFN4KPJTLbvSiJI
 RP4CiEA==
X-Received: by 2002:a53:a490:0:b0:651:bc7e:467a with SMTP id
 956f58d0204a3-65df6378775mr1518275d50.60.1778653488143; Tue, 12 May 2026
 23:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260512194205.1905069-1-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260512194205.1905069-1-aswin.murugan@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 May 2026 09:24:12 +0300
X-Gm-Features: AVHnY4IBOI0cXm6Ttk1c-wBlOrtR772myo-KbyFKUxtOC0y7ogjjOGQZRsNN4x8
Message-ID: <CAC_iWj+tD8eOKxem3m94BWX42GTLuCD7tqEW0GUdtsPLpLcYqw@mail.gmail.com>
Subject: Re: [PATCH v2] efi_loader: Remove authentication header in
 GetVariable()
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: xypron.glpk@gmx.de, trini@konsulko.com, michal.simek@amd.com, 
 u-boot@lists.denx.de
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

Hi Aswin,

On Tue, 12 May 2026 at 22:42, Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> Currently, efi_get_variable_mem() returns the raw stored format for
> authenticated variables, which includes the EFI_VARIABLE_AUTHENTICATION_2
> descriptor . This causes image authentication failures when reading
> secure boot variables as callers receive wrong data containing
> authentication headers instead of the actual variable payload.

What are 'the callers'? The EFI security related variables are usually
read and consumed by the firmware itself during secure boot. I don't
remember the code on top of my head, but i think we end up storing the
auth info because it also contains timestamps etc.

>
> The UEFI Specification Section 8.2.6(EFI_VARIABLE_AUTHENTICATION_2 descriptor)
> explicitly states:
> "The authentication descriptor is not part of the variable data and is
> not returned by subsequent calls to GetVariable()."

We can strip the headers during GetVariable, but you need more changes
apart from the one here. The EFI secure boot tests fail with the
change above [1].

>
> This patch implements spec-compliant behavior by detecting variables with
> the EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS attribute and
> stripping the authentication descriptor before returning data to callers.

[1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/30086

Regards
/Ilias
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Enhanced commit message with explicit UEFI spec reference
> Link to v1: https://lore.kernel.org/u-boot/20250725123653.513252-1-aswin.murugan@oss.qualcomm.com/
> ---
>  lib/efi_loader/efi_var_mem.c | 44 +++++++++++++++++++++++++++++-------
>  1 file changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> index 8d5f99f4870..edf4522e51f 100644
> --- a/lib/efi_loader/efi_var_mem.c
> +++ b/lib/efi_loader/efi_var_mem.c
> @@ -336,9 +336,10 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
>                      u32 *attributes, efi_uintn_t *data_size, void *data,
>                      u64 *timep, u32 mask)
>  {
> -       efi_uintn_t old_size;
> +       efi_uintn_t old_size, var_data_size;
>         struct efi_var_entry *var;
>         u16 *pdata;
> +       void *var_data;
>
>         if (!variable_name || !vendor || !data_size)
>                 return EFI_INVALID_PARAMETER;
> @@ -362,19 +363,46 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
>         if (!u16_strcmp(variable_name, vtf))
>                 return efi_var_collect_mem(data, data_size, EFI_VARIABLE_NON_VOLATILE);
>
> +       for (pdata = var->name; *pdata; ++pdata)
> +               ;
> +       ++pdata;
> +
> +       var_data = (void *)pdata;
> +       var_data_size = var->length;
> +
> +       /* Handle EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS */
> +       if (var->attr & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS) {
> +               if (var_data_size > sizeof(struct efi_time)) {
> +                       struct efi_time *timestamp;
> +                       struct win_certificate_uefi_guid *cert;
> +                       efi_uintn_t auth_size;
> +
> +                       timestamp = (struct efi_time *)var_data;
> +                       cert = (struct win_certificate_uefi_guid *)(timestamp + 1);
> +                       auth_size = sizeof(struct efi_time) + cert->hdr.dwLength;
> +                       if (var_data_size > auth_size) {
> +                               var_data = (u8 *)var_data + auth_size;
> +                               var_data_size -= auth_size;
> +                       }
> +               }
> +       }
> +       /*
> +        * EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS type is old & not
> +        * expected for auth variables
> +        */
> +       else if (var->attr & EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS)
> +               return EFI_INVALID_PARAMETER;
> +
>         old_size = *data_size;
> -       *data_size = var->length;
> -       if (old_size < var->length)
> +       *data_size = var_data_size;
> +
> +       if (old_size < var_data_size)
>                 return EFI_BUFFER_TOO_SMALL;
>
>         if (!data)
>                 return EFI_INVALID_PARAMETER;
>
> -       for (pdata = var->name; *pdata; ++pdata)
> -               ;
> -       ++pdata;
> -
> -       efi_memcpy_runtime(data, pdata, var->length);
> +       efi_memcpy_runtime(data, var_data, var_data_size);
>
>         return EFI_SUCCESS;
>  }
> --
> 2.34.1
>
