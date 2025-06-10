Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742DBC5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 09:57:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ADD182BAA;
	Tue, 10 Jun 2025 11:56:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="XMiCtQrs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 782A582B0E; Tue, 10 Jun 2025 11:56:50 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A65882B70
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 11:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJVmvqQDwnld0Y0DEgwDDFBHuO8mYpyhmbBdLEBkp/VZQihnds3Rmt51PLjYj8buBIgmnAzVim5fQ/ufLoPBN070H4ovzk45xPGLpNbRepjBWjyUeuzoXJkhZ7kBp4NnU9XTPAaTU0ocPl8oZ8A3+2HxqNVaZiRWhaBJ0rFWWlVQSqZ7/KjLMH/LRjtveegJo5ZAnqCLuREShHblLIoSCy25LUwC+3s42ArZwXO3MHhvJGiCS5SBtNzMVd72URRddtVoLy5zWgcD5UcI0DTwJYcbM99DamH+jl3HDQxDf9EV5O8L9P/LvxicbMa/dPGhQZ2FNdXP+R2FPL9WkbE3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSDTaRn2vIzO8sTpy56vni3OnDHjqZEulmga5AmlQR8=;
 b=WDsEtxQEPc8HVd/FlCHoNHGtKkdT0LdaKPsT/NFxHoOweRGmTPS2SJQmE0EkuszWSJM/J628c2ft9GrI0sOjMlbpJi0mEGDViHJ3RDcAfI8wdzMUlYnleNsndSYqKnr2qqPrl8o2ORwCwalD0/qbflr6tCZw5FXCsyI3MU271bBIinWhQK1SoYscKhYqVNPoeVw8Vsurzet7J5MManB/lJK9fTlCSlTSpKYUKFVM2j7tqtpDzOVag4xdWZkEIsVE5sl3GqGKIGiIvRb9RnnnCIdKsrlkQ2EnvujFgIrEtdcIIdWqNykJnSFazuQ6byHDJKjLy16nJYWtA24npYfHWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSDTaRn2vIzO8sTpy56vni3OnDHjqZEulmga5AmlQR8=;
 b=XMiCtQrs6MYO+iHZWmrrHbW+n5wxS72V3mTGZEFJrkZjZthvx1w+UHUfu89xlIlPq7n4TJW86TJYfn3I5mW7SNuLdxGAb/Pj+8TGYLkR34Rcla1ZdQ2ZXVkZAs9MUobazhd6CQVrfX5HRhaGMQ0siqucZDei2fCDX8VvfMTquHhIOe35dBGWYIn1K5D0c5jTcdcx3UQ2IB7LEqoSlJbQyz364bK3AIcOpheAfypBWrwFuexRa52UAqrxY5TbV980tXPga9imJ3PD8/WIwj3Y1NPMv6VyIxVeriX+BW4qUya6ouCRdAC3q4UDMn7W/P68rslCLpPh/LRyQoP9hwsY4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GVXPR08MB11183.eurprd08.prod.outlook.com (2603:10a6:150:1fc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Tue, 10 Jun
 2025 09:56:42 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Tue, 10 Jun 2025
 09:56:42 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 2/3] common/spl: handle properly images with bad checksum
Date: Tue, 10 Jun 2025 12:56:31 +0300
Message-ID: <20250610095632.1085431-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610095632.1085431-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250610045054.1038235-1-mikhail.kshevetskiy@iopsys.eu>
 <20250610095632.1085431-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0010.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:272::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GVXPR08MB11183:EE_
