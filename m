Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59323C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 13:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7BDB8206E;
	Fri,  4 Jul 2025 15:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VWDgqR4z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0904682A8D; Fri,  4 Jul 2025 15:21:24 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 766AC803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 15:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdrXBgGo2iFylArJ40eD358i5O/iAH0N+TsRY7C3J5TSJhmUDQeyNnhU9JM4KqMiTKl/ZrX2VPK3gop9GWkVeq7+S7NCi+p9vjjd7aqRaEUvPaXHg261pRh8MFmHtHWipz6CS7IdTSXv9rFCihKpKXmh1ZAkBorvTdG7uQ3wAhtI1unJQ75f6Y3U5ycJ8GBtibpt6l2JrWJmUUz1QO1T61j1tt7ac6uETKsNRFMc9mGrWTHtxsqtIlzBr09kX2hwWVnwggKSM+ra+bmQVJHRstgWK07XxX57xFmD9bQvJBBlPA/bbjetvn/osJuNyrib/Xv8GDi4YKlFOu1R2UpxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcCprYpnfYSIk3mUFN+W4d6Jy0FEESHQLLevugyAqPE=;
 b=Ps66aihRBjXfz27g9BnFD7h1pIGs4/2JPa/MXkmNVtvHolFUsf4OerBleXlsdUzWq9rixDDBk44B6YUNVENcuuOaB/gik5OcBYIsO3YtAHF2SG99eHwnn7wShJ7C6+yTmJctUm0rrH/fC7Bz5sWYCEl8DuFtvmL3xk0BBezO3IDh8Xo1A8l8pUwEv2aEdNfG6N58iQ7wU+24XbaZ5LBGZYwRHx8kCMQDP+ana1nih6nl3zfAYt+UDE/X5F27sekJLLUqqVfhpdntFPRJjUndvzHwXdFxh9XhpkmdaJ4Hp/CrnXH9Ga5TEgEJVpCvsEJNhfAbhjdAui27B/a9Ep449A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcCprYpnfYSIk3mUFN+W4d6Jy0FEESHQLLevugyAqPE=;
 b=VWDgqR4zrLE0CducXB0yUJj4ekP+UikImxZwoNwP/XTV4jbSsYUf5lthwc0Ty8RNx+ojwX+g+7F6GEJZr9cNiVxZqixE7220IQb/X+EK+9lnsqpmApc8ehjsCEapLIpeMTYfK6kO6h8nTOEvB3NNfe5frqxlSIIlrv/1vjdeD1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB7382.namprd12.prod.outlook.com (2603:10b6:303:222::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Fri, 4 Jul
 2025 13:21:17 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 13:21:17 +0000
Message-ID: <86a735fc-3281-4b43-94ea-a8bc8cf72b0c@amd.com>
Date: Fri, 4 Jul 2025 15:21:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] Improve user feedback in case of FPGA bitstream
 load failure
