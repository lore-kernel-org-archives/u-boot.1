Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9CBCEDDA6
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 00:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EEF488C44;
	Thu, 10 Oct 2024 02:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="d23fxno4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63BBD88E7A; Thu, 10 Oct 2024 02:50:13 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50DD288C44
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 02:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POCTwOlgRU+mr3BXr9HAHqMVHGhwya+QgW8So/3JNFiYnObAaQFiaAH3bVurkmHlMoaP6URzwryn7v/mDa0JapKsIR/jQirJpfvGAuSrZ4UC8rtlQliQwj4tjOR6mV+AA6PTk2Gdr4jJZtKaP2v5vSoNo1QQTh/dJc2o/1kg0pECw0Wv58WMJvvhWf5KIXgLZfSdlvFY2zfmald4fG37sjjWJiLjADkahAZzarezgAI8iUC+RkYV/zpZXx/cCvEfG1fZSdomgiV1kxA/w6qHuxktU5lTZBPx/+FoBRxc+QoHD/hp2ebgGmBzZ3PAwJN8RI2fTeMdw700SKezWDyIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goPJURObgJoel3Mbmq0Bss1UHcbh5dVzcjYqfjS9ZgY=;
 b=kaBiQOOflcMYAcCXfWCAeI/MNCfYyAYJe1pfXlSrJdLYG2kBxBzugbpSbnZNZxnUjngOLtRrJBMjwZopmhVjlPDhUM4UMGsaSO7UJY8s/Oe53seOSisOalafMf4vU9AD4DsO1HU9UfZpJTa2BpnLNMba97wtUKjmVYLuNJ9jyZqaqTk3u+LmHJP6sJnCZwhuC9smnAFCl5paArMHeQLzFTYlmBfIVCMcPWF2xQh0rjDRXQlb32Tci5Kc2Xed2owYsAoKjQOMEg3qXNQeQXNEANTK1XIwHhtVlcprio8lbZql8I5wppSR/cWuhhtSxwIxl/w5DeVqhJONuIY8iEJ0lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goPJURObgJoel3Mbmq0Bss1UHcbh5dVzcjYqfjS9ZgY=;
 b=d23fxno4vr49r3sT7/Cu/UpzTjelHJzvwxXs8M9KS+WKlt39iuS3Ja6RmUsdrTfkJtJPILK0Dl3opdSDFTlpDyto4nCPX5mNFbP1i7kL+UgfEvknrbfqqZeQPPzoE0xRzLMSAA0HZ+0AEpyfD3ulz/9p63tPdpEsIj++RwUUT/7rV+OQAjq+7fyP176nfLA3XyeurBuuAQShbuj8y4Mw0wWQ1fLpdZF6KdjgtWG5JxuEHDIUtXAWk8/hy4Uyp235MfGU8LPU9FsC3oUZ3nNBgxpnW2N5ypmWychTSU/f/iNq4yY+w1U8RoyclPkBRSmE9xX1+902knTuQTERSxwCvA==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by VI1PR04MB9859.eurprd04.prod.outlook.com (2603:10a6:800:1d9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 00:50:09 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%3]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 00:50:09 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "sbabic@denx.de" <sbabic@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Jaehoon Chung
 <jh80.chung@samsung.com>, dl-uboot-imx <uboot-imx@nxp.com>, Joy Zou
 <joy.zou@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: RE: [PATCH 1/2] power: pmic: Support pmic pf0900
Thread-Topic: [PATCH 1/2] power: pmic: Support pmic pf0900
Thread-Index: AQHbEt8llFO0cjhJvESzXJAJK6ESdLJ9CpBggAF8+4CAAK9QkA==
Date: Thu, 10 Oct 2024 00:50:09 +0000
Message-ID: <DB9PR04MB84614504F90B00533535901088782@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20240930032244.20286-1-peng.fan@oss.nxp.com>
 <PAXPR04MB84597FAE909539FAA580A19E887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20241009142217.GI14210@bill-the-cat>
