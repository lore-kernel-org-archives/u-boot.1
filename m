Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D81C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 07:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 162B888896;
	Wed, 24 Jul 2024 09:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=weidmueller.com header.i=@weidmueller.com header.b="kGFDLx30";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E73888896; Wed, 24 Jul 2024 09:35:13 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D151888C2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 09:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYCtBM3wgZSA2n9Y4rinYDolnWhu0gpbL3msYLhtJmIbc3ElxMxBgWWKdx2OvpnzzBZ86pdysAbJn6eeifbs+dwVEiM/lYE3KUQj63mWMG2CupoxZ96PSc8dCmNyQFambXKjl6K9TEz/q1iqXeW8rfhRMWdBdvHGm17M5aucNGKojNcn2gZBe7r92XDCJ8XyUTDxZGGKJWTbe7RyTdy68kiVbRAD9iMtyz9uiYuD2+2sLBJrIZMyQ/UF+Aia8fkUwSJ5Qra+RSMoDsD3p/QfPL6JruPR6nMY4O9XzhWOsIcJOHfgQ0BQ7qhgpY627r29qKo1RO3AmhOvWCYS6fGcrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PA0KNwiJKOqZcNQTL398BllBaW3KiV/ZWtXdsV+moNw=;
 b=atwJezViLs6ym4CIbfwDzK0+PMdxFhwCJRIxOgq6g04gUVrDxVaHF6tw1BYAT3d63zAhZ4xeFWd6XM7Nr23s4AMCyDLW4Qv+8+rvw+ZPW3EErxCGL4+kFPDMvcRja4/s8K6GO7cTVF/tjkpMV/K2PDgaFcj+mdcv7fc+fNM4XZMra0x+GkAOvnHyabRabZlWFZcHZBM+Lw+ab8XujCDDxSyeDL+n1UKO6hThlvgeCCKg+j8ouMGE6ZOkMWyDQs4ZRkVNksW3IFVcMeZiaUuW50nQ7mofbc53Rd1/lrSBAxx/at5VILXFlO0Po4m6cPFnXy3h6B17Zt2uiJZu5qtJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PA0KNwiJKOqZcNQTL398BllBaW3KiV/ZWtXdsV+moNw=;
 b=kGFDLx30SLkOX7DDgtuV3uRHsRqLdg6Z2kbJBsvsB/tx47dWzfnuX1aRtnMDAuamaDTflXBPs1HKnTavrAbT3+bCw2duas7p0CBoVqvw+o5iDOw6WRhvk3jornxTelaPAvgTgczPne2TQ6P/qlVBTGtHvlgVEd1KlKT1xbXpCBf2dYJ2knmR5Z23+/dqCYjMkfTSacn5X4WnEsAXmPruz7KT0Vv2n0awnTSr4A3r4iDj+3+i6rqwFtpki5MlXpX6pZ5921+evhGPb6iqm7iZ2GbXdiUNdGiyX0cMtVa/tcKhufpIVuorImtW5aTVHEqVgrbUB0+OeEWcnbR2kpRamg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by GV2PR08MB8124.eurprd08.prod.outlook.com (2603:10a6:150:74::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 07:34:58 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%4]) with mapi id 15.20.7762.030; Wed, 24 Jul 2024
 07:34:58 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/1] tpm: call tpm_tis_wait_init() after tpm_tis_init()
