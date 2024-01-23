Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFF7C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 14:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E38B787B51;
	Tue, 23 Jan 2024 15:43:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="B9bSK3wq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B82C87D27; Tue, 23 Jan 2024 15:43:09 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B91EB87B51
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 15:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NEgskx016057;
 Tue, 23 Jan 2024 08:42:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706020974;
 bh=ly7MBJI3ehpmo4B4pmaR3oXVO05B0Mou21lF46iXp/o=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=B9bSK3wqFOnH1qjiET69YQHaQL2gvbY+SI4AAvJXW574IFPIv6Z22g4nicBzv4WmQ
 iQJFoWJ7HOf3hEnoPJYyUUDcu3F98hykFPtgowskhkBCKgeF/s03noS2SRf8PPdOIZ
 LJ8YVditBMaBIMjbgaiFAkRYl80iaYCOefW/9d8g=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NEgsMF045055
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 23 Jan 2024 08:42:54 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 08:42:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 08:42:54 -0600
Received: from [10.24.68.115] (ti.dhcp.ti.com [10.24.68.115] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NEdu0j079783; 
 Tue, 23 Jan 2024 08:42:48 -0600
Message-ID: <7ea85460-5fb9-4f4f-a023-32662d1f54fc@ti.com>
Date: Tue, 23 Jan 2024 20:12:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/16] arm: dts: Add bootph-all for memory node
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
References: <20240119175043.3904751-1-a-nandan@ti.com>
 <20240119175043.3904751-5-a-nandan@ti.com>
 <20240119192545.dybq7b5yy22oar75@observer>
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20240119192545.dybq7b5yy22oar75@observer>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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


On 20/01/24 00:55, Nishanth Menon wrote:
> On 23:20-20240119, Apurva Nandan wrote:
> [...]
>
>> diff --git a/arch/arm/dts/k3-am69-sk.dts b/arch/arm/dts/k3-am69-sk.dts
>> index 9868c7049b..29884097b9 100644
>> --- a/arch/arm/dts/k3-am69-sk.dts
>> +++ b/arch/arm/dts/k3-am69-sk.dts
> I think you mis-interpreted
> https://lore.kernel.org/u-boot/20240103175221.ovjzcwwljnjhka2n@expire/
> comment to modify kernel board.dts. I meant for you to squash that
> correct change  to the patch that introduces board-u-boot.dtsi and r5.dts
>
> Now that i read my comment, I can see why it might have been
> mis-interpreted. Sorry about that - please squash your v7 patch
> instead to appropriate patch.
Okay, will do.
>
>> @@ -33,6 +33,7 @@
>>   
>>   	memory@80000000 {
>>   		device_type = "memory";
>> +		bootph-all;
>>   		/* 32G RAM */
>>   		reg = <0x00 0x80000000 0x00 0x80000000>,
>>   		      <0x08 0x80000000 0x07 0x80000000>;
>> diff --git a/arch/arm/dts/k3-j784s4-evm.dts b/arch/arm/dts/k3-j784s4-evm.dts
>> index f1f4c8634a..662552c872 100644
>> --- a/arch/arm/dts/k3-j784s4-evm.dts
>> +++ b/arch/arm/dts/k3-j784s4-evm.dts
>> @@ -31,6 +31,7 @@
>>   
>>   	memory@80000000 {
>>   		device_type = "memory";
>> +		bootph-all;
>>   		/* 32G RAM */
>>   		reg = <0x00 0x80000000 0x00 0x80000000>,
>>   		      <0x08 0x80000000 0x07 0x80000000>;
>> -- 
>> 2.34.1
>>
-- 
Regards,
Apurva Nandan,
Texas Instruments.

