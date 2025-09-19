Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF67CAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 10:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19F65832DA;
	Fri, 19 Sep 2025 12:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Uqkn7ssS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C267383526; Fri, 19 Sep 2025 12:10:19 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 211BB8334F
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 12:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/QNIcO0s14rC3uWcQdAlz+aS0BXe3wTlWr4KN6WqDJQYye9i5xcEnA94RWSoTOC4AYvbOMI7FC3fSKbt8PrX9mAuOSw73Wtw8q4VCXL9xTtSg1IFvFN0dPYrzrYk2N1YIYinW5Kgqm0yZsefB+1NVo84UxQD4Vbsu1os4ZjjZ/SENFhY7zwBAnjdcefJtXZqq6RFxiU+3bJeL2ysek+ERqoD556t4fwq3xRyB4lD0QUl+VUFahHjxETpV2Ydh1Z9+afZ/fI3+J4hZYRg9zTX9D01HipqoX1IH1YxtUSbGqjb8j9eOUGCzB96y2NtU+/HOhmTXwxx2Y2k0ulzUPiJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXTDsN3rvfS6n4lM++0ewqFiPOSGbL3x3uz4mGN2pfI=;
 b=iQg2hucHlr7NHq6jK7KWuyyGhICDDlLf4f7sAZPSZsGaIUbGomJj+xUxJoTPizqMgKqojfdDLWDguV7PAkm97kNwdZOEnj/raWOOBkS8BIE8fRSP18kj9KcEhio5xijtc7M7Nu/pFaSF4LsN/Ds51aqBD9LwnfJBLHfeVhOVULPSnkxsa4/uULE+Nrvnlj23FoRHnh9QeXONdAGyxlSHz1uSD7j078Yx6mP8A5B6W3TAu2I4kS2vqP9Rof/Ixkp8U+GIIiwccy9gx9QHEgCoIzTUJLcmRBBa6Jy1t4SYXHbt98rK8zMoQ/Hdot3/ElBWsk8foNdXd1sPe5KO76X3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXTDsN3rvfS6n4lM++0ewqFiPOSGbL3x3uz4mGN2pfI=;
 b=Uqkn7ssSZbVREPTItHit/I4IZMug8T+sLWSZECNt+umaz0zgiiq7Hc42Q3GaN2vFVQg7pJlgsNc61kbBLyV1nj1bEKfULioYuByoEGPEMFIcQAUtn74tOmFm2rNVJn7OTNmB+UCcHqdYKkh5l2bwcl/KE696kcMSEHU1iE7Y2Zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AM0PR10MB3329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:185::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 10:10:16 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 10:10:16 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 7/9] _exports.h: reorganize a bit
