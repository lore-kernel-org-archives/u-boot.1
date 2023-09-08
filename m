Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31898EE8015
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 16:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66F0A86A23;
	Fri,  8 Sep 2023 17:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TkNKxjas";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFE8686A69; Fri,  8 Sep 2023 17:59:57 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3188F86A04
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 17:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 388FxjHn043568;
 Fri, 8 Sep 2023 10:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694188785;
 bh=tVxU2vIh5rC7mJjYH0UtOUjA5EU9Sk09nraVuBgt6kg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=TkNKxjas5MT4QB43gH6DaHEV2fOi0liL5l80aruHEjMnmqpNOTY72LaISoz4E8yLC
 aaOZYFFgBp9Xd/YteHp3QL710wG8/CT5NoP4d7nBSSeMi9Xq0+aU7gl7Cda9dG9BCF
 IFPrl7dC/KpBJRTKOEXFUIguZxdQ7n6oHrNY4yUQ=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 388FxjpQ082295
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 10:59:45 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 10:59:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 10:59:45 -0500
Received: from [10.250.38.120] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 388FxiHQ011386;
 Fri, 8 Sep 2023 10:59:44 -0500
Message-ID: <0ea3625a-c647-fc80-36c6-93e46685c750@ti.com>
Date: Fri, 8 Sep 2023 10:59:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 11/16] board: ti: j784s4: Add support for board
 detection by EEPROM read
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Apurva Nandan <a-nandan@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Kamlesh
 Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>, Manorit
 Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, Bryan
 Brattlof <bb@ti.com>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jason
 Kacines <j-kacines@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph
 Siemsen <ralph.siemsen@linaro.org>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
References: <20230908110551.861575-1-a-nandan@ti.com>
 <20230908110551.861575-12-a-nandan@ti.com>
 <20230908144237.qd4ito3c656hmfp2@degrading>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20230908144237.qd4ito3c656hmfp2@degrading>
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

On 9/8/23 9:42 AM, Nishanth Menon wrote:
> On 16:35-20230908, Apurva Nandan wrote:
>> From: Dasnavis Sabiya <sabiya.d@ti.com>
>>
>> The board name is programmed in the EEPROM. Add support for board
>> detection and choose the right dtb based on the board name read
>> from EEPROM.
>>
>> The J784S4/AM69 has two platforms naming J784S4-EVM and AM69-SK. The
>> J784S4 has EEPROM populated at 0x50. AM69 SK has EEPROM
>> populated at next address 0x51. So start looking for TI specific EEPROM
>> at 0x50, if not found look for EEPROM at 0x51.
>>
>> Also, add support for setup_serial() to read the serial number from EEPROM
>> and update the serial environment variable with the same.
>>
>> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> 
> 
> NAK. go with the approach similar to AM62x. AM69-SK has it's own
> fragment.
> 

NAK to your NAK, there is no reason to introduce more fragments here
when both boards can be supported with one defconfig.

Andrew
