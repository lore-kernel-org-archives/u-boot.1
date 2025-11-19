Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9C0CF34D5
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 075C683FA5;
	Wed, 19 Nov 2025 16:23:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="G9OLW6lZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5424283FCE; Wed, 19 Nov 2025 16:23:17 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B70A83F7D
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ama835mrOeg2IY4Vu5eRWC4VNvjhMlx2EAQrHIN5CEAnaukzH+PukOeDDzm64BSA/+NjrC7r5VIAFRUSB1mEWQUT4qgW/w1urYidtmZKcsBAztYMwa7OrlKBnEnagnMYX22QJPOrFpbvymetu72+1YaQrCkUB4AAarWTyzkwmdz7uVDYTXaEYacblO0VHHrFGagikEfg10fFXHfQ7TJuthl7EnOpxHvAuw+W0uloSf7WtE4zZQR85xzhTGfWoEUkHxCd6BVYtnHh7kc3pZngaAAU1ohmHKZd/GtimNmHv20HFaVVoAUH7HipB926XwPEMD6h0esmo1SOsG05oXfJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGQ4Jb+bVfRunXCSlNtuDFniI3RkLqbrxB0H4uCKJU8=;
 b=ABZ7nXDH1j34Bpi+RnHTp0bMPC737DsAOVpc4ntlI+Ifukk3iXI3zpS26+Elm0X6M84smq4FgWhLS1FDCdts4BKfeBFAP1yGv7vkYUfNgvXxcl+wHJnRrG1sJMK/d0iqtsyj5wMqIHFwXJ3316NfN+hawvSKBR4t6sOTkccKqUtKds4Z+g1A8xOckeMdBgbIl3a+FQbhByxaEwtGjq6C5c1kuAr/XRywttusqhDTdVaV/NX33XNrxUdThbk14AkfBd/CLiMepwX24n8zjDXtdldxGEfn1Q2gtCz6SEuj9WB2n1a4mDfJKSFZ+MYGdcI6aQWpX9LZiahwlcTYPGR6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGQ4Jb+bVfRunXCSlNtuDFniI3RkLqbrxB0H4uCKJU8=;
 b=G9OLW6lZVEzEb21Pr6KG2C3Q7W388DvWAnmppI33N1d9NwQhkm5VZDXt0ElaqaRFeM42L4kOi0Qk7lIbU8k+3BfWnBEACibNLCGJ/ys/rhwcP4ZKEF4KpKN7+qLi9l5BNvNL6JzJPlorne2F3VEsDNjuLjLoMwQo4smz3x+avbtSDjgGM7CU7nBQThXg4qVSRAJgj4qnmMnTvz5NWjIN52zQSrwIAY8L2E+b2PWO2gPX8UtgS16ZWr78PEcXVx++T3PIpmtiwysmBQL2yLyGmJx6pGLmDnzFgfL5JwNEGYLOEFdzC7PgU4oyzBizuEB63fAEbi/L4GqUNuKPzhbdJA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8619.eurprd04.prod.outlook.com (2603:10a6:20b:43a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:23:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9320.013; Wed, 19 Nov 2025
 15:23:14 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH] mx6sllevk: Stop disabling device tree relocation
