Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F306FCD5BB1
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 20:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE361848DD;
	Sun, 24 May 2026 22:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Q+gU/cM1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44C7B8491D; Sun, 24 May 2026 22:01:01 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 022728489D
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 22:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdAb4JlLLqkWIbOUdfgcJDl/07EJD4bPSSO1ZxSIUEQOW0hy2/o2TTZzAKqeYZid5WmYyXuUfxqXW6cmYHxhs6qs0irkzrGQI/0+CT328yTdxMtKgxK/kq4C/8YHgic0YZNK4mYqBe71JPWaxERuO+Hqj4M4BBNW9h9bW2JP6OPFgVhbHT0XSTHQSAKSApxEXUvjnwoYHmEd/TF1iqSp5xLBHYTmPxnW+BOqcrGW5eSqhqxa78WuuuITjGehxKGWXUNLoBVTXRbMSfgX6Cciu8m5JCrQb1giDH3jzP3hzYAoPxtuMhfsnzN6YgEZYevF6VEQjWl05TvEvWDHCnAN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=eQgPKEkMFAuc22oV9M989UruvzkjXb+Hk7skIB8sc68v1UMT6IdTMqcVU6gVJionjn/aTDX7fHQ6TjKLlW6zIg2bHNKlEhVjxrzOALiMV7SK2dbxYC+meA8pnvn9dCF8I/gBMuh77LwvcNiQLv/2CpFD30IlEycHhlP1kB4w2BLP+9ukclU1BwjxjWVD7tvLQk1OpXnhUKW3qKvyibZdoC07n8veeYyJO/eY6adGusOYRpMziOlgyXECeZukSifVETfdNCrV8Z7d0baUHUwTK48jOmyF05gWgAxJxcKH4ZfYgJKi6bMkFA5yQ6hcLEDBdOHs/X+bnNuio9vpRAs29w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CTuSEJtUONRqJV+obdsb4ncvj1FKSUiAO0dNj6Vmt8=;
 b=Q+gU/cM1aOMe4lbUsBhlmoLRMREKoBpzDow3ZpHq8RBW9HnBX6mJv6AjJc9muqAJSlBHNxhAad++RM8uqpESOQOW/+TTYzC7Eip/sBf9woYoLUXz+rSTQEhMmuaCmSjXl5l4tNZqoUZBoAO15jWFXykyBeflzFXRfg3vke/uu5LoSQRHlaeSBvYgMsVaiyD2LGmPIp+H71FZfpvvqMj2ET/ngj3BzIu908A8iwb7KJt0PF/qJ7P8LnCSHp38dVmCmRrG7+hWXPSfTE0jh8+7g2IydIFquDvh6+Jufx39qfV28e049DyWOewIt+hL0aJM6vm445VlK/YBDbrY4e0sbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS2PR08MB10266.eurprd08.prod.outlook.com (2603:10a6:20b:62f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 20:00:56 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 20:00:56 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v9 5/9] pinctrl: sort and format the contents of the makefile
