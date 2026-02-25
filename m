Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AA6FD3762
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 15:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF6C483FC1;
	Wed, 25 Feb 2026 16:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ihA8U2bX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB3F983F7D; Wed, 25 Feb 2026 16:49:07 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6653483FF8
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 16:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=sparsh-kumar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzkSDsrPsryMZw48BoN5zqhAKpwCt+rERoBTtI82x+aGDT5rmKExRhxoda9aaZlGVSL/dSLGpiF741bH5UKFXKOpfeh0SGCT+DjFUo64vhMU2p9ubAKEQzMIIMqTJPqHh+f5OZcVyzAvL3HHRCdiFLPbxB3h59E9YV6XGxzTwFFzRIOp2TTe+8lIfOq/lXEF/B30u+ej6rNotJZ8cD0mXFu4QFRnO0cS5PBEtebPj7mNCJtM2pyLXZrrv6UxTtwLXPocBNrrK0VofWsCfCSit0A/c0rn92cyT3oA5SA9Q8rP3TLcex96B6jQgKqKKXb5Gm+prRHjnbfpal9J8MBVFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hL81RT98HmD/OGzBJOwHCoGsNWEyjQp7eCMZ/1x5tDU=;
 b=Xe/BTPr7lGrMqceohCEw0ShbsuiNJBQryjVRoHPDrDEOFaH4bvetvRpBrqge0jT1BazCAGAA4nyYpnnLPJCcYPdNjPEjFTGH501zGr3pEeqeUWJdvnZjbbTVILYdwWjbKglPHC07qpHQwLbM/i7wPyEjOCeICDmnLSsSV5mOn2R50ccY6DGVtvkli1PLp9dimaLq1VkuMaU+8N6CgGZCMJN+sIaylK/fDjG8rf5VspfBrHOozLkflX7O8yLTUlpNGI1NVIaWrLuOaR0Ff+r0KMWpnJnPeRjdC4PCgfn4ghBNEL3ZDUNMrFTcfCZo8xbs/xf4ETncqw9sCi6ejtcSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL81RT98HmD/OGzBJOwHCoGsNWEyjQp7eCMZ/1x5tDU=;
 b=ihA8U2bXu25wooYiZX6doVGq+WLPJjbNYLZ2MEq3zz2rBSCryio371SuYNuhmkPqSoIIPY42N055YcRg1HOSsrFJHQUAWibZweo5gxVEciroWM/LclyfZFBXM5Xp5NJybnysFBwXSZ40SNSW8/aC+lM3rGvzKL7PlQCbYz/QzXA=
Received: from BYAPR05CA0013.namprd05.prod.outlook.com (2603:10b6:a03:c0::26)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 15:47:12 +0000
Received: from CO1PEPF00012E84.namprd03.prod.outlook.com
 (2603:10b6:a03:c0:cafe::c3) by BYAPR05CA0013.outlook.office365.com
 (2603:10b6:a03:c0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 15:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF00012E84.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 15:47:10 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 09:47:07 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 09:47:07 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 09:47:07 -0600
Received: from [172.24.233.216] (uda0510137.dhcp.ti.com [172.24.233.216])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61PFl3uX204649;
 Wed, 25 Feb 2026 09:47:04 -0600
Message-ID: <e6d88daa-c00c-418b-a8df-3714c7254002@ti.com>
Date: Wed, 25 Feb 2026 21:17:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH V2 0/9] board: k3: Sync rm-cfg with TIFS
 v11.02.09 firmware
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <praneeth@ti.com>, <bb@ti.com>, 
 <afd@ti.com>, <n-francis@ti.com>, <vishalm@ti.com>, <sebin.francis@ti.com>,
 <d-gole@ti.com>, <a-kaur@ti.com>
References: <20260225132425.3096103-1-sparsh-kumar@ti.com>
 <20260225151047.GJ1593142@bill-the-cat>
