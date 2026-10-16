Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD8ACCA464
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 12:38:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88873607FF;
	Fri, 16 Oct 2026 12:38:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nVU8_tD8W8rm; Fri, 16 Oct 2026 12:38:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A18A2607E7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792154309;
	b=QLIxBi4nKfc11x9UHYRtq2LSd2HJn6HN2bg5W6JQaTVnZY6zyyF4j2qb8L1c2lDz1VPO
	 t8IrgiIFbHeispW/lXQymjH/D4yz0SVkA1dz77uJigUXhKtLZWqCD0tYF/qHm8icmYOA2
	 trjxRY92He7tbkIK/dCgi+8beTOebt0iOPLq1BgbsM2qD8Efi/UoMnuSek43bzmzmPTG9
	 8n5RXHwnChm/ek9Ng2ZDHPDwA5ciQCDDgrNoRUog32ehThEU84jrSPv9sKh4T6BF7vf4z
	 1PJd+mPDHmVH45erl8zBBDXX/Im/DOJxQzBx4Sk/zUGceOu51WXUUEhG8dQRkZtDALA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792154309;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XQaAZY/yZZ7NYrjsvBk0WbPCAXVJVxCTv8UjgXeti8g=;
	b=ZDKMZ7914TB4HD5aHtl5FA7hJdyAH8rqTxwEJNNuRWxc2RixV2oTmsIL3s3acVzirT14
	 2fXp4LFNRCv1KJcZ2xkRod+DV4lvABb91JFiux1YgrrDYmyzNfyWtW+VTtNbzW0HBGy1i
	 AEHL0FCWHKrjTYqbAytZPiiAsqJBnlRTZL2a/f/dt76oAWpIu/WTDv3MBBuv+DuzOaDW+
	 YHNI6GlZeImVeYkYWHBQrUgnEmjyLAkYEZHvFP/9Rx0sjwwYPhnEK6Btn61NOI4l6dvt9
	 sxtwXeko72LP+nUpzoGzEnuewvUTEoiP/2jA2lHnTeu3fFXvk1A9UVSkIPKWNkz8Fgw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792154309;
	bh=XQaAZY/yZZ7NYrjsvBk0WbPCAXVJVxCTv8UjgXeti8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AvpmoseYp1QGoRpCrR0QKUAz+kgkpgDXG33BBMKXATPjauVfyiOK4vOkpZf512Y0E
	 +g7hG22rV71h1SK74roPfuORQaV2DhTx52KbU3NsfRBWIvqi36ySIPb4n1ezscdTDi
	 9LNeppsrtbGOtphaLNAJ/oCvyOoKFlr8OmM+CDn4HckysA6aNOtMKwFLSxGibeAv0x
	 7izxOcGnVzmbl6FErHXS3nfaV3JzU7NgCTlTK78/3tl5qn3bY918GCmxLvjp/PWO4A
	 TwP2YEeRZsGtJMM0Saes9f9mBEZAbmqC9nPpzPECxQ9ccHE4xbDB6mErrq4y7v6WfP
	 0fKM59Mqr9wNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A18A2607E7;
	Fri, 16 Oct 2026 12:38:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A07C8769
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:38:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 929164016D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:38:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JlQBJjmjqZVL for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 12:38:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EB54B4016B
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792154308;
 b=NhmIFa+BhqJDVKjCKr2XLhdEZzCeX4BIg3nOXLZit2nQJ67EnC1BmdaJLYXrffaaE8WB
 gO4WBpCGwl7bMWNAocBecx/UYO+9vdYTZ4frJPfc2JpllPnPFvsvpegWGRIuRo9EbyLC3
 a/G1qzBypf3pb9HPuZWI/of27RwkNwtjc/H4k/SoDWD2e60HJ8XGr8Qkd+1ul8ZrenD9d
 oLxC6wt3QZlZ6zyWfxB/6yiV+x92IFDSKCEPad1BtY3l5s4Q7QdrcRcSbisK9SZVvUE3L
 J4HqUKBe5ZPANTuqm+9wW0zcD/VSot2CH4SGAKNXtxgSCkn424cWYUpFbGz/ZGBiyKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792154308;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=XQaAZY/yZZ7NYrjsvBk0WbPCAXVJVxCTv8UjgXeti8g=;
 b=lIeR2U0vzGwijJNNPz/nC17qdjkb/09f2Yx7wrjPJyiMyIx64LviLcUvzxKkU1aOhY5w
 F0mII3ka9R+H54a/HAlXCUdwteFpsZV934pT55Atx9HAvldi3CihOfrpJ+LFyJ2vKK8sN
 JnClOscZPdaPKfFULOnRVbjAJUja8py/FB2SRx6bTbK4/H9fdrOjc2zO8QGQJ6Ygfv2FJ
 8dNiBaYXskgL/5lCzuOseETnJ8VGF/HKLMAtp+V2x+AsBMhqY0BXzgKsuqkNo9zBNsQTp
 ZSmCJtY8WAKOEDM0RlOF5mLOCS0sqJRT69P+mNPDtZ2crmIVHLuXLw/fk1Pb7S1V/zQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="b9n/Tlgt"; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=b9n/Tlgt
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB54B4016B
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:38:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F09540C4D;
 Fri, 16 Oct 2026 12:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1301F000C4;
 Fri, 16 Oct 2026 12:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792154306;
 bh=XQaAZY/yZZ7NYrjsvBk0WbPCAXVJVxCTv8UjgXeti8g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=b9n/TlgtRgLtVMzC52vP2ZU6uvGq8gUHNvoAqbGPwoHK0+D+I/YnwgBbTbtehe+I4
 29kt0WqPK2uvM6lXCC1xxU6Kp7WHVqxVJ8nnQRo73Ag1Es86cpD6VoaFhk7O0LKMfa
 WtKRiinx3gGXv/JdGT70InXsFP376uRQSZdNJENW7FKBZ6LuY05Z99fM+ddDX/t0/L
 6JO9LcxOxzU9kU20gIfdupW361CAVCwY/DHsfTVWuckSXJVgEUBdDoj1CbSizRFuhR
 nNFWuDvxEnwT+Nmcz8te1wXtuXBYgo7K79ZPRhNN5Cg6cIKuM/I1TFsFHQU0ej09p5
 ndmYj1XHkjT+Q==
