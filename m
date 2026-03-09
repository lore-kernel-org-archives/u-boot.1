Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF97F3C242
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 12:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEB7F83BC7;
	Mon,  9 Mar 2026 13:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HZZ/wStZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3915E83BC8; Mon,  9 Mar 2026 13:16:01 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B416805D7
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 13:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZjXqnvNtMCQ6ksMpOzlFku94UV6DVvIdcRgLFvW6iT8EIc0DdWro57bRdKSYhn2OMPy58W7uADs4mClJ9SXVKNcJf1zKqVg+n7OL1OODq7lZlSX34zEf79KdcjlXizzVDWUmOECmC3JT/LPv8elHtuiBpOMx7lEaRYVd2BzCV0QC4B+2fHUyTfZLx413IpvJrb0Ssct+xMvmXwClwWXPAgw4jjW7Qg7fIidUFFiT8l+PZvtWRk+sPn0RP2rFlUS0lMHMOu2Du3JR5NmJrBnSspi28zIaKKvnd/dZTiMsB/NEAlrOBlksIgJuEA7VwSAEqwmafgf3SwZcPdp+pLK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu6HY90YB37QH7tYjGh9W6/ElhT8sqnq79hrEWTRsis=;
 b=I8BwBlUe5sIUzNNkJr/yiyP6MT+blXuDiiXDT7TgT/YJHuz3fwOcRit0ysVdMhPsUlyxCp4njMIz20g9gx7F1WrztMi06k0/NzmKGQrywwVy0Osf6hXGt7Fd0LnwvQRev9nr0M6iT3k3VRewbXfqLN6sZo+a9KoZXT6JejbpJxWRqTy6bb+PE7Vcp6YjKHPG145+mFHz73+uKjnTW7SVvAX0h1ZlXKT0gJDUHs/k3M0PCMk5Jl50bPflKwx19YMEfMBxADTcXlehL4ZHAOFekkXf8ujipGFeJui6S2C8XHSlTceX1c0xw+uYGvwqnUwiaKgfGdJQJ0Ldd5PB59euYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu6HY90YB37QH7tYjGh9W6/ElhT8sqnq79hrEWTRsis=;
 b=HZZ/wStZ0GDvmv2uvpcxzdvb5GENnyTxzcJgXcPLARyVXiA+X9xAaeiNy69owqgigrwlG7SV3VUCkhtGMYFLOe2I5eQxIk26dLKZdciO8FkTFUmfycxu2mUWLB3rWGGAqj+rO155pd8h/nx8Gx/JXeX1m1L8ObCVlwrK0y/CU9c=
