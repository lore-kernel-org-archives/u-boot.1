Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA81BCA1002
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 13:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A7FE83B5B;
	Thu,  4 Sep 2025 15:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="CrTKgMiT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6310983B48; Thu,  4 Sep 2025 15:19:33 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECB3B83B34
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 15:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccEBxX/+uofIylbjjuxRfr+lKxMPm249qxpqrRF7vyxaU3rZRl4y/GGasY7IKFSiWMUiaZvEK2LkXbI1M2iEje71iiM1pjv90U4iNMHWckIqOxAQX/C7XS8uT5GcG3nnVxiFYl29CEaRscltoD2iPte9TeHtZmHKJmTcFnAyyk/R0I8+V+8fHPfjtfRGmZRt8hXqMeAduGtNU21kQJ4H/fij/i2Tq928Xxm1yajDMdrGvv+neSL2YWhl+j3YVXFxgYfZqZKJGXCxKkAGR9C81tlpAP3UgXDdYJmV2ZCZamomXPa9Z12Xon98rY+g5Xey9zhfNMH5Seg6KsDZ7/wdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BVgerrtDGDwvpAOb5JU7ANjy/QeaJ6BwK2Sc7IUUn8=;
 b=B2PfWZawD+Dof52bz4/D6aaweYmRbwneUfb6Sth5e7gZBahMqdiBLFenevo8w+Me6XTeydnyFUbU63qPZMOgdkZt1s/womYl+UErTSsc9tf2dmwix4TTTSOOq7nM25SHiqbiw4nEyLhWS7bi7wvy4uaB56ao+uZLRrp7/Q+wx6vn9+EWhL28z0u1+uefY9DmN7Zfw3qYCJ2s6ioAbGu060gZgJHKBxIf4mab0cyxmFKYSfEluSfoGpKZDthtujNtPHGystN6SVr5Hq8TeT7Nn9h0MXFvoPjOmzI7VDuPNuK50yVxmVPvlmXaevgXlrZzp0fXAmatD6f8PsQvQVwK9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BVgerrtDGDwvpAOb5JU7ANjy/QeaJ6BwK2Sc7IUUn8=;
 b=CrTKgMiTTRuQkIFoVASWytjv9+Tx7ourpMmzKL7lLX2k5dif5xSLtHPMlyaFs7IXdgd1LlbdqP4hOgPuq75heFqRydaRHNn6eOjuUzfdBph58x9cdyIvlqZI/WWkl3bIFjwxwCueGPvtApWM84kyHL6Q6gt2fCo13HE7AooH886nde/VfEAmdJwAN8cTeHkIhFqmDNQDHgnKC6syEoww58NwA2en7cxMQyo2FXeuRjdNFTFsOgHry877gDUKyfarS/MXunhPPL3xx252Cc87/H865Qapl3vbIa2tFDS6J17/LKwPxkU9gZfaIVmszw5zhid9UWm1MnIJKckZiMsgmQ==
Received: from DU6P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::17)
 by PA1PR05MB11835.eurprd05.prod.outlook.com (2603:10a6:102:4f4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 13:19:29 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::17) by DU6P191CA0023.outlook.office365.com
 (2603:10a6:10:540::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Thu,
 4 Sep 2025 13:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 13:19:28 +0000
Received: from DB3PR0202CU003.outbound.protection.outlook.com (40.93.64.6) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Thu, 04 Sep 2025 13:19:28 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com (2603:10a6:6:4a::24) by
 DB9PR05MB10954.eurprd05.prod.outlook.com (2603:10a6:10:4ee::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Thu, 4 Sep 2025 13:19:26 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53]) by DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53%4]) with mapi id 15.20.9052.019; Thu, 4 Sep 2025
 13:19:26 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Kory Maincent <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 2/2] ti: Do not remove ft_board_setup for CONFIG_NO_NET