Date: Sun, 24 May 2026 23:00:34 +0300
Message-ID: <20260524200038.47826-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260524200038.47826-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260524200038.47826-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS2PR08MB10266:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf2a7e1-2b3a-4cdc-66c3-08deb9cf2ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003|38350700014|921020|11063799006;
X-Microsoft-Antispam-Message-Info: tVVdGfwxR9Ooshxgue5seS9MqQVrHNwT4XtZQFmkK201RFz44EdLXnRrEFU9968p823DKvVGBcW6/XMnj9UzGjFLg1IG9qKqLBc3O2RJ6ly79JP7h1BHJB/XOnWYzvxlu4zIuLzvBHEH9CosTJYyYZF9Mio5APXo+HSCZFi5XmLDdVwozlniz7vLQp2+DRvo4/viRqhyjXx2SFemUR/8FdtOpj4oPv/dkB0O0Awttb8vD13fGoTld9lTIzufFthw2FG2FiIRj3B+z92Uf89kCZ7mpSb+qQ8miyB5hoavu9Z0HlE1qkfsDlutxZzYBq+2cKTc1r7tNfQvUclQ/VfpUNbP/W6G2zHjY/K5//dvLD2dpKfcCa74lev3fptYRh52p231BA1vnx91Wc112gP2HJQt7TFjwe6j4bNsRB0t+1je8XRt+QpvBeYheryCr741UoKwBMB0CTSB3+RGUsOzlftnDSskZWEjJ+q/INstoZR/gJfyPG4YUJVGgUxkP8hD9YSAANevaz0oqaNDe3/sBH91VIX1AKJ8kqRowyaGPq29eceqlHCYOyBl+BEj6KzMurWnRCPh+sC+kEr/iIkjPZZ+wU+EMavcc2tQDSoIL4pTo86lylqqudRcfNEgmyXBvkAy1t4QlQLvIORB5oHeOxxKpfoqY+sS/9wiy9cllqJiRCLDV0B2xVewEwMgwrWDaX5L2GgiLbIr53F2H3tzlWgGVO5U/JKdH/1cA4SeM+rsi66Hje2gUqeRj04+QUrRviJWHVdRoD4+iXVgDJJ96w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003)(38350700014)(921020)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ub45nNQMRrKVYaIiw6RL2qWzc9mkQumUSD5SE44B53taSfYMIgqADrG74BsZ?=
 =?us-ascii?Q?QI3teQDg19YwjgmQeH5dbcwSKARE7IWo1aO9Xqt5JW88y7iZ6eaq16kEHTth?=
 =?us-ascii?Q?u75swNdonhdYsr04ajg1E5EBytnu3FfD+epzfAhV6ADPhkTvZ6lkmFJbvqIT?=
 =?us-ascii?Q?eAYkIinuSSFxU8PfEuCed8Tde+Dlj28dZz9C9DEJ+GtwNFl+7eLd/0x9xD+F?=
 =?us-ascii?Q?vFwGQhpvIVmz2RRzpKzNhu7ZlIWAKUo0qdqucWkLKE9fGTP4ZB6mGuejIp5q?=
 =?us-ascii?Q?Ra1gF5xF5Bot7AVXqlJPb4cu1yinBPFqwGasHxPdB9E93xgrwDWJmxw/24tx?=
 =?us-ascii?Q?9NTkgbcCeVKBRCWdyCqNSQTuRYzFDzP477B/pWBKyWj61a2pCC8fot7PyZpm?=
 =?us-ascii?Q?zCGgwpKbdPaCHyZ+R1hq7yG8Fkr3waPgX+SCjmtKZPacZU0qRpSOtEuShho0?=
 =?us-ascii?Q?6qLEnq5/NtntAo+ifc9/W5aNdlG8spkwTsUlsdQ+yD+qa962fQ6iwRIbD47V?=
 =?us-ascii?Q?68Y/aov03TprkAvQCXs1hwBIU2l6qGaha/+NuXGDZxq3UXefW1+PESfJRccJ?=
 =?us-ascii?Q?2DikE2p5JUuN6Lv1rGP+k4jQyElWfysADMws3CoXaeKhsedkminwe6bF0OX4?=
 =?us-ascii?Q?8CBkFaoTipwOXNZXxaXfZMGBNLT9FybB6a5+ap4umz29Jg2yPDgd5kwVWkCR?=
 =?us-ascii?Q?0Ie2ONFkwOWuoc/7g/f5wzi/wfIzJPRsVnasqqcExAXf0aehZDXMuPJE18DB?=
 =?us-ascii?Q?HM+aonFqUx8oR5lvYu8tz73pTsNzuozNjqZjlvA+HVBLjJdxtO5wOXYtSxRX?=
 =?us-ascii?Q?p/+K25UFJNBVE3T6/QYUX30S7dHTC0N+V14M5IBuaUnjcgBwB+kMHByDxeOJ?=
 =?us-ascii?Q?DlTy0reuURiEvHabCP8zB14v/fFGVHgbdyLYCWU2D+FeAkg7hfQnRNc6pkEd?=
 =?us-ascii?Q?q6XRhcgXwuoO0+LEuSdA3oOxTC/Ua0rntoXoQXp+CnzbHck4k5NgwcQNez3Z?=
 =?us-ascii?Q?uDPlV3SXxn6WrlGlawrE+p0zGb7EULJQOPymjtiXQ2tRQvtRMnPZvUZrn1L0?=
 =?us-ascii?Q?CMYvKHDAC7Be6MNU1cm26RnZR77nYn5eYg7FXj1vDsQbtXPoYDm5yTWV/SDt?=
 =?us-ascii?Q?rNIyDwTB2YaD5MQUf4tj/dhilb83hDR1Oso17FBCeKm4QVSZ5RmWQuuq0FRV?=
 =?us-ascii?Q?vkGbiGHU07edzI+w1IzvVw4nwC8e0Dbm0IC0G1AMm/uEDxv52UBhRmPEn3+A?=
 =?us-ascii?Q?gnezyxc2/whSwigBteqnN1rr0jM5YcI6MHsuSnYRkRmt9MNTqv+NBWp/mEBN?=
 =?us-ascii?Q?LPjdQdH9mSriM1BCNe/6e0lsCGBDhEu8Sb7BHCiPwodP6sXrw68aibdmprpS?=
 =?us-ascii?Q?kmjvW0NXBOiBRlHFBNXqFqXgmf5jvzvruPVGEfEyUaAkHeZ6zJvFZHxXfshF?=
 =?us-ascii?Q?zfNEwVgO8b0GQ5Xy1/6v+YtOebCFMnxN31vXtKrZVDxsqCPstLjF6e1BT6qj?=
 =?us-ascii?Q?yeWO3CrAfcm00uVl+90efybwhXnA7THBMBiX5hoMXyWGNT5dhnCSIxmELP2O?=
 =?us-ascii?Q?4LHrGiaXDnowHu1QuCgTgrjZq0Vr2oX64ADum9Aw9adKNeHE4Dwogn5lq/3S?=
 =?us-ascii?Q?9QyrncwMUL7K0t8gT7SUbNS95COcRDFzpO/z26hoNqYPAlwbTcayleEYW0ZB?=
 =?us-ascii?Q?yvyna3AlqwthG7thPTH7rgkxGpKIV08i342aUO50DU0l+Cfw5FoB7cesdmGF?=
 =?us-ascii?Q?OlsKwtF5qqh5ibBqY1raZtDklxm4rso=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf2a7e1-2b3a-4cdc-66c3-08deb9cf2ae8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 20:00:56.4430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9MHfmHJCOSFIUkAUEZXtir22EpnVTRgOObj2lpPG7kauUe/I69bEqQ3TmDuywzH3cPVxGwu+6++wESIPB34JPZL9OnxNgm4SkxVQe9PYGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10266
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

