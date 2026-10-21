Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B7D606A31D
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EkB/dRzP;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=BUCQXlzO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62DD7810E8;
	Wed, 21 Oct 2026 14:36:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id apJ6IOG3ZVnv; Wed, 21 Oct 2026 14:36:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C1C5881155
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792593369;
	b=kTWTgPM213xp7WuSqvYputAud/ITqBHbN+EpORyexsyvy6PnxGHYBc+30RHreKn4Glww
	 +u+zVIwq6M5flAYv0Fdqq4ZyzJEJ0bsjPlHeEeFwl+M/3z9nO8HXJH4U//6Z9Q0lfBYui
	 LhwzGIUauuQ3NtvSkEOLy5NI2lLdEzZ481+cjMvY/e6uxeVAE6Wn95PcXjlrKSdOK2t8w
	 RUgKLgpuWC/AxLpkXTHqjBt+zfHYw3C3yS9k0ExWPTeikiw1HEmWXIR9/qAiJZEaXfgap
	 zbO5Fgif7bCIpNeartytfJkepH51BwKnNLttcMHybtwl4qVuaB7IYkPLNZgxbR5Dqrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792593369;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mrNCvTJhrk6GmKFWJb7y8riBpo8i4BMSWHkX70RUDTQ=;
	b=aPGHhYRhU6ErJu04bjf7LHpKGwr/7qccI9VdbcDtfkc1Pu8SMHnslZaio0jv64CdLDCa
	 vwliONWBdsiltutyU6dFNF0ayEraeilL6QvYwpUwnYs9VutkEz9rNxMxO8AxdfXp4ah4J
	 nEMKLJqxfP55pAjNV114rdGIiGZ4D/Lx7RJV0KvxjviI5pUND0YoOSP+C41HwUCIMK2Lx
	 Ws/PtDWpqheLw8ykEPINS+Z+H9GZ7rBjHT0FJiErwRDsQM0Viacg/vGv6JHWDhfWAov3t
	 MuIvzIfmIjPY+v5qbXWmeE+eYPY3NQkJrp315h7C7BE2U+guCfKi+LtpQ0krptmWiAA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792593368;
	bh=mrNCvTJhrk6GmKFWJb7y8riBpo8i4BMSWHkX70RUDTQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EkB/dRzPiDaQUBpYw8NGqJkrqXnOjf/nDcUV9gjKa8bFhw8b+3bLnR7H6KKCpTSEn
	 y/lxmuwILXXLgHrolnUp1OrV2RcUy8pLXHyfnBxISn7EtPodRBvRnHidkhVKMk0/39
	 wKsC4PLh16bQ8Vab+C1xSPyV7/3deMsOMs6+W1DbaCgQPeB3UCLbO8izVyM5C8lcqd
	 H+JyXbEN05XV1QIAwbVLmOAqz0haTC/StHcJ/1xKJfk7OVB55soz0hm3I5uLyrdS+w
	 e2ZsgbWss2E3gHjkZXtWGABiSbmaspUisrNQ4HdaIus/BL62uR/213hw0VXlcTyre1
	 WA82WleJWaR3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1C5881155;
	Wed, 21 Oct 2026 14:36:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 09B043A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E34BC408B3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:36:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8mGO0G5PJWyb for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 14:36:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 86C2F408CC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792593366;
 b=VnNmoHmKNDITcuH+z2nltj/WmAdzRIZ7SqJSqAYt26QZ8wfwuZuZLa2tb3OXwz+xeEhI
 cX3yZeteZzmTozIq03ycH1VPVJZaYxKA69FUvWfYUDpht79+AesmiBB80N0RMW7tXG0+1
 iSj2qHZRyvepWEIyI8p7kdB4FTZDsDDtpTCFsSo7TJZV25diNMcDmM/yPPXF5oJmLWAFx
 /jrilOti+mCgnDUxa3tqr/FtfAQOZNxZVWvLcMxbEmCWDiM5uxF/BShiVn3+R4izA5+j+
 ps4ezlQi/QVM0Iz8yya5tZqoekHnOdh4jINSUNSL/ct/rBm0uK0+Fj7Ufiw0i2TCQng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792593366;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=mrNCvTJhrk6GmKFWJb7y8riBpo8i4BMSWHkX70RUDTQ=;
 b=hzEO/tBKOHyjTNcejI7pH6WA5le1jr27b7+vztg/WpbSYScceCBaI44PUAL/R3LOFlhs
 p22ilh6KxwTyASgXAjugvCUYx8bm917B5YQJwZqlNZWbvv5twvMCeTl4NFCg3iOiCH3PZ
 LkZr8C39G27rMHK9RfxpOKW/XJ/un0tw2f6R2KuN+X7klNrOAFfe3E3OlaJqfAFvogDLz
 7aYsXpVpTEIci+Axgw3j9hhT6BkowNYRao3Ebt1wg3zRIVBD8vpvRYe3xFd3VFIQvdZRG
 uVFnl7EUCAswXYnG+GED+PQLfLs6YcTDn1V+gTOZvv85tw07dsRT903bUWX5SlOKzrA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=BUCQXlzO; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=BUCQXlzO
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 86C2F408CC
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792593351;
 bh=mrNCvTJhrk6GmKFWJb7y8riBpo8i4BMSWHkX70RUDTQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BUCQXlzOG8sNZ3eOxtKSLu3DF6DXf0/KraBXdb72Xui0SM8GFsVqEpaPkT5mHasc1
 YISw7Yq/EZiHFW1cAtvqcWJlrZOViW7Qi3wZPd9O2XdGVrssFXephiBlDG6HShUDoO
 qpE7cTKtwHv39gnGF75/ZPyEsY4JEONGgLEBA0qZhvHIVsgBZFv4O3OM50oUkEE9NS
 x0eb0sN8CYQFmPh+JJslu8jjDWgXm+X0ZeaQrt5E3lLymNAa6pGSQ8qWMpjU4K3f3f
 v/gk7AmDFkhLzC2L3evWfAo5eMcBdbqCMfnru1oDrl5hf93k2mO6HjxhEMYCNnfJJk
 +0XhE4BRgpYBg==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id CBEE4B2219EB;
 Wed, 21 Oct 2026 16:35:50 +0200 (CEST)
