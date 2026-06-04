Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A226CD6E57
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 02:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFD84848DF;
	Thu,  4 Jun 2026 04:02:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pt2Y11lp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44D32848E2; Thu,  4 Jun 2026 04:02:01 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64D5A84895
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 04:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fL8pAAqSfLMeTMKueq5CzsoLfo11rXqFWdYDTUTt3FBNyHrvSipmK0qFWYsJ1GIIvPX1F9iQ7TtFsxC9faCl4nNxTnAw5baqQNlQ77niYC09ik1fqurqMAsEPZzXtJvEDrNxy1DqiYQ/4Tia+p0y4lFLDtTHhPzQ1mjn/njTROKFMqNyxT3Zh7xac4MnvjJxyem5ttRNSBdTavM7OwxglzfsrTl0gt3HWxD9E8x+EYFgcr8hBBQJrBo5RnNGhzQIqfRG2uqOpsYjbO0/jrlM/N8umJEteaNXHOdW5COmD6fFlcWP+X8gHHAFvNvh+fKP+pl0RKuxax88nXYFxAJisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAjdXIqCgQSnGPJ/NXl2WhjjWhRmL1B8Nh4XP4yVE8I=;
 b=WsB8LtGBc9J1Mz9EKs03h3Wn1qAPBAaQNZB4jMiA+oTSLQEpAmtlvcAjcNtBqVGIeQ2VgmMck643bpBiyE6prAo7B9wiYBsZNCSN6hgchO0XXhwz8Lqe4xs/Gl6uUV//jilRbKkesQDNi7+7fRvNUkqdyZm8AJC2/lwUakEp3LoGuvCez9kFNhFKfi3P/9NCfg167Y8qxCPprYNBYsxwH+GPxEtMsXBg4AdweaLFbnDsrUzxPZPdlW8hviDRny1n4DUE3nR/xmdaBf9VHNzGXqyy3Is3Dd2iX7H1pRqGfQ4+y4JmI/ffp8XUV8v5BMav2/uyXNEpDQdhnrNjOiUF0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAjdXIqCgQSnGPJ/NXl2WhjjWhRmL1B8Nh4XP4yVE8I=;
 b=pt2Y11lpYrVX1P3AY7z7cfPBq61MoGl6k5qbhc/Dul2tlBTDHGCP93xUmDtdjsAjjSyC/upR7Q8+qJblkF0EqzaUD/A0XgBBF4ULnV+XPXGQWFRnm0aiTOGe36u7kKkOeYf14OfHfXs8QGF6n9frO+qQar52+D7Ss+r107X3JB2O3IDCm4WNT0Y+w6PAheqeHEQj9LObcZkh/C3y9CGcfv0N0TJB7QWSZ9afHqIHTb7IGtmR99mBIt0tMBfe3NucH3GosEZDmaovJ/y5WpmpJCbmG7MwrzmfKxjx/9KyTkcJQ4pNVY6VRNodXOPkHtxxuqFGQx0hA94u4I+GYBGIMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA6PR04MB11803.eurprd04.prod.outlook.com (2603:10a6:102:523::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 02:01:57 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 02:01:57 +0000
Date: Thu, 4 Jun 2026 10:05:01 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 uboot-imx@nxp.com, ye.li@oss.nxp.com
Subject: Re: [PATCH 2/4] imx9: scmi: Print CPU part number name
Message-ID: <aiDdTXIUdWma9T//@shlinux89>
References: <20260603055159.414338-1-ye.li@nxp.com>
 <20260603055159.414338-2-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603055159.414338-2-ye.li@nxp.com>
X-ClientProxiedBy: SG2PR06CA0237.apcprd06.prod.outlook.com
 (2603:1096:4:ac::21) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA6PR04MB11803:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de41fb9-048f-4459-8850-08dec1dd423b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|52116014|19092799006|56012099006|18002099003|22082099003|11063799006|4143699003|38350700014;
X-Microsoft-Antispam-Message-Info: FoGXXSa6poIwJtvHMDXTn8sI2Vk5gfFrwdzJl39pcg7g25OgEN65rcRE7LbuSqP4SyJXWyDBBiZzTMhcxVXN0sbSMkcm7tYxXcbAGyfTnoGB+oQ81hFmihIvdjf/3qJlWB7PEXj+PF9ob/GBRwkjKvmbnjc4L6ZR2ywEaFJJxU/oYN4mFO+e3hd8I6FwJPBi1e0Fs/1rTN1GMQ/FQFgsiQ1xs9QbfUYfXoPU9Ng1PE1PXVvyVPj3PY00FJ+8iVnUFCHCS/mAqG3+4tYApLR71EXB1tR5kl3sS87rP5V1I94wmCL4xdB70ns16BbA61ujTJhcwqCWBncTQEleszdpWWPUHeGECqT6pdlpmnBaRaVcshn0LMgUKN+HyIo3xjH9rrKt4AO0wLSqvwdy41Tsq2XQ/2c4cHWE+3MzYNSk413ktuTrDqVs1hqUr1IROBKK671uEie6wfgjgPxCtBdEVhxRbyflvr9H8ybYtpTH47r8bRFyWoT0oTtLMJsCEAed+E9Lx12l+Pjc+aH0atP37IZSOqLfKgYDogZTg0VQMNQuKzkVer+CR5xAs7NQxDC4Biw1MAlGf/kt+0DCD3WKAxTQgnfANIjARifTFTR237lQfTj6Njxi7ldti1Y41eAQ3ipgtG6o8L0Z51WkI0Sk7K+RkEF1YSatvVE8kOAb+EdPe1AX4ZiFHATMEVsXHt3pjZIYkNPBgd8sSdMVio4UxKbra6mYj5MXSQPId7dRF6N83+d1CshD/8YdYRttHQLg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(52116014)(19092799006)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jFVD2T7l0C4F1abSrfyaeRh/QkHOb0gZDwpkgP+PqGC5OQ0nFrlZCPYFwlaa?=
 =?us-ascii?Q?pKlYGnvOSi2kSQsH1WuT4+3KMzjBXihFhDv6un9LdLzJ61OjUq8d6bq2XJvb?=
 =?us-ascii?Q?TFxPmI4z4ct3VLi4fSSdEDuM9E47hI/uQi7JFw7D9xUQs1FGF7vUCDSOH6k/?=
 =?us-ascii?Q?XTxhGSSpIjntjwQzMRHEyKoAGQtqHiNcJ/iGWBmKUS0eBl9XUX1V4av4EzIB?=
 =?us-ascii?Q?XEXdDXoIe7VolZ5wFeCI9DzqWbXk0JKbJeOqQmtYzuNEgHd3YLDuUxgwPb1q?=
 =?us-ascii?Q?tGPBV1nB4uW0C31GT+gvH/RMYXIxQMbDP0LWEZALGXKMAaqeppakzRph4Gh6?=
 =?us-ascii?Q?ff8a3YB3eb2Gb5O/gVJ2yQMt3Y3Ec/QBk7g4p5VDS7yuy2yogXDMRwqrvACO?=
 =?us-ascii?Q?mXDSZmLQMVPpCUwirlmYKd3pc+ZKhKOkxmhsIMzMeUuKXV73BYVSe3ElUgpI?=
 =?us-ascii?Q?o3Dg8zqCrwt27JHCaJz+Q+rn1HvM4TZowo2j9YGrDeLd+eMFpXsfVKesyOpD?=
 =?us-ascii?Q?e/W63pm9v6IzzzGfa/0vmp41DaQA/Z/1K5CJBTpd9cN2U6horD0H601Dfmyp?=
 =?us-ascii?Q?NqHNPO29SzewFvXaX8fDqpndhVRcL+vIO15eJGejXn6TywWfR0tZeHYfR5sm?=
 =?us-ascii?Q?PtnSxGLSHto9QKTq3srpJlmHMejrraR75QCJ7c586c5x8LnV8cqqsvj5qjjJ?=
 =?us-ascii?Q?4L99fMLllHqK97/Aif5pId8gYcMC9pnRmERNv52hXi0tsjQ0KRjcZvmDhBtY?=
 =?us-ascii?Q?zduKGLop41LF7bFQ8bQjOUpM7KN60MFSET0mj1gy//k0H9wEuOrz0i9f10NA?=
 =?us-ascii?Q?yx0zYsXbo7hWSPtYHEGf58j1nLg/3jsbUQBylwUbdivuio5jxwEADw/3ch1B?=
 =?us-ascii?Q?TIqYVpIm2zqDuCMbMMnXskOP0wzYRV+RFh+8aKY4bdWV1fTBOWZQO3Bh3m77?=
 =?us-ascii?Q?f/x0FIJPdKFVr2jKAr11UJkFRQcGgtQw5WSaHIlp/SEj/ugQ4uViywDVR0MV?=
 =?us-ascii?Q?s2IGUEaYCFYGgZiTeENHiBfvSxeTDjNVGaX+BzUAORtrtN1gHa6dAuUis0DN?=
 =?us-ascii?Q?JTqQVtyrcv3qfIuttg43l8N94/56g09xfbOZ8sC4iQK+9Bwu4DQ7yb0ibTyA?=
 =?us-ascii?Q?lXBQ+Er9NUrTrppcUZruBeO6TrO3YMrMjZ/PfOXtZhg3mHEyHZELEZ07ov/Z?=
 =?us-ascii?Q?jSqzp9c5rb6diHchM4gdkwkd+C0S1YIKk252sp1lof0Al5pm7niNjZenQ952?=
 =?us-ascii?Q?oDVTix72Zx0Kkoeyo9WRpXEyajueDRnii5ABEBB9N2oD6N9UxUDPDMAYVwc5?=
 =?us-ascii?Q?L2cmh6cjCHaVF65i1qHIrUxFTmdWZxelGyRN2gdDrpWH3SIHOywsrqCvF3KU?=
 =?us-ascii?Q?2lJuAaq9V6mK7ibGLDltU7fFwC3JikgWheoq04ctZu/8a9iH/KXdE50KO0mh?=
 =?us-ascii?Q?KdD7OBM4YMpbZozKjWn3Fq4xfeOfm2XUNdZwXwjpU6ldM4iWa1JheKxgFp/n?=
 =?us-ascii?Q?dPE3UUm4yqfXJEKWZgE66bf7Pg2JeCgOzbirleru7Vy+tR/H3sv763zg9NCV?=
 =?us-ascii?Q?EztiYMGsuOIIZlUSZHorGw7q6gwIsp831hMseCc0Yx6aOzTjI3TA5KeT3AI4?=
 =?us-ascii?Q?JOhqfk2LJAq/cyUS3A66ZyjZIU3FugxH59RUIXUYOfNlCRHW4WgjLu5lN55y?=
 =?us-ascii?Q?v4TLkmRGZ/Nof6F4vAdxr+ZCXPTEvW4oONsX/57PQu5ab1EMksvd6y2ZZYGg?=
 =?us-ascii?Q?HL3ZzD6kzg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de41fb9-048f-4459-8850-08dec1dd423b
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 02:01:57.8603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2aNNk7GEXfDhdya1pj6K4UV7tRcWG3yVD8G/GLuJxZS3rsXyX/uhYpjCc+Qo7nY8SX3u/+9v4Sf9rXmNdYK2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11803
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

On Wed, Jun 03, 2026 at 01:51:57PM +0800, Ye Li wrote:
>Decode the CPU part number from PART_NUM fuse and print it in CPU name.
>
>For iMX95 and iMX952 Part number fuse is defined as:
>[7:6] : Package description
>[5:2] : Segment
>[1:0] : Number of A55 cores
>
>For iMX94, the PART_NUM[7:0] fuse directly reflects the
>part number value.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
