Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B358BCA1016
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 19:42:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CA2A8312A;
	Mon,  8 Sep 2025 21:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="friF/B+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB2EB82E34; Mon,  8 Sep 2025 18:05:12 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76EB982C84
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 18:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJ0h0+gBZHvnP46o3TFZhZWel/53+FnBMATUVO7vsgTg6o2hI9uKvt6iausj+oXEGUAp30VL8dsU8Sobw4L0hoTx15q3eYFb+xop5JPNakWuMqlx/epLurYqKMHVtcsYABrQg9lhez+GAVlo2sRJRRYyIflpBwT5F44DQjN2yr4zfbL4gDS9WmNtJ6wMTDzqPlRWsVk1/IbcZe+AQyfFPUi+cfpPHOr1QeUcGQ2XAC0NZP+zrVf7mnkUcA2Njvan2kkexa0jLoMnnSSoheY+jytpbyGp9jUBDbEpYOP3q1Y3HHhoyo2WwKxjbk1a/nr/9GOofPiK+p/UZbSOwnMPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OixQAighS8Xb7j6GwXRtKUVGTgRoSEAbGOtWtP3OuSY=;
 b=BopK8py7ArzN3LLVNyYge/360TRh/nbLLztyDMqxQrmnPOMRPqIVn11vSqXrDQj7I9zBDJOJJlD0VGFmr2KVGkSJJxh4STE5zVpzFTFHgm5a2M9jgVuZ9HInawxsb4kWumqTNZseLYUTn8CZaS5GbjUl5oYhFGJn1Qg4VXFbCXud4MPaUW8x4Er6xhPuyRt+XNJon4InZL2kGMxMlxl5JbIhN+FN+tJY5iRxiOVgz7FWSID/NLy5g4GlVrCeM4RSeq4Do43fLcSydnZXSTEw3hUbXGXotoXuvPV8szV8IoQdRv0kSB9gqxOEd0u3wlEy/jAM7t7HmhITwxlVU+KOjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OixQAighS8Xb7j6GwXRtKUVGTgRoSEAbGOtWtP3OuSY=;
 b=friF/B+1Iz8JL8EkshgnJNyWVblXBnyYPjwsfiV/e4MI8R50EgbW5I3rNT3SKyrGFPDvTfUbfSMOXCFQKg7p0fdWJ/xz1aMy6km4iLkbTx6UdWXUSjvVvadf0i0kagg+kSd/xuQYKjoNhA8DZoanuFxk7NSuT0rqCJl39XUwIBxSHCyQVk04TlyAluV/FWAzOy+QVkMhtUD5d6p8ENfkz09Bs1+/RZDFFtsxOlOJxxoTd+C9NWYv4acxUtogTvRrghcHD3wXVTNbWnLv3gSJIqOfGW57e8YX8w8L5nHcTfOQZUwbC7JwWNtRivR21SEmvaziN3k1K6rHU/uxwS1YNQ==
Received: from DUZPR01CA0221.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::28) by DB9PR05MB8202.eurprd05.prod.outlook.com
 (2603:10a6:10:258::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 16:05:07 +0000
Received: from DB1PEPF0003922D.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::ac) by DUZPR01CA0221.outlook.office365.com
 (2603:10a6:10:4b4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 16:05:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB1PEPF0003922D.mail.protection.outlook.com (10.167.8.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 16:05:06 +0000
Received: from DB3PR0202CU003.outbound.protection.outlook.com (40.93.64.3) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Mon, 08 Sep 2025 16:05:05 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com (2603:10a6:6:4a::24) by
 AM0PR05MB6642.eurprd05.prod.outlook.com (2603:10a6:20b:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 16:05:04 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53]) by DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53%4]) with mapi id 15.20.9052.019; Mon, 8 Sep 2025
 16:05:04 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "jerome.forissier@linaro.org" <jerome.forissier@linaro.org>, Kory Maincent
 <kory.maincent@bootlin.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "trini@konsulko.com" <trini@konsulko.com>, Maarten Brock
 <Maarten.Brock@sttls.nl>
Subject: [PATCH 1/1] board: ti: am335x: Do not call disabled PMIC functions
Thread-Topic: [PATCH 1/1] board: ti: am335x: Do not call disabled PMIC
 functions
