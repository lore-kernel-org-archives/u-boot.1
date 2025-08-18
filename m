Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E990DCA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 12:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC2E780107;
	Mon, 18 Aug 2025 14:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wnNI5XOJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5673A801BE; Mon, 18 Aug 2025 14:05:35 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 825AA800D7
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 14:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJG/TI1FyMeEO88k80XVDD5XG4YcvEGBKkGZiQ5qDhD0Du8edYiz0TyYARa4KKLe7KFrsovLvQpLZdvUPuyzZ1fVbDwm/lRbxljZya8vg7/dCi/36Wpx8Y/MyZDSzHREuv6HkYFVvymuqsRyx2sS2x7RH6WgqRcZob6yBmOQWvkn8rnUyCcwQNPVMXB/t72MH4zuxS4mAqtPo4ZHdO7Iz9y7wwF3jY1XdV1+ryUAtKnuqunqk3q8L0JKPwL15Ftb3azbAH8woGPjxXmr0q8yzROcghWass89mJ6eS4X2Fb5BgvYKi2m8B/nIK3p/Cr8sPO+Hol0rddT6u4f18yGcbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7hyR8YOccYiHKrAX1fIx4ywVQVcUTzNXnYy9bxLjWM=;
 b=hDwRR2rQFkXPKNm3UGnd1IH4udoeFEOUBi7kQK5PpLM1zRz5BXOXBsM9VRScTtQJ84tOkjWkvflKaDvKxFXgukjgzeVmiIfJ4BbH7NAJyBDIMoMDj771g9tADWbNN48+f5M3nCCXzBzwmKnsNDobOYmiEpY5HhTPVmYDwcjU58qpvUlu8o1jn5H2T/qGa8WZgf4JS79PH4oQqCJQ5Twp/+eB4ADF8l1tZDp4E3cmi7zj4DKXJ8O96UdfUYNK4Mxe2j8h0jf2hJBo4h3bvdyWZDpLAtTy0BIgg/4/cAPhNcG8HqSvzkVpMtVbpqBELHhCedeUM27NcJ2e7GO9hPVN2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7hyR8YOccYiHKrAX1fIx4ywVQVcUTzNXnYy9bxLjWM=;
 b=wnNI5XOJXO6XN9W5wY0W/qzv8qGdEEmGOaywg7nMCsrvahw/HXzwE6A1AMxnhY3iZvI3rryanqNl6DFUBhG5hwBcgcnvsKig21VaRj7ZHfGAnEd/vbhoJepluEIVMb7NNBBCv7HW9plm/HEflarENknD82EsSpqV/5M6TeWUeHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 12:05:28 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 12:05:28 +0000
