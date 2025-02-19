Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B8BC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54EE580FF2;
	Wed, 19 Feb 2025 14:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="fpDxlwMB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5106C809A4; Wed, 19 Feb 2025 08:24:56 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 964FC800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:24:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2zjnrOKMl6moAvo+3khaw7/eljaTpth6pialBjqHqNHoAbXfMMYEYBRVPXOAYQg5Xx9WEG20p89QevkWDTzxUWzBcF5P7K7PGCNrIhgTyEj2iHAVIrMI+IcylQY3Ku05WtufEgBpmrWmsQu8En+Ilq3AIs1vtiAegNq2swIwegsjGZu2z3tiV6HbfGiKBioXrd0X7fQr+cIJX2nE/26LIgkYJ1vyaaWA9uvJq8wyl9s9feHpIlTWFl67EWj1tunaY7C0dXBYuUtb+85REWLPdAnGZfcEqnKshbaZlDaknWYUCthZ+jZTqA3ZKrx3vKFprPeSZnPmbuET9nyMmI5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYXvCFj+OpEwsBpZH4v/aSegTeGLmyuvV8OVdJ9VfZ4=;
 b=DxIxB8NSNUKtSSpjwQErKGoV/j4YtlqOioqZnJUcBbb7a9dCk+4cWxbjdn6JdhB/M3tFcEeaDjODRYjYnbQgv4j7Z2qWAERshTdURp/qi2uqInc2mOI8kWmowR8UlWj8WIkjO9/WynCVSzFLXUm5bWa1xdR8+s4EE3rrJ8ZyOZmKA3cjDT2eCEgXAaybXP6UG6SqRIRZSj79Y5hn3JRh4xShOuW/+ns61NTH8o1wWqlSUDgnJtpo08l+gS8dhNkVg9G5l93yqia8L9u0n2e/M5sGhL5y2s7ywBbtS0+CoTGyxOi6oqOuZFZtJXKkcyePUN0Xoc8uxsTXaxMWWmvxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYXvCFj+OpEwsBpZH4v/aSegTeGLmyuvV8OVdJ9VfZ4=;
 b=fpDxlwMBBQ2m3SOu8mFSsRo/sxLGjxlaxkP9FZfrZ2fnoEo5aS10XlJTme1q2fm/Iwp8lb0xXYWZ3aSW84B3aq7DjB6xABXGTdiv1fbC8zqU2YGJXxJNpkgxH2yCb1CAVOBV+9YqEWU4dodh6P8/Q014pI93k7WQB0/mq9iPOQiiegaSnSO7h+Sz6qfJgzZMbOgWexoeacgYzQGPPbAyQUabi3J/3XS7ljMfFecIQCAoAt5ZHZJJeEGkUrXyXgcfNfV8qg7n3M/8rXl4ZWRgrnJEH0Mexy2h9EqmAQd8oz82BY0UgmWtLkbJ7/scyhUUdXvyqDHpS/d8KpjnLS5oBQ==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by SA3PR03MB7253.namprd03.prod.outlook.com (2603:10b6:806:2fd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:24:49 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:24:49 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>, Tingting Meng
 <tingting.meng@intel.com>
Subject: RE: [PATCH v2 19/26] ddr: altera: Add DDR driver for Agilex5 series
Thread-Topic: [PATCH v2 19/26] ddr: altera: Add DDR driver for Agilex5 series
Thread-Index: AQHbgeApUpuD4LWxQ02Cs6RUoBfszbNOOuug
Date: Wed, 19 Feb 2025 07:24:49 +0000
Message-ID: <SN6PR03MB3583A0C1ECD3AEE2FD974C87A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-20-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-20-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|SA3PR03MB7253:EE_
x-ms-office365-filtering-correlation-id: 8d901c40-7944-4017-bd3c-08dd50b67e78
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|13003099007|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?aCmfssFHtST/rV6rSvmqYkrXmCS4rYufhfGKmwKTJK0PC10gliYUSbXisr24?=
 =?us-ascii?Q?Vv+hPbf9OE0rX8GOvcR/lwVCQHxfmKIpyQCUhzPPOEnAAAdmTMearUrOh1GA?=
 =?us-ascii?Q?CRmoZj/tQaGSMJuuGVEV3ndTDEyGl0Dh2McomQ8jMxB4pR65dVn5X2Se10RZ?=
 =?us-ascii?Q?LR9voTT5C+k7+Wft6jSc9CEl2zfuELL2c5ZTjv6Yr3/m53De4iDH0K3rgn9h?=
 =?us-ascii?Q?RjZWPvc7Ggph+ELRCIjBt+G1bP3Q6PEmP1h106qXH62Sur7tHZmIood5b0na?=
 =?us-ascii?Q?bQs6hBg5x/ZByAaUIvt3k4dQBkzQXhjbgXGczl2VxL6kudtfqzv9cIIx5QX9?=
 =?us-ascii?Q?mkfzr9b2O9tpPJGAoqhdph95OpxzJwANhkpjadBmkng631HgSS2lUc0HiCGK?=
 =?us-ascii?Q?AsVOCeBBuDKfkLqc2DlDlLo3pvZDXakENoZ+GXyyywke4qHrB3r9gZHnZMZG?=
 =?us-ascii?Q?qLmi+GkJNtVcGxw+DAb33SSG7+KcWI6S8hqPOhbG6c85SIHdr69R2vzqmefv?=
 =?us-ascii?Q?x740I0MA0bu5qLEif6H6mh/SLPOy8DoKl51LqDK2cwDANinH9P848RwAGUJj?=
 =?us-ascii?Q?r8m2Z0xKzXQAXMuDcipPo6WILPDUTImZ5YAA4WzYq58W8ZIS3j6JCXJWm+/F?=
 =?us-ascii?Q?TAHWrqUR1438LkxumqDP4b6FckB46NzYZYB+e1R94NpWXuu/ncDDbcPn2ngu?=
 =?us-ascii?Q?MYR+yT/hIIMWvW/vpLu0jWaylfPQQux6illP4WjoyoRfRfqcey6Z/Rq5pnqW?=
 =?us-ascii?Q?etHjFBb6j3jzUWNanLiyCFyZ1cfkYYNsmh5dt0wAduwvwqLVO0Wv4L+38ZP4?=
 =?us-ascii?Q?T2YbS0hmWGZ3i8iozVcbrZur1EHWIe14PC3OyI/8Q28ZgLtF27c878gQ67zC?=
 =?us-ascii?Q?dmrNeN/C5t0u/wKGbJwe53iPPgdpvTGCPG2ZNVnFU7ysdvJujzcn2C1szcCY?=
 =?us-ascii?Q?SD+jUmA8V5Vw/K5rBr9yn0fPA3jolMbOL5/s8ZAZ8O0jhUyO8LHZV37TbCFe?=
 =?us-ascii?Q?SqjhXU6cuw+dNqS7qo4kYPi21XJqC+WfUxk3EyqecFYcmoxENr10ZLmXxulc?=
 =?us-ascii?Q?ezPj7+RnRX9QFZuF5qCk70Yefvc6qDcC1xmTo9KOFnIXXVAu1joGiNv4P7oi?=
 =?us-ascii?Q?9q/UTldh0Larz0ybDZGWCNBKDfg17vDQuzcZ4LiMxMKNILDSxk+SqCqLCnJd?=
 =?us-ascii?Q?Y+79UHfCUKZnw7ZBMLcVpHND5f+iV1vYLv2c5P4APdqabfrTQVD2cGPychLQ?=
 =?us-ascii?Q?wl8hsybtkNd2RkhX66L2+h56Nntmu6Cc2KJ29MQgxT/MoHr4AYiPTwWWWz3Z?=
 =?us-ascii?Q?AHv0ez4EvJjfWdj4COdo4CgFSrHkiX5c6hIufTHojjpj9+ZK7fHRl0f0/xzU?=
 =?us-ascii?Q?gY38lfUkaMk3zFx0MdiQccYokwWM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x/ay6H3Lc0R4oQbD8p8jYxP7Rl3dOl3YAnOORYFFrJ1fAwgAEkRyzWfvlukq?=
 =?us-ascii?Q?m642v29Bq/gtHhoxefbEVuGciOAnJum58af13Tecs4qPwzaF/jhDm7ZZWLaN?=
 =?us-ascii?Q?HFv4x2M/lOZkHmQ5KqLeiGXFhzv2/4nYll1uviMv7wNb0CuSGFlLftEVARcL?=
 =?us-ascii?Q?iF8K31FFexIZeoumI7uoem0+civdvk4EOGT5uxI+EcVrBMPEhspghVGebeui?=
 =?us-ascii?Q?/xiohK4kUboAJbV1E5wWQo9SC1qCoYoUU96UIdsvx9oh9q661djkGbIDUC5Q?=
 =?us-ascii?Q?guDVKBAsbZzOGyU6r1KerUjJpx3ydMbloRQiRNezfloRp3M65EQd3NOl33NJ?=
 =?us-ascii?Q?+M0ub0xNkdoCyUOuwKRvG+OUJHXEr4uDh4x+55QPSd8mtu1jey9cubBfcgmZ?=
 =?us-ascii?Q?Qncffml7Vb02lhkz8QCq5MbwetegL8RE3eU7BO7fIViw+gxInWiitn0b32TZ?=
 =?us-ascii?Q?+TRWxym5cO6rzRZeU86OIlPFQZy4H8MY7zmE7IRLFDy2kNb4VRa1XRWY3Dq1?=
 =?us-ascii?Q?A7Ysd/PbolBA5TSLgoq8maGLZ/WLbYu59nQ4hz8ewzvylbdIX9oDGPcpwH5j?=
 =?us-ascii?Q?9pFRW9IWUJrLwskQbX7QXKvA7VTWIZax89ElSmbClt4Q+rjnnsEU0cl6liuQ?=
 =?us-ascii?Q?0J8hXZWoSP3zEVGBrAykhzcuBOiRnk2zLSy8+XSbPY8n/vMDM2S7+k3O01E8?=
 =?us-ascii?Q?rqwEZ4j1xNmN3+9ls0MBkvDP66IzHnE3xsOH10lTY2SDDEymYOdAUAXo49AL?=
 =?us-ascii?Q?jLEd0UtBWYpLAD4R+amHTyxqQKIqf75iKDoHU87wKSO2Gg5RkkKWfIILEuv6?=
 =?us-ascii?Q?LEZEh3/ufooVtIFUi8++4Np2D9JhjmldtpS1mi7O8bWTA5e1yXES9C3ojnm5?=
 =?us-ascii?Q?xy2N6vsrOQKgSP448FFnLsNArJjPIEuY+pwjmEKgSVFZEJ791EPM2wbzXqT9?=
 =?us-ascii?Q?W/jlbRIyabZfBs0+3RT+JCmcjwY1v4J42dFliQjisba+DTdNaTJCXBRBQ+3m?=
 =?us-ascii?Q?xNY55dTmGqUk9Eml7mvp07fG9Wk4iFPHDPx1hjxGlJUOQ/yljmiEb+Z1eT9y?=
 =?us-ascii?Q?3CqevC9d0XbcM4Coa5kOzWjN/3zSI6C3+LNLZ2Qc5q00v3CciuSldmbuFaPQ?=
 =?us-ascii?Q?X+yd/2EMQ0o3LIJbx7XzHyoSewlcLpuh7hL2RzZPPrOxNRuTQKV1XpFgoGsJ?=
 =?us-ascii?Q?YFRKk2jd9KmjmbkYyNdyg2zf9hOnK1dpwlOUD4A7e8rHWyMwYehTdm0BqaVa?=
 =?us-ascii?Q?cFLEDN759sPM7tDe7I3jvWghmvye6CrGYkHKMeuRQroBthgpws+xd2Egp0rt?=
 =?us-ascii?Q?QPAhKTRD3LO4/HQN5eugWCA2N8BYmfKrWkiyc0Pwj4TZY7lPb2UxSgSH2nW0?=
 =?us-ascii?Q?M9sawccM9WnH/oLDyze5Sced6EaE1/2NozTuSrHryBEzAlJhtmeAC8QWOwWB?=
 =?us-ascii?Q?i66JZF2rYov6lZGRQPNy4JRe2dUoZWJgQ5kKPZUO6ZAJqJTISR5AoJzAiocq?=
 =?us-ascii?Q?Y6eFGBLk191h72jUc1pJ/XtvDLsCSe5wHFL2aJLj9q2aRWK4CJggRujEaOOt?=
 =?us-ascii?Q?O1Trih5KsyLtClHSohYyZ5bh3y3HepzEJb7G47Vh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d901c40-7944-4017-bd3c-08dd50b67e78
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:24:49.2325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CcHukofrYbB5IX0ECdLYyZplscqqG1QVRGI5biURECHaHVTdH5Zoc5UC4mIRcudoX493rzuJRE5YcjwNMGaG4fHgOlUynlqrUEkXUVYTx6w=
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
a@altera.com>; Tingting Meng <tingting.meng@intel.com>
Subject: [PATCH v2 19/26] ddr: altera: Add DDR driver for Agilex5 series

From: Tingting Meng <tingting.meng@intel.com>

Adding DDR driver support for Agilex5 series.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
---
 MAINTAINERS                                   |   2 +
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi      | 251 ++++++
 arch/arm/dts/socfpga_agilex5.dtsi             |   8 +
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |  37 +-
 arch/arm/mach-socfpga/board.c                 |  33 +-
 arch/arm/mach-socfpga/include/mach/firewall.h |  21 +-
 arch/arm/mach-socfpga/misc.c                  |  35 +-
 arch/arm/mach-socfpga/misc_soc64.c            |  22 +-
 configs/socfpga_agilex5_defconfig             |   8 +-
 drivers/ddr/altera/Makefile                   |   3 +-
 drivers/ddr/altera/iossm_mailbox.c            | 748 ++++++++++++++++++
 drivers/ddr/altera/iossm_mailbox.h            | 136 ++++
 drivers/ddr/altera/sdram_agilex5.c            | 420 ++++++++++
 drivers/ddr/altera/sdram_soc64.c              |  76 +-
 drivers/ddr/altera/sdram_soc64.h              |  10 +
 15 files changed, 1767 insertions(+), 43 deletions(-)
 create mode 100644 drivers/ddr/altera/iossm_mailbox.c
 create mode 100644 drivers/ddr/altera/iossm_mailbox.h
 create mode 100644 drivers/ddr/altera/sdram_agilex5.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ba31f86feb6..b69a463d164 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -152,8 +152,10 @@ ARM ALTERA SOCFPGA
 M:	Marek Vasut <marex@denx.de>
 M:	Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
 M:	Tien Fong Chee <tien.fong.chee@intel.com>
+M:	Tingting Meng <tingting.meng@intel.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
+F:	drivers/ddr/altera/
 F:	arch/arm/mach-socfpga/
 F:	drivers/sysreset/sysreset_socfpga*
=20
diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpg=
a_agilex5-u-boot.dtsi
index af3f5d32f9d..8d6503dd091 100644
--- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
@@ -389,6 +389,230 @@
 			};
 		};
