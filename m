Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344DCC197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 23:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E3D081429;
	Fri, 28 Feb 2025 00:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="KJs7eAdY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82F8D8168B; Fri, 28 Feb 2025 00:40:49 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13DCB81426
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 00:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0SZIXrmX8yKKJGggR38qRVte0OaiQS7CsWsbaXDCVhNUEQqH+cRygDGQ8HYhpLfxTBx+EvOio+wN9O8HzBOsL2mF7WAzvl+xZVdJ41eNI7leoXcsO331XnrFfbL9fn5hC0YACxfbGpx6J4o2lKpro+PywvXOGTtay0XDql94GKUuFP+KhP8mKab2+kGJUTPudzj66TreKYLFFLmJtVuYI4ozBMUzACSkhdt0iL5+5Kt72TT9vV1LS3duceIEGLk93pEmwV3hsFND5qW8nEYgtxwf4XWDGA6G48hQUtZ44o6JcBTytXB4h5BLJUkr81hQL0zV8JtQ8L+vzJCxZmedQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+n2McyPpj4SdNE8kutCfqZJCkvFqS2adzD9SdELI4E=;
 b=HIcKSpAgd4S4ktYrE54MobDBuddFqbDHGD8vxfDJ/PQG21OyAH/3DnpUzCUqwEYJjdYuHtoFiwOf2jPGn8c1z8sZrXnto6Es8A4bOS1u347swY489TA8kdf+hahwl6y46Hvr6P4Q8Xi+GfeIC5/dmIjjiHg70dDIXWXpHgljG8hgk0ByEajTRW4m6YtgAla0iSCuuZ40tUtpD4JzT/Gkjjsg85YgSw2dsFGuDhTClCp9KiLKRdyZZ3uQ1w0kIxUm+tk/nwSe74Ple9K1p4qME56GCZtKZjT+hERdKu15MfqmeT8UAv6ft86Ko7fbUDFM+NkTPy2ejEuKECOgatuUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+n2McyPpj4SdNE8kutCfqZJCkvFqS2adzD9SdELI4E=;
 b=KJs7eAdYhDgY/Ry2wdUthnHy8M0HXNWbdwC/AF0E2HiCxeaBn0mcdJWDfO57PFR3h00FxSllOAM+X4sgjaMhcjJBajBDXQfVz7UspdvFBLRbe/mi5OMOowMwa0Acx5h4f7a3wb5OnYcwY8iVn4oOu0GUX0PW7hTd5btPf+4lFfINW6CcyAplpG1U8ePU2WhFFOpz/Y8z3Pb69dU8OtKMMFhhUuaT7TihgwAzblP5ab6fHcoocVF475yHNF+RCbtsFUQl7992fNcc9l25iQ5Bn+YGMH6NWcZGPzdcrP6VHdoUjJkHDv1eMhlRNHRgROb8A7pYV2QyIOs4YX9uv9AI5w==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10574.eurprd04.prod.outlook.com (2603:10a6:10:581::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Thu, 27 Feb
 2025 23:40:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Thu, 27 Feb 2025
 23:40:45 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Ye Li <ye.li@nxp.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Fabio Estevam
 <festevam@denx.de>
Subject: RE: [PATCH] imx9: container.cfg: Guard tee.bin inclusion
Thread-Topic: [PATCH] imx9: container.cfg: Guard tee.bin inclusion
Thread-Index: AQHbiTe4ODF+Ld7EPkeZMv/CdB0w+bNbz4LA
Date: Thu, 27 Feb 2025 23:40:45 +0000
Message-ID: <PAXPR04MB8459A76D103B3677DD3F645F88CD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250227165001.252176-1-festevam@gmail.com>
In-Reply-To: <20250227165001.252176-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU4PR04MB10574:EE_
x-ms-office365-filtering-correlation-id: b3524375-d23f-40ef-f70f-08dd578827c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?B35tSz8bU/dhDAsOeIPCRKiSPKP8oiK7JVnS9ut2I2033yfvVAyrpw1oP5XK?=
 =?us-ascii?Q?i8QAnK+6L802SoY3FoSTDHzrOcYO19YPG4twDZsiJVSKYZisQkGE5kWxideK?=
 =?us-ascii?Q?jHzFfNRg2yrgkempIb/uKovvt3qr/za/YIeyocHRSI+CeR0Dc/Rz/tmgvPwN?=
 =?us-ascii?Q?g6v7CjbX/THx8l4tBwg83YnXNeLPPg4rUVLj/Ig9ifW+b4n7ne2c2ptscCZU?=
 =?us-ascii?Q?1H337zqAi4g+H2+MHfHwo8fdTAtRGEWGQc/7z0rOC2Ik8/cBXPwaQuLycou+?=
 =?us-ascii?Q?mZ2NjgVpK8kPCWoFY3C9XL8WkorJnAXWN3MziH9vr0wnQ2vEsNCHjj/KLAnK?=
 =?us-ascii?Q?DDqT4bMd80qAiCK75Mywp2pF6kQfoJZyuKDBiZoBln/psZJS2PfJEuroK58q?=
 =?us-ascii?Q?ubelQVdpelr6cUi1b1gEpuYLttdfYObWLFcHs8qHEYzZ08fWyk+3cB2Mhgzk?=
 =?us-ascii?Q?w4IN2XgFqyyLVIW5PwciN2V7Dv2EvWKmMTbQJ20ug5zxeOWNTx6ph+QW0Uun?=
 =?us-ascii?Q?iOtppE2vtAejgLiTTvBsoVPj6uFfce38nQEmdDu3IVjQzb7nlOKaXe2it5ft?=
 =?us-ascii?Q?ujVOxsvAdNpfRyMQyIwyw13JkRxEpbL1QEwmrnmgTq+64en3bahT4xkC1Tzz?=
 =?us-ascii?Q?/tSX4NA4wsHOhprQsnMsIcmr1ucc57VeYLTqJaMduIXmwysQdBzp6HDuHGpA?=
 =?us-ascii?Q?kx4N5jaHC5EWHeNPWgWzVfGI3MwpR+qCqL/5nmD8RlqzWoDoHk9I4GyDjorG?=
 =?us-ascii?Q?hgzfiZWxMAQZdm6wwBtsS8bUWO1K/d7tXToPpqGAZ7sPA3P5TpMOaZilIBoi?=
 =?us-ascii?Q?uBVy2G9Yk8+Oo5HuPCdkfKkiHrNIbg3C/XjZCkuPXyc+CE/g7E45d6WJmKNs?=
 =?us-ascii?Q?JFmtD4ObsGgM9oeo7kWHVe8WrUu4UkLbZzqI4Ec5TNY7dwYwyzNlCuuZLznf?=
 =?us-ascii?Q?2kpku5ZjaESE3MWaga1v6FBLtCv+NR47LjPN9UPlNkEflQMyIFeFsKhmEpGT?=
 =?us-ascii?Q?U6LO/OzuMyNcwisL+Xpa6XQUIRhUuRzi5xIiYWyJgNmLC9+1ffWnJR/yeDHU?=
 =?us-ascii?Q?Volpi/4k5G2bi5FC7Ry2oSne6ZLFBOmrCB6qOVjCSTJMSihd79IXgZAEzHOt?=
 =?us-ascii?Q?1zcLGQ+YTU0TDS2Q5VXq/EVmNrS5/+ou+AW6/EU/gABZAIs6rnKcj4GpRzx+?=
 =?us-ascii?Q?pQEGlM/oc8NYskDlzwah25w+hpc2Er0JAISzI8gpHwVvq9tzHImndm5UGYUo?=
 =?us-ascii?Q?9lxqNakKzdk3BPpQB2x5jFPk0N8Bat+5/EZ0s2R2iKmm3NXzuQC/OhRsq4Kj?=
 =?us-ascii?Q?7CEjqTR8pYMWE2tnDiecDS/bO8BgyhZLNsDs1r/ZDme6ij4a3WNaY/2AFSkI?=
 =?us-ascii?Q?otrFCV8A6k3Csi4CqC1r99itP6a8C+OrTx5uri9X4YJeEds0Nk/yeih3bDWT?=
 =?us-ascii?Q?3WH3ocP1u0RAcGri8jt/kayWnAYwNkWB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z7MtJwR7zaU1CTDUnOREnQVgAdNawq7X1ZkPttjBm3c17hm/4wbOsONHlynp?=
 =?us-ascii?Q?AK+QBcklGCY68m/6eg/7xv+Jx3PK612P5A7UzfkA9eqVig9OuqOniNw5fZDX?=
 =?us-ascii?Q?229vBui/uAOuoZ5qa8z78GhpIfMVVQkxJ/VKoxpY6wfpQOqEHSdVfEi5LUqc?=
 =?us-ascii?Q?FKnWs+lq0IcgNS9PryoFBGHJg1DFsYP+MY+MMg8ap1S+ROUhSd6mIy2MzZ63?=
 =?us-ascii?Q?RGnssKOzs/NUnp8BGu5oeeQ0M6UB84+/8Qe2YFAyw7AeqjaUQYMZ9jI/f7bG?=
 =?us-ascii?Q?0Y8H7RgDI6kOosnCL0IyNo5M7EojmsABp3VUziZ/1WEsmq4EzRqLfGA8Wkrb?=
 =?us-ascii?Q?bhegVHregs196QHS7AhXd0w/kI/w22by0anV8YR67wJkXq3PpTOOjdwvFAed?=
 =?us-ascii?Q?9XfBXN55MIyyPCNy37uihgbzS1GXmM+X1KXx5luMgJs0TxIfLQbw4X+VAU69?=
 =?us-ascii?Q?rFRhdqmBvG5/kivoPNKnis7IBFBfhVPcRhUIwfEoPFoa7dbbOduu3Q1lw1D5?=
 =?us-ascii?Q?JdJ3lFDQ64b2XC8kTKEIADjbR8RapFn9uHp/3roaZuPYWSRkxgRowL51Utyt?=
 =?us-ascii?Q?XJieuqFrxk/YowYs28mdI/wEQW2poGuWgx0a4+atHXnYtd0UH2c6f0SqnzpR?=
 =?us-ascii?Q?lJ9SVNnTzoId6dW18xcWDkaEef9pP8e1i6/7AGJoy5owbuoqIZa+xZR7WqVn?=
 =?us-ascii?Q?xBIm5N1ic9Lf5vvca1ou0q6U+Fr1iOU1sUX2RguPYb2FuapVbbx6r+GMDAyj?=
 =?us-ascii?Q?gm7zbgNtZ9o8tFIpjdlkEPw5a4JHSvWKVQi2xUBYRH2CYZzG9uXSNO09Czio?=
 =?us-ascii?Q?xdPugjqSvKWmqkgpw4E9Xjbu3HB/VHV3kJ72mQWpXnNmv1y6+8/Z13kRledR?=
 =?us-ascii?Q?IP5QJpQeDWVLyYuLhU3WHAZVcLoR3wtMxcZNQ/j/jkK/RRBP03XNlkgLGMk4?=
 =?us-ascii?Q?RZE+1rpUtmNdONpYk2ieKgkStFxXeprntDt4xLfZQ2twHnQ2mTNuo2BsIPMb?=
 =?us-ascii?Q?QbucIkBxMzM9nVGiN/yfVwbCHzZ0wZdGTh2+EcFk8TVTQ3iHZguDuVWbCnb+?=
 =?us-ascii?Q?3Bh7tTxyyEce1pz8yoXViTkZUvenOm+rid1YYzGjIBcBcYy3/nXVHMdvj/XD?=
 =?us-ascii?Q?mgdghDvWcE67NP0ojevFE3kG6ZBNPlaHuwyPST7duOoj/Pffp8JnE5dMQNYE?=
 =?us-ascii?Q?q/TmCdIRttkmdK8XaL2jhzHrsLReei8+f2UhyUADmrhdD+9Fgiz0WddfE0XC?=
 =?us-ascii?Q?1er0vh8O/WvNHWSMLrBiSbVf2G+9ZH9X+fFi/+RK3wf24BRphDqsCVXZNsfN?=
 =?us-ascii?Q?arAWxm+gkVrPKPvfvnecotgYl5/lyIVGDWBHqEovVot8Vqf1YPaGc1UsfCSD?=
 =?us-ascii?Q?YID0saw/kqkveio1zmQD/tmJpuX52GY79Ra2cZetjSypNLQbTGJUSRpolbwM?=
 =?us-ascii?Q?aAlB2PVSFqQJBll6EV3pT3a/UOZ6b4Dt2IPtDhWPmNUU/3OZp9+VZzWCI0UC?=
 =?us-ascii?Q?fQo6fvbcWeyB+vhqxoauApzd2ehlWf4WNOEWe3vJuFq3G6bMa2qkwAhlEm8d?=
 =?us-ascii?Q?CI0nrvo46JvXvGivQWs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3524375-d23f-40ef-f70f-08dd578827c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 23:40:45.0893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A4qhnn9a6Ug+jA2zZ2ggwKoTCSAE8QDpLtfOgGMvnLsriYI9sLiiFs1Yl/y1BRqyQwsKmYJ3BQshBYf3PCfXfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10574
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

> Subject: [PATCH] imx9: container.cfg: Guard tee.bin inclusion
>=20
> From: Fabio Estevam <festevam@denx.de>
>=20
> Guard the inclusion of tee.bin with the CONFIG_OPTEE symbol to fix
> the following build warning:
>=20
>   CHECK    u-boot-container.cfgout
> WARNING './tee.bin' not found, resulting binary may be not-functional
>   BINMAN  .binman_stamp
>   OFCHK   .config
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
