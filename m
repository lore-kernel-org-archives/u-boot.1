Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55179606A32C
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 10:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v+Sr1KEg;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=bYah3iRz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11A3B81429;
	Fri, 20 Nov 2026 10:32:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BKSAFi6ey_2P; Fri, 20 Nov 2026 10:32:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 48DAF815FE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795170766;
	b=CSEBg+EyrLcsjCI5I5S0AKpcX3E2iar5gkatorl+qjjcisu322Qd7rHQEiTvebWW0WKo
	 GkvTj3JDPK6CqytJqrKd1EQnlF1uNZzqhvV5WFnw3GEyHk0VNSE+Tg4mdogZxsHE3/CxY
	 x5s73GXxK3DAHe7ovW3vp41JLi8SylcHzYtku1id+Oux+4cF5dF3P75ENHNPAONi6PMCK
	 7qT0mHBXuNYnkcKahmdClBR25DZGyWN/T35ssF5Ih3mKA4oNuoni6C81KgdrxJEHizrkm
	 285a/FMMWUZWKDgi/vnDm36QEPW6NYUxM/sKhTzPHBsvxBvJwjj6eJJ5F3c4WXRfeHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795170766;
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
	bh=Ghqrd7cSFHP5WbazFEi/ROM4RyOGWQ9jUITM1cR0fUQ=;
	b=lBYSS/7eKiDpRlSiLZPazeWgdHpn8Ce5KRUSQW8MEGmuUlEheQtECKiLwlgf47bzYCO5
	 vL7uvRDQtBUJ1hVJqAZ1zIlatPlz0QxxLBDHKEKIco4nLiAiwonp03dugwaHVgjk6I5Os
	 FjZPufh2lpZ3lWS+mlpawVKQR8QNDBkkY6kjKrOFZNxoKCJ+9fG9N36a7RK+zZg6vIq1e
	 GRhvY1alzwcQAYrh+j6F+1VkTzcRsNZG1M9jLLmay6JEZfxTZ9gAOwqxxOnH+zK70Nzo/
	 CnpxNT0WyI8WL98PFxBNyoRaZtlIqZM1fqEnblSHHAsmXcSkRnoHeqOIG1FXGKZZsoA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795170766;
	bh=Ghqrd7cSFHP5WbazFEi/ROM4RyOGWQ9jUITM1cR0fUQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v+Sr1KEgnOuWn2uXZV7ZMxuIcL0xb2imp2iRlEjcxb4RK5fVrhVVJyjZEyLMWfVsC
	 ovRvJVpIknLXonT+gqNji2tsisaNBTytVU0WkSxQdlgQtkkFK797NL2P8wi10r+sQk
	 KDL/MueiJz7/4J4n0AXGxoYl6wTCTeJjwiclq5K0avqZkHwr+aCWUBJHZnkhifEV4a
	 SoT5AMGEufy91Jm742BM/61KwHaxs7JK1nca/J16GwwTOBg3p7jk+xKPCv3WNTOraS
	 kOjZOyWoi0Yq7u6IO6kGtEvf8zI8uzSQjTNSIaKrCqLyVeSpB6bxQgQ40tLyNgB9aW
	 JaLD0I5EJ9MOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48DAF815FE;
	Fri, 20 Nov 2026 10:32:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 888E41C9
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:32:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78EF960E44
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:32:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mb1-tJZnn5ZA for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 10:32:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5FC8260E36
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=bYah3iRz
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5FC8260E36
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ghqrd7cSFHP5WbazFEi/ROM4RyOGWQ9jUITM1cR0fUQ=;
 b=bYah3iRzRF7+tacZhCYFSfq+zykEulmbppUfQ0Sb1UUdOD4/Fyp3/OW29sh0AX/snCWIO+bhzdtYezIc6Tighb+e8Icc5CDvmwPxyMeg6uWUADIjsixaP/ZNa2BdCM+Yjs5oBaIfTPYvpEI22KPTObkvGjJZBmvBZofVK6HbRgU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS1PR04MB9653.eurprd04.prod.outlook.com (2603:10a6:20b:475::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 10:32:37 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 10:32:37 +0000
Message-ID: <7e70091f-1af7-4bc5-890f-565ac34d6f65@cherry.de>
Date: Fri, 20 Nov 2026 11:32:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] binman: test name globbing support
To: me@samcday.com,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Cc: Tom Rini <trini@konsulko.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Javier Tia <floss@jetm.me>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>, yan wang <yan.wang@softathome.com>,
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
 <20260610-android-binman-v3-2-710298a38fcc@samcday.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260610-android-binman-v3-2-710298a38fcc@samcday.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0059.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::48) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS1PR04MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: e3694e13-e6eb-4b29-b27c-08df46f19898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|4143699003|11063799006|56012099006|261022105027099003|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: i48P19sjVgsevx66TL9B0E/yuunHhYeAUbk8kEf35CrNP9WWKV9AAXSbTpcskErQC7YW6XzHQOVtlQw4DCoZBzbRulQRDA9lO+qtgkO6xNdIpSBqqZqKgTFGl4fF91cL+lq/gjU32o6O/CsTEgD68pUQ0A1c7YWviW6a9Hqsb5cGHDf9Yaf/t/F18aQ/SzSEmXI1O6rywrO4pHqDKXO6foGGJnaOPeTzfAgevI67zl+IQdg0w5MhmyJ0P796P87W1E9x9VaB/YWNI+cksdy5ifMPWwroDX3FLvWm0L/8WieMAS2P7Q/vqa/X5mpMLjNY/GkXEUUQrBsmIt+Txk7Zx5++BXe3FlJ32xF3KQNWWYggSOnsdUQBFBjMFTwvdMcAuIEMkXUB9lRCwWRzOr1rNXE8s94U4E49IjAMwc9NpYBoILufnOV1VRH07BQcVm5uO6E4CDnwKXqkyISkBTiN824CP2TsN/Kdi9OKN68ONHgCvWNtBnNQWNyTvyJVI42+XnefrAY5LNJH9t9xeLuxxSc6ztU9NibL8MA1R7nV+fvpQr9m8v1ybomGIklmkWOR4yOA6cWvuxSbb0orROYctWt3jL6akN7cq4Ebj72G8x6kIHXev4lzliQRIz6xR63Gdjz2gnAMVZ3U58S/7blNa1GiDZd4tgacmmVzp7TxRDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZndNNWxwWHoyeUwrMWl5aFFnVlYyaDV1cXY0MURRcno1dmxkTlNJVXl5TFhS?=
 =?utf-8?B?UEZNMWpVbm5CQkNQaXJBRm16S3puRUcrSXB6emt2UU9pdGJQeWN6b1poR21P?=
 =?utf-8?B?Ynh1TUVCN2lqUkdjMzUzb0hydHl5c1JxZ0xJTjFxVEZ1SHR5Y1MwZGxnbVZk?=
 =?utf-8?B?cnZuOUtwRTlORzZPc3dHRnVwSXRBaVc4eWVRQml2dTBaUS9paGowcXhzUTNj?=
 =?utf-8?B?WHZPUmhGNjM0ejZvTDdIOEEzQ2kzMGwxM0g2a3lqcFh2VVQrV3QxZUlKWVZK?=
 =?utf-8?B?NFZsY2VYM3hPMHBoeFRZTldCWFYwdzZsMFU3cnUwekJjakc1T2htMnZVT2Zn?=
 =?utf-8?B?MHoyMHZJd3FYK255UXZjbExiR3lVVzdVYU42b2kyWFJWbi9nY3c2blQ2RUxs?=
 =?utf-8?B?cUswUEZZN0Y4UGJzMXVaaWtNN1dJU0FoM09Wc2xtTm1Ma2RGS1ZCbzVKellr?=
 =?utf-8?B?S0dPOSthY3hmWlBkZVVYS0JuR1JDY0RvSHBtTHI1VHc0VzhnNnF6STdpWVFw?=
 =?utf-8?B?emhkeDM0aGJTa2dEYWxpZTRMYmFBdnJrS1ZOSzBHOTgzYXQzUkJxRmE4UXFQ?=
 =?utf-8?B?U2NOZHdqV2tSN3dsUWdaUjgwbVFMTExVRGdoOS9EUkhhRytTVHlUM3VUZWcx?=
 =?utf-8?B?UE01VjFKWkgwcWFDelFxV2IyNGI2QUF6YjlCbnNvNy90blM2Z2FLbCt4U1JX?=
 =?utf-8?B?MWpzcG5kazFVY2tPeGxIc29GNCtOYSs4T0JTTWNod2d1WnplRG0zV0Qrd0F1?=
 =?utf-8?B?UWxLcDQya3NDaDFkaXplNURUemh3ZGNkMWFwZnZYMHBOeTc3QzdFTktkd0Ni?=
 =?utf-8?B?UDJRVlZ0dFpyUEE0UTg2RGl4SFg1YzNiZms3MW5mc3ZKS0NBc2F4SjVRaEgw?=
 =?utf-8?B?bkxHUVBJTkRZd0VzZjNFeEczTmVuQWdvVDJWOERxa0VTRW5CYllKaTRCanpx?=
 =?utf-8?B?YjUxcDZkNVlndHNCcHk4a240dTlsSXRlcDUrVmZxcUQ0VUpVZWpTeDNBVHJZ?=
 =?utf-8?B?TXBzc2JmNTNPaXhPdjN1ZGoxUVJBUDJvYlRVWEdIblBZdFI0Z0pUNjE5OUd2?=
 =?utf-8?B?VW8xMXFuWnU2TmxhTDdhc016Q0ltM1ZyREd0YUZodTlaMUtGUnVyYk52R0Y2?=
 =?utf-8?B?ZXNiTUpNZnRFMG9EcXdnNTlQbUtxVGFEdlZrZ2xvU0hoc0NpaXJqb2hOZzMy?=
 =?utf-8?B?cDBHSkQxVDdTQUJicDJFVFZUSnFEMWF0OGJPNS82ckJVVUIzU09mU3k4bUZY?=
 =?utf-8?B?eHlXM3pNVGpIWEFkaDlXbzB4QmU0dUVnNE8wNHpMRjUrNHl6MDlqNm1YRURN?=
 =?utf-8?B?RlZNZ01aVGtmMW9hcFlLWWxncG9YV0EyR2Y0RzFiYmt0dVRuL1FsRnduVngy?=
 =?utf-8?B?T1BNRmJKaVdHR0EvYXJqKzk3SWNHVGlOR3RGOG1UZDA1bFA0SXVGUGFOVmV2?=
 =?utf-8?B?UFBHMUJNY0Q3eDErSE1UU2dIMm1yUmhBRWF3NkIvWk8xemhEczdERUhsdEFU?=
 =?utf-8?B?K1FXNlg2Qjk4Mnl2T0VnVktFTGNncWU3MkRHMVpXSCtnVHFOOHVkWjM2bVdo?=
 =?utf-8?B?MEhhYXpBRml1VmgrVEFKTzdOYmJaZ3hobEZMOEIyVE9ZaWV6b0s1YzY5dkY0?=
 =?utf-8?B?R1pnWVRDRTBsKzdKbENQK0RhVzB4a2NXUWdlWjdMb0xycXhzc0k5OFQwTVoy?=
 =?utf-8?B?MmNEcUl4S0VhL3VGV1dOMVZ4aGtrY2x2QzJESDA5NWFvSDdMUmY5dFVyNlp0?=
 =?utf-8?B?UWVxNEFlb0QyenZoUHJ2RVBkNkVoeXNNSmY5YlUxeWNyZ0RSc1VUWkhxTFZK?=
 =?utf-8?B?V3BNbHg1VmNETDF6WWsyQzVacmFqT2VUYmhNbG9wV3VtZU5hb3pMRmJlZERK?=
 =?utf-8?B?TVRSdFpoWDFSYkJSNW45cUFOc1A1R0VYQ3NjKzl6Vlk0Uy8vSXlEM3d0R2gx?=
 =?utf-8?B?eEZLTGhLbzZKbGJ3VVd5VnpvZkdUbVlsczFVMnpGNFd6MFJBTWJ2clRQQkVC?=
 =?utf-8?B?SmQ1bWZ0d1hCbjlOTWJYMTRCZlN5eUM5OTZ4Y2lqa1BqREVITFdiVDVCZnlx?=
 =?utf-8?B?SUpGMCtCTllHL05IM3FOVmpnYWRNZ1JOeW9PM2RIUU9lN3hkRy9GOGI5ZnFM?=
 =?utf-8?B?ZTZlTnd0SHZzMjlUWEp6cHpPUG5yekpLbEhtZCsrQ2FGZEpUYjdHTXVlUzJV?=
 =?utf-8?B?UVR0NUNZQ2tObFdaYjkvRVFjSU5ncFNOS0ZqdGJUdG1YRWRRQ3JCdFg3U0J3?=
 =?utf-8?B?T0psK3pRc2lSWk1BaWp1alo1eG5URGNSRTBYRG0vTTRjNFpsRHh4Zm92TjNY?=
 =?utf-8?B?U0tHSlFJZUZ5RVo4SE9lR0hTVkEvVzk0RHBhaGpWUWxIZUxibksxQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e3694e13-e6eb-4b29-b27c-08df46f19898
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 10:32:37.4509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcYWDspFVZ5TonF3DREc0F8ywZ94iXci1SN3zNsaqqpJdDo3aLx89S86SZJs2bSFB9YMO7bRwQOLk0N+jfmWXX9GTxP1KbTxuwlvPYblm6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9653
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sam,

