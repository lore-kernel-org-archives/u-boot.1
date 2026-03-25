Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DC5FEA83E
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 11:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97EAD83FED;
	Wed, 25 Mar 2026 12:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RHeOz34h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3006084020; Wed, 25 Mar 2026 12:23:56 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39ADF83FEC
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:23:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTh7miFWUsQ9fgZCnVaGOb/jAOugofVcv2L7eIHCVJCxq7wQ8GPqKhAQs/O+zrbJxfqYnEXQxcZwdcVfTOe/eKJn7XpkQRTaDQZRmhAMpgctAgTlRfeWYKVt7ht6Hso6eHaC7NWReY+BCTWgIU0Z65/yGNBQ9zl2lQLrh2GM2hvUq5cKrVou16G1oy1th0lPOEUSCaBgUA3K5JeeVy608JejohpU8mlIFk6Rj6KQyXZjqSduFEdOoqM3QMoskLo11PfbBczqcmCF8UY+CPSkzYIurQntTUFP48T0lqwZ1iPav7tb08e05X1yQi7LUM+QJFB4nxQnIpNFvBhPqtyPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMkhNzKfmi9qvBDrye7hioi/55QGYx16ahhup7i2wec=;
 b=qknINrahA11asgq37qGbYRkbpLjv88cJEUDeOJ8xOkWHiqibJdc5enXVceIg9IElvgrWhOlTsLOr9nxqY4f4wa81qQpMoUeM/Xulkc3fhDuRIouSF8XQD94uo3OJCBdE7SUJD6P8Y4oTvrVYLhVzp4LOz1VLFQfV+BZhEnpm6xL/Ja7ZipZmJBzJjq2IBG0wpo/rg4FipLgqEvALzPGit+wxsYt6ue8CRpAmvsd3yJWv0Cib/Xko5FuoLVRH/vSuskursOY24wtwXFOMmELuVt0ijl3mzg1MbCe+QLQ7adFr+o0zGCEEw9EsMZwClxjPsPrGyADIBv3VlbaUDRHTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMkhNzKfmi9qvBDrye7hioi/55QGYx16ahhup7i2wec=;
 b=RHeOz34hULYiwho0GzDFnXeqdxnnWC8y8mh9a1TRy5mqVNYMAoii2VJxO8Wt55zlO+vYelEaL0SNAQs2cVjOpf7rt7npEtk9R1C7lzCxxRhwdzJCJkFMsm01j+NEzuLIhxUz3e4upmy9CnQaASsQfarmQC39yD3who67Vqmk699GudImrixQU8DTYKoOELo4TcxiDC0DXBMGdQ6U1V1eo/3O3PKfK++xzRpuhiyzS3k8jKmfvvQbZ6ET+x8xLE0no5XS4i2y99PeCuAfqM7ThmruxWSrTiR6lPto9bikQ5OV4iUj7fkAwjYrwam+Pc9hwX9F1yL5c/AdJ6fyKSZXeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8293.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:23:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 11:23:30 +0000
Date: Wed, 25 Mar 2026 19:26:04 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 5/8] arch: arm: dts: tqma7x: add boot phase properties
Message-ID: <acPGTNcTSYmseDbw@shlinux89>
References: <20260325095801.47706-1-Alexander.Feilke@ew.tq-group.com>
 <20260325095801.47706-6-Alexander.Feilke@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325095801.47706-6-Alexander.Feilke@ew.tq-group.com>
