Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45359C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04B0784A63;
	Fri, 10 Jul 2026 14:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="XHcY+wfQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A08FA846A4; Fri, 10 Jul 2026 14:36:37 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B1B984A60
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 14:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+sclIfNSj1TFgS2tvUfKZ5ddO/k8Tt9MMqrLTEutRPjCvfXrnzQ+JTtgxuKnLQfKd2qO83bZ1qwlC/CkNfS+Qri91kyM2Dw37NrF5PPqR3RWkksTDkH1DGQKUPEKBArEo4dr8X0I6O0BegvFzwd5pyEQRDD86/Auhvo93ChrPd2uRmR+UlCOM++wi7C5j2jZpQX+37566U5AyZyYBAX74yKPaXAPwKb61JHXbfLGN3f3xorTHXw32eavM1kWIKaWfXts3w6Ltq13/3HoebWCignhKdBIykzgtVdENvAX8wItfiB99cEbZrC0HqoVdUrwc8U2JuZHn5K+KCgfNpRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuQciiXAhmAxn9nVtNDqZu6shtxGYp4P/sDxmKIVRFU=;
 b=Q0GoTvA5aV5ZqlFaBXlL7/MMTWZFnKvnCBsZu/adT+x0ByfxhUcRHQIF0w+t81RDO7OUFZhslybSoMPkgGF2JSzC/vSqffXu8V5+/It8NmhNNkVB3EXJH+2VjRnSqlzKxCg0qUY4c83lPJiHLvvhFQvaVCu/MPbsYNqZ4YvqnkMkLND3RCn0edhWr2xLgz2+c4dG3wncBaxiEqAJtjeLDpPiP/Dyj4z923PZwG5wuvc5HkQhjpHxVA6QIE8PG6zKBTc5v5PMdu2CWgP4wKRTqU/ne0Lt8WhPzwajO3++AWFMluKwrAsEARLhCiVwUlDomLq/H3O/CMLxnM8cIQTSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuQciiXAhmAxn9nVtNDqZu6shtxGYp4P/sDxmKIVRFU=;
 b=XHcY+wfQbe/p6m+XtdcjAExDH5nyXHz05PPfngleufLTPXCA2sEBJMKX6Qwshimz3akR84EMZppbsltCGIE+07VbNQuGJLo7ASY7Uq2IJ2XjBmR6d9t60OKxvJTiJIwpHVxiy2e7kb5MWd15ybDjbOqBwk2+dMpU2K9/r0c0QFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB4PR10MB6942.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fe::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 12:36:32 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 12:36:32 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 6/6] k3-binman.dtsi: insert keyfile and distinguished name
 templates in all ti-secure(-rom) nodes