Received: from BN0PR02CA0048.namprd02.prod.outlook.com (2603:10b6:408:e5::23)
 by CH0PR10MB5132.namprd10.prod.outlook.com (2603:10b6:610:c2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 12:15:52 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:e5:cafe::32) by BN0PR02CA0048.outlook.office365.com
 (2603:10b6:408:e5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 12:15:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 12:15:52 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 07:15:51 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 07:15:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 07:15:51 -0500
Received: from [10.24.50.78] (lt5cd606227n.dhcp.ti.com [10.24.50.78])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 629CFmBY561592;
 Mon, 9 Mar 2026 07:15:49 -0500
Message-ID: <7c954d64-73d1-4c11-8d38-4a41b6550c54@ti.com>
Date: Mon, 9 Mar 2026 17:45:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: ti: j7*: Update rm-cfg and tifs-rm-cfg
To: Dominik Haller <d.haller@phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "n-francis@ti.com" <n-francis@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "afd@ti.com" <afd@ti.com>, "u-kumar1@ti.com"
 <u-kumar1@ti.com>, "anshuld@ti.com" <anshuld@ti.com>
References: <20260226-board-cfg-update-v1-1-9d434890f537@ti.com>
 <66762e9343f0f5e00d60224115c4355e097a09cb.camel@phytec.de>
Content-Language: en-US
From: "Chawdhry, Manorit" <m-chawdhry@ti.com>
In-Reply-To: <66762e9343f0f5e00d60224115c4355e097a09cb.camel@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CH0PR10MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: cf448ddd-f22a-4a80-9283-08de7dd59b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: Vl6u+kbIRG8F3iwSMfObaPlGPWhQ6I7HLpTG3uZvysvcsSCAHFcGrTCTHOpcJrpQIFhonl5GjylEd571QoSPRRHV4WERyDBnL5Tg7xISvOyHO/ygQIRdfo8721DfyTd4OxRFDH4hanq0wk5d3Rqef3ZxiYX8PJs5fyy236KiDQ/6dwEq8SHnoM2Nc2SZiqidFtVPsizUMy3CwlCa6umDlC0olk/ZaH8jWwhYcroDFkpvLQlWkn6asPrSauvRxu3Qe8LLD0V6FsV2Ebuytsjlhqd9OF3uqhRgsAmxBR4cUjj/Hqy/4lQOET/V41pcSiGSWWkL04MQKSWyyqhXcHxxIYhQdTP2JnPpLDZ6fUpwrTttVnf5Y/A7zLGBfH9RYfnaI8jPb1xZxG2kmpEBJezKDXw7wkg9OcO+lwYuUpAxXm75kVf7qZc5fJnsMh7nTMx4WGpEhIKcf9E8ImDGIgXQ0p7YrtxVeCfrpaYxwy4fCj6ZeNPV3+mzFslqltDSIz5FJjLHbQsTzO3D35N/4QXBy5JMQ1efSOYlQxq7B4y6LT6L+9CT9XxHWNQKpmHJoqvZMRoAgg8pZRL//1MkyLEfo+GgGlKWLCNhoCQHPDsJaYtmfRbEK6dBzPn1LXmitnh6qWw4hgjJ0w0WxTwpV/LOmxkoc0yCvbc/7dh+biJZEDohENNcSi894qUltWZz62NCgiPl3eqQhTATfo5eXMEAYKkqwHMahqFRv20H290V9QVa6+Rr6/kwLj5Vnatj1U0iIdkvUW8ty8yR8lytNvMLHg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uMdm5m9MoZPi7+u7BQcz+pd4CtobUzz2ScSIGLS015v6z7nNfo0Gnpcsb/8YY0U4eVM214Lo7NKYNuE716Qypa3F6tBjAwYPQFYbaiw4eerQEnsB4Ix8iFnHBzcdbB3m9Y12Dlnu3swC710Gg3vU6Ut3zxAZP0ktd5DzqHNewFMSnfUHBM/CdG8H5kDfESZCPrZge+/OW40f0ldsZ3fOW1RHF1l/v4gJXds3iOmM69zWTlUhiQahsMGygBiRh2brbIDLbPdkZKKeCvX+Ld2PjP9MEXbxe7prJspCIHnVelYFeFiZkavNqXcHaqln2uw9ORr+ll6g0aXeTk7B5GrD6nUBWWVITWsjYpOM2SSm/rCxyEQ+rRtyrcT27isWch9C//ijwWz9STAY13HUaiY4zPvy/q1HMeF1d4mvEv4jP81S2Uam/mHmCfEKrliqS0cQ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 12:15:52.0540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf448ddd-f22a-4a80-9283-08de7dd59b63
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5132
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

Hi Dominik,

On 3/4/2026 3:54 AM, Dominik Haller wrote:
> Hi Manorit,
>
> is this relevant for the vendor boards too?
> Phytec AM68, Toradex AM69 and the AI-Beagleboards are in the tree so
> far. I don't know about the others but for our default ci builds we're
> just pulling in all the binaries from ti-linux-firmware.
>
Checked with the firmware team, the following is repurposing GPU host ID 
to a new A72/A53 host
by adding IAs and IRs (from the end to allow backward compatibility) to 
this host id.

I don't think it's necessary given they're saying that backward 
compatibility is maintained but
ig it'd be nice to update to maintain the compatibility ( as well as 
test if something is getting
affected for your boards )

Regards,
Manorit

> Dominik
>
> On Do, 2026-02-26 at 17:07 +0530, Manorit Chawdhry wrote:
>> Repurpose the allocated resources with version V11.02.07 of
>> k3-resource-partition.
>>
>> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
>> ---
>>   board/ti/j7200/rm-cfg.yaml       |  8 ++++----
>>   board/ti/j721e/rm-cfg.yaml       | 10 +++++-----
>>   board/ti/j721s2/rm-cfg.yaml      | 14 +++++++-------
>>   board/ti/j722s/rm-cfg.yaml       |  2 +-
>>   board/ti/j784s4/rm-cfg.yaml      | 40 ++++++++++++++++++++----------
>> ----------
>>   board/ti/j784s4/tifs-rm-cfg.yaml | 26 +++++++++++++-------------
>>   6 files changed, 50 insertions(+), 50 deletions(-)