Thread-Index: AQHcINmJWmfe7YqAm0qbuGfL+fh/ug==
Date: Mon, 8 Sep 2025 16:05:04 +0000
Message-ID: <DB6PR05MB4551D31271569EC04E8EC60F830CA@DB6PR05MB4551.eurprd05.prod.outlook.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: DB6PR05MB4551:EE_|AM0PR05MB6642:EE_|DB1PEPF0003922D:EE_|DB9PR05MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a2d8e2-4568-4570-2369-08ddeef17a93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?iso-8859-1?Q?ssFFEJwiIvTWPjC+JzX9wgVb2sNdSvkmG1flp3m6J4BKpY4w2nj2gw6B/e?=
 =?iso-8859-1?Q?HFDXY/KYhCg/FTJinv/BfefyXTm3S0n5XGElWBT0IoyhZmkRoa8NQqsXbK?=
 =?iso-8859-1?Q?Zm4z9X9uZQeIpQaciaOOsUUkwYOUKjn192a2moG9bzpavMVjm5RA9Qk6kN?=
 =?iso-8859-1?Q?7p96XFsw3wXLp/ss3CUpZiSzkS8PMj+2yUHYXbZaRIbtU4ReycEMVHIFDw?=
 =?iso-8859-1?Q?e/ehgn6nlYnc1SSMMsSl6/eXqrawm1UVuzvofNdSbjoj563VBRMie7Wrus?=
 =?iso-8859-1?Q?JJ1byLzbhdnzQHSl3TTyQWSbNXEjmtRjLjJlMdHh3o/aW2D15e/x0V9Msv?=
 =?iso-8859-1?Q?gK9upOSeZp2WImfF+hbfCheYLeIatUxiTIZnjfl1tEQK/HQerCznV0Xwsj?=
 =?iso-8859-1?Q?VFwtqN7PpKM+dohWrhcV93eM2SpJPnEQHvRydLye5gZd34B24lT0Ygl6/S?=
 =?iso-8859-1?Q?iVuat2ABe9x/sh6Aet7tjAGlNmz0fXe0/drKcf/6ZjXEpirFKc3fUZ90DO?=
 =?iso-8859-1?Q?tQP3BB7SoD8GZGYpitzkFseBvDGv6UBBlYyMOqBJoXBwEmePeq+2P9+2yn?=
 =?iso-8859-1?Q?6rJCfCrKor19WbMVJv1vhwIIgEAdWNz847Y6uVuOnFgRGJbE7OQ1oeG+iM?=
 =?iso-8859-1?Q?cbFhuxn0d8F5CGbfY5/S1NGDM1xR1iiEjYzWDyIfY2ov6q79BfHJwlFUsP?=
 =?iso-8859-1?Q?nY4s3b/8TdfY2C3lmCXNg7W9c73hL1vDm4XwmJ3gz/3JczKRP81iVEb1NX?=
 =?iso-8859-1?Q?jjCLWjQUa9zgsf8DrqHG0lAOztxfJPM/NOINjrUbIDSeRMw2xmHL7egPk+?=
 =?iso-8859-1?Q?eczNt3x7lgG4cUtk51v6NLqFX0JABKDCqbx6KbUKaGOXydjYGWW+YEzX3P?=
 =?iso-8859-1?Q?2BlGGEKZ2X0s9G4308HyPaI1KhDNmcLn+72oI8PCAxJ8GR6Gsd3X3ctcwk?=
 =?iso-8859-1?Q?HfCRRNL+E0D8e2Qs6ULOGjt0pvPLov/Pu8IJeUZLmdbx/uzq7KvtlbI2XV?=
 =?iso-8859-1?Q?9vorDiiGDRwrlynKv8riAHp5kz1oyfdX90EleQZ4L0YQjE2UPcwYMDxIn9?=
 =?iso-8859-1?Q?+MSlZ0LnYNfky6Yw/WAn8f7++eodR7Z3tEt2k4vLNuffuJwTT3iFfJADHe?=
 =?iso-8859-1?Q?jBV50J9z95rHfjsR6d/H2nWmQB1WfveJlnhLQdBl1BVoQWTA7Qz3w2no4R?=
 =?iso-8859-1?Q?QF/4O0m3X2xpTMy0gxblgGcdjB80Sxyccb9eNcxgAnC/B82rqTdms+SVzJ?=
 =?iso-8859-1?Q?0GKSQ5KUXUPVZAHPYRO8oj2AksqbvDmskAKKt5EW+qKUKjDhnne4LxbuVC?=
 =?iso-8859-1?Q?FZGhADs6aYwMamdRh/rkL8F8vPRXA3x5G8fZo+kYmWGq5p2hYH7901G1Dc?=
 =?iso-8859-1?Q?eI+UdIXxglUZlvWIgV4/0x1txahbtZtTPkVPrfO4tOeTj0y3uG5AjM6zWo?=
 =?iso-8859-1?Q?q4eTCn8Jf5UsVxICzxoUVmSqO2JPEAErRLrOvNQuHX3izjFE3jYRezqslk?=
 =?iso-8859-1?Q?HQrjJG1gRVKiTYZvmsm9XeOFJmx0Bc6oEySgOb0ttuEg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB6PR05MB4551.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6642
