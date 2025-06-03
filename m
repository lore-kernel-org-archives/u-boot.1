Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27EDC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08BF882CB9;
	Tue,  3 Jun 2025 16:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="LAWBtah7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23E9E829B2; Tue,  3 Jun 2025 15:39:09 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29A8282145
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 15:39:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTsJ61nRwE22bwDin8bNUWt5ofdasoc6qTwJdIahouQTmdqcXtsNSx/FuxIntszEhgGeC8uaMAIJTKdB2OCKXPTAfDSxmzpJfnuZQXBhM+a27jmre/xZtBZx+vKQBL7UN77UUu5MCOGFdTd7UJO5rTcPwgum/XfPUVfSklD3QccLWEK52j9VAANzPqGQYDNWAgPKLmyVLJpltrjrMm/F1nQ08tJbMmPF4/bHXkyZ2JZHElJA0inwhLOQo8GtlmyT5v62tMkqXNL5522G+Oa0fSLPVbOaURCxBNJ9xKCKtxKk1keGzegi1WQGv/d2IrhpyY+4EnGdQ7O5w+BMiImjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ip3T6EPj8x50zfSDZjV2ERNm9o1wvSP0VkTAJavlLRQ=;
 b=yXuRiu7+44788G2mYdhbkF+CeDdWZcdLiIL+LpcmblCecbjww+TLBlACf+17h6KLkF75UKsj8C19jHIJ1T/oxDhxHaqJhAS8XG6ziu6sQvazSjegz/cb34kPk/R5k2UYMIOMr8Mu1s5Jhdv0mQuhR//NouHwY3ENxlw0OLGW9K7ZyiXNKvzuJnsru67h4aUhi3RtF43VlRkFedxnCeeZSVcae80q4pFfMSyXyx+NsBN7t1Pc48rYS8CPUOqvRV0uOCTu+kYPusvHEeaWrbdDuhcjEjw71OmC6zRBWi/DvZHHpLaQOVaJraFynDjuPYv+jIeBjOB4QjsNzRtj0Wt/rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ip3T6EPj8x50zfSDZjV2ERNm9o1wvSP0VkTAJavlLRQ=;
 b=LAWBtah7VmR0BNKVWAh8i/8rIJh9PIne97NSiRFaPiVvyaVi1JIlQyULJefILOjn3q9er3YQMzJQgYCvQDiN21O1vlutP7t5BC3y9mK68cc6+AVl3jbPxCfKUl2OC4w3wFbX5+QvO/Mp4QrjfrPf1gd+q80vw+LhN9g1oxDlvH7miQO5snZGoSCc8E0wvXf4cZtf/CDGCTDI6uEdc/CuyHvtnHTBywquuzMAKwPCKWsKTIMajDj4E2J0qj4JkYdyIoDtINLwTAwE8zJxtPT2T42VTzVuSOfbZfWWvxESuxuz4X/IEgsO03YyzjMYpm6B95/w5fkuRhhViu8p6q7s4w==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by DB4PR09MB6623.eurprd09.prod.outlook.com (2603:10a6:10:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 13:39:04 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 13:39:04 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH 03/11] pci: xilinx: Add probe function and improve memory
 region handling
Thread-Topic: [PATCH 03/11] pci: xilinx: Add probe function and improve memory
 region handling
