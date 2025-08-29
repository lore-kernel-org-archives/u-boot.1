Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485E7CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 07:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4F87835C7;
	Fri, 29 Aug 2025 09:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="rFN7b8Qb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31F8583487; Fri, 29 Aug 2025 09:59:25 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 462A68352B
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 09:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxCxjsLDC4I9/9K2s9hSboYmBztTA4tDqYwfUrt7oe8NsfQ4ZL+VpoW8YHmyM0EP4SaqQ/EE7T+yVEiHQMvpxZIy5r+PmH2RW0fDD6agOPiAE/UXO0J2NWwfrsVUrXR7psonS1nVkKZPRWoBt+H9OubERViM6kReSBp+CsKSVolhUodTwbh5CaBJ/c92rGptv9uG2BWvPiJU3xV7+lmFBRRCjJ91xCz8s4ZbhXRtMH9l6iOrUynJrZrVQdgl5yR7ylzNJpC9le8uTurbIPA229RD24n61mYIgjITztmdclF42Jmwrv/Cs8i2cW8GZZo2qbyWijPrt1ToDx69GFghWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1BlP7b5EcRQW6EJxRe8ZfFufBhBz54w/esfM5bHTe8=;
 b=oZaRt2Vj3Ek4VivdO255js9OQAE9R7bmBmM9OSosEuNxj81phg/5jQfCIucCvLSHZO/HY2ayqw5c5Y4d8HgyOgIpZUIN4mvgDHtXXrc4Bv0rP486cIxiOx546q9pmXK2vOrIn5D7iv1T/oc5Aea41M1sgT+NdRy2YosB6wK/4w28IttIumS2fh0HT/8u0a4dBwYOmiC6OO802LIIejjApZtIlahHNuunYB0E/vtlpAGLedLX5HGrml0RjUBe8qXzzXTFlzg2DE93QTx3RBeaWRniFVejUy8XSUFqn39UG4zupMtEFBwbAehKE0UJ0cmAcUtHttegl7htpJUgV4U1vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1BlP7b5EcRQW6EJxRe8ZfFufBhBz54w/esfM5bHTe8=;
 b=rFN7b8QbH1Ovu3wqFy5fP0a5dtn+IV+VlMPK+Zgc6jd3o5T+FDi4e8meOQhzfAWRn38BCqLBiYVocdzoqs/pBJA+sHe2Qz/PzlsUf68KoyhcFzGkpm8SVSJ5Pqtyin/LLbe5hkdTx0WAqKoAeIuiKGlR5xN3WumnCHpIf98CGTvbXPFEV4Lum3+3TJ4rVBtLHkvAbVNXDr66UVPNAfHq03459vLmeuGrdzE3p55EDieLgiG3O47vZs2xnm4xJoS0w4oZqfA1OHqi3ZG90w74zcjrnr6yXI1Ak+C2X0q3ENP4K09Bye+evdP5ijj5/zn6QPrIQUXgGG7Ju5j7Tksdfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6589.eurprd08.prod.outlook.com (2603:10a6:102:159::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 07:59:22 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Fri, 29 Aug 2025
 07:59:22 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 2/2] cmd: mtd: add benchmark option to the help
