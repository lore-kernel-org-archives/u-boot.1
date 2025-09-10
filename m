Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2593DCA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 15:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F10948329C;
	Wed, 10 Sep 2025 17:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="oaXTT2eo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37FD48318E; Wed, 10 Sep 2025 17:37:45 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C43B830A0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 17:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H00iNwbUbip2fLrp8OS6MC9Nm7CA4s+ydFLAUzGNo6FHpgmkGNaL0YfhxmNPr16cPGEf2Qihomdg2ouicF5Lr5ucg7W8ZdTP+lmoqnWnfj8jkeQYZ+qluYIiSa6Fin9vrWpcqclwBWxtlDyS82s0DUzWUa+xxTC6UeqamUpy/8HBSAGgHQMyjyWfk1kawEzEePGwZ9QYxyepFhRo3n5a7Pw8Pwy1mIP1tIFWQ79BQvQqkRDTMb7p2aNozaT5cAMDPbJ4GN6BlInOxGZpuxMNtGakGqkErCxtIvhaGRE9b/PFqILcJ5NfEP7AP1v1p0nn1tVLcNOwowlNJJYYL4m5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYSyfK7uzS/iovwgY7dV8jjMJe7gaUCFSeOypF6pffs=;
 b=YeYJrYPJgQYLEAhIUKir/gkx7b/gTPjO8+gmjaZ/117KL5aaJ2c7XOu5lfJCMwq30fYoV+fu2YSQV4txyn2hCN0keVNoHTLQLjK6dCOkOofWM+A6XnLDIQ7QRNhd5i4hmTXI8IAoWa/57tuiVWONpq9geUEF4ySk8AJWZH9XWs2/z3pCvLPBR6ZUOfFa4DIISU3Qp4KFSeQ79kOVfC4T5kreiSPSrTbZhDvPMdsebLxeMh9vHOCDLso0TNFtJxKWZM3ZesXogCfFFsR8ZzfkyMxTvKs5muN8p2HcIfIZHI+OaCZvtNKXxKMdwgqZBv7GpRwJAtyfkbhZfTrZ5NXFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYSyfK7uzS/iovwgY7dV8jjMJe7gaUCFSeOypF6pffs=;
 b=oaXTT2eoLsFYDrHijn+DyYTlHUyRWyglSA+/LEGe6aCkB6/5f9r2a9YCqMMI0lFU7Yn+4TmhNILyGJtQmPQkwCHJ7kJATQE56P4bYzUA0DtmSn/Nsmjif4o6mShgrClpD4xATMMUBUJc7IkgRhul/b9xXrXcSfSH+Ukv14RotAWGnusP4bCR3JZuIUYALd257n1DyFjt8eD62PyLgGocDsLxRITxAdKCYSPsgHvWR4WDyYmZiO1C5YKDQzOJKjqbdURAgSLnU3EBerpoiRQLIV5bxD9ttgZorH5as4IHBrUUkUi/YaDqLjBvzG03Fg8usDomeQdQRRzA3Jgg6pCRnw==
Received: from AM0PR07CA0021.eurprd07.prod.outlook.com (2603:10a6:208:ac::34)
 by DBAPR05MB6919.eurprd05.prod.outlook.com (2603:10a6:10:18c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 15:37:40 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com (2603:10a6:208:ac::4)
 by AM0PR07CA0021.outlook.office365.com (2603:10a6:208:ac::34) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.6
 via Frontend Transport; Wed, 10 Sep 2025 15:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 15:37:40 +0000
Received: from OSPPR02CU001.outbound.protection.outlook.com (40.93.81.78) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Wed, 10 Sep 2025 15:37:39 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com (2603:10a6:6:4a::24) by
 GVXPR05MB10882.eurprd05.prod.outlook.com (2603:10a6:150:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 15:37:35 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53]) by DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53%4]) with mapi id 15.20.9052.019; Wed, 10 Sep 2025
 15:37:35 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "jerome.forissier@linaro.org" <jerome.forissier@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>
Subject: Re: [PATCH 1/1] board: ti: am335x: Do not call disabled PMIC functions
Thread-Topic: [PATCH 1/1] board: ti: am335x: Do not call disabled PMIC
 functions
