Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99312CA0FFF
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 16:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BC0A83A32;
	Mon,  1 Sep 2025 18:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="rcJF5nmG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B823583A1B; Mon,  1 Sep 2025 18:06:17 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7AB283990
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 18:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMeqbUgNr7EchV322b7eMkae7hPKh3dvUAbAs9YqXussufW/oqN6yC+faz8VdBfDlSFhPK4MYzhgQWCTQuRax8V2p3RvaKZ7X+1XqfVstuQrGe/JKdrWz0xXf9BW2+//s3QSosdCUf5OHr6Ug/aSTpF3EzdnpB9ZccH1Vs7LuMvGN1HkX91oL3NUSUvxNthn/8LDuZg3d9+EdyRy9xWB3JkYzpQDSFcYa9n9ojLzBp+owAtIQZ7oVTwbOuD9W8D6+hkkZ716r1KYQXAK081TocA/ZYe8zFce8rhaQJj1oAJY/MXytzI6rgqi1mynPbeXMH9dkLNCTbOEeBWtHctuWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9Cy0zv3FTjiJOVwAjoO2NPOvMNDL5nKWMBFAxm7/30=;
 b=RihoJtbhBklIQ8UCknfFqbqOekR8RaNKm7f4uwbDxA86AgouAXa75Nvfrc6/M8CoNcGdrYIp/eZ+wDJn3BC4cgZi9Kz6t5VUq3PRjZkBlU6OyJMQftF5wWkb4opdFms6yp7BDuUja93rYzSMeG2AjB+wAO5spyNSxse7i/z4dKSBgqJHZdqDU6BkgIaNi48g2PJA7+EKSmakziJUprrNMdiuKKeqhvoUUJplWsYNHeWfQI/hqENkyRFDx+E7wO+wFcS4Ictx/1YjLlxCt535Rlj/wiM2cicAVc4J+48kgCtaRt4q56IzEU94jYfCM/0ehbO/RJvKL1+WBUDgBsUHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9Cy0zv3FTjiJOVwAjoO2NPOvMNDL5nKWMBFAxm7/30=;
 b=rcJF5nmGTGrkMnNZwqDHn79OOcsbjfA231cT5ftFaIYqzSfA7MNHV3gjExvgblgc/YAyIHnQRyH/tqU0mdvWeVmwOohxzAHE74xF+tktuBmWq97rPyf2NozZFISOW6mYYxlXbvAjZCgrLwmMk4Is8Zamf1QXviKSVadRrNdo+dodQFSwbT7hQT8cj37m4Y5JtvWAmR9sqpjLRpw9fkMFa2fnLSDtiLFT8C5Z8neu38rKRt6igSHykhiNfgptI35sTmCjt/VJIJOWZjoX+Pendg9z5FDTk6boUxGMJ7P89kqF7dIdp16Idg/u4GuRo/tKeOJJWCLArzvUpXbQcbyLzA==
Received: from DU2PR04CA0069.eurprd04.prod.outlook.com (2603:10a6:10:232::14)
 by DB9PR05MB9549.eurprd05.prod.outlook.com (2603:10a6:10:301::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 1 Sep
 2025 16:06:08 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::38) by DU2PR04CA0069.outlook.office365.com
 (2603:10a6:10:232::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 16:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 16:06:08 +0000
Received: from DU2PR03CU002.outbound.protection.outlook.com (40.93.64.30) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Mon, 01 Sep 2025 16:06:07 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com (2603:10a6:6:4a::24) by
 AM0PR05MB6739.eurprd05.prod.outlook.com (2603:10a6:20b:145::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 16:06:05 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53]) by DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 16:06:04 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Kory Maincent <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Maarten Brock
 <Maarten.Brock@sttls.nl>
Subject: [PATCH 1/2] ti: Do not try to read the mac address if no NET is
 enabled
Thread-Topic: [PATCH 1/2] ti: Do not try to read the mac address if no NET is
 enabled
