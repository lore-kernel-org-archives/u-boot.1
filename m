Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038ADCF07A5
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 05:13:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46A1C88F2C;
	Thu, 10 Oct 2024 07:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="JrQc7FrW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF887888B2; Thu, 10 Oct 2024 07:13:15 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D6F488F2C
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 07:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnNeIoW6I9ORmGkXZ4ApynSNJltojyMSs+UGGTq6xRVS6oMcIAun+JlbIcNCQ6LK6TXh3fkXeaG2jaoUEEdbs6oUjseSSEIVMeSQIHoThY16MPq7hzW3b+SX73ODVUp/XGIwBJ3zxf7nJAEGKaP1udvCZnAx+wbo2jvrtIfoVQY/E4GhSviBGc3I/E/pPRhnuRWJXAGuZZcxF6W55NeoWobE4al94BQ3p2NMsSORyBgmxL2SNxRtNbbcLmOLKsXWER6TpOe5UQX0sFUsCggNkg0d2TzW1I68T9p36Ge87xTSRq0lvcD9SSDAWpjj93D21WK2EPlkFdcm6tRIO2PklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVQRw3DtMVygu2YOuEvyJmOLigZHyHGu+hvCOnNUgfk=;
 b=xhTUM6tPuvVcF7Z60IbtPSs/J/QGk/C62Y6/gGrJ6DxJ4r5wrS1V7UfZcu0NBKzrJz9nXRMXMsG01yVIrN/GJLaDC1C2SUifb1RVFz0afGqsRGQhO8jgCNmr360B0I4DvF6My5QWJuyeM2bohwNf49keyl+pGnk0pGShbWhyfBtKQhhzqK9GmvpWm9sbWMzUqNiHxDbCMtRGbBRtb6t5XKlAcS7Q7MvauxuRpNnS+3Ir9GygTDW4zPEes1K2hmjiD3YUfwg1eHP5j2be4p9GCxRUy9L4cSwetnf85i77K48iZzXK59HlXXhBXdQMTcoMa0rz3IrfzKGjCyuo1A38cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVQRw3DtMVygu2YOuEvyJmOLigZHyHGu+hvCOnNUgfk=;
 b=JrQc7FrWSa2oRzna21Tmbiu1PfZhVLheSITWsYFPyA8X4qYnK9Cv+WAU0dQojOJ7e2lk5c54ryO4RvvSwMAqaeUmUgjLOUFrIj6cMNqPK20++Cay942OgAL6kK95YqN+5yA5Alkys6s5fp8io3faBMji/WpmE8dBjjf+7rt5jflRnLsgHzcKOGHunj0l6ODQbyttNmogn/mGo2//dnJwffS6tlqkPAX1dJ+sDDqDXTRxO8A75u+H69Z+shn7Bsrh2RF4U3B7vn9G/xNra1h1FliFBjqr0E0WWM3QXZR1EskNGU/zYMcyAShRGi93j8rBmz1cnn74l219X95Ik+invQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8823.eurprd04.prod.outlook.com (2603:10a6:10:2e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 05:13:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 05:13:12 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Heiko Schocher <hs@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Fabio Estevam <festevam@denx.de>, Gary Bisson <bisson.gary@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: RE: [RFC PATCH v1] tools: imx8image: add possibility to skip dcd
