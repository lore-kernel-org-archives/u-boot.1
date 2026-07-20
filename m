Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B427C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 11:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A36FA838D7;
	Mon, 20 Jul 2026 13:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="kvBhZv0W";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kvBhZv0W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11D1784119; Mon, 20 Jul 2026 13:14:43 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B614B80517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 13:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=LEpRlBtH3N4kBQP7TEtnH6QNRr2Sh5tUgUDc1tte31CUfTrqKoctFZE/ZYXcjLoVvLwgOcYiWeAMP8lTM5Nqpm1a1X/fNEx1eEEmm4vmbNSyAzDdlM7buePIzqxHCI09EJ3iacbD/rDkbMsVyyPHtr//TP43ebrY8VNvs94tVpV4kW9+VaEWRTw75MouRGNjFfjLgY/NEb85DMn5tT+l3hEoeAfmvmp3iDpsLHS9kH1QxvtVsyK4DT8EkocoaLFH+QZ5fspB+X8iGzb/tvDx0fEJzlifR9oGLONoIrUlWTMw5R48e/umkHB/uQBNN698dGeZAqi9dW/oI7aedis4uQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1fiaIRUTjxoxzgw3YgvQrI+VQFzXNTp9miegvI8j5Q=;
 b=Al/4nRsDEKG5k1Tc9/g/Cl6HowUE1nJQLq+6pEiBo46LCNUOYNcScm7krtTw83cbOt7A/iwEJ1gXCmETyE4wWts0HHESXJjc1KTFEdS0D6pxmLAbeLC44Wr77PfflgU4vfqwyPQG1u99bdHfwGGxlJ39M7L1ENYnHyJjjzQDoUsPUh5Vp4Gf1shVUdBiTiPaPDT/2cHMSzmqT7vsPRIIPyoKXFlYnl9PzcGxUcegNcQ1dSneNLInHDQRA7+Jyiov5bE3vv7f8B74gA0o1oHhfTRhg8MK0MCjELJRN439AeiOoNRGDf6zBxgue7wVyRyBGf8crT8/PELRzdMQ84q1vg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1fiaIRUTjxoxzgw3YgvQrI+VQFzXNTp9miegvI8j5Q=;
 b=kvBhZv0WtwBkVnHT4FHq/trrubsDPfkQkgUb7s0WyTpE3eAg7bwFLyRgtJBVZ8eB25fqSzF2p3Rbnb7EpiteZt2oGvu7VggF2q8g78DbgnAg5kAXpK6NEYDEntSO5hXjrGp/KYjqmsRm+feVKr0BJ3R28yQISnpokqDwvYYrl/A=
