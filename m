Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A19EF3092A
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 10:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E83D483FC6;
	Thu,  5 Mar 2026 11:39:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="D3B8gJQb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0592E83F9D; Thu,  5 Mar 2026 11:39:00 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 883FA83FBC
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 11:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6VpdSFY3hKBpBpyIuHufQPOUyukFqT6BYeNNHNRHtSX0PbGlk5fi1n/TvTNdAbsT6cvp/wrT9FivJDL+bU/zcV0YTD6gS+sWm9WWJuwkBxfqmB/ZBUdmiItz2B5qk/XmpYeKiVYZxsxg8KVmHaXnJoTln5OAy0eBxVosj83sXzXmqPG/YYHC3M3Niku4PP4bDczbYGuLCm4XIaYNAs7SuAJQzp20j2jNpvN5UCMNrfPxFjGmJRW3LW+Phdhad11WLAxxVJzDOffSWOxmhK7FPsbZqDmd9KybbsRg57+mMYmBnS5sU7BRdy7T8P0ljN9rkfb7YbZQlFpB16k6aIP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1LtaTMFJfNoQbNwUGZmoC/FnpMnfC73Q78CxNeun/g=;
 b=pqUOLORI+4KTAz2vywqBQjyBhaDmam81AqkgE70bQJxlgsESuQTMQprJLirae9GPOVDM0qUEHSxbDsN+dQdm5b5BRY+okx7kCVLeSL7IRUKszb9qKjz5XqMLd5Zz45lewy9doPA4Td1bxW+XCl6XyagCtEACsavy0faDttlbGJP2/Dj8gz+CQLj11FjtZr49ZQ297mRwd4bauQT7zCYwy8U5vUifKfcUS+sumE9YURgF6xFJfIP2bBuSMeBmbXNRiKlhD6MN3ovoToVDHE1ADccmmvv5o4TGdZjEHnb3TWS1LJ8ghDlz4Pj9oHN/AzNOckNvZtNv4IxJjtVdFAlppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1LtaTMFJfNoQbNwUGZmoC/FnpMnfC73Q78CxNeun/g=;
 b=D3B8gJQbliZQC6OsfAEF1Wi4dui9jQTy7z+9sfffhsiQsAPxBajKQma0wAjtO1O9b1facK1bjOgDEEtIPzjCXtJkiHxwMdBD44uIRh/wX9DyV/l9MUWgHkP7Jnx2ZfimQ33G2RY/w+slobHgu2ER2lLQ97Mjq7T7jlP7RCvylKk=
Received: from SJ0PR03CA0132.namprd03.prod.outlook.com (2603:10b6:a03:33c::17)
 by PH5PR10MB997759.namprd10.prod.outlook.com (2603:10b6:510:39e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 10:38:54 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::3d) by SJ0PR03CA0132.outlook.office365.com
 (2603:10b6:a03:33c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 10:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 10:38:53 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 04:38:53 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 04:38:53 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 04:38:53 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 625Acmo11700378;
 Thu, 5 Mar 2026 04:38:49 -0600
Message-ID: <5fa4af89-41a7-4e0a-9921-6881a33d0a09@ti.com>
Date: Thu, 5 Mar 2026 16:10:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <m-chawdhry@ti.com>, <c-vankar@ti.com>, <neil.armstrong@linaro.org>,
 <marek.vasut+renesas@mailbox.org>, <u-kumar1@ti.com>, <j-keerthy@ti.com>,
 <semen.protsenko@linaro.org>, <afd@ti.com>, <anshuld@ti.com>,
 <peng.fan@nxp.com>, <mkorpershoek@kernel.org>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v5 00/10] Add PCIe Boot support for TI J784S4 SoC
