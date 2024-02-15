Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6044BC4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 09:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AF7C87CC1;
	Thu, 15 Feb 2024 10:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oMtOnkp2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 435C487D8A; Thu, 15 Feb 2024 10:04:09 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C6B58078B
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 10:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41F93ntr070691;
 Thu, 15 Feb 2024 03:03:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707987829;
 bh=xBKv/JcMcjvq1a+oN+ahHysyMRi9qQdc/kXLVUZk0Js=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=oMtOnkp2kfiHT+CHv7ZA2BFg5sjhxnFxgybhPR5uggksaVa1MvAmImTtACMYm9ji5
 oSToC+3MKtRjkQ2s9NwUdKtYzHWTPa7SPTcJQF9fKKsQbUcxB46jMfBFALZCDEidcX
 PfIVZ3IkMhoEAdi4KnfBZdaoVzqWCaKwDC23fbuw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41F93n0B070252
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Feb 2024 03:03:49 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 03:03:49 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 03:03:49 -0600
Received: from [10.249.139.5] ([10.249.139.5])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41F93fdm066578;
 Thu, 15 Feb 2024 03:03:42 -0600
Message-ID: <d7298f55-c565-457b-a9b5-52980ae63f1e@ti.com>
Date: Thu, 15 Feb 2024 14:33:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/16] arm: dts: Introduce j784s4 u-boot dts files
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Apurva Nandan <a-nandan@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Simon
 Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof
 <bb@ti.com>, Christian Gmeiner <christian.gmeiner@gmail.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
References: <20240119175043.3904751-1-a-nandan@ti.com>
 <20240119175043.3904751-13-a-nandan@ti.com>
 <20240119191743.xtxtuhnmhw7eq662@bonus>
 <f7cd5cbe-7c14-429e-b5c1-9f994f3ea4f7@ti.com>
 <20240123205255.i7eynu6vdpoxwybf@irregular>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240123205255.i7eynu6vdpoxwybf@irregular>
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

Hi Nishanth

On 24-Jan-24 2:22 AM, Nishanth Menon wrote:
> On 20:28-20240123, Apurva Nandan wrote:
>>
> [...]
> 
>>> in j784s4-binman.dtsi:
>>>
>>>
>>>    &binman {
>>>           j784s4_tiboot3_hs_fs_template: template-9 {
>>>
>>> and then in sk.dtsi:
>> sk.dtsi means sk-uboot.dtsi or sk-binman.dtsi?
> 
> you wont need an sk-binman.dtsi with template. sk-u-boot.dtsi and
> r5-sk.dts ofcourse will instantiate the required templates!
> 
>>> &binman {
>>>         ti-j784s4-hs-evm.bin {
>>>            insert-template =<&j784s4_tiboot3_hs_fs_template>;
>>>        };
>>> };
>>>
>>> This allows boards to readily include the template for the binaries of
>>> choice and generate just relevant output. Wont it save much confusion?
>>>
>>> [...]
>> It is still little unclear what is the full thing that you are recommending
>> to implement here.
>>  From what I understood, is it as follows?
>>
>> - Three binman files will be there: j784s4-binman.dtsi (soc binman),
>> j784s4-evm-binman.dtsi and am69-sk-binman.dtsi (board binman)
> 
> Nope. just j784s4-binman.dtsi with bin file templates for different kinds
> of devices.
> 
>> - j784s4-binman.dtsi will be a SoC binman, and will have only templates for
>> all tiboot3 gp, hs, hsfs, and tispl/uboot
> 
> tiboot3.bin is a an example, but you should do templates for other files
> (tispl, u-boot.img... )as well on similar lines. So all a board file
> ideally should instantiate is device types it wants and overrides of
> dtbs it needs.
> 
>> - The board binman files will include these templates and update the dtb
>> files in them.
> 
> Correct.
> 
>> - Final board.dts will use the correct board-binman.dtsi files
> 
> if the templates are abstract enough, the additional code will be so
> minimal that we wont need a board-binman.dtsi - just u-boot.dtsi and
> r5.dtsi can include the relevant templates.
> 
> Hope this helps.


So I took a stab at working on this for couple of days, a fix was needed 
within the tool to allow binman to handle multiple consecutive templates 
which is needed here etc. which is why it did not work as is; but the 
built binaries are still not stable for boot. I think this will need 
some additional work and debugging. As of now, templating is not widely 
used, so I'm guessing some more minor fixes would be needed to get it 
building as we intend.

If you are okay, I think we can take this series as is for now, I will 
take action to start off a series cleaning up and using templating for 
all the devices.

-- 
Thanking You
Neha Malcom Francis
