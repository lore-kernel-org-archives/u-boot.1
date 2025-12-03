Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858FCD15DB7
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 17:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D416283EB3;
	Wed,  3 Dec 2025 18:32:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="VtucyRhP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99C708402E; Wed,  3 Dec 2025 17:25:45 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46C1584019
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 17:25:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=anthony.pighin@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Skbl6+yWeUy2OWmcYk8BJSV94Qi0ZbsNycTc8mk6alidoeX/10FSLvTkt4N8QdELSDFf47IzyywdKhxI811MIs1CRMjVvWnjHizGTqxOk77gp+W7W+I9JbzrEDXYvZy6zx/u8Gd2cUexwM21H6D3DfaaME/Z/FyWmK3FP0/NWxZjy37S+HQ+HRMbQWfnDEarq8RV2HZ3VMTh6eq3cdr3bnR1Yr1iOk5mOwuS3iaQGTc+ENd3RzxCzZvEiG4Wd2UXkb7rPdftC/vmeqXhQfnIAP3waRBdzitiwLL4gpGPrHDgklvGXeXN4zlqxKRXQNty8WRXDd54PJVnU75CdlyHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttopbZrqSSFKl0AMmY/zMaAnkiZMksSEJS/SUKlzZfY=;
 b=PWQ/X8FTV1fTaaEC19GaxJ/W5bqAODjkR9rP+9/iNiayu9KrLYz8D2wms7SMQRoNLVkUL8VCtQugDgDvAN0OkvjuW1v02rbuVznK/m7eF06P07RireoSEGEMpj0cqIxEGfh+nwZlx6axx8yFrEsFxffus2m2bPuuPvWWAJ1hmWvRs1Hv2t97mzMfnH0IodGZI9Xcnfs2nCgtoV0aOwT90nRpK9jAqauXgN0uDgW9fdrJntF8xiW3kDyl3JhV7gWG7ceTKxeT8bhnQjV1K0ihQ2XXqzRE6lAwahl7mG0pPk03QFRI0ez6rkUivrh423ycXb/kcL2cJGpxkccQ1y2g6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttopbZrqSSFKl0AMmY/zMaAnkiZMksSEJS/SUKlzZfY=;
 b=VtucyRhP5WYxjCX4MP+Inz9+V/kP4i87k53xkwmNfxr7c86mvOW467jPIB/DvRZVazlP4weEGKRndxNKO7QELqc2te0zAZ7BNXvL4YC78Z+r3K22XLk0JSjW4GDn/J0DdzGpMKE5AKJ5C1O5DyFX5BHPUi2Waz526wEKTYLCUQXKsxV3j9NTHqIknCTgcyYUDiXtA9SduVBwYvonQshsgEKmGWRH/Zt7d+mDb4WPAkP204BFxlgsJ9LBqdOBqpzKVZPbUbh6unpIsabLvba9ZDJoZ3G+gd2ORLYdunQ3oSRj55GK4giDoUiK3GaxVcyoksl57zhIRNP7MQbvMlv+yQ==
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by CYXPR08MB9563.namprd08.prod.outlook.com (2603:10b6:930:d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 16:25:40 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178%3]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 16:25:39 +0000
From: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "peng.fan@nxp.com" <peng.fan@nxp.com>
Subject: [PATCH] armv8/fsl-layerscape: fdt: Remove offline cores from cooling
 device maps
Thread-Topic: [PATCH] armv8/fsl-layerscape: fdt: Remove offline cores from
 cooling  device maps
