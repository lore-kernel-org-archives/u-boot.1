Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7BF606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p+QAwtkh;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=p+ezWvpG;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=p+ezWvpG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83F6A813D8;
	Fri,  6 Nov 2026 18:07:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gh5nL2hk9BeP; Fri,  6 Nov 2026 18:07:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A55F1813C9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793988461;
	b=OIb4/Je+i7Mz3GnB/+zPXGU21iUhxwzjbMJk8XD9Tkc2id9D6hvgG3QHJ+fO4wx7I8kF
	 LefsNJAbJtiN14g/qmiE+yjGxpFzUIVySdbZIELfTphVPSI1WdIHL6Ocy7Za31XdTz+GY
	 hvcUWqMUirXUOIO+WBpj8KIORHXHYbviERG8ai1mrjDhfQcTHvByzTCRKHxT1WSq3wdIe
	 nV9Bq6+O3YssyuJ6FNbaOMkldzcpQyTTk9lBebfgvmSRsOB4D4BKg0hcv9yM2yhejIRPA
	 leHDJYL5RpZnvm35CEn/Fm8pTlMues+0QPGoJyD1TOv5GpBtF+a/4KhTM9ShMtKElnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793988461;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=b7snaEJDMNTxiwMm969KHJYS2E1g0dfTiDGjp94L+Ew=;
	b=Zf/oGgwqlhuv5CFqHEX/p99a+bUicFJuSWbg9hY3WYLvLAmboK3XWf9V/XZM9wGv8ufz
	 3EA+UVsnN6Ma0HkYuNtN5LkWnJ4tPUk/CsRGQiV05L+3idL/QZGpCrvV3py+1it1e3vTd
	 tGnQGdh9d4Ue/VTiMLs6XkoNQ35EPgMRexKWZknF2docS5sRoWfm6thW7ggnBT0osQ9bK
	 PEVwK/3JVSARR3KC6sMgebR3YUDukEslQiaNYCYwFbiNf9HKU8JA/kuRLnfHGPL1UZB2I
	 XvpjHtH3UySGBDDydfX6hr4R5AzBerfcX6LV4sMfQ5WOfIkVTjtyzhHF1F9wTzMvlhg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793988461;
	bh=b7snaEJDMNTxiwMm969KHJYS2E1g0dfTiDGjp94L+Ew=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p+QAwtkh0Ly7F6SYD+9zSwEB0cswmu0//lRMrvHSIBnoLhq7kFah403PooSRW0JtA
	 0PIxFoYIAN2xDh/9T6z2andgosfTUpJgmPRmW/92IbQLLpaD5A42A53GRUjwwIbz3/
	 BQIty6D/h/0MW9Kr6SgwS1MXIG8Alb3eYBmyfhBGfFtAOgZBtNUb9gAFXj6b9M1jVX
	 758X3wJbiBzsN0+fkC0WgkWurIHoMkFCP0+ZUkPYWGzlg26YCq4k6fEUgg5u9QLBTV
	 f/CfJIP+qaBDwztoPX2dfMX+5cl+e6esLiONc00oaxUAOTYfivIvQEx5vlbvJpUfOX
	 N+tW6OBKNzzHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A55F1813C9;
	Fri,  6 Nov 2026 18:07:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 01FE52E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:07:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC24040947
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:07:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EYW8N94SPyMV for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:07:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3D269408EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=p+ezWvpG; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=p+ezWvpG
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3D269408EE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7snaEJDMNTxiwMm969KHJYS2E1g0dfTiDGjp94L+Ew=;
 b=p+ezWvpGWZLA1+Aco5wrCMAkUQ1K96nFahydeZsAHE41LiRfRZHgTsSmd295WuBwBCgdUmsMgiDcYWpSJXkwnF9sNxJi/Bl4BE3A9+sEScia51mmBcgFvWdWCx0ihNa+PMHzA4OTC8iM6pZkClvrfOOrJ9j+LjuGmom8dBrDuaA=