Thread-Index: AQHcINmJWmfe7YqAm0qbuGfL+fh/urSJfcUAgAFCz6uAACh5AIAAA7OAgAEoqkc=
Date: Wed, 10 Sep 2025 15:37:35 +0000
Message-ID: <DB6PR05MB45511513B880348BFDA2CB77830EA@DB6PR05MB4551.eurprd05.prod.outlook.com>
References: <DB6PR05MB4551D31271569EC04E8EC60F830CA@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250908184342.7ec9500b@kmaincent-XPS-13-7390>
 <DB6PR05MB45516C241486780C8D198FCD830FA@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250909162356.6ff75133@kmaincent-XPS-13-7390>
 <20250909143711.GV124814@bill-the-cat>
In-Reply-To: <20250909143711.GV124814@bill-the-cat>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: DB6PR05MB4551:EE_|GVXPR05MB10882:EE_|AM3PEPF0000A79A:EE_|DBAPR05MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e121af-b3f3-453c-4643-08ddf07ff9e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?iso-8859-1?Q?UnhbUuJRMBcM2IBZ9RnyqYZyzeb0pZPNYmbwtlPR/rcnMs9/uLNFEl5u9F?=
 =?iso-8859-1?Q?VQYA09QZ2rf2WFWgkX6voy4tAeq6h1te1ACPCURKzOO2CEH9if8sToip3K?=
 =?iso-8859-1?Q?66YGd0775/tIg2KSPBtovZps95o2tCCvcZy74GGGX66pfLSTLDOCapP69Z?=
 =?iso-8859-1?Q?BtemUrylMhhMQvN5crHzejNs7QuiQzGluYRsYrZ7ukp6FW5R8v8AKEmfph?=
 =?iso-8859-1?Q?fWk+CwvZs1LSNVESoPKASta30N3QK3I65GZEG6Z99mHnEGMNKkMUJAoFGh?=
 =?iso-8859-1?Q?MAgca1QOtlWt44iDnrRXfc38Ff/8ADNw5tEW9xsRwtbFPbVSSiyRi0r4jn?=
 =?iso-8859-1?Q?HOqnIfplOBcoIJDm4Z5Zh6rB5nzYYZ+rfMSbnVLVN4AwrxbR3W9MDEbzjJ?=
 =?iso-8859-1?Q?ERGKJlA/Yu4kAzEw/wsoveE1lA4hETG+5gfZGVNlplLfKA38H7DiIRw06N?=
 =?iso-8859-1?Q?5SBCGp6KOWKYPvDjy/WSDzoaKQWpNS8XR77yWp9OnhynA5LRmrzlS7Z43C?=
 =?iso-8859-1?Q?37yPR3qguTYd14GtNAvmfkMgd9jFsDY04wpQ9qOG8wz3xe39dqjvfCjX1u?=
 =?iso-8859-1?Q?TP85GITMDb6s2UjMaG7vbkiYtgEHFve9B/y4LkIzmMcW/divhXkrWAuBEV?=
 =?iso-8859-1?Q?lvV2jArcMMf4cwFmdyizI9ymWScI4taz7XOWzQ+g2wPrxQJ4JksQife1fj?=
 =?iso-8859-1?Q?mUFivHhcbHxy1CfWX45T+tQ07thcXIi5fYfu9yg0SMsnsn1YpjQYW4Ua2s?=
 =?iso-8859-1?Q?Y8fw4Y8O/iVAk6p7ozn3ghmdDSW5kpWwZTINQt/+qWm/lYQE/vfvsQHUe9?=
 =?iso-8859-1?Q?rZjxoPOMsg5dyBljjL45e7heHaFewDFzgMY6YMNtfoTXMoBObdolhkj1HX?=
 =?iso-8859-1?Q?fSMISdPb1HatYmYTPrVABMXVSerNNO6wMScll77aJJHejqeWBBSrDUS6nT?=
 =?iso-8859-1?Q?g8NoQjV879+kHOloVff/j5EuZS6orbj2IFZIRmSmG0PvbRoqxhdXkRfau+?=
 =?iso-8859-1?Q?N23MQhgktM5AsjEMZ7iEXJkp0s8zEKjKSWN601t9/4l53JodbeHsE1FlF6?=
 =?iso-8859-1?Q?199l7S6j1Du9Dou+kqwjcDsJAhu5H67GKBzQQGnk/7oPJKQrjqtGzyG+wy?=
 =?iso-8859-1?Q?mGJcExEJpjR+/d26Yx5phPbz+ZzcgZxs+7DIGEJb8gaVwBPgmZ9D9cFfVY?=
 =?iso-8859-1?Q?WkkFxxyy8bJNrNaFbICqngaY5xdmM0tinfhG2IlM7AxQZ6QmxiR3OZeEAU?=
 =?iso-8859-1?Q?PCSVbYCae3/bCr7lbxz89kghPZBEgZh7r+YYGkqwh7GOVBqS2wsPlya6SE?=
 =?iso-8859-1?Q?M47PYhTMmFzabwPmR4zdsJo0AumjIIBgWnW9eJ5bpF+fHMpxBS4MO49X8M?=
 =?iso-8859-1?Q?OyGLKbSvS9389snbDIPu+dGqgUFlkPQk+f1EiNYUB3rP0lv7fi/uQMkwwb?=
 =?iso-8859-1?Q?t2FZe1oqg0svoEkHSRgZ0vtRKYVQxggdoccCZQ/BC3I+Hg82U6WVrJ6VuA?=
 =?iso-8859-1?Q?6fNUG9d8Ppqg6ifCSw6xqECovfkNjm/s5L8W5SD5LH00FxkJl7osGxgIrL?=
 =?iso-8859-1?Q?rgmdw0A=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB6PR05MB4551.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR05MB10882
