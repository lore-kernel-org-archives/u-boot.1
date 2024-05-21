Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776F1C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 08:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CBBC881C1;
	Tue, 21 May 2024 10:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="dT6mV8BV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57151881AA; Tue, 21 May 2024 10:47:15 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D5678811C
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 10:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xt/CzpeWyicqR+YR2yhiMi7jdATaJFpPruDNnEKsWNkl4Pn4woXKs+VCek4DUji0FHtwVMoxQeUZ7tfB3+St4zIy3dOXcFbi4s6znsKRx0uF4wLebSgYUVVbNnDwnlKLMJj/dQ/76K3KmRR+ieZylWbWUHKOabMxJmC/+cgqjh9QthdSxhwruearfSj19Zu/Be56lO5xN19opihLcsnJOxPSYm3FFP+BWzvpUCuUMEe00aP02heVZAczjiVcTfNoiUQ2gk2v0qB3ugiJPg7+C+kGqpD0QCI0btJ/EJyDJohzQCGoEr/o3EPEpLFwOplxTp6ZO0SO67pvSuXgjYdAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LCcghMLkBUWiCqQdMrvXe0dt1AZpO34J7MX6VEKngM=;
 b=MjqARLHLJBs1gS2HuENv6yvsJmufMem3Vemm04xz7U60lCJ2RUyZ21NOTY96kzPKIHtSqljAMyFHdZvabE0jECsOZUnQjYxQhdwK4tDiVlDURHJe+Ger3FMRmlPTA0UghdBwCrI4tH9fQ2UWXwhuH8EVkRq9tKFNSOohRTTRTeU8PzOPBKk9gTGxrUA5oU0RXh7HvR85K+5M69BjGa5RzXyxblLud8vK1aL10tmdQLWwfAgarMfBbkL1E6hrF6cYVp8T8W0XR7FodFJq6f0CbI2X1ftBIT645dAxYK+oszEEfLKghJrIS6u7ZrpslPD+qB6Xbi4wZra7Xl7vpwN98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LCcghMLkBUWiCqQdMrvXe0dt1AZpO34J7MX6VEKngM=;
 b=dT6mV8BV/cuJhlYMAlplz/mW4AiynQvq9+Deqt24btmgMZXpkMKVo877xJYi50bKu68BHpvBaq+QIAqQ0jJQgBSv0C4gU2ru2huwNTVHtJiFJ5Dp/7Q/ZDdxhp/ajqWMK/xEK6w3Sk15aWbkL0fdrKmXQUi8y5JQrBLPYMWWDeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU4PR10MB8709.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 08:47:09 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 08:47:09 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v4 3/3] cyclic: make clients embed a struct cyclic_info in
 their own data structure
