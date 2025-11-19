Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A1CCF34C3
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:21:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CEA183F7D;
	Wed, 19 Nov 2025 16:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="BbLJ9CB9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22CED83F8F; Wed, 19 Nov 2025 16:21:14 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B27383F50
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:21:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3pJQjJZuq/sRwz6FqsOTOLTthWlF1jONcQEfFBAWu3Pi0wt/kevk5Lx5r8XjcvCUqVGsPlpeFE0Eq6lj/yOC2jxEWFVDFabD3iGDT6QonU6wfaSRvLIk+rSIAE81sdfVBQOOK0njGxHBVvB9saXUuZZ65Df/kuGje4hfSW5aE1HHIw7RosY8szRxb4UfyrWY08upksaJEUHrb5dopNYMSCUgBhTeN2jDrUTk18lb4ardiLhojP73018SO4nSmprNcxosIx0BE6m7szPH0oigQ60Aj0+390DrtPUA7AGKG/3T7Ty4ovaYJW68qqApeChCf1sH26L0r3QYD1kMDB+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnTPNBvIUuHXMgZeyIFp2KhiPQO3oa0tA1ddv2JpAQY=;
 b=Ew7giflszIFnMcO0EdAjDMZKTDfrnw9csfwjsUEMo19dg+ErtPCPzoqdONJhGr5IXhYVaE4pzkaBjLM3gd9YizQw6k05MEC2hNcnIivg3KODpFSlnEq5d2YUwXa/S5X1rEo4pR7FxUzXi51+1c1EmSSMsXwLU6Qv6nMLGUz39c6mbAfcP2Jp5ZL5gMXLvNJpmV9tOr2WlF753nCWBz2ZUUdBZQYZZ9xh7/OIFUetrjk4mKlUDFjKG4oV9V1fQ13QQ93O2jA/EURwUD6Ze82ROuoLP0DFp3JHYQOZsX43x2QAaFYv5oFa9gEPA3ckwJ/qWt5KdpcBAESqWCueVJT1gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnTPNBvIUuHXMgZeyIFp2KhiPQO3oa0tA1ddv2JpAQY=;
 b=BbLJ9CB9Bkg64dSAkMuQS8ttu0L4XHTwVcHcfQC70rdzV2B5knsorypS72/OfR5W8AMtpxI1xBM3L2yI1+r9shxZ+WeMG/beTseSl/O5Ghz7feB6kUmfmoSd8j3tkuhaLs6HFOfknqUlzLi8GDG0beUGlETM80ORPECzok8bEkigHU/wp39X1goxotkF7W60Ju1FfAoaKee+DQjEnX3VoBztZNM1fDo8e4AGkI4OtOwAt+ThgWeEkcqNwPjGuH1aHLPslS1OuUJ3ycGp+m20jOoCZ12k5PT2N1ZxiwnR2nJyy51tFTj/dKmFlLjehL56HBxwbyPUmLVcQmh0uvq5QQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8619.eurprd04.prod.outlook.com (2603:10a6:20b:43a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:21:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9320.013; Wed, 19 Nov 2025
 15:21:10 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH] mx7ulp_evk: Stop disabling device tree relocation
