Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D348D778B1
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 01:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE33383DDD;
	Mon, 26 Jan 2026 02:24:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gMkSgKvW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CCF483DFF; Mon, 26 Jan 2026 02:24:48 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5706A83DB6
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 02:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oayEXshI+cQV8hDfvcZP1z1ZoX8RnvmSZA0nDtEiQVDBzU7RmuEcI2ANl99puYEvq/7H9OYKYZc7CO0KliFO9iXUyyh24UYLkohDpyAH1yTGZAv6Ms5qRNwtkFQxpyqyOLGSdLMkJzCFmOQRxOfXZfuSbpppqbghZEFBQdIm54ezIc9gnbLbl1IWXeOWnAbpcq4gw7nx147HXNSxk9tAHdmv4np/uvggYMlvEyc4NFq9nzxYaf9hTFfJ1nBJAEAIXuAYwWQ5YDyHeSHi5tIisxzvhFeaLaUknAyaJ+KHx1KI/z+QYBDgh9QrZ7SGPZSviGvIiBvBIEnHmeAxrF/WuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ti6a4n+jJQnDgh+9vaqVEdZaulElbNwrOAQQpBMJXE=;
 b=KX4+P+bvjqcmhUcg2P8LqCGaiparRGDbBQGCJ97vxukPU0tu/HCRKasi72hYUmXf8Ya3w6vLOgXJin47I27uKAkzXMXnBnihhy7U9yL71Pyz/5c2+IIbeV2CrTCeJ6nyHmRD+YxxujumNHsI9xjwlqVRklOWOAqXw6HuBeBj5YvzaPGzjKvb/R+UklhZtL3HvibuxpVoeGHL7DXYYpwRiiyU/i5P0zht3Jv9+wD9SzmEgfe8PHMiS1dfQilTiA+1D/gskPudweqTyfnVJPgh38jzHpvi5kvbk8L2sl8WKQ0fz9VjZPBCdVfpL/Nn4fTTqEzr1sQLbPFMIdUOycNXVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ti6a4n+jJQnDgh+9vaqVEdZaulElbNwrOAQQpBMJXE=;
 b=gMkSgKvWTYGY1HBaHRXb2VVfHSMJEGGrJFOnjWFVG38YV/u/00tUVh+hAk1AVcIaoD5gHkQ4Fd/gKPtTxLssq1uThDUnc5C3bejUOKgvBwwOlbvc2N5ISpw7LzO/4oxb5cUkKzWQEYiVoV083wSWIxoTO/4MtEpGcmFdHMuL/I5pHLIXsBRj6TSb4yGR4qb/u3bnNljg2v+5eoQHNPdsnVklm6JGfaSA727vzgG4ngsrsICYe4gSTP7YQpBogjSNauSAAMEyqfginOaqhu19+oHam1rT0Y9HX0dpfGpVtrOQQhm69QGR4BtkzNSZ0uHMrOod0k+HSSPD8+t81QN4Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 01:24:45 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 01:24:45 +0000
