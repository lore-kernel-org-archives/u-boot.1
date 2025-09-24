Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A34CAC59A
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 04:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE6DB83447;
	Wed, 24 Sep 2025 06:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ORRJ/Z/L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B93683447; Wed, 24 Sep 2025 06:20:52 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7942833E9
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 06:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bp2SqalEo2ombl3A0B3opykywHeOjMg1yLxPei4Ib2Gc5A0xS/4qhpNMZgO/JQ5zb2ceSuLidhOnywpCLBB3RHbHNUpTAeAOhHwsZ6efF2j7Uwxya35oOrhHSc4YL5Q9M+w/cwKGqaR9btIKi/RM26R0MoLavnj1oYLFu9QqxvhHPWApW4wDsP9qhRT4jgEJzxLAhAqpVkatabysRxo338z6wcF/CwR3Znhf+zrqCBwz+2ZMUAWn/xBqO5NsxzIiAzYG7OoDkd9uxo5jSUAVo+eQexds2+THsXldA3Zc34UnvvmaqgRYJlYMzVm84gdIsOiGh+4jRagXuqbQu5yjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fb2XFzElTh0vSY2HbfVbtF+RAIRXOUNUruC7C+hKeHo=;
 b=tGouzBh+rZstHLhM7fRgSN4XEMAnWHZIf+stG7RRxI5xamLRCigRhXuvmuKOCQvqZBHqEy45/LvQo8Nrjsu/X/GiY9mgMA7Gdpf/B1I8sZ/Q5hBxxO6N0eTDIPtxpgZ5xz0JyCSJ4XFxS8USlaRtIqNSPA17YtqiyAgJ1KYdO5N3WjMy7mvvBmW+DBc7sioTy7E9FyIAnmRSfw51O7ueGODjGo+Cfuji+FixHpmKd/LtNevgBG+eF9/8YEPDGQeD7THEcKovxoygYRjY2Z7ot61br6w8uP2LTF3GQKLi2o0Q88gsxh3SlkypeA11qJ3Xuau1LtSx4szsDD4rv8mAvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb2XFzElTh0vSY2HbfVbtF+RAIRXOUNUruC7C+hKeHo=;
 b=ORRJ/Z/L+hw4pNCf0e17YqgYIcc+Upy1bW/OMSAF79G+LzW+at1b41NTxkrLuBFzV3lMZVvisf8YaeRh0soK+AIYXxN4/HeVjz1pzk1FC0hFcdaXGtq4vCAntWqe86E4LEPxN+45iQZff3tSwGXiceoIaxj+pnzO9EWbDJcubOa8JWboV25fcw7Mgn3xASptg5iecmaEFi7yGhQX1iO4ZQHvJyC5ow6VfOZcVchjOXSB0vzok/dB+lKlqCnLsTGDJQwD+sasK03a7Mow7ddrbfAehWRNFSlEyASK5Ka2iqPPM470OdYq8ihXdOQTNgNR4cBa1lwFXIJcrswWOHURIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB7552.eurprd08.prod.outlook.com (2603:10a6:102:24f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 04:20:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 04:20:45 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v2 2/3] cmd: mtd: add nand_write_test command support
