Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43F4C531C9
	for <u-boot@archiver.kernel.org>; Sat, 25 Jul 2026 09:50:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FFAF60687;
	Sat, 25 Jul 2026 09:50:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pG183FvQ7w4b; Sat, 25 Jul 2026 09:50:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 869686066F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784973000;
	bh=difmFp+6FIEW+J1NnCLP76OJXJ9VZMk/Pzb3/oTB1TE=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=sm1pAtzKyTB11UKAMbDhHXIEfzpy106j4LhKVGVlv9zr69n5wX+19UVcrNCo69mu6
	 Wk3a8eamrZ9v2BQKN8JE1GAV4tDWgBZv8HtQVKaS3jFfhN8VTcf1NNZFiJh6EK+qzH
	 MHBviaS5l5QTeyR1k6c3SZWKIjyeuet38CJW762IW5xf/1DT/dsB6grM5GD/LBk9Sw
	 GOQ7dFqQp3egzw7dcNAhQUuHdhiQch95AcGlbUI6AYmbM0MOIt9e5T/KLsXfxNdk3+
	 Twi0Z4PLk4cr0IQ4gBKDVd+yT/HW0pAOZbw3t5PjjzjEvTEHe1hZNqptJ2qAf0OQwx
	 spIh05SOQiX1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 869686066F;
	Sat, 25 Jul 2026 09:50:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B76CB490
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 09:49:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A88346066F
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 09:49:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gcWBqCcVUsm7 for <u-boot@lists.u-boot-project.org>;
 Sat, 25 Jul 2026 09:49:58 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alif.zakuan.yuslaimi@altera.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4A7FA6065F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4A7FA6065F
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4A7FA6065F
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 09:49:57 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33BEE800AE; Sat, 25 Jul 2026 11:49:56 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 967618005D
 for <u-boot@lists.denx.de>; Sat, 25 Jul 2026 11:49:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=varxd/fQei9W/xA2dPMnX+Rb9oBNawvd4bsBlFzh4MMPt+x/gDYZCm+2UryWg0ibnZIAAQiQQpbQB4xw21q2EuVQT+YECzM4DbqHvK4K8Uip7B4fNI3ljfroecSJR6WXnJTiBkL0z0v5qTUrNhNEbgyYw8x+8yTvZBYYI1io5lDtxj9x0CndRleklmVD0FT2H6NXQl08cF5TyN8KFiYhg6YCLVXWyNU9Af1MhV6UiGQUDzryjvRAXAlN7UEG1RKlkHg1ZH4Z+1czrP3aZIBOx1EaBUPWhEvJz7mJCB8MCs2o/skfgH1Znln5y60nO9pisBM+4k52SE2cvyEMNNMljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=difmFp+6FIEW+J1NnCLP76OJXJ9VZMk/Pzb3/oTB1TE=;
 b=lZ1twJQS1Zo8MQOuH+BKFcJvZ5xl2O38q3OJNFsdlizPjNHhTVQTqbBVQLDT4EKZE0gacNoAJOveUNYLhXTJxXhFCYQFj7LJtwg9fyStStQ2DWrmNUiwmwyvHkohvlFlhFiRAUAm6LnbRMJ5nFu10XDMjB69hzaEzk7LfODNzdZqeLFuDNgz4lpbnKAtDsR8K4e2AYAC5Gws90HDdCilpUYvz3aL4nVFWAMcqRf8g5kKzmfNeCI6H3zquoNv8UVpsUlvHGldsdUrNoajR668N/vIQKpXgGU5rp7VwhBmaeNs1c53DmejhkOVDqpO2J7yfaEIXml1f0sv0S6dtaDbig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SN7PR03MB7035.namprd03.prod.outlook.com (2603:10b6:806:351::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 09:49:45 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 09:49:45 +0000
Message-ID: <0200e37a-7790-4a48-b43c-abbfbb1603f9@altera.com>
Date: Sat, 25 Jul 2026 17:49:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: socfpga: Rename TARGET to ARCH for SoCFPGA
To: Sune Brian <briansune@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek Vasut
 <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Johan Jonker <jbx6244@gmail.com>
References: <20260723024306.9888-1-alif.zakuan.yuslaimi@altera.com>
 <CAN7C2SDhSzVabXx+EswLksHbQSEyK4GxgkgUVG7Z3Kx7RdS6JA@mail.gmail.com>
 <a4a2481c-fa1f-411c-ac21-380b3a35a4c2@altera.com>
 <CAN7C2SCatXrdU-ObZWW=-sRAO2oa4chFu7pRsTVjcAaqs=w8VQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAN7C2SCatXrdU-ObZWW=-sRAO2oa4chFu7pRsTVjcAaqs=w8VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SN7PR03MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e44c1cd-86b9-44c9-bb84-08deea320e99
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|4143699003|11063799006|56012099006|10067099003|3023799007|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: N+Ki69aL9GfIf7LlzfEXQNEMMq0aFl25SaqM5wsBkZXN7BYcvDPHYxKgT/rhIUx82fGsVdABquMvcmTkVEsxbriEcgbHXz3tn1Da02MlQvsNkiMqhqnh3zxhBgwQBpRoIhTRWsFRMw0BxG62uG4sM3rD/dQPsWSRsJdTB2EX5+IpzYp/oxpcc8CpRKNkSIiSbpBwozjVRHiGYjMcLOpaGEVR9sXsD8bxQysnksOsP/u6IPcyr9/XV31Nr2EZjiYD0vxv4V5wnwEyqYwGdkd20L8jNToBuLdm5f2Zz9iK/oCtXjEQnuGQIvNqRQ/Brz4I95KLLq8QPsGW4xSh6AIEyYDsfBfl2ONlOMp5DLocDYrS/Sql10/7caWtVaISp7Wpqbxn9ZMcEbppY48Sce8AxNeP12S1VU11Sx5OwBvqvSJcrFLZM5oZJmVPjDVyWG+bTHsupqVyRMUYJf1hNZkBA+wXIPBk8Pb6JnFoEYQDK3hxt5tB3pLngdyXPQeoC4bbz4B9aKXUhhMi9gQnIPtM6dtjrcKgN0LLfdl3t2+ooNh1z+Zk9OMtSADObiasVnkI7yY2T8Ki5YnYAg1/DtzGHCBrxATj6AQ0X+5ptMp8jk52NfkwCloKOv0RXpmE2wQsAozrUW19veZS/b4w41cZJ7PZLPPmBIQ1h7hS73Xy+ts=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(3023799007)(55112099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXpoenRUVitLbVJRUzkyRHZQSUx1ZmJTZW9RNHd5OFVKQWJ0VmFlV0NXaUgy?=
 =?utf-8?B?OElydFl2aE93MnFhQjNVbUovbVUxbEZOOFBYZVo5YVo1RWdJRjUxWEVhcGFr?=
 =?utf-8?B?SGRpem9seTQ5RUVORW1LZTBtdllIUWl5NHdQMHhtT0wyYnBHRVkzYm5RUTVr?=
 =?utf-8?B?bi9sbHVIU01jeEhVMTJTa1FBSTFKc2JVZkhTS2NBb1NHRHk0OTNvWDdLbDEr?=
 =?utf-8?B?M1ZtRDkyZS9vdXpjamxSRWdSSnJ2UXZFRWVNaFlMZ3ZkN0ZGU3pMTjhKUnhV?=
 =?utf-8?B?MWNESUluK3Q3NkttdUVVeGViUlV1TzhsS09jTFkrOCtmYy8zLy9PYjRiWjlQ?=
 =?utf-8?B?UHFGaTFQbmlHMXlYYlRKTU8wWlJxbEg5eFgvQUY1ZG9VSGVzUXg0OGhLK3V6?=
 =?utf-8?B?N21KS1pmTHdCbXZnVkw4b0tWT1NqaFZmcHJ1ZW51NE9TQzdqNXVjWU5wbXVK?=
 =?utf-8?B?NmZCdEZJOE54YXZvRHhjaWNEcXNjOXFLdWhnczEwVmpYc3ZWWmJtYWR1QzRX?=
 =?utf-8?B?bHpoV3R6NWdrMWxtSlNpeU9nVlhNTDFjcGJlV2pTUitlbEV6bDgycjBTYXZN?=
 =?utf-8?B?aE81Q2NUcUgxNHR2ZW52bHNhdHF4YjYvWGRPZk1ML3J3amVaYmlaVElRSUEv?=
 =?utf-8?B?R21FSHR6WWx2aUR5SVFXV3k2WlJyKzNaWkZOU0xwMzg5UCtEYVdFM2xYejhr?=
 =?utf-8?B?SnZLMU9DUWVocC9jQ0s2UlNGVFpLMFBvMDlzNTVvYnRseEgwMTV6N0tMRGl3?=
 =?utf-8?B?aWFNa1hoV3ZTbGNZbVl5Q2hIa2pzR0hkOVNGb1d3aWpxRXlXUjZCVDZtaTFt?=
 =?utf-8?B?bGh1Uzl2SThqancvdGgrMTNoMmVVU1lIOHJENUk5cmpMU0YzYnNwODFwbmdr?=
 =?utf-8?B?MkMrYnJob1JzdHFzRi9Id0NDTURWbEl4OVJtR0tUTXhMYUwybE4vZ0E2TjdK?=
 =?utf-8?B?MHVYNmVjUjNuLzJERThSSEpYWW1aZCttSDYveHhrQ2s4b1B3VGhxL3FDRk5Y?=
 =?utf-8?B?cVJEODJuY29PTTlBbUhXSlRLU3VBL0RDdW52RUQ1ajUvM1ZQQ2hNdGh4d3hL?=
 =?utf-8?B?bjhpbTNDSndDeXp1WGhTMWllaTQvc2pmV2tNMFV4bThFVnQ3VDExaDV5V01O?=
 =?utf-8?B?dEV1T0xWRjBUUjZoaHlGR3J1dDVBbXAxdXl3RHhEZ3RqSmJiQTdoUU01UHdw?=
 =?utf-8?B?ei9PLy9QM1p1Y212SnZoUHl4djZ2MTYvNXJ0RG9qZG9pK0dlRnhUSE1tR0Zs?=
 =?utf-8?B?TzJTYkpURzJtQTRQbGZCYW5mNmtGQm5RWXJGbzJhc2xYTG1ZV2Y4SFNRV2Rx?=
 =?utf-8?B?TTdlRmExT0picGJpQnlqT1Z0MXZmODQvMVJteEJEZEVDQVlaaFEwZTJvdWFm?=
 =?utf-8?B?YXJjNnA5ZFJTNlBVbUt0RVd3MVBWM3B1aG94QWwzM285aHhVMUtXWWl2S0I4?=
 =?utf-8?B?MU1pb0cyNy83V09pcEJKb3QrNWZZQlNhSnM2ckV2ZTRpQ01SNjc4a1RSZ1pz?=
 =?utf-8?B?VVgyOUhTZlhMOWJkNmF2dk41SFZEMnVjYi82RmtVdTN2RWJVQW8rQnNFaHVz?=
 =?utf-8?B?dFFnUjJYcWUxSWVDOGlYeGJQb01VaThkbFpxZVJzUW5pYm5lenFWSGRkWU5W?=
 =?utf-8?B?cU9HclNsN3VnRHUwaC9nc2IxNnVpamFXRi95ejJpaWdjSTJyaHZGVlBZVVNM?=
 =?utf-8?B?ck5leFZwczhOQXlBMmU1eVl1ektSNjVSTmtNTHdnd3U2dVpSU2h2UlRITnpr?=
 =?utf-8?B?SmQveDBya01mZ01NVEVTeHB5cVhybXFMNVFNS1pNd1RVWXhEcHgySHIxTitW?=
 =?utf-8?B?UVN5QXA2bGV2emF1M2RpQ2pMRVpDcm1OampVTSsxQTNpK2diandkMTZEM1lx?=
 =?utf-8?B?MTAwN1NVWGRieFhmL0FvTndCbStQbENXVmVPMXg5enl1UkFMRDlENWptRWtt?=
 =?utf-8?B?bGhWeENIK28rbjdjSkdseWFMdHlVYU9EZnZYWmt3bC9Qd3pDdWR5YmNEVlMv?=
 =?utf-8?B?OWF0RE1EcU1acVdFOURKZWV3ekRiUEkxRFZTNjFId0hLWDJYbmxISmVFNUw2?=
 =?utf-8?B?dXdYazEwK0JmMW9SY0x0YVkzODA5VkJBVTZSck1CTTIrN2I4QTJoc1FYMU1U?=
 =?utf-8?B?aTlXSExvV21OOXFOUlRTRFR1dXJ6L3BYeElnWVFyU1NLcEJOOU5weWphSHRP?=
 =?utf-8?B?eW9jcTY5M2llWXFvOXlHN0tuVjlsbnRkMlBjUU1vWUNwTHQzQnc5Y3FVTXMr?=
 =?utf-8?B?Z1JxVW1WSDJ5ekREU0ZOaGt1dGRMOUQ5Zm5uTGlTVzcvN28yelo4bnVDbGtZ?=
 =?utf-8?B?c3dqeUtKbXNGRFJjZG1tYWNjTXVCZmlrUnVwODZGRWFzNEZ3Y0ZuQlQ0SkJW?=
 =?utf-8?Q?puLlsgTAC9dfybktQJKTcpa8VXxHprvg6FvPD?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e44c1cd-86b9-44c9-bb84-08deea320e99
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 09:49:45.2015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Dmqf7ce+I/1RJ4XpTNX23yNh7BnLINOyfpRKcnDcO09sK4VhunVgMDPRSd8hlodv3npmUQMGpJUZWkh00ScDZWW+ne52cFiwzCLZrYSWtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7035
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=difmFp+6FIEW+J1NnCLP76OJXJ9VZMk/Pzb3/oTB1TE=;
 b=aQ6xcXvs0Yqs6K+ODbITW0bJwD99FB5zPehPiybT1bxM9SYIsm9IXfzYHqKtb/rzWi8uhdeE5X2ngpIkZ2RkRHMntRAOiYsLQTK8qPKsJDqdP7Vc5tmCYrd2jHHErtcA8tlCn1kdkkwYDeeES+9KOOxI/1Wva84QTmXQS+UEbM/2RTyMNH2IyWKBSgldKd91gLc6gxhxPFnz2t4I0Np6qA0K1vC3IVFNCuvmT3/iRGWtbdChIK3K2i4oxaW/UGzn1lDfZalWrnYxNyFQWp26KleEkEaK/bgoI5hgH1SR4shUgz2y3vJUzeZ5ZXqNIyikStQtUE1H+Zc+h5zBvc8j+A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=aQ6xcXvs
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="aQ6xcXvs"; 
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
From: "Yuslaimi, Alif Zakuan via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Brian,

On 24/7/2026 6:25 pm, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> On Fri, Jul 24, 2026 at 12:09 PM Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com> wrote:
>>
>> Hello Brian,
>>
>> On 23/7/2026 4:59 pm, Sune Brian wrote:
>>> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>>>
>>> HI Alif,
>>>
>>> Just reminding, duplicated patch:
>>>
>>> https://patchwork.ozlabs.org/project/uboot/patch/20260407153650.26404-1-briansune@gmail.com/.
>>>
>>> Which is under reviewed.
>>>
>>> Thanks,
>>> Brian
>>>
> 
> Hi Alif,
> 
> My original patch does grep the entire u-boot repository and update it.
> However how T.F. redo that patch or any missing I did not double check
> again.
> Tom also noticed the new board's naming update is missing and updated
> the naming as well.
> After the patch applied, the board.c did not notice the missing renaming
> but only the PL330.
> 
> I am okay with the old patch removal due to the title not properly formed.
> I also suggest doing a full grep again to verify any missing.
> 
> Thanks,
> Brian
> 
After grepping the whole repository I found that only these two files 
needed fixing.

Since this is already under Tom's radar, and your patch has already been 
submitted and reviewed earlier, I think we can reject my patch here.

Thanks,
Alif

>> Thanks for the heads up. How about the fix for
>> arch/arm/mach-socfpga/board.c?
>>
>> Best regards,
>> Alif
>>
>>> On Thu, Jul 23, 2026 at 10:43 AM <alif.zakuan.yuslaimi@altera.com> wrote:
>>>>
>>>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>>>
>>>> Commit 62f7a9460209 ("Replace TARGET namespace and cleanup properly")
>>>> replaces the TARGET namespace to ARCH for all SoCFPGA devices.
>>>>
>>>> Some of the TARGET namespaces are still left out, update leftover TARGET
>>>> to ARCH following current SoCFPGA naming.
>>>>
>>>> Fixes: 62f7a9460209 ("Replace TARGET namespace and cleanup properly")
>>>>
>>>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>>> ---
>>>>    arch/arm/mach-socfpga/board.c | 4 ++--
>>>>    cmd/Kconfig                   | 2 +-
>>>>    2 files changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
>>>> index b202ca258bc..b662afc1ad7 100644
>>>> --- a/arch/arm/mach-socfpga/board.c
>>>> +++ b/arch/arm/mach-socfpga/board.c
>>>> @@ -210,8 +210,8 @@ void lmb_arch_add_memory(void)
>>>>    }
>>>>    #endif
>>>>
>>>> -#if (defined(CONFIG_TARGET_SOCFPGA_ARRIA10) || \
>>>> -     defined(CONFIG_TARGET_SOCFPGA_GEN5)) && defined(CONFIG_XPL_BUILD)
>>>> +#if (defined(CONFIG_ARCH_SOCFPGA_ARRIA10) || \
>>>> +     defined(CONFIG_ARCH_SOCFPGA_GEN5)) && defined(CONFIG_XPL_BUILD)
>>>>    unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
>>>>                                                    unsigned long raw_sect)
>>>>    {
>>>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>>>> index 35ce42f8397..b724f4f8d49 100644
>>>> --- a/cmd/Kconfig
>>>> +++ b/cmd/Kconfig
>>>> @@ -1911,7 +1911,7 @@ menu "Shell scripting commands"
>>>>
>>>>    config CMD_C5_PL330_DMA
>>>>           bool "Release Reset DMA Channels for PL330 Handshake"
>>>> -       depends on TARGET_SOCFPGA_CYCLONE5
>>>> +       depends on ARCH_SOCFPGA_CYCLONE5
>>>>           help
>>>>             Provides access to Reset Manager Per2ModRst. Enables DMA
>>>>             channels for ARM PrimeCell PL330 via reset release.
>>>> --
>>>> 2.43.7
>>>>
>>

