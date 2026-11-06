Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22747606A32D
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=u50PfvN2;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=DiHoKcn5;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=DiHoKcn5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE54C8116C;
	Fri,  6 Nov 2026 18:08:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id thxVmDuhZhIy; Fri,  6 Nov 2026 18:08:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0761F80D1D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793988521;
	b=tDq6UVvkoNQH7A0DIv5L4g3mAwPsTdSR1yFYuLM35uHqc0Zh6K1XTR7DLK9w7decEuOz
	 tn9I7bhfDF+z4kzOf84ax13shpfPwyUrZDrs0otOYkGDSxi3Xdyg+YxUfoYWL8q7Gzf0k
	 biH1aiEPYKMbjDDxZtEcXhywai3BMAQU8JS1RiXXXApqychAn8I155L9gTMF1WznB4MxG
	 V+ClifgQcyk363wBufqGXGwdih8qdRPgMyev6jaTSU+6DkYMvl7m/QgBSomRROcZ95rad
	 ngZfcYGyAyv3ygpcj1ssTemHU23MqLB2Npkv1uOV4Z1u5VwJMhqSA92ANoF5TwR1+1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793988521;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/BUVw+Tz2A9VSWmt0dSp0Sqvx5DY5aB9v9PNqCZhOac=;
	b=dIkKXLpxV9RkiX1WzlNbQB8boLquX2PLMwz4YeS8BMBmBss3AI+wWEmT0XQUrjw61+FH
	 JqNhHQuGfF07mo762ymXS1gaOHbK3AAP800zG3GAZLpHceRQjcK8flDhEdV4+ccyEY2sa
	 rljeQdSmSWv6+1ZqGWHkak2ly72X+/+aJTIFRJ8DXHdSsqPW3b2kYCgR2T4XKeLHe5xx6
	 RPBsxPbiXUI8GpYaax74St04SitOsW0QWzOrp3q1aNWyXclF44Kg6QhLHcMeanxrwouoJ
	 LOZ1eeO94vxzUlYzDjTp/g/+oOo3X/EHawmDWUjC37t4ZJyNi6TCGXEC84mSfn7w4NQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793988521;
	bh=/BUVw+Tz2A9VSWmt0dSp0Sqvx5DY5aB9v9PNqCZhOac=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u50PfvN22hOFsPivNMQT+swGxhcF2CDdUnzVdevjwAuivBPvKgH8pmQXEjROhQ+Y+
	 PEzXQGCUM/Cuo/SAWzIq4+8fC2doQsrDR7QUKrklNLFWL8v2pqXhv6jbM0OFZNrk9r
	 wxhf/woDjU2IJYQBaScsRRiblqClWoB0fy64/sjakh6Vk4bv3nf2ZVjIdUxw7ogCc3
	 GqfZbbHyb7mXDdVraTvVXdYl+I3jBnbtz7FzKHW0MgmXlBt2IRyN/2soCqw/ybZ5YY
	 fiIwWRcQwJzQ/ERxGUIgbPNrNCEitK/Pu51KnfWcD0cacGlgnPHJQBW+brAD6kFec2
	 jFQ5O8iIXzfZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0761F80D1D;
	Fri,  6 Nov 2026 18:08:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F096C2E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D636540934
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:08:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8mcDAtyXq-5n for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:08:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8C9274091C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=DiHoKcn5; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=DiHoKcn5
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C9274091C
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BUVw+Tz2A9VSWmt0dSp0Sqvx5DY5aB9v9PNqCZhOac=;
 b=DiHoKcn50bXGtCFi8MUgTg6MuICdUAKrQLLPHlUXcxntC58/D3euL4jDh48cVW5wqlwPejhP1gx86VHeXipWsJgKOfdieVNv4J51Fnr+gqwwXXC7KiXBLYWXFrN5EXRXnP+z7+WaH2ZoykbOAjYaTkNlI3b0M/1hf0099R3rx3w=
