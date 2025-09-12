Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4539CCAC582
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 10:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E4A5833ED;
	Fri, 12 Sep 2025 12:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="JkZeV/QH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EBAE8341A; Fri, 12 Sep 2025 12:08:02 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 642DB83322
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 12:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFERJBJOrCV334LitWNzxpB/Aonz1kG2iXsA7091Y/vM3uP/b3tPonoFpfEMQbNB6lSaf0bBdRhz4BI8J4zYj7o8WKYKIbDdb/dnyfvfjJn1WW0stubuHw5WTmySmuyR96x9/AP6AB/SVyb+Agr/1m8fGqElyYB88BgyJXB0mLVH2230W0k4BtFHd40+UWl6FKpbD2/z0Gok4vXQMrzxaGHb+L+eJuE07vmFZ2XUcAVeft1SUet2fai2HtkRMMvM5UdiweOf7/zDR/tNxNSeRhKEKGDHH3iD2CQd38qV7SVUoEndl9FXS9giT8njxFcLzkJ13wmqpIqoU8LAhfesxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePHwoop21BnX5c8oHMAGEWv5ILTyS+s4Sm4OujGrDgc=;
 b=YSfOr/FEgTpQJqPrbWT98b1MFQfj4PhOSxNLyJR19HI+goI1FmERNYlIJCAUrd4/CFKZivJbGMNZ8uo+5MFbppQntjodlzBoUvZH7WGeacDJsxacUudjp3aFQPP/A0H6YGWX4QZgvpf1h4WwN2BuLJduSZiNaKHeUgt9V5mn3NU3ZaH9WVfjuVjbffDsZ0CipBP0LzDZ42CYu1kpH/Vihvq29Jsjhs8QNq2JvW3pKYJ0pSU9FvrUni707z41UcDOdaofkSSXy/uWWn8y5tLSlzpPeAYNdWopHJAMHi8Y8Bs8iB3w49W5QsYpXvtXsXPYve6/V+B7cQecB+7dxeKYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePHwoop21BnX5c8oHMAGEWv5ILTyS+s4Sm4OujGrDgc=;
 b=JkZeV/QHELTVCVLnKXd53UJza2QO+yq2GnaZUr1A0P0lyscoizrOHpRQPC47aOjBHDczEennbAgyS44zsblro0cglbJrZ88KHny3idta9z0YYFF6cHmoNhONftWrGNJcfLvU+BP6Fbqpfh+1HJjHLDb6BrF76plHQskLnzwRADD16qcByzIhPx1yTrxvhSqfqqdBXkYb7lHwifIkLACnSwuupE+wS2ATEjcplZbhf7ETLrzTyb0pIdDpE3xf1dmK4Rbep0UmXuUqvmHS0IWcG5XdwhtRJeTHt4JNGBCvDxCfo+8Qdf8c5LoXzDGpxVFkW9CWNsDwF8g5PqQ8lxRVSA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Fri, 12 Sep
 2025 10:07:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 10:07:58 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Ye Li <ye.li@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "festevam@gmail.com" <festevam@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, "trini@konsulko.com" <trini@konsulko.com>, Alice Guo
 <alice.guo@nxp.com>, "Ye Li (OSS)" <ye.li@oss.nxp.com>,
 "tien.fong.chee@altera.com" <tien.fong.chee@altera.com>,
 "alif.zakuan.yuslaimi@altera.com" <alif.zakuan.yuslaimi@altera.com>
