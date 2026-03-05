Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DD5EEF308
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 05:56:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD26183F61;
	Thu,  5 Mar 2026 06:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dt9GgGup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07B7F83F75; Thu,  5 Mar 2026 06:56:13 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DDD783F2E
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 06:56:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKjzYQsxzfictIkKr6mdBq7ex+B1R4L3j7yAmTQzkvuGTwHmuTeRVAxGPyKdStb6zjqaz6IJbTMkQiRMAaywq1HpqCqAiWXHk/ZrjrBkLWsccPYARQysnrLBdibeumjrO9bhaRZ0JM9l+sMWwKeBGLUBD1wrRb8RiQ2kyqpJQSQBpJnmTYoEPrEz8ErVxXUrjOme6Ai9Xe8TqziDdmgZg1n9CinSmjcwffBwYeIcGis8lp5WEqub95GXo8NeAo92ZaKPlK00TIWqIJQ123z27TuLDbxjhdtaAbMpzRj9wZ7R2C70TgnQkMKsYmy+Kk4+OY3EIXus4/xtHjpbCMOgIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etpIfXuQ8wXHfbGKJWtpLbBN2HNtOMdofoNOtKIrXnk=;
 b=m1o7Q/W3LQwk1FBxQZDv7TDxp9LTbddWOGVUXTv2Z7d2M5G5icgoa3Mbllt8pTUJ8tMq7SSeIHgid2fGqJbOfvOVqWNJ7lApjMfZUZuIMmcaspk6ZUFlQ4dbvV8WnZea/eHJGKNofqMqu/xZi0Nw/5c9h8Te3mlkYC1UlMU3n2Krz0mW7eRJrYAIel8wJjWr7ZEjC5KvyO87kFQ+/0HnXQxGamoT/h0RI2dyN58TQYbfac9S1TpZ+gtUNmNKZHNqYJJ88LJkPJn/P1NDD2PadftxvQROiR+vBK7HTMRamEwpJkmZXr5sA5QDKHq09Y1RO/8RLi5Ys5Wbe67bYV0k6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etpIfXuQ8wXHfbGKJWtpLbBN2HNtOMdofoNOtKIrXnk=;
 b=dt9GgGupH4AD5PClO6mqNsQGgwxfkUs+Mro/E+NM49Aqq7fj579/QyMk2NcKNa9D2OW1RsmiEbyoazMlrq3KIUeLYab5kI8thCrWa8OOV5SuhmGQ5LsRKuY0PweZSLOwTIKBNqOAcPg7lV88VqRNEWh4Kyhf8RHoyObmzFBI/8Q=
