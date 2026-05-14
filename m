Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4E9CD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 22:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01A4684663;
	Fri, 15 May 2026 00:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jDachWHm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AA958467A; Fri, 15 May 2026 00:28:44 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FA988464D
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 00:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ha6ySr7klTpXenjGOaGdtH4/dhaZHHnmERYzq+xJAL9x40PENbgzvL1U6FMnYeiUhq0IOaGKbFMXF+TU1ANeSov/qGUgbLvgXfcB00CuW0R0vTPWn6SJqGBk9lvI3AyJkN9rBqjpQV+oe/I2ouDce+bNce46H8eX6KwwdnnK2d9aIstpISSvIU/7mTKqw7oeuPdFe2D4J0o01ahki6sUSn9QB6A+aF90e/d0GAoj9Dq9jA0QGaOSzRYFM8N9R0zsiGKsFsitElA5OKcMdFxVAVJLLX+J66FMRxu4tA2ySwfcxLi+hz13x5gkl5sM77DwTa52HiQ4GFbOz1x32aC7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nH3nDVytDkpVqnz/Z2UkuVs56rRdh2UWtTWtaNCT/xg=;
 b=e5Cv6RYU+DGpygyvOIikFm4sZ8ob/uSwH+5+8B8zmR1Fkkvgvm7DXYeV6LRETn8h37a2rDZTjeiQrx5PMnQWfO4SkCUU80wsIhrbiT8YMTS8iFa0VSDFcmsJy1ZcMEcwbrAryCO6cvAbQblWWA9RS8vbx3kfJQlyIiI4+JSKGzK86RMAgMeCaKzZfIdOi0hSsMU1gTKdfjlN8zwrZxS6DZaB8dqMBzWCEt3l2lUWYz7x2twsCg0uL4ma+RBk8NbceCnlWrt9qVVL/fZXFBRi3usqlDcgh0IIUnuYFuPS+z3sFD9mKc0tP/ymO4qC1B8TVq2OM45O6H9unlOI1wYSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=paulk.fr smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nH3nDVytDkpVqnz/Z2UkuVs56rRdh2UWtTWtaNCT/xg=;
 b=jDachWHmQ45mGV7goGqZedc8BrcERfpCmt/v5rBTcqTnp2V5pqkdPgG4gpRjkpeNcJXQhhQd2w7htnc/F1BAAitYq2l3FYZ52smz7AFdVlAwbm1bt/XEQTe1XplgupIyHDYJPpVS/PzRzSIW4lgEacaZgJgUO34000eroGNe5iI=
Received: from SJ0PR03CA0269.namprd03.prod.outlook.com (2603:10b6:a03:3a0::34)
 by SA1PR10MB7664.namprd10.prod.outlook.com (2603:10b6:806:38e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 22:28:36 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::17) by SJ0PR03CA0269.outlook.office365.com
 (2603:10b6:a03:3a0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.13 via Frontend Transport; Thu,
 14 May 2026 22:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 22:28:35 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 17:28:34 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 17:28:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 14 May 2026 17:28:34 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64EMSYGg3127838;
 Thu, 14 May 2026 17:28:34 -0500
Message-ID: <a47677b2-3e70-49c4-a92a-a3463e02ad53@ti.com>
Date: Thu, 14 May 2026 17:28:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] arm: am335x: Switch to upstream devicetree
To: Markus Schneider-Pargmann <msp@baylibre.com>, <u-boot@lists.denx.de>,
 "Marc Murphy" <marc.murphy@sancloud.com>
CC: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, "Kory
 Maincent" <kory.maincent@bootlin.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Parvathi Pudi <parvathi@couthit.com>,
 "Basharath Hussain Khaja" <basharath@couthit.com>, Paul Barker
 <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, Simon Glass
 <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Svyatoslav Ryhel <clamor95@gmail.com>, "Tien
 Fong Chee" <tien.fong.chee@altera.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Johan Jonker <jbx6244@gmail.com>, Brian Sune
 <briansune@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, "Bernhard
 Messerklinger" <bernhard.messerklinger@at.abb.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Parth Pancholi <parth.pancholi@toradex.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, Paul Kocialkowski
 <contact@paulk.fr>
