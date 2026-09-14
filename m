Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEE0C88E64
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 11:01:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1CEF340638;
	Mon, 14 Sep 2026 11:01:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YLyUxKTVFg0N; Mon, 14 Sep 2026 11:01:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F19D84062C
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789383703;
	b=TBawVLlckF3hVfBKNmmrbxH15oVvhS9sbvfIYW3MHBDSDK/raFFDRJX+/+fPM8ZB3Mgx
	 JnX4gtOUfEP/XvXbiWkzxfuPnOYpeGPXjlImhozXiFoV3kkg9gXHbRylMF5sdtJat9apK
	 pcEnw98H4tg5f0yTrmnYgxRbzC8C3yy0JBXD8CDDpKZ33kN6H4z44lI/WamABfzyASw0M
	 VqHmKnBVVatTHGm+Ax4zN2Jw0O8BWu6G5r135sFE3xux3srCJda0NcZFPFSfSlF+c/nmQ
	 8AslvvzPb7Vv0vOyBJ00KJNJlaPp42KD0ycnbLoM3pAoYiFNOB8hlo43VzZlAiTE66Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789383703;
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
	bh=bqoFZztQzKpf5u0EK76x8xIRF8GSOZKfTB7d7NU+f7Q=;
	b=S9XEPF4fAVR+kE+sxqorDFtJYwBHUi/ivCvaY30GDmesIPITg9DglQhSUeQYs8+AbxNf
	 /P09i71sDQpO2pfXOVygVYCpqCvJhERxSL8JMrqJdu9jIidyiCpaz3vMqJfwJmEAOpRQz
	 Uzdw83C/srFp1L/zYfKhe9J/t3itrPFsii42qlJMd0WdhSTDMqDJtMl/BkF0NkjZ5/mpt
	 2nmlegjKRHRSx/Zrm4AsJMsuoRB1rSi75iTNAB4gyMrCPeEXfCCqbzkSRE6cdbbu/YrUF
	 BxUBMSbZ22yEZFfJsPnwu6f8piLHeQUYZUHcC6khNjluYYxu694Wk8T8ttHT1ecreqg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789383703;
	bh=bqoFZztQzKpf5u0EK76x8xIRF8GSOZKfTB7d7NU+f7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q5Qp9INSJWjAGxCoOD0m4tSBRzbS0PQ6C2CpbWxHwc/1UAA9KP47ItCV1bNdwdPnx
	 G3DiW6PlVpaGdHOtXp4Izv+bm7hTY1jLulHBw1s4ZbAqYkTU2u3gEWqgMvMAlhvXUa
	 uTbGO9lu2Xq9B39VfUAr/SCAU/yNMte5toY398HQmaNoQ9dOTSIv7oeF3MxiWtmogb
	 6y2IPATlb+9Bze1z/NKd3BnLh23rwC25JzfVkYgmsQrc9zTKccWRtYbPuVDLiAwRQM
	 foo5xH8NWzXaGDFhUppT0/gw0jJ2QOg9oKg5RtWfQ1pbq1S0Dr4BCmTniLQzHut7nJ
	 Wob0VvXzGL15A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F19D84062C;
	Mon, 14 Sep 2026 11:01:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 650722D0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B1AF605E9
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:01:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4MxqW7XuqlAV for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:01:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9DF7460689
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789383700;
 b=RwXg/kO5j3zbRkVV0mZma9pUVBI+QzEJJg47KJp7y/kr4+5r7hTyGJRA1vUj1QrrsMet
 cneeWkkB+wuZcAB94LjOFmQH5HoBUn+Rs+4dDUBK6Zf0DOe+LuauFAxDzrgAGj9rodGNA
 Keop3vzdXsYl72BOLKFt402QVcZW2hQllj7OgJqndDZDowUyPQVT847u//KTQYcpq0Rkz
 Nwnq3N+w8dMvsWNm7ojPHSpKJzEusAUAzvStVb+Pn7zehubXSd9gHHI3k0+O6xYUrXRyz
 BjCVr2R4BJImKdBDsDier8fODnetqa6p5WZF4fCY4LhOLea05evzh005Mr6yERdMsMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789383700;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=bqoFZztQzKpf5u0EK76x8xIRF8GSOZKfTB7d7NU+f7Q=;
 b=frR3fZM3wPJTJcaty3SWSu6TksgrFSlvCyMRQw0zIs0XW+Ssb9Uo3G/zp4dUNhMNohWS
 FKRvjQGskmknd6im3aKxKiUqHGwBsI/OA4SmY19k6zF2ApD20Iah/X9/yHRez8lFlPIaT
 LhMgJLWPaLvCdSOGBkAv2jcROfyJilh//iodylNvGQXMA9uEMjTP4EFoIISD0M3eaniQ/
 jDqiRB6zYFcN8V8bfpE/nX7CFrwJtczEt9XiA2uvCvtcgGeQZcRVJyLam3I9ICAQ+QPQe
 IWCTDODpewJx0ThEGy/b/07R0CM640GtuSq/7N4kxcnSvpZSd19mJqr9deca3MQIV9Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=none header.from=kontron.de; 
 dkim=pass header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=nlHcbPue; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=nlHcbPue
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9DF7460689
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:01:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5pnUZnebBbVvVw6fJzFStyE1rh2GTPjozuUKrcHFs5OY5MPpi8fSsXJVqxdOFr5zsE9Cfr0mCU2BP4pDQpjz9/I1bA3USwc/PmKDGXQihHiGSm88HcbWIBIvB4wH4Ij4slIQnf6UweRYsFGMkCSHrWUe+KIo5SKeRC06BDeJdSP3OGFfm1bW3Q6XWP4Ksb6hVSJX53GdS97dSRz38tYPcpAEh4nLy4SjjyHVPMQDc63TCi/CG90zbMtYyOc6iqTl11a475xmCnrOUzQ3e92l05IqOKRFEjOHiEnh8ruS+IHJ9fo8E0ec9o5PHXMCbbilu+1wEOV2gfhRF+Ht/yO/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqoFZztQzKpf5u0EK76x8xIRF8GSOZKfTB7d7NU+f7Q=;
 b=XpH5EznJK0Jh1mNfSOSnwDLY8p6mhC1TfY9KtoBegfAIqcjVD0dd+IJr/vqUOTZthhUnECiQizi/iIODEfT/+iAL4fzuLmmOXG2yzhWIE9BW1Jf5tFip1EBw/kQ503sizVltcshM6xUzTIfACgUtgzcCsHLeXdQ2GFv/V4qQuHHNrZeY3188zXHhlrfOLbIo+LLWvQRzTX2D2B6IRROwuB6J8hos6FO99CUgrJNz2I7ok/IhjWBV1E9kptsaMQjTRZG9t4lr06PItexm9UHhXxbfMzFHuyqqXFfc2+0wQABDzJUERoZEkr1nJuzV9zmBJFajV8QxiKuB8Pxu9Muf0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqoFZztQzKpf5u0EK76x8xIRF8GSOZKfTB7d7NU+f7Q=;
 b=nlHcbPue+1gh+vFLSQZJBqa7KZ0nwE1SEl42YfMSBEpREVKVgbS+kU/1zVc1Dr+aIsymaXtfUIXxT51ADJPKNte0q0wJFjZDABFYQhjnDQ/TK+x3oOSGYqDaYJ0/OEYC8Y/RD6DcuQeV3OTnH61IEeB3rOgUbc5kam0uc/X0DUIXtsJ3a0dMkYN1Ra/q+pZiEWlHZjB38wKjiIB28YxpWxD//g+8cvx8LQB/Tpeb8RneMvB286yVVK3v9hRul76F8sqbPxNJswuDc5SADPGJ2ckFMFrtuxDtN/xQzR8UB2SqhoCvQiq7qv/UnOaFncoVxEZNh/qeD25EOHJD9ykzgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by FRWPR10MB9225.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:17d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 11:01:31 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 11:01:31 +0000
