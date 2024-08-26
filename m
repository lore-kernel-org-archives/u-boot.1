Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67474C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 14:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86C3088955;
	Mon, 26 Aug 2024 16:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ceEgfzpn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F195588955; Mon, 26 Aug 2024 16:36:07 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8703E884DB
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 16:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7c1324be8easo3668243a12.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724682964; x=1725287764; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kzWNb1aa6kPrQyx0USXdEjYSyY0PuFb+DCyiUXXTTFw=;
 b=ceEgfzpnCEWK8bau1+P7SBvgbN4aQIBTLjxhb9lAX2e26rninrCNAF+EkOUFPclfuf
 skK7kmM58bjXg+PpdrnXDBRUtMprUTDwcvrbj6YaYY+7d8hoe4QR3CQUyvrfJO+g/lc4
 NFFb3ZmQ/Lp9u2s1hDhotwLvGMCtNC/anvaNKrR8SBZTZqKmExyjsfuvvoAq2Fo6f2iO
 FVnXGJnRpQzRyLVihBgpxdSj4xnnt08WheNhskr5Dj8Uk5yvviLbDzmvLhiUmrZ439F0
 SOOuisZ3KFegqvFlGMoAbwJJhO0+mcWrP3HUq2tiN5IXd7x5uCq8OfM79ZdxeELCzjlJ
 LEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724682964; x=1725287764;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kzWNb1aa6kPrQyx0USXdEjYSyY0PuFb+DCyiUXXTTFw=;
 b=iNLg6ZmXZto97cnao0YT8qO+1r7UJFBq8MVW7wEFhy65bUMp2BDE4PQcUB9kjeH1o0
 8hRJmlkL6XTPsbMilMw2hBDMp5VS3KryPxq+7/oTW/aSMBaLOwdnLlGGgVvvUbB2T2fV
 odCll9Iri48i28zPlJ87NZES3UGId14Kfp7uglCVjRTCCIEn71NZcVc5bIfROQtTKrkk
 ITIDsp7/KTNIp1AxQxuJ+k5IOBaqWSSLZ6+t1EOdT3YwljuPa6M8pLE2eJCbFm2xC0jK
 qldtMfXPPenb9o+MTpqNHu45zQ3lp9bqvnHgTX4/rfoqlDktbvt0HToy/cy7lCK2e3p+
 klTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS/m0mP6vXSJcllqYx0dE+HsOCtgzEe7eryGgHnScioEYeAikNNuXEaPrNtpa80mP4IwPJ6Gk=@lists.denx.de
X-Gm-Message-State: AOJu0Yzh2HGaxhCHOzr3qkTf/X7ph8INe3XQH8/jnGEVke3XJGFjPQZg
 xoEc3/EIkQgbyT+Rg/CCTgsvVzZy6mta1i1AkAtc2CADOnP5t6B8HKZXlTDq67S0LhaDVi3NtRS
 G2AH6xvx5g25Q7vUjnPIUt7vQK0LZ+kcYBEO7Xw==
X-Google-Smtp-Source: AGHT+IFQSTChj4Tr0t2OxtJferqfeMF0e90aB8kfrq89u4WDrrvRpBbF93BOeSBMHAcSPxla+eA2uOxdl4KFw9VBb7E=
X-Received: by 2002:a17:903:298e:b0:204:d4a6:c68b with SMTP id
 d9443c01a7336-204d4a6c799mr27471345ad.16.1724682963745; Mon, 26 Aug 2024
 07:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
 <20240809-b4-dynamic-uuid-v7-6-8c44ab1f06a5@linaro.org>
In-Reply-To: <20240809-b4-dynamic-uuid-v7-6-8c44ab1f06a5@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Aug 2024 17:35:27 +0300
Message-ID: <CAC_iWjLDPFd3FSOF9VzHGWY3cWTv4KQKHzxJEiogXtOy1tT6qA@mail.gmail.com>
Subject: Re: [PATCH v7 06/11] lib: uuid: supporting building as part of host
 tools
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

