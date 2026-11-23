Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29D5606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jEWzHtFu;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qnCZs2sW;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qnCZs2sW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8270F40583;
	Mon, 23 Nov 2026 09:24:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NmkCibTBV6F4; Mon, 23 Nov 2026 09:24:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 985F940567
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795425891;
	b=JG1TvYL3DMhlJ3Ti48v/r63aB8D15E87hEitIpXulFGthSDzBe70jkXpVuuktiuH0rps
	 V9yrXtPOVCgsA17/lAenrgQcGLLRgEwsXzDXxj1aGoaQ+8JOINVbAOlG9K91gyMKWf99a
	 XVlo82u7+lQ/P6qulJWCReShTF+axmsmuLsTUgaxhBdSSOFHYVYMcBtFPvUfkl9WBTqSU
	 NMleuRyMV99B604qvVRHST5TWYgtmHuLUzvXjWZcTq+qZEpAjIOBvgkaZ7c45P2jxnhl4
	 QOqGDQweLPwDUIk2Fk8vM2x+troSx/fquF5XYd5pXQG0338X7vegn5xcnmXrz+g9FyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795425891;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
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
	bh=lKiReemyUZ7FXYdkEj6pFDZVUAYeMtVOC3MSwDg78o8=;
	b=dWijdBXY+csAXurpb3jDd3M5vQ641lMeE3enGKOp35+ksz205uYSzHCY0Ym00hMyRNwa
	 JZB2h+ela48oDwT0Ackt3+uTvjgrRI/cmYPiBqublMr3+30wYKWgEuIT3i81BYg4NI32P
	 uUryIkSn65O+pEw0kPkHU85AbvmULuYNQwG/N0FTME7xBF0yUrnXs0DhEp0DNA16UVxVe
	 LGhTa9cdqJdlnYVoQjYmeSVPPW1cDaE1/RXvHS1mhhplZzhTxSUfylpQXK1tavg1T0sW9
	 cch9LSRp73HgTbakFhihyvvIEsJroFY0wwmWb+gl3xPIg+pUEK7oe0w4+WItfClGvXw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795425891;
	bh=lKiReemyUZ7FXYdkEj6pFDZVUAYeMtVOC3MSwDg78o8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jEWzHtFus0VUcIl5Hw+fPbmDKs8/Av3N0AVJ27XfJQjmm4m5DuPzjBYmmBXuLVoag
	 d1f5rib976UyCE97IUC/32QpldSl5j7/Mhj4RpMtIxhi/vMDZ3RTvBb1zCDSjeWtS2
	 JjkAFuWmNQ1ZWmKs19cYpr6iA07smIfCQ0CAT8l8g7j1lPSzwwvx3PlBrtS3BVOZYm
	 LSXNrO7XUudSKFKinWtcf8KmeQvl+GkktWQQcvizqKINnQUFc8LmQDPAvShePsy5u+
	 ekvXmVfZXE4N7vk3cRWxNU7FO+Wd7u5SqDKa928TBSzJ16D20LQsaO/RYfyWM6RjFl
	 2phF1UJvFlJEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 985F940567;
	Mon, 23 Nov 2026 09:24:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E4B23499
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:24:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA769605F0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:24:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ThJeGgKGbcdM for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 09:24:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E6E2A605D3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=qnCZs2sW; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=qnCZs2sW
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E6E2A605D3
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKiReemyUZ7FXYdkEj6pFDZVUAYeMtVOC3MSwDg78o8=;
 b=qnCZs2sWCdO6Egn60B4uQj8w89cBNTqXh+4XJpCy9xghx+uzPWgd8GMakyVLa7XqsyIBomszCI2JAt4NwjpU8y2YaZleAoQB/9+6Kxv0fd4epkBvlpFU2cDNE9m5N+VNB9X1nQn1Tsmp/xCoBrDvun6N6/cgkvb3pB2n/RrlHP0=