X-CodeTwo-MessageID: 9311f659-5ac3-4c0e-98f5-d4ce99ec1de8.20250910153739@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6e796997-df93-4bc7-33bc-08ddf07ff6f3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|14060799003|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?jTt7YR21EkPV54kPciYKKYvA0MaQWNY8N5jFjp3dRUZr1AwV+1uwnlfuhB?=
 =?iso-8859-1?Q?jtUrmUO9quvFLeFk6+KEcRyNhULaQ8z8Ro8aChikywisLC4VVydmtLU8C/?=
 =?iso-8859-1?Q?EdOOX17CMiQj+ffjxXvZDWv8n+Ss+qrmV9sC0FqSh5D57iFFgDgDIwcafY?=
 =?iso-8859-1?Q?bJRSR39zkLZvgxLzqVfqMN4jXnckIELgPgyyv6EphwTSle0er76Sf1Pxdo?=
 =?iso-8859-1?Q?oHYpAMEhF79ftBOjZIr1EMijDEH7dUKmv0ul/oFTf5eR4MaA/pS9UdHmHE?=
 =?iso-8859-1?Q?OXznPMJ89jg+s+myTGbm+5Vv3VhiA3vFYMs+8LZ2njUjlkomqbBfQPRAXH?=
 =?iso-8859-1?Q?Nia/0c6DbHFBQVZM19jfK6HxhGQUV48xT5DjFDizmuEj0wp+TZ7q23cwTI?=
 =?iso-8859-1?Q?+gT27ldPs6Fc6aMAptIdtVDoHch5hgFgYCn3iBWpSrLNVivN33m71eD27c?=
 =?iso-8859-1?Q?MJHDkilLsb3hTKNh4zTQZtjuwx9dILIrRaDwCQ4eWVF6lvLQMstk3ESpd2?=
 =?iso-8859-1?Q?11b7UAw055DPa68DeWVyXLnAWi8h0rKdxupfucXziZFw4U+5ZOaizGeLFw?=
 =?iso-8859-1?Q?5abgaA2HP22+I1pPX0YOw8gO5b+tmFMimgO4ZWyV+YgRud1g/xm7F+GpxB?=
 =?iso-8859-1?Q?vlQM5Mbb95MPREsYqVLvGRW4rOYJOSaLkHNUZIDwF7Dxyxcssx3KZ39ZUI?=
 =?iso-8859-1?Q?ftCd2/m24tDs4H4rQq8KrYbN8NfI/5xAE2YLqNhFw1aEKj7yiAdvkIeafa?=
 =?iso-8859-1?Q?YgcErdLgLScMS0XMnJdjHUP7tOM7H1IoNgEq0NvGvN0yu0agAs6Nfu8Yeh?=
 =?iso-8859-1?Q?WBu7cXVmzIS6PLyscYmRygVLChQuPcsZynKNkG9g1x7/5WPo0UGju8V7HE?=
 =?iso-8859-1?Q?9FKXYW4GkNdlFezQFdrphtJqSlQ6VZvcDv4ZKEdmlu2ITIsn1fda7INX/f?=
 =?iso-8859-1?Q?2HgKa0XYV/eIcvRRbBgMdwRFWiszVw3Bs1q0CuQFuRgub2R0GqjWjfgR8R?=
 =?iso-8859-1?Q?PfVKEs7k7kSI1RQa+QULTaq4M9EsKmGFoA8Y6Nn4keiQzx636NKi7duj3E?=
 =?iso-8859-1?Q?mEJB/NFxvwghCQGqkjtAALQU+sdPb7g1Gd2VhtE4nzHY9bdDY+iWMXCuu/?=
 =?iso-8859-1?Q?PlcfkJTSoZZ7dcwaK26Mekmf2rOXz/9pkj9WzYMLnWKd3xvScDHyorbBrF?=
 =?iso-8859-1?Q?D5JoF+BZuhrO/ZTWxmPI5c9rr3iIH2mNUmAhaZT9aCFqhydctn9/lyeaeN?=
 =?iso-8859-1?Q?f70//v7UjaRPgsOho3srSqPB+aE9Getze68NngOVdroewvqI4zhQKW7K/u?=
 =?iso-8859-1?Q?uTu6GHUfainBCyGeJfd7XEcJ582ATTtnIg38VZ5cDWHRLifrl3GPeNYVp3?=
 =?iso-8859-1?Q?ApeCNhmKjSZSuazWWWiji7KvozGnx+YaN3+VBg5B52UkkGq9uuHZW1HcS4?=
 =?iso-8859-1?Q?nidL/cLYHu4aApkjEOjQonvBdgYbMFybdRihB1Qx2ts7H7HTYenGtpzdhx?=
 =?iso-8859-1?Q?K0XCUtl+4I5kDvbgWsL0+to7Vl5yiJLRNRrJYU3AO6fxy7/wuhSOaUw18F?=
 =?iso-8859-1?Q?Iu4i4JOH2WIYUc/Pep3V80ppEo3+?=
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(35042699022)(14060799003)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:37:40.0447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e121af-b3f3-453c-4643-08ddf07ff9e7
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR05MB6919
X-Mailman-Approved-At: Wed, 10 Sep 2025 17:57:30 +0200
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