sorting rules:
 * rules for generic pinctrl files placed first,
 * obj-y rules,
 * obj-$(CONFIG_ARCH_something) rules
 * obj-$(CONFIG_PINCTRL_something) rules

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/Makefile | 60 +++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 29fb9b484d0..df52c6db8c2 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -3,39 +3,41 @@
 obj-y					+= pinctrl-uclass.o
 obj-$(CONFIG_$(PHASE_)PINCTRL_GENERIC)	+= pinctrl-generic.o
 
+obj-y					+= broadcom/
+obj-y					+= nxp/
+
+obj-$(CONFIG_ARCH_ASPEED)		+= aspeed/
+obj-$(CONFIG_ARCH_ATH79)		+= ath79/
+obj-$(CONFIG_ARCH_MTMIPS)		+= mtmips/
+obj-$(CONFIG_ARCH_MVEBU)		+= mvebu/
+obj-$(CONFIG_ARCH_NEXELL)		+= nexell/
+obj-$(CONFIG_ARCH_NPCM)			+= nuvoton/
+obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
+
 obj-$(CONFIG_PINCTRL_ADI)		+= pinctrl-adi-adsp.o
 obj-$(CONFIG_PINCTRL_APPLE)		+= pinctrl-apple.o
 obj-$(CONFIG_PINCTRL_AT91)		+= pinctrl-at91.o
 obj-$(CONFIG_PINCTRL_AT91PIO4)		+= pinctrl-at91-pio4.o
