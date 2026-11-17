Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B459606A323
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IIr6bgn6;
	dkim=pass (2048-bit key, unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=P14+qEBH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3213406AE;
	Tue, 17 Nov 2026 07:39:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q-ABT_LQIzXK; Tue, 17 Nov 2026 07:39:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C6A76405AC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794901173;
	b=kioa1bmGqJrblStLDi2EKtDwLelh/sgBJ6J1QxCimlXhZ6BU3urA/yHKjg/r5SeBj+uG
	 jb0IMYhv9tq6pEUyVofwe0LdcFibK22L0D47to8lJUEfk2YVWXW0IpUp62f1ESUZCrrS6
	 lu/+JEND5VLFGjdLJHv7BX3eQLVcuiUX8yw6FuaJ/gEaj5YpqKFzYD7sh+TDrnEvNMT3r
	 zmQ8ZaHvQRiow0DKLWpv7Qn/wzHv5qWwYxPyVc/a/eLqyxnCU3Vb49/gW0CtfURu0ex+d
	 4xx3pyCbNH34L8PpXDB2uBWDt/Zb/xpYP+bT1lZh5sdfQjY0hVl56MQPQ/nA9nB+lTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794901173;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:From:Content-Language:In-Reply-To:Content-Type:
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
	bh=l+7tqMTO29h68mx3+V0v0N2ooSA49RkQQJxmF9xkSfQ=;
	b=sKWcO0C45BEzrbjSZlReptcR/XDgovSpLBtIfNpJK9+OAoweCfkRl0Qm2PnKb/6f5Ujy
	 ZyPqh8ePGdShULxcWs7jIRaRRNsYebFUcnSJaUnmi0tJ+Jjy4wBUaWmUWStQzp0wgDniX
	 oaZpLEGRwzQBKuxWwPN2JnzYaUrv6FXKPHirrE6RrkQ6n0R7Z2UDnZO3uP9jOU6fZPjF+
	 oqn06Ng8U/yAYpcTK58MXNsZYzebq6+WWV70C5MpuhcKA5SQlSfVH1Z01MUVQtHE1HAvZ
	 VBSQp1S9e2IKrxfze3lgU6OshYN/aPdHOuutDldC00H3G59nyHdISEfR3JyqRL+TLDA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794901172;
	bh=l+7tqMTO29h68mx3+V0v0N2ooSA49RkQQJxmF9xkSfQ=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IIr6bgn65vYG1zw0j0lUSN5SCMPJFZSiIg0R2Ah3OCpPZ62qS2THP92SjA+dN+zZY
	 f8HqmTk6qje3ezKSvcS54kSiQHrwR3smJb/L0paGPLy1Z8jYFXK1GK/8lwSNrafqWA
	 vhegVc1yd9kmeyo7kAvt0zWv3gjmwF+neug97SzlsF+sVl+R9kQq+dAMC4J4Iicf77
	 o7GRaevk4ro7xU2sNwMvh+V7Isd2NkmKd5xCGZo2QCpS/a4x7kPZuFvJi3J9hWOm8d
	 DNVrYesF0mYicn+gGboYttFDEPWOEWrUkcxDmT0dHp06SdDlXaxYZv03fGxGu1QBTv
	 rPpMYhcqnoX4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6A76405AC;
	Tue, 17 Nov 2026 07:39:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 81729260
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:39:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72AA1605F7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:39:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YnusJEhal3MI for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 07:39:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5A40D605ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=P14+qEBH
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A40D605ED
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+7tqMTO29h68mx3+V0v0N2ooSA49RkQQJxmF9xkSfQ=;
 b=P14+qEBHP1VAOk6Hx4H5FaZ/Q2KNoRJYRO4kHStBWYUwNPCSej45Y5FIPOTAuFRBAN0OWBQo01lGbCuBQ+HGSt1MCcSIjg2ineyesw9dummwshmSV3j+98IJwou05k2wIwzJiNrSn+KOWF9MSnUQtnvH2NcFe7hry/H65CJ8U0CQJgLD9DPdj8fUv79uzbXdDroFXPafvxGZ0b5bZJPgmp3MXICzKU7+F4ll+p5VaSCNjwAahIBlHL7nhtQ2IsruzHYmoIvcyZZeFjS85kVLC6+0jFmr9LquzSaAk2axCz+L9j66HJ/fSBar1sYCUPksZb6suo2gjtU/XhmvjOgXAw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by VE1PR08MB5792.eurprd08.prod.outlook.com (2603:10a6:800:1a6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 07:39:24 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 07:39:23 +0000
Message-ID: <d91839b5-22cd-4c42-ae22-feb4a56605e8@iopsys.eu>
Date: Tue, 17 Nov 2026 10:39:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] spi: spi-mem: Transform the read operation template
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Vignesh R
 <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Eugen Hristev
 <ehristev@kernel.org>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, u-boot@lists.u-boot-project.org
References: <20260927235716.1872707-1-mikhail.kshevetskiy@iopsys.eu>
 <20260927235716.1872707-3-mikhail.kshevetskiy@iopsys.eu>
 <0fd81914-a485-4bf1-9161-f2d4f0b17f54@kontron.de>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <0fd81914-a485-4bf1-9161-f2d4f0b17f54@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0169.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::17) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|VE1PR08MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 914b10dc-f723-44d3-e1e4-08df447de663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|921020|261022105027099003|261021121427099003|4143699003|11063799006|10067099003|56012099006|261026121527099003|261026130827099003|261026140227099003|261026135527099003|261021133027099003|261028144727099003|261021135927099003|261021130227099003|261022075727099003|261022115727099003|261022113327099003|261102123227099003|261021123027099003|261009221227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UJhTx15n48HHtqrQZWunUVuPaR1UBmWzVDntmq6dGKVicLSKbjv+CRVyt9oUVcgCkKTJvy8osooHNLS3A6pdQb1E+j4nsRWOXQR1OP56bd+NpoV9uC2fFae3bx6Xzq/xk8+uKlA9GbtsTAeFpsCz7n0xOvloBiJHbdisEYzMm4Swzyjr83lG+h8J6hVhkPJhEv06/r7nGcloMqn6l/xHiKok4c3xI3fF53ZG/uDc/fIjlG9axG7ZFzV/Uehc+SJp27RtXBpmHu1mS/kW0O8xMvBje0mjAKCxXiwziNz+Q9ycLImJ9Rw825LzY45LLNCPyzvgS60HdX/umCCqhWCOrRz3OEJ5MgTNmurMCKjFcrD7o/Duu9Agc25i3D9eXelPkVbv1r/r476tFpZXcd77SZpYxS6xzYWXwIiMzv1s2kzykD2Euxd7Ne4Mfz8sa3b4ipkI+11Co0lt4Sr7e7I2na3i4VXxgBYfq9If/aDFKobAMT3HwpKvAPMnw4eKOTTbDGW0MY0IueBlZ5Ur9nw0bnzmtxtsHkV12byf6Se3GZ3hoLcqEuuKs5KNc/ucJ9acX5nRbZNYmzD8hgTYIAt/CVPUPjAwMnYrePQohKP4sMLwYtH/eBRqjw6Y7vPPFm0vtJ3cZIdxNKQbDg5ngq5hsz8TIk2Si8qa0Qfs6h9jcptfy/JO+gk1bGKhXgXQnxA9PamJXyQoYD0W8u5Mf+0G3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(921020)(261022105027099003)(261021121427099003)(4143699003)(11063799006)(10067099003)(56012099006)(261026121527099003)(261026130827099003)(261026140227099003)(261026135527099003)(261021133027099003)(261028144727099003)(261021135927099003)(261021130227099003)(261022075727099003)(261022115727099003)(261022113327099003)(261102123227099003)(261021123027099003)(261009221227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzJselVQU2tFT3MzblJqSWhmK3ZDbHBRbDBibVFWNUZQUXd0b2FxMFViQWRV?=
 =?utf-8?B?QktJNFJuVmp0bnRNWjVxcFdKcEs1b0FMdjFibHlqMkFHNWtaWXUvNnp3VmtQ?=
 =?utf-8?B?OWVRdUNzMFBBNHRrVGt4Q1ZPcm5DclVuUEc3cXN3T0hjUkd0ajdNeWNvOHZz?=
 =?utf-8?B?L0dpWnJESTJNeE4zRDlyMERCUFg4alNFSkpYcFV6YlY5T25MQ29jZ3I4VVBO?=
 =?utf-8?B?dzJqSXdRTkk4aE5RcDN4b2JUL2Y0NDVIOUVzWDVDOUl3U0daRWZlbUNzZjAy?=
 =?utf-8?B?TUQ1QWRVM3UwK0daTjRHeC9ZZyswcUIwTmdMalN1bkNDWDVSMW1haElqaUVo?=
 =?utf-8?B?N3dmNzFqV0oxU0p1Y1lzUTJVdmxMMnlpZGhLTUVHRStDa1F0ajdYb0NobnFr?=
 =?utf-8?B?eUdDK1RnaGNCdlZ2MWdITVhiWGs0Sno0QzZQbnlzelR5Z1ZxcjF3Q3oxTEJ4?=
 =?utf-8?B?ckhpdGtJanVFNnZhNldsTFlWMTNSdXYrQitjV0ZlalZMSjhlUkJodzh3ZHp6?=
 =?utf-8?B?UW1HZlhFK2J1OXl3V21IcEthZ0VVM1dhSVA4cTRRclpyQ1hGaXZCV0pKNzQr?=
 =?utf-8?B?NU1RemZTbHM4SERJcUNJYXZyVEluVHVVdy9PR3pJd0lwVzdEWVhaV1M4aVRn?=
 =?utf-8?B?a21HK2t5VVptQmJiOWcvTTlFa0RBSWVSNkRwTjdTQkxJWCtSbVV1ZGFlL2NF?=
 =?utf-8?B?RDJEbjVxb0FJNWN2K0dtd2UwR1VkRm14aHVsWEZCWHprd1Zubkc4NlY4V0tB?=
 =?utf-8?B?QW53dVZ1OXlUbXNldzlPT1dwSlRISUtraXRQbGp4VlNCNWZCRmlxWE1LQm81?=
 =?utf-8?B?MmovU1dsRHhZTkUwQi9mMHkxWjlydC9JTVEzTGpJbVBiSThxanhYSTVnZnhH?=
 =?utf-8?B?SDFmSUJoUFhZQzdRL0VhWDdadDk5aVpwUmhneUZPSHVxSmM3WWozYzZQeFZq?=
 =?utf-8?B?Y2NRNVU1bVBLZlQ0Qlp3bWFjTzNTTExacldzblF0bXJhMTFzWk5WMGNrdGFW?=
 =?utf-8?B?OWx1bVRHSGEwNExpWHRLc3IxbGhzdnRZVC9tSG1VYjVYd3M1TEhsYUlxamw5?=
 =?utf-8?B?RDNESW84aEl5MmpaWnYvZTByUEh1cExHOEozd2ZheURHdUFTNVZPSlQra2U2?=
 =?utf-8?B?M3pwcTVhQWJzeW0vL3R1aG94NzdycE41WlZxdWxKY1Z4UUQvZVFySEk1eG5S?=
 =?utf-8?B?ZFBsZlpOR0tnY2I2OFQzTSs3SVdxcTcrc21mb3llK3BlS3NJZHdNc1JGRWNy?=
 =?utf-8?B?d0tWbmdNckp2R0oySEhvMHJLdXJKZllOaWN0Nlg3Mmx0emdpZVRXWTVvNCs1?=
 =?utf-8?B?bzdoRWpWNzNtWFpOZ0VQRXBzNVlJK0Y5ejAxVURCbjhmd3pVTXl5U1Q4L3Ju?=
 =?utf-8?B?cmt2YXY0bW9tNkVsRVJHYUZPUVlYYm43VlZneHFvWTlKOEt2bTdINU10aTBt?=
 =?utf-8?B?ejdENW5ER2szOGFBSlg3U2o2UzdLQ1lOMUVpS2t0MTJRbElaa0VCeGRtM1Zp?=
 =?utf-8?B?d3p0RDlpR2k3WXlnYWR6c0JsenZqUmRtWjRqN1BvVnMydUZ3ODNQdkRmOEhR?=
 =?utf-8?B?b0V2a05xYnE4Nk1BQ0Z0RGtocjdWd1huQzFxWVNheXR0WVFQcmFXV0JkQ1FY?=
 =?utf-8?B?YWR3dkdUYjRob2ZtTDZtai9Zd0NOUlFxOGxiSWhzWnh3RGJoR1FLcC9pU1Ex?=
 =?utf-8?B?Smh1L2owRFhveVdBdmYyQTROSDFyOVdFQnl6a3BqdmpWNHhrTjVEL1VMdDA2?=
 =?utf-8?B?VkNiOENVSmFtbnZpQXUwc2JINWk2bFE1aE85aENZSm1IYW00bEVoN29OS0Fj?=
 =?utf-8?B?MncvVlhSdll3VllnN1BGY0FFejVINHpacUdUR0lWOEhrMTJxbW9QK3pZSEZ2?=
 =?utf-8?B?aGRQNnpUOWZSUk5mU1NwdWtOVlI3UmJKV0NRWWd0UEFVUTlZaXo0YU00UkZ5?=
 =?utf-8?B?dW9COS9McFpjVDJ0dEV6dzBvTkNQVUd5OHhKVW42bU9NTnRnWVVLTGFCZlFH?=
 =?utf-8?B?bjFGOHBmMkhmeEhraXc3bDAvZlFOMlRYdG5kaWpBNWJNaFFlc2xWYWl1SVk4?=
 =?utf-8?B?TmoxWGRnemlLKzhnM25OajRRZytHNXM4SGEvKzZsL3lqeEVPZ0hQcFcrM2pU?=
 =?utf-8?B?WURFQ0o0TWZnMThmWHpyNFRsRXJ5aFhzcFJ4MmloYW8xY2wzRmVhcFYzam9v?=
 =?utf-8?B?Z2tNVWxpcUk0dTh1UmZhdVhwbXFwdVhVdlYzejZZYzAzMEsrWkwwdms3eElq?=
 =?utf-8?B?bmcvVlptMVdWeWlMcmN3N1Bac1ROSmU5cjdlYVRJb2Z1Rjk3YTJoM3kyQUhU?=
 =?utf-8?B?UDFRVndTSU5HaHFmWU1tOWgzWEdCaXpub2VBaFRTYkFrbzV2RWFEdXUwUkIv?=
 =?utf-8?Q?eUv5CXsk54wjCClE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 914b10dc-f723-44d3-e1e4-08df447de663
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:39:23.8719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocOftlOMIuwutMvK4AXpUFQsn0UdCwCkHln20EOTOeptNAteFbqkUrLY9u728l3Wprj9LaJ35bSDEN25tg2bWBlL3Jb1jBH2Hgy2C6UeMAQ=
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/7/26 10:56, Frieder Schrempf wrote:
> On 28.09.26 01:57, Mikhail Kshevetskiy wrote:
>> From: Miquel Raynal <miquel.raynal@bootlin.com>
>>
>> As of now, we only use a single operation template when creating SPI
>> memory direct mappings. With the idea to extend this possibility to 2,
>> rename the template to reflect that we are currently setting the
>> "primary" operation, and create a pointer in the same structure to point
>> to it.
>>
>> From a user point of view, the op_tmpl name remains but becomes a
>> pointer, leading to minor changes in both the SPI NAND and SPI NOR
>> cores.
>>
>> There is no functional change.
>>
>> Acked-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> [Linux commit: 39d0ea33123ffe0214217b529830ad91574c8757]
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  drivers/mtd/nand/spi/core.c    |  4 ++--
>>  drivers/mtd/spi/sf_probe.c     | 22 ++++++++++++----------
>>  drivers/mtd/spi/spi-nor-core.c | 20 ++++++++++++--------
>>  drivers/spi/airoha_snfi_spi.c  | 10 +++++-----
>>  drivers/spi/spi-aspeed-smc.c   |  8 ++++----
>>  drivers/spi/spi-mem.c          | 15 ++++++++-------
>>  include/spi-mem.h              |  3 ++-
>>  7 files changed, 45 insertions(+), 37 deletions(-)
>>
> [...]
>
>> --- a/drivers/mtd/spi/spi-nor-core.c
>> +++ b/drivers/mtd/spi/spi-nor-core.c
>> @@ -401,15 +401,15 @@ static ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t from, size_t len,
>>  		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
>>  
>>  		if (CONFIG_IS_ENABLED(SPI_DIRMAP) && nor->dirmap.rdesc) {
>> -			/*
>> -			 * Record current operation information which may be used
>> -			 * when the address or data length exceeds address mapping.
>> -			 */
>> -			memcpy(&nor->dirmap.rdesc->info.op_tmpl, &op,
>> -			       sizeof(struct spi_mem_op));
>> +			struct spi_mem_op *tmp;
>> +
>> +			/* temporary use another dirmap template */
>> +			tmp = nor->dirmap.wdesc->info.op_tmpl;
> Looks like this should be dirmap.rdesc, not dirmap.wdesc.


will be fixed in v2

>
>> +			nor->dirmap.rdesc->info.op_tmpl = &op;
>>  			ret = spi_mem_dirmap_read(nor->dirmap.rdesc,
>>  						  op.addr.val, op.data.nbytes,
>>  						  op.data.buf.in);
>> +			nor->dirmap.rdesc->info.op_tmpl = tmp;
>>  			if (ret < 0)
>>  				return ret;
>>  			op.data.nbytes = ret;
>> @@ -447,10 +447,14 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
>>  	spi_nor_setup_op(nor, &op, nor->write_proto);
>>  
>>  	if (CONFIG_IS_ENABLED(SPI_DIRMAP) && nor->dirmap.wdesc) {
>> -		memcpy(&nor->dirmap.wdesc->info.op_tmpl, &op,
>> -		       sizeof(struct spi_mem_op));
>> +		struct spi_mem_op *tmp;
>> +
>> +		/* temporary use another dirmap template */
>> +		tmp = nor->dirmap.wdesc->info.op_tmpl;
>> +		nor->dirmap.wdesc->info.op_tmpl = &op;
>>  		op.data.nbytes = spi_mem_dirmap_write(nor->dirmap.wdesc, op.addr.val,
>>  						      op.data.nbytes, op.data.buf.out);
>> +		nor->dirmap.wdesc->info.op_tmpl = tmp;
>>  	} else {
>>  		ret = spi_mem_adjust_op_size(nor->spi, &op);
>>  		if (ret)
> [...]
