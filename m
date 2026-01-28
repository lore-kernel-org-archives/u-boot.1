Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB65ED2FEE6
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 14:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C24383CEA;
	Wed, 28 Jan 2026 15:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="03x6HT3x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C00EF84242; Wed, 28 Jan 2026 07:00:53 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1484A8423D
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 07:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=radhey.shyam.pandey@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XM6q7zfe4Y9gkiwdhwVsgfxY1zTH870oy18h6bkKjypdIn2wN3R3QEoJ8ns8b6E3qE4aL8YScI053qVVZ2zzj/aFYHFL1gT7CX/WMsXVU6LTY1dVHUnbHOg2DlHBLndllC3Z8uvFMDYix44CAw6YPXrcT5cwAV6MjIgVbKE2fITmOTWAJFGPppKeB7oZYB9RCvyMZ2JOYJvOaG6PEeECqFVb970Wt/SmBXk67UdkRYx81TFYdDoXWpJRlGFS9e1L3fjONSnECU+L0WR5XHOCtihnrTRuWBcp2A6TmDOi/alahtJMgjv3OizOFqUOc7ViT9CIPtuZl3p6cAJxPqhPoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VucQsnRAHlWFxtQuHXy2zzH0g+7xh4SSbkIxhXOGA8=;
 b=Gs2uKvIrsguebimOvlr+hNiF0erXOsKJhQJ0jGCUZR+j3dYgh2AHPSKEwPGj7ISUXzWu5VYUrucuEQfqI8J4bDkUkbAb8NKzoH8pn5Hp6jd6y/SnDGYMX3cngim3gK9WH0e2H1BPUB5Wydr9qXzGpi3VswORWLcIlNO1thKdzayi4ViKQLWuhZd1IJf22SNC1cCTns420YddAxJE8f6ekk8w2IOj5UuSNfRnlPpjXkhde0gEDPBdahIWQQKYox1EdLnxE6kjPfdxpiAAF+iRegZsIdjlLnCJIPbdNmdHUGIxd72PGRnfvglFKrXjuTeVx+5vVUO0PoZnX2qGdoKP3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VucQsnRAHlWFxtQuHXy2zzH0g+7xh4SSbkIxhXOGA8=;
 b=03x6HT3xUVPtuQOj7UEfkHb9YP2oYbMdicbuQaKgKmrGJ44iiVVed6uVl2GNiEI1FpZWK1dyGqDJkJ2Sy9cP7QDVxSOJD4CzDoM+V7N4vTVMXP23ivbe5vYXYavQoEG1lbiNflzoirLpno/HEfpDoo8PjGpDdC9+s4QxW+qQU8U=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by CH1PR12MB9598.namprd12.prod.outlook.com (2603:10b6:610:2ae::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 06:00:41 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5151:8ae3:f31e:4c9c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5151:8ae3:f31e:4c9c%6]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 06:00:41 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "git (AMD-Xilinx)" <git@amd.com>
CC: "Naroju, Nithish Kumar" <NithishKumar.Naroju@amd.com>, "Visavalia, Rohit"
 <rohit.visavalia@amd.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 3/3] arm64: zynqmp: Wire gpio-delay driver for USB hub
 reset
Thread-Topic: [PATCH 3/3] arm64: zynqmp: Wire gpio-delay driver for USB hub
 reset
Thread-Index: AQHci54Jmnzd1BOh90Cboi5+CpPfILVnHyQg
Date: Wed, 28 Jan 2026 06:00:40 +0000
Message-ID: <MN0PR12MB5953A7B11BBA1F018180E27FB791A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <cover.1769086229.git.michal.simek@amd.com>
 <d9935cb8244244d60e87ea69585dbdb2654e0216.1769086229.git.michal.simek@amd.com>
