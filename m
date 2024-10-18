Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86FDD3C54C
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 06:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CAAA89285;
	Fri, 18 Oct 2024 08:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TfVTerqj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C881989295; Fri, 18 Oct 2024 08:30:35 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B78F789285
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 08:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLR3XMPC2HIXScXc+Wqm8YSSxUtxKDGYBryxuXWKqEoX21EK4bdIBV+LXBnDLRTZVNC19O490DtpVKGFbM2feUMLZteroTJGKiChNu+AVAL/IcA+g1yyO/iP1F4dU9Xwm8p6pJFbVhJfzME8s6yR0KimBJlLAwjlzr+ifyfD52YajU2yGtZ+BdlRgtGakiqqbT42t0DkeFFsCTTTu/WrlX3EL0SJ3uD9bKQ80iC6kxlG+2/dWvaulD+wLjAW3mRBZZgO5i6xggHH23IZGuZhnNwkWW16LcCXq3asbViPw2bJna11IYOFA4qV/FT32TDh1ebKYHXK+vggGF5seaUXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8f8YIGWi5AEvgPLbyarLoetQjSL2W1Enwa3xET8XcE=;
 b=YWMnLROCIUK4myQNffNnfC4n/cZbkCjcZByRIDF9VMoIrNkkwoNCBg217ixI/8XWLK3YOLMcf8KKyuUFBjLMXnduknqBGQ0FbJP0fsNGs0zTXx7OlvnlgyzPcpXTVymc/qR+swnLUcyMnumW1Z2x1fBv1dxbEbXzuH5CCo1QvfTFMQ0dvOzI+yWVKIQys8junoqZYy9TvGz4MEDVFB9xenBLHhDUqQyNxpCisMkA8A87rMC/WjL2kOfxBweLmMuGYqrnrV/0j+8U4sZfzkX54xYbwfDTS8iEtxVpjUHmlG2hJ+/9w/M073YAQgTLgFoS97xspkhYk1Z0GDUTzBit5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8f8YIGWi5AEvgPLbyarLoetQjSL2W1Enwa3xET8XcE=;
 b=TfVTerqjBZtiIeUGOdy2nDErRzn3oQfDbKRHijRsCT3PM8+X/uc6F0SRsfW1dM9JcLIq7xJQupkWIK8BGrHsrRecMFPkBNHVWxiUzNk0hr5A0lxZEd/MJ617iGR1A7c1CDaIzB1UbaUOFenhFi+Chrjqxplde/MnP+hteQEq0uSY9Jg7hymuTulcbMhZTX1bjFe+gxsQCIDS3Oll6fK+g33UqpoCyLD3E4g8q0RZHrGHxuLkmrKVzVJ1qjA64nHGXFOcp3XBz0osnF9p+gWkyNWTZ3MwQ1CgS1+iBwzCsH0wh++vpmOommb3cq9H5TnhqsExcqz/ptdo/K7iYXgZDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7844.eurprd04.prod.outlook.com (2603:10a6:20b:236::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 06:30:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 06:30:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 trini@konsulko.com
Cc: uboot-imx@nxp.com,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3] cpu: imx8_cpu: Avoid revision to corrupt device tree
Date: Fri, 18 Oct 2024 15:34:32 +0800
Message-Id: <20241018073432.18234-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 9425e9df-a844-47c8-fdff-08dcef3e5d07
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjJ5K0VISUg3cHd1NEpqV3FRUkZSdkZROXY1V2tNNHF3UDB5akJmWEpzTVpr?=
 =?utf-8?B?alFpcDduZkdvMFRFSGhXckZHM05RNFNaWk9uYVlVRXlncGIxbmExelMxL3VY?=
 =?utf-8?B?SmQ3TUlESXI4eDgzeHZmb2R3Y1BmU2V6dko0d0l1Q3kyRnQ0YVZrc2RHT0I1?=
 =?utf-8?B?VCtsMnpiQWdFMWpKM2FISDBjeWZXOFNXWndsNFhLM2ZuQVIvbW1oaVJ0amZm?=
 =?utf-8?B?c21MSnBoYUtxTm5BcWpiSmJ3bnE1Y2V1RGJlVWl0NC9rMlZKQnl0ajEva2hW?=
 =?utf-8?B?VlU3czZxTTV5SEpyUHpjVCtoaFNyY2FwMVg4RmVRWjNqRzJtMlYyVnFEQTF5?=
 =?utf-8?B?eDNOWEFHaXNnM3hDUklKUitVbmIxRXlodzN3VTN6RmV4elp5N0FocVAvWmh1?=
 =?utf-8?B?Y3hVQVVZMjBqaTRaejhnM1RmR005QzJ3eVA3cURublFQOEtTK1pRU1h5NG0y?=
 =?utf-8?B?WUVIS1QxWVdpSHlwVFRzdnQrenk5dkh6U2ZqR0JoZnZMaVh4VUs2VVkvTHRt?=
 =?utf-8?B?VEpjNS96SFd2Q01ubGV2c2FZMjcwOXIzVElvVGt2QTBFTmlzMnVpQlF5K3NS?=
 =?utf-8?B?d3pHOC9FYnlnZ0RYQjB5L2JiSkVtS3l5Y1hjYVNlQWlVQ3ZPQURLZ1dmTzhp?=
 =?utf-8?B?eUpTL2tRL0RuRWZlMnV3dGY4Zkx6R0xmUXAwQWpwM2I5eDJ4SEJZbjkwTGNI?=
 =?utf-8?B?WSt6eXhRS1FBMk96bnZEMkFxZGFXdUppN20xKzFNQWpreEgvY3JrRXhod0dE?=
 =?utf-8?B?MS9OcE13NHplS1pGcWlzKzg3cE5KVVgzQ0w1cHFqT3lWUHp6ZWlScDJld0Rr?=
 =?utf-8?B?UjdXZU9xTHJTRDBhWFdkR0J4dnUxT1N2WTQ3MTR4VXZSN05rUitMVU94MWFo?=
 =?utf-8?B?bCtIaWJSZUJqSGphK3plRWd1dTlnQ3VObVhGNjdkNGZaaTVpVHRremduRWtK?=
 =?utf-8?B?cXNqMEsvdWFXTmV4ZythYVNybTFJSUVva3JRSnRiUmh6R25XZUQzNTh0M1FR?=
 =?utf-8?B?aFhQNEI1S2diN0ZkUSsvSHNhTXhXMUY4bE5mTWdkV1Rua2w0RjBjWFF3MmZn?=
 =?utf-8?B?Z05QYUNzd0RKRkdPUzNTL0EzOXpIdkFNUVlTaTA0MkZIeGdVVGppZWdKMk5I?=
 =?utf-8?B?TUtKYnYvaWVJcUs2dkdySm1Rd0VqSTlUNnE4bzNXQjJiRkU3aVF1ZDcwS2NY?=
 =?utf-8?B?c2t1ODBRcENEdUJQOTVuRWhkLzRaRnpsekRVa3lUVjZhNWJMRlZLK0tvQjhq?=
 =?utf-8?B?MzdXR3VFbTVyMWQrUWZITExqQzBaZ2luaGhvdm9MVmM5djZrUm9jc0VmeHdp?=
 =?utf-8?B?eCswWGw3NGU5WHp5Q0U3ZDU4RTFPSzRUZmQ3SEUyOU1SMW5iMWxmTXh3MlN0?=
 =?utf-8?B?RjFFVVpSZENGZmYvN1dBelg1NzVsRlQ4SS9JdWs1S3BKRlBGODRaZW5vQVpJ?=
 =?utf-8?B?UXlKZ2tNMUxpd2pnL0FKQVpkSlo0ZkJlTjM5cTVmQUZCc1JMRTFkOGtDYzJk?=
 =?utf-8?B?QWtXWE1DU1BaR1JDd2h6bTFRQVp3aUNmb2FBTEszTEVMM0p3RW9QQzdFZ0dX?=
 =?utf-8?B?ODdUa0xOLzVZYVRqeENseEoyU2N6aEtzK1lYK1lXdW9vQ2tEUHBFKzRreXAx?=
 =?utf-8?B?M1Rib2gzc1AzTGZRL3h3alEwM1BCK1pkbEh0NEhoa2MxRk1LVHkvQ3VXY2dM?=
 =?utf-8?B?enRha2hsNDNLWXlXendRcGNubTd4SGwyVUI1UFliT3J5WVVmcFdabHhFMWZI?=
 =?utf-8?B?Zld5QUZkUW9iN2JqallFMkhrR0lPZkE1QXlzeDR5akMwTDRINkJibUE2Rkc0?=
 =?utf-8?Q?1+hDn9xXtda3ewA2snyk4bPK88nGjBlErQyNI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QStvakY0WkZiM1pqU2dCc2F0Q1FPbXFtNENINTZwRlhtT2M5OW1XVFZOWWtE?=
 =?utf-8?B?dkNGSVJMckYvMUNzVVVCbWhtVDNNVjFwendhRWRWemJPWDdjbmJmaUo5V1M4?=
 =?utf-8?B?SmNTb3Znb0VwaU0zTU50UXExWGVENTFoeUZIaTlxQkRjVEtCUWhNNlRSVGNC?=
 =?utf-8?B?UFZXTDFMNUM5SEdaV3RYNnArd1JBL1FKOFFjVHdWaEFmckVtVWtORHFkVzRw?=
 =?utf-8?B?Mys3TFlrM0ZFcmtoOTlmSmZsMjlNejlPc21oOStsNnZjTE5OUURIVmVQNGtO?=
 =?utf-8?B?OW9LUUFzOEVUN3pUcGdnSmcxdlovTE54TVNDeUpiblNneTJOQk5QNit6eUhr?=
 =?utf-8?B?REVjVEttVEdldEhHOTZtNHJUMC83T2tNdklCU2ZjYlBmNDM1MS9tdWt2Z1M4?=
 =?utf-8?B?TlJhWDRMVEYxdWxpQVc5akxUaVg1M3FIMzdsVlVYV3lKWmZlWVVZTSs2T1cr?=
 =?utf-8?B?YmU3UkRYU1RmUjBVSURBOTFTbXMzUW1lTS94Q0N3eGhHVzI0RE5FQ1VTNDc0?=
 =?utf-8?B?YjBRU0xIeUxSUWpvVmszeU5PbnNmT0hPYUtvY1J1UWVibGh4bCtIMUY0T0hP?=
 =?utf-8?B?aW9lY0NEbFJlNk1SNERJM3A0b1cveTMrSVM3YkFHUCtXVktxdDJ2UFp6M2dX?=
 =?utf-8?B?WHZQOWpDRHkzRGZEQmtVVHE1TkR0cUdnM3NHN2MyTVRvQlovUm9rVmxYKzNQ?=
 =?utf-8?B?N0NRNXh5RGVsVVZYRllKTGhPdkNCdTRTdk9uSE1XM245NXorWEErUituLzYv?=
 =?utf-8?B?YzFGOVVsczVqQ2xiN0N1dDdBbWNyR1NQeGJwVm9Yank1U3IvU040VlBDQWVY?=
 =?utf-8?B?WkpFY1VpSjVOQXZRaDdXZjZIVmJvWCtHWjVXRkxJcWg1NDQvVEJEaEVTcFR4?=
 =?utf-8?B?My9lMkl0aWtUb2NxZk5oR0toMlZsNi9ldkorR0kvSFJvZXYzM250MExsRnBJ?=
 =?utf-8?B?Yi9wNzd2ZXJRUUJMWjhzVzgya3l1VTh0NHBNRnUvbHp3WWJUSEE0TFRRdDJH?=
 =?utf-8?B?ektVNjE5bjR1Z2l1TzJFMlQ0K201LzdSRU1FOTBYbXlSOXdnMlZzUEUwbUN0?=
 =?utf-8?B?SE4zdFh2TUVaRDZQRjl3MEp3S3dJM0owWDIxN1J5Nk9ua2JESm41eDdFeWs1?=
 =?utf-8?B?ZWU0WENJMzgwTnlsdTRORXhzZTJVZFVqS1N0QmJUaVZWZkQ2dDlWMlIvcDhH?=
 =?utf-8?B?bkNLa3dmOVJWU0NvdGo5MmE0cWhVTGhPWmV0ZStzamhhY0lyUFdiYzNUZEhr?=
 =?utf-8?B?Y3U1WE83anBBOE5TL2pWRmsybjJRbm0yM1hkK0JBN21OSjJmUUhIVnBieFE3?=
 =?utf-8?B?UWJRRkJNRW52SkJIWjduVmN3QjVvOHlKbU1NQXVEZzkvSC83eXRsWnVaaDZX?=
 =?utf-8?B?NzFPdWl6QTdRSmx1WG0rM1ZzeUxFUUVaNzA5SzBQajBVNlJObUJZdjlLYlJi?=
 =?utf-8?B?QnRFWCttRFhvTHlqNytVcThWUGkzT3JhdzJxSTcrd0hob0FnWFJhWmNFVEZF?=
 =?utf-8?B?VEM0UGpwaDJIQ2g0NVlwbnNSQ01NWGNNdDhjTmZTekwrMUlrWlNZKzQxNXJH?=
 =?utf-8?B?SXVKUDIwK3Mwek54Z0YvODg5RFZUL0VsVzV6eS9vbFBGcVB0eU5QMVFST2hm?=
 =?utf-8?B?MGxuYnd1U2g0U3lRMVJEbk8wRkhxV2dzdTMzdHEvRlFxcWxkZ2N2L3hZV1g3?=
 =?utf-8?B?YkZwZ3RzeDIvdzVVQXRiUDl0ZVYvVE90eW45TFFnREw3SDY5TjdEejNsdUVC?=
 =?utf-8?B?N0NtbjVKbXRWWHZIT1dBQ3RHOFZwR250dmJQdDNnT1FGUFc2TGdPcCtFU1pF?=
 =?utf-8?B?bFEwYzNqZVdOQTc0aDdxanVsbEU0Sy9XM0Vsb29Zeko2OWpGajNBTGZmbmUr?=
 =?utf-8?B?YVZ0cjgrZnFkR2NMQ3J4aDV1UGtUQXpVTU0vQ1VmUGtsdFZMRGM2VFUzNTd6?=
 =?utf-8?B?eFZoMkp5NGlRTUl1K0duRXlMTWI4NjcwTzZ6SEEwTFRzd2MxbDdjblF3RjI1?=
 =?utf-8?B?UjNwTmc0N2wrOEdEVkVsUi9FZDU4M2MzRC91dVRWd3JMcXF4Z2VhT0ZCQlNa?=
 =?utf-8?B?bGYyZkhrRjZTcytZejM5VThVNDZna1E1TllYaUtxazg5N2hsZ21DemdocVhM?=
 =?utf-8?Q?FTcaNvbft0Symvv3vSw5W+jw4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9425e9df-a844-47c8-fdff-08dcef3e5d07
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 06:30:31.1101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEVr/58sfN+iuyEsRRTjaRAkWcsHCPvCC+QNwnTSmvt2skVfxSvkhCF02WhOR4szl6ZMqEHRJmr9XLZhV3Hsmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7844
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

