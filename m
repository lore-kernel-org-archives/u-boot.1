Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F789C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 16:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E251B8033D;
	Wed, 15 Jan 2025 17:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IbJ/9Gib";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D34780657; Wed, 15 Jan 2025 17:53:14 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECDAE80040
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:53:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2yVDCARtps3vUecw75LGkdLeqGfLghAbwX3S4iPot3+OGK5sBzLh6XLOwigZNhXt/ZWAYCv3gUqWFej19Dsy9ax7URQVkyQS7kCdVxvOzduxghRVopZFbiuZbtACbJCAKF6cdXAh1SLzn+T+OImLinTkaF/FnfQs178oVW7wgb+MsHiaYu+x3VfdjMmNkXklL60IbYlPXo33Ycmi4a3V8MJXa51xikPWy2A/7xBjTDpW6jg6PgjRCWymTW5AVBRV1Lp2zKw5AQjklvdy3HHS4+lDyJjaoOpkivshpTU19H5SgF+ssfSLllonEJiPzU1DZ5q6xiIbsRbPXiZHzarVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7AFBmz4liIvMtYiMJ9oi6T+M6XP2T8km9CZV01Avuk=;
 b=nmrBmuL3220fuRrg7ueVMm4H0md8Ii+wUYQFhQuIfzLH96f5t8YxUhI9dn142ThouElbw4EyIbbgBcXBOG98NYVERGSHJsq0Re3nyiHnawGBvAGpIB/HG5LYyx/cGcSxFkTpdAObX9oNu1y1+/Z/PqTgJJFoTQlENpp+JZhPkiygyjCNn0dINalOUve2CXkaPXsEMePQ7QwTwRnTGu20CY/0eymmyjdA23MbeHGZa9Ccf41SSV249EL3xpvOV76WVeaIokVTNYmsErQNQYWsBvc2+30u/a7wh+nSQG05o/ZEuFPbSHlpopOoTjHDfgSh23ivWnogMSwmX6xAKvw2hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7AFBmz4liIvMtYiMJ9oi6T+M6XP2T8km9CZV01Avuk=;
 b=IbJ/9Gib2bBx9o/uDvnv7wxeoZdIWE7gjlfv9dQQCWKyL3HBeFWK1WgxyKo9/Dnf4r1hCnXJ2enKLcyRrqrgpr+kJJ2F8SSt/EWsAqQBuA8bWswU1vdnAUHIMeo5Y+m2YySwuRpo3Vs7D+rWXdbE4Rc6aTiFnhSvGQcy2usc6qM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAWPR04MB9887.eurprd04.prod.outlook.com (2603:10a6:102:390::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 16:53:10 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Wed, 15 Jan 2025
 16:53:10 +0000
Message-ID: <0d94d1a1-9dde-4916-b7e9-2112e2ef66d8@cherry.de>
Date: Wed, 15 Jan 2025 17:53:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Simon Glass's future with Das U-Boot project?
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
References: <20250102161313.GP3476@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250102161313.GP3476@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAWPR04MB9887:EE_
X-MS-Office365-Filtering-Correlation-Id: 105cf0a1-735e-40c6-5926-08dd35851797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b21xdXlxMm9reVVWdU0zdnBhVFdzMmtCdS9jdDZtcGlZWHllcE1wMC9LVS9L?=
 =?utf-8?B?Uk9tU2pSWklLQUVRME5PckVPcUkyWmozNUJ2TXoyKzJSNFpIeHBnWnQrZmRq?=
 =?utf-8?B?WVVaOW5UQXN4RmdWWklwK0I3UHhtL21kTEFIOFNyV1ZhT3hDNnhUV3p0SWU5?=
 =?utf-8?B?NTkvUzFvdCtNZnlrVG5YSWU5OUg1VU9YNExWN2JCajRJRWI0Ly9wOS9XOTFH?=
 =?utf-8?B?ZFBXRmZza3k2VXFCNHVRNUZOTmdSZVdWVWxoMkR3cFc5SjF0L3k5VXB0WWFp?=
 =?utf-8?B?S2VRRkVyRTVIUEtsdjZrQjlZeTY5bGNSVE03RnFHSkxvQ3VQS0g2WkdUL3R6?=
 =?utf-8?B?aW9rUUJ0TGhGdmxpUEFxZ24yb0J6UTZMQjA4WTVSYnFEclFjN2dmdEsxN0xW?=
 =?utf-8?B?KzJ4eldwU3JlSXhKaHZoSStRL3N1cjAybzg0V1RIRE4yNEZhNEJ6c0picmVU?=
 =?utf-8?B?S21hTG1SblN3V2lOU25SMXhueHBEeGkwZEtmTGQ2WXhtY2xyUUpHY2Q4OU00?=
 =?utf-8?B?UFdDV0ZwZHEyQkRzUitLZ2gyVDJUeWRUd2Q2VExISEVEbVRiWXdsUUQvTk5a?=
 =?utf-8?B?UE4zRkFDcjBHWjBjU2VqTmNrOW5LRW5IWTRoVlFxSy9ITmVRVlNYZU55ZWFs?=
 =?utf-8?B?MjFHeUVzckg1ZnhvbHBxTGRHcmV6Sll5RXFLUCtzZlFidjZrVFJqOVIzUEdN?=
 =?utf-8?B?cFhma0dyLytwbytCZ2hHK3Ryei9TNWw1NnJ5QXU3RHY3cUVXVmlQeEg5MTJv?=
 =?utf-8?B?M3Y0ZHhwcXFUOFhtSm55MUc5MDNiNERLSGZaQm8zeGQvMjAxb2lNam1RN2NP?=
 =?utf-8?B?SEtYVXdLa1FkOEdJUVVlWWNod1ZyNGY5QWxmbnVXVXlHT3QyazR0Y3dCaEtw?=
 =?utf-8?B?TjNUeFUzVVJGT0hRVnpMYXU5elFUdVZLeDVDOExxUXFwNE5mMWRjeGxSM21m?=
 =?utf-8?B?Y2I5K3Eyd2s2bVZMR3J1VDRlcWxqNjdXYlM1Qk45S2dJRUhvY0dKeEgyR0hq?=
 =?utf-8?B?N0RjaUxIVURWdGpMZ3dJVEg1SDBrRTExN24xb0taekMzU21xY1prbklXV3NQ?=
 =?utf-8?B?Yktubll5Wk9Vblh0UWE0V1k4RmNXN3k3aCtDNE8xMG9qUFIrMjlhZ0Y4ZkFB?=
 =?utf-8?B?b3A5VktvMGxwZDZDUXQwd1FWb01hUnA4VW1TNjJJVUpvQkNTczFtWU1tMmRL?=
 =?utf-8?B?QWlCWFFmUE92WjBpRmNYemo2UGlURlByZnl5VEk4SjFrT3pSRk44YVdhdE5M?=
 =?utf-8?B?SUpTTU5yWVRNMDRaU284ZHd0VUNBWjRqVzFyZkMxN2U0QmdqYnJnSUtmbEl2?=
 =?utf-8?B?RVd0UWpPK0dIa0VaY2MyNHdZRTRiZCtJYVR3T3FZaEh4NWx3aCtoK014ZG80?=
 =?utf-8?B?MXVTRUVRK2ZYOU9KbkY1SHlhQzdVUGtXY3p0MFo3NWVMeGNFSENlOU16elpD?=
 =?utf-8?B?RlQ4Sno5YkhIUkFYMytMT3FjdkprTGlUOGFkckZGZ3JUS3pld2l2bDhWekFT?=
 =?utf-8?B?UEo4ZWhIcm9LVDBMVHUwZ2d1MjJMd0dnYTY3cE5vclhOeXZ2TjlmbWRtTU1j?=
 =?utf-8?B?SXpYeXNOMzU0Y01OdHNMaGtzYTdoblJxVXBWcWNmcnF6amJpaWZtak04bnZL?=
 =?utf-8?B?dVlwQUJQWFZ3eGlZMXdOZEtpaE0wSmRvRW1sc2pSdXhIVUgxcWpBdEdFN0NZ?=
 =?utf-8?B?eXZaQ0U2Wks3dkdCaDUzajdWcUFLUFZKd1JadVN1cnVDL3cxTDJPNmc5eldp?=
 =?utf-8?B?RlJFM3QrcFJKcHE3dTFaY29uTWdMQVdXUzJ2MmtLbVltVUlqeGsrOG5hSm1J?=
 =?utf-8?B?M29scEpZbTlJeVBWbDZ5SlNrWERKNndtWCtCcEFLQXQxZWp5dUZQTHpPdlNH?=
 =?utf-8?Q?sKIX5+tLYb3IG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0ZEVmRIRExuK3lUMVE5aGUzUnJKT1I1bDhKMWYzQWRlY0V2aHAxcGMzd01N?=
 =?utf-8?B?a0psOEpzYzR2ZGVYcmQ2TGU0NXZGSHpLeGJLOXhtRmg3K3pxTnRZM2N3cWto?=
 =?utf-8?B?QzdoRGphTE9EUEljSnVWT3RQd1g3cHhFZUppVkxsUTBoeTY2S3R1S09HejUz?=
 =?utf-8?B?WVNKUTFxN2pRNWIrN0NzWW5hNFlCdk00bXN5WG1mWWNqWE9oUUNGTUtvbHVZ?=
 =?utf-8?B?K2p6bjFCMFMycU9SK3Zqa0xCZmRxV1crVDVMdEFjTG9NWnNmRXdJdkw5dkZ6?=
 =?utf-8?B?Z01qdjJBeis0VnNLaGlad3RQdHZJTUJyZVhpUTUrUTI0OVJqdUM5aGUzT1FK?=
 =?utf-8?B?T2kzSzdLZk9rQXRPeG8rdytCYXA4K1phTVAwNjRKNWxzQVBLQm11LzdzbUVC?=
 =?utf-8?B?TUtiZ3dabHl0QkhtdXpaVVltVVE5NWZjY1RxVEhDSitqemQ1eGxJdTlIVVc0?=
 =?utf-8?B?Q2hReXNtSll3alB6c0V0dllGa0ZzZ2ZEbFpDcU84STI5OVlGTW8vN1F2ZUZR?=
 =?utf-8?B?VTFHUkN5TDYrcjc4M0RXMmV5bURYbzlOekNzaUlPc2Y3UFY0WXI4TlRONWt0?=
 =?utf-8?B?VUpzYU91Z29XdjQ4UkhUU2tuVm93cUZjNHg4Rm4xZDlhcTNYM3RGSFFGaWV4?=
 =?utf-8?B?TDhRM1ZoM3E2K3dmc0sxV0N5MFdKaE4yWHNXM29sTnhNVUswR2RRUzIxTFNn?=
 =?utf-8?B?ZHgxYkVCem5ydkVrK3pFRStuSmd6Yyt5MWZTKzk4eTJMd3pRS0hzN0k2V1Zx?=
 =?utf-8?B?d3FvUlhwOCtkNzJMRFVTeEtTVVFrczVCSlg1THlqTFd3YTVKNi9YaXlDWDh6?=
 =?utf-8?B?VWtuWVJpeHF4SjQ0OStvVWxrTzFPbCsrNGEreG15aGFFMjZQYVExdzJ2bDVa?=
 =?utf-8?B?TzdpRW4xUFpaeWpvSHJZNGFMUW8wVm5EQ2s3VEpCN3Q5TXNTeXlTb3VLWEwy?=
 =?utf-8?B?dVdzUUU4ckM4MW9UbDVQL2k1RTRrK1BWSXFGNzBZay9rRWtwWHdTUzdtU0Jx?=
 =?utf-8?B?ZmVsd1dxbjE5dldpWks3Z2VlcGQyemNnK05OQ0xqMzN3cWtzajNvd2d3VHUw?=
 =?utf-8?B?OWpjb1BxZHlnNTEyQ3Qza2tnR2hhVFNKKzFLQWFMd3E4NGpZY1A5K3RzZUUw?=
 =?utf-8?B?RUEyUS9jdEN0em1FbG4wYVBSWDVybWhjU0c1R254QXA2Rzhqc2dneHZ4cmFa?=
 =?utf-8?B?Z3h5ck9QSHFSTmFKQkRVTDlOMllTblZLbHBVSUE4TFc2TXc0eUhQNmc0VHFu?=
 =?utf-8?B?WDE5Z2VlSU5XWDZ2dGh3TllzaERmejR3QmdMcjdPSHRoSTFYL0VkeTBGQXRr?=
 =?utf-8?B?Wm9pd3BWbXpiUmxFQ3ExZWkybytOS1F4SW9qSmRQeWNGQXJnOUN5Z3VVampX?=
 =?utf-8?B?SmdSdUsrK0lod1NNU2duM0tCekN6bGdEVVY3MFBXRlNBL1RadHY2YS9PVTBR?=
 =?utf-8?B?djNmQzQyNzNYMFl5blYxR2xjQlBhdXVhb3UwQ05xV1JQMG80QVlLSGhoU2FH?=
 =?utf-8?B?VXpDa3BDbzRuNGJxSjdOWTVlV2gzSDd3am84VTUwZkRpK1lERnJoWm9CbUhn?=
 =?utf-8?B?VmcvWFNLM202cGpZYnkxbSt1LzY1RGdqV2lRekVIVHorbUhDaXFSZW1mSTlx?=
 =?utf-8?B?YjFpZHluNmNuck1xTEJCNU1BRENnbnhEU2NjV3UydnFnY216NGlFeEcxTmEr?=
 =?utf-8?B?Rkc2a2FjWjZtWGF4S1k4cEpyQkRvbXVYKzUzVVRjdVQ4eTVPWVFVZ1JvT0Ix?=
 =?utf-8?B?WTlwMDBsL1ZQSnhRbGViSEE1MDdvUnduNURJdjVjUVhZaVdWWU14QmdmejRk?=
 =?utf-8?B?R0xEN1Y2TE13RHRmcW15SkYyQ214NHg3TGRLbjJZSVBTU1dhL0JSSCtHQVFS?=
 =?utf-8?B?ZU9SYnlDRDEwcURpSENMY1FqdFdrN1VxbnRwRVZIK0VTWWY5N1ZZcTkzR2tP?=
 =?utf-8?B?Y04vT1RTRld2Yjl5RXg0cEVwZi9Tc0JSc3grN2QySmQzVG1pUWlIUEs0UVdz?=
 =?utf-8?B?aFJxZG9LSW1vdjdHRWgrcXYxZUJ4cVFmNXZVWitrVmtvSTFBZ2pXdnRmMEpI?=
 =?utf-8?B?Rk0rTHhCQ2t5N01kazcybDFuYTIwVjBSRVk4VWhUd0ExWmtzb2dMRENWTXRk?=
 =?utf-8?B?QmxFdm10d1BTV2FOMmcwc1hOTVdGa3Z2YmFDdXcwTlpwSjdPbDM1WlkzK3F2?=
 =?utf-8?Q?vK4gyXXHt+cwZU1Ft5pYYOU=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 105cf0a1-735e-40c6-5926-08dd35851797
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 16:53:10.0490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mf32FlXkygyrBxs30owEkv5I7HeRLhXSja3f3hn1DRBqDhi1JmHgr/AFfs26ZR9s2Xd7FjAKSuXIQuUgcUxBN8lgsDaYC2vuSPpHW0ysxyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9887
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

Hi Tom,

On 1/2/25 5:13 PM, Tom Rini wrote:
> Hey all,
> 
> While I had hoped that the quiet of the last week or so had meant that
> things would perhaps return to how they had been before, Simon's large
> patch series and then comments on the TPM+bloblist patch have shown
> otherwise.
> 

I would appreciate some context and possibly links to the problematic 
comments so people who are not in the know can provide their point of 
view. A factual, as objective as possible, summary of the situation and 
maybe afterwards your complaints about it could help too. Because this 
is lacking, I'm not sure much more feedback will be shared?

> At this point, I do not know how best to handle Simon's behavior,
> without soliciting feedback in public first. At best he's created a
> soft-fork of the project with his "sjg/master" branch. I've asked him
> repeatedly to explain how he thinks this is all going to work out, in
> public. I've had private conversations with him, but I want him to
> explain in public. Or, he can post the messages if he likes.
> 
> And I am in the process of getting outside help that would in turn be
> able to help the project move beyond the BDFL model we've always used.
> Because at the end of the day, if most of the active developers would
> prefer the direction Simon wants to take everything in, that's something
> I can accept. But what's going on now is towards the worst end of
> possible outcomes I think for the project itself. And by that I mean,
> one prominent contributor steam-rolling over others and doing as the
> please and implicitly acting as an authoritative voice for the project.
> 

It's not clear what "Simon's behavior" means here so it's difficult for 
me to say what I would prefer. It's also not clear what you're asking or 
suggesting.

Is there a specific reason to keeping it vague maybe?

What I've gathered skimming through the ML the last few weeks seems to 
be about the following:
- Simon saying he merged patches into his sjg/master branch but it 
contains (?) rejected patches or is not sending pull request against 
master or next,
- Simon sending patches based off this sjg/master branch, specifically 
without notifying other reviewers/maintainers,
- Simon sending too many too big patch series too fast,

Can you please clarify what you're bothered about and on what you're 
asking our opinion/feedback?

Cheers,
Quentin
