Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF12D185C2
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 10:46:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 677BE83B8A;
	Thu,  8 Jan 2026 11:46:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ay8sUEsr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DAFD840F5; Thu,  8 Jan 2026 11:46:14 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5669A83B87
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 11:46:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFCrusPhx3cA/0HfeUn8WT5uhk2nSym5tIZY23yeTKi7UQsoslYzwPjodIboss/iQkr5nHjLwItlvww67FV4G1B7MTAhEqlV75EWE9HZvpuCLgfh3BkDvAEwFid4QuIbznvwUtGDZU4SeFXNalbq1J78xX9hzB4i5+BF/3YsIq6RA5enXUImQNeSNxJtJBwHaKnxA9SE5Y6/PVc6Jpj/n61RYHSHJOL72Polxm5kvR64F4bRrUoqJygcHsqFLmRwDeVjKJDN3YnRcTMGvz3Us4j40a2pw8w+SRy+02gGZjlM8xm89F6UPdCglE16RTgd367RKAfDDw1keg6yqouL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcCt3hm8SF98mPvhUy++4Zm7EYNj+lvUAqpnZTMaIIU=;
 b=cJvlasS4mGc+/Sfk/0G3T5pHYwNsFpAbLWp7YtQeEp+rme4GYw/IvTDtT5qgiLc24VIQr1Xln9vNbDuTdqE+qSl8+C5J4p3tPxQt1xX1xNmnFBrByagf5mduAqECebUezNC3G2D65qZAFV8WdOIwlrFSJltyzvdT7aORTuQI+1GPZSW8nY89tfVuv8hCGjk0rrGZdi6XWMkkVIc+gpN5zxwOJ9/Upox8p1DQhU8MMnnzjM+b7QvEOVnGIHjl6M7vDhF06JWhMl6LvY5GJ2RDm1Xb4MnzDJ+FIuzqF050qEoDa/ykqcWFH2I4HcD94ceZE6z1Znc5SF0g8fe9Y888QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcCt3hm8SF98mPvhUy++4Zm7EYNj+lvUAqpnZTMaIIU=;
 b=Ay8sUEsrFXbsISCB4yn/6AMTFWFswIt7tNZoye1zbMHc6CkzMEXmEG4qqEwNtgJLtYC9rLAWsvgAo3baj9kOoPf9wqaUsNFdBB+pgLVIu7MoOao06Pg3mGycaOsInq7KXrfW9eLTdOBb9YlGzXwsQyJYxyDKeXfQFhJs/pcKzfo=
