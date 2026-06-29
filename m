Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48B1C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 06:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7AE8841F2;
	Mon, 29 Jun 2026 08:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="SwUXkqIj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A09584832; Mon, 29 Jun 2026 08:24:22 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C4A284105
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 08:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vl3RLdn+n2kworsabxyNgcFhd+P7ZMt6vhb0Lud0jydVAHhFOArtEOI26oW1uCSaxm6KZ8ThKUsRzy10XiSfxvh6FDD8olFZC5V6E9blnU1V136Y5taZW/3ngaysyFN3X1joOEls0a9XLwe7DYukBkI8biD30W1b1QMO6oQKCYDBS3uzajkymflsOtA2HHbor9oKbPZ4kEUg3K8U6c6lhXETVAxtVBbchZSMO57Rbq88rOc2Uz37BNejyzOkNujCdc5RrR6/CF88fq8mBiJcE9Fosm2szcq9VFHsOrWkmxNW8XotChaKQX365lngwakmx4Z0/8UE0GjcVSFK1YaIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQEQAVdAyTYDbnSIPdQFJlWlj/Dyb8xqx1m/kIpSEIU=;
 b=tDp8HjV9vvG6vNDzovAjk0tTHvlGTc9AzZ40YHD1n9HB1iku/5ZLzm7Mq1Ip0awPMkAsNtjHPLu4QlHeR6omsEAVWQMwuqpzVqWuDcMaxXvkSF0pE3GTKHBo0Vy9NUqHC9LkxNitDNIfRyQuRE6CuuQ2Yfd99Aein2Ub9Z2/7Hrs+NZE3KWEioB54e9Mpd779VuF9V0wXsU0DsYbAfgdE+GbE5Sr3n0aek2yb1Ao5IMA+Y6l0qGWwptazr+VAA13q5HxOHVzE5pzqfjl11VYwmDHvzj9MWtBt2MO8ULcuDDadqVqTpMRzbG1N9ggKB8cqgSCXRhG5pp9l7AhF6c+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQEQAVdAyTYDbnSIPdQFJlWlj/Dyb8xqx1m/kIpSEIU=;
 b=SwUXkqIjB1hRdnyCNfldb69HFySp6UQRMpFzNYZI3ESzjyls8YZWkOohTAOXrEyNQ5piye23iPR6abJT8AWEMROdcu8mtNexqifmxd8Q4ACv2JTcxzoILKOKv7GNzS/anKHMSLIkO4sGREfFukLsf/2N2vFADzoZ1AM7FjABtV6vyua4iDbiQdM1pT9idHBwUyz64g/3CwC/mhhZcS+OPdZ2dMSulmRmefmbXvU/QSjfC8C2qbeZESZ6FyV8BCfmX5aZy1CU1LPifeErsEh1wknaNQIu9YhMr1dhRIVUgI4om60zIZInfcpaD77GSVYpI1V5dvIQgN4oFHuUWvV1fA==
Received: from CWLP265CA0517.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18c::18)
 by GV1PR10MB8734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ce::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 06:24:16 +0000