Date: Mon, 26 Jan 2026 09:24:41 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: Re: [PATCH v1 11/11] siemens: capricorn: protect environment
Message-ID: <aXbCWebLaRhqWr16@shlinux89>
References: <20260124055452.8799-1-hs@nabladev.com>
 <20260124055452.8799-12-hs@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124055452.8799-12-hs@nabladev.com>
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|VI1PR04MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: bf13011d-2a77-4113-eba4-08de5c79b044
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|19092799006|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wwql0CD0/g3S1IX6GrtJ90XXmOLjgW2O/vax7S55Gij70++KBaq7EMmtwUvY?=
 =?us-ascii?Q?MZhxjbc+0UiBngT5Oy0hd5gFXOtQ+2kQ0JKirvo0ZKDLmj3L/bc2n54GS/Rc?=
 =?us-ascii?Q?uwdADv34K2ExUToKzF25Q2jEL5Gbr3WtXMACm4iQPZs+CyoH1KodETPTLLxo?=
 =?us-ascii?Q?Mfww0SXvdcS6jC7CmKwzplotEBMp2r4opUjjfvTsju2+zc31wiZyBH3NpouV?=
 =?us-ascii?Q?KlZ4bZekIjc9cV6Ows/O4kmVooytJxz4cq53WEuGc7cRXii3OLaBHVCD7rL+?=
 =?us-ascii?Q?9lCq7f6ZMvuBNPVTtzKGh1/PUZKW+PWNTnVRuzYReYnD2fj5JbLpZ0cLoYom?=
 =?us-ascii?Q?aZ/W2GQgMo4cgVOfLfkT2ME9t8pSO2o0ACLzrwEvfzmrKSKaITzHhvJ70PI9?=
 =?us-ascii?Q?0azAdaaTuZO/22cmSc5U7PJ+N/jeul8N61KsWHP+7NsC2IrbxMoHA8ByKa3x?=
 =?us-ascii?Q?xJZL9wq4ovGwoXrmMJIVjSAK4/BmFmI6jCdZY12/1DZGrYIQH00bX2QPMZvf?=
 =?us-ascii?Q?tlNaJ5UwQ5zdtw8Wo1RX2bJC2JCk2pgPuF2onRwCP5rI1Oss/x2ryJB0/UP0?=
 =?us-ascii?Q?E+sAk0BzJSv7v34nyjOeooK3OgkLobq48S69IQYSoWIdP2SNBA3C4iGZTOJ2?=
 =?us-ascii?Q?6BopKyUI8Rf5qVrADmULgwqHww187AD+aArIWNxjeB6im68cmA1xu2XbmWsE?=
 =?us-ascii?Q?jHkUKXd3ds0bYNLH3onJF1hkueClfIwCVfhJtxIwSxn55uMgonLo6t7ur/rj?=
 =?us-ascii?Q?rmBj0lTdQu1Hl0xbNa9Vl0DVBaM+VyKplOnVrtnolVmilZxFo+aSM8cTkZNo?=
 =?us-ascii?Q?375IzacMi1KZeG77Gd8UPKATUhmz4kAroLEYX7kXrlO2PWNxgKaPzK1OaL3+?=
 =?us-ascii?Q?sB5mX9NwUxFLVnLuX8Cc43DcYtwAX7+SiGMvudfQDafbYvnF3ZS9KfNPAywl?=
 =?us-ascii?Q?zYTGhqFl8wHM8mXsySpakC0m85z8HvDHiPAqGXHw/SoaiI9fNxIhV3wKVdqe?=
 =?us-ascii?Q?r9zF5Ni06krsdeB5dBdiQ1KAxyKo4dR/KTyRqzfP78dq5GdczY6/6zAS4Lku?=
 =?us-ascii?Q?N7oZi7bfFlanV594mdztwFpYfTenKgu1vhF7XVcBjO/09K4j1TxtDAMKg2tG?=
 =?us-ascii?Q?gFHy5gp4NlWvr64InoygOAKbOIvHyhJFrmvC6+nqCq8HiId9isvugZ1xFeJx?=
 =?us-ascii?Q?nRcPjQVmugdJ1d62IVCzPgByJSI+wN01GQ0goG6L4TaK78VpJKmfRtYhg8Ay?=
 =?us-ascii?Q?jtSIX8SKMogDGxy97+up1FrMyddYtv33cK5gM+Dz1G19X8EK88ZezEzzhYcR?=
 =?us-ascii?Q?hzFEP54iUKheK2JA4uelxmzJGFSiyakBzwIARlChCuHhsMgJv+OCNMrWJVTE?=
 =?us-ascii?Q?pLnBEnF9/KTQ10B5EeoEgivYextyXNkstPvJx/ZZQRbmUSgNKWAqVqzmpaHL?=
 =?us-ascii?Q?VP+c3tha80Rz/GiBRKleZQeX0wosnpxfnUhdCu04YVQ0X+Z1+RmtKzwB7qb9?=
 =?us-ascii?Q?6IR2uHKdekjb/WnFtqRDtSkuzwRQIZIEWdDe/fQ029HASIV2cScNRmzkrcHh?=
 =?us-ascii?Q?iz7njSG+XaZJC84AN/7vaFOdiA65YJBlgZ2VeU6AO5oNZTzlWz33K/4aw/xE?=
 =?us-ascii?Q?T0QoGgW1hcd8flpdDoBsuj4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(19092799006)(376014)(366016)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fmWCX9KpGIZBcw20dhyquL6mQcOxKs8ZTPxl7LGsbR/fyW7SEaM6RfL4kCDE?=
 =?us-ascii?Q?AqPJwt4gWpewv1iVCsGxFdh8/uL4NY0bDLw+n/HI3DyYE8OT3L0poEMi5HVy?=
 =?us-ascii?Q?T4bFe79JouBQg9NlqLtxZqwaZx/deBL+BFnuYb9gbHRf/1yfPlKYiN1IlX9R?=
 =?us-ascii?Q?O6W0eTphNIiTzU3dlccKY9kyU2/0N3U6a1SqZZqrABbCRUOLAMFFCmP4GYiS?=
 =?us-ascii?Q?ZF48jyaANmuAyrbFKmNze4N0D9aEgU6qTM9+6Z8AxwsrOxUOopg1DeEQ3QKG?=
 =?us-ascii?Q?ILc/CoSLVYVZvm0e2/AAzMQwM5+hRvSPXCwOQw+0nrCq88bgAfvLK9iZHqo1?=
 =?us-ascii?Q?eauEEqn1i4/2/QQ9NBCkZ/edfFAWbL/q3/pgaie6E7Nj10km3lAAKTjWk5tE?=
 =?us-ascii?Q?XwZD8wHInOjMw6GwKi5GRAaEugYDBEBh0nIAWSraqWUVLYKVPsRndPgbNb0C?=
 =?us-ascii?Q?sgwMY8Xfriv+6sk2gN4vc9DvDBvCsM3m81UXa595/V41fEbJEklZr6GBuE1S?=
 =?us-ascii?Q?HgNYnHDcbo1WIhKFogjeZB+Oeq6jlrkkm26LjKsNvZHCOFS35wkqa4sEkEZ8?=
 =?us-ascii?Q?4gP9zjF0rP2JQCSMgRvz9bT0L3b1n/yyF7Jdzih/cBEjudfwDIF2Uey8fVkT?=
 =?us-ascii?Q?gCM7cWJMVJTQqR4XmpN8EahKmvrEs5gghJbsLq7M8EpgGBM2OmerfxFNNYzy?=
 =?us-ascii?Q?c861OKHoAY8g5JqF3LH9mL5UvZBQ7IzoC1aq88Hq2bOE/r3BYEgIUYvAdxHZ?=
 =?us-ascii?Q?dJylPAfKx8TYT7r+0d3Qk+FJr3op//idYk3AKdruh1m5uZU7MzhkSk9GyRM8?=
 =?us-ascii?Q?AjtIUmt9/ENT2xSKiaInDu4x18M017PmO507anV0DiVXqhtGcMIQ7U7eVB/n?=
 =?us-ascii?Q?r7f19AZ/clPtv9OCKr//V42Zfp0Zp3Z2Ja/NUjAFLBxpU3bqMlL5XLyREkKN?=
 =?us-ascii?Q?BbylK52brgdwFVylVmg9Zx4c/Dn4+hTKQ3hh7mM+HqS3pGeRFivxO3n3RIfk?=
 =?us-ascii?Q?tIDteUrLp/aERR/P/qpTnKYphORYFNv5A638uwfIPf3N8Zh4POAUVxS2p6sI?=
 =?us-ascii?Q?gakQQQ5Tulji9ExQ1RmNe9EjnlZODPB6a06IVJSDuKc61QkQ4toNtQWUlQLI?=
 =?us-ascii?Q?5eycv2u8SmwNDP4RzVbgOWNOHUMkObKiJOW2T5a0FdpQ5hHKOJDTXrpjILKG?=
 =?us-ascii?Q?I0cQpv1eKfQLUJOR08mpZysDvNboM2EyI0txDp5AWgQFL35tnvPMn1LjBPPh?=
 =?us-ascii?Q?ubDuv+ha1XzyonDlFCWS9B7K8luqVumYnCY4p6ynYgi07D4CkvB+go20tSky?=
 =?us-ascii?Q?1A2EzAqHy5WtJYgXiJeYYMjcEMvXlgDLJNE3CPOAarEM/Hm0FWujJHhIqxF1?=
 =?us-ascii?Q?uUzk8SRJNGKPuq3co0mMo+W/z3CT9eI447pry0qwRGE7b4qqJN9QFJHtOTK6?=
 =?us-ascii?Q?eChmfxD5X+5pzASxDpwA1wimhbFFshTtbDNMY8VwrZINwsBUC/OlzzgYnpOB?=
 =?us-ascii?Q?AFSYxlTt3dkAVXzTxPJnAA3kWy5VgdalHYPBF/Mqiv7PhSPuDXG0IpXB3Yxb?=
 =?us-ascii?Q?WzxrpifKt5L1TZECVnnpZ3vqenUhr7KO1cJl/eFKF95un+fQi7kBS6aFYBwl?=
 =?us-ascii?Q?gP3cHYpFC0tMYGs6J1Ydddi7golBC2Ygi/IOltM4QP5HPwHXXsD5qWH3WeId?=
 =?us-ascii?Q?b6b1EXWJWWg11rLMTN5PUH6IuFsSARzKiEHwgswUVwDGOnAWAV8SiL3gG4WX?=
 =?us-ascii?Q?WGHIK49HFw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf13011d-2a77-4113-eba4-08de5c79b044
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 01:24:45.4396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpdexalbYafipKE4/0ADPnWuNMwaBrFs2y6+I6NjEb96GJcshkYdSiImdZDRbViJYwMvYJVHbX4XHqaaR7wfvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6861
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

On Sat, Jan 24, 2026 at 06:54:52AM +0100, Heiko Schocher wrote:
>From: Adrian Freihofer <adrian.freihofer@siemens.com>
>
>With ENV_WRITEABLE_LIST only specific environment variables lisetd in
>CFG_ENV_FLAGS_LIST_STATIC are read from the u-boot environment storage.
>All other environment variables are set to default values and are not
>written back to the storage.
>
>The u-boot environment usually stays for the lifetime of the product.
>There is no A/B copy mechanism as for the firmware itself. That means
>that incompatible changes to environment variables in future u-boot
>versions may lead to serious issues if the old environment is used with
>a new u-boot version or vice versa.
>
>Having this protection in place ensures that only a limited set of
>environment variables are persisted across u-boot versions. All the
>macros not listed in CFG_ENV_FLAGS_LIST_STATIC are now part of the
>u-boot binary which is redundant and immutable. This guarantees that
>the u-boot version and the default values of these environment variables
>are always in sync and cannot be changed at runtime.
>
>ustate and rastate are not relevant for u-boot itself. ustate is used
>by swupdate which persists the transaction state in the environment.
>rastate is a similar variable used by another user space application.
>
>Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
>Signed-off-by: Heiko Schocher <hs@nabladev.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
