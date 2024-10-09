Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BCFCED628
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 08:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 896528915F;
	Wed,  9 Oct 2024 10:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="uNKXZv5K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0068E89160; Wed,  9 Oct 2024 10:21:44 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20705.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::705])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5E708902A
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 10:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TL+6a1LOYyDLox/IBM6MSFq+5NvBm3LJEDT1rbciU61NxiFmWAVy8eqlqMDuw4s3zIJTpHH1qYzPjtj6a6U1v+vroGSU/jad7SPJVyC+CaiOtTglE0lxmEQ3HHdXNHiLDye4SXnXoZgShncC43gnm4Y8Hv1T3jv4t9dnU6qVqxTOptud3AOe1Dhd91FtsiizHv0+EIQPliLpieFPV7Q03ReroGTazZJqC4KwXgFWQi2PuWRi8gSvsbRLy/Ots/Aod4+MCxAMpWrRoVKkoEaecVuFb5wa7qEB8Ut5t3fHeSk3iTY/A02NxxhJTVgSySMfaAlPcCea4a/1XIQMTD76og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8A/WIthcMbxFz1RyN+sG0aC8Se9Z9p2UWAfzmAjRGA=;
 b=H+if9E2dEdtXTULPZ8jJawJf9aI5b/5l09qDwHkuCHGL4BvtkKMDTCblnvBDHphkskeEdHZNiDGKDNhGWw5D9LQHKtjLF9mpochsbtb3zEFKi01h0ehA5gyidfvjHpXyIDKz2nXGTNdVlDIABwyg8W7Fd35Gj3Kc35dh4lXkcEqpG7ZrLXlVAdaHOuRut1DbJmf1T2kRMtrLcsvGsxXmrYAekahP7mKvJeTCZNkBrU5PGj/OZEE/hjjpkHDYtEKCyRxYolA5NBUcq/iYnBYBU62Vlp64xH/UhnHmTGrlxZEzblIdXFz7PQOjxLnEj4VZunQouUY9u5L3RivY1aqt3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8A/WIthcMbxFz1RyN+sG0aC8Se9Z9p2UWAfzmAjRGA=;
 b=uNKXZv5KvLi2bzwXkhPiWYCxm5lZCTggopW+0vNa8c//nVGqXaQX6QHg9bKl8W7258jejSXACKRqwhUlWst2Bk7LzPdiFmdjZLatntWbuS8pSsUIgw7K8oGW6/omjwuY8iRLlJ2YUIub8k9MOWUiQOOTJdW2HfiB43B1RPE6lXrJk3c5+w5q7IDPyDCHVYI5Q4VeshxAY+mLeAoaFfVOcZtvOoudRLGzRAxsT16CpHiTZJ7RcMTK33z4fYEZbBeGMyIBimWqp6q+XtMLdEGcY/DkgcOf9hsMOAiy8Gxf2yNfDLnn39Q+Xal6vihzNeQUs2/F5O0YA+fL1BCOP3zROg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB10142.eurprd08.prod.outlook.com (2603:10a6:20b:633::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 08:21:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 08:21:39 +0000
