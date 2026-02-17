Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4157AE68176
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 11:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B138B83AC5;
	Tue, 17 Feb 2026 12:53:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="RLhvozsT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6944E83C72; Tue, 17 Feb 2026 12:53:44 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C05DD83C72
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 12:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUmyNFPQmW7rbZFHy7QMwlSiyYEyC581m7bzjlYkLP/WMmE3EclZ4rah7um4VcOK+FdGoi7aqrWaKYbX67Sp9nnrcEsKB11ZQn+RfKOOQQ1P5yCTYuvrIoddo++BnuUfUw4Vq7gfhbYf6aXM4exaO2cqCAw/Uryb7G3F30IqwDvdAOBv2MfSKTb7y6RIfHxUsqB2h22BfvJ1Ilp059JuyJIF1b7IqC0JqfekE7zZc0RHZ+6mBvceN1qsZC1OuNkl9BG9VcyH9OJwZOc8M7ayRCtiU93U1lKELPI766s4HR8584jRR/ohjO1dKs2kK8q9/SOQ0rzRZacy0K5cN/5YlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiuHgs3Kki0ZeBz8l7YxkWwGdBTr96MtaMePxHyEqm8=;
 b=WI01WbLWjUjkkxQ7H9/1J98ePbrhKE+7n/fXvb0lJwsyRZhIus6Puf9gsiaCgNidk8oqs/UGp7siF2MVZaoingcq2LvWfZgurF4Ah3VcJHhHX2+V/hP6QrKUalW+goINFSokU/9eKy9MfeaQzHVCrHef09UJyRiBId0X8+VqSV87IiOXE/9efUfB1XaJ8A3WaKVUV64+CoafNtcjvVz+GUl27G8fUYaPaBcDuZPnt6n1nmGYL/c6Icu/0BPRjGxM434MfkYEs+S2uWahHLScTfogaRwL4XvnFsIYOWRY44Zb/4td9V72sr191Uuo14ewQjucyzudJY0xBRl7pS8sAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiuHgs3Kki0ZeBz8l7YxkWwGdBTr96MtaMePxHyEqm8=;
 b=RLhvozsTjidGNQ1McCZ74HB/PGTE3O82a/AHYoY8qKNtaH/BJw/wumbcYXt6Vq9RrSgiKW8adKddU8687mNWDhjrIiRdJU6dp82kX1BTD3Lk+ROUlDHT77VqHSm1DZSkcaaGRC/lYyL73BuFCDDrSNFCa9W/95SMhz82LZtX1Bd721ywO7lwyX1dBWcKv+Da0ZxPKSOJs5uK687BXGAX7q3jo5Keh9kQFCmQim6kF6BdFrhbaf1iEbxD4YktFUz0GyDOdUZ5M0JM1eVZeA6R6U/hGXML18BPpoRJBuu8QNVylj94oVRtWGRovC8NFHQeg28qmmeMIItGJulAPfn9qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DBBPR03MB6761.eurprd03.prod.outlook.com (2603:10a6:10:1f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 11:53:38 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9611.012; Tue, 17 Feb 2026
 11:53:38 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, ilias.apalodimas@linaro.org,
 trini@konsulko.com, simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v6 2/6] binman: Accept pkcs11 URI tokens for capsule updates
