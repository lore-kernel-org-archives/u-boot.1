Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BC8EC1434
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 12:05:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 075CB838BB;
	Tue,  3 Mar 2026 13:05:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UaJlYRkp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BFD883E7F; Tue,  3 Mar 2026 13:04:59 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FD348063E
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 13:04:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rth/zg9xy+3ashqTVnip3lzMvZ6XyIBE0RjqaGrDNnLLiMK/D1DJApa28LnyomrmuXwTRhUIjXZ+PUqpjXXkVxyprgLHaovmMVkUoHk+YxIYkWdcvR/HtzcIJR/1SCMyzTpjAhpIQL/DY8gwVXsyAXBotnAzAVXs0imNGo5dNXHgg//niqUj43BBy3zLJ0AzCJpD5/CR319ZHWsX9IYBgkwjQe2C3DPNcDFle33YMtcsehK5396kYnIZXhkbAIWTzql2Ik7ilwqdqxCTnObq6mRyzpdYp4ta6FtSm+ywtFnos8nfFhCH3zDKLIyl2/8RytwAljNyTTzSfOUuoOa2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2o+cGm2ZuPDYIltPvq+WLDBepHA7Q3DtxB1EhHJCng=;
 b=kRH6mRb5dg0cUMf4LhRil3AplhNWmQsG2cjFHdSeTsnmPpLUmiqwWOmbQtKiYwlTPCDYbWrFOnftlXph6YCZIxstcDu5EfsPJtC7o4OJt++zTynzFL41tJ6F9QJ8ZeNqLuUszq+ry3KT0un/yDI8eqG5oP6gS6JHal/nJcK8fIRRb1/JCmg3CFP8WWA4fbwsfpPD27gA5oMYfVU7p+6ndI/K9PFoKujQ3sMFaRyNRZKqpR8egCNYudAF0ek6wYvRLt0edRC2U9osXGQSlRtt+xTS6hTLFNpNf9c58VqF0jAz1X940RGNwmGSrbhMzziOyPtO+28iXmhOETk9uIkc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2o+cGm2ZuPDYIltPvq+WLDBepHA7Q3DtxB1EhHJCng=;
 b=UaJlYRkpUt8FzpE5ZncoWUa4pdktmpVy4gQ0k+YeHKo4FP+GYNLKfo5EJ0mw1BgAog3UNwygxo43tN9WOc6okBTS85XYOIL5BFhp2CcqqCjpAwB2DRoVb4jk3JEAJZc1OtjIM9l7PwuXApAfnNJfqT5mOWNWanMTw4WaWqyl44Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB9PR04MB9963.eurprd04.prod.outlook.com (2603:10a6:10:4ec::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 12:04:54 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 12:04:54 +0000
Message-ID: <f642ed99-b858-44b1-9453-cba0d4578af8@cherry.de>
Date: Tue, 3 Mar 2026 13:04:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/16] binman: test: Move x86 and Intel test files to
 test/x86/
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20260226234802.345968-1-sjg@chromium.org>
 <20260226234802.345968-4-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226234802.345968-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::9) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB9PR04MB9963:EE_
