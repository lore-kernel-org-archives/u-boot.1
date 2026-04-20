Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57252F5581D
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 11:40:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C846384324;
	Mon, 20 Apr 2026 13:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="npKgtN3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 258D48431E; Mon, 20 Apr 2026 13:40:55 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3718B84326
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 13:40:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuYwGdpK3xOac7b0G7EeQ+5UGNec+5VoSDRNOavedG/XkhgrrepPCj+maTLxDJILDkpH0KptxAUCzmh97BXqr18iIKubmNTvTXPxeTkxQfucFNVBKZ55+8UOA9GHzymgfkekE+oEyVKF40rzZko0ZlYsF7RVLbgHW+13x5BtMi6U53pj4hEozo7boDkDtLF8kcW0RsqaWYtbmDuvdwJF/Gwsja97u+2wdO8sEhnHWnCpg/8dJnhcWBLhEVe+mXbcfe+AjYYvuLsuaZ21BqJl3JDrwOB7HNfXa4lT1BNmqp1UvinaeGlKe0A27yjCFcgAA3zsAbpeybN24KK1SK52Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViBXpVHWo5ZRp1ZQkUDU7NgYy53Z9E3yCmS6WPXl9bM=;
 b=KUhwY9+Ko8mhm+Bkx7a09BW8b2PUKUMZBSsNh3OobrrDUtNoBCvNPZkoTK70M988nXUL8jJCrFURqhGtKU8TXNShMmIWO90fa6Mk9P+T6takmccbspnKu8oEbzpcM6m4nbME/15kGiC/gKNfyXj4Fs5PM84c9yrsYuSt6XaJivYV6UpGWNH6e6Wzn0bTHJgwDT8uBD+0/IXeh3FaiHz1QoT1YtCuXdChkOqPiP/suTwQyGokFUnV3zi34fFla4/z0kyhHC3rmiqR31sBGU+c/vJItmTLTcB9bbF1FvG8fZdr/zZe5q7uYAzWQ7oeggqG4/LIn2zvoewQ1AI9T58tHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViBXpVHWo5ZRp1ZQkUDU7NgYy53Z9E3yCmS6WPXl9bM=;
 b=npKgtN3i74X6IVeleQPch9/vOWWHf3EkZaJhXaqKhaueArW30y9isg3V+XuJZqlEngpC7eYfxHsyDZBWbPPg2sy4gVWqWHaAn8bUGx/V5KPsXsXd20CynL0DMTDPExdALziEe611/cb5vq3fWCiNNb4D7m59nvdHgbk/SSe7m/VoqZyq+Knlje5+c1paCqu6ex4Fw89J3KDw8wUfjqki/NJaCkomZnXHo9gluwq1rxDdIx8qfwkNCtcK4hQsR9Ytj+osk1ixTcmw4MhseCTnsqSu5Nh3iOD3ZiCHuvrzd96R2D8BUB1+fw3C/fH/XJ3IxmcZX8uTmCOBWHwSbOx9Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by VI0PR04MB10664.eurprd04.prod.outlook.com (2603:10a6:800:259::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 11:40:50 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 11:40:50 +0000
Date: Mon, 20 Apr 2026 20:57:21 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, ye.li@oss.nxp.com,
 uboot-imx@nxp.com
Subject: Re: [PATCH 2/4] arm: dts: fsl-ls1088a: Set dpmac nodes default to
 disabled
Message-ID: <aeYisbtH46SNwGds@nxa18884-linux.ap.freescale.net>
References: <20260417141437.1490591-1-ye.li@nxp.com>
 <20260417141437.1490591-2-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417141437.1490591-2-ye.li@nxp.com>
X-ClientProxiedBy: MA1P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::18) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|VI0PR04MB10664:EE_
X-MS-Office365-Filtering-Correlation-Id: c9033081-61da-434d-86f1-08de9ed1abcc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NtDakZbFl5qOD9B7AQcM6wkmm/Tg2FCt39G3EX1vKzGM+KikZJDzm9PQpWVy3KZb0kzE8Fr8cNCNTvARANc2zN7QbXLklkbuQ2WK+pkZxZ2t6GUazgzUtb+2AkJb4WiY0tEvK8auxjbmdnz2TZN/P7q3ptfxIZFtbb0azVkovf7pxGPKz92T7C6byaMoqfkNTQ/dBEpvpix0jlPGsUf1JAdKv3S+Z4EJYCmh2gdfg+SE2Y/Fz38eEAmvDD8jW6MVkpQSChWQjYEuWUPfCS7vHN8qbTnwo6+S8OJUHvtItqsacFlL6k/uij3nG6auzCb6sNlJAqzioDR3hXpWpUII5ByIjrPxuZvkhFt/FkzTWXb0HudArPdeaiX82DemO3jPaKc2EhW2bEG3h2hu2QsMYT4OfWoE3/tbCL5fpULIRimKwu2OCnbi7+wHP1VdpLgHw6ozIyCi4iqTfPOvq4tTk5ci25S+8vqqL2FYTbBhdkrlbQTYIHVck+lSuJTHErWoqszMdMW1RQLfQtxPszoLzlLti7vOKJV9vnViyutXE7g2vFeBqQCVdd+inKg6a47xndfe7EDBM1HObhgyoQmpFRZx7zU5Vk7p8S2dEiyhtrohQGV7sMLrid8NVKtPikOSzjIoHJ6squKQRm5qFADYDWrpKhyA0NYmQBJBWac5H7sr7e6RJDxobgRduMwfH2EyGw6SN8Icpc5t5o/ZWtD8a9OSbZFwwa4N0jdIoPg13FNZMeAfbVWhWphn0tXm+bn+SYFyl1ckM5SPsZyS9Y0/rNaiCyRrMlBA4F3zNImxErQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ld+RtQfRA6GvJk/d5sUI7nOQrc3mqMWFg0nRrVIaCj4548/sHK66VB+UW5UH?=
 =?us-ascii?Q?FPzzSTqeOwj9NnhZ/VpgiqLhfY5nGPcbevyUzzXImUdnVd5LhWN5RDGgXWGk?=
 =?us-ascii?Q?0N7AMO7GTvSyOz1Nzi8Z64ij9vvIKRejp984XZqp6px9xPYTAwtrRatCtzxN?=
 =?us-ascii?Q?yNxJDOWVkFX5yt2QSqZpfoqtoqBQiIoWQhfKBXIiup/YYWrI9WGGnVCBoTQ4?=
 =?us-ascii?Q?jV+j3Y0drrQld6LsrDNzSGSvJdqZUVWkb4oIawGzD0FoocEtgGMaATffIO/Q?=
 =?us-ascii?Q?QM1bqY88H3GUaOWI/npAOdk3mS6cnxYIzHABUss9hZqGY/6uju+mP+JkyNBr?=
 =?us-ascii?Q?lGcKUn17vTBhdjenBv9M3UVMBtSSBLrxEt+CcaIuPI+nqIllK47wED4WHh3P?=
 =?us-ascii?Q?8JlbZDwfgy4+Bm/8NDEBOllqKWOdDBjG7utkENtphumdGjveOLkuErjSiwmQ?=
 =?us-ascii?Q?3hOsToup/BzkuC09TnoydqsQo+evs4Uz+uJDA76ZCD9PikD/aQ9N1q/wM7bO?=
 =?us-ascii?Q?6etBN+2bKqKDglH7MCkwpQPclym3JbvYekqpD3UbEjJP65Ai5B9ni90zjU52?=
 =?us-ascii?Q?Wm6yeEbtdH2uioX3NE3nQ5qLX/TLHDi7nn8bqLJnBuDXNobVfFLI2yKxhF88?=
 =?us-ascii?Q?nXWsF6u8O6SrR2Dga5JCMHBV0ySHCqLkpjiRipNOdiL5XtNn+Nsl1FTWUtIO?=
 =?us-ascii?Q?Uo4BId8vPaFTAjebv5ilUW0Deby8tMP+IS1f7HfJrt4uxGpwBl+V5QkbXtSi?=
 =?us-ascii?Q?clF4vRPMAweJr1HXhLhKg2mmqWW2IOYo6zsVqF2196BJUONMZl6cgkzhDSva?=
 =?us-ascii?Q?uJGnalV+otjoIQVLFYNOyV7iEyQ8AIawbcXHPEpzHyz1E8FgVHIic9qGyP/0?=
 =?us-ascii?Q?IJjUOryYEyRaf2mspsCBJVsyXDJpXYU65xu6AHjaE3OeweV9fHyZlFru4ry4?=
 =?us-ascii?Q?7hDr9sRYTMG5Q8ap/ZmFzlI+Z8WJSbVbAjcAHFpG8UvyuV0xj8DG6FOxpfL5?=
 =?us-ascii?Q?X9S6X1NnhSwhuoVubp8XIxPdRVNZ3YfVJYu/buHQ3ONa8WSznbwMHXzrt5qC?=
 =?us-ascii?Q?QkWJF5zeGgE5GTVvk7nK4Zyox48XAQRpYhNU/aw5hhLaYqF27IsP1AHeZ3xc?=
 =?us-ascii?Q?7rund24AxcBGTFkoUQHdOHHr6cjBC7jzclB2zyIMOY/7RB1A7GanOYUnooHI?=
 =?us-ascii?Q?cc8CSTFoQXbSF4hC3pYLU1fT2/np/ge2xpjs1kaL4mCKAv6uGnR1rvKVZwLJ?=
 =?us-ascii?Q?L0ABPNDzp2ycAAnMYB40iFEixB/truURohRxCHm0VVx6K08eaNNzZz8955xB?=
 =?us-ascii?Q?L8XCjBUV8B0QLaa3x0yuCTgKoazxnhQ+l27bPA64WrGu2Rg8/NZnAz/uQWQs?=
 =?us-ascii?Q?IdaDvsKzrWR6P2ovB8rzgAfS3uBAG1yhLm/Hv78TGrmRzmkNp/tayOAaNozL?=
 =?us-ascii?Q?XBi0e6VA4bwkWMBTxE2ILkzbXChdJNKoq2mJcZ6Ggvctk+9hIB7FeqYSeYli?=
 =?us-ascii?Q?7Q8DIP7vxxs0xjqUAUMrHzeKjwYKs6F0CBIc29Di+upjZF+TDFvAIGXW/nAx?=
 =?us-ascii?Q?CiMPDrJNWlfDBRivKnuQl50iMIsaylRvdMezb618y8BK2pL0YRPzs+qypFXv?=
 =?us-ascii?Q?HeNQl1H9WBudVZPiCQ7ilVmk1W/4WPeWYtIBEDD79IevnpU1Djy57LOjwRCn?=
 =?us-ascii?Q?YAld2rmXXwBzeQeJARyBnMjupfJm0vJ1f2FJBR8ypdCON7uT0nzbm6HagcZz?=
 =?us-ascii?Q?Z7qrIEZLTw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9033081-61da-434d-86f1-08de9ed1abcc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 11:40:50.5130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBxkWclm6fG+qXPyCnb4E1YPPChZGbhm0a1TBmVKH7u6w6oGdaD/T1wLZgkNLZqdjlf5CbkMqQmLwUJJiFGkJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10664
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

On Fri, Apr 17, 2026 at 10:14:37PM +0800, Ye Li wrote:
>Disable ethernet controller dpmac nodes in fsl-ls1088a.dtsi. Board
>dts is responsible to enable them. Otherwise will meet failure from
>ldpaa_eth driver on LS1088AQDS board, because only few dpmac
>controllers can be enabled on this board.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>
>Tested-by: Wei Lu <w.lu@nxp.com>

A better place to do this change would be x-u-boot.dtsi, but since
this board is still not using OF_UPSTREAM, it is fine for now.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
