Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8573CC624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 09:54:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 962DF40B59;
	Fri,  4 Sep 2026 09:54:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tAG5ssHtzxQY; Fri,  4 Sep 2026 09:54:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A419E40B48
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788515668;
	b=JNOVvKyUkM7ApHfFEGGy1uaFJXjxrHvviXnp8j6ZIf4TMhkRDDuOOkgGB1kxhJkvPLeS
	 FbC5E/eBMJkrt0x5DiEyJuMej+Bky+yL/+BUiF3VgwV1+ex9xtEtAz8HCF1cxWpoEjDuz
	 LBTId+c1n4PXUEGk8a9C0nXb6CDeMkHPOwtF2TCUqMeHkgpgO8ddD15LVb2O79922yUL/
	 MHPBSMWIbBj4ZoEP9UpaOxsi4M9a7ttsiLKMohd5rk8YymkDW465QiVIwRMafNp8sEsZ3
	 k9TDR7wRjJhBRHr2iIniy4kDruaacNj8CC6VKsUW+bhe4/Vzm/32IShmXglAJflBVqQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788515668;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:From:
	 Subject:Content-Language:To:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=t/a+sXadPpLARkMTRiaO0nETjb5YCU2CFBvG79eZ8V8=;
	b=QNoaEiRPafrCyVMCKXz7thMQt1Yc8tMXGatAsBEF115YLda+b3oSWylN7aV1Vi1qVXRh
	 b0ECDRdlQFrVsOtlkPEmFPKS/WZXWhj232zXSq9Em9BldIQoBFJ4BPvCoGbO7W7AInjjh
	 ryIqRSFhRHLubZNzSMA/ppM6KpUVALitOiiZDgEeqNoOW725ALjr5GaMO67rdwm5TJREg
	 CatvqjNMWBkKvf9qukszaRH0NniCOjavLQD5PP8HicY/hVM2PAg/zwCtpED6oNQWZk8da
	 bx1eXZd25Z44qZdhiAWn8LTU7rnBbn3dfrgr8aRPbShNwY0dT3DOleE5D6H1StOChuQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788515668;
	bh=t/a+sXadPpLARkMTRiaO0nETjb5YCU2CFBvG79eZ8V8=;
	h=Date:From:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=q0AM1Sm5d5qBM5nzWsZCnC392Ahe3BSCh2pMbYVne+dTalk0IdGXrftouj4ruaBHY
	 3IlAub2/5UfPpxhBVokPqGj1MexOFj8iG8FR1cf8O+dcyxcuLc4xIQ5aOSTxxgfFg2
	 +806sXoQyD+4n/VIqu5OXuqLtGpoqlQ11shkKXtj3IOfxB88wLLVM0T8FFDxwGqFUj
	 zjt2+ba5dbKqZUW5aXOH04tMfx/bcP07Q7vQ4ohBD8Plz63Bls6A4lZbrOSd1r/7Gk
	 PLwAJWGHpvZEfr3rMS6L74ntx4EGIQ9kxKouwIgMIbvlsTzo73EBJaE/PlYubsNCkM
	 XpgT2XVJXtIZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A419E40B48;
	Fri,  4 Sep 2026 09:54:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E5AB53AF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 09:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D800C400A2
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 09:54:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LdIqUKRY0uR6 for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 09:54:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5080640080
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788515665;
 b=RheIZ+DoZ9wVGFZFDlTuTkYbx2kxtyzDRlpqOHxVOoGljUkJRq+PzYHI3W6kjFs/iqer
 LaxthL5KVy5hFG+dn0Fg6tbQoPGF2lKj6q0CennB1fGegO7y5BsEXPRrC+dN1BrqGiZCS
 kjzSSRIMFEDdX7juYxvB2jJ6IGOjR5qVEI6iJFHsrh6mOaZwWWRfrL2MDk4cEA4LK6zBr
 IfKIzu7q2Q0hxuZF02/Leire4rbeV2sUXPyVadF/XrDdeLRzBKMWJNRF4YRx9AwyLGLb/
 KR0GcL0WpyQspBiffEUmPNj7qspq8+ZQ1OdRc3+eaqulOOrt/BtAo/CGW1nSN46QvKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788515665;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:From:Subject:Content-Language:To:Autocrypt:Content-Type:
 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 bh=t/a+sXadPpLARkMTRiaO0nETjb5YCU2CFBvG79eZ8V8=;
 b=GSVHu7PWOWLCaPxCDH6FpEekcVqPxW7o5P5fajjkabanmT69Q5DVTBa5NjCJACC90WEU
 afduDVyJxcCRgm/5sqUHOwWHB5N/2p0kr0peiD5WsZc8m5LGK6KgWY0ba/n4TPUsXg/++
 QwWR2VfSbYI4uxzrPE4657Q9q0NXVENTRrLjOzFw4Gj7pAUf8sKwpGI/d8DIiLb9HkXZ4
 OjRHJmYZtA+k8eFwDrs1INyTif1LGeTPGKVWZhiNuWTfU1+E2bO6hpofnmLpfiwScydux
 WPOVx5L/jlmDoyq3bt9rVN4DvHST6zongB+tne8dZIKpDtpHZf6Cb4H0ct0zlR3EJoA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=gSmiYO0Y; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=gSmiYO0Y
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5080640080
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 09:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHbkMp/zcuhuvzzgOHYNdrnvGCfMniRUVc1rolP4SlUXZb7niu0rNg07JPjOnfdf/7Rsa5zCngFJXpUP0qfHAgUg82CxzOaV2f/iXWfZv6ay8Cq3JJw6Dtb8BhKH6qmz7eivwfsELBB2LmhBf5M6ogEjSoIa+oGvCwH78V1691//TP0Vjqyjvsnc6sCYeRVuC7utZpPlc1FVKs+mcivnq8NhbZCPaD+yQAc24wkCzb7qDSEQ9VtpwvYH3xf3/I8hdMXj/aHocVRxe8QpPWTej1velTvYMlvHLONqZtsVy2NLD9FWC6JJ9pfCNt+TlME1sSL1ZtBC6rDtolPWHcC6wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/a+sXadPpLARkMTRiaO0nETjb5YCU2CFBvG79eZ8V8=;
 b=jyxihCB87q3+tg4vQRbvp/qr/okBOTVf2HeMPjMLTijU7iE5NKEU7JGvt1/GmFS75JTEKT9h8mtHM8XlnGdGelIuivaZaeDNi5qX7zMyIuKPwvz0GP+P9a+zH04b/oDpkH9U6U51u0338z3Py7TF3P8FpNiOFzWt5lCsbtGq9T3UQv60JxHHl9fgfS+o69QXgYAyG9ionsna2o+DBYXR1gFmAcEGDYskN1jFy0QlTVlRSfUFdhGU2k8XvzrveIktfaejo+NcaTSWKDYdUkU32gwHLYjfgZcrETRD6u27RV5f9yAkwqRoffz+iJH/ryxRsm3nZfoszQ397BBWeJflqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/a+sXadPpLARkMTRiaO0nETjb5YCU2CFBvG79eZ8V8=;
 b=gSmiYO0YUawS58/aCX+hgBynCaXfd4EjEScLlHWQrbOtEnhytQO3ajkrPE9oWgxRAOgf9dKdEDVQYNJF9IampZ4ceSFeHIttWqwSE834CzCyyQ5IPl5VJFw4vBdEy3+IxwUT0IUWzhoF3Cv5bTKzHjZl4qh/RwYLvMT5J2FVYIKKQeWcvP0QPQ1o+lAV664Gd738qEX/7t1F8YnyXaZ1CLol/yyI8aYuN32ASR/i651ITWiFVMTKT9SLytujKksqLshz3kknPsGGO1Xfy9ph4j0VS2u30E5UYZ8UbSaYT1+YX9iB8ohefQXFYF28DSEsvXTWoBe3z4819HANOHrSFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7442.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:300::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 09:54:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 09:54:16 +0000
