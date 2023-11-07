Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA65C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 09:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06ADA871A6;
	Tue,  7 Nov 2023 10:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=mupuf.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12EEF8715B; Tue,  7 Nov 2023 10:47:16 +0100 (CET)
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com
 [IPv6:2a0c:5a00:149::26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E75A871A6
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 10:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=mupuf.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martin.roukala@mupuf.org
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
 by mailtransmit05.runbox.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <martin.roukala@mupuf.org>)
 id 1r0Ifu-00Cpcv-92; Tue, 07 Nov 2023 10:47:10 +0100
Received: from [10.9.9.74] (helo=submission03.runbox)
 by mailtransmit03.runbox with esmtp (Exim 4.86_2)
 (envelope-from <martin.roukala@mupuf.org>)
 id 1r0Ift-0003n2-8i; Tue, 07 Nov 2023 10:47:09 +0100
Received: by submission03.runbox with esmtpsa [Authenticated ID (1057822)]
 (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.93) id 1r0Ifg-00DxUX-CS; Tue, 07 Nov 2023 10:46:56 +0100
Message-ID: <f27831c4-3ba8-4f81-89fb-256c3f0f77fa@mupuf.org>
Date: Tue, 7 Nov 2023 11:45:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3588-rock-5b: Enable CONFIG_PCI_INIT_R to
 support EFI networking
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>
Cc: Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
References: <20231104130451.111020-1-martin.roukala@mupuf.org>
 <ef28a2eb-131c-4b43-b048-f8af3160ddbb@kwiboo.se>
From: Martin Roukala <martin.roukala@mupuf.org>
In-Reply-To: <ef28a2eb-131c-4b43-b048-f8af3160ddbb@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Jonas,

On 06/11/2023 20:15, Jonas Karlman wrote:
> Hi Martin,
> 
> On 2023-11-04 14:04, Martin Roukala (né Peres) wrote:
>> When u-boot chainloads an EFI bootloader such as iPXE, we want to have
>> already initialized the PCI subsystem so that network driver is loaded
>> and ready to use by the bootloader.
> 
> This change slows down boot from emmc/sd-card where scanning for pci
> devices typically is unnecessary.

True.

> 
> If pci must be initialized and scanned before an EFI app is started to
> find pci network controllers, then pci should probably be initialized by
> the efi bootmeth, not by enabling CONFIG_PCI_INIT_R for a single board.

Unfortunately, it isn't that simple. I am chainloading iPXE immediately, 
so we never end up calling bootmeth... and so iPXE fails to find any NIC 
because u-boot did not initialize the PCI subsystem.

IMO, the defconfig should work in all situations. If someone wants to 
speed up their use case, they are free to disable the features they 
don't need.

A generic solution may be for u-boot to start probing the PCI bus when 
asked to enumerate the NICs through SNP by the EFI binary... but until 
this is done, the defaults should just work.

Regards,
Martin

> 
> Regards,
> Jonas
> 
>>
>> Fixes: 191ece249a96 ("rockchip: rk3588-rock-5b: Enable support for PCIe SATA cards")
>> Signed-off-by: Martin Roukala (né Peres) <martin.roukala@mupuf.org>
>> ---
>>   configs/rock5b-rk3588_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
>> index 0595325e81..938137c851 100644
>> --- a/configs/rock5b-rk3588_defconfig
>> +++ b/configs/rock5b-rk3588_defconfig
>> @@ -36,6 +36,7 @@ CONFIG_OF_BOARD_SETUP=y
>>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5b.dtb"
>>   # CONFIG_DISPLAY_CPUINFO is not set
>>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>> +CONFIG_PCI_INIT_R=y
>>   CONFIG_SPL_MAX_SIZE=0x40000
>>   CONFIG_SPL_PAD_TO=0x7f8000
>>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> 
