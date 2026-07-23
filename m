Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727A6C531CB
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 09:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27FF480F26;
	Thu, 23 Jul 2026 09:39:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eWJ5ty-q251Y; Thu, 23 Jul 2026 09:38:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 51AB180F18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784799539;
	bh=EOI/crNw3Ca6uI4740Hd23Goks0QDJ6XqCpjWkD6Dpk=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=NU6ujUoTKQD1riXxg9RL7a/p5V/WRBU0iB9An3P9s9ALKHVWPhZKgWCGOy3M4IgRJ
	 zt+2wYUEGyhTaUIyJNASP+7QzUmRsyk96VfIESX3rYlKcjdvgTGwIzcD8IXOoX0+sU
	 EQ/XzbdKzdx5AegZOYuTW63jt4W/qk7LgsSwfHB4CxdmlUIox3a6yjVOq/GPaihHjU
	 +zl1UXcpWH03lhwziTsdQ17rKH49M4PAfBKCqpq7WXTEvEz6UvZ6gVfGp5YC6lBYfe
	 Yifap3MAUT89eVIYtXRcu1Mbj6NXaQBoXtTuuoxGlorua1dkfH5S9uj4lTsGvS+DR4
	 EhDAtfRR8PKCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51AB180F18;
	Thu, 23 Jul 2026 09:38:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3ACABEB
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2BB9440026
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZgDrvlLBajHB for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 09:38:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 515924025C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 515924025C
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 515924025C
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:38:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUjACwyBCPm7MvvWDuVLFFh9lMKmh6K+WLJXQTFV89c3QR14c3NrlufCyewncyilLsEOGr8cQNcTUAAzWqzskiYU6k+aHzGAixdaX5dIMWnbBEskrY1HcU7xO1bQ3yET8qEXuECaKCKy7lQnkc+g30jz9KopEA0ZT1nq4/pu7Zur8GXhd5pWg5ePHMh2YQ6CK8vkDQcZiB0R+ncMUfby505lZDBzWIjeC9FbXIWbDyW/TizelknUHze8b5iNtVdoqKmnFmJoK/ttl8gmril3DETqrNCColdoLkcOnPbxWHrD0jeI+GYpLIeea7pjFGtRkuLEEKSv/DYGmBPGYvG/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOI/crNw3Ca6uI4740Hd23Goks0QDJ6XqCpjWkD6Dpk=;
 b=o4cDrxyA2+QOnJ4WORfoT3R0n8PgfMrM22y1y75OCPXJ826nqWGhFu4WX5PUjf0x/W32FkWBHmNzCl7sOBoOqbtl4b8ybCJieuqYi1XRvY+dYr09YWnk4hsH6NbxSSuDDdd3tfDG7rHoGYMwhsBcmpTS+R63CJfWsA+BfDdSCfMNf6gSiSqvrsLxrioFw3UVkQOvUSFGZ40PsODeTS87Vg4LFUQYLqrK/zE9a4EgrGDxhdpnPqhGMsFB2elp5QVkxL7md6q/dDKLeJgMhRT8WuDPk83eeI8CTNuzJ7pwnEoKsJr4J+cXxSldnPGv3qisY98009XgR1D+egV872yRLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU4PR10MB8712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:568::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:38:46 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 09:38:45 +0000
To: u-boot@lists.u-boot-project.org
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 6/7] k3-binman.dtsi: insert keyfile and distinguished name
 templates in all ti-secure(-rom) nodes
