Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAD6C8303F
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 07:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 455F48354B;
	Fri, 29 Aug 2025 09:55:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="RXD3w3sL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60147835C6; Fri, 29 Aug 2025 09:55:49 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAE3A8359F
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 09:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjT9A8n0g+t/F4IKgAh4Xzmr+In9MmDsEuIf7j0i4PXBzq+BE1CzCRy0DnjpPd5kzSSYrqaLxWR+qZOAG7FXI3BxnZPRgP22I+Lp4wbTvig6UaFyAqEJ9Bm32C+/LRWQGnQBnZV/eWfYbe0FvgT1jXfsIL+YxKNSJLHCqy/c5NR1Fnc42rY2m+Z7wRsZnAVIH8A6zIzii3jlWdtvWnqZ4wW45M42g1iu4eqkZWHZWqxHDxYCkPLNkz6Pz4FGpm/jTRhDCyUJUUlWI3X4RaEJZD1pKc56oFfToOywvLfmNgbGU+aN60GWBg2VNu0IKr+KjUGCxzDbGVkHWY6gacmjHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EOJvIDy98cTmy1hjUN9zh5PfJxsMoJ2AM5Je8Xavxs=;
 b=uE2pW4eyo3st4cnGCgEsejNqa0LsarKc/xFOTP3bML4GPYYgGw3LcIOSTDrba0dljgmc4E/c2y77TLctT5XrJ6YZxXDPYHJrFC7wNWq7gAWBt4UMHjEqxl1OUUbtYmHhSCNOFZQ4VXJmi6huFxDOz/Di5TxNIdHV3MI3KQ6Q4dkadjk04glVKNnu6WRIlLykoRLVyolELBYOyW4wPlfThEQu7dj7I7PF0hTWmX6GmHQzptfxWeHeaOT4YilXrD31n26LPIgTYXVy2+r9SEXqrd0znLZRwGMrGhyBO1+MKLsgM23HAGJvvU0Q1FV5ORpI2mrfnpeuWEgOIPdFZbq96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EOJvIDy98cTmy1hjUN9zh5PfJxsMoJ2AM5Je8Xavxs=;
 b=RXD3w3sLWx19UigYMjkSHtmXdPeLYVH5MEbzRE3Q8icR2qtY0nCNQ5iW26g9zvGtGjeC0RDozRnCabn/AWmeYmP6Dr5edYup6HMsjr1T8Vechhv+UpAB5DwnuDSGuqrjR2bUQGFxz8ryQNUlw5D5BHOgmX3c/F+RawBrvb0klAjXALdwBFHkppfEH+mqjipelMeTkrqDygh8ITqhVymqLdwJI5x9uuWq3+GHMdy1Ic4jncoDwnaiXcCPyhD/5OKb/UXBkaGnl/Evp+JQUKJdfRSjS1C97vClovimaUsFOkJNzQ2pisCapACZwN0IUkCtUQweDLPRLWmut4AlhM0PpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10425.eurprd08.prod.outlook.com (2603:10a6:800:20e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 07:55:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Fri, 29 Aug 2025
 07:55:41 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 0/2] cmd: mtd: fix benchmarking
