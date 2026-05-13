Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A06CD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 09:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BFC38466F;
	Wed, 13 May 2026 11:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iT0wg2Ir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A77F84671; Wed, 13 May 2026 11:59:16 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF7D08464D
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 11:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkKPHio2ozaKbWg/qAg2e2hx9enI4UjCjUA1dC046SPhRXF7IjbnVpXqXRUpsjBG5XhReZfw60Ghz99YzHrkcsxpAXuMYJfIp+0Y7KLfOcYf5eiVzQSrV9iPAW28eeRLuEpoxq1Q0rGhsvMXUuizqFTNbmR3PPNrMZCgSid+kFz7taekhQMaqPpC7SI0D7asY27BTRyGRjsyyRWgJBjE+fYn6MWJZIPiPaSSuf62yibOvIb5Rv7E9vmJoVMGCcLqKwaO+SfX7gmZZev+wwnjSjF0BOIHEOlRWk8PNOlAgrfyx9LghwoASwTecom/BTdMXELxmd9LEv4gmtyZR6xfag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YISlFQ3f6E8TMIf+QFTjbYBUYMjygbw385NL+tgF/iQ=;
 b=a8Z20lo1ej2hk7Xs+onPIJTtflDz38n6NGqBgWO8h3U+/Vn5ZLGbAaHzZcDhFcxyfvNmiUN+5EcFp5w1Y/7msWHTfRWa0ruUbVIlmAYqrvw8X32La2/3M7GGcKxDk/g5zuWC1cQ+wJ51izMDYwANj+IpVZBk2h3n+jfSOfX3XYDSyOwYBKh3ME7vnEIZpaIG/HfYUK3i0teEZS9lYU0NltqPUDq0vR9HYSiVpVJKYUjpWDdtQYqQJMKFNOUwZBifODdiVR9G9T6SM7JSSLNIFFU410O344lkYbkpKOG8eVK2H5L+5qaEIEfJLdvglwr/NBjPXOYvX7eU3CsxD/L9LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YISlFQ3f6E8TMIf+QFTjbYBUYMjygbw385NL+tgF/iQ=;
 b=iT0wg2Ir74cH+LB5ayuids9wzjNwEj4mZk+0kNQpSgth6VQgSbFj4s6mESZzO6Gp2RQsSNxCp9Azct/jP53dBZBoe1WwOWAuW7QCWFoM+StVRZgLbtjKyGooU7+uemhv1ZM0BwQZNEnSAieTgoc1ymH2VMLoqi2M3kf9N6BtuwcXl8Y7jzKqe0lIpVadvC1nqOM0f5JcqDzzpbr8unhDewozaX0N9uwQX0JG8N+nkPvSJ8l6wOxNZfAp1+1NTCYVS+iA5u/9R+A3BkmyYGvyRsYUG8BszRDdkD+UJd4UhNGO5MYmAAZkzZ40BmpssGmaBUWNEPrKMFtKzPIndAmVmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI2PR04MB10836.eurprd04.prod.outlook.com (2603:10a6:800:276::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 09:59:13 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 09:59:13 +0000
Date: Wed, 13 May 2026 18:02:03 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 06/14] power: domain: imx8mp-mediamix: Staticize and
 constify driver ops