=20
+		socfpga_ccu_ddr_interleaving_off: socfpga-ccu-ddr-interleaving-off {
+			compatible =3D "intel,socfpga-dtreg";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			bootph-all;
+
+			/* DSU */
+			i_ccu_caiu0@1c000000 {
+				reg =3D <0x1c000000 0x00001000>;
+				intel,offset-settings =3D
+					/* CAIUAMIGR */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* FPGA2SOC */
+			i_ccu_ncaiu0@1c001000 {
+				reg =3D <0x1c001000 0x00001000>;
+				intel,offset-settings =3D
+					/* NCAIU0AMIGR */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* GIC_M */
+			i_ccu_ncaiu1@1c002000 {
+				reg =3D <0x1c002000 0x00001000>;
+				intel,offset-settings =3D
+					/* NCAIU1AMIGR */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* SMMU */
+			i_ccu_ncaiu2@1c003000 {
+				reg =3D <0x1c003000 0x00001000>;
+				intel,offset-settings =3D
+					/* NCAIU2AMIGR */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* PSS NOC */
+			i_ccu_ncaiu3@1c004000 {
+				reg =3D <0x1c004000 0x00001000>;
+				intel,offset-settings =3D
+					/* NCAIU3AMIGR */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* DCE0 */
+			i_ccu_dce0@1c005000 {
+				reg =3D <0x1c005000 0x00001000>;
+				intel,offset-settings =3D
+					/* DCEUAMIGR0 */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* DCE1 */
+			i_ccu_dce1@1c006000 {
+				reg =3D <0x1c006000 0x00001000>;
+				intel,offset-settings =3D
+					/* DCEUAMIGR1 */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+		};
+
+		socfpga_ccu_ddr_interleaving_on: socfpga-ccu-ddr-interleaving-on {
+			compatible =3D "intel,socfpga-dtreg";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			bootph-all;
+
+			/* DSU */
+			i_ccu_caiu0@1c000000 {
+				reg =3D <0x1c000000 0x00001000>;
+				intel,offset-settings =3D
+					/* CAIUAMIGR */
+					<0x000003c0 0x00000001 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81200006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81600006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81a00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* FPGA2SOC */
+			i_ccu_ncaiu0@1c001000 {
+				reg =3D <0x1c001000 0x00001000>;
+				intel,offset-settings =3D
+					/* NCAIU0AMIGR */
+					<0x000003c0 0x00000001 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81200006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81600006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81a00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* GIC_M */
+			i_ccu_ncaiu1@1c002000 {
+				reg =3D <0x1c002000 0x00001000>;
+				intel,offset-settings =3D
+					/* NCAIU1AMIGR */
+					<0x000003c0 0x00000001 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81200006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81600006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81a00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* SMMU */
+			i_ccu_ncaiu2@1c003000 {
+				reg =3D <0x1c003000 0x00001000>;
+				intel,offset-settings =3D
+					/* NCAIU2AMIGR */
+					<0x000003c0 0x00000001 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81200006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81600006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81a00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* PSS NOC */
+			i_ccu_ncaiu3@1c004000 {
+				reg =3D <0x1c004000 0x00001000>;
+				intel,offset-settings =3D
+					/* NCAIU3AMIGR */
+					<0x000003c0 0x00000001 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81200006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81600006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81a00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* DCE0 */
+			i_ccu_dce0@1c005000 {
+				reg =3D <0x1c005000 0x00001000>;
+				intel,offset-settings =3D
+					/* DCEUAMIGR0 */
+					<0x000003c0 0x00000001 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81200006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81600006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81a00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* DCE1 */
+			i_ccu_dce1@1c006000 {
+				reg =3D <0x1c006000 0x00001000>;
+				intel,offset-settings =3D
+					/* DCEUAMIGR1 */
+					<0x000003c0 0x00000001 0x0000001f>,
+					/* DMI_SDRAM_2G */
+					<0x00000460 0x81200006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000480 0x81600006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a0 0x81a00006 0xc1f03e1f>;
+				bootph-all;
+			};
+		};
+
 		socfpga_smmu_secure_config: socfpga-smmu-secure-config {
 			compatible =3D "intel,socfpga-dtreg";
 			#address-cells =3D <1>;
@@ -422,6 +646,26 @@
 				bootph-all;
 			};
 		};
+
+		socfpga_noc_fw_mpfe_csr: socfpga-noc-fw-mpfe-csr {
+			compatible =3D "intel,socfpga-dtreg";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			bootph-all;
+
+			/* noc fw mpfe csr */
+			i_noc_fw_mpfe_csr@18000d00 {
+				reg =3D <0x18000d00 0x00000100>;
+				intel,offset-settings =3D
+					/* mpfe scr io96b0 reg*/
+					<0x00000000 0x00000001 0x00010101>,
+					/* mpfe scr io96b1 reg*/
+					<0x00000004 0x00000001 0x00010101>,
+					/* mpfe scr noc csr*/
+					<0x00000008 0x00000001 0x00010101>;
+				bootph-all;
+			};
+		};
 	};
 };
=20
@@ -467,6 +711,13 @@
 	bootph-all;
 };
=20
+&sdr {
+	compatible =3D "intel,sdr-ctl-agilex5";
+	reg =3D <0x18000000 0x400000>;
+	resets =3D <&rst DDRSCH_RESET>;
+	bootph-all;
+};
+
 &sysmgr {
 	compatible =3D "altr,sys-mgr", "syscon";
 	bootph-all;
diff --git a/arch/arm/dts/socfpga_agilex5.dtsi b/arch/arm/dts/socfpga_agile=
x5.dtsi
index 03b55040497..788e44f724b 100644
--- a/arch/arm/dts/socfpga_agilex5.dtsi
+++ b/arch/arm/dts/socfpga_agilex5.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier:     GPL-2.0
 /*
  * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
=20
 /dts-v1/;
@@ -544,6 +545,13 @@
 			status =3D "disabled";
 		};
=20
+		sdr: sdr@18000000 {
+			compatible =3D "intel,sdr-ctl-agilex5";
+			reg =3D <0x18000000 0x400000>;
+			resets =3D <&rst DDRSCH_RESET>;
+			bootph-all;
+		};
+
 		/* QSPI address not available yet */
 		qspi: spi@108d2000 {
 			compatible =3D "cdns,qspi-nor";
diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/=
socfpga_agilex5_socdk-u-boot.dtsi
index 540b2662283..e08dd5523f2 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -22,11 +22,38 @@
 		};
 	};
=20
-	memory {
-		/* 8GB */
-		reg =3D <0 0x80000000 0 0x80000000>,
-		      <8 0x80000000 1 0x80000000>;
-	};
+	/*
+	 * Both Memory base address and size default info is retrieved from HW se=
tting.
+	 * Reconfiguration / Overwrite these info can be done with examples below=
.
+	 */
+	/*
+	 * Example for memory size with 2GB:
+	 * memory {
+	 *	reg =3D <0x0 0x80000000 0x0 0x80000000>;
+	 * };
+	 */
+	/*
+	 * Example for memory size with 8GB:
+	 * memory {
+	 *	reg =3D <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x80000000>;
+	 * };
+	 */
+	/*
+	 * Example for memory size with 32GB:
+	 * memory {
+	 *	reg =3D <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>;
+	 * };
+	 */
+	/*
+	 * Example for memory size with 512GB:
+	 * memory {
+	 *	reg =3D <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>,
+	 *	      <0x88 0x00000000 0x78 0x00000000>;
+	 * };
+	 */
=20
 	chosen {
 		stdout-path =3D "serial0:115200n8";
diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
index d07b3fc3618..024c688e705 100644
--- a/arch/arm/mach-socfpga/board.c
+++ b/arch/arm/mach-socfpga/board.c
@@ -6,23 +6,24 @@
  */
=20
 #include <config.h>
-#include <asm/arch/board.h>
-#include <asm/arch/clock_manager.h>
-#include <asm/arch/mailbox_s10.h>
-#include <asm/arch/misc.h>
-#include <asm/arch/reset_manager.h>
-#include <asm/arch/secure_vab.h>
-#include <asm/arch/smc_api.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
 #include <errno.h>
 #include <fdtdec.h>
+#include <log.h>
+#include <init.h>
 #include <hang.h>
+#include <handoff.h>
 #include <image.h>
-#include <init.h>
-#include <log.h>
 #include <usb.h>
 #include <usb/dwc2_udc.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/arch/clock_manager.h>
+#include <asm/arch/mailbox_s10.h>
+#include <asm/arch/misc.h>
+#include <asm/arch/reset_manager.h>
+#include <asm/arch/secure_vab.h>
+#include <asm/arch/smc_api.h>
+#include <bloblist.h>
=20
 DECLARE_GLOBAL_DATA_PTR;
=20
@@ -58,7 +59,17 @@ int board_init(void)
=20
 int dram_init_banksize(void)
 {
+#if CONFIG_IS_ENABLED(HANDOFF) && IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5=
)
+#ifndef CONFIG_SPL_BUILD
+	struct spl_handoff *ho;
+	ho =3D bloblist_find(BLOBLISTT_U_BOOT_SPL_HANDOFF, sizeof(*ho));
+	if (!ho)
+		return log_msg_ret("Missing SPL hand-off info", -ENOENT);
+	handoff_load_dram_banks(ho);
+#endif
+#else
 	fdtdec_setup_memory_banksize();
+#endif /* HANDOFF && CONFIG_TARGET_SOCFPGA_AGILEX5 */
=20
 	return 0;
 }
diff --git a/arch/arm/mach-socfpga/include/mach/firewall.h b/arch/arm/mach-=
socfpga/include/mach/firewall.h
index 5cb7f23f8f0..19ce1a53234 100644
--- a/arch/arm/mach-socfpga/include/mach/firewall.h
+++ b/arch/arm/mach-socfpga/include/mach/firewall.h
@@ -1,6 +1,7 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright (C) 2017-2019 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  *
  */
=20
@@ -126,11 +127,27 @@ struct socfpga_firwall_l4_sys {
 #define FW_MPU_DDR_SCR_NONMPUREGION0ADDR_LIMITEXT	0x9c
 #define FW_MPU_DDR_SCR_NONMPUREGION0ADDR_LIMITEXT_FIELD	0xff
=20
+/* Firewall F2SDRAM DDR SCR registers */
+#define FW_F2SDRAM_DDR_SCR_EN				0x00
+#define FW_F2SDRAM_DDR_SCR_EN_SET			0x04
+#define FW_F2SDRAM_DDR_SCR_REGION0ADDR_BASE		0x10
+#define FW_F2SDRAM_DDR_SCR_REGION0ADDR_BASEEXT		0x14
+#define FW_F2SDRAM_DDR_SCR_REGION0ADDR_LIMIT		0x18
+#define FW_F2SDRAM_DDR_SCR_REGION0ADDR_LIMITEXT		0x1c
+
 #define MPUREGION0_ENABLE				BIT(0)
 #define NONMPUREGION0_ENABLE				BIT(8)
=20
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+#define FW_MPU_DDR_SCR_WRITEL(data, reg)		\
+	writel(data, SOCFPGA_FW_DDR_CCU_DMI0_ADDRESS + (reg)); \
+	writel(data, SOCFPGA_FW_DDR_CCU_DMI1_ADDRESS + (reg))
+#define FW_F2SDRAM_DDR_SCR_WRITEL(data, reg)		\
+	writel(data, SOCFPGA_FW_TBU2NOC_ADDRESS + (reg))
+#else
 #define FW_MPU_DDR_SCR_WRITEL(data, reg)		\
 	writel(data, SOCFPGA_FW_MPU_DDR_SCR_ADDRESS + (reg))
+#endif
=20
 void firewall_setup(void);
=20
diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index fbe3af845d8..33a157e098e 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -5,27 +5,29 @@
=20
 #include <config.h>
 #include <command.h>
-#include <cpu_func.h>
-#include <hang.h>
-#include <asm/cache.h>
-#include <init.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
 #include <errno.h>
+#include <init.h>
+#include <handoff.h>
+#include <hang.h>
+#include <watchdog.h>
 #include <fdtdec.h>
 #include <linux/libfdt.h>
-#include <altera.h>
+#include <linux/printk.h>
 #include <miiphy.h>
 #include <netdev.h>
-#include <watchdog.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/cache.h>
+#include <asm/pl310.h>
 #include <asm/arch/misc.h>
+#include <asm/arch/nic301.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/arch/scan_manager.h>
-#include <asm/arch/system_manager.h>
-#include <asm/arch/nic301.h>
 #include <asm/arch/scu.h>
-#include <asm/pl310.h>
-#include <linux/printk.h>
+#include <asm/arch/system_manager.h>
+#include <altera.h>
+#include <bloblist.h>
+#include <cpu_func.h>
=20
 DECLARE_GLOBAL_DATA_PTR;
=20
@@ -51,8 +53,17 @@ struct bsel bsel_str[] =3D {
=20
 int dram_init(void)
 {
+#if CONFIG_IS_ENABLED(HANDOFF) && IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5=
)
+	struct spl_handoff *ho;
+	ho =3D bloblist_find(BLOBLISTT_U_BOOT_SPL_HANDOFF, sizeof(*ho));
+	if (!ho)
+		return log_msg_ret("Missing SPL hand-off info", -ENOENT);
+	gd->ram_size =3D ho->ram_bank[0].size;
+	gd->ram_base =3D ho->ram_bank[0].start;
+#else
 	if (fdtdec_setup_mem_size_base() !=3D 0)
 		return -EINVAL;
+#endif /* HANDOFF && CONFIG_TARGET_SOCFPGA_AGILEX5 */
=20
 	return 0;
 }
diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-socfpga/mis=
c_soc64.c
index 793b8b8e390..e0b2b4237e1 100644
--- a/arch/arm/mach-socfpga/misc_soc64.c
+++ b/arch/arm/mach-socfpga/misc_soc64.c
@@ -6,17 +6,18 @@
  */
=20
 #include <altera.h>
+#include <env.h>
+#include <errno.h>
+#include <init.h>
+#include <log.h>
 #include <asm/arch/board.h>
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/arch/system_manager.h>
 #include <asm/io.h>
+#include <asm/system.h>
 #include <asm/global_data.h>
-#include <env.h>
-#include <errno.h>
-#include <init.h>
-#include <log.h>
 #include <mach/clock_manager.h>
=20
 DECLARE_GLOBAL_DATA_PTR;
@@ -41,6 +42,19 @@ static Altera_desc altera_fpga[] =3D {
 	},
 };
=20
+/*
+ * The Agilex5 platform has enabled the bloblist feature, and the bloblist
+ * address and size are initialized based on the defconfig settings.
+ * During the SPL phase, this function is used to prevent the bloblist
+ * from initializing its address and size with the saved boot parameters,
+ * which may have been incorrectly set.
+ */
+void save_boot_params(unsigned long r0, unsigned long r1, unsigned long r2=
,
+		      unsigned long r3)
+{
+	save_boot_params_ret();
+}
+
 /*
  * Print CPU information
  */
diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_de=
fconfig
index 2a2c76113cd..10686a0a7b3 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=3Dy
 CONFIG_ARCH_SOCFPGA=3Dy
 CONFIG_TEXT_BASE=3D0x80200000
-CONFIG_NR_DRAM_BANKS=3D2
+CONFIG_NR_DRAM_BANKS=3D3
 CONFIG_SPL_LDSCRIPT=3D"arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80300000
@@ -10,7 +10,7 @@ CONFIG_ENV_SIZE=3D0x2000
 CONFIG_DM_GPIO=3Dy
 CONFIG_DEFAULT_DEVICE_TREE=3D"socfpga_agilex5_socdk"
 CONFIG_DM_RESET=3Dy
-CONFIG_SPL_STACK=3D0x7f000
+CONFIG_SPL_STACK=3D0x7d000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
 CONFIG_SPL_BSS_START_ADDR=3D0xbff00000
 CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
@@ -93,3 +93,7 @@ CONFIG_WDT=3Dy
 CONFIG_PANIC_HANG=3Dy
 CONFIG_SPL_CRC32=3Dy
 CONFIG_BOARD_EARLY_INIT_F=3Dy
+CONFIG_BLOBLIST=3Dy
+CONFIG_BLOBLIST_SIZE=3D0x1000
+CONFIG_BLOBLIST_ADDR=3D0x7e000
+CONFIG_HANDOFF=3Dy
diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
index c1d6a6b6c59..b19f3601813 100644
--- a/drivers/ddr/altera/Makefile
+++ b/drivers/ddr/altera/Makefile
@@ -4,7 +4,7 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 #
 # (C) Copyright 2010, Thomas Chou <thomas@wytron.com.tw>
-# Copyright (C) 2014-2021 Altera Corporation <www.altera.com>
+# Copyright (C) 2014-2025 Altera Corporation <www.altera.com>
=20
 ifdef CONFIG_$(XPL_)ALTERA_SDRAM
 obj-$(CONFIG_TARGET_SOCFPGA_GEN5) +=3D sdram_gen5.o sequencer.o
@@ -12,4 +12,5 @@ obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) +=3D sdram_arria10.o
 obj-$(CONFIG_TARGET_SOCFPGA_STRATIX10) +=3D sdram_soc64.o sdram_s10.o
 obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) +=3D sdram_soc64.o sdram_agilex.o
 obj-$(CONFIG_TARGET_SOCFPGA_N5X) +=3D sdram_soc64.o sdram_n5x.o
+obj-$(CONFIG_TARGET_SOCFPGA_AGILEX5) +=3D sdram_soc64.o sdram_agilex5.o io=
ssm_mailbox.o
 endif
diff --git a/drivers/ddr/altera/iossm_mailbox.c b/drivers/ddr/altera/iossm_=
mailbox.c
new file mode 100644
index 00000000000..db9435db657
--- /dev/null
+++ b/drivers/ddr/altera/iossm_mailbox.c
@@ -0,0 +1,748 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ *
+ */
+
+#include <hang.h>
+#include <string.h>
+#include <wait_bit.h>
+#include <asm/arch/base_addr_soc64.h>
+#include <asm/io.h>
+#include <linux/bitfield.h>
+#include "iossm_mailbox.h"
+
+#define TIMEOUT_120000MS			120000
+#define TIMEOUT_60000MS				60000
+#define TIMEOUT					TIMEOUT_120000MS
+#define IOSSM_STATUS_CAL_SUCCESS		BIT(0)
+#define IOSSM_STATUS_CAL_FAIL			BIT(1)
+#define IOSSM_STATUS_CAL_BUSY			BIT(2)
+#define IOSSM_STATUS_COMMAND_RESPONSE_READY	BIT(0)
+#define IOSSM_CMD_RESPONSE_STATUS_OFFSET	0x45C
+#define IOSSM_CMD_RESPONSE_DATA_0_OFFSET	0x458
+#define IOSSM_CMD_RESPONSE_DATA_1_OFFSET	0x454
+#define IOSSM_CMD_RESPONSE_DATA_2_OFFSET	0x450
+#define IOSSM_CMD_REQ_OFFSET			0x43C
+#define IOSSM_CMD_PARAM_0_OFFSET		0x438
+#define IOSSM_CMD_PARAM_1_OFFSET		0x434
+#define IOSSM_CMD_PARAM_2_OFFSET		0x430
+#define IOSSM_CMD_PARAM_3_OFFSET		0x42C
+#define IOSSM_CMD_PARAM_4_OFFSET		0x428
+#define IOSSM_CMD_PARAM_5_OFFSET		0x424
+#define IOSSM_CMD_PARAM_6_OFFSET		0x420
+#define IOSSM_CMD_RESPONSE_DATA_SHORT_MASK	GENMASK(31, 16)
+#define IOSSM_CMD_RESPONSE_DATA_SHORT(n)	FIELD_GET(IOSSM_CMD_RESPONSE_DATA=
_SHORT_MASK, n)
+#define IOSSM_STATUS_CMD_RESPONSE_ERROR_MASK	GENMASK(7, 5)
+#define IOSSM_STATUS_CMD_RESPONSE_ERROR(n)	FIELD_GET(IOSSM_STATUS_CMD_RESP=
ONSE_ERROR_MASK, n)
+#define IOSSM_STATUS_GENERAL_ERROR_MASK		GENMASK(4, 1)
+#define IOSSM_STATUS_GENERAL_ERROR(n)		FIELD_GET(IOSSM_STATUS_GENERAL_ERRO=
R_MASK, n)
+
+/* Offset of Mailbox Read-only Registers  */
+#define IOSSM_MAILBOX_HEADER_OFFSET			0x0
+#define IOSSM_MEM_INTF_INFO_0_OFFSET			0X200
+#define IOSSM_MEM_INTF_INFO_1_OFFSET			0x280
+#define IOSSM_MEM_TECHNOLOGY_INTF0_OFFSET		0x210
+#define IOSSM_MEM_TECHNOLOGY_INTF1_OFFSET		0x290
+#define IOSSM_MEM_WIDTH_INFO_INTF0_OFFSET		0x230
+#define IOSSM_MEM_WIDTH_INFO_INTF1_OFFSET		0x2B0
+#define IOSSM_MEM_TOTAL_CAPACITY_INTF0_OFFSET		0x234
+#define IOSSM_MEM_TOTAL_CAPACITY_INTF1_OFFSET		0x2B4
+#define IOSSM_ECC_ENABLE_INTF0_OFFSET			0x240
+#define IOSSM_ECC_ENABLE_INTF1_OFFSET			0x2C0
+#define IOSSM_ECC_SCRUB_STATUS_INTF0_OFFSET		0x244
+#define IOSSM_ECC_SCRUB_STATUS_INTF1_OFFSET		0x2C4
+#define IOSSM_LP_MODE_INTF0_OFFSET			0x250
+#define IOSSM_LP_MODE_INTF1_OFFSET			0x2D0
+#define IOSSM_MEM_INIT_STATUS_INTF0_OFFSET		0x260
+#define IOSSM_MEM_INIT_STATUS_INTF1_OFFSET		0x2E0
+#define IOSSM_BIST_STATUS_INTF0_OFFSET			0x264
+#define IOSSM_BIST_STATUS_INTF1_OFFSET			0x2E4
+#define IOSSM_ECC_ERR_STATUS_OFFSET			0x300
+#define IOSSM_ECC_ERR_DATA_START_OFFSET			0x310
+#define IOSSM_STATUS_OFFSET				0x400
+#define IOSSM_STATUS_CAL_INTF0_OFFSET			0x404
+#define IOSSM_STATUS_CAL_INTF1_OFFSET			0x408
+
+#define ECC_INTSTATUS_SERR SOCFPGA_SYSMGR_ADDRESS + 0x9C
+#define ECC_INISTATUS_DERR SOCFPGA_SYSMGR_ADDRESS + 0xA0
+#define DDR_CSR_CLKGEN_LOCKED_IO96B0_MASK BIT(16)
+#define DDR_CSR_CLKGEN_LOCKED_IO96B1_MASK BIT(17)
+
+/* offset info of GET_MEM_INTF_INFO */
+#define INTF_IP_TYPE_MASK		GENMASK(31, 29)
+#define INTF_INSTANCE_ID_MASK		GENMASK(28, 24)
+
+/* offset info of GET_MEM_CAL_STATUS */
+#define INTF_UNUSED			0x0
+#define INTF_MEM_CAL_STATUS_SUCCESS	0x1
+#define INTF_MEM_CAL_STATUS_FAIL	0x2
+#define INTF_MEM_CAL_STATUS_ONGOING	0x4
+
+/* offset info of  MEM_TECHNOLOGY_INTF */
+#define INTF_DDR_TYPE_MASK		GENMASK(2, 0)
+
+/* offset info of MEM_TOTAL_CAPACITY_INTF */
+#define INTF_CAPACITY_GBITS_MASK	GENMASK(7, 0)
+
+/* offset info of ECC_ENABLE_INTF */
+#define INTF_ECC_ENABLE_TYPE_MASK	GENMASK(1, 0)
+
+/* cmd opcode BIST_MEM_INIT_START, BIST performed on full memory address r=
ange */
+#define BIST_FULL_MEM			BIT(6)
+
+/* offset info of ECC_ENABLE_INTF */
+#define INTF_BIST_STATUS_MASK		BIT(0)
+
+/* offset info of ECC_ERR_STATUS */
+#define ECC_ERR_COUNTER_MASK		GENMASK(15, 0)
+
+/* offset info of ECC_ERR_DATA */
+#define ECC_ERR_IP_TYPE_MASK		GENMASK(24, 22)
+#define ECC_ERR_INSTANCE_ID_MASK	GENMASK(21, 17)
+#define ECC_ERR_SOURCE_ID_MASK		GENMASK(16, 10)
+#define ECC_ERR_TYPE_MASK		GENMASK(9, 6)
+#define ECC_ERR_ADDR_UPPER_MASK		GENMASK(5, 0)
+#define ECC_ERR_ADDR_LOWER_MASK		GENMASK(31, 0)
+
+#define MAX_ECC_ERR_INFO_COUNT 16
+
+#define IO96B_MB_REQ_SETUP(v, w, x, y, z) \
+	usr_req.ip_type =3D v; \
+	usr_req.ip_id =3D w; \
+	usr_req.usr_cmd_type =3D x; \
+	usr_req.usr_cmd_opcode =3D y; \
+	usr_req.cmd_param[0] =3D z; \
+	for (n =3D 1; n < NUM_CMD_PARAM; n++) \
+		usr_req.cmd_param[n] =3D 0
+#define MAX_RETRY_COUNT 3
+#define NUM_CMD_RESPONSE_DATA 3
+
+#define IO96B0_PLL_A_MASK	BIT(0)
+#define IO96B0_PLL_B_MASK	BIT(1)
+#define IO96B1_PLL_A_MASK	BIT(2)
+#define IO96B1_PLL_B_MASK	BIT(3)
+
+/* supported DDR type list */
+static const char *ddr_type_list[7] =3D {
+		"DDR4", "DDR5", "DDR5_RDIMM", "LPDDR4", "LPDDR5", "QDRIV", "UNKNOWN"
+};
+
+/* Define an enumeration for ECC error types */
+enum ecc_error_type {
+	SINGLE_BIT_ERROR =3D 0,			/* 0b0000 */
+	MULTIPLE_SINGLE_BIT_ERRORS =3D 1,		/* 0b0001 */
+	DOUBLE_BIT_ERROR =3D 2,			/* 0b0010 */
+	MULTIPLE_DOUBLE_BIT_ERRORS =3D 3,		/* 0b0011 */
+	SINGLE_BIT_ERROR_SCRUBBING =3D 8,		/* 0b1000 */
+	WRITE_LINK_SINGLE_BIT_ERROR =3D 9,	/* 0b1001 */
+	WRITE_LINK_DOUBLE_BIT_ERROR =3D 10,	/* 0b1010 */
+	READ_LINK_SINGLE_BIT_ERROR =3D 11,	/* 0b1011 */
+	READ_LINK_DOUBLE_BIT_ERROR =3D 12,	/* 0b1100 */
+	READ_MODIFY_WRITE_DOUBLE_BIT_ERROR =3D 13	/* 0b1101 */
+};
+
+/*
+ * ecc error info
+ *
+ * @ip_type:		The IP type of the interface that produced the ECC interrupt=
.
+ * @instance_id:	The instance ID of the interface that produced the ECC in=
terrupt.
+ * @ecc_err_source_id:	The source ID associated with the ECC event.
+ * @ecc_err_type:	The ECC error type of the ECC event.
+ * @ecc_err_addr_upper:	Upper 6 bits of the address of the read data that =
caused the ECC event.
+ * @ecc_err_addr_lower:	Lower 32 bits of the address of the read data that=
 caused the ECC event.
+ */
+struct ecc_err_info {
+	u32 ip_type;
+	u32 instance_id;
+	u32 source_id;
+	enum ecc_error_type err_type;
+	u32 addr_upper;
+	u32 addr_lower;
+};
+
+static int is_ddr_csr_clkgen_locked(u8 io96b_pll)
+{
+	int ret =3D 0;
+	const char *pll_names[MAX_IO96B_SUPPORTED][2] =3D {
+		{"io96b_0 clkgenA", "io96b_0 clkgenB"},
+		{"io96b_1 clkgenA", "io96b_1 clkgenB"}
+	};
+	u32 masks[MAX_IO96B_SUPPORTED][2] =3D {
+		{IO96B0_PLL_A_MASK, IO96B0_PLL_B_MASK},
+		{IO96B1_PLL_A_MASK, IO96B1_PLL_B_MASK}
+	};
+	u32 lock_masks[MAX_IO96B_SUPPORTED] =3D {
+		DDR_CSR_CLKGEN_LOCKED_IO96B0_MASK,
+		DDR_CSR_CLKGEN_LOCKED_IO96B1_MASK
+	};
+
+	for (int i =3D 0; i < MAX_IO96B_SUPPORTED ; i++) {
+		/* Check for PLL_A */
+		if (io96b_pll & masks[i][0]) {
+			ret =3D wait_for_bit_le32((const void *)(ECC_INTSTATUS_SERR), lock_mask=
s[i],
+						true, TIMEOUT, false);
+
+			if (ret) {
+				debug("%s: ddr csr %s locked is timeout\n",
+				      __func__, pll_names[i][0]);
+				goto err;
+			} else {
+				debug("%s: ddr csr %s is successfully locked\n",
+				      __func__, pll_names[i][0]);
+			}
+		}
+
+		/* Check for PLL_B */
+		if (io96b_pll & masks[i][1]) {
+			ret =3D wait_for_bit_le32((const void *)(ECC_INISTATUS_DERR), lock_mask=
s[i],
+						true, TIMEOUT, false);
+
+			if (ret) {
+				debug("%s: ddr csr %s locked is timeout\n",
+				      __func__, pll_names[i][1]);
+				goto err;
+			} else {
+				debug("%s: ddr csr %s is successfully locked\n",
+				      __func__, pll_names[i][1]);
+			}
+		}
+	}
+
+err:
+	return ret;
+}
+
+/*
+ * Mailbox request function
+ * This function will send the request to IOSSM mailbox and wait for respo=
nse return
+ *
+ * @io96b_csr_addr: CSR address for the target IO96B
+ * @req:            Structure contain command request for IOSSM mailbox co=
mmand
+ * @resp_data_len:  User desire extra response data fields other than
+ *		    CMD_RESPONSE_DATA_SHORT field on CMD_RESPONSE_STATUS
+ * @resp:           Structure contain responses returned from the requeste=
d IOSSM
+ *		    mailbox command
+ */
+int io96b_mb_req(phys_addr_t io96b_csr_addr, struct io96b_mb_req req,
+		 u32 resp_data_len, struct io96b_mb_resp *resp)
+{
+	int i, ret;
+	u32 cmd_req;
+
+	if (!resp) {
+		ret =3D -EINVAL;
+		goto err;
+	}
+
+	/* Zero initialization for responses */
+	resp->cmd_resp_status =3D 0;
+
+	/* Ensure CMD_REQ is cleared before write any command request */
+	ret =3D wait_for_bit_le32((const void *)(io96b_csr_addr + IOSSM_CMD_REQ_O=
FFSET),
+				GENMASK(31, 0), false, TIMEOUT, false);
+	if (ret) {
+		printf("%s: Timeout of waiting DDR mailbox ready to be functioned!\n",
+		       __func__);
+		goto err;
+	}
+
+	/* Write CMD_PARAM_* */
+	for (i =3D 0; i < NUM_CMD_PARAM ; i++) {
+		switch (i) {
+		case 0:
+			if (req.cmd_param[0])
+				writel(req.cmd_param[0], io96b_csr_addr + IOSSM_CMD_PARAM_0_OFFSET);
+			break;
+		case 1:
+			if (req.cmd_param[1])
+				writel(req.cmd_param[1], io96b_csr_addr + IOSSM_CMD_PARAM_1_OFFSET);
+			break;
+		case 2:
+			if (req.cmd_param[2])
+				writel(req.cmd_param[2], io96b_csr_addr + IOSSM_CMD_PARAM_2_OFFSET);
+			break;
+		case 3:
+			if (req.cmd_param[3])
+				writel(req.cmd_param[3], io96b_csr_addr + IOSSM_CMD_PARAM_3_OFFSET);
+			break;
+		case 4:
+			if (req.cmd_param[4])
+				writel(req.cmd_param[4], io96b_csr_addr + IOSSM_CMD_PARAM_4_OFFSET);
+			break;
+		case 5:
+			if (req.cmd_param[5])
+				writel(req.cmd_param[5], io96b_csr_addr + IOSSM_CMD_PARAM_5_OFFSET);
+			break;
+		case 6:
+			if (req.cmd_param[6])
+				writel(req.cmd_param[6], io96b_csr_addr + IOSSM_CMD_PARAM_6_OFFSET);
+			break;
+		}
+	}
+
+	/* Write CMD_REQ (IP_TYPE, IP_INSTANCE_ID, CMD_TYPE and CMD_OPCODE) */
+	cmd_req =3D FIELD_PREP(CMD_TARGET_IP_TYPE_MASK, req.ip_type) |
+		FIELD_PREP(CMD_TARGET_IP_INSTANCE_ID_MASK, req.ip_id) |
+		FIELD_PREP(CMD_TYPE_MASK, req.usr_cmd_type) |
+		FIELD_PREP(CMD_OPCODE_MASK, req.usr_cmd_opcode);
+	writel(cmd_req, io96b_csr_addr + IOSSM_CMD_REQ_OFFSET);
+
+	debug("%s: Write 0x%x to IOSSM_CMD_REQ_OFFSET 0x%llx\n", __func__, cmd_re=
q,
+	      io96b_csr_addr + IOSSM_CMD_REQ_OFFSET);
+
+	/* Read CMD_RESPONSE_READY in CMD_RESPONSE_STATUS */
+	ret =3D wait_for_bit_le32((const void *)(io96b_csr_addr + IOSSM_CMD_RESPO=
NSE_STATUS_OFFSET),
+				IOSSM_STATUS_COMMAND_RESPONSE_READY, true, TIMEOUT, false);
+
+	/* read CMD_RESPONSE_STATUS */
+	resp->cmd_resp_status =3D readl(io96b_csr_addr + IOSSM_CMD_RESPONSE_STATU=
S_OFFSET);
+
+	debug("%s: CMD_RESPONSE_STATUS 0x%llx: 0x%x\n", __func__, io96b_csr_addr =
+
+	      IOSSM_CMD_RESPONSE_STATUS_OFFSET, resp->cmd_resp_status);
+
+	if (ret) {
+		printf("%s: CMD_RESPONSE ERROR:\n", __func__);
+
+		printf("%s: STATUS_GENERAL_ERROR: 0x%lx\n", __func__,
+		       IOSSM_STATUS_GENERAL_ERROR(resp->cmd_resp_status));
+		printf("%s: STATUS_CMD_RESPONSE_ERROR: 0x%lx\n", __func__,
+		       IOSSM_STATUS_CMD_RESPONSE_ERROR(resp->cmd_resp_status));
+		goto err;
+	}
+
+	/* read CMD_RESPONSE_DATA_* */
+	for (i =3D 0; i < resp_data_len; i++) {
+		switch (i) {
+		case 0:
+			resp->cmd_resp_data[i] =3D
+					readl(io96b_csr_addr + IOSSM_CMD_RESPONSE_DATA_0_OFFSET);
+
+			debug("%s: IOSSM_CMD_RESPONSE_DATA_0_OFFSET 0x%llx: 0x%x\n", __func__,
+			      io96b_csr_addr + IOSSM_CMD_RESPONSE_DATA_0_OFFSET,
+			      resp->cmd_resp_data[i]);
+			break;
+		case 1:
+			resp->cmd_resp_data[i] =3D
+					readl(io96b_csr_addr + IOSSM_CMD_RESPONSE_DATA_1_OFFSET);
+
+			debug("%s: IOSSM_CMD_RESPONSE_DATA_1_OFFSET 0x%llx: 0x%x\n", __func__,
+			      io96b_csr_addr + IOSSM_CMD_RESPONSE_DATA_1_OFFSET,
+			      resp->cmd_resp_data[i]);
+			break;
+		case 2:
+			resp->cmd_resp_data[i] =3D
+					readl(io96b_csr_addr + IOSSM_CMD_RESPONSE_DATA_2_OFFSET);
+
+			debug("%s: IOSSM_CMD_RESPONSE_DATA_2_OFFSET 0x%llx: 0x%x\n", __func__,
+			      io96b_csr_addr + IOSSM_CMD_RESPONSE_DATA_2_OFFSET,
+			      resp->cmd_resp_data[i]);
+			break;
+		default:
+			resp->cmd_resp_data[i] =3D 0;
+			printf("%s: Invalid response data\n", __func__);
+		}
+	}
+
+	/* write CMD_RESPONSE_READY =3D 0 */
+	clrbits_le32((u32 *)(uintptr_t)(io96b_csr_addr + IOSSM_CMD_RESPONSE_STATU=
S_OFFSET),
+		     IOSSM_STATUS_COMMAND_RESPONSE_READY);
+
+	debug("%s: After clear CMD_RESPONSE_READY bit: 0x%llx: 0x%x\n", __func__,
+	      io96b_csr_addr + IOSSM_CMD_RESPONSE_STATUS_OFFSET,
+	      readl(io96b_csr_addr + IOSSM_CMD_RESPONSE_STATUS_OFFSET));
+
+err:
+	return ret;
+}
+
+/*
+ * Initial function to be called to set memory interface IP type and insta=
nce ID
+ * IP type and instance ID need to be determined before sending mailbox co=
mmand
+ */
+void io96b_mb_init(struct io96b_info *io96b_ctrl)
+{
+	int i, j;
+	u32 mem_intf_info_0, mem_intf_info_1;
+
+	debug("%s: num_instance %d\n", __func__, io96b_ctrl->num_instance);
+
+	for (i =3D 0; i < io96b_ctrl->num_instance; i++) {
+		debug("%s: get memory interface IO96B %d\n", __func__, i);
+		io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface =3D 0;
+
+		mem_intf_info_0 =3D readl(io96b_ctrl->io96b[i].io96b_csr_addr +
+					IOSSM_MEM_INTF_INFO_0_OFFSET);
+		mem_intf_info_1 =3D readl(io96b_ctrl->io96b[i].io96b_csr_addr +
+					IOSSM_MEM_INTF_INFO_1_OFFSET);
+
+		io96b_ctrl->io96b[i].mb_ctrl.ip_type[0] =3D FIELD_GET(INTF_IP_TYPE_MASK,
+								    mem_intf_info_0);
+		io96b_ctrl->io96b[i].mb_ctrl.ip_id[0] =3D FIELD_GET(INTF_INSTANCE_ID_MAS=
K,
+								  mem_intf_info_0);
+		io96b_ctrl->io96b[i].mb_ctrl.ip_type[1] =3D FIELD_GET(INTF_IP_TYPE_MASK,
+								    mem_intf_info_1);
+		io96b_ctrl->io96b[i].mb_ctrl.ip_id[1] =3D FIELD_GET(INTF_INSTANCE_ID_MAS=
K,
+								  mem_intf_info_1);
+
+		for (j =3D 0; j < MAX_MEM_INTERFACE_SUPPORTED; j++) {
+			if (io96b_ctrl->io96b[i].mb_ctrl.ip_type[j]) {
+				io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface++;
+
+				debug("%s: IO96B %d mem_interface %d: ip_type_ret: 0x%x\n",
+				      __func__, i, j, io96b_ctrl->io96b[i].mb_ctrl.ip_type[j]);
+				debug("%s: IO96B %d mem_interface %d: instance_id_ret: 0x%x\n",
+				      __func__, i, j, io96b_ctrl->io96b[i].mb_ctrl.ip_id[j]);
+			}
+		}
+
+		debug("%s: IO96B %d: num_mem_interface: 0x%x\n", __func__, i,
+		      io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface);
+	}
+}
+
+int io96b_cal_status(phys_addr_t addr)
+{
+	u32 cal_success, cal_fail;
+	phys_addr_t status_addr =3D addr + IOSSM_STATUS_OFFSET;
+	u32 start =3D get_timer(0);
+
+	do {
+		if (get_timer(start) > TIMEOUT_60000MS) {
+			printf("%s: SDRAM calibration for IO96B instance 0x%llx timeout!\n",
+			       __func__, status_addr);
+			hang();
+		}
+
+		udelay(1);
+		schedule();
+
+		/* Polling until getting any calibration result */
+		cal_success =3D readl(status_addr) & IOSSM_STATUS_CAL_SUCCESS;
+		cal_fail =3D readl(status_addr) & IOSSM_STATUS_CAL_FAIL;
+	} while (!cal_success && !cal_fail);
+
+	debug("%s: Calibration for IO96B instance 0x%llx done at %ld msec!\n",
+	      __func__,  status_addr, get_timer(start));
+
+	if (cal_success && !cal_fail)
+		return 0;
+	else
+		return -EPERM;
+}
+
+void init_mem_cal(struct io96b_info *io96b_ctrl)
+{
+	int count, i, ret;
+
+	/* Initialize overall calibration status */
+	io96b_ctrl->overall_cal_status =3D false;
+
+	if (io96b_ctrl->ckgen_lock) {
+		ret =3D is_ddr_csr_clkgen_locked(io96b_ctrl->io96b_pll);
+		if (ret) {
+			printf("%s: iossm IO96B ckgena_lock is not locked\n", __func__);
+			hang();
+		}
+	}
+
+	/* Check initial calibration status for the assigned IO96B */
+	count =3D 0;
+	for (i =3D 0; i < io96b_ctrl->num_instance; i++) {
+		ret =3D io96b_cal_status(io96b_ctrl->io96b[i].io96b_csr_addr);
+		if (ret) {
+			io96b_ctrl->io96b[i].cal_status =3D false;
+
+			printf("%s: Initial DDR calibration IO96B_%d failed %d\n", __func__,
+			       i, ret);
+
+			hang();
+		}
+
+		io96b_ctrl->io96b[i].cal_status =3D true;
+
+		printf("%s: Initial DDR calibration IO96B_%d succeed\n", __func__, i);
+
+		count++;
+	}
+
+	if (count =3D=3D io96b_ctrl->num_instance)
+		io96b_ctrl->overall_cal_status =3D true;
+}
+
+int get_mem_technology(struct io96b_info *io96b_ctrl)
+{
+	int i, j, ret =3D 0;
+	u32 mem_technology_intf;
+	u8 ddr_type_ret;
+
+	u32 mem_technology_intf_offset[MAX_MEM_INTERFACE_SUPPORTED] =3D {
+		IOSSM_MEM_TECHNOLOGY_INTF0_OFFSET,
+		IOSSM_MEM_TECHNOLOGY_INTF1_OFFSET
+	};
+
+	/* Initialize ddr type */
+	io96b_ctrl->ddr_type =3D ddr_type_list[6];
+
+	/* Get and ensure all memory interface(s) same DDR type */
+	for (i =3D 0; i < io96b_ctrl->num_instance; i++) {
+		for (j =3D 0; j < io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface; j++) {
+			mem_technology_intf =3D readl(io96b_ctrl->io96b[i].io96b_csr_addr +
+						    mem_technology_intf_offset[j]);
+
+			ddr_type_ret =3D FIELD_GET(INTF_DDR_TYPE_MASK, mem_technology_intf);
+
+			if (!strcmp(io96b_ctrl->ddr_type, "UNKNOWN"))
+				io96b_ctrl->ddr_type =3D ddr_type_list[ddr_type_ret];
+
+			if (ddr_type_list[ddr_type_ret] !=3D io96b_ctrl->ddr_type) {
+				printf("%s: Mismatch DDR type on IO96B_%d\n", __func__, i);
+
+				ret =3D -EINVAL;
+				goto err;
+			}
+		}
+	}
+
+err:
+	return ret;
+}
+
+int get_mem_width_info(struct io96b_info *io96b_ctrl)
+{
+	int i, j, ret =3D 0;
+	u32 mem_width_info;
+	u16 memory_size, total_memory_size =3D 0;
+
+	u32 mem_total_capacity_intf_offset[MAX_MEM_INTERFACE_SUPPORTED] =3D {
+		IOSSM_MEM_TOTAL_CAPACITY_INTF0_OFFSET,
+		IOSSM_MEM_TOTAL_CAPACITY_INTF1_OFFSET
+	};
+
+	/* Get all memory interface(s) total memory size on all instance(s) */
+	for (i =3D 0; i < io96b_ctrl->num_instance; i++) {
+		memory_size =3D 0;
+		for (j =3D 0; j < io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface; j++) {
+			mem_width_info =3D readl(io96b_ctrl->io96b[i].io96b_csr_addr +
+					       mem_total_capacity_intf_offset[j]);
+
+			memory_size =3D memory_size +
+					FIELD_GET(INTF_CAPACITY_GBITS_MASK, mem_width_info);
+		}
+
+		if (!memory_size) {
+			printf("%s: Failed to get valid memory size\n", __func__);
+			ret =3D -EINVAL;
+			goto err;
+		}
+
+		io96b_ctrl->io96b[i].size =3D memory_size;
+
+		total_memory_size =3D total_memory_size + memory_size;
+	}
+
+	if (!total_memory_size) {
+		printf("%s: Failed to get valid memory size\n", __func__);
+		ret =3D -EINVAL;
+	}
+
+	io96b_ctrl->overall_size =3D total_memory_size;
+
+err:
+	return ret;
+}
+
+int ecc_enable_status(struct io96b_info *io96b_ctrl)
+{
+	int i, j, ret =3D 0;
+	u32 ecc_enable_intf;
+	bool ecc_stat, ecc_stat_set =3D false;
+
+	u32 ecc_enable_intf_offset[MAX_MEM_INTERFACE_SUPPORTED] =3D {
+		IOSSM_ECC_ENABLE_INTF0_OFFSET,
+		IOSSM_ECC_ENABLE_INTF1_OFFSET
+	};
+
+	/* Initialize ECC status */
+	io96b_ctrl->ecc_status =3D false;
+
+	/* Get and ensure all memory interface(s) same ECC status */
+	for (i =3D 0; i < io96b_ctrl->num_instance; i++) {
+		for (j =3D 0; j < io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface; j++) {
+			ecc_enable_intf =3D readl(io96b_ctrl->io96b[i].io96b_csr_addr +
+						ecc_enable_intf_offset[j]);
+
+			ecc_stat =3D (FIELD_GET(INTF_ECC_ENABLE_TYPE_MASK, ecc_enable_intf)
+				    =3D=3D 0) ? false : true;
+
+			if (!ecc_stat_set) {
+				io96b_ctrl->ecc_status =3D ecc_stat;
+				ecc_stat_set =3D true;
+			}
+
+			if (ecc_stat !=3D io96b_ctrl->ecc_status) {
+				printf("%s: Mismatch DDR ECC status on IO96B_%d\n", __func__, i);
+
+				ret =3D -EINVAL;
+				goto err;
+			}
+		}
+	}
+
+	debug("%s: ECC enable status: %d\n", __func__, io96b_ctrl->ecc_status);
+
+err:
+	return ret;
+}
+
+bool is_double_bit_error(enum ecc_error_type err_type)
+{
+	switch (err_type) {
+	case DOUBLE_BIT_ERROR:
+	case MULTIPLE_DOUBLE_BIT_ERRORS:
+	case WRITE_LINK_DOUBLE_BIT_ERROR:
+	case READ_LINK_DOUBLE_BIT_ERROR:
+	case READ_MODIFY_WRITE_DOUBLE_BIT_ERROR:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
+bool ecc_interrupt_status(struct io96b_info *io96b_ctrl)
+{
+	int i, j;
+	u32 ecc_err_status;
+	u16 ecc_err_counter;
+	bool ecc_error_flag =3D false;
+
+	/* Get ECC double-bit error status */
+	for (i =3D 0; i < io96b_ctrl->num_instance; i++) {
+		ecc_err_status =3D readl(io96b_ctrl->io96b[i].io96b_csr_addr +
+					IOSSM_ECC_ERR_STATUS_OFFSET);
+		ecc_err_counter =3D FIELD_GET(ECC_ERR_COUNTER_MASK, ecc_err_status);
+		debug("%s: ECC error number detected on IO96B_%d: %d\n",
+		      __func__, i, ecc_err_counter);
+
+		if (ecc_err_counter !=3D 0) {
+			phys_addr_t address;
+			u32 ecc_err_data;
+			struct ecc_err_info err_info;
+
+			address =3D io96b_ctrl->io96b[i].io96b_csr_addr +
+				    IOSSM_ECC_ERR_DATA_START_OFFSET;
+
+			for (j =3D 0; j < ecc_err_counter && j < MAX_ECC_ERR_INFO_COUNT; j++) {
+				ecc_err_data =3D readl(address);
+				err_info.err_type =3D FIELD_GET(ECC_ERR_TYPE_MASK,
+							      ecc_err_data);
+				err_info.ip_type =3D FIELD_GET(ECC_ERR_IP_TYPE_MASK,
+							     ecc_err_data);
+				err_info.instance_id =3D FIELD_GET(ECC_ERR_INSTANCE_ID_MASK,
+								 ecc_err_data);
+				err_info.source_id =3D FIELD_GET(ECC_ERR_SOURCE_ID_MASK,
+							       ecc_err_data);
+				err_info.addr_upper =3D FIELD_GET(ECC_ERR_ADDR_UPPER_MASK,
+								ecc_err_data);
+				err_info.addr_lower =3D readl(address + sizeof(u32));
+
+				debug("%s: ECC double-bit error detected on IO96B_%d:\n",
+				      __func__, i);
+				debug("- error info address :0x%llx\n", address);
+				debug("- error ip type: %d\n", err_info.ip_type);
+				debug("- error instance id: %d\n", err_info.instance_id);
+				debug("- error source id: %d\n", err_info.source_id);
+				debug("- error type: %d\n", err_info.err_type);
+				debug("- error address upper: 0x%x\n", err_info.addr_upper);
+				debug("- error address lower: 0x%x\n", err_info.addr_lower);
+
+				if (is_double_bit_error(err_info.err_type)) {
+					if (!ecc_error_flag)
+						ecc_error_flag =3D true;
+				}
+
+				address +=3D sizeof(u32) * 2;
+			}
+		}
+	}
+
+	if (ecc_error_flag)
+		printf("\n%s: ECC double-bit error detected!\n", __func__);
+
+	return ecc_error_flag;
+}
+
+int bist_mem_init_start(struct io96b_info *io96b_ctrl)
+{
+	struct io96b_mb_req usr_req;
+	struct io96b_mb_resp usr_resp;
+	int i, j, n, ret =3D 0;
+	bool bist_start, bist_success;
+	u32 mem_init_status_intf, start;
+
+	u32 mem_init_status_offset[MAX_MEM_INTERFACE_SUPPORTED] =3D {
+		IOSSM_MEM_INIT_STATUS_INTF0_OFFSET,
+		IOSSM_MEM_INIT_STATUS_INTF1_OFFSET
+	};
+
+	/* Full memory initialization BIST performed on all memory interface(s) *=
/
+	for (i =3D 0; i < io96b_ctrl->num_instance; i++) {
+		for (j =3D 0; j < io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface; j++) {
+			bist_start =3D false;
+			bist_success =3D false;
+
+			/* Start memory initialization BIST on full memory address */
+			IO96B_MB_REQ_SETUP(io96b_ctrl->io96b[i].mb_ctrl.ip_type[j],
+					   io96b_ctrl->io96b[i].mb_ctrl.ip_id[j],
+					   CMD_TRIG_CONTROLLER_OP, BIST_MEM_INIT_START,
+					   BIST_FULL_MEM);
+
+			ret =3D io96b_mb_req(io96b_ctrl->io96b[i].io96b_csr_addr,
+					   usr_req, 0, &usr_resp);
+			if (ret)
+				goto err;
+
+			bist_start =3D IOSSM_CMD_RESPONSE_DATA_SHORT(usr_resp.cmd_resp_status)
+				& BIT(0);
+
+			if (!bist_start) {
+				printf("%s: Failed to initialize memory on IO96B_%d\n", __func__,
+				       i);
+				printf("%s: BIST_MEM_INIT_START Error code 0x%lx\n", __func__,
+				       IOSSM_STATUS_CMD_RESPONSE_ERROR(usr_resp.cmd_resp_status));
+
+				ret =3D -EINVAL;
+				goto err;
+			}
+
+			/* Polling for the initiated memory initialization BIST status */
+			start =3D get_timer(0);
+			while (!bist_success) {
+				udelay(1);
+
+				mem_init_status_intf =3D readl(io96b_ctrl->io96b[i].io96b_csr_addr +
+							     mem_init_status_offset[j]);
+
+				bist_success =3D FIELD_GET(INTF_BIST_STATUS_MASK,
+							 mem_init_status_intf);
+
+				if (!bist_success && (get_timer(start) > TIMEOUT)) {
+					printf("%s: Timeout initialize memory on IO96B_%d\n",
+					       __func__, i);
+					printf("%s: BIST_MEM_INIT_STATUS Error code 0x%lx\n",
+					       __func__,
+					IOSSM_STATUS_CMD_RESPONSE_ERROR(usr_resp.cmd_resp_status));
+
+					ret =3D -ETIMEDOUT;
+					goto err;
+				}
+			}
+		}
+
+		debug("%s: Memory initialized successfully on IO96B_%d\n", __func__, i);
+	}
+
+err:
+	return ret;
+}
diff --git a/drivers/ddr/altera/iossm_mailbox.h b/drivers/ddr/altera/iossm_=
mailbox.h
new file mode 100644
index 00000000000..6f794781d30
--- /dev/null
+++ b/drivers/ddr/altera/iossm_mailbox.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ *
+ */
+
+#define MAX_IO96B_SUPPORTED			2
+#define MAX_MEM_INTERFACE_SUPPORTED			2
+#define NUM_CMD_RESPONSE_DATA			3
+#define NUM_CMD_PARAM				7
+
+/* supported mailbox command type */
+enum iossm_mailbox_cmd_type  {
+	CMD_NOP,
+	CMD_GET_SYS_INFO,
+	CMD_GET_MEM_INFO,
+	CMD_GET_MEM_CAL_INFO,
+	CMD_TRIG_CONTROLLER_OP,
+	CMD_TRIG_MEM_CAL_OP
+};
+
+/* supported mailbox command opcode */
+enum iossm_mailbox_cmd_opcode  {
+	ECC_ENABLE_SET =3D 0x0101,
+	ECC_INTERRUPT_MASK =3D 0x0105,
+	ECC_WRITEBACK_ENABLE =3D 0x0106,
+	ECC_INJECT_ERROR =3D 0x0109,
+	ECC_SCRUB_MODE_0_START =3D 0x0202,
+	ECC_SCRUB_MODE_1_START =3D 0x0203,
+	BIST_STANDARD_MODE_START =3D 0x0301,
+	BIST_MEM_INIT_START =3D 0x0303,
+	BIST_SET_DATA_PATTERN_UPPER =3D 0x0305,
+	BIST_SET_DATA_PATTERN_LOWER =3D 0x0306,
+	TRIG_MEM_CAL =3D 0x000a
+};
+
+/*
+ * IOSSM mailbox required information
+ *
+ * @num_mem_interface:	Number of memory interfaces instantiated
+ * @ip_type:		IP type implemented on the IO96B
+ * @ip_instance_id:	IP identifier for every IP instance implemented on the=
 IO96B
+ */
+struct io96b_mb_ctrl {
+	u32 num_mem_interface;
+	u32 ip_type[2];
+	u32 ip_id[2];
+};
+
+/* CMD_REQ Register Definition */
+#define CMD_TARGET_IP_TYPE_MASK		GENMASK(31, 29)
+#define CMD_TARGET_IP_INSTANCE_ID_MASK	GENMASK(28, 24)
+#define CMD_TYPE_MASK			GENMASK(23, 16)
+#define CMD_OPCODE_MASK			GENMASK(15, 0)
+
+/*
+ * IOSSM mailbox request
+ * @ip_type:	    IP type for the specified memory interface
+ * @ip_id:	    IP instance ID for the specified memory interface
+ * @usr_cmd_type:   User desire IOSSM mailbox command type
+ * @usr_cmd_opcode: User desire IOSSM mailbox command opcode
+ * @cmd_param_*:    Parameters (if applicable) for the requested IOSSM mai=
lbox command
+ */
+struct io96b_mb_req {
+	u32 ip_type;
+	u32 ip_id;
+	u32 usr_cmd_type;
+	u32 usr_cmd_opcode;
+	u32 cmd_param[NUM_CMD_PARAM];
+};
+
+/*
+ * IOSSM mailbox response outputs
+ *
+ * @cmd_resp_status: Command Interface status
+ * @cmd_resp_data_*: More spaces for command response
+ */
+struct io96b_mb_resp {
+	u32 cmd_resp_status;
+	u32 cmd_resp_data[NUM_CMD_RESPONSE_DATA];
+};
+
+/*
+ * IO96B instance specific information
+ *
+ * @size:		Memory size
+ * @io96b_csr_addr:	IO96B instance CSR address
+ * @cal_status:		IO96B instance calibration status
+ * @mb_ctrl:		IOSSM mailbox required information
+ */
+struct io96b_instance {
+	u16 size;
+	phys_addr_t io96b_csr_addr;
+	bool cal_status;
+	struct io96b_mb_ctrl mb_ctrl;
+};
+
+/*
+ * Overall IO96B instance(s) information
+ *
+ * @num_instance:	Number of instance(s) assigned to HPS
+ * @overall_cal_status: Overall calibration status for all IO96B instance(=
s)
+ * @ddr_type:		DDR memory type
+ * @ecc_status:		ECC enable status (false =3D disabled, true =3D enabled)
+ * @overall_size:	Total DDR memory size
+ * @io96b[]:		IO96B instance specific information
+ * @ckgen_lock:		IO96B GEN PLL lock (false =3D not locked, true =3D locked=
)
+ * @num_port:		Number of IO96B port.
+ * @io96b_pll:		Selected IO96B PLL. Example bit 0: EMIF0 PLL A selected,
+ *			bit 1: EMIF0 PLL B selected, bit 2 - EMIF1 PLL A selected,
+ *			bit 3: EMIF1 PLL B selected
+ */
+struct io96b_info {
+	u8 num_instance;
+	bool overall_cal_status;
+	const char *ddr_type;
+	bool ecc_status;
+	u16 overall_size;
+	struct io96b_instance io96b[MAX_IO96B_SUPPORTED];
+	bool ckgen_lock;
+	u8 num_port;
+	u8 io96b_pll;
+};
+
+int io96b_mb_req(phys_addr_t io96b_csr_addr, struct io96b_mb_req req,
+		 u32 resp_data_len, struct io96b_mb_resp *resp);
+
+/* Supported IOSSM mailbox function */
+void io96b_mb_init(struct io96b_info *io96b_ctrl);
+int io96b_cal_status(phys_addr_t addr);
+void init_mem_cal(struct io96b_info *io96b_ctrl);
+int get_mem_technology(struct io96b_info *io96b_ctrl);
+int get_mem_width_info(struct io96b_info *io96b_ctrl);
+int ecc_enable_status(struct io96b_info *io96b_ctrl);
+int bist_mem_init_start(struct io96b_info *io96b_ctrl);
+bool ecc_interrupt_status(struct io96b_info *io96b_ctrl);
diff --git a/drivers/ddr/altera/sdram_agilex5.c b/drivers/ddr/altera/sdram_=
agilex5.c
new file mode 100644
index 00000000000..f6352869f21
--- /dev/null
+++ b/drivers/ddr/altera/sdram_agilex5.c
@@ -0,0 +1,420 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ *
+ */
+
+#include <stdlib.h>
+#include <div64.h>
+#include <dm.h>
+#include <errno.h>
+#include <fdtdec.h>
+#include <hang.h>
+#include <log.h>
+#include <ram.h>
+#include <reset.h>
+#include <wait_bit.h>
+#include <wdt.h>
+#include <linux/bitfield.h>
+#include <linux/sizes.h>
+#include <asm/arch/firewall.h>
+#include <asm/arch/reset_manager.h>
+#include <asm/arch/system_manager.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include "iossm_mailbox.h"
+#include "sdram_soc64.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* MPFE NOC registers */
+#define F2SDRAM_SIDEBAND_FLAGOUTSET0	0x50
+#define F2SDRAM_SIDEBAND_FLAGOUTSTATUS0	0x58
+#define SIDEBANDMGR_FLAGOUTSET0_REG	SOCFPGA_F2SDRAM_MGR_ADDRESS +\
+					F2SDRAM_SIDEBAND_FLAGOUTSET0
+#define SIDEBANDMGR_FLAGOUTSTATUS0_REG	SOCFPGA_F2SDRAM_MGR_ADDRESS +\
+					F2SDRAM_SIDEBAND_FLAGOUTSTATUS0
+#define BOOT_SCRATCH_COLD3_REG	(socfpga_get_sysmgr_addr() +\
+				 SYSMGR_SOC64_BOOT_SCRATCH_COLD3)
+#define PORT_EMIF_CONFIG_OFFSET 4
+#define EMIF_PLL_MASK	GENMASK(19, 16)
+
+#define IO96B0_DUAL_PORT_MASK		BIT(0)
+#define IO96B0_DUAL_EMIF_MASK		BIT(1)
+
+#define FIREWALL_MPFE_SCR_IO96B0_REG		0x18000d00
+#define FIREWALL_MPFE_SCR_IO96B1_REG		0x18000d04
+#define FIREWALL_MPFE_NOC_CSR_REG		0x18000d08
+
+#define MEMORY_BANK_MAX_COUNT 3
+
+/* Reset type */
+enum reset_type {
+	POR_RESET,
+	WARM_RESET,
+	COLD_RESET,
+	NCONFIG,
+	JTAG_CONFIG,
+	RSU_RECONFIG
+};
+
+phys_addr_t io96b_csr_reg_addr[] =3D {
+	0x18400000, /* IO96B_0 CSR registers address */
+	0x18800000  /* IO96B_1 CSR registers address */
+};
+
+struct dram_bank_info_s {
+	phys_addr_t start;
+	phys_size_t max_size;
+};
+
+struct dram_bank_info_s dram_bank_info[MEMORY_BANK_MAX_COUNT] =3D {
+	{0x80000000, 0x80000000},	/* Memory Bank 0 */
+	{0x880000000, 0x780000000},	/* Memory Bank 1 */
+	{0x8800000000, 0x7800000000}	/* Memory Bank 2 */
+};
+
+static enum reset_type get_reset_type(u32 reg)
+{
+	return FIELD_GET(ALT_SYSMGR_SCRATCH_REG_3_DDR_RESET_TYPE_MASK, reg);
+}
+
+static void update_io96b_assigned_to_hps(bool dual_port_flag, bool dual_em=
if_flag)
+{
+	clrsetbits_le32(BOOT_SCRATCH_COLD3_REG,
+			ALT_SYSMGR_SCRATCH_REG_3_DDR_PORT_EMIF_INFO_MASK,
+			FIELD_PREP(ALT_SYSMGR_SCRATCH_REG_3_DDR_PORT_INFO_MASK, dual_port_flag)=
 |
+			FIELD_PREP(ALT_SYSMGR_SCRATCH_REG_3_DDR_EMIF_INFO_MASK, dual_emif_flag)=
);
+
+	debug("%s: update dual port dual emif info: 0x%x\n", __func__,
+	      readl(BOOT_SCRATCH_COLD3_REG));
+}
+
+static void set_mpfe_config(void)
+{
+	/* Set mpfe_lite_intfcsel */
+	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_MPFE_CONFIG, BIT(2)=
);
+
+	/* Set mpfe_lite_active */
+	setbits_le32(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_MPFE_CONFIG, BIT(8)=
);
+
+	debug("%s: mpfe_config: 0x%x\n", __func__,
+	      readl(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_MPFE_CONFIG));
+}
+
+static bool is_ddr_init_hang(void)
+{
+	u32 reg =3D readl(socfpga_get_sysmgr_addr() +
+			SYSMGR_SOC64_BOOT_SCRATCH_POR0);
+
+	debug("%s: 0x%x\n", __func__, reg);
+
+	if (reg & ALT_SYSMGR_SCRATCH_REG_POR_0_DDR_PROGRESS_MASK)
+		return true;
+
+	return false;
+}
+
+static void ddr_init_inprogress(bool start)
+{
+	if (start)
+		setbits_le32(socfpga_get_sysmgr_addr() +
+				SYSMGR_SOC64_BOOT_SCRATCH_POR0,
+				ALT_SYSMGR_SCRATCH_REG_POR_0_DDR_PROGRESS_MASK);
+	else
+		clrbits_le32(socfpga_get_sysmgr_addr() +
+				SYSMGR_SOC64_BOOT_SCRATCH_POR0,
+				ALT_SYSMGR_SCRATCH_REG_POR_0_DDR_PROGRESS_MASK);
+}
+
+static void populate_ddr_handoff(struct udevice *dev, struct io96b_info *i=
o96b_ctrl)
+{
+	struct altera_sdram_plat *plat =3D dev_get_plat(dev);
+	int i;
+	u32 len =3D SOC64_HANDOFF_SDRAM_LEN;
+	u32 handoff_table[len];
+
+	/* Read handoff for DDR configuration */
+	socfpga_handoff_read((void *)SOC64_HANDOFF_SDRAM, handoff_table, len);
+
+	/* Read handoff - dual port */
+	plat->dualport =3D FIELD_GET(IO96B0_DUAL_PORT_MASK, handoff_table[PORT_EM=
IF_CONFIG_OFFSET]);
+	debug("%s: dualport from handoff: 0x%x\n", __func__, plat->dualport);
+
+	if (plat->dualport)
+		io96b_ctrl->num_port =3D 2;
+	else
+		io96b_ctrl->num_port =3D 1;
+
+	/* Read handoff - dual EMIF */
+	plat->dualemif =3D FIELD_GET(IO96B0_DUAL_EMIF_MASK, handoff_table[PORT_EM=
IF_CONFIG_OFFSET]);
+	debug("%s: dualemif from handoff: 0x%x\n", __func__, plat->dualemif);
+
+	if (plat->dualemif)
+		io96b_ctrl->num_instance =3D 2;
+	else
+		io96b_ctrl->num_instance =3D 1;
+
+	io96b_ctrl->io96b_pll =3D FIELD_GET(EMIF_PLL_MASK,
+					  handoff_table[PORT_EMIF_CONFIG_OFFSET]);
+	debug("%s: io96b enabled pll from handoff: 0x%x\n", __func__, io96b_ctrl-=
>io96b_pll);
+
+	update_io96b_assigned_to_hps(plat->dualport, plat->dualemif);
+
+	/* Assign IO96B CSR base address if it is valid */
+	for (i =3D 0; i < io96b_ctrl->num_instance; i++) {
+		io96b_ctrl->io96b[i].io96b_csr_addr =3D io96b_csr_reg_addr[i];
+		debug("%s: IO96B 0x%llx CSR enabled\n", __func__,
+		      io96b_ctrl->io96b[i].io96b_csr_addr);
+	}
+}
+
+static void config_mpfe_sideband_mgr(struct udevice *dev)
+{
+	struct altera_sdram_plat *plat =3D dev_get_plat(dev);
+
+	/* Dual port setting */
+	if (plat->dualport)
+		setbits_le32(SIDEBANDMGR_FLAGOUTSET0_REG, BIT(4));
+
+	/* Dual EMIF setting */
+	if (plat->dualemif) {
+		set_mpfe_config();
+		setbits_le32(SIDEBANDMGR_FLAGOUTSET0_REG, BIT(5));
+	}
+
+	debug("%s: SIDEBANDMGR_FLAGOUTSTATUS0: 0x%x\n", __func__,
+	      readl(SIDEBANDMGR_FLAGOUTSTATUS0_REG));
+}
+
+static void config_ccu_mgr(struct udevice *dev)
+{
+	int ret =3D 0;
+	struct altera_sdram_plat *plat =3D dev_get_plat(dev);
+
+	if (plat->dualport || plat->dualemif) {
+		debug("%s: config interleaving on ccu reg\n", __func__);
+		ret =3D uclass_get_device_by_name(UCLASS_NOP,
+						"socfpga-ccu-ddr-interleaving-on", &dev);
+	} else {
+		debug("%s: config interleaving off ccu reg\n", __func__);
+		ret =3D uclass_get_device_by_name(UCLASS_NOP,
+						"socfpga-ccu-ddr-interleaving-off", &dev);
+	}
+
+	if (ret) {
+		printf("interleaving on/off ccu settings init failed: %d\n", ret);
+		hang();
+	}
+}
+
+static void config_firewall_mpfe_csr(struct udevice *dev)
+{
+	int ret =3D 0;
+
+	debug("%s: config Firewall setting for MPFE CSR\n", __func__);
+	ret =3D uclass_get_device_by_name(UCLASS_NOP,
+					"socfpga-noc-fw-mpfe-csr", &dev);
+
+	if (ret) {
+		printf("Firewall setting for MPFE CSR init failed: %d\n", ret);
+		hang();
+	}
+}
+
+static bool hps_ocram_dbe_status(void)
+{
+	u32 reg =3D readl(BOOT_SCRATCH_COLD3_REG);
+
+	if (reg & ALT_SYSMGR_SCRATCH_REG_3_OCRAM_DBE_MASK)
+		return true;
+
+	return false;
+}
+
+int sdram_mmr_init_full(struct udevice *dev)
+{
+	int i, ret =3D 0;
+	phys_size_t hw_size;
+	struct altera_sdram_plat *plat =3D dev_get_plat(dev);
+	struct altera_sdram_priv *priv =3D dev_get_priv(dev);
+	struct io96b_info *io96b_ctrl =3D malloc(sizeof(*io96b_ctrl));
+
+	u32 reg =3D readl(BOOT_SCRATCH_COLD3_REG);
+	enum reset_type reset_t =3D get_reset_type(reg);
+	bool full_mem_init =3D false;
+
+	/* DDR initialization progress status tracking */
+	bool is_ddr_hang_be4_rst =3D is_ddr_init_hang();
+
+	debug("DDR: SDRAM init in progress ...\n");
+	ddr_init_inprogress(true);
+
+	gd->bd =3D (struct bd_info *)malloc(sizeof(struct bd_info));
+	memset(gd->bd, '\0', sizeof(struct bd_info));
+
+	debug("DDR: Address MPFE 0x%llx\n", plat->mpfe_base_addr);
+
+	/* Populating DDR handoff data */
+	debug("DDR: Checking SDRAM configuration in progress ...\n");
+	populate_ddr_handoff(dev, io96b_ctrl);
+
+	/* Configuring MPFE sideband manager registers - dual port & dual emif*/
+	config_mpfe_sideband_mgr(dev);
+
+	/* Configuring Interleave/Non-interleave ccu registers */
+	config_ccu_mgr(dev);
+
+	/* Configure if polling is needed for IO96B GEN PLL locked */
+	io96b_ctrl->ckgen_lock =3D true;
+
+	/* Ensure calibration status passing */
+	init_mem_cal(io96b_ctrl);
+
+	printf("DDR: Calibration success\n");
+
+	/* Initiate IOSSM mailbox */
+	io96b_mb_init(io96b_ctrl);
+
+	/* DDR type, DDR size and ECC status) */
+	ret =3D get_mem_technology(io96b_ctrl);
+	if (ret) {
+		printf("DDR: Failed to get DDR type\n");
+
+		goto err;
+	}
+
+	ret =3D get_mem_width_info(io96b_ctrl);
+	if (ret) {
+		printf("DDR: Failed to get DDR size\n");
+
+		goto err;
+	}
+
+	hw_size =3D (phys_size_t)io96b_ctrl->overall_size * SZ_1G / SZ_8;
+
+	/* Get bank configuration from devicetree */
+	ret =3D fdtdec_decode_ram_size(gd->fdt_blob, NULL, 0, NULL,
+				     (phys_size_t *)&gd->ram_size, gd->bd);
+	if (ret) {
+		puts("DDR: Failed to decode memory node\n");
+		ret =3D -ENXIO;
+
+		goto err;
+	}
+
+	if (gd->ram_size > hw_size) {
+		printf("DDR: Warning: DRAM size from device tree (%lld MiB) exceeds\n",
+		       gd->ram_size >> 20);
+		printf(" the actual hardware capacity(%lld MiB). Memory configuration wi=
ll be\n",
+		       hw_size >> 20);
+		printf(" adjusted to match the detected hardware size.\n");
+		gd->ram_size =3D 0;
+	}
+
+	if (gd->ram_size > 0 && gd->ram_size !=3D hw_size) {
+		printf("DDR: Warning: DRAM size from device tree (%lld MiB)\n",
+		       gd->ram_size >> 20);
+		printf(" mismatch with hardware capacity(%lld MiB).\n",
+		       hw_size >> 20);
+	}
+
+	if (gd->ram_size =3D=3D 0 && hw_size > 0) {
+		phys_size_t remaining_size, size_counter =3D 0;
+		u8 config_dram_banks;
+
+		if (CONFIG_NR_DRAM_BANKS > MEMORY_BANK_MAX_COUNT) {
+			printf("DDR: Warning: CONFIG_NR_DRAM_BANKS(%d) is bigger than Max Memor=
y Bank count(%d).\n",
+			       CONFIG_NR_DRAM_BANKS, MEMORY_BANK_MAX_COUNT);
+			printf(" Max Memory Bank count is in use instead of CONFIG_NR_DRAM_BANK=
S.\n");
+			config_dram_banks =3D MEMORY_BANK_MAX_COUNT;
+		} else {
+			config_dram_banks =3D CONFIG_NR_DRAM_BANKS;
+		}
+
+		for (i =3D 0; i < config_dram_banks; i++) {
+			remaining_size =3D hw_size - size_counter;
+			if (remaining_size <=3D dram_bank_info[i].max_size) {
+				gd->bd->bi_dram[i].start =3D dram_bank_info[i].start;
+				gd->bd->bi_dram[i].size =3D remaining_size;
+				debug("Memory bank[%d]  Starting address: 0x%llx  size: 0x%llx\n",
+				      i, gd->bd->bi_dram[i].start, gd->bd->bi_dram[i].size);
+				break;
+			}
+
+			gd->bd->bi_dram[i].start =3D dram_bank_info[i].start;
+			gd->bd->bi_dram[i].size =3D dram_bank_info[i].max_size;
+
+			debug("Memory bank[%d]  Starting address: 0x%llx  size: 0x%llx\n",
+			      i, gd->bd->bi_dram[i].start, gd->bd->bi_dram[i].size);
+			size_counter +=3D gd->bd->bi_dram[i].size;
+		}
+
+		gd->ram_size =3D hw_size;
+	}
+
+	printf("%s: %lld MiB\n", io96b_ctrl->ddr_type, gd->ram_size >> 20);
+
+	ret =3D ecc_enable_status(io96b_ctrl);
+	if (ret) {
+		printf("DDR: Failed to get ECC enabled status\n");
+
+		goto err;
+	}
+
+	/* Is HPS cold or warm reset? If yes, Skip full memory initialization if =
ECC
+	 *  enabled to preserve memory content
+	 */
+	if (io96b_ctrl->ecc_status) {
+		if (ecc_interrupt_status(io96b_ctrl)) {
+			if (CONFIG_IS_ENABLED(WDT)) {
+				struct udevice *wdt;
+
+				printf("DDR: ECC error recover start now\n");
+				ret =3D uclass_first_device_err(UCLASS_WDT, &wdt);
+				if (ret) {
+					printf("DDR: Failed to trigger watchdog reset\n");
+					hang();
+				}
+
+				wdt_expire_now(wdt, 0);
+			}
+			hang();
+		}
+
+		full_mem_init =3D hps_ocram_dbe_status() | is_ddr_hang_be4_rst;
+		if (full_mem_init || !(reset_t =3D=3D WARM_RESET || reset_t =3D=3D COLD_=
RESET)) {
+			ret =3D bist_mem_init_start(io96b_ctrl);
+			if (ret) {
+				printf("DDR: Failed to fully initialize DDR memory\n");
+
+				goto err;
+			}
+		}
+
+		printf("SDRAM-ECC: Initialized success\n");
+	}
+
+	sdram_size_check(gd->bd);
+	printf("DDR: size check success\n");
+
+	sdram_set_firewall(gd->bd);
+
+	/* Firewall setting for MPFE CSR */
+	config_firewall_mpfe_csr(dev);
+
+	printf("DDR: firewall init success\n");
+
+	priv->info.base =3D gd->bd->bi_dram[0].start;
+	priv->info.size =3D gd->ram_size;
+
+	/* Ending DDR driver initialization success tracking */
+	ddr_init_inprogress(false);
+
+	printf("DDR: init success\n");
+
+err:
+	free(io96b_ctrl);
+
+	return ret;
+}
diff --git a/drivers/ddr/altera/sdram_soc64.c b/drivers/ddr/altera/sdram_so=
c64.c
index 10a8e64af3d..7c8eb80ab54 100644
--- a/drivers/ddr/altera/sdram_soc64.c
+++ b/drivers/ddr/altera/sdram_soc64.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016-2022 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  *
  */
=20
@@ -28,6 +29,7 @@
=20
 #define PGTABLE_OFF	0x4000
=20
+#if !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
 u32 hmc_readl(struct altera_sdram_plat *plat, u32 reg)
 {
 	return readl(plat->iomhc + reg);
@@ -99,8 +101,9 @@ int emif_reset(struct altera_sdram_plat *plat)
 	debug("DDR: %s triggered successly\n", __func__);
 	return 0;
 }
+#endif
=20
-#if !IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
+#if !(IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X) || IS_ENABLED(CONFIG_TARGET_SO=
CFPGA_AGILEX5))
 int poll_hmc_clock_status(void)
 {
 	return wait_for_bit_le32((const void *)(socfpga_get_sysmgr_addr() +
@@ -252,7 +255,7 @@ phys_size_t sdram_calculate_size(struct altera_sdram_pl=
at *plat)
 	return size;
 }
=20
-void sdram_set_firewall(struct bd_info *bd)
+static void sdram_set_firewall_non_f2sdram(struct bd_info *bd)
 {
 	u32 i;
 	phys_size_t value;
@@ -288,7 +291,7 @@ void sdram_set_firewall(struct bd_info *bd)
 				      FW_MPU_DDR_SCR_NONMPUREGION0ADDR_BASEEXT +
 				      (i * 4 * sizeof(u32)));
=20
-		/* Setting non-secure MPU limit and limit extexded */
+		/* Setting non-secure MPU limit and limit extended */
 		value =3D bd->bi_dram[i].start + bd->bi_dram[i].size - 1;
=20
 		lower =3D lower_32_bits(value);
@@ -301,7 +304,7 @@ void sdram_set_firewall(struct bd_info *bd)
 				      FW_MPU_DDR_SCR_MPUREGION0ADDR_LIMITEXT +
 				      (i * 4 * sizeof(u32)));
=20
-		/* Setting non-secure Non-MPU limit and limit extexded */
+		/* Setting non-secure Non-MPU limit and limit extended */
 		FW_MPU_DDR_SCR_WRITEL(lower,
 				      FW_MPU_DDR_SCR_NONMPUREGION0ADDR_LIMIT +
 				      (i * 4 * sizeof(u32)));
@@ -314,6 +317,61 @@ void sdram_set_firewall(struct bd_info *bd)
 	}
 }