Date: Fri, 19 Sep 2025 12:10:00 +0200
Message-ID: <20250919101002.568488-8-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919101002.568488-1-ravi@prevas.dk>
References: <20250919101002.568488-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0040.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::11) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AM0PR10MB3329:EE_
X-MS-Office365-Filtering-Correlation-Id: f430b681-a860-4240-0a11-08ddf764babb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9RQJo6W6ouhwJwB9FMBVO4UX8IrEfUD6f0KAc5YYarCXRSogkhrkkqyr3GsO?=
 =?us-ascii?Q?mqvzF5QW3L6bkqY4juphcSpaEGWNOKpV3p0iqcwKrvk5sF82ZK+yVQM/e7is?=
 =?us-ascii?Q?WeBvZGkODGMkOHuuRXhf/UL5KCGorlEwseZHYVyUybgGu6lVovIpe084zp9T?=
 =?us-ascii?Q?z+TVm2fRlYecP+OjMLJ2Ggysl/kgdOzUcgHU3IVLkMpzmjHDb9CjsLyDjWHi?=
 =?us-ascii?Q?jEK8FpOFS8eAOaO/jzAnQtiqEkbv+1LYI1hAHTHVD4wCR9vMMUkhmGQGMaVM?=
 =?us-ascii?Q?eMWklcCEDr9aUkpvZ5rAxhqbakac19oIg5/0paR/Zrg1XLhlfFQYSTUjCjp9?=
 =?us-ascii?Q?HJBw9pFSopL1Mioa4LkJhB9Eg9w02puZCFs9Cb91v1CimsmxQSLtUOgszW1G?=
 =?us-ascii?Q?vkwYFMBIeePFEGYrLO9q2pkYegQ3jkk5eU3aPD03FEz1QiJktHq7wn8xsr6Z?=
 =?us-ascii?Q?g7eHvGaFdJbnNbOCBrjpPBPC9jY/dcZvgjm/CHA5yXXExQKV2vT9+botSK1v?=
 =?us-ascii?Q?R6/EAsqGDsGsTqeDJeLPjzyg9Cq8eCVlfhm/U45OWpJ1bMKGes4ji3PSp9wd?=
 =?us-ascii?Q?w1SsKSKrqxG+M1vYrzSPthEISc/PNjKdmUOHGdVohBL2CH4a4y1bhc+mFqjK?=
 =?us-ascii?Q?ZhHtYvnYHE3yzODetLUdgcg6kLvmTutxWCRV0ijPImQNuB7UfO9Lo1X5dDmM?=
 =?us-ascii?Q?0KjxcG5fXejPL6O6Sl7QC55L4cWJ5lgotkbmAunAVDTnzVG6rcdw1Z7NSA6C?=
 =?us-ascii?Q?VbH9yiYuUkiRyJifVZwVLPZkdierXeovEH1JQQgYDAh4AFcPiGUF/gej4AhT?=
 =?us-ascii?Q?gjRMCeIpP6ShS1V9/vNMk0hdkbv7F6IxbAqkDZxoJUd+DBMoSJsX1yRctvyP?=
 =?us-ascii?Q?yHssKvjdTvKPx5PRMA7ObWiMO+KF0oaXm/dzuZpqqW9Wgsi4wGrSO3sx6bD7?=
 =?us-ascii?Q?kSJSVPbhDs3nImIAzybxhiyM/sR2mWnhQRyxwgfK/jMAxwZesvMH8t6UjGaD?=
 =?us-ascii?Q?38BixyWXCUe736sdybH8+qd465vwYaR+ZW0wJodMkTmeHNV3qjhIku+n1byr?=
 =?us-ascii?Q?JR2Dn02ID2xIg4zL11WPGA8SVQ4i2HgbNAbOT85i+zwYsOjV/1Ul+4o2o2RQ?=
 =?us-ascii?Q?y4NnYuOAV0CVIAEp3ALjxvkSwOIs5/wiwQzOgGHD3vKZ9np29iMRLH5dS8cY?=
 =?us-ascii?Q?rUc7EqoL545jsp5fM4Zdzn5A5h+q3l2WDfAnz1vdYGi6EiPzKhWomcLKGv2z?=
 =?us-ascii?Q?hjRqypwI5Dv33Wxhooa2yzN/W8hZaBx1Um3Pr9mgJZDZVyXKWzxTJf1qfyAN?=
 =?us-ascii?Q?+8oluKw3jSZYwYY/aHya+fG8sbL8cTe8Pclf80xswIoHsU1DWn1v9x0o33gT?=
 =?us-ascii?Q?jqoWpsphr6ZlgdqkOn/l03FHFf8TOALeib+ZqlSzrSxtxvSrkcJZowCD3KaE?=
 =?us-ascii?Q?e/k1oDLEK0qdCDlnTg9Otl5TxOOpG5qE5HOcU3IxxtmGdFWzqBLEkA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Op/bZoTjJXNauSsA4PgtnT+/kJkEuc+ionWMFB98x1yhU8WB7NOXB/997Yr/?=
 =?us-ascii?Q?xNYFrVGMGj7xcZOBW41vz+n0MkscEdUeguh7dhHng+uaEe1ASpq8eXd+UfXV?=
 =?us-ascii?Q?9iwpuyXrlHNKPouezz1bvAhwAAI3096O73mAroV0RCmSXPo1COQRaffyuHcy?=
 =?us-ascii?Q?LsnxYBo3OSLHOeVoFHOVmsfBFoZa8gQSsrqAOTiLKvwlvstZao7y2HNaJRer?=
 =?us-ascii?Q?yKVx64pNh5fsv/6dn2Nkpq9citBABsYt+C2XRAn1yK5ytPbCvVUmvFfvDX7x?=
 =?us-ascii?Q?jfnf+B736ajsQVFgKxhPND8vlFyPg7PqQUIIHL3SOwKdi0NSKotOhq8+6BNv?=
 =?us-ascii?Q?BypXQEBfsM6MRFJOR2bSyrIgZ9CoOtYltfWBNbL4TdjtiPdNoun8FDsg8vPa?=
 =?us-ascii?Q?eoMX3FME7N7uCXPVpGf07WczRpzCmmiKqaMGonth8jc99RhCrClY/55p1Vny?=
 =?us-ascii?Q?q1X08wqm5eh1P33Zdoe4PbX/SGwwFpp3oFnr3wvjYoMc6NKVtWLqbFJruRHl?=
 =?us-ascii?Q?X9gOnGPMMMEh+AAE15KF14zdnr+w9zlr06wFYzJ6nRxuQMwK8BUHO7vyVqGv?=
 =?us-ascii?Q?CslDfWkpTyewS2orYPXAS6nhxOjf818g8dn6sh9+c900LmmyHaxYwXpuqbMt?=
 =?us-ascii?Q?gmP5bQs10ptq1reir2hKJGwEeRAR1TZK+63TScF3hscNEjY7k1lm1Mf9Au1U?=
 =?us-ascii?Q?oSqgYVk/CScUS1g/eY1Uzu8YBwyKsDd2ONOLOeabKP7psDPRBpzA+6EXSG40?=
 =?us-ascii?Q?skVb1rKUSqTkvD53o9lhFIgfmE0eSJOY03yWnSHXwIyVPOcaSDNxdhRDSn6K?=
 =?us-ascii?Q?NLBpqdy55pS0/DLbmJTMqewJOXYTXWr2uD8FU0OYFF194wBRRfFJJzqaRxAR?=
 =?us-ascii?Q?RG3y/UsENg4EvlandHlka2oALTFNblqiofG2LPUoasGEBhs+4mFxshvMyqMf?=
 =?us-ascii?Q?636W2NNT75AXm+rVhzqQM5QRy8Ve2IPvV8cxpxLFVPTCamcWrPg8ba5u7+WM?=
 =?us-ascii?Q?CoUq0+lDEFTQ9l/ZKWMZeCWReeSwFpXg7QUVxRw0eb33Bb0QW/DP5ikxgPoi?=
 =?us-ascii?Q?tUS2y3CAj1vLmMLcW3+VYYyFAbosA5/iSEp5Gk80rpWa9g7ZtRWknkqIdQw4?=
 =?us-ascii?Q?/OqCf0ji6l5yPZTUqLy9Fw+xE/XAGSqAfqG1H0aWKvXPSRa0y1mGPBWzGodP?=
 =?us-ascii?Q?mWKcKOcPbY5SsDpiNsLvnRH5+ColWwzQh5D0WJyYg7e54Dnt3uME70gzY3k+?=
 =?us-ascii?Q?L7gnLk81elzEC1HJV7sHMjqmDGvfIviWHvXGuUBoPcRjMDzM2sa7+c/MGcHQ?=
 =?us-ascii?Q?eq2yDjuyqSKJhDmNsA6U+xsskJTlC8nNKcecW4YdPNyk7Hnti7/JPdyXdnKB?=
 =?us-ascii?Q?WABfYMfYgFXP7bZXjXIJ7NmmYOzYj+BQkEINX2cSjiIs3ZG4E+lV12lX27l+?=
 =?us-ascii?Q?As5+BWZuiTvlv27XApeFSJA7Mng+s3XLtSkselc047TWkqOHY6U4Y/yAVRjN?=
 =?us-ascii?Q?5FcWbSDwl6XWuImUu/0l+Rr4mBDCGa1jhJbLAgASWeQGym3H8QYiJiGVXxNw?=
 =?us-ascii?Q?Q038RGgwUzurg3iLyIzICqSTpL/CXhO53p+VBRsZ1FPPhuz9yknzwIudUw1u?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f430b681-a860-4240-0a11-08ddf764babb
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 10:10:15.9740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgoIvuRZyIXhMFcfFbbOuTUiJoQybruJMxe0D7nUE0cd58hK7jz2hnEYzynwxZ4GxlpvlkVYK0m5ToL4HQWcj8TycUxGFAFX5mFkHHlyaEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3329
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

