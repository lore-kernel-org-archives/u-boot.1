Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954AFCF34C8
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 21:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 185BA88FE3;
	Thu,  3 Oct 2024 23:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Im3bvby5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2997C88FD1; Thu,  3 Oct 2024 23:28:26 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21A4488EAB
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wa4JsJttA1A460mggVoqJtkvF0GnVZRWfHUUhFtN0hIpXxasH1pNSL6Qe7TrWqWspEUGgrFGRIbLtXLZWJ7xFD/CJe3vHhp2zD9xdXMv0XB8d5csT2lZQWa8qZ5A4PumjJNNBiGbWT2PeuD7BUQpN1QaYFhiHTzLTaiFCvX1+wywvJJi7LOToUN3H8zmw133CA2usQUMgnZsiA7Yk0pkQRMtFu2y14jMebsaeYaEjYrxJH2ba3U2mXopAkisA2cQlBx95pTmvxhd8aP0wcE45sawWsV9VRp+v87x4GOW4Q/LFcF1zv2AGYGkza7Rzp/Omkyl95a340kYIwVGhebLuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=she49k0h1hcbMfo2EpmDJ+tPHyNXMmellwWwU/URnX8=;
 b=wZbnpjkwympqw8pjKrgV6dbStD1Eyhev9GayrHake/ucMdtARC1VpeoFICNAJrt2j2wLT9mmf6T0SdVbS/K5OQ/2WCRUQxriTC7DxVxI6a5ID/vOlBjNXXmAw/4SyMZZWC+3t5auZEc6HnyiSqxxwx5ro5Aj+DWE4O0N2dyNyU0i0oJRJ9kSUpgtyUp763UsCrJngPIA/QmaFdYhpW/rHMkF22LsIojUj8fRUztIE8Gmp9swChV+m084GqcEYUzMyh56au1cQvikpThRU7Tfu/8gPidWNEAbz7qy6T/m9VS/d5KH7rgoNCKEUZIkrtO5Vnh4VGZqqwUQ99ZkJtPERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=she49k0h1hcbMfo2EpmDJ+tPHyNXMmellwWwU/URnX8=;
 b=Im3bvby5ZKlqLeDeR2cBfOA2pAG/Zv19XFJ58aIDYqC1ScDkqV7SmslZiNSRN4mhrE3KIACM6akhjs2xpmvRh3s9Oxc4RdWRWNJcLLFXc2PUfkj6ml8kpJZxjzHB1wLUDzhWLD77ADcDeGkmartMzT+kIg2RH7E7AFAofQg4V2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB9PR10MB8118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 21:28:22 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 21:28:22 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 09/13] lib/sha*: include u-boot/schedule.h instead of cyclic.h