X-CodeTwo-MessageID: 98b9730b-e595-48ae-9028-0d6548eb90f4.20250908160505@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF0003922D.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d2cc18b6-df66-4101-5c3a-08ddeef17911
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|14060799003|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?F3N1DqjPCbVdGMMNBQ36NIVK5KFTPU7oGWywFapqO7gHNsLhfsoR9upJgY?=
 =?iso-8859-1?Q?cEvNmMCpSEHmp1PdV/34cKwKfMZyDVUVIuX4MFq5HHNMd7MQikSvive/bD?=
 =?iso-8859-1?Q?kGr/h+J8fazQjrIsVPi0jHeujHBEY2vG+RwV6k45it9GHEl2nN2tiTrgI8?=
 =?iso-8859-1?Q?AoN6Vj5mZvjEoDbaimnMkznapkeYt8ihF7MXrODyyIBPMSIPW+geFkEADI?=
 =?iso-8859-1?Q?7T6f2HGQcsalBB+3lC4z+TlbIz1BGLPFK10QtrNsAFdhFXGnzp0IXE9gY1?=
 =?iso-8859-1?Q?gt/e4lAs3VDwRABtLifmDmId2XEG6t5VYZpelGEYUBNg38W34rwjQ5InT7?=
 =?iso-8859-1?Q?zFBvvbNVtWi+/nafWNlEZwqdtvBj0/4P3+YrByTcKdSD/IgXpErsMjVjSw?=
 =?iso-8859-1?Q?fCy/SWNXU6DEgLuWNyG2SiLUWbORM+MSmltNjKeNulwJFNscJW7oX8VhyS?=
 =?iso-8859-1?Q?PRwwX3qyDjsUGj2A3ek4j8hMmWYcqJbHlfaZ0Vh9xK2s9EqoiC/VaqLsvG?=
 =?iso-8859-1?Q?1zSltcTRavFqpirOzq4K/lOUyjmAD8SSIGe4G8u6dunCpx8GtLrlsO3xer?=
 =?iso-8859-1?Q?7dAmyHGo0Tw78oY+MtVzuB2EsOq28AuznABtc37+yCXjO1TcDBW/0f2+Ne?=
 =?iso-8859-1?Q?gfoD4MSpFmBueEmgtcK7Mc0Fh+h0y1rbspxfxRPjL/ShHKXKbqv22Pq+vk?=
 =?iso-8859-1?Q?v/6hlSKBe0V9oLny0HYrNCLKoGxuSU6H6LD5A1s0Nw5eXkl7ixClF+uaJ+?=
 =?iso-8859-1?Q?jbQAJfVHEFE/eSabP57z2oRuZK+vA1toblO+zqUz/BN7p1mn5ONuJoyKIu?=
 =?iso-8859-1?Q?QwO1SeCQSTy6geM6nXDJT8Ss5+ISJe1AfVRP6t9KdmOV5eLidRNwJx6c3K?=
 =?iso-8859-1?Q?0SClYD3ysGpYHMPE+/7KghZZOHl/grTubLkjl6u15hkxyi5+sjcPHtc4/T?=
 =?iso-8859-1?Q?qh6NXMu7N9UVVpbD8NYyrNYUKdlFVnO9DYuL9UdsWMdiazcdOC/gs9A0c8?=
 =?iso-8859-1?Q?UzsQp5LBw3BVhBK3FVT9Sxxu7BQu5PQAoTeMGKYjvLjyQ4qOvdqZ+ZP8pp?=
 =?iso-8859-1?Q?kLleIoKi8mhyG8cArafNcBjlsM6XTz/QHFrxFREHXczCvLjmG42oWGFFNH?=
 =?iso-8859-1?Q?K3GsElXNQw21OP5iWGbgDX/7V2vGVvNHEnc0cQcmxnsbgFM9214MkvRNG/?=
 =?iso-8859-1?Q?fQMbedsVc7P0oPZ0RfEpvXyC5Es6eeOz8agZYt5oA9VfAdLwV80Qgzu/hz?=
 =?iso-8859-1?Q?3D51dTSjQFj1nybdb5fLeWsy9cEKtv/Vsuwa9zXfQs5I51C+PtpZmq8Uee?=
 =?iso-8859-1?Q?amzcIkSXgHDNmZbmgZz2CZw3nVUJHnLWY7C2SctW3qcWUrJgP3An3NwTR6?=
 =?iso-8859-1?Q?8Qh/I0jHUREIZx/3tCmxLYMyBtoMXy8tYuhNSjO4lgH8YdRRmooBefbYe8?=
 =?iso-8859-1?Q?0T46MXwFElxhHQS6QiBPGKiVgk0j8ASv21z71uXxXCiaxTisMrUBnGzUvt?=
 =?iso-8859-1?Q?hLvA4z5fFiJIKN2VXN4LvtPAkmaHxdOLC+o9FzcL/u6urBm7+e6INQO4F0?=
 =?iso-8859-1?Q?mOnyB3JtUiZ/kuV/I2IHB9lKU5hJ?=
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(14060799003)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:05:06.6357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a2d8e2-4568-4570-2369-08ddeef17a93
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF0003922D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB8202
X-Mailman-Approved-At: Mon, 08 Sep 2025 21:42:16 +0200
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

