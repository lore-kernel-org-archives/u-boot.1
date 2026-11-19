Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCCD606A324
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AxwkVSTl;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=C5KXpu6r
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEAC440B81;
	Thu, 19 Nov 2026 17:01:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bg5NoTPFBEFC; Thu, 19 Nov 2026 17:01:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2CFB940AE6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795107661;
	b=tIh6DsIBhAHXK+3bI3z25KZTjcWLd7/1Fg61NB3HnRopVnUw8z2cQFYVxHs1vbNJxPYd
	 5unOqXtlg0KRjyjPINy6WS8bPVa3eKhv+uINdVsrfTuA1l4jH2N/bIWPGL9M5MxDZchH7
	 EaRcXT1XhBgfewpgTx6p3KxlU2oB1JNBMfoazGdYcKA7jfX1pHBwvCNxjS1irYXtUMoaG
	 72l0uZcQSWnqiifu0Areivl60MIi/6cZz8X61HCHQlxGGL4LIAPq9Lr8VVI52Ep5gd8JY
	 QFmJJaGyBmaCq8GUgDw9p9xk/MlK2ksLVSnKs8ul0IGEnlo//WbinoJpWWeeboC479w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795107661;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0YZRsjXbdMmHeHdxmw8zRZ2cCtnnYIIjBZSxg+aAMWU=;
	b=pbfluwU5OjbQYWYCOJVruaKIT8ZteshAyoMVW40RJ8tCQdtrmsPgugH5fJYvx+O+YAKe
	 wXcZETcqh4ozxBXgS4ORPNdtk4J9sWu7Omo5JqFUnrARxL15Bhg0a1mUOy1RzUhUv+jMo
	 rr65WnyL7/gndayPFc3tZ0qDkF0uVzwg98yiMdzYQNoqOwV/ETxWvfGdi812v6vlXKwUj
	 fpbDqxINiE1hMVHQi6RRCHBSyeg4qshbbvTUNIqldqdACl4tZcr7xJ/WPfw/y9soVYZjA
	 xiq8TeY9GtEXoaSO7aYK1efcMA7w9C2YCq9yExwQwjPaxoyG9UFao948AV7bBf9/qbg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795107661;
	bh=0YZRsjXbdMmHeHdxmw8zRZ2cCtnnYIIjBZSxg+aAMWU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AxwkVSTl1X1HVatLASebrhH1mPSxd5fNgUcaN6VayAelz1Tkluwz6nLMcyoxp8RD6
	 SDfSEkjt4vKR7Ur5KGWiN31//Oyw18I2heooPxqcmxh8iewLqukwwvpMmkbK/Se9h4
	 0oSShY3ZlyIUCdtuKSx3vNI/6o87ONfepOw3HV4xyKhc9XjGy2GxU1unFO3oPMD11Q
	 KF5MwtwobwsMUO5Aad/WhUaFoQnufFG+JvWBC7xfA+wXJ8yFYoTXUlSTAgQEX+GO6a
	 P6S0HvH/todtr1Ay0DIop909/CV6zOVjl7B70py7AYh45mfpJvy9fa01K8Dm5h0JmT
	 /GxWWjL4tmtVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CFB940AE6;
	Thu, 19 Nov 2026 17:01:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AA3481E7
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:00:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9072F606F0
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:00:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VqYu4oZV47Sn for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 17:00:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5412D606E2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=C5KXpu6r
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5412D606E2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YZRsjXbdMmHeHdxmw8zRZ2cCtnnYIIjBZSxg+aAMWU=;
 b=C5KXpu6rdGd266exXTPyMCOLFxR6AEAROzhsgVL1XusRrvpKvO/E454o21JlEFvxcyd+3bGJnfueihfiIGvU13CPiH+384ByhP/bmUXAEAdTH8Pd1XL+u9meH++xunf6SQ6DZ070rBJauHy8+ybMKWNoRY9x620mkgC48mOhRr0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DU7PR04MB11188.eurprd04.prod.outlook.com (2603:10a6:10:5b0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 17:00:52 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 17:00:52 +0000
Message-ID: <7209e2dd-4bb8-4039-8842-5f5d3d9fffd1@cherry.de>
Date: Thu, 19 Nov 2026 18:00:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/15] buildman: Use mock environment to ignore DTC
 variable
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@nabladev.com>
References: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
 <20261116-qcheck_fix-v3-5-b6cf7e96944b@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261116-qcheck_fix-v3-5-b6cf7e96944b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI4PEPF0000011E.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8a7) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DU7PR04MB11188:EE_
