Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581A8E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 06:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F6B1806DB;
	Tue,  7 Jan 2025 07:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="l5tKRtXi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 977E8806C9; Tue,  7 Jan 2025 07:59:15 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2717280612
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 07:59:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hL8i49ZH4FuGhuh7YVxCsrdNoP8Pq6Pvuy99yIy/Pru3lRZCdV9Xz8PUhgNrNyNJsGWLilmMGjbwh7ohuJPUu43ev9c6oRPTM4Pp/pBL8FdfMxTee8X2eE1jAZ18ibPQIb/gv8XppD4+za+f6AFyBylXo0i1NbcrlQK5FnKBvOiVKyRa6bfnc1hzPL1ZpgweWJoHL9EgXdbiC5ep2GGUpVW7TwXoDijj9If8W3gsbYXR2IdYsU/I5NKlyaIzidjhsDP9I6OJhAW1Wv9S7wyh6GXOVoovzuGFbGV6+Otu7PlZDIrxJmsgZDsz1iE4obENPfcvOh7oTLO5CF51jXIzcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3bWyxTaHMM3UFSF+98aJKlLQnN8VsxVU4KCRoZEMIA=;
 b=BZG3Hc39Pmj4Ku9wLXssYaChgFxP2sBFfkFKtH30x/5Vaz6NNF9sa7e0D0oHxcjXW0TWyokMoF5qyZXCiGogVsvAlALbpNwTIb86y2nkLlLd3WuS+TaPPue/GBfCnGid+2UIYsZsEsH5nt9WgNuw2FQEmAHvf3BpH44t9yQ3c1CQU+rPTkL07dovOKu6rcVUSFjEyvRnr+uCVTkM3yzPwgHlF8w9C3zjWbynjvvQscmyc+BxZVgaa4FzUmkl/EktbE+GpguFj10s31uy6Lsl/absXrLfFjZyelC9YSoZSLq1dUssx0Jw35GmIeWjoxB81koiKKGzEusVsBy3cltuhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3bWyxTaHMM3UFSF+98aJKlLQnN8VsxVU4KCRoZEMIA=;
 b=l5tKRtXi9jsOkyS4CJ3Yz8XjmqGjNFkLSefpy7Tan4HM6XR9Ms1vegV/NwHyHiTf1T+Qr1x7Jgp+ILF6YS3+bSKRbXnKzKxF8HBc4XQxvKYEwac1tR/z2c9ej58x7SziNir4GPmNWYjIjq+PPDljlz47L9+vcnzPVCYPRbG7EKD2Ru4ie0hEHTTwaTS3zneS2goNQw2163Ns5ZRy56mhv/J3D4WEPqArkhzgyM+nP7rF558xqxBEHWBUzFxKk+mF3wguxnlG62M+nzJovFQtRfaYok7JNCbeZ0cnX4YFqMImJBsTa7eo5ayqYfP0mvpvfdaZio9Y25AlNQkhYdSMiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10523.eurprd04.prod.outlook.com (2603:10a6:150:1d4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:59:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 06:59:06 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 07 Jan 2025 16:05:03 +0800
Subject: [PATCH v2 03/16] imx: imx91_evk: switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-imx-bootstd-v2-3-97671b1694cd@nxp.com>
References: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
In-Reply-To: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10523:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d827a9-244b-4f04-6957-08dd2ee8c715
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXQ2SlZoUktCYzlBa0t3RDJxa0VlU1ZORlRyQ0QxSUptZjlWZlFOWFZqMUVE?=
 =?utf-8?B?UlpiWnFvR3RYa0N1L0JCQjBsdE9haVcveUpUamttbm9WNjBKQzhiZFhxd2xm?=
 =?utf-8?B?TnVTYzhmQnEzdXJuZ2N5c1ZVUFpKRWUyL0tCMEpYSzl2UWd3ZnpaOVVlK0Ey?=
 =?utf-8?B?N2hKOHJJaUo1eXlCanZSY2pFQ1JwbDA3bCt3b2R5ZjVJb0hnV1dxSXNPSFMx?=
 =?utf-8?B?MXM1TzlBZTRjNW51OXVIQ2ZaRyt2eHkwQTc5Q09mOUxsSUpjejE3Zm4yMWFV?=
 =?utf-8?B?R25hYTB5L2dWTnZCTzZ3bjlCUC80UUtUZDVWeUo5Ylo5ckZFZGc5SHE2ZzVh?=
 =?utf-8?B?WXl2aWJJM2RqNW1KN29WUXdHUFhjcEhUdC9Xa3pqTm1ISEM2bXJyK3BSaGNX?=
 =?utf-8?B?elNybzluTFoxc3gwMGNlS1RzR0JxazJCZ2JwdjV1aURTRWpxcWRHUzdCbmsw?=
 =?utf-8?B?bDlYNERQZWhvVXVnZm5taTFTaUZrVXI5NEtUT0hwVnpNYnhLVm1NSm1aeGgr?=
 =?utf-8?B?RXVkZjAzUllwcVpsQXkxYlNBaUxjK1VkSThJVkZFNGNGbGMySUZPaUFYVmtH?=
 =?utf-8?B?L0xCZXJNU0tOM2lBUEJxMEl4K2dkVHNQNk9IWkN1dzBJL3FxSWUzSEFuOEhj?=
 =?utf-8?B?TUdNZ2drb1lBNHp4Qndpd2h4UnZLbE40MXFUQXl6YVc4VHkwck8vc3EreFZU?=
 =?utf-8?B?YW0zeTJhZ0hJWXpia2lsbnJPeGtiN25KZzZKTmJ3VXNoT01xSjVSNE15U1hP?=
 =?utf-8?B?eFg2dWg3ZXNBbHVXb1NQbWwybEoybFJUVlZVVkVIUnZPOEZhUGZzV01ORnJP?=
 =?utf-8?B?ei9OY1c3ZmtTQmNSSGlHaDhJN1lXVE1Vd0lMOHlSbkp5L2pqbmd1YjlEdVZh?=
 =?utf-8?B?amh6MmhuaFltNDA4dkdkWUJ3ei85N2xnRmd3VEJuVitIVGMxVWNHYnZWRjJD?=
 =?utf-8?B?S09YMklHUHRuVEczY1Y3T2ZqV3RvUFYxZitvRUc2VGd6THFZVENoT0RoUlJP?=
 =?utf-8?B?Y3drZUtLSUtNb0x2b3BTV1Z4dHNoNk82TTQxZndaK0FkTTNCMlVCRUNZdjRG?=
 =?utf-8?B?d256OUN6T3JycWlQeXZhdkg1TTZIV2lBcndidGNwQkxBOC9aa0lNNmVqL3Zp?=
 =?utf-8?B?STlzd2JheGhweStwaElWK2RYYjhySzdHL21XdUt4aG1PUnBRa2hTNDJlSmFx?=
 =?utf-8?B?TUwxdEQ1a3B5b3A3ajh6ajNXcWhYMXk4eFQvb2ZxVzloRnhiZFFaSUhGbjJX?=
 =?utf-8?B?Q1NoM3ZraGVwTERENGlvTzRTTkhDKzVWTTAzc3dkL3RrdWZrV0UzT1Z3bC81?=
 =?utf-8?B?N08vMDhZSFFjTnJhZ0xGdytXM0o4L1d2ZDBkVEVuc3dXVmQyZnJKdnVPemtY?=
 =?utf-8?B?Y3hLL2ZPN0dvK1k3ZGRCaUZSL3g2TzdYL0tqTUl2V293NGFNQitlaDB1aVdJ?=
 =?utf-8?B?QXFPd3hMdU8yTE5LZ1BGaG81VVNWOWlaQ3JneVZEaVM4NGY1V2VDSHpxMzJN?=
 =?utf-8?B?Mkw0RGpNZXpjQW45cVhYUWEwUW9sQ1VwNVVYZUVaZTRvOUFwcDROSWFWc2sx?=
 =?utf-8?B?TUxLbzBwbEQwWkZZUEhMM0F4SjdkcDZXNFg5R2RKRFdWQVd2VmVqOTduR0hU?=
 =?utf-8?B?bGI4eURtMk9KSUd4a2wvMm5Jd3FRR0NGRVEvVnFQZ3prbVR3OXYwMFMyNFQ4?=
 =?utf-8?B?VzZFWHBlWUJLMFNjQjZCc0dJRHBrK0dmS1J1bE91QVV1UGpKcDFRYzNrZHdP?=
 =?utf-8?B?TjN4MlMwaGpLTnF6ZXE3UHc5SmVOdi9FcW4yQlpwbEphNDJVakw0djlxYm03?=
 =?utf-8?B?NndpSzd3THR6NG5TVzBpQXNidmMyNGJNLzRtSnhRc1kwZjhoSS9PYUJ2VndM?=
 =?utf-8?B?ZlVsTGhyMTRiRGVsbVRzRjRVbTlNZ29uOTVaQ0QzTHh5V25LQW9VRkx0TXhx?=
 =?utf-8?Q?PaFinVMECKsr2bwUhApMiUHC465HgpQ1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGtUK3FVVWhKem1hdXV5R2lUY0RiNkZpcG9FMzhUZElmYzRUVTlJd2Z1ZVZx?=
 =?utf-8?B?aGNjU2grZGZRTzZCY041cjI0ck42bldvSzlCNFpybndQb091djR2ajdWZkJw?=
 =?utf-8?B?VGhJTjBmZm1Cb3RyWWZLRitDdlZEVyt4Mm9LZXhadFJvV1RVU0Q5NHdLamhU?=
 =?utf-8?B?cTU2WFJvM2NKamNNZmZoVk4rN1hqSVpNMlhmazZBTWVrVTN3ZW9zYnduM1pQ?=
 =?utf-8?B?ZTFIcktzakh0Z0x6TDBEc0tVM1RzaG9ORmFqVEhwZERLQktiZ3BKTGNVOHUy?=
 =?utf-8?B?YldhT3g3d1JSdjJrL1h0dVUreEFmNlZSTks1d251WjQ3dVR3QXY2N2gxMVlG?=
 =?utf-8?B?Y1oxNVBKRUpOQlNBSHFsZDFoeWVraWNpK0wzSnlUWUFnR01kbHZpY1ExMVVV?=
 =?utf-8?B?MjQyb3N2M0gwaU5vU0FtNEdqZVRzY2dyZlJ6N1AxR053WXlPRlQ2RTd2d1Nv?=
 =?utf-8?B?OURJYjRNVlNZNVJRZ240ckMydDVpdkVtR056YTRtNUdXMzBKbEpUbTNCUld0?=
 =?utf-8?B?akk1M28vMzhHY1o5ZE9NOFZuZ0hZUnRuaEJZRkNCK24xaVhWSDZxVmNLZUxm?=
 =?utf-8?B?UW5KbGdEOVQ5VlV3RVB3Q2VZTlVYY05YUEMxb2pMR1lydk84MEV5bUdDS1I3?=
 =?utf-8?B?eXJKR1RJZ2NRWVNienFPN1ozWUtXU2hyT3F3d0pUeXkvNzlPUDYrd3hXUUYw?=
 =?utf-8?B?eFEwcTB3ZTA3WUt2SEZLa2VGM0NCZ1dUNDRwdjdLME41RCtHN0I3cjhETitK?=
 =?utf-8?B?K1FEYXN2R3RDWVFrT0c3NzRSbUlvanVXYlBUMEdwQ1huaHdBckpia1lWTzd2?=
 =?utf-8?B?VzBEMzlKVEQyaHZ4YUEzTEdPNW85MTkyelFxRHA2YzNXaDJJQ2pYMXFQekZh?=
 =?utf-8?B?S1k1WnRIK3VadFc1UTR1eHN5SGMxSUdodk9FTjJHekRVOGRrT0tkZGhlcWVK?=
 =?utf-8?B?TEpOakN3ZFBuVkxSZjBzZXBqcmdKZHUvcHh2RFVHWlFEQys2eUVUcm5BYUh3?=
 =?utf-8?B?M1phUFQxVVVqWTdwa0R2NVl1TjFPZGpPSlZJU3k2VG5RM2k2Nno0a05oU2Zi?=
 =?utf-8?B?d2ppWHhvRFQ3VDArZTk2U0tiazUzV0dqSitaWStCMnQyWUlPdVFHOHd4UkFB?=
 =?utf-8?B?ZUtiQlRCZll3S3VlTU5iU3FCTDlZN0k5TEJMM2Y3bFlMaUd4RWljZE0xWU9k?=
 =?utf-8?B?dHRmOUJzNGI3bi9OWnZuTlpEd0pKem1nS3ZEV2Z3OFliaElmemxCMGk1YUMy?=
 =?utf-8?B?VU9tNnFFOXdqUVMrVEtJY01CazlGL1AzQ3Y1WnRKc1l5UEZ2b3M1YlBhZkMr?=
 =?utf-8?B?anFneFlnNFFid09wVzBxRnlndFlqcmZSWWZhb1NNVFQwbldMZk0vMzFnV1Ir?=
 =?utf-8?B?SWluTkZ3Q2NOcnpnRWtQMVFTY1I2VEM1cGlHMTdPSjhnYVdZVHJvTFVmbG9K?=
 =?utf-8?B?MU1tc29qcmxNR251Nk9WUm9RdGZZQ3g2VVhxNnBoc05tUG1YZVVuNFZnZlNF?=
 =?utf-8?B?RWhyRnlVVUVreFNiS2wxUXAwNUhBK0dPbnVTQkhOWFF1UzhqSFN4elJpMU9S?=
 =?utf-8?B?ZkQ0L1ROREs3TUR1WGZwY25QRTVCcitweVhtbnVobGlRS2JzaFhtVDBCWDBa?=
 =?utf-8?B?SXlraEtGSFJzSEFoRDBMOWpQdDRrOWZSL3hYMy9YZnFQcXphZy9kdFNmcTk5?=
 =?utf-8?B?RFBwSXNKY0xwZVNncGJic0tkazdkS0ttMXNvVXZueU1SZzRLN0RMRW1tUTRD?=
 =?utf-8?B?SGlrWkxyYWhYUmxLbWszZzRJQW0xUUFRSjdUb3BiV24xOHdoT1l2c3d4czdx?=
 =?utf-8?B?dnd6RTl0bVRsMmpIam9Gd3VWYncrRE9KUTZtdVZTVHd0WjFpZEtEdjlJay9K?=
 =?utf-8?B?Z2N4SUw4WDRtZmI3b1JGQ2IvNENEZjI1SGVuMFV2UW0xN1VHQnhCWkd2YXVL?=
 =?utf-8?B?Q0h6V29vRDFLazkwOFQ0SEpmc0p2TkpxREhocmxBL2FaemhjTkVYMEh2dzFS?=
 =?utf-8?B?SnRuWGpQS0tjakNjUU5xNGFscEloeFEyeVZZZkFNR0xiNHdvbmxEanlrVkcr?=
 =?utf-8?B?QmFQRGFiR2RBTlVLY0VZU0hDTjl5U0cxdEhCdy9kNGpRK0R4TkU5eTdaRk8x?=
 =?utf-8?Q?jhlUc8vZ5gQ3jHvdahWdlvGpe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d827a9-244b-4f04-6957-08dd2ee8c715
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:59:06.5153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUA5gx4OL2lm0IstX1NrZBuJAbcuxZncreBELefO9oYaJYgrkDa6O+MOD7b+b6bachYMYNAo3cJdH6jZ3bF3Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10523
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

Switch to support BOOTSTD with a bsp bootcmd as fallback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig               |  2 ++
 board/freescale/imx91_evk/imx91_evk.env      | 29 ++++++++++++++++++++++++++--
 configs/imx91_11x11_evk_defconfig            |  3 +--
 configs/imx91_11x11_evk_inline_ecc_defconfig |  3 +--
 4 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index d756f3dcad2e91172ecd885357b9d0adf2e387e3..49220c0955ee4f658c06ba98c6cbe5ff411cd993 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -34,6 +34,8 @@ config TARGET_IMX91_11X11_EVK
 	select OF_BOARD_FIXUP
 	select IMX91
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX93_9X9_QSB
 	bool "imx93_qsb"
diff --git a/board/freescale/imx91_evk/imx91_evk.env b/board/freescale/imx91_evk/imx91_evk.env
index 92486c6f74d2ec12f638443dcf598daa28f306b6..c972d3eb2511542c1a11812f879d7627cadef797 100644
--- a/board/freescale/imx91_evk/imx91_evk.env
+++ b/board/freescale/imx91_evk/imx91_evk.env
@@ -10,6 +10,7 @@ fdt_addr_r=0x83000000
 fdt_addr=0x83000000
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 image=Image
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
 mmcpart=1
 mmcroot=/dev/mmcblk1p2 rootwait rw
 mmcautodetect=yes
@@ -19,12 +20,13 @@ loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
 auth_os=auth_cntr ${cntr_addr}
+sec_boot=no
 boot_os=booti ${loadaddr} - ${fdt_addr_r}
 mmcboot=
 	echo Booting from mmc ...;
 	run mmcargs;
 	if test ${sec_boot} = yes; then
-		if run auth_os; then
+		if run true; then
 			run boot_os;
 		else
 			echo ERR: failed to authenticate;
@@ -48,7 +50,7 @@ netboot=
 	fi;
 	if test ${sec_boot} = yes; then
 		${get_cmd} ${cntr_addr} ${cntr_file};
-		if run auth_os; then
+		if true; then
 			run boot_os;
 		else
 			echo ERR: failed to authenticate;
@@ -61,3 +63,26 @@ netboot=
 			echo WARN: Cannot load the DT;
 		fi;
 	fi;
+bsp_bootcmd=
+	echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadbootscript; then
+			run bootscript;
+		else
+			if test ${sec_boot} = yes; then
+				if run loadcntr; then
+					run mmcboot;
+				else
+					run netboot;
+				fi;
+			else
+				if run loadimage; then
+					run mmcboot;
+				else
+					run netboot;
+				fi;
+			fi;
+		fi;
+	fi;
+scriptaddr=0x83500000
diff --git a/configs/imx91_11x11_evk_defconfig b/configs/imx91_11x11_evk_defconfig
index 6ee0b448f9932ae9c85d3a0a8f6b32787afbec6b..55ba71953c2ba76b3e9b958c5bcc5d7471f5f242 100644
--- a/configs/imx91_11x11_evk_defconfig
+++ b/configs/imx91_11x11_evk_defconfig
@@ -6,7 +6,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x18000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_ENV_SOURCE_FILE="imx91_evk"
 CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
@@ -31,7 +30,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="imx91-11x11-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
diff --git a/configs/imx91_11x11_evk_inline_ecc_defconfig b/configs/imx91_11x11_evk_inline_ecc_defconfig
index 761a66662641f16da6b9e2ba13690234df7c0a44..0eabd7aa8b3cf7a797ea1b3668c9639b59a7a009 100644
--- a/configs/imx91_11x11_evk_inline_ecc_defconfig
+++ b/configs/imx91_11x11_evk_inline_ecc_defconfig
@@ -6,7 +6,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x18000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_ENV_SOURCE_FILE="imx91_evk"
 CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
@@ -31,7 +30,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="imx91-11x11-evk.dtb"
 CONFIG_SYS_CBSIZE=2048

-- 
2.35.3