Date: Wed, 24 Sep 2025 07:20:32 +0300
Message-ID: <20250924042033.1873771-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924042033.1873771-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250924042033.1873771-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: cb28ee36-6b2d-487f-ca78-08ddfb21bb68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?es95YMJPo312tFqdxYf943FGFPLQhmmiVAvMdDps0FcosEYyf2hxx40TXSOT?=
 =?us-ascii?Q?Xryoi1GnnZr58NBvWpaU8Jrif0yWZgpiAXciUFDd3PKejTH/fc2zYY/ku7NO?=
 =?us-ascii?Q?bcYgiLnJshsDbSxtPBOlrpgCZVyyBZlQbiu9l2dO0jsNWceXCIGHOdnCd39q?=
 =?us-ascii?Q?tfRmLaIJwWUzY7pJaK6eNJTF29GjhIbuWW0i4tRrUbbWG6wFd8u9+wB2Y4TI?=
 =?us-ascii?Q?XULKJoF1oulrFGPVH9wtDwY3V/pIhSHALuf7bc2VLkeenL3hgsASNbSSlGsj?=
 =?us-ascii?Q?5amGn6+GBItQyJjSvfaB+sLqSAXtc8srFB+omxys97iVHA3kohGrjCkkasMK?=
 =?us-ascii?Q?R62Q34p48wOesE8xH4fA0W2salw+fDLxeQjUiE4ppn2uvKcRu8fJcGrgmOc7?=
 =?us-ascii?Q?/G4weJBynRd+vR/o7g8bMsq6ainLLkhsweFhw9Xs1jNFcjyy4K89hSBisojQ?=
 =?us-ascii?Q?4nyp+rxde0y7Xsm5EoZXHmvUD4tYyZr01XR8u2qimqNiJLYEo8BvHUZqN0pC?=
 =?us-ascii?Q?3p960wJDC++xH9b1x5qIKZiKzCFjiwdy1oN8bE6Wx/dWKjcZcUqa8o6BPrhZ?=
 =?us-ascii?Q?+SNjZzvV76UBh4eca+iNGp0BYiHau4h5trdr/Eay1o1Mk9MKCN/K7uMTvJkv?=
 =?us-ascii?Q?hUYAcWQDu4E6x9gnlncxbioDU7dN92cXVgfq3ITwZjt29LpC2ff5Io1sRnzu?=
 =?us-ascii?Q?AGH4HWv1GhGiOSAIK97TkXCmmSYO5QMY+12ZSUon3X82cl8cR3QSi5vrhtz+?=
 =?us-ascii?Q?ZyyWcqVWV/dgRfzh+M8mDhkTx5Xr6Uuh/OeFcwz0IZclvDivN71fXvqZj2fW?=
 =?us-ascii?Q?N+mJlW7kpcOj7jhl3flXWdh8slbrBvuCS0+YywQFGMOJ59Q4Anay+bOhvmoK?=
 =?us-ascii?Q?E6QoukDxMi7/jCBNRfG9I7pH3RvYj29x9Pqtzw1C0cqrynP9zKW/M1ZegJai?=
 =?us-ascii?Q?OM11RchXGoix/oqHjefti4OfNaxoEaxkGGoc1hgNpYELfelJnKYay+BaibPp?=
 =?us-ascii?Q?nCTC8fb+Twp2t+QRf7YiQU+e90SKZGoA+m3y35417EoDBgq2EJ8La2J9+7o8?=
 =?us-ascii?Q?Sk8VWFNg8maFV/QsL+hSnnSC/zmr8iBFaur7+cLrUqKdNrmTUegrs6W9/Eam?=
 =?us-ascii?Q?PTsLGhlPJsSOmy+zU6//P+z21NiEOVZEmmHlRmX538bYtjOOTFPgV92cI35b?=
 =?us-ascii?Q?6ngAuXLDc9rpL49dxmnpDi5M9zuqi7Dl0xmbYLA2ZPmflXgazKFdpz6HlLO0?=
 =?us-ascii?Q?V1NiIClblZgzDua/1olGFF41uYalz4acUX/qWPhpU7lruhu8xIzzBiNQXTAD?=
 =?us-ascii?Q?AXbC/rghId7oA4dC5+rFQ1H0/MSDJh65/2bRcnXmbQFJFJn8eYfQ7QR7YGxu?=
 =?us-ascii?Q?S1tczXh1xm6SNYKzS94MGzc3k6D1PIZaauBixtmz3qga6V/tiKGkUCDsa4+w?=
 =?us-ascii?Q?bjfttQ66tHCFOwZ2Pf4JaKAk+wFXrlg+cim50DGE1XuuDpDjsfYkbWwmIaHt?=
 =?us-ascii?Q?fLJwu2zhpQzEw7o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XHR0Kzq1PK2LX615YwpMGJ791vzQEvfBOiIjtkCBsCWtgsBys7xqPH0LRIbl?=
 =?us-ascii?Q?KmAElifAG0mWdhJdNp0JSXN7RzABmNx+u3bPbAFQ0b073xnXKKKnq+RcEv6u?=
 =?us-ascii?Q?jnn1yGfeURnWasSBdtoowJVEv/EcmjHXvJH3JB7tY+DgnBJp9fFPBtAXHNse?=
 =?us-ascii?Q?BZUCawIIzsD9yDPM4nDR8vWVcnICKNe0KL3c/u251R+VJoms0do2cMdgAdx1?=
 =?us-ascii?Q?WxmyC7XgPPCRUyMHd7CD/OYa4LbQJ+rRU91LNhwzERtG5hdpifqNLGzt4Tgy?=
 =?us-ascii?Q?gPGX0c+z0VdVmvIjVSWYqkS4iP2uWwAh8oWGJ/1KUUDbFEvGz+3Oec0PBSSt?=
 =?us-ascii?Q?2mcZWtuOhN3HXTyzuKwv5XSxyG4eWgXVaL1IMZUse3UWtKpUhw28VB1eqyTJ?=
 =?us-ascii?Q?qEJFFJxwl71ZXZUJvqI5I/9E2el3OAAnm1rGienyMYaiyTW5u4kQsOaOlPcR?=
 =?us-ascii?Q?z1bQLCAPjzFIiBA85ziNAS8SFyE4jRpOv7zMA3DpnbcmNzCHtMSqpSdYKRrw?=
 =?us-ascii?Q?OxV5OdfdseJWjSiXG1N5Y5LdxevVUZTut9iNCkolrxtMVGetK3CH5psBfjWI?=
 =?us-ascii?Q?yq1cYZuPgQaHcAlY81MnYrBhXXRnR/RQEGTaPbzakV13whL3M5uAVeNU2iii?=
 =?us-ascii?Q?sCK5YjxD4zjMUEYQTF67EIC0hJ/9zEXc80eR0g2WT4KiCQWl8tfXEqxTWveW?=
 =?us-ascii?Q?opeqJmMfNUT6ThVL3PruIRINm0Z22zndMXWdcfbW/dRe1pynRhbP28oTFl4y?=
 =?us-ascii?Q?2BKwVpwdMKUanQTNK/XEWJn3BZpTZDyRoEfuveV3bhOung31TlFRC4H8A+Zi?=
 =?us-ascii?Q?NqDeYe2YyeWfcwPQ0Z1irGf3Zaid3KxbvgLqgQgVGLhRrVOBs3GtBg8tde2H?=
 =?us-ascii?Q?b+TmkilA498kZ7Kf2l97mIZ1QBrocykz1nGhapIwuDnG49liexUGtL8JoL5g?=
 =?us-ascii?Q?wTTI0McIZySH2YISKoFLyuETSd3UeNVjbFrpsRS3FTkqHKwtKKiKjo33GIn+?=
 =?us-ascii?Q?gP311+XJ4SfNTeztYiSYSOzkSphpdM+XoyCJQnqGFhtmOks/91nVzKR8yxux?=
 =?us-ascii?Q?pw4pSmpEOvfQ2lqRI5f2ZC/NoYrD4ceHZQ4G8tf5VYxKN1N5KW1LgXBx7xg4?=
 =?us-ascii?Q?zE74xcuxrKF/9WhjlUSEnrFc81oFhzdnDPEBJEYo2wbf0J/SXTLsm/PF2eEi?=
 =?us-ascii?Q?NL8pMtwbCJsSl8lIXCzBTiTyw284V2KAQGPTfJ9eHdtW8e4Bt0c6cHNcZvu/?=
 =?us-ascii?Q?n0uJ4WJ2f5uf+Q83NvwHgnOP+qs4fk0hjPQoxzniFyJUrS/ECh9rciYox+C8?=
 =?us-ascii?Q?VsATaTWd/MTmFNCb7a7KZaQDndSUAMD+6fPWcObpddPkFaXoOHs8MksIMo2Q?=
 =?us-ascii?Q?tDJnfzgwbjIHyb8AomRTQmSjdAxY4/k4399bdvS7crmfXTRdrjJprLDf9QTh?=
 =?us-ascii?Q?SP2IZZF/FTsfnsL5xbPmKsLqvq+RuPBSMAaT8BZ9AzOzPHQWiImxcKIuIx+T?=
 =?us-ascii?Q?BERPYILx8PSQT/NM5d82E0Ta/xJr1dEoj6gWjBlqH/TgjJ/4Du6lpZbnuxC8?=
 =?us-ascii?Q?17HG6IMHsXLKo49acdoK59maY8hbCqyY3sPa1xtRbMJp2ZWOqbNbQCV3vpEN?=
 =?us-ascii?Q?X3SVG2r0+L/ju4ZOUm3Opk8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cb28ee36-6b2d-487f-ca78-08ddfb21bb68
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 04:20:45.5413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkyBbYhy2ZUkBtZDLUBkN8Jp/aHoPgu1QojH5pzomvuLjL/oWLpxo5QQquah7uonJYeZUJ98rW6H+cZW1v3Lu2O0Zz2IS8qLv21YisBBOUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7552
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

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch implements 'nand torture' functionality for mtd command.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 cmd/Kconfig |  14 ++++
 cmd/mtd.c   | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 211 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 8f2a35d780b..cd1a664f34f 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1519,6 +1519,20 @@ config CMD_MTD_MARKBAD
 
 	  This is a clone of "nand markbad" command, but for 'mtd' subsystem.
 
