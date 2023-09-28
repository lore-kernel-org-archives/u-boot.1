Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A501CE7B1F
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 19:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B826864AA;
	Thu, 28 Sep 2023 21:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="r/Nc2HiC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F19258655F; Thu, 28 Sep 2023 21:18:36 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98DC48634D
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 21:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dba8=FN=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1695928700;
 bh=bJN/RRnQdXQ4sPpi6ywl8XrSBexYGlNDqSFGuLQRrpo=;
 b=r/Nc2HiCTgsWo17amgWlblTjzBBjr9zJtTQkgTupP5u3JoHuIJh3e5c24K3RS59jkWfpBUach
 XB3+m5K2Uv1QYVwCGpMXA3l8c2PkzdG5YKlyiZw7CKVWPTeR9KkIDpCq2irpSHymfc0QokwRD72
 1JngD/53P2awEeXIKQESqIYQBGyyulr7/i7ceuwWMGRSZ0ViMm/Q0KEE64tpQh9sxeSzw2jUV5T
 ciipMxXhV6LXyZRRXEVNkbkCf9eJXRArQmhvcUaKMugLZV4w+sSp7n/2lMr7otsbwmqMGq2dReW
 5pSP9Pj2KriK1wMafgW+V1b98j6UqbW8oOWRKWvDSLIw==
Message-ID: <6087c770-4802-5c2f-322a-18eab9940a1e@kwiboo.se>
Date: Thu, 28 Sep 2023 21:18:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] dm: core: Report bootph-pre-ram/sram node as pre-reloc
 after relocation : regression
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, Simon Glass <sjg@chromium.org>, Tom
 Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>, "Andrew F. Davis"
 <afd@ti.com>, "Berard, Brian" <bberard@ti.com>
References: <20230820220316.3517102-1-jonas@kwiboo.se>
 <05a3d9d4-cdcd-4145-aece-727f14a7efb3@kernel.org>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <05a3d9d4-cdcd-4145-aece-727f14a7efb3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6515d17c63d269bceef458e8
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

Hi Roger,

On 2023-09-28 14:59, Roger Quadros wrote:
> Hi,
> 
> On 21/08/2023 01:03, Jonas Karlman wrote:
>> Nodes with bootph-pre-sram/ram props are bound in multiple phases:
>> 1. At TPL (bootph-pre-sram) or SPL (bootph-pre-ram) phase
>> 2. At U-Boot proper pre-relocation phase
>> 3. At U-Boot proper normal phase
>>
>> However the binding and U-Boot Driver Model documentation indicate that
>> only nodes marked with bootph-all or bootph-some-ram should be bound in
>> the U-Boot proper pre-relocation phase.
>>
>> Change ofnode_pre_reloc to report a node with bootph-pre-ram/sram prop
>> with a pre-reloc status only after U-Boot proper pre-relocation phase.
>> Also update the ofnode_pre_reloc documentation to closer reflect the
>> binding and driver model documentation.
>>
>> This changes behavior of what nodes are bound in the U-Boot proper
>> pre-relocation phase. Change to bootph-all or add bootph-some-ram prop
>> to restore prior behavior.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>> Changes in v2:
>> - Drop use of !! to convert into bool
>> - Update documentation for ofnode_pre_reloc
>> - Rewrite commit message
>> - Collect r-b tag
> 
> This patch breaks boot on AM642-EVM. Boot log at the end.

From what I can tell your board use a lot of bootph-pre-ram.
https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/k3-am642-evm-u-boot.dtsi

What happens if you change to bootph-all or add bootph-some-ram next to
bootph-pre-ram on devices that is also needed in U-Boot proper
pre-relocation phase in addition to SPL phase?

Regards,
Jonas

> 
>>
>>  drivers/core/ofnode.c | 2 +-
>>  include/dm/ofnode.h   | 8 ++++----
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
>> index 8df16e56af5c..b1e94b2d60df 100644
>> --- a/drivers/core/ofnode.c
>> +++ b/drivers/core/ofnode.c
>> @@ -1353,7 +1353,7 @@ bool ofnode_pre_reloc(ofnode node)
>>  	 */
>>  	if (ofnode_read_bool(node, "bootph-pre-ram") ||
>>  	    ofnode_read_bool(node, "bootph-pre-sram"))
>> -		return true;
>> +		return gd->flags & GD_FLG_RELOC;
>>  
>>  	if (IS_ENABLED(CONFIG_OF_TAG_MIGRATE)) {
>>  		/* detect and handle old tags */
>> diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
>> index 0f38b3e736de..13700f8266d7 100644
>> --- a/include/dm/ofnode.h
>> +++ b/include/dm/ofnode.h
>> @@ -1198,15 +1198,15 @@ int ofnode_read_simple_size_cells(ofnode node);
>>   * determine if a node was bound in one of SPL/TPL stages.
>>   *
>>   * There are 4 settings currently in use
>> - * - bootph-some-ram: U-Boot proper pre-relocation only
>> + * - bootph-some-ram: U-Boot proper pre-relocation phase
>>   * - bootph-all: all phases
>>   * Existing platforms only use it to indicate nodes needed in
>>   * SPL. Should probably be replaced by bootph-pre-ram for new platforms.
>> - * - bootph-pre-ram: SPL and U-Boot pre-relocation
>> - * - bootph-pre-sram: TPL and U-Boot pre-relocation
>> + * - bootph-pre-ram: SPL phase
>> + * - bootph-pre-sram: TPL phase
>>   *
>>   * @node: node to check
>> - * Return: true if node is needed in SPL/TL, false otherwise
>> + * Return: true if node should be or was bound, false otherwise
>>   */
>>  bool ofnode_pre_reloc(ofnode node);
>>  
> 
> ---boot log---
> 
> U-Boot SPL 2023.10-rc4-00480-g9e644284ab (Sep 28 2023 - 15:53:09 +0300)
> Resetting on cold boot to workaround ErrataID:i2331
> Please resend tiboot3.bin in case of UART/DFU boot
> resetting ...
> 
> U-Boot SPL 2023.10-rc4-00480-g9e644284ab (Sep 28 2023 - 15:53:09 +0300)
> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
> SPL initial stack usage: 13408 bytes
> Trying to boot from MMC2
> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> Loading Environment from MMC... *** Warning - No MMC card found, using default environment
> 
> Starting ATF on ARM64 core...
> 
> NOTICE:  BL31: v2.8(release):v2.8-226-g2fcd408bb3-dirty
> NOTICE:  BL31: Built : 00:42:57, Jan 13 2023
> I/TC: 
> I/TC: OP-TEE version: 3.20.0 (gcc version 11.3.0 (GCC)) #1 Fri Jan 20 15:42:54 UTC 2023 aarch64
> I/TC: WARNING: This OP-TEE configuration might be insecure!
> I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.html
> I/TC: Primary CPU initializing
> I/TC: SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
> I/TC: HUK Initialized
> I/TC: Activated SA2UL device
> I/TC: Fixing SA2UL firewall owner for GP device
> I/TC: Enabled firewalls for SA2UL TRNG device
> I/TC: SA2UL TRNG initialized
> I/TC: SA2UL Drivers initialized
> I/TC: Primary CPU switching to normal world boot
> 
> U-Boot SPL 2023.10-rc4-00480-g9e644284ab (Sep 28 2023 - 15:54:37 +0300)
> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
> Trying to boot from MMC2
> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> 
> ---boot log end---
> 
> we expect U-Boot banner to be printed next but nothing is printed.
> 

