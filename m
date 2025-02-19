Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7715C021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7950680FC9;
	Wed, 19 Feb 2025 14:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="dTixyxjU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56F4E809A4; Wed, 19 Feb 2025 08:23:05 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F005800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:22:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhRQUagupaP2cgbr7kZI5WUmHM7vCxbsLtArQ8+zHeizz68v8NYCAGOV19AQphuxljPKwCTGEnb5bfR09nw0CextaZwPNlxWN3N7aGifoWpH6jox4N9XrlZdXYxWHhULDRWEmlAM1TUmumYV7YrFQLEeJPkvYVh4CSGb7XThUZd4D997MD5PIwQwnHgitXR792njPVk0gg9004F00sflsgU432YTe9HQ9TFB9m2fGnRQLDgGey69P1G5jAmecZ9iTCjXsCMz5X+WtpzwA+KN9/Es6Wghe7cRVkZ0ADDFoE/4P6fXmfc2ZNqR1lSRwq6W/ABxJvK1PBZ7xrUT4z5hLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWA7J0d8XZ80PCr2LHA19iGm1HGml+PkYuE/DH6IwIo=;
 b=pwZBBoxKEAjOEBB1INt8da6RJEw3UsAvZXg5UDvSutr751kNEd2gs6wVuHDWnYCuR2VQuHsRH1S0EENU4wbmF92jV0WB7OdYSV7nydKOb3Cx7YITOfs7W/Xmx5tORH8ZWuw0mNADBo+uJpsI7jtQ/voINOy066T2ys60na/OCecIBFq8QyffYcvHDlTKeZFOAbz24dVKV/niGhAF2r8+d/rhjOKPL8thVOhc93kKsFG5ITSrxjc21+v8a0KxZXmm1p8HIJrRKE6rJDzinZUKN/SNhDxzKiZjxBweWlVmsG9PVstbk//zh/oo8Q5SlnJGVIEBO+10LefwpcjgNW1B7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWA7J0d8XZ80PCr2LHA19iGm1HGml+PkYuE/DH6IwIo=;
 b=dTixyxjUsxNvUgsb1InlXgTVxRQy4O+OGzKnsWkIrC5mzEXPBpa0T3pIu21d4tqPB1B9zeozRPgSra45VOEK58t48Ckn/9jXuMTy4YAkAdJ0S7jx4DI7rG07gRKmfHLXYEs55zZ/6TIoQ05RjbHCSCpD/GuDYvsvlO05YA77ql46r555TVk2hU8pz8zA3Rf4TDTrKBW5Rz8z6SxqsssL/87QVoaKfJz5OXdeiXBZiAdqfkr1f5Nez2IwlvMSAGsBQrBZ3dqi+FEXUzFXWvjujsEd+ZSdrCQTusoDgllANCHDOmo9Dt8TseyySgFftaR37tUyFxJpGOzA5yXIUS0sQg==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by PH0PR03MB6679.namprd03.prod.outlook.com (2603:10b6:510:be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:22:56 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:22:56 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>, Tien Fong Chee
 <tien.fong.chee@intel.com>
Subject: RE: [PATCH v2 14/26] arm: socfpga: agilex5: Add SMMU initialization
Thread-Topic: [PATCH v2 14/26] arm: socfpga: agilex5: Add SMMU initialization
Thread-Index: AQHbgeAhjVy0e4E1vEugKWzeKOOhubNOOmlw
Date: Wed, 19 Feb 2025 07:22:56 +0000
Message-ID: <SN6PR03MB3583A45329021F9269412966A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-15-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-15-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|PH0PR03MB6679:EE_
x-ms-office365-filtering-correlation-id: 63de47bf-ab14-49df-7256-08dd50b63b6f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?BhGP3RQw1ERM1K3N/MxG30t8qTIIL7GcOjouuf8A50qKHaLlkLfvFJe/oHzl?=
 =?us-ascii?Q?LKSxRd9MB4m3RcKMQ0KPPsELThQSKlTvTqXNMMp/mtHuET63V3ghk6IfKkrH?=
 =?us-ascii?Q?m0WgO0TY60wP3udGOHjVI4OszO2MT6XbufiI8kHl8dA+LKFFm0ggNKz0NZme?=
 =?us-ascii?Q?W+KA8ddBKq4wBgakySvTR5+iNKd0sluM4UNlVV7wnQ/MTNnPWaWZLNDYb/2t?=
 =?us-ascii?Q?ExJW3RMrtTcn66YGn6q1DwGwEFDdfZDYvFlYt8AJkoz4C7bEFDk0jzzYDqe6?=
 =?us-ascii?Q?2BX/c8dzPjQaIopz7DEFwzP9KW8bboTyplKxDr5sxJD++CsREu3R9mjBYP6D?=
 =?us-ascii?Q?qpT7mYBUHs7MmBOoZyUtEubJMTrUJ6f2UeT+QGQaFIIbtiKIGvtYzGydWLXn?=
 =?us-ascii?Q?Xw+05M4FCKlNcq0Yh10pFHTn0Lu709uDTgb5+Hg7LtTX+ta2laI4CtkFcbTf?=
 =?us-ascii?Q?vJ6bYjVFMIntZDlUBrnLDb7RC2OIBSFFycLNJ/IdLEkxqewk2Vh8/id4R/DZ?=
 =?us-ascii?Q?t493zVZS/aUf2tBVQojDICu6Xo1K3K6pHZTlf97uSvVGOY4+DywbcyfC6QlX?=
 =?us-ascii?Q?zgtX2CEFN+YCkFEhQUVi1UPsT5IkCsLn5hP8rEBEC0fHKQJFqWqHozmlf5+g?=
 =?us-ascii?Q?MnJJm06vJO+i6gdlVDztCfngcCGfsHEGOfuJdFLYCMuxJal9QnJkOKhBIy8U?=
 =?us-ascii?Q?gMRqYujDFOTFvopcY/y7T3s8pbWjK9Ych6DkCN+FSByCHEZIHfLSfYmf8Nb9?=
 =?us-ascii?Q?qbxgdu9DxpQr1JL8HH5XnddFfaUCGUmfw6gFZoIBEdqmORXuAZWzwaNY7Oil?=
 =?us-ascii?Q?2m9e+9x5Eb4FSIdTIZHTxvyrqxyyXQ/nQoAKu6PeNWmPak0tispmaH6QBLXV?=
 =?us-ascii?Q?H5NunSY0v+dULEF7kR6ECzBSelUhF4GmH/O/4bZM9atM+tPJXgRjYgvLkiDd?=
 =?us-ascii?Q?b7KZwHfpgJCG1yQ1NIozQYvxuVPuYLfio6LYoXqzUmAsvdQ6A/+0XS6P3jyI?=
 =?us-ascii?Q?nZB7OhefJ2t96/iAaX5b9bFVCuoHSWIqcd5usSLS3903TQ1eCsWKjdyl6UuO?=
 =?us-ascii?Q?5LMhpAeCLrrTguP+crcbiPyS1wb8s+VSGi14xLWzlL9bAVrqD+5QQjueWRPm?=
 =?us-ascii?Q?SkGv1kltygU0G8hNBtpDQyoVI7J59YY0oMhuDminn3IG+disZo2MyGRYAilC?=
 =?us-ascii?Q?Uf4M+AQm3YqxD4XGHvIYaR+1ZVV1mVKCmShDiJKYQo2X4021Bmav6gd4r8e3?=
 =?us-ascii?Q?TGLLKqCJkYQ2jRDbEIbistVRRXqQJR4PfhhkTANvq8YR6Zx9VCgDP/0nIfh1?=
 =?us-ascii?Q?XzdLFu6FqAtY5X+2jHBDOAA4OhnMepftDOUH0iqehtBEBMTQAThAdlm3ysn0?=
 =?us-ascii?Q?uuCcHSIN4NnVklXOZp68hJAryBaf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7QjsQdYuhCT/6Gj+g/K74d/6+LZON0tZKLMb/mHmHzURVz12+qneY+Woiytf?=
 =?us-ascii?Q?HBuO5y/3qG3ivu3k9IOa0pi0Cro+kczBUH5OX3li/vvIp+mE6B1LAhoIRGsE?=
 =?us-ascii?Q?zcWAbUFNzPBR2M24c7ZsJ9c1LkVTyTmCoOOAyIDJBd8pl1aYvieYyBvJQrlO?=
 =?us-ascii?Q?pUSw3bKvQ/nRF9ZrLWsm0AL4gOThFNaV/MyMiT1unZaOdPdylGWW2CkW7mrP?=
 =?us-ascii?Q?7tWCdCBWGLX73lGnEcNuY21vLEiB1M+fO3cHEZIJVfbNvsG5aJk5/SrJP8ZB?=
 =?us-ascii?Q?9TN7KzLjYmWGaTHj2uHVLhtlAUqEfgeXAAR/xIWKbgvlNYYFl7Xa0NkEA7Z8?=
 =?us-ascii?Q?yEj+9EyZx0pgdYwbbLIevZY5jZ8WKyjYZ6FGuA2sgY1ogZQHIyZd9cvfvoQO?=
 =?us-ascii?Q?Q1x1LaMOFrq+RXwEU0oTjQgWE9TlmxXLS/Sr6LOYgahikdffCP90XdK4vGkX?=
 =?us-ascii?Q?C6khn+A7IBTk1cuR1oYBHSx4KdYCVLtvqNitG5uGwNkFvLIe3V/susbxtX4k?=
 =?us-ascii?Q?NQltfriFFHd5Ry0+aQAUHHixMXE5paKwOk4MkuTMcrLHDAUjTnlQzNPI8v4j?=
 =?us-ascii?Q?OxiW0M2n9wSLesf/3UmHbMv0AtxEdSWCZJghb6Bz+UCG3I1RjfWk0W/C3Kd8?=
 =?us-ascii?Q?2AJ60ID+qSk7P1AuyV4uOquAaW0vY4en34dfix6p8fYBINiaNe/GI0ztEvUr?=
 =?us-ascii?Q?Xbvsk9KufL3/OPPwTCfVEo4c2YBPFAgGYZdyRuJu09ijQBdZS08rNyOWZiA7?=
 =?us-ascii?Q?9WoB5FTGBW7SXthdVG/KHE3nelyatfc+tAQfjQftknERDAF1vZtjgB27ue8J?=
 =?us-ascii?Q?7OvrLEeSjH9i6MvaOef+gktJxsXAlH6fg1mdRNyC7E9rm3aA5uwBF0lbLrQX?=
 =?us-ascii?Q?9Y2cK3wZnm1bcts6FPT3p4N3iqR3czU2AJUrulAEcviN74UirVKdpUErFGri?=
 =?us-ascii?Q?tyOCsLdJTAVmHqFC2lPlFWso2fMQ2NlYI0+2BEpiryFyMU2+WB/kuzJt1mxf?=
 =?us-ascii?Q?vMUxjklhMdCVPqcp0L0DUm0IWHRzaiVXkT+H7t9flf/pbIH92Zw53MpkfJiv?=
 =?us-ascii?Q?+RnVEYPDGV1bFF1EHHMCtazWL37ZLe2jnOemEBQSxY2UOXLY8b8z26NNA5AR?=
 =?us-ascii?Q?hRtzt/cwbK24ct1ZLBA4Vsc9fW7ESiip41CoiQQJC5EQsbsn59baZVD1Rmj8?=
 =?us-ascii?Q?/mZVevpceFOLR4Sf1fhq3A+dnpiL+AW1RJy+g8GVWvuK5ocik4P+3QeJr/ZQ?=
 =?us-ascii?Q?Sh5zUCf2+7nOd1mjNPplbTMo7ZDFdse1mdqT5L4scYAZS+RZT5nljZvdp/ci?=
 =?us-ascii?Q?jyBvuZWpugnyJ1jEboCEOAIi8uUP414P6HFryWqtRXTHAjjUfmnNp5h04mpt?=
 =?us-ascii?Q?6uelgQMuCKz1zWiSdDCutx2nLxBo1MCYthCtlksFHIR08qE8cxo04hF4zKEO?=
 =?us-ascii?Q?JaQRIUaZBFOIUj6tDQ5nmUQkD/Wi6PWX8i8kOUonZ5FeYyyAwy2W7w/SHkXR?=
 =?us-ascii?Q?NIXeN1Lwuo/Ukfs0QkNKbukxujIVSAo/73W28wBtRYiwSlstRDmXBDwDxE5d?=
 =?us-ascii?Q?P4HtpIX1JWOm7h0M+YFiKwZgr52mr4Zeo7BomNiQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63de47bf-ab14-49df-7256-08dd50b63b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:22:56.7683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ky8Vz4rRAsw1lMTI6tMUj8nmYSlqA2xDUD6DnI47Sajh9oFfXT5DVK5tRaZeHlCtEjC+MugZ8fUC/WfO8kgKgcplnjnVEFJZCWZu6JIhXw=
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
Subject: [PATCH v2 14/26] arm: socfpga: agilex5: Add SMMU initialization

From: Tien Fong Chee <tien.fong.chee@intel.com>

Allow non-secure accesses only with SMMU peripherals. This would protect th=
e content in DDR secure region from accidentally modified by SMMU periphera=
ls.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi | 34 ++++++++++++++++++++++++
 arch/arm/mach-socfpga/spl_soc64.c        | 16 +++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpg=
a_agilex5-u-boot.dtsi
index 08f568f5650..af3f5d32f9d 100644
--- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
@@ -388,6 +388,40 @@
 				bootph-all;
 			};
 		};
