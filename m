Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0F9F30956
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 13:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4175C8382A;
	Thu,  5 Mar 2026 14:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="trOmGHHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7A7E839A8; Thu,  5 Mar 2026 14:08:37 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D56C981E18
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 14:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 544DA61340;
 Thu,  5 Mar 2026 13:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8692EC116C6;
 Thu,  5 Mar 2026 13:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772716113;
 bh=JYs9VmaDmj301rTuk4BsC2Q7Ha4fjctxCUGlaAeWkfY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=trOmGHHq6t6/GHAF/AXHekgJfQ4ZZzhCnH2/RNOn4oWgYl16i/11hFQG8vMfGgXBB
 haMTXQTxQVUYQLGmQXs4H/0bxRj7wH64Us0I4ohzX/l1E0KwOIFyHTpE8Jt07oCo3y
 FvOjKqUcECgoJGtkgtlPlA2MvSF6GPPVUNtAWSd3Vpjnl5dKgzaM7bdWaFUWNZf7X9
 p/ZSftBh6H56cNDVPSAHcIS411pCLHi8TLW8kOf76SLb4hRoMVCvRW/pWeTpvzJ0iG
 WH7W4DWVUjl4C2mZLYq+sduggd8KL7KYUrHpgSppkqxiaG5HBeYnA5YB7wa2AwjF3B
 GFU3X+eMrqBpA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com,
 lukma@denx.de, mkorpershoek@kernel.org
Cc: u-boot@lists.denx.de, srk@ti.com, s-vadapalli@ti.com
Subject: Re: [PATCH] common: spl: spl_dfu.c: Fix warning associated with PCI
 subclass_code
In-Reply-To: <20260305103815.999886-1-s-vadapalli@ti.com>
References: <20260305103815.999886-1-s-vadapalli@ti.com>
Date: Thu, 05 Mar 2026 14:08:30 +0100
Message-ID: <87h5qumnjl.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Siddharth,

Thank you for the patch.

On Thu, Mar 05, 2026 at 16:08, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:

> The subclass_code member of the pci_ep_header structure is a 1-byte
> field. The macro PCI_CLASS_MEMORY_RAM is a concetation of baseclass_code
> and subclass_code as follows:
> 	PCI_BASE_CLASS_MEMORY: 0x05
> 	Subclass Code for RAM: 0x00
> 	PCI_CLASS_MEMORY_RAM:  0x0500
> Hence, instead of extracting it via an implicity type conversion from int
> to u8 which throws a warning, explicitly mask the bits to extract the

What's the exact warning string? With which compiler version?

Is there an example defconfig that I can use to reproduce this?

Thanks
Mattijs

> subclass_code.
>
> Fixes: cde77583cf0b ("spl: Add support for Device Firmware Upgrade (DFU) over PCIe")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>
> Hello,
>
> This patch is based on commit
> f473a453b0c kbuild: Drop phandle from diff between base DT and U-Boot augmented DT if DEVICE_TREE_DEBUG=1of the master branch of U-Boot.
>
> Regards,
> Siddharth.
>
>  common/spl/spl_dfu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/spl/spl_dfu.c b/common/spl/spl_dfu.c
> index b09f82790c9..7d21bb4d16a 100644
> --- a/common/spl/spl_dfu.c
> +++ b/common/spl/spl_dfu.c
> @@ -64,7 +64,7 @@ static int dfu_over_pcie(void)
>  	hdr.deviceid = CONFIG_SPL_PCI_DFU_DEVICE_ID;
>  	hdr.vendorid = CONFIG_SPL_PCI_DFU_VENDOR_ID;
>  	hdr.baseclass_code = PCI_BASE_CLASS_MEMORY;
> -	hdr.subclass_code = PCI_CLASS_MEMORY_RAM;
> +	hdr.subclass_code = PCI_CLASS_MEMORY_RAM & 0xff;
>  
>  	ret = pci_ep_write_header(dev, fn, &hdr);
>  	if (ret) {
> -- 
> 2.51.1
