Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE84C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 07:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FE85874DD;
	Thu, 28 Dec 2023 08:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Lb5Nt9hT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78096876BF; Thu, 28 Dec 2023 08:18:11 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE03B874D5
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 08:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50e70b0b869so3872940e87.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 23:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703747888; x=1704352688; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fphfNSlR77yh4XyMURQ0g0j9jBXQnZhVoLfA7SLsIOo=;
 b=Lb5Nt9hTbnXY5o+sQTI9hUsBAmQ0tQFqr7nFZdNktuUk98U9617fp1YxM2gKrVeJeG
 TdJk5NSMLzmGdrqGJn3CsVd/1dBsDYzUT3xoS333D7cL/Vaa1ovDsbx/3RByJRICAFsF
 IyUJZbd9AlTwzVqC9lXyzLuswqvrZwSw08LPTdN1IlESJM0A+1NWIfdKVz74lqQCUXz6
 FPIWBIWAy21ZStVJhpWjI8LhTKmua0ywBbN/mdO4qT7g6f/7yDfkgW1gk7GCMX9bsquW
 NfqGapiejRr2HNn9S+agJfFmt6saKq5gtPTINbCv/ymdFl3aQshBXvodDJ5Tdan9Tuqn
 uyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703747888; x=1704352688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fphfNSlR77yh4XyMURQ0g0j9jBXQnZhVoLfA7SLsIOo=;
 b=QRAZPCjUMi+7OVOilfAKn6yi4RSr0z+Orr3SzzcA7HgXbUoK4pN7HG8K7uG9iau+S6
 Ixzz6vXd/JOBKbbg8v6K9PaMxqjQky3Agpruz6QwtFO8/XYQFcp8YJ1Nbk3eSYoNsuE9
 b8LKwcrwFaIe90Fq/IQSalpPKqPe+4oCeGM9utUTIjS3JwN2gKsAbXnnQdtTZ6Qw8av5
 XFI28SLcIg+SnuW1IJOo+OVOXLT3uprM1VXQQqQ6MZ38olKI0ahbgYh2id8thYb6m3Xj
 0PCaPgcLKufgojPxUEANYVQuVpS1qnMpk1zijSefcAk0qFU49LZcbgn/+kDOzwVNDEBC
 pxKg==
X-Gm-Message-State: AOJu0YxayhbO+lXsSAvCimpdR68q5LkP1RPL+neX8TPCdZ4mUmFIkZ8X
 v182vZcZsicZZ6Srf+Gs0qf2R7prc46LYjs3VGrVu61UK9DuB3wbe8fWqfWfvcs=
X-Google-Smtp-Source: AGHT+IFr1HEREvAGo6QUPh3IwWvCQ+cPiAIUjB8Suvg6ywuLLSuEAHuYUhbyt0UkyeZxGPfxyh6QXKarCMtx+WgnTpM=
X-Received: by 2002:a05:6512:3e2a:b0:50e:74c1:6e65 with SMTP id
 i42-20020a0565123e2a00b0050e74c16e65mr3331937lfv.81.1703747888176; Wed, 27
 Dec 2023 23:18:08 -0800 (PST)
MIME-Version: 1.0
References: <20231227210712.712937-1-raymond.mao@linaro.org>
 <20231227210712.712937-2-raymond.mao@linaro.org>
In-Reply-To: <20231227210712.712937-2-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Dec 2023 09:17:31 +0200
Message-ID: <CAC_iWj+w41TX5PewM_8zZP26G0fafXraxQ-cazwcvR=_FdcHkg@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] bloblist: Update the tag numbering
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

