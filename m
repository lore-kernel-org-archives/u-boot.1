Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B14C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D96C680A35;
	Wed,  5 Feb 2025 14:15:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="gpo+lm3y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9B7A806C9; Wed,  5 Feb 2025 11:15:54 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 595BF8070F
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvoSyNS/znpmDKktm9mg9v+KSia/kSJIqDMd/YT6RGBh7KK1zlFX7b8Pm9IQzHLQ9HeTAt5q3e7a6vlM3hQxaQM8GFE/WPe1FGMk/s9KgzWzHkggk5poYYwVM8xRqLc3zdoCw1JYdqWtKKD7DSQJ54sysKWdffZa950MqmIZYRbxkHUtxQRHisrHHMJrNGX0iOM0MhYmXwlqy9BWECMlbO7AlTApY3Juemwsze5PqwMslczCwC4ozlRfsMQVfNyRLBcFuiuIcQlSufQy/ZELBwDpUek93jPiLnLDncWw8T9hEL98ZpOk5ZA7aDOLQKaB17VbgB/viq1XjBSpm+WOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4tTmO4QfO4rhACeXtAJegn2On7BXU9if5tQfs/yu9o=;
 b=xgdoqO84hXLkjo956gMdzsAddlbNVSvsfZI8dpV/EVQi8Nq7Nr7DrHYoP8MPF7k3mPblNLrAVr5UffOpSVoKiWnbicO41nVccIx1MX3OmkeGo0F6wgKmB6K63srnS6Ao3ssK9EL1EI6mWNYggkqbeUZyaqA9PqRaDQUXZU52NXDeorKg+2J5KOQAeI+vwE8BhF9YZXDRqvJ1JFP/wbDexaecL+6QzBZdvzIF0O01UZguQymKPxiwFrxeAxKRgz0hSSjdE5NkIhCPDQcBrUKQzt/cDMJT19Y1rA9sD9CZB0h+wWTY+aJ0zHFIO56CznAE1IdFe7YfioE7RR6w+MngDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4tTmO4QfO4rhACeXtAJegn2On7BXU9if5tQfs/yu9o=;
 b=gpo+lm3ybo9MiXYsAYK2Om9Hs2gm/ui4K2PteGL9JCXEGtYrCEUGAJOxwqdHWsWmJL0Mux+V6/BypOkioVbS4R996TlTn9Qb8tEuViuZRw5QpAzqTz8nRLC9tjAiG1qqwFBrAJYAFiMIZrspC532j3CayVv19HGxA5gpVv2Q9A153FNFr/KS12M0R2x+sL97BcfGBxFXkZfr31o8or4BJkCtqGXWmdn335WLAnPJ64Q8ENtGrlNyeL0D+CIN9eztz1BcgK1glWkBxJD1t7yKjowLFU8oPgPwpRDIkTzwiuXbGt4zoJFPMLqw27h4PXXBlIVQ3ooE42AuVPKxCRAKPg==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DU0PR03MB9635.eurprd03.prod.outlook.com (2603:10a6:10:42d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:45 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:45 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Matthias Brugger
 <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>, Tom Rini
 <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: [RFC PATCH v1 04/20] arch: arm: mach-bcm283x: add BCM2712 board
 support
Thread-Topic: [RFC PATCH v1 04/20] arch: arm: mach-bcm283x: add BCM2712 board
 support
Thread-Index: AQHbd7bqW8a3v5ECeUuHqvHh5d2jzg==
Date: Wed, 5 Feb 2025 10:15:43 +0000
Message-ID: <fd70dabe61df73e33bb2498570a9a849139e4019.1738749764.git.oleksii_moisieiev@epam.com>
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
x-ms-office365-filtering-correlation-id: f6a37023-4038-4d2c-7f25-08dd45ce0dd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Y5S/o2ts3DuyTGhdgwa3SfXAfXYSz9Dmrw/PFnNFHIM1La8OVuaOJppizW?=
 =?iso-8859-1?Q?4MkF20P2dSwgz/qE1ykRIRuo7Z6SxDQVWGE8Y5bJDWhQhLz+PG/WNcm5Th?=
 =?iso-8859-1?Q?wky4Zqc2aDMAGyoqncMx/dlI11Zx9ejAhg0RQV46/0nCOb8LyyhtW0UTiw?=
 =?iso-8859-1?Q?x1lBrV1gKjxnhay68uVPRBHriCeIIDh0Gw4a80tuIABwqa+q4uYI8PbtbX?=
 =?iso-8859-1?Q?2e4zR7LDWtEDaNcww4j7zHsrpeevd626l2N8/gx4Ctr1sEA6IOM8cD/TXV?=
 =?iso-8859-1?Q?XthxFjXC9OqJo7W919TksGGak/sWIsygnwp6+nQxeyQaPOAdHXnouJd+vI?=
 =?iso-8859-1?Q?0awHXOh7Xf0l9DtNG2T9z5qXAeDCAPFzp4MxhynC8U5ujHSgiyQFh8PNty?=
 =?iso-8859-1?Q?6h/ssl/XC4lyMtLqYZoTn4Rdov4kLo7rbdT6WM4kc9jx7JZg7IAtgb7DzN?=
 =?iso-8859-1?Q?DZJ7chF2s98CoaQABLuSxPMPtv3RQeOsFnKtPnlt8NjJ21IPMPx+jpMKCR?=
 =?iso-8859-1?Q?goE5sUS2x38Xlp1ihetTWJgMRmtNoAt6sGAgBO8uQgELrPEVTS+Ew3LW06?=
 =?iso-8859-1?Q?QN/2qVDtb/t2zgZxQvwbsnSflhXM5BXKUZ0TRgGWXo7unPN4d//nvx8YXQ?=
 =?iso-8859-1?Q?lQD48acABDdPYvpDU1RkOw8aBVwsSw6Cn4ETX7/wwXjaKbhJmYSHXL8SDA?=
 =?iso-8859-1?Q?8vL8qrbnCySsNG/F0kDVxEmcwSDFnol+P7F1oLeMF+dIiiu80rkmel1RA7?=
 =?iso-8859-1?Q?z76tiux+ayM0cK2spHfc6TbG5axNQ13JQFJM0qh4vGhLg/XAHQyy9mrhWP?=
 =?iso-8859-1?Q?UF4u4p0saTi9FSspURufuV7LQ/PP86Ij5r76Hc9k95WYPqcHKfINwdh+IA?=
 =?iso-8859-1?Q?UztIxDMRfRRhEHxM3qlSkx5GMKdBqC8TZ8CpJ6EcjaxBdNvBi8m8X/VYvh?=
 =?iso-8859-1?Q?WjdPd/oCatC9Wn2KQtOxmMFrR/k16unE+6IiEsMqwrHIctZ7bCoU9y4OiU?=
 =?iso-8859-1?Q?6T/GX8IQq1ljmTMzIDXfFoVOYWTqqYh8ORJOlnZ7TENzrmqFMbve3tqYTw?=
 =?iso-8859-1?Q?ncMb0D8yCBfzmug30GZGO+leVcLZ/04a05fQfBaPfgbzQsx8PVAJkTc+kr?=
 =?iso-8859-1?Q?ay9sGTe6C1/V9Kw5m34qDTfBFe1AmeOX//uzYoRtixOG0h4DzGU+DX7fMJ?=
 =?iso-8859-1?Q?fbJ4rIzlj4NKJL/ur/IMWX0IkJ5d3ewMUaDSmi5834/Ipa4Z08ByxmmE94?=
 =?iso-8859-1?Q?jOPyZnwIHfH0rB66rk2fw7MxS2PEqToCEmKIkxCZEA2W+7Mpvk16LmOasd?=
 =?iso-8859-1?Q?YjQzBNBkpai9Rlg219FgO1FbvXdgOMSjQ6M9JnBSD4WpHaAyBiMYPPqpxK?=
 =?iso-8859-1?Q?/mtUXTssCn5MhzZCPrdHFGyP0sCWnNJnS04HqlOW1q+qzxSPfkJ44DXzn/?=
 =?iso-8859-1?Q?6PLBFRL7fMlVdrLc0PgfQn5xaJStyB2uRhUdfmQ+SneZcaXF895emKMWiu?=
 =?iso-8859-1?Q?kmZXNhFKMJsNpPX19S/+AC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QcvvYjHyn6wG29Z8+q2JolaS5xlOhh5KpaXft7mHg/llSK3p8ADN43xGk0?=
 =?iso-8859-1?Q?kgvlfMs9qZNB1ac+FENxS4aRD+CtUkgshGZxRZszU/gNn54nUsaCpumiim?=
 =?iso-8859-1?Q?EJbHoMTKkumDl3WPIIPY5jjN8RD78fctZUtCJRP2tp4LZPGSHrGjHOTo7W?=
 =?iso-8859-1?Q?2RvffvhnlbyYjP7gHhX4fHCesaC1+Dw2CjZIZZqk+6+CkQUTL6kADMwjy4?=
 =?iso-8859-1?Q?+lpJB/1ZlreuJYx03JfN3FnPaxz99Q442SKZA8rX/ieIOcvGMY8iiiSSAS?=
 =?iso-8859-1?Q?/cak5DeYgyblB4GFlK3siw4FTdBM//4RDdb+LJSH8e5EWaHIGBaek1GsvB?=
 =?iso-8859-1?Q?XqV9csTgdj8eQNSWs2R99iuJVRng2WdAWdlRGf2ci8BXX1RZNnKpF+qtpD?=
 =?iso-8859-1?Q?8yt0bZDHfXUgyt3EKOvDaO/F7YeogzUIBQHJ8NoO2buTwqOJJX0ClFu+Uk?=
 =?iso-8859-1?Q?5d3Yh72f9WOCLSSFFcFRyiliHMow3OB6snuk7DaLNMt5VR+LRHIO/r2VD4?=
 =?iso-8859-1?Q?+VjM+vTZ0fHXm1x/1soVyBxqS7X/sb5+saufhVND+04F12owajorv82GNh?=
 =?iso-8859-1?Q?ltMBbBqW1KAcNpdp7IqAypVd/paD2MoI0fC97LaA58a1iQ4FQuSFtKveif?=
 =?iso-8859-1?Q?7YTDWaxBHQ7XcVQWN4iD8qFmhkUV9EvOqWQkr3U8SNDG29rhosVGpqgDx8?=
 =?iso-8859-1?Q?CMhWiUdZKZ1ISAc09Qb1posKbIlTlhhbj/0CCSaK3MwqzjpqNc6gHnrxI5?=
 =?iso-8859-1?Q?dn7sYGKt1eiURP+pxYn+s73FsCijRedn8ugrn/01cllU3AhBLT6b5W56VF?=
 =?iso-8859-1?Q?XO1EYJGakA7PjNLA7idK6QDv11fPPo6W9JxJN9BmVh53WgRt31kRe3I5+f?=
 =?iso-8859-1?Q?PhvgrIJKXewYGmB2WT2RlYIUnGiMc7id1Ai4CaSjeMezJQTMhXZm99SBNn?=
 =?iso-8859-1?Q?pCB/GzBTksciP7DD7VL7DaLZfYzNEsQIrD9NMmxNG84u52ADnOjj8JkTz2?=
 =?iso-8859-1?Q?xLqCfEWRyGbR412PWU7GadzXjcz2VgshKLMS+dTAG/TOfuT0lmHi+OQQFY?=
 =?iso-8859-1?Q?5J7XrVCEnUQzfZWy/JomnLASDbgX/FjkB7xGgWrrYyJVEZqMWFqojRtvtT?=
 =?iso-8859-1?Q?F5APASHhO8J16PjBSfS6K/g8HVxCsSEK3Ln6bIYC4Rpd9jvLo+P2n4F5xn?=
 =?iso-8859-1?Q?Q8E5yOMnK5DrZRPGe8RpogrQruJ/WKUezM+jM5C6fq1399JrEBhULOTUfP?=
 =?iso-8859-1?Q?HyXq6K/Icdvht3oq1+epGHKIhMzAXU8KbN3CuTmDkAnpux5H/vwVYjy6o/?=
 =?iso-8859-1?Q?Pa69xiySK7tJvOF7fM19ydZ0a1JiVas/Vb81eH4bHx+FaZAAhoOEOzegDv?=
 =?iso-8859-1?Q?Jl7bA9HCkk59pcD8n4YiUK6ijF4j1QMkACc4PtoG3I/UAA47NKYacqgGHZ?=
 =?iso-8859-1?Q?e9r0OKKT/kCE8Pbe3XLsc+uB1YgK8RmTP/htF5HbTcnzNakUJ7Cjq+Sua/?=
 =?iso-8859-1?Q?E5WLtkV+rzobtKC/P0y4nJnPn2fs9OqhowM3YnqNpTTtUeuV0p1upQpDsB?=
 =?iso-8859-1?Q?SY20uZBWH3QTuONJ4MVAOm0C19nV2/2QpWRMXGObMTwWx1dcTfhX9GVaH1?=
 =?iso-8859-1?Q?rGuAGeXtUHBXmbgJE5iShjjdnYPffPAYFc0DZUFlmr70DFLvDIvyWwvw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a37023-4038-4d2c-7f25-08dd45ce0dd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:43.1580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kiEI+QdFqnG/pIKKWS8QdCxh9DCsfYR/bRU94fr1toJEDUZMNwxEZLr2RHbvaJBImPerQkbus6p92F0ko6aSIPJbgQkIZoeNA5dvl2RASZE=
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

Add BCM2712 board support to U-Boot.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 arch/arm/mach-bcm283x/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-bcm283x/Kconfig b/arch/arm/mach-bcm283x/Kconfig
index 6ce278c6d2..c7509146be 100644
--- a/arch/arm/mach-bcm283x/Kconfig
+++ b/arch/arm/mach-bcm283x/Kconfig
@@ -44,6 +44,10 @@ config BCM2711_64B
 	select BCM2711
 	select ARM64
=20
+config BCM2712
+	bool "Broadcom BCM2712 SoC support"
+	depends on ARCH_BCM283X
+
 menu "Broadcom BCM283X family"
 	depends on ARCH_BCM283X
=20
--=20
2.34.1