Date: Tue, 21 May 2024 10:46:52 +0200
Message-Id: <20240521084652.1726460-4-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240521084652.1726460-1-rasmus.villemoes@prevas.dk>
References: <20240521084652.1726460-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0056.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::29) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU4PR10MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: a7fdcdb2-093f-43aa-632c-08dc797299a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|1800799015|52116005|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?23RZWsx+mwujgsPoOrUhN5Khxo3btY67HTJSC/u5gDG1WdfCW7ePXBFfAcd7?=
 =?us-ascii?Q?Ya8AoJE0nymUHPkdCAp4ZZbxXjdXgfI0FbeFeegxYU5ESIX719HvvZXJfuBm?=
 =?us-ascii?Q?lnrw93SiA0zsvDyPWx99aCE8ZXlLDoJZ8wIpH4U1q1LJhdSc6TQs/nfIT6V5?=
 =?us-ascii?Q?rwT7RtoGyh9V9gdsaTFO5oub64CPIcEbyl80A3zYwHN5GjvxD27gJrVz9q/N?=
 =?us-ascii?Q?E/4Ph+XwKLFZCktbs98drH2L5pJ0Jd84kiBeLyTsp63H49lqWleP25OKY+hW?=
 =?us-ascii?Q?KpjuHlC9NllZPr0B7TK3yNY/O1P9nAEMg6syjjtouLz7e4CzthiZuCymwCby?=
 =?us-ascii?Q?3n055+zFlYwbDBEIWlbJC6vWzvvRKLH65U5wYx3ZvXppyZ7cSLRKnvNUqqd/?=
 =?us-ascii?Q?/XxuqIXe7dkxBY/GsGpkKBDxoG6Jquw8SyEvunieWcFtzrRVnY5zh8Wq3Ohb?=
 =?us-ascii?Q?Bfz2SDh0O9kKzxTzF7ScBKBzQezFEvURDIbxxmePCSdeCpmpPSrpU9D2or2a?=
 =?us-ascii?Q?7alk2dXTK25G4Vc2FViOGTTG4Hr1mk8JJAV33d1DXnRNw+cf0eOA15pyi7Al?=
 =?us-ascii?Q?JiFO6RfSf/OQtpqUGxwowuaZZM9WWvDCGBuj17pASI77mjsZFqpWO3NxYZ+R?=
 =?us-ascii?Q?b2HgpLj+eL0lA2OM186bTI7uMmpx14HtXZeqdXjATaE2FfTMt38DkVc7w9hy?=
 =?us-ascii?Q?JZ51CLM1mlqWcRKzEGUQl2jg2cUB4rHSiXba79BBOsSOFODdi+c8ulDBtSn1?=
 =?us-ascii?Q?Fa/2YibHKulcvo6Ji6Fu0AYNBmhI7ctc6ohh6xuGQF62VuCZlxe34s4EHWNh?=
 =?us-ascii?Q?xmLYDfuhya9MuS+kY/JybSUSLrBAbmloH8y1KMYkJpjEGoAiAqMt5+Tr85nE?=
 =?us-ascii?Q?bx67d+Dd8IVLGWFJGVvgbmcQ+uk0mxgaZUgru6nwd+vn025LtKt65Gh8s9JY?=
 =?us-ascii?Q?ekxjSmKYWodZaU0lSKDI0aJ50vAbzpkYIEE9a71KFVa/ccmqhRYiKDxVQ7dB?=
 =?us-ascii?Q?wFeAeQOJE8QN9ViekDP5vlpw2zUbDzblvstThP6+Zt+INvyucn/4NwY9Ix37?=
 =?us-ascii?Q?BU7ZdIDMW86zLKjb18i5xKcr1JjT1VuJ3HKhWh/6PMN0PGUUIT++wmg82Vyw?=
 =?us-ascii?Q?l8DDapu8YHea0dTV0/nJ5dbXQt/wOv3jcrIie71c+CHGL76uKr98Vbr4z07f?=
 =?us-ascii?Q?pcBPWzv4By/u25V+ERIpaCnclONVgwAHHSyJI5twB9cfYLHsGbVgoG97fOye?=
 =?us-ascii?Q?EPnWCmjgl4hJR2UuZQR1/nEQzoymLz0K6hxIdLXzwA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1CXvms8wtXURkmqtnT9pkVgpRUPnpXWd3VGNCEdvVGIrc/DdiJ4xRnr0KYK2?=
 =?us-ascii?Q?lyxUBeIkHE1lLFqRc7Vibu1lhDZlcpcZ0kBEBOTmL2M9aRR4KLo+JHISZzp2?=
 =?us-ascii?Q?dVrlEt6gwvbZ8r9uxdyvYDG3xjkF8mjHTBFqor38WOEORLZwlGtHxnABIQkt?=
 =?us-ascii?Q?CQKVhRDfKP+jYw6fk8798J6EVhigGJtzG2xjimsNz69dPsmGiUJcHcYuTt/S?=
 =?us-ascii?Q?oMIhlwmAt1yJbTjqC9YD6kNowCLC55z21jIT1isB/Zorsx9srom9jXBbRi+F?=
 =?us-ascii?Q?2e4pdkaFHdPQHpYXafQZTRX19JrAbwyLkN9d4MTmfq7IC/tvNRGGC33msnTf?=
 =?us-ascii?Q?LalZbvM0eCllIxA7JtuTsEIe/tAPV55Q3/r7qXq2tGGhnvH9JC3CblFy/7yV?=
 =?us-ascii?Q?rLjXqVjxZWhAcDL4njdKSFNhMw2nqFipfjIyAeQPVOUNxbI7nVBO8F3oWf1J?=
 =?us-ascii?Q?Izpz3LN9KhnWsveCg5lOXKOfVcWcENJd9d9oCMZkfHgzXLxYXJZdPHYcc10s?=
 =?us-ascii?Q?69R8Q5nMuiVf+TFmOAP92mJoZJvFUCsb/Z0dF82EkdjSlkmpuwOe1MwTdPj1?=
 =?us-ascii?Q?8B2OEYmcSc1smV2mtCppnx6b7V5PWfBW+d9Kv65tl+hymQ67sZiG2XzV7L3/?=
 =?us-ascii?Q?loMnTVHX6cOFynbuod8CGy1HQ6FFZ3AWMUr4MVgSsah4UmiNC+YRNdqDWc+e?=
 =?us-ascii?Q?abkRKfLMdSgCfrXyfqXhgu/V/aX2gvZ6gMTNmrEE5mKc28FgDTd/W+jtFmb2?=
 =?us-ascii?Q?DJ7z4qWjMbTWarVwWsuhHWgz5Kn/oyp+WdccV6TepSURtXpUH5Lc6qoB6wCD?=
 =?us-ascii?Q?0imjzOY291jOdClMfYShe/K2IHBhlnkaICOSK3EzAvhYKSCoiv+ApThphA+A?=
 =?us-ascii?Q?vUp46eQtJ+hR0h25UgAgij30bMTwQSc9nOvLZZVUTYZbAo8s+CFrRTaXTUCP?=
 =?us-ascii?Q?iq1dB5YwDEuJEhmdK0FU5CgiYgSqtK6jb5UtQXfQ+en2ZF5suiGPtWItiUYU?=
 =?us-ascii?Q?G+fKiS6+P9Hm7gvsMhJ0yuwn7EPbif3kvLsd30Je/CehJShaIW9cZv/uDZVZ?=
 =?us-ascii?Q?+qDyea1qhSNaEUYbjKY3+w7KHX7etzWi6XTqyYQaO0mn8SR+BJ6RtaVud7bt?=
 =?us-ascii?Q?hMpDJJRSBugYdQA7dQBdpyWcm3ax2+G5hrs5S2+Q7OrN/sZBXl9HxP9Z+XqG?=
 =?us-ascii?Q?+bXmO83bEct5XwRORCRmimQHAzFpc4vxaZAe47EgIMCws4odbK0EfYz9iu3r?=
 =?us-ascii?Q?jULqZ7HQJg/bzNUmLTZpGx8nfKSTo8B/nun87kE78U44TIcl4fPQ6E68dW4e?=
 =?us-ascii?Q?C3n9DP9TSVyE4viXK8NrB54yDOnzxKnA0UZL79x93JVuc72JEL002udSRKTe?=
 =?us-ascii?Q?Np3aP3JsZOohCUHX/zPhf/h8F/wJYQ/IvMU3zMkRNBOgVsL81CPYp0TAradj?=
 =?us-ascii?Q?Abrxy0fa308iFvPscUjcQDowx9CZPmhbUjXk9aWAhzaIUlcHYCB23JQ1K2C/?=
 =?us-ascii?Q?lsuDKFt41uB6M7xgfDKIwtHSxdcKyIaNWSCquOjosXY/UASYghF6IKWr8c6W?=
 =?us-ascii?Q?15F4E7iMtdaEIh+L+JD0KZQ7V0N1u1OaV15pCOCSzU4NG3BtMN2rrnCCGz3m?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fdcdb2-093f-43aa-632c-08dc797299a0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 08:47:09.1639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eh2pT/xT9lZqKfJQFj0B1YADslSJ8n3Cg/9Kdae+AEpm1W2tNhP2r7W1Nj+ZX+CTFGfYUE4uNzMwq6uY1GyYS9rPgLH3bSint7u59XxrrHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8709
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