In-Reply-To: <d9935cb8244244d60e87ea69585dbdb2654e0216.1769086229.git.michal.simek@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-28T05:58:56.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|CH1PR12MB9598:EE_
x-ms-office365-filtering-correlation-id: 5379d628-512d-4d2d-a309-08de5e32913a
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ktjpVQd/fFRFta8U2PvAm0dsG18endSL5UMBT11dmlkWBjq4A8Ukdo4FjhEa?=
 =?us-ascii?Q?f0HKEtO7DDfM4hTqKc/VKBFVVaRUiZeYxH39R2JvvcYSn5d3si3J3rPtdOMK?=
 =?us-ascii?Q?3j+3LbVB2uRPRtzwUEUF6uaRAFK8WOAOVhPFMPkP013kx3PdmEAtbZV4Bn8+?=
 =?us-ascii?Q?NY8Rm1Sla2BXorxqpYncQZNPD83B8AzLW/CYSDkh8fxSEDdAUq7fvZc+VyKU?=
 =?us-ascii?Q?kz5ngnXLxHXehKl45YFtFZfeBjN3dre3QvNeZSZF46Zsmb2gZqn0LWXqbjEY?=
 =?us-ascii?Q?PxWteva+D8lv/exdt0jkDpkwtVu5XHBn7HWAeE201NfQGAVZb3M0my4joRRa?=
 =?us-ascii?Q?EPcEkG4Qn1tQM0A6BS7TEccBXfxtXy5xy84gH1U3NUEAbKRuPSIYQKlNpSk6?=
 =?us-ascii?Q?KH9L96KVBTUBWWud5AhFkgs8Zwu8y7va+irvQMFq9b/GbWlMrbPKP1+9xMT7?=
 =?us-ascii?Q?mrdSVRj5S6Iuzw+1jHmp46JlTYKgyla8CotdWKJx0My12S5iqGCjVisg4Tq0?=
 =?us-ascii?Q?a+OAT6VphejBydZrmqsclTGQl6KGmvW8IpqwxgdztvAGN5qp6l7IADXqPz+N?=
 =?us-ascii?Q?1zlnMKtqf5uHM/IvB243v8HIWRF2qnJJ30sDFACzHjFzTA4AWDw1aKWnm9Eo?=
 =?us-ascii?Q?vm1+B1ZwP7ftkEpAuhdqafov6Lj4w0kOcnSp8IPx0+FJtcnUJ0xtxIcdrYAe?=
 =?us-ascii?Q?KL7TB11lyqs9OQ3ksRAmu68Vl5Z/5/Oq2gJmrJsuNBscDO18dQ5nEy+G5zLQ?=
 =?us-ascii?Q?kP/4iAPpWj02/d/QTQjGR/SzJZs7gz/hmJ3eWFqpGUkvWoCMwoc9Lc59AbpA?=
 =?us-ascii?Q?0Vtyc+1MnBVbxgZbL8ZjyZYCxgV/gveVmRI5R6QEhDimp1irinI+F5HGDJMW?=
 =?us-ascii?Q?3D4I7I3nUfG/GFvrwgTGkSSmWqAnoOERSpkRS+wappak8NT+ZnS+6WyVC4kq?=
 =?us-ascii?Q?x4AqGQtrl4nDK8p2GKIMEnoIO24cF0Lw87RI4Ch9RX2kW0zrSgKDsSsOnx9H?=
 =?us-ascii?Q?YyFR2EwVu4CAnFrLsAt0dWbRq3CQjAT11tioAfW6LAQgQNr2zvYPx5Mo4Fh4?=
 =?us-ascii?Q?ET8AxbWQoeTphc7MJEMrBUkSu+fbHcQH8Nw+TBNwvPaVudSvafgWKdwEZnsf?=
 =?us-ascii?Q?7jpWAJ5GsCKXBl6zKT22Io2IygEAkTxWLih9SmhBoHP45XHOMLEE8dgSuuPN?=
 =?us-ascii?Q?mlmWE1XwwNXn5RO85kpUE7ISq1tsMQeEtGFufl+zI9nOmE///rMUjSEOVnnF?=
 =?us-ascii?Q?3yd4Sp9OXdl2U8nAAOU3VUP10gJYnTbVrdfze5kMPcky6Lew/VNS+0ZyJoWx?=
 =?us-ascii?Q?W2NdoiGMmMho0yvYy3ZrHO2DBpzUwn2ATRdaoF1IaLNz7sSUNL9FUv6ZEn6d?=
 =?us-ascii?Q?9C/0TgWxUJpJHjI65+1MWT66qK+Q4YTBlBxDgcVudqj9Kkc3hLtooVqWcmlC?=
 =?us-ascii?Q?d3HUMEhzDzmvf7dqov1qpT23eQJUchBA3g38g4zSMJwJTNjWA3mY9o7Z3gbK?=
 =?us-ascii?Q?1L8dIMQbHJyW2BoMssqeW6+HnLsObY9gd3VXMAqgxmndm41oPjJqFWuoDfw3?=
 =?us-ascii?Q?F5/Y8hKyZ64jd8dkWuqSNUsyemHcpwvkcETxyjwo7Aa8DrsYSg+8kkA6pA4y?=
 =?us-ascii?Q?p+fIohGaH0lD/8jxoVqgitM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5953.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ehYw/Gj1977JkBgA4Wn5TAQ325Aqz4orTuX4aXbwGLJwAjKAPEj5ZRJ/s0io?=
 =?us-ascii?Q?GULIia3z1uv98UdQeEP5jg97yaLbhVGRZJEFmh92cQYOmBGm441ITSyI6AKs?=
 =?us-ascii?Q?/G8jBo4oxdNE+CJGm8NGk7D5hfEa6dqAGJ7FYPdEH2wJSTcxZxQh8brKmj8U?=
 =?us-ascii?Q?49AFpC/cIxbyDN/sMufkjeZvnTkjjirRDEOyNpz/gjnu0ph2z9M1FA4tOMIS?=
 =?us-ascii?Q?heHHlXuu6MEzdPuUjzo3ZPj62gXuXFJRTfo/2byxEAI00CrRS8qydf0VoMGt?=
 =?us-ascii?Q?3nqYL0/XtjGXhIBvRaHXFuM4Jv36+XKYLcCRX604PNRQjZcvXrKYGfq8zEDp?=
 =?us-ascii?Q?wn03r+REZjnQuyIYvFclfMo7pVFk6fnIp5CAOOFHL1TUz7WrYociEFPE2CVP?=
 =?us-ascii?Q?2ISmlgPqfSKWiMKJF8WbIUmJGny/XO7q4au3koV0DnSXeblB8IgHdxb5KlW9?=
 =?us-ascii?Q?GJR49REBnOobEXHC0DLQTKtgm3hJTgGtMoPUBcmBSAu7+Ib6+fCY3l2joDS7?=
 =?us-ascii?Q?lpDr7U5eBDBDrUK7hIcsvSeb5o2o1XU3WgTwv6G4Ycva0r6JsHpl4AmC/rIR?=
 =?us-ascii?Q?Mhkben7fs8kGdRjQdPQmESAO0ggQleYluGAOgdcezdtgYiuHOreoorF/J4Oo?=
 =?us-ascii?Q?gppquGShFaJraHnefN/2pT2+sN22TlTNon40Wq0IyVeANDAtBe0UgYsGOlRW?=
 =?us-ascii?Q?LkJgXP0tFVdQobWKvSTQb+FJ53clA3BIdPkX6sadvl8RpkaDVKu1G+LEKwi8?=
 =?us-ascii?Q?1HkL12qCO4LXAftNH9+bISA0UvEosNxtt/oopekr3eitWhQMjJ1ktbHaZoz0?=
 =?us-ascii?Q?YY+jYYYtY+IRq2KTS89IyPWbUimsBDv4Uibvs1iKBrnmqJzaozzFYJCsVkjA?=
 =?us-ascii?Q?EpWKabToas79HXyjiWFpsLp80GAOw8MaaDqBToDrA1ULGGsCtXj7Bu/Tc6Uj?=
 =?us-ascii?Q?7J0NHPSjRFJ8shPpjInEZVf0AEVqg7M6K8qCsFwux1fl9sQuBAyaQSbhEwJD?=
 =?us-ascii?Q?PbufnP4O+secd2Nmb3zrbiJ5uH1t6eOSB6g18jNjxobkRa7ERFBm9uFKm9WA?=
 =?us-ascii?Q?1uPaYL6iZWC+7kLGGRlrQrdOSzmV1dnp3n+2ktp3psOtFmyLk5BJ2gzmWQM4?=
 =?us-ascii?Q?ALQaipdrX7Tv1zmOkNyonxvo0DybSKJtYWRC+YS4RwJfawSLH5N5qcpx43xx?=
 =?us-ascii?Q?fDsZbkW7gxkn+BYvHA9EMV0rE6O+UxKhGZz7+JOxMhQXLTkrEjnqEB/TdqUy?=
 =?us-ascii?Q?aVvcHbTm2H9+pJHFpP5RILIYSwm/2lsSUtICAFJ0+xMGsCGPr0ht7oa1z8R0?=
 =?us-ascii?Q?b5Jzc2RND5MjLrvDlCfLIsuqcPHASJ2yVGEfppj9dsX1BxsOXUgQdkT1mm+/?=
 =?us-ascii?Q?QVZhjjbeULd0DzKZUnzbiyxRjyS0ujx4XOsX4Go3zbFNZw/3E0yUtWIdY9mr?=
 =?us-ascii?Q?VO7ydByJVfo0e11lB+ywV3Zwr1FcpffxG62cOxmkIfrJKukBOHD0a7mwlNej?=
 =?us-ascii?Q?IsNFcZpksiq7VzT4ZlGdQC56fciFDZW3DDt0xxQHcWiyekKeiNiAkYVY1lBO?=
 =?us-ascii?Q?J5B4LzQlK9Ne1BSxzTmrd0L2pR+KlPI2IHR0VyhvEo7s11ig8mN2f3qkLE2w?=
 =?us-ascii?Q?qSz96QsylL06ov5sPkBfXLR4MnbKJKYZWEv7jL/8oanjghvBq3TcBSvwwtS8?=
 =?us-ascii?Q?xLfUV+obEvCDfqBHg9ckDPFjMkeNlI3+QBJPmqnukfbOC1YJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5379d628-512d-4d2d-a309-08de5e32913a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 06:00:41.0541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BggMIMFhoij0V0ey6sBDMCxU6irSJsHo3bojHnRwzWsPnU2Mu/8ZYkHjNVnWH74z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9598