On Wed, 27 Dec 2023 at 23:07, Raymond Mao <raymond.mao@linaro.org> wrote:
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
>
> -       /*
> -        * Project-specific tags are permitted here. Projects can be open source
> -        * or not, but the format of the data must be fuily documented in an
> -        * open source project, including all fields, bits, etc. Naming should
> -        * be: BLOBLISTT_<project>_<purpose_here>
> -        */
> -       BLOBLISTT_PROJECT_AREA = 0x8000,
> -       BLOBLISTT_U_BOOT_SPL_HANDOFF = 0x8000, /* Hand-off info from SPL */
> -       BLOBLISTT_VBE           = 0x8001,       /* VBE per-phase state */
> -       BLOBLISTT_U_BOOT_VIDEO = 0x8002, /* Video information from SPL */
> -
> -       /*
> -        * Vendor-specific tags are permitted here. Projects can be open source
> -        * or not, but the format of the data must be fuily documented in an
> -        * open source project, including all fields, bits, etc. Naming should
> -        * be BLOBLISTT_<vendor>_<purpose_here>
> -        */
> -       BLOBLISTT_VENDOR_AREA = 0xc000,
> +       /* Standard area to allocate blobs used for Trusted Firmware */
> +       BLOBLISTT_AREA_TF = 0x100,
> +       BLOBLISTT_OPTEE_PAGABLE_PART = 0x100,
>
> -       /* Tags after this are not allocated for now */
> -       BLOBLISTT_EXPANSION = 0x10000,
> +       /* Other standard area to allocate blobs */
> +       BLOBLISTT_AREA_OTHER = 0x200,
> +       BLOBLISTT_INTEL_VBT = 0x200,    /* Intel Video-BIOS table */
> +       BLOBLISTT_SMBIOS_TABLES = 0x201, /* SMBIOS tables for x86 */
> +       BLOBLISTT_VBOOT_CTX = 0x202,    /* Chromium OS verified boot context */
>
>         /*
>          * Tags from here are on reserved for private use within a single
> @@ -133,9 +127,20 @@ enum bloblist_tag_t {
>          * implementation, but cannot be used in upstream code. Allocate a
>          * tag in one of the areas above if you want that.
>          *
> -        * This area may move in future.
> +        * Project-specific tags are permitted here. Projects can be open source
> +        * or not, but the format of the data must be fuily documented in an
> +        * open source project, including all fields, bits, etc. Naming should
> +        * be: BLOBLISTT_<project>_<purpose_here>
> +        *
> +        * Vendor-specific tags are also permitted. Projects can be open source
> +        * or not, but the format of the data must be fuily documented in an
> +        * open source project, including all fields, bits, etc. Naming should
> +        * be BLOBLISTT_<vendor>_<purpose_here>
>          */
> -       BLOBLISTT_PRIVATE_AREA = 0xffff0000,
> +       BLOBLISTT_PRIVATE_AREA          = 0xfff000,
> +       BLOBLISTT_U_BOOT_SPL_HANDOFF    = 0xfff000, /* Hand-off info from SPL */
> +       BLOBLISTT_VBE                   = 0xfff001, /* VBE per-phase state */
> +       BLOBLISTT_U_BOOT_VIDEO          = 0xfff002, /* Video info from SPL */
>  };
>
>  /**
> diff --git a/test/bloblist.c b/test/bloblist.c
> index 720be7e244..efa1e32afd 100644
> --- a/test/bloblist.c
> +++ b/test/bloblist.c
> @@ -291,9 +291,9 @@ static int bloblist_test_cmd_list(struct unit_test_state *uts)
>         console_record_reset();
>         run_command("bloblist list", 0);
>         ut_assert_nextline("Address       Size   Tag Name");
> -       ut_assert_nextline("%08lx  %8x  8000 SPL hand-off",
> +       ut_assert_nextline("%08lx  %8x  fff000 SPL hand-off",
>                            (ulong)map_to_sysmem(data), TEST_SIZE);
> -       ut_assert_nextline("%08lx  %8x   106 Chrome OS vboot context",
> +       ut_assert_nextline("%08lx  %8x   202 Chrome OS vboot context",
>                            (ulong)map_to_sysmem(data2), TEST_SIZE2);
>         ut_assert_console_end();
>         ut_unsilence_console(uts);
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
