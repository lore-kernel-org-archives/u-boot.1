Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E476CD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 10:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF6A588600;
	Mon,  2 Sep 2024 12:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xN2cwnx2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C239588717; Mon,  2 Sep 2024 12:54:37 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66E7C885F2
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 12:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8kyWQpgejIDtnAFOzT2v/k1Gcc0EadWi9boXOuntK5whnlvpVvfSQncWsUGExwzEUGDP6jEFRf7sTTPCWnYwxjhG9FkQPKxm+ZIyg4/B8xfEmXwFO3tcUToTB/nounn74El23oJglGsjwSa2u/MsPzEUv/4YKVPfOOGW6kKAoIB1Jd2iWlt1TQstgOwJhh+PCfcsnPejsvED1rsEytzW9s2IFDey1v4GHi+qvMNryKvggvU+kgMkBKBaabhinR6XtyqKy2CMK5BoFwq2NwPfpR2B8+B0gPH5sdKzrjSIeLJo1I72fVvzjgeB3BFwljF/idZmR3BfljPT8mG+5mO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmsYRzVrNCrOvrMZedKsuUcBzcDlrCaJU7A8UaQDbmg=;
 b=qYDK7vl75RU4NVQTudkelaRtmKY9jwks3x3YuOKDJU6GmVmizN4mbmkCh939zjC6GcRxIcOsxHK9hxu/TR+oskwW6/4UONVKD8MExd7JjCL7vG3F9YPihu8Th4HpNaoDL03CT/qT1JJfAoty1p/NxI5BhsKsRbrGMWMQUqJVHI/o1xt07EURCpFRSRPKITq0CQn33EgbQvPsEM+n5eMAE4Rwur1yRH0a1rWYBd6u0d2iT1fG5K0dyFaQenFZPw+Cx144KswkFcay/meXyKD4nl5dhiCELlMhah/8zOIYZaoaJhXad97gTpvdpzyKpsk16jR7/SxZ97UecVPCzwjkjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmsYRzVrNCrOvrMZedKsuUcBzcDlrCaJU7A8UaQDbmg=;
 b=xN2cwnx2t8eiu62W7rwmJXoLvBVGt4C4fvV3Pb+GwRXgOkbplH2JGbpcvajZlvX9bD+7VTnIHt242fyYyFB1Qme5viq3Fe6OD1k6ss0K//1xrQuSZMdRSkHqZJalrinGz+agYsX+SVXlWeRNksxUGo2i7J3gnoYC/Z7ntiNLHLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 10:54:32 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 10:54:31 +0000
