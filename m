Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F110AC44536
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 07:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 016E483A1E;
	Thu, 22 Jan 2026 08:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iF3J8kL3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58F7683A1E; Thu, 22 Jan 2026 08:09:53 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DE5280077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 08:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMwlLW8FfidEFZqcBayKRE1NmTseRnRG4OLnjBBtGBlqm+I/nkve3g4Tv0c1CLRFVy16kEdCeGqK7/TMmauDZfYpNYHEc2tAHgIe8eZoQlNMHlK85rA01JKJYLfNQ22dYKFHuLhWc1Tk9+Cn5/0L3dIJupg79hNy5t+u8qi8RK6wNFXiP5HeA9uMQl3zTdjG8JIFgP0p+EbdI+AfGA4kJ75uVTIsgAbSJGC3hB0d9p0FvILGtZQHM1M1gHGJZF7iWDsf9MuVAtMw/7dsjXz/ZoqOkDiRBMtpJNaoUprKWZnOaK7lDu8oeloByWVp4YO9MLnszog98btVpHFwNXvgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSDtNkBmCVL8266Hp9qIFrCqaoSL44GUBXGUc/egCXI=;
 b=hzcxj4jwt8jgyWSO+QVbKGDIJsQiHPSTLasKngTZcdlcK2dgYuz9ldzSWfHBSLVe3IYKH7iRX2qwcjY9iTdyeAewmvVQfXdEAG9BE6hpdY4jJ9DPvE7RhZeryJKysg6EOgb4JakC46v4KmMIidbgBLxmTHui2Klyd+tSYUoc9XLaGK5aB7sMisTMOgJYe29qN5A/2afEGBvLTmQpu7eejBq4sI7TPchJNh11iiXtJg9TGKUTab4PMQ2/iKnTNxzpiYjYR8uUSSBja400vj2D03fFb41sK4DjwWO8aWIfZYoB6e4her1ZNmeB81mNHOXVGlYAGXVYWM6L61xWrFFa8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSDtNkBmCVL8266Hp9qIFrCqaoSL44GUBXGUc/egCXI=;
 b=iF3J8kL3vjj7at9jzZ3hsQ0LDiXkRssr/iM6FvyvtaR1dWBFPZDiW+wQdHc3CD9oIfJpMfaigp8Ehay8dTEXkgJcImI0W0Ui02BkvZW7wgpRcGlj06ob/oP3b2Fu7yRLU1LNXJAxvdHpj9BczJLCdsgETaCMSGTVjr9oBqImcRVRA76lJd8a+VdGP+6ODUqyCi5XdK7AwcBhPYTFGBrCybH/1gziwTiHkvNDgatX7Obla9K1gatslJQ4LXBjO2sx0XvsTZ6szu9Q0oCuTuqe05IMDccbrGntJi1HeT7K7rgxPb62qFphPqtFOVIMD0P1CT7Hvs42qERCn+OZGlhZXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 07:09:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 07:09:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Peng Fan <peng.fan@nxp.com>, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, festevam@gmail.com,
 ivitro@gmail.com, max.merchel@ew.tq-group.com,
 marek.vasut+renesas@mailbox.org
Subject: Re: [PATCH v1] mmc: mmc-uclass: Use max-frequency from device tree
 with driver default fallback
