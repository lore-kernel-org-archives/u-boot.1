Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D728CCAC58E
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 23:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F223083236;
	Thu, 11 Sep 2025 01:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Rxir9Znb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78ABE8323A; Thu, 11 Sep 2025 01:53:46 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79948831C2
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 01:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssOVJQya30Vwc+dfFp+Z0UGDiWWlzS1F6awpUQmFzmcbjiV3IEQRGTD4XFDocenAGEsUGeqQqMctlv+o2N1NFfwKcf8OYEAjOEAuD8Hbpk3nzh6WadCbdCwspzLcjaXYsQeg1THFVMz5/8qD5oqw65y5EgcfhNmP5/Auhk/iNHISWdaRkpvBCKgvevYiaxA1UQ7HuSJOjh7J+pSFYua2NMar0oMQXLiPi+JqDHS7qwbtsLMpxUZLdVavdtWqVZ5XC2YbvlO1vT0arOPHsyvSCtK4sj9EVAtEkumUQgprVFUNXgh04ObLkye8y/bcMLd3TX6W80hVa/GtWk2kLDtsmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4f+W8JCl1UFKin+vop3jcyITNVmJiy20pwZ+VUs+Bw=;
 b=NgiynAS4tc5c4lKkTj9W3PERnCtBmd+I5Pduz6KY9xCLyLgxatw3Gew9bG93rHegEi1G3P6MYjbVw94AuQxphv1pFUtQxZV18PJ//B9fi6DkotV51walOc1Z/FnzqRzy1RweMrTG/+9LPy44dzpB6z3QYrpsEOPIBtr8291D5qrkXtVWvLvdMCGNCFD3Pzv977bYSGDcBpDMSjLB3sWXD/ylVDu8xn16g8omEiYPam3rdk3f4qjNxfOzr8XycbC3kJqruBs6oZHCdFvBOPnz5WQIQ/ykK7BDLXlizyIRp5Waix5Z3f5ONLiNOaNZAGWctlzhf92khbipRTuGIcrWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4f+W8JCl1UFKin+vop3jcyITNVmJiy20pwZ+VUs+Bw=;
 b=Rxir9ZnbTi041cYT/Izu4w61ppGCiMGrxbgEb/fOorzxE6z7qtjoYWgLHXOusW88KyTjj126TDPTJS+VhbtTAVCksrbii5UnQffAjpiuoRdhgR8QQW3UKbWUvxFqPmn3LzQ/NK56i/hvtpQP06DUljlcPZRh4GGTuqAsok7nNEoY7a4ZdkmsJ+XfGg4z1en5XPH7wUvGNQkxAAPjHOjsWv6R06yWJMHc6/sMgCnh5k0rlnYnnRnzUCGF/JKDZGVRXXw2+nDR58aUss8kQe1hOE/nLiKgW1jB4nLw1OYxBlleksteuatip1bCihNqwluGypvDwaHyf+AD7eqqWFUi0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB8850.eurprd04.prod.outlook.com (2603:10a6:20b:42d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 23:53:42 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 23:53:42 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: [PATCH 0/8] imx: add i.MX94 support
Date: Mon, 01 Sep 2025 18:47:59 +0800
Message-Id: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN95tWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwND3czcCksTXdNkEzPjRMu0VEsjEyWg2oKi1LTMCrA50UplhkqxtbU
 APc8zPVsAAAA=
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@oss.nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: MAXP287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: 170dd81d-a409-4a0c-0dd7-08ddf0c54535
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NU5QU1dLSkFvYkhqU3U3ZHgrbEtlblZiVHIrZ0NNVFhDQ1dOYTNNSDlNeFcw?=
 =?utf-8?B?cVJ0UDBaaHdhUTZBVVlOSjlVbEJVMGl0TzR4QjJ3bEM4dG5iaUtDTmlmZFp4?=
 =?utf-8?B?M3E5dWU4MHZXM2hZYS9ScGdRdkhqaGdYNHdjVU9lU29wWVViNndvZ1BXK0NQ?=
 =?utf-8?B?bGJjZWpZL3NNNHh5emRNRUVDQXNJS0dGUnZOaWF0N0Rkd3pzelk4TVExMUVj?=
 =?utf-8?B?ZmZYZ3ljbm5QZ2V4d0ZQVnNXSzFSYjNlaFBtcm9KUEliNmN4Nm8rVkZHWTFQ?=
 =?utf-8?B?YllzTE5MaGdoMUhBTnZUczVKSm9JMzFGNXZza2FXbzhiWDFXRFBOaUIrUEJG?=
 =?utf-8?B?TkVXcmMyeVdyVlhFSzJxejZXMmkvWGNrUHJ0VFk0TmovWjBUa3lmVWZEWTBj?=
 =?utf-8?B?MU1XNXdwM01iR01Eb1ZxcE1qWnppRXFqRnhLODVVSmNTbmxSaDBKeVkyV1pv?=
 =?utf-8?B?RlJGZHBlNlAxZXhER2owYlZnNTFPU1NsTnRhYlRiQ1BOaUxOcERDVXMyVDlW?=
 =?utf-8?B?SmIzcUk3ZDB2clBmZGVJM1lhRCtnOU1UQXRvUTkyMXUzZGEzejJTblRMeVVF?=
 =?utf-8?B?VzJHc2ZmOFhjMXR2WkNTbk9GamxLMTVIL0haRTljK0J3UmwzTjl4N2psNFlS?=
 =?utf-8?B?WFBlRVQ5eWZORzlURkNZV0dkS2VTSmtoUnBXY2RaekNCVk1pMU9LdlJ2N3pZ?=
 =?utf-8?B?Nk51L2xFWG5OT0lqdjA1WXlMenlSYmtLVHU5bTZnWFMyaUc1cmVBV0hza0ky?=
 =?utf-8?B?b0RjTGIvblhSd2ZSVUZvWlltalUxbTZTc2kwNUhPL0syWS9SYlVWWHVUQXZS?=
 =?utf-8?B?c0ZJU0JVQXptSFlveTZiQlRNQkc3N2dyVTAyTUY4dUhqdXNBOW92a2JVanJu?=
 =?utf-8?B?WUlCbHFXa1JBNTFKRW5ja1ZuSDZYN2JQZUNWNDV4L3JZOUxFSC9ORFd6VVRP?=
 =?utf-8?B?alVmRjRXMnJob0tVYzl1Z0Z0SXFuL3RoSjRzWnFmck9oRWtCaG81dEl3aHBo?=
 =?utf-8?B?amxmNUw5Tlk3NXZXelVaVURxSC9BRFhhalBwdDlpVVpuUWxMSVo5Y2t6aGQv?=
 =?utf-8?B?azVuc05JcXhYemM4UEttbkp3SC8vNGVZa3NvL01wdExwY1EyZlE4cWFsdzNl?=
 =?utf-8?B?SVRUSVpTeW50OXhlNG1vc0Q3R3VSR0JSdkp2VDcvVG5CdU5neWpjWkhNTm81?=
 =?utf-8?B?MHVyc3ZXb0ttQStpMC96ZG1GOXZuTHEvOHltbmRwcHl6d2hrTXZ0SzljK1dW?=
 =?utf-8?B?NDlFN3A3MUZJUURLVEM4Ti9VNUowWU5YcTFCc0VmNjVrc0gzeWpRUnJtSzV0?=
 =?utf-8?B?ZjJOaHFxeVJMTm1nVmd6eHhUOFJQL1ZlaUFWbEprbm1hK0dsRWJkMkF6U2Fw?=
 =?utf-8?B?SXRYRkQ3K0dNVGdEdFlCNDlXZXpCelY5QTlsUFQ3K0pRb1lXWGRrZnlleVlw?=
 =?utf-8?B?MjdPUGczZFovRUpnWDdWcDVML0pIQmJXaTVQU0lRNDJJZW0rZ0lQUEViSlRC?=
 =?utf-8?B?YiswbmhlcTY3TTBIZG5UTVpEVGFSNmVxcFhBbmNHdS8vZmx3RXpGNmZseDNz?=
 =?utf-8?B?SmJRczJ0ODZFMS9RVGpsTU15ZkV4YWk5dVJPVUdtSUcvcFlaZndEd0xHaTl6?=
 =?utf-8?B?SUgrWk5vV1Nudnc4Y2dvWUZ2U1RxYThlZmtiY3JsNFFQd2cvejVhVmFjT3Jz?=
 =?utf-8?B?aVlsM3V2REo3UTM2Y00yOWFlc2puTktWbU4rR0o5cUJFRml2bzlPeTM3TTlU?=
 =?utf-8?B?aThhNHIyOUpxSzZKWUZsQlJTa1VxTE1BUjNhdjJaY0xjbC84dWs5THhkb201?=
 =?utf-8?B?TVNrUW9NZDVmTWptQ3ZxcnhSTkFXcWNZSDNBWEp5MjltUVNoOEpKN3hXb01u?=
 =?utf-8?B?L0lWdWJMTEh1aG0xSm9sdmg4b2Rlcm5xbGd4U1ZKRGxTYk42c3hpRXBnaU53?=
 =?utf-8?B?Wm5PWEY4SmJCbE16VzFtUDRZSVRVaTFZejlFb0hZUlMzby8zVDAvT3lGcU1C?=
 =?utf-8?Q?mqdhO7UYiaGPotyuwYmJjV7q/IZCrY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1duQUtsR3BiS0ZoVExwTG1hdmlaUngreU85Z2prc0VJYnpQSmVHWlpiRXNC?=
 =?utf-8?B?WHhGTENreVJ3VE5pT0EvQmRnby9NdWFaT1NzU3pSTGdXdHVXQXhqM2FaMEpj?=
 =?utf-8?B?dUZQSEJVdWpFS3dFK1V1c3ltSHM5MGRhelIxUWRGZWhGaFduRVFEYzFtUGQw?=
 =?utf-8?B?YXVLU3B4cE1TYW1rQitQT3RZY0FXSjlhUllyS0pzdndwY01qZjZyRUFXcDRY?=
 =?utf-8?B?dU96aEQ2bStrbDIwbjBlM2VIODdtWnJmUkVGUFdLTTA2a2xWQUQ1YWl2eFhO?=
 =?utf-8?B?UGt5ZFhKRm9mZ1VBNWljWUs2Q2JsN054SUt5eXorYUEzaG8vcUxHZEZvQjY1?=
 =?utf-8?B?cDcyYktENHVLTzZDUHRNMm5MbFQ3OUtGQ2w2b0xrcmZDa3RsQWJwc2JKVE9D?=
 =?utf-8?B?L0JoR1JWdkFEd3VsMVZUb1M2WjlhSHpMWWpiTUF5anhyL1VyYnFYM1M1Uy9F?=
 =?utf-8?B?TlRuQVg3Z1k3SHd5VnU0RTZFL2prRlZPMlZRQkU4OERvTFQxZVE2V0ZsNDh0?=
 =?utf-8?B?aHR3UUI5ZEVEUktFZ2RoeXQ5ZFNRMTdFZjc4eUYzSm1jaHVTQ2JFZWkwRE5a?=
 =?utf-8?B?NXlia1M1NWpqVlBoRlpkVzJhZCtWaWM0Z0QwUTh4Y2ppQ2VFQU8wT2VBbHFQ?=
 =?utf-8?B?RkRSbWxBdTUzbTZFUjg2N3RpaUlNNVJ0KzJRUytOck5XVDAzbkZXVnVkTzBj?=
 =?utf-8?B?L050RjRqSTFsSkVGcm5HSS9TTXFnc09zWWF6cnByajQzZUVDUGM3WUdGSzky?=
 =?utf-8?B?Nk5JNHJXL2ZHaW1WRi9UYi9VVnM0SGtvVWdsVzZRTGxzbi80RktIc3dlRU03?=
 =?utf-8?B?dTdLNExiTUtPMHJXZTFEeHJELzFJRHozVi81RmFsdmw4N1VCNTIwUHJBd2lN?=
 =?utf-8?B?YUZrb0tQNit6aitDeXBweHoyZFhYNFU2SnpvZVdPWlRvUUYzY2ZUU3VOWFp2?=
 =?utf-8?B?L1hSb3NreDc3UmFTbEowRzR1c25aelI4MWRTM1dXZlMyVU8weDNkaGVuM2Vj?=
 =?utf-8?B?aWRDTnRZZ1FPcngxZlJiTkc5RG9rT2QyU01hTUVOd0xDSy9aTWRRaHFVZnhq?=
 =?utf-8?B?NUxZUm1Dc0hHU0tpWXNGTzZibTA3R3c3R2RUV1M1RW5VQzR1amtkUHQwTFJz?=
 =?utf-8?B?Z3NiMk44WklXYjdDQlJMWll0NnExWFl0aSsrbUJlbUhTYmgwWE9XdmR5RkU3?=
 =?utf-8?B?Wll6WFVhdGRxd25XZUQvc0doeS80azVLYzhMRUYxdG5VZ1I2UFVTNERPUTly?=
 =?utf-8?B?d0IvNkgxNW5DUzd3WXJvSnRlandEZE9aNFp3ZUpNRTJ0a3R3YXVBVkorM0dO?=
 =?utf-8?B?bUw0Zkh6NjEzY1pLSnk4c1RVbVVHeVdyVngzMG8zMFEvT1lhcS9sZXRSQTQv?=
 =?utf-8?B?dWZ1bUFsbWRoQmlUaXJGK1RRVWtYK0xhUWdtZnVrSGRjczVKbEZ1NUtJazNW?=
 =?utf-8?B?VmlQcnJTOVVlS01hSHRHMjdnazZ1eTEzNjJ0b08wWkZ3ZWJhQUlnbDY4V2Fp?=
 =?utf-8?B?K3FWMThMMitJWUZ5Mk1XbEQ3VlVZU0YxMG5uV1dIVnE1OGZLS01yTWg2YnVN?=
 =?utf-8?B?eUo1N2VMMGc4dWd6QTl1Yit3RHJhQ1BQN2VWR1E5SjJhd09PZ3lsYzd6TlFh?=
 =?utf-8?B?Y3UyZHV4UVRMMERYYUZ0c0dsdERDUHdQTDJoZEhtVmRWNU14THJkcTI3TXBX?=
 =?utf-8?B?dUxIbndUWlcyVW0xUGtVS3lJZFF0c3l1bnVUME5DN3NXNnNGYXYvQ3A5WVNy?=
 =?utf-8?B?WTR5UVZwZ1FCclRhT05MVmU0dktsNGthLzVnNVkrZFhrNVMvQ1h2MXdKY29p?=
 =?utf-8?B?cVYveGxrUXQ0SW11REdPbnV1MXJxank2a1MxNFI1bWt1eG56OEQ0dHZNbFM0?=
 =?utf-8?B?aFZXbU8xWThkTnE5TmxEOTMwOG1UL0VUNUR2Wm5jWENERFNKTmp3RzFsblFG?=
 =?utf-8?B?WG90eWhQUkw1aWtCU1dwMThiQXIwSzVMTERmQWt2ZnVqSUhqSjBoTGUvWGdV?=
 =?utf-8?B?MW9rZFFEKzhCT2RZNXNsNllYQkZGaTlSakcwc3JEK1NXbUErZVZINzlzdGQw?=
 =?utf-8?B?YWZTeTlvemRrKzB5TGRrblBTYlYxa3JpM1QzZlNLdVg3amhsTlRnQ2xHRzY5?=
 =?utf-8?Q?qx+BbvKTkA/04pzDLPUL6tvYd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170dd81d-a409-4a0c-0dd7-08ddf0c54535
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 23:53:42.1032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76TuQWCUuzvZvFBUJNfmSvLsa/g62FXITrwQtWwwDev6Kgtcd8LGOUxFGnzxBuYhmgPDo1Jidcbt9U2Lob6qgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8850
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

This patch set introduces initial support for the NXP i.MX94 SoC. The
key changes include:
- Addition of i.MX94 CPU type and SoC-level Kconfig entry.
- Printing of the LM/system last booted/shutdown reasons.
- Definition of base addresses for WDG3, WDG4, GPIO6 and GPIO7.
- Support for lifecycle state display.
- Introduction of daisy register offset specific to i.MX94. 

Signed-off-by: Alice Guo <alice.guo@oss.nxp.com>
---
Alice Guo (1):
      pinctrl: nxp: Add i.MX94 daisy register offset

Peng Fan (1):
      imx95: Add get_reset_reason() to retrieve the LM/system last booted/shutdown reasons

Ye Li (6):
      imx9: Add i.MX94 CPU type and SoC-level Kconfig
      imx9: scmi: Add i.MX94 support to get_reset_reason()
      imx9: scmi: Update the files under arch/arm/mach-imx/imx9/scmi/ to support i.MX94
      imx: container: Add i.MX94 support to get_imageset_end()
      imx: ele_ahab: Implement display_life_cycle() for i.MX95
      imx: ele_ahab: Add i.MX94 support to display_life_cycle()

 arch/arm/include/asm/arch-imx/cpu.h        |   2 +
 arch/arm/include/asm/arch-imx9/imx-regs.h  |   9 ++
 arch/arm/include/asm/arch-imx9/sys_proto.h |   1 +
 arch/arm/include/asm/mach-imx/sys_proto.h  |   1 +
 arch/arm/mach-imx/ele_ahab.c               |  55 +++++++-
 arch/arm/mach-imx/image-container.c        |   4 +-
 arch/arm/mach-imx/imx9/Kconfig             |   9 ++
 arch/arm/mach-imx/imx9/scmi/clock.c        |  28 +++--
 arch/arm/mach-imx/imx9/scmi/common.h       |  41 ++++++
 arch/arm/mach-imx/imx9/scmi/soc.c          | 196 +++++++++++++++++++++++++++--
 board/freescale/imx95_evk/spl.c            |   3 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c     |   5 +-
 include/scmi_nxp_protocols.h               |  55 ++++++++
 13 files changed, 381 insertions(+), 28 deletions(-)
---
base-commit: 1a7882de8c859467ce931ed23761db1e391aeaff
change-id: 20250901-imx94-5c463a9fe924

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

