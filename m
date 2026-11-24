Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E20606A322
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sWO+//9N;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=D+sAXCd/;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=D+sAXCd/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFA1F407AD;
	Tue, 24 Nov 2026 08:38:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kmxmKFTUtdWd; Tue, 24 Nov 2026 08:38:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E8D7C4079A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795509485;
	b=sC/Vo5QRFsgk2u1kgrOZrJT+hrastVPymbjcp8LrNXYT8aa/a2RZvFJPiT81/BTPQews
	 7jPZq1xQR5c2tbXTHP98wa21ROl8uRW5r3J693ahLWhJOuNxJuWZjLY7Qsn1Qj3f7FhgT
	 HO4yyHBWSAu//53ODILn+JFSEfiXlxpkZuTtzOysT0JbriBkEbUI9IspoMXSvBW7T+SZV
	 ymC4KDAwyry72jovXhil00O+FLHbF0woRrWvheVCDdhua6UV7ry1WZCy54950DpNYXFJq
	 tg9FSirS0E1/23OQc6s/3ww4P/x5Lpr5+7S4gLb9Z8NvL01G7epH1KAu1GlXQDXsdUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795509485;
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
	bh=Xow2wP8xClXW+UhB3IFnaYRUrS5S8b5Kaud4zcegF7g=;
	b=rlE84AeQQQWoY/tjddEHS0d+xzKy9M0LoK7gByKDuMaW1uNCtQDl76Ni+ho5O2mGoaxt
	 L0LCmVNDsxdsOSiCT0/14JS/7t1LkC57akY2Pw3PL8u7PEmwzKnANdlGzPCTZ16RUlX7P
	 tDLSu5hnz/O/a1MehPnOG5JSTVWzVQ39JI3TIFvA3FuVd24qEW5Wl8r/cnGcZapBxSxl3
	 ug+oK9CdYtQYf3l6Y0J+YJ7rd1TBEH2K4o8dbFjYnG6eD1W80v1kNG+kGe6NHhUiidyx1
	 mw+wO8IJUklsDU9tuYRY+LXo80v6OAUMVmVxn4bye66qVhBlLF7ktBEZSPt51/VY38w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b="D+sAXCd/";
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b="D+sAXCd/";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795509485;
	bh=Xow2wP8xClXW+UhB3IFnaYRUrS5S8b5Kaud4zcegF7g=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sWO+//9NHTI3zL5eQLEubsa7owEGFv/b51yT74cwjVstGahROOMHG+xjEve5v495w
	 o0D8V/HgNZ07WqxfKUdrbO6yCI5p/HSw5QVazMsM7iaFHATh+CDsqGQxyOASyVnaP1
	 F0dYq3zgH1B8BdPrJxbpxRozs4P11geNveRYDAUscjywf2Zj0iefnL1wJbuIcjY8y0
	 /mgSnGk9YfxVbbFqwpH7xUWNXRUZCXB/nUFEhTOTIujENykV1pTXITzJJIlD/OjmtX
	 U+kDQQoEPJZUnDfh0FIHLIr3ppFqrNRmSrkJgKOT5128IeYLWoAdmjh9TenuJvBiqY
	 13VZNpVdEJo4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8D7C4079A;
	Tue, 24 Nov 2026 08:38:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A3A403C4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:38:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 94F1F4079A
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:38:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id snfY96MxJz5O for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 08:38:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4A9924078D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=D+sAXCd/; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=D+sAXCd/
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A9924078D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xow2wP8xClXW+UhB3IFnaYRUrS5S8b5Kaud4zcegF7g=;
 b=D+sAXCd/PxwHVFfiMFZqXPOiurVlS9LDZ3fC15inajftDgxrzzPp3pm/TP8ZxeBmeCKZuBFTcHMcNKHg+mMsoSV/NLP8SmmiavGY8Dp27I+tKkPdbYIZN5w6kLDHAuXxEu8mOT0JBi2l4IxGsF1KKkb/7gBC524Sptr+TadsSCc=