Message-ID: <agRMG+rjx/tStPsD@shlinux89>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-6-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508122247.512862-6-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI2PR04MB10836:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf27a18-2c20-428e-9f23-08deb0d64906
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|1800799024|376014|38350700014|56012099003|11063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3yOsEcI9y7ZCBG8BZM0Zc6bFb0jGPNRtWUZfDefIV5zfLTa7AJrb6Q8zKMn1EkU+s0SL+Tti16U+lVeWgbhN6ShmIVr5hMhPJBL5QvC4JWbWsdhVMEMulgvjhmZqZZ8o05uWT7O5qDGlmv8CTM7WLul8JeofrU2UGdLT//7h8A9HGMgsEmJXhxtUbBlILSwOr5A6ac53TT6t4rVXt+zGLUn3oYxu86xl6wRvHwKdx9Khi07+W5mqKBlMj+KQBUBjr8aqoRUuIOvdD5ZjHDW9eSS+GPnCz6WEyuQctMsoklHUZvlNfQBunTb12Xu0K2TcRRM9kRwEoU8Y3tuQbPvFupntvkQeScCA4FHDHSc8M+y4WDvNkNiTt2ujGMN42oZTIXupI2JtYmI0itRbymqd+MfxNosWN6U+HnQkMUi5reenOYvrXOGZyvOxomF2S6FjQlVNh0tEtiJexZ5LAXH02i3nKAMsO9BLpcOGtlbxz4YStRCEw/rKGWBamHKWGoj6HaBHDIrWyDBWhMH4ORzFJG/jJudtUbaChnnnVcMdilzZh3u3CYXmpKbwNdCGV6Rbmx0PB830EUoSBCGSmkP+QZuopBGUzjEwHLXHZga5wTbaYdOxJPY60Fkr4RVRNWDI2alaP2xxhb3KwuMFyE2pQ6dd/nA5vDYIs0eyEgDFJDOZJYXqeKux9ugkE9S5/5PKG/JAb4S8vx1XWLdC+198g5E1KfZNTEWXvlHtw2/6GoO/xHoIFNOo5+Orlu7ySKHj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(1800799024)(376014)(38350700014)(56012099003)(11063799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I50myN9OsYoHCWLNSsn59CNwDivDzTpoyf+x4a2pjsgXb7rrT6gA1vxrNlt0?=
 =?us-ascii?Q?kQHpjIdMGrQ9+IgVe4N4opz7vi+MyM8fycJdblPqKpYRuCL94lH2hlI3lWqg?=
 =?us-ascii?Q?9965yhTqW2Zsff+vgg+wZ7vPaBfpAiXPE9H2IAODhGX3zhf2DOuc3Vvr7yRc?=
 =?us-ascii?Q?ex68Mj/BaVkLsefwh07CcQ83AxlakOWECwvxy7bK94qU6+AetaGe/yDYgkC/?=
 =?us-ascii?Q?abWQYEMikimEsPDbcsbLQ1SbGc6hVnIELZb/djlE+O4w+qqw4PL3+y5AWVtW?=
 =?us-ascii?Q?xkDiBUK68FIKgRfYQO/EnYY6gn6LT7WxHxi+32az26kcXMuCy+iu8/3IZ/Ny?=
 =?us-ascii?Q?a/ATGUfRWYZOATIc8yZnTtToqgFlovrFhcRz3xoYqFFTRTiDKOSsxtqsf0Od?=
 =?us-ascii?Q?9xxhnycBRS320pVu6aUBanyqy/P5ppGQI1jHDDD17kx00fj1wD86r7We2XWI?=
 =?us-ascii?Q?qlWg/espUEWl4glpH2a2NW4peMyJEWSx3B1tLS69nEORQOycQpjBqRAAzy6r?=
 =?us-ascii?Q?XZHZ5Swi86CvOmMCX0UY/OBemRFmrcHrMujXzwGzNqkK6TpgRn6urb1wXZGB?=
 =?us-ascii?Q?tvOD4hUq5I5nq6z8im1xsLtYNSJoisbbssDFhUqmUIF7GT5iXoSXH1Cg+9xj?=
 =?us-ascii?Q?aZV4mnTuaeDUBnklDTExMYw+mB7bItGKNt5fIecBYyLboXsUj0G/usTGDsVK?=
 =?us-ascii?Q?YCDBOqmp6dpEJtES8DvJHVPX2jNex2tCH64w0KM8KqXr5hKleHbkfLtxdi29?=
 =?us-ascii?Q?ob1sdNnmKqCNCia8QGOkIWs4wez20M+ankVUMzJrV9MncvdJGoEKCzm/1Ffa?=
 =?us-ascii?Q?Xqxz2uLs6T3MHkCdowtb9+q9dYJbnzJ+CUGPq+hoeafFBWO2YHw085evN7RC?=
 =?us-ascii?Q?gVeZiWDqdk+dcPopNHxxrdQMVbZuITPBEcYEZ59mqkSgZOnAEOFVNH1WLRW6?=
 =?us-ascii?Q?CrxpiYncqYW/bgmH3ANQrtyazek9kQSlJ9TlTxLWNnT2Y5Ugzc0CedvCkBkY?=
 =?us-ascii?Q?h5nySm6viSxo1tRqk29DmFZgok8PZVH6R5AMMTRs3xKl0/WY7fZ6/kT5qkNF?=
 =?us-ascii?Q?SmWk7nHAEkT0HAAsibv7vamO+RbU5vfvt2ymsJF+ibg1t8Ua6xDqIK4qysCQ?=
 =?us-ascii?Q?sK6s1TdCBRmT107jzDH+hau17Kyn59wfgYdiewYzynVIMP2Kqb9V94543RZS?=
 =?us-ascii?Q?LOukCEi5e0gKUE3nc6x3XuCw3VTA2T3Dcukal4m087PiNiCRgbwppcGnWGoc?=
 =?us-ascii?Q?AE7SUX0jjGiIAca0AUAWkMBYZIUTKy3n0gjskzxr2QKvlI+tKtM9Avic8ubA?=
 =?us-ascii?Q?uOcPtxQZBj7IzIJKynV38QYo0Y6sD6RurYSHlAy1RyUAazl/fb1nK4W05+8K?=
 =?us-ascii?Q?Zi0xalYNrhUfitP2ngBVBb7O1QbkJi6TgaBIzhQse5dEvmJnqptlCDOpKEHM?=
 =?us-ascii?Q?Of9wN7EdtWIcKdrbsEDjneIlrTayCKMw4EolDEUOFY7lT1Q6aPsK5cnXyh7r?=
 =?us-ascii?Q?V50VM60kJxVLQNGGIR6jDtExbWVPLdPnZB6ld3OJN+4PmG+3MnCwXgLxbzrV?=
 =?us-ascii?Q?6EeLrD6mnXu9hDt87SX2cBXdryYOXL1LqRhQ0euqsBhePtQh+VV+3MqSdSfe?=
 =?us-ascii?Q?RQj3ckSvLH/3erhiHMcL0KcYjxn8vSuCrDdfIV/S2qaNxut3qwUd0SzzEUe1?=
 =?us-ascii?Q?EourDODTp7EkkdrMcPTX+xYUdAVkFWIxgO626CZeDNEb1zsKBQOxs2kqW5GT?=
 =?us-ascii?Q?BCoJLHwReA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf27a18-2c20-428e-9f23-08deb0d64906
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:59:12.9276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OI3ieRKK+PnFMZVqj8azMtWuMZ3DT429LGBT5pEf4AuIcubPBF5dbQpjP1z9hLV5NSfB3+OIHarsXUbJmKPYAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10836
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

On Fri, May 08, 2026 at 02:22:06PM +0200, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
