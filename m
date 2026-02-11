Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48788E9E2EC
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 11:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92097831AC;
	Wed, 11 Feb 2026 12:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ly4fzMY0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C177083CF2; Wed, 11 Feb 2026 12:49:25 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CABD83015
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 12:49:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcW7f81Bp6o5YaYWYIuiPoI2wMzD0gk7vayuXsCEi/MsDlqNbRcav4AqfzFjF5VVyMRmyVUdEwq2xw2/XHzOSVoGxKVDYbEHbV3gHysb1dhvCwDIyztKJNziStvb9Trp8wK8jwsn9k+K0mv3AM1+ykV2DrkeyLKXQ5HgSNdV0Vni9u6U5CFNJYf0ZgOskPFGBtmaGGbn7ra6ZxMp9ujz5vQGCURBkUtAf2iVNBhm3AV24CdO4dGM1OZF3ASteBya49sRDfymKGAkJFnTZC3s4Biar64wvcevMGpyTM9zELA3JqZImIvm3KsgWhOL1i3oJ8e/1XKq9Z1e61bIus4bzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pmc6ZnL9JDkIbkYQLQvhvS2Xci1hjM3qOFKqOWP0+QU=;
 b=ZsMspLKVT2TL+35H+aKllim4I1Z19tjf6JnM7DBC+B1qXfj57huQbxTgI/GhWopTbYs+oJ3fXfD+qvjehctkNYESV1V1AmItdsWMs9Dwymrim/Rxw0SaerWXJoOagMiszC73oIKVA70cNMflSbTlDn3RUqYtTQfmWWarVT//IlJT+l2u6Q1QmYTiXLdlwjZKGw45tNT6fFczxHZzkqxToc9A9GdRS4gKrEXH/F2/ZW/WkzgwUl4XGUpf9NqDDFsRu5Qsz9gXHLXSv1oCIRphUZABR/aYBQ4BfwN6+IcZgq42MhaN/RI2sf3cDOctj+HC/DZHMBp3xbsaKqWmIxB9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pmc6ZnL9JDkIbkYQLQvhvS2Xci1hjM3qOFKqOWP0+QU=;
 b=ly4fzMY0hoMQb9ftsaMmpIOCgDbLHVSae3x4FHCd4+m0juGtbsKkL004WGmd8XNrMfJpPc219SmL5Y0vI0E2lY/vlumxKcjLkLNG7p3+K+ltn1gEkh+xyiBx4iE7Fz8PRlmoSucm/Sg/yLOW3zzTx8i7DAQsSoFQumjF7gYAFTelFb0kB8VJZjjv2unESNr1C1I1goVO2KE3cLyyhnV/64r/g7nSJRKeb1UpzT0NnWLJP/rMRXTXusxh3aG7EA/oB9h9iXVaG/eyHNpc3Vp2bTq/c2ciI0ag3iEUSShyFvArwvvt8fLPjbDtYdvLn/0IaSmG462ubMh0NU2Jz2AESQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8977.eurprd04.prod.outlook.com (2603:10a6:20b:42c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 11:49:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Wed, 11 Feb 2026
 11:49:16 +0000
From: Peng Fan <peng.fan@nxp.com>
To: William MARTIN <william.martin@muxen.fr>, herve codina
 <herve.codina@bootlin.com>, Stefano Babic <sbabic@nabladev.com>, Fabio
 Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini
 <trini@konsulko.com>, "Ye Li (OSS)" <ye.li@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v3] arm: imx8m: add boot_device and boot_instance env
 variables
Thread-Topic: [PATCH v3] arm: imx8m: add boot_device and boot_instance env
 variables
