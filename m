Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F5AC021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 10:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8F8E81120;
	Thu, 27 Feb 2025 11:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740652767;
	bh=phpfpOxeWmRUDFUHf/63T8HlZdqcqaXOpK7BXoVtghU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s8taYIC5ZLmz/4XwZJPVAspqcmK0uw3iA0dcRQtnOdt6JZcD6Ns7PLj6CyrE2Mzh7
	 v6tbmpmHNKuNUlkVWC9mzDoqQXmc+vmiAV4/hTEMB0Yi7/xlEGbtEwGhYGCJm1UkiI
	 uth9Jzz9BvTxNMhpr3oWQ2plGWrKJ9EqYKRb5qxrtRFTR4RvNW7qsy5tPQjLgVeUEF
	 DtvdTbep2ZPRwdyYC7DUNJ+KYvsq0w5g/fBg0TpUpm4taBGY1b7JD9ODX1zDNX7nr4
	 GXlmcDZy5FgVcAkrJDiTbYXHjqH6pIc9UaB/QrfaX1o+yjcJwcqRcPWA/phQ8dxxI3
	 +2OzoFZyL0eUQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5137881197; Thu, 27 Feb 2025 11:39:26 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 633A180F12
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 11:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4Z3SWZ1SR0z9tvR;
 Thu, 27 Feb 2025 11:39:22 +0100 (CET)
Message-ID: <321ec33b-3117-4c46-83bc-e2bbb7d8efcb@denx.de>
Date: Thu, 27 Feb 2025 11:39:21 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] mvebu: armada-8k: set fdtfile env from
 DEFAULT_FDT_FILE
To: Josua Mayer <josua@solid-run.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250209-cn9130-board-v1-0-b94ab83e141b@solid-run.com>
 <20250209-cn9130-board-v1-2-b94ab83e141b@solid-run.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250209-cn9130-board-v1-2-b94ab83e141b@solid-run.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Z3SWZ1SR0z9tvR
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

On 09.02.25 21:23, Josua Mayer wrote:
> Developers find themselves with two options for defining the default
> device-tree for a platform:
> 
> 1. CONFIG_DEFAULT_DEVICE_TREE deciding which DT the u-boot build will
>     use for itself.
> 2. CONFIG_DEFAULT_FDT_FILE deciding what should be the name of the
>     actual device-tree file, when booting an OS.
> 
> Armada 8k config file used option 1 while adding a marvell/ directory
> prefix. This causes issues when switching a board to CONFIG_OF_UPSTREAM
> where the marvell/ prefix would be added twice.
> 
> Update the header file to set fdtfile variable instead from
> CONFIG_DEFAULT_FDT_FILE. This allows clear separation between
> device-tree for U-Boot and OS.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   include/configs/mvebu_armada-8k.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/configs/mvebu_armada-8k.h b/include/configs/mvebu_armada-8k.h
> index 6fedbe9ee386269533852ecc07667e77b11e83d6..cf2e92cf125576f6033a142b7ea40ccb19c92919 100644
> --- a/include/configs/mvebu_armada-8k.h
> +++ b/include/configs/mvebu_armada-8k.h
> @@ -50,7 +50,7 @@
>   	"fdt_addr_r=0x6f00000\0"	\
>   	"kernel_addr_r=0x7000000\0"	\
>   	"ramdisk_addr_r=0xa000000\0"	\
> -	"fdtfile=marvell/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
> +	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
>   	BOOTENV
>   
>   #endif /* _CONFIG_MVEBU_ARMADA_8K_H */
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