Message-ID: <f5fe4549-645a-45d0-9869-fc1c6e355cb3@iopsys.eu>
Date: Wed, 9 Oct 2024 11:21:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/13] net: tcp: improve tcp support
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Anand Moon <linux.amoon@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
References: <20241007205543.1632499-1-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszThjoOakb6FgrdkhvjAn1fL00wZeTGRewWUedqSO3E6+dQ@mail.gmail.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <CAFLszThjoOakb6FgrdkhvjAn1fL00wZeTGRewWUedqSO3E6+dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0000385A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB10142:EE_
X-MS-Office365-Filtering-Correlation-Id: a84ec363-5cb3-4b9a-2526-08dce83b6606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVJyU2llbytJZ3VtSWFKd21mQWZPRG1Sb3ZmL081c250MEhjUGltWFRxenlC?=
 =?utf-8?B?QmJKQUQzZmEzRTVjWStIUk9CbXNtSzhUb25WY1RaamhSUkRSSFBKcXRqYS9n?=
 =?utf-8?B?ajFqQ0hWSlhwNTU0cEE4bTVsWWgwK0VMc2NQWjJ3bkZrR3ZiZkxUTFhVK3ZV?=
 =?utf-8?B?bEhGSWp1bnFaN2pnODR0TWhzOXdLT1FSaEdlMG5TdGo0TnRReWM2TU05cDd6?=
 =?utf-8?B?c1ZEK2RWUTBWc1hHWlM0WUhDUU1jRHF4MlJHSUhLaHYxUUwvS3V5RHVQUUNZ?=
 =?utf-8?B?SFhGekJVQ2JpSlBCeldFd1V3TGhZcHJFWWdBa09nRGFrV2JLZW5QL0srSTZJ?=
 =?utf-8?B?NDFYNmNuRVJNd1d0c1lKYUl5MFJDNzVSTHdieW9aSHdUK3JoaGdHUzFjd2Qy?=
 =?utf-8?B?R2hndHNTSUVJdnJoMTVIY0VtY2tINTBYMXJMNDdEV05pdStGQUkrWlY5Sk1W?=
 =?utf-8?B?ck5IUEVUVDdQTHQ0aC9aYmF1SmRTKzAwdGlscHV1S3M1alp5OTFXWmc3MVRx?=
 =?utf-8?B?N2NWbUNpTU9pUHNjd0NudUYzaE1ITkNHa2ZoalozZEFzbEYvVlQvenV3blBV?=
 =?utf-8?B?Z0ZtSkVNWEVQSVBwYVBWNnIreHJzeXgyd3VOdlNWNFJtZEZZQkYyRGV0QnA2?=
 =?utf-8?B?d0pqaFFXNDVCRG41TDJxSWllU3pvbnpBclBBdlRSbFJoSVllQnY3SmZ3U0pt?=
 =?utf-8?B?b1pHeHF0Rjl0bXUzTDhPWHQ2dlJ4QU83bHlLT2pRVG51REF5MFZpMU9tc1FE?=
 =?utf-8?B?TlRJSmRxK3Q3b2htTDV0VGZQbHFrdEg2WGxJUTZ6dXFSdTZZUWJEdzVUODN1?=
 =?utf-8?B?Zk84VzM0ZVRoY21BQ3Y3dVVTRlVQbGhlYjA0ckZKbzR0Sk4vclFjN2pEVVdp?=
 =?utf-8?B?U01VOWhxMlc4RFN1c0V2d0xGYjR2eU53YWhxYmtWZ2ZOUHFHeEhqWHVJc3RY?=
 =?utf-8?B?M1Z0Y3pvYUx6WmdzV3FEV09HT0NOUXZndk5RS2Vtd09DOEFodFRYSGpaWFNT?=
 =?utf-8?B?K2ZXay82eUFIRXdjVzFtZVBzZm1JZW5QaWViaWxvTzQ2cmtwQWo0ZHJFN3NL?=
 =?utf-8?B?THdtWVUvVjJQK0Jzak9IbG1OQTI4ZjZocGRQMEE5aEhzQVRqcW5YNFR2cGM1?=
 =?utf-8?B?NVU3TlVWOUI2aGVNcVQ5dFdOL1p4c1BUYWlLRFhkM1g3a29QMXdYbHkyY0tm?=
 =?utf-8?B?UEo1SUZXQ2k3Sk5oNG1SZG9PM2JXMjNwS3NGTkljY3ZvMU5LdlRERHhna1FU?=
 =?utf-8?B?R3d4cEFWRVVTOEwzRFQxakI5Nzk0cDlJWWtCR0JEN01LTWNhUHlaUHJ0WGhm?=
 =?utf-8?B?cmJPOWNhUVBQMGhRNXZBK096MU1sMHlJR1A4T1Axc2orbHo2SnZuaXQzOVpa?=
 =?utf-8?B?M1lnUkt5dDRDdnc2MjAvNEtoeERKTmNSem5iRGZ5eHpUSVA2ZE94eldrMjhT?=
 =?utf-8?B?bGNEK1NGQUlWb1B1bEFYeHFVMWo4VHdqK0xscExpYWlldktGNWhvN1ZiUmpr?=
 =?utf-8?B?ZnNhOVVSWm5VU3FyV0hRY2NmZDhWRmJUNmN2ZVF1UDBWMnBWOURUY2toc3JY?=
 =?utf-8?B?WGxoeGtJTDhFZkMxMWFacnh4aTk0V29aelg5eVNZZGJTT3EzRkYvWExiK0Jj?=
 =?utf-8?B?QlhYY3JLVnhpV2h6Qy9wdlZrbUpoS2pKSWdTQStmaDZoeTdWd3FOdUQ1dVNv?=
 =?utf-8?B?WVVyWi91bS84Nld5eHVJYlROY3pwSHdscGJrTDJuSENmOWkyUHkxSTdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1hZdU9hQVNTSXZFMEp3ZGJ4L2o3bkpBK2d4UjNDREoyazcwdFNockp5bDBJ?=
 =?utf-8?B?Yy94ZFRQWXdDRzdSeFQvWVNLRXhmaXV3VzBFOUUyKzRiM0xlQkVYV1gzWkJi?=
 =?utf-8?B?S1pLV2x0dnZZS2UyRCt3b2U1aERvMnNIcVd3RTJ4VkQrNTNlYWJxQmpJTDBX?=
 =?utf-8?B?c1NLdmVOYUFnTTlIQUVlS09tZDVvbTlZUTR6MVJqbHY5aGMyRzMzNEgxRDRH?=
 =?utf-8?B?OFdDU3phUFlxc2xPcGd6bGlESDNJWGxEa2VWdllHbzlkN0NzdTYzdUUyVy9X?=
 =?utf-8?B?Zy9GRGJvRmd2c0Y0TVlsOCtIWDRDeHNxNWV1bURZK3YrNFdTQ2tXUWJPS0kv?=
 =?utf-8?B?NWQ4elZzdkxDaEcwZmFGa3BqTHZmelFETnQ1SGE4c1B5K1VrTmtpcGQxVTFP?=
 =?utf-8?B?dy82RzVVK3VSdWtVUDRia0pUUms4MS9IZWROVVlTd3NWVG1zN3ROMGxwb0ZL?=
 =?utf-8?B?dzdtWTMwUVVFckswR25VcUlaUjMvTTVIQi9NdU5FNnpCTld0UjNLb3FLL3Vi?=
 =?utf-8?B?NVpwcUlQYy83OWdkZjJpTVhpZVlyZnVtbUkwb1dydHJuNkYvbFVoSDF2b0JU?=
 =?utf-8?B?elJQclIwN0M4TlRCeXhTcFdWRSsvUUQxMkNCZXVhQVJ5UU5sMnl0YnF1Y25S?=
 =?utf-8?B?blF3LzVzUE5mYzUrK3c2Ym1RSW15R0Z5TkNycElnU3MxYVVxSjhzQWZPY2di?=
 =?utf-8?B?UFVOZHNmQUJGdjBVQktHKzJiaVVvYWdaTVRXK0JjSWFjeUhJVExNQ1A4ZUw4?=
 =?utf-8?B?TTRyV29UVnl3dVZ3dmVrM0c0MnZra2xIYlZCN3MvY3I2WWpveXY2WUtOZ0dO?=
 =?utf-8?B?b1pubDl5RjNhN2YveUx5dUo0cmpNaTNlcEVPdHNZRHFBeG9QeENmeEJKZVFw?=
 =?utf-8?B?OXFnRjFKL0VoQ2dBMEErMjUvcVFoMXZReGUvY3hBQmxYK0JrRDA1blJnYWtU?=
 =?utf-8?B?ZWwxSFd1VkJVbXZKQnBWSkQ2b0dpQ040QlpDWlV6ZkV6dkhvOTNSZTRmbXNt?=
 =?utf-8?B?SVpWMG54NE5sdW9SU0l2OW94UmZLUXBITUxaWFd1Zm9icWFGZVJLVmd5QzlI?=
 =?utf-8?B?ajY4dzV6ckQ1dlRkK2ZsdG1KVlRwWnlhcmpvdlhDYmJWaHcxTWVWb3k0YXA1?=
 =?utf-8?B?aHNsMVZLK2hsa2piNmpKd0l0UlBKS0xJamQvOE1zYnN0emwrd1hEYjEwVUd3?=
 =?utf-8?B?RjErUWh3WFgvMUJySDk4ZUEySTJwdUFabmRRUHlYQklPQ1Q2VWJ2YjZGUDBG?=
 =?utf-8?B?UHo1dFQxMzFRa0JvQzc0b3hqQWVYcTR1R3dZZk01ZHFyQjdWZ3ZMYXpUbncr?=
 =?utf-8?B?ZnNESGJsblp0MDRkNHRhSjhGUmU0UllJVDVHZERGVm1uNzhvS2NRQWs2bmlv?=
 =?utf-8?B?dVJiRTlSOWEveCt1MnI2TDBwb3AwWk5iazV1YWRjb3BDT0Rtc0RLUXFtQjla?=
 =?utf-8?B?eEhMd3dXZUVmS2JhbXZYdmZwR285dDY3cVh1TGg0djVnWithYXNlSlhRS1lJ?=
 =?utf-8?B?b2l2UEJFM3RwOGFyMCtZblMweFRBOU1kU3ZydURyL3R3cHBFWW9GSFg3Z1VN?=
 =?utf-8?B?bXZubTAvbWdXVkljT1pWckhxNE9JRnBXN3hZQXo4YUVUUWVXVWdCTXowSWZD?=
 =?utf-8?B?NjVrZW1xbDNNeHVsSmhrU1l5SHlvaWlhSkk2cGN1aHhpYTFoenNpYStSR21q?=
 =?utf-8?B?VTd4Wm9rS2tIVnh6eTJXei9pM215OWNwN09Jczd2Q2t2OE1MYmVvcndjSGZI?=
 =?utf-8?B?b05YQ2NZUWg0SDBwZGRCTkltV0JlbWNNZ3lra3hjdVIvRnNVM3RrUXJ5K29w?=
 =?utf-8?B?WWdPUG1ZVWltTUZJV3FGRWU5L09YdEZINmNrRm9LV0RTOHRlU1k3Y0NnRkxi?=
 =?utf-8?B?Yy85RnM2SnVJQ0ZhMDB4VzFxN2xiVGlSM3Rjdjlzc0Q0R3JxOCtJK2ZBcHpj?=
 =?utf-8?B?aHlWS0VHREc5c2tpdlFTQXZEU0laK2pHbyt2dEo2UmQyVnJqQXUwaURqemp3?=
 =?utf-8?B?NDdnRjBlc0ZYL2hhcDhlWkMycm5CQW96R01mcTZGUTZFNGlIcG9Kam9DYXRR?=
 =?utf-8?B?R0ZHWWZYQnhvYzJvamJiU3lENDZXSnYwcTlVem53VXp6SnNYK0NVRFozcHBW?=
 =?utf-8?B?d2ZBcHY5eDluU0JPb0xITk9xYzhXb1NsZHRVQkJwQ0NYUzR3MUhETWdVb1ha?=
 =?utf-8?Q?lWEf36TAS9bbg07oTi154Vc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a84ec363-5cb3-4b9a-2526-08dce83b6606
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 08:21:39.3395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1104tK3gP+7KI6Bjd0CH89uewwgSawwBKUbzyNPXl2swigZV8AaAQft7eCrNewa3CIsFrZlbu/Cvxa65ok3qXXtJp64Vf20JvVcwPeueDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10142
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

