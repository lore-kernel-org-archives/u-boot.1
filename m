Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F4EEE642F
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 12:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A03C84019;
	Wed, 31 Dec 2025 13:33:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="J5pp19On";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF09E8402F; Wed, 31 Dec 2025 13:33:35 +0100 (CET)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazolkn190110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d406::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1039483F6D
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 13:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEVCI/7UX6ZCVJfGuVsR3OiDVd8o83NgaQJ+UcTBWTrwspEjiLKpmL3RhK7IDCiATG9Ok9TEzqozwPBelaTPcfoazSpWp6QU8StP8kSLFEkGyA8AUazmZ6oLKzMzUc9go50gtz6iQK3Z+Wha5/ZbdVVZNkf0swdQnpCfpdujHdBTvTEWVIqTzBLYvg6mZHdl0/diIb1hvEMSQi40UqSEDHFXaF7wsO9kTk0Nq3O3Som8iuk9RLJiv667nmfoHyG0GA51ivWluUubohvwnpRm+my/C31ood+JvaHyBU4KM0OD7Q0tKK0ls22BSBW71FMrca26Am0CFeyIdEGqHPOL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2VHY+4HPv72IiIj6oTHtjM2O1Kfop6HiwOKrHfjd9w=;
 b=dQ/jidd/ICRJfRtV8gSOA8kG1sLYYWT7DRqCJeM7JpCW5p26KlF8MFLimes7lgoFBNJrGEDvDh9sfHd80mImCW/LOHUH0UScyEKmEpjMwzrRqND1gscRLoZxvr6FEp582hHbZzxqEjtn3jHaet+tOYusfCkzVKGsY6YDhRTySwsUJzRuXlflGIT8nY8682gAu+5DRG3AZVbGHNA+v/DZJr5qCVhsFsry5MNz5q8T43ZEgKv1GBa6XmJgZYCBO5FFFYju8ak+vfCDSbNsDmbXdtNAqGeFoP2QySS6dreS1Vv4OQZpekTyJI9QQqzTO1CBsvCq+YZfuMYe9y+zZ1qsbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2VHY+4HPv72IiIj6oTHtjM2O1Kfop6HiwOKrHfjd9w=;
 b=J5pp19On36cxMgrlZs6U5VHCrxBLx+qxThKgZG9+/jXodXqbUrZvypiKnoxJW0CbeNKboF3Oqr/ua9ZVWp3p1+jUQPQp7IkeugMtLH0tYgKk6c5wVG/t/ntKG+GvKvQVu3Iy0qGmPOFtxCNUtiH3dqZ0HprAPNq9B4Mk1ONVyry6xqex4Zgf/PaX8AHciCereoJ666VXqqhpL8amCFJGOKT5jwxYpeT9/noQ5zw3/ds+6XpHEP8BTQub5GJp+v9MePC02U2VWsIVrq6NM30tj+Ig1qSV2P1TwU3YPg1Kclpz8HK4GRjebV+AWsIqODS4HUyJ1Whou2635Ch8E+5t/g==
