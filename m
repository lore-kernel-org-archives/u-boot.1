Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180A1E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 16:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 765D1801CE;
	Tue, 17 Dec 2024 17:12:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CeuoKA8l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03B2E801FB; Tue, 17 Dec 2024 17:12:48 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A1F180107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 17:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWFnLfIsOUvsqTr/oNon27GdM7Vq+x5wsEXMoDld8FMTehinWpImhI2Aqom+kInPo2vAJP4u3LDl1SM7SZW0u0I//scSZCPHaRHuKGelPfvXK/RdkeF3Nry31U0WB/kOCt1ktRh54MRUJZlRMwWeQ05uPxGAliAoYaGkJDKVgHODQyJHMl+tQl3czfhnBVpln7R452l8rFgiXg4y/FZhs2nDNZrJN81CxtruW7kLPk270gCA7llK8I3YyJD+8KUHberMTO/mDvY5fxO0L2oewGhMZTeAyBq7L5lEkDgLxAr1Xk6qTE8K/gL5sisT22FCAyoZrTK5ApYDaeo+oHTtKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8zXkqqNQBELeO0LpLF78FTHsOmt8VdBejbJ5Yv1fj4=;
 b=V7C4i2jVbbfZkHQ+VBT8kLpKHdKq5gJPlgV5vdRIPdXMI6fRDrrvImNSHHOaFxn4IeI3aJe/ZBoKhYCkTUYiSJJB67Wj0Q7q0MmxygTZSqa2A4F+bpVOkL6Mnb/zTpncf/sWyVAIThvw/CAtwMa4XIfeZcQEH0iRwkYGCdsqcqcyAOiS0WhDGAGRdPgLAzOdjgycQqJ1lOVq4XAY7amQsimy6NZ4oukxUI6CVXVc0g0K7nk1k071XaLS9Z2sYRw2pt/ScewhV8VAOBXMz0LU79fxFGA0zM0XI17i8hQBbNZvQz2nTWbF9/1YDZkVHfM4M4epggCL58/NYd1layaAeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8zXkqqNQBELeO0LpLF78FTHsOmt8VdBejbJ5Yv1fj4=;
 b=CeuoKA8lOMDgQANTij9jHP6VlTCZst+zJvUgAdC6urOHsS6MMAM5a+wHMBI++TlKuPyzs1VtWPXTd1VNeAG2U6ZW0qC5fdkYFiX8x6MfwwWGUdc9q8FKSuWTzU+dEq6w6PanZeOAKo3nDF20PPIpH9oVfbBvDNzAXZ+lISPjPxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by PH7PR12MB8015.namprd12.prod.outlook.com (2603:10b6:510:26a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 16:12:40 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 16:12:40 +0000
Message-ID: <9f7dafec-f150-4bea-b736-f7cfe766940a@amd.com>
Date: Tue, 17 Dec 2024 17:12:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] common: board: Simply array with function pointers
 with CONFIG_IS_ENABLED
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>, Sughosh Ganu <sughosh.ganu@linaro.org>
References: <9786c6124c959ca230dd2c23e8da794680f09867.1733837980.git.michal.simek@amd.com>
 <20241210134808.GB2457179@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241210134808.GB2457179@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::18) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|PH7PR12MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: d54cf4a8-48c5-4319-4835-08dd1eb5a16a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1JPSGxGbnFIT2sydCtjUXBGV1RQdS81TjB1bmxKcktFNVl0dXVOcDU4emxT?=
 =?utf-8?B?MEJHcE1ra21KUUFSV0hiV1h3MUpnTFh4U1dCdXVKREdnb3BZZHRsbkp2c2xL?=
 =?utf-8?B?Zm1RcXE2MzJnK2N3SG0yQ2xkL0JEWXBleGlvbGQ3Yko0MjAzaXRZMUYvSHd4?=
 =?utf-8?B?b0k3QzZJWDFlT1AwcGxPRnVmM25URjZNNnZndC9BaWxJTjBwdEp1WXBDaHNR?=
 =?utf-8?B?aUtzb0pBeHJGYnBUTGErbExnV0cvaXd6bVJsWUxVVThXUExoRnJBdTVMS1k5?=
 =?utf-8?B?VWRzb1F5dUdxZFlBZ3ZwVUlydnViYWpBY3RBU2FhSjRFaEZYSlVaZUIvVzJa?=
 =?utf-8?B?cytCeVVhemc0RG5tVW1BRXNIdmZITVNZT29hc1hNNG51N2xseFFDNnBLRFZ2?=
 =?utf-8?B?c0RNbHk2M0xzRDRPaHhIY0ZWcXZYM0IzTzdFNUp6VEsxUk0xNXB4TFhNZ0VY?=
 =?utf-8?B?UDRYOGRSZGVlbzBPMnkyRnJ5WFRIRkNTL29JSzU5aXYxUUUxbnlGYXQ1T1Y1?=
 =?utf-8?B?bk45ck14MkNNWTZHV3JIUnNiaUdVWGQxUGZWQWRpZzRKV0VzMEhLYlozM1Qv?=
 =?utf-8?B?NU5lanc5RVBrajdrSTBiZ0wwQmdZb3hCVUZnWkdkcm0remU0Y0wvQXBhaGI2?=
 =?utf-8?B?aXdCNTczSDRHeTlHeVNEbnZxQm9YZ0xRWVBnazZSd2FDVjJPcFFoRWUxTXda?=
 =?utf-8?B?c2JXNTU5MGRaUmdJTDJZSmk5Q1BCdGZLV2FiZ0dFWDZnY0c0RzREbzNqRTEw?=
 =?utf-8?B?OHp6VzhNWElsU3A4OS9XNE1RMkM1Z09ZN25STXRUZ254U1NyM0JVWXRYbW1H?=
 =?utf-8?B?Ny9JbkRxNEVzNFV2NCtQZGt6UkNlVXVhQ1p2WDNmOWIvQXJRNE1Ra1loNTBa?=
 =?utf-8?B?UWxZMnpKUzFqb1phZlNLZUI1RGZSQXdNOEIvNXlWcHFoOFpSVWFCaXZvSHVB?=
 =?utf-8?B?NTVsRGJIUHJVcENiaDFrbXV1L3ZiazNueGp1UWNVdUoxbFBlV2NMVkNWZUpz?=
 =?utf-8?B?YkNOVldEQktLaVB1WkF4eUQrS29CeTlMZVRhVHhvSi8xMm8xNVhYbGpjdHRL?=
 =?utf-8?B?MlpNV3FERTBNT0RXVTRFelQ3dTVhNzhnWHZWSEFlMGdhZS8xWE1lZTBIb0Ft?=
 =?utf-8?B?UG1Ud1ZuWGZPOXdYREtOOEsvTzJkT09GL2pwZzFBN00vcHFkY2NGWXRJb25R?=
 =?utf-8?B?S2pZL0RMekFNYjZ1OWE5VWcyMWg0WW1PZzhFRE93ZkxHZ1JoQ0xydUhySnVv?=
 =?utf-8?B?MHBya1VUaWFoRFFialNpNkkwdC9WNWllUGlzM3g0Q0cxTFpNY2MyLy9xS1do?=
 =?utf-8?B?YlNvSERURmtCUGtneUlmbW0zcTJnamcvMzNhQU1QL0tOQjN3dWtNL3hPVEtL?=
 =?utf-8?B?NG84a3I2UE8rTjZqdVc5enM5bnB4WFFWVHFaOXQvdkdRRjdoTzNNb0JNODdM?=
 =?utf-8?B?MWM1N0VoVlVaL25YbEZFR09VKzlWdDFobEx5ckh3WWVjUllFU05WdVRhNHJY?=
 =?utf-8?B?QVVvcEFFYmdlbHNoVW04MHZUUVMxMnE3RDBLZVF5ckpvRjJUYXNXdENWYkxv?=
 =?utf-8?B?cTN1SFJwRUdhM0FtenBZeEJMUkhTcklpZEVlNy9qNERKYTFVWDVtVFVsSnBl?=
 =?utf-8?B?andORVpCRm5ZcVA5bXQxTWxpbDJMOURvYUpQeDF0aGYrWGpPREVJelBsYms4?=
 =?utf-8?B?S3pWMksxdERCMzMvYWgvOWdKUy9wL3FqNnIxNWN1YUZwMUJvN0JsR3BuTU0w?=
 =?utf-8?B?aEFLcWtGcG1uNEdtWnlwU3JVNElJam1iMzNGWWVobmd3dTFkZ2RIOEF2bWxH?=
 =?utf-8?B?TWI5RWp0L29BcnpOSktkdDgrY1FZUnRpK2QrdXlrWk1iWkJrNWo3K0l6MGlO?=
 =?utf-8?Q?fLVdYVK2FIiIT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlhKWFZjeGsyM2RPUlZVYkljN2JiTWVYc1pSdnRBcC9GK3FOUlZQN3B5MHdP?=
 =?utf-8?B?MHZTaXJsdGs1NEhKdlBIdHR3M0VDb0pWQVVLS1lCbzQ3N255cXl1OHFUazJt?=
 =?utf-8?B?Nm1HY1FYL2h4cVZiSDdvQ2U4ZUpaM3dPYklJMWdSWUtDMUU1YWdTZmFGRnpi?=
 =?utf-8?B?RVV2eGhyU3NWMFh4d29GRlRxYldFcnMwN2FyRU0xSW5NYWVhVXRGMlgyNngr?=
 =?utf-8?B?YVZ4VVcreHYyWjQ3Wm8xQUtRYnJzbzBnOUFMNXpLUnBEY2NpTWkyTHZRNXUv?=
 =?utf-8?B?Y0NTYm1VZVg4M09LTHVjK0RGdlNDZ3EwQW00L2Z1bVVKc05oa0ZjeXY2VjJP?=
 =?utf-8?B?NGUrdXU5aStFc3BENFJja1l2K2tXZUdralFBSDQ3NDVBT3hyZGhWNC9Qa3Rk?=
 =?utf-8?B?UW1QTlk5TEJGTmhVUkYreFYvNk1pNXllc09UdGd3Z1Z1T0svTC9FSDA3QlQx?=
 =?utf-8?B?RU0rN2huR3duQXhJSkdIUzdIdDJVZFlJUVFwY3JTM2ZCTlBPeVQ4MHZzZ2tI?=
 =?utf-8?B?VHZrTC9MbnZlK1ZrQUpzaTgyQmhVVGliZ2tKaDgxaFU2R0FacVF5Ly9WRmFW?=
 =?utf-8?B?K3JqWXRtRHZZWTJWTkRWSmc2TFVxMVFnaEt4MjBybEZZU2d6ajVYRzZuY1B2?=
 =?utf-8?B?a3JxSHVwQzQyQy8xcnMwbUdZZC9DSVhGa1Q1SEZtQ2w0THNsUFpSUFZveUkx?=
 =?utf-8?B?WFJ5V2JFTG5vaEF2ZzBJUk1pRDRIZURudDNONFAxNnR4VnhXeVNwL0FDcWgz?=
 =?utf-8?B?MTA4TFBwZjBKOTRQeGNuR0hueGJwVmhaUlo0YzJVbmR2d0pNVXR3SUVJVTVC?=
 =?utf-8?B?ZW5WL1Zuc3hJNU5xOVZBVUN0aVBsTCtMZ1cxOFRmbUlRcFIzckduT0hHSk03?=
 =?utf-8?B?MGxVSnpYWllNT1QzemorcFlMSmNuaHF3ZUlDdXVQWW1yNnpvSm80WjZ1MjZY?=
 =?utf-8?B?RmgzV0c4d3RVdnp5RlRLVUlNakpQdVZmMitpYWRoSkVTUXE4MlBTVWxrLzdF?=
 =?utf-8?B?eTBVWFE1a29ZYlA0V084SGZQdTBvTmRvMzE3dnFLek96VEtZTC92L0xSQWtW?=
 =?utf-8?B?bEdJY3I4QzcxdGplUllQMVEzY2VYaU1qbE9hdERzM2FiU1VmdjNQOTl2Z21o?=
 =?utf-8?B?WmY2bnc5NU9rcDY4WkowQm1vSFRXa3N3RlJxdHRIaUUzMEpGbTBXY1RvODFs?=
 =?utf-8?B?QUp3cVh1cjdvOWs1NGUyaFI3akxZUDVzaGYrbkMrTmo3eXlIYkUyRXd0aVV3?=
 =?utf-8?B?NFRwbWNYU05IK0pwYi9rbGFVMHhpT3BCWjJjbyt6QVROZ2dZczB1dkIzYlJV?=
 =?utf-8?B?anIwUTh1TmsyL0MvREI1NDN5QXpwdFM5U0MzRkZyaGVhWXBpYU1iV3ZkRGhS?=
 =?utf-8?B?OHNmVWU0b0JpeEd5S01zR2Fkb20zSVRhUmdNQmFQVzNwc0ptelAyUmxMT0NT?=
 =?utf-8?B?c09MbDNZdW9qNDRLWGp0US84RWc5VExHR0R5L216QVgyWHp0R0FaNWdCUUxI?=
 =?utf-8?B?NDZZekNSeVFkeTVQWkFaNmlMdzM1RUxLWCtsNUJ5Y0ZIT3YwNFlvSG9vSkVx?=
 =?utf-8?B?Q21KRnJUNFR3SHBKU28vRGU0anladUw1WTdXVE9HaGtabHg0QjQvd3M4dUlk?=
 =?utf-8?B?NkZZTlBrN1gzSDNLdHRXSFV2TERkWVZtNHJxZ1Uyck1MYmladFFHUSsvNE8y?=
 =?utf-8?B?d3VwWklKdkViRG5iS2tmdkhrNSttUjZXd3pNMGs5L2hyeEZPdHZpR20wUVNr?=
 =?utf-8?B?QkZpZFIxazVyejlyNkxtNkd1UmViZG96cUoyYTh0UFdjUWw0bHVRVkwwMkdB?=
 =?utf-8?B?WlJ1dHpxN3VOczN5dGVJNGNLa3JMa2FXSEhqTTE5WTNpSnNJdktFVzlQT21u?=
 =?utf-8?B?Z2FKck5TSU55MDRaeC9GTEVNS1AraUVYaW4weDU3RXVOYmRTYmR4SjhZQjMz?=
 =?utf-8?B?QitMaGIzTTZCckg2bm5aYUtNb0c1TlNyTkhqK2w1dUludjBkbHVOWm83RFZt?=
 =?utf-8?B?WFl1VFI0S0RXck9DcFphYUJ5ZG9LckZVVGtCNDJ1cnArcmw2MjE3am9aWklN?=
 =?utf-8?B?U1hsUURud0RoZHZmQWRTMmdpTUQ4c1pxQVZxYS9sSmc5SWkrdG5UTXZPWGxP?=
 =?utf-8?Q?v0+1FRPOCjCyrZQHzkF18ZMh3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54cf4a8-48c5-4319-4835-08dd1eb5a16a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 16:12:40.4078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNq6dxw42j5jNhkD5ghUrzGhwvnGMT2lU6qvPFNMd2kEz5O+9Km8PbBBTIyHmD87
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8015
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



On 12/10/24 14:48, Tom Rini wrote:
> On Tue, Dec 10, 2024 at 02:39:42PM +0100, Michal Simek wrote:
> 
>> Convert all simple cases where current ifdef is used with using
>> CONFIG_IS_ENABLED.
>> The change doesn't have impact on code size and it is only cleaning up
>> description.
>>
>> Checkpatch is reporting issue:
>> space required after that ',' (ctx:VxB)
>>
>> When space is there another warning is coming up:
>> space prohibited before that close parenthesis ')'
>>
>> but there is no way how to fix it that's why leave it like it is.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> Thanks for doing the cleanup.
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 

This has been included in series from Jerome here.

https://lore.kernel.org/r/cover.1734448827.git.jerome.forissier@linaro.org

Thanks,
Michal