Date: Fri, 29 Aug 2025 10:55:32 +0300
Message-ID: <20250829075534.2895148-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <87tt1r6api.fsf@bootlin.com>
References: <87tt1r6api.fsf@bootlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AFB.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::30d) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB10425:EE_
X-MS-Office365-Filtering-Correlation-Id: d83f44e9-ce7b-4743-8361-08dde6d17339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JHumT5monTFK4p5eLFFKI80R3/WcQ5yfjw6q3E+RsFIjPk2Wn4qU8y7qRdii?=
 =?us-ascii?Q?dVIalCw1gA1MnGd7YfxsjExQt7+eR2imyXDc5fKgVBA1mvPb21JeXz/zP9GJ?=
 =?us-ascii?Q?jbodBsuhwQ7IJz4xZc3ZU9f9r1K6F29t/xchN3S2z/jaezqvjSbku9vS36bK?=
 =?us-ascii?Q?msFtVL0qcwHpb9bVal1qo2TP//werSWDdRiLY22IrB/98oIgMo8owWttXOnz?=
 =?us-ascii?Q?RPsi6Z9/cKZVmwi8uAtaIEDVE79kBpLjLHfWEYAopMPjtyjqPDys8qA1toI2?=
 =?us-ascii?Q?g+cPgfnYwRh2A7ggdis5iiFkTFmQNDCpOMdMnHmyh9lm+XlVdfYi9cm/mTH3?=
 =?us-ascii?Q?WYwnGGkckDYcNOm7W7Q7nbEFIP8ElGsVMsoRTcSgYLlg5Oa14qOdojB83Dpn?=
 =?us-ascii?Q?tINqI1IPooaOUcj+WPUBaNBp98sNSYscdb8JcsXLrvZ0eiTMurGmxHk9njRH?=
 =?us-ascii?Q?DN5m9IttwrIDsn04iJzCHZCotaM8tsOKmV+cn7VmVN9Hvfw/qxCn1pdRczmI?=
 =?us-ascii?Q?ii4hNSweux6hKRHkzFB5o4NnxU+DsAz9b1rYcVcOGpF6myqZ8ynDcsH/Fl+0?=
 =?us-ascii?Q?gouwPdO2tlqerB3ZN3iV99lCFZ7efA/2SPqEq20O9NyCA5OUPXykrB3VFiN4?=
 =?us-ascii?Q?GALDsvFiQZ/GxcED1p4puEbnnE9dXzaeKwD8ikpwGv0+P80xhCEHwVOCbTEG?=
 =?us-ascii?Q?B+0XRnUd0smaBgy/+vePJLKKGTaOeLv5Rdu4FoZ8DuC+MExQbDJlRhC6PtMe?=
 =?us-ascii?Q?srFokhMbfdZac+qxyiFZhYum8gnYblckgljJFUF78Wsf3QmveDBs4CzRNrEy?=
 =?us-ascii?Q?yKiVhLUxM/mgl8hRzHe22pUxOuiue7IgT/C0aqPGPQf3yD3XtRav51efSPAT?=
 =?us-ascii?Q?XroL6OwFKX6NXbIENkE/HSpZcKwBk2ir/DDzdja8DXRidicn6B+hPTF36fJ7?=
 =?us-ascii?Q?SoSy/3AFYBnnHa6QQr/zvCy7YZJfx6j5HSFxflUKHrSXPf6rsoMGcuM3UPAJ?=
 =?us-ascii?Q?r90CSfKlN3nsEIYwQC0xOWhqgwnV2J3mg76mcL7JeSO88unruBYti54+8hgX?=
 =?us-ascii?Q?GCwlOhkzkkbq0VsoqNV3nW3lXqyoU0hVzqTXoOAhHN5nzkcFlSeAHkl/FgtB?=
 =?us-ascii?Q?NQV5i+E4YqNzdettaj2C5uqbw1xSAfJVZfCBUnw6Vm9AHhoDMIiyGZAEriHo?=
 =?us-ascii?Q?wd1ZqGOlXLx3eVTIM/4/oB3DbSuFQNSe6yhVln+s9y2oK2FE5JsybhvaFwx5?=
 =?us-ascii?Q?ZINkweH6J+f3HINjA5BI3ENx3atrRTCg1W3J9A6Zb697gbdgZg2e5J30vfQU?=
 =?us-ascii?Q?OWcHyK9BFEGo3bdR1smir2V7JUrta5EROAzKInvUs91FAEUy2ZRSe6KNlHul?=
 =?us-ascii?Q?xFHsQclhkv0VC8owJ2+r3f/nfyslQW4oj9bpTILVv63uMfaQCOhqmQhidvL+?=
 =?us-ascii?Q?urYC9faZHCWljbF7Kself9Eh0Sqo9auRRYolcTvk+gagOU7SaSNmOw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qOwL5FLxzHD6Vsi4psYiSNxvdC1+ryyZx79NLgO9A1h3rydHBgdrI2e505IG?=
 =?us-ascii?Q?/CaofEGD6/tgIEA0NPzltW8uZja38TtsT3amnh+RRbTPWanXNo+ZN0LSFGMV?=
 =?us-ascii?Q?FAGm/vexZheeCVK86eqUZAB0UQqQToO4DJvo3FT8qukOH6YfcGgTg6kI4i9+?=
 =?us-ascii?Q?JdHBZjojLcA+zMKjMoxdqjhIreds8YNSiKAhcSD7LpcHbJ9cSxyMNCud3G2m?=
 =?us-ascii?Q?VYXRDEmubtE+xun7saWm/Q3TLfc5+qBj5dz2UQC+gyNEIQ9nPq2eIF24haK4?=
 =?us-ascii?Q?VxWrCIwuzUEVzYmRC0gwk45ssh4vyRGFIUZZrYch1mfePAXJHGCcGZVaf0P1?=
 =?us-ascii?Q?t0cuZD2uZG3O7svqQNlWHqzLU747x5Y44H5gBI1meQ86pSA3XhqUIKSYsfOq?=
 =?us-ascii?Q?Lkc63jf2SIBngwxBlAtoQCtvuEMIA2vAqzEPu4XjJneZ5AnLOYlTJQI+BPQp?=
 =?us-ascii?Q?s0eiyM+nD75nb/7eVuk+zluZOZBZxvHrSrNuKXlL/ee7gFtOx0HoV2wyyydz?=
 =?us-ascii?Q?NHabv+qvL62NxF8MQwEpAvSeS+EB325xjMqZIUZJu4HSfX/xzJDF14OThTlU?=
 =?us-ascii?Q?pzrIhSp0RCJJ4sHgoF+Ji+MeDE/meol1nHuzdWA7ef5WFhX904049ZIX8P3s?=
 =?us-ascii?Q?79susHQ8RgOFnjihpYFcjHD+w/sSen8RhIlpgbFjXJQM3zGzFFmcUmJobKGb?=
 =?us-ascii?Q?IDvgDKtiIeMq/grRX4CqIWTAN1rvrLB8ExYhcWMBBz39cF9R7PXaHSkflHEk?=
 =?us-ascii?Q?XCn6IXL6th6wO7rqjwBbywoDNyGd1txPxXp2QxPHvIyB5Kev5tZXqco47Onc?=
 =?us-ascii?Q?E6saSI9qN129KNSaAzVfOB4S9YcEhtUHe47F6Ecs32oTri6l2WQMB6LlKhZI?=
 =?us-ascii?Q?ymEEdskLh3ZvpGFrkNGPIAapgs7EOp6jyBiI0n1xp6lOn8m/EIC/k3W710HD?=
 =?us-ascii?Q?ZTJvf9lTMsubBiz+TCMFJYKerXyBJlTK2txinPbIlR7VRKOeGpvWbVtv6s83?=
 =?us-ascii?Q?6Cyvgn4V5jeEkHxcfzIr0vXTOxjdPbDSzMwJ11zuZ1WRZdXvQSiHPhUSG4zi?=
 =?us-ascii?Q?53/MPCr4pwBkL5Tzug+Bk2Kv4rl5JhIA2wbIsKl0aI37Gl7X7t/kXMYOHYxp?=
 =?us-ascii?Q?uY9YEdUcJBOGWr7Gi7deHPpv4YG+VWEswI4cHyxXdhf9wPgAejrZoVBqd1Kg?=
 =?us-ascii?Q?W3tpQjy9tED5uowQe2RuN10SWkW+F1+0+diQnS3rEOxC5llF/17wySsu/cmg?=
 =?us-ascii?Q?UA3Q41Vel6Op/gRFVhQkSEkd77hJQ2P2Akv1pCDRUg0zbMU+Mj5xP30IBvpi?=
 =?us-ascii?Q?53f2vEVdF4yTY0L9XsNuJ7wio+uXoaMZ+NmzebEhUP+O+y0Xcj/nH+bjuGYE?=
 =?us-ascii?Q?tH4lDBiuYrKXTHteljpF9h1rgtTGTjBRz2UP8yhIyuBmMP75VCjiLTs4+KpL?=
 =?us-ascii?Q?DoxQtygAvSTLa7G8lm+XcWA8z1ZNkLDXYzM3eTBiWx/rWzyl0Kouz9+InNmo?=
 =?us-ascii?Q?9wW1bFd7g8riEirtiCMzoIoSYxFlmaPPkMLQzHFhwgu59R8ZP3+QxLXb/7uW?=
 =?us-ascii?Q?lk/I6/906EVyAxjsZbO1/7b8hCCIm6ngE5nEat0gl5iSq04G6E7aoS1S/zWt?=
 =?us-ascii?Q?Lcosoy6SHad9VJvFObDl0Eo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d83f44e9-ce7b-4743-8361-08dde6d17339
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:55:41.4445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TG49uhT7uiTdyPP9/gNyV44WogV2qes93udacR1Eks3sNNoAnDbz0sIqp7J/fGiv5af1+2ZaHfrSfk3vempfbudj00W07DlLpan1xCTNm70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10425
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

The patch series fixes speed calculation for nand device case and
updates help to refer benchmark option presence.

Changes v2:
 * update commit message
 * 'Fixes:' tag was added
 * calculate speed a bit more precisely using a 64-bit math

Changes v3:
 * split on 2 patches
 * update help for 'mtd write' command as well
 * format help for 'mtd' command to align device names on the same collumn

Changes v4:
 * rebase patches on top of master branch

Mikhail Kshevetskiy (1):
  cmd: mtd: fix speed measurement in the speed benchmark

Tom Rini (1):
  Prepare v2025.10-rc3

 Makefile                      | 2 +-
 cmd/mtd.c                     | 5 +++--
 doc/develop/release_cycle.rst | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.50.1

