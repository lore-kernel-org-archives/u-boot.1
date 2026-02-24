Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3E9E9B249
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 10:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B89F783642;
	Tue, 24 Feb 2026 11:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iTz0WNYs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB90883BC9; Tue, 24 Feb 2026 11:47:05 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C19C082BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 11:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7YaJpaoJ5jcC5h6TjrvJyWNj6MsWjhKkSPHejkqBNdgn5WgLlbzCYlhfy90HH1E3sqGjhhkE+lQ3XlYs04GWdFZlg1NhAWSuSQKhr9+RPBwVLno0uSUvEebE1UB9wrRSer72Vnn3edT3pPlhtbOjAVG8XHS9JiqhAI/8hQNraCOUp53vegntINmsqc78dMxAC8AWAgcdDxcKdN4K9RVjybs5OqOEH8A3kSJ4GvMX1HF6erElprRwSM3CP4GDd/7pAvhPSkyCgeK+kpzOXfxt4c/3ltgRcoTl0SKgIzFlx7dhhetg3z1/O/tUlQwyVkK6JAxVofpoUdn1Pv76B8T4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEdelqTqSPm82hX7m4aTaJ3KqvkBbvKj79n1f6Dn9Vw=;
 b=FWCh7QS+UsEdKgJISfK+DJJZGn1/CBG3/HkrXebz2pMORuNVqUO6OOyUiaOtIH54pwLDze7emKdOP0H8rH+EZwlh804GHQ36bxlT9ylXn8QRys+r0gSSonQgid/k24apvUqVMvSlvU8tXTNdfmclNwUSjjgkn9otJf00kXE4pbfctvoJAevtNfw3EZwyEX8U2iquY9nXdzcvQ7GLN6ycn6J/4BwoxLo8vP59E5CZBL3fjZH/7X/LBOjff+92y28al8dD/plL4p/EGCoCVvRuvMjG7R6yjdnyLbVUDd6Smb6Fu+/fBimao23gZ6ilG425lr0IlyBtj3TppAdjQDCO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEdelqTqSPm82hX7m4aTaJ3KqvkBbvKj79n1f6Dn9Vw=;
 b=iTz0WNYsjRObvelXC8oBuf4mh3p+xQmBdRE7h7AabEC2IA2Vo4fWESA0oYF/Rg8BWkmdc2xFn9vxQjWmL2jHbxJ9qSaIGIHstH1vbSa+/qEZNme3YTLpAON0jiWStgBM67VveBmSN0+bURj2zymIJMJjabHRl2nuceQcuYIvDeU=