Message-ID: <d0ce354d-71d0-4dab-9725-70e06998df2b@freeshell.de>
Date: Wed, 21 Oct 2026 07:35:48 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] configs: spacemit: k3: enable mtdparts on Pico-ITX in
 main app
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
References: <20261020195126.1325187-1-e@freeshell.de>
 <20261020195126.1325187-3-e@freeshell.de>
 <20261021075605-GKD65567@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261021075605-GKD65567@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yixun,

On 10/21/26 00:56, Yixun Lan wrote:
> Hi E Shattow,
> 
> 
> On 12:51 Tue 20 Oct     , E Shattow wrote:
>> add default mtdparts and mtdids consistent with k3-pico-itx.dts
>>
>> Signed-off-by: E Shattow <e@freeshell.de>
>> ---
>>  configs/spacemit_k3_defconfig | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
>> index b333e708d01b..2ca912556a88 100644
>> --- a/configs/spacemit_k3_defconfig
>> +++ b/configs/spacemit_k3_defconfig
>> @@ -26,6 +26,7 @@ CONFIG_SYS_PBSIZE=276
>>  CONFIG_HUSH_PARSER=y
>>  CONFIG_CMD_GPIO=y
>>  CONFIG_CMD_I2C=y
>> +CONFIG_CMD_MTD=y
>>  CONFIG_CMD_DHCP=y
>>  CONFIG_CMD_DNS=y
>>  CONFIG_CMD_MII=y
>> @@ -36,6 +37,9 @@ CONFIG_CMD_PMIC=y
>>  CONFIG_CMD_REGULATOR=y
>>  CONFIG_CMD_FAT=y
>>  CONFIG_CMD_FS_GENERIC=y
>> +CONFIG_CMD_MTDPARTS=y
>> +CONFIG_MTDIDS_DEFAULT="nor0=spi0.0"
>> +CONFIG_MTDPARTS_DEFAULT="spi0.0:128k(bootinfo),512k(fsbl),64k(env),1024k(esos),384k(opensbi),-(uboot)"

> or make it more specific? s/spi0.0/d420c000.spi/ 

Yes and no, I do prefer an automatic layout (and layout name) be
generated from device tree at runtime. I guess that may possibly become
"qspi.flash0", or "fdt.soc.d420c000.spi.qspi.flash.0", etc.

The output of 'mtd list' tells us the parent:

=> mtd list
List of MTD devices:
* nor0
  - device: flash@0
  - parent: spi@d420c000

Also, then, the output of 'mtdparts' tells us the partition layout:

=> mtdpart