Thread-Topic: [PATCH] mx7ulp_evk: Stop disabling device tree relocation
Thread-Index: AQHcWLXIeUdCBIleFEa9wbrfRucpVbT6HsgA
Date: Wed, 19 Nov 2025 15:21:10 +0000
Message-ID: <PAXPR04MB8459B67D1C10C00CF9E6ABA588D7A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251118180423.591332-1-trini@konsulko.com>
In-Reply-To: <20251118180423.591332-1-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM9PR04MB8619:EE_
x-ms-office365-filtering-correlation-id: a96be164-8119-4cad-2932-08de277f4542
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?oIZD50IQpVDSvwx65XadhgIeIPZghaJzzUyxUgB4JNTFulN81pPmjcdjLryS?=
 =?us-ascii?Q?nor5yJimxC68XQbeAujZ8dyv8SBOaLJ1GZttxukRSxi7+YfsiSs1nV1IHfe0?=
 =?us-ascii?Q?wGvg3xe3MXLWJk77c5bZQcVu7B1VkxY4eC6DtzaMmDzAT1BpfqwviHGLkxLK?=
 =?us-ascii?Q?aTw1MjXx5nwROK8q3yQ93reU2X81WZ66TFsNm+yksjI0/9+qGta3avOpzOCW?=
 =?us-ascii?Q?lNhVwCKgNYRMbUAAhsqWZnhU+WMLqJo4VO8tpbATXDTmOJH6Ja1VftYBAU8O?=
 =?us-ascii?Q?+VF0n6BqwBKeC+ZKTo3rwZN2ZPaOUezvbulxI8ABSX85K7/F4f0tufuvBDOP?=
 =?us-ascii?Q?eIgp3P8nyV7Xb0qxb2aeo7bN9KWw0MRTStdNT2xIr3qe/SE2Qp3AgKhNCRwp?=
 =?us-ascii?Q?rXo2HAdlY3CjYdZW3MMmti5JZI8EZb+CcWHllc9PHY6PgMa3PXloPbS69+Zx?=
 =?us-ascii?Q?6zW8brq/c/Q5fveX4jaV7mcGTOHazrMDJUgtO45UXOxoCRnmlHrs+AeXOyZD?=
 =?us-ascii?Q?7ZsJBkqIZ0I9shCerQ9GH9ioGqlphd3cK0qAsSp84sj0s/PBtw4kBhh7bKBP?=
 =?us-ascii?Q?eavohLv5TXZjft0EBWKMRsG2AKT1goF1OyyM3wF9SoYTazAD+2jTb9CoIcFs?=
 =?us-ascii?Q?JeS13RrA35QjjMvMvU3ACOqK5uoFdZy++br0/SNqPMwcqXIv/3vbpD+DMkul?=
 =?us-ascii?Q?fQl/+BM+bvcdtgO8FMKj5tpYv2Q4YSNZkk+g2W8mpyH4A4+zwRrpsFLSLRnc?=
 =?us-ascii?Q?lNRl/sMkzgFnd40bA7sX7PgnOblvmX/ZVGYyPEwVXcqrZddAACOrDqz3UR9U?=
 =?us-ascii?Q?Lred6rkiI0sv7B14I0exuLSlvUUwxeKvoQn3AfUK3VdOVQXcfsTn/w5nwGln?=
 =?us-ascii?Q?PgvIUXCYblH911GeCHXORkBRbGERj8ypyRVrLweTOJzn1qzMHPiRIriW+UZP?=
 =?us-ascii?Q?bg2kSrCuZuHVuAFzPfOk7vH5KqKXbyuhAeHMVTK6A8+u2OJ2SpRaoqwUZDHv?=
 =?us-ascii?Q?nrKa7ZN8OfeQZpINedg2lZEnRRvsndThRZNwEHz4MuZSjbps1lDt6FfEiA9R?=
 =?us-ascii?Q?t8X2wDC1mPPZhZ5ZbRs111uD3l/61uRR0iR4mGvU8F92HPMjT5ztKmInzUCJ?=
 =?us-ascii?Q?Zp3Qy+iRUug+WD8cjzVCX9twqwJknuI5YchkVgLdG6NF81w5y5eoEUzd+sgb?=
 =?us-ascii?Q?3CIBOornb/sEBzLmgq3HNuuzvYVOm5nv80jm0Cq0Gc7rOhqtLavSpWSMYQuw?=
 =?us-ascii?Q?+zba5pCqJCcCZY1C+D0JhRA/L3VgFqPWRqSxIpAtbek7WdI0Unr/hAF76cvv?=
 =?us-ascii?Q?DHWTfjy6FIt71C+QdxkxJUkocH4aAPUofBgX9ag82447B8NkpQEZupWdERro?=
 =?us-ascii?Q?nZzM6NYmvbaMmb0VSF+B+5+U3F2CcG2pBkf4DekPR/jKXOzwPRZYKwYl1t5S?=
 =?us-ascii?Q?QPyChV4YbippjoidA5ua13yjBDtfDoFeCKQtCR7q9AQ9naHyUjW+Rns3ZF1H?=
 =?us-ascii?Q?mh2Arim9H4JcoXZEgXFeEIZCWcctYSv2v6EQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T8aoFcJtMVw5e9w49WXhr1/Qr1ovCWjFIJenTdL2nBpScSUVTZP1aT0z8gZG?=
 =?us-ascii?Q?3VIHS6id0C6YFP8oNcQtviJBa0SmZVG7qwPK++nOzVRHHfJs8KQCH0byqpev?=
 =?us-ascii?Q?Bys3vmP9rXCFSYppgcCWuywDEAEeQwLlDX+76j8Z2Tgq43KEDOYHExaLuwLY?=
 =?us-ascii?Q?YPy931gSvJA0b0Bdl7Tboma/p1Hk5y06lctY40jxcEETif/Gh3QnCYXWUZcD?=
 =?us-ascii?Q?FiOIicOurML/nvu03iHu3FAe1kXJy8ubaN6wokYvNO5U/MoKXULf+20o0o8O?=
 =?us-ascii?Q?bczw3M1aPUvLqU1+jEhrO0WwK0H7FR/ppiotht/l3+0uMSoRR62S17x4Ey+3?=
 =?us-ascii?Q?QpnGq3hS7K7O29172FtSx2g5+7h8FNuxQ10gHjpDVArXoWK3L0rTTKvfltJu?=
 =?us-ascii?Q?/acqvhFFeB62FFN3MRYoEwWFabHx06etoypZgSktqr71U3hxmom+P2HIyWmZ?=
 =?us-ascii?Q?zhvDRzi17p3XunElOlxpHE5hGe4+QtslYd+9g2CYJMEvomtHNANOzk0oQVKu?=
 =?us-ascii?Q?efqed8UDAfiaREP7/k5Cy8FFDRt75CBInMjvtMyOAwhXFJKyhyDhv187nxlp?=
 =?us-ascii?Q?3RUSCLahvIWHA4l0Xq0g9KSlYrUrQi0APpa2KsE1K6zI7PKtkjIUPrJJDGTY?=
 =?us-ascii?Q?Lw9KTnaK7Qi5cSColUd57i77arnBRmyd0mEZxM/keg71evukXubhxRJOYASa?=
 =?us-ascii?Q?oRH+K6rw4uLsWQOyZHTblO3T3pUFNLb0jdTnLE6TpyJa8w1iNOCq+2tdXKdz?=
 =?us-ascii?Q?OJcT7hTtCVtbpgddnBIX3Bw2vLVX5VcIXGdMx7gWvBnxKLjJD/AGPNISSC62?=
 =?us-ascii?Q?92MvkuUI4RBa9rbIocC9WBghLkJSrjxmotDGqOMCuXgwVmHPZZvr7nPLVER2?=
 =?us-ascii?Q?r0Pz3lRZduskVC2qlPxxwrM/gEu7bhrPbsZG++L6sDQHqAx2FNuV0TmhZkiJ?=
 =?us-ascii?Q?gAuEQ0bHdZJ7noJEZHCgzD/D3fp6F1u+yZ73TWdGoYaQoOTSMLPo6vQoWj1t?=
 =?us-ascii?Q?xzIYBd6oUqpvjURHMtG3zFzHASgCi7ikhG7Jn5Jc4fUkM/BG4S42VKRPrFNX?=
 =?us-ascii?Q?OfAIkUiH7IemKDGkPaUI25eEON1GKdCvhZ6IKhMsT++bN47upN+xeScvD36B?=
 =?us-ascii?Q?Fh8H8fockSabvu5brF+Dq20Pw/8yMbWWfGldTQoVmRriUnRv5osJ076nWT7g?=
 =?us-ascii?Q?XljnFT07mvmJcW1Sz9+Nj8zNvK8ZZxR3ub1150ptM5EtTXVD6DIdxDLACirg?=
 =?us-ascii?Q?KCJIgFSAqU0x24AnTYjPXy+zMGbeuoBEy+ACF8uuDi2l9o9qroYmUyGykw7L?=
 =?us-ascii?Q?vRlVqFlLbId2d+1QoES6/c3A15wlvzf3WbIY3h2PwKdnGNYSd61Ic73k2ILs?=
 =?us-ascii?Q?kMP1kr7srSScW3BbgqK1+QxzPOoENTcwIHYaJipbDPohpG2Zb++BPZC/GRyk?=
 =?us-ascii?Q?M78yVmeLB3z3TVd7cWGAeWIjOwGeX2ZWpnRTjjuZbgGHiiCJPpQ97t0HxneW?=
 =?us-ascii?Q?8TSk0n5+Of/PukRCZU2xvjT06KRVb1zHg8LX9k6Fln2AYjUUe39m/oOwEoy7?=
 =?us-ascii?Q?evh+sjZVtuQQEIFWQT8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96be164-8119-4cad-2932-08de277f4542
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 15:21:10.8874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWAmnbf/LAo32X6CjGS9CfE/YL8x6p3AFmI8YnsabGYg5HpI1dyoORWXSj/loG68KKdPnFDuildaNURfWhxKGQ==
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

> Subject: [PATCH] mx7ulp_evk: Stop disabling device tree relocation
>=20
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from
> correcting problems such as having an unaligned device tree and leads
> to various failure modes in the OS.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
