Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762D6CD8C85
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 04:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA816839A8;
	Tue,  9 Jun 2026 06:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RBqRFBW5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB99839D9; Tue,  9 Jun 2026 06:25:17 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9030D80087
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 06:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6p2VEpmzV/74XbfLpsL42JMe3STeY2oONdfww9C0cpHdk1DV93PZVu7SyjdGBSWX6l/4N3Ha6hPLU61pYjmRyh+8RbHq3ClDV04XN3+DJYMKE9AD0kKtW5xapn+KmB+8FHzcQcyKEwGj2TNBPMzShZhQCfD18Jz1DHrx2cxFTH5uEWLw1GfCBVqvrlEra9C/RbaEPHArx8bqWsQQMGwQVQZyl7ef1RZDNitbQwa+3p13sIfXBuuRBYq3DF7c4EIYuJQpyAk8kh2HSflWX/omxh3q8JhPSRy4nmPLyaxAFEAJztMkpvW180WL4jRb1ZF3KJvCaCAjtw9/SzUgpBjtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hHbPMm/Okd0YKRCg9Qg6wLk+Qnn5iftoERK0veH+gM=;
 b=asiuF7SwwSwb73Ze9w1zchY268F0mOtq3ELPKUTxj1l4voIllNQX03XFAevcz4rQFWDC7fqxjl7VIOpGhzVSOjOY2okvXO5qy8Rjc3uv0FvTgfbPKTHZ/O0PJIMasatm8AbdxF9vlrfu0TeffGbSNhrdXLPPkQOJC4XM6Ig6BjIHqE03kpGnxoCAnLzKvxxaYseQdQbE2ODZ3vTfGUFigwsE+6cmHYqbf9L7lo5N2RjajUB2PODg2nz90st4XsoWPgJ4sZr3a8vMKRI+NQVW69IuQveJXsWaEiJIy7fEganseyPzM5DZcZH3DxKhf5lucf0zeBIWHtOWZqGvsuiEcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hHbPMm/Okd0YKRCg9Qg6wLk+Qnn5iftoERK0veH+gM=;
 b=RBqRFBW5Pl5KEJA6+YZ7tlsulllj0R85Vo7cCzgGVo6LvN7l8Srni2YPsw7jzPf+cVpoWeL5QidL/Y3YPVmCqNL2Cy+A1ZpWf/yiJ9kSv9Wn4YzL7W5v5UalsVUV8I6GH4Nlt2B1zyqZsHvPwBydbcfD8/q7Vkbt+VRwpJzUDG4=
Received: from SJ0PR03CA0167.namprd03.prod.outlook.com (2603:10b6:a03:338::22)
 by DS4PPF67D158296.namprd10.prod.outlook.com (2603:10b6:f:fc00::d23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 04:25:11 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::2a) by SJ0PR03CA0167.outlook.office365.com
 (2603:10b6:a03:338::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Tue, 9
 Jun 2026 04:25:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 04:25:10 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 8 Jun
 2026 23:25:09 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 8 Jun
 2026 23:25:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 8 Jun 2026 23:25:09 -0500
Received: from [172.24.26.211] (lt5cg60819vj.dhcp.ti.com [172.24.26.211])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6594P6o3851517;
 Mon, 8 Jun 2026 23:25:06 -0500
Message-ID: <3237a8a4-e4c3-49e9-9e2a-5cd5055cde58@ti.com>
Date: Tue, 9 Jun 2026 09:55:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v2 5/7] arm: dts: k3-am69: ddr: Update to
 v0.12.0 of DDR config tool
To: Francesco Dolcini <francesco@dolcini.it>, "Scholz, Kevin"
 <k-scholz@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: Franz Schnyder <fra.schnyder@gmail.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "K, Santhosh Kumar" <s-k6@ti.com>, "Brattlof, Bryan"
 <bb@ti.com>, "Chawdhry, Manorit" <m-chawdhry@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "Gujulan Elango, Hari Prasath" <gehariprasath@ti.com>
