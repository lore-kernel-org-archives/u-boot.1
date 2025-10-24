Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CC8CCD1AB
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 08:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D5B9835FE;
	Fri, 24 Oct 2025 10:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Y7H41Fff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 940DA83623; Fri, 24 Oct 2025 10:59:13 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 032478331F
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RINPLpjMwiHvKl++NlZ8uIeHg0KV/GmpUZWil02BWhxkA3FmQB8a6oTvpnp2+NOh36xQ/mMcU5FmnMbuNWX4iGZVIT5pNyneaTw9zX80qGc/TsZNLLuN+HMq+vJbG4fDPGjClCnjU3SG9o3OQfzGet6G0ubZUNHTeeJsMAao16S4dtIXOq5PXtqiLf+prcgPEgNqGR7qP/83NDt/xwxeLSoCQ4k/8ujb5j7zyVvsqMA8DzcO0Z0PBijb8Geug37G4K1z8qn0mjCaoWNn2zFj6RvywOjIGc5SEY2LEk0+fqoEPYaW0JRw9SY72v370DJr25z46plcVWvLCp1Q3UmWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnhcXgO95FZNY0dSijoOKS2qKrgrA67pcOxVpVcL+Q0=;
 b=PKURZmKiNpd2gd2mis+Stk6a3YLoQ0n62Mxq9gWrIQ7J19cXbavDtDoE+2fTCDouXkNjfAyULVeWUMpPW4OH4VUHX5cO3PMlOpLqyGc5EUJxBs8gyfKr88lpqVUxCMI279WW9dtlyYHfecD1tcm6DncVknysa/uijr2u+FKZYKZ9PpTLXcmDHH6JjI1FpVMR2yUPWw6u8GC8XznJgYhDZCCW6ByoA83q1p62V10Dg8iPiHlK1thE3Fg1WJjuqDSVBWbuUrdlQFjnf535Fgb9ES74ENifjMy1QbhH6XMn7zDuV1e7QTRbB5nt6Alpz99iMVlIn9UrZJ/hPh2o/WeoTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnhcXgO95FZNY0dSijoOKS2qKrgrA67pcOxVpVcL+Q0=;
 b=Y7H41FffszDREZQGOaGFFc5wrQxzdWdqublZTwxprBj1wHpLRRgBae79+mVpyC+wBT+417gs2vDBBBpEHh9jx6EVcqYJr8lY+oTm+qHHyREqz3Jdny1ApdyUx5VhTIdm/SfG9aoh4BuKv2IvLj4h6ZJ70UjECRMOm01m2yC1ciP+fZ1McpGxuGJ9KSzJWWRIKUV0HJqThg7QwD7OrPBzC1xjIXwEwFdTxALvpwZKru+hxyX6/EdUu2UqdCOWVbPkk0eHzSU8OxL1wowRYCOgjgiumrTArDDU5MnDpV0NnQTvs89/HuQgdAiRUOVKYl0khZ25M/Z6mXsqQEXRUIToTg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7806.eurprd04.prod.outlook.com (2603:10a6:102:c9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 08:59:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 08:59:09 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>, Tom Rini <trini@konsulko.com>
CC: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Casey Connolly <casey.connolly@linaro.org>, Tien Fong
 Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>, Patrick
 Rudolph <patrick.rudolph@9elements.com>
Subject: RE: [PATCH v1] arm: imx8: select ARCH_MISC_INIT if FSL_CAAM is enabled
Thread-Topic: [PATCH v1] arm: imx8: select ARCH_MISC_INIT if FSL_CAAM is
 enabled
Thread-Index: AQHcRKjGOQu6uDx0E0+V3bZ8OmpNVbTQ/3rA
Date: Fri, 24 Oct 2025 08:59:09 +0000
Message-ID: <PAXPR04MB8459F0A4241BCCCEAB1707A088F1A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251024054036.676912-1-ghidoliemanuele@gmail.com>
In-Reply-To: <20251024054036.676912-1-ghidoliemanuele@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA4PR04MB7806:EE_
x-ms-office365-filtering-correlation-id: 5ff55f2a-eece-4080-402c-08de12db9847
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?HEpBtLxswm+yA8Aw4MRF8T9MMRBToWHR8sZxmO3OElgZmA6KgBcb58csvUuD?=
 =?us-ascii?Q?Uez0gV9PbSROKLXPQjKq7AA/Ll/Vs0Hvkrs40Q6sFBek/pWIA5lLSydGEPRb?=
 =?us-ascii?Q?Jb+FZpod9GxeHpp6qSnVVK2qJZk2fCYwOcblEx0UI6QUvkKl5q7u7bVz2Skf?=
 =?us-ascii?Q?fRpDQn1pdDeXpZzVKSD/uZVAhDwtAhZ9i8aDBpdaib9diYZ9YJ/OrLgTrjBd?=
 =?us-ascii?Q?ad9QGldkNtVV5qxIFIPpqji/wPBUFjuJHFbKc4JWeTOS6HKli9EEQEeO+hTd?=
 =?us-ascii?Q?NMouDGgd7U1+vjkAZvg8KGnhN1gYpreOcM9AgX/xCHmyooAhkhWcrXooKDsu?=
 =?us-ascii?Q?8W/wXrggvl1Feuw81L1s0+SR5wPiAKXheGAp0u3VduC7xWVtfj13QmckndSg?=
 =?us-ascii?Q?0ksv63HwhzBSV+DpFOgSmV53ZgNSYwfSijahqH9jnjnVIoFs1BX+4Ix+UXu0?=
 =?us-ascii?Q?49fNerjwKTqY/xdSaLidSmWFzXZzDP8scGWFzdkJzU7JGQChbj2Li+Ejcuuw?=
 =?us-ascii?Q?p1Dxkw+6tkVPMU9/A3jN6VnMKpIsNMkn0C+3OL2M8kWp6QdDXjgDA+irng9Y?=
 =?us-ascii?Q?LEvdgR3iWGLH/evwmxRhCUGYoaOWPEk3pNX9s2NBRPmPvrvFoVZJ2ewhPbWV?=
 =?us-ascii?Q?jT7vKllFMHSSn7Fn5l71fZ/aouT1/avoI/3KyAF5zEF5NMJ1+O/SFyI8mqg4?=
 =?us-ascii?Q?wqia7eqhmZdXoiSqROFCd/VpZoesAaQ3yGnKi4+bYMJwfwev7COn5ueDXBwR?=
 =?us-ascii?Q?Hvq6F37CsLRMIJ2XMrjFOmxqsezaewoSuYa4e4rK0tuuAaSdi5yPjStqh3EI?=
 =?us-ascii?Q?8DlgerEpV4qLMRjKQlDDzHih7ZQQEHUEt89yGfSdTnp1kYEqfnfci8+tYYvL?=
 =?us-ascii?Q?pSxmKMj1s/78kLw2ettgSm1wztZpjbTaYmpFQGDWNTAmEoFpKJIAXxYSb4i0?=
 =?us-ascii?Q?BmoeWoWDPBReEW7qm8q2A3/u9qRfKthEIkSIdmTHqBNq5Gfk6JnmPlbm3VOQ?=
 =?us-ascii?Q?nqzhAG1O7gWBu7h5s/izbQ9LqJziErkjtp95BXwcrxSbV9TbBw90glsNxvK+?=
 =?us-ascii?Q?ou74gHtHAX7V4Vq+NCXRjLuxWv7qQPYqJZZXAIcOBYMl4PkJjkE7p3NBSOEp?=
 =?us-ascii?Q?gt8mUs+EW8ibYMcwO3DOHPiAi5kOZV4scqhXvvMCYKDlWnIbtE1XQjdcAxwq?=
 =?us-ascii?Q?qt54nYWJsagOmw562hEHCAeedW44Vyk7sAdsNR/I7A4g9NKkKm3Ad016whVJ?=
 =?us-ascii?Q?2LNjCM6ZeaoTGXA470DQu5Zf5ZoLbRbjai1DYXEKYnbBMOKaWWu3uFOiTVyf?=
 =?us-ascii?Q?JSfvHQXbVRN67fe+zVUMk8QDBd+s54YuIIdGBGpl7DtwTsZkzJo1bGgxlt17?=
 =?us-ascii?Q?9g5FYRerEiwGRWUTXIbc8JiVqZeOoLPTwmnDQwhcd6LuAmD5+hqABJFqmYrN?=
 =?us-ascii?Q?aM+nms8+JLBQ9hrbneGRTTOmwYNbz1J7wMbfZCgDQ0y4qmtgEkufgbeqJILj?=
 =?us-ascii?Q?gLrv+RTvewM3IoUky9yP+wfk1zeXpcksDR/X?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZztmYZspUTXOHBs/ubgsg4viWaTNKmzazT5k5Geq7okTHTWsX8+NTGXlD3pN?=
 =?us-ascii?Q?DFZop4PwAleOSRSuLg2ORCjHhl+wZFzl0gYqKe8o39a8hFooX+MCj4kM2UcP?=
 =?us-ascii?Q?jbg0ymp2xV3B65WkPvqSXv/EnlhejGvRwTonCPYW0qd7V1AlNosMvzACk5ur?=
 =?us-ascii?Q?BSaF4/vjXSlXgNxhu2nU+6QxnOugy88bKybBrJwMkg6u2N1LnhxcIIGUgyKN?=
 =?us-ascii?Q?JD4kbTWlaN/vT9sV+tmldvtjCvPOWDZrtbVSqlkDYCkkOZmSq84YArdxUT3H?=
 =?us-ascii?Q?Fs1RRUr1E7c3jYhvX94WVPz0a+6TTddlz/V69U8N526F5DD7l0dRR0WvSHdw?=
 =?us-ascii?Q?gEjxPY7g67Auu0PTGjd/utf2Z6LzCsnOnhnZkZgdRVkTy57lOCOQj9XkRhB0?=
 =?us-ascii?Q?XMXEyQd54s3I6/jqgnb/bIyZZcGKQfzs9sRJGFD0yNv+uWXYc2999dOnx9y/?=
 =?us-ascii?Q?p9ruMrJlYewP1QsRlyR99xosdv5v7KVydlWxCz2Yumr8lcEabUwh1Xgxe6N4?=
 =?us-ascii?Q?cmjWxnSYzFaENJ2bAsqGrf/8i1qRKzdS5BgEuKPIsegRVmvIf5QDABxI4rPH?=
 =?us-ascii?Q?4HPpMegeTixeA8jqC35kkmNgvsW3kXdGYA2dkRJwaUP3MdwthIbQEP8vNef9?=
 =?us-ascii?Q?pvfVFzONoK8hYTAtd2eB7XvXf5FT/Mas4fEC633fjx2Acg5Ybin0zOYApsAp?=
 =?us-ascii?Q?OzkvV8xzxJVl/4BLxYSOPcwQvbgyctj2bNvuHQpwfHGdbLg424DJN1Lo5bxV?=
 =?us-ascii?Q?ChdItfC4/+du5vd+9k7Gm3pcY+JanDc9FBzEjV8eWihGtbCmGT7OXs4j24/S?=
 =?us-ascii?Q?1I21WWp2FKDrpl/cm28x9N2kTizcrKZbod7r0zoWzmgD2Q0cxMkS5Ldp8TzP?=
 =?us-ascii?Q?t29hkxWoNnkJeINryacUt+k09IoqJ5f3OAi7h+3GH0/sTH19VNPKc91psPDS?=
 =?us-ascii?Q?YLFTIIj6axUBANIirktdXrIESUZa3YAk+z07stw0NNz1DSq1AILEgcoBOd8H?=
 =?us-ascii?Q?/JUZERycPAGU3zYQCNw7KcQmVWP+2jM1VHlaXmpkHyngHG6uyLcCNmAiuUZK?=
 =?us-ascii?Q?PCSQ4pgIkGdvGviyYvkcz5QSzYdsa+UALG5dtLsaXqnzNhcqjrnqXksbnXTc?=
 =?us-ascii?Q?gnnq/rqyrWck+9aeGQbQ6ByXpuQkkrcK5qW3p4pnmLgAj51feOzNlBtrUElq?=
 =?us-ascii?Q?LZCRblvLd9p8+b/Fg+X/mgmJaTVCzNArFVnPjCN1MtlLbJhJkrNvlXm9gCay?=
 =?us-ascii?Q?eqkS2NUtg79mJTtlFDGDNwQjDbiMETjqTx7TEBGkQENvcic/H5vBENYCmNi6?=
 =?us-ascii?Q?tEqiI3BM4jRb5p4xYtpA5X1jMk0HF8+uRcvDYeW9WEAt6XXe669pCkU8QfDU?=
 =?us-ascii?Q?E1teVqfe2HqAvbRN0eZttc264SCovWCXwSuZsDBN3FiqeK3HlqYwjad/ZK0P?=
 =?us-ascii?Q?+2B2x2hkyTf8KxYbYoQLr45h8P3/1OmwPlTKkEt0HgfRUdNbFk2ko88jrYbq?=
 =?us-ascii?Q?0qlNcnsrUr2xFgzl/xE8IL0HztZozPH++7YzQQUHULxqRGWBkFeVWadt7jIM?=
 =?us-ascii?Q?zNIf0k42rAsOXSK8mIE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff55f2a-eece-4080-402c-08de12db9847
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 08:59:09.4819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzzZUc8OCxEz4M7faKy2X0HzeuGDCtsBskvQHqy90QYPw3M/a8W13663M7MbRg4MwZHk0yTKduA5uYFDvKL7wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7806
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

> Subject: [PATCH v1] arm: imx8: select ARCH_MISC_INIT if FSL_CAAM is
> enabled
>=20
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>=20
> Commit 2a7acc865b9d ("configs: colibri-imx8x: enable RNG support
> for KASLR") enables FSL_CAAM which requires initialization in
> arch_misc_init().
> The ARCH_MISC_INIT configuration was added to the relevant
> defconfig.
>=20
> Commit d0ed9636902b ("global: Make ARCH_MISC_INIT a selected
> symbol") changed ARCH_MISC_INIT to require explicit selection by the
> developer.
> With this change the colibri-imx8x defconfig is no longer sufficient to
> enable ARCH_MISC_INIT when FSL_CAAM is selected.
>=20
> Add the necessary selection to automatically enable ARCH_MISC_INIT
> when FSL_CAAM is enabled on i.MX8 platforms.
>=20
> Fixes: d0ed9636902b ("global: Make ARCH_MISC_INIT a selected
> symbol")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
