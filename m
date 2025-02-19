Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26258C021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:05:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B89C780FB4;
	Wed, 19 Feb 2025 14:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="JftXn+UX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4CEC809A4; Wed, 19 Feb 2025 08:22:16 +0100 (CET)
Received: from CY4PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4228D801DE
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:22:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIfCdqrXCaPIYdCtaJTnzmq4V3x6iKeKE1MdnQlqg8w0TnddeqUV7mJ1u2rvuCZJJsYfFv33lkS9vugfo6sJEiEJPqFnpCY23XZ75FXIYltyevxfZtkwU6+MP+5ULU6iBH/LZoozWFnG+8tGheU7Xn2mEwXNu6j5/tfqFjVjtjxnl+frVXjdHJmCvokDG77S/y8r7/f2Qc5biTqUbFiUax/Kr6pypVk7qOyc72H5ju7Z/Q5Gz9KF5kWkDps5e6PITTp/9Hau3hj8umxmxf2Uwmh7z/z/CxfvSy8k0oC1k6HjGZLvWC0tpwaQzWwnEVEj3CkbRtGLI7dUuKfxS4zK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22UTGhbodMQA3/u1Pnn1yjV/RMrB/UDr73DAjMDDX3U=;
 b=QyCPCdb4V2XHpzJwAgQxv9abUF8itQyUiJ/uNbZLACnvSOTbjXNS7kKW990Pj3oq+ZrITbhk8ZMY8zzEpH74Uj8XGd0jW5o3Rez7zDwUW0A28Zjihiz91O7JjtKGuxYDx5p8jUr1Qaf1QEqAHmTman8MABHG/O0guZieMFS+kOjhhx7dp+r0vPkquc6zeyG46/+Dbx2zaVAmjah+vlU+/4B7Ev8/sUNtxC0ntF27hLZcHDCqrh1p5XJibDqsj+S+xQVxWLHL/6QJLrbMHW980yOeifZ9SC1sZEx7i8aOXMFx3fRKQWCPdqMmoHqtgVOPz+9XwvmInc0tbU2PrBJW+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22UTGhbodMQA3/u1Pnn1yjV/RMrB/UDr73DAjMDDX3U=;
 b=JftXn+UXpaNOpJFDcOVPK5/28Uwz6l2852ArstmUbLuVzPv62fz1oRduQosVOnyZ4kugSDDg6Unlr+4WcFwC3joutlrKEh6Kbw63mPwZ+1XH0uzQ02jkIpJuDT23vOeUzPdRTt21lPjybEcxhLp3WOhc5x/q4qcGSvFA4RfAikhj/06zNART7UyEa2dD/EQnXtOIdM7/LWjVI8TI6w/MwccxKSzbwdm1ughr0IKfw9eX//Wq0DfsFG7ZOAr948zkIGLpstTI09mqNoVR8T1Gmy7YJc7Me12c6rcBD4bg1rGf3tH4mhidEc84qpwoNFe1P2k3Ejn5VVXRUjdKaezcTg==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by PH0PR03MB6679.namprd03.prod.outlook.com (2603:10b6:510:be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:22:10 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:22:10 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>
