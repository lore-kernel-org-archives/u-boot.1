Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB67CA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 12:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 876B882F5E;
	Tue, 19 Aug 2025 14:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="fDclzqXs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5009D81FEE; Tue, 19 Aug 2025 12:32:21 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F2FA802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eW7LYeaqyY+GFNXkkqD2Er9A9puel/x9U07gICVMQfdFyu/7slFERYIoWcjHS52r2bg7l4cmxSypmUO45zd2NMB292KktSLz3TBpR0F2Cz3NjGNu/0SQMwxQgWEH3YuQO/JvLiIq3C1KS+amU6THtP627aALosdH8g6P0hGgKKSQJ4UntlBVsWbSxuOWj9DVT7Z+HP59y3QmPr3VbtBlNUW7Gz+GAPlgoDaTiy7oZKYyQxBPiDulhb1sXqaJKHb26kbVbY6v3xOGQKzLyo6XmbTgQBSz9zJJk6IWXGUhHVfgv/M37PAICIETgYRGPRshrvmG4vF+Qpf++W7WjDjt4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoSBVvEB+xBQ4CbhKTkX0uu3HGxAIao2nA1+rsVp+5E=;
 b=N8vQhqKSmTjJ0dXyQ+eER47Nc2Ny60hED2WxZ9Tecvf0ddjzl8hmAxx4Zu9Aj0raQhLzfmm5ahMF4iREWcF1si+SmcI1konqR6vwxtrK+JggsCKjrQpJULjYeiB7bUXTZkIVG3r4gyD2m778HgG9cXICI+rs8l1E6Pa1Bev05j39Sf6E8NrbMWNBoOILb3qBGEFbmcRWGXc86Xx11sqpB+NIZxKTTfRYoKrrxS0gbmbDYdZwA3eGa9++cNXm2KNnnVBbpgc+0j4+qDwiAh3x6Aw5HDLb/ntJ7Mk/q//wsvSQYAa1N1YUWFpIUR1ls2EjkVklNmvzkHzkqksxXWLvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoSBVvEB+xBQ4CbhKTkX0uu3HGxAIao2nA1+rsVp+5E=;
 b=fDclzqXsFEUYDNQabNiPSvDwq7C2zmbnnN+5QhTvBSC0NlgYfIrl9XDXF2CXl8uAemqRB4cHsr3Noi3rejaGPfesh7q/KqW5SD07ykOTtk9gHSt4yLlV7PIme08PqDHYij+gbx8jg04aktkxTlXLO/alFh1bXJp0D4Jsek36nVufkG/H+Q8GiVcsLzTZcpnylsTxVJHSEHwRg55VC2c9focakm/d53ddJVMqyLCfeoKwd1CcdgevH0SqZ69zvgrvs5k6G4j8DczIQ/SPvJlbtPIv5deMdKAKUAiaowldLLx4BmonDoG56RFIhYjMA3e371rgKJuVPOpEELNyI03Fsg==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by VI0PR09MB7338.eurprd09.prod.outlook.com (2603:10a6:800:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 10:32:17 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%6]) with mapi id 15.20.9031.019; Tue, 19 Aug 2025
 10:32:17 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v4 03/10] gpio: Add GPIO driver for Intel EG20T
