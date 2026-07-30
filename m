Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7E2C531D0
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 07:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24DBF607AB;
	Thu, 30 Jul 2026 07:13:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HyOPQROytdi8; Thu, 30 Jul 2026 07:13:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2319760793
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785395611;
	bh=wPfK3R02qe3EHFT3Du1phLT1TN6BS7Lv/BqUxlpTUrw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AsF66ylFPrXCv9vKirVxozWRBBP8M3sPdbR99NHR2689HsO1lZQfiAFNxYayqFTO/
	 7zLaYvKO2GrltEIX0nSwTu3UGsZBlYCJ62wErzFi4pA2QUy9lARp/gDQsdtocmIZ6k
	 jzFwyhX/QNZVu9+eZgaFsYCS1QxMKIxNQHcIaufrJDZCFrMgbhgDOCesvgNNNA3Cco
	 JdelUTYjnWbkmSHU7Xl40ZYtLobUhh+nrU7Z1CB06xdoaBZ3NihH0k/Mom6hAYcc01
	 PFDEY9ttF2iKdDGtMGjfuEF2PR64QuFcpevCbEBUZfYzS+cid4PRMd9FyFdhAqZGPV
	 kl+8fMeALMPig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2319760793;
	Thu, 30 Jul 2026 07:13:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BD2427B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 07:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 615F580E06
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 07:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 66BM66wkAoPA for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 07:13:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=w.egorov@phytec.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 427D780E05
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 427D780E05
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 427D780E05
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 07:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qM19WrjKRDcbyIhXpSX4d4GPC4wKskPu6f25lhO3hpfOcPt0RRG/8fsnx74j2c7vvbe8pn4xFR6ikguIvqwukJw/bByAInPLQvLKy9lBsgTMt4y5VOi/MXhK6g4qQ7QUI4x49Io6S78P3dryFWdQmr6S4xelwEp4KTjEdDCkmXN4IXLHNHZ3tjhaMDq5tZ67GUJiRfjvIigIGgsGnUkCGqPgJ+eUUQjZrH45gnGkSgeuFZEdXfUOeblcPnlOyFdR0DhliwH1jWlySBPX5/fBKPebDqpfMNGR3u6iB5PIixNJZeoKGMeAk5K7vYNfFh/+2digWFxVCrjfaqZFDhf6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPfK3R02qe3EHFT3Du1phLT1TN6BS7Lv/BqUxlpTUrw=;
 b=yeRXa+VAH+c6+6UQHEdUNs3tpBsRf8trqeVvmwmseR8Uc/tgdNs548Cvcbs2JN2DwxEWNh8YQdF6192ilKKs/HwCzm0kWbDi77L5ZwmshgiGApHaz00MQY4jJLfW91rYD4wamL8Sstly5tBgvwkSV9Fsz9uSJ2qOMMhtzj9XYT5+k6A4JGe/OyTyJt1Ti5Md01+iqwr6A5tk2UFYIEPfBLVm1FKRPbcH49jWqidwPRbp3L3DxEO58g/ctBA5y/x+d2hZC3Bj2v0WiiISmtaJX1EGTiwq2UQW7hDSB/Gdgzk4ovmZVn7dMvRmy5yoGIDW9kf1sSZLZk2MxMeF3DOvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by VI2P195MB3101.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:2df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 07:13:18 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 07:13:18 +0000
Message-ID: <2eb12bdc-3f71-4106-876e-0dfedf9a7eeb@phytec.de>
Date: Thu, 30 Jul 2026 10:13:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Refactor binman nodes for boot binaries for TI
 AM625 into templates
To: Anshul Dalal <anshuld@ti.com>, upstream@lists.phytec.de,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Aristo Chen <aristo.chen@canonical.com>, Suhaas Joshi <s-joshi@ti.com>,
 Bryan Brattlof <bb@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Sparsh Kumar <sparsh-kumar@ti.com>, Simon Glass <sjg@chromium.org>
