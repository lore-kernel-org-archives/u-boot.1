Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA465CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 03:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A17AC83B8F;
	Fri, 28 Nov 2025 04:26:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DDxZPsOj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E97A83B99; Fri, 28 Nov 2025 04:26:45 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB26083B8C
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 04:26:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLAoPtjgMllgETTMUwL6W6XNbx50CqsJLifC4UfcKIyeqgwC2rMNRF6ojbTZr13QP/qjwzU3TGak4HeHLEr8GcNk2o7OwRD5/SwMpy9pDRv8TDZqBppS6Z1ef6pCaHr5hmDApkrN/cbO1/T8wsr/WTgvopXskYlyFaUyMSimVf6Jn3dgghtMTfRdEMN73+GqUtV0rz/1Ku0fxq1XM17J6Ulcr3q0DPxZ/p/CLWBqouet+o7jnNqS6gIwiVxugiwAk7zonqqcRgBPrfqrClkdrl5SDtRcT8Rvky6sj5RoSSlW2tCBBnGwtj7kdrVbMnS4Te5Vk7ilCTGjI9IbgSQnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CW4CsFk37o4fHNgBhCcopsNj77UZ3FkAhu4Tit04PAs=;
 b=vulis7f2vWnha1/gqXl3f/0eP7J/dTJ/k/o5k3KGvHLneSI01zxGPbh9WmwUvGSbJ8BjXHNOZ/i1tVBlv+S8db1nPXjBG9PXX2pF2xPzyba10PERz4gXjJjCwCJekyqcxpvC2p8jbMrEbR1H+BFg437CZWhyfvmZ3z1Ul7J7ZmIA13LrpbMHGMaRGx5asETDIWZ1Yg8aFfxLlyEvXhenqVXtiBOZAYF3lDJsPnOjg5bdATIj2jNi1QOQ80vZyUdhMC32eKpYVEJybOnrPVtXCsYosvbfXNP1WyX23aWkEjZaPW89kc74bU4J/IqidoA/fzncx1NoBQYQH619o3NcDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CW4CsFk37o4fHNgBhCcopsNj77UZ3FkAhu4Tit04PAs=;
 b=DDxZPsOj/+iJVaj3I/9hZNOK1MIXCnxP1EkeMxK3Slyo8fB97A5peiCxPS+k2YbomIc93gV6mBkRxiIJwtW+vH3ZSERKfvICcVuVd92JdP+23mb84fqzwQEBchP3cptvO2QJlyKJqzxQPckADRmyTmT3tbcw2vUN0gi/NICDAosYfb652+eq+FtS+DWypEjIYhLkUB+IXldKUG4xt6f8xttdcF3e9dLH9WQNQCz0sJwdl/zQ+LPNMWUbG4U1jYQ41ZgSOg31T7b69qm4YLGRHzn8ezCdcXT3vc/9lJn0HFeMJbABvdhbVLm/hAGux7p8jStk0XU1Y5stZlsFsqQn1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by PA2PR04MB10185.eurprd04.prod.outlook.com (2603:10a6:102:401::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 03:26:38 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%6]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 03:26:38 +0000
Message-ID: <3da2565f-523d-47df-8202-0624bf0a445c@oss.nxp.com>
Date: Fri, 28 Nov 2025 11:26:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] imx: container: Eliminate IMX_PQC_SUPPORT
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: fedor.ross@ifm.com, =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <joao.goncalves@toradex.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
References: <20251127192633.79935-1-marek.vasut@mailbox.org>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <20251127192633.79935-1-marek.vasut@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0036.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::8)
 To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|PA2PR04MB10185:EE_
