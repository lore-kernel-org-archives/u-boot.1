Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F17CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 15:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FD06828A2;
	Thu,  2 Oct 2025 17:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="qvkOmO/Y";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="qvkOmO/Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA60F834D4; Thu,  2 Oct 2025 17:15:41 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CB1080107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 17:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VrC5kQ9m0A82PCTHEltXzk3f5+vo9i2W/wERSk9tAWzXfKBIq0ovbIRWfBzxLgIKvhvIc7TuU8LAHJXB66ZEwhqVvSBPWUbLeMTsoHxxysnMJ1Nz1f85hQh3IMwNqy3JLKIuvAXKy5ilJ/4Z8CEUgZ1tQh3wifI5vHD3Wzv08LITcH8KkQ7x/vwa73tV59aWhttIpkdc20F/CfVHTvHVuG36wSXnkn9DelBOJb7/NNP7ovQognlkfBFE2owBpwb3YNiu2tydSW4OBYCfEyOx8Mbtntvuj2aVYDDzi/PO9LXNanxWoffo+nWgL4z4RI5rOTHj0uxwlgUyK5AUrOyXyQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ewYdKF2GS8nd4CjTJgpQZ41ngKUmXAa1s1YDpAYmlY=;
 b=Wq0e/LoneXAy3Gsz3erMGBQtZjBBqobDHg3TfETpJlyxM+ppuDeTUgf+i3SAHgxoD80d6N0wugx3QCQ9lEYxu7vzScjGOKMFafdco0WNBVnAwkNXQy9pY/Cf1WSjv2KEqY7cmXx5/DHbvLQkDA2qOZCh7nkDzm2+yOGDRXADSxeox6uvBEi38Jvj+1e6ueQbFZnZD+UF5Jv0G7RqdX2fjJEar8RWxgyPNPw7LBY1Lg38suqLeBCUNrz0nu7EMNK/mseUILvKL4uVsL+LM4fXlAqNTcOJerLMIznNK8cSZFm1ZGNORdXyj7siE/gmsry8pCrI4BU6Q4ZthxCO1209rQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=canonical.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ewYdKF2GS8nd4CjTJgpQZ41ngKUmXAa1s1YDpAYmlY=;
 b=qvkOmO/YEvZ7rn8uvD1Mc/2hd0i2sLBO2mdHo9WMOlaSCLkZwjl0RSUmS7qIKEe5XXybVFV7VXdgdbxoJBjAUJ3qNTGgmwMsHl5/qBYAh3/AkNnh2ttElrDupDBkRcX7UZU/IRImV7edj7jZCiEKFSoAt3mqHaIieutD2LjopHNdLDH8e8UIaoqVA7Ol8ZxWxaFrjviO2Tb4W7sXLG5R5R5JoO1Q7AsmLfENWbYGNpkkoiWQRQntTTh2rSxWge/QHBYBvyXFQyeB9cILNy3krpwFX6x4jtinWipMwEQXvLA+vww1ASJraPe8Rcxj01xq24zNCN4Nzflw+due0XEAJA==
