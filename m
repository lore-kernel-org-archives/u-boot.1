Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA2AC25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 15:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 294CE8860D;
	Wed, 29 May 2024 17:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IpX30u+m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A9A18860D; Wed, 29 May 2024 17:03:41 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9890885E1
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 17:03:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kethBNuCDvBRHIuOK9kH1FluXLwZT/KafjkP0U8/E4hO9t1qA2qIK4dBqrCYe6V/o9Rx8hNgyLiTDy9QA2SHjayNvr5OyAnRMWXRbiJASIg7UqfS+QBVLEnOTAOQT7aoDdPLmymDZQ0XfHSk3Pr2uv3cum36y8nug9jrARLwJ03wbg0ueSnhWFTguyASlvWwF3IPA7GcWZIwS3vXdHxzUBlZ2wmgSMG/BsnN49Hl7fE9kkIsP0NfVvvR452ROAnv+QbYYAO7xP5Rcb+FTkhRS0cMrbARGdtkhX+nYBsdT2uDZ+nJm+ErthxJiBpPJMIkrPF3E076b/B1Bxz92dP2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WCQkjMeS2OPM6VEyRDCmsj8N7JPLINEmz+3z2eYsog=;
 b=EqTTtHUn3Dj/5f3oOEZmootvt+6aWwJ7aRZULnhlsdC/apClmwYhkoFYbHWJ8ScZ8Lt2GYm4c7FbS76gvGRLTLWAJ3wCETCK884oZmCelVn5rQO4sx3Cxsl3xNTDoW5B+Q5KOpax7IpuwO9SQSJNi8YMFYvENC5o6KjkLyTsPJgY9i68jANBSe1y1L7HGpcTdK1VbDG6osrWToFl23kFxuKVScW7KgVYhazEphBXNfLKY3xQ2tQ5Ao8B0FPxjykKQUjfkbugNG0qUbCeUmjS0YbM340s3OUaWpCfbcI4r8bXAfjOxuusBp0JjPbLxk2hkO1BYhAq+U9YTxvcejRHdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WCQkjMeS2OPM6VEyRDCmsj8N7JPLINEmz+3z2eYsog=;
 b=IpX30u+mIvpBhpjdXtK0/MTE6eORkq+TJLccHuWIyPcmPBkReOl6sPIDtltPJMwsZBEJT8xYtqC53ZFPC6M1GKiShQIigRXMZ5pFFowBDDeCrNWP28eGRMGrqy1/uQjRVYJyXaUq2ZvjDbr1MrvqG2afltmYt6wB+zKaxIiCk+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 15:03:35 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 15:03:35 +0000
Message-ID: <82f63d08-3dce-4166-bd82-246cade9ab87@amd.com>
Date: Wed, 29 May 2024 17:03:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] mmc: zynq_sdhci: Only evaluate card-stable
 signal if card was detected
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de,
 "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
