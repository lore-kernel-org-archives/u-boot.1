Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4682E7718F
	for <u-boot@archiver.kernel.org>; Fri, 27 Dec 2024 11:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A3178036E;
	Fri, 27 Dec 2024 12:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NC1lnS4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EC1480384; Fri, 27 Dec 2024 12:14:45 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CF388036D
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 12:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e460717039fso7584623276.0
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 03:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735298081; x=1735902881; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jl0PHLNJ2Aezq2wkzzg5+sdSqE+/6JPXRbrrBor7rww=;
 b=NC1lnS4F33nwRLMLxtxCp/ndPbftjHzHxWzY6wol8ctnAsKdsSGBANcAU7fWuwboiL
 L3mp6V+Ogf2DyHR2nlUHQu4sFZkuhB3vZ4dGnU3JWwC/FKQutmWjRct6x8oFnWep9X0a
 W36aZEXBWVpQNaDAXEIziVJTl8nphMx4uzjPtC6cac1uPORVoeirzQ91xExka/1aHBVD
 f7KgqNe4fns1e6TwfGgD5dFw3M7mhJ3hurazVlHd+4BV2nZW9bvAYn/jBV9mvKnZ3aVo
 sAW1RiqeO/W2mJuOATCvkmEUkNTzRtCGxrpkr9fSqFldyED5xqDScc8XkR67oXDBr4m/
 7Oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735298081; x=1735902881;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jl0PHLNJ2Aezq2wkzzg5+sdSqE+/6JPXRbrrBor7rww=;
 b=A/jPATOS0UaHwtU4C+z4eukjCDsgfTl83MFN6xseqsd6q3hFA9MoY516+6h9wC9gaO
 +GOF1v+gvrbqwBcGwul791QuemZ2F9AftZVEFNVG7SqBZswG7V/SoOVM7fdidueGAImJ
 wFvv9mGG/76gAUYZRKvJJpE5WnjOhUBnVkAUJVCfzqhMTold/nrYLweEQeq7Oa6DUv68
 Ixrs/EFSO0ZPy3fQJzpqqHoKwXpIwKc/CI2jGWYgSTBRZW7s/LMTW2h9adcLXvKV2ODz
 +wNfnoZmlJLMPLaAn3Vw0vF8SBXMFIFx/Aje0SfjinLJR2JRStvRUWoyX8HYH4ORWGBu
 DqKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4oINnati8b3jjQeKg1Ot37FdO9Lk6sW6fl8/drez76KD5dcidtWPzdF7heBynMUfWbHnVX2Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yz16jO1Fd1UKTIi6EYtvwktiu0Ejcbn0bhqotLN3p0Clou/p9ZI
 WTy9U0SWDd+u538UOa97jjA7ZVwg1l7LmhfKF9ReYCDmzcHtONSUfsPMPBeaaup9VMg8c9TlOVn
 gI4oUB8Fg7BpV7T9ji8Be8jpuhxBNuCLjPelbgA==
X-Gm-Gg: ASbGncv00CTJTpV0QXIPNzY5szjwYyk36Q6Ou+1v17vGdhlEe4JvfSO3LMD8ytdLnTz
 j1sSaksh0/cO6Vs3exuyJ9o0ku2Iw5efjtqRQwQ==
X-Google-Smtp-Source: AGHT+IF5UTGwBUP5zMV8Bgafp1xyyGFab6IEX5jLcV30HTz3y0kn83AkFX/IJVzu36MkELpex2ugaVJAXNFOCnOqM4g=
X-Received: by 2002:a25:1e84:0:b0:e4c:66ab:ed4e with SMTP id
 3f1490d57ef6-e538c22dee7mr16043052276.13.1735298081300; Fri, 27 Dec 2024
 03:14:41 -0800 (PST)