Thread-Index: AQHcm0GSAVPvbFM8LUepB8bF56aHIrV9YNng
Date: Wed, 11 Feb 2026 11:49:16 +0000
Message-ID: <PAXPR04MB84597449572BC512CABC27CD8863A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260211103109.92178-1-william.martin@muxen.fr>
In-Reply-To: <20260211103109.92178-1-william.martin@muxen.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB8977:EE_
x-ms-office365-filtering-correlation-id: 2cb0daf0-f817-4f66-cec0-08de6963957e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KWasaSByQ+m4di2jCLAStScki9F44W6g3Y6eOPWkFa65kabASdJraLvVnPg5?=
 =?us-ascii?Q?e/WlBBhVpakzFJUyNV8/sf6gmrnq9dNqdW5aGbCWxvzAV6ki+HcL/dymaBdO?=
 =?us-ascii?Q?FUWloU3RA2OeMDzb77gImpu1XED/+pnMBQca+3pnZ9vM263nWoUw3WS7DCqK?=
 =?us-ascii?Q?HmD5QSwFgzO7NNNC9guwDM2qHSdvBC44MtJo0kfYe46P4hJG5IRrE4wyyAr7?=
 =?us-ascii?Q?g6HlTmc3ilo7Eso2HgUv7dascSltp+Unstvmw+FP2F5USmRuyIO4OFTAaAVi?=
 =?us-ascii?Q?GqIDBOxWU7o03YRvQIx9Z5AbIiNYuHN2S6H6cqSuqjLMWb9nfLmpiRlHoXed?=
 =?us-ascii?Q?IZMtVx9lFyCal1YHOli3+PSMMzugvMWT4A8OMxsujCIqSETn2g16IzOjtLIM?=
 =?us-ascii?Q?Oz+PGOJZlTDI3RtlE0StNl7z1TmFsBnc3u2S/7dgT5TzgVpEVi9BBoUKCchI?=
 =?us-ascii?Q?6RsmZBl+DXn2tn6WmC4SP5MlzYeFOC839qab3DxCKDk0coZnR3Z9IOwIYdkV?=
 =?us-ascii?Q?JeqQGLFkmoxbR7E+i1tmOxDS9xB6Ip+O5VL9f0Zk7coqRPXJNiUpN7ZiVnPX?=
 =?us-ascii?Q?BRQ4T0tyexB22aelidvE0JpUWtwfgTVhiBmDrvmzPqsDG1fDl9/ydIZdpNYG?=
 =?us-ascii?Q?MJgfor+KBqPao9e2TJKw3kbLsTbea+w7fbUMA+eZ1YVWwLGaHoLrfiR4mS2u?=
 =?us-ascii?Q?5Bsb1JWeJvzCkcF4otKOu3E9bfo2/hGnbetNZrwFU1RVPlUTuNs2jSx301GQ?=
 =?us-ascii?Q?CyVlC4bTLV/1fFdUg3zC8uP/2UD06r01hhQpteGY1AT3zYaJmyDfsY2kVNge?=
 =?us-ascii?Q?KVLaAkRl4bDsdOzTzooiliYz8uOjidqrcfrHHPSWjVe2dWQi/WIJ2fjxFxrL?=
 =?us-ascii?Q?K2uMrgkrwQQ26jDnpzQ1MqaNmqNBu2Cao39GOj3xS2xUolhl55hsL1Ybn+bs?=
 =?us-ascii?Q?Y4vz8l5IVlAh58hvY8ONUkvI9i9/lOOgpogFQMXIhVVKad2QbZ/R7ggF3zwu?=
 =?us-ascii?Q?S+QVVOXO2kYDsnZ42hHQYeslNXLb6yET9MUGUn727RZbc16EV9upEsA2AXXs?=
 =?us-ascii?Q?Oa5AuY1c4l8ylxy1Wvzx60XOjfWmdSDB0I6HwiSs7GcRokeBiu903qaSgowv?=
 =?us-ascii?Q?3LCokg7OU4qNobe4vuhbbb+lHpnLwUaxWlg5EPu6zC238Q+VzSPXd9zovskM?=
 =?us-ascii?Q?R3nlpG6JfcoYfli7wyK1OEQkgXs/3UQIQ+IN49+a1O2WOcXu5evM+pZ7HcJL?=
 =?us-ascii?Q?VkDwMadM1y2cZnnenZ1n6DnW4xlahKAI1OLOBiB91ZKtqtfYqHGoJug8Kb5R?=
 =?us-ascii?Q?CKP7PNwLqfiaRqjwwP21bELBO3VgXsXpZth/xQzx0orAKEbr+wCp5TRgbolD?=
 =?us-ascii?Q?TS9ge5eEWCRtCao1SYwLyxgHNhZGjEM0zLnGeQCPNHeWd69fFhnbrwSYZAjv?=
 =?us-ascii?Q?WUamRIMMk6U+olm+Cnr64uK7QxTEr6gb69E1rbfuZvkAGNgCnDALwtIHnsem?=
 =?us-ascii?Q?KHlrcTQpfaYu2Tn3h8Chxaf8m6KhKDZrHwVX1irJYul3F95Kaav+Zgv6Jze/?=
 =?us-ascii?Q?1WsoFng1qmVPvKYLRsjq9MTaF9aC+RMJ518v4WfaD7K5bxiVD+mjJkWhaUdA?=
 =?us-ascii?Q?D+tBVIHhPamyE8SnaL9Qx4o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zmP8ho9AIKOuzsOWGMg+/S6bso1Fw7WT1y2zgxznBhK7TEHrOMDTFwQ7ILWn?=
 =?us-ascii?Q?DG/6h/ZcOw8cJzRlVzptH5+4tkEAufc/eJ+ekP7MZfHmzyOUMeUW/eJawqL1?=
 =?us-ascii?Q?SWdtDCmqRBo6C1zoqGRGiLx0xHA/jCS5/PVkQ2RXp3Z2g6TVZEizz/dsHlg2?=
 =?us-ascii?Q?fvwYemsedl3cWqnJ7aBH1X4eD693Oq1njhNj6n/yjQPOqM107d700dHwhFQX?=
 =?us-ascii?Q?Dl/olS2/XRPHVL49CtocIC/H2NVx0VsnFj6hs0pYuD36vitvmpsiNiomShxZ?=
 =?us-ascii?Q?yI/a9FqGuEUh+B8E/bIfWQzu2yL2OMmFzbNDccfJsNffeaLjrThuOBzo9y9Z?=
 =?us-ascii?Q?Ub+z32UIxLuCGBo1skaUeXIg5U5vLUXFm0dGtSEs2ESrlPZfJDut4cB80VG/?=
 =?us-ascii?Q?pFPLyJa0eKRD83cdYRQt8TRXK8TZsHN86+PmHohDuck2L/AuRtZJKgaSUhey?=
 =?us-ascii?Q?Wgmx55/FFjx42x2usS7tGJ26ZxMjlqvSqMKa32h2rMiQUR/Ic74i1+ykkI63?=
 =?us-ascii?Q?8hkJGLsM56H7nOpl4v3lnMqNxAIHd3R6r91vkG5qJmq99TgbbIRKiXTxciYN?=
 =?us-ascii?Q?82Vfm5LTvort3jRo5kf+peMzCurU/4+CQJfRGtMgcQwXE+SAMNIPuKJgnN+z?=
 =?us-ascii?Q?gGt+x4e2Ux5j3xug3JxunFaVlusnh+OT5GlybKERx9TRIlu4AOCncPJO0aMI?=
 =?us-ascii?Q?22MKgczH+laexDKGe6VEkj+Q0RBgapR+0spKZXhAUEelSialVRuM9unPmBaE?=
 =?us-ascii?Q?A9FLCt1gsN8rkNoHR/ZnI0joadfN5VIGw3+QUp/ps+CSdtZfSbJ7XhQx/K4D?=
 =?us-ascii?Q?U5MIH/jawLK9MpCm5V+cyNHJmnV9wFHbhT0c4KzcnV1bEUvEB0cRErrlrQ46?=
 =?us-ascii?Q?bNU4TOW4JdMTwzYGrroKsVErX4FO4ks8jk2t3Ivez/Yd0MHnu0Qu7y1HJ4n+?=
 =?us-ascii?Q?CRa5Nga+duuk24zJBCwFpLBdlcTkJu9W5Hyi8W2Pv04c2XIlB4xXgZo8IUt7?=
 =?us-ascii?Q?KC2WS3yz/iEjVu9pRzk94jYyy7lsQugjVQiXID9C2n7241ibYb9tds0ZFLLp?=
 =?us-ascii?Q?RTypVEbhW/0quf5srYX4Kbvd65A00OQZjgdZgdBbfZ7tvC3RrIXF8KQhLwev?=
 =?us-ascii?Q?LGuFHLyaptkmPsSfTUtX0cGUcl+JZSS/mgJzumqFgfnOgHXHucZm+MsQTk87?=
 =?us-ascii?Q?RPusr4V7CGtGtkZI9KkzknseokSDfV2lA2cQpTUpokhlCcofQb0eaM2cYyFy?=
 =?us-ascii?Q?zieNvm71lvo+j1toi7nL7dRhsvU685+45kNg7SQnTrN0fWRH+oRlVUDWduvW?=
 =?us-ascii?Q?dEVxCxxNcTGMOJJA3rX4ZJOZnj7ym5DU+WxYYc72Ih9te6au32AqjN7Uv+SD?=
 =?us-ascii?Q?S4zZTw7BOWpMNe/yLhEVf0R/ztrTFgVSrSuA+Bwp3OYJFe1sbMRI3U7r/B8t?=
 =?us-ascii?Q?VWLdiGWWDL35D902CYwMHAUfWt3gF6CiX4h9fd4Pp9a8BohXG7Bz6vAIRVeH?=
 =?us-ascii?Q?kOa8vtv9JTeMu46xrc7MMQbrQNvAnJppBheYt9x4wwrrHsG4Yi+OiLj5B2Iq?=
 =?us-ascii?Q?nIIdzPOcgbUuJ8rUyDFGe+B008AyCs3SJy+GofAr2aqJggr0DvGn5CtY+Bwn?=
 =?us-ascii?Q?PQxZksvM12XIsekN445jClUj7UYwVXTlX0EBReLC9mUnDR/qmqytympu9T+/?=
 =?us-ascii?Q?Z+hLeLS9PA6XI0U8PW/Q+Y/p1JNB+YLCw9aLKkE9BSXg9w9N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb0daf0-f817-4f66-cec0-08de6963957e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 11:49:16.3818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2hx5IJnDhUEO3EM0HoloGzGGTSFHDRT3g3745VUzMcsMAUhYR+T+QQ/TSG/h0RhBsruVRuV7h4egcRvm02c1sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8977
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