On Fri, 9 Aug 2024 at 03:56, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Adjust the UUID library code so that it can be compiled as part of a
> host tool.
>
> This removes the one redundant log_debug() call, as well as the
> incorrectly defined LOG_CATEGORY.
>
> In general this is a fairly trivial change, just adjusting includes and
> disabling list_guid.
>
> This will be used by a new genguid tool to generate v5 GUIDs that match
> those generated by U-Boot at runtime.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  include/uuid.h |  4 ++--
>  lib/uuid.c     | 44 ++++++++++++++++++++++++++++++--------------
>  2 files changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/include/uuid.h b/include/uuid.h
> index 1f4fa103b5e9..7f8414dc906c 100644
> --- a/include/uuid.h
> +++ b/include/uuid.h
> @@ -69,10 +69,10 @@ struct uuid {
>  } __packed;
>
>  /* Bits of a bitmask specifying the output format for GUIDs */
>  #define UUID_STR_FORMAT_STD    0
> -#define UUID_STR_FORMAT_GUID   BIT(0)
> -#define UUID_STR_UPPER_CASE    BIT(1)
> +#define UUID_STR_FORMAT_GUID   0x1
> +#define UUID_STR_UPPER_CASE    0x2
>
>  /* Use UUID_STR_LEN + 1 for string space */
>  #define UUID_STR_LEN           36
>  #define UUID_BIN_LEN           sizeof(struct uuid)
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 24b5881600fd..84277cf67ece 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -6,25 +6,38 @@
>   * Authors:
>   *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>   */
>
> -#define LOG_CATEGOT LOGC_CORE
> -
> +#ifndef USE_HOSTCC
>  #include <command.h>
>  #include <efi_api.h>
>  #include <env.h>
>  #include <rand.h>
>  #include <time.h>
> -#include <uuid.h>
> -#include <linux/ctype.h>
> -#include <errno.h>
>  #include <asm/io.h>
>  #include <part_efi.h>
>  #include <malloc.h>
>  #include <dm/uclass.h>
>  #include <rng.h>
> +#include <linux/ctype.h>
> +#include <hexdump.h>
> +#else
> +#include <stdarg.h>
> +#include <stdint.h>
> +#include <eficapsule.h>
> +#include <ctype.h>
> +#endif
> +#include <linux/types.h>
> +#include <errno.h>
> +#include <linux/kconfig.h>
> +#include <uuid.h>
>  #include <u-boot/sha1.h>
>
> +#ifdef USE_HOSTCC
> +/* polyfill hextoul to avoid pulling in strto.c */
> +#define hextoul(cp, endp) strtoul(cp, endp, 16)
> +#endif
> +
>  int uuid_str_valid(const char *uuid)
>  {
>         int i, valid;
>
> @@ -51,8 +64,9 @@ int uuid_str_valid(const char *uuid)
>  static const struct {
>         const char *string;
>         efi_guid_t guid;
>  } list_guid[] = {
> +#ifndef USE_HOSTCC
>  #ifdef CONFIG_PARTITION_TYPE_GUID
>         {"system",      PARTITION_SYSTEM_GUID},
>         {"mbr",         LEGACY_MBR_PARTITION_GUID},
>         {"msft",        PARTITION_MSFT_RESERVED_GUID},
> @@ -231,8 +245,9 @@ static const struct {
>         { "EFI_MEMORY_TYPE", EFI_MEMORY_TYPE },
>         { "EFI_MEM_STATUS_CODE_REC", EFI_MEM_STATUS_CODE_REC },
>         { "EFI_GUID_EFI_ACPI1", EFI_GUID_EFI_ACPI1 },
>  #endif
> +#endif /* !USE_HOSTCC */
>  };
>
>  int uuid_guid_get_bin(const char *guid_str, unsigned char *guid_bin)
>  {
> @@ -266,9 +281,8 @@ int uuid_str_to_bin(const char *uuid_str, unsigned char *uuid_bin,
>         uint32_t tmp32;
>         uint64_t tmp64;
>
>         if (!uuid_str_valid(uuid_str)) {
> -               log_debug("not valid\n");
>  #ifdef CONFIG_PARTITION_TYPE_GUID
>                 if (!uuid_guid_get_bin(uuid_str, uuid_bin))
>                         return 0;
>  #endif
> @@ -297,19 +311,19 @@ int uuid_str_to_bin(const char *uuid_str, unsigned char *uuid_bin,
>
>         tmp16 = cpu_to_be16(hextoul(uuid_str + 19, NULL));
>         memcpy(uuid_bin + 8, &tmp16, 2);
>
> -       tmp64 = cpu_to_be64(simple_strtoull(uuid_str + 24, NULL, 16));
> +       tmp64 = cpu_to_be64(hextoul(uuid_str + 24, NULL));
>         memcpy(uuid_bin + 10, (char *)&tmp64 + 2, 6);
>
>         return 0;
>  }
>
>  int uuid_str_to_le_bin(const char *uuid_str, unsigned char *uuid_bin)
>  {
> -       u16 tmp16;
> -       u32 tmp32;
> -       u64 tmp64;
> +       uint16_t tmp16;
> +       uint32_t tmp32;
> +       uint64_t tmp64;
>
>         if (!uuid_str_valid(uuid_str) || !uuid_bin)
>                 return -EINVAL;
>
> @@ -324,22 +338,22 @@ int uuid_str_to_le_bin(const char *uuid_str, unsigned char *uuid_bin)
>
>         tmp16 = cpu_to_le16(hextoul(uuid_str + 19, NULL));
>         memcpy(uuid_bin + 8, &tmp16, 2);
>
> -       tmp64 = cpu_to_le64(simple_strtoull(uuid_str + 24, NULL, 16));
> +       tmp64 = cpu_to_le64(hextoul(uuid_str + 24, NULL));
>         memcpy(uuid_bin + 10, &tmp64, 6);
>
>         return 0;
>  }
>
>  void uuid_bin_to_str(const unsigned char *uuid_bin, char *uuid_str,
>                      int str_format)
>  {
> -       const u8 uuid_char_order[UUID_BIN_LEN] = {0, 1, 2, 3, 4, 5, 6, 7, 8,
> +       const uint8_t uuid_char_order[UUID_BIN_LEN] = {0, 1, 2, 3, 4, 5, 6, 7, 8,
>                                                   9, 10, 11, 12, 13, 14, 15};
> -       const u8 guid_char_order[UUID_BIN_LEN] = {3, 2, 1, 0, 5, 4, 7, 6, 8,
> +       const uint8_t guid_char_order[UUID_BIN_LEN] = {3, 2, 1, 0, 5, 4, 7, 6, 8,
>                                                   9, 10, 11, 12, 13, 14, 15};
> -       const u8 *char_order;
> +       const uint8_t *char_order;
>         const char *format;
>         int i;
>
>         /*
> @@ -418,8 +432,9 @@ void gen_v5_guid(const struct uuid *namespace, struct efi_guid *guid, ...)
>         tmp16 = (uint16_t *)&guid->b[6];
>         *tmp16 = cpu_to_le16(be16_to_cpu(*tmp16));
>  }
>
> +#ifndef USE_HOSTCC
>  #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
>  void gen_rand_uuid(unsigned char *uuid_bin)
>  {
>         u32 ptr[4];
> @@ -501,4 +516,5 @@ U_BOOT_CMD(guid, CONFIG_SYS_MAXARGS, 1, do_uuid,
>            "e.g. guid guid_env"
>  );
>  #endif /* CONFIG_CMD_UUID */
>  #endif /* CONFIG_RANDOM_UUID || CONFIG_CMD_UUID */
> +#endif /* !USE_HOSTCC */
>
> --
> 2.46.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
