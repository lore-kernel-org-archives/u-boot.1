Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E33DC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 147C8800C2;
	Wed, 15 Jan 2025 14:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Opz3v4xn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9993880214; Wed, 15 Jan 2025 14:29:11 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 506E880040
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQAOAlrjPM0FBrEmjaIauQ1CM1vQLffgnF1Bv1xOktUTjBeMg3i2T/rLedlNgB3vKwjh0cJdLrIIdvregDly51lfWGare+0c1tzsu2YCl4RlBDiM5X7h2yoVbnDNlUlb4LWuInXLY0bgrNhEMwlYL5PE8I1VoDlli8t4dp8PDYECl9l0elY5ttJvVYGoXiFiMoKGKrBywmr1c3S2n2IriFpapvkhQ6iM0AxO25sAwURDICsNushkrgbViSot4ms6BLNdew8QlngwlnN5Zy8Vn2ejI8O0pI2H+NdERYHKkkBwXIweAZqTHy/gBOVP7MEeWblEvkYfsPUFxFyBvakQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9F5n2usOYWNVDNBJrOEeEp5A9yxZwLck4GxIfsNN4s=;
 b=wQaYc2Yw6TYmncD+h/hyTRrcBbQZEUD/nF+gNtQlIGhySWOFGVJ5JkbQC3uyDuJYlwvlasACRguLTIHc0xkwfmX9KALEP+3iIdS/H116ztv3cYzAbnFQDKou2zqUOsFLlS1UuVQeSVS9cRiS+59xgJwMZzhpGz0E3vTSb1V4HedwazJEwbadpnx02X2enRcungi2Ri/8zOSoiAzU/TcS83OtTDNFzjjtEMhuVPf6q7YW/L1Vcn3R8ukEHri8PDhfhDM5B1Ne+1foNUbS6el2tJpFcQvUIlkJQ2GR1t2OUU1PuAB5MQRSBRbspeMdon93aVIdhPhfNvNwe+7cvR5D1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9F5n2usOYWNVDNBJrOEeEp5A9yxZwLck4GxIfsNN4s=;
 b=Opz3v4xnEfF6gBjI0P6NFOk5P+zMp2B/cPo3bo0/Amr35yt3tPll6Rwx9PcaXyj7/heQR2JvSjSiPjuBMGC+qiqBfFtvSLsTAHlyY0+ntSw+FumpSomQ9PtOhETD2HHifuLBLdd/pOml5HBuKdRmGLO2EB/vv9FEuXl8b1npdQs/tyWjhsaaDZF30yoQarC4w+t4wHkJlELVnVEmM4/2FYcRqdBXoE9iiQyWDjaLUCPWKeZMywOu2i0Z3Oj8uiDJcPVdGMm3DoSDJUPEDcUeOKmNCSR/rMZLvrLqI6t9NFVZubyCF+AC4CRWMfPqIxM5owlSYWX8gsPvz/YFj6dEcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:29:07 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:29:07 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Subject: [PATCH v4 00/20] imx: add i.MX95 support
Date: Wed, 15 Jan 2025 21:28:47 +0800
Message-Id: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABC4h2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQ0MT3czcCktT3cRki6Sk5OQUc8NUUyWg2oKi1LTMCrA50UplJkqxtbU
 AQIOJmlsAAAA=