Thread-Topic: [PATCH v4 03/10] gpio: Add GPIO driver for Intel EG20T
Thread-Index: AQHcEPSJ7CfMxMLnb0Oa97ZKLKQChg==
Date: Tue, 19 Aug 2025 10:32:17 +0000
Message-ID: <20250819103021.1518687-4-uros.stajic@htecgroup.com>
References: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|VI0PR09MB7338:EE_
x-ms-office365-filtering-correlation-id: 0b597186-1c14-4dab-d201-08dddf0babcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?hhpRnmWtRjuGRVWxqEOWzHYirmClhTu0RzCTCGFU0t3cWusobWBhyrt/g+?=
 =?iso-8859-1?Q?lvCQISyoOrq3XnoM/k5tdECyrPSZQo8NrZqHBk9aRly/nv9UHGrdgTlcvM?=
 =?iso-8859-1?Q?epwCARyIcjzMWRCNhW6SUSMzyGBP3LVRTQWCdfQYsxzYKNNEGVD9gTQ3HY?=
 =?iso-8859-1?Q?lqinTGWZMYtPQLwkvlflnrjl9EMeuOYjymp2jRZhIcnwYFCiE4U4B19ZNc?=
 =?iso-8859-1?Q?nmMdpsrlHPs/Xos+IEnx16ArL33Ee2Bm5l7P3e9I1tPjG6C4vKjI4X7lxH?=
 =?iso-8859-1?Q?2EE8VVR8aUNatVCptqExX06hgCWjpbEJAcwu2f+zd5W7dpnrFCFXc42QVx?=
 =?iso-8859-1?Q?lxBErfoAFnaDQzcval6TUtbLHsrLdnFyiCpCCDqxSmQcUOS8DGUB5v2k3a?=
 =?iso-8859-1?Q?8bgE7YBqcl4yx8NHOppyuTZ80pEqsYLRAtJgd5vOOyAZWPesWgVza83tF/?=
 =?iso-8859-1?Q?DYt8hK1GW7BcUp25MqvLRIl0y/1mn2VuEVQNQMcny92VkJ2suzSRdnQEUP?=
 =?iso-8859-1?Q?aXoh7sCIw76ZdEYhOk2cxGAlVIfKJtKMWac3KAT2XMX/CJcuGpAoowrvN6?=
 =?iso-8859-1?Q?8r7GREA9c2jFJGNDY7qowQ3wpRh6JanO78roOHs3CIk9BCj9jGwAWTpnJm?=
 =?iso-8859-1?Q?5ay7eUs36MdmjwMnVIoEODdNDRx8dlJ1lGqDjgtgXBj47YJ7C7ytjo7hYC?=
 =?iso-8859-1?Q?fLWRbRYuOGVs4nyIihcitXN/STaPFo5s9UGKqFO++FgmBWRPOgttAiPor1?=
 =?iso-8859-1?Q?S3o5fU3hQux4y7uzf3JVFWMzgtVsP33jhUqWu3pPdAyeiOJF1i/yykE3fN?=
 =?iso-8859-1?Q?F5+r8NKZEGj9ZaR6REuWylQCYOFk+69IgRRlpxPNvocg9tQAAvzXuBNSpx?=
 =?iso-8859-1?Q?URqjZwaOCtAaVkKDhz3EWU7D4v+JTReWmhje/jUksiZM8q2rhqQmz6TGin?=
 =?iso-8859-1?Q?atz1RZJirL2VBODMu6uNFtoROQvtVVAXz/bY0KOY8HE8rcfBUJRFPIr3+V?=
 =?iso-8859-1?Q?3uA2lVOSZvc2QBH3WN2dFikP5XsUkWwyp4or7Apo58y6s3aZSeIaPYi25C?=
 =?iso-8859-1?Q?tGKdAug5M1FmL7bKaKoWHqYjpbZ6WwOC9pxNQ5hd7GVYo6d0qSZBeQ7zuP?=
 =?iso-8859-1?Q?FDYofZeuiLaf/GEtXwk5rv0P8JaE+BVwT9jNvE/IaoAjCZLmk33ripNVr3?=
 =?iso-8859-1?Q?rKVW8eYT1wxgyBYh7p+OMUpDgMZgSjyxy+gwHcVntPpyhsOI7Sqtl3Tzg+?=
 =?iso-8859-1?Q?Rac8d0zJIGjEQOypuMOm2tpbb16VdsI2ksTWjzKaAde5uAfUyASDocTzn7?=
 =?iso-8859-1?Q?PGwn+UsTtMpPTkvikxdRs3FSAMF2pIYoFGi80ZTbDd9ghMvlpT6YXEkf/e?=
 =?iso-8859-1?Q?BcTtJF33I50nu8sCB3wU1/nVYMmJrJELCS1i1Vrv24ZmjaDn3Q2IY/nOag?=
 =?iso-8859-1?Q?lBAqr0aqiip6kageF2w6M1MN1UrGKNEJDhxqEm6fKI/4Wsbk/EGOiCRMjC?=
 =?iso-8859-1?Q?rwEuYCLFcPLprB//Ck9hVdLlGcrg7uHQJcYrB63MTnLYdS4TZOUnFzmDoe?=
 =?iso-8859-1?Q?IfvgAow=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qYknXYwAVdySL7RPPqYn3hpKw1U1jnUibpsHPDxPZECp9PbgojXAXNkiAe?=
 =?iso-8859-1?Q?3yqP1DbW74Qk1XTtZUORPXw/LEZOe5MMqZMWiIzU3Z2qL8bvFL/k7PYEy7?=
 =?iso-8859-1?Q?8dLq/AUWYmo06jRNjOjLeYn47kNNlxbwMbFhCymD2E3hLP+zjZdzkELXhj?=
 =?iso-8859-1?Q?QcXZBzGX3247sXMdu2tbmKnsiDIo8eyzZtIz9aT5g7DI2GPAvsX/XkQsuR?=
 =?iso-8859-1?Q?j9MxoGElrsn/s7RhJyw9UrqIDYdWss08XJtZH3fAYHw6AYDJ8/A7L+RjMg?=
 =?iso-8859-1?Q?mIosCKvpE/pExgpLR6vzof9XHVx3TdIQ/Zr82J99jT+zCboFAY6Lu7LF85?=
 =?iso-8859-1?Q?tXVd2orUCxj/2bPscN32ZHOWk5pl5qVjpxsOSD7cppKim0tQFMgEB3/RA+?=
 =?iso-8859-1?Q?ongheRwA1sdfSRZMY77D2GU6s3UceyNchvFjy8TOCNCVGWioHq1+UHNh/u?=
 =?iso-8859-1?Q?ctYzz/q8j6v38QxyrsEXSmt4/ZV6TLh4eR7Pywv4oGvOMr338gu2+tpuNK?=
 =?iso-8859-1?Q?6Cnd6tCp/J0GFcFdI/kuoE7This05fGN/TEBeziZqHIu1YHL13zI+UXJhw?=
 =?iso-8859-1?Q?btB4rAAYoCX+koDaCF2GRs6LLeJvStDrLnBP79Hb3jTRpDZnA4/U53UUhN?=
 =?iso-8859-1?Q?6s7yVHopStXIujIqxHVPEHqpLDfXIXlPnOEHT1ROk6/eiCb3PPFjjZloaT?=
 =?iso-8859-1?Q?ajM7s8ENJuvxA/u2CP5vR1GjnBwu7E4K66G2dURTdz6PQvCRP1LM3aDLAX?=
 =?iso-8859-1?Q?/MJaYflZk56BXK9PCzsEc548313ctdLtNv4+0Z2KGl7473G/vFURNyfXx4?=
 =?iso-8859-1?Q?4ZCPXEJJkLSQqfBqsyJzq0dCTUnEunO4iwy+1+bOm4gdr/IqHBiRQ81WG5?=
 =?iso-8859-1?Q?ZtX8OQtb4zWh+4dWBANAQo3sN3Z5zLBt+zRWWgTun/v7T2XPprCOTROGJz?=
 =?iso-8859-1?Q?yggRiNZC6ZJrN0mYEdf6pJtLZQQFAlwwFek8CqVCPtUkDOP5pdCb5AP7UB?=
 =?iso-8859-1?Q?G3QpJMzBl9VXf0Pn5MoYRP6vYQit4kJVN+7EXHizixybshp6ydTQReIElP?=
 =?iso-8859-1?Q?ZczkaiBWfcUCwaBAeeghxEzDozKwnyBnB1Wh8Dulswjhr09AuQQVXJBeUi?=
 =?iso-8859-1?Q?ImDVTYEBLr/Q0WAX0foL4wdKSDdyuselxDM/IgXB9gC+NUhh9niLyQztuE?=
 =?iso-8859-1?Q?6lPSOYRKcg8G7hdH0L+3owJ2lugmXkrDfthFNl/fv6tDntQSWvqRnWeLG3?=
 =?iso-8859-1?Q?waB4d8wCRs283hggb1Qa1yjttV8XCguLA5hWtcGv6g5rOFZGAfCpzlKchT?=
 =?iso-8859-1?Q?ngpsxDrL274wB0N/lU2hBDji+4KpEjO+xUGVEjU8iskPrha2/1nragOAPM?=
 =?iso-8859-1?Q?cNxL58auHgEHwCM6EkFTokNMeitQXYW8fHyVqh9IXlFW10Cm9/uyZwzmZu?=
 =?iso-8859-1?Q?/0RNbQUUc0WKbxe9IboMUJ0l2wK6iF88aMFSg/8q2zwrCL6mzh++hoSUNt?=
 =?iso-8859-1?Q?kU0PrnIlP11R6WoMNmLrhTZlY5qrXixGWtlN06ny6B1+q/Ezr7hS6v2eDp?=
 =?iso-8859-1?Q?yKV0hxveZ0J6p775rv+IzudROtVr+4z3JYKNx2WLaQuvlqrc1LTUKXzg79?=
 =?iso-8859-1?Q?Hqtik4yUtR55VBOPhYyzU1ujJPn9UqZTSOxeCh5hwDlukW+RmpvnTLdw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b597186-1c14-4dab-d201-08dddf0babcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 10:32:17.6067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xHTsnZxfAyhwHLtHDXKX58RHLM5MhFPiW7/yFrAYixpHoLIQMmdKypJ0uBEaynPTzUdLc673gD/HBJFlDKo2w8L+nerdbYPCBjWRFQwwY4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7338
X-Mailman-Approved-At: Tue, 19 Aug 2025 14:58:37 +0200
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
 drivers/gpio/eg20t-gpio.c           | 140 ++++++++++++++++++++++++++++
 4 files changed, 149 insertions(+)
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
index 00000000000..136ca7e91c0
--- /dev/null
+++ b/drivers/gpio/eg20t-gpio.c
@@ -0,0 +1,140 @@
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