Received: from BLAPR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:32b::26)
 by DM3PPFF3BBEC48F.namprd10.prod.outlook.com (2603:10b6:f:fc00::c57)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Tue, 24 Feb
 2026 10:47:00 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::29) by BLAPR03CA0021.outlook.office365.com
 (2603:10b6:208:32b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Tue,
 24 Feb 2026 10:46:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 10:46:59 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 04:46:59 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 04:46:58 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 04:46:58 -0600
Received: from [10.24.50.71]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61OAkuVG2593341;
 Tue, 24 Feb 2026 04:46:56 -0600
Message-ID: <a8488ce9-4758-410f-8871-ef642c53ab41@ti.com>
Date: Tue, 24 Feb 2026 16:16:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: k3_*: Add config fragments for inline ECC and
 BIST
To: Tom Rini <trini@konsulko.com>
CC: <bb@ti.com>, <reatmon@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>, 
 <gehariprasath@ti.com>, <s-k6@ti.com>
References: <20260220091532.3584771-1-n-francis@ti.com>
 <20260220144507.GS3233182@bill-the-cat>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20260220144507.GS3233182@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|DM3PPFF3BBEC48F:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d64e34-80bf-4491-1d11-08de73920994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFZleUhvK0xGbWpscmRsVXJRODl2SGZibEpDcHhuRTNmdktnbHFSUWJxRVAv?=
 =?utf-8?B?NzZYREVtR3FEWkdqQ3NFTXBMaEQ5dFc3cUZmalA5WjNqS1dzY2dmd1dHc2Q3?=
 =?utf-8?B?QTBDV0FwNnNoMGJvWFhDY3pqTGM4bmtwdW1lTEp6STdkZGNNWjhQUnJIcGpa?=
 =?utf-8?B?YW51THJhcDUxWUpuK3NkRER2VjQ2eEVFNjVSbTc4ZFA0VGFvTEU3Y0pMVUtm?=
 =?utf-8?B?S2ZiRkVVS2F3ZVhZVmZONFJqeFdKcjlKZS9hZm1aekFJRE9ZVk9rTTlmbjlL?=
 =?utf-8?B?QlNwUTU5ZnQ5QmVjZjQxQ0t3b3hrejNKQzZKVWtrRnhPWkRjZGFlLy9ORzV5?=
 =?utf-8?B?MGtRUFp1dm8xaDdwbmxjOFk3a0I1cjQ5YURVNmI0c3lzZlBXc09iUUc4NzJG?=
 =?utf-8?B?NjJjazhoZU90QjRyc0Q3NTVzaVlRZmR5NnZCWXpxMnB5SmxrRzgwS29IM0xI?=
 =?utf-8?B?N3ZOV1VHS08zZEJtNWI0NDBtZ01ISGR2Q3JHTW1wUnkwVWI5dWFTb2h6SndP?=
 =?utf-8?B?S0hpWERYbUl1K2NuaUQ5NExlUGRTR3drc2RtN3lUOVp5M0FHa3BwWE84NG5z?=
 =?utf-8?B?UzR2eXhUUkRWT0ROcU85ejlOdnlSWVJaUEVKd3NHYU1xaGlPVUpzd2tQZi9I?=
 =?utf-8?B?L2JtcW5raUR5dHJBZ3JmTGVuaHp0SVhobVhWdk00ZVgvZVluVDlsSVY5OS9O?=
 =?utf-8?B?UDF6NFJKRmkyUGF0TE9MT005SlFTUHZJSHJzV21DQ3h1SmN6MUJCT0NEa0Rl?=
 =?utf-8?B?TS9lVUFya2hiZSsrUmF6MWp4OU12OHJvZ2ROS3YyQkttVFF0amNjME9TTzF0?=
 =?utf-8?B?cjJFcnJCRFVVS01VS1ZHOHYwM3Fvd0ZZU09TWG5vR0tiZjVEN1c1K09BNEc2?=
 =?utf-8?B?OU5vNVdwWTJkVjRNOHNqSlZlclhVeDFqUlE2TWhLczZ0dm9iQVBDK3FpMVNN?=
 =?utf-8?B?RnAxVnBuQkJha3NFdnNUTEVBU216ZVFFdDd0b3Qza0xQZUU3a251bUMyM3N2?=
 =?utf-8?B?UllwU25SYXUvb2hGNHlhTktvejRDKzJTOGlkbjAyU3IyK2crQ1oyNWh4cDVi?=
 =?utf-8?B?bUdUUzFrREVSRk56aWFiL3hZQVNIOUZRKytIWnIxWGpnQytLL2EwaXhHTWd4?=
 =?utf-8?B?ay95Qjhzc0hnNjZqMWtDNTVvaTlmWUd4amVwYjlyL1JnbXkxak5aMC9jNEpK?=
 =?utf-8?B?VEttYXppVGtmbFlJTS9rU2NCQ1M2dDFKdWdrdm84a2ZTWXg3N1E3dUtSYUFM?=
 =?utf-8?B?VkYrNjFrYjdZelZnZVdqRi84dkxQWFFSSERoTWtCL21JREVlcXBrNGkvam4y?=
 =?utf-8?B?UVY4YlovNlBXTVY2dFNLRFp6dkwyYllSMldPT2MrTE5HZlREWFErbTJEMFF1?=
 =?utf-8?B?Wm9RcGlyOElsV0krTmhDM0MrUkVGNkxxRG1MYURUM1d1bjVuVkJjOGJGOTMy?=
 =?utf-8?B?M28zSEZBbnBQdU1ZSHFERGw2SjVlbHZHcU83VGtJRC9WNVpweEl0cGJMRUZN?=
 =?utf-8?B?RDA3S29xNEcvZC9vYlQ0cXF1TGpUb0graTl3c096WkRpN3Zhci9MK3dsUkxE?=
 =?utf-8?B?MTk5UlYzRjg5b3hmS1NVUDBlVk5MbHNnRFhvV2hKQTZwaWF4MEZNT29zNXpw?=
 =?utf-8?B?MEt0UUlMNWxtNWIrTXFaaW9LNW5OTlJUSlJGNWNLd21ibWU5WVZYNWVDd2lH?=
 =?utf-8?B?NEhIaENnMmdjMDVyZUIwRitlZWxmamJ0VzhPd2N6ZzlvS3lPUXBtazlnVWRY?=
 =?utf-8?B?cDBQWmFMTGZ2WXVKMW1kb29WU21DMkRyQ3NseHdGNzJTcHNGNDhBVzdRbWxZ?=
 =?utf-8?B?VUdFYUQ0WmtSRkIwYXVIb1VPdkxqT090WjZhdnA5eHFMcUJ2MmxRR0Y1RjlM?=
 =?utf-8?B?WnZmZVdLNFppODlvV1RpV3RobE1EcWdiT0kvSldTMDgyWlVOSUYzM2NvazNr?=
 =?utf-8?B?UzdRaHgrbVNWRDlEeE5VZEtkRHdNQWtyWFNrNFNZTWo2NTZHeHdGYnhlS1RL?=
 =?utf-8?B?L0hJVnpvcm1CZmd6clFsNlVXWmRSS011Qjh6UEZKTW1YSWNTbytybDdFS0Z4?=
 =?utf-8?B?M3JwM0lGT1BuYldkM054bXA1S1FETS9sWWJZUUhYV3ZOOWhUVFl4aTNYQ005?=
 =?utf-8?B?UXVmdDYzbUxjNUliUmpqcDk3K1JCYUgwQ2FmakUxMkZnYXVnOVFPUFdNWk15?=
 =?utf-8?B?N0tJUDJ5R0dDeE9tbFEvNmhucmttYUw4QUlOQUJQbGVEZE9sWUJJTnM0OFpz?=
 =?utf-8?B?SXdNQ1Q0aFdPcVFyR3JJa2ZsRmZBPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IsqxuNOuawq9s/5m++A44izNNOfYhFZ0jg4YM8uFZIkXKRlv4uKxuSIrCX+aiIWsLcRYlwYL64PqiEkrmTxT/Ax5sC9GEURoJRqCsmbfvIca9z6OtuV1L/I7R3ALEWGmqhGgMfMLa9EfIkrPJ/pWcFZhYY2f+GKh9k2mjtIXvYr4b+IJvA0SSbF0Vo4j8J5h1tlxutP7yUKroDHils8Ccssu7KHPvN68d5us7kKP82C+R32uefPTQxtg7ZzqqlkaYXKyIsO20TTSbpPO5GYwFi5aSThkWAF8LcQ+wvVifrxWyLBdKUT+IU9ugePHs3zWN3/Y6fHFVSs5wimT97GpBUD4GSbIUWnp5Ur+EVj4zymYAS6z3iDYCWmvXKkmjK/6CjzDpzne59WrXJ3sDQzc2L+dmOzw98KzgBalnOO+7wHxSjsA0DkvmiC1PWZx0GP8
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 10:46:59.5154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d64e34-80bf-4491-1d11-08de73920994
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF3BBEC48F
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

Hi Tom

On 20/02/26 20:15, Tom Rini wrote:
> On Fri, Feb 20, 2026 at 02:45:32PM +0530, Neha Malcom Francis wrote:
> 
>> Add config fragment support for enabling inline ECC and/or BIST on TI K3
>> supported platforms.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>> Typically we do not enable these configs by default but would still like to have
>> the option to start building them in our default build flow for testing. Also
>> there is the added advantage of users being able to see what is needed in case
>> they choose to enable these features.
> 
> If we want to partly justify this as helping users, we need to update
> the board documentation as well. Also, can these live under
> board/ti/common perhaps?

Yes I can add documentation.

And yes putting it under board/ti/common can work.

> 

-- 
Thanking You
Neha Malcom Francis