X-ClientProxiedBy: SG2PR06CA0224.apcprd06.prod.outlook.com
 (2603:1096:4:68::32) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da0a8c3-913e-4cf0-c6fb-08de8a60f171
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: EWvlBPKSaTJ8McRXS2j4Sp+baoXCPmeGTiax9OlUxjQrUcezHyZ6bmil6WeKRPA7rBDv42FNaLO2AeZCfZ39rJsRC4mTaLw8rmQn+/wnesT9zmrYH/dym2wm1CKLwYhbvg1FcRsiHQFugifhLr4b4Rk7Cg676f+3s1vUUT20291Lb57wTdGKQcTH6os1ToBmhfSWDnUIhwItJOHlqM2yRG/CczMTD72HJQMglieZBNW6XwDaOBTU+NnR4q57mKSsAnbb4gJlRdsv11jTJ2BDDV6SyrydO/ZFLfPKzr86WPFIu1lkqxe0wLAS/C5uZelOlJ4VJVXel+8JXWiiWnMbOX2EZ8i0BFrI+ZLGQygoI6sN5j5Sbqr6avyH5AS7Q/4CNPafptuC6oGZaFXp4lHDUHMRaqchTBRKe/1RHieNw56PfsWnCsGkd+eY11rEXQH4X30+c1K2pM1+oCXdQUHd406bja2DjSM/un82bB56CEzaLBnNTxXCkdg4CEwxFpruPP1g/U/m+b7lnaZEzlRgXW9ZVLt17nIgOI4dMKJyDjNYhpQ9dsdH+qQD6YJ1YBluo1Hnl7575cgk8dCjSLZiHVfklxrWc71ioM0qZ/gCDtKU5WhJden7D0ZEMmeKmB985Sueeinh0mXSqXgKediNJw1zdLTfna2FipantAL0j8dt1dZ/ecG3FyHUlq7fZdNt1efp4CMaVeCklEMUmVBLrK7Fx8D5t4WL1FO1q/453aapyyb/47tiOFIISuLTcGiExjw8M98jUJDxGvvMzSawIjiim3RSidH8LZLAXnQOWZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V0FGLFCX7AQdSOvLPv0mIeoaJLLhV+c/i6dJKMxRG2D64JyGKoTXL3FdPrmR?=
 =?us-ascii?Q?GNrYLqvqgiR49GTOJB8WRnY4HP6JDxG0qJ86VquK3HqUVDmaaBxJrhQsYw6w?=
 =?us-ascii?Q?zttklpp/uYqU4rekPvT0wlXDiScpu5IGs8KmJjzrdgOtk0HJy6fRrHkSTS/Q?=
 =?us-ascii?Q?f2Ndr+0NaQMGcUkVWTdQ71k3DvuJ2Gm+YNhRC7ft4cx4AyDjJ7nqHatKIceu?=
 =?us-ascii?Q?npJTp3FuC25fT2HRFXbui28OLYlvUtRBXcSsPAHzpShcga7L293zcLHZ1X0h?=
 =?us-ascii?Q?gQ/tTJXUV2ZsAxN7l0LwtpA6X6ufsusbm+itJfBCw90mr17INwBYV8Ea2Tky?=
 =?us-ascii?Q?40+r59znMXAHTAWUpjwVOnd0+KLFj3QPOziq1Y8kvH6pruqdKIPmUKMGQqnO?=
 =?us-ascii?Q?ToZpXgJAZDmPlesbWAh9E48B52xuuzatTErpDfNCYsi9C9wwC+uREyE8I92h?=
 =?us-ascii?Q?ymp865aHLjSJmbOc+RiikTcJMd22X3bu69BV+IvUjkct+TDjlSDVqGr0KYNw?=
 =?us-ascii?Q?IStAkLFVOyNz6ypYQIjOR9nd1ZnV5MiUGjtHT2wGTfpULOTYHLvtcT46US7M?=
 =?us-ascii?Q?Pdv2NaZnit9PFx1eV16JIZspqG7cL01P6nM/lenwCpO3yHBGx9NM5vn4lTVY?=
 =?us-ascii?Q?4d0Td12ualH+WEWxBdolP64tkwcZ7+SAnJ+VyetOGlHR/uLcvZfrjIAjG0ax?=
 =?us-ascii?Q?aXrQMaJYxN1PX+e4FdIEX2LKwY1F5o1K+7IcpqGZNN+iN6hAIKppCWF4HJj3?=
 =?us-ascii?Q?fN+pKaaruXoll3cMQDZQWs8T2XxHgIdZCxd9628LV7Ho4wbTUZHuYmtHlii6?=
 =?us-ascii?Q?iqd1lr/Tdy0oY+9WMNHOdaF1q4g38iwkQmQNsIbrIpK/rHOtrufvNjayeBeZ?=
 =?us-ascii?Q?DFhSmac9kmCFDVxzWXWbfSFnEjIb/9JyXCAunSY/PTirqPdzrUoa8Ycuy6Bz?=
 =?us-ascii?Q?nXNd38F4oIJ+5fgK0yRjgfKXDN1TmfzLIKxBfVxqiZOZe1jaKAYHPFd2stYW?=
 =?us-ascii?Q?QAOLdtWGsq62uFozdn7oMzFlKi+RzfPz4mkWRpr9OpAHGiXBNpdo7Yjp9c+T?=
 =?us-ascii?Q?TCVZJhJ/smGY4liG7P41k5B6M5NP4jHjDFLpZtS/n5McLN4ereoGiOuS69Hf?=
 =?us-ascii?Q?CQFUGZn1jkomTTWlVdU7zxWepi8mqP0fwqjUS8Ir3NUt7MuEQjr0OcN7Tc0p?=
 =?us-ascii?Q?loChlxsLFv5GC8/CZsbp4/CCeVjCjp4tQiFzmfTVzM0bgBm6KtxYa4fLJtZr?=
 =?us-ascii?Q?42w2IjPL9VHcDmYYpHIM3yh6ScLLV93c1iUb78uoo5PtFXpwuQpt9e2wQmBc?=
 =?us-ascii?Q?+9lbDMzv0FtRv8ErZ63z3jHCKlP/UNQM7aQZc2xRDwxbl9p36MxYj7F/vo7j?=
 =?us-ascii?Q?h2RYMQGJ0MG+xzn5Hj/jwPhuV6qN+XBRooi/rkGxcRUPIduHOo1o5axtkco2?=
 =?us-ascii?Q?qwSNcuf3VDCXIKlpnpgn3hzUDqz1vJtBzTWKu0Ojc8HLx0wjSd4LqzHhLIAr?=
 =?us-ascii?Q?C4yXIC8/F93BYtIcrSS6LMTYWEaGQeA+yCxF9009GYPSXvwv+PYhdJ3ExqmB?=
 =?us-ascii?Q?YwSk38hesXoAZeanX6UNmXkANBsytsMzuzMPmDMdvXM3eG2WZfFxDkSo3to0?=
 =?us-ascii?Q?OBVfBX/CiG+9kDoirCt4Y/QWntQEeBkPXoev4KlKOYiH202KOuviMfXlEPkI?=
 =?us-ascii?Q?MWUNl5psEa8g65bDZAD/X1x/PRIC+xLjU+nWPxorfObANGsSCV6VN8J/M4Md?=
 =?us-ascii?Q?+7w0bCXIew=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da0a8c3-913e-4cf0-c6fb-08de8a60f171
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:23:30.6871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kis/1lgnG/tlPfXJOmmFxMCHwUotrUqLvcL4Cjozf+1SpryrU8V05TViLKz8406ESbARdHc+edpYAqozTZhz+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8293
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

On Wed, Mar 25, 2026 at 10:57:58AM +0100, Alexander Feilke wrote:
>From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
>Revert this commit once the upstream linux device trees are
>synchronized.
>
>Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
