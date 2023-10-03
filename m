Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E174CE75426
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 12:12:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0767871B0;
	Tue,  3 Oct 2023 14:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="Gr5IOYpK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98B7C87211; Tue,  3 Oct 2023 10:58:36 +0200 (CEST)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C27D8871E7
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 10:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4640511bd5=andrii_chepurnyi@epam.com
Received: from pps.filterd (m0174682.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39332Wx4003099; Tue, 3 Oct 2023 08:58:31 GMT
Received: from eur01-ve1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2055.outbound.protection.outlook.com [104.47.1.55])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3tg1ast0gx-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 08:58:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4w23gjGD1SdlV+vnfLoT2x1z11fVdJ6/1eqB+82hO8H3jhGC/7u8Me4/fOuMvcxzHj1LSnkFzw2cYw/lrMWOJUf1u09gkdaPkCmBgIPbzsxDFab8n3xevLy3hVKljoEiIf2e3hqZ2dqbk+bGqVNwuJCxiZyB3mxXHJe2gpUTYjdc8w2+lHlKvVONY3Bi8ct/fQ0DTQj0ccye1bYi8W0YZr/YSb0hgcFS/+M4Xy79giNZP4hfq+Fna14xXWGsVTYOOkf8YWnF/xHEYtbkLGU3wfUPw2NtvHPx38N6GLq0fRNPlSsQKjsrK2vZn3xGXNGSrrRZSRjH6gAURtPHyoQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58dcKH9d1gqGP9nSrCVw53ClNnVgdRoYESHv751r1Jw=;
 b=WTwsOff3rzYiVXSGxMam2IuuYZ95Qaq2sYYAdKXhVBQ2Je4U1K+YiSkVaxhfkAYA2gNeilynLWZe4Cg59emo7QXhrfE6n+tnXBofscRrQSNDqzsTASjwf3A+3y8W1hPNR6bu1g814769liHRK59rwGPcYvvxqltUTQIO8v3/5G6PPUfb1uEdgQFo6SJMasC68feu/2R98Pcawd7fpPnOBUE5mBSOGLOn0Z7fcp7fKfjNKn6j2V9DkuV2ogCBvCcvvzOJqfI4rFos+fvWObMy+uzytAw+lO+9BIcm4/rpOIwQ2NcbzbnEdcwz1MyoaEXejveZi/10AGsOwmFcm//ikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58dcKH9d1gqGP9nSrCVw53ClNnVgdRoYESHv751r1Jw=;
 b=Gr5IOYpKTz8kgdWmaVyME3kFIWNEvsviBg2DgaMY5aAOQ2iGT1q6s/ZkLRZD7IGVx1fQq2gN/sUGZUvU8ER7CNu7QEK9baNXgAfyPLktukGr8utJwJHZhP08V+KaN8Ztt10i3OqxwY1pkh0cfQTmOEdRkxFHvspJmCS1PrrUw7D7ZVSutht25ylYhBke7ItjhdwcdhhlGSz5KkFJVZ5+MvE8VRKD6iHV+rQ8hJvZx8IAHZoSHSENIAdm5QwXcdbrn2Esi1MlfzbKBE1b7yANn7KInMrUX3MlNNxrUtUy57th3SFzbwTxwGz7rqaqsB43b++PzJ/MHvIRSM2M6+D9ZA==