Content-Language: en-US
From: Sparsh Kumar <sparsh-kumar@ti.com>
In-Reply-To: <20260225151047.GJ1593142@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E84:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 792c0fe3-41b8-428c-a98e-08de7485236a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|34070700014|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: jSpBA4pxfq+Hd7wnSNEmLhZcKCBJNsULz6flioF9Ad08c1coUkCJPXfv/BLZG0W7HXsrJZ1Gh0lvAdwkEsXQor8F+pBkqaCvZYHCsuUdT2ywon5PhZ67pjWfXUb5oju+zPA7U6ieXMkKjR+P+9keY4FsWdiUh84Ane8fLfliHE6KiFk0zW8qRtjzNO308UGYSv51Hk3ASksgScJ+VHcPmAjTqCbUOBvC0OlHwqRs9MYjOMfkSXHJif/SH5r/Y7LVtjEQEdEFiEBNmt65fzGmpOQPjDQmoUEFcLQ6aYLvl6jjDcL2tr2/v/T0mplh+M+J8XyYdNrVIYJJ3NZhupypVixUGOLpVg7MASW0ZpXB6NGDc07DXmwFkvD3qItbbczOk5YqU2pVAbdGJO3SqPaUjB4r243vcPfB+koBt6k4ieOuSEevlmCLHmDnPbolKOc+DS7it5W7mZIrVyeOFvYYp38gly12f6E/7qYUfF1pB0LMiQTdvwacNBKN02hx3h2cmCXK0uIhYEmED8q4kB9NoWz7hkLsJD5NhRYeDr257UBy8fcNLVLV33x4UbUiUaSV/uslbEmZz7uiO+vVhfy6mM385YknyeEItsVM+gpCPj0MGy0I//c7Y+8Iq03+aOjW2gATm4ZDleriO3JqmdHjv4YyP69AQBerjNN6HSafVW4dLUMJPBjM9WzgNgWYJaxs0DgnenDUj+n2l2T/pcmc5VNqv+FlC6fSoDQF1WiQZRojpMomXIgQpDRJPDK+9c1QsVB1aYw6uNSzIPeswd59QcQoXn+79mi4ysMMWFc/b8rFPXGHifzh/oZGzUhzQD/ne9F+CWBXYDbifvXdfuzing==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(34070700014)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mcXJSX5LzO6eU0etefEch7UTDKqohOfZo7vMEaIxP/pC8aWPg4jjlUczC+vVESQEL+pS+ZcXO2012A7LFXQtB9laS750bT1s2Otm3thxilV5oBMxhU/AGODD4LuG0JMO+G3vgji4Hf2j3Fq0Dt4nQLaAb6EniNXVDtzZWj0AeOZZR1vjQCbJ0NLwRa+xJ0QpJxypbBI2oaetylxPn9gCQbdrLqag6N6wqadd4v3x9bzLFRfqZQzDBPfx+mTmwrDeyuXRvH6SnDoJgCcBJGzs7rQ5sK+4G7jlzeDA7jZq+Jm6pgCuOM2Ocrkt0e59TDwun/no52JXBkxkDJJvl9Jwu7rQK3LnIDx8+2VwDMxubCVfKp0QLslEds6h4wMu0wZbmPoxBWvOVB9N7GT7FTSUeMPnc1gsFFdcaeNO4GNCMXfWwIUNE7H4rQXcAyeSBfOG
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:47:10.5498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 792c0fe3-41b8-428c-a98e-08de7485236a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E84.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
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

On 25/02/26 8:40 pm, Tom Rini wrote:
> On Wed, Feb 25, 2026 at 06:54:16PM +0530, Sparsh Kumar wrote:
> 
>> This series updates the Resource Management (RM) configuration files
>> for AM62 family devices to align with the TIFS v11.02.09 firmware.
>>
>> Background
>> ----------
>> With the latest TIFS firmware (v11.02.09), an additional virtual
>> interrupt and event is reserved for MCU cores to DM usage on am62x,
>> am62ax, and am62px devices. This series brings the rm-cfg and
>> tifs-rm-cfg files in sync with these firmware changes across both
>> TI reference boards and vendor boards.
>>
>> These changes are backward compatible with older TIFS firmware versions.
>>
>> Additionally, the am62x platform was originally introduced without a
>> tifs-rm-cfg.yaml file, unlike other platforms in the AM62 family.
>> This series addresses that gap and enables tifs-rm-cfg in binman for
>> am625-sk and am62p-sk platforms.
>>
>> Changes
>> -------
>> TI reference boards (patches 1-4):
>>    - Update rm-cfg.yaml for am62x, am62ax, am62px
>>    - Sync am62px tifs-rm-cfg.yaml with TIFS firmware template
>>    - Add missing tifs-rm-cfg.yaml for am62x
>>    - Enable tifs-rm-cfg in binman for am625-sk and am62p-sk
>>
>> Vendor boards (patches 5-9):
>>    - beagleplay (am62x-based)
>>    - phytec phycore_am62x
>>    - toradex verdin-am62
>>    - phytec phycore_am62ax
>>    - toradex verdin-am62p
>>
>> Note: For vendor boards, this series only updates the rm-cfg.yaml files
>> with the required interrupt reservation. The tifs-rm-cfg.yaml files
>> cannot be updated without access to the corresponding SysConfig files,
>> as both rm-cfg.yaml and tifs-rm-cfg.yaml must remain in sync.
> 
> Do I read this right, and the vendor boards will now be broken?
> 
Hello Tom,

No, the vendor boards will not be broken by these changes.

While it is generally recommended to keep rm-cfg.yaml and 
tifs-rm-cfg.yaml in sync, the specific changes in this series do not 
require corresponding tifs-rm-cfg.yaml updates for vendor boards:

   1. AM62ax and AM62px: The global events reservation change in 
rm-cfg.yaml has no corresponding entry in tifs-rm-cfg.yaml, so no sync 
is needed.
   2. AM62x: The virtual interrupt change would ideally need a similar 
update in tifs-rm-cfg.yaml, but none of the vendor boards have this 
file. This series introduces tifs-rm-cfg.yaml only for TI reference 
board to align with other K3 devices.

-- 
Best Regards,
Sparsh
