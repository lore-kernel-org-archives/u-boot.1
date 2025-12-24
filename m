Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DE2E776F0
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 16:41:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFB7B842CC;
	Wed, 24 Dec 2025 17:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="qTR/niFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 244D584295; Wed, 24 Dec 2025 16:46:13 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31F9D84261
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 16:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlLSCjI36xbaK3ESLbhguoA1VXrPE6CFPI26I3ls/Sv/TWjon0quccl8SiGnowLw/9ksMGvr1Q7xzvwk7FB8CXnvR3PkOuxUUaXTgkVVdNsk/COZLNCw8YGphdR1UokS5nNwwHflsnu966xUdc6q3iMgwLVO6ftMkXMfNFG4Pap52PENfRK4emu6hXVFijqe2nrn49+7w+33yv+Hg6SBeEEyolplmkFj8FR8hbb1pBDU/DkOjdA25QNo3LXdyg/IY12onH2q+W1rtYar86i61vfLse7zcgLXCak97hF8y4qJtpWSoFjLiLuZm3Fjunh/NThrCOIK0hRUi1TisQHF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7byoZIwVd5OrYb8gjblrqlpuAyDP48z5Wt+koOLJXQ=;
 b=sWQiN6qJl+uFfHsQjwpXsqZcOsiVt0JMZw9HF1UxBOCh18WzTuwokuAnj0DVb5umiiJ+Av59NSDDG75jxnCtEgSKpHPZRhlSVyIeQgBqCrgXuWyLZW61/Gm5UlAURB6JkDc/dbi+LlkKYKN2E2dLMiJiw2QCwUTflqzOmT2hNGBNmfP1XsyhaIWR/OIogUp9JxauAioT+3ibPC5KsXpui3uPxmo5jr+YYcUg3/7OXK4cTuiiCBDWl7dZVpD7EC5blB5I65hyuOj38jZD+ZRy0y8mc99k0e/E3oGQdu5oGjKMZFvWcOk9ZNOAbHUCFp/4Tet7c9ma8sRtZgQ4CGV5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7byoZIwVd5OrYb8gjblrqlpuAyDP48z5Wt+koOLJXQ=;
 b=qTR/niFR0IIi7C/5yEuMej94vvxmZhTM/JzrvfiMVo6A+PkG4mAq40/ngE0VBd9hpfvnpKgaJB1E0Dt4kFOg5WTs93Gj95Tu+HVLrC1XTRllZMkZuyl1g3iJwcp3LwE5Uu3oaJnvheZG2MwLC934tnP+jFo0rRiAQpcyQPkNh8CozhV67Fbn8PUnT2PAo9dhP7FYeHaCpsz7euiONme04X0ZjgwYIJ4ItCjbXoFOWrbsJWTqlUF8maACHITtQxyJ3e50JLQXYfrLboY1WAmrHETtnqIDQRqseK++B6Vn6QA5QTQQCCmt13TOA9iMKM/1OQdLKvDPkitGnyNWIbGdGw==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by PA3PR09MB8195.eurprd09.prod.outlook.com (2603:10a6:102:4ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Wed, 24 Dec
 2025 15:46:08 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 15:46:08 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v5 3/8] gpio: Add GPIO driver for Intel EG20T
