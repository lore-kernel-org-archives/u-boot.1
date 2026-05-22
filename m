Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346C1CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 13:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4173847EF;
	Fri, 22 May 2026 15:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ZKDDyySM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D03528469F; Fri, 22 May 2026 15:49:39 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01A598470E
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 15:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRt0a9SsxiLdeka63JmzhCRKkU/0iSZkTGzh37wtFCnFBifymwbP+lc1vee6xXo5a8BLXxazYyOR9SahWDYrY9qLeJrM4T/0MdW05yM0kqYHlZ14+2uNkILTDjbDEn2xzLmx41jYCAn1EOSmTWZbKtPapOE9PH1fWUIPC8qgxRu9YXDQV8gpDB93nRktWQr73hnW0891tuhd/QL7dEBeqv/8XLBKNpAfhw14QruxMDVZqxzSShfTETVftUMnz/O1RYoMhzmCp+R78f5SD8ymmT3NQAgDEja3UfirqVZP+1G0S07m+WgX+cbvWsJ2aB5P4D0BE18kxJwRFkRc2i9lFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNjFKny/iC2coqP3/r9vZZeu2CRVgBurt/AuH2/sJF4=;
 b=IfQzrlxwsOBtnmRhzLgSUrQ1RmKIaqeGb9zKGDTHZYGHB8Eqw/hPucCcCzLlCjEZWzUhUM/E2rpn40BDvXPs+YLGmukVwCfGLFtZKQRblAftGR78Zh6MgKBBy9n/H1SQ/7L7ZDmDTVGzCXFbiKk7wSOEF92GDRXOLYcpHbS/z8mVjlvBT23a8eKGpbxzO4y0abPPAbURDoyIzOwklSlrGvFWj0odhClO+vmj+KgpqWHRtgOQdgabKooUuzYnpRnTicJJk6alGeduqhdNoB5gDyibj3ZslaQwyAnFhzVjyHCKsYBMso/Hm/E5ZrWuRYgnmOIA5YODeOjF9TwA489YhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNjFKny/iC2coqP3/r9vZZeu2CRVgBurt/AuH2/sJF4=;
 b=ZKDDyySMf3d4AkEJ/WBw/TxKP0SHkzB+PInCdAQGVNp4bHHhh3FkmiyJhVRcMZTP8/1bWQsfto8935CcMv9ohPjaA/1VJfQyfhvzPVloP7+k0o0sXsO2U9XQDGtEGipVTjpzmoCrs3Gt2Hk/IzRDUenGsgMVXbqJ3geWucKZELrc7armr4Qtsm4laPeWY7YuMizj1JA6uEBuTkBICpQLjF7Z9EM8OS3DkGa2kOLbJFfV78EnJ+0ePtN3thXeHhQEug+8q4hHWAxslq4koupdFiitOuys5fQLD8pGed1RHFMGBHY/CdP1VGyPYf+b+fxg1SI9jUCYts+Yb6OEi9aJ9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by DU0PR04MB9348.eurprd04.prod.outlook.com
 (2603:10a6:10:358::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Fri, 22 May
 2026 13:49:35 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%7]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 13:49:35 +0000