Date: Thu, 23 Jul 2026 11:38:28 +0200
Message-ID: <20260723093830.3132465-7-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723093830.3132465-1-ravi@prevas.dk>
References: <20260723093830.3132465-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPCP307CA0004.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::17)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU4PR10MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: a51d2d8d-f581-4f3b-14d0-08dee89e30b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: T8XAw9xClq/vCdr1AW4poc4WhQZ54szs6Nw+2TWGw8sZNQ3PUwR7fai4qQlUgludbLu+zRCITOwLSjKkaIWCb9zjkqRHjWSOcwuJ2+8Zs7kVQlTntcE0L2KI2u/kAm7nmp/fvSkm2xW9LDc6O3tM/HKaa4PC5hTTjKvYo7LxeYDJuAUj3ld68Fyhn6h0AmoSMol4h+Gg5kNA2Kkupd1P48PLR1IyM/JWZJw6SrF5dUxN2mbZiThjsf0LIsW6xQBrtZHaKFHgSr2UU/ofqnlUp5YvK2XSx+syX6KTMqq5l9HT0nUM9CML3Z13mW9XXwQJ7m1Kv9LbVgLvJ/jlVqJMtylE99A5C7BzeF6K50LjW5LVClN1TcDUnRSIHVnJK7Hnu7iyH5MuVwST9z6Cwu4GKdCa8h/GiQT95fkCJmtjj1u3PqxUWDhFax00FlE7A10NGtjIVXzzdaGnX2uaM4K5TLFsPNuCWouBt9uck7qNjxX0OcbJhXHigCvsHkaAlqxJIqw1HIn7gz+ske9J7ZoE9ck97BH4uEAyrTWkrKpIotbmuJaCp6XucrN36zDKK7eKQS+mNbyw1zHy+iuhBuhGFvD0wUzwUGLpljBxr+VvP4fl3eXQYz4WnnKhoCMyBtQzplmKVQaOzdvWpURrGN68fhS08GPL1wf0YcKV6KdN2/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FdGoJyRt0oQGNiyCgYbxyGYikL4t7Lm6GbvMfAGMqXV3I2sCIskqU0VltHMr?=
 =?us-ascii?Q?yOwb0OiRzsX+Br/BaJ6sJkV1Wv+jz9EJz72exAIpLm+23kBt1xrWzSu7Nixt?=
 =?us-ascii?Q?ZmcaXfS5A1t1kBDt3OvKBe+tiDD2KB9kNyZ82Bbms1zfXMLVDzOe0j4Xwm/s?=
 =?us-ascii?Q?CnW4Tl25P8H/RCO0XZ7XiGUM1vBs0IbQXn26f0i2xSC5L32PC7GWEWXxUmnF?=
 =?us-ascii?Q?tYeScYnIC1z47O1m9ke1VDzFpDrAT08qIIK3xeIeYSHpHubfBU1DtCR9w5jT?=
 =?us-ascii?Q?14O7FdFGXYFCnRsTLVinjCWDKvaxRp+NZ5Wa/NlQIzDWIRkHjIfaZ5+PflHg?=
 =?us-ascii?Q?jat62aa2lDcteHSCbNz9cUY2Y57LR0VSsVwhNHtQPhMNg64/7cbfRlOcs+sL?=
 =?us-ascii?Q?pcer8QgC4izPRNG3vlYnZMEfEfqUODjyKLahX+sr519xGYstzEqetBr7vbTm?=
 =?us-ascii?Q?qOXiSx5dAUv2v1/dsB7SvxdyUhOTvyPOdw7DtWxeE3Rlct2ORnhmlYz42QxQ?=
 =?us-ascii?Q?pAwxyeGyciy0RYBn1WCPsm8zXl/CK8/s50iibo5LnjmVHq2Kr0Xw7pUOUfdT?=
 =?us-ascii?Q?Bsb7Fh1qebXpt1DFBIIJR3AEan1Kur6xJcPShP1pkCkjmqLCoM95gNhf1aBW?=
 =?us-ascii?Q?yVnTmlAj6dZzXbJgvmywJlsVOaaclrcKiUqjA4KuFf8nCXHvWasVrlmZfR5J?=
 =?us-ascii?Q?hH54Gh8sYuNR2q5kjK2QWpn5bUzX3qDKgflsUlIGT3SG+0K62wlHlJOpdBSh?=
 =?us-ascii?Q?ONE2EhbTANaC0EJyh9DfKhcscoiE5nzBJWI8IcDHn99Ee71fbOyFSuiJ0lEE?=
 =?us-ascii?Q?eKJMdwZmLuVgzT2V1L6KWBzkyNAuxxa/aQuorealMQto4zAxWORNAq8MVqDH?=
 =?us-ascii?Q?mzHHZkXeGl6QM+QHpcJs2CzUpAGLg1ibRCfoHmJLvW1yosVpohXUhZToFdJv?=
 =?us-ascii?Q?pd0GqhhDNHasHOUWgStsMW7yuyh+clbTbf0z494qpn0wdvaSMKTKMDHBOdeJ?=
 =?us-ascii?Q?VDGnj9fPAdgCYFzM+t9Ha3/iZ6nEIAgEGpjA/O0xPu9xL0z8eMuLYIQWqjPa?=
 =?us-ascii?Q?aLGhe0QlKMvsKdlWqbC1HupxbqvYPmEymaX1t8aNzmAI6JNHwHLbqgXy9I1k?=
 =?us-ascii?Q?R1MDG4DryBSB/N0w365ReQRCcIKN3ZYkFcMWw0TjgzzRbXVrO26Uyu0QPqkT?=
 =?us-ascii?Q?W8kL8VBjc++8fqLGwpUdCIWAAKsw2wdiWDK7I5I7w3QiZAVb/SkKg7eIdQG7?=
 =?us-ascii?Q?szJcAih06zwX6IV/Zsew/i7UQyAHX76M0F+VTMGGSxG2cwJmKdlf2IDVewnj?=
 =?us-ascii?Q?vKORwWSP9qmxZA9htZ66bbhgRmpBnIZhh8f5PTSUxqpouBbP8PA3er1sKVuW?=
 =?us-ascii?Q?1XCpry6wgZ2l4fhQzR/BkWyIBI4XRx3qg+G6Vzbm+wV95aJMMnQAQEUlICr/?=
 =?us-ascii?Q?rX379kuyiMgckKg/RfL9CxiWlWVJZznCbbZPlVLqFwDZfY69e6hSvM4431VI?=
 =?us-ascii?Q?nelj8rjsDXlnVvlMn0sLw5nztdTW4d01kvci+FOnMs5kzyQBg2VabkjHeoG+?=
 =?us-ascii?Q?fcHO8f0b96JGwnHk+X/6YuiCK9QumOxuDIYqXJLL6QJOejSKxisFvYsmkiPA?=
 =?us-ascii?Q?3wyWoIlKY24FXfWCbDXJnzjFaWENG0Eca9z965K2+WbVr4J13Zs8F/LvzIpp?=
 =?us-ascii?Q?qUNSZpTkglEI5uhuml+GNLw/WAoT4Lw5bTAjhsCngCLbYLXn4vee0CKk8Owq?=
 =?us-ascii?Q?XolguaPJfCtnzXkx61yZ5kfSqX3NZ8k=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a51d2d8d-f581-4f3b-14d0-08dee89e30b1
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:38:45.8320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nKNzMQ1cTx2OXCDFXiXrw3tadcJf85+QjgKMhj8wBKpO+2JNfygE7cPnVFpFIVlgVzuJyL/6qwd+c0PCBmQZDXloDfRenGBR8bMCm791Ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8712
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOI/crNw3Ca6uI4740Hd23Goks0QDJ6XqCpjWkD6Dpk=;
 b=PajxVsD/bEiKVd6KlXHZcZt9uF0o2mODtM5fqqJQrLYhMURUkKATPj16x4wvX6R/0BozZKYCORzLBm9i/bf2fwBDVDHlaA/T75BKpFfUyQ5+dRankDVWrB6VXWnaYxG9XqxAKX8ATbt20/MnNgzqTvZ0gKE+iMEIHGEa73gEVYc=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=prevas.dk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=PajxVsD/
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Rasmus Villemoes via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Rasmus Villemoes <ravi@prevas.dk>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This should not make any functional difference, and downstream boards
that already override the keyfile property via an explicit .dtsi
fragment for each node will continue to have precedence over the value
coming from the template. But this makes it much more ergonomic to
have the keyfile and distinguished-name have consistent values
throughout, because one only has to override the values in the
templates and not each and every individual node.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/arm/dts/k3-binman.dtsi | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 2c9e5b619b7..797c271bdeb 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -150,8 +150,8 @@
 					arch = "arm";
 					compression = "none";
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&board_cfg>;
-						keyfile = "custMpk.pem";
 					};
 					board_cfg: board-cfg {
 						filename = "board-cfg.bin";
@@ -165,8 +165,8 @@
 					arch = "arm";
 					compression = "none";
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&pm_cfg>;
-						keyfile = "custMpk.pem";
 					};
 					pm_cfg: pm-cfg {
 						filename = "pm-cfg.bin";
@@ -179,8 +179,8 @@
 					arch = "arm";
 					compression = "none";
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&rm_cfg>;
-						keyfile = "custMpk.pem";
 					};
 					rm_cfg: rm-cfg {
 						filename = "rm-cfg.bin";
@@ -193,8 +193,8 @@
 					arch = "arm";
 					compression = "none";
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&sec_cfg>;
-						keyfile = "custMpk.pem";
 					};
 					sec_cfg: sec-cfg {
 						filename = "sec-cfg.bin";
@@ -287,8 +287,8 @@
 					load = <CONFIG_K3_ATF_LOAD_ADDR>;
 					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&atf>;
-						keyfile = "custMpk.pem";
 					};
 					atf: atf-bl31 {
 					};
