Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B68AF327BE
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 07:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04D838431E;
	Tue, 21 Apr 2026 09:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="gACREga/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAA818433B; Tue, 21 Apr 2026 09:55:02 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B243842E1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 09:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9S/giVfoRab5YwPsGGrAXgA/k1rMP/YHWkFUFQEjM9hfVoEX8TmCkP8Lh4Nw/N2z8ZM8g5tdLwf7p5CrnGNgShgX5Kf9IuonQGscomu4LOxQbn2dlKdqUMTxQAIBbxTWaKp8WL14GfP8cYnekEoiHjk2HBfEaMO2+m/gHsTMUygB9oS2uKyXjUk9xxarTw9mZf0yzl74C6ktK0JOVYYGphKqmvqmGOA7UZb7bOilP9pTWlLRy0LrVrtnspMeJooMaYm8WKrnG2ClzjR1ehFvH9itBpY1Otn27RRFMUx459BUNhuMQKX4Y5fCcVo7B+1tfGfw5U5hkrcw0QFoQlvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeZ7zmOl4YHVStP5aiZOv1lKBeF1PKR4GAhZ6vv6MdA=;
 b=EGOL4W1vW7hsMtcGBrkr2QzYD1H+K4WClp4zIJPr2uQXSWYFO47WqWqfZwQqj1but9IpkqwAts3rcrmXArbhRbOTAw1ePQTViBD68Z1KMHNiMpQtSCu/OmaEC+rS6lpgX+QwGsb5iuMd+NOgZra7L36c9sm9tKQ2A3Cq6/HfdEzeTQLSBr5rDxbEosSyIPITNAJHqgHcQivJC8co4+McOuchVNXtiCerPMH0tvXwlY3Zpg5JyHy57cXueIBGJ6Q6PKJDNKw2nvtvJOxfZ+0hcKQbO6OX18dcvrSOFFR6WqDbSGDxXfCELRL3cxDNSWhcksAWZIR4ym7LLGHaNIeoGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeZ7zmOl4YHVStP5aiZOv1lKBeF1PKR4GAhZ6vv6MdA=;
 b=gACREga/8Jr2GJSaAg2wmCLQvIkvsR5OR6CvMktXnsVQ53CZre93lKkE2OuIHUWMNZI8reuz9UG0uz0K7p6rTT84oGhztbt/oTh68LzYYRCOePLWWaLFcQoTl2hrSOyYBTrrgwvZ8YrEDXJ6SQCCIwx8oML/Zto8aH8TUlsTQCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB6233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:78::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 07:54:52 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:54:52 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 1/9] string: fix prototype of memdup()
