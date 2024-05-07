Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D70C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 04:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27EF688724;
	Tue,  7 May 2024 06:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gE7CJbSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2312988729; Tue,  7 May 2024 06:15:23 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75609885F7
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 06:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEJ1UkRTf7Egw1ava8iXEgeauYPHh+rhDMt8Y/jGADZpPJ55qOGr/vhWt2GDZt/jFRrWzQSz1m3URPSy5pqwXzDCdJyv7dOmltkwcTUoObPnwNTRiidBG8+44+CFZrbAqO0q04j/d/ljPECKefuUMPuYA7T5ZbcAXJ0OeLA7Auu4syDcX2urPNcyHYeyArIrmEHJcDizRRz8+/NhPAeMIvbxmgfU3beMFFP5VzEOaGd4aYLQwurigQzeZCbQFiCHxC8/LQ5tyz4AkBQomQ+PXsQvtpI4HVoQaJnnO8y38JA52rrnHnIMekpdkCCwsRXxrGFlih4r+gyMKBYikGJq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uzuxdd44DOYnes144JfjwwpTbZGNjNBV63Dgl53LN88=;
 b=CjqCW1hHZcel7AzyIRBl91ae18MTWO+qCauL1FVyT9SmHTftAQm4pF8zfbUlHbhu6We7GewvluCpv81pDAMrueqYggs5KTQK5Bss1D0S4G5qZLt2JU8nzniph/bwDHIJ/IF47NqlUp99VphTNDqdyyCTaqj18t/GM9iaeHnqmduhmkiGXPbzvjal9qE3Mh/ORoiRC37d6m875vHfHT2ym4q6g7zMe5U0RcTSuQd9xKieXC30SNnhHiFLQt2kyxMkBSQZF48C5v+flXhVOGRkfKxtNXgszFwvEDLZ2a4BBwlxUo8Uq8NSLZ47cFngXjDh5R+knzr9pqjWnMtvAvPC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uzuxdd44DOYnes144JfjwwpTbZGNjNBV63Dgl53LN88=;
 b=gE7CJbSsCncVDj9EIYMyai1mKjKsXtBeq6AhTG8eExdrZcw6AZg5f9S/6DEoEjb+ZdihfX9f9Vfv4SzoNhBu7kTt+1mWTZWuumeyg8IaYVAzLp1ETK9VrAz7IV+qgLD1dxWpKUiS0iOK9iJPAroItgKWIaUKLQJ2lYIFRAXPfOo=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 04:15:15 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 04:15:15 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: "Simek, Michal" <michal.simek@amd.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v11 0/8] spi-nor: Add parallel and stacked memories support
Thread-Topic: [PATCH v11 0/8] spi-nor: Add parallel and stacked memories
 support