Received: from PAZP264CA0108.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fb::23)
 by DUYPR08MB12015.eurprd08.prod.outlook.com (2603:10a6:10:65d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 18:07:32 +0000
Received: from AM7PEPF00000056.EURPRD83.prod.outlook.com
 (2603:10a6:102:1fb:cafe::76) by PAZP264CA0108.outlook.office365.com
 (2603:10a6:102:1fb::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 18:07:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM7PEPF00000056.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.2
 via Frontend Transport; Fri, 6 Nov 2026 18:07:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7snaEJDMNTxiwMm969KHJYS2E1g0dfTiDGjp94L+Ew=;
 b=p+ezWvpGWZLA1+Aco5wrCMAkUQ1K96nFahydeZsAHE41LiRfRZHgTsSmd295WuBwBCgdUmsMgiDcYWpSJXkwnF9sNxJi/Bl4BE3A9+sEScia51mmBcgFvWdWCx0ihNa+PMHzA4OTC8iM6pZkClvrfOOrJ9j+LjuGmom8dBrDuaA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by MA9PR08MB241936.eurprd08.prod.outlook.com
 (2603:10a6:250:104::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 18:07:00 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 18:07:00 +0000
Message-ID: <5f05513b-b6d4-449e-a3ae-02bb40c553b0@arm.com>
Date: Fri, 6 Nov 2026 19:06:59 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: phy: SMSC: add Microchip LAN8841 support
To: Robert Marko <robert.marko@sartura.hr>
Cc: trini@konsulko.com, u-boot@lists.u-boot-project.org,
 Manikandan.M@microchip.com, luka.perkov@sartura.hr, nd@arm.com
References: <20261102121310.460070-1-robert.marko@sartura.hr>
Content-Language: en-US
In-Reply-To: <20261102121310.460070-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0055.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::12) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|MA9PR08MB241936:EE_|AM7PEPF00000056:EE_|DUYPR08MB12015:EE_
X-MS-Office365-Filtering-Correlation-Id: f5fd5eba-505a-4c69-053d-08df3c30d422
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261028144727099003|261102123227099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: hN62e1/ncoN+mZrA5IA+a/THaOQiz0omyivuiHTQAl7A7yQoQBqUJyT2MrfuJKLp2fb1oE3qRD0aNtPnB793tka3UyHvEPtsPz8BnjJdTQ6QMhM+zMgWAsc5kuwZwrPdC/BxiJNBgbHs31j+LZ8t8ng/6ddWVE3t58zcBnuye6z+BZcvE/KnwzmU90OqkzDmggA99HVCseVThuUuvP1wac7sfz0ZQIa8UPU7cB7/bCE6xxfDDi0Ac34kOZHItyTVyivUg6ZkWHadLEsdogeJ47kcAMggka+Qprjcv+0324iqlLib2N25tISHXoZr7s0NrPtsm/V5kVDW0OpdgdqC3y34c4TI+/rl/0CbnWdEhlnSM+sKDaF1yEQ0uLNSTk5EWVPHMQW8IIXCD/WV9PffDw0KQ71+UZzi1p7mAhtPCx1OP4Zu18wx/aFEVWiFrdOxaalEmwTjIAaXvfS1412Acz/0pUpD4iqaKg84dIRz0+1Ix1B9OYz524gDXcKJ8twI52dyc+78xFT/0O5NXPu802D32QfZ7sszPj+Mdp0fJK+UWt/I9h0bkubHzaxMB4EGaIkRYTlmZUqMRQVnLxX15jqEwSNwVyBZZJDDW77E+/JTXWP4ThKsRjzfm09Bw5rj
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261028144727099003)(261102123227099003)(261026140227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: M4SpO2pg1W6jbbIoEl3fKVOhRkDlAWbky9RTbpEqKUFxtKutNbQT+9e8/LKulOMD/Rl5QfLz+frMFXKBhXDCQXXtxRqgpKsnuuGJUwpqGIzaB6fT3GFduuGNL1T9rY6PAcSTGukGP49ajsxHOe9zyO7BBk0kXbUzQ/2CMVK9D5/2mc1xdfyYjLHhRy3gsn8yr5svC7JFO6xcMCgg47g7CkTyCP4fT0mbwgQWvbmiSj6Lc9vEN98Ps6rWUmtsXemKlegN4x4FQ2wsXjKQ7Bwmx+HaKugmjXjD3Bm4yacczjQmBpAQzQLJ+zUn8bnm+/imLCN3tPj/bcx8HMbVREtmow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB241936
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7PEPF00000056.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a00057b1-94b4-493a-c3a1-08df3c30c0fc
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|35042699022|376014|14060799003|1800799024|82310400026|36860700016|11063799006|56012099006|261022105027099003|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CYTnTLo1fnCq2Mpy77pU5hff0Ul+29xc83TB1r7UOQXWKmVaUROIiItLvAVYHbmTBLZqJt/DpkxUSIS3yU0odHugWWeAp8j7MuIZ9N/xEG49SBVQgJrjRT3JstpU447OpqSXm+sbWoyc3TLF/54gZYUm2SGTo3Gmz4V5JMaR/YLsf69UwgTpZsIQOiQlopnurlxEyQrmWl6DkT0scqTF/GiNOePisqazRtH9/e/DPSp2YbixDUBLj47hEshM6uHcobtL9kVDd7WMN357NFdJZ6FOEYEUiBv7UM3u8cMKwUYLyVliBGGV2JxOE7H/IiYsptq7USnkf4aZC6zv4L/tSLGPYdt2dqxLdCg4ACSlkLm+fvZhsHAJsWK5npewSGTSmI7E40TcBwKG9Otc5X/GYlb1bv0E8uCQx5oSCGOPkoBXotPSQr+UuOGY94uH+MtUS41Zc7m4qexDmp9iHbBfb+nWBnF/85448i8KdvP8x/dbj1ilFmENJADJx2YxqCohG486ZlfZ/VaaVbIXdTd6+fY+6UxpFKHrVGqm7YceTEI1IAQvZ3tbu7IYNtBRSjezyCRTxRinIIlBqW/iwl2iH7N5JcU+bLhuOtMiBHIJztN8gNSwWctaIqfwQvO9JGcLG30TxB5L3MNdiGk1gunkfA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(35042699022)(376014)(14060799003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TNI8aSNw7I35GcyhnTZoj6aS0Dbwdum/qazP/4djeP1eF5YR6GrF2xiMirU4Bq6uy9g6p6wE8Ic0DvSPXq6g7IYa8YCDvpY1QxGQBkyQjmea8kKLIBIv2UgAzeiX63dzhK02fnf2i4BKCZJkd1FgJNuClK2PDa87LtwQdY1G4Xk7NCn9fUBKDUKZulKyNWCebMSCOX/epqdq/adsuRncweSE2Nou/aOZSlwSkn3snm+k2AbA62Ce2gKsQa617b4KkeZZ8Gja8P1Wdw9y4UcNtPGCSrcxYzr6x8UEDjjwq9/t+ygaJwW4AGH7+w/xwnZXi+rRBDniY8bK+0gPH8udgKzP28N7RlPhXCs+fnWBFpx8su1kiN724x0p5qzrnjN2uoMVz7QBondiFIbp2SbWqhbnV1uieAzDq2mrHTw4rzZoEWISrQTSLDxIYvlxCLRA
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:07:32.4079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fd5eba-505a-4c69-053d-08df3c30d422
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7PEPF00000056.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR08MB12015
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Add support for the Microchip LAN8841 PHY.
>
> It provides fixes for erratas, as well as support for enabling the required
> RGMII delays based on the PHY mode.
>
> It is based on the upstream Linux driver.
>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/net/phy/smsc.c | 182 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 182 insertions(+)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/1] net: phy: SMSC: add Microchip LAN8841 support
      commit: 6cad2387b3cac6132ef6d43fad22cc9f64a61d48

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
