Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2378BC3ABCB
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 02:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D887288EA4;
	Tue, 17 Sep 2024 04:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rCT2s5Wu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B692F88F1B; Tue, 17 Sep 2024 04:31:22 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BF0F88EA6
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4q6I0Rpr/Yk1iwCEGdPILJeePj9beuO/UX7OZND64XBwkpqkikfQi/RGoyTxvIVCzCkyEfNzIu2MhiRC2QoEpAWT25hzsqq9S3DfguufSLRUYlKFxGqN678MOaarw7JyB3kEoYG1ludDlHS9pT7mahGkJSTVsOWu5ONRi3VMmMH0n1TORNfLjuAxkjD3Mh95dOefjcZiehlQ9BfK9U5FdFRMdUzUrQnLbEvQt7O9BSEHk/Xo0ydrRBxqC3n+/0gEWLIT1Hlv/r/CNJzXQjdfzpCG1e4esXd4hPNWBfVm+3ozTXog5NNB6xHJWie4ONx43qRon5/KlSBmKIRJlBrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYLgxBcCgvFVhLCk0CE1dak0hYn6A3h9u/Pjwah3V7U=;
 b=EySbUhhTmhqB3072dxjnvPB/kad/lCUP8m4egXLHvGpByfcpbyyp6NUheGmKgX+Qq70m27v5uOzGrfykCCEqQ2G4mNMidBeZLDwSyFS5NRh0IfXjaHiFnaG0uvZCDH78qEUarm1m0DJOffSiib0qRwxI0TbL+dihBRfHsHFO2Jz76TZB5EYpNbKxO8/Gcw0rQInESbO/AJpyEGjrj0gX/rXdklPvmLjpgIcPAbOH7+98Q+J6upoj1TUY5lEn31/PG8LywHenu4hi5is0k7545gq04+CTcVHVOCUsP4eT+xnXfAUnIAyK3tPV6H4i60tbCncXvVWsC1YUlK+70BO/Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYLgxBcCgvFVhLCk0CE1dak0hYn6A3h9u/Pjwah3V7U=;
 b=rCT2s5WuxpB61TPku4d2WzZrmZpS2OATRZkKpPOPxov3fLt0TH8Yw2Cpe+P3ZFC/zdsdRcnzzH1wKJtnGc8GEybnCkhJ3f8StyxpESRQMQDbgwpdOkv+Iqozwcwccsi28nsUVs2tWbjSbtxxbii9FXVObrYhi3ef/K6pdU8bNHvxFqPa02fa6sPOq+SUJe8jgGfLrlfP2bgmtrXwM5VVnM17bHpKhveLZF0xpu/HxghtrfRYzU0J0ybcl1R4d7KUlZf9Q8nsPduIKqAebDS1YsMMF39IlNx9rjRMp5jO04TJ2zbuRj1dWbEiFeHCCI5uckJ9GasdAxuuKy6FY0PPTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10451.eurprd04.prod.outlook.com (2603:10a6:150:1ea::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 02:31:15 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 02:31:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Sep 2024 11:34:09 +0800
Subject: [PATCH 17/21] imx9: trdc: introduce trdc_mbc_blk_num
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-imx9-update-v1-17-4fe8effc937e@nxp.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10451:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea8d9e6-4df2-4540-2715-08dcd6c0cd94
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0pPTVdzS0V2dGRZTHpZM3ZOV29GSGZ5WGpwd2NFcmNyajJ4cm5RVHFEaXhF?=
 =?utf-8?B?QmdNU3E5TE94MW5xTFFkNE5rUUhWV0YzZkV6VmV2NTZrNEdSaVZtVFVMdy9i?=
 =?utf-8?B?UC9sY2pxR0FmSDdnRzRBS0R0anFHci96ZFdrbmw2dUs2YWl0SW56elpQallY?=
 =?utf-8?B?ZGN2cTdFOUxCZjcwYVVkandvdDcrQzdmS0w2WjFSQjFzdXBhZEJJV0pXblRX?=
 =?utf-8?B?MDI5RHU4eGVVM1E2UmxnYkV6ZmY1M2haSUxLU2g5UVo1QWw1NUNLSnUzTXF0?=
 =?utf-8?B?eW1lUXFuQ2JhMU9icCtkcjJ5YW1uRWQ1SGNDd250TW5ZVk5SUThZbWJGaDdM?=
 =?utf-8?B?a1dJTTBBdDFQOUFaWVZYUk5RMG9Zak1SY3hhYXRjYnA2aTZTRHBLRjhwVjZF?=
 =?utf-8?B?alRPTXVxeVdORCtuZ29FWmtncmQ2V2VxS2Nyb0RlOEx0QTdlMG0rZ3RQVXdP?=
 =?utf-8?B?T0JFekc1M0Y3SkNPZUx4dGFKV2U1a1R5dm92aEYyZ3FBYU5kYkpucFVEMU84?=
 =?utf-8?B?dGYvZHovUTFJUXRhR2tPVy9ab2xLbzhIOU1COXoxNWs3RmdnRTdZVHROZUlp?=
 =?utf-8?B?YjF3MCtuWXVGeVJjZi9UNHpiVEd4dzUyZjUxNnJ5TEZRWVdOY1l0dWo4anF0?=
 =?utf-8?B?a3hwZFJiUERpeEd4WGdnaWpEZUYybTFFdTEreSsrQVZJNG5uTEdibHVURlg0?=
 =?utf-8?B?REw3YnppSzAvckk4Y1RKTFIxNU9ENVdZMWV3aWszMjVLbjV6UndzK1k0RFlh?=
 =?utf-8?B?WHprc3EvVnNobVZaYmlhWHkvbFFYZ0lrTE1iZyszUERmTzBPaFo1RmFsWUR3?=
 =?utf-8?B?c1RSU3kxYmFma3d1WFpkZjY3aEtxdHVqcUJ1ZlBMenUyRDhsNFk0OXRYb1dE?=
 =?utf-8?B?SXVheTVPbWN0NDJaQy9BWG8rdnJvUnQydERwaXVtUGpxRzNlTjRCVjNYV3Bz?=
 =?utf-8?B?cnJSVEpNY2h1MS9CeFdoNVVILzljWnBNTEtZQmwwUE90c2FaZ0RWZUV1MGRE?=
 =?utf-8?B?MlU3a1h0ODh3RnB0bE54VUN4cjdKQStzby9PVWZwU1VRM1VqVXREaE1aSUJx?=
 =?utf-8?B?ODJXbGdTTHFXNUlKL3gwdnFYeU52VWZRUEVZL3JOdXh0RGhBUnc0S2sxRW9F?=
 =?utf-8?B?cDljdVdEZ0IxM3pHUUErODZVOXVocUQ2THJJWDhjT2dxRlVyN1FXUmxNSW13?=
 =?utf-8?B?dUNHOTFFOXlvS29KWDBrU3I4YXJweHNUQ0JaNEM0T1NtTkhxVFJzRXk1b3RF?=
 =?utf-8?B?UzI4MjhNZkc4NFJSNG9jLzZGM2FmT0JybGhFNFB6SWhGZ05CMk0wUkhwbFdq?=
 =?utf-8?B?WXdsUVQ1S0ZJZkNsczZSZTQwbVdPcGpGeW9EVVdXVUlYNG82OTRQMW10dStL?=
 =?utf-8?B?YkVKWWRTOGs5L1h0K3ZLZld6dFcrNkl2blN2NWVkaUR6bU9iVnBZbk9SYXNM?=
 =?utf-8?B?UWQ1NjNmR0RxT0N1ZU5KYmhjNkJYSFlkSEVmOWZPeUo3bWhZUm1LdXdqVGZa?=
 =?utf-8?B?ZVBlb3JUQnFhU1JaV3lwK1kwWU9GdlpxUWVKMTVNc2NUUVcycjRWZFJkalF3?=
 =?utf-8?B?VWhqcXdvamRJZFV3bXFxZzRTRi9XdzRKUzhjRWNqUC9USE1Hb0RGdzVCNUlZ?=
 =?utf-8?B?RzdncEJYTUdKMkNPVFJUZmxKR050ZU1oYUNHU1J4S1ZoWU1PclM4YmJWbmdY?=
 =?utf-8?B?VWpZRy9WNDdqUEZZeUZJTENiVU02R0Vqc1pZNmxTa1JKV0lOUXA2YnN4d0FP?=
 =?utf-8?B?UkVlb2xMbVEwS3c0NXlieExMR0Q3WEF6dHdJOE5WTnpOcm1SazBJK2tHRTZ3?=
 =?utf-8?B?L2JvY0RIcjJ3S2NPSkVrQ0hRMktHNFBaZTc5U0NDQ1RCeHVEUFJvUUJYZTV2?=
 =?utf-8?B?RzVPNkx3dGs5ZFpaeTVJMjJ4L2ZWMnBCdFhWc25FSUJxVUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm1UbWdnMmRXd1V3c25rQjRFeElaU2pPbUk3T3V6clNOTWtIRWFKSDZSVUdl?=
 =?utf-8?B?NXhFOTJOcnpoUXRGNGsyajBRWElvdFVlRUZFUW1GY0p0L2lsVm93Vmlxd0V5?=
 =?utf-8?B?L1R0S2xHeWtwMHZCTitJS0Nhd09IQzJXSldJdlNUcTE2VmF1Q3JlYVRBUkxQ?=
 =?utf-8?B?QmtPWTdBdmc5S0pGMDFjc2s5V2FwQTJDMURzRStqRXg3SHc3aldmeFZKbTR6?=
 =?utf-8?B?b28wWGtmUEtvc0VyUlRaNlFVMFZGb05LYUZ5TGJ6TmhEclhpSkF6NzdyMTNY?=
 =?utf-8?B?SmtwQ0krOE9qSG1GVGQwSEdhUFFRNUthRjNkelNCZjVVYThBYkV3dHBaaUlY?=
 =?utf-8?B?bnl2b1p6aFd5N1VhN3BGaVNya1Q1ZWduTS9QUVlBc3NrMFVmVVVlYW43OC8w?=
 =?utf-8?B?dlR4c3JyblRTT1g4NTJmNC8rQVRCTWVpc1I5THh6S2tmeUh3M0JaYWYyOEZh?=
 =?utf-8?B?TVdoRHRaWVQ3VDJ4K3AwTXhVcW9nVWM1ZlhNZHlwNUptUCsxQ3VOWSsvTitx?=
 =?utf-8?B?YUg3YmplMjM2Nkh6enRiL3EwSkNabWN4TTdHYllXbFhPNmRnTytXYU92L1pj?=
 =?utf-8?B?L3M5Z0pIbHRJTUJndWxjNElWOUdYdTBWcG1WNmZUY3BlU29nVjlQYllIcEZi?=
 =?utf-8?B?T1NydjBWVEZwWHFmM1RDNEFocGs0TThuUXNOTi9EeE9hVFZEMy84elYwdEtP?=
 =?utf-8?B?eU9aK2RJRjlIZWNUWnlURmlkNnN2ajZYdUZWdlE1UlEwY05NdjBlTm96WFpV?=
 =?utf-8?B?OUVuallaYU1XZUYzT3pPT25yMDlldGVCcTRCWmlmZ0lPZGhNWUFDOElQVHQ4?=
 =?utf-8?B?dU1rQjdFNElDVHI1TklJZXpBeWQ1Rmc2MGxNWm91Q3ZncVNvYkU1ZE80K2s0?=
 =?utf-8?B?SEZGZGFhZVYvcHdVMTVQYytiQWk0U2J2ZDBZNWpDTFJBRm9ua0RnZmlaWnFM?=
 =?utf-8?B?MEZGTWNnWFdKNUd0ancrYjFjT01rVWFjakRldmx6VzVxOEdIRW55TDBpRE5E?=
 =?utf-8?B?WGQ5QnJUOFA0Wk04TExhWjlZVitHZmJIa0RGVldtbzdYOFA3WjdRVitVQ1FK?=
 =?utf-8?B?bUJCc3ZEU3RkVXZVWkZTa25xMHd5eGpjNmdrWjFKSTVCV0hlNnViSWRGTUVM?=
 =?utf-8?B?TFB5OEtsOHphT0pOWllWWVFmTlM1QVhRQlV4VG13N3BUUVY5bGFaV2xvZCtF?=
 =?utf-8?B?VGlDVC82b0RQSkJqaWdKWUZmVldBa1RCZXdHZDEyMmMwK01Ma05rd3J6aUpC?=
 =?utf-8?B?aTc5U3FtUlNmWm1SZW16a2pSdVZyVUxTMDBWYUhEd1U5WFExTWQ0aUIxSkVk?=
 =?utf-8?B?b3FYMHB3OHFxcmt1ZE9sa3R4TDFycmwwZ3l4cmpOSXN0VE03d2xBK0F1d2Qx?=
 =?utf-8?B?UkhGWm5qNVI0ZEZIWHg3UkhTcDV2RVN1aWhybUZzdVFxRE5xNFNNZC9sV3RF?=
 =?utf-8?B?SnNPcmlzK2t4MFpHZUVVYVRQVXZvL0h0OVhPT29kbnBSMU02YU4xK09HMFdL?=
 =?utf-8?B?eWo5THNqVFFGMVhWaExma1djN3ViZkVvd0l6dFhiNFZMRlhSVlY2dVphdktT?=
 =?utf-8?B?MVF3STY2Q1ZRdEN6a1orT2g5RkMwRWRSeGJYN2hiTFVZdUwzQ0NOTlZ3NFk0?=
 =?utf-8?B?NFRLeVVRMzRCVVc3U0VPMlBzd3NXeXBJbldZRE1BL0ZCWGlRUGdPM0FLT25O?=
 =?utf-8?B?ZjAxOWNRSkVEMjBBM0dER3dCaEVBeHYzcnVGSFI5Uld3OE1HeGxJMWNhOEtX?=
 =?utf-8?B?NzFXenlCWWNtSFRYMEZBekt4WDNpWldKUmdCWTRiMHdSMjQyei83NUgyRlkz?=
 =?utf-8?B?V28zWG9HSG42cVRJa1RrRld3WGVhNlhLQlc2dnUxaU1rVWtWakRYL3dSc2Y5?=
 =?utf-8?B?WE12WHZtWlc3a28rcGl1Qi9UVE1SeEJ4WnVBR05wRlJ0MGxieWh1Szl6K2FF?=
 =?utf-8?B?QnJObkVKUWtFUlVKRUdEMDRYOSt0Zkl0cVF1OXY1SEEwUDBGcVZieEl4L0Q5?=
 =?utf-8?B?YTZhSkxINlJyRkxUZEY2V0V4Nk9leGcrQmVkRGR6bjBvVE5kdHoxc0hvVjhu?=
 =?utf-8?B?Tyt3T1dIUjliSlJtRnYzQTlVb3FZWXBhT1JCNGx2Sml4b1Nob1ZBSE83d09D?=
 =?utf-8?Q?+lUNxbMmNuU7NdiSEY2PpXM6+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea8d9e6-4df2-4540-2715-08dcd6c0cd94
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:31:15.1760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yzHt5VaAB8jhvVkCedXqPlXQk48SMwOljumavrf5AN8HOxeRURNrRms+s4xXyS9lQdOzYp1dXz42iRHoeZS2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10451
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

Add trdc_mbc_blk_num to get num blks in a MBC mem slot, then drop
the hardcoded value '40' for NIC OCRAM configuration.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/trdc.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/trdc.c b/arch/arm/mach-imx/imx9/trdc.c
index ae1a46d1331..ef0f8b52a4d 100644
--- a/arch/arm/mach-imx/imx9/trdc.c
+++ b/arch/arm/mach-imx/imx9/trdc.c
@@ -19,6 +19,7 @@
 #define MRC_MAX_NUM 2
 #define MBC_NUM(HWCFG) (((HWCFG) >> 16) & 0xF)
 #define MRC_NUM(HWCFG) (((HWCFG) >> 24) & 0x1F)
+#define MBC_BLK_NUM(GLBCFG)	((GLBCFG) & 0x3FF)
 
 enum {
 	/* Order following ELE API Spec, not change */
@@ -154,6 +155,22 @@ static ulong trdc_get_mrc_base(ulong trdc_reg, u32 mrc_x)
 	return trdc_reg + 0x10000 + 0x2000 * mbc_num + 0x1000 * mrc_x;
 }
 
+static u32 trdc_mbc_blk_num(ulong trdc_reg, u32 mbc_x, u32 mem_x)
+{
+	struct trdc_mbc *mbc_base = (struct trdc_mbc *)trdc_get_mbc_base(trdc_reg, mbc_x);
+	struct mbc_mem_dom *mbc_dom;
+	u32 glbcfg;
+
+	if (mbc_base == 0)
+		return 0;
+
+	/* only first dom has the glbcfg */
+	mbc_dom = &mbc_base->mem_dom[0];
+	glbcfg = readl((uintptr_t)&mbc_dom->mem_glbcfg[mem_x]);
+
+	return MBC_BLK_NUM(glbcfg);
+}
+
 int trdc_mbc_set_control(ulong trdc_reg, u32 mbc_x, u32 glbac_id, u32 glbac_val)
 {
 	struct trdc_mbc *mbc_base = (struct trdc_mbc *)trdc_get_mbc_base(trdc_reg, mbc_x);
@@ -383,6 +400,7 @@ int release_rdc(u8 xrdc)
 void trdc_early_init(void)
 {
 	int ret = 0, i;
+	u32 blks;
 
 	ret |= release_rdc(TRDC_A);
 	ret |= release_rdc(TRDC_M);
@@ -397,7 +415,8 @@ void trdc_early_init(void)
 	/* Set OCRAM to RWX for secure, when OEM_CLOSE, the image is RX only */
 	trdc_mbc_set_control(TRDC_NIC_BASE, MBC(3), GLOBAL_ID(0), PERM(0x7700));
 
-	for (i = 0; i < 40; i++) {
+	blks = trdc_mbc_blk_num(TRDC_NIC_BASE, MBC(3), MEM(0));
+	for (i = 0; i < blks; i++) {
 		trdc_mbc_blk_config(TRDC_NIC_BASE, MBC(3), DOM(3), MEM(0), i,
 				    true, GLOBAL_ID(0));
 

-- 
2.35.3

