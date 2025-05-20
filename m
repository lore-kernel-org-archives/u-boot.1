Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5158FC3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 14:09:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C38C282C2F;
	Tue, 20 May 2025 16:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BsqjrMfA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E18782C38; Tue, 20 May 2025 16:09:11 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A73982B7C
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 16:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFVEFc+Llk9GATbA+yF9naDxzEziSnJlCZ8IPkc9Kohed8YjUvFuk5mO0hDlDzrlx+uj8ivtG7Sn8H6h3I+2ZQY8QtIgthQaGHgo2YuI3ZcSmF/WSZYgZwvvBGvoiX3EcmYn+/UqQh0elO7fM63H65MgIq7gBABvjFE+AZg9D/CT0gO9GwNVebd+itetWRFRvZpQtx2LI14GnX0BDyJZrEJeP15xr+3KB1FYaC5aG0juALIYKuervkVGRetg1ZfCW4BIYPDge1O8O3OSK21TfA0ScAJq/RGnWc9R2pYunVpso0uxzdqAzutNMWAMQ0nzillJZ6c2+iGQLLm0iekDAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EThbUcp5X+Mhku9dJC2NrWAngE1emsiy+AcmcyWz3dw=;
 b=aL9NfsnspsStZdw4EWyBRbKhGzeB6tD/Rjqh0TIsDItXp/5avPUM6VY0iGOJ8WpnkZ3PAAUiFLY6BwxGxIFwgs/HkR4S9vcRt5CwvnmbpweOTYleg/rcqUSq8oXcqUQNgYXbZmWzP2lok1PIfw49XOGGd7JBOdVaiJNTfNxhw4chHDB99c6TyBauEG182CtlUadZUkfm2ZT02POsrZlPSjgfX38sMXABYWQj/CYwqEhRSl9KQkniHWjyGLXbyWW5O+ebfAgRX/viNmG2ysPWKOkgM3UGCNmmwpZx9WvCRG7WcACLCUp5ks+PKMOYvvhdseVlhakgHeupI8VGTf8c0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EThbUcp5X+Mhku9dJC2NrWAngE1emsiy+AcmcyWz3dw=;
 b=BsqjrMfAucl4bb0aRGCGwPJJSZmkaDWi08gG4KarfNJsjA4B4JCgyrh450KrSy6URoFe5qyOq7lVAas7uKsbB540P+Je+nnMjWuaIqKgbjEVjnZtTHhoqA/4knJIXREb51hzLIIXHuO96KAGAAxgx5APC2iltRw3rWO8W5loyankyuHTcvh/1ohrhE4kNe98WOvd8crTqs9K4c/u0lccn1XZr+Uj/OpzYV6l0wS0fp7mJ41V7HxltVfdsTA+yUBqzLxgIEtesrzxKXjGDMu7VhKMaRto49ti1oSCpoYmSRwt9nKg9MMcRtRV7bk+8cZgNc7VmV1kDDWxB4nDagypiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7884.eurprd04.prod.outlook.com (2603:10a6:10:1f2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 14:09:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8722.031; Tue, 20 May 2025
 14:09:06 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Kongyang Liu <seashell11234455@gmail.com>
Subject: Re: [PATCH] mmc: cv1800b: Fix build without MMC_SUPPORTS_TUNING
Date: Tue, 20 May 2025 23:18:25 +0800
Message-Id: <174775421994.22423.108902901642897804.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250427214637.321693-1-alexander.sverdlin@gmail.com>
References: <20250427214637.321693-1-alexander.sverdlin@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0096.apcprd02.prod.outlook.com
 (2603:1096:4:90::36) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3b6fed-57eb-46e1-962e-08dd97a7e1a3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGtlWEtkVzd4NzdEaCtRY05qdmsyRlJTck5ET0tCOXgxZS9scjBWUlF2UW1L?=
 =?utf-8?B?QVhheCt5RFIzS1FXb3dzdjlLMkxqelIrNVJUS3ZhU3FDSWVIUzlad0k0ajVp?=
 =?utf-8?B?QitLTHFKZEdXS2JaeTVBd0tVVEZ4MlJSK3VPSzFyRGFsazVPb0pPMjJLUkRZ?=
 =?utf-8?B?OHFuSU9tMklabVBWeUZGdEcrcXFDaFFzVlczWFZSem1RNlpkejIwUDlrcVYw?=
 =?utf-8?B?MWFkQVY4R2dFd2U4ZE9wc2JLQUpLM2RTblpEUnJ6eFIvb0hNMmRqRFV5VzRl?=
 =?utf-8?B?dzc3NHNZZm5zd29XSlR6RXNzM3dadmhXeFZMS2ZCNWhvd1ZsMHRWdWZxYnZN?=
 =?utf-8?B?d3dTd1RsKytPTCtqd2FOQWlMUHk2MjR0OGRqaDhDN3A1YnpTclFDbnkraHMv?=
 =?utf-8?B?aTAvd2ozbGVvdTRiWDUxNXRuYVZYMWF4a2ZGU0I2bzhjaWE2VWErZlE5b0M2?=
 =?utf-8?B?eGZtWjkzTDlPbm83K25pM0R6OWxvWEd5OGh3SEhRZkZCUFJySW9PRUZzbkYr?=
 =?utf-8?B?OUx2NXo5Q0ppZkIwRUhEMDM5NmM1c3d0NmNRa2UwTDQyUnNaalkreG9iK3VH?=
 =?utf-8?B?VXdtZG82MmpjM1VOT1liaFRRQnM2TGd3Ym9YdVYxcUlkaGpjRnRreWU5L1cy?=
 =?utf-8?B?amxpNHI3TCt1YU4zRStxb2tTb3EzMnFIUVRPaHlQNzUxODJXV3RWVjF6a2pT?=
 =?utf-8?B?RVVYU3JpZHU5cE5sVDY4WjBnRk1WemJKSGRVWUIzSlgrOWJoTUNva0FuTHdJ?=
 =?utf-8?B?WmIxQzB5YTF6dkdTNWJRMkhnTlpqQW44Wm9BRU1QZFhSd3grL1J5elpHaGZz?=
 =?utf-8?B?bXduMmc2bUdrTW5ySndKaDI5ODFZVklMRkNWZ2tpNVBqWVBydXJnb3ZwUVVP?=
 =?utf-8?B?VjdId3JsVC9ib2toNmJuYUlBbHV6MVRqRTd2bWJQcTZkcytGOS9vUzgzcUZq?=
 =?utf-8?B?bkNLYTFZazFPNHRIbjcwRlhNK3g5dVlzRTYxbmFTbVpiVFBOcUNvbHVMVG1p?=
 =?utf-8?B?eG1Wd2l2Q3B1aFYxRXJGVVBiMkJYMWhhUmd1NXVXTm9wNDhKMm9JeldJREM1?=
 =?utf-8?B?Qlk4d0xrK0hjZkNFcDZTalZPaDdpemt1TW5ndEpiTHIyNjZwUzZkZTJtZHEx?=
 =?utf-8?B?cFJ1ZXVuQm5OZkE5S2p1VWRYdWdoRXZKVVlWYTMvU21IOVpFSjdkVVBacGkx?=
 =?utf-8?B?SXdVUUw2dWFJOXhvbUlVU2lnbDF6YVI5d2pmM2JFYmtnOFdsY2NPUGdMK0Fi?=
 =?utf-8?B?WHp5eFZna1JnZFlzd2xZaFZqMUhOeHRNL0VEK1pTM1gydk5GVnVqRENwVGhi?=
 =?utf-8?B?NGxvcUFKamsxUFRLakxCSGtwcE1RTmZKL1ViZW9jUHM3TDdicHhSUEZUaWNE?=
 =?utf-8?B?OVcyaHAyelRVanJxOXlJaFVsYVJ0VlUyTkZhalJzbnJNMmJ6K0xFelZvWUR4?=
 =?utf-8?B?MDBPQUVEY1A0S256WDhFUE81aHVvUVpETmt4WGdVMUg2dGpGVEdFcDFSemgw?=
 =?utf-8?B?Nm5FZXZFZEI4WWVkaUZDOG0wbVZmNXFDcmFYUURRRVlYZVhhMVh6b3Y0T2k2?=
 =?utf-8?B?RzRiMUQvWnJNWUZNWnlSU2RDVTliTjNnVTMzc1VVNGdycUVmVkVqUVhlK1Rr?=
 =?utf-8?B?VDVzWG9SN2JUaFNscGFLU2VSZEFGZm1LN1pValRyRzhuZkkrRXBsQVc5eEh4?=
 =?utf-8?B?UHZ1aWpKUitGd1ZIZG84bERjdVFDcXFzaGlUanVLNnhrQlNyY2dkNzVJRW1S?=
 =?utf-8?B?VDVWL0lXYTdya2RKUVVWa1Jnb2ZieWp4NUl5RDBiRmR0aVd4eTVBOGNOenNF?=
 =?utf-8?B?QjcrQ2FOeWJnTk1ldEwydXVBMEs0d2RlTW1qanEvSXQvYVFVNElkQjU3WmlG?=
 =?utf-8?B?Z3p3ajZZTjVEYlZpSnJua0ZtazNOcEkxKzNET2JUdk13M2ZNZUNWcmtPL3Y2?=
 =?utf-8?B?VVpsS3A1WUduVVJoL09abWVpbis5YWhDZHhEVzdZbUdXQ0ZhSGhqRlFLZU1Q?=
 =?utf-8?B?b3c3V3pFL2JRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3dLNVBlL2xzU0xzb3lsOGdhdC9kd3IrWGtZdklXWEEyUk9YdXFRVXV6MzRi?=
 =?utf-8?B?bnBXYmFVWDJaeG52cTR2SUFVOGRrLytKVGdJSzRHbmdtMXd1WENDZWNVR1Rz?=
 =?utf-8?B?eVdjdGJ0VnpKcTZzSHUwS2pTTFpNUDFpZXVzNEhSR1dqWTFhYmVQdlp6Mkht?=
 =?utf-8?B?TEZMTzN2YXhkczNBNEUwamNsSjNuTjY0dzZ0OUF6bFg1RGpIRzltTXQ0TTFs?=
 =?utf-8?B?bjB2ODlsY3kxMGxrdzZJTDFOcWVRRzZQbzRJM3oxZUxyNDNXeDhKZVR1eXk0?=
 =?utf-8?B?MXExcVNLUXJ1OXhBZGJRMVVXcUV1TzRWdk9DcFp6dko5dGx0OUJENUU0ZEFp?=
 =?utf-8?B?WStOM0RZTlZEYTg4RHJPaEkzYWo0OTVqMXlGMEp4N2tBRXdTbGVlRHpramI4?=
 =?utf-8?B?ZXV6NjhBTDBCTFJ4eWlGSkpyZGZsMitYQmR0SW9iRjIrYU5lRW5BWFR2cks1?=
 =?utf-8?B?eXFpdVgwbTFOWWxPK3NLdzJCQXdGM1R2T1BCakNGWjdPNjlpeG96d3B1T1pO?=
 =?utf-8?B?cDN3ZFJvblBvWmVaZUc5WFFRbm11YU1QZjBqWkpYVm5JOWJEaEowSENIcWxr?=
 =?utf-8?B?OTJrSHJMMGR2SUFUUGhQRGdxdHMwcnJCblpyOTNrZU5vKzQ1azNNR1Fkd2My?=
 =?utf-8?B?NWhZQUNzeHozSjRmcGZoOUJ0bVUybjM2MkZvc1FPY3EyYTBEK05vTWwvOVkz?=
 =?utf-8?B?OFQ4WHFxUkdaVG9rNGg4QWpXa3duRmVZVzZxR1pTZXNidWF4eG05TitJamU1?=
 =?utf-8?B?dFVqYnVURTFrUk9iYmhMa0d5dG05TXR1L0xKYW1reUpLSnZQL3IwVFdML1NO?=
 =?utf-8?B?aWpTYlZwbGdtYVJiNDlYZWh3QnZLMGNiR0lRTStvQzJmZGtEN21LNmNGTTVO?=
 =?utf-8?B?eWFLamZXYjM2bHdJeEovcGpVK2ovcy94MFJFYUl5SDYwUm5udDVCVFRlU1Iy?=
 =?utf-8?B?OVFoa0dMOC9WR1Bnd2RhbVhLRjU1MDIvRU9DUHhvRkNXc1RqZEF6ajZpeUlM?=
 =?utf-8?B?NzdxckxteGVHR0lqdDZOV1F6ME1BWU1kTTNFMjJNUFRGdmg0VkNYMkxnU29M?=
 =?utf-8?B?THl1YkEwNTRJcHljVU1WRjhrUlZSKzVOSmQ4TTlnZjE3ZS9YRzBVRkxlTkQz?=
 =?utf-8?B?aURqTDIrK2NrTDdBdDhJNGNlYkxOSVFPYmNoZkxma01ycVlKZmNFdm10U3R0?=
 =?utf-8?B?cThSMkp0VUM3M0cxcFRsZTE2TzNVczhJTHlVdXpPMXM2aVQxZjMyRG12MGdF?=
 =?utf-8?B?RWUyRksxNkJJT2ZtZjE4TUE1VW1ndFFpWGt0SWxkTWNRcDUwUEFsV2cyN21s?=
 =?utf-8?B?d01Ja1VsU1Z4T0p6Z2pNUGdhYVhWMEhpaFhzR3hCRE1rWER4UTFpRkRMb011?=
 =?utf-8?B?ZFZHcHBmQURONjU3R3Q4aDJlUGhjUHIyb1czYzJRancxUzFDNFBFQW03T2J1?=
 =?utf-8?B?ZDJJUGI1MzNCUFVhSzFLSTFlVVdTT2p1WnNQM1owM2hoUXlGMU9TV3dPNUcy?=
 =?utf-8?B?WVRLQzhhNjJDbFg2U1h5b2pHdTdpT1VKWFpCRU1vNEtZNG94WEtHT3FZUnFG?=
 =?utf-8?B?eFA0TTZyVkRBazBuRjk3ZkdzUGV6dFdwcW5LeGxBM0tpblVFeGJ5R00zTWE4?=
 =?utf-8?B?T0hYZ2xmczcxNEIrVWpBRzY1NjFoa0VDamJpcmNhcXNHNXZuU3NZZlY0NlFE?=
 =?utf-8?B?NGRncVgwSFY2by9HVTlERnpGdzlYUzljZGh4Z2VuU1BvQ0RPSFVlUUkyL1k0?=
 =?utf-8?B?RWphODZoOW9tSFAyWG1FVWFLNkFlUHQvU3BwYldXRWVraDY1VjJpZkdwbUEy?=
 =?utf-8?B?K1F1OGtJV1ZzdXI5V3A3SGgvYjA5ejdFZXlDcGFGTFpXbzRPcjdnWTk5YWVJ?=
 =?utf-8?B?L3NEWjhYNTZXT0NTMUZVc3BLWnlPanVNMWxxZDBVOFVKaVdqWTJSUm91R3dY?=
 =?utf-8?B?b3ZtRStjVUdySGNPYzk2ZWE5ck5wVXJ1TmRmY1VjdnQ0TWtHK2ZQeEF3ajZn?=
 =?utf-8?B?alQwTjVld3BUaFh1aVkvMUJXUzJMV0lQNFl5SjU5TTU1cHdwYkV6TzNFR09S?=
 =?utf-8?B?YXlFQUlRR0dNY01FZGxkZmthYzdrYjdwZy8rL3QxU1JLVkJjUFFrSVEwRFVZ?=
 =?utf-8?Q?/oOTykUk5haQ+oq7GpuWR1yeT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3b6fed-57eb-46e1-962e-08dd97a7e1a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 14:09:06.4339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dq513P5aE63Kp/ICyO/apg42aQm9PDBfpnDhc6LHiz0TyPsLOxOHZMqpFY7lIyYCVo3YoR2do/wz4UySChurcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7884
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


On Sun, 27 Apr 2025 23:46:19 +0200, Alexander Sverdlin wrote:
> That's how it looks like without CONFIG_MMC_SUPPORTS_TUNING before the
> patch:
> 
> aarch64-buildroot-linux-gnu-ld.bfd: drivers/mmc/cv1800b_sdhci.o: in function `cv1800b_execute_tuning':
> drivers/mmc/cv1800b_sdhci.c:47:(.text.cv1800b_execute_tuning+0x50): undefined reference to `mmc_send_tuning'
> 
> 
> [...]

Applied, thanks!

[1/1] mmc: cv1800b: Fix build without MMC_SUPPORTS_TUNING
      commit: 72ba30aeccfc225152c19991732228f95b050ca4

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
