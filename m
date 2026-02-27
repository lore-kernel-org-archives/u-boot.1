Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3288CFEFB54
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 15:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7340783E81;
	Fri, 27 Feb 2026 16:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="v5Jb7Cd7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 752DA83E88; Fri, 27 Feb 2026 16:03:43 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A5F483E76
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 16:03:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sa+VJ5ZPbWT/otcFM6OHYim2Pu6f3Tgp2yrptFmYXiukjku8NAm7y4l+c+0MI+zDAX/J7M2f5QG1WQOzafrBQiCbTjawNnJAa9Zu/13gM/rRuvTVVuzsdaQLrMbatdkGgXpAeRWnfN7HQDaSrknw0sT/rzi79sdjUe92FrIQkb54TE5qjJ+c/2Vbn/MXbR67TP7YdCpMvUZNJXq7lQzHVqbVgCn6dn9ldJznfepMpzetfhxdXyX0ud0ctdq87plTAUrAAftHCd/I7NNEqt9xGMQG7k/bfiwcDRJSl1plAzzXCpOCccZsMdYLlIaLqwG56w6fCo7m4nk8jPuRLGmi1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCM3AeMkFsWR/6kuZUbI7UHUC/yXWmNVAWHjNMgnuGA=;
 b=S9m/thjQFeSfod9GzR4JWGXcUD5+r6SfFzKxzQj3KTJHGshs02FpxtBYjK0jZa6wUuCM7fi6qdzC4vUrFDdxo7w0lACm+2mKH6qRr4oX3WKeLAkXZvFV7UXsYvMuawJleSImTVnZorM2Yx/l2BwddjkWA8h5vGaKCINSdN8CRLI1RAvTPBFBqzR/8WZq2xeQBRSLmpCoWjo+OEv0Axau+U64IIktPzyiExOdV5BfoReA92c/V2+9kur2wV1xHhfj54zZlAg8q51NtDRqRNiJ1kqgs+4JQynd43FdtwKrzLFxb6gUPzTWVhGFcn4eyyRDk9vcWk8BoPCer15nUD4ifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCM3AeMkFsWR/6kuZUbI7UHUC/yXWmNVAWHjNMgnuGA=;
 b=v5Jb7Cd71mISfwwK1Eo1hXye9cp+uQiNw4djr2fV8nGr6O+P3UlyBqVu9+B7PFxg1gmgW0OTnUzk+gyPOAGtXhmllzZMBUxrQCLibCJB3CP86hPg5YKavX5/OunHmoUPiyI5gBlf/R4zPxXnAqL8C5is6Icq+/ANUSgfZTLUIbw=
Received: from PH8PR07CA0032.namprd07.prod.outlook.com (2603:10b6:510:2cf::6)
 by SJ1PR10MB6003.namprd10.prod.outlook.com (2603:10b6:a03:45e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 15:03:35 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::12) by PH8PR07CA0032.outlook.office365.com
 (2603:10b6:510:2cf::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 15:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 15:03:33 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 09:03:27 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 09:03:26 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 09:03:26 -0600
Received: from [10.249.139.123] ([10.249.139.123])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61RF3KP8227007;
 Fri, 27 Feb 2026 09:03:21 -0600
Message-ID: <0980b08b-ef08-4ae5-8656-4b6c211a1680@ti.com>
Date: Fri, 27 Feb 2026 20:33:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] 64-bit PCIe for AM64, AM69, J7200, J722S and J784S4
To: Tom Rini <trini@konsulko.com>
CC: <vigneshr@ti.com>, <anshuld@ti.com>, <d-gole@ti.com>, <n-francis@ti.com>, 
 <bb@ti.com>, <jm@ti.com>, <s-k6@ti.com>, <afd@ti.com>, <u-kumar1@ti.com>, 
 <marek.vasut+renesas@mailbox.org>, <a-dutta@ti.com>,
 <neil.armstrong@linaro.org>, <semen.protsenko@linaro.org>,
 <peng.fan@nxp.com>, <george.mccollister@konsulko.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
References: <20260227115841.333073-1-s-vadapalli@ti.com>
 <20260227143509.GQ1593142@bill-the-cat>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20260227143509.GQ1593142@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SJ1PR10MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d773048-fad3-490c-f2e9-08de76116017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|34020700016|82310400026; 
