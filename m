Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4789C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 09:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1598B88412;
	Fri,  7 Jun 2024 11:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="JGZVVI4M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96BC387842; Fri,  7 Jun 2024 11:26:21 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B94FA87FCD
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 11:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fINtC4kYg+pa9uxDdcDm/5SM69rfhF2dMpuz+YJ3qwqXpjohp58h/LRDvlvYOnwZT0CSzmjno31D5EqjFUzOt+pf+MhRoeegeRvNm6tEn8UY+TmeAc46V5Nk6L4ZNYsZ6yjKQRLqi+VaoyZseaHirFpp6fsrDT0Cq7H+B6JVFiNHkTgHR+V0ZvBH+ADBkGI4bhJik63jenUKxKwcHZoXmOkjgPZI7JpDeDXAgFQyNBpN/2fcmCVIPkaZMZIuWJT0n3FQCaamjotx788u+GkRajCxgVFkjGU1X+3WCgB96mh0s/zEUqjk86WU45S7vWo0jdhRfyfTdX65kqz6fGrcEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFUbVolU8tL24jAx0wXZ88DIOKsOgryU4NBr+LpaMqo=;
 b=liiMVJGP+G0Cqy7pAaBWy/ndpHF6+gaIt0vwh/aEj1qj7YaUpQ08tULG0e6hlRPHHjuk2kUvrgCikM3Poa+OE6dP0pTrrABuj6SChsyzsbe0W9fxVycFdMbnR+l1DP0PymccnPDsxH1yI4X2RH67lTtQB/eaGzoR/AnHyZApnLfUrTxTxy6Jk5L+Dv8/QzNlRIF6qA4AEKYxKRMF32zux+xMYiZmzTebfp68zNEpoyaS9HW6UcT3YjB0aCoMjuGZSEGGLj2LYVdqNfdfrp0XkyiuG9+bhoDhdtYmUaZPvSCzPMGN41MQHNrTe8ej2dFGZEIK2msqCEN6JnAPBr8KUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFUbVolU8tL24jAx0wXZ88DIOKsOgryU4NBr+LpaMqo=;
 b=JGZVVI4M1Ne7zO+PnqXj1kIvavHloNXRsi/wZauQzmKIogIUrMTCcXtLUMd0yK07cSethkebDg9LjfEVMPBHh581htI3hwf6t8aq4Vl1Ienme+QgT4g44GIrsgaxAd6CMoPkk67CX5p/UeGteip04VDt6AueUvcyWRwx+/tGyec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS8PR08MB9193.eurprd08.prod.outlook.com (2603:10a6:20b:57d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Fri, 7 Jun
 2024 09:26:18 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 09:26:18 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v3 1/1] xilinx: zynqmp: Enable reset_cpu() in SPL