To: Tom Rini <trini@konsulko.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
 <20260304185113.GC1388590@bill-the-cat>
 <b0d3eb09-add7-4a14-98d2-84061adf9fdf@ti.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <b0d3eb09-add7-4a14-98d2-84061adf9fdf@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|PH5PR10MB997759:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef44950-f19b-4677-a0f7-08de7aa365e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|34020700016|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: 3Qqvm/JV+tS7RVAFMrFW6/vibLzjRZR5UpRtwWFSghNB8YN0e7JjDNusXSOUrOd35BBoHomXMHyNY/fc4VmibeBN8WA2jlFHb/Sv+NB2yu6+KXOPiIHFEUr7+ngUPlGp11ImOxr+N7f+KOF3VFPZChwF6i9jmllmc3q3362PvhmINnxIbjGYvuzjor4/VklnoUQuE99skKn2BYSD812YHrgcijTVRVjVmpvLY67ZtMSJl/tATEsD/nIg5I6BgxVCl//9hLJApSiF9KTHD7QeUv4GbGADuYmMhtJJn4KhpsppPsGCvMYYg4PtSz67WFc0kjrF9Cp1K0oyRG7jirV3b4zUcsFSZW/32u0RpGv/un+hTWJQDbYMSmj+eVnODlFS3SSLInXa93sSrFhMiQXxcIbP+9ke3QAUetw/9wL547EqmrE73m+qr7paR74+eAo/8U9XZEnF7Et2akIudo5qf81pE4WKmT2EgwgWmrRY5C2daKENU6CJoqy80OJADhOuOo/hNcQiIdc6E0hn7UfQHW+j3H3vdURL5oXaNOkThAn+UqfH51fmhrpTbb0VKKQW6BuxxoZ3oikgLpQRi6xOo4QPY69gv8Awe+nApBi7UdieZybV1QGXAQ4UBfkIlLZALi88YlYaAXRKRoaoCoAXE1ecdsxAfQH7A5nXX+U7Cey1XilrZIAV5z83NmJYASHi8+GdKoFeA2oiSBOMA3ELEQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(34020700016)(36860700016)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wGVkoWqSz1IS1emTgkTxjyLtIaYym1/rWmzCsZZlRsPsWJQLQ0YblTdxa3ysC6KutyvikW3InE32HRefnzi/C7sQJ18gZG4TQnbPxAYhCloP1GL4AUAVBUy5o5xkdLZ6Jek4CUKMw/V+SWvE6ARaY9AE7IzPCspOfxvdau6CCqMlyM1Y8H3jJkgq28FyZj823ZFtmImJB3ksMuL4YWCL+SVFar9LC8Cmec5b1oU6v56ciqtFMin85aKIcFOF+7JY8aNrELosfBDO5vzcB3/bWzr/hSmlodCz6wtihdf3AIJgnGfiVkUZ05J5G+mVg0g+nuCDxWYDHq0qExoqITDQTTRySu8fGCVzCBcTk64VHzf6Z4h1ygXEo/DlPqD5dRaHLHklEwBlOyguo8+nq9jX5+m723R4MerEcjkVGC9mEJ8kJnxhDCXr8rmr424YUYjC
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 10:38:53.9563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef44950-f19b-4677-a0f7-08de7aa365e3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997759
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

On 05/03/26 11:27, Siddharth Vadapalli wrote:
> On 05/03/26 00:21, Tom Rini wrote:
>> On Mon, Feb 16, 2026 at 03:58:28PM +0530, Siddharth Vadapalli wrote:
>>
>>> Hello,
>>>
>>> This series adds PCIe endpoint boot support for the TI J784S4 SoC.
>>> Series is based on commit
>>> f9ffeec4bdc board: toradex: Make A53 get RAM size from DT in K3 boards
>>> of the master branch of U-Boot.
>>>
>>> v4 of this series is at:
>>> https://patchwork.ozlabs.org/project/uboot/ 
>>> cover/20251201110103.845413-1-h-salunke@ti.com/
>>> Changes since v4:
>>> - Addressed Udit's feedback:
>>>    i) Patch 6 has been updated by limiting changes to disabling 
>>> CONFIG_SPL_PCI_ENDPOINT
>>>       and CONFIG_SPL_PHY (CONFIG_PCIE_CDNS_TI_EP, 
>>> CONFIG_SPL_PHY_CADENCE_TORRENT and
>>>       CONFIG_SPL_PHY_J721E_WIZ don't need to be disabled as pointed out 
>>> by Udit).
>>>    ii) Commit message of patch 8 has been updated to indicate that 
>>> although PCIe Boot
>>>        is supported in Hardware for J742S2 SoC, it is not yet enabled in 
>>> Software.
>>>    iii) Documentation in patch 10 has been updated with complete set of 
>>> device-tree
>>>         changes included and the C Program to transfer bootloaders has 
>>> also been
>>>         simplified and documented with the usage of appropriate variable 
>>> names.
>>>
>>> PCIe Boot Logs (J784S4-EVM running Linux as Root-Complex transfers
>>> bootloaders to another J784S4-EVM configured for PCIe Boot):
>>> https://gist.github.com/Siddharth-Vadapalli-at- 
>>> TI/2d157003818441fe79a139d0dec1058a
>>
>> With current next this introduces a failure to build on j784s4_evm_a72.
> It builds for me without any issues. I have checkout out to next:
> c0ca147ac62 Merge tag 'u-boot-imx-next-20260228' of https://gitlab.denx.de/ 
> u-boot/custodians/u-boot-imx into next
> and don't see any issues when building A72 SPL / U-Boot proper for J784S4.
> 
> Could you please share the build error that you are observing? Or is it a 
> warning being treated as an error?
To fix the warning associated with 'subclass_code', I have posted the 
following patch:
https://patchwork.ozlabs.org/project/uboot/patch/20260305103815.999886-1-s-vadapalli@ti.com/

Assuming that the above is the fix for the same build failure that you were 
referring to, please let me know if the fix can be taken along with this 
series.

Regards,
Siddharth.
