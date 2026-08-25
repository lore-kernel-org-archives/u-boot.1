Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42165C61DB6
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 07:53:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9BDE60618;
	Tue, 25 Aug 2026 07:53:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qJxKW8XiKjyw; Tue, 25 Aug 2026 07:53:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787644398;
	bh=RoG3SFlSHUiP2HXwqjLcrVarAuAtsAtbTnjNHVI6kuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ak5Y2kK+wWBuuAJq3pDy/jWx8jFuRfz8GPrxY+ZUnfza3vw4rbKlGhsQx4WaUYuxv
	 PtGYyJVmhKMQsArcI6G3O1g/t669DwJeW/QzgokWVRcgzDgtzQDwR893E12NoLSV1q
	 L2ytZicsPG+AC3Gl6FsxXVXnkhuYfA2rRINKyp3KDZcUW48iXuWYbr61Wi0PtYkKup
	 lIJhiOfbZZb+h8nFdnDHkX0S6ICzNIAPdhLbHCdYgnonh0KrJY0dlAUAhQhCpQtePv
	 BGXC3gwhbJJeAWS3We+kbhcZOL1IfPTugF3Qfn8mkH+hXtKF+lqhNjVt3zlm5g9QQ1
	 nvuzf7kxGzaNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE5B76068D;
	Tue, 25 Aug 2026 07:53:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AD548336
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:53:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AAE1640068
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:53:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uxc6Z_a1BJYm for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 07:53:15 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Numd9ryf
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9433F40064
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:53:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjxt/qMXIQc2VEvSzvgjWM1J5Ydavo9g9eSvQzh94piLAkM56rm1miJrW/fSY3VG7O8p31E4u51xvbUQJUdnZcr/3K0pntIj1ITLtSlwvfBvdngGG1MWMbkY0k0L3H+WuvDqwfmn4n4WNelD48Fp13UrAUruBuu2EkqIjGitTFXu6FG2ZSa09ubs11veaCOFUPx/QbNyzgaY1dE/YGmxrA2ufMMff0XABuGbtQYSVMtkOtGsVhdBb9GSuNtL/17XEjvBAq9Jr5/5Izn/Eedtrox3Hcbrfmy+OocYWwQG9tj1Y0zRxudA3Ip/nOUlbtdjVwkz89auxmJj3MkJKM6S0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoG3SFlSHUiP2HXwqjLcrVarAuAtsAtbTnjNHVI6kuQ=;
 b=j5jbZ2/q4/IIuPIy/VnrYB1z05wUsHEVI3J2HCImB/NWu7+956+3Bu7Uv0bmylMOfH4N9yG6NqWh2AfZapbf/0sAYDJiL6SXLR7OEHLOdcoB916F8hwaqteNRBcbicN69lkbJWI1NzGVWaBsvxQK/xdmZ4mkUXTJ+ogvE/fesfw7yb15qC99MDfMyjz56Zy6sOmtE0zdc+nobq5wvl3vI7WI3iMdxTIMZE4IEXswt7LL+BiQk2QVOnL+fx0O/T7aCFyX/haZ1841nToBojiIDhtzoYa0amPyiu5Utr3lDAbdbmXVzOZe3v5UbG6tJrLxmcTE9HOyXdPs2d3/1XMBHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoG3SFlSHUiP2HXwqjLcrVarAuAtsAtbTnjNHVI6kuQ=;
 b=Numd9ryfYIEFpTGVW392KTN8v9y2NEYWBxYwUTKo/qRF7HfTq8UrIIrrflDntabF72X4ftNUOI8adQO1OTlOT27ZvxpAzaF/eKAAB8j5EzKGcHZF/CRv1EEnw8O6yR8OUTGGA9bsXwT79TAKwTXGJfDGUVx+HSSlX2qPCW2KN895umAYy/3LtCFFnIP38qjgM/9NXEI+TpXUDVMxrDDf9T4Iv9g0wH2igOO/wtwnlEj1sC0FE31FC+KrMI05OZPoMApo+hWTSgWgih9n5O0vXJhEt6Q96OBTYqD/SlznPx6uInNblfek9zDgDsazjd1mWq7MuizuE+AblRYW3SRbsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM0PR04MB11929.eurprd04.prod.outlook.com (2603:10a6:20b:6fc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 07:53:09 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 07:53:09 +0000
Date: Tue, 25 Aug 2026 15:50:47 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] MAINTAINERS: mmc: Add myself as a reviewer
Message-ID: <ao1JVxbw4JepNuRh@nxa18884-linux-1.ap.freescale.net>
References: <20260823102633.13128-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823102633.13128-1-tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM0PR04MB11929:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f154281-eec5-444e-9668-08df027de79f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|19092799006|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 0LkOsLBgoH1C05haDuZ7/byOGcgaWuDsErTQ/kd/N2LiWU3jVIVMV7DAZPc7iFReFe1fxG9hE4Z//YegYsXTKeto7/6zaQf3Jmx1ZlyXsDGxTAmjoOKNqutwHNuWYkxirYHI2b1hYU3DfnTBORBfgh+Bm4So+YwXDGbDlgJAKa86ptvlqWdBy6KrMDupMLQ1PfhU32pYiD0RfCN35PJIZal7nmpG1gDO+OHEJgvHeiRej+8WeNt+c9hKiCjc9KqAZoCLSPhIf9gPm+ixOr1i0OKhXVhZobnWjti9v2S8PdP0YoQEA/n0cb4o3wIslyDbmWNKN4ghL9BmH4RxDK/VSAgIvXwOFqHNt5+pag2JK3RIFZBdstSFogoERA3iQBs8W3fkK2v/dZDkMg8N1kcGwhcoHeWMa/PveEzC2L46Ti++rCUmrrxsVaprmjxkTUL51c21C8edOmqkNJ6Xc0AFOLAH9sRZn5uEj+FPEIdSSwWO6jF4TdWgR55yTyMSgkJpvS/XIfswe7vshEAlWIqwxD0sg8lYJ6RUwwNoGxmCb1ulU2gsegtnOHNRU508yH6gxqgpCYbzASKh9e4k3RMN5P+gahssHAGph95zOudAUXjII1sxXjpWvCRUVRssoF0K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(19092799006)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QUEOxsVjH5lA7NudqNa+Z/NT3Gyd3thJ5lQ+43T6PFqzPFYoBwXVB+BznfbN?=
 =?us-ascii?Q?B/DkW5SuITam1KiaiQLjdtuaafyjIDTFfFGdMqUrYzZz72+2phlnpUaqAld0?=
 =?us-ascii?Q?1PL+wQZj4LGzaykkVZaPCCXH1G8M+swrCz56jJHXSa3a0aAsdDxv123Zoj6t?=
 =?us-ascii?Q?KjtHQkPfdOpiEXDKrmMhHSthexY9MmpZ/C9smfI8eMU+PLrbnNULmhYXIglE?=
 =?us-ascii?Q?HMG3gj1ufe5Hpjv/+EVbFhRln+WW1CoavnD1Iv4+FUcGHvTA8zfuLjzKhVln?=
 =?us-ascii?Q?gMaKv3bUqCurk7N6q5d9fhsZzZjHKQ6+FUKx2QkER9loueeAIDuN711/9nPm?=
 =?us-ascii?Q?FoT8LcOwlFg+sFYHozDhKJlj63yiHf/8mNO1YbK4xLrZV1HUn9UMWbMknlV9?=
 =?us-ascii?Q?UIIYqTO/sPMPr5RyPfgBjFfZ0wlzGYOs/IT11qcAHMNrOyRQvzd3Iij5BYwW?=
 =?us-ascii?Q?cj6LbFyAS4ecuTci9F3Rt3N9/lDrMt8zKtfrrZ4lAADourbv1AzMNaAt2CQo?=
 =?us-ascii?Q?MiQDJUKTiHRCTiJvILfTLEW6Ruu+qeYl73Mu51vc9bLFR3wONagPIXFOq7Pn?=
 =?us-ascii?Q?MY+WzOAbfp0LbPF7bX2RqOk7vXgEZ1mzdJh7mwnXxWtZeiWB4c3rBpS5X2i/?=
 =?us-ascii?Q?/eaMR4RN6IaqEj7F8Tk+bIl4VJmEEqywMMgq2AJ7+Ylt06sdYdxYvvtylgsS?=
 =?us-ascii?Q?ckkdF3GVYSbUMy5aib7IbjWN6jfxtOcsV6KB76L8vJLW8hmH2olPiDMkkZxP?=
 =?us-ascii?Q?p/UNSQwwjacmFaozfiLnHfCkETXLttGS2E6DQx50CE9NAIDFpOFtzQNZxVkh?=
 =?us-ascii?Q?uVVdS5beb/z+wPWc91RDnBVmmb8IjjEidC1SFzdzBuUUhwfy/VL+faoEbGn5?=
 =?us-ascii?Q?4b7BjQAKjNl8NKlSpOr18DNFFefAvK9zNHtYRKcZ+eaTdrFEBA8eQDzbfS59?=
 =?us-ascii?Q?nb+FisfzI9QmfHuQaJJZ1ZMNqPPXthuA0mSXn613yltVyhW9n8nBUG4Rb4Ry?=
 =?us-ascii?Q?LPPl0Ouhr8lhrU85nyUt2qoMHXeY6VR/55ZyvyR2DghSeVpaNU25UaSun+7s?=
 =?us-ascii?Q?jlz5DLsaUWx5V6ngcyPc79DdCWBZ042C81xdS9B2ZxVyVpu+AxO3xVSrFhc5?=
 =?us-ascii?Q?t6jMLzVcswsWoz//Zmr9UBsv+IKJccJ4JQfJciu9j6VqgVyUPxrT5HOhEo4F?=
 =?us-ascii?Q?SWnI9O5PdHnHp9FRuv0qefjkcwG7GdOOaJDp/tDFbrj+dHFuY8LcNcjqwS6m?=
 =?us-ascii?Q?poceO52rQs/f4z5PIM2NDTyaCBxAVI4xnUaas76Taoe9QhsDPAKYtqWr2Vi6?=
 =?us-ascii?Q?vHtb7a47qsKLueiQEQOeTs+9VhADVw8+5uL1Fwvn/0PLu9GczIZ8VXZDHVKf?=
 =?us-ascii?Q?jSVUTynp0N25h8fJkc2O0t8UDu4Bl6A5862MPyL3+zckk0VRf6rIPrVQdLdu?=
 =?us-ascii?Q?t5Z2S5oVnzf19pDjXdO90lf5jJEXhh+AQnJt6A8+vEb7sLJigoZFDNBahrEZ?=
 =?us-ascii?Q?cT07uOh2xO9CeBpBCHj3O3/PaxQohahtozsrgTzkmRmA85ECLnneINovxC3m?=
 =?us-ascii?Q?IGn7/Dcfr1xIayYmm1Hen/ycl3hNWQ7FwselojzaoAnjQMwCnE9DBcl0uMiU?=
 =?us-ascii?Q?eXasuuNIKTWHReodVvLEnrOL/xMos1CdOYobETH+lCc3hHXvNEuw8itR8iea?=
 =?us-ascii?Q?uPvGwJ9otNQr4M9FPMLTJj/kaEAk4yPi0lMw+a5EAAZtjZCsa9Vtthu31RbP?=
 =?us-ascii?Q?hf0fEHvjQwplNZ4gXU/cWZkE4bcATouXpQfVP6h03miJUafncP32?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f154281-eec5-444e-9668-08df027de79f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 07:53:09.2423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtCuLPpyoNZNlFdxQO6FsmS9Nv1l4iCg5CEFK4OyRdfOI8U3x22lwRyLt2l8HqtZoQFEwbhWphofKPNg4arUN1BDAlypKeXsL+PJgbPSjl79bb1OP49sTeYYVzxGQw5j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11929
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

On Sun, Aug 23, 2026 at 03:26:33AM -0700, Tanmay Kathpalia wrote:
>I have been reviewing MMC subsystem patches for the last six months.
>Add myself as a designated reviewer so that I am CC'd on related
>contributions and bug reports, and so I can help improve the subsystem.
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>---
> MAINTAINERS | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index eb48eea55c5..3b6f5f601ba 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -1378,6 +1378,7 @@ F:	arch/mips/dts/mrvl,cn73xx.dtsi
> MMC
> M:	Peng Fan <peng.fan@nxp.com>
> M:	Jaehoon Chung <jh80.chung@samsung.com>
>+R:	Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> S:	Maintained
> T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-mmc.git
> F:	drivers/mmc/

Thanks.

Acked-by: Peng Fan <peng.fan@nxp.com>

>-- 
>2.43.7
>
>