device nor0 <spi0.0>, # parts = 6
 #: name                size            offset          mask_flags
 0: bootinfo            0x00020000      0x00000000      0
 1: fsbl                0x00080000      0x00020000      0
 2: env                 0x00010000      0x000a0000      0
 3: esos                0x00100000      0x000b0000      0
 4: opensbi             0x00060000      0x001b0000      0
 5: uboot               0x005f0000      0x00210000      0

active partition: nor0,0 - (bootinfo) 0x00020000 @ 0x00000000

defaults:
mtdids  : nor0=spi0.0
mtdparts:
spi0.0:128k(bootinfo),512k(fsbl),64k(env),1024k(esos),384k(opensbi),-(uboot)

I consider the partition layout identifier style as you suggest:

$ egrep --exclude-dir=.git -or 'mtdparts=[^ ]+)' | cut -d: -f2 | sort |
uniq -c | egrep -v '[0-9a-fA-F]{7}' | sort -k1,1 -n

...
      3 mtdparts=nand_mtd
      3 mtdparts=uniphier-nand.0
      4 mtdparts=nand0
      4 mtdparts=spi-flash.0
      5 mtdparts=nor0
      5 mtdparts=spi_flash
      7 mtdparts=boot
      7 mtdparts=omap2-nand.0
      8 mtdparts=nand
     11 mtdparts=nand.0
     12 mtdparts=orion_nand
     13 mtdparts=spi0.0
     16 mtdparts=gpmi-nand
     50 mtdparts=atmel_nand


$ egrep --exclude-dir=.git -or 'mtdparts=[^ ]+)' | cut -d: -f2 | sort |
uniq -c | egrep '[0-9a-fA-F]{7}' | sort -k1,1 -n
      1 mtdparts=10b80000.nand.0
      1 mtdparts=1fc000000.nor_flash
      1 mtdparts=21e0000.qspi
      1 mtdparts=30bb0000.qspi
      1 mtdparts=30bb0000.spi
      1 mtdparts=8000000.nand
      1 mtdparts=fe000000.nor_flash
      1 mtdparts=ffb90000.nand.0
      1 mtdparts=mtdparts=47040000.spi.0
      1 mtdparts=[mtdparts=]edb7312-nor
      1 mtdparts=mtdparts=edb7312-nor
      2 mtdparts=02008000.spi.1
      2 mtdparts=8000000.nor
      4 mtdparts=1550000.spi
      4 mtdparts=1550000.spi-0
      4 mtdparts=47040000.spi.0
      4 mtdparts=ec000000.nor
      4 mtdparts=ef000000.nor
      4 mtdparts=fef000000.nor
     10 mtdparts=ff705000.spi.0
     16 mtdparts=60000000.nor
     16 mtdparts=ff800000.flash
     22 mtdparts=fe8000000.nor


For the initial patch here I instead prefer the minimal and simple style
for mtdparts layout template names and to re-use what is popular in
U-Boot source tree. The use of hexadecimal bus address for the layout
name is difficult for me to read, and not clear to me what is the
benefit to doing this manually-entered data address?

=> env print
...
mtddevnum=0
mtdids=nor0=spi0.0
mtdparts=spi0.0:128k(bootinfo),512k(fsbl),64k(env),1024k(esos),384k(opensbi),-(uboot)
partition=nor0,0
...

Compared to a style of repeating the bus address:

=> env print
...
mtddevnum=0
mtdids=nor0=d420c000.spi
mtdparts=d420c000.spi:128k(bootinfo),512k(fsbl),64k(env),1024k(esos),384k(opensbi),-(uboot)
partition=nor0,0
...

Let me know if you do yet prefer the bus address repeated for the name
of partition layout. I'd like to see this as part of a runtime-generated
mtdparts configuration, so anything is okay with me for the initial
manual layout here.

> 
>>  CONFIG_DEVICE_TREE_INCLUDES="spacemit-k3-u-boot.dtsi"
>>  CONFIG_ENV_OVERWRITE=y
>>  CONFIG_ENV_IS_IN_SPI_FLASH=y
>> @@ -49,6 +53,7 @@ CONFIG_DM_I2C=y
>>  CONFIG_SYS_I2C_SPACEMIT_K1=y
>>  CONFIG_MISC=y
>>  CONFIG_SPI_FLASH_WINBOND=y
>> +CONFIG_SPI_FLASH_MTD=y
>>  CONFIG_PHY_GIGE=y
>>  CONFIG_DWC_ETH_QOS=y
>>  CONFIG_DWC_ETH_QOS_SPACEMIT=y
>> -- 
>> 2.53.0
>>
> 

Thanks,

-E