There are of course not a whole lot of examples in-tree yet, but
before they appear, let's make this API change: Instead of separately
allocating a 'struct cyclic_info', make the users embed such an
instance in their own structure, and make the convention that the
callback simply receives the 'struct cyclic_info *', from which the
clients can get their own data using the container_of() macro.

This has a number of advantages.

First, it means cyclic_register() simply cannot fail, simplifying the
code. The necessary storage will simply be allocated automatically
when the client's own structure is allocated (often via
uclass_priv_auto or similar).

Second, code for which CONFIG_CYCLIC is just an option can more easily
be written without #ifdefs, if we just provide an empty struct
cyclic_info {}. For example, the nested CONFIG_IS_ENABLED()s in
https://lore.kernel.org/u-boot/20240316201416.211480-1-marek.vasut+renesas@mailbox.org/
are mostly due to the existence of the 'struct cyclic_info *' member
being guarded by #ifdef CONFIG_CYCLIC.

And we do probably want to avoid the extra memory overhead of that
member when !CONFIG_CYCLIC. But that is automatic if, instead of a
'struct cyclic_info *', one simply embeds a 'struct cyclic_info',
which will have size 0 when !CONFIG_CYCLIC. Also, the no-op
cyclic_register() function can just unconditionally be called, and the
compiler will see that (1) the callback is referenced, so not emit a
warning for a maybe-unused function and (2) see that it can actually
never be reached, so not emit any code for it.