X-MS-Office365-Filtering-Correlation-Id: 09fc5fa5-556e-4508-304c-08de2e2df0c5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|42112799006|19092799006|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlErZy9RWkc4UjhmSTU1dTdlUm9qci9TNEZPMlg5OS8xWW1Zb0poZTFtWTBx?=
 =?utf-8?B?OE4rNU1mOG9XaU0zdUVzcXhZMGRPK04xbUlDY2hWcWkxa3o3TkNuUGZoU0I1?=
 =?utf-8?B?UFRORzdYR2JGNU1DZzJySGhPdU8wMllKWXBhcnRMYTlyWDY4Q1dMenl1N29E?=
 =?utf-8?B?b3BadjFhRUZ4ZEpTZlBVZ0FRZEdYZTY4NVJ0SDkxMkJEbnJDdngydUVJMkFH?=
 =?utf-8?B?MmhuaWhvNGh2eForcnlDczg1azhzVzFZb3hIN2pvVjVlWWVSUU1TVk5IRTZL?=
 =?utf-8?B?Y0dmamp3U3NXYUVpUXZmNWQ2VU9kYWh4bzZCZVlzNDNxeGNSMWVXTGpJVUVB?=
 =?utf-8?B?aWFuc3NaQXRvT1hkRCtWTE1tNjBpZmgzbWdZdDhnYSs4bGcwWG1EN2hYNC9B?=
 =?utf-8?B?VWNxR2xja2wydlQreWJZSlJPZVM3R0FZRmh3SVd5QWlJbU1LbkZ4dDZERUxO?=
 =?utf-8?B?c0o5ek5wOGVvd2hIbDducjVQcjRnRFlEMEFYN2Jxa24wb2NkMlloQTRFMU85?=
 =?utf-8?B?dW1qTEdCNE5GKzYycnhjOExsRFlGMEdkdVdNdHpGZ2lWVFVkRU15ZU5WUzF6?=
 =?utf-8?B?c084UThJQk5LMjFMb25IaWZGbDZxK1JtV0t1N1hvRGtCNFI4MFNXUm9wajZi?=
 =?utf-8?B?WVdqVXdlZ3ZpS3FHak5HUHlVQ0E0ZG40UjFoYk94dnNJRjhIN3V5S0NRM1VC?=
 =?utf-8?B?OUVHV0NSTE53cGxPUGg3bUVRbkNLTHB5SS9NdzdtVnc4UlRsWXYwSU5DQUFI?=
 =?utf-8?B?ZURsTEtVL0JsRUV5c0k4bkN0K2Z5amt0aUgzdG1PSVovSS9RMlpwQVdTWG42?=
 =?utf-8?B?K2t2V21CKzQxWnNkaFNDNFRzam9EMmRqYkRqYy9HdU1DNnF4VHROSUVpV0lq?=
 =?utf-8?B?MTdMcWdqSXZDeUJXL2JWYUFRekJBVkx4ejFuVmVVQUJmV1hDVFE3d09Kd1ph?=
 =?utf-8?B?MG9TNDFPeDd1SEk2UENjcGtoYlRxUDVvR045MXBpakcrOENxNGZLZjBnZldw?=
 =?utf-8?B?V1RROGlGRHIxZ2tIRG81WlJtNFRSUGYzaFFySUJRRlNqWlFsdzVvMjAxRmpD?=
 =?utf-8?B?djZsczBrbVlJdEx1QnFpSDZVdU9xdEtiSGFvQUliOG85MStlZ0tOWVlOYjQv?=
 =?utf-8?B?YmtvQjd1cVlvbDllM1VwcTcySFBES0VOVDNxVTFYZzg4SEUyODFFaUdpaXh0?=
 =?utf-8?B?ZmIrclhGbERiZEpmVzVyU1RnQUVrR1RPeDhlOUJZd2hjZzliZ2VQV1RxWi9n?=
 =?utf-8?B?djJYbmRreFovNU1IZ0lta1ZnRHE1T1NvUVRrUytVa0JDYzMyZk1odXlJSHJD?=
 =?utf-8?B?YjdMT3FuZGFjK0ZHalE0THdhM011YVJkd3VPamtXMm96d3l6M0pZWnA4a3F2?=
 =?utf-8?B?RC9BYnhMR29kazZJMjZGMEo2bm1MZnB6QU84YnlMaC9ZUXZycEtBUk9HQmM0?=
 =?utf-8?B?a3ltcHVFZlc2TVplakFqc1JrSnFYRGEveXdZeWdISkJPZGRadmloeG1aU203?=
 =?utf-8?B?elFXZXk0TkdwNEZXb3l4cUFBTmJOWi9rdDA5RDBZTlFyenMyTjcweWN0dG8w?=
 =?utf-8?B?dEFRVEhHb253TlV0Ymt6VCtVZWVOYTNCbGVvRXlrMG03R0RBZ3RLSkFPaVFx?=
 =?utf-8?B?OU82RWt3YjExb0hleGJYV21aMlNYVERkakVzNUhjQm9KdG8yNEFsZTdseXcy?=
 =?utf-8?B?ZXQyaWJTMExDSGJrWW9ibDdEeHVDTCtoUHRodVlvZkdTQWx6YTNMbStFVDVT?=
 =?utf-8?B?ZEFwSjNDYUhRMXlQaW4xREdIWDh3NFA2c0VxRk02MUw3Vk5Hb082N0dUaVlp?=
 =?utf-8?B?alMrT3crc0hqTndvSE1Nc082aE5CRkI2SGQ4UTZ6RThrUlBNZStmY3dvTzNo?=
 =?utf-8?B?UGF2OUMzS0U4YVhKWUNtZktEckc4Unl2MjlHZFdRN0dqdkYwdXNrSFhGRDdz?=
 =?utf-8?Q?2rodaEpCk45mLaS572wqu8vf3jtjFy8G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(42112799006)(19092799006)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVRyWmxtTU9zUEhGR29PamdKVmQzcGVURWdmZjQwVEFsVCtwUURuR1lGWk96?=
 =?utf-8?B?VVA0NkpDelo2SWgyRFAwTGZmTDREV2p2NkNvVzlFR1BzeE9PN0Eyeld3WG92?=
 =?utf-8?B?aFN2RnBJYUI1UmxZUmg1SDZyMFFIUTBMME1COTN6RmVSNGtSWldZMzgwWmFq?=
 =?utf-8?B?Y3ptRGoreXV6cTlSOXVnbXhUWU5hdnRUSnVQQjBxSGFjZDR2TlRaSkp3MlBx?=
 =?utf-8?B?dkJhYStrSnQxZmNiU1ZSWWF6YXl5YW5rTC8yNXFxUnZuSVZBME9jN3doOC9h?=
 =?utf-8?B?SGo2RlhLaWM4QTkzenIrQXRBMklHZFRmMjIxTEs3bEV4YUlPcHV4elJWSlZF?=
 =?utf-8?B?SGVhRFBpUmR3S28vczBoVUVRa1ZRWmh4K29Gb2o0Z09JVEIxRHY1YkN0MHZC?=
 =?utf-8?B?OTI3Sm1aTDNqTlJTK0FSNGkwMmFLNnBOQ1NXT2NGbjR3d0JxN1hkbmY0UTE1?=
 =?utf-8?B?S1E1aFpvOWpmc1ZGakhEcWpyWkpyUG82a1F0VXdFUkRJeUhDVHJ3NUZhWkRQ?=
 =?utf-8?B?Q2F0Ui9PTTN2QlZHV1AxY3dwM1ZrZGs2WThIYkhycUErK0p2SEo2WEc5djJ4?=
 =?utf-8?B?bGlRdzRtakNTVnlScDNYTTB1M01teHltRENiUGI3Z0lXOVFNL1JsdWlMWEtW?=
 =?utf-8?B?OWZGMkg3dXdMWE5RTjN4UTNMS1hGcUhHWkVCN3RTU2g1bFNWa2pMZ0lvVEJI?=
 =?utf-8?B?NVBZZ1p6RkdXK2tsVmV1Y2xKS2N2OWNGNHJaRCtsZE9rSHZ0K0dVeDUxMEFr?=
 =?utf-8?B?c0hmUTZtSjFKQVBuVUZ0MUNmaTVPS0FVekYrUU5iS1MrenJaNXpIbURkOUtC?=
 =?utf-8?B?bDNwRG5EWGpWWi9rZ2Q2S0cyK3FJVzZibDVMYW4wb2lRYWs3Z3pLR01lSTdj?=
 =?utf-8?B?SDJWV00wSEsyb3JQWGM3WWl5VkhRcHBqb1dpU2JwZTYxdUx6ak1aWTIwNXJ1?=
 =?utf-8?B?YWNwUkFCNUNQS0t6ZzFIT2ZFVW1CdFhDRVkzaWxKaTBHWWVSYTBqZVFaZnJJ?=
 =?utf-8?B?eSsyeVVSdEw3ekw2OWlrNkkyV3pFanZpUk92N2ZkODVuZm5ESlpRRzhnTzl0?=
 =?utf-8?B?ZFp4VngyY2RLdnYxYTFERE10NDR0bDU2MVZQeW1zY2lVbUVWNGZHWUN0bSts?=
 =?utf-8?B?bE9mZVIwWk9yU09yTHp3R1VDdytIUXB1d3JDZFhiWVhiSklXSnRoSVJJZUNS?=
 =?utf-8?B?aG0wOG00OVNUWEQ3SEg0dEpaYmZUVjJ0QXdDbk00Q211dm9CNmRpYjd3VDNG?=
 =?utf-8?B?SnRRSk1SenUzQnREUzBab0NudHBSMGxRVWlYWTNndEE0OTgyRjkyYk55ZzNy?=
 =?utf-8?B?aWZLN2JNeHRINDdzZFhiaWhBMGpzUGI0eENSRldmZE9NUTdzVlo3TGZDWGF1?=
 =?utf-8?B?SDJOellLM2xUNndaV1ZFREFNVnBlS2F0ZTlrQ3FWMVNNekNCMWwyVjlXeTZS?=
 =?utf-8?B?enpOTmxKR3FYVHNVOURPQWgzRUVqYkZDenZtajQrM2tuWXBETHhrdUQzblRW?=
 =?utf-8?B?NCs3M3pEbGZDUmFMWEsrcHgrbmVRQmwrbi9JVXFURi9HWDAyMVY4Qjl0andu?=
 =?utf-8?B?Y25yU0tiMWUyZEE5czduVmlKZWNrQ254dDJXdldoLzVGUks3L01RellFUDlh?=
 =?utf-8?B?M0szNDAzbU5FbDM2QnBFa3pMa1hlb0FIb0YyOEI2UFh0RCtjb1Q0NGl6SW5M?=
 =?utf-8?B?VVgxaHEySlVWUlBMVE40czgrZ0RhTmJTZi9xVThsVjkrWUF2b2FQZHpycldH?=
 =?utf-8?B?eWlEQlBtMGJEMFNUSDRDRGMxYkpGb0hYNFhMVUhkcWovWDFTeGJITzgxaFJn?=
 =?utf-8?B?VzhUV3ByVmg2ek1JbEg3OUROMVpOQkFQTlE3VjljVEdvU1gxL01ySmh0Ui9X?=
 =?utf-8?B?M3BmeTluVzRBTk84YWVFL1E4NS95Rlhrem5tdEVBNkQrZDVnOThtVEZDbGh4?=
 =?utf-8?B?WFp0bkMxOXRLVXkxcGhiRzI3VlJWemRCTGxtWmQ4YjFpT2xmNmJIYVNvSHQ3?=
 =?utf-8?B?cVFDMmNWckhXTWJmRHIxS2hIckN6TXpPUmJnS24yTURrZFVSWEFRZVQyUWht?=
 =?utf-8?B?YTh4b080Vk01NUZ6MjF2eG5yQktmcEJPMVBYNlFBU1JhUkRsNEhIVnNGb0Ra?=
 =?utf-8?Q?KxdW6euXPetzBiMr91gVrFwap?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fc5fa5-556e-4508-304c-08de2e2df0c5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 03:26:38.4917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIeK2M9ef5zEsf1E59+nFkHslHAA1rpF03DCxa8Bze3TvqpHdU/sO7mIcA7JboaJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10185
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

