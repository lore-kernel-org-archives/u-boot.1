Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE233C54764
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 09:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3301587F2A;
	Mon, 19 Feb 2024 10:49:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="y5g8Nj9f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5061087E80; Mon, 19 Feb 2024 10:49:20 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B3187E95
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 10:48:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41J9mR3L071323;
 Mon, 19 Feb 2024 03:48:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708336107;
 bh=eCxI39doczDdSWorc3f5XIiTON4d3cxKB5+TFGFQNqo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=y5g8Nj9fJvUmV20bG1048rQFArojrVPmZOEz1ltucEbaHXtrl7OkiXgsON+mCibF2
 +miN9D2ex1Tc2rDWHkzANQercRFEhUQyEl66MmNKCSxsum4jsPh9cmIVCrfAFU3SzC
 cYu7jvMDo3M2pBIf5t9WOYiyqAkWA2LBhJht28L8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41J9mR3F080740
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 19 Feb 2024 03:48:27 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Feb 2024 03:48:27 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Feb 2024 03:48:27 -0600
Received: from [10.24.68.115] (ti.dhcp.ti.com [10.24.68.115] (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41J9mKs1077228; 
 Mon, 19 Feb 2024 03:48:20 -0600
Message-ID: <981515a8-5f20-4636-b927-069aa9775a2f@ti.com>
Date: Mon, 19 Feb 2024 15:18:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/16] doc: board: ti: k3: Add J784S4 EVM and AM69 SK
 documentation
Content-Language: en-US
To: Andrew Halaney <ahalaney@redhat.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Nishanth Menon <nm@ti.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
References: <20240119175043.3904751-1-a-nandan@ti.com>
 <20240119175043.3904751-17-a-nandan@ti.com>
 <5lgshkyfxnvxt6okk3yooxjwks7bqtc2u5k5o7wzmorgxs2jwh@qylsklcedwp2>
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <5lgshkyfxnvxt6okk3yooxjwks7bqtc2u5k5o7wzmorgxs2jwh@qylsklcedwp2>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


On 16/02/24 02:14, Andrew Halaney wrote:
> On Fri, Jan 19, 2024 at 11:20:43PM +0530, Apurva Nandan wrote:
>> TI K3 J784S4 and AM69 are new additions to the K3 SoC family.
>> Add documentation about the J784S4 EVM and AM69 SK.
>>
>> Signed-off-by: Dasnavis Sabiya<sabiya.d@ti.com>
>> Signed-off-by: Apurva Nandan<a-nandan@ti.com>
>> ---
>>   board/ti/j784s4/MAINTAINERS |   1 +
>>   doc/board/ti/j784s4_evm.rst | 299 ++++++++++++++++++++++++++++++++++++
>>   doc/board/ti/k3.rst         |   1 +
>>   3 files changed, 301 insertions(+)
>>   create mode 100644 doc/board/ti/j784s4_evm.rst
>>
> <snip>
>
>> +
>> +Switch Setting for Boot Mode
>> +----------------------------
>> +
>> +Boot Mode pins provide means to select the boot mode and options before the
>> +device is powered up. After every POR, they are the main source to populate
>> +the Boot Parameter Tables.
>> +
>> +Boot Mode Pins for J784S4-EVM
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +The following tables show some common boot modes used on J784S4 EVM platform.
>> +More details can be found in the Technical Reference Manual:
>> +http://www.ti.com/lit/zip/spruj52 under the `Boot Mode Pins` section.
>> +
>> +.. list-table:: J784S4 EVM Boot Modes
>> +   :widths: 16 16 16
>> +   :header-rows: 1
>> +
>> +   * - Switch Label
>> +     - SW9: 12345678
>> +     - SW8: 12345678
> According to spruj62 I think SW9 and SW8 are supposed to be
> SW7 and SW11 respectively?
>
>> +
>> +   * - SD
>> +     - 00000000
>> +     - 10000010
>> +
>> +   * - EMMC
>> +     - 01000000
>> +     - 10000000
>> +
>> +   * - OSPI
>> +     - 01000000
>> +     - 00000110
>> +
>> +   * - UART
>> +     - 01110000
>> +     - 00000000
>> +
>> +For SW8 and SW9, the switch state in the "ON" position = 1.
> Referencing more from spruj62...
>
> SW8 is a push button for a user defined interrupt for wake up (I think),
> and SW9 is the main domain warm reset push button.
>
> I'm not sure either of those are what you're trying to highlight here.
Thanks for highlighting, I will fix it.
> Love the TI documentation by the way, it is very nice.
Great to hear, that you found it useful :)
> Thanks,
> Andrew

-- 
Regards,
Apurva Nandan,
Texas Instruments.
