Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06095C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 09:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7640C878E9;
	Wed, 27 Dec 2023 10:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mgaWAp0L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6DFC878F6; Wed, 27 Dec 2023 10:48:23 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8599878C1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 10:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50e7f58c5fbso1513958e87.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 01:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703670501; x=1704275301; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8eePNTGJiAsFIPe4usOMwSubPdFTs1woUBcvPMKMMcI=;
 b=mgaWAp0LlAbmFwQoVUpjVROfc8d0CpiE9fvJGzMKb454DtRUs9XEdF2G9iAGCIz7Cz
 c5k3yAOFF43VBaWtVQxfZhWRz/JNVllsmKrDjRleJlVq9T4WHvCq/w+1wic/03iDFH7h
 j2OzDVIo1IgKAOJ2ThPm1B+Uxp0Zky4wjbMhU8tUu6WCwt0nlDfd6zj2l5oQwmiaZolp
 ZB6jW8sZ7U4Vg6DW5QvkKgEEuwnE+Wb3kKkS8PK2VX3JpX2JojwXfaYHa5JIffXWC9UM
 2lI3qKVWIsV/az/exhwwTtiKcf5gddHagWnWuRJNWPj+mDXXJJ+KBljxvbexBsJP1rhO
 HT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703670501; x=1704275301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8eePNTGJiAsFIPe4usOMwSubPdFTs1woUBcvPMKMMcI=;
 b=P1HhAuscD73cM0kRdr0rcb7C2WoiOt7/ERlSqhaXKACuqLau65lO9nStc2hlpfsnRO
 c0HkQahMRHtLp0mTYyPnLiV57/UTC4DbDHF/lug3rvwqY5OvxRxs2ALX9jysctBUUKoK
 TT+11BX6mFyoA5Gq2AhoI9m7IVAVnkTg2APcAs7OrP4YeSGZS1cMUIvcgsPWRFvvFGvK
 kqYrZS9Tk92P203hyTToNPmerg5Bb+nxszb1XZmIrcmAp5XNFOBkCtJCfozpUkHwDcIh
 ZSYPYWsT5no9ArDEHJn+FkhnAPz8USBvM+RbCSReL9/1UIDJZXJucIWoBDmm6jVFgCKv
 zi1Q==
X-Gm-Message-State: AOJu0YylQhTlBbvzdYcyGv3wfVw7QWyTTG1NgFCY135TMM6wC3ArK+36
 iAjmx96n/zv0OsEHADj5z476JwK4Qzcl8dsmzghh1AUjiCaAQ25ImlYeEbVU
X-Google-Smtp-Source: AGHT+IGtpzlIFYZHx3GwUx8NjFCsLUk+efDLK+H50dqitTLinSxJC9nd4oqrsJaAdWrvBBYRQy48wzvQd/MchHRo/kw=
X-Received: by 2002:a05:6512:419:b0:50e:2bfd:df51 with SMTP id
 u25-20020a056512041900b0050e2bfddf51mr3382321lfk.67.1703670501014; Wed, 27
 Dec 2023 01:48:21 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-2-raymond.mao@linaro.org>
In-Reply-To: <20231218181901.337515-2-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 11:47:45 +0200
Message-ID: <CAC_iWjJ7AQ5_=yh-0FPcFOQ2-8XmZ24eT2WtWtQ8gmmEOiMuvg@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] bloblist: Update the tag numbering
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

Hi Raymond,