Received: from CH2PR14CA0052.namprd14.prod.outlook.com (2603:10b6:610:56::32)
 by MN2PR10MB4190.namprd10.prod.outlook.com (2603:10b6:208:19a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 10:46:08 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::35) by CH2PR14CA0052.outlook.office365.com
 (2603:10b6:610:56::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 10:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 10:46:08 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 04:46:07 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 04:46:07 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 8 Jan 2026 04:46:07 -0600
Received: from [172.24.233.249] (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 608Ak4702246828;
 Thu, 8 Jan 2026 04:46:05 -0600
Message-ID: <d00d6af8-2c14-4d33-a24b-68a13dee6aba@ti.com>
Date: Thu, 8 Jan 2026 16:16:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: board: ti: Add AM62D documentation
To: Nishanth Menon <nm@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <praneeth@ti.com>,
 <vigneshr@ti.com>, <bb@ti.com>, <khasim@ti.com>, <afd@ti.com>
References: <20260105183545.4108567-1-p-bhagat@ti.com>
 <20260105185909.t7xv4xjl3xzw4d6m@granddad>
Content-Language: en-US
From: Paresh Bhagat <p-bhagat@ti.com>
In-Reply-To: <20260105185909.t7xv4xjl3xzw4d6m@granddad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|MN2PR10MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: a46351f6-713d-4a9d-9a32-08de4ea32181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|34070700014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDE3M3BiMnVMdmdUcEQrdklVay93disrVm5sSDRsVk5tQldWV0ZhZW9ISFRV?=
 =?utf-8?B?MFR3ckN3WGw0U0czdXdUS2t6ejZOT1d0OTBPVjBmdEF5anptOStMZng1M3Zv?=
 =?utf-8?B?RmlTdGt4VVVwVWFjTTZqMUFXYWJ0djVESjlJck9oc3FIQU5aVDFZV1NwK3Fp?=
 =?utf-8?B?d3dQNTh1dkV3NG5LWXBFUUV2QmJBSWVyWUl0QWlqQTN5WGdsM3kyNUFJTlVh?=
 =?utf-8?B?UGhsamVORnh3eWozR0YrMDdad0c1aXgrZGkzUytnY09vWnhRS2VobnZHMlRZ?=
 =?utf-8?B?NEZpaVU5aHE2SW1FUUFVYzQ5QlhhYkh1V29PMGNxOVphS1VJN0x6Sll0S1E4?=
 =?utf-8?B?MnpRY2grK3BvemdyUDJoVXRSRlV3NDJOWUVzQnZrN2pNU0xwelErTjYxbkZa?=
 =?utf-8?B?ZWorY0wxcnZPeC9ERjJBWXB4TGFuVzBhaTFjSG40WUNRYVhxQVNSdEs5U040?=
 =?utf-8?B?YWxxTWNQbmlIb1dpY0xuMGthVXBvUEFOKzNzTGMwWDRmTlUrSVVJL0hZVWNG?=
 =?utf-8?B?WENUOW1DcUU4Uk00aFJEMmJCU21VZmp3MUlLTXMrdmlMa1p0Q0pia01WYWIr?=
 =?utf-8?B?U3JpUEZEL2VtcWlCdGFCT1grU09jVHg5bmZBUXlXUzBUakRQNGtzUC9MWFNx?=
 =?utf-8?B?SU9EdTFBaEdFY2JjbGtxMkdCTE4ySm1rNk83cmp2L2xKRzJLYUpRS081UEF4?=
 =?utf-8?B?ZnU2N2I1S25pb0ZRNjlUaUgwMnhiRTNIZUtXYUN5a1o2WDZqVWNZK0ZJc0dl?=
 =?utf-8?B?ckpRMGRQb0R0dTBsSUJiMzd0U3haR29FaFpXWmdnK0Vha1VvVjBGNmdPSEto?=
 =?utf-8?B?cUtGa2YvSjR1Tks1RkhteHRzaW54ZytPRmp5VGw0azlGYXllOUt5SEllOVNP?=
 =?utf-8?B?OHFnWnAxanVmSDhpcG1ueVZaY0h0am9TUEJVREFtWjhZR2JyN0h2bnpGR3Y0?=
 =?utf-8?B?RFh0QTVBRkNjSkdtLzFOZUdrRG5TTEtRam53RTJjUGZsSTBNZkc2YjBySjBH?=
 =?utf-8?B?NE16SXZwOFNLdjJCR05YRjNta0MwTUd2cnluaGY2dTlIY09ac2x3RFJDODl4?=
 =?utf-8?B?K1lobVBpRExoNGh4SHpmbWtFbVlFY2dkUnovV1lpeFZ4K29XZkZpYXowU3k1?=
 =?utf-8?B?c2p0WGlwdS8vdzVuYUt2SERQa2E2Q3VqZUFnYVZLMGVXRzkxQnBDVkdUcU0v?=
 =?utf-8?B?RHBUUEtYZjJhQnMxd0JFa1lPaS9DZnpoNUJiVStnVFp0aTVGNnh1eXlmRlVx?=
 =?utf-8?B?OURoOWxaVHF0cks1dnRyd0JFejB4dnpSbHZqRnZUQWtrRUVtRHBLNDZyZkI4?=
 =?utf-8?B?NkptSGxwZFZnU2xqSkxFdUlKQjk4QzYzNWM5eFFTVHBOdW5CRWE5UmwzdXpM?=
 =?utf-8?B?LzJKT0VsZ0NVZENldSszTVhiOTgyS2NZWEdVVDBXR2ZXSDMvNlI3aU9UQWFF?=
 =?utf-8?B?SUh6MDlmbWdjRGlhdkpZNjdXM2xPbUhZbDJzTEJ6U1QzLzVuOWpabEhLeFhy?=
 =?utf-8?B?WGhFcFF0dnUvVW92cm1DbndzbjljQW9rUXo0SzJVZEhNcjZEcGo4ZEE3Vlpz?=
 =?utf-8?B?bnI3MDlIenFCOE8rdGladnVEMmYvVXBBUEYvdUhzdHk1ZjBvY1A5T1hmblpJ?=
 =?utf-8?B?U3FaamRmcVNYc2ZQUG54L0dWVk1BeFRWVmtLZndpSzdjRnNwU3dVbnZlb2lS?=
 =?utf-8?B?SjFPak5vVS9mb0E5QWFXcVMxV2N2cjE4cHZLMER3Z2EyTWhOck5VZzNaT003?=
 =?utf-8?B?bkxXTStDdDlnSVNpcDhwR0treDhqR0JXTVBuc2dTd1Y4NXdPamFiaDVMSGFL?=
 =?utf-8?B?WXE0MnllMGw3SEQxWmRLTTFzRWhxd2Y3RGNvV1cxcXk3cGtGeElIS05nLzYr?=
 =?utf-8?B?clZRdkpSOE1xaFd0amRXU0dQb2lCbFFyQ1BoOHFyS0MwOUdQMGI0RTl0VDdB?=
 =?utf-8?B?SU9nbG51LzRpTElqT0FxNXdnRzBFVGZiSXVTaG1xRGZpRkZIOVFQTjR0cmF1?=
 =?utf-8?B?R0YwUStDWkVLVGl1ajg4S2xDOHg0TFYxQUdvZC9JYnZqV0IwSGYvbHI1ejJR?=
 =?utf-8?B?Mk9HNWdqRXoyWGxSUTRZNmwwVXd0c2FqRnk1VDh0U1QrNWx3NFNYUFlEck9x?=
 =?utf-8?Q?K+Ag=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(34020700016)(34070700014)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 10:46:08.1304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a46351f6-713d-4a9d-9a32-08de4ea32181
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4190
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

Hi Nishanth,


On 06/01/26 00:29, Nishanth Menon wrote:
> On 00:05-20260106, Paresh Bhagat wrote:
>> Add info of boot flow and build steps for AM62Dx EVM.
> [...]
>> +  **OpenOCD support since**: August 2023 (git master)
>> +
>> +  Until the next stable release of OpenOCD is available in your development
>> +  environment's distribution, it might be necessary to build OpenOCD `from the
>> +  source <https://github.com/openocd-org/openocd>`_.
>> +
>> +.. include::  k3.rst
>> +    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
>> +    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
>> +
>> +To start OpenOCD and connect to the board
>> +
>> +.. prompt:: bash
>> +
>> +  openocd -f board/ti_am62a7evm.cfg
> * Are you sure this is the location[1] ?
> * is am62a7 correct for am62d ?


Yes, since they have same core architecture and count (also verified 
locally).


>
> [1] https://github.com/openocd-org/openocd/tree/master/tcl/board/ti
