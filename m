Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F84C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADC9B810EA;
	Wed, 19 Feb 2025 14:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="RxsNk6nz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B8F4809A4; Wed, 19 Feb 2025 08:26:06 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 494A5800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G60FeqoNTPKvdQMdkVHEEKH5onCQr5FgG3eOZ7CP3vS1JSqa4PEnkmL+BQxFgp3ylvqoY+457BFnGy3QzgrRYHtXrvb7fA9nQQhGT3j3LSI6PY/9HgDuPeUjFIlt6XuyedKBGwqbz/tCl+FOmaaVGBflAYewy4o+025GJvkWWvZyFG1XHW3CT3oaQsnApYBDa9dSpXJ4qLx+i+vlL9jyilasyUO+IqCfzt+SOEUPuF/IYG/ItsHq04r/+Q6MFX7YdZDtrwuv2qqLqIySdDxn4A2pvPHXz4zujh2A+B12I+d7tStzI8pVZgeqpyb35lZIXw24SkaqurKH8LUGVXammA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fek2J1kBYfwP3mYmRqfJtC2ZbuNR0dv1Y1gq4Vxustg=;
 b=VKTSHUYjAmm0mgAZySYGtepeOSD4J/ktfXD6Bx9Pfyu/6IfMxmkSDNJ/DqxHhwvafeFvmcdcbhEFDAgqgvL220i7Y5vslFqCa6TenS2rd6T8KSwQvCcTywlChOFKlcU9JOGwrfynRM9Fn4hOHOrGtdodCyIM3D55H27r4KHe4BfEkVUiZ0pixu3NPUo+Nsi/gt+wpU4uJBLCtgGxDQQheM5gbUUAavE9xUU91XHImxxBy47oJz5QolIXS93cXVzpPMfqLrx/DsN/H98RP/7ZiUvkVDquRpg5jBQZEwX7fEktAvMXSj/yJbh+gBSesdJBm1pv/ZJbK5kdbNnuuivcoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fek2J1kBYfwP3mYmRqfJtC2ZbuNR0dv1Y1gq4Vxustg=;
 b=RxsNk6nzXqdIY0Pmn/R+If4kPhBINo4LzgwnfwKe5WlDj1zePwFTg4drFSSBnToFif37QC3IAactc2fjrIa9cGDHtrzbp0L8AWsIHHMCfU1te1d1kJMaYUhW6oUevKdrrbEaNXcS16jaFu1IENp5AegJdzNGR9YJrj1Ql9YivGfy7bZOPeIXNdydR7ViYaHXnISIOEmc+1KXTYIHyMbjoOOT2SHR2Neg8uKwMmeyM8gjfZtdK3a/R37PIKJUm0Irq/tYQn7Xn6uS9ZusNKy7/h+v5lBFUS3veDzAzLETx+kDfvbqsG0Zm+Al/4nEKZYjrohTEXFPyi11I1knVcUprA==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by SA3PR03MB7253.namprd03.prod.outlook.com (2603:10b6:806:2fd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:26:02 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:26:02 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>, Tien Fong Chee
 <tien.fong.chee@intel.com>
Subject: RE: [PATCH v2 23/26] configs: socfpga: soc64: agilex5: Enable XGMAC
Thread-Topic: [PATCH v2 23/26] configs: socfpga: soc64: agilex5: Enable XGMAC
Thread-Index: AQHbgeAw14D0cinWHUmOumQHVqOxp7NOO0VQ
Date: Wed, 19 Feb 2025 07:26:01 +0000
Message-ID: <SN6PR03MB35830080D133FDD619FEC79BA7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-24-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-24-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|SA3PR03MB7253:EE_
x-ms-office365-filtering-correlation-id: 3a026d66-e823-47a8-ad58-08dd50b6a9d0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?FHPEmQ9pVendc1tfEIfM8z5XyIAW85SXUDFy2lf0a0RXiE8CRPEtIpYsqtpB?=
 =?us-ascii?Q?1NJ6o0UkYwJWhssOvsaBGqCj9hqXBtkotGhJErxJy2W5HxkeVU/i38XL0Ta0?=
 =?us-ascii?Q?D5pvb/GC1BU0RUgVKYeJqeQF37UO4aXf+UQhNVAWKEqeuat0t497ZI6AR+Bi?=
 =?us-ascii?Q?jdXCjnUXgEM3Vrz6kxbRovO63lhjSYJGlyfKWlz2x6T9wJQq/2Lm658Xj7lr?=
 =?us-ascii?Q?ZyBXpDShkl6m2bVqfMrDMYCaLhGRLYLEbwSENGJ09gPU5LU/Ih3LhTzWmFZy?=
 =?us-ascii?Q?LAsErMkMfYlrI+CYZh20s+BCfyQVI+jxJRYuLWZMUhl1lFhC5eR9ni9DdAqg?=
 =?us-ascii?Q?d3PTlT18MJBeRd7+blEaKIftccs7yUgYnjFpMNIPdL6pmcXvLv3LeYhQbDm2?=
 =?us-ascii?Q?E1ue7P6DlTYnOJAja5d7RxpOVx2aRGC/v7NGOZHNbHGGRt1fZr/FXCMf61Cj?=
 =?us-ascii?Q?SUwwUt+o3xNIOa3OPimYocnaJkOKAyv0EV4NoaVIpkVlFYnsR6tMbohO27Vs?=
 =?us-ascii?Q?CMUCauemXbaJlaVMrm9/3QqfrnIafqAv6Q/tqQ2X7AfY2YGtLQSUxueq+hll?=
 =?us-ascii?Q?BCkHuDmhi++HfnQG9s+UpzV8T4duNHDtM776pNbzvvxBKy61feF9rNC5Ephq?=
 =?us-ascii?Q?z+GYYQ3ESpPW/WH8l0F1tEiElWyUKPDR4TGAI7uY1IA1Tnv1VjKq0mbUwpvn?=
 =?us-ascii?Q?bSqkYa4+p8wcxYPsuzWyK4hcwe5veqe0efwTSyjO2NkbiaemNIlPPa9MhJpo?=
 =?us-ascii?Q?iGL0kU01nsRwxqlus7iClA909mJPMklXsNs2uzxMxSPE7ZIVtG6Nc8JGSCAv?=
 =?us-ascii?Q?DmvKfj3yP1qNSV2VopNvCF+SsVwMy8nktr+umeUPe60lLRcu1tUSXE31vSOe?=
 =?us-ascii?Q?KPE42IxMZA8V3wOd+KDOxk4Nq2h8zmWzqsPyyvK9xcPbFBh/CiE6gTWKIZDe?=
 =?us-ascii?Q?zmzHScHdCGMtKJeTMaoq+loA8G3gr1hvijX2EmZ111zzrn1dYEYbSLi9Fby+?=
 =?us-ascii?Q?/GxbVllla7TR18MWfFovX7iHMd/PNI+paf8wYFOEU14+otwM3s1xkPfW/aBf?=
 =?us-ascii?Q?g+rKkQE/Kj7baYeNneS1ssExiwGe8bwEpV2BCmIOS0jjCe2dYAGaX5bfgubE?=
 =?us-ascii?Q?PVEYG1rqDeVuvp8T3uD+A+UI1T3Xj3jjOkjnmMlI6qhcIIEZKXzENiWesuST?=
 =?us-ascii?Q?XWeidqsT4ksSUbYJvzIeJGiU7YJt22ZAmC08yBbuAhZbkPcd5e9TDEfqoYdO?=
 =?us-ascii?Q?Be0qHMkHbLOkFCIyzc49sv9rlLpMssndQYrcCepXbDn2WXR3ZE0im6DC3eGi?=
 =?us-ascii?Q?V1XGFAh7kqCA9sIX5kki62C1DmfUmMLI5hoPNyjbKd4OGk6gCogPE8jj7Xrf?=
 =?us-ascii?Q?wTVF82C+Ul+OUh8O8XREwzYzNv/+6pR5E7Cam6ksLa/oD1D2h075YwtUgpJK?=
 =?us-ascii?Q?y85d/2X8UwqfbWsDhh/oem/7bsG1bC/x?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jGleYIqNRNrk0IviydK7H7p2ZsdLZ9nRQMsKCh6Jb00aawo42Qz28tH4hUKQ?=
 =?us-ascii?Q?396xz2txHuNhotIOIkzijhWieUytEaNTgZj+c3ZKe6O5/tGNioUIx4WCmsm+?=
 =?us-ascii?Q?KJjbC59SfmRwmlliQNkHjopFD0Su+4FEHEqFh9oLtZaODTntT2MYaVWR0QPO?=
 =?us-ascii?Q?owvQhrO5VTG9hVXMh7mqHP40xx8tvLb5jCQRxy089AUit5dke3OssQ9tpOB6?=
 =?us-ascii?Q?X8D9M9qyVbNr0bYtkB4Dj9CAbXthrAWSzHKph5JPrJKJ0PV+MOyaqm8wSMVa?=
 =?us-ascii?Q?fvP89P3z/SIuZuSejPkbMnXKXkqtBZyGi2QjaphSjYmmLNVQEV2SOr/QBItT?=
 =?us-ascii?Q?1p0AmJHbBjZeYjSXI+226TMl4Qaw0A15U420zEhgKYRgXeM6G8eQ4l10L8zP?=
 =?us-ascii?Q?Wd7ypaI3XQRedyXnQMkDNoYuFKeAwjgJNCB+59PzLfpmgMZe4dF61Vw4wTG8?=
 =?us-ascii?Q?zvRVvkk6BuPX2n7VeCZnV5HctsphmQfXjqkEMM+9vH9oai1txA0aRjMSW1b+?=
 =?us-ascii?Q?jWWRBuWU6b95aSoXFxmcsbUAxY+F+uUXc9TtmMxcbqHbfYBsHGyWeTXPEMV5?=
 =?us-ascii?Q?vWWs3B53QTtkyjy58YU0jl0/QONA53TTJhEoeFWC6/wxQFiTQAehhgVDvnQi?=
 =?us-ascii?Q?njynggLBn5x30fnpgGMFlhQN3e44N00BxhHDY+1cnE+SqrgFn9W6fU2Xg47o?=
 =?us-ascii?Q?5P07lByv2gEWD9YDofIYvTpUU1NBlw8h0xtrkeNnjgSMqt922Oend/HKnder?=
 =?us-ascii?Q?XdDF53YgBF8JCpASChfJ482JKiS+w1tkxPQH5bCwTlEl/ivc6+dbsMAoA2Pg?=
 =?us-ascii?Q?29wsdOZ6wiPaTsx67Y0DSL5wSNQ4KKHv38jJQtxMETRX19Fmdytg5HXLB3ez?=
 =?us-ascii?Q?dWKZZUgWW4eiSp+sEtEAlWCYiMeCNBAGIG/olDb2+u268Dw+VNgZF62wRlHJ?=
 =?us-ascii?Q?QQIREh32cYzqFPAoLwgJYQBUCVfB+2FfkFrVRjVMo0xLxsvVspf8IL2MIhbl?=
 =?us-ascii?Q?PKycsyG2w1QXxgmZzIPakN+8GhAwNmWSTdnnfFPFL9s6tSKmX80zuWvOjbX4?=
 =?us-ascii?Q?jjZRJ26frdDcc1Z5UBSWpofcc88Sh8MD6Yw/OXDZarJIKXMGZSV1fNSnsS5x?=
 =?us-ascii?Q?sPqdACxDTKlJEug5cIxN3652W8q0RVoLwDIPgpT1dpq1Sqhk0xiSlT38fiP8?=
 =?us-ascii?Q?ei4uadz894Q3iK+8Qj0INLMWi+eHTOFkWBzvB58JFpdiOhQdNgRZ55llHaWi?=
 =?us-ascii?Q?utE1eEcNVBW9vKnXePKEjphi/6YXplb2jrOne37oYDsv3ipsOguxjtMXEGzX?=
 =?us-ascii?Q?3uaw9VahKMXTovRno+q686nCbvaPhCi2Mzbmaif7q49cg3pdpZVO5VFcfG9p?=
 =?us-ascii?Q?y8tTrQGfAsyUzfXaEF3jWnZFs6ugFj1RHWqFuUx9a2n2rwU9rsaBDMCri6W5?=
 =?us-ascii?Q?lMeU/9grZojdgOscHiisCIqOZ2xIHFsAnKV3QsDmVgZoo5SvLEMqeE4tw6JP?=
 =?us-ascii?Q?bI9+lxVGp2QNYLQ9+UtAVO+YOmvYdhrLIrx2X/6YXiAHHQr9sZu7pfje2f3S?=
 =?us-ascii?Q?R+5ixq3UUT7idnF/SSUTjybO5ZL2rg9pECnmvZNO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a026d66-e823-47a8-ad58-08dd50b6a9d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:26:01.9396 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smDl3fqb+AG8ezpxQrz7LjBrVJjOyWLBXRa3S1XOfls04Xc7poZ5dSHa7/rO6PDi47k0Z+lrjzF5m4esTyTvRNb/vgCGXD+w4N6SR5bR/fs=
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
a@altera.com>; Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v2 23/26] configs: socfpga: soc64: agilex5: Enable XGMAC

From: Tien Fong Chee <tien.fong.chee@intel.com>

Enable XGMAC for SoCFPGA Agilex5 devkit.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 configs/socfpga_agilex5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_de=
fconfig
index 97b00a82129..2b71ccac025 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -97,3 +97,4 @@ CONFIG_BLOBLIST_SIZE=3D0x1000
 CONFIG_BLOBLIST_ADDR=3D0x7e000
 CONFIG_HANDOFF=3Dy
 CONFIG_SPL_RECOVER_DATA_SECTION=3Dy
+CONFIG_DWC_ETH_XGMAC=3Dy
--=20
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