Reviewed-by: Stefan Roese <sr@denx.de>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 board/Marvell/octeon_nic23/board.c |  9 +++++---
 cmd/cyclic.c                       | 12 +++++-----
 common/cyclic.c                    | 22 +++++--------------
 doc/develop/cyclic.rst             | 26 +++++++++++++---------
 drivers/watchdog/wdt-uclass.c      | 33 +++++++++++++---------------
 include/cyclic.h                   | 35 +++++++++++++++---------------
 test/common/cyclic.c               | 19 ++++++++++------
 7 files changed, 77 insertions(+), 79 deletions(-)

diff --git a/board/Marvell/octeon_nic23/board.c b/board/Marvell/octeon_nic23/board.c
index bc9332cb74a..74b9c741b7b 100644
--- a/board/Marvell/octeon_nic23/board.c
+++ b/board/Marvell/octeon_nic23/board.c
@@ -357,10 +357,13 @@ int board_late_init(void)
 	board_configure_qlms();
 
 	/* Register cyclic function for PCIe FLR fixup */
-	cyclic = cyclic_register(octeon_board_restore_pf, 100,
-				 "pcie_flr_fix", NULL);
-	if (!cyclic)
+	cyclic = calloc(1, sizeof(*cyclic));
+	if (cyclic) {
+		cyclic_register(cyclic, octeon_board_restore_pf, 100,
+				"pcie_flr_fix");
+	} else {
 		printf("Registering of cyclic function failed\n");
+	}
 
 	return 0;
 }
diff --git a/cmd/cyclic.c b/cmd/cyclic.c
index 40e966de9aa..339dd4a7bce 100644
--- a/cmd/cyclic.c
+++ b/cmd/cyclic.c
@@ -15,14 +15,16 @@
 #include <time.h>
 #include <vsprintf.h>
 #include <linux/delay.h>
+#include <linux/kernel.h>
 
 struct cyclic_demo_info {
+	struct cyclic_info cyclic;
 	uint delay_us;
 };
 