Date: Fri,  7 Jun 2024 11:26:08 +0200
Message-Id: <20240607092608.712996-2-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240607092608.712996-1-lukas.funke-oss@weidmueller.com>
References: <20240607092608.712996-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0326.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::19) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS8PR08MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: a4104702-9981-42a4-245a-08dc86d3e2a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|52116005|366007|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J74CYZKVZc6mNbAkNo2AYYhg2+s7bOmBv9a5mmHvfDC0U+Ffyb1TVFuxyhei?=
 =?us-ascii?Q?Zm8JDczm9JdxcsgY4BMOIeweponaRwWTHVVTaCI6+rgc1BvIC8NWQSADwlMj?=
 =?us-ascii?Q?xZn2uWT2T8goSSzCFpAo14JrMqXMTBc0Qg4ZwYpYDqJrTIQwKeHmt+9fLPZP?=
 =?us-ascii?Q?30IVuDmFeSngX1yiUHGGLpnfz174RHzKdxW+ecF4aIyXouSPp7YRytbqfQda?=
 =?us-ascii?Q?NZffT5GmIPKbncNdKPacqlQf6Se6x0Bmjpl0ewzhEb4HuGsHmEDMK1rdih+M?=
 =?us-ascii?Q?OVfxCt0xEsH4yAGzOQWZ9ydMSmWCNuE7xXIgha2dQvTFFUqpUO5Z6WtgzICS?=
 =?us-ascii?Q?9318naB4L1GOfyoh9uThqK+MI3iQpz7KfMuvfAFeBM23v3Q0C4HpMutjqqxs?=
 =?us-ascii?Q?IBS5lG+XMbO+rQcXBI5CsvB8Pl+wnqaboRAthGD8d88eB83vv/zzwWJKin77?=
 =?us-ascii?Q?CqQutCH37oKL16W53BG0k4UdxoEvLgaLJV+SCDx67Ms49/FDxH1mwvugQIbM?=
 =?us-ascii?Q?m0JmO56adbgU5/eyQ8HE38aie8eLKisCgj5YQ7gonF+b9QqehxgoXcn1j8Js?=
 =?us-ascii?Q?V2CLzehXsumYQ24JyVRBefHR1A+2dXBetpZunE2NpIxi65EUTc06uvqz3egx?=
 =?us-ascii?Q?0jQn2fisJ6GRIYt9dpvn2hE995OFyc1nqN0sj7dTWFVmsVkdTehOshe87Tjv?=
 =?us-ascii?Q?SNpFYRC3KWwHfJuP6z7ljtrKDWLrXo4mB/rE7x628o/hEHHLPH0LPXzZZGDP?=
 =?us-ascii?Q?SmjCuhfjIXZFUYJL296nSMeoTVSaZHMc0hk3M/GIno8E+GCsAmsWspPbPSw7?=
 =?us-ascii?Q?XESlE6zOOtYQMci3fT9STlGkxwmYGA/taE/Fw2N+kibRbR88Af795RqNnMsP?=
 =?us-ascii?Q?42Jt87gogORRoPwfdK1EnBTBk8W+qyBZL9vq7OVIwm5tR3AZoknXbFX2tFr0?=
 =?us-ascii?Q?Zd9omnc+ltRrJ81bpf8GSPrNK+jOApmDK9Cr9WyTnKC6Bet00/TX40w6X6UP?=
 =?us-ascii?Q?X7Fhbw5k39gsKw/Apq8r8Db4not6uif9BKZkLNgEuoKWXjzF0kwdwcUgVROn?=
 =?us-ascii?Q?9zUE/Y48XN72z9FlrOMNhE3kCyx8v0deyOcDy+1vJUCQhA5g2rcEN7fU75WL?=
 =?us-ascii?Q?QMwHSP7BKK8wgIaMEVEpdvYucrEmxSCzSD9tEIYXvOWIN3wyv+ZRePmj6ff7?=
 =?us-ascii?Q?iEOhc9O8ID1WVSVlpHvQbPoGh1li7g/BmWjyOOeabaldqp1ipVP3VegXfEu0?=
 =?us-ascii?Q?Yx8pNItCj2tVMrE32gEAY4nW5hF89r9Grr4lIPz0R+a/b7XBguIniHsCnjhB?=
 =?us-ascii?Q?/rHJnYZ2RmpZLUlUQrGvWLakccNNoCvn0sN+sdAbzLVL9gVR5huDE6MljKYG?=
 =?us-ascii?Q?kfHOYqU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QFueEruao7U49VM8YXcn9/24Ep0wStMYrz7QYECLIH/Ad4sjJVwygU/ksQg6?=
 =?us-ascii?Q?4uKAwg3Ke6ZL8p7aC37Wg45v0uYi/0lCGPT9xXEtLmk0F9zwYGpkx56iI8ih?=
 =?us-ascii?Q?mXELkyGOz8BkpiVtjtJC5xrv4ra0qkPKwmvsKJ0jroLK5Xvk3XC1YPz7E1dS?=
 =?us-ascii?Q?J5PMG8dITrPmpn6FFgMrWeVgqpaG7ImJ/NBibJKdMG9v3lh/GOQawlC89f8G?=
 =?us-ascii?Q?gN9HhCKS1DPQR23pc04pjKHMxdfyjd1+vpuPsD871TCnC0JDKdP2ZHH+RNlP?=
 =?us-ascii?Q?IquvjfDEqTS1FIj/RM1wwlNezx0th6+UGup5cfWPLCmxdugWbD1Ar6+DnemD?=
 =?us-ascii?Q?E/nzMYc/tLdWr0SvTqA9foTT+8uu+Ww2Avltf6VpoQtMs+O2V0NFTNPQivBl?=
 =?us-ascii?Q?D+EXCVeIGXUqJA8bCfJ5tpQ8vBH0m8MnhpRzOHxoCcNp0RbisJu435pB+6/J?=
 =?us-ascii?Q?6shcU1XjC9zekD4gp9V4u77xi/U04G/y5etVKHdvRqYLnJEHVpRD/bSk5na0?=
 =?us-ascii?Q?l3W5Cqsk9XIEhYdl+nI78m/OnMsWyYWBLldO4AYafFUWyNTfkzQrMbKMRkaZ?=
 =?us-ascii?Q?m+uGDjwSvnQSUV5Hx4tUBF3EmdbSGJwaWgMc81i3JAuYTAaNcl0bZE9Wg5SY?=
 =?us-ascii?Q?beLeTJEX8d9JHrjWWoEBQ92yylU/AdFKpPvfGnmhS9LXwO0NR+HzZhs4xzJq?=
 =?us-ascii?Q?B28imsjvqeVtIqkxPE8ybPcgzVDJmDmA8eh4r4FVG3ViPvC7az+azh/ncbTU?=
 =?us-ascii?Q?ZUKmacw+MXRInNPYs1jQn7DCx2yy53WtDMBbFxwmVqjM9TQm6U04XVyRJs4/?=
 =?us-ascii?Q?VhQUDnw/jwL9dhISPeFSQSu9JKX/xrRGqReDLncvajLc6iFmhP9JOUAxF/rX?=
 =?us-ascii?Q?DeHFF23X93+GEQZHmZN33bjpOn2hKNTh6Oml1e6vNq4Te8puSaWB+W45BM7r?=
 =?us-ascii?Q?au2zxIMknMxmudyl0khYC7rIH3IALRYKKTw6SujI2sf0EZpkqUUpCfRbHzsO?=
 =?us-ascii?Q?DBGV1aNWgMZdXmgricO64+aAS86B9enB2VBTgWhD1k2t10dHTjup/hP4EC0j?=
 =?us-ascii?Q?s8CS3j2sst6UDGM2bmbv4ee3HkSyEM7jwz5Hn2ZwQCaDZp4456Z8Ym6E/6U4?=
 =?us-ascii?Q?v1Qx4d48i96D1G80sGXk38yRy5ZHWYsv7YzNT9YxzgzJPVQIXKnxKNEJhpyB?=
 =?us-ascii?Q?BeaOAEL/5iVlwrPWOzPsdKa/T6H3qpEVk/rYpZs3kFHfcM3JfYqHRr9MD2ct?=
 =?us-ascii?Q?LiUC/XsACbvZB7Mxty1rVSvF4YQ7gvC7TogvN4rk6CaOmbqPFtrUVPMRWllA?=
 =?us-ascii?Q?FIxstDFcLnHkQjyPuqtobEG+GxB7E/5S0UGoeN3D6+QkgVxJSRMs2eaHGNUv?=
 =?us-ascii?Q?edfOw1dc9XR3o4qyLKtNRSsnZ0Lv6v/M5nkjtiVSbmLFpGcyNbU3XbyhtBhG?=
 =?us-ascii?Q?K98Er8F3gjYUt5h2/SxNljMMkeejYaC/PqqdgwLgt+wK7g5andSNjuO3V1mX?=
 =?us-ascii?Q?o06s4lj6m6KZt7JKG1wBrRRBFcgGpr8gXVx/JDClBbTpzVw8dLCV66p5xU2i?=
 =?us-ascii?Q?rryMuCUeAKQzQ34Lw9iRdWwz81Hw2pPLvSYKls8HCP80aee6+iPfHnr0rO/g?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4104702-9981-42a4-245a-08dc86d3e2a4
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 09:26:17.9254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGy+c1yR4Sg01baKG/UO3Lete+zhHVYFjxGxyakmuKZn1pndsywlUT9UK/LWwMgakN2bx+eR3o+luXIYxn+RFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9193
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

