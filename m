Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FCEC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A5FF84A4A;
	Fri, 10 Jul 2026 14:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="YHmu2e1k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6D0284A91; Fri, 10 Jul 2026 14:36:35 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD9068498C
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 14:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/m/PTPqKxrn+9o61H6fbQXHhZ0ws4YXHeVL1xro2OMyrJJLwkmrA/taMGryd5+Or7sGjD5kgUF+ZRNXXOWDrjoEMFPMvY8Oh2d2RTPt8qgR6U3tWrRf8LJAT5ECS8IlqGiGUKZNPQT/XBFZ12DrMCuAv0Nk8hrvFh8cONx+4nEzjkLjIjth4qZUwR85IFdjGOlFc8DIspK/u+8+S1MpCSIXt1ll45EW5WS2P6jsQcAtQs6RS/1egnpsRq0ACFm8tbUw20vphfqWpHAcMfkcf45MtJnSWz+qCxDmndDufrpv4VGJZUYes23GQylSQIp7GqwcZ2sfqW5PRnx7Ml7RvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htBCG7a2+zlLIuTlisTPNon6TTXlR+Mkxqj8yqsN6vM=;
 b=Dpb4+HFaqPE409aSE1M5fMr0joSyNL6+RRttwzkTZXZMLmgKJgyDKNdmPqZcBCqfj7LHl33f4T9vtfteKb3O6hp/um6fPZ+C8fwMZBlFgasha/RQXbIwta0yqLhwUeOuLuXuv2IYBQAngMXlzrDq/3pqxvgtPqp2fQOMLR6OdVzx45ThRScZIZk3WzvJMLrJy1UcMUHvP08jYQnGMTzQVBhcui0yVHZZQXX+rY3M4Y2S7bWcxMeIslrPdltbBY9TronDfIASK4gNYv6usI9Q/NdqCw184qaOdwJtYRxufCL/R69X81/Ttmgro73Psn5MjXtsLuy28sNnhh6cyfw37w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htBCG7a2+zlLIuTlisTPNon6TTXlR+Mkxqj8yqsN6vM=;
 b=YHmu2e1kAq7vzgqFO/P3d3McgJqC0AqnaHFNB9v/3rF/Mx9vGhbDzAwtWichYtbxzxd5otcBxbGKpazVwYWXbVzCDYA93Ljawz+ohl0uHGgyCNmZoCVr3iUL17Y7fI7CP7cnhK+b+b9uyNbDYidbReKxs8h631ogjVqdojItrkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB4PR10MB6942.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fe::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 12:36:29 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 12:36:29 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 4/6] k3-binman.dtsi: add keyfile_template node
