Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F11C4452D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 02:39:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D43306069A;
	Wed, 22 Jul 2026 02:39:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qVNHTZE0FLQL; Wed, 22 Jul 2026 02:39:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 04B8D60724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784687953;
	bh=boA1UxAAs+bdGig5KGvXH4JA8x8ZB3M16l21z0DBwOI=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=zM12PWls19IwtwAD/W3K3RwbZnhavGM9kyoJZL3bwQmxOmMlJVUzthedUsOOlqb5+
	 bm/1t2Ic8L3aci11dJTU15IGYV1UQYIIHSqJeouUGitzI6PF2q48vfeUfDiYv91dz4
	 Hlub2sXxVkUW6fbfRQzYVVsE64im4/I7Oh49EBlUlVWvhrkrc+FVbG0AfZRH9hxPpF
	 XIdZVe2hPVNrnrhCu2FgGBgoekccUv/+xEgEF5HAn3EJBNM4IHeqkUuxajS0k6fQY6
	 RPbU0KR1VE+DxGwf/DT6e7tOtKhkCpkYTw6TFMymVySwlNCHYIN9NpoPDgUV9G+lDG
	 pCgq1JJmCxkIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04B8D60724;
	Wed, 22 Jul 2026 02:39:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 13DC910A3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 02:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 080CB4023C
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 02:39:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tJKuo2mzmU6h for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 02:39:11 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dinesh.maniyam@altera.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AC7C24004B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC7C24004B
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC7C24004B
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 02:39:09 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17C7E846A4; Wed, 22 Jul 2026 04:39:08 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73469803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 04:39:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyyWxmrnctslEOGRlZkPi0FWgPkNhkaibXNcKVoCjG1u+U1tEpcqU9fysW/mQIU2CIOeOHbmQM9L+xxEY0l6PM7p4TkwyZK6Unjrt9OJBWDwybqHZn2yv8eFywaTQhSOTAOUmPCq957DCh+x4HMzRhQJULyMmExXoFrgTaWH/UKFijyMzSHRrujIuoJ2dlQEAGw+HZ+RTaDIf8eW2ZDqsYFYsYP+BevCabJPNwA4ZKqUk25rJzNECr/Xsiwlbt8mvLg+k11kjn4Hv+pa3Ex9LB53qmlcZ5A2svOTFy7KrAUEtMVdUiPRJmECDQ0ziAh0sXzL5qJ1umIIRWVsouuKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boA1UxAAs+bdGig5KGvXH4JA8x8ZB3M16l21z0DBwOI=;
 b=YkxRUwVrqs+eWbY7uPkxRq6x7iCien00Yx+6MRTqNjwjk+EvswycbzBBIB9dKjE0DQjqP1tjdgj/g3FcYA9xbxl+yP1xb+Awxjv+aesVi1It3DDPCCMtMKgTulW6z4lCjhbmzbXeBZXJSXNZ2aC8E4DkDKjILXjxD3QqlJ8CBGpTbKzeYBTDEI5oM06Vwtw6EYH9oM06yoA31YEPHRVAOfY1cCn4eTc5b9eNgI4G6/hMR7wNhqk62wguYzX34WcShHeAx7B+8HWbcKEbMioID32Re6WUH0HFLK+Al+767tePUzs6dY9DFDT3wtcFvBNnB1ZDAKAHrztI5YeYdkz9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by LV5PR03MB8460.namprd03.prod.outlook.com (2603:10b6:408:35b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 02:39:01 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 02:39:01 +0000
Message-ID: <0bc5784e-7eef-4b70-a4ee-f11dcd2a1910@altera.com>
Date: Wed, 22 Jul 2026 10:38:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch: arm: agilex5: Configure DFISEL for SDMMC/NAND
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260311050117.23037-1-dinesh.maniyam@altera.com>
 <223e763b-772f-4b3f-8b1d-301e2d976884@altera.com>
Content-Language: en-US
In-Reply-To: <223e763b-772f-4b3f-8b1d-301e2d976884@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::9) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|LV5PR03MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: f20a8d9d-ba59-46af-ba27-08dee79a6302
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|11063799006|4143699003|56012099006|10067099003|6133799003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xeCVtNgBnnkedcJC6BpFZ/aXdSsRGVTiuBetRonHKixOgrVGGeAe5A6QuPpaXENQ/KV+kgJUKWJD7JsthK3l7YZ69Zadq+DB6myCYHCcJ2xFjAvn4bBmpicpC1qNuc/587DaCsY833xNt4iMyCpRl+w2610S15wChUgtfy+zebZ0Hp+pXt2PEtIdA5bY8cbD+3U2UvWPAeLyZGaESg1xBjxRnOToGl4pFniFzEernToQbpgtl3gVVCwvJ8qu8NfWV0x6cK3m7LWsUCA3sd/DpAELL3C4LoJzRxbD3Z7EN9WqO8JmM/Uyh/Dc5D1W0w3fsuRHa8NAA3yIyjJbV5tmR/6pvkAYYUtlbjCjzoZ3JHrSBfHDnsvjg0dQjpEXt54jmqBalqrkWltH0lbs2UhV04JhRxXXnYjDumzvMC4bB0B4i3vaVXuELkCi72hEFiE7/svOoZkvf9XDcahBqr5k/Egi46ZG++JjdoyTYxmTRu8OXK1uOVCz4PwTvK9aSQijDsVjqrO08Z2IazHVjLOuPHvK9vnAzf18XuaYw9QB/WcgdRxore3RaP0YuYh64dRRKxRlZUe81LKY4rtjh5d6DJPQnEuHk6hBGtS1aS8sbI7zyy3lcWHyEkqxu2eS+ZUNv8roXNZT2VGF1xFii4VkPOpI/qBace9L/xLn9gN/dvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(11063799006)(4143699003)(56012099006)(10067099003)(6133799003)(55112099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UndwUlptODBhVm90Q0Jxa090UXVSTk5KeXM0OElyVFM0SGdoNXAvK2laU093?=
 =?utf-8?B?cGEzSVUwODFsdjVBaVpBTDNHQVZFT3YzRFR4RXJhc3BvNDdFVHVvaEpjK3c4?=
 =?utf-8?B?R0UzVjFNQWMzVzZXbm1QNk9Nc1RObndMV0NVaStlVzZFQVBENkFYZ1BwMUU1?=
 =?utf-8?B?WTk5SmJKeFVkVEtzajFVK0FGU2xmQ1lQZWV0R3JKOHQwQmZCZUVaRkdWRXBv?=
 =?utf-8?B?TmRjQXlWOWY2UHhrRkI3QUVuMVlFYWdoUTJqcFNEZFpyc0RhTDg3TzhYb3Jk?=
 =?utf-8?B?Z3RqSWlkVS9ZZTJxN1RSbzl0MjBMNjlCQnBia21aMUxHaThZMXBkSTE4YVh0?=
 =?utf-8?B?T0lFTUlZaEVwWlQ1UlVodS9FUmZNRTdMWUhJWUR0SFVkc3REQmp5bWtIdzhh?=
 =?utf-8?B?dGxaUjVBNVRrUENTdTV2TG5yekU3R0xQTTFUWmI1MVJuWkZ6Umk5N3hQRXJT?=
 =?utf-8?B?NzV2cGE5K0R2bEw4VzhlL0paUzZRbjF6UE4yN1gzekxoUjY5YXZwQ3RvVkh3?=
 =?utf-8?B?UHlsV05JeVpNYXVNckNtSlgxTDJMZllKT2ZhU2piVFgzcWkrZlNMVGhwbFNv?=
 =?utf-8?B?YUFQRDkzd3pnMHlkeVVBdTg5MVdHNGh2d0hRbjViUDlhU0FBTDNJNDlXTDdV?=
 =?utf-8?B?Z043U0l4THBBcUJBMHNxbjkzZmR2b0JtUFl2TUlReGU0bWlvRDFlTTZaVDA4?=
 =?utf-8?B?M21rNlZQQ0ErSC83NGYrZmZLbitTSWdWc0Z2cGlkOHZhOWFCZHlGQkkybFRn?=
 =?utf-8?B?VVpSK0I5VWxsZXNzWVRDYlJqMnh5b2JRWjR3b2tCc1hVYVpuc0JYSEdJa0Vz?=
 =?utf-8?B?TUZ2NVZ1V1pnZzFlZW1JS1BwYlEyeEUvQ3lrc0ZUWE9kOGFrM1FtZGZ2czda?=
 =?utf-8?B?QVRRNFdRdEVqaGJxU2NHNTNYdk5JQ2RRWDdRVnFKSUdPOUFnWEV1QVd4QmR2?=
 =?utf-8?B?alo2R2tvSi9tS3YwalluMHlOREpPTHlVbkVoSkpaWTVFbnN4blZWYWFVSlBo?=
 =?utf-8?B?VkcwaUt2SXNMRnMwRnJvWXNhOE9nblVOVzdqQUtLMG4wc2VXazRwaTdPajFK?=
 =?utf-8?B?SHRYVG95YVlMc2pkL0sxbnZtQk44TlI0d0wrd01pZlU1clhyd21xdUYwVXZo?=
 =?utf-8?B?QlFORDVKVjJ2ZmVqWEhIR1p5NkNkSnZKRy82TUFaT1I5bVJSb3NuNldjYk9W?=
 =?utf-8?B?L2xZaHBYVzExZXpieFJEMitvYm54eFBDYXl2NGJzcnlNamVSUjZySzRxaXRt?=
 =?utf-8?B?SUtSTHRoMzVnUVM5RUtMelVHdjZrbU1jZEFteTRpN1VjblhyeWdvWDgvWTlV?=
 =?utf-8?B?bjJQTmVlUERGanhBZzQ2eGR0Z3pSbFpLSDZmZG80bUhyYXMvRDlnNlNIaFg2?=
 =?utf-8?B?ZTlYUHNzeWloeWVjeUc5VWFYbXdjOVJMVkJIelNVcWxiNkF6ZEhvMVJvZlhT?=
 =?utf-8?B?aDZ2aythOGFNU2QvU2Q0MGZmVmxkckRaa3B0UjZFditvZzNmVlNHaGUyTW9l?=
 =?utf-8?B?WjB4SjFIdVQzRlBOeEFqQ0hhaE1qVnFacHFTMWR0eW9TRGdpeEU5YURrVkNC?=
 =?utf-8?B?UzRKbHNCR3hpOFdZUzNJa25wS0hCYmhUd25zSDNjdG5NT3VBRW5LQTVaWlJi?=
 =?utf-8?B?OHB2Y1oxSng2RFBLR1Q5N1E3ektCMVZkbHdMM2JwaDYvdTlqQjQ1d2kxSUg5?=
 =?utf-8?B?N3J6WUVuUkt2N2phNjRLUmhLcWVhWXVmNml4b1J4M0c4YzBMb0ZlWFBoTXMw?=
 =?utf-8?B?UTdXRmxjSDVwTW9lY2djY2NXZnZKM2tpRVZ0Y2M3TjZveE9SV2N4N2RiQjVW?=
 =?utf-8?B?UzFaVWtkSE1FdHZscEZZaVQ2VndWcjNZekpmWU00emJCeHZYNHRXM0dSVmtE?=
 =?utf-8?B?Z1hlTnFmVlI3TnZFeDA1WFRidGVFbFBoYy9GOWxyRXlqWXlZTXlBb1YvazJk?=
 =?utf-8?B?Yjh3VmdWQmNLRXZiVUJRYWdOZkZRRThJSHhuZnpUVE1WbURLbUVtSVI1SUJy?=
 =?utf-8?B?ZU5SV2pjZ3pBa1lWY3BWc2c2RlEzMnVoeEI5a2QxSXZmWUg3U0FKb1Y0eGNS?=
 =?utf-8?B?SUtvY0ZOR1BtWEhPbWVpSEk2L2V2K2RiNWxtU0VkR3I1ZDRFYmhiRDdwdFFR?=
 =?utf-8?B?V01xUmY0K25taHhBemFkMFFZT1FhcFg0Tk52bmtsVWtZRkNHUE1Jb3hUcUVS?=
 =?utf-8?B?d1dXcHZibWNlTnZEYzBVWEJDLzdEMnhZZGFhYnN1WW5Ick9sZE0rcnJpbWJM?=
 =?utf-8?B?bitmRUN2S0pzNGdhWU80NjNkbTNyZzlXZkdMc0w0SnNaQTRoNlVpWk1XM3Uy?=
 =?utf-8?B?K045MUx4bEhVTG93dmhGV01LNVhXd1hFNWsvVmU2c2xsN2NEUGZ2YmVINHBj?=
 =?utf-8?Q?j0qpEAqsoc2UTNm4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20a8d9d-ba59-46af-ba27-08dee79a6302
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 02:39:00.9566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuX1DNlMF2p9HqPXMuGPU1LtBC6bGIQlWtEpathb+RDd4BVEDbi+uWlL9knqaY7pjwv4QbFpgROPaQ+IoPVqoNFdK9mBq9vVki5Hx2ICJUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR03MB8460
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boA1UxAAs+bdGig5KGvXH4JA8x8ZB3M16l21z0DBwOI=;
 b=S+P1evJRcKC+ZLn/MOvN2t1OdR7yksPtx4ZKfPS/7C/sUM7v6GOt3T7IO4I5sjBlMfAYaNFzImlGJzJbC3ltzxSw7lbkieiSXfc7s1vljJjqzIHbBPQzxUv3pt5Xtp+pv3E79SH7h6OHrm5ME+Nk8cjHJCLy4jUM6SXt0loEncYZA7iW7NkPsP3mfsN8WrlOLeRnRdeP09dOYqopEHv08ZwFXtpZaTPOuK2304FXNxVXZ69YUhLfjVQ9pQNKbGGqCCSeRjSXh7KLNWhiRAGYD7rJcPxvmLtqBUdmFQNtNprqz+lbybhF/rob5gxUUBIJ6gvGTTMWWCfXk03BmaC86Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=S+P1evJR
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dinesh.maniyam@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="S+P1evJR"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: "Maniyam, Dinesh via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tien Fong,

On 16/4/2026 11:52 am, Chee, Tien Fong wrote:
> Hi Dinesh,
> 
> 
> On 11/3/2026 1:01 pm, dinesh.maniyam@altera.com wrote:
>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>>
>> By using the handoff COMBOPHY selection data [BIT 16], we can determine
>> whether the combophy used for SDMMC or NAND. The DFISEL configured for
>> SDMMC if the handoff COMBOPHY sel [BIT 16] selected for SDMMC.
>> This ensures that the appropriate PHY interface is enabled during
>> early boot based on handoff configuration.
>>
>> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
>> ---
>>   .../mach-socfpga/include/mach/handoff_soc64.h    |  1 +
>>   .../include/mach/system_manager_soc64.h          |  1 +
>>   drivers/clk/altera/clk-agilex5.c                 | 16 ++++++++++++++++
>>   3 files changed, 18 insertions(+)
>>
>> diff --git a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
>> index b8f2f73e283..39e3340f38c 100644
>> --- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
>> +++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
>> @@ -81,6 +81,7 @@
>>   #define SOC64_HANDOFF_PERI_LEN		1
>>   #define SOC64_HANDOFF_SDRAM		(SOC64_HANDOFF_BASE + 0x634)
>>   #define SOC64_HANDOFF_SDRAM_LEN		5
>> +#define SOC64_HANDOFF_COMBOPHY_SEL_MASK	BIT(16)
>>   #endif
>>   
>>   #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
>> diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
>> index f768a3a55cb..f95ee6ce226 100644
>> --- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
>> +++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
>> @@ -18,6 +18,7 @@ void populate_sysmgr_pinmux(void);
>>   #define SYSMGR_SOC64_MPU_STATUS			0x10
>>   #define SYSMGR_SOC64_COMBOPHY_DFISEL		0xfc
>>   #define SYSMGR_SOC64_COMBOPHY_DFISEL_SDMMC	0x1
>> +#define SYSMGR_SOC64_COMBOPHY_DFISEL_NAND	0x0
>>   #define SYSMGR_SOC64_NANDGRP_L3MASTER		0x34
>>   #define SYSMGR_SOC64_USB0_L3MASTER		0x38
>>   #define SYSMGR_SOC64_USB1_L3MASTER		0x3c
>> diff --git a/drivers/clk/altera/clk-agilex5.c b/drivers/clk/altera/clk-agilex5.c
>> index fb1e72ffc5c..dd999e25aec 100644
>> --- a/drivers/clk/altera/clk-agilex5.c
>> +++ b/drivers/clk/altera/clk-agilex5.c
>> @@ -25,6 +25,9 @@
>>   #include <dt-bindings/clock/agilex5-clock.h>
>>   #include <wait_bit.h>
>>   #include <clk-uclass.h>
>> +#include <asm/arch/system_manager.h>
>> +#include <asm/arch/system_manager_soc64.h>
>> +#include <asm/arch/firewall.h>
> 
> 
> #include <asm/arch/firewall.h> does not appear to be used by this file 
> after the change. Please drop it unless a follow-up hunk needs it.
> 
> 
>>   
>>   DECLARE_GLOBAL_DATA_PTR;
>>   
>> @@ -244,10 +247,15 @@ static void clk_basic_init(struct udevice *dev,
>>   	struct socfpga_clk_plat *plat = dev_get_plat(dev);
>>   	u32 vcocalib;
>>   	uintptr_t base_addr = (uintptr_t)plat->regs;
>> +	u32 len = SOC64_HANDOFF_PERI_LEN;
>> +	u32 handoff_table[len];
> 
> 
> u32 handoff_table[SOC64_HANDOFF_PERI_LEN]; is preferred to avoid 
> variable-length array
> 
>>   
>>   	if (!cfg)
>>   		return;
>>   
>> +	/* Read handoff for PWRGATE configuration */
> 
> 
> The new socfpga_handoff_read() is described as “Read handoff for PWRGATE 
> configuration”, but handoff_table[] is only used for COMBOPHY / 
> SYSMGR_SOC64_COMBOPHY_DFISEL selection. Please update or remove that 
> comment so it reflects the actual purpose (PERI handoff word used for 
> COMBOPHY select bit).
> 
> 
>> +	socfpga_handoff_read((void *)SOC64_HANDOFF_PERI, handoff_table, len);
> 
> 
> Update len with SOC64_HANDOFF_PERI_LEN
> 
> [...]
> 
> 
> Best regards,
> 
> Tien Fong
> 

Thanks for the review. Agreed on all points:
- drop the unused firewall.h include
- use a fixed-size handoff_table[SOC64_HANDOFF_PERI_LEN]
- fix the comment to describe COMBOPHY/DFISEL selection from the
  PERI handoff word
- pass SOC64_HANDOFF_PERI_LEN directly to socfpga_handoff_read()

I'll send v2 shortly.

Best regards,
Dinesh
