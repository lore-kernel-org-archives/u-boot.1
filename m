Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9B0C4453D
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 04:09:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07C8E409F3;
	Fri, 24 Jul 2026 04:09:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1gtViQuCMoqD; Fri, 24 Jul 2026 04:09:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1340340A37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784866193;
	bh=TQyLdoppCrN5cmUR4piOOnLRggwg9HTyy/y3/bCEr+w=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=gInfd5ay2QfspNap4mtpIdbj+3bjbsVBzR1rXkfMGXK30+PASO//8dagGgjA+K8t0
	 TG6KJ1/ExrEOPpnBxnDnXWz8HixKgnr8ALfjlGWsof1AdO4RTyY6eelLpajah1TkYL
	 q45NzpfeMzru/2WxvePkhc/97qwYTCn4BD44iHVlPesq4CuFmVdM6Oautfu7EeeB88
	 +fYNp7N+5hrraU4jGxWLNbVmWheaSmlf6sfDi8MhJnPBDGwzkgK7udgjbH8Fj47Mfv
	 ja4u7pI83fcd97EO1oeFeNjhpjo72U5yfYy21eCahukXkTNAGRzOVI8m2knJIwtHLR
	 qVhgFlRvo3gNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1340340A37;
	Fri, 24 Jul 2026 04:09:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D6ECF3B0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 04:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D47C160B0D
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 04:09:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3NZIEHYkCH2I for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 04:09:51 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=alif.zakuan.yuslaimi@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 85BA3607A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85BA3607A3
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85BA3607A3
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 04:09:49 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB2B803F6; Fri, 24 Jul 2026 06:09:44 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A7DE800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 06:09:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDzBZzoGO2tlt4DWiMKVX3lhBbSUcP3jzcvrEGIm388TIemP0FkP6Iy93qjC9aH9GvQhEC6livaHNdd1tTxou1Xlpepc49fN08ij+KSNBpTB/xZumwUA4WKhAlCbLEAvc4lcEaiAyE4Yhg6mP5MvXJyOSGZ/di7FXmsq68itk9AiwET5hQg5mTEDN2SNhYNi0sG2LPQ+hZ5cyz7IV/UQdJcteb9cnI2EmQroviKhubTnjarufBW9RguNe0i8Jmz65YXiwT5wZForFpnkPprsmmIoWxxRkwSPJbFnV52H65RPkvncDT/zhDZnwxSBgEK7ZceFCzKnZauakPWScI33gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQyLdoppCrN5cmUR4piOOnLRggwg9HTyy/y3/bCEr+w=;
 b=GDUocJRONjGs/eRR3bEk5VPh2LXmPF96W2gE7546C+RZMWSc/pxvLhO7VK+1DVeFwZK/DUBKYMgJlHzIdyBttsz+JMCUJgRdYMTW658yCMcS1ub6HDui/MmeRg60pXsXdBKGQaqA0owvjfCoQZfiSbD8oVdn9PdIIRtdBR1/ZwZPhneD2E7rJElNEXf/47QPj/4iMFdVujCT0/AO/H5EoTg8P+NlENHu3SMfVs2oNHajVDBw2N3fHdWNn/YnJtRDv/M5GVbxMhXDoOZtZcDyx6QyQfgWMHphJn4BelWgOgmNiKCPDKF5UJTdDDniXlInKNqA5xQTvZnVygV7RqKsZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA1PR03MB6372.namprd03.prod.outlook.com (2603:10b6:806:1b7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 04:09:36 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 04:09:36 +0000
Message-ID: <a4a2481c-fa1f-411c-ac21-380b3a35a4c2@altera.com>
Date: Fri, 24 Jul 2026 12:09:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: socfpga: Rename TARGET to ARCH for SoCFPGA
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Anshul Dalal
 <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Johan Jonker <jbx6244@gmail.com>
References: <20260723024306.9888-1-alif.zakuan.yuslaimi@altera.com>
 <CAN7C2SDhSzVabXx+EswLksHbQSEyK4GxgkgUVG7Z3Kx7RdS6JA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAN7C2SDhSzVabXx+EswLksHbQSEyK4GxgkgUVG7Z3Kx7RdS6JA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA1PR03MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: 168d7ea7-d883-4b54-e49f-08dee9395fa8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|10067099003|4143699003|3023799007|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: vbGBDwDyU/yqz1OBmxVcpeOQIGk1MTB2DNRP9kfaaXeZbh8FvYjIBq1ItaeUKHpJMKboQb8LBwCs8NSorg8i04WTJtEHgA8kgkxupTKVfYKb5jl09U/+9HE1UTf3tNyDwbsHyJuXfgBKdOsJEByk/v3W4n/eQ5QsujJS0g+5dGMwZSdlg0lkmyOFZf6MpBeoSdO/HbbTUaJ+rloCcN2TQTBjZQlL7N2OlQPfr/5ZHOLk3kRBzb8xHLzPE54vMpEd+3aIFMPIcwilb+4SlnZwuZ2Hr9fKmfeqU8tQgnG5PmL+h7MpwIR8x+CSQVAjcn+J32UTWxk3k59ArPWL8UbKsvP/u1bmMfP2ly0sGawCoYTb/T4ZaQPo5icGr+sAMncesNE+8oEsCHoL1aApVNQ46+a3PcnsU+lq3oe7jCA35RDXlhl5LrQxipa/Mog7rwKxYZEkutNljmyYRdsZ5Vn5Kzct+oidJ7/zXI7U5KVR/AV80QQJ+dRdj6ynR8K+M1WErkp2P7Ou23rVj2/BnXiawDFTce2f7yhDdVTmshLTYWQCncrh9J5dE4fRqyeSvYo6WBzUuQXRK/39ltyHzoB2qiu2w1mOn1DJ49GOlBjiwIDOU73hGH2YbqQJalQGbOUx9PVi1/u3Ch7zK91bMjzYs2HEpjBAUWSAh/OEoK+I0yI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(4143699003)(3023799007)(22082099003)(55112099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW93dVVDNVptWlRkUGFFZnJ6RE5rQm5kSUNYcGx3MG5SUEtZUUs2T3BFcXNp?=
 =?utf-8?B?K3BLUnpFOUJnaHZvNFBNaUdZN2xLOTBKZTR4Snk5TVVZMGRFdkZKdStZdXpm?=
 =?utf-8?B?dUZnTEk3WElCV2RBazZDZnB6TnZiampvM1pmaFBNVjVHNkYrVTdFSTZaK3Ri?=
 =?utf-8?B?ZXVEenBGZ1NMbVppb2tDWHUxVFpkd09mUFpVNzVkN0lkNEd2a29SZ1RudnNq?=
 =?utf-8?B?NkZreXRhRlhyTjdEWU9yaFlVc2hSZUZqUW92K0lSNVk5RS9VNG5FYXpkNkow?=
 =?utf-8?B?MGFHVnhjY1M1RzRYVTRWNnlYTGxXQ0ZlVmNCeVQwL2RsUFE4aXV0QzdBYkJB?=
 =?utf-8?B?YjF1R0lVby9sUEdRRjA3S3JOT2NBWFdSK1ZqV2lNcUhOQWJhaGZaRndDMlZR?=
 =?utf-8?B?UEQwR001NlVndnNmNVNHSStoMndXYitCUXZweDNnMnpFaFEwb2RPTFR0QmlH?=
 =?utf-8?B?UVN4UGZiUmRIS21OYytQbEJmRnJMVkhvcHE0YjZVTzFrRnJXYVcvaytpN2ls?=
 =?utf-8?B?a29ISDhLYWRXRnhpVmpzaFYyS1ZlRThMeU1uUWFSSVdYc25WQW41MFpEeEhl?=
 =?utf-8?B?VmFnQkoxcTR5K3FKMG1FazhzVUYyYVl1ZlU1ZGJUcSthYUp0eXpOK0RTWXJF?=
 =?utf-8?B?L3VOSTZ4M1gzT3ZaQ0JKVnYrUit3NTFsWkJMNlNRRExQYnp4ODNNdndOa0Jm?=
 =?utf-8?B?blhkdkVWUzlWbi8vZGxYSmJXNVNKelMrZitaR2lMUUloTVVqSWVQVGZ4Vkh3?=
 =?utf-8?B?dDQxUUtGR3dmVHFqVVhEbTNFUzdMeFdnQVVoOUZFbWIzZFRhaEJGN0hLYmRG?=
 =?utf-8?B?VlZiVXJBUjA0N0hqUlFLMmFMK05pN0VXbVF5Z0Z0QkFsazFOQ0dlODIvOUN5?=
 =?utf-8?B?VE1NdVpKdVZXOVMxQndHb2RjclRiUUljVE5WZndQV0tKTDh6ejdKZXF1eEdE?=
 =?utf-8?B?YzdHQ0lCMDF6ZjJlVGF4ZFBlRnZBcTZySEFtamNBQXcyWGEzVDBJM0wvcUZ1?=
 =?utf-8?B?ckdycWIwbWJvUHJrSmFDUlhvd25MWVVuR3RLcVRPUDFudkpWamZMTCtmQTJz?=
 =?utf-8?B?SE1RT2xnU0VGK3BCNXhlRU9VeWV1TzJ5MjNaYzlTZlpNcU5Hd0ZJa2x2ZkIr?=
 =?utf-8?B?UmtnbVdya1FEQ2JRc3h5YytMVVIyblFLQWVFTldmeUpSZWdIQXpZcmgxWi9r?=
 =?utf-8?B?UTJzNkNCNFEwMDZhMEliN0RXdGZyN25IRGF1RmtKclVLNC9VNWgwaWJUUUdZ?=
 =?utf-8?B?Q0s1dlRtQTFZM2VFNHNZa0xYQVc3OWFSZkVTbnhybHNNS2E2VWhrSkdEbnEw?=
 =?utf-8?B?S3k1d3ZDUGdlNmppZlZ1anVTT3ZYQ2tYSWdMd3RXNENNRU1ZdGJoWnEveW5P?=
 =?utf-8?B?TVQ3d2pkT0NZekgreVEwRnFFSTBLWEFYdUt2VmJPaXF5MWwyTkE4Wis2VHRZ?=
 =?utf-8?B?VVpad2lSZEJnTGhiakYxU3plQVVqS2lqcU9mQ1BydXNiaE4zekQ2NG1ZR1lY?=
 =?utf-8?B?MXplbzZ3Rk1YUTRXdC9zQ2Q0NDdIdUlreE0vK1kxTzhsc0JwT0NEZFA2UUo2?=
 =?utf-8?B?ZGhjYUZSTDNsak55RGd6RjlIalluSVdzZ0xXU29uSzc1RklBRVhrdUprZnRn?=
 =?utf-8?B?R3dEa3N5MnhxS3lrWmpSSXhkc1AybE1DU0tNZ091VGdKVnJxS3p0cW55UlhR?=
 =?utf-8?B?U3NsdE4weWlRTkVycDdBMzQrdnJndmJnWkpwVEhNeXloZTVCREtlT2VlN0hu?=
 =?utf-8?B?VGxCSGNqbDhHTmJBcUpDcitPbGR5M3ljTmJ5WERWRndwaWlNZlRaL2xhZXEz?=
 =?utf-8?B?bkJ5K3R1Z01yamNnV0FDTlYwR1dlZnJTVUU0UVVaKzdyOTJVQ2dTWlhpV0Za?=
 =?utf-8?B?Q2ZGaU9zTXdob3ZZMGlCNTBGRkNWcUw2VFA2amNTdmR6YlRPSHFaM3FVSU1y?=
 =?utf-8?B?blpzYzZmK2cwSFBIbnFwVEVvdWNMR2RBME4rMWxlTU54Ti9OTEZ5N1FaY2Js?=
 =?utf-8?B?d0ZpSElxZjZzeWtXNXRLOVN0MStOMnVZdFV6elZDK0lCeEJ5WHo2QVczK0JQ?=
 =?utf-8?B?SW5aQ09NMG1YbUdaZURZZGs4Z2lSMEYrZGRaTlJYSDJ2S1RmUEFLZk5BOHZG?=
 =?utf-8?B?UzhmQWlaK3pLNVdMdkNhb0Y1MnhiVm9sVXJRWHF2dFUrQk5YK29Hcm5ZMUlU?=
 =?utf-8?B?N1J1VVgvL293TkRSV0ZoelZFVnI1RE1aSHJHaUd2eStwTTBrOVUxUVE4dmZl?=
 =?utf-8?B?VFg4WWJyWXgrbUc3STBnRGV1OGhhWU5VSjV4cGMvSnFyeldQZWlQUDdnWnc0?=
 =?utf-8?B?ZDlucGFocG9SOTV3WkJ4UWJrTWRrbm0xMG1qSUZEUDFFWnFDaEdPN3gwY2I1?=
 =?utf-8?Q?hFzTQBxyfRnLEdOZ2GD+eXfxBjcZ7vUFYKyQu?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168d7ea7-d883-4b54-e49f-08dee9395fa8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 04:09:36.3828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vbleuh6NzZaiCg69/hLM1GUyOVQ1Zx3vWJK6urk507zDWpkQGfjtmJMWBYpfELJHWrtjw5fus0R6Gvrcqv+ThistQZoW2y4Y8rsNUW5fAIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6372
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQyLdoppCrN5cmUR4piOOnLRggwg9HTyy/y3/bCEr+w=;
 b=fZkjyG6JRPlJdg1VCTn/6DR1zYLVfsCUAy79f90PZTUGCtugRgLVxjXktcK/86miGq0DgylwRjogyGmmwhgwJiVu5s4jj/wGDF2voMpDKeyNYsUrZBv/8zV3MfmDQTnnXKr8hT2w2dQAshvtQljflOJnT7wzAmnMaOjUHDq4boG1IjOXyu/aUTU/G2kH9xgdcW69/B0rsouYS+sJCSjhWUnv2jzw7fSGDD2RocXZxHjZcfAq7j96n6w/F7sRohsZcEL6d73XG0QLsHAk8Ww5nWl0Xgy911psdgBuw741XxI7BzyYHcLQG5LOEnJtM/RnOtJAJphd/R9L33pEZE6Iag==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=fZkjyG6J
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="fZkjyG6J"; 
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

Hello Brian,

On 23/7/2026 4:59 pm, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> HI Alif,
> 
> Just reminding, duplicated patch:
> 
> https://patchwork.ozlabs.org/project/uboot/patch/20260407153650.26404-1-briansune@gmail.com/.
> 
> Which is under reviewed.
> 
> Thanks,
> Brian
> 
Thanks for the heads up. How about the fix for 
arch/arm/mach-socfpga/board.c?

Best regards,
Alif

> On Thu, Jul 23, 2026 at 10:43 AM <alif.zakuan.yuslaimi@altera.com> wrote:
>>
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> Commit 62f7a9460209 ("Replace TARGET namespace and cleanup properly")
>> replaces the TARGET namespace to ARCH for all SoCFPGA devices.
>>
>> Some of the TARGET namespaces are still left out, update leftover TARGET
>> to ARCH following current SoCFPGA naming.
>>
>> Fixes: 62f7a9460209 ("Replace TARGET namespace and cleanup properly")
>>
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>> ---
>>   arch/arm/mach-socfpga/board.c | 4 ++--
>>   cmd/Kconfig                   | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
>> index b202ca258bc..b662afc1ad7 100644
>> --- a/arch/arm/mach-socfpga/board.c
>> +++ b/arch/arm/mach-socfpga/board.c
>> @@ -210,8 +210,8 @@ void lmb_arch_add_memory(void)
>>   }
>>   #endif
>>
>> -#if (defined(CONFIG_TARGET_SOCFPGA_ARRIA10) || \
>> -     defined(CONFIG_TARGET_SOCFPGA_GEN5)) && defined(CONFIG_XPL_BUILD)
>> +#if (defined(CONFIG_ARCH_SOCFPGA_ARRIA10) || \
>> +     defined(CONFIG_ARCH_SOCFPGA_GEN5)) && defined(CONFIG_XPL_BUILD)
>>   unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
>>                                                   unsigned long raw_sect)
>>   {
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index 35ce42f8397..b724f4f8d49 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -1911,7 +1911,7 @@ menu "Shell scripting commands"
>>
>>   config CMD_C5_PL330_DMA
>>          bool "Release Reset DMA Channels for PL330 Handshake"
>> -       depends on TARGET_SOCFPGA_CYCLONE5
>> +       depends on ARCH_SOCFPGA_CYCLONE5
>>          help
>>            Provides access to Reset Manager Per2ModRst. Enables DMA
>>            channels for ARM PrimeCell PL330 via reset release.
>> --
>> 2.43.7
>>

