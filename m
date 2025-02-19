Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BB6C021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19C0580F68;
	Wed, 19 Feb 2025 14:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Y9SLcf8C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2D96809A4; Wed, 19 Feb 2025 08:22:47 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BCF4800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lI4ltPQxS42sC6nd/y6nEgADbNqRtGtHCaTS9mRf6axWoEp6lr84Ve0PP10hOTMJbKhjZwNcd6z78uN9ExXB3Fp3Loo7XvxrVzkVaCjyCiJyt1OT0wNWJLALDEC7bR3+TFVV9vQ8wqcoYLWMXOAsS1egY7P1zTnEbZYw/7zVKMTlsHdDnUZkYm1IgLg3XHiSmdb4VGCroSbVVFY5Mzex4CiKptuNCblxgobr1d/BMv6LMo8+Op2972AdP3aX5QrxNLgOAxTs5omdWiV3LiOnd8qzdGfpwT5WWA47qF4jiQyZXlh6RL4uc7V7z66EC7/NGM1/QlSg4IP7rKkbo2psCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cw2M6MX2E6E2b54O8ye+qp7h/psqokZZN5nxHKEI92M=;
 b=mKPKXO0kCVD6/WANJRUh1mi/wuVJ2Exi5A8YlnFEUdIf8IzBYCKsYKjzBbbhsdI4WxqDpZ7kj9JdK05e8w03G2cN1aQffUDflGUWglaf1vjCAYRIx+ddUI4/qFw6zmo8IFPARuD/pdiBbaDy7hyA0nv/EYpAbwWsDxIE0R1UIXUDuDSxM7vXgH1gCjEXp3Js/DlxAdskHqHPw6wX5cbSjrH2vRkBT5vFO1md/adKC8DA14EzcSXKLqw7uPzQM66Vt+Ox9snX0bW4PWW97uOcCn8WzCz1jZRT5bSLNL9oSHL5A3wDvfpJHNG9P/NgRI2AmLYkNrtbdf0a8AYgq1aJMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cw2M6MX2E6E2b54O8ye+qp7h/psqokZZN5nxHKEI92M=;
 b=Y9SLcf8CX1+LEOLLdPjVv5/9OxjJ4lEoCpPCU2XqT24/i6HJPvCrsDXNh4WJbUaQJ/18spyOYraWsoNn5i4KdQvfLqlQdMsTVb/M+wJ+Az7PEQFIqpyODr8ugOEd/yDwavXIpAnjv9TDM3/dUViu+JNYIP/Eetdpasz8krosYZ+juJOGTirHTz540zIwPYabKDujgIFRlu1AteT2WkYEPXKNBSjEk7HbaUygYq2dtGLyZWnBEr7s9VYCtUwtBsTOK2b0pInU5JWObomsMLUB691eUPo3sgdYE69njyFEBgyP5FN4hfB1/fB0NZ4df7jrDpPphvXQsUeYhd+LXHeHUA==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by PH0PR03MB6679.namprd03.prod.outlook.com (2603:10b6:510:be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:22:42 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:22:42 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>, Tien Fong Chee
 <tien.fong.chee@intel.com>
Subject: RE: [PATCH v2 13/26] arm: socfpga: agilex5: Enable cache flush for
 system memory cache in CCU
Thread-Topic: [PATCH v2 13/26] arm: socfpga: agilex5: Enable cache flush for
 system memory cache in CCU
Thread-Index: AQHbgeAfB4se7qKJX0yRymoWArKop7NOOlbQ
Date: Wed, 19 Feb 2025 07:22:42 +0000
Message-ID: <SN6PR03MB3583D62EF94B0D9605EBEDC8A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-14-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-14-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|PH0PR03MB6679:EE_
x-ms-office365-filtering-correlation-id: 44f487e0-6136-4c7c-b416-08dd50b6330d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?MMa3xPNpX16dOX5AS1SXl0bn6CxLQD6g9sh8uigNQZ2NMire4KJf5kO8Dnvu?=
 =?us-ascii?Q?Bv6E3C48rrx6LWsJujZ+wLIs9aQpAjT4zjDUxfp5wL5qe8//RMz8MHF7PozD?=
 =?us-ascii?Q?FA9vEYfo12U2BNkg9aLGbvEXzBZJbNdZhpnMtJFVi9BGjZhCLBsDocA89ZfJ?=
 =?us-ascii?Q?1lDCdMf1dwxl4EHMdKaxm56ECLk7F14c24rYoDa1nNIi61l9xIoSHUHNruni?=
 =?us-ascii?Q?djUPGR/YiHR48/TTLRghUVku6w6yKLYKXlr+LBHWYH1hnpOlYerwLQ16Zmfp?=
 =?us-ascii?Q?x+v2z3HrGBxA/rfA6vKh4Ch9EBP284qxlx4cD5uP0fcszjTofoNwihVYki35?=
 =?us-ascii?Q?/GblWpmd8whBfkHeBuH+U6crw3pNhFvOsOkiinmFdQGrCqBkQ7GC1f/nbOPM?=
 =?us-ascii?Q?hG0u+KNEj5Czd2olRcuWFds7WI/VTd7/gftnwXLiyn3Xdkx5+s4bPN4owd1B?=
 =?us-ascii?Q?WJKEpoafnK7pcIQVVVZnL9/geiTmBLGWYp4c0hnvQP/jVa8Sf2uf9gt+T+5b?=
 =?us-ascii?Q?H4iTXtmAADNg/oKWTQw8rIbG5DKLNji5QWNIYNcfoWV7Bhoo9z9/Cf98dSgN?=
 =?us-ascii?Q?Fy1eQmaiFF9a+25w78czBjBVIHAv5LJLbh1IxUg/3vQTYn9K2n/jQtrDRKxD?=
 =?us-ascii?Q?tceTQI11cMztP2BTG85zcvETF+zzlvQtTmHI1DzRuSFJb2nmmsDPhC6Fzlfq?=
 =?us-ascii?Q?/HCDgjQsD08ld4RdFl101IhQXtSjb337oBmDmz2k+Q6crnTBYvysYBqphFpC?=
 =?us-ascii?Q?xiuNTPjX2DjXJWoQMdWjAtAoGugH+u7TVUXSzgiSREnORLa7YOzH8dDJKJHl?=
 =?us-ascii?Q?KECIhIwL4FTLq2jqIMKDPsimChD5yHlYc8H1jFcsHI/Ha0Bt/EFfDWq8NJv7?=
 =?us-ascii?Q?JO1xrenqgcPc/ug6BePWqQDliY1BhDAum1VUF02biqNysTSZlcXsL6na4LGz?=
 =?us-ascii?Q?L3rAlEj0QK/aoc++mJHMLowHxRHuf/EbdoQKdWODYQ34SYixil64omP9zTOo?=
 =?us-ascii?Q?KWljWMOLoxOlAFV2qnClFtc3LcN35bzvNl5KW7MTbqkP3PgHq5CjXcKxYh9z?=
 =?us-ascii?Q?3SA5rdoKScsjSrRMwauEibQqbEcMKmrrNAK8gF2qnizDJH1Y2BsZjyFZ4+sY?=
 =?us-ascii?Q?ZCX9JwwfNprZuAi5kaT+Vt6CnFMayRQ9OY+ClxevxD4h5do/2Vvso6B3X5tS?=
 =?us-ascii?Q?KflP6lxftbaCQR3jKI3E9VRd/4aYDuIrzZPZzIm/3Dlx+eE8WcIzRp5pOGB2?=
 =?us-ascii?Q?IoMpUggYgZ8Xy7NTlsNHRaS/vUimQYtCQwuK0+rktgJSBHNReAy6oQceWCb4?=
 =?us-ascii?Q?y3spOv+sn33Yoq1MEnE2V9Jwa9tkUSFwDk8QeJkRpQ+cGwp4tMGZezlXFYFf?=
 =?us-ascii?Q?0B8TOq8kKFwYXH1ceetgccBy/4CY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m8hhLe7nyOcoCdJSAYlLoATg0NTzieymJhwnZHSMnO5Q8HU9l3Pk40w9J5MU?=
 =?us-ascii?Q?u77iJppUtwTACBKtM+K1sGtRsMdwdnHRRZ/M372QSiwlb1YhatqTmg5VRsOG?=
 =?us-ascii?Q?BWo34dXC4gxYYdTPVr/jXajCiGOW1H/cgEqjaykJju/WnfD19HsQZEFkInSX?=
 =?us-ascii?Q?7tYb3NpQFRa5QlN2tsBs6lSr+o6n2qXI1KRVPh8JMZ3dDA7YCRavaTijY4pT?=
 =?us-ascii?Q?JGQWag1bdn89mhdIinqRRcxlelrrTqgpH6OgArZeCd2a2JWm8DbIayf0Yraa?=
 =?us-ascii?Q?p5+3PDM9FAsM8sSU0JFzQp7VDqe0wMtNCDJP00CjwvMDysUGZFm+2Cxi5RUf?=
 =?us-ascii?Q?N+32Jlpt5FuJYE72ro9Jtn7QF4i65ghjsxoOl9jIyr4zEs9YxlivqJO3WUyH?=
 =?us-ascii?Q?/QKZHm9lYfmE6YKO9/NV3uVWtc5T9f0i1z519RiQGwEsjDy/5ICDSC+hthGv?=
 =?us-ascii?Q?5sV5+B4pemQYyNJ3HYZ9JVWYFl6omwtn+PQcGLb4I3jU+QB31Kaeo22mHfPg?=
 =?us-ascii?Q?mpHdZaTPKbVLoG24DhZBpDGnH+alHufj9dNeR3vcor1n5vVkqysBPIGskiB9?=
 =?us-ascii?Q?r3xit1OKHVYDb74mMxfWs7EV3CKG1XDt98bkF672EqYIhxC+/APeHNAlkMF0?=
 =?us-ascii?Q?hpNozc0eMod5lXpzt/42XZVXyKzqeEm3w16inxmWfL+dMTRtSSO29qphSUgu?=
 =?us-ascii?Q?6v/wqXbjMtDJSfwEC0OJJgX6snAjZKk3Ie3p3zXHGIyAQIXTRzMTN+NZk9bK?=
 =?us-ascii?Q?zFFEbmSOAxiZVuzpfqY35fBNpc+yvZydHjo62phW9Wbqrr7//HemPelDQikD?=
 =?us-ascii?Q?pOz5T6e9NZcld/uHhpSpyLC6I2HOC/Gl39qINPbZ36DgtonyPP0hFCkDGSKy?=
 =?us-ascii?Q?C1zTKU4VIDFz7CDypCVNpvx2xppNaQAQp0K7WMriyxqhEblkX0cgbwWtQEfi?=
 =?us-ascii?Q?Pg+e9K6m8kqqe2tH9Y1VNkF4quMy41x8fXstrKVZeQAUfXbtqsZH6oz0uCnd?=
 =?us-ascii?Q?YhbWVZBZpYARw7oRHKT9I7LIML5e1pqTHcMPLxwZUTj52M7ewXaRvNxYgT3v?=
 =?us-ascii?Q?QvU+kJwyzYH3mDnJxNxKYQsf3KDnPcK/IXf1Y8EP57yDJpAsBrmu+0iAipC7?=
 =?us-ascii?Q?Duea9yu/pOei9t1z7TQI0SqzrYTzyZqDMHaHze54BgC0csJR3Cnh+ATRAF2V?=
 =?us-ascii?Q?6PFMMwpHc5p9IPHDYYbzTsKkrtsTTLr8r6QaGN0SVu7uTx3kqkIx3hpGNmy1?=
 =?us-ascii?Q?hiolHf5ZhqJFCVRTRPrUI2/c9MridDzQYEtv7OPUMLU/gQ6sozboDloy9JED?=
 =?us-ascii?Q?/0HXjqxG0dkutn1LjMeYMTZcIRwgzlX5nSw4hR4IxCSMeRpplHlKPObsek0W?=
 =?us-ascii?Q?TX1ZSF3mn0cVbpNCwan1CkrGfw/1nCzxR53WMe93VEbvlny3c9t6Avtp0xsY?=
 =?us-ascii?Q?1sCP1J6svNP5Rv/ZrZzuUSiGfwlqMpBp+Z7lMNRfqNV2usLNlXQP2Es9mlFV?=
 =?us-ascii?Q?jbxLsaH26nzUebhinjHPyWUX+9KWUG70oG0KC3XWHIDVry3g6CeJyPbXdvf/?=
 =?us-ascii?Q?2/Rtmal8YuSxGk3e1EAjHPY7ULGhxINyGFP7eijl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f487e0-6136-4c7c-b416-08dd50b6330d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:22:42.6845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H0WEZzNoNyh+45MqdvZlq+Jo4byc0AbRIpwMBYPKUdzctTilTeTGv/4d0v46olJw9sK/YqlsdGgC6nGspALqGgKxbfMqhEmZYYeoEIJN8NQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6679
X-Mailman-Approved-At: Wed, 19 Feb 2025 14:04:13 +0100
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



-----Original Message-----
From: alif.zakuan.yuslaimi@intel.com <alif.zakuan.yuslaimi@intel.com>=20
Sent: Tuesday, February 18, 2025 4:35 PM
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@g=
mail.com>; Chee, Tien Fong <tien.fong.chee@altera.com>; Yuslaimi, Alif Zaku=
an <alif.zakuan.yuslaimi@altera.com>; Meng, Tingting <tingting.meng@altera.=
com>; Ng, Boon Khai <boon.khai.ng@altera.com>; Hea, Kok Kiang <kok.kiang.he=
a@altera.com>; Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v2 13/26] arm: socfpga: agilex5: Enable cache flush for sys=
tem memory cache in CCU