X-Change-ID: 20250114-imx95-ac8bbccd71e5
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Teo Hall <teo.hall@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=5159;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=wStFnrTCGDJ4Whxtf2dyDJLUUZhN7KXk/rbn+0HsTN8=;
 b=+NfEjzevDPPzZEqzoIWtqFesMk6Ty31wAE3EgxxhGV21o91h8TuXRrLtnO72Mg8jkDtKaC5w4
 IpV/froFLIqCwj9oeDnpYmPxkZryix8raJfJUTrAXoj2U/Wn60Bj2W5
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f8f3b85-a535-4f95-6495-08dd35689624
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnJRenBjb0RmVndFZFhqb1RpOEpYay9VMk9GK1ZqeUZIZnovOGlLM2xERkRp?=
 =?utf-8?B?MnJ0blhGQ1Naa1FINmhHbGZhUXZUK3BQRXpEbitYczdWa0ZFdVpiOHpLR2s2?=
 =?utf-8?B?SHVUOXVLcUs4cWgxajQ5TzJIdXNEcW5SbWNHOVZMcUU0N1pwdEdWOTFKME5r?=
 =?utf-8?B?MXpEdnJoOE9zdGFCbXlWUUtjQ01uSnYxR3NtL01jOFJOcXlxMmpOQWF5NmhS?=
 =?utf-8?B?NTFFaFN6Z3VlMDNUdlhwTzNFeWt2Q1FQSlEwTXRaYkoyQWNoZVB3NmIwT2VD?=
 =?utf-8?B?cnZSalh4MHNTWWc3dG9TbVU1TnlyVUFGVVR4RDFvcS9qK0lCNmVuQ2dFWnUz?=
 =?utf-8?B?bW1QZUE3bVdqeEFHR3FRTCtUcE5vN20vTENONElCVHNETklYckdTSmh6ME1H?=
 =?utf-8?B?anliTmhJVzNuZ3BDK2RNeW5LZktCdDlYR0NETzdPOURNclZaWHdYUkFGR0VL?=
 =?utf-8?B?b0tNdDViMXpndEVmZWp2WC9VQjhVd252STNyMmE1alEyNkIzU3haWUdiU2JR?=
 =?utf-8?B?d2tISVlldERaUjNWQTJldGNJSWZQMXJBY1ROaHZOaWEyNUN6UEJGMG03YTk1?=
 =?utf-8?B?NnM3dm9NeUtuWDVoRlphQ1ZGcTE2TXRzRW9yQkwvSFZwQUxmYll6aFRoODRn?=
 =?utf-8?B?UE5JcmlyaVovSGVBY2g0S09OeGpKR04xdnBoeEMzMUtCWHdJUEFhcWFjcExk?=
 =?utf-8?B?OUZpZHZBYVdiY2NUR2FxeDZJZXd6TGlKMEFuendLaXZuT2tUTzlodkcydDA5?=
 =?utf-8?B?cm9VYTltUTcvRTdjdEpSK2JtWmpObHlyY3ZoTW4wZ1MxQm11ZnhPSHBMbWVX?=
 =?utf-8?B?eGNzWHRPWk5MOFl0dmgvNWh3M0tFRmx1a0p3K3AvdHlIZmpFaHQxREphQnJP?=
 =?utf-8?B?dmxadkx0QVQ1UWFWb1pFdnlSclBDVEFGVDNwS0RjVVpqOGNiQWVyQW1ha3pn?=
 =?utf-8?B?T2xMTERWRmZ6YXhCeVJnMkk5RlhQNUxzSDB5clVBODJxZEZtQ1IyM1Yvckti?=
 =?utf-8?B?cENwY0xWaVVRY3ZNUEdUblVFSnVZbzBxNGhCalNBUUZiUURoOXpPbkh6K0s0?=
 =?utf-8?B?b28vb0VtbExtSCtDanhMeGlZV1UyY09TSG9DZmhHbGt4cE1DL2Fpcnl0V0hh?=
 =?utf-8?B?MktQd0lCZE9DWTM4MTl0b1F2L21mWHF6MDdSM203VUZHMG1hY2Y4UzJBNTJJ?=
 =?utf-8?B?UHZ1Sk9WNXRpd1pOYXBiNUFvQjlrTzlLQTRMWkJYNm9HYTRYbTUxOXRIc3cv?=
 =?utf-8?B?dTBxYStZdmJHR2xmdG5ocUpDT3dmMTRuK2hnU2taLzlRUXFhSnNHMTk0ZkY1?=
 =?utf-8?B?REx0V21GMFVnVUx4ZXZRaTFGRHF5K2cySG10aTVrdWNaRVdIN29XQnZUYlJp?=
 =?utf-8?B?WjlkWTIwcnNTSm84bW9WWGhOdlFSQ1BVY09BWHVhbERSc1BEamZaMEZlR2VC?=
 =?utf-8?B?Y3QxSWluS3Y0ZUd5MWlqRWlYQXJYZ1hnN2U4OVBFZCtQd1lKYWtLVVpxNUQ0?=
 =?utf-8?B?Vjd4WHoyUXdOcDRhc1BnVEpKQ0M2Rm9ydmluM2FZOWg1SnNzU1hIcFgvV20v?=
 =?utf-8?B?SDFhR2pSKyt1cUpSOVpWWm9jREkwSWI3QlNjYThuWWhlcS9oMEZ3RWtMdFhG?=
 =?utf-8?B?UmVycnc1RGNQYWxlUzgyeEdVWnFEYk0wenRyYVQyWWNpTnB4a3RITTNqZmdY?=
 =?utf-8?B?MHBWVlVlNXh0amE2U2tHci9ydUcxT2s3NTl4azNLN2tGUFY5RjEvYlYzNHFx?=
 =?utf-8?B?SklhMG9Jc0YyekhDTVR3cGNWeDJ5Si9vZE52VSs4YjljY3l3QUw2d1hYbTNk?=
 =?utf-8?B?eDV1MVBiY0Z5dTBHV2YyNXh5VjdOTFlaYTU0eVBYc1c2cGlZT2l5MWZRNHhx?=
 =?utf-8?B?TUFMMnZWcTh0ODI0YTUwQjEyWTdTZWJ1SlIxWlEzSmMwVWVyanBZdlpWUTZa?=
 =?utf-8?Q?jfbgc9dSdAI4UPmzvTtOH8gQK3z2jG0s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTJqVGpRSjR6WUlhMzZUOENORitQUVhnNVRwTmlBUGc1RHhRUTIvRGZUb215?=
 =?utf-8?B?a3V3elF2eGROQlJPcG5uMkFUejNaRVJCQlJLN2NDZHJXZDMzem5IZDQrNEVJ?=
 =?utf-8?B?WnJUa2hMSkxERzBDazVDTmFPdnZSN21PTG13ak1zajdad3RIMFZJM25Ta1pJ?=
 =?utf-8?B?dE9RMGM5ckM3ZW5DTjkxRGVHU204eVFOSEMvSnNrQVhsUWFTZmdWRGtUNkt3?=
 =?utf-8?B?SWlxVUM0MGU3bG1VUUZiQUk2ZXlKeElacGp2NmFjeVYwSUdwNmFHK01DbEpY?=
 =?utf-8?B?UldQOFFxUTdUVFdBRHN3bXVGZHNMWVpRY0Z3UTFEMXB3cDNtYkdUK0tOQ0RZ?=
 =?utf-8?B?RDFPKzZMWjNva1phK1ZJTmdzZUpNdngwRERCRzZtWS9EYzUwR3VLaUowaWdh?=
 =?utf-8?B?c3kyTVJhb1pnU28vZVE1L3p4VEQ4bExveWNVRlBZakhLcDc1WUJsWkw0VE42?=
 =?utf-8?B?bFpEWWtINHF6Y09yRFVRR0RJN2lvUlhqdkZRN2JNR0tUM3lVSWE4eFpVSHY1?=
 =?utf-8?B?SXorRE41M2Y3djI2NDdhTkp1b0ZEcFFkeWE3RExjemJEajdIUmhaQXRxMi9l?=
 =?utf-8?B?SklQeUlFeSt1SVM0QUVBWmlRNGlrZkhCOThORTBqdS9RdlIzMHhGcHF1WjRw?=
 =?utf-8?B?SXdQWTl5SmNVVEpFVjNhZzhuTDZab2hUY3M2dDJTUmtlM2w1cm9GZ24vY3FI?=
 =?utf-8?B?alJyN0NPeHEybmgyVmxVNDR4ejVyVElZczNpeFF6RUp0ZEdpNGk0RmNPbnE1?=
 =?utf-8?B?eXFaZkg1OFNJb3hKNURvOVNPZExPdER3aGg5bWR6OWlMVjFmcWNndVRaL2Ez?=
 =?utf-8?B?NG9oTnlFaDk0RHJpNDMrazVjNHppUXVzUlZlMTZ5MnlpUXE0SkRxWklMczM5?=
 =?utf-8?B?N3ZLNjdyYWhwQ2pkVGl4enJkWnNsdVRXT2NBYnNNd3YwbVduRzduOVAxU3dQ?=
 =?utf-8?B?Rm00N1hGOXNoNGZxUlEwRENsRWRlUjlwSmllSlFqNnROeGtyVHNoOE1zWTk4?=
 =?utf-8?B?ak9qNUJnV1JCV29XQnBhTExHQVJvRzdqT2FmNWpBT3FiNHlNdXZ2K1Q3MzJk?=
 =?utf-8?B?eG9qYUhGK1BJdmtVQUZJSHNkbjVuYTlYNFVLZGU1RnJuTWZTbzRvYWsrK0p4?=
 =?utf-8?B?dytQV0FHYi8yM0hwd2orcXFmVUdQeTRpNHArbFJDNyt6d1EwdVc3eWZQYXQ0?=
 =?utf-8?B?eHJYZXZlT2JKcU14aEpsNWFoOUVOR0JGM1FKVlZ4bnQvc29neEJaclE3SVp4?=
 =?utf-8?B?cFRrOE91YmJuVElsZlkzVUNuV0QxK3VDdkI4RUNteUpjeEgyWlZBVXNOd1g5?=
 =?utf-8?B?MG5RcmdPSzVmMHRXVmpLUFIyeDUrUXRpVE1sNjJsL3U2OFV5ZStObG9hL1ht?=
 =?utf-8?B?RGlxenphRDl6dlY5eHprTTRtQ3hSVHRESHhzVHRybFpJSS83dlZ0OUJHVng3?=
 =?utf-8?B?bHgxREhPRFlCYWNyS09qa2xJbmhwZjdkUk13TFlPcmk2bUFQMHJJOWdmQTNQ?=
 =?utf-8?B?eFMxYzZZOVI1L21MclQvcEFxZHJPVUZLQlVydUplMlprOHdvRC95UkZjZDJC?=
 =?utf-8?B?SXRZcE4vUTh3UXFzak1yb0VKeGl3azFDYWUrNUJkVUpidnp1RDlFS3NsZUVF?=
 =?utf-8?B?MUEwZktldURubm5FdkU0WHkybTh5RU5OeDlDVEN1UFVUN09BU3Y1VWQzKzB6?=
 =?utf-8?B?WElWOHAwcmM5ejhOa09oWStHTGNnRmxTT0lrV0p0UEFYRlZUbm9KK0ZXeGZx?=
 =?utf-8?B?VlFxUUxMckJaVTZoWmdnV0ZIZDM5RmNSTjh2SVp2b1VWckU1S1UyZDJqeTZK?=
 =?utf-8?B?N3hlM09WOE9vRHJZYjd1M0tMS1B3NHlqVEdjWTJOVDJLRVdUaGYva01GVm9i?=
 =?utf-8?B?dG5tREtzelAzakVacjV3VUVTYlpMTWl4MHhtN1lObzFsbmNyWWRqYm1OR0Vl?=
 =?utf-8?B?aEJ1bm9BdCs5T1ZPREFCZlFZOFZkT1FPelZlV21zUk9rdW5CYzZZSDh6LzQv?=
 =?utf-8?B?TDZ0VDJ1cDJ2SUY0eWxteWt0dUFSbmpiMXo5dm1ZYnRVVFlnOHQ2dDJSOFMz?=
 =?utf-8?B?SnZyK1pJRTlJamhxTDY3WExTeDhwK0dOR0lRbzVmV3h3cWNsbHdNNXpjenNO?=
 =?utf-8?Q?b1rzkjKl22yBhBebTRmi/G9k7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8f3b85-a535-4f95-6495-08dd35689624
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:29:07.0859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVuhs5Deq5U/VG6DmaqTklYpNmQiLmUzEVX1tRbFrR2xeINwBSvb7iLC9kIjKt5KnpJ2I0OW7nzXQzr9BADwaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7764
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

