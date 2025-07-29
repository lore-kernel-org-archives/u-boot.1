Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2ECC87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F5DC8320C;
	Wed, 30 Jul 2025 07:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="PVMF7Byp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4043883045; Tue, 29 Jul 2025 18:22:47 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21ACB82BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNAKvKdtArcZ6669A52QCAJiWMydmgvTzOZDGJYdENBwDWfhiNU/fWv7acO5GrWTqfqHHJLaDN4jaltEXWA/FtmHlb8KEzeXINs14dO4OCNJqiHXoPH1xKXVGF7xsGdecT/bC9TR/bxBkzcxKrU8kRBnrinD5EOq7bzHIh/LkXWpWfXNYzdUBortmCQ7TrpvsTFzVwHApkCbVgDBpq0o1WqWSx/6a852TnQPfl01UJ/IIKfXG9n+6TiWXmoIWO3j4ZjTj+5BE7xEYseZBXgG84SRnL5KPamw1RvnSEuA1QY/5jj7tbsbF8ViFIHStbGTr+U73zxUncBzK46l3Z8fSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftO9I6cW+XoWlPhxUfIMT2e31Hp6N/rhVCBWDcVejxs=;
 b=a5MS8X6ZGs6lRXCfVuStbPGL7jvTS6k6d7urpow4FqXjJfUb467ynE9c19BD/Bb8wi35LrM7nXVxrn8eTyQ3Hoc5NTBVXvf3Ynac/rFCB3OcAplP4hntIHpjQu6O900MgCokyjlNnjTVeG4UyfRPWS8TpqfezFiqoYiEXXbseXTRoaakX9NSddRPuUO8P7bQJi/HkvQenZ53lO+0+E6npzBVaPCy0CC9C3nfFtnk2wBn6gfVcZ1HIrlnakSFLaV8iqHBfhOOrYs8IsIWUnK89Zkgm5EsRFsyLK4QG/rlXxQ3shtIr9Y3O/jWlgOhUN+xkZPmbZlr4yAQ6V0FS6gh0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftO9I6cW+XoWlPhxUfIMT2e31Hp6N/rhVCBWDcVejxs=;
 b=PVMF7BypU80mDdN4gdR65t8WSFfWEnLkgxzlryogunl2h1RrvDbB5IiAkAPNYVFa2E6doN/n6qcA+P98d+aHACA9AwMW8jBV4M535Hkwrtj4Q5b/B5jCdyt7xL0waoFmUjuTJwOXhbbZKrEVEshrdev5clSkomN/2jMvUww4K6pi0Ysq0AURakEWAblXVLioh2Rcaa3B+Au7R3cK3LS6QlhdVQRL7h8kYIAL/cQwuVlz7E34UTC+rXbL76me93Z8ELD44qxmfEBiTENAnIQ9tUGC7OJVQXKrFsNJnzIc5RUnlSpeatb0b37VPXcYTB1K5F/di7BU6Ivi/8x6Mq1tYg==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by AM7PR09MB4021.eurprd09.prod.outlook.com (2603:10a6:20b:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 16:22:43 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 16:22:43 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v3 03/12] gpio: Add GPIO driver for Intel EG20T
