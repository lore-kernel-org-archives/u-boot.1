Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1037BC61DFD
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 08:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A137D60862;
	Wed,  2 Sep 2026 08:53:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XKEvpdSqxrOJ; Wed,  2 Sep 2026 08:53:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788339233;
	bh=292JAy2Y2rwDMQnbrODzuJIAKWxIgpePE6Yshf0U38A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mpZ5ZLLCVir0NCiX0XG5u6M2BF0XtLXrYCChYjBOldex0rwzhGOSSrqQonzB/ujv8
	 BvRkNwV0A15qshkoX2MSjZ87Aelt14PfFZDpVLS9hjNPIWpklIT0uHHlS5nREzOsNO
	 HR9A7nyOM1ZMuXHOMU1uu2+C7Yj/mQcCfK7tc2LpCN04vJDsy3Fp6K9GwDwvQ6JHOz
	 VhVzwcsvyzwbh8HppMtP2KqHDU9A0rKYY6S9dcF4smhxGhpcYo1BgKSuqVA/sGFXQz
	 qSDlpMADBgZGsJNfoo8HAFZM6p+hYODAVz5NRUrBrM+Ti1ndcnDdbrGW9DVJHBq1XM
	 ncSHjLHESc8Tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E96AE60871;
	Wed,  2 Sep 2026 08:53:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B0D04265
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A08416086A
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jUQHevqXGxpf for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:53:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=4qzea79y
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D3D5160863
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haqh3sw2cMInJtnuRgst8ly6ClbVOFfjokEqeLQXzarckY8aueE64v/as4vtC6LphBT/kaQJcOT7v9YGDIz7BFANo/t52k1JCMA8O9Q44QF1z5tdfW4HaM5AWySHz0Vi3x2qpFaBmuw0GbwvizPmATDsF3paGf/X5xWHVAFZCFUMvlMdYwpHrMLfCwKGbR0O9hkXNSf3SzA/K0aZLG1k9M1qHq2nwZpdfg2JbZ8+tiD0bsVr+QZ3HCzcASHkYwGXFbUIPya8ZQLZTT2XgBQUqUCcG9mfTxne8j1gEIK+Gr+LJbhg3Zxb+vTzwJRps0RsBwUhqpnaI7nzXzgBao3HkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=292JAy2Y2rwDMQnbrODzuJIAKWxIgpePE6Yshf0U38A=;
 b=UvD8M99mPYWBPf7Q0MY2HpGhOu6Sv25FYfW443N2PCDeViOHREUd+uHKo+bWEFfX/BjriNbz8657Vn4qhP/CTl4hApUVFOoZIM6ziG0l8CMBbn7o0iOVbOAq4GcSfcOwnsv6JsuR33wMyBch15nuvyTMTqYsd8QkMniwKINE3HjMvthMCBkfe1E7iVk0EF4H9Oq4/kAeer90CRQJc+XbSKMbcBNJZmDZ1FByOvgsaxK9JWiSh6aW04ln9P4EFgdymkk+4LH2TBP/8bQE9IoQtZl9p3YBRDZPb7z94uRsl97kYtYrSQCKjghqjNLnxl9Zv3On473eEYrIOxY7g16bsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=292JAy2Y2rwDMQnbrODzuJIAKWxIgpePE6Yshf0U38A=;
 b=4qzea79yZW771bd5HX9DVcOJK1Zp4t/Ao3tS1PiEvUYUEp0d95Eip8cfCLdO4pb81Ua42p/4y2fSUDibUjG9ebTX4bkPX8Qfmbdc7sD4XN7tXfW+RR4QfYoetL3AU10ZWiKUD1B6zBtf4QOaUuDCbWPm8UyIPQ/yp4W9GvPO104tODjgr8PT3xK0rv6SFyIjGE8XurxScbKKFC+9Ej8MWEPEfxMCmEocxWhRLI0FVF0w23SzW0o247NmKI3J8w7svyfh6leI2LM+6jxCVUDMpOQddTylTe4aFYB6a007fZXm5Q0gvRAY9S4EyFK5BCuS7EwcJGa23SpiK2KzoFJsYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB11739.eurprd08.prod.outlook.com (2603:10a6:150:327::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 08:53:43 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 08:53:42 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 08/16] airoha: add MMC node for Airoha AN7583
