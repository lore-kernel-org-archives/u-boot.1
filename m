Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C632F606A31E
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o7YQsmLD;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=SAsnjzfG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35E2380E14;
	Mon, 26 Oct 2026 09:56:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tzyi8club7iu; Mon, 26 Oct 2026 09:56:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF1D680E0C
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793008574;
	b=gb5dgxJx6P8048kpLEHiVrLY7NkjrZn0aCmUdk4Tr2OUFPIs5qI+D0S+RtNifl4uszHX
	 lT5SLIG8+0pbnOiWJaZ2K2Sb/5VUIWge4tG2Yiyr+RR7uqkpPHI/xSvmtv02mv7ssLTmI
	 5XAFfwBbR7tnO8v3yPDwCWvEscB6Ryr9HpKN99dOcdXSHtYam1RcmeWCp4wxicoe2SPM5
	 A7Yd1i96iLGvnVGYxgiw1i9HkBD1PUuofSRszsQjRFWqjcBffvwPQTXNI0jO6FuYy6M9g
	 1GjNwl5FUPXFVxcaSrNm++/3CoVmEYZo2pD6hrcUkGfiiIPhWnxTeEtEmSJHpHKX1UA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793008574;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/jqyA3dzGlbuZzP6fBdvY/208ZQBKhKJtLVz1WpDL2U=;
	b=ZJsrCVRq2oBjYvSsV/d2sP51/5rgshyBilG6cG+6r1/eYRvh6yOYPgtBKAhvekdyRVfR
	 vT/NzqJwba027ZWf2OPZ7KOiQo0N1LybtTfT7/6/Zc5P5art3ojwld00pTs0QoEBy8yRE
	 5RidS1yXFX0ipOwRIluVZ8ngLtH/Ufl1rsqh/bKLxzag9nYlQsYiuh3Jrsc+M3AoE0y+J
	 HzyELpSYVwzciOC/gt4mOu8Fz00BgNCbLY7qlDSWDKHK+bsYNZn/ML7uAfJ7Sy2FwEL30
	 0cTIHKbd3H3zI7dJQE0dj0qpPgIvyDKxJzaqvbJRatDfgf+08TOOS3kRF6YJdvI4yMw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793008574;
	bh=/jqyA3dzGlbuZzP6fBdvY/208ZQBKhKJtLVz1WpDL2U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o7YQsmLDef7FrCTvG+nvjMdUtGc4bFQAT35i8x+U/36YJ+vF2pQCJuJ71PQisXb0m
	 OMOPH0+qZmZAFJHP1xhG1uOAesQz7vZgrFd8vw/ZASb0oLXjqX/+y03tfUXZD33lPb
	 1ev+xT1O2ZOB7lhxJBec2IA/ZbX4Mb1zr/OZb460KQTApFVcefAfRf0BB2XpD6rOnP
	 2SmRkkm1BgKAkGxbdR7DHmLm1BeOkqtOYhqJkFvx/K9ZG+mzWWLhK2ckop5wJGuB83
	 20BvDAwygMT4Bh9C2pJtiy03Zg2Bnif9izaUqMveznq9k8YN0qOedKrtMhSE3Qekfa
	 yuwyVbeAWJAYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF1D680E0C;
	Mon, 26 Oct 2026 09:56:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C8D143D9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA61040049
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:08:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nK79-br5YQxw for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 09:08:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 79D744004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793005720;
 b=WovswsFN/2qDg8RemZAf1yuSjNRP7DN3f9nlTHKNyGLO1kiBaEieeo3uJSpC+kJg//Eh
 xOU0a9fcR1QjDH/DycpjecD3/gZg9DaGfSVaHTEh15vRsrQkzfzXWL1APul8w3tpiwKE1
 oat6hRl1/vZ2Bl5C3XWnKjw2DwhfUKeFyLr2SYxGxwg9y3084SA/iwJWo9YxKk2sGDd9d
 QeKkozlYVkZEykTCQ9ywI/ozhL2AP+JSsw6fkEhaeB+z/E1NQ9SSXXkmEQSP91hInpZ7i
 S69cWQNClCYVSkSHlQGN4DLFbYdeY/PuZTKUjVQ96jD+1VG9Asdrqs1N+B9N2yrzM7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793005720;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=/jqyA3dzGlbuZzP6fBdvY/208ZQBKhKJtLVz1WpDL2U=;
 b=q7Y4TBlUx6mes/Tz+pBKNNwatBbyV3EKy9jFv2OmwBbYe1bupdwTV5HIjfbcxuUzJvuk
 Xpn6zYuZ6dvOycD7sxHmrfr0Jo7yk8Tj+ii0QLxXDI3TRnR2peKn2kNQQtvJQJIikaI2G
 w6Y993ILenTn1dSiEt+1ihnqlwusC79pxOqXH3uDJKXmjxsrg+OJ+X4VYkLPpVvXEB0sj
 2PY5ER5bUxyOEeMFSE6KDKbvHO04xfgtZZzQMwy/CAY/QNS89Z+ghtKovdQo7O3TurQQ1
 uqwF6t6W45v7rehVRikpJOpajvkxNQiROhJwJztOhWAEN3/R1QtTJGWxX5EWTTDF1qA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=foss.st.com;
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=SAsnjzfG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=fabrice.gasnier@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=SAsnjzfG
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 79D744004D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNqrDf2gv29znfBWowxJX8RDJl/YGmxyvIad8oFwRacATkURALuZNsUPxtv29GosqYPPOcEbhB4KHMrBiWrUPgnk0A0PGCMqbEVNiZuxomkA6Zs5hehFGL36rs5V7bTY5R6YhSR/v+921BSfImz1jmMb/3oTu/B67Ba4r7dv9Zvi0WvEPrX7XumvGOWykztvvp9l/Aj6JK3kOW0+B0ucW2S2GaUu07Xbb4MB+ePyiKDeWRgUlW9MpPgUITlT+S1duDlqXsxMaN0oGJujLAEKd7+AgRllX4E3j+3bkGZANADXAlL7d2inT+UDCfszANrBF84yl+vRF38COCUlnuYPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jqyA3dzGlbuZzP6fBdvY/208ZQBKhKJtLVz1WpDL2U=;
 b=ZbRidDnPWDBtdQ6lROcYvUSMAIaT7x9OWqNJ3V+tNfUQnFVOzBVfWbvhr7w8CZJOA8je3GySri/vH2vpMjAq+1zDaHXk/XkC55COTS6vvgMctXOxbzHSm8fd/8w/OtE5q75Ii2NzsaFQLqDQTzUrTXx9GFdjyEny36z0zlkP2GH3+3/nkxxKUxJVGqm48N1clSHF6pF1RRzhMsuLdRCMvE8mpIHi/IiNlY3x7ioCuyC/WY3H6sST3048WCgBk+sDCI312zEt5v1va4Oi7zwObZRYNHtJ+/IDxUUIt5UxmNb76I95qP3tARnno5iwp6eqstMmHVwn4XVYKBAWuPqVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jqyA3dzGlbuZzP6fBdvY/208ZQBKhKJtLVz1WpDL2U=;
 b=SAsnjzfGQXSqMexCnUGLYHXLCenGAFZk1UbrmBkLEGGCgwqBGNSx2j1udWZzEBU7AkBSZ9aEoegM83ZiySlcN7Mron6aqrtow5xxHx3oTPlOQtMJODhGHbYsdJNQ9XVFrwRsWyGXEudE36iu8TYZ5NNCt+BbWpgKGowSAMIwZpWMC0nuL3rN96yMGgYu0eBBfUMNC/RRbDh75Jxq6fZdirQtKT/a2RUSWy109kjJr1ASghfLPCB8Os7LYR/AJEii/u/r8g6ry7d1gvqJToGycOOXpZXTvGEzbZUlkZt7EKWn7JR6PALIqsSuW6W9CkZLJHLhW85IIhOYCLQ32YIO3Q==