Thread-Topic: [PATCH v3 03/12] gpio: Add GPIO driver for Intel EG20T
Thread-Index: AQHcAKUD28fSHCQkeESapUXseb4Olg==
Date: Tue, 29 Jul 2025 16:22:43 +0000
Message-ID: <20250729162035.209849-4-uros.stajic@htecgroup.com>
References: <20250729162035.209849-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250729162035.209849-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|AM7PR09MB4021:EE_
x-ms-office365-filtering-correlation-id: 6f9db976-eaa0-465e-653b-08ddcebc2594
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?afeNpxQKji06437d75u9nRpd/27F81XQX4OjqGkecoWIRFbEqfRS3b2tZi?=
 =?iso-8859-1?Q?IOYJmfZ+KFFsCknaExTjuRAtU0zF0iHrhALwOUdaXZ4t4gjKxFGTDm4WuR?=
 =?iso-8859-1?Q?2ltGblaNJFy7tsg9UZeXNRr4/J3JYzSD4b/XJP8AJMZz/X/aRGGb8BVM5+?=
 =?iso-8859-1?Q?EiLh+EmjTS86wP778ZRlQ896C8a07T6iiaUFv386rw7czO8612c1L09uDN?=
 =?iso-8859-1?Q?SpJGsfvF24iXenbpbX5RflUp6khfEP9alxy/nq8ZGBMWOuXXPPfVGbzuG5?=
 =?iso-8859-1?Q?c8fuRbnwadfieGeTAgX0Qj5J1siUQdCQzc81K/9K1DqgSE9dV8xhAbX9Zo?=
 =?iso-8859-1?Q?HB0xdj2iX6Gg8sHChSy44Mz8Trs1015DSN6VIGSYhtp91q5AXBsq8NFhAu?=
 =?iso-8859-1?Q?xmb+Ge5BKddY/Qy4TILif67286HceNAeescaL0EnCa9t2XsEyqlJEQ1yR3?=
 =?iso-8859-1?Q?mYvPpv3yYDTOBfc9ELIekBO0wKl48Ak8tBcWsnOZaopixw+hik3CNKZaK3?=
 =?iso-8859-1?Q?PWwWi5MufHpAcuXAJtkxNbZt+mXbnXpIn/leIwsfoPbEIyH/oNjHj3b+OD?=
 =?iso-8859-1?Q?CpvbdhaIz2j3YeK6PmZbIThEPaGXHibJ8vbaMJOg7ijhV69Ruuiy+Yxunk?=
 =?iso-8859-1?Q?biCIfPKjoufsMsD51yjvs9gA9EqnjvoD0u4ofh1oNvnTVe+Ov/ADG4HOdt?=
 =?iso-8859-1?Q?n8iTjeBFJjXJvTkpv61NaBIj1bqSMcXTpBcFr0LYZpUPJ0HqMMQypGqwlg?=
 =?iso-8859-1?Q?GhUQi7/P63P6OaE4tHmeA9wiJjeysp3PYfevDIYd6iD6MiYHVeWYQmSr4W?=
 =?iso-8859-1?Q?kdBFjcO6zvYsxmNRmlEAJcZh/OXJMiNiQ7mR9cZuUPeDCiYetB3oxrFlFs?=
 =?iso-8859-1?Q?WLrw49afzHsZLgLKJwc0bPZs1h2gn0eDBBDaz7uMGdPMw3DBTSOEeC2Zl3?=
 =?iso-8859-1?Q?lNeaNH8TfLNgPnUy8C+/xeGSUBrl2MyQ4uRoY2gLaMa5rWo6smsgSLgvHp?=
 =?iso-8859-1?Q?nkH1ltd4+RxbkiXXGf1jqHvv880CoPzf8UcYV0tAq3jcSKNgZ4q+Xgi47F?=
 =?iso-8859-1?Q?O3UEL/7sGoEKbckZZBo1SD2VpvitOfLWFmT+qlnkZ/8wFV9EcC1BQUS+t6?=
 =?iso-8859-1?Q?eP2i9s3DPYN9LxdRDccBbJrKLrGFaj9yxzOlaszSBl33EAEA7ng5mjJPGN?=
 =?iso-8859-1?Q?zZkRYdWODr4PQm5Ou3mzaf6rq492IRjOhjmAxw3ZiWvPE7viIhqdPG+Unp?=
 =?iso-8859-1?Q?uBTnvAwFO1t4soLIYU5f5wTCotXvoWz5Kw+tqVX5PwvAnDIc7WBmCaPftx?=
 =?iso-8859-1?Q?3CQEU4hUpzx980Nv/pgb2oybNrrO/MGpjjR48a7h1dN5gsqUVdYHxbUO8O?=
 =?iso-8859-1?Q?Sx8RYq9EzI/iw2YojgOGLo0K9AGLzJWswrT62dlC0noYGdMWPEYlPY7Xjk?=
 =?iso-8859-1?Q?gQUOmNF7HK2tWama+2uQW4QjUa0txlHSwbCsbK6Xm2JZi3CaFyeo02svX4?=
 =?iso-8859-1?Q?KQWxXuG5IsseXjO6uGtInG+0honcmwDuqf0DCp2SBefCIu/FyPoyJOPlo1?=
 =?iso-8859-1?Q?NYLqdOs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JAa9wkSQ3+1hr0GAsksNVC8cPDgnJo/x1oK4C3kxWSvTNY37gJCeTtRjq3?=
 =?iso-8859-1?Q?1Kss4KAYSluNtIlv4I+k1CHn8ao3JslVHe+SYjxUyR4ZFSU3T9gbdh/5ZI?=
 =?iso-8859-1?Q?gp3wc1DlWHoud06mDoEjklSafE3nmr0JIJMXHEfPSFAIpE9jeq3euTKDU2?=
 =?iso-8859-1?Q?E9b4BUiKhMtTskjf6BnusleNoe7SZbBq7AXTG6Ybxj+0wSLZUALHoQiuCy?=
 =?iso-8859-1?Q?D9jQhi1EHd5QNPmr6Ot90vIo72G3cki1o+Q3af0CU30xaJIU6kzM2Ufrmz?=
 =?iso-8859-1?Q?aEGTKLsZkIDYXuwwDO1plZh7y9MbbfUxAULGLA/DU+Tl9aZiXS8AR6Q/N/?=
 =?iso-8859-1?Q?jGYvLHTg3Lcm+U9Gl/NwLJTpQrw6aFw9G/ozz/6S0rCTv1guNp9n+0ozz6?=
 =?iso-8859-1?Q?aK+RbpzVnFzQJePgTYymLUhltv8PkaGd3czLwyEmFxnLgVv7EThk3w3HHh?=
 =?iso-8859-1?Q?GWn9QdstKKG8Hgx0Ma/sTmxJvW+8RPeEWjsBa6bCCyScU8J048nbSeyjUq?=
 =?iso-8859-1?Q?HchS40dxoKey0yGYqZqWpR+7uJk44oMJyKxwh0+nEfBcprIJeC19nlt2Mr?=
 =?iso-8859-1?Q?AGD+tTi6U6ZnGo0PWoFaUXn35CE+yZNi6TLztPmSHXgVTJDeI79TDzwrZf?=
 =?iso-8859-1?Q?b6XuzLr8OC8MNvaSvbNyglyP8XSJA+FSaqNmfO+PjoHscP7D36G8SJXb3z?=
 =?iso-8859-1?Q?h5ZW0QoDi+elN7TkyVnyU/b+p674QkCIvh5D4ntAT+QJlFx0HUzBfUQW9L?=
 =?iso-8859-1?Q?SiqNOVhdFWRaD370GgF+xARK0QYEMUuArWLmXQlF869GIkbCdfufju4vpV?=
 =?iso-8859-1?Q?frUbULuxgU9LBrAgL6TSDdC9eGtXWbA48B5xs6yDGCS3jpWGomqe1HFFtO?=
 =?iso-8859-1?Q?j1GBeW2Ab2xQ6k0kWoV7Zks+AR4Ve0SJanGZFnEaHH7znVWwniNnpRybby?=
 =?iso-8859-1?Q?lCE+07jTKsdGY2rRyle627PYvDImRpD3L/ZKkEa2rvSgjMFn2fxLYzT3le?=
 =?iso-8859-1?Q?BpaUREchHbS4/QdB6lnWIXseJ4v8iS/ijujDH5mZ1NVHM35U+8tAEjjI9A?=
 =?iso-8859-1?Q?bgqMHARwnuTDM4bdU0YTzwyUGMf9jYOWixz9PYiNc321ofS+QCOpTeyDAZ?=
 =?iso-8859-1?Q?RSIwEliU/rGLrFdx8e1EQUHI0yXa44elXlBHlZfNe1vY5XNlBUyQ5ajc2f?=
 =?iso-8859-1?Q?ng9bulVpMCNM7X8M7mkQAvkxqFIvmo1BOpPSeGRt31vnN4KW/OJ2gaVag/?=
 =?iso-8859-1?Q?qdB80kN40o7xTqi9Pcj37y5qUtfxi01Wn6Akgk6vJ5pvoXardSHs1SDSxJ?=
 =?iso-8859-1?Q?tRE3sQDynJFi0s8GnRDgoFSd8LQ4R6SLnxbjfpCxcX0K5EUiwnyzuY7IUg?=
 =?iso-8859-1?Q?OaO+cfQSd8IdjyjRFgSkysfO/JMJkrO3ChHJ2N68ZmwEMFLNnTxnyvIyB9?=
 =?iso-8859-1?Q?8qFpLn3NhQNBTA2aJ96xkeJciQvkBfa3T+ADBb8Z32Zw+D/IAlZYHXRvg+?=
 =?iso-8859-1?Q?KkgStoUU9SzaZ0tU59S9cmM+m7CDkiLoBf0cRzaeQb8njvAPhK5/vzLwPO?=
 =?iso-8859-1?Q?LWnxiuzkfVgOefVdLSAwXnnY9zjbggCkbTk1b+ws6CQWVQhuWmqon1tfvS?=
 =?iso-8859-1?Q?owQ3344x211nRLmc/4HcERWQgFSqYNwQDOScMjnvBeV3T+ffmHSQe5fQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9db976-eaa0-465e-653b-08ddcebc2594
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 16:22:43.6086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tTZbI7tZs61OQ9cJZU/LrZzuAjkVD6/gFW4ofr1Ens+K+RMWhazgzQ/8YfN0n5wjcQLhzgzdriugR/IU6z1XSITPqAa+YRJviOaFeEh54EQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB4021
X-Mailman-Approved-At: Wed, 30 Jul 2025 07:10:08 +0200
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
 drivers/gpio/eg20t-gpio.c           | 138 ++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+)
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
index 58e464106a3..26040947a69 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -726,3 +726,10 @@ config MPFS_GPIO
 		Enable to support the GPIO driver on Polarfire SoC