Received: from DU2P250CA0024.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::29)
 by PAWPR08MB10118.eurprd08.prod.outlook.com (2603:10a6:102:368::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 11:14:37 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::5f) by DU2P250CA0024.outlook.office365.com
 (2603:10a6:10:231::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Mon,
 20 Jul 2026 11:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9
 via Frontend Transport; Mon, 20 Jul 2026 11:14:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOnuF0zO9aFDw0VxRGIpVKqH9ojl+hFvpzDPNWXqsYdYk1rXEYId5Gk3DwbJ3qqWKb6QB5nL8DGCL9qP/Kgpz1A+uLYvmFnZU14i7bWrf/+63qT1Rxkhq+AYC6FacnJrx+2Z7fOYTe84z8XW4S2iS9K7o104H4rdbWGvBfdpGwjprkGslsK6QRls9LdN6duvnF0ybvaNkgCcxG+6debuvBf2j/G7lltagRi41jHsv486fFv6oRSBdrmjDgavpttydhkCbaXpL3h9OyWN8vT87u4xVd+EIrqUF9XhUYNwSLMqgBzokESUk/vFI2nPLZZ7gnqXRj185VHDQMasZFdtfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1fiaIRUTjxoxzgw3YgvQrI+VQFzXNTp9miegvI8j5Q=;
 b=IZpn6d6ok2sLhEVzE4JVr498HHM0MPjroFwwsS0Rj7IFaHnAvLqQXG3XlkrTofIujySAwie+Joig1y6ClxwRLI0dTwLhyJdhq5Ivskctc7WhS6zaujqHsUNGxxP18RjedQfXBuJbPrb/6yqn7R66WvxVRBUC4cSNPGu+lZRXlfqgGXBJDsogoOMd+U0yi29bxKq7uBjoHuNsLmK69JITS5nfDlyYt20eMkFAhX2J2T00hM1sCDEVWIt772jHt071BcUAivx4oKJ4hEWztH6+QvUNrBcZW1kRWs/cIgywQLgH/NPAXsoDigG8YfPwRi1jVaPM4I3+nrkladS2aEH0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1fiaIRUTjxoxzgw3YgvQrI+VQFzXNTp9miegvI8j5Q=;
 b=kvBhZv0WtwBkVnHT4FHq/trrubsDPfkQkgUb7s0WyTpE3eAg7bwFLyRgtJBVZ8eB25fqSzF2p3Rbnb7EpiteZt2oGvu7VggF2q8g78DbgnAg5kAXpK6NEYDEntSO5hXjrGp/KYjqmsRm+feVKr0BJ3R28yQISnpokqDwvYYrl/A=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PAWPR08MB8792.eurprd08.prod.outlook.com
 (2603:10a6:102:335::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 11:13:33 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 11:13:33 +0000
Message-ID: <8454b1d7-4ecc-4fdf-962f-c483fa5e4ed8@arm.com>
Date: Mon, 20 Jul 2026 13:13:32 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v1] net: dwc_eth_xgmac: Return -ENODEV when phy_connect()
 fails
To: U-boot Openlist <u-boot@lists.denx.de>,
 Boon Khai Ng <boon.khai.ng@altera.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Nikunj Kela <nikunj.kela@sima.ai>,
 Peter Robinson <pbrobinson@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>, nd@arm.com
References: <20260714071927.27877-1-boon.khai.ng@altera.com>
Content-Language: en-US
In-Reply-To: <20260714071927.27877-1-boon.khai.ng@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0154.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::11) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PAWPR08MB8792:EE_|DB1PEPF000509E5:EE_|PAWPR08MB10118:EE_
X-MS-Office365-Filtering-Correlation-Id: 475cc8da-6bff-455f-8a83-08dee65015a5
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|18002099003|22082099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: AFEmciw8J4ieIT+ccrCgs4T/GDaVImyOs53R6vI0UH8nvhDh/ur6d1vgny16osV7HwTBvBwVqjTMicnxy7qjwFIt9tWRM+ao4vzuV+udOcxt3q25PuOb5jLRNY2IXx2uR517lu47iEYVNAtLlz6rzLCHlpBtHHg1eysfDFVj6WRr96KfOeXWY0VGCmLgyHlslxpEqLgVM1bq20Mho7RiNp8Fxa+qAT6GtrPDXI90YrU1TwewkDUEaj6K060t7DLKCHM+vdnZPiXLGNX/3NkkqC3GMXFi1SKuuW5pWN9bnXzMWhBglPL+ipcjQnecGGzA+6sKz3IXmnYnNN53LQeZdJz1DZT5jq00f6XkLy18IYS4gte+EidWKUc2TJrHvPSiXx+uExiOXOx2n/R6Ee5Kj+Ej6YMbB/SwWWGEEjzjO7X321HXDcZOY61H/1Eyuiz3ggzyo0WkoOc2dNxjLcn5AURfim/gtLTqBxEmHdxObioI0A2tssy9I/w4uQYpLI46Ld5VqKGUNYQEqijjaKfrassiTEqbF4U/lmLGWegBFZr2t7d+8SqZ8gQX/IJzw6xBpcXWIqh3ophX2eQt5vyIKxNpUg4D+gud8r+0cK8gfvtEjd+wku7DjjYBv3yk4qySmYiUy6jD+1oPIXfhXSk3Nb6bjJkiYSHJIuxEnvhSo2k=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: pIt3MA9TY7DDHo9K/YMwFLuDsHeXy3xyd/vYAjuT+THQ3YvALH+p4LKtYyooRcvfVZmP6G5ZBRbB3CxY02flycQo1DvGiIrkjgVfeoYfQhjw5Gv3/V1EVA9kFOLtk9ywgTAMw/T13i81ttC2IlauVXNFzF70tN94jplj32MIOMpLKvZTeuE8LT9UgwnH6+Wb++0ubPnxDtTvClbYJuLgC0tjQPnICNozEUeC6L/y93FmC4zdIaFegKENMR3n7gND5tQf04+P1sOlwfRYQDnTW/jB8NYpzceJ05u0uICAvEfVcbDJgDND4aZAfPheYMEhZG9CPBjJ2W8/xcDo1E6acg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8792
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e3303583-82ea-41f0-47ed-08dee64fefd6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|35042699022|1800799024|14060799003|7416014|376014|36860700016|10067099003|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0jC3jsdjkPfJbgUyJrwSE3wHuravpGGh85K6N9kQosN6T1gJgCnxGcqsEGcDt7ERnkFOFnQ9hghd2x4I/wC47oGq4Ag9TeBYgn5lSZduw8odsg+hheo6NRLJ8QLIFQeKBYWoCIiVtlaG6UzKsMK3g078VQNLqnCeOH1D733TAI6KfiDxnfNWYtKLBO4yjoyoIZMZavje3Q0x2Z7sdHyFRV1XgTzzX0ZzzOFrQiFSoP7LUbJqJEKHDEeY4RSmXcZrGfliKoBR80dWRP9JDOVHNQChZcHo5kv8izyxZuH1+1eZf7KKTbVX7zvBCDYapyxODcp7W0twKGCzVYvRN9AT9gOqtlEyBQFkFFsroo4MDGGuBa3pLFQR6OfQ++YjDyi9O9CH9B17w8sCk3X9tDWZEd4qgHz+XA+ok0pNxq26QMJh6zcggB57ZHZSinYo1KiHjMTQ664/l8IkJZAOjmQ4H1s9V1XB1+2O1zYYp2Pid/+hft3OELhU2vHrJHhxY9nxwt6hXL2DNVfNrK30bPlrutDRoMIjUTwmieOFDZYYF8deahnyfzm+7aW64vgkYG7ujCC+hKYo5HnE/eu3Wq/BGboyJjbBbkZ2/TPV8KnmhIntnkJBhJuaoRBmJvJTLfWr8pAQ4lYy+bodquDnpZmdqKkqYrSIboepipsVisFIotjYdTwhxULFqW85IlbCtIuGMQd8mOaOVbyYZn/A1VsHDg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(35042699022)(1800799024)(14060799003)(7416014)(376014)(36860700016)(10067099003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jlO32+ZAyBvOr4+Dxti7TWcsRnJSyz5LcXfyKJC+JL2xIS3t2i7S/LRtyXIG0FR3jjes6xxQLZyQh1YiWO7MJjTy4jNvF125O6NQBN/vAQY90wt6i9Mw491lQrFwh3JM6Gx4C+2xWC6QtsPWkg7oV10DyTin9ZiJ8vhjiNAkfqjOqXOyDLeHgAHRwfWd8T8lKWQLwZifHjv8eG4uYkv1wa5PuQEvZP2b7EoX73aWPashIf8gWAHUKqDJBRXULVkjFtQG8dwX6+3ZSSYBwDPR+Q6nV6Nm3Zk+QpqmH9x1Wu2JyugNyFwxdAz+mQ5Z+kzUd79rXG4NQDuQPL4Ga/qWEUhy5JFDyKxS2HH8mvEEjcii25L5OtNGTS0hMDRCsweu5/Ly+lIueipyrihu9CO2RunexkZ/M0TCpSSLTlHgf3aCknvzuvGaACSyYG6sHtXz
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 11:14:36.7026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 475cc8da-6bff-455f-8a83-08dee65015a5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10118
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


On Tue, 14 Jul 2026 15:19:27 +0800, Boon Khai Ng wrote:
> When multiple Ethernet controllers are enabled in the device tree,
> but only one controller is actually present in hardware, the
> non-existent controller still attempts to connect to a PHY.
> 
> In this case, phy_connect() may return NULL without setting an
> error code. The current driver only logs the failure but does not
> propagate an error, causing the initialization flow to continue
> with an invalid PHY handle.
> 
> [...]

Applied to u-boot-net/for-master, thanks!

[1/1] net: dwc_eth_xgmac: Return -ENODEV when phy_connect() fails
      commit: 41913031b3411d523302fdc9acd4dc3dd4f02677

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