Received: from DUZP191CA0008.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::20)
 by AS4PR08MB7687.eurprd08.prod.outlook.com (2603:10a6:20b:506::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 08:37:50 +0000
Received: from MAD0EPF000008B2.eurprd04.prod.outlook.com
 (2603:10a6:10:4f9:cafe::67) by DUZP191CA0008.outlook.office365.com
 (2603:10a6:10:4f9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 08:37:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008B2.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Tue, 24 Nov 2026 08:37:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xow2wP8xClXW+UhB3IFnaYRUrS5S8b5Kaud4zcegF7g=;
 b=D+sAXCd/PxwHVFfiMFZqXPOiurVlS9LDZ3fC15inajftDgxrzzPp3pm/TP8ZxeBmeCKZuBFTcHMcNKHg+mMsoSV/NLP8SmmiavGY8Dp27I+tKkPdbYIZN5w6kLDHAuXxEu8mOT0JBi2l4IxGsF1KKkb/7gBC524Sptr+TadsSCc=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by BESPR08MB999873.eurprd08.prod.outlook.com
 (2603:10a6:b10:146::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 08:37:14 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 08:37:14 +0000
Message-ID: <b538d8d9-c262-4c68-9647-f056b028ea5f@arm.com>
Date: Tue, 24 Nov 2026 09:37:07 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 0/3] net: lwip: add wake-on-LAN command support
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, Simon Glass
 <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Mingtian Li <limingtian@email.szu.edu.cn>, nd@arm.com
References: <20261109-submit-lwip-wol-v1-v1-0-d11961f7666f@gmail.com>
Content-Language: en-US
In-Reply-To: <20261109-submit-lwip-wol-v1-v1-0-d11961f7666f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0027.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::17) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|BESPR08MB999873:EE_|MAD0EPF000008B2:EE_|AS4PR08MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f7a3ac-ed0c-483a-deff-08df4a063928
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|261102123227099003|261028144727099003|261102130727099003|261009223027099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003|261022115727099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: IuaooNk8JopGhSknkYyZFi4MyVK15z4hSJmnhUtrVhl3KT6Sjk1d7pOpYU0pSENUNFWgY2niVZ1UZ4DMea1J0YxeAyKP8egY8zEskWAFc37YxeyKWeJAEp7jzrPhYlx6jTkGmQeGfhanE4PON/Z3hl/mw2casCBsvkNWNpZpfRiNwbeK6n5tcluuInoBADuzjw5oW9t1gxVvjf3jupz1+899sN+pR8XaKf+zyGxdvLOD9JpXv2Ltf8ernF+YfxN8pra6Ab5UgX+kv1aHs7nOfmXHPouBw0/yLzehNyokF51kpuS0MeWGQirZ+Gu7zE94UFSGmLajnXAR4+RpV9AfiOBrnTzJVD0T9w6jTdZZZQ4ulneoY6j5urIUDX2OgnO9QR75D3SCYPWvBOFiKhe/wrV0O+v5rAOY/PXBfkL2MgpQAok2DDOWygIsDaMNrJqzCixiJsE254VBhNj7KzxCZ4/kJdZCAgUEJlW40ew679jHqUn92zbHBqazpEhzMAen8DsTDbq1wv5lcUF70gYE+9CZ7hIHMUK/pWJfPuGVNnvN2zJPay7DDAcu4BOs2MMm9f7zcOL9mCB1B5o4Fu3/tYKfBYxd3w09d5wATKrgcoekQZJE5Jmf3qHPN0+vSPat
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261102130727099003)(261009223027099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003)(261022115727099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: mS6F7rZFvUsvFDnRH8Q35zjfGwHpDo6jzc3/lNx1ii5cD9omnytcXNPQdilkxi6JGZSPPmNCKoo48Lyr9ho82mt/9kZP+pD9sT/QxdUq2KJM/YQldkn4qVtVXyo8hP8BpHcrVWNlWfv+i94Vacef4D0qhkayOJfA9mceOoS2sMCGsUPPwfgLrDm6vjItUZ6PxSRboQPqG7wyCoqWg0ebiOHFm+UJ7Z0fTCeJx6orPB0I8hqsMozfvuVeoutBJt8u/p43Boopse2r3qk0N4wh6x5yJLnB8UWJxNCUjW+sGXe3yB1yLGZyAlhxAY/35gfxyy7KnSSr3fRym0oI/ggaqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR08MB999873
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008B2.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a9cdd662-aa6e-4531-79b8-08df4a062411
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|14060799003|1800799024|376014|35042699022|7416014|22082099003|18002099003|11063799006|56012099006|261009223027099003|261021123027099003|261022105027099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261021121427099003|261022115727099003|261102130727099003|10067099003;
X-Microsoft-Antispam-Message-Info: lHqLHK2ed4mr3qUvAcXH7XUsqM2gKZA3PQVbLKi9PAjLvbiRcsz13B4tPDxfWm3E6stkhaOAgwSqIzcR3XxLNIVH/K1AkA0xEAdKDPmjvf+BEX204ebgJmn4hlG7oQV4NGFXzh9gP3ncKypXiWEhHfz/73jb8VUbGgf0804vxPLyzYIa0D+isIMfNuDwItdI8OTXOgjauTuuiXRpX7/2A743TD9NST9TaKIaindW/UXVbpVc/wwbwtZr2ATupyuUCg1YdvhjsWyvv1WbnggxdY1n/N5HDB1H2iBNVtSeF9wQhfi9R/o3qZylv2RVc146tl3fGMyhIxn6fgz+7fK+Ngvbg3dUQlMauQD0iI1BaHal6qTwpg+eyh1T19Z160OiL8OkEIJBONxtub4QNFcpI4c2NpGhv10qemQVPylGYhewyl4juIWzZK6JrJe7I2wePrAxwGzdgy+62+2fNUazaDLO45UednkYVOdEjsT5nxkLzRA3Buz9jXBWRiBftmaPOl+UGJYmM/6c9BAehwPFGMWjUYxINyKMvvQi32dNCe8lgfK+jkF1z5dToPGqLA78SYnkwPPbja7m2hrgJlw3Gczq6ujhaqQv12eEW8B+nHj4PFsX7RutnFr6d1gRLwI60CnhI5C/l0uyOyK42n+9Mb63arNZ2S4BNDvYfez9mBc=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(14060799003)(1800799024)(376014)(35042699022)(7416014)(22082099003)(18002099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261022105027099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022115727099003)(261102130727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hxRCumuHT7elnAvfW92of1kUsjTLy2BqFOIiYSxXvd5Olc6RFq0hz6hQ+nqpW2gUAbiJbDe/JbQhR1F9SgO8TBCZWXhBCkSBz+toXgmAHpwMwzEHt8uuikpsxD8Py5uh8cXfa4hrlT5Wn7xd+LONchoPCpSGk1fg7Je+S3ogH5rHlqsKUnqTVfIik+GzqsT6NuAYB+s5shZICZAWdDn2dd0OjN+UAe0Izj0UtW6mZlc4WCr2yQwh16msu6FVYrXIsiqfyDOjQ6RCz0YAOIJMsC0GDNlk+YoM+pv6O8ZBT7vvKeXrGWrGXtOVDeLpy7QpJaoLDKPh3tkjFSPIPJPHwn+ISBXZwCWhNlE/fb6gW3XhjT/L27GQonDzovtaV9xkI2pjKism4YP5elZav/jNP2+IwxaPc9HbrrHqES39TA06bWZ2IUlfFw8ke/7+ZOwS
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 08:37:49.7538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f7a3ac-ed0c-483a-deff-08df4a063928
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7687
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

> Make the existing wol command available with lwIP. It waits for an
> Ethernet magic packet or an unfragmented IPv4 UDP magic packet on port
> 0, 7 or 9, including when the interface has no configured IP address.
>
> Share magic-packet validation and Ethernet password export with the
> legacy stack. The lwIP listener uses the shared network runtime and
> leaves other clients active when the wait completes or is cancelled.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> James Hilliard (3):
>       net: wol: share magic-packet validation between network stacks
>       net: lwip: support the wol command
>       test: net: exercise lwIP wake-on-LAN reception
>
>  cmd/Kconfig                |  11 +-
>  cmd/wol.c                  |  20 +--
>  {net => include/net}/wol.h |  27 ++--
>  net/Makefile               |   1 +
>  net/lwip/Makefile          |   1 +
>  net/lwip/net-lwip.c        |   4 +
>  net/lwip/wol.c             | 129 +++++++++++++++++++
>  net/net.c                  |   2 +-
>  net/wol-common.c           |  46 +++++++
>  net/wol.c                  |  51 ++------
>  test/dm/Makefile           |   4 +
>  test/dm/lwip_wol.c         | 301 +++++++++++++++++++++++++++++++++++++++++++++
>  test/dm/wol.c              |  91 ++++++++++++++
>  13 files changed, 618 insertions(+), 70 deletions(-)
> ---
> base-commit: 1ed1749575f28b406c241218eb6a200574574a25
> change-id: 20260928-submit-lwip-wol-v1-2deb541b7456
>
> Best regards,
> --  
> James Hilliard <james.hilliard1@gmail.com>

Applied to u-boot-net branch for-next [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-next

[1/3] net: wol: share magic-packet validation between network stacks
      commit: 35e6dac3cc546fb27aa8d29c6454a815636e49ae

[2/3] net: lwip: support the wol command
      commit: b9189ba6ea9cb320b4c60bf8f16b7a3e059c9a26

[3/3] test: net: exercise lwIP wake-on-LAN reception
      commit: ae80d30f747f03c04210428052371fbfacafc8ce

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