-static void cyclic_demo(void *ctx)
+static void cyclic_demo(struct cyclic_info *c)
 {
-	struct cyclic_demo_info *info = ctx;
+	struct cyclic_demo_info *info = container_of(c, struct cyclic_demo_info, cyclic);
 
 	/* Just a small dummy delay here */
 	udelay(info->delay_us);
@@ -32,7 +34,6 @@ static int do_cyclic_demo(struct cmd_tbl *cmdtp, int flag, int argc,
 			  char *const argv[])
 {
 	struct cyclic_demo_info *info;
-	struct cyclic_info *cyclic;
 	uint time_ms;
 
 	if (argc < 3)
@@ -48,10 +49,7 @@ static int do_cyclic_demo(struct cmd_tbl *cmdtp, int flag, int argc,
 	info->delay_us = simple_strtoul(argv[2], NULL, 0);
 
 	/* Register demo cyclic function */
-	cyclic = cyclic_register(cyclic_demo, time_ms * 1000, "cyclic_demo",
-				 info);
-	if (!cyclic)
-		printf("Registering of cyclic_demo failed\n");
+	cyclic_register(&info->cyclic, cyclic_demo, time_ms * 1000, "cyclic_demo");
 
 	printf("Registered function \"%s\" to be executed all %dms\n",
 	       "cyclic_demo", time_ms);
diff --git a/common/cyclic.c b/common/cyclic.c
index c62e7fa7d19..ec38fad6775 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -26,34 +26,22 @@ struct hlist_head *cyclic_get_list(void)
 	return (struct hlist_head *)&gd->cyclic_list;
 }
 
-struct cyclic_info *cyclic_register(cyclic_func_t func, uint64_t delay_us,
-				    const char *name, void *ctx)
+void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
+		     uint64_t delay_us, const char *name)
 {
-	struct cyclic_info *cyclic;
-
-	cyclic = calloc(1, sizeof(struct cyclic_info));
-	if (!cyclic) {
-		pr_debug("Memory allocation error\n");
-		return NULL;
-	}
+	memset(cyclic, 0, sizeof(*cyclic));
 
 	/* Store values in struct */
 	cyclic->func = func;
-	cyclic->ctx = ctx;
 	cyclic->name = name;
 	cyclic->delay_us = delay_us;
 	cyclic->start_time_us = timer_get_us();
 	hlist_add_head(&cyclic->list, cyclic_get_list());
-
-	return cyclic;
 }
 
-int cyclic_unregister(struct cyclic_info *cyclic)
+void cyclic_unregister(struct cyclic_info *cyclic)
 {
 	hlist_del(&cyclic->list);
-	free(cyclic);
-
-	return 0;
 }
 
 void cyclic_run(void)
@@ -76,7 +64,7 @@ void cyclic_run(void)
 		if (time_after_eq64(now, cyclic->next_call)) {
 			/* Call cyclic function and account it's cpu-time */
 			cyclic->next_call = now + cyclic->delay_us;
-			cyclic->func(cyclic->ctx);
+			cyclic->func(cyclic);
 			cyclic->run_cnt++;
 			cpu_time = timer_get_us() - now;
 			cyclic->cpu_time_us += cpu_time;
diff --git a/doc/develop/cyclic.rst b/doc/develop/cyclic.rst
index 67831496a70..893c269099a 100644
--- a/doc/develop/cyclic.rst
+++ b/doc/develop/cyclic.rst
@@ -19,20 +19,26 @@ Registering a cyclic function
 
 To register a cyclic function, use something like this::
 
-    static void cyclic_demo(void *ctx)
+    struct donkey {
+        struct cyclic_info cyclic;
+        void (*say)(const char *s);
+    };
+
+    static void cyclic_demo(struct cyclic_info *c)
     {
-        /* Just a small dummy delay here */
-        udelay(10);
+        struct donkey *donkey = container_of(c, struct donkey, cyclic);
+
+        donkey->say("Are we there yet?");
     }
-    
-    int board_init(void)
+
+    int donkey_init(void)
     {
-        struct cyclic_info *cyclic;
-        
+        struct donkey *donkey;
+
+        /* Initialize donkey ... */
+
         /* Register demo cyclic function */
-        cyclic = cyclic_register(cyclic_demo, 10 * 1000, "cyclic_demo", NULL);
-        if (!cyclic)
-        printf("Registering of cyclic_demo failed\n");
+        cyclic_register(&donkey->cyclic, cyclic_demo, 10 * 1000, "cyclic_demo");
         
         return 0;
     }
diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index 12850016c93..e2e7f9ab84b 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -17,12 +17,15 @@
 #include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
+#include <linux/kernel.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
 #define WATCHDOG_TIMEOUT_SECS	(CONFIG_WATCHDOG_TIMEOUT_MSECS / 1000)
 
 struct wdt_priv {
+	/* The udevice owning this wdt_priv. */
+	struct udevice *dev;
 	/* Timeout, in seconds, to configure this device to. */
 	u32 timeout;
 	/*
@@ -40,18 +43,17 @@ struct wdt_priv {
 	/* autostart */
 	bool autostart;
 
-	struct cyclic_info *cyclic;
+	struct cyclic_info cyclic;
 };
 
-static void wdt_cyclic(void *ctx)
+static void wdt_cyclic(struct cyclic_info *c)
 {
-	struct udevice *dev = ctx;
-	struct wdt_priv *priv;
+	struct wdt_priv *priv = container_of(c, struct wdt_priv, cyclic);
+	struct udevice *dev = priv->dev;
 
 	if (!device_active(dev))
 		return;
 
-	priv = dev_get_uclass_priv(dev);
 	if (!priv->running)
 		return;
 
@@ -124,20 +126,14 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 		memset(str, 0, 16);
 		if (IS_ENABLED(CONFIG_WATCHDOG)) {
 			if (priv->running)
-				cyclic_unregister(priv->cyclic);
+				cyclic_unregister(&priv->cyclic);
 
 			/* Register the watchdog driver as a cyclic function */
-			priv->cyclic = cyclic_register(wdt_cyclic,
-						       priv->reset_period * 1000,
-						       dev->name, dev);
-			if (!priv->cyclic) {
-				printf("cyclic_register for %s failed\n",
-				       dev->name);
-				return -ENODEV;
-			} else {
-				snprintf(str, 16, "every %ldms",
-					 priv->reset_period);
-			}
+			cyclic_register(&priv->cyclic, wdt_cyclic,
+					priv->reset_period * 1000,
+					dev->name);
+
+			snprintf(str, 16, "every %ldms", priv->reset_period);
 		}
 
 		priv->running = true;
@@ -162,7 +158,7 @@ int wdt_stop(struct udevice *dev)
 		struct wdt_priv *priv = dev_get_uclass_priv(dev);
 
 		if (IS_ENABLED(CONFIG_WATCHDOG) && priv->running)
-			cyclic_unregister(priv->cyclic);
+			cyclic_unregister(&priv->cyclic);
 
 		priv->running = false;
 	}
@@ -262,6 +258,7 @@ static int wdt_pre_probe(struct udevice *dev)
 			autostart = true;
 	}
 	priv = dev_get_uclass_priv(dev);
+	priv->dev = dev;
 	priv->timeout = timeout;
 	priv->reset_period = reset_period;
 	priv->autostart = autostart;
diff --git a/include/cyclic.h b/include/cyclic.h
index 38946216fb8..2c3d383c5ef 100644
--- a/include/cyclic.h
+++ b/include/cyclic.h
@@ -18,7 +18,6 @@
  * struct cyclic_info - Information about cyclic execution function
  *
  * @func: Function to call periodically
- * @ctx: Context pointer to get passed to this function
  * @name: Name of the cyclic function, e.g. shown in the commands
  * @delay_ns: Delay is ns after which this function shall get executed
  * @start_time_us: Start time in us, when this function started its execution
@@ -27,10 +26,12 @@
  * @next_call: Next time in us, when the function shall be executed again
  * @list: List node
  * @already_warned: Flag that we've warned about exceeding CPU time usage
+ *
+ * When !CONFIG_CYCLIC, this struct is empty.
  */
 struct cyclic_info {
-	void (*func)(void *ctx);
-	void *ctx;
+#if defined(CONFIG_CYCLIC)
+	void (*func)(struct cyclic_info *c);
 	const char *name;
 	uint64_t delay_us;
 	uint64_t start_time_us;
@@ -39,31 +40,34 @@ struct cyclic_info {
 	uint64_t next_call;
 	struct hlist_node list;
 	bool already_warned;
+#endif
 };
 
 /** Function type for cyclic functions */
-typedef void (*cyclic_func_t)(void *ctx);
+typedef void (*cyclic_func_t)(struct cyclic_info *c);
 
 #if defined(CONFIG_CYCLIC)
 /**
  * cyclic_register - Register a new cyclic function
  *
+ * @cyclic: Cyclic info structure
  * @func: Function to call periodically
  * @delay_us: Delay is us after which this function shall get executed
  * @name: Cyclic function name/id
- * @ctx: Context to pass to the function
- * @return: pointer to cyclic_struct if OK, NULL on error
+ *
+ * The function @func will be called with @cyclic as its
+ * argument. @cyclic will usually be embedded in some device-specific
+ * structure, which the callback can retrieve using container_of().
  */
-struct cyclic_info *cyclic_register(cyclic_func_t func, uint64_t delay_us,
-				    const char *name, void *ctx);
+void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
+		     uint64_t delay_us, const char *name);
 
 /**
  * cyclic_unregister - Unregister a cyclic function
  *
  * @cyclic: Pointer to cyclic_struct of the function that shall be removed
- * @return: 0 if OK, -ve on error
  */
-int cyclic_unregister(struct cyclic_info *cyclic);
+void cyclic_unregister(struct cyclic_info *cyclic);
 
 /**
  * cyclic_unregister_all() - Clean up cyclic functions
@@ -97,17 +101,14 @@ void cyclic_run(void);
  */
 void schedule(void);
 #else
-static inline struct cyclic_info *cyclic_register(cyclic_func_t func,
-						  uint64_t delay_us,
-						  const char *name,
-						  void *ctx)
+
+static inline void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
+				   uint64_t delay_us, const char *name)
 {
-	return NULL;
 }
 