Changes in v4:
- split the SCMI pin controller driver and SCMI agent code
- update i.MX95 SoC and clock related code, board basic support code 
  and so on according to comments
- move the function that loads ATF and tee.bin to spl_imx_container.c
- add document for i.MX95 image container format

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (8):
      pinctrl: nxp: add a pin controller driver based on SCMI pin control protocol
      firmware: scmi: add pin control protocol support to SCMI agent
      clk: scmi: check the clock state/parent/rate control permissions
      sandbox: add SCMI clock control permissions to sandbox
      imx: Kconfig: IMX8_ROMAPI is not configured for i.MX95
      binman: add a new entry type for packing DDR PHY firmware images
      tools: imx8image: add i.MX95 support
      doc: imx: add document for i.MX95 Image Container Format

Peng Fan (6):
      mailbox: add i.MX95 Messaging Unit (MU) driver
      scmi_protocols: add SCMI misc protocol protocol_id and message_id for getting the ROM passover data
      scmi_protocols: add SCMI Performance domain management protocol message IDs
      clk: scmi: add the command CLOCK_PARENT_SET
      scmi: add the macro SCMI_MSG
      imx9: scmi: add i.MX95 SoC and clock related code

Teo Hall (1):
      imx: add V2X container support on i.MX95

Viorel Suman (1):
      firmware: scmi: smt: Interrupt communication enable

