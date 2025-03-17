Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D57C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 04:35:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82915810F4;
	Mon, 17 Mar 2025 05:35:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="BlBiiL4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A94D80F4C; Mon, 17 Mar 2025 03:41:39 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A460C801DE
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 03:41:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziniu.wang_1@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=le3gyL9z16Bdr2yNwTc771b8vHt+Y2wVwFN9cKsIogTHHRPYPTC0Kd2WDHuJ8E2sVVk0nSY0xnOet+ATjrJU5K8Ww1SV1LoPNToWqAE9qit0RKKqe4a7ArJ2xFavnP2ux1TUOQ/rY2v3xXhl4oSjRgD9VMxtVemMDvw4HTVPuFgRMferou2ID1a9YeBuofyEchY6pDgc2tjzND9/x19L0EcsBON9h3tqDD4qVO0tzj2NTTUhNMgbkOMe8ToDT3vM/Cbrkljsipn+f6eZ9cbX5W61wJBcsHccFSO63tiwmEE8R3spEJhe623JL6FalrQ9bJik8qV0/8VXurPDfMsspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzpV7+/FFae8EkWedX4G3RxQLikDTfTjIqTAek0WOtQ=;
 b=xi/dDD0vnXOoKkZd4UO8+DeFZK9AWGS6FtIh4d0tOo/du24TBkz11p8oc6cT4A+RzI6gSWNXFKhLMq3hjejNWT9e6DNuNW6l7rvCqikmcaamXxL6KoBnt/nzcOjdxDNI7qVUV2IL8AKPR1cWrURLupThejr3YKFqdM3iRHU4y42VinSqlLW/cxhFbB/oWgT4OGo2l1czWGG+ZQ+UjlOBTfiCsWRTvY/BUTCp2ZSR8EDcVgous4w+F1G7CpMXeaNizgFklYTqSmaHAWw3ANupGa31ZQ2hzVignOL8hw1kLnT9TaFcdqQXvGgiAki/Ai4bo4TQlMRakRz61F/ZG9U8cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzpV7+/FFae8EkWedX4G3RxQLikDTfTjIqTAek0WOtQ=;
 b=BlBiiL4lM4Xv9GstzRgZlvxjcpqyQnv1ZkACh29WmfmUR12Xhr3ugTlK54FF/s15NfTWDF7d3bgWCywigUbMYtPHBsfOyfkGhefocpwYpdcJYNcAdqJ+N3M1XdTFiTBLa42kQxb77w9Z0EsDzs1MDHTMm0PThSrMWpwkm8ljl/fDcX+xG5d+1/Dp1G/SOowzXi/FVhoXWF/g3erGIwQ5o8yGA+AYhRg48V/kVASFY+mX9NZjH8ZPnWbI6t7wb/9r58DlmAo//b2HVQaL2l62zg0T5lMgjOiUizzxqOfjs4rKxMDu1EDOvUNOeYknG9fEKrwfgVJSh/pbLymhb3iFEg==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by GV1PR04MB10920.eurprd04.prod.outlook.com (2603:10a6:150:208::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 02:41:33 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 02:41:33 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Tom Rini <trini@konsulko.com>
CC: Peng Fan <peng.fan@nxp.com>, "jh80.chung@samsung.com"
 <jh80.chung@samsung.com>, "pbrobinson@gmail.com" <pbrobinson@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, "jonas@kwiboo.se"
 <jonas@kwiboo.se>, "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [EXT] Re: [PATCH] mmc: mmc_boot: support sandisk and micron emmc
 boot/rpmb partition resizing
Thread-Topic: [EXT] Re: [PATCH] mmc: mmc_boot: support sandisk and micron emmc
 boot/rpmb partition resizing
Thread-Index: AQHblLhjd8TNPdcmeUaL+y5LXPgLNrNysSGAgAPtPYA=
Date: Mon, 17 Mar 2025 02:41:32 +0000
Message-ID: <DU2PR04MB856771F9649B280C53F5CA76EDDF2@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20250314081024.1035144-1-ziniu.wang_1@nxp.com>
 <20250314142759.GO2640854@bill-the-cat>
