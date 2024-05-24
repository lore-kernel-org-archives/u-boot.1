Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C349CC25B7A
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 15:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33EA0884D5;
	Fri, 24 May 2024 17:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uF7gusJC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E17888851; Fri, 24 May 2024 17:38:26 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6043884C6
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 17:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44OFc5Yf108793;
 Fri, 24 May 2024 10:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716565085;
 bh=Qe5aeEu8J1gJ8iPi5YU3/8rpHFj2L+8p0mp5YTLWJgE=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=uF7gusJCVdVTw9GmyIpOu2JDP8mOHC6TSBzGGdSuF06keHN4P2tcb9d09rZd80V+b
 vadARZS6Or32Oao/I05cCWjBmNV9J+enk7FLTCBCx2PRhjkwKYGVz6Qza/VzDfxuQ5
 e8FxUjgvrnL+Pmf9gKCOZhNEASolXYKUKqwuQyAk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44OFc5eq079475
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 24 May 2024 10:38:05 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 10:38:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 10:38:04 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44OFc4Hg091703;
 Fri, 24 May 2024 10:38:04 -0500
From: Jon Humphreys <j-humphreys@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Roger Quadros
 <rogerq@kernel.org>
CC: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>,
 "Christian Gmeiner" <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, "Neha Malcom Francis"
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, "Maxime Ripard"
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>, Bryan
 Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 "Robert Nelson" <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 "Masahisa Kojima" <kojima.masahisa@socionext.com>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 15/19] board: am62px: Define capsule update firmware
 info
In-Reply-To: <Zk--WFQJC-wi5zE5@hera>
References: <20240509164123.1753050-1-j-humphreys@ti.com>
 <20240509164123.1753050-16-j-humphreys@ti.com> <Zk--WFQJC-wi5zE5@hera>
Date: Fri, 24 May 2024 10:38:04 -0500
Message-ID: <86bk4vcjab.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:

> Hi Jonathan
>
> Thanks for working on this
>
> On Thu, May 09, 2024 at 11:41:19AM -0500, Jonathan Humphreys wrote:
>> Define the firmware components updatable via EFI capsule update, including
>> defining capsule GUIDs for the various firmware components for the AM62px
>> SK.
>>
>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>> ---
>>  board/ti/am62px/evm.c        | 32 ++++++++++++++++++++++++++++++++
>>  include/configs/am62px_evm.h | 24 ++++++++++++++++++++++++
>>  2 files changed, 56 insertions(+)
>>
>> diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
>> index 97a95ce8cc2..6d0f66e5dc0 100644
>> --- a/board/ti/am62px/evm.c
>> +++ b/board/ti/am62px/evm.c
>> @@ -6,6 +6,7 @@
>>   *
>>   */
>>
>> +#include <efi_loader.h>
>>  #include <asm/arch/hardware.h>
>>  #include <asm/io.h>
>>  #include <dm/uclass.h>
>> @@ -13,6 +14,37 @@
>>  #include <fdt_support.h>
>>  #include <spl.h>
>>
>> +struct efi_fw_image fw_images[] = {
>
> It's better if we add an
> #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
> for both of the structs that follow (and it applies to all your patches)
>

Ilias, thanks for the reviews.

I had this protected in #if's in an earlier patch set, as you suggest here.
However, in those reviews, Roger recommended that we don't do that and put
conditions around the use of it in set_dfu_alt_info().

https://lore.kernel.org/all/b19f02e0-a80a-46d6-8296-5d516577766a@kernel.org/

I assume the reasoning is to reduce #if's in the code and rely on the
compiler to be smart enough to remove dead data. (Roger, speak up if I
misrepresent you.)

I'm ok to do either way.  What is the preferred way in U-Boot?

Thanks
Jon

>> +	{
>> +		.image_type_id = AM62PX_SK_TIBOOT3_IMAGE_GUID,
>> +		.fw_name = u"AM62PX_SK_TIBOOT3",
>> +		.image_index = 1,
>> +	},
>> +	{
>> +		.image_type_id = AM62PX_SK_SPL_IMAGE_GUID,
>> +		.fw_name = u"AM62PX_SK_SPL",
>> +		.image_index = 2,
>> +	},
>> +	{
>> +		.image_type_id = AM62PX_SK_UBOOT_IMAGE_GUID,
>> +		.fw_name = u"AM62PX_SK_UBOOT",
>> +		.image_index = 3,
>> +	}
>> +};
>> +
>> +struct efi_capsule_update_info update_info = {
>> +	.dfu_string = "sf 0:0=tiboot3.bin raw 0 80000;"
>> +	"tispl.bin raw 80000 200000;u-boot.img raw 280000 400000",
>> +	.num_images = ARRAY_SIZE(fw_images),
>> +	.images = fw_images,
>> +};
>
> I haven't worked on any TI platforms lately so I cant say much about the
> naming and the flash regions. The definition seems correct
>
>
>> +
>> +void set_dfu_alt_info(char *interface, char *devstr)
>> +{
>> +	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
>> +		env_set("dfu_alt_info", update_info.dfu_string);
>> +}
>
> There's a CONFIG_SET_DFU_ALT_INFO symbol. This better if we add a check here
> as well
>
>> +
>>  int board_init(void)
>>  {
>>  	return 0;
>> diff --git a/include/configs/am62px_evm.h b/include/configs/am62px_evm.h
>> index 06b12860e21..57a1ba9dc3c 100644
>> --- a/include/configs/am62px_evm.h
>> +++ b/include/configs/am62px_evm.h
>> @@ -8,6 +8,30 @@
>>  #ifndef __CONFIG_AM62PX_EVM_H
>>  #define __CONFIG_AM62PX_EVM_H
>>
> [...]
>
> Regards
> /Ilias
