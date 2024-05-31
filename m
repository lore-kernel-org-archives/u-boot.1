Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C34C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 04:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CE3B882D7;
	Fri, 31 May 2024 06:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U3sWXlz0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B66CE88755; Fri, 31 May 2024 06:10:11 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E85E7882D0
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 06:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44V49uOZ104854;
 Thu, 30 May 2024 23:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717128596;
 bh=g0J5JLsJxIo0nUHxR6bhwUpH1kZSOEoH+GxhTG8nVDI=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=U3sWXlz0wARyOQ4qJQOLJVtnFFPkHaWyaSExdrruRPs/Awo2ISuIgFFB9twKk6pAh
 4dGmwKPKSPVTH3B6hfQS8ojA8YCarO49Q7y8MskLur0CLE3ejUMG8RYafXeJkXFGVf
 afkmgnOWmq9t+GfrOlBTq423ivTR/9nwwsjQ1ysw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44V49ubG011316
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 May 2024 23:09:56 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 23:09:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 23:09:56 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44V49u8F017552;
 Thu, 30 May 2024 23:09:56 -0500
From: Jon Humphreys <j-humphreys@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: Roger Quadros <rogerq@kernel.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Kamlesh Gurudasani <kamlesh@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, "Simon Glass" <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 "Neha Malcom Francis" <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, "Bryan Brattlof" <bb@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon
 <nm@ti.com>, Tom Rini <trini@konsulko.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>,
 "Masahisa Kojima" <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 15/19] board: am62px: Define capsule update firmware
 info
In-Reply-To: <CAC_iWjLMERkDYF_-Eu5mg13q_PjjfjcwgsTGxJ_SB6h6PdzXEA@mail.gmail.com>
References: <20240509164123.1753050-1-j-humphreys@ti.com>
 <20240509164123.1753050-16-j-humphreys@ti.com> <Zk--WFQJC-wi5zE5@hera>
 <86bk4vcjab.fsf@udb0321960.dhcp.ti.com>
 <CAC_iWjLMERkDYF_-Eu5mg13q_PjjfjcwgsTGxJ_SB6h6PdzXEA@mail.gmail.com>
Date: Thu, 30 May 2024 23:09:56 -0500
Message-ID: <86ikyufwq3.fsf@udb0321960.dhcp.ti.com>
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

