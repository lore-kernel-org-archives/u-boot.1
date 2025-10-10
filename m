Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB968CCD183
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 00:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E140683B2C;
	Fri, 10 Oct 2025 02:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="VS8mnmzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 635DB83B8A; Fri, 10 Oct 2025 02:01:51 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42ECC83B23
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 02:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/2wsrTxTLbXluTkrnPPWXmw9RsSTmgL4jn6aaQEu1rz60fRfoE9Qe8XAp+JxMen6Gi/1sbc2GsUa9m2RxRipN76i12Qnpb5uMw2bJpx5JTlwneI5VnMeigdz3dp4v+VoO47BFr75do07pLDHksSos5i/XhQUbv74jgZ1BLfXMWaynYe1z6cz/nZ75qstm19OJ9F3145zXt7FTz1uePgdq8kT4ACSmaJvLuOw97EfgVs+T3k5NUPSw0klfVc9p9iaXYfMw74UL5hSkIoHPTBGSohchXb+pA3qjWezYaFOS3RP0stY2/a1n9+jj+oXFyVuz35HitW09rlSW5pJlvt/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERIf3bhF5/5hAGGLnTpfonbDIyaBLWe2RcGw4TZP5WY=;
 b=SXWxX0M34hWVeR+jJrwfR/YbRJr9Cvp3fF7exS5fYVbiMw1ta01h+M5MFSJwvjS+yMZTyCncm8eKJmhP5nJRMFn/IDKpXXF/O8bHpuGY5nv7WGEBzKCJ7FpDGxalO6l2fH/AK2FIxb08FpI8WzkIDgxAC7/Gdop/VLjX6ojtb0yfu9MM3W5xuB5yCGVB2+EKG3VGf1L3blfG3dp92tO7/wziCFK6+3dZvFPkebXZwWba409EXW1tqkS9rJGRT7mg9Eir+gDNaVg3pB3c8/VFPoSNACxqz0zLUpLe7EAex9j5InBsG/gZ4bz2fKlVf5NOYm8PmchFYRqu4z7+0INnOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERIf3bhF5/5hAGGLnTpfonbDIyaBLWe2RcGw4TZP5WY=;
 b=VS8mnmzzih4TZS6ZssZntVnyaiytjC4cGKETRPHZa/s/y7kLGQ+vuaSsl1eF+t2/jHKDT558+c1n3KxMoWtVp86wVV3Y7bkT7/2m/PBNbcsFPlPb/wsJH9yBvZKUGSNUkSGpsagc9/KEZKUvNxU5A0Ym/u+iFByheJDG0r9dQ1nXVga/C9iCf4nYjeNFLq1Gl5HHhfgIWkETJk/l7YOUxLCQwIxvSWI8KFwIe4zrdZaGGPPHScGcjDaO18Y5buodhvMvTpxk2XVVw4A/v2Q46dEocK8mkolv+ydLhbrMd24u4yltDbGCyCzqmFukJMm60bh8EiUHbcPizvkQuJbLaw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS5PR04MB9732.eurprd04.prod.outlook.com (2603:10a6:20b:672::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 00:01:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 00:01:39 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 07/10] firmware: scmi: mailbox: Support
 arm,max_rx_timeout_ms
Thread-Topic: [PATCH 07/10] firmware: scmi: mailbox: Support
 arm,max_rx_timeout_ms
Thread-Index: AQHcLvV8BThySXl6h02dWtTdVl23YrS6VK4AgAA+8qA=
Date: Fri, 10 Oct 2025 00:01:39 +0000
Message-ID: <PAXPR04MB845960B0A575E637752842E288EFA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
 <20250927-scmi-v1-7-5e9354fb3bff@nxp.com>
 <20251009201422.GA226328@bill-the-cat>
