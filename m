Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD66C3ABCB
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 02:32:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9B4888DEE;
	Tue, 17 Sep 2024 04:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TIir4ldN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B1C988E75; Tue, 17 Sep 2024 04:31:13 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CFE488C78
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yw3ypYUg3UlLZ7LiKw+WRQd1eKiUxRZv9ISNa5fK1slHqVdkcPv2DLVop2Yh3zyOeI63s+X8xpm/+JRTqEelfGqnMpg4jeI+L53mhNUPEnLvFc/uIQwEuwwNRD37A/ZCtyqjjSipbVkH2oOdw4vrljPgIrOVtKxMwWEjVriT7aA2CoROFObXwvN4Ou/kXRJkUOxnbGUh2r5Q9weMsYCpVqclgx3zseuwpyrcLya8zGo78VT/BdZmorz2WumaB8arSgpPYXVYLmY1GNqfBiv5DvjsqefA/nZ4V842/nf9dFvVzsGWQUK8A8IL5Zj2KYSWs+1ukm4SJQ3+iNXTq0v6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdToP7gHQHcuq9zk5Dq74N304u7ZJ8NVoQdxnwwRELA=;
 b=YhLR/Zc2P730iECK3XpjOKtKr24T8gaYTq0ccg2MVKZ2wha+PTPhypcJY86tVIl5b8Q61pffL9Wigfff2jEHfGFeJaZ06s/6SmaeaeXgbGZ37tTyyvID0QwDsDrTzm9jPwJhWw0XDxLkPrHx9kiIQNVaT0xnwIZ9lpdxwM9MZ9uoRXfICoXW3gk5tJOQljztMt5cOJTOUs7rWkF1c3dwrn0ItKmX0BLkNH8sZoMjFoVh0y8L8yREEdqRhFV/eLZ/nmOQ3ZjqPie3S8kLNv7ySpD+gxeICiHJQknOjdXomBj3J0rer6WlwzmRDP4NCQGsqxKD1iT+MPngRkapSt+WiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdToP7gHQHcuq9zk5Dq74N304u7ZJ8NVoQdxnwwRELA=;
 b=TIir4ldNDSd3lqf8tnETkTcJnwZNKG3SrI/t1fdOBWc5i69oJDAsLf0BGSM+cDzg8tD/kCLI8rH3n7qN8BWIjnZVT9q8s3DzFistDP3JZaMjENnvM3poItkZEuTlsUPj1/TMD4DPAkIm1jOyjAunqtFYBN/vQBTOaknG+iBjOvRn6eL69tpyY1cCTCVKfT9c4H4DQstdkrcQ/47D0t/BpnsZkeK+ZcAvTCk4BvYqpLrNMiKL/nh+9Ryl+9+f17fcYgDaBiKrehGqU6EQe8gKP4xH1VD9j9NHwJ8SeoflfHCLTW3MljtCPnbfFHfrgC2WsgZ5WVqW5t9d9uD4iHTk7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10451.eurprd04.prod.outlook.com (2603:10a6:150:1ea::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 02:31:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 02:31:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Sep 2024 11:34:04 +0800
Subject: [PATCH 12/21] imx: generialize disable_cpu_nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-imx9-update-v1-12-4fe8effc937e@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c70b5de2-aac6-481f-ce42-08dcd6c0c73e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zlc0NWNtWGphdlJ3eHRJQUJaZmQ5Mm53WFdLZCtQU1lKWUNud1pmMWFqNFBp?=
 =?utf-8?B?cmdGbHg1M1FkUWI3QWYxcXA5U0MrQnU1VnV2Y3JzY0pENmZVdGsrc01UN3Q0?=
 =?utf-8?B?MDAySWdRY0YrNXdsM3FyTXluNUU2eGd6eG5BNE0wWG9GZHExVVBVU1lNbDdW?=
 =?utf-8?B?UENOSGVmUk9aTWZ0RkZnNDFCSzlkd3NjelgwV3c1eGtoQ3orR1VkRkdHMW1t?=
 =?utf-8?B?empndGYvMklSR05QMGhhSDJVZXptMDhuc0xuZW9NQko3Njg1djNrTFBCbmk5?=
 =?utf-8?B?VUtzS24wT3d5YUtHYlpxNUFoVVl5UkNrclRNTS90WkNFQStaMVcyNTVIa2ZG?=
 =?utf-8?B?Z3l1Rk8xNjQ5R3ZuNzhYbTF0bVV3aDhLcEF1U2hNSlZqYk1FQzZ6ZDh0aSt5?=
 =?utf-8?B?NDFBdnhQRWtxSURET2FUWkNXWlIraEIrUkFzdkdkOGRaN1Q3RURtbXVpT0Vx?=
 =?utf-8?B?V0xqT2d0YUY3RHZjTkQ1cWJ1Zk1MVkZtdDVUdTAzWFlEa25GOUQwK21BUGwv?=
 =?utf-8?B?TnFjTVh4emRHUHpPYm9YemhlZEpHb0ozM3oxRVk3SlBmZGtBRG45SXNUQ3Ri?=
 =?utf-8?B?TW5xdmRaNXY0WFVwZHpnK3VoTzlIK1BOTWpGU1hzTlRnZlVaYzlWaUlxT1U2?=
 =?utf-8?B?cnFDQlUwVnNWZlpTOW56ajRUWlUxUEhGVWV5T295NHZTekFSYXRTaUFZMVlZ?=
 =?utf-8?B?bDlVMmkwWHY1M0I0V0dETHp3bmUrK2k3U2lDOTVIUk1Ma0tNeUo0WklZQzhP?=
 =?utf-8?B?OFZiYjlFN0M4c1hJRElBejAzcEJzczdNQWg0SDBKV2hqY2w3YmJpMFcxSW8v?=
 =?utf-8?B?NHo5SnE4bG9VelVXbTB0NHRuZWk1SVdMWU1aRjEyT2FNUXhkdzAwdmsrMWV0?=
 =?utf-8?B?QjRYd0dkWEgrZVk3dGh1azJ4dUtxK1VoYjZ6cTErQmdieGU5VHVRVU9xcDdZ?=
 =?utf-8?B?RU01a1J5NVBldjllUUtyU3JPZEdaTzVTZ3lSNTI4dTVVb1poQTdOMkdRaGg4?=
 =?utf-8?B?Y1ZGY2hSaWxQS05yakwrVFEyem9pTC84SThwMTVnamNyS1kwa25tcHEwQmU0?=
 =?utf-8?B?NlkwMUdKV2pZWDI4NFljNjZGOGJRNHM1QUoyRXVNLzRHYVBWVGFJYUp0bmlE?=
 =?utf-8?B?aW4zMmcyVzFOaVh2MS9aWGw5eG1QVGFtL2daU3h1UG1MMzVCNy8wNCtIcjBJ?=
 =?utf-8?B?cHN1eEZoWmx1SHowSGpMa3NUZENQdGU5WW5SYzJRUHBPU0Y0NkRVSlUzWkRY?=
 =?utf-8?B?U3cvQ1p0aGdnckJ4bEI3WmwxMnJqZjNldDlXR20zNXlsaUlNZ0k0enZaT1RW?=
 =?utf-8?B?UTBZZnlKOE1qblZVT1pDR3hGSlpTZ043clJHOVNLTGt4b25obFpMWkE1QW11?=
 =?utf-8?B?T2NWbjNDV21odVYrdmFmV051RUx6N29CYmdOcm51QmdCNjcrSFluaEJPMGF6?=
 =?utf-8?B?NCtoa2g5ejhwWVJ0cnIyWEw2anRQRjI0UWZvR2hSMjZIS1ZrbiswK3hhNmpM?=
 =?utf-8?B?WFZYaW9lZzFzVVYxLy9FLzdFMGIwNzlieHJDUUdBSnhmWFBGR0FsSXNMOGlC?=
 =?utf-8?B?ZWk0WG93QWxzUFBJZmx0eTlRYURmUkdjWWhtZE1KczRTQ0NvSmNLV1pTK3pP?=
 =?utf-8?B?enFjVkdhVko1KzZkSTU3eGo1MXNMTWh3bTZxeUVmblgvSDBHcktiUW4vRmwy?=
 =?utf-8?B?NmhKbzEzbmwxaXFYM2UzemZuOE1LVVhBYi9OdC84Q28wOXBCUVpwQ3dYNEtK?=
 =?utf-8?B?M2U2eUwzWEFielEzYkt6VXh6cVNNY0k4cjNHaGVMeUJnUFFTellPdlpoWFYy?=
 =?utf-8?B?SUxpV1dMdElpMldyOEJqWEN4WHNsUFNkL0NFLzFLRURxREZyUnBuN1VCdHRs?=
 =?utf-8?B?ZW1ieFBVaE4zd3d4MjE4cExyQUt3OWpPL216MituVThCNVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW84YUJTZkowVHVhRDlXbzRuV3dsSlJaVTVaTnhpWkdNcS82ZlpuYitUVzRD?=
 =?utf-8?B?R2wvNUtJQ0FkMnR2Qk4rbWhGUy9PMWtZNTRYZy9zTGlhb1Erc1h2NWpwYW9a?=
 =?utf-8?B?ak1UdFhQV3FvdmRMQzVhVjNNWHQwN3UyR1c2TjdrSGt0WWRmVGc1Q211emR4?=
 =?utf-8?B?VHAyOWtGZ29iRnNsV1l5L1o2QmlldnBWdHE5RUlCdXdKdW9ScDgrcHNLRVI5?=
 =?utf-8?B?eldZcjEzVDBzUTdoWWlOWXFTTkF2RmlBMEpwaVJPNHAvWHRhd0Q3VmRld2Z4?=
 =?utf-8?B?Q2Q5c2lxNkV3ZGRVNVArU1dYSVN0NEpzMEErNEdwUi8rd3dwdTlMaXhCMHRm?=
 =?utf-8?B?MHNzeG1ZUVp1RTh3ZTVSN1FqeVF5aENoaWoxeW8zWFRqbkE4K2dFajFKQm4y?=
 =?utf-8?B?dlg3MC9xT3BEZnF0T2h3UXRCM3BXMmVsOWs3SFRRU2NLZ0FOSU5YWUFoWG9H?=
 =?utf-8?B?YUl5cFFoRVlhUmRodE50T3NHdGFFNVQzNUNocE92d1czZGpsM0JlUitOdGcr?=
 =?utf-8?B?bm5meTBTSE9PRHZSVGQrZEEwLzdRcFBjOEludkplelYybDhXTytQbEhzZEFN?=
 =?utf-8?B?dE1mem55VWM1cStrcFQvb3kzNkZ6NkZZcHBxUjNpY3pRRkZZYnBiQXFsMjd1?=
 =?utf-8?B?ZUUwT25zN1U1dUlrQ1FzUFpmdExYd1NIWkUySHdtdlI0cS9Fbzk0OTlQS2Na?=
 =?utf-8?B?bHVZYUdqYUpydzAxZEpkSHB3RndNQys3NVRCei9DelROWWtEajVTaEs4Z2hH?=
 =?utf-8?B?b3RlVys3L25GdkNTU24wM3c1WlBhRVBSZmZTem1pMmU3OENFSGlnUFZZOEZX?=
 =?utf-8?B?NFk1TUtIelp3ZHk2U0VhaWVKRkJubnJ3bk9FVG5DVUhNSFBaWjFIMkdmRGpv?=
 =?utf-8?B?U2RTelpQOVFpUWJiSUVIQ1RuK1R1Y0N2ZkNyZWp1L1NNY210ZXphbzk1SGVq?=
 =?utf-8?B?ZDlCMGYwL0wralg4bnZ6Um1idmVvVmtpYUN2ajY2aVdsMnlMYjhmQVJlQVFN?=
 =?utf-8?B?R01KSnQ1c3Y4Sng2aHJmL055TVlRMk5SbDkyeGFJQzVEMnBrKzkrb1NNWHFq?=
 =?utf-8?B?Vm1vRlVubEFtT1NMbnZjSjN1TnA0N3dQd2hYRFpOODl5K05ieXBGWGhWeEJD?=
 =?utf-8?B?Q2pjQldMQ2w1bFdWUjhBUkZlYlNKdVlPS0RSNTJhcGlGdW9ZVXBUUGl3RWVi?=
 =?utf-8?B?Y0FuZGRrU3Yycm1WZmlPemxZL0k2Mk1SajlTTUR6TUhteWJNUUVuNVpNbTBU?=
 =?utf-8?B?QjBBSS9SMW5SdXVlMENSZTU2UWNtbWlBQzZ1ejFQUXZOcldwUWtPWjhGM1Z1?=
 =?utf-8?B?RVpYMXZTbG5Uaysrd3ZmRUZZU3o4eW1iNVY4S2NVNWd2Q0dlTnhaM3BGODNl?=
 =?utf-8?B?UG1icXlPK2EvWFc3R21RVVlMNWVDTlFDRlB3V1F3RDVaWXNsSE1OaFoyNDJv?=
 =?utf-8?B?MlExd1gvS0x2SzV6OFNpUk1yT2Z4VmZSVk54c1lMQjBVSkczMjdyRnRoNVZY?=
 =?utf-8?B?ckwxK3VxQ3k5MlR1MnNNa0UyazFIRFR6YkFvb2pEN2ZqTFQ5T1k5d21SZ3Zu?=
 =?utf-8?B?THhab1FWY0I3R3VDeE5uMzFYSjhxS2FQTWhuL2hhWllMSWllWkcvbGJ0S0JS?=
 =?utf-8?B?UXBlU1hDRFFKd0k4Y04rOFdBU2JmdFNwUEsweGpnS1FKZXd0TlJZYXhqZThV?=
 =?utf-8?B?K3NiWFhGdkUramdJc25YMzUwZDh0MnA2OG5LTWp1UHFQdi9LTUNKK2FUQTFJ?=
 =?utf-8?B?OTZ5dHFoeHlwbW9aM3hHcWFvQmp2dlRzclVyQW83M3VpcTBTNjU4L3pkU3Nk?=
 =?utf-8?B?RUNYYmhkVUF4TmIzN0xNRnY4Qmk5N3d5T0xraGJPV21RVVQyV08wQzVhOE1I?=
 =?utf-8?B?QWZFampCV1VmMm9zVHZlamlIQ3BxM2htZXV1N2V2UVBvU1BsKzJzWEg3YXhS?=
 =?utf-8?B?OUtaS0ZWRTQ0MjNpZ01ON2g3SkZPWVZtVk1YN0htK0VUWW5FUVg4QUNuTlhk?=
 =?utf-8?B?dnVuZnRMVEkyR01ERXVTT2trNFRhazlnOVA3MVlrNlNwb2xsS1ZBMFNJdTZ0?=
 =?utf-8?B?dG51ajNCajRZWkNpOUVwUGw4b29tcGFsa1ZEeWxUQVJyY2V6cENvSjB0Qlcv?=
 =?utf-8?Q?ivxH6U4wA6aiz5a51W5jA03Yu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70b5de2-aac6-481f-ce42-08dcd6c0c73e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:31:04.6487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNr1a91lX+TCVHJxaCsyEbeMxVEYZGQMGeUA3Z0IJyrKHyknwDS7euLt2OWOVngq+O4/oLZ8A+2fqD82V9lSeA==
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

disable_cpu_nodes could be reused by i.MX9, so move disable_cpu_nodes
out from mach-imx/imx8m/soc.c to mach-imx/fdt.c and update
disable_cpu_nodes to make it easy to support different socs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/mach-imx/sys_proto.h |  2 +
 arch/arm/mach-imx/Makefile                |  1 +
 arch/arm/mach-imx/fdt.c                   | 87 +++++++++++++++++++++++++++
 arch/arm/mach-imx/imx8m/soc.c             | 99 ++++---------------------------
 4 files changed, 103 insertions(+), 86 deletions(-)

diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index 31ae179b211..d93e095e191 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -275,4 +275,6 @@ void enable_ca7_smp(void);
 
 enum boot_device get_boot_device(void);
 
+int disable_cpu_nodes(void *blob, const char * const *nodes_path,
+		      u32 num_disabled_cores, u32 max_cores);
 #endif
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 5262dca4ffd..47e2cb8d943 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -12,6 +12,7 @@ endif
 ifeq ($(SOC),$(filter $(SOC),imx8m))
 ifneq ($(CONFIG_SPL_BUILD),y)
 obj-$(CONFIG_IMX_BOOTAUX) += imx_bootaux.o
+obj-y += fdt.o
 endif
 obj-$(CONFIG_ENV_IS_IN_MMC) += mmc_env.o
 obj-$(CONFIG_FEC_MXC) += mac.o
diff --git a/arch/arm/mach-imx/fdt.c b/arch/arm/mach-imx/fdt.c
new file mode 100644
index 00000000000..df6fbf51dba
--- /dev/null
+++ b/arch/arm/mach-imx/fdt.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <errno.h>
+#include <fdtdec.h>
+#include <malloc.h>
+#include <asm/arch/sys_proto.h>
+
+static void disable_thermal_cpu_nodes(void *blob, u32 num_disabled_cores, u32 max_cores)
+{
+	static const char * const thermal_path[] = {
+		"/thermal-zones/cpu-thermal/cooling-maps/map0"
+	};
+
+	int nodeoff, cnt, i, ret, j;
+	u32 num_le32 = max_cores * 3;
+	u32 *cooling_dev = (u32 *)malloc(num_le32 * sizeof(__le32));
+
+	if (!cooling_dev) {
+		printf("failed to alloc cooling dev\n");
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(thermal_path); i++) {
+		nodeoff = fdt_path_offset(blob, thermal_path[i]);
+		if (nodeoff < 0)
+			continue; /* Not found, skip it */
+
+		cnt = fdtdec_get_int_array_count(blob, nodeoff, "cooling-device",
+						 cooling_dev, num_le32);
+		if (cnt < 0)
+			continue;
+
+		if (cnt != num_le32)
+			printf("Warning: %s, cooling-device count %d\n", thermal_path[i], cnt);
+
+		for (j = 0; j < cnt; j++)
+			cooling_dev[j] = cpu_to_fdt32(cooling_dev[j]);
+
+		ret = fdt_setprop(blob, nodeoff, "cooling-device", &cooling_dev,
+				  sizeof(__le32) * (num_le32 - num_disabled_cores * 3));
+		if (ret < 0) {
+			printf("Warning: %s, cooling-device setprop failed %d\n",
+			       thermal_path[i], ret);
+			continue;
+		}
+
+		printf("Update node %s, cooling-device prop\n", thermal_path[i]);
+	}
+
+	free(cooling_dev);
+}
+
+int disable_cpu_nodes(void *blob, const char * const *nodes_path, u32 num_disabled_cores,
+		      u32 max_cores)
+{
+	u32 i = 0;
+	int rc;
+	int nodeoff;
+
+	if (max_cores == 0 || (num_disabled_cores > (max_cores - 1)))
+		return -EINVAL;
+
+	i = max_cores - num_disabled_cores;
+
+	for (; i < max_cores; i++) {
+		nodeoff = fdt_path_offset(blob, nodes_path[i]);
+		if (nodeoff < 0)
+			continue; /* Not found, skip it */
+
+		debug("Found %s node\n", nodes_path[i]);
+
+		rc = fdt_del_node(blob, nodeoff);
+		if (rc < 0) {
+			printf("Unable to delete node %s, err=%s\n",
+			       nodes_path[i], fdt_strerror(rc));
+		} else {
+			printf("Delete node %s\n", nodes_path[i]);
+		}
+	}
+
+	disable_thermal_cpu_nodes(blob, num_disabled_cores, max_cores);
+
+	return 0;
+}
diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 9ed27b59303..68d5762c2ce 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -1135,79 +1135,6 @@ int disable_dsp_nodes(void *blob)
 	return disable_fdt_nodes(blob, nodes_path_8mp, ARRAY_SIZE(nodes_path_8mp));
 }
 
