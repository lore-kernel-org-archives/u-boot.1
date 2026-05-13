Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E8BCD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 23:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 411E0838BB;
	Thu, 14 May 2026 01:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ML39EMJM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF7FA83E36; Thu, 14 May 2026 01:39:17 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 295278341A
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 01:39:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axz+uxHaSb/hFwE4dKmIrWq0V8Qg4S4CnWUGBbCEhzT7kd0wzY23cURcnEb1qBnhdGglLxTKIagIwID7QBGdehIxUFJLqF0ZUiFjEOJhownFOAzbQGVgRajHLJmXIYLHZVL2H6Mt4sIp+AWfLHWu5zs2QaxujujHiJ8OueyKI6HP4eAb3peq1kIyFDo3jLBO2K5quuf2vlokDvMBG1yokgVJc5V50qKqQFeSbZzq7AC75vRYUnynUUsQB8+/KGAJePuYOUozPaxusLRXf7tp3gwB78Ti1w27EUgqSVkI0nLTIFwGMKz/4qctOOkrY32FWe3y4OenuQ9bIFyv3kKGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjziKNUB8E49Oxbvw4mVJ0NZBtOZhkseFAvj/jPYSJ4=;
 b=yxuoRz1sSNGQL+wSYk364Mu0bJofj0PvK8nMFeALGTka9HK3bITWBtPoYVbuCb3vk51X62VBckYMo4piwCMd4xH+9oz6IukB15vs8blBqX0I8CLxSb4xpLDnoSmxXl16b3JKIn03mSpDBtM52fx+gqZcNME6tWnDzMt5JHWXFkWMd5woVVzhalyXGrE1MMdNVV4Mb6mWRLEfI78Zw4mmbAA0T4hcWS9hmcyzwfQEE5ppU2+Eq98pQdLBTsc0Gc5jBdm6yvOfKJ2Mw0WdE7wKJWeggUD8bhzMxvyDx3kHDRHGbGs9ltHecLZCaBZhHTLYhNPIkoCLo6PfWMjPVELpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=altera.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjziKNUB8E49Oxbvw4mVJ0NZBtOZhkseFAvj/jPYSJ4=;
 b=ML39EMJMrL8LkwXDpm/qhDgoaFFwTaOpqPg8tuXssbxyxf/gwXTUF1suHnp9BAeduxyZkP1BsKbSgXpit4Wqsclq0LMY6gHcJlSryhKV0TjqYh6kcCxsxQRiBnonvtAlu0AFBJ6SgdM+pzJrZzQrd7/WFM0ZJpPZA6IZbpSFWLc=
Received: from MN0P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::8)
 by LV8PR10MB7725.namprd10.prod.outlook.com (2603:10b6:408:1e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 23:39:11 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::30) by MN0P222CA0005.outlook.office365.com
 (2603:10b6:208:531::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 23:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 23:39:10 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 18:39:10 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 18:39:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 13 May 2026 18:39:10 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64DNdAnx859369;
 Wed, 13 May 2026 18:39:10 -0500
Message-ID: <52ec8007-ce50-4f12-b796-4b8c2aa1822e@ti.com>
Date: Wed, 13 May 2026 18:39:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sd: Handle UHS-I voltage signaling without power
 cycle
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <peng.fan@nxp.com>, <jh80.chung@samsung.com>,
 <marex@denx.de>, <tien.fong.chee@altera.com>
References: <20251021204526.22701-1-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20251021204526.22701-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|LV8PR10MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df93b19-10e1-4af3-14da-08deb148d567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NMHdgr7X5VkOg/XQSPMl8M/GwIOZYv2yvXYLECq9LFdzwD+YpJGulped5HKM1cLtFLA5AqLZIM6cqufr+/WDICHLUcshfuOgpa7fYIOJKEtd9wzRuL15bnh3UkSIWhGAXo6SxWpYKE/5U1YI5eys5shW87mVtNKNnNQeoh4/ZMhV72VCvMinaKMaR1HMAWPUVrgJu/gXy4BCfMza7AAw9AtL6+wtUo/99KSax3An7GOFL4zIenRvuBIwTowXFsiAyyv8dc8kosF66NTyMf7QmWfTTVX14iqfGnogBMr4yjBr04K1DAbmex0pWjr2dcThhYfzvOtnTpIfzPTuzP9WOrxF/hpk7s5P67YRyBjtDIhuxWINedB/W4I2fouLUAw034st0dF+fcLDTB3JqkbbMnxP6g6T92hmEoVfGnlHPolMbLJm5I4Nq++1i8S2IG2wjjxhSzQ/thMRkDC9JZx+WDZZX5S4XXkKtNkmyFO5J17z7HY51/Pjty+QGU7lrr/f0FzfHgL0jXVsBgyzgXV+wWY0ce73w1xcOBR0ZQDKNOIPFGFmpAgSPMwH6NLAQ90chVmc9is/7wPEZJusVHAMzOGFtb5GNvuW/PB41afG6eF+YtUK5q4wyw4W1Thn3yhe4ajwxf80NFWetmj2LlkqytEZntKWyN/EoN1jTEZV+UdSPaBlHiuAxtWESqmj37DuUrlUk3xWMAi+Qq6lL0cs2nQqPzDjd7KfId797oNwqrc=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wP7Qbh3XGbus8ahSZqGGlUd/FkupP3kJ3tNtiwyqCsE5icFaJkqKA54waHOvMZM6aU6fH4kgH0JzPiX1MUP5zQ6hQISjkaQXzROtOSi5NdzsJ/2mYGkLBiSIEQLmEMaV1hd/V2YN+H3iZ14yrckNU2KAi9we1fqrIokKn8rKAyxyZ1kmR+e1TDS+JqkuNdVRKGXND9kI9q1C1CA+Q4ftvwKbBOkwJDQlPq4AbQnWI6v65mbgFyQDNNbBIrJuKG3RYwvYrWzRwckvJ7dlyBkviSFVi8t8Q2VZvEvE779GguDALU3WAE70RmKWN2vcKu7uXTZLN/KZzh7S6gmzZ/Ms2t2zYy3uoSKfO+eVUeJbEwzQHmHrh14f17YH9uxS7K2m8+EH7SwIXacDPXKdFtPg0XZ0V8Nbg+qCEA5EvjmMFXNHzLsnfuLPEeXXrvfglqLA
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 23:39:10.8063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df93b19-10e1-4af3-14da-08deb148d567
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7725
X-Mailman-Approved-At: Thu, 14 May 2026 01:53:29 +0200
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

Hi Tanmay, all,

On 10/21/25 3:45 PM, Tanmay Kathpalia wrote:
> Some boards have SD card connectors where the power rail cannot be switched
> off by the driver. However there are various circumstances when a card
> might be re-initialized, such as after system resume, warm re-boot, or
> error handling. However, a UHS card will continue to use 1.8V signaling
> unless it is power cycled.
> 
> If the card has not been power cycled, it may still be using 1.8V
> signaling. According to the SD spec., the Bus Speed Mode (function group 1)
> bits 2 to 4 are zero if the card is initialized at 3.3V signal level. Thus
> they can be used to determine if the card has already switched to 1.8V
> signaling. Detect that situation and try to initialize a UHS-I (1.8V)
> transfer mode.

This implementation broke am65 IDK board SD card boot, I have still
to check why this breaks only one board, potentially there might
be a quirk only for this board... But for now sending the question
in case anyone might have an idea what is going on & save me some
time.

~ Judith
