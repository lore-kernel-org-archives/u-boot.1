Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97201FC593D
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 12:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F17883AA9;
	Thu, 26 Feb 2026 13:15:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HSF1/2U7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F79B83E63; Thu, 26 Feb 2026 13:15:36 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E35F83642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 13:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6a3ez6xAjAhTT8kCMZVuAkZ/sOh5QzMbktFM8J/uJglZyLpMGz22S8Nn0z8J8kbp5aRw3yTDeHJcp2+UQQEDZXOyMe9Md25ze/fCqggrnaJnecav8qFVuDiJ0EQt8MnZxwHqS5GkgLvNR+sJublSaGghRp1k+yZi6hoecKAr2zSksDD/C3+xlQYbTY7IXjZvpR1kRSAQlw1bjLjv2cr5fTKMQSEnO9w7urr9P8OdSB456D0xV1epSxqDG1/W2WV/zwr0hGENlvFJ29h8d0DM9xRqsuele27LtYjR+IhUYCUEOIfaOrQ8bDT2qORW4916YAnVonWXVH/C+GuSClSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvexNTSnsRGglwSe/W4LE55GrF8norWtmf3zOHNREw4=;
 b=bEKJ6aIBVOk1eG4lhy4febnFcEqGDaSUVJ3o8lgmVO5CYznL0lIC6iLyCDAa+S7wvVjG/PqXA60TULVOAkUONq2EbFaTM6Pln/lmufLcruerpSDApO+qKwpNPDehnq3SXx+w2foGO2Il5LTxC/ri47J7r5Bb40PLYL/KvD0/Oszo7JtWFs2iTp4/wSrwKgTGyaLkS0CZLj7vLhNDdZp/xdH4D9V2U90M7inxN3YbFXBuFROc6vye2gJG9GUYg3qENqdG/6YHr2LTGRWnmMgIhg1zt5P3UDEkbdVJCaQ41HjjqFI1DgT5HyPeKoBO/N7eMg4fWyYtBrW6I0GAVrk7Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvexNTSnsRGglwSe/W4LE55GrF8norWtmf3zOHNREw4=;
 b=HSF1/2U7AMNIwNmjb0KprvNiU4Ntfo6TWAsOld5xBKGe+1IOqvQvLvz/YTrl1cAdd/YQPPL8kkMzuuLOuDy0XX3Fosy/NO1nYBPP5agJ0FG2iV26MsLPX3/9Y8NZeHLJWuIl51+D1PvKASdMwQ7WzsUWhRyxReTsaMEMAsptoH8=
Received: from PH8P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::20)
 by DM4PR10MB7508.namprd10.prod.outlook.com (2603:10b6:8:17d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 12:15:30 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:510:2db:cafe::c7) by PH8P223CA0010.outlook.office365.com
 (2603:10b6:510:2db::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 12:15:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Thu, 26 Feb 2026 12:15:28 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 06:15:26 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 06:15:26 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Feb 2026 06:15:26 -0600
Received: from [172.24.18.150] (ltpw0g6znt.dhcp.ti.com [172.24.18.150])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61QCFNrd2336714;
 Thu, 26 Feb 2026 06:15:24 -0600
Message-ID: <b6f35e93-2bc7-49ab-bbba-c6f02c91ba75@ti.com>
Date: Thu, 26 Feb 2026 17:45:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] k3_*: Add config fragments for inline ECC and BIST
To: <trini@konsulko.com>
CC: <bb@ti.com>, <reatmon@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>, 
 <gehariprasath@ti.com>, <s-k6@ti.com>
