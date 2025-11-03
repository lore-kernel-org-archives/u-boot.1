Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D71CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 06:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37FA983642;
	Mon,  3 Nov 2025 07:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Svg32SGW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FA2583700; Mon,  3 Nov 2025 07:00:37 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azhn15012014.outbound.protection.outlook.com [52.102.136.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D4968331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 07:00:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RazuH+PfyXOFwyZju9sd3ZsGu0n8jJziYNNj4glCSTBDGXkQZ2MIfUVUI6UsBmCVc7SyXjk0iPNU41+t1/N3RKeFqoNYi9JykyaEDIpa36dF0KnJlDrJIK+AiaMIFsj+K/y8l4AWYxm7iOKaHP473Y73aiTOtAHA2+MO7HowqC2E+JLFPSVkPgitpAsx+1ppH4Sby81WyH3PHi38Df8LhNXbja3mNRQNfldYbyZijrhE9gTE/13PqVdhR8GiSPTqL2ANikQCqml6awRw0T9R0F0bsZncJKaKPukoucgOC8X53jGmKwbYf9rW6rdM/SlELZ6OIwUIernqznjJ4TIDoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0kVzYiR6/ob3XmbpT/oNy93fcW2jDN1DtQYI5frNFs=;
 b=JJ2W8i+8As4di0KokWg2sQM1G097x/h91gFPYXq6eqDi2VY+I+gN52iglxjcAI1LcPTsGCGt8RMDlCTtNQMIXmH58pxJOcuwzORtF39kSKGdnXunWuXZC7QVTgrxPeqP5hFgU2ZO1rMk8bNUgsXblPt+Zp+BHF89Yam3I+tq2WAlDPJMXt5LhCB58/7+ipWSRNz69zqfL7a7Qu6wkcgBikuMwQ9kemGk5i2x+cBroLtaGUMUbBWOG6fAWpB1CbVCrrJDMR0von8qFW+FWeHyCXGLSqsL6t37Ik/sw16vdlpaXGjBFaZpPCCZijGDEamkXtZcjq3QuUJxTQTLee7eJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0kVzYiR6/ob3XmbpT/oNy93fcW2jDN1DtQYI5frNFs=;
 b=Svg32SGWg4LSYg7YYNmBcoh0JogNvjXU6Wz/nR48/p3qCkGYWJr+e0sffE81cqOKcc3XXKFIdkzmgg6TPPIC0o36Xy/x/mZ0FhtaoBpE9CxPOq2ksFmNvA9CssDb4jDuiLUr4WlHB0DmuCOGqrp2RuAeCbwCDS3hkWlbDJ+ih3k=
Received: from MN2PR05CA0041.namprd05.prod.outlook.com (2603:10b6:208:236::10)
 by SA1PR10MB997558.namprd10.prod.outlook.com (2603:10b6:806:4ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 06:00:32 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::c0) by MN2PR05CA0041.outlook.office365.com
 (2603:10b6:208:236::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Mon, 3
 Nov 2025 06:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 06:00:30 +0000
Received: from flwvowa01.ent.ti.com (10.64.41.90) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.20; Mon, 3 Nov
 2025 00:00:26 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvowa01.ent.ti.com
 (10.64.41.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.55; Mon, 3 Nov
 2025 00:00:26 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 00:00:26 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A360OSo3631362;
 Mon, 3 Nov 2025 00:00:25 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 3 Nov 2025 11:30:24 +0530
Message-ID: <DDYTWPXUMAPV.2SL2W3ZLG21EX@ti.com>
Subject: Re: [PATCH v1] toradex: verdin-am62: sync rm-cfg with SDK
 11.01.05.03 baseline
From: Anshul Dalal <anshuld@ti.com>
To: Vitor Soares <ivitro@gmail.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Tom Rini <trini@konsulko.com>
CC: Vitor Soares <vitor.soares@toradex.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251028151012.126588-1-ivitro@gmail.com>
In-Reply-To: <20251028151012.126588-1-ivitro@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SA1PR10MB997558:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d9df9c-580d-461e-d652-08de1a9e4b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|34020700016|82310400026|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1hQaVVzdHZ3ODJmODBxZGRVcnhnQWk1UUM5ZDFnRzFBSGhMTWtvdmRma2tw?=
 =?utf-8?B?UkNqVllTY1N6cHhqQmhxZ1VORVFRTGRHOHpKeXdKY3A1dmdiRWo0Vno0WndJ?=
 =?utf-8?B?N2dYTVR4UlU3SEp5THh6Z3NlN3FnTkcyRXl5MTRjU3VkZDBWb0xndDFsUmNa?=
 =?utf-8?B?M1gwRE5idVFLV3hFV1hUY0VIQ1lCTmZyRHVJUFN0SmU4QVNSS3hjamMvdThX?=
 =?utf-8?B?U200SHNqazBabi9vQ3NMQ3FWWTZDczREekdUV0NpcWdrVmtXbnd3ZDl5SGpa?=
 =?utf-8?B?MHdNaUg0UzdpKzNWSVU3d2RmRTNQVlljQWpXUXFFSXNLd0I0aGVKU0dFa09Q?=
 =?utf-8?B?NWRWV3JKRHVmNEVBTmVwZFdPeFdFZHZ6MVJmTzFwdWlxZ3hHaUZ5bjJybkI1?=
 =?utf-8?B?TWtvZW42bExEMnR4aXRFZ3l3anlUYjBRczFhRGRTaVY2b1hTR25oTThkbWR4?=
 =?utf-8?B?ZHFXdnh6UXhuTENvdGdUMTFvc0F3NWpEWk5MWUpibmhsSW5ZYitxVzJvV015?=
 =?utf-8?B?d2NoLzdTM29DaCs0bEFIbVIzSGU3WisvZ0loZ3J5WDlGekIzbWN5bVJxaFAz?=
 =?utf-8?B?SUZYd0dpbWxWdUxPbmdySmVYak4zMTllWENPR3dEcHJoUHVsaW93Tm1XbmFC?=
 =?utf-8?B?cEQvZDE1Q2VDSVBLTzZLWDFWUGJnOXozNVNRTENBRnZVL094YmVDaHc3TXdC?=
 =?utf-8?B?N0RWNUM3d09VL3NQNVpGeGNSYWE4VU9TUE5iSWxMeU9TZ0JhZ2VxZzEzYW11?=
 =?utf-8?B?Z2JFQlZCUzlXN1VtTVpMVjN3UWZqM2gyaHhMbjdKbjczaDVaeEFVanFPMk8w?=
 =?utf-8?B?cU12S2dLb0JDVmxCeWFrRnh1Y3lZSDk3ZlNvck5oSG9rcUJLN3czZWVZOG1M?=
 =?utf-8?B?T2pCdzEzU016NkdmajBqdjBVSlZiN29tbmYyOWR4citkOU1pa3lGTFRxMmZ4?=
 =?utf-8?B?RkM4NXhNWi9rbExjS0VhUERtWFRaL3cxOGdoYkVYQy9JbnFDZExVa2NoZGRB?=
 =?utf-8?B?ZVdNVDlwQ2piNVBVZDh6VjVIamxTT2pFczFKNDNYYzAxcUtlL1U1cWtaM1pR?=
 =?utf-8?B?VmRsdnNtWmlIekcrNWFrRmZ2RDB6R244TDhNRFhndHMzdGtuNFltV081c1dh?=
 =?utf-8?B?TUI4OU9ncnlZQVI4Y3lzWlFIUXVKNHBJb210Q2dKMnhBcHdnWGxmaXhkaG4x?=
 =?utf-8?B?SWNLS0RneFZkeVlkWldzaEdSOXpjMlBodG5pQk1hbGpkeXNkOVlrS0lvNUpP?=
 =?utf-8?B?ZDFYVlZjTjFtTHdjT2dpVGxyREg5QXl4UllZeU5NcDhtUzRUbVdSUllxMm1i?=
 =?utf-8?B?ZWRQV3NvaFgvc2lKNzBuRGFja0dPOWpKZ3RpekU1b1VFZ1hpTkJObDhVKytO?=
 =?utf-8?B?OG5vVE94NUVyb3ljOHNVV2NKa2RKREkwdzYzSVpDK1JzSlFMRlhUREFtUElI?=
 =?utf-8?B?UEQyc2RTUTBDYy9wUDcxZHdOUmVNeDRnWDZ6ck5OYkdJQW5jcTUvM016OWFT?=
 =?utf-8?B?UEJXWFZjcWxGd0ZIUWFHZEUzdnBhdWxmSDdqa0JHVjdaVTd5UGEzdDJIZCtY?=
 =?utf-8?B?UnZKQjFacTJ0ZkRvUHhwSXFjVzhFTVVKTWZKaFBVK211cHJhaGlGMitSeHJO?=
 =?utf-8?B?ek9NUEhPUVgzUFlKeHpQSHhUL3hNNVJsOWxubG9hQjlRQzlnMFpYWG5uV1Fz?=
 =?utf-8?B?Mi93dGdieUtjeUlRYldCcWNMeFp4TEYxYjU0eTJId0c1em50Wjk0U1NKbHdH?=
 =?utf-8?B?aURoT1JXVkNlRkZWU3Nud29oYzBkZmxCYkNyd0lZbUpzYVNkWDl0ZHVsQ1dy?=
 =?utf-8?B?R2NrTVcyU1AwUEtBSG5QeGZtdFNiWjloWUNNSW9aNkwwR05JOFhMUXppb0dw?=
 =?utf-8?B?ZmlUWjFYZzZuMUJvV093MTNoSEJNQnlVNzVYS1NPMGVrNzJQU2lpbmhtVkpp?=
 =?utf-8?B?aUtrQXZkMlBjYy9GT3c5MkovZFZ4cnBKRGF1ZjJDS0N2VVNCK05pMmlXdEI0?=
 =?utf-8?B?cEZNcFNoYTFwK3FvcGNNMTJ6d1FHUXRSaGpHUm9ESklERWxVTXBuTUpBcU45?=
 =?utf-8?B?ZUVuUnRxY203cWd2aGx5NHFhRUM3OXdCWG9Lc1ltK21hbmNZOFRzMmdxVVRx?=
 =?utf-8?Q?MG6M=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(34020700016)(82310400026)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 06:00:30.5756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d9df9c-580d-461e-d652-08de1a9e4b77
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997558
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

On Tue Oct 28, 2025 at 8:40 PM IST, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
>
> Update the resource management configuration (rm-cfg.yaml) to align
> with the default configuration provided in TI's AM62xx Processor SDK
> Linux version 11.01.05.03, generated using the K3 Resource Partitioning
> Tool.
>
> This matches the configuration from board/ti/am62x/rm-cfg.yaml and the
> notable change is the sharing of MCU GPIO interrupts between DM R5 and
> A53 cores, and reservation of an additional virtual interrupt and event
> for TIFS usage.
>
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Reviewed-by: Anshul Dalal <anshuld@ti.com>

Thanks for the patch!
Regards,
Anshul
