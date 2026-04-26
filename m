Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BAAFF885E
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 16:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A68183FDB;
	Sun, 26 Apr 2026 18:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SOBZH+U+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hzGo8eY0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CDC48407E; Sun, 26 Apr 2026 18:35:18 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFB07839D9
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 18:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g3XNy2TJwz9t5H;
 Sun, 26 Apr 2026 18:35:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777221314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnHfCxCQ+ogO2U9YSzi2sX/YIZaq3B3dgd15L/jmCDU=;
 b=SOBZH+U+QWMvMIra3MIq9dUhoD4C+1TkzhY/PI4b+4hJSTPKIy0BRiQQ7iw5lxoK/WH967
 YJmWF3yZmQ3nnrjkAv6beQgbSBtzVBwikiyTm0KCtJOcknph7qudTxs+yc4gdANHwjUdyv
 cY+TCK/B/Y0ZSucFOgrFrxyaOdSorsTfmBiJ/MZgYUHGzPljXcyome02hTVPbvD+Hq8+de
 xYv4UESiW8JhIyl5UPEXuo8QvXuwlGW1e7WXuYCm+gNs+V0S7cDBNryXcTKvQcDzPDfqO/
 vmDQ/Txz77wtAVC7jTXy4BrTu3Egb+gXAfrsU6KqbTN9gkfAM5GiI6+h6MilWQ==
Message-ID: <6944f28f-131f-4a08-9ef9-aae812926f4b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777221312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnHfCxCQ+ogO2U9YSzi2sX/YIZaq3B3dgd15L/jmCDU=;
 b=hzGo8eY0mDJwqgeibJ74L89ru7X1dIX+1a84iYT9ay+rhKHvNBVjsIjj5+44GcCJf/V8vd
 iJEI2aOmFr5+QlE+2sZrMvCwWupjlzTvb7JDWJdTV1PCoKSFENCBRVNHDNQtxBHP3LPJds
 7KXHu+7pRtsDTxQpWJjWArDXGkto6R6UJlYN8f9WhJteoflwfHy1E1Hivacvn2YLTClagG
 GU7yhC5iNOB9H91NOwfiEwemPDwNryEHXLKMgKgpe5Htk3g3kBIe3KKzAHru4PCPbpK9t3
 ALAxVtxht8Ujq7yfH4rgjbwLQoRp/IzSuEUG1vTqFNbqNdumS7N8DoO3wVzBPg==
Date: Sun, 26 Apr 2026 18:35:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 6/6] common: Add an option to relocate on ram top
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, u-boot@lists.denx.de
References: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
 <20260416055948.130041-7-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260416055948.130041-7-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 6db3uey8nz5m17moo6rawhzywpps57ng
X-MBO-RS-ID: 3681fafe126fd8c7496
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

On 4/16/26 7:59 AM, Ilias Apalodimas wrote:
> Right now we only relocate u-boot to the top of the first
> memory bank unless the board specific code overwrites it.
> This is problematic when loading big binaries as it
> fragments the contiguous memory space for no apparent reason.
> 
> It's worth noting that there are cases where we must not relocate
> above the 4GiB boundary (64bit hardware with 32bit only capable
> DMA). E.g This will break platforms, if the ethernet
> controller cannot DMA above 4 GiB, and once U-Boot does
> get relocated above 4 GiB, the packet buffer which is built
> into the U-Boot binary is also relocated above 4 GiB.

On certain platforms, it is currently not possible to relocate U-Boot 
above the 32bit boundary, due to various dependencies on content located 
below the 32bit boundary. One such example is ethernet, where the packet 
buffer built into U-Boot binary is placed below the 32bit boundary and 
allows loading of data via ethernet even above 32bit boundary due to 
memory copy from the packet buffer to the destination location.

> A previous patch moves the bi_dram[] info from bd to gd and make
> the memory bank information available early. So move the
> dram_init_banksize() INITCALL before the relocation address calculation
> and use it to derive the address.
> 
> Also add a Kconfig option and allow the common code to relocate U-Boot
> to the top of the last discovered bank.
> 
> Reviewed-by: Anshul Dalal <anshuld@ti.com>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   Kconfig          | 10 ++++++++++
>   common/board_f.c | 25 +++++++++++++++++++------
>   2 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/Kconfig b/Kconfig
> index 7f00e76ba786..63c273ca8c8f 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -491,6 +491,16 @@ config SKIP_RELOCATE_CODE_DATA_OFFSET
>   	  Offset of the read-write memory which contains data, from read-only
>   	  memory which contains executable text.
>   
> +config RELOC_ADDR_TOP
> +	bool "Relocate to the topmost memory address"
> +	depends on EXPERT
> +	help
> +	  When U-Boot relocates, it chooses the end of the first memory bank.
> +	  Enable this if you have multiple banks and want U-Boot to relocate
> +	  to the topmost memory address. This will use the information of the
> +	  board memory banks configured with dram_init_banksize().

... use the information ... to do what ?

> +	  Use this if you are certain all of the devices can DMA to high memory.

... can access memory above the 32bit boundary.

> +
>   endif # EXPERT
>   
>   config PHYS_64BIT
> diff --git a/common/board_f.c b/common/board_f.c
> index 4ac22dca9e7c..f95e789257ad 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -339,7 +339,22 @@ static int setup_ram_base(void)
>   static int setup_ram_config(void)
>   {
>   	debug("Monitor len: %08x\n", gd->mon_len);
> -#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
> +
> +	if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP)) {
> +		int bank;
> +		phys_size_t total_size = 0;
> +
> +		for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> +			if (gd->ram_top <= gd->bi_dram[bank].start)
> +				gd->ram_top = gd->bi_dram[bank].start +
> +						gd->bi_dram[bank].size;
> +			total_size += gd->bi_dram[bank].size;
> +		}
> +		gd->ram_size = total_size;

Shouldn't this also apply board_get_usable_ram_top() to be consistent ?

> +	} else {
> +		gd->ram_top = gd->ram_base + get_effective_memsize();
> +		gd->ram_top = board_get_usable_ram_top(gd->mon_len);

Should this really use gd->mon_len as a parameter, or gd->ram_top?

[...]
