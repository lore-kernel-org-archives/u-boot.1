Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE421CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBE94845A3;
	Fri, 28 Nov 2025 15:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xP0+96on";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1F10842CD; Fri, 28 Nov 2025 04:36:43 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BCAF83B8C
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 04:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4dUHBTrrDfPDWw7iLADI9v8q0QcHlmgwISXpM8oX8RW51q/VS06r77VDURc29DS0k+3rKegajfRa7karNoWeqVsOZJpRzSiavN0Y1v9zqqB8O6mQzBOQr3jc3oHOeLqSlk1YzqfyqPJqzCtysBe5oFPhIogSw+ORtGWpkuncNrKPZCTUVI7nGjx2Kypd+LCGpVh6Z+fBNmaJzLl5460NXi45c+3AqrFTb8xAUHFEtnG5VdKfrC8u9C/svea/AUWPDyWyvDJhUasj8BW7H0je9uLWTijI+sAYVmkFjPY7QphpGFmhCE3L4U+99+5I4kkmcMCvYZwcNpaUmsfBKGqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24PIrBq4hdh+OcJ4dMWA4uvCyH4YrT+fBqi9fPyCGGc=;
 b=mToBSbfR2sC8OloAkjM5i7NnsHf+qFdYzMkMVtOia4GY27DaQSAyemzeKpXv8TUhZKvZRAEoJ43zF44jGkkIgHqnS5v8yjN27JKrpQK08F0UuybgtghGwnGrJFWtXEW7iomgfGTzyvh1NjnoJkrbvakYSNO83xW5UQBeScRR4sYh8KyHOmTFVSniLALFV7vZ4Sn8Z8dlJu4b2EKB1COiuNpSmx47LuFDAiWoB+8/h7zG5opeueRkJJNsy5ISUxGjloEh8qo5PZfZEXxwuu14XMBw5x+625AeZ8I9NkCfhmRL4/FL+h1ShsSrfwviDTOhm5I704WQC1NlktWIjI/IhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24PIrBq4hdh+OcJ4dMWA4uvCyH4YrT+fBqi9fPyCGGc=;
 b=xP0+96onAMzBQj8K/a20KI0Dh/0vQC3FbSiBHf8gYVXutZ9GsHNEAs0au6JQBrtefgx7JvPawoa4UK3Twd82a2DYkSYeHPdeJuEU7ALBQKTxo5ae1ruUxVWRxe9sEnhiQ6tadDaE+QCI/QY/CetbHfX90rHaspV9ZXikZdW8ElUCIAkw3gp82QPjaBTGyiwFgYSiUBW9B4gQRgk3q9qT0o8GQWu5qweuseTPHNUa55Rnp+MJlHNkMdW1QUtywB0Wb+4Y8S7D+tv5WwqioYAhu37HteoQ+2yHVbkmgQ0IAAAwB9I4aSierT06ZjItrUMVH8uNu3cKdQ6edHEpotUmvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB11474.eurprd04.prod.outlook.com (2603:10a6:10:5de::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 03:36:39 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 03:36:39 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	Pramod Kumar <pramod.kumar_1@nxp.com>
Subject: Re: [PATCH] ls1012afrdm: Stop disabling device tree relocation
Date: Fri, 28 Nov 2025 12:49:35 +0800
Message-ID: <176430530392.3808119.14258296452455169370.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119145528.843285-1-trini@konsulko.com>
References: <20251119145528.843285-1-trini@konsulko.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:3:17::36) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB11474:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd69d49-4887-4275-e31c-08de2e2f56fb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXk5Rjd4TFdyVlljSWFrSWhxZUhrOFROc2pybG1rRnB0a3BLUFZBVkJabXB1?=
 =?utf-8?B?ajljbWQwRC9mUDJ3MkNUdysyMHZLb1oxU1p2aERDRHZlSmMySWJ4dE9wMVhN?=
 =?utf-8?B?cmpjNU1HMkRrdjNyQ2plMmVyd004TDZIb3poVmFJQktJd3p1alVoZFBOSlJQ?=
 =?utf-8?B?T1ROUUpGcGtJbzBEY283MjcxN1hqZTJzQUE1T25jSktxc3JIaFF0dEdDQWFq?=
 =?utf-8?B?K3NNSzlPNHE0d0dFdGRhblRRZzRmQmZibkZDUU16Z3dsMVZnTlVqTnBGZ21w?=
 =?utf-8?B?bHE1aEY2Mi85Y2xuYVBJVDVuS0xISEpFcDBkWGwzaTJmNm8zMWo4QWlIS1lB?=
 =?utf-8?B?UGVwQUp4aTdQekVGdDJJSlR6aTdyS04vSTJkVFQyNUZVVUtLbTB3RmptK2VC?=
 =?utf-8?B?Q3QwazB1eFRxUytHYmoxYTQ2N0VpTldxelhMcng2OVlMRzM1dkMyalVkekZ1?=
 =?utf-8?B?S013WUxQcnlzdnFHZFdRR2d5UllHcnFIa1F3cnBJeEdONHlJVWN5cHprSlQz?=
 =?utf-8?B?QTZId1piZFpTaWhEYTV3bFlwd1MvSXltZnRaMUVQa2R6YUo0Q1djTHVGRXFS?=
 =?utf-8?B?UDZWNDZLcTg0c2MreGJDK29oNFUwTWdVeWRPOVNqNWVXR1RSR1k0ZUsrN0xU?=
 =?utf-8?B?M3hHcWwxcFB5NHREQi9sN1RPUVcxalFpTUh0d0JBL0h2WGkrV1ZwZ3BQdnJO?=
 =?utf-8?B?ZFZnK3QxRy92TTVlbU9CcnNKNEJ5TDQxQ3VvWlVoTkRGa05WakI1aVVFN1pZ?=
 =?utf-8?B?UVo0b1hPTzVyd0NwaEtQMUZTV3pNaHBIL21BTVRJZ0dvR3FRdGd4ZzROREo0?=
 =?utf-8?B?UW5vQkdWbEM4ZG5GM1pjOXdSL3JRQ2orQmFWOEM2bFhrVnlKa29taVFpV09L?=
 =?utf-8?B?WERVbis0TUZsbHRRa0hsNzJIK2pGaUd3Qlh5RVRrTEw4N2hYYmZEV0RBbWhX?=
 =?utf-8?B?SXA5eUU3R3g1blRmK21PZjgrNnVLMTMxdzFiUnRRMWpEdTB0Z053SXFRaUdC?=
 =?utf-8?B?RVg1UjYvVTdJYndrZUUya1Roa2lHUjByMFpVVWkvTzUwRWd2Y3RUV084U3lP?=
 =?utf-8?B?dzBWa0pPeWxRcGJjaXE2THZlNmRoLzVWR056U3NBN04vRDFYdXNSTUhSS3ZM?=
 =?utf-8?B?bjR0cmRSSW1vaElqWVBnSTdVdlo4SE1TK2dWR0JJaFcrdWd1dTRLSHBSU3VB?=
 =?utf-8?B?YXZMSlErZURML25GS0JidCsrQ0hiTm5wRVBqSGRBNkNrZXNibHdUWmxLUVdJ?=
 =?utf-8?B?enQyRDFVTjNUN0xPUmdxMCtQL0NVZ2xUbkVIZlhsZy9LdkRxNTFhaVJRd0Rx?=
 =?utf-8?B?YzZjeVJOZ0djbUt0K20wYWpab0pwTmdtVkg4TUY1Z1F5ZkNLSGkvMXBSOVJ3?=
 =?utf-8?B?a1pHMVd0QlBmVE5WODFBaDJRbTVQQVVEa3BaVGFLMUJpQTFDMHhxWmpINXJu?=
 =?utf-8?B?TGFSMHJUOXVNd0xwOGNSNWk5aDBQd1dLMjA4MGJWaEdkVlY1NXpxZWRDQVQr?=
 =?utf-8?B?bEE5S1cwVTJkbFMxQ0wrcHpVMXZhQlhjOVdxUGlBLzdaeVlmRlhkcnJGT1Vr?=
 =?utf-8?B?Z3NwUVR3V1IrTU91T2FVcGNwSHZhSGw3MnEvc3dMMGN2R3E0VXlQRUNlZk11?=
 =?utf-8?B?cVZzaGpYT0lyT2pOSC9iYmM1WTRJbXlvNlVYVENGZE1pNzlESFRjL2ZrSmI5?=
 =?utf-8?B?R1ZZVjJ3aHVSeFNQVmw0UXpMVm9hOFhvbHR6a1dkeU9aNHdoVFUyYTk5ZXJx?=
 =?utf-8?B?ZlJYeHhMM1NUZjZvR2w1Q0Q1MmNmOU5scjJOR3N2eHI0Umx4bDJTTTlHZUZ4?=
 =?utf-8?B?MU9SUUliMTlPeWFGSDFsWmZHTlcrWWJVc2dqSldJcDhkV3hhOHRmaHZzaHpw?=
 =?utf-8?B?cWhZWlpzTzRHVWdVOHJRT3NMUkptRndUUHZsQkpOZ2U1T1JnRjdzSGgycThX?=
 =?utf-8?B?eWNsL0NaRW9oMWo5Ryt3SEdZV3NRWWJuQTU4WCtOZEw1MWhoZTlHTHRqMzdZ?=
 =?utf-8?B?WTRUVE1ncjVnRS9WSXE4OGs2MkhZSTdGVGFXZDNSYXc1VzJ6UXpzYlh5QXpi?=
 =?utf-8?Q?ClsDbz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzRiR3VuUG10bSs4TXNyRWZMcDRJeGtOYWQxU0poM0VXT3Zta1FxNDJkSllp?=
 =?utf-8?B?b1BQNkswRXlOVTVEaGFzU2FEYXJ0NS8rNW5Dd0pncFVhZkdhR1E2MkJqbnhK?=
 =?utf-8?B?V2dQb0UxQlVRM3RLTjdwVENNRUQ0cU54L0dYTC9UVEpsZnFLZGpESXZxS0pT?=
 =?utf-8?B?MmtGeFBtMjFNd1ZReDdzaG5QR2J1WHBpRG9TbWc2L3QrYXQyMVNLU1NFanlW?=
 =?utf-8?B?anhYWjRvZDNDVkRYS1U3TkxJOXY1V21IaFRtM0tLZ205K0UxQmFiaUZCVXoy?=
 =?utf-8?B?bzdJcTdNbzdPZnBreTFya3FSM1R0alM3aE5yQ2FKbnB0a0JxVVprSUhwcGlZ?=
 =?utf-8?B?NTRvaWZTdVhjU0p1d05wa2JBUHozN044ZXhwdVZiVlZrS0FKYkt1dUtiTFUv?=
 =?utf-8?B?Z0pNci96QlJyWDR5V2NwQTk4ZVcrd0NOOVQweEVVVG9MN3JQNFJGMHJOR1hP?=
 =?utf-8?B?Z2UvOWp4ZmpUcVNFc3VBbXZvMXFieS9IRXpaVGZzamJpeEttbThJTUt6R0xO?=
 =?utf-8?B?Si94bElnNmJMTFJOWlVjV2dMTEcwWnVibW5FQmxKRlpyWWxGN3l5dDR0d3pE?=
 =?utf-8?B?RzJpcUdVNHdGMjhrYzNvcHo0RVVTQlh5OHdvVEQ3enUrd0cxV3IwTm40TVpp?=
 =?utf-8?B?RXIya0FxV3puTFhzajhycFpNR1RHZmZhOWJUQVhLb0xFLzBnWkRlVFZSUU40?=
 =?utf-8?B?R0Jtam5FaGFKYUgrLzM0aG80L1M0L3RMa2R0K1BBeEdObkJpWjZaVm1US1Qy?=
 =?utf-8?B?UTB4Nkk5UHdCc3BjSDBBME0ybWhwOEsyREF3akhTL1FRTXRVeW4waXdydTNu?=
 =?utf-8?B?UGcyQVRqaC9uTHVmZnVxUmEzUFFybVh6VVl3SjhTcWdFc2p4ZGVSNnR6ZytO?=
 =?utf-8?B?RjNBTVA1NEdMcStCdVg1U2dwSEpPWWtOSXVyVWRBV2JnbHF4WnZkTEVuZUVy?=
 =?utf-8?B?ckFGT1RwcURJNDcxZGROcDhYOE9WeWQ4NzBKanJoUytJTDFZTWJITVFJOVNB?=
 =?utf-8?B?dkM4QnZoa0o4NXhvK3h0SXVLTzkwT1hDMG9ZK0ZpWHlqbk41WmIrTENtbWlq?=
 =?utf-8?B?SEF2QW9XODVuY0ZiY001bUIxR2E1QlpmTTJWK2FaVmw1Q0pCOHBDZTRHSUZq?=
 =?utf-8?B?WHN2cm5VU2J6K2UrRTV2TFl5bG5KYWZadm96aWVwa0c0VVNUT1VuV3BJNnRR?=
 =?utf-8?B?REtUdk5hQUlpR0p0cGVHWHNhZ2FvS3p1dzR1cS9VZ3Bsak5sVWhUOStUYnly?=
 =?utf-8?B?NVVWdmNsUjFOOG5ZeGVMYjVibVhQUG9Zc096MWhhWHNYZG1GbXNJaXFhK2lv?=
 =?utf-8?B?QzVMS3BKVC9QaUJLVUF1YkNzaG0vV2JVMlJGcFRicXRsejZnMFBLYldHY0Zw?=
 =?utf-8?B?RUdyY29zeHo4cWR4cGZmdlEzYXZtZlRNazFxUlJ3SFNIU0RpK3FLc0FUVmMz?=
 =?utf-8?B?bnMyVmtuVXQxbUJHdWdPdUNLWWhZdzhpWXkxUStWdElPQlEzbVozRERNYnFX?=
 =?utf-8?B?NmRVbm1BMUVmTDdPV0ZXRi9XVURTNVpRNGpRWnVvZ3A4eVlQNDVKOGxxV255?=
 =?utf-8?B?am1xWWJiMmhPVHJDa2s5L1cwRUpjYnMxbWNPRXBuYmRNem1nbm5vYmh4Sm9k?=
 =?utf-8?B?MW9BK3VqVGNxSzhjNWFZTytRMG1QT1g0QkNweThsY2Q4VmZXb3lWMjV2L0lq?=
 =?utf-8?B?dUVnUEZadjdPZTFuSGV4eTN2aE4vcW9vZDlqcTRsbjZKbEVwbEpidERqbTZO?=
 =?utf-8?B?K3lsa0s0VFBqZmw0ODVXcW1HMDBvMXVxMVNYZUllTktHM0pzcHkwT3F4UkxM?=
 =?utf-8?B?Sk5FK2pwRUt4bDlOK0hpdWNLM2J2d3pPaGN6UUZmbmJkcGZzcDVOU1BQUmlZ?=
 =?utf-8?B?OUJ3ejBiWUdjNDRpclUwd2luNkJBejVZL2F3b25yU084SlBnOStVQ3h2RTNR?=
 =?utf-8?B?dzIvdHNlR29IOGtOUjFDY0tlbG1KYW9zSmxpUkpwTnJ1SGZoUnBTeUkxbzlM?=
 =?utf-8?B?RVNCaWxMR1JLa2RUM2FZaU9mdmlabzZ3cjl5OHJZMjl1czZyUGh6WS8zSEdN?=
 =?utf-8?B?MXdrV1NIWFdybForRFNyTUJ0NGVHT1BYV1pDdGJRK2FJbDRIdVd0eUkzNmJh?=
 =?utf-8?Q?VzNcBOKFCAYMfOOUaqN2WISJb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd69d49-4887-4275-e31c-08de2e2f56fb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 03:36:39.4950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jlNoRZrg+15yMXw+nuUO1HyqIp39a6Kf6QhN8dpUOQVDlx4MqbS0a3VcVmlIIkaYZDbDR49GzbK5xmUn+BFHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11474
X-Mailman-Approved-At: Fri, 28 Nov 2025 15:13:26 +0100
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


On Wed, 19 Nov 2025 08:55:28 -0600, Tom Rini wrote:
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
> 
> 

Applied to fsl-qoriq/next, thanks!

[1/1] ls1012afrdm: Stop disabling device tree relocation
      commit: de5aa0389c3b60d6bc45cc4ec8e3d18decc18014

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
