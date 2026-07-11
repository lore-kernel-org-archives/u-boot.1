Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE36C44501
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 03:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D857E848A1;
	Sat, 11 Jul 2026 05:54:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vEWF1ClB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D0138497A; Sat, 11 Jul 2026 05:54:04 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DD698341A
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 05:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrkmrBwsL4LqiYMDyoD9f6QGOk9QWA3bOkvhEm1F+MGOPpTZs9h0cMZEn5QCUWqA+URiXnfWBwYa8WXY3T9THU9UHRwzCL69umE/Tf2ThNi5k1XyghdZ9rJ6tmGiip9/HcA+PCqgjfip3xHoD6rF2IosbJ8skuNFvc82pM10XrjKHGX/EWtHRUWlVdAqGq+BGgoBoqvtFos7bPIvlDpkjmxXyUwFiKahd3/ojSbQxSU27pRiIsZa0kRCz308tBM10GqfMK0EgD07E4Qw/r1xqfW8EoLxsuZffSyk1NU1RYkpbn0c2le9Iyt7AH0227zpajv8+1Xh1gzIdfrwjp/tgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y40dEmQKISjcnBRNZj5gM3z6HmTy6sPoPANipUEqq+g=;
 b=dQg/fnJn1/GN98hV3JHGaxvw7TraGrniL+DpNY5x58HeYc5rQ/XcEb/CArTHM/scOsd0aRRKAXSQ9lVmi9ynh9Ci6WNHShUb9Us+3EkLAqkYuUXBqwnu79RX2SpXSkOVOhi348hLuaskgNCO/sFUTjRqsy7xznI3zL/V+aKHpIqJM3NwuedOr92gU3el3Y+X+lt3gERdvDfZuWjDbE12CI4UfLixTWD6pZoZzRpZr7CY686JJepXAmHV+CQeiORM5jq9/krc1NhExm8G6eciLy41GIWDYTzmntxkRbWGyy4h72Lwvi6LzFZMbKwjwNEXFs3CJTsfy+uX6HOplgvn8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y40dEmQKISjcnBRNZj5gM3z6HmTy6sPoPANipUEqq+g=;
 b=vEWF1ClBSlX7Fk9PiOgWsk8CFqsPMRJsBf3Df8NEE++uy6XPqeSh1IRpJ+V+QZtQ5Ga25Hrm4GsIABZBkCqUKExjdSudCgSuK8DX3P7aUkAcGML8e9VNZcwfOMZ9LXqqM0XJescx7+RsQSVa9ODWOOkLuYdSItv1cv1H6nhQKjIFVYVkYq5zEUcf5E6Z10GA1qOaKhRvNVhASTHQCDq+e3yOFGAgopiL0rM5ThvWH8O7DMMDLDMphxOndUIDxoQJ7ep2nF9q+I/TLbhq+oEIETMPj3kyZFtw7hbwXntayNxQ1t1mUk1KJRZi8EzNlaMDXYPGJtaZA+fwdnZOBcEPRA==
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB12351.eurprd04.prod.outlook.com (2603:10a6:800:323::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Sat, 11 Jul
 2026 03:53:56 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0181.016; Sat, 11 Jul 2026
 03:53:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: dl-uboot-imx <uboot-imx@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] arm64: imx: Handle both MMC2 and SD2 boot devices on Data
 Modul i.MX8M Mini eDM SBC
Thread-Topic: [PATCH] arm64: imx: Handle both MMC2 and SD2 boot devices on
 Data Modul i.MX8M Mini eDM SBC
