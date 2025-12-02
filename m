Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE8CCFD376
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 07:24:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE05E83DFA;
	Tue,  2 Dec 2025 08:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j7mMJ4w5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E17D983E0E; Tue,  2 Dec 2025 08:24:45 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C80A83DE0
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 08:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cr+fZUMO1gFDu3CsiFoHuM8S0YHBreuMCg7/JMqiNM9T2FPIeHSXqnD37+5h/bbNXXJEj6oABeOaZNG4B2r3D3lNZWPseyQdO+O0sAR0RtIgUJHiUhvzThE57J2bBA529ZxtYTF0HiHBL9zEIE7BSlUaJXZ3Ai9dxCe4njfEqX6Xzj8FEjkWEdaioqxQXuGfhBW3W8yDWigIeM2R3EmSf3w6v3sqP3Zp4nmk8ihUsKxqps4UW3gSsedc1bIWxpy/Myz5PmlU/emvvOcuP0FRYj2W+RxsRG3ZDVv7C6WM9jX9++sjPGoWiJv+UB3/IikZu+0rlur4UYkeOfp9aJvqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=023kBEx8ijufggAz21AmMYVyl6soUsNU/AOBzz83NYs=;
 b=h+rLhjC8T98q71zTKClqZ+m/F63mJs8fe54uOWB8FWaClQ/oyd6xHkQNWCOTfQF2wuBRCt9MfEKxqubgPxb66p6lhhsefwkuvumHMRwCFgTeqVMYyJk+hxvwtkZRIwvPF9xoya85s6QrOQZZ0a0Rllyr5vJ98cs7nZSlt20nGf/CPcCf/FIXiwetysrEYyaCb+HgXrvbwX8hoDe329egnr830IiRK/7+rpey0ByOP+YmTBtY5WpSC1Hsvwtc+dOcqMsRW8rsoJt5FoyTHPo/LYAVlmt632iWAcf/G85lgBbUd9E1TS7PnAy2yv2XmWXncfz2lpsDj1DjnGPRs6Nufw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=023kBEx8ijufggAz21AmMYVyl6soUsNU/AOBzz83NYs=;
 b=j7mMJ4w51tNPwEupWt5ioeYuWx199o0Nfueo5XCfEP3/e8Yzz8JDOChZaFhOcW2dzYKaIF/+qNxHTi4Lz3dXEC6Jbh9yZL0eMX27c00vsBYITR24f8EuX72bysjmZPNj96duiQrKLogAVQi5C0byhE8fgsMtKkBQEfa3e1Rddm8=