Received: from CWLP123CA0200.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19c::11)
 by DU2PR03MB10068.eurprd03.prod.outlook.com (2603:10a6:10:49e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 15:15:33 +0000
Received: from AM1PEPF000252E1.eurprd07.prod.outlook.com
 (2603:10a6:400:19c:cafe::16) by CWLP123CA0200.outlook.office365.com
 (2603:10a6:400:19c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Thu,
 2 Oct 2025 15:15:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 AM1PEPF000252E1.mail.protection.outlook.com (10.167.16.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15
 via Frontend Transport; Thu, 2 Oct 2025 15:15:31 +0000
Received: from outmta (unknown [192.168.82.134])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 4D7ED20080097; Thu, 02 Oct 2025 15:15:31 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (unknown
 [52.101.72.103])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id C389A2008009E; 
 Thu, 02 Oct 2025 15:15:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSbfxh7T2ZuxABxO6MhMRu9YVYvH7kWl174ujwKuIPF8DP600U5c0IPG1/YBqv5c7fqOl/g93j6GXsmofkN/GQ7pPIza+DvhNQbtXiHzSri4HNCfT6Azp7F/pFcZSPutMscxLlc0V2GPLXyVgSnDM1gRZMAjGKpNpZdm2ynV/nSbxvjhR8EqQg4ir+Q28DZryGNogl6Jb9aRGnJ/P+XPWFM4zezPfYHNtetjhrLWZVyVuUw9bN4BARQeySTwwj3WfBSDlVyB2GVfjR2UeELvKpvYXMLWsObziNSPYnI910sxcyCroKT2cVzRrX0twDiWs1uLqFaBR6hvSQ+yPjI+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ewYdKF2GS8nd4CjTJgpQZ41ngKUmXAa1s1YDpAYmlY=;
 b=vtmZPCEh6HwU0oMdRpxTntqogSn2NhT/wz7N9sN0o5eaXoEBbIwokbCZseMJhngBf2CpSvBndbSeD1+UjlVkCkthUlc8bDgeuMXcs6ldl1qff1YsFvWvWJMxyVDAxMT1WhRRPTbBIyx3a58Wi5vXrCCz0uqgVOGq4DDe+OjHU6WmX7ZCurzVUVzUpHDzREpmIFkSl2N5R/qGfazlqiW5RLCrEIdu70DrbAh1KjvqK612lMq2M+GrdXzZVW06lDioPsbELRMbAv7LIZEhDbEgjzXXQorrMPc669s6oHXWKqIDZF7KJe+UdkkE5IntYiWOtk+wfAt2CCUKUVbmuID+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ewYdKF2GS8nd4CjTJgpQZ41ngKUmXAa1s1YDpAYmlY=;
 b=qvkOmO/YEvZ7rn8uvD1Mc/2hd0i2sLBO2mdHo9WMOlaSCLkZwjl0RSUmS7qIKEe5XXybVFV7VXdgdbxoJBjAUJ3qNTGgmwMsHl5/qBYAh3/AkNnh2ttElrDupDBkRcX7UZU/IRImV7edj7jZCiEKFSoAt3mqHaIieutD2LjopHNdLDH8e8UIaoqVA7Ol8ZxWxaFrjviO2Tb4W7sXLG5R5R5JoO1Q7AsmLfENWbYGNpkkoiWQRQntTTh2rSxWge/QHBYBvyXFQyeB9cILNy3krpwFX6x4jtinWipMwEQXvLA+vww1ASJraPe8Rcxj01xq24zNCN4Nzflw+due0XEAJA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by AS8PR03MB7986.eurprd03.prod.outlook.com (2603:10a6:20b:429::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 15:15:22 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 15:15:22 +0000
Message-ID: <25dcea70-da3e-499d-90ae-732ebd253a57@seco.com>
Date: Thu, 2 Oct 2025 11:15:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: semihosting: Use correct variable for error check
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
 <2780374a-3a85-4969-96df-34e331a53c53@gmx.de>
 <7f274115-8fd1-46c3-866c-278569aca469@seco.com>
 <c0aad39a-a72b-4f1c-b10b-ae922ae4039b@canonical.com>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <c0aad39a-a72b-4f1c-b10b-ae922ae4039b@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:610:75::6) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|AS8PR03MB7986:EE_|AM1PEPF000252E1:EE_|DU2PR03MB10068:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a692a0c-e33d-4f15-85d9-08de01c68719
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?RVEya29BUWhqMnB4N0dSUEtwWlJUNCtUSVFaRDl5Tk5ielFRajNRN3lRN0ZQ?=
 =?utf-8?B?QW9aWFoxRmc3QnRZbzBvZWs1Vll5VlRGZ3RFdU5UdTB1YlpndjAwNkhFZ0tX?=
 =?utf-8?B?YUx5Z1YzZ3o0aDlMTGt6b2Q0Q3NqeS9FZkF6TDkzZ0pFekp6UlpYNmhEdCt0?=
 =?utf-8?B?ZlltcmtOV0FsN3lDZnZ2dTFJRnlpYXZLd3pEUXpmYS9PQnhrNUZLQ3FSNDJC?=
 =?utf-8?B?U3ZScEV1UUVoVTlqdWVDbFJncXNDY042cWVQZHJyeXYxVXZUelV0MDJ6Ymh5?=
 =?utf-8?B?TXFua3FEWWcvajdSK01HT2UzallDK2ptVzJnVTJkOFRHNTQzVlorK1Rkd25k?=
 =?utf-8?B?QWQ3Q2VMcHBpUFZacCs1ak5qRUY5QnA5VGZmc0JmbWdiZjEwdVJxSkp2d2R2?=
 =?utf-8?B?OVdpSmlOMkhHSFVhaW10ZENKVUF0c3g2NmVtN3BkWkd2QUNqRnJaSjV1REVj?=
 =?utf-8?B?Qks3Vm5zN0VHa0xWWlVHNzR4L1o1ZTBLUTJLK0FRQmV4aVcvVEx0ckJvOUZz?=
 =?utf-8?B?bUxUYTMzZStiUktrVi9Ga2dUUzNGaVRMc2pSNitLdXVBUXl5K01WM2RCd0Q5?=
 =?utf-8?B?aU1UaHcxSU9ORERsSGppWTBQOTBSbkhjTGl2d0hzZ00vZlBFQzBnOG9sMFRY?=
 =?utf-8?B?ajMvb1BCSXdjR1VhaHBiL1AwTkQxKysyNVAyaWhYUDM5d3N5YUVQQ1YyaVp3?=
 =?utf-8?B?ellNeVlmcXRiWWg1ckUyY2JsNDMrSy9QZHB2TEhwL1pSK2MyTkRHaDlkdnZt?=
 =?utf-8?B?R29BbzVHVmZxZ3RFSXFKZmxqUUZ3NmNuclMxUkNrRENGbkxpMWhqUEpRQnN2?=
 =?utf-8?B?TjhFYmlaVGdKc1N5Z2pBQnJWWmpUd3o2OEM5ekRXcTZMa3BhWWNOV1E4K2Rw?=
 =?utf-8?B?Wk9IYk1GcFZUVTlOdWZ0VmVYSlFRVmZJQ3N1cUhzaDJ3RHJRUEl2OVdLTFli?=
 =?utf-8?B?U2ZRMldMRXExWHRobVB6dXVPQlJuN2dGNEFicTBvQVgvYnpuWjdDdkdXL1Bo?=
 =?utf-8?B?S004NXF3bTlUd1dDSGxlY0gzR3NrWllkdWNEMkc5TXVla0FlUEpYeDNqeWRt?=
 =?utf-8?B?dzk5aktuSE9DL3UyNDA0eFFHMzVpTWJOdnZpeFpWM25Ga2x1YTBYNTNyVlcw?=
 =?utf-8?B?Y3YyVHBvS2YxMjBRZEVpZFVVTmVURGlyVG5WTlFUUXFZR1JjTWxJR0J1UjZK?=
 =?utf-8?B?c0kzUXJzU0JQWmc1eGlNNEF3bGNGQzIyRjdZMzlRd1ZXT2NiTlZtbjdhbzVS?=
 =?utf-8?B?SG1FWmNBWkgzeU5RcUora1FPVXp5aGhPMk1wbUJTZW9zbXBQMFp5VHFNUlh2?=
 =?utf-8?B?aytpVWZHeFA3Y3ZYbnZIRWw4d0VPK0ZDTnhrMEFUK3A4aGNpalhIckVPUndm?=
 =?utf-8?B?SHR5ZVg1cWpmaURzYnVGM3N0bXBGcU5pOXBFYWt5c3QydmNUcTNpai84R3Fr?=
 =?utf-8?B?Z3lkd0drZW9TbXVHSm0rK0Q2Wkp0S2czUXhxM0ZlbGhHVjJDOVZwUnlpUWhW?=
 =?utf-8?B?Z3BVcENjOVIwQmpTSldPc3gySjlpU0pjdzV5Nk1vNDlPL1VXWjNtTGFJdm14?=
 =?utf-8?B?Z0xoRlo5TzFqZGZ5K2E4ME9Cb3RNc1ZnbVVXRzluVWkzMGlHL0Vtdm5Zb3ZD?=
 =?utf-8?B?T1ZoQkY2eUxEb3F6TkJ3Q2tZM2xsRmJoYnl0Sjh2ak02NThpSVNrMzdWNDZV?=
 =?utf-8?B?bU9ZN0JaVytKVXc3dUdSSVlRUE5aei9WcmdmcGFqNnNQblBYeUhFZ3FxdVNV?=
 =?utf-8?B?dFE1djNHeTVLeE1aL1JwTmQ4dXBRY1czQzBnYS9sQ0RTVVB5bE9wVHpZNjNi?=
 =?utf-8?B?U2VkclR2clV6QWp5TEJ6UERTKzJlenM1czFlNDN5VmpVeTJDMkdGTzZzbDVs?=
 =?utf-8?B?MHl6MFRYSUhGL2RlR0xzMkt3V1F5YTFkcmlvRGFHTHh3L05NUXpYRVl4M2wz?=
 =?utf-8?B?VklLZ3lvcUVqS2JwdFdEaWtFWkkzZXFsSWFkaUl2UGxPTWxqN3IyWkg5UnF1?=
 =?utf-8?B?TnNQM2JySXF3PT0=?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7986
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 165b67cf-b2b6-46ce-e2bd-08de01c68190
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|14060799003|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUdlT2lPYTJWNTRtT2hHZ2J5TnVqc215dkl6RVRzMnJPM2xPTUxSU2hETlVR?=
 =?utf-8?B?d0p5ZzlXOTkzZ2lKM1RrZGRFaTNIclBvL0g2Qjk2OU1YWFBnVE51b3pXQmNU?=
 =?utf-8?B?SHBpdjVOSlVZd0NwMWFwbnBxZGh3ak0rb1ZhemVtY3lVdlkrelRSRXFJODZF?=
 =?utf-8?B?dE9DSFdjaEhRSzNjK01LWVFCck5ua0VBQUphc1JJSXhtOFUzN1I5MFdPZkJB?=
 =?utf-8?B?NEZ6QXdJa0tMSW1lb0JEVzR1ajJuR29ZeWRFM2FsTy80b2E2VkszQ3VyOTRz?=
 =?utf-8?B?b2dqMkRUaEVpZGJRWjJKUUwxMGpRYW4wak5WaUM5YVZCOW9yUU93YmNKTUZ1?=
 =?utf-8?B?OWdQS2tPRnMvY1NkWnRxdjJlZnFQVHh3RDYxQk44Vm15VHVhN3VpbXRMUmFU?=
 =?utf-8?B?TWJzK1hGVDVGY3FwNTNxMVczZjF1UjREZ2k3dUJSYzdDMzBEQzJwdzdWMG1E?=
 =?utf-8?B?eVAraGQvdlp6aUl3QWZjb2M3Q2w3RWlFNXBjbmZTMzBZbVFIZkFPeVJodlE1?=
 =?utf-8?B?OWk5NGNyOTQvUUdwOFFwTGtndkNYbXdQYjhoMEJyanNPa2R0TlJHRE12VHZE?=
 =?utf-8?B?NmRzUG9INy9rL2dzUUQ1ZzRURm0zTThWa04wZFJyQ1hSd0NMRERONlkvQnpw?=
 =?utf-8?B?OTYyMm5UYUpTQXBYRklnazZNTGE3Uk5SZGoveit3bEFaclNPUlV5cHZtaFlR?=
 =?utf-8?B?WTdUTEtPTDlkejk1RHVVZjZLeURySHdVbEE5RHlUWGlmWHlFaHJXVnhMNXIy?=
 =?utf-8?B?NTVEMVpjalBoaHpOdzdMc3ppc2Nac05GdjZqTk1YWjI1aE1sUGF2R1BqQ0dM?=
 =?utf-8?B?ZFM1VVlvNzluUkZtWkc3ZktKcEpGOGhyUlI2OGM2WUwvNjZsVDBodmlmUHVI?=
 =?utf-8?B?ZjJ2aGRWVm0wMXB5UWFleWY4NjVJajR6MjRHUjE4TjQyQ0tOK0VmenpPV25Q?=
 =?utf-8?B?QmVQOEJJRHVkWVJWRW5lUXRVWm16dE16Wm1sdExUVCtZaitvWkJxSllNZm9H?=
 =?utf-8?B?RGpuenNob1FtWnoxUkdIdC9BMUJEcy9Zcnc0aUtsa1BES2ZEN3JreUV4dkhW?=
 =?utf-8?B?N3lmblZ3RWQ2TW12ZENON2tkSEFEcS9NM0FWWVRzd01RRDlUTmFveWU5NnBE?=
 =?utf-8?B?TUhwRWxxc0RrVjBBd0dSTDFneUdZRUxlRnJ6cm5YKzNhaEt1QkpCbXlJSVVR?=
 =?utf-8?B?VTF2bVJBK2pjbVNqeHVvaFVhajVDbVVuQ2xUVHpJU1BQUDlUTW9YTnFjeXBj?=
 =?utf-8?B?K3g4RVdmb1RpZVV2Ui9IQzIyMTd6V2FVSVhvWFVCWGptdUp5ektlRWhtY0d3?=
 =?utf-8?B?UUt6akpxUkVjbTZQN2VpZDUzSjhUWkZ1Vnc3VDdSenZlejNheUxqekU2aFk1?=
 =?utf-8?B?dUllNi9pUngrRyttV1NzRmRJS2pEd1BDdG5SZGNVU2JBbWtKeHZodDRTcGFu?=
 =?utf-8?B?SVZHeWVNbmZBaTVaWFJwUU1ySWFDdjllZEZ0ZnQ5R1NRU1RaVjR3RXMraG9j?=
 =?utf-8?B?Mm1NSms1bnNKSE5qNXJWKy9NSTVEcVo3UFZnc1VYS3FVbXJxdHZaT09ybG01?=
 =?utf-8?B?UTVOWm00MitIOTNIOUo4emNTd1EzK0RBcDZ2VTg3YnhTOG9LaVJWV00zalQ3?=
 =?utf-8?B?eTNZMHFqQnBCRm1YMlJHcnEyWE83SW5JQW9zc1V1ZmYzbWdxRUxmRTVRTk5F?=
 =?utf-8?B?a3JHUFZVZVd0S2dlYTZ4UXF1NDlhbzkwaGcrcVhidCsvbnBTWTFzcmxTSXVw?=
 =?utf-8?B?dlVqZmYzTkh3K0RuZDV0WXFsNks2WFBJYjArM09QTlpSQ0dTa3EyemltZzJE?=
 =?utf-8?B?Vk1GNWNIdHZsOHJzRXBiSDBhWlVBRVRsbkVySE9IL0U0bFh4aTMrZENKQ2Nq?=
 =?utf-8?B?RzBicmt1TTZNcHgrSFFQNHlPMWI3WW96dFdOa0hMR0ZTYkFzTUFMa2xxbkdZ?=
 =?utf-8?B?Q3hUTGRBU1N5ME0vTWMwVDNWNjRpYktnTERlOHZOTVVhdjF6cHZ6ZGhXemFv?=
 =?utf-8?B?SFNnZllDNGg5L0FIZSszS1ZrT0ljZTB5NGZzSFBNaXc5WGpoaEF2aW9DTVR2?=
 =?utf-8?B?Q0h1aThtMzllbmpUU0pqa3VyYnhpYW1IYkVXQkRGMXlqTDZkQWdMdUM4dEZh?=
 =?utf-8?Q?lToU=3D?=
X-Forefront-Antispam-Report: CIP:20.160.56.85; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(35042699022)(14060799003)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 15:15:31.4489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a692a0c-e33d-4f15-85d9-08de01c68719
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.85];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB10068
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

On 10/2/25 11:07, Heinrich Schuchardt wrote:
> On 10/2/25 16:36, Sean Anderson wrote:
>> On 10/2/25 05:52, Heinrich Schuchardt wrote:
>>> On 10/2/25 11:39, Andrew Goodbody wrote:
>>>> After calling a function that can return an error, the test to detect
>>>> that error should use the return value not a different variable. Fix it.
>>>>
>>>> This issue was found by Smatch.
>>>>
>>>
>>> Fixes: f676b45151c3 ("fs: Add semihosting filesystem")
>>>
>>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>>> ---
>>>>    fs/semihostingfs.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>>>> index 77e39ca407e4d240a1fd573497c5b6b908816454..9d7a136b9ba9b035545b34b31df58e2d65de7db9 100644
>>>> --- a/fs/semihostingfs.c
>>>> +++ b/fs/semihostingfs.c
>>>> @@ -35,7 +35,7 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>>>        }
>>>>        if (!maxsize) {
>>>>            size = smh_flen(fd);
>>>> -        if (ret < 0) {
>>>> +        if (size < 0) {
>>>
>>> The ARM specification (https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdeveloper.arm.com%2fdocumentation%2fdui0203%2fj%2fsemihosting%2fsemihosting%2doperations%2fsys%2dflen%2d%2d0x0c%2d&umid=f17ab8fc-2d9d-4cce-91e2-e7e66f117613&rct=1759398729&auth=d807158c60b7d2502abde8a2fc01f40662980862-e0799d2d4d61f93cae033d54733c8fa50ef84918) has:
>>>
>>> SYS_FLEN (0x0C)
>>>
>>> Returns the length of a specified file.
>>> On exit, R0 contains:
>>>      the current length of the file object, if the call is successful
>>>      -1 if an error occurs.
>>>
>>> Please, consider that the file length on 32bit systems may exceed 2^31 You must not consider this as an error.
>>>
>>> %s/if (size < 0)/if (size == -1L)/
>>
>> This cannot occur because on a 32-bit system SYS_FLEN only returns
>> 32-bits of information. The host must detect files that exceed 2 GiB in
>> size and return -1 (simulating EOVERFLOW).
> 
> I don't think so.
> 
> QEMU will read into the st_size field of a struct stat and copy that value to the return value. The st_size field will have at least 64 bits on a 64 bit system. And copying to the 32 bit target will simply truncate it.
> 
> Expect overruns for files that are larger than 0xffffffff.

Yes. And there's nothing we can do about this. If there is a 9 GiB file,
SYS_FLEN will report it as a 1 GiB file. This is a bug in QEMU (and
OpenOCD too) that we shouldn't attempt to work around in U-Boot.

--Sean
