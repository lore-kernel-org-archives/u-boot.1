Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EEF606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p8Dpntuv;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GSxq/EGR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E693660725;
	Tue,  3 Nov 2026 07:02:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9_wfgLdRoySP; Tue,  3 Nov 2026 07:02:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DC53F60705
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793689346;
	b=R5yj9O/uKmxBbcbDh0nysMuqPp9bEfxWT2FMGLAJ9UEgFXQVbb9kNnjSkJL5337TkuON
	 z3cjVSRX1F6J4HEeMbDTtf/kVjhbx1Kiri8BLvcQYipKS9bJvLE5v5w8Kw1CxQyWsK0Nq
	 m7G5hgYExZ3KXMjBEuOBUv0XfjQMcnOkYbo+RMN2Ail8Jv73VR6hVslSdP12E7md3fScW
	 lI+xFKv0LcPFVY1MfDIsxH4z8aEROXHsfl98Uoz+R71g1d03zgOLaIOw/CxQt1JUbOAtx
	 0SWhAklDc4f6pja05n7ajxdN3hkuKd6PtLXPZpxqGJJAX4bzBda0hrrMS3CSsFHNBvA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793689346;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=h06bFs8Ai2pv7OHMSVMZfcHx1mv8ANXZPEECChOEY6A=;
	b=GkCqzr9tPMfWpdgqMOi5R19eWMdsDvielCNpuvUO2hx+ZjU85vaK6eSEEZy8rfRFeDGx
	 CnTwiJobx7tRi4Sz1hRIRJlx/YQ9SyubCl0wE8DvdlguZpEjZdYOzQX7+kWTyqAtC+6hB
	 ns01x+b50tu7HnlwolntDp4Cr7vikC78a8njRMAGG9af1u24jH2pNc1AbWk+Tp16ZzHhZ
	 nsxmm6Dlh2y5ZoQnGg8cpeom2Vvv/4ZLwKxH4redXLMAokgknL34jFfDMyKNi/pXOJ4ev
	 lWmUoJ641Jzub/uMCvbHiXeZViGK2/sZBD53SJCqd8zPjI8PpJ2XxoZsQDC1liY1dZQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793689346;
	bh=h06bFs8Ai2pv7OHMSVMZfcHx1mv8ANXZPEECChOEY6A=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p8DpntuvlSYzR9zpW+J71TL2UDNlSqSwtoOHwCl1GAKSEAJ4dUMTpm4FtAgz2H7vf
	 Fc3O4JkUgXBZN1vjIjzNXfSSzuWJLEpP/w8GFHP+Y9IuXMIk25X+y4qkyYOwI9RmVV
	 1HH56pXWWKLnYDppvtZpJQUJtdRdRQvtKd0VR6xGH2Y3VmTijHA4YGcjv5oaqKKZTZ
	 +kgzU94/KodViwSs9Y+RyohSR27ZMqKLGJION0N3K/E+Q3l+6IsC2RMt2tsLfw+1MQ
	 GPYv3SsM266kTIKbPcKBU1apDF1mvWU57BlzzdTzJKwBlueDqsb46I1ub6QnI2TZxG
	 KpyrIP1b7m/DA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC53F60705;
	Tue,  3 Nov 2026 07:02:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D35F74BC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:02:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B5DF380E32
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:02:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fvU9SMog-lR2 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:02:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9641B80E0D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793689343;
 b=AedPqwdIGD3BqLyBC8fKFiK6+EyiLNGiAvoVCYQFlBaRKKyQzUK5v2voHBWQtLpgKNrQ
 goraLz3mNaNfZ0XLRijMbvMOnwk1syR1Cu7UFvxBRzdEjMhybmrfK/TVs3d3dJ+rx6aya
 K0vaacfxgblZenP8XYZxkEnJ0IG/4fgHiO4X46BENXK+QDSUMFlGvRov5K9ckfbF9FDde
 t5/9xKtczRrugOUSKAvXfAC5DXJsQBBlfgYo1SjeSk18uYwNwu1BFOf3uAcX+HT57lmQ2
 2ie856UETsQ0UUFgT813pVt0Z1zSOEgz7N5fJAGYq6AsZvHTgo8uINKgJGlRy9/MLCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793689343;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:From:To:Cc:References:Content-Language:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=h06bFs8Ai2pv7OHMSVMZfcHx1mv8ANXZPEECChOEY6A=;
 b=fPO8GvbIvna6DvvgnfC2DzHF4y6PAQ+2/Wr+Kl3WS0giRrIsTFlKcWBsfG1vK8XQTrX9
 wIdYPIEOxx+XprhoMHn+LMjQ6kl+Ypl4oiPOlqoldc8n4eKp/YSBUfgVTM5vvb80Jej+q
 E5xKkOUuxO8OU/5e+XPJHrujmT5Gnu7uX8ucn57qL6f2HviW4CGk09Y60uPZPewkhOi/1
 5iTy0IFgkujOU8OycPDN4GSOeU26O5rzNOEfADaHDBPlI9Rhjdn9U97Lmv2GNGYwiS70+
 pCNqzODQhoh32eOq6KZnpqfAkTl8pDnMdPGgdDGh8qurLABgDdGnHdAuaCR/o/dXlRw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="GSxq/EGR"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=GSxq/EGR
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9641B80E0D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:02:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJw7x72B+It6MTTv540bLN5NIxtON0Pj85Mbl2DqVYaco6DkXSbFbNqsEoI1czMVw7Z4YcHnHU+eLoksVgYWafr79K35hVcyvEa3sCqtTfHLrXwpTniGPD3NrD0L+tm3ARQWLELC6orWodU9dl0P+8IO16ZJpWUUVHhEbtLGMnbVF5EY4nRRWjooigvFr8Xc43v1qZTNL8OaaNGZwJYJAv7RxAgFQoVFgBNJyOzx95SpMhoKSKTIJIeTeyDZpbhW0mWE5BbZzmz7+5Hc44sAvXmmRjR0bse/3U9bcC+QV0DkmM2Bt6aGkmFsylzs8m2byOM17PBbj98peuvaY58CHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h06bFs8Ai2pv7OHMSVMZfcHx1mv8ANXZPEECChOEY6A=;
 b=XMjS+8UmpoWkI8ewifnOnlMvt3aNrYW8RRPG6fw2IRl6vv1eQuFrBJeGZOQWJJIUsvfytgsXYne/xYYrqV0hDHt/F+I6NzhQ0s66+VTs5uRLK8CowgjybD1Nu9kkQyXDmalHr8nW4mD6NH0MloqX6YWkkvAjEE+VHfkmOgJiMX1qixgLVYzrnF3Tov5Ld1QxOnAJTSZE/tpPcDrlNmAMzr5kcXB0bi7vLx9nrIs6Eonm0eEQaqQy+NOD9DwcThUFkWnzC37HdOq5OwnlD9agrqXJbxzprTE1evas0c9KDvNFlwFhlBOyfo/2yawCIuMfPRwzpzjhd+8J5eIj1aCJ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h06bFs8Ai2pv7OHMSVMZfcHx1mv8ANXZPEECChOEY6A=;
 b=GSxq/EGRur9nSOFezyRGvZlM2smcVfAAuQ5xxPOykGo9KY+B27dXmV7KfxNiSstVAyKJyRZKxFRWvKRUl5kP72KyEb4LPgb/NNnihSb26fHJ1NiqhrxsoPCi1LBA+Oiem1WVDqfHvqZyewCeJ4mDEKn8cb+OZDGhJw5a6/A3TIw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB347562.namprd12.prod.outlook.com (2603:10b6:610:367::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 07:02:18 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 07:02:17 +0000
Message-ID: <c4bc396d-aa9e-42d2-9878-817333224315@amd.com>
Date: Tue, 3 Nov 2026 08:02:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: xilinx: drop bias-high-impedance on SDIO
 CD/WP pins
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shaikh Mohammed Suhan <suhan.sm@amd.com>, Tom Rini <trini@konsulko.com>,
 Tomas Melin <tomas.melin@vaisala.com>
References: <15d2705e0807fef7567df21ebcfe48aa7f1466dc.1792505922.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <15d2705e0807fef7567df21ebcfe48aa7f1466dc.1792505922.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::24) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB347562:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f613db-57d4-4eee-a29c-08df397865cd
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|261102123227099003|11063799006|261009223027099003|261021123027099003|56012099006|261021121427099003|261022075727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: PWM36wNfGhNfMkcIUbeBtT71wFhrYfOWytu6RB+bizMoyGqHH1X++8G3hzWW9U8xNmHtF3qY2PcTDePcznsxqiHulWr4Yh3DVRgfR8Wzc5utpDwKsC68tTtabLmjaRviD+PKKxrNEVEuV7PYd2YbAPZqj7222ruRAd3GMzywmJbOuuNXAyozl3G4dbQOvq+2LKb5WGSAG8JZ21NtMbrPCjNVLwgaTn3smgE93uc62509/bW5eSIZsvqOssR5uw+2FpWlFGPYlfrsM+tMDamXt50/K6edm6SLAq4X1y8ZvtBOVWU0jSXyTrkGW41ZE/9ahQxjXfbu1Y8urGdoUOmhkeb8MiL5BlIZuCIvfM0HNkLbYJs9fXGgBVYQZyo4l15Ze5jMFbmPgbaOb9Ofc1nrRaDnyMekbxqRPOaxL4NeRdjxC/HNKY/aobvZU6Grf8bORnN9ogNt8RPaFKxhYMQ+38T20PgIEYrvJRpfPsaCZuJqamie8cEOeMp5sxBYPIxq0ztYNmQtPnh93EMp7FT0j+RWe0lJ8okxBmdQQ8g8Ye72a53t41b6fTdX9kKJWOWrUI/alJWMh1UdDxcH1Z8G0J2qBUht2z0Junvg+VBG2hb9YrPfNxr3biYOSF9FXP2ucos9G3EdJ7+MNdRhgtL3pz0JniQJYTTdsis7MQCbM4A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(261102123227099003)(11063799006)(261009223027099003)(261021123027099003)(56012099006)(261021121427099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUlZOGJkNGJtWmpMaDFtVVNNL3A2STVldUtmc1AycXd1QTN4c3N5QnB2UTJY?=
 =?utf-8?B?VDB3RVBmQ2tHM1lzbWc0TE92L2ZaR0xwY0JvVVJ6a2Nxa1dRWFNmTjRTbW00?=
 =?utf-8?B?YVRHcjRHTWkvVU8wQ2Y2N1pvMGR4QTBIVEttM1Boek5WTVBhT2ZobXRTTDNG?=
 =?utf-8?B?V3VNRjhjaDM2TmExanBuZmxJL0QwSFdTZUVYZmxYdmFoZ3NaUDVjYnpKQk5S?=
 =?utf-8?B?d3QrK0NHSXdHSHVxUFBVcUE2SE4vbTNhclRpaG5ZVGhaM0haNDVITGhZRTB3?=
 =?utf-8?B?cTZ5dFZ3ZUlhRk9GOWhvMld4aEc3L29OdDRRSEtNdkdHcFpLa1ZObmtRbHJW?=
 =?utf-8?B?dmdrWnpRUWVieUk3QVNhUzliaDVHK3RhWk5pTmtkUmxOdGVEczRoK1Q2MWwz?=
 =?utf-8?B?QUJLNWRMOGhObkVNTkhGbGlhNUJuRTVTUThJdFF4NGJ5bEVueURZMTVkVHUr?=
 =?utf-8?B?am0xOFRtdmQ2YWxRbXQ1aFI4djgvNXNxbUJmTThQUFh3SUJTcnkrbzI4ak5R?=
 =?utf-8?B?WlNkVGMzZDhyc1NKcGd3eGxOTGlITlM1RFdFdjhTRnp4Y0ZidTUrQ2l6aGFD?=
 =?utf-8?B?Nk5pRTVJSE94cU9WU0VhK0tQNFA4L0gzTWxqaldXSTdBNUh4RmV3d1Rpc0I3?=
 =?utf-8?B?NUJjWHlSVlhudXgydlRrTmFIa1VHSkgxL0pVc2dLUVZWc2NWeWZvWU5VN01M?=
 =?utf-8?B?N1FWS1N4NDBneHBSRHpPMHhPU1hCdElnWUNnK3BQTDIzZk5xS1dqTXZBdk16?=
 =?utf-8?B?QTM2OFg0QnR0M1NnZVdWWUFhWDNwRjF5R2Ftbldlc1NnNWdLb1gwaGEvcUtH?=
 =?utf-8?B?U0tZYVFWU21sV3gwWXpPMEhKRnB5ZTMrRVVJS1BKOWNrenowcyszbnVNT3cz?=
 =?utf-8?B?U0lJT0tyMzRBOTZkdlVrVkswUTN3Y0VrSXdZZFdyUFlWWlpzK3V1VEdHVlFw?=
 =?utf-8?B?VHhHbXY3ZmdQZ2lqYjNHU1pPY2FFenk3My9FZVhWQVFyaDVpR01xbDlVaWpM?=
 =?utf-8?B?dWFna0hBWmQzM3FsNmxMdkN5Q3h3M3hHZEI4dXNHU0laTE94QkRGbU1FdWFM?=
 =?utf-8?B?RHhWNW5TMmZTeS9TWWtpbDRRUEJJK3FVQXRXd2NVU0EzcTRGQU1QYnllbnov?=
 =?utf-8?B?TFJ6aTBqNy9NcmJLZHJUR0dWVDYvT1hmZnM5NnhhanRNcTZSWUI5YTkvTEE0?=
 =?utf-8?B?S0RLUGVYZXVMRkIzcktQS3NWNEdFdnE5RXRGaFFmZ09kaUhETUtJOXNsd3lq?=
 =?utf-8?B?R1UzWFVZdzFaM0NNVVMyc2swaStudDlIeWN3VmU3Z25XbEs5STNKZnZXc0xB?=
 =?utf-8?B?MHJDYXJOeXpFOWpzeGhPRUljckJ6ZjVXcWhiazY1ZW9UY2lrcWlINFJ5cS9w?=
 =?utf-8?B?aHRzaXFNVkNBZE5DNUEvOGlVdUFwSFBjUkJ2bVVVREc1dy9id0tENXVXNUoz?=
 =?utf-8?B?a292MVVzbSs0RWxiK3VrbGtxN2FrMmdUdjZMNlIvbzZZOVRNbkxzSFdhdk1Y?=
 =?utf-8?B?WWdHTHFPNEhDdnlmYTB3SkZlUlFoT3VNcEEwQWhiZVhVNnN1MjVUakJJSEE3?=
 =?utf-8?B?TVNKUGI2dEROcjVsRjBhWjhFTXkrdmhnQlRwWlNhS2RkQ2pWdzd4WVJjYzNu?=
 =?utf-8?B?c0JDUDJaV2QzeXNXUC9OQXRhVjd5bUhGZjNjMm85SVg4U2tYZ0s2aVBuSG1h?=
 =?utf-8?B?ei9kNDlIVlcyTVBNNG1OTWZleHVuMmVzcW9sb0ZhZjBHNGcvUXpCSnZ2SUdB?=
 =?utf-8?B?Mm1Xa0ZNZlg4c3FmRUt0WVVQMVZ5L2RPMEJPWE5qYjJoNC83VnRjbTZNeVFh?=
 =?utf-8?B?MVh1NmNKemhOQ0NKTjVpT2lvSWN4TC94OEEwaXp5S1NQNUdqUDlMaTdmQi9t?=
 =?utf-8?B?ZklxYkVtd011Y1pDdmROZ3AxWE8zdHdZVTFoaGxjMjdxQkEyRkt4SStKcWIx?=
 =?utf-8?B?c3RoMkIzTFM2U0tiajI1dkhmbGdzVS9WMWhiQko1WVpnbURGNXJYZ21oZnBa?=
 =?utf-8?B?djFQRW52UGVIdkxYd0prRUROZm4rZFpoYVE5NUNZM1JJQjdxOEFCMTBlcXlr?=
 =?utf-8?B?M3hWS09PZGs1UWJXSGt0U1E0RHRaUEJZNkNnc2hEc21DMDhaMUl0UmZ1bnhs?=
 =?utf-8?B?QzU2T3lSVGlZa3JqL1llbDdrWWtvbnZ3S2t6REY3eHNRblhmNEhvYlp4OUh2?=
 =?utf-8?B?emxaQW8walNJcVcxNmhVR2ViZGFNbnd2SEQzcEFZUDM4QXBKT3U4bmNvMDJ3?=
 =?utf-8?B?MlV6bHRmMWFER2pGMnhqaThNMU1XQ0o2RWJ3b0pYTXpxMWpPTHM5aDM2MHU1?=
 =?utf-8?B?SEVXbS9oZ3IrOXMxYU1CUzVJUFl0bFF3NmVTeWRTQnUzRUl3RWhCUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f613db-57d4-4eee-a29c-08df397865cd
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 07:02:17.9102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvJuMrmXThcs2sVhyRhWcfYDV7rcBm/C7le5CBjhrikm4lso5wGebwzriBydx6jf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB347562
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/20/26 16:18, Michal Simek wrote:
> Since commit 9c105255108b ("pinctrl: pinconf-generic: perform basic
> checks on pincfg properties"), the generic pinconf parser logs an error
> when a pin configuration node specifies more than one bias mode.
> Several ZynqMP boards described SDIO card-detect and write-protect pins
> with both bias-high-impedance and bias-pull-up, which triggers at
> pinctrl probe:
> 
>    generic pinconfig core: /firmware/zynqmp-firmware/pinctrl/.../conf-cd:
>      cannot have multiple bias configurations
> 
> On ZynqMP, bias-high-impedance enables tri-state while bias-pull-up
> enables the internal pull resistor; these are mutually exclusive bias
> settings and only pull-up is needed for CD/WP inputs. Drop the redundant
> bias-high-impedance property and keep bias-pull-up.
> 
> Reported-by: Mikko Rapeli (Linaro) <mikko.rapeli@linaro.org>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso   | 1 -
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dtso   | 1 -
>   arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts | 4 ----
>   arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts | 2 --
>   arch/arm/dts/zynqmp-zcu100-revC.dts      | 1 -
>   arch/arm/dts/zynqmp-zcu102-revA.dts      | 2 --
>   arch/arm/dts/zynqmp-zcu104-revA.dts      | 1 -
>   arch/arm/dts/zynqmp-zcu104-revC.dts      | 1 -
>   arch/arm/dts/zynqmp-zcu106-revA.dts      | 2 --
>   arch/arm/dts/zynqmp-zcu111-revA.dts      | 1 -
>   10 files changed, 16 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> index 45396e420433..fc8d3467198d 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> @@ -403,7 +403,6 @@
>   
>   		conf-cd {
>   			groups = "sdio1_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> index 22faec35f793..80d1577c92bd 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> @@ -394,7 +394,6 @@
>   
>   		conf-cd {
>   			groups = "sdio1_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
> diff --git a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
> index 2897c423f82e..7942e632d047 100644
> --- a/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
> +++ b/arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts
> @@ -285,7 +285,6 @@
>   
>   		conf-cd {
>   			groups = "sdio0_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
> @@ -298,7 +297,6 @@
>   
>   		conf-wp {
>   			groups = "sdio0_wp_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
> @@ -325,7 +323,6 @@
>   
>   		conf-cd {
>   			groups = "sdio1_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
> @@ -338,7 +335,6 @@
>   
>   		conf-wp {
>   			groups = "sdio1_wp_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
> diff --git a/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts b/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
> index 722b2e833b44..34b68cbc1e9e 100644
> --- a/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
> +++ b/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
> @@ -285,7 +285,6 @@
>   
>   		conf-cd {
>   			groups = "sdio0_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
> @@ -298,7 +297,6 @@
>   
>   		conf-wp {
>   			groups = "sdio0_wp_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
> diff --git a/arch/arm/dts/zynqmp-zcu100-revC.dts b/arch/arm/dts/zynqmp-zcu100-revC.dts
> index 81353b60b38b..2ebba269d208 100644
> --- a/arch/arm/dts/zynqmp-zcu100-revC.dts
> +++ b/arch/arm/dts/zynqmp-zcu100-revC.dts
> @@ -337,7 +337,6 @@
>   
>   		conf-cd {
>   			groups = "sdio0_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
> diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zcu102-revA.dts
> index 4d5f4754171f..1af7b889cbf5 100644
> --- a/arch/arm/dts/zynqmp-zcu102-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
> @@ -947,7 +947,6 @@
>   
>   		conf-cd {
>   			groups = "sdio1_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
> @@ -960,7 +959,6 @@
>   
>   		conf-wp {
>   			groups = "sdio1_wp_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
> diff --git a/arch/arm/dts/zynqmp-zcu104-revA.dts b/arch/arm/dts/zynqmp-zcu104-revA.dts
> index 4479ff735145..b03774bba937 100644
> --- a/arch/arm/dts/zynqmp-zcu104-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu104-revA.dts
> @@ -373,7 +373,6 @@
>   
>   		conf-cd {
>   			groups = "sdio1_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
> diff --git a/arch/arm/dts/zynqmp-zcu104-revC.dts b/arch/arm/dts/zynqmp-zcu104-revC.dts
> index 0f1b1fd92a70..ec1b9168a1c1 100644
> --- a/arch/arm/dts/zynqmp-zcu104-revC.dts
> +++ b/arch/arm/dts/zynqmp-zcu104-revC.dts
> @@ -386,7 +386,6 @@
>   
>   		conf-cd {
>   			groups = "sdio1_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
> diff --git a/arch/arm/dts/zynqmp-zcu106-revA.dts b/arch/arm/dts/zynqmp-zcu106-revA.dts
> index ad76159084ef..5a5d3884821c 100644
> --- a/arch/arm/dts/zynqmp-zcu106-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu106-revA.dts
> @@ -946,7 +946,6 @@
>   
>   		conf-cd {
>   			groups = "sdio1_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
> @@ -959,7 +958,6 @@
>   
>   		conf-wp {
>   			groups = "sdio1_wp_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
> diff --git a/arch/arm/dts/zynqmp-zcu111-revA.dts b/arch/arm/dts/zynqmp-zcu111-revA.dts
> index a9a473602374..e13e93847bd8 100644
> --- a/arch/arm/dts/zynqmp-zcu111-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu111-revA.dts
> @@ -778,7 +778,6 @@
>   
>   		conf-cd {
>   			groups = "sdio1_cd_0_grp";
> -			bias-high-impedance;
>   			bias-pull-up;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
> ---
> 

Applied.
M