Received: from VIVP296CA0085.AUTP296.PROD.OUTLOOK.COM (2603:10a6:800:35b::14)
 by DB9PR08MB9585.eurprd08.prod.outlook.com (2603:10a6:10:456::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 09:24:37 +0000
Received: from MI3PEPF00008484.eurprd02.prod.outlook.com
 (2603:10a6:800:35b:cafe::9) by VIVP296CA0085.outlook.office365.com
 (2603:10a6:800:35b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 09:24:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008484.mail.protection.outlook.com (10.167.240.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Mon, 23 Nov 2026 09:24:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKiReemyUZ7FXYdkEj6pFDZVUAYeMtVOC3MSwDg78o8=;
 b=qnCZs2sWCdO6Egn60B4uQj8w89cBNTqXh+4XJpCy9xghx+uzPWgd8GMakyVLa7XqsyIBomszCI2JAt4NwjpU8y2YaZleAoQB/9+6Kxv0fd4epkBvlpFU2cDNE9m5N+VNB9X1nQn1Tsmp/xCoBrDvun6N6/cgkvb3pB2n/RrlHP0=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by MA9PR08MB818843.eurprd08.prod.outlook.com
 (2603:10a6:250:10b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 09:24:03 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 09:24:03 +0000
Message-ID: <0c9029f5-0d2f-45a3-9634-f882bc74582c@arm.com>
Date: Mon, 23 Nov 2026 10:24:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: shell: reject out-of-range connection IDs
To: George Kola <georgekola@google.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <CAOTQ16+bNoyuFm9kF97-Z3-vpbj77qUGfSZvDxkAXbnhKP2FDg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <CAOTQ16+bNoyuFm9kF97-Z3-vpbj77qUGfSZvDxkAXbnhKP2FDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PR1P264CA0183.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:344::10) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|MA9PR08MB818843:EE_|MI3PEPF00008484:EE_|DB9PR08MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: e79b2b31-17c5-4e46-e319-08df494397af
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|11063799006|56012099006|10067099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: tQIo4iqff3Qp0e7il+p5xeRTjfxe6S7na9vU+lms3Yw6gIA6Z2Jy3OZdW93wso/dYc/qxk6N3WI+T/6Zxl29NCffRLXCbbHuWpzvI+UcKMOjal7bkEmIn2OkxwGS3Txrj0e0oejfToYkMKWXtjDpwFa7O2GZbWdHfYDAVowiwOvOL+wCHVSX83NPm9+EitNfuWw3InNb4Vl/OXb/2ZwkSfOrrNVCQ5YlcczV/YvQKssDGxsJTRrhI5iDvVQLALEbCqqnrz7GtBQEpuxWzHusj65Z0LKWwRjkutyWNa/RDZh1IEEkJOnj6bkvQxwbVy4DPIrGH9sZ9lHfYXspveV1LqfYXB4lBCjruhpX9xdHARZWB0rp7N+rBsZZ3d+gpHBnu2kCeIylMgwYAarRVo56Sp2TXBP8vdyGh01zSsv9A695zefM3L+CvX9bih7h7Pe6K5EwlRcysAsA3hPTgjBtKLm9QFCPMTUijjmXX60YmnX0hwDdA7upI2FbaNB9oT/U58xdWKiNQzmultzqe7OxfTfVEAi01ScMk+G2YRt3gZD2OUZrIR9TvNh3uSulxasGGhTSDr+Gwry7fAGONNCctYWZ/55SoVFeIU6yj4qpU3JJdhY/AHiVJR4Wgkr4lIGAwCs1QlqgLO0dhxFpg0Fdlgk1Mq0owYvsqjYBricx0B8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: TChTi3q2ZAVS8y/bjxbVkObl3DF3shDfM+2dpvtGZ2nA1pd19RQjUkoR0UQYVb9Wi4xgg3jU5LTtC1g4rNGODZ2+3NMHFCho6FTlZJpX1zTsHu3K7Tngi9a2XfHOGOKotT04g6dDINGxjfqGPUVMhpQ0VOFWcLYw00Ah0VcP6Euuw8hckZ1KiFiqSuhf1LmmfgR1EMhgliKXYxYPuduJENUQucsEMliCrjviXgNsknXMEGiRmW3UHKpzeip0zJdMKFBgzQBtPnLqJAjf67p9cv5q62zgN+03I/4pnsTcLwCSLn5hoFqJ6ZRYivJ3x+JOHbaafPm87nZ/2iDB5uocKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB818843
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008484.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7d446093-4556-47cc-ed73-08df494383a2
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|14060799003|376014|35042699022|22082099003|18002099003|6133799003|3023799007|56012099006|11063799006|261102123227099003|261028144727099003|261022105027099003|261026140227099003|261021123027099003|261021121427099003|261026121527099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: J5KrKx4l0p5b31hA7xIimEBI+hBICixu8skXUtss6/EMLvivPz6V5g2w4CLokuBYomR8E8tF3eHwE3AINVT42bo6qO37MLQi5DnHIX2coOK6vtWJ8y9Q48KYZAr3bvZ1U553mOlNtEzkxnIaXtNHKeCWkkbgRSpKvlq8CRop4HBLYwEqd/9/V/KPVtJblhPSdvmY+i5S7TnIS1Tr2it2XIRVFgBSkeGgKD/lU9wN/yW+W/u8tg8batRcVkABwHcxc9O0Q59P9cS2Wy68OhwL6D3FfOL3bomjIrS2/t0d2ZBJF+TrrVjEMRg+mX0/gxzegkEElFWH97md3dn9v9FtsA+I6DeCI5R+L1Zr7hR7B86na/XsXwFUMmlvycLXpCF2YgCIXfU7CbBZEkY33uLOkYL9N9coEvb+Bsyo4bdGe3DTOo8BP8tTyrF+12arG/NKaKUX8AQib6IADHmv4SXUeuDeawm6ccUooUqRrHoO8fbvDBDqptYuDztFTRWskmVh3FV2Dqd3r+vCNNSyITf0jkCHO1wYn31EdI6XOJaXKWyFhI/Cy7DRV6/lTjEOBY8WNlILBbF3SWAPNqdL+LrgYPXDG8zG+s7npr9b/npCacyO7SwLRx6zBlzHeTl519bJ5OsDHzbBR3OevKyL050OQ7rvhA+jHlMTaoDRgf2M6fp/JhFaRh+HeTomsI7qqv6zBCH/W1lXqf6C2xIdhhJiyA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(14060799003)(376014)(35042699022)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261022105027099003)(261026140227099003)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JeZq2Oy9dncTo/rFpmfJB/eNQ4lztCU7lt7tOwuPfu4yyvdUINwVWvtoHeENIWsYdh01pi3dj8kA0qN+Tx2IYFncrWrwkpHu+/nZVeLa/vFY+Hz/ZgovfPvElFiRAtqqe7IkGNSGvlLHJHnMT4UoPsSUz3lS3fiWB7Gqr3RCpYCRxp0dZPLXOzLVO6/CvuBN/PWBoviM/yvZsGo/jdgyVJ1HM6k7NCTJxWf+BhEIua2H9dGmqrwwPcchafjFEeQqlCJ01PxepDJRaA9TXYwPahIcK0ETB6X/T05qnO5Mnu7cpmKTwPwHXVJkr5kdMO8sQtG9kcfkQSp5XerdyWmwiQus1sMfP55NucSotk4b5cgXtcyhiMIohxX54bYvkQAXwjlzKx/yMMxm4Jrn24qBpbU+lEj7MQhrhSf2e3r8HSjLlUDfyCy/AHzkhMp6PabT
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:24:36.4575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e79b2b31-17c5-4e46-e319-08df494397af
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008484.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9585
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi George,

On 15/11/2026 18:12, George Kola wrote:
> The lwIP contrib shell commands clos, acpt, send, recv, and usnd parse
> the connection index with strtol() and only check i > NCONNS, allowing
> negative indices and i =3D=3D NCONNS to index conns[] out of bounds.
>
> Add parse_conn_id() to reject empty, non-numeric, negative, and
>> =3D NCONNS connection identifiers across all five handlers.
>
> Fixes: f3f86fd1fe0f ("Squashed 'lib/lwip/lwip/' content from commit
> 0a0452b2c39b")
> Signed-off-by: George Kola <georgekola@google.com>
> ---
> Note: lib/lwip/lwip is synced from upstream lwIP via
> tools/update-subtree.sh; 2-space indentation is preserved to match
> the surrounding upstream lwIP file style.
>
>  lib/lwip/lwip/contrib/apps/shell/shell.c | 54 +++++++++++++++---------
>  1 file changed, 33 insertions(+), 21 deletions(-)

Is this cherry-picked from upstream? Is this code is used in U-Boot? If
both answers are 'no', and although the fix does look good, then maybe we
should keep the code as-is to minimize divergence with upstream.

Tom wdyt?

Thanks,
--
Jerome

>
> diff --git a/lib/lwip/lwip/contrib/apps/shell/shell.c
> b/lib/lwip/lwip/contrib/apps/shell/shell.c
> index f4f668d712..356dbc9b04 100644
> --- a/lib/lwip/lwip/contrib/apps/shell/shell.c
> +++ b/lib/lwip/lwip/contrib/apps/shell/shell.c
> @@ -185,6 +185,28 @@ sendstr(const char *str, struct netconn *conn)
>  {
>    netconn_write(conn, (const void *)str, strlen(str), NETCONN_NOCOPY);
>  }
> +
> +static int
> +parse_conn_id(const char *arg, struct netconn *conn)
> +{
> +  char *endptr;
> +  long id;
> +
> +  if (arg =3D=3D NULL || *arg < '0' || *arg > '9') {
> +    sendstr("Invalid connection identifier."NEWLINE, conn);
> +    return -1;
> +  }
> +  id =3D strtol(arg, &endptr, 10);
> +  if (endptr =3D=3D arg || *endptr !=3D '\0' || id < 0) {
> +    sendstr("Invalid connection identifier."NEWLINE, conn);
> +    return -1;
> +  }
> +  if (id >=3D NCONNS) {
> +    sendstr("Connection identifier too high."NEWLINE, conn);
> +    return -1;
> +  }
> +  return (int)id;
> +}
>  /*----------------------------------------------------------------------=
-------------*/
>  static s8_t
>  com_open(struct command *com)
> @@ -322,10 +344,8 @@ com_clos(struct command *com)
>    int i;
>    err_t err;
>
> -  i =3D strtol(com->args[0], NULL, 10);
> -
> -  if (i > NCONNS) {
> -    sendstr("Connection identifier too high."NEWLINE, com->conn);
> +  i =3D parse_conn_id(com->args[0], com->conn);
> +  if (i < 0) {
>      return ESUCCESS;
>    }
>    if (conns[i] =3D=3D NULL) {
> @@ -365,10 +385,8 @@ com_acpt(struct command *com)
>      return ESUCCESS;
>    }
>
> -  i =3D strtol(com->args[0], NULL, 10);
> -
> -  if (i > NCONNS) {
> -    sendstr("Connection identifier too high."NEWLINE, com->conn);
> +  i =3D parse_conn_id(com->args[0], com->conn);
> +  if (i < 0) {
>      return ESUCCESS;
>    }
>    if (conns[i] =3D=3D NULL) {
> @@ -495,10 +513,8 @@ com_send(struct command *com)
>    err_t err;
>    size_t len;
>
> -  i =3D strtol(com->args[0], NULL, 10);
> -
> -  if (i > NCONNS) {
> -    sendstr("Connection identifier too high."NEWLINE, com->conn);
> +  i =3D parse_conn_id(com->args[0], com->conn);
> +  if (i < 0) {
>      return ESUCCESS;
>    }
>
> @@ -536,10 +552,8 @@ com_recv(struct command *com)
>    struct netbuf *buf;
>    u16_t len;
>
> -  i =3D strtol(com->args[0], NULL, 10);
> -
> -  if (i > NCONNS) {
> -    sendstr("Connection identifier too high."NEWLINE, com->conn);
> +  i =3D parse_conn_id(com->args[0], com->conn);
> +  if (i < 0) {
>      return ESUCCESS;
>    }
>
> @@ -915,17 +929,15 @@ com_udpb(struct command *com)
>  static s8_t
>  com_usnd(struct command *com)
>  {
> -  long i;
> +  int i;
>    err_t err;
>    struct netbuf *buf;
>    char *mem;
>    u16_t len;
>    size_t tmp;
>
> -  i =3D strtol(com->args[0], NULL, 10);
> -
> -  if (i > NCONNS) {
> -    sendstr("Connection identifier too high."NEWLINE, com->conn);
> +  i =3D parse_conn_id(com->args[0], com->conn);
> +  if (i < 0) {
>      return ESUCCESS;
>    }
>

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
