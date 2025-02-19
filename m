Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1244C021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66D3C80FAC;
	Wed, 19 Feb 2025 14:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="T/gqYEro";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72D90801DE; Wed, 19 Feb 2025 08:22:05 +0100 (CET)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E77B480F32
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:22:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZC2RDldMVzmQ8G7tCkY4u2PLCCVTu87SYdN8yfmU4YsNHid6NRx6mceL43Zt6k3LKNSgDzXLWhKoriLwHkw1k/tGtYiarinzakX1AueCFoZi9jjpNnt8Zh73fkiJZ3cu38AtQ6EtEUUn+RIhJeUXNmFroAY320x6M73YGaumXfK4TtkN4RrEM72FqMypdJeBMCZo7tlY8bFhQXwfSQJ/HJgEAn7Hc1nr2YA/HrnzsYt5jb9aZLJTQ6/6nn/PpXmiw9NQgLARfTwoBPnwD6s46doY9MH+A1GOy5ExIHNwvMEwTX3DjlSRxuK1e9kQ87ZDr7UwPhdUb7h1H7QBLlZzQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZQNq2wY/PnRntWAyVl/MEzZCS9Vi0+nQ3VtEZztsQE=;
 b=VGKSW+9/cOZ/o72Ag7mC3EhivwBGHRi27oX0a1zgph2FYkpr4ihyohpai/10LxJdtXtvtyH/p3t10n+zR8k+REEWzdsGO9k5YQuaopuLPslFHCPH+5r4Dxkv3T0kBwWPjFbs4tnwJT9/9gYPN/1/vcg9R7B0xEEyyEEwnGfLWiyZ6Vuz/00g0cua2BgWKgQxr3z6gVhY0scUPGxY7oU7E/fEVUPZbqKWfQqkc3aoZuBbt3IiJkYkzvciu+26c6lpC3iW8JEx3Yl84jrvwDNhCrFvYun0Z9cJzNoyGuyKwKf9flLmnal1phSW0f9qrkR3zu6dgus3+lCA8c7AzVE8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZQNq2wY/PnRntWAyVl/MEzZCS9Vi0+nQ3VtEZztsQE=;
 b=T/gqYEroAk+1yufHMyWjtbNbPRjJdtShhOX65mmeWZOiDqWOkD7Gq12wXednXgHsdkHwWuhGpwozxYaRbURq9vcnucaKRV02PbUNNXmzzzNIQqXGuYcr8ZvK3Nt/Lv/d9iHKJfP9V01kh+7GUgRzqYg5A6OmMGw1eQ4qvwkL9FjeHfOS/l0N7bM8bY5TrWpZVrlDZ3KROw9heUOV9bhOhdlhm5rqkVmPyFHYvR/+jHbtcptVwzmA9rSBaSWxbGljXUtDnnjygg71tTWIRaeCozTeiDTIakZY6lzrvojswPM5VIoMBPdmAHCSeDtL1g0SbIO3POyfmgjBIhBQ1yR21Q==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by PH0PR03MB6679.namprd03.prod.outlook.com (2603:10b6:510:be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:21:59 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:21:58 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>, Tien Fong Chee
 <tien.fong.chee@intel.com>
Subject: RE: [PATCH v2 11/26] arm: dts: agilex5: Enable XGMAC
Thread-Topic: [PATCH v2 11/26] arm: dts: agilex5: Enable XGMAC
Thread-Index: AQHbgeAdcddObqVSE0eVMDwsyiIvRrNOOiTg
Date: Wed, 19 Feb 2025 07:21:58 +0000
Message-ID: <SN6PR03MB358386CBF210D62646CB2B85A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-12-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-12-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|PH0PR03MB6679:EE_
x-ms-office365-filtering-correlation-id: 819ccd92-ecff-4790-ce6d-08dd50b618f2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7C1pT/fEoutYfhbQHNfYJAWOQu6GurXeW9zyW4In7PcwT4hvr08WinTwpdv1?=
 =?us-ascii?Q?ZRMClq4fh1agAFhH4BCkNEee4eBfqoIepaPojRaEt4fC3bLnxFs+XKhgHhqh?=
 =?us-ascii?Q?1cMQlcoPA3M1QrQxu7Q1mOS2VfzzA/REk+Nc1Xu93onSgcsZYsAi9wwCF8PQ?=
 =?us-ascii?Q?mgTRcPypM03k1pMgkV8HfcV9JkkuiG89HrfrN3nrJ/fBuK876tUX+kMK4cc4?=
 =?us-ascii?Q?CLmzYX9W1b26WFfggbOl3iKh3jl9uUAX8aVNsksxZO5CJwJ7GWuoL42mmjgj?=
 =?us-ascii?Q?dKGYj2z2gtMcjB7aYwcabziVIcAfomicZJZg+oGkfRZiLTo/Ic2jEGVzxefE?=
 =?us-ascii?Q?QDqZb2pO2u/WCT/Q6vPv8gsDIwPC5sZYKZ620nlg39D2pRmaYtWvd0wFSpPK?=
 =?us-ascii?Q?MXMp5tKcJuLqPU9dB9aA3q3/9dswPSYiooZgyXVr4cY9jiCEHdAr9fpnkvBJ?=
 =?us-ascii?Q?1zCADBpTndF1nGQDL3t3EURKVonILJo39VLcPFcNS/zXPh49eD0atbGT0SFA?=
 =?us-ascii?Q?ajjfd7wEOI0Tr59qevlT321ykjPSGqawi3i1j38hZSQ8Jp6D5wJ+RLfNkDn1?=
 =?us-ascii?Q?fQ/9p2BOjkMDQtXh21mVYyLVrh5PwUcNOfq6st/PvryScnVgY62nEYmPlhY3?=
 =?us-ascii?Q?P2aCVbaOGQvLG7ZOJhYITXx6E5QJBKPBD5Q1AooaHBuZLf0PPIWJY5S8TmNn?=
 =?us-ascii?Q?o7tXhY0P9zU/tpLmO4R+dziu6oxOR8Lm1d5cjIlx/0/q4DMVD4pB3wfdkU34?=
 =?us-ascii?Q?3GOJL4BU+kSYsnYEK+nVuVUdiD0rA8IA+MGYPZ4+fmX/QH+NhcyGofPH3Fqd?=
 =?us-ascii?Q?xbZchUUprfQcQnrkjoqUpW4twFOmc/cTA3/tq3pbhH/sBQxaNWM2YkQY+983?=
 =?us-ascii?Q?UZMi+hM0f+vqehg5o6Wb3uryLDh2+5Tg2UytuwKaC6VpdWK8LWI8voUK7jmK?=
 =?us-ascii?Q?oj+TYwPJUa6o4uoXlKG4XPmBd/6ul3/MRvVJEKuR+z+OSt5gA/FF6dNSfD1t?=
 =?us-ascii?Q?wUyiRp6qtost+i9yXbUBCqmUPXzpeblyHTtcWq3UsNz+mC87Lbvh8wAQWYXD?=
 =?us-ascii?Q?y2qRyeEfN1XAht5hzwqDdorRrge7nN8Fgo3eG9nP+Ein3CBtNqkdAGFdnPfl?=
 =?us-ascii?Q?IsQpx7dm0PdrI6v0bq97B0KHcR3LKxY6tSn2jAGXJkOJOGkSXbVeICEPc4hp?=
 =?us-ascii?Q?N7+GEwQ3x1CyDQdeXAEuerzUnzW6rDwX6KVg4OaKSBFx9OqTcrPVDWdX25o+?=
 =?us-ascii?Q?VRoH06seMbg32kzMXh6C4hLp+XUynv7k9tUKLVtE2EXpzHskp1CYwVw9LJxv?=
 =?us-ascii?Q?AUWfoh5DYCCnkKSDeSSrWWyjIS75iaB5ffPn47dIU1TjAnYfypxsuK5+NUKC?=
 =?us-ascii?Q?2TpTqLc250Ko6ZHdF8q/nK1LXQ8L?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ihmzhw0ExGA8ckH5z5ObL1x+q3dSVU/J9CWHZgFWalgfDL+nSE1iwMofYm/i?=
 =?us-ascii?Q?3E/M0BFEMxO0/bQTiPcencu6V+uPdZI7pMYm6oIw+m+aoGOu0nfCUM98d8Ap?=
 =?us-ascii?Q?0ScQo9OnScGxYXm4LqiUZXo0bg+95USwbvmEai+e0GTAUFxgb54OAXfZvPAV?=
 =?us-ascii?Q?Cd9hH5G3PJJjhmeYnvz/0D0Li7x/fJBTbk0sihAPElDorNwaa0ydv7C4d1El?=
 =?us-ascii?Q?xG9Semfdg/CIV4o5UIRUMoDjUgu92UPWuIOLFI3RU2Pu4EqC5KZ8MmbkO9sd?=
 =?us-ascii?Q?i4udH7/YZm49zr0Oj3T6fW8jZuTH54Z0OdrYXb+mZdihjX5fPEDNZX6Pjm8Q?=
 =?us-ascii?Q?ImfdeiLbztXXDwq6oUgIA9GbssLt0sJZojGaLQVqc1ymV7xHPDNI6nPEC9DR?=
 =?us-ascii?Q?BsTpchzhZQ1FCg4x0wT0k0XYgJgox9IuPhiP1Zyt8Z3d2Ikf/EhioN/d38o3?=
 =?us-ascii?Q?gqftj/lwdcgR4NkXXnETImo8ab5vu6EyGRebRMaDKmg9JfYWEwFJRWvGmZGu?=
 =?us-ascii?Q?MklsSpMJOEMOhuNboiam62bfMM+x3DAS+3oeMy7PTGWeRIIoqOwY0L9WKSB7?=
 =?us-ascii?Q?zYtf0g8nINyOOUokvGAU/Y6ReYfT/UTPoFU+OvJyyXlJ9YqDJOKE89kivwZA?=
 =?us-ascii?Q?Tlwfa8IVJGmq+G9DvtyJcP+9nutvZPZGJ8OTBBypO1dYmzoGw8hXTqjuMBxW?=
 =?us-ascii?Q?YWAHi3j0wOanYckvqUfDFZ6WqAGyL10FUsQQzEHKQuHqwrRMlKGac6xsz9vj?=
 =?us-ascii?Q?8fEep4sdmAm8W0PvDHZgaO0b/Pu7sKK4FX6u+uHIXEmspRBXTp3DDfEDNKK3?=
 =?us-ascii?Q?4rA6GDRqrj2nqA7PydkNN9KYXoiwoqkK+RrKyIBxR22XSoieF2P0uxhkLOKH?=
 =?us-ascii?Q?NfFTFP/c4pXfR4W0v5sJMFcMY0PpiBLSuFiPmgukNS/hesfO3OUeBWVzV8ZV?=
 =?us-ascii?Q?Z+V3CL2tpy3s4k+qpJGGhvVjLVFqkSYQWvV9vz3iyYUjRqaRdEF8KwhtfPsE?=
 =?us-ascii?Q?iX3w9AXPnh5s8VKFOySIxmfVkK+RqMroHbR56gu5P73AKdfLum4muQ8Zy0/E?=
 =?us-ascii?Q?mSleK3wgNvzY5+6CtvC9gJvrvC+EHo/CcFHBaF2sgQag70o5BCTZa0Xq7EC9?=
 =?us-ascii?Q?4bmO4TBDPRlpC73adnHhiPkSEBQ3JhS8/C/4aMr9qddgnjQ5Ry01azOoCFLo?=
 =?us-ascii?Q?nd1Lh3vxRKiWD53DmKwyFZsmyVwTTj4J14b5T3pwmd/4T6OqmNWQVuN+M/Fh?=
 =?us-ascii?Q?kXF8LyP3DCoaBzet8tNu+IQ+dZc0QGbkqNQ09X89N3axlHW3SOnogmCLsulf?=
 =?us-ascii?Q?PJ3FIqxcxIfJvsJpOR3lyTjj0IZ7OzVOFmSBUNcdyN+ftCIAMEs49DRJ4MGb?=
 =?us-ascii?Q?G/LF6Wg3qOoGu0SM7AvtoEKb4dzoJ+NkGGbnejXSqnE2DNBpL/SmcveZu1IZ?=
 =?us-ascii?Q?50OM7akM1YAiBE4nfP/tFPxWdkxqKBs0Xro95+kZO6inmd/D1zD9X7WBu9ul?=
 =?us-ascii?Q?uqJlznEkxWNgf6cJ36jYwdpMjjU4usVXS5vMEaYqt74M1JgK3uo1iO0G4SY6?=
 =?us-ascii?Q?wF9iaKWhPo3xvUfrKwyETMsvrdXkLgWmpSIsr+1/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819ccd92-ecff-4790-ce6d-08dd50b618f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:21:58.9127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hg/M6eqqTH5b1+kSRpmNP7Dzdicvh6SQeYnqbu3KfdADaRbNdg/EZHI8Crc4zZguygjJpo90BS4JiZhX4+WA9NOQCi9//e2xpgHo3VMKc8o=
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
Subject: [PATCH v2 11/26] arm: dts: agilex5: Enable XGMAC

From: Tien Fong Chee <tien.fong.chee@intel.com>

Enable XGMAC for SoCFPGA Agilex5 devkit.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Link: https://lore.kernel.org/all/20241204064755.10226-2-mun.yew.tham@intel=
.com/

---

v1->v2
- include Linux lore link for Linux upstream progress
---
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/=
socfpga_agilex5_socdk-u-boot.dtsi
index 9eb21d65428..540b2662283 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -3,6 +3,7 @@
  * U-Boot additions
  *
  * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
=20
 #include "socfpga_agilex5-u-boot.dtsi"
@@ -122,3 +123,36 @@
 	bootph-all;
 };
=20
+&gmac0 {
+	status =3D "okay";
+	phy-mode =3D "rgmii";
+	phy-handle =3D <&emac0_phy0>;
+
+	max-frame-size =3D <9000>;
+
+	mdio0 {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		compatible =3D "snps,dwxgmac-mdio";
+		emac0_phy0: ethernet-phy@0 {
+			reg =3D <0>;
+		};
+	};
+};
+
+&gmac2 {
+	status =3D "okay";
+	phy-mode =3D "rgmii";
+	phy-handle =3D <&emac2_phy0>;
+
+	max-frame-size =3D <9000>;
+
+	mdio0 {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		compatible =3D "snps,dwxgmac-mdio";
+		emac2_phy0: ethernet-phy@0 {
+			reg =3D <0>;
+		};
+	};
+};
--=20
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
