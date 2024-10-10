Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EB8CED611
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 01:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E36288C98;
	Thu, 10 Oct 2024 03:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="g6yYDl9I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B19988E5A; Thu, 10 Oct 2024 03:18:10 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABE6B88C7B
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 03:18:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyxZypx9t75u88d3UFpO+n0rE4dR2dsN7cHZQKVy06a9sD1KcOlNEwHfueFA3GSq7DUBkLNHyhejN/8nAbeXw08rpNxI/aE0QJhTgWGja3XSvhtm/8L0+JWx0aJbL6IR+AeQnvQUwYo6OlRSlLjIpME5pdnJ/MKQ5lXQaY0qj7NQSrPoA33ZU89x7hqrv0JAB0melMN/mIgL7AQmBE4EtkRw4MQ9lrGvRmfJt7UdOXFHFw0AlItO8A+1/jh80F4NsSBta/Gqm7r/Lp0lqA8QV24B06lkd91G7nQfpgZI9/6ueDUYFpQOCj4Ig/2UhekQOp5XZmEbEcTi57hlbPH7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpDPsapnX6MoHHknvnTQJOwkD0ryr9B3UHGH4dqo504=;
 b=bG2ykHEoxPdr/OzpSLSyC78IW1R99GLuYwSir8Ujq7cW9JtxEYF+oeOgk8i0AJLh7myjRyaAqcWVmb53gcFE7qNZgSMtoUdEkC5Laa8sQ5TRzjJgCQxld0FuJna6vbtTc6pzjnFCTBPeugu/j7+yCmY0QoY+aTdpOP8WnqON1fZWTL06RjGakdKCnQUpo3bwKcuueh68JQJJ54LtheoEwwe2Uwzb6KgHRG+WYdEz/Kg3cFx5N6B7y6RSepTj7J043BnNWtJLORw4osyOhglPhIf4Qgd2XatPcDYxW9wncpSEvoesf0kSIWqu4cVdO3vMSI2gVgCyfCwE35uPt0kmmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpDPsapnX6MoHHknvnTQJOwkD0ryr9B3UHGH4dqo504=;
 b=g6yYDl9ICZ92XjBvMwWvig8dq//SFFR56e59Y7iYuus/ngAqVXBequk3UL/FsyAWgC6yOD+3ilv7lahSV6yS+DDVtXkA9m7UN7oeDSBnw4Ql9IMuy//Onw/kgvbP1loZK6Cd7RLm3oNLerL/jYoJcQ+AqVNTeqs7t05lrwLKUCSDOnrv2mwRtsAfApnjm+f8X3YIKcuX44PmAZxB/PcRkER6T4iOg6ZjMq1wsOV08aaYmI9f9upeweCGR5EajQHFLJRqwdxI/1Efo/6vkVSbQVhI6dlrBxlOqnqzBvfkCiomaUuJWVSq15ecKtAqKxlzypfLZJd0ySo2ArEW8U1acg==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DU2PR04MB8616.eurprd04.prod.outlook.com (2603:10a6:10:2db::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 01:18:07 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%3]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 01:18:07 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Gilles Talis <gilles.talis@gmail.com>, "festevam@gmail.com"
 <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, dl-uboot-imx
 <uboot-imx@nxp.com>