The current list of exported functions is somewhat of a
mess. Reorganize them so that related functionality is kept together:

- console I/O: move vprintf next to printf and the getc/putc functions

- integer parsing: move the *strto* functions together

- standard string.h stuff: move memset() and strcpy() next to strcmp()

- time: move mdelay() next to udelay() and get_timer()

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/_exports.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/_exports.h b/include/_exports.h
index 21afb8d37f8..f1b11c1e380 100644
--- a/include/_exports.h
+++ b/include/_exports.h
@@ -15,6 +15,7 @@
 	EXPORT_FUNC(flush, void, flush, void)
 #endif
 	EXPORT_FUNC(printf, int, printf, const char*, ...)
+	EXPORT_FUNC(vprintf, int, vprintf, const char *, va_list)
 #if (defined(CONFIG_X86) && !defined(CONFIG_X86_64)) || defined(CONFIG_PPC)
 	EXPORT_FUNC(irq_install_handler, void, install_hdlr,
 		    int, interrupt_handler_t, void*)
@@ -25,9 +26,9 @@
 #if !CONFIG_IS_ENABLED(SYS_MALLOC_SIMPLE)
 	EXPORT_FUNC(free, void, free, void *)
 #endif
+	EXPORT_FUNC(mdelay, void, mdelay, unsigned long msec)
 	EXPORT_FUNC(udelay, void, udelay, unsigned long)
 	EXPORT_FUNC(get_timer, unsigned long, get_timer, unsigned long)