Date: Thu, 22 Jan 2026 16:24:02 +0800
Message-ID: <176907022015.3206735.721738938882345850.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116125031.3975-1-tanmay.kathpalia@altera.com>
References: <20260116125031.3975-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 39629f88-21e3-45c1-8d2c-08de59853b14
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUppd3ppd2NDTDdVRDA2ZTJIMjFCN0FHSEw0ZGVFN1VUV29FOVIwUmNJU2lQ?=
 =?utf-8?B?V2ZjejVJRkNKcEhMNTFaREQ2dU9ZR1ljQklGQkxwcFNXc0d2WGRFRmtFTnk1?=
 =?utf-8?B?RHZNR2ZhOFczYW9tRzdTMXB0djk5OEk1Y1hiTXlTMytRNjl6dksyb3MzdTR3?=
 =?utf-8?B?bENGZk93QUcvV0hNaUpKQ1lPNlU2V2Z1WEV6dXVpWEpnSEdBQVdBdUN5K3dt?=
 =?utf-8?B?RUZQdENkanQwZk9KNFF3WC9pTDlJV1lUYVdvU2xKdmNyak5Xb3U5S2xSOHc0?=
 =?utf-8?B?a2tPNVBaNFpNcGk4VmVzYzZoVkhiT0Nkd0hEcFNTd3BWYmZSeDZtNlNtMlNI?=
 =?utf-8?B?RmdWc2s3WHVvbUZWelU2WFNKcnhUN2sxNDdFVW8xelZkVVZFbG00bWI4R1ZP?=
 =?utf-8?B?dHA1dFVYRmhnemVHT2xZeFNqQW1nWWpHVGhVd2htQ3ZrbzdMcXVISEFJNlJq?=
 =?utf-8?B?bjhKM2JBOXJqd25IYmdrRE5hZ0JnQStkbGF3cDdMYVp6WUdJWERYS2pZdlpS?=
 =?utf-8?B?RlIxeXRLVmtGS0FGYlV1OTJHbmk5WDVtYS9SajU2K0xVYTJlU0NBakkwTFhH?=
 =?utf-8?B?V2ppRzVnOUdWcHF6R2VXR2dVOXVOT0JxUE5XcEpLUUlXbldFdkMyM0tobU15?=
 =?utf-8?B?c2w1RjIzT3JEZk5VZWJ1VlNKd0pWd004SWNXSnVXWGJMc0l5d0tBSzFHYW9t?=
 =?utf-8?B?LzNRZ3NVSEdXU2E4ODVQcUFnN2J3Q1cxV3ozc2MwN0tld3NsNkMveTdLUDNj?=
 =?utf-8?B?UkU5anBXdkNrNXFWdXo1STFFQ1Y4REl1RkJXTDJ2ekpXYkoxZlR0cTE4RWtt?=
 =?utf-8?B?QTJ2WjZPUFdFYVprdVFFZkttR1llOVV1MVlHa09FMkVQd0hrVnRtaDl5bTUz?=
 =?utf-8?B?ek5kVzdITnd1K2J2aWduQ1IzUW1udUUvc0xvSHBqYnZ6a0t4RTBPYjZXYlJX?=
 =?utf-8?B?TGFWVlpBY2UyZW8vR2EyWERFMElzQnJTL0lsUDE5bUZMemwrV0lQSTJCb2lo?=
 =?utf-8?B?TlBPbXpVblVrcDZ1TnpnVzJZenhoMkVVN1djUy9hemNuSlFNTGVaNFlGeTNJ?=
 =?utf-8?B?empRNS8vLzZZeWpUcTI5MlJXR3ZzdFlqK1ZZZm4xdVZjNEdVaExROUZUQ3BP?=
 =?utf-8?B?VDVEZTJLYldYS3VmZGMzZjRuSmpHNDk3SFNWbEpYYzdtc3hkdFZ0Zy9jNDAw?=
 =?utf-8?B?ZndmMVpTdFUyS0dIUW5FaEFBU09zQ3N2Y0V2QVRmYXhpNEZDdFFKVGJKUURl?=
 =?utf-8?B?VTVGK0dFZmRJc1ZHOHQwRmd5V041WUVnRmlpbllwck9TbVBiSDVtakc2U3ow?=
 =?utf-8?B?UjhWRGZrNGlYYlpuS0VXVWFqR1haYmRiR3RBWmJyOVFEbGVPOHJwblNjdmpG?=
 =?utf-8?B?UTluOFdkUzl5dVM5cjEyV3ZTM3o1UmtidTBrdFFoTTUvZFY4UVZYY3UzZmxR?=
 =?utf-8?B?RTdSOHBoOStSUjhyVWQyZWtpRGxXNG1Zcm4xYlRHNFhqeEVyd0E2Umh2cmZv?=
 =?utf-8?B?OGlzNDZoK1JTbHE0ZWN3MWRBN0VobnZWay9VOVFQOGlHMUVPbjFKTFVuZFlx?=
 =?utf-8?B?VjFuckRFeUoxaXBwYkxWckJES2dtbHdURE4zTFNTcGhoY1o0bUJqV1NzVU83?=
 =?utf-8?B?Zjh2c3RFTDhYUjd4bUthQzJIT05NUzNPRHhWdWdpTGpaQlIzU3B4bGNvSzZF?=
 =?utf-8?B?TVErR29xZEVZSDAyZkFwWW5Zdjh6dEhJaFY4dEY5MjZQd25Xazh5OHlsdEJw?=
 =?utf-8?B?OW8wSmRWQ1AyaFBLczR2OHhXY3d2S3NPUktXcUxNZEdRaDltRGFIQnFpNjdR?=
 =?utf-8?B?Nk5Dd0pkb1E3RFBMVzlGUEdWYUc0SkpFUXNEczhhWGpFTWJzUWdNUFFBSnVH?=
 =?utf-8?B?MS9uVEt6VFRyMHhQL0VoZUg4MHVzV1N4UTFhemhnbHZPMjdCdk1LZ3JzZWUy?=
 =?utf-8?B?aDBtdTgrb1FUTHB0YytXVjFFRkFpZ1NtWlp3NWxEVWtudTFJN3hXTkFRUXF4?=
 =?utf-8?B?eCtTUmZTNWt6MGdBV0trendHTldEaW9QODJIODl5enFYdUxDLy9Yd0JtWFZr?=
 =?utf-8?B?OTdFQzNxYlhjblVJZEhVQ3RTZGhFcXZLZUx4NStKaDZ6TEVPZ2ZxeDZDTDRS?=
 =?utf-8?B?YkVIUUEvdXJVZ0s2L3luVzk2b20yNTdUd3djc2NYdkNMYTZPRFU0YzZROTVL?=
 =?utf-8?Q?sOdf2CNGOQhLJz2Jl3psW9w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjZnd3BDays1cXBwYVJsVGRPWGx5VVRjOUt4MGpRQVI3RjNnbHhHVjFPKzJC?=
 =?utf-8?B?WjhhU0lCQWxudkl2NFRDZk5jdGxSTVdobCtkQVJXYlAyZXRtU3hnQUN0SVR2?=
 =?utf-8?B?SW1BK1BsbUxUYU95eWZqczRlTVloNFlNZVFsZVNYQit6ZGR6WCsvM3lsU24z?=
 =?utf-8?B?YXhnd2QvWGVuRjQva0V6enBGNUdYZXNXbWNiY2ZNT0pvUlJ0dzViL1VqSjE0?=
 =?utf-8?B?MCtlK1Z0cEg1YXFGdFVkaXZpdjBoNnhaQ1Q3NTZsQUt3N3FBN0g4aFczQVZW?=
 =?utf-8?B?a3YwU1NIWkdpMkJSR1pOaFB3UG9rUXZ5MWkvcnl5M0RaNEN6YkZMTEYyRUpl?=
 =?utf-8?B?cThWK2ppNGRwamdLaWV1VG9GZzN0N3h4aXk0MGJEdW5SQ0pUOVRHaHBOcEsx?=
 =?utf-8?B?dVhtUmRMZEFDeUczQnMza2lLQmsvSWJubHkySGRBaE9YdWUzK2JFam5VWVU1?=
 =?utf-8?B?RVNucGg3Z0M1a1ZONkhwazd5ZHVRN3BZVVA1V1Q2ZkVrY2daa0VBQTdmMHBD?=
 =?utf-8?B?dk9kWW8wWndOeWdkckdmS3puZzNkREhqRHgxU3Y5UXF3T284SUZ0cjVKUnBo?=
 =?utf-8?B?aTR3Sm5kcElJbWZHR2R6K21DMW9DdVZPc25RcGdLYjQwRElwMzN0aUZpRHZn?=
 =?utf-8?B?V0xxR1pDVlRsOGVHMGUveUNXUHptQWY4MWc4S1hxSFJIcjNvZWFRamkrNTJQ?=
 =?utf-8?B?TUFDcGFvb2N4c0tPMm9CWlV2WjFlYUlvNzltZE52SERhaHBzT2dWNG50OUR2?=
 =?utf-8?B?NFltZlB0NjVwclBLNzZGVXh1TGxQdkpWYjJaZ21iK3R2WGpRcHlVbkdBN1I3?=
 =?utf-8?B?U0xYYTRmTmNNZGRYUUR4bmxiMUFNVVo1dHMvREphdnpUbnkxRDJ3UGNEQng4?=
 =?utf-8?B?MFdNUlo3cXI3ei93UmRFRGlOc0gyd1R5YTBESXZFZkFPRVBSSFB1dEZSOEZI?=
 =?utf-8?B?L1JpdWQrQ3VjRWFLVnZXM1pKQ1hCUm40RFZEbWRWeGpTTkJzcTkwWStDbEpM?=
 =?utf-8?B?cHNPRXFwNk9aeW1CNzdqblNUekkzbCsxRG90YXFVVlNrQURyRnB5MC9PNzBo?=
 =?utf-8?B?MXFLTXpTanE5T3lvMW93QURVZnYwNkZMci9KMm93MkZWMFoyOXpaaWhwUmRy?=
 =?utf-8?B?UklIclZXeEV3WXd1c2tTcDBxZ2dVMXMycnE4Z2xxeWt4dUl1OEljWjBRL2w4?=
 =?utf-8?B?UGtCZGFmNDNqUHpTVkFnQ3pqVDMrMmNNS2VuVENaOEpxaHJEbFI1MitHeGJo?=
 =?utf-8?B?MlkvRi80QXNIa1dOeWkvSkkvZFlKNFk4bFV6TGtkRXNhM25EcVNYdXN3cHVZ?=
 =?utf-8?B?by81YTF1UXBhQ2pJeGJ0UVpKSkhXcTJNNzZ4UnFvSXNKbityVzFleVhpbitW?=
 =?utf-8?B?UXg0cTIwbXBNQnZaNndNVVBETUthM09Cc2V4VGc3UkdSUmhuUjZGTlJqVVJk?=
 =?utf-8?B?RkxpS3VMZHI2dWJCdlVHNkFlQVJMRWg0K1lYbjM4cUp0dWRqL2JhUC91eTdF?=
 =?utf-8?B?WEVSSmRVNE1Ob3dLWjNLYkxoR1lBTWg1OWFRNUhWNWgwNFcxZFNBbHFSTU5J?=
 =?utf-8?B?L0lLM3pMbzIyUXJYZUNUS2h1ZDBFcXhlYStqOFB4Z0FhNE9VdXRCdk5Ua1pF?=
 =?utf-8?B?S1ZyT3MxSE53S01oODlneVhiaUlCYXptYzNPOVN6ZStmbmtFbG5vWWFkZytP?=
 =?utf-8?B?bWxBZ1U5Y3hsdGc2Y0RhV0JTSDloZ0JhbWdzZThjSGJ4Rk1ZL1hReTlXWWxP?=
 =?utf-8?B?ZEhrckhIa2Q1MGMxb1Z0MTV2SW1KUStFUkh4cDljUTBXSTBubHVwV2J1cHRQ?=
 =?utf-8?B?VXpJOFJDYkw1N2pIMEZuR01JQ1ZwdHZmVWplQmpxdEorNTV6VzJFNlNsU1dx?=
 =?utf-8?B?ditVbXdCd3d4SlY3Wkk4TEJFSHNueDNZdjNQM0k4bndnVjI5YUlocGpFUkRk?=
 =?utf-8?B?YnRLdmVEOE4rOFVzT09mTWtSbHVSb0ZZK2VOU0F4clJjUGRjdG12UFlQdzdD?=
 =?utf-8?B?Lzg2UEZ5Uy9Ndmk0KzVBT2JwWGc4UnJFYmlKVDA3YmFXMUtOejNMeXBMNGJF?=
 =?utf-8?B?dUJQckhjcTBJOWZycUdCaWxXUVFWU2lhU09Bc1NmWEFOaktBYnJ6b3o0dFVL?=
 =?utf-8?B?WllFUlRxcTVjUmM4Tlplc0s0Z3ZtOGgyMmthZmJDbXI2dDlBK21lY2htRzYv?=
 =?utf-8?B?RTZiVXJoOFBjYm9lMXF0ODRDcEFBNytsNHFFdVdNTHRxV3FzTG1HQ3JGS0gr?=
 =?utf-8?B?ZmQxaCtERDZsZzg2RWVIN2VWZStBMWczOUozakk5ejI1OElWeGJJcWdsVTNO?=
 =?utf-8?B?Y1A5dzNwcTVGaFJNc2NNcmh4Y09DTE4wSHJFSWFWcStQbUxFcmg0Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39629f88-21e3-45c1-8d2c-08de59853b14
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 07:09:49.5384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOZGiv2v+fEbdzeSJC1mVFbtR+ct0TpBCfHbNaPL0H0UijZtHRU0UffSyma8std/WtkobnR0tipwIIecgaJsQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7586
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


On Fri, 16 Jan 2026 04:50:31 -0800, Tanmay Kathpalia wrote:
> Use dev_read_u32_default() instead of dev_read_u32() to read the
> "max-frequency" property from device tree. This preserves the driver-set
> cfg->f_max value when the optional "max-frequency" property is not
> present, ensuring the controller's default frequency is used as fallback
> rather than being overwritten.
> 
> 
> [...]

Applied, thanks!

[1/1] mmc: mmc-uclass: Use max-frequency from device tree with driver default fallback
      commit: efc26685682987e1bea06bd821d7960501326edf

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