+config CMD_MTD_NAND_WRITE_TEST
+	bool "mtd nand_write_test (destructive)"
+	depends on CMD_MTD
+	help
+	  MTD nand_write_test command support.
+
+	  Writes blocks of NAND flash with different patterns.
+	  This is useful to determine if a block that caused a write error
+	  is still good or should be marked as bad.
+
+	  This is a clone of "nand torture" command, but for 'mtd' subsystem.
+
+	  WARNING: This test will destroy any data on blocks being tested.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index 95e4be9863d..4d69c7b4915 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -20,6 +20,7 @@
 #include <time.h>
 #include <dm/devres.h>
 #include <linux/err.h>
+#include <memalign.h>
 
 #include <linux/ctype.h>
 
@@ -762,6 +763,194 @@ out_put_mtd:
 }
 #endif
 
+#ifdef CONFIG_CMD_MTD_NAND_WRITE_TEST
+/**
+ * nand_check_pattern:
+ *
+ * Check if buffer contains only a certain byte pattern.
+ *
+ * @param buf buffer to check
+ * @param patt the pattern to check
+ * @param size buffer size in bytes
+ * Return: 1 if there are only patt bytes in buf
+ *         0 if something else was found
+ */
+static int nand_check_pattern(const u_char *buf, u_char patt, int size)
+{
+	int i;
+
+	for (i = 0; i < size; i++)
+		if (buf[i] != patt)
+			return 0;
+	return 1;
+}
+
+/**
+ * nand_write_test:
+ *
+ * Writes a block of NAND flash with different patterns.
+ * This is useful to determine if a block that caused a write error is still
+ * good or should be marked as bad.
+ *
+ * @param mtd nand mtd instance
+ * @param offset offset in flash
+ * Return: 0 if the block is still good
+ */
+static int nand_write_test(struct mtd_info *mtd, loff_t offset)
+{
+	u_char patterns[] = {0xa5, 0x5a, 0x00};
+	struct erase_info instr = {
+		.mtd = mtd,
+		.addr = offset,
+		.len = mtd->erasesize,
+	};
+	size_t retlen;
+	int err, ret = -1, i, patt_count;
+	u_char *buf;
+
+	if ((offset & (mtd->erasesize - 1)) != 0) {
+		puts("Attempt to torture a block at a non block-aligned offset\n");
+		return -EINVAL;
+	}
+
+	if (offset + mtd->erasesize > mtd->size) {
+		puts("Attempt to torture a block outside the flash area\n");
+		return -EINVAL;
+	}
+
+	patt_count = ARRAY_SIZE(patterns);
+
+	buf = malloc_cache_aligned(mtd->erasesize);
+	if (buf == NULL) {
+		puts("Out of memory for erase block buffer\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < patt_count; i++) {
+		err = mtd_erase(mtd, &instr);
+		if (err) {
+			printf("%s: erase() failed for block at 0x%llx: %d\n",
+			       mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		/* Make sure the block contains only 0xff bytes */
+		err = mtd_read(mtd, offset, mtd->erasesize, &retlen, buf);
+		if ((err && err != -EUCLEAN) || retlen != mtd->erasesize) {
+			printf("%s: read() failed for block at 0x%llx: %d\n",
+			       mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		err = nand_check_pattern(buf, 0xff, mtd->erasesize);
+		if (!err) {
+			printf("Erased block at 0x%llx, but a non-0xff byte was found\n",
+			       offset);
+			ret = -EIO;
+			goto out;
+		}
+
+		/* Write a pattern and check it */
+		memset(buf, patterns[i], mtd->erasesize);
+		err = mtd_write(mtd, offset, mtd->erasesize, &retlen, buf);
+		if (err || retlen != mtd->erasesize) {
+			printf("%s: write() failed for block at 0x%llx: %d\n",
+			       mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		err = mtd_read(mtd, offset, mtd->erasesize, &retlen, buf);
+		if ((err && err != -EUCLEAN) || retlen != mtd->erasesize) {
+			printf("%s: read() failed for block at 0x%llx: %d\n",
+			       mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		err = nand_check_pattern(buf, patterns[i], mtd->erasesize);
+		if (!err) {
+			printf("Pattern 0x%.2x checking failed for block at "
+			       "0x%llx\n", patterns[i], offset);
+			ret = -EIO;
+			goto out;
+		}
+	}
+
+	ret = 0;
+
+out:
+	free(buf);
+	return ret;
+}
+
+static int do_nand_write_test(struct cmd_tbl *cmdtp, int flag, int argc,
+			      char *const argv[])
+{
+	struct mtd_info *mtd;
+	loff_t off, len;
+	int ret = 0;
+	unsigned int failed = 0, passed = 0;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	if (!mtd_can_have_bb(mtd)) {
+		printf("Only NAND-based devices can be tortured\n");
+		goto out_put_mtd;
+	}
+
+	argc -= 2;
+	argv += 2;
+
+	off = argc > 0 ? hextoul(argv[0], NULL) : 0;
+	len = argc > 1 ? hextoul(argv[1], NULL) : mtd->size;
+
+	if (!mtd_is_aligned_with_block_size(mtd, off)) {
+		printf("Offset not aligned with a block (0x%x)\n",
+		       mtd->erasesize);
+		ret = CMD_RET_FAILURE;
+		goto out_put_mtd;
+	}
+
+	if (!mtd_is_aligned_with_block_size(mtd, len)) {
+		printf("Size not a multiple of a block (0x%x)\n",
+		       mtd->erasesize);
+		ret = CMD_RET_FAILURE;
+		goto out_put_mtd;
+	}
+
+	printf("\nNAND write test: device '%s' offset 0x%llx size 0x%llx (block size 0x%x)\n",
+	       mtd->name, off, len, mtd->erasesize);
+	while (len > 0) {
+		printf("\r  block at %llx ", off);
+		if (mtd_block_isbad(mtd, off)) {
+			printf("marked bad, skipping\n");
+		} else {
+			ret = nand_write_test(mtd, off);
+			if (ret) {
+				failed++;
+				printf("failed\n");
+			} else {
+				passed++;
+			}
+		}
+		off += mtd->erasesize;
+		len -= mtd->erasesize;
+	}
+	printf("\n Passed: %u, failed: %u\n", passed, failed);
+	if (failed != 0)
+		ret = CMD_RET_FAILURE;
+
+out_put_mtd:
+	put_mtd_device(mtd);
+
+	return ret;
+}
+#endif
+
 static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -847,6 +1036,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
 	"mtd markbad                           <name>         <off> [<off> ...]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
+	"mtd nand_write_test                   <name>        [<off> [<size>]]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -884,6 +1076,11 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 #if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
 		U_BOOT_SUBCMD_MKENT_COMPLETE(markbad, 20, 0, do_mtd_markbad,
 					     mtd_name_complete),
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
+		U_BOOT_SUBCMD_MKENT_COMPLETE(nand_write_test, 4, 0,
+					     do_nand_write_test,
+					     mtd_name_complete),
 #endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.51.0

