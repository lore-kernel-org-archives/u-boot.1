Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9715CFED2F1
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 08:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF11383F00;
	Thu, 12 Mar 2026 09:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D/uuKluN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3661383F53; Thu, 12 Mar 2026 09:58:11 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DA4683DA6
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 09:58:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A15E042A3D;
 Thu, 12 Mar 2026 08:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD673C4CEF7;
 Thu, 12 Mar 2026 08:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773305886;
 bh=VBH1Lx9jU/sHDs9TYA79m0bNFsKu4Yy/tMvoGTg5We8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=D/uuKluNKyfuJTbC4F1PAh8QEa7udVU2RXWK0cyoj4ooLQUmVmDVzDMD6fIPj9bQ7
 mtWX83TxCtsC4+PK9tewBvhG+BxrX012QSU5Bj8uU84mahB0KG4QZ1iaFZJsxAV2IY
 VesNJ3JGnDzcKGdsWTlmVx+2KKk0ZwSDH2b1WgtTz0RRMYVxsZS4vFBDO5tobnlksT
 v3h5/shLeGK7zgPZ5tqPUljgrbqvfChedIrdj5JNT2TWn+Mqp1zirmtO4fsbAmLoMX
 lSsnf7H5e2xxN8JZcsd5fEMImZy+u0HZytRwuCZhWKfP3pPNC7BduPIVAgyEZd17ls
 qYXynIcOrqC6Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anshul Dalal <anshuld@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 trini@konsulko.com, lukma@denx.de, mkorpershoek@kernel.org
Cc: u-boot@lists.denx.de, srk@ti.com
Subject: Re: [PATCH] common: spl: spl_dfu.c: Fix warning associated with PCI
 subclass_code
In-Reply-To: <DGVFQRGRKPW4.3LLLZIHTKSFG2@ti.com>
References: <20260305103815.999886-1-s-vadapalli@ti.com>
 <DGVFQRGRKPW4.3LLLZIHTKSFG2@ti.com>
Date: Thu, 12 Mar 2026 09:58:03 +0100
Message-ID: <878qbxmnl0.fsf@kernel.org>
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

Hi Anshul,

On Fri, Mar 06, 2026 at 10:34, Anshul Dalal <anshuld@ti.com> wrote:

> On Thu Mar 5, 2026 at 4:08 PM IST, Siddharth Vadapalli wrote:
>> The subclass_code member of the pci_ep_header structure is a 1-byte
>> field. The macro PCI_CLASS_MEMORY_RAM is a concetation of baseclass_code
>> and subclass_code as follows:
>> 	PCI_BASE_CLASS_MEMORY: 0x05
>> 	Subclass Code for RAM: 0x00
>> 	PCI_CLASS_MEMORY_RAM:  0x0500
>> Hence, instead of extracting it via an implicity type conversion from int
>> to u8 which throws a warning, explicitly mask the bits to extract the
>> subclass_code.
>>
>> Fixes: cde77583cf0b ("spl: Add support for Device Firmware Upgrade (DFU) over PCIe")
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>
> I was able to reproduce the issue on am62x_evm_a53_defconfig with the
> following diff:
>
> 	diff --git a/arch/arm/mach-k3/include/mach/am62_spl.h b/arch/arm/mach-k3/include/mach/am62_spl.h
> 	index 2c9139d2cc0..07ae5e99e49 100644
> 	--- a/arch/arm/mach-k3/include/mach/am62_spl.h
> 	+++ b/arch/arm/mach-k3/include/mach/am62_spl.h
> 	@@ -12,6 +12,7 @@
> 	 #define BOOT_DEVICE_OSPI		0x01
> 	 #define BOOT_DEVICE_QSPI		0x02
> 	 #define BOOT_DEVICE_SPI			0x03
> 	+#define BOOT_DEVICE_PCIE			0x03
> 	 #define BOOT_DEVICE_CPGMAC		0x04
> 	 #define BOOT_DEVICE_ETHERNET_RGMII	0x04
> 	 #define BOOT_DEVICE_ETHERNET_RMII	0x05
> 	diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
> 	index 281fa3fea15..a828ad164f1 100644
> 	--- a/configs/am62x_evm_a53_defconfig
> 	+++ b/configs/am62x_evm_a53_defconfig
> 	@@ -1,4 +1,9 @@
> 	 CONFIG_ARM=y
> 	+CONFIG_SPL_PCI_DFU=y
> 	+CONFIG_SPL_PCI_ENDPOINT=y
> 	+CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS=0x0
> 	+CONFIG_SPL_PCI_DFU_VENDOR_ID=0x0
> 	+CONFIG_SPL_PCI_DFU_DEVICE_ID=0x0
> 	 CONFIG_ARCH_K3=y
> 	 CONFIG_SYS_MALLOC_F_LEN=0x8000
> 	 CONFIG_TI_COMMON_CMD_OPTIONS=y
>
> The patch looks good to me and fixes the build warning :)

Thanks for the diff. This was very helpful to me.
I could reproduce using the default toolchains that are provided by
buildman [1] which is ~/.buildman-toolchains/gcc-14.2.0-nolibc

[1] https://docs.u-boot.org/en/latest/build/buildman.html

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org> # am62x_evm_a53

Will apply for master.

>
> Tested-by: Anshul Dalal <anshuld@ti.com>
>
>> ---
>>
>> Hello,
>>
>> This patch is based on commit
>> f473a453b0c kbuild: Drop phandle from diff between base DT and U-Boot augmented DT if DEVICE_TREE_DEBUG=1of the master branch of U-Boot.
>>
>> Regards,
>> Siddharth.
>>
>>  common/spl/spl_dfu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/spl/spl_dfu.c b/common/spl/spl_dfu.c
>> index b09f82790c9..7d21bb4d16a 100644
>> --- a/common/spl/spl_dfu.c
>> +++ b/common/spl/spl_dfu.c
>> @@ -64,7 +64,7 @@ static int dfu_over_pcie(void)
>>  	hdr.deviceid = CONFIG_SPL_PCI_DFU_DEVICE_ID;
>>  	hdr.vendorid = CONFIG_SPL_PCI_DFU_VENDOR_ID;
>>  	hdr.baseclass_code = PCI_BASE_CLASS_MEMORY;
>> -	hdr.subclass_code = PCI_CLASS_MEMORY_RAM;
>> +	hdr.subclass_code = PCI_CLASS_MEMORY_RAM & 0xff;
>>  
>>  	ret = pci_ep_write_header(dev, fn, &hdr);
>>  	if (ret) {