Message-ID: <05892a67-9bbd-4a7f-958d-2f0b9af844e0@amd.com>
Date: Mon, 18 Aug 2025 14:05:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: cyclon2: Remove message never printed
To: Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>
References: <20250804090816.42603-1-ada@thorsis.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250804090816.42603-1-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::21) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 60920282-ea51-447c-1770-08ddde4f85e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTF6NW5HNDJUWUJhREdKVEdMay9BU1JaclFDUnZJVVBTZDg4UWR1dko2dzdM?=
 =?utf-8?B?ZWp6T3ZlaTMzdDVlanhhbDZ4VGY5Q29neSt3cTZQVUljdHZqOUVTWVBhenZv?=
 =?utf-8?B?QUNKVVRFSmpZZFlzZXBTd1Z4bkZPc2NXMVBLOEowN2FPL0FVeWw1MysyREht?=
 =?utf-8?B?aVg0RFRjM3c3NDZZK2RDSHgzd29wcHpvYzcycHJGajczbzVQaDFsalNFNVFy?=
 =?utf-8?B?SDFJV1hFWlh4ODFkMXg4RDNoV05yU3FrZTNQbDZGKys0djBmc3ZaZ3VDd1Jk?=
 =?utf-8?B?MlhGV0xQdE1ia21FTjFINzZYQlViaFJTQTF5WEtPR2haQkNkb0I2bGFFT0Zl?=
 =?utf-8?B?a1VydjFJekEvVnhORlNTUUtPUlZnSFhRSE9TeFRpSEk0MkVDMUsraHovUjlR?=
 =?utf-8?B?UDhrYUovQlFTeDNrTSsvRTVObSt4c2pnRlFRMUxMN3VOalBYeU9uSmJHdFlM?=
 =?utf-8?B?dFBHdUJibjRwWU9PSFp2L01EelNYZ3NBVXdtWUgreHd6ZkE3RmxrNmxSa3BX?=
 =?utf-8?B?S1B5bDRQZG1vdmxpL3c1VUo2YUNFR2t6WlpJZGZKdUMrUFA2T0orUTBvWmov?=
 =?utf-8?B?WFA0bE51U3dBUFZpcVArbjFHTndJdHpXV21pc29waFU0cUpPK0R2NmtMZzEw?=
 =?utf-8?B?ZVp4aHNuZVZQbkJ0blZZanByQTZZN3IzdEhLVG8yMHNZVnNobzlTZTAvQlNs?=
 =?utf-8?B?TEdTN3dWSmY1eE1XSHJVVS9xbXp1Mmc3REY3cHoyMmg3b3M5emMxbEdpc1pr?=
 =?utf-8?B?aC9pY2paanpJOVVzTHRxY0NBSFlJaW5LVEZUbjNleHVVdUpvazdjNlBzMmJl?=
 =?utf-8?B?aGdnTmhCZEJIWUlhUmlacU1Jenp3UllvUEdmS3BKbFZ4OWNIZG9yTFlEM1ky?=
 =?utf-8?B?Nm9NcHdvM3p5SkJqck9vVU5OenlpVE81S056UndnZkY3dGpVT05DUFdFcWIz?=
 =?utf-8?B?aDJYMFJFZU1WMDlXY25zM01lNUNyTzFEQkdrMWRFVGtUMFZIN09NS3dyaTZ1?=
 =?utf-8?B?V0xFbjRKM0RNRTN6bmdudG9BU3pod2pnMWE1WHlvaHpsdHgybmVDK0RvUEVW?=
 =?utf-8?B?d0tLSGR6dW9Cb2cxYWxEaHZTbk9Ub0hJWVdzVzhRZnRldDUvcVFsdzFmbUgv?=
 =?utf-8?B?ZUFXMkpFMjlyTlJoeE85a0dySmVyaW55eE80Rk5ubEdSRm9laGRDK0xjQUQz?=
 =?utf-8?B?RzIreWdoMmV0L1lqSy9VcXBSZlNBdnpEVVVPaHM0dXlVT0FydHRCNG1pRU5E?=
 =?utf-8?B?c3pCRWZ5THdlMXRHbVRsWjZFRmF3cTZWWjRHZjNEVHZUZFRHaUYzU2ErUDdv?=
 =?utf-8?B?N013dzh3OUlxR1d3WG5Zd0tiTDQ0eC9CdXJBNldFVzRkMnpZWDRxYWZHNUNa?=
 =?utf-8?B?c2taVjRyWVpVdWM0a2cyYUVlMW1DM0hacEJFaVNsQ0JlZ1I4UCtBekV5cDYw?=
 =?utf-8?B?a0FCSDlmOVMxN2R4NDJUa0RFVHVacWtNNkNPVUVaV0RKWFFDWnJpT2xvZlMz?=
 =?utf-8?B?djBheE9qR3RFM1BORXBqZWFEQk8wR3ZoVzdoaGltK0xnbi84eDREbDNzb3FB?=
 =?utf-8?B?VkhaaHFWcFlFc3pTK0g0Z0dHcnc3eFIyZWtsak9BSkVvOEUxS2JDSkZZaG52?=
 =?utf-8?B?MVlLTmkyUStuR0lmdlNRcWczbUp6U1cwYUNZTlYvUnlCTGg4aUxmYlJVWlk5?=
 =?utf-8?B?RmxDeVFGenA0MlE2R1V0UkZhUGdCdU9RZE9lRHlDcTBNUzZRWEV0YVIxeHJs?=
 =?utf-8?B?K25ERDZKdmhvT2tIcnM3QjEvVndEMWpYMkxXS1dRWnJlMHczcXhVZGVJRTI2?=
 =?utf-8?B?Z0p5VTNCdXUwNy84SXE4Y1Yrck5teFhaYnpiV1hPcTUzdlJDeE1MOURaNU1v?=
 =?utf-8?B?eDBPc0F6aHV0YWhvdW1CNEtXeExBKy9YdUN0N0tLT0s1T2huVnNkTFNneU9F?=
 =?utf-8?Q?NzphfMWY5Os=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlFZNHd6eWJURlB3RU53NUVwd3RNMXd4ZTh6WmdIWnEwZm8yQUQ3R1M4U1dE?=
 =?utf-8?B?TkFuNjRVdnpmelNBdWNXR25MZ1Q5VTByc1kreGhRT0JEU09LWUN6S1l3Mk1W?=
 =?utf-8?B?ZUJ3TkwvZ1BuVWgwUW5NbGhPbjZMNGZyNGY2M2dSam8yckF4YkZDcXYvMXdq?=
 =?utf-8?B?dUh4TXovOFpMbTRUVXREMFZkN1I1YXAzQ1lXazZPU1NIOEVGTTNmSUpGVnBS?=
 =?utf-8?B?YlIzVGJKQ0JLVDlNZUgvWnVKVzZHdWRzZ2JGQXFlbHhGMFdzNE1JYWJDbEFF?=
 =?utf-8?B?dCt3Rm43M3ZHUGNsT011ZUVueWNidWh2SzFjVU1KTU4yaUZtVVdNbFhjQVRG?=
 =?utf-8?B?RU1VejAyeXlCcngvVERJMTNqbGxYb0RqUHNPYkl3TjBVelBVWFAzY2tKYVVs?=
 =?utf-8?B?NmNHVmR3V3dOdWlsQUdsaTEyY2pQc0pYZXhvd1g2MHZ2UHpucmJaL1g4OWQz?=
 =?utf-8?B?SVJnNjFaaDNZTGxBeWl4MjJmMFBSTGpJSFZPOUFMSWhqeStUYlhvZ3BMTHE2?=
 =?utf-8?B?amVsMVVTQTJWQU1wNWZTVThOZGUxTU4veG84N09EMUdJMnlCZ0N1YlM0Rk9w?=
 =?utf-8?B?L2NsbWtrTG9rT3lpdFJKQ3hXWEhjMUFEVnZZUWlFSHRoQWwzTmxvUW9qTHpK?=
 =?utf-8?B?cXdtd1hiVGRrTkhhTFFuNU85RU1RN2p2NEM2KzRlQ21VcGJCdHNjTWFrQXhv?=
 =?utf-8?B?VDFMclVKT3lHMURXTXFNUHJKRWhwQWhpaFlqcmJPazI4ek1UUnZEVkpNM2My?=
 =?utf-8?B?T0lYL2VMdUdIN2hZZXJNNXd1cHVCdytXNWRkOGI2T3NvaUNzeEF0QjBUWit2?=
 =?utf-8?B?TVdDeUhMS0J2Qm5VaUkrQzhPVGIrZ25DR1Z1ZEN3WTJ3Rk5HL2E4ODQ2WnNx?=
 =?utf-8?B?TzlpYUNSYm0zU0xyNEk5UkM5SHl6WHpOd2xJYk9sNGdVSGhKSzM5bVlaekVj?=
 =?utf-8?B?Wm5vUWRDbCs2cmIzbXk0SENyTTB4TU1IM0J3dERVZ2RxSDNnRWpxR3hKWTEy?=
 =?utf-8?B?eTlDcE4xTWIzVW5MME9uUWNhdVQwL1RQL2dpdlFyRy9kVVR4RExVc2N6aTB5?=
 =?utf-8?B?ZW9FNEsrZC93cXdVeC9PNjcxN0kranJFYWhRbVUxaFNVblE2R3NoenViWExC?=
 =?utf-8?B?MFBIZjhVd2xidlEzUlRnU2VzTHdJQnljVkhnTGtnaHNJWUtrdUJlNXlQYUJI?=
 =?utf-8?B?Unlldk14SUg5SXVVWHkvekxZODRaWHhpZWdtU05MUmp4Slo3eGFPcWpQaURj?=
 =?utf-8?B?VUUvWlQ4U1Z6R0t1bkdxbU5MSi9Pem9CdXplNW1lVkRiN2U0M2N0Z3p4MkVz?=
 =?utf-8?B?dnp3OVFuUUQvS0YrUVh3U09xS1MyZzZQaFdVcWM0VW9jVHRvb2VTVS9vQ3dG?=
 =?utf-8?B?VWswV1lYekRpdU02a1ZPWmpJcDV0ZzFPNll1ZXN6R0RVNUFSU1hicm5aY1dF?=
 =?utf-8?B?Zk0yN2xCNE94dG1OTWdJazJrL3pzdFNFT0F3Ym93KzRNb3FhV3ljTTJwMVlz?=
 =?utf-8?B?SndnMno2TGlseFQ1a0RsaHR6RHc1ckZCYlRQVWFMRVZEUmZWTEwydnF4UmlE?=
 =?utf-8?B?RmtNdkxLenZWK1Z1WUQ4Y2lueWRKZEIzK3JVUGtmNkpueFV4Rk5Dc2tuV2NO?=
 =?utf-8?B?ZEc0aWEvK0lYa3haaXREOWRzRDRlRzZRL0hQNk55RFo1ZHRleDBQeXVHc0J3?=
 =?utf-8?B?THpick1LSkxBYnlVTnpKZ0c0V1pIVDMyb2t0Nm10TlBFbnZEQXVvSWk1djVh?=
 =?utf-8?B?UXFZQTZ4WTc2RzlFeUg3dFF0V1NPSjB1bkw3QmdFRklxNHBvVUFYQzlNVFNN?=
 =?utf-8?B?SE5udWxibzJEREtRZEV3ZmZ2bHpJZXM2N084SzlXYnRJVTNyc3NtOEYyUGtu?=
 =?utf-8?B?OG5XamdiUkJuZHhXOFJPV2pTWmNMeEJLeEovQmxFK242V1B6UHFSTjNLM25j?=
 =?utf-8?B?dlVHem9oWjFjMDg3c1N6WCswb2tXNll4U2RzeHpRcEVJaWZHUG94OGFRVk5N?=
 =?utf-8?B?bm55bXY4dG91SjRCd3l1ZmJVMnNMeXdURFB3Y0YxVGliTXlydFpTUnpnamNT?=
 =?utf-8?B?OERsY2oxN2Ricy81SlRjODE5UFM1MFQ5dzN0SHF3Z0VwSVJ5NWMyYVVKanNW?=
 =?utf-8?Q?TYTac/8RZj7D0qyBTn4FkLGb1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60920282-ea51-447c-1770-08ddde4f85e7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 12:05:28.7775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7m5DpdyYl/mi6hZ/FG3TETTirYpYwAKbmOLX19HUqcO4cSYORq5AuRU3ZOmZKy7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974
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



