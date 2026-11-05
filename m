Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B005606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k3qLvdG7;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=A8nEvktY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 825C88116D;
	Thu,  5 Nov 2026 17:05:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rVPIKW5aQT1p; Thu,  5 Nov 2026 17:05:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7AB5D81161
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793898313;
	b=STECczdLi9eXefmq2Fx1xq5aQXVjsnWNX6ZH0Gt8asfughcI9aOr2dj5iPXcpmgSw5za
	 0CtJfCO4ev4iZp5L9+t3tU9eqqc6cYRwhHkiVtQz+x9R0kSl97OGRf/H8dV9htbvAqf7L
	 7ilp9iehSWz9LFld0Pve58OR6TzL+Bb0KpIV2F3PL40DoiTvVCi1g/Vp75NNk1JHjdSz7
	 NTJR4QCX1kFxOC1NM9IAwxwKxa2T18GamzF+NrrrVLBFL/BeVcXMwwpioP3JTA4arl2kk
	 3iATmOftEVltPTolfEInjxfWexBWv4xCGenpFPLcFRtVTuEQ4K11Jc6zNojwpVm/LUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793898313;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=hKOb+tNWBX5XjIMyWfkGr88Xe4/7UmGU0GJN1g2Sn7M=;
	b=L0ktKcqNrCz5817h9LCi3hXay+lwhTiXoxPxg/7hj1ZxLN1uVwN54QBjs9Lj3NT9bMre
	 cxc2S/FOZruu8ARqSS0oTo9kLSs3AJWKBfCHvX8Tpp9KbPkwwBmw8StbOEQPgFb4bsTZp
	 G6nLbivK4j0VHXZbVadLKmD7Z3eV+W7FDSCk4w42uc60j3QAsLPVZqU6SWcb3K2otrvSJ
	 zqfG9uZ09mcNyAYvSMg+L4XVt1v5mqn4wBB86XaWCPGAH5QYaHCxT3ZOztlvQoRr6HLOi
	 wuTh+Do8Pemd5SFQjWgBi37Rza4oj8BuTUbgv4BtkHdexNMWHQzrc4MPC91K2NmOZbw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793898313;
	bh=hKOb+tNWBX5XjIMyWfkGr88Xe4/7UmGU0GJN1g2Sn7M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k3qLvdG7ApqxR2YpzDx+kH80qJWkUnp7nFHAUbaBhYI4GAHR1ks/BXbVo1rS5E9DQ
	 jFw6wABX0mN0bUv+KUubyPJ1rxekXLudKJtQa9I48/2RcsoN/Admcq4uWCt5721KzE
	 4uenowQq936k64sibv2OHUHfZvYZ5WVe5wp2CZwBvmiNOwgc5Dmh/TyEctLcg4ikDo
	 b5HFfpEtCMX8cEtlc9QXOIhabj0UgqXNORvWt0e3aV39FWsrAOwU8Ev2eFM/XKOQsV
	 zcFB2zcY02zDechGDUmN5ItWhboXkpSnMGnoYYEPLmF7/Cf1jySc/PmGJfosOPu4jL
	 jCUcmmsZtRZ2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AB5D81161;
	Thu,  5 Nov 2026 17:05:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 427BA37B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2148940847
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:05:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ST2o9QNp35XA for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 17:05:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 534B34083D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=A8nEvktY
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 534B34083D
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKOb+tNWBX5XjIMyWfkGr88Xe4/7UmGU0GJN1g2Sn7M=;
 b=A8nEvktYk+OE9zRnmiwbJO3r8oWFE0CiitdkGQ7Si5KdmVLpBL3DUctSuWn0sC1DohwsSyB+/kdv4SddzjXhagHchyV2NIKvJtAht10rCih8rNnXOrVN333crXWx1H6xLB0/zQurmoQPIFNZZTxMXpZ/mdTjtbdyq3xtY9f/3HE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PAXPR04MB8895.eurprd04.prod.outlook.com (2603:10a6:102:20e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 17:05:03 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 17:05:03 +0000
Message-ID: <d9d0d343-c615-4a78-9f24-197ec3fbbee7@cherry.de>
Date: Thu, 5 Nov 2026 18:05:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] Add support for OpenSSL Provider API
To: Eddie Kovsky <ekovsky@redhat.com>, Tom Rini <trini@konsulko.com>,
 Tobias Olausson <tobias@eub.se>, Paul HENRYS
 <paul.henrys_ext@softathome.com>, Simon Glass <sjg@chromium.org>,
 Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Johannes Schneider <johannes.schneider@leica-geosystems.com>