X-Microsoft-Antispam-Message-Info: W15hoxee9mZnD1K58/BvKChwEq9+Lqr4leHFpz96FVolD3Kk1BwE/DphX3xGaSAIyC5u6dV1uvz3GVUR2f6kIN4JtIRKxqY+WMi0cKO2l59bp5kKDfRnEGPX/DsCEMjbY9DIABh2O5jjzuVRzLEa8loPsPnz4sMkIYfeYA54WjeqfPoOPPKJs8Hkl8SXMEwF4DIGxk96hGNlQWHBn5M7QvEI+orfuiXRlyYYjuwyNkABCDtvfQpISptG3VLtGmbUirCKETzoQZTWeH3tFJNRZ8brYqnhVtO/AiX7EpByw1Cdv2c5k+uBtLCWVtZVEVch2WWLyNVCgb2i5xZpYTw6J5E1jqBw3hANfit9qOLAHACKTTbFEBQANr1kcJS0whsXwRNLKtZKV1PrDvb9gcF0bSrYc8csfLm6VafGWCgho+k4RCKKdKD17xS3V0BE5F5ePjcgwOvbjnGpD0zL+dkDCq9bb8iZnL0BhL++glG+EIjSUzOyiG7YUaKo30B3EcGmdcx3P7s9MMLh1N3Eb9eFpsdB/bOiSeqX4eLaiMtOyCAI0fhEWCRexiXp3Dna71FclNvCHMdEuQVGbeUsrgjh50MFVcNDTzfwN04LRqp71aLm/1Er/yHhUXSr4CBTJGhRp3ARK0gJXdgaHESZ/aibNMwyKU253kwwd81TDI6Dj5ru99QbBwAv+miqtr7dsFryVj35chWtpYVFvKDM1lIRQ9qc5yNjfP9r0Bl0+w8q4UiOrtB12yymBfg3t+VeLTCCdW/bJhLnoTGPedolkYeanw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(34020700016)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zyUL2Kb6YBSHiWRHEb2aZmOa9qNisLjnHrI/kt6ty+vXvUJ7LanSKAg+L/VRHQ2t4fFY7zQrR0QtzQf4aHM6clO0nMxFzB70q+t003/3CJHdQxoLvIyKO30WSI/kgLhpU1194LyvEACi+v53zhmXxqz3lysG5piOlwLrAJGWzeXwrhxQ9p8LRwh3pnTd6Ro5LT1uaaDHd4XUofb5r2jGFUUeBu02YDY9pqOylu3o41gUR0/CfRylo5CdwOa+Xn2Gj3r46UYNxz0WhIF3ollWK7tfvYj49KDglF6Xwphi3c7Wieupz1bZhKf8NlOnfSMQW7jCYMPggDwj0qPuejHhNId3D581SH7oY9nXwklj04RWtMV1zNVwPAnOUHcfkcWHYst3cAtRqiiFxelYGksnY5F8i6TCUFJ994FCxY5o0auWx+wc9680XQ2uBGbSNoVT
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:03:33.1030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d773048-fad3-490c-f2e9-08de76116017
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6003
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

On 27/02/26 8:05 PM, Tom Rini wrote:
> On Fri, Feb 27, 2026 at 05:28:28PM +0530, Siddharth Vadapalli wrote:
>> Hello,
>>
>> This series is based on commit
>> 437ea9f8be5 Gitlab: Fix TEST_PY_TEST_SPEC for qemu-x86_64 in sjg-lab
>> of the master branch of U-Boot.
>>
>> Since Linux device-tree has switched to 64-bit Address space for the
>> PCIe Controllers on TI SoCs, currently, U-Boot needs to support the
>> same. This series adds support for 64-bit addressing for PCIe along with
>> enabling Root-Complex mode of operation for AM69 and J784S4 SoCs.
> 
> At what tag did the device trees change? Thanks.
The DT sync with Linux by the following commit dated 30th July 2025 
changed the PCIe Controller from 32-bit Address Windows to 64-bit 
Address Windows:
https://github.com/u-boot/u-boot/commit/ecec23fc9a9f0eb48b761722c492cbbd4bb2e546

I noticed the PCIe Root-Complex failures for TI SoCs in U-Boot just a 
few days ago. Hence the delay in posting this series to fix the issue.

The MMU changes are needed for J7200 (support for Root-Complex mode 
already exists) and AM69, J784S4 (introduced in this series). MMU 
changes for the other supported SoCs (AM64 and J722S) aren't needed 
coincidentally since their Address Windows fall in the 'Flash 
Peripherals' region that is already setup.

CONFIG_SYS_PCI_64BIT however is needed for all platforms (both those 
which are already supported and those being introduced by this series).

Regards,
Siddharth.