Received: from AS8PR03MB9583.eurprd03.prod.outlook.com (2603:10a6:20b:5aa::18)
 by AS8PR03MB8594.eurprd03.prod.outlook.com (2603:10a6:20b:573::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 08:58:28 +0000
Received: from AS8PR03MB9583.eurprd03.prod.outlook.com
 ([fe80::529f:7d90:7f52:64aa]) by AS8PR03MB9583.eurprd03.prod.outlook.com
 ([fe80::529f:7d90:7f52:64aa%4]) with mapi id 15.20.6838.028; Tue, 3 Oct 2023
 08:58:28 +0000
From: Andrii Chepurnyi <Andrii_Chepurnyi@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "leo.yan@linaro.org" <leo.yan@linaro.org>, "vicooodin@gmail.com"
 <vicooodin@gmail.com>, "andrii.chepurnyi82@gmail.com"
 <andrii.chepurnyi82@gmail.com>,
 Andrii Chepurnyi <Andrii_Chepurnyi@epam.com>
Subject: [PATCH v1 1/1] board: xen: introduce virtio-blk support
Thread-Topic: [PATCH v1 1/1] board: xen: introduce virtio-blk support
Thread-Index: AQHZ9dfGe3DunhD8RkWAZVLm9bjHEA==
Date: Tue, 3 Oct 2023 08:58:28 +0000
Message-ID: <20231003085805.2214260-2-andrii_chepurnyi@epam.com>
References: <20231003085805.2214260-1-andrii_chepurnyi@epam.com>
In-Reply-To: <20231003085805.2214260-1-andrii_chepurnyi@epam.com>
Accept-Language: uk-UA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB9583:EE_|AS8PR03MB8594:EE_
x-ms-office365-filtering-correlation-id: 28d2d6d6-beff-41d9-d2c6-08dbc3eee8f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JtnIv6PTFxjezitvqB8dw/L3IQ20wepk0jF3iPlhNKm/7DHTCt3E1CiN0cBDuW+ENsI+8jwsopv7o3f3Lw0eT3mg0OwdNDVuCrH8IGkXs3FySkoHJHdLHO+W14ghcTcGhf4RiDuQDsmEy9AeXFJe+K6Yg1ZFG/WRYYEnpY2OSYxzWFOttirSk8mxp8WLWuUR580EzXbmRtHsOESjGoRveWXKtvAkiunpRGcOrQ4Dmz81K1tyLgk8uhwzwisybNl9JT6xosERgWmcU2r4scUcFMqAm9LNGI/K8wN86DNR5IHEPgV/knHnAVfTb3lr8tNg+6j+YR7HhOwSLUjkMF/NScJTsiODxdNRo7ufviFNRxXlpo6qI4i9SyOUNBD3pg3ujh9cjv/oHJCd+6W6067ofWpehh+X1S8R+opCmUr/uERsPMkub+pQ8dqPx+sNP1k6B3DCe/ZJFYSf2GuPs5bGWiXW/YinA7L076hVJxynz1ozDMmPXAPJeRLQBlKD+qgbZJIuu09CJheEPcP41MQogUNVhcaK26AGk7Tb4IydkZWPMrLBNMusimMZPPcYErFqqD+OzC4IE/WF4y9nOnSIEIs0ODg9Nkbzo2HDtZF8Y8XDCR6CTJO/B8D7+wMXy07g
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR03MB9583.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(38070700005)(38100700002)(86362001)(122000001)(36756003)(478600001)(71200400001)(6506007)(6486002)(6512007)(5660300002)(66446008)(2616005)(107886003)(2906002)(76116006)(66946007)(26005)(66476007)(64756008)(66556008)(54906003)(6916009)(41300700001)(316002)(91956017)(1076003)(8936002)(4326008)(8676002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e/J2Y8BLM0CHaHPBu+mXx7IEJEb7IwqP/v8yImoD4bu6luFReAorHvE/Mv?=
 =?iso-8859-1?Q?YBYJ+Aiz0a0TOVFcO/m2r0R5LtsZtw7EkprOFLx6P3SEE2SEibl8Lzo7od?=
 =?iso-8859-1?Q?ttb2RWscH15LwDEd2+Kxc4qLSZX0DmcPn86J/TpqXeiSeYlZ7ZjOfHtIZs?=
 =?iso-8859-1?Q?asnjyGU22TQ98YTBR1xDN4GjdnDO7Am1WY50e8WNNSp22Rhcw3dK7wnLJ5?=
 =?iso-8859-1?Q?ujJpEMXs+dYbaOGv2Es6cRg5vyCoIAkjeaMGALtv7fGr6a55uGYymxJwMp?=
 =?iso-8859-1?Q?FHHlQGXeeCQNav8vQVipFASVrn/Vln5gR7Rp/cvIcDqSwTAGGySDJOOXiQ?=
 =?iso-8859-1?Q?no3bedC9otnF+gTP2dIykQ1+6MxEOwxGKco7dvefzFO7FWHal3iiLV985M?=
 =?iso-8859-1?Q?ZoTrJ+p8Swth4a/IjmXWBlw5r7kXbbJlrbCBNOgf7m3wyeXnNn21m/zQXX?=
 =?iso-8859-1?Q?ue7I3LtlLnEGjQcl3zMOmfSmo85Hw10WSSoWJXdnkYQLcRzY3KIKIDvFAz?=
 =?iso-8859-1?Q?5pDTY/Gb9/PYQaNdKdfqPA2M4+yibNdZu2t9J61cuGysuhIZwp2O5nWNDm?=
 =?iso-8859-1?Q?f1nBpGBJS2XkQEMivUhfdhEPYGlpmvaLB6zv2c/NrvCSEM9ytkJzIedywG?=
 =?iso-8859-1?Q?1jKJR+7jzvIxYcMYNd6AFR6Qg4KoV2AgvwcGYUxsPKpsL9zFyYMC850Edd?=
 =?iso-8859-1?Q?YK/o5ez4fGi9mtagWbz7q4UjsfWD4Tss9Sn91DnOp4NcGtHuHyXhBOt9Pa?=
 =?iso-8859-1?Q?t0I240uwM1+vs7AKD5JZwd4eNGD9gbMyVPBwjWd9FHAnyPLZSqpiXP8wM4?=
 =?iso-8859-1?Q?KHoiib+PKx9Fk2htEa3vYptteZcZZyEBDtwltkP4YrMxbflDDeW2UPveNm?=
 =?iso-8859-1?Q?Q4tQMvCglhaF7Cos6YYeyIRYnc/mIhDxm23d4yvLwF0sh+RVSY3WBDy/c9?=
 =?iso-8859-1?Q?RarRXD2r3eHyFXsYpu2jAV1n7OWqe8QDezTLjhMYjRsepJi7H4AbuvsneB?=
 =?iso-8859-1?Q?ej3By2+RsCZUx5+yGMbHi98Jk4S3mZ0Luaf2NHpX129nz4AK+bv0Q4C0hV?=
 =?iso-8859-1?Q?R4NHdwu+KVL7gXbSwVjfNDOzB50RBprtnL6PI9V1tMg8Xp7/DlOJYYKFUA?=
 =?iso-8859-1?Q?utNBnFzCcexC8WCpZ9abXD8vi+6OBbD+gTLEy6Bh9IphCis5IgWpuu9nAt?=
 =?iso-8859-1?Q?IVnOqfEFQxLpXdwHvW12H4Eh+6pZtEcAzFo2EOzMQLc+K+t+49OM1rKVXZ?=
 =?iso-8859-1?Q?0TAQKxbC/OiUBQeoEayJ0G8trftQddABU6pOvRMlCtvWw1oBWUL0c7cOyA?=
 =?iso-8859-1?Q?H04kArkdJTb0Qi9U7ZSzrYenwJRYRxtoXzArztE7tLlpKAVfxJx7j7aReS?=
 =?iso-8859-1?Q?V7mot9RlZ+yPGhyhluLU1FtTA/WUxQTEHWMjbv0STrCgGDw5Qfy2hNPM9U?=
 =?iso-8859-1?Q?umC4nCChYGN+yCVqyliJfpyWBqXLekNtvpca40p6ZnF8NSHrXeZ4nlgtzI?=
 =?iso-8859-1?Q?BXUg6gbC61St0xlgoDIN8fbgoNuVb4AD4JYqyLvEcaz/EQwoD6ADJPVffk?=
 =?iso-8859-1?Q?Uok5JFClptgm8u+GeLtlu4nmaBSe81L5sOsleY9+BF7guJqxMfZrJ/oNSv?=
 =?iso-8859-1?Q?CejvSqTTb153LhWI4+w31EteHEPXyMkkLstGKFjdufhkG8hPo6I5iF0g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9583.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d2d6d6-beff-41d9-d2c6-08dbc3eee8f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 08:58:28.0808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mozslLyhFnwDxzWcn9LDO4cKC86FcGRyBmHw4Bm94Vdbj3Vv1rdEDnZjY+u3VKFG89r3l9CXpCc5ad9Chn00XayQPtJqx534XFdCzN3wvrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8594
X-Proofpoint-GUID: vZdFY7CfxRNwQ46MMH512H20fAHM_7_w
X-Proofpoint-ORIG-GUID: vZdFY7CfxRNwQ46MMH512H20fAHM_7_w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030056
X-Mailman-Approved-At: Tue, 03 Oct 2023 14:12:00 +0200
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

Added new xenguest_arm64_virtio_defconfig which
enables support for virtio-blk using various types
of transport like virtio-pci, vrtio-mmio. Currently
supported: up to 2 PCI host bridges and 10 MMIO devices.
Note: DT parsing code was partly taken from pci-uclass.c
Limitation: All memory regions should be
below 4GB address space.

Signed-off-by: Andrii Chepurnyi <andrii_chepurnyi@epam.com>
---
 board/xen/xenguest_arm64/xenguest_arm64.c | 108 +++++++++++++++++++++-
 configs/xenguest_arm64_virtio_defconfig   |  63 +++++++++++++
 doc/board/xen/xenguest_arm64.rst          |   2 +
 include/configs/xenguest_arm64.h          |  10 +-
 4 files changed, 180 insertions(+), 3 deletions(-)
 create mode 100644 configs/xenguest_arm64_virtio_defconfig

diff --git a/board/xen/xenguest_arm64/xenguest_arm64.c b/board/xen/xenguest=
_arm64/xenguest_arm64.c
index 6e10bba76b..244070a242 100644
--- a/board/xen/xenguest_arm64/xenguest_arm64.c
+++ b/board/xen/xenguest_arm64/xenguest_arm64.c
@@ -8,12 +8,15 @@
  */
=20
 #include <common.h>
+#include <log.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <errno.h>
 #include <malloc.h>
 #include <xen.h>
 #include <asm/global_data.h>
+#include <virtio_types.h>
+#include <virtio.h>
=20
 #include <asm/io.h>
 #include <asm/armv8/mmu.h>
@@ -49,7 +52,14 @@ void *board_fdt_blob_setup(int *err)
 	return (void *)rom_pointer[0];
 }
=20
-#define MAX_MEM_MAP_REGIONS 5
+/*
+ * MAX_MEM_MAP_REGIONS should respect to:
+ * 3 Xen related regions
+ * 6 regions for 2 PCI Host bridges
+ * 10 regions for MMIO devices
+ * 2 memory regions
+ */
+#define MAX_MEM_MAP_REGIONS 22
 static struct mm_region xen_mem_map[MAX_MEM_MAP_REGIONS];
 struct mm_region *mem_map =3D xen_mem_map;
=20
@@ -63,6 +73,93 @@ static int get_next_memory_node(const void *blob, int me=
m)
 	return mem;
 }
