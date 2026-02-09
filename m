Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA68EF06EE
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 01:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 142B683C30;
	Mon,  9 Feb 2026 02:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pjyQQx5Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6C3F83CEE; Mon,  9 Feb 2026 02:29:09 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34EBB805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 02:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnHdIS0IGjakDvLju0cTTbl65p2QgJVV58Hck0FNiAxJmY1uChrfVQiPZ7cBI+R41/dcJuUzxLDQXDd6rFrP40EcA1svOGOleJnbZywt8D6MIS6HRz3pzpC7MkkAXTn3aJ9hzPkjkycctI65vCWB+QOyrumiRx5kc9QfFtvnPqGGyvrtVltVVUUOsJ51JDGXvxbB7y/Y6vwuQDa3bm2tTZRrt+qn0GnZw5CHc06C2MO6vR9EUeG5drqQICPFLJPvaet2tEKUdgMp6rrgK4eyNE4M/4xGr98I2EBGzmvC86RaIFSixjVolRaVDA4weyqXNazGHIUrs4wBFaWiJGtyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPspR1f8x8EmRHTo7a/aAkNO/gymepd95G3Fd1O9huE=;
 b=OU8L7EkZzynd+ryeDcYlypgABMXf7OcaY1Db587uGg0PtQoFe2KTBAXEuRzQYnQM2nzaASNp1vyprH7uK+/SOqU4O8AydfWBbpEXxm2488lD9bA7crxh1/c6O5zZlGWCMDemyQln6W9yMjaCnhz3Ui+RAJyv6dPbED7/DMxSgQnADkYrMRij6cS/eecrfWQ3r0MA9WqUxG0zB4B/U2juQylK3hLNHlBveSCGYpfG2gc+8xhXLcqH/aqnUXksQTUhdew9/02mOZybzF9TMTf1Ys+ybx6UcMDCbbCHeBg5cEKnSzKx85xveWdv2N6hH3BGdectafHrTDUD30AkT81kWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPspR1f8x8EmRHTo7a/aAkNO/gymepd95G3Fd1O9huE=;
 b=pjyQQx5ZK0F2GwlRwp8TaR4BX4+JDLlbjqXLb5j565J9MJaDV/BedZOy12RwCBFFwJXaSkTbemburWuTBEOrPfBBTVioSTPkyqb9ZysGZdUO06xhHnF7bJ08yjl6nvikS5fcRp7fFEDgrGOIjZbWE1fGRw5wlMOwmdQngIcP8XtASer4uPHQFwJHaah+3HpIqHFHy/7Xn/lI6ock1p1cFwlenm/5FgW2flm2GaGY2dR38RQ+EKVFFlvsF3Sgiw9mSJa4lif8+RvjDkD/r0jiuwR6Raama7JFfb8V3wNaYUQifbuTnjs5yFYgAtf2vKv5p55Yf3O1bG75X4XTfomnFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9840.eurprd04.prod.outlook.com (2603:10a6:102:387::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 01:29:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 01:29:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 09 Feb 2026 09:30:11 +0800
Subject: [PATCH v2 07/14] toradex: common: Add missing headers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-cleanup-v2-7-73a3a84ddbdb@nxp.com>
References: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
In-Reply-To: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 35add8f6-f094-43e2-1d88-08de677a9d08
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eE1EVVhaejVoOTRYdCtQWDU4V0o0d3krcFpKTnM1UXhsVGtBZHZxMFZxTC9n?=
 =?utf-8?B?R3JzOGRLMThUZUxEQnMzVkp4UHl3V3o5U3NqcVY1QnRERVVmd0dYZWZpT2Z1?=
 =?utf-8?B?a1VlcmdKckZ4cXM1Y2pGUTZXZXBGUUNFNVhiaW5BTWlMSmsrd1dkQ1gyODdB?=
 =?utf-8?B?VWd2VURjNWcvUGxmcGdxN2Q5MjNVOHJ2Mlh0UVRwcnU5dlBqOHZ3RmgzT3p4?=
 =?utf-8?B?dlZJK2pwUi85T1hHZ1ROUklaUjdBTHFnRE1HTWhHRUZNbks2UHRBRklFK1Yw?=
 =?utf-8?B?Y1ZXUWZCcklURE9SVmtBVEZ6WituSFpaRTZVRHhsQ3laUVl4Mkt0VkFrUDlU?=
 =?utf-8?B?bG5kZS9PZ1prV0JJaWVsb1R1V01FVmpkSGRQV1VRWVVIQkh6RFpoaTREbFd5?=
 =?utf-8?B?VXU2NVJZY3ArTzVvdEV6ZytEbk5sbXdCQ2lqdm9BdW95TytsNFBWWXNJQnIy?=
 =?utf-8?B?dU1EZE5oZ1d4VUpISkNlbjA1ZTVtNXM4Mm5UOEsrWEJENDdCTnBxampSVVdN?=
 =?utf-8?B?NUZnSjh5R0tyNk13bGJKWnRhU0VPK2R5T1lBUkRSL0VlOGtQcE5wakNwaTRY?=
 =?utf-8?B?dGdjSHJiZ0swTW1VaHlhd0R5Y2NoUVhWM2JMTUlJK01xZmtxYlhoZE9BbEF5?=
 =?utf-8?B?QzNBL0xEUWVxTytESmtXbWtEZVRaM3VBcGVZWjZhK2s2bVQ3ajNnZ2pCUnNK?=
 =?utf-8?B?aUVQN3lJVGloSUtvb1VISzRWdjNqa3puZ0JGTzVqam1VYjk5OGs1cXovdmVt?=
 =?utf-8?B?KzRHekwxVjJVVVpKK2RPa2l3bG5ZdGhsbjlwdHNGY0NUVFBLVExXY2RRakF5?=
 =?utf-8?B?OU1GaFdZN1BqZEFmdEszOHV0Sld3RWRwT2dHL0k2bVRScTZRZytHQVlpa0hn?=
 =?utf-8?B?OFJhY1NRTmUxV3k2anExT29EWlRtOVB2UndiQmtqZjVMOVNES3BOcHBGZ29Q?=
 =?utf-8?B?ajd0b3d0bnBtQ1lReG9jM1FvWXhLOGFyREluazRuMmxxd0VQYmowL2kzSHhG?=
 =?utf-8?B?R0hEVDFtNWZHaFhTS2wrbnJndStGL2ovc2ovU1NSWVpUZVREODcyS0hGZUU2?=
 =?utf-8?B?TE1JeXhoblBjNXdvR1RoRTZOKzRjMUtDMVVNMUJCRVk1OEw2WngwY05QbVdu?=
 =?utf-8?B?d251ZUNGZFQ2clE0cnkxaUUwcDF2enZwRjcra3VGMDhITGNDc0F2NkdMenV2?=
 =?utf-8?B?ellTaHFZYXBrRHVPUjdRNEdJTjA4TkJkWnB6Vm05NFJRRCtkeUhzWWR0OTU1?=
 =?utf-8?B?blEwRkJiYm5QRzE0RC9rNHF6TXlGYjdaamZ4bDByNW9xTFNaek5YUlp6c2lO?=
 =?utf-8?B?dkhZZktZRWFTTnNraER4Q29NMjlXcFNyRzdQMmwrb0JhMUhnak84VmM5a3BJ?=
 =?utf-8?B?Q1k0dVp4d1RHcWVsMUhiRXpTVzVyZ3VKNndYQ095cHBrbmR0SEdaa0NNVUhK?=
 =?utf-8?B?VGNnaGlOZlhENElhdXEwc2F3NTBYb2tTYThXY3ltWEE2MVdiYnZCSzNFN25S?=
 =?utf-8?B?V0doVGR1UEsrQ0h0Y3VHTHNHbUV5aW9QU25QK2V0UXcvMktNeWh4LzhhMG80?=
 =?utf-8?B?RTc5NktjeC80MHNSWkZpeE5zeHBIMFlpZWpkUHcxWlc1bDlZSE1TS3ptK1FU?=
 =?utf-8?B?NGJ5cU1VWjBlZWg5c2VTVExxa3R5RG1uemxlVWVZdzhWWW9RbnROaW9kVDhq?=
 =?utf-8?B?aC8ybElEUFBvR2V1Z1FOK2lPQjk5V0t0aVY5OTZkQnpGV0lqQXhqYXgxdkpk?=
 =?utf-8?B?K1d3TVViemJSRmZIZHJ6OUZJUGkranhpTk8xbUEwUzUyK29DbnlZN2pUTkFo?=
 =?utf-8?B?cGNzOVd4TDE5emMvNlJqLzcyN21RcVFFYVBvZHk3QnlmRDFCd1YycDRiZ3pE?=
 =?utf-8?B?QmZJREJOd2x0UlpFNk5ScTFnKy9UYjFPWXpaTWk3eDlpYU80aTM0SG5vQWRD?=
 =?utf-8?B?cDBCYzZlM1BpM1d3OURlVFBKamJFeU16enVINEQ4VGxZQVpQZ1ZhazdWUWxM?=
 =?utf-8?B?eVdVWHVwQkZGb3V5L0IwbHlUSXM2d3lMNnZDQ0tRQzZBVzNKS0xVM2l2Si9T?=
 =?utf-8?B?TkF1WXFuWlZpUnlrUWkvOWd0ZDFrcFRLZ2pOR0tvVVZ2ckhLbkgvbXNYOXRi?=
 =?utf-8?B?N1lQaC8xSzZTOHVjbVEvUDJtZm9qUjF1enAwZ1ZiZi9jZVFFZFVIVWRlUEN1?=
 =?utf-8?Q?M0xoak0hKvYtQa0M/4zO0dA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGYxYWtJUjhEV0QxNHJ5bkpaTENIbCtKeGdmMHFYUmYycHRpNlFOMm9DYmR3?=
 =?utf-8?B?RXY2UCs2RUZuanJnNU5mK2RsOE9raGRUUHVlT2hhOVNZSlRxd1BzamNKLzFt?=
 =?utf-8?B?elo0N3lXYlRsNjFoclNtQ0ZYc3pCeWNQbTZHejJxdENyWEdRU1VTTE1oaE9C?=
 =?utf-8?B?dnBtVEtJdGVPV0FRQ2pJa2xtNXB5dFZXSkZIaHdZclEyQ1dhdFBQeUY1STdk?=
 =?utf-8?B?ZlZNKzMwL0Q5NlZzK2tGNnVqTEo3UzFQZVNkT3hWcXduQjhTWjB0UzBCekxM?=
 =?utf-8?B?ZDJicEpvNDZML2M3OSs4WXFDdkZXRjJtbng2YzUvbVlndHk3REF3UnRGNEpx?=
 =?utf-8?B?S2pubm9MNWFpUVZIWkVyNTdXMUp6c2lmaG16SWgzczkrd096VE9COGIxd0o4?=
 =?utf-8?B?eUp6MGtRaHBMM2RRWmlzNFoxTlRHc29oby9TT3hzUDU2M0dhRE1EbkRuaTNF?=
 =?utf-8?B?THAwU3gwMmk0UUZZNVlsRkJLT2hTeWFmbUIyTEdkZDN1eFNHbmpxcGlPWS9N?=
 =?utf-8?B?SjZoeVM3ZGRZbTR5L3U3Zy9ZdTlCVnhobmNKN3JTWEtCRVUyTW81TVZxNng2?=
 =?utf-8?B?d0ZNaERRUjdoT05aaVQvSC81UjFBYzhOMmlOUW1xWitRRFlUYUZSbldsRTZN?=
 =?utf-8?B?VDJZcnNCZVhRZ2hQYjRjVGtoVzJVTHlCK3d2QTJ3UnhITmZpQWZVWU92aVNF?=
 =?utf-8?B?bklxOFlMMGJWYzFPM3licVlJRmRBelhNdXJyUlZkMlZIN3RVTTdmbGk2bHJH?=
 =?utf-8?B?TzlIcktmSVNidFY1Y2RCN0VyQzNwQnlqVEpheGl0V1NTM0ZsWjkrUXg1VmQx?=
 =?utf-8?B?TUNBR0U2MFpZcEtsZHk3QnFyMU1MaTAza0tGQTdlbG5MUndGNTE2ZktKMytQ?=
 =?utf-8?B?NmhseTBPZHdzWjdBTTBnRVJiUXJRekJQT3JadW9GUkVQWm1seWdhQUIzVSt2?=
 =?utf-8?B?ODlEbG5oTXJIclIwbXg3T1MrK05mOGtLVE5mVEtTZDZETmQ1dWdxeXNPNXF4?=
 =?utf-8?B?WFNzTlJ6OXAxaHZyeDFoVmRGL3MzdU5sTk41S3FMYXZSWUZpSlZZNnNjSjA2?=
 =?utf-8?B?Sm8wM0pqOFk5UjJaSitNNVg2WDJVV2lEaGxLQ0E0MExKdTBSbHNBRE9OTGpl?=
 =?utf-8?B?cWIrcnFWTHMyc3NkS3Q0YUd0bHBUZk96OWxNOGlKQUh5bTdtbkpiMUdRMTEv?=
 =?utf-8?B?elp6dW11eFhieC9jL0tsTlpMWkFUSHVoU0h2ZHpVUkEya0RIcnh6Yjd1VWor?=
 =?utf-8?B?Wm0vKzREM3BLVnBCVjA4WXRBNVFXUk9SaERLSVhMbDRQcVJSbFdETEMxbkhw?=
 =?utf-8?B?TnBwaStwMmM2akxHcDVFQmg4V2lBcnlVcDQ1S2tCMVl5QkZZWWpwNEg5UVZU?=
 =?utf-8?B?ZFd0R3RFdjdYTlJOemR2U3NyVFJQcUR4ZEg2SDA0UG4rbkU5dW1rcklEcXJ4?=
 =?utf-8?B?WDJOZ3hCQkoyYXkzVW1ra0QzZERqaU15ZS9oREhuWnBDMXE5Y3l5Tzh6MjJz?=
 =?utf-8?B?U3RHYlZEVm5rN3JMQXF5QXEzOWc0VlorbEJodUhkaDBTYlFOZUlrUiszUkpa?=
 =?utf-8?B?RTdpa3ZsSnBqNFFUSitSc0piZERuSDlvWnhjVGV6Vm5jOG5hVWlqM2Qzbjda?=
 =?utf-8?B?czc4dHZmN2luQXVidXJXQ1ZxYkJoeDJ4a2s0K0EzVkcwM3UzQ3J1NVRJbkxi?=
 =?utf-8?B?YUV0dXpVWnRoeWpiaUdQaWxZbVpodFlCWCtGR1VOOENXTVl2UTFkTTNWRzl0?=
 =?utf-8?B?ZmRISHBWY2R2WUQvZzFGUmVCQjJiSzNzOEZvMXZyemIrV25nbTgwT2RwbVJn?=
 =?utf-8?B?ZnMzVUFRT0laOFhiUkhqK3JmZ0Y5K05OcitPTXJLaVVDeVNiZHlwNXZtUU1j?=
 =?utf-8?B?VDJtTzExL0dteVJWMWN3cGZwZXp0RDRDVHZoUlErSWZURk1nbHRHYjM3dGZp?=
 =?utf-8?B?dVdtMmszdlIzc1R3SkZsSEZ3L1E0UXVNaEFlcmFsNGoxdkdaQ2R4eG8vUFpI?=
 =?utf-8?B?L1RESzZ6S0M3L2RxeDdoUDR0K0JGdDJud3BEN2hvYTNLUzRKR284WkNyWlo2?=
 =?utf-8?B?VE02ekdmUERzeUJYZk0zS2ZmbDhBVDlSdytYRk04SHM4aEJ2bmZ6V3l4dVZK?=
 =?utf-8?B?UUNmL0JyZ3B1cVRvOEZjTXUyRVp0R0E4a3BqVTZ0QmxZQTRteFBzS1NYeVpF?=
 =?utf-8?B?Q0M1RFc3WkFHZTlRaTlaTi9jUnpPMnhDQUMxRDd6U1JvNldiSDA3ZFlueTJr?=
 =?utf-8?B?R1R0NzArdGFpVXpYdjBva1NiR2M0Y2JDdXhPTnFydFdlQXFQR2k2Vnp3WjRz?=
 =?utf-8?B?N3gvN1VWUHNZNFRrcGhaN2RjcEJieUdRMS94Y01MeVBTenZZSXNtdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35add8f6-f094-43e2-1d88-08de677a9d08
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 01:29:05.2903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9p8yc07euypW0Gu/uBCEGb35nDhq0f7rCEtjLQoRC+PA1QHer9cPDUsyHCy4oWrezdH89ldt5SE0/n3NPcyww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9840
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

From: Peng Fan <peng.fan@nxp.com>

Include linux/types.h and asm-generic/u-boot.h. Missing the two header
files will cause building error after cleaning up usage of
asm/global_data.h.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/toradex/common/tdx-cfg-block.h | 2 ++
 board/toradex/common/tdx-common.h    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index b28033d8332e09d063a6a8ad1d4e334703077f00..067daec0d776070b0b53fc26d1043d6eb781a527 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -6,6 +6,8 @@
 #ifndef _TDX_CFG_BLOCK_H
 #define _TDX_CFG_BLOCK_H
 
+#include <linux/types.h>
+
 #include "tdx-common.h"
 
 struct toradex_hw {
diff --git a/board/toradex/common/tdx-common.h b/board/toradex/common/tdx-common.h
index d446e9f1d5ca7d3d5a1318b389393d28854e2263..db3369a8f9ef9b409c53c45e94aa5f22933a44fa 100644
--- a/board/toradex/common/tdx-common.h
+++ b/board/toradex/common/tdx-common.h
@@ -6,6 +6,8 @@
 #ifndef _TDX_COMMON_H
 #define _TDX_COMMON_H
 
+#include <asm-generic/u-boot.h>
+
 #define TORADEX_USB_PRODUCT_NUM_OFFSET	0x4000
 #define TDX_USB_VID			0x1B67
 

-- 
2.37.1