To: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Cc: vtpieter@gmail.com, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250626093519.115655-1-vtpieter@gmail.com>
 <20250626093519.115655-2-vtpieter@gmail.com>
 <6e88abac-88fd-4b65-abff-bb36c2e7203c@amd.com>
 <0a6df085-d0f6-4274-8f47-2ef291aada32@cern.ch>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <0a6df085-d0f6-4274-8f47-2ef291aada32@cern.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::17) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2ecc0a-80d7-4f7c-1baf-08ddbafda871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFA0MUdHOVdTTGdXb1AzSi9XZzhqdXRUWldZR2dFWnc3dzk5MXFsL1JJc1ht?=
 =?utf-8?B?VjVCYnJKejRmSytjMzkvOWZGL3hNbjZubkRHdEQwVlczR0JrMUllQktJUldZ?=
 =?utf-8?B?ZlEweDlnbmQ2S3hhN1AvVUJuM1ZqK1dLMW1JWncvVUVQYS9yd0d5NDg0UDFX?=
 =?utf-8?B?Q1VtelE0STdZTkR4bnNUblJLeDJlV1ZNUGdzWDdZUzI4WVhsNlptTUZibldk?=
 =?utf-8?B?QUQ5R01XMGEyS1lWS2wwM3cwQVpNNFJ2WFZBeVUyQm9FaTdUVkV3T2ZWd09V?=
 =?utf-8?B?M25GUUdDTnBXYWhtSWZQWDlibE5EQmlyWkpqc1Z2UDBpbndYeVBNVmRya0l2?=
 =?utf-8?B?czdUczg3RFh1NGZrN3pPZDZhN2xLWDN2SXN4azNCUFR6czYxcUFPaWhtUDZm?=
 =?utf-8?B?VEduaURqbGFhcDZpcUVKZDM1VmZmVU4ybDA4aGQxOEZ0SS8rR29KaVc5SlZD?=
 =?utf-8?B?YjVlQnBKVVNHanRFMU5tVkhVb1NhYTYrNUNYeVltKzFPK3pnaVZWVis4NXVJ?=
 =?utf-8?B?Wk96blVPV0Jpb3F6eWdPdXlXc2hYbTJhR2xDaE5ralUwL3Y4T1o5c1lCYVlx?=
 =?utf-8?B?czRTL0NOeFZwNVA5eWNXdWhiY1JNeFNTQ0NtS3czaGdLNjljVWtVamt3MHlo?=
 =?utf-8?B?akVCSnNuNno3MzRsYU82ZWJxNEtiMVBYUWVUdENsNm0xazNkbU5UWXV3THZB?=
 =?utf-8?B?R0Y2RGpHcnBESGREYkRNRE82YXZnU3V5QS8zUCtBeldGSVY1c2VESWZDeXBB?=
 =?utf-8?B?ekljV25RdzRzaEVkVkJvUmNUcVFWRkZzZEJmUHN2QmV1aFlSaEY2MGhsNDN0?=
 =?utf-8?B?ZWtjZmxFcFBSTUM4enNmMlRXT0hMZjZ4bWIzb1BidExSVVFocWpMVlZXNFhL?=
 =?utf-8?B?RHZZYldrTmlpakM3ZHBBd3dDOTZ2YWNwSGRWNnhPN0RNRXJsbkcydFkwUEI3?=
 =?utf-8?B?VWtlU2FXZmd6UXg5U2JHWVY1M2ZLNWtaT3lFT0x1MVlNRk9hRTg2OGpMRkN5?=
 =?utf-8?B?RUV0UW1hZjlHYWk3KzlyK0NmdGNyOUlyN0pTczYzSC9lN01la2FtSi80RUc1?=
 =?utf-8?B?U0xVdmt1b3NCZnFBN2h0YmlDM1VkamhTUHp3dnVmTDdGZERhK1BLUEFDaC9l?=
 =?utf-8?B?bmlnTENTOFVsalJFZ1Q5ZHFGN0tKMUFZdzNwenJpL0VobHlBYlBiWHVGVFBK?=
 =?utf-8?B?dWRqNktHQ2xVeGN2VDdDaldlRkhQQkVFR3BDSm9Gc0N2Rnk5K1IvQkFXZGw1?=
 =?utf-8?B?OUxYaWIzRFFCY2xXK3dEWlg0U0VXOGxBc1ZrTERJR2tnajF3eVNpMWd3Q1dy?=
 =?utf-8?B?NHlWVHRPOTZ6R1J1QjBweDczT2E4SWdJOE8xOE5JYWRqSE5XNVA5OG9iUXFC?=
 =?utf-8?B?MytsZVdFbE9NdkcvVURldC9FNTdzWlErU3JXaXFvTHRSanVFejZ2RHFiOHh6?=
 =?utf-8?B?MGwyenR6RWtySXRqZlhFUGlOalkvNDh3WlgzcmVMVG44cGxScDR3a05HTjY4?=
 =?utf-8?B?TWRIREI4YlVuTTBRclJpL1BxQXRvaXdNdFpjNy8wTlFJL1JvZ0JId3AzcHd2?=
 =?utf-8?B?TDcreXhPVE1NRGtxTEc5M3duRDBzZlA2NkNCK0dWWnMyTG41YkdNdWJCU3hy?=
 =?utf-8?B?ZWNwakE0a3BFbEdrNVIzOU9tamJWT3FwaSs2K2ZoQnk5aGRWQkV3NzByNyt4?=
 =?utf-8?B?UXBMeFRvSTJDU1RkaVZIM2VOeWNaL3J1NjQvWlk2eGF3eGo2QjI5VkV3Nnh6?=
 =?utf-8?B?eDhmQ1R0MWJsVHM3Q05HMVZUbTZBZk5pSVM1T29rNGozcnJjNlRpOUlLWW5S?=
 =?utf-8?B?dkxCWGpxWGZ5bDlGN1ZRbWxVWTZHUlBHcnpOd2hPdERvbUdqMS83UWx4SVZZ?=
 =?utf-8?B?Mk0wWUxyb3RtcTQ1YlZBMEVRNmdmOUJaNzJPMCtqckJrZ1ZhNnYrUXdJZHVm?=
 =?utf-8?Q?5BtlzeOnlAM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU16OENteXlNSmplM0tLUWRMWkt5cjlpK0c0Y1NMY0p0VEJKaWpyUFplU0JR?=
 =?utf-8?B?YytaUVhMVld3MkRRQlBINU96Rk1lcmdoQ0xPd1REQnRPa3c3bENqVWVIWGJT?=
 =?utf-8?B?NndVcE5rNS9LT3BTOXZnZlFTSWZ2eHp4K1BOby9KbGliSzF0ejZaWnFjTVpQ?=
 =?utf-8?B?L0c2N2pQeVYwb3lRTFBSRW13Y1Yza2FhOGZ3bFZXSkRrbWRZdW10eW9hSWxl?=
 =?utf-8?B?eVVTRGVLQ1BOVWZsSi9wL2Y1cVlHY0VlS0IzRjNmWEo0eXA5UmRIRmRBRnI5?=
 =?utf-8?B?UGl3VVdxeTE2anBsN2lmM0JXdHBKdEIray8rbE9tNDlIbjdMVEExOHQvQkor?=
 =?utf-8?B?RHVsaTVaOU04QnNTeHlpSmRXSUtaU05UeG8rYk9RME8yUzd4SzhNSVRRTnVR?=
 =?utf-8?B?d2ZNcHIyYlVCRlJza1ZJQ3pLQXl1d2RvLzdsUU1JcXFuTnprdnhpQW4zSlYz?=
 =?utf-8?B?YzJ4LzdOcml2OWFweXhaMVZoeUh5Nys5MkhxRVdpQ2NER0xIbytob0NQNFdv?=
 =?utf-8?B?R2JKS1YwTE54SnRSakdvRXZEb25BY2xHMFlzMjRtRnhaSUJKanliNCtXb2tD?=
 =?utf-8?B?SklhdktQSHovbnVhY1ZaRkdraGNHQUIvNkZMQk9JMTErR1FMWVliWlJLL1M5?=
 =?utf-8?B?MjZNdThFY1k2bTM0MjFuaTAvd2RuYVA5MkhIODNjMTYvOVZjYUtJcTgyT00r?=
 =?utf-8?B?VEdZcEFEdGl1UHVrUUhmSUxkTSs1bDY4RmV2eW9INzVXSzYxVXFSa1l6ckZp?=
 =?utf-8?B?Y1RnZTM4cm5xSmZFNCsyc3BMU2ovbXZubC84cjBMK01KQ1N2Zk1oME51Wk1t?=
 =?utf-8?B?Zm5Ua0MxZVdQbTJuTmFYNGFZVlVHUjJhdlZBMXhKYTQwcWNkNFpsck04eFA4?=
 =?utf-8?B?dlBtMjFTL0U5a3pjUjNDV2Y1bHVLUzMzdHg4emRKWUZESHpXUTFhWjJGUTlp?=
 =?utf-8?B?NDJralBDUnFwS1UxZW45bGdNeXBlb3pIczdEM3Z1UmMvK1hUM1ZpUzlCb0c2?=
 =?utf-8?B?U0s3MlpZSElkZjdCU3dTd2dCaFo3SXdLdmxuS2RVYThpTmdza0Jlb0pVRWFU?=
 =?utf-8?B?dGlUR3RNekJsazUvSFhma1ppSnMxcVVCZkluYVdPVCs5cUgwNlJZRCtUMUI0?=
 =?utf-8?B?aUZVNUFSdzJ3TDJFaS9ONXJCT1BhNnlieFdDWHIva2dCeWtLNk52TmMxOTdV?=
 =?utf-8?B?NSt5MmxrQmJLWitVVFhoZFByaFIvM2lEVGdMNnU2L3JZT3c2dUlRd2FzRnZ0?=
 =?utf-8?B?UThnS25lMTFoUit3NzMvbTJFcGlZcEtVM25iQlpHb2piMHpYZmFzNUUxZGF4?=
 =?utf-8?B?TWNXSVo2WitTZWZodGhEU2diTFVSODBKY0pjSFZYWXhSeG9DRGdaUVFMOUF4?=
 =?utf-8?B?aCtsYmx4SGRuYUxLbXRjSXRxOWxOYmJSM09SaTdnNkJZZHE4SHpTZitVYzFx?=
 =?utf-8?B?dGl3SDhkN3h0Ynd6ZHFZQWgwNFVSTXhoY09xRktlS21zajVtMW4yRDdXQW1D?=
 =?utf-8?B?bVRveE11cHV3Nk1LV1JzbWlCYWprUjZKR3kwVVE5RGl1djIwdTJrRDlNSzRQ?=
 =?utf-8?B?b3c4OEoyd1lqd21FcjMxTzgxSGhTRFhhRDErN0hnbTR2aXFxbGdIWXpmV1U3?=
 =?utf-8?B?dm5pYkgwaDVPSTZUUjcydTgwclR5WkFlYW00cUhqZzlpejUwaU9ocFkwRzZL?=
 =?utf-8?B?dU9SWDZhbTFtMldIZ0Y4WmlFV01oaWYvcXNobSt2UTlwYlhTdm16QjRpK0Ns?=
 =?utf-8?B?SUVLNDA3aldvbUNjS0hpeTVGWEtFdFhibllDcitTbnpabmFBMFpCZUhWLytY?=
 =?utf-8?B?aXl3UktvL2hNTFEreUxFZjFZdWc2ZHdIWVJLejFzUHE4WC9SNEREaExuSjR2?=
 =?utf-8?B?YkpUZzh5SHJwSWhxa1RKWXUrUjZDcUpkZXlNTkUybzR0T01Eek42b0ppMFFv?=
 =?utf-8?B?NHVOZ1k1RXFvZ2IvZjU1VkRqeHpUMlZrYVFxZ1FRd2U3eXZ2WG1FUittelYw?=
 =?utf-8?B?WDBWYnpMZ2xoamRvN0NPczgvUWVOL3V0ZURmOEFiSTA2enV4YUkzTllOOEMw?=
 =?utf-8?B?RDlvZU5oLzdVNHVJUlNLMGVQS3pPVEtNSm9nV3UrQWxGUWY1SThkQitTQWRp?=
 =?utf-8?Q?TLSyF76qd1ta4/vZ0M09H8JXl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2ecc0a-80d7-4f7c-1baf-08ddbafda871
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 13:21:17.4675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEsVfc7r0HSNndsGDpSqJTcPcpsKua976oXBQO4GO7aBMaCTAO4knKYyq8I9l0z5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7382
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



