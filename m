Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABC6C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 12:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8972888770;
	Tue, 21 May 2024 14:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="cgjDUCiC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BBB588776; Tue, 21 May 2024 14:51:59 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3422D88771
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 14:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIpiccVOMDp9KWLpfjtdaek1e80OqYHk8DAp2rF0MF8XbMmlhcCwucnvc22fwNFEH9PoAJ2h9pxkdeiyDOpXy1iI4wvT1vABLa3+zRHUISkj4Lenl5kHCvlxPPLmHxFXewAszetglqus7pOGKFGB+feDvQ3SaLZEaiwgjJXMoTBaIQsExb+POmK80BEkk4FoD2dcS3Z9tIqeo6RmGM1ZGHyE5w0Xhb+DdA3JcasJtlIK2eltDQLiaQpZkXDfrDJcJjqZfj3hyCAz60JJ0+iWHRyzZRfDhOSqzs0vRtETd+e6VMxcEnO4boT2iklbxFoLYemBMGOPx4z/9QXKPjJdJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFR1oyGqWrrMgsuAxvYjHuWSeXmWS5AvEIoQxAWRn0M=;
 b=MnBUqPK3VCgIZ+K6YfJqa3uGZq/nSUrIE63bJ9j+vD5YbQxv/CK4lUxsIBeqgJPHpYnMR6cMuA0jD59cFDVjMhJbPuBeUPoIMlsC5t0III0WtdawqjaU7BrEZycrUTjxgXu3mGv0rbGTmLXCrkq9XJRogR/27A9BRCd0uCLqNioWWkj7H9cTaZRVEfRKqU4wHHWjyx6g+64XliF0EwMJAwvDyYPlEv4uP5WhocKxhtLxaJheE04c9pDnfE1c1D9CuKYuGPcu+3/+dGsENeVg4IVr5RNYr/hbqjoVXZrd9Tp8ryrh6aUezln2aQNbPHD6wRmMe/G7oDB6o8hWfY2M7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFR1oyGqWrrMgsuAxvYjHuWSeXmWS5AvEIoQxAWRn0M=;
 b=cgjDUCiCcGerBC1T2S5ZU8iqPjAQawYPDvLdv+jamMFDzJ/eV9GBBDxJv1liIGX0p1UVx5rkIm2sWtLS9t/HMs52tfNOYUcQ1QkAI8loqRnRUEJDg7E4eVO1eR8Pk4QUeMbThVBd69Id57kpysu5qsDy8Ep+2+vVyourhu9ayYw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8246.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 12:51:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%6]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 12:51:52 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: dl-uboot-imx <uboot-imx@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@denx.de>
