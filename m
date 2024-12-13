Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02224E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 11:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E9F880104;
	Fri, 13 Dec 2024 12:49:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fsdvmTll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22D498010B; Fri, 13 Dec 2024 12:49:32 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94724800DF
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 12:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6f00b10bc1dso15107347b3.3
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 03:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734090568; x=1734695368; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f4zPj7ZR31+bjyCtFRbLqSK9FeBeyH6N2LNRi+qTRTU=;
 b=fsdvmTll+GcnFUNMBDj+nz7ktdzwrJ5vvpbWYIp0DM3McwNdHjP9BEo5MqPXXrbhKf
 bp3x+vrs6QyeAJogO84fQLQKXw6ci/BzZ+aUtckUtohuzeeK0BaR72DHMPmHcvkTrB1K
 a0/OVamWenWfGS0Qh8l2RHKZd+wgzlXuIcag28+FHbnE2V7XhHKHL7EfmYQ/j4fVK3iB
 6TJiqwQcf6hz2ctnGmwLRLu8RFvuXS1UMscBOje3AeKRDkyjIl+EKD/xvflq3MUrIm16
 NHLoi1d0XYpdRfXzLk1/0Ymobt8ePdiweR2znT45GUmqBn6S/8P0Yuvcn6y5hLDT96+n
 cS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734090568; x=1734695368;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f4zPj7ZR31+bjyCtFRbLqSK9FeBeyH6N2LNRi+qTRTU=;
 b=L8nv1TpT3SDv59A7DqvvipL/WK1d1LOo7kPDzeMRXrNuGqdBLBSx9T8rJIEX8uPREh
 +gSZrBL7SLXLCRdvKuMP3La7ZQNfoH5nW/viGy7cqjmXRpj6W4nJ1Gw/4K7yCwMjCP0A
 R5Rh62C/5uFFdJdVoEL563OzDjJctDc/itflodRcpFLDyFCX7ErbwNvveFBmA6LS/ooY
 bqm+qMRyHdaPaxYYzi9uroemRjvH8YRKguDlvty/xp//mIa+XiN/C99q/QDgfBovm9JT
 prq+m8Xctig3n1dBQPji/5oz7XE/SMfyO6u6w/qeWfK6oHJvTNatEkpPd3RZIfV7ex4m
 DQ4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5lDLR/5UE1LTw3pPrMCuqNNdLV7tMd39ddC9o79kBrcFLlICD1Tqbl6TGOGAW4iMHgdbZCng=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/G/niSbFE7GolJtkocZj7lT6rQ3oZ7UoUlHlRPNGCV/DgNL9s
 6Lo6ffGty2stkELphWxEUfU1aM8n//gmj/8H9Pm8OyAdNQnwk78EQowG19ixpKHb/8RuRQXzK0q
 WvU+KLZdt2qPSfiEOkLX1O9B5klE1BeObDj+p5g==
X-Gm-Gg: ASbGncsA6sXxeOyWiFjacqkifvMe0PsiYiBvXEuRKGjPD5lWxVF7sEhtPCJ/PTPLO2V
 WRQsyFKfBHSsW+V7K4E5pNyryQC6wlyxEI/U2ew==
X-Google-Smtp-Source: AGHT+IF2y5WqgoK4R8wUdQgzMKedG3etiY3Ns4zOFXP1BpdQ8O/ZXe/o/3mwAi/Rq3/CdPPywu0Lbxavjax3d036PmY=
X-Received: by 2002:a05:690c:25c3:b0:6ef:57ad:9d91 with SMTP id
 00721157ae682-6f279b3897amr17661567b3.24.1734090568414; Fri, 13 Dec 2024
 03:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20241213092032.28196-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241213092032.28196-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Dec 2024 13:48:52 +0200
Message-ID: <CAC_iWjKKFLxUYGpGyOy6uFquGXmbOTy49iFrio8dC9D14Z07_w@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: efidebug: update output of memory attributes
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

On Fri, 13 Dec 2024 at 11:20, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> * add EFI_MEMORY_CPU_CRYPTO, EFI_MEMORY_HOT_PLUGGABLE
> * correct output for EFI_MEMORY_XP
> * remove duplicate list entry for EFI_MEMORY_UC
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/efidebug.c | 5 +++--
>  include/efi.h  | 2 ++
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index 02f1e080e88..2461425e291 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -554,7 +554,6 @@ static const struct efi_mem_attrs {
>         const u64 bit;
>         const char *text;
>  } efi_mem_attrs[] = {
> -       {EFI_MEMORY_UC, "UC"},
>         {EFI_MEMORY_UC, "UC"},
>         {EFI_MEMORY_WC, "WC"},
>         {EFI_MEMORY_WT, "WT"},
> @@ -562,11 +561,13 @@ static const struct efi_mem_attrs {
>         {EFI_MEMORY_UCE, "UCE"},
>         {EFI_MEMORY_WP, "WP"},
>         {EFI_MEMORY_RP, "RP"},
> -       {EFI_MEMORY_XP, "WP"},
> +       {EFI_MEMORY_XP, "XP"},
>         {EFI_MEMORY_NV, "NV"},
>         {EFI_MEMORY_MORE_RELIABLE, "REL"},
>         {EFI_MEMORY_RO, "RO"},
>         {EFI_MEMORY_SP, "SP"},
> +       {EFI_MEMORY_CPU_CRYPTO, "CRYPT"},
> +       {EFI_MEMORY_HOT_PLUGGABLE, "HOTPL"},
>         {EFI_MEMORY_RUNTIME, "RT"},
>  };
>
> diff --git a/include/efi.h b/include/efi.h
> index c559fda3004..899160f1546 100644
> --- a/include/efi.h
> +++ b/include/efi.h
> @@ -266,6 +266,8 @@ enum efi_memory_type {
>  #define EFI_MEMORY_RO          ((u64)0x0000000000020000ULL)    /* read-only */
>  #define EFI_MEMORY_SP          ((u64)0x0000000000040000ULL)    /* specific-purpose memory (SPM) */
>  #define EFI_MEMORY_CPU_CRYPTO  ((u64)0x0000000000080000ULL)    /* cryptographically protectable */
> +#define EFI_MEMORY_HOT_PLUGGABLE \
> +                               ((u64)0x0000000000100000ULL)    /* hot pluggable */
>  #define EFI_MEMORY_RUNTIME     ((u64)0x8000000000000000ULL)    /* range requires runtime mapping */
>  #define EFI_MEM_DESC_VERSION   1
>
> --
> 2.45.2
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