Date: Thu,  3 Oct 2024 23:27:58 +0200
Message-ID: <20241003212802.3810-10-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003212802.3810-1-ravi@prevas.dk>
References: <20241003212802.3810-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0114.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::11) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB9PR10MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c041d57-cd95-44c0-e60b-08dce3f24e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tyUsbisVOQlpFYwoM0Drnw0HgZypYn7Tqe58PngYsVgg++CtSQs0EOXiwgKx?=
 =?us-ascii?Q?GYtSOVWdBw6Lzri6LhygxDliUIzEXPKJ7t42Fze4bGF1Wl2PB8tcBre9m8nN?=
 =?us-ascii?Q?iPH+yiC2eaLi7hHxDU74V4LtJKl1hN/WN+ON16sN9TL6LpEAObhZnA7K3hFI?=
 =?us-ascii?Q?D9mBp/nYBy4eRd/vEVmJNC8MlaTeReG/HS6QTd3BeiSnZdLE/jeBU51WhHzb?=
 =?us-ascii?Q?GlhPWHEqT5RRXwzAw6mR0b+83pWgmQFtG5UZnUfkfQeQql6rPtPGdxIh346P?=
 =?us-ascii?Q?rS1YeVgFpB09wyo4gJjdcr9SkhJo+7eQTMuL0jRdr5Y6/TYv+o8gcyNR1ccu?=
 =?us-ascii?Q?EWUbN+UY+gZDR0wCYHp8bTqxnqcez5agUO4Emu7Fufsb4MRG31x7e057dK5L?=
 =?us-ascii?Q?yvWAxVdJM4zcfIODX+7ydpLpG8YpZDU6I150chbVanr/EzccexSv78kD6SqW?=
 =?us-ascii?Q?V3D/polBcvlbsYzZk2LLC9KiOUsGAQB6M91UX6dtLBd1k6Fb9c9KrOmPWisl?=
 =?us-ascii?Q?CH2ndx+7Dr43/O9SfpD+OdTkR36w4jW1EIvq0azYmuDSo3nPGGxZwE6uewCc?=
 =?us-ascii?Q?DcCAvvhtdOWVaiGJApuXHe3hhE5kPVifgeEuKoqvywoi3Nij7XhsX6L/NwWE?=
 =?us-ascii?Q?Q4Sx/1xFMKdBR6FWyeIkXwLpM5uxbeCcEkEXNBvj/agzWSt87sZEza02aril?=
 =?us-ascii?Q?+7iD0SkmfNZcY5vZvYaX/NORIFaEOYdat16smeSBvDZ6U33MdyJDQUOUQ3os?=
 =?us-ascii?Q?8v08i2P9svlSGH1HGv3NIvSApcssrV3yC5U5hIcOBOq5xtvz9Hj0LTyGUJ7j?=
 =?us-ascii?Q?g5I17FvxjRDi3zLyRCaxCDxvYrmf/679Gnno2Vm1d2HVRG1BVFdzUsPVPc2s?=
 =?us-ascii?Q?X8H6tP/MYx2xMY334q4hRudMZbaQOYNGx8Cy1BSz4wQAaPjJNLRerwi2Hyi1?=
 =?us-ascii?Q?BOKX3clX/0XIJolHShBuRykNT+aRWaYDbUxQR/cfrvT14YaRX1+mmiMEP1ZG?=
 =?us-ascii?Q?v3ZQISowwXET3Kss33eM8idztc8IfB2wc6NaSJTGs7Vlaup6BtyQ/YUcKQkk?=
 =?us-ascii?Q?KakTjBHZ69PtXIpShn3Q2HwISmewXxEWkPbjYACCbvDfANeEcpnBtjiljsM9?=
 =?us-ascii?Q?GuVPy2/JRhO1KUWRnIa8rFEOk8D0fRA/ZNhb6oHrXriLW6nMmOBZD2uzPCAc?=
 =?us-ascii?Q?YLrx6qIaKF7G/7XMvXhrUvUwPS23meVVWwgvpu1dDE7/IK5/9ZYcEmoJUONI?=
 =?us-ascii?Q?LIcerYHx1dOC7CJYCKADzdL6oGKpZ1GqwufvdOimyrRSmbzl0hzB8IKEqY3I?=
 =?us-ascii?Q?glcN2d2qH1KTj+gLC71YveTTevk+z/6LIUVq50KuHXvMTw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rdb9GYXE3B+VGLWvovKVT8FhQIAwGHJCh5c6IDFIC32SM2C45yNE2dOwgZec?=
 =?us-ascii?Q?grCFq40nBMd/E357MkDeXzJJlZQjj5T9GJmm8eHqeEEY1VAg+vuqsFkFQAbv?=
 =?us-ascii?Q?jx1UqffC5u+arl3T9vShIOsioJo6LDBizm+D2BITmVtu6aX1hBNu2AHjtBjw?=
 =?us-ascii?Q?faDNmAsAM916yrRLJENzr2Ss6X5ylTBZLuhLYuZRUMmBgwlUa5cGhf69PUj0?=
 =?us-ascii?Q?NImEEgETaOFXzzsJK5z5Zar7XO0y85vzwzInIk8JOpjbUxuQWpprx+qmbG3E?=
 =?us-ascii?Q?5WR7p7ra2qc2aqanZJyJOv7AAxLCu+uP+wVHEhIO/Axp113VM9SC2OM72ZJY?=
 =?us-ascii?Q?oljUFBRIUa7CDB7PpSDl1GwYa3fSgVDCkCGYGsY9+krqLX2CVRi7aOQ7KmNr?=
 =?us-ascii?Q?v2KJTygQoPByxUqcbfJW97aJEE8lerJAi0mO/PmoFyBE/278ztHvvTRPgwro?=
 =?us-ascii?Q?JAB1mhnN3nxwNLkzJr6K02UUwBUjAmJY6CX8ksCnv0cGOPwfsbk4UpkDiwF4?=
 =?us-ascii?Q?Ckx/t8SeULRthqimnOSIiBjBYNIWSAixI346D7j/Ffs8MFUMOr6FNeavhW4J?=
 =?us-ascii?Q?V2Jo7PotwRcfvZUJ5oXR2JItISU96zgjDn9JNbvpz2oZuG0FXFo11GWGEkVd?=
 =?us-ascii?Q?vG9eV6xWL1U/CYWsGEqjROr6lMAZPfe/1PC7bWjLmNZ/JCnPv5wZy9d3sCSv?=
 =?us-ascii?Q?esPj3cYeV74PJuYnsa8NfzX1lbCKQaINXunZyFq+sbLbdSDaeIFCGu/lDDNV?=
 =?us-ascii?Q?ukQIm6DYqlXClZXt2z6WPPWwAKTc2hy+290miD2+m6+b6GH/63VLpPVG+3p5?=
 =?us-ascii?Q?aUUlQIKzU/ECjLFrMl7p01M9S+BqBQUU+Mc55/FUlKekupeYG0iOrkojYYOq?=
 =?us-ascii?Q?8soQs5e30CG/oBi7V8S9orVFf40CJZr5kNECJRNJFU+/HX5ugg1wtxXQYu0e?=
 =?us-ascii?Q?9Qz1J9youMMZIH0vng0pAWdSMMCmQ2Y/u4J+3pd0nlt+CKNe9eid1PJbOQOM?=
 =?us-ascii?Q?S9/qMiYgPBc/sUYowkX0qRCNwq+arwR01p6+B14gsT9eDRhjfBc1o5AKDTHx?=
 =?us-ascii?Q?/ox0mAqvz2XkPCw9xx1DdzJPos/a+XrecOcslEzN/5F1KCF3Zv0ZkdAWJsY/?=
 =?us-ascii?Q?FSsrIIuHjof5jymincOyJ8XQPMgSPLxhKBL7P3M/CKDRm+zbZ9CA1956prEc?=
 =?us-ascii?Q?lDrEg9p4fglEwEZ3OhYMadHyMv0q9CSnWb7z9eMInCDtgjIXJIwFn9EjXtHq?=
 =?us-ascii?Q?X31QXJkEo+9GA/BlMa0Q/zlAllA+pziiiixam12I2+X1fCCjUvwxSV47VHLz?=
 =?us-ascii?Q?TufCyH9n9dQDqEyUnsIrLVGNecJ/gMp27UsEGDeH+L7J7mNpeuqH0Rq34wt6?=
 =?us-ascii?Q?L2c0RlpXXwTtiEc55UlVQBuYv4PipsyC13Gkf+r3UXgir9afvWRb9GbRxq+C?=
 =?us-ascii?Q?PrN1NGGC/ZlCMJdxGsd385gN0T/be1YhfaZ/ySYpE7VhBI0dM+LnYXQ4pyuf?=
 =?us-ascii?Q?j9EAIIpn8yYZkXkUca6tA0CzvHKnfe+SUkBYGm1to8FwHYbOqlzz7NqFCMiy?=
 =?us-ascii?Q?Nd7yB1eHxJ3PUCdq7AkcMn32CTMnaWvg3KU59OTpamNy0QG9tGJK8NaFLoxI?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c041d57-cd95-44c0-e60b-08dce3f24e88
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:28:21.9855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwDtxJ1Ib5loUS+qz605kD/M8fGcZ+uW3eW97QfaycIGtanugPmQxHru/ps71n3/DROEO+kpTYtKGYA/gz3I1LLrJ90z17kKOzNFHXwicEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8118
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

