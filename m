Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3ADE64AB5
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 14:38:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6953489328;
	Tue,  3 Dec 2024 15:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sKV6km9b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55E8A89651; Tue,  3 Dec 2024 15:37:52 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67FFC8948B
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:37:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmzMulqS0sPJHXV1TpDSUqcNH2DegKv9qYDuw6SqlV6+CgYn6iKpIUINATc5F46rLGu23XjUUeZCb278qUTEiTKcV12CHMeGEpqiMdLXDJorSuUmq33iuoqq1SwWZmzp0x3FLYcztB+0lJPGrARp/0n6eabjXwaOKtRCelXqSKAhU/OLuHK4O9YEqQOA9nSURzsSEJF1FW5sZc6ebTCF+ZWwM3j3/RKGB2RBddJhM3zE3Zp+2TQK686dDoTZviHO561A0zkewe0flvXYuX5Nj9/PAxunWxUm8BSoa2HwTojuJJGnRnlapV0AWJNaoJeSyXxocTDt6xyCdPi+6p7Siw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rK8cAiFFrzsTu2E2V3YmIN6ssO+A9Bc/S8DqQj+Rkw=;
 b=in397h6YxD/Ya1MtyeLk31WrvyWnZN7g5GcWvd8TeZPrzuhSBrmvO/3I/Rn47Q0/HaBSaHHIeYtA0341q6SVUkhuh1bEaKZ806tF3K42W+SeXMVt0D8qrs5tRxApUAbGMgsMtCzme7jabAoumcYhWDMSJillLLSo6x8O++E/tUguGjumjAjt3R3r/uSrVEqicFWZxobaGJwCFixWBJ+bttJ7CeK8ddfmehdsHgGSVH78xlPklkjcnau+1zp6yGXZ9BMmQNMwsxnsUXW7Qb1wlBnBs7+L4dg/21/9SsNvT+2QzhhfM7M1CpGWs8QI9wvVxqYKPNwLT+BVOjjw+P94Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rK8cAiFFrzsTu2E2V3YmIN6ssO+A9Bc/S8DqQj+Rkw=;
 b=sKV6km9bkiK0j70m2KYkvLuKFwnaiNUbp4T9ekSIbdb2nGj382IBY/SPBu8lPrGEsIgSJ3icQSKpkDO7IeezyWfBOncqsGKr9uJzy8R/Y74VRLPc7Ins/uNkym2MJSGxnvNwFADIomzLeXMFdZNScR7gEr7XwMSmY4juhj5y7V8gO3tKQs0tuZ4MP374lbeFusJqt4f7/yHgH1iCsPmBeTvvIcm/W1ImeNTAYlcZjSSr5cZr/dgIeD4au7e32lD5bGoF0uYEkN7Sgxh4NfhdyofKnC6ECvK5AZ41idQwlYyMhv1+FnZ0SQZd7zqptymZYtyxc16XWsbW5+9FQHWGBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 14:37:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:37:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Dec 2024 23:42:44 +0800
