Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B38606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fXbKan79;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOJRbDKS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D156060A4C;
	Thu, 26 Nov 2026 12:43:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VP-msTPA72go; Thu, 26 Nov 2026 12:43:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 178E860A4E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795697038;
	b=OL8MnvHhjZtkuOMgb9bGAdQYEvAFYEIUfoRONZE9PkZmoQG3AXD9xJjrOl4LKZzFji2j
	 lUuWQVCQFP7PV6tmHCZ+scXbqxA2SfBVUEg+KXPvzdX9453qW5oacgn9adkZQq8YJD9Dr
	 2a9PN1d4YNSS12eeKi70FXtYkYJHs084q714687hp9swAnqj7K36kN8jTzaDQjCUzCjuz
	 wGfJPU0LX0vHC7OrgYpOtQHzaPHwvHtyqBGkJtqdum5dAIBtg8U2anBRI/QdcwvuoMuNI
	 i7iswcKXZFoaLOQ2i+AoZUAVDJLTt7mfxEMHWdo+1dkrrRkbvoXQp/PnO7zlfGBxh5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795697038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UQ/FSK5BwXTo8IoEynsOXRoNPvOj33J7G10zMQTz7Jw=;
	b=ZW5cB0FdqOfxkxqKelvSU66M2wcaxgB5+0hysCspHWpY/9kUMXT/B3/H4Vl+uQsDg3DG
	 Wuf+GkFrJTd6hDFUNZbPpPc+3xhs1qv8AY0adY15HU18BvPEu4XkIVPGSUCOLudLstRgy
	 bf84FNqRmR6BGXWjdW5pazAkQPU7qYvSTOrksQ51PrwL8oGmH6usoF4GbQa0G3AmgUwqW
	 +8pVNXHKi3YAS9AjgM3JzQpH19IrMPOt62X6JB9Fu6r99HHIvwf0SzXNjbYsCEsdqbpiv
	 SLjlmlfCnSBTEyiBTnVlk89MzN7zBuZXYdXFAVAF+Zyob6LP9fT4JTVHbOcCQONzFtQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795697038;
	bh=UQ/FSK5BwXTo8IoEynsOXRoNPvOj33J7G10zMQTz7Jw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fXbKan79m3Rmh0MtYoITTH5QgrgiQy0NapGZf4YC07xrhvQBEKck3ikXtgWSBpYdO
	 aQP1I/NsL1M9QXanYj5I5rX8OqyT7+kpYvuW9k2/Hga+evPY5giglGxNLUInSKa+oZ
	 fNStkQgoDBvdo1CwPyASomBrfRmwiORchBp4nK9qKQH+h6e52uDWq2XdKRbqPTi+FZ
	 Ppm39e88HykISed0j6pqw1+afJc83q3ri5Z6qdJcZpqZgET9f+qZfL95ErYeyhSwV0
	 EByRGOFFYjEG0vB8pfgA69exkGv1+84n5tABP2gIzX69/kK0huyntztXH1G5xJrMSj
	 IG4OFIlxBx2Rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 178E860A4E;
	Thu, 26 Nov 2026 12:43:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A9AC032D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:43:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F4D940913
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:43:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l-yXqGcI4Lel for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:43:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E538B4090E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=mOJRbDKS
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E538B4090E
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:43:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E92F447EE;
 Thu, 26 Nov 2026 12:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB11D1F000D2;
 Thu, 26 Nov 2026 12:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795697034;
 bh=UQ/FSK5BwXTo8IoEynsOXRoNPvOj33J7G10zMQTz7Jw=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=mOJRbDKS5RAVFYgzrdR77oStWjQFvB2S8KySCf2aXfRsYmxs4dFrUc6F7e2Z0yyD/
 uPFVIzG5gFdvKWWw/gHdYmv78RzIq9DWu9bKs/JjCelbL65+Y8EHfCzwp0Xor157Lj
 1Mn/xmRD8r0L8q/Gk0UtsO4zRtgjX20Z6YENGB5/D6d6MBOZ+kJIQoPGkhYkOBP+3/
 XxGpqNhuO5I1gO2CmdC2AVpzHMXPyzXyYeWXv3cISJXJF/uxPGfUXy7OSkBzgUH9GL
 B4yQYwi30lPLLq3XvO36BYcUQkbhhhhRkoqY0B80J3WQQ5R4vYKK2Hv42HrGnVqalY
 Jhj+xt1LupmuA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RESEND v1] mach-snapdragon: raise block cache limit to
 cache full GPT table
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 Michael.Srba@seznam.cz, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261013094310.2408439-1-aswin.murugan@oss.qualcomm.com>
References: <20261013094310.2408439-1-aswin.murugan@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 18:13:48 +0530
Message-Id: <179569702870.130558.983878136582109162.b4-reply@b4>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-13 15:13 +0530, Aswin Murugan wrote:
> From: Aswin Murugan via U-Boot <u-boot@lists.u-boot-project.org>
> 
> part_get_info() calls find_valid_gpt() -> alloc_read_gpt_entries(),
> which re-reads the entire GPT partition entry array from disk on
> every call once per partition while looking up each partition
> during boot.
> 
> This happens because blkcache_fill() skips caching reads larger than
> max_blocks_per_entry (default: 8 blocks/4KiB), and the GPT entry
> array is bigger than that, so it never gets cached and every call
> triggers a fresh eMMC read.
> 
> Raise the per-entry block-cache limit to cover the full GPT table
> (computed from CONFIG_EFI_PARTITION_ENTRIES_NUMBERS) so it is cached
> after the first read, turning subsequent GPT entry reads into cache
> hits and avoiding redundant eMMC accesses.
> 
> Improves boot time by ~800ms on eMMC based devices.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/board.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 87adb100edd..b87e5ce0e89 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -11,16 +11,19 @@
>  #define pr_fmt(fmt) "QCOM: " fmt
>  
>  #include <asm/psci.h>
> +#include <blk.h>
>  #include <dm/ofnode.h>
>  #include <env.h>
>  #include <fdt_support.h>
>  #include <init.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/errno.h>
> +#include <linux/kernel.h>
>  #include <linux/psci.h>
>  #include <linux/sizes.h>
>  #include <lmb.h>
>  #include <malloc.h>
> +#include <part.h>
>  #include <soc/qcom/smem.h>
>  #include <sort.h>
>  #include <time.h>
> @@ -30,6 +33,12 @@
>  enum qcom_boot_source qcom_boot_source __section(".data") = 0;
>  enum qcom_memmap_source qcom_memmap_source __section(".data") = 0;
>  
> +/* Number of 512-byte blocks needed to hold the full GPT entry array (entries * entry size) */
> +#define GPT_PTE_SECTOR_SIZE	512
> +#define GPT_PTE_BLOCKS \
> +	DIV_ROUND_UP(CONFIG_EFI_PARTITION_ENTRIES_NUMBERS * GPT_ENTRY_SIZE, \

Not sure if relying on EFI configs here is the right thing to do since
this will be used in non-EFI configurations as well. Can you generalize
it?

-Sumit

> +		     GPT_PTE_SECTOR_SIZE)
> +
>  #if CONFIG_IS_ENABLED(SYSRESET_PSCI)
>  static void show_psci_version(void)
>  {
> @@ -153,6 +162,15 @@ int board_init(void)
>  {
>  #if CONFIG_IS_ENABLED(SYSRESET_PSCI)
>  	show_psci_version();
> +#endif
> +	/*
> +	 * Default cache only covers 8 blocks, too small for the GPT
> +	 * partition-entry array, so it's never cached and gets re-read
> +	 * and CRC-checked on every part_get_info() call. Raise the limit
> +	 * to cache it after the first read.
> +	 */
> +#if CONFIG_IS_ENABLED(BLOCK_CACHE)
> +	blkcache_configure(GPT_PTE_BLOCKS, 32);
>  #endif
>  	qcom_board_init();
>  	return 0;
> -- 
> 2.34.1
> 
> 