Date: Fri, 16 Oct 2026 18:08:20 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, Michael.Srba@seznam.cz,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH RESEND v1] mach-snapdragon: raise block cache limit to
 cache full GPT table
Message-ID: <atIavP8ucOMC-LN7@sumit-xelite>
References: <20261013094310.2408439-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261013094310.2408439-1-aswin.murugan@oss.qualcomm.com>
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

On Tue, 13 Oct 2026 at 15:13:10 +0530, Aswin Murugan wrote:
>From: Aswin Murugan via U-Boot <u-boot@lists.u-boot-project.org>
>
>part_get_info() calls find_valid_gpt() -> alloc_read_gpt_entries(),
>which re-reads the entire GPT partition entry array from disk on
>every call once per partition while looking up each partition
>during boot.
>
>This happens because blkcache_fill() skips caching reads larger than
>max_blocks_per_entry (default: 8 blocks/4KiB), and the GPT entry
>array is bigger than that, so it never gets cached and every call
>triggers a fresh eMMC read.
>
>Raise the per-entry block-cache limit to cover the full GPT table
>(computed from CONFIG_EFI_PARTITION_ENTRIES_NUMBERS) so it is cached
>after the first read, turning subsequent GPT entry reads into cache
>hits and avoiding redundant eMMC accesses.
>
>Improves boot time by ~800ms on eMMC based devices.
>
>Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>---
> arch/arm/mach-snapdragon/board.c | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
>
>diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
>index 87adb100edd..b87e5ce0e89 100644
>--- a/arch/arm/mach-snapdragon/board.c
>+++ b/arch/arm/mach-snapdragon/board.c
>@@ -11,16 +11,19 @@
> #define pr_fmt(fmt) "QCOM: " fmt
>
> #include <asm/psci.h>
>+#include <blk.h>
> #include <dm/ofnode.h>
> #include <env.h>
> #include <fdt_support.h>
> #include <init.h>
> #include <linux/arm-smccc.h>
> #include <linux/errno.h>
>+#include <linux/kernel.h>
> #include <linux/psci.h>
> #include <linux/sizes.h>
> #include <lmb.h>
> #include <malloc.h>
>+#include <part.h>
> #include <soc/qcom/smem.h>
> #include <sort.h>
> #include <time.h>
>@@ -30,6 +33,12 @@
> enum qcom_boot_source qcom_boot_source __section(".data") = 0;
> enum qcom_memmap_source qcom_memmap_source __section(".data") = 0;
>
>+/* Number of 512-byte blocks needed to hold the full GPT entry array (entries * entry size) */
>+#define GPT_PTE_SECTOR_SIZE	512
>+#define GPT_PTE_BLOCKS \
>+	DIV_ROUND_UP(CONFIG_EFI_PARTITION_ENTRIES_NUMBERS * GPT_ENTRY_SIZE, \
>+		     GPT_PTE_SECTOR_SIZE)
>+
> #if CONFIG_IS_ENABLED(SYSRESET_PSCI)

This PSCI change is irrelavent to this commit, if needed propose a
separate commit.

-Sumit

> static void show_psci_version(void)
> {
>@@ -153,6 +162,15 @@ int board_init(void)
> {
> #if CONFIG_IS_ENABLED(SYSRESET_PSCI)
> 	show_psci_version();
>+#endif
>+	/*
>+	 * Default cache only covers 8 blocks, too small for the GPT
>+	 * partition-entry array, so it's never cached and gets re-read
>+	 * and CRC-checked on every part_get_info() call. Raise the limit
>+	 * to cache it after the first read.
>+	 */
>+#if CONFIG_IS_ENABLED(BLOCK_CACHE)
>+	blkcache_configure(GPT_PTE_BLOCKS, 32);
> #endif
> 	qcom_board_init();
> 	return 0;
>-- 
>2.34.1
>
