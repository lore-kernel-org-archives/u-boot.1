Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AD6CA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 13:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03066838B7;
	Fri,  5 Sep 2025 15:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="m09xmciQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C05B7836D1; Fri,  5 Sep 2025 15:14:43 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8768E835EA
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 15:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUpqzbM7go8DRCeNaqBHdLZEv9/F3PJUSSaEhAoQ02rSPiYZK5Omitae6rVw4Aqw8/UVc15KGzrx1x/PoD914vLFyEeCS23UTL6rQwnicinBo/abn1zn+SwHQWbFAeoV8Us5HouZOo2dG+jixP19Jdf18h2GXonWb8SAaK11P/gvFs4foIek0ATUHLs+IAfSgoMn7gAx4Vr4S6eAuHOUm5j+h/AX8Oe0KhMQzF7C1s+78gSqU5isOugJEPpCnWZDtVZktbPVOS/sXSGG8YD0SFBBextAbI0sa9xHluAy3nD2beVUy8Mv7/qkQkVrhFCyBimdbZvzI9Ctu3IJ4Tuobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RD8ESfYDWUwQRmmwK3y8iSoY2s2teJ2lke+kikfxtnE=;
 b=bA9ZBC3Aan+C0HbNu5MgBGKv1ftzr3jdJkRDDSKGv0oeqE1PCUEiGNSa96XX5AS8BB8ATAVIC4fEeqnzLRWBZzRhkBrMi0ehBFEQv5TJlC+xyV9xMvW/G8e7gpMvq2UBs5o/6IL8jwaB1gxrHdt0TczezMGD/FQsfO+0j3Xld+qWBl3+PQUn5uqrEhoOi89ldAhEfygmhQs66pOpLDHajSSEF1ve11qGscWkWrtICCuyUeMun+G6hfHj/p3XlUVc4FoEjf8vxAo9yu93RSD24u1W54ylTe4ZV7fFvYv8xNvTHXU38Lu6ZTgPXh3Z4LfbAhUxrr6sBxayIV8ifgG1Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RD8ESfYDWUwQRmmwK3y8iSoY2s2teJ2lke+kikfxtnE=;
 b=m09xmciQE2YCZrsoJ4+u7uVB8ARn5A30E9cQC8uxsk4TdCFPuLjeF/6OCop5MWpElhEcVO+KE2bLgOVd8RNFRL9kKIpKTrvxuDrwR87eL7zNxSj+kgNnxGxq6tjb1GXzKBjYB+kUJ8hdCf26JEXKvjbESKZLccwGqIv3tEUv1wT35p94R6sUGGMMZ9JzsyHs3TWERW/+kSLIBorP3cuZd8WO5aRd4hBFmGZtCybRLnGMb/WZjwKbKCyGNi3aJR8giyTNdE86VEgWyJeu3bioxo45j5l0hTamKv/7vwV/YVKOaTLcP0VKkUHxbb3RNPgCnYkSvBzlztKKzs9N7zmAQw==
Received: from AM4PR0302CA0028.eurprd03.prod.outlook.com (2603:10a6:205:2::41)
 by AM9PR05MB8434.eurprd05.prod.outlook.com (2603:10a6:20b:3a0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 13:14:38 +0000
Received: from AMS0EPF000001AD.eurprd05.prod.outlook.com
 (2603:10a6:205:2:cafe::cb) by AM4PR0302CA0028.outlook.office365.com
 (2603:10a6:205:2::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.20 via Frontend Transport; Fri,
 5 Sep 2025 13:14:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AMS0EPF000001AD.mail.protection.outlook.com (10.167.16.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 13:14:38 +0000
Received: from DUZPR83CU001.outbound.protection.outlook.com (40.93.64.11) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Fri, 05 Sep 2025 13:14:38 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com (2603:10a6:6:4a::24) by
 DB9PR05MB9779.eurprd05.prod.outlook.com (2603:10a6:10:3dd::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Fri, 5 Sep 2025 13:14:36 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53]) by DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53%4]) with mapi id 15.20.9052.019; Fri, 5 Sep 2025
 13:14:36 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Kory Maincent <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] ti: Do not try to read the mac address if no NET is
 enabled
Thread-Topic: [PATCH 1/2] ti: Do not try to read the mac address if no NET is
 enabled