Thread-Index: AQHcZHFVeCa7FkAKDU+HAgIdcGRrbQ==
Date: Wed, 3 Dec 2025 16:25:39 +0000
Message-ID: <BN0PR08MB695168175B8E121E36076AD483D9A@BN0PR08MB6951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR08MB6951:EE_|CYXPR08MB9563:EE_
x-ms-office365-filtering-correlation-id: 4b47adc5-2631-4f67-61b2-08de3288991a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?phULDtnKiMCaV27+RHPGDGaNYpm4KdYXT6iF7f/frbiDvgSRZaAH0l0kje?=
 =?iso-8859-1?Q?uGZvFtCgG+OyZTc7lmCl4FXxmyB9MYYYn4HmIh1NjUbY4bjtbGfly4vBbX?=
 =?iso-8859-1?Q?rxAQL0B91t/Ycvamo0onyr4uFxQ2mGRqjgOYRIQ5YIt0nfCU1v8BGysd2i?=
 =?iso-8859-1?Q?2B5b1I0l7rQfVjHmFLDNC9T2zDWcOx0NDhszB44S5nWWQhIWSLZIeXdlDF?=
 =?iso-8859-1?Q?93mJLpsj8hC06CrUAhZJU2BxatnpcZr/XiqFffICXlpbTRdoEOy8O/ZOz7?=
 =?iso-8859-1?Q?PFiDgZeSG5XBzzz99Bse4FKiIjAJz+Gzvgu17SmlpTzgCi+NXIE1AkQRrq?=
 =?iso-8859-1?Q?ho5YAyTbdJL+TWzj4fRQFr6kHl5QRnYlYMfxGRjwKF7Bl9fGb0hJcWnCD6?=
 =?iso-8859-1?Q?iq9GfBVrx3aCk9We2cAx3TRCfWNmt0gF2Eizsjc/igecCoNuwkveC9LKHs?=
 =?iso-8859-1?Q?kKR2UM1NtGOjM52xiMOhWFp1ERDldDODG16l5rDZS3q11Gi5X4ndXSYMDC?=
 =?iso-8859-1?Q?QMqQ6TCry3udjqC7qeoX2ajjTLQ5aNSyC7tDW4vQ/m82ONT1MYtRWFyUa5?=
 =?iso-8859-1?Q?BrBcadW373/dfp803vYo8iH3mmK0T7DSgWAlGOgDpI7RWkuxq06cZiTiCz?=
 =?iso-8859-1?Q?qCQjupikBUpq2lR5YaQmBj8YgPb0MhutZyIq8kRYx/hOfpA+4ei38/OrGB?=
 =?iso-8859-1?Q?09wEiQc1a6/CsV7kZ+27Us3lfKBuLSjD3zvv937FSV6DdoLI4yyYVfeGRc?=
 =?iso-8859-1?Q?OLtLmxyeBfWNsCfK3kEgAZuZz2dCEC5yHRpADq8P4zrbo8oX08Ju09WaeS?=
 =?iso-8859-1?Q?4ifxzIp9RuEuqOYHtrceVKzahIIzz8EpTPBGZZwEncfHkB6l0SxOyhJ6Hz?=
 =?iso-8859-1?Q?e9PLWDnNhJcp4wJUg+2kmr/qmQkvTo+dst1YfWS/ZlgJkXtnO7j505VWKe?=
 =?iso-8859-1?Q?wsuC4VGr1sUhbjXRl76vav0vpYSRHfcKa4CD5hkpglF101mBJjXVwdeEFW?=
 =?iso-8859-1?Q?DHkANlXcRz9R8606DyfmI1cX/vLmefXOQvBMWa1WHVEylUAVjruYSBZTfN?=
 =?iso-8859-1?Q?dXfeAJxr5jhrJqz48kneJ4fLMjkZfka7k4eEvR6OqMgnjRADuBYrliefap?=
 =?iso-8859-1?Q?0T0KcUAuswMKNfNprWkLoTFy7TBpyRfs/jE/cKf68OneN7QL8drE/TRnxs?=
 =?iso-8859-1?Q?VOBluEiqy0p0bcX/fWJV092eIsPMpFI+bxS85xKA9WNrKqcPqBqrBrwWMe?=
 =?iso-8859-1?Q?BURv4veOdDrs//i7uGBYAZy+m+T+b7S5kAG9SsEBgN0EPW0TS2uinkE6FM?=
 =?iso-8859-1?Q?tTvobkRVI6aeCSi17gml7RH1asE4KK+vlYq7muMxnF5xXwUxAnKNtARs+Q?=
 =?iso-8859-1?Q?cUotjgN0d46661if58DWZCLDbEP06rPT7eQ1POcKEObwJoR2OBQKblPdKX?=
 =?iso-8859-1?Q?jrkGWB1jzPiekFN6wtvMeM8r7IFTqxrP+RBkkO1rWWxb+y73wXJj4smS9K?=
 =?iso-8859-1?Q?wfunMked+WZBnjiXyCH3VKkbjVFhGPeLWTId55V1yi2UGoL/W/k5fQ3Zpp?=
 =?iso-8859-1?Q?r8k3n96ZU1fyeyS34qawPo5JLkLg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR08MB6951.namprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/iUnuxdiJBKiaMI9lFfaenKpFVgQZhBp0UusO9zajWN1bLWDPvXut59eyI?=
 =?iso-8859-1?Q?P9PK7WQEP99uTyy6XFfJCyGz+kZzFsHJvWLgUsxdtQDXseR7GRoljyHhRJ?=
 =?iso-8859-1?Q?CDEXHIYcCDSFsOguhXU/5sVpLVutEAqUAK+mdJSk7sV4BDJomq7ynghz3y?=
 =?iso-8859-1?Q?QRwNUT8VCnJejQu2wdYkCiWIrMTCNStI3KjZWw2viLXC/Ly/VhkwAg51KT?=
 =?iso-8859-1?Q?4PPl9UDbXZd/qgPWVxYOZhNKN+yBvOTOrbW3wrpdBPPUZi3QMiikTEQQtq?=
 =?iso-8859-1?Q?PW/lkGhJ8TcyyAk7UHmC4rb2e97qdIalXFmQcmdUMV94EGAZsfWoJXQ6jT?=
 =?iso-8859-1?Q?CNLpoBIuiVBMteTZOP3e9KsRF5r+uMJNC45Ni61CM8DdZ0QiZfG+FCL9xA?=
 =?iso-8859-1?Q?+4Z5KqwzFdqNnqRDn9l6LUsRtvschUZNxDKs4tB9zFS280lEYXO6MQDzOS?=
 =?iso-8859-1?Q?nG4t+lxBJVTTxxDSflcrwXwe3D9B81+TGz4ZlD56IGLAYCXcGDOmaRWR7p?=
 =?iso-8859-1?Q?1YcuDw2gj3dIkRU6wB0u0bhAfP3wNHNFrWi5uJg3XgMrZSjwQdt+t84qio?=
 =?iso-8859-1?Q?sfxrb2hjdknI13bx3acnInmy1BLgJMqUzYyIKZkyVlS1iC0K6JHpKYHQwA?=
 =?iso-8859-1?Q?riaQ1ub60UvAibNX6AeKX1arhaRWalcwmO8com3D7otF7Z7zcDVRY4kdyM?=
 =?iso-8859-1?Q?mkgeLGwdHH1ab0F3YizHUT7XWa2r8HJ+XOgShHMVmFLMyhdJDNBDLX/Ukl?=
 =?iso-8859-1?Q?THYDqQ3EPm3kbz8iIJ1sqa6RLY5ztTtwknyPPMDaMTSrFW+g1fRZF+uy7r?=
 =?iso-8859-1?Q?TmRKmaSQsC3d/w0XvB0KAmedyqvzJBkLUleU8MGsjFUsLnaOHFJUPdxu4P?=
 =?iso-8859-1?Q?xh0uOJUYO7xVtIET+7qz7k4vLUayjb1X16VFvibhTMiyrGsuUybLHDH5me?=
 =?iso-8859-1?Q?1xTTSNd/RvgXMZBj8BH2xQGZprKN7TeTM0hed4lQMrK4Fz3JLehRpRAeXt?=
 =?iso-8859-1?Q?/uxl7yw/R/PRAUpiL41kYYEKL6QIMhXjyQWLJpfc+MT+fQJjMjm8AOzJw3?=
 =?iso-8859-1?Q?R+4hX+s9Domm6XFBej9mikNoor78BHh6ivLH8cRrmhps6EcuhMiguvmsTV?=
 =?iso-8859-1?Q?FWz9nCQqgudyV2L8QmoCydc42NqSimXvpP7Ms5JlZhC42YHqudwlf8anFq?=
 =?iso-8859-1?Q?NaEu/8EG8anbTCLIoDordUflh98NVvcK0+afV4Ib9TWW/bXSD0LlJbmI+n?=
 =?iso-8859-1?Q?dnmn9t3zI0ite/c6y7czpsy3UON6PrqFTU8SQG8n8kjGXBvm8Q+KAzmOjd?=
 =?iso-8859-1?Q?pLlPegj8OIaPtiIyPrJhEyZXCxv7M3uKxriTmy60CEaLJfWrq5rYp/qV/D?=
 =?iso-8859-1?Q?QaLT7RI5bCAc+et70q/vinYVnq2LzqBz1+l6VG09DpinLJpzoiRb8k4BfY?=
 =?iso-8859-1?Q?e9sMk1iNlCDyxOvSrq3XchAAL2HU1CkgK8LyvqHb6Rk9Jw2auNZjz+6CE6?=
 =?iso-8859-1?Q?R8ng8EkUQ37JSdq0rz7MY45549qeussiLDAiCWSOoOpAag11z6++Vxj/Lt?=
 =?iso-8859-1?Q?kbdw48NbCYalRyY4nLYDzGnPwFSbawL+Rhu5jHZ2jwuTgL/17OrculgBZO?=
 =?iso-8859-1?Q?ddlrDV/zChSydo5Y/Ff5qispmYl9eEemjJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b47adc5-2631-4f67-61b2-08de3288991a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 16:25:39.8320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jfplv4TXrxj9HeciJ1DicUmVqPDqEN7WnrtS12kyVWXYYRnvNKSR9XkwAH0pQyNyyyYvDXs8DpqPly5oLtK4GFv44X64GnTOxPrKQr2q/A0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR08MB9563
