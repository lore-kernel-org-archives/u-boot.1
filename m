Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EF9C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 11:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2776187E37;
	Thu,  8 Feb 2024 12:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="atasVNiv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AA5487E3F; Thu,  8 Feb 2024 12:59:37 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1504587BBA
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 12:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHbVk0C0FFba7/qJBSMrr8BYeAkoe+k+srSXQxFykXpZ7CkY7tcygx8KfOgCTdzwzhifQyWVrAndX7D0ExpQA5dChAwpAfse/NvpBH7LcQFM4/f/ccSGTGZyZl7zz1T1CtmNMa6JXGk9ZgncDXB4YiDnV3+BpHn4BLZ6MFXKaZ1VdbSstluiOrTJeuO7vwMuT4EYR4F8YPKa4DR8tPGnJbMWlM+3q2sxce91/+MHQtyBqmYuW7as7Qb0VDiUWnhA1Kbq58MoAeqYaLljKXVfJtLECL+CFVRv8AkvvqOpe0e1sa8llFE59aEqWFfUwQaHttMXeivjqvJF+EojvodQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOMM4mC7Di1oHUUp+8OBnsWxmqnktM35sO+pkRYl8pY=;
 b=jqUPDvOP+vuWhrFJytt37LVaefpQDBTtZwgas6BvmOH4R2fVbyiKBep3kWqilXdpYfZgxaI8fmQ1wsBfgd67dom0OCPKg7ffG7i2F9JOL3KZdxwNpCssS+G5IGm+Df7h1EWyB7kTmXH7rpWLeP8L16IBSlu91lhdWLWVQz6iiLpFzXE+zAq3IqarxEZRnx2A4MqzrsqpwzBF68C6SUR5llkAMWVA6ArelXpFbNpvzH9VB336o8HAraEX9U/BPnlSpg6m1/0LiNQ/ii0MhF9mmi9RDekOFwPgX8lWEJ+hAr8gln8B83HOB/gP5CxaKwpWIiDQg3SxjrPbUKWbVhkEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOMM4mC7Di1oHUUp+8OBnsWxmqnktM35sO+pkRYl8pY=;
 b=atasVNivYRCsnZxrrqPz68d1rtwiKPo/l00c93vFtTvK4bdsoQalzmiHO/FptfMNXMviYxxI8duOyobyUFE7Z+t/C9JTza3dVIfFu4dbBq4zkCXV0s+dsGdrozFwOCLiZwkDjDWdsOrE7jBYI/oZlOC31MvoHX2X4ZtYuDUMA2s=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9277.eurprd04.prod.outlook.com (2603:10a6:102:2b9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 11:59:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7249.041; Thu, 8 Feb 2024
 11:59:32 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>
CC: "U-Boot@lists.denx.de" <u-boot@lists.denx.de>, "mike.looijmans@topic.nl"
 <mike.looijmans@topic.nl>, "Radu-nicolae Pirea (OSS)"
 <radu-nicolae.pirea@oss.nxp.com>
Subject: [GIT PULL] please pull fsl-qoriq-2024-2-8
Thread-Topic: [GIT PULL] please pull fsl-qoriq-2024-2-8
Thread-Index: Adpahdne5aScth7wQpC/ynkE/L4kPg==
Date: Thu, 8 Feb 2024 11:59:32 +0000
Message-ID: <DU0PR04MB9417865338E6CCD3646DBF2288442@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB9277:EE_
x-ms-office365-filtering-correlation-id: a405c9af-4f12-4338-c894-08dc289d698d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cqeeSJij7G9PEHAKktZA95NFIk3yJQFopcSzJUUWZQMgBO2kyDk0jYskwWXl7EvR/c2+J9xi90RQ/agC03mRmAu8jrCBj0uNVdnOCc+Gn92QlLY039YvFCF2PmDxlBdmnImU7QCTFWYux0Yyv4PmXfacIWyoqjEk1fV2++tx/kVyYzDOSmZIvuhWGShnrG9bC8h/uIBB1c+PP/t6diHMDvVKi6xQTHuu3H4BGizBBFFNwx8Nw+sHR51eyGANJdJyfSB2GvkLJDMxta5cOmHNo405vWa2fGNOEY87/kRfJuHwOfd57IIQAVHesb7PL/jLT73qN1njiZiajbr9jY8QP8S3BMPtLjo2YoRjEJBzFKHJeBZeAzr+cAkgkOFmYKmiVhglK3wltalwvUgUMi4T7eDfnJ7qa1YKhJcxJdquQ5N3hQTAWo6Tj7TyBUgotOWj2tjyLcjo1Nzr3h1cLmIpaAvauFiqEKoEjomufCUJt9SyGV2hAMC78ToWx6JiVqktzXixy5bsw/+y2oAslODGbYme7E+t3wU9b+9fCG/nzLfIUI84dLo234g8psoUX8hxUsLZCADMduTjt2ktNERWTA4AL+ybtebVZfRkJ8k1xuE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(346002)(39860400002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(64756008)(2906002)(41300700001)(52536014)(8676002)(8936002)(44832011)(86362001)(5660300002)(4326008)(966005)(33656002)(7696005)(9686003)(6506007)(71200400001)(478600001)(54906003)(316002)(6916009)(66446008)(66946007)(76116006)(38070700009)(66556008)(66476007)(26005)(83380400001)(122000001)(4001150100001)(55016003)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Dr5rxBraFoWT2BnDIkoQtijpnxwtXdbAu8VBlOqzUVUudY0jCw+y6q0xkXZ8?=
 =?us-ascii?Q?JWwYjjQDb2SwIvTqlRgf21XOpURFzaAJDc+9abuJE5dL9lVp7t2NpxB7zNQC?=
 =?us-ascii?Q?ywpjJJtl41g4PFa8YHhI3rAFkSGeWo1r8XaeuZ0nQRWcNNvJXFCPgZScR2I+?=
 =?us-ascii?Q?FfLOq86ty4j61PqLOzUUuKLT6y88T7mjAqLOHSuxnazYNdqyGvU+AvP6ZbTU?=
 =?us-ascii?Q?PjDf/qRYpAmmXfWAwJtGuQ6hLR6hJmlkUfkN0OtewzxHX3+DfcPVvlkA2IfE?=
 =?us-ascii?Q?R5EM0KvEajU1QNGNYxJd1+1uBrPKsFpC4cT4q4gzXD8FzB+OOo+wPwSfA6dC?=
 =?us-ascii?Q?mf/Mx/Krvfa1hEFBc11ccsEobCVIz1E7zbW4BAgmZmwhSeu1Lh0C7fcjriWt?=
 =?us-ascii?Q?fDTIMlNJm+exLs+a8zeAZ3Ffi/n0hBHVNS6XOQ67tjO1m1A9ai+sC2ATiQdD?=
 =?us-ascii?Q?GXjfmtb4AY/JItv7+H2YlMAWda2KANP+l4SH5/RrTaQjpoJolXOpD3V2hxeu?=
 =?us-ascii?Q?ynfkIyuRDjExU7qtoPZfeZk+cpKnAzRGjS73r3WZgeCby5PtnUjuBchWBiD/?=
 =?us-ascii?Q?wznoIKKIt0gE4DHYwc5yVkoicSzunk8Mygc5EN0+aww57I4HpfjVqy1wYlLK?=
 =?us-ascii?Q?dZMHhYnoVnnt8SY2UJYhbrsPVEEs4BhuPsfxkmp8GZtFIXStMvbVhL0BxFOB?=
 =?us-ascii?Q?y3UTLKJq1dftQcngnSZAAsOFNkSijuAlGOK6M7QKoBuIibaAXvlYotgF4b4P?=
 =?us-ascii?Q?sVY506IMUsJddJ10w6q+mOn4puTooa9IV37RAc649JyBB7nrkGw0gr9mnxne?=
 =?us-ascii?Q?grU25MWWFNa4GILaEwiAv9EsDuFy1h+e/BdMSmJ5fDqys4exKhAichobR/sM?=
 =?us-ascii?Q?IQx0qskkJ6M1Sh1T/d1b4A1S3d8OS7Ct56ckw+fNXw5XSFJOHkxtKQZhFob/?=
 =?us-ascii?Q?DIibD1Pzk1vLE+ZMWCFrzwv4GhEzEpQ6lwDv1hjGd6DKbDcIu6MrG918r5sv?=
 =?us-ascii?Q?Ea1xvYIJDCLUDYQPq7zLWJ4P4QoTd1flLnP2udgJPkNbnsBEIIBFK8AzuqTf?=
 =?us-ascii?Q?P0iIwBd1AWhsSUt7Vf4JJyLLqY/9rTgmujYhvk88ikCDp1cAIGWoIxOrukMd?=
 =?us-ascii?Q?pZR0ICbUfV89X4ZsnMC8SUNKEcZCOLPL+G2VzVqmuCcS4QN5GCcxr473XEiD?=
 =?us-ascii?Q?xH8Dj4g2+oKgqHp4la3EfsJ1t8wozXYN2pAdiASPDVYlfL68KKb8tMiIm0uM?=
 =?us-ascii?Q?PKiH1Tst6oLovY2kTmnImTYK/h0XvtP7tJ63e5u0KEXBFfOjiZGVMUygkJEW?=
 =?us-ascii?Q?jYEqCvmymdkIZ5U0JmnOTblJktaTYUA6XMX4kn2jGtr0Dp1wreW7k4AWCgyg?=
 =?us-ascii?Q?KOLfPRaf1/iPLjax9E0YWajdPFjLSzF/+/QCw2H1luMX9KiWdEDGHpLYvH2O?=
 =?us-ascii?Q?Ygals1MUoebl+4cjW8NlX84aBsnEgGfxdD4I241QNlzKDJ82QDfAd5F06J+c?=
 =?us-ascii?Q?aH51K1bB8wWcpsTPBiwbY+jW3BuRVGmyvxx6/ZElNp9aOigBCEN8VWIn9Ih4?=
 =?us-ascii?Q?sQ97yquYrYL9N0whg/s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a405c9af-4f12-4338-c894-08dc289d698d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 11:59:32.5562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5KjDlZx2WKfU2gcrhNCYp9D50enzp2ZXZ6zg2q5FB72y0f0RyGBO3q3ksDhH2utbTONoyhxqOJNNAS0q2eUGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9277
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

Hi Tom,

Please pull fsl-qoriq-2024-2-8. Sorry for not being active in the past time=
, will try to
catch up.

-----------------------------------------------
Add TJA1120 driver support
fsl-layerscape/soc.c: do not destroy bootcmd environment
-----------------------------------------------
CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/1=
9562

Thanks,
Peng.

The following changes since commit 0101a2ffe125911ebf89172b495f5ff14f2fd058=
:

  Merge branch '2024-02-06-assorted-fixes' (2024-02-07 09:47:47 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qo=
riq-2024-2-8

for you to fetch changes up to 121696c957d741d17125f5416d1210b11ef8afdd:

  fsl-layerscape/soc.c: do not destroy bootcmd environment (2024-02-08 10:4=
5:32 +0800)

----------------------------------------------------------------
Mike Looijmans (1):
      fsl-layerscape/soc.c: do not destroy bootcmd environment

Radu Pirea (NXP OSS) (4):
      net: phy: nxp-c45-tja11xx: use local definion of features
      net: phy: nxp-c45-tja11xx: read PHY the speed from hardware
      net: phy: nxp-c45-tja11xx: rename nxp_c45_tja11xx structure
      net: phy: nxp-c45-tja11xx: add tja1120 support

 arch/arm/cpu/armv8/fsl-layerscape/soc.c |  5 +++++
 drivers/net/phy/nxp-c45-tja11xx.c       | 43 +++++++++++++++++++++++++++++=
+++++++++++---
 include/phy.h                           |  4 ----
 3 files changed, 45 insertions(+), 7 deletions(-)
