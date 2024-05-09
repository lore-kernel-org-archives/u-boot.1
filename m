Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B28C04FFE
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 00:48:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6509788472;
	Thu,  9 May 2024 02:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="fzC5MsX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E52B188472; Thu,  9 May 2024 02:47:31 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 028B388445
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 02:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwLpxu3sc0O5eC2OSUTlPnc7WXeSW7zLkFL20EhQJCwMATZazxmOpYhQmbCuVD9Gxm7e+sb1OE2sDRcjzyROvvSaIyUEUP9aDPKxw2BAgRjBFngo+2JVgcNWsjnvJU3diJYOG1uzIFV1uduQKNgP5MFA9tY+VWqT4z6zVv4Q4M18iT+0Zjulk2dCqIwf17dyav2wfukg3QKbx0TLgrLHUmrjiJEpJhc/J3ye7vRDVJ0o7gywGTNGCzsb2qVFx2Z3eivtl2K2ld+C7t3m9So+OmnacRLaVEMAgAZQe3aebzQlq1iuVd81A0hBnU81T3qR7fGBDLyMXHgipT7R8qv5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyreIx7bNiw1sIPYVXPE3aZ63Gu7tIMblN1UkIOGibg=;
 b=k+QGTvTFLb5yVUdRrEaVuvL5KzA0VbraEcQjW4f7kyBFCQ/i/9J1mvTBgIZ473BaR1MdiTYXzx4K5WZgr80Rfd/4aJ7YmZc1Tr2JdYII+oPbfnL546zaGJC6h6/hLgd+5QJruJFoIsrexk4okeG0KNpJwzix8Q2ZuCst1MX75zndrIgSEgLFkarnBH92gtJLlz/w0AO35+UVvX1xSwAv/NwkoWg2UE05URpFCPzbkbiucemOKAvaRgS3BSQSacri0oWpyXERSvXGIvTBkbq52qTw0g9CZNH6cvxC+6sUQdb4y2Oju0mHgEzsh6BSdGCLRuJ1AQoige1U/mo8p7b4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyreIx7bNiw1sIPYVXPE3aZ63Gu7tIMblN1UkIOGibg=;
 b=fzC5MsX8RCazFPBng1UaePr/GgvawS4xRGG7Hfp5oYRKDSezDIMudAR8nc5R3tN1SePW11erUbFP3Qzbf3/rwTFvmsPEaPPZhR9opUo+L8uO2i2oJbBoIczcI+I9Jl1NrHPGT8HZq0Cl9bxyFiQpnsfTqeq7MFEcudE1e0pAdd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS4PR10MB6063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:582::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 00:47:24 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 00:47:24 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 3/3] cyclic: make clients embed a struct cyclic_info in their
 own data structure