In-Reply-To: <20241009142217.GI14210@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|VI1PR04MB9859:EE_
x-ms-office365-filtering-correlation-id: 9bc10aa9-6a40-4ed4-3c2e-08dce8c57d86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?FKojtA6fRw4AuDIdwSuplOtxFkce6T7F+EGIwJhBlitSp8MBQ+TAsVv4u2GP?=
 =?us-ascii?Q?GpvYGdUsLS8wLTN+/fusPbjQnOe0j7W0BFTD8K1G/qGKsoxe2rOaDFo5ylYK?=
 =?us-ascii?Q?ZJpxq82gByXfA/vtksZf0+BcW2IxEsC/dMOZmlkpLKziqbO8yu8SgvQDCqjN?=
 =?us-ascii?Q?xAbmws8FiBNXZY4Axgcz4DLOv++QL3SxbDDiTW7cmXkV3lgYvQZH3T4S1dHM?=
 =?us-ascii?Q?g2QPROSeB/bI9STPgzTlLgOG3A5RwZAegvk7V9vy7I4nLFdN9rtqVGLE1ggt?=
 =?us-ascii?Q?rzvZcRlAvW8KcQjyybtKiB8W7CvPpC/amlP5amhTzw8EfaA2AZd6hGMUSLdh?=
 =?us-ascii?Q?MvgWoTJzvcT6ne6VCFnb9SwVRc3qa02k4D9m7zRT3sKJjov200dYxV8iI4bS?=
 =?us-ascii?Q?NOK162wGfFmap2X0t8iVaxYdjtAbfRp7b5K2fveNt0G1fJLpdsz/TVkuhfmj?=
 =?us-ascii?Q?fN6/GGPr/MtNlsOWndAZF6PhHoK3lEQx8eXA0u22HTCZSDDKpS80UZDl/fae?=
 =?us-ascii?Q?mIsgGdzC/lvA+TxxmOGvGcnubykGGA1KIyYLtrvYeLaO1FavyobvD0zgvK2B?=
 =?us-ascii?Q?LC+wuaRUIh+y9vIk7P57TqyT99tLASmcgUX91XIUZ1Hw0MgDU9kT55rDkN6E?=
 =?us-ascii?Q?rjOoeMVXWlnzu8TFYc72ZUpvhgeSmqbvRqHbutjO+M0h3A7RgGby5ITQdXEj?=
 =?us-ascii?Q?yjPaqeYIHaRngjzedOYs4fwvTqRboFVUnV5xbrcUoJ8vEJIPtOmFLm3BcM5d?=
 =?us-ascii?Q?dpRnnG3fvZIyWV4xfQa8fu2KvaPKkGh4hGHbar7k8zc8GMgCntSI80VCKtYm?=
 =?us-ascii?Q?vkWDjG/7bo6GiHu3dWAgOl7b0qDZCCWYK0ky/syJsF47Yf460mJ6HAmgAe7g?=
 =?us-ascii?Q?WokukEcNdSrxXR1+ekwFE+KWZfe4/ciANp811GExeLXGLUcKCePdJqBchOAi?=
 =?us-ascii?Q?qiFWkw2/K0N46lONjwpH1b0X/NE7CCSg2bWS8a4+cVdOfrU8AZJPJ03RU1eD?=
 =?us-ascii?Q?hXAtnpOybaDQbae9rLiJqz2XcOzSDX2Om64/TCfOEmdPY/Myg7prP1BCYj5T?=
 =?us-ascii?Q?eCgBDX98p+/0yCuEZi7gV3W+u+jvEl2kZURtg4JQwgulG2ef9PpU0vHIY2pl?=
 =?us-ascii?Q?70r63BHKzfVXsx9eSbUgi4tzHTKjf+S6iXaqu8h9vOudqVAv1vMxkAvhHIpt?=
 =?us-ascii?Q?iXjA4xxMlbY602qEPEtNKV4WFM8Jq9zISzhMRdAlqhW7slNVIZVflmoOG8+9?=
 =?us-ascii?Q?GcD4jkre1oUY7VhnY4Td5JeIBYEV9yPm3bcZJpWLK1AJtlQO//cwolOO/Li0?=
 =?us-ascii?Q?dC/prp12SwPwH5XRUGdtV4w255wXHaqETI1PGECPz9jDfA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N/OJCo3QZ/gMaAKhBX85eaVib0zdL89ehGpvnzoCsYfZOmkh/EvflnyoSeE0?=
 =?us-ascii?Q?nXjytddnzG1S3XkItUCAGvNL4TLdBjbPnQXIjrgwKpKQbBsrgA7vNVetQWRU?=
 =?us-ascii?Q?OsSuYKHfIb27uv58767MMsCZB1WfKUXH4KAMApiMlb/oWtg9u23DfCi6ZBWh?=
 =?us-ascii?Q?+q35nTi6sTT1c0e8iFPV+tQUV0c3rVCkW/p3XzQbO8nObtuUdKWA4bFmt7De?=
 =?us-ascii?Q?3Qy7wYpN4bK9RXCMb0XOJLqjLsikq1xgKscciKtlkq3K3XhugZeWGOlSpf3h?=
 =?us-ascii?Q?MyO6sPReWqmzA+0vu+FnKp7X0Q+PZv3mwJ1a69ENbEGAYyCYQHObV4jngOCb?=
 =?us-ascii?Q?8PK19tfDDUnwMg9whGknPwDVwbOZbkHCqGEczqjEApwue4X5dK7rpeQWiMN6?=
 =?us-ascii?Q?2V4sWVZjDzHZ+AwGhT1yvI49ShlCUsmzcHQR45wV28HB4h7xnw/7XKDpsIjY?=
 =?us-ascii?Q?/sRx2nOVuXE3V8/yST2RURz+mim6aufvuik+OZySkA1tNR/zKNx8tdGHzgSy?=
 =?us-ascii?Q?m9IywefHAekxAvE2wmBVWUUhj7h4Nk0F5CQlF06AfjXUqMQQwAYtCmGmm06M?=
 =?us-ascii?Q?q7FcjD1nmeocd4kti+ofWLUHcPfWsWZN3idp0uten62dGuMqlpCGD2YgiNhh?=
 =?us-ascii?Q?1Wzy8L9WsidHGw9TIQCX1DplJ4z4U2aHZSjOf1p7DSKd9atooNrbqwLq4s7p?=
 =?us-ascii?Q?6DaXPqZSKDcHZnDAJ4SUI6DFHin7rA3VgkO6OOJu1/+10vpeOVDGs30p3i/5?=
 =?us-ascii?Q?vAwFlblszzS0J2z9gkDqcUfLHDhSkVzBA6ZDh6uCiiykBjb4twillVmvqKZ3?=
 =?us-ascii?Q?Tnt2m25l85a/ldPqIYRWRlWn+UfdAhCsThxwlwJs4UVUa6AmpqBhBM8hEYdr?=
 =?us-ascii?Q?Aaomw2KXtEM/35q/WRTLZzslI/1pmBkZvLb61ek8zcsomYHFFeu16YBPJiwu?=
 =?us-ascii?Q?HazODU+MRwtcpQoPghGqQvldJS8OvmntioJ8w3njehUtmSElFO57AEQ6EwTf?=
 =?us-ascii?Q?irtbgEtBD+oAzVNmU9YapcbRikNA1+7mXh1KODPgzog1/BevdwfpPjWZVpgc?=
 =?us-ascii?Q?KzL6NbkB+5iy9Vpty2a6u5c/yjYpy6NjbqO1lhN5bUp3odjgdy7IY2CdSahM?=
 =?us-ascii?Q?p4GaHFPavMYwLsq7q+C6xa8DNiwNd6n2Ag7ztNsjKC/ONcnFpb8aKHcS6aUQ?=
 =?us-ascii?Q?etl9SHhJvMszCKh07Zhmfd1PEn9IT2Ggt94hkypAZPYQiWR21YbJMk07aZmX?=
 =?us-ascii?Q?arXMZ8COpTJeJJTwc9L7mdMR2xOyH1+n/+oWYj5QifpbcCAeFAl9pMKH+D7J?=
 =?us-ascii?Q?DNnH5J3Pw6xmZHdyhGvsMQNEMdX7QzjubOHfO0XWA9wD9eNAgmiMWmtNKIDp?=
 =?us-ascii?Q?9SHzNzT/W1W5lCBUrSCkqpQD7f/xuAN1C4Ec4dXmjyLVpolXEa6BTXckvrxJ?=
 =?us-ascii?Q?Q0o80/dvDVf74P0QdiISKsO5fafCKNyggJbZwkVvfEhjlZT2XjYaNGiYK8v0?=
 =?us-ascii?Q?70gW/LAsERwIqfNc6HGZ5xSZMMecOrR4emIlDXiIxEs5T93JDZ6ZpM6Q0DK7?=
 =?us-ascii?Q?yne4NeMH8mZ7EgTbi5E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc10aa9-6a40-4ed4-3c2e-08dce8c57d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 00:50:09.1346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UUiTNi53kberX0haiRISejki39OvzxkwxFuhSWYaEb6SnB6cTlXZbRhkwSuydYNyZ3DFwRBtCH56okLL3kq90A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9859
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

> Subject: Re: [PATCH 1/2] power: pmic: Support pmic pf0900
>=20
> On Tue, Oct 08, 2024 at 03:42:52PM +0000, Peng Fan wrote:
>=20
> > Hi Fabio, Tom
> >
> > Seems Jaehoon is inactive. Will you help manage the the power
> related
> > patchset or I could use fsl-qoirq tree to manage these drivers for
> > i.MX?
>=20
> I'll take a look through things and pick them up soon, thanks.

Appreciate your help on this.

Thanks,
Peng.
>=20
> --
> Tom