X-MS-Office365-Filtering-Correlation-Id: feae09ac-40d8-4a9a-8930-08dda80519c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9a+mtJzi4aR+pTVS3OWyCe2lcjdERLWpKiEiCcM00PuCZKBAZ3keAxpPpZrn?=
 =?us-ascii?Q?PPmXoozThwKOHyEwwRZMqYRMGvfn1/rQm1iBxczXUbH+APdXna2KYmEX3aKJ?=
 =?us-ascii?Q?b/UtQ9GJxVnq9Y2nhApuoKhuT/19sdxFaqMigfsHngChCsOiIEOdmHBv1+TE?=
 =?us-ascii?Q?z7uQDUc3QOGN6hmWPfoJVsYtjidBDjW+WXpXybZNQm1DASYATxOI974sHUW2?=
 =?us-ascii?Q?xi/60qEed8tF1dWlVYX+KQhD4VMJfWV3tEjfG1isTSsoadk/eFUjuAgywNbi?=
 =?us-ascii?Q?EFADDKiC/DGyo8G+j2zDqjhWneQ8vuZyQgLHptj8QMUjR7qqnmIGxuXRng1f?=
 =?us-ascii?Q?AJXKi6uRxCXOTyTyeK/Ow83tME+65jNdwWEgVefSh3kFUhRlW2RhLzfhjGc5?=
 =?us-ascii?Q?4VXbD8XBQ3E4OfnPOAT3QxmAEFyF5T+7XhCW9zqYgJsGA/AVps9Pc0XTqTPt?=
 =?us-ascii?Q?ISNQOdlHA8Zsk7thXu8bItwQMgvJfslc+TgoMAKLmO1OBpI08e4wNpvO6OeM?=
 =?us-ascii?Q?dJ9p8DTRhw/pUwhKi87owYOIm2N7Vt15Wfz1kFpTLZLdx6kQ6FaRXyLJTWtP?=
 =?us-ascii?Q?ucwptNQ6feYbktazTzMNfS///J+Doel9ZwMMXG4PzqZFjEKftpF6V/c8jxP7?=
 =?us-ascii?Q?hudUipdbvnuVCrN/nvJ8Ng4eYaBcix9tsTwdEvM2mlnst/VhNkxdJkfh28sZ?=
 =?us-ascii?Q?+oH0muSux0jN7ovcDsDWB7v8apUOIN/NVOl3JLoKNoxkN3xaF7PALLXYvRMI?=
 =?us-ascii?Q?Sonu2K8W/N0J9kN+HitsHNJJlRQ3rQXxFIwKAOWfsq+buG0DPdXtXkvAMIxO?=
 =?us-ascii?Q?/yi2EdNIpeOOoqwfoMuMKen8tMUvn8elbU5H23ul9I5928xKfNw1auJPUyLr?=
 =?us-ascii?Q?5BDJCxYFZ9IStzx/Wm7+GguZB+gw4d8Nz+7POMnLki+MmHgaZIxb6GcvAdqn?=
 =?us-ascii?Q?peU1/FQcg4zMOEF8B5Ct6c1IfQH1hKwB4zu/qBtQtu4kt8Pw35WKp400l5tc?=
 =?us-ascii?Q?fM6K9lYvqgQkDoAoPzW6lOlneMyifI4/ZF7GQyburgGuw/BBT1vLARqTDCAK?=
 =?us-ascii?Q?AHqmg6yhrXmbocL11Qmwv3Vs42K7j7iLcZ4U0eokdnYP9US8Tug+ZV9fsbaU?=
 =?us-ascii?Q?UzH0hNFBMDjp41C6SF6ZAJttQKK4KsV2GrWYFW26VNy5s4Qcmc/lrYFUJBoi?=
 =?us-ascii?Q?GZMDuFSJFTKHYJIKE6rwJZNkNSuSv1Ytg/PB5UQ9AtbySYh5r94OW93oCbws?=
 =?us-ascii?Q?tm9siekxucun7r7D+Vh6S7VXsZ+c4pQyc3EeZzdrVO8RJuS/jZMCDZ9NO/el?=
 =?us-ascii?Q?213yS/pcmfeWGt+L4nFbL8ialTlCsCb4mhfxJmK0Tpf8UoVuorm1qsW6Plk1?=
 =?us-ascii?Q?+wT69nOJzyC2SWenhBIp1LrhuLey9a3XgAr+tokfJJ2Q7m8u1Swp+leLLKwe?=
 =?us-ascii?Q?EZgFTmCvu2aWNtgab1G3chP1aGDbrJh5Xy7nlsfF7yvhEv3HzQ4WLw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZlvINW4L7uQDAeLJzDX2NzRvW1ZApGFFZ6Wtvmb6PbxmKjvOg5SHTyKLSeae?=
 =?us-ascii?Q?lNaRvjNo0zFcpmX0ejQXb3QT/o8TBd0TKpFSwRL+HIIxKg76OOUnixfC/O7Y?=
 =?us-ascii?Q?EmmrNbGiQcCCURRgngUdkqQ4zhOinBD3X8nK2gX8J4m93Vsd4PZVuxe54A6x?=
 =?us-ascii?Q?vKavw9DjEggMuWn3xS5RSWDLwjdC2AR1aEh2gPdso5HIosoR+ZAnpsZM1j5W?=
 =?us-ascii?Q?YUKtoyzXl3wDVg8xjzJfDKOWOcmxD3Scx3jL5/AVVITTMsMXxL0fjXqv9/7q?=
 =?us-ascii?Q?sGz+jGwqO0iMHMJ7bmQv+9meK/cC3oLDO6O7X/399ThO85PTRTWwV/W83i+1?=
 =?us-ascii?Q?nde/ssnxY1eLuXVQw19EVmMDadHCTIttlchIelMNX6nCRx8qW1tIDdOG4RF8?=
 =?us-ascii?Q?/o5++6KGfs+2xRMZwMqzkaNFj9vaFy7QC1064Z6XIeE5hplcOyO5dyBaE1Aa?=
 =?us-ascii?Q?1zgsU5UgZ6olosp6SGnm0CnyPYVTRNOckBFKQKPg2JEo1vrlYUELc1tZ4BUd?=
 =?us-ascii?Q?WgeaMiJA7JXZfncw52l6XS9uZN0CZAcninAo7KL4HFstBjJNuInEQnRucjeb?=
 =?us-ascii?Q?p6s2Ekw0HvTQ78cG4Vw+vno598wMxnft/Ikc27E+WkB1b2iBlNcY77psmfHc?=
 =?us-ascii?Q?cqkRYOxP7uuqB+7mRfTIioeNs9YdJTlSaqlo2FIlEOibRgzib+tm9lfEC0y0?=
 =?us-ascii?Q?kVa/0rnOPNfkrF+wg7Mohma0nyubt4sMqq4sY7nquknukcUR7iQAV+QoBeYb?=
 =?us-ascii?Q?hZ0KvpURTzYZ+F3tvxJ9H+w0uZdIUjA1RIgywyvDUzpYJ3CV3LLHGU6tABlY?=
 =?us-ascii?Q?lMjSpQsDowDDuZmdybiEB+SwCPgHWMnfq1e7AKrfvGPptyccRvRz79uhLvHN?=
 =?us-ascii?Q?F0t1GZapb4rSJlQMLRSQ0MuhYasbIlxHm6l2xm2EO9iWSyxNzwuIt66VLmM2?=
 =?us-ascii?Q?oR5fpfJ24w+FEIFidDxjHKG9zB2jGsP0dPFlxWs9UmC9odw1hQ5NlJU5xdrA?=
 =?us-ascii?Q?p1LNM7WeB/5qf0uiIHZ/ta7fMCXWH61oAPmghz7pMwMqDu+0oop0ygwMc1VF?=
 =?us-ascii?Q?0xZUqO7BRD7yXpkpcyxYKE7dkgg0dL0lKY2wRPjypz+KG/XteWf9eZ8p/OKc?=
 =?us-ascii?Q?0Fb3k8/3YEC09l+SeqZcihk80Dsw0Q0J088z+lV6joxhzrag6ZibcBDylCv7?=
 =?us-ascii?Q?1Mqx2LQjDjI+br1o+SDvmNgcX4FkBO0HjiFdagP1Ag4qik7FW/n/UitDvArN?=
 =?us-ascii?Q?3fa3qYD0con9cabnF6lf3XZYD0nHwH/Bk1foKQ2lmZVw8q3u4ksE/HIr0XHD?=
 =?us-ascii?Q?CONLtu+f+dLSqWkHlm6LfFhQgHZOF/+iUWxH2GTmDl732WXayFU2B0Qbel1j?=
 =?us-ascii?Q?gW520qklVOAMi9jVdUzDeLMuH2spGR2pFLkiB3zZqf3I0hR/3hRZO83pl/sD?=
 =?us-ascii?Q?NRponL1JbuGVKnS0dIx0TdbPha5yIx35EybpHTpNBOQg1L8DylQt1J5G5GCi?=
 =?us-ascii?Q?xVlDPv1CcQ182CHOz9pzlD2m/Jln/mA7eIih7stGOUCjYdSoI8isW/P4KZSc?=
 =?us-ascii?Q?7RkRzRg9HcLiutu+VOKlMC4NEmaJNqR4DKMXrAV4loE/zZcSV+7nn6zqunY7?=
 =?us-ascii?Q?0A8Hz2iWMb2NMAPYVuLGaJI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: feae09ac-40d8-4a9a-8930-08dda80519c4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 09:56:41.9274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccrf9kRbrFHOJt7HbE+MD+uKAqdpQzr/Pm5NnWUmQ97Ev3Ne+d+qZtHqBxjaiPJMDgfgzDAUqpbTrNK8yLbTfrJjPBzLGGDgx7lowh7yIfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11183
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