Date: Wed,  2 Sep 2026 11:53:03 +0300
Message-ID: <20260902085311.1550804-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0077.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB11739:EE_
X-MS-Office365-Filtering-Correlation-Id: 91705cf1-13bc-48e6-38d4-08df08cfb0cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|52116014|1800799024|23010399003|10067099003|11063799006|56012099006|3023799007|921020|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: N4LAJJV7T8EbVnMgfiUEE+01FBr1EAyMHcgUeO1OF8Hf6aGhF5ncfGGFmhnPQpmcufkMf3u+pCmDY5QuuxrtGpfQ6H1gQ1hh6gEqmLC9eu5jjjPZALokGHxcyHrwIakRRuLMF4Ov6Ejl3IzmsRMnkK9JUDYy+DX78SnUGJ/UT1jZ71WdneNybXzOtmumhw1OB6FNOopoNwQWBwMDVgMqs2JYUMBZQHVRco3mdbMPCX+r524aahW40hCytokgUiuq2VSW66tLuC6KD5xhKgHxER/Kdx3n9yedxCDeluSzIlv6J8UyO+lUU1+qWNS/C5/OFtOEYblalMY/axLxoOR5jyqYr+EtW13E9dVvQg80sXGfxEmJHpmoydbnfC9XNddNVObS3Higq8noo40qVJ+7R67TazGgvVbqGdKqoyn+20T9LlbDDRvQhTzvJ8WPPur2K2ass6+NXXEAwgGc2MeXTmKvnlid4St6sg+ypUz5C0A+hl5SP15KKIgdNBHIsl/Fujnk/h9gA1S+NIp8+C7HWwBrAXRQ4Z1c77kPBa6BVLgqInESGI/hoTtI+At1mBzPVWHPzT4S21nm9abQ/JHzy842urOrfcvuBPUxum779OICQWYea3a1EqQSMcCPUPVepskZIKfg3ILXsUq5b5oSWIrG+YhDhIoF5NTtGRnbp6dzSEY2JImqLTqI6VnYEv2/iJwCQZJQtaXzSdp8E6/fEWPg9OIxTHzeVw/5DTXA/XM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(3023799007)(921020)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CrTrt6zrBlFuhJbEBa87PvXfNMjhcGjqROi2gfveiUcWwkY5W3NRdf7vou4D?=
 =?us-ascii?Q?wnMoDlTqog81m728UMmkSBFdi0yA+YK0oxyj08xboJd4ACS9IDKyCKL1anw2?=
 =?us-ascii?Q?mv8rmS8eYcHyZOxIKwfJnGjpeSUsJnv4N/zbS2QL0Kr7mOeL88I9OT7TODYH?=
 =?us-ascii?Q?5/+fStfgh36iTAA6t/HJ58TvwFxq0nXs0A16Azc+KWFgGIO8toiYdWqcGFEe?=
 =?us-ascii?Q?DuZICUbb9GYNT4CS/twGmSyqcelHeKf8j5LKGKjoUYmNo2FM9OatlTt+9Oz6?=
 =?us-ascii?Q?JFL15RqwKPOxKagJARtSGcNEtMfBIL2y+5kJlPTvoOfKUk3u0kl1es55RMNh?=
 =?us-ascii?Q?ON6ShfpHw9qnRyPU6JzxR6yfaFhDZTa0q1n+SEFqwNPyw9K+jqIwRCArE4XH?=
 =?us-ascii?Q?kwMu+TM5+Knqtr8fG7z1VOhnJWVqAbnQlaKtice4BdOGh8sTns623wTMFXmG?=
 =?us-ascii?Q?eVmS2qyMDw//e+oGv/TF9aS5MFw8bxRQpCm7w41IlG2OyMNloLeSxzoFtQbb?=
 =?us-ascii?Q?8LMBh8T2WbFNeOFlvgJO7qI7ODX+ATWGtF+fesWkga53lrh5hVJeXG26au0C?=
 =?us-ascii?Q?LWht9sYFNric6NojwGrNGcVCYyDXbCsk1zQVK7oVkjRQlUBZkDtb7rvL7A6o?=
 =?us-ascii?Q?V+3Wuz1LeNLyyCbRm1Ck61Ry1htCTAmUF0fdEYpRFsDf8dQUzU8AaJ6vW5u6?=
 =?us-ascii?Q?/h9kXMIxFoTEtrUlXsajTdyE+fWYnu/MnfnDriCo7IN1R9qrYbaBqfgGAGQA?=
 =?us-ascii?Q?Rzhw+tJpJgqbfsAyq9hgBCBGmGZEW1+4f9GaWM4y4klUdBniHkMrud+62h17?=
 =?us-ascii?Q?/IHKiMKrCMIAAbw+gTg6XuoGxjHNKrOaDUz6G7fBREF11hVIiJS5A85Tqjct?=
 =?us-ascii?Q?OhaOHaYdaenWOWPYT5FT9KE9njOWr1jI89NaBMEqYsff9FFETlxCJkQbr29h?=
 =?us-ascii?Q?a8KRAWBqoRa7tZs7X2nXGqc2/x1GiW1soX+Jb0n9/K1e8VveCnQfNlGuM058?=
 =?us-ascii?Q?8EhOLrqturJqAezqjTsixLIkzrBES11r63hCraPM639/P5hw4v5Fgpz8pTiC?=
 =?us-ascii?Q?Ax25Hk5tKXGtVNY8eYWlPSsJ2bKcBTDMRHsRLunkO8vcMrHp4/PuS3G7m2d8?=
 =?us-ascii?Q?6Ws6v29+R8wyt+0pzhtWJ4u4hpzj3g66ahX9dwJIcx93plOIfTOo9ydd9BGj?=
 =?us-ascii?Q?17Bq/9jZU2k3Yv6kk5wIMOkITol6cQPcVhHmMxh8nrjzemftLpiqULS+ppI0?=
 =?us-ascii?Q?68szTk/O5avMRFvQ4AIMysklOnY0zizAYXfWfRtkJDi9/M23sc8gw6776qwj?=
 =?us-ascii?Q?56tygORhfqqQVYcRawAeH6Bx2a5wSByvi/zD/YdVcMWLqO3ii0PIulh5IRmd?=
 =?us-ascii?Q?qfZjCphGjxcG8xlA58ej/kuEvHP26GJqzHQMT4Efl6h1E/NckKjIlD6Rd/QM?=
 =?us-ascii?Q?402/gDlM7BPta1HiAGfu3rd6g0qWcDew7cAn390lU2lMyr3JM7U5lgBaZ62p?=
 =?us-ascii?Q?FPTZdN+KkHZlQxvBlNJb6PVmX7hEvh9/BjRgnj8TMaSYpsgShcTdvFEAz6Lj?=
 =?us-ascii?Q?GaGwXWqyOS8eFEzHyBZXzbuHtb2LTEZjWe1E5DAtwtZvp3tKl6b1FeW5pLwv?=
 =?us-ascii?Q?EBCCeT4SH0+cMXBxV2DMET+0Jne9V6UzLfizYlaJtLvDlle+FI8bZbWYuEJR?=
 =?us-ascii?Q?3qmxb9X4HqTHdJJivk+OKfIX1cF1E569Aw8BESMLKi0AmtDAgLlr4Y6h/zFa?=
 =?us-ascii?Q?5Q0Noq9E5gz9jBFL/cFvpX46waaicCc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 91705cf1-13bc-48e6-38d4-08df08cfb0cd
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:53:42.9607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byL46sTnZa05QEht8/s8lyDDuMoBkyAovfil30fB3wklLgwWRxZBcgo+Bqy5W+veoRixV6gnTRR8UzarglP862tE16CgUKGtAKkw9L0/veE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11739
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Christian Marangi <ansuelsmth@gmail.com>

