Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDD7FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16136842F2;
	Sat, 25 Apr 2026 18:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FBdpKzbD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24C8C842FC; Sat, 25 Apr 2026 18:44:33 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED2C2841F2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
Received: from AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 by DU4PR04MB11726.eurprd04.prod.outlook.com (2603:10a6:10:615::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 09:00:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdE+zWnms0WcbEbQDXbvhyQa3h7KN022Oiw/7tq2d05Ub58Asiy/rpP1Bv3/7XKM63bHw8AfkR80UQKSSBGqF3OnOcmc4+KxGgGeDShVm8KbdWDMDy31D0rX3tfSHOWwqHabHHem1PNj+AF8yB4AsBohRsunPLkcysGPxPy22dBDQ8iC58hmo3HkhtoyBizxqzd/d1mvAHfp6wAamEauTqXdeHp72oCWelRhGi6d4/M6nYD+Fq+9ATzgxVSv5bZtQvyPdbwa3aP1FucyI2Rw579farVOtSj+UrzjjOliqU6dJUVbbPRPlrrW7iYK2L3TPiSU1uwvHQIFDm8E0Ceusg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxvWD1tbGVkUDEEBjoOmCLTLuc4f29uk82r45yrceTM=;
 b=Ms8c2S6XWsSLYCLzyVhq1AOwZAB8h6uor6qu9Pj+ZiFDxri6KzxYD5oncJHsVXsEdt/WaQ6Z2zGy4AmGYkBbmc8TftG/kbqGhiHmQLMR8MPWHPdCnBN9ab+yiCW8g5piasONBh2mkiM715u2e9A17zN0MUGS7iDY1TbnSBl/Mok5MYT5ILCiE73vcOEIleVHxyyJdBCbs5AKGa96A39wo/dCJ5EE1/eD7ALow7gGprzQAAOujyKX55A3+t1FscpaP+fC6CjE2TlyeRYm3Fhd7E+GIotmt3lLAz0d77W/FQgMaQXsyGgSSD6gGYwlVr8KXlZaZKusSbHqKqL3mnWOgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxvWD1tbGVkUDEEBjoOmCLTLuc4f29uk82r45yrceTM=;
 b=FBdpKzbDy6+h1Wn56SvUHKgiJN9k3rGZc6D6nfhakKMFiYZ/x4Ib6bp8hDkms/3YoSUFUBskh9NI23fRlbk7EYfqPMsv3i7z2GjGfS68uzSeBi9j7/fq5zAb/RcgkoY1V3/AVp78WBvSgpw9rgG3kc820lBBmzq4N1/5AzkRVx4p+Wbqbi+mhP6ZeS+5RoWsa2N/x4YAUVoVcoYY5CyXM2a9ANaLe6eOK0KcgClngHM7jiS4zGKi5N58vgfRXIH0EoMpzVl7uM6o/W5vefPeTkYPOxa6FE+a296EC+et/eW9+9tb0i2VoYvv3PEPFL23VyAijdUl/b4o7HBjv4sgkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Fri, 24 Apr
 2026 23:20:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 23:20:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 00/13] iMX8M: Covert to OF_UPSTREAM
Date: Sat, 25 Apr 2026 08:36:52 +0800
Message-Id: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKQM7GkC/x3MQQ5AMBBA0as0szZJFdW4ilgUg1mUpkUk0rtrL
 N/i/xciBaYInXgh0M2Rjz2jLARMm91XQp6zQUmlZa0qZPcYh8eCl49nIOtw1I0Zp9m0pC3kzgd
 a+Pmf/ZDSB1lNKPNjAAAA
X-Change-ID: 20260423-imx8m-of-upstream-b658bcd87e6a
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm, u-boot@dh-electronics.com
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, "Lukas F. Hartmann" <lukas@mntre.com>, 
 Patrick Wildt <patrick@blueri.se>, Ye Li <ye.li@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 Angus Ainslie <angus@akkea.ca>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Olaf Mandel <o.mandel@menlosystems.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7876:EE_|DU4PR04MB11726:EE_
