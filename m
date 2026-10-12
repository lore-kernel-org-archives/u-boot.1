Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8933BCA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2617C6062D;
	Mon, 12 Oct 2026 05:42:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x_5px7mh3PcN; Mon, 12 Oct 2026 05:42:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3ED90605F1
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791783766;
	b=P7HUeG4nXcsApEZNIz/W5cx7cZoPqE+LLkKD6gJ8Z/P/Ly7qCscazBJiuPClTPzLQyRS
	 /PcKavlyalqD5m30t04BN1CrAES0MGlC6VHBzUlaiGI/9ipzj+0jqudTkhPXiON56X9td
	 Ib53DhhWQve7zaA1tLUVQGgUPdQPhO5qphISy+YUVcQB52KAL26zj5e5krNYGQ6WxIiBo
	 Sj5PfwvvEQSF9vBXMVV7GWnmJtxx2ZLtQF9Zh2KDCLzRAaYiFBjyhoImxtRbPonSixS9b
	 lCZOGqMd9RNYnaNtl2Ni9TkhGnCwlNERkXqd13h89CEb95qvslsQHZlkjxNe0IB9dzQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783766;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=AFYJ8bxpi6/bPtT4Xwz34emStRbqlqXNIWe27EWjyWo=;
	b=r2Cys3Vn61XSpCOspB+5QpP9XHSDiPAh9v7BQjacbAFLm+SQ2GUd+pH5zrI1EDzSg2yw
	 fVj8510+RkPnYVPSbEwBxYyMvtfSU/cx/aobW3JfA34bwHPH1r9R3NNpmdY+ihhxFlbci
	 4RaD3092dDQhXwEfHhnCMkBrg44iziYnJSOeZVjWN0oIwWMpR7geE7xGYAGOk9TXMekJK
	 BZyrsgOIc5OdLi9hI0lfroAnJw/jvyFXSMGLAYZICpUbnLkvRile52LyZwFbGnph5Pv3h
	 mv+408Vxw8j2oeT5XCGwD3Ha+Ojjr2/E74bLKOKCNLibXQJbfM/mjhS3kf26ExQlqVA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=wF7PdBLu;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783766;
	bh=AFYJ8bxpi6/bPtT4Xwz34emStRbqlqXNIWe27EWjyWo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IlwuGc3Xiz5TRqqlfTcJetcO1ep6lrgkMmfCi6BLAGuQ9E2WAnN4d6INKAEM1jcKE
	 cWCYV+IF8dr3Nqwq7coZZ4Esowpq3WZxMbiu4yZJpYvvWQv5VzxDCgdjA24BiB+j1O
	 UQZB0uQBw8TkX35O8K0Ji6Rh3+ahYPkhRE/DEDCqq3xCceuWAkW+wVduvgd8v9zKll
	 3GmhVrZAYM4Jez2M2ZgC+yST+ywo0i6Dw0+HBbPnB8cipyr1HY98fgW1EWNxXjBr/Z
	 7jzjhlLUXqKZGe27nXrSyrMNrdCOuqqBWxHeENcEaRQm5+S5+pYnFI0KHO2e1D7QN9
	 uKlsaRg8tELfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3ED90605F1;
	Mon, 12 Oct 2026 05:42:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E86F9DF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:42:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11194605F1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:42:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yb7n8CcaLpJg for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:42:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 08619605EC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783763;
 b=k8FiG94qRfR9xgjQjnrtQ2tnvRlcgwjeRruAPWz2BavJ/8w+yGJiDMHWDHOwh5yIPsIw
 0kfwcpu0XcCdlQWBBGc7zPvc5vSMVnrvL3VhjzNhy97J5bWGsPfClS/PmEIyeXfaAG1ce
 Ty1Q4KVXniFLzGp0+4U/I0vtMGy+eKzsAWlILCWAEg5kVwC/461pM1W7YAB83qUmTy3ST
 4VZ4MMvZNBwU8YnSUoPAXnbLKyopMomdmdQdvclx+uXSBKLRkzptKfrf2TaMBRurhoyI/
 /gHY9rSBNSitk+hqsQ+1d40AcRzC6ZSQjg05YwkPf7dFazs14C4OEzEYxljxSn1t+xA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791783763;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 bh=AFYJ8bxpi6/bPtT4Xwz34emStRbqlqXNIWe27EWjyWo=;
 b=P9kH5vpT+bH5wExk7GqeT9rnLqz2T7V92Sqo2s0RCS2476LOvrsbM67P31jmR2TeZ2tS
 +ZyGoLo6yuC0F72hxNl+iFMaMpWdkQsrbcz4s1CyjYWQP4BwNw9UkSWVHDA763aHbFHnQ
 1uYvjrMnO3pwL+8pxLl6zoBIzuaniQur/PbXeabHmOqqeTIYQVMsg+ngGp0XepNvAwzbb
 4nyuFSHXA8xJEQi0FmkgFpDlTirjpx7Ay/iGsHLIgXtUnQJTi6nD0xCMAXzbrDb7rAUrL
 ruA3AbemtbQdFaMRhL5cMCIyEIoSKws4InK72uV5OuF3cENoyEiyTS8jF+rG9A+UMwA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=wF7PdBLu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=wF7PdBLu
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 08619605EC
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:42:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHWK9kB6EEyIUP0/P1ezwJyI2EMMnEmqKFBltCePbPB8uqOOpGrRaHna7TVFanrz/AnIS8RyILq5QUxc8qLDg1ScIS9FtLPdHXRN+hgLkvT69DyctoGsPiy3BjxctedG5fKTm4cqDQUknjRjBQPMRbjeXVyThMd4Bj6o2I7tGTkbHvY5GyY+fya7tGfbpVYq0Ws0C/eIN+vlYzbu0sICh6cDtc0nqkAAvUtSgPxocq9T/AjVpt6dwry/ugZfElXOnHBOaB3q2wMhn+JjPxNbsVvCldVJcmaa+HcKa/7tV9KT9BZY8vrKGn3B9EryKImnGC9BWIHtuT0FAwFBiN3l9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFYJ8bxpi6/bPtT4Xwz34emStRbqlqXNIWe27EWjyWo=;
 b=LAcTan7DapRmnF3lct1LwXu/Jc7BIV7QZH0V9Hq9YpzTIxkNLUuPk6EXTozfCO3AqqSrRdB14k14n7wuVm6tjcMDDVKNSEL/RzIPqZItf8r0gY0Ynma5U1tlyBXoyEOV3YmBMpvlkfY9CX02uu0d4ZGLv8p27tK9GjIYdogWdQ3AXE47d5TY9GwJH3hLQfKxfwdy8xgCnKM8ZuOKvg1nmsn2b4d2qL7uUgxqryAeYhMxYqRI8TvwzlDupqnjLp2Qm6ehFQ9u9Lt1jPKp/shnshPPHdEvuwAYUGcoaGtdHF/vkVTwsEHRdF/eaGaTnI3vZbBq7I+ir6nc1BKtcdIOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFYJ8bxpi6/bPtT4Xwz34emStRbqlqXNIWe27EWjyWo=;
 b=wF7PdBLueM3KssBYZa5hgeG/DQcmay1ocw9Cwf2Ii5g5LmsekdAj1HqF+mUJXGdMFLjvIYwoCLe0+aHMjSJcDrUgWXoQakhw/17hbPd9s8xx4dAcv6gG5zBwfbLBMTEjo6EAem8QT7EzMlbDjjUdzoZxdKguO5IGgKTslNsyMSivplQN34Tsy05ovOdEAGPxKhkJfPDFESMy/29dmTluoZXZKOsYeIEhgNaBrep8OqeKbPuGz+cWfDocJQiTRDZoIX0mNyBmtcdezhHwpEkCK+tbfHQXvmYiiVJbg+atreyoXW9D/LexeDdC5VRS1Ese0rxckm3xay5Rct7AfLvRSQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PR3PR10MB3786.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:4f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 05:42:35 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 05:42:35 +0000
