Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945B6C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0059F80EB0;
	Wed,  5 Feb 2025 14:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="lhLQMKKO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BBA080207; Wed,  5 Feb 2025 11:16:00 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E104807E4
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIT+mYOOMSjTVaTNzXk3yBAQFmR0TEBaGui3GeWfvwrfGH+6Dp2mTaBLz8EcAlombuMH47iukVUiWosO/wOlGX/y/MwBtEO3A4+uJldXagyFxFZRxamHdx4kmsKHTrZDmVUHbGC6ZFdrJ79VgPVIVOMUD1b7sMJmimpAhZuuxpxgb+7fd+gypt9RAno9c/qqBseqwjjZ9FhoP7CzxkDHfgb1YgA9bgzQgD21nADH6PcOBfHdorRn73C61sm+WLyEeSW2aPUhzSfl6s0Xi4Th/sA3AS0GlYiVtM1w1xbk3cc8kL2exD0zxjU8hKWxBEOCNAuli1XtyRFCfkUUCqyXQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jM03+D57Pzf5gQxLCeD5agFv66ZqFdcTGtYXxKI8i9g=;
 b=ZeXTwsZhCMZqps2NpZaOlCYfy4iG/fqCPVDy6cmXFnhsXU2Th/qa+X9Zm7zBs9b2R2cM/yI6f7TS80Jgz+sZFjNreYcWmonuLb9FXFVzT8TzBhGlDMO6Vtsgl/PCDaDW8831uSzaJn9IkQVn4h1derHxfCmN5Eeah/m2AYldED50MurnDkoMcFPAs2d2a8NHxivUAU9XWqOEk3aCGiXmNE87owUgNIikwts+AWba1ijRVsUfyypz8/BfeNmBiOWD3YIuM4JHM/DalcBs341IYwJ4kJOfKtX+DsZN7bNo1KTr1wHz7zkUvZs+bjRxjCodkQoPloOJVd029DJeCaXwpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jM03+D57Pzf5gQxLCeD5agFv66ZqFdcTGtYXxKI8i9g=;
 b=lhLQMKKOAyYLcbFDIHmjsWqxrffY3pwUnDDOyTnx+BrKsGtaw1uw45hQrH+4RzZBqi99gT96s6RM/NQgXcN98DbyI22Xq/0mhIXmedMw6HBN4K2X4md+ogtRtko6G7a7sNzBeBADoZ5lyWjzHuhiR8mR3FJJVYv6Ajxea+qPao0H69XFdjdkkQln7wHpikRmxpZFWUULhDXkIb9jd82flW7aXaJyuMZCmYRyGSYv7Dh6yzSbcambeNDq527ZAa3xZqYp2ImZuD6ElyvU/m9WzneG5oc/hBnn6myrVbk40+R4hf96TRYOvgf0kx3Mn7c+P1BwkiiPYGeDMKkzw18ueA==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DU0PR03MB9635.eurprd03.prod.outlook.com (2603:10a6:10:42d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:51 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:51 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Matthias Brugger
 <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>, Tom Rini
 <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: [RFC PATCH v1 15/20] configs: add support for the Raspberrypi 5 board
 to default config
Thread-Topic: [RFC PATCH v1 15/20] configs: add support for the Raspberrypi 5
 board to default config
Thread-Index: AQHbd7bsVlUmrZ3BOU+lo2rAkbwrzQ==
Date: Wed, 5 Feb 2025 10:15:47 +0000
Message-ID: <0e50a66bcd6313cf85b7261c721b2653c322edda.1738749764.git.oleksii_moisieiev@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1738749764.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|DU0PR03MB9635:EE_
x-ms-office365-filtering-correlation-id: 20c1802d-65fe-4f85-6ef5-08dd45ce116c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jRBzzDbavMGYuPu1pr7MkgsWQwoMBLRXkUE2L6EdfM+tdcwpWAuP4E3Szj?=
 =?iso-8859-1?Q?UO4GsgVv79K4IJEs/umRCYPoePCF/barefNsx+AA7PCBRMeZOrUQtmoNfm?=
 =?iso-8859-1?Q?45nO4ZJXsg85p1h+HKM0zKerNHWHkpK5Ge9eKK3Cn6KCiQpVeSDGD9SRkN?=
 =?iso-8859-1?Q?6tkg51DyF/kAO/ePvdmXb1G3z2AUvu/lgUc4CJyBngcK9N6q+n06JFxPBI?=
 =?iso-8859-1?Q?DphX4dJaMlRsXcsZGDjFDOP+eKEtIVVoJQeNrF8/mzejWeg1mWkAHEbZ26?=
 =?iso-8859-1?Q?u2et3GfI+19Y2SLw5lhLJNBA1etJ7SY6+gBIy68AXsePBAwQ7YZUvS9FkU?=
 =?iso-8859-1?Q?OpMZdrUF6n3BODRcZN1Hb/O63fxD1U4EsUAwv1BcWnJ9RlN9pxfGpb6/vk?=
 =?iso-8859-1?Q?f+AwKEfFDP3Zfwt/Q4cZrMOmq9t7nreqzSgWUmFgnwjftlPpcCEAd3Injg?=
 =?iso-8859-1?Q?1dIg0v7XVH7mUP84p0ELkKWoXKMjnEuIucbw8QRH8e6zlGPewuvWc8Ra95?=
 =?iso-8859-1?Q?hrMe144ArMALVlh/XaVlpx/70l5CLwgkiHKzMlq7kVH8dgdX06EWEhBi7B?=
 =?iso-8859-1?Q?rXcmT1HPJZQjrpjA4krt15J4QVoHVjhuM0pHkUezyzUDq4D0O4ynDZGyh7?=
 =?iso-8859-1?Q?U45XZpr2xksNznX3J5xxAQhpHR4AVF1nY6vf77Ai8uW76GUp57oVlutUlA?=
 =?iso-8859-1?Q?Z/dE030MD7xHw13zSu0TyNWwS7iPv0pvjZHpzm5YVCVkPGbzhGRSpf+cOG?=
 =?iso-8859-1?Q?ifKA9SFHBqh+Oa0jPhTeoPLY5qcz58R7WxkKqowGXD3h8Lksa6DJZDfBnJ?=
 =?iso-8859-1?Q?EvHFCkRcujrRXJknXxbymwUEKnGmEnnq7WiMOk+Coag6upyHImDM5dQoO3?=
 =?iso-8859-1?Q?uq+jpNGnxzQdUryuyPOW81iSDR4g9JrYBlHvlBYXYIf6R+ZzZkLOoVndt0?=
 =?iso-8859-1?Q?AukI3ce87Wa0lhPZ4smDTByqu55AFw4sPNguGFXlwPEdT16OVbQVLqHR/2?=
 =?iso-8859-1?Q?XiuD7iSrWYUWRtFlhAu7MQi9VrQxLL2UPsXIENspegYUcziz2xhb7M2w+s?=
 =?iso-8859-1?Q?LmOeDyxDMWgJFu5sozMTkYACbAICK5nOPoro0/ftkwpErR2K+l7D+Nln6p?=
 =?iso-8859-1?Q?ZIrr7pI/Y3yVk5fFKRszKJe2X7zIefyJ39TPUSs1Jez3fsVDL7j0QjMWh/?=
 =?iso-8859-1?Q?NTiIE9gBh+pDotRtDEXJRYP312+c8qzETjO6GwN9sdDp/hIgKYWG/3PXM/?=
 =?iso-8859-1?Q?i5sJZV36X8x0/QdRuJ65XAvvbqYdlazMMcIjZVK1HyJqwwL4Vag648kgpK?=
 =?iso-8859-1?Q?1aG+DU/L3L7K9EDUSl4Bxo1qJh/MNzfnG3J6aQ1DR3vdQuwhSO+GWkcz7M?=
 =?iso-8859-1?Q?5VNkPb7tIQwIRfhyfd8eIaFX4Q3SyCjOEQdAkQlxDxwv9zXowyMeIF3S5w?=
 =?iso-8859-1?Q?+gqVK+bD9aRN1+6PA/OQnFPmsPbbR4aZvFaOk8i5xVhE5/OJxOY+41YTmM?=
 =?iso-8859-1?Q?0lmeUQIvXKgCOLMdwdgIMh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?se7+4bDO70azZ8oX5irqn3k1aQ98NTyWhG/TvqtgEzAF1I6hBCcxNQ39QT?=
 =?iso-8859-1?Q?wcWVOLNyQrWpdnVtYh1EA5MVE4rHofoDkSxeE37gUYtyKu9DhJYa7y4kTJ?=
 =?iso-8859-1?Q?BUCl7TtrliZcBE2nTpB1uOZc4rXPNAdPnlVet10tX5bnXc9EZ6Dv35K+FE?=
 =?iso-8859-1?Q?EgvNbk1/8XCht6x5ZpqJyJc12E38pNaHqRKsOnPGtFz4Mf0YhA28OXLo0d?=
 =?iso-8859-1?Q?6oG3sYMnbnAxIuArBvCG2x8HntRmZ2jr/4qgdzSq5T6/Io7cbjoKeXc8Gp?=
 =?iso-8859-1?Q?EbYheF9LYfp3c6frAB1KDEkCUXaThQUKfocicyDrqWSS1v63PfjDwUp85T?=
 =?iso-8859-1?Q?GN0WakVd3CbUQ5afAUx/ZY5LoqahHvO6SG78LDa2f7KQ9rnQVvjZ9yNv7g?=
 =?iso-8859-1?Q?7QVVVgYXwxEEw0sg/xeHEsfDlp48cUkUSJuAlIELU5dEFi7ubhRQ3Q6n3b?=
 =?iso-8859-1?Q?LNXDgfB9ExgCeuUKJKnfltbnYfymBSpL4vJzcgM66brPgg+O/5hRmoNZJl?=
 =?iso-8859-1?Q?MoeXaklM28Sn3kx0QsOqRoFxq8WjtjcnAmEd73aJfLTcFOCAWbYTFnQvQg?=
 =?iso-8859-1?Q?+yO/71KV9Btrv0+y2ZewwcQNM0a7E8UAmzmEjxO4Wl/1c/6R0umBoG3fX8?=
 =?iso-8859-1?Q?oMaQSPE6rWD57w+xUIAm4lF24tihy1lCpKONLPNKrL7ym95ixeQcRpUBel?=
 =?iso-8859-1?Q?6Wj59X3md/tZ3f2KNDYLjVyQMvrM11eUkE+p+1qYqRbT8e9LK8NQwO6kLD?=
 =?iso-8859-1?Q?x+gtPxp/G82V7x3hMub9kTPfNY5tYRVUHlT/uFN4w05HHGPo39Mt0RZwUr?=
 =?iso-8859-1?Q?Qu085UFrD3mGKkI1A52vZqBX/GhmJzoM202syIwwI5RkYslowM2/AzAWaP?=
 =?iso-8859-1?Q?q0+FC6yn3ezvhpPHhoTT4EyJkHiQBQmXYdt5oP+/OJhBZM5rf/PEOUp5+O?=
 =?iso-8859-1?Q?j1Z/Rs+bXHcE5gQfwMEt+9cRvsVJ3/037DGXiyaqEr8Zt1jW086uNbHoq3?=
 =?iso-8859-1?Q?4U04ecId9lW31votGYE/R8zPklPnenDYR+bdCKj2MpAOnr1gXaewu7PXkF?=
 =?iso-8859-1?Q?3CRLnDu6caS7O9Efes5Ayfmenrhzf5Xv0MYElLwzD9nR4xSQ/t8rO2ph+b?=
 =?iso-8859-1?Q?29iyyVC2jzWWET2G3xBEta/w/naaNHNEzCuLPCP7dMfwzpbv6SgOC11t0Y?=
 =?iso-8859-1?Q?n8zFxO044R2HXr6FlRhMcOFHCSoHXW8zLuwlMwvEb4cHSZuOSZAMidnpom?=
 =?iso-8859-1?Q?cFrv8LLrV8hS7MhN+EXi+yt3EdtdR4ZwXtrI9cqP87Om4HMswAJ9aCq8tU?=
 =?iso-8859-1?Q?2u7IRu+qXqd2S1gP2MF0vmGnsaozC1zO1yiUVTL5q4t3bt/gH3gN4JDsfc?=
 =?iso-8859-1?Q?Bq/y63Y19iA7z/vRSBVwBs6LvfpOiSEqnagHdL5PHmgDbCnwQhwjyGtlK+?=
 =?iso-8859-1?Q?eUjqXAJEloU/FzFaN56QhygwXsWr8ZTorINm0r3EWtSCj/jBPc25L10owA?=
 =?iso-8859-1?Q?shPpOPa4wP9TAgD2jqJa3JowsguXEM948T0dXG+0YBgJKpT5w315ouJQae?=
 =?iso-8859-1?Q?zgC5naO0jiXisKg95cYBC58pGb4ZP7XfWst48pWpgS2MJ98iwUzTjqzJy4?=
 =?iso-8859-1?Q?/lXgdHydhHvtmh4icJER9RSsWGxMTgilk3yGQ/mzkI7HSAtpNAO85R2g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c1802d-65fe-4f85-6ef5-08dd45ce116c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:47.0554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mYBGfQ5r2GvlIR1QLDG8bZzdimXVEY4foserMfLhki5AhDgoQwb1lIV9n3N/NR3/84Zj0nSZWnLVD75BEi0t/wQH3A7XrI5amUQIdJ3pgJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9635
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

Add the default configuration file for RPI5 board.
To build u-boot for Raspberrypi 5 the following command should be
used:
> make rpi_arm64_defconfig CROSS_COMPILE=3Daarch64-linux-gnu-

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 configs/rpi_arm64_defconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
index 02f942cf34..feeef14954 100644
--- a/configs/rpi_arm64_defconfig
+++ b/configs/rpi_arm64_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=3Dy
 CONFIG_POSITION_INDEPENDENT=3Dy
 CONFIG_ARCH_BCM283X=3Dy
+CONFIG_BCM2712=3Dy
 CONFIG_TARGET_RPI_ARM64=3Dy
 CONFIG_ENV_SIZE=3D0x4000
 CONFIG_DEFAULT_DEVICE_TREE=3D"bcm2711-rpi-4-b"
@@ -56,3 +57,21 @@ CONFIG_SYS_WHITE_ON_BLACK=3Dy
 CONFIG_VIDEO_BCM2835=3Dy
 CONFIG_CONSOLE_SCROLL_LINES=3D10
 CONFIG_PHYS_TO_BUS=3Dy
+
+CONFIG_RESET_BRCMSTB=3Dy
+CONFIG_MFD_RP1=3Dy
+
+CONFIG_PCI_PNP=3Dy
+
+CONFIG_RESET_RASPBERRYPI=3Dy
+CONFIG_RESET_BRCMSTB_RESCAL=3Dy
+
+CONFIG_MACB=3Dy
+
+CONFIG_CLK=3Dy
+CONFIG_CLK_RP1=3Dy
+CONFIG_OF_REAL=3Dy
+
+CONFIG_RP1_GPIO=3Dy
+CONFIG_BOARD_LATE_INIT=3Dy
+CONFIG_BOARD_TYPES=3Dy
--=20
2.34.1