Cc: u-boot@lists.u-boot-project.org, Bastian <bst@pengutronix.de>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Jaipaul Cheernam <jaipaul.cheernam@est.tech>
References: <20261029201348.730274-1-ekovsky@redhat.com>
 <20261029201348.730274-2-ekovsky@redhat.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261029201348.730274-2-ekovsky@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0132.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:359::18) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PAXPR04MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 559b32e1-e53b-4e87-f5a3-08df3b5eeeb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|7416014|921020|261021123027099003|261022115727099003|261022105027099003|56012099006|11063799006|4143699003|261028144727099003|261021135927099003|261009223027099003|261021121427099003|261026140227099003|261026121527099003|261102123227099003|261022075727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: /+UwHs2RP1CbrXAcednA0Ptk1bbnMBlF2kjHzXR5VIECUGOIrvSZHRkxmF0t04Or4XbpxeGgTx5rixhG/zeFhcwGLmibfJyttj39kGoKIcQn8NzRx71urn7q9sd2sANpi5v+WLWO6BBlyFYoDy42Ef5rJetxXBo862pF2OoywrWW0dU3z8be/yPQbLoY7sCOOb+KYHPRJPvT/DY2XCEP7DYtZ6knwihUlh6VWRgPUIK4q1ZJLa5vHD+DNywJAgEvtAZWuneTOysHfUPJuw4whJamAYafkJy9Zxauv9F+AeMaUF6XCYjNShCjig7DY3V5FQeZ6s6wzTlcH+Viwo91PWXGCCJJR++VkU44LjbUgpZKLDnCp5fOq2mXi8Crrxz8a0qjNtsge1HJJyopfFkYzVaFjuN4a+N4liZfX/DlNLm4aMiRxMfC23Q1U7CkUDFR47toX77Y6sGMsY+7FidhYc0drm860aGQeLoRZJRVVcdtfF4p4+R8aG/J/x99e+5aqEq6ZCqBg2PZHFlcZpNvkEowzuDlN/e9sYTnDYQVEhNJkzC037KYHg7yTVwrpVe4i+pAk1HGUwknu/Gv5h1+0Jjm5EImt7g4yztUbTgkNjLollYoUdOtShUfOc1jyNNs2Dd8PA6d5jWJmEX+m4FrKkVQJbAJqHUupEgMExclzL068u8YiGwfXu2p97XI73xphl9lnVgEUS2rLR3f05Z/SQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(921020)(261021123027099003)(261022115727099003)(261022105027099003)(56012099006)(11063799006)(4143699003)(261028144727099003)(261021135927099003)(261009223027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261102123227099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVhvVG95RjVXQjZUSVNjVytUR2hlNUhOQlYvQ1E0d1ZKRG5yd3l6QXJJTU0w?=
 =?utf-8?B?Y1JWb1pPaEw1MWFtSkxzZEljc0dZKy9oRjlLNStqcWpiRkEranVXZjVCeXJw?=
 =?utf-8?B?QmhoL2t4elYyb2ZkamFnOUFGcm41UHJSU1FoaEFYRWYrTFh0aGZUUmtZSnVF?=
 =?utf-8?B?cnFpNEJaMzhDWHJIR0ZWd2R6bmJMQnVnNkFNRWF0dUdZV1NiQ1AzZFlpYVNs?=
 =?utf-8?B?bTg1bEFwNjFuWERabkM0M0o1SmZMUktOMy8vNjNGdXpOei8xZW5TM2VSdlMv?=
 =?utf-8?B?VnIySE5wY1FwZG9odWF4SWpnbnpHNzJHMjFBUkNxWXRSMXNJVlkyTXNkN1FS?=
 =?utf-8?B?SDdjUi9WekRsUGlpYUhicXBwQnR3SG4vS2VTNUd5ejVoY3pmQXdNVy9IeXVF?=
 =?utf-8?B?czkyOEZzTEdLVi9kWlZzM1RGbmNBdG5qd1JNT1NhY0NXNnhXOGFjcm9NYWZp?=
 =?utf-8?B?SjhNRiszU1RjTTY1d21WbnZGb2wvTEtWVUVkcHEyOUhhMTFJTjJTcEFNbEtk?=
 =?utf-8?B?VWVudFU1RUw0L1NkVlo3dDQzVEhXUGl4WlI3NU9sUnhaTVpUK1JWL29pSXdO?=
 =?utf-8?B?THRqa1lJYUU2TjRWSkZKN2hEVFBLM04wUGgvbzg2bWpndXpGVGM5Tkk2cTdR?=
 =?utf-8?B?c20zVnVuTnE1WmwxdlVvTkYyRmZYTWtuSjFxSUowMm40M1h0ZW1SdVk2aUo2?=
 =?utf-8?B?Ym1MTlhQSnhhUm4vc3ZuV0syc3Jkelc2UlV0SU9IUkdrU2ZOTUdoOHRxdTFI?=
 =?utf-8?B?WUw0UGNKdDY5dTRUSklLejVITVd5Y3FETllDaW42YlhHYmdsY3FGQm1NRWhN?=
 =?utf-8?B?Q1QvWkQ5RS9OQi92akc1bkQ5RGJXNHA2cmJsMW1WYmdDN3pxQnQvbWxTQTVl?=
 =?utf-8?B?WWRIWUNMZXdWVnQ3aUI4Tng3dm5JZ0lwRGlyWnJvMFhwNVE1RUtST2E3b2lJ?=
 =?utf-8?B?SDBnWmFDYUdzc2VUaE5YeHhBNUw5RzQ0RmFPdDMzMENwREluaEtlMmNnQWFZ?=
 =?utf-8?B?Y0g4ZVNLaEhSTlJ5bjlWMlpaL0Y2Y1NyNEpPU0t2c0NRWjJoL3pLell6ZWZt?=
 =?utf-8?B?RlFUNXdGTFE0K2duSDdUSnJrRjR0QjZRSERzREVTZGtWbTcyZi92SDY5WkdN?=
 =?utf-8?B?TGJIbHdkN0NYeVc1R004em9oa2U1UWNUSDRzYnlWLzJ4bUxQZ1E1SkJDVHNj?=
 =?utf-8?B?WGJyZDlkRlNyU3Z1dVE3TCsvY3MxWVpNQXUwU29wd3VyWXExSkV2YjNOS1hS?=
 =?utf-8?B?SndHSEpoaUNkQUwwSlJHVzNSVm9RQ0VTd3Uxa2hYQjVQQ1djckRFQ0RWQkQ0?=
 =?utf-8?B?UDJ2Y3lXWmY3M1FLTzFldEVITmlEMFZ5SXdzZVF2eVVLc25DRlBBQTRjSWtQ?=
 =?utf-8?B?Y2FlekJuTzVlYUNQYlZTemFCblZGeHVxSENNbVZ5N0RKeDBGS2FkcnhpeE0v?=
 =?utf-8?B?NE5icHg5KzZKRGxnSzRBWkNzVE83bEk5NExudmE4R2RDdDBiVHZkMExBVmlR?=
 =?utf-8?B?eVhHeUZ6NDlaQXUxd2xiR2IzOEF2dWV6dlk2WFltVFpNZXdKbmxpODJHcnBy?=
 =?utf-8?B?dE1tRWhVT1pyVUVwNGdYN2RsNUtJTWZPWGhnaTFROGxsMU4rSTVSQzVJZitJ?=
 =?utf-8?B?dncrSXdwRDBlZXYzVEF1UDFDa2svZlFvY3poSkpuYmxya3FnQnY3QUFwVVor?=
 =?utf-8?B?WlkxZk90NDdDbXc0M0Q0QVVoVERNeEtFRHcrUW5qeFAyTFRzREV1eUFabk16?=
 =?utf-8?B?eEJNZThTdXMwbmNIUjl4OW4vT1R3ZzcvYzNMSnVqc0NVT0M4VTZ6UVBIdFhu?=
 =?utf-8?B?Z2E5WnlLVVRkYW9nZnNRSk5uUk1WZEtibnRXTk5FdkM5VzBUQ1NwaUtwQ0FR?=
 =?utf-8?B?aSsxWGNHTDFsN3NzWWZBdlJMell6MFRPeCtJZ3gyTzZxS05leUEwTW15NUJR?=
 =?utf-8?B?YWRlU1RvZmhhREF2ZzNnUnZyNzhwczA2SDl5Mi84MEtSS3ZMRGVhd3FaOHhW?=
 =?utf-8?B?cDlDcUE2UEhiMEUrOHJvQ0ZzbmwvU05tb2xHZHQ0bW9EUjZHZnhqNXpGZjVU?=
 =?utf-8?B?Umt0RHl5anpEMUhxYmMxWitwSlkxM094TzZReFRoS3ZhTmxhaW1QSmRtclVi?=
 =?utf-8?B?NnY5VXB4QXhoKy9tVnB4N3pxdlE3TXIzVjNoa1BxZzczWlM3Y1BKWEZJdkdV?=
 =?utf-8?B?b01RZUNBWEV6L013bGdJaXhaQ2F2b2ZKL2JDcFM3eXFwem1Ham54WXdEalI1?=
 =?utf-8?B?aitMUlFYZmw4SUpyN0F1aFdERERUWlFRYVNmUGFCbXNjaGdneG1Od0FBSUwx?=
 =?utf-8?B?bGdnUzlnQkJvTUwzZHg0TTB0V1VDUTdPMVNJek1BUGswY2NiKzdpQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 559b32e1-e53b-4e87-f5a3-08df3b5eeeb5
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 17:05:02.9513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sn5RoPYXflsjM7gt0Opk2sZmfJmYZOZnmaL3oT/3PqgdcOWc9vIlYo5MoyQhmVmIYePyWex9u5baloArZBvAqNMt5L2+mXHe33xSkJ7LoYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8895
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Eddie,

Thanks for the follow-up.

This mail is only feedback for the "we need to fix the OpenSSL engine 
support breaking builds on OpenSSL 4.x (and some distros with engines 
disabled in OpenSSL 3.x) but keep OpenSSL engine support for other 
distros that still support it" part. I'll get to the "support for 
OpenSSL providers" part in other mails so we don't mix things up.

Patches 2 and 3 are not applicable to "unbreaking-build-on-openssl-4" 
part of this series, please keep them separate for a v6.

On 10/29/26 9:13 PM, Eddie Kovsky wrote:
> Add support for the Provider API while continuing to support the existing
> Engine API on distros shipping older releases of OpenSSL.
> 
> This is based on similar work contributed by Jan Stancek updating Linux
> to use the Provider interface.
> 
>      commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
>      Author: Jan Stancek <jstancek@redhat.com>
>      Date:   Fri Sep 20 19:52:48 2024 +0300
> 
>          sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
> 
> Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
> Tested-by: Mark Kettenis <mark.kettenis@xs4all.nl>
> Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
> ---
>   lib/aes/aes-encrypt.c |   4 +-
>   lib/rsa/rsa-sign.c    | 102 +++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 100 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/aes/aes-encrypt.c b/lib/aes/aes-encrypt.c
> index def33a3b3248..0cb2221df800 100644
> --- a/lib/aes/aes-encrypt.c
> +++ b/lib/aes/aes-encrypt.c
> @@ -16,7 +16,9 @@
>   #include <openssl/err.h>
>   #include <openssl/ssl.h>
>   #include <openssl/evp.h>
> -#include <openssl/engine.h>
> +#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
> +# include <openssl/engine.h>
> +#endif

question: Considering there are no other changes in this file, is this 
include actually needed? Maybe all we need to do is to unconditionally 
remove the include (in a separate patch then, to highlight it really 
isn't needed and not related to unbreaking the build).

>   #include <uboot_aes.h>
>   
>   #if OPENSSL_VERSION_NUMBER >= 0x10000000L
> diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
> index 0e38c9e802fd..361ed0647bc6 100644
> --- a/lib/rsa/rsa-sign.c
> +++ b/lib/rsa/rsa-sign.c
> @@ -19,7 +19,47 @@
>   #include <openssl/err.h>
>   #include <openssl/ssl.h>
>   #include <openssl/evp.h>
> -#include <openssl/engine.h>
> +#if OPENSSL_VERSION_MAJOR >= 3
> +# define USE_PKCS11_PROVIDER
> +# include <err.h>
> +# include <openssl/provider.h>
> +# include <openssl/store.h>
> +#else

issue: remove for the "unbreaking-build-on-openssl-4" patch as that's 
provider-specific.

> +# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
> +#  define USE_PKCS11_ENGINE
> +#  include <openssl/engine.h>
> +# endif
> +#endif
> +

issue: The ifdefery logic is incorrect. This will break distros that are 
running OpenSSL 3.x but still have engine support. Such is (was, when I 
reported back in May) the case for Debian Trixie (13) and ArchLinux 
(they still are both on OpenSSL 3.x). In any case, we still want to 
support old(er) distros. I could build this code fine on Fedora 44 with 
OpenSSL 3 and openssl-devel-engine installed, so it should still work 
the same way now.

So, we know for sure that OpenSSL 4.x doesn't support engine so that's 
an easy check. For earlier versions, it actually depends on whether 
OpenSSL is built with engine support and we are allowed to use it. From 
what I gathered looking at how Fedora handled the "built with engine 
supports but doesn't want to let you build new software with engines 
unless you have openssl-devel-engine package installed" part and how 
Debian allows it, I figured the following (which almost matches your #else).

#if OPENSSL_VERSION_NUMBER < 0x40000000L && !defined(OPENSSL_NO_ENGINE) 
&& !defined(OPENSSL_NO_DEPRECATED_3_0)
# define OSSL_ENGINE_SUPPORTED
# include <openssl/engine.h>
#endif

issue: please rename USE_PKCS11_ENGINE, we actually support other 
engines so this is misleading and we technically could support both 
engines AND providers on OpenSSL 3.x. I can suggest OSSL_ENGINE_SUPPORTED.

> +#ifdef USE_PKCS11_PROVIDER
> +#define ERR(cond, fmt, ...)				\
> +	do {						\
> +		bool __cond = (cond);			\
> +		drain_openssl_errors(__LINE__, 0);	\
> +		if (__cond) {				\
> +			errx(1, fmt, ## __VA_ARGS__);	\
> +		}					\
> +	} while (0)
> +
> +static void drain_openssl_errors(int l, int silent)
> +{
> +	const char *file;
> +	char buf[120];
> +	int e, line;
> +
> +	if (ERR_peek_error() == 0)
> +		return;
> +	if (!silent)
> +		fprintf(stderr, "At line:%d:\n", l);
> +
> +	while ((e = ERR_peek_error_line(&file, &line))) {
> +		ERR_error_string(e, buf);
> +		if (!silent)
> +			fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
> +		ERR_get_error();
> +	}
> +}
> +#endif
>   

issue: remove for the "unbreaking-build-on-openssl-4" patch as that's 
provider-specific.

>   static int rsa_err(const char *msg)
>   {
> @@ -94,10 +134,11 @@ err_cert:
>    *
>    * @keydir:	Key prefix
>    * @name	Name of key
> - * @engine	Engine to use
> + * @engine	Engine to use or NULL when using pkcs11 provider

issue: unnecessary change for the "unbreaking-build-on-openssl-4" patch 
as that's provider-specific.

>    * @evpp	Returns EVP_PKEY object, or NULL on failure
>    * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
>    */
> +#ifdef USE_PKCS11_ENGINE
>   static int rsa_engine_get_pub_key(const char *keydir, const char *name,
>   				  ENGINE *engine, EVP_PKEY **evpp)
>   {
> @@ -157,21 +198,24 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
>   
>   	return 0;
>   }
> +#endif
>   
>   /**
>    * rsa_get_pub_key() - read a public key
>    *
>    * @keydir:	Directory containing the key (PEM file) or key prefix (engine)
>    * @name	Name of key file (will have a .crt extension)
> - * @engine	Engine to use
> + * @engine	Engine to use or NULL when using pkcs11 provider

issue: unnecessary change for the "unbreaking-build-on-openssl-4" patch 
as that's provider-specific.

>    * @evpp	Returns EVP_PKEY object, or NULL on failure
>    * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
>    */
>   static int rsa_get_pub_key(const char *keydir, const char *name,
>   			   ENGINE *engine, EVP_PKEY **evpp)
>   {
> +#ifdef USE_PKCS11_ENGINE
>   	if (engine)
>   		return rsa_engine_get_pub_key(keydir, name, engine, evpp);
> +#endif

issue: we should fail hard if the user requests to use engines but 
mkimage/rsa is built without engine support otherwise we may incorrectly 
sign/verify things with keys the user didn't expect. For context, I've 
actually managed to build an SPL without a pubkey and "verify" U-Boot 
FIT. Fortunately enough, I caught this before shipping an update to a 
secure-boot'ed device but the fewest surprises like those we have for 
the user, the better.

mkimage will still happily accept the -N argument which sets the engine
parameter, even if engines aren't supported.

I think if you have a file key with the same name as in the engine,
you'll then sign with the wrong key.

Think

mkimage -N myengine -g key

and you have a key.key in the local directory. If you compile with
OpenSSL engines supported, you'll essentially use myengine:key, if not,
you'll use key.key, without mkimage even notifying you by using the same
command.

What I ended up doing is:

static int rsa_engine_get_pub_key(const char *keydir, const char *name,
				  ENGINE *engine, EVP_PKEY **evpp)
{
#ifdef OSSL_ENGINE_SUPPORTED
[same code as today]
#else
	fprintf(stderr, "rsa-sign compiled without engine support\n");
	return -ENOTSUP;
#endif
}

so we don't need to patch all callers of rsa_engine_get_pub_key() to 
handle engines being supported or not. The same logic can be applied to 
rsa_engine_get_priv_key(), rsa_engine_init(), rsa_engine_remove() and 
then you have to modify much less of the file since you don't have to 
patch every caller of the function (which you had to do because the 
function doesn't exist anymore in your implementation).

>   	return rsa_pem_get_pub_key(keydir, name, evpp);
>   }
>   
> @@ -207,13 +251,44 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
>   		return -ENOENT;
>   	}
>   
> +#ifdef USE_PKCS11_PROVIDER
> +	EVP_PKEY *private_key = NULL;
> +	OSSL_STORE_CTX *store;
> +
> +	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
> +		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
> +	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
> +		ERR(1, "OSSL_PROVIDER_try_load(default)");
> +
> +	store = OSSL_STORE_open(path, NULL, NULL, NULL, NULL);
> +	ERR(!store, "OSSL_STORE_open");
> +
> +	while (!OSSL_STORE_eof(store)) {
> +		OSSL_STORE_INFO *info = OSSL_STORE_load(store);
> +
> +		if (!info) {
> +			drain_openssl_errors(__LINE__, 0);
> +			continue;
> +		}
> +		if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY) {
> +			private_key = OSSL_STORE_INFO_get1_PKEY(info);
> +			ERR(!private_key, "OSSL_STORE_INFO_get1_PKEY");
> +		}
> +		OSSL_STORE_INFO_free(info);
> +		if (private_key)
> +			break;
> +	}
> +	OSSL_STORE_close(store);
> +
> +	*evpp = private_key;
> +#else

issue: remove for the "unbreaking-build-on-openssl-4" patch as that's 
provider-specific.

>   	if (!PEM_read_PrivateKey(f, evpp, NULL, path)) {
>   		rsa_err("Failure reading private key");
>   		fclose(f);
>   		return -EPROTO;
>   	}
>   	fclose(f);
> -
> +#endif
>   	return 0;
>   }
>   
> @@ -226,6 +301,7 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
>    * @evpp	Returns EVP_PKEY object, or NULL on failure
>    * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
>    */
> +#ifdef USE_PKCS11_ENGINE
>   static int rsa_engine_get_priv_key(const char *keydir, const char *name,
>   				   const char *keyfile,
>   				   ENGINE *engine, EVP_PKEY **evpp)
> @@ -293,22 +369,25 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
>   
>   	return 0;
>   }
> +#endif
>   
>   /**
>    * rsa_get_priv_key() - read a private key
>    *
>    * @keydir:	Directory containing the key (PEM file) or key prefix (engine)
>    * @name	Name of key
> - * @engine	Engine to use for signing
> + * @engine	Engine to use or NULL when using pkcs11 provider

issue: unnecessary change for the "unbreaking-build-on-openssl-4" patch 
as that's provider-specific.

chore: (not necessarily you, not necessarily now) we need to fix binman 
tests when engine support is disabled (e.g. 
tools/binman/test/fit/dummy-rsa-engine.c won't compile, and we shouldn't 
run engine-related tests in binman, and CST for NXP stuff doesn't 
(didn't at least) compile either).

Cheers,
Quentin