Thread-Topic: [PATCH 2/2] ti: Do not remove ft_board_setup for CONFIG_NO_NET
Thread-Index: AQHcG1oeOvD//iZHQk+XfdKWv0RcKLR+pPqAgARcaXI=
Date: Thu, 4 Sep 2025 13:19:26 +0000
Message-ID: <DB6PR05MB4551C8F51246AD5EEA64F4498300A@DB6PR05MB4551.eurprd05.prod.outlook.com>
References: <DB6PR05MB45517FBC403C54F9589F03878307A@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250901182549.GD124814@bill-the-cat>
In-Reply-To: <20250901182549.GD124814@bill-the-cat>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: DB6PR05MB4551:EE_|DB9PR05MB10954:EE_|DU2PEPF0001E9BF:EE_|PA1PR05MB11835:EE_
X-MS-Office365-Filtering-Correlation-Id: 61198000-79fe-49f2-d0d9-08ddebb5ad72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?iso-8859-1?Q?l2uph9EkRcljB3rSaZTiwNYOLsLW2hH1HTwsoW1t2qyTICcJ4JozHtU02p?=
 =?iso-8859-1?Q?6nXQJH/hZrew2tEsjPQCMKZQWxrwz0BTEPn7dsHMjIZPwudf12MDw3/+5w?=
 =?iso-8859-1?Q?WKnDi7t0vsF1jMjEmP2ShzsItIh9qemJelcV5v6qQiE7dbHBLDJWL1LKhm?=
 =?iso-8859-1?Q?D4ogE6iwR9UEd/APkCpNtJtGTUn/xlvZUFyD6F6jkOHlfKReOPvuShK3OD?=
 =?iso-8859-1?Q?VMFA5gAzsTKKRgBg/Xum+USfrwN/xE+cswUepB/8tm5n+LKLU/+h7IRf4T?=
 =?iso-8859-1?Q?V/rEPSjWuZsSFTln1zkmYaNXQEY97cTz6+T+l98524L5bYq2e1kUr2C4Fo?=
 =?iso-8859-1?Q?V8AG9Rn1z4jowqaLn8yz1Ca2SHZCtt78RwT3MiC2Rj8gsIfhdfAUBkiwKU?=
 =?iso-8859-1?Q?tSwA+kkzLXN6U/msmxOzOdGKAlBlJ9WCGdMjzjY5WaXMrOmyOZWIuNeHgr?=
 =?iso-8859-1?Q?vQ6lv/cIHWJ1j/qLXOwWeUNSX5gWblEbBcoDBMWqvp4paBRmB2p/UeI8Cd?=
 =?iso-8859-1?Q?xUslh7k4E/BcN6GoYB0+AuwOfjhRCfdecoi/JUuTVXaqwH42IBK381L9ym?=
 =?iso-8859-1?Q?mNpgwk5q7cZpHw7s26nN3/Qi/uWjqXnukW1zldm1vWK/q8KmhRe30L7/Qz?=
 =?iso-8859-1?Q?Utmd5r1rkZs9GzCYVQ5D+yKuzQ6WD33KK0Qqc5EjaHeZUKDww02ySMqJAb?=
 =?iso-8859-1?Q?g1xUUrQS778H965mMeARmlDsu02u3mef/rQ9PpSApaIZ29hAGU3QXVCHl6?=
 =?iso-8859-1?Q?UpKyKvFAniOxpnxyEf+JCPnCsL/9pOgaGjU6RqwD/TRcP3IwY/jiCxEVBf?=
 =?iso-8859-1?Q?HTLcSD1ZbZLpj+pFaSFmFyDBTY7lEne9m+L0AM42XDNr5W8CPDeSTgZ6wU?=
 =?iso-8859-1?Q?xEdhd/UeQ/xAO6rKOe3GsukdqWzcuSwZxW6Fyt8IUKSHvQ+5b18EBKuyCm?=
 =?iso-8859-1?Q?zaT4xX7sMJbAAvD89O8/qnoCzYLrkEXBgj5fSHFLCOVHf+o3njnDT5sJ4Y?=
 =?iso-8859-1?Q?5A62pTw98fpgryzzy4KbYQOfxd8ElZMFhevHcU0IM1BgKLyn/VaR+0Z6J6?=
 =?iso-8859-1?Q?+HVnXEdLRnp9UbqvAimYNnwMzjAD/EqXacAvORkJPgDVv/vyOzvzeF70zH?=
 =?iso-8859-1?Q?GlDtiOUrMduASHy0E+s9pBxbF5huN++etfXiG2JpihV4lDIdupg21X0BeI?=
 =?iso-8859-1?Q?Gs9FSp97osjfVHxqJyfZjJikF5eqI2YwFN0zThsD7PwK5CNq8FwfrWo9wL?=
 =?iso-8859-1?Q?ZW9ruyFbuvXJq/9UQL8EUpn3DlbhMELLYtp18Z//yfulyvq+eKOm/+VH2N?=
 =?iso-8859-1?Q?dfxf84aSpP3/Rplpj3KNk6cbkLPVB+O7sUPiTZ/vHOqH3Ebm5ipko3niNK?=
 =?iso-8859-1?Q?sTmIXxiV/qmH79dgrah+sNHuhxAT6JxmucjARdSIAqq+x3EXjFrlPCfqxS?=
 =?iso-8859-1?Q?W+2cRaxIbgIUn7NfxR3pbmXAjemew6ZWW4Ec2Mjz3Oa1YOquCnHi8QcFgz?=
 =?iso-8859-1?Q?h+qmjx/5A1YtpOdFZkYxx5hT0ayMcTEQQlLNUXacGrhw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB6PR05MB4551.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB10954
