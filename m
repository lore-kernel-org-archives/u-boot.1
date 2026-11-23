Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58F5606A332
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SzBXZk2x;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=JiMflBmX;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=JiMflBmX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BDBB80DC2;
	Mon, 23 Nov 2026 09:38:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NwUqS4QDPwxr; Mon, 23 Nov 2026 09:38:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8546880A56
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795426723;
	b=eVjUuAFc0zbOd7RA6XobYVl68mmYUl/0ukzgyswLWwITSmzFrXbwTrhqe8HRFJtu1Bxa
	 SQt3A9fl0RO5N5uqDBV8fFUm+oE168WxOjCUSTOuRS0XNL+UPb3izCNyDGFAFAqZFPo9a
	 +WUAVAHl5tOE4+StoqkOrvhh7Psfk6WtFJfqCY/IC9/So2QjUM4ekMsvra55kU5FLX1xy
	 LCEHfzTItEiQwc7tUvXi51PkufwOwJ4DKxx2zgMHfE37R1Wxfsua03GhpChw0tGRrfRG8
	 6y2jczqtc6L+UH4SlT2YEZb54NcTDIjXmfc6gRrotgoq7vn9TVR9ybQcMNymacT6XaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795426723;
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
	bh=nph3ojy3oYTY2r8/vSwNFaGsCDlLKFrRExonsq0M3Hk=;
	b=qfW1MSmxVW9QskkLzCYRip2exuGr50qNHSR63sPrmKG8lQD9GEI+PXTX8pn8YWB01b0x
	 6RoAc9qMHy3GSh7ll8AtUzeeHdUl+ltmes/dj+BKbDY5UC6k+KwY94/CYiWcPbXkSlTJ4
	 gv7wi3Vsljf5Iacd/O3L2YshPNfXiPzJr6x6aPnKNn4Rae8aiJUL/sB9krber65jcd/xf
	 tq8iaVc1E/vk6b/7/syqy+weGX1NqBb0GZPAC4c+9Y+/DjsyN66d9t26sUINdwSq8td4g
	 Yl6UAZ1Pp9SWNhPLMI1rmSegvSPBLFbx2w9mc2XUHxSFRW54ZqxRrfkp1jLrU1cN5/Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795426723;
	bh=nph3ojy3oYTY2r8/vSwNFaGsCDlLKFrRExonsq0M3Hk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SzBXZk2x1Uo7sJQIbHATWPoLc+1jAGEr//Fo2svwvZkGOioPuuhNcT0tZjAdJlwMG
	 Ob+URAm/5hlq+TpaLoGp0hGnpzW2kyBi2a7tzQIieWazXVhrK+QwW+4ygAaBJNCU7W
	 axdKLy/fdyfFsb2IQNLqat4u5xW/rrwgTYfEGEfv3PI7yTK/zr4v3tMcy5W7GuGTTy
	 k1GT3voMsUds3pM8Ey6j49izSxUMvVfuoNcBAkzm6fawpmluybP+Xn8NHUJX7U1NfK
	 PnrJR5f/2NXOR9quWGBVx+sD9H3RFCIajF2Qk3eSMxR7oimDe2IGmpjTR/qpDvzubG
	 XKfCHnux7+ucg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8546880A56;
	Mon, 23 Nov 2026 09:38:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5596B499
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:38:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5331D606DB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:38:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Ky0q2o-gPVH for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 09:38:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D739F606D5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=JiMflBmX; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=JiMflBmX
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D739F606D5
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nph3ojy3oYTY2r8/vSwNFaGsCDlLKFrRExonsq0M3Hk=;
 b=JiMflBmX3UufkfznhLXdoOYZDcIJ/hFPxiCO03uZbKXp+A+6RQTM/OY0q2BRHLNenlbuGNeQ6JQzPhMOP/3i35jTumY7Go5Ty6KQ/nPkKDcXXKlU0r9kpMfJBfRJFTQtaKqRM5eZNV/XyEXZjXh55b2zMp8XzmOyKoRLrgRjcxE=