-static inline int cyclic_unregister(struct cyclic_info *cyclic)
+static inline void cyclic_unregister(struct cyclic_info *cyclic)
 {
-	return 0;
 }
 
 static inline void cyclic_run(void)
diff --git a/test/common/cyclic.c b/test/common/cyclic.c
index 461f8cf91f4..51a07c576b6 100644
--- a/test/common/cyclic.c
+++ b/test/common/cyclic.c
@@ -12,22 +12,27 @@
 #include <linux/delay.h>
 
 /* Test that cyclic function is called */
-static bool cyclic_active = false;
+static struct cyclic_test {
+	struct cyclic_info cyclic;
+	bool called;
+} cyclic_test;
 
-static void cyclic_test(void *ctx)
+static void test_cb(struct cyclic_info *c)
 {
-	cyclic_active = true;
+	struct cyclic_test *t = container_of(c, struct cyclic_test, cyclic);
+	t->called = true;
 }
 
 static int dm_test_cyclic_running(struct unit_test_state *uts)
 {
-	cyclic_active = false;
-	ut_assertnonnull(cyclic_register(cyclic_test, 10 * 1000, "cyclic_demo",
-					 NULL));
+	cyclic_test.called = false;
+	cyclic_register(&cyclic_test.cyclic, test_cb, 10 * 1000, "cyclic_test");
 
 	/* Execute all registered cyclic functions */
 	schedule();
-	ut_asserteq(true, cyclic_active);
+	ut_asserteq(true, cyclic_test.called);
+
+	cyclic_unregister(&cyclic_test.cyclic);
 
 	return 0;
 }
-- 
2.40.1.1.g1c60b9335d