=20
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+static void sdram_set_firewall_f2sdram(struct bd_info *bd)
+{
+	u32 i, lower, upper;
+	phys_size_t value;
+
+	for (i =3D 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		if (!bd->bi_dram[i].size)
+			continue;
+
+		value =3D bd->bi_dram[i].start;
+
+		/* Keep first 1MB of SDRAM memory region as secure region when
+		 * using ATF flow, where the ATF code is located.
+		 */
+		if (IS_ENABLED(CONFIG_SPL_ATF) && i =3D=3D 0)
+			value +=3D SZ_1M;
+
+		/* Setting base and base extended */
+		lower =3D lower_32_bits(value);
+		upper =3D upper_32_bits(value);
+		FW_F2SDRAM_DDR_SCR_WRITEL(lower,
+					  FW_F2SDRAM_DDR_SCR_REGION0ADDR_BASE +
+					  (i * 4 * sizeof(u32)));
+		FW_F2SDRAM_DDR_SCR_WRITEL(upper & 0xff,
+					  FW_F2SDRAM_DDR_SCR_REGION0ADDR_BASEEXT +
+					  (i * 4 * sizeof(u32)));
+
+		/* Setting limit and limit extended */
+		value =3D bd->bi_dram[i].start + bd->bi_dram[i].size - 1;
+
+		lower =3D lower_32_bits(value);
+		upper =3D upper_32_bits(value);
+
+		FW_F2SDRAM_DDR_SCR_WRITEL(lower,
+					  FW_F2SDRAM_DDR_SCR_REGION0ADDR_LIMIT +
+					  (i * 4 * sizeof(u32)));
+		FW_F2SDRAM_DDR_SCR_WRITEL(upper & 0xff,
+					  FW_F2SDRAM_DDR_SCR_REGION0ADDR_LIMITEXT +
+					  (i * 4 * sizeof(u32)));
+
+		FW_F2SDRAM_DDR_SCR_WRITEL(BIT(i), FW_F2SDRAM_DDR_SCR_EN_SET);
+	}
+}
+#endif
+
+void sdram_set_firewall(struct bd_info *bd)
+{
+	sdram_set_firewall_non_f2sdram(bd);
+
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+	sdram_set_firewall_f2sdram(bd);
+#endif
+}
+
 static int altera_sdram_of_to_plat(struct udevice *dev)
 {
 	struct altera_sdram_plat *plat =3D dev_get_plat(dev);
@@ -322,7 +380,12 @@ static int altera_sdram_of_to_plat(struct udevice *dev=
)
 	/* These regs info are part of DDR handoff in bitstream */
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
 	return 0;
-#endif
+#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+	addr =3D dev_read_addr_index(dev, 0);
+	if (addr =3D=3D FDT_ADDR_T_NONE)
+		return -EINVAL;
+	plat->mpfe_base_addr =3D addr;
+#else
=20
 	addr =3D dev_read_addr_index(dev, 0);
 	if (addr =3D=3D FDT_ADDR_T_NONE)
@@ -338,7 +401,7 @@ static int altera_sdram_of_to_plat(struct udevice *dev)
 	if (addr =3D=3D FDT_ADDR_T_NONE)
 		return -EINVAL;
 	plat->hmc =3D (void __iomem *)addr;
-
+#endif
 	return 0;
 }