Subject: RE: [PATCH] arm64: imx: imx8mp-debix-model-a: Migrate to OF_UPSTREAM
Thread-Topic: [PATCH] arm64: imx: imx8mp-debix-model-a: Migrate to OF_UPSTREAM
Thread-Index: AQHbGq2AzX0OmhM6tE2aW2sN7G6AyLJ/LdBg
Date: Thu, 10 Oct 2024 01:18:07 +0000
Message-ID: <DB9PR04MB8461D3DD8ECB267BFEE7182A88782@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20241010004242.149787-1-gilles.talis@gmail.com>
In-Reply-To: <20241010004242.149787-1-gilles.talis@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|DU2PR04MB8616:EE_
x-ms-office365-filtering-correlation-id: e40a12c0-9163-443f-29d2-08dce8c965a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?FyfzrcIl7l0PLcdBfyZVt8lNmzdLb0jmmGh0OcqeXZg4ARsfJvgVqQV0kCgr?=
 =?us-ascii?Q?RlYkuKUOpN54sWES/5c19FUHuIKnLsO8hTodvEpCgq1tYSFxpTVb6YkX8VW7?=
 =?us-ascii?Q?GlUVT94Cw4ymYXOHX9Hr+WNqciBvi9AC8VMGQmjQIzLNVqvZqP513CGuE4Zk?=
 =?us-ascii?Q?RM4Rx3L9gqjYoV98oV27cUHPnFzR2K2+AhugyNeaTnKOX3+GnmjG9qHMjem9?=
 =?us-ascii?Q?JFoLsrtGvSDbBxxzrO2IDQ2aIH7k9iPZuGPe9BuB1XM3OA2475JlgmOzm5qa?=
 =?us-ascii?Q?gX67X0GPnVkfyqY0ntydyWNHj4hq7E+sjqrDJxqwwmyxz3sdCthm7MygxYZF?=
 =?us-ascii?Q?LMIqx/jd0fBjAjrv8k0oqCLNrCEsqcvcf0EiFuXGUCFntDuqOCMaGkVtdlWz?=
 =?us-ascii?Q?tbt69f5k91ocy4iK4jbnOVJifz5RAJprNTFptHoctzIkSzPvCp4OmSW48wfq?=
 =?us-ascii?Q?1wZMfz5GKTGI/vPheOhXolwUMv4Rik9aMASziuru1UbfrBhWhlxeCGy+yiVQ?=
 =?us-ascii?Q?CsvGm5lFx7+w1j9i1DjvPWbq7yrUzoMQbaD4xldkvygAQC7MTbkIJ9djTjdM?=
 =?us-ascii?Q?CXm0h0IM701i/7Zh26PuULgZbgkJ0wOM8l8W/HiMrLDj/AIZisLpjNGpHck2?=
 =?us-ascii?Q?Vy5u4wOgy6vPur+qb8dUWAkwHqlH8c30/Wx/3v+ny8RVH9JR2JUCpDah9yKB?=
 =?us-ascii?Q?Xai8iC1ZL4PTDBsD4nHGo7rWS0shLnfZ0mwDMCNadEf6pJvQGbe6iiaXBYZr?=
 =?us-ascii?Q?mYX0V7TW5lOqskBSi/ixMFxVGUqu4ocwZZ2/WOgwnggDd0fRUX7fFrl90ECA?=
 =?us-ascii?Q?ePVNHv6ijQDtUe1jGKOzAXFckPyW7EtV+8yAc90bUr9AQeKPgyyh5ZtTnGYe?=
 =?us-ascii?Q?6WwDBRyQTPQqHHiMipRUCfVPG4XN5kTcr3JXcCmVjaJY2zphP+xqd8VSIUOL?=
 =?us-ascii?Q?hd4StSJXM2FMjzlVAs+xNOR3uwFxdBVHUw0CGRvRsup8/x1notsnzEY0FXjP?=
 =?us-ascii?Q?2usWcoCX6yDUva8bdKsGe8MLc7sGTyN1con1JbW0XeYboOHZph8yQ51poa8T?=
 =?us-ascii?Q?9097ZJ+cEPE4Xhb0cXNpdc52C5WW0n7+LBIIkU+AfcysaK/PaP27aoJezmQH?=
 =?us-ascii?Q?3vAh6EvK07RdVsBqO65QT7+95cpiyUk1Vtjt3LA35lNeCKIJJaALAjGOCSSl?=
 =?us-ascii?Q?BlZvA/LuLo3dA2HaXsn7x8rNlXSAG4BII4QcDouxzRP5iUmrK7N0E8f+BgDk?=
 =?us-ascii?Q?buDTd5Cptx2Z2VTwUKzgcyWkjRwHz1uS+cdQzn8B61NMcxv8ZFwamyx2QWIu?=
 =?us-ascii?Q?a3uYs/W1MSoRc0NmAOhK432PycVSawwgYkGlkLKrBeYkGg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lZv/ay/dSL5+LASElTCn9ejcKEJ3CeppJI+yM81vazG7YODwXOPe+P4e64P7?=
 =?us-ascii?Q?TGSyEsKm3rcyyOsA/gz/cWmi/Hid0207XjPHGIn7atUSDFic61KLvHQYl92S?=
 =?us-ascii?Q?r9tQ047CoVLNeXe3MqKcngbrQKkOcbucz9t5rdyIYWqo9Syv1Cf8sOnPp4Vf?=
 =?us-ascii?Q?sbgpeDXbcna5vLO/BHvsoneiJXtWICfJbOccPa3jztxLe3E2IN/xiKVyxwZI?=
 =?us-ascii?Q?ceaioClr3J0WaH5SHXrKEC3w9KdjnatPb9nxN3ZrbifbwNRgxFtnlnLcumr8?=
 =?us-ascii?Q?LWlOaoTFNdoX9uboxHE0sJIOHa5qatSPiOnrhDuCIjsHw8IMBGk+FAG8EsqB?=
 =?us-ascii?Q?EYErIHJBIUMlf9HJSmL6EOXX6iN4X1TC3couFWHBHy0TbCOGU2qsFU5W8ljl?=
 =?us-ascii?Q?onoJploU27vMEwRaiVs39kVAbUDI733P8YHj550k73CeBFNP30YQoXkfB4q1?=
 =?us-ascii?Q?65/zX+Ve2rJFPXoDkj5UUymzxVq+rlSVk+z8dc7nLrsgQUVlVWgOGZ97T1PG?=
 =?us-ascii?Q?R1T/z3lZBSHgZK0OYt4nUWyjTVUg4TUl9ASluX4PZm7HMIy5Alg21+RHDv3E?=
 =?us-ascii?Q?ekwcARXeX9avBOAx4l132OIEoKeJ+yleSiexMaqvoXegTqntqR/NHvCKGjSf?=
 =?us-ascii?Q?v2utgXgQpctLNIsLHTby6MvKn/auby8C9BIT5iYrfoTwUW/KQAIXmDW7oWTA?=
 =?us-ascii?Q?mjIukodS8HIlSvAIZb89MGH6YYbmEFKABw2sD1xQDmsNh1yayiNjKVbIVeXy?=
 =?us-ascii?Q?UfPV/9nO0AiK4cpXUUjTApmsI3KQx527GSO6P+wYR+9JPK2HyG+50zcp+omk?=
 =?us-ascii?Q?sp9Kma/fzZ8N9+znwiOmj6XH9HS06F75FiZi0hIcbHOyzU1aRtmERyMMMSC0?=
 =?us-ascii?Q?eubIvrbPqB2f8pm57ifAXeeO7aXoPDlXpZIT/CXQY51sS5W9uhsR+C3FcsCx?=
 =?us-ascii?Q?/O6JKEwi/URzS20wWQKIX667n8kGbtTFyeNwwWV+dOVH72WErzpazL63ayFn?=
 =?us-ascii?Q?U/xa7ijzIo7o9G4BtVi9uFOy6eZJAilB1HKjXhIMEK88H2Y9XrbWD91JaTrG?=
 =?us-ascii?Q?SHORCIZTj3DnZx4t0r8ytmgAwYxT5yDpVl3rBhAbJ2yu9//jql3BqDT3qYH9?=
 =?us-ascii?Q?6URSBTwryhmP9eM25jE0xQsnm3ALgru5v+PBFsBD2nlWDP8TqefLeHjjUqsi?=
 =?us-ascii?Q?NViN5k1iElbMhgckCAIHo7d1t48owzayP3i2eBzVSbOCP5cBFlomI3/yw4Rs?=
 =?us-ascii?Q?VaWtAmIaBPazXccvlhG/27pVmZVtEORSkWmm9EUxLc4axafzBNZA1htEQuZp?=
 =?us-ascii?Q?Ucy8/Hmdz874sUMxWT0/nnUy9WtXRJGknlhuzaSvbVkOp+sMqLZbFV6AovB8?=
 =?us-ascii?Q?lgD/5526uwtgeGqsgzPTG9pdO6HRYcCtCpiiYz6iVnfPJzoHP6q5+9PMOvKO?=
 =?us-ascii?Q?jK+nd/5tNMFEVqPSl+wvDR/Fa9HmqUezWpPBkmPy8P9vfPFgmSQX5Y5gSy8Y?=
 =?us-ascii?Q?GxThErgD0hhdeR7AaSNZxjp4SBhHyMdur9MzGrfhInCmgtMuL/fpp4JSj2Pe?=
 =?us-ascii?Q?iUljySzSHWibZ5hRdl0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40a12c0-9163-443f-29d2-08dce8c965a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 01:18:07.0365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wdfRchoaj9kbGA2pvKdLJXLXKOweURjIuWKIbuy6bIlQwXltikelB6n5XXJXngi9SxsYeZEqFnQFuy3OiWirlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8616
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

> Subject: [PATCH] arm64: imx: imx8mp-debix-model-a: Migrate to
> OF_UPSTREAM
>=20
> Device tree for this board can be deleted. Device tree location now
> points to the freescale/ directory.
>=20
> Use absolute path to PMIC node entry and its regulators as device tree
> in kernel does not provide corresponding labels
>=20
> Signed-off-by: Gilles Talis <gilles.talis@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
