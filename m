Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37F2C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 11:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19EED87E30;
	Wed, 20 Mar 2024 12:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PLQGJKWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79E6987E30; Wed, 20 Mar 2024 12:54:31 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A22087D8F
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 12:54:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d41d1bedc9so116733821fa.3
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 04:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710935669; x=1711540469; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kpPuKbJS27tun20dw6uYeWoIbYqenN4IvA//JjYYxyk=;
 b=PLQGJKWlRLHABVqKj4qkW9JMP5ivcK1ly8R0sc0K84rPZGuKa+q4LMH2LOosjUV+hr
 nDkiLowXyFejRTme14rJn6Wo5HF9uw69G75MQN95TRG/25bOSL0UFc352gpu/qzP2M9q
 kOYNA/DbhnxC4E/pDZ+GeBzQbNXauFtdr2PTGTcHeRk/RoqSogBHmf6bk5H6n/FxBYH1
 /VxB3cY4lr2gxyEtOX7GfK9R0sM9tLubmHUrU5luecuGgg49/eUTV7zQzNRnSYrZmxRc
 ymrhXrE51kxgDKLaBNunnCOGb60eLtijlT/kUl4ng28a/33PHRNTAGnckl8l62UvGBjf
 rtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710935669; x=1711540469;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kpPuKbJS27tun20dw6uYeWoIbYqenN4IvA//JjYYxyk=;
 b=hkJpw0Tg9n60ImCk2XmWY5ex96QmlwM+im732zCYAhPCLF1r4FQVaTZmMezmUHjapZ
 chLJuA3wLjIQBxHpA8gGBFmDHnFcCvKc+e1O5tB3kvcQqAW750FI3QeaENPx6lkL1LRj
 AmtpOdz+xvUKd4xHdzfnFwYdk2hQuOuU291w/YIgDUD/X505Bwi707fXK+8/xgS33RNA
 DFzp3FfFHLUDpRZKEBuJNETWFAyhsaPzgTEzNnD3QbLssKPdiyVcbkbGk1u/XyBTOu2L
 CKEYSDgxlVvctqCifPJ/0nv5j1p6pDUNGNqZCCubz4cLv/YSrEGceRJ2ZUOZYRessWlh
 NTbQ==
X-Gm-Message-State: AOJu0Yx+LoL2Abw83XyrOOTnQom1wTcB07RLje+RamGx0eO93mKPOfyF
 XhBNJGDYv1soULEDDKRkW1nX13/3TwugQccZgX4DwdNwn91S1eAsu8tNeOoTR/Pt2ZfMHS6l2lc
 UuiX6G15ro5lgF/e2SV8uXATICx9KxbDpyJggAg==
X-Google-Smtp-Source: AGHT+IEtofKOYwTdBpc4r0C5ebnDYbSqOea8RwW+udiUooadDCCYZ6kAvM0HJ1uM4RdV4t26MK6oA3ZfI0imx4rp+hg=
X-Received: by 2002:a05:651c:388:b0:2d4:707d:8b3c with SMTP id
 e8-20020a05651c038800b002d4707d8b3cmr9684517ljp.18.1710935668549; Wed, 20 Mar
 2024 04:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240320113051.1.If084ef69b9da34900391d0f0acc13475b250ce9f@changeid>
In-Reply-To: <20240320113051.1.If084ef69b9da34900391d0f0acc13475b250ce9f@changeid>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Mar 2024 13:53:52 +0200
Message-ID: <CAC_iWj+1j+WR0aCTLA9Z21j347FpT95t3iWZnJoPFhH5E9jScQ@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Add absolute path to EFI_VAR_FILE_NAME
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Patrice,

On Wed, 20 Mar 2024 at 12:31, Patrice Chotard
<patrice.chotard@foss.st.com> wrote:
>
> If the ESP partition is formatted in ext4, we got the following error :
>
> STM32MP>  setenv -e -nv -bs -rt -v OsIndications =0x0000000000000004
> GUID: 8be4df61-93ca-11d2-aa0d-00e098032b8c (EFI_GLOBAL_VARIABLE_GUID)
> Attributes: 0x7
> Value:
>     00000000: 04 00 00 00 00 00 00 00                          ........
> File System is consistent
> Please supply Absolute path

This error message comes from ext4_common.c and it's ext4 specific. Do
you have any idea why this exists?
What happens to other filesystems? IOW does this change the behavior
of the existing code if it tries to write a file in FAT?

Thanks
/Ilias

> ** Error ext4fs_write() **
> ** Unable to write file ubootefi.var **
> Failed to persist EFI variables
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>  include/efi_variable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/efi_variable.h b/include/efi_variable.h
> index 805e6c5f1e0..8d507460b20 100644
> --- a/include/efi_variable.h
> +++ b/include/efi_variable.h
> @@ -92,7 +92,7 @@ efi_status_t efi_query_variable_info_int(u32 attributes,
>                                          u64 *remaining_variable_storage_size,
>                                          u64 *maximum_variable_size);
>
> -#define EFI_VAR_FILE_NAME "ubootefi.var"
> +#define EFI_VAR_FILE_NAME "/ubootefi.var"
>
>  #define EFI_VAR_BUF_SIZE CONFIG_EFI_VAR_BUF_SIZE
>
> --
> 2.25.1
>
