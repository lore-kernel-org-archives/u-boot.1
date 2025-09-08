Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21F1CAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 08:52:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A32280B9B;
	Thu, 18 Sep 2025 10:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bUNg44cX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EFEF82F14; Thu, 18 Sep 2025 10:52:44 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6419480107
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 10:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGEMgVxapDLpNWfkyEXSrOKQptSIw+rumPztS0bLLRN86R3U/2YyubDsoeWkdEKdCJgDbnrxrmR0aMm6/YYdLbP6RBVelJ4vB22CFZ93M9Xp7Wpg+YZhzKs3Nk8OyFim+uOVayLHATdeS629t3h15rxhxbSl7zpjsDz2Qo4NsIWeo0P45IEsdtCOeBptddu2MMz4vfziii0yunYxZ56vUhK9vw1h8HZFgCX7U18anF8UDaJo0kl9GHvMI/j3p79pWWI6TXq0r+o08hME2gPokgIT254jJF/CbnHhZkfi7mYab1FvSWNTRP6SFUdmEvFSxy9HxyQXNG6Y/R25Jt2R7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u32f8JD5mwKqylGG4qjFOKuLvjl/X49eRTQBzRrtURw=;
 b=Yo8+5zUXz/sFsejM5/4pSUUXjsDPk0RbZF5hE0uwrOVrCdE6wWMsRkSylaLzsRuw8uyenl9ckEwpkWIyBKpKjsU0+gDtLtzZAtzB/DRXrv32pWx9J7DRMlvT5w+7hBcYr4BfrzqjwSCQXlMrmmybv71D+3oDZJb5+XL8Nk5ST981FL2Pwe+jCqx4NaYBoAKIY9NBUF+5FkNJx5Ld1B7CckfeMtD+oNTbdVQLFYMDL1IKIRFocL+jSzPorjSb0vdHZ1TvJ/F2+mGTDuVdM5gXrO70+6zHz5vtUAbjenVDDKdFGcWIAQ1IPytK8Ga2L5+GeEYwiiUIajAXWvkmWmBxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u32f8JD5mwKqylGG4qjFOKuLvjl/X49eRTQBzRrtURw=;
 b=bUNg44cXgaq/5ZGsHrN+I9BBmbwy3a39hloTzo7CmjubBHrNB7J4wKI6JLmTD8jwBe8SheRiUCF+1sj68Dc+EzFXoSaKjxrqA5+AOF+neiNfhv/jt8LhL3uA7GGG1c/NmNz3umzqMBNhg2c6u859u9fDM/1WlTQpnPm43k+7N7UFBtscds8pTujJ6MVrx4i1cb0392xhTmR0TE5IsXVkY9bf8FQL71zEQQWe1MgPfcOfv/eU+ufAMv4ut7CsL5iZNvnR0APFCRJQL5AcsGVfeYkHZqgVMfTeIgMsnj4gFeIYYsHFJ5ttSqc2BdCINCkR67uiAARm9T980FI9zrqozQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DUZPR04MB9781.eurprd04.prod.outlook.com (2603:10a6:10:4e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Thu, 18 Sep
 2025 08:52:39 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 08:52:39 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de,
	ye.li@nxp.com,
	peng.fan@nxp.com
Subject: [PATCH v1] usb: ehci-mx6: Extend support to i.MX91, i.MX93, i.MX94,
 and i.MX95
Date: Tue,  9 Sep 2025 03:46:49 +0800
Message-ID: <20250908194649.3645232-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DUZPR04MB9781:EE_
X-MS-Office365-Filtering-Correlation-Id: f058bf75-4cf7-40d8-26ca-08ddf690b8d0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8TX8qNUcLQhesiMmKimIuYXuFDwJHEuOpVQWml/l4okTjtsG407uRfmJcyIE?=
 =?us-ascii?Q?6vhBWs7NAkP9M9GrSmjNmOGMpXqI+SvNqvZgkcU2P1b7v9wbd9jwibx2IP1v?=
 =?us-ascii?Q?g1AarwEKBXulE0fF9K45tMgBtkE7ycA843qSTPv+ORSP/yX/Xsjts25eDkwE?=
 =?us-ascii?Q?MB0cU4dQvnC1f0mBCVquuS4yUPcVYW06TiYtpCe6uTUlOD+s9AHFcUn/9Y5z?=
 =?us-ascii?Q?s90yqEDQK20yQgR2CDP/HzK36/lcZ0wd+uk4Gzr1WWSlVcpqsMVDUsjzKH/a?=
 =?us-ascii?Q?3pEg8NFljoNbDwfqCluu64LR8oK91AtlVc3DA6XRBa2+Y6Fx8bk2kJLigv0s?=
 =?us-ascii?Q?1fZuz8VKnjGzqXHv6/RoVSiZx1dVPybV3HzfPBwfDmU+3B1U73by2pJF932f?=
 =?us-ascii?Q?UYhfG9nPnFCUBhSJ3aweci5FdPPk+M7udnTSREqsjHwzUEerRVGM7XXWi8/m?=
 =?us-ascii?Q?ttHzrgg5WsXd5RMMA6yfpCsRTkr68JuVEKGubIsWCMvQssrLo48F4t9p8X+O?=
 =?us-ascii?Q?TUxZOT89vrzV2T/rAjjhbpI/jbTq+3YunCSbVhu5RYRIwwwN3L8OyDU5tuNz?=
 =?us-ascii?Q?rbLoHd00LQZEsd9t89ycoVMOU2FdJqJW36217yRQgvSwjVtUOto7l9d0WJ01?=
 =?us-ascii?Q?nniuox5WZCYxKl+aJGGEnR8YiA6b8qs4Qsr35pNCsUPKNjd6a68jD3NL99J+?=
 =?us-ascii?Q?bubwz9S0yhgEucZOWOgaa6Vj3VTCKm9SE6iSkvZcxDxIIISoX+dbO25gOp/t?=
 =?us-ascii?Q?LL9Km4338fw3uchWfJTwAmkJ1YBO7DbiqTii9KgrAPRCC4nD62is/TJst3Ck?=
 =?us-ascii?Q?a1UppncN2XjrgBPHlh4mROWvx5ZYmdVQ881gvuCFZqlODko4gq4foPAAiYdB?=
 =?us-ascii?Q?zUxmLaI3quI5RUZHdaam98S6N6W/EAX5bbfodBvX2tB+SWYkf1/nTRJ5KMSJ?=
 =?us-ascii?Q?HG8/8iJQSknV/tfpsC9cTumlr2YyI6O4sCv6P/Tv1XAYicVgiqJ0gT4Pctmc?=
 =?us-ascii?Q?SMSeVaIpWGb/Huhiwi3Csj4aEyjUzdKqgUTHsmCydsxc5qf6PWJWj/Ril8PJ?=
 =?us-ascii?Q?HyNhWYfYqk2U9S8IN3pumB+j5mt/T/SuVkMOVGvq9VqExM4/mzbDra8CNYJF?=
 =?us-ascii?Q?uXLDmjMmRCVM9B6QIpnWmXCDb+qY+lg2CBcgsLM79SkZGsABZzR12VbiHand?=
 =?us-ascii?Q?MYFQOlbg3DunyOA0gRNnxZjfqk/WcVFQkVbHPpXtAEbFgb7kSORDXfrPWKsP?=
 =?us-ascii?Q?bl0KwP3xkjp4iBL3SLkDFoG9/dCO4E4LVgODm9JN8D1RK5pV+/G96/b9xxmZ?=
 =?us-ascii?Q?Z+xXDQZWgUk+Npb/GdVpfPPWl+ybieE+vcqycgoW5M1tPuLJav8ZBdGT2nAq?=
 =?us-ascii?Q?h9ofpl35lLBitehIfPHu7xQCNamDwdtlIaMAIQIsnywvhE3uo1ZbRRiTk10a?=
 =?us-ascii?Q?5aOdKn6B5IOEamk9JsjpBI/IywSBluOweKhR5S7uvJY8cGwC9Wyemw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qsv8rive2YLDgUPoF9rgPhutvoqF85fdi9l9IE2ZTrmY360/F+owYoK+YTew?=
 =?us-ascii?Q?U/SVoWmUE/1iJ+ryzjbKxcbCuA7/4D3GpJqKZ/VhE5TDvwncOGCAseo3rbEg?=
 =?us-ascii?Q?1kd+flrDvUcVLmUzRmwXqogX2HsL8LwbLxdITiPggsTyz+qjiwZgRx6i18th?=
 =?us-ascii?Q?tWmvSdOgpG26S4SbHIXkZg7yjxxhYLNJDIuvd0b27QPgKENb3vTa8C2prBI1?=
 =?us-ascii?Q?fV4furhXit5RVE7cGBopudpCvu31df9PyPJUtIGqq1cr8/6/anI0b4b9kkNp?=
 =?us-ascii?Q?wjtt5886JQQ4eHZ3wgAU0i/VSY83dT5lTJ+zA7eXb996Plm586eSjVJjI2L/?=
 =?us-ascii?Q?oTe5/66BX3JVs+hkMO4KLzJIqECTchnE7xDepJzNv0YWGWlz41bxCGI74pf5?=
 =?us-ascii?Q?1gRrdOtVK9DaEofKjWtGs2qvR7kMDzM40C4CU1HIFdv6eFz0RNtaYQmQsSKt?=
 =?us-ascii?Q?lzPCnSjW1Y+X1i6EVCOSWf7afctrhaVE9TD0hGj2COJ9l+vJDel1+y+KYb8H?=
 =?us-ascii?Q?yfmhyaLm27qwL/LQV2ioel6rkzOZMrVp9/NkFHsCmFO4xy0CsvkMPxQmVMfW?=
 =?us-ascii?Q?Mnck0JyPxHupyoGGHq0rGqj/hP5NBBYn8m0nvrwS8AU7Fmdep/19awWBqstI?=
 =?us-ascii?Q?S/JryHFBcLoZlpDdMZ0qAnJQID2vcBcPI/gz+pfAbuj8dlVWAX7lo5OKphBg?=
 =?us-ascii?Q?paX5OJD9/RSJD1JYpGYICtVhCVBRtDG/T4m+2YMxUlSgCBvnSbCnOuwy4Gru?=
 =?us-ascii?Q?A1KkfJ3uyJENtW6Of05ZdVZjxAoU3caoXX3KDCfG3V9C556TkBv4FqU3v6Rn?=
 =?us-ascii?Q?/4kD7fXgQfh4O09ztH9ymqatY/f11I65ule7h1M6uFAPjJWiki7mB+JYasXf?=
 =?us-ascii?Q?YNfTJcRqSBiSAHJErycQhDS0fxSNe9iqzrx2Ss0eoB8g6utyIAZquROph0P8?=
 =?us-ascii?Q?lPNMfR/VPUGpkILn58v2ufktdivI1Fmtm9yWuIIdxjXmI7nt+035sqNIKAb8?=
 =?us-ascii?Q?c4BRZhbQzreUUgwxosuHU7pxHlHFmEexNkWjaQnV9QuJbb272vgLxEe7uRcm?=
 =?us-ascii?Q?4RikeYEbn3+c0KLiO82kbpz/U/nTDvM5ukcn8tCOg5onvdbqMP8EYJLG2jD0?=
 =?us-ascii?Q?LIY845ZJ+wJeG3dTOXQOJ+1nSoO8lR3aYq7FEuLRR79U3r7esJgNK5I6g+be?=
 =?us-ascii?Q?TcfDxVk19FqHvnRrdtMRTl8dsc8ADUShQL0T0NedNXTJoF7+7Yzosd2FtCNk?=
 =?us-ascii?Q?GImhp4Sz93M2OlJkcz+tC6wTcJhao72+fglIofDjRn6CpxTuibkxWG/sCqBv?=
 =?us-ascii?Q?8Ynlp4wwFKH76av9Yjg6VPNkFxtZWyarQ43Rxg02YOGmL0MH1GM5qfrxXkB1?=
 =?us-ascii?Q?UNPaFGojt78CSh8djPl8tzvkKtsC4ORb/0hXDddypRYJ7KUiCLey9KUKNDqi?=
 =?us-ascii?Q?im47ClmGovnxTRzUeBwz6iJKfqiWFlC6uxB0HltsSclDOInjh/y1ZOvKzGdG?=
 =?us-ascii?Q?cZWSsvEmwZJHjNwUpt+NgBFThszoxZnxvfZcga/UmrW64qjDKJSp7oIvxOXI?=
 =?us-ascii?Q?ijDzmDRVHSVluyngAAVkEqmMQUBZQPFXM4Fm9Cse?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f058bf75-4cf7-40d8-26ca-08ddf690b8d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:52:39.7579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6ZxwS5u3oC0b4ubWWwqnenFAw/c6BjO6ZZOgPHriFX1L9FgTTNR9SDxRu+e408qqEI6yugNl6SUzQfsW2YgoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9781
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

From: Alice Guo <alice.guo@nxp.com>

Since the EHCI USB driver is shared across i.MX91, i.MX93, i.MX94, and
i.MX95, the condition check is updated to use IMX9.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/usb/host/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 5c9e8fc9d15..16f210b1281 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -209,10 +209,10 @@ config USB_EHCI_MX6
 
 config USB_EHCI_MX7
 	bool "Support for i.MX7/i.MX8M/i.MX9 on-chip EHCI USB controller"
-	depends on ARCH_MX7 || IMX8M || IMX93 || IMX95
+	depends on ARCH_MX7 || IMX8M || IMX9
 	select EHCI_HCD_INIT_AFTER_RESET if ARCH_MX7
-	select PHY if IMX8M || IMX93 || IMX95
-	select NOP_PHY if IMX8M || IMX93 || IMX95
+	select PHY if IMX8M || IMX9
+	select NOP_PHY if IMX8M || IMX9
 	default y
 	---help---
 	  Enables support for the on-chip EHCI controller on i.MX7/i.MX8M/i.MX9 SoCs.
-- 
2.43.0

