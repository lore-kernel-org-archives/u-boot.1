Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5333BCD4F35
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 10:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A834B836AC;
	Wed, 13 May 2026 12:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o4iQpPVQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 866CD84099; Wed, 13 May 2026 12:51:59 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD4A78341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 12:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCo5Ve3u5WlE8eM8ZCa979ZbGTFegJHoVgs8cxHKD9+Zt+yyvTSNHdi3hiiKw9iHQbuTQ/jpayog16jHrbbeNIaNWtStfpRKhZxGuTLaiQKR8A/CvIeRF4yWRMyl0tIINIIyxqv3jo38GZB7msVDEPOlZzMmBNZP/Cl4UJRp3K8K5Y0b4Z0V3xcfNL2vEYGvMnXmWcoVHDJkAGa0cqeO8759c8XB1xPd8i85XgTPU8ENfEz80VZy4t35O38u4x9Pr0BRnvpV5pJb5Uw156hwlT8YczjmKAks5xULq+WxM4bqvXyii7fzceE14XJlZTHuJxIKiDz/MCzbNN+qSqNSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXe45LkzU6JnRkA0hS2Y7/swj3HpUZHCV7TqtGplzfo=;
 b=Uv6KPp8/PvrPvP6i7JtqOSDharOqhRC1Qsebf9HhEpa8uKF8vlOA00ZLYLDP/AM/avIV6QxR95pO/8xNOhey48D6NSOXMnAUuZPLFG99MgS5U4OU453klxb8li2ncEHeiGf8I6mPUqhBY6oIwz/DCzo/D8VIr2Mj3zL+TfSab4FXzJrefsnutZZFqWgOCMShZ0bsjlobRw66eEzEUIJj90dXB94KacA7NWjZ5UhoycSax3vt0cXSSYWBjbhCxiU+Mik7ZIzbfLJ/NdlkEtbXSecaPxYQF7utxgKXocSQeBqJXkocnUH74uOfknS2/CgeurazS8tr+H6bUabMFddrTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXe45LkzU6JnRkA0hS2Y7/swj3HpUZHCV7TqtGplzfo=;
 b=o4iQpPVQPyJn5aCHVYrnovCUrIlQIk+NT5Qaz+ulWEsQ7M/T2Rk4tvAGSqSDBQUe4v3omhir51+MQWSQftQICm2RtTjk/uOwmo3r+dCVA/GAGANRUySNRovxUXYn2I/wSr6PX76LQP3A9Tj+mC+W+UHZbDXkpOuPybzovtggD7CYl/cZsGQGreq2GHL30VP7zGWtFUE4vjfuwTlJY/j0r1IJG4v9lDwL1h2C2wVvNfWle4dZ+bzHGLWQNiVJBJ8wQBdo/BhuELRddpv6rFNkX3a8r4ogZHk9nvO9n9AKBS3CM7xFd4Ffw1NIsiasg3vn0K3stJIUVtbop5HIQ1ug0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PAXPR04MB8079.eurprd04.prod.outlook.com (2603:10a6:102:1cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 13 May
 2026 10:51:54 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:51:54 +0000
Date: Wed, 13 May 2026 18:54:43 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] mmc: bootstd: Staticize and constify driver ops
Message-ID: <agRYc4BCalhQunli@shlinux89>
References: <20260507220757.209233-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507220757.209233-1-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: MA5P287CA0347.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21f::19) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PAXPR04MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d6cd3f-2a8a-4e8f-37e1-08deb0dda59d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|19092799006|52116014|1800799024|38350700014|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: tNB4DtCJG5JAP5iRr+VjYOt4e4RlMKwGe6x36twVNQCzv0bkaWt+hrSORHvzxec2YTEhHNusW3NjYJjPRbB5W5anCXSDsaZyFqEp8BuxxHaXqK+QdcpKfKaQ+HvJ7ioGiLFLz7Xb7P94ZbUEj/34Y1cHIZ0nvJRG9MOCL4OFld2F5OmlCPN9oo/cb7yOoFTTgW5I/4x3BqMsniSahDMQDTBY4bxjt1DNBfkKVxZsJi7JMxadsQ8eLtzjfz75NjD511jflOqh287cd3KgDk0nEeylkZfunmb9/Pry+PbWT86OVoUtyZTL1tt6suvw+6sGWdz3pnc6RgUr6kYILQKTQqig9bsDek84KuV1COSdjVu5Et4a/90B7zpwi7MZUzMx3PRm8OYb8y5Ze8JyogZQ35yaQ9SfHjiTRfUf4IDMCDy4SyMQ8+fB6YzlWJEFVHyzmNwVmGESomcjaxcoF228v5v6YuU43AjvhcfkWErnYVRN+qiRO4i8rlVfTB0yxALjhofndEmG1BO/eazYdFHnrZlv0wzv6fmmWTiNktKIuFB/ORQ/ssLu4Mw7PS5axgjDJIXFXayoEs0CvqdC2z5AKFG8XlLm3DychHwDeUo+FUEgwAvJ9c/mzE+XaMoLm9t/S6u4HcZpmUOi3mtilhuJnP9MyRSrLFoNFySjDXNYvE1mfsG+kTdGeOoA2FdOYCP3Hugk6nsLwkb6XdKFDcnJvi7b73qitYzaPVtLsBTHt1/D5rJCzu9jhwSJv6S0Likd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(19092799006)(52116014)(1800799024)(38350700014)(22082099003)(56012099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2MQ4Qk9iy/P6t24fMJPpEaOBMgCGck+coeJZEbzusAlLRB+Denu5qW3G01C6?=
 =?us-ascii?Q?TF90NhgsXgqmOBNNn3qGkeY+U4KMcxfseZKooJvb6G+IBwBGCGOl9uEzy6Mg?=
 =?us-ascii?Q?K+UiLg2M8sr/i54G8khSKi0kHSIP8XDz0uz2Hx2OCYLDvJ3KUp/WJcLqzhzl?=
 =?us-ascii?Q?QaeVzJfdxHSapEvTYrMvtX5rBHgoHjdyhz+7ABT5slQE+0c0FJWBp3XvZmWP?=
 =?us-ascii?Q?rY0P1dTReu3cakIT9ye8CE+gB1Tx4VJ3V0Es0Y9+fV0Xnqli5LVBY9WtaLc0?=
 =?us-ascii?Q?/xn9YF5tRimyEx+SzVjh5dPcFYLP3gKGgxdFwWfbmiNDNOjwxkq7mQByxWuL?=
 =?us-ascii?Q?jLdM2TGqG6KUn7r7/cy1yx/BsDyp5i8Pyjd71xaDXOZy9taUO/H1FY+qrLFr?=
 =?us-ascii?Q?iJ2m62hz6POBVX6r/xDG/owHNg9b8UvhB3SovGWE+ldCdh9cT4i9i7FkhBpA?=
 =?us-ascii?Q?RwfFbMjaBmkYuCVNTSkk7c2oTsnTfAZA81/c8Xf3DlmUwqvge+SnkMeq4gkr?=
 =?us-ascii?Q?NZRsChfDHr8fc4/7ME/BwHusIpH9gXcga0/lUkZlicatAPpvwfpXEFN/Bwkb?=
 =?us-ascii?Q?N0KiO/NBVUQmZ6s0rzhA/UBikrcBR5M8fT7/4VjfFMs+++a756c6W6sMgQty?=
 =?us-ascii?Q?sP5vssmLjThQpC/fGn4q9e0wPmPHrOd4g0+/cWj9DSOrm/elJYbIAIjOyOGm?=
 =?us-ascii?Q?7tN/dnrsQyjJy+61Hqr2K/WKcSYDqXHk3m9CpKR0uH/EI5g1SIyQFC+I/FNQ?=
 =?us-ascii?Q?jS0SxYWSFjD0ZIovGnsJ1xTIazYN0Zn68FWciHWoDjtONbuIu/Ah7SDjMt5c?=
 =?us-ascii?Q?F3LxsE55s4nP8g+r/aN+GgJfQmxL1QvZmJbQVnCBtTwG2rdT7zjbL+6x+IYc?=
 =?us-ascii?Q?A8m9FCpYQIamKsOUqlAQTiY9qdBAZfs2DEmb25wtEMwVxv0nj6syuuqmbS9A?=
 =?us-ascii?Q?bgzN9jZIbWfq0rQHxzZ2N+JbaOfdjslrJY0Xu5D+u/MMBQHmSfjymmYnHphw?=
 =?us-ascii?Q?XBxUOG3w+f5XChdrxGqx+Gj06ePfAbY4vtah0thrbacWtJTXBpcsMrMQYcaq?=
 =?us-ascii?Q?RPktPmY9BF4W7uZ8un6KhCS5MEIoJSfgLvN2MSmaAHEjfvTERrLHYEJtxHtb?=
 =?us-ascii?Q?3gbWv8z5HJlZBFoqCb+qSK0VRrMslmwUQU5nyELoMq+l2JCay3FYaRBbip6m?=
 =?us-ascii?Q?qG262hokM9KSrSzQc+OYyJL3TYbOP53ToTrt5hf92l8Ko3ejAGKsNr8eAGTN?=
 =?us-ascii?Q?5tbU22OeFGdmy0ZCHVLwLzutqpYSUKySUBwrkUch2en+SMnGYIZKck1jfDR2?=
 =?us-ascii?Q?n6Mx61W4GQbYRzDFfNsfOSM9FTm14/2Owd0HEGzHEGnZdhHnZwHdkek7v64C?=
 =?us-ascii?Q?StDPYOrG/+ZKl4evX7eBAj0djjj/SsYwVnWfWuluS45/b32OzyC4UUzt/YAs?=
 =?us-ascii?Q?GEweBpwff/ALaXR5tfTMy7NzlO1ltPcs/9bs4oacYSL6/f5Q4ADhFY/O8kmX?=
 =?us-ascii?Q?nfM1llD4mM6nCcH2w1Sz57Q1kudx/4UlCNfIORfIdgzHUzAbrjjniF4psmNp?=
 =?us-ascii?Q?hcI+up4QC2TOkrHNMSv/1M1P3BGyLC08JQSkuYEiMqmYlmybs5wyJdtvUUj9?=
 =?us-ascii?Q?TIrQkP28PBUKfq9sip4M40UCdqYPw48opezL8J/texubz4NmoUD2cuElJ8s4?=
 =?us-ascii?Q?AwOEAuC/vCEiFmnJdQeUKia+RycbIihXP0Hb0Bl+CckCBTF3Rqa7ZaA0giGg?=
 =?us-ascii?Q?qYFSCeUpJw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d6cd3f-2a8a-4e8f-37e1-08deb0dda59d
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:51:54.7053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TG1iTLORmPKIPSXQXuphEpYFXKLSCM4FLvxQI/2680wy2jKkcDIsdTnbeKyZ9vHj4Kk8OxXxq26XJWNoZLYI3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8079
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

On Fri, May 08, 2026 at 12:07:48AM +0200, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
