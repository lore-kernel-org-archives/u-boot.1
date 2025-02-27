Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AC3C197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 12:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C1FC81111;
	Thu, 27 Feb 2025 13:11:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="RoRrD4xX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38BB581026; Thu, 27 Feb 2025 13:11:16 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9399801FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 13:11:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1o5gxqR/MdN4pycxTWl8OlEA+LW/JbOMtgU2mL3HIO53tRSBbO6NS4hQj4ZELCRa56TK/1z+Ibph1Lg/RaxU6SpWTH6H195itmJITTd5EKBn+NTdAWp7ukyp/b60xJKmFjfZHj8YNVm0U/6JwgshjUES2GsoMcnEbRgjyeGxWzp7ukXh8GwKy1RqfG+rNFlsXEOJeJJltiu/56uhVS/8M9yITj6Q99DQCrNylPaMQ0KkamlHGFRC8cVaUsjduUo6jqWKST4yPU1hynw64ccb9QenQ/Pu7RuqUL0/FZLLcrFBxKIbYEG8hYKWTGbAYykVAfAfS9FAvCmv4ntzke8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7M1yfXgDe8Ert9v6Xrfiu9MqBqiEYyhSzBFUm7bhvTI=;
 b=nllTocV2DCJUno4UD5zjr7WpkrY1GdZVs2BzQ0CouQtvqhLuoSMELyvK8Z6MBouuTMFOUDXsBY8V/6rvqJp+APbC2FCvLusVt+ZN6eSF/wvLBCTk7k8VJXReAeyIxPtBFRFDr72bxGkBNXgvzHYLvlAZB2deX9ZryFm6t6lbHsN94K6z7SiYOGXXWHZyVJlmPThkprrS4APvuMEr6ZKAzxZKfmzVvtZ8CSXxBmZR0ezVTp79MpTi7TuxgHPvGdyjDtqLtBcDLvslUVf7kwgjR4JI3at/juthYSDUS5Q1ftlgz7rVi99yp3UvgsY1BlUJYuOOYksKygih0EQkFDu4RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7M1yfXgDe8Ert9v6Xrfiu9MqBqiEYyhSzBFUm7bhvTI=;
 b=RoRrD4xXImuZrfxqdySaPdStGANziRhTF8dS6T7iEKNtt5+YZR11T+5PS6gb56Kit1fJ+xATzJ6cfwQ3gmSHjJJsvwoLVahpAKbB1GfgNNvB3TGJhSeFFeXObJMKrMyLhJ6wlolUQah2INsd+Ee3OdeXCnD17qwv+Z9o9EiV+ichO6hlAUXAqfSVLFhndPvGPtdlhw7o1sekMKYnsy8shAA7Hwosz9ketPl7e8KOU2M1zgNd3qHDR2HMG3TGjl55EPF7wGMcRB8KkfdDHYIUvpLnL40HXTkj1ROaWrsodS1OYdfI3E2hwgSfsmsJIdvuEtBT39j63xkpRa/LAGGOjg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7596.eurprd04.prod.outlook.com (2603:10a6:10:201::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 12:11:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Thu, 27 Feb 2025
 12:11:12 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Fabio Estevam <festevam@denx.de>
Subject: RE: [PATCH 1/2] imx93_evk: Pass kernel_addr_r
Thread-Topic: [PATCH 1/2] imx93_evk: Pass kernel_addr_r
Thread-Index: AQHbiQJ7czDKgZ9gfEmUgTILoAZANrNbD0MQ
Date: Thu, 27 Feb 2025 12:11:12 +0000
Message-ID: <PAXPR04MB8459969E5B8C4B6E77C21FDD88CD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250227102916.164418-1-festevam@gmail.com>
In-Reply-To: <20250227102916.164418-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DBBPR04MB7596:EE_
x-ms-office365-filtering-correlation-id: 4b44262a-a720-4559-3f2e-08dd5727d3cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ebdMPBmc563rQeoB6PGZrANy2CqYFxpJ9V2QrjkR/3ZXfdB3pkr+p0+rXh9Z?=
 =?us-ascii?Q?78Gy0mLoY8YlwTQF54AA5E+eBwsjA58zkgUxYhZr5f7uGQl4yWZYSGxRPuH2?=
 =?us-ascii?Q?t1dQwSMI2Zr4VOdwzt3r+ZJVJynlEFMtKnrP25N0TBkEH+Oo8Zin7GG20PYM?=
 =?us-ascii?Q?rRvdqGITRV2ijEJjl2cv6BRM63GU5jrO4APBq46MlkShqd3o0rM++iFci0G7?=
 =?us-ascii?Q?pmbdz5d5TpaJFt2YKVOiWhNx7hPQ/Uu2GZ7Y7/Dz3bu3i9YKw3NeGHx0nbJu?=
 =?us-ascii?Q?i8Jsb+WjaeK7/rp9elkdrHJ4fiVLhhIEghfl2SzdeABOlwMn2RSfP2K/z+oN?=
 =?us-ascii?Q?jie+fxuI44E+FtxIwhPFaWLKWoNaPXhQxae+pWBNS/XfBhucogtW5IpejxrQ?=
 =?us-ascii?Q?mcbeP1WORgimIfDecNY35JMfBXk+q1UtG8EuHC/yHDgu/BbQA4RWmdkVhGnb?=
 =?us-ascii?Q?CFl+NNQYIgRje+tlu/OdH/3GqVfmWtt4BqYJ415hyjLxfVoR9RZDftT0cI6Q?=
 =?us-ascii?Q?R3vWkKUpb390lZGRqplhLZbwkfkoghVQGNlLHu19qbK+90uEfMqsIvIGcEfc?=
 =?us-ascii?Q?pmxDcRO3ZhGN8PEcSMrHw5kXr6iEF8cEER6xOmMRwyNKEx0LgWRqJLzuCu3z?=
 =?us-ascii?Q?TA4iz5natdIm32fziJkKvUw3dDrLBr/owQNE6hQNdL34jVFR1fwbk2qHrvCS?=
 =?us-ascii?Q?YlwDKJzzmDMvmqh7Og45ZImnvsxrmVZ1hFBED4kYm3WAjYRfSsPkOP1sgwbz?=
 =?us-ascii?Q?27ndj2dUaANRj9PZDTtQZZhbPC/Kb8ToYigp/HPDWS4UcEeko6g4NYt27anU?=
 =?us-ascii?Q?Lu8vdstxA50lCwDIUtLx79Jn45VefHZE9rzaDIIXHfPzcR0mCHYt4wUMoNM/?=
 =?us-ascii?Q?MPRUwgO635hp41lC5HyusS6uLAxwG7zCjI5w6PtFolSad/9Fswip61+2gWWq?=
 =?us-ascii?Q?uXlM8g4kLR3UIUXMPDWqm+AbBDHvwHZqjW2j3cR7VUprrxo5pN6EegsUetZ3?=
 =?us-ascii?Q?MtOqUlhP+udDxz80A6eDAbuZYL2SA38Dg55NanApTn/Ru6yPaRbwImzH2sFU?=
 =?us-ascii?Q?X5wa42xC9m4/E1XlKQuZVtJV09ks0nrj1lIOUHz0Af3LDsPm8mQ3FMOtQqoy?=
 =?us-ascii?Q?BYw8v6O46o+VZmxXn+jOEkTsuSQAquQc76jLHBrPR2jx2zKXz+ivA48Yb66H?=
 =?us-ascii?Q?B22uk8avhI4S04CC/+cPMXEbNovyU1GG+CPGdePn51JQZxjdZnk68Ivhwb6U?=
 =?us-ascii?Q?KjiKKR4hDjh4fUehPd2W7UKG/1et5GrMldr6aeY4vBy3Tww/JiPSj0IyfFA0?=
 =?us-ascii?Q?vzFXj8XLC1MOqOAk8Y7Vefvs0T8z9woaVFdRPi7xpG79P6GKVn4I5VAhO8/K?=
 =?us-ascii?Q?nQbupZTRUH9Y+i5tpz9fTGSg+jLVuXO5KOSDh6t6NdAAHic5YRmXO57p6luA?=
 =?us-ascii?Q?5A+ciISnQp3TwdgZ5d6EdtCGgy14XTLC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9ojjEWej+EIp2R5SFT5OsEgmqFlqN+8ePTLE7FkQ+1p9fp2T8Vz1JOmCNaMa?=
 =?us-ascii?Q?mFjzkkH3e4qsYxcLxVJ+62+pNh3q/GzfwNabjpIp3gavwfT4pPLhwBuEpAn7?=
 =?us-ascii?Q?SnqoeeKDOsa8HpZ5Iztl/jcdOOjPOTGghRO+lLQPLBRnPg6LZZqGwF6qsfRC?=
 =?us-ascii?Q?mamSJ9vEvi6h2u8fPryVhECVpcL7J+eqCXjMhX7x7VRdzp4/OUWIYBesxDmt?=
 =?us-ascii?Q?xLmzP+Ox127hVD9hME8HCDBXQfI5eDosvmJx5Z2J/vG9JzHQ6Bh5XQcgQ+F1?=
 =?us-ascii?Q?sQpSZoocWB6GICidQOxCCBcBeHqCX1GYHbxOD2HAqoa3cy4/PjEwID6dLF+K?=
 =?us-ascii?Q?zY5HuN3wmvNgkF27CS/ro+ACVyQdetNg8lGS73OvwGgnd/8o51a447tOuaU7?=
 =?us-ascii?Q?/VYyoxNONUFHvE8d2wdQoOR59TwkACGb/0J7SQ9GfFiKoDYwmEmcNxDyim2O?=
 =?us-ascii?Q?L0IS/rvnNSwJDRXJrMFffBMXZ2ZPTiePaeu+QvSJgfWqcl3tJ8i7LJx/ExXV?=
 =?us-ascii?Q?ruoSIUCQJanUmsSUfWEAd7yiOJulYVkIajUStsGsaXFXecpFuqXfv3azrrZZ?=
 =?us-ascii?Q?ZyIEIdYvba5H+olA4eUp+ll7IRrUp28SeqR+lr++wZp93KTZErcjYxYwpVsF?=
 =?us-ascii?Q?v09lQwywEJGJ0/1pIpaZmj8vk/+M26Ud1exbJEvAE2O1rXpTU0N8pVLpq6hM?=
 =?us-ascii?Q?8eelLUHLU7ykZeD3XSiGVQFsh5Ffg76hkEmx1kywFhcTA8XKhDzeBP+e+mfo?=
 =?us-ascii?Q?7Gl/2jxzie4BV5JwBNFsXv9bbVnyuUqEt0HAzHHRi4JMHt9qhoPKxRvSIT1/?=
 =?us-ascii?Q?r8oni6QSmNazu0gaZSPIEcf6PJAQMJi93eNn4xgZ+ugfwEKOXmVgbhfwl3RE?=
 =?us-ascii?Q?mdaBuB4VKGMh2oLcIzKogNd1e7GWy+5M1UvZl+lcbc3R9CrrrH+T/6xud8lr?=
 =?us-ascii?Q?FRyDoXAnnx0oy0MU4uhZj8Vsog6oFDaIzAe7O/1RM3xowvYD5RhMCMRLlbLQ?=
 =?us-ascii?Q?+tNbyMX3VqyACuJzhGmAF+Sb9AM832XzlIi6DDPoVhenbT4svm56Vx3iDkc/?=
 =?us-ascii?Q?NYbXoP8JRHcfW8lun5gpbHtF9XSnSp/yjyGgzj0598qbTxF4kaLS3Y4CsuFF?=
 =?us-ascii?Q?TQ+tLsxxYsaovM3Sr0WaLNmxoFuww3p1K6fho9MAnGeQAi58OkDDQQ9Hm559?=
 =?us-ascii?Q?aCjEdeexpsoH2qGxbSxX8caDBUEF5oKRHc5Q+8HG5JM8qttx7B+bfC/9aSR+?=
 =?us-ascii?Q?+DXtERGeS6sJHm67ZfSLjzLr9Z38j1iOUnAw79N4z7fDWlNtkFW/TVKcgbTF?=
 =?us-ascii?Q?GsjZGqwkswu80mCrE8PPXRirS/3ZrYBsCaKcsEBVtJX2IRjiWwQMlg93dn9Z?=
 =?us-ascii?Q?xmv0oOOn3oc/mXq1KdFlB9vHMO3fgvSwkqi2FjWY0DS6Ql8XIj6cauAmuh/4?=
 =?us-ascii?Q?+C5x2jkVMPYK3t0dxVpfj5gnXMHVUrzXAisBPKWAOUbtxmVTSskoPhMD7cUi?=
 =?us-ascii?Q?QsYivSY9NGeIuxfFgihgjtZz6ioJ+HDyg1AAEdfWpEaD7iuSW8S0JdyOufHI?=
 =?us-ascii?Q?MCp2bCG2ursLmgGr/1M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b44262a-a720-4559-3f2e-08dd5727d3cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 12:11:12.4542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8pj0DUvfE74WUcwfCFf6OqiSNNgGrBW3zXX8PfQcFB5cmBEWHumNZwB85gU9/j5T07Tht6TFxvlcrqnO0dL5lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7596
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

> Subject: [PATCH 1/2] imx93_evk: Pass kernel_addr_r
>=20
> From: Fabio Estevam <festevam@denx.de>
>=20
> Currently, booting via bootsd fails because the kernel cannot be
> retrieved.
> The reason for this is the lack of 'kernel_addr_r'.
>=20
> Pass 'kernel_addr_r' to fix booting via bootstd.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