=20
 endif
+
+config EG20T_GPIO
+        bool "Intel EG20T GPIO driver"
+        depends on DM_GPIO && DM_PCI
+        help
+          Enable this to support the GPIO controller found in the Intel EG=
20T
+          Platform Controller Hub.
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 83e10c79b91..e44122cb9aa 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -81,3 +81,4 @@ obj-$(CONFIG_FTGPIO010)		+=3D ftgpio010.o
 obj-$(CONFIG_$(PHASE_)ADP5585_GPIO)	+=3D adp5585_gpio.o
 obj-$(CONFIG_RZG2L_GPIO)	+=3D rzg2l-gpio.o
 obj-$(CONFIG_MPFS_GPIO)	+=3D mpfs_gpio.o
+obj-$(CONFIG_EG20T_GPIO)	+=3D eg20t-gpio.o
diff --git a/drivers/gpio/eg20t-gpio.c b/drivers/gpio/eg20t-gpio.c
new file mode 100644
index 00000000000..d41ca4bfb17
--- /dev/null
+++ b/drivers/gpio/eg20t-gpio.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <pci.h>
+#include <asm/io.h>
+#include <asm/gpio.h>
+#include <log.h>
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
+
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
+	struct gpio_dev_priv *uc_priv =3D dev->uclass_priv;
+
+	priv->base =3D dm_pci_map_bar(dev, PCI_BASE_ADDRESS_1, PCI_REGION_MEM);
+	if (!priv->base) {
+		debug("failed to map GPIO registers\n");
+		return -EINVAL;
+	}
+
+	uc_priv->gpio_count =3D 12;
+	uc_priv->bank_name =3D "eg20t";
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
+	.priv_auto_alloc_size =3D sizeof(struct eg20t_gpio_priv),
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