Date: Fri, 29 Aug 2025 10:59:11 +0300
Message-ID: <20250829075911.2895683-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829075911.2895683-1-mikhail.kshevetskiy@iopsys.eu>
References: <87tt1r6api.fsf@bootlin.com>
 <20250829075911.2895683-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: 31095621-08dd-4d65-0b97-08dde6d1f66d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XW5m5i7jcTzmEjSHiorw5voxIKIFRTIkrEUMHZwg/viG1FS++my7FzH60CBU?=
 =?us-ascii?Q?uQGGdvOWzwFJYXUgMLqRqMhTTg85Rpgd9jgWLLdjEmy5V0qwFZQ2RJ5N3y3J?=
 =?us-ascii?Q?jobFX6hyBSZzfSpSq3vdFnppCtMy2eNqzGS/FOgIg7o8xGAAauhqZB1KrMa1?=
 =?us-ascii?Q?pH4RgpteiI+2p+A+DLQThDlrIqLbtKK+pVrdQpoe0QpwT+KXLip3bmYrmEax?=
 =?us-ascii?Q?NnnrWu5mt0V1S6S1Finlzecp8e8lTgEXOBnxZVAnHjNnRLxH6AYiUA9bYeAC?=
 =?us-ascii?Q?ll2Ysvak7gJ3mfCnJx7dTsuskXCwNHTJxEnny6l3DpuUolHpSg6oxffHT8UZ?=
 =?us-ascii?Q?E6I0iKGvhcP6lDUtgWHoub71/qrMUSZfSI0Q8wJBzy+zg+o3dfJPSratJ/DU?=
 =?us-ascii?Q?PUFwgr35Tr8wGPQ4ZO7GFwOs1R4Gb4wVS8qE8O5lHnwyEDbb7gKq8mMo/S+3?=
 =?us-ascii?Q?RtboAwn19NEBRyPTWpofImsviFa4/ywp/RKXKBiWZ/ZmHF9fXMP/pREk3TkU?=
 =?us-ascii?Q?WTFCrv5MF2nYv3xyl0cx/S8u/nYp0yMPF/49I7gG6Va4QXNMsXU4wGgtjh0X?=
 =?us-ascii?Q?ECQZDy/p27TXtZ1TRlvG2JQw1TFzeoUB8Iui4VXc8Tvef332Ka5sJsdrQq1W?=
 =?us-ascii?Q?IW43GZwH68uUCIeTtaAsYaeDEp75NI8PFmCdiFapzbxV81R52cDrSw6ZpXW6?=
 =?us-ascii?Q?kDZJN8QDC4GiYDchJWDumlfbpUYqL2Og70XZm7mKC8Cna99LRxpO4G/XL3ja?=
 =?us-ascii?Q?50ZwaUdR/PyDgOqYzmvA1OrMprhj0vqUvw1joQ3yCAgqHVx8UbxTsHCUaZlj?=
 =?us-ascii?Q?542baW3zvK7b0s17G0phRz53nmYviRtVdxJJcEmRKoQm0qewteKXhmKKawtC?=
 =?us-ascii?Q?PiNg50Czj0vplQuqhfXx3Z42uREG+xT0W+woErkFojuXcV/gJGITgleROnhX?=
 =?us-ascii?Q?akUsoQ7z0Ov86f3nD6UF13tVvhajHzP1g37gvtAG+Yu11NoueOcGo8CgUcbm?=
 =?us-ascii?Q?1yoJObt2sIhpn9YfwT5W3O3lskNsVUn5eN9xUQOUuyecXU49p52MFPFpWlMS?=
 =?us-ascii?Q?nGAYE5O4BHCQebvK3ymvOgQ2lsfYF9e073QbHzvSkKApAsqQ/b8m6VzCNfM9?=
 =?us-ascii?Q?KSm9iI0WlD+Y8zuCftSRr7rrWfVE7u+G2VoelKyvrkKrGC/xF9Fio919j079?=
 =?us-ascii?Q?gehmi92VVu4PN8ENF6w4JGF3QMbiP0aFYhOZAu7gFmkeLhwggwgdQmrXwjWe?=
 =?us-ascii?Q?RCSJTzK+iaKlv3iVYKRnvSusMEc5Bb4rZ7JpQc+59CIggU8V4Q/g5bBen4oI?=
 =?us-ascii?Q?VqdjPpXc5W73DpcOzy1Yz3WtHEv1Xj/O2OGvq+JRhR+9my9I25MyjukN9tF7?=
 =?us-ascii?Q?TWWuhXu7ujkBN5RFKouQGWBiXZzrVye7zKCWLodl7tnrLGfeEGmpnwa42nGe?=
 =?us-ascii?Q?1MqFKI5jxMqVtK8haQb4HlCLEfmRkY6Foroyc/vJPjybXKde7ewsuA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cYeqdRFaTiaWC4y06DTlJy/i993s1LzIIKw5C2kVkWjeQDWMG7A1iv/UvW1n?=
 =?us-ascii?Q?QgTgernLaKo2g7V2yLsCXR6CqKqgTsqjuC2U1RHrTBLv/Z0rZcxXzimBpj/V?=
 =?us-ascii?Q?eMXioGTpvOPrAxdSvZ4u4ru5Q9YQxzqdhhg89tWFz3bXenY82elb05c1hQwl?=
 =?us-ascii?Q?FaEYg9lcm28dpvOmsHZTKGG+MayrhyDm5tX6sAyOC8c+CK+BMcS7cNeXM1rg?=
 =?us-ascii?Q?I/80FIVmz116XQmknMzHnVpu4SLaqohit9nMHdTqVMv8cC72vfJPtOu8azFX?=
 =?us-ascii?Q?yrnEAO2WkNjyr4v3XrcPJjtN0W5izXWrzkNagMWgo66wX+h3pLRFED2IL7a5?=
 =?us-ascii?Q?pJx4AX03sDTx2gWIluJNadppOq5nL+pZOqMeST4TaIuews9w/Ipa5y3iv43b?=
 =?us-ascii?Q?SVhxsBVjAf2e38QJZ/C2dfg8SO2ydRA9k00L/KaOAfz8oMRJBd4u6WtB50ui?=
 =?us-ascii?Q?eEo52GmRz2OG2umf3ZTFDWZbYzSWfy+p44eNVVdHhcJE9ySJeahnGU5ovEF5?=
 =?us-ascii?Q?CcFhU9yujc+gmiTz9VwLIevJi+uIEX1faeNoXrURC0Dlx+po6w5ZEJOhxBHp?=
 =?us-ascii?Q?reuGiGr8uyJj0BFx9i0AX9keptqcHFAaaVo1c46YEQ/pTcki9pV1TIwqHcr+?=
 =?us-ascii?Q?jG2y0cqfMTihfWeO3ih9Mtuc8h72HRIQUV+4N0/7kAB6NDVntoe9AT9Cot4M?=
 =?us-ascii?Q?dtYGd507AI6C/qB8jCv76eXn8ZvWE9+8eG8o9+y8v136/uf4hf014Du3pK7F?=
 =?us-ascii?Q?BxFeQYZ9x72+b5KOsmpZtGRhMiMRwhYuAB4Ux5DmBSjq+f9ASczKsaGd4V7D?=
 =?us-ascii?Q?lIm8v9z1X9rbcGhZtbrMatkVepb+r1x30ZyxeY++Q6OYa07dr8jTnls7fqVW?=
 =?us-ascii?Q?WfXN0Fx886twf3CzGg32/hv2aVgnWTb88bdDOzq6WNcEWrbbc6Do7gg9lseB?=
 =?us-ascii?Q?vEBu7m0a7Ne4QCogkSVL0K66zGmnwgeYvRNnbQoadrQbqZzr7+qALTQkY56y?=
 =?us-ascii?Q?mYg4Jbi/Y5gRE/3yVp2zGDEtTSmhvIL1t1bVjEBoTMkt1y5qRT/NgEEeMfsE?=
 =?us-ascii?Q?f5sQyFalxuF1zAA1S/jhpOayrE+eKgt+Lhda3Zx+XnixzhqSTsXsWdjEghvj?=
 =?us-ascii?Q?pemzeGjDQaFUIYS0fkZoH9Pobl29xBwNB1bT/Vx1MltJ0nP5/W1nkz2lvLBU?=
 =?us-ascii?Q?gL11aIr7orzjsMfORNzY4ZUE5gowgatFy0TEf1ASR6R7JgU54dwCHgRKFCf/?=
 =?us-ascii?Q?WEld8xAIy2H9FqLlVQAdRhW/niUxxTpBuNwZMcmye846/kFeM/x6AVGEN9n4?=
 =?us-ascii?Q?M+twnTiuAoSCNNXLa0tGK3jbYqaBnvZu7PM1E2Kk5SeHKXyeTUbR4y1Y3Mci?=
 =?us-ascii?Q?HzuYIE8Erkgw9tN4z/wtCrNRdUvwkh/OIxbUMQhcLBhc30xjToSASJzIPWzT?=
 =?us-ascii?Q?e1kijmWy/pqEdbyWfR4x2HTDfte7Ua/peyDtVVoElYi6nP9Gt+s9bfrSxT82?=
 =?us-ascii?Q?YMzrWD9qbttuRprGUVx4iYd7+X/vaBgb/UaC67uj84NzJPt30hzgbTrBqRQL?=
 =?us-ascii?Q?UlfoAXgrcy0LjDwtGLmBYnV3fN0Ifqpn35N2SiJEEMghEoQThvoC09b5piPq?=
 =?us-ascii?Q?F8iPjrBghmYrznxiINYAAbs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 31095621-08dd-4d65-0b97-08dde6d1f66d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:59:21.6052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HK7RDYOGn8azY+cHZ9N2kNzZ6U2WJ9U0tYSpbuJEnAVerAUWUgZolPMFmq5gaM3smDdH+o6veoAdOn9ZLa7ccUT0Qjdv1f208Jp677lLPFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6589
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

