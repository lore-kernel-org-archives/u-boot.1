Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A265CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 10:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5B9D8341A;
	Wed, 13 May 2026 12:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LWd1qa3O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 927FA8341A; Wed, 13 May 2026 12:02:46 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C39BC80086
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 12:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjlIJDz/dm5cWiyVKzkp9xzDbl2XcBUMAMxGCoiFUJ4TR6kEwU4UcCcKOpKJ7wPxmvCVzT7pSqkS/W+fGjBc2kwyxo0iifKMbwMEspfAX5Nh9cWgR254CoCKs2VgNYS5CV036Yb81ZqjQ+wb3ysSG+lhZHArxQwXr0qhU6/izlV/oakJUiNWEglysCfEvcXtkeLC81kEht6m9AohMf4lkC6vU9ARKZVjFd3YaNdnWcEujvW6CWWobZ+ui4+rOauqa1I6SKiPLBeRxjmP0f7di7HROxJycFVkMEYzhM0VWCegXcw8pEU434Fajpp7ETt3ClTIdV/jzEcknQCW3DSRBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3IbB/9pVRN6cpOd5PCvtZBUz26KajzSi6AKGdIZ1zk=;
 b=qhtoIke6KAQSeznNXc4043LxGqvDNN3GxtWee7lQu7VVJqQ8bnoRAoYqbh6mq5WmmK1u9x4ItF+rrpTohnjlG4pQzwyRRYdISlhp1OKkc6HasdoVNi4XLMAgxG0wlh8dulb1S9qgruhubSy+VFVEd+bX/9aF82f71zWwvNz+OR+tsvSealnFrgM4mBKao/00RDProFt6uFbf3owc6gnXT7gU+AZQpk/6OW7vy7E7TPvgpYcOHf0nGXQanbxg3hfKc/VAlDz2JmwrG6YjAmBLLaRNSLt1f5zWCgnfvG1v4Q42wvs7+XrQk5Qj+BwoNhu/m5f3Mll/lYhs0psBMlzqig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3IbB/9pVRN6cpOd5PCvtZBUz26KajzSi6AKGdIZ1zk=;
 b=LWd1qa3OX1zwOfnkxyhgvEGmrdRYvhD5hP7eiQyLPxLClAvD795eE84uj6UAPPwLyAD6u98Zz/WI9oVaiC9D/BYI+QqwnrC9/x2vqDueD8iMwCFt7L9rZb++7fv4p4U2CUL57dKLzULF/u9dN0IUpyLNj6H5Mes2tjCEkO2JiMJ9T4BlfzwGkKhOJ8ccL3tYfANYOGSPUTYEO47S7RjCIu6fz9Xfzj8qc21XEyp6nJF18lCwGjDY4GicqvCzJ4fwHksIaOEDgYI/oGupc92azlPAEErWl7TVVys+Pd2qtBGWakIFLm0cPWQOfuPq4yP82l72Cj8jwWiQUBpz1BZnkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB7928.eurprd04.prod.outlook.com (2603:10a6:20b:2af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:02:42 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:02:42 +0000
Date: Wed, 13 May 2026 18:05:32 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 uboot-imx@nxp.com, ye.li@oss.nxp.com
Subject: Re: [PATCH] imx: priblob: Fix build break
Message-ID: <agRM7MADZx8cCGNE@shlinux89>
References: <20260511074712.3772830-1-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511074712.3772830-1-ye.li@nxp.com>
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS8PR04MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc9e6ea-1151-4455-19cb-08deb0d6c617
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|19092799006|22082099003|56012099003|18002099003|11063799003|38350700014;
X-Microsoft-Antispam-Message-Info: dHdCBXF0rfOj9V/bVhDmqJYdE8w4n/qDXfXktQzgUjVB/wrWmerohjh+xgeCp5PFcFbSbEnkUfGj4GRMwHUNN7j66qkWhBRsiFUyAiNbMJucPierNX1jX+RB9s4Naby0vk+CmrjqRZkEfTrI5o2XvI1nBOkBlyOuwg38dlMbu7JCwLcVjkS6LqWN6WNRHU7yr8DQYzo2uRwmiEk6xLA0iHDx/YBYG6bxBcDocO44YboJLAq5YjRRc0pMb5EA5ztJlmnaVSWzlclTohvS24tdckUVtTHbrWKamWWx3HMwfyR8tI9FPNjUdKStSLEXsolQJU3RfbQf1ITB+MUr4wvb8zVZ3fJr1QoMXLj2VLv32QRUCZtHbpUGZwLBcOuWn8sc2w7v6lzCj8qlTERtL69KRC7pcg9TpS7c/Ugzopv5OQomPQU3xn6hIF6hBF9dCP6u95gLuCgAlmH1U3bQS/v8TsWPtf2lKFrZLb13Xa2dXOILWYTfYdTIr9Cflin4Bm7C5ouNfS6lckK34D2IX0MrQFcSxQdGBv4xlgOOrVPUznZtRmFl/Nk8pNwScv9kCAKHX//CxqiChdU0P99wmuy7KHUagRAik8GJ9iAhywlUld1MVgZCFAKorQaMPtMWFAcAF1tr29y8LHOIEBWDV+xMxZkEOM3c2Z20dJ/8S5Pq4NbFS4vmofjxiNuwZsoqgEgpGgzsbfiOeOJ8TGjh+lVt98aD3fMXHvrOX6JiUs6vWBd19YtrB6fCNdOfdXlPd8cD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(22082099003)(56012099003)(18002099003)(11063799003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uduu41gAhEMOLsd3PQzt2hTDJTXemyeMoT1cd6KwoRkxkK5/DcvJ9QJ4fK2E?=
 =?us-ascii?Q?EQG24L/oAyQmqjjaQJfmBuSl+Jf8oTinxdFsk5f9lEbLa4PPIByogKxmRPdn?=
 =?us-ascii?Q?OflknXdwtEYGZsdxXBHM9H9QqgZQEIorieuMQOtkEVn9fXUaw7FUhYcuhEx4?=
 =?us-ascii?Q?gxEjTDCXdvcN5M+DfBQoqkHzDsQszX5xxUL5TNtusyCQ6clVjeH2JC8VDUlm?=
 =?us-ascii?Q?ObdtD8PQqCRL1uv6G9JAgUlRYX49KtQHRz+gHOtQ/Rsolxin/+eCSlWSeh1B?=
 =?us-ascii?Q?/JykENYzJGUeT4/kstEnIkRYYuh4KMZk4npxkpH7t1Hsuj6cURam7TujmG2y?=
 =?us-ascii?Q?TN0DIWkRgY7FUhS7AvJu5N8+p6V80A6zIvZwlucPg3ZvtaPr7tWUqHWsGGec?=
 =?us-ascii?Q?QkvROVGSfS9Vts5Xoq3ChfuJLqF0b6KdPcTogwejbh90dsIzad+L9YTKqgx8?=
 =?us-ascii?Q?RnbUU42zNP6ipwYD7DOKVRvEdgz3QdVrbtJ40ciJX3r8fwIFku4uXBNcwOO/?=
 =?us-ascii?Q?nLgApjxvtULTJfMpC5aCZg0d89jdK7Sdb3tcMVRNF3p/XCZ/dQrdMyEJ8tMY?=
 =?us-ascii?Q?GWmBrd/mxkdJ91kY5DyuP4DcsgCyD773ckILl9IbUL9MlQLLK8AZ1pWBHtuD?=
 =?us-ascii?Q?qc6mcRvf/mEQpg6buXxrb1wUknFib3FE3Mn/9xU5LVEd+Tnktov/7nizsp7/?=
 =?us-ascii?Q?j86FQBcYhVjgkZUA3IWhZE6BTmehlg0h4jvW19TzqxpR50JZKMW6IQxDA4OP?=
 =?us-ascii?Q?IV9mQREQMvuZSgRhFo8h39hpAzLYGIIVIIoIOxO7ajzFdQqMsg1twjtDTL8K?=
 =?us-ascii?Q?zBVoQp+YemGNgsrgVq3HoMY+iaW0Hao1pB5DduzDo8Yp8MIueB6plgdHSQWl?=
 =?us-ascii?Q?pmXhPfbzlT5d0cB1eVf1IUfEhUsp5jsmH4WgyXDhf1WGy9WGbtnQ721Qqsom?=
 =?us-ascii?Q?pYXrgnddZ3GoXB+XQyzD3/32g1iWbYAqtGjOyR5M2E9tB2GPUWfjBPSgCsc9?=
 =?us-ascii?Q?QNo5I4gbVOs+whCrZJ8LGjNdQXRxMc8+XjFS0e5F0FuoBrMqNXDMiuQ8I3L7?=
 =?us-ascii?Q?A0Yy8EF5V5NWliOEMRmhcXoRtaC5nIgu+kPmVJvf8FqPvc5lpg77MXzGB9KP?=
 =?us-ascii?Q?cDPajMmJ05svslh4twJb63cuai9fIWVD7k8nq5SNJAxXsZlFEO0PYsIAApvi?=
 =?us-ascii?Q?KXT8MPOtNlhf/lRr8M0G2biV2Kbh0jTJzgYoBLRB9yROGhVjq7i996DT8xLm?=
 =?us-ascii?Q?M4R3Dul91PsoYsYp78JugVZyCJCatGI4cYYEeHDioDqU5/qjU3K7zL1h/JCJ?=
 =?us-ascii?Q?gKMpVNvu8wRWzmWOcyrNw3Bzay8fe4ROiOOnyG8BZfS9i0n5EijE2ANhvfyE?=
 =?us-ascii?Q?8A8WYhO87jL6X4m1Z0mpTFraW7c0nYT4MGZlQbYBAcChR7jXjrAkIEhGkdJp?=
 =?us-ascii?Q?r12eDcp26pt7KOkBf+uW0285S513i/5BlFBIh4VUwXxJCFeF+VCXhxO+iTKs?=
 =?us-ascii?Q?uwCYbCMfM5PCyc8GQ/Hbu+iSxjCCkCjQ5oAGt0R0vS2NIbVKW7bQ8aYfSPX1?=
 =?us-ascii?Q?Mf5g1h8kNcKIZj39uO+HyFRRrJfsXx0PU+b0ELPQiJipnj/VKPe04f3a5uyu?=
 =?us-ascii?Q?w9n3vGFW0SrfVNuFP7XIMtrdNS/dmkod6Cf3ZeJFD5OTCPfn/dOR2lSRG19N?=
 =?us-ascii?Q?vBtgxU3LOoLadxeseYhZkdiHpudrMCMiGM8ePg4hhA4XMNudI+q9JueifFGn?=
 =?us-ascii?Q?BvYXrJcGug=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc9e6ea-1151-4455-19cb-08deb0d6c617
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:02:42.7168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3ZrNgQsRC6L13kuLFcVrc2TUiGHZZDfkVpBlFOh19CrV2FRdIAa3Do6w8IYs0VZs0qNzrDp+1nIMA8wxOzB6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7928
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

On Mon, May 11, 2026 at 03:47:12PM +0800, Ye Li wrote:
>Add config.h to fix CAAM_BASE_ADDR undeclared build error when
>CONFIG_CMD_PRIBLOB enabled.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
