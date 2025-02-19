Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E858BC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDADD80FA0;
	Wed, 19 Feb 2025 14:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="dISbc3wF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 340A7801DE; Wed, 19 Feb 2025 08:21:21 +0100 (CET)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4750801DE
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:21:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZ9gkv74kroysA3vdNFStETn7JbuegyzO2Hy4wqVhr3U0mavoaWrRp581U9xyNhCFon//P9e85mXFvfT75I1Yv9sKCbFUK48+724za/1q0J30JL5uUhVFnjbICABtMq6LCu/Vqc4aAa+2EUubPz3RI3rv9CNe19UpuV0xZaQIp975wji0FZwEaG8QRTDOO1LA3X5VQmYJaWBTp9a18PogDODG8v6Jdg+srinu78N/PAAZ6KKPGZn7WFNgSmhChQNKJ7UvADvOb1MWnEhGxg0uf3Tz/sEo4j4HlUNxrJgQxhZVOfex7XFPZEA0a48b3pOYrXkeljsVbHeUCHzPDp85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uasscYZABoS4WRcU74HEd7Upzj/acKXIcTt7MGMlRek=;
 b=c8ALLasy22PVaovVkBE7OGsfL4lULKo98dbBLLjxIB7xYa584ARt89Jk4XQXEG4YIqndrnWI0nNDvOwRPfZjqUCBbECDVdgVXg3jC8VfdeQzeIoOpGCZAovLGFptuDgpjrT8dXR6VWpcXEeOssxKfq7NLu2V5LxbRoGySN7SBHS2f2Y7+dHaUcdgYbeRypluaweI4zRNl4cRn3zOQdakjiXAz8eFPGACprcg2uGqBAo9SzizfllE88dh8cynvrOxwd5tWd/yoGPHQNI/XIHD5QJilFwzXbfMvQIT4xxCrdAxmtRMdrGufoO7z6h5m4C37c8Y3ZjphmBwPHmazdUHnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uasscYZABoS4WRcU74HEd7Upzj/acKXIcTt7MGMlRek=;
 b=dISbc3wF8h0awsdshfWZH4/O3CkgSKwQqtrmlnkX+6LTrElwqgq7ywfRmPCDDdjK6vEAImShwvqKjRTJ7luF0VgHoqq2cy8NZGEd2f4pxWaXMi8h0QjCOuiGJfVLwX54aWdcJ5U85kXJZUgNPjkDmzgR8mC5S8YnX+quIB1R+JbFtQDvHDCOuSyGVdeieIaDcorX/I+3kxCB3RYVmjLL0nYqFQKGkW6Y3YLEnd6vyDX81XWzBjSz7iZycm2Zs53iubOpCIQvCbKEgzfB41z6ARPsZltgu1x0eCmyGjWC2jk57e5BUVyyDnCB7JaDwoYqVGKYscjSTbBs6+r5GxKRyQ==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by PH0PR03MB6679.namprd03.prod.outlook.com (2603:10b6:510:be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:21:15 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:21:15 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>, Tien Fong Chee
 <tien.fong.chee@intel.com>
Subject: RE: [PATCH v2 09/26] arm: dts: agilex5: Add HPS cache coherency unit
 configuration settings
Thread-Topic: [PATCH v2 09/26] arm: dts: agilex5: Add HPS cache coherency unit
 configuration settings
Thread-Index: AQHbgeAcblBh+rNbqk+ikRzc7bw8rLNOOe+w
Date: Wed, 19 Feb 2025 07:21:15 +0000
Message-ID: <SN6PR03MB3583A30A9EEB9D019E2C1232A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-10-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-10-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|PH0PR03MB6679:EE_
x-ms-office365-filtering-correlation-id: 73681c78-e974-4740-a6dc-08dd50b5ff45
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?dUQPKLN8myVCDAlH+nFETbyNbHP9HajK4JHA5nbIAeHDsolU3kjB696YvLGc?=
 =?us-ascii?Q?ygETsPzWHTFNq+26jd8eGlBNGyovLd56jvBfBq5lmCg/4MTc/bNtdXMa6Cut?=
 =?us-ascii?Q?6/dQIYbU9p2pkYNkIPX0y9hOmP3MWc/jbNvHbbZ0oSVdcMkbvhcgbQUKZQEu?=
 =?us-ascii?Q?chJTHxKKcp2Q8BjsYExy7eECTX2vZF4oyM9j4jjn5iuCR4YA5cJdZavGaK6H?=
 =?us-ascii?Q?Uc5XEd/rl4wozD7MnfT6GwT9T1z5DHa5N3njqqtg2Jqbm+x8CTnU7AiI10A5?=
 =?us-ascii?Q?hhZUAX+JZy5eVYjgJy3MKaOjtebI9Lc5Q7j3qijRbhHimkLvgZFjOfgA+ytE?=
 =?us-ascii?Q?FihB0dvXo89MR2TcTKHxMb2pFUQDuUq8Mrfh6bqkywN/A7Klqg5oJSC4iaDF?=
 =?us-ascii?Q?qJgmaOO1IqWVCE4LNZNu7g7fG3ulDBMOgVE8VPvS8lzO8Rr+sovLCKRE2lXx?=
 =?us-ascii?Q?HgGMrS0EfXhU92nIGR+PYfig0beN1C00y9A29dRBhjTL8TGONK5eUZe7cZYR?=
 =?us-ascii?Q?Df2GOjHXwyAwEis9nz+Yg8U8bP/guyo3OTj9x+zyy9c/e8frGxe96xPHKsX6?=
 =?us-ascii?Q?/fI7X9q33TX4dhjiNM3Qqu7VEWNA488iJQRySR53IcjFfdnXy3klUWzrQqKz?=
 =?us-ascii?Q?Lh0nyfEXnszeuyoLDe5U1qGbfggNn2NvWB1Mu5Pf7UeNdKnQnrH901q3/K1B?=
 =?us-ascii?Q?Suxs2FjWvSZPQ7aUNAn2rXNuKJUj7G0KoXehm2JODZfX2uiQI6+219eXHWHB?=
 =?us-ascii?Q?hWqbbkeAPylRhFcN2LJwCeB/TfSscpjX8pY8t7ccFXRGRCMcCXIOZldte4/E?=
 =?us-ascii?Q?82QPUcyDYRd8BAeSM6Jko6nzxNzsW9wTkeV3MVINOKC5Drg43qssnncxhsBO?=
 =?us-ascii?Q?3G3sn9IQSletXTy/ga1ayap9Y/3xAHm9xMGrK0t5mIemj5H4z8qSRUzLXaLm?=
 =?us-ascii?Q?Wt/RwOya+GS1rdlJmW0H9m3H+PL0exs3gsWrI4kjfP2rTKq52XPm4RplfUy/?=
 =?us-ascii?Q?dvM4YAqe7ejHrE+WhME1LJ1ZmJdOQIIjot4fS7uS5o6eRAnkv+rN1n5iPBnK?=
 =?us-ascii?Q?MdxIxDeuAS3bTZW5by0juD3T0wlJwbMz6sd4JV8M1J/8wxvQLLLdfTwytD4l?=
 =?us-ascii?Q?Emn0hzZejoQZbBYySuYqNxzj+5wxpWUVOb/P6V/rH28Xhqs0PsInjSkTedxF?=
 =?us-ascii?Q?GcxtojvaUEnvkSh3IR/WzJnMi1dd73/44OiAsBQleBxlaIe8AMeYHpZvwS56?=
 =?us-ascii?Q?QpURk4P/T7saoEwKbX1OgNFjTGBsTywJh1MFyH7zI9N25UIOZWI47HVOS8wk?=
 =?us-ascii?Q?q9xVu1yLuaQVdVodnWA6UVUkKLvfPLrhidBZvxcf/gpkKggs5TTfm/JnfcwJ?=
 =?us-ascii?Q?5XS8r00Y7QDDv7uXjpVKmUG6gA04?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mjDFShCymq6EjTXhE32cP9Vo+i7BPHd0BVdCsHZ38Rfm/lZhnPP56TLRHwcj?=
 =?us-ascii?Q?HzWVvIUsiwn5CHxWw8XZch5vL/NyntXyXA0UqQuSaSsOWoGOGb05FOerJ8An?=
 =?us-ascii?Q?wp+7DPQvXCfWzhG7sw/vY7M8gCHhXDkOjG3wV+15svKAVKBI7Y4k8RPpIjn8?=
 =?us-ascii?Q?5ehBDQZD2ga9c8XjOpqIu2gnhbavINqWxLy7sGJTzLc6AMnuIVF8XlIBZKGI?=
 =?us-ascii?Q?81bLvQO22Hid2nW61pAhImKZuAorJvPEsXsVorSVfywgcm7qAGr+pgJgdEYs?=
 =?us-ascii?Q?HK7vMvACb7CZmNS240JrTBandRcZADf+KEjP8YN7Srg/BNLLmO13FQKJz1Wo?=
 =?us-ascii?Q?S58a7vE9fZWm/OdLRfenf9PPlWbHd/7m007HK9OM1+PrMCfWyhlqYt89Cnha?=
 =?us-ascii?Q?chXxFFUKgOl7eFCevwz9XI/ec04e1E1rsbhlwFvXMu7y9+URk6I40ti1YXiY?=
 =?us-ascii?Q?QJgBP+z1cfRW8qmoKYs73IwClWanitDPqOH1xYW1n2dnNmGXMmmx9e8pp57m?=
 =?us-ascii?Q?WpRwJlFpLwyvp+pOfzrAWWxwpyFpXeuwuanqhwFhcgXnW08VXKG6co9IcFZk?=
 =?us-ascii?Q?xfKUP5xBQ5AMVjtZpFEKovkgZEvcrSGkdajfvdXPSMhHnFwnbT2WTMEjCvpy?=
 =?us-ascii?Q?JbUrv8X3hzHERymQf8bIvaNEN3l0IMwrBpjaVJoS8MTB9k7icn+vJn3lW8AP?=
 =?us-ascii?Q?ScnqYinJBT6gwoHpvVzZomlopCH15ayVvhHxdMYsBa0R8e37T1j5t9GEbeCG?=
 =?us-ascii?Q?m/9suttdCryoTbpRaXX17HSLybHirY9gghy1oiHbGppTkYcv3wXcbIUtRGde?=
 =?us-ascii?Q?AY7FKuN94ewqfPy5UULrQcWpkQeare9GfMx+/WuJcV1dLjOTC1+XtFZjvYdH?=
 =?us-ascii?Q?frb5TchMoN0hgFWaW2/KXnzvX073rlpKhQjhsKXXvvbFVmQjaXTMJyaWtQuW?=
 =?us-ascii?Q?YGqPeeyhj0I/wcTSwZ5eBVgNV/pzUvq68p8//OxqL1C2ix9dSl7p6ajvn1+S?=
 =?us-ascii?Q?OW74U6Zphwih+RwoMtCBDgE+pmHiB9aYS2zga3aC01bDd36/ydiN3AK+kPWy?=
 =?us-ascii?Q?slG7RgkTBDM19iEhfMf/9xMFBw9DJPqobEos+9+c/TLkc2l450eaY9GzqNQx?=
 =?us-ascii?Q?QHZfY0Vfw/1A59AOhntASlkSNPUIA2fWzrIEvuxlSoPioA2TZ89RkiO+bojT?=
 =?us-ascii?Q?BAjaV8c9fTHn2frIaLSd2KvnZ7zjeQ/NNCTZ5e7lHL1C6KY62dY5F7lMolG8?=
 =?us-ascii?Q?gV1VumZRGo0AlNe8tBpvck6nrfzVmUwW71OyQx4j+nsbH7rWiYf2b5L9I+3q?=
 =?us-ascii?Q?hb+wFpwxUASo0E3VNFaUWzbF/EkzY20kM1sor4MuahMVHU64d/684P3XlO+B?=
 =?us-ascii?Q?vwQp9DTbiFZcutTNKDxcFgN1mBFS+kh+fGWAgKwj0fOz3z8+XyFxxgHzH/gA?=
 =?us-ascii?Q?jM/CjQdVtz2/Hi5VhDCRrdf5dPTF6wKPkA0njo7PDu5yTuJHQuwX3wVwtZo/?=
 =?us-ascii?Q?r/c5vMiX6w6nBQulHKxWiK1gJmniviYhHHIE1nGi/LxLAl8IuIPYBf9IoAo6?=
 =?us-ascii?Q?emQQU+PYcGnmXTj4siVuh0uFC7eQ9MlHNX1yg0hX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73681c78-e974-4740-a6dc-08dd50b5ff45
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:21:15.7918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbHLMOtdra/Slkjh6wPORLinBERUdyS7zh0TLnquLzVwaDSubnWpU5gcdlSUtG5v0LtwJlLS+zE6f5ZbRPiKgTp24h1tNiqdNzibMMxjl8c=
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
Subject: [PATCH v2 09/26] arm: dts: agilex5: Add HPS cache coherency unit c=
onfiguration settings

From: Tien Fong Chee <tien.fong.chee@intel.com>

These configuration settings are required to enable cache maintenance and a=
ccess between initiators and targets.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi | 210 +++++++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpg=
a_agilex5-u-boot.dtsi
index a8167e5c14a..4270dce38df 100644
--- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
@@ -3,6 +3,7 @@
  * U-Boot additions
  *
  * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
=20
 #include "socfpga_soc64_fit-u-boot.dtsi"
@@ -13,6 +14,215 @@
 		#size-cells =3D <2>;
 		bootph-all;
 	};
