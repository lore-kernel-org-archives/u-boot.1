Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F50CD64072
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 05:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88BF783979;
	Wed, 17 Dec 2025 06:33:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sdATu5Pa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05891839FA; Wed, 17 Dec 2025 06:33:58 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2796C8334F
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 06:33:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLs6pLIGHx58E2hzef2iophN8CHfnXHw2uqE4QDVpylnjKjlr6BFIyE81wTmarYSyaT413LyGtNNza50VWsPawii9fnnBMCtzeLj9z9TvvSO+ctLn7HvXoHJzFzeszV6KWxK8pKiuYBWoPvCTkPCEhYXIwGdwHtXayyjuS+QuC6lX3cKGVki5aui+W3dlbOOVvH0Z7qPW/qhrKi3nhJdaAzZsKBbohCPeQTth1ovFPZ6NPG9L8xBb0liEMQ41VehkK/woSZZQ07otjTNxxvnTuQigfR4aJPBkgsiGULxsWCDhEloRtKDFMY4olC+tOdaaYLCA1rMYPzc1RhbNL5lkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oZL47zTm83+4T56In1GMEpjTF95abAKlgFgYI1+buw=;
 b=GZB18o5ZMrfRwN7qpjkLpiOnhta8Sxer//W0T9cQwEOEQDIbrcC5dfTQGT4lYN92P+Qfy+ch51nsJiD9jlaFOrDSng03ejcXOYAsuMhc5VShlWEViyrMdkUEJBdF4W7gHHw0SAzfUNfuIKlgtLPML1aRj/PXf0cXlvYmVAh6uNDNNCdflwpLPbvGQhaeJk63za2QzlQzMCKf/boOJoLY9vwvGm1Fc5kFLfyo0pqeGMaMm2XqE1rHcWEqVXzeCbgSp1vVb+y7Z1atE0CjoCQBIk4qdOKeN9dAN7JDlRqFqm0CYxdpzevHwBbSOkrShSf0KPLNlHQU2i20SBbiLggwgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=dh-electronics.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oZL47zTm83+4T56In1GMEpjTF95abAKlgFgYI1+buw=;
 b=sdATu5Pa77tb35BrjngXytCYZvi27ANuGwfdMX9PNWzrim++Kg+RYVsZEm4gaNhjF+7WOuhPfW4RqdcLxDjt6IkOguQtj+Yir6VTalv6229JnH0IfEZ8FrsQGWcaDnB1YkpTm7j2gK3FsY+jYZtWWbxaIrPiSKfRgOJ6+RCyj7g=