Date: Tue, 21 Apr 2026 09:54:31 +0200
Message-ID: <20260421075439.16696-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421075439.16696-1-ravi@prevas.dk>
References: <20260421075439.16696-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0007.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::12) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: c66bfd04-2b1a-41e7-7fd3-08de9f7b4540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kZgA1zgMkNYmxTyKF2f1+USE4ZfjS0K57Nvd9jWR2NxTx1EbCLTJOMJrQh7OMsvJqpUcv37abG/te4O850TpvzFFXQRnsTSWWEEss8gUXHfdZrAiY8+XRW98o3Zw+0Q3FueMPGpj4XVDywwXhwtksGE07bRp+AB8qKYnGyTLxIGAJor1JXkWx2H6seab6O9ZsE09wn+y9srB68z75VJ7mGlYFBaUtUawP6q6yB0B+x2RXXijk8WpAXk7Dak9djEf6wsr6tZ875YeV9lmCh9EWnB2JSNjb8QwKTm0hhlkymUgKaf+qEuO/rVGWIZnL2BqXttor/WNzfhgZc/fGqZkGhDuJI4OajWg9QWU3xIqK4ouNBPfydDyfx/1rCRn/s7V+I/DanRxrkY5I+N02Lq2TLRuoe2gSvYlanE5CaT+bCYcj7E63iikF0SDcT69bDL0gMXLW5JLXMFE7A69xPaYYb6yJmkWtS2K/5RUe5UywdLiyHLC+ei6eRl251aE2DNLgh8kcw0g0CYgEO3XAvvj3E9repUJRv68DTB+QRhuOyqwEnSx+3rrnGfl6744z/gXONfA6jVN5UoOB9ujH/EjCbHwAYgSa4ENNhhxAG2EIrRFs5UUBA/ClQtH5Hcd8G2VK5TL/QhcalZ075fAFy7gnl2eu5Q1Z0UJzdo+olVer5B3Fbf/8Lya7UHHJ5lUOkKsDZ8aQ8ugaNNoC/hKKy4Up9YQb/dLkUdsuN0lyCvHpkLZ/4fPgmBYIK7fo2NsTc034JvhlXiojLKyVm03X33NC1Tkp1dTbpeNTaP8LsBAdPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B9FE5p/6HX9Zv6giH5DEV8+bj7ivF491Tkov3il7s7eJ1+IFkjgSpO3Vkeiz?=
 =?us-ascii?Q?7i+LybrS/74bY3jp2QAwBD26t6rIc0doeMbVYLUwjYf/1OQKpc361BUynZu1?=
 =?us-ascii?Q?76Ze3UK+o3ljlHq8Z17NlhzBBib2wB56rKzY5pl13Zkqg0GreQsEHAOgQYXd?=
 =?us-ascii?Q?zFOfPXjmypsWJVsDy4mngXdbRzSVz2Ftbh49dHRkeuQuHk0n6lVJTLRBPb5D?=
 =?us-ascii?Q?8wFMxetWrz0sJ6UuHO0x8qE/XN7DChUms0rtBWCvRkeIqgIUNAyNWMmgyj7Z?=
 =?us-ascii?Q?KBCRzKMV+9PriaARioHBXvdOT1+PfJ4MmSzEWTptYNrAyQpXtS9djto232Sy?=
 =?us-ascii?Q?cTa1XoQFYDw2qBb/nncGFu7d/rFyH3XPf2hr3N2EsBh//b2kQIyc7BK6tVWd?=
 =?us-ascii?Q?gPFJFNbZoFNf6KabHMntTUpGvaRvtrE0t6H7YZspx4jsJZ5BGJD0jnFUSgP/?=
 =?us-ascii?Q?yd3wEqyG3zCM8VIu3/cC3klXthV7Vz2CC2s2UAZ4IpvRYbKjBBbqLQASqfpp?=
 =?us-ascii?Q?RFvgTxaMBDCxIAolA/uSBz95TnYSy8b6VIbUJ0B1jmGcf7m2uEAy0nbxg+En?=
 =?us-ascii?Q?9oyfmLckiCY4RoqcpHhEAmdihyrJ34rtLPoP8OqjKeJNv4HvM+c1kxZNkSEk?=
 =?us-ascii?Q?L1Z3+NzKKuIVDbdfdLmfZ9C3o9GE9J5Vl34xxqPpwHISMdvHZRMpzVI8Z9LO?=
 =?us-ascii?Q?/jUDlo9fdbgtlJg2QK3BL19PE0gBrRWzSX3aDKXh8zHeA3rTjcqMn8yIRPPZ?=
 =?us-ascii?Q?jU5qctJ2iO+2SvteQNvIY+g/nwOCVg92e9lLn0gD1ywF9NQZUGZCMRytbX4r?=
 =?us-ascii?Q?yUkMANitya/nTiOPrM1ho9/bguawk+7rio7974KZ7lTYhrTejhX132EgXJqw?=
 =?us-ascii?Q?UDbmtei8eRqLJCtuN/B1agvRB7oP87UYfWrUntk4P8oohxy1GPi32RNTqR8O?=
 =?us-ascii?Q?t05mOORAT2ixb8b8aUDI9Trbafmk9bDnpVpk7QSqTnxwknttBlEGmK6aJAf2?=
 =?us-ascii?Q?GbFC5lAf5v7xnr2rnCGUwND3poQ+no9AohbcRpI775r046jy3KQmNqBbpvt6?=
 =?us-ascii?Q?PpvFNEYlIA8CubGSPFhK36lang6/ywhF6fFZ9gO572Ezw52PxvlAr1mj2MNs?=
 =?us-ascii?Q?7wFMv7gLQ6IQ9H5v3ebRGaT+jIoGOib9CjzAEpj+T0NncOKUUXmH2jmLfF0F?=
 =?us-ascii?Q?ar4vNCDKDsUBoxJIQpbe9OgX09cJ1tdwt/QdfVk/Powk38hxfJNEQpMt5I9K?=
 =?us-ascii?Q?6R08MQMJ5rqfhxtlUpMbD3nb7dRsVlNGB8mBKBDftQzQPqG94rPRZMm/WJoy?=
 =?us-ascii?Q?+xhrOG+rvdRmgbIJdkiQg0tLgFqe0dMCCQkC5nBybmRcse5Ez71MxpN28ZyB?=
 =?us-ascii?Q?ZIq95yRlQuonPikynWfglfdCByjTWtabiRf2pnB0hOzzLq0nn/kmtQuig4mB?=
 =?us-ascii?Q?yReZgHla1lEAgUend+j8hpeLTaKNuqC0AnfmR3m/45ZeIzOBD7cNalNNiZLU?=
 =?us-ascii?Q?I07KKlnnFCBCZ8wJEKDe5pi6Ar5zGWGynjnYITbO6f3L951gBXrw4a83/yAH?=
 =?us-ascii?Q?TXXek6EJIM8dMX84bNqgTRCRIajfmuHyFJLTChriyT0vuZxzaBpJMgobgLYZ?=
 =?us-ascii?Q?ZfDEaAHv/7A+KeKqyQMtD+27rFo7uWQcROSTlqMJM03GEtO64FdBraCrC/5u?=
 =?us-ascii?Q?fmKcVjJrIB+mc1/WGYrLPCPu+w+eRgNmpWrp7FyEGDpNkR/9EOJ5d7Ugtbms?=
 =?us-ascii?Q?Hmbg+eh1FA7PY3TFvbD7OCPkMjzAd1c=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c66bfd04-2b1a-41e7-7fd3-08de9f7b4540
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:54:52.6208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1YHCim8h+OY2rbXC46Al0bGA/+HreQ0YBkIMzhPVdI2HJjPTUxcjBOCyFMpW+yYlV2rT5WCaa11NJQ0I7pk8905NqqTbM9b+tfuOi/c2/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6233
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

