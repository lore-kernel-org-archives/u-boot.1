Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F889C4450A
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 08:01:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5624384C42;
	Thu, 16 Jul 2026 10:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="LvxEoHh9";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LvxEoHh9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 166EB84CCF; Thu, 16 Jul 2026 10:01:23 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ED6E84C15
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 10:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ccp7q3cAQi62j7OFmMw26h48V1A2bpO87O5xdJ2It3hllhyQ/zvMeg8Z/lqp3NZCDnfDrXQV2FnzHjkoRpb747BmTzRdDcGcYeuJ14K2zoNAFTkN/9JmcsSLi8phG3mgxxnfwXbNCnYaswiH+pn61OOIWN44PAP9gLERA70TvjcLBsPZMxJ+NLAwQOr8o7U947xY6XJSnUAJlfCPzNEWNCvqbc6VHneBgCtLnM25rH+tOF/F5ooyM7eG8icluGmAREdWyiQmHSPznWvwXVhuTAvVwdb4vpkxyRCRkAwSx8ERqXZ5SOR0tlgM1bM0qih76kP8xpwQCHamMR1yI3LwiA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wqit31LpC+1vGi5dS4i8HQHNosQI/WcvL+Rw42EQj2k=;
 b=TT4ZD5tNrXr4wEiVKdR/gXb6fVPQFNVPYNkA6kipSNfzLHsBIDN6axzbdPLqExar3hKkAD/nKonnxPE7hdxeuBAX4K3XkiRsm+qVXxEwdzanxgntJYlEPHwGIbzn0BjBI8LPE1q9HlmRh7g4iz4fd9c7XaN1BEnYFVBnf+c5cti0mgFggA1YUh5zHAisDQhiKRgb3aso3scObM+ZRmhrAo3k84xPb7d1qO3Yd426UEAiKGOeOYNG20oilH+/nT/46vausSfvKxONEFyYY1dfoMmfl0uBdNOk8kQgBkGd3jiYP4jelGHae4ucx5wbSNMsvCOwQEfkgLLguWynQE9XNQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=mediatek.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wqit31LpC+1vGi5dS4i8HQHNosQI/WcvL+Rw42EQj2k=;
 b=LvxEoHh9pdiTddVdOgDA/SSUyCFs0dIe8N2tH7REpL7xBWY0K5WEa1NbbyMjjQx+Sz1ADEk4O5kRQOwvfKHUa6pVNJZ/Pf8wld8x2+tRNkX9lrJm57CzQ+D0wbNjg5vlTceeC/Y7CxOzIGGOroGMwCfOuxu/nHCRZMSUIQoCbSw=