Ye Li (4):
      scmi_protocols: update struct scmi_base_discover_list_protocols_out
      spl: imx: use trampoline buffer to load images to secure region
      imx9: add i.MX95 Kconfig and Makefile
      imx95_evk: add i.MX95 19x19 EVK board basic support

 MAINTAINERS                                   |   1 +
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      |  68 +++
 arch/arm/dts/imx95-u-boot.dtsi                | 157 +++++
 arch/arm/include/asm/arch-imx/cpu.h           |   2 +
 arch/arm/include/asm/arch-imx9/clock.h        |  10 +
 arch/arm/include/asm/arch-imx9/imx-regs.h     |   5 +
 arch/arm/include/asm/arch-imx9/sys_proto.h    |   1 +
 arch/arm/include/asm/mach-imx/sys_proto.h     |  39 ++
 arch/arm/mach-imx/Kconfig                     |   2 +-
 arch/arm/mach-imx/image-container.c           |  63 +-
 arch/arm/mach-imx/imx9/Kconfig                |  14 +
 arch/arm/mach-imx/imx9/Makefile               |   9 +-
 arch/arm/mach-imx/imx9/scmi/Makefile          |   6 +
 arch/arm/mach-imx/imx9/scmi/clock.c           | 105 ++++
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c      | 135 +++++
 arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 +
 arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 +
 arch/arm/mach-imx/imx9/scmi/soc.c             | 827 ++++++++++++++++++++++++++
 arch/sandbox/include/asm/scmi_test.h          |   4 +-
 board/freescale/imx95_evk/Kconfig             |  12 +
 board/freescale/imx95_evk/MAINTAINERS         |   6 +
 board/freescale/imx95_evk/Makefile            |  11 +
 board/freescale/imx95_evk/imx95_19x19_evk.env |  90 +++
 board/freescale/imx95_evk/imx95_evk.c         |  54 ++
 board/freescale/imx95_evk/spl.c               |  72 +++
 common/spl/Kconfig                            |   6 +
 common/spl/spl_imx_container.c                |  41 +-
 configs/imx95_19x19_evk_defconfig             | 177 ++++++
 doc/board/nxp/imx95_evk.rst                   | 114 ++++
 doc/board/nxp/index.rst                       |   1 +
 doc/imx/imx95_container.txt                   | 136 +++++
 drivers/clk/clk_scmi.c                        | 191 +++++-
 drivers/firmware/scmi/Kconfig                 |   6 +
 drivers/firmware/scmi/sandbox-scmi_agent.c    |  56 +-
 drivers/firmware/scmi/scmi_agent-uclass.c     |  11 +
 drivers/firmware/scmi/smt.c                   |   3 +
 drivers/firmware/scmi/smt.h                   |  10 +
 drivers/mailbox/Kconfig                       |   7 +
 drivers/mailbox/Makefile                      |   1 +
 drivers/mailbox/imx-mailbox.c                 | 417 +++++++++++++
 drivers/pinctrl/nxp/Kconfig                   |  13 +
 drivers/pinctrl/nxp/Makefile                  |   1 +
 drivers/pinctrl/nxp/pinctrl-imx.c             |   7 +-
 drivers/pinctrl/nxp/pinctrl-imx.h             |  11 +
 drivers/pinctrl/nxp/pinctrl-scmi.c            | 136 +++++
 include/configs/imx95_evk.h                   |  27 +
 include/imx8image.h                           |  19 +-
 include/scmi_agent-uclass.h                   |   2 +
 include/scmi_agent.h                          |  11 +
 include/scmi_protocols.h                      | 105 +++-
 tools/binman/entries.rst                      |  10 +
 tools/binman/etype/nxp_header_ddrfw.py        |  32 +
 tools/binman/ftest.py                         |  11 +
 tools/binman/test/346_nxp_ddrfw_imx95.dts     |  24 +
 tools/imx8image.c                             | 143 ++++-
 tools/imx9_image.sh                           |   8 +
 56 files changed, 3390 insertions(+), 65 deletions(-)
---
base-commit: d6da3dbaef57fc1d319b6b552efa009e2489d7d9
change-id: 20250114-imx95-ac8bbccd71e5

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