Subject: [PATCH 01/11] gpio: imx_rgpio2p: Move 8ulp_data to data section
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-imx91-v1-1-48d2eaa4519e@nxp.com>
References: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
In-Reply-To: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: JH0PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5a::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 96cbc7fc-998d-484b-bbc4-08dd13a80e3a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTA5LzRHcUpuZUUvSElYa0JNMzYrUndscjdxZWFCaktHTW9adFBZYmw0eFZh?=
 =?utf-8?B?MkVoMjdveGhzZ1k1OUl4Wk95cDdpRWJjamo3eXpKNDNtRmdVemtqZWRBOEhi?=
 =?utf-8?B?R0MwalpsTVhsRXRNd2dpejNaeVZTZ2NoWk11ZzNOOWJ2aS85V2srMUFGQWdD?=
 =?utf-8?B?TnZLUzBrSlZZNE5qWUdsWnFhNGpsR2NmbkRDczhvZ09UaFp3WFhCOVBTSXls?=
 =?utf-8?B?YzhKMzIrZHBIQ0lKT210Z3ZMWWE2ZUhBTVkzWUMzWmtrTlFmZll4T2NIZExT?=
 =?utf-8?B?Y1Q0NEp3a3VqZGgrbmMrMU1VWWFuaFpqMnE0cFlPZk15akJ0STFUQzdrWGpW?=
 =?utf-8?B?dXZpQldaa1c0cU04ZXUwVm1HbTRLb1dJYnR4VnA0V3NsL0t1QzN2OVoyTkdX?=
 =?utf-8?B?S1lHdXFTMmtVeDVvUFNDeU1TY1U1NmZtRHhxc2p3ZWlhR21rYjk3b3FNTXNI?=
 =?utf-8?B?cVhNU0JnZTlCY1NQaThqVmdOSUlHQm1KRnZFSnJHOHdVL2dnYjZwbElGcm5k?=
 =?utf-8?B?SGZRWk41OGx6Z05BOThyRjd1UjRZR3AxNER0STRUTnZpYVJlQXhUUXlPUkxF?=
 =?utf-8?B?Q3ZjVUkxcEszTDlBODdEdTlaNFNYU0RoTFpRT1krN1A3dXJ2aGh0KzhjNlZH?=
 =?utf-8?B?eG5US09uQVF1Y1Z4OG8wcmVYOUlhU25PdGhMWU5TaXBhcGZaMG44Vnh5dmRI?=
 =?utf-8?B?SlZmMDlKemNtemdDOVNnNnppY2k1MEJveW85dTRRN0F6WGFLVnZUVGJBb0Nj?=
 =?utf-8?B?ekVHb1pJdUpQSCsrSUFhVDN2dlh5Q2h2bXBzMVlxMDNxdkxJN1MwSlhFYUFB?=
 =?utf-8?B?elhjdUV0OEFGVmJJU2JuVzIzYWlyQUhJVUxDa213LzZubGI5Mk9yNm5MV3RK?=
 =?utf-8?B?b2NHbEJWWEFDcm9XYjNVaEpGZVUvZE9zNU5TVDZIMjM4aFZhZVBkYy8xQ0Q4?=
 =?utf-8?B?bDNseVUycUpiSGFYY0VudG9jYjFSYit2dFFKTnVYc2lKSVhMQW10dm1TQXZK?=
 =?utf-8?B?NzZ2TTBQYXVha2wwQitvN1o4WFlsN0tYZlNGd1MwdGJmWjZIaTI2UnJLUzVG?=
 =?utf-8?B?cWlSQW4rKzByTU9JeUhETWNsOUwwSExOMGJkZXZ5bHcyOWZMVTVxYnc0VEN2?=
 =?utf-8?B?ZndFRG9jN1g5a2lmOGpqelNOcDNaVGdNNkgvRUJMaTVVb245dlYwcEpOckcx?=
 =?utf-8?B?dkxIQytWNzEvaEFNVE9ZaFpjU2lzdVlkS0dpR3dRNW0zdHVCdmpQL2pmTU9a?=
 =?utf-8?B?T0ExSm53LzUyQk9UK21XY1FyODZGVEhKZ0R4c3owTFVGblY2cEVqTkZweFBp?=
 =?utf-8?B?OUVqamt4SzNTVm5zbGtOcjVIdlpVS2dpOURRSlBYU3JBeW5BajdNaVdzRUw5?=
 =?utf-8?B?WjdKSFFiTjVTTzUwS3FoVzZIQnQ3aXRoclZFSGFKald4VkM2NzNUTlhrYTRM?=
 =?utf-8?B?b0twajkxM3Mzbm5iL0EwZ1d0am1nMjZkZng1ZEZ2Ty9weVE4TjM0eHNPRlJB?=
 =?utf-8?B?ampkcURTdXIxY3l3SmpaSU5HeDdQbTk4LzlXYmNIU0dSZnJpb3E1WkJpdEl3?=
 =?utf-8?B?WXRSTHc3Tm80clZBSDQybFVrZ05ucGNDWjFFbmFaRCtBTkhGYTJmU3IwMTFY?=
 =?utf-8?B?QngzOTFKeW5WZ095QVIvSFNHbVlaM0JQVTVMQTNVOGoybW4xOWRjYS93ME9Z?=
 =?utf-8?B?NW53SlhocDNQbUhrSHNyZ0RubnlDY0ZIZmQzdWxrck41RExFWnhFcnhGUmhz?=
 =?utf-8?B?V0lrblJqMTVlaVIzMnRUdWtPSlhGOXlscXBoWlcxMnc0ZkhvUFkwOGtMYVdr?=
 =?utf-8?B?aWhFOUNPZ1ZaUUpZTUZXR2s4eXB6c1ZWM0tsL0dhVFd6ZHptNU1RUzU5WDhI?=
 =?utf-8?B?VXRDT2w2ME9obUZUVkU5ajN4UDBxL3dERlNNSEV4ZWpJNnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTBZZmRFRS9yRkFmY3hNaWh4TUdvbUg4RFBrQjdtTGJBYThtK2Juc3BodXVy?=
 =?utf-8?B?R25ZckV0cEpJdTJQeG1HYTdzcDRzdjROWUhmMEJLaVpCMTFWK2lEZ0o0emZF?=
 =?utf-8?B?U0d0VHZsWnErQk9PS0lqMHRNSStSRmRxUVFVdDJrOGpWc3VRNjcyN2JVN3dv?=
 =?utf-8?B?aHFWY1o0VUxUaGdaRTN1ZUdZaWFqMWxPVWxCS2pXeDlhWk1tY2dvWWMxbVVF?=
 =?utf-8?B?c0Z6MEdGQ3NJZmhjMk04ZEluMGJlaWRSWHBlb1YzQVZxUEFOTkdtZ3NSREFi?=
 =?utf-8?B?Q3pXV3g2RlRDdE13QkhoeVRweXo1czVseE1Bclppd2JycW9BYlpJRjhoU2ZW?=
 =?utf-8?B?SmpxOUtiTGRhVFRQSWtGTzZ2V1ZyL1g3d1NDZFh2Slk5aUo5MXJ6SEdpU25H?=
 =?utf-8?B?YVk3bXVHZkZmd0JVOU1BbCtzMFBlOXhPWjEySGJON21qM1ZQSEswVkV1SFJD?=
 =?utf-8?B?VGlxVzJvcEUyR0haU1B0bUJPeDdBbDBBTDFtaDJIMTRGdEdEemkxQy9MaXdz?=
 =?utf-8?B?a3ZKMk1WcW05OVNTZXZsNFBMaDdacWc3eTUxaWNCV0FseFViN3R3ZHVuQURo?=
 =?utf-8?B?S2x2MnN6U2FQbUZiQVZEZk9Sc1pzc3Ira0h2TVc2VFdCang5RTRPNU9qdGps?=
 =?utf-8?B?T0ZSYnp4dHVTQzg4RjVtYW5rSU9UUVFaZVIxZVlHbjNuRVRFVGpJVmJTWHUv?=
 =?utf-8?B?eW1kUEZGNVZSNEJNRm1STFRZU3RlR20yZ2kvZC9PNEZLT1RJdTVIbEp1eGJ0?=
 =?utf-8?B?b3hUZExMTXZPOGZIeXgwSlBJdXVKZ3o1a3A1WTM1VXUxL1hycDVpNlQwN2pT?=
 =?utf-8?B?YmpVYzlPMUp3K2JzQ0syQXIrUzZ2Rk0wc0dvT3l0NXQ5SWNuVTRvR1p2bEFz?=
 =?utf-8?B?RWlhQnQ2clZsRi9BL2ZpN0U4azhqTXcxZnpESk8rd0V6d3hncUdwU1VjbVdw?=
 =?utf-8?B?MWU5NUZNMUxWb1FSRnBwSGl1aGdodkpvL2duSGkvYkZoOWFVdFJwODBub1RV?=
 =?utf-8?B?cWxmQ0s3STdGR0YwaVZERnY2Ujg1RHFSSE96S0hGeEkwenhIdWlYNG9Ba1NF?=
 =?utf-8?B?ZGhFUEIzZ2Y5NVEzNXlvZ2M5emZmUzJDTUNVczFwK3N6UWZBMThEZ1YyYktP?=
 =?utf-8?B?bGJ3Wlp0b1pGMmNjVE1CTG8vMUgzYTZNQUp3QnpweFFCL1R6d0Jyd1l1N05r?=
 =?utf-8?B?Rm1VOG9uYlRhd1cvREQza3VncWM5L3hlUXBpanVhazBQYy95em56bThoNlFu?=
 =?utf-8?B?djI4WExmR1A0OExPY1pGalovWHFZS2h6RjcrWWI0d2EwSUliVGkwV0Rvdngz?=
 =?utf-8?B?TGFwd0JlM3BwRjdaUDFhcHNsaWNBeUFqeEZra2kyRU1KTzMyc3RsUGlDdEpE?=
 =?utf-8?B?M3lMWWFsa2JrbWo1c3F6U284UGxsYTduTjlpZnBmVmVjU2tIdDVlVm9YRjdD?=
 =?utf-8?B?dEovRDErd3ZEc243SnBzYm5zRjBBNnBxQjN6Y0JyLy9jblo0WU1hNGZONTY1?=
 =?utf-8?B?M2pYR2FxanoxRkt1cjNFUHNaVEhXWTlsZzE0bkZuWithUlgyd1ZFeSs4Q0FS?=
 =?utf-8?B?Z2NMTmVNdW5qQ1dhMnp0Z2hORUVVUzFXV2hBSXZNRDhjdWNxTE5sd1pib0hi?=
 =?utf-8?B?Qlhpc0NYUjJEcmZoV0sySjB3aWZ6ZW9ZenA0eEYzQXRsMTZjRDlVaUgrQWlV?=
 =?utf-8?B?eUtRUjE1anNmbnVaYlU3RTFQMTBoTEtUR21ZMUJScWtiWXFKWjJZYm9BdGdC?=
 =?utf-8?B?bGhCVWNmS0M4TnRKb0J0L2dnM2NvckxUV0lpRS9YbVBXdmN2L3pNM0ZHL3VX?=
 =?utf-8?B?Qkl1ZFJyVlFCYVZtUXg2cEkzUTdVaGhjVnptY2tBUTJkOHFILzRjR0Fqd2l5?=
 =?utf-8?B?M1Vyd2l2OE1ZTUZTVHIrR0FTL08vcy9PRlNoWUNrRXA2Z0hJSVB1TGVGcGVZ?=
 =?utf-8?B?YkNUSW81QUV2K0hhZFoyckt6cC9NTjI0ZFRZeG1SWHNrRlBUM21Tdm42Y1Q4?=
 =?utf-8?B?YWZoZHN1MGd0SnVTRmordTNoSTlOaVo5OHhHSEJzTnpYTGljc3IraTNHOHFz?=
 =?utf-8?B?elgvRmJYN2VDTlFNSTZiSVdTek1hNWdLR2w3ZHFralQyY3kzVGlMZHd0Vjhl?=
 =?utf-8?Q?jJWaxiDAf2+8AEbx+KAXtaFNe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cbc7fc-998d-484b-bbc4-08dd13a80e3a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:37:47.3015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VK58c3n4S4ZLUFle4x/vu7jurWkVVv4fPIUpQhDq7riZNf3avTLAyNgNU1rC1PIZcEHu3NQ/zl/SufijSph4oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541
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

have_dual_base is set to false, so the 8ulp_data will be put in BSS
section which conflicts with the area of u-boot.dtb which padded just
after u-boot-nodtb.bin. So move 8ulp_data to data section to avoid
its content being corrupted by dtb.

Fixes: 51cfa66f2c4 ("gpio: imx_rgpio2p: support one address")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpio/imx_rgpio2p.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/imx_rgpio2p.c b/drivers/gpio/imx_rgpio2p.c
index fc1d418315c560f2e794fb383d3764d98d482b39..7cf178f8a485224e6314a66d9c82e0c2a5776cd5 100644
--- a/drivers/gpio/imx_rgpio2p.c
+++ b/drivers/gpio/imx_rgpio2p.c
@@ -231,7 +231,7 @@ static struct imx_rgpio2p_soc_data imx7ulp_data = {
 	.have_dual_base = true,
 };
 
-static struct imx_rgpio2p_soc_data imx8ulp_data = {
+static struct imx_rgpio2p_soc_data imx8ulp_data __section(".data") = {
 	.have_dual_base = false,
 };
 

-- 
2.35.3

