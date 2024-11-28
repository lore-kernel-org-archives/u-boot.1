Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE194D70DE3
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 16:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA11289C67;
	Thu, 28 Nov 2024 17:47:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h43tmrOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC44489D08; Thu, 28 Nov 2024 17:47:48 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8962089782
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 17:47:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4ASGlWuU1187847
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Nov 2024 10:47:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732812452;
 bh=//xOWqpDW4WtfJHUAcZUiMmo6B5fTNt/EfFbXdkZo34=;
 h=Date:CC:Subject:To:References:From:In-Reply-To;
 b=h43tmrOt/6I3VdlzlFGNPdUK5c+x4QJu6hSVRm75PeSNEsPl4dK/dh6LNrcJnQlcm
 x2Nx03J4+P3am6xXeamzEZtDAAWPtH3dxR0mEKQFPxllkJDbVUDesekVUNovs3HC3d
 Gd3shpD1gamtbXdOXKoydKnKAwVPyGY2GWF8uT3E=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ASGlWqB017318
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Nov 2024 10:47:32 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Nov 2024 10:47:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Nov 2024 10:47:31 -0600
Received: from [10.249.131.218] ([10.249.131.218])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ASGlNvJ075788;
 Thu, 28 Nov 2024 10:47:24 -0600
Message-ID: <c80a0234-d9e2-4c41-b403-38e6346a4d1d@ti.com>
Date: Thu, 28 Nov 2024 22:17:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <s-vadapalli@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH 0/2] AM62A DWC3: Add support for USB DFU boot in OTG mode
To: Roger Quadros <rogerq@kernel.org>, <vigneshr@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <marex@denx.de>, <hnagalla@ti.com>,
 <mkorpershoek@baylibre.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <jan.kiszka@siemens.com>,
 <jonas@kwiboo.se>, <j-humphreys@ti.com>, <nm@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>
References: <20241126120322.1760862-1-s-vadapalli@ti.com>
 <ea2bb69c-280a-4ab2-85ef-cd0d9e6e3f76@kernel.org>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <ea2bb69c-280a-4ab2-85ef-cd0d9e6e3f76@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hello Roger,

On 28-11-2024 18:15, Roger Quadros wrote:
> 
> 
> On 26/11/2024 14:03, Siddharth Vadapalli wrote:
>> Hello,
>>
>> This series adds support for USB DFU boot on TI's AM62A SoC which has
>> two instances of DWC3 USB Controllers namely USB0 and USB1. The USB0
>> instance of the USB Controller supports USB DFU boot:
>> ROM => tiboot3.bin => tispl.bin => u-boot.img
>>
>> USB DFU Boot requires the USB Controller to be configured for Gadget
>> mode of operation. Since the USB0 instance of the DWC3 USB Controller
>> supports both Host and Gadget modes of operation via the Type-C interface
>> on the AM62A7-SK board, the device-tree specifies the "dr_mode" as "OTG".
>> However, there is currently no support for dynamically switching the "mode"
>> from Host to Gadget and vice-versa with the help of a state-machine.
>> The OTG mode is treated as a separate mode in itself rather than being
>> treated as an intermediate stage before assuming the Host/Gadget mode.
>> Due to this, USB DFU boot via the Type-C interface doesn't work as the
>> USB Controller hasn't been appropriately configured for Device/Gadget
>> mode of operation. One option is to change the device-tree to specify
>> "dr_mode" as "peripheral" and force the controller to assume the Device
>> role. This will imply that the U-Boot device-tree for AM62A diverges
>> from its Linux counterpart. Therefore, with the intent of keeping the
>> device-tree uniform across Linux and U-Boot, and at the same time, in
>> order to enable USB DFU boot in "OTG" mode with the DWC3 Controller,
>> the first patch in this series sets the "mode" on the basis of the
>> caller function, rather than using the "dr_mode" property in the
>> device-tree. There are only two callers of "dwc3_generic_probe()",
>> each of which clearly specify the expected mode of configuration.
>> This will enable both Host and Device mode of operation based on the
>> command executed by the user, thereby truly supporting "OTG"
>> functionality when the USB Controller supports it.
> 
> We don't really support OTG state machine. All you are supporting is
> user initiated role change.

I should have probably used the term "Dual Role" instead of "OTG". I
meant to say that the controller can be used both as Host and Device
based on the command executed by the user, if the controller's dr_mode
is "otg". I am aware that we don't support the OTG state machine in
U-Boot unlike Linux, which is why I have posted this series as a
workaround to utilize both Host and Device modes in the interim.

[...]

-- 
Regards,
Siddharth.