Thread-Index: AQHabeGfsHQtYi5OQUWrRu12lAeU8bGLjhTA
Date: Tue, 7 May 2024 04:15:14 +0000
Message-ID: <SA1PR12MB8697F03FAFE69E8FE81F397598E42@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20240304031046.25998-1-venkatesh.abbarapu@amd.com>
In-Reply-To: <20240304031046.25998-1-venkatesh.abbarapu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|IA1PR12MB6258:EE_
x-ms-office365-filtering-correlation-id: 49e0a1fa-86a8-4ddc-17a7-08dc6e4c4bf5
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?C8MZ9qX8d9HrFD4fHYCJZBrZRDf1Rq9xwiqGqSZ90Qn6+q0rUpQDhygTc3m9?=
 =?us-ascii?Q?gY/IVWN9hTixVodHzyrRlz09oHlqwMZ5lRNHYOW+hwZ4POqBVWFwFIHKYJHI?=
 =?us-ascii?Q?O5J+eJ4CR8stwuKndX1g4dIzv2cRsFUurw1MDQdZf3qOurA2x6NkzjMcFJWL?=
 =?us-ascii?Q?k2yrZp6xA2djfhwlVf61KfLr42gOZfmN2e554o8EZFfl5deMeE7jxlMSnVdI?=
 =?us-ascii?Q?LFZlRBQFnzUIZsPMir+QOUc/4MT1mVQelOo/BEzN8Lw2WnvrmQmef+GWx+Ba?=
 =?us-ascii?Q?clasaoZ55Fm7/SfgesdVDse1gRfSSA9jHuklg6EhzDA2zetoaEwIyDRoLi5W?=
 =?us-ascii?Q?RV6GXe123EdiwD1JKavu0prXsSy8gZc8duMQlkahD4rsR2JfJfLJkLoewwVU?=
 =?us-ascii?Q?jPDaDtVVmEkOxBLGsWAr6c3jOc2XS61Pm2/+jWcrh+NvY7c6iXgaXSmxpsG4?=
 =?us-ascii?Q?0lEx71W2dd1BE+pDozHhdcAkJSaBR0OaBmv1+Wl/JmEi6hcuXWtJTmFGQQli?=
 =?us-ascii?Q?8wJYuGZ/4Q3lhA3asOXyjCBd2f9L4hsyfl502WuwSBhc2yR0dDSv/tD+nydP?=
 =?us-ascii?Q?8bqcbUM/bB4kbyCe2cdISJHfHjwhjFm9QkhxC2XEOi9i0x6I5JIzFZiHglwf?=
 =?us-ascii?Q?CmsasevEYkVJZ/tgzDUa1ZhOmZ0/ZYYulnSDPVz3q3cwdcF6/h1hJsVaFJVt?=
 =?us-ascii?Q?M5nXcKE5kPpYQ6S4eTxvwBM/NLTzfrczG7FMKefwr9VgbRLBiFaYxj6atgYl?=
 =?us-ascii?Q?AQ8agAnys5ROBXPr7ZwXYZE9hltIn3aR4oPi1v2rhcIHOjEsyL5831n6jNTq?=
 =?us-ascii?Q?WSlgZ2K+zJrq8VVy9pJ/dE1rnXUp6NmvwSjp83LTgII6EBm1j8FBKQQiZRr2?=
 =?us-ascii?Q?eglgTJkPFfDJHoNavMY0TOWjp5iw9n/Hj6Og8okxxO10m7hKRv811MKaUWni?=
 =?us-ascii?Q?6Lk8ShfoDC0Ix21FGy3dpu8a9FRJFdCNBwpKmuXW5MXeiCog4/Y77hiWgLKS?=
 =?us-ascii?Q?0f/yUfSlaAlnGmvFpCc3/IUw5EzrcfpHVTfr/Heo/2NUwPodZrbXyNGnT1Ir?=
 =?us-ascii?Q?2FArYUbq3OdCqHloqmGOEXx4Z/H4tMxC/y8XUQvQ71uB2/d7/joayiFI1oc8?=
 =?us-ascii?Q?NiK/Z5T1wTX+uI8kikRRniBtTezjZCUboMmpycW6LEJcWuSlOcg/D3VTowRT?=
 =?us-ascii?Q?kGNcTBwXkawy0dfM2j8y05eXjnjWbPMV/TlzBYXlhI22GbVyUpPiQqRbAbb8?=
 =?us-ascii?Q?Si08Li8rUFyF3jYOzq5JVfuxDiSj/T91/gzgYb3Vej76iJ5FzlPVzXtYoLEc?=
 =?us-ascii?Q?JvYpCGf3CydI6iPDe/ePO8/MfVhSGMaUJ1YY0MN/AzT8xA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YdCWSmhZho4X+Mbzczf4xoXXzT7LFjdWWkiZsx+j66bNOxq63fo56X5yxCom?=
 =?us-ascii?Q?kSH7QvpzFywnpHfIj/6QjEmJu8xjv0BhcWoJQz8SWEWubkKsBWP9m/+ahbkY?=
 =?us-ascii?Q?cco/v7tvOJcJyQMYPhHB8ClqxPBtLxwU5DrI5jk9jHAYe1/WoC2eBnjGfdpk?=
 =?us-ascii?Q?HVUvGvwx7WB3aY7hRw9jqicwEZRrn6pK/sjGCjuhb3pve3bsRLPTJo1f36Ca?=
 =?us-ascii?Q?KpgDvCw+r77DscI5pAXAWPmEn3suPBsBILTvbEKSQOD+hZB6skdF1SuWNb0n?=
 =?us-ascii?Q?E9uTKYGcFpCzWrmOVPbmIpRR92qaL38rbYY2Pw2P7/Rbaec+M43mHKLBFC6P?=
 =?us-ascii?Q?ezUCB3i0RUUDHRGVi4W7gv0W9ljbGqJbF4MtbkMcKh5Ip0H3KsdLu4DUI5yG?=
 =?us-ascii?Q?nDEDLv85wftNRaphi2ojPik9qP7fhrNF7d5/kRyn1+K9DGtJsqszO79kdFzy?=
 =?us-ascii?Q?3zTjrvXGU69oINHRGzmLF63NohDOBOjTNcTKaFqhrhwh4v/i6d3oD+fdBaOL?=
 =?us-ascii?Q?RbiO8LF05c4XzAQdZZNNx3J5hdzh1umcagvM+riwjW7W9GjAeuWfLHbpY6rx?=
 =?us-ascii?Q?7fnaIqhGKEM35koxMVGWk7PwnispT576/RU+PcXalBBXfE6wLj+/VyBKbJ6j?=
 =?us-ascii?Q?MRrkSc3yW3EKng23NmIrtxLHFbqDT3IZ/6vWpwtLE38fXxa5S1E2NmqvkP9S?=
 =?us-ascii?Q?mNcYpIiDZ9sDqaGurXl6CqZsn7oAXChmXDRAcmCREk7EZH9GP1pzF3gcbNdc?=
 =?us-ascii?Q?acsTYFVaLkEnvcnkRBW8pdBIUaZ3NWD72IGlz4TkqeA/TlHmPVlQEPr7QU5G?=
 =?us-ascii?Q?ACZSGeBd6S+9H0ZjFIUBr+2F929u6istlL0c8xbO/VI2onMszSbyoRnLmVMU?=
 =?us-ascii?Q?47et3vbWc3OVZ2hkVUHCUtJW10EfUVNgtEORIPrZxLvfjDfbH4gFeQotmPS2?=
 =?us-ascii?Q?F9tCMs4Z30A15aNn3kD9uHBlH4RefhVanqXTMmjTzGFHxz/YmvKg1WVCLYVa?=
 =?us-ascii?Q?4TI+q0FnhbN5CRms2xSR44rEbXQ38ejRZ5HQKVV83C1fB2Gazi0jY7438XIf?=
 =?us-ascii?Q?/tcPj1yd4uHUbOc0fkYWHWxvzwkyo+1Ux2aqJPL2iwAjJWWXO6Iy3890nJ+q?=
 =?us-ascii?Q?bL5Cd383maTssVDqSB63dcojtJsTfPlWfD6gIl+AcnX6KH+4hyEZ1NwJdSSt?=
 =?us-ascii?Q?kbA8Hk1N/m+R2hHlOSL7KtJkRQaXthW8YMm38N3rvR+Y2LCptQ2KxpAdT8o5?=
 =?us-ascii?Q?1h3tPovdw94sUhgjRcxjFuzEfbH4zVthsc4ZTpijG9jqXJpjn6cDFPRUTzug?=
 =?us-ascii?Q?Ni93eQIyaTR4lKe/zbBZrNK925EA+HUeqkE/z3TBvhb9fKQ76rfR6oq4Pof5?=
 =?us-ascii?Q?SyATR6LQZgiIEMOqqGdh4MI3KGrldARiRcmizRJIBbnR1rbWsQ7SnQHD8pwS?=
 =?us-ascii?Q?WhjQ/1NHhtgJLHF+LBEMrAImOra8O/alACgBv7DphI4BGWTZS1qI/eZgLeBt?=
 =?us-ascii?Q?VcWRq767I4Amuyp9luA8AuDLElKZJFaFR1jT+YT8PwGa7mmbobmL9BDk51gk?=
 =?us-ascii?Q?EEzRo4Hf+0uWxD3ZEIA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e0a1fa-86a8-4ddc-17a7-08dc6e4c4bf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 04:15:15.0384 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vLZh2IdX7yziTNIt+kf7ox+N+L2E3LHQt9iURlZp5P7zqtfVkaBMSHIRdsahdID+tPbTLQgks7zMRoCeSk+hgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258
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