Thread-Topic: [PATCH v5 3/8] gpio: Add GPIO driver for Intel EG20T
Thread-Index: AQHcdOxs6gKz2WOZTkS8AmCC35gnNA==
Date: Wed, 24 Dec 2025 15:46:08 +0000
Message-ID: <20251224154449.946780-4-uros.stajic@htecgroup.com>
References: <20251224154449.946780-1-uros.stajic@htecgroup.com>
In-Reply-To: <20251224154449.946780-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|PA3PR09MB8195:EE_
x-ms-office365-filtering-correlation-id: 3bf278d5-1d9b-4f91-9b52-08de43038e8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?so404JzkeDdRRI23DR9dokXyWrIcSaVKGXPgeM0V1K3+M30F/5ji/vrg6X?=
 =?iso-8859-1?Q?OCZdLE/bU5L1v5JyhNgijsppev0fo7Vdx6/7yn/kpX2FxY87KAuBMoad9C?=
 =?iso-8859-1?Q?0TlS129DAu+rin41yJ4rlZEaLxjwS/BbeHxItAs3YMclYrk+Wzi6W27YvO?=
 =?iso-8859-1?Q?lCl6P6djm5dc/6Msg7eh4kkz8mLICNzUN6SqtefKwZKN4ZknZ4s83cmt+G?=
 =?iso-8859-1?Q?Gebj5HrZpGXXcaMuweIk9oGDukBRXGji93Hegt/Y2ERiKn4ls/LUNgmHL0?=
 =?iso-8859-1?Q?zkyqJWby4J6csZWXN48h5qz+UwI0OpZTaXqF71vnbcIiKXdnZ7uRhNVDDt?=
 =?iso-8859-1?Q?hJAYBSyxxakq2j9RKpcT/vXR+wddE5oGxsAfMl16U+4qw9P0oFry7RjFNd?=
 =?iso-8859-1?Q?c8eQP5JtaZF+750HbYRI+d/7yJt9nTNliOknBPQhjCJC15ZJHtcr42c7kO?=
 =?iso-8859-1?Q?kj5XOsdIhHiWNc5X7ArkGmEtvxRCm+pF70CISfxlWfISxzYIqRwGPMPdNP?=
 =?iso-8859-1?Q?f54mdHLhuED5cyGQhSaHnVUu8BOl7bzmz5F+/KSDiu2WgK/D3bEhRRR9Dd?=
 =?iso-8859-1?Q?xFqtBGE2tBPOToZne05Hb6pU/fVhwxMSuqjNCDPoYEYX2x8IDpWi0WpqQl?=
 =?iso-8859-1?Q?Ec+ngnbENaoI8s6OVVhw3s9wT9235DTqaDmIAotexBgy+xlA+UCZBsywIP?=
 =?iso-8859-1?Q?ST3fyf+eisZ71HASkQsHdoFVzn++JQIgpFgbGSM/4k84M+wewQPiyE3rK4?=
 =?iso-8859-1?Q?ZoCmJWfOVufOslhm8CE2b73/JdYf7PH8omd2/DsFteg6tShNVuV0QJuWQQ?=
 =?iso-8859-1?Q?5nLUbmNl3zKCN/iIgVbLM0TuEbZqHNU5s7x6Smg0oSU64G7fMlsndQLhaw?=
 =?iso-8859-1?Q?/qDolSyMmgqaJkHGA/IJQU/Th1rpup7rwvXiSiDbj4erIZkGffy0KuTMXi?=
 =?iso-8859-1?Q?WgcRawDI/c8HxX+PVpD6KFeqhuzxkfCbJYefAA6gLJsd4cV/KCsMPFstRi?=
 =?iso-8859-1?Q?rD0TY+wab56pWDGVRTD5Z3WAYkMW0RW5g7KbMvXqIUPKKkY0/6lRI2orhZ?=
 =?iso-8859-1?Q?YPiZFmnAjlVQJzMl3lBE8Biych4pOI/4xRJXLQBYT4uPoBdCZQtjFO66BA?=
 =?iso-8859-1?Q?I+QZyahCOKOav0735LfnaCf/SsI2OA/Z+t2WcfAg2L3I2kplICaBflu38L?=
 =?iso-8859-1?Q?vfOJWSdgXD/K0FgOO5BdYdwptke3VhLqyKGC2qpxcLG4i9bPfT8WTZTLkm?=
 =?iso-8859-1?Q?XTchRx5FAnDfy0I22EOHsTFMfI6jK7L129pInNsNsueQYCf1qt3jDojCS0?=
 =?iso-8859-1?Q?Xr9qmoxuDZGfXoFqhXD3vWUUuAaTo534E+sFhI8TLb5vsvWw41+Y8O8TjA?=
 =?iso-8859-1?Q?UPlawr1uCCa1O/WJdQWzOUqyW2zlzXQ7NixJ271ytpY4rVXY6gvl7I7pFm?=
 =?iso-8859-1?Q?wwzXLhpPog3bA+AGZOICI9cg/eCH7B10Ro8I6hgwYtUR2l3mS87oDIw+uw?=
 =?iso-8859-1?Q?uK3+h3XzDv4vHPBj4mDMzjnF5FwCa/RU1FDJotFrn+pSVwiefxwkoKlyVV?=
 =?iso-8859-1?Q?hZ/I+gpkMPa7F6geJ4dIJ8dSvanS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zuITZI+L2s9yUzKEl/xMbDNPMYULvygf5lZuqnij6vA5go44/m15/gmwNZ?=
 =?iso-8859-1?Q?ozLId86jJekUuVoFBFbZ+g96JN8KsH4BTBopp3c6D7Lj2lHLqRURc8Dvm2?=
 =?iso-8859-1?Q?YCoj8JE6guGYWs0tdwksqW3XobBin80kivZHLiAQtbvsgWNd8b2T4QG0BD?=
 =?iso-8859-1?Q?J+/0FHr0jI0sm0tIOaFA+yQ5pLpqDACfsRzwsmjYBMBBOT0FeL04ko9Wdt?=
 =?iso-8859-1?Q?P2XQAbZOmkup2h2s2thKW2gt3bHCdgCdipzJKbla7ktV0xQ6DmupKns2Lh?=
 =?iso-8859-1?Q?7vzZsOP61ijyCuQe9I1+UlZD47Dg7Q2JxVZDSNSADO1nzSljU+nh9/S/jd?=
 =?iso-8859-1?Q?+WCjL03FkGAXlGMavMhW/LwZCLabNkxf/67R+9/WhhHyWI2DdT0NKBT6xT?=
 =?iso-8859-1?Q?hhLyrFqiMBmfD+Ghw79YaeHmmiV3y0J4nI9QVGf3FVl7fkeeEoP7UF8uRQ?=
 =?iso-8859-1?Q?4GO3S7VsrJP5yBwLexCdQXKNCO6Ri0FPe/K/UoS3cAJTrffOQlK/AiyzQX?=
 =?iso-8859-1?Q?HWqRjdcQHTAIe8PvAi5tPf953cnK+D+gKidSmcxFThALuK9dtlEW6+RoZ4?=
 =?iso-8859-1?Q?KYDU1n4VePvVqpgoewXIQzlYyoa5h2H+Efy1qj+ZeHtrzownqv7yG8+8ZE?=
 =?iso-8859-1?Q?vIQ4JAd1NkW6rPRFBmH41imQY6Z9kO7MRGN8t4dGYr+vryY0OAYFQWHeW9?=
 =?iso-8859-1?Q?tTn4ciyGZubEpRcbrzP/gWQ7iseV8GI3stcP8RBcYkMft5GdP6Disxpe/g?=
 =?iso-8859-1?Q?8GUkitIde6ipGyMisnLgl8kouETpfnqh0i4R8Igyr2eGCUxu8rScLkFkyR?=
 =?iso-8859-1?Q?Dhd/L/5WDT0bCtzi9SPWwQ4wcydB3PUfbiuFw/kdt9I6e0PHJNamYTOnxl?=
 =?iso-8859-1?Q?iKqoDv6d8dbHIi8IwcakEFdcksu4AWGIQgZWNz06aP1H/I6hrW5h2WuVmT?=
 =?iso-8859-1?Q?vYuNXSZESHP0LFCvgdlZ2XM11BArgsmDSNki3sdoX7diz36+m8EviajxpZ?=
 =?iso-8859-1?Q?wXq62wvhYwx82fdVqq5An6IxJIfUj67TDChNJmsAK9o72OZGkaOoyXiTdE?=
 =?iso-8859-1?Q?DU4h0tVm14reyPF+WEmwM+sGtvUGZyCxYQguESM6QWDSAzwloNwDv9+UK4?=
 =?iso-8859-1?Q?d5NbUhngrEkiwoNsjcXSttQwS8qukvQT8z1A9fFa0KMh6RB+jx044lhYP1?=
 =?iso-8859-1?Q?/j3QL6BMZxMCnPYJOsfXp4wD45h1nnv8ze//OSey4kjabXLzL69cs0AwGc?=
 =?iso-8859-1?Q?y5nItvZGFm08LmA06V0MG7LsGRETXFwoltxOwsY3Y+kc3JUjYRG5Rr3rVk?=
 =?iso-8859-1?Q?TyOTXoHXK1Dv+WQjyJj+VWSjth01M38VyoRPhZWPMBpOk2uV+4iaKmqQAE?=
 =?iso-8859-1?Q?e3jAekJU4SfzOwhTR5EoWEb0aN6mSp+sBzBlMvT9ZfTQxV3FF1NHbuJyQn?=
 =?iso-8859-1?Q?DE5HBrt/DJa+u6amNm61X4vsY54OR+T1hfY2o5EikgEaKAmqJrmvAn/d3I?=
 =?iso-8859-1?Q?lD0v8r5MCrckkyZn5qKZYK8h/oNC+G6eg1HjIJ4inCDV+uqifjsOeu8puW?=
 =?iso-8859-1?Q?qBU1G12Pxv8Izh8m0FqNL36m4+Wm8fMZps5vYJtfHgreDocBhxcObD8pL4?=
 =?iso-8859-1?Q?009z7h84wLD6Dp/kUV3OKfpxCHPDLPzTR7wZ2rckRpdjgbr4xM9G6H3kTR?=
 =?iso-8859-1?Q?0YL90MaCzB8qce4Q9IaT7aelIqJOnZcDmS1FuS8XSXOzW4odIiurFbeiRP?=
 =?iso-8859-1?Q?Ez6zVdaMKkytU+qVbg1TujjRzRz52shwTVzNIcGcXyv/Tcyj2vZRTd3Bic?=
 =?iso-8859-1?Q?3Z1MpTzPskyFCxWCBQF8/NtzQnPxewk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf278d5-1d9b-4f91-9b52-08de43038e8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2025 15:46:08.7963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oiVzpaZt60Mng7JDegDtal+aNM1AtEP+wFpduKrKS8uGuI5EbDicT/ZmMUucgS38S+ceQtxiWKAYkCHpvyhAQSDzEcOlntRH93Mb5jl/rEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR09MB8195
