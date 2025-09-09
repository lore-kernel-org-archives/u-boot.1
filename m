Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BB9CAC587
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 13:00:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF19C8329B;
	Tue,  9 Sep 2025 14:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="K0QUkGzt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02AC58312A; Tue,  9 Sep 2025 14:45:27 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9B73830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 14:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VADcfN0vocp/KB9FqTg2IYOWFubhecROzU4bDZzkEC5or0T4KdvqxpcNSSUVCuVdngc86+xDy5S+6wyZd6iQC3s2iR29ATjoEZ1O58zMKkfFDhYeO/ztnpT10Wo494rfUdPlILkj5GxeW1GzirEnwFlx1yeOysnZznOi1a9BS69Qv9zDQuN7mVojVM8qQsR8lKxK8CO/2AAsMDvGEHtgtzKdjgFWpjJHK9JgqTXP9KPZnPotbQByJnm/EfWtXXLggywzwZcqks3oEeaLwoTMdFLl/zdtK9pX9RW6ey/pAP0KwuwrGPr9u54rqgCvRC5lD8Heq16Sx93nJlNGS1LeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjAXOQtkKRFrh7XNgWVd1xsTpRS/43pbHxEbihS/+0s=;
 b=g3Tqp3gQdzSl0xS5eoZ3Bq3PRc+yEfv+Txw6GqLEg90yKL6sqZLA/Sc4Nm5kw3QUzpRO6b0RscoPnz2R5Oatu3ShGQe16h5ndQNdp8Yc2uOCFOQT86eUkNmNTsoAK5i0TzVBpvLRUAUY49vfuPxjxaLMB4EqTbwnTfWxxaFpsX6XAqQrvIG4yJ8pepK7gMHK52YRLslDEnr/FRuX69wn24GioCYVInDIBbjyRewlsRWPnPZHZZ5JEC182o8wkd4FRIhw8KizLjLPrJHwIi2utJ3sHpgR075h6zpz1em80Pp+ZtGRxLjLimvT5pbkv24X6kzANLiqYhWyvPOBRQzTEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjAXOQtkKRFrh7XNgWVd1xsTpRS/43pbHxEbihS/+0s=;
 b=K0QUkGztbIbQdKiSKy88B91XVh2njCcnsm02461P8wDa6GdPgzT9I5a/eYmsi5y7e0gc2P7w+e9gQAYv9CvRTeni1YYrL+L2hZ83/buKyrz7g43YFidkqU1EP27ZmotESqIHDgi7pHDRyzJQJUxK6Cx+aFTRMZhFqdAv7RogKr0I9KCrDVFStcKtOkQT3DO7R1VA40jCYky+OxFfJCePsaK+lalOqwtTt4+fiCRxExzNBSwMFCSSpSzuhN7bhyjIu+bfoW2767TVGXyWkVjuANJ5DlUadnpI83s+NqbUyhC90bv9Bg/HDIBwA2bz6QBS3Ue075Nu+GqkxD29duQ9dg==
Received: from CWLP265CA0532.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18d::14)
 by DU0PR05MB10244.eurprd05.prod.outlook.com (2603:10a6:10:440::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 12:45:18 +0000
Received: from AM2PEPF0001C70B.eurprd05.prod.outlook.com
 (2603:10a6:400:18d:cafe::36) by CWLP265CA0532.outlook.office365.com
 (2603:10a6:400:18d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 12:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AM2PEPF0001C70B.mail.protection.outlook.com (10.167.16.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 12:45:16 +0000
Received: from AS8PR04CU009.outbound.protection.outlook.com (40.93.65.30) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Tue, 09 Sep 2025 12:45:16 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com (2603:10a6:6:4a::24) by
 AS8PR05MB10464.eurprd05.prod.outlook.com (2603:10a6:20b:610::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 12:45:10 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53]) by DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53%4]) with mapi id 15.20.9052.019; Tue, 9 Sep 2025
 12:45:10 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "jerome.forissier@linaro.org" <jerome.forissier@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>, "trini@konsulko.com"
 <trini@konsulko.com>
Subject: Re: [PATCH 1/1] board: ti: am335x: Do not call disabled PMIC functions
Thread-Topic: [PATCH 1/1] board: ti: am335x: Do not call disabled PMIC
 functions