Thread-Index: AQHb1IzfByTWxUTGTkC/IgMX8zBMMA==
Date: Tue, 3 Jun 2025 13:39:04 +0000
Message-ID: <20250603133744.278790-4-uros.stajic@htecgroup.com>
References: <20250603133744.278790-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250603133744.278790-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|DB4PR09MB6623:EE_
x-ms-office365-filtering-correlation-id: 93e0b48c-0bcc-432c-2895-08dda2a401c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?k3eHbU9ykA3/WIQ3uplQRQyTVS1POR8Mt52GpZqen+F/V3lqhQg0mwQ4Ca?=
 =?iso-8859-1?Q?2hkvJyvFp2wTx1PHG7vc/osV9/7RolXb2IRrB3NuAdj/YstDh6KJnYKSNS?=
 =?iso-8859-1?Q?BeV6BhZSeV8CTDX1QMMCI320bpfZhmID6qLufCg6vlc3opyHOqE2AWKRfk?=
 =?iso-8859-1?Q?Ar0ZBrJqODhwyFDakvPaXJPLLAZqpYQpDd0w9vJbDcI6SbJoPaTDkTr1qq?=
 =?iso-8859-1?Q?U3xkvuG/YkA8WIZiUmfKqexIi0bNXgYRk4nja1YLqeypLJxQUCy4tB2ajN?=
 =?iso-8859-1?Q?3XLjia4ggS3MIcMchT8At1qsPV1EOB8ITSE8D3Dx57sdjsfalqgvw+/DEf?=
 =?iso-8859-1?Q?ODgxVwIplDsXjk4wTNSoKysvIT4IK07SfgnkmBpPAGnjmPyISImRTEF+B8?=
 =?iso-8859-1?Q?NEtaW8H/9SdaC67+1p3PCL9pDgzTkE5IbzaZ6dqm6TtOJSTt/TUBQEj1D5?=
 =?iso-8859-1?Q?QCUzvE6YPA4J/wP8qtgiJ/iMqOUj84wj8dSEb+dvP2/xMyCB8kZbMASYf5?=
 =?iso-8859-1?Q?32DHz53U8QyVHfPE8hp9MA5BwjYaXi46KNDDZG2eX9Tivsf7MLUuK18rWR?=
 =?iso-8859-1?Q?tZ8gejg5adR0QNO3PfGFbSq0ftFmDk54uGmN7i7TR7+uPZTLKSISDvaV4Q?=
 =?iso-8859-1?Q?BYOMljsNFDwEXbW8/EYSeaOURijAHyjCDGd/b6zXR39PatZKw3WDvS3CnG?=
 =?iso-8859-1?Q?9U+LH1H8aC++iUIGBBIm4B1Fz/rx8PAmXLdt4NKP7oCDrrY3FKXyEol0ko?=
 =?iso-8859-1?Q?e+mUDIvEXI9orvQytE0TcejZevWHmmrXLxFvPf/zRcBuvZlRq8LhmgQMlR?=
 =?iso-8859-1?Q?6GikUHcwmS1SW0szEhhL9e2nY5HkWyKAffGo0QMY5JXkhwsLsv+9Zd5qjC?=
 =?iso-8859-1?Q?QQAUuIPzm0sAya57hVugHVL8Ae10TXJy0VSm5FHP3Ad9XO3jhLgEo14oAL?=
 =?iso-8859-1?Q?Hgy4OeZVLfB7HVVMx5/sm6wjf8m8TsPPVagkZH/sbbxjTDCv57CI8HnUob?=
 =?iso-8859-1?Q?vDkFBQJ/QvgnL3AW36kpb7uyEIw5G9b4jPGwwOYS3IHKWA4sLgBEtvt18V?=
 =?iso-8859-1?Q?sSCzUDbonNLAn/54XHP8MpKvbd3FbWLPgcm5FT4llscQqODzKJMNKa1gyl?=
 =?iso-8859-1?Q?6ixszqnHoWV3K2dtJtNHj/UkYwAQElHqSMn/RoxSqlhTx5/o2nbd8jGI7/?=
 =?iso-8859-1?Q?nSgmbt+CJdfhAt91hl7fUmFkmjbyE6uZPGfuSKPN84bZgZZ7UreQvvy/aC?=
 =?iso-8859-1?Q?7gLGEtOgUuUC1LEXyOotiNgWEA1TauqJQVzYqI2lPAG+TyUpSV/P4hSBPb?=
 =?iso-8859-1?Q?2oz6UvxWwA5zBK2/LS5GU1oIAJGMBxXU6zRoo6ENNOXSw8hhcZKhq57Oln?=
 =?iso-8859-1?Q?MPCTh3UscZWUsKWVZ/ZngPTjN2rAlDrKTedtpX41S7mLami+om3kKb2bcP?=
 =?iso-8859-1?Q?PQXgXxbEhGjAGfJKoMbrNn1bZzRh+Z9yTHB7s0vBpWIAsOcMJXfnqBFr6u?=
 =?iso-8859-1?Q?qe79UggwdZpKB+xEmdy7VoQmy7MRNlsJGLo9KVNJtVbwCHMGX9CxEGmRiI?=
 =?iso-8859-1?Q?izCj//E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?c3qXdy2set9jeUYc5NCHpRbJ5JmpL1xk7dsgbkcJ9KF8/c9KavECUMJip4?=
 =?iso-8859-1?Q?42WaOVUkv43b4+NhXZAiTH5f1YufL5Y+43G8VadmvJHRY2voo5HZrsE0Nj?=
 =?iso-8859-1?Q?8YwsykPrYs+OI2OO7s06bR0n4TaXFaZcPWkF9d9yDyoH7LvQutjBD5oNpg?=
 =?iso-8859-1?Q?FE3cwpmYA0INWp83RK3qg1O5xOUjchpwiaudztx+olK/4XslKaYs/a5x/h?=
 =?iso-8859-1?Q?oSVXXI8Y9HklIt00LZBmlbMCm+j9rZ0Nr6LngsYfV4l9oyF5yMgCxP7qlA?=
 =?iso-8859-1?Q?kd/Xs/CBhqloaI/3tAuU60LsmcDauu0JLnb2DRyWWnWNgCHeOTX0W3hUG1?=
 =?iso-8859-1?Q?wK3TNmBfW+yeZPUBBUEO5udphPTuC54Vc2tYNWMm04R5YdjSYNIKsUpvOx?=
 =?iso-8859-1?Q?rmKIfByQDMjksagw7klJXHlWZN1tzxOMSr0CozC+GXRJL11QAjd0os4uiS?=
 =?iso-8859-1?Q?oEueCJmRP82Sb4+fJWHYoxb0vQ37ABmNDRTsun7sykYxgDZgGxwFHZG0g1?=
 =?iso-8859-1?Q?b3c1e8Z3jEGHeHTtYz8P0smK+xRsahKmUH5HcuWOWVUW9YvaRFrkmPCT38?=
 =?iso-8859-1?Q?cl4oNrur0ak3ZsDZ7OiC6zKXpwveAXE17d344cus0BbTLltavvFbzQGjGt?=
 =?iso-8859-1?Q?0A2lr664/3Lu0WN21E7gWWobRo0fGebBo6YLQfj6RwX3ql3HS8ZF727fdf?=
 =?iso-8859-1?Q?GURfjy1zNgwrjIfw7xiboDbm/Ijfj5CloLFVmlkR+1p0nmsfZGnyiIaCR/?=
 =?iso-8859-1?Q?VspwDab81WTbkINQeXVUYK/bOIZEvN7FZpRiGN3HXZt4u2+sYvA70DDgOx?=
 =?iso-8859-1?Q?/jo5ClMrivI8UvlYyLLVGNLgjpoaqx4nw9rRu953F/DHtZVnNofdek5Hug?=
 =?iso-8859-1?Q?4PLlKRTGJ1XT1qVH3LKy97WL+y+FIyVLMar+lSx4gW34ICN0ljBk/V9EaO?=
 =?iso-8859-1?Q?FrPDk3x1xzU2bn4PrXuf/v6VHzb5YzHLy/z6JFD1zGQpR5JYDpwbcZdL9U?=
 =?iso-8859-1?Q?EAzhaDRA77zHGDiWnt6fJMf0WrgX3n+T4+VxtrkGeY9j8wsKho5SOojp8k?=
 =?iso-8859-1?Q?ZJ9HC43DohzgHmsMlcwapKarKLBxLIr8NFfLEzsLhFggYIIn//2+fGFjTi?=
 =?iso-8859-1?Q?UxP6aF0GwquT8PF9BoBHNWUFaIUWLRRQqJvJ97cDq/50uEA1oKM2gMlnvQ?=
 =?iso-8859-1?Q?pqU1vuZ+eHhYIv/fXIc2Bkc9ua5eOATk5eh0wVHY4aMQJEEtxknQpFao5R?=
 =?iso-8859-1?Q?H38iqQuhJLuSO6ttlvV/mnlLIgqp2ch6lvaQMHQo8SEJ9psMJZd9Uo/dX0?=
 =?iso-8859-1?Q?w6/0N0uDuy9Z8kwXpDo9iy69r1hAZWbefK41TxuvcpD+zGse9kseX+jZ6H?=
 =?iso-8859-1?Q?2FXfHEheZncfgH7FK2S+iV42Su/34NYve53bsSGmXiihsfdseAN9Lw5Brd?=
 =?iso-8859-1?Q?PN5JRiMAI4zX8gdewe7FQqTnx08ZbxWzk0wFJ1qkr1OY8eln3vKrIwJXuZ?=
 =?iso-8859-1?Q?pqnY0ZHQgRfGvj4N56h6TP/HV8O7a2JlWmowB4eqssw/v2cmZvZxGBBewW?=
 =?iso-8859-1?Q?sl+4c+hRe2mLRjKSC9L5xi48wBNMK8YnZKBlPYjMpkZg6i8FbUpsA4JXtV?=
 =?iso-8859-1?Q?kdTPelLcUuzxshfFXppRO5soP3efXOstDd5u/bU+qVHss9QaYq6SbqHg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e0b48c-0bcc-432c-2895-08dda2a401c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 13:39:04.4308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKVSFmSfDpTgJw5KvsIBp2SyUngOS6swzmAmxitU7apgsTlsatLoSFmbk8+I0GZYk9Y8a1jtEtfhO6h00dmr8IaaTlVCB9NWbrO9NmZpyZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR09MB6623