-	EXPORT_FUNC(vprintf, int, vprintf, const char *, va_list)
 	EXPORT_FUNC(do_reset, int, do_reset, struct cmd_tbl *,
 		    int , int , char * const [])
 	EXPORT_FUNC(env_get, char  *, env_get, const char*)
@@ -38,7 +39,13 @@
 		    const char *, unsigned int , unsigned long *)
 	EXPORT_FUNC(simple_strtol, long, simple_strtol,
 		    const char *, char **, unsigned int)
+	EXPORT_FUNC(ustrtoul, unsigned long, ustrtoul,
+		    const char *, char **, unsigned int)
+	EXPORT_FUNC(ustrtoull, unsigned long long, ustrtoull,
+		    const char *, char **, unsigned int)
+	EXPORT_FUNC(memset, void *, memset, void *, int, size_t)
 	EXPORT_FUNC(strcmp, int, strcmp, const char *cs, const char *ct)
+	EXPORT_FUNC(strcpy, char *, strcpy, char *dest, const char *src)
 #if defined(CONFIG_CMD_I2C) && CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
 	EXPORT_FUNC(i2c_write, int, i2c_write, uchar, uint, int , uchar * , int)
 	EXPORT_FUNC(i2c_read, int, i2c_read, uchar, uint, int , uchar * , int)
@@ -53,13 +60,6 @@
 	EXPORT_FUNC(spi_xfer, int, spi_xfer, struct spi_slave *,
 		    unsigned int, const void *, void *, unsigned long)
 #endif
-	EXPORT_FUNC(ustrtoul, unsigned long, ustrtoul,
-		    const char *, char **, unsigned int)
-	EXPORT_FUNC(ustrtoull, unsigned long long, ustrtoull,
-		    const char *, char **, unsigned int)
-	EXPORT_FUNC(strcpy, char *, strcpy, char *dest, const char *src)
-	EXPORT_FUNC(mdelay, void, mdelay, unsigned long msec)
-	EXPORT_FUNC(memset, void *, memset, void *, int, size_t)
 #ifdef CONFIG_PHY_AQUANTIA
 	EXPORT_FUNC(mdio_get_current_dev, struct mii_dev *,
 		    mdio_get_current_dev, void)
-- 
2.51.0

