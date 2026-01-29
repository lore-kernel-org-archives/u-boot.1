Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9FCD358ED
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55AA683DA9;
	Thu, 29 Jan 2026 10:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nHBxjKDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C54883D8B; Thu, 29 Jan 2026 10:39:34 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86D3D80086
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJNfE1MveR3Bnb5E3y1oxS3YkGtZHghzxLKHxpPSIEahKeCdECvu3ek1W/gBWVr+zrvK5Z4h6bsodOO1v+nubhaNWQcXrnhicsRMaIcS4eTL5uJ2FNH//lmbpToj0OiJ63Uma5nUWGxoTIqbxTub7yZz/VQBzZz8Y783rELGO8rLPHm5LAUByvZ5s75fZZ3KvxVQXVHuQiz6YIb1twfp57wG0wWFd6mOfSjtd7eDPNzdnjiAAwyQz0XLXrXerxlDQwJRv8kiAj90UkdDleXw1pAQcKTpVfJ2Rnti/F20MK100Gwt7Wf+bNFcovW5D594wyhv2pAd4Dne4lJ6XucPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6X88QcOeByVxk8c01Cx6k/yg3VQ3tg3pq0eCZNkZro=;
 b=KyNJtR6U6xBMIAlXykirqi4ILRnu9rlt3WFJgEhzVZ5ky8lOXBcRi+6j+ojFP9hjbNYq7PTluH0nVYtO1RYWvxrCiPq4w4r00L571ipQMdIRn/zcDFnPPkVgXJ3TvN7ySu11We6GxLBE+Du/AQTDibyJ4pjQp576tSnGujtXV1y0CEpY5zxCYzotpo0lhR565s//4QOBD/RYuQxpDZ80PLqMwjfBhD0aGm3Luc+WafuPJyaWJHwXTSuy9PVtDGKYtM9y4UO5xscjYXlvGjpaaSZwjKEu+JKUzBinFYNhq02xIoXm05xoB5iG0HLaoMJpUpGN2CsMw8hjNYsDJS8xpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6X88QcOeByVxk8c01Cx6k/yg3VQ3tg3pq0eCZNkZro=;
 b=nHBxjKDXhAMqcbzuB24SFFD212kRpQWgrlJESizpr0Z1oXrzlMRcg3NAUlUVkRl+P5TpiUE5hjf76P+3t3mvkdvLnLjC0tFHP7Kmy68B+JJ0iOoRPBqUjh4JXNQIM70m/Of9mDEWJTUhJI+8xBj7c6wLXQ2BOQMe7j0leLMrZ4BLw61GhRhfSGohL7yfygkKZKf9SL1Mj+QPghAfRmCgHxqrShpiIyUxrQ4Yjd4bwO35D9O5BfRAABGj4gPGrko1+CjnU1grq6lBTG7rlzs4JW8ey+fBWJHwlFyPoUR4/GBqwN2b0kdoagDxEyUNcm8XykX9CZVWLBecTykwtAmB2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10384.eurprd04.prod.outlook.com (2603:10a6:150:1dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 09:39:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:39:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 29 Jan 2026 18:54:04 +0800
Subject: [PATCH v2 02/12] imx8mp_evk: spl: Drop i2c_pad_info1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-imx-clean-v2-v2-2-1245ad2c3a01@nxp.com>
References: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
In-Reply-To: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10384:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d136e2-7b7f-4626-74b6-08de5f1a4d5e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHRHWkFmeGVjbHoxS2t0SG9VZlRHS0F1RkxZd1RFVXBWTGdmdFgxUGJwT0hT?=
 =?utf-8?B?SDNjMDk2Z3VhaEhkeDdUZ0VNM3hmb3R3elFwSHRPTy8rZzhSVnFWVGNkbHNj?=
 =?utf-8?B?Q0Zwd2RkQWovSU1kZG1HYjQyOEg2YWVrNTlteGlkSmNBaHR5UnFHVTVYMkE0?=
 =?utf-8?B?bkg1V094OXNvbzRObjlKM1JIMit2enhMMDdnUGdMWUEwUDBjSXdRaVJSbzBy?=
 =?utf-8?B?V2RmV2dzdk5UZE9lVExDRks1alliYk5KUXFWYWlMTU1naE1DdWVMWmlDWmtR?=
 =?utf-8?B?a3cvdlpacFRYRXdPcVZpWjBGS2NpWGtDSlprTUFVWFdYMVZ6VlNUTjVFN3ow?=
 =?utf-8?B?YjQzYTh6ZWZoY1ZINFJMN01kUlNrdlV2cEk0enp3cGk3OXlTbEhIajJsWExl?=
 =?utf-8?B?UlJNT0syYm5zekI5RlJ1NmNhWGFXcFJISW13dnladGxXQTVpQnllbU5tekZF?=
 =?utf-8?B?TzdLeUdKbTdzVWcwMlZQNGpydTZxdTVHbjVEY2YwUHBOWEJMbjRyREtrZkJ4?=
 =?utf-8?B?QVF0c2hkbFVITWk2VHUwQWs5NjBLZmNDTjJCK0h0SWp0U1RHeFQyTllIbnIv?=
 =?utf-8?B?MW9QR1kzWG1JTUNJQ2h2UU1mQ1RWQUVVT1dLQUJhUlY5VmZ3RjNLOTdHUldk?=
 =?utf-8?B?T2ZZS2lBbGJFcWwyckFwQktzc1pDK0NuU2tYUDRTSmpsK0xRZTNPdWpsQklx?=
 =?utf-8?B?d3ErcjJNSldBa2NUYlhDVWtzM0dERXp3Wk52dmM1bDVONzJucHRuMk13Wk96?=
 =?utf-8?B?RVNDQjQrbHFhSHZLeWEvVXlHUnY4NHRnK3dzQzJKejErY0RrNUpNc3RuTGZX?=
 =?utf-8?B?THd6NitGMExuSjlYZ21yckU1TUFWbm5KLzNXTk1XdGVJVUNUMngxNzNhSVdJ?=
 =?utf-8?B?ZUZlcHJDM0pkVHMvVlE2dGVpcEJBTUswb0l0eXJuckdLS3V0V0pxbEQ4bzZQ?=
 =?utf-8?B?NUsrTnRPaTgvbFNaT2dhd0oxamt6aUJDcjhnR2VMZnF2TWRBMFFNYTFRQ2R2?=
 =?utf-8?B?eTlpTGpWTzhBMWxmTWYzYUI5RDIvelF4aUtpWjd3b1hMZ2JPRTlJNnU4ODJB?=
 =?utf-8?B?bWZyazVYa0wzM1lIMVFlTjBXcUFUSUtnTkVlWjNRVzRsbXk2cDJVenNvejVh?=
 =?utf-8?B?Q2RXU3VYS1JuNjh0VjlpMSt3d2tQZWl6ODJBc2RyOHNhcmhpOTAySnJXdWc1?=
 =?utf-8?B?SG9HeHdMTzRzM1o1WkI2T1N0MFhCczlxaU9FS0k2bDJwcnFrY0ZGTWhWSHJG?=
 =?utf-8?B?MTFzdktZa1ZBYTZNQytZdWU4TndjYVpiYUR4Z1ZlYzFGK3FqekZkM25LOWh6?=
 =?utf-8?B?OUJQeEN6NmtnNWF3TVlQaGp4MzhoUDJnSHNHMlRueEg4MzVIRGVmR1ZudHRR?=
 =?utf-8?B?dXFtNVlqUTF3dFdvb0NhK2Z1Qmx4N3VVcTRLcldHcUxaKzd1QXExTnJ6aUUr?=
 =?utf-8?B?VjZ4dDZrbGplakRDUHVTcVRlZ2U3Y0VPMGF6eGI4b3VkMmYrWDM2U2pYdDFu?=
 =?utf-8?B?emJSMW80ekZYNFFlSnp4anRZWmJxc3dBalVMSkF5R05LZDZ3Qm9ZdzZSRG9I?=
 =?utf-8?B?ZHd1YkRrR0g1Mm82M01LWHdjUmVWYXNOc0x4dG1qN1lqams1SnNUdmJETFZp?=
 =?utf-8?B?WGNpZlBRckV2ZnhHblJ1VnJSSVhyeTcwQnptUW15MTgrRTRNd2x1QitnN1Iv?=
 =?utf-8?B?ZFozN1BkVm9OSkNwT3RGQi9DUEJzQTRMQjU4cjA1RlBSV0FaaHMwVXpPZmx4?=
 =?utf-8?B?RTNPSXZ5SktpRWZIR0p1UW5BcS9Pb1Q2VVpuK09UdS9PWmtveUJ6UWR3aU9p?=
 =?utf-8?B?c0o5QUhQUlJNR0hsTWtpNmk0ZTlmZHhtVzVNZVUvRHVnVHk5bDdUQk4zUVZn?=
 =?utf-8?B?R29YZFZObklFVE5BdTYzaTExVkxhc0tpNHY3Z0hveXZ1NUdxR1hxdGxBYmhk?=
 =?utf-8?B?ZDlWMmhqUkllZDYxMGpMTGFGeUlsOHBxTlpFanErUFJMOFRpV2NUcWlFMkFo?=
 =?utf-8?B?UWRkTXpUSXRySVppeC9YSFgvdFRjTUZwT2ZSUGlwQm9SYzlFb1NrZDdJR3Bm?=
 =?utf-8?B?MVpCaWszTnJQNGQ5RU16dVljVGg2YXo0TWtpc2Z6ZnZ4Qy9sc3pjbGxnL2R6?=
 =?utf-8?B?V3BFNzhwVDlodGxRQnMrMHE3VlpLUStNcXZ5bjlNMURwZnc3ZzF6NWlvTnc0?=
 =?utf-8?Q?cKumKNMXvhWhmERg79hjwsU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2RCSlg0MGRLUEhIUWlyUWpUMUJxUlBNWUs1QmhxYzdCY3Z0M09PWTc2NHgv?=
 =?utf-8?B?UjhMWmZiMlpTdnRwZ21FeGM2THk3Ri9wdUhjcXFobHVVMlRlcmFyK3hJNkk2?=
 =?utf-8?B?MWxwYVBtSHVNa3JUTmh1ZHRjbDN4cWdpTGVPSDgxNTZLaTd0WDVIYWtSMUZo?=
 =?utf-8?B?Q3Y4aEF5SzlHajNHNXBSWSt1Y2V6Z0hKVktJblp5ZEcySEpVS1Z4UkNpWWJs?=
 =?utf-8?B?eEMwaWVIc0VqUSt0Y1VxWEJYQWoxRVNkYzRUbGFsKzlIbDhtbU11cWZqeEhJ?=
 =?utf-8?B?cCtOQTRZekFkR21pQktMZHBRYjdEeTRnd3J3VjViWU9mMmRmOElTTWwzUGlq?=
 =?utf-8?B?TWdpZ0xSQ3FCSVJYQ2paWnNEMGVCdW5ZaUFaS3A0NDI3aklhdVNaalNyZUs3?=
 =?utf-8?B?WFlBWC9scnZwOXM2NXdrRWpQUTlaTW80R0ljamRpbHZwMDQzR2hDbHB3RGxW?=
 =?utf-8?B?YUM0bTdBVW5OUDFJNkhncFNFRXNpVkt5d0ZVM0NxWGJxeHlNS0xvRUMxcXpI?=
 =?utf-8?B?Ri9PcFRXRUE2MEJSUzBlemExMUNpcFpNbmJkZ0xFTkRRY2YzREdFbzU0dFVE?=
 =?utf-8?B?VFBoUGQ3WjRTTTM3SmVVN2xCUzV6aFVCWmJRelRrSHVrWE5Fa2VXNndMZ3Ra?=
 =?utf-8?B?eFdWZktYRW0rczN2eGlZU3dpRVdWYkM2VnBtandwbERtM1dwcXFyOUwxZzY4?=
 =?utf-8?B?cWdTZjRud2RERVp4d1FJb2FLZWF4MnorYVhVQXpKaFFDVVNCaXAzSTQvTkI3?=
 =?utf-8?B?WTBDbzh2OGJ5OGdYOFVNVjBuYmpSUjhGcGw2aktDcjE0WXRDS1pmRW1qa09K?=
 =?utf-8?B?K0FiUTJUUDZrblVZS0V6bFBzODRsbTVVU2lEL0hXODJLaTk5RnFOaUlyL1RP?=
 =?utf-8?B?bllKajluQkZLckFORkFReURGK0dZckhHZkxqUkNIakFXa1NoKy9CU3FsRjFL?=
 =?utf-8?B?NlcrQzRCU0dsNHhnOERDbFpqWW5UWTRlUTN6VE03UHczblJ5TjhMclkrd0ZC?=
 =?utf-8?B?SFBWbW53R3U1WjFXQXBDWkZVM3dkbXNULzc0Q1NUYzFNQ1poSU85R0xiVVA1?=
 =?utf-8?B?bGpuZzJsTEgzVS9oQ0dSRWxHSjdUYmYydG10YzFYTHU1YnpVeXE5MjQ2aGJI?=
 =?utf-8?B?bHZsaHFKY0wxUE1FRnZqSkVweVJ2MFYwWkpBY1FtWkNQcW44Q3E2RGNoVlNS?=
 =?utf-8?B?bkpTOEJwQVB5bkNsVzA0WURrSlhZRlk0Z093QWdXSmR1N0tnRlhmalZ3NXRZ?=
 =?utf-8?B?YnRlNlhPNHFFZU0wVnRBVEZZKzBFYXB0THVjV0FGV2lsRnJiakZOSklGS0lX?=
 =?utf-8?B?MVJtbUpGc1Y1ZW9Fd0RXUGF5QTBuN0xQQ1dNWWZ2WnloN3FJYXpUSWhsTEVH?=
 =?utf-8?B?U2ptUnhVZFp3eDk5SldOb0s5Ync1RlVnMm1xZlVKenRRcDAxdVJwTjVuQUhG?=
 =?utf-8?B?eVNRbjJPazRpVUVPa3pEdHhLMmdpRDA0cHhYZ0wrTVEreC82RE5FNmJzR1lx?=
 =?utf-8?B?b1ROMUtIaGNFUHU1dUZ3dFdHQXUyenZNVDNYaklVc3MrQXZKOHVSNlZNNkFk?=
 =?utf-8?B?QStNdkV5ZThjQ1NadTNTZ1pTUTVjRFhncFAvVGdhakN4ZHNmd0ZpRlFQVXhk?=
 =?utf-8?B?WVZ3TFQ0eXJadUlKeWdoYlVuLzFGRUJibS9RWEwxby9lQklPTDhlNVBUSkYv?=
 =?utf-8?B?ZEZHaXZ4Y01xVEhGWUdIdkxOQjJqRVBYVUt0UUtteUtrZFZsUkRxNUpwcHR5?=
 =?utf-8?B?RW9XL0FkNDdPV05ZSFFValNadHNuRitaOUpzNy9WbXVNSTh3V3M3ZitSeHpk?=
 =?utf-8?B?R2l6WWJMa3dod3R2UFljYk5wVHpJNEQ0TURabWpyV3VOb0F0NXN4ekVTS2dT?=
 =?utf-8?B?YmFlQXVad2lUUmZ0TkNPNUsvVXhYZDhmUnVMdVhDdCtML1ZCZ201M1FxV29i?=
 =?utf-8?B?c3JiRjIvMFZocVE4MXRKKzczRGdncFZCbGIwQlBnbVVhRjNub2haOTZVdjgy?=
 =?utf-8?B?bE5uMXd0bDJZbW9WemE4K3RJbG1JVHhBblNxOElLMDY3OFNTdHZoaElWbnIv?=
 =?utf-8?B?MjlJdDQ0cmd2NGRPKzZ4cktVMDBNOUlzWE5pUjlVRVVmcTNpSmRudzVpVzJx?=
 =?utf-8?B?SjUrYzJIY2JDQ0pScGFXY01mWWREYnAzSFhLVVcwdFhndW00d2M0OUJkZjdv?=
 =?utf-8?B?cU95Y3NLOXVGOEdaVm85c0VGUGM1cmFjK0ZHSmlrSzh6ZXlLbWJtMlFvTGsw?=
 =?utf-8?B?N3lHYi9zeFEzb1d2dk1uQnQ0NGlCTHVORXhwUEc4M3FHanBKWm5pUEN1Tit3?=
 =?utf-8?B?c0p4aGJhWTZMMndrRmxrVWNjbHgzT0JwQ3pwZjBIN2dXVUY0RFNmdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d136e2-7b7f-4626-74b6-08de5f1a4d5e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:39:30.7664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jBB2kDwd7t6OZJxHbYx+HkUjrodS9yc7kgcUxXyoqx72PUQUNWOsG+eyKVPJt7cuc0zF8i5/lO93QoHzlYA6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10384
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

With commit 6e6492c85def ("imx8mp_evk: Convert to DM_PMIC"),
i2c_pad_info1 is no longer needed, remove it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx8mp_evk/spl.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/board/nxp/imx8mp_evk/spl.c b/board/nxp/imx8mp_evk/spl.c
index 12da1b2abfb..552bf689228 100644
--- a/board/nxp/imx8mp_evk/spl.c
+++ b/board/nxp/imx8mp_evk/spl.c
@@ -10,12 +10,8 @@
 #include <spl.h>
 #include <asm/global_data.h>
 #include <asm/arch/clock.h>
-#include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
-#include <asm/mach-imx/gpio.h>
-#include <asm/mach-imx/iomux-v3.h>
-#include <asm/mach-imx/mxc_i2c.h>
 #include <asm/arch/ddr.h>
 #include <power/pmic.h>
 #include <power/pca9450.h>
@@ -51,21 +47,6 @@ void spl_board_init(void)
 	puts("Normal Boot\n");
 }
 
-#define I2C_PAD_CTRL (PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE | PAD_CTL_PE)
-#define PC MUX_PAD_CTRL(I2C_PAD_CTRL)
-struct i2c_pads_info i2c_pad_info1 = {
-	.scl = {
-		.i2c_mode = MX8MP_PAD_I2C1_SCL__I2C1_SCL | PC,
-		.gpio_mode = MX8MP_PAD_I2C1_SCL__GPIO5_IO14 | PC,
-		.gp = IMX_GPIO_NR(5, 14),
-	},
-	.sda = {
-		.i2c_mode = MX8MP_PAD_I2C1_SDA__I2C1_SDA | PC,
-		.gpio_mode = MX8MP_PAD_I2C1_SDA__GPIO5_IO15 | PC,
-		.gp = IMX_GPIO_NR(5, 15),
-	},
-};
-
 #if CONFIG_IS_ENABLED(DM_PMIC_PCA9450)
 int power_init_board(void)
 {

-- 
2.51.0

