Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D415D0E6DB
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 13:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8FC98405F;
	Tue, 25 Nov 2025 14:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bmpSnWYI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA8A184057; Tue, 25 Nov 2025 14:02:40 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E94F28405B
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 14:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dG2sd4y7Jz9sqj;
 Tue, 25 Nov 2025 14:02:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764075749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8AbJDEl3uIlNbkeaY6Sxlwy5j/0bprv0s+/yA0qLKqE=;
 b=bmpSnWYI1wKfq0C1Gz5INjcU8NB8IFLn8Y4zfa26iXb9UUkbwvveN1UhO3W6tnFDhViVbE
 IVfQYcsHi1RXFucvdkxm/qBt3cq8EAEuQL/FCWHi/cpo+m6P6+y/TPdWdzgpiJQsf85vdO
 XS109mMDM+WlPnU/97VY0jPdnzN3LExVJ31SkdEREyZ+KwzPCLpkpNzX/33Q/sOoO2HjML
 kY8j3BMXXcejE1eeUimu3hdf+rd1Q7nN1FxGuckyzzDyDfA/HJQKxgwpOw3DIYeaKuz0RU
 kzHp69Mfpfs2XCSRP+baC4Mq6b/VBOziRsiHxxgqCRa5mAa8KaLiw+TGjORXAw==
Message-ID: <e5af0e26-6b84-4321-bb26-c6848d233f4a@mailbox.org>
Date: Tue, 25 Nov 2025 13:20:49 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
 loading of U-Boot from SPL
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 512637ad38c08e54645
X-MBO-RS-META: weo7j5htxroix7x77ynpdnrar3by4nq8
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

On 11/14/25 6:13 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> If U-Boot is located on MMC, SPL and U-Boot proper are glued together.
> More precisely, SPL is stored 4 times. Take this and its padding into
> account and adjust sector number via board_spl_mmc_get_uboot_raw_sector.
> This allows loading from a partition, without the need to hard-code the
> offset via SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   arch/arm/mach-socfpga/board.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
> index 28554b7a109..d756f7381fb 100644
> --- a/arch/arm/mach-socfpga/board.c
> +++ b/arch/arm/mach-socfpga/board.c
> @@ -14,6 +14,7 @@
>   #include <hang.h>
>   #include <handoff.h>
>   #include <image.h>
> +#include <spl.h>
>   #include <usb.h>
>   #include <usb/dwc2_udc.h>
>   #include <asm/global_data.h>
> @@ -209,3 +210,11 @@ void lmb_arch_add_memory(void)
>   	}
>   }
>   #endif
> +
> +#ifdef CONFIG_SPL
> +unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
> +						 unsigned long raw_sect)
> +{
> +	return (CONFIG_SPL_PAD_TO * 4) / 512 + raw_sect;
Please add a comment whether this is offset within a partition or within 
a raw block device.

Also, I see the long discussion thread, maybe it would be good to point 
out which commit exactly broken the DE0 board.