> Hi Jon,
>
> On Fri, 24 May 2024 at 18:38, Jon Humphreys <j-humphreys@ti.com> wrote:
>>
>> Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:
>>
>> > Hi Jonathan
>> >
>> > Thanks for working on this
>> >
>> > On Thu, May 09, 2024 at 11:41:19AM -0500, Jonathan Humphreys wrote:
>> >> Define the firmware components updatable via EFI capsule update, including
>> >> defining capsule GUIDs for the various firmware components for the AM62px
>> >> SK.
>> >>
>> >> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>> >> ---
>> >>  board/ti/am62px/evm.c        | 32 ++++++++++++++++++++++++++++++++
>> >>  include/configs/am62px_evm.h | 24 ++++++++++++++++++++++++
>> >>  2 files changed, 56 insertions(+)
>> >>
>> >> diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
>> >> index 97a95ce8cc2..6d0f66e5dc0 100644
>> >> --- a/board/ti/am62px/evm.c
>> >> +++ b/board/ti/am62px/evm.c
>> >> @@ -6,6 +6,7 @@
>> >>   *
>> >>   */
>> >>
>> >> +#include <efi_loader.h>
>> >>  #include <asm/arch/hardware.h>
>> >>  #include <asm/io.h>
>> >>  #include <dm/uclass.h>
>> >> @@ -13,6 +14,37 @@
>> >>  #include <fdt_support.h>
>> >>  #include <spl.h>
>> >>
>> >> +struct efi_fw_image fw_images[] = {
>> >
>> > It's better if we add an
>> > #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
>> > for both of the structs that follow (and it applies to all your patches)
>> >
>>
>> Ilias, thanks for the reviews.
>>
>> I had this protected in #if's in an earlier patch set, as you suggest here.
>> However, in those reviews, Roger recommended that we don't do that and put
>> conditions around the use of it in set_dfu_alt_info().
>>
>
> Hmm but the function prototype itself is on an ifdef. If you want to
> remove the ifdef you got to do it everywhere
>

Are you referring to set_dfu_alt_info() which is guarded by
CONFIG_SET_DFU_ALT_INFO?

If so, that is separate but I can add a CONFIG_SET_DFU_ALT_INFO guard
around the definition, for now. But IMO it is a bit of a mess because it's
use and board specific defs are guarded by CONFIG_SET_DFU_ALT_INFO but the
weak/default definition is guarded by CONFIG_EFI_CAPSULE_FIRMWARE, which
causes problems because the configs are not always the same for all builds.
I was wanting to fix that too so I might do that as a separate patch and
make that patch a prerequisite for this series, which then allows me to
remove the definitions of set_dfu_alt_info() in this series.

Jon

> Thanks
> /Ilias
>
>> https://lore.kernel.org/all/b19f02e0-a80a-46d6-8296-5d516577766a@kernel.org/
>>
>> I assume the reasoning is to reduce #if's in the code and rely on the
>> compiler to be smart enough to remove dead data. (Roger, speak up if I
>> misrepresent you.)
>>
>> I'm ok to do either way.  What is the preferred way in U-Boot?
>>
>> Thanks
>> Jon
>>
>> >> +    {
>> >> +            .image_type_id = AM62PX_SK_TIBOOT3_IMAGE_GUID,
>> >> +            .fw_name = u"AM62PX_SK_TIBOOT3",
>> >> +            .image_index = 1,
>> >> +    },
>> >> +    {
>> >> +            .image_type_id = AM62PX_SK_SPL_IMAGE_GUID,
>> >> +            .fw_name = u"AM62PX_SK_SPL",
>> >> +            .image_index = 2,
>> >> +    },
>> >> +    {
>> >> +            .image_type_id = AM62PX_SK_UBOOT_IMAGE_GUID,
>> >> +            .fw_name = u"AM62PX_SK_UBOOT",
>> >> +            .image_index = 3,
>> >> +    }
>> >> +};
>> >> +
>> >> +struct efi_capsule_update_info update_info = {
>> >> +    .dfu_string = "sf 0:0=tiboot3.bin raw 0 80000;"
>> >> +    "tispl.bin raw 80000 200000;u-boot.img raw 280000 400000",
>> >> +    .num_images = ARRAY_SIZE(fw_images),
>> >> +    .images = fw_images,
>> >> +};
>> >
>> > I haven't worked on any TI platforms lately so I cant say much about the
>> > naming and the flash regions. The definition seems correct
>> >
>> >
>> >> +
>> >> +void set_dfu_alt_info(char *interface, char *devstr)
>> >> +{
>> >> +    if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
>> >> +            env_set("dfu_alt_info", update_info.dfu_string);
>> >> +}
>> >
>> > There's a CONFIG_SET_DFU_ALT_INFO symbol. This better if we add a check here
>> > as well
>> >
>> >> +
>> >>  int board_init(void)
>> >>  {
>> >>      return 0;
>> >> diff --git a/include/configs/am62px_evm.h b/include/configs/am62px_evm.h
>> >> index 06b12860e21..57a1ba9dc3c 100644
>> >> --- a/include/configs/am62px_evm.h
>> >> +++ b/include/configs/am62px_evm.h
>> >> @@ -8,6 +8,30 @@
>> >>  #ifndef __CONFIG_AM62PX_EVM_H
>> >>  #define __CONFIG_AM62PX_EVM_H
>> >>
>> > [...]
>> >
>> > Regards
>> > /Ilias