Message-ID: <260a4db7-8cff-402f-80e6-ea8b2fb93148@kontron.de>
Date: Mon, 14 Sep 2026 13:01:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] arm: mach-k3: introduce basic support for the
 AM62L
To: Bryan Brattlof <bb@ti.com>, u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aristo Chen <aristo.chen@canonical.com>, Udit Kumar <u-kumar1@ti.com>,
 Andrew Davis <afd@ti.com>, Daniel Golle <daniel@makrotopia.org>,
 Johan Jonker <jbx6244@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20260804-am62lx-v4-0-01746157643d@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::16) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|FRWPR10MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f252c82-25ee-406e-8425-08df124f8834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: TD9pXNtol++KPDn2X9XgHkCX/No7h3bs4kqWMmOj35yvF82RIOEmnX230Oaw7V/t0bu+SakSyWt1WxripL1Yyd2VYsPKTa+Mtn6q5qHrbfK0drBTGaUh74bTa27jyn5PBomXN5cUIv44XQMEviq2ABUoVbnfJLEendigauaa4QmKgFIexrV01t0oFMYakfGbjPo5Tt6BDKLEfqbbuE/N5yhtTRl5gNfPXwS7gT+J0LFYFplMNd53t/8fJcSsTaqTB+rqDUsyp0gEiqHFbxNFTe4s2tH9BljQJds8RQXDFWlbSNS4mHFBHwiTwkvrLwOw/7e6luEALlTlnaKdbXSPP6itwJ3N0WhlIyDBCmisxiw3W5wIJOqG8bbYJpjbQ7BKcpEMIqSOdULid58aPZO1UOH41eIyjtonGzW0JkzminBmloX40yc49vYGZSyBlMNQnXQlNBXXWGTkcohMTPe5tsKMo0s/K4Sz3pI5dBLKUCU16NsCaT2bdKHD7mPIo6w4prEEAcff2hWGUhiVXnC0FLiqvDfyr8q+Sg3Pf/39ENa/K5XhLAYio6xGHOB6MzRP4x65vKHtUpc/9SKi00yxEa+1fUzmQNLHHat2ybqC8d8/8aw2PA1o+seloIdy8I/1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWplRmVjNmtVUE9STWZpajBMSmMvUUVjeE51UmdhbXBjVVRVY08xWUJ3Q1NH?=
 =?utf-8?B?bTlmcXN0QlBUQmZGcEIzNElUV1BZY0FBeUgyQ0d2b3FVNGIrSEJiZytsN0RI?=
 =?utf-8?B?a2RLanJhK0pQOUFCTUhTaXhWclVmZWxEM2ZuN3BKbDF1dzJ3U1g3cm1mYVpH?=
 =?utf-8?B?QlU2Z05GdWFGNFp2QVdISHF6TksvU0VYUVJEYlQzcmp4QUxkSlZ0Vlh0ajJy?=
 =?utf-8?B?VjdwOWhRemdiTlNGNmVBRWlKd09KQUxmTmxqdmN6Z3dvZkcyWFp1YkNQS2s2?=
 =?utf-8?B?QjFxR1h1S0Z6aXZrd21GM2RtVWlDeGRFY3dDa3U0YnBNRmNxQ0JhOGQ2c2d6?=
 =?utf-8?B?VUFLZnpBYkNZZE1OWXZ4UFpXNFVtejcxeHJJR0xzQ2p2VGpDWnIwNXpya0lk?=
 =?utf-8?B?eTAwQ0xycEhzSXFDaVFPV1k3UC9YaFZTQk84YkY4eTNTak5TWXZmb3htREVJ?=
 =?utf-8?B?RWpIeVNhSnVCK3ZOcUxhTjU3VFVWMWZJRGtOdVdyekhHR0Rqd2luWERXODlI?=
 =?utf-8?B?bXVpbjZBNE5USmt1c0R5bXNZUHd5RVI5cHZKK1pkTmRQQWE1ZTBoK0tvRHdr?=
 =?utf-8?B?QXFPZXpydVpxWnpkM0pZQTJRQmVGZnh5c1RRWXFGV2xZZDBYTk0xNUlKT0Zi?=
 =?utf-8?B?VytNaDlqQ3RLamJDU29QRkRpK2VOa3Y4Q3UyUWZVcHdjRmYzZFhIclM2eFZO?=
 =?utf-8?B?UHpqd0VqenVFbHBQUlZaM2RxbUQ5eS9mSi8xb0l2Zk1zUFRNazVUdW43TTNS?=
 =?utf-8?B?ZlZMRlJ2R1BkQWozazlNQkQvdzlFYldhZ05xeS94bmNFYzJ6MUJaeTFDMGVB?=
 =?utf-8?B?ZENBbnZ6b25aRFJiM3dOZzRlOEdKSTRJbDhXQ1ZtQWZENkdkR3FPUkc0Mkt0?=
 =?utf-8?B?eE5lc3RNejNPaGYrUVB6YkZOaS9obDZ2Sm00TmpiTzdFanpObGJnNTk1NUl4?=
 =?utf-8?B?NU1RS0c3eEkwTTNKMlp4SHA3U3JWbWFNbUM3a3hEekI3MzJSWjJJTmxWQWd6?=
 =?utf-8?B?bWVvYkV4V0Z2VTBtT1p2bXpkR0RHeDZyYmZUMFNZa0pCaFJIRC91ZDlabUJu?=
 =?utf-8?B?ZDVDZXpZRDIzVWx0WVlsWkJ2Vmc0RVA3TFdkYlFEcCtwOTZsTFpSY1IwR2ZH?=
 =?utf-8?B?b2VHMC9aWWErVUJhS2R4eUtqaW1vZGw5cXlTTU1iSzZ4ZlNQZTNJYTdpeGlU?=
 =?utf-8?B?TXpmN2ZFQ1ZDNFU4OHB2OXhkbXRGeHJ4czNhOENPWkxIUUZaTkh3NEdyTDBl?=
 =?utf-8?B?b2NVVjdKTkE2WkUvQ1lleFlTWHVLNzZ6T01Bd1ViQ2krWmhTdnVURlp6VmhB?=
 =?utf-8?B?NkdiSncwVUcvbUZkQ1QxQ0wwN3FXcTBwUlRiTTBYRlZ6Z3hnem13UG1pcmZ2?=
 =?utf-8?B?V0M0bTRLTzB3aFVESDR6cWppTG1sWHpRYkxxUUhiN2FWQVhOa05nNVZvYm91?=
 =?utf-8?B?UUNaZ3VjdmFGL2FRdS84eUZrWVNlU3FHc0xGdGxLU2Z4ekVMTExlVko4eVdr?=
 =?utf-8?B?L3VNZk1zRjE0QUZURTNtMzB1MEViVEozejlYV3dLVzZ5NitCanUvbGZsR2Vv?=
 =?utf-8?B?ZmZjQkRDQVlrRFY3Z0IvWHQ5d2NnbDMra0NiNUVTNGx5NzRjNWhZT0k3ZmM1?=
 =?utf-8?B?ZGtEYW50Vjl2aTNQbnpMSjB0eEcva05DQ1MvSm5uODd2c3lVQS9LckJJNWdS?=
 =?utf-8?B?RWhoYzdDZ3QrYzdDYmFoNXFmQWxockRaN0ZPUnBMTjVhTkx0UTRTZE1ldllm?=
 =?utf-8?B?THJ0WW1yRWN0dk1wcmx5SURxTXZqR2RiOStTUXFLbHVnMTVINnd1Z0xPNzBC?=
 =?utf-8?B?V25kMlpLTURBdUJpTFZBaXhVcjhqWXVzWnl6OGllMG5zK0xuVTA5OUg1MEdC?=
 =?utf-8?B?SHN0NmJhNTU5V0J6NWFsMXVjWnVYckN0ZzlIUk5QSEVlWFlnTTVhTUVkU0Zj?=
 =?utf-8?B?RXpRKzVadjd3c2NzSklPVEVUaDRhWlFydk8raTl0Y0tsVnFVZFl1ditTSjlh?=
 =?utf-8?B?THhEZlkyQXlUVUs5YmxHWGtuWVdCWHg4UzMwcFV0ekNQYzZhVlRhcmJOVmZF?=
 =?utf-8?B?eS93Y0xNR3U1SmhEbHVjUzdVa1ZXaWNhM1FqSHRFdXdoWnl3aW9mTnluV2RP?=
 =?utf-8?B?TWxLZkNpTXlqYXFRdnZTR1Fsc1czTlJEN2NGMXB4YlQ3SHJWbXZhV2JGYWtG?=
 =?utf-8?B?YXJUNXhmUGZlZ1FQZVhpR3I5MTRsTmlyMGVoN1lhRVY0RmJ3ZGVDVWNNYWRN?=
 =?utf-8?B?Zkh6MU13cWVzejFsZ2gwdHFiaGlYRkJmTWNpQWY4c2JVZWt1QlV2Z2dDYS9V?=
 =?utf-8?B?WXRBdDJ2aUNqRkxEdWlubmlBUjdVdmg0NktZYW5zSm5WMjIvT1BDY1NSVXVL?=
 =?utf-8?Q?+g3eA5jm5IQcVLKc=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f252c82-25ee-406e-8425-08df124f8834
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 11:01:30.9569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fppAJj57Nu8wyk+kZgACJ8kE5HkgaoxFNFrksuAtJ0VbTHxSJb14o1EsnVNFoGf58OWMLqoLbMuM6V8IV03zkJBzzEfukkw/2H8520Tkx+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9225
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