Date: Fri, 10 Jul 2026 14:36:18 +0200
Message-ID: <20260710123618.2036728-7-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710123618.2036728-1-ravi@prevas.dk>
References: <20260710123618.2036728-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0006.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::14) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB4PR10MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 0571cb55-e68c-47ea-6559-08dede7fdf30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PuN1f+tSgbt8CWAGQGhcXYVPT70DAVDVRCD30yJ47h5oVbApulOkqayEOgSZHC4Fvq6Js9AS3HMMdAlvd7cCJjusIk8jM2gGAAnYy59KJ81o6vpEWCXS9f6ijM5oPm8uFGCcCUA8Cb3al9Hwg2gRJzUWcP23ANLhzzSbae2NOoNEIWmZlmIe3sT7VhiW8KD20bIr1lLxMudFr7WxXznHA6YSD6psG9BFWztz0tX81JOxzLT7LlukY836DkTAs+PKsW2ke2K9VT7k9Plnbllk5vT0FHv1H0GNXn4A/OOuEMwD9NtUkCLmI5gJQ8YiPT8ijbcecVG0yhykcuuir6KlsIXZHUrt8v7uk6wBghKxLbV9YK3oX2FTcsGzV4l6X7dud4cg5ydJpNdM7yOwnbD4FsV3bJyhu/O6trjPw/FkxXWJ7K8owETnYPy7Vb8vgKjh2mK3C4MiRjJntn2hsynZGfzLqXgzGze4D+anINGC3Vzg2d70KpDauDWxMRy+HtDcuQglrNinsYtxPE3EciUJSEXt/S7CnrK8Vs/TQoQOgcgFtmSi62D4KZZI8V2PoF3dD65XTuruPO7L+YuPWBD4HpRJOu1DPMkCYOj8rKhUkF5nQYYmNaArn+Ejl2lgri0fuQQfrujsoql43iZau/BNna2sVePMI6WRMupBfYdoZ/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zPGSU6N5xgcJ+mm/AdEUl5YG5BBPv8NcninyYq03R1UT/qRjn9KBFEZk2hCr?=
 =?us-ascii?Q?4KSd3VmRVTmvFuBkKBbRms7Dl9etGufIj0I2pzHDZ3DCfhf+hnb9T3zhGqN6?=
 =?us-ascii?Q?a6YCQK8yIFz+U2XpMTpZ+gBk68lKahuzrFCHb3I775H8MXbqqJIcj1UiJgJ0?=
 =?us-ascii?Q?BfDxQeLDVY4BfxiabhIEjIIyxTkFNXkqBG5Z88wallUdUslGoy5fU2dj2lRw?=
 =?us-ascii?Q?9XjyfMpAKF/qH8ieOJzP8NAVX7GE3gyywv/AXuLlzcdjWQf5rhkH+12DnHKq?=
 =?us-ascii?Q?Ft2bjw6YIBUtP3iQVgiA57JXRGEF1Y7dHuSC/GxbbXLl9foG53YUUQWEGPio?=
 =?us-ascii?Q?iD/6erMDAnLkBUkRgKbP3PcjOuTA03l6j/7e6VerRGmIyV4XGEVlErW/0GKR?=
 =?us-ascii?Q?h3i8sOIE9onQa9HPTG5Ea4mcH3ma9g0R4knOrkXbcAF/ZPXakQuefaR0kHV9?=
 =?us-ascii?Q?MOB+tSa5dHiFYu6OKbxzFWYvYLDIkO6K2P91AkVf+fcCboJvcQWl6HARiW7T?=
 =?us-ascii?Q?ctxZLh+XIjyVWoeGNeFSYZhpMgmAihDjUI43zGdd3q4IEl36Swo9Y3IJZng6?=
 =?us-ascii?Q?erSodLl8/8ydQ0zf8ezBGJK6vln+blbyiaaz1AvzVj2AgI2UCPzcCBbCf60o?=
 =?us-ascii?Q?Qax4lZJp/Psx/rHHb5NwsrI5T7AX3bhPX8UrtSErnbA0a0dv2JQpyKTCGlUL?=
 =?us-ascii?Q?F5TwVgq5RzULemsssDoG8eanNs8XzDTu7TEfw6Ec9YhLsBiTgRH83SnzMs7f?=
 =?us-ascii?Q?7ms4ouqwJWBZhCQfFWbEoZiW+IOrf+Fh8Pg1y39+01mKXxDkj5/6BnXVLunp?=
 =?us-ascii?Q?95sQObdnwdMHQpSkpRq7L7Gap7DAy9YOErZOq8wS8Jf1mQPmhBIqAUI6IqOP?=
 =?us-ascii?Q?sFRN6+DrF4FKWWfak4PjRS8ujpAlagwulhQNsG19MXfLXc2u8rqKmsy5xC5C?=
 =?us-ascii?Q?3YyTWXIEzM7B1vw2s4CW4/7PbLFFeVByGGhVJlBs3Sr1QdPNKKYhphACapfE?=
 =?us-ascii?Q?D6e42vdJv10TbNMHyOPQysbImQxpG2TJ+6MrOQvRW+fk1K3Mti5yQxV43v4A?=
 =?us-ascii?Q?JnCFsQzPoPcpSTzzeVu7TALVkzoDsamYYA/wbgiWiYy/mj2eH+BceuTFv9sc?=
 =?us-ascii?Q?+g+QBPCtoW/mSRk351f4qLm950BWFb+ZYNLe0B69JrIhcVQQRSfXZJZWg+3m?=
 =?us-ascii?Q?oSeXFDtwDRFY7Cd7LGTwWaLKj8q7HyZroSk3qQBgu+nI5kbdHU5VEA+ExXC7?=
 =?us-ascii?Q?7Q29UfvX2snDc9nGo5INv/CzkrUgWziuBkOV3PBMVlcS/1L32ZS+T9GTqbQg?=
 =?us-ascii?Q?It/6QQwXtVNCmMng0Nrn55fqDwTDW/ECsTpnoSJ7QLGFkWYC0CsF8YvUydzM?=
 =?us-ascii?Q?QP+NQrJ4iIWG/emFarL35PaPsQH1IaXVrVS3iYd0y7RkHzY9guxVZRSn8C12?=
 =?us-ascii?Q?7tJDQgMvCrCoThPTuzBo9N9DfKQK/YTeMb6hCT+vsPOtHec7VW7FOzJd8ysA?=
 =?us-ascii?Q?tlVvqam+xPCVRzZ8dAt4YiL9oXuGrkXOAGcS9VNwy/NYwjpJ4VCmC399MG+B?=
 =?us-ascii?Q?47BpNBTIUBfa0eDy6740DRxEMRjZJJxbrMIMJ4sMOkU6pm3p1x33lVwymwBN?=
 =?us-ascii?Q?RaD3npeaTku+Rz0dYygqLg1fIAm42jFo2YK1nbQjU3SI3xzoQU9J1B03w15R?=
 =?us-ascii?Q?rtTCaHuBVUSzG9QhA0iIV8MvyDdEiH0ZaCsYSRO17fY6KHsmyHFobSBgcPNv?=
 =?us-ascii?Q?ptgJnfVQWU9gGF59q82+mHlSvwKJeoc=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0571cb55-e68c-47ea-6559-08dede7fdf30
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 12:36:32.1320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJmntMgYrdxvARmVqOEsK3hnxxHLul1m93jif8TtDk5dHClDDRMo9kcYeaVCHzovFri/FXf1TnARrfHKzxcCcIuj7PJrfyaDDkz32t2/zoA=
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