Thread-Topic: [PATCH] mx6sllevk: Stop disabling device tree relocation
Thread-Index: AQHcWLXAbGKALadKa065znEt9ta+pLT6H1rg
Date: Wed, 19 Nov 2025 15:23:14 +0000
Message-ID: <PAXPR04MB845953A82B656A841614119088D7A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251118180412.591209-1-trini@konsulko.com>
In-Reply-To: <20251118180412.591209-1-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM9PR04MB8619:EE_
x-ms-office365-filtering-correlation-id: fe2b99ac-6766-478b-6751-08de277f8ecf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?VGL4GjYjGw3diCmmJkxklR6hi8FLamIBw/unadStqI1rgU0H7YoHpx2GKMt+?=
 =?us-ascii?Q?bIKU5pKpCqi1JcDCE5UIXgIcLzGLQcQxJZjJIFDvvskRLvW8EKxwv7jewS2/?=
 =?us-ascii?Q?rNh15V/zkVWNZ58X4d4xatUjh5BZMshPIKNn7rRrUq+QEQNsFBx2Dlp6uEHj?=
 =?us-ascii?Q?ZjNt04QWxriOq5Omr+VijC8EbSez7lQ6J5Xh5LLTZjUiEcpMG8gDSeI9c29f?=
 =?us-ascii?Q?1YH3vJyns65Nbsg7O6dhNj6+ExwGF0Rn9FfNzaczjMoxO47SsUxidxjSeBCD?=
 =?us-ascii?Q?BUi7Vtchec2iLBQ3eQuoUMVrfVBn9HspbnUjPbC7pjEFvO3Jl7lzI9jxcm4f?=
 =?us-ascii?Q?nqFedAd1pSEr8U1TU5P4IGtkQdFWNoXqOUP8ibcNGqemCgC6axFJQVGhr2/E?=
 =?us-ascii?Q?Ys9G87koR+81gIx+5wWNdLkqGO0TeDQ2Cq+IMRiyYQGoba5ng1UdAD+X0MJ8?=
 =?us-ascii?Q?5vl8T74cm/6Wg8LDwjKF1pKVnpLc2Gq3CSmMB083rSLxJbcRjhGtdB+Z8kan?=
 =?us-ascii?Q?qb67fIxQMDv8BYNJfOFcK5gZq5Am1SsR7nYeuVzfKBQcQmjITM102VRl+THT?=
 =?us-ascii?Q?IGGN9B1n5fLOuNOQNdLtdCmTOtRMMyiqcgyX/+5tg4bTPMMEDutchIvyLDT6?=
 =?us-ascii?Q?YNwbbzsTI7wqEMYGjdusGlqliJVzJwPhqU6KFsjJcxe0k37nFDKZCPmn55iV?=
 =?us-ascii?Q?p+D+C2DI1hkdmsIm144HSUoXEwe4CFdSZ2qITmuW6bRSTDp1od8lnrah/G5q?=
 =?us-ascii?Q?i24/C2Li8I5fgl1xw3Gbzn1XjZN//HrdGijJij2bhqubMXUSm0VpUR1nEEv5?=
 =?us-ascii?Q?yLVNbSKX9xVNfCqucB+zc2LAsRup5U6iJ3JamG1boDBesIPHFKyhIMMn2m/8?=
 =?us-ascii?Q?dk1l4pS048gXaCalLtNVzFCyQH1T8lK74gEruHjwJ6dbExLznFEd2WF0xOPo?=
 =?us-ascii?Q?eLSerwlBrtXJgZx30bnxe3+Pw0uS7r+hcXmgpze27+H//41UJGukz1k1SYIG?=
 =?us-ascii?Q?8M5OL58dLW0Is/vWATanWSMuD4PsaI/Yon4YYldoX+/EEhPcW9BTCj0xZuLI?=
 =?us-ascii?Q?OkuwlZ+CoiBgICi1nNENEyldiRyOb0hgHZ1hRMLqoe3Xn5HhIzsDDUN7HxNg?=
 =?us-ascii?Q?3k+myuqEkyBgPfpBXbYDklaGIDcllFG7v7h8NR/qbNAWrHnY6aPTdSNrHr6Q?=
 =?us-ascii?Q?DTO8Ki89sLbauWkpezOlsZZZrknqFFeyl65cH20R3pdlvPdAb3HNw7rxlRC/?=
 =?us-ascii?Q?PJwKcN27iUdhYcTMTAfXVDDWE3ydAJu7IjKP0j6oUf8K/ofsOL9FYcAyk9ku?=
 =?us-ascii?Q?W+pijSQFnnZzYMsgyK49R+J8CpUKwQNXHWbwNt9fOCPt4RAGhJNcpjQl+ZyU?=
 =?us-ascii?Q?5OcPgkF06TYYsTHvk2f0ZD5DCQi0BQFr8kWuIGYu/NxYqk7KlDnWaleZnLKp?=
 =?us-ascii?Q?xUorakaVjcafHYfNn8Vra1svRvpFr7eARgrtr7UHQPDHVj9dSC6tn1LbzEQy?=
 =?us-ascii?Q?6EztaNgCY668wStq6nG1uEhYhFO3yFKjVpl/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vqazOnuQqxbrsbvCOcouhRnINwCTw9NSLtSJdTw8kBsKUjRD7GL1+VZ9YSP3?=
 =?us-ascii?Q?lzwBEqdUtexYNVClqh8q2cw7HHNNNM9ZXD4OUmvYQ0FJojRnZGovlgoUF5hA?=
 =?us-ascii?Q?kJQglw4LW6rtk1uy7vrr8PX84x7krnu+uN5Zj8Y5xm6pbdYN1iFgX776enTU?=
 =?us-ascii?Q?kdJcKxw+hxlsEBykSUIjgEEJCqG1MM9Leegzrrk0S8E64f2Htx3MOJIAjSzI?=
 =?us-ascii?Q?8ALOOz6VzMIV3vRgj4uua630qw1VisQhN9zGq8K28rHnhOvlqbnZ7OeZZJz3?=
 =?us-ascii?Q?ybdmFe+WuariwIafNtOVDSWTrVSmBFx0nXmWV5IAmCGHUUp5PwdAAFG2O/Fv?=
 =?us-ascii?Q?ZEBaBOzAxF+58mgkUwe7rdU0pEqEuLAIeiqTyOtvGnOqFXOgSOVHd34s6F9w?=
 =?us-ascii?Q?ILPQToN0Oor9H34d9FR8czvIhHZJpIcy9+Gc9RjfH/vMx/wppdR6LJpT84R2?=
 =?us-ascii?Q?FypsKSqQH022zEbddxw0FLPYuzmp4JbqKKSzfyhEHGcJtyVLr6pm45QZ9TWl?=
 =?us-ascii?Q?8sOLjAM92uROoDbvxyN5oqfAwauENBcMr4o2VoKqexhOjQz9t6WiEYo8FiK/?=
 =?us-ascii?Q?7349aIcSqgV9+m4ELxFAmaTi3QYl4DE8PB68SC3pFxr7WmdGXbyBNgSU/AnZ?=
 =?us-ascii?Q?UDyEtJ/RBkV++j1+ZnRoJOAm9wC1Spx09viyS5ztVoZMVrotZ2QriVZphINA?=
 =?us-ascii?Q?zXIVbGAGVjQ8+BLfj44ZMQdNXv39T5B+Fk0/KKdnuQw/cWvqK7F5JP63d7HG?=
 =?us-ascii?Q?zuxI3SXM+DhQQf/FipQE3GCXFC4ScorhBaQNuzNTqnuMujoCHYS61o5xn+p7?=
 =?us-ascii?Q?kiBD+mEwgK57f74FI8t3qS6U9pNYWjNsP50xyCPfyuM/WqlqVY2DJYizrbzs?=
 =?us-ascii?Q?6nvmrX2vhiSWHca4CE1sAFPYOxKxGRAsdDyfnsYVkTyYPQfwxSi6g60tApy5?=
 =?us-ascii?Q?VscPOTEFwaXzjvKD79mzgNBWjesj0y4oW8cHSb2rEWmyOQL2oz1e/ObQakJS?=
 =?us-ascii?Q?2Lanw+kd3KlbVcy7xJQhyCT0aQUZhAy7TAESuaKE//AoeFapanjTJ47yS2TQ?=
 =?us-ascii?Q?gAD11uaJQ3ynmamv9nDUwWFEXxwkeltGeUyNTGbv4aW9B02+BmRP6OtpyHvw?=
 =?us-ascii?Q?uzRTpaBP2i1t69vWFndSrmBGU8vTO+4Dnt6Z4d/kv7B3OVfIVyJKB9DFIHGQ?=
 =?us-ascii?Q?shcg7ugQyPpyOWwXxm+z25r/nJIcgYMIkTHIbmR+0A7pJHj3ecS1wRwUeurT?=
 =?us-ascii?Q?KonTnS0B6H7rOjjcw/S2gdBpQiy4wrGAo6paRGDIwnEbxznNT0cvO2+YuMsM?=
 =?us-ascii?Q?TUy7G/fmCJAbHyZX/8bpLJ3f9Kk2hBISzIgqT9fHolKfcD++JhSqHl2tMdk9?=
 =?us-ascii?Q?xEb2K81ra26xwg+W9j5W5HZdmXGuunw2RVOc7F0jbSSztrMWiPppqhtl7UdC?=
 =?us-ascii?Q?KAVsYmxpvG9a0vxJstPu8DWgu4Dh/mkgmIOPh1a8vQ/u+RvfEWgoYyKQ6UEi?=
 =?us-ascii?Q?FbODRpewONG8e9xSFT0ZrFP2JDGkSnHx1f8OalSTWRkF7ft4fGaTIkKJBIeE?=
 =?us-ascii?Q?xcy0T+WINfEtlRnIo/g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2b99ac-6766-478b-6751-08de277f8ecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 15:23:14.2842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dEQemuZyIj5YhRVmX7UU8VRK4X+KW6/dsPT0VUDxsQR3wlJZxQIV8BFTzqRiifB//QGP/VjA3WN+xJ+DpKNj8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8619
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

> Subject: [PATCH] mx6sllevk: Stop disabling device tree relocation
>=20
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from
> correcting problems such as having an unaligned device tree and leads
> to various failure modes in the OS.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
