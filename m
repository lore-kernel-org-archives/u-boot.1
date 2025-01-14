Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21860C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 07:29:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F17C80619;
	Tue, 14 Jan 2025 08:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F7Tsc79Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57395806C9; Tue, 14 Jan 2025 08:28:59 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 038268007D
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 08:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUdQOkuqIgIIyQUUvXjqs7UDWMailDhhHokSeG6NjEQRGC4Tim4Jx/D39Y6rEvJTOcNyKT//W/5EqtfxqdHpwP8WobDSQ0TnXgHvUIBpFWaFAy82CcdjqB531/9qmw+ZWJOLQT9PYnZNdhrz9l/O0bXqIgHa7xSvp8QojkyQevcvTmv4HlaTTrI3pmdT39VJQV5h7i3UxQsvpzDP1WhHaTHQc3I5yMsIhgbb+L8rhLdsdPlTX0vmvia1HXF3Au3EoHPhA07syJeA6xKBp+8YYeshwyLkglxvEgNxojaFbi3gr++WQDmAjomAT05lVwg6vsnXp6uyHSTETiAlA9qvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hf8iciz4Bpjy8meIBcncc1VoVczljJQB7BeoL9d5a7A=;
 b=BMHSqtx1Fuauoj8+ukfNjk9wyh81BHBAaZN5sfvAMtyCMIh1z+WQ1XYyscVHZMLxh0OG83cHggFvcS59zsDRsQo7q7c1BzjfcbY/ffEzJTsaOT/C2wAnKSLEyinSlO32Syb9kAE4PA7pgW5TE2DbD5IwxZsCTOWGu5Toi1Y7DqkE6jON0VbZVX3vEiqPoijl8EffXG3DeDn39joG/a2kdIMWOC9lrRfNY7SQzCIp1VoVG/omMYnSa1y38iMb2JsrVaOrTjcYFqNcIooeOeRc9ss9C6i4HFwgCT5Lww12TzN7BlOjh5gL4S9rw/b2yUWBP2IJ/2Wr74ITXRVv8B0gQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hf8iciz4Bpjy8meIBcncc1VoVczljJQB7BeoL9d5a7A=;
 b=F7Tsc79ZqG7nYUaJ1AYdw9VUf57cTA3yNxNlooTdD8YHxjKCzF00MxwE3eiBs93GOl9GOaeT3Xf1qrMAt2hOQsYqNIxktEbhEXPnW/9Pmhbw0VtZIJtzqnNCMqbrV0pkrEl/420d08y+2megYtJ1YnYPGzbNvLAowzo8+pqRagE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 07:28:52 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 07:28:52 +0000