Received: from PA7P264CA0294.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:370::18)
 by VE1PR08MB5792.eurprd08.prod.outlook.com (2603:10a6:800:1a6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 18:08:31 +0000
Received: from MAD0EPF000008B4.eurprd04.prod.outlook.com
 (2603:10a6:102:370:cafe::96) by PA7P264CA0294.outlook.office365.com
 (2603:10a6:102:370::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 18:08:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008B4.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 18:08:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BUVw+Tz2A9VSWmt0dSp0Sqvx5DY5aB9v9PNqCZhOac=;
 b=DiHoKcn50bXGtCFi8MUgTg6MuICdUAKrQLLPHlUXcxntC58/D3euL4jDh48cVW5wqlwPejhP1gx86VHeXipWsJgKOfdieVNv4J51Fnr+gqwwXXC7KiXBLYWXFrN5EXRXnP+z7+WaH2ZoykbOAjYaTkNlI3b0M/1hf0099R3rx3w=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by MA9PR08MB241936.eurprd08.prod.outlook.com
 (2603:10a6:250:104::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 18:07:09 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 18:07:09 +0000
Message-ID: <2c037f55-bb68-4713-ac20-e7f5e47a83f0@arm.com>
Date: Fri, 6 Nov 2026 19:07:08 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: preserve the driver error in eth_init()
To: "Terry Zhou (Synaptics)" <terryzhou05@gmail.com>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, nd@arm.com
References: <CAMPWMbrVO9-ZVYQu6Y0GSA37OXzTrg+nyZObyxQJKtJvBErmQw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAMPWMbrVO9-ZVYQu6Y0GSA37OXzTrg+nyZObyxQJKtJvBErmQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0055.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::12) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|MA9PR08MB241936:EE_|MAD0EPF000008B4:EE_|VE1PR08MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: ec01e40d-2d10-4545-e456-08df3c30f6e3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: jzGMk7k2QAaxlaDkItvOcLILe0DOSh5b2yNN504JzUEInvQaQdSrFpNuD++i5ERPtBOz4T5NcpRvd1hFCSSJ6fh29QdUuYpe63eMDjfM2haKL1mNF05NLh9TdEAVbwk5BR5m1QHby6CveLhDyXFfcxZk/d0+JhTYyT0jBXe5VmZL2HaL2i0eiQWbk/U2FiW9iTnFoCKFBhsvtUlNipRhzJ6BhqRFMqHYhmPTRawyyG62P8LqxeHwkWS8P9srwIQK9cYETTUdmI5HF2NVr2e441uZXSJyY5iD1WRqclxsiXwa+8H5S+vjKmJ92/FrKPMSlh7+8HtS5xfPDlxzptrBGlhK/fm+IM9JYHID67Eh3Mh6rUHdi5Z3HddDbavPW61+6uvFsPHmYbuJ3/7Z+Igbr6dSLsaS3MApKi5GQBh6hlthzZODcqB2WHv+PfpzzRB/Uly7t6sp6cIdvly55xQf0sDtmm0odeXE55w1UkU3Nl4K8wPPgSv/bFq+o7moOUyzcisJ+hu8tQlMpFSsNOfqyDc6l1iPg1m8Fy9zKLfwMROSaQ6dYyRoi/7yVjCAsaPh5NbrDnIWWiiPyk0QdDKlru3Z8AhKNZof5g2Q8TE4If3g72vLcq/xCfb9IRwUulxq
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: GK7MvKLBCAqXOQBahI1nrSh7BhH4ytyKCrTLLHTeSeHQOPggqsYA2AKBfcfNmL2gaPYSFncPduxsMIaxoM9yzFU6ix/9/uqLqvMB2/A+Et01pSBTETQ+eiEZUnbGiImkpaLC6zafwsatp9+TjePSk08iBnabbhrXg1KamqyUDD/EOsoWQs3l95mkiuzxZQN6odcJx9za0/g0SV02cR4Vt+GVjfgvjO07ekGsA5bEIk88G8z7hcNfBj8dqXGhMspjyVDEPOgB5chds2olobqU00O034A6EtjXhifpkcunvYiT4WMKO/6Q6CsNcRIGM8SYTaTWKhLqXN0rsWy3dlxS8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB241936
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008B4.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f2e270c7-bc26-492d-d70c-08df3c30c62c
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|36860700016|82310400026|376014|23010399003|35042699022|1800799024|6133799003|10067099003|22082099003|18002099003|13003099007|11063799006|56012099006|261026140227099003|261028144727099003|261009223027099003|261021123027099003|261102123227099003|261021121427099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: DV2P3b0IgJgObTCmPOYs6txe/w9Tayo8cVmPMVDeDbOGOhMSL2+1bfFqFzGWYTxzBZyPHNYD4vSPljX7dGeSdlUirmtTkjtMvv19gVypSbALx3bDdCaK+OXjas/bXBCkv62CiTauNdeQjtiPtux9oJ/LnuxiSDEv3BGvJOkXmXWtd4QGaQFUbueziKuP172sH0UsMBh8toU1Ge/x+v1cnV0Mls9G6L6x2B85UB05SPI+NaXTXjBcqtJkBVzv5LITcBywBkkZuU4H7k+JksP1JDSAHyvIkGMTIFeP6WRujWNitMXNaRQIZuHfZxlU2FdTf2QVOPm1DE4+l4jhx81CpN2m/XCH7GLqKCrzw2cV5lWsoWi6ihYmC39lhU3O+Ogt33kt6RQJlTSscRAruZDng+FmOl1gTUlyEsDt/5rXpYVXOgOpP11RlZRRSUqyb4aVGHc8izw7lahxMD4BBgsjz/ypb/xbAE+VMwN0fcZqflgMJeKWGTCvAI5Qx8OR22SLSnpPeURiRMJBkCT/pN5Q13Q8r9eyuiJqohVkb/TZxXSWDiA89cP2k5he8TP13Y0Oyd6e11CBINEx4RnJ0Q9ghDWPP8qdTLzOBqc0hZ3vLHL8nh5eEQMcQ2nAD7uC6zFs0xwy8hj3lN4Ag1e/HOPn9rdSGyTu12JsG+GSUzOELdM=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(36860700016)(82310400026)(376014)(23010399003)(35042699022)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(13003099007)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261009223027099003)(261021123027099003)(261102123227099003)(261021121427099003)(261022105027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XNEtT3S6AJ2+xJD9niuQzPEfHSZzd+ihqRDtf81f0DsBU15dEfiEpqgm60nDgE5Ir+5Q/Gtq/FIPHRZ4mfRrs+nG7o58FgCRapyqyKIT3/eH7EfQEwOShVV/OQ+WudzcHXkNjxUCRutIKL7+R3iJJwtl2XheuhGJ+Yl6I2xP0YaoIQZ8orLTm+tVx1XQpG63wVQarRhN7PyDMqWfZ1TkJX89WQ+EP4BSaKD3ioPi639eABCNIT2TBvUXAdMnk2OV9Miujt6GyPQwY7fY5QQpgwXM1QmGGJmglWbh4GFUyDrXOzSyhNbiOtcIk3xifKYwDKuJwweS513X3zvUUAuAIgqiaK6gPxcVTS7yc9TM+GqVqBITLE6SoVci7klbp8zdTIPzv+yTeEBMRiogu7iYMb3p7CxCbs4Z9h3UEKggFVNV4+C+swp7MEec2csCqtDG
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:08:30.6544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec01e40d-2d10-4545-e456-08df3c30f6e3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B4.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5792
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> eth_init() overwrites the error from eth_start_udev() with eth_errno,
> which may still be zero after a successful device probe. This can
> report success even when no Ethernet device could be started, causing
> DHCP to enter the BOOTP retry loop instead of failing immediately.
>
> Preserve the return value from eth_start_udev() so that callers can
> detect the initialization failure.
>
> Signed-off-by: Terry Zhou (Synaptics) <terryzhou05@gmail.com>
> ---
> Validated using downstream SDK U-Boot on Synaptics VS640 and SL2610
> Without the fix, driver startup errors are followed by BOOTP retries.
> With the fix, DHCP fails without entering the BOOTP retry loop.
> DHCP succeeds with the cable connected.
>
>  net/eth-uclass.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/1] net: preserve the driver error in eth_init()
      commit: 59068d4817767bf94bddcc38bb0f08e60638c4d1

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
