Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101A606A331
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CjenQJ/E;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=KSNEi0wu;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=KSNEi0wu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54BE480FD8;
	Tue, 24 Nov 2026 12:51:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wASU5jv4pKkU; Tue, 24 Nov 2026 12:51:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 73C0A80EA4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795524694;
	b=W39LvdeHKoD5D6OS+MX5MGhhQqidCihGyloPPY5mIKt10sLyOs7EU6LDEPPBbCaeQjvr
	 C8m3nIYAZxchwuF07X37Yw8AaehtJMgylCtF8jbNi24dhXoalXmrqfgxpBh74PcY1P5Nx
	 oQHwoRpSEUUbT7dxVO2Z6ikW/8RCKoKoIHKsegtSV/JLSoy8ppozOKYh8xo/pqpAJDOOq
	 R62uSqNiP0pDUQ6ejkvbcBiF5/PhZrQtwwRavykRdDg0dGC/m6g6+vt4Le+uJv5nWnEJF
	 CSXXhqfhyRRkQMDxwzYTS91DRK8L2Znpo6YFQHOFqeTXDCiZW3cR7z+m2vYtNX+Ww9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795524694;
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
	bh=iHpGUKfvLhvKyL/wH/td2b4NsAShixcVbb7hBq9ftco=;
	b=fwuoYK1h+FOh0dLbWUbKjCqEbt6gkdFK1fFChiloVBALrru6znTzpFWcO3I49yLPUfBX
	 0TzIiTjg0UuHz5Ghz9IkqXL7JTBosnfMWAuCyohB5zObBJpbfwaF00XfaLXz67AtcL9gH
	 piWoLjRX3/FM1Hq+JyqO6n1vcfLd/wdEWZaMT1a4d92CdgC1WOXWKj3HQlWt2xngkb9dz
	 chfwk/wbbsEGlbjIRWgNy0XvO/MSqmmxldw4vvirsMTzpmCutrj4BHvpX4mtstKu3SAJ8
	 zYUp7ciLuuUJYN7PmZyEXhu7eWq7jwwjB1iiie8YisCG7yHLHUgvW5sO+eHGyk2sZbg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795524694;
	bh=iHpGUKfvLhvKyL/wH/td2b4NsAShixcVbb7hBq9ftco=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CjenQJ/EBtJ6OvwNXyyAPi7AFMWtyY9TuJdGyOzhXL3zOZm+TLwDK0KUCJ913e1vN
	 QsrHow1lOyEH+pLN/v80NERKXmC0/oXD7zDqIpxGCjIlpJ/BZGd9IV4lruZU6S+p5o
	 b8Lt7cKaWxemp7WCi1L3K1uDLacHJeYXfBqM62z0eeT4A3b3oWUYNeWo28j13TjNLO
	 5lg6Ijz6FEsfM1Yi1pIz4vSu8+PwELzBtd/XrWNY82Kr4jT0E6iRz28u6D1zBnPROs
	 EgJ+nGHmqxfcoxhvMm6BPvyCI0I3DYkG1seBm6zsuSIkOew7Vp12vIiKqHyx88bpld
	 eOMkbIGfBZSDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73C0A80EA4;
	Tue, 24 Nov 2026 12:51:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C333371
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 12:51:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 394F140687
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 12:51:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rrJzusGOUr_M for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 12:51:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AB9B940682
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=KSNEi0wu; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=KSNEi0wu
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AB9B940682
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 12:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHpGUKfvLhvKyL/wH/td2b4NsAShixcVbb7hBq9ftco=;
 b=KSNEi0wudxGuTELVLMZQl1507Dlo9KSKOO/GG8Vjg9J3y8xn6L0/E/1OqgJpaCuQFhsUzZVEDFKkfXxo1Wpfh1wcUPTZiovOw2E7/oOO9RZTF5bI5ghtRCo2Qm9fImA5qN5IowGItyBB3XV8Oi+HWPIy7l7ijvCD7fxugLP/AdE=
