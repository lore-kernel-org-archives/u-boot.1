Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8095606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cUjKtkPL;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=TpYWxRQR;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=TpYWxRQR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9852607CE;
	Tue, 24 Nov 2026 12:51:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UNiiPEoZHYn2; Tue, 24 Nov 2026 12:51:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 77FBC60814
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795524700;
	b=LVql938258jfo/0sd8GixoL8PrusRyCTiLsU3qZiO80b0ywThn070oJVwq2RTw08RQeY
	 6b23jKfnTrghVVHROnIP1RhcK4O5xMqBvstpK4+1d3c3N+UdtCICuiCDeOIlz5OsEAo0J
	 6uEJY+gVpCOi4w44RMgcke5Bcts35et3sROqh1WitW+SN/5AbHTMTkJDWTsLv/NDTPei7
	 wQP04Jh/CWlpjzmhuKrx8J+bIk/M/1ImgLTUi3rxfocKHWhtPgm2RQOuzGuCTIMz52W4u
	 BoH3q4pp6XCxaN4Vej/FJrU/DUIDeqQN6riHBTdve3ZJCgg6m3KzE7mOpM7uyL7gYjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795524700;
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
	bh=YWE0G8nEde6HODuWuVbUheDG2gau4G7Scpq2cFJr7NE=;
	b=hAwNwNHjr0FOxxQj+7cWaGcLM4zDLHXABb2eIa+X6otciZhZCOqgrmjUaXc3OkPm43xh
	 4bdK/DvI06W1r7Sp+Bp7Mu5TjHa9o/BHwtL44FqmtkZBpKjkKwshGLD1qIRXK/OypKCBN
	 s3KXMnUOtwNU1XFzlHQcdMDUhm7oytujl9Bivbjey2ht+69dh66UVnV26NM3XHW4BsrxB
	 VptT81ju9JDRzyq1HevJGLyyACxCJQXHD+9IXFZV/ew9+dxT9mirRzgcFZa7WQns9JILY
	 F1I1dKeht8S9YcdcJu8hEIOtT+C22DlYXHrP1NmStos3XGpNn1GFEmeqFNmmbaqYfzg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795524700;
	bh=YWE0G8nEde6HODuWuVbUheDG2gau4G7Scpq2cFJr7NE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cUjKtkPLjQ4joTzYj3oV2JS4KPrSU7bdXKbJBGYdkGXB1m+w+ihAoY7qvkgyTIoKt
	 wZWRHbq2LOkGC+Z2IukvoOtRnDIorG2nAJOSXO3CyzNskyYWRlJNMkLUyIfysTq44u
	 0uHxG+6SoW6vpd443j8h6GpYpt2uOd4Z/eIHWXZqa0QImDnVI2F/MYdn+4wdzpgn1u
	 /isu5EF4zCkav6MDza24STS3rZiuKC7zXaugcil3I953ilrGxh2+yu6yT8/FLMgR4F
	 Xh2r1k7ZHdDsbobc/DzfjjC9FSPSz/psQreQa2wr9ucRCtXHhmjkhOLEB5R1PzFnJ6
	 Nq9vYfeGXA0nQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77FBC60814;
	Tue, 24 Nov 2026 12:51:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 813D53C4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 12:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 677A740687
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 12:51:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FFgcfub9IZyJ for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 12:51:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 195A040682
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=TpYWxRQR; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=TpYWxRQR
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 195A040682
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 12:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWE0G8nEde6HODuWuVbUheDG2gau4G7Scpq2cFJr7NE=;
 b=TpYWxRQRVYYV5dZrRYP/e+A5Mup3SQ6k5I4nWI7kd90MBv2sQ+79Bk4UP2UlUhPEBt1Ygr1Y6yNvhneSJxKsqfB8Inx10+oY2gdfwYlpKxSE+PYxu75hcy8hnCGTB4VLnNaGNaVeoGqXLwHRw+el42wWLGGIk1tuHA1ZzoSO6WE=
