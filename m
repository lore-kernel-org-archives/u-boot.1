Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F7BC4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 12:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ACD787947;
	Fri, 12 Jan 2024 13:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MGTPXESD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAD43879C7; Fri, 12 Jan 2024 13:36:43 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EF028760D
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40CCadTQ049107;
 Fri, 12 Jan 2024 06:36:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705062999;
 bh=s/3Q/k6UOKQBwDgb/WzggLluix0IVggC7vMuQKHphGM=;
 h=Date:CC:Subject:To:References:From:In-Reply-To;
 b=MGTPXESD/WU7IK8OLFUctIi6jHzlyPg3ly6IxKfDU2O1Kn+EoPMoVz3PFO4HNtWKh
 jfq3O5uu59JzJ1iWN/rgkiCSDSRbBp1ie8WHe9h8DTq+NaFGIp2TAQrH0dysILuvlO
 DrGrernv1bHYPxwlFKwMBRiARvpvvgmmqK19QchM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40CCadFT003611
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 06:36:39 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 06:36:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 06:36:38 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40CCaZU4034195;
 Fri, 12 Jan 2024 06:36:36 -0600
Message-ID: <cc658de2-24f6-4990-ac59-1f4ad4d373e1@ti.com>
Date: Fri, 12 Jan 2024 18:06:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <trini@konsulko.com>, <sjg@chromium.org>, <afd@ti.com>, <vigneshr@ti.com>, 
 <u-boot@lists.denx.de>, <dannenberg@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: Re: [PATCH 00/10] Add support for Ethernet Boot on SK-AM62
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
 <20240112123231.ivvcnryppxuqi5jr@sequel>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20240112123231.ivvcnryppxuqi5jr@sequel>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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



On 12/01/24 18:02, Nishanth Menon wrote:
> On 12:17-20240112, Siddharth Vadapalli wrote:
>> Hello,
>>
>> This series enables Ethernet Boot on SK-AM62 device.
>> Product Link: https://www.ti.com/tool/SK-AM62
>> User Guide: https://www.ti.com/lit/pdf/spruj40
>>
>> Ethernet Boot flow is as follows:
>> 1. The BOOT MODE pins are configured for Ethernet Boot.
>> 2. On powering on the device, ROM uses the Ethernet Port corresponding
>> to CPSW3G's MAC Port 1 to transmit "TI K3 Bootp Boot".
>> 3. The TFTP server and DHCP server on the receiver device need to be
>> configured such that VCI string "TI K3 Bootp Boot" maps to the file
>> "tiboot3.bin" and the TFTP server should be capable of transferring
>> it to the device.
>> 4. ROM loads and executes "tiboot3.bin" provided by the TFTP server.
>> 5. The "tiboot3.bin" file is expected to be built using the config:
>> am62x_evm_r5_ethboot_defconfig
>> introduced in this series, which shall enable "tispl.bin" to be fetched
>> over TFTP using "tiboot3.bin".
>> 6. "tiboot3.bin" is configured to transmit "AM62X U-Boot R5 SPL" as its
>> NET_VCI_STRING, thereby implying that the DHCP server and TFTP server
>> need to be configured to transfer "tispl.bin" to the device.
>> 7. "tiboot3.bin" loads and executes "tispl.bin" provided by the TFTP
>> server.
>> 8. The "tispl.bin" file is expected to be built using the config:
>> am62x_evm_a53_defconfig
>> which has been updated in this series to enable Ethernet Boot specific
>> configs, allowing "u-boot.img" to be fetched over TFTP using
>> "tispl.bin".
>> 9. "tispl.bin" is configured to transmit "AM62X U-Boot A53 SPL" as its
>> NET_VCI_STRING. The DHCP server and TFTP server need to be configured to
>> transfer "u-boot.img" to the device for the aforementioned NET_VCI_STRING.
>> 10. "tispl.bin" then fetches "u-boot.img" using TFTP and loads and
>> executes it on the device, completing the process of Ethernet Boot on the
>> device.
>>
>> NOTE: ROM configures CPSW3G's MAC Port 1 for 100 Mbps full-duplex mode
>> of operation due to which it is expected that the Link Partner also
>> supports the same mode of operation.
>> Additionally, enabling "phy_gmii_sel" node at SPL stage will be
>> necessary and is not added as a part of this series with the aim of
>> adding the "bootph-all" property to its counterpart in Linux device-tree
>> first.
> 
> 
> NAK - instead of writing all this up in the commit message, why would
> you not spend that time updating the excellent documentation we have?

I plan to document it after the feature is in. The reason for mentioning the
content above is for explaining the flow in case anyone wishes to test and
verify it. Wouldn't documenting it make it appear that the feature is present
when it isn't?

...

-- 
Regards,
Siddharth.