Received: from DUZPR01CA0271.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::27) by DU0PR08MB9846.eurprd08.prod.outlook.com
 (2603:10a6:10:445::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Tue, 24 Nov
 2026 12:51:25 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::66) by DUZPR01CA0271.outlook.office365.com
 (2603:10a6:10:4b9::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 12:51:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Tue, 24 Nov 2026 12:51:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHpGUKfvLhvKyL/wH/td2b4NsAShixcVbb7hBq9ftco=;
 b=KSNEi0wudxGuTELVLMZQl1507Dlo9KSKOO/GG8Vjg9J3y8xn6L0/E/1OqgJpaCuQFhsUzZVEDFKkfXxo1Wpfh1wcUPTZiovOw2E7/oOO9RZTF5bI5ghtRCo2Qm9fImA5qN5IowGItyBB3XV8Oi+HWPIy7l7ijvCD7fxugLP/AdE=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DU0PR08MB8834.eurprd08.prod.outlook.com
 (2603:10a6:10:47b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 12:50:51 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 12:50:51 +0000
Message-ID: <0e90ce73-9baa-4f85-8329-41bf503ffcc8@arm.com>
Date: Tue, 24 Nov 2026 13:50:51 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: wget: Fix typo
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, nd@arm.com
References: <20261123085803.25333-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
In-Reply-To: <20261123085803.25333-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0269.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DU0PR08MB8834:EE_|DB1PEPF000509F7:EE_|DU0PR08MB9846:EE_
X-MS-Office365-Filtering-Correlation-Id: f09b3785-76d9-4243-6b67-08df4a29a5fe
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|261102123227099003|261022105027099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: 3nDd4gjlOCO00sGHMcGywskPIUz0KaTgxC/zwwOTieRuyAwrGLUqjnAxYf/Ln63gvG/zOR8DhkfWELHNoXHvt6W0xngwKY/skLqJTdhhgfEnm0GLpejRG7Uh8vQXkP+aLGxhGbiGp/G9QRsPnIGvawZsfUcEt20stTazWyPREG5BU3B0p4eAX2ngr4G+UtdJR1olQtjP10TSJ/RVn0YhMu6fwWvitRaPDwz9HX/gNyydgx9BsgIRsd0EQyaMA2+mJ5w4ZQlyYmqI0kU2c+f0sYK6pF5oDUIRYI4/QxcoMqs5WoKIOBEmObL4JyQJOPXq8uwT1AQKWolwNyUnAhR6G0xfVJ3OLkhSF1YJFiuCm6GmeA2948laMcSwXIwfGZ8GSJ7fAmfOZLNjUGDzCQkvDmUMdnMZuloCeryi2YXSGKCIuShRbShuvguZKeHh7byIbehbIQSwVdk24coEeaAu3nI194jo6kiktuhfx4b8JUZ+ghZd+kQdlLcGXGBLTjFT64yWqpfy3aghRqDl4AVNuOQuW37n9yKA25IRrB+g1ZQFLdo8IUQI+qZe464KaczQXOeZMm0JCLY3kBIqC37/uVtjwCjewRWXUCMxhBgeEkDjIO7F8sZoKbCZsuqltq5p
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: nRliQSEECD4n+4+Rq8QjoGUfuZSqKbnsn4mGa7m62/+u7zzlFYgiLagb3FrJ/TY2iFFyIH5oiQBipQYoT8NluKtd5WTtPLVY7VJggxAASNP4h1MHZLGXaqKcS7RD4s4efbXcYre7QSAAy13fpFOlfPM5QwvAxdJe9702XEq5wMT9/yazMFKX21CKWvBnkmSghW8AhAa7XjAbTVwnf+mbUGoHWAqOReoW85XMjfRowhr731+vpz66M1QGh0eGbAyDImszw3lmh5IjbBbwVJrEV/Rg2A0yxR+r40V7INCgZvpkkrZW4iqRft6Kb+8G25GBLxx19dDgNvlEjL9QG4QB/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8834
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 43f0b67f-1e50-4d83-df54-08df4a29921e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|1800799024|36860700016|14060799003|82310400026|23010399003|261028144727099003|10067099003|56012099006|261026140227099003|261022105027099003|11063799006|261021123027099003|261102123227099003|261021121427099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: L+2yNF2VAzfvJsupG5h6qzLqxbZ5jgUNuyjLepUeQsZyLa8w0CrK09sIE8JhIhWA+//xgd6hhA81T6/p4rETK217VAgXb1lGSx97Ty3AAxurTMUtHmQ8oRTPsnmUHSP38/C2pzPoW2vXFaRpW+61VTiTBGqX7+iyi3xESCKYAwb79ECck314nfLpTkWmpa7GCIJku9cmip3cqu9zK9vjIEX1fodjdqfRJrzn7SJjErGpm/ueDcuqgqQfWO66NjBrL9spxSDaC+JTZBf6vWwBIJyvtk8zdU6ENeV3hVB3b119KwJYUJdRIT4Qj8Ibv1+ue2lg3TInVcF8HYBrEs7ahsF6FBcgknAJQaUWDsYaj704gDWUHZjsDVac/a6ZEMReCObH5ElGJMj1BsyrZCvTXtx3fStddnFpmU16QF5xZInkg9uTCgLEMoMMlTp9QgWgW6RZoVHywb/YKa7NZafkuX+DvWWwDCp/PSxKbxw81yJ2Jd3znHaZa9VnBb5iFbbQeU73uotHDgEOWdf1Qa9dGw9OWxfvsoViFau83nedI1uWOpKgtOJZVhJxLUHhNJat7ZVMj3cWBFP7vrGzbMNIvWqb7IWW+vcQnkxWKN2toClm1CvDTZorpLt0xLl3/bNxjQ2Z/FR9KOjr0mu+ZkoNhw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(1800799024)(36860700016)(14060799003)(82310400026)(23010399003)(261028144727099003)(10067099003)(56012099006)(261026140227099003)(261022105027099003)(11063799006)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UQXTMvdrptOQBuFJqYRAWY9PztXyVzMNeAsLMWdxAqxG3/KJ+hreWbAb1USnUrEz2eSQGRIu0unQBLp/PY4lkmIRtwRjqeg8Ld+aHN5fXIszKFTS4T9WGo7Feui5NZ5pZ5FB/un7U+yusbcj/YQ7qeDNmC0jad4mvC4KJRziVtADlPlcBn2lqmesVRSiXyY5jSBbPBBfU4QkdsdCcw7RLviVlTRggC978dr0EPvOU9rEnHerTJhQTxpsN3zlqgPSEDWtiXtftxbVU0kpm5ANTN2Sb2PfjXiy0NdtyZBbogMSgyL8sPM3capWNDgJpXjw5LooJaT8/CnlTrmG70Wb0vZr6+l9dR/chVwNoFhKpiHXbyY17xfEyScYDBAzqxKNvMVicugfp8E5fmUaWDh97+mbaw3v5htL8lspqQaUV3KsMts9Btl3nm9Xb2NbWBXJ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:51:24.7944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f09b3785-76d9-4243-6b67-08df4a29a5fe
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9846
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
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Fix misssed typo, two s are sufficient. No functional change.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  net/wget.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/1] net: wget: Fix typo
      commit: 2804731be861f8215d3ae0c77d928d524251680d

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