+
+	soc {
+		bootph-all;
+
+		socfpga_ccu_config: socfpga-ccu-config {
+			compatible =3D "intel,socfpga-dtreg";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			bootph-all;
+
+			/* DSU */
+			i_ccu_caiu0@1c000000 {
+				reg =3D <0x1c000000 0x00001000>;
+				intel,offset-settings =3D
+					/* CAIUMIFSR */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* DII1_MPFEREGS */
+					<0x00000414 0x00018000 0xffffffff>,
+					<0x00000418 0x00000000 0x000000ff>,
+					<0x00000410 0xc0e00200 0xc1f03e1f>,
+					/* DII2_GICREGS */
+					<0x00000424 0x0001d000 0xffffffff>,
+					<0x00000428 0x00000000 0x000000ff>,
+					<0x00000420 0xc0800400 0xc1f03e1f>,
+					/* NCAIU0_LWSOC2FPGA */
+					<0x00000444 0x00020000 0xffffffff>,
+					<0x00000448 0x00000000 0x000000ff>,
+					<0x00000440 0xc1100006 0xc1f03e1f>,
+					/* NCAIU0_SOC2FPGA_1G */
+					<0x00000454 0x00040000 0xffffffff>,
+					<0x00000458 0x00000000 0x000000ff>,
+					<0x00000450 0xc1200006 0xc1f03e1f>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					/* NCAIU0_SOC2FPGA_16G */
+					<0x00000474 0x00400000 0xffffffff>,
+					<0x00000478 0x00000000 0x000000ff>,
+					<0x00000470 0xc1600006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					/* NCAIU0_SOC2FPGA_256G */
+					<0x00000494 0x04000000 0xffffffff>,
+					<0x00000498 0x00000000 0x000000ff>,
+					<0x00000490 0xc1a00006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>;
+				bootph-all;
+			};
+
+			/* FPGA2SOC */
+			i_ccu_ncaiu0@1c001000 {
+				reg =3D <0x1c001000 0x00001000>;
+				intel,offset-settings =3D
+					/* NCAIU0MIFSR */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* PSS */
+					<0x00000404 0x00010000 0xffffffff>,
+					<0x00000408 0x00000000 0x000000ff>,
+					<0x00000400 0xC0F00000 0xc1f03e1f>,
+					/* DII1_MPFEREGS */
+					<0x00000414 0x00018000 0xffffffff>,
+					<0x00000418 0x00000000 0x000000ff>,
+					<0x00000410 0xc0e00200 0xc1f03e1f>,
+					/* NCAIU0_LWSOC2FPGA */
+					<0x00000444 0x00020000 0xffffffff>,
+					<0x00000448 0x00000000 0x000000ff>,
+					<0x00000440 0xc1100006 0xc1f03e1f>,
+					/* NCAIU0_SOC2FPGA_1G */
+					<0x00000454 0x00040000 0xffffffff>,
+					<0x00000458 0x00000000 0x000000ff>,
+					<0x00000450 0xc1200006 0xc1f03e1f>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					/* NCAIU0_SOC2FPGA_16G */
+					<0x00000474 0x00400000 0xffffffff>,
+					<0x00000478 0x00000000 0x000000ff>,
+					<0x00000470 0xc1600006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					/* NCAIU0_SOC2FPGA_256G */
+					<0x00000494 0x04000000 0xffffffff>,
+					<0x00000498 0x00000000 0x000000ff>,
+					<0x00000490 0xc1a00006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>;
+				bootph-all;
+			};
+
+			/* GIC_M */
+			i_ccu_ncaiu1@1c002000 {
+				reg =3D <0x1c002000 0x00001000>;
+				intel,offset-settings =3D
+					/* NCAIU1MIFSR */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>;
+				bootph-all;
+			};
+
+			/* SMMU */
+			i_ccu_ncaiu2@1c003000 {
+				reg =3D <0x1c003000 0x00001000>;
+				intel,offset-settings =3D
+					/* NCAIU2MIFSR */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>;
+				bootph-all;
+			};
+
+			/* PSS NOC */
+			i_ccu_ncaiu3@1c004000 {
+				reg =3D <0x1c004000 0x00001000>;
+				intel,offset-settings =3D
+					/* NCAIU3MIFSR */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* DII1_MPFEREGS */
+					<0x00000414 0x00018000 0xffffffff>,
+					<0x00000418 0x00000000 0x000000ff>,
+					<0x00000410 0xc0e00200 0xc1f03e1f>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>;
+				bootph-all;
+			};
+
+			/* DCE0 */
+			i_ccu_dce0@1c005000 {
+				reg =3D <0x1c005000 0x00001000>;
+				intel,offset-settings =3D
+					/* DCEUMIFSR0 */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>;
+				bootph-all;
+			};
+
+			/* DCE1 */
+			i_ccu_dce1@1c006000 {
+				reg =3D <0x1c006000 0x00001000>;
+				intel,offset-settings =3D
+					/* DCEUMIFSR1 */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>;
+				bootph-all;
+			};
+
+			/* DMI0 */
+			i_ccu_dmi0@1c007000 {
+				reg =3D <0x1c007000 0x00001000>;
+				intel,offset-settings =3D
+					/* DMIUSMCTCR */
+					<0x00000300 0x00000001 0x00000003>,
+					<0x00000300 0x00000003 0x00000003>;
+				bootph-all;
+			};
+
+			/* DMI1 */
+			i_ccu_dmi0@1c008000 {
+				reg =3D <0x1c008000 0x00001000>;
+				intel,offset-settings =3D
+					/* DMIUSMCTCR */
+					<0x00000300 0x00000001 0x00000003>,
+					<0x00000300 0x00000003 0x00000003>;
+				bootph-all;
+			};
+		};
+	};
 };
=20
 &clkmgr {
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