X-Mailman-Approved-At: Tue, 03 Jun 2025 16:44:26 +0200
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

From: Chao-ying Fu <cfu@mips.com>

This patch adds a `.probe` implementation to the Xilinx PCIe driver
to initializ bridge registers and determine the ECAM region size
at runtime.

Additionally, writing the PCI memory base and limit registers is skipped
for the root bridge (bus 0, device 0). On platforms such as the MIPS
Boston board, writing these fields results in incorrect values being
reported (e.g. base =3D 0x0, limit =3D 0x1600), causing Linux to fail
memory space assignment for the bridge.

This workaround allows a MIPS Boston board to boot Linux & let Linux
successfully probe the PCIe bus & all devices connected to it.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 drivers/pci/pcie_xilinx.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/pcie_xilinx.c b/drivers/pci/pcie_xilinx.c
index 63058e8e7c5..3b6a8ced848 100644
--- a/drivers/pci/pcie_xilinx.c
+++ b/drivers/pci/pcie_xilinx.c
@@ -132,6 +132,15 @@ static int pcie_xilinx_write_config(struct udevice *bu=
s, pci_dev_t bdf,
 				    uint offset, ulong value,
 				    enum pci_size_t size)
 {
+	if (bdf =3D=3D PCI_BDF(bus->seq_, 0, 0)) {
+		switch (offset) {
+		case PCI_MEMORY_BASE:
+		case PCI_MEMORY_LIMIT:
+			/* Writing the memory base or limit causes problems */
+			return 0;
+		}
+	}
+
 	return pci_generic_mmap_write_config(bus, pcie_xilinx_config_address,
 					     bdf, offset, value, size);
 }