From: Tien Fong Chee <tien.fong.chee@intel.com>

set/way instructions "dc cisw" which is used by the "dcache flush" command =
only flushing CPU data caches from L1 -> L2 -> L3 to system memory cache in=
 cache coherency unit, hence this patch enables data flush from system memo=
ry cache of CCU into DDR memory.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/mach-socfpga/Makefile     |  1 +
 arch/arm/mach-socfpga/ccu_ncore3.c | 64 ++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/ccu_ncore3.c

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefil=
e index cd9e9272024..b6897ba42b1 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -65,6 +65,7 @@ obj-y	+=3D mmu-arm64_s10.o
 obj-y	+=3D reset_manager_s10.o
 obj-y	+=3D wrap_handoff_soc64.o
 obj-y	+=3D wrap_pll_config_soc64.o
+obj-y	+=3D ccu_ncore3.o
 endif
=20
 ifdef CONFIG_TARGET_SOCFPGA_N5X
diff --git a/arch/arm/mach-socfpga/ccu_ncore3.c b/arch/arm/mach-socfpga/ccu=
_ncore3.c
new file mode 100644
index 00000000000..a399aedcd10
--- /dev/null
+++ b/arch/arm/mach-socfpga/ccu_ncore3.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ *
+ */
+#include <wait_bit.h>
+#include <asm/arch/base_addr_soc64.h>
+#include <linux/bitfield.h>
+
+#define CCU_DMI0_DMIUSMCTCR				SOCFPGA_CCU_ADDRESS + 0x7300
+#define CCU_DMI0_DMIUSMCMCR				SOCFPGA_CCU_ADDRESS + 0x7340
+#define CCU_DMI0_DMIUSMCMAR				SOCFPGA_CCU_ADDRESS + 0x7344
+#define CCU_DMI0_DMIUSMCMCR_MNTOP		GENMASK(3, 0)
+#define MAX_DISTRIBUTED_MEM_INTERFACE	2
+#define FLUSH_ALL_ENTRIES				0x4
+#define CCU_DMI0_DMIUSMCMCR_ARRAY_ID	GENMASK(21, 16)
+#define ARRAY_ID_TAG					0x0
+#define ARRAY_ID_DATA					0x1
+#define CACHE_OPERATION_DONE			BIT(0)
+#define TIMEOUT_200MS					200
+
+int __asm_flush_l3_dcache(void)
+{
+	int i;
+	int ret =3D 0;
+
+	/* Flushing all entries in CCU system memory cache */
+	for (i =3D 0; i < MAX_DISTRIBUTED_MEM_INTERFACE; i++) {
+		/*
+		 * Skipping if the system memory cache is not enabled for
+		 * particular DMI
+		 */
+		if (!readl((uintptr_t)(CCU_DMI0_DMIUSMCTCR + (i * 0x1000))))
+			continue;
+
+		writel(FIELD_PREP(CCU_DMI0_DMIUSMCMCR_MNTOP, FLUSH_ALL_ENTRIES) |
+			   FIELD_PREP(CCU_DMI0_DMIUSMCMCR_ARRAY_ID, ARRAY_ID_TAG),
+			   (uintptr_t)(CCU_DMI0_DMIUSMCMCR + (i * 0x1000)));
+
+		/* Wait for cache maintenance operation done */
+		ret =3D wait_for_bit_le32((const void *)(uintptr_t)(CCU_DMI0_DMIUSMCMAR =
+
+				(i * 0x1000)), CACHE_OPERATION_DONE, false, TIMEOUT_200MS,
+				false);
+		if (ret) {
+			debug("%s: Timeout while waiting for flushing tag in DMI%d done\n",
+			      __func__, i);
+			return ret;
+		}
+
+		writel(FIELD_PREP(CCU_DMI0_DMIUSMCMCR_MNTOP, FLUSH_ALL_ENTRIES) |
+			   FIELD_PREP(CCU_DMI0_DMIUSMCMCR_ARRAY_ID, ARRAY_ID_DATA),
+			   (uintptr_t)(CCU_DMI0_DMIUSMCMCR + (i * 0x1000)));
+
+		/* Wait for cache maintenance operation done */
+		ret =3D wait_for_bit_le32((const void *)(uintptr_t)(CCU_DMI0_DMIUSMCMAR =
+
+				(i * 0x1000)), CACHE_OPERATION_DONE, false, TIMEOUT_200MS,
+				false);
+		if (ret)
+			debug("%s: Timeout waiting for flushing data in DMI%d done\n",
+			      __func__, i);
+	}
+
+	return ret;
+}
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