Subject: RE: [PATCH] arm: armv8: Fix spl recover data section broken
Thread-Topic: [PATCH] arm: armv8: Fix spl recover data section broken
Thread-Index: AQHcI8lsobwLHH6QcUCYwBnWgfUYwbSPUokA
Date: Fri, 12 Sep 2025 10:07:58 +0000
Message-ID: <PAXPR04MB84597A23746CA4919C6D0EC98808A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250912094111.319680-1-ye.li@nxp.com>
In-Reply-To: <20250912094111.319680-1-ye.li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8476:EE_
x-ms-office365-filtering-correlation-id: 4a3c84fe-bcc5-4223-aefd-08ddf1e44016
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?SVQ8CauwqTT1uyqNvtGmHeD2get20n3M5PkDFYfrOpdV+xNyBx1r1If5k6VE?=
 =?us-ascii?Q?jWy8sHH9Nmp9/uVuHIre2DmeUS/iu5/y8jlAy3tdiZCe+9HT0Y37H92MpPxd?=
 =?us-ascii?Q?veYZ//IhOji4L8+YBSonwyD+pUPipNLgNs6/TPVo7Lou7P+muHRRnofZVWpO?=
 =?us-ascii?Q?r0nwIkIYbaoZM8c0Y0wcVtpgDDEwTM3ABt1sjjjG4cGHOE4SC9LLfEgMDr6C?=
 =?us-ascii?Q?xG7zvmoKsdsUDpriH8fhdAV/pXwO0jOWql1dLwHr3WlboYDV863qJXq8M8yh?=
 =?us-ascii?Q?FtooHuiRlb3rKXyj8sUaW3+0eL5Yq5qNB/kigsnvP3Ii7VSMlOD3lZW05apd?=
 =?us-ascii?Q?tMZaDdOe29AGE482GIAKt5V4KBiZa9dSXFGOUuNNVirNpmoNk+lILNfnyyfJ?=
 =?us-ascii?Q?3WlBAzz68dinZX0MyiapbhCciJwh+OjpQSSiBhMMtSmi16m2AANTZnttUyEj?=
 =?us-ascii?Q?Eym4C9E/jCWgJNHJWXJiCaGpqifM3F7ZucxKo22Az1vdts3cKr/A7b4K/yYY?=
 =?us-ascii?Q?oAlB/DmlIxlqL5QDeRpE5gOqArus1pWr4ugY/i6rZmnlzJZXY1zSlhIbYVO/?=
 =?us-ascii?Q?E/LlpUsQs8nymGz+7NshI1jAvM2NYNIRHsQU9dXqGUdVmleBZBSwZsaPT53r?=
 =?us-ascii?Q?Oy2sqWbAC+HDI8jEWyzDAv9vOWgP2u9rTylPugGFNXQ2X2WC8sgQP6JTM+Pj?=
 =?us-ascii?Q?6i1OE35DDbdige4sX+JbCggqfVq5Nug5MF6LxyCozHLmEAy3oZ6B/40AJACr?=
 =?us-ascii?Q?GDbnbzax9U0gayoLMsjfDr6es+jQu9JN27ksa4IGqDmI6IiI6StCYVvI64m1?=
 =?us-ascii?Q?kzgcr7tyFbdia7gCSWuxJ6Yy05EZR73ff3fAwIcOJ4fZ0U1Fr9PVoD4YTo/B?=
 =?us-ascii?Q?xrgR3gXI8adqOl7xN8Tu36sUSKJHaPDhjZkIIGYi0gYnxAyzUf0WMZvpemb4?=
 =?us-ascii?Q?yPqi1C2Y6CRH4XPwd9QdHi7uzrzlsylzzZe3Z14ooOS3KnzwMADB7c/Q+U1K?=
 =?us-ascii?Q?ktHfDeqbeZPHp4i1xrN+LYkCXf9s/Q3RzNdjZNiGxjlo55woXKbaPfECxyXY?=
 =?us-ascii?Q?5kEHiS4PCIbjOx96984AGWN3eJtar2dpjoVbCq5nMYKq7ccs227C0A0gjmN6?=
 =?us-ascii?Q?NPCOYIF9X1ZBGJKaKQMr54x6Z/NMZgupyDDjvXr2upvi6asGMSMjLpmMuDFH?=
 =?us-ascii?Q?I630BnXZRFCZ59MpH1CHE6VmvWtFXzgh5fCtH6cvdCkmLcxeSYivacpeWa9I?=
 =?us-ascii?Q?wR1JCMSRrN0YRY0nEeZ2zyBFGXU+YlXLTvGal2czbUz2LvjVwumKFPUX3p9+?=
 =?us-ascii?Q?Ef/wrH74kjbx9lfHzhbM0M+Rn44fLGrhib7QGCn6DgkU9FyFqe/Qo1Adg8kj?=
 =?us-ascii?Q?ZB/nBCLC2iD44qHHT+ntgEgMDU2OABBP5Rei9J2dww91zpL6UomkQ4hagTfn?=
 =?us-ascii?Q?MZ+pxloEWH0eA9Rxh8vjWGZvmNJPN0Ef0+et0/PwABq+geN445xfTYv/z+VG?=
 =?us-ascii?Q?JLACooStH1XoNoM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WNyrucaHepN2KnxBaPBMr8SRM1S6rtgDsqj2VBfG0Q51JHkEKma1o/sirFyg?=
 =?us-ascii?Q?SPS7KP1L8HrvVG/I9Hnx0zrfUCnmxwpIMmByghQ4YZLOVZCd3zRfyGjaaH/8?=
 =?us-ascii?Q?9VSN555IH0OBOGq43hTXFbIVRrMkc0M99EWdF7ptXsBhMuOav2BIQ9sGcX2T?=
 =?us-ascii?Q?u5eBzTUTDgpAa8W4kYkJriREbDWGMFIGHEUFZuW6GWmKLAwcJ7GLAdK2edp7?=
 =?us-ascii?Q?7g3kh7KjnT9f92ftL+YSqYpDmx17+mCG6xL/a2qUaSPphFBa4VbDPzrIQznm?=
 =?us-ascii?Q?fOaFmieRb0UQbm7esdwg6FDdasIXLSU6zdzEdfNZCu0cpfZ0dzCnodTv/SKP?=
 =?us-ascii?Q?EwEpreqvL3FxYfaix9k7mF5I9h/vMgTgC/fHny387e3DD3yJegFRPkDJDwuE?=
 =?us-ascii?Q?6rleb0WhD/xyh+z1B3RJRL4wbVznOMqrdnUWNm6HlGIYHgLfNjeQEB6FmZii?=
 =?us-ascii?Q?b9HNJj1HonNkjh7yYmy5N1oU6RiP/2VyiZbL85K/H+Gey/aFlUdNXG/1xicS?=
 =?us-ascii?Q?eqypsdfrSxh00s0Gy0ZTieuRJQy5Kf/wuH4vO7+srP6vWaGyDm8GcDyhLUSU?=
 =?us-ascii?Q?w5PirYioKcp9Zbav31dVjiwwHTMb9Skw8lBTLRToMAP8vN/WzJbMURtE1Vv2?=
 =?us-ascii?Q?/COq6PH8nQxgYQXFhlxq6MRKHeKHGUxN+mheAWViwkBcQq8E/E//xAmwtRlT?=
 =?us-ascii?Q?WGfKAi7V/seEg2Z4j0UBgLtA7j0ec45jLXmK5EQQk9rvxT3PkfAYjm9Y+Qyy?=
 =?us-ascii?Q?0KiJ1tWquRGcts5Q4xRjW7F332HTJoDjNZY52n6s1RxFPyX4TBKDPHmxnQTi?=
 =?us-ascii?Q?i3OOF16lN+SQr9aVMaErsV4BJVhmEMSo8WxVUb1cqMV8JTCbQAp4cjCu/9as?=
 =?us-ascii?Q?4+pIonLWK/DFdoRHS8yQiv+Skf0UX7YNNBZ1eWhqk3A8oD/RXMBrRJ05UQ0H?=
 =?us-ascii?Q?paN2AU6ylWQh5kb2/JXxxUDgXiO8KP3KO9nv3SD93aAoSC5Ln/6kSa4hUYXn?=
 =?us-ascii?Q?wmZJjETZ8lGaEDBHkhz0dLXl7V7bvYDJFl8oD8Oy5+/3tcrufa+N2BjpodBK?=
 =?us-ascii?Q?oaWqqQ8VWtdKGv3krjOItMIC8eNzlNt84jtsBooO3tmQ8JugGyqBt6nmDlXR?=
 =?us-ascii?Q?+Mv0SOltYa+QyE8HuoseahrYRlSwxg/1wuGzkijQ1r4WMM2e8IJa7ZXG+efF?=
 =?us-ascii?Q?GbSgu3dpU3hKg5bub4PYhocGltkKeP8OSmhtmvb1Z8A7NsKEZoGq6XYZkFc5?=
 =?us-ascii?Q?EU3/8UMfns9iWYXrjYwd0NMILhUGXuXwMrFZ6+N2W+SOLBxA9w6WMLMQyty1?=
 =?us-ascii?Q?sCZcPyh1NzjSZAGR6JzKQvvppXq3zNX9YWAxLjWBlI38uHovYtYGOEOUAfHx?=
 =?us-ascii?Q?D/oqbzumpO6BFrpOMUYbeCh7X2lm+u+P8EqDmyMyqc1CciTol4GYhuIxMAaT?=
 =?us-ascii?Q?aoyTGYuNChyK5R9abx3OiYFpd3nO/E7feuk+PoZeux0aGBUgyauwWXI1dtRv?=
 =?us-ascii?Q?HQ8LhrQLTwd14YZEgdhSjMf+jO0A02gleuc6LXWc26QA57wV6II5OmFV9MbQ?=
 =?us-ascii?Q?EEUn9Pqd8muDeUj0ApI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3c84fe-bcc5-4223-aefd-08ddf1e44016
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 10:07:58.6199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fHV7hs6dfmP9W+zOSSWNGmkit0wP7G8WECrjlasbHW6Sr+vazMss1pEvs8ymvvnPP3HoYA2rm5/yT6MihejGAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476
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

> Subject: [PATCH] arm: armv8: Fix spl recover data section broken
>=20
> SPL recover data section is broken which causes reboot failure on some
> i.MX platforms (iMX8QM/iMX95).
> The global variable cold_reboot_flag is assigned to weak reset_flag
> function which always return 1, so restore never been executed in
> warm reboot.
>=20
> Fixes: 1c37e59bfbba ("arm: armv8: Improve SPL data save and restore
> implementation")
> Signed-off-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