Message-ID: <cbed1b19-f171-4388-9614-13f89a9820dd@siemens.com>
Date: Fri, 4 Sep 2026 11:54:15 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] watchdog: Add support for i6300esb
Content-Language: en-US
To: Stefan Roese <stefan.roese@mailbox.org>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: c442fc35-8a42-402d-0c91-08df0a6a7b6f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|3023799007|11063799006|56012099006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: Mlwcv+SwMdFuiqeXEIStvhU9eWDJ3VMuu9xl47coTM4MxJSNEGuEIAT8ctRLaoOW+ehOfEQaPtI21esEk1G2LPlHRfhECH87A2cCnmzDrTxVBSlnEtpV5yrYgOZEmXVLkmx30AxavaAQBVkv+ivJZDQwrNP+g5h3jGvv5Po6q+mIRFAKV/UFTZqf9M1BqLX27aZ3RbpQU3iA+VtUAqXF5DQR/VreyP2dWVYx5Y1sPf/tUvJ+3cOGGXyMGaIgbqnA12F/SQgJpyE88LtCH+LP6epFI+wiAb9YDYbry7Ly9fpJ9v8HB26CHlRUueDCQxuCipFq1DLi3NWWGNf/ylR4n9feJqSs5JhNiBxI8hQ2NxU4I+0oODvveKAVbseLDKLRFck2gGgz+DH/km9NuHLgcHps9HdY+Bo9GJXzw5Ct/wxrviGBgEg93mgvbtrgBuTCjFb+KK2UuC2O/Q9ZTycVNyzLuJWC7avRE1QQSohQGWazQpXGtb7wbXEdA8co3IAB6TS79KsN32TyAXZfDLZ0209NPOd1fDjsqi51oLa4XfNID7B3CF8sp987+hGNjQc4LIl3MSbx0NbRuwvmGB0FKx3vCnRKfyZMjvxLWylXdWQfpEuMhL0cT36ZWJF3Fodzjl+Pnho4TXXO8V2Gt+qcd8r9GSh4bQ9ImXpzZhPU0Zo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(3023799007)(11063799006)(56012099006)(55112099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rnp1NkQ5K0hCS29zaXVTM0IzbFJqdm9LTStvcGtOYWJNcVBmQmtWWkhVakNW?=
 =?utf-8?B?QVBGc0ZMYTZEQXVxS0V5clIwT1RPallzSkdnZUU1Q3luT1lCd1NwdVA3OWd3?=
 =?utf-8?B?dnNRbm9iYkNSc0ExelcxMXRQaUhpeWFtbGlzdFRXaW1OYzdTSm11L1FtcUg0?=
 =?utf-8?B?RW1UeWFvQ1RtMDc2R1kzRXd2NnEyVDB0VDJzY2xyTXhkUkphTHE0ZXc2RTVW?=
 =?utf-8?B?Q2dYb3NGRlJYNFAybDMrMzhZM0tNMG1BRkVhTjBJTkNCTGRtb2dPRFVLMFho?=
 =?utf-8?B?cVlRWm4vaGhrZFlCV0g1YXYwWjh6ZmlJM1lidXZWNUtlQmZUVGFDKzNPb3dR?=
 =?utf-8?B?T1NHK1EzV0M4Smg1Q1lMZUxNNmZRbHJGbUxKZVFIbk9KMHlEbDdTLzdCOFd4?=
 =?utf-8?B?aitqT3BoRnVOUlR4czNiOGJCNk84MU9xU3BtWlZFU00zUWVDcXBJVEpGWmYx?=
 =?utf-8?B?dGhWYkVMVzh3ZHM1WjFnMk1sTEZuMGRGaHRnM3VSM1lWRUFPZlpiK3ZEbHJt?=
 =?utf-8?B?Z3NISnJlVVV4ajNIamVRNVhmc3lVaGptNVMreEJrZDM2czF2c0dQeW03eGcr?=
 =?utf-8?B?MjZqSVNEYlNCR0JVWnZaaWRHTDNwRzFCQ0h4UDB6MWVmVVRtb2lGenk4K1pE?=
 =?utf-8?B?cEpHUkswaStjN0w1NTNEeUEvQ29GNkFlRExVeWQ5Y1BLeFhZckFZK2txZnd5?=
 =?utf-8?B?K0ovVldwVW5GdUxNNzlyckltSDFNNU9nd2ladHVsSHpPYTh3SjBZYXN2aUdQ?=
 =?utf-8?B?UGpWaFVnL2tieTBvZ1BTM1pSSmQzaUdSbHpsajBCVExxd3A5V0VIVEVsMjNG?=
 =?utf-8?B?UEtSV2g5NWhXYnUwTmVSWVZpejZFSExiMnBnaG5ldHhhYlRiOFJidmxJK3Br?=
 =?utf-8?B?aXJHOCtHT1pEaTloLzM3ZUcxV3hXSVVpYlpQWW54cFd0TEJBSGs1S25JUHk2?=
 =?utf-8?B?MVFWb0lmUmZqMXZRVjFYcWtHcnZhS3pSM0hMTmFNZGpTV1NDVXUvbUZzMUNo?=
 =?utf-8?B?QXBZcnA4ZkhCNkdaTjRMcWRRL0pyTmdMTnRiMmhIcmZBQUtyMU5jSXZJNDkv?=
 =?utf-8?B?S0RBWjY1ZzBpajl3UURhOXJQMG16K0JCUWFGOFNBWkc1RnIwQ2RFZWZmc3dF?=
 =?utf-8?B?dzRJQTlabmpwZ1pJMmJkUkxVVnliMGlWQjRkeFovVTRmZlptUTVLUm5VRGJn?=
 =?utf-8?B?Y3dLQzgwVU1UVXZ0bTV4QUhmak84Y05RdU1CcVRTK21EdXY4ZW9SNzRvU3k4?=
 =?utf-8?B?dFF0bnZRRHpHaTI4STUwMHJJeVJYTGdCQnJYbGdycWN5ak1TRDFkUUpzN3JU?=
 =?utf-8?B?YjM0MThUNnl1YkQ4cDI3ZmxPb2IvRjZ5bE5wUnNvTmVocmF2NlhmNkIrWHN0?=
 =?utf-8?B?QzNmODJLdElWL1RSQTJkWUVaUnpsSnBrT1RINm5SbU1UQ3JtaVEyMkNnZU94?=
 =?utf-8?B?czNrVHVQc2pnemx6djRYdWVZaWdobnpMTkRUdjZZZS9nZjN0VWxaZWdsOVRL?=
 =?utf-8?B?d21IeW5uVFptU1dVSXFWQm5HY1BwQWNVNU1EWXpMNEcyNWllWkZzMi9BT1hX?=
 =?utf-8?B?cURmVG1odEdFaEJ3SVJ2MXpqbWFCMG81ZzBMWUltd0V6OHY3NW9sQnBFTUFs?=
 =?utf-8?B?QnZ0Qmc2bEl2L2k4R0JleDRCYkFqNEJNcnVvUjNRdzV5bjZTMHdDb25Hbkp4?=
 =?utf-8?B?cFFsZDVkVzJSeWRrejdtVjhxSURScWZ5R3JtZTBRYkFRb3hOOER5TXFxR3V1?=
 =?utf-8?B?TFVVcURRNDVySy9tUk5GVXpUNER5U3grVklXd0JUWmNOSk85SWJhK3pjTExw?=
 =?utf-8?B?OEdObzFFZVRMd0xFdnNVdHNPYUpKbjROSFFjQ0xuVElDdUthVFVITnlqNVZp?=
 =?utf-8?B?RlJxYkc4bld6VDV6R1FUbFM4SFF1MkJmaEQ2cndWUFZ1eWh1WldWWVg2M3By?=
 =?utf-8?B?MzZDMS9PZC9CTjhSY3dUUDZNNkJTUGJnbFYrTzZUTU1vWFE1ZVNndEZHWHhU?=
 =?utf-8?B?OXdaNmtNR2ZyTkRyOFVXdy9VZ2hRRU11OHBUbUNFc0J1S0lwalZObWF4N0FU?=
 =?utf-8?B?RVRCLzJzcFg4Nk5UUkppbmpyWFBFYUIraWxYT0JOWGEwSURDN25oL09RdW42?=
 =?utf-8?B?bFQzcUUrcHNaYnhPZEdPR0NFNFpDYXRmMktsZ3ByZGpCTjA2MzJJUWZCRkkw?=
 =?utf-8?B?UUl5U203a01yUlNONVg4eEFURDAvUDhhMThub0ZpYTdrdkZEcUh6NWhhQ2Jl?=
 =?utf-8?B?NEN3MmJjWWxrcWdyMHY1dEZyb29ZdG8wUXY3K3o2eFhSS1YwUWZGdWxiTzJE?=
 =?utf-8?B?MjNRWDFQMU05RmNhUEY4bElpaXQwUktWWlk5UTg1TGtkNk1NR2Yxdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c442fc35-8a42-402d-0c91-08df0a6a7b6f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 09:54:16.4993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wD/ErTdlQHm3hgRvkPY/tSoRjMjVWXhc3+wXfJQARd7DEvTF5fwuMEiE5aSA7v5gLP0+dk4o1ja1UNMqpwYDEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7442
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

From: Jan Kiszka <jan.kiszka@siemens.com>

While the real hardware might be in the museum now, this allows to test
watchdog integrations against QEMU virtual machines (-device i6300esb).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/watchdog/Kconfig        |   9 ++
 drivers/watchdog/Makefile       |   1 +
 drivers/watchdog/i6300esb-wdt.c | 147 ++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+)
 create mode 100644 drivers/watchdog/i6300esb-wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 3c56c541505..225e23ce247 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -494,4 +494,13 @@ config WDT_FTWDT010
 	help
 	  Faraday Technology ftwdt010 watchdog is an architecture independent
 	  watchdog. It is usually used in SoC chip design.