-static void disable_thermal_cpu_nodes(void *blob, u32 disabled_cores)
-{
-	static const char * const thermal_path[] = {
-		"/thermal-zones/cpu-thermal/cooling-maps/map0"
-	};
-
-	int nodeoff, cnt, i, ret, j;
-	u32 cooling_dev[12];
-
-	for (i = 0; i < ARRAY_SIZE(thermal_path); i++) {
-		nodeoff = fdt_path_offset(blob, thermal_path[i]);
-		if (nodeoff < 0)
-			continue; /* Not found, skip it */
-
-		cnt = fdtdec_get_int_array_count(blob, nodeoff, "cooling-device", cooling_dev, 12);
-		if (cnt < 0)
-			continue;
-
-		if (cnt != 12)
-			printf("Warning: %s, cooling-device count %d\n", thermal_path[i], cnt);
-
-		for (j = 0; j < cnt; j++)
-			cooling_dev[j] = cpu_to_fdt32(cooling_dev[j]);
-
-		ret = fdt_setprop(blob, nodeoff, "cooling-device", &cooling_dev,
-				  sizeof(u32) * (12 - disabled_cores * 3));
-		if (ret < 0) {
-			printf("Warning: %s, cooling-device setprop failed %d\n",
-			       thermal_path[i], ret);
-			continue;
-		}
-
-		printf("Update node %s, cooling-device prop\n", thermal_path[i]);
-	}
-}
-
-static int disable_cpu_nodes(void *blob, u32 disabled_cores)
-{
-	static const char * const nodes_path[] = {
-		"/cpus/cpu@1",
-		"/cpus/cpu@2",
-		"/cpus/cpu@3",
-	};
-	u32 i = 0;
-	int rc;
-	int nodeoff;
-
-	if (disabled_cores > 3)
-		return -EINVAL;
-
-	i = 3 - disabled_cores;
-
-	for (; i < 3; i++) {
-		nodeoff = fdt_path_offset(blob, nodes_path[i]);
-		if (nodeoff < 0)
-			continue; /* Not found, skip it */
-
-		debug("Found %s node\n", nodes_path[i]);
-
-		rc = fdt_del_node(blob, nodeoff);
-		if (rc < 0) {
-			printf("Unable to delete node %s, err=%s\n",
-			       nodes_path[i], fdt_strerror(rc));
-		} else {
-			printf("Delete node %s\n", nodes_path[i]);
-		}
-	}
-
-	disable_thermal_cpu_nodes(blob, disabled_cores);
-
-	return 0;
-}
-
 static int cleanup_nodes_for_efi(void *blob)
 {
 	static const char * const path[][2] = {
@@ -1359,6 +1286,13 @@ static int ft_add_optee_node(void *fdt, struct bd_info *bd)
 
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
+	static const char * const nodes_path[] = {
+		"/cpus/cpu@0",
+		"/cpus/cpu@1",
+		"/cpus/cpu@2",
+		"/cpus/cpu@3",
+	};
+
 #ifdef CONFIG_IMX8MQ
 	int i = 0;
 	int rc;
@@ -1402,13 +1336,6 @@ usb_modify_speed:
 
 	/* Disable the CPU idle for A0 chip since the HW does not support it */
 	if (is_soc_rev(CHIP_REV_1_0)) {
-		static const char * const nodes_path[] = {
-			"/cpus/cpu@0",
-			"/cpus/cpu@1",
-			"/cpus/cpu@2",
-			"/cpus/cpu@3",
-		};
-
 		for (i = 0; i < ARRAY_SIZE(nodes_path); i++) {
 			nodeoff = fdt_path_offset(blob, nodes_path[i]);
 			if (nodeoff < 0)
@@ -1440,16 +1367,16 @@ usb_modify_speed:
 	}
 
 	if (is_imx8md())
-		disable_cpu_nodes(blob, 2);
+		disable_cpu_nodes(blob, nodes_path, 2, 4);
 
 #elif defined(CONFIG_IMX8MM)
 	if (is_imx8mml() || is_imx8mmdl() ||  is_imx8mmsl())
 		disable_vpu_nodes(blob);
 
 	if (is_imx8mmd() || is_imx8mmdl())
-		disable_cpu_nodes(blob, 2);
+		disable_cpu_nodes(blob, nodes_path, 2, 4);
 	else if (is_imx8mms() || is_imx8mmsl())
-		disable_cpu_nodes(blob, 3);
+		disable_cpu_nodes(blob, nodes_path, 3, 4);
 
 #elif defined(CONFIG_IMX8MN)
 	if (is_imx8mnl() || is_imx8mndl() ||  is_imx8mnsl())
@@ -1466,9 +1393,9 @@ usb_modify_speed:
 #endif
 
 	if (is_imx8mnd() || is_imx8mndl() || is_imx8mnud())
-		disable_cpu_nodes(blob, 2);
+		disable_cpu_nodes(blob, nodes_path, 2, 4);
 	else if (is_imx8mns() || is_imx8mnsl() || is_imx8mnus())
-		disable_cpu_nodes(blob, 3);
+		disable_cpu_nodes(blob, nodes_path, 3, 4);
 
 #elif defined(CONFIG_IMX8MP)
 	if (is_imx8mpul()) {
@@ -1495,7 +1422,7 @@ usb_modify_speed:
 		disable_dsp_nodes(blob);
 
 	if (is_imx8mpd())
-		disable_cpu_nodes(blob, 2);
+		disable_cpu_nodes(blob, nodes_path, 2, 4);
 #endif
 
 	cleanup_nodes_for_efi(blob);

-- 
2.35.3