Received: from BN9PR03CA0149.namprd03.prod.outlook.com (2603:10b6:408:fe::34)
 by PH5PR10MB997758.namprd10.prod.outlook.com (2603:10b6:510:39e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 05:33:52 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::f1) by BN9PR03CA0149.outlook.office365.com
 (2603:10b6:408:fe::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 05:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 05:33:51 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Dec
 2025 23:33:45 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Dec
 2025 23:33:45 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Dec 2025 23:33:44 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BH5XhfC1013754;
 Tue, 16 Dec 2025 23:33:44 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Dec 2025 11:03:43 +0530
Message-ID: <DF08W9D84X84.1DQ1VM5S8TT9D@ti.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>, Judith Mendez
 <jm@ti.com>, Udit Kumar <u-kumar1@ti.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Vignesh R
 <vigneshr@ti.com>, Christoph Niedermaier <cniedermaier@dh-electronics.com>
Subject: Re: [PATCH next v3] Kconfig: select
 SPL_USE_TINY_PRINTF_POINTER_SUPPORT for K3
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251204-am65_dfu_fix-v3-1-de18ed3f346d@ti.com>
 <DEZHV1ELFZ43.E3FN619R0UNY@ti.com> <20251216140104.GU303283@bill-the-cat>
In-Reply-To: <20251216140104.GU303283@bill-the-cat>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|PH5PR10MB997758:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e5346ba-ba15-40f3-c2b6-08de3d2ddc75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmk0L0FLaEkwUU1ZY1hySDNMWnBVM3pwQ0ZhQkovblNhSjEraDlnQWtEQUMw?=
 =?utf-8?B?OGhxSGMyMU9QSkNMbjYzREZYSHBlRkRjUlF1OXQyZ1I2eGlIdnNiTWF6Sm0v?=
 =?utf-8?B?SjlORWx6MGtqNVJhOUltUXJNek1ReGdIQ3VRVFV5bWlHbEdLN3paZmwxa21T?=
 =?utf-8?B?c1FkcUtoZnpLWmdRcEFQUU9TYTdWVWxGS0FyMU11YXdYeGpsTm9IbHZQREts?=
 =?utf-8?B?aHU3Z01yNDZUNnN5L2oxUjJlWmhpR1lZc1BjWktIbWRRb3NYNytpRDAwLzhF?=
 =?utf-8?B?VHZnM2FYclBha1V2a2dSSzkxYXI1cC9FdzNMWE1tQy9XM3dPWTdIV2ZmSHVE?=
 =?utf-8?B?NENQNzFjem9UcFh3MFVJRjRHUldVWlFhNDZsSU5KT3ZZWFEvNkdUYW1oV1lz?=
 =?utf-8?B?NGsxaFZpSi91RS9KejdxUU9NNzBtTWVEK3p6c3lsbUlLM3QwNHlLQ0xpVmE2?=
 =?utf-8?B?eDJPdEJWWGM5QkpXOVpLS2RYNXhKcjNsZVFvOWMxeXhSMUFvS3U0aGVVcFFR?=
 =?utf-8?B?ZjVzQnZ5SXp0VkdNQUZNM1FtMXhIa2RsbEx5eW1WcXlCMnRUZlFqUlMxR2FR?=
 =?utf-8?B?S0VtRW5BbkltcFUrTUFrUUk1bnVQbFFuTW1sM2pwc29mOUROVEVxS3U0cXRw?=
 =?utf-8?B?TzRMSVlSejJrdXh5Q3U3a3RoaVhjbnJsaXB5c0hWUlhFb3RyOVMvZVh5ZWRS?=
 =?utf-8?B?Vnl0VWRHUEdWeVdGWkZBVDlmdnowQm92a016S3dGcnZVZjlhbWMzL3ByRkZQ?=
 =?utf-8?B?ck9HVTBCQlcwVCs1UDJmclhkVi9teUVYeGtuYVFQMXdBdFJZUjlhcDUzcTN0?=
 =?utf-8?B?MTFQb0srNkIxWHlBY0MwVnU2L0xsNnQvaDBYbGEraEJ4UTRjWmIxWDdYTkFR?=
 =?utf-8?B?Z25iOGlMV3dmMGpSVTVJbHV3MHNlTko0b0tlTnJCcmxIUGk5cE1XYmhhUERo?=
 =?utf-8?B?cndKeEZFL0JFU3hGZW5XTlB6WG5pbU1YZlMrRFcxbzZKc2dSOU9vWWlxWGgv?=
 =?utf-8?B?enUrYyt5aEJtM3cyQ2RzREZQNkhLV2Vpc0wzbzU2QlpicDVXZEdHdlQ5RmlV?=
 =?utf-8?B?a3k4NXhLQjRGdzNJdG5xUkRKZ0luVENVamI4akdyZ045UTJ1RjhMUXp2emVS?=
 =?utf-8?B?aUxxbTdqL1ZReHJweEZWdVhBWXd1MmxVK29NRjlNS2didUpqSFFnMFZXdmV5?=
 =?utf-8?B?UEdadUFxQUZnMFNvczNiWlBXSE9mL2prcDA4K0VNb1NMczFQbnlhWUZQWkJN?=
 =?utf-8?B?cjV0dlZWeEprTDVVOS9JTm5yU1hjZ2lIUFA3OFlRQ0ZPMWJieXVpSjFUb3NK?=
 =?utf-8?B?ZnNkQTZmWC9aN1ZkSStGVW9kbW5NcVhoRTdrdnlPUzFucjJhZFBRb0F6NjhV?=
 =?utf-8?B?VEtIY3dXMmxGd1AxYzBGbWpNQWM0ZnhwWHBqcEtMc1E1NkdXZ0RadTdXbFky?=
 =?utf-8?B?MUZlbTVZWGxwcEpzSXhZNThIZ05xWjBVcnR0TVVLaUJmS2ZIQ3dxU29HMFQ4?=
 =?utf-8?B?UE0yOFVaL2p6YXR3djMveGlPMklpVTd1eXBQM2pZakJCdW00N1R6eExGNkNX?=
 =?utf-8?B?VnNvRS9BeU54OHJjRzJmc1BQNjd2MEs4bEhISmU0bnlvd0cwWC9Fd2d5N1hS?=
 =?utf-8?B?QVo5KzdaVEpDN1YxQWpzUFc5MnZuZWQwNmUzQ2w4blZ0SjhSOWNBQVNYVFVD?=
 =?utf-8?B?d3hYV215WUI0Q01zWjkzWG5WaFl2NVpudm9WQUV6emdBOHNWbWJGY1dWRUh2?=
 =?utf-8?B?MTJEK1RJbnA0TGp2R2p4emh5bWpUbkhRYTdqSzdINFhhYkVBa3ZFNGJqRWtu?=
 =?utf-8?B?N0tZYXVrL041OWtnRTdpMEtkZi9KdHZrWFE3eXZYL0lhUFFxRGQwOVdNTGNR?=
 =?utf-8?B?Y01taFgxSHNZNVdiaFh6UkhHdEN3M044RUUxbHZnM1p0NWFIWXgwVUV0d3gx?=
 =?utf-8?B?Nm42MkczeVlYc0dSeXVZUndYa1NPZjhWRStCd1Vyb1k0VW0wNEVkdmY1Y0NL?=
 =?utf-8?B?NldneTJKRUZuZGhueEllcHpESHFGUklZMUpkUGdOalVJMFRZWDVBbXRjallr?=
 =?utf-8?B?b09aODhlYVpEVkJSd3NHcGkwN3ViNTliRWlac1NJSWU1SWZkR1VUYlIwUnE3?=
 =?utf-8?Q?LKiw=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 05:33:51.3493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5346ba-ba15-40f3-c2b6-08de3d2ddc75
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997758
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

On Tue Dec 16, 2025 at 7:31 PM IST, Tom Rini wrote:
> On Tue, Dec 16, 2025 at 01:52:37PM +0530, Anshul Dalal wrote:
>> Hi all,
>>=20
>> Any updates on this patch? If possible could we pull this fix into
>> master as well for the 2026.01 release?
>
> I thought the feedback was that this was a generic problem and so the
> Kconfig logic should be universal, or there was an incorrectly /
> sub-optimally handled case in the tiny printf code, that needs fixing.

We have a few ways to go about fixing this:

1. Fix the commit 1e24e84db41a ("tiny-printf: Handle formatting of %p
   with an extra Kconfig"):

   Pointer formatting used to fall back to %x handling before the
   commit. Though going by the commit description, it looks like the
   change was intended. So, I'm unsure if we should re-introduce the
   confusing handling back where %p is handled but not %pa or %pap.

2. Add SPL_USE_TINY_PRINTF_POINTER_SUPPORT per defconfig:

   This was what v2 of the series were attempting to do but as Andrew
   pointed out, there might be other platforms with similar issues and
   it would be better to fix it for K3 overall.

3. Change usage of %p in k3_sysfw_dfu_download to %x:

   This is a suitable fix imo but we might still have to fix similar
   usages of %p in other places. We'd also have to be more careful when
   bringing proper U-Boot code to SPL since %p would not work the same
   way.

4. Unconditionally select SPL_USE_TINY_PRINTF_POINTER_SUPPORT for K3:

   This allows us to remedy the problems with above 3 solutions with
   very little overhead to the SPL size (<100 bytes).

If this problem is faced by non K3 platforms as well, perhaps it might
be better to take the hit and make SPL_USE_TINY_PRINTF_POINTER_SUPPORT
default y.

Regards,
Anshul