X-MS-Office365-Filtering-Correlation-Id: 05624b7f-bbfd-48bb-b08c-08dea2580c10
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|19092799006|366016|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: FJ+bQ4T6l9I6q2NYuVZLKUeNnCRPzNKVC2kaYjnq6jMh8saXiKrzOT40mcVfU7AgNbgTFSF/+jQXWJrEduT/10eJ3Ez0Yh+5l2JcI34QH869UbUjfA98JeeT8dfnU5V8KT6INDEivMgu6rDSrm9rUNmAYr9ISNnF0zE609CzJQqeJpuMxCXUlhNN5P4ciF27gprKyep4eOmOvz5KUhKaGXtMy3t2oZPBTfxhnb7odZyZ3GCut/Tl6LC+P77OlZup+4GV9SB0A8UgET8piH6MN8LyFX5Qc4AgVmcxMFwFV8bmO+B9m8LrPYuZ67PGnF4w6KOr+3SjublvUC2XWB843dzdW0wqtE55NZbFJ+VCvxkoFFrnWaO5TBNKhXJMVYYtsjDYcn9O7HzpXthkzXq8qmqHJ8rttrRampTco+OS7UAb+j9+1rntfOnaRQ/zNUV72tQrYpQJgBd3O9/VnMVrDZvyeOOTjUObO3t4dai+Rq1UrAor70i8VzwTArDrxlncW19jk4ABOShqKFo0dw7Xdyw7q4O/vsUe6ankiPtQx5yr/ddoyx9i3SUY87bgZ7d2HAlfPDtnBokzM6xy/od+GG+RNHYNvN7FZ/dRDArVMif0kw7ofRm+0NJhXgnWrPjwl0RfNL322P+VHEajVTIQdC6UqD4zWofBqeDcUD+YVVOCnseEz3DECamUKQixMyO25oLPIhJBXvFlSXAkugOxMO0C87fz4QyAGHj8yu+IVOZK45yzsqJYszNKaR9NEwmeDvqqOwzOkzM/ROReNyd9ZkKOf3M6rLl1idM7NpSvD+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(19092799006)(366016)(56012099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHZ4RnluaWlZdEZzMC9YRE82QzNWemxRcktObmQwOWI1ZDhndHFUaTVVTGJH?=
 =?utf-8?B?dlZ5U0I0SUhGS2s0dnZCY3crZVkrZTQ4MEZpY2ZxcXNIc25hM2JLV24zbysw?=
 =?utf-8?B?a0M4dXlQREJ3cVF3VmJqeGJsWlY1b3JIelB4OUZmRHdqSE4za3A4U1pLUFll?=
 =?utf-8?B?bmFkV2NhZlhaVzhQcVFnSG8vanV6d21DT2w1NW5Xc1hTM1g1STBWU1NzcUhp?=
 =?utf-8?B?c01BZE1VUVR1RTFRVU1jVDRxZXB1d3Rlc0F2VGlQdTMwUmE3aDFhbGNTLzFj?=
 =?utf-8?B?bll5T0lpRzhVdGtoTHBjOVZQbmFaOTJWNmpDOEY3WjZIcWZ0RmFsd2d2aldy?=
 =?utf-8?B?K0UxVWpXOEk2M2k1cjlta3FwbE10Qm5sWkRndmVqL0kzNmtkeEVidUE2bnJi?=
 =?utf-8?B?Y3UxTXU1WE03TDB1OFNlSmJvaE5uMHBWSzFxT2hEMmpEeHJCMmRTTEdxZmZB?=
 =?utf-8?B?RVJTSS9JVFNzaEc2Qmp6RlczUy9SZGFYa1dkTk1FcnJqVWpQZi94bkgvUFFB?=
 =?utf-8?B?eGlkWmZreWt6S3VreHlJU0hZN2ltSWxGWjdweG45TlphSm4wVWZvV3Yxcktk?=
 =?utf-8?B?S0hlRStnemhlR3Jad09WVjhBODcyVmRCZVVhVFF6RHcrRThRWjQydTA3T0VE?=
 =?utf-8?B?U3pFNmV4ZWc5eGtKUmEzakhvR0ZPdFhnZ1pmYVlSQVpMeGw4QUNuNytzZDFY?=
 =?utf-8?B?b1piSHJBU2MwWU9uUFFUZHdGb2RKWjZqcmxKNWtSQU1wUG02Qm5xVmlDYlZY?=
 =?utf-8?B?czlXdXJ3WlpLSWEzZU1WVXdkQVk3M0dNTmRneGhud2JRMEY3QXBUMkdmYjJv?=
 =?utf-8?B?MVlTcTNuOHdxUHdJTU9jeXM2ZFBuQWZrZC9hczMrUFVIQWpFMlBXWXI0ejQw?=
 =?utf-8?B?S25MSVNPYVhhTTI0ZGpNNm81RUNmdERpQWVpU09tcTdPaWxZcmZ6ZmdZY0xL?=
 =?utf-8?B?M0tMbVAzWHNNUjZYWWpTZ3RYN3NlTExEWTA1SlRTTHZPYTlkd2hpOGx4dW1S?=
 =?utf-8?B?c0FVZHBnN0FBczk4YUlVeitxbHVqVFVRcGZhZFJDYUg3NjZsc0lkcFJoNlJ1?=
 =?utf-8?B?Z0hQdC9SSndmQU4vcG9neThZQ1NWSEZ3YkpTVjRBc2NKdlA2SEZ2bVdlek1m?=
 =?utf-8?B?UXh4ZTF2NFlhUUtTUnZoMlF0N3UrLzVYMUsrMFp2UDlVQ1FoNjV6V0E4ODU0?=
 =?utf-8?B?VWNNMlZPV205Zk5ETmQ4eVFmclhiKzNzT3R1S1Jma3ozb28vbzBlVS94OGxM?=
 =?utf-8?B?dTAzaWw4NC9wNHkrbWY4dzZDaXVJQXExNTJFUlJSeEtQZlV5bnZpRmludGZK?=
 =?utf-8?B?UHpGNGRCWlRNeStSckh4Ti9OTFpBOHpmYVhqdVRPYmI3anA5SFVINnBSVmhT?=
 =?utf-8?B?Ky9YaTZtTGsvL3I0YkoyVlY4NmtTVno0dEpPUUtyQ3ZBRVA2Yjl5R2NLUDhV?=
 =?utf-8?B?aGNNRzFyRjVLTTdFNS9FR2FDR1JSNXFxdms5L1AzekdGZU9ZOTByK3VuSlNw?=
 =?utf-8?B?U3l2RTdDdmxHcVVwSWFQNHZsbE1TRDJOZ0Jpbm9aV3NlYU5rK0h3QjVZWUkx?=
 =?utf-8?B?aGtlL21RdHpFRzJ1Ni9hajE1WWJwVmc4MWJTOEF3WDhXY0liMDdoRFBYbmpF?=
 =?utf-8?B?ZEk1MkY3SmEzUldUN3VrZTV6NVBZMGQ1aXZKRC9lQUhOMGlIRStjMGFYSitT?=
 =?utf-8?B?U3BXOFF4aitNdC9xSzh2blJaMGlYay9VOHNzRGF1NDFZV2RoQ2ZZNmZMaHZv?=
 =?utf-8?B?MmczWkhQMkEzSHl1Q2szcGN5aHRXanJzTnMzbnQwVStSTmhXVmxWVGJWUjdM?=
 =?utf-8?B?QjN4NEhYdlNVQUxrWlN1OFFmRk1hY2xBdm8yTS95MENQcEgwR3FkdVZyakpu?=
 =?utf-8?B?bjZ5RjNwaFNTazFGN3BLdGJoSkJhaUU3WEJ4ZlcraDc3eDZyQ1NpMVJuVWQ2?=
 =?utf-8?B?SmdXVXBqTUdtK2w1ZDd1a0xEdEF5SHFPYU10QzVPVFhseUljU1BEMUR6OEpL?=
 =?utf-8?B?T1ZrNG5aWUQrZkl2cURPRFcvdkVqcjN1c1ZqbFNpaEtpK3Y3MlN5MHZZbjNM?=
 =?utf-8?B?QklUcGtDVlBJV0VRNUdObW14T0VxZ3cxU0FZdEpwM0FVYkdncWg3WjIwMWsz?=
 =?utf-8?B?QUF5YmQrYTc5RHFYM1FVenBNOHFSVUYxUUh0YTNmRU9DMkxsQmpBMjZ2S3ZY?=
 =?utf-8?B?dFhIQVh4OThGZ1hKMHdiMTd4KzhLNjJUalJDOXF1VGc3N0lIc2NZM3IrSUdC?=
 =?utf-8?B?RGxlQlpNSi85dHQxbmtsWDVkNUtmbnN1dTN0d09VTVVXblBnNVg5OVNHUjRl?=
 =?utf-8?B?V2o3cjI4WXZsS3JLdmFPWTN4T3hvMitkWWlId05IQXNVVmdnK3ZOdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05624b7f-bbfd-48bb-b08c-08dea2580c10
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 23:20:17.8103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thPfq0BFwnAYCdqTbAlbG6ePERsewS1M/OBScUoT6zMmjv4zTvl8ZYp0AcXHdGSNGSItxHPnSk1dPncgvUVbeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876
X-OriginatorOrg: oss.nxp.com
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

This is an effort to convert i.MX8M Boards to OF_UPSTREAM.

The only left one for i.MX8MQ is:
imx8mq-cm.dts

The left ones for i.MX8MM are:
imx8mm-cl-iot-gate-optee.dts
imx8mm-cl-iot-gate.dts
imx8mm-phg.dts

The left ones for i.MX8MP are:
imx8mp-msc-sm2s.dts
imx8mp-rsb3720-a1.dts

These board dts are not in upstream Linux, need give a look to upstream these
dts to linux, then move to OF_UPSTREAM.

I checked all the board dts, but I not have the board to test, best effort on
this patchset, but this change might break boards. I would appreciate board
maintainers to help test.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (13):
      imx8mq: reform2: Switch to OF_UPSTREAM
      imx8mq: phanbell: Switch OF_UPSTREAM
      imx8mq: pico: Switch OF_UPSTREAM
      imx8mq: librem5: Switch to OF_UPSTREAM
      imx8mq: kontron-pitx-imx8m: Switch OF_UPSTREAM
      imx8mq: Drop arch/arm/dts/imx8mq.dtsi
      imx8mm: mx8menlo: Switch OF_UPSTREAM
      imx8mm/n: Drop unused dtsi
      imx8mm: data-modul-edm-sbc: Switch OF_UPSTREAM
      imx8mm: icore-mx8mm: Switch to OF_UPSTREAM
      imx8mp: dhcom-drc02/picoitx: Switch to OF_UPSTREAM
      imx8mp: data-modul-edm-sbc: Switch to OF_UPSTREAM
      imx8mp: icore-mx8mp-edimm2.2: Switch to OF_UPSTREAM

 arch/arm/dts/Makefile                              |   15 +-
 arch/arm/dts/imx8mm-beacon-baseboard.dtsi          |  437 ------
 arch/arm/dts/imx8mm-data-modul-edm-sbc.dts         |  997 ------------
 arch/arm/dts/imx8mm-icore-mx8mm-ctouch2.dts        |   96 --
 arch/arm/dts/imx8mm-icore-mx8mm-edimm2.2.dts       |   96 --
 arch/arm/dts/imx8mm-icore-mx8mm.dtsi               |  232 ---
 arch/arm/dts/imx8mm-mx8menlo.dts                   |  335 ----
 arch/arm/dts/imx8mn-beacon-baseboard.dtsi          |  309 ----
 arch/arm/dts/imx8mn-evk.dtsi                       |  533 -------
 arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi |    2 +-
 arch/arm/dts/imx8mp-data-modul-edm-sbc.dts         |  972 ------------
 arch/arm/dts/imx8mp-dhcom-drc02.dts                |  230 ---
 arch/arm/dts/imx8mp-dhcom-picoitx.dts              |  152 --
 arch/arm/dts/imx8mp-dhcom-som.dtsi                 | 1153 --------------
 arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2.dts       |  175 ---
 arch/arm/dts/imx8mp-icore-mx8mp.dtsi               |  186 ---
 arch/arm/dts/imx8mq-kontron-pitx-imx8m.dts         |  613 --------
 arch/arm/dts/imx8mq-librem5-r3.dtsi                |   45 -
 arch/arm/dts/imx8mq-librem5-r4.dts                 |   27 -
 arch/arm/dts/imx8mq-librem5.dtsi                   | 1382 -----------------
 arch/arm/dts/imx8mq-mnt-reform2-u-boot.dtsi        |    4 +
 arch/arm/dts/imx8mq-mnt-reform2.dts                |  354 -----
 arch/arm/dts/imx8mq-nitrogen-som.dtsi              |  278 ----
 arch/arm/dts/imx8mq-phanbell.dts                   |  481 ------
 arch/arm/dts/imx8mq-pico-pi.dts                    |  418 -----
 arch/arm/dts/imx8mq.dtsi                           | 1615 --------------------
 arch/arm/mach-imx/imx8m/Kconfig                    |   10 +
 board/data_modul/imx8mm_edm_sbc/MAINTAINERS        |    1 -
 board/data_modul/imx8mp_edm_sbc/MAINTAINERS        |    1 -
 board/kontron/pitx_imx8m/MAINTAINERS               |    1 -
 board/purism/librem5/MAINTAINERS                   |    1 -
 configs/imx8mm-icore-mx8mm-ctouch2_defconfig       |    2 +-
 configs/imx8mm-icore-mx8mm-edimm2.2_defconfig      |    2 +-
 configs/imx8mm-mx8menlo_defconfig                  |    2 +-
 configs/imx8mm_data_modul_edm_sbc_defconfig        |    2 +-
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig      |    2 +-
 configs/imx8mp_data_modul_edm_sbc_defconfig        |    2 +-
 configs/imx8mp_dhcom_drc02_defconfig               |    3 +-
 configs/imx8mp_dhcom_picoitx_defconfig             |    3 +-
 configs/imx8mq_phanbell_defconfig                  |    2 +-
 configs/imx8mq_reform2_defconfig                   |    2 +-
 configs/kontron_pitx_imx8m_defconfig               |    2 +-
 configs/librem5_defconfig                          |    2 +-
 configs/pico-imx8mq_defconfig                      |    2 +-
 44 files changed, 31 insertions(+), 11148 deletions(-)
---
base-commit: e973fa5115e40f93bb1425db5b1cc1f3d9b8047d
change-id: 20260423-imx8m-of-upstream-b658bcd87e6a

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

