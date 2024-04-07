Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E34CD11C2
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 13:03:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80AED87E52;
	Sun,  7 Apr 2024 15:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="CFngc8oG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3380E8802E; Sun,  7 Apr 2024 10:57:17 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E891B87E3D
 for <u-boot@lists.denx.de>; Sun,  7 Apr 2024 10:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=joy.zou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kt3muVr7/Hc3qH6tlM8EUpi9N4q+Pyr6u47e/57B1IYoJANRF91wdNzOFM9QrIRyaI2WQ5+yQYzpYkB/O2+AeUWeBeQDjeoAYQo73J2f1hKV3z68ufFMl6PbuGxq8JjBOYwLlt8ZoUkzHxwLqkSwa68o1WL22/smVplVBlINAcUPUkNNMy+29xNG4ILqyBRP1dUM0t/F0ZH5xAlyzhm8q6XlJR5xxCgS7go9MXBfaxqcOmkimkV0Q+zPY65YC43fKDjLFi+RrQ/sUStzB2X4eNZMACNVmJqi/I6FcWIaMmuk7pATAZAn5CCAzCBKj6vGbNWaSJpOFxvMjphw/pAPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kOVRmEbM7JT6/776oO3qp1m+3eon+RO5lkz7NaSRUM=;
 b=kDps4aNuIlMLGbeH+cCbOPZ420rAtjYz73Gpsn7J0TRZZ69X+rTBDPzm5maVtqK4R46sQclyI4fMjqrJeXL8V0m50EdcOwa3Kh5AisxCx+deGrMMmiORO+GjTU66wj0OvUPKuVXqmVPHd7HlzkuioT8ynACf/phcxnZGYrOL4QVOvzDk6lkeNVbBQp/sO4Xp5KYUFYIPFAmw2bhGsayLLIFiRjV9sNKSWy9Snx0/WZ06ZITgXzR5ziLeRjWy3wmrH64Omk1RcRICsukmbI7l+V4VNOyh4rNNrnDjQOtzCshaNgrpjbr3d4nEYeHVzCmCi1+OnvnkEVzQRioKlT2yHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kOVRmEbM7JT6/776oO3qp1m+3eon+RO5lkz7NaSRUM=;
 b=CFngc8oGa/BUBpiBlMIfITGZsbRk27fgXCOUzu2zpGClqcPhUz0KXd1rZBFlmo76ZwhI9xTlmRwVtGHoeKAZFOdYHfFYVjWxDYHjDm9Z65e8bjIv13r0K7cWMKf2/DhKwNf5xo1EGFYFfGiJzEj3+GPumdDWIPPzjaQhpue7geA=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DU2PR04MB9177.eurprd04.prod.outlook.com (2603:10a6:10:2f4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 08:57:12 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 08:57:12 +0000
From: Joy Zou <joy.zou@nxp.com>
To: peng.fan@nxp.com, ye.li@nxp.com, ping.bai@nxp.com, sbabic@denx.de,
 festevam@gmail.com, sjg@chromium.org, saproj@gmail.com,
 judge.packham@gmail.com
Cc: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Subject: [PATCH v4 0/3] Add pcf2131 rtc support
Date: Sun,  7 Apr 2024 17:05:00 +0800
Message-Id: <20240407090503.2312483-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DU2PR04MB9177:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RM9VcJtBIYUcSYSJk1A8xSYsICllwcjN+4U+aUWFJlT+uNrpVifljjAfS/A+xpi1CBDvn9Ux7J3ep7m69Qd5aBah33DTondSwijxFRmX+yqZC+Phe/kDtT1+CEph/6PF2lHtc51l3KIEqXuXagIcmGJ1dPkbhoD2WurhrkRHc+SPQY4hdVC6OVVn0cMumrJhBnxfo3ZxDI/6Wq4wc7ApCWlm/YaVfWg4MrzEyicTqj7N4UCPQwV6FmzGFwqNyIMibDfHM1Da81W3VM+3f0kLzg9EWoYiEMc4JmBwgS+QuyANbqgDoXyKee9V/AhEAtl9DL3UcN1Tpv7fdlIx3PM3yPz2n+PQKxehrAh3L5csSRlPLjRPkSV+7zbSBJRk9l5fJJQxUs7MGCCdmuL5PshyjP5dLLcIi2ved+t0EthPb+6GCM0abBfJqrHytc8ns5npoLeys1yOVP+hOo2165dx/je4SeA078C02ZxOF2YSRaNvf6ZIAhcpDYtfEnRaU426TNfBJIihcxUvn5556wSJoAwMBVuWDCcHlc1krGYTvSug7lF6+6lw9u7DqrVLSJaq0mjy2RguVY+fYhlRPS/jd26jgGnm9Fj1NrAYKQULvQOZankqRunMlVq4fUIM/CTVS8CTyS78f1rLFa4S+mHnUMHY4hbkLECy/xtRkWMGCB8TKoPl5GnlI3xMRJdDwIjAmSu9mkNDhjfjKyxSWu8gmMvvbVw7vQJfuF9SAaW7cY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9386.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lTAUiFAC8w+3osQCOoe09FEKKLIWf5RhY2+DyhdXVpyjO2jkD0mic461fOwd?=
 =?us-ascii?Q?U8bC59iGzes3fHther6F3GFlCILWQ13H7ZtdShRtRureb9FLenvVVTVibL7k?=
 =?us-ascii?Q?euzUyvobL4vtMUPaO6FUq0N70lYu+/a7AjH8OPqyEDDftF2koJ1wnhOoAhrc?=
 =?us-ascii?Q?CY/hmf8MZrlq3qjQOAEmLY9QZtoraVQ+My27JOJtW+Qt4yKEuEkI9LxYA+SU?=
 =?us-ascii?Q?qYDAboB7G6GYyeM8e1LGf9v+0QizN5493vNrPvNbOKbHpaybBZI1jLjumPpc?=
 =?us-ascii?Q?nMexAdkBeFy8wg925EFo6ulyw+AusUmPYnLiJ+0E3o7kwMgAlrcTEMgbpgnk?=
 =?us-ascii?Q?AaBH86EQ0ycc9XHc5th+X6rPoPYM3sh8iuZe3ddRUJfUUyySEMuBqmUeXNgd?=
 =?us-ascii?Q?rMKOEztkspS7w9yKkSZOzvji80qPKZSu8hJygBS/X0cZ2yFL/18h4IPdOaiP?=
 =?us-ascii?Q?iZOnqdznhMAY2fiPBH0N5BeDjGyk+okQrQlom4/AeZlUclYXE3II1rjWxr3T?=
 =?us-ascii?Q?5PX902lMS0UDZpGVUdyN1+PgaRFocsG3JyziL7lb+sgkw4nc5UeFsGSbZgcE?=
 =?us-ascii?Q?GyF0+lczVFFC5ixtRBRDAO7NrPdusPGYxA8Xfx9TVkhKhEDvX8PnuU/mHOlb?=
 =?us-ascii?Q?avy+KtG/71WBSC/wG30n9XgU3dSR2prM0uXKjrHf/shHcaXudywSmSIz/VoT?=
 =?us-ascii?Q?2sriDpB4PTZj3uJeAHMsEvO0B2Ap0f/DE2V5s9tW+tbVtvsderHrX9uaNwha?=
 =?us-ascii?Q?PehfU9URLxNTQLBXSpwD6RtN5mvWGsOtWiW6zw6sIBYWGeYSddti5pfj60zp?=
 =?us-ascii?Q?Nw7A4P9D1YECVAWv2mSpCi3LzkfBBg0M3OwzhRlRtdbpmN4eygc45BZYlIbe?=
 =?us-ascii?Q?UdQ2ECxpKmjr9LfojrZU8hfvyJW5iVZtQRJDNoMwolhH3Eus5kvEGdSTSIo0?=
 =?us-ascii?Q?FjkMN2xPdJGMay/NHozHviacV5MoUOewZK7hMJs3qN+FZ8YOZdOE3qnZxOvZ?=
 =?us-ascii?Q?c9EjBgQmTuUoOyFdEev0cD7i1PhhYmr30pxObOsbi8stcZuYKE7usr89rxRI?=
 =?us-ascii?Q?RRnIaXWhrB30eara9lvtd1OTqJ1q6HwvVlltIZxgBswaSmEhtD35TnIofNnk?=
 =?us-ascii?Q?G+5MVsgxHYAH/EF62QZUz3MoAk9QHu6+lkgsDzA+breuRXBa0EmZ/apqj36y?=
 =?us-ascii?Q?CgH8ZdPCX4ar88DCdkM7FSBa+hYvCNTOJXmsZiXzwtJp+/FPhzBzg0QCg7BF?=
 =?us-ascii?Q?7CDKfgEHzd+e3Q550BMgevWE7DeJ9e8Bm9/uWkdjjOKrl/iv5E37n75ZOK5U?=
 =?us-ascii?Q?TVjDHIpLHDwKgvKZDfb2kjGS6CAaiuJX7NNI/Gwfz2h0Z4aLBvfNNUwMu7T9?=
 =?us-ascii?Q?rFXaaHBCzI+Scwt9LGzvUGTF5pzQSJHo+ujNDqpI86ruivcVt6/X8z8fBFpZ?=
 =?us-ascii?Q?Xb0diy2/EvaSff3DNyhZnLu/tQH3y4Qz0sLrx18bYJqH2NGNv4J0whlkeliB?=
 =?us-ascii?Q?gpgb7CZD0ABD+QHE+0Tc4y/One13pcQqu4V42HJ7xXSeBCOng6/dCuZ6J7Fn?=
 =?us-ascii?Q?fVuJELry+VupupmAXhSQlKJZr+jLCylDPTnfoXZ7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a8a83c-fe8c-4a07-5dff-08dc56e0b6ad
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 08:57:12.0676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHnR1kkq9XRBhI2pqpFFRs2J8vmQYjF7nj4b7v/cKPKGR3+MA6FSth/1g1nys8sP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9177
X-Mailman-Approved-At: Sun, 07 Apr 2024 15:03:39 +0200
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

The patchset supports pcf2131 rtc.
For the details, please check the patch commit log.

Joy Zou (3):
  drivers: rtc: add pcf2131 rtc driver
  imx: imx93_evk: add rtc PCF2131
  imx93_11x11_evk: Add PCF2131 RTC support

 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi |  34 ++++++
 configs/imx93_11x11_evk_defconfig        |   1 +
 drivers/rtc/pcf2127.c                    | 146 ++++++++++++++++++++---
 3 files changed, 167 insertions(+), 14 deletions(-)

-- 
2.37.1