X-Mailman-Approved-At: Wed, 03 Dec 2025 18:32:26 +0100
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

Some processor families use a generic device tree, and rely on u-boot=0A=
fixups to massage that for lower core count personalities (i.e. NXP=0A=
LX2* family). For example, the LX2160A device tree will be used and=0A=
then modified to offline non-existent cores when running on an 8-core=0A=
LX2080A.=0A=
=0A=
However, the cooling maps still contain references to the non-existent=0A=
core phandles, resulting in:=0A=
=0A=
    OF: /thermal-zones/cluster6-7-thermal/cooling-maps/map0:=0A=
        could not find phandle 15=0A=
=0A=
Rebuild the cooling maps as non-existent cores are deleted.=0A=
=0A=
Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>=0A=
---=0A=
 arch/arm/cpu/armv8/fsl-layerscape/fdt.c | 57 +++++++++++++++++++++++++=0A=
 1 file changed, 57 insertions(+)=0A=
=0A=
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fdt.c b/arch/arm/cpu/armv8/f=
sl-layerscape/fdt.c=0A=
index e8d2339f1a3..bd33969d569 100644=0A=
--- a/arch/arm/cpu/armv8/fsl-layerscape/fdt.c=0A=
+++ b/arch/arm/cpu/armv8/fsl-layerscape/fdt.c=0A=
@@ -12,6 +12,7 @@=0A=
 #include <asm/cache.h>=0A=
 #include <linux/libfdt.h>=0A=
 #include <fdt_support.h>=0A=