Received: from CH5P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::21)
 by SN4PR10MB5544.namprd10.prod.outlook.com (2603:10b6:806:1eb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 05:56:06 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::af) by CH5P220CA0003.outlook.office365.com
 (2603:10b6:610:1ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 05:56:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 05:56:04 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 23:56:03 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 23:56:02 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Mar 2026 23:56:02 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6255tvrT1776913;
 Wed, 4 Mar 2026 23:55:58 -0600
Message-ID: <b0d3eb09-add7-4a14-98d2-84061adf9fdf@ti.com>
Date: Thu, 5 Mar 2026 11:27:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <m-chawdhry@ti.com>, <c-vankar@ti.com>, <neil.armstrong@linaro.org>,
 <marek.vasut+renesas@mailbox.org>, <u-kumar1@ti.com>, <j-keerthy@ti.com>,
 <semen.protsenko@linaro.org>, <afd@ti.com>, <anshuld@ti.com>,
 <peng.fan@nxp.com>, <ahalaney@redhat.com>, <mkorpershoek@kernel.org>,
 <n-francis@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: Re: [PATCH v5 00/10] Add PCIe Boot support for TI J784S4 SoC
To: Tom Rini <trini@konsulko.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
 <20260304185113.GC1388590@bill-the-cat>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20260304185113.GC1388590@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|SN4PR10MB5544:EE_
X-MS-Office365-Filtering-Correlation-Id: a90e3ad1-85e6-43f8-d865-08de7a7be35a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|34020700016|1800799024; 
X-Microsoft-Antispam-Message-Info: krZENTyQq39d0jYjSQhjMDwO5wfihpXJ99yCeHizj27ZXWX3IZdIFJpds/6OWwCtvn/l5lZonylQK/NN+XVggFrWpPw7SA4yxw2iaOuOsQxB7kPDVZxOh5XGNsBfVW0ZLiPjcx4NOrl6KqqCemdD1+/6Bvj8b0QmZUGMYUGopIaGVZrdI8izdsr8lGXZ/w9izzVE6s+y0JYLFO/CtJGHehM5DEBtkNmE8hbYZnjHRZF6YafYP0TCLOgQkuVgiGqeaFec+mCXhPHQjopbiEdS4jL7juNXCH3/nqP0gZ20JmqMQoq2kwavlYu7uTWClY/AKLm0nRwrzcONwQN1zw5kEAMwThJGwKRxMJVc86AVpUlIodnA47PnmKgZeMI9Wow9vqJZw25+pSgXaPNzslhWkayI5jjgE/6A4dlvLNpBhUzBJ+7zyi09vx1SEz8TFlnRdJOBQFGX7Wpfl7zhBEPaxsB6/+z8kAh6qhi3ehE+k4/IsrYUXI/2rxM1GzH+QGrnbUADS0Nfk7xFRDnLMOeLlvn/lp7c2CcLkjqYsKVOYiS3gxAVdzt06ihcdVMp1S8LPM+hdoZhaOx8EVJpWYYbwXZ+tyKI0aJll7SYF21z0PoCXcFcydK8ZSOgw5QQjf/PDdMa1w+Nls5yvT/6xTO1BQfnny5yZJrjvVwn9OiZbhhoKyFKBVTYUOsloQSkeh2UzcsecWRMF4MWv6Vho/sW0fv6wgSLXITebWGcDoaNKoA=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(34020700016)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZSincCqMwePVL+ez8Q+roMjhdSwRPxgDYMOC2RG4WrMVNbAG2yYVszckWAoa/oiNSR9ek/049rRrDHB4yuF0CArukHU/bT7dtJiR9mmDxGZihnw4H4AYLisaPovIQObtLuVg67y76PysjAjGGLU+4MezBThb8qnVjspBvka2348kbDNBVzz1eEA+Bkr05PUGWxWnZ+NhH1ijHr771xEMYo9OxjoQFdVnOSPCODuq6w2jaLTwtz3b/JgyR93GrKeVuFuKIGaOVvhSqV5X3ZEsQ9OS5o2JdthD2hORSsbrUyTzcH95evF5SDUSVaOCbmLKrmgSOZHHkBYLWtim4gReob5ZfwtE1Fo8ha7darH3Bast+ZMBmNr5YRlCJ/HUnkD+g8TGW5fyjqUtMmcsDkMMelxqJTCXOFjn7XW04at3Gc4v5YsOfBQC2DYJBEbjz9VM
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 05:56:04.6162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a90e3ad1-85e6-43f8-d865-08de7a7be35a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5544
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

On 05/03/26 00:21, Tom Rini wrote:
> On Mon, Feb 16, 2026 at 03:58:28PM +0530, Siddharth Vadapalli wrote:
> 
>> Hello,
>>
>> This series adds PCIe endpoint boot support for the TI J784S4 SoC.
>> Series is based on commit
>> f9ffeec4bdc board: toradex: Make A53 get RAM size from DT in K3 boards
>> of the master branch of U-Boot.
>>
>> v4 of this series is at:
>> https://patchwork.ozlabs.org/project/uboot/cover/20251201110103.845413-1-h-salunke@ti.com/
>> Changes since v4:
>> - Addressed Udit's feedback:
>>    i) Patch 6 has been updated by limiting changes to disabling CONFIG_SPL_PCI_ENDPOINT
>>       and CONFIG_SPL_PHY (CONFIG_PCIE_CDNS_TI_EP, CONFIG_SPL_PHY_CADENCE_TORRENT and
>>       CONFIG_SPL_PHY_J721E_WIZ don't need to be disabled as pointed out by Udit).
>>    ii) Commit message of patch 8 has been updated to indicate that although PCIe Boot
>>        is supported in Hardware for J742S2 SoC, it is not yet enabled in Software.
>>    iii) Documentation in patch 10 has been updated with complete set of device-tree
>>         changes included and the C Program to transfer bootloaders has also been
>>         simplified and documented with the usage of appropriate variable names.
>>
>> PCIe Boot Logs (J784S4-EVM running Linux as Root-Complex transfers
>> bootloaders to another J784S4-EVM configured for PCIe Boot):
>> https://gist.github.com/Siddharth-Vadapalli-at-TI/2d157003818441fe79a139d0dec1058a
> 
> With current next this introduces a failure to build on j784s4_evm_a72.
It builds for me without any issues. I have checkout out to next:
c0ca147ac62 Merge tag 'u-boot-imx-next-20260228' of 
https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next
and don't see any issues when building A72 SPL / U-Boot proper for J784S4.

Could you please share the build error that you are observing? Or is it a 
warning being treated as an error?

Regards,
Siddharth.