X-Mailman-Approved-At: Wed, 28 Jan 2026 15:01:19 +0100
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Michal Simek <michal.simek@amd.com>
> Sent: Thursday, January 22, 2026 6:21 PM
> To: u-boot@lists.denx.de; git (AMD-Xilinx) <git@amd.com>
> Cc: Naroju, Nithish Kumar <NithishKumar.Naroju@amd.com>; Visavalia, Rohit
> <rohit.visavalia@amd.com>; Tom Rini <trini@konsulko.com>
> Subject: [PATCH 3/3] arm64: zynqmp: Wire gpio-delay driver for USB hub re=
set
>
> USB hub requires longer delay to get out of the reason to work properly t=
hat's why

Nit - reason -> reset

> use gpio-delay to ensure enough waiting time.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

> ---
>
>  arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 13 ++++++++++---
> arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 16 ++++++++++++----
> arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 16 ++++++++++++----
> arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 13 ++++++++++---  arch/arm/dts/z=
ynqmp-
> sck-kv-g-revB.dtso | 11 +++++++++--
>  5 files changed, 53 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp=
-sck-kd-g-
> revA.dtso
> index 832dc5ab2458..8342479b108a 100644
> --- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> @@ -3,7 +3,7 @@
>   * dts file for KD240 revA Carrier Card
>   *
>   * Copyright (C) 2021 - 2022, Xilinx, Inc.
> - * Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
> + * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
>   *
>   * Michal Simek <michal.simek@amd.com>
>   */
> @@ -43,6 +43,13 @@
>               #clock-cells =3D <0>;
>               clock-frequency =3D <25000000>;
>       };
> +
> +     slg_delay: enable-delay {
> +             compatible =3D "gpio-delay";
> +             #gpio-cells =3D <3>;
> +             gpio-controller;
> +             gpios =3D <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +     };
>  };
>
>  &can0 {
> @@ -116,7 +123,7 @@
>               reg =3D <1>;
>               peer-hub =3D <&hub_3_0>;
>               i2c-bus =3D <&hub>;
> -             reset-gpios =3D <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +             reset-gpios =3D <&slg_delay 0 10000 10000>;
>       };
>
>       /* 3.0 hub on port 2 */
> @@ -125,7 +132,7 @@
>               reg =3D <2>;
>               peer-hub =3D <&hub_2_0>;
>               i2c-bus =3D <&hub>;
> -             reset-gpios =3D <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +             reset-gpios =3D <&slg_delay 0 10000 10000>;
>       };
>  };
>
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp=
-sck-kr-g-
> revA.dtso
> index 532f6bf92bc5..db042ffb4f36 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> @@ -77,6 +77,14 @@
>                       };
>               };
>       };
> +
> +     slg_delay: enable-delay {
> +             compatible =3D "gpio-delay";
> +             #gpio-cells =3D <3>;
> +             gpio-controller;
> +             gpios =3D <&slg7xl45106 3 GPIO_ACTIVE_LOW>,
> +                     <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> +     };
>  };
>
>  &i2c1 { /* I2C_SCK C26/C27 - MIO from SOM */ @@ -187,7 +195,7 @@
>               reg =3D <1>;
>               peer-hub =3D <&hub_3_0>;
>               i2c-bus =3D <&hub_1>;
> -             reset-gpios =3D <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +             reset-gpios =3D <&slg_delay 0 10000 10000>;
>       };
>
>       /* 3.0 hub on port 2 */
> @@ -196,7 +204,7 @@
>               reg =3D <2>;
>               peer-hub =3D <&hub_2_0>;
>               i2c-bus =3D <&hub_1>;
> -             reset-gpios =3D <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +             reset-gpios =3D <&slg_delay 0 10000 10000>;
>       };
>  };
>
> @@ -224,7 +232,7 @@
>               reg =3D <1>;
>               peer-hub =3D <&hub1_3_0>;
>               i2c-bus =3D <&hub_2>;
> -             reset-gpios =3D <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> +             reset-gpios =3D <&slg_delay 1 10000 10000>;
>       };
>
>       /* 3.0 hub on port 2 */
> @@ -233,7 +241,7 @@
>               reg =3D <2>;
>               peer-hub =3D <&hub1_2_0>;
>               i2c-bus =3D <&hub_2>;
> -             reset-gpios =3D <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> +             reset-gpios =3D <&slg_delay 1 10000 10000>;
>       };
>  };
>
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp=
-sck-kr-g-
> revB.dtso
> index 458d79e81192..e3567d0abfe0 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> @@ -78,6 +78,14 @@
>                       };
>               };
>       };
> +
> +     slg_delay: enable-delay {
> +             compatible =3D "gpio-delay";
> +             #gpio-cells =3D <3>;
> +             gpio-controller;
> +             gpios =3D <&slg7xl45106 3 GPIO_ACTIVE_LOW>,
> +                     <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> +     };
>  };
>
>  &i2c1 { /* I2C_SCK C26/C27 - MIO from SOM */ @@ -188,7 +196,7 @@
>               reg =3D <1>;
>               peer-hub =3D <&hub_3_0>;
>               i2c-bus =3D <&hub_1>;
> -             reset-gpios =3D <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +             reset-gpios =3D <&slg_delay 0 10000 10000>;
>       };
>
>       /* 3.0 hub on port 2 */
> @@ -197,7 +205,7 @@
>               reg =3D <2>;
>               peer-hub =3D <&hub_2_0>;
>               i2c-bus =3D <&hub_1>;
> -             reset-gpios =3D <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +             reset-gpios =3D <&slg_delay 0 10000 10000>;
>       };
>  };
>
> @@ -225,7 +233,7 @@
>               reg =3D <1>;
>               peer-hub =3D <&hub1_3_0>;
>               i2c-bus =3D <&hub_2>;
> -             reset-gpios =3D <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> +             reset-gpios =3D <&slg_delay 1 10000 10000>;
>       };
>
>       /* 3.0 hub on port 2 */
> @@ -234,7 +242,7 @@
>               reg =3D <2>;
>               peer-hub =3D <&hub1_2_0>;
>               i2c-bus =3D <&hub_2>;
> -             reset-gpios =3D <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> +             reset-gpios =3D <&slg_delay 1 10000 10000>;
>       };
>  };
>
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp=
-sck-kv-g-
> revA.dtso
> index e7417af8ae01..f93c7460a552 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> @@ -3,7 +3,7 @@
>   * dts file for KV260 revA Carrier Card
>   *
>   * (C) Copyright 2020 - 2022, Xilinx, Inc.
> - * (C) Copyright 2022 - 2025, Advanced Micro Devices, Inc.
> + * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
>   *
>   * SD level shifter:
>   * "A" - A01 board un-modified (NXP)
> @@ -78,6 +78,13 @@
>                       };
>               };
>       };
> +
> +     slg_delay: enable-delay {
> +             compatible =3D "gpio-delay";
> +             #gpio-cells =3D <3>;
> +             gpio-controller;
> +             gpios =3D <&gpio 44 GPIO_ACTIVE_LOW>;
> +     };
>  };
>
>  &i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */ @@ -161,7 +168,7 @@
>               compatible =3D "usb424,2744";
>               reg =3D <1>;
>               peer-hub =3D <&hub_3_0>;
> -             reset-gpios =3D <&gpio 44 GPIO_ACTIVE_LOW>;
> +             reset-gpios =3D <&slg_delay 0 10000 10000>;
>       };
>
>       /* 3.0 hub on port 2 */
> @@ -169,7 +176,7 @@
>               compatible =3D "usb424,5744";
>               reg =3D <2>;
>               peer-hub =3D <&hub_2_0>;
> -             reset-gpios =3D <&gpio 44 GPIO_ACTIVE_LOW>;
> +             reset-gpios =3D <&slg_delay 0 10000 10000>;
>       };
>  };
>
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp=
-sck-kv-g-
> revB.dtso
> index 7a05180e58b4..70de6933600e 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> @@ -74,6 +74,13 @@
>                       };
>               };
>       };
> +
> +     slg_delay: enable-delay {
> +             compatible =3D "gpio-delay";
> +             #gpio-cells =3D <3>;
> +             gpio-controller;
> +             gpios =3D <&gpio 44 GPIO_ACTIVE_LOW>;
> +     };
>  };
>
>  &i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */ @@ -148,7 +155,7 @@
>               reg =3D <1>;
>               peer-hub =3D <&hub_3_0>;
>               i2c-bus =3D <&hub>;
> -             reset-gpios =3D <&gpio 44 GPIO_ACTIVE_LOW>;
> +             reset-gpios =3D <&slg_delay 0 10000 10000>;
>       };
>
>       /* 3.0 hub on port 2 */
> @@ -157,7 +164,7 @@
>               reg =3D <2>;
>               peer-hub =3D <&hub_2_0>;
>               i2c-bus =3D <&hub>;
> -             reset-gpios =3D <&gpio 44 GPIO_ACTIVE_LOW>;
> +             reset-gpios =3D <&slg_delay 0 10000 10000>;
>       };
>  };
>
> --
> 2.43.0