Thread-Topic: [RFC PATCH v1] tools: imx8image: add possibility to skip dcd
Thread-Index: AQHbGkhRxRCk15HZo0O9jXZhliHcZrJ/cWJQ
Date: Thu, 10 Oct 2024 05:13:11 +0000
Message-ID: <PAXPR04MB8459336EA96B93DEEA1EC9B788782@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241009123937.124691-1-hs@denx.de>
In-Reply-To: <20241009123937.124691-1-hs@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU2PR04MB8823:EE_
x-ms-office365-filtering-correlation-id: 84b1188a-53e4-4d36-c0d7-08dce8ea3ce4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8OAIoHG+Sz5qy/IbfBXdNZixzqcFP1485smD7KhhAH58jLKhbsmC954CRcqJ?=
 =?us-ascii?Q?u92bNd4oVB6OXUeBEItMSrUKhFbxV/5UUEht2mAAtVE+euET529Mye8LLCaB?=
 =?us-ascii?Q?wSd6bh4vVIwzurVszhw4c+fYbkk3sdgfL33DYpY9zjqTXJ5TTJg8w2bFB2b6?=
 =?us-ascii?Q?9EYTh1VVWi+9c+mnRAQROCiCTm3MdQcemlhFEtAUsR2gz9qVxT/eg1KN6fr0?=
 =?us-ascii?Q?O3/lHBe/88cPtZxRLJqayJkuTznSkF6ebO8k12GyBdUUk79S7Brag51lBLhX?=
 =?us-ascii?Q?TGH/VF0l/Pw7Kj7n8oqrUhukLYgc8b/xsHfqrPrTnKH3XSUUIkUAauJwlfwk?=
 =?us-ascii?Q?JjLxluhHcxO1WmD9TLZr9Pg1FjH+CEnQIHB+Dc5FvpnPqs/BgHRHp/dXDjgp?=
 =?us-ascii?Q?tauf8UsQQWMgn5VpihzfHYHQKLqSJCXLS3lyC5Nuq8dYGY2g+NqPtDdrWYOA?=
 =?us-ascii?Q?kG1MOX+yvzR/0ECqGCNDb2M/idd6QNwzuUdm6BfZyYJfo8ajZiH8EvpLHbr8?=
 =?us-ascii?Q?uSEatssrmrGJYLgefqlsowkcbAOC+E7Y8HwBuxSszTlGaHHyhVKvT0RCzneu?=
 =?us-ascii?Q?LOJj3FFgu42vHLNM528D149Kjg6UpUM5e9ODOJINrqRTqv38esSwTagElW6o?=
 =?us-ascii?Q?20G5RluEK5nlR1FSkPlWPA7vzxySdn16BCvtfAOH9KeIs/5uDIXLHpOpCGP1?=
 =?us-ascii?Q?ZSvRNEZVD4dDV0YuQprP0Ehla0SMyvLKTLFBzVPIdyz/g3/3GWueshuzO5Sp?=
 =?us-ascii?Q?gKTCCYeI2KVxdNqDZN0YFI2NPWOwE8tBKpaAA4xIGzFrlMJYWnvI2rUE5Mul?=
 =?us-ascii?Q?9aH8x4lTYAsazKRIYNxMZWlMMhA6reBRO/xWpmm7rc+ASLOo5iXSNJUQ9oNZ?=
 =?us-ascii?Q?0h9mWC0NtgY+u4AjPZBV4glvuhF5ociCLolr+4mZizm3bybVZ5t35GON6CDf?=
 =?us-ascii?Q?xtMFFNZImesvu8FpKynElTNfnsxCCYK3spOkOourvjG2I75YeiO1hDkLvcfX?=
 =?us-ascii?Q?uCEQZA7pePwVqYdSapjphB0zMxGKUMsyeWHVFA4bx4Dh0iuv/9569eB4ifd8?=
 =?us-ascii?Q?L5ecFrYiK/yoG31AXsFoGT8sc5qIc/oX2zh/5uJxOrmq+ng6H69MNar3FgXA?=
 =?us-ascii?Q?ZoFfOYfCUCi2W3vls+mG3PyHr8QzziJVnoqB9OUYH4knLsE8gSGT4wdjzdfm?=
 =?us-ascii?Q?UAYWz4PMpNaX40Ew7DuFTy0wISt1JixEDwnrwpLqdSRQLVDj+xbtKf53VYVP?=
 =?us-ascii?Q?ANwypl18eyJDaxKeloss1gAgvAJlhSGkS9ZWHlJxqRKI9Ff9LrGjHHj21h3/?=
 =?us-ascii?Q?cbfU6WG20TIv6HB92YM6WBSWei1ueMnrXKzB5WrF8l5qJQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wpJeEYxiLQFW3D9EJlJK7ZEwxX2Z1K2t/T9RGH441o8ucR/Gi41Nqtr0YO7O?=
 =?us-ascii?Q?afzA1uIqGXGoxpR2jZi0U67IqfCjzsEtNeP7z/vlKyGlmEYIApRVNZGRhzwl?=
 =?us-ascii?Q?jxYo/a7i9WMAczm5rVfx11v2/vCLeOTiFDdzfihx0KqKr0BQjYHjKolK7M5h?=
 =?us-ascii?Q?FaKTeaoFZrFqnvCRvMBR432JUVJ51fwPerx7n1ktn0cV+HRdoK+MYpyl3R6V?=
 =?us-ascii?Q?jezu4kerribWIUE7hF1Osa+/fH3MLZsS9Gjf9JaC40c0SwCbCSqVgKSis1Nj?=
 =?us-ascii?Q?felFqkRGldXnI7XVbLCnsXFGums3GbZOBUBvQEGI8d5eN2at4Lb1jh4ykYOk?=
 =?us-ascii?Q?XPzu95HjOUAqRVypvY0u6jlUb+K69FmdY9KFjGwUGrdwzqOIrLjMqEIwy4YD?=
 =?us-ascii?Q?Th4lFdMkmJjtxJuP+g4hhC4QAi/bMD/Vog2raMh0if5vMU8VJbwK8vCBDSEM?=
 =?us-ascii?Q?L5+va05ZoBq8So5XnVLuTCS0RKlqxLih7HRaV/EmhVMYIj0waURrOwt/Lewk?=
 =?us-ascii?Q?KFaeq4bKM/fBvYIbxD770XvpGkR2AXdPMEdTs9kS2o0KbVf+anF/ctUAQpri?=
 =?us-ascii?Q?cNQgqRHd1S99iZzDyoaVIdnr5+IWvEYHht0dcqXIBGXxVvnbmL7YyxQsAItY?=
 =?us-ascii?Q?LYdhlf9651p6nNSwJ3Gv2vT6dUaK/W+ebn6lN7OCNDH5Oq5hjAhlBwH0NMdh?=
 =?us-ascii?Q?sIq1IJsyPpqNfczCuHRLe7MGY//+4YdfApJ6zAikXnHC8UY9JpUki6tQbzkR?=
 =?us-ascii?Q?q6WjfaAs+RpvGueMICV80bMS+VwdJ+ShF6x9Kqm7yEwWhWfm/9qdMz+Gdxcw?=
 =?us-ascii?Q?rdTGQ5pjteXjBodcv+xJWvkaqjQNuFOp0PbRj0HJiQ80cic/1iku+yPvZq6J?=
 =?us-ascii?Q?AmYpxXeiGK4FMoc7kqQDUrWZLWcHg/z4vsEQD5n3nrI9oEDRR6Av/uOJUg61?=
 =?us-ascii?Q?pFLgoBQZNdTpWEGM8vAoZdaBOYPnnSB+9Mg7OPXUUpsz328gmPoFJrlR6Mq0?=
 =?us-ascii?Q?LqO2M7YvC11CEIn78+1hlAeBKZV3zjt4bf6PKJ3DqQuPbb0d0iQymPPJcHyC?=
 =?us-ascii?Q?5LjfyYBg5QlhymefrR95jsiOQlCfd9/K5L3r0Vpb7kk5xreuqMprgPg4n8yz?=
 =?us-ascii?Q?SAkDNhSF7wMu+xcJKYNm680iCRtydYLiRqF2eM94uC3p6CrPxA1GixINtnj7?=
 =?us-ascii?Q?kefQ16jIwH5hFsX43DPlNZwbGir8seiIhMGAqeebM641EZcmDeVaWzO0F80c?=
 =?us-ascii?Q?5jjch4Yuew8QoCa1nfxTGDG5gjrxhjQyRpMjcQNJ9WjTzWGAICdBXGPt0nLm?=
 =?us-ascii?Q?H+n9qNd/0eMN5ObT2ApkEIqBHhMkfEV/cqnG7xf7nHGW30P1KaFZFDZ//j6d?=
 =?us-ascii?Q?NgJi/W7Im0p30+n+28qR8K5iXaePMxL1JLJOEdUuiP4qFErOU+TvJB2hF01c?=
 =?us-ascii?Q?pHf/tpoUia2Q5N1eblP7ncM//VIc7Y1KsIg7k5iWohhYAhCuWHHmglnPaBVo?=
 =?us-ascii?Q?s/PR8ieQEsGO35bwZx9T8oQgG8id9LqkdbctzA27gIvVcvwen+vbDNZU/C9q?=
 =?us-ascii?Q?NzJJLxElY0DHYsSwWKg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b1188a-53e4-4d36-c0d7-08dce8ea3ce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 05:13:12.0859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FU2mG0dOSXF15NMwLYFefuTC9oV6gS63reZ/+BOLUxH9BcJ/nVmfI3jjvuCSSeODqbhnCvuJieDIHpL7KiDclw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8823
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

> Subject: [RFC PATCH v1] tools: imx8image: add possibility to skip dcd
>=20
> Currently U-Boot always adds DCD Image to boot container.
> On imx8qxp SoC it is possible to init RAM from within SCFW, and
> adding a DCD image type to the boot container in this case breaks
> booting (No debug output anymore from SCFW! Nor any output from
> SPL), so we need to configure a dcd skip somehow.
>=20
> This patch adds a new imx8image_cmd entry CMD_DCD_SKIP and a
> new entry in imximage.cfg "DCD_SKIP". If set to "true"
> no DCD image type will be added to the container.
>=20
> Signed-off-by: Heiko Schocher <hs@denx.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

