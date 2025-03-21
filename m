Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70FAC35FFF
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ECB381D6A;
	Fri, 21 Mar 2025 08:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="srfgtqBA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 928958141E; Fri, 21 Mar 2025 08:16:34 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7564D81D65
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wu/EZbJGhxT1ys73Z/lmMcmglMyp3kSW2ucqNoErZ7Jvx2Yns2ytIdVKM2/DTJPUFXdVEWqb9Mb6ULSsULqCHCy7femYrVKyukriBQLOaYQTymoaLbGH4asdtqT+qBUWgBpvdt+MBME/yY4lU+2Z2WYy+27uz43yKLH3R+lJeAdVwUni9/muEh+y830W6jqw8fi70a455I5k+com0Y7BROdX85FECiH7gdCw3tu+/IMQ5ZyQV8QwbWc5a0/dw+WASO+xoH3TexUkQLPPJ1bstW/JItr8WJBUvQuc9pIIW0W62xx0NU/BHTUxSnQTHdwqNyGB35QA3qoQE3mLFCPKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usTyPKVDqSQyY5wUBJfGMmzwHYNCZeECnWEC/jdiU0U=;
 b=j8J/seb+hJkjyzsDZ+SGTkREagia1wiJ3RqHLYg/ypF2gs9wWsg4zmIpQBRa4dcPrz6Y+YaiTSiLqgaeZ0zTTufoccVYay04v6GE/b2jfLgc6+LT0qcpcgQoS08bEVnEHUKqGnBL8hBAcxqZcFMAnj0hNSF65iPuQ3LRHKmRA4vRxPk7n2+WjicjTI7CjZ49K8eXj9Xy4/RMU4lcdu1SKK3waMmJNyvxyLpr5OErFWIZ+gjaIQ5oPh7qru2+aT2gZugHYxsVmNtmN4/bxQ+gTZEHx+Kkjj5HJ6Ie+155D5+Gshfbp5DSRShJrqkQpwWx9qeWkY0UZWRcsfrnSs/0Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usTyPKVDqSQyY5wUBJfGMmzwHYNCZeECnWEC/jdiU0U=;
 b=srfgtqBA4kgES9Cb8Z3uPMGVSZvo0/yAibUpdTip2zne4fz7IzbzdXXiiOfHKJZp/ackxPUw0wPoAua/ijaxqrQb9fc/Eto9vV2uWtVjup4K8r9C4bnqLLsT538fSVf7bKsqIaSlgwlhHrArCLeeriDJVQE5wJKqdN/C1g3bSZDUuSTtsEEAIqSyWy743sLUYFVPo+kRCfQjddWlZhkAAvcW1OTxye+okkYDXMJMQ3GbnzimOUaK8/mjfQHhhlPalK28VUXNhiEYdjLx9vu4gkQQ/PPNBHV+lKb4W3twE45LyESdOpBRRvRpP6QfPLBwunYiKYquyvpTp4Czhk5Vuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VE1PR04MB7421.eurprd04.prod.outlook.com (2603:10a6:800:1b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 07:16:29 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:16:29 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 21 Mar 2025 15:15:23 +0800
Subject: [PATCH v8 09/19] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-imx95-v1-9-f2c8ba815f89@oss.nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
In-Reply-To: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marex@denx.de>, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VE1PR04MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e88afbe-9694-4770-6e89-08dd68484d1a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T21JOXNlOUEweE96b2VjV0FFOGJoSXlBYnBHVk5IN3VzK3E0Nnc3dHpxNnd3?=
 =?utf-8?B?TE5CQXhkUGRWb1BlR3M3eTdRY2FLRzV3UytRZU5YY1A4WkhTWjcrNkRPQXda?=
 =?utf-8?B?WVU0L1ExUXprK29kY0hkRU8xZEhaaS9VbGNEQkhVM0NBV1N0UTVDQm5aTjNi?=
 =?utf-8?B?L2FRUUJlcGRmUnpuSXBOZlhRYWV2dnd2cGRLd0NCU0taWm0vb2Z5SXlMZzBL?=
 =?utf-8?B?UzBrRmdtSkQ1bWJUc2pDSHZ0d3lhYks3c0hpK3BGbGpaSExTdC9NaUFIWWxG?=
 =?utf-8?B?VXRUS1hEa2VIQzlCS1JEMzVHcFcrNGZOUkhtOURDUFdQK1Z1N0MzUENzSnRs?=
 =?utf-8?B?QjZjelpteVYrOXIwcStvZ0syS0dlQjFRZ1Q5Nm5kSjgzczc2aUc0bEJaMUJ6?=
 =?utf-8?B?YWd3LytrRFdpY3A3MlRkMzBVcklwN29WaWVWZDdEaTRrc3hxTERmMW5xV1Mr?=
 =?utf-8?B?TndqUWRjZFdlaUpHWi9pVElWVWJmSVcrMDIwKzFYM3VkNDg4NlkzTFZ2ckVK?=
 =?utf-8?B?YjEyM0VaSFgxMnJFTFBXYzNyck5jeC9XRG14bFhTZmJoV1J6ZTBqMFVqVE94?=
 =?utf-8?B?dFIrUXZ4RW9uRHhIZmhEeGpHUlNHSnYyRGVUTitndCsrY2svMHVFOW9OZExh?=
 =?utf-8?B?SmJTSWlrd0dRN3ExcmpndktPdlluWDBRU3lOanhRTTd5aFQ3ZU4rSDN3RUJr?=
 =?utf-8?B?dkhhL2NZQ3d0OGRWeTZBRDNpdXpaK25MRHQzWU1GdjFDL2swNlo1Y0J5SEQ4?=
 =?utf-8?B?WngzZUZ5cStEblNsZHR0cTZ1blcvL3dsWGFCZTZUQmVPSnpsYnc5VmtOeUJD?=
 =?utf-8?B?b1d6MkpObWpTdEV4dC9iSjkvWDVPdFJHajZ0RS80L0p2V1EydFVvZUd1T3FB?=
 =?utf-8?B?OWk0dkFRcW1JZ0UwSFVDSmJjM0JLaHAyWmc5aEI1YUJTUmlrMms2M0xOcjhr?=
 =?utf-8?B?VTFSTnY1RjU4MUVVTWs2Wm5Nc2luYzFKdzVXQTAyK1ZlYTZ1VC9aU2pIUHhu?=
 =?utf-8?B?ekg3Ym8yamR6NWFSUEhuOU9JVHdOOXk2Y0JSYzZ6MFMrdTl1cHVlSTMvcFgy?=
 =?utf-8?B?SEhDU0FlUlEzb0UwM2h5dDJwdFkrUE9TMk5ZTlMvNnFtQXRmcUpJNEs5VitE?=
 =?utf-8?B?YVdJckhxTnRXNUJxZWdzZVlVUGF2NkpORDZUcTI1aTU4b1NJZHpiVjJKS2JO?=
 =?utf-8?B?UWh5TnllbzVtNnh5VU9CajNEaEZuZ2JhN0tGNUFpaVdLcUgyV3A2Vkhka1Ex?=
 =?utf-8?B?WXNCcXNQNWVvbzJBWnExUG14dnl3VEtDam9SbCttLzVqNTlvRlp2UFAyY05r?=
 =?utf-8?B?aTRHTXVjdFJralg4V3A2NHVRTmxSSUozVFFkTW1mdEdodUFrTEduaVdOWkxL?=
 =?utf-8?B?YzJFaFFPMW1NdEExS0NlOXV1NCs2Rkt6MVZ3aG1hS0w3UGV0VmZpNU5hOFU4?=
 =?utf-8?B?Nkl2djZiN3ErWWI2dWE1aWxzdThKZCttVFQwZGt4dURqVWxVWkUrR1lSRzdw?=
 =?utf-8?B?QkprZVNQNk9CbjZOczNvdVFqWEFUS05xOUhtQ1pEUDBZUitGZG5nUkptNEVp?=
 =?utf-8?B?cnhzZVVvS2dPTy9OSndNMlF1b3FBb2ZCUnk2SGVLNWxVWk5ScGlHd2lXOWUw?=
 =?utf-8?B?QzVvdUdtb1BDWmJ2Q2RnUWJuWEh3aC9DVS9uVnFZdG5venl0S2o1TlVsNWMw?=
 =?utf-8?B?bW8rMy9zNWpCaTAxODNVQmlhdHVnb1dGenVyVGJXN2ZDNm5kV3N5YURaN0Np?=
 =?utf-8?B?QnAvM1hrSFVCdmx3ZWZlQlFHYlo3OGJBcTVlcjI5cTFHNTExbk9DMEtNd1Yy?=
 =?utf-8?B?M256NWx3ZGY4MUpsMUcyNHZpWG5ReHFIeUVGNEhMTFRKMkdLUllzaU82MWFh?=
 =?utf-8?B?RWtjZkZiTHlnWUdtOGx2OEVUSGY1WU1tMWNOWDRnUHhudVVSNlY5RHB2UWJn?=
 =?utf-8?B?VTUwYnVtQWJiQy9EU2Q5VlY3ZDVqQkxNYlBXc3o5UnFuVXFUL09rajZiVFZH?=
 =?utf-8?B?MGdxWEVvbCtnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHpCL2tta2xKNktMa0NJWnhOaTNFU2RpMm9PcmF0a2dBNUpTRTJ5Tk9tR0xj?=
 =?utf-8?B?MHovUTJtZUhWVVZ1TVd3cXJsb01IcytobGMwc0VTUkFXR2RmbE04cHRQczU1?=
 =?utf-8?B?MzM3R3F5d1ZBZ01rb1Y0czZCWUV3UVFlYjQ2UTZROFJQZzk2Q0NZa0NGbkdC?=
 =?utf-8?B?RldhOVJTMWZGaXFxTVJucjBPUjkveXd1blJWU053TlF3TDd2TXBvc1d4MU1a?=
 =?utf-8?B?YVlid1huZ0xJVDdlVEF6dVJSZWZxY2t6TTlsclRqVk5tamNWY2NYQVFsR0wv?=
 =?utf-8?B?U2NMZkx5KzBmUFRRZktOUWVKSXA3MnRRT1lpMENubE0yYXhhejFLZFVoeU92?=
 =?utf-8?B?b1JuOW4zSmIvTWZuZlQ0aDdKQ1YvTFQ1K0o2bFo5OTErZEw0bTg4Si84aHly?=
 =?utf-8?B?RThrbGxyZmoyVlYrWmpVMHE2ZHh3Nk93MGZCaGtUVmJlbkhHWWdHOFJnZVRL?=
 =?utf-8?B?M0xzWVJ0ZElPaVBueHNMK2N6Uis4K1d5b1oyeWxMTFhGdWcrZitRTmFkcnQz?=
 =?utf-8?B?ODFDbklpUUMrU0pnMU02RGZIMk5YYWdUNHE1bjZlRktBV0l0b2ZYY0N2anRM?=
 =?utf-8?B?NDRZWnhWcnlNa3pidkFOSFVzV2hhTlBFOVlocFJOeWNObVVraEtWM2tqNUN1?=
 =?utf-8?B?SEp5eTRUUERmcWk1UUxUQmFXTVRTNTF2UlR2N1FaUkk3bjN2SUJyd2syV0Y3?=
 =?utf-8?B?RlNtVmhyMmZONk1qdUZaamx1bWZ0Z0hQSkQ5dDNwSHYzV3dNc2ZzU054cFpz?=
 =?utf-8?B?VkVkdzFrbWovbURqbG1mKzBjQXdEanlySlpFT1UybDZGRGJHYTh6bUpGMlox?=
 =?utf-8?B?U2R3RndBYkl2WXdNWk9ISjNYV3JRb2s5QjFFN0xBMlZMQ1l4R0N3eU95aTRl?=
 =?utf-8?B?VnhhVnlXZlNVd3lyRmpmWEN3U3N5R1VBOTZ0a0QrT09WbHNYZVdBRnJXZEdp?=
 =?utf-8?B?aUFpL0VYaHJkaDNKS25RUkVFelVwU2RwNG5OL1hSOHpReTZmRkNLT3V6N1dw?=
 =?utf-8?B?dWswcVlEb3J5LzFzMzJGeEV6bWxFT1hQTnhvdWZQWktId3dWeFRCUHBBOGty?=
 =?utf-8?B?cnJLNXkzN3Joa3YyL1dZZjYrK21JUmpRVU1aSXZ5TzFxS2RudGxsZ2dMZUw4?=
 =?utf-8?B?V2kxSGFyUlg3RDNUWHFXbWZNSFdTRHVjZDU5VDFkNHFZOFZHQkJZM3crcHBY?=
 =?utf-8?B?UXpWN0dqWWEvVFhpL2ZiR0R1akhkRWhRRGVidE9tTUhyZTlLME43UmRIeXM5?=
 =?utf-8?B?bjJORDBOcFdsRG9sMWFQb0NxWkVkOTBHSFpoMlJkRXBqSG0vZHpPZDE3NWVL?=
 =?utf-8?B?K1BZbkxqeC9RUHc5dzZZRVNyb2FsVEhEUHEyblN1dXROcmtQWmsvdHc1YVVM?=
 =?utf-8?B?akQyQ0FNdlFzS2tWRVl6VXAvSHBDbW1mUUQrRncyOTNZOGtRcHBrVEdiY0d1?=
 =?utf-8?B?ZDNFaW9nNm9xT1gxZkIxVTF2SVY3TmVzUW0vQ2xjcHVqRmRmVWlucklVMlFi?=
 =?utf-8?B?NmNEQm1Ubkt3aEVhZ3Q3YmRMNkR3V3JQMm5nOEVhVDRybHpsSmR3V3B4ZXZk?=
 =?utf-8?B?dy9BaGxZdUxoTDdCYkcybEhiSUJKdmE4TFNvU3NsaHUwVk5zajc4Y3lTTUxB?=
 =?utf-8?B?TjM2OEgyVWZvT3hCWHhKbWZRQ1FlL2liVEhWK0kwa0dLN0prZy9ScElaZ2Yr?=
 =?utf-8?B?Wjk4NUFRVEdPWDVZYmlteVlkTE1PVmJrakJrMm5NYXl0dFNrYlRzZlBMcGVi?=
 =?utf-8?B?aFg3VkQ0MWRVNHBkWHFMY3BFQ1ZUZmowUU81Wjkwc1p6ZVBpTVE5VW5NS0M2?=
 =?utf-8?B?aTNzYjkzbE5oamQrTzlyZHZOOFZDSHdmRUVIY3VVUGRZckdVUXUzdnNpc0Rw?=
 =?utf-8?B?ckdveWR0c0MwMnFlKzA1L2RKUDMybWpXV0FxUGMvSmt2NDhSb1o5MGRuNHZU?=
 =?utf-8?B?NXhlTHdrQTQybmZxc3Ywb3AzYU1BUzJUNGVrMlZZM1VwREphc2Y5SWYvcnYy?=
 =?utf-8?B?ODlaeVVlQ21pYjlvY0RPeUErazRMdnBDRDI1RjE0M3hHZEpoUXRvM3hCbVNv?=
 =?utf-8?B?VmlneEZzaGp5aEFYczk5ZjhsQjVNMzUxeTBwckFnOU0zbW40VFlYYjlxdnN0?=
 =?utf-8?Q?CH1azCVWYa6wFX6Gz9jBbz6dC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e88afbe-9694-4770-6e89-08dd68484d1a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:16:29.8018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dDzwpa/o025eOyB6lXwxi7qDEdmjZpDC7z6ZzpYfR5uXTJnQqiDjiWxBkV+Z4HnJBRZK3i1VtYhlaPITQ0Kbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7421
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

From: Ye Li <ye.li@nxp.com>

@protocols is an array of protocol identifiers that are implemented,
excluding the Base protocol. The number of elements of @protocols is
specified by callee-side.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/firmware/scmi/base.c | 24 +++++++++++++++++-------
 include/scmi_protocols.h     |  2 +-
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/scmi/base.c b/drivers/firmware/scmi/base.c
index f4e3974ff5b..3943d90fd40 100644
--- a/drivers/firmware/scmi/base.c
+++ b/drivers/firmware/scmi/base.c
@@ -258,7 +258,7 @@ static int scmi_base_discover_impl_version_int(struct udevice *dev,
 static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 						 u8 **protocols)
 {
-	struct scmi_base_discover_list_protocols_out out;
+	struct scmi_base_discover_list_protocols_out *out;
 	int cur;
 	struct scmi_msg msg = {
 		.protocol_id = SCMI_PROTOCOL_ID_BASE,
@@ -268,7 +268,7 @@ static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 		.out_msg = (u8 *)&out,
 		.out_msg_sz = sizeof(out),
 	};
-	u32 num_agents, num_protocols;
+	u32 num_agents, num_protocols, out_size;
 	u8 *buf;
 	int i, ret;
 
@@ -276,22 +276,31 @@ static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 	if (ret)
 		return ret;
 
+	out_size = sizeof(*out) + sizeof(u32) * (1 + (num_protocols - 1) / 4);
+	out = calloc(1, out_size);
+	if (!out)
+		return -ENOMEM;
+	msg.out_msg = (u8 *)out;
+	msg.out_msg_sz = out_size;
+
 	buf = calloc(sizeof(u8), num_protocols);
-	if (!buf)
+	if (!buf) {
+		free(out);
 		return -ENOMEM;
+	}
 
 	cur = 0;
 	do {
 		ret = devm_scmi_process_msg(dev, &msg);
 		if (ret)
 			goto err;
-		if (out.status) {
-			ret = scmi_to_linux_errno(out.status);
+		if (out->status) {
+			ret = scmi_to_linux_errno(out->status);
 			goto err;
 		}
 
-		for (i = 0; i < out.num_protocols; i++, cur++)
-			buf[cur] = out.protocols[i / 4] >> ((i % 4) * 8);
+		for (i = 0; i < out->num_protocols; i++, cur++)
+			buf[cur] = out->protocols[i / 4] >> ((i % 4) * 8);
 	} while (cur < num_protocols);
 
 	*protocols = buf;
@@ -299,6 +308,7 @@ static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 	return num_protocols;
 err:
 	free(buf);
+	free(out);
 
 	return ret;
 }
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 519b906b4ce..9046de7e3e7 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -145,7 +145,7 @@ struct scmi_base_discover_impl_version_out {
 struct scmi_base_discover_list_protocols_out {
 	s32 status;
 	u32 num_protocols;
-	u32 protocols[3];
+	u32 protocols[];
 };
 
 /**

-- 
2.43.0