MIME-Version: 1.0
References: <20241224220049.26629-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241224220049.26629-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Dec 2024 13:14:05 +0200
Message-ID: <CAC_iWjL3Nxu=jtrS9vPa1hs71+pdDsZSA=W+uobMbaK0xpSKwg@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: update descriptions in tpm-v2.h header
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Tim Harvey <tharvey@gateworks.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

Thanks Heinrich,

On Wed, 25 Dec 2024 at 00:00, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> * Provide a link to 'TPM 2.0 Library Specification'
> * Remove outdated comment for TPM2_NUM_PCR_BANKS.
>   The value 16 can be found in the current standard
>   TCG TSS 2.0 Overview and Common Structures Specification 1.0, rev 10
> * Describe some of the structures in Sphinx style.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/tpm-v2.h | 42 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 9 deletions(-)
>
> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index 4fd19c52fd7..0f388b26496 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -6,6 +6,11 @@
>   * Copyright (c) 2020 Linaro
>   * Copyright (c) 2018 Bootlin
>   *
> + * The structures are described in
> + * Trusted Platform Module Library Part 2: Structures
> + * http://tcg.tjn.chef.causewaynow.com/resource/tpm-library-specification/
> + *
> + * C header files are listed in
>   * https://trustedcomputinggroup.org/resource/tss-overview-common-structures-specification/

We already define that a few lines above
>   *
>   * Author: Miquel Raynal <miquel.raynal@bootlin.com>
> @@ -34,12 +39,8 @@ struct udevice;
>
>  #define TPM2_HDR_LEN           10
>
> -/*
> - *  We deviate from this draft of the specification by increasing the value of
> - *  TPM2_NUM_PCR_BANKS from 3 to 16 to ensure compatibility with TPM2
> - *  implementations that have enabled a larger than typical number of PCR
> - *  banks. This larger value for TPM2_NUM_PCR_BANKS is expected to be included
> - *  in a future revision of the specification.
> +/**
> + * define TPM2_NUM_PCR_BANKS - number of PCR banks
>   */
>  #define TPM2_NUM_PCR_BANKS 16
>
> @@ -55,20 +56,43 @@ struct udevice;
>  #define TPM2_PT_MAX_COMMAND_SIZE       (u32)(TPM2_PT_FIXED + 30)
>  #define TPM2_PT_MAX_RESPONSE_SIZE      (u32)(TPM2_PT_FIXED + 31)
>
> -/* TPMS_TAGGED_PROPERTY Structure */
> +/**
> + * struct tpms_tagged_property - TPMS_TAGGED_PROPERTY structure
> + *
> + * This structure is returned by TPM2_GetCapability() to report
> + * a u32 property value.
> + *
> + * @property:  property identifier
> + * @value:     value of the property
> + */
>  struct tpms_tagged_property {
>         u32 property;
>         u32 value;
>  } __packed;
>
> -/* TPMS_PCR_SELECTION Structure */
> +/**
> + * struct tpms_pcr_selection - TPMS_PCR_SELECTION structure
> + *
> + * This structure allows to specify a hash algorithm and a list of
> + * selected PCRs. A PCR is selected by setting the related bit in
> + * @pcr_select to 1.
> + *
> + * @hash:              hash algorithm associated with the selection
> + * @size_of_select:    size in bytes of the @pcr_select array
> + * @pcr_select:                bit map of selected PCRs
> + */
>  struct tpms_pcr_selection {
>         u16 hash;
>         u8 size_of_select;
>         u8 pcr_select[TPM2_PCR_SELECT_MAX];
>  } __packed;
>
> -/* TPML_PCR_SELECTION Structure */
> +/**
> + * struct tpml_pcr_selection - TPML_PCR_SELECTION structure
> + *
> + * @count:     number of selection structures, may be zero
> + * @selection: list of selections
> + */
>  struct tpml_pcr_selection {
>         u32 count;
>         struct tpms_pcr_selection selection[TPM2_NUM_PCR_BANKS];
> --
> 2.47.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
