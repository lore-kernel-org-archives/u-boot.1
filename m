Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D157C021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 574DA810DC;
	Wed, 19 Feb 2025 14:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="C5JSYETn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9851809A4; Wed, 19 Feb 2025 08:25:52 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9680C800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eU873SP0chnx8eYW/Pfk0PCDpxPuuBLrmlTjVDKmZLTqR2V7HgOpJdO7uKlXUNKDqcksBpSyNkl1rXQ7A+Cz1tmK6SoSHbfGHqEG7cRiXXm5rZRX1SaO/xzrV63I7KvZnSh7XOT7sAFQX6aTG1jszFqxgZ2VZ0P70IdH5Fs7riV+04pBp5f9ijUAR9NXEhvb5F9RPDe79ejRV6vNbZvZuhoYa6bAyjSyqulK1DvGyMXUXbDvdBMRcirwvo+Q03lwPMwsvWtVk17hvZsQpNekk8CF0cyFvlho1/6yL4ChPR/xvuRxOnzVEIPIm0cNzu+AG2EQinrr9H+cCVXwBZVsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxjDTzCbKwXmcKDQZh0yfg07cUW9oI/7RWdspS2LYHo=;
 b=fjgZaZLk6YbrPxVFt9CyU++Uv54ctBjpoDJp0E1HfVk/GrrwWtfEYK+BjBWh0tfeUOef+1n5pLzWDL9aEd9EgC9M1lkUXitm1b38o7vNVxd85FaH6keGFXIuqmQF576NIb6K/bwTy+ccPFvHbbldeCW+icRRnfg/lHAjVffnBtA/ZFzNGAm3Rqb910QgXFx6TAmVwcUcI5cOFMMpw3Z5LgD67uLhyPP5fCLahXiV5x3B11NkcSs0ib0rKC+Lfov9HxvYIT51Zs99zF3Uy3fJzZZrrrtXvXrQwVwI9QTM5AtXzf8hhyU1luQ/xuJM7+wkfgYhdeN7JI91epkEZrex9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxjDTzCbKwXmcKDQZh0yfg07cUW9oI/7RWdspS2LYHo=;
 b=C5JSYETnaDarXH0tm94YEg8yRR4V0ZWFh6S81+Czcd6og/Ni3wBNtgGH0BPr5xV5TnP6+so7R0RzxwHjAah+va5nJrLIekBs2AvGOoOS+cKEKLu2sHlRWG54Z3+6LPnP/+u+dq/qYAChgBuDa76AvQ8GaVEITnq3MZ/4hfuQwt7Veh4jN2VIBf6YTMQ73tDkkpXU4Yy33L595CxJbREFhgeMye/Y59P50Nrf4DBrAzyW4CxDslZzJd27wjL8Z0eIjxXkDGXzweVHoOGgTIv6/ZDG4AfzsDqrQ57DcsnG3Q6lsYtRBrZm3vSs/SA/WknOWaZGOroIrVGybfs37OQykg==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by SA3PR03MB7253.namprd03.prod.outlook.com (2603:10b6:806:2fd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:25:48 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:25:48 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>
Subject: RE: [PATCH v2 22/26] configs: socfpga: soc64: agilex5: Use common
 ARMv8 linker script
Thread-Topic: [PATCH v2 22/26] configs: socfpga: soc64: agilex5: Use common
 ARMv8 linker script
Thread-Index: AQHbgeAuI8lzz7BU8kiLoMQUkkGSe7NOOzfw
Date: Wed, 19 Feb 2025 07:25:48 +0000
Message-ID: <SN6PR03MB3583F44306C397B24B913D60A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-23-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-23-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|SA3PR03MB7253:EE_
x-ms-office365-filtering-correlation-id: 7d9576d4-35c5-41f0-fccf-08dd50b6a1ea
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?IjKbD0cMUOe6dWo5x5tJX0wGjOFgxwL6aRjvAY0c6u72e8dmlQDN++HKx8mk?=
 =?us-ascii?Q?svzaMzchZLiPCYsZQH5y8B+zw1LbvrezFl60ZM/w3Qwaf+ox4KMpI5MYi1Q1?=
 =?us-ascii?Q?XKHn8MmSnr76hdq7mE+ICscr2AF/Ej9oWa2kcxYJggJEqSc4TNsCp22fdyvf?=
 =?us-ascii?Q?vHpMbCiVY+k1yXKgw0VAm5kQr/JKUubNlaWVrgbMzCZicdI1E/P9WWkRoMfQ?=
 =?us-ascii?Q?JeTDJxDgGAQia8g3Ju2GCANQPquqqCq94mdrJkmEAjVDcgXaK6wig3Ph96+p?=
 =?us-ascii?Q?qSpiqmY6ncjHKAFMBni1uS+xQjqSZrUvA2B7s/5Bk+iJPULCp3loC2akKQTy?=
 =?us-ascii?Q?is/BJCko7oCYE/D1g58vNNuy0hnek8UFjZnzClRaPAnonhHd0T2y7eQo7Kqn?=
 =?us-ascii?Q?4AxFV+s13TZdaRx0MjBUoGp7ORpMcNple2NNcaTcmwO/YqBhhwwKEx5vtnBO?=
 =?us-ascii?Q?3ghpTqLNEctsmRhBc1M4QwdpQrSaQx3qjS58jcm3w0x8P+rmS7K4lriRmn+R?=
 =?us-ascii?Q?GrJc3jT103Baw50xuOpm6futHF+zgrQ/bfmWi7DYc4L+cJLdxWV2AFVJRM0S?=
 =?us-ascii?Q?0QywVKp0eJCJywe2CfaaPWXrH0BhgBjt7JQQuc+je+JXqEJpvheXnvkdvxXh?=
 =?us-ascii?Q?CaK/7TSdwambV701t4Tx6CndceW/TXVYOyIcKdGe49HBvf7ysOWGzdgasY39?=
 =?us-ascii?Q?xdrFZFGrmK+vzf6uC4R2Ti7pgg/k3O+f7BIX0gQb5o1/xAxr1MJdq04Exkax?=
 =?us-ascii?Q?e3L0/rR/B3xjxqrsgExcTDt8SIpaXHq61pKUrvW/KHdVpVcBwFm4omN/eiDC?=
 =?us-ascii?Q?ib8iqnVD4nr4J909+bzGxDz7xChSklOjhl6YxvDjNPc2joog1Ah5UGwAxtIz?=
 =?us-ascii?Q?UbV1SbkagaIkSwmgXNW7/LLxvuqViRih38faEO4UCy2kYnvNryj42WnJFNvo?=
 =?us-ascii?Q?1tX7eNdhMb8yxcPwoZW6JE3nJdftGTP5fTmacNxQ4UZp0KiQ5klvUT0LT5kv?=
 =?us-ascii?Q?RY+QleV8usPO1s3LQxmYaLtRrYz06wLicIdvDvEfAxhG1es+FvZczYjT3W8o?=
 =?us-ascii?Q?J450XfCcziS/He018ORF77/vDWFLjBBNgCINT9+srIgsgOI92coar6rLBY3c?=
 =?us-ascii?Q?X38T/JPO0v4t/bRA0XDNxy69G7z57IYXSuAYpRM92sx5GEPGxIC8q/5u9ak2?=
 =?us-ascii?Q?+EZ/LZs9SK2EbtEcAv3o2jiL2bqHWNZrQlq0nylSVAOJJBRi4+hMlUqMd/zL?=
 =?us-ascii?Q?1MENM2pzJtOLxI25DHpnDgMok6SbHjNjp8uUvlPENoqGKD6TKOvQsaaz+ofK?=
 =?us-ascii?Q?7er8LLa0Zf6zLZ+vq34hC/VEdklort27Ko8rSGMcbmvqHy5iYtjxkGBSUQwK?=
 =?us-ascii?Q?wElB6uKdPu3wxGpF32a/yXDLs5vhkYFMNsAG5oxiU37kIsOZmem9dAe/Htgj?=
 =?us-ascii?Q?cA5U0iZNlt1xXkqUsgYIGBrUcu5rbyB+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fqRPera5n7WtjXeXp6yAvRR7Kwo4/4LCon+XxX0rTMn641DW7Lfglm9883sm?=
 =?us-ascii?Q?z5yAyk6u4V57z4I2SoNP7TBj3t1ImefIwdz8+o674EHA5V5Xep6excV0brOT?=
 =?us-ascii?Q?OVn4KiG6abHYdb0o84e1BNURT5UKyryDJFDD9TzMNfA0lp09NWPQosJyEYWi?=
 =?us-ascii?Q?Z5VVzNhvK9Kr4G2HPztsIEw86GoDyxrefQ6hEElOBMFc8NZeztK6i/LPlHW0?=
 =?us-ascii?Q?FgkpMiZWzTdse9HI8MNcwUicj7DQWqzF0zX2z4W5VMaWrjJsfuXG5b05+ZlQ?=
 =?us-ascii?Q?Hnhf1/4nSioVYpfIkinNOh67quYG81dNJzR2FEsQjXtcNp59AGfVj7BpwBRi?=
 =?us-ascii?Q?FzMo43bYVDafgFUeMvJvx0fzrJwOa2ApcLE+KSEMrkI1e8pSgzC9/YvxmX1p?=
 =?us-ascii?Q?+NucJ62vyfoeunpm2D8dh9tAqImAAXnGhIyANaerP70t3TdJBbiaxHmmn8xM?=
 =?us-ascii?Q?y9Kww5DFL2tkta+i2JalGy2zgsENBdIe8m+1DuVrd5oMLR/rVr+otbIWDiLI?=
 =?us-ascii?Q?pepTia2YyCVwrKA+TRIzKbiAI1UheX6jLH3oLrIGrp5PncK4d8dcMqYwy0bZ?=
 =?us-ascii?Q?mw07dStRuKHPgRqJCGqHJ65BQvjJdkm/o/X6lFyXyBzy/mCFX4tTcLmI4Tuk?=
 =?us-ascii?Q?OXuo22qyMuUY2N2k0/LSDrq3C7rmFMP8fMZ9lVCKyiDSgCevuWpaiDC/C6wo?=
 =?us-ascii?Q?BXtOgULgAeIMQaciacNmw7BfuMFgxw+pOTSntURdfeE67QY6i3b0bdnX5oH8?=
 =?us-ascii?Q?1g0XhAEaaGs3RozNjTq80Qe6G1SO2rdXPrKpDQYHHJUXQqbRT7FI9GIeuLGj?=
 =?us-ascii?Q?c/cUVAQFRScSeZLKYD9v/DArRlhdop5HQTxq5jUVglASlbfSSEUG3nN6eetW?=
 =?us-ascii?Q?72NzAExH8tOvn63cXiZAQswDFEoR0X+PY0Ii9nPjYjkYaLv4DAZLTNOs9c2S?=
 =?us-ascii?Q?0PZlGnyFhcyBX7SUOY22d0UD1NF9LQfNA6aXnwJZKp7IQ0fzWJ+9ZsRte3GV?=
 =?us-ascii?Q?KFOlSUnbA1nDg3AL+yvY41PHUUCg/CcteW1G6ll6q7NA8LwUlSeia+0RDk4V?=
 =?us-ascii?Q?HiAsOxnGrhQ0dRbKWCegW/tiOKiLOpcEy4wcYuTKunn7yxxD0QTi4PwGECJL?=
 =?us-ascii?Q?uQtmQAZgKqNPC6yLeD4Xn2jsljD65bOcJzJSd+uRK/AuTYkdTIh5dEEj/ADl?=
 =?us-ascii?Q?gtup7OjeZqDF0oceX5v94stHlmPc5DycdhRdRyd+5zQjPHFCTTlDfaxArvxe?=
 =?us-ascii?Q?ybsAWp/8KYukNdEFqoLlmlv/4GTB2T/KEx/fvT3ZLteJJUjtbX8c3RIdxuwb?=
 =?us-ascii?Q?gIFvD4kXDK9hgnc8y7MYArgAwVAXAR2pZLdoCB3cgR9TR1cz/lsKc0ea1DdK?=
 =?us-ascii?Q?hOI23OmDNQD1GIdp4IwVb3aByJZY0s+grqCaeTstrwFek1xZEqg5XziBOlWT?=
 =?us-ascii?Q?/Bpbp9kIokRW0dXeAl9LPIIuP7gHNb5H7m0jedTM9u8rPzBLW+Lm3LbWRVkf?=
 =?us-ascii?Q?zDxsLsDoAJBxb52id0Gk/zyJ7FNyxgSQ8hOZeogXviBf4w6dpWsi+CtAlh4i?=
 =?us-ascii?Q?Bl8hBMCXNNG6cg39pixRDl2t2X3NgDFI7zLYJi2z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9576d4-35c5-41f0-fccf-08dd50b6a1ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:25:48.7068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ImnUOOSbPoLEFIHuNb+DwP6wgsen6fxv3g/y3aL7CC+nLQ9Md9Ngicmpi/qq2idi/9f6zTFyyatuIZxvhkLVgwWtYHHP6yXRAXD7bgBLuFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7253
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
Subject: [PATCH v2 22/26] configs: socfpga: soc64: agilex5: Use common ARMv=
8 linker script

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

Use default common ARMv8 linker script instead of a separate
SoC64 linker script

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

---

v1->v2
- Move to common ARMv8 linker script
---
 configs/socfpga_agilex5_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_de=
fconfig
index 61ce065a2bf..97b00a82129 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -2,7 +2,6 @@ CONFIG_ARM=3Dy
 CONFIG_ARCH_SOCFPGA=3Dy
 CONFIG_TEXT_BASE=3D0x80200000
 CONFIG_NR_DRAM_BANKS=3D3
-CONFIG_SPL_LDSCRIPT=3D"arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80300000
 CONFIG_SF_DEFAULT_MODE=3D0x2003
--=20
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