Thread-Index: AQHcG1luYjYkdek/hUmbiEPbAi/qCw==
Date: Mon, 1 Sep 2025 16:06:04 +0000
Message-ID: <DB6PR05MB45518EE72CE8B05405F3439A8307A@DB6PR05MB4551.eurprd05.prod.outlook.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: DB6PR05MB4551:EE_|AM0PR05MB6739:EE_|DU6PEPF0000A7E1:EE_|DB9PR05MB9549:EE_
X-MS-Office365-Filtering-Correlation-Id: 713a38c7-2f31-4e6f-5f5a-08dde9717651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?iso-8859-1?Q?3j8EAuwON2gFE8zJMuoDUx59uvXG+rIYMBTuTddjhp7ib9rgBDcqb78Ynb?=
 =?iso-8859-1?Q?ajdtDFr/5pmIr/Q05O+G3tUgmBMM+NSlOg3jeP2t82Y3fe9hz1UUgVqkBX?=
 =?iso-8859-1?Q?kcKJskBq8DIduwfFEBiu5pe98k7ESYq9zOsAv9oIH8aH+D4L68Oes/Lg0a?=
 =?iso-8859-1?Q?fbPzTLucJ0w/SoGfBsyH8M6sxGqZcK6wKIJzOHGatT5uYEbZTQV7eh2vY/?=
 =?iso-8859-1?Q?G6EDNqz9ycrODOVzNbX3hFJBmpS34/jjwLOPmskGTpSDJ9DA19t2fuJMQE?=
 =?iso-8859-1?Q?HXSZc6psH9OcxhqaJjX4+F0np/i0x+CmaCXOKtCPvnO1PtWmeXMcRJU+eM?=
 =?iso-8859-1?Q?cXuLFIUs3ubDxfcMpLieta2SW+R1VinEyG/SyJSIovqX12wPT5s+C7lo5Y?=
 =?iso-8859-1?Q?PcZseti0RqhrezhGS4cWrK4EoTIWtO+XIe/Wf3/eG1RyBDWohK8SxUxDJt?=
 =?iso-8859-1?Q?0EJyyWByZvZ8viBjvI4rNTUDywsyibzpHoLXCCqPWPImOjSwnvEGvMSya6?=
 =?iso-8859-1?Q?3bcFdFKJOh3RmUvNXimL49bz+mrwlr2WEfoxic7zfqf6Nm6fC5NHIIZxT7?=
 =?iso-8859-1?Q?vR3+Z/KQ6P7DJG6cEZsSoG87RB8Boa7YduZ/n9Wcd8x6tsMPAqceW2z2g9?=
 =?iso-8859-1?Q?C/VOlvLbjnicBHthkEDR2jyhh92D/MUO6w9zVKo0kg7/uO/XAtmvPu/N2F?=
 =?iso-8859-1?Q?QMYP9+mGeo2OEn7LBWhuxlgJs7Jgxc4gLNLEooudu7KgUvDg3+iiAwJQgI?=
 =?iso-8859-1?Q?e3KxyAphkskJS+n5BWO7pdvn/NsLCkOr3TZfpD4vmGwIAtrwBU7oYc04Yw?=
 =?iso-8859-1?Q?fi17JVyB8DsjalHdrNJrPtHUE2u7mj7M06eJookqWxS76FktbWJYeugYH/?=
 =?iso-8859-1?Q?1qPU3pmVyTdZqKacqvVsFooOWUhtVaEwoVftFA1d81DgkVE4EDVldH7Hwv?=
 =?iso-8859-1?Q?1pVMr/IUii4++FX0Cq+2E/G5k/9RNFTRE0Qo0RWCZCVpIn63T/Cbrib1sN?=
 =?iso-8859-1?Q?jHxcdXWWGRQMlu1cZLhMTBpNjRc37WDkj1MnLD9G+rrzPLoa9zXondD9OE?=
 =?iso-8859-1?Q?+PXwS523O/Qv4sljsm8YKcUwxSKSrXNBXGtLUs5qXcMpUJJx5/3UnY239L?=
 =?iso-8859-1?Q?Nuq0gjcUnqei1+G2Gs6ONwIN/kynmBdBOyDV9wc3g7cbkT0NWyRUl+iefz?=
 =?iso-8859-1?Q?N6NA/8ASVl1dHMOmBHEVS+LEbiWxTAmVHLOb0LzAnhTlptBCzhmNIL0ic2?=
 =?iso-8859-1?Q?RQ9ktByPyf8W6Fm4MU+gTJyBcZTuJde1qAJ0AFsjJZsJg7aRWmohE5ycpb?=
 =?iso-8859-1?Q?p2j4Wh53ULcRQW6yzR2njlXKbxYuciJ9R2kmeCXO2OybZe2iFz64WxfU7h?=
 =?iso-8859-1?Q?IBcxxWDCUaxVn4/1j/jleTPBTs0ebdfM4x1oF6PvSfd53D4QJRoc1P1wvG?=
 =?iso-8859-1?Q?DzYIIY46a+fr73QRKyLLw+beL+heMcttyK8fcZW+TYHwNDzDeFdauGvMUR?=
 =?iso-8859-1?Q?my4CvaZzOYLbmgvmz11fWC1EUUicshZbtJtqIKlsRg5g=3D=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB6PR05MB4551.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6739
