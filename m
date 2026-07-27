Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B6BC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:32:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DBE340644;
	Mon, 27 Jul 2026 08:32:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7AM5WFkBWagO; Mon, 27 Jul 2026 08:32:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6254B404E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785141127;
	bh=6UyLPj/hjNgoQQ2rLdMqA08wnSTTyyXq0gJakfxrB/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CPwfA+XGVoDUNdqBmet5YmYMgIMrf1kvB2+DArPQDKRRJhP4LF/LM6D0LWOYXWQBF
	 fFN54sRjPHkLnf+yM+YgGsfeR5d6EU6Mv0LCWYep03OGDHATbobroiPlh7n6wke07p
	 F6p69LoPWGPHV6itsH66X4x8AR2Dmx0P8kQHXG0LM4K97p3y8gZUdiOZGgWQdhyr7A
	 +Lbpd1EyTbbYR8Hstw70vmI0n8puqDsukhmsonb1cfHC88srWnf0Ux57NmwLvwXoBu
	 lz8Tc/ce3csFcFNFBrGX3rQuvpi82LI7vybz6yHSg0WJJiF+K+Lr5rkUrTgLAtE0zt
	 wIMRv2Vs47WlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6254B404E7;
	Mon, 27 Jul 2026 08:32:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D33A45B
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:32:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3EBB0400F3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:32:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mCHiJvpft3xd for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:32:05 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D40924005F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D40924005F
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D40924005F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:32:04 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2A4D84671; Mon, 27 Jul 2026 10:32:01 +0200 (CEST)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 322A982991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 10:31:59 +0200 (CEST)
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6611669cd16so2994914d50.0
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 01:31:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785141118; cv=none;
 d=google.com; s=arc-20260327;
 b=q9kAo7tYKbCZB58cjZx5RPUmWLyA4CuWtYJ1NBABk+LoIzmleeQytfPklNuTNqUzmr
 oPXrfBsxcQPnXm0EeI0zh696huUhkNNmZiOm9Jftn+8t8Pv+lf+o6/sSEmqd8tCZ0M9D
 873S1gag/6DkCVGi1oaZ5Sb1ixER+orD7Y95Q5ohS02GR5JKjd2vxQbqBCzQp2FPUo4O
 CRBpfP7swmCwLbr87ecm2mP8P/H4xg3GYmzufaJ/fR0ABJcojQAxm/1gcF1xBLXEhupC
 C55Umag8BjftqZd2kW86V0gGm9Bbm9xegchiJ92o5XbEjkwoEW/NClJ1VaWQWt1EKH2t
 WItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=G/1eR+nx2DM/x8GbDbzlp7Q3ihlWmwkiZwUlueorusw=;
 fh=FSxL+jN78k26ORP9jf6DsvfZ47USyfVvNOv8WEzo2g4=;
 b=Zhy4N2CtixhCMsaHVja+WzPzqWWsvIk6yQ38/YruCyGfM7n8BXtSrnZNNJhTy5Nxt/
 ko/zTDc6Mtu1ENNxSCopf1bhCFSzJLpB50/oYBG/WSm8dndyNpaJUX9D70vvL6GlI3Xl
 +SKMLYtYVQttwmmzwi7vPiJEOh9lRrF/+rvOR2viAdHA5I6623t+Gm40byC61gUxUs5+
 Rf0QBswnoLqdsgfDVBhMC6AK0XoT49AsWDz5BQfo0OhnncBG34s6SRyubggdogbGW9FY
 Dys5Ub6BZxk3xzgdnJIzo3/DLKtrIU8MrrGXqHyd6g7zhoYiZocY8WnltItHbPRfa1iM
 IcwQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785141118; x=1785745918;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=G/1eR+nx2DM/x8GbDbzlp7Q3ihlWmwkiZwUlueorusw=;
 b=avsXu2iOWOOCJIbhclIO3y4Pa7zA4SQ0ZU55YX3WQCzR0R9BZn2tbXWmAziPzvZXXA
 EB+vrunnH9xE7F7o+l9IQpgdmcVY2A7wsOOPHoy0PXk4hDGzd4pidEKTCuqYbcXu0SU0
 9mRoGp3locUVvh4wZlEQDxr52D1yqisIKCGAlTj2UvcK/E1toIG/VkVX54wkySZCdBuF
 vJqPli6Yc5aMTSVDvLJjq5595/epopmPamlYPBvHx9FpAa3U9jyCeYlKd/W0mWA2nF8V
 R8AAusFoA2yf4PwFNN0IvuSklUKbZx317fifqt6K2RWQ9g0eZdmJTTrp61YaUk3Z7Fg8
 5ozQ==
X-Gm-Message-State: AOJu0YzjqevmAmIJFbbiw3OetuAZQwxL2rsc0NkwCRczHRDSRXHwIHXY
 2oXtnVvcVX2ALw2Ny4IGx4DHkQRyi/GaxIQ9MxysQOw6Ramt7IV+Uigc+ulJpe/rGztcG2kqReD
 2ZwuoEbBuZYyGyXWb3laaA6zhOV7BExYBWQPmOAX6Gg==