Thread-Index: AQHcINmJWmfe7YqAm0qbuGfL+fh/urSJfcUAgAFCz6s=
Date: Tue, 9 Sep 2025 12:45:10 +0000
Message-ID: <DB6PR05MB45516C241486780C8D198FCD830FA@DB6PR05MB4551.eurprd05.prod.outlook.com>
References: <DB6PR05MB4551D31271569EC04E8EC60F830CA@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250908184342.7ec9500b@kmaincent-XPS-13-7390>
In-Reply-To: <20250908184342.7ec9500b@kmaincent-XPS-13-7390>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: DB6PR05MB4551:EE_|AS8PR05MB10464:EE_|AM2PEPF0001C70B:EE_|DU0PR05MB10244:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4ed170-953f-4c80-5f49-08ddef9eba85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?iso-8859-1?Q?CtzimSyo5fRv856AbbgA0jSGgcXf+l/QZHxR8wQSfJ5jAZhQ6Oop6I2CBQ?=
 =?iso-8859-1?Q?2zvKKdx2BJaSGUs8AInaks8vo5SqayGJju8bKTfp4mDXD5l501xvonaFDX?=
 =?iso-8859-1?Q?qJyFHeJ5Rs5Kg7JVVmIGYydPYM/DSwPVkFtY9U5cMaphjKvD5Hz+IQnm6T?=
 =?iso-8859-1?Q?TZPZMtoTF886CCA3ln9FpSOW6wyST+wqqiNLbhgQLfBIesosDk32i376YV?=
 =?iso-8859-1?Q?pFKVHhJ0mysU0ROyGKl+jgrbjkQnf8jp9kfMsHK+jrTTK4da9vdJeE+7EG?=
 =?iso-8859-1?Q?hA0zU33FdyPiNswzD97aYpKyeZfdLxxQWmTWIqWoJMsvH0oeLSqKWLJDXC?=
 =?iso-8859-1?Q?Nn31fhuntQ2YAo6iuJgHIOEw1p9WyHkiBoNpzV0p63P/HCKi5h57nysw40?=
 =?iso-8859-1?Q?lJqO3jAxMADBhv+89ilJsCZQydWHcc6PIqiwH4mmRPAYuBW95fMfFX62Fx?=
 =?iso-8859-1?Q?n8w42uBXeUcuxvKdyyKikJ7c+XFjBzRMG+O3ho7X3AhFadJ2b0pXu35Xss?=
 =?iso-8859-1?Q?Ph1AsD3WtvRYtWSVVdDFKxmjiBsHnmbjyIn3Qn171t8KzAtK+7+V40PbUr?=
 =?iso-8859-1?Q?q2DJCFKfPiZd6YTaIA9zX61cuV2NXSdWf/3wuPCAYNdyaAIwnRMZ9jM0Lu?=
 =?iso-8859-1?Q?SG0JqwIOxHGFu5rBzVLTBAdbq+eFR/Sqvy98QraZib0OVcepi562fZeN8O?=
 =?iso-8859-1?Q?4a7LMFSxYb/YiCI2aABKvTgpjUZ8SH+Giyj8SKeRXJdcrUrSx99KaKTiiS?=
 =?iso-8859-1?Q?AJevQSzHBckrDRrbhGaFplpmOJd35Z2cgTfEG2hyZtGjkAt9hP2s3b21mc?=
 =?iso-8859-1?Q?5VQ6yqoUKWhRfFMe0jdGoFIGHu35D5O7VosXQp2bpTA9G7tOrnn1JcBI+f?=
 =?iso-8859-1?Q?MQIUmudwU5DWHiRY+dLQm2ptXQ23NWI5WlDF7HwLnufZK2jx3C2i5tFFdB?=
 =?iso-8859-1?Q?cNnABDF7CNUDnJUBzkmOYU+qLZZz+Akj0s8g/BfJ/w5uzSW/dNzRMB9cl1?=
 =?iso-8859-1?Q?RVlReMdoTjo9GsoKJwO8ZnWUaMZ3eSHKI2FrbeQduE3NLhX/EhIyaBI3Bk?=
 =?iso-8859-1?Q?ifh0NBXHErt9JoA3y6TCo5orQqEIiVOjzl3P7HOl7/UB4BvE1mruhwrD00?=
 =?iso-8859-1?Q?gVANtTPwtA53rf2uAzJWIUX2D9nJK3b/p11kI1Hb0+9UQSrinn/NCB9Gzu?=
 =?iso-8859-1?Q?e/osPJSo9/TbT6AYdQt+b1YwkykF4Ye6Z4K3L0aQ04M4/H5zPyyVqUZtL4?=
 =?iso-8859-1?Q?ajr1Ky30+roM0xpiJ3Pdk00GtzkNAJVfgASrhubOcDQzbKPNbIKxKOLYip?=
 =?iso-8859-1?Q?fbSHDAi1YM41LkPN9QVP4le3UFO7ashUGv19DkHSaeNNA6r4SoLnITvTrE?=
 =?iso-8859-1?Q?cdRv5trNtiUUDvFYAAmj7NPdQCrpm7WSVi+oYM2M0dk/0CU02Yus0cZa80?=
 =?iso-8859-1?Q?MdIm69QimmRNmN5rIVrTdxHaz+CEEab0HOSss5yhKeznHrzrmqPO/5dHGr?=
 =?iso-8859-1?Q?dvuMz9XrHEgI0NZL5LO/ZrL7B6OivzVXJ19ZCMHbd6bYaat5a5RRyChcX4?=
 =?iso-8859-1?Q?8lSY/Zk=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB6PR05MB4551.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700021);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB10464