+
+config WDT_I6300ESB
+	bool "Intel 6300ESB Watchdog"
+	depends on WDT && PCI
+	help
+	  Hardware driver for the watchdog timer built into the Intel
+	  6300ESB controller hub. Also emulated by QEMU, thus useful for
+	  testing watchdog functionality in virtual systems.
+
 endmenu
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 84faefdb4c2..cfe3f3dac5a 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -58,3 +58,4 @@ obj-$(CONFIG_WDT_TEGRA) += tegra_wdt.o
 obj-$(CONFIG_WDT_XILINX) += xilinx_wwdt.o
 obj-$(CONFIG_WDT_ADI) += adi_wdt.o
 obj-$(CONFIG_WDT_QCOM) += qcom-wdt.o
+obj-$(CONFIG_WDT_I6300ESB) += i6300esb-wdt.o
diff --git a/drivers/watchdog/i6300esb-wdt.c b/drivers/watchdog/i6300esb-wdt.c
new file mode 100644
index 00000000000..7b969216e8a
--- /dev/null
+++ b/drivers/watchdog/i6300esb-wdt.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) Siemens AG, 2026
+ *
+ * Based on Linux i6300esb.c
+ * (c) Copyright 2004 Google Inc.
+ * (c) Copyright 2005 David Härdeman <david@2gen.com>
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <pci.h>
+#include <wdt.h>
+#include <asm/io.h>
+
+/* PCI configuration registers */
+#define ESB_CONFIG_REG  0x60            /* Config register                   */
+#define ESB_LOCK_REG    0x68            /* WDT lock register                 */
+
+/* Memory mapped registers */
+#define ESB_TIMER1_REG(w) ((w)->base + 0x00)/* Timer1 value after each reset */
+#define ESB_TIMER2_REG(w) ((w)->base + 0x04)/* Timer2 value after each reset */
+#define ESB_RELOAD_REG(w) ((w)->base + 0x0c)/* Reload register               */
+
+/* Lock register bits */
+#define ESB_WDT_ENABLE  (0x01 << 1)   /* Enable WDT                        */
+#define ESB_WDT_LOCK    (0x01 << 0)   /* Lock (nowayout)                   */
+
+/* Reload register bits */
+#define ESB_WDT_RELOAD  (0x01 << 8)    /* prevent timeout                   */
+
+/* Magic constants */
+#define ESB_UNLOCK1     0x80            /* Step 1 to unlock reset registers  */
+#define ESB_UNLOCK2     0x86            /* Step 2 to unlock reset registers  */
+
+struct i6300_wdt {
+	ulong base;
+};
+
+static void unlock_timer_regs(struct i6300_wdt *wdt)
+{
+	writew(ESB_UNLOCK1, ESB_RELOAD_REG(wdt));
+	writew(ESB_UNLOCK2, ESB_RELOAD_REG(wdt));
+}
+
+static int i6300esb_wdt_start(struct udevice *dev, u64 ms, ulong flags)
+{
+	struct i6300_wdt *wdt = dev_get_priv(dev);
+	uint32_t val;
+
+	/*
+	 * Scale to ns, then divide by 983040 ns, the period of the timer
+	 * (30 ns PCI bus tick * 2^15). This is timer 1 (IRQ). Timer 2
+	 * (reboot) is set to immediate expiry.
+	 */
+	val = ms * 1000000ULL / 983040;
+
+	unlock_timer_regs(wdt);
+	writel(val, ESB_TIMER1_REG(wdt));
+
+	unlock_timer_regs(wdt);
+	writel(0, ESB_TIMER2_REG(wdt));
+
+	dm_pci_write_config8(dev, ESB_LOCK_REG, ESB_WDT_ENABLE);
+
+	return 0;
+}
+
+static int i6300esb_wdt_stop(struct udevice *dev)
+{
+	struct i6300_wdt *wdt = dev_get_priv(dev);
+	uint8_t val;
+
+	/* First, reset timers as suggested by the docs */
+	unlock_timer_regs(wdt);
+	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG(wdt));
+	/* Then disable the WDT */
+	dm_pci_write_config8(dev, ESB_LOCK_REG, 0x0);
+	dm_pci_read_config8(dev, ESB_LOCK_REG, &val);
+
+	/* Returns 0 if the timer was disabled, non-zero otherwise */
+	return val & ESB_WDT_ENABLE;
+}
+
+static int i6300esb_wdt_reset(struct udevice *dev)
+{
+	struct i6300_wdt *wdt = dev_get_priv(dev);
+
+	unlock_timer_regs(wdt);
+	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG(wdt));
+
+	return 0;
+}
+
+static int i6300esb_wdt_probe(struct udevice *dev)
+{
+	struct i6300_wdt *wdt = dev_get_priv(dev);
+	uint8_t val;
+
+	wdt->base = (ulong)dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0,
+					  PCI_REGION_TYPE, PCI_REGION_MEM);
+
+	/*
+	 * Config register:
+	 * Bit    5 : 0 = Enable WDT_OUTPUT
+	 * Bit    2 : 0 = set the timer frequency to the PCI clock
+	 * divided by 2^15 (approx 1KHz).
+	 * Bits 1:0 : 11 = WDT_INT_TYPE Disabled.
+	 * The watchdog has two timers, it can be setup so that the
+	 * expiry of timer1 results in an interrupt and the expiry of
+	 * timer2 results in a reboot. We set it to not generate
+	 * any interrupts as there is not much we can do with it
+	 * right now.
+	 */
+	dm_pci_write_config16(dev, ESB_CONFIG_REG, 0x0003);
+
+	/* Check that the WDT isn't already locked */
+	dm_pci_read_config8(dev, ESB_LOCK_REG, &val);
+	if (val & ESB_WDT_LOCK)
+		dev_warn(dev, "nowayout already set\n");
+
+	/* Set the timer to watchdog mode and disable it for now */
+	dm_pci_write_config8(dev, ESB_LOCK_REG, 0x00);
+
+	return 0;
+}
+
+static const struct wdt_ops i6300esb_wdt_ops = {
+	.start	= i6300esb_wdt_start,
+	.stop	= i6300esb_wdt_stop,
+	.reset	= i6300esb_wdt_reset,
+};
+
+U_BOOT_DRIVER(i6300esb_wdt) = {
+	.name	= "i6300esb_wdt",
+	.id	= UCLASS_WDT,
+	.probe	= i6300esb_wdt_probe,
+	.priv_auto = sizeof(struct i6300_wdt),
+	.ops	= &i6300esb_wdt_ops,
+};
+
+static struct pci_device_id i6300esb_wdt_supported[] = {
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ESB_9) },
+	{ },
+};
+
+U_BOOT_PCI_DEVICE(i6300esb_wdt, i6300esb_wdt_supported);
-- 
2.47.3