Message-ID: <2399e73e-139f-4f2d-808b-567833b4f42d@amd.com>
Date: Tue, 14 Jan 2025 08:28:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: xilinx: Add missing prototype for
 set_dfu_alt_info
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20250106090630.209938-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250106090630.209938-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0293.eurprd07.prod.outlook.com
 (2603:10a6:800:130::21) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: 9265e812-b302-413d-b4e6-08dd346d18a3
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEFKWWNhejRoTENWSXcyM3lPdFBBcmhxUjc1VGVDalR1ZFI1Yi9iU2tsYVBV?=
 =?utf-8?B?VnphaTdReW5YcFpLWlVlRzhDcWhlYjN3cCtNR3lsNUZJZnRmRmZuSW5odG9Y?=
 =?utf-8?B?MDgyQXNEaXBFM0xJWEdtOFlZa3lxeU00aG5vNTNUWVQvUzFQSEZsZy9sck1L?=
 =?utf-8?B?eVd3Smt4YStkZyt6Q1BlZ1JzL1dQMi92Q0VNNU1peDJNdlE5S2Y5VVR5Mjkw?=
 =?utf-8?B?ZExPOHdTbWRHVzEzV0c5eGNvUVMyb2w2UXZROUpGM0hvM1lSSUNvV0xPNEM1?=
 =?utf-8?B?MVpuTzBTYm40eTZBOE05bG9iM3R3QXVuQ2swSklyaTFJMXU3bWRWMW0xODgz?=
 =?utf-8?B?LzlSenpMdW53ZVpZVURvMmJoSlN5OXdTTjBTcHhydlBRM1BQMVk3ci80STh4?=
 =?utf-8?B?NTRZcVEwZkVYeDZzYytwOEtKb3dqMytORGZER1RtblgyR09zM254dVZHZkRM?=
 =?utf-8?B?SFRVMC9kV2xLNWlnb24rQVJVRTFCMnZ4aEJwMDI1dTkybG5Uams1K1VyQ0Rh?=
 =?utf-8?B?aDVoeDhMQmRyYzdQdU5ISEJ5Q0NKYUVmakxQcEowMjdYa0JETTlvMTJCTDZn?=
 =?utf-8?B?c2d2M2hUTGFJdzRFUFpIdER2TGpsdllseVB0TWFvQ2pUK2dIb0E5RTlPdXU0?=
 =?utf-8?B?aSt3MmdGWURjdFYybHE4c3YxZUlTK1MxbGVHSU1HZGFEaG9zM3ZpcFVDQ1Vp?=
 =?utf-8?B?eGRFQVVPbVE0cjg2Y3VNS0Z1TWJOVW1nMDYzNm91bndicnI5MUFoUkNuenBZ?=
 =?utf-8?B?QXVlZDR1L2lYZXRES2Q4YnRHd0R3ODJYZ2xkd3gxS1BMc1FoUUdWa0d4bHBF?=
 =?utf-8?B?dHREY0dXNzk0Sk9MOGxYWEMxUnNuODZGTnlvS2NHbUNQTnI0eXA0RzY4T1pS?=
 =?utf-8?B?ak1lSHpJeWZMTnl0cVY0Yk9hT0NwdWJRb1ZXWEdFRXhibG44YXN1ZU1Eb2wv?=
 =?utf-8?B?ZzJMMVZwaXZ1SjVLaVJQMWk5WWNTQXpOT0xNQWYxL3NFVjV4cGhZUmF5VTc0?=
 =?utf-8?B?aXZGdllQQXY0dWZ1dXRTWWp5cnZFN05nSm9XKzdxYmxJTUlWR2d0SWt2dzhI?=
 =?utf-8?B?NWs5RVhlUkRJN2djZFc5RUdrYzFERXBuT1ZiYmV0TjZXQnBONlNYZHlqdGRq?=
 =?utf-8?B?MEtUTzZaa0VEL1J6VHBKV25FV0l2am5taEt1ZWJMbUJpUlA2bStad1ZVQkMz?=
 =?utf-8?B?NGY1RnpOZm9VazFFcjMwQzN6elRrUlo4WWVQRWJuTHdZN0c1b3hueFRheWFI?=
 =?utf-8?B?MVJwckRmZ1lReXRldUowV1JsdGQweEpadXdBSDNkbmlXTWdPaVdEclRoUkRq?=
 =?utf-8?B?alUxWXZac243djhnbVkrRlpyV0ZUS3ZKdjI1cGhKSkVIMkxzd3JMNTE5V0hx?=
 =?utf-8?B?aDN0Y0hhRzRUcEM1MGNkL3pmeEgvS0FpMzRpQlFOakc3WkpsbHRTU1VLM21i?=
 =?utf-8?B?UU9PQTUxV1VUY29EYmN2cXFQc25SdVdudWptQ2xlYkVidllabG0rM0pCVytD?=
 =?utf-8?B?NUlmRzN1aGQ1V2FWNHMzajJIdWtBcHUzVmFacXMvNGVZTUJ6a3hmU0ZzeW4v?=
 =?utf-8?B?UVlLc0JEN1dyRWkxL0hDNG1raU9malp6NFlqaXpIczZsSXA1b2lkc2NxWXNQ?=
 =?utf-8?B?OXpsVFhtRmozRVZmRFYvbytmVXdqVW1ocHhieHQ5c1gvZzdzTERtQWxjY2Jn?=
 =?utf-8?B?SzJLZi9sOHpLakRRT1dRTEZ6eUVLNGMwZjNvdzhhZFBscHRXS0h3ZmtvQ1Zq?=
 =?utf-8?B?a1BmanBSNGVJZmJ6c3RNMVNyMzVMRUpqT0J0OUloUkNjVDYxblpkQnhBc091?=
 =?utf-8?B?Zm11WmZxeFk2REw5eW8zQ2Q4ZUxjRzFjREpoZHQ4cnZCWi92MmJadEZ6YVZv?=
 =?utf-8?Q?PbRqUXj/mv5fS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1FXT1NiUlVqYmJqZmJZYmZVd1RJVk5tNmgzK2NPQlpsRTllbEJtVWJQck01?=
 =?utf-8?B?V1JpMDR2d1RFTDc1VDl5amswalBhWDYwY1RFak0vcFNSTE1TaWZjTHpBb1VR?=
 =?utf-8?B?enNFclJXT0E4ZTJ6NUFJcnBYOEZnU2hqM2RzMHplSlRjZThmUVA5NjNESFQ5?=
 =?utf-8?B?ekFmSGRBeEFoZUpUUjUzeUpXWE5hNGswYncwY3dKUnV3ekhMYkt3dkFHd2g1?=
 =?utf-8?B?SWhWYnhPSjRhRnp2bUVuSVhmMVRNbzZINTdwSENZZENSbjFnQjhkVHJJMGZE?=
 =?utf-8?B?RGJaNy9JcUc3ei9mek5iWklHa1hPOFl6QVo4VTA1dVZETVR5S09hWmpVbE5X?=
 =?utf-8?B?VTVKRWJyODllWGlpbXVOenBOeXZXdGI3ZW1qY3NpQ1Bic3JSMW9nVk1NQ2Ew?=
 =?utf-8?B?OEtlWnA5bStwYXdjc1dTb3YxdWlnZHpUcnd2UC9tMG1hbXNaWmdxY1BhN2x6?=
 =?utf-8?B?UlZlcHpqNHh4K21JWXRVTkpTK1A3YTB6TStZdTdTeHlISjdrUWhYZ0lqd0hU?=
 =?utf-8?B?RngxTU1ZSW1Ga2NOR3RXV1F0aThjVEIrazFlZCt3Y2VNMExIL3dmTEI1aFpR?=
 =?utf-8?B?eitFWm9uZVhjNUJwUGtTaGdFSFF3MDAybEFaNldPZkR1c1QvVDhDa0laSFFW?=
 =?utf-8?B?Y3p1b2h1STZTMXRWVkVCbWo1Ym9XbDZiSWRadVR6YnFtZ0krS1ZzMGVnZjlv?=
 =?utf-8?B?ckRrNUw2NW9XYzNjTUc1YWVGcHBZL0NMZHhJeGlIeVRvVzJwOVVhVk5LclNJ?=
 =?utf-8?B?eTU4NTZQTzVIaUlDQ2FGVTBkUHFzTlY0c3dPQ2s2SlJOZ1ROWW0zVEJuNXBw?=
 =?utf-8?B?Vmk5M01jdHNCMWZFZFVuOTg1VFNHQnlzTGxjNUtMcS84aXZ5N1dmb1dBbURJ?=
 =?utf-8?B?QjlGN2Z5cU1NWjZYOUdXK1A5c3liclFqQlowbkZUSjFMbEhJdk10Z3pOUkVO?=
 =?utf-8?B?alZUejBWbEs3dStjTFZoQWhlN3dtampTamdxWEFoczVqbll1NzR5NEc1M2ls?=
 =?utf-8?B?a3RXSUFteFprRzVxMExhWVU2dENaOStHRE1sTVZlUVdaV3hjeGhTT21uU1JD?=
 =?utf-8?B?QkQ1Q2dkWDk4U1pZYXBFYmJQMmU2Yms4c0MzREovVlE0bkd1dFVua0lscnJy?=
 =?utf-8?B?a0J4Sm5ham41c0dWd20rNmtibGJBeThkQmJSQjNPNWF6ZE1BY05sSFFBK0ZL?=
 =?utf-8?B?R2VGWlMwMHhTa2h1YXcvakNEMFJFdEQ3WEw4MFptM0FrNlB5VytJVGx4cUw0?=
 =?utf-8?B?eTEraENXM2JOdDlQSk9zb2t6dnZsUTdoWkQxMjFYeENuQ2daRFhIb1BUNy9L?=
 =?utf-8?B?RVRzb1hudFFxbEgrRTAxYnNLbTVJSTg5KzBjbXFBZ1dXZGM1STZtVUdreFlQ?=
 =?utf-8?B?MXpzRkpLSTNSVHY1Szc2aWF5U0N0cGdzWXZ1ODVPQ2ZoZ1ZFeDE1WThqUjFk?=
 =?utf-8?B?VlB1ci9vcHFoenF4RUV2R0RIRmUvL0cybVl0S0RTUng0aW10OXVWVnJKUXFt?=
 =?utf-8?B?Y3RVWkF3dnVGQTV3OGZqQjVoTXNSTndUT2lBSGpzNFA0UVc1TTdUUHJpUG5v?=
 =?utf-8?B?VkYxZzROcFYxeDJRdndQMjJQYXI5Um5uVnc4cWxha01QcUN1SEJxZ3k1T3Ax?=
 =?utf-8?B?TXRpNzVnUlZ4RWJVSXREUmVzaGRSUVBHZVVLZU5WeGpkWjUvRXJiZ2JUOGND?=
 =?utf-8?B?WmpVZGJ1NWtFcnpGaHlmNzcxQ1M4Q0hNSGdWWEczK2Z3SFBUU2piUlpycFN3?=
 =?utf-8?B?d3FhZ1lISEZmZS9pdFJ3Y2JHRGNUekNqdDNSNkdvS25UY0lYclFZSzdQck5w?=
 =?utf-8?B?T2RHaGgrWUhxamVIb1FVZzAwWDVaQTFwUWpQc2FiV3N1bStBZnk3bjZkQ3lN?=
 =?utf-8?B?QXFrVE9qM28xUytTYkdtZUtOVXhEWXBETjZ4bFV0Z1ZpWjVLMnJucGFNTG16?=
 =?utf-8?B?YW9CNVpQeklWU2s2eTFRYWZJV2NuWGplR1pDUjk0YlpoUjdHb3h3UklTeXgz?=
 =?utf-8?B?bEpUbkYxdGl5cHJsbUFtYVdRWHpGank4VDFUb202UTdMcUFrQVUyMGJ2Q0xQ?=
 =?utf-8?B?by9BbzRXdjU0a2JBMXg2NDJrUHlwbVNzSjZBek0rYUdNZzBkdHQyZjdET3Fq?=
 =?utf-8?Q?b4+nLwy5OyFYust9PwsEZLBLo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9265e812-b302-413d-b4e6-08dd346d18a3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 07:28:52.8149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6GHAkw5R4ORcSgrQLL7MOCrZHOCRvlwUbj9UgKVFbgaKbM3UU/RBIL4Q/t6eqkl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168
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



On 1/6/25 10:06, Venkatesh Yadav Abbarapu wrote:
> Add missing prototype to fix the sparse warning,
> warning: no previous prototype for 'set_dfu_alt_info'
> [-Wmissing-prototypes].
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Include dfu.h and remove the set_dfu_alt_info declaration from board.h.
> ---
>   board/xilinx/versal/board.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index fd5c6ced79..c0477e6574 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -6,6 +6,7 @@
>   
>   #include <command.h>
>   #include <cpu_func.h>
> +#include <dfu.h>
>   #include <env.h>
>   #include <fdtdec.h>
>   #include <init.h>

Applied.
M
