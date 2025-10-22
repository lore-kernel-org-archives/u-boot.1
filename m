Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B756CCD195
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D49668381D;
	Wed, 22 Oct 2025 09:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B9Z+B/9M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB225832BC; Wed, 22 Oct 2025 09:16:05 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D03C982E34
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 09:16:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSxyhSwLvEgtMA6v2vCOD1Bp+BnCXo2ImdfFwWNY7eX5LOilQOTFGMxyf2v+LwLfeCnK2hwr0xa3N/hfuij6pILKQmwQtJaK+No3jSlXXZYh2+FSFK9l/mLuZge05k2/dE/ncyf4PjzDd5VCQAS9crYoUVoS4Qp+JPIO+vtY0JhemtZeb4aEyXvkp6Ns2tQHgdvhB1eppQh1IfM+kUGQCYOv5BVgAkgq7CFCLkacZNd7dDj1f5v/+BUzqbcYCT7j5UmSoKh2iqsHv2ryQEGLjvZsRYk1Do3tlZcNBSmWTjhlyiAwBgFna2+grHJV3CbbdrD4BjVeDy35oleiZPDrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykRocAcX27kQzF/zLZC/mSb7UEtgge4/wahtyv81er0=;
 b=wFMA122MZnkjdeqNXAsbWR6R87zaaGnIGkw49vjhIkWrRRg1NL/emOIV28sb6dpRZTnImnVE6Gayha9o/el5ANZJqKL6TFxlRajyUYvpt4NorV2UJwc0AspR68R+rpjE1y/iNQT80MKYQ0+i92XJyfH80waF/N/dYv1/eZSGjQP5HxElo5YItpQliXQBf88MRSQP+xIume/HCeacbUAk1CnzlFglYK5OuBJWzT6f5cL2GvM+LkIlJm6cuhS/RR0lGpGcDFPDLf25M+0o+1qHsqQwPvCJZNNOqXhEIjfEuin2Zsg6C0Nty6CCiEiYPLpZXRwDywNiazTSKXT8MzyyKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykRocAcX27kQzF/zLZC/mSb7UEtgge4/wahtyv81er0=;
 b=B9Z+B/9MQy96ALz9M6Bde11Qf/gGqDcpyl5eOqN5s6GFoCrRANz3lCBazRCj+DaHZ+msymPWTh0s/qZtvMwJX876cFOKRNYKfZcXyOg9AJ4qTnkwIuVnVdpWqAbma9L4WZB/24g3vDiIol5/4/0Dyy1D0hsgNdqP+XVdvaA2Zm1oznOF8okusIA/bp+p/uceB03C8agtYCd4I+uEGRosnjysFRmZa+WbMWoxjo5cxYmCe0qcbYicpJGsnfVSb9z4okSc2SvKuX7wko1oild8+SjrQlUuRl14dxle1zFE7FomZ8ymd6AY6qcWoX3q6wMGsnokopd//CldmHqcnUCzxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA6PR04MB11807.eurprd04.prod.outlook.com (2603:10a6:102:522::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 07:16:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 07:16:01 +0000
Date: Wed, 22 Oct 2025 16:28:16 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Henrik Grimler <henrik@grimler.se>, Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH 5/6] power: regulator: s2mps11: add support for S2MPU05
 PMIC
Message-ID: <20251022082816.GN30163@nxa18884-linux.ap.freescale.net>
References: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
 <20251017-power-pmic-regulator-s2mpu05-v1-5-91cadc0f4156@disroot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-power-pmic-regulator-s2mpu05-v1-5-91cadc0f4156@disroot.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA6PR04MB11807:EE_