Subject: RE: [PATCH] ARM: imx: mx5: Enable BMODE command on MX53 Menlo board
Thread-Topic: [PATCH] ARM: imx: mx5: Enable BMODE command on MX53 Menlo board
Thread-Index: AQHaq2M2YH+fkpQIg0C9BvOxucLwSLGhpHjQ
Date: Tue, 21 May 2024 12:51:52 +0000
Message-ID: <DU0PR04MB9417FCBF2DB70100E11E988588EA2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240521094216.8919-1-marex@denx.de>
In-Reply-To: <20240521094216.8919-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8246:EE_
x-ms-office365-filtering-correlation-id: dc7ab261-5bd8-4a0f-c2af-08dc7994c969
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?29MnidhagPRK6mRfaV89yLBpBZstGrEsvXWUzikb7UZwLHxXk2DNgoZT6wqP?=
 =?us-ascii?Q?GCjV+xi2jZHKg+qm2nOPzuyDhPZ83g84UWgUGOuOAtrMVM0IjDvUYmloB5Pc?=
 =?us-ascii?Q?cP+I9lQx/S4Om9I6BLXcWsq5ogClmurTLVg6SBUdwDpgVbbd8s4ixELm2iL7?=
 =?us-ascii?Q?BtkP9e0mZHYyLSM5pi6bhv5mqTuLtdV6OcdbL8OpQ9j3hQQVRrDdLHxb+Q/4?=
 =?us-ascii?Q?Hf8vV3o5OmL7TAkDmFxbC74eNocuviybgrxfh4ady8K4rbnYfaIvhvzbCGTE?=
 =?us-ascii?Q?r/D7Xx7nWM/IgPb9OL9WWmLlCIgNTzOMbj1rrnADSwqLYoJfQ+C1qoSu0mCk?=
 =?us-ascii?Q?TP6UBwtvhFnqQw7yKlyXWXhewWvzb7jp/3uTaX5dH5OUGgmDX2ZC7YfU7xm8?=
 =?us-ascii?Q?lsCFAdJB/M0nNCdE1I5fRjQ70eCtcRygs/6NIgmKl5vnWaZSROhgYRaJ1hXd?=
 =?us-ascii?Q?S8LTH9xGfclgRHG1Qbo3BGRBi8FBzbaYYe9jAp6jg790l1l6My0DwvGJfZRT?=
 =?us-ascii?Q?LQ6Wi6RYgtbUFzM+20EK8hu4lAbG7xUqNimoKMJOLpS7QD5D68m3f0P9ndO4?=
 =?us-ascii?Q?Y5tHUmV1ysXhNzkXupY1N5wjUyWTlJF+os4PdXOiuld7avsXxV7taPih9lpz?=
 =?us-ascii?Q?9VZp6yAoRMw2FsOpo3cdO/eAzEadA2wpc8kEXoXJF4OjnnuytNL1fK/GVKEn?=
 =?us-ascii?Q?PfXnc8BQw50Z8DqNATdrpOfpLz2G5q+9LsP7cA+OLdqkLDD5tmpKWTwlOM7n?=
 =?us-ascii?Q?v55vUxyzi7QYaMwSIn/uWYMebDKRVWSKhYJ+tKe6AdS2PAzxJwb4cVtkYhlk?=
 =?us-ascii?Q?IXewcDlsdaU7zQNRPAf+EAxmfyAujCh7BVQrD4/2HODpXEuEHEsNCbJfvOtD?=
 =?us-ascii?Q?qqBpXQUdsbPwIW4j+yQS/wJf0E2lgN714k53Q5B0G2plrwN5xdaibwrjVZ+m?=
 =?us-ascii?Q?M5EPXrdPYd1eTrBETcnNVn0RVMUvA+I375cd0x35gMz0NbOxq5seDlWXysZR?=
 =?us-ascii?Q?yS252Y/5Hylcp8mZZ++gVYiPhdwbanqKfb96pn5RPbuEafUEkPw3jQYzstxI?=
 =?us-ascii?Q?FvDkzX/orZ6bGXWx3YNXnWGwYd8Ujp0FvDsp/DDZXEydE2cI8Dym/v5nxNgO?=
 =?us-ascii?Q?zzHukHVh/nwbZ9Yi0TeY8WigoQK/KbsRO1UFR1EMU7+6/fOxrVdCWZlkAftP?=
 =?us-ascii?Q?VQ9CdGqnvQ6JyLQEo0Ehu+ivT+OQR7ai+74xt8u9wU7q8mZFHvIW2u7afAlO?=
 =?us-ascii?Q?JGQTLSiAEl2llnxraRu1iaVxyo4EwHeKsy8SfO+uwE6QdnAZgyZc1bC/pNzl?=
 =?us-ascii?Q?ni8OHz5iZflCHfvIsP5/TM/n2AhgJkKOTSDbYfkDF5Z9+g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7ixRqjvq04SIWeE4gejeEf1PfvD7k6jkcY75iRy+CzB0+C41OqLbKWvsGle9?=
 =?us-ascii?Q?/K+1oLaLArjsOQzSlo4CzUHgAk6vxqb+EJ+yG+LTvGy1T4+MbTsP0fUUOqGy?=
 =?us-ascii?Q?uvePKi7abUdh56qpeejX7xAeYLkZTEMBniQTaRtAKgR5x+xH8iw7nccSOAZn?=
 =?us-ascii?Q?WmD3+PJyBwB6zwCgQEWC9Ek9RbvYdOH078Dlks87VS5JXyxvJj6KXs5V5vZm?=
 =?us-ascii?Q?zP2Vs+B9cRrJOegFq/zri4A/bU0XwJs+JYnJV0t2zYxxzQlRHM8L7UrtyRYz?=
 =?us-ascii?Q?QNOXuUPT4/X/gDcH5ULEopF3ncm/6OFlQm+Z53hKhMmbQ4AYV9o0bsleSDKJ?=
 =?us-ascii?Q?LiClUo3qyL00v/jzhw/W0JzkVltBcY1rdJ1ERCSt+M8TcPslLGMsR2/MrIpA?=
 =?us-ascii?Q?NkpeUhUjh74YBl1JLsziBcvsMs2rhx05HzavbK9YQLHg3RYEsRMzXXVvWgsG?=
 =?us-ascii?Q?SXVcU6Hq8WVpDmGyRul5kOWya92FxNod1kPgW9iYyDkmjxDOCHzcZ7UUFT8N?=
 =?us-ascii?Q?j8y7VMtl43tlNRFEPcgBGemO0mqjv0MVAExKRDQgjy+aa8k15XXtjGmlyieD?=
 =?us-ascii?Q?8YI6hVuzQ3EL0uCfYYMJn/Q7lsTxeyutl3pHvQulJ7vN5e4tJGxybdGdNDBQ?=
 =?us-ascii?Q?LdCLlTQDX8nWnn1rXiuWMcWnq2GBUj7fKr0p/TCrc1kYV5cp+pBgJ1WvXoJd?=
 =?us-ascii?Q?XtR8csUNz95hk86nMbbR3hIcE9lFVw0Qo7nWuVY64UAnQJbN5vva1CWs86X6?=
 =?us-ascii?Q?wx4YdiY6CnR3KfFRBmd1OhzBkb6Jk/sjEIcfUqAtJK5qHiCRsWQ2qLUB+jWD?=
 =?us-ascii?Q?VeamX1edgQREg8CnjYEDn3u4hCMKZVey7p9HJsCE9BmyH5V8S6oQDrX+s3tg?=
 =?us-ascii?Q?nu1rbJbozIKqC8zORmOPKmMpBYCdlBqaxiRQq5gj3n/70rAUqHqrRGnUB5uk?=
 =?us-ascii?Q?erxH650p9ybPDERHTl6JvOJSrazrMeiQTGnco7eYn693zH17ZhO2yuqjLQNh?=
 =?us-ascii?Q?Run0h1gdxvieGVEeTSYr9IEfkY3gOo/B5Qf9267l+E9PgYVMp9/IlfxXTzr0?=
 =?us-ascii?Q?LQEP/NGTiuy28ePdHiwKL0iabQW5J3EdNTEQes4m+mSXf+RkKLBBdBNfzLYA?=
 =?us-ascii?Q?kBBL1oFjJTGv16QzdrfSREn06H8n8z73JdUYeQMs8e09kS4KOhs1OXaz45FE?=
 =?us-ascii?Q?4gyYIcTFAV3zmzLc3RB8HT7h3DKybW/bi/8TOPyrKy5dDQWzfYkV0Rke6/kV?=
 =?us-ascii?Q?zyIXFWBIJxXUq9QTATDUP6mXbE0GzDCUo6isWEoU3s52ISdhFSImctUQBLh1?=
 =?us-ascii?Q?JPa1cOEbTYxwjfZkukt1lszkslJ2rt+m/cDk3YsVYA9NDvuNhllIQi+XhMsY?=
 =?us-ascii?Q?UvyWGn1oNaBlrDzw9AFTcDnBlGEFpek1M8Q8ToCynTo2ZW0TTNDI+qrFOdzG?=
 =?us-ascii?Q?tIOhZEQ8VRzQy9EYNIspdj0STS9Yd+m666dcozIEbj+NSt9QQ3lh7UczQ8oK?=
 =?us-ascii?Q?ap3BBIPkllv53NEk+HGO42ZYFktbR4+FW2vl32PhSheYU/pzGKuWY+VbM8E7?=
 =?us-ascii?Q?+/cSxFHM/rV6LOCOL6U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7ab261-5bd8-4a0f-c2af-08dc7994c969
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 12:51:52.0893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ouVy/rPWdqgwxzMInPDAAZtKbh+G50BXcEwaxkOQ+6J38uoVNqfbmXfHp8rSqztrgDW5uyrnSYj2TuP1IOyCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8246
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

> Subject: [PATCH] ARM: imx: mx5: Enable BMODE command on MX53 Menlo
> board
>=20
> The board can do primary/secondary boot switching, enable the bmode
> command.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: u-boot@lists.denx.de
> ---
>  configs/m53menlo_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/configs/m53menlo_defconfig b/configs/m53menlo_defconfig
> index b06a614dde0..d6b47240c10 100644
> --- a/configs/m53menlo_defconfig
> +++ b/configs/m53menlo_defconfig
> @@ -22,6 +22,7 @@ CONFIG_SPL=3Dy
>  CONFIG_SYS_BOOTCOUNT_SINGLEWORD=3Dy
>  CONFIG_ENV_OFFSET_REDUND=3D0x180000
>  CONFIG_SYS_LOAD_ADDR=3D0x70800000
> +CONFIG_CMD_BMODE=3Dy
>  CONFIG_FIT=3Dy
>  CONFIG_BOOTDELAY=3D-2
>  CONFIG_OF_BOARD_SETUP=3Dy
> --
> 2.43.0