Date: Wed, 24 Jul 2024 09:34:47 +0200
Message-Id: <20240724073448.710197-2-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240724073448.710197-1-lukas.funke-oss@weidmueller.com>
References: <20240724073448.710197-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::17) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|GV2PR08MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ed8b9f-1d90-4c6b-dd54-08dcabb31e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xwd6S21Vt0bClptgdsRp/jITXHnNQWnvfhqEd+zX72URMjWNO3rPpOisa+I4?=
 =?us-ascii?Q?gHRVkcfz2j0/WRUNkCPKSqT7RV0T3S4PK79NF60Sz22n6Vdq4WSGxFj77+Cl?=
 =?us-ascii?Q?gWo+8uP759KpH8CxK7Yt5io/RkXqbweleMzhpYqmafzQdPw2UUdvYoaHkoYn?=
 =?us-ascii?Q?L4o/wxfU5QtO70U3kS30MqdxxrtK4A0kWMmWFGVWJ9VB1Xe4OmngLrqXXNC3?=
 =?us-ascii?Q?wuPjkbiaVn0asrIhcL/jdTZMY/ZaI1+o1tZ/PJ5xJNfBUiElyoMLWh/avVvP?=
 =?us-ascii?Q?Cq3DiW34Tvo0VXsZtVS7HbpfkBJw+2dhEsVLauRSBpVJmfziFXhXScXO1uMy?=
 =?us-ascii?Q?oq1sqX8ct3jcDL8tDkATlSM6XielUuW1XzKXjP6u777nA6f71lAm/Gli4Pub?=
 =?us-ascii?Q?z2xuHiWQeekEdhhnw0S/qIIDQhza8KBh9NlgKBUmTDzTgL+9b+iADhZvWSg8?=
 =?us-ascii?Q?4iIu7vtnNiu/2rKLitvo/GDwgz9MQcsTQmMEV6E1ck3dV0JdUXSWbQn96XiH?=
 =?us-ascii?Q?ZuM3922khmW9bDGUcBvqS9b7CGK9+6yu8+m6Fgki0H08pFpTLcqY++tDj0b+?=
 =?us-ascii?Q?dZTuvymfcPFJJhhXu7B/vfzF9U0MG0Fknh1VqPV1SYSkuYJVlb85T7D14pzN?=
 =?us-ascii?Q?qthbhm6sarW6vzb/QzesQ90QsWvMiRc7FuHnu6nbHx9mO2Kk4AaDJB9n/QrY?=
 =?us-ascii?Q?J1UnM65IYt6eHy/P/dR6fjJnsjWnMoP2aQ1SpXUIyovgA1hCxP0vqCn8R1lN?=
 =?us-ascii?Q?Ijnv1vJ941CqzTDfij7fdymJ4aRvbY1scjhm1WrXlhHfP0A5M7EjutKuxzQy?=
 =?us-ascii?Q?c1GoF3CBU6R9V8uAXZBsFj/glpntXbrmo6PW7nFsGlunqWhn/b3MN6XEneoj?=
 =?us-ascii?Q?gX+Dif7RGEQkr4bXpE3+WIMvS3JgthEgljf+U5UdHoCJ6ke+dk6ZuWOuDdEh?=
 =?us-ascii?Q?Y8ZnXRXW4FIsAdtM7hNkyWQ+9yMfm27gsSefbLfJtqvqNK3m0Xezc2ah+zb6?=
 =?us-ascii?Q?Po9pR9F/JGd/n8K8VkAYq9k99KqVNGPHF1u3FRPx4d4kz6uSfjQD4BJ0v+nF?=
 =?us-ascii?Q?xJuhAXTdcoSsGl6JRHso3BlqDo91q5XPu0vbBhcwFeHrdvnpjK2NwTWgdRnC?=
 =?us-ascii?Q?Zmr5z9mtveOS0+lKISDlld9fPvqxLC1fwYKW/d9lkgx2aIF7lC3GrAjyV7PX?=
 =?us-ascii?Q?N5UKnF2Ep16ivCNr2RGujg3MGvvCBBG6SYXkIjKVueBKlHsN7IaF3IFXysKY?=
 =?us-ascii?Q?ZEJRaFB+0ZfhI3Mw0WR5sPCvReqR4xxKX09MdtqmQkBEFstR3wbwPOtjUWiT?=
 =?us-ascii?Q?qE6HEh1kg9lIC+u1pIYZRYWTYSHq3wV6hisLF163NmCjRzAKPdUrmLRi9tDJ?=
 =?us-ascii?Q?acMNCczmfmZrQZKrPy5E9X0R/CeR8C/XIp2RmRKExBzgBgi65A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wr7tVmxlAOFvSDBDzitWt+Akaqzvn4l6Xmwjkd9barve9xrpmQtY5CLRzBLA?=
 =?us-ascii?Q?mwJVS6O8dHZjWazG+x9Rs5+960wt02iR7A8kkHAmBqgWTSwktUzenYZJyQ7W?=
 =?us-ascii?Q?EQ5JPX+1DaP/jGZGHxunL28PF6S4SsTgeu5HN9SKkvjcF4oyy/+WAZwKj+pJ?=
 =?us-ascii?Q?sraLW6yLPRn/eD18s+3N4bp20uk89J05vx3KUvo6Ny5EsqPatTPi4EIzOGRb?=
 =?us-ascii?Q?B7w9iCBqzYejre5ljt6Yb1UoJ4No9KSdSYAewNLZCWsAO7M1by3ZsFdDqAZV?=
 =?us-ascii?Q?UEphaTUGjjIO+JhSrImhfagV1itkXHn/7eZstFV+N5GEnL1rX6zziHWG/siX?=
 =?us-ascii?Q?mvjivDtxl+O0GwGlsT3NzDaobfPzS8Vrlu4YzGHVTg8XwyAVzCcqf3Z1UQMP?=
 =?us-ascii?Q?Eckvd7OQ2PAOwtyjhQnzcrNN80f0zOTY5n48rE7J//sTUUuf654vWKQlBr79?=
 =?us-ascii?Q?Ejm7ipKpB2+YHiJ1f3Y43PutgghD5RbQUMtFK4vYRj4mqoPkmWpuJzeRXCSK?=
 =?us-ascii?Q?lnvx4+jooLFbIJsK1F93jsuU1TW0nbJwGSi3r/ZlbFl4RuPHEWxamuxur80t?=
 =?us-ascii?Q?ahPLTH6Gnu0z5AGneNGxepRiU2kGVYK8xz5yfeSH9JDVmYRgcxdzb+Qq5jgV?=
 =?us-ascii?Q?Edau7608Qkinnt3cXViFpWcTs6CgHeJSjSr+/yVHNUS2uLXwu+J3KMbtC0oR?=
 =?us-ascii?Q?QyABG3l7tUhatN8Z1987bwlwpIwLFFs/BS4MkZ0Zo4kt+R9TefgrUjIZnVkb?=
 =?us-ascii?Q?O9RnM5R48cFLkndQit+2guzVzygZf5Bgu9DMR9zG8Ys0g4rxUY7RpiMp33vc?=
 =?us-ascii?Q?+5qwpmwtk5vboxShdvoKsLi3fEYGE640q5mnw8gN88YHYH8wsuUXO35MmfZL?=
 =?us-ascii?Q?+vMpYimW9Q/9cfOiKisF5vkkAOmsvJH09BTNayAlgVGYMAXTuxnTSjVnWiqy?=
 =?us-ascii?Q?9MXHpxeaOgMKkhZpiuMGH9ijPfkgC8qMOCR3FTFsIIcaF9LJcM/G3vO8TYfr?=
 =?us-ascii?Q?1uUqbBY3ebA7rflIclgtgH5X+oIQez7CVWmot9OaMa7VmH8Hiu47yR/T3E/f?=
 =?us-ascii?Q?D4z23O0GfjvC2dKxn23wrPIreSwHES2QDk77rfMEY1m73nSauUtrw9dmbR2T?=
 =?us-ascii?Q?wHSRIOxAElkuh49s90Wei18vMsUi5TdvhZryO5k7S2WFNlv6PD0+JA6D0ly/?=
 =?us-ascii?Q?Pwr5qxSnJviR0HnDkZ3+eRqTs/AQeDgrM6mtRfqqUZGGjMwYGBQU6Sh+0IdK?=
 =?us-ascii?Q?UrC5znxmCdm1rXaAQajbKBe47Dr4BpTSGU1OdvvZa//XEolS4vC/aTM6h1Nc?=
 =?us-ascii?Q?+wlFxDl/M+ZiyR+kjK5t1FDEZlqCd5ZKNF2oZGOuTlKehResAi1oQKd9KO4u?=
 =?us-ascii?Q?iLhtwxiZkjEAfPjfB4lF3o4TUdlWodBdb365ygpCMkFJFAsmZHAt0+BDZyhz?=
 =?us-ascii?Q?/Ac8I/578JiX6zrkW6y8FxvSj+4AGB7g7aTfjZ+Hp9CPR1IgP6i1ucbJdPLQ?=
 =?us-ascii?Q?abDwvIFKSJb6f4F3xTcy3R2q9FeCSQrayHi1/jTY+Mu8p1dvqGoPTmI4wbVi?=
 =?us-ascii?Q?0P+w3lHWU60ZsntW+DrxFkZuDfpqaGtslNagjloQHDwdgvUcG0f/xySmh5hu?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ed8b9f-1d90-4c6b-dd54-08dcabb31e83
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 07:34:58.0213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUeyGHLk6FMK1tg2iQ4Wa2FCewUVAr6wK+V9YcHrOzCLPEb4Nx3Iknh+5qbj0QPC6/3EndSoM19j6LFgReXuww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8124
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

