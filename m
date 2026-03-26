Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B364210AB825
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 20:40:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 333BB83E76;
	Thu, 26 Mar 2026 21:40:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XfI4A+jj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rw0/5yjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 544B283F14; Thu, 26 Mar 2026 21:40:23 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22A0480517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 21:40:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fhbJ45cnHz9ttR;
 Thu, 26 Mar 2026 21:40:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774557620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQwwX/YcqtR5W9sTBVN+J0Fo4ZiQtQEh2IaVsXA3vxo=;
 b=XfI4A+jj2DLvtrNh5TsWkZYy0DPblghAFC+jbilAdkj9AjaiGfxvcBAaCSle+9hcPCSlSM
 OSJabwz9SpzuAYXeYnzr/xWBmT7zcJPPGKh0cTo8Y4Czmb9S3J3Mv7r0+u+wYSh66sSoXo
 PWO4oS8zl+xj5K1zwCmTsLR82JXSYIuA1eTU8tUpjSD5j97OBE8jNoH0TOklrpCnVMfpw9
 7K8ssBbrLrFNaaDsyoQJ93knD/c8mB9zk74owTlOfoDmO5Chhxk9YaSQT62oGneJf1W+sw
 Bej14GezrVgjZfhndyddGn3TzqPxgFFcD9CRiOtF8U9qg2zoGxMyhWn+qveYRA==
Message-ID: <6f6f1fc8-56c5-405b-915f-269d789b43e3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774557619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQwwX/YcqtR5W9sTBVN+J0Fo4ZiQtQEh2IaVsXA3vxo=;
 b=rw0/5yjBwfg1225pSLFmCkem1KQLuNPmoiMG6VDnxvveG3OxS/I9CaJu1DGtbYLm6BY1sM
 Kf05SFUO3i5hEDlHdWZl6Zx/m49FuHw6IGDTUdZ3g7B1bPpWFuYaI86QjIsqDhQdwSF3De
 up1PayQh1pdBx1d77WvQHMiMVm2AW/WrBXAF9V81b81iKN6Ud2uiDUdvrjEfENu5W/FXqE
 atX7tj4eJhhhBZnnZ/mmO3fUE9V+PM3cxWU2YTIR3z+ozeEYJ86NRWkaqhlj8Aml/thano
 rZz0If1NUbo1O13Z0zaEi00KBM/8nGjBbFUl17PRtcOgw2NUeYN6EemkVxUxRw==
Date: Thu, 26 Mar 2026 13:58:35 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1 3/3] common: Allow relocations on the top of the last
 bank
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 marek.vasut+renesas@mailbox.org, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20260326115111.1631261-1-ilias.apalodimas@linaro.org>
 <20260326115111.1631261-4-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260326115111.1631261-4-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 8232e235af5b067697a
X-MBO-RS-META: xehht4ys9uny5hfx3nmqentn3kb3kdba
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

On 3/26/26 12:51 PM, Ilias Apalodimas wrote:
> Right now we only relocate u-boot to the top of the first
> memory bank unless the board specific code overwrites it.
> This is problematic when loading big binaries as it
> fragments the contiguous memory space for no apparent reason.
> 
> It's worth noting that there are cases where we must not relocate
> above the 4GB boundary (e.g 64bit hardware with 32bit only capable

GiB , non-SI unit .

> DMA).
> 
> Add a Kconfig option and allow the common code to relocate U-Boot
> to the top of the last discovered bank.

The commit message should really clarify the current pitfalls of 
enabling this symbol, including the part where ethernet transfers above 
4 GiB used to work because of the packet buffer built into U-Boot, and 
they will break because the buffer is now relocated above 4 GiB too.

> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes since RFC:
> - new patch
>   Kconfig          | 7 +++++++
>   common/board_f.c | 2 ++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/Kconfig b/Kconfig
> index ce25ea24a60f..b9144878ce0b 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -474,6 +474,13 @@ config SKIP_RELOCATE
>   	  Skips relocation of U-Boot allowing for systems that have extremely
>   	  limited RAM to run U-Boot.
>   
> +config RELOCATE_LAST_BANK
> +	bool "Relocate U-Boot to the top of the last memory bank"

You may want to call this "Relocate to the topmost memory address" or 
something along those lines, since "last bank" is a bit opaque.

> +	help
> +	  When U-Boot relocates, it chooses the end of the first memory bank.
> +	  Enable this if you have multiple banks and want U-Boot to relocate
> +	  to the top of the last available bank.
> +
>   endif # EXPERT
>   
>   config PHYS_64BIT
> diff --git a/common/board_f.c b/common/board_f.c
> index df2b0dc899bf..7c3fbeab17ec 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -321,6 +321,8 @@ __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   		 */
>   		return 0;
>   #endif
> +	if (IS_ENABLED(CONFIG_RELOCATE_LAST_BANK))
> +		fdtdec_setup_mem_ram_top();
Return value may need checking ?