Received: from AM8P189CA0007.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::12)
 by AMBPR08MB605959.eurprd08.prod.outlook.com (2603:10a6:20b:798::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 12:51:30 +0000
Received: from CPH1EPF00000521.eurprd05.prod.outlook.com
 (2603:10a6:20b:218:cafe::66) by AM8P189CA0007.outlook.office365.com
 (2603:10a6:20b:218::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 12:51:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000521.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Tue, 24 Nov 2026 12:51:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWE0G8nEde6HODuWuVbUheDG2gau4G7Scpq2cFJr7NE=;
 b=TpYWxRQRVYYV5dZrRYP/e+A5Mup3SQ6k5I4nWI7kd90MBv2sQ+79Bk4UP2UlUhPEBt1Ygr1Y6yNvhneSJxKsqfB8Inx10+oY2gdfwYlpKxSE+PYxu75hcy8hnCGTB4VLnNaGNaVeoGqXLwHRw+el42wWLGGIk1tuHA1ZzoSO6WE=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DU0PR08MB8834.eurprd08.prod.outlook.com
 (2603:10a6:10:47b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 12:50:56 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 12:50:56 +0000
Message-ID: <8e7af9c2-3c61-44b5-bd15-40f6e063ef38@arm.com>
Date: Tue, 24 Nov 2026 13:50:55 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: ftgmac100: recycle receive descriptors after frame
 errors
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Macpaul Lin <macpaul@andestech.com>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Tom Rini <trini@konsulko.com>,
 Jacky Chou <jacky_chou@aspeedtech.com>, nd@arm.com
References: <20261123-submit-ftgmac100-rx-recycle-v1-v1-1-d2afd61f2ffa@gmail.com>
Content-Language: en-US
In-Reply-To: <20261123-submit-ftgmac100-rx-recycle-v1-v1-1-d2afd61f2ffa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0269.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DU0PR08MB8834:EE_|CPH1EPF00000521:EE_|AMBPR08MB605959:EE_
X-MS-Office365-Filtering-Correlation-Id: 964a810a-5201-454e-ebcf-08df4a29a8f8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|261102123227099003|261022105027099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: xL31tZuJsb5C47mma91GpK8tZGZuHMBd2SGi4OdL1JPIzIVsIPdo3XSp9xq4cbC5eVtVZTFud7MhKkK3JyALlBD21sra1zAV4H+Y6eeLgUWl70cmIhnGgDMfeoRTtjBbyibQxEK4NKnLrlbXGdJJvN94bQgcmdwSSMDS/keGCXd7xSxg3M2M0yeeWON6aFqxGM/0vFXWRP/+sdZ0bO2TdpkpF0dMNR+n98GL7O7EwTzZ8F86hju752nWHW2WU3WuNoB+XdHRBvFlW0qVV1unrQZ4zzfeZx3mGbSBLNcSDUeFyOzBENQKfTS1QiVKTgZZC5JgzwGfjQMUK6wI2nQhvdQsfBpo17ghiLuaYltw1YL7eX/jHAhFw8Q8THssKo1nRIdWeJLVaJO7vVACgqjvsSMBTJVv4+2Xa8gh3JVJXJ6v1pYvML2Edp+/fzkWLwF/0TjDGTnkZpSLnW+l/wBB7F2K25DjaxVjrEJwwqrbIZerwkiDIyWvVJRWaSVOeWVH/fR2ZKMQ2uVE79ASc/RUPBMPt36SSS94O+N6OaZF+tbTvV2iaGDLaFXE8CMeqzVM3IXCj6VxjTF8pt6xgw9fkuxzS6LtK/XNIl9Rk8GcIWUknJRdQ+0zoXP5jZ64nRnj
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: lEwWutaIUn26C0KVVRBKD12pgCY9wCzESqC+ClvNlTlflbEN8E2ZATERsZQc04t02jWoijE/fcp3UIwsecc9Uym0Em+lkRqvhkNySYQuLWOGHt0NFnSp9B0sjiVuRRJoewth1gn0+1ci4yCaW+9KRkt8KYjZEJFpibGxqpCElt/zC/gLN9oCmkJqa5DqMDvxQsxOUbj0UBZexJcFUfaXXMMSTillTNApoL5jk5itb58tMCFR1EUqOE4CHcaM1Wzxq9WCP4aqFU+emzcheCCC7XP4BkxlP52BIuRHW888JArBq6Z+Quribt7l1o5sqUpxiDrtAuDYI9LsqDNEGSk9ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8834
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF00000521.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 005d5517-537d-42a7-2a67-08df4a2994b6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|14060799003|35042699022|23010399003|36860700016|82310400026|261028144727099003|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261026140227099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: X80mT7xnDGrtg82uU4CWjGTMjBoTb8E/95eSyLR+LF4ZolOrlHhgPJVVVSSVarTkxrdIQt/GyJux2WmoUS9b93/sLBhLLJ55lcCmRjBcNebFwGsM9LGkyx//jVW2fYW/zLmAT+xJ0mGYiR/nfFlxHhPVLFcHeTOtRyix0HsMeq4Cw4hgkmXhvWhn80a7GHVNsfE5j/yEobWHSprtRgpUnq+rCbp1hbZkc/Ahd+M4btF7E3RSEBAkzzWH4kRfYak8KvTw1ujJnX0AN+dfGKCCowi+bQTcFoObmY2HvNLUfWrWsQ7GZUj+/JbC4H5y8T00qVMTlZuO39Iu8k+T8X760h7JaKbzHuGti/Pg8M6ODzsS9ZbyTtpApemPk3uwsCxfT6faWFyoNiUXBoXrzx/ugkVMvIvIkX2nJ549leiaKqzMbpQRf9t8EZE9M4+CYRJNabznSmb1GFz7wexIChrek+uaMUI8JIm0QBZ71jjfh9gIjZIePiQdjOoILVQ9FsfCbkDN3DfmAA3JDpwzOvzkrqVfBa+ae5zcDP2VJJbE1nDYr6bxBnUtdvyTS+XLco+e1VPJCSfGOkUF84C1J3/IZEEy5B0rOfyxSGSH2zopUk3xemgpwssT/GheyOYhhU4wQh1p721Np1eLn7hF4j2zAw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(14060799003)(35042699022)(23010399003)(36860700016)(82310400026)(261028144727099003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261026140227099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IOMvhWBSLVwUPnMGScqEGmb5KHx2akWA+lMyheqNSQxzCdAQ45Ntdo4WiuxIiMF+GY6qpoUI2I1Q5lBE6QdgrgtrLgLkyAUTnDtWx38R2iBRvM3WuIrC/I72QM7Lj6Iue1Wrga829Rjsx8BCi+MQuY8jjmDv64CGa0YElvvbIgx6RRWQsf31k44dFr2kt+Hdmn8ked91gr0c81RVa88nkUeOQBZxwvag9soh1K0TdvIGIhoQZ8nP86AyQSZQdMYFJ+Ny2/8Ui7cTx8u4Qe5KPZlnwOz/skFKk0tPpVGPcp3M51KVeunqPF2Au6OY0ZlRLf+gEMDG1N27nWMlMCNcuW76snyR6lX5xLbAZMGTfaQN8E7UANNIpunNF/OJAbg0lDBHJ47DtZUhA0J+ffLYIajobpwiSmMj1Pho/pA512bIaLen9v7SGaUDEaWPcSrW
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:51:29.7491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 964a810a-5201-454e-ebcf-08df4a29a8f8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000521.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB605959
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

> A single frame with a receive error can stop all further reception.
> The MAC has returned the descriptor to software, but the driver reports
> no packet without releasing the descriptor or advancing the ring. Every
> subsequent poll checks the same discarded frame.
>
> Return the descriptor to DMA before reporting that there is no packet
> to deliver. Leave a descriptor that is still owned by the MAC alone.
>
> Fixes: b3dbf4a51f38 ("ftgmac100: support of gigabit eth ftgmac100")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/net/ftgmac100.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/1] net: ftgmac100: recycle receive descriptors after frame errors
      commit: bed9fe32972b343922324d6cc98be8b75ad84961

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
