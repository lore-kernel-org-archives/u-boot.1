Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41164606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g/er7kcy;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=CAyMSnV0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10B32409E9;
	Fri, 27 Nov 2026 13:58:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qGbDYI_R7ej4; Fri, 27 Nov 2026 13:58:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3F63C409AF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795787923;
	b=WeQDzEd7O2v08J0jhAmIRKy7tEgU348l3Xv9ORv3Dzc4fHjbI4RgpRG3JpfI6ykTbgKx
	 onePiXjskbz6LfTFf1ezLuym/lUz0Mt2WzVf3HytRi+eb6v5M2/vdd/gQkt+6UTMLmNWf
	 tztzpfIsWZZAV+cg2j0amK2W0iV859naFtbyKMx9qzQpPvrwBXJ2N3+WCPAhX/KxvngiX
	 qKNZQK+E1XQ1+ykW3HqBL42rgX4624XqabqeJPTlnyI51iXq4XEbc9eoyHgrEBIws+Aeg
	 3OwNTq1QnprjuV+zGei/TdYlLv+TYapRs1+dhONHXRXT60/AXwU48KJCqrzvFHk8J0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795787923;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=z4Rv01MxtGK7ERJdxZyLgxOCDuo1gfWp7fQGmvUmR9U=;
	b=Kr0PgMrtuJuZPPOKYApQRiqrjdBYKA6HmFFhRr2g1Z12STJV+pJ5X45sHx0tiwg8Fh/W
	 Vxh9dQ4IgFdQPvGu9SGvFlYYCSM0f3B/0FZrAHJMoixkYVELktHjzlxuJ7IciAXfG9Pb0
	 +1Qn9D/DznPjL3CAdC0TWYkhLTAHfWbIm8QNgwJFplgHuyA8wZw/AN2T7l3vi7LsPE/0P
	 +LZNHqOPrZGg9R4QxiMTcPz4o6PIlehAHwEnK35u94QJop8wUIPtgl6s3BTOtICOzQYQ9
	 Pfz/MXApedBP8OIxWL0ywbDeFr+hM2iPXcZ1jCLgV+K1jLF0lCPQRQd1nWAXq8nxkbQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=CAyMSnV0;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795787923;
	bh=z4Rv01MxtGK7ERJdxZyLgxOCDuo1gfWp7fQGmvUmR9U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g/er7kcysVZgTLK70zToUj/avrZ3AniU1h2LuncHvwUkZ3+RuxCAr0ULqzbzjqkNE
	 a76jOkXUzQNXj3W7qYcXJandt7TNnH5Us+l4NIDzb0H0SK9mHO+DPj9gDTxhBAVUJQ
	 +krvxM/bh3x5KRex/9utCa+8G7Pr4gMORz0sKUqqDOO3+Jg2DQ8sQFQy7HHLiQRx08
	 zi1aJRczDuVHoiGbNbD29SjjaryclJjB9UVv8qODFtJVxgCgzwyD4Qzt/0yD5xJIaY
	 w7Y+NEm1LhD57Qqoi6dAqq+MhmJTByZCU/Ze/pOYlU+s3wVWxOk8YcrDOGT2h9SSNj
	 wiEwkOAfUcWbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F63C409AF;
	Fri, 27 Nov 2026 13:58:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 02B5F311
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:58:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC80D409BA
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:58:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rMVfMKDtHzpE for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:58:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BA42F409AE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=CAyMSnV0
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BA42F409AE
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4Rv01MxtGK7ERJdxZyLgxOCDuo1gfWp7fQGmvUmR9U=;
 b=CAyMSnV0DP/0RknbDHbHf2B8UEY/VqzJvXL2b99cfWXDRCVf5kMQVu20RK4bIpjbndP4R24wxueQnlXXDte8uVU2HysBYaFre3ueF76wGSm7bT0Pno3Ge53N5YV2c2eeiWsVqISOK5N13n832v4+4wfbM7Ri4P59YmQH1jzofVU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MMZPR04MB345699.eurprd04.prod.outlook.com (2603:10a6:190:51::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 13:58:34 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 13:58:34 +0000
Message-ID: <93a0cc9d-4705-4fba-b55e-074aaa66f701@cherry.de>
Date: Fri, 27 Nov 2026 14:58:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] ata: dwc_ahci: get the PHY from the sata-port
 subnodes if any
To: ricardo@pardini.net, u-boot@lists.u-boot-project.org,
 Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Eugen Hristev <ehristev@kernel.org>, Jon Lin <jon.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>
References: <20261127-rk3588-sata-fixes-v2027-01-v2-0-dbdf7770972a@pardini.net>
 <20261127-rk3588-sata-fixes-v2027-01-v2-2-dbdf7770972a@pardini.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261127-rk3588-sata-fixes-v2027-01-v2-2-dbdf7770972a@pardini.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1PR01CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::27) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MMZPR04MB345699:EE_