When PMIC drivers are disabled their functions should not be called.=0A=
=0A=
Signed-off-by: Maarten Brock <maarten.brock@sttls.nl>=0A=
---=0A=
=0A=
 board/ti/am335x/board.c | 8 +++++++-=0A=
 1 file changed, 7 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c=0A=
index 2b7ab68e83c..284c31cc329 100644=0A=
--- a/board/ti/am335x/board.c=0A=
+++ b/board/ti/am335x/board.c=0A=
@@ -283,7 +283,7 @@ const struct dpll_params *get_dpll_ddr_params(void)=0A=
 =0A=
 static u8 bone_not_connected_to_ac_power(void)=0A=
 {=0A=
-	if (board_is_bone()) {=0A=
+	if (CONFIG_IS_ENABLED(PMIC_TPS65217) && board_is_bone()) {=0A=
 		uchar pmic_status_reg;=0A=
 		if (tps65217_reg_read(TPS65217_STATUS,=0A=
 				      &pmic_status_reg))=0A=
@@ -332,6 +332,9 @@ static void scale_vcores_bone(int freq)=0A=
 {=0A=
 	int usb_cur_lim, mpu_vdd;=0A=
 =0A=
+	if (!CONFIG_IS_ENABLED(PMIC_TPS65217))=0A=
+		return;=0A=
+=0A=
 	/*=0A=
 	 * Only perform PMIC configurations if board rev > A1=0A=
 	 * on Beaglebone White=0A=
@@ -426,6 +429,9 @@ void scale_vcores_generic(int freq)=0A=
 {=0A=
 	int sil_rev, mpu_vdd;=0A=
 =0A=
+	if (!CONFIG_IS_ENABLED(DM_PMIC_TPS65910))=0A=
+		return;=0A=
+=0A=
 	/*=0A=
 	 * The GP EVM, IDK and EVM SK use a TPS65910 PMIC.  For all=0A=
 	 * MPU frequencies we support we use a CORE voltage of=0A=
-- =0A=
2.34.1=0A=
=0A=
base-commit: e4c8b32d03d7ecffd586b7d33336603ad639d7c0=0A=
branch: am335x-pmic=0A=