Add MMC node for Airoha AN7583. These follow the same node of Airoha
AN7581.

Similar to Airoha AN7581, add the fixed regulator and fixed clock for
MMC.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7583.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/dts/an7583.dtsi b/arch/arm/dts/an7583.dtsi
index d67b7459870..1a64f48e5f1 100644
--- a/arch/arm/dts/an7583.dtsi
+++ b/arch/arm/dts/an7583.dtsi
@@ -105,6 +105,21 @@
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 
+	clk25m: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "clkxtal";
+	};
+
+	vmmc_3v3: regulator-vmmc-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -259,6 +274,24 @@
 			};
 		};
 
+		mmc0: mmc@1fa0e000 {
+			compatible = "mediatek,mt7622-mmc";
+			reg = <0x0 0x1fa0e000 0x0 0x1000>,
+				<0x0 0x1fa0c000 0x0 0x60>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scuclk EN7581_CLK_EMMC>, <&clk25m>;
+			clock-names = "source", "hclk";
+			bus-width = <4>;
+			max-frequency = <52000000>;
+			vmmc-supply = <&vmmc_3v3>;
+			disable-wp;
+			cap-mmc-highspeed;
+			non-removable;
+
+			assigned-clocks = <&scuclk EN7581_CLK_EMMC>;
+			assigned-clock-rates = <200000000>;
+		};
+
 		uart1: serial@1fbf0000 {
 			compatible = "ns16550";
 			reg = <0x0 0x1fbf0000 0x0 0x30>;
-- 
2.53.0