X-CodeTwo-MessageID: c0d00595-b9d1-447a-bb32-19dc88782098.20250909124516@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 78b585eb-eae6-4749-9cf3-08ddef9eb6c1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|35042699022|14060799003|376014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?FPu4VRdOO9pNYKnKLRX5kOo0Lup1eNFzqeqprWZUFhjMcqrmoah8e7CjhI?=
 =?iso-8859-1?Q?SwpmQ5MBiI/zAbmCgaPBaruve7OVE1kyvRmSaV5fOL/6XGbfgfnR3dWKaj?=
 =?iso-8859-1?Q?zpxzYJwRk11DV/E8k1Qvn5o52n8UUMR/1ZGLQWuoUybPkZWrrt0SimsQRT?=
 =?iso-8859-1?Q?tDw3EhX6dk6n35b8kTv6GJkUAFqwk00RbVfw7e56tfkAcrfOdnOGOG/J1b?=
 =?iso-8859-1?Q?RYLMeAcj7yQOXCC78AQH+Us+zEbpG+0cAFZ4damQO+6ukllAVwR9A34NTK?=
 =?iso-8859-1?Q?+pa6jzAAYy+pUvmNzM7RYO4izGOz3GL5OPsAE9k2VXQbYYCiejh6+hreGQ?=
 =?iso-8859-1?Q?R9URv9jKBQgFtv1FkjAAo7MQjhRLmj4oezfSLiWTx+GA04GD8yoxETe4M6?=
 =?iso-8859-1?Q?2aoJqA46uS3Exx5wjtxs/JT5ynKmVzUEkvldn2oJq8WVCpMqGZ4m5h+wdL?=
 =?iso-8859-1?Q?fONzIoD4ryRQj0Z9VElc8ktcqkjmLxCmH9cLwsTMRqEnW+FZM9Tqxx63mc?=
 =?iso-8859-1?Q?RdRTLb1iaxgOVAyCCkGqM8JgqiyXb7ihGr8AwkzR0XeR5BSw7d0lCQ4JES?=
 =?iso-8859-1?Q?2+/LreICHjnUovqRVuCNpbJIKOm/gGUEkwUAUGQ2cVeuLH3/cZIYX06iNr?=
 =?iso-8859-1?Q?qY0Vj7qxwJdFPCHaxUeeStEummV9/leRto8+TgRJQ3YiR3GVcGNKY9LXJ6?=
 =?iso-8859-1?Q?p3TbnDDEU0kQgEd5emijTaVsjv1YnJOFP1CwGexy6kEC97mziU3SIhz4ao?=
 =?iso-8859-1?Q?mG2Wsc1e2FcPOTvR6NAWtp/IbpKUO5YsMVzyzrH7e6EAK8+MtQyDSD5XOO?=
 =?iso-8859-1?Q?hgzNofr3RkDUKUMuJltpM2Qdw02VoM10ia5cQdFYjUf+kYyaPTWVWTtPPO?=
 =?iso-8859-1?Q?gbru5k1xQLJK5e2XitiF/IPSG252KJkdOjWE4iLlKZDF7Vf3LpfKQs6syG?=
 =?iso-8859-1?Q?mC1BXv/jmXoZKzwRVk9MJw5Et8fVKbi5s9DFqmCRZXdUxgca+a6R19F0Rl?=
 =?iso-8859-1?Q?g4tBx3To3ynGYwXYa04M4TFIOzJ13In2O3B+VASqaSMCVAP1eOh0x4Mfip?=
 =?iso-8859-1?Q?iSRKuLIiw0u8Kh8RmxdVlPlCX6kZneIpyhP23BL6687LsKW1QGtmfjuiDE?=
 =?iso-8859-1?Q?3sE0sGsdL82QJ29WaLQuh2/R1QRPrEzQZY81LL8dBVtGNf8UqUTqdlf6M+?=
 =?iso-8859-1?Q?3YvFOLuXPaIxeCp0aHQ2dHwFDVSxq/uwKZOcF/wVfWjXQcSlIt4SU6TYL6?=
 =?iso-8859-1?Q?hcDfEZhY1HYwYilUBTXCAuWY0YkVeEKMW2XpycDVmGTrRFaCaPe6vYOcIh?=
 =?iso-8859-1?Q?kEiJQEEY5SlYW61FXTuJvUlY3E60xR4YZ4bPqLdrZy/Sx8Ev1j1Z7b6O+I?=
 =?iso-8859-1?Q?1LPmQTDJEBVkCsL4HyZIq7kXMQa1lxggQlHavJOlP+4TbsvsXS1bzA/+z5?=
 =?iso-8859-1?Q?8QIvxCRHLRp5s+bajTS/VGmfYuvVh3cgji91ptEcmxinwRZCnZGv1t2vd0?=
 =?iso-8859-1?Q?fDTn1abaAQ4PM1d9XrtCiJ469iGBUvlbvxlbZ0njSifIYV58npLlwAi0zq?=
 =?iso-8859-1?Q?wPVwWWSOdDEYrrlws8bPS1eDQ4Ca?=
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(82310400026)(35042699022)(14060799003)(376014)(1800799024)(36860700013)(7053199007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 12:45:16.9321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4ed170-953f-4c80-5f49-08ddef9eba85
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR05MB10244
X-Mailman-Approved-At: Tue, 09 Sep 2025 14:59:55 +0200
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

> From: Kory Maincent <kory.maincent@bootlin.com>=0A=
> =0A=
> On Mon, 8 Sep 2025 16:05:04 +0000=0A=
> Maarten Brock <Maarten.Brock@sttls.nl> wrote:=0A=
> =0A=
> > When PMIC drivers are disabled their functions should not be called.=0A=
> >=0A=
> > Signed-off-by: Maarten Brock <maarten.brock@sttls.nl>=0A=
> =0A=
> There is already board check with board_is_bone or board_is_beaglebonex=
=0A=
> call. Is it not sufficient? Why would we disable the PMIC support if we a=
re=0A=
> using one of these boards?=0A=
=0A=
Why would you keep the PMIC support if you are NOT using one of those board=
s?=0A=
Note that those checks are at runtime, not at compile time.=0A=
=0A=
> Maybe the only relevant return would be in scale_vcores_generic, as it=0A=
> matches the case where the board is not known.=0A=
=0A=
When a board is using a certain PMIC it should be possible to deselect all=
=0A=
other PMICs that are not present. There is no point in keeping unused code=
=0A=
in the binary. Isn't that the whole idea of the configuration?=0A=
The current situation gives a build failure when the unused PMIC is=0A=
deselected.=0A=
=0A=
This file board/ti/am335x/board.c gives the impression to be useable for al=
l=0A=
AM335X based boards, including those yet unknown. What if a board does not=
=0A=
need any PMIC configuration, because the default strapped config is enough,=
=0A=
does one still need to drag those drivers along?=0A=
=0A=
Or to turn things around: if configuration is not to be used to create the=
=0A=
smallest possible executable image, then why not incorporate all PMIC drive=
rs=0A=
by default? All those config options could then be removed to simplify thin=
gs=0A=
a lot.=0A=
=0A=
Kind Regards,=0A=
Maarten=0A=
