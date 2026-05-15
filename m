Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB3ECD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0ADF847C5;
	Fri, 15 May 2026 20:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b9gIZwMQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E40438484A; Fri, 15 May 2026 20:26:30 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8FD3846AE
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-670ab084a39so301545a12.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778869588; cv=none;
 d=google.com; s=arc-20240605;
 b=QDxYoVKitTUcw1xxe8g+TQ0q1hLblzJaaOL/cbSpirk2TrjolKccUFSs2VvkB1WlqO
 +yfPz0YQsQYDiaONvDDZn1dnp6dUKxxKGEvmOVwN6rNaD2bQhRf1MuekjnJffx89abrb
 WY5oTZSMoL5ktlU0zw2J93FXaNIzC8T4qnJT2zc0xRlqXa+37CX4nDEZiFDp3gPGlcD5
 oRMVz1I4539sJHUqJKEw1bojd0NZLkrE++zmROLnnH7gurxsbizYlsDEoSX+pib8BkF2
 +6z1EhbivXA7FGVa9qQFkhPSPJ2hSmLuMDwwYiJ9xHPcH5SUYvbs6UfxrnqdmYOFL6ha
 E9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wPRmaDamQQtL67M87EfBSQ0O8gvx+wuC8mTwfz+zCJg=;
 fh=sKlYf1RYFkU7W57k8Hb0RqRH+ropi6os4Aw4ruwQ2Xw=;
 b=UQBORQsTUcmbTcUx5l4XIAzo3qbzEu1BVP1nOG+4rysffOnzoIhGBjMbaUQkLM3mcf
 v0AgqSSU6BPurAS7gasMaC/tQUsF5XWn5mApELK8wtIDMPr1KqBibdrh/d1yEuv7ijUe
 xQbp8DeUH4GW/+LtEy7tAtTLgOunQ92n61pk/MyVMHL+AhX9jvBpt2IEd5kPx8OV8ssF
 YTKmOW2EAtRuuDy2lGBpdTDnZ7M2ItPceB3LeDspYTHuMqfCvTmPj80JoFY4FODmgeqa
 4cfED2YCs23kh6i0W53nDesUxWc5JyXBqSo5fNQ5XvKellakGYKH8WA1bTD2o+0j2zv6
 YMTQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778869588; x=1779474388; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wPRmaDamQQtL67M87EfBSQ0O8gvx+wuC8mTwfz+zCJg=;
 b=b9gIZwMQvnhWosdJcShP04yzFpdur0W5EB02YDrRntrc3xcEvwQypAudW/V7xDPmJ+
 x/3FWepNPDES2+DZGxznIzM1JqgbxSGUpGKsp+KWyQdrh8ENOvfxGx0IKTOyIWaSz883
 akWTjSLSv29JdOiILBiZz63HPyLv8sjU+ISPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778869588; x=1779474388;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPRmaDamQQtL67M87EfBSQ0O8gvx+wuC8mTwfz+zCJg=;
 b=n1e5tlBnpE/PMQgA+FAVNT4hxYEQZWBAtgEnj7HRsoSVlrzM+RXMha565A5x6af/r5
 +4SMU3f8O+aDLUEinE8fjFUr3tAHg652yIuBgKoDkbvhqG95q46bxDjL3PvXX03hX1nY
 YEg9eviDzpdHWhA7AfHvuYhgluIYvbjKDjnTnqLO50/VPBz4mMGBou8O9TPnibXFUeK+
 S6h73Ccc8WbfSPZhpCbYQ7NDJsPaNw0/zMfmDwzMjrtUSIyWaPNOoOX9N07rshcR8yAT
 1eTNIWvjWqwjClYfZ7gdqALY614h1RXcFXlrMvO6boLeW/pKHlAcLUoLUwZ1IL+qgHxj
 hifw==
X-Gm-Message-State: AOJu0Yw0VhWHPhDWcvxYCUUn957Bc4SjmFPiDz1e0D+gw+Darswlb8bl
 Xfro6xo3ldMKUzi/2rLvh//gXpsyYluH8jGrnvzec/4tUPbEFdNzVJOBjE8JztCFS9RLeCmUcnu
 eyAoOSuX+d6bLkscL61fU2VX46eG0oVrvWocGQNWA