Received: from BYAPR04CA0036.namprd04.prod.outlook.com (2603:10b6:a03:40::49)
 by DS0PR10MB6848.namprd10.prod.outlook.com (2603:10b6:8:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 07:24:39 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::de) by BYAPR04CA0036.outlook.office365.com
 (2603:10b6:a03:40::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Tue,
 2 Dec 2025 07:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 07:24:38 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Dec
 2025 01:24:36 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Dec
 2025 01:24:36 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 2 Dec 2025 01:24:36 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B27OZo21842245;
 Tue, 2 Dec 2025 01:24:35 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 2 Dec 2025 12:54:34 +0530
Message-ID: <DENJUYPGV6Q6.IA9OYWK5Z67Q@ti.com>
Subject: Re: [PATCH] arm: dts: k3-am62d-evm-binman: Update DM
From: Anshul Dalal <anshuld@ti.com>
To: Andrew Davis <afd@ti.com>, Paresh Bhagat <p-bhagat@ti.com>,
 <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <v-singh1@ti.com>, <khasim@ti.com>, 
 <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251128110210.4143342-1-p-bhagat@ti.com>
 <5f575e86-a687-4427-af8a-108f08ee4d39@ti.com>
In-Reply-To: <5f575e86-a687-4427-af8a-108f08ee4d39@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|DS0PR10MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a16fef4-caf7-4e57-2361-08de3173da4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVlaM3BBUE16V1dvOC91b2lCUEFoMEJFckZTajJsTlNna1cyRDdqSWZhQjZM?=
 =?utf-8?B?Qks3bjdDN0hrd093NEMzTFZLUXlZZWM4aGdIdXFWNXhyNVk3R3REQWtEQkdQ?=
 =?utf-8?B?MWtBVVRpVVc3Z0VqbWt2TjlteU9FUWtCS1Nma29tZXFOUXFEODZKR2t0RVlY?=
 =?utf-8?B?ckJRUkZsWnRiRXUwUitrUVZWQk4xTEZJeUt0bWMwdmN1RTFXL2MvdCtlYk5D?=
 =?utf-8?B?S0dXeXNudG9lczdOMmlnZGNEaWdwdkd3b1R6aWJia01zTjZuMHYvcEltTUds?=
 =?utf-8?B?a1NFcmhJWElLbndwUTBLQWw2eWhkUTRFKzhhK2s2Vm85STFDS2hpbjBwQWZP?=
 =?utf-8?B?TzRmekFlNDdSTVZCN1VwaWZWVkJnY2wwcVcycnpicFhtR2hFTXA0MTlFaVBY?=
 =?utf-8?B?YWFXR3dJak1icElvTjdmOW50UERVZGpZT0k2VkN6dE44MTE3VlVsRmloWFZl?=
 =?utf-8?B?MDB1T29pbUlTQ1E5RWd2bVRNQ1lNbzA3U3JNUnZiTndnOHdQUXNNU2wwK2Np?=
 =?utf-8?B?TEhyVUlSV0x1VjZydUg4ZitScFp1Z2oyY0tZSUpLY1ljbGMxTHFHaHZINkVW?=
 =?utf-8?B?UnFCNHNVUWo2VmhZQTNPbkt2Ymp3M2Urc3J0ajdUQmI1WDY0Z2N3LzZkRkI0?=
 =?utf-8?B?VlcweXFwN0YrK1dVWkwvbDRCSCt6R001VWVneVA4emYxN2ZKY3c2UTAzaGJi?=
 =?utf-8?B?dGpkRUxzdUVPNWEydjFNd3lETTB1SDByVUJuY1VYYTZaWUl3OEVPQnRuZ1Z4?=
 =?utf-8?B?QnJBTlJzaFk5Y0JmVGd3ekVLQ1pRQjBpeWF1NVA3dHJwNktDbGw0N0ZnMVVh?=
 =?utf-8?B?N1A3cDJocWhkNkxCU29SVm1GOExBK2ZNRkJuR0xNTW5NM0czOFRhQ2g0bVZ5?=
 =?utf-8?B?QUl1enVBdmR4TjNwTFZ3dTlSTXQ2VENSSi9PeU05MWdnZ29DZW10b3o0cWJH?=
 =?utf-8?B?QWo0eUY3aFlQazRzQkhpdHJNUW5aZ29VZ2ZEOEpCWTAzbjNKenk1NVhiNkcz?=
 =?utf-8?B?ZFhOd1hOc2RNN3JWYjQ2M25oRnU4YVBGYWtoNEJCbnFhSm5vOFFQLzRPWGRu?=
 =?utf-8?B?cG5iYWZUWEtWcHFGNThod2VTRjNoek54c29yTnVnS1RCNGg1L3hZN05oLzN6?=
 =?utf-8?B?dkpIYU5wdS9EbFBuaDVxVGt6dEh3NW1CZ1UzaU5MRlRhTmVCTDRSRkR5MTJP?=
 =?utf-8?B?ZWt3d0RJVU1haVhzekdabTQ1Nks5VUlSQVlXd0pnUjJyV0RwL01sU1RTZlg1?=
 =?utf-8?B?QTlNS0FrR1IwM2g1OUFQQXA2bUtqV2t1ekJaUE14UUpXOWV2bE54WHV3ZmFl?=
 =?utf-8?B?WnAxN2cyeFcySjdRelhjeTF4c1k3L2EzTFNJaWsxM0ZZVTBCU0FyNURiYk9O?=
 =?utf-8?B?aUNjcEMyRzJmRkQ4U1J6d3JiNXZuV3k2aGljU0puVXpYNXNxTzVoSWdJOS8y?=
 =?utf-8?B?cmczME9QbWQxR2JBVVE3TCtjRTRKaHhnZXZzRk5DT1pRU25YQUxkNU9xdkdV?=
 =?utf-8?B?R2lNd3dValF2YXFOZUZhSE9Ja25UVWw4M2JnWXRBZVA4VmRvemdEYWcvREMx?=
 =?utf-8?B?S3pBOGlzOGUzeGpmdlp2d21TdTIvdERUdnFvbkhjbzM5NmJ1SHA3TlBhUVB5?=
 =?utf-8?B?S0VJTzEvKzJ4cGdxcmlGczMxTzRENGYvMDdXUnhvYVJJa0FXZkc3c3BUNVNT?=
 =?utf-8?B?eTV1ODhCUkdyMXl1YkxFNDVDNFdSZW4yMCtpS2dpTm1YZDhYU3ZualRrUDFK?=
 =?utf-8?B?MTdDZS9LandQWXNlclZiTGhSYUZ2TWJNVWp0b3VRL2UvWGFHTUtKcjBqM1Yx?=
 =?utf-8?B?aFBRRFIrRk45WkwrMm0xUGZRajJMNHZHbS9xSjNVNmUxSjB0c3hLUVVTTmEz?=
 =?utf-8?B?UUIzVVY2ZDdrYjBkRGd5d08wWlZqQTNwVVZYU0xXc09rK3NFWkhJMjNqZmlP?=
 =?utf-8?B?bTc0M1ZzRHhTdXN6NlBKVmtVQmdxYnk5L0toV2pScUFtSTBvaklmSk53MDF6?=
 =?utf-8?B?OWt5amJ4enlzQ0puN3BtNGhlaFZobVBrVjQxT1hqUEZmNFoyU1IwM1F3WUQx?=
 =?utf-8?B?UVp3cmJlb1lQaWFFd2JIRTNaTjVveEk3SU5PdXI5ckVQNXlwajVZS1ZueEpE?=
 =?utf-8?Q?IoYc=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 07:24:38.6168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a16fef4-caf7-4e57-2361-08de3173da4f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6848
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

On Mon Dec 1, 2025 at 11:52 PM IST, Andrew Davis wrote:
> On 11/28/25 5:02 AM, Paresh Bhagat wrote:
>> AM62d previously reused the AM62a DM. Since a dedicated DM is now
>> available, migrate to device specific DM.
>>=20
>> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
>> ---
>> Boot logs
>> https://gist.github.com/paresh-bhagat12/38bce75c43466b5074271f4cb2ddc3f3
>>=20
>>   arch/arm/dts/k3-am62d-evm-binman.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>=20
>> diff --git a/arch/arm/dts/k3-am62d-evm-binman.dtsi b/arch/arm/dts/k3-am6=
2d-evm-binman.dtsi
>> index 7bf0e955645..3a0ab9f8b2b 100644
>> --- a/arch/arm/dts/k3-am62d-evm-binman.dtsi
>> +++ b/arch/arm/dts/k3-am62d-evm-binman.dtsi
>> @@ -101,4 +101,12 @@
>>   	description =3D "k3-am62d2-evm";
>>   };
>>  =20
>> +&dm_falcon {
>
> Not related to this patch, but just noticed we have a different DM node f=
or
> falcon vs regular, would these ever be different? Could we reuse the same
> filename for both, was this a limitation of binman or an oversight?
>

It's a binman limitation, as with a common node it would complain of
duplicate phandles (once in tispl.bin and again in tifalcon.bin).

> Anyway for this patch, LGTM,
>
> Reviewed-by: Andrew Davis <afd@ti.com>
>
>> +	filename =3D "ti-dm/am62dxx/ipc_echo_testb_mcu1_0_release_strip.xer5f"=
;
>> +};
>> +
>> +&dm {
>> +	filename =3D "ti-dm/am62dxx/ipc_echo_testb_mcu1_0_release_strip.xer5f"=
;
>> +};
>> +
>>   #endif