References: <20260729-k3_binman_refactor-v2-0-9a66fd170040@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20260729-k3_binman_refactor-v2-0-9a66fd170040@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0166.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::7) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|VI2P195MB3101:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bfd6541-d3f6-432e-8530-08deee0a080c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|10070799003|1800799024|23010399003|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: pYvuwDUghsC94ajavXZ+rY+SQZ1Ui2q3MMd/cr0Hk7nJ0Bp72Dcr+uW/ME4w5RgzobGWnbkuAeKXJae7UFgQW+ucKPVlpqWtKiVtpQJibvqzOsKJ8e35wLQk/wYyU3R205ZwpSjYGYTs4ld4vd1XnqLj6sKwJQ2anP8ju48pZztDujMnLw75NhGpdl+GPJF+t94WvU5+WGl1IR7tRWL9jcx0XKFBP3CZgeiuHYkuw3+20WBeubvwlBeve3WIQvH6rcvF2fq6Mg/SF+ryhS8YWbkSXtbWry3RwjKgytNcU8HZq2/Pf8GUoSX8VAt3RbowWApAkxLiK4x/RU1XPiRlzz4TmcxjKj6VQmmLDNgQRz8Zri86WlMUIEBXQNwbQjLPrVcWUZafXnx1tjzbX59DwnGDUo7UaUui91RtZpzMDR/bSYe7T4VzlaDwuWGOcKgMWv2WFIXg3JN9PkWd5Ni3ZWB6DTB+MYst87DcYUyi5a3mbXeAqqimBwZgmz6rxwOimieTMBs2j6VPOYhrDqA5v6BXNZHHjcsCpWIQr3H0pSSjmk+yUf6AKVJCiB3+uKYb+VTpsb5uLo2ZUb6uniJV7NAwTi5N8uPlb8+hpAkGrgjjC1QkXt0Haf5cZ5330Lli
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(10070799003)(1800799024)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NS9DTm5ZdjJXMWIvMGVBdENJNjQvcWVlR1NRRExZMWNqbnZDSzUyL3BWVFo3?=
 =?utf-8?B?SGRUNDRadC9tK3BISVNWSUExRVlsQ01XMjlmWWY1RmlUNDI2R01GSldaVWxB?=
 =?utf-8?B?T0g5U3gzbDl1d3VWQ2N5S0RkWVprd2RlZkJHVmlCemY1YnRhRW5TY2ptL3V6?=
 =?utf-8?B?OWk0QVQxMG1zYkZ6OWtlcVg3RlNHa0xZSXN0Vlp6QnIxcUl2MnJoeXpPTGd0?=
 =?utf-8?B?c2VZbnovMXFjVkNERkdiaGthNElsSCtGRWZicm1MMDdnQ1NLeWNYUWVWckFH?=
 =?utf-8?B?Y3JyVGVIaEdUVWFuS2hibXFHcTlkaVV2RWFiTFdnSXdwQ3FsOG12YjhWdTRz?=
 =?utf-8?B?SWpCT3lsYSt2Tmg4N1llTWllQ3poRTZHMk1ERkJvRzR3YjZVaHJmbDhXQ200?=
 =?utf-8?B?K3ZnT0ZUU3RmRHlEdXFvZGZlcDJjb3Q2dG0vS1RvclZiVVdXZjEydzBaa3g3?=
 =?utf-8?B?V3dta2tZY1VEZEZFNVRlemJ1SHpvdmROZUNaNUkyUkdSRStjamtzZ1FuUFdT?=
 =?utf-8?B?YnZ6aGthSkNwZWRLZjVMRFlzenFXR0E3L1lCSWo5Sy83RkNXMGtYMXJxYnQ4?=
 =?utf-8?B?WVFvT2w5c3NhbGpBRCtsRkVBQU16UklxUnloVG1IbXh3YUYxeU85V2FIMDZn?=
 =?utf-8?B?RG1aYXlXMlVVanVIZjhvNzRPNnYzZWh0ejh0S1JTUEdrZHZ1WWIvM2hnTjBJ?=
 =?utf-8?B?TmJGWEVVdGtEcURDcVlwMVFIRVczVURhRkg3NTkrbGJtMDdHV1ZYV0gwZnM4?=
 =?utf-8?B?b2FYMXlzdHdsTG9Dd2RFRDhIT2EzV3Rsb2F2T3pLSkdRaExrVFJEZFZpMkww?=
 =?utf-8?B?UVFGczN1Yk1OekVGelN6SVhsbUhqWWYxL0c5RlJNQTNSOHg5NWpFVk1tdHBU?=
 =?utf-8?B?Y0ZQMnQrd3NyUGIyVE50c3M0QUNpaW1WKzQ4VjVlNHJDMmtmMkdGRkJUUkY3?=
 =?utf-8?B?T3lhQnhQWE1DSUUyKzE3YmxIR04xeUNFVCsyZ1l6OEtXdVVXTFhoRTdDWWhD?=
 =?utf-8?B?MFlNeEtVb3NWVjJ1aTVjUUlUeVl6VUYxdDJYTE9FcUFUbFZhdkhrbHhXNnFm?=
 =?utf-8?B?UnVXTjF0K2xHVFZGK0JtZlpGSm1UU2ZLYWxqc05sSFlSOUtNdEREbk44T1Vh?=
 =?utf-8?B?dTkreFBuUGJnQ0RKYndrTHQzdXdaT0tVZ2xJZ1E4YlJpaXJxUlFYVDhnNFpC?=
 =?utf-8?B?cjFJV2ZqR2syemQvRUZBRFkvTDdPS0praXRyQklkZUhlN2VYaU5CdzdEUGdJ?=
 =?utf-8?B?MVBDMFN4Sm5adlpQWmVyVUt5S2EvOWcwVTBmaHpIb2c4Z0xvUmxGVVQ5U0Ex?=
 =?utf-8?B?eFI5bHpFOGZJTk9ZV2Z3eEFhSFFzM2dpUGpvRnY2NzIvN255YUplTEt4R2pP?=
 =?utf-8?B?ZnV2YlBEV1pWNjhvOTlBQ2d5UUZubCtHMUgzbHJIeTByUGl1MWxONEFyQXpx?=
 =?utf-8?B?bHNLUTF5NnNsNXg4aVNnUS8xeVlyL2lBTno2MDM0U0cyQWpxN3dXUzRnVXRv?=
 =?utf-8?B?aWdwZDFEZUhGV1Z5UVJRS1JCL2VtRnAyaXFuYkh4NitCUDVSdHRQV3U2cklx?=
 =?utf-8?B?bnRyek9VanVEUDVVdVB6b3lOSmZDaytxS2lEb21obng4RTZmcW1pQTE1NWRS?=
 =?utf-8?B?cG9lWTZab09sVUY1c0lUUnZuRXNhZlVuQWhZamJLUXhaakhySW5tcFEyL3FG?=
 =?utf-8?B?MEpHUEQ1Rko5Zmh3aGVOVm1Qd2J5ZHJRNzJqbHhiWkFLT1B6ZUZ4RGl3dzFh?=
 =?utf-8?B?QzdSS2J5a29JZU9UMmM2SXZYK2VtYytBbkxXSloyQysxc0pRbU9BNHJYcTcv?=
 =?utf-8?B?VUlFVlRvTm5SRFRkai9rVTNGbUV5ZVJnZWJ0aXZkRENiekFCanphb3hZYTV1?=
 =?utf-8?B?bXgrbHZDaTA2dkN1bUwzS3JyNW9zSis3V3RMQ1FEb0NhYTZsbWI4SlFPME8y?=
 =?utf-8?B?RUFMMThWQ3hOOUM3VjMzanBvaW0xcFVxTEFXeUlyNFZBalN4QitPanZkZnEw?=
 =?utf-8?B?VU52RVhFREUwamR5SjUza1hPZERvRW9aWk5hKzR2Sjk4YXVKeUVkeDlqdHNO?=
 =?utf-8?B?T1pwY2VoTm9kTFN1dnZWTmFBaENEWXI0NE5BaVlLejlQRjJsOG1SdGlvd3lz?=
 =?utf-8?B?VCtwNFljbDhhQkJMM1FvMFVqT29WUGRjNHVTVjA4QnNZQnoxWkdsOC9RWUVZ?=
 =?utf-8?B?Vm9qVUt3MjJVQUZYNFI5SURqeXNWTEJ0dnVZM2NacTE5ZERxUkw5N1d4R3Y0?=
 =?utf-8?B?V1dBbU1salk4NHE0dW1qNjlQNWJuVC92U0NsVktUZEg0SktxcmJ2QkJCWW1P?=
 =?utf-8?B?aml2MGsxeWRXcWlXMVJHSi81TTZjTlRJZ25PN0Z6UFFRQVNRVlcxQnZvbXFJ?=
 =?utf-8?Q?uMPkeQSC0/5ILmMNAXxplY4Gf9IBadbtcbh8JfJIJpzna?=
