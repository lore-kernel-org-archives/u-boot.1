Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E739ECE589
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B18CB88E36;
	Tue, 10 Sep 2024 00:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="pZfU16c3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC9B088E3D; Tue, 10 Sep 2024 00:21:31 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::70d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A8F388C31
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVsE/O7DNTP2NLylguu6n2O5aw7pm6L6MtV3O+p5esRHGAgdQFJQm/947JKcYqwv99Mrn/YTy311RmaMKHpMi8fM1y6y/IjyrpA2gyNj3fyVPmkPKLpDdUXMxOr889aKyKA+bSWnwQN4HaSq8TDY3ItmrPD8f97yrUJOe2/eTGu8zQdlds0D45uyCauQyeEJiSSjJtg7AURrVRC4JgLNJXypmMT8g7CN5sczxlLEAWbeOD22iJeFaW9f7BpET9QCsiKClKOiaYdj6AfqN3f+LdqlkHN/eYH61OQOYlKoyz8IUscaciUZkNQOdkTcaSKWWlT0IUc4aB1GS90aLssUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMEdbR1tIcOIDLnabWLvQ0byS5G8RRxni7GI1xoQa/s=;
 b=eLIWraoa1mvY4b1X6CJza+GePRtsxB4xUt0Vmpg8pOmbIcVd6G94r65H32qC5D09CCwGmVwGBFfcodYPteOPMtoGmGX3PZCA5ntFUS/BMdwgci6YMdGqksTR+KVFSpNxbEMOUDvbNl48VeCjuLrf1wFPv84eMkYZXDDmojCGbxW7bzMsfhUrKH+W6e4vgGWwmK8D/hts0cVrXCBbfGfqBGm0fpU39fh8M0rriPGJhuy+0IxPKbvCbXcsiG3A8oFvQAsKx0ogbCCH8HjssR6geb3RZkgg2wE5oeYhgnW23nVWEipbgvvWFekZGPQFxNBYUbKJAhqKvqUTlzsYKwXMNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMEdbR1tIcOIDLnabWLvQ0byS5G8RRxni7GI1xoQa/s=;
 b=pZfU16c3lxN6Zcjqxg6ZioxVVZyuJOACE9P109ZWinFTTii2abd/JuhIkp2q9KNiOsTonSYr+PaTfegE2/v2yChM2fskdqjUHLpuplCVWo1LuxOoV2+amOx/RFOsV4Z7spniWHEeYl6G9lKQgzu+xlU3VTF2bAYW5m3aSv9q1Y4iUCNL6lmPq91PMv97BdsTHS2A9ljN89TD2HTaAWFtF1nA7l1EseuXecwPvMlLSdQaVlUoFosmQM8JoLTmMfyQaT3MqrZ0EcAfSUj+v/nYa1M4ghby+9MN4L9IvlrYdmMYugoMON39Xyvn1XDZsu+kvDmcuNTtCm8+jtorVZif+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9935.eurprd08.prod.outlook.com (2603:10a6:10:401::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:21:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:21:23 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v2 1/3] cmd: mtd: add markbad command support