Message-ID: <77d8fc9b-ab0c-429d-a1e3-05e558188f45@siemens.com>
Date: Mon, 12 Oct 2026 07:42:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] optee: do not announce RPMB from within a supplicant
 RPC
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20261011-upstream-optee_rpmb_b4-v1-0-7c63edca4b92@oss.qualcomm.com>
 <20261011-upstream-optee_rpmb_b4-v1-2-7c63edca4b92@oss.qualcomm.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261011-upstream-optee_rpmb_b4-v1-2-7c63edca4b92@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::9) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PR3PR10MB3786:EE_
X-MS-Office365-Filtering-Correlation-Id: f91b47da-7fa2-4c4e-3eb6-08df28239e7a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|55112099003|6133799003;
X-Microsoft-Antispam-Message-Info: 30nqMx4xYyrlLrDrV8UpmfonRE6TNQixDhJhGwmCWuV6HVyx/LBHwzqmc/gUXcXow4FXzqB7DpK239AOU6llH3ycMMPQCG+YErxFCP01jvVucYtKFkAzHNlw5F1iqp5ruHsyfnOS3RLmxjvWIAAtd7/Of3Y75O2giUVOZgVX4TkNGHGLnQ2u/s02Tvjx6hxkIACEhfXrlX0qEcX+VWRMkfRzB6cpfVnWKPwkid/LAmALybmWWK9kUNQcY030LQL2fdTXfMFljx47gDOacIcDzshvxp4lbOl1GQMcu+OxAEMWQ5Ka3cJKBeWGISMY72i2s7wO+LYpD6Jg6/5or6xpCoTqaJs4ddeJJX9ignAkLrCz41HSLqJ2GWx3noQMsbZ+EZf+YZGHCzH7kcAzEa2AOqfPbGCPvV7K4NgGbWpsQoxbN/6ANx8J3hTBhb7a+gAlTTm75uI2aMzDFDcDdz0iypEHTeTGinCDa3Jc95VN+SyenQcbcM+0utWU36B/1UNMa9jScFwhJzbYhU4OE5f2X3+zR1mI5c/FsrolTDzY7lVMKUpj+Mw8wGipT8v2y18WiP9V44Rf8KI1jNcRksA/pSvpCUX66Go78aFB6FOKNlKEpoJlUngDOwjWNV8R+RetESY/K+N7YfTnjMPjr/IE7brFM0qUUAsAf1d05kGauqo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(55112099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVdQQkpDSHZoV0tCN1dIR0Z3SXpXUStuNmZnbHJpTndFeXBJZ0ZZVi9tZGdp?=
 =?utf-8?B?bi9KekJubGJJQXBFMXZvdjVmTXE4d2pwa1plZFcrUlJVZU4yWlR4U00rSFo2?=
 =?utf-8?B?ZGZtRjYxLzdZY1BEeGJKVk1yUGRXK3cyQ2liMXhnZEgrZTJyWjErZXRzSVNu?=
 =?utf-8?B?SXZoNU5MWGJLd2c3N0lRbUwvMVlHeGozcWF4em9jMWpuOTlDMlk5MnBGMGtY?=
 =?utf-8?B?ZEtMQXhCbllrZkhybGxEbk5LTElKVCszVyt2TVdTZ3g1L1hSZEFYc0JhbHBq?=
 =?utf-8?B?YndoUDRFdGVNZFQxNkM0eGZacSt3Um9Ib3FkdXp1REhXRFoydUlPb3hTSGEz?=
 =?utf-8?B?TlBBNk8vNDExSi85bm5aOEJuUEwwZnBGWGxpb0NVMk00OC93dUJuM3B2VG9C?=
 =?utf-8?B?VWQ3STdxenJrZ1ltMDJabnpPU01TQ2RuYXBGZjl3N3p1SmV5WUFZTGJ2TWtt?=
 =?utf-8?B?K2grNUVtRkRnZS9DdEpCVFFxV1EwOTluV2daSmViWDFmQUd4bWRhRHV6UFRy?=
 =?utf-8?B?L0FDNHhxRm9CM3pzOVBEcytDUzBZTi9FNkpFSC9iWnhHVnNINlY4ckFwRU9R?=
 =?utf-8?B?YzFTdU1ib3RFUitTcUhBRmVyaW0yY2RBbXAwcnJmUitMQU5nTWsrUDlTdHNy?=
 =?utf-8?B?VW4wclBBU0Z3QUxwN0hNZm9BbE5hL0dhY2NZbjRoQ2k5MkVKZjJuS2lPSkxT?=
 =?utf-8?B?eWVCVmVCZlRDOXlocEdSOGExQmdHeVhpMVNobngzdUFra2VtMWJUSXphamN4?=
 =?utf-8?B?eHVVemdIWS8yK3ptenNHWFlCcFB6bkdxZDdhRnRLYS95UmFUQjBkOFhGQVpZ?=
 =?utf-8?B?R3lTL3V0TGc2bnk2b3FWT0p3ZnphRTNWOEZGd2RrTHlyRDR6Y29OMnhVMkc3?=
 =?utf-8?B?NlV4dkVVN1FZWjRNRGkyNFBzNEhkTjhtZStpckhZd0xDeitGWWdBRnQrb0tK?=
 =?utf-8?B?Skk0VTNSdURqRUJ4UmhPMGEySTlza0dveWVtTEV5ckVjNmZRMVI1RlpWeEsx?=
 =?utf-8?B?UU5WYjdrNjYxYW8xMy83dENxR2M2bXlYZTdXK1lpTmhjV1R4NXFpSXg4dThI?=
 =?utf-8?B?VVo3c3BBc284VzRSbEZnSTJrclQzOG5HbTJaSmg4S0czWGFRTjI1ZHVJbFFu?=
 =?utf-8?B?Yzhucms3RnREL3F6RmlXVWNtSC94dzJkUFMwSnpKUFhDR3Q2YjR6QkM2Mzkx?=
 =?utf-8?B?bzAxTW1ybHZlN2c2N1hjc2xLREdueDRHV3ZsOGRRcXpIaTE5MGVGK0Uwc21a?=
 =?utf-8?B?QVoxK1F3NzY5MFh5SlN0cUYwSHRwbGZ0TmROYVhxa0NJNFVPazBJVDI0MG5w?=
 =?utf-8?B?dTUrMTdkVXRYM01PVWJiWEpNWG5sdytlWUloaFJJT1Y5WWdvZjJoeXJEbTlo?=
 =?utf-8?B?L1dnRWhtU3NyekwySllCQmhMZGdXMnYwRUVMaytJbDFXNVhkNVFrdG5ETEEx?=
 =?utf-8?B?bXAza2VoN0pjdHdNeWRlcFE3TTl0dnYzNm50TFlDQXUxQmJVTWx2T1F2emEv?=
 =?utf-8?B?dExLRm1xbEJXN3pjS09EUEpkWWVyeVc4WUNWek1pVzBVSDEvYlZ5TTVpaWRv?=
 =?utf-8?B?SmpDTlF1UTNZWVUxaFdCVGVBZnJiUTFWUyttMzNZV3lPVWdnaXlxTjBUZVdk?=
 =?utf-8?B?d205b3A4NjRaYmd2UG5sWlJQSTBad1BuZmFJUVRod2JhYmJTQ0JZYzl3R3JF?=
 =?utf-8?B?Sk1VcDVCUmRUbUhrZkJDN05UejhNa0MyelBiTyt4MENMSCtQOVhKOUltL3ha?=
 =?utf-8?B?Tk43K2JJcVN3ekdvOFNRTWhDdW5tL1lRUzJQRFdUTTlTSUpSc3RudVRWcGRR?=
 =?utf-8?B?cjg4WTVKQXMvZWcrMGxSc1NiL0VLeTdBNHEvUkVnTnNoRVovTWhPOEk3Q3U0?=
 =?utf-8?B?LzBNTVQxcVVHUCtEWXM5RmRVd2dpNFZJZ201eHVPeks5enVWWDhaZXNKbExy?=
 =?utf-8?B?L0d1WlNWWTd2THI0NTB4UGxWb29ocWdESUFPbVZCZ1FQYUFqUXlXRmw1Q2xZ?=
 =?utf-8?B?UFptRVJvOEVJYlBaQXlSakw1Y0srNVFTUi91bWRqNnd6eDcxZGN5T1Y2NXFt?=
 =?utf-8?B?cmNzQnF0endOdkVNL1lvV1Z5NWtBcGFjYTY0aVJZamVNT3dYdFBWZDVwdlJK?=
 =?utf-8?B?VDNSdXhpdnJLRmpPREFQWWlFTm01U0hoT3VESlNWMHAxMjdNbm5KWDNlSEw3?=
 =?utf-8?B?b1BMTE1iVTE4VFlkVnVqUmNOVUh1OEJJT3BhTDFwKzgvOHBpZXZ3eUYvTjB6?=
 =?utf-8?B?ZkdQV09mak1sMXIrdzdET3Z3STgrZmpHQlZ0V1dBaXF1WEplSmxjamZvbzhI?=
 =?utf-8?B?bCtnMW93SmJJdWxoUmI4L0k3V05jdVZKaklNcTlrZmtRdkVzTVY0Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91b47da-7fa2-4c4e-3eb6-08df28239e7a
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 05:42:35.8418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvSzwXZwnvYennLpe6k7GVRVJnGr3MMT0JX+mCDVVjl7pJuCX63Pl1tAu9U1Bx9zZ4lT+TW1VQ5cilzzrL0SMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3786
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

On 11.10.26 15:07, Igor Opaniuk wrote:
> mmc_init() calls optee_rpmb_available() once the card has been set up.
> When the first initialisation of the eMMC is triggered by the RPMB
> supplicant, that is while OP-TEE is blocked in an RPC and holds its RPMB
> mutex, the announcement opens a nested session and OP-TEE's second thread
> spins forever waiting for the mutex (U-Boot has no notification support
> to put it to sleep). This happens whenever a TA touches its RPMB secure
> storage before anything else in U-Boot has initialised the eMMC, for
> example a TA call issued from the shell right after reset.
> 

How do I trigger this exactly? I tried via StMM (env print -e), but that
didn't cause issues in my setup.

> Track whether a supplicant RPC is being serviced and skip the
> announcement in that case: OP-TEE is using the RPMB already.
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>  drivers/tee/optee/core.c          | 3 +++
>  drivers/tee/optee/optee_private.h | 2 ++
>  drivers/tee/optee/rpmb.c          | 9 +++++++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index a47c76811cd..b61f907a3ff 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -424,6 +424,7 @@ static int from_msg_param(struct tee_param *params, uint num_params,
>  static void handle_rpc(struct udevice *dev, struct rpc_param *param,
>  		       void *page_list)
>  {
> +	struct optee_private *priv = dev_get_priv(dev);
>  	struct tee_shm *shm;
>  
>  	switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
> @@ -450,7 +451,9 @@ static void handle_rpc(struct udevice *dev, struct rpc_param *param,
>  		break;
>  	case OPTEE_SMC_RPC_FUNC_CMD:
>  		shm = reg_pair_to_ptr(param->a1, param->a2);
> +		priv->in_supplicant++;
>  		optee_suppl_cmd(dev, shm, page_list);
> +		priv->in_supplicant--;

Wouldn't it be enough to track this from rpmb_process_request? The
nesting issue is limited to RPMB requests, isn't it?

>  		break;
>  	default:
>  		break;
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index daff3e04493..92e3b3bea10 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -42,6 +42,8 @@ struct optee_private {
>  	struct mmc *rpmb_mmc;
>  	int rpmb_dev_id;
>  	int rpmb_original_part;
> +	/* Non-zero while a supplicant RPC from OP-TEE is being serviced */
> +	int in_supplicant;
>  };
>  
>  struct optee_msg_arg;
> diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
> index ea5507af086..cc82fcead0e 100644
> --- a/drivers/tee/optee/rpmb.c
> +++ b/drivers/tee/optee/rpmb.c
> @@ -224,6 +224,15 @@ void optee_rpmb_available(void)
>  		    !device_active(dev))
>  			continue;
>  
> +		/*
> +		 * mmc_init() may run from the RPMB supplicant itself, while
> +		 * OP-TEE is blocked in that RPC and holds its RPMB lock. A
> +		 * nested call would then deadlock, and OP-TEE is about to use
> +		 * the device anyway.
> +		 */
> +		if (((struct optee_private *)dev_get_priv(dev))->in_supplicant)

Using some local optee_priv variable might be nicer to read.

> +			continue;
> +
>  		if (optee_open_enum_session(dev, &tee_sess) != 0)
>  			continue;
>  
> 

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