Date: Thu,  9 May 2024 02:47:14 +0200
Message-Id: <20240509004714.1394547-4-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240509004714.1394547-1-rasmus.villemoes@prevas.dk>
References: <20240509004714.1394547-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0105.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS4PR10MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a47783-6b54-4cbd-9416-08dc6fc1979d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|52116005|1800799015|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?De/AWG3L5xcGcIYau+sHwjai4wY3c4r1kOkugTOwaLfQ6AG58xwAj2Ix+eTP?=
 =?us-ascii?Q?ZaVVKVzkFazrbnrjNSc/op9cwaw0nlzZgTpEcv9pAujDDZv6aSuwdr4CniUK?=
 =?us-ascii?Q?EVNy0WoZKMhCoveHnbNvcDarVOHujVCTJsbsIRSxxDOGBwXWt/eHiVk+smiF?=
 =?us-ascii?Q?mXvVHzKBC5Sk4Z/TqUShgQgOD3t3cW8XHwGc3ejIza76Ntv2sv5a+7HEAVnR?=
 =?us-ascii?Q?3gS0UaZvJerSCwjddBRJgqHAEEjf8GKEd14qqJAQDTakEWlXpgJZsSA95ObR?=
 =?us-ascii?Q?IPUoeSgLqX9Qdr1agjfRb+ZIzfPEXshI4i1KtUBJlEi/cJfy7omd6YbkhgMr?=
 =?us-ascii?Q?FD++/XToBJnKmypdmZZvRgV146Tpwb9IGSLxHbTukJpF3moTU01cLBiITG1N?=
 =?us-ascii?Q?8GQXwncX7JXKT2bwt17Lq6WqUI+gW2erZLUpJg3n+phdmml3/qfH49pp00gO?=
 =?us-ascii?Q?Hd2jMIqsUetmkd9vV0besRh1RAwPDV4o9bQL9YlmPIDsF0Stm5j6uSHoaqy6?=
 =?us-ascii?Q?j4H16VS38XO8hG+HAVTuv3KVPPdMwoKRKZkuL2fgvGNz0lKke2XL7RS9BRaU?=
 =?us-ascii?Q?0TB7Xu536np0ds045KER9TIXa5RAE2iJiSqC2k0CqJpbWMyNtZLIqHAXavSc?=
 =?us-ascii?Q?6rAh2/7/s9yJnlR6rhKdUyjaXcNCMmYvi5Ge+fB0lJMU0eNgAS6h/PXobBvI?=
 =?us-ascii?Q?scfUWM5HczTGPfPS3VdX7VUUTIb1Z39SzqJjMdkiucYXCOa+c0x7lF9SY85U?=
 =?us-ascii?Q?coq58Va3E3TxXqYvfo190xD+iIONC3KlW+lIkdj10h5vjizxNPHZc8R68Lpz?=
 =?us-ascii?Q?CCM4cCYKthsXcvCE/soLPFIj6CT3EtWOsMbCrAyeOP9UAtpR8eq2mdJoSPxJ?=
 =?us-ascii?Q?VEbeesBVZQVaYoe1qBy2r4QgB5JJE+g1JhDh+GWN1KvRJFIL3ZpQ/EnLI3+A?=
 =?us-ascii?Q?g6ceGYPkwFJI8N5QEOHeMd4GuLJ8+57jXYaMKRaGziiGuNfdoGZH70w6CGeE?=
 =?us-ascii?Q?tfegxfyFeznm7LFroETC8qT37evZ91I3s8YXFee+r7+89y3s6lOEMAgOQigV?=
 =?us-ascii?Q?Ot9DjMZUFytCjfF3uIu1+JF+hQ7+7S12TN2lB3M0C+IiqCpk52W2lzbtDg/4?=
 =?us-ascii?Q?ZsZ9xSk4m5YC4KnMMAzBjWQkvc6FmuUiqyerGYGZt7Hwx2xBiHPJVrnc7itr?=
 =?us-ascii?Q?hjR/TP96zb7pGaYdE6IB3YALzrzGEASVyL6tKfc6FcZtvaDY5xJson2WMgut?=
 =?us-ascii?Q?mq8orPCkpzgzOvnBa/7eNp9ZzQ3BUq/+Yz2XcJYcUw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KSRxEJLq+2LfXX/WYOXNcD0cPsFeS7pCSyEKVLT5lHKlDzZAxU1eIeYahelC?=
 =?us-ascii?Q?nG/wL6VFx66wQCIiqIk882bUB/WLJzg6mWBiblEp2DoUdrycnlJhcVUK3H/l?=
 =?us-ascii?Q?F2qOxlLfS9+CiNS9+rhnorDcf3g+5ESdea5E4Q5776bxarHeWiOpqh3NYvON?=
 =?us-ascii?Q?AWNcOrzVUNiGYhvfEyzMPTDIeBtsJoE0qwBwTwwc8PFHM/ah0B9gfeO8s4u0?=
 =?us-ascii?Q?N3XuqvWRu1gTI+fq24jX7JZbfVNdJbsO3B0uyeBs6Uv/9Xgj1r7KMybpN2cj?=
 =?us-ascii?Q?tWaAL48npftLGuv+mL8CJFsdchrcBkYggf0h9ykhdjvpsMgkN86B8n5WFms1?=
 =?us-ascii?Q?5E7Wa5ZWbgesng0R5XIfEiVrmLba53QmVNkbaQy3YzapRBa/k6sJ+HP/xE10?=
 =?us-ascii?Q?Hw3mu8pyc0tbCLyAKiuRrk9GsDbA2ZxbvU2oGnbYyxN8Er/eQPLQ6QYDB4yF?=
 =?us-ascii?Q?CSHkuzEDeo2DlYSQFNhYQDDBNotuzY5tpWPaOQtBy1OdeW6qJt04t+jg7W9e?=
 =?us-ascii?Q?zQttnl+FhMQhlXx0O11qtyykmJ2Fb5npbZtuGwMI9YNYcRSb0J9SBwaDVMbb?=
 =?us-ascii?Q?A2ULy6baalrn6IPU2fMb5lBZ/kHO3wi0xrWaRUAAoB4Nt9HLai+TCoDfsd/b?=
 =?us-ascii?Q?lUGPDzjKNDN+w0uT/c5O68oKf2CR9qslv8Z4AbD79eIVMdoMkWVgBWNRmJ2f?=
 =?us-ascii?Q?TWsdLSOuLCJLggFQhuVOQ3tkbK+I1uUSK2RRpNAV4yhcj47ZXBvS1kpBiMGo?=
 =?us-ascii?Q?IKGMkB3Fval+pmnf6Hhd5dD+PgRP8B1VkEoUzJ0d7b/hKJ2zpmd04UMU3X5q?=
 =?us-ascii?Q?MYYm03l+z8jOw7qoHMdVkhv2Yp07R9u9JczvUddf0ildE/Ogf83V0DQ0XQvh?=
 =?us-ascii?Q?+R5TrzSKIHmMwdZVF8lK8keSLzgmO5Nz974/ergm+3Fe17NtqT/vT1KW2a5P?=
 =?us-ascii?Q?UpvIkNqKLQNEzfpC418E2B4v4rES3eguqiDWtR0GnzdPaLcmv/0HoI+f/Xx6?=
 =?us-ascii?Q?fI/18j1aMJIG2iHOBH20ti1SeYvfcWlpDryWnpTAvropUjLQjHPBUskpREvK?=
 =?us-ascii?Q?/bTr8H2TGmlALkHd4zxkHDJJUB7vEDOLtZ/qmeEOAKlWyXooJM51W4xfsDjI?=
 =?us-ascii?Q?vKLaSzVUkx19BPCrJK7L/+QHHXyR7o6BOY2qK/vYgnahsbYiTYfXuidKOwJl?=
 =?us-ascii?Q?Ihf29F8G/6jJCkyayfsBneGVJqLSvtq6V7mRO0HpIR8fsaknUXcDB4PzKziL?=
 =?us-ascii?Q?B4nPCps6V+q6eBBQEYyGz8OsAFkC3/b/SeiR+2UA3KMOCdLeiQsqT7sghEg4?=
 =?us-ascii?Q?ukBK3SaM5dpdhVj8P/ILm0dIgPQkIhsrmez4KYTedsB6zG/CMBgm24vyPi7N?=
 =?us-ascii?Q?loYcScZA240dLk8HCy7/f7oFqa0A1B/grg/98X1jjne/34gsWOZHcovjVelH?=
 =?us-ascii?Q?9fg6Ej6DwPbPqK6nRMGA30usHtD0MiRLRsyaYuWwFblbBglwKn05ZWKZ/Q3V?=
 =?us-ascii?Q?aWujXpLf8HXzdbwIXz5PUuo+Rpkz5jnFL7kxiiYv6Rc71xoytGnNQYfuesQ+?=
 =?us-ascii?Q?a4laf0F/uDoGU6UV7CzQRUWiqpSQD9SLlEieJu03HpBF6CyuRmx1oJdaNSIS?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a47783-6b54-4cbd-9416-08dc6fc1979d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 00:47:24.3858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaqECH53I785Ie8COVnXgg1jmFOMpdOVfkTBDyRVIWK4kMl4uYen0avaWpAO3tHdKv2G3dqEfYMpQwabKaWrFF1PBTGOy5bk6eyJJe7GPE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6063
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

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 board/Marvell/octeon_nic23/board.c |  9 +++++---
 cmd/cyclic.c                       | 12 +++++------
 common/cyclic.c                    | 22 +++++--------------
 doc/develop/cyclic.rst             | 26 ++++++++++++++---------
 drivers/watchdog/wdt-uclass.c      | 33 +++++++++++++----------------
 include/cyclic.h                   | 34 +++++++++++++++---------------
 6 files changed, 64 insertions(+), 72 deletions(-)

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
index ad7fc3b975e..315546515f0 100644
--- a/cmd/cyclic.c
+++ b/cmd/cyclic.c
@@ -14,14 +14,16 @@
 #include <div64.h>
 #include <malloc.h>
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
@@ -31,7 +33,6 @@ static int do_cyclic_demo(struct cmd_tbl *cmdtp, int flag, int argc,
 			  char *const argv[])
 {
 	struct cyclic_demo_info *info;
-	struct cyclic_info *cyclic;
 	uint time_ms;
 
 	if (argc < 3)
@@ -47,10 +48,7 @@ static int do_cyclic_demo(struct cmd_tbl *cmdtp, int flag, int argc,
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
index 67831496a70..bcc1ca6ce6d 100644
--- a/doc/develop/cyclic.rst
+++ b/doc/develop/cyclic.rst
@@ -19,20 +19,26 @@ Registering a cyclic function
 
 To register a cyclic function, use something like this::
 
-    static void cyclic_demo(void *ctx)
+    struct donkey {
+        struct cyclic_info cyclic;
+	void (*say)(const char *s);
+    };
+
+    static void cyclic_demo(struct cyclic_info *c)
     {
-        /* Just a small dummy delay here */
-        udelay(10);
+        struct donkey *donkey = container_of(c, struct donkey, cyclic);
+
+	donkey->say("Are we there yet?");
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
index caa1567e0c3..c0332f39dfb 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -18,12 +18,15 @@
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
@@ -41,18 +44,17 @@ struct wdt_priv {
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
 
@@ -125,20 +127,14 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
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
@@ -163,7 +159,7 @@ int wdt_stop(struct udevice *dev)
 		struct wdt_priv *priv = dev_get_uclass_priv(dev);
 
 		if (IS_ENABLED(CONFIG_WATCHDOG) && priv->running)
-			cyclic_unregister(priv->cyclic);
+			cyclic_unregister(&priv->cyclic);
 
 		priv->running = false;
 	}
@@ -263,6 +259,7 @@ static int wdt_pre_probe(struct udevice *dev)
 			autostart = true;
 	}
 	priv = dev_get_uclass_priv(dev);
+	priv->dev = dev;
 	priv->timeout = timeout;
 	priv->reset_period = reset_period;
 	priv->autostart = autostart;
diff --git a/include/cyclic.h b/include/cyclic.h
index 38946216fb8..dc0749ba03d 100644
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
@@ -29,8 +28,7 @@
  * @already_warned: Flag that we've warned about exceeding CPU time usage
  */
 struct cyclic_info {
-	void (*func)(void *ctx);
-	void *ctx;
+	void (*func)(struct cyclic_info *c);
 	const char *name;
 	uint64_t delay_us;
 	uint64_t start_time_us;
@@ -42,28 +40,30 @@ struct cyclic_info {
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
@@ -97,17 +97,17 @@ void cyclic_run(void);
  */
 void schedule(void);
 #else
-static inline struct cyclic_info *cyclic_register(cyclic_func_t func,
-						  uint64_t delay_us,
-						  const char *name,
-						  void *ctx)
+
+struct cyclic_info {
+};
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
-- 
2.40.1.1.g1c60b9335d