References: <20260521062615.GB11963@francesco-nb>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260521062615.GB11963@francesco-nb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|DS4PPF67D158296:EE_
X-MS-Office365-Filtering-Correlation-Id: ff55a3e4-fe22-4bdc-e9ba-08dec5df1836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|3023799007|6133799003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XhkfqJjEbsgsZR8+CQeGPz5YuX3WA5DzyFHHc+bRq/sarDj/a92yp7nz6+b3dgmMp8K2sfGsFbYKZJp7lAuTXiAxIB7QDMsXlmk7QcUdPI8OM0q23A0oseQqNnwLJ/zrW6KZ/Byr2IltPzYrtLFhMh+zfUIEGIa4LThufnA4Yk6uwfd19bId+UuotnsNXAvp3IumqZ+7uZLm3RxZlzYY2E0R3hTDOrv73xnhzrPy6cSzdnkve8ag+rbWS4rR22Yi+P8zvNnJmVH6FhUHbbyyDBRmx9HzAeypgZkMs+ybyagPXSJcJV1EnfQUS3QR2RlKJXTOpp/ZNyMxsrXxhsmb5SZ+K0foZ4uayGD1SWvDc3Rtd7rD7XLvOqXN+AdN5LJdlZy75NXXlwvYS6oU4xji2EV6mLn8RNf0GHy8Y/Hr31hOenyabONQpZVa9nCQNzcMS4SkJLo81Usn5GdlHuecqCpJPx6VtfeQQ9lq8a9hllb5B+KeZCspNrz0lkuoSG7sBWCwtdaDeG6Tctc6R4rJ6aAROpbcIl+p8YZFZaBmQDUdKGNLq+diY0EPkaAeXNA7j1AhWBNy+ViHagu2XjxSsmcvnOjLtubczlxGRBCcEBdJNTpjqDB9zISorZb4EkXcx4iTvo07KDuvR6o1ItLmd0NwpI+2hSInIN8z1UYTJew4Sj384VyouUJUXrKQu1r5obKDySpqZ+rSKKbjUTlLISL8v3QBY6XmefSrTUlyz9E=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(3023799007)(6133799003)(56012099006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5WPNaUcxhAw4OOXW38w7M6mdhTxZCmFy7Vw75y+camZrPjf1xYoO4XKI2j7uMlYOCoxV06p3rS5iQ5Nb9s/eaM137Wl7udNPVi3EFZowh9ceuSp/0lFJGk93471EAN5u1DpGGXdQmgGhGrLZT1pHoU42uqZoCizdslThzz2Ls95//VhCOaZmg/hoNTFdnc+bDwx2AjIX/pcalFanz8L2T4zZnuPs5nT1N3Q7nYtDuMYwqX5NSguhseu2VpXT+SOwPCcwLyWcdc4MxbkCHRlqw6xiwD3ir/uNuMjkEi8MZSWQETCXkrOH9JUbpbNgPYC5FtvA2oX9IgDtfahvBXGfj2LgEHQJG7k6xq4dxBILX3+2o7Im1HBouaIgcWRRemdVs4EESlpiUe9RKgkq+CYj78y5yIy9JfydRt3S+1WXCwD889cBcIYD4A+ghRlModg6
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 04:25:10.6529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff55a3e4-fe22-4bdc-e9ba-08dec5df1836
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF67D158296
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

Hi Tom,

On 5/21/2026 11:56 AM, Francesco Dolcini wrote:
> On Wed, May 20, 2026 at 09:52:09PM +0000, Scholz, Kevin wrote:
>> Francesco,
>>
>> My understanding is that the Aquila board was previously having
>> intermittent boot failures, hence the comparison of the TI EVM
>> register values vs. the Aquila board register values. My understanding
>> is that since then, two unrelated issues were identified resulting in
>> the observed behavior, and both have been resolved.
> 
> My question has nothing to do with Aquila, I think I was not clear.
> 
>> However in general, more than one IO setting can be adequate for a
>> given design, and it is also acceptable to have different IO settings
>> for different board designs and/or for different DDRSS on the same
>> board. 
> 
> Again, nothing on my question relates to this. My question was
> 
>>> specific configuration for AM69A SK board in which only dram3 has ODT
>>> enabled, and dram, dram1 and dram2 not. Is the layout/schematics of
>>> DRAM3 different from the others? Why?
> 
> Why do dram3 is different from dram, dram1 and dram2 on AM69-SK ? Such a
> difference implies that the layout is different, or something else. I am
> interested in understand what's the reason.
> 
> The question is because I want to understand better the TI design.
> 
> On Thu, May 21, 2026 at 11:17:10AM +0530, Neha Malcom Francis wrote:
>> On 2026-05-20 21:52:09+00:00, Scholz, Kevin wrote:
>> Francesco, hope this justification on the IO settings are satisfactory.
> 
> There is no answer to my question.
> 
>> Tom, could we pick up this series in that case?
> 
> From my point of view you can merge the series. It was like that even
> before, I just abused this thread to gather more understanding on the
> topic. I see no reason to hold this patch because of this.
> 

Could you pull in this series,

Thanks

> Francesco
> 

