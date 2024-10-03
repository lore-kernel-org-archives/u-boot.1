Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB7DCF34C3
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 21:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C4C288F5E;
	Thu,  3 Oct 2024 23:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="JlxXdwD+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8783488EAB; Thu,  3 Oct 2024 23:28:26 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BB9588D5A
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3mTXa0+lVi09gjQIz9lx/y8fyqsn201f1pkYpU0SlxZCoAom482q/wf/Tx5b1ZcsSQYevZxKw7mAAnAqBM1u0CJrP1fZy/iwaeOmw97uOvxiC1z5Lhd5f+aSogdtohK/l3HhwSAM1rje+ICkfGrHie1PYoDSfgGrNjo+qzRA3RO/S7t2lGRP6NKZm0PiBIt1LqTZ4rZd7jEB5oC9+RJO2Siy/7NSeoinsWwefuyMp8z6SkyYXJFVDKfehJ7slZiXr37iR8PIRH/knblxxDpY9Tfko/KTBSeOBoLVO9iekUwveuwJk1umLJmxIfGryy7Q1aHQ4C1dRGD7o8fon+/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU81Izou1PF2Fp9fIiH1cdnL6VMjoqtsbQATyxysjIM=;
 b=fMjimjW1NCm7zFI08gsCUctJQgckO9ubkmyYVtFt6mMaMMyIfuZT1T9tBqUEMGhlsrBRFP8qerOODoNTq/6KoNymxgZj3nhjJcf5pooS2gx0XOrj9exVEpgcx6xOvUoEcfFs1w/jI1s7WdyyxVb2H9848zPE8h/7g+Es6I7E2b6BcaIA/teWS2QSIocTeOg80WTobYlwo3s85DWM9oyGgAYOZmCkXspfYVX7jrce2v0kYG1qvywwN/8MP5WDLT4J4ICHa4p8Ff4cqFBm9oa/5acTjGV7xmghqgu96wb+rYPMTNNawW5fp7aOCpbVhwo4rhZ0l0crLI4ZAlNn2K6NNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU81Izou1PF2Fp9fIiH1cdnL6VMjoqtsbQATyxysjIM=;
 b=JlxXdwD+snLWcTzHStcwMIQCs11Y/iINYiaIaB9TrTlzA2sTGXZjmwXRLNHl0SRASDVMweMQKOEUj6BJ+L72+1zhbs5RjfNVt+3ZJs6wwUOzIY6GFjjs2oNgAjde9TCJW6js0bSQ5UNUxtcbexwzbl9krdZVvW01fXK06rbuy1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB9PR10MB8118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 21:28:23 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 21:28:23 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 10/13] i2c: rzg2l: include u-boot/schedule.h