Message-ID: <5fe8e236-ddea-479b-bb0a-deedcbd0a6bd@amd.com>
Date: Mon, 2 Sep 2024 12:54:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] versal2: Update the sys prompt name
To: Love Kumar <love.kumar@amd.com>, u-boot@lists.denx.de
Cc: git@xilinx.com
References: <ffe76860e1a67728e27ff904a6f7639a771fddd4.1723179877.git.love.kumar@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <ffe76860e1a67728e27ff904a6f7639a771fddd4.1723179877.git.love.kumar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0034.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::23) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 4678f877-9fea-4c4f-1a29-08dccb3d9f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWx2Yzl6UGRTVTk1UWtDVG1zQXd0dUZDZzBDQlZIbUVlQzBTUjNlcW1JanBN?=
 =?utf-8?B?R2k1bTVoRUdPU2QzdnppWWswT0R6alJGWGFXUGFGUWJpZW5Vb3NUd2NmT1hD?=
 =?utf-8?B?WHBpQ040NDBabUhtS21vSzJRSTk1MHQxVWpWYzdYUDVxY29XR1ExOGdqNVVU?=
 =?utf-8?B?NnBudHgxNHgyaDhieVZhV1RkTU1TT2doOHAvRmVPOUNIMTFvb20xdDNxSmRK?=
 =?utf-8?B?aTR6bHMvL1JOeS9xeFRZLzhhS29MdVdkSGZqeWFOdDA1UXpLKzMvYW9JbFNS?=
 =?utf-8?B?c041KzZwdFVQMUZXMEpYRHNjcE54T2xHNFFXaGZENGRyZ0w1NFdrdGpaUWVP?=
 =?utf-8?B?YlRFYy81bm54bXN3Tk9BUXhseVVLQ0J4aHQ0ZXl6Z29vWDhLTGFneGJCRHRD?=
 =?utf-8?B?RTBIU0twQ2h6RVAzenlESG93UnlyZDZjdzV3RWdxeFJSV0pQdFNPTGN0d1Rt?=
 =?utf-8?B?ZnRUMTdkZGFDTlhBSDYvd2pzYzRDVkZoRm1uWnQ2ODNkalJLWnJEbzVTMzZ1?=
 =?utf-8?B?SUF0aHdGNHR2d0cxYnFnZitpR1o4N2xRZVQxZlVnRUcrQ1RneThaUGJxaFlV?=
 =?utf-8?B?WDFRenBieTIwZlgzR05oZlR0MHEwVjkvN2VjT2g4WDJCV0ltQWFtcm42by9M?=
 =?utf-8?B?SC8wMWxHdkxSYS9VRDRTZWFxa2QwaEZxYmRidG1VY3lNQ3FtU1l3dDRxbWxI?=
 =?utf-8?B?YWNvcHlZUHVxSlAvUUlvdkdNYlp4TnBra0RhSzNzb011TWlkdi9USzdWU0cv?=
 =?utf-8?B?bWdWWHYzWDJ2b3ZZeHl0VWZ5aDJNcnhFRmlXa1VFNURsRnU2Skk3SmRiM2xU?=
 =?utf-8?B?cVN3SGxuWHB6VnM0d0xJalkyQk1tenNOdXFiZFYreWVFL3ZDV0UxSkZYdUxV?=
 =?utf-8?B?Njg5MHA2Zmp4eDhKd3pTQzNKRytCcEZ6VUgvMWhyRElPOGpHbGJicUVVQWs5?=
 =?utf-8?B?UEdLRWl0MFF3aGsvOGNSbjRTOHB4QVJ1RFQvNVlKakRka1dZWVQ1aHZwSmhv?=
 =?utf-8?B?MWx3VnZxa3d2ZkcvZXgxcXZMUmplOVk3UHVKVStheXZocFVjMXZsWjdBNkhR?=
 =?utf-8?B?Skt2L3RvenhYNTZNbFpabmswaXNaVVJlT3VMMlpXUytCeHZUQVhCdjdZbG5V?=
 =?utf-8?B?aGxFZXZ3K3lUOCt6SVhOVm9ySjlxamo5SG92aC9yZkFVczJUNmE1RnJVT3VU?=
 =?utf-8?B?YVp3aXpIZWNRMThLSFp3WkEwNGhQNFg0NWFXYnRnU0JpUS9mQkM1WkU1a3F6?=
 =?utf-8?B?WWtlRmdHd042SzQvL3pYbWNoOTM3Vlp1OXBGbjlCb1plK3JGL2w3RjBRRm9i?=
 =?utf-8?B?ZlBpRERBTXRaWnpTOUgwY3RkZjNRVWlQM3h2Y2JzQzdWLzdEK082NmdsdEtN?=
 =?utf-8?B?N1RBSHcrSHpQZVdxRWxOUmR0Vmdwa0xLMzJZY05jenhYV2tXdnFNMkJkQ2hw?=
 =?utf-8?B?RTZaVkVCZzBwcE1zTGFrbWlpa0F5bG80WGErbllhNGVNQW1uQVZXMDhkOXpv?=
 =?utf-8?B?VUhoTytJWEh5NHRvdTdxdE04eHA0SzBBb01ubVRLTWd0OVl0L1hybm93Q2ky?=
 =?utf-8?B?elJtTzVCbHpFcHA1QzdQbEpZak5MWW9HUFIrcXZQbDRPZ0hVWmtHTU9UT1F6?=
 =?utf-8?B?U3p6RDUwdTd0a2xmWmZQUmFRSlZycnRpRUpERzdkR2FtWTFPQlBRTThzczJR?=
 =?utf-8?B?Q1ROc0ZuLy92M3hhWFJtRzh6QkFHT0NXZDE0WHVBY3k0c1htV21TQ1JNZWZs?=
 =?utf-8?B?Y25CYmt5NVpzWlpoM2Jlb0xPek42WlFlMzFyOVRyVHltM0Z0dXNGWEVwL2R1?=
 =?utf-8?B?YW5ab2hZbm5OMGRYZnMrdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkxvZ3JRalpiZnMrWktDdkJSOUNCS0R6REg4VzRvenFBQXY1eGUvNEFzSSt1?=
 =?utf-8?B?OGJTRDJUMjJmTklNanVnaVl3UFFNSUk1RVBaelBjeFlZQ3YwQXg0M2NicEov?=
 =?utf-8?B?L0RuakMwRjR0dTRRWWQzZDVma2Z5VStjWDNrM0hmMlNwVk44ekNBQU9mM25w?=
 =?utf-8?B?ci9EeTh2aXJURTJSNDNTdGVKckRKZzVZN1hHbjZkaVE3a3U4UEE0WW1rMFhX?=
 =?utf-8?B?V3h3a1gyQnJzU0hOaGg0aU5CaUd1QmxKOTJKUVlVZEJaRk1UK1pxUUxHS1Zx?=
 =?utf-8?B?akhzZ2ZOZUdrMVU5eHpYcVhtMS9qcU5xd3B2Y1VnV0VVTEFsSkRkN1NGWWth?=
 =?utf-8?B?U08xNllyd1JYVGpFWUlNc3RVcE1xQjR0RnY5OEtscXhPTzBWb2tzMS9Cc0RH?=
 =?utf-8?B?L3NYZW9TcG43cEM3SWp6Zm5SMjV2NGhtR0tidkNDRldsTWd2VkozNEwySjI0?=
 =?utf-8?B?aWhLcEx2Q3J5STdJeTU5dlhxeG9xT2w0bVYvaitvWWNCd1ZiRXpTaDliUXo5?=
 =?utf-8?B?V0ZLSkhtZldqUDZVU0pIMVAwNUxyVzk0d2NiUHV0b3hVV3JobUwzVytSQm10?=
 =?utf-8?B?WlFaU0cyczY5SlVHUkNWd3RRcDdtOExuYUtWbHNFSnR4SjJLci9za1MzdDcx?=
 =?utf-8?B?WDRmT1JPZ25ad0hIVmw2c2dpMWxPeXJSSG9kRUFzYnFxaGZJWlJjbVZLSnVC?=
 =?utf-8?B?RzVoMFhGYzNqSnhCTHRpZ0RpN05vMG9VVXQxeUF2VDVablUyY2Z4Sm8wOWdP?=
 =?utf-8?B?Qm55clRtRW9kcnVzL2krcTdMVnM4Z0I4bmJOSUNkMXhIMXF4TU9NOXozQk4w?=
 =?utf-8?B?bkF1L0E4SlNIaTYyVVBCSGtUT0hqVUhNZ2F2aldZb3VON0cwekpOdXgyZ1pV?=
 =?utf-8?B?RVVMbVZ5MkdDSXBtUGFoSnlUaUJsYWRxUXdCb1dGYjIvd3BLZFFqdENCVUZv?=
 =?utf-8?B?ZkU0OGRrYlgzUHBLSmJUWm1qUEpqVDh1T1o5UTFiZzIzNzl2elBIQzRNUUF2?=
 =?utf-8?B?Vk94Skh1RFVhYjc2dkRPa3pVZS8vZENvbWp1b2s4NDBLMjJzblh1bzJndGRI?=
 =?utf-8?B?eXViU1pSZXJ2c0xBQ1pPczNZYzhwbkpvR3ZqSkZPbXNSTzcwUGpXSlcvY295?=
 =?utf-8?B?dWxUY2ZoeEdpd2pmV3ZkYXpBKzBLZS94QTF0VWdjWHpSZ1VmU2c4ZjdaeG1l?=
 =?utf-8?B?ekJOcExodDJkQVRoWWNzdDlVWm80U0MzS3Zqd3FlYTRVek9jamR6Uit3Z2hm?=
 =?utf-8?B?U0d4d0haLzRSOFV6ejdCTVpPMlBpcnFLRG51blV3WTN2WE95RTkxTXUzblpG?=
 =?utf-8?B?eGNyYy85c3Z6V3ZvUmVGNmcxWkhITU5aM1c0THFaOFlqL3VsT3Z2VWY0b0c4?=
 =?utf-8?B?blExdU9ENVZIUktkdkJjMTl5WG1SbXFaWTFIbUFsS1BRVnNsZ2ttVmZFMlgr?=
 =?utf-8?B?VzJpWUU5ZENDR1VhZFpGVThXWUYyTkd4aWx4b3RQZEVFYVk2c0E1UGM1U1Zx?=
 =?utf-8?B?UFpiWkU1elFvWWx5WDd5aER2cXE3bzN2K0ttMWZqenZGTkU4R3AvQWtiMVg5?=
 =?utf-8?B?RUh4N2Q2dklOUmNRRzJnTE9NczNkK1JESGs4cGlxL1d2ZHBBRW92V2l4S0Rz?=
 =?utf-8?B?dVhGWTVZWlM2TEZJaUdtM09sV2hsOGxMSCtRRnZwaXJBNGdJd3JDU0czQWFt?=
 =?utf-8?B?R012cUlsVmF4NTBvZTBiM09xcHhGa2NKdjAwcExVdHdwZS9GNTFaem5JSEcw?=
 =?utf-8?B?MUdqaTVpTXFUSmQrZlpaUis2TlRuK1dxdDN0SU9sczc5RUJ2Yk5KL0VVY2FP?=
 =?utf-8?B?UEp3OE11RjdCVGxnTEhuYUVXek41cHQ1cFpXSFh6WVB1ZmRSNGN0cWplNm50?=
 =?utf-8?B?Y09CWXJvNmFrMjg5WlZxSW9XVDVwRmxCaGJJQkEydCtnVnFhZjdYbEJCYzVt?=
 =?utf-8?B?UmJiaXFLdE1QOUpmczdkZ0ttdWR1Y1Y0WFFvYlVMRGF4aTcrQm1zdFRKMnln?=
 =?utf-8?B?eUJyVjN0ekIzbFJVNzRreFhvRmJXMHI5U1k4dFZXVG01SmRqaGVCUERrU2Yy?=
 =?utf-8?B?NUM3cmp3ZTZUcGNJNXBIUWNYVzRXZUd0QitGMkozNnRLYWdpdWNCZGNWQkIv?=
 =?utf-8?Q?MjudsRq7qW9yrNRegDe2Uofeg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4678f877-9fea-4c4f-1a29-08dccb3d9f8f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:54:31.2492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hai4JljxgfcRdhqbp5LjY/0riIFEn+8CEsmzwUdtwu0LyRIA7x3SxfwDfUv9gZlu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914
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



On 8/9/24 07:05, Love Kumar wrote:
> versal2 refers as "Versal Gen 2" as a generic approved name so using
> the same as u-boot prompt name for all versal2 defconfig

We have discussed this together and using different word than versal2 is not 
productive. That's why keep only versal2 is enough.

Thanks,
Michal