On 6/10/26 3:27 AM, Sam Day via B4 Relay wrote:
> From: Sam Day <me@samcday.com>
> 
> This makes invocations like `binman test testAndroid*` possible. It also
> composes well with the previous commit that adds support for multiple
> test names: `binman test 'testAndroid*' 'testQcdt*'` also works as you'd
> expect.

issue: missing Signed-off-by

I'm assuming it applies to the rest of the series, so won't repeat it.

> ---
>   tools/binman/cmdline.py         |  2 +-
>   tools/u_boot_pylib/test_util.py | 12 +++++++-----
>   2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/binman/cmdline.py b/tools/binman/cmdline.py
> index 9632ec115e5..b3be9f79b20 100644
> --- a/tools/binman/cmdline.py
> +++ b/tools/binman/cmdline.py
> @@ -201,7 +201,7 @@ controlled by a description in the board device tree.'''
>                    'preserve the output directory if a single test is run (pass '
>                    'test name at the end of the command line')
>           test_parser.add_argument('tests', nargs='*',
> -                                 help='Test names to run (omit for all)')
> +                                 help='Test names/patterns to run (omit for all)')

issue: insufficient information

What kind of patterns? A hint at fnmatchcase() would be enough for me.

>   
>       tool_parser = subparsers.add_parser('tool', help='Check bintools')
>       tool_parser.add_argument('-l', '--list', action='store_true',
> diff --git a/tools/u_boot_pylib/test_util.py b/tools/u_boot_pylib/test_util.py
> index ff275a7b7c0..2089b3574ca 100644
> --- a/tools/u_boot_pylib/test_util.py
> +++ b/tools/u_boot_pylib/test_util.py
> @@ -4,6 +4,7 @@
>   #
>   
>   import doctest
> +import fnmatch
>   import glob
>   import multiprocessing
>   import os
> @@ -186,7 +187,9 @@ def run_test_suites(toolname, debug, verbosity, no_capture, test_preserve_dirs,
>           test_names = [test_name]
>       else:
>           test_names = list(test_name or [])
> -    test_name_set = set(test_names)
> +
> +    def _match_name(name):
> +        return any(fnmatch.fnmatchcase(name, pattern) for pattern in test_names)
>   

issue: please do not mix function definition and code

Move _match_name at the beginning of the function.

todo: please update buildman argparse args.terms description

buildman will too gain support for patterns as it calls this function as 
well.

Cheers,
Quentin