+ Tom Rini

Do you have any comments for this series?

Thanks
Venkatesh

> -----Original Message-----
> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Sent: Monday, March 4, 2024 8:41 AM
> To: u-boot@lists.denx.de
> Cc: Simek, Michal <michal.simek@amd.com>; jagan@amarulasolutions.com;
> git (AMD-Xilinx) <git@amd.com>
> Subject: [PATCH v11 0/8] spi-nor: Add parallel and stacked memories suppo=
rt
>=20
> This series adds support for Xilinx qspi parallel and stacked memeories.
>=20
> In parallel mode, the current implementation assumes that a maximum of
> two flashes are connected. The QSPI controller splits the data evenly bet=
ween
> both the flashes so, both the flashes that are connected in parallel mode
> should be identical.
> During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
> nor->flags.
>=20
> In stacked mode the current implementation assumes that a maximum of two
> flashes are connected and both the flashes are of same make but can diffe=
r in
> sizes. So, except the sizes all other flash parameters of both the flashe=
s are
> identical.
>=20
> Spi-nor will pass on the appropriate flash select flag to low level drive=
r, and it
> will select pass all the data to that particular flash.
>=20
> Write operation in parallel mode are performed in page size * 2 chunks as
> each write operation results in writing both the flashes. For doubling th=
e
> address space each operation is performed at addr/2 flash offset, where a=
ddr
> is the address specified by the user.
>=20
> Similarly for read and erase operations it will read from both flashes, s=
o size
> and offset are divided by 2 and send to flash.
>=20
> Changes in v2:
> - Fixed the compilation issues.
> Changes in v3:
> - Fixed the CI issues.
> Changes in v4:
> - Removed the dio,dummy_bytes variables from zynq_qspi driver.
> - Fix the compilation issue by including the DM_SPI config.
> Changes in v5:
> - Fixed the issue reported by buildman.
> Changes in v6:
> - Fixed the issues reported while running the sandbox test cases.
> Changes in v7:
> - Fixed the issues reported while running these da850evm_defconfig,
>   imx28_xea_defconfig configs.
> - Fixed the issue when DM_SPI config is disabled.
> - Fixed the issue while running the sandbox_noinst_defconfig with spl
>   ./spl/u-boot-spl -d arch/sandbox/dts/test.dtb
>    jedec_spi_nor spi.bin@0: has no valid 'reg' property (-12)
>    jedec_spi_nor spi.bin@1: has no valid 'reg' property (-12)
>    ### ERROR ### Please RESET the board ### Changes in v8:
> - Fixed the compilation issue with imx28_xea_defconfig.
> - Fixed the SPL size issue with the axm and taurus defconfigs.
> - Rebased the patches on top of next branch.
> Changes in v9:
> - Updated the commit log why SPL_FIT is being enabled.
> Changes in v10:
> - Added the new config SPI_ADVANCE to fix the issue while enabling
> imx28_xea_defconfig.
> Changes in v11:
> - Removed the unused variable, corrected the type of variable and replace=
d
> memcpy with memmove.
>=20
> Ashok Reddy Soma (4):
>   mtd: spi-nor: Add parallel and stacked memories support
>   mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
>   mtd: spi-nor: Add parallel and stacked memories support in read_bar
>     and write_bar
>   spi: spi-uclass: Read chipselect and restrict capabilities
>=20
> Venkatesh Yadav Abbarapu (4):
>   spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
>   spi: zynq_qspi: Add parallel memories support in QSPI driver
>   spi: Add the spi advance options for non SPL
>   config: xea: Enable the SPI_ADVANCE config option
>=20
>  configs/imx28_xea_defconfig    |   1 +
>  drivers/mtd/spi/sandbox.c      |   2 +-
>  drivers/mtd/spi/spi-nor-core.c | 399 ++++++++++++++++++++++++++++-----
>  drivers/spi/Kconfig            |   7 +
>  drivers/spi/altera_spi.c       |   4 +-
>  drivers/spi/atcspi200_spi.c    |   2 +-
>  drivers/spi/ath79_spi.c        |   2 +-
>  drivers/spi/atmel_spi.c        |   6 +-
>  drivers/spi/bcm63xx_hsspi.c    |  42 ++--
>  drivers/spi/bcm63xx_spi.c      |   6 +-
>  drivers/spi/bcmbca_hsspi.c     |  34 +--
>  drivers/spi/cf_spi.c           |   6 +-
>  drivers/spi/davinci_spi.c      |   8 +-
>  drivers/spi/fsl_dspi.c         |  18 +-
>  drivers/spi/fsl_espi.c         |   4 +-
>  drivers/spi/fsl_qspi.c         |   4 +-
>  drivers/spi/gxp_spi.c          |   2 +-
>  drivers/spi/mpc8xx_spi.c       |   4 +-
>  drivers/spi/mpc8xxx_spi.c      |  10 +-
>  drivers/spi/mscc_bb_spi.c      |   4 +-
>  drivers/spi/mxc_spi.c          |   6 +-
>  drivers/spi/npcm_fiu_spi.c     |  14 +-
>  drivers/spi/nxp_fspi.c         |   2 +-
>  drivers/spi/octeon_spi.c       |   2 +-
>  drivers/spi/omap3_spi.c        |   4 +-
>  drivers/spi/pic32_spi.c        |   2 +-
>  drivers/spi/rk_spi.c           |   4 +-
>  drivers/spi/rockchip_sfc.c     |   2 +-
>  drivers/spi/spi-aspeed-smc.c   |  28 +--
>  drivers/spi/spi-mxic.c         |   6 +-
>  drivers/spi/spi-qup.c          |   4 +-
>  drivers/spi/spi-sifive.c       |   6 +-
>  drivers/spi/spi-sn-f-ospi.c    |   2 +-
>  drivers/spi/spi-sunxi.c        |   6 +-
>  drivers/spi/spi-synquacer.c    |   4 +-
>  drivers/spi/spi-uclass.c       |  34 ++-
>  drivers/spi/stm32_qspi.c       |   2 +-
>  drivers/spi/stm32_spi.c        |   4 +-
>  drivers/spi/ti_qspi.c          |  14 +-
>  drivers/spi/xilinx_spi.c       |   6 +-
>  drivers/spi/zynq_qspi.c        | 119 ++++++++--
>  drivers/spi/zynq_spi.c         |   6 +-
>  drivers/spi/zynqmp_gqspi.c     | 141 ++++++++++--
>  include/linux/mtd/spi-nor.h    |  12 +
>  include/spi.h                  |  23 +-
>  lib/acpi/acpi_device.c         |   2 +-
>  46 files changed, 792 insertions(+), 228 deletions(-)
>=20
> --
> 2.17.1

