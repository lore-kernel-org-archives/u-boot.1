Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1540D2F344
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 16:36:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 139B2808AF;
	Tue, 13 Jan 2026 17:36:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="l4RCYhK+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4A14803F5; Tue, 13 Jan 2026 17:36:51 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF03582C7F
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 17:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCwdhsr9wH+7i/5gIyGBQwg2dFZfqgT/OF9fnQ1/YBcdYDbkdFDJdnUCJN95sYbg//Xf70LntGk8ZExNT8Q18ObD/OsjO9WH+churyHMph6ZA85fhzyT4oqFDpwdynqSFVIdbNKm/khTlL8w1mii3lIS0p5sB+8QtTdiQJcuhgTGCiB0pvFUzjEjGZtcFhjVXgrNdtoYeUl5Rb/u4wD7tdIyqaR3OQnCGrElyLQ2d7eWPalLa7Lb044VBq3hcqGcbznY/zvwBPyLw/j/tEWAFVx1DTr+ur7VM7F3zdP+M0wsWywGtekcecguGGwqGlAFSfIs2w2C/ZJs6WWdQ7+XCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OVnLks37kTIfw9lEoCuKd95XSm5ujzcP+qSCfcfbxA=;
 b=Mj4nKKQkv4vW0LGBqcpM4B2brQS5V6No9UWFjvRl5zrGG1B5LifWUdjK3GnbQZ7PaXvSbLAkc5TQskJtoFhcbjUfW88sJ39ntkAltrpTitN0/yOjVbP3UHkOgU0OpTasBufQP8iPcBMFRS872ZAwaNd/NAKlV0rmIW07wd9XpxWjZ1/zmJWiBb8ELWR02AZ7MaZO/fKQFCPfJfU9hLz/Lwy7fPSFhykeSimtcYEuIOCe+MlFHYg2jtBZXujYCrOrlLcOpLHvv+bM99qACxH/Q2Xtp9SAcER0qf5z8VQxhMF0Z4cO6Sus0K95tl9/2RH/4KRWcInDF5OWXEJQAR1USQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OVnLks37kTIfw9lEoCuKd95XSm5ujzcP+qSCfcfbxA=;
 b=l4RCYhK+KlHvKsws8i+04e3CyiUEYisYzmAFNJZNgxV26E3SbVj5BhoUA1cXGHOlzvSIlTJqokXq6K8Jy9HF333beQtCoPNuxLb7NJTjXahxOSpTm7PzjY350Sp9Opl6n0v4PLfhiZ4p+NOrKKIm9o1TFXeom5lpt8pa1nm+QdQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI2PR04MB10285.eurprd04.prod.outlook.com (2603:10a6:800:21e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 16:36:47 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 16:36:47 +0000
Message-ID: <c9bb34c3-d38e-4560-8de5-4532605495b9@cherry.de>
Date: Tue, 13 Jan 2026 17:36:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] usb: fix typos in include/usbdescriptors.h
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20260102191956.266773-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260102191956.266773-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::15) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI2PR04MB10285:EE_
X-MS-Office365-Filtering-Correlation-Id: b77e5d4f-1234-4538-bf28-08de52c1f1b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTF0N3JaWHozQ0VpMHMyb2I5VkExYUhqaWZUWkkxQU9Fd1VNdU1mZitKRUIy?=
 =?utf-8?B?Ni9BaGlUY0VPY0ljWEFwUmxNSitJT1E0SnJSU3dEcXNsa0NIZ2pRTElxWUlv?=
 =?utf-8?B?Rk9UZ242SUVRU0NkY05Rby9INlpDQTl2ekZYRjA0QjFaWXJac20rV0huS2Y5?=
 =?utf-8?B?YlZ6V2h5S2JYci9NQ1hiY1VSUjdPTEhrT3NtK2NpMytTOHZOeDRPM2Q0T1g5?=
 =?utf-8?B?SEkwK0NwU2c1VXkxUE9ROVFiWG5TNHVqK1B0Z3NtN2ZFTWN5OFFLOUc2WEZw?=
 =?utf-8?B?YUlZNWhXblRvLys3ZUVyd24xdmhJRVZhZDJ1Qi9veSswOGtxeFFYUUdIWTMw?=
 =?utf-8?B?K0VLQys5OFRnNlBRNHFqM3JVc0FqNTV0ZWRGZEgvalhNcUN1NFVwZExJMHd0?=
 =?utf-8?B?anpZK2k5T2dNR3V6MDRlSURkcnBQU0pCNHRYV2xPRXpnWU5tTjFtTHZubXVr?=
 =?utf-8?B?WElHZlMwK2NOQkVna0NIN1ZyUkxhUWhVUVgvSWIxTERBSStOOG5rV1g5TTRw?=
 =?utf-8?B?ZEEzYzZyS0VYd0UxVVBNN3RpaEpmenVydDZXUVVKUU1vQnhraFFMY085ZFEw?=
 =?utf-8?B?MkRhQUtsb0lTekpxRHFWaGphQllCaTMxeDFpVy9xVW1NSUVsbTBQWGtncjU2?=
 =?utf-8?B?M0FEdjNEbDNFR0M5VnUwd3hCR29jbTBZM0IvV3k2V0pqcUJYdDRRQTBaSnVF?=
 =?utf-8?B?Ny9kazNFTjEvcVpSc2NVS0lCTkd5Q2Z0R0N1YUd0SkRnaDlWWElScjFRb3R1?=
 =?utf-8?B?T3NPZ0VMV0IzQ04rSktMVFQrWGRKRWhEUDhIM3RBMExici9maXpLcHFpOXZE?=
 =?utf-8?B?ZDdweE9jZlZEaDZLRi9YeE5sdUNZc1ZvU2Q2TU9FTVlCVGdnTFNJMHdaM1ps?=
 =?utf-8?B?TGhXRlo0eVZWYjlkWW5lQlBRRDRVZHF5OExLWUZjRE5neCs0U2xMamZGZnlL?=
 =?utf-8?B?OEhBekhxM2JUV1g1cjF1OE9yQzYwOFgwcXBOMnAzcTZiQU9oS1ZPcHBxUFlq?=
 =?utf-8?B?amIzUjVqTUp2ZWduWjM1SmR3T0Fna201UHlWWEwyTXpVbjUyTXhkTUk4ei9h?=
 =?utf-8?B?ZGFrbmM2cTRuQTRFbkdqQjVnSDZaUUFlSERRRGxST3dVMGJGdkZUZmR3ekdK?=
 =?utf-8?B?Q0xPWGRldHZUNElBRjFhTktPcWc5R2F3SVBtMnB0M24zUFFXejB4N0NZUTk5?=
 =?utf-8?B?bkZJUklNeE5iYUk4SG1IZlpQYTdReHRic2xVYjJOdVprV2k1YnJia0wySGJH?=
 =?utf-8?B?MWE1VG81ZGdtNUM5MTJMZlRkVzl2TnRoZnJqcHo3dW0rZjhIeURldkhlMFlN?=
 =?utf-8?B?TVR5cWxSYytrbWtWNjdPZFA5MmFMMktmaHJNTCtrQ2dpZklQTEdET09GblE2?=
 =?utf-8?B?K1g1WUNhdE5RYVNVOUwvb3UzNjJ1T0h1ZzE4d2k5bVpiYjJXWXo5RE9Lbkxx?=
 =?utf-8?B?cGhTeWF1WVo5bEpZY2hKdzRKbllGc0VMaG9lR3Y5ZXkzcGQ5cDZHd2RHci8z?=
 =?utf-8?B?dXRNbjVwNFVOck1BcHgrbWlpdkozbVVEVnVEWXpBNmFlazlQWkhKRFg0MjlF?=
 =?utf-8?B?bGtOYW9FTGdpV09SZktESEs2SDVtVGUyakhMbzI2MWZNMWtmeWYyaUxSR01v?=
 =?utf-8?B?Q2c1RlZTUm11bDIxMENpeGtSU1d3VTQzbHE4ejBYMnE4ZVg5ZWhOUzhFU05x?=
 =?utf-8?B?OXJDSHFRMHVHazhSR2FXZnVxVDB1TVBLMnhkSWZvN1ZsM2I0WmpiSTkva0JI?=
 =?utf-8?B?ZkRwckhPbmVPNE55dGlyZnFsVTFLR2pwT3Z3cldYanltUmp2R05GZzdpc01y?=
 =?utf-8?B?Kzk3OFN0MC85ekJrZnVpZ2V0RjI4TGl1cklEc09oQXBhMWFUd2daeldHOXNG?=
 =?utf-8?B?blVxV0hTSnRjbG9wR3l5dHB1azJqcnhYNW9mM3ozVnVwQUwrTStDcDAyaUJH?=
 =?utf-8?Q?2FyialXT5s54zf5+OE9olDXMHQvXmKOz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dENudW1EVEMyWnVna3pKL3kxSmYxdEVBVDBRdEZ5dmNVenNHM3F6b0JSWWJD?=
 =?utf-8?B?NnhBazRyMjVFN2VNcTFsbCtSSWxtWGMyRldRK1F2WGdjcWlHNFRUeUZCTzIw?=
 =?utf-8?B?UmQxeGNUTS9WM25LVm8vS25YSUNQQTRFWDllblprQ2V0Vy92WG52SExLK0cz?=
 =?utf-8?B?SHcxSUVzclJsa0RaNzl6VTl6WjZydk0zMlNYL1F0alJneTJRK25qM3FwaHZX?=
 =?utf-8?B?eVNObXFsNHRkVFVXWWR4WGhrRDN1WHJRZzFreUxvcmZ4L2JTOVR2djBsNkV0?=
 =?utf-8?B?R1JXcnNMRnF1Z0VBMkVHb3paL1plbWc1K2FNcUFBM0pLVXR3dW04MCtOc3FB?=
 =?utf-8?B?K2FaS1VLWlFIc3lESERoWWJzMk50UE5GVHNyNzBWcjQ3RFBYb3NwTTIrZDdF?=
 =?utf-8?B?dFV3dmRIUE5lU01hTm00d2xnQXkvbVJRM0N6eGFiS0l1UnBxczFTaW9SVVFj?=
 =?utf-8?B?azNCMU1mTzhZc2tsV2ZjNXlIUVBMdWk4NnVQZUNHTkVKUkhYSHZTK29zam9R?=
 =?utf-8?B?U1BHbTJPZzRrb0hFSG9BanljVGlodlBxUFV4OGdmWEEwc25wYTJBbnNUUHRS?=
 =?utf-8?B?SzhBTDhOb2xGRXAwTWp6YzVYd2hlUmtkWHkzRWdmSXVLTWNrSEowbk5nVVlY?=
 =?utf-8?B?SVdpSklwZHR0NGEyMXc3bzkwbmdMRW1odmJQaHFxL2orZzJucUxVdGlMeVlX?=
 =?utf-8?B?MlRhdmlUenNkUUdsT0locTFsendRM0lzOW1wVUprL2U0a21WV3ZnVFVXdi9l?=
 =?utf-8?B?b1N3V3BvK2NoKy9KTXBYak82TFBaa3hLODNURnVxU1JCNjlpTDFTbldxY1BZ?=
 =?utf-8?B?ZWlsbmZkK2tYUmJQK0toSzEvZHI5TlZwQkN6WTF4TEJnTGVPMFQzYlBheUVR?=
 =?utf-8?B?dDJGZGIwTlA1YnlJVXh1Zy9qZUVaYnloeGVnNEtuUjQ5dVZJMDV3K3E1MzZh?=
 =?utf-8?B?eStiVzN5VnMvcmNyeFhLNExOYnJ5ZS9pY043aVMrMXFid254MGhFeE4razZJ?=
 =?utf-8?B?QU9DM3ZVdnhRaHpHQysrOWk4UmxaUU1kTXRBM3RNcThGcWwycm9FbTRoNVB4?=
 =?utf-8?B?OGZ2WHJOTUNJSE9sUzNaOTVnTXBUbWRNWHExbEpHaGdLQ1haSlZjWDExMnJ1?=
 =?utf-8?B?a01IMTVOY1lJcDFxclFSTktzcDF2T3dVcUNoWjJ2dndvZXJlWHZSY3RUbWxV?=
 =?utf-8?B?Z2pFWE9DR01OQysvOU45bHZNbVFIUjQ3eFFEbUV0U3BrSWhmUkFjbUdNNk9V?=
 =?utf-8?B?YXl4a0RNRlpMVFZhckhic3dranIrMUZLRklwVnlLdEFGNFdHYlNmV3RKNjl2?=
 =?utf-8?B?ak42TWZuQm5JalB0QWVaelVXOFc5ci9PQStaa29wcnVRRHJKSmNZa2FBdlhH?=
 =?utf-8?B?eVNBU001NVplY0NKSmMzYWZmY3ZYY1d0RHk3S0ZZUThIVVN0cVJOM0VWSGNV?=
 =?utf-8?B?UzJCTlBNSGpTQmlwWWlDSjRXdVZ1dXJ6dE1HNis3ZCtPc0wzSWNubEQyUW5i?=
 =?utf-8?B?cDNmZkxlR1RVVmFvOExIeUROaUU2dDZuVFhuckJxWmZBQWh6ZWFlRDVWUm9k?=
 =?utf-8?B?WWtqcVh1aTNkbjJCOHpESU1XTEJ1ay9qUWlyWFhkSHRSakc5aVQ5YTY5RW85?=
 =?utf-8?B?eWRLRDFKa3p0UGNsMEp2RHNlZmJEcDdVcUN0NG1ObkJKOEVPUzMwNWkvQ2E1?=
 =?utf-8?B?bnA5VHVDUzJFeVVyZm9WMmE1cWJPQTdTNlM1TmRHbUY5eEpSR3Ntc2tVRGZt?=
 =?utf-8?B?N0RTdkNpSzlLdE92TDFsS1BZVitsalhUK3ZReVhtcVp2UlVuZFBnOEtTSDFq?=
 =?utf-8?B?eFYxTFBGY0pQckZUV2tZR3hvZUgydHhDK1lmUzhvVmtpa0l3d2ltb2kwYkVO?=
 =?utf-8?B?blJFSTM1WHZWSG1XWWdGNjQ3VDVXY2hKa3lNVTh6UGZxejhSbkI4bWlpdVg4?=
 =?utf-8?B?aSs5eXdCWEhnSWpLNkxPUlYzL2I4QlZEdzZYVFNGVS9QcFU0VVJpZGtWZkZQ?=
 =?utf-8?B?MHVFb3ZWOHdqYmNKdE82a3hsdEVSY3VZNTZmamVmWTlKdWtuQWx0YlFCSFc1?=
 =?utf-8?B?dEdoZkJielArc2pWSVdmQjFIN0xtd2RkQW5YdDJIcURTSE9laFpwRm9Eck0z?=
 =?utf-8?B?RzduZ2dKSXBjZTV5SWw3d0ZCV0xLUFgxZ0ZuamZ4K2tOL3lDV0NtL21acy9R?=
 =?utf-8?B?OWdiTzNLc0xUOEg5OVBOSy9jZVBpNEhkYWRPbEdkcVlVdHVVZUp2b3M2NVZz?=
 =?utf-8?B?SGE0VUlDZVZTZ3FrOXJ3KzhvZmo3WUpmU1pnT0pycExjZGE4RmpucnMxU2VN?=
 =?utf-8?B?VEpVcXZlK2JqM2Z1cHBNajNHZzlzOEtoalVsRFN1UEFVNG5IZkFydz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b77e5d4f-1234-4538-bf28-08de52c1f1b9
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 16:36:47.2417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6/iMIbQruRKnnNBN5yILYS+s0zwvnxNwUpm5/3EZATuVFOv/Bqfw+fxmkqCZXMdRiyrbVk78rWQb4A7ZxaNt5CNCS8mexrlML/nolRERT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10285
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

Hi Heinrich,

On 1/2/26 8:19 PM, Heinrich Schuchardt wrote:
> %s/heirarchy/hierarchy/
> %s/usb/USB/
> %s/configuratin/configuration/
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