Hi William,

Thanks for your patch!

> Subject: [PATCH v3] arm: imx8m: add boot_device and boot_instance
> env variables
>=20
> Some SoCs have supports for 'boot_device' and 'boot_instance'
> environment variable. Those variables help to choose the right boot
> media during the execution of the boot command.
>=20
> The i.MX8M SoC doesn't have support for those variables but provides
> internally all the needed information to create those variables.
>=20
> Fill this lack adding support for those variables in the i.MX8M SoC.
>=20
> Signed-off-by: William MARTIN <william.martin@muxen.fr>
> ---

No change log here.

>  arch/arm/mach-imx/imx8m/soc.c | 72
> +++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>=20
> diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-
> imx/imx8m/soc.c index 1fe083ae94f..498b565183b 100644
> --- a/arch/arm/mach-imx/imx8m/soc.c
> +++ b/arch/arm/mach-imx/imx8m/soc.c
> @@ -1472,6 +1472,76 @@ void reset_cpu(void)  #endif
>=20
>  #if IS_ENABLED(CONFIG_ARCH_MISC_INIT)
> +static void setup_boot_mode(void)
> +{
> +       enum boot_device dev =3D get_boot_device();
> +
> +       log_debug("setup_boot_mode =3D %u\n", dev);
> +
> +       switch (dev) {
> +       case USB_BOOT:
> +               env_set("boot_device", "usb");
> +               env_set("boot_instance", "0");
> +               break;
> +
> +       case USB2_BOOT:
> +               env_set("boot_device", "usb");
> +               env_set("boot_instance", "1");
> +               break;
> +
> +       case QSPI_BOOT:
> +               env_set("boot_device", "flexspi");

i.MX8MQ does not have flexspi. It is qspi.
i.MX8MM/N/P has flexspi.

Regards
Peng.

> +               env_set("boot_instance", "0");
> +               break;
> +
> +       case SPI_NOR_BOOT:
> +               env_set("boot_device", "spi");
> +               env_set("boot_instance", "0");
> +               break;
> +
> +       case NAND_BOOT:
> +               env_set("boot_device", "nand");
> +               env_set("boot_instance", "0");
> +               break;
> +
> +       case SD1_BOOT:
> +               env_set("boot_device", "sdcard");
> +               env_set("boot_instance", "0");
> +               break;
> +
> +       case SD2_BOOT:
> +               env_set("boot_device", "sdcard");
> +               env_set("boot_instance", "1");
> +               break;
> +
> +       case SD3_BOOT:
> +               env_set("boot_device", "sdcard");
> +               env_set("boot_instance", "2");
> +               break;
> +
> +       case MMC1_BOOT:
> +               env_set("boot_device", "mmc");
> +               env_set("boot_instance", "0");
> +               break;
> +
> +       case MMC2_BOOT:
> +               env_set("boot_device", "mmc");
> +               env_set("boot_instance", "1");
> +               break;
> +
> +       case MMC3_BOOT:
> +               env_set("boot_device", "mmc");
> +               env_set("boot_instance", "2");
> +               break;
> +
> +       default:
> +               env_set("boot_device", "invalid");
> +               env_set("boot_instance", "");
> +               log_err("unexpected boot mode =3D %x\n", dev);
> +               break;
> +       }
> +}
> +
>  int arch_misc_init(void)
>  {
>         if (IS_ENABLED(CONFIG_FSL_CAAM)) { @@ -1483,6 +1553,8 @@
> int arch_misc_init(void)
>                         printf("Failed to initialize caam_jr: %d\n", ret)=
;
>         }
>=20
> +       setup_boot_mode();
> +
>         return 0;
>  }
>  #endif
> --
> 2.47.3