Cc: Stefan Herbrechtsmeier <Stefan.Herbrechtsmeier@weidmueller.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Johan Jonker <jbx6244@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240424082343.212554-1-lukas.funke-oss@weidmueller.com>
 <20240424082343.212554-2-lukas.funke-oss@weidmueller.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240424082343.212554-2-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0303.eurprd07.prod.outlook.com
 (2603:10a6:800:130::31) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 9943b3a7-8171-43d6-56e1-08dc7ff08331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHdCWVhwL2wyeWd3YXlsSXhXMWhGYmUyM1l0cGFocDM1NDZ6ekVHQVM2SXEy?=
 =?utf-8?B?RTVQUitOcDZFZitMMU0vSlhDQXNmMTU0ZEd0a0p3Qm13SmppR0NOOGxSR0pO?=
 =?utf-8?B?OCtOWGF5QWV2Rm5Wa09sWE80WFdYWng5eGFYVW1WZjQ2ZVdKVEl3WS9HSXMr?=
 =?utf-8?B?TW9QaXo5Q0ZEQVFMZTEvTzFQM2ZYZjNFOFFrSUxGNlpGanZrcWNvazZLbTNR?=
 =?utf-8?B?dHIxT3JMMy9CTDNoTi9iZWM3bUZvd0F5aWJ1WjNYT0VxR085L0tJSmc3NXRT?=
 =?utf-8?B?akRQcjQ3VVdvOVZNblRocVFnSjQ4VVFmQTVtZlUreFQxL3VUNnBlYTY3QVVv?=
 =?utf-8?B?NDBjSUdpQ3RhSjZTQ1RBUGF1TG1wOVVmeHZiVnFCSUFEU1FvYkMwOEl4VnN0?=
 =?utf-8?B?aXZBREM1YWxZc1c3ZUF1L3JScVh6VFBDb2NRbzA4Z3dOWUoxWUx2N25ZeE5r?=
 =?utf-8?B?d2NjTnNyWUFWN3NOWUo4RTFFQVJDVlhpK3RkZXZGZWlCVEZPbGNGTnF0VXZP?=
 =?utf-8?B?NjdkWU9RUDhZajA2WW8vMktDc1dFVDdXU2VMU3d5em5TOExDZHZONTFDSVpy?=
 =?utf-8?B?cWJESDhwbnU1emI2a1U5aGlkb2ZaelRwbXVOcHdXM2tzaElMU0FWSDFXMWxo?=
 =?utf-8?B?TFZMcEIzTFJpUENudnpWWDE4Sk84RE9obDhkRU9wa2syeWthWFZ3YURjS1E0?=
 =?utf-8?B?clVUWnRrRjNwbjNJQmhVR3VxMzMzZFhtbjlGeGVnL29XLzFOVmNTN2U3cmE1?=
 =?utf-8?B?Mkt1bEl4YUhLd1c3di9wZjMvSlFjTi9YeVNmZTdEUDZJTy9EYjhsUnpXQzl1?=
 =?utf-8?B?QlpTeW5qK3RscEVHL0JtRitlMWZYQ2hxUUc5V3krZ3JUL1NvWlVocmlISFZt?=
 =?utf-8?B?RDZWbkQ2OGJ5cWxSVnI2cDBUSmxFbkk1ZTFGU2p1OHRoZ2lFZGw0a09RWlZ3?=
 =?utf-8?B?ME5rcWJCMnozdFMrc0YybWpOdU5SbTRibk5ZOXc1cXpUK1NlaWtKdFZIc2gz?=
 =?utf-8?B?N0EvU3JDeWR5VzR6c1ZFMGRkSk9KTXVSaDhXbGphSUhGR245Ry84MWE1SE1v?=
 =?utf-8?B?U2d1VjNoZi96OFc5cUpmcjFlU29FOGg0TEM0MUY3NVNJTjVBK0d5Qkp0ZHo2?=
 =?utf-8?B?UDgxU3lkbnE0R0JqUUZuNTlDQk9YbzlpV09vSUtxRTY5MlQ3TkpNMGZZWTE3?=
 =?utf-8?B?ZnNBOW9IbmRGZ2dTMVlpckJWajFYOURuWTVXbXZnWFNsZ3NJci9nVTAvZENH?=
 =?utf-8?B?WHZ3T2NoeG85eG9KbmxwQWJnYkpSSXd6QURIbU92bVNOY0g0Zm1jZDNKVDBn?=
 =?utf-8?B?UTVyaERHOHZnM0NQTjE1V0xIejd5NllNeEtiS0dORDQvKzZiaDhzVHJ5ZzRJ?=
 =?utf-8?B?emZ4UFpRYndvdGhwSG9zdS9ISWx1ckROQmtDcEtwcDcxTktYcVgrKzluaW4z?=
 =?utf-8?B?Umd0VUQxcnhNMlUyYlErOUo0QUQvNlM2cUFaMjcwK0pHZ1FsZHphUU8zekFC?=
 =?utf-8?B?NXVjQTY0QjZsdzdidDN5T0hPTHZ6Y2JVb0tQUS9ub3V4SjlFWjlHY2lMRkdn?=
 =?utf-8?B?M3BYaUJIblNXNXNBYVNMclFCSFl4U3AwMWY1N3krZ1hWcHVxOHE1L0dVaDZr?=
 =?utf-8?B?TWFxVEx0eHZkWE5uN3ZoQ09wTmVTbko4RUpzVGNBbWxKNENURW81elYwZzNm?=
 =?utf-8?B?Sit1SnhnYVZtVDh6V0hTeUNGL3prZVIrTUthVjlNYk83bVhDS1hqRWNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzBlVXh5U0VleVhRSDN4MC9WZndZcncwQUhmQ1dXOTVXbm5HWUNSc3BwdERQ?=
 =?utf-8?B?ZnlDWUhnZVZyNWNiVFdleXFBajdFbldibGdLUlIrZjZwNExlZ1RzN2tGaWQ3?=
 =?utf-8?B?ZlR5OGhYQnNFVFc4RnJ2VjROT0lYUTBoQmpNWU85NjExMGI0Y3VFNW56bSsv?=
 =?utf-8?B?TU1sdXI5ZkxkK3dLUFliQWxNTjAwa00vcERrYkpkNmxWL1k1cDZBeWNyUE9O?=
 =?utf-8?B?d1cwcmtVZmd4ckszTlcvSW1vOEkvallRSDBhaUlreURaT0E1d2xoNllBcXFl?=
 =?utf-8?B?WEFuM0xOYXZndlErbzdmNG9vRlhJVFdta3c1dTB1eGkzT0dTdDVEYno3Q3U2?=
 =?utf-8?B?MDRYVjlqYitGclVmTFRtVDdVSENYalNYQy9vQUcvbk5tYlBCRmE2QkpYQjNN?=
 =?utf-8?B?QURKSHorRWk0M2daR210MWZ4UjN0b3h1ejVrdFQ3Ti9wKzZMZVpxTXpoZDU5?=
 =?utf-8?B?UFdNbWc3TmRrblFFZXVud3JFbUowak5ad0tvRytmSm8yREhIdWllUkdncVhG?=
 =?utf-8?B?WHhVelZRLzd5VDZxaFdzTTJFNHBVSmdmWHh6ajVLT2p5RGFoaWpVSU1uNnA4?=
 =?utf-8?B?RUkvSFpUNFBETzhPSmEyWGJ6QmpyZmxpa0Vsbjg0YXJVSHhCYmdmS1crRURw?=
 =?utf-8?B?MlZLWjYwYzRsZ2VUSTg1K2VRVmYxWkl6Vy80MVkxVU9VN2k2c2VoOVgrM3RV?=
 =?utf-8?B?ekx4Vi9wTGtQMzNvQkJ3Rkc3enNiYzR5MHJCbjY0N0d4dlNSN1JEdkNUWU5n?=
 =?utf-8?B?TVZ5bzJBcVRialIxUGtsd3MvWWdjZjRBaUVzS1NiZUtwSW5tVkRQZG8rMnFQ?=
 =?utf-8?B?YjA1Z2dKTzF2TGhyNjJqWFFiTUQ3YkdKcVRFKzF0bGozdUNJbHJWN2lpU0tR?=
 =?utf-8?B?aWNpT2lxdHVFNC9WZlVMNXlZOGw0VHNwVE1GcXpoSU5TSDZUQlg3bDZsNlV2?=
 =?utf-8?B?enBlTG41cnloOU0zU3UvZzlXbU1KdWtTUHhIa01jVHhiUVVySnUrSnBwaUZF?=
 =?utf-8?B?czJ2MUJLUFV3bXVHY094MjhXOWl4amFQMnlaMTk5VFAxNmRFOVRDRGxieTVY?=
 =?utf-8?B?QU9qRzhMT29TY2pqQkZFZEExQi9wZHRoN3VacTlpVEQzengzdDlORXhiclBV?=
 =?utf-8?B?U0lvZHNMU09QMTdwSlpQVkhvSE51Q0E3RnQ2VUo5RUZIQWFSaG45UTVSaEpv?=
 =?utf-8?B?UzNBV05YZnRIc1l1ZE1tdmRvOHlLTjBnRER6YkplN2xJM0VCdDhkMVk5M25l?=
 =?utf-8?B?aCt2clZCWTluK2JLUDR6Q25qcnhmeUJ3cEh3citqRTRWdmk5QmpNdERYbWts?=
 =?utf-8?B?aDlpdnJiRTc4b3VKVzhpWHlrbngrR1UvQmdZOUxORHJHM0gvY0VWU2cya3h5?=
 =?utf-8?B?c2puZDlCMjVPZjNvamJiMDIxL2FrcDhNa01YVEVKSWtLMVh6WEk3OEdwVk9C?=
 =?utf-8?B?Y09pZzM0ejFVSmI2R1FlSHdmTW41SXBtQ0RtOVVGOGIyajV0Y0NXUXJOUmcr?=
 =?utf-8?B?cFdNbSs1b3hFdWc3Z3NLNXV4SDUrOVZWczF0V3NSbklPd0ZqYkluVURKd3FR?=
 =?utf-8?B?ZDQ3czNIM3ZGVFBacTNXSEMxa3cvVEZYZXBBdTl1SDZYWk8vd2xWNjI1bnls?=
 =?utf-8?B?R29vUFUwZXVMTExQeVFENU1XRHllSDZlelFWYjhaSkMyY0pid3M2bjc1ZFpy?=
 =?utf-8?B?TFZYd2x6Y1lxKzRpRERvc1Z1NUpnQUJWWUxxc2NYZW1LUkZvSGV6SFR2RnpJ?=
 =?utf-8?B?YVVPdzhCVlJLZ3pMeG5ZYkRROFdUT1NXL05rdnpxTXQ1OW1NTXRxa0R5VDJX?=
 =?utf-8?B?UklkV1JMNUtyMGEvWWxjbHlMOGJNazgrSityQUdGS3J3ckRyTkE0MkJFZ1Ur?=
 =?utf-8?B?dFZ6YzdTb0FuYUtxMXRVMldhMTJNbzNPU2VIcW5rR1U2R2RqSklQemhjVTVq?=
 =?utf-8?B?bHBHSVNPSWViVkZ0M2tzRzlrMW5pVDljWnA3Y2NvTjduVU1wVDhqb2VWR2V1?=
 =?utf-8?B?THRFRStqRzl4WWd4OFFUZnl3UW8ySm9EQWxZaDY2SEtraWM3cVF3WXh6NnUr?=
 =?utf-8?B?S3pDZ1Y0aDFScE1Xb3RBL3U1eCtKTFJPVzRMT0pmQlUwZjhVTmtJZU1uOENh?=
 =?utf-8?Q?wVjOfgbI0WKhIW4q/hP3h/7YK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9943b3a7-8171-43d6-56e1-08dc7ff08331
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 15:03:35.2338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /le6vWH77PJBtnPkoDcaAmRP0p+yFdlqheInAdSqjK1h0M0FtQSQPcXAiC9f2CUw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
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



