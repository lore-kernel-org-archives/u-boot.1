Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D25CC87FCA
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 08:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C63E383152;
	Tue, 29 Jul 2025 10:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DUpLRQ90";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9261882BCD; Tue, 29 Jul 2025 09:04:14 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D9A98144A
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:04:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56T73ZWN2907307;
 Tue, 29 Jul 2025 02:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753772615;
 bh=jfuwP0s+z/Y1eWrEX3p6LAGPsjg3ksG03bdg2LxvI8U=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=DUpLRQ90MtBKP5piUuYFzgxBorg80Zrg3Ju4t1eKqLUf6QgZNWEnJ0nO4Zb1IvLzV
 r/PjjwnOEeR4L0gDxs8VE/yJoTBenub5hx90hdlvOOo4f5gLJNBlEV0nw7HVZ3/Ran
 l4bPY8qZFoA5R3QV9V1FDQGJ9g4B8RpGLAdrcyPE=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56T73ZVZ2268797
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 29 Jul 2025 02:03:35 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 29
 Jul 2025 02:03:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 29 Jul 2025 02:03:32 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56T73LHL3014656;
 Tue, 29 Jul 2025 02:03:21 -0500
Message-ID: <d78ccd66-04ba-46c1-beb5-4412c282783d@ti.com>
Date: Tue, 29 Jul 2025 12:33:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/45] configs: am335x_baltos_defconfig: Increase aneg
 timeout to 20000 ms
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <trini@konsulko.com>, <yegorslists@googlemail.com>, <afd@ti.com>,
 <vigneshr@ti.com>, <bb@ti.com>, <nm@ti.com>, <robertcnelson@gmail.com>,
 <m-chawdhry@ti.com>, <vaishnav.a@ti.com>, <ggiordano@phytec.com>,
 <w.egorov@phytec.de>, <francesco.dolcini@toradex.com>,
 <paulk@sys-base.io>, <marek.vasut+renesas@mailbox.org>,
 <romain.gantois@bootlin.com>, <kory.maincent@bootlin.com>,
 <mkorpershoek@kernel.org>, <festevam@gmail.com>, <a-dutta@ti.com>,
 <ddrokosov@salutedevices.com>, <anshuld@ti.com>, <jm@ti.com>,
 <sjg@chromium.org>, <p-mantena@ti.com>, <n-francis@ti.com>,
 <s-k6@ti.com>, <rogerq@kernel.org>, <seanga2@gmail.com>,
 <kamlesh@ti.com>, <a-shenai@ti.com>, <c-vankar@ti.com>,
 <dannenberg@ti.com>, <e@freeshell.de>, <h-salunke@ti.com>,
 <semen.protsenko@linaro.org>, <peng.fan@nxp.com>,
 <quentin.schulz@cherry.de>, <sumit.garg@kernel.org>,
 <d.schultz@phytec.de>, <emanuele.ghidoli@toradex.com>,
 <hiago.franco@toradex.com>, <joao.goncalves@toradex.com>,
 <u-boot@lists.denx.de>, <praneeth@ti.com>, <srk@ti.com>
References: <20250728145034.225997-1-s-vadapalli@ti.com>
 <20250728145034.225997-2-s-vadapalli@ti.com>
 <a0f6b8ef-ac29-4f53-8d02-c20b1cb0305c@ti.com>
 <1c747fc2-f622-4586-ad7a-6d295ebf4a9e@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <1c747fc2-f622-4586-ad7a-6d295ebf4a9e@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Tue, 29 Jul 2025 10:28:01 +0200
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

Hello Siddharth,

On 7/29/2025 10:45 AM, Siddharth Vadapalli wrote:
> On Mon, Jul 28, 2025 at 09:03:49PM +0530, Kumar, Udit wrote:
>
> Hello Udit,
>
>> On 7/28/2025 8:19 PM, Siddharth Vadapalli wrote:
>>> Increase the PHY Auto-Negotiation timeout to 20,000 ms from the current
>>> default of 4,000 ms inherited from "Kconfig" for PHY_ANEG_TIMEOUT.
>>>
>>> The motivation for this change is that existing devices will continue
>>> working as-is (timeout is an upper bound and auto-negotiation can be
>>> done earlier), while older Hardware connected to the board that might
>>> occasionally take longer than 4,000 ms for the Auto-Negotiation process
>>> will benefit from an increased timeout.
>>
>> Can we think of using TI_COMMON_OPTION , similar to TI_COMMON_CMD_OPTIONS
> Andrew's suggestion of updating Kconfig [0] seems better to me and I will
> prefer that approach. Let me know if you think otherwise.

I am ok with Kconfig option as well.


>
> [0]: https://patchwork.ozlabs.org/project/uboot/patch/20250728145034.225997-2-s-vadapalli@ti.com/#3553223
>
> Regards,
> Siddharth.