On 7/4/25 14:38, Pieter Van Trappen wrote:
> On 02/07/2025 10:51, Michal Simek wrote:
>> On 6/26/25 11:35, vtpieter@gmail.com wrote:
>>> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
>>>
>>> In cmd/fpga.c, change some `debug` calls to `log_err` for important
>>> user feedback and use CMD_RET_FAILURE in favor of CMD_RET_USAGE due to
>>> its long output which hides the actual, useful return message. Change
>>> the remaining `debug` calls to `log_debug`. Remove all 'fpga:' and
>>> __func__ strings as `log_*` has this covered.
>>>
>>> For `do_fpga_loads`, move up the `do_fpga_check_params` call for more
>>> consistent command output; use a constant instead of multiple '5' use.
>>>
>>> In drivers/fpga/zynq*.c, change 'up to' to 'above' which corrects this
>>> confusing/wrong statement.
>>>
>>> Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
>>> ---
>>>   cmd/fpga.c              | 99 +++++++++++++++++++++--------------------
>>>   drivers/fpga/zynqmppl.c |  4 +-
>>>   drivers/fpga/zynqpl.c   |  4 +-
>>>   3 files changed, 54 insertions(+), 53 deletions(-)
>>
>> I would be the best if you can create also cover letter.
>> But let me reply to this patch but issue is likely related to others. I am 
>> also not in CC on 3/4.
> 
> Hi Michal, well there's a cover letter (v3 0/4) but it's only been sent to the 
> mailing list cause for the actual patches I use the get_maintainer.pl script 
> (only). Probably also the reason why the 3/4 patch, amending the 
> sandbox_defconfig, didn't reach you. I'll make sure all v4 patches are sent to you.
> 
>> Anyway CI is failing with
>> $ tools/buildman/buildman -o ${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e -- board 
>> ${TEST_PY_BD} ${OVERRIDE}
>> Building current source for 1 boards (1 thread, 64 jobs per thread)
>>     sandbox:  +   sandbox
>> +drivers/fpga/fpga.c:23:13: error: ‘fpga_no_sup’ defined but not used [- 
>> Werror=unused-function]
>> +   23 | static void fpga_no_sup(char *fn, char *msg)
>> +      |             ^~~~~~~~~~~
>> +cc1: all warnings being treated as errors
>> +make[3]: *** [scripts/Makefile.build:249: drivers/fpga/fpga.o] Error 1
>> +make[2]: *** [scripts/Makefile.build:388: drivers/fpga] Error 2
>> +make[1]: *** [Makefile:1930: drivers] Error 2
>>
>> which should be fixed.
> 
> OK I can fix this. Where does this CI job run? Also do you know if there a 
> reason why not all -Werror options are on by default in the Makefile 
> (KBUILD_CFLAGS) while they are on for the CI?

As far as I know we have two pipelines. One in Azure and another via gitlab.
I do use gitlab one as the part of source.denx.de.

I can't see any platform which has WERROR enabled by default.

M

  30 config WERROR
  31         bool "Compile U-Boot with warnings as errors"
  32         help
  33           A U-Boot build should not cause any compiler warnings, and this
  34           enables the '-Werror' flag to enforce that rule.
  35
  36           However, if you have a new (or very old) compiler or linker with odd
  37           and unusual warnings, or you have some architecture with problems,
  38           you may need to disable this config option in order to
  39           successfully build U-Boot.

