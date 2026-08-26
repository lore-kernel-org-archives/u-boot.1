Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B16C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 08:47:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33878605E0;
	Wed, 26 Aug 2026 08:47:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id US4miocXKATp; Wed, 26 Aug 2026 08:47:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787734045;
	bh=95AFOCpXwPvYwMz9lvx6M9FgEejTN4qD3uB7YBfEdkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Or5ZdCFjdSvQeVgaLKnRSQoPTWBVSZyg8kHPokreRPjQjbZ1SGe0zfVivD5uQu0W0
	 eUj1teidLU3e5iSJ9THY5DOjyH23usfJSQ0t7h0sFm+LbAzlI3IpKn6DOj1Wpp6/YT
	 3OuugDohhr2/4oEuRP7zZWOQ2m88OXinyTdbmhF6uUx/I7ev5ScguPIYEf+cc6APYs
	 EuVYb7gyHfeorRVN6ydNtv7pQsmu7FsjsYyKn/lBsNZY/p4+eeHZBJJnggwUlIm5qC
	 q2X0e/JQafrml4X2W3mOtnr5KglMfsuE05duizzUO1yAMneryCLZiynRW+pAztf1LT
	 j4F1ZA8Xzvk8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE3756070D;
	Wed, 26 Aug 2026 08:47:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E5664105
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:47:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BAD54401DD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:47:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rORs8eE368zs for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 08:47:24 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=qjGtyD9x
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DEB02400F2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:47:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhvAaRjWwF+Y8ShqWvwhxJYSV1E94euF2H6tix1LFB3ua4RBp3uMsicDh3ZIYbzmCF4hq5VVBuJAk5+RbNUSoA2FS1wgsOY4ZYCKDW8nNUCwehvBT+/kh8AioOxsoHlaqAzO+hJSsTqkKbcIhAdbf/jaIyi4/wiOFarYsU/r40yOQy+5XXWQQgrRXAkX26DoR/tF0BSg6TKIdWVFxaMISplcj2BqMeMNMXc7nFTH80Y17AMuGKvQ0w8mZqTsYKo1iT9PojiAJ1gwtlirOJCFhJrMFUg45Ez/uAJbzK3QFqmOwXswdETj2ln++tYkRi8tjdcFrM67hyVlQmNmbcP0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95AFOCpXwPvYwMz9lvx6M9FgEejTN4qD3uB7YBfEdkA=;
 b=u+Jm17bpm3v/vhz/XkBS5NTZGFWh+HGZEz22lSjz9uZ3UdTnwc0f8Vy/FEPsWlj5XMiys3+Aep8uYwMDADxOhFaCPEDuBOIqUPhrOib68jVMpyZ70VzNi55olluxNt9aJ55y29XeKEZlsFpzQf235q/UHfAE0wVb1YvgrsEpqF/1PnG6QUSt1F4UB15tV3LffMhJMpqN34fdvpDX+OorA0Zp/54sQwH3Zn+BfmpZ9FrrLhAXEYe6EGzsMufhRys56ZdhOPeo/8B0bEn07BdOFF2z8VQMdw2qFFJi6kkx2G6oZILgtF4JtBOpU9ioeRnIUVvxlS3fLetsdmFsu7zpAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95AFOCpXwPvYwMz9lvx6M9FgEejTN4qD3uB7YBfEdkA=;
 b=qjGtyD9xtJ1Ds9s5s/viduXooFhfAq5F3bv/jPeEL6PNYbkVgcgCdv7n2prIwFGXhjRoxMhI6q/9Q2yxRj+a3O20f+kSbXWrAb6wuVkhdq0a3AmK8G8l8c36tGr+YegOeWid2/8Fk3te+xLB+KK2wI5o4LEqK0xxKGZeUdocFQg9IFnr8VY4Zjwf8Ku7REdXDq1iW+3VipusSrlzhF6bBFsHlVowgFfzhQl9swG17TAoAJ3mQ+JNlZ2AxA6tiQ1p3qIEtom4vTYRSndHA/ZXeJfSuOyqCLJ1w1jP475yEdoPZ66YxuAKsQMr5Iu6LBk1VByB78TvHeh2cLF68c34sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB9076.eurprd04.prod.outlook.com (2603:10a6:102:22a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 08:47:16 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 08:47:16 +0000
Date: Wed, 26 Aug 2026 16:44:51 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 5/5] mmc: Make "MMC Device not found" a debug output
Message-ID: <ao6ng6CGIYy9aEK0@nxa18884-linux-1.ap.freescale.net>
References: <cover.1787514446.git.jan.kiszka@siemens.com>
 <57a99d87a25d42f68f26697b81fafefcae29abad.1787514446.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57a99d87a25d42f68f26697b81fafefcae29abad.1787514446.git.jan.kiszka@siemens.com>
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b11ffa-8850-40df-def2-08df034ea10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|23010399003|366016|376014|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cqlVRl+WsMUXEnQe6h7/COkqhbSxYQhi0ydmHKqMqHZJfLqyyHJICyAo6nN/98k7KAMEO6UVf9lfI7PMl45pDRGaljrN62+rMibuO0ehkWx2oxnTe54uu+0Z8JVFFwwzPIJPQZ1XkkIp69pMQmRuF8X97q2dcaq2m8MCoRVTMRa+7MOMzC055+C/PKwO49rCRMDnGgWfuqLQZCA0dGj86e9aZBssDWliYTskQLwYswOksUt/S9YOSkjAT1EhhLQ/oTOZ/tlEbNJ5iteqODzSw0qCeNMl4Zq0FobB6acqiDC49FBHnIqvUrMDL92Ny1mtAWWGhP6ayMCrznnG/UnyycEjQtOm1WoVC1vKh/WlaKEe7xiqOG9qmRUfMwwW9vl2iDJ2Ft5VQmtYUej8ye3Qv4eRvFAKdkF1UL9mEJqS0jg49tIQr/of/Ir5DTgrLHwGOxVaPNDkT9PJxqxXnFbiCmDj7xD8n4/zcwihxAgZFROYAInVsMOYJzeXQwH5io7BEFz83nOTQb46jZAHNY+ZmXjEn6P43mMEAVXyQ/cdQAzcMgBhsblJ10wm09obbEFe/8MxDxdJso5s3X41v2PAnsJQSkAvUOejDRybEUZiQVlM0osT4AIj4yGqNXpbSPdK1ClfX9mvhRbNASkgLMWWjG7htGWMQK/8YDdw7ARYeT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(23010399003)(366016)(376014)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UkdY6BHqGwGseSG096Epv4SKsYuF3M+n0xWHNoZT4xEyYWnJTfo/PnA5bBPi?=
 =?us-ascii?Q?awlLAoCUSEDvw2YlxJmqEOZ5kdEjbIubJAT4mVdRjB2ZHbIuABbi+YF9hKjh?=
 =?us-ascii?Q?E41Z1/sT2Mpeddy0XyLTU7UV9j+LC7Y6TyyEocLZG0Jxnx3EGEIDs41JupS0?=
 =?us-ascii?Q?coro0FJYQLh41GWdRf0E/aG8u2K21wDFShPqjWJM4sfTwNtOt3mQ8xCmYmd3?=
 =?us-ascii?Q?tGZeyMH4whUBN87wwv8Giive6iPK9EDKOhJq0OqE+wUKLsJ7yaQ7NbFLbeEc?=
 =?us-ascii?Q?AoBEpHDh+kNbBHNpbsRj9amoXdFl5FAx2WrjmUw0LymL+dw8jCEvRh2N4ZhO?=
 =?us-ascii?Q?cGS7NvcVT+LaLHIgKn4xgVrNAbZ8Fr2aLYP6chaMhM2Xing+MRW/EnWTi2C1?=
 =?us-ascii?Q?8ANHAMl1Wnfks0EFZFlHnURDjJ6snE8FJBo1hJg66+hEmFF9g3nxkwUmnyrY?=
 =?us-ascii?Q?FsP6cyBFoIoMh760zyUMjgTJKqy4RAuKzRYmcG4WcB7QO8958kJEbs508Csy?=
 =?us-ascii?Q?gchF96XUguSuJNBdP2/Oo6pUxDOns+X3RE3EVfAXArndxcB6arICQenpp6dU?=
 =?us-ascii?Q?xCCD1w6kuvXSvo3fADmJNAnD0IuJQmVPf9uanWtHraa+hqBACYeGSn+jdEmJ?=
 =?us-ascii?Q?lf13tsGFwTWl+KdIOqz6X8li56pA2IQ85o1iJ+fid8SPkOXEJ+bMEGiKI1Mg?=
 =?us-ascii?Q?A8xRr53g6rBaaHQhbkH32C9+6S3VOPqOl1xpDspdGHh1wKl/GnJyAONojEhz?=
 =?us-ascii?Q?jQ41zAwl+Mn9OOyASBLG4B7QCvpKboGwJE0G8o44WQqj/zRMi5cvqV4rGwW/?=
 =?us-ascii?Q?iFK1me50bROrBQl3ZPGBHz5cD5UhiFQLsowzYhGQz3zP5zDGMEya71dTzmyx?=
 =?us-ascii?Q?h9kbe6wKZ9SRaqJ+GMGhEsMyaQid7vAOhZbaen9hHCvz/0QmWWkibjyDyPpF?=
 =?us-ascii?Q?xxZZetVtD3YMmaWZ0sTZ4Hj0J5Dqr1Bol6hAoX3tS7MCoR1OnVkBDkVSkbou?=
 =?us-ascii?Q?HYdZiZ7J69gR7K5c7E4BK1zDD0/4lVS42Zj9svkDAp9e9opv4a27BzvmgUSd?=
 =?us-ascii?Q?3R+Hrds9LISFk0qxCe9qpy7AQP6u3H1SVzt/jPqiTq5HebK+jDoN3nDuUxsV?=
 =?us-ascii?Q?5f63HPSZC+Nb4Rt0XGKxeUoosUjx1jMjv/6D5YSVSc86yY62MD9Oiw/iQCyz?=
 =?us-ascii?Q?1MGB2ylVIxgW454+jSpaIuzRD51DaYAAyGdkH9y1+z3YmGNtgxiw/9j9qt0+?=
 =?us-ascii?Q?keF8n2ewwoEYFYB2yH2Qay4cdjlJbj4vTcIe/4DxH19hING/VNTYP3zujasw?=
 =?us-ascii?Q?0SZ/Zo0GdURLKSDL8qtlL/gfElgjD5pdg+ULd+LYkfgwojIu4Bkd/+6b3r2J?=
 =?us-ascii?Q?MiVeAZztkAQ4QMfrzxK21E8KtNNrkf1qikUuJh2COsDRJxXLbNGcVrOaDYzz?=
 =?us-ascii?Q?OnrjBxs3w1hXFB+VVs/TWEBmytmTU4bQljeSLMHA6aRAEsi0tFeNyNoH0r20?=
 =?us-ascii?Q?rzGWqU8EdFdwpw4hdysORYCT/X2Ped/X2nVMR3TlCRr5yUN/IW+Xa6ZxPo0Q?=
 =?us-ascii?Q?PquDOC+fE08azcztFmNCouwrIzJ7fxLxS/LSCaNHWv3qZTQhL7/wGDCYntUa?=
 =?us-ascii?Q?J6nbPeY+u19Pv9Ha9W8A1Eg29u0nzcKTSAwBEur7IEjxqdjP+8xv+w0Pfb49?=
 =?us-ascii?Q?3b6w3/4eln+Cwsdapvoy7gV/cyjm5HNaCW0lTxFxeoE0RrGXf6ZqXcqtS6Vx?=
 =?us-ascii?Q?nm06+jDSKjebdmgqY+KTEdg3n3ux/szWocfQGAhtD2IUGaJq/kKA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b11ffa-8850-40df-def2-08df034ea10c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 08:47:15.9368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqKID9/tCjQNqlO9Jyp8zoFxMoqNHF07YvPtu7x6MAcP0/Bri4PtaUFnmSmamv1L+q112AgadO5UwwQiu8Gj4/W8atjDVU/faUxbu6GNIbQfnra4u2m6GOJIA1S+G9ko
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9076
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sun, Aug 23, 2026 at 09:47:26PM +0200, Jan Kiszka wrote:
>From: Jan Kiszka <jan.kiszka@siemens.com>
>
>Callers of find_mmc_device are generally processing and informing about
>errors already, e.g.
>
>=> mmc dev 2
>MMC Device 2 not found
>no mmc device at slot 2
>
>Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