X-Mailman-Approved-At: Wed, 24 Dec 2025 17:41:15 +0100
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

Add a GPIO driver for the Intel EG20T Platform Controller Hub, which
exposes a set of 12 GPIOs via PCI MMIO.

The driver implements basic GPIO operations (input/output direction,
value read/write, and function query) using the U-Boot driver model
infrastructure. It maps the required BAR1 region via `dm_pci_map_bar`
and uses internal registers to control pin state and direction.

This driver is required for platforms using EG20T, such as P8700-based
systems, to access GPIOs through the standard U-Boot DM GPIO framework.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 board/mips/boston-riscv/MAINTAINERS |   1 +
 drivers/gpio/Kconfig                |   7 ++
 drivers/gpio/Makefile               |   1 +
 drivers/gpio/eg20t-gpio.c           | 141 ++++++++++++++++++++++++++++
 4 files changed, 150 insertions(+)
 create mode 100644 drivers/gpio/eg20t-gpio.c

diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/=
MAINTAINERS
index e350121395e..bc59a628c79 100644
--- a/board/mips/boston-riscv/MAINTAINERS
+++ b/board/mips/boston-riscv/MAINTAINERS
@@ -7,3 +7,4 @@ F:  arch/riscv/cpu/p8700/
 F:  arch/riscv/include/asm/arch-p8700/
 F:  configs/boston-p8700_defconfig
 F:  arch/riscv/dts/boston-p8700.dts