This should not make any functional difference, and downstream boards
that already override the keyfile property via an explicit .dtsi
fragment for each node will continue to have precedence over the value
coming from the template. But this makes it much more ergonomic to
have the keyfile and distinguished-name have consistent values
throughout, because one only has to override the values in the
templates and not each and every individual node.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/arm/dts/k3-binman.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 2c9e5b619b7..aca243f72f2 100644
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
@@ -330,8 +330,8 @@
 					load = <CONFIG_SPL_TEXT_BASE>;
 					entry = <CONFIG_SPL_TEXT_BASE>;
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&u_boot_spl_nodtb>;
-						keyfile = "custMpk.pem";
 
 					};
 					u_boot_spl_nodtb: blob-ext {
@@ -419,8 +419,8 @@
 					compression = "none";
 					load = <CONFIG_TEXT_BASE>;
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&u_boot_nodtb>;
-						keyfile = "custMpk.pem";
 					};
 					u_boot_nodtb: u-boot-nodtb {
 					};
@@ -521,8 +521,8 @@
 					load = <CONFIG_K3_ATF_LOAD_ADDR>;
 					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
 					ti-secure {
+						insert-template = <&keyfile_template>, <&distinguished_name_template>;
 						content = <&atf_falcon>;
-						keyfile = "custMpk.pem";
 					};
 					atf_falcon: atf-bl31 {
 					};
@@ -536,8 +536,8 @@
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