X-CodeTwo-MessageID: 0b0580ee-69d8-4101-9e72-4b3988e0ad6e.20250904131928@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 87c037a5-098d-45f8-dfc3-08ddebb5abd9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|35042699022|376014|14060799003|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?k0jFRW+ucko9cxALR9C4cTZ7TgedthGJEgLWfeqUjctDCuQ/DHOUQhLiQV?=
 =?iso-8859-1?Q?657SKmo3VFwLH9aCaHeMg987qj2NgqqzgXrHtXE1n3Eb0yhytfmERHdR8N?=
 =?iso-8859-1?Q?xH87SroY9Yy+R2lLIctublw5kuUDe7s7j30RbpuaCyXugwNHIxAmbGad6Z?=
 =?iso-8859-1?Q?yfJdSQ3hD8vv/ZE9/ApNTtV80nQjHH3oKIeR66G57kWlwhr2flXYpvwcEN?=
 =?iso-8859-1?Q?z7jlwkN2+B/VFkth4Sk+s/os0IdgiTAI8FK6ufOjNeWj/CYaEBo7mFjakr?=
 =?iso-8859-1?Q?mbtXhalF42A782Php6dPH38Aa+kLifcn2AH8hoZG+b885PLJUoR3tLTkgT?=
 =?iso-8859-1?Q?VODF7R9m7H0VfpfmBbja4m30nufKwQi3RSP9WOBlx/g1zDwLCyeJJ28mWY?=
 =?iso-8859-1?Q?sZ0Mlwzt/DW9vslLUc/HwtQiPub+knMLvoYOR9HqMPTatgzIJj4l7/8b2c?=
 =?iso-8859-1?Q?C1ZpB49dZ/Llnl+jrfd6k5CBr0Mjw3im4zT3UxEApmoOts3zHKmFpmhzZd?=
 =?iso-8859-1?Q?seJoJDWLAdcGdhk/j2zQ8rE3HOm2/c2MFJC5WzDrttq86VJAYqpnvuh/g8?=
 =?iso-8859-1?Q?T7nAv0Tfhlz+HUdPH2GQfd/Ohi/AAIngYB1M5LFZ+zMMu0fYfzIyzZDQ9M?=
 =?iso-8859-1?Q?kpCZxQwBQU5GCR/gkL/ACtAqzBzmLI2TpgtypJ77mPnTDFWzJpkPsbvs+l?=
 =?iso-8859-1?Q?uBd3XY91p5TRlS6gyrhR+rfO27aZjRAKy1C3FAmjXT74DmR9HxhLTF32bB?=
 =?iso-8859-1?Q?8XeXe02Wkm3xlTmX3LJusktMkeA3Ukw3ts9rASz0J/doUo4sliuqambFeZ?=
 =?iso-8859-1?Q?8qlcolOmuQLH+r9XxvHQ2chehRcs46dAZSz9GjuiTgYNmHTyVAx7K4NFuZ?=
 =?iso-8859-1?Q?Nt4kcA3s8pC+n8FRC8szXNIM8+9+ChMs5ge9TF9ahSoLmg4gdXZBrhy381?=
 =?iso-8859-1?Q?f/TP4+Fvg6HHQ48WHYHGNpMokCJDrvjQdpMe9P/cq17T6MCZ7Aybw0xdHl?=
 =?iso-8859-1?Q?kM2tGfX6H3U+8fnnVXXgFFL7B5zvRzJmwRUEn2iY5wEBfuWipbYwIRtgr9?=
 =?iso-8859-1?Q?fkPcA4l/p2kP/K1bY/qLk8wLu7kyrI1COAbdJ23uYODaIps5/ZvlHusSS9?=
 =?iso-8859-1?Q?zUNCF04TBO3lfyEI65HPm+6soy7V8aJx8yK/np72mUQPGo9KzwG/l8SpA4?=
 =?iso-8859-1?Q?8I1Sk4yYaX1/m8UVoZruuoqnQm0ulOZZyg+hNCdAN1ZSURnZTuWXxyiZbC?=
 =?iso-8859-1?Q?rPF3EF5CIhI5gbQgXPqru1YcPo9/DYVcgpneJBZb+WKwqsKdexkuSrhWOA?=
 =?iso-8859-1?Q?zCgKjr4cQxx7iG1EaATPEgXypnw6imV1N9sQtNs+hpsIQVWtjW1/sytfxV?=
 =?iso-8859-1?Q?2HPcYOA04ZFmug3H1JTodpFZFnRQ2YEdzZNVH2nYvir3EtNdJpDg23uj5j?=
 =?iso-8859-1?Q?hF7kSdGGgctPcxtGtFD6TUjl3UiuXePoVoXBY6FEtS/hjNl2x3cRfNr+Ew?=
 =?iso-8859-1?Q?10M6sQ+Fk2Mki2IrLm4+cGEwMPZu9dv597BGexbmC9Slr/qNIck92Ujgqo?=
 =?iso-8859-1?Q?h9FU3PXtwjvWqbVGjnwmsKOcbT2c?=
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(36860700013)(35042699022)(376014)(14060799003)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 13:19:28.6803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61198000-79fe-49f2-d0d9-08ddebb5ad72
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR05MB11835
X-Mailman-Approved-At: Thu, 04 Sep 2025 15:21:00 +0200
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

From: Tom Rini=0A=
=0A=
> On Mon, Sep 01, 2025 at 04:06:10PM +0000, Maarten Brock wrote:=0A=
> =0A=
> > Even when CONFIG_NO_NET is selected there is still need for a=0A=
> > definition of ft_board_setup(). Thus move the checks for=0A=
> > CONFIG_DM_ETH and CONFIG_DRIVER_TI_CPSW inside the function.=0A=
> >=0A=
> > Signed-off-by: Maarten Brock <maarten.brock@sttls.nl>=0A=
> =0A=
> Shouldn't OF_BOARD_SETUP be disabled in that case?=0A=
> =0A=
> --=0A=
> Tom=0A=
=0A=
Had there also been non-NET-related fixups in this ft_board_setup(),=0A=
would that also have been your answer?=0A=
I don't see why disabling NET drivers would have to impact anything else.=
=0A=
=0A=
Maarten=0A=