X-Gm-Gg: Acq92OGpfVN0T6QNxyKqk4KRM9nb1rkjbyzzR4cjt2/BFGm59eCXodOeWmalXcd5Vlh
 xwQazEFw9IriTJSL9I3JcLgdmE4k1e/WRkoD9UIl9TpmZYW/leTPwad3p7kk4kEs8vl3YDbZ2dy
 9btN9scBqS/RdF7KN7+UC9Ds+3sjDnESaVGY0HfcDx0P4z2SqYk1CoaFFEyhqC2q1auopziXIgz
 RJPFgrEfbBRuArGT/5AYljFh0lzqIq68BfnjSGWXGgXCrINe2we90WuDAK2ccxqTTuivWOnUwNT
 VsIuVQ==
X-Received: by 2002:a17:906:5146:20b0:bd5:405c:7964 with SMTP id
 a640c23a62f3a-bd5405c7ae2mr81763266b.48.1778869588321; Fri, 15 May 2026
 11:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-5-harsimransingh.tungal@arm.com>
In-Reply-To: <20260514124924.1804332-5-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 12:26:15 -0600
X-Gm-Features: AVHnY4J-PTau6YTowQqCnO1hbKp0KlJjEtLBH_V6wg8rHW2dPzHvnxx3HglNtv4
Message-ID: <CAFLszTjgLKxRxxBSTXS7xWqWmzrF9zCiJRGKXAQcvEKvu1hcfw@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] efi_loader: enable EFI runtime
 SetVariable()/GetVariable() using FF-A transport
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, abdellatif.elkhlifi@arm.com, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, hugues.kambampiana@arm.com, 
 sjg@chromium.org
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

On 2026-05-14T12:49:13, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
> efi_loader: enable EFI runtime SetVariable()/GetVariable() using FF-A transport
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
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> lib/efi_loader/efi_variable_tee.c | 320 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 315 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -830,6 +905,95 @@ out:
> +efi_status_t __efi_runtime efi_get_variable_runtime(u16 *variable_name,
> +                                                 const efi_guid_t *vendor,
> +                                                 u32 *attributes,
> +                                                 efi_uintn_t *data_size,
> +                                                 void *data)

EFIAPI is missing so this will break on x86_64 where there is a
different ABI. Same for efi_get_next_variable_name_runtime() below -
please match efi_set_variable_runtime() /
efi_query_variable_info_runtime() which already carry EFIAPI.

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -743,6 +775,49 @@ out:
> +     ret = mm_communicate(comm_buf, payload_size);
> +     /*
> +      * Currently only R/O property is supported in StMM.
> +      * Variables that are not set to R/O will not set the property in StMM
> +      * and the call will return EFI_NOT_FOUND. We are setting the
> +      * properties to 0x0 so checking against that is enough for the
> +      * EFI_NOT_FOUND case.
> +      */
> +     if (ret == EFI_NOT_FOUND)
> +             ret = EFI_SUCCESS;
> +     if (ret != EFI_SUCCESS)
> +             return ret;
> +     efi_memcpy_runtime(var_property, &smm_property->property, sizeof(*var_property));

When EFI_NOT_FOUND is mapped to EFI_SUCCESS we still fall through and
memcpy smm_property->property over the zeroed var_property - at
runtime smm_property aliases the FF-A shared buffer, so whatever the
SP left in those bytes ends up in var_property and undoes the memset
above. Either move the memcpy under an explicit found branch, or skip
it on the NOT_FOUND-mapped-to-SUCCESS path. The boot-time copy doesn't
matter because the SP fills the response into the local buffer; here
the shared buffer is the response.

> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> @@ -1067,7 +1319,65 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
> +     if (ro && !(var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY)) {
> +             var_property.revision = VAR_CHECK_VARIABLE_PROPERTY_REVISION;
> +             var_property.property |= VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY;
> +             var_property.attributes = attributes;
> +             var_property.minsize = 1;
> +             var_property.maxsize = var_acc->data_size;
> +             ret = set_property_int_runtime(variable_name, name_size, guid, &var_property);
> +     }

Just to check - at runtime var_acc points into the FF-A shared buffer,
and the preceding mm_communicate() has already let the SP write its
response there, so var_acc->data_size is whatever the SP reported (and
may be 0 on failure). Is that what we want as maxsize, or should this
be the original data_size argument? Please confirm the SP guarantees
data_size on the way out for SET_VARIABLE before relying on it.

Regards,
Simon