On 4/24/24 10:23, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> On ZynqMp there seems to be a dependency between the card-stable bit and
> the card-detect bit. The card-stable bit is set *if and only if*
> the card-detect bit was set before, indicating that the signal was
> stable and reliable during card insertion.
> 
> If the card-detect bit is *not* evaluated the corresponding check leads
> to a timeout indicating that the card-detect was not stable.
> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
> 
>   drivers/mmc/zynq_sdhci.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
> index 935540d171..d0bccd41cc 100644
> --- a/drivers/mmc/zynq_sdhci.c
> +++ b/drivers/mmc/zynq_sdhci.c
> @@ -1168,11 +1168,14 @@ static int arasan_sdhci_probe(struct udevice *dev)
>   	 */
>   	if (IS_ENABLED(CONFIG_ARCH_ZYNQMP) || IS_ENABLED(CONFIG_ARCH_VERSAL)) {
>   		u32 timeout = 1000000;
> +		u32 value;
>   
> -		while (((sdhci_readl(host, SDHCI_PRESENT_STATE) &
> -			 SDHCI_CARD_STATE_STABLE) == 0) && timeout) {
> +		value = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +		while ((value & SDHCI_CARD_PRESENT) &&
> +		       ((value & SDHCI_CARD_STATE_STABLE) == 0) && timeout) {
>   			udelay(1);
>   			timeout--;
> +			value = sdhci_readl(host, SDHCI_PRESENT_STATE);
>   		}
>   		if (!timeout) {
>   			dev_err(dev, "Sdhci card detect state not stable\n");

Venkatesh: Can you please take a look at this?

Thanks,
Michal