Hi Marek,

On 11/28/2025 3:25 AM, Marek Vasut wrote:
> The PQC support is available on i.MX94 and i.MX95 B0 and newer.
> This can be detected at runtime using is_imx94()/is_imx95() and
> soc_rev() macros.
> 
> Eliminate IMX_PQC_SUPPORT and CONTAINER_HDR_ALIGNMENT and make
> U-Boot generic on i.MX95 A0, A1, B0 and newer once more.
> 
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: "João Paulo Gonçalves" <joao.goncalves@toradex.com>
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Alice Guo <alice.guo@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Jacky Bai <ping.bai@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ye Li <ye.li@nxp.com>
> Cc: u-boot@lists.denx.de
> ---
> NOTE: Compile-tested only
> ---
>   arch/arm/mach-imx/image-container.c | 20 +++++++++++---------
>   arch/arm/mach-imx/imx9/Kconfig      |  2 --
>   common/spl/Kconfig                  |  7 -------
>   common/spl/spl_imx_container.c      |  7 ++++---
>   include/imx_container.h             | 23 +++++++++++++----------
>   5 files changed, 28 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
> index 78f2488cf6d..59169db2fa0 100644
> --- a/arch/arm/mach-imx/image-container.c
> +++ b/arch/arm/mach-imx/image-container.c
> @@ -131,7 +131,8 @@ int get_container_size(ulong addr, u16 *header_length)
>   
>   static int get_dev_container_size(void *dev, int dev_type, unsigned long offset, u16 *header_length, bool *v2x_cntr)
>   {
> -	u8 *buf = malloc(CONTAINER_HDR_ALIGNMENT);
> +	const int hdr_alignment = container_hdr_alignment();
> +	u8 *buf = malloc(hdr_alignment);
>   	int ret = 0;
>   
>   	if (!buf) {
> @@ -146,7 +147,7 @@ static int get_dev_container_size(void *dev, int dev_type, unsigned long offset,
>   
>   		count = blk_dread(mmc_get_blk_desc(mmc),
>   				  offset / mmc->read_bl_len,
> -				  CONTAINER_HDR_ALIGNMENT / mmc->read_bl_len,
> +				  hdr_alignment / mmc->read_bl_len,
>   				  buf);
>   		if (count == 0) {
>   			printf("Read container image from MMC/SD failed\n");
> @@ -160,7 +161,7 @@ static int get_dev_container_size(void *dev, int dev_type, unsigned long offset,
>   		struct spi_flash *flash = (struct spi_flash *)dev;
>   
>   		ret = spi_flash_read(flash, offset,
> -				     CONTAINER_HDR_ALIGNMENT, buf);
> +				     hdr_alignment, buf);
>   		if (ret != 0) {
>   			printf("Read container image from QSPI failed\n");
>   			return -EIO;
> @@ -170,7 +171,7 @@ static int get_dev_container_size(void *dev, int dev_type, unsigned long offset,
>   
>   #ifdef CONFIG_SPL_NAND_SUPPORT
>   	if (dev_type == NAND_DEV) {
> -		ret = nand_spl_load_image(offset, CONTAINER_HDR_ALIGNMENT,
> +		ret = nand_spl_load_image(offset, hdr_alignment,
>   					  buf);
>   		if (ret != 0) {
>   			printf("Read container image from NAND failed\n");
> @@ -181,12 +182,12 @@ static int get_dev_container_size(void *dev, int dev_type, unsigned long offset,
>   
>   #ifdef CONFIG_SPL_NOR_SUPPORT
>   	if (dev_type == QSPI_NOR_DEV)
> -		memcpy(buf, (const void *)offset, CONTAINER_HDR_ALIGNMENT);
> +		memcpy(buf, (const void *)offset, hdr_alignment);
>   #endif
>   
>   #ifdef CONFIG_SPL_BOOTROM_SUPPORT
>   	if (dev_type == ROM_API_DEV) {
> -		ret = spl_romapi_raw_seekable_read(offset, CONTAINER_HDR_ALIGNMENT, buf);
> +		ret = spl_romapi_raw_seekable_read(offset, hdr_alignment, buf);
>   		if (!ret) {
>   			printf("Read container image from ROM API failed\n");
>   			return -EIO;
> @@ -282,6 +283,7 @@ static unsigned long get_boot_device_offset(void *dev, int dev_type)
>   
>   static ulong get_imageset_end(void *dev, int dev_type)
>   {
> +	const int hdr_alignment = container_hdr_alignment();
>   	unsigned long offset[3] = {};
>   	int value_container[3] = {};
>   	u16 hdr_length;
> @@ -298,7 +300,7 @@ static ulong get_imageset_end(void *dev, int dev_type)
>   	debug("seco container size 0x%x\n", value_container[0]);
>   
>   	if (is_imx95() || is_imx94()) {
> -		offset[1] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
> +		offset[1] = ALIGN(hdr_length, hdr_alignment) + offset[0];
>   
>   		value_container[1] = get_dev_container_size(dev, dev_type, offset[1], &hdr_length, &v2x_fw);
>   		if (value_container[1] < 0) {
> @@ -308,14 +310,14 @@ static ulong get_imageset_end(void *dev, int dev_type)
>   
>   		if (v2x_fw) {
>   			debug("v2x container size 0x%x\n", value_container[1]);
> -			offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[1];
> +			offset[2] = ALIGN(hdr_length, hdr_alignment) + offset[1];
>   		} else {
>   			printf("no v2x container included\n");
>   			offset[2] = offset[1];
>   		}
>   	} else {
>   		/* Skip offset[1] */
> -		offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
> +		offset[2] = ALIGN(hdr_length, hdr_alignment) + offset[0];
>   	}
>   
>   	value_container[2] = get_dev_container_size(dev, dev_type, offset[2], &hdr_length, NULL);
> diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
> index d9725a96043..8a01b9045dd 100644
> --- a/arch/arm/mach-imx/imx9/Kconfig
> +++ b/arch/arm/mach-imx/imx9/Kconfig
> @@ -36,14 +36,12 @@ config IMX95
>   	select DM_MAILBOX
>   	select SCMI_FIRMWARE
>   	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
> -	select IMX_PQC_SUPPORT if !IMX95_A0
>   
>   config IMX94
>   	bool
>   	select ARMV8_SPL_EXCEPTION_VECTORS
>   	select DM_MAILBOX
>   	select IMX9
> -	select IMX_PQC_SUPPORT
>   	select SCMI_FIRMWARE
>   	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
>   
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 8dade2b501e..f8fd502f5a5 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -372,13 +372,6 @@ config SPL_IMX_CONTAINER_USE_TRAMPOLINE
>   	help
>   	  Enable SPL load reader to load data to a trampoline buffer.
>   
> -config IMX_PQC_SUPPORT
> -	bool "Enable to support i.MX ROM PQC Container"
> -	depends on SPL && SPL_LOAD_IMX_CONTAINER
> -	help
> -	  Support i.MX ROM new PQC container format. If your chip does not use
> -	  PQC container, say 'n'.
> -
>   config IMX_CONTAINER_CFG
>   	string "i.MX8 Container config file"
>   	depends on SPL && SPL_LOAD_IMX_CONTAINER
> diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
> index 79d021f81dc..e0e8ee0a5e6 100644
> --- a/common/spl/spl_imx_container.c
> +++ b/common/spl/spl_imx_container.c
> @@ -87,11 +87,12 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
>   static int read_auth_container(struct spl_image_info *spl_image,
>   			       struct spl_load_info *info, ulong offset)
>   {
> +	const int hdr_alignment = container_hdr_alignment();
>   	struct container_hdr *container = NULL;
>   	u16 length;
>   	int i, size, ret = 0;
>   
> -	size = ALIGN(CONTAINER_HDR_ALIGNMENT, spl_get_bl_len(info));
> +	size = ALIGN(hdr_alignment, spl_get_bl_len(info));
>   
>   	/*
>   	 * It will not override the ATF code, so safe to use it here,
> @@ -104,7 +105,7 @@ static int read_auth_container(struct spl_image_info *spl_image,
>   	debug("%s: container: %p offset: %lu size: %u\n", __func__,
>   	      container, offset, size);
>   	if (info->read(info, offset, size, container) <
> -	    CONTAINER_HDR_ALIGNMENT) {
> +	    hdr_alignment) {
>   		ret = -EIO;
>   		goto end;
>   	}
> @@ -124,7 +125,7 @@ static int read_auth_container(struct spl_image_info *spl_image,
>   	length = container->length_lsb + (container->length_msb << 8);
>   	debug("Container length %u\n", length);
>   
> -	if (length > CONTAINER_HDR_ALIGNMENT) {
> +	if (length > hdr_alignment) {
>   		size = ALIGN(length, spl_get_bl_len(info));
>   
>   		free(container);
> diff --git a/include/imx_container.h b/include/imx_container.h
> index 684fc3bc988..1a19d2503e7 100644
> --- a/include/imx_container.h
> +++ b/include/imx_container.h
> @@ -6,17 +6,14 @@
>   #ifndef __CONTAINER_HEADER_H_
>   #define __CONTAINER_HEADER_H_
>   
> +#include <asm/arch/sys_proto.h>
> +
>   #include <linux/sizes.h>
>   #include <linux/types.h>
>   
>   #define IV_MAX_LEN			32
>   #define HASH_MAX_LEN			64
>   
> -#if IS_ENABLED(CONFIG_IMX_PQC_SUPPORT)
> -#define CONTAINER_HDR_ALIGNMENT 0x4000
> -#else
> -#define CONTAINER_HDR_ALIGNMENT 0x400
> -#endif
>   #define CONTAINER_HDR_EMMC_OFFSET 0
>   #define CONTAINER_HDR_MMCSD_OFFSET SZ_32K
>   #define CONTAINER_HDR_QSPI_OFFSET SZ_4K
> @@ -76,14 +73,20 @@ int get_container_size(ulong addr, u16 *header_length);
>   
>   static inline bool valid_container_hdr(struct container_hdr *container)
>   {
> -#if IS_ENABLED(CONFIG_IMX_PQC_SUPPORT)
>   	return (container->tag == CONTAINER_HDR_TAG ||
>   		container->tag == 0x82) &&
>   		(container->version == CONTAINER_HDR_VERSION ||
>   		 container->version == 0x2);
> -#else
> -	return container->tag == CONTAINER_HDR_TAG &&
> -	       container->version == CONTAINER_HDR_VERSION;
> -#endif
> +}
> +
> +static inline int container_hdr_alignment(void)
> +{
> +	if (is_imx94())
> +		return 0x4000;	/* PQC */
> +
> +	if (is_imx95() && (soc_rev() >= CHIP_REV_2_0))
> +		return 0x4000;	/* PQC on i.MX95 B0 and newer */
> +
> +	return 0x400;	/* Non-PQC on i.MX95 A1 and older */


I understand you want to use single uboot and spl image for A0 and B0. 
But A0 is not production. Only early customers get few A0 samples. NXP 
marketing has notified these customers to replace A0 to B0. Are you 
still using A0 board? Is it necessary to do such change as we want to 
remove A0 to simplify the codes?

Eliminate IMX_PQC_SUPPORT config is not a good way. When adding new SOC, 
developer has to update the container_hdr_alignment, then it will be a 
long list in this function. Actually only iMX95 is the exception. If you 
insist keeping A0, I prefer change like below and retain IMX_PQC_SUPPORT.

#if IS_ENABLED(CONFIG_IMX95)
static inline u32 container_hdr_alignment(void)
{
	if (is_imx95() && (soc_rev() >= CHIP_REV_2_0))
		return 0x4000;
	else
		return 0x400;
}
#else
static inline u32 container_hdr_alignment(void)
{
#if IS_ENABLED(CONFIG_IMX_PQC_SUPPORT)
	return 0x4000;
#else
	return 0x400;
#endif
}
#endif

Best regards,
Ye Li

>   }
>   #endif

