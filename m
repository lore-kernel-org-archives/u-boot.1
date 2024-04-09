Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2942C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 21:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D764887FBF;
	Tue,  9 Apr 2024 23:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OC1w5TEn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 510138786C; Tue,  9 Apr 2024 23:11:58 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26C2E87572
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 23:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439LBhEQ064816;
 Tue, 9 Apr 2024 16:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712697103;
 bh=UpMhOP3L5heQ8Q5ddK7nGcnl9ifavnEwfWULpn+bOvs=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=OC1w5TEngVR3CM/jlTjh/SdMNUSKri03DfqBCEDFvYpPH/WVMVZUl2YrcS4DHn0/9
 FdEcnOxhRe/YB6xnsIiFfzCzf5vw5w9NHn8PD9o9ldQtv2BPJpBhS8BB//FWovItQT
 jIlLLgBBzz+BiRuSnB3VTBUFJhx9SPqp9nwxB21s=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439LBhAF007292
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Apr 2024 16:11:43 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 16:11:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 16:11:43 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439LBhde013625;
 Tue, 9 Apr 2024 16:11:43 -0500
From: Jon Humphreys <j-humphreys@ti.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Judith Mendez <jm@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, "Simon Glass" <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 "Neha Malcom Francis" <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, "Roger Quadros" <rogerq@kernel.org>, Bryan Brattlof
 <bb@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, Tom Rini
 <trini@konsulko.com>, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 02/16] board: am64x: Define capsule update firmware info
In-Reply-To: <185bd37a-9e1d-4daf-8bd6-57ce598e95fc@gmx.de>
References: <20240408223134.165877-1-j-humphreys@ti.com>
 <20240408223134.165877-3-j-humphreys@ti.com>
 <185bd37a-9e1d-4daf-8bd6-57ce598e95fc@gmx.de>
Date: Tue, 9 Apr 2024 16:11:43 -0500
Message-ID: <86wmp6z1f4.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 09 Apr 2024 23:13:13 +0200
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

Heinrich Schuchardt <xypron.glpk@gmx.de> writes:

> On 4/9/24 00:31, Jonathan Humphreys wrote:
>> Define the firmwares updatable via EFI capsule update.
>
> Nits:
>
> %s/firmwares/firmware/ (firmware is uncountable).
>
>>
>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>> ---
>>   board/ti/am64x/evm.c | 33 +++++++++++++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
>> diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
>> index b8de69da06c..876c5c25d42 100644
>> --- a/board/ti/am64x/evm.c
>> +++ b/board/ti/am64x/evm.c
>> @@ -7,6 +7,7 @@
>>    *
>>    */
>>
>> +#include <efi_loader.h>
>>   #include <asm/io.h>
>>   #include <dm/uclass.h>
>>   #include <k3-ddrss.h>
>> @@ -27,6 +28,38 @@
>>
>>   DECLARE_GLOBAL_DATA_PTR;
>>
>> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
>> +struct efi_fw_image fw_images[] = {
>> +	{
>> +		.image_type_id = K3_TIBOOT3_IMAGE_GUID,
>> +		.fw_name = u"K3_TIBOOT3",
>> +		.image_index = 1,
>> +	},
>> +	{
>> +		.image_type_id = K3_SPL_IMAGE_GUID,
>> +		.fw_name = u"K3_SPL",
>> +		.image_index = 2,
>> +	},
>> +	{
>> +		.image_type_id = K3_UBOOT_IMAGE_GUID,
>> +		.fw_name = u"K3_UBOOT",
>> +		.image_index = 3,
>> +	}
>> +};
>> +
>> +struct efi_capsule_update_info update_info = {
>> +	.dfu_string = "sf 0:0=tiboot3.bin raw 0 100000;tispl.bin raw 100000 200000;u-boot.img raw 300000 400000",
>
> Is TI using other addresses than Phytec?
>
> doc/board/phytec/phycore-am64x.rst:
>
>    fatload mmc 1 ${loadaddr} tiboot3.bin
>    sf update $loadaddr 0x0 $filesize
>    fatload mmc 1 ${loadaddr} tispl.bin
>    sf update $loadaddr 0x80000 $filesize
>    fatload mmc 1 ${loadaddr} u-boot.img
>    sf update $loadaddr 0x280000 $filesize
>

This patch has the correct offsets for am64x, so I guess phycore defined
the offsets differently.

> Please, add documentation in doc/board/ for all boards in the series
> specifying the location of the firmware in flash memory and how to
> update it(cf. section OSPI in doc/board/ti/am65x_evm.rst).
>

Yes, I will add patches to document OSPI layouts where missing.

>> +	.num_images = ARRAY_SIZE(fw_images),
>> +	.images = fw_images,
>> +};
>
> The series has been assigned to me in Patchwork.
>
> But changes should be tested and reviewed by the respective board
> maintainers (Vignesh, Tom for AM64x) as I have no access to TI boards.
>
> Best regards
>
> Heinrich
>
>> +
>> +void set_dfu_alt_info(char *interface, char *devstr)
>> +{
>> +	env_set("dfu_alt_info", update_info.dfu_string);
>> +}
>> +
>> +#endif /* EFI_HAVE_CAPSULE_SUPPORT */
>> +
>>   int board_init(void)
>>   {
>>   	return 0;
