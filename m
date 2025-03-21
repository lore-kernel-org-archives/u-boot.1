Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4F7C35FF3
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92F5681D3B;
	Fri, 21 Mar 2025 08:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tqOSkQn2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 760E7805C8; Fri, 21 Mar 2025 08:16:13 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18AEE81A0E
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSlMTAEVSInqpapc31d1FKMMhn9KPplsKLrF9uO/hjt2J6kCliH1AVP7PrhYN6mpHgqGMzwEZqXspThu8Z3zhJrkdbSPfqrsxLGxVUwt0RxQoU6+AxuPt4fKhBvTqD+WSug6cITpCNkhSLTJiSN7Xlv+8gw8bO3oqb/Lc7tfxsPRoljM3cWx2RAoaAqdrfuLRUavjUW2J+5e5B9OLSYO/fAQme+S+SuTCnIGAy4hXGiv9Ozps2l6V4fmGGi3EQK1gkZinHpSXPqX2gDM5qpVjYAIS639cXQoviHVOba/ACyxiebsn6vag1PLsZN8NoDaw/CUFQvQxqVywQ5/Ioqy6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Te8lsd/oq8U3N5hXz3eqkMHvzASQjInuewCN/qe1IvU=;
 b=nMaGePneJnsoe3IKcI82f/hywSOiJQkdlYc3Px0a0OvQfF6Pa9JIqj7CAXFtisxj/ZeaFq/tNlFcyGkzki5BiLK8518E1d82/h0c3aT+lDe4MEi5xO1HuCSBvQnq78X8Nu1mi+fUSL5IcLsm8vhq+PgockxeTA7/wdTzAbOxw/dCivAu5fxyQ5w/f0jDY/AH2YlJyOzobzWfq6RmPO5/M39meFzGhq1ruBDy1oornm10r/0/e7vc+nQto7NSzLEi1CC7ds9uhLN9NPYJ+lPGe7zBrX7V0N87SlZzl7cCmd7zHt1gTXJtty5HFtmYG6g3niMIv6mQgk2W2ovbaKDwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Te8lsd/oq8U3N5hXz3eqkMHvzASQjInuewCN/qe1IvU=;
 b=tqOSkQn2hyGHKdcfTaoEAlf/1oKaHR7ZdlJdcmvoYFWeIghb1vwviGZWAyjGRpDqCyxwWjSOK4g6vBavfG+dM0ndLJfLL7qyAxMgEaoQhVXtgg4xoFtO6wWEXidzTZgKrGjOPEoRm43ZxWV7ioCguuEE0vUqJHBjSubESEpNGGaCgS1PlawYkjg39kxQAfa46dxtZ7iufpHX71+VnkbVZCmtJl6upv8SOuJBDCu0FHshFbk86dpOQsN4m04XdcG6+eo6fm+TfNRyIsT5FduMIAMkesIViI0QD28MaG28XsvlLfcl7Fc6LPoDgvTLB1/ymnCZdAsbvmgy2TK4OQPkkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM0PR04MB6836.eurprd04.prod.outlook.com (2603:10a6:208:187::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 07:16:09 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:16:09 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 21 Mar 2025 15:15:18 +0800
Subject: [PATCH v8 04/19] scmi_protocols: add SCMI misc protocol
 protocol_id and message_id for getting the ROM passover data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-imx95-v1-4-f2c8ba815f89@oss.nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
In-Reply-To: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marex@denx.de>, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM0PR04MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: cf79594e-3145-4a4e-82b6-08dd68484107
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTV3R1BveVY3SGM3SnBKdC9NL3FxT25tcG1QVmRWTWFJZmpuM3NLNExvTjBE?=
 =?utf-8?B?d1hqRjZPNDlBOEVtQjg0a05oL3hqc0NsRHl6azJpZ3poV1BZOW1ncS84VG1H?=
 =?utf-8?B?cUJ2dUt2bXZUdElYRzFWNFB3VHVWWG9TV28vU3RpL0tsSGFLa0RoaktkUHgv?=
 =?utf-8?B?ZDlqQW8zeEExcWZXeHZhTEpEa0dXZ0pZMUQ3TkY5OFZPc0tVZG4xb3p2NEhD?=
 =?utf-8?B?NDVVSmJzV1lSTmNQaW1RNElUd2RQK3VKbFJjYTZiQUt6dWhTdVVFSUIwalZv?=
 =?utf-8?B?WHBYSjZTVTNQaTZadU1aV0EybTh1QnA1ai9IUHpuVWMxUW1BWndLWENwL1dC?=
 =?utf-8?B?dmpyNjlnN2hmWlZ1MHF2ZTZPdjkvY0plRU55ckZJaXZpV1h0dHYzRkJkNjJr?=
 =?utf-8?B?aHk3TmhNYmJDQ1paSGRIMXNjcUFnUDBzdG4xc2dmRmJ6V05pUkZwcUZCbnFH?=
 =?utf-8?B?N0t0b1FBQW5NN1Zub055cGd0MEtjalU4U0ZPaTVyWFFPS25GUW5RZzJobWxB?=
 =?utf-8?B?UHNUUnM4RUlmeit5VzBuWlRyUkxoRWFhRGFleGRTMytleU9VeEs0NVQxM0Ux?=
 =?utf-8?B?eEQweVNiQWVGYkx1N2c3VXlWekc3TFA0SkVtN0lyZFlMbnNsMHFnNDRrSmNM?=
 =?utf-8?B?SDJJc3RRWjVQZlF3N1NoWVdtZ00yUlc4WlBlVUUzbldKV2h5QWIxRjJGUG5p?=
 =?utf-8?B?Uks5N1V6L3k0eldRNWdSd1dxckZWTTdrVlBRNTNmbngvSE90SkZXN0xvSVFM?=
 =?utf-8?B?VURsM2hRLzY3QkI1QVJZZzRFRzNVd3JkWWJLVERGSXNBWE9yS2U5cFpwK3Ry?=
 =?utf-8?B?a3FCZTJPNzVFSnFITkhlTGQzWVlNRVVuaVZ4WWUyYmV4cmlSZHFsT3hDSWJu?=
 =?utf-8?B?S3VlYzBqUXRaVkVjRms5cmpZVk5wdDJKK3pCRVcxbGVqcHdOWTRFTEh6Z2Q4?=
 =?utf-8?B?Z0JFOWJyeW5nOU41amc0b3JVYWZnUXAxcDZxUlYxTnJXUzlnQXA2RStjTHZU?=
 =?utf-8?B?TUJhWERCUFd0dWZLcFZ5cm9EODB1dEY2Y1hxSTFiYzQvWUlVNENYTU1wamov?=
 =?utf-8?B?SFBka1V2Wi8ySTdnc2gzTjljUnhXUHRyY1RZWkR3Rnl2ckNEWjdCZklKZGNx?=
 =?utf-8?B?UmwzVmp6eElwWCtpU1hQZDk2dUtiWU42OWRsMFpWZ2ZEQmVxa3hoeGNEekwy?=
 =?utf-8?B?bTNkSGcwYllUM0hiTGVFK2I0cGJnb2ZRbzcyOEJDUkRoVnp0K0toRXc3NTB0?=
 =?utf-8?B?VlMyYlFBVURBSnVMc3hEcC9HS0NJK3liNEdDRkQzVkJPeUpDNnF3azhPcmlM?=
 =?utf-8?B?aitSZjNKSFdGdElGQnlJdW9FcTdrU2ZQK2p0bEEzdDNPS3RTM0lURDduV0FB?=
 =?utf-8?B?SUhLV3VLUklXYXlVam9xQWxQRkhmNC9Qcld6NGhOeVA3djFndDVhNno4K3N3?=
 =?utf-8?B?SHlmakY1Tm85QU8wNFpWdmVhYWRqY0lqWFhpdlkyYTlrRVRNbjhUTkJMcmhy?=
 =?utf-8?B?dk1DWmoyR0FKSCtwT1NFVzNuK3dwM2tJNlRFOUo0OXhEZXJHTXIzOForZENB?=
 =?utf-8?B?UkIvb2s4SDdvR2NiRHF5WFBtNG5wdGdsMjJOTm95QjdJSk96bHRlcitDRVZJ?=
 =?utf-8?B?azFUTk9VblJnSUowRUVIaytVNHNtU3VENmhsTVZaMittYnRySEkvRFpWWUwr?=
 =?utf-8?B?LzZZanVoSnB4SDVTZ1dxbjYrTFhGcjZjNW9namREODNnS3BiQTlTZktIb1hZ?=
 =?utf-8?B?QWtmZm41OW9kTElMY3pwUUpoRnNYOStwKzBYbGtwdzRPNUxvWHZFbmtUT2xI?=
 =?utf-8?B?UDNnWXIzQ2pmT29CSm9xN2V1QVpHNm9WV1k0M1RLN0JrY2dnZkRqMFZMTnVM?=
 =?utf-8?B?eDFLWFVmeDUvd2NkSnh4b2tOWWR3ZzFBeXN4MTY0YVFVbWMzelE1YnFmdjFV?=
 =?utf-8?B?V0hVQjlNcEdnd21SYzdNYlBSbVVnOWhqUm9qblRvWWVhWkh2MjVtZWxzaEZV?=
 =?utf-8?B?OWhybWFjQzl3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGwwVFpuSDhZblhLL3N0MXN6SkwyZysvYlRTQm1wbWYyL3JSTkpQeGhjUmNr?=
 =?utf-8?B?akNBOUZVU2lWanRTQkxiWkhrcmZiTm9kLzdwZTduZFpHSXVhVjZNYk1lbURC?=
 =?utf-8?B?UVVWUDRsanQxK2paUGt1ZEdaQ0RTNDIrUG1GN2pUYTE1djFtcXM5RnlSL2g0?=
 =?utf-8?B?YjlUbXpUQWh2citBNDdFZTZOc21yTzlON1lqK01QaGRQMEtmODM3OHE2WjFj?=
 =?utf-8?B?Qm5ka3JpM3lhOVN0cHM0aEZ3TlNIR1NiSEg1MXRHVHlvOG1IRHJHZzdLS2Vy?=
 =?utf-8?B?RVdqeVZtRUhHVU1TWDNZZEgvTjJHcThqM0RMeVQ1RVhWVjhWUjZGa1RkZjdm?=
 =?utf-8?B?ZUl1bDE0TnkvYk4vMjRvYmVEdVFXR2hmTVovWCt6bG5NbkxmOHk2YlUyMGdh?=
 =?utf-8?B?Q05RS0lIeHlwQXlubHFIV1VWMnVJeERPL2hqYnBCblppMHc4ZHRIY0JHVGg4?=
 =?utf-8?B?c2ZrVWJEYkJNRC8yR0dNVzZ3MWlJNDhEb1dndXowK2o1bUQwSmMwTmUwU05U?=
 =?utf-8?B?bDNkUytVakFZVWowQzZHbFpab0pxcElXTGZsbHk2T2ZFRm5SRFhuRy9nMjJu?=
 =?utf-8?B?a1NzRTFpQSt5SGxkRVluZUFLRkFCeDhZUU5wQUhWWGVxY3NUTnlkQnhhUnZU?=
 =?utf-8?B?WHE5NFlHajV4Y2h4UjNySWdFSHlOOFdqQU9KZEtFcDRCUjhBT0xmUnZkSlR6?=
 =?utf-8?B?eDZva1IzY0dHdURBUnNEelpJL0g4ODZiYlkyVlFwQVgzcGZqRS9lMVhTb3Fz?=
 =?utf-8?B?WXRXK2JVbDg3UHdOTGtlUUkzMjVjQnZPd3pRWHJtcm1YQzRXd1AyUDdKR2xM?=
 =?utf-8?B?N2FPVloyQ2g2a1JWWkhDajJmaUN0UGlnRm1reUt0dnFDaWNLZ2JST2FDRFFH?=
 =?utf-8?B?amxkTWNLOWQ2czJzZ1B3SDJ2OTNiMnVMRkNiWUxnTG9EOTdyeEpSWE1sclJp?=
 =?utf-8?B?SkR2V2hZdzNKald0OExwcm5SRXNHOTlRcS9FaHZCSm5qQXBDY1VhcFBzY0dC?=
 =?utf-8?B?YytwU3pDOFFIVnBlNzEwV2ZoVUkzNko0ajVGNDFFR2VWSE5Nd2x2YUY3OEIw?=
 =?utf-8?B?MXdnZEQwSSt2c0RYZStHc1daVUw3R3hKcndKVEc5VUNIQjVjL0Zib2ZDV3A0?=
 =?utf-8?B?eit2TFFVNjlUcDRVTW9PNzNMQXJ1N3hjWnF4ZmFWRGdJd2FsWG4vYTU2a2gw?=
 =?utf-8?B?cklVcDJYQjhQditNWk1IdjRlNkRYSGxKTGhPcWJwcDljZ0FXbUNoa0k1bWEr?=
 =?utf-8?B?TUJjRFQ4U2FVSjhyNm5KSXNPSW4vUEpnL1lXMExnRVVCblBydlFJdUxiVXdJ?=
 =?utf-8?B?Q0duSXBuNU5rUFJKMUtraHZRQzVOdmNMZzNiMlFNVTJkd1NWYjlEeUtIaXhq?=
 =?utf-8?B?YUNCV3lCSE96YlhsblF0U2Mrc1JLSXdlSnpwc1NGQ1ZmNGx6TXZNWkM2djl1?=
 =?utf-8?B?MDJWSnBwY3dRNHMyYm8xb3BQclMvUmZLaW02bVBkOHovSmhkVTFxYXZMdExm?=
 =?utf-8?B?cGlrSlZOWFpjYmR3dEx5YmxTWGdwbk5jRG14YTY2YlB6c2JOYkZGNnJsNUEr?=
 =?utf-8?B?eVZGWWsvcEFoSnFQTWNZVFg3bDVPMHlJZWNVb050QnArY21YRmtkNWZCTXdK?=
 =?utf-8?B?QlBrcXovYkp6cCtIclJGZEFuOFY5RFVpdGRtbGUyRHVLV1MwanYvWTN1UmZo?=
 =?utf-8?B?UkVWejcwcnNSSlRjSTY1SW9oazJlZkdYUEdnN2x6WEtLQW8vVHlBSlBwUmVm?=
 =?utf-8?B?YitlUzZtVEhTZmlQdFBTRGg4ZTZ4TFpiTXV1eWorVmp2OFlkZVgybHFhMFlp?=
 =?utf-8?B?UnA5Rlg4WmREMDR1Qk9ReCtsQit5OWw1RElNVGRUdmYycDBxKzZpeUlDNFBZ?=
 =?utf-8?B?ZWtCeFhLbithc2JSeFllZVNHVVcydFpBVHB1bG5OMU5VNHZmaUkxUGorc1N0?=
 =?utf-8?B?eXVvT1AzWU9lakthMXA5Z1l1QWZnOGE3ZEw1VThyQjdaUE5ZOXdSNENVZ0xM?=
 =?utf-8?B?djlIT01VZHNVVzc4eWJPazBRSXo1Y3IrZFlpdGtnMTFOSm5DS2JxT1lrR04z?=
 =?utf-8?B?NnZ5NWdHYUlZQmdiRFJxVTNFejJRU0tSQUJFdk12NGN1OVQ4WjZ6cmZ6clc5?=
 =?utf-8?Q?O6bmljo5M983DJuzSIw8bxIut?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf79594e-3145-4a4e-82b6-08dd68484107
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:16:09.5664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyjLIHecqRX9pnMGf+npG0ga4Fw9Tazpb3HBX8JVIzNcTHe0jDQqcT2cPVF8P1nBUoGPLD8TW6GewyJbAbLhYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6836
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

SCMI misc protocol is intended for miscellaneous functions which are
device specific and are usually defined to access bit fields. It is i.MX
specific. This patch adds SCMI misc protocol protocol_id and message_id
for getting the ROM passover data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_protocols.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 279ebbad440..06de4a601f8 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -25,6 +25,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
 	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
+	SCMI_PROTOCOL_ID_IMX_MISC = 0x84,
 };
 
 enum scmi_status_code {
@@ -50,6 +51,10 @@ enum scmi_discovery_id {
 	SCMI_PROTOCOL_MESSAGE_ATTRIBUTES = 0x2,
 };
 
+enum scmi_imx_misc_message_id {
+	SCMI_MISC_ROM_PASSOVER_GET = 0x7
+};
+
 /*
  * SCMI Base Protocol
  */

-- 
2.43.0