X-MS-Office365-Filtering-Correlation-Id: f190bd2f-5a30-40a6-16d8-08de113adb3f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VOCFinlrVoneiFO7LD93c86fDycBi7uhJ6/9TqjHmtdiGtXtZ+2OyQGeaaXt?=
 =?us-ascii?Q?rLznzHxBvdSdafqBSrRKwoN41LreCnbvR1Hv5/qN8ga6z9N+H/sFtVBstvk6?=
 =?us-ascii?Q?I59GmKuE/CuTS52B81xO/XvmBiFg7/pzWCS9NSpoVsxxUvIKp218qjCUCfhm?=
 =?us-ascii?Q?YwVkKEqNVYu0brtgqq9+xYaHIXOFEoDEaJNX9+GicWsIpNISOk2lKDWFaazr?=
 =?us-ascii?Q?g+9UJDloLzBRikYLZhTsgBfjP9UHu3yi+H+0U3LuVnAQw980nBCaYDulmUZa?=
 =?us-ascii?Q?4XWENODW8suCC77zT1xBnWEwtBBq3PJementA9wooonVXEr9/j++emhuXjK3?=
 =?us-ascii?Q?kOA3Vh6QUvSrc5Y4gRk+X13ZWarLztu+LLr0wY8PbZx63R8ITcONLZ4fTyk5?=
 =?us-ascii?Q?jjvcd6F/z3ejPe5CMWRqeLr5e/E+Zf/FTdzzGTh2i//gf4hstCy/D0SWb3Gr?=
 =?us-ascii?Q?rMHwgTJ71yhlDCcokO/hPgk2466pgT6JP6ip1yHYOZfAdlUWinC/CBP35GrT?=
 =?us-ascii?Q?6vGglzFljVx07vCkpfaWnSHiCnhp8y0HoaC7IUWFqaXRclKPVQ0CPAif+s/n?=
 =?us-ascii?Q?bJj2pj5OkRqExM0dGbW0ZHC78J7Fq/XgajDHuQg5afIn4w0OJR5UCFKSVSsl?=
 =?us-ascii?Q?n8/3fOE9SMCHlWrpEqftHl8y6oOf5gTt80ERdRfbPuh3SF21g4mG0XFaPOQ5?=
 =?us-ascii?Q?yvSd5bAnzLMQXuj/L09rIf2W2cAVuE1PqqgvckkB146ihrkt2QWb0lO+7nvq?=
 =?us-ascii?Q?HDgwIEoA6D/OOMrOf2DixdOtAUwQRkRb9ucFr5UuuoyfUfLiXv8cnxVvBrLb?=
 =?us-ascii?Q?8ywthjaqHs0yP6lRYizgfCnswUIAqqjPU0i2urKAvTn8SSXsyNjCjz2wGh1S?=
 =?us-ascii?Q?Snxy55tKwMwvH4eRLtiye7IE6mU62EOZR/rvw6qBDv1AqRKsxBv6BzzkZHv9?=
 =?us-ascii?Q?1UrJVJBQso5oZTz++gHaWUbolWjBE97GgTd+1sT3blhSZROemxcf249FMKiU?=
 =?us-ascii?Q?GbYIV2tqBAKZ03ue4GP9UUhfM8Uk4YXP/E5otzSeyUjlIaTloz9zWvuHa8Pu?=
 =?us-ascii?Q?hRaNLU17n1LF/2z5ue7r8ieifGXr6VEuWuvN3aw85tvT9cjAi43dSe/3TK0h?=
 =?us-ascii?Q?z0KKJ4XvqxgQIhiwdUnRzpUWuSJLf9+17KHZUWUq/SukW4xxPmKpaGEFgHsX?=
 =?us-ascii?Q?xyiRHplTh+cSkjXt7T7KIHpA7jj7hnx5As5CAvTbQs7A+yrl6YiHMc4oZtuM?=
 =?us-ascii?Q?kjn1ALA4vVxo5oV5agnmIMT8zcfoUK8dQp4ir+PbmqvhyGHNjSW0bVNMZE+f?=
 =?us-ascii?Q?TtmVQ2sKAakEwFhf2NRXrQ8nzXORtp9HdT/Dq1hNIxHXCCb4om0k+VFTSQMb?=
 =?us-ascii?Q?u420CNHJJQAbWSS9YKWIodLFl2tKOD/IeR/i+k4HveS+LKXZY4Wu6lMjrC3C?=
 =?us-ascii?Q?oj1kyMAgHFhepl+2aAll8lFY1xNKJkKmUiG4nIKq5PC1KS4InnnbfI2Uws+C?=
 =?us-ascii?Q?oyhZSbPWz2dkSyOPA9afUkB3PGXnDtesjlar?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RYvIW26aD1ubOL9WmuG0ky8JC/xnSUFf7LtHQuEQavApY329orNvKghsz45N?=
 =?us-ascii?Q?G4P8ex1mS0bKTtiJIaUapU88JI/YMTjTGbZ1sSYDTRFGUcqJOBN7KAC46AhK?=
 =?us-ascii?Q?yi0kqy5Ah4VzmZqo3R//5v7GziF8RYEVaQmbIADbIcfbnSf7QTl5U2afG3E7?=
 =?us-ascii?Q?Hh1KL43ieY4TW+nYoIEkSVP1Vw9J8TbX3Hy9qjO1f6qAHtMZvy2rMTgAmpZK?=
 =?us-ascii?Q?k8sIDgTtuIAp7t/XdAh5+gWhbjKrAuHDfSGaA352FfkDEaLCzqUWOg6Qpw4w?=
 =?us-ascii?Q?+84hzrHJECh8vvmCTx5WD39gdTWVx4LUfSLWIEyDOtbBL5zWntL2sXkYtVa/?=
 =?us-ascii?Q?Rec8S7bsCjlwCIxzOxT81I9ZoZ/dASW13ah9Miwm1AY4wodBlqj9p4/gj6QM?=
 =?us-ascii?Q?t/VcYjeS8V1xj4ibTFQJFRasq2HuLwc+tARhKAkOnI5C6g28Y/MpxjvtqeBj?=
 =?us-ascii?Q?iN9XOdqc1rUTIxYAd1oNLDnTn0of6pGd5JHLZN/GQGFNSy49x2BEPwsrzEq4?=
 =?us-ascii?Q?BfKjY+MhnHWH+C9J2/mzXnqimQOkIj7hfUwkJNEgprPl/8EWjk1LFILIRxw6?=
 =?us-ascii?Q?4T++ykTqetprjVe9fe8WgNViUZIoqLVPZg5EQu+yYglFITtWVzrm7jdYIIKy?=
 =?us-ascii?Q?hTr4SsqvlBSxF8eNk1hXlBkvX9UDRRCNqAXuX2xIKFN2P8Mh2xtpch/NC4LV?=
 =?us-ascii?Q?gImRN/oVr+ac8cml2c8seoW3luNc6nDePzShkuHxWarL5f+ln3s4y+fbyaPc?=
 =?us-ascii?Q?dxoNvnYgfLVKJbfwx1Q7uP+S/PvpR7kDTkWnxQ9i5eOWBDtudWl5xUwU7XJa?=
 =?us-ascii?Q?iw4W+sU/4Mywgna1BgGCjyTKImJL6u181ggKjNWfajVWqiZCcliXumPuqXY/?=
 =?us-ascii?Q?qDpar8+0j5l2LUZ68c0A7lrOcgILyDXrGKSLVWGSvIzOH/c0VLNOKnF/jSvC?=
 =?us-ascii?Q?JMmF0+gsVuKVb156oPeL7nxLMa+DsbpWlpNPY/PNLc0IYtQNa3XY/u0G3uuk?=
 =?us-ascii?Q?hmYg3FzPZIMgEqlbVeS+U02Ci+tWUvdHNkhukqyMZoFnn5hsdeJHR6+pEn3D?=
 =?us-ascii?Q?rQSmbU6sT8qX/507bqwSwaBC2cpKF0rP6DVuBu11Spn1ampd2wNXopwz82XS?=
 =?us-ascii?Q?WlGIYyME67YZe2pCdZesGfsHqMPxew3pA0/7YQsDNY2KllVe0826I8+kFD+U?=
 =?us-ascii?Q?qb8idSf47OG9WHqc/NHbpZjM7wnwJMrHS9YGh/2VV4nDVK2+oWEaZ4jeo6Pr?=
 =?us-ascii?Q?FBM4rTMNqELVM12yKpa6rUCCRn2U5dh/aW9vTCin37rboY0DCJNQpPIjLB71?=
 =?us-ascii?Q?tiwowzArr3WuxS1zN2qCR7k171lwyKdMb+10BLdJ9aSGCnP7M/9o3kI1UguF?=
 =?us-ascii?Q?70HveIMmkZ4M6Qt6FcPDR1br8RF0a4y3XrA6ekZdlS76prCNH9ssU2XjVVPT?=
 =?us-ascii?Q?16a7A7NlKjPPwvGCMcZ+kc8lTZ48f4sehJpk6wAE6kCQWuCk9F/FtZd1VabH?=
 =?us-ascii?Q?4FOHAckoQjeImkwAxDxymoPY5s+oHNUYv2r35KDJsbf2RxedF4o3Ixavx8EZ?=
 =?us-ascii?Q?wVZ5l6fKGQZurHH9ATwSHIW3X/ckHLXPf7xxaH9M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f190bd2f-5a30-40a6-16d8-08de113adb3f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:16:01.8748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qpa9q1RKArVCSQMjDq/AjocYXH9ma6lQMrALiyKdqBrrW9mI8MFO+ShY7NaaWr6hLaLIbFdCQnO/actNL8TziA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11807
X-Mailman-Approved-At: Wed, 22 Oct 2025 09:21:43 +0200
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

On Fri, Oct 17, 2025 at 08:58:20PM +0530, Kaustabh Chakraborty wrote:
>Samsung's S2MPU05 PMIC is used by Exynos7870 SoC. It has 5 buck and 38
>LDO regulators. Add support for this device variant in the driver.
>
>Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