Received: from OS7PR01MB13834.jpnprd01.prod.outlook.com
 (2603:1096:604:36a::14) by OSAPR01MB7303.jpnprd01.prod.outlook.com
 (2603:1096:604:140::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 12:33:23 +0000
Received: from OS7PR01MB13834.jpnprd01.prod.outlook.com
 ([fe80::6e58:e4b5:3405:28d6]) by OS7PR01MB13834.jpnprd01.prod.outlook.com
 ([fe80::6e58:e4b5:3405:28d6%4]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 12:33:23 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Tom Rini <trini@konsulko.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 0/2] mtd: spi: add support for new Flash chip BoyaMicro
 BY25Q256FS
Date: Wed, 31 Dec 2025 20:32:31 +0800
Message-ID: <OS7PR01MB13834542EA65B2EEC830EE37CBCBDA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To OS7PR01MB13834.jpnprd01.prod.outlook.com
 (2603:1096:604:36a::14)
X-Microsoft-Original-Message-ID: <20251231123234.1323171-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13834:EE_|OSAPR01MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: e6be1bbc-7ea8-4f36-cdf8-08de4868c960
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799015|15080799012|461199028|23021999003|19110799012|5072599009|10035399007|440099028|3412199025|52005399003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YHb+dR8mPSiHMNBlF4NsK2ydASxU5bnVDp3HXNOGeW4ec3Plau4LTEbZrtAL?=
 =?us-ascii?Q?UXACFlXs0JUTPSqnYHOHoQJHnGQAMoRfYj0Heoepm8NK1ipYYqQiCIc+dnv5?=
 =?us-ascii?Q?OWNMSmgpULyPrVrYcH2+bjmbSC+A9tFupFZTi+Wbnc9bxhHmrMOl86ETi1Ff?=
 =?us-ascii?Q?aIY8xOEdiDJnTxBAHsR7Sefw5iiZrCcbfbsgOZtXn0i+l/73hIJTwQ3ti7uv?=
 =?us-ascii?Q?+ZvGnk8sEYKLeNF8ut2FJTb6EGArWZz/43npj4QfQ6AksGfCSIh+Urj1x2mY?=
 =?us-ascii?Q?4k4roTUv1uzkDeZdUqaQnQWPDMUkr/37BrQHx5iCtuysck3OmrSEWc8dMEGA?=
 =?us-ascii?Q?HtXnDrZzRx6ODcFUYYRabrromEY6UAwnCprOzDaC97mqqe+wyLVO8wImGxCr?=
 =?us-ascii?Q?4BBZW+One31+j/WvOYJrXbMXKxLC9P0owXzqy5/xqIoEkznfdChu7Z7fpNH6?=
 =?us-ascii?Q?Pe6T/yJtTaZRYCA1xP3F46kPZVahVjgrwgr3l5H/XyV1bA080vacC+sdeRuV?=
 =?us-ascii?Q?CIj6ssvCXm+FANAcoI6tRRXcnxjhCaQXDtqV9oExcTMSr48fpyBzQUru/AZH?=
 =?us-ascii?Q?9Jx18wS77byqWwGIFIjtjBFqNJy1N94pcEDDLzlfZRB/s/gdvr2nhP9PU6wD?=
 =?us-ascii?Q?4Bgl4N7NVq/E40g6VZUEb2K92D6agsODdlpmvJiVRDewPM/ACMf0M6UnZETJ?=
 =?us-ascii?Q?+V0ActNxoivcQxi5v1MqqYl/DNHtGTXuVK3SluhpmncL952YWBnx5S/RdQK6?=
 =?us-ascii?Q?wFFWXf0fAey1NRO/TsaBxUfTUn3O9x52gKhHsp8jM3bYu5AnTKlq5J1gb4QF?=
 =?us-ascii?Q?9WK1Zk86Q42xujDBNhy1nbkcfmTq1CWoZFIVG3FwfRx+/bIeheNnurv32jLn?=
 =?us-ascii?Q?Yu+e5nrNVIDU/MIduA3bhGpJkiVs805eks12+WYSpdROMYE6HnW+M8NjyeVE?=
 =?us-ascii?Q?I3aHi87a7XQ3FlHNPrwgWEf+zjGEi5k80u0Gq9U1+E0rMKE3cFL7rJJ652W2?=
 =?us-ascii?Q?7O9dqTzeRMCI4AGa+G2qjHouMvPH8QqBobH6gZp+iaOhrD+4Fu4dhvIayo8Z?=
 =?us-ascii?Q?aGvaObCABouBLfbz6XzaOsjryIXA571UpGG1ezilRTSGJTGmFs5qR0ZfXWzo?=
 =?us-ascii?Q?nOeU23mYecUVoJQWKaGKxaM3sqmvFGgYViByHAyyTyJS0VIJywpqleOH/IJ2?=
 =?us-ascii?Q?88EiWc7KO5Hu6KJ+Jclr0HqPqRl+h4ZO96XkZg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AmVQubn2RgDQT8jGs1nvdZc8sWH/gAaV6AZAVvkQUozi2maOlooKDvIKU9sJ?=
 =?us-ascii?Q?G3tC8GnLJ0dhS63ElIpDB/JAtu/x7Slm/olRqFlYf/70cFQaGZ+ljO3zVqYj?=
 =?us-ascii?Q?NBvFC0X0XNyuHmQxmOIzHqbxsDG/aeFhSn7e7PNgeZ1rhtd19ADLvx1VV2y1?=
 =?us-ascii?Q?z++eRarzMcbaiRugj+26M6dTkfgAVGqTWlE1SXgc9CtrRRh2SYQmgeqz62fl?=
 =?us-ascii?Q?qJ5oW67cvP5OqVmLwU4NY0/oXn4TbORETWYldGU9ABsSvua75soF7RmFTXvS?=
 =?us-ascii?Q?BPapbjzx0k2zKivIIKHoa4dZqapnaXCKfVuu5NhGbgVM/tWqZTaJgbr7K1gN?=
 =?us-ascii?Q?Oa6DZSFkuqNI/51iu+0pp/s9lRvszg+X6ySruDs/RDe4pYyX/43P78dbx//4?=
 =?us-ascii?Q?1pJJdit8AQ8itfdKx8DMPRnOYmTh0HnGBSNlYQv7IvHlm7EcpCnOwpQGswpQ?=
 =?us-ascii?Q?iIdlrqUvkidvV0LV5T+eQOhIRZquv7UgPXf17RQkmsA15Nduj0eZisxC+Jf0?=
 =?us-ascii?Q?vW0ijP1tWPj73LAYRyB2EBznpkHBaG3mV4uWiG6kLUGim/N8YokxQFNFwjLE?=
 =?us-ascii?Q?PNsWtfmWVDfVwaJ/LyTMuuX8dCQyENRb2WkTzpfpAAA+lYmAAnq/93K67jGI?=
 =?us-ascii?Q?j3gcaAvgux+G+s/oEHHJuM7ukhGQe8vUvhyugGtHxuW2JELPRR+HlbTFyzM6?=
 =?us-ascii?Q?CUm1965raropdnY+tw85j6wFW9rsHKEKEAsYnHmSCSECnFQytmI1seC1qS2w?=
 =?us-ascii?Q?SN8eJv0YJWgFJynyJ29jPdEb6GCmmy75TffSV3FHLxqq1vuIyIsjZgv8EBGT?=
 =?us-ascii?Q?3wX1o1CKcJWqbajv3ypPuuLVWTp2ZJqLMTcoeZzKKONrWPyTSssVju+FqyPT?=
 =?us-ascii?Q?jWWiCoOWJQ1OE2qn7rG5gh+SSEijICKByiqOJeCB0bJbh0fPbHjGuaRK8GFT?=
 =?us-ascii?Q?YRYIYZu8tfVQiE5uDEsbaSRPxg13cSEfCPVgnYrcy1rBSWlHvppY0fXb0jyH?=
 =?us-ascii?Q?P1Vg6ggXnnjDsBiZi5wuiBMhob0NT5lPQJQe3kNrqmidTUNELCMOhdLwBBiO?=
 =?us-ascii?Q?/XbieX64pwgl5H6nGR+2lzR8J+JlFtouhLiCUZzONjAOHcrw56quhpCK2b3n?=
 =?us-ascii?Q?db7G8K7NIrlGyxRV4aosOi6E5hsbenBKHY6B2ixKp84GrUWCX0J0flEzjlis?=
 =?us-ascii?Q?ejG1HV9HAZPlG+QZsdskFj/A/WuUIldaOrxaUI9YLHSFtqSJIFE8V6oKjtXb?=
 =?us-ascii?Q?/XIE8qo6ufs5hDFKWl5+m+j+ysqKTdqQk7xDoVYHaCDszw+0DVIrmdk1Csz4?=
 =?us-ascii?Q?JzDmv60/KadP8cMa6yEvRLdHyhVNr6FD8lfE58cWMB1+UrLboOR6oBPnBoTv?=
 =?us-ascii?Q?pOcuzmBaeEYANGQm6ab2fxoNXuUe?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6be1bbc-7ea8-4f36-cdf8-08de4868c960
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13834.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 12:33:23.0331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7303
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

This patch series will add a new SPI NOR Flash chip BoyaMicro BY25Q256FS.

datasheet: https://www.boyamicro.com/storage/upload/pdf/BY25Q256FS.pdf

Shiji Yang (2):
  mtd: spi: simplify the conditional compilation of quad_enable feature
  mtd: spi: add support for BoyaMicro BY25Q256FS

 drivers/mtd/spi/Kconfig        |  5 +++++
 drivers/mtd/spi/spi-nor-core.c | 30 +++++++++++++++++++++---------
 drivers/mtd/spi/spi-nor-ids.c  |  7 +++++++
 drivers/mtd/spi/spi-nor-tiny.c | 29 +++++++++++++++++++----------
 include/linux/mtd/spi-nor.h    |  1 +
 5 files changed, 53 insertions(+), 19 deletions(-)

-- 
2.51.0