Date: Fri, 10 Jul 2026 14:36:16 +0200
Message-ID: <20260710123618.2036728-5-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710123618.2036728-1-ravi@prevas.dk>
References: <20260710123618.2036728-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPCP307CA0007.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::7)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB4PR10MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: c238946a-f6c0-46db-d99a-08dede7fddc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KZz5bhCZufZRBK/y3iZh/ntJGkvqR7zJ9IGN0B/1UH0W5povKjbxpLWoc5SWYXs6Yoqi2UD8KvPyCBmwrgY6HqlIthsZeZLpfLBpB3uv5T0eM9KUpBHwiYkCV86iKQ31dxSeExg+owku12C3AK3gwQY8TdPbxK4WSSiMZsNi5JXGz+6rTv7o270EJTJgPEc5ya4q873YyRbtKPHMeQ/WEP8oE0/wnsY6aKC88adsz99njTye7wdMkwkSDlR+1gM8VC2nMRa9sWSU6pAnqEQ7OUwfA5o70dBEG7aQft4aeOzN7ejtszVFovY5b4/KtjFy2PpDQ+zY2F2QjDxA1rsT7eMQEfrUAoK6g7ZSsnhYSUzf8d4rb8Z1ruDaTXO7waG94WODsjHQOxOA3DhyrXn3YduowE6xU93CYWF4SwL19jBzA6R4wyuvonx6VQ6tvv8p1YhS8RcRnvd0Tkx1JbRRHu21Hh2yv9JGG5/EeiByvG55awx5gAtMTuQgv7UyK44WhxjBBaps/YvQLmR8/CLSvyzw0ao9tfrkdGWTlDN4nawMaePOiP8oGhIRs04Bxgyvwoyto1LIA9oXpxcxP89opPenJHUvNtX+bx/utlRLAJToekhzi1daynEuuRdI5YZm1/WPrilBqly2oes1BZYgS90T/J6M3qTMwyW5p4zKow0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZTMUSjZfxJuVpY0Kuc8/bnzqvx/c5ZkHWi2j8GrfGTLMNqCREbIcYYsYRgWH?=
 =?us-ascii?Q?ysrHdzjSvYM0bYyVhhQ7SWx76SySXg2NdGTuoekMBgg1ovbJNYBUUhDC6t/v?=
 =?us-ascii?Q?R9DcA3XhcqySuHi5kmWfQ7xP60DERYzukA6vsg59RtL3uYcOtGJlmn9t/+iH?=
 =?us-ascii?Q?Ku1L+5cKlzn4RIHjMOKjQM9EMjo5IeJAqPpDx05UT5gqEvZ3f2kKvWVm6M7P?=
 =?us-ascii?Q?RKeJFdsKEHJsEbx1BTV5P3COQSqubzRwvwwg0OF6S1lXGCw5629D94uDfq8L?=
 =?us-ascii?Q?Fttcoc/m+tSycArBlMXkzKNOYbu1ZCxIEGBeo7Lz1ut2y2aJzYa8+/JWfAtc?=
 =?us-ascii?Q?LYj/ZzRglfznlmZeXb91U/1prySaYZLT02N/AVuvmW9PkJ9Z9CXRRUfqrVr1?=
 =?us-ascii?Q?gnvRDsZ9v2QI1y7qvMpv/Bjcx7eaTIDdJAv+8ZUQBtvpIL5OgLLGa9SX4DzS?=
 =?us-ascii?Q?D0zt6grxCh1/WmF1AN5eE6eBX6F9rb4QU7yfHg9yktpE0uSJa0NWbH82K4n0?=
 =?us-ascii?Q?Ht2J0JMq1ZKZPNC934fTiF5YalDfuJ/Ei90oSXVaVKx0LU56sKDZEEtluDDA?=
 =?us-ascii?Q?NdiByn3K+Ixwy9Mh9f4+sKOb53t6U7UDLBKTSXBOzUx0UfwxIqrEVdjr+MmA?=
 =?us-ascii?Q?iFHiBQpWR5mjypGYuqB7Nrm9rT/EIMgpx4OXWPm6/l/xoGskuV6oRqSZMhX9?=
 =?us-ascii?Q?UihKwMo6kqGU3vc9ZCXZ/NHqmAgVTi9ZMNGclUn9l4ougi5ogQfwLsUPi3wN?=
 =?us-ascii?Q?nNBzwCBeMtPNHrZ9qP0nmpq5iCZhDR22fa/Jc//1hOLxGK/+BFx17NNEOjld?=
 =?us-ascii?Q?VyuSZGzzMVqn1QrFC6DhDx5lr3hgpWBp1dMlDVzS0YFIJh+OBmcUy9U05EOu?=
 =?us-ascii?Q?VpVcFsWs+ueJFYYtEMsRYThubptTMLDjYK71/33T0mwHkfv5J6XSa6rrlFr6?=
 =?us-ascii?Q?wqM/V4sQWXBsLcquM2XU0VMuHq2Uizn4rQLFUjV3P54WI6ao+ID/8nxpTT1M?=
 =?us-ascii?Q?Cok7TxB8yA8CFXayUfO6xnn5Tv5abywLP/ihGuVd6eFugMZtIIeGefP+hxQr?=
 =?us-ascii?Q?lj0C81dGIVW67ORfrSeK+ARYbGTdSr2XYgckEsRDO0AlSuJgyCndgtLc9v7t?=
 =?us-ascii?Q?QWAkWafgyKIYD5q0kjnVpGR0Jyol0KRKosShUjTd2pTqDj+vm8+bCzBAdnIb?=
 =?us-ascii?Q?9aF2tzUZKGmwJMHzqHVd2Zu7xveBztybY/afWrFlIGYVoHj438XgJZJh1o+z?=
 =?us-ascii?Q?f0hn30Q6OwlYMSJtRFvrQAkFhd6zVN1YCpZyaYzqXNjl/ZvFostWwZoDgFvN?=
 =?us-ascii?Q?WCCTHam+SE9qZhTUK8pgcupVoTL/9c+PlGuUAJ/80F+mu9Tq8o+3kl+NjZXp?=
 =?us-ascii?Q?RXBinSU/+NlVc2HFmKvRaMPAqVQP5TnD4f0Id5yqcf+GDrg3vzdXNaJgs2nA?=
 =?us-ascii?Q?SD+mYC5voLNiLQK/mfEYnpWG51xDl2JDbs4LJViSWRpMO3YUc1ubApaDhqqZ?=
 =?us-ascii?Q?pudK5duj5WokfzKMdFjzRQAXGTLO/Zv9fVfdy1jIHJpPbmlKKlP33y1DtM98?=
 =?us-ascii?Q?fGazFi+7mrI/hZbnK6IRC6vA1bjY+OLD+zTx9jIggeNSl/Vgd9vOZIl4hkk8?=
 =?us-ascii?Q?e/YwHF+MraWWxk36VXn15Q+bY4fHuUU7Q28jGyYKsy19wPcDa93kHvKAy1TF?=
 =?us-ascii?Q?/kMTztr6rqbdTS1AxBnyEpWlgzo1ucJaSWeAe7GWJvOdavbfsrx2BnxWXUyO?=
 =?us-ascii?Q?SMlZmRQIAEqw4FhH+kSJOxh3zq4gQ7g=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c238946a-f6c0-46db-d99a-08dede7fddc6
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 12:36:29.7267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYpCCOjpUO9gqBZeecOWMjd8K7sOC1NHIQnOELp+eqMREEiY0o7mT90040BA4W1CChhIlyVzciBiQdYrUe7V9hVJO4VHk3UIrI/f1Yvb/W8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6942
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

Currently, it is somewhat tedious for downstream/custom boards to
override the keyfile used for signing all the various artifacts
involved in booting on K3 devices to point at their own key (or
pkcs#11 uri for that matter). One has to have overrides in one's .dtsi
for each and every ti-secure / ti-secure-rom node, and a lot of those
do not even have dts labels, so one has to use their full
/binman/... path.

Add a small dedicated template that only contains the keyfile
property. In a subsequent patch, we will change nodes that contain an
explicit 'keyfile = "custMpk.pem"' to instead have this template
inserted. This way, the downstream board's .dtsi file only needs to
contain something like

  &keyfile_template {
    keyfile = "/path/to/own/key.pem";
  };

and that will then automatically propagate to all the nodes.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/arm/dts/k3-binman.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index ad127663d03..69214bb32fb 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -25,6 +25,10 @@
 			filename = "arch/arm/mach-k3/keys/ti-degenerate-key.pem";
 		};
 	};
+
+	keyfile_template: template-keyfile {
+		keyfile = "custMpk.pem";
+	};
 };
 
 #ifndef CONFIG_ARM64
-- 
2.55.0

