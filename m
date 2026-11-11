Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008D3606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=icj2pEfG;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=c9FfqA/I
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C2CA811D7;
	Wed, 11 Nov 2026 17:16:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hh1YQ4SwCdfO; Wed, 11 Nov 2026 17:16:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E2C9E8121B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794417413;
	b=asK9IdxAnA87oLS0sCmxZOgVxBb6GKkAdVts8sM9Dcb/nBMnfqv/0idyj1sx6I1Tqpuv
	 GzMfl3X1HbO091XwU9zY34LJOlF7AEN/Xxi6YYRwaHoT+5M73hM7dEIlJqDALjPjTEL/7
	 1MHkCDHziXTlWo9MMzPtpBQF8gNH8moMGJ7wpZMYpCF/t77f7Nxp7oQIfPsbPiC/uzj4E
	 OEJ55RzY1hPRiK+KWvyGGM4KT/F2/zKIuDm5zKpe5NOc3UCPMgormxgQaPoPgOvVEsYr7
	 QDsz1IB9VNbkxFouKUsjUmER1ZqM49BmOsnaDepwKEutjBCEo+TNbRQwz19JTG12K0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794417413;
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
	bh=aMACuidpXnxSXaG4Y9gT+/CbubiEYMJ4RE4SteHo9U4=;
	b=NmrCHOqbiu/Ix5cBkNmQ2KksxB6PzGc59M51jJHJ2kCWAWnMIb8R2WMBPwneMY4FmzwZ
	 7Os4LZpOQYGoIQVsE6fAeih3hJfRcJXiyx3zmCDrR1ljrJtcEwi8mpDL6+dUj/c+AmbVU
	 bL1ts8bCqHXXVvvFVKPq141+JdLCMs3qtse5rAz7/DGqxhkYDU63erELtoS91cy1+2qj8
	 zOcQKW4/RHz2Lu9JX6hoKQ6sBgfgfgNutytryOinHVvRzXY+yY1k3XRCwbsq7veRBi6aY
	 pU00oaM0XCXq3x2LMNtVu9emkJmmzIdffRRqQdJOuJDLXP0G1bCd/MR8p08CV7hiofw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794417413;
	bh=aMACuidpXnxSXaG4Y9gT+/CbubiEYMJ4RE4SteHo9U4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=icj2pEfGojIo24mLT95dDXpXgKsTc1+m7kF4bGnMbhrIa4wQiH6c2UNjVL3G00AaI
	 gVlEyThlow6U9Rejqs5o6Z+J/hKyRkcDyZYe7jVnzVsy1BwNwNJM3O3JezuSttEO9u
	 8hL0Iu6526WvJGtxvMIrj3tEJ42SA5fpNRT9/1YKu2UPlmBI+Zlbd7dkJV1VhauTFY
	 iKllMyBdXtsNa1f6DwYS0KTI/4W9tPVH3wL09hPtVO8A3NEKk9iJGo16WcY11kAqF2
	 dfiqNSbThff1GmTd2eKMe+/25yKwSvSTHC5W69KK3PZneFYngu2T0QPEF3WlUzfoZt
	 Kd3+hQxHiP51g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2C9E8121B;
	Wed, 11 Nov 2026 17:16:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CB16431F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 17:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BCEB460779
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 17:16:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hhCwiwG4Gt-9 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 17:16:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AEB6F606DE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=c9FfqA/I
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AEB6F606DE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 17:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMACuidpXnxSXaG4Y9gT+/CbubiEYMJ4RE4SteHo9U4=;
 b=c9FfqA/I6ZcKvjXNLWczFbpAgdmaHXfbzVovA96lGZHyL2/cVk/MBDvAHgXTRJNR1RPibbwYfTwIkVcdubqKqQrjz6MrFhtyvJhpB/j3Uv4dKzYESCuFAZ3QCpfB6SbUNIeTZbXOzV2Yq4BziY5v6BpPlLMSwtjHZICksHM2j/8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA3PR04MB11155.eurprd04.prod.outlook.com (2603:10a6:102:4aa::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 17:16:42 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 17:16:42 +0000
Message-ID: <83adafeb-674b-4e2f-96c9-b8eb7694dc0a@cherry.de>
Date: Wed, 11 Nov 2026 18:16:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Add support for OpenSSL Provider API
To: Eddie Kovsky <ekovsky@redhat.com>
Cc: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Johannes Schneider <johannes.schneider@leica-geosystems.com>,
 u-boot@lists.u-boot-project.org, Bastian <bst@pengutronix.de>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Jaipaul Cheernam <jaipaul.cheernam@est.tech>
References: <20261029201348.730274-1-ekovsky@redhat.com>
 <f7b2f1f2-e8c6-47c1-8e47-795f6ade7618@cherry.de>
 <auy1K4oe9E2Fr9xu@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <auy1K4oe9E2Fr9xu@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0143.eurprd07.prod.outlook.com
 (2603:10a6:802:16::30) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA3PR04MB11155:EE_
X-MS-Office365-Filtering-Correlation-Id: b9dc4275-0d22-4f0d-c615-08df40178e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|261026121527099003|11063799006|10067099003|4143699003|261026140227099003|56012099006|261021130227099003|261021121427099003|261021123027099003|261022113327099003|261009223027099003|261102123227099003|261102130727099003|261022105027099003|261022115727099003|261028144727099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: /xmQ+YvEa7p2es4ss10HiGhZgIVqpclTZxhTEzxHSnXXwpeMInJoBVDGAsFsgU+2gc2jppdthRgxZsz3OwicEWvsatTjW2Si+KwNip81GdW0qD4+oDzesYZpN5g8qB/lVsF5x3BRtccGVgmPMZB0mWqaJk41dR+iuAppmaLTbIZLj+i7QDOJ/BGXi8CgLeFEnfg+WugOUTwfia4cbONYlPguJBBHN/zFfq3Y0I1shjZcQnibhNddpPQydb9griYZfq0snscEaQ5CY/4cT+Quids2GebrfuD+QqVEBnkMH4/rBOaFJsTbUUIeVxPS6QNHg5sNyfVL9DL7zy0PPi64Pf6IK7p6LZsXRycQ8AhTdIZxeSmMzsrcMYLg/DYvL6Is+gpxSsVlIpzwGmnn1Tn9N8JrmjFnYW00tuQJI6BctYkm+6zAv+R+WjoKcM/ROZXNRT7qaihlrplRjEf091s39OtSuUB9gW+kVBlnRWK7xgz2n4G1J08nCbsKjDVIBwAuOZUVpD2srk/BCJzWk3DkTHedDCX+yyfDUC3loNO9F38h2ggidXEgd1NShwoZgIi5ROUA38GO/JpFp8UxerNhsuXuu9SFEffe7ny8jANf/U8QheIMFGKLL+1qeD4sQjeX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(261026121527099003)(11063799006)(10067099003)(4143699003)(261026140227099003)(56012099006)(261021130227099003)(261021121427099003)(261021123027099003)(261022113327099003)(261009223027099003)(261102123227099003)(261102130727099003)(261022105027099003)(261022115727099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU1QUXF0OGVGOCsyNDVJcHY2Ykx5TDRzUEZPdkpRejhvUkZ4N21QN015TFpE?=
 =?utf-8?B?bUVvNGhRVGJmZWNkNkpuQUo4UDRNUndNdHFjRFNVbncwMzJ6V25XTXlMVmdt?=
 =?utf-8?B?cXBvVHJOb1F6MEtVdjEzL1FSVmhVUkJ0akY3eDdUYjkySW9NMjlTbjBPVWhT?=
 =?utf-8?B?QndxU3FLU0ZzYnozWHhzNXR1YmdwSWJlekxmMURNY3JkS0N3RERVbDlnNGFx?=
 =?utf-8?B?S0FyUDNyYWRNekpUWGxZV21MYzFBZitVZ2Z4bzNqajRhZVBJK0FNN2FEekdi?=
 =?utf-8?B?OURTaTc0T3VITzZ1QVQrbTJaNExLZDQ5UFVaYi9YSGZVUjhETDdaMW9DZVhH?=
 =?utf-8?B?eXk4REhNMkswVVVPRmtaZG1JZCtGaTlOSkFXSWRBek1Qa09wMWxONndWSGtC?=
 =?utf-8?B?M3REK3JONHl6YnlDbHc1cVFDQjkyUkhUbW1xbmZGZVJlVTBFbVdkaVV6SUN4?=
 =?utf-8?B?UnpNQXpGQnJkUHp5ZDFQUzhYZmJUL1d3TmdUeVNPZC9KNHBpU1M0eWJTWTli?=
 =?utf-8?B?LzdrL213TTk1RndQb1pnK2JyQlV0UEpPMEdJWDk2dWc0TStibmprOG9LMkxM?=
 =?utf-8?B?NkhDMnFUSFZVTFNEVmVzUS9XMGhMc25udG5mSUd4RUFucSt5ZUdZZFdNSXZL?=
 =?utf-8?B?dXVURzJ5K0ZCS1BaMkpMNnhqSERxZnhIZ2lNVEQ1TDNMV0o1OFJSbWY2akZP?=
 =?utf-8?B?T0xVb1dDSzMwNzNGK0hjbGxrdnlGbTBrMmpQZDNkRk16TVVVSXpMb2lSZE9O?=
 =?utf-8?B?V3NqZDFkbUJvUm5SSDhLa25RM0FOaVVudzFWT3dpMWUveTZsb1dyTDRWRWI1?=
 =?utf-8?B?S1Bpc200MEIxdmk4NFY0eW9oMTA3ZDQ0WlZLcVJvL0ZzQUJjbUptdUNidVRn?=
 =?utf-8?B?d2l5Y1d3enFBWUlFRU5mSlpBRGk4RzUyT1REK1BVY0NuSGdsd2ZSSVBnMDFt?=
 =?utf-8?B?VlovSTlUenI1MkJWaEpjVG1NWkFVZG9FUFpVQVAyM1BOdDZMNHUzWHlIOEZQ?=
 =?utf-8?B?bXpLL0ZJV2RiVEJEcFkwT3lxOHN6THdmd1dzTS95Q29VVHc0cHdPc3JZWStq?=
 =?utf-8?B?N20xRitkYk1VTEhKTGhHckhBd3VIUFM5REp5VXltbUtEcVdITG1COGZPVFND?=
 =?utf-8?B?R3JBTVhHZkE0UnErSUdLZ0hneURZN2hpMjZZdnFxWkFYSjFIZmtOU3VBSFJq?=
 =?utf-8?B?eU9oclIwMnVmQ3J6NFVlenQ1dnBEdzdlbEx1dFNPRllhajg3alFGdDhBVzNP?=
 =?utf-8?B?dDR4YVB4QjR1WXhVNWFFQ1d4YmFqRGIrTUh4emdwSVZQcGpCQnYzV3dXcFl1?=
 =?utf-8?B?K3FVSWFQbGZUTFA0OHBqQkhlWUVXOUhhbVJCOHRicGRqRk9pWGU2U1hZU2lG?=
 =?utf-8?B?MytaSHptdWVxTzdNVTVEcGFyNzkwZ1IzdkV4U3A2VHoySUlBUU5kL2lHZEVC?=
 =?utf-8?B?eGViY0NiTUthK0h1WC93VDUrM2x5Z2E2NWh5MXc0NW5Yb2xIY1FlcjI0Y3hI?=
 =?utf-8?B?VUNMaXZvZ1FzY2FKeU1hSWdzdjlNNEdkSlJiS3R3MGJBWWs4TFpIU0ZLOUpC?=
 =?utf-8?B?OGNNTWVlUzJsblNyUWRDZXZtV1ZoYmFrZGF5czE4WVJvRndJaGVGc3hFVEl3?=
 =?utf-8?B?cSs1eVFOMmZLZmg5WUR3L2Zjd1cweEM4Z2srbWpxZ0FYd2JjSHNrYjFwN1A0?=
 =?utf-8?B?NEhSV3l4anBURTNpZlpXdUZ5c09uN2FvUlFoc25BUC91Y2E4TDNFZ2RIMURR?=
 =?utf-8?B?dy8yZ1BCYTFXR1BvMDEydjhDVE45L2RXTTlDcG5UcjJJdDBRMlJ1YkZCZmJW?=
 =?utf-8?B?RXFuclhKUXRGZXRGaHNraER5SFZtYVFMdEZDdmFtaUVrMFN5QjYvTzNoZkg4?=
 =?utf-8?B?N1FTNlIvVUk1MjdzQ25aakM4bks3S0hhZHd4ZSt4ajhEWXU0R2tYdFRlNEZx?=
 =?utf-8?B?bzRhM00vTlFnbkVmWVMvVG0zTml6Q0l0TmlXY2xjSkhkNm9JQ1hOQVBCLzB6?=
 =?utf-8?B?Wks1czhoWWFUNUh5SXByTFZmK0J6aFA4eUFnaVF6STg3TGlBWVFvRjVnYkt3?=
 =?utf-8?B?OGNzOWJ4UGhDL3VqOGZUcnVvNXNoWFdxUnhaUlpoZlBJbFdKV3RuVlpyZ0RT?=
 =?utf-8?B?WWJJdFFVSTMxdXJINjJTYlFBb2tkN2wrK0xjelpDNzJHYVRZRzZhblZaeE9F?=
 =?utf-8?B?eWxnbmRBQ1A5Z2V5b1pWbjM2SnI1QWl3aG9iZkh1ejd2UHErNG91MEVZS0hh?=
 =?utf-8?B?L2dLaE1tN3dUMTZFcXIyV0dJY0JhWEpGU05ZRHpkaVBlR2JwZkdhREdrbVV3?=
 =?utf-8?B?UnFvZzRvbWpwUHdVeHV5MjJCMzNtRHQ1TzlJMFdJcGpGOS91dGpzUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b9dc4275-0d22-4f0d-c615-08df40178e1b
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:16:42.4327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sT+PuLtx5YhizOpqTJ/csZq7Ec1AkeSklx6ofXnPBuiVygKyIf5nxR11vSNypJMP/mpqvF0N0JzA16yE4Z7v2p1yJccTD44CWK/rAMvfRHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11155
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Eddie,

On 11/5/26 5:56 PM, Eddie Kovsky wrote:
> On 10/30/26, Quentin Schulz wrote:
>> Hi Eddie,
>>
>> On 10/29/26 9:13 PM, Eddie Kovsky wrote:
>>> The Engine API has been deprecated since the release of OpenSSL 3.0. End
>>> users have been advised to migrate to the new Provider interface.
>>> Several distributions have already removed support for engines, which is
>>> preventing U-Boot from being compiled in those environments.
>>>
>>> This series adds support for the OpenSSL Provider API while continuing
>>> to support the existing Engine API on distros shipping older releases of
>>> OpenSSL. Build dependencies for local development and CI are also
>>> updated, while the final patch adds support for using hardware tokens
>>> with the Provider API.
>>>
>>> The changes have been tested with the FIT signature verification vboot
>>> tests on Fedora 44, Debian 13, and RHEL 8 with OpenSSL 1.1.1. All 37
>>> tests pass with both the legacy Engine library installed and with the
>>> Provider API.
>>>
>>
>> I'm NACKing this series quickly because we are having pressure from multiple
>> projects and Tom would like to see this fixed ASAP, and this version here
>> should not be merged. From a cursory look a lot of feedback was ignored,
>> possibly because I did too many rounds of reviews and it got difficult to
>> follow. I'll therefore spend time next week to collect the reviews I made on
>> v4 and that sill apply and post them condensed on this thread.
>>
>> Please, we just need to fix the build issue for 2027.01. We don't need
>> providers in 2027.01, just the ability to build on OpenSSL 4 and on distros
>> with OpenSSL3 with engines disabled, without breaking OpenSSL engine support
>> for other cases. If you get a patch to fix this, please send it whenever you
>> can, I'll still collect the reviews from v4 and post it here. If you're not
>> interested in doing that, lemme know and I'll take over this part and you
>> can always test the patch(es) if you want to.
>>
>> Cheers,
>> Quentin
>>
> 
> Hi Quentin
> 
> I designed this change from the very beginning to maintain the existing
> code base and preserve backward compatibility for users of older OpenSSL
> releases who are still using the Engine API. We cannot add support for
> OpenSSL 3 or later without moving to the Provider API because of the way
> the OpenSSL project has changed their interface.
> 

That's not true, as already said in v4[1]. We currently support OpenSSL 
3 and engines, and we actually test this in CI. You can test locally by 
running the following commands from your U-Boot git repo:

podman run -it --rm --security-opt label=disable 
--userns=keep-id:uid=1001,gid=1001 -w $PWD -v $PWD:$PWD 
docker.io/trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026
python3 -m venv /tmp/venv;
. /tmp/venv/bin/activate;
pip install -r test/py/requirements.txt -r tools/binman/requirements.txt 
-r tools/buildman/requirements.txt -r 
tools/u_boot_pylib/requirements.txt -r 
scripts/dtc/pylibfdt/requirements.txt;
export UBOOT_TRAVIS_BUILD_DIR=/tmp/tools-only;
export PYTHONPATH="${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibfdt";
export PATH="${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}";
./tools/buildman/buildman -T0 -o ${UBOOT_TRAVIS_BUILD_DIR} -w --board 
tools-only;
export TOOLPATH="--toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools --toolpath 
/opt/coreboot";
./tools/binman/binman ${TOOLPATH} tool -f missing;
for test in testFitSignEngineSimple testFitSignPKCS11Simple 
testFitSignPKCS11Object; do ./tools/binman/binman ${TOOLPATH} test 
$test; done

You'll see all engine tests pass.

Additionally, from my branch at 
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commits/openssl-providers, 
I have tests for both OpenSSL engines and providers *at the same time*. 
Here[2] is the log where you can see none of the OpenSSL engine tests 
are skipped and only the PKCS11 provider tests are skipped. They are 
skipped because we don't have the proper package installed inside the 
container but I tested this locally months ago and they pass if the 
package is installed. If either the engines or providers weren't 
supported, you would get a skip with a given reason, see [3][4]. [5] 
shows that you can build both engine and provider support in 
lib/rsa/rsa-sign.c.

If what you said was true, we would have had a build issue when every 
distro moved to OpenSSL 3 when it was first released 5 years ago, which 
didn't happen.

[1] 
https://lore.kernel.org/u-boot/8d7ff3b6-abb9-4441-8491-99c538ea5f2d@cherry.de/
[2] 
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/jobs/79119/raw
[3] 
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/blob/openssl-providers/tools/binman/ftest.py#L8339
[4] 
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/blob/openssl-providers/tools/binman/ftest.py#L8719
[5] 
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/blob/openssl-providers/lib/rsa/rsa-sign.c#L22-L33

> Both I and other reviewers have tested the proposed changes on different
> distributions using different OpenSSL releases. The build failure is
> resolved on OpenSSL >= 3, while building with the Engine API still works
> as expected. (The only obstacle we found was that signing with a

Run the list of commands above with your patch series applied and you'll 
see it doesn't work.

> hardware token key using Providers didn't work, partly because the
> existing code doesn't make the pkcs11 uri parsing available on all
> paths. But Johannes already proposed a solution that resolves that
> issue.)
> 

I'll discuss the provider part later on, I would like us to focus on the 
OpenSSL engine build failure for distros where OpenSSL doesn't support 
it anymore (Fedora 44 without the ability to compile code using engines 
anymore unless openssl-devel-engine is installed, and every distro with 
OpenSSL 4) while still keeping OpenSSL engine support working when it is 
possible to support it (all other cases, including Fedora 44 with 
openssl-devel-engine installed).

> What are your specific concerns about the code in this version of the
> patch series?
> 

See review on patch 1 (posted a few minutes after you sent this mail 
here, unfortunate timing). But essentially, this breaks OpenSSL engine 
support on OpenSSL 3, which is something that is supported by OpenSSL 
and which we want to keep supporting.

Cheers,
Quentin
