Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DBAC3DA42
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 17:43:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E79B8854A;
	Tue,  9 Jul 2024 19:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="OgJkmV+i";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OgJkmV+i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87843874AC; Tue,  9 Jul 2024 19:16:41 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3199888651
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 19:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=YeoReum.Yun@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=lRkkO+cBatFzDFsoeR4S9f8bFuxb9reX6THbL7wlZuf9JqRd+Z4EQXjStbkW0Vw+QlQ3Njr0Rk1ezb3aHh+xhxyP5vKS1OaGTtKAAQBey/HpzFviUvE2ZxzcQ1mbC1uEA5SLpbCsAE3THRCdzlfVt5QbXv1cbWoBLzgJRI1U3AV3aDSEJyt4qRKpkzuXosQY8T2cWv/oWReS0J7aqWymT1/vi0W7bW1ZSHI7aCJ3BujRu+t+y2qCoxnjMezohvuqwndcUp/RY36CE5EamZAIPYTb6EVKD8p9RIbdX894haLg0NJhgJ2KJiO9XJHfE6wf7vsEZIPT7/yxD/gqBRCHpA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uBojYtxnZgzk+zQ7j3izHytXlBp7V+WLeAvotNJLak=;
 b=KkloDUWQoTUcz3DOR6UjB7YOsEIp23lw46zWIEaHMM1iyCE50eq7CT9yV8vTZR8gMuLyfQXhUi0y3Kc3ZAIH6eJEq/7Hud7USucFxw3pNF2REPvpWbyD7S5ByLEwiF+qlhhGbCszdpN/pMIKchZkz/A7O1WmNbRzRLC/cdLrQ76pCU1y87I+p7EGy93/4woyCDlHNWs3xc5pLQrpdK5DWzjdfXZwKI3QOmiA8d6jL5hZUDauqkOHEoDoQZgEcqDqvZcUW0dYisSHxi+jeiE07IZ0MRLn54A3FBBWW4cC08zzXYixB/a5hzO1ZG+vhbFg8jjaM4hGT6ZUh30eCzdFXA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uBojYtxnZgzk+zQ7j3izHytXlBp7V+WLeAvotNJLak=;
 b=OgJkmV+iX/ciuwTDaQ6/No8pD2y3K+br5HpoNmPSlDL8BoTxlkdljFYPAzZSwxHQuAHTSaEkDx8zPorzuX7fsEZYOU/30XVqXhm2g3ZeCBu3QcnC3zhtVjluMiYB1MSCY+AjISuVxA8mYoQ9hGHlzGjr1C5C95APJmVQXhxMXcw=