@@ -303,8 +303,8 @@
 					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
 					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&tee>;
-						keyfile = "custMpk.pem";
 					};
 					tee: tee-os {
 						optional;
@@ -330,9 +330,8 @@
 					load = <CONFIG_SPL_TEXT_BASE>;
 					entry = <CONFIG_SPL_TEXT_BASE>;
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&u_boot_spl_nodtb>;
-						keyfile = "custMpk.pem";
-
 					};
 					u_boot_spl_nodtb: blob-ext {
 						filename = "spl/u-boot-spl-nodtb.bin";
@@ -419,8 +418,8 @@
 					compression = "none";
 					load = <CONFIG_TEXT_BASE>;
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&u_boot_nodtb>;
-						keyfile = "custMpk.pem";
 					};
 					u_boot_nodtb: u-boot-nodtb {
 					};
@@ -521,8 +520,8 @@
 					load = <CONFIG_K3_ATF_LOAD_ADDR>;
 					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&atf_falcon>;
-						keyfile = "custMpk.pem";
 					};
 					atf_falcon: atf-bl31 {
 					};
@@ -536,8 +535,8 @@
 					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
 					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&tee_falcon>;
-						keyfile = "custMpk.pem";
 					};
 					tee_falcon: tee-os {
 						optional;
-- 
2.55.0

