Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AFB606A330
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 04:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yTuj7bQv;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JBizJRP4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D455F60E32;
	Sat, 14 Nov 2026 04:36:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oOLnzynRAe6U; Sat, 14 Nov 2026 04:36:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2AF3E60DED
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794630997;
	b=SGQrQDpLtVtroVtKhxZXAOU1srR+ia2pBiVmoBLTnJ7SykXbVxQxvK6eG+Xuh2gUyBS0
	 iiDO+N1psb4AWCnnRbSNfgjcGb5TWX4pYcns6UZVztOca7fKTDUoORiz/dZ9IrPATZ/Qn
	 CrdXFgZVYGMJViBrzhN2bSrEGTpc2UBI6NMp/Ec32n1GOeLapx9o+fVE55Xpv+YRGINTW
	 1GAUls2uzhMHQh+hV/0OuRhNdgukgnZnGUUcauWZRNzzxhM1NjMD2fVKZyQ73AQ3VxdN8
	 kJBwwBAJJ0r6OmzFCPOAmoieOusgQugvd/S0w5D5eCHcPxfqll0WJiJgCis++34SDWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794630997;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:Date:Subject:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	bh=qu5i/FC2toOKOtfvsl39DxMXw8ulJNMc2Y5KYsi2z4I=;
	b=SLi/0QYePjB/HHwyCPInn3QqDky6Xc9WTd13u3S5Gm3K2M66bp3mrp9iys5p3Mufm0nm
	 grcv2zcPEi5fQVIKqtHPKZ/t/CYevOI0SjwcxNzEWoROxopFc8238DAAAb3YIEDqPaoFG
	 EqHqEG4zUBs49hvHDLiXaHwhfb25T3VYq+k3Oc6z9uVmh2/aF3VsLi/BfHwAbnpJRDtOY
	 vMX200qWppXMcOnDE2Og+sp0HILL1NTvQs//TtJae9CCCei5mzRDJsq3/MiioX6YhKPji
	 mPm+r8SN36GuVoP9fuvVS1wh4xs/NWCinYTOG5nlji63+Ejr4KsVcU0Fcu8lqFj4icg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794630997;
	bh=qu5i/FC2toOKOtfvsl39DxMXw8ulJNMc2Y5KYsi2z4I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yTuj7bQvWxECtKDUh6/aR8ccBTdOvMrM8AMpIU1cONIiiZ3O5pOhWkK9XHsBzTy8R
	 PD4x8f+TyPVAlCx00mVgRsO6c5VFd1bNtYZ/uQn5nnv+4t2pUYU4ZIDluPrYBycP8P
	 rOVWweNaEvTBO+fHnjEKW/8H0OjmPKWQfcnvVCfrSzYuPine38iuKyzFYR7vpJXXy3
	 +0f08fndDJ5ooxgxuSl1ENAXa85A5yJ55FWw3SPvf10Ba6M8iqbee2JLD9OHwxH/QS
	 G0WZj3cLgpkjz2Q9hA4IRMDWhkIbI6M/mJHFUL08QtY8eU1PSBsktYzWq2mnlVGTpX
	 +8ScC+CfQxgcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AF3E60DED;
	Sat, 14 Nov 2026 04:36:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EEE6F169
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D4A6940E89
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:36:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mW5PafEC2Qtb for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 04:36:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0A4A140EC2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=JBizJRP4
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A4A140EC2
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qu5i/FC2toOKOtfvsl39DxMXw8ulJNMc2Y5KYsi2z4I=;
 b=JBizJRP4I+BGOIOYIO5fFb5YQ2cHKsKy0DAD0sXkhwbNaxea7Xis3lgOUDE8PMJ5BH3oqTaGgY6tTwoMPHPgojEj/lZAx6NiuBMq0J4EJmUua/aJYw+YEebisvsdCSyrrxpnpZtDixzymr4zP76wZxbb/R+Vj+4FZD8zafqB8Y9gdCyRUhM10ndGH6Gwsz0kQP6ouMEAYIhDhNyHf+ypbIuZ6hpc+qecNLyNNllEwgnIa9ePXQR0MkyLmPJoHiQ5pp28EtSa6RJH3kphrnu0WfnnFqzAOLf6cFklaqFsSalr5k40bvZtfTnb7uKtkn/4tWoaRp10ANpLGx/rdETcpA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by PA1PR04MB11082.eurprd04.prod.outlook.com (2603:10a6:102:487::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 14 Nov
 2026 04:36:30 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 04:36:30 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 14 Nov 2026 12:41:17 +0800
Subject: [PATCH v2 2/3] arm: dts: imx91-9x9-qsb: add U-Boot specific dtsi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-91qsb-v1-2-046293559467@nxp.com>
References: <20261114-91qsb-v1-0-046293559467@nxp.com>
In-Reply-To: <20261114-91qsb-v1-0-046293559467@nxp.com>
To: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Joy Zou <joy.zou@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ye Li <ye.li@nxp.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Johan Jonker <jbx6244@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|PA1PR04MB11082:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad1c7df-3bd8-4317-5bad-08df4208da8d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|366016|23010399003|18002099003|22082099003|261009220027099003|261009221227099003|261009223027099003|261009223327099003|261009221727099003|3023799007|11063799006|56012099006|261102123227099003|10067099003|261021121427099003|261021123027099003|261026121527099003|41080700001;
X-Microsoft-Antispam-Message-Info: yVzrkr6BFEWt3xL2y3NIvlmu2wfLuob80qw6bM7aTHMDJArWK0U+2BH6vz22fm4o1ka1++f4Q1VnowpiZEMXcRN3lfp4Almsx/znnWuK04Pr/GChqgI9hRtQQPfeLYXAkvNGsCoqInGKBGK2o1SMwM30SXAr6QZyKt4eOxihdZMq/9wB7Ht+HXWnqugbPPdSNoH3Y1IDvDOuZORK8wMWr14swS1ILaTQ1fpOu+zWmd6nbtUfegMHoghqjv9WE3lVwpuzLnB6r6SH95IRK3HGY4rRTI8TmVfm5LKpIyABQO48i5RmnYVfe4q3GCyPalHm9YNHulj+1TMevb28/J+700E4bIhgFLTBYA0hlm3eU7cO2rzaZtCHJwe6T6m5QUKAEPuzSdo4lsK4KVWigiu8g/cQmXnbwQvQNE4fWNHay+nYSaQJnt1CEH5j2SEGxExHCFDG+7gE9JbKrM2h9b1LzSZubPBuVA6gMTTNuEN206jdxDMcPd1AbX6G+yPEc/aQKOv3cRq6KL1IRZq6OpzVbxtnHqDkAbLF2bYCeg4pwATxeSYwNtQYSz1rVVwrxn6RkzRpl4lrDEQOlrqqciBlHgASPckLVJuZisq+S0IvHBJj0NBAvrSdzlxrTjqO9ENI/gMimktBXhlGdKo4niZCYPxOfwxLHHCMwLtTcC5cXuvM6ehkQHunDqj3DgQQAyvy4n/tKLM+rK7EKxNHRYW13OqzQFaPixp61vt1FS4Z2MU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(23010399003)(18002099003)(22082099003)(261009220027099003)(261009221227099003)(261009223027099003)(261009223327099003)(261009221727099003)(3023799007)(11063799006)(56012099006)(261102123227099003)(10067099003)(261021121427099003)(261021123027099003)(261026121527099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXFCVExWMEZBM25xdUtoTnlMb0hVQUcxamQ5SlBNNXRGbGwyNUZhcnp4dCsr?=
 =?utf-8?B?WkVqU2ZSZ2FNN0xTc21UVGwvWjdtZVBLMEE5Z1RNUU1PdDNJa0JtZHdlbHQ2?=
 =?utf-8?B?ZkpCbXNTaVN4anlaZ2tRQ2JKU0Rjdnk5QWZCWkREbjgrU0huSVpiYnNFWkJV?=
 =?utf-8?B?WWVpNTBDWjBqanJZRmc1SmlEaGFGVlMyNTZCcksxczAxNUdZTGFXWlZ0Y2pu?=
 =?utf-8?B?U05yVDAveDNYY0s1OW4rbjN6dFI3blRJM1ZXeE9IM3k0NFIxTWNreUJEVDhh?=
 =?utf-8?B?MDM5NUlqVU1DcjZTUzRCS2dzSi85T2FyMFJDTWRQeVJVNFRUSVQrZ2ZRUmVz?=
 =?utf-8?B?TlpabDVCeGcwYzc0YkEvSldoK1pPV2VsTDlSQnpTWXhpM1ZnbG43a0pYYXBR?=
 =?utf-8?B?Tk15RzRqdkd4YjlVdlNvSkJJK3JmaFhJRzdoWUhXcCtIeFRhUStqZVJLRkxh?=
 =?utf-8?B?ZGxham9GQjFVR3hiNTdxKzU5RnFXL3dIUDJydXh4UUxZZ2ZxOEg4ejY5Rlhu?=
 =?utf-8?B?cXJ2anVVRXRQUTZZVHZ1aG1MTEo3VW1yd1hienJPU3ZJYnl0K1hVQzd3K2Nk?=
 =?utf-8?B?MFlQVmVqVXV0NjNxcWc2dlJoc0MwUngrTkxjQXBKYml5MnBBNmRxS2lYbWpS?=
 =?utf-8?B?aWphK3FMWnFMSHBkQ0ZKTmVNaGt4d2lpSGlyUXdnQkMxR3RWc2NSdTJueUJ6?=
 =?utf-8?B?S1g1Y2NpRnBTemlTbHBFRldxUTd2bUtrbVdodG1FZ3BLQ01FUmE5b2c5OU85?=
 =?utf-8?B?dm1Gd1dDWHg4dGl2YjhZM0U4UXJtZXZYMmJjcXNzTTlZSmorRlNQZ0xkY3px?=
 =?utf-8?B?cVpPS3hIV2JmaVdZTUMzcm85cTV4RlFCWUNycUtWeEpKVVVKSXJyODBHNjd5?=
 =?utf-8?B?cDB4Y09JSVhTNzJYUXJBNnNnbUJVaHpTNkRMdG9zUDFGV2ozeno2MU14WCts?=
 =?utf-8?B?QnRtaGxvUzU3ZC92MU5vOHJtT2htamRTK0hqTGdYYVBvbU5hRkFaYTROVkMw?=
 =?utf-8?B?UkZDN2VjWGhxSTNqUkh0TUNlaXNROHRrK2UzMGJ5UTdDL2Z6aUdPYlVFV0Z5?=
 =?utf-8?B?RS8xOExLbGdHa2YydXk1QzNKS1EwRUtzTGJDbkJpVUtlRHpmQjhQZHVMbmpa?=
 =?utf-8?B?Smd5UElkMkVhYkVZZHl1MStIQThZcnlGbEliQ0RlRWEvNXJjdVRVZjFyOEh2?=
 =?utf-8?B?QW9XSnc1dWhsSFJERjFRNi9HWVBYSjhiUHVoYkRkcHUzNnRNNXowU3JUMngy?=
 =?utf-8?B?MFN3aFNaTkJnaHZhNFJEVTFGZlFlemV2NnZZWGxxNjhEakl0SDE5eTEwVW5R?=
 =?utf-8?B?VmIzdFhLY3BWR0tGQnZ3cmNZa2pqZ3N2V1Q0Tkdoak5QN1laWWtXdW9tNHVU?=
 =?utf-8?B?WktkZXdHc0VpcnVFVUtYSFFyWkR3K2JxN013OHB0UExacEcyY2g0UWM3N3l3?=
 =?utf-8?B?dWRHVGhqWHVPMW1KMWpoS215TlVpY3RzYjJsazFaKzl3aWkyeXF0ZTk1Q29V?=
 =?utf-8?B?WE9VdVl5Yis4d2FDZmttZmZzNjQ3amM5ZUZpVFl4SnV6TnhJOEsvUVdoK1Vp?=
 =?utf-8?B?WjR5Z3Z4NFhsQ3BHM3JmQ0s5QTNLMjV5TTdRMWNndjBZVms4eTVhdEdLeVVF?=
 =?utf-8?B?b29XWjBHZVUwTnNNYjJsNS9WR1F4aFN0c0YrSHhrOUZWdzNnQTRPMGpnaGo3?=
 =?utf-8?B?SThmY1c5cFFlS2ZLTlpFQmhSSTV3UGRscyt1RUV4TWI2OG4vQzJEcGdIN1FD?=
 =?utf-8?B?TW1ubFR1Y2Z5d0NORCtoUjUveVB5V0RlQnhvMVgvcGhaZm1vT01wcVp5Q0pM?=
 =?utf-8?B?Zk5TeGZoekRsWjJ0MzQ0Z1pBaXhVbzhEV3FGZHJrdjhYRThhZFg4ODh1NWhQ?=
 =?utf-8?B?dHhiR3p0TW9rWGd0M1NSdndDc0xqQmgzaURpMXI3T0J0UjBLTXg1b1JwU1Bp?=
 =?utf-8?B?UGtTcG1ML0hEZG9ZWmZMRXlRcjRSRzJYelRjY1BFK0plNnRna29ESXdOZWNs?=
 =?utf-8?B?bi9RZzk1YVpsQmZrQmdwQmdxS0VSUXhUY2pNc2h3c3cvazJpUXU1cE1tMldW?=
 =?utf-8?B?QURrYUFRZmNxL3ZYLzJzUzhBaXhwdTAwem12WDl6ODZMUkJ3cmtDblBSSDV5?=
 =?utf-8?B?Q0I1UnB6UWRPK3U5QjVDcXVGNUFWTzRmMjR6ZVpTeFBMMzNHZ3dsY2tTdmxF?=
 =?utf-8?B?U2RZbDgzN0k5WGdoUzNJTTJyTUdjOXJibEhPd3p0ZFJkd0JBMnBPNEZGdW1B?=
 =?utf-8?B?TUlOamtpdGdSQzVPb3JhR0FuQnlDVVU2Vzk2bHdTanVzbXhzRWZEeXR6RTRR?=
 =?utf-8?B?dE1LWXJyV1E5WlhnUnV3anVRRzFITVFESnVYekFudHc2QjU1UUhnNmh6eW4w?=
 =?utf-8?Q?0LZfZptBHbbWRLn/FGUilBUelCXT5XiunagFB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad1c7df-3bd8-4317-5bad-08df4208da8d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 04:36:30.5050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ik+spKV27UMdfzyOfzvKiXzZ9zFfj2Cbfj/A4pZN9uFLz6Sv5tAt65TcAeWzzWsuu/HdfwjwIva8xh/n1kV7W46lCJ6CxmGUv/7gNys2poF1WZj1bTBdlmF3F58jhI6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11082
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	T_SPF_PERMERROR,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Joy Zou <joy.zou@nxp.com>

Add the U-Boot specific device tree overlay for the i.MX91 9x9 Quick
Start Board.

Add GPIO hog definitions for EXT1_PWREN and SD3_nRST. This allows the
GPIOs to be configured from the device tree instead of board-specific
code.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx91-9x9-qsb-u-boot.dtsi | 72 ++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/dts/imx91-9x9-qsb-u-boot.dtsi b/arch/arm/dts/imx91-9x9-qsb-u-boot.dtsi
new file mode 100644
index 00000000000..f563f851a02
--- /dev/null
+++ b/arch/arm/dts/imx91-9x9-qsb-u-boot.dtsi
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024, 2026 NXP
+ */
+
+#include "imx91-u-boot.dtsi"
+
+/ {
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog3>;
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
+
+	aliases {
+		usb_gadget0 = &usbg1;
+	};
+
+	usbg1: usbg1 {
+		compatible = "fsl,imx27-usb-gadget";
+		dr_mode = "peripheral";
+		chipidea,usb = <&usbotg1>;
+		status = "okay";
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+};
+
+&A55_0 {
+	clocks = <&clk IMX93_CLK_A55_SEL>;
+};
+
+&pcal6524 {
+	ext1-pwren {
+		gpio-hog;
+		gpios = <13 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "EXT1_PWREN";
+	};
+
+	sd3-nrst {
+		gpio-hog;
+		gpios = <12 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "SD3_nRST";
+	};
+};
+
+&reg_usdhc2_vmmc {
+	u-boot,off-on-delay-us = <20000>;
+};
+
+&usdhc2 {
+	fsl,signal-voltage-switch-extra-delay-ms = <8>;
+};
+
+&usbotg1 {
+	status = "okay";
+	extcon = <&ptn5110>;
+};
+
+&clk {
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-rates;
+	/delete-property/ assigned-clock-parents;
+};

-- 
2.34.1

