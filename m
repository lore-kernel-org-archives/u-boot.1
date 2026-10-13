Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C1FCC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 06:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0A22405B2;
	Tue, 13 Oct 2026 06:49:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5oK8xFUKlGuO; Tue, 13 Oct 2026 06:49:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1061B40518
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791874179;
	b=LIcKTF2aISuRIsDrdkHl1VGqpn8vT9YA8nDuQfnnYs8s1T6NJCdsnEClXNxZA9v9lR0W
	 cXcDIhoiaLvg4hbCr7g9S7mlxIZV0geRNKZilenVOBSPCWUoUoAaq+XP73pv0J28Ac9YZ
	 B6++rtJPUPE6VE71mCu5T5oMHiIhrqL+B64nY0RvBAJBG1X9U4L1pK7MtssZFsBzhTbWd
	 YgldE/F87odyMkFxpI1eHC40LnYPd8kub8ZMfk0G167+HAXBrXpxvZnTKvBCynKgR3DTQ
	 /yaqXTMxqCE8EoWEVOeAAm/tJQlRPZI7o+AGKB8/OCgmD2RjCCYaH0Zq1YStXXNkNmw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791874179;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=Hnbf86sRz3d66ce6RAEPvP546v/Flu3cdu/M8KJP4D4=;
	b=Sq11QWfjrO4IGBYRNHLiXebMpQyI4zP7VdGRqpyWV5KMiMAgXxhqG8slr4HjHBXL0c1U
	 Ga7ntdZlJLwOLVqCJLBCFjAYGYYqzkAEVcg19YdI9SLbpwIVtacQCkSootaqX6JdrW4YX
	 MZYGD+t5u81vcmvbGlgOHZPhCLnjNhig7SJQs7H4O4Lfxs8jBcj/pEGFML6EW8BM03DU+
	 jGb03NjDpgKrI2arrmf8eeFMUGzl+NeZSf0BhbH+0Gawy8oAqUi0QTUHymRebcMR+1JTj
	 AT4KmCmDtL2J0WWmiJC4rs8mYEgfBveflWbEWPnoG0jIjwZIEPA5zQs9vM0UR6MDnTw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791874179;
	bh=Hnbf86sRz3d66ce6RAEPvP546v/Flu3cdu/M8KJP4D4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jv7+m31fu5DB1qWPZtt2kQfIZkmsEkCjte614p6IodbIyv/c2PwsEadA3M86GA3jV
	 w+7avafNcUIqpH+6EGhYOIrKIQogfSo0Pm3rmFGgQLyPd9wmsana3HmD4VIqSVNU/z
	 zkf7KkElgwSyaC8U82OTcrWisFZ5L0HB1tyKE4HbWkr8wQ8prVvHYM2zYSq1PI81RE
	 qKwpOxdlIZjRVsxvUtL+uqeGTLDWAYwPg4ZFj8vXI2Mrbhp6VpHxvivX6c/r81XNnW
	 uG/Pf1rjfr0+Z6iIGR62JFJsFHzXQ85Svn4/d51mcsTFw5VzpGpYd23TlLs6pVxr/p
	 RAhJnT3IltzQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1061B40518;
	Tue, 13 Oct 2026 06:49:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B16B7788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:49:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 97C77606EB
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:49:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0dxw5NEG_i_H for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 06:49:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 312D5606C1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10c::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791874176;
 b=cBlQZRU0FKDaHYH3TD6VzZOqVK0KY5iEb4UGKjkiJSqjPaqKyOsH7rWKb40PhprqK+D7
 kScidp01H97sf4p4ouamzR52g7bTe/YZ/X5DElMBPbgq4yHYoUyhq54koerVTHUzYmThj
 xAIAKHSQ/o4qgpjBaOOZ7aDOcipxuH2UuXKpxwkJb7y7bMhdtJVyojgP1+g7sSd/gBugS
 GsxQ2TRYcA/InyGoUrASaseXdQy/Z1A3Tu3Dw9PeAbKvvmMHA+uz8cj9tIqL6WoYL0fyF
 Sgr9M12/ZwcB9zhFIEnv2sXdGBaZ1lSaRMIPSIV3Q8rX8ffBzW7V5yryf4aWzns4QOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791874176;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=Hnbf86sRz3d66ce6RAEPvP546v/Flu3cdu/M8KJP4D4=;
 b=C0lfOetmqEEnluMQlSK8GG+b8O7RvqnBQ0LAZfrq2uty4MZIHJfsrZ3/2gOkr2qdS1pY
 qSjf1qdLeFQ5T7fNeI1EeqcXpg2aPXMyN3EMcz6eLvul7FAF9BFpfa1DRfp3QBZAzw37v
 WY+0ZAw1uU7LGnttwuxBJK+PrXKDvRZF7WRRFHbQTutBziYDPtchf2zuE09lLkrk872cS
 6WuE3FixO02UKta0j8kzUbI35FQx5rYG9LM5+gkU+L8nhLgltdlUYLPA/8BBEmSugClvo
 GZVkglIHK8YrxBZVcIOk/K8Cd/xL3p57SpH2YB8IphSdHgN1Dfwcwzo4+8HjzROmtpQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4Ya5Dnrz; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10c::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4Ya5Dnrz
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 312D5606C1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:49:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I09idWWTsN4AwA669FmA9vzw+aBdbZpA1drD0FEEyix5V/J0+hsZoHv8d1TUTwpOHffIvfyYHQr2sYnKfCojze/3HHZcFjLP9E4OPtCP44DVoGxekoEemXy9aGWnv8fbKhStK/rPeGe9hSqp/ASYaHAviGGJWnAAhffpej/6sVnRWZt/NJGTCAeBcPHNnZ+Rg3+OhtIoQ9KdBtTzmRTdPRO0xYCVRu6ZMgx5l6FkUtDL5QcqmZHweqJSjzczq/hGqH0rKfqCj6p2mxKX+WAebk8CZa2i/lRdJTwihy4XdhFVBNIWLON9Qv33dyjuEl/AGILcMtQnL1npX+rZS+iJcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hnbf86sRz3d66ce6RAEPvP546v/Flu3cdu/M8KJP4D4=;
 b=MauWNMX2X+qq/Bg88a6IEkyQD6fS1B6wodxujis7H5YDQaoZlY8fCwkz3cRR1JAh9pFpsOyJrdCebbzGJH5mcQtaAMyjeng5TOqR9fmmWtMEcmAaXSaTcgZV+epi1p5ENAZAGbs6nQBFKqOUGVca3OqNA0zVGJ2XlML49fKd2fe7s1tjtZeNO9CM+cXbR4AlydaSspKm+Rh1htl30Dqc3mEkrOR9xvx4gDimftkinfhMEdf6ccdvOVUSVWMlYbVvrUfsDnXrNRKBeaYN7Gxf2hLCn1r6f1/LHLucV15h3mElpcKoQXlRWrM9Wx0c5+J29PCo7OWnqlOeIm4j/mGrag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hnbf86sRz3d66ce6RAEPvP546v/Flu3cdu/M8KJP4D4=;
 b=4Ya5DnrzgkZf/s8B8nth3ZvTg3YBX+Ha8rdrdQAgjhsB5HWtdn0+vWth/Bu0IibG1w0rznZcylhw22VhDeZMzFRSZ5zSIwnq5p1eQ+GuylGolRVB44zLjCDfgVLSgSK1vZv22sOJkTf155tUTEKgl8K50l4/Xmx1LX34E/6qPIE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS3PR12MB637004.namprd12.prod.outlook.com (2603:10b6:8:43f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 06:49:29 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 06:49:28 +0000
Message-ID: <a83ccf7e-87ee-4c78-80d9-86dc0b246491@amd.com>
Date: Tue, 13 Oct 2026 08:49:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add support for RPMI to U-Boot
To: Charles Perry <charles.perry@microchip.com>,
 Michal Simek <monstr@monstr.eu>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Paul Walmsley <pjw@kernel.org>, Rahul Pathak <rahul@summations.net>,
 Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Conor Dooley <conor@kernel.org>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@oss.nxp.com>
References: <20260902141744.2422566-1-charles.perry@microchip.com>
 <cd52329c-e241-465f-a77e-588ae89f5f10@monstr.eu>
 <as1zWYeE7OGOZEmJ@MON-LT-C78453.mchp-main.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <as1zWYeE7OGOZEmJ@MON-LT-C78453.mchp-main.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0025.namprd21.prod.outlook.com
 (2603:10b6:a03:114::35) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS3PR12MB637004:EE_
X-MS-Office365-Filtering-Correlation-Id: 9935ea15-a095-4a01-f5a6-08df28f6209d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|22082099003|18002099003|10067099003|3023799007|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: boF9hNBi5U+NOU082/WEnNyRJb0tKtpFh8On6VmwFpnBNwJptLDEa3St0aVlldnjPdJYCVN27mgJTyC0+aTq78O6NZMaeSDv5P4C3So8D04oma2idbAApaQCZ17JOz42ft7jNlRXjHfKtNthARSv2sGQRSxES9Vy789k83WJTwrMa6xm3BpvDf8uL212G18SY6zWbnWi3hgv1ZKwNH20vwz4wixDMQmT7ReNzAdNgVRgI8AJrjtRb30AOWNnVFEnnvj0jb8uUmjFbfVmCm0aVSmLneuCcaQpEFhc0eE99VBEYHJL3Iv9+stwIlk1eMSuGph2aQYbdY/GNklCK0v/ecbjhwBlA8oUP55CWOtDFZhnB14f8buQlKxt1Pd8cKfKGtA0S7FTjRXiyItpDh9+uA/ywUy/k369tSidbwxX0yaBEEhq8Hsn+cjyKWKMOPFl3PaH54qLr/wtawxNRM2TGxHaF/owG5ScIBJ+JDx8Zl/qbxtjAzmiM5aNeRIpXGSIIP8OJSQTpVNdGsTZ4lRCwYTO/xPfnYlxL1FgA+GuefbBFskKYbiHiQiMy0BWgQ+O/zB+UsIg/h7gZiRRYF9q1YfXBtp6iTFm19K2iJwCWsB4LcjPaYambJtXaBf5s/JA+V+WRle6ireBhL68EE+sf38w4/3lGfzTj60TnR+3MT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckJCWGJWNXE4YUd3MEhOUFhHbkFjbHBteUNUcndhSkp0N3Y3a3AwTHNGWHl2?=
 =?utf-8?B?ZTZ1M3R3WjlwalkwRGdwL3pnd2IvdUJESFdwUStlRGE1ZlpOQkxNMjl4bC9K?=
 =?utf-8?B?NU53S3djRXJZZ3VhOXVpUEJqTldlTG54YXR2eGU3N2RmMTJ1Y2NtcCtSTWt0?=
 =?utf-8?B?c0dQdSsvS2ViVWFwZWwwc3ZRa0lnVmFXcE5OMlJFK2hKNFBsUk5ycDl0Ym4z?=
 =?utf-8?B?Ti9pL2J2NWRRSTVwNXYwUlk2eVRITTJacE5Na1dDWTNZN0VqZXZLTE1SN3cr?=
 =?utf-8?B?elkvR1hYc3pSbGdzcVIxcW9tdlgzb290Z211ZUtPYzVHbFk5a3lYYTNZT3Nq?=
 =?utf-8?B?NlRmREdVdGpwNC81dlhJK3lWLzY3M25mSmRiTWF3OVVOZ1h6dFF2ZW5OaERs?=
 =?utf-8?B?SitXRnZjcTFIS0d5TUpRUHJzcTdJa29UWWJuRzl2OWtVbEFNSlJIaWJKUTFz?=
 =?utf-8?B?dXc0THp3Vkp1SUlNaHIvMTNidnV5NVBBUkNPSllkUDhjNzNwUkNEalJvNDBS?=
 =?utf-8?B?UGg4TWpwYTU4MFAwQ3F6Rm5IdlhDcW9oV2xtcDFhVERYOUwrMnlUQTlSRTZ4?=
 =?utf-8?B?YXZZdEJCQ2paZWthZGRFVnhiQWhSZHlPVGRwTXVwZmNsMU5XcWtSbVB6YkVa?=
 =?utf-8?B?TVI2ZC9jWGtIaFYrUFJRZTIyUEtLWG9FU0t3bHJZTjMrU0YzUXNLbHZBWEJy?=
 =?utf-8?B?bndUalN4cFJKVzg2bFlKL3ZQQUpXUWhMWEQ5dkpaMGdrck5PbEVLOE1yaGxM?=
 =?utf-8?B?UXJMU0J5VFpaVnJrZmJ2SDViQ093bVFiWktIMmxxSEMzZHZJaG02d3kvYlo5?=
 =?utf-8?B?YzFRYXlnZUpPT0htRjdVYzNBdmcwclRLSXNHZDUwak9PYWYwcXZsNEJVSlQz?=
 =?utf-8?B?d0MyRUhJVjBKM1VNM0JpeFBza2NFaFpkNXlYaHVCU2liWE5BdzQzc0FveW82?=
 =?utf-8?B?YmF5WjM0b1Z4L2RKVHF0Y3lHanVYZjFCdFU4S2JoVVllSjgzelphRmNzdHk0?=
 =?utf-8?B?dUczSlJXY0M3UkNvY3IwWXJzQXRXbkFwWXRKTXJwNEdIZVJsRGhqVThicUw5?=
 =?utf-8?B?ejFKQVdJTUFMd0dTMytOc3pZSnNhQlBOMWZhbFhoeVBsMkRhUW1Ebk54WTBE?=
 =?utf-8?B?eDZXUy9PMTZramRXRVlGT2Z2MjN4TEtubUUxVVQ1UHpkbDBmVkgxcnBWanU0?=
 =?utf-8?B?eDMyYWdtNkQ0dGthaE9lTXE3cEJYcXFrVHBjcVdtc01Dc2NNQWRXVDNxRzBs?=
 =?utf-8?B?eDRZS0lZeXg5STFEMm5lVTJoUy9CSndTQVNNb2xLUUdFYUZUSjdWNWJVRDBp?=
 =?utf-8?B?Z25lUnhSTXMvT3BXOG5mU04xU0d2OWhzNWlkTkQyTGI2Tk83S2tlL1MzVnJl?=
 =?utf-8?B?M3J1bWo4dEhGcklHVUdBdmlCZ0ZkWEhWN2d6L0kzcmd2eGFXbzhxQjhqbENn?=
 =?utf-8?B?RUoyTHZYZ3VlRXJaQU43K1p5dzRPRnBnWllBSHVIck9MSjdMVW1iWC9MVVA5?=
 =?utf-8?B?N0hmY2xYaU1CZWxET1dJZFJvRHVMTlY4eW1jMjVFSU5iRStuYmx5V2VONWRm?=
 =?utf-8?B?bEw1ZWJaZzg0cDhOSUg5NkNjM2N0T1p4SklORElxUkkwRTNTNktYa2tGeUVZ?=
 =?utf-8?B?MTVpZVJsR1JNYTFUalIwWGtJVkx3cUl0eGJOaVN0ZEt4VWdKc1M5Y0N6S1lL?=
 =?utf-8?B?VHNRVUExQWpJY2NRSHRlb3kxRXVuM1FFd2k3Y1cvWnJidW1SVno5MzJ2N05G?=
 =?utf-8?B?RmVZMGNONkR1WTNKS0R2TmdmUzVqWHNQRnNtN3Z1aEFDUUJadHNxanlqckVU?=
 =?utf-8?B?YWlwZUgzNkQ4RFZrRlhHM1RubG9vd0ZxYWlhOVhuQXo2NHFhc0hTYVB2aTZR?=
 =?utf-8?B?YnFZZVZUeWZGRXNFM1dYTmhZQk1hOTlyVWlPRUlucWczNVRuQzVQNHRWM0sz?=
 =?utf-8?B?QU9lVER3YTdWQXc2Y2VYdWpsdTJoN25QNEZ2eWJvd0tnWG5DZytVOUdRV0F0?=
 =?utf-8?B?SmRiQmw5WkJNZEFxZUZkVGN0QUY1bHNVYTBoeU5rVDJNZ2d4dTVUTGVUM2ty?=
 =?utf-8?B?eWUzck8xMWVPbGFxOElkRk1KWG1BcnNwZElPRWR0b2F6NnRSdXREdWFuTUkv?=
 =?utf-8?B?WGl0RXBIOHM2MklEaElQQjhqVldyNjZFWUdxYkRuVXJ5NWFvNFZVVkppUHRH?=
 =?utf-8?B?MldtcGZJd0JHTTI0UExYR0w1d2I4bnJ3ekJDZ0hNNzBON1ZaZUdmamtFSTc4?=
 =?utf-8?B?OHNxUWdaKzRaTXNMTFZFY3FESEdsaHQ4ejFrRWNOS3JERERubG5rTjFNMUdO?=
 =?utf-8?B?Q0wwM0NLY0FSRTk0YXpNelBUdjNWL1RIZVR6RG9XYkM5SmNVSTJYUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9935ea15-a095-4a01-f5a6-08df28f6209d
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 06:49:28.5265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: os2cqEMHNsSwCVRdwXflGVndIwvIsC0rtZi95SJ/+Yp4VF4TJOd1kLOjKAfEU7yt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB637004
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
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 10/13/26 01:55, Charles Perry wrote:
> On Mon, Oct 12, 2026 at 11:47:51AM +0200, Michal Simek wrote:
>> Hi, +Paul
> 
> Hello Michal,
> 
>>
>> first of all do not use mailing list on denx.de.
> 
> Ok, I sent this series at around the time U-Boot changed to
> u-boot@lists.u-boot-project.org. Sorry for that.
> 
>>
>> On 9/2/26 16:17, Charles Perry wrote:
>>> Hello,
>>>
>>> This series adds support for RISC-V Platform Management Interface (RPMI) to
>>> U-Boot. RPMI is an OS-agnostic protocol for communication between an
>>> Application Processor (AP) and a Platform Microcontroller (PuC) [1]. The
>>> goals and purpose of RPMI are similar to ARM's SCMI.
>> I have raised my concern at riscv minisummit at LPC and also talked to Paul
>> (riscv kernel maintainer) that this is not the right way to go. We already
>> have SCMI and there is no reason to introduce RPMI when it is said it is
>> serving the same purpose.
> 
> Cool! Thanks for bringing this topic to LPC!
> 
> That being said, I don't understand why we can't have both SCMI and RPMI.
> For sure its more code to maintain, but there are other things at play than
> just the functionnality. We discussed this in v2 [1], the points of
> contention were:
> 
>   * Anup said that the main blocker for him is that the SCMI spec is not
>     community driven while RPMI is.

Based on my information none really starts to talk to ARM about SCMI and this 
has been introduced serving the same purpose. None should introduce another 
interface which does the same thing. That never was the right way to go.

Thanks,
Michal
