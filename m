Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C73C3DA41
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 15:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD71188680;
	Wed, 10 Jul 2024 17:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="JSkeLRjs";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JSkeLRjs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C11B188657; Wed, 10 Jul 2024 15:52:30 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21F0F886E8
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 15:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=YeoReum.Yun@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Qa4e9siz8CtPReD+4D8revcBueVQesgsOGTQoBjuREGzH6ptTvcKhRD/6AVFfsW8g9S98pOKGnbKpAo+OjhJmkBhTo8CL3UZYanf27wjOLPFYYUeGcu858HsQ0jjBoHwXc+6ZHg3yTDjWwChpiyw7jXFR0vjY152mH8vNLA7WUUBIw68+P+XxuSjIqroECdT7GxUKnQr4BqgQzZ2NlNEo7+syLTKosHoYyRHbNmAkct4zI34YM7lRrlBsZ5KwZSW0JMTqa28aZk21+1xljUlpH56B+XPD+2xHWzYkqckB6p48xxvnLFZ8i6cdehSwUsQMIfJc69RwL55820qVEDhQQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8ezFAsPr+V2VeS3K2gdMPo8rRrflPRs3Ja6J+grp9s=;
 b=Lpl1vkFYEN2j/pr5xK9hxkWzUPWCnIJ4js/aUgTjy7Isqg6en+xLFWz7D9C/pNNidUXDNgjZ9F4uwa8/KRGWzRbyOZuJ49YHBvFxM6wRf9g/BXpmFOrDBFNp6dgtrzLfsfschkmb43j/CZDN5HOzfhUK0AmzUzVH1MHwBlJ2MvZuTwGrxUEaLPVdkpzebOm5IouI2/N6Ca3XcLTWUMUbG8VeiofQ9XjlOIKJ6plQl+mjwpiXZXaUe63VME6QYS16aQNzX16GY82nFK/+vRU/F46AcnVYgW2uCjieYrMsqT3rp2kWHD3J0FCZs4/Am7QCIu35SZlIDRmFtmf1XB6ALA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8ezFAsPr+V2VeS3K2gdMPo8rRrflPRs3Ja6J+grp9s=;
 b=JSkeLRjsKbwpfza9uTb/mbMMV3VVT5MqinvwA4GcBfkPoA7SQ358Zrc1d6/euIQb46hoReIKZjBU9QWjVAUxNh9vQbRcvPb3EYpm26mz2heJqospLY7ee4qaP4bpUDOQRd4vUYIhI9A3WIynoF1CvdRh4aEtE1lC6Xjd97sy3K8=