Received: from AS9PR04CA0063.eurprd04.prod.outlook.com (2603:10a6:20b:48b::9)
 by AS1PR10MB5215.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.7; Mon, 26 Oct
 2026 09:08:35 +0000
Received: from ZR1PEPF0000E45E.eurprd04.prod.outlook.com
 (2603:10a6:20b:48b:cafe::55) by AS9PR04CA0063.outlook.office365.com
 (2603:10a6:20b:48b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 09:08:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 ZR1PEPF0000E45E.mail.protection.outlook.com (10.167.241.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 09:08:34 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 26 Oct
 2026 10:08:49 +0100
Received: from [10.48.86.251] (10.48.86.251) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 26 Oct
 2026 10:08:25 +0100
Message-ID: <0d6d23d8-c247-4359-8195-1ac4238f8319@foss.st.com>
Date: Mon, 26 Oct 2026 10:08:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: gadget: dwc2_udc_otg: bypass debounce filter
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, <u-boot@lists.u-boot-project.org>, "Kongyang
 Liu" <seashell11234455@gmail.com>
CC: Lukasz Majewski <lukma@nabladev.com>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, Patrice CHOTARD
 <patrice.chotard@foss.st.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261008-dwc2-iddig-fixes-v1-0-24c302b8953f@foss.st.com>
 <20261008-dwc2-iddig-fixes-v1-1-24c302b8953f@foss.st.com>
 <xhkdbh5ig4sqa.fsf@mkorpers-koolstof.csb>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <xhkdbh5ig4sqa.fsf@mkorpers-koolstof.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E45E:EE_|AS1PR10MB5215:EE_
X-MS-Office365-Filtering-Correlation-Id: d2388e52-2467-4d6c-ddbf-08df3340b6b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|22082099003|18002099003|6133799003|3023799007|56012099006|11063799006|4143699003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: r+d6b/EPfc/pRoxTzh/7HZBpIqmjRPvrPyxDDTeMH1s895McyM+450U9RrwQe6s2M9X/N4AW2gHZULjFmDjh3gTMZSAAdvEd2TN00B/2vF5S/hsc8ZI5aC7VIXmRSNTiIipnbkmsmrT6Y/H6RwZm371VoqJ1Q09b+bCyRwxMAziuNshGRZfvSZS56uK7dZe6reUIje7mqC1+Ot3h82DVB/QW7qBzFwKnPpXOW+mNKbY/n8MhWA9tKg7WV1uRBzKiHzSLo0sfLtLgN7ojyxTaT+0SAA3F4qof/uhkVKUjFEDB96y9h8R0E0arV119KlXVLw4wLrwCG3UZfXKefX9ZqBNEVFtu9XZj4DaRnOjiD2Lv0eA3JgQWTKmc2gGKClG/y7h1lawHKHlnoDbsIpY/Crlv3B/sOvYJNrnOwnAJfAGagtpfI4FXm787ms+1PiFILHr9swlVOumIoElxB1P4rGbsCvLnG4bYHDy1RNHqMTVqTHraYBRwvNdYLfMo+8tfrN/uNLWg8XuteSKFwXBIrxIK5vC0kFRtUWjyVz2DCxV7w/Vfk6dKErBjJvrcn4jcPStOFNKymixz4ZfvN/nz9UmGPp1qxTnNz6WLB+l9u2NVOrnsQXTgizUFtz/3KrMnkbbDGha9RIAiFdqUS72Ymq/FIMP+Kb2bsggfSk6+PhAWUjS6tiywdCEVj7S2JAmmo1/cdIfi/qvCO5N37XlMfQ==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(11063799006)(4143699003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hJQoidT1k1WINJ5PP7wCyW70EZzPfSTdBXBo5nnh4x3I5wgl4rIUmvSiSxCgUl6b1wXosciy0F2S1NCubWn/fluqgDNrE33X/txmiXKYttaNxpIoK5qIDY/gXdp1bFnL0m1laBYAgcmpgJzv9pi09yc6LYW5FFAOyj4WBadXRdmMOVOl1L19JBLdI9TrLVl21/qG5lomo4i9B2lTvUFvFsYKTAS82zFCZ/eNMLFTf6wuUyCQUPlP+jKNz3pSxejGB8cJ+G2rlUnac2ZEcH+lIui6GKgtpdpqk7N0v/+evv+oPfAaFFVksDLbnA2ScA5Z5sfV0m0IKEsEitkvIwIlN8bPJgljlg64eTCYGgUOb+M+ud6zSYdgljpgHQuf+sarvmVS/0+NI1nGFfsLluFWPi2PA3sFXbjg33LTAnICjCqhzBNC+Hn4kOrsm6avtIzM
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:08:34.6035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2388e52-2467-4d6c-ddbf-08df3340b6b7
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E45E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5215
X-Mailman-Approved-At: Mon, 26 Oct 2026 09:56:09 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 11:38, Mattijs Korpershoek wrote:
> Hi Fabrice,
> 
> Thank you for the patch.
> 
> On Thu, Oct 08, 2026 at 17:37, Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:
> 
>> When using the A/B session valid override bits, also bypass the
>> debounce filter. There's no points in deboucing, while forcing
> 
> s/deboucing/debouncing
> 
> I can fix that up while applying

Hi Mattijs,

Up to now it looks like there's no other remarks on this patch?

So, yes please feel free to fix that up while applying!

Thanks,
Best Regards,
Fabrice

> 
>> session. This solves some connect issue seen on stm32mp1, as forcing
>> session races with the controller initialization in reconfig_usbd().
>>
>> Fixes: 5739ef2bcb6d ("usb: dwc2: add "u-boot,force-vbus-detection" for stm32")
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> 
>> ---