X-MS-Exchange-AntiSpam-MessageData-1: 2J5/1XT/4Nj3sA==
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfd6541-d3f6-432e-8530-08deee0a080c
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 07:13:18.7043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EtVd4qSIiuA2JQ1KDjxEhaCGCD3olADyV1u4U8FLe30/pjnnu5jc7EIj98mF8EbsLiJUqjZ/Twa/FDevVs6aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P195MB3101
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPfK3R02qe3EHFT3Du1phLT1TN6BS7Lv/BqUxlpTUrw=;
 b=L9/WAYuhcMNgLK1ERUvNQIb1UhHd1AspsidfzaeyiTIfhODgLbB03JUDJYLR8NS2VPqNMa+v/tS0dpDz/lh58XqY/Fd/nt/47xPllo+eQBR33Iwof6+rZxedslIZemfOGr/iLBf716RJNDLdlTfb8s4t9p9+zsWjhZwbN1MDPf/k6J2Z7cDKDwjWhR/L/0QAlvCAFHYyEswvCnzQFZ+nnJ7JjNVk5Y5RRXvMcdBCXGxPZeHXn6aPf01hy/DdzJ2cn4n1Hn52ahZrUTZaxe986rwwIJN2zIc6VG2l8kPepJu7TtbovhcjznTAfTEK8GAyIKAdylrR3IizjxqUp3KpDQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=L9/WAYuh
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 7/29/26 1:54 PM, Anshul Dalal wrote:
> Hi all,
> 
> This patch series seeks to help in reuse by moving currently duplicated
> entries for tiboot3.bin and tispl.bin into a generic SoC wide DTSI
> (k3-am625-binman.dtsi).
> 
> This dtsi in-turn gets included by all AM625 based boards which can
> insert the templates from k3-am625-binman.dtsi.
> 
> The newly added templates are as follows:
>   tiboot3_am625_hs
>   tiboot3_am625_hs_fs
>   tiboot3_am625_gp
>   ti_falcon_am625
>   ti_spl_unsigned_am625
>   ti_spl_am625
> 
> The series has been boot tested on beagleplay and AM62x EVM but the
> following affected boards have only been build tested:
>   - phycore_am62x