X-MS-Office365-Filtering-Correlation-Id: f68b3d68-68af-4217-b485-08df465eab03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|1800799024|10070799003|376014|261026121527099003|18002099003|22082099003|6133799003|261022105027099003|261021123027099003|56012099006|4143699003|11063799006|261028144727099003|261102123227099003|261022075727099003|10067099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: AoNaWMuerTScfXx+NazQ+yh0IKKQFZSYjb+qrkJY2v91x/3ow5XWKZHbg761ZCm+nV0HJqkuYHrsmRrmk8wCjc+mP7TVDcFy4Ts85VafT7oMXFybrou57InmCPon+IcLKKY34igv6HHQy7emSh59z/DgqIs9tTsMuEEwTkH98Q/KDwT2C+vnZdrQa1YvlprVqWLJc4BSwLLkC2nuDMj99O2utmGQC3/HLzq432JO84FFp5+lpspLL248mhIgiSnFxDBjtAsNEuHSkrO482i0XMGrk1nb91BYBnmZ6ec9M1OT4Rcj5qtmf8G3MuW7P6AqzX5U7PUKGPgplduAJbScGXndzvNeukjf5SfiwadU4cSYG2p7W8H2SA5d3SOUFcsDYj5m9td9bTU1rKkxufcr2mseCGkVRwtW/+nvZnP7rjE8UkEkUkMjUPiz4s5Yj1XSQsa9wBYWJLubhpwgaqozdXZykxN5kTFHupuB2ZPue7qI+NCbsEGR/o4Xx+iJ9wv6Eb8XC+v57bW3npBWU8eh9vJhT9nNI8jE8TbMc1QqQStiv65+ryfUeLwUd+rsjI12v2r9ZWaC/tp81j/cxPDYEwgTPU9R4c8q3tO3qlqMsul+uawZtPVcFIZKpZ4uvLDFGtGmwxdispcwf6Hi7prN3wTXAvzxb4d/xsB8YGCZlFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(10070799003)(376014)(261026121527099003)(18002099003)(22082099003)(6133799003)(261022105027099003)(261021123027099003)(56012099006)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(261022075727099003)(10067099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SldFSmFmb0RZcm5wRjYrK3c4aWh6eUhMUUJCaFNQK0hGQllsRWFETHFPRndq?=
 =?utf-8?B?RC9ma2pZN1Q0ZTYrZC9KeEpUaTNjZ01kMzk1citLOUIyYUI3dDZOTWxMMlhW?=
 =?utf-8?B?V3hzYkJKWVRtOE9QRjJZTkRXRko2K0d0L0pxZmZHcmdTWTd6Z1M2d1hmQ0Jk?=
 =?utf-8?B?OVJRRE5USUhNcWlMTlE2SWZwMDM3MlJXYURrcjFvNG1uUTRlNlEzNkZxbHlZ?=
 =?utf-8?B?L3kxejlHQkltZGhRSE9jc1hINjh3QmJhVmtWTkZ2UHRCajg2cFBDRlJUWnRr?=
 =?utf-8?B?NkprYWg1VEF2bS85Vy94RTlUZ3Nmbks0bzdyenNzQ1NMMzJpSlkyWkQ1K2NF?=
 =?utf-8?B?SllMSUIyRlhtczc3MlFoeG1meExHN2VXNmQ0K0NXZUR5MFB2SDFjS1hsSjEv?=
 =?utf-8?B?VHpSUnlCTmd1cVNvRnA0U0xJV2hDSVc4ekFmZ0NXRCtjMHJDeGRCRDlGcFRi?=
 =?utf-8?B?eDVnU3VBR1lCWnMrb0NTdGxVdXNmYmkvR3JGRkxYQ3pwYnRrc0pDQUNVaHls?=
 =?utf-8?B?VkJqZkRBMEt6a3ZZbGZUREo0Ui9LdnNqcXNTekxqYUFyT1hsVm1rUFRUOVNF?=
 =?utf-8?B?cEtCK1hnbHhXU0JkQzF1SEExTEY3QXdITDRFbnZFazdpeGlXYlVqZEJGbzVM?=
 =?utf-8?B?SStrTzF2Y3VGYUY2ZW5UN0N5OFNzalFzeDRiRnc1N0ovdFg5Yk51R2FYYkFU?=
 =?utf-8?B?dkJNeGF3R0RmKzBNSXdpVTZ2bVFtOXBQWHI4cDl5bDJpcHN0ZkFrK2FTQk5Y?=
 =?utf-8?B?WnR4TXZpdTBhamhVWkZEbUUvU09oZ2NibWJweTY2K05Md2Z5RUc4b2wwTHBq?=
 =?utf-8?B?V0dwVjdTWThLb3ZqTExLaDBjZnJ1TjVrdWxhQ1BYOE04RXphRXpHdTRnYXZh?=
 =?utf-8?B?TTNQN1hxNmU3K09oTllkZWs2VlE0amVNWmN3TjE3cnphY1loUTJ2elFJWUt2?=
 =?utf-8?B?OVNRcGU2MTZVL0o5RFFYZ2ZLU0xqWTdwT2puVWMxS2hwc1RqN004R0pSQng4?=
 =?utf-8?B?Z1ZJdWtjQkE1ekRoVFQ2Q2tlelVVSVdOcTNQU1NTVjNMSllCT3BzQW42bXZi?=
 =?utf-8?B?djVFMDl0Nk9pU2VPSGEyYjZYN1dBME5LTHBzenVIZEpYcWh6Znh2R0s5Uit0?=
 =?utf-8?B?NzRveWNVNDJzWGNhZXRsZCsvcEJYY0w3KzZYVE1pN0VaSEZDdDBWRDdIU3Zh?=
 =?utf-8?B?eEk4bFJtREdFeUg4cmZvNTJ4UndQRkYxNEFNaG53eUV4ZDVKYnJFVkV0Q283?=
 =?utf-8?B?SWxUbXZUM0E4TlFLTm1OclhNQXA0anZTdDB0NVhub01OUXdobFVUTXBaYXR3?=
 =?utf-8?B?YnpMdDNWcWhNNGxxZUVXOCttRjVuR0xiK2JDM0lJQ2R1THNJMUtXd2tUMGds?=
 =?utf-8?B?cGxZaVFNY3EvUFFiOWZWVDJNWGxXdFpGL0Y2VDZDaXMyN0lKaHcvNWdrNlE4?=
 =?utf-8?B?cWxPQlZ4YWt2QUdiOGpUa2NYakRtaW52THdwTG5NMzE2eFdha1d0MFB3bTFw?=
 =?utf-8?B?QjZnL0FQbllRWmoxbHppVXJPc0xzVjBLbXBFWlRRL0VuZFZhRTNiL3FPcTBE?=
 =?utf-8?B?QVNSRXAxeklIOEJaY1cwVGR1U1FuN2FKWUJLejdIalNFeVVIQ3E4ZlU0amJh?=
 =?utf-8?B?OHVWdjFCOU41R2F4Nit0Y1p0V2lXODF0ZXlNT1ExYW4yQXAxc1Mvb0tuMUJV?=
 =?utf-8?B?TDBFSmZzSDRKeERhaEI0dUprQTJIbTc2d000bmZ2Vktyd01QUnEwSFVRTVlk?=
 =?utf-8?B?V0dzc1NCYW5SMGtRWUxsTE1tdFloSGZHbUhPMldFalBWZFpMZkVUVldNTzI2?=
 =?utf-8?B?Y3NqQU1qZWZGU3c0RVZ5bmUvUWxIb1dwcEd6aC81by9ZWk9QcE9yeGRzb3Bu?=
 =?utf-8?B?NVlTV1cwL3lrRVNMdEpCK2kyYmdwNjZwZ2dRQ2pwNlMxemFSMUdjM2tkaW10?=
 =?utf-8?B?WU5BMkFOTVYrZ0lMcnNvMnNlbHFyTk96YnM1M0hiYVVSblBLRUswelRrZlFC?=
 =?utf-8?B?S1VHeUZITzI0NWJ3YkVqQXlmbGh1SnVFcGVrL0VqVjh3dHFzZnQ5eUtlaGt3?=
 =?utf-8?B?dXZwdXYxMXp4cDlXNldoSEtKRTVhWWR6QVllOEJidmhraDBTcWZrOFcvKyta?=
 =?utf-8?B?SWlINXoxN0F1azA1OEJCM2kzWTN6dTh4K2FKV0d3cmRvbHd2RysxcEJpdkRG?=
 =?utf-8?B?ejlHdkpxdDhBNHZpclBBQW90eFRKalBsanRFaTRSMnFuUEEwd0xpa3BJd2V0?=
 =?utf-8?B?TGd0a3hnUEE4UGc4elg5ejhHakkzeEpjQjN1Q20zTVFUZ3I1N3pmWElNWXQr?=
 =?utf-8?B?T05yUHVvRk45a0RkYmZ4SkduVG43cElvRFRubHpEYVJnUUdzanZUQzJQanNv?=
 =?utf-8?Q?wbEPXs3HYXq3rdzXkrb2azu3jmooPlQnRFjJeShNnjstY?=
X-MS-Exchange-AntiSpam-MessageData-1: 7XIZoFx0cta7v6ayeubQDHFgEkwiCp0OP6A=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f68b3d68-68af-4217-b485-08df465eab03
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:00:52.1335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Urr/ER0+Ywb6ECX2EirbgYKpYFwMnF6mV7nr4qbVXBSUYip1xxcRWd64ILeyE078RMV3qWtWHCJaRqOsBmQGcARPn1gItDM6noreAbrNi3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11188
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

On 11/16/26 11:59 AM, Andrew Goodbody wrote:
> When testing the toolchain setting of DTC in buildman, use a mock
> environment to avoid making changes to the environment and give the test
> more control over the environment in use. This avoids test failures due
> to being passed an unexpected value for DTC.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   tools/buildman/test.py | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/buildman/test.py b/tools/buildman/test.py
> index 7ee9496ffb3..81ff2716bb4 100644
> --- a/tools/buildman/test.py
> +++ b/tools/buildman/test.py
> @@ -1012,8 +1012,10 @@ class TestBuild(unittest.TestCase):
>   
>       def test_skip_dtc(self):
>           """Test skipping building the dtc tool"""
> -        old_path = os.getenv('PATH')
> -        try:
> +        local_env = os.environ.copy()
> +        if 'DTC' in local_env:
> +            local_env.pop('DTC')

suggestion: non-optimal

local_env.pop('DTC', None)

or

if 'DTC' in local_env:
     del local_env['DTC']

pop() returns the value associated with the key (which we don't care). 
If default (second argument) is passed, then a non-existing keys won't 
raise an exception.

del removes the key from the dict, and you've checked for its existence 
before so that's safe.

Not necessary though, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