Received: from AS4PR10CA0024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::16)
 by GV2PR08MB8028.eurprd08.prod.outlook.com (2603:10a6:150:79::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 08:01:17 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::36) by AS4PR10CA0024.outlook.office365.com
 (2603:10a6:20b:5d8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 08:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Thu, 16 Jul 2026 08:01:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bqu6OI1ZN0GojLPd/LCyFDUIdiEpYUvJpJSyzdUQb65VuSBGRQLWHOVejgX/D65lGvJiIYbLTfCW9Vpsm1EVCBbxvvXRMZI3PkmDll0M3Gu8hL7OaSne6HHI2ADkf9WalWMyuALVF9XL42zOHjLlNPr7y1k83YrIZoErmwnQf6EQ81bEXjwzKBFZfvmFIQ4VNHU7/0m0QAYTx7OF5OY3ujER9AtEOG1pn1WT76J6iPRQqhSn52x+str1jilfUAq4c2PEbazgVTop6i0j3npETwJKBjxdoxGMQq/TigpAy0qDcp4Dk6lvQwmQRncskBw8NMhQNuofJkhzcbSPS7surw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wqit31LpC+1vGi5dS4i8HQHNosQI/WcvL+Rw42EQj2k=;
 b=SbvHe7PlCjzypVYKKz6DUG53kWcJcbQT8Jwe4qeNfCEINfIpOkRncCfo8Ayau3F+8zZEwBMmRoFaJnHXbHZXrEepdc4X8w0ZBH3GorH0EB9DoPaIDA5A/gajKLN2ZHfE5EhX/fUWxVz6EC8v2Gg+34XQElz+C9SvrwkmcKuXVXwXygXUXdD9jbuq89Ve8YlXXrOekmwb+uR+ccUoThJ6jwl6hXTZo+nIZmUYHuu1+tIZ5zkDWb6xMZ8iWKLkDLXxxm1LAeWSrtspVdOyKzdTxcajfU2beZtBP3pjRKAi03IcZRxuZtPphVGKyCmFVWpM2cpjuiWwRUSU8wxrex8g7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wqit31LpC+1vGi5dS4i8HQHNosQI/WcvL+Rw42EQj2k=;
 b=LvxEoHh9pdiTddVdOgDA/SSUyCFs0dIe8N2tH7REpL7xBWY0K5WEa1NbbyMjjQx+Sz1ADEk4O5kRQOwvfKHUa6pVNJZ/Pf8wld8x2+tRNkX9lrJm57CzQ+D0wbNjg5vlTceeC/Y7CxOzIGGOroGMwCfOuxu/nHCRZMSUIQoCbSw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by VI0PR08MB11383.eurprd08.prod.outlook.com
 (2603:10a6:800:303::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 08:00:08 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0181.016; Thu, 16 Jul 2026
 08:00:08 +0000
Message-ID: <85e975e5-3be3-4b48-86eb-7f3b4baf69b3@arm.com>
Date: Thu, 16 Jul 2026 10:00:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: handle chained pbufs in transmit path
From: Jerome Forissier <jerome.forissier@arm.com>
To: Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, nd@arm.com
References: <20260715084236.172815-1-weijie.gao@mediatek.com>
 <c62bd0e1-3a4b-4dc2-ac46-d310a7d53c19@arm.com>
Content-Language: en-US
In-Reply-To: <c62bd0e1-3a4b-4dc2-ac46-d310a7d53c19@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0186.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::11) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|VI0PR08MB11383:EE_|AMS0EPF000001A4:EE_|GV2PR08MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ec32da-0272-4c1c-10f8-08dee3106995
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|11063799006|56012099006|4143699003|3023799007|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: L8IdCmEmzJuo0nHAjjGPWVUw8uucZADOt6XoGU+YUL4m5EQKl9r7qW3qMcpsahv/ZsXF74MnioRS63EC5k2JKiV8TNFs3jLuJyfOcj1VYTAC/ynBNQYHAX2qW8vQJVx1iQMyiJncYdq4Y8A0nKZlUyZp+4t+u27Miis1/2gDx0gHLjztqfGCNk+bg14S+4eXKqOodMq6DEbXdvOtsWFpA0TuI1XFUdacILuQDZuAns9AzYg4V4Qpaou47wH95kGu/N72PNvWEBnE0eE9QFdsRFwgrcZ4ILiLUj+X/qjU0Euy7bit0/IhAGBiMFtrMegscpF33+oFbEDPpPIXLKtfQgf6ugCs9nlAqKlOVp35WdKNBnV1bRFOnM/pqXrQeMLcsoRGGyQcjaOOa0mRo5z8hbNSVZEay3S2hAOGF+OFOAD3nj2QhWv6hgnqd+CgmGL5IHbJPgBdOilbckuxBEr4zHyz4Yt+O98XA4WSJuaW+3YOhoidOKl+/ZB/8fgE5EGPLkeb6pK8GeBPDZ3BChcIEDIQCNhWH853EGh83M7Cah9Nz6gMo4Oh1aIgFQlukzGozGhIaxQaaSX8jKFVWHKAx6nybSXiXujdQ7sr6fXk3lBHoSOoezPZsU79i651lodg1lu9KepxkWUk+s8Ou8b1hsNzwkK/VFNmic48TXKF9aU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(56012099006)(4143699003)(3023799007)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: YzU2NTHoMbcmbX9lKbFFufGCCcATTJBjO3y8i9Rn5NPMpOPVej78bev47SCFPhs8qjyHctb3SOmWuGk6Cx2VeKkMyYZFN2UwP0jWj6UvDXr3Ay0C7PiIC9I5fo7KsIpaTEQfVtN5c8KMxmhifz42NzaYSSvPO38dcMzcSUOqJw9RbDl4ryW1kOexTqxbp/M/o9upB+Frhy5kBUoBmGqKYIo70VutiTUPb1sSVZgM1Srn51gckqCWRp3eH/J4GEJn5S8cDfVfYbrcyj9bWi1d0sMAiBkM7e/I1Ln5C/kozmoM4MUjk40TEbZU0tJeK2BZvWdEKrajM9U9fScfohelOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11383
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9e91c066-96b4-4957-2fc3-08dee3104137
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|35042699022|376014|36860700016|14060799003|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info: PhjSY0WxwOEcpoPvGGUaiFzXZSf9r3TWPJrP9A5vTGPO3eZcNlOzfa81eRPeTiyoI5qMxxSPXgVJROB0UzbUuBX95j2fsEI6/zfY6DgondssYHUBJgxmKhppPpAWQxA8uK4Rw6F2zr28cW3PusnpAbzKR3VhLR+rgrCjKt2MsZz3r5yKBWumqI+WF5AHLsWztngn7SlGJqZxbY8uC0zZd4lXGAlPypcD1HL+NJSHVomwTMhskI7Z7McjU1FqvL5GbmG4mHKCzPBXslXWyB1psuToLVC7LMWMpavow4hVJTqKSV5fmGLesVDbh5Za77rml/Abn+1a5IT5Buj+Ad0aCgMj5ZeidTayV7nTY4JYTJQCssQPabfHAtPUhyZ2pn9qG4684miFBdPqQYSBMSamL03ILfMmA9E0bOjpevr9D3TOAxCJT1d/fL2rbi1nEgJHYM37QPLeOGG1I9HQ4n7/6tXsVbs7uFCGgVkt+2Xy7fIppcHhhzfwXCSIVmKNTBF/Tgpt2aNe7sNNvO9RdFwxAKK6owjrv7EInp7fgDarG8cQuZSvhoz9rbRxtkfZQJjFn/rvH+msEQFY9K7Q+m+rqBFu0TtEq95vnYo2OUMysw5cNMJeAcp2o4iIyDpJgic6mCSY3QFe1jnFvxkeKI5/fm4ktPlqAPIq2Adg8GAA3XxVd/F6uQ278lGlK9VRl9DirREtmOUBGzdNtDRLc37YWg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(35042699022)(376014)(36860700016)(14060799003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q58LDxeZAOVLOC0HwoFoAkaE5DlYJNiVKIxPYoxs57+mCpEYd3PXZJAR1hB5H9zqsiM/yMkCKHAaoEEhREauhtZhn0lTxHcVcG4O5NH8oLK+vDGaYJIeRI3C99e+51OfpaDNhuPTclb8egghOd5FgG7893PyrL9k0DJO6cMPOyyFFsfBAtTWJp5noicf4qbzBjJ25bkJAgvwrwdtXF0RsqwbKsu8SCO1WwFslrNtBcn+N6ruZ8IhfqhUSBLMoEA6fInj1sODCcF1+MQKAHcSF9bsBzWaR2NCdqfqibv4gcAcnqKjzTt0+Bz9P0EliXmHm5Wp11ChVV5dR5GElKtZJnlDK/cIdGQ+2HY/qVmlIKDL0U/fqnyojxYSrUzs31K9SPZERCE+Jk0C0khrKuiehXL5a8DnbAHtl7trKaJM5Ef9tqV/gc+A7eDODOYR2TYW
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 08:01:16.2583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ec32da-0272-4c1c-10f8-08dee3106995
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8028
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

On 16/07/2026 09:56, Jerome Forissier wrote:
> On 15/07/2026 10:42, Weijie Gao wrote:
>> LwIP may pass a packet to the netif linkoutput callback as a chain
>> of pbufs. In this case, p->len only describes the length of the
>> first pbuf, while p->tot_len describes the length of the whole
>> packet.
>>
>> The current transmit path only sends the first pbuf. This can
>> truncate packets whose headers have already been generated for the
>> full packet length, resulting in malformed frames on the wire.
>> For example, the IP header may record a larger total length than the
>> actual Ethernet frame length.
>>
>> Assemble chained pbufs into one aligned contiguous buffer before
>> passing the packet to the Ethernet driver.
>>
>> Fixes: 98ad145db61a (net: lwip: add DHCP support and dhcp commmand)
>> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> 
> Good catch! That was a big oversight :-/ thanks for the fix.
> 
> Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>
> 

...and applied to u-boot-net/for-master.

-- 
Jerome