X-Gm-Gg: AR+sD10mlOjV5rMRbZ2PE7oNTqBkMyzmxStsMqpUe9VvRdSGVsa6xVBzbrJio2bVyo5
 BWQzGO+Dd28DSeuO77jKqPjLwppVNMzhNI7TiZ2sy171vSZO+2AtH/PQwNpE1z6pkWALPB+vqVl
 kToBku9TIRnsove94kS5I6lxnqLt3KSEtyPTdKNWZ1VAOIM6yn+IfS1MEBcIQ7cpmxwMpTFLGOk
 5NeTydbKBSgpF3eeed+R6MjbWOe5cIrljgBgqA33VijBneI8fmTpSm6ORVlupz7vHPRw0AuRZSW
 9DKBuAuGYDH4a+DvECJUipMNr+QghBHXp/cs+JcQ2rQCVQXRHvpagCad/1WteIQ8y5P14wqYMX0
 AaMlVEWCS+QdO+ECgOOQz9mNMEHtjATLTZ4YSyXPf1kxWrCGLLh3mmgb2pRlu4dipcfQqYtKGjx
 ZN1EMs0oAfQv7v5aDjGhMhquIimBFsMUvWIik4mci9gZ0MoAfpbc+VGNMChrvPtw/c5aAindM3o
 tRCacefeuKsbQKmmo+rohJ7QXjCazF5Nw8Iif/opbiKgHkodccD0F373C7vFCrKh7X8Qqnv+Hvy
 g+Vxg95i8K4InsTL9Z709kp+AHhWVwm0UDu574MfV+M6mGmBKSKpPX2cmsH9+dVnAd4awoI=
X-Received: by 2002:a05:690e:b86:b0:664:ea4b:d1f7 with SMTP id
 956f58d0204a3-668c7a100d1mr2506211d50.42.1785141117722; Mon, 27 Jul 2026
 01:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260711091559.1842381-1-aristo.chen@canonical.com>
 <20260724092720.3533-1-aristo.chen@canonical.com>
 <20260724092720.3533-3-aristo.chen@canonical.com>
In-Reply-To: <20260724092720.3533-3-aristo.chen@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 Jul 2026 11:31:22 +0300
X-Gm-Features: AUfX_my117MpuLsRxY8r2x7kQJ8ESDSel-FGDePKzlKSd-ezOBv_j0gs2FJsFXs
Message-ID: <CAC_iWjK+qeG2AYMHdAP6_5TsmdHKaW=A6O4gj6oDd354aR80GQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi: Print ISA-specific and unknown memory
 attributes
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785141118; x=1785745918; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G/1eR+nx2DM/x8GbDbzlp7Q3ihlWmwkiZwUlueorusw=;
 b=FhmE02leAUgt4CPEF2p027Ni5cp2wy850yGPbZ+wszPW7Zgfud3vPp9N8NKvWTFmei
 BharhyQe3MMBkh3O2BjzSPwX4XxjXb7pz6txCPdY4PuFUBGHZP8/CKENE3TxWQuHU0jl
 iVojsh61T0XemcEipcETOko+CYuJg34K7An0fxYkstrEee4knynSCHrLISYdooJW95OE
 fp0DI/CTwc/9MT7mfzQNOjjAztqE+kH9u7k0dMGOD/FlEL4cJKI+9/5ZCIceUwRhdb9u
 DqQPeKurJRtr2Ttl5ZWAoOpVTodcKYtcEiNZzN61uVQZp+jDiroqdb8qF8BhD49UrCqQ
 BVFQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FhmE02le
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ilias.apalodimas@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="FhmE02le"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, 24 Jul 2026 at 12:40, Aristo Chen <aristo.chen@canonical.com> wrote:

> The attribute mnemonic table did not cover EFI_MEMORY_ISA_VALID and the
> EFI_MEMORY_ISA_MASK field, and attribute bits without a mnemonic were
> silently dropped, so a memory map carrying ISA-specific, invalid or not
> yet known attributes displayed incomplete information without any hint
> that something was missing.
>
> Add a mnemonic for EFI_MEMORY_ISA_VALID and print the ISA-specific
> field as ISA=<value> when it is valid, instead of decoding bits whose
> meaning U-Boot cannot know. Any remaining bits that match neither the
> mnemonic table nor the ISA field are printed as a hexadecimal value.
>
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