From: Lukas Funke <lukas.funke@weidmueller.com>

tpm_tis_wait_init() is using the 'chip->timeout_b' field which is
initialized in tpm_tis_init(). However, the init-function is called
*after* tpm_tis_wait_init() introducing an uninitalized field access.

This commit switches both routines.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Changes in v2:
- Call tpm_tis_wait_init() from tpm_tis_init()
- Use phy_ops for bus access in tpm_tis_wait_init()

 drivers/tpm/tpm2_tis_core.c | 28 ++++++++++++++++++++++++++++
 drivers/tpm/tpm2_tis_spi.c  | 29 -----------------------------
 2 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/tpm/tpm2_tis_core.c b/drivers/tpm/tpm2_tis_core.c
index 680a6409433..1fdf8cfa319 100644
--- a/drivers/tpm/tpm2_tis_core.c
+++ b/drivers/tpm/tpm2_tis_core.c
@@ -419,6 +419,28 @@ static bool tis_check_ops(struct tpm_tis_phy_ops *phy_ops)
 	return true;
 }
 
+static int tpm_tis_wait_init(struct udevice *dev, int loc)
+{
+	struct tpm_chip *chip = dev_get_priv(dev);
+	unsigned long start, stop;
+	u8 status;
+	int ret;
+
+	start = get_timer(0);
+	stop = chip->timeout_b;
+	do {
+		mdelay(TPM_TIMEOUT_MS);
+		ret = chip->phy_ops->read_bytes(dev, TPM_ACCESS(loc), 1, &status);
+		if (ret)
+			break;
+
+		if (status & TPM_ACCESS_VALID)
+			return 0;
+	} while (get_timer(start) < stop);
+
+	return -EIO;
+}
+
 int tpm_tis_init(struct udevice *dev)
 {
 	struct tpm_chip *chip = dev_get_priv(dev);
@@ -436,6 +458,12 @@ int tpm_tis_init(struct udevice *dev)
 	chip->timeout_c = TIS_SHORT_TIMEOUT_MS;
 	chip->timeout_d = TIS_SHORT_TIMEOUT_MS;
 
+	ret = tpm_tis_wait_init(dev, chip->locality);
+	if (ret) {
+		log(LOGC_DM, LOGL_ERR, "%s: no device found\n", __func__);
+		return ret;
+	}
+
 	ret = tpm_tis_request_locality(dev, 0);
 	if (ret)
 		return ret;
diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
index b0fe97ab1d0..7909a147c2d 100644
--- a/drivers/tpm/tpm2_tis_spi.c
+++ b/drivers/tpm/tpm2_tis_spi.c
@@ -188,29 +188,6 @@ static int tpm_tis_spi_write32(struct udevice *dev, u32 addr, u32 value)
 	return tpm_tis_spi_write(dev, addr, sizeof(value), (u8 *)&value_le);
 }
 