X-CodeTwo-MessageID: 6f6d52e4-837e-4da0-9396-02985ef956b5.20250901160607@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9af5b226-2d43-4bd9-0ee4-08dde97173fd
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|35042699022|36860700013|376014|14060799003;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?WGo+aKv/NEENczUZEWxFIrmgDm+QkgnnBUVLGnjbumLhAFUO4+bMJkZs1b?=
 =?iso-8859-1?Q?6LdislXBLEPJN2SzUAGQHuayHGQFmD+sB03VOSmv2e53+nFdqH6U5VXntL?=
 =?iso-8859-1?Q?dRLjkMnnhNAokxXbhkiEtOaUASs+nEvsS/RNzaGyjK5yH9DsMr0Ss92rZF?=
 =?iso-8859-1?Q?jXlbOYN9/IIm72Ga/2ohnFdJeiipFeNfQikVC0zTG1yP04vMqvfIzq78F+?=
 =?iso-8859-1?Q?lkivwH9B+vOJlBVTyABlN2lb70LjfDTG4RLwHTafV/LCMH5tOqqxdMbccE?=
 =?iso-8859-1?Q?Sq2c80gBpjsKFBf/6IXzhAGe8Fj8Gr4cs8rpUUAXTd9ij+gzcXHuOMxHVI?=
 =?iso-8859-1?Q?IDQdve1IBSeIT4brvHSPlQMY/d710+g8NszCi11iiamlZsP0TEHXXVWLE+?=
 =?iso-8859-1?Q?k+onxciH+wnV6dsnigjmFWhGCEge/ENRYE8JANUJmGOXMkDJl1Sf//05Nq?=
 =?iso-8859-1?Q?gncvMGYlLtYVuGlilP8yHmcG9RZd9RNeaxEnEkNUdk62RHmVeFf12cl1L7?=
 =?iso-8859-1?Q?jlTenJnAu/THqs0B2Y18ZR0pWWS9snllWsvfpU73Cyp6uDX/amtJF6wYhc?=
 =?iso-8859-1?Q?njNgYc8G3HRydfob/xoofOv6/IQnWmwGjZL+H+3xuI9ume3xcC2rX/92ZB?=
 =?iso-8859-1?Q?vOwcc+As2OsggKTMwK3PNZvpSAxFtbInBOS0IDPLsUKX9uFLpEzdJfygsA?=
 =?iso-8859-1?Q?2lmQUcHUoVRkbJapqijlsfZxiuDJbKnj8Puf9xEqzHnY1PgKs6brtB5P/B?=
 =?iso-8859-1?Q?kjXrxU1EP++SKfZfsdC07rOlt44pf7qwVWj3YTALAZpmkPVoXYqoYbHKoq?=
 =?iso-8859-1?Q?ZC4Ac3mm+758TGfcmmzxiscpDQV/kvVqlfRkh5w8Ppgez3G0DnEDyRppEt?=
 =?iso-8859-1?Q?Yw8n8YUjbou6WtsYP+MeWU9oQfsYP7zrVz8SSNcg6mDYjCbsCciSo++XlO?=
 =?iso-8859-1?Q?vy7iXPUxktYtGvn7NgOO174mSTo2HOW2kY04tlEMvarg516tnbTSYBCdrB?=
 =?iso-8859-1?Q?B8td+Xa0bZTeSqcLXBMiUg/4dBgCnJ9uO5aC4Sj0iAB6wHrHV1pEmsGZbG?=
 =?iso-8859-1?Q?jpWT/V0a8lrejvExjvg43Sh7RtwnM8YmJ0c9ox8bp2LOvrTDe847QAbCQB?=
 =?iso-8859-1?Q?Lj+usXsA8hOjtssX7aQWbxfaMGuFobLxY71qdfNx8JUWy+GROqcZJn7/UQ?=
 =?iso-8859-1?Q?hBfgiZesjvO+JEU+kuPiXmddiEs5ocvgvzFizciub8F4SXNKFpr2N8eC2z?=
 =?iso-8859-1?Q?t5iQYD5NIvPGUY5jOPKZSsK84C53CvjfHlA9IlnDHYfc9KK+BVo8ZruHfQ?=
 =?iso-8859-1?Q?J5SXU7/oOxzG7u+KZhOZG2Z5jJi8xhW3PtIgigSGlQsomsPQuGrirNp0jr?=
 =?iso-8859-1?Q?lsk/d2gU+j48D3DS/S6xBSeqa9Og/drit2EFgcQ0pPKsY+eH+czgeNT3ca?=
 =?iso-8859-1?Q?Hekkbuqm9Y3MdCMKRhxxf3iU6JWI9Qvy+eioPpOMIlHPy5gk5o894NaVWN?=
 =?iso-8859-1?Q?NUHD970HCWF/CIBsldGcHMRwBcTLWFPkbHOZmgFDTtdP2Q3tNt9KO2EueX?=
 =?iso-8859-1?Q?gD1fbHC/WGE5N06NnKD97tph2HiP?=
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(35042699022)(36860700013)(376014)(14060799003);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 16:06:08.1028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 713a38c7-2f31-4e6f-5f5a-08dde9717651
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB9549
X-Mailman-Approved-At: Mon, 01 Sep 2025 18:31:50 +0200
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