+#include <malloc.h>=0A=
 #include <phy.h>=0A=
 #ifdef CONFIG_FSL_LSCH3=0A=
 #include <asm/arch/fdt.h>=0A=
@@ -48,6 +49,61 @@ int fdt_fixup_phy_connection(void *blob, int offset, phy=
_interface_t phyc)=0A=
 }=0A=
 =0A=
 #ifdef CONFIG_MP=0A=
+static void fdt_fixup_thermal_cooling_device(void *blob, int cpu_off)=0A=
+{=0A=
+	int cnt, idx, len;=0A=
+	int map, maps;=0A=
+	int offline, phandle;=0A=
+	int ret;=0A=
+	int zone, zones;=0A=
+	u32 *tbl;=0A=
+	struct fdtdec_phandle_args dev;=0A=
+=0A=
+	zones =3D fdt_subnode_offset(blob, 0, "thermal-zones");=0A=
+	if (zones < 0)=0A=
+		return;=0A=
+=0A=
+	offline =3D fdt_get_phandle(blob, cpu_off);=0A=
+	fdt_for_each_subnode(zone, blob, zones) {=0A=
+		maps =3D fdt_subnode_offset(blob, zone, "cooling-maps");=0A=
+		if (maps < 0)=0A=
+			continue;=0A=
+		fdt_for_each_subnode(map, blob, maps) {=0A=
+			if (!fdt_getprop(blob, map, "cooling-device", &len))=0A=
+				continue;=0A=
+			cnt =3D fdtdec_parse_phandle_with_args(blob, map,=0A=
+							     "cooling-device",=0A=
+							     "#cooling-cells",=0A=
+							     0, -1, NULL);=0A=
+			if (cnt <=3D 0)=0A=
+				continue;=0A=
+			tbl =3D (u32 *)malloc(len);=0A=
+			if (!tbl)=0A=
+				return;=0A=
+			idx =3D 0;=0A=
+			for (int i =3D 0; i < cnt; i++) {=0A=
+				ret =3D fdtdec_parse_phandle_with_args(blob, map,=0A=
+								     "cooling-device",=0A=
+								     "#cooling-cells",=0A=
+								     0, i,=0A=
+								     &dev);=0A=
+				if (ret < 0)=0A=
+					goto skip_update;=0A=
+				phandle =3D fdt_get_phandle(blob, dev.node);=0A=
+				if (phandle =3D=3D offline)=0A=
+					continue;=0A=
+				tbl[idx++] =3D cpu_to_fdt32(phandle);=0A=
+				for (int j =3D 0; j < dev.args_count; j++)=0A=
+					tbl[idx++] =3D cpu_to_fdt32(dev.args[j]);=0A=
+			}=0A=
+			fdt_setprop(blob, map, "cooling-device", tbl,=0A=
+				    (idx*sizeof(*tbl)));=0A=
+skip_update:=0A=
+			free(tbl);=0A=
+		}=0A=
+	}=0A=
+}=0A=
+=0A=
 void ft_fixup_cpu(void *blob)=0A=
 {=0A=
 	int off;=0A=
@@ -73,6 +129,7 @@ void ft_fixup_cpu(void *blob)=0A=
 		if (reg) {=0A=
 			core_id =3D fdt_read_number(reg, addr_cells);=0A=
 			if (!test_bit(id_to_core(core_id), &mask)) {=0A=
+				fdt_fixup_thermal_cooling_device(blob, off);=0A=
 				fdt_del_node(blob, off);=0A=
 				off =3D off_prev;=0A=
 			}=0A=
-- =0A=
2.43.0=0A=
=0A=