Hi Bryan,

On 04.08.26 23:54, Bryan Brattlof wrote:
> Hello Everyone,
> 
> This series adds the initial support TI's AM62L SoC family along with
> the AM62L-EVM reference board.
> 
> The AM62L is a lite, low power and performance optimized family of
> application processors that are built for Linux application development.
> AM62L is well suited for a wide range of general-purpose applications
> with scalable ARM Cortex-A53 core performance and embedded features such
> as: Multimedia DSI/DPI support, integrated ADC on chip, advanced lower
> power management modes, and extensive security options for IP protection
> with the built-in security features.
> 
> Additionally, the AM62Lx devices includes an extensive set of
> peripherals that make it a well-suited for a broad range of industrial
> applications while offering intelligent features and optimized power
> architecture as well. In addition, the extensive set of peripherals
> included in AM62Lx enables system-level connectivity, such as: USB,
> MMC/SD, OSPI, CAN-FD and an ADC.
> 
> AM62L is a general purpose processor, however some of the applications
> well suited for it include: Human Machine Interfaces (HMI), Medical
> patient monitoring , Building automation, Smart secure gateways, Smart
> Thermostats, EV charging stations, Smart Metering, Solar energy and
> more.
> 
> Some highlights of AM62L SoC are:
> 
> - Single to Dual 64-bit Arm® Cortex®-A53 microprocessor subsystem up to
>   1.25GHz Integrated Giga-bit Ethernet switch supporting up to a total
>   of two external
> 
> - 16-bit DDR Subsystem that supports LPDDR4, DDR4 memory types.
> 
> - Display support: 1x display support over MIPI DSI (4 lanes DPHY) or
>   DPI (24-bit RGB LVCMOS)
> 
> - Multiple low power modes support, ex: Deep sleep and Standby
> 
> - Support for secure boot, Trusted Execution Environment (TEE) &
>   Cryptographic Acceleration
> 
> For more information check out our Technical Reference Manual (TRM)
> which is located here:
> 
>     https://www.ti.com/lit/ug/sprujb4/sprujb4.pdf
> 
> Happy Hacking
> ~Bryan

What is the current status of this series? I would really like to see
this find its way into the main branch.

Thanks for your work!

Frieder