These library routines obviously do not make use of the
cyclic_register() etc. API, but do need to call schedule(). Include
the proper header.

Eventually, their ifdef logic should be updated to avoid talking about
CONFIG_WATCHDOG.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 lib/sha1.c   | 2 +-
 lib/sha256.c | 2 +-
 lib/sha512.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/sha1.c b/lib/sha1.c
index 7ef536f4b5d..233bd9145c6 100644
--- a/lib/sha1.c
+++ b/lib/sha1.c
@@ -17,7 +17,7 @@
 #endif
 
 #ifndef USE_HOSTCC
-#include <cyclic.h>
+#include <u-boot/schedule.h>
 #endif /* USE_HOSTCC */
 #include <string.h>
 #include <u-boot/sha1.h>
diff --git a/lib/sha256.c b/lib/sha256.c
index 665ba6f152e..329802fd827 100644
--- a/lib/sha256.c
+++ b/lib/sha256.c
@@ -6,7 +6,7 @@
  */
 
 #ifndef USE_HOSTCC
-#include <cyclic.h>
+#include <u-boot/schedule.h>
 #endif /* USE_HOSTCC */
 #include <string.h>
 #include <u-boot/sha256.h>
diff --git a/lib/sha512.c b/lib/sha512.c
index ffe2c5cd964..ea555ff33eb 100644
--- a/lib/sha512.c
+++ b/lib/sha512.c
@@ -11,7 +11,7 @@
  */
 
 #ifndef USE_HOSTCC
-#include <cyclic.h>
+#include <u-boot/schedule.h>
 #endif /* USE_HOSTCC */
 #include <compiler.h>
 #include <u-boot/sha512.h>
-- 
2.46.2

