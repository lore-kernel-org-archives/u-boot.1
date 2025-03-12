Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF58BC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 15:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C8E6800B6;
	Wed, 12 Mar 2025 16:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="C6f3slY9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B622801BE; Wed, 12 Mar 2025 16:53:45 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 722578003E
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 16:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ruj9MjaGc8/Tm5sFWcNQj4VI5ThI39yAwvuMQM0ZK6OytnPSbhDEb9OEnYHlwJH81T+kSmRKXBFWs65O2BHG7iXRwR6naHUvOXgKNKKt69hImwjXLbY/JGfmVkAb4WkV84h8KFTBfv470xvKNzpmWEg68IFktA0CAHOt7p5ohI8pyJ8zQSnBzDSasXXQ5yc/f+M1rPkVWBLVR4llHL+EEsWVQ39AGytft2g+9T8QUtVQxQ8GE7agfOqyVh2LVlEel9sRp9bYemc1yzWB/q/aSeDZVas68RDyMyHo0l3+fcNTu5wmNHl9MQ9UpdWOEDQcvfkP6jmQDANSLD8JVtO1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqsjbUjZgIdTOGHEiNRzfyumsz1n7TSZdkZgYW/jvjg=;
 b=dyvvKvLC4g5xEQ0A9OnMlQDgeMIAbMz0WjHng/XdDZi+dKMSDr1QwIQ6462L4Rh7WLy3eVw7Y70PNO1odabkWlC90DRG67MYCAwmJ7oFjveGSrsAhqZG73thm1tZJaX7c5IneluA3o2TA5buEMYuvwiE7M+1YAjY0gQjaVl1KjRcfe8jnvJnTkXQxahob7DXBSMQuRHvOhcqa/yX8t8ZFqLE3qzaYjQv9ZKPEjICPuHCNQ9DxVFFsTkvmG9Ne5HFNUOX08Ed6lfGrdFfitwRqe67IOm+OR962lbWxdJxXmXTSzk2TbPEl8jwAP0vJulxihU/bbiGesuNMpueHF0eXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqsjbUjZgIdTOGHEiNRzfyumsz1n7TSZdkZgYW/jvjg=;
 b=C6f3slY9p9YqoFZI+zqImL5Jh3xXMRyN6ih3m4injHaReTKqq4zzUm+1ctAmsQBM6Gtyo9NbfU/yjYa2QCUghpZzbl2HkDv9wgxRN0c3fTWTsRzc1V4J0bQbgq70lwUzP0ObeEoCLFgPkc82p8AFXxgM34iLc0Zp0FLNqCiirutkSdnjbDYAyvPC0ag6uEDaxqMXZt3+rOAC9Bo6e/RsW+X0+0fvK7w0U910lc0lYIFIbCmiD1etOt84QLzIeW0J46LvPdfF65l5wQB5ePuRRpjw7SQ8dKquSqVXdrwQ9hkr8fYEcT6cmSG8FD622eHz00eRpJTiVwBfMgP1Vx8W3w==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9247.eurprd04.prod.outlook.com (2603:10a6:102:2a2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 15:53:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:53:41 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Ye Li <ye.li@nxp.com>, "festevam@denx.de" <festevam@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: dl-uboot-imx <uboot-imx@nxp.com>, "Ye Li (OSS)" <ye.li@oss.nxp.com>
Subject: RE: [PATCH] imx93_evk: Fix wrong VDDQ voltage setting for LPDDR4x
Thread-Topic: [PATCH] imx93_evk: Fix wrong VDDQ voltage setting for LPDDR4x
Thread-Index: AQHbky3HIZs40QXRDUy/AWciCG+kwrNvp0TQ
Date: Wed, 12 Mar 2025 15:53:41 +0000
Message-ID: <PAXPR04MB8459592733197D128CEDD54288D02@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <1741770247-123217-1-git-send-email-ye.li@nxp.com>
In-Reply-To: <1741770247-123217-1-git-send-email-ye.li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA4PR04MB9247:EE_
x-ms-office365-filtering-correlation-id: 88c221f1-ec9d-4309-ebf6-08dd617e0fce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KhM+HpdJ0HL/9bAtL2UT/Ad3WTMYQ2FtJ5aATSA+rh/dHde06E4vi9Ausx+Y?=
 =?us-ascii?Q?/AFK4z6qO8JXbIsBRPmSUtHrH/6tkj4aDLWMi16V2hDsxl3K3uxLdSDCAYjS?=
 =?us-ascii?Q?CobfsYfF5R1AGrZ6ztFdmAyxb+SwWDx+cWMebw1ACkaQox+zktD/px1a8E/R?=
 =?us-ascii?Q?YJS4hNGvCG65CGqmhJjZaOm8ot8xromAD5GWDkQo1kMdfPBPHLNQHEypenDZ?=
 =?us-ascii?Q?+MABt7rM5zyXi+kKV5opxND/EafG78RRVhrd0BYSDfl59cFCpcLaYLGd64QJ?=
 =?us-ascii?Q?tGtdlkHoDLF0VWPeFcEsutfG7QtoTastzwQU7kG1mOdEzB0I48eFnQ4HEs+b?=
 =?us-ascii?Q?YJ3vOuEcSCZG9haZGQM+sMY3HNNIIt+EEWd3lfQsfFpxKra3u0E2XD9xO3VY?=
 =?us-ascii?Q?jbWa6CuSBkZNCatQbTho9FOh4UXUBuYgYUOWiR/CokHbxT+S0Bx19pNLfhai?=
 =?us-ascii?Q?+4E9pNP8S7m3v0RcutVmfcSQGIkw25rf+AExgdpJQYWAzqB+jwYrq/cgBmeY?=
 =?us-ascii?Q?wbm046Tg9MNVx4i9F8pJdK2ijhS+bttfbNKEoygqBfHZ+WUWH7iZXY8s438f?=
 =?us-ascii?Q?sZZFsvMT+Q7Lrs5olkGaULtnVGQaQA0Szi4s1aYvWzseoJEPVcHj5a9Y2gna?=
 =?us-ascii?Q?I3RR8JM3xh21ax51icDE/sa4U2P+03K0OPw82xi/zR1pJQANgX/suhUOJ+SD?=
 =?us-ascii?Q?GCY/Q10al0d9wWQ3pNSJFzNmpIwuLIkW4HlvSVqDeM7Tc96GWFrZSrWn38Ra?=
 =?us-ascii?Q?k6aRFWkfu3Qy8BENlZaZVEFBGqYkBKV5ECXyIJ5Pof0r12qRQREpNbEtkDoH?=
 =?us-ascii?Q?PIeCw1uVw8jQMKYxXDUVhOkmcJKgA6P0KxU4pRY48JSG9tZw2QSxGLPbhWSa?=
 =?us-ascii?Q?uDYbRb3bMyJ2cEtrQdhSzBUX4nzr7mqVpEr+Mlv5NDV70inMJdWAtUpwQlOk?=
 =?us-ascii?Q?F8CiKNk8F1qXwlYMu5fnJ10YZKYqgZM8vyqm9mFwkw7I2BN+2VA3YDeG3Z+h?=
 =?us-ascii?Q?2BLXKtOVAbZ4O4bx9wsAvGhaGa4O75ynqRiwEDEt77WmCDsQLJcywfEvG7o3?=
 =?us-ascii?Q?gbPGhsA9zQyK58yM3U3+8azCV1EeOTaWf+h2+Unbc7S0557BOM6PJ6uiNvd2?=
 =?us-ascii?Q?dyOj50U1Ni5q0FE/hKAka3Scs1TlfJQ8VnmZmmOqvcrBzQpNd3Poe43gfAic?=
 =?us-ascii?Q?3Dy3GZ4l4FfWJ4k/R7lYnXuyoHwavtWCelI2dsnG3ykuMfbdmPA523TOtNGa?=
 =?us-ascii?Q?qCWF1VoIV39XDu7Ns4sjIDJJYAH9nEFKMmpw4480QR+oVXGo6EHeMdu4CQGh?=
 =?us-ascii?Q?iQe+i7jsb4AaCR1wqhIZEhb1NuDPWeho0MvaM0CiALb/29m4G+6He7lkChbZ?=
 =?us-ascii?Q?G3NMjIsQ3nRDRErCwqqj92VIEVSkjEUWZgWbpFHeWaNhFV7Gwg1nZNTBccUd?=
 =?us-ascii?Q?wWrCwg5hzr92rcPAsbw80J9+WaJGiP/x?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XHYyugCQwEJ9W95KuQny6PWdnObPt+BvN3BxkSYPNXcZcyhvXHzRTcbGzy77?=
 =?us-ascii?Q?9qk6erlfWnO7u4J5vB1elDLHxHzIEyPgK0mNJiTtRjV2ncnDMcW6K/Go/6Bp?=
 =?us-ascii?Q?Oqgk8NgaptQc0qnzMpiIkidckJksQH1Uv5Hvd4n2w/00N/ZiyQG9qxdtdY2G?=
 =?us-ascii?Q?clIbfSi1W8YWohP7NwpTSNT6yMAhPUF3SnjWX7jeDSiEtnAeg1lgRl4/RFfR?=
 =?us-ascii?Q?cDK5QiIV2ddJY+GzJ2EPl6w8b1wwrGWCfJVIMWB3pnMktPNArgn/73mstSQK?=
 =?us-ascii?Q?6CI1STtHPndN07mtUQlWhIn6rOcurbTHZcGBldMM87tnQESJZt7eayl+nSue?=
 =?us-ascii?Q?ufKha+jNa4sJZIgG7aYkOv7iMqlcehEunTdHq4iTJl0aH52SKU8FjMBOc48U?=
 =?us-ascii?Q?t0jSfIo368r2nuUzxVLhZb2ALXdQjJJ1+dtMMcsfCTE6jeNzBic+Sx5mFIZI?=
 =?us-ascii?Q?b5lv/6rjEyewjB/w/hiGEjONsnMOTjzb4+LWYrxMX6eDg6jLTB3kUkkkK9I0?=
 =?us-ascii?Q?6g1X8V9O/LhF0dvvrruliVtveMv8ghjuIpfpFGwKvVRgWIPPZqPvz2TNe9nM?=
 =?us-ascii?Q?rDh9jSd78vItnWy6H2todYmvh91Fjh9jtDuJgi1+Vt9dO699WsvZDTPUxFhM?=
 =?us-ascii?Q?oH3XYYa8G1NBvUidQfKXUeGTrPhPtoNL4IcDBQApBFRSaSoyB55F/yFXn2lJ?=
 =?us-ascii?Q?TN4yCLu5OLIYELY4cRisHHSBeKTkQtw23DMR116VUpAff1edduOIhmTF4/bD?=
 =?us-ascii?Q?0ONEIUlOfSo2ttR4yr+APE4YWlDhSuEpo9nmFO4udR06vPR1BhYBiVHK0XKh?=
 =?us-ascii?Q?OjrG3vHGQfnC6TmiPeqi84NZ3p3WmpNuyoPJb3HbqTT9uNfKPtzLarzzQQbc?=
 =?us-ascii?Q?WqrtIWyumZbjiN41AuxZt9Eeu3M0KvTUUAzQYRfv/m7LkpJD/4u9hAhj8Aku?=
 =?us-ascii?Q?ofRc4VlUgW+Ga2HZTI1+3HK5c1ddkBngiiEQaCfwxD1AlERbOi6FjxYIouGl?=
 =?us-ascii?Q?NHyg62ZXtm/hHHsoCGyOsZydl8hyCn/sXTqj/8PLVX5TBjPcKjVj4XXjXp8y?=
 =?us-ascii?Q?kqRtWNGu3+Y+85nItFT6837dyLaMQvRfXkt8ltMIRmZmDYy+gIqF2BsYSV0N?=
 =?us-ascii?Q?iKZG9ZFBRTJ2k2AllVDXS3S1hWCiJSejprDfjBVpO/LyKhbVfwubb5aTJOz8?=
 =?us-ascii?Q?fm09JEVRiBM85CJbACWV0Bg9EfwO3T9xKTm0eGoGKFoK6ST/5OXdZ2e0D7N0?=
 =?us-ascii?Q?T9eig6ioNKk7hovXf2r8B0atOIB0XlVtJEv9SDWLiJget27p/is+QcQ2IWWe?=
 =?us-ascii?Q?ktxIvnCRgEHA9DG/e8VTdinjkAxB/TMsTUDVTtsxZocoa9HPBoN/R4F6C3g/?=
 =?us-ascii?Q?GmFl7odLXXOjJRiysJVG0KUR8qGH8At1nnv3RDilupj4Lvcx1rTie5rFSXfB?=
 =?us-ascii?Q?GRkZJg67IS7UQLjfmWyzizsImEQPTjpZ/uTwvSCBscNgZQONz6eD1iwFyC3X?=
 =?us-ascii?Q?Ru6rJ4cyiXKyFU6kwEXepFI4aiLKKjrouzkiC/glpkY5uTPOJYM6filtswRQ?=
 =?us-ascii?Q?tAiuumUFQC3co33Vewk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c221f1-ec9d-4309-ebf6-08dd617e0fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 15:53:41.5217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6zvca4y+IMyakY2LZSQxQHB7NK3uflOkaLOfje8zqFHwewn3pmOXQN+ckotrsCmZlGmN7ynjk3yl+xdDn5+Ewg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9247
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

> Subject: [PATCH] imx93_evk: Fix wrong VDDQ voltage setting for
> LPDDR4x
>=20
> The default PCA9451 BUCK2 volt is 0.6v for LPDDR4x VDDQ. The codes
> are actually used for reworking to LPDDR4 which needs VDDQ at 1.1v.
> So remove it to avoid LPDDR4x issue.
>=20
> Signed-off-by: Ye Li <ye.li@nxp.com>
> ---

Acked-by: Peng Fan <peng.fan@nxp.com>