Received: from DU2PR04CA0085.eurprd04.prod.outlook.com (2603:10a6:10:232::30)
 by BR0PR08MB197270.eurprd08.prod.outlook.com (2603:10a6:2c8:45::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 09:38:27 +0000
Received: from MA3PEPF00000409.eurprd04.prod.outlook.com
 (2603:10a6:10:232:cafe::9c) by DU2PR04CA0085.outlook.office365.com
 (2603:10a6:10:232::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 09:38:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MA3PEPF00000409.mail.protection.outlook.com (10.167.241.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Mon, 23 Nov 2026 09:38:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nph3ojy3oYTY2r8/vSwNFaGsCDlLKFrRExonsq0M3Hk=;
 b=JiMflBmX3UufkfznhLXdoOYZDcIJ/hFPxiCO03uZbKXp+A+6RQTM/OY0q2BRHLNenlbuGNeQ6JQzPhMOP/3i35jTumY7Go5Ty6KQ/nPkKDcXXKlU0r9kpMfJBfRJFTQtaKqRM5eZNV/XyEXZjXh55b2zMp8XzmOyKoRLrgRjcxE=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM9PR08MB6131.eurprd08.prod.outlook.com
 (2603:10a6:20b:2de::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 09:37:53 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 09:37:53 +0000
Message-ID: <c53b15c4-124e-4311-9fc0-ec69b0904f17@arm.com>
Date: Mon, 23 Nov 2026 10:37:52 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v4] net: eth-phy: release reset GPIO and reset control on
 device removal
To: Graeme Smecher <gsmecher@t0.technology>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>, nd@arm.com
References: <20261106-eth-phy-release-reset-v4-1-191b196ef4bb@t0.technology>
Content-Language: en-US
In-Reply-To: <20261106-eth-phy-release-reset-v4-1-191b196ef4bb@t0.technology>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CW1P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:29e::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM9PR08MB6131:EE_|MA3PEPF00000409:EE_|BR0PR08MB197270:EE_
X-MS-Office365-Filtering-Correlation-Id: f03c8bc9-1a9b-4e2a-1453-08df49458602
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|5023799004|11063799006|56012099006|261021121427099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: /ZteeQbwmpvTnv7AY1pO6Z8IZp7wNJlmgSEJ6yTvy/LCtF8tE+RnytDxslrBmYCIJ5URTMT7peNV1GQHTrCHI8ENWRgRJq0WBpWBsn8uRKr4FFhnCa7fZ5aTRA72kQly/5lE4w55Y/R6b/j3Jpc+YydlseR0g9QCqtF90ecFQO+MjHxzNSHqPHQEUaxO9vAwk+ltLDFBLhN2iTyUIiU/TySUMvn7mGru9G7mV3PdRoJjZ9a9tsVPr47Nmf3EV/LhpgpqcZ+664/5zbEmapFWIOH4XHnscQazgVHaf4HwylzzGQpvJ6VNU3cX5GCZhEWOuTarvpZwp48pF1lcljnMj4umi0IyoWlojiQ4te+xWk5RaYzsUGF2mxoA/Iw+NoxqTBzSQ8DOZXoOj8JZKOU935gtCgsZNnJtFK8sOiLEoC9DrxC3Tb4JAkT5gUnnbrl0H/kBUafCtfqHw5Ebsgih1US6/BeLNdrCYpVGzyM4dJ628Y3faVpJHhoaOMl04TRtGzTT1hCPs8ru6mpdGdKvY5jK4Al+ZpbQdKSUb9kTTCXjAj/SltEEC5QixvXrZ8Q73l2Nm+BpoA53h6N0OH+8yjwefZWHF8aweiEO2/P84pZnRaqRUHh9e06nDB1bgWHw
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(5023799004)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ErtvG/+PhRoWDA/MjIcIH4MpeLsNLHuwmJFxAUpMAKanG0Qbu7OZhSNHLXyOFKfK6YtswMcdXRKmww/T7Ky9DNYDs9PAbSZK6+eiIOauNfe9gO1+itM6iibv5IM29JOJ0LJ094JricjcC8K0jMgI4HyGUQXd4V/fD5ZF27Jn9J3jjf/SlKdASSgESJQfZiKMJawUSqsLrwIwFqvX/LbwSr7AQltCkuArZvbxT2YdUkTnuWCQUbFDUtmtnrkmzVzx50iphzgvZe0hUuxOhjt6otT4d/kyTVIJMlGviijJ9y0KVZc5YRxA9Z9i93K2AVM0Pfq42krActrRlerWU5ENgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6131
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MA3PEPF00000409.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fc64bd5e-8cbd-4773-60cf-08df49457296
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|14060799003|376014|35042699022|1800799024|23010399003|22082099003|18002099003|13003099007|5023799004|11063799006|56012099006|261028144727099003|261102123227099003|261026140227099003|261022105027099003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: u8ggW+MbdlQSzt7d441pFCkp37e25nYjzxwOMaXwNtfSgdlj11eXJKLfjy+2YUTZGQl62tWvPikoYMzPfEWoB9LboDHR/gSzOGeBHG4NxW53ICaOXeuX1OJ7bX6LAduPVhZeUBLor9ENLrRC2GygfSNyuA2OdoilutA9IYDRRa94WYgsqdcS+on0KJpzw8jrVjIdF5fS53jPWSTDDgsl5NzURzB8WH0KCfzUtMJvijys4M0/KzH+8iX9AGhdK/hx8NK3G+tXpMnU3sPXZrv2RYfnnJXY6L4grH1/G/H4ogn91NZPZLWVV/grOAlzheNnE+2Jh1Dua1KT8aMo0R4bGuCbjhQEN8tM4ZIPuXIouL/3m7g5BP6ISEBIKYU+ustRpoYGm+e/SrKqcUOln1/JCVZbGon+F54IKcrrt13Sdmkuj7NgAK1qk0lqDA84xuOo61hu9vVBxRkki25GMEnM8W0uh5bCebVrfalYViVg+Df180j/8xZsjoYw8TYluHUFFNBqgZmg5v30aEXEi77/ei7Bv1HrDaRnPIXDPuYeIdXNEsGaUz3zy8gr51SdlfgBqut6nU3FTJiZvy73R6IKkux3BG4qiu6z13Lhdpd+78l55H9WLGsBOWT0cEZKijLw4LENNCOy0bcJLU5xK95HUg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(14060799003)(376014)(35042699022)(1800799024)(23010399003)(22082099003)(18002099003)(13003099007)(5023799004)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261026140227099003)(261022105027099003)(261021121427099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e6CHfK+2xwPzHef9LPbA7CKhT1GznG8ZGxDxjhBrkgjzGGIU4gh3/yAPsSesyARh47D1DVzp1m+F6yJmGMwkMuKSboc7k9g01FUyvuooBheNpHZDFUwPRrPPssxUjJp3ZL6rcoLXyoe4uyjavW46E71mdEeAePiqr3uIAxTaMXlswNR+cLK2kd0P0BylQJXbUW3M36djcNMBRm3MxnZD81Wm1NIY9D/8A4i5TJKyZ+sUkW0h2JzElphvVhKVOPLQ6B7BaNOaDhcP4ed3BqlgRpZ2hdq9OTf6MlAGeVCDF9tOYWOpGuuCOc+Z25ehbCctLqaQm+PvLtuQiBjVhJ3wyYDTLsHoM1J1NcF1f9rsgHOIah+e3HHzQ2qP+5WSE4BAoVWsEB1k1Wan62nMWovOKzzdETooKYGIIHp0HnOvdtvuS326ARQ/RiXQ+mljMPi2
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:38:25.7970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f03c8bc9-1a9b-4e2a-1453-08df49458602
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MA3PEPF00000409.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR08MB197270
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

> eth_phy_of_to_plat() claims the PHY reset GPIO with
> gpio_request_by_name() and the PHY reset control with
> reset_get_by_index(), but nothing releases either when the device is
> removed. When retrying a wedged PHY, any follow-up probes fail because
> the reset GPIO is already claimed.
>
> Add a pre_remove hook that frees both.
>
> Signed-off-by: Graeme Smecher <gsmecher@t0.technology>
> Acked-by: Michal Simek <michal.simek@amd.com>
> ---
> This patch was 4/4 of the zynq_gem resource leak series up to v3. As
> Michal Simek requested, it is now sent separately so that it can go
> through the net tree; the zynq_gem patches continue as their own v4.
>
> Tested on QEMU (xilinx-zynq-a9, xilinx_zynq_virt), with a PHY that
> has reset-gpios and a (syscon-reset) resets property: after repeated
> unbind/bind of the ethernet controller, the eth-phy device probes
> again. Without this patch, the next probe fails because the reset GPIO
> is still claimed.
>
> Changes in v4:
> - Split out of the zynq_gem series; no code changes
> - Rebased onto current main
> - Add Acked-by from Michal Simek
> - Link to v3: https://lore.kernel.org/r/20261103-zynq-gem-remove-leak-v3-0-2f02ec0023f9@t0.technology
>
> Changes in v3:
> - Rebased onto the eth-phy reset control support; also release the
>   reset control with reset_free(). Use per-feature DM_GPIO/DM_RESET
>   guards, and reword the subject accordingly
> ---
>  drivers/net/eth-phy-uclass.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/1] net: eth-phy: release reset GPIO and reset control on device removal
      commit: af9898a75f1543525ddaa43bff1133878ebe1bd9

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
