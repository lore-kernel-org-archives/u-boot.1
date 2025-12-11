Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1232FD41C14
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 371EC83DE0;
	Thu, 11 Dec 2025 11:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Uh0uxRj/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C92D883655; Thu, 11 Dec 2025 10:00:53 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ADC98352B
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 10:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVCo2SvvA36o/LzRC9B+p4pXFFxpXbw47ZCWUXngPcL6CWyakUG6QzkNP2pjNr+q3yvQqW0HoO4atyoD+d05Jf5DdHsIyhiA2cbmoRhF3qZqeIzkLYWYpcFdPYCTavXcu6MWKDvkFtFrfrWxNa453jbhM1UvTGMLwR/VGFPiGedm50Q+mlfDZI/Za4jWMSpr5BOFacAqC/vzjluYRv8dErld6RbXdAWYybJvWl06r0KWfW94+rxVnP0PMzfFP2YpAv5iRofqTjs00pDoMVq+65gf6nVRFY9GYV4ah/r/k66BqpaGvg+xrYbc9MII6bo50jVVzm2VGmDLkY8+AH4MQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INVzcWcNQ4Y07beEcXbGg8MKN0s+Nrj0nzT+Qrft9JU=;
 b=IIqJMKfhZOfBe/i/v9UVK3F/7ikVBvvuEr7Qq65ShLZmVq/DK1zfucHBsO8duQiNCTw4NtcH51XnMH7IjNUOiRkZP344r7HkBTiGJtqj8CEhHEG6YOnoLeMxzSf42+gmgJj+asg/91/25GCNEs52acY0UKdOovhA9Lxcj7t81a0f+df4fHQA2ijxpNiARv3E9jekBWNdBV/qxhnJAPq+hSe2XwknaQtgYYjqa8cG5q8QJ0ZBRbTCBl93luLAzmUaqVIwkjhxijkISOY2W5zVOV58sOdFQtlqyK0agJ2MUecgCmS1kgjv6pGpIaTYZhF0Xes6Cew4GXVFtIjJBHTgnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INVzcWcNQ4Y07beEcXbGg8MKN0s+Nrj0nzT+Qrft9JU=;
 b=Uh0uxRj/80/jalX85hEECUf89RFfHDOnysOwm2dyJYP9a3y/JbD77yH44FmXcrMWxsgcR0dojnA060pxOgVeSnDTxURDLjPwPBnIaktS7Luxp8ouXb8FNsX0ajiswSORcTY9gD2jEAAumGvoIYH48PVFqgczIPDbKPUaJP8/Pl7VPvrA+5yEkaXPyLUZZyF250fWgPmyE/Y2i9316uyfZi2yyqxe/SdhqGSLg+TUuC5j/C63TNeiYpG4PfBwVd1kVkx4k58w+Z7k1OcWP1lJR5akMniXZtRDYidVocT2oHZ0iIQsYwHZEedCxR4xWfZeuOXCAiLXJG8Ejrl7NF/rIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11304.eurprd04.prod.outlook.com (2603:10a6:150:2a8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 09:00:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 09:00:49 +0000
Date: Thu, 11 Dec 2025 18:14:21 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
Subject: Re: [PATCH v2 5/9] mmc: sdhci: Add SDHCI_SPEC_400, _410, and _420
 version defines
Message-ID: <aTqZfXBiE2-oLS1T@nxa18884-linux.ap.freescale.net>
References: <cover.1764760325.git.tanmay.kathpalia@altera.com>
 <eb896ddffe4ddf9c7a159b2ad2c12e71c7d7101f.1764760325.git.tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb896ddffe4ddf9c7a159b2ad2c12e71c7d7101f.1764760325.git.tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV2PR04MB11304:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2cb2ac-0f0a-495c-b7bc-08de3893c778
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|1800799024|376014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?No1E7z9RhKdcHskRGXyz6VT0PLYsLgHSZX2+LUqJMjOLOa71m8A8pNiCx+MQ?=
 =?us-ascii?Q?WGLJZW07JziiBWDpHrJ1GMbwh0AtKjT2Q5a/acCRcZubAkHXBz6FwAGTB0AB?=
 =?us-ascii?Q?f/OWnAehY4rBcAXQfro7rDC41oJmKmG2pEH45E5/wjDH8abIbg+gMTuyebqu?=
 =?us-ascii?Q?/593AtYh88MAfysPxzRdMLrw4ooNXQjcvJu1CVQtouQPQKYd3zy3hW0tojp0?=
 =?us-ascii?Q?wfZ2UM7Bs7K2o0kKB/PmDit4dUcY3OMKxK3YYcaxAlRi0XQdFJWpf0y17JD3?=
 =?us-ascii?Q?Lt1lYaISgyxTNG/aNabzu61q4hUU4tudHIE+P891TGzioEWGgLyVPSETHG4Z?=
 =?us-ascii?Q?1SwfmxfspE0KnFEW8xI0QT3l0hUttCslaZ/9G9z90TUt+TC5PS/jQt9bJGRX?=
 =?us-ascii?Q?YdHVHgV0L7AfiGJWCU07qCngu0y8na20z2UmZWeF7i7ue/o2s4m7YlixgLSy?=
 =?us-ascii?Q?dvMU4FY5gIVKJF7Ypstb0NvXIjlXfDjJcNJGAiIPYUHk2tG8QBxvJ5fHRfvb?=
 =?us-ascii?Q?5hdYZiygfqM225dFOaqW8gTgAItlyRf7+ts23PE5V7Kk9vhIqrdPVmAH4JSv?=
 =?us-ascii?Q?jbtXihly0TIn9Qn1sJhslDuRg7mQbQsUtfhzFj/kQQK0vEHJrvJxExnn0zfz?=
 =?us-ascii?Q?a/SoNnOKD1/tZF48uMAHMXM3up6ZrLsqthm163530Mb9jyeVulzA2iakSt+N?=
 =?us-ascii?Q?tHZ/OVymhqnVJGi7+3h6/aSCF/cEWjJdN4ADTXzxkTDZGzVNvtApad/TEslD?=
 =?us-ascii?Q?ugdbG0kygeLQ4iIrCjyFOicqDbog7TurbPEAfTNMnUwZcXRNWgIfPQZXN8ls?=
 =?us-ascii?Q?pWi5oqLaMKKn2P9BL2VeBH+aG9GbOSxtXGjJL2xyWNeMEA9cuIfEfuwAgTwt?=
 =?us-ascii?Q?5BNEkzkmMklqDXm2jELzgn+5xTlZW+ws5ew7mPIPeyX1deoNOcfZLKfFhCzt?=
 =?us-ascii?Q?5sDZs6d3yrihxb6ZBAIEWgq99DbUrO3kCeWbdM8YtpjYJf8FqdK+qfnGhpwo?=
 =?us-ascii?Q?qMh+QuxkHAuGb/WAmDk9Vyr0UqjSmHSU1BL6wVH0EU1jfcioApOzWyVAqBqv?=
 =?us-ascii?Q?xAP+u7ZBEADk98tnSPsF65K9LFFvL/6TNTz//Vq8jEQZaCE4GADGtPJUAwHL?=
 =?us-ascii?Q?YKF+8uM933WyzfPs/oOTN35kZJEqsDQ/Rvr7ol06gWFho29UsfpXTIpjS+JU?=
 =?us-ascii?Q?jYHu5x29QaRi2JzdHN7wHJEqltRs7mDFzLkxEItR60zrn0hsnIr6efiLak2b?=
 =?us-ascii?Q?PMwXCgONxEVOCyJRwmwHEz4lUv9dssUAywlIXQLQalJRZvV5xHyRAD8MON7U?=
 =?us-ascii?Q?65zBGFdpNs0WxgG3Tw2oQ8ixZq4F5FHeYH8p2/MZMyIwhMxS8yC+eezZ4GkV?=
 =?us-ascii?Q?vz0sIWKq+nhx+Id1hbz1dZpAqo/A/Zu1zyqlmpf/wLyqrrna/yCBZ6PxDxwz?=
 =?us-ascii?Q?KuxE/Lp526xtJ1EDpCZ+uI1Wgc0J8xcbdVwKKczXFVEdaJYFMlfIQE/pllwQ?=
 =?us-ascii?Q?2JYgmacjcMtqaJ0ydYHPnNI4b+CI+JVn66+9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(1800799024)(376014)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AHhi7UqYJZ+7eDLKQyufTz7BcRAUIsMnKMPWa8ombh4b/SKs9io4XGvA7+Ou?=
 =?us-ascii?Q?8qPqunfO+eYO05JCF45GTLtcPV91ieOFxhHTOi6Ua7n1NmOc1dwdHPs/D3Th?=
 =?us-ascii?Q?uEI9SE2NxHZ47gZ7wELkIjaJjv+5LGQA+N82Wv7gtdxcFHvfm5lMTUdzdvv4?=
 =?us-ascii?Q?A2w7lbNphJeYMPJy3I1a7VNhN0x5YWIyXm2ELyTkfblYYhrCe5w9dWk0vZz0?=
 =?us-ascii?Q?+aMm1Wya7zHp0nsTGauJY4+op1YmJBsNubsTOLjwW6RotKnKETSSdYg13nv0?=
 =?us-ascii?Q?qh3W7DhBlTstfqsI//7or67AaCC+IOBNoW56nWc8wPAqGc6V24Q6iUQT5xOp?=
 =?us-ascii?Q?SkMLC7EJJq1zcfjyJZpA36bCMDj+cXJHmeTd4cBP1ZfvV8xkMFNtE73fgRGv?=
 =?us-ascii?Q?OMvTz8+QQFlGPs0HRkw9mLSgqrg+Xu0SzV2zcuwcx4Ex8tDqtpStgd4fi7Fs?=
 =?us-ascii?Q?PNV1UILavsr+c+RWQCyeBq37u1sGhBfJL8ohginCtQGK/oVTgY7wuIcYfUhA?=
 =?us-ascii?Q?/fY25STeBu9D9lmiKX7FV/vdvJMtBsNhi1t8FPsqU2AA8YPzrgL2DszKQIgO?=
 =?us-ascii?Q?MfuPlxSmbQHmOCYUKVLmRHMZhxQJANzStpI6/cHaNCScGJEOyjEBviBQ3fJL?=
 =?us-ascii?Q?R/WNfK9cwxDv3DuCId3TgkgUf+jrq9p74TmYInZp4wy6/VsVggPNdC/tYW2S?=
 =?us-ascii?Q?99yp8U4ZqINA/dvjNzFtuqYrY6In5o3S+udC2hv3hle/HqndJUtt3iAuyOR/?=
 =?us-ascii?Q?UyUrFPiFmd1WrB9lPIzyQEZ6rqAhPs+/GGxKDkGFfiL2wiKEhSeWZiksDEc1?=
 =?us-ascii?Q?5cPl9aLEXQ/jw3egXkcHA7F74QAhXK2w0+i/p8MPqM6W5BTYwjkrW4ueHbEy?=
 =?us-ascii?Q?bKN0TAzhJ+qqVjOAtZdZVbLnZokavJ/JtwcEjnzwrYGP5+hdzQrF8FiTFzJu?=
 =?us-ascii?Q?3HpyE7YP84ZUZxXQEmUotmlOb627p1EEnR4SMQRO2H/GGZR4wnxmsDo6Gayh?=
 =?us-ascii?Q?OoHBnYUmUgEcJ0QLeZWaFk31ttgfoyYkOysL9NUHbspptpfSdn5+mOfW2J0j?=
 =?us-ascii?Q?gt0zyvMIdMrxEYL/W1v/qW2UBLI/hsw8UpQ4tkdb1cW9hnDLQJHzjkaIBOC2?=
 =?us-ascii?Q?WseylqSLhmQVUQTKh5/lxZAWtUadDzwTHbwEB1H1nHUwyqCbTpd+2MlnpyOA?=
 =?us-ascii?Q?DZWVtcUfFRbOlxLgcxfRI/J3BPwjw11JUWIR9BhHMgakIKY8ZEvPiMpzk/C4?=
 =?us-ascii?Q?q2jvWDIlFr1WzyvRUGf2d83Day4qbiJUAQdSceNd96nGOWkA93+nXrIGqkOj?=
 =?us-ascii?Q?WJAEvX6UEoI3wvfnVQIrL83wpFhHWXdncnBc8I8yjqQ57YqjMWPidxJpmisa?=
 =?us-ascii?Q?OI49U1aUw0Bc9L+j2ekr31iVKytLBfmGJGUVHTB1InrAQtzDd0jlfU0LWmKo?=
 =?us-ascii?Q?qFl298Kbid2xFK0m7m+Het3durPWZVfGKMPsF0yDYJgdf1q2v4zBMnsyY0GU?=
 =?us-ascii?Q?0YrvQ6cjd4dhreboJDydU49H/k6P6pC/CVZNYnWBT0erJ5+No93r6U02uIUj?=
 =?us-ascii?Q?AQ/qdMBCAqmMVVMBhv5YTq33ZJeCs6c6PKX09km+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2cb2ac-0f0a-495c-b7bc-08de3893c778
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 09:00:49.2565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9QTqLjn0mmQnoau0pf+IXrEO0KNrG50ddK4Y0IAtgIRSTDp86aoqjhmMd82Rerj4/Sp4C6NpCPTrJLuA9Lafw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11304
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
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

On Wed, Dec 03, 2025 at 04:21:35AM -0800, Tanmay Kathpalia wrote:
>Add SDHCI_SPEC_400, SDHCI_SPEC_410, and SDHCI_SPEC_420 macros to sdhci.h
>to support newer SDHCI specification versions. These defines are required
>for compatibility with controllers implementing SDHCI 4.0 and above.
>
>Reference:
>https://lore.kernel.org/all/1535617305-16952-2-git-send-email-zhang.chunyan@linaro.org/
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