-obj-y					+= nxp/
+obj-$(CONFIG_PINCTRL_EXYNOS)		+= exynos/
+obj-$(CONFIG_PINCTRL_INTEL)		+= intel/
+obj-$(CONFIG_PINCTRL_K210)		+= pinctrl-k210.o
+obj-$(CONFIG_PINCTRL_MESON)		+= meson/
+obj-$(CONFIG_PINCTRL_MSCC)		+= mscc/
+obj-$(CONFIG_PINCTRL_MTK)		+= mediatek/
+obj-$(CONFIG_PINCTRL_PIC32)		+= pinctrl_pic32.o
+obj-$(CONFIG_PINCTRL_QCOM)		+= qcom/
+obj-$(CONFIG_PINCTRL_QE)		+= pinctrl-qe-io.o
 obj-$(CONFIG_$(PHASE_)PINCTRL_ROCKCHIP)	+= rockchip/
-obj-$(CONFIG_ARCH_ASPEED) += aspeed/
-obj-$(CONFIG_ARCH_ATH79) += ath79/
-obj-$(CONFIG_PINCTRL_INTEL) += intel/
-obj-$(CONFIG_ARCH_MTMIPS) += mtmips/
-obj-$(CONFIG_ARCH_NPCM)         += nuvoton/
-obj-$(CONFIG_PINCTRL_QCOM) += qcom/
-obj-$(CONFIG_ARCH_RENESAS) += renesas/
-obj-$(CONFIG_PINCTRL_SANDBOX)	+= pinctrl-sandbox.o
-obj-$(CONFIG_PINCTRL_SUNXI)	+= sunxi/
-obj-$(CONFIG_$(PHASE_)PINCTRL_TEGRA)	+= tegra/
-obj-$(CONFIG_PINCTRL_UNIPHIER)	+= uniphier/
-obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl_pic32.o
-obj-$(CONFIG_PINCTRL_EXYNOS)	+= exynos/
-obj-$(CONFIG_PINCTRL_K210)	+= pinctrl-k210.o
-obj-$(CONFIG_PINCTRL_MESON)	+= meson/
-obj-$(CONFIG_PINCTRL_MTK)	+= mediatek/
-obj-$(CONFIG_PINCTRL_MSCC)	+= mscc/
-obj-$(CONFIG_ARCH_MVEBU)	+= mvebu/
-obj-$(CONFIG_ARCH_NEXELL)	+= nexell/
-obj-$(CONFIG_PINCTRL_QE)	+= pinctrl-qe-io.o
-obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
-obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
-obj-$(CONFIG_PINCTRL_STI)	+= pinctrl-sti.o
-obj-$(CONFIG_PINCTRL_STM32)	+= pinctrl_stm32.o
-obj-$(CONFIG_$(PHASE_)PINCTRL_SX150X) += pinctrl-sx150x.o
+obj-$(CONFIG_PINCTRL_SANDBOX)		+= pinctrl-sandbox.o
+obj-$(CONFIG_PINCTRL_SCMI)		+= pinctrl-scmi.o
+obj-$(CONFIG_PINCTRL_SINGLE)		+= pinctrl-single.o
+obj-$(CONFIG_PINCTRL_STARFIVE)		+= starfive/
+obj-$(CONFIG_PINCTRL_STI)		+= pinctrl-sti.o
+obj-$(CONFIG_PINCTRL_STM32)		+= pinctrl_stm32.o
 obj-$(CONFIG_$(PHASE_)PINCTRL_STMFX)	+= pinctrl-stmfx.o
-obj-$(CONFIG_PINCTRL_TH1520)	+= pinctrl-th1520.o
-obj-y				+= broadcom/
+obj-$(CONFIG_PINCTRL_SUNXI)		+= sunxi/
+obj-$(CONFIG_$(PHASE_)PINCTRL_SX150X)	+= pinctrl-sx150x.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_TEGRA)	+= tegra/
+obj-$(CONFIG_PINCTRL_TH1520)		+= pinctrl-th1520.o
+obj-$(CONFIG_PINCTRL_UNIPHIER)		+= uniphier/
 obj-$(CONFIG_$(PHASE_)PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
-obj-$(CONFIG_PINCTRL_STARFIVE)	+= starfive/
-- 
2.53.0