Received: from AMS0EPF000001B5.eurprd05.prod.outlook.com
 (2603:10a6:400:18c:cafe::7d) by CWLP265CA0517.outlook.office365.com
 (2603:10a6:400:18c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 06:24:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001B5.mail.protection.outlook.com (10.167.16.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 06:24:15 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 29 Jun
 2026 08:28:30 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 29 Jun
 2026 08:24:14 +0200
Message-ID: <d239690c-4503-4c60-90ce-478394aed4c0@foss.st.com>
Date: Mon, 29 Jun 2026 08:24:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Move schedule() in
 sleep_thread()
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
References: <20260625-move_schedule-v2-1-2e4abf0c5425@foss.st.com>
 <750d6e53-d48b-4791-8544-6d5edf7a895d@mailbox.org>
Content-Language: en-US
In-Reply-To: <750d6e53-d48b-4791-8544-6d5edf7a895d@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B5:EE_|GV1PR10MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: a3cd776a-b675-4f90-48db-08ded5a70b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: E0ha+U+nmfTdkTTQC/I1gc2OhdX6E9l7EpIYd1oaX8q9UMW+Xp/mtPFfub8U7Rg+mSH/IMxLQ4qRzF5TBFOTCjMqj0up+OH11xDMoc2RcpN6DG4SYDSCcazS3t0Mw+i7qbyOJuOIE+Ytt2oO0TzkhSOpWqiWUEWE0CikXMbn+ymOS5T34x5Hcj8InR6IJ5yzM/RhDgnDGxMuczxY22BOhFNWMWAjJI5A1lYL9UKWeSuNcwZ2FWFtB4UtNOL263/oQQZWnJQF/mfR2k+LURe6IV9s1hg58Ff0nd/toyAoAMdRaeKpdor63MpVmsP0X93JsfPRcv6nOdAy+Fo2PSSeR/skPpS6XzKk3KVprOsYTuMPcma1TVIou6vHEUspQZ8QqttgBhO63id4mkklsn/O60GSef+2kVvo8L/r7AU81Di2qi+okZnci5E0LioPBx1EGH0/s48IgBmC4+z4nhQCgpyOFayjb4vNlZtgH9xgMaOXF4bv97Gfnyrw48C0dGV0I0t3cf5oU45T5doDupcZYv3IlMpwmJs/Zh3i95hg23uaqqPrBbybYL8gNyJY/wfKtjBcceB5RtD0XTXYl/3j99Wiq9IBRtvlohy9eeQldLiJU11beyfxBC9WCjAABVCXUo1nqh1+5L7tuk7rGIHFbOwYIteMlC2ZSlBZCfwD/eObq7sX1kwDegkBcII1TFTtCj7RrWQ4xk2sFgcLOjcjvQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KdFipHSzwFUnrDSZO9OHEyT2NmdkYQRuuTPriZxyukzdVs7E69afNX5WWhzF8QX0k7yAyIHEeXpxPJfWKxFtrpraH3lDEiwnnJAmOx2ltk9c7gVYDdLWRX0FKtwkqdkeKn33Vx/DXXlDytnpoxXLqsUe77RRx9VRJMKqpJ842JWWgN5o1HiDGUAuVlN9iymxpaedPFTJ1nZetIhWtiw4HDFEAdEDb7S/ezvghBtIkTrMqpIfeqrX+C3GrVIDiQsBHLunajEnW/d/ZLJYQbtAU2cr+hNyCtTT9lxa/wyA3hrNh3NXmS5mmfay4ATFcK9mxp4RtSbCN5mYBiUeveHdJLUmbHJ/vgDlpqxG3vmVJ/SIgTO2hoR3/RtadyXiUlRPdiUMmK/W3RlsAnQEAnGbl9B0I+zjPTnOvVmGVxYW3sS3cPMHlohtrMA5eUJXi1Pf
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 06:24:15.5937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cd776a-b675-4f90-48db-08ded5a70b2b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8734
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



On 6/25/26 14:36, Marek Vasut wrote:
> On 6/25/26 10:38 AM, Patrice Chotard wrote:
>> On STM32MP157C-DK2, when aborting the command "ums" using CTRL-C
>> it may take a while to get the control back on the console,
>> sometimes around 1 second.
> 
> Why does that happen ?
> 
> [...]

On STM32MP157C-DK2 board, there are 3 cyclics registered which are called by schedule():
  _ mmc_cyclic_cd_poll (1 to 2us) every 100 ms
  _ watchdog@5a002000
  _ video_idle

schedule is called on every loop, whereas ctrlc() (CTRL+C detection) is called every 10 * 20000 loops.
That means ctrlc() is called every ~700ms on STM32MP157C-DK2 board, 

Moving schedule() from main loop to same level that ctrlc(), it allows to call ctrlc() every ~70ms
which increase reactivity when user hit CTRL+C.

Patrice