U-Boot device tree is padded just after U-Boot proper.
After the whole stuff loaded to DRAM space, the device tree
area is conflict with BSS region before U-Boot relocation.

So any write to BSS area before reloc_fdt will corrupt the
device tree. Without the fix, there is issue that “binman_init
failed:-2” on i.MX8MP-EVK board.

Drop 'revision' and use malloc area in cpu_imx_plat->rev.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 Update commit
 Pass CI

V2:
 Move to use malloc area for revision

 drivers/cpu/imx8_cpu.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 6c0a8c0cbe4..51262befaff 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -20,10 +20,11 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define IMX_REV_LEN	4
 struct cpu_imx_plat {
 	const char *name;
-	const char *rev;
 	const char *type;
+	char rev[IMX_REV_LEN];
 	u32 cpu_rsrc;
 	u32 cpurev;
 	u32 freq_mhz;
@@ -69,28 +70,29 @@ static const char *get_imx_type_str(u32 imxtype)
 	}
 }
 
-static const char *get_imx_rev_str(u32 rev)
+static void get_imx_rev_str(struct cpu_imx_plat *plat, u32 rev)
 {
-	static char revision[4];
-
 	if (IS_ENABLED(CONFIG_IMX8)) {
 		switch (rev) {
 		case CHIP_REV_A:
-			return "A";
+			plat->rev[0] = 'A';
+			break;
 		case CHIP_REV_B:
-			return "B";
+			plat->rev[0] = 'B';
+			break;
 		case CHIP_REV_C:
-			return "C";
+			plat->rev[0] = 'C';
+			break;
 		default:
-			return "?";
+			plat->rev[0] = '?';
+			break;
 		}
+		plat->rev[1] = '\0';
 	} else {
-		revision[0] = '1' + (((rev & 0xf0) - CHIP_REV_1_0) >> 4);
-		revision[1] = '.';
-		revision[2] = '0' + (rev & 0xf);
-		revision[3] = '\0';
-
-		return revision;
+		plat->rev[0] = '1' + (((rev & 0xf0) - CHIP_REV_1_0) >> 4);
+		plat->rev[1] = '.';
+		plat->rev[2] = '0' + (rev & 0xf);
+		plat->rev[3] = '\0';
 	}
 }
 
@@ -318,7 +320,7 @@ static int imx_cpu_probe(struct udevice *dev)
 	set_core_data(dev);
 	cpurev = get_cpu_rev();
 	plat->cpurev = cpurev;
-	plat->rev = get_imx_rev_str(cpurev & 0xFFF);
+	get_imx_rev_str(plat, cpurev & 0xFFF);
 	plat->type = get_imx_type_str((cpurev & 0x1FF000) >> 12);
 	plat->freq_mhz = imx_get_cpu_rate(dev) / 1000000;
 	plat->mpidr = dev_read_addr(dev);
-- 
2.35.3