It is pointless to fetch the mac address if it will never be used.=0A=
=0A=
Signed-off-by: Maarten Brock <maarten.brock@sttls.nl>=0A=
---=0A=
=0A=
 board/ti/am335x/board.c | 72 ++++++++++++++++++++---------------------=0A=
 1 file changed, 36 insertions(+), 36 deletions(-)=0A=
=0A=
diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c=0A=
index 4ada8b534c1..739b23b8554 100644=0A=
--- a/board/ti/am335x/board.c=0A=
+++ b/board/ti/am335x/board.c=0A=
@@ -801,10 +801,6 @@ int board_init(void)=0A=
 int board_late_init(void)=0A=
 {=0A=
 	struct udevice *dev;=0A=
-#if !defined(CONFIG_XPL_BUILD)=0A=
-	uint8_t mac_addr[6];=0A=
-	uint32_t mac_hi, mac_lo;=0A=
-#endif=0A=
 =0A=
 #ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=0A=
 	char *name =3D NULL;=0A=
@@ -852,40 +848,44 @@ int board_late_init(void)=0A=
 		env_set("boot_fit", "1");=0A=
 #endif=0A=
 =0A=
-#if !defined(CONFIG_XPL_BUILD)=0A=
-	/* try reading mac address from efuse */=0A=
-	mac_lo =3D readl(&cdev->macid0l);=0A=
-	mac_hi =3D readl(&cdev->macid0h);=0A=
-	mac_addr[0] =3D mac_hi & 0xFF;=0A=
-	mac_addr[1] =3D (mac_hi & 0xFF00) >> 8;=0A=
-	mac_addr[2] =3D (mac_hi & 0xFF0000) >> 16;=0A=
-	mac_addr[3] =3D (mac_hi & 0xFF000000) >> 24;=0A=
-	mac_addr[4] =3D mac_lo & 0xFF;=0A=
-	mac_addr[5] =3D (mac_lo & 0xFF00) >> 8;=0A=
-=0A=
-	if (!env_get("ethaddr")) {=0A=
-		printf("<ethaddr> not set. Validating first E-fuse MAC\n");=0A=
-=0A=
-		if (is_valid_ethaddr(mac_addr))=0A=
-			eth_env_set_enetaddr("ethaddr", mac_addr);=0A=
-	}=0A=
+	if ((CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)) &&=0A=
+	    !IS_ENABLED(CONFIG_XPL_BUILD)) {=0A=
+		uint8_t mac_addr[6];=0A=
+		uint32_t mac_hi, mac_lo;=0A=
+=0A=
+		/* try reading mac address from efuse */=0A=
+		mac_lo =3D readl(&cdev->macid0l);=0A=
+		mac_hi =3D readl(&cdev->macid0h);=0A=
+		mac_addr[0] =3D mac_hi & 0xFF;=0A=
+		mac_addr[1] =3D (mac_hi & 0xFF00) >> 8;=0A=
+		mac_addr[2] =3D (mac_hi & 0xFF0000) >> 16;=0A=
+		mac_addr[3] =3D (mac_hi & 0xFF000000) >> 24;=0A=
+		mac_addr[4] =3D mac_lo & 0xFF;=0A=
+		mac_addr[5] =3D (mac_lo & 0xFF00) >> 8;=0A=
+=0A=
+		if (!env_get("ethaddr")) {=0A=
+			printf("<ethaddr> not set. Validating first E-fuse MAC\n");=0A=
+=0A=
+			if (is_valid_ethaddr(mac_addr))=0A=
+				eth_env_set_enetaddr("ethaddr", mac_addr);=0A=
+		}=0A=
 =0A=
-	mac_lo =3D readl(&cdev->macid1l);=0A=
-	mac_hi =3D readl(&cdev->macid1h);=0A=
-	mac_addr[0] =3D mac_hi & 0xFF;=0A=
-	mac_addr[1] =3D (mac_hi & 0xFF00) >> 8;=0A=
-	mac_addr[2] =3D (mac_hi & 0xFF0000) >> 16;=0A=
-	mac_addr[3] =3D (mac_hi & 0xFF000000) >> 24;=0A=
-	mac_addr[4] =3D mac_lo & 0xFF;=0A=
-	mac_addr[5] =3D (mac_lo & 0xFF00) >> 8;=0A=
-=0A=
-	if (!env_get("eth1addr")) {=0A=
-		if (is_valid_ethaddr(mac_addr))=0A=
-			eth_env_set_enetaddr("eth1addr", mac_addr);=0A=
-	}=0A=
+		mac_lo =3D readl(&cdev->macid1l);=0A=
+		mac_hi =3D readl(&cdev->macid1h);=0A=
+		mac_addr[0] =3D mac_hi & 0xFF;=0A=
+		mac_addr[1] =3D (mac_hi & 0xFF00) >> 8;=0A=
+		mac_addr[2] =3D (mac_hi & 0xFF0000) >> 16;=0A=
+		mac_addr[3] =3D (mac_hi & 0xFF000000) >> 24;=0A=
+		mac_addr[4] =3D mac_lo & 0xFF;=0A=
+		mac_addr[5] =3D (mac_lo & 0xFF00) >> 8;=0A=
+=0A=
+		if (!env_get("eth1addr")) {=0A=
+			if (is_valid_ethaddr(mac_addr))=0A=
+				eth_env_set_enetaddr("eth1addr", mac_addr);=0A=
+		}=0A=
 =0A=
-	env_set("ice_mii", prueth_is_mii ? "mii" : "rmii");=0A=
-#endif=0A=
+		env_set("ice_mii", prueth_is_mii ? "mii" : "rmii");=0A=
+	}=0A=
 =0A=
 	if (!env_get("serial#")) {=0A=
 		char *board_serial =3D env_get("board_serial");=0A=
-- =0A=
2.34.1=0A=
=0A=
base-commit: e4c8b32d03d7ecffd586b7d33336603ad639d7c0=0A=
branch: am335x-no-net=0A=
