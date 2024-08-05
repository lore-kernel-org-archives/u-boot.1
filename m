Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AA3C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 14:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90ED088908;
	Mon,  5 Aug 2024 16:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="e6awcLBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3A7F884AC; Mon,  5 Aug 2024 16:01:15 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 748B48894F
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 16:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrIvwz6245vHJd8EZOPGiyY/LUZlvQC09nVdTDxYMp3YmdcldlW+k+KriclCw6s2es9bxOxO0ixnzeY3ewssvnpWf2bdxde1DuTxBLeyAgCJRnprA6PYhc50lK/Flti01i5qs61l7+XWUUzEN3s0N1pqm/ETi54fkmFEKWeWxk012CrnNgJRe3b5XDSbDhVOubBUKsy6A9BiJPjKa5IuJpkax5nEf7AoQNC/+kQH/4VTPCUxlzAC8/Kb6GgsBmz6ZFt+8Y2SZSh0ztxhWsrjQ79JA0EhkcfcWBkdePRenAOWyLZXxujlLrzYpGjiReaFpEkBxB8+Sj2WqY55nNJYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAkOMe4YKh5028YzPVMiSCbjdsSqUJmz0XXlolAE4M0=;
 b=ZVZjLghoBlbqA1vID1XMCGcSl/YAK7b1vmiwQazc2S/T+dcJ1kgmcLRYxV0n3aNkH0rAaQtk6Nf8BXC8FJOPHwqTQBgPBZuPWgIkSkrWdoTmcHh247jRSvCfhTIZ7Y2vVChScH1m5gYs48koe1Bpw8tcJXED/MHn9Z/oTogqYv1jGcDVAtyjDtCgF5kLpPG+3bZYEhYQP2BW3+bUYFHgikiCbmSDxntwlV8+drorCkN/uksAC2YoBUi+CNTZ2dS+KG7eoTfPYFtWh2rdT1crM47GYcbgDEP6vpw+hRfCJFScFnnbN7eOn29NK1X+WdEcYYfMnAvrDHuYmbyvdg1LyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAkOMe4YKh5028YzPVMiSCbjdsSqUJmz0XXlolAE4M0=;
 b=e6awcLBPLbJ8Ez/JLBgxuC6K7E5NglsNW4TVfVA5+UmBqcYERbk8sHlVaKMtddC+toIzRJhoxO0paTN38ALOEGluaYn3OS4CA+FOLogZF5hT3oNua9hX51BwGJCRO2dUu/0icNvkwlqt+gnf4Y0ZPwOUOgVpRo9dVc4xm9kLQRjz9iPepO4T18RJVpYjOcUKz+m2WzMMBr663ZLRcp3fLLNsCny/42kPuacthZ4MlcvlMkb3hNRTj5d9FDlm0pAKDleEUJHRMHE0TABzwqKxFJij/D8T4kq7PIuBNv1aTYiLOttd2riGKUni5haj9cYvqxJ5/99UWXgzd9A/Lq+9FQ==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PA1PR04MB10294.eurprd04.prod.outlook.com (2603:10a6:102:44d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 14:01:11 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.7762.020; Mon, 5 Aug 2024
 14:01:11 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Gary Bisson <bisson.gary@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "festevam@gmail.com"
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>
Subject: RE: [PATCH 1/5] tools: imx8image: fix soc variable for ULP
Thread-Topic: [PATCH 1/5] tools: imx8image: fix soc variable for ULP
Thread-Index: AQHa5zUW0PPjpZT6S0WRcL+PplcoHrIYsTWQ
Date: Mon, 5 Aug 2024 14:01:11 +0000
Message-ID: <DB9PR04MB846114B114ABCE89F1092B1D88BE2@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20240805124326.544310-1-bisson.gary@gmail.com>
 <20240805124326.544310-2-bisson.gary@gmail.com>
In-Reply-To: <20240805124326.544310-2-bisson.gary@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|PA1PR04MB10294:EE_
x-ms-office365-filtering-correlation-id: c96b2a97-3c70-4b11-14cf-08dcb557103b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Kz905AE5I9s5qSYnDxy3/Zd4KZ0k9e1HgBGH4Ds6ZkQ3WP9uYZAo8OJ7UuyK?=
 =?us-ascii?Q?CftjvYKAwVSCQJ5GMEcDrcRFWFlmphlzmcn1nGuSBn0zU7cpIsDuolGASP5U?=
 =?us-ascii?Q?uNSmt6EtEg0AShssmtSBXsXUUb3oHCEWwu8s85bAon+GStdoL0uyfC78hY41?=
 =?us-ascii?Q?ukKhYNwM7rUbsoJP35W6oBmhbfVN/fIrRD+kcyMoR1yJX2QeNA7wIEmOeRS2?=
 =?us-ascii?Q?+vNe3GGd6UHsGbjmHDJYvobbLs0kZ/WNmpH2C8XuFFM87jvDpYIGU3UOTNjy?=
 =?us-ascii?Q?FuTfXlA8zdP9y5wPGr/XnBenaj9INApA4zR7s6+mJFC4mLoOtLIJMvaMiD4a?=
 =?us-ascii?Q?fe3GAMrVN/CxUzEjjUpS8knbbbW9ndtucKYHQM3pkKjmE8VpffFrgWlYHkit?=
 =?us-ascii?Q?85lvY65tz8ww+N24xA/epUfppyybvfuf9mFFVzr13BSjaK66qc75YqBx8S0m?=
 =?us-ascii?Q?mUL4SgSzV7cmXLMjpbIH6cgfcImzejjM8Khe0ZGi4Muwn81unFKDgG58qdL2?=
 =?us-ascii?Q?6YvX8fuTV/o9WsZ5if+5PBWFYkH3vjYobGT9NllPMPj//+ISrSgMvEwP+wMp?=
 =?us-ascii?Q?buIJf9G2mPJugYxuXzbisI9+j3wLNL00klo/TSMPuKdMptovJvn2duQ2rIko?=
 =?us-ascii?Q?prffrc8sq4pXrOShoexe1zTu8NSE8BVy0d1pIQdEYT38URh5scdJlYjco3wA?=
 =?us-ascii?Q?hJnbks+pKQeDp76+elpgfF0Zz9cI9sezN02HAFEOgEPp52oXr7uGaG66hLgb?=
 =?us-ascii?Q?r2YkxEAEwV8iRU9DPoonTSJjsJU77sWet3aD9R35LqjhJsscUlx2VwUqgvHG?=
 =?us-ascii?Q?e/i7PPmijxvWerpXmwnkANQflEM+wmOY85TxhzRm4r8QAdW/C2bhkv2+87rs?=
 =?us-ascii?Q?tCYgVBpGF6piC9oxIcC74qfvm6i+BT3VyyBNd+heXpV11SQjuaRTBxV5JESW?=
 =?us-ascii?Q?54SnaaJvulYuiOiM/281A8yy6hMiLqVgiW/L9/wYJVmx2zVgr2cZJ9N8MAia?=
 =?us-ascii?Q?qjutjutbrJ6K7UrrrOc+6tfcmyAcsmD55hJrD6KsDR4qnojXqzFZ3G6VhoY4?=
 =?us-ascii?Q?jRl+QQQLQl9DYiVcuRUWNOR2N+HQLg6ORBUQ6NiyXKASTa5RnRc5kPNVy1ud?=
 =?us-ascii?Q?cQgNO39WzmcjIwXT+UKZN4DN4cxFoAreEsn4RSex1ut09vYyzAYHC2re7n1Q?=
 =?us-ascii?Q?TkDw/2h22xHkEcKnVU1swtciJJdySjF5/wI5t3FPo3a79pWJdSGZwEmNC3qn?=
 =?us-ascii?Q?CRfVZc/1CX9lwJeQS3OU4CrHvbkV88dsSOYLeTYTB4qBJYidVBrGJmrOlpnc?=
 =?us-ascii?Q?XSiratJqJ9xsHWriYMjnWK9535sPWodOuCiFvjOrVf660ciitcJsbwvd2WfS?=
 =?us-ascii?Q?uEZkIoDNK8FCcSNQHOf779V9y6aD+VXIHhIbQ+1+9woGk+wWjw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FmTm3jl/bNn0b5auZaGTCKhIJ+S7+QCUlmdn2LfNtnGJsEP7SWAhb693ipwK?=
 =?us-ascii?Q?pmcy7lhfPgqhty11/3BF4HTYvZbCs1pIvsz/16QCyEUbmGyZbZi0EPlTVmu0?=
 =?us-ascii?Q?N+PenJw4VQEdOV7GIzbmvtcmuPDxYdoaboRCcHh2b41fTQkWdIdXnTPEd6cl?=
 =?us-ascii?Q?0bMRhShvtp+vbY/t8VooFDaiMbJTMI4UI7mjvTVaqA3ewrihUIeXmcDi6Ge5?=
 =?us-ascii?Q?bzPqsBcBumcGpq91yo0j33cmO/+2eUiKRoZRaVervkzYJ25HDnPoajwinf6Y?=
 =?us-ascii?Q?DYUla4yU2jhookwZChiWB0sv4nQ2boV9Gi2n6dyVcaj4eHj9qw3TOpVAzi5v?=
 =?us-ascii?Q?ZCuMhFaobjqd85s6S22GLQLtjadZUvjvjC/th/RSljRlbDKqgIEzpjAmcC2v?=
 =?us-ascii?Q?Vm5blXjq0v6Nj8B6X/bszb57k+Zp2sQfaG5H+9YWu0tAuZCIJB6cCuSpvYZ7?=
 =?us-ascii?Q?Vw8ttbqt8MSrSwF13vEMONP7V+rToSdRBGxM0WwB3me07Egf7wRFJNPSMLYY?=
 =?us-ascii?Q?ptAbiR/iNRslgNw/4/pPbkoMGlWxAbZkO9hjqI/LdxjRMaTYkHZhfNeHw3pu?=
 =?us-ascii?Q?JfJqd5J1Al92PnpHsSPgoINefKU4GBncSficH7HOiEb5sRHiMjufbAUlbrhW?=
 =?us-ascii?Q?VvSyVzlLBpuxuLgm8M5MzCwKnhagHKtHntWw8sPc7vghYyrDrFdujepVLrNo?=
 =?us-ascii?Q?0etAYndwCkXvvDCXiOkNRTS/3tRGfn5TKSRyf7YzSCqSVGQhW8CO8kSTZn6Q?=
 =?us-ascii?Q?pp4We9O9rRkIe5oJUICKMTAWy/a2xApGuHcC1JM1NWEcIf/M0b/1lJR0Tga1?=
 =?us-ascii?Q?waUxjZrZ9WHSoMLpk8fQVlgsnd+8nMRSQR9cUjGzx4Um1rfbMXUhdG1C7HCi?=
 =?us-ascii?Q?fa+2k0uC13QLpIcB99zIxUXOfa4HTPZnROXFi31/WjjoSQwbN8jYMiX6IEsE?=
 =?us-ascii?Q?viWRNko2oc4XIoMdGWhHDlQPEhHsQIfqZy5ZuZLyp3FNQbwyRXfV73Eaqt6J?=
 =?us-ascii?Q?EiaUbeoUq8LP6yLrYiscuvKQoNKIe7q//W6aCp9uXiqncpzEzZO+OAqJXTb2?=
 =?us-ascii?Q?bFLbN4H/wlD1DZpFyJP8NFNgd5xWmcKDJRrhjxZTUoAiyvs4Zwj7U6gCTVdT?=
 =?us-ascii?Q?R9pFK4U1VxC+MoX2q0haqzmkynAg9vm8fitnJQesGwgG0M8RpsI95ihQtEuo?=
 =?us-ascii?Q?xqAyrVcE/MOl0L2czLipHt8hfkNLdvqYMoAKLn9xIs5rTTt776dcqaInUgFz?=
 =?us-ascii?Q?w1UnlNfu1shAlixDyy9jpiHVtUZ4bIy/j74wWgY49AlOtuGEzZn1nblXvO9q?=
 =?us-ascii?Q?f6USon5vD1qjAhrp+nxa/OIB4OTWnd4e05Y1s3QzS+A4i+om7HxpalNbs88W?=
 =?us-ascii?Q?RtJuOYfjOBl+VkwWRWVO8p/wSc+SPN1EVKmR8RQshIFyfAsQQABjAo+UbEJT?=
 =?us-ascii?Q?KgJiQzN9PCEPOL0ycA9Kp1CDaDHDqxWRK+7OvO0P+whfq9cDCH23iOcTVkoK?=
 =?us-ascii?Q?LrKUWTd2MqDcaGM/G2VGyh64U/GLCumCkFfEuU6nw1CarkDTmId/I6ovBMd+?=
 =?us-ascii?Q?p9vMgmZQ55zuswK1pF8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96b2a97-3c70-4b11-14cf-08dcb557103b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 14:01:11.8388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QfeljFdtR+lvH8Yx3+vGm+8X5A2c1e5xv5GNl41PAbyB3dVZyFgglZEw2M+gdnTU6krHfxPeGxKbZONaNio1Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10294
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

> Subject: [PATCH 1/5] tools: imx8image: fix soc variable for ULP
>=20
> Fixes: 6ec65c8558f (tools: image: support i.MX93)

Put this just before your "Signed-off-by".

>=20
> Currently the ULP token sets the soc as IMX9, making it impossible to
> differentiate the two families of processors.
> However, since the 8ULP requires specific binaries like upower which
> do not exist in 93, they need to be separated.
>=20
> Signed-off-by: Gary Bisson <bisson.gary@gmail.com>

Besides the minor comment:
Reviewed-by: Peng Fan <peng.fan@nxp.com>

Regards,
Peng.