On 8/4/25 11:08, Alexander Dahl wrote:
> else branch is never reached.  Print "Done." anyways to keep behaviour.
> 
> Addresses-Coverity-ID: 583148
> Link: https://lore.kernel.org/u-boot/20250725132645.GA1807455@bill-the-cat/
> Fixes: f0ff4692ff33 ("Add FPGA Altera Cyclone 2 support Patch by Heiko Schocher, 15 Aug 2006")
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>   drivers/fpga/cyclon2.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/cyclon2.c b/drivers/fpga/cyclon2.c
> index 7e78d6e2d6c..1c464c1e912 100644
> --- a/drivers/fpga/cyclon2.c
> +++ b/drivers/fpga/cyclon2.c
> @@ -174,10 +174,7 @@ static int CYC2_ps_load(Altera_desc *desc, const void *buf, size_t bsize)
>   		ret_val = FPGA_SUCCESS;
>   
>   #ifdef CONFIG_SYS_FPGA_PROG_FEEDBACK
> -		if (ret_val == FPGA_SUCCESS)
> -			puts("Done.\n");
> -		else
> -			puts("Fail.\n");
> +		puts("Done.\n");
>   #endif
>   
>   		/*
> 
> base-commit: ae5711f881100f856ead1e76832c32b92dba93c7

Applied.
M