References: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
 <39c2f5f1-ba0d-45ec-92f8-2e87ddff1aae@ti.com>
 <a02cf44e-c7ad-4abd-a102-59ab1963eb32@ti.com>
 <DHZWV3X6T3B5.2WVH8JEVPPH10@baylibre.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <DHZWV3X6T3B5.2WVH8JEVPPH10@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|SA1PR10MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f6030a-8e6f-412c-47cd-08deb2082346
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|13003099007|18002099003|22082099003|56012099003|3023799003|4143699003;
X-Microsoft-Antispam-Message-Info: 8AaBuazQNsPyOiAFD9Qg6GVe6nHoQQqJ3AtUTVSYozYoxpRv8gVWC9sExkRC/ON+DGQyZF6Xa6LT+VdNdu7Z7hJ6thVx5+UjomLDb+ooFO8dIxrH/kC2EivR99EyGG5nJnztjo4FsEXoE8j4qZndHn4CpVDSYc5U5kvRh3Z9BIVe9nE83qbLFFOXFAkwRdHbD6a9XxzKGlrQRCH8kRVumKIgRTq05I/gP+FrxYa6t9dhc1xRcHro5I0ueRnzMo1GtdIyihTBpXqdhjBKg0RBY9fYzFU/AD81nJPYKcI4tiVwOy0zdg609zL9MXIK+F9SSg+rmwd1dl4kebIZxS1btz2W/f44GDSVzVzRe6TtTCmrkAaBNa0bh1joEhHgV68Tx4Pgi7ZHRM0dbwxLZAHhYgajfJeEMNzNGfGOnCdwnUzfVKCOoBaGN1uanKoeBfFrHyQt7Mn0jThcZnBiP5uEu9ErO6O1HL5ryUi3Lmgavg3HoCVRy3HdzAjjF7UyU41/XP8zp1as2WcJdc3Wv45qzLbNjUZYgE55AC2C0jYE7yXcJ3sjPy/xYyXj18fhyI63c8QHZ51QuIX80DuPSDvMAGvlZcf9nqu7H+v5AGabkLMXwBSxjPjJxKKrDJy9hTiye3oINpK6BIRN3VBwTqxRI1WFdKCFwdt/JwDQCT0tNzyz5P5nL94CRkatt1Gs9u/V
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(13003099007)(18002099003)(22082099003)(56012099003)(3023799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /mA7r75zYFX9PJXnnVFSolZQ2mnwgWoEQtOUfWGGzm40p5p4wZlIMYR/aeHUelizMXfoR04WQeIUciQnx9B6ui/gRmW1c5qCGveUvRslJdMiXLhNGRS9UT2UR15IIfPe0xIHvR2fRekD3bC1wOl5+++sHHymLXqfltFfacxfa/VH55oa8QqjfYYwV+w94VzIpLX99O+71tdyrLCo4EgQ9LgOLnyuzqD0m2xJyPHgkeyw2RxNmffXAZ2t0qOsZ3yJWRoJWCjXWPYY1yVuUWgqXR+G16NQTIUobA6c2cYgL2rJ/LfyiO+MlajtvWIT/6HWcYf6S9eEf4Wx/ZfiZ+3k9NXkVgB7qo6F9MCZt89AfRZxingTaQN7FpNAxDH7BNJHu007l7mxDEj7BeCaz4A1so+Zp488cxNVsSI4EdGGU+YLLv1ZAw4OwPZVpK8c0Ml0
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 22:28:35.3247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f6030a-8e6f-412c-47cd-08deb2082346
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7664
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

Hi Markus,

On 4/22/26 1:55 PM, Markus Schneider-Pargmann wrote:
> Hi Judith,
> 
> On Thu Apr 16, 2026 at 10:33 PM CEST, Judith Mendez wrote:
>> Hi Markus,
>>
>> On 4/16/26 2:55 PM, Judith Mendez wrote:
>>> Hi Markus,
>>>
>>> On 4/15/26 11:02 AM, Markus Schneider-Pargmann (TI) wrote:
>>>> The series is split into two logical groups:
>>>>
>>>> - Patches 1-3: Fixes for am335x-evm to boot and support the LCD panel
>>>>     with the current u-boot devicetree.
>>>> - Patches 4-14: Make upstream devicetree working with uboot. This
>>>>     adds tick-timer, adds compatibility of the board code for different
>>>>     USB probing, makes SPL smaller and updates the defconfig.
>>>>
>>>> The series has been tested on am335x-evm. Note that I don't have all
>>>> other boards built with the am335x_*evm_*defconfig, so tests are
>>>> appreciated. buildman reports builds are working.
>>>>
>>>> Dependencies:
>>>>     - net: cpsw: Add cpsw-switch DT binding support
>>>>         https://lore.kernel.org/r/20260410-topic-cpsw-switch-v2026-07-
>>>> next-v1-0-c914724b13e4@baylibre.com
>>>>
>>>
>>> I have been planning to test this series on a couple of AM335 boards,
>>> So far :
>>>
>>> - am335 EVM: Pass
>>> - am335 SK: Fail (at least SD boot regression)
>>>
>>> Pending to test:
>>> - beaglebone black and am335 ice boards.
>>>
>>>
>>> am335 sk:
>>> without of_upstream: https://gist.github.com/jmenti/
>>> e51e1fc1b25c19f94786ad39a38737b7
>>> with of_upstream: https://gist.github.com/jmenti/
>>> fc17347eff33991a78ce365c42a76a25
>>>
>> BBB boot without of_upstream:
>> https://gist.github.com/jmenti/b8f7151e7666ca16b9bec7ec5b2efe17
>> BBB with of_upstream:
>> https://gist.github.com/jmenti/c22e017605d3d6c20189eaf3cfce6231
> 
> Thank you for testing!
> 
>> Seems like MMC enumeration is switched, BBB now boots to emergency shell.
>>
>> Also forgot to mentioned that there are more failures on AM335 SK
>> than just MMC, related to USB and NAND I think.
> 
> Yes, the mmc node names are different now and it seems that's how uboot
> enumerates the devices. With the next version I have
> CONFIG_PHANDLE_CHECK_SEQ set which should use phandles to distinguish
> them.
> 
> I found an issue with the USB setup which was different from the old
> behaviour. The USB drivers were always probed which was only done on
> demand before OF_UPSTREAM. I fixed that as well.
> 
> Then I noticed in the logs that MMC doesn't properly populate PARTUUID
> for the one board because of the mmc numbering change and it boots from
> the wrong mmc on the other board booting an old kernel and dropping you
> to the emergency shell.
> 
> I didn't see NAND issues in the log I think. Can you point me to it
> please?
> 
> Also I noticed ethernet is not there, probably you are missing the cpsw
> series here:
>    https://lore.kernel.org/r/20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com
> 

Ok, if you are aware of the issues, I have no problem with the patch
series. I seem to have misplaced my logs where I thought I saw NAND
failure, and I will be out of office until May 25, if I find it then,
I will post an update if series is still unmerged.

And thanks for Ethernet patch series, indeed I did not apply, I will
also apply and test once I come back if the series is not merged. (:

~ Judith