On Mon, 18 Dec 2023 at 20:19, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Align bloblist tags with the FW handoff spec v0.9.
> The most common ones are from 0.
> TF related ones are from 0x100.
> All non-standard ones from 0xfff000.
>
> Added new defined tags:
> BLOBLISTT_OPTEE_PAGABLE_PART for TF.
> BLOBLISTT_TPM_EVLOG and BLOBLISTT_TPM_CRB_BASE for TPM.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Align bloblist tags to FW handoff spec v0.9.
> Changes in v3
> - Add TPM related tags
>
>  common/bloblist.c  | 18 ++++++++++---
>  include/bloblist.h | 67 +++++++++++++++++++++++++---------------------
>  test/bloblist.c    |  4 +--
>  3 files changed, 52 insertions(+), 37 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index a22f6c12b0..5606487f5b 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -36,16 +36,26 @@ static struct tag_name {
>         enum bloblist_tag_t tag;
>         const char *name;
>  } tag_name[] = {
> -       { BLOBLISTT_NONE, "(none)" },
> +       { BLOBLISTT_VOID, "(void)" },
>
>         /* BLOBLISTT_AREA_FIRMWARE_TOP */
> +       { BLOBLISTT_CONTROL_FDT, "Control FDT" },
> +       { BLOBLISTT_HOB_BLOCK, "HOB block" },
> +       { BLOBLISTT_HOB_LIST, "HOB list" },
> +       { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
> +       { BLOBLISTT_TPM_EVLOG, "TPM event log defined by TCG EFI" },
> +       { BLOBLISTT_TPM_CRB_BASE, "TPM Command Response Buffer address" },
>
>         /* BLOBLISTT_AREA_FIRMWARE */
> -       { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
> -       { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
>         { BLOBLISTT_TPM2_TCG_LOG, "TPM v2 log space" },
>         { BLOBLISTT_TCPA_LOG, "TPM log space" },
> -       { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
> +       { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
> +
> +       /* BLOBLISTT_AREA_TF */
> +       { BLOBLISTT_OPTEE_PAGABLE_PART, "OP-TEE pagable part" },
> +
> +       /* BLOBLISTT_AREA_OTHER */
> +       { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
>         { BLOBLISTT_SMBIOS_TABLES, "SMBIOS tables for x86" },
>         { BLOBLISTT_VBOOT_CTX, "Chrome OS vboot context" },
>
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 080cc46a12..92dbfda21b 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -81,7 +81,7 @@ enum {
>
>  /* Supported tags - add new ones to tag_name in bloblist.c */
>  enum bloblist_tag_t {
> -       BLOBLISTT_NONE = 0,
> +       BLOBLISTT_VOID = 0,
>
>         /*
>          * Standard area to allocate blobs used across firmware components, for
> @@ -89,42 +89,36 @@ enum bloblist_tag_t {
>          * projects.
>          */
>         BLOBLISTT_AREA_FIRMWARE_TOP = 0x1,
> +       /*
> +        * Devicetree for use by firmware. On some platforms this is passed to
> +        * the OS also
> +        */
> +       BLOBLISTT_CONTROL_FDT = 1,
> +       BLOBLISTT_HOB_BLOCK = 2,
> +       BLOBLISTT_HOB_LIST = 3,
> +       BLOBLISTT_ACPI_TABLES = 4,
> +       BLOBLISTT_TPM_EVLOG = 5,
> +       BLOBLISTT_TPM_CRB_BASE = 6,
>
>         /* Standard area to allocate blobs used across firmware components */
> -       BLOBLISTT_AREA_FIRMWARE = 0x100,
> +       BLOBLISTT_AREA_FIRMWARE = 0x10,
> +       BLOBLISTT_TPM2_TCG_LOG = 0x10,  /* TPM v2 log space */
> +       BLOBLISTT_TCPA_LOG = 0x11,      /* TPM log space */
>         /*
>          * Advanced Configuration and Power Interface Global Non-Volatile
>          * Sleeping table. This forms part of the ACPI tables passed to Linux.
>          */
> -       BLOBLISTT_ACPI_GNVS = 0x100,
> -       BLOBLISTT_INTEL_VBT = 0x101,    /* Intel Video-BIOS table */
> -       BLOBLISTT_TPM2_TCG_LOG = 0x102, /* TPM v2 log space */
> -       BLOBLISTT_TCPA_LOG = 0x103,     /* TPM log space */
> -       BLOBLISTT_ACPI_TABLES = 0x104,  /* ACPI tables for x86 */
> -       BLOBLISTT_SMBIOS_TABLES = 0x105, /* SMBIOS tables for x86 */
> -       BLOBLISTT_VBOOT_CTX = 0x106,    /* Chromium OS verified boot context */
> +       BLOBLISTT_ACPI_GNVS = 0x12,

Any idea if we have users that would be affected by this value change?

[...]

Thanks
/Ilias