X-MS-Office365-Filtering-Correlation-Id: 2669cb6b-6403-4b73-1752-08de791d14d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: AWL7jvBJDOhvp32qKhQjbhINMWvnHtT+FHfBGpS4LEQxnEpGBEqiNf++h59Hfu5qeMFPXhLLaenE9rfet5M5UPSAkSGWtDDhm4JhLRm3qZ6nHP6+fa/ahi65CfmVcoqkxjIdJopCDnj2Wi83JYfEQEoBIIBNnejLR9WVF+LyAVxQM7+QvtHxftDeK6P8qX75GLYHlCc7tvHwYuG05NZ5o2Tfm0KfsbBuoxHtn9A3fq7qy0XfFR45I2IyCfFYfg2Lu1Oaf7is9eaRpwrl6qySm8fzh8Edvixj1+WEcXViKTIbZGvkhJM6zoF+KJoWGwNyjG3quHh0eobfcYFv2zif/hA/LfcelQ5oIXiH3ysDmSw3LDTkiKJnqk1yLVmmTrAqZjHOgROLiHbPq6IOPFxk+nBdOiRvPtVCoPpo0kvQijoqwXXt/SajU6lIjcV1+0n11ZJr1WeDdyjwvxs4Cv1xpX93mbZ9KtJ4JJJ/Y6fxHNJmjsP03r79w1DHRWjDM//8snq9fAUJOXUCXBuhinwUneafj4Zwnwckf3mT2C3WTY8vx0XcMOQDVZ46nvUzcvBZj2KhoScPm18L2AcNHnXXd1qw036Psc8s4TBwsj01k93m14N0xnZV7h4glD3rqS1QG8fy9cXFfvRy/4MhPN7Ov6PXrevXOkQ9PQLU3TN2hDIfIYkdXjyh9yJWGumxXaKT3v0V1cjHsAqQoFHRjSPSCn2B+tAUu7GBsJ51a9Eh4pQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG1oSUVGNEV0U0JzQ2FuYzZ1cmRVSmdJcHZFZmlyZzhTVFpoV3FYQVdLVkdm?=
 =?utf-8?B?Z3lBWjhKZ2VIM1NSRlMxcUdwYnNXUkk0VVdiY2gxYjllUStHT2RKL2ZmdFI4?=
 =?utf-8?B?d2JaTWZ1RWVlMDZkdHA0Tm1XcG9ic21mTXRQSERGb2s1alR0bE90THFaYTBh?=
 =?utf-8?B?KzExcE83VHBrVnRxQVhuQXJiRlVsb280SkhZL21EeEowZkx0U0g2eXFRelhX?=
 =?utf-8?B?anRVcGt2N3VuZW12MjM4VE5nUHl4Z0s2eXdiKzl4ZlhYWklZckJ5ZjZ4RmdU?=
 =?utf-8?B?MWFKQ1ZvQ2I3cVIwZnVNTVJ3eWN0TTdFL2VYRUsyY2pSWEkyajNya3RWRktS?=
 =?utf-8?B?enFVZVovdWhrcUdheU0ydUxXN0RBMHJab0hiNHR0eDBkaWV6N2tpT2tkWFFx?=
 =?utf-8?B?UTJRRUNXM0ZNU1JpbEhrUFpSSUxJbW1Jb3lZSkdUYUUzeE15amFJS3FuVHo3?=
 =?utf-8?B?S21Tc0puNWgyZDkrbGdEWS92Wno2ZDdhdjRaQy8vbm10ZE5LL1crNHNPNlBF?=
 =?utf-8?B?aDRqZVYxK1pSM3NseGZxZnIwVURCMnN0TDVVWFdQTDBKMHE2NTJCeHZNZS9U?=
 =?utf-8?B?RUxVd2ptUGxJUU5tV0VncG9lN01NamgyMHAxdUd1V2tsZWFuMjREOFhIR1Rq?=
 =?utf-8?B?VVZ3SDk3S0NROVM3dXlRR1ZRS2w5S1dOWXhlK1BvUGpBTEo1MnNXR2xaYW1G?=
 =?utf-8?B?bDlWZWF4ZDRERDM5ZTNtMnNTNDFGYkpnL2t4emtINjN6YkNVQ3ExNkNvbWRY?=
 =?utf-8?B?WE1ldUllS3VGVDVLWXpqdHJtbWVGUTRyN0hhZHFTVzkvQUxqRW1aRW9ISlIx?=
 =?utf-8?B?eXJYS3YrT0FuSFBMOUZjYkxHK1BzVlBLUFNsK3N6MmZkWit3V2xpYWtHTzFB?=
 =?utf-8?B?MUx3UVZvc3JSQ3o2Y3lzWmhKS1ExK24xZGlxTy9jbExjTjh2bnR6dFVYU1VB?=
 =?utf-8?B?N05ENlpVcUhmUnNJUEdzTUNpS1BpQWlnL2p5c1pwZWRyTTFNR1ZONm9IMWZr?=
 =?utf-8?B?QURsSHpkSEJCSGpHQXZDU2czVnhPa0xCZC9mRTA5YjY5UUo3aFhMMW4rY292?=
 =?utf-8?B?Yzk1ZDJBZ2hlSHN5dzdOWmthd2lDaEFPL3pWZGRPazIzcmptZVViYkFOL1Jh?=
 =?utf-8?B?WkM1ekNoMitWV012MG1KSmY3MXg3U1VyYW54ZmM5dk44VlJUakZabmR5Tmtz?=
 =?utf-8?B?U2NIbngzQ2tlMFI5T2NUVFNtSmxwT0lBZmYvUXRPRlRjS0pITnJvdXZSVlVL?=
 =?utf-8?B?Zm9yeTA1SVNHM2FtdDQyNEhFSHhXc25SQUxNV3J1RFhzTEtyaGtEYTdhZEhJ?=
 =?utf-8?B?RUZ2cnl5c0crY2dUVStEZVN6NTM4QWdVYVl6czJPalRtODRPMFBuUnZxWE9H?=
 =?utf-8?B?Wm9hcmtRbnpsb1RRVGJIVkQzZExNSTVDRVhFRTQ1SDFxQlZZS1NVT09SOE9x?=
 =?utf-8?B?RHc1ZUsvVTViYkQ0TDBvSnFZSGZ3RTRUWVlBY29vaXkxbzJTMXJZc2k5STlM?=
 =?utf-8?B?Vk5xbDZNYnJrZDRuYS9TRGxaYVBLVXhHMEs2Z28rOGlZMm5lbzB4TTRYWE9C?=
 =?utf-8?B?MndWT3pxZ1Evb0h3TVVpc21HVnlxM2pTWWMzV2hDVExuZi85UnE1R3lXQms2?=
 =?utf-8?B?NDN3SUVVUCsreE8wT3pwdS9SL0swSEVMWWYyWVlteHdvNkRybXJ1eis2TTJj?=
 =?utf-8?B?bjJTSTBJQk5uUzg2OEFMakJFb2craitKUzZNNnZGWFNTWXNCM3JxQVd2djR6?=
 =?utf-8?B?OGxoQnA0TlhWZlo4TzFmcm9lTWdDS3lycmJ3TlFhVGt5bmRXN0EzNHEremcw?=
 =?utf-8?B?RzUzMGNPYXY3RlpzUkpTWmxWeG44RDVETGF4Wnh1YXdHMFlRbks0eUtDTHpK?=
 =?utf-8?B?M0lHK291bzJXa1BJQnZkUHB2K3VMaGUrOE5aUVlTenpmUitvd04rcDY3MWo3?=
 =?utf-8?B?UXRKTk5weWdqYzlRcGptZkZPT3NhTFZjenFQdkFycm12SWpJWlE1OWVxR2Yr?=
 =?utf-8?B?K2ZjUm9Gdy8vR3hZYUZybDBUVy83MDJSWC93dzFkckI1d2tWM29HZ3IyU3Zi?=
 =?utf-8?B?K0QxMGM2Q0lDT2VrSC9KbTJYYloreEZESUZzQytMdHBxS0RLc015RmJlL2tn?=
 =?utf-8?B?elROQkZHMVBIZllYNFNiaTVmeG94UGRyRTNFQXoxMSt0bHVHK2k1T2NOYTdH?=
 =?utf-8?B?RktnYmpVTDY1T3pUSmZFU1dqb2F4MndGc1BRd0MvbWdTZkVNdzZkRitCbzc4?=
 =?utf-8?B?K2RXZUlnS1JxSUs2THhmeGdyeXBjQTM1SGw1eitKM3o1SnFyYlZJWEVQSUhR?=
 =?utf-8?B?MDJ3TVpibE03eWFLOW5xMnNMRVA5Q2ZFTmIyRDhkRjZOdjlsdmxsdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2669cb6b-6403-4b73-1752-08de791d14d6
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 12:04:54.5120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51+kj8CAw5rskBLwAecVoHtr0YhFwgS9Kh9HezNFAzxSC+4P8Wo1UHqc4JB2mD8VEeg3BbDRNPYC25ZC1ntLK4wI3W0ME1scI6LyYCMop6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9963
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Simon,

On 2/27/26 12:47 AM, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
> 
> Move about 40 test files for x86 and Intel platform support (ROM,
> microcode, ME, IFWI, FSP, descriptor, reset16, start16, FIT) into an
> x86/ subdirectory. Drop the numeric prefixes and the redundant x86_
> filename prefix, and update all references.
> 

What about moving descriptor.bin to x86/ as well? Ditto for 
tools/binman/test/fitimage.bin.gz and tools/binman/test/ifwi.bin.gz. Can 
be in a separate patch.

Same remark as for patch 2 about naming files the same as the single DT 
node in the test file.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