In-Reply-To: <20250314142759.GO2640854@bill-the-cat>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|GV1PR04MB10920:EE_
x-ms-office365-filtering-correlation-id: cbce98f8-3e95-40ec-d2bb-08dd64fd3aaf
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xyMUb58yxMvnDEP4K6K4AFssohjSa7nyn+ddVkF6GKPTZh+nBs2s1cfGYQuR?=
 =?us-ascii?Q?W9kyfmPKX0W74sACm9ob7DLbe7fiRwbLVmLMKjEJ7GhkDGYFBBVyBADYATuQ?=
 =?us-ascii?Q?DF66vQ/kw6yPIKiCQy0aph3vCLIP5qyY98QN9eGOWtT9BLLewUc1bKTOclPo?=
 =?us-ascii?Q?fNtBZrwuZmiK+h/bYqGpPlPmDSX69Z674kEkZir4LCh4EHpAkz6hvQYPMlBv?=
 =?us-ascii?Q?IXDde276FaiztLzcBVmwPPAJ+R+IjNXVCaqPlkbFxCfaBmvCkXegsqBnDBRl?=
 =?us-ascii?Q?deuNvxTsx6UAjTa4Qw4I89K8IohvgyZwrx7X9OaQTvaUYIt+azsdu6q5iE+t?=
 =?us-ascii?Q?xaV+P8Fc2dhulF+ShcLSRKdwJoAenNQvBs1rYJOeEVBJflv3CpuUQGCJsgBN?=
 =?us-ascii?Q?Z6UxIMk9B9se3DB8yDfYOHHKuIGmA9H+UT28N3GFSiesxu8bx3QpnREYKdFT?=
 =?us-ascii?Q?fe2GBGBe9A8nQ7BotdBshVBBB/3b/ybldwAvEy4o5oSJA5Ubu92QyWH/T8UL?=
 =?us-ascii?Q?3ChgkZfo7AWJ9tZN6vpMpUrFj1vCnzQCPnDGpIVETPErt2BwszbndZ3cipB5?=
 =?us-ascii?Q?JmGFIR1hSphd80BcNiyjxNWIUuXRQsPQQT1+cF4C2CB53cUtaH2GUgs66lxh?=
 =?us-ascii?Q?F4xBUDPUELIuAx6NFdC39wjHwKLNXxEXWh8THRWX6tP3IBXWg52Y1F6SiDz2?=
 =?us-ascii?Q?mq5sib6GwjX295fXhi8Yvq392ZFOBWfxd1OnhYLN8s0O7g7F4ud8/dC7DO1r?=
 =?us-ascii?Q?7L2qrI+FJPpEmqbtLTCuunC220lrNB4Qn6e/XH/0gKY/sQEy1Dn3PLn1EfSE?=
 =?us-ascii?Q?5dl0dF/F5LWVpPh7HvGDFOZzvOYpTcxjeJ9kP9v8XJNNCMw8aqP/8YAym+FK?=
 =?us-ascii?Q?/X1BEgCcUyrjFhbj2cj9Xkr2QRi4u3TWg0DD41C+K1b20IFi5Wg3Aa4ZS2K/?=
 =?us-ascii?Q?oX5mkj+bWjj3SdJJXijOPooFLGkuHXLLaMpJVR4uq4ZbNbbZz+1yRfkibzGx?=
 =?us-ascii?Q?FHcyoq9nTGgZUOTrANIGSsUntkAd0c7oaOPeyq+h7RF2h0hPZfdy1l0BK0Lg?=
 =?us-ascii?Q?2SbTUeTn2fK2ipuoX/sXEZ7rW4HOCmsFDvD4+Xx/jIcGLB8kyhWOLMeBhyEx?=
 =?us-ascii?Q?g+mye6ibkndgfJQElwUwwLvwngvFef58DDcoSg9+twNEWDS+MHa0RtgrC5jv?=
 =?us-ascii?Q?2bxCT0K5RsqiBxagMJC3W0pivSE9fKnXD7Qft0yHwZtqOwj5ICS1LKeiiIem?=
 =?us-ascii?Q?F0mDDlJonlv5XLPf/+ZcWs8wnn/aSWp9yfKyhTPNWHKhCsn25zOzP29AokYY?=
 =?us-ascii?Q?ctDHxg3/d2R/0bg/D9bZRbpiGRY9CihS1/DhLXDwNiWnc+nT+QNzKH7rsa/N?=
 =?us-ascii?Q?d9cdqMPk7aUuyuwcoSYA8TqdT3Dygm1FrwKM5YO4HDu3UqjzrDi9eDFopqlg?=
 =?us-ascii?Q?4teDzR5BQrQqYIDWmzihchAeqqMLfA0J?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8567.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qpn0KdRrrs42w4CLj9DVLm4UL19yE5zsB/BOGK5K1gKZpEtkpx2DfUsSTRKR?=
 =?us-ascii?Q?GS2DZt1rUI9ULmLjwAlvSWEgnXPC7bpiv1EOpPxsjq6YTLxIKakNqrxHtLOj?=
 =?us-ascii?Q?kzbWGz6/zBsjl/ET4zn/cdUJtEry7/XyhG05cS7JnwN9FtXvrEFSEJkZxoBe?=
 =?us-ascii?Q?osKVYctwYwMyXp0dOmezXi8sypdvKf+uQp7ZiNtChmF5/Yz5DyD+bQ99lMNv?=
 =?us-ascii?Q?a2QjMPrmPpq8/zHGQJTuhDnPNgxB1SkFQtlhLorhclB03ZwSuzK0cYvESJ6N?=
 =?us-ascii?Q?m/z4sFeLwJKWnyW7Es7JWmrtpSLwHK3fF7M0VCSiPyN6nPq43Ij3Azob7aqC?=
 =?us-ascii?Q?4M/oPeWktdanfZTCq9rtxzTkhNFyMgluucu5t3lfNizoW0kqWLdIFAx+YDyq?=
 =?us-ascii?Q?HaXe0MDjHwIzGsNac+uVeq9x6x1wSohL6gIuLE/Mgrm6NBu4pt7I5EcioEoL?=
 =?us-ascii?Q?kxLt4b5E/3AA1LRw+TAbS0roLPVsrEFR66Ju829oqLdOAl8jgL4UUqAChhF4?=
 =?us-ascii?Q?PlxJD0avMte6isCVoXzSaNIAoT239RnwW6KcGAlCVUoE7z04nfjj30YYH/Pg?=
 =?us-ascii?Q?ARXNDocKNA86gcD+kdRsjoJNwx4VTsHHqMVG6DIEZmqUjZYtjAUYpGuUFWhr?=
 =?us-ascii?Q?5R9z3cyn7WY++teRNY6gTdQNnRT8u7gUrN2XJ6Y1WFnvZokJT2lQVeWDO+iH?=
 =?us-ascii?Q?+KA0HNX8dp0bkASLpbrM/v1u8xp8/cwTNWc/BKeluECUJohRSPjpyDwweMT5?=
 =?us-ascii?Q?Bd3uc5WZZ1XDhL9AUHGivG9arUrskewPNT+aoFcG3WqlI22v97lVTZsEvfkd?=
 =?us-ascii?Q?JF0Ybd6d9uVY09A9AqNPg81UPjQS1ZLnhIu7CuRReebiOjs8ZOuCW0t28xwj?=
 =?us-ascii?Q?gTaFGiy6rGGpM9IAH91yftDex4Q6J+nxqNi+GsLYe0Nzm4+SsNVflAnaM/Kr?=
 =?us-ascii?Q?AuoffxChu2YHhuPxt4wIquWTm29suK9uKR5EqLtPNPKpJnnjqe37rfrHXbIR?=
 =?us-ascii?Q?Bw/Bj5eMwiA/k3pIYJvpzHud4Df7ycO3ilV0sx4Vd9PAcUZSJE6cn+iJ/xlf?=
 =?us-ascii?Q?/yxRNxkjkE4Sti+8gCKrQY1cOc2Z+wBqhChQvcbVe+9CPXx0Vmfhw2AwYkuM?=
 =?us-ascii?Q?lDlW8OCCJw3fcY44J0GSxs0xgKrWH50Xa3p7eG9ib3MVKl970d7Sjr6PuTyh?=
 =?us-ascii?Q?LMDeK9Kclwwa0JqQeUNpDppHwTwCyOkkXaz9sPwZDuJ2hHuWQ4RHSVHABxBm?=
 =?us-ascii?Q?xne4iGTS0tnFAXc/IFXhS1aoIxpgSYDsCZYbEIoQpGYu4TrDKjn//6805Dqp?=
 =?us-ascii?Q?1FTVGM3ZO0mp7H7+0tCmlBkMSc2uIGEV1b2ctLYbHM7hj0BUIgnidX3WZRzT?=
 =?us-ascii?Q?DdNxVQ7T4tjXo4he9I/RCi0UV/AxM0Vw494bYM7o9yUm3CZxXH83THmbfPBn?=
 =?us-ascii?Q?Z9j9Y++2m06Zdk8bGR65W0bS7yaX78aS8o/l8BfGze9bPzQBpno7H/007Kyu?=
 =?us-ascii?Q?ro9gI879pb9h2qJx7u94+uLmMiPKr3x3Q0EhsHN2DZDM+aIR1Mld96PSEoKz?=
 =?us-ascii?Q?vQYCxa3U+s3rfLQAMBGxkWV83QsZo0d2yyB8RMsm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbce98f8-3e95-40ec-d2bb-08dd64fd3aaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 02:41:33.0198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gNSSSoudnaF6jnL1fW+9XA2iatAL+5EZGQl1BkpilmrnFByiSrbXXcNOc4i/ssJw+fEaKKvi+Yh4K0FCVL/tPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10920