Date: Thu,  3 Oct 2024 23:27:59 +0200
Message-ID: <20241003212802.3810-11-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003212802.3810-1-ravi@prevas.dk>
References: <20241003212802.3810-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::28) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB9PR10MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ee7002-2760-438d-078d-08dce3f24f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O3vGiUl9qkfvyI+2VVSyEBzrDUDPekoID8pL/3ptopIKOkxtyFB//GKe26VH?=
 =?us-ascii?Q?PdJJsMTAu8migHs8Zkfqof3dsnsc6L6GWi3R2GqWFVW8pDjb90F0VyZ7S8Zl?=
 =?us-ascii?Q?ydo+VL5qW+IygXPRJOcSeCdHYuV9dKoR0S8e/nnR49aLbDXBfBj/w+KpLqBu?=
 =?us-ascii?Q?gVqCkYNpACcM0D3oNUrQ1iW9CgdTPLwjNmlfP/kTa5TEPwu6Ip5SWlNvzMry?=
 =?us-ascii?Q?S8mshNMtWPFrHKo7T/KOuE0LZ3norrxf2q7VWSxbcqFV9c9j8+MnqL7qaaMC?=
 =?us-ascii?Q?0G0UKNldWomq7R7q2sQOFOpg5wjTJYsSAng9LZ9uwaXUYEXsUWrM50TjzARL?=
 =?us-ascii?Q?+MU9cR5emJLPWaPiwHNEcZgqKdApVq5yYwqTIPk+L/UhmBYNYmEhB2DrUMDO?=
 =?us-ascii?Q?ogsHTubXEO9/+/SJst4BwJl4tj7roIA42WsTgrr8wo+3z1HWwqY3ju4MPdDz?=
 =?us-ascii?Q?3bvAnXnyAJeP7d8a9uixgMgRa8PU7aSFEURwX5RkJ8YmbGNqOUkuuCdQ0z/M?=
 =?us-ascii?Q?HdyBciRZUgmFN5kcc2m3kNLPwfLLEjHF2gMQmlYAViPrYtpakTZ8ZDPv8Ava?=
 =?us-ascii?Q?4tj9mbUecm2GYEv/9ijJWjGqQXmiQPosjq5WKoFoXRT3BuDP+GWsxOMIkCmR?=
 =?us-ascii?Q?oX7m+2KOmRZu9lD1P0gpVSztD6YixkySv0pT/0nPNxBzBEsLbIyAqAyIEeNT?=
 =?us-ascii?Q?Z4g777iI+gfcVaFuqmcbIGr211/20UrRPPAt2UrrlG/CJ6Di3L14aHsmRzjq?=
 =?us-ascii?Q?gF5RNWkX8jovpWQ21yqfi7ADr5J7h1Af49uSBUwg/cEc/EjafChPQaw3V3+E?=
 =?us-ascii?Q?vtRm+BLMMuw8LTC0R3CR6wd1+QONWxiF7fWYkSL5GFDbnuOdmzlxHIeEFc0h?=
 =?us-ascii?Q?l/kOEnzKRTEB04gbPQVFT6xUMaGDOyC3GRNfCmU+nPXHMUu4WYFoRVLzzyi2?=
 =?us-ascii?Q?urRWQiV6T1t/jIUldEJqtUd2r3S20Hs8OiSizCCUqqxIllz+m0KNWn/spM3t?=
 =?us-ascii?Q?bDAcxy8JvaXVoMZtK5Hvdwa5hyz2mTqwXq8IBwCgFSHZtz6W3v7N5CvcOhOd?=
 =?us-ascii?Q?+Ly9ssTbBNn57CKVKHMiv4gzHH4SqjEDhZhSbAMNYCVMfwXJyAlf+uY3FI/H?=
 =?us-ascii?Q?HZOFVypMnVEsEEI5ILzBn/koixV11TVRgIHVjHKEVXsrbB/eUid6IELEtMCz?=
 =?us-ascii?Q?8d5gvBybDxUF8G470gJ4IKVDyJzXb0pWp9gkQjzQF3YkedN/Bjvv1CuU0Oxh?=
 =?us-ascii?Q?NsGuIx8RnuS1GqLkyxbYUQG+RE5Pjvvj9TIrMclbmaQ3UhiXQJ4Jip7R4ycB?=
 =?us-ascii?Q?hOt66fSloRJi4Va3a9KH85MrR0xcL0rT3lEU1h86/Z2Scw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pa0W1zR45V+zvlYggTWqUOxs6v1vizbG+bVHEVrlXWS6EHDSzoHnWEd9+p2K?=
 =?us-ascii?Q?YvacAco7UeL6otoiR0RDgXjoNxWOMuQNLjRHJYrSPUQT/AhosHDv1IZxMCHo?=
 =?us-ascii?Q?PF8Go6kXbOqXzgfWgKL56Z6mkZxFa3cycf811q270hRibTLA8MclXOd9Iklz?=
 =?us-ascii?Q?4eXAln/tjdkdsKsLMaNo96hUclI3PqTnq9yovyTHQSze3Euk3Cm7p0SSSY6z?=
 =?us-ascii?Q?x+oRGVVVJKrCPEV3vLrI4GsAR8vrWlQoiEmt4TCP/qTK5KgCOpg/pdUQaUR9?=
 =?us-ascii?Q?kAU5IecJaREYfeP7v8bqayG//EGgGN2t/jtC0cvOuHCNXayw4T8PyBydg/BY?=
 =?us-ascii?Q?jf6WjSoaAJJxe4Hg+MM9T6GSr7W2/J/AtxzXkI5+ji7zm332QH6sgVOTmtEb?=
 =?us-ascii?Q?eQ4d7f0LQaQpdQoRZv3uCb+6zZmO9xPZ6uHnwrRPIz5q/9IHp5qMlusH7K9y?=
 =?us-ascii?Q?w9IxpsyASCf5PkUGw0dOLcHUS9I2Bp4hs4pDFxFtVVWPgOcAAtrbQX5HHDWR?=
 =?us-ascii?Q?bRvVKJ9IpjpeaDM1dmf3i66bjeaT1C4Tk2GcM2mxnY7UssVwEK+qUKbWkjNT?=
 =?us-ascii?Q?HaPrOM+hwKmLMN8FjPgeKZxcvyLvvNqQ+XGl0Jf4pO5MMpYQSCfDwkl2Ujft?=
 =?us-ascii?Q?50sAOGmd+OvcBSZJd60Gmhwhu95qolB39iNk6R0goZ5C4V9sM04pr5yRPHth?=
 =?us-ascii?Q?IUju27PPb6yGq6sgOV9lDwXy0+H871URIKSQFbOfIs0mwjpZEJAOkXCP4luB?=
 =?us-ascii?Q?xWR0Dra9RSpRaOOMHAnMV2/oXo3DPLf1+eJFYyq/hUL4/Z8JrNtvTkAJIs9Z?=
 =?us-ascii?Q?EIIVtT1aw2nnyRSrVpWvNMdBIO/e64kox3bi77hIhKKpoKJo7tLrnISNCzVI?=
 =?us-ascii?Q?5aHj0rKg0wIJrYQ0Rx6Q2mzg9XW+P4jxsfYHr+OreVCZKTuMZYvc0G7yWFzw?=
 =?us-ascii?Q?LorXvzNUMj/+zXk/BDOAzy2zJSj5+so5Kho/+q5IOKZoLPgcVMCqhXvPEAs0?=
 =?us-ascii?Q?GR2alE86VW2Kpvayl7USp8ve35enHTQJ4VqGD07yKCooHuHH2KQy4/dFu1LZ?=
 =?us-ascii?Q?pkUbxw+gvrKsr+BZO/SgExUY2ilaXVDCKPmO9/uoUy0n+NYEf5N/tUcU1tSX?=
 =?us-ascii?Q?Mb+lcLqOS2oopZ39d+yaNSVzmcsezYDBwQZu8VSUjyW5wbZW5UnCY1tZVeVs?=
 =?us-ascii?Q?fBMX64CkXbK9gwjji58QB0ExrAgNmnJVtKCr5yQSyPlpXmGzShAcKgtBwmiE?=
 =?us-ascii?Q?z43sNdLDAKNX2z0ZihBYJDYasA0c+DmfMnR4tMkfG1MQzOi7ob7PGHjHgxlI?=
 =?us-ascii?Q?fSqyjHTTSooKOC65H8Ej1JlO9GnUEO6FsubX9BZUDPKnADPQKYUw0gh1IjBY?=
 =?us-ascii?Q?M1ifQ/kfio4WNwfnZAWc941Boh+dbxaJU2kN241ngTpeGRA8bI6+6fxn/DUX?=
 =?us-ascii?Q?X83nGgwLhrwt4/lwf4vN40CwndMaOGn321z0mYBkI2C73EhShddCUStB/Hzc?=
 =?us-ascii?Q?VeAOrBm2uxqNTZRwNhPb1QbOhWrNUeXmQBHUMOxEQnXuX/1HqFSwY2bLvthU?=
 =?us-ascii?Q?4XEIsGZCH0r5I851SxPzS67S92b3SkQCwAZ+A/Np0u7I1zUtonaRNVlNeSX1?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ee7002-2760-438d-078d-08dce3f24f52
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:28:23.2794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6k5qcY3DzOVX7eHKP6ji6PA5o1tTzjoHYIPIkVm7hqPadCjypG4+LBrZtCdVppoJJICR7B/PydU4Kjb91/3oqNVQHm1yYo6uCRtF4pzsnc=
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

This TU currently relies on getting a declaration of schedule()
through some nested include. Include the proper header directly.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/i2c/rz_riic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/rz_riic.c b/drivers/i2c/rz_riic.c
index 5f3f8d1b24b..f292c824362 100644
--- a/drivers/i2c/rz_riic.c
+++ b/drivers/i2c/rz_riic.c
@@ -14,6 +14,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <reset.h>
+#include <u-boot/schedule.h>
 #include <wait_bit.h>
 
 #define RIIC_ICCR1	0x00
-- 
2.46.2