In-Reply-To: <20251009201422.GA226328@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS5PR04MB9732:EE_
x-ms-office365-filtering-correlation-id: 789330cd-ee66-41cd-f6fa-08de07902fdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?/LLj8eCOpQrF6A2sWA6t3wpOZedJxmrZBW6+F7uRDRsFvfI2gYp9BCUbcKtH?=
 =?us-ascii?Q?of1PaqwXN3hoWm10dwbr60IaZFvDnHgacgZ2v8NKGOqlOZuP/CgbIo1RkjTY?=
 =?us-ascii?Q?cfQoXVDP590p9s643m1b2tmgSv+FxBJaGSC494wNxigtuJsShV6qlgfHIRdo?=
 =?us-ascii?Q?4J+L0OmbiY7Nna3dE7ZIclHbWoO5sioOWG25yivr/GypUlxjrFq3JE04uwHA?=
 =?us-ascii?Q?YF5UHZk92cLsjgQ3NDwHEsW1Z6dg2S7edUW7ZIIWuzSjhw37ipNUeLDqb9LL?=
 =?us-ascii?Q?X8VlBBN/xpRMi6DgooODKw9HLt7lrNQRVk0KSOZg4jKDTBtLnIdBMM2Yzthd?=
 =?us-ascii?Q?YCgDFRgwqGdIrpoZgj6Lvl+m6ePeqkAaHj1bd6wcCOPA/HH6KCYmj1p/0bWV?=
 =?us-ascii?Q?DjaZwDoUpaFCwuAFRH5EcHKHWu7GD3Vx5G5iHS9M99UMA9vpidQumb9CbjEP?=
 =?us-ascii?Q?O0owVw3iDeY+gUF9bpH1rPzu/2dGztDRU4wk3EMtY//ZN3mE6tgT8KwWKZsb?=
 =?us-ascii?Q?dm7mgwX3X+G6XO2HcKUQr1WsHnXD7QKbp4GEKOaWkgs1REuAXAuXGTm9Ai5F?=
 =?us-ascii?Q?/cL2cnAhdQ5Q3VJCJoMLhTaaXlq6bFlzRdykj1Ftg2yAZ0VGpO4PWr/joDGo?=
 =?us-ascii?Q?L44Va9ma9R4LTjA/z8g6/KQ2Z44enTS7vsSlfO7CKCTfIwxgOEMEi/ozoU2M?=
 =?us-ascii?Q?RHsBVcegbe7ob3zWgr4oDw2TEAKI0GEBzprjckMajlQBMESAxSjyJ5dofWEs?=
 =?us-ascii?Q?KsEWPTCnUJxo6VfnkoErJBdK7Caket9mkNRFVHP/Sd+lWK1UL0pwNshez/BX?=
 =?us-ascii?Q?cJy62luBKTlyTykRm1zvxiUdeic7kJdMsjdjxpgb6Ou22hlWOvob2RClg3wl?=
 =?us-ascii?Q?FlMeanOcGvyusJrF/40vcjGUFDkiyKemTycQ7WIkj829BAUDMx03jC8hi8J4?=
 =?us-ascii?Q?Ryg9QfDcN79rWlapCGGlm63P+BmVAkmPO1Ct4thIF5oHn2EQTIv1z1Zs+ydI?=
 =?us-ascii?Q?nztp9vb4ZvM2Pr9YnuQbqCDoQ2jczpbdlmt1+eSXDT6NhQo4+nUpnxkbNXEU?=
 =?us-ascii?Q?YLdbIffDsQUFuGw83W93zFBEXeqlxY3N1LU3Bo2ils/UcuP9uYnb5fO8Yun+?=
 =?us-ascii?Q?V9l1SLFHZsIwL2c/JYa/DRSdfQxp7mvLX69zXtPai17p+eo7Kx9UkkYsmE6K?=
 =?us-ascii?Q?c04kud0VvLvE6cEcQhe5jj7db5CM1VF4HpRkGF/QrxK1SNIJp6BYShDHxbWQ?=
 =?us-ascii?Q?VrKzL5LkzAPRxia2B9PDK2HNBE1e1kkHyENx3QQBcmVUGacTyDMkr2h2c7dE?=
 =?us-ascii?Q?uduJHHmp80nDUa8BQZmFLeCeSgIYo1Zp7LYOQRQj4lu+FSG73UZiH0td3loS?=
 =?us-ascii?Q?zwWrkyZp79UqcxFDyjkM23MHOTaPLMB+XyX/boAKEpSDpxE7kBHroXMv83Ze?=
 =?us-ascii?Q?1A+yHEhd1MT8YLkwKQqDCwIgijTmaIJzEFDzSng+SrhqzBPN85boKvETn16G?=
 =?us-ascii?Q?xaIJ7ZYJBYv4pKQhu8bIiVpPmLsjAqd++V/k?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vi0uzk5EeeYZ8n12/wE1l4jm5sIMXF8BW5F/hf09ZepvPB+dWOXDpo9yjETl?=
 =?us-ascii?Q?ulPSpwzPvp4l4KlItIO4MzAw5uCPS2Rp1cT1LKEUJ7DV3PEFCW7z9OKRtZzg?=
 =?us-ascii?Q?3iSFwJVbD1DMAAWPjeauIAOBONaebkMPNu/qIWWkeZo5v0jxFBEqnu93g7Ap?=
 =?us-ascii?Q?PiZ4If4GXXvs1pLqAFfvEC9vryuMwCOOk0XGbARE12MW2t1Eldbvmx6SSXNh?=
 =?us-ascii?Q?fBMl1tBq8MnqawE7lVq+LYZnGGIEvcWHrHo2GggDjYka07s3AfTuyy2URK0p?=
 =?us-ascii?Q?QReR0Win2oHT2cQC1fi8hEm3fprFY7fpv4PymNAGyokLe6GG8Al5kHZqf33c?=
 =?us-ascii?Q?SZUvR3c/LFVGn3+KuSI+xojns3GttO2imuAICxepi8OvGd61oDyC6AMiBgdF?=
 =?us-ascii?Q?5oI+vmDi52pfGvSrbqIMXef+qVcC1yH0kaIqZN3FvBVCbrYpOBgkSBVLlPI6?=
 =?us-ascii?Q?+eGvyo+wbkzv5z72u97rIQlth19QVs/8rHuOTfGVet5Urrw5Y1Zm+r2v4C3Q?=
 =?us-ascii?Q?7VAzKpRnqR8YaGVahxwVE9RmPrzP3kDyqRAGyRS688W5bxIGgCx9dBBDojJe?=
 =?us-ascii?Q?0luo046VaaNLVGobIXC5hzliafVQbGof7jfM+2wIkQ0whEoD/K0Gzjia9mID?=
 =?us-ascii?Q?xTc36wtHvDF7sSpVs14wr+I7mIAH2t/cU0M6PmxhUhLW0dF/Noguqx5jJcn+?=
 =?us-ascii?Q?/gShU+AACONaAgBLvsYj3xkLxiz2uWTY9yXGCcn3dhMeQ68qp2oloZLm/45z?=
 =?us-ascii?Q?IIbevr/zUoZiyYWcbhp2OGGQpFVouR0g5S8KGpNydpajx/zZXZIfiRHA3tv5?=
 =?us-ascii?Q?45jJPYAxdt4FabnZ3puxu7k9jkUSre7cqRwd/Dc4EmsslBPKR9pFdefO6v1V?=
 =?us-ascii?Q?b4YS6QN/3P8eI6pI/oqpqYlBQs7iaYskAOLehYExTUyYsPO5VK3R8NsutxW8?=
 =?us-ascii?Q?0zjBBCMmpzU+TiJFLrfDuK+hIncXsxiriadBZnfpT1B2FJY0sFE0RoB6Pb9c?=
 =?us-ascii?Q?rv2hohoTzzRb/A08qwt7BV4PMCm1tudNSH2mLq2HWuTCkysa7b/ojdBNhr6l?=
 =?us-ascii?Q?GaxrzQrFcq0NBMm2Nk+yamYWgT6IzNieaJg2LK2w873CECyd8ij2kSp+rjIT?=
 =?us-ascii?Q?lgezisOLxxPn/UAH6Q//zMF3KDSxAozifklPNyFb5llHo8HtzY7q5VyVwIQE?=
 =?us-ascii?Q?yWHtMTSjx+ppDO2asRrgdyAH3hLS2eJFinNH+zFz0dbFiRKD6zjdNUFtJfck?=
 =?us-ascii?Q?jLb1bH7FbHqm3bfmSwDOq7G+FayHlJOKI8pWtBi6RbwfdD/mvFCv5r+e+Ec4?=
 =?us-ascii?Q?JUm3c8W/A2Wfeff8BpNPTCzPWnMLyzuuUVPn+K8NLsUTupWodpyc7tCJaEiK?=
 =?us-ascii?Q?L3Q5sv1EKcx5ZT48dmQlc6N8BFCOOLQT/XkfgOhat5uLn5aOVpg0sw2CXIkD?=
 =?us-ascii?Q?EtYPeValWRMy535W8ScHUHBc+Zp9hHSavvS53rmr/E13pzYc2hbNzWKpf7zn?=
 =?us-ascii?Q?UGUZ7DoVItKnZLg3C9ES9HrGTD2Gu8coZP2J34U2MpUMXhBiUewGd9POlUi1?=
 =?us-ascii?Q?49y6uYoyBuCKPhiHoME=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789330cd-ee66-41cd-f6fa-08de07902fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 00:01:39.2803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/HVqdlatw7lU+vI+ca62R1WOlr4eGZORC+C1Zc+3aIl/lKmTGjKr3nA+g383AD88sa5/UzNMkNsqH9p0Y/7nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9732
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

> Subject: Re: [PATCH 07/10] firmware: scmi: mailbox: Support
> arm,max_rx_timeout_ms
>=20
> Reviewed-by: Tom Rini <trini@konsulko.com>
>=20
> However:
> $ rg -g *.dtsi arm,max-rx-timeout-ms
> dts/upstream/src/arm64/freescale/imx95.dtsi:
> 	arm,max-rx-timeout-ms =3D <5000>;
> dts/upstream/src/arm64/freescale/imx94.dtsi:
> 	arm,max-rx-timeout-ms =3D <5000>;
>=20
> Is the timeout really 5 seconds on these platforms?

NXP i.MX SCMI firmware does not allow timeout,
In normal running, it is quite fast for SCMI firmware
to return back. We just choose a quite large value
to avoid potential corner case.

Thanks,
Peng.

>=20
> --
> Tom