X-Mailman-Approved-At: Mon, 17 Mar 2025 05:35:00 +0100
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



> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Friday, March 14, 2025 10:28 PM
> To: Luke Wang <ziniu.wang_1@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>; jh80.chung@samsung.com;
> pbrobinson@gmail.com; marek.vasut+renesas@mailbox.org;
> tharvey@gateworks.com; jonas@kwiboo.se; sjg@chromium.org; u-
> boot@lists.denx.de
> Subject: [EXT] Re: [PATCH] mmc: mmc_boot: support sandisk and micron
> emmc boot/rpmb partition resizing
>=20
> On Fri, Mar 14, 2025 at 04:10:24PM +0800, ziniu.wang_1@nxp.com wrote:
>=20
> > From: Luke Wang <ziniu.wang_1@nxp.com>
> >
> > Current mmc bootpart-resize cmd only support samsung emmc boot/rpmb
> > partition resizing. Add sandisk and micron emmc boot/rpmb partition
> > resizing support. The commands and parameters for resizing partitions
> > are different for each manufacturer. Select the corresponding function
> > according to cid.
> >
> > Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> > ---
> [snip]
> > +	/* Set EXT_CSD[175] ERASE_GROUP_DEF to 0x01 */
> > +	err =3D mmc_switch(mmc, 0, 175, 0x01);
> > +	if (err)
> > +		goto error;
> > +
> > +	/* Set EXT_CSD[127:125] for boot partition size, [125] is low byte */
> > +	err =3D mmc_switch(mmc, 0, 125, bootsize);
>=20
> We should define EXT_CSD_BOOT_SIZE_MULT to 125.

OK. Looks good.
>=20
> > +	if (err)
> > +		goto error;
> > +
> > +	err =3D mmc_switch(mmc, 0, 126, 0x00);
> > +	if (err)
> > +		goto error;
> > +
> > +	err =3D mmc_switch(mmc, 0, 127, 0x00);
> > +	if (err)
> > +		goto error;
> > +
> > +	/* Set EXT_CSD[155] PARTITION_SETTING_COMPLETE to 0x01 */
> > +	err =3D mmc_switch(mmc, 0, 155, 0x01);
>=20
>=20
> And if we don't have 126/127/155 defined today, we should use
> reasonable names for them too. Any other command numbers I missed as
> well please.

Thanks Tom. I will define those macros in v2.

Regards,
Luke
>=20
> --
> Tom
