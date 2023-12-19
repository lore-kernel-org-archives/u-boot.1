Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3AFC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 19:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA99F86D37;
	Tue, 19 Dec 2023 20:19:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j9oLOoSx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3903875FD; Tue, 19 Dec 2023 20:19:29 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDCE586BFA
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BJJJHMB104399;
 Tue, 19 Dec 2023 13:19:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703013557;
 bh=EpikwyY4VUXLT1Pnn7U+HDwNq8jdBSanzbVzcAujakg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=j9oLOoSxUcIgyV77bZwE9xp6hN24OKJIAdao58CqqrPc95rjqF+zcNKiDJkObkNRE
 VCG1RjvdG8Jw0kTn8Nxvl7LqiNHx3yPm6dc2dRXzRuPlhi4B/Sup9QSzWbbC2JpazK
 ji6mftWBhECUSABIKAeERZc5Illxs9FMo7FcVvWw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BJJJHC8055318
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Dec 2023 13:19:17 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Dec 2023 13:19:17 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Dec 2023 13:19:17 -0600
Received: from [10.249.128.104] ([10.249.128.104])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BJJJ8GW016024;
 Tue, 19 Dec 2023 13:19:09 -0600
Message-ID: <3d113c6a-0e41-4363-acde-a1bc2adf1fdd@ti.com>
Date: Wed, 20 Dec 2023 00:49:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/17] Introduce initial TI's J784S4 and AM69 support
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
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
References: <20231206123753.1486031-1-a-nandan@ti.com>
 <20231219174538.GX2513409@bill-the-cat>
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20231219174538.GX2513409@bill-the-cat>
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


On 19/12/23 23:15, Tom Rini wrote:
> On Wed, Dec 06, 2023 at 06:07:36PM +0530, Apurva Nandan wrote:
>
>> Hello Everyone!
>>
>> This series will introduce basic support (SD and UART) support for Texas
>> Instruments J784S4 EVM.
>>
>> The J784S4 SoC device tree patches are taken from kernel patch submissions
>> and will be updated as they are accepted and merged to the kernel tree.
>> All other patches are specific to SPL and u-boot and do not have
>> dependency on other trees. Appreciate a review for acceptance to u-boot
>> tree.
> Please rebase this on top of current -next as it doesn't apply / build,
> thanks.
Okay, sent it. Thanks!

-- 
Thanks and regards,
Apurva Nandan,
Texas Instruments India.