=20
+#ifdef CONFIG_VIRTIO_BLK
+#ifdef CONFIG_VIRTIO_PCI
+static void add_pci_mem_map(const void *blob, int *cnt)
+{
+	struct fdt_resource reg_res;
+	int node =3D -1, len =3D 0, cells_per_record =3D 0, max_regions =3D 0;
+	int pci_addr_cells =3D 0, addr_cells =3D 0, size_cells =3D 0;
+
+	while ((node =3D fdt_node_offset_by_prop_value(blob, node, "compatible",
+						     "pci-host-ecam-generic",
+						     sizeof("pci-host-ecam-generic"))) >=3D 0) {
+		if ((*cnt) >=3D MAX_MEM_MAP_REGIONS ||
+		    fdt_get_resource(blob, node, "reg", 0, &reg_res) < 0)
+			return;
+
+		xen_mem_map[*cnt].virt =3D reg_res.start;
+		xen_mem_map[*cnt].phys =3D reg_res.start;
+		xen_mem_map[*cnt].size =3D fdt_resource_size(&reg_res);
+		xen_mem_map[*cnt].attrs =3D (PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+								   PTE_BLOCK_INNER_SHARE);
+		(*cnt)++;
+
+		const u32 *prop =3D fdt_getprop(blob, node, "ranges", &len);
+
+		if (!prop)
+			return;
+
+		pci_addr_cells =3D  fdt_address_cells(blob, node);
+		addr_cells =3D fdt_address_cells(blob, 0);
+		size_cells =3D fdt_size_cells(blob, node);
+
+		/* PCI addresses are always 3-cells */
+		len /=3D sizeof(u32);
+		cells_per_record =3D pci_addr_cells + addr_cells + size_cells;
+		max_regions =3D len / cells_per_record + CONFIG_NR_DRAM_BANKS;
+
+		for (int i =3D 0; i < max_regions; i++, len -=3D cells_per_record) {
+			u64 pci_addr, addr, size;
+			int space_code;
+			u32 flags;
+
+			if (((*cnt) >=3D MAX_MEM_MAP_REGIONS) || len < cells_per_record)
+				return;
+
+			flags =3D fdt32_to_cpu(prop[0]);
+			space_code =3D (flags >> 24) & 3;
+			pci_addr =3D fdtdec_get_number(prop + 1, 2);
+			prop +=3D pci_addr_cells;
+			addr =3D fdtdec_get_number(prop, addr_cells);
+			prop +=3D addr_cells;
+			size =3D fdtdec_get_number(prop, size_cells);
+			prop +=3D size_cells;
+
+			xen_mem_map[*cnt].virt =3D addr;
+			xen_mem_map[*cnt].phys =3D addr;
+			xen_mem_map[*cnt].size =3D size;
+			xen_mem_map[*cnt].attrs =3D (PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+						   PTE_BLOCK_INNER_SHARE);
+			(*cnt)++;
+		}
+	}
+}
+#endif
+
+#ifdef CONFIG_VIRTIO_MMIO
+static void add_mmio_mem_map(const void *blob, int *cnt)
+{
+	int node =3D -1;
+	struct fdt_resource reg_res;
+
+	if ((*cnt) >=3D MAX_MEM_MAP_REGIONS)
+		return;
+	while ((node =3D fdt_node_offset_by_prop_value(blob, node, "compatible", =
"virtio,mmio",
+						     sizeof("virtio,mmio"))) >=3D 0) {
+		if (fdt_get_resource(blob, node, "reg", 0, &reg_res) < 0)
+			return;
+		xen_mem_map[*cnt].virt =3D reg_res.start;
+		xen_mem_map[*cnt].phys =3D reg_res.start;
+		xen_mem_map[*cnt].size =3D roundup(fdt_resource_size(&reg_res), PAGE_SIZ=
E);
+		xen_mem_map[*cnt].attrs =3D (PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+				PTE_BLOCK_INNER_SHARE);
+		(*cnt)++;
+	}
+}
+#endif
+#endif
+
 static int setup_mem_map(void)
 {
 	int i =3D 0, ret, mem, reg =3D 0;
@@ -72,6 +169,7 @@ static int setup_mem_map(void)
 	phys_addr_t gnttab_base;
 	phys_size_t gnttab_sz;
=20
+	memset(xen_mem_map, 0, sizeof(xen_mem_map));
 	/*
 	 * Add "magic" region which is used by Xen to provide some essentials
 	 * for the guest: we need console and xenstore.
@@ -143,6 +241,14 @@ static int setup_mem_map(void)
 		xen_mem_map[i].attrs =3D (PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 					PTE_BLOCK_INNER_SHARE);
 	}
+#ifdef CONFIG_VIRTIO_BLK
+#ifdef CONFIG_VIRTIO_PCI
+	add_pci_mem_map(blob, &i);
+#endif
+#ifdef CONFIG_VIRTIO_MMIO
+	add_mmio_mem_map(blob, &i);
+#endif
+#endif
 	return 0;
 }
=20
diff --git a/configs/xenguest_arm64_virtio_defconfig b/configs/xenguest_arm=
64_virtio_defconfig
new file mode 100644
index 0000000000..b812cf4fe8
--- /dev/null
+++ b/configs/xenguest_arm64_virtio_defconfig
@@ -0,0 +1,63 @@
+CONFIG_ARM=3Dy
+CONFIG_POSITION_INDEPENDENT=3Dy
+CONFIG_TARGET_XENGUEST_ARM64=3Dy
+CONFIG_TEXT_BASE=3D0x40080000
+CONFIG_SYS_MALLOC_LEN=3D0x2000000
+CONFIG_SYS_MALLOC_F_LEN=3D0x400
+CONFIG_NR_DRAM_BANKS=3D1
+CONFIG_DEFAULT_DEVICE_TREE=3D"xenguest-arm64"
+CONFIG_SYS_PROMPT=3D"xenguest# "
+CONFIG_IDENT_STRING=3D" xenguest"
+CONFIG_SYS_LOAD_ADDR=3D0x40000000
+CONFIG_OF_SYSTEM_SETUP=3Dy
+CONFIG_BOOTDELAY=3D10
+CONFIG_SYS_MAXARGS=3D64
+CONFIG_SYS_PBSIZE=3D1051
+#CONFIG_SYS_CBSIZE=3D512
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_BOOTD is not set
+CONFIG_SYS_BOOTM_LEN=3D0x800000
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_GO is not set
+# CONFIG_CMD_IMI is not set
+# CONFIG_CMD_XIMG is not set
+# CONFIG_CMD_EXPORTENV is not set
+# CONFIG_CMD_IMPORTENV is not set
+# CONFIG_CMD_EDITENV is not set
+# CONFIG_CMD_SAVEENV is not set
+# CONFIG_CMD_ENV_EXISTS is not set
+# CONFIG_CMD_CRC32 is not set
+# CONFIG_CMD_LZMADEC is not set
+# CONFIG_CMD_UNZIP is not set
+# CONFIG_CMD_LOADB is not set
+# CONFIG_CMD_LOADS is not set
+# CONFIG_CMD_ECHO is not set
+# CONFIG_CMD_ITEST is not set
+# CONFIG_CMD_SOURCE is not set
+# CONFIG_CMD_SETEXPR is not set
+# CONFIG_CMD_SLEEP is not set
+CONFIG_CMD_EXT4=3Dy
+CONFIG_CMD_FAT=3Dy
+# CONFIG_NET is not set
+# CONFIG_MMC is not set
+# CONFIG_REQUIRE_SERIAL_CONSOLE is not set
+CONFIG_DM_SERIAL=3Dy
+CONFIG_PHYS_64BIT=3Dy
+CONFIG_PCI=3Dy
+CONFIG_CMD_PCI=3Dy
+CONFIG_PCIE_ECAM_GENERIC=3Dy
+CONFIG_PCI_REGION_MULTI_ENTRY=3Dy
+CONFIG_PCI_INIT_R=3Dy
+CONFIG_PCI_PNP=3Dy
+CONFIG_DM_PCI_COMPAT=3Dy
+CONFIG_SYS_PCI_64BIT=3Dy
+CONFIG_VIRTIO=3Dy
+CONFIG_VIRTIO_MMIO=3Dy
+CONFIG_VIRTIO_PCI=3Dy
+CONFIG_VIRTIO_BLK=3Dy
+CONFIG_CMD_VIRTIO=3Dy
+# CONFIG_VIRTIO_PCI_LEGACY is not set
+# CONFIG_VIRTIO_NET is not set
+# CONFIG_VIRTIO_RNG is not set
+CONFIG_CMD_GPT=3Dy
+CONFIG_PARTITION_TYPE_GUID=3Dy
diff --git a/doc/board/xen/xenguest_arm64.rst b/doc/board/xen/xenguest_arm6=
4.rst
index e9bdaf7ffb..92be9d4376 100644
--- a/doc/board/xen/xenguest_arm64.rst
+++ b/doc/board/xen/xenguest_arm64.rst
@@ -23,6 +23,7 @@ previously done by NXP [4]:
 - PV block device frontend driver with XenStore based device enumeration a=
nd
   UCLASS_PVBLOCK class;
 - PV serial console device frontend driver;
+- Virtio block device support;
 - Xen hypervisor support with minimal set of the essential headers adapted=
 from
   the Linux kernel;
 - Xen grant table support;
@@ -34,6 +35,7 @@ previously done by NXP [4]:
   define any start addresses at compile time which is up to Xen to choose =
at
   run-time;
 - new defconfig introduced: xenguest_arm64_defconfig.
+- new defconfig introduced: xenguest_arm64_virtio_defconfig.
=20
=20
 Board limitations
diff --git a/include/configs/xenguest_arm64.h b/include/configs/xenguest_ar=
m64.h
index bc268d25dc..3dce25b60e 100644
--- a/include/configs/xenguest_arm64.h
+++ b/include/configs/xenguest_arm64.h
@@ -14,9 +14,15 @@
 #undef CFG_SYS_SDRAM_BASE
=20
 #undef CFG_EXTRA_ENV_SETTINGS
+
+#ifdef CONFIG_VIRTIO_BLK
+#define CFG_EXTRA_ENV_SETTINGS	\
+	"virtioboot=3Dvirtio scan; ext4load virtio 0 0x90000000 /boot/Image;" \
+		"booti 0x90000000 - ${fdtcontroladdr};\0"
+#else
 #define CFG_EXTRA_ENV_SETTINGS	\
-	"loadimage=3Dext4load pvblock 0 0x90000000 /boot/Image;\0" \
-	"pvblockboot=3Drun loadimage;" \
+	"pvblockboot=3Dext4load pvblock 0 0x90000000 /boot/Image;" \
 		"booti 0x90000000 - 0x88000000;\0"
+#endif
=20
 #endif /* __XENGUEST_ARM64_H */
--=20
2.25.1