Date: Tue, 17 Feb 2026 12:53:28 +0100
Message-ID: <20260217115333.503359-3-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
References: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0074.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::7) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DBBPR03MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: e54af421-8018-418d-b195-08de6e1b2fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dnP7+2QOMijzntcmWtzGYALAS325nUvkBTnfuDbEjHyHccP0oSMyfhO97xR3?=
 =?us-ascii?Q?Xhh/uuzWdkGX2pNu1XwR75ex8+ydydy9fqohADeAJo4uv6Ti5WSUyKfYdPCS?=
 =?us-ascii?Q?9AKmPHelL2rAZHGmQKlVCBlJD7e9BStda9F4KL3A9uqEqQ91hqHebjrOIG8M?=
 =?us-ascii?Q?GwLuOFm7JOi9ah+/Vhep6IVB0IdrCO8KJAt2sG8iHCcKwy7KvaKK/ejKV5vb?=
 =?us-ascii?Q?xJEqgmb528zOLPHoFz2lH6RhDD4brel187W8iY4RsEHuHzAJXEJEvaHO/R0p?=
 =?us-ascii?Q?oRFhuWx7LJ18Q/HvwVBS4LMeeIC/U7kjYuBJsb2Qv3I9aQ6DNOYcGXPC3cYY?=
 =?us-ascii?Q?MwAvF0rLodA+SyVpnpg08TqX9CM/ZgUpdSXMa9nI22Vz3QggfDtzQogW8+Ne?=
 =?us-ascii?Q?+bbVE2Df+2DCA9BZi7UTZxcP2paDVK9DYTmWuIuyr9bdb/mdMpi8vXBgGug9?=
 =?us-ascii?Q?xqRieS5zkJRXLgmgEP/9yeif1Ye/n8DR3TIXidtUHKDlvY6HpPhnGFTuAYJT?=
 =?us-ascii?Q?mTPRdiKRF1zRabcISBgDh9mY3jBb4H4BzGsphZeiebOF8n6ZAQoZqp7Q9yvQ?=
 =?us-ascii?Q?IQNjuJJO1WjSXEYoCSccsXhHZv52KjfhZd59UBU/yrfrUJpjF6h+vg1Cd+iY?=
 =?us-ascii?Q?ItOIYYA488X8l9kl/FQeh86yQAnPOK0aKH3yML/3BMbv/W+DV6mDGANaT8LK?=
 =?us-ascii?Q?2gLnTqyLX1CIcDjEFrBnqtslS29npb6nb6+gyThq8o3TDP8r5kugm+tph6o8?=
 =?us-ascii?Q?fctdIHgYv/62860Wm9YKKlxoWtFG1SElkA8cf8+P26+cioyP5/DGMxqAPq0c?=
 =?us-ascii?Q?F/0ihxvAxWutwdcreAg0zRRpqLHz5halmxo6HKzaGiSPrc0ofoFs1Xs7/SNn?=
 =?us-ascii?Q?mgtDsHdIbdntzkluFGBMdrpSo1ksW7/rRI+xUdIgwYkdr18v/fL8NBO+57JK?=
 =?us-ascii?Q?a61KM5WvoFuJJGSsGIbyMMZNmDsLvPuX/cN0XwBS/ttsC82HcSdVQ2+bSxFK?=
 =?us-ascii?Q?GFbiIezclR0QjNhJooGJaAz2ybSmKQvgTMKx2mc9DYldD1prd5Z0IYBVP5R1?=
 =?us-ascii?Q?UUOLpkm6k9khFHxvZTFcVYB5qLeP8g0j6RfimXkdPXIp+I/bo01kzzZ/3HPc?=
 =?us-ascii?Q?81VmIzOdP+J0W5aVZizHW401VbzCBeYnZfXs4WT28DP5fIsM6QStZj0ssRr0?=
 =?us-ascii?Q?M6xQnJ0DzbNXgwrlNjbQiql2scjThs+s8r+MQk8EbrLvnjm3XJ4pyeIHUc2l?=
 =?us-ascii?Q?MjerIkkqnUBCHVHtdDHCYOuDI98LUIFb8knSRKKqDARYmyYPNNAFY4lZ1Ai0?=
 =?us-ascii?Q?UOh7LvUbTfil+Jgpy7ghUWPOZQw8wJS6qdlsdL0V6MEHoc/m2EnzKQqf6pnQ?=
 =?us-ascii?Q?O1tw59UQR2wQgW3P2YO67ix/KwladNjWR/VLqK1RyB0CTmCYG2HYrrH3NM16?=
 =?us-ascii?Q?xXOHWlNEMhq5CFgHbyAmSeh2SR8nu6M9BmzecOI+wz6EnpQP2t/k1Igh8I2e?=
 =?us-ascii?Q?V4kZ9/VWi54u2PqRL/CMxBAYrO3/ud3dxctJZ2bziMRzE+7LiTUlgkuvw/O7?=
 =?us-ascii?Q?joLMmGz7hItVdiz47s8WKCShliHnCzSg9QCXWlVRfRi6bBcv2aGsPwZvk5oe?=
 =?us-ascii?Q?8imCCqoE0Nql1jS5WrHMCpE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MBzAt/g56iPqtCQBT/7maD7opjjIpYjDSmO/OVPVkZqq0gtyP4YuMTZ5k/vy?=
 =?us-ascii?Q?47Hv2uo+0d6Tp1D1rE+4PHpJ13btl4atT82wmtgnPU7QgZYQGft4eDRKehid?=
 =?us-ascii?Q?HQOiYB2hHzSYd5ouKOn6vg/9RQcWNZyxWJO/rtUpGT1bMwraR1HIEq8CtK0S?=
 =?us-ascii?Q?xy5YAVREkVc1r5nTeA/rBKf6UDarJMvQQvRxEnJeR9VtYpXpREb69jL7Su3A?=
 =?us-ascii?Q?4LE0Ggtu7ZbRGiEbjKbsIKb1fhA/ZWEzpnOngVyrkSZo/8ckHf8VxTAnV/+v?=
 =?us-ascii?Q?KJCY2RBdJpa4br5MjX5HVeBC5exU4ij8Izq9b67VvgJsqbY+lxlk5uyh8u2S?=
 =?us-ascii?Q?YiciM7p4wJoXoqkAEkoV455sg0GsDSdpuXFYjyz5gvOVsp2+Kw5buQxwLck6?=
 =?us-ascii?Q?aCxBNyxP0TU30cZpcaVtvHwyG65PfXM3ZS5uA8SBJlwjEEVpM4V/o53YNvnL?=
 =?us-ascii?Q?li0/E7sf94k4KWmvpA/DvMjatEG48ajCaIBRoCcWgWo8PFBhId+7sYbaWDzF?=
 =?us-ascii?Q?7r8o7RzElIrLDNb6qKjYZtfvjYxkvMwZ53ol5S2Zi2J9KGXhBkgFK5C9fRo0?=
 =?us-ascii?Q?GjJ2/ruwvLB4LHXwHvBDGiL89qHNh+dEKu13gtOENBWZ7cQ2l3yJvtwAbdDz?=
 =?us-ascii?Q?W9GCg5uRBlDPacLN5TF4hxiAZjfArgC2uZYPXzBj3BAf+yrdV7GQs1N+dMCi?=
 =?us-ascii?Q?lNITlvMP13rwxKJtoqBsRlR7C1CvhaKYMg/4BEM95/rwksv3Yjed7ln1eh7u?=
 =?us-ascii?Q?KwXZdfnzUNPwzSoCBAW5MCi1hRPA7zHK9aeGj50+KoDtI0rb/H9inWma3UYq?=
 =?us-ascii?Q?0QI5DP7etiE2O/w0NS5cXUh0JKTHdAMwasfjvXTEBIpq7ILuObCSChZDs8sZ?=
 =?us-ascii?Q?hAqKGsPcMqfkkAgKAAUMQPBEmXG9SUmynz0S8UfG7Z/eNLCyZNvfrGof+Ofo?=
 =?us-ascii?Q?/rEgNERUTluagyLQtk3a2bS9U6AQb6TVstEXA6pIWEPPInS7FwNG0vg/8RRC?=
 =?us-ascii?Q?hIE0jeij0TXAEIfI5SJdprQgPopouGFj8x3gbzVnA9OCQBQKhdZp80M5XztY?=
 =?us-ascii?Q?YXE2yOO771Vsh0H3d/76mbtRCmcyDRTof1PIes9m65Xoww3PYiuzlASK1bX+?=
 =?us-ascii?Q?e3TdrpHCESM3tkJXPc6WnlAUPJQPE7Td372WOWb3AhHxxvxMVXDZ7c7K8yCL?=
 =?us-ascii?Q?kzhkNEEeyJ8FQmhy+k3emYEn3exFaYW6tmgQF88URtwwvC8T8kUuIagus4Zq?=
 =?us-ascii?Q?tPYUPrmwRTXMdErzCvbmej9JqccTPMglE9LXu+ActRw9+iD6ovXDWs5bz2V4?=
 =?us-ascii?Q?sSVMT3mhcA5OvDg4EvfJCPzUp4moli/UqHMRuqM2Aqm3sf8hHFnyRm361gUd?=
 =?us-ascii?Q?H11z+xWAoxkOwiZL48ewXMsRwBloV3DXfpDAg3upYWK6REoTyxxVgooqgw5z?=
 =?us-ascii?Q?Aex/2Xk0K1xV5NbpzpYMTFjJbjuuRPrGlZubDGYlmYQYB1RdJ1OODaNikw3O?=
 =?us-ascii?Q?9iWxfgt4fbL7y0B0rWjdKcLplyR1BA+INDRcC/GhUO6eggkJKQgzoPpWYqqN?=
 =?us-ascii?Q?ue/l4zchUbOJS7BSa2rx8EzFqX+2qUmj3CqdHbUXSukLDxipcfLjkWm0LPec?=
 =?us-ascii?Q?cqH/EP9VY0lVP32aujpa4HiftD8aZhagzUqvF7sAm6Hn9v8KjMHzw7UBE/MS?=
 =?us-ascii?Q?AvRMe57AbOnyA8d610BpqWyD6ji+6bYf1PScRd9GdxDsOCN6/XdWP3voUV98?=
 =?us-ascii?Q?ywKI1+VCuA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54af421-8018-418d-b195-08de6e1b2fec
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:53:38.1322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2v0k23Y4NWE/sz2dMzw1HfuvB3BkFheS+xq3J9VWG/abdwBvzK5uxfV9qRq3RC9YaizRuLq2DyTn7riQATQrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6761
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

With pkcs11 support in mkeficapsule we can now accept URI
tokens and not only files.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Reviewed-by: Simon Glass <simon.glass@canonical.com>
---
 tools/binman/etype/efi_capsule.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index 9f06cc88e6e5..3b30c12ea514 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -125,10 +125,14 @@ class Entry_efi_capsule(Entry_section):
         private_key = ''
         public_key_cert = ''
         if self.auth:
-            if not os.path.isabs(self.private_key):
+            if not os.path.isabs(self.private_key) and not 'pkcs11:' in self.private_key:
                 private_key =  tools.get_input_filename(self.private_key)
-            if not os.path.isabs(self.public_key_cert):
+            if not os.path.isabs(self.public_key_cert) and not 'pkcs11:' in self.public_key_cert:
                 public_key_cert = tools.get_input_filename(self.public_key_cert)
+            if 'pkcs11:' in self.private_key:
+                private_key = self.private_key
+            if 'pkcs11:' in self.public_key_cert:
+                public_key_cert = self.public_key_cert
         data, payload, uniq = self.collect_contents_to_file(
             self._entries.values(), 'capsule_in')
         outfile = self._filename if self._filename else 'capsule.%s' % uniq
-- 
2.47.3

