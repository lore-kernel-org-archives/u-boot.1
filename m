Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C8EC87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 16:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 399FE82F00;
	Mon, 28 Jul 2025 18:53:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="C2XOy3Sd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 889FA82EB8; Mon, 28 Jul 2025 18:37:19 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B122D82D06
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 18:37:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56SGauaV2801212;
 Mon, 28 Jul 2025 11:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753720616;
 bh=nmqd16c70kVUs1ielspd2IiRTEoCFdGZHBofys36/FQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=C2XOy3Sd+SdbMbq5y2gCP0zhyLkxSpBURniZe0zmxZLpBygTpdWew5KE5S0+9IwVO
 CXeYjauX8uqrraODypAG6lxVRcYQ4fn/2cMsJGBnbegwQnM3/ZDvnlJvKuiI/Nr0LB
 aLub4k/bSeUHpin05q4XokUAhiZ7WcPLDwuAZD1I=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56SGauEY431121
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 28 Jul 2025 11:36:56 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 28
 Jul 2025 11:36:55 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 28 Jul 2025 11:36:55 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56SGarLe2355670;
 Mon, 28 Jul 2025 11:36:53 -0500
Message-ID: <9303e5f8-9723-45e4-9ef6-5aef6234bd10@ti.com>
Date: Mon, 28 Jul 2025 11:36:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/45] configs: am335x_baltos_defconfig: Increase aneg
 timeout to 20000 ms
To: "Kumar, Udit" <u-kumar1@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 <trini@konsulko.com>, <yegorslists@googlemail.com>, <vigneshr@ti.com>,
 <bb@ti.com>, <nm@ti.com>, <robertcnelson@gmail.com>,
 <m-chawdhry@ti.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>,
 <a-nandan@ti.com>, <ggiordano@phytec.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <paulk@sys-base.io>,
 <marek.vasut+renesas@mailbox.org>, <romain.gantois@bootlin.com>,
 <kory.maincent@bootlin.com>, <mkorpershoek@kernel.org>,
 <festevam@gmail.com>, <a-dutta@ti.com>, <ddrokosov@salutedevices.com>,
 <anshuld@ti.com>, <jm@ti.com>, <sjg@chromium.org>, <p-mantena@ti.com>,
 <n-francis@ti.com>, <s-k6@ti.com>, <rogerq@kernel.org>,
 <seanga2@gmail.com>, <kamlesh@ti.com>, <a-shenai@ti.com>,
 <c-vankar@ti.com>, <kishon@ti.com>, <dannenberg@ti.com>,
 <e@freeshell.de>, <h-salunke@ti.com>, <semen.protsenko@linaro.org>,
 <peng.fan@nxp.com>, <quentin.schulz@cherry.de>,
 <sumit.garg@kernel.org>, <d.schultz@phytec.de>,
 <emanuele.ghidoli@toradex.com>, <hiago.franco@toradex.com>,
 <joao.goncalves@toradex.com>
CC: <u-boot@lists.denx.de>, <praneeth@ti.com>, <srk@ti.com>
References: <20250728145034.225997-1-s-vadapalli@ti.com>
 <20250728145034.225997-2-s-vadapalli@ti.com>
 <a0f6b8ef-ac29-4f53-8d02-c20b1cb0305c@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <a0f6b8ef-ac29-4f53-8d02-c20b1cb0305c@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Mon, 28 Jul 2025 18:53:44 +0200
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

On 7/28/25 10:33 AM, Kumar, Udit wrote:
> 
> On 7/28/2025 8:19 PM, Siddharth Vadapalli wrote:
>> Increase the PHY Auto-Negotiation timeout to 20,000 ms from the current
>> default of 4,000 ms inherited from "Kconfig" for PHY_ANEG_TIMEOUT.
>>
>> The motivation for this change is that existing devices will continue
>> working as-is (timeout is an upper bound and auto-negotiation can be
>> done earlier), while older Hardware connected to the board that might
>> occasionally take longer than 4,000 ms for the Auto-Negotiation process
>> will benefit from an increased timeout.
> 
> 
> Can we think of using TI_COMMON_OPTION , similar to TI_COMMON_CMD_OPTIONS
> 

Or simply change the default in Kconfig to something like:

default 20000 if ARCH_K3 || ARCH_OMAP2PLUS || ARCH_KEYSTONE
default 4000

Much better than 45 patches updating each board defconfig individually.

Side question, if this is right for TI plats, why is it not right for
all the other platforms? Should this be the new base default timeout?
I don't really think so in either case, the point of the timeout is to
switch to a fallback port or boot mode in a reasonable time, not sure
20 seconds is reasonable..

(you probably don't need ~50 people in the TO/CC on this one either, not
everyone who has ever touched the defconfigs cares about PHY timeouts)

Andrew

> 
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>   configs/am335x_baltos_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>> [..]