This commit enables SPL to reset the CPU via PMU-firmware. The usual
reset mechanism requires bl31 to be loaded which may not be the case in
SPL.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

Changes in v3:
- Use 'ZYNQMP_PM_RESET_SOFT' directly
- Add comment on what happens if CONFIG_ZYNQMP_FIRMWARE is not enabled

Changes in v2:
- Drop 2/2 since reworking ZYNQMP_FIRMWARE dependency is out-of-scope

 board/xilinx/zynqmp/zynqmp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index f370fb7347a..c37c198ec55 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -285,6 +285,18 @@ int dram_init(void)
 #if !CONFIG_IS_ENABLED(SYSRESET)
 void reset_cpu(void)
 {
+	if (!IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)) {
+		log_warning("reset failed: ZYNQMP_FIRMWARE disabled");
+		return;
+	}
+
+	/* In case of !CONFIG_ZYNQMP_FIRMWARE the call to 'xilinx_pm_request()'
+	 * will be removed by the compiler due to the early return.
+	 * If CONFIG_ZYNQMP_FIRMWARE is defined in SPL 'xilinx_pm_request()'
+	 * will send command over IPI and requires pmufw to be present.
+	 */
+	xilinx_pm_request(PM_RESET_ASSERT, ZYNQMP_PM_RESET_SOFT,
+			  PM_RESET_ACTION_ASSERT, 0, 0, NULL);
 }
 #endif
 
-- 
2.30.2