Will try to fix spelling. Unfortunately my english is not very well.

On 09.10.2024 04:57, Simon Glass wrote:
> Hi Mikhail,
>
> On Mon, 7 Oct 2024 at 14:55, Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
>> U-Boot support of LWIP is not ready for a moment, but we already have
>> some kind of tcp support. Unfrotunately this support is really bad.
> spelling
>
>> Some of the known issues:
>>  * tcp packet from other connection can break a current one
>>  * tcp send sequence always starts from zero
>>  * bad tcp options processing
>>  * strange assumptions on packet size for selectiv acknowledge
> spelling
>
>>  * tcp interface assumes one of the two scenarios:
>>      - data downloading from remote host to a board
>>      - request-response exchange with a small packets
>>    so it's not possible to upload large amount of data from the
>>    board to remote host.
>>  * wget test generate bad tcp stream, test should fail but it passes instead
>>
>> This series of patches fixes all of the above issuess.
> spelling
>
>> The benefits:
>>  * A lot of bug was fixed
>>  * Better and more reliable TCP state machine
>>  * Tcp cliens becomes smaller/simpler
> spelling
>
>>  * Data uploading was fixed (now it's possible to transmit a huge amount of
>>    data from the board to remote host)
>>  * Netcat over tcp was implemented. Netcat supports data downloading/uploading
>>    from/to remote host in client/server mode.
>>  * An example web-server implementation. This code can be used as a base
>>    for web-based firmware uploading used by some vendors.
>>
>> Modification was verified with
>>  * firmware downloading via u-boot wget command
>>  * fastboot over tcp
>>  * netcat linux client
>>  * Firefox/Chrome/Edge using example web-server implementation
>>
>> Changes v2:
>>  * cover letter was added
>>  * some patches were removed
>>
>> Changes v3:
>>  * better cover letter
>>
>> Changes v4:
>>  * fix bug in debug output
>>  * add more comments
>>  * codestyle fixes
>>
>> Changes v5:
>>  * old patches were ocasionally sent with v4
>>  * add back web-server patches
>>  * fix bug in debug output
>>  * add more comments
>>  * codestyle fixes
>>
>> Changes v6:
>>  * fix the wget test
>>  * improve description of "simplify tcp header filling code" patch
>>
>> Changes v7:
>>  * fix include ordering
>>  * improve option descriptions
>>  * fix a lot of extra brackets and comparisons against NULL / 0
>>  * add empty lines before final returns
>>  * fixed a bug with zero size httpd uploads
>>
>> Changes v8:
>>  * [tcp] add function to restart rx inactivity timeout. This may help
>>         in the cases where remote peer waits for u-boot data, but u-boot
>>         is busy with long executing action
>>  * [httpd] add function returning underlying tcp stream from request id.
>>         This (with the above change) allows avoid connection break
>>         for the long processing post requests.
>>
>> Changes v9:
>>  * rebase all changes on top of origin/next
>>  * update test/cmd/wget patch description (bad tcp ack/seq issue was already
>>    fixed in origin/next)
>>  * tcp: add rx/tx packet counters to a tcp_stream structure
>>  * wget: use tcp rx packet counter instead of own one
>>  * netcat: use tcp rx/tx packet counters instead of own one
>>
>> Changes v10:
>>  * netcat: fix bug appeared after rx/tx packet counter addition
>>  * rebased on top of v2024.10
> Is this series ready to go in?

I think it's ready.

>
> Regards,
> SImon