> Changes in v2:
> - New patch, addressing Heinrich's question about invalid bits and
>   EFI_MEMORY_ISA_VALID/EFI_MEMORY_ISA_MASK
>
>  cmd/efi_common.c      | 20 ++++++++++++++++++--
>  doc/usage/cmd/efi.rst |  5 ++++-
>  include/efi.h         |  7 ++++++-
>  3 files changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/cmd/efi_common.c b/cmd/efi_common.c
> index 904747c5b32..e57835d3bae 100644
> --- a/cmd/efi_common.c
> +++ b/cmd/efi_common.c
> @@ -58,6 +58,7 @@ static const struct efi_mem_attrs {
>         {EFI_MEMORY_SP, "SP"},
>         {EFI_MEMORY_CPU_CRYPTO, "CRYPT"},
>         {EFI_MEMORY_HOT_PLUGGABLE, "HOTPL"},
> +       {EFI_MEMORY_ISA_VALID, "ISA_VALID"},
>         {EFI_MEMORY_RUNTIME, "RT"},
>  };
>
> @@ -91,13 +92,16 @@ static const char *efi_mem_type_name(u32 type)
>   * efi_print_mem_attrs() - print the names of set EFI memory attributes
>   *
>   * Prints the set attribute bits as a '|'-separated list of mnemonics,
> - * e.g. ' UC|WB|RT', preceded by a space. Prints nothing if no known
> - * attribute bit is set.
> + * e.g. ' UC|WB|RT', preceded by a space. When EFI_MEMORY_ISA_VALID is
> + * set, the EFI_MEMORY_ISA_MASK field is printed as ISA=<value>. Bits
> + * that have no mnemonic are printed as a hexadecimal value so that
> + * invalid or not yet known attributes are never dropped silently.
>   *
>   * @attributes: memory attributes (EFI_MEMORY_...)
>   */
>  static void efi_print_mem_attrs(u64 attributes)
>  {
> +       u64 unknown = attributes;
>         int sep, i;
>
>         for (sep = 0, i = 0; i < ARRAY_SIZE(efi_mem_attrs); i++)
> @@ -109,7 +113,19 @@ static void efi_print_mem_attrs(u64 attributes)
>                                 sep = 1;
>                         }
>                         puts(efi_mem_attrs[i].text);
> +                       unknown &= ~efi_mem_attrs[i].bit;
>                 }
> +
> +       if (attributes & EFI_MEMORY_ISA_VALID) {
> +               printf("%sISA=0x%llx", sep ? "|" : " ",
> +                      (attributes & EFI_MEMORY_ISA_MASK) >>
> +                      EFI_MEMORY_ISA_SHIFT);
> +               sep = 1;
> +               unknown &= ~EFI_MEMORY_ISA_MASK;
> +       }
> +
> +       if (unknown)
> +               printf("%s0x%llx", sep ? "|" : " ", unknown);
>  }
>
>  void efi_show_memmap(struct efi_mem_desc *map, efi_uintn_t map_size,
> diff --git a/doc/usage/cmd/efi.rst b/doc/usage/cmd/efi.rst
> index 3ccdbe9410c..62a2638feca 100644
> --- a/doc/usage/cmd/efi.rst
> +++ b/doc/usage/cmd/efi.rst
> @@ -45,7 +45,10 @@ Start, End
>
>  Attributes
>      The attributes of the region as a '|'-separated list of mnemonics,
> -    e.g. UC for EFI_MEMORY_UC and RT for EFI_MEMORY_RUNTIME.
> +    e.g. UC for EFI_MEMORY_UC and RT for EFI_MEMORY_RUNTIME. When the
> +    region carries ISA-specific attributes (EFI_MEMORY_ISA_VALID is set),
> +    the ISA-specific field is shown as ISA=<value>. Attribute bits without
> +    a mnemonic are shown as a hexadecimal value.
>
>  efi tables
>  ~~~~~~~~~~
> diff --git a/include/efi.h b/include/efi.h
> index 71234d1b6fe..a4c21d7681d 100644
> --- a/include/efi.h
> +++ b/include/efi.h
> @@ -268,6 +268,9 @@ enum efi_memory_type {
>  #define EFI_MEMORY_CPU_CRYPTO  ((u64)0x0000000000080000ULL)    /*
> cryptographically protectable */
>  #define EFI_MEMORY_HOT_PLUGGABLE \
>                                 ((u64)0x0000000000100000ULL)    /* hot
> pluggable */
> +#define EFI_MEMORY_ISA_MASK    ((u64)0x0FFFF00000000000ULL)    /*
> ISA-specific attributes */
> +#define EFI_MEMORY_ISA_SHIFT   44
> +#define EFI_MEMORY_ISA_VALID   ((u64)0x4000000000000000ULL)    /*
> ISA_MASK field is valid */
>  #define EFI_MEMORY_RUNTIME     ((u64)0x8000000000000000ULL)    /* range
> requires runtime mapping */
>  #define EFI_MEM_DESC_VERSION   1
>
> @@ -686,7 +689,9 @@ void efi_show_tables(struct efi_system_table *systab);
>   *
>   * Prints one line per descriptor with the memory type name, the physical
>   * start and end address and the attributes as a '|'-separated list of
> - * mnemonics.
> + * mnemonics. The ISA-specific attribute field is printed as ISA=<value>
> + * when EFI_MEMORY_ISA_VALID is set, and any remaining bits without a
> + * mnemonic are printed as a hexadecimal value.
>   *
>   * The virtual addresses of the descriptors are not shown: the map is
>   * identity mapped before SetVirtualAddressMap() is called, so the field
> --
> 2.43.0
>
>
