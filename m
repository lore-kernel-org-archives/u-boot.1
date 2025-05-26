Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79560C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 07:10:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 014B082B2F;
	Mon, 26 May 2025 09:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KuDaXZDF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B16182CA2; Mon, 26 May 2025 09:09:59 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D50D82B2F
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kC+B6F9MIu3FveDCIe83cDdLKDCsrFjnThrCN1UTjweug0AFEOjNkCJ/oLmjMqGhIjfFIVetqIMIkVpt3HMYyY18wsMF3sJaNDtQmIjqR0PbZhwBmcY8KY4OpC1vCarTXY77UFZ96g+q+PT+4/3aSOjS5api+bNxzJbIPqtfoCRdN79rj5T411vdl+8uo1nlcRXBqrgaSnfS0AKDrQ5O0BV3NkT3FQeXcvFgc2GikQKj39SsgINoZGreso2jcQkYd4VtdtyJDI5S3M4MgQJgvhuaNb+pgWDSfyVCxq9e4vYh7TF0K+mj/N6Jz65UwgmGO2utWfKDvzGcCiTUB7A3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ln31Cff2MdaFKmQvHAHRG2DymobhfgRzvhwoN8J4wA=;
 b=mEwhDh3xqd3Yloycv7idI4LtAESvAMTyi67Ms4qxHL0LRTVqfRDkPAz1VMuZaylq6l+dd9y8F51KMoS70oL8jkwYPf/osqxoFfmzjCGrssDdVjjumdlR/Iop7iae1Q4qhu+8yBTC7x4IldpQOMrz0Tz5N+dml3lzQs04WxK96jpYs3qKO4hkbsCL/C+nQuMQyD5bawtoYJEm9VaGJqz91BKElK4MjtT6p9oyxdnTKhkI/dg+j3zPUbAKSGVsw7XKNt/ayuvt6GgeWJ3VJ4Xlgqf/zH8OS53jhqMF2mlC7rhUp4cxP6vvtSmdst+jsr0X8o4VfjkWPt/uNCruMjAgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ln31Cff2MdaFKmQvHAHRG2DymobhfgRzvhwoN8J4wA=;
 b=KuDaXZDFcrOdrLYx/WEc03sb8/qG8EtwLtaV1NjyGKueFV8Oh6caMBOLAdtPJK0mQKtGcBTChbfHrAgDBAY8f5+OBzhzyVaka/F7Ey8FHUTVFzxZzfBo6yuPgWcUZRTkv27RhOXU8bHkrm8QAAwaquThXlT3uG5NIrj0wSc6q/Fp2vUuB3txcm7c1SGct5zt1fIo49NpgQDHoxlCICTFGaQdrtjWh0Qt+i6ijPL0K646vi4ThdqndgLIRTLp4+dFZAb6XK/wUDqMdogQopdlBAC4EjXulVm43G2TuUBaloIe5XcQntcnOfYTNQTtZNCaqsGTwmD+idS9cRjGNDZTNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9934.eurprd04.prod.outlook.com (2603:10a6:102:380::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Mon, 26 May
 2025 07:09:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 07:09:55 +0000
Date: Mon, 26 May 2025 16:19:40 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH 08/13] board: venice: flip logic for GSC supervisor enable
Message-ID: <20250526081940.GH19264@nxa18884-linux>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
 <20250523172018.4164647-8-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523172018.4164647-8-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9934:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b2b1827-07cd-478e-b1eb-08dd9c245134
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5OLf25KxghRgCZKbRV09MEtFEK0EzL57wMT9Y5WFUiYLvpi0cV55/WFtzJ5s?=
 =?us-ascii?Q?Ls/H6zhEE6jsoWiTDWLZivuNjsrOhEUxkeOclwqMSBnxtyMzXsUtZgED8cZu?=
 =?us-ascii?Q?Xj6DAFuhUV4uoZqFxQO3tvkh97OsNgIhbR6O38z4NXALEiTZ9v60ne03oTtr?=
 =?us-ascii?Q?WP3ukIPinCLpNGYCIOGvgxSsfL36LpPOHGTUwl7VkoT0P/dUTCMWz0urWuj3?=
 =?us-ascii?Q?TTSJ0DsRTNhazGc7B+5hXGQ52AIp+065a8w8x038FCjhFUdBCWuxpiYw3G8H?=
 =?us-ascii?Q?Ll0s5gVyeog5jXjB3271WFvpZlTSCK9LqiZ9YhDYIsS7+kWq0MtNAyWEp0Ec?=
 =?us-ascii?Q?sPrGHmtvTnjHRskFeThcxWo3MF6jTopUSFHtb7qd32Szn4aWBDEgtuxlE8Za?=
 =?us-ascii?Q?hYjOzeNyK9dc2L1F6jztdvc3cXxRwI5MaPwd6UTOvmU33EWrqpNEnLN9ygbr?=
 =?us-ascii?Q?cW9AfPCcwgA0EBUA1bmxjtzL8pus5Mj8IhiTXzsILj9v3vTqthG8Pyv6Iy5l?=
 =?us-ascii?Q?cbgKvO66ad34842gxyn3SRhyP5jMJrh8edZZ8cMRijhrBUNxUp19qnJhb6tz?=
 =?us-ascii?Q?lGEyJXKzi8Ep7N+Nh2ppxoifJ0v9wQwI5uesE12Y771glMnS+BueaqixwxwL?=
 =?us-ascii?Q?E6RGA20O/dMB3EmlgUZ3AMQDA/djqBdhugYepckGHmRjXKkK0ewnQSB5B04Z?=
 =?us-ascii?Q?1rrFVH6OeHg0qgVPkQm0Myi63IFsQuu0g5zH38ukDE/300fm8VxOsPUAPkF8?=
 =?us-ascii?Q?/RHMNDP4fgXKN1q3JJV9gffxoak7imcWY1DzX+vtAQsNYHXlMkOWVzvPjqVU?=
 =?us-ascii?Q?PPDb1lcMC1OvZ5JhUre6Vsiae1DaZaXAXL6kL6acFzeGPLPFApnNv95cf7Wi?=
 =?us-ascii?Q?kZFCzT4XicqfDG+eL0S5RsgC/6ztSMod8kN7W69M59HvpT7tG2Me9vi32fTG?=
 =?us-ascii?Q?g3ljjJQquE24+wULWWWhHoSqVlOYihC2Od6Ll+w4wRamsTJRG0cNE8gBv3tH?=
 =?us-ascii?Q?67I+5O+b4VfKYWpw8NIaj6u+Cx8wMpuBPmQx5RLTDQhJJGeAFOVmNlU74N2Z?=
 =?us-ascii?Q?RZx6E1E27s/j1i1WG+gGMoZjZrc2FPH+SlVUjmGncuxndqAeJQYmJeb9CwcO?=
 =?us-ascii?Q?bxK5IzE4ExIG2WKKXplOV9+b99wvz4j2GkEpEGaCGh28wG21qgoGlQZYaEvi?=
 =?us-ascii?Q?io7dxGyxc0/3Ev9S7rN2nZc4heQLveApCuAYLJ+Iag5ZjUR9yE4ZkhcgDYj9?=
 =?us-ascii?Q?GKPDdWKIjoDRlu7Wl5pe+cmmgy2binZ+Ky43gD6ep2a8Rx74DT754mkZQceI?=
 =?us-ascii?Q?E8ntaO5uDc927pwSRaZvAZj8IqmhqT2L+zszM/wrgRe7sYIEKJ3s/AKbEoVY?=
 =?us-ascii?Q?JXBqGtKPsgqvRylijGPaLZ95+NH/VP947x/xi0ruqSC90OtZwUFjNIY4j38x?=
 =?us-ascii?Q?U6IwYuFXqV7Yo31377uk7R55pLZrb1XXP8eNFH05qf0jSXwZUEuMHw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gnUgENcCwjq7W2u5r24wRHDuYl2CBlcQkgjv7vIB0LAmtEBucWFcZuoB6rbt?=
 =?us-ascii?Q?XLCj2zzKK7V7FAsBzl2qrldYGVeE63Kqkh8ay/kb0FxRaFFcn4aH8WuCcdx8?=
 =?us-ascii?Q?eyZMgbWRp/q1KDHc8JNcZLbEAOkgORLYvu8LSUVOgZLoZJ4tYSeygLXtjDTN?=
 =?us-ascii?Q?/33p3BlbFYouPQq2SMFAZ9ywaDfjquxcfxdPZBsuiVjfGze4o9tu7UnHAQJG?=
 =?us-ascii?Q?AQzkK+qvNOTnNAO+3yHh81gqZWEgszM40zBttIDhp52sdUPikIJFGPCpoyQV?=
 =?us-ascii?Q?x47hBwvqNESm+tvscRrusSyjU5GrN1DlJirch1a6q3Wx72zjk12QvS467faK?=
 =?us-ascii?Q?zHF6/ihD7jzz4+A5epNZBB0XjTV7Q0pMh9fJyx40IoyMD9p68G8UyPQ838XT?=
 =?us-ascii?Q?QA8EHLm+mN5+zZ/N+mrnz7PGeNOi5401P/XB8GN3Yy9VhP7OmG5y3Z5mJw5V?=
 =?us-ascii?Q?jkSZPCzGclvHWScgmmpHGngHe1uMg1Z1PbWn0v4R3B73AI0456+f27Wza6H3?=
 =?us-ascii?Q?F6tPFsKjeqW1kjmxKWNSy2zgwhI4faW4VfELVjobRgjoEnQz9aJTDOkLzOzj?=
 =?us-ascii?Q?zkPuoJ15L4ZWvMmmLcsA03XqdnG7igMFvv+UQzY+0Qtjo0ajRG/NqUgM8Dqp?=
 =?us-ascii?Q?Lfqr9XninnjHz96a1VZRxIurVfle0FbeRxZVkg9Ezbsg8JWG6RpfOtwqNull?=
 =?us-ascii?Q?DVneqmP1DpWyd96XZvTJP0E1QuAo9QhiLoOnyEpzHC8eu7tXofJm0xqs1ZRt?=
 =?us-ascii?Q?rOuG+aKTG1Yjdfqg0mhZcosM8AebRGac5WlHL38D0ImuA16xQYAmuwtJgkpz?=
 =?us-ascii?Q?aQrGjWD06Bqne0CD4FjgP3lfM23U5uyEQaSK8I+52aW/XT/6RPnZHkzr1B+o?=
 =?us-ascii?Q?ndGvSFpt7yP0POkaIpPZ1biHDEt55e0LxPpqg5NodFacblLo1xFjSqZm08Sy?=
 =?us-ascii?Q?peiZqfpaDoj7h1BPEfiqsjbTEETcXge6Q91N6AVnxRKlk1ioDwdONOy+kWw4?=
 =?us-ascii?Q?XiSxEhk/3Ghjt4lYCn+uhA89zBvQVWL/5HS3hYdVTgrYPdpkCyJ+jTKUMH1z?=
 =?us-ascii?Q?6IJxzDOEmmJHa+cuMRdajfSrOaTOB425bDxpNeAuV+62gOBlJ4ziTMr/aymU?=
 =?us-ascii?Q?mXecLy9aD/7YTS82dLlk+66VtZtUQT4ngrDEw8yoFOoTReBN+rRNPT/EoGbn?=
 =?us-ascii?Q?3K86sl1NXLszeNzXFh3dIqy2t740j/vflMxfwcfdkrwdNwnJ3nAhTxJqihdx?=
 =?us-ascii?Q?7/w3v8gPLFJjQ6feUZATZpQDbmbpBGqQx578taUNejuxrjUYAWLEt+MjFac/?=
 =?us-ascii?Q?3JPlPHoQYcTgRdLte5a1qmVy92ZLdISrbb8wVRqroWL8MppqGNkS4uOh4ilW?=
 =?us-ascii?Q?x5zgkBBeUGI2uW8xOFwF3VyhIb2N5LWA9TwRk6jA6RX3d5zm1vCcvl8XUoJH?=
 =?us-ascii?Q?8rfF5MJPK6UgcbrG3XzCouOn5mwA2PPHFZDn7NkrmGwLHGQyug6GkcmooIXu?=
 =?us-ascii?Q?3ISRPUr4SVHTtUtmgkmU455FeQ/1lu1nhMfYqbaTH28l85DQkbODaXppSTSH?=
 =?us-ascii?Q?ycTO6YlqroSodTM5EVlRBJq4wrZ3vCtgGoCmY2u+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2b1827-07cd-478e-b1eb-08dd9c245134
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 07:09:55.3715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYbuXSOw151I6IlahAHZwi4ip8BI4Z9kOT/cs4VS17EYBq+kb4lkjyywY3KEp3BpN1cwM3z8m9QBBirwn/yEhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9934
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

On Fri, May 23, 2025 at 10:20:13AM -0700, Tim Harvey wrote:
>Flip the logic used to determine if a board has the proper hardware to
>support enabling the GSC voltage supervisor so that we do not need to
>keep adding new models to the list.
>
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