> From: Tom Rini=0A=
> =0A=
> On Tue, Sep 09, 2025 at 04:23:56PM +0200, Kory Maincent wrote:=0A=
> > On Tue, 9 Sep 2025 12:45:10 +0000=0A=
> > Maarten Brock <Maarten.Brock@sttls.nl> wrote:=0A=
> >=0A=
> > > > From: Kory Maincent <kory.maincent@bootlin.com>=0A=
> > > >=0A=
> > > > On Mon, 8 Sep 2025 16:05:04 +0000=0A=
> > > > Maarten Brock <Maarten.Brock@sttls.nl> wrote:=0A=
> > > >=0A=
> > > > > When PMIC drivers are disabled their functions should not be call=
ed.=0A=
> > > > >=0A=
> > > > > Signed-off-by: Maarten Brock <maarten.brock@sttls.nl>=0A=
> > > >=0A=
> > > When a board is using a certain PMIC it should be possible to deselec=
t=0A=
> > > all other PMICs that are not present. There is no point in keeping un=
used=0A=
> > > code in the binary. Isn't that the whole idea of the configuration?=
=0A=
> > > The current situation gives a build failure when the unused PMIC is=
=0A=
> > > deselected.=0A=
> > >=0A=
> > > This file board/ti/am335x/board.c gives the impression to be useable =
for=0A=
> > > all AM335X based boards, including those yet unknown. What if a board=
=0A=
> > > does not need any PMIC configuration, because the default strapped co=
nfig=0A=
> > > is enough, does one still need to drag those drivers along?=0A=
> >=0A=
> > Indeed, I hadn't understood that you would face a build error as the PM=
IC=0A=
> > functions are not defined if we disable PMIC configs.=0A=
> >=0A=
> > I think the first issue is the design of this board.c file, but, well i=
t is=0A=
> > U-boot typical design.=0A=
> > And scale_vcores_generic() is not a generic function at all ...=0A=
> >=0A=
> > Ok, your change are legit after all.=0A=
> =0A=
> A thing to keep in mind is that am335x_evm is intended for the TI EVM=0A=
> family of boards and look-alikes (so all of the beagles which are=0A=
> kinda-sorta TI EVMs depending on when you asked someone).=0A=
=0A=
TI and U-boot give the impression that this file could be used as a templat=
e=0A=
for any AM335x based board. That it produces build failures as soon as you=
=0A=
modify some configuration contradicts that IMHO.=0A=
=0A=
The same goes for my recent patch about NO_NET and not providing=0A=
ft_board_setup(). That also results in an unexpected build failure.=0A=
=0A=
Kind Regards,=0A=
Maarten Brock=0A=