It doesn't make sense to restrict memdup() to only return char*
pointers, especially when it is already defined to accept void*. This
makes it uglier to use to e.g. duplicate a struct.

Make it return void*, just as kmemdup() does in the kernel (and which
our kmemdup() in fact also does).

While in here, make a small optimization: memcpy() is defined to
return the destination register, so we write this in a way that the
compiler may do a tail call.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/linux/string.h | 2 +-
 lib/string.c           | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index d943fcce690..9e47fe01c16 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -142,7 +142,7 @@ void *memchr_inv(const void *, int, size_t);
  *	memory is available
  *
  */
-char *memdup(const void *src, size_t len);
+void *memdup(const void *src, size_t len);
 
 unsigned long ustrtoul(const char *cp, char **endp, unsigned int base);
 unsigned long long ustrtoull(const char *cp, char **endp, unsigned int base);
diff --git a/lib/string.c b/lib/string.c
index d56f88d4a84..c2813e0f854 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -667,17 +667,15 @@ void * memscan(void * addr, int c, size_t size)
 }
 #endif
 
-char *memdup(const void *src, size_t len)
+void *memdup(const void *src, size_t len)
 {
-	char *p;
+	void *p;
 
 	p = malloc(len);
 	if (!p)
 		return NULL;
 
-	memcpy(p, src, len);
-
-	return p;
+	return memcpy(p, src, len);
 }
 
 #ifndef __HAVE_ARCH_STRNSTR
-- 
2.53.0