+F:  drivers/gpio/eg20t-gpio.c
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 2ed2bc82946..bd350d7ec96 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -728,4 +728,11 @@ config MPFS_GPIO
 	help
 		Enable to support the GPIO driver on Polarfire SoC
=20
+config EG20T_GPIO
+        bool "Intel EG20T GPIO driver"
+        depends on DM_GPIO && PCI
+        help
+          Enable this to support the GPIO controller found in the Intel EG=
20T
+          Platform Controller Hub.
+
 endif
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 910478c0c7a..3a823614253 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -80,3 +80,4 @@ obj-$(CONFIG_SLG7XL45106_I2C_GPO)	+=3D gpio_slg7xl45106.o
 obj-$(CONFIG_$(PHASE_)ADP5585_GPIO)	+=3D adp5585_gpio.o
 obj-$(CONFIG_RZG2L_GPIO)	+=3D rzg2l-gpio.o
 obj-$(CONFIG_MPFS_GPIO)	+=3D mpfs_gpio.o
+obj-$(CONFIG_EG20T_GPIO)	+=3D eg20t-gpio.o
diff --git a/drivers/gpio/eg20t-gpio.c b/drivers/gpio/eg20t-gpio.c
new file mode 100644
index 00000000000..18dc5214c43
--- /dev/null
+++ b/drivers/gpio/eg20t-gpio.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <log.h>
+#include <pci.h>
+#include <asm/io.h>
+#include <asm/gpio.h>
+
+enum {
+	REG_IEN		=3D 0x00,
+	REG_ISTATUS	=3D 0x04,
+	REG_IDISP	=3D 0x08,
+	REG_ICLR	=3D 0x0c,
+	REG_IMASK	=3D 0x10,
+	REG_IMASKCLR	=3D 0x14,
+	REG_PO		=3D 0x18,
+	REG_PI		=3D 0x1c,
+	REG_PM		=3D 0x20,
+};
+
+struct eg20t_gpio_priv {
+	void *base;
+};
+
+static int eg20t_gpio_get_value(struct udevice *dev, unsigned int offset)
+{
+	struct eg20t_gpio_priv *priv =3D dev_get_priv(dev);
+	u32 pm, pval;
+
+	pm =3D readl(priv->base + REG_PM);
+	if ((pm >> offset) & 0x1)
+		pval =3D readl(priv->base + REG_PO);
+	else
+		pval =3D readl(priv->base + REG_PI);
+
+	return (pval >> offset) & 0x1;
+}
+
+static int eg20t_gpio_set_value(struct udevice *dev, unsigned int offset,
+				int value)
+{
+	struct eg20t_gpio_priv *priv =3D dev_get_priv(dev);
+	u32 po;
+
+	po =3D readl(priv->base + REG_PO);
+	if (value)
+		po |=3D 1 << offset;
+	else
+		po &=3D ~(1 << offset);
+	writel(po, priv->base + REG_PO);
+
+	return 0;
+}
+
+static int eg20t_gpio_direction_input(struct udevice *dev, unsigned int of=
fset)
+{
+	struct eg20t_gpio_priv *priv =3D dev_get_priv(dev);
+	u32 pm;
+
+	pm =3D readl(priv->base + REG_PM);
+	pm &=3D ~(1 << offset);
+	writel(pm, priv->base + REG_PM);
+
+	return 0;
+}
+
+static int eg20t_gpio_direction_output(struct udevice *dev, unsigned int o=
ffset,
+				       int value)
+{
+	struct eg20t_gpio_priv *priv =3D dev_get_priv(dev);
+	u32 pm;
+
+	pm =3D readl(priv->base + REG_PM);
+	pm |=3D 1 << offset;
+	writel(pm, priv->base + REG_PM);
+
+	return eg20t_gpio_set_value(dev, offset, value);
+}
+
+static int eg20t_gpio_get_function(struct udevice *dev, unsigned int offse=
t)
+{
+	struct eg20t_gpio_priv *priv =3D dev_get_priv(dev);
+	u32 pm;
+
+	pm =3D readl(priv->base + REG_PM);
+	if ((pm >> offset) & 0x1)
+		return GPIOF_OUTPUT;
+
+	return GPIOF_INPUT;
+}
+
+static const struct dm_gpio_ops eg20t_gpio_ops =3D {
+	.direction_input	=3D eg20t_gpio_direction_input,
+	.direction_output	=3D eg20t_gpio_direction_output,
+	.get_value		=3D eg20t_gpio_get_value,
+	.set_value		=3D eg20t_gpio_set_value,
+	.get_function		=3D eg20t_gpio_get_function,
+};
+
+static int eg20t_gpio_probe(struct udevice *dev)
+{
+	struct eg20t_gpio_priv *priv =3D dev_get_priv(dev);
+	struct gpio_dev_priv *uc_priv =3D dev->uclass_priv_;
+
+	priv->base =3D dm_pci_map_bar(dev, PCI_BASE_ADDRESS_1, 0, 0,
+				    PCI_REGION_TYPE, PCI_REGION_MEM);
+	if (!priv->base) {
+		debug("failed to map GPIO registers\n");
+		return -EINVAL;
+	}
+
+	uc_priv->gpio_count =3D 12;
+	uc_priv->bank_name =3D "eg20t";
+
+	return 0;
+}
+
+static const struct udevice_id eg20t_gpio_ids[] =3D {
+	{ .compatible =3D "intel,eg20t-gpio" },
+	{ }
+};
+
+U_BOOT_DRIVER(eg20t_gpio) =3D {
+	.name	=3D "eg20t-gpio",
+	.id	=3D UCLASS_GPIO,
+	.of_match =3D eg20t_gpio_ids,
+	.probe	=3D eg20t_gpio_probe,
+	.priv_auto =3D sizeof(struct eg20t_gpio_priv),
+	.ops	=3D &eg20t_gpio_ops,
+};
+
+static struct pci_device_id eg20t_gpio_supported[] =3D {
+	{ PCI_VENDOR_ID_INTEL, 0x8803 },
+	{ },
+};
+
+U_BOOT_PCI_DEVICE(eg20t_gpio, eg20t_gpio_supported);
--=20
2.34.1