Subject: RE: [PATCH v2 12/26] arch: arm: Enable PSCI reset driver for Agilex5
Thread-Topic: [PATCH v2 12/26] arch: arm: Enable PSCI reset driver for Agilex5
Thread-Index: AQHbgeAfcQRf8YmpcUO4qFAlFWUC7LNOOjMg
Date: Wed, 19 Feb 2025 07:22:10 +0000
Message-ID: <SN6PR03MB3583C031BEDFF3B5A7F262A4A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-13-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-13-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|PH0PR03MB6679:EE_
x-ms-office365-filtering-correlation-id: 14c4477f-ea4e-488e-f6b3-08dd50b61fb0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?4ikFyy73vLl2o/HacdOZCn9y6KY4WmNGjEgnUnkME/ExqCFHS8B1vhFwqL//?=
 =?us-ascii?Q?dkpNsrqnZHqnYjWbx/NckBZ0iX3poUoVXs6/gJRB8UmWg8bftIEBbqfaqolt?=
 =?us-ascii?Q?oZ0iAPQQKNg0QVfGaghqqp1UHTVdnw59VB3EI1dyvz7C8IOJ/XviR7xtttmv?=
 =?us-ascii?Q?9MyQpSZP8DEUZtcTmFB03UXyeZzeVmlGJbRrwhJFhozg7/oGK9spdvc0dk3o?=
 =?us-ascii?Q?p8ByedOlJ19WfR8JOBP9pMno6xiuIVCVrq70/0aSwfiv35LLTI6YKUdtqKUD?=
 =?us-ascii?Q?ui8+if/GDsvT+p4YIyT097xEASEsDplKVNaxrTIX3tMVzhKQ9gUoQJvvDS3k?=
 =?us-ascii?Q?XSHnpSCsZF+EdJ7bm3a5DMZdxBKPsLuOZNv5KE0OokNFdLYgOpaPYKhBVZyS?=
 =?us-ascii?Q?FgL9gBfErCX1KWaOrm8AMEsNk35DAsLFNuOHeQtWW7jl26HFWiL8yusTV0EL?=
 =?us-ascii?Q?CO3UQz2OeCHnl7zQkTEBSV1J4oZms/A/mPLPw3j9mV/p7rM3C2giLrUzNOr8?=
 =?us-ascii?Q?jPvYTk09zaS/OdPWYvIE2Bu+I1aHbeuQD4QfEpD3FCrDuk8aWC0HUINqRKAc?=
 =?us-ascii?Q?wUaUCpMEmViZt1DAiX5di/4YD5FtpfvBmF52N0222dYjJ/FA+Q8xNPaNxtmY?=
 =?us-ascii?Q?1s5OKnsmOchbDwcaYVnjuhNpWNKkAytAAzK+tHdQ/Xy2VIlrOj3KjRiUqsbs?=
 =?us-ascii?Q?fJZWfXjuIOsyg/FicPr20b3uNhn2ZFTGKplWPq6q5bRBHv9aYAuYJFTdSa9S?=
 =?us-ascii?Q?l3Jv1B8lgd0yv2MdibfCUtjsAe/Wfsf294YhakG66IzEck+zSyvLQJfQrj3L?=
 =?us-ascii?Q?uRbPYrPTkobbmgwP09PbKMlYrXWLjWkmeRa8ckQJMLTSCTNBrHRd70EGo14u?=
 =?us-ascii?Q?DGBLu8ojjRIadMbp3BIshezC/jDM5KaJ4aMpPjNKajqas/s5uG9d9/j2tQUK?=
 =?us-ascii?Q?sjdv+D4GyqDqvfprrnkLTCOkBFNerA9DuLKazvgwFkGvjcJPPR44pUDEQXJc?=
 =?us-ascii?Q?39+nqLkHBWRGbxEIwIpqMECX4UOvGxlG/zZE0SOrgXTj067xtEYUsYVl0JBn?=
 =?us-ascii?Q?PbFgZqeChsc0ij9KarUTSIz5q85aTT4nc+ZOqMW6f9xvmNzpgYzXzQpfhPzM?=
 =?us-ascii?Q?wXdQmZgQfncFHchRMyqyyoJ8hVn5N9vu6EFqvYRrWtsf5BxReGszuteg7quq?=
 =?us-ascii?Q?tn2u82+v9TkBhHlNvEUwQK7o9iypldznmfbpNQgDHF4ToPpywcCyJJ+6iAxF?=
 =?us-ascii?Q?dZc10te1xGEaJv7Jl6GzoDuh+BP3dKrtarSB/DP8xXMei+rbEaGCsh8bCRfM?=
 =?us-ascii?Q?8yOlL7hUd9WMHKiZ9kg+ofd72GjQ87n508yBYipOBbwbnfvD/xo7daVwJbOT?=
 =?us-ascii?Q?OBL7CzoCYrOAuszWYq1rTUOOamIYHJFAlI1gcIkHJP1lBiKBDoIttpEyq9rx?=
 =?us-ascii?Q?1pmBqF1+wVQAdaOauMR0/kI/Mvo/dFyQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nDjCY3kUNEL4irR3E46Lf+YD6JXmY0cNRB1YOBPOXsitYATYP6ITG9tUFPm7?=
 =?us-ascii?Q?nE8DWNkkYjW6/Kbw9oDq88w9w9IwtS8N+7X8KoGhTkiYICEIC9Qqbn3DchZV?=
 =?us-ascii?Q?lypDIDhNmiM/rk5JuYiIFH16FpWBr5UYqvzYhd9e8WUg2ggk6mfLQGbhOUk+?=
 =?us-ascii?Q?La7ElJLXTvD7Z0z1S8Cpgc8YmgGrLGrOBeO4PJFzaoQRj0erU1RRWSW3vxNt?=
 =?us-ascii?Q?zzSX6HnLqtlhvaq/1V5a+ejEz44zDWvQaeFWOFbQd0ZOdUbg2caSPTpY5vmS?=
 =?us-ascii?Q?4jG+YOo6806VjjMzM6iAfJ4nmg4Zybnw6pfY+m9uVK8QfgVSXD/a+IzcGnDp?=
 =?us-ascii?Q?W6EG6JKpXblHXwyg52vZGS0WZ89o0+OFv/NZMMbaP5dWBokT7fj0pr2QNoO/?=
 =?us-ascii?Q?nZJVY6eq7cTCbiduQvJSEvgNNzCA8+NYECuqknNEm1XaT0HiiTE7Ep87zcso?=
 =?us-ascii?Q?Eyso0mkuoFLzA6sjqWApDNpfBJ+uTytxYe02L1qx6147HYmX9sDZa0F+YCUv?=
 =?us-ascii?Q?Qj+clfKHMmWiq4zE/lVqkZ54PWonFMn0HWNNdtzZBMg5zQU9L2PEgzo6Dd4K?=
 =?us-ascii?Q?YWfjsCp33RidKy+SSxW7fxmp8PbmdyL6UI7n5eSizVYEQisjG7M1wqnVwc+s?=
 =?us-ascii?Q?siizI2WVTi/0Avb1yiZJ6UoyzHHX2J6pEJHSmmi3Z/3hWp9Ln3gHE48JilVs?=
 =?us-ascii?Q?+ya+CLwL5FAY074qk5M2Wi/AUvdLAbIwG0KxH/9Oe3/elOPDgFVXEN24GNG8?=
 =?us-ascii?Q?Kc4yQaUeEp+94f1dCxPSADT3CkKK+RI8U9YDHu7RkgWbWbkfz2PfB5Ukq7kR?=
 =?us-ascii?Q?DLUH2rMgTFIsGPYxL+qJLnlsqW5en/YQTojq450VnH+BpygcPA9cz6AlHLfr?=
 =?us-ascii?Q?SgHF6a4XRW+Gph+IvLDWvjQZqBZUXDwyC76dKv0opAb/fNkKNL2znV9bpLvL?=
 =?us-ascii?Q?Y31w8wLHw5eVZNrhDf4Z+PgMesedPkH/kWgQXFtzMvimjU0gdD8boNZwKKzc?=
 =?us-ascii?Q?9lqTjpe2A0OXMlfd9K9rLXksligsHAyaF5zVlJ1gQr3WDizleig4EEHcCzKM?=
 =?us-ascii?Q?JCD8kd4d95sgh3DwY7JAC8ohT2ezAkwtR0WYnxcqx6EB0hsj94JJ8kCloU+9?=
 =?us-ascii?Q?irjW3nQ3Zywj8GtKjiZQp6zIQfKmuWKGPS5p2sbR+07Dp+zB/ozLApaj5q8D?=
 =?us-ascii?Q?DUD8yr4ZfKtHjoyNRWs4WRpas18/mmJeAwal091Pf7l7M3MMjeyRwS157IJ4?=
 =?us-ascii?Q?v1W8bBvqeqEeSvTKSvkDZN+qfiZ5aORub+mmyzRX3SXpUguxED+Zs823O99j?=
 =?us-ascii?Q?vxdxgBM8gBBjCwaiy3z8Ra3qteFM9BuaMcQPV9Y6MF983yjtVrsdVRNzDyw1?=
 =?us-ascii?Q?HG2n38mHi4e2nRxIqgwnes6GslQsukvSbzd3o6OiTHRyZTPuX+mVGJA3dCIC?=
 =?us-ascii?Q?l+oH6DFPsOJ8GnpCwC3e5eME9BC8LbfI8GsfqhUFnx1BqW/8P84MXg2OxyV/?=
 =?us-ascii?Q?7ZJ0NIeRBuyETijnI6evorFyLg9R2QB2CNGzp9ohTRaj1/hLwID2zSKAPJTu?=
 =?us-ascii?Q?wBLsJrotrB7oWC2BewTNCR/rmFJIvz8wqx+J9nyD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c4477f-ea4e-488e-f6b3-08dd50b61fb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:22:10.2248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ch1afey77RYqbxlB/enX90eUdmOCOJemlnx/tfU4d03FGJXRyXKQCbpTpBrmrF8ffqHPyIGKhJEV9u4ZWMFX3VLLhhmsjUby9zV7sL4B8wY=
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
a@altera.com>; Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Subject: [PATCH v2 12/26] arch: arm: Enable PSCI reset driver for Agilex5

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

Enable PSCI reset driver for Agilex5 cold and warm reset

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>

---

v1->v2
- Use common PSCI reset driver instead of implementing separate
  reset driver for Agilex5
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig index 865a56e2c8d..eb9a9ee=
a9fa 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1131,6 +1131,7 @@ config ARCH_SOCFPGA
 	select SYSRESET_SOCFPGA if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
 	select SYSRESET_SOCFPGA_SOC64 if !TARGET_SOCFPGA_AGILEX5 && \
 	  TARGET_SOCFPGA_SOC64
+	select SYSRESET_PSCI if TARGET_SOCFPGA_AGILEX5
 	imply CMD_DM
 	imply CMD_MTDPARTS
 	imply CRC32_VERIFY
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
