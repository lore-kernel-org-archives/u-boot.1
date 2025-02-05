Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A71C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:19:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B67380C66;
	Wed,  5 Feb 2025 14:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="MtVPsCGG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A779C80207; Wed,  5 Feb 2025 11:15:57 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9F47807C0
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jseegpTxyyov3wc1fJVq9NsRUcEUDW/t8cWCoVjb2KhRkRP3Qw1hgFXM/iQq0/UwQyCGMDbD+873fgDWajOiul9zst8bj55SNoDz0gIDU+kdM2IlW9VkcbjTHha92xIQsf8IG2EnscGhg2SeS1J0OaVJpdUHs2g+HjpJ6xnS1zgm9JEdjZgi9UqEA/RSpv2244G2K8hCzLqqLUrDAD2KgO0TvInXJyq4QVCO8nwb3HYb8B1/NFD43Y+KaSBpUckmExhbvQU4cHvWgWljiihEpFr4Mcl08TwzvX6SFCJTEhEMJEYRHmKCfV4OwOxMaa+M+0qHU+5y4bp/gG4ysFxihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3m/Dt4fWZTCQFUi32munI/HvB3anx5TMKWkIbKhbtD0=;
 b=YdPkELaKSjKxnrhGpdkKXhbcxi/+xOCEg3Tw+kM+vNG9cVFFTYYbDSh/CXYRSubA0aMqNdJuywMFrVgevyWYQ7taiJzIKCUhx9p6TjgVOCjJjATUraX/xBT51FrjnFWt7kSSJkkQDVAxWt7TRhNLUo5rYiP1Vk+1GWoDnCKxeKq/qN7Xm3aW6XlZ7mYZpWIiabhCx7mHDLQtEPecoeTJwzxa+WCMzjNmc0EADPPSaVzVGbMeRsujSM+G9fr6pMNQcTHRQgx18sHWAcq3drQDh2Xv18KoY0QYDdL5nQhGWlWjgut+7itD0qQiEbf95o8Jcn2CBageODGRIOVGmkabeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3m/Dt4fWZTCQFUi32munI/HvB3anx5TMKWkIbKhbtD0=;
 b=MtVPsCGGjS7cQhPNNI+d7SCxvT3K8gzmxzjwfoHHmDwli2s9vs+czbMpXfktmhpLlJfl7Au9zdReN2mNErJurlvYn1dv65K5wab+0AbP5/2WwZnYzLvdhsbd8RW+I+CjPm9KXgeFui/ORoRd6KWNBxvOeM6S0DcAmXMcG6/QoHmwkGLSjEDQ4sX0sGTB8kUBlDeSQwIpR2nukSFbXe/bsyiZ/SElxsy0k5QuFSL/dEyNIlEsawmLfk6TT/SxnI+V8FAf0H0fMXG15kTYfeIHAhouyYcxOIBSaaOKPybNEP7AtJwbec3Fqh1Vw8lbbcP/PmfNbG+7WRpgXSVKJXadMw==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DU0PR03MB9635.eurprd03.prod.outlook.com (2603:10a6:10:42d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:47 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:47 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Tom Rini
 <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: [RFC PATCH v1 09/20] drivers: pci: add BCM2712 support for
 pcie_brcmstb driver
Thread-Topic: [RFC PATCH v1 09/20] drivers: pci: add BCM2712 support for
 pcie_brcmstb driver
Thread-Index: AQHbd7bq9Abt8OHVQ0K0EQFowwU3Ig==
Date: Wed, 5 Feb 2025 10:15:44 +0000
Message-ID: <0a21f1bab4d05b115a86aca5bd07b820aacf308b.1738749764.git.oleksii_moisieiev@epam.com>
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
x-ms-office365-filtering-correlation-id: 4bdbdfcc-d45d-46a2-a24f-08dd45ce0ed3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?f6hrUUEbb/FQCTcWdIEYKOpNe5ZDul0G81xfRP9ZEmJlZce5PD4DfHd0lH?=
 =?iso-8859-1?Q?8igBBIlasrvHNLqK1W+I28i4QhHdQPUgoEM9//lORohNkPmnXp6ABbCL73?=
 =?iso-8859-1?Q?U1ubuzv4FCVDHMt9Qj8jS8rkvTVPKeR9mvHQN7Id74kUv1R1J4+09NXaqY?=
 =?iso-8859-1?Q?9AH78n+ts9JdR53l5TqQud/5mNgm0LM/ZG42ju1bepxIm/G9Cewi1fUA8k?=
 =?iso-8859-1?Q?5kSpJFCF0olCsCCf50OxNHpdNuw7JPjbxZ/2ucXSrTnZdL7OC1YO/0hpLm?=
 =?iso-8859-1?Q?deIaA5CZWDqlRflPj4iXvwoklabTdmsQBIG72f4hogWcmcp+xzqG3VCLeG?=
 =?iso-8859-1?Q?wq1DgWdMAH0G7U3os+gkpeKALrf6f3Ehy+vVCjubB3YYFfTzdetbCqRvna?=
 =?iso-8859-1?Q?yEgIFEDqHo0cuUF33GbVRxyJIt0J7bswHtZcf0MGps3WLGyuUiS551R7Bl?=
 =?iso-8859-1?Q?a8mGD1ZpMAQ5W4OdFgJVuA9FlAru+J8biL6A73cZs1dtkBQB7yXppmb/lV?=
 =?iso-8859-1?Q?FS4ZGWl9s54fO4fCbkes8bJo9NXavRuWMGGPG8Hd4FcC1ZMTEWZHLSNEy8?=
 =?iso-8859-1?Q?IAGE9IjwlnvuWVVoxfF5ES8kuAQnl1N/g6wEDW7wu69RDSr7L5lEPQkZb8?=
 =?iso-8859-1?Q?+RA3pn/EXuIus3/7LWB0+Z0Qb0s+YmZQr5FkukVooNTJ+qI0Po2bwddRGY?=
 =?iso-8859-1?Q?5YeD2G7QC5JcixL7V1usiGHujsHp4KHdHvITVrBcS/JFg0uRxC52pEaKcU?=
 =?iso-8859-1?Q?mGLYEd026hxKBzaXYPjf9e5T9WkasjR6ZpJ3b+lL2Ij0LPGC+ss/Sd499s?=
 =?iso-8859-1?Q?84LR65xXnOQkbBanrTKH1ZKxXlfvSxYvUgMvLk7/t5ZUUFiY2L/8JFaSny?=
 =?iso-8859-1?Q?aQoKl8o9uFkJtkckryXkKgXpJA0HjCtrq+9JCQIlqGQZ4DB7yqWMrEri6Q?=
 =?iso-8859-1?Q?3TecR0mnd2B+AiW2F6eG8dO7CNV7+AkNJyE/3NlMN3YYfG0RdHDjsfZdEM?=
 =?iso-8859-1?Q?Aa+BKVwMvLQeWTO/ZJxCEM7Ef2NndXrJSM9a8O9N4IxnBe45nTY+lF0vqV?=
 =?iso-8859-1?Q?meka+LdvEKN9dhWw8dYJp3pyULRfWbS7IP8wXmX90oIw5JQ0mqICvmdsK5?=
 =?iso-8859-1?Q?ZpIn42r3vFdqZl/Glgec0YvhKOvEQlVylolwVtuzzwftZRqW620lCnW9RD?=
 =?iso-8859-1?Q?BibcHXtcC96ck/FeWD82DxNM56HucofaMKKL+XrTAIzHfQNKrImojEznJ2?=
 =?iso-8859-1?Q?MgGUetsgO4A/yUJkWUbtQG2z+gu8s63LKEwtTBm6fysrcDKBRnT7PHQm6A?=
 =?iso-8859-1?Q?hBGXnzyLf358kJdjzl7ptyqaJX8radrhC6s0opH4L85FnlhBuYL9lghINK?=
 =?iso-8859-1?Q?hMaqE35ztx8TDRY5A1Y5Wbg38dl9EE88GJqtWOWLAuIbjPBd0m6CFqCVF0?=
 =?iso-8859-1?Q?kL3EtGQxsFLA9KFoJdLSXuTW8K4KJY++eBEFqdNS8rfHA1kvN01zDGVTSz?=
 =?iso-8859-1?Q?KyrKQlIA8B76gnPHE92U15?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Pk2aMVWEZhzP+NXo4GjHYby/goZ2nuJ3+asUnsKoVdaSaWEsMiQGwYWZly?=
 =?iso-8859-1?Q?3WObcdCXMFuupxybD4evAQ0L67nhSCo+FIjYXeiIZpmtLvVifjqQi6r8LE?=
 =?iso-8859-1?Q?F9Fuaf3M9CPA+Md9lKLYbK7lM+DUNkROZvAaI/98KawW3r5c+djhku8Fpi?=
 =?iso-8859-1?Q?mw5COdtVPLi3GBF7fvC7i/enBRB3R348fvSv2vVELlFoRMqoU65OikfEba?=
 =?iso-8859-1?Q?/BsQmbXG4WoIFUJbh9KMAR+tp3ZZlE/h2Bh8TP08JvCnkZqsf3NtsvL/Yt?=
 =?iso-8859-1?Q?VW2/AxqBJjS4VIX412UFaE/VjaBsQAEjXU2DB/eQF4HJuh9BfI7e4Zkz6u?=
 =?iso-8859-1?Q?89cPXF94MYZQGUgsvJ8020dK4ArUKhVJiiKy7HIb9lpjihlj35VjZe1JL1?=
 =?iso-8859-1?Q?gsCfn9AG33lWfK5VDMA9HUyKnCXogO7DkyYkw/4cgRdYr+Op4hPzgK3Vwc?=
 =?iso-8859-1?Q?0Mv7+DqEGcq8BxjlmsM5sL+tPXu0R2B6orGr2oYeGjlCAS7gz87R70tx5r?=
 =?iso-8859-1?Q?K8zA1aPJlPRN20noN9farVAKNcM2f/EjWgwmUP3ksn27jxFhpr6Wky4Ohv?=
 =?iso-8859-1?Q?nXiyaGeXYoVN/ILBraThS/jQF8v87eYI7NfMYpGoyFKWiUV342GIhHxAAE?=
 =?iso-8859-1?Q?0wyCEYbdPHl6Bz9fX9WKbrnusFnPyVx6NSbdU/bYaQee6H7G4QXs1rDWQV?=
 =?iso-8859-1?Q?U/JhiyqZ6cJqIH8Q3p39JE8rhi4IWuq0X8tDEpRH8Zly9YnIduuuJAdeaV?=
 =?iso-8859-1?Q?HHZbvi80uEJORxURnAO9ZGKQHayM7800lai3qEjELvTlb0ZDrRyM0A/zg/?=
 =?iso-8859-1?Q?8y5nzFvSutM6igkLHBfQvc8fYs4zzz1xBRx/gIStGk3sFRvz00GXM6U1uk?=
 =?iso-8859-1?Q?O3PdBom+6KIJwhv8YI/fWPjNQQnLoYTV7S6wy3+qJkGta4ctmXD5ncd6NZ?=
 =?iso-8859-1?Q?r8iL++apkfi8ol/sFhFoCBDtqEZ7c3sVTb6BXXfcxmdZsDJO5GxI43b8kB?=
 =?iso-8859-1?Q?s1it8Qr4AMr6GQ8AHbvGJ+WLdkLv80XYLtHmReEmZCS2jfg0dyYQ1d8UD3?=
 =?iso-8859-1?Q?OYm7rc/fb7zZb0796ueUpVm1PqL5C0SUGF5sspWoRpFHi1cigTCOZ2Zut4?=
 =?iso-8859-1?Q?ccVp5oq7Z8KEVn3MJbn70sx3HULHcGNyNvvFY0E4bGXZWkDnys6JE+GfZz?=
 =?iso-8859-1?Q?5pY3U6Rev2B8ekEoI+MsFhQVox09eJLt6RtBz0/uKiIlphNplDKVlr4n6L?=
 =?iso-8859-1?Q?zMAYwy3G+u23gbfHLLK8ieIDqgtkuGmKfbIdAeMVFTv5bDP/TFC2NiaXRH?=
 =?iso-8859-1?Q?0t5tcyCOCanfeG/JP9sgIoT4yDrZNp8AVUk1JG+KNahGhGNxZRV5ksUBY4?=
 =?iso-8859-1?Q?THRVvJwAxtK3KU3wjFP3yiHNtxfFusLvkEBYhk6qxo5VXJQCB3Nhm9KOBy?=
 =?iso-8859-1?Q?jVLhoUcQbkeGhxUNRGLRazMkAD9YB+EkBjJJxsXZXVJ6o9IjQZ5elLsdEd?=
 =?iso-8859-1?Q?LwpM1GR8cVTUVsvs8vpbpWV+cLOHoxLIW4B0c+dPyP7NlTRbNCG/oyCEXh?=
 =?iso-8859-1?Q?IEDnXWSHO/OJVMSUpmQyKRueq8Cv8CuX/CoexDrQiq68VM6V4H+SZjQptr?=
 =?iso-8859-1?Q?jWwUEoqq/94EqLNiZWQHjSOPOEMDQq2KszvaJT1Vk0HGwKIwBkXbFbZA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdbdfcc-d45d-46a2-a24f-08dd45ce0ed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:44.8108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Egv7PsUUDfhCoB0FHZqL3A35E2OmSV6HAH9D0ysyu2AGfcdpeYceNyosoDfFVw86uzV+9lz2We+KN7+Pk1RRMCyCK7VIAS85OxN7X0HrtPo=
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

Introducing pcie support for BCM2712 on example of the RPI5 board.
This driver initializes PCIe driver on start and provides access to
the peripheral, connected to PCIe.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 drivers/pci/pcie_brcmstb.c | 314 ++++++++++++++++++++++++++++++++++---
 1 file changed, 296 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
index cd45f0bee9..9de5c0e980 100644
--- a/drivers/pci/pcie_brcmstb.c
+++ b/drivers/pci/pcie_brcmstb.c
@@ -21,6 +21,7 @@
 #include <linux/bitfield.h>
 #include <linux/log2.h>
 #include <linux/iopoll.h>
+#include <reset.h>
=20
 /* Offset of the mandatory PCIe capability config registers */
 #define BRCM_PCIE_CAP_REGS				0x00ac
@@ -45,6 +46,7 @@
 #define  MISC_CTRL_CFG_READ_UR_MODE_MASK		0x2000
 #define  MISC_CTRL_MAX_BURST_SIZE_MASK			0x300000
 #define  MISC_CTRL_MAX_BURST_SIZE_128			0x0
+#define  MISC_CTRL_MAX_BURST_SIZE_128_2712		0x100000
 #define  MISC_CTRL_SCB0_SIZE_MASK			0xf8000000
=20
 #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO		0x400c
@@ -65,6 +67,9 @@
 #define PCIE_MISC_RC_BAR3_CONFIG_LO			0x403c
 #define  RC_BAR3_CONFIG_LO_SIZE_MASK			0x1f
=20
+#define PCIE_MISC_PCIE_CTRL				0x4064
+#define PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK		0x4
+
 #define PCIE_MISC_PCIE_STATUS				0x4068
 #define  STATUS_PCIE_PORT_MASK				0x80
 #define  STATUS_PCIE_PORT_SHIFT				7
@@ -90,18 +95,23 @@
 #define PCIE_MEM_WIN0_LIMIT_HI(win)	\
 	 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI + ((win) * 8)
=20
-#define PCIE_MISC_HARD_PCIE_HARD_DEBUG			0x4204
+#define PCIE_MISC_HARD_PCIE_HARD_DEBUG(pcie)	\
+	((pcie)->pcie_cfg->offsets[PCIE_HARD_DEBUG])
 #define  PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
=20
 #define PCIE_MSI_INTR2_CLR				0x4508
 #define PCIE_MSI_INTR2_MASK_SET				0x4510
=20
-#define PCIE_EXT_CFG_DATA				0x8000
+#define PCIE_EXT_CFG_DATA(pcie)	\
+	((pcie)->pcie_cfg->offsets[EXT_CFG_DATA])
=20
-#define PCIE_EXT_CFG_INDEX				0x9000
+#define PCIE_EXT_CFG_INDEX(pcie)	\
+	((pcie)->pcie_cfg->offsets[EXT_CFG_INDEX])
=20
-#define PCIE_RGR1_SW_INIT_1				0x9210
+#define PCIE_RGR1_SW_INIT_1(pcie)	\
+	((pcie)->pcie_cfg->offsets[RGR1_SW_INIT_1])
 #define  RGR1_SW_INIT_1_PERST_MASK			0x1
+#define  RGR1_SW_INIT_1_PERSTB_MASK			0x4
 #define  RGR1_SW_INIT_1_INIT_MASK			0x2
=20
 /* PCIe parameters */
@@ -131,6 +141,52 @@
 #define SSC_STATUS_PLL_LOCK_MASK			0x800
 #define SSC_STATUS_PLL_LOCK_SHIFT			11
=20
+#define PCIE_RC_PL_PHY_CTL_15				0x184c
+#define PCIE_RC_PL_PHY_CTL_15_DIS_PLL_PD_MASK		0x400000
+#define PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK	0xff
+
+#define PCIE_MISC_UBUS_CTRL				0x40a4
+#define  PCIE_MISC_UBUS_CTRL_UBUS_PCIE_REPLY_ERR_DIS_MASK	BIT(13)
+#define  PCIE_MISC_UBUS_CTRL_UBUS_PCIE_REPLY_DECERR_DIS_MASK	BIT(19)
+#define PCIE_MISC_AXI_READ_ERROR_DATA			0x4170
+#define PCIE_MISC_UBUS_TIMEOUT				0x40A8
+#define PCIE_MISC_RC_CONFIG_RETRY_TIMEOUT		0x405c
+#define PCIE_MISC_RC_BAR4_CONFIG_LO			0x40d4
+#define PCIE_MISC_RC_BAR4_CONFIG_HI			0x40d8
+#define PCIE_MISC_UBUS_BAR_CONFIG_REMAP_HI_MASK		0xff
+#define PCIE_MISC_UBUS_BAR4_CONFIG_REMAP_HI		0x4110
+#define PCIE_MISC_UBUS_BAR_CONFIG_REMAP_ENABLE		0x1
+#define PCIE_MISC_UBUS_BAR_CONFIG_REMAP_LO_MASK		0xfffff000
+#define PCIE_MISC_UBUS_BAR4_CONFIG_REMAP_LO		0x410c
+
+#define PCIE_MISC_UBUS_BAR2_CONFIG_REMAP		0x40b4
+#define  PCIE_MISC_UBUS_BAR2_CONFIG_REMAP_ACCESS_ENABLE_MASK	BIT(0)
+#define  MISC_CTRL_PCIE_RCB_MPS_MODE_MASK		0x400
+
+#define PCIE_LINK_STATE_L1				BIT(1)
+
+enum {
+	RGR1_SW_INIT_1,
+	EXT_CFG_INDEX,
+	EXT_CFG_DATA,
+	PCIE_HARD_DEBUG,
+};
+
+enum brcm_pcie_type {
+	BCM2711,
+	BCM2712
+};
+
+struct brcm_pcie;
+
+struct brcm_pcie_cfg_data {
+	const int *offsets;
+	const enum brcm_pcie_type type;
+	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
+	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	bool (*rc_mode)(struct brcm_pcie *pcie);
+};
+
 /**
  * struct brcm_pcie - the PCIe controller state
  * @base: Base address of memory mapped IO registers of the controller
@@ -143,6 +199,9 @@ struct brcm_pcie {
=20
 	int			gen;
 	bool			ssc;
+	struct reset_ctl	rescal;
+	struct reset_ctl	bridge_reset;
+	const struct brcm_pcie_cfg_data *pcie_cfg;
 };
=20
 /**
@@ -186,6 +245,44 @@ static bool brcm_pcie_rc_mode(struct brcm_pcie *pcie)
 	return (val & STATUS_PCIE_PORT_MASK) >> STATUS_PCIE_PORT_SHIFT;
 }
=20
+static void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
+{
+	if (val)
+		setbits_le32(pcie->base + PCIE_RGR1_SW_INIT_1(pcie),
+			     RGR1_SW_INIT_1_PERST_MASK);
+	else
+		clrbits_le32(pcie->base + PCIE_RGR1_SW_INIT_1(pcie),
+			     RGR1_SW_INIT_1_PERST_MASK);
+}
+
+static void brcm_pcie_perst_set_2712(struct brcm_pcie *pcie, u32 val)
+{
+	u32 tmp;
+
+	/* Perst bit has moved and assert value is 0 */
+	tmp =3D readl(pcie->base + PCIE_MISC_PCIE_CTRL);
+	u32p_replace_bits(&tmp, !val, RGR1_SW_INIT_1_PERSTB_MASK);
+	writel(tmp, pcie->base + PCIE_MISC_PCIE_CTRL);
+}
+
+static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u=
32 val)
+{
+	if (val)
+		setbits_le32(pcie->base + PCIE_RGR1_SW_INIT_1(pcie),
+			     RGR1_SW_INIT_1_INIT_MASK);
+	else
+		clrbits_le32(pcie->base + PCIE_RGR1_SW_INIT_1(pcie),
+			     RGR1_SW_INIT_1_INIT_MASK);
+}
+
+static void brcm_pcie_bridge_sw_init_set_2712(struct brcm_pcie *pcie, u32 =
val)
+{
+	if (val)
+		reset_assert(&pcie->bridge_reset);
+	else
+		reset_deassert(&pcie->bridge_reset);
+}
+
 /**
  * brcm_pcie_link_up() - Check whether the PCIe link is up
  * @pcie: Pointer to the PCIe controller state
@@ -232,8 +329,8 @@ static int brcm_pcie_config_address(const struct udevic=
e *dev, pci_dev_t bdf,
 	/* For devices, write to the config space index register */
 	idx =3D PCIE_ECAM_OFFSET(pci_bus, pci_dev, pci_func, 0);