Date: Tue, 10 Sep 2024 01:21:10 +0300
Message-ID: <20240909222113.2562703-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909222113.2562703-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240909222113.2562703-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6d001a-79a9-40bd-8332-08dcd11dbc77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mUlxxQVky7B+RvEiYfKcxwBXxM326wVil48y4efme0QX/N7aig8cJ04RR/NM?=
 =?us-ascii?Q?DXpPMAU6HKMnFQgotBs0nKNjyTe96IUwvIJkOI/WDYtCftTwUad+gkkr6o/n?=
 =?us-ascii?Q?02anRBgj7vwu3rZKdEvEqnqRIh33EsvtfcbNbPKeZgYIap3gBFfaJQwW5HhL?=
 =?us-ascii?Q?hw4YaSkuneivo4chEyuTFDNZ2sn/3sCkITCBgXmO20p/i5s5twWjyIx0Rjik?=
 =?us-ascii?Q?9HSxwJNpeC8ckZD5XB19Ke0jtj4iewa+8A5aPY7LYmUcTPsl9SuP2E2JNcJB?=
 =?us-ascii?Q?nqOic0HPLShCE0tdooaJqbO8XtuYD8yOVEpJVc1h9MPmUffuY+3+n5A+8wRl?=
 =?us-ascii?Q?2Cg6r8+mrs2ZoUe+56pYY1qv7G2e23Orut35kp1kOPYEzDvpnT/K2ji/HpYR?=
 =?us-ascii?Q?VSGHyuzcM/DAivzg3j6hvWiWWBUHr6HEN6qwKxfUsxOpSzWYSK/FeX+FntGI?=
 =?us-ascii?Q?3adccCe/MKAgzx9gdcdjN9Zk4+lbyEsAbuk0D94Tyh1Xj7dt0lKnEVqGpIbV?=
 =?us-ascii?Q?YnbGuXVlRxr8K3L3QV6VBMemqiUcNjROGnOF2lljxs5QggBGKxOvovbg3w0r?=
 =?us-ascii?Q?XimatD1aAfofRIwQYwDsfeR5o0OrO6Cd51eHJviXr5YDmzWxJRJnlBGHya0D?=
 =?us-ascii?Q?jJku7IAYlV+hR6s7/oTtxlOvJABQi6Bo7yW+SIcTf+8JZC0/6rHkazq+3QHA?=
 =?us-ascii?Q?h4CgISvD2/zk15/X7zxIVWIlkrZqijyP3egX7vSlC5hwtW8JKdbWF9noK0nU?=
 =?us-ascii?Q?ofEfyj0lj8B4FOeIJCUb+e0YvohXgAl6QY7vqJd7FQq53VIu+P3kcKDXfrRm?=
 =?us-ascii?Q?sFL2CeTJeArT0wunN3VdfXoltt8qqazCV8e5v6oKHWe+y51XUU1IBmC9+N1V?=
 =?us-ascii?Q?9gGc5Wk1p4DLTtiUeKE6N4BXdzCpo0QbgE7A3ZFJGS3zvbHq8DwJGSry87Nc?=
 =?us-ascii?Q?7RyGUTXZN6GOWXmfilrkFtMI0Zp3OhpagsL2UWRVQJ4QyaXWfCq6/su7iBS4?=
 =?us-ascii?Q?MD29klmKyyBP7lGSdkk8SMJnoc5KSGq0ylwF7/LjwNELZ6smqAv6BYgK8eVB?=
 =?us-ascii?Q?4YYtvyOKfGtuf9HD5xZdFp+Xw+xl7+nkosDFB45cHe/Bk7Kih0AZ49L8aUOH?=
 =?us-ascii?Q?N5QSxOrNRP6dzkaGudtW2AAv//HfnhyLBlPtBcUm3E4kkf/iFIyCbNgEwVd+?=
 =?us-ascii?Q?0n8TgQ9LuWQOd29GH9vaMwIwaBvmq4YsHbl2qBRdsux4kU/sojEesr32PESL?=
 =?us-ascii?Q?2Y+iRUdS2wZlt5RZOWZlFDB8057/ymAu1zNwyBEL++C2RWINE2mYlEy8B5hD?=
 =?us-ascii?Q?wbyALIMytNln2MX4S+1xeGr1i6dNr0UQMSS8YNK4ypJjlhgMa5wGyHM4EuSX?=
 =?us-ascii?Q?ok+EQdIjCFbmTfSRyWK84dt9xlgt2wYYn/V+E9aG1osrSi889GO1qwKCWFQN?=
 =?us-ascii?Q?OuZ44NN95Co=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cr1uJ3RifOCR7CK+X9BxD6jrGQ6PM9l0UAMPbgS7eVhd+8TmZsnKLfgCnUjg?=
 =?us-ascii?Q?UUgmEJNv61Q7/IsTECcxvaRqHVC9I9LWPfw0bf4f3EIIHW2OfUxdzyAUqXYI?=
 =?us-ascii?Q?tH9K5v7z1PawvCXNoItB0J+3QMZx//2zS5B6bPElYpNSmPniVo5Ps2Bhg8Wa?=
 =?us-ascii?Q?2n2M+e7eMFQKfgpqf4Z0Vzsl/XU0yefrM/2mB6b8amqfVgkIUe7lHoKS68tv?=
 =?us-ascii?Q?srd9wez/ZR462eRu+68njfGaa+M8GYBba9Xh9c26ezx/fuaQhOf2MTi0xS66?=
 =?us-ascii?Q?wK3mK38fLp6Y5cCeNs+fwDR+CgqzOAloJrduiNrxMH+2gbxJardeuHkI+GUs?=
 =?us-ascii?Q?OQHv97xvFR4rdxA2wPvuY8nwUMIUrNsUwF28o54zSor9VUh32MnurKqONDFD?=
 =?us-ascii?Q?/2nLDQkz8c4oDJk0UYodLYOzKMemCubmao86LV8rALrPmdg4uC49Y7MiRR+A?=
 =?us-ascii?Q?h3hkYECLQJ1Wl03xpvxjoSIuO9SPgX6Tbmnk5wNaCy0bx8X90Z3+HwqG7WCP?=
 =?us-ascii?Q?B+TVIvbtYCdJr9mgS3TSAu+jL/Pu0M+vyROUe7UaGyNRtrJwL7MffBDJAvNW?=
 =?us-ascii?Q?UhvIz4eLjgaFDbQqbV9eTeAmsY2vP3sjX4wgOgk8Ld17FtBwJxQlbNXn0y71?=
 =?us-ascii?Q?UBIIJgehSzocOBsxJhpBpT2Thc+0kEQcC2rgXAMRDxLrXZkw3p5oAeziIQsL?=
 =?us-ascii?Q?FRK7Rj3dE7SEBIaSiGQd/Ic5v7P8lbF0O3WurdVeYz9HWe89KNSXGmV41vSx?=
 =?us-ascii?Q?9JSMqf74GMQOg4JTYKfYrRNKExV0QqyMRG/h3AVdrAbS1Iwr2udY5mXXTN/j?=
 =?us-ascii?Q?QeoYw+1YFGiqEKNzBMPH9COCfuugBBlJ3//1vo9Cd9RqgCdFzBQ8Uwz8LsEv?=
 =?us-ascii?Q?Iqe5mtIbBlBbf8Ztfr6WbkB6Ym6Wwk/jeGa114xZJfleTxSRV09/QagCdRea?=
 =?us-ascii?Q?mu29qRJpeP2je3I/d+3RbsRXlcIjtrAo6WDsHlHsE9YuX9MMlfP/0xuA4m85?=
 =?us-ascii?Q?44pUfsoIJFcsfvXDtrS4t3l2G5m8IfYcgciAJecuyeIiv7wymnqr/oyDNxEi?=
 =?us-ascii?Q?16EH8jb7PogHqPS8yJ/ljGHyCXvN70EWTpNQuAt+/FVU2CJS2chaxO95rrlw?=
 =?us-ascii?Q?O69K6EKKG2j6JADVYAQSLcDPCWc47iJYlcU6lB/DrM5WyM0135DBSOSmZQVC?=
 =?us-ascii?Q?OIVL2nnc4uoIoSUXKYVn1z3u9oWhKJoKEpm0QzxWywh7KGgxbfG5GMsBHBpi?=
 =?us-ascii?Q?CEEU5gOb5W2AY9olsqFVAifetODKJdpJeoIyQv+hMBpYyfYZILF/C7I5osOz?=
 =?us-ascii?Q?18bPf/pcM+UhxXyTrysSy6E3F961R2HYaEPjAHG4htehV52XgbdgPcqQghMh?=
 =?us-ascii?Q?KaNWzfifjv+lXoC+FUhe7gYE8d3xYLUs/X1cfjD7HfNMC8S7pSFWCHPP/e7G?=
 =?us-ascii?Q?kvot/cvhKkzsQbvaHldketxyrAYeRvXbUcpdDh5+poRWhY/0QbnEOxOHPByt?=
 =?us-ascii?Q?yPkurSyBEEJjCOKFZiW12SHeac/cvUak5lnZNqs7RNxVacJsKqFjss/FXnpM?=
 =?us-ascii?Q?ox0LY0eV+AlsJ+LmaP3JLUX6eQQiXd3C8I2tB9dBZI/6JMOg4oIEpeV2ngAk?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6d001a-79a9-40bd-8332-08dcd11dbc77
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:21:22.7433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvXlx4Z0KRb3oUtZ4uGOmgzd7/pMA0euP86QNvePqZuuRCdbQzZjdFDGdINELfWpAVub20CU3T7B5IaO9je1BiO7b6vs1t9YTlI2IBUP96U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9935
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