load_simple_fit() returns -EPERM for the images with broken signatures.
Unfortunately this may conflict with image loaging selection on the base
of boot phase. See commit 873112db9ce68c38984ff25808dde726f8dd5573
("spl: Support selecting images based on phase in simple FIT").

Thus loading of

	configurations {
		uboot {
			description = "u-boot";
			firmware = "atf";
			loadables = "atf", "tee", "uboot";
		};
	};

with damaged "tee" image may finish without errors. This may results in
board bricking.

This patch fixes commit 873112db9ce68c38984ff25808dde726f8dd5573
("spl: Support selecting images based on phase in simple FIT")
by replacing EPERM with EBADSLT places where it should be done.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 common/spl/spl_fit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index ab277bb2baa..321954a1547 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -200,7 +200,7 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
  *		the image gets loaded to the address pointed to by the
  *		load_addr member in this struct, if load_addr is not 0
  *
- * Return:	0 on success, -EPERM if this image is not the correct phase
+ * Return:	0 on success, -EBADSLT if this image is not the correct phase
  * (for CONFIG_BOOTMETH_VBE_SIMPLE_FW), or another negative error number on
  * other error.
  */
@@ -236,7 +236,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			return ret;
 		} else {
 			log_debug("- phase mismatch, skipping this image\n");
-			return -EPERM;
+			return -EBADSLT;
 		}
 	}
 
@@ -475,7 +475,7 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 			image_info.load_addr = (ulong)tmpbuffer;
 			ret = load_simple_fit(info, offset, ctx, node,
 					      &image_info);
-			if (ret == -EPERM)
+			if (ret == -EBADSLT)
 				continue;
 			else if (ret < 0)
 				break;
@@ -835,7 +835,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 
 		image_info.load_addr = 0;
 		ret = load_simple_fit(info, offset, &ctx, node, &image_info);
-		if (ret < 0 && ret != -EPERM) {
+		if (ret < 0 && ret != -EBADSLT) {
 			printf("%s: can't load image loadables index %d (ret = %d)\n",
 			       __func__, index, ret);
 			return ret;
-- 
2.47.2