=20
-	writel(idx, pcie->base + PCIE_EXT_CFG_INDEX);
-	*paddress =3D pcie->base + PCIE_EXT_CFG_DATA + offset;
+	writel(idx, pcie->base + PCIE_EXT_CFG_INDEX(pcie));
+	*paddress =3D pcie->base + PCIE_EXT_CFG_DATA(pcie) + offset;
=20
 	return 0;
 }
@@ -427,6 +524,98 @@ static void brcm_pcie_set_outbound_win(struct brcm_pci=
e *pcie,
 	writel(tmp, base + PCIE_MEM_WIN0_LIMIT_HI(win));
 }
=20
+static void brcm_pcie_get_resets_dt(struct udevice *dev)
+{
+	struct brcm_pcie *pcie =3D dev_get_priv(dev);
+	int ret;
+
+	ret =3D reset_get_by_name(dev, "rescal", &pcie->rescal);
+	if (ret) {
+		printf("Unable to get rescal reset\n");
+		return;
+	}
+
+	ret =3D reset_get_by_name(dev, "bridge", &pcie->bridge_reset);
+	if (ret) {
+		printf("Unable to get bridge reset\n");
+		return;
+	}
+}
+
+static void brcm_pcie_do_reset(struct udevice *dev)
+{
+	struct brcm_pcie *pcie =3D dev_get_priv(dev);
+	int ret;
+
+	ret =3D reset_deassert(&pcie->rescal);
+	if (ret)
+		printf("failed to deassert 'rescal'\n");
+}
+
+static void brcm_pcie_munge_pll(struct brcm_pcie *pcie)
+{
+	u32 tmp;
+	int ret, i;
+	u8 regs[] =3D  { 0x16,   0x17,   0x18,   0x19,   0x1b,   0x1c,   0x1e };
+	u16 data[] =3D { 0x50b9, 0xbda1, 0x0094, 0x97b4, 0x5030, 0x5030, 0x0007 }=
;
+
+	ret =3D brcm_pcie_mdio_write(pcie->base, MDIO_PORT0, SET_ADDR_OFFSET,
+				   0x1600);
+	for (i =3D 0; i < ARRAY_SIZE(regs); i++) {
+		brcm_pcie_mdio_read(pcie->base, MDIO_PORT0, regs[i], &tmp);
+		debug("PCIE MDIO pre_refclk 0x%02x =3D 0x%04x\n",
+		      regs[i], tmp);
+	}
+	for (i =3D 0; i < ARRAY_SIZE(regs); i++) {
+		brcm_pcie_mdio_write(pcie->base, MDIO_PORT0, regs[i], data[i]);
+		brcm_pcie_mdio_read(pcie->base, MDIO_PORT0, regs[i], &tmp);
+		debug("PCIE MDIO post_refclk 0x%02x =3D 0x%04x\n",
+		      regs[i], tmp);
+	}
+
+	udelay(200);
+}
+
+static void brcm_pcie_window_prog(struct udevice *dev)
+{
+	struct brcm_pcie *pcie =3D dev_get_priv(dev);
+	void __iomem *base =3D pcie->base;
+	int i, ret;
+	u32 tmp;
+
+	if (pcie->pcie_cfg->type !=3D BCM2712)
+		return;
+
+	/* program additional inbound windows (RC_BAR4..RC_BAR10) */
+	for (i =3D 0; i < 7; i++) {
+		u64 bar_cpu, bar_size, bar_pci;
+		struct pci_region region;
+
+		ret =3D pci_get_dma_regions(dev, &region, i + 1);
+		if (ret)
+			break;
+
+		bar_pci =3D region.bus_start;
+		bar_cpu =3D region.phys_start;
+		bar_size =3D region.size;
+		tmp =3D lower_32_bits(bar_pci);
+		u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(bar_size),
+				  RC_BAR2_CONFIG_LO_SIZE_MASK);
+		writel(tmp, base + PCIE_MISC_RC_BAR4_CONFIG_LO + i * 8);
+		writel(upper_32_bits(bar_pci),
+		       base + PCIE_MISC_RC_BAR4_CONFIG_HI + i * 8);
+
+		tmp =3D upper_32_bits(bar_cpu) &
+			PCIE_MISC_UBUS_BAR_CONFIG_REMAP_HI_MASK;
+		writel(tmp,
+		       base + PCIE_MISC_UBUS_BAR4_CONFIG_REMAP_HI + i * 8);
+		tmp =3D lower_32_bits(bar_cpu) &
+				PCIE_MISC_UBUS_BAR_CONFIG_REMAP_LO_MASK;
+		writel(tmp | PCIE_MISC_UBUS_BAR_CONFIG_REMAP_ENABLE,
+		       base + PCIE_MISC_UBUS_BAR4_CONFIG_REMAP_LO + i * 8);
+	}
+}
+
 static int brcm_pcie_probe(struct udevice *dev)
 {
 	struct udevice *ctlr =3D pci_get_controller(dev);
@@ -442,13 +631,21 @@ static int brcm_pcie_probe(struct udevice *dev)
 	u16 nlw, cls, lnksta;
 	u32 tmp;
=20
+	/*
+	 * Deassert rescal reset for BCM2712.
+	 */
+	if (pcie->pcie_cfg->type =3D=3D BCM2712)
+		brcm_pcie_do_reset(dev);
+
 	/*
 	 * Reset the bridge, assert the fundamental reset. Note for some SoCs,
 	 * e.g. BCM7278, the fundamental reset should not be asserted here.
 	 * This will need to be changed when support for other SoCs is added.
 	 */
-	setbits_le32(base + PCIE_RGR1_SW_INIT_1,
-		     RGR1_SW_INIT_1_INIT_MASK | RGR1_SW_INIT_1_PERST_MASK);
+	pcie->pcie_cfg->bridge_sw_init_set(pcie, 1);
+	if (pcie->pcie_cfg->type !=3D BCM2712)
+		pcie->pcie_cfg->perst_set(pcie, 1);
+
 	/*
 	 * The delay is a safety precaution to preclude the reset signal
 	 * from looking like a glitch.
@@ -456,20 +653,35 @@ static int brcm_pcie_probe(struct udevice *dev)
 	udelay(100);
=20
 	/* Take the bridge out of reset */
-	clrbits_le32(base + PCIE_RGR1_SW_INIT_1, RGR1_SW_INIT_1_INIT_MASK);
+	pcie->pcie_cfg->bridge_sw_init_set(pcie, 0);
=20
-	clrbits_le32(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG,
+	clrbits_le32(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG(pcie),
 		     PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
=20
 	/* Wait for SerDes to be stable */
 	udelay(100);
=20
+	if (pcie->pcie_cfg->type =3D=3D BCM2712) {
+		/* Allow a 54MHz (xosc) refclk source */
+		brcm_pcie_munge_pll(pcie);
+		/* Fix for L1SS errata */
+		tmp =3D readl(base + PCIE_RC_PL_PHY_CTL_15);
+		tmp &=3D ~PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK;
+		/* PM clock period is 18.52ns (round down) */
+		tmp |=3D 0x12;
+		writel(tmp, base + PCIE_RC_PL_PHY_CTL_15);
+	}
+
+	tmp =3D (pcie->pcie_cfg->type =3D=3D BCM2712) ?
+			MISC_CTRL_MAX_BURST_SIZE_128_2712 :
+			MISC_CTRL_MAX_BURST_SIZE_128;
 	/* Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN */
 	clrsetbits_le32(base + PCIE_MISC_MISC_CTRL,
 			MISC_CTRL_MAX_BURST_SIZE_MASK,
 			MISC_CTRL_SCB_ACCESS_EN_MASK |
 			MISC_CTRL_CFG_READ_UR_MODE_MASK |
-			MISC_CTRL_MAX_BURST_SIZE_128);
+			MISC_CTRL_PCIE_RCB_MPS_MODE_MASK |
+			tmp);
=20
 	pci_get_dma_regions(dev, &region, 0);
 	rc_bar2_offset =3D region.bus_start - region.phys_start;
@@ -482,6 +694,12 @@ static int brcm_pcie_probe(struct udevice *dev)
 	writel(upper_32_bits(rc_bar2_offset),
 	       base + PCIE_MISC_RC_BAR2_CONFIG_HI);
=20
+	if (pcie->pcie_cfg->type =3D=3D BCM2712) {
+		tmp =3D readl(base + PCIE_MISC_UBUS_BAR2_CONFIG_REMAP);
+		u32p_replace_bits(&tmp, 1, PCIE_MISC_UBUS_BAR2_CONFIG_REMAP_ACCESS_ENABL=
E_MASK);
+		writel(tmp, base + PCIE_MISC_UBUS_BAR2_CONFIG_REMAP);
+	}
+
 	scb_size_val =3D rc_bar2_size ?
 		       ilog2(rc_bar2_size) - 15 : 0xf; /* 0xf is 1GB */
=20
@@ -490,6 +708,29 @@ static int brcm_pcie_probe(struct udevice *dev)
 			  MISC_CTRL_SCB0_SIZE_MASK);
 	writel(tmp, base + PCIE_MISC_MISC_CTRL);
=20
+	if (pcie->pcie_cfg->type =3D=3D BCM2712) {
+		/* Suppress AXI error responses and return 1s for read failures */
+		tmp =3D readl(base + PCIE_MISC_UBUS_CTRL);
+		u32p_replace_bits(&tmp, 1, PCIE_MISC_UBUS_CTRL_UBUS_PCIE_REPLY_ERR_DIS_M=
ASK);
+		u32p_replace_bits(&tmp, 1, PCIE_MISC_UBUS_CTRL_UBUS_PCIE_REPLY_DECERR_DI=
S_MASK);
+		writel(tmp, base + PCIE_MISC_UBUS_CTRL);
+		writel(0xffffffff, base + PCIE_MISC_AXI_READ_ERROR_DATA);
+
+		/*
+		 * Adjust timeouts. The UBUS timeout also affects CRS
+		 * completion retries, as the request will get terminated if
+		 * either timeout expires, so both have to be a large value
+		 * (in clocks of 750MHz).
+		 * Set UBUS timeout to 250ms, then set RC config retry timeout
+		 * to be ~240ms.
+		 *
+		 * Setting CRSVis=3D1 will stop the core from blocking on a CRS
+		 * response, but does require the device to be well-behaved...
+		 */
+		writel(0xB2D0000, base + PCIE_MISC_UBUS_TIMEOUT);
+		writel(0xABA0000, base + PCIE_MISC_RC_CONFIG_RETRY_TIMEOUT);
+	}
+
 	/* Disable the PCIe->GISB memory window (RC_BAR1) */
 	clrbits_le32(base + PCIE_MISC_RC_BAR1_CONFIG_LO,
 		     RC_BAR1_CONFIG_LO_SIZE_MASK);
@@ -504,12 +745,13 @@ static int brcm_pcie_probe(struct udevice *dev)
 	/* Clear any interrupts we find on boot */
 	writel(0xffffffff, base + PCIE_MSI_INTR2_CLR);
=20
+	brcm_pcie_window_prog(dev);
+
 	if (pcie->gen)
 		brcm_pcie_set_gen(pcie, pcie->gen);
=20
 	/* Unassert the fundamental reset */
-	clrbits_le32(pcie->base + PCIE_RGR1_SW_INIT_1,
-		     RGR1_SW_INIT_1_PERST_MASK);
+	pcie->pcie_cfg->perst_set(pcie, 0);
=20
 	/*
 	 * Wait for 100ms after PERST# deassertion; see PCIe CEM specification
@@ -528,7 +770,7 @@ static int brcm_pcie_probe(struct udevice *dev)
 		return -EINVAL;
 	}
=20
-	if (!brcm_pcie_rc_mode(pcie)) {
+	if (!pcie->pcie_cfg->rc_mode(pcie)) {
 		printf("PCIe misconfigured; is in EP mode\n");
 		return -EINVAL;
 	}
@@ -596,14 +838,14 @@ static int brcm_pcie_remove(struct udevice *dev)
 	void __iomem *base =3D pcie->base;
=20
 	/* Assert fundamental reset */
-	setbits_le32(base + PCIE_RGR1_SW_INIT_1, RGR1_SW_INIT_1_PERST_MASK);
+	pcie->pcie_cfg->perst_set(pcie, 1);
=20
 	/* Turn off SerDes */
-	setbits_le32(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG,
+	setbits_le32(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG(pcie),
 		     PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
=20
 	/* Shutdown bridge */
-	setbits_le32(base + PCIE_RGR1_SW_INIT_1, RGR1_SW_INIT_1_INIT_MASK);
+	pcie->pcie_cfg->bridge_sw_init_set(pcie, 1);
=20
 	return 0;
 }
@@ -628,6 +870,11 @@ static int brcm_pcie_of_to_plat(struct udevice *dev)
 	else
 		pcie->gen =3D max_link_speed;
=20
+	pcie->pcie_cfg =3D (const struct brcm_pcie_cfg_data *)dev_get_driver_data=
(dev);
+
+	if (pcie->pcie_cfg->type =3D=3D BCM2712)
+		brcm_pcie_get_resets_dt(dev);
+
 	return 0;
 }
=20
@@ -636,8 +883,39 @@ static const struct dm_pci_ops brcm_pcie_ops =3D {
 	.write_config	=3D brcm_pcie_write_config,
 };
=20
+static const int pcie_offsets[] =3D {
+	[RGR1_SW_INIT_1] =3D 0x9210,
+	[EXT_CFG_INDEX]  =3D 0x9000,
+	[EXT_CFG_DATA]   =3D 0x8000,
+	[PCIE_HARD_DEBUG] =3D 0x4204,
+};
+
+static const struct brcm_pcie_cfg_data bcm2711_cfg =3D {
+	.offsets	=3D pcie_offsets,
+	.type		=3D BCM2711,
+	.perst_set	=3D brcm_pcie_perst_set_generic,
+	.bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_generic,
+	.rc_mode	=3D brcm_pcie_rc_mode,
+};
+
+static const int pcie_offsets_bcm2712[] =3D {
+	[RGR1_SW_INIT_1] =3D 0x0,
+	[EXT_CFG_INDEX] =3D 0x9000,
+	[EXT_CFG_DATA] =3D 0x8000,
+	[PCIE_HARD_DEBUG] =3D 0x4304,
+};
+
+static const struct brcm_pcie_cfg_data bcm2712_cfg =3D {
+	.offsets	=3D pcie_offsets_bcm2712,
+	.type		=3D BCM2712,
+	.perst_set	=3D brcm_pcie_perst_set_2712,
+	.bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_2712,
+	.rc_mode	=3D brcm_pcie_rc_mode,
+};
+
 static const struct udevice_id brcm_pcie_ids[] =3D {
-	{ .compatible =3D "brcm,bcm2711-pcie" },
+	{ .compatible =3D "brcm,bcm2711-pcie", .data =3D (ulong)&bcm2711_cfg },
+	{ .compatible =3D "brcm,bcm2712-pcie", .data =3D (ulong)&bcm2712_cfg },
 	{ }
 };
=20
--=20
2.34.1