From: Ye Li <ye.li@nxp.com>
To: festevam@gmail.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH 3/3] cpu: imx8_cpu: fix the mpidr check
Date: Fri, 22 May 2026 21:51:44 +0800
Message-Id: <20260522135144.1643089-3-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260522135144.1643089-1-ye.li@nxp.com>
References: <20260522135144.1643089-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0214.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::10) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|DU0PR04MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b0c3b7-a57d-44e0-83ff-08deb808f5ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|42112799006|19092799006|18002099003|56012099003|22082099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info: SEHIBjvuJPXPIngRthxa+fmE8Tde1bm54tJdlMaLyZe5OGzrzMFKfuWGGnzNd7YrSBw4Dzd+qrYOtlBvlKXSsGodPloGQ/YvMFwDS9UaxMAyzedde0PvjD00XrYFVISEKMzWz4en8el9Tm07znf368/jkcCemPOR7utC9y2Q3oTZa5tGU2GNzcNtwrTYxCec8DH3NeEmvyFaKdXG8f0DppDZvKgPDMjcAgsRmetdEQFFkeigUG0EMlDSXFcY3Kz2D48djPrcWZf5lOmil379iI+koLCxDlxwDFN2ZU7SjilRQHEiw057SqDehsYf+AFDQQ16Ymd/pyDFWGGJDta+rRyZH/FjwClFHpz+OYFuXEtyvLVqjcEw4C9t0mDVy4Kl5RKRjUJ6BxIOQMtJ+t1IUoVBilw8qki+nFgEpA9FsGY1mblKKWBuPrZ1qeRtAelF3QrDgCHYN7SkLaGmCSreXp+uUahe30hVFWwzX6nxVIWNVgEg7PCoV9BtmgjKLSh5Et6pwLvcrAPrp1E5YJJSuydD5B+8XJifUvQkpusZHrIhfQpVK5MR50ekKwlmTlKdgkKYLq8k60YIhz3aOqGHC1R3PswDBx4pW0OP/vyvo9RLnFLtoy+Xtd7PoKTs5W60Kd/JARqlAkEI3loBkvUJJ7Biy6wle3vxMWXpsNdRRQZDoMhBDsqDN5QlvaDacR8Y1AkrB+7WcjO9k8NamvchC37RTRLR7z/pfl0K6lbYVZzKnuyYh2xdxbImDH5gccfs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(42112799006)(19092799006)(18002099003)(56012099003)(22082099003)(11063799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ECYXAUsi2ExRHHRKSQD60P0diMPukIZwSDiOkOslNULYvI2lFCa+rSW/JuDd?=
 =?us-ascii?Q?KSLhdC4v0kCgkUTXmC4I+Cz5XGwYej9w6yzbrGpr+gOpfoboj1pMGaiQA4vH?=
 =?us-ascii?Q?vTGEOHiP6ZfStSPMKx2Z3a5RyHO90uKwG8d8v9O1gDl1Pr4ICKXdw9brcY38?=
 =?us-ascii?Q?56pvUjLD/O6coaZ7Jyyt38SLLIKHuGie5riydpQpTJA1rOLVWKejrwuvb09F?=
 =?us-ascii?Q?7/MxomvDWL2kj9UmhyDBHDqDNBUwBP2gJmtLz32LT+LSW8LqJtbb2WM0kKto?=
 =?us-ascii?Q?HHKJinONVg+T+bOJVvYXeigXFDQbGUY4nxHsMcOCpO/zJifVLsEPZ5l6KjMW?=
 =?us-ascii?Q?1GkcTfXnL45Wom7ZaTRFd2PPY+Zx5VjkwY8rBD9anVHORPG02nPLobNYzxeb?=
 =?us-ascii?Q?r49HDzABqLCNiIXsHFCLL1mOpayv8obyZR1DgPr4656OVrrZvXljjWWWHeTz?=
 =?us-ascii?Q?sfh71O88I02bCn2x3HciiH00918llqZx0u4uVti6Px2C+jd8W/8ddeAKmD+G?=
 =?us-ascii?Q?TLs4LEzMf7DAtq0rSWZNnVvcsALuGPrndendFDzB9vI7qj420sjbuYTYjvah?=
 =?us-ascii?Q?qJRMU4HflOg+lhoysfEYB933KcKVM6WMlL9+F606bhzSrYoS3e7NHPVT8rXW?=
 =?us-ascii?Q?2WYSVYVi9scW+1mcB9EGidU+jYIo//riIA3+Q4kGWJTQN6qpUzYgiOP1QxTw?=
 =?us-ascii?Q?SW83B/VDntv53IeDYJt/mbpBz9UyZ8t4gfpI5mgjCom0HPvulHA+UFnaGjPL?=
 =?us-ascii?Q?pAUngwP/aj0fGu+5XoGPXOlf9aBkR0UdktJuF1EWqpD378Q2NEnfzNknWALC?=
 =?us-ascii?Q?Z/Zx6iFDuEqyUTsKGPXBXq33TcsE/U36Pc+Ww8/r7ZHzBH/Adse1p1/wgh0d?=
 =?us-ascii?Q?C81mJQAGLOBkd7ZGoGoJTbuK3VnkLOdAmAFlp/mzYxzjL2c2qExsgbkfOq+S?=
 =?us-ascii?Q?hyW3TH9j/R4hU66xaLRyMN5TAL4UlPfnDDzSp7ESuUPxE46eGEo8btbUW9Oo?=
 =?us-ascii?Q?/QkCWlOyBMrII/rKXq749oVYmNZf/EkhN0zOmoFxvrVbWcc3DdIJnmv4zPUo?=
 =?us-ascii?Q?BpIj0gnM51ztYOjQgp2psKtMWuWj/S4jSyqhUCohGdKUpfOHQutFQL4ghye2?=
 =?us-ascii?Q?Ods3HPjP083nQpeTz7J5ujPPQI1Jx3RdpOzdgP2zlbvKZFBVrtxQxyVF1rL+?=
 =?us-ascii?Q?no/U2KusWpPwbSXuGXehVez0qtsBG+KiSCvMYxvpsrkADEJ9hDIpV/ZGpSPA?=
 =?us-ascii?Q?haDY2qOKuPxyQpCz81WlQKeYExsOuym1A9S1MWeT9KadN3ekxFQ4zURwepXm?=
 =?us-ascii?Q?swzwPpnK9VkdDEZwix8JAMr7SfL6W3pifZ7ZXGHluol9l4lbLsRIem8m+Dua?=
 =?us-ascii?Q?mvhGrWzt4NYdg/vdZWg/Y6BEkLuuoaNfjm/Qu7cmhxKA3wTWMDkudojYpiVy?=
 =?us-ascii?Q?Ej1QSbUUdA1qfO3ViErX+uCCbe1jToHwFX3j9fx+eBA+6ivXW5nmpsrUkNxu?=
 =?us-ascii?Q?CpRl2kKehSzGZPTUtSfT+9Gmb+7f2n8cumrxPWeSVXhR6R33iluDA0c/BK1q?=
 =?us-ascii?Q?06kD+nB5e+E83gY4RDuZaWMke8Ko50pe7Xdd6rhV4fqHxtiXUWZJkdxIHfGV?=
 =?us-ascii?Q?LQvvWSuFmgvwaJws1vQQfLcXJJQZzWXgavxnE1aB+bcp4ksAq1VYEwGrFOcd?=
 =?us-ascii?Q?FyeaWupj+uJ6PtVknHmjLt2nr71CbYe8jcx+8vxlTNsVE+Bd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b0c3b7-a57d-44e0-83ff-08deb808f5ef
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 13:49:35.9158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vhd935EvVdOCgXuOj2f1n6KLLuCJnQjq8gMvpAVOAcl6XacKjjZE54l3tq7kE/+b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9348
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

From: Peng Fan <peng.fan@nxp.com>

The mpidr's type is u32, however dev_read_addr returns a value with type
fdt_addr_t(phys_addr_t) which is 64bit long. So the check never fail.

This patch we still keep mpidr as u32 type, because i.MX8 only has max
two cluster, the higher 32bit will always be 0. Use a variable addr
to do the check, if check pass, assign the lower 32 bit to plat->mpidr.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/cpu/imx8_cpu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 87c13c33ce8..2bd76ffa739 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -380,6 +380,7 @@ static int imx_cpu_probe(struct udevice *dev)
 {
 	struct cpu_imx_plat *plat = dev_get_plat(dev);
 	u32 cpurev;
+	fdt_addr_t addr;
 
 	set_core_data(dev);
 	cpurev = get_cpu_rev();
@@ -387,12 +388,14 @@ static int imx_cpu_probe(struct udevice *dev)
 	get_imx_rev_str(plat, cpurev & 0xFFF);
 	plat->type = get_imx_type_str((cpurev & 0x1FF000) >> 12);
 	plat->freq_mhz = imx_get_cpu_rate(dev) / 1000000;
-	plat->mpidr = dev_read_addr(dev);
-	if (plat->mpidr == FDT_ADDR_T_NONE) {
+	addr = dev_read_addr(dev);
+	if (addr == FDT_ADDR_T_NONE) {
 		printf("%s: Failed to get CPU reg property\n", __func__);
 		return -EINVAL;
 	}
 
+	plat->mpidr = (u32)addr;
+
 	return 0;
 }
 
-- 
2.37.1