Received: from AM0PR08CA0009.eurprd08.prod.outlook.com (2603:10a6:208:d2::22)
 by DU0PR08MB9371.eurprd08.prod.outlook.com (2603:10a6:10:421::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 10 Jul
 2024 13:52:25 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:208:d2:cafe::31) by AM0PR08CA0009.outlook.office365.com
 (2603:10a6:208:d2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 13:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7762.17
 via Frontend Transport; Wed, 10 Jul 2024 13:52:25 +0000
Received: ("Tessian outbound b2522d7cfa6f:v359");
 Wed, 10 Jul 2024 13:52:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f5d305b7042f5277
X-CR-MTA-TID: 64aa7808
Received: from fccbd46f81ec.2
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 6F5A3BC9-7192-42CF-B591-AD844AE9DFD7.1; 
 Wed, 10 Jul 2024 13:52:19 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fccbd46f81ec.2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Wed, 10 Jul 2024 13:52:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6FP4silMMPLtJZygXOy8f7sd96tuP0jhm0MGjsrjYGLjDnKb0sgNt1tgSqGQO3us5yRaMCd0qsR7xbf8sYLAVHx8krZekogyIuM3Aq5kWAm7y/6XUKWKb2GOzqb2KX7dqCx8HdnQJ8/tR1AVTTNK618WMbJObc/yqdUY+LSVidTxIYB4e9xZn7rvGOIr0OzgQjvEGyytJiZ3tGGyKKi9Z3wcLTAJ54zBBGlJ8wsVKPAR3158lwSY9rpvwqQ8PMDkjL37pjAUyID6iyrgRx+R17Ghcr1fT89wJhTnuDGqWxNQiT4BnLhReBZBKeZfvvK5s99jQEQWgcMhpayrIg6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8ezFAsPr+V2VeS3K2gdMPo8rRrflPRs3Ja6J+grp9s=;
 b=FFqp51E5nNqKcRDw7f+gYYi/pfOXbCKSuMIHFCrxyUNpxLYb+qIx5xb6agzLwL2cDYfvukWS7QQlrqRZGjbN057iNXzEQaBEfM7UAwA+rTHTr8hwqQ1NwQFzPoV9SJmg/hbaOH3pVwOaGvoW80RndoHlbbwcPqAOvl7Lh0iO5ZACOKK79BYscMLHeiyoZuTFwmS5gUmPJ+K3uzXvKBNGEIb09mR350va0PT61e0zpAZMzmjrxcLa/TPT2fNp3SiSzzgikp57vn2+bKFY6hc0+WwQMNAwuR1RrRzMzz3kzBa73QIsPd48Zss+6OKJHi40wFQ8J1dIDZdJRZ3iEGbOAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8ezFAsPr+V2VeS3K2gdMPo8rRrflPRs3Ja6J+grp9s=;
 b=JSkeLRjsKbwpfza9uTb/mbMMV3VVT5MqinvwA4GcBfkPoA7SQ358Zrc1d6/euIQb46hoReIKZjBU9QWjVAUxNh9vQbRcvPb3EYpm26mz2heJqospLY7ee4qaP4bpUDOQRd4vUYIhI9A3WIynoF1CvdRh4aEtE1lC6Xjd97sy3K8=
Received: from AM0PR08MB4289.eurprd08.prod.outlook.com (2603:10a6:208:148::12)
 by AS8PR08MB9362.eurprd08.prod.outlook.com (2603:10a6:20b:5a9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Wed, 10 Jul
 2024 13:52:15 +0000
Received: from AM0PR08MB4289.eurprd08.prod.outlook.com
 ([fe80::507d:582a:b779:1b83]) by AM0PR08MB4289.eurprd08.prod.outlook.com
 ([fe80::507d:582a:b779:1b83%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 13:52:15 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Raymond Mao <raymond.mao@linaro.org>
CC: "trini@konsulko.com" <trini@konsulko.com>, "sjg@chromium.org"
 <sjg@chromium.org>, ilias.apalodimas <ilias.apalodimas@linaro.org>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>, nd <nd@arm.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/1] bloblist: Fix bloblist convention checking.
Thread-Topic: [PATCH v3 1/1] bloblist: Fix bloblist convention checking.
Thread-Index: AQHa0j2KAcpnQ1em+U2bdjLEEREtsLHv+nmAgAABm6k=
Date: Wed, 10 Jul 2024 13:52:14 +0000
Message-ID: <AM0PR08MB4289F384257A66FBD404C31AFBA42@AM0PR08MB4289.eurprd08.prod.outlook.com>
References: <20240709202057.2538776-1-yeoreum.yun@arm.com>
 <CAEfUkULX1Ez=L0p7rZbweTA+V8NRuyiduaPrTaMqkhKW+aTOHw@mail.gmail.com>
In-Reply-To: <CAEfUkULX1Ez=L0p7rZbweTA+V8NRuyiduaPrTaMqkhKW+aTOHw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: AM0PR08MB4289:EE_|AS8PR08MB9362:EE_|AMS0EPF000001A4:EE_|DU0PR08MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d2b50cd-8f8a-4bad-4022-08dca0e78792
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?ZYTPuQti0+XuAVQMssD3L+E1E0kKaWC7rvm/f9ClyktXujEMv8vomh1Y7yUY?=
 =?us-ascii?Q?Kn2d/WlOShhT8HLCQ3fHdErMq48q2gpLDmjli8PY3Mzrubhiv15B98oHgfCM?=
 =?us-ascii?Q?XIYVZukHPZFkoQfqq2g1VNhtQojIdXuDCKXY0oIQMv8aF/LCNiMxW3UtTAoj?=
 =?us-ascii?Q?Cn7f4iE5z4RJxlZ4/b8fW2psI0o/AyPNLm9ySCOyXjqYx0O8pP+mWKCF/XW4?=
 =?us-ascii?Q?IO1bLDgnKVFw1yhFA1grzYCTa3hFM5aWbIc46k4D87OF90+a1fM/JcCwTKvU?=
 =?us-ascii?Q?vxYFKl453r9oFe30kTWGhaZ96vf7ELAiv5P1l8LDLwcFfLpMb+v+V1xpzVLL?=
 =?us-ascii?Q?rQY3Q6rVm5x4QjBXmh70mKDOoO37n2EuGGGYH/IF6smFx+2FWjtlQWkLi9KH?=
 =?us-ascii?Q?9GnRGTeu0l+GNtQ+S5th3HMd683/LSLBX01/2fji14Ypd7rYQ++/FTwe01J2?=
 =?us-ascii?Q?SkPQItKZyF42mk8oGF+8fO8g77nWfqrMatidkJfsfLWjq1/YBMjQmcC11nue?=
 =?us-ascii?Q?fpi/9uwXZ59ixhGZJnDVVIVOpo8K8rUEkc4r2vYHSJlgY5fx2sryPLyIgHkD?=
 =?us-ascii?Q?DKbZHXbqk+Wag57BDBscPtp+nG/2Q4h4sdOKqOdZ3fXZtf5icDMgBz0H4U5J?=
 =?us-ascii?Q?5+cW76doWuIsk6hHwKn5o49orRnRb1vE4l0wlqZ2ADO1ivgZ2X9+nfdAPbJR?=
 =?us-ascii?Q?XXPShZwBSxpImACZSYzK5C9oeIAGjHq3CuUB7oTNmoLGVCX87KkPaHtiumJJ?=
 =?us-ascii?Q?YfwFLJBHkERqDkNEuKFv6lMtGRymQosTgK1AB60d7qOxuwEPBd+mr4UncoQ/?=
 =?us-ascii?Q?uPU88t37fNU6EL+U2YlJG0HrBslhovel5pJTDP6HcTmJxccxjXdeMTJ8ZbrY?=
 =?us-ascii?Q?n9Kd/OUfaSO/W29NNONkJczmWz1eggCxVr1u10WX9/Mwp9apPXzMgmRm1jCb?=
 =?us-ascii?Q?2H5eS5BAAzC4Ld0R/jUpxvGMGdy3k0aYPyDdrDcJbNOe3Gus3aMYrhuzHZEd?=
 =?us-ascii?Q?MFqCcQayZFQUa9QY5flOqF1i0JoqgeDgD02DbbIwMMOYc9pu8GFj3/r7dtt+?=
 =?us-ascii?Q?p+/YZsJG6Wb4a9iY+AT4eIx7o/fgZ6plQydcD7u1VKcYHBttTd9JMTfLfjTb?=
 =?us-ascii?Q?SnGDfmHedh18RTbQH3/Fs4AWkRAJm+WdREMp9zssFy5SDtcKTOrPL1MH363C?=
 =?us-ascii?Q?dYBdOOGfWcJEp2jQyTYYw81wr1EGZTP7MPYCWay78WM8/psa9CJLg3Wc5YGU?=
 =?us-ascii?Q?yiYKTVlISNdenREQWtLYQOxIlfCKh2pJBbjsf6fzAbqb6E42OBaIrSMUi4UH?=
 =?us-ascii?Q?FR0yo0niDlqeoaaZaKdg/B70KsEVUcsAy+paGXrAHanSeRwnenZDMfwuc6Bl?=
 =?us-ascii?Q?WmgahdU=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB4289.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9362
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6717efd7-1a9f-4305-1aad-08dca0e78181
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|35042699022; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qqQDOP6t199EEZ6PGjJPJkrBL2hblxnsK85dtnBRtEMOO68+Jq/nNL5AFQfa?=
 =?us-ascii?Q?7x4y3po62wmpU2pzEFQ29mDzV2A1HiwxbcBVjJnDet+7MuIxQpaYI612Lxdq?=
 =?us-ascii?Q?7TY0/G4ta7ipM3u7f6mHTko77LCW3WR4CJyj1nLlVncCzoR5IDYbUoNJKGdv?=
 =?us-ascii?Q?nEReru09MY7JyhR6i6YEFmpwr9HIvq5oWct9txMBGEEGnvzuwf9a8XgJh85H?=
 =?us-ascii?Q?q5Jeqvue7iBmYzx/rv9G8oiF4pq51hVs2UzHA7AGL4lEGtT5aszb8xu+d8gE?=
 =?us-ascii?Q?W8ZoL6Zr8rJ8pS/lvBWiMe3va3WE9jtyG+1yYKyxKEvlXBfhGpzHc4Pm1WMh?=
 =?us-ascii?Q?p4Rqoc3soYZ8Gizq4YF/2WXeahBZjEkLVjz7XmHRO20QOy0PFWt22HV/pewj?=
 =?us-ascii?Q?I8J267N4jAC2mc+Z5ZMoCQfxX7iJO6L1a2c7TgRYo8n+K4CRxzEs8Qdu7Muk?=
 =?us-ascii?Q?0hPhNT0GPKMBRJDpGmrGxz1C3MtDvzVjj20a+kr6dIH7kp5ZUzbjuO09lR3d?=
 =?us-ascii?Q?BCCfuuemxpBslacJmuwn4CM5cA5xDWgKhElCczEPZ6sK7d30X1Q/sK/xNT/C?=
 =?us-ascii?Q?dyF1NzWe3OvMqfOOb8lIKSyVeL+Uk2zqf06fee9AKU/tMTWg9Zyye6iHIr29?=
 =?us-ascii?Q?ZqXA1MDOhDbS0U0UdQQ20xP/nvfptXuC0rG+/wjHKf6RVU5kIXJQFd7F2pLZ?=
 =?us-ascii?Q?tHevpf0eTVUurG6k2cL1fiWejJb+/DT0nZ0dugg7ZP+wetWyVKxAxd2cwJWr?=
 =?us-ascii?Q?Dulf9UYP84Mu/U+NLIbiUZjZXwO/DmvvnUQWT24LK2il33A3W9v9duSJvbmC?=
 =?us-ascii?Q?5XMDZOvwwZ8ib6u1xHloalrrCVAn9XDGdOboTvO7Jmfg/hLxbDsbXCohhfoq?=
 =?us-ascii?Q?Oa3UQW1EDvJSlOoU1Cq5BFC2NNpPIfIMNa9Q8gdcQ8aSxjv2AFAd63qQEhG/?=
 =?us-ascii?Q?8cYYMLtpK8LW0cm8Sp271xsKnjRnL8zT7BR8xM82THex70br8/3G0CYyyUJ7?=
 =?us-ascii?Q?Y3DGoro6pF7CVpejEd+02JS14TxO+ZJcaWSUniVE82z8JrEskD/+5LGmfLAr?=
 =?us-ascii?Q?pyNITnudAODlJoYnNbzf6KViNI/H2Ctny9kP588QdRIDM294cxhlXvhHmklT?=
 =?us-ascii?Q?Gd9WQYyhzXKD1I3TWFiT5tLLloWgMnBuHdJJZS7pqnOsX+9begluotpMAqwF?=
 =?us-ascii?Q?+qkTUV+3akAZG5rEWdYoRE52VayLJ+6H2Sf3GxaK9Gny+eX9xumE6ynSWWWo?=
 =?us-ascii?Q?PgLWH4frARMdEgzuL10Vk0dZfV2+5pqeLWHQj13ShZzpRFN4E9r//OgPmBL4?=
 =?us-ascii?Q?9hVnip5FHQkyxYINinQ3taw/HCQiLmvHJ+EwDH1ELyRUM9fZ5BVwTdbbwzA0?=
 =?us-ascii?Q?NAB3wbh5Op4wfYRybALf8Pk9s1h5DaHF+FyuNtHsFH76iOfvGQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(35042699022);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 13:52:25.1384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2b50cd-8f8a-4bad-4022-08dca0e78792
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9371
X-Mailman-Approved-At: Wed, 10 Jul 2024 17:33:42 +0200
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

HI. Raymond.

> Please remove the "FIXME" on top of your changes.
> It was a reminder for the bug of the FW handoff spec.
> We don't need it anymore once your patch is merged.

> BTW, you might need to resend the patch with a new
> subject "[PATCH v2 ....]" instead of following the original
> topic when you send a new version.

Thanks for your review. I'll remove the FIXME and resend with v4.

Thanks!

________________________________________
From: Raymond Mao <raymond.mao@linaro.org>
Sent: 10 July 2024 14:45
To: Yeo Reum Yun
Cc: trini@konsulko.com; sjg@chromium.org; ilias.apalodimas; bmeng.cn@gmail.=
com; nd; u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/1] bloblist: Fix bloblist convention checking.

Hi Levi,

On Tue, 9 Jul 2024 at 16:21, Levi Yun <yeoreum.yun@arm.com<mailto:yeoreum.y=
un@arm.com>> wrote:
According to recently firmware handsoff spec [1]'s "Register usage at hando=
ff
boundary", Transfer List's signature value was changed from 0x40_b10b
(3 bytes) to 4a0f_b10b (4 bytes).

As updating of TL's signature, register value of x1/r1 should be:

In aarch32's r1 value should be
    R1[23:0]: set to the TL signature (4a0f_b10b -> masked range value: 0f_=
b10b)
    R1[31:24]: version of the register convention =3D=3D  1

and

In aarch64's x1 value should be
    X1[31:0]: set to the TL signature (4a0f_b10b)
    X1[39:32]: version of the register convention =3D=3D  1
    X1[63:40]: MBZ
(See the [2] and [3]).

This patch fix problems:
   1. breaking X1 value with updated specification in aarch64
        - change of length of signature field.

   2. previous error value set in R1 in arm32.
        - length of signature should be 24, but it uses 32bit signature.

[1] https://github.com/FirmwareHandoff/firmware_handoff
[2] https://github.com/FirmwareHandoff/firmware_handoff/issues/32
[3] https://github.com/FirmwareHandoff/firmware_handoff/commit/5aa7aa1d3a1d=
b75213e458d392b751f0707de027

Signed-off-by: Levi Yun <yeoreum.yun@arm.com<mailto:yeoreum.yun@arm.com>>
---
v3:
  - Restore arch/arm/lib/xferlist.c.

v2:
  - Modify commit message.
  - Remove wrong swaping check in xferlist_from_boot_arg().

 common/bloblist.c  | 11 ++++++++++-
 include/bloblist.h |  5 ++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 11d6422b69..2008ab4d25 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -576,7 +576,16 @@ int bloblist_maybe_init(void)

 int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig)
 {
-       if (rzero || rsig !=3D (BLOBLIST_MAGIC | BLOBLIST_REGCONV_VER) ||
+       ulong version =3D BLOBLIST_REGCONV_VER;
+       ulong sigval;
+
+       sigval =3D (IS_ENABLED(CONFIG_64BIT)) ?
+                       ((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_=
64) - 1)) |
+                        ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_RE=
GCONV_SHIFT_64)) :
+                       ((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_=
32) - 1)) |
+                        ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_RE=
GCONV_SHIFT_32));
+
+       if (rzero || rsig !=3D sigval ||
            rfdt !=3D (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
                gd->bloblist =3D NULL;  /* Reset the gd bloblist pointer */
                return -EIO;
diff --git a/include/bloblist.h b/include/bloblist.h
index 7fbdd622bc..f4849f22a0 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -83,7 +83,10 @@ enum {
         * Register convention version should be placed into a higher byte
         * https://github.com/FirmwareHandoff/firmware_handoff/issues/32
         */
-       BLOBLIST_REGCONV_VER    =3D 1 << 24,
+       BLOBLIST_REGCONV_SHIFT_64 =3D 32,
+       BLOBLIST_REGCONV_SHIFT_32 =3D 24,
+       BLOBLIST_REGCONV_MASK =3D 0xff,
+       BLOBLIST_REGCONV_VER =3D 1,

Please remove the "FIXME" on top of your changes.
It was a reminder for the bug of the FW handoff spec.
We don't need it anymore once your patch is merged.

BTW, you might need to resend the patch with a new
subject "[PATCH v2 ....]" instead of following the original
topic when you send a new version.

Regards,
Raymond