This patch implements 'nand markbad' functionality for mtd command.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig |  6 ++++++
 cmd/mtd.c   | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 978f44eda42..53ebafcb610 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1433,6 +1433,12 @@ config CMD_MTD_OTP
 	help
 	  MTD commands for OTP access.
 
+config CMD_MTD_MARKBAD
+	bool "mtd markbad"
+	depends on CMD_MTD
+	help
+	  MTD markbad command support.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index 795aaa2b37d..45084d39d3a 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -691,6 +691,57 @@ out_put_mtd:
 	return ret;
 }
 
+#ifdef CONFIG_CMD_MTD_MARKBAD
+static int do_mtd_markbad(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	struct mtd_info *mtd;
+	loff_t off;
+	int ret = 0;
+
+	if (argc < 3)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	if (!mtd_can_have_bb(mtd)) {
+		printf("Only NAND-based devices can have bad blocks\n");
+		goto out_put_mtd;
+	}
+
+	argc -= 2;
+	argv += 2;
+	while (argc > 0) {
+		off = hextoul(argv[0], NULL);
+		if (!mtd_is_aligned_with_block_size(mtd, off)) {
+			printf("Offset not aligned with a block (0x%x)\n",
+			       mtd->erasesize);
+			ret = CMD_RET_FAILURE;
+			goto out_put_mtd;
+		}
+
+		ret = mtd_block_markbad(mtd, off);
+		if (ret) {
+			printf("block 0x%08llx NOT marked as bad! ERROR %d\n",
+			       off, ret);
+			ret = CMD_RET_FAILURE;
+		} else {
+			printf("block 0x%08llx successfully marked as bad\n",
+			       off);
+		}
+		--argc;
+		++argv;
+	}
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
@@ -773,6 +824,9 @@ U_BOOT_LONGHELP(mtd,
 	"mtd otpwrite                          <name> <off> <hex string>\n"
 	"mtd otplock                           <name> <off> <size>\n"
 	"mtd otpinfo                           <name> [u|f]\n"
+#endif
+#ifdef CONFIG_CMD_MTD_MARKBAD
+	"mtd markbad                           <name>         <off> [<off> ...]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -807,5 +861,9 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 					     mtd_name_complete),
 		U_BOOT_SUBCMD_MKENT_COMPLETE(erase, 4, 0, do_mtd_erase,
 					     mtd_name_complete),
+#ifdef CONFIG_CMD_MTD_MARKBAD
+		U_BOOT_SUBCMD_MKENT_COMPLETE(markbad, 20, 0, do_mtd_markbad,
+					     mtd_name_complete),
+#endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.45.2