Thread-Index: AQHdEL0ZqWDwfDPnIk2bQeCgJQZ4vLZnsDKQ
Date: Sat, 11 Jul 2026 03:53:55 +0000
Message-ID: <MRWPR04MB12330A2F821705FAD6CA375B588FC2@MRWPR04MB12330.eurprd04.prod.outlook.com>
References: <20260710224018.566152-1-marex@nabladev.com>
In-Reply-To: <20260710224018.566152-1-marex@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR04MB12330:EE_|VI0PR04MB12351:EE_
x-ms-office365-filtering-correlation-id: 1bdf1d1b-d124-4e12-c2e3-08dedf0007f9
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|366016|23010399003|18002099003|11063799006|56012099006|22082099003|38070700021;
x-microsoft-antispam-message-info: rUJFqgdo82SZZbTDruA8NDq3UKHAqJtKFZ5mBL6bppMB3z29gX+zKAg+DE1OLWNZZcNCPxZ6elzwTHVTGB/zSy31ftbiN4n+J3eLnkliy7l5pmIESQHzC5qzAx9lbLNynEiJSWiOZBa+gKA5Ua8/kRoMQTvnqtnY7nDqgvbZvrPANleXBPUt//V6eun30ELWh67z74VLQb466V1CRUF6DZKgzxMa2smxrqJ37Bde6EmpzZX+RECTGJG4kk2oihvF2ZXJYZR/5+LIXnekWmf5Y79PLa5tgHdIaJzE+g7gaUDGCArF5ceXzF2zI2sjV69TQxUT6EaNbBbE2qPMoXkuoYlTGgHeaEE5a9rNMzAF4GRobYCz9cpROUG+qKfdTy/sfkxJGnlx8gOt9ljNU7zgNi48DZDYo1rc9piNezCWpeLt21hv4Kkk7QIq/H+i7p1M4E3QdMs6+FXvjdAoRFCilSxsGHgZxH00miX9N0vgMYx/3h2x/AsFdBqtRmvTwdb93tjoMGbPtJEL32HQ+iAelOEjp8CfJTaXNvURo4ifiwxK5JTPX6s8c2G10M5kFXCROFFmHs5o69rXdaAC11UCj5ZWbF8dHxDHbOJFJOY3Oof9Jes/A58m9ufzmZ5vtv9YGAW5W9wBHlaR3bqbnbrsiRtlX22HLR2bE9GOiY1qTZQ0z1x+KDd/INIBugUVsFvybTF6GAaYzstFdVQ18bfucxpgDsxxHH1zKVRz2V0bxKc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(23010399003)(18002099003)(11063799006)(56012099006)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CjyL3RqoY9V/hGbfhGa9qcMT4AkEt+O0F+/iU+Qti/yId6no6CZjRs7/tT3N?=
 =?us-ascii?Q?wIxktxiZPnKNp2qFmdFLAcUGLQWCEWtfo+vpmJK7K25wjWUW35WtymzRf2oV?=
 =?us-ascii?Q?oQ85qZ8cgVrue9LRin+d7T2jomI/KL33jbH+UQ1OBta/nWv9Tu7qw516b96s?=
 =?us-ascii?Q?NEVlmJnCjjOkIzsmGYb7GKFN8fzAqpvPZi4ESVyBqDNDY+yko9gpVX/hu/jA?=
 =?us-ascii?Q?cGvTQ9yWYojodKAVgyBpSzCpXsOj6DrHQssGxWNLY1JFD7RRa67/V2+uiMPW?=
 =?us-ascii?Q?Tpou/uyJF7PAaF1BZeKXUleArk/Ozsz9gWsadYJqncGomxGfw4zr4WRiRX88?=
 =?us-ascii?Q?SoZGxgXYY33SgycmBTFgixvTCYwmOuh4rHHe4aX7f4473lZG93t4Wm/5nXqN?=
 =?us-ascii?Q?UJu4hpYUteB1wOzXQOInraeJ44H5h7U0b2132iQBnhIhAVIheEaVZawQPKo+?=
 =?us-ascii?Q?r8tNWP2rIEjVVse/ygAQWg4Kr+5mXlz3VXsOxUyqSxEt++WIiWcHpWl+N9yT?=
 =?us-ascii?Q?pTbbtlJZh9hE7xgBqLU5ANqyvoat7Krrpg8F05YzEGqWp2T0rO1c3/1Q4hkJ?=
 =?us-ascii?Q?BzA5DETh8XmvNE0sjKrn9IovXwmf/Rg0sPvvG5T+pC0Ilo4ARcGCKFDzpqdu?=
 =?us-ascii?Q?0XuQ9V3ZgoGFIwmuWCpRq1T3XrxU+US2W0DbWs2BEEHwqX8QOTZ2KaiqXY/C?=
 =?us-ascii?Q?ObeR5Qtq0ddhUNxRN81PvJl9eeuOWacuSuo6Ll5f3f/vcs0wVHcDtZfF+W+6?=
 =?us-ascii?Q?YwNxBJP758+issUbxzyjJE+ecCq0eQHVGq/IS2BLCvTSP/6OO8N4Sf4qUSsW?=
 =?us-ascii?Q?kG1aFngcTyCCbYIeMomhS8FbT9eooUyOHMneDT5SMIMgX/yb1M9k/8T5dCW6?=
 =?us-ascii?Q?fpxCxWZD2oUr2awKmOR0gvKzt3H1NTCPGRtaRrpGRswt2lsAQWfIqHMhImuG?=
 =?us-ascii?Q?rX0zMazF6TZ/S3hrDOFWQt6qy2cX+FUKLPoAVrMm3FsXnqErZTlIUB8XlPO5?=
 =?us-ascii?Q?rU0ZWaL+DXelXVncCol977jmUtF4zIs+JFz/7DCgq1nt9U2YNDayZfXQGRSU?=
 =?us-ascii?Q?XWFgEUOt/tb1PV320KY/4ManoOzPnOY+LSFNoZBLy40EHhbm/z9CTrm3hzUd?=
 =?us-ascii?Q?we3kqfbviScHIl/rzYdWLWPO8WsN9EQqtBfnPIoYBe20a5Yep7R466dAR6VC?=
 =?us-ascii?Q?BLTX1hvpBna6pEDkqnyHFFs00urEYpkX/rSTO+qzKPsa5w3fQc1KtMiC4LWn?=
 =?us-ascii?Q?VqYQdCgZljk0Cy0H/DrCpSTFo6b+tZf/H2be8e/p9E+Dpk5WFeMU73APpkBj?=
 =?us-ascii?Q?cgEtZnjVLTBOgtgS+X9IsD5/2IFspuWccg9TlMDQkHT41YiXugkenZukephG?=
 =?us-ascii?Q?9TByvKexVGEWmHOcrdr3+1BGu3a4LNiex6OvpNMIGY0R7g1Hn7eA2QVRj+1/?=
 =?us-ascii?Q?tV82iHQVmw0rgd1X37y3SFd2LiYl3WOhy7kMUZ5c3EbJUWF4l9V1RzpREhtq?=
 =?us-ascii?Q?+iGqb1BGoBX6TUeMDWXxuKHSt9SBcQDlSaKrkLB2HUtFTUUeFRVcp+/A1DCT?=
 =?us-ascii?Q?fpGKbrvCyUHY1kxxA7q4QXRdgon+eA4tci8L18E++P/Ho5sQvzbAFWBx7jb+?=
 =?us-ascii?Q?4pm1WlbtMlcnMbIOEZvluWHLh2l3SddxyGUGObQL+zMswqK6qinXh/l8DVyR?=
 =?us-ascii?Q?z3xYX8Zh9PXLOWxL131ernJkpPFtqNY/5Ch5RYoo8ud3X015?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdf1d1b-d124-4e12-c2e3-08dedf0007f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2026 03:53:55.9452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ltAmKYkC+zTEM/Tjn7GFEjWXVVYXuwqyg/0wYw7howN3aZAEtY6FdAdmOQU9mpLCsiewOSL+HmmKtp+18zL87Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12351
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

> Subject: [PATCH] arm64: imx: Handle both MMC2 and SD2 boot
> devices on Data Modul i.MX8M Mini eDM SBC
>=20
> Handle both MMC2 and SD2 boot devices as SDMMC device 1 on Data
> Modul i.MX8M Mini eDM SBC. In case the system boots from a
> microSD card, the BootROM reports boot device as SD2_BOOT instead
> of MMC2_BOOT. Continue booting from that SDMMC device instead of
> falling back to SDP. Note that SDMMC device 1 is the microSD slot on
> this device, SDMMC device 2 is the eMMC, but BootROM reports the
> numbers the other way around, hence the potential confusion in this
> commit message.
>=20
> Fixes: 0b97a394f6b7 ("ARM: imx: Replace YModem with SDP on Data
> Modul i.MX8M Mini eDM SBC SPL")
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