For this series,

Tested-by: Wadim Egorov <w.egorov@phytec.de>

>   - verdin-am62
> 
> To verify no regressions, I compared the final 'u-boot.dtb.out' for both
> the R5 and A53 build using dtx_diff script from linux source.
> 
> Depends on: https://patchwork.ozlabs.org/project/uboot/patch/20260729-binman_template_phandle_copy_fix-v3-1-9bf6cbbe1a61@ti.com/
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> Changes in v2:
> - Reword commit message and pick R/bys
> - Reorder properties inside tiboot3 template for gp to match hs and fs
> - Remove symlink from tiboot3 template for hs
> - Link to v1: https://patch.msgid.link/20260717-k3_binman_refactor-v1-0-4089220b4fd4@ti.com
> 
> ---
> Anshul Dalal (2):
>       arm: dts: k3-am625: add template for tiboot3.bin
>       arm: dts: k3-am625: add template for tispl.bin
> 
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi      |  94 +----
>  arch/arm/dts/k3-am625-binman.dtsi                 | 362 ++++++++++++++++++
>  arch/arm/dts/k3-am625-phycore-som-binman.dtsi     | 357 +-----------------
>  arch/arm/dts/k3-am625-r5-beagleplay.dts           |  33 +-
>  arch/arm/dts/k3-am625-sk-binman.dtsi              | 430 +++-------------------
>  arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi | 301 +--------------
>  6 files changed, 418 insertions(+), 1159 deletions(-)
> ---
> base-commit: 447f6dfb9aa2191553993441f92f9c50f6486ffe
> change-id: 20260717-k3_binman_refactor-081615fabbea
> 
> Best regards,
> --  
> Anshul Dalal <anshuld@ti.com>
> 