=20
@@ -385,6 +448,7 @@ static const struct udevice_id altera_sdram_ids[] =3D {
 	{ .compatible =3D "altr,sdr-ctl-s10" },
 	{ .compatible =3D "intel,sdr-ctl-agilex" },
 	{ .compatible =3D "intel,sdr-ctl-n5x" },
+	{ .compatible =3D "intel,sdr-ctl-agilex5" },
 	{ /* sentinel */ }
 };
=20
diff --git a/drivers/ddr/altera/sdram_soc64.h b/drivers/ddr/altera/sdram_so=
c64.h
index 87a70a861ba..183b1a33080 100644
--- a/drivers/ddr/altera/sdram_soc64.h
+++ b/drivers/ddr/altera/sdram_soc64.h
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2017-2019 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ *
  */
=20
 #ifndef	_SDRAM_SOC64_H_
@@ -13,11 +15,19 @@ struct altera_sdram_priv {
 	struct reset_ctl_bulk resets;
 };
=20
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+struct altera_sdram_plat {
+	fdt_addr_t mpfe_base_addr;
+	bool dualport;
+	bool dualemif;
+};
+#else
 struct altera_sdram_plat {
 	void __iomem *hmc;
 	void __iomem *ddr_sch;
 	void __iomem *iomhc;
 };
+#endif
=20
 /* ECC HMC registers */
 #define DDRIOCTRL			0x8
--=20
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