The patch adds benchmark option to the help of mtd command. For the
'mtd write' case the help line exceed 80 characters. Ignore this issue
as modern terminals are capable to handle more characters.

The patch also formats other command to make sure all device names
starts on the same collumn.

Fixes: d246e70cf81d0 ("cmd: mtd: Enable speed benchmarking")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/mtd.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 57f6c700f1d..f053dbadd78 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -782,18 +782,18 @@ static int mtd_name_complete(int argc, char *const argv[], char last_char,
 U_BOOT_LONGHELP(mtd,
 	"- generic operations on memory technology devices\n\n"
 	"mtd list\n"
-	"mtd read[.raw][.oob]                  <name> <addr> [<off> [<size>]]\n"
-	"mtd dump[.raw][.oob]                  <name>        [<off> [<size>]]\n"
-	"mtd write[.raw][.oob][.dontskipff]    <name> <addr> [<off> [<size>]]\n"
-	"mtd erase[.dontskipbad]               <name>        [<off> [<size>]]\n"
+	"mtd read[.raw][.oob][.benchmark]                <name> <addr> [<off> [<size>]]\n"
+	"mtd dump[.raw][.oob]                            <name>        [<off> [<size>]]\n"
+	"mtd write[.raw][.oob][.dontskipff][.benchmark]  <name> <addr> [<off> [<size>]]\n"
+	"mtd erase[.dontskipbad]                         <name>        [<off> [<size>]]\n"
 	"\n"
 	"Specific functions:\n"
-	"mtd bad                               <name>\n"
+	"mtd bad                                         <name>\n"
 #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
-	"mtd otpread                           <name> [u|f] <off> <size>\n"
-	"mtd otpwrite                          <name> <off> <hex string>\n"
-	"mtd otplock                           <name> <off> <size>\n"
-	"mtd otpinfo                           <name> [u|f]\n"
+	"mtd otpread                                     <name> [u|f] <off> <size>\n"
+	"mtd otpwrite                                    <name> <off> <hex string>\n"
+	"mtd otplock                                     <name> <off> <size>\n"
+	"mtd otpinfo                                     <name> [u|f]\n"
 #endif
 	"\n"
 	"With:\n"
-- 
2.50.1