-static int tpm_tis_wait_init(struct udevice *dev, int loc)
-{
-	struct tpm_chip *chip = dev_get_priv(dev);
-	unsigned long start, stop;
-	u8 status;
-	int ret;
-
-	start = get_timer(0);
-	stop = chip->timeout_b;
-	do {
-		mdelay(TPM_TIMEOUT_MS);
-
-		ret = tpm_tis_spi_read(dev, TPM_ACCESS(loc), 1, &status);
-		if (ret)
-			break;
-
-		if (status & TPM_ACCESS_VALID)
-			return 0;
-	} while (get_timer(start) < stop);
-
-	return -EIO;
-}
-
 static struct tpm_tis_phy_ops phy_ops = {
 	.read_bytes = tpm_tis_spi_read,
 	.write_bytes = tpm_tis_spi_write,
@@ -256,12 +233,6 @@ static int tpm_tis_spi_probe(struct udevice *dev)
 	/* Ensure a minimum amount of time elapsed since reset of the TPM */
 	mdelay(drv_data->time_before_first_cmd_ms);
 
-	ret = tpm_tis_wait_init(dev, chip->locality);
-	if (ret) {
-		log(LOGC_DM, LOGL_ERR, "%s: no device found\n", __func__);
-		return ret;
-	}
-
 	tpm_tis_ops_register(dev, &phy_ops);
 	ret = tpm_tis_init(dev);
 	if (ret)
-- 
2.30.2