@@ -186,6 +195,31 @@ static int pci_xilinx_probe(struct udevice *dev)
 	return 0;
 }
=20
+static int pcie_xilinx_probe(struct udevice *dev)
+{
+	struct xilinx_pcie *pcie =3D dev_get_priv(dev);
+	u32 bridge_info, ecam_sz, rpsc;
+
+	/* Disable all interrupts */
+	writel(0, pcie->cfg_base + XILINX_PCIE_REG_INT_MASK);
+
+	/* Enable the bridge */
+	rpsc =3D readl(pcie->cfg_base + XILINX_PCIE_REG_RPSC);
+	rpsc |=3D XILINX_PCIE_REG_RPSC_BEN;
+	writel(rpsc, pcie->cfg_base + XILINX_PCIE_REG_RPSC);
+
+	/* Discover the size of the ECAM region */
+	bridge_info =3D readl(pcie->cfg_base + XILINX_PCIE_REG_BRIDGE_INFO);
+	ecam_sz =3D bridge_info & XILINX_PCIE_REG_BRIDGE_INFO_ECAMSZ_MASK;
+	ecam_sz >>=3D XILINX_PCIE_REG_BRIDGE_INFO_ECAMSZ_SHIFT;
+
+	/* Enable access to all possible subordinate buses */
+	writel((0 << 0) | (1 << 8) | (GENMASK(ecam_sz - 1, 0) << 16),
+	       pcie->cfg_base + PCI_PRIMARY_BUS);
+
+	return 0;
+}
+
 static const struct dm_pci_ops pcie_xilinx_ops =3D {
 	.read_config	=3D pcie_xilinx_read_config,
 	.write_config	=3D pcie_xilinx_write_config,
@@ -204,4 +238,5 @@ U_BOOT_DRIVER(pcie_xilinx) =3D {
 	.of_to_plat	=3D pcie_xilinx_of_to_plat,
 	.probe			=3D pci_xilinx_probe,
 	.priv_auto	=3D sizeof(struct xilinx_pcie),
+	.probe			=3D pcie_xilinx_probe,
 };
--=20
2.34.1