X-MS-Office365-Filtering-Correlation-Id: dff24611-aff4-4d99-7508-08df4c8e8706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|4143699003|6133799003|18002099003|22082099003|4133799003|11063799006|10067099003|56012099006|261026140227099003|261026130827099003|261026121527099003|261026135527099003|261028144727099003|261102123227099003|261022075727099003|261022113327099003|261022115727099003|261022105027099003|261021123027099003|261021121427099003|261021130227099003|261021135927099003|261021133027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: /PW3gifKIYC2+SX9ar2HEq6FTu7S6nK0qhVw+c0078cJbK7S7y5kf8jMJircp5R8MhUdM0jceu41vDq84l5ktM+dSvnVKNQmjFK3UyPDY911B1b9b7kHVpWm4KrY7IDuunIq5uQ07NAenq8+rzLZjVHmw4nxGqkj/XKE2PkqZj1SOb+DvoWByU4fbGXWFFHQ8qnHtWMSCcwYo205uJFm5PcOllaIWpbCALsu/EO3i4brEz1ybCySXMHb9v6Yjwm+ZiZ3VBtkzy7aSj5nT96HVruIgzG7369ZsSSASqXTLxOTPUI3yu+kS6ghz0iszbpqRZ6CGFWf7eeSIE3HzIEHKE4+MBCfTaON3uDmofnJi3nYBDL1OzceoaxHv2c7uhP3s3d/Ou+rywH4iU069BMwBKBN8c8XsgFsRLXk1XZBsvbZrOq4hsKYcWRYr5EecfUUfvSbyy66XiLGwjBZhirSX7tN7p4pFdtGrx21lPiQseHIIsO6D1JTwpoJZ+Jzv8h7d756vjJNAuY4+CEvpd9XTzCEnjsZ6gUqm1314rrrkhPDjoC0XSSGdddi0SStVETT7RN14SjuRCGbfnMx9NTE6KFXQfdjYIADpz4JJzAEtbIaOarhgCuiRgKs355UqmL6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(4143699003)(6133799003)(18002099003)(22082099003)(4133799003)(11063799006)(10067099003)(56012099006)(261026140227099003)(261026130827099003)(261026121527099003)(261026135527099003)(261028144727099003)(261102123227099003)(261022075727099003)(261022113327099003)(261022115727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261021130227099003)(261021135927099003)(261021133027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXlHclcyTUhFTVZsUWZERHZCY0Z1QWpnbStDUkRXeTlZdFNUQkNPclZVanhK?=
 =?utf-8?B?dFR4eTcvU0lSV09EcDhtVGxPc3BIRDJYakU0b3YreERaOWlKSi8raEZXV25Y?=
 =?utf-8?B?UzkxbHkvd0pCZ2tpWlQyRldVd3dRZXZudWNCN2xjRnI3RFg1Rk1wMUZaK0FU?=
 =?utf-8?B?TWVLajFrTW5rb3Q3blZvV0JqZExubzRQU0UyNHlNanRsYk8rcWl0MllydEVo?=
 =?utf-8?B?eS9yYnk1MVlyQXNjNCtlWnFrcWRvd2o1SnBjWXZHSzFTQ1ZMbXN3WUZxZVhV?=
 =?utf-8?B?KzFkczlrMGxpWVI4Q0FmZEw3WW5IaGw2eE5QcUdQMkJOb1AzbVdCUmUwZ3pT?=
 =?utf-8?B?SlNTZ1pRNG04UytuN1dVRXQ0VUNvSWdFMjdzRkp0U1FUS1B4b0U3ak4ySGRG?=
 =?utf-8?B?bFNKY3VLL1NkMnFpZ2wvYXNWaFNVSnV0bjQ3VWZIQnZOM1JVSGlKQldVanNN?=
 =?utf-8?B?MVpPcUZRdzVMTklNTXR4NWtmN3E3SjIwZkh2Y3ZKQW1pQnVQSjZ5K09ubTlM?=
 =?utf-8?B?SHdhOTFlTE1pY3lzbFIrYjRVR0p6VTZpU0pvaDR6QVo2NnFGaE9xYTh1YmRQ?=
 =?utf-8?B?WW5PeUE2S09wWXdvWm15dFE2MExIVjhubDcyNGM1d3ZheDMvQ1hoODRvNjFP?=
 =?utf-8?B?L0pIQVVGRlB2bnhaMi91Zkd3clFUVkIydnRUUTlFRW1aMU5qdDY3RENuMWVI?=
 =?utf-8?B?Y1RRWnE2VzRjdnhjVnBscW16N2Y2Wm1UcXZra0Ruc1NuTlhCMHR5SXJVcnhR?=
 =?utf-8?B?elVMbkFVTzIrT0NBUlRCckFTaDdHQzJKVHpPVjZqTGVTdXl5SXZ0NHpvQW1R?=
 =?utf-8?B?T1JqT3FueVBpRE5MSCtsMDlMRXg2UUN2TGtJV0RqTkM0SWJGVkNvRnlQM3Ny?=
 =?utf-8?B?ZkNmOU9TSkY0dWZUd2RYbnFNZGVhclNtTlkxQk1kSmt6N0l3TnBGZE45UGlI?=
 =?utf-8?B?RXNoR0xDTDExMzJlZWpEUHdNQmg0TTZ3ZmtCaWJ2bytlZFJNczVkeXBpdHV3?=
 =?utf-8?B?L1FDcThjcjZBT29XSkQzU3hKY3V2R3REU2I3L0dKWmxPWmt0SG5WT0hPVUlW?=
 =?utf-8?B?bFpDSVVRUlhGZ3MwWllpaWFHbi9IRm9SelJrUkVRaGJLcCtEMm5VSE1vbXdk?=
 =?utf-8?B?RVZXOTY0VUhadVVXZTlibDVFSkQxdUFsL1pvSFFpRXd1cW10ZmxYVlgwd25D?=
 =?utf-8?B?VFBOaHBiSXR3OStneE1BWXE2TnkyTGtrUW40VWJBYU1WTEVwUFd2S25Ccjlu?=
 =?utf-8?B?d1hjdndsek1sVEI2dy9jejlicktZN2g2dlBoRHJPRW1wNkNKRU1PbVNuMDlk?=
 =?utf-8?B?cFpuVzRocENiZzdLTGNUT3liYU5aanJVUHVJL1dad0FBNlJ0SFZUZHpGZzNT?=
 =?utf-8?B?NGFUSjhVSEE3WDNmbjNxbUhZQUsrMTM0UDRUQVV2MVYrcEQvUFZka0FhTWFT?=
 =?utf-8?B?KzR0VUFOOXo0WVpibTdoUXB4UU9ubi9TR2ltS2hnWWI3bDhMYXdVYjNsSjIy?=
 =?utf-8?B?U2Z0NHpIeFlwN0pFbFdKQXRlSEtIQ0VHUnhZMTNLZEdIVTV3dUFnQ21zVnFS?=
 =?utf-8?B?eDh4UzYrVWU2aWJXaDZ3L3VWMVk5UjNWWUQ4RVNreDhCZStUZUtLeU0wWjY5?=
 =?utf-8?B?VnpjUmFlbm9iekoycU9OajJ2MzJuUDM0NHNUOWJ3OG16NVE2eDV2UUc0M1Vx?=
 =?utf-8?B?Tm9PaE90bHNjS0NYRFVwWkVnMUo3WkJQT2x0a3p2UHhDcHQwcWpiTmo5cTZx?=
 =?utf-8?B?R2MxaWtXVmF5ZXZrYTY0KzJVQVZIWUNXTFRvTXZ6eS92RXBMaVdWUUNXbEFh?=
 =?utf-8?B?bmJWZisreitHZk1tUC95bnZCbGFPSzhZejhEdStGTHMrTkFHRW5UTGFjNDdF?=
 =?utf-8?B?ckZoK2lZVVhtaHRpTGdJcHBtd0dIeUdFYlV4bExFSDhqQS9UdEp4cDAxemg5?=
 =?utf-8?B?NXJkR2V4REM1cjAwazFwamM2ZFlsb2QrV3RZektKTlI1bE1SL0xud3RCbEdK?=
 =?utf-8?B?cDdJMDdPRkYyOC9qVWUrNHJ6NlJSeWdBcU9SckZQRmFnK1ZlSFYxano4emFY?=
 =?utf-8?B?RWViNFNuSDFtcjkwQmgwRU1zTEdTeFFickwvTWphdHhTT3FTL0NnbTdpY1Z6?=
 =?utf-8?B?bE40RjJvSnVzdXpHRlo3bFYxQ3RLbDdQRWhrOEd6ODV5Z0FvUVZza1o4THJS?=
 =?utf-8?B?b1JGeHFWbVZ1RjZJR20xZGg2NG8wbUFzeU5MYXk0MXJ0WGZLNUt1UExRR0I3?=
 =?utf-8?B?NkpTMXJRZkdySThUcERCVUZSZ0JiMHgrRk9acXhRamtZODZSS3BIakl4czdT?=
 =?utf-8?B?bVdzeDdLU0ZjcjI4RTVhM3FDWnJZS2JLdFAvb3hoQ09uVVBSOTJmUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dff24611-aff4-4d99-7508-08df4c8e8706
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:58:34.5544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3OUrXrJUcYDSI3kPSOmgYA4bnYVUeLneXbpqBXws0qdDu2kPR9DRG6rzNMyTmwGNIXEuWdMCrF9VY/gda6OnPRtpKGZkYdkMAsGo8mnSSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB345699
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ricardo,

On 11/27/26 2:12 PM, Ricardo Pardini via B4 Relay wrote:
> From: Ricardo Pardini <ricardo@pardini.net>
> 
> If the controller node has sata-port subnodes, take the PHY of the
> first enabled one instead, like Linux's libahci_platform does.
> 
> This fixes probing on RK3588 and on RK356x sata1/sata2, whose DTs
> have the PHY in sata-port@0.
> 
> Link: https://patch.msgid.link/20260201191804.41421-2-heiko@sntech.de
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Ricardo Pardini <ricardo@pardini.net>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
