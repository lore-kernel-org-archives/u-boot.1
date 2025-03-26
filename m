Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3029DC28B30
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 05:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C03B681DED;
	Wed, 26 Mar 2025 06:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="QkwWoEDL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19FA08186D; Wed, 26 Mar 2025 03:20:51 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DEEB800C1
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 03:20:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziniu.wang_1@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwkkOeQeE4RZ6gD+dzps1eLhWtXaQmObCiHbknY+wwXpP/7PnMOj0ufG+9gNOchYkUWc9dMUfWxUw1G+cUiJl97NltTub1Uj7r2iuujU2lJPVv5MzCvVOasS/vn/k++8kQ4B/86Cv2wuN0Q49bMTLMryg9KNq990cUwbxMilGQuZo/y1GRnaP6ZZDA3m4ay+tDOlDwfV/QbCJEPsagCwDLQdL/sB9v1/s00ui0kb8iyBxu+88pIFQyuI5Q6Moierk5EtMICGQnRN48XrfjUD+kY44DVvrnNgBAqtIdo5ykz1b+5CZs/yjCSE/HOwWvA5Mg5D+nQ/7xoTsyZ7fYhRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtGgJFN0mCzYDkrmYIbn7TzNDx7fNmWCHb+eTAoXtNg=;
 b=QF5aw5/3gimq8sqViLvlsUM5CJk4RcEXxT8ykhJFanM8oFrkSrjJcUYafRnjn1oW6ciXguAV6/bxnMEO5MIaYAYsNOtJ6EAKeyGVqdhg8/PTm8C2xKeA00X6oJZcjinIlKoweN/gLE/ytjk7tcb5Rnk/mD1cUu3++cyPHIFJAQ+9/deU6v4TC8N6GLPJQWjsJi7kI7Q8WL0g7YC8tWYPpCxK9o/qO55EHQlOUdwsttfF4i/sj7YZKVi8Stt4WJgrw1Y+nU8Nb578+939OemjXWH/B3E2YW8xBCVuIt9oFs6MAoKJ4v3ki1W9lYXgUN1hbnoszOUi91uN/KSarbpKMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtGgJFN0mCzYDkrmYIbn7TzNDx7fNmWCHb+eTAoXtNg=;
 b=QkwWoEDLpXvXV/u6L1pA4ssQ49V1kErLEtQUpEiayagMkGqCy3UYzwNlBuvpqIVuhUzooRMrIFTU+0DikEOhzrxIahedmzDnG3ioWpWbEMiOa0dVUF+v4qn0IzXHcF2zacqNQHgg5lqWrTcm9kTr0Po7MQ6su8t8q4Xr22fy6g12TdfcOe9dQMraru8kO6ha6VSxwH27xHh3y9BebXAa5EMggCf5UshZaG0gzCOJ8KWMlny2R3YFkGrv8eQ1ha1sc9cjkJwiMyEQ+Pl6FHcTiRWW1k8usmz8FaRj7kptP7iGyJv09VxcWl8qSrBnbdiNCNK5zOeaYHyqMgOtCaG2NQ==
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PAXPR04MB9203.eurprd04.prod.outlook.com (2603:10a6:102:222::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 02:20:46 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 02:20:46 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "trini@konsulko.com"
 <trini@konsulko.com>
CC: "pbrobinson@gmail.com" <pbrobinson@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, "jonas@kwiboo.se"
 <jonas@kwiboo.se>, "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [EXT] Re: [PATCH v3] mmc: mmc_boot: Support Sandisk and Micron
 eMMC BOOT/RPMB hardware partition resizing
Thread-Topic: [EXT] Re: [PATCH v3] mmc: mmc_boot: Support Sandisk and Micron
 eMMC BOOT/RPMB hardware partition resizing
Thread-Index: AQHbnV/gFBShsiYKmEGsQ+YpxPjl/LOD6G6AgADG34A=
Date: Wed, 26 Mar 2025 02:20:46 +0000
Message-ID: <DU2PR04MB8567774A082F1734BB3703D2EDA62@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20250325082914.2240470-1-ziniu.wang_1@nxp.com>
 <5005e7ba-1b9a-4d49-9cd6-d48a8341e436@mailbox.org>
In-Reply-To: <5005e7ba-1b9a-4d49-9cd6-d48a8341e436@mailbox.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8567:EE_|PAXPR04MB9203:EE_
x-ms-office365-filtering-correlation-id: ff1214e3-10b3-4508-73d4-08dd6c0cd169
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jk6ea3+uebQsW9vBFxtjtZQZz0uXzrA5/a1oZb6d0q4j5tfwLS++Y52XlbAq?=
 =?us-ascii?Q?oVKzDNMcY9euLzwbo1z/V9ZVnIG3+OdRi7PTsW//FpmV618cUDdZr4SDWIEi?=
 =?us-ascii?Q?NmbRb77GIMNIaEOiUctQ1OXkYldxC8EtXUlIJAsepDUUx1UbJSVHKcn7Un0e?=
 =?us-ascii?Q?VslPhy8FUrApH/APBqLHpGsUyiU5NO6E+6ay8/93Dd3pb6bcapaS4gwzrj8w?=
 =?us-ascii?Q?2PLm2TzPnq7MWmwZnzNttBUWM3cfSROxgpHGYbG2co1M//Nhnn5gzoEeXITW?=
 =?us-ascii?Q?HdIG/yFR3Fh4ECLTnNExUidG2Du2oizoFFr3q+t6+GgBj7Ky9aSaPQw7223r?=
 =?us-ascii?Q?XY9g9dCfY/Hx5AzIE0vDqr7SvJFK+2gds8qmLhzrlqDJmkIedZc6fuf9C/Ox?=
 =?us-ascii?Q?plkQ8taDPA85QKU5iruYjsbvjQ0OWrkeZ9jkFqXTEp6x/Y+YY6f0XmgZTKZP?=
 =?us-ascii?Q?UmgFVun7055FG1FZ38NYSOaKJdt952dKaDmQ3kRvIfOsFCksy0M7miX80lON?=
 =?us-ascii?Q?Y0/Bs8YYLSwWVrOR30JpQyp1mQ1h4yctS5KtUyPn7nYp0azAIEHGZX8e8oFg?=
 =?us-ascii?Q?7iMoaFJj8ULIjHTGfJPZoF8jjepIMHCAxn/6tKn3FuQhVzRkLu9U2yg/J+7K?=
 =?us-ascii?Q?ksPiTyAB8WM9I0z1Yihi9ni4uCa8CG2aq3oqseltj7oNkwMD00rNhS6wOIwR?=
 =?us-ascii?Q?pPqHm9wGvaRtdZ0NfypmvdbPS+lPCNWR2UyDlqdppFu0PC39eg7Zo8fD1w7i?=
 =?us-ascii?Q?pklkWZ6ChMkakpaSYXsECqC5ylf/Hd5irRieOEOeINbitc5MlLabtjIKaHI6?=
 =?us-ascii?Q?6/nXOdx0OPcGZXeH06y47olCleGptZWr1o0upGZAvrWjENoeM0NngP7OqFws?=
 =?us-ascii?Q?Sc0j8uFguS9LKhMKH5OIq5kl8sQv86Qbq1rzKg6v7RD5ftVZPjyTmo+dehH9?=
 =?us-ascii?Q?iie2wq1qgNCh+iZt5Y9fe7jSd6XbBAyujUwC+AMgk5KTuHvbgSBkp+S3vxEP?=
 =?us-ascii?Q?tbuulmekPfSiNBiUNjcXiWcpknLAxp+uC1APPPml8Ll4FhrfyhFYXO1dvelJ?=
 =?us-ascii?Q?MrtXadcdS+kmlRCAED7XOvzVEZTZI3FJHuDtw+hS+52EKxfGUorb49ebusdF?=
 =?us-ascii?Q?NldRtvcel+3fI44o1Xwi0J14eszaCcRA0jru+YeI2jcR+XqMjW7ZpPYSqFgO?=
 =?us-ascii?Q?5LPLHkU7KN7I0R7Y4elDLKhIBSvyRwddUG9en0IcTI7G3/sw1x0RfIeEqUtx?=
 =?us-ascii?Q?GB5vy8OzFJudT88A9khng+7qFo5vtVS1wCMCf7tP5yq0dd8UGAFyyyTamYmh?=
 =?us-ascii?Q?YtgEi1NHro7LGZpIYyU/9zlzxWpIPKI2OGSmaTU8Yfm5zpOTY65O3suCf8xr?=
 =?us-ascii?Q?NfNtzgoQVYYG+DzGkRBCht/8VS5VXYT7QMCilNBmiIXlTpYz4lYSQAcHjaA3?=
 =?us-ascii?Q?TVGhNNUbnlDWiCXBQhvOvz4hjuM9pG9M?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8567.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lf5TYQglRbu9B+t3pFP9MEufxvoD0xSbUCaBOkUNe3h2r7FuKJK5a9lrx+0S?=
 =?us-ascii?Q?XjNR+5MSkW0EQtGvsJopz8G4bAJW6W3KXuoV1q4BfC1XtjsUbnVd9MvZfs/i?=
 =?us-ascii?Q?YUsrrq/6xjtnbw6nXthJtNbTAPZptBd6wVLnkpt6+kjDcoq/UTwfWYYSBiEi?=
 =?us-ascii?Q?V7sLkiAK6QDo+NpRA2MXFmKGxFdUDjIqQ60zsVdxwnW4QiZIvyjUG32+jeIm?=
 =?us-ascii?Q?/fIXUUxTiamJMtXh2CjYOrzV2b5Yx1rWMqg8C1uhgz4+6bP4V9561HlD8hk7?=
 =?us-ascii?Q?1b+AfQTUqTVwJ8Cd/LZqGPkF8QVl2ysh/9lMpLg8kxP2KLzaehozaXuZ9zQE?=
 =?us-ascii?Q?2lLHUlwdSWmPWLH8Yf4K2ACHM5H741az1428/bvDSoNOLwUFKYoIbJpHvOIU?=
 =?us-ascii?Q?PZURNwyFcPLSkLsupAfkW9r4JmUlAkwZ+edGVbt2m8fEOPhdrQKc3SntpNWw?=
 =?us-ascii?Q?v0I3ryrXUYK8a+6a8P3oYwiPbYijZyWfbsUQPfzmizP5aKFjLG4OdXEE6NVz?=
 =?us-ascii?Q?b+5CJbs+n5EhF4lff52TxW6VGUN1GrphIRkKaO8LVeCECG/+ogMGZsZ3uqP0?=
 =?us-ascii?Q?WQDkhzFJZLhlOglU4ivSMxrnCY/IFwtk+24jGcbKrf0+8IIeT3n/hHKhLvP/?=
 =?us-ascii?Q?VI0UbGNKtXottnLryWP18LhQduHOg8vo+V1inAnkg99t/JWixG3dt8HUPLGq?=
 =?us-ascii?Q?ESvYlk7MsATbvgsgul5qJ8FZTsHVTsvNQ0JXUtyhwqqf9BqgBOjYk0cXDq3o?=
 =?us-ascii?Q?c9YuKPRgVOFTLlV+ZiPDzmk+2BkRtbh8ALbFaaQ2u1CYU/XMvO9h2ObqIBim?=
 =?us-ascii?Q?RBtwd6Rp/zgXkxitWLTHKt1t4vpiycKYazfibYjmvO9w8NjgYp2ejo6EE25h?=
 =?us-ascii?Q?EoqgP3yxjoT+97xmr3ymDngmjz1pG8ZY834zaptm38KhrWpikrV1/LIGxmav?=
 =?us-ascii?Q?B2iDnrVV6loy1ENdA/vFSF/LXPcFIuhX06t6V1T0itbLwJ9lYUxEKSVKSepy?=
 =?us-ascii?Q?nHCHlcp9bt7ApynUs7VKmrKEfmwgL1Z0g5dPIQ4b/dSwR8mFP+hnmW2JyeHc?=
 =?us-ascii?Q?vxLRZp2NLJ9L8hPdnRIE2HasjXqf8WP4mak5fyJaz5e2hTSkmOF00q/fJ3yF?=
 =?us-ascii?Q?J/b6oSUR+3tLgCWnEwRcXPiL11FbwzpPquQv7DPsYWuko0IU51FPS+ZIgYB4?=
 =?us-ascii?Q?XOAr2kIxbkC3o8LIgTZoxcLFl+4HZuWDrZaKJIUXqbjEBIHq0n+T6/2X4txx?=
 =?us-ascii?Q?FrKaKS6QhAwzVfK4irvB2Y/KdtjZPdjKT8qQC62pjMbwQhkr8EYcVk7/2kXb?=
 =?us-ascii?Q?z/4+MUcBijss8d93qKcvx+VnI85zuXwRrPoIst27m/WRIHunCqNqXnOsJv8E?=
 =?us-ascii?Q?W5Dxyjc1MzVRg0TCqA8Bw3RP5CJF/7T0ZKhP8T/B6LE4axUAm2fPPjCTcrkb?=
 =?us-ascii?Q?P24XiMbRfOdHlDNKR7fgOp7pfyTGYl9KV91O+M9jSvwglRcugelF7JZyGEgH?=
 =?us-ascii?Q?0q/vLApz06PJo0xjnOxCpnAPNqIqhPG9N4jr9u0ji8an3szdkJY5SR5vysU0?=
 =?us-ascii?Q?9yGqQlkf0C5Wsi0wdS/cTmwGxQl0MASoga7ui+Om?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1214e3-10b3-4508-73d4-08dd6c0cd169
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 02:20:46.4859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ekoK5d9dlMd1rBBJ5BgPnjDFNyF+MDzgw2sFpf6smsrtN3okKhOiFTEDRNndVn8/KI+Ce7dtwpffBGXdCfigw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9203
X-Mailman-Approved-At: Wed, 26 Mar 2025 06:01:30 +0100
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
> From: Marek Vasut <marek.vasut@mailbox.org>
> Sent: Tuesday, March 25, 2025 10:24 PM
> To: Luke Wang <ziniu.wang_1@nxp.com>; Peng Fan <peng.fan@nxp.com>;
> jh80.chung@samsung.com; trini@konsulko.com
> Cc: pbrobinson@gmail.com; marek.vasut+renesas@mailbox.org;
> tharvey@gateworks.com; jonas@kwiboo.se; sjg@chromium.org; u-
> boot@lists.denx.de
> Subject: [EXT] Re: [PATCH v3] mmc: mmc_boot: Support Sandisk and Micron
> eMMC BOOT/RPMB hardware partition resizing
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On 3/25/25 9:29 AM, ziniu.wang_1@nxp.com wrote:
> > From: Luke Wang <ziniu.wang_1@nxp.com>
> >
> > Current mmc bootpart-resize command only support Samsung eMMC
> BOOT/RPMB
> > hardware partition resizing. Add Sandisk and Micron eMMC BOOT/RPMB
> hardware
> > partition resizing support. The commands and parameters for resizing
> > partitions are different for each manufacturer. Select the correspondin=
g
> > function according to CID.
> >
> > Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> I think you missed picking up Peng's RB from V2 ?

Sorry, I miss Peng's RB.

Reviewed-by: Peng Fan <peng.fan@nxp.com>

Thanks,
Luke
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>=20
> Thanks !