Received: from DU7P191CA0004.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::10)
 by AS8PR08MB8947.eurprd08.prod.outlook.com (2603:10a6:20b:5b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 17:16:36 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:54e:cafe::2f) by DU7P191CA0004.outlook.office365.com
 (2603:10a6:10:54e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Tue, 9 Jul 2024 17:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7741.18
 via Frontend Transport; Tue, 9 Jul 2024 17:16:35 +0000
Received: ("Tessian outbound b2522d7cfa6f:v359");
 Tue, 09 Jul 2024 17:16:35 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b57888709485a0df
X-CR-MTA-TID: 64aa7808
Received: from af5b5ee58a99.2
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 70E24525-F4DF-4631-BCBF-83BBA26E5648.1; 
 Tue, 09 Jul 2024 17:16:23 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id af5b5ee58a99.2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Tue, 09 Jul 2024 17:16:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROR5yLNQkuZa+NT5K4GYT4LuRwxxSYf29QhKJgJ68LV+6ED00uP5u/Gu4c6CPx5tjYjLq4+JQtGA6oFojldkIzsy0wBYf4IsdfJ1uYil+7LCefso20ld3pBUxlwODun+R4biwsmWaUVqAMFNpr/8aPfy8/IeLFN7fMXDnPfks4kRhInU4Ty18qMVbfMKcPxSvBN4zjzMJ04reV3HTLehUoK5kqETJ8CdUAGSXSSrKHscismFQze6x2DXnagzDT2vMA1kTUICEbAy30hchHMaICS6GxSltoUQ/eum9pEu69nccYwsgYeEwFPVTuDzFSczmjCO2hNiBGgqQGMLNtwWcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uBojYtxnZgzk+zQ7j3izHytXlBp7V+WLeAvotNJLak=;
 b=OVHssXx0eznldu4OFtG734daeteaxLlr1WQTQ1Pxu9txfRGd8O6l5y1t1isD2jVFkEw1OAcHDWSHISj9UoW7HK5a/Os1G+TYPHCVC2/leAMLh+RVb8tWsQ/BCjEnHbwbJpTNE+E/RrXBGmUydlZSUwkJHBeLPTDOvvFZyex9Eadv+94QIDx4b09qgJeLpkdFx1k2gjqEaRGZ+/jNP9YBU46dDU2tAr+PiL9VPy/6rTi0PpLISPmFaW9Nywxlbszkll5SEWn0jiHfPGjKSCTdWJmuxy7vp5UqSws97MSUNbhkInQ/6mLdlnoHiJPgOj22rNbA/BlHWgVJpRbj79Lwow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uBojYtxnZgzk+zQ7j3izHytXlBp7V+WLeAvotNJLak=;
 b=OgJkmV+iX/ciuwTDaQ6/No8pD2y3K+br5HpoNmPSlDL8BoTxlkdljFYPAzZSwxHQuAHTSaEkDx8zPorzuX7fsEZYOU/30XVqXhm2g3ZeCBu3QcnC3zhtVjluMiYB1MSCY+AjISuVxA8mYoQ9hGHlzGjr1C5C95APJmVQXhxMXcw=
Received: from AM0PR08MB4289.eurprd08.prod.outlook.com (2603:10a6:208:148::12)
 by AS8PR08MB6117.eurprd08.prod.outlook.com (2603:10a6:20b:292::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 17:16:21 +0000
Received: from AM0PR08MB4289.eurprd08.prod.outlook.com
 ([fe80::507d:582a:b779:1b83]) by AM0PR08MB4289.eurprd08.prod.outlook.com
 ([fe80::507d:582a:b779:1b83%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 17:16:21 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Raymond Mao <raymond.mao@linaro.org>
CC: "trini@konsulko.com" <trini@konsulko.com>, "sjg@chromium.org"
 <sjg@chromium.org>, ilias.apalodimas <ilias.apalodimas@linaro.org>,
 "n-jain1@ti.com" <n-jain1@ti.com>, "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] bloblist: Fix bloblist convention checking.
Thread-Topic: [PATCH] bloblist: Fix bloblist convention checking.
Thread-Index: AQHa0gN4INcUrc64ME2JLLc5F5/sc7HuczoAgAAv2/A=
Date: Tue, 9 Jul 2024 17:16:21 +0000
Message-ID: <AM0PR08MB4289A2EDE199614C04D77FC7FBDB2@AM0PR08MB4289.eurprd08.prod.outlook.com>
References: <20240709132516.2427654-1-yeoreum.yun@arm.com>
 <CAEfUkUKQGN3NBomwAkyP2fD6e6MoCrsiav3cS39gVxM43JHrXg@mail.gmail.com>
In-Reply-To: <CAEfUkUKQGN3NBomwAkyP2fD6e6MoCrsiav3cS39gVxM43JHrXg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: AM0PR08MB4289:EE_|AS8PR08MB6117:EE_|DB1PEPF000509FD:EE_|AS8PR08MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: 8431374a-60e2-4136-a01c-08dca03ae31e
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?iso-8859-1?Q?u9EFOFQCvqiYurXXillgiEValsyJwCFF1dLTuLMBr7X1gU3bi+nv4s/GWJ?=
 =?iso-8859-1?Q?yVo3imaZ0Hdwt63t3YUMYnbepvsoncWVj+lrWjpv13abjbEBIjp6HzRLWK?=
 =?iso-8859-1?Q?ZxKQytPozrFIvgt6rjODvwdRZT5mXJSdEuh9oppTimGTmyjPV5z5EeUIR6?=
 =?iso-8859-1?Q?fPCP00c4VTOAVxm7sz6JYZY0w76+h+o7sAuzHOSv0paYuVZKFOVn+TYt6Y?=
 =?iso-8859-1?Q?VeL/Mgw7vNjVMLZNlwMJuqZf+zIoMjQOrvslWoAb4MhbJ8L+Ei6rbgDRRO?=
 =?iso-8859-1?Q?MjMprqLNMKZIVg2qXKDV/A+4N5oVsyGC/TvnDOAs6m87oWO/yEo0NmZodm?=
 =?iso-8859-1?Q?pCNOWjJj5HqldB99UPxqNbuZh1Br8zBVK0HlCLQbdtBKW/YVqnR8axZnEo?=
 =?iso-8859-1?Q?yP/5sZ9hZPNzaF7C5s5Lu4+wqOh+BrW2ITD4OBrC5yXyeMst69EK/LrJ32?=
 =?iso-8859-1?Q?3VuZOOgo2y1EdeJnGY2RMMWfeEGEUFBNjRKl7EluFV5MKN6cEQkCNKSaHz?=
 =?iso-8859-1?Q?xxEmRza0V61SMspdlnoRq8SDmGta1SF80+P1Kzg8RvvQJCH6BC/HzbbEwD?=
 =?iso-8859-1?Q?lKjuXeme7ZCpiCOvAwtpNYQif+xvtL/GttHzWwiMwkG39btdPJ+a7zlUbl?=
 =?iso-8859-1?Q?RtzFpEPgswH1JxzMCh6zGwoM2sp8mh/8rYo6fUEJGSjSs5K4ESHNxq6y6i?=
 =?iso-8859-1?Q?hWAdzqy4JNpVQbP4cfM/DJQpJI77DqPm+v8zcKmrN7fVrjUdslMPFic0q0?=
 =?iso-8859-1?Q?E7rNyvZFerqQrFsfdmkVHozj8zavRWhNol4pBzP1jGsrCpAS9vSs0siWwj?=
 =?iso-8859-1?Q?OEwtUqTZlJB/QEXPeoMT5vWSrUYgtNKJCbpFfa14og3LXZFLH38oNmHj0I?=
 =?iso-8859-1?Q?l/F8v0B8oGVkbsJkIm+COWQL5F1LztcoEjXc/eEl/DxyeMjDgVsMpNlL5Q?=
 =?iso-8859-1?Q?6zAZXgidgjmbXA6C0JSw+TNqt112iSzOtIWRTAXHPUoZcUGi+J20G9O425?=
 =?iso-8859-1?Q?gbHsnUbeRn5upM/uuDdawTpCThANH95ViagGsKITa31zosd58fG3ooNyoG?=
 =?iso-8859-1?Q?rUPL7d5SJ9PE8Bv6AVl65Hz/4IOru/VkH3zk8gk932OPiY4hDdNuiAKjc1?=
 =?iso-8859-1?Q?+GFq55YEfOvzpoCKBiqLgwPD6YSf+S4fBNVkypW0Y7JRZpjXeQXRZoOTPZ?=
 =?iso-8859-1?Q?wpYTdQNcHkne4/WfE0RMOqWste4pY9hNVvkCf+hVdf3Plpwz9Qodguex2i?=
 =?iso-8859-1?Q?tMrmPJXkatdKBjvhX7eGGFIlVDZkf8puedliNQSYhJPfqQIvDeMJyjkqrp?=
 =?iso-8859-1?Q?Pk9aprn9MZh7k+k0HyFimP90JvIwi3LUU+NAB0Y3PRJsAbBaI/slLixdGz?=
 =?iso-8859-1?Q?G4rdiUMG0J40DOY+idACC+6/IckramQUPELxfOO9oh/WZOhtlxcvdfdKXa?=
 =?iso-8859-1?Q?XWBF/z4jUlLvHd8Spdgl7tQ2ifntvNm2ldzlLg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB4289.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6117
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 816ee990-f07c-46f6-8582-08dca03ada9e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|35042699022|36860700013; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?5HCTfyphmO3DejpDw8lFZ29+1mGHh/0ESN5cqLTiA5qBhqrQTL1IecwnXd?=
 =?iso-8859-1?Q?eFPTPBeFqZPls1pvaD53SQtMab6twgZ2eY0dOe9uF6EWSaaEtEx2oXKDnd?=
 =?iso-8859-1?Q?JabZrm8+S7smX2sckVZcYEO2cubQJrNf3HvFsmSr100rAmRpZnkfh6mCKu?=
 =?iso-8859-1?Q?aIYi31tc8ChZtJniFI/o/oFVNmDl49oXOYoryWgadPGr39tjajXsOCv/kQ?=
 =?iso-8859-1?Q?X5By5xJ5u3u0RnWsMGSOEz99lUiwIg5ESbG6rSHmGuL520/LfcJXOEEpOU?=
 =?iso-8859-1?Q?DKK79KLNJwv9MIZWE0bZkPvF8KdEWvU9u3YUwuPYKsFBLdbjv5npXjuEsf?=
 =?iso-8859-1?Q?FrTmyOuTZfv746US7Epd3OLKlYOiYhbcjcqItLpqIbHtfzk2/1atn77T28?=
 =?iso-8859-1?Q?RIVY8EAg/QllHI22+P4hCNnJwC0g364gNSDx/rU9yzymZ5ZqMGyUznl55s?=
 =?iso-8859-1?Q?YEf0YWGjFwyVNVKczC7Hld6Uw4F0UPctTg6Q4wU/T3e1/UbNoeI/HraQGE?=
 =?iso-8859-1?Q?tH7a1Q0j6aGYDQvQfooMw/2mMg6sWXPUgSq+tNlMGOtdcMgxMxJ1Ju6evw?=
 =?iso-8859-1?Q?8Ot5fKGSSVeYP8hLJDdBQvQPMHGyr26lN6w6k8naVv+e6O6+JOJ2vbEftN?=
 =?iso-8859-1?Q?5shU8A1Kf9pf2TETXzmNztv5xbNmlO5ccZeLScMrq8i7z5BwCsMS6/p1k7?=
 =?iso-8859-1?Q?bpAMb5KZMOZVQ39PYzx+lAGSGyhehaaJMRdtBoFG5ZR2qnjGMskMM90zhQ?=
 =?iso-8859-1?Q?R2i+xjgK1hysyksZOsXfre1LZlkAKRGy8brGvQvAbEHMRShArwnT42NKiu?=
 =?iso-8859-1?Q?2UcQIXdDiPHUr7wPQMiZUwwAlC/IMixnyboQ7X8FUOu0yYT7yAno8mwbby?=
 =?iso-8859-1?Q?bvZSS7KUpZh7F1MQLnIdYL+tbhM1cbTPfQE2GEbxrcjo3RVkCya6FamSzK?=
 =?iso-8859-1?Q?VA52EL0VCcmwlje9dlm2uGQ0vUdHUx0KGo+ekU63+ks1y4Vttx/6TGpIWN?=
 =?iso-8859-1?Q?26At+59kpjJOPdGwkOURcIXmOQr+m7LUTIiFOGylPAY/XAawu+GNtrAoEc?=
 =?iso-8859-1?Q?HmbSGC1ca3+QDhsZHV9SXOi90jjM81sdtOs1U9JT+7VIip6o1EYQJw0enP?=
 =?iso-8859-1?Q?uTHcYvH5hIP9cqG9CYfIWGjv1AdnXsjA1b9xAelWWzht4vmbuP8laaHmfb?=
 =?iso-8859-1?Q?NCvjqHgAU1pUKQNx8uYqFtzGcEnqx4elQfJxdf9CR3jAF5alurypsDnuri?=
 =?iso-8859-1?Q?USWc4VMjgNZp+uV1wOxiSHA4NEvefJiNPazHt/70XK5vsT3MyLNnC0mmuN?=
 =?iso-8859-1?Q?BN58f89v2weBZHuYJ2aPzmzRqWxx4gG7KHP7cFVKgEsp5gLaFc0Zpomm0r?=
 =?iso-8859-1?Q?YU2graq9q7YGBryFPllvTuFz269GGZAc0PWY0ubSZ8YJhldTPQHJe8DcnF?=
 =?iso-8859-1?Q?zC2QRP5CGLZ03BKbc84PQN4nGEYTwaHfT61NVf9cNptuFDF89YPGWt18Y8?=
 =?iso-8859-1?Q?y6fi6IST1ATUXIwa8C7DuO?=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(35042699022)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 17:16:35.8750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8431374a-60e2-4136-a01c-08dca03ae31e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8947
X-Mailman-Approved-At: Tue, 09 Jul 2024 19:43:34 +0200
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

Hi Raymond!


> The handoff of armv7 will break if you swap arg[0] and arg[2] here.
> The args are already aligned in the correct order via the assembly code.
> Please see the 'save_boot_params' function in start.S of armv7.

Thanks to let me know. I couldn't see that code.
But I think before checking transfer_list, It would be good to check conven=
tion first.

So, I'll change order only.

Thanks!
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