Thread-Index: AQHcG22hCAVY5zgda0u9d/sotbL/vbSElRIY
Date: Fri, 5 Sep 2025 13:14:36 +0000
Message-ID: <DB6PR05MB4551733BAB639F21D54919FB8303A@DB6PR05MB4551.eurprd05.prod.outlook.com>
References: <DB6PR05MB45518EE72CE8B05405F3439A8307A@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250901182409.GC124814@bill-the-cat>
In-Reply-To: <20250901182409.GC124814@bill-the-cat>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: DB6PR05MB4551:EE_|DB9PR05MB9779:EE_|AMS0EPF000001AD:EE_|AM9PR05MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: f53ab173-35a4-406f-ff05-08ddec7e2af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?iso-8859-1?Q?EwFOBEAOeKcJjGyFrkDljvuW00vfqWbJ7jW++/u7J03KO98gaxshtkZG3H?=
 =?iso-8859-1?Q?gM15GXDz9VqsUXigjmTXerd9oVslEjyCZvSXVityThDOGBR68QN7xBO8nB?=
 =?iso-8859-1?Q?dE+9Px8fLszgVxSvCUxMKh02OS3AmGTf+6z5UJP/ERiQpCAGlwXNuTX84U?=
 =?iso-8859-1?Q?mBSvJO1Qw/pKJPiZxuA1lFgbvSXoB7iapqpSYrt+4oibTsMTstomemkyvY?=
 =?iso-8859-1?Q?jUb8sojBQVDPIPzaJCavZjWFVi9BqmXZ4qo0DtUZwlCyQRrRjMOlnGlGjp?=
 =?iso-8859-1?Q?moPoUOfH+JPUS5BdBFKlF8JsOoiw35Gc97e6E2wUwMlr5l/P/tXseqN40q?=
 =?iso-8859-1?Q?CavidJfXgXCGYX6s1lyvYX3xn6igffUkB1k2xVhvdeV91k7B7n/BgEXv1R?=
 =?iso-8859-1?Q?1Ut8eOjpDmLEzr5+3818BVNuE6pY5QfT/FKee7K2iy9sg3dDzwtFDIoFCn?=
 =?iso-8859-1?Q?Rji7BTl03pUXJxTza9fSjSmS3UjKGVbGZutPqd9OkjSeCDUQrO/TgOAZmK?=
 =?iso-8859-1?Q?4Z35WBRRI0CycdpNwyuACcsiXPn6sY6Pl9g5+H/U4xH2Xy+OWX6E9ImHzz?=
 =?iso-8859-1?Q?/BhDskDHVvKI7zNvjyjqFCcXYa4J1Lfu3rQURx91uIOQtWp6neF38gJCma?=
 =?iso-8859-1?Q?9WB4LwsMbiSbibPUDwNVo7aKpqrOb39XRzNlmT+ys6Dhb1jQSmQL2a09ak?=
 =?iso-8859-1?Q?yUmkRh4XF8sRumGXmUxW1UXyAtCAcIUxUwXV1J5kdQ3Lm4jQnWCtiFxbtZ?=
 =?iso-8859-1?Q?82n/Nplq+fme1/uQfxPOcncBa5wtq+home7KhwflKv4jZB4h5frF2yvGEe?=
 =?iso-8859-1?Q?lOtWr/Jo0vRLsYMVAocu9MqxUwZJmRht328uOyIFSbJ9u0r9Tzz433yazv?=
 =?iso-8859-1?Q?Ye2kgwjff+9cKIrIuy4YcRG8H+GAxsDJAeUWOkcjwoV6P76eFllCWwOVp4?=
 =?iso-8859-1?Q?L4/HnOy4rM9kYoDs/j04nxUvsQHDU5O1fcB6UbPseyAZwB/F/7GUIjjGug?=
 =?iso-8859-1?Q?6j+xK4cfXUbX8RsAIle8y3L4mZAM040Qi66A3KF2/4ERDPogVLaY38w2jQ?=
 =?iso-8859-1?Q?Mq1ZKkDdm1NClIs14MctKnsGYan8Qp131jV7X6BiongdQYLdcIZs9kP03k?=
 =?iso-8859-1?Q?F87hWMPsVGXbpNhMMDdORTuCls8NWoDniFVovrXzn4Hx0Ngx/hywzIzwbI?=
 =?iso-8859-1?Q?DRzXM0y5SUy1iY5K3AwyxzGk5/izfXxhlNIFx/2P1zg0axbkUy+/uwzcvq?=
 =?iso-8859-1?Q?JDB6c7wCdfn8PTOS7WBpOgEYJQyfU0L3bc/gVIk8bbId1Gcn5fIHtnaiW7?=
 =?iso-8859-1?Q?pyRhqy9mvVNfKWbbBL1+t+ND58yyrwNmomdpWhnBN3F/ao5B0j7w2/GehI?=
 =?iso-8859-1?Q?6faF6Bob6uY6IdjPAAiHQQwnBaftlRiNTuAFOEz2jyu+LFuWPlqqvxIfAE?=
 =?iso-8859-1?Q?hptZWW/o/++aj7Dk+z+xfS16Zcpdpn4kSQqwvQdx1JbiVXACT8XHGeb5LV?=
 =?iso-8859-1?Q?ofRxLzd5Q3dmUqFlarucjA2NjfP0bgg17Q0XP8D9j8Rw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB6PR05MB4551.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB9779