References: <20260226120827.2258728-1-n-francis@ti.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20260226120827.2258728-1-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|DM4PR10MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 526da147-12d2-417f-411d-08de7530badc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|34020700016|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: 5InjlCQ9vwSXPzBe8qK6h7iavJ294BQmxoaxv9NAjgpsI55mfin7Ibxw2niX8aXJpYqdgYHkG6wRL3vtJsv9D8cN4hCbNW0uQIQCuUV/o/L1EdzAyJ27Z3arDo3vU8mNgJEIYIJd9EN/dmZfE4Fdf1qxrVWfnM9QNLssFKFcw9YEGrID5GWbHIhd4q0h2TGC99rTK7gCSeGL7Tl1b21/JeFMhaCYXc7TyVGMuFI6aEEjwNrA59G9dWccgNI6zKSnw2p/VB8CzB1OpRtzEUtynxfc6woJ9r9cDSlvyV8YyJ1xnGQcxqpwCLiymL5eZh37TYTc76pfTVp/1MoC7db0R6U98uSVHNsCUWczp/DuBwQn4Cfgr7EfQ2yoh7EtHqMlGGNSFgcFfMC/esUKeIIDIcZr3/X3Ba9Y90fiVegaAb6MLP268m2L2g1/nwlRoDAmiPxuEZroyqHO+IlKX9KB6fpAN3DyVWbmZ5tMVIb+GmCdcK5s9pbqd6v/JDumKVu1mtgTA5QfFwZsLweA4bMtd5BnIoeW+Hni8UcoFRdVe8njuVi+IhO8lqNmzpMdmHvbfdyMivOd8jk1KoYUzjCgdgu7GoVIfuPzSF9KTENjIdtkwBoB2GEMcfJXngAcBx40seLpGD4By47GyQOKMy7JAoNQB7KxtbF27lkVJRkiVBjlr1QoXbX1+0ss0BQs1hhMJJCe++zLUBlFddWpygdMydJ+vBv7nwlsgiD4uqNUm5jPLmI+8Q5AlY3U8VOMJVjP5TqU2OdzFGkL8kps3dFdDR11dkliX/eV6PmHrtgsyQg=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(34020700016)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jqxN4P8ytzZlQqPIJ2GEe7X+l0tzlHaVaR+7zjruwH8M2v5sQA8ZYdXFvFH7b70wmL0aNd40PGwUvXOWgScAN6vvX8FnoAaU4KInN33mg3hdF9YFQiqyaRMo8yrUjxkaITq2fff3zjK3EX7PzcKewSJaq+WBH6rBm6IlCOjxapuOI62/8sIfVFGjTQhQwrX8xpXZMPmx9Pt+R3BmUX7YxEJnP9dat6dhjAzrw+dZFKEfc0BFfuRLJA+lJKxzV5AZ7s8S4Ogcm81RYQMEKX1wtqQJzKe0TGT/c4wx/5qHIfG4Sfo5VV/DebtsbFcoaSDCXZPRYet720l9uwrwI0/mo4vrhg9Q+JkLD7X3g3WtXQlU0Hv3PWt2T80d8TEwBIAYvvzx4zsV0hkgJ7wkx3ZxJba+N7OJ5wSteU2m6xeDmkLtLpCdj6moeB3Wg3b5XCr5
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 12:15:28.5750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 526da147-12d2-417f-411d-08de7530badc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7508
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

Hi all,

Please ignore the series below, will resend with a minor addition in text.

On 2/26/2026 5:38 PM, Neha Malcom Francis wrote:
> Typically we do not enable these configs by default but would still like to have
> the option to start building them in our default build flow for testing. Also
> there is the added advantage of users being able to see what is needed in case
> they choose to enable these features.
> 
> Changes since v1:
> https://lore.kernel.org/u-boot/20260220091532.3584771-1-n-francis@ti.com/
> - move fragments to board/ti/common (Tom)
> - add doc patch (Tom)
> 
> Neha Malcom Francis (2):
>   configs: k3_*: Add config fragments for enabling inline ECC and/or
>     BIST
>   doc: board: ti: Add support for config fragment builds
> 
>  board/ti/common/k3_bist.config       |  1 +
>  board/ti/common/k3_inline_ecc.config |  1 +
>  doc/board/ti/k3.rst                  | 55 ++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+)
>  create mode 100644 board/ti/common/k3_bist.config
>  create mode 100644 board/ti/common/k3_inline_ecc.config
> 

-- 
Thanking You
Neha Malcom Francis