+
+		socfpga_smmu_secure_config: socfpga-smmu-secure-config {
+			compatible =3D "intel,socfpga-dtreg";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			bootph-all;
+
+			/* System manager */
+			i_sys_mgt_sysmgr_csr@10d12000 {
+				reg =3D <0x10d12000 0x00000500>;
+				intel,offset-settings =3D
+					/* dma_tbu_stream_ctrl_reg_0_dma0 */
+					<0x0000017c 0x00000000 0x0000003f>,
+					/* dma_tbu_stream_ctrl_reg_0_dma1 */
+					<0x00000180 0x00000000 0x0000003f>,
+					/* sdm_tbu_stream_ctrl_reg_1_sdm */
+					<0x00000184 0x00000000 0x0000003f>,
+					/* io_tbu_stream_ctrl_reg_2_usb2 */
+					<0x00000188 0x00000000 0x0000003f>,
+					/* io_tbu_stream_ctrl_reg_2_sdmmc */
+					<0x00000190 0x00000000 0x0000003f>,
+					/* io_tbu_stream_ctrl_reg_2_nand */
+					<0x00000194 0x00000000 0x0000003f>,
+					/* io_tbu_stream_ctrl_reg_2_etr */
+					<0x00000198 0x00000000 0x0000003f>,
+					/* tsn_tbu_stream_ctrl_reg_3_tsn0 */
+					<0x0000019c 0x00000000 0x0000003f>,
+					/* tsn_tbu_stream_ctrl_reg_3_tsn1 */
+					<0x000001a0 0x00000000 0x0000003f>,
+					/* tsn_tbu_stream_ctrl_reg_3_tsn2 */
+					<0x000001a4 0x00000000 0x0000003f>;
+				bootph-all;
+			};
+		};
 	};
 };
=20
diff --git a/arch/arm/mach-socfpga/spl_soc64.c b/arch/arm/mach-socfpga/spl_=
soc64.c
index 4fe67ea0811..df89125cb29 100644
--- a/arch/arm/mach-socfpga/spl_soc64.c
+++ b/arch/arm/mach-socfpga/spl_soc64.c
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2020 Intel Corporation. All rights reserved
+ *  Copyright (C) 2025 Altera Corporation <www.altera.com>
  *
  */
=20
+#include <hang.h>
 #include <spl.h>
+#include <dm/uclass.h>
=20
 DECLARE_GLOBAL_DATA_PTR;
=20
@@ -22,3 +25,16 @@ u32 spl_boot_mode(const u32 boot_device)
 		return MMCSD_MODE_RAW;
 }
 #endif
+
+/* board specific function prior loading SSBL / U-Boot */ void=20
+spl_perform_fixups(struct spl_image_info *spl_image) {
+	int ret;
+	struct udevice *dev;
+
+	ret =3D uclass_get_device_by_name(UCLASS_NOP, "socfpga-smmu-secure-config=
", &dev);
+	if (ret) {
+		printf("HPS SMMU secure settings init failed: %d\n", ret);
+		hang();
+	}
+}
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