X-CodeTwo-MessageID: b08fb306-0b42-49fb-aa27-ddf25f08e683.20250905131438@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001AD.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7412f659-5223-4af8-9a89-08ddec7e2982
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|82310400026|36860700013|376014|14060799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?nx3zSWFfYPB+X3OK/32YdHzmvfoNtntpN4IyMKaAlVYy7KXxbLyoDLS8mU?=
 =?iso-8859-1?Q?7NVGhzw4UEgC/JiOF+2tJrB8jmMpTo+Z9db1Su52dGe7VNu3FOZiVAH/7S?=
 =?iso-8859-1?Q?xdiqyDg3uxW+inw1vYVgvddzp0ap8ao0dO/xrgkW2tN5AGyfgYlqb2OoiM?=
 =?iso-8859-1?Q?PKLmKN94xtlQwgkRm7bY9S8PwSe7cvWQg3A7t+yRF8CTfkbWQk5Lq/qPD+?=
 =?iso-8859-1?Q?ubMCWjPMSJ+71q1iQK0A4Vm6zAFdKvLZ4UhZpz74BPfYCncFs1ANB3/LDF?=
 =?iso-8859-1?Q?prZr33y/eSnsEpOvDhLfjNkjEcj31kBBB67lBxpy1j3Er1hgQNO40YoYX0?=
 =?iso-8859-1?Q?OCmTcob+KW9t15ZQJunj+3c6PaVSchoUMymzsTkG54GsX6LeK6gk9Bq5cV?=
 =?iso-8859-1?Q?QvVtLWcElvH9cgUbeOHSxcQLjjpCMyDCxUpy2ya+Eyz/9201RIxClIkyQb?=
 =?iso-8859-1?Q?q5uICiT+uhcATAwhMXKmTZDBtSbSFBtCwcOxXkWQwZJ2Ui48STbSHDmUOh?=
 =?iso-8859-1?Q?wZaPDDv6REONIOkaJqJYyTp6SJUIFlgI5FG0MREW4bQqGf8rL6hJpT+4K+?=
 =?iso-8859-1?Q?wzY6tvU2z30Pwyu8JnQ/N4T3JcfgRubp5HR/GA0SsBMpNpVeUN6tmVZ2LA?=
 =?iso-8859-1?Q?Ndk8T3fZdtP1pm/hKz4OSiHVKfW0ItStVSlwSiKSISSK/vOP7dlPF5HYBh?=
 =?iso-8859-1?Q?r31YKXeG9jhB5WGHrcje5mLSzDpgir8XgFjV9DEcUsfKtBjDwJhJmC4niB?=
 =?iso-8859-1?Q?PY5VvKgiWvGrsAAHUPymSe+1RBDASoe6OMof/tc+E7hs18y5ewjHufd2nQ?=
 =?iso-8859-1?Q?jljQjxlDwvDlVjMUOhq179z8HBVO2AjJF6j1PK+BgBitdcqAAV0IOEwGLs?=
 =?iso-8859-1?Q?wWEoE7xSFcYUTIyzAyKni3pnFFoaFvwigUUnLPTPSvLGHLLuc8s+raPz8+?=
 =?iso-8859-1?Q?gK7z6loYSDPJGGcFDEW7LsXsAh+qh0uNkqrbtc322gnchcHvht3LE1W5VL?=
 =?iso-8859-1?Q?WogqB6IckvFBENlTvfs9vTJWywnY8Q/CZDYBc63TfCxTuUePeNVMLDGCsP?=
 =?iso-8859-1?Q?xMi1AiEiCeTWzcsEHEgbji/HxZ9ppSsq9fy6IyTRnVl0D9sS6HcTC8O2GT?=
 =?iso-8859-1?Q?cXLYgtO/d+/YSyNZdV5MwtenWUDQa5Ir5pND1+qnmaA5sRvdUKCU4SmUeb?=
 =?iso-8859-1?Q?WE4fZ44CcFg+E8HMHRGXFlOtO7ELFZOSG0gcCDEOgIdTQhi4pG6FyZgdTz?=
 =?iso-8859-1?Q?zSHZDL0xJ36IsLT2RkgxYhyxpmQWanBg9/ok0JGOyp+SJtzeNvo2auyW/Q?=
 =?iso-8859-1?Q?yoocO/muwuKjfWngY2IZyV8I+1kMcJIFfUJgMbkHmWlxOhJQ7RGtw+Ldfd?=
 =?iso-8859-1?Q?c4LTfeurPsI8ke/gAeFYK8nAiIXorGkJcB1BXmMi3BCO4pzdUpoyFxLgKo?=
 =?iso-8859-1?Q?OsqpKKiQc4fuXR+V2manYDsV7S0/f27PFq99uQokIVCFv7N49LvJm+5tJf?=
 =?iso-8859-1?Q?iW7LGqLWodqfmJzvkCehG8emlNUR0BNHQEi9IPpp2tHTHIsG4fJ7E5lxmp?=
 =?iso-8859-1?Q?BBT7hLdI3nUco2LwOuJXutAySNEG?=
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(35042699022)(82310400026)(36860700013)(376014)(14060799003)(1800799024);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 13:14:38.6891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f53ab173-35a4-406f-ff05-08ddec7e2af3
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AD.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR05MB8434
X-Mailman-Approved-At: Fri, 05 Sep 2025 15:45:34 +0200
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
> On Mon, Sep 01, 2025 at 04:06:04PM +0000, Maarten Brock wrote:=0A=
> =0A=
> > It is pointless to fetch the mac address if it will never be used.=0A=
> >=0A=
> > Signed-off-by: Maarten Brock <maarten.brock@sttls.nl>=0A=
> > ---=0A=
> >=0A=
> >  board/ti/am335x/board.c | 72 ++++++++++++++++++++---------------------=
=0A=
> >  1 file changed, 36 insertions(+), 36 deletions(-)=0A=
> =0A=
> The problem with doing this is I believe that we pass this information=0A=
> on to the linux kernel, which at least in the past has assumed it would=
=0A=
> be provided correctly by us, even if U-Boot didn't use the networking.=0A=
> These fuses will always be populated so it's not a problem to be reading=
=0A=
> them.=0A=
> =0A=
> --=0A=
> Tom=0A=
=0A=
This is not what I see happening. Linux can detect the MAC address by=0A=
itself. I've replaced the actual mac address below by *'s, but verified it=
=0A=
is exactly the same as found at 0x44E10630.=0A=
=0A=
[    1.444956] cpsw-switch 4a100000.switch: initialized cpsw ale version 1.=
4=0A=
[    1.444998] cpsw-switch 4a100000.switch: ALE Table size 1024=0A=
[    1.445125] cpsw-switch 4a100000.switch: cpts: overflow check period 500=
0 (jiffies)=0A=
[    1.445146] cpsw-switch 4a100000.switch: CPTS: ref_clk_freq:250000000 ca=
lc_mult:2147483648 calc_shift:29 error:0 nsec/sec=0A=
[    1.445215] cpsw-switch 4a100000.switch: Detected MACID =3D **:**:**:**:=
**:**=0A=
[    1.487205] cpsw-switch 4a100000.switch: initialized (regs 0x4a100000, p=
ool size 256) hw_ver:0019010C 1.12 (0)=0A=
=0A=
Kind Regards,=0A=
Maarten=0A=
