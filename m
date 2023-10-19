Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEC8CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 09:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF951871F3;
	Thu, 19 Oct 2023 11:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="WSw+gfth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9BDF871DF; Thu, 19 Oct 2023 11:58:54 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2071b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe12::71b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EF57871C9
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 11:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OywEBDQ0RXsLqO2queI5X5kCyf+R0NKWeCYp3zjRWI97iqfNHqIB10p29URQK1nXvFFPenTHW8tAyV57Yn0xQUOIV6fn6OW1dDJCPqGSMxZUsfI2oVQ93KMjV43sDhoKIe7Rczt+FglPPcIIbN+4+2c1nF+kX33AJC8HOuLYrwUAeX8afPkW7uFs0ijKYzMeueG/fjtplQhvF5wenk2rUWSWrMnXBSZjzAZy2FQHFE7eYM+twKwwDM0n3+a8IUX7mJG1UDZCMFm/KGCSBU98NNDfcCDpXpuiIIoDk4K0/aFBHV1ldMwTK/xtOmYDcc+6Yrt0jIRceyUFJyDv7z+EqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAnbSUyJlK1NUYGFLr6rzwfpkdDajd/qmQPf8t4qK2o=;
 b=AYcbsANFwM/4GqfUFm+fx9WgBDtdET0wyfs71jmjGszxy1RQDPsJZUrF1C4k8nJOEA1LJh6+fviWjmknKy3CXrNP7Jw63kC5lj2f4xeXPMMyeNvqH6r/pCNmcxMJHZrXYBGldaImHRs8MGCWd2QqLAdTYd5PJ3MWhV1jAEjFs+Ls3uhprW4n48Z6/+EYcaZ+YTMHXMoaZcOFlrT8Hjh2QF8gKkJM98+okL7ZGflo6UUW00cT7RT23wVUKwKrJHZ5/9qEZkdA9ciSmfIHtEeg5N8R/hzGsKu4IonqniecGVjnww8/acu6ueGjOzfCq2djCBMreX4NTgiotxXX0uqryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAnbSUyJlK1NUYGFLr6rzwfpkdDajd/qmQPf8t4qK2o=;
 b=WSw+gfth2T1yCCCIPPUYyZ61LylTwTd9wL2Lj9IbttEXKHi01TZEpV3pP/cSkKtVFqNdn1dQJbzJJ6xTdolFxHJIs2OcJ0vcf8cBGo4zgfj4DyS9gf8Ddu/RGwBSGndO2QUngXe1S7T9uFBfRwQuXiS9+dnnYleYnyJXx35VPI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU0PR10MB7481.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:424::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 09:58:50 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 09:58:50 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 6/6] led: add TI LP5562 LED driver
Date: Thu, 19 Oct 2023 11:58:37 +0200
Message-Id: <20231019095837.2084458-7-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0094.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::35) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU0PR10MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 76fb35c9-3c5f-42a7-c831-08dbd089fe9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FrFi4D6M85TKS6MoSvnzuRfFQHM5Ut9jsvy02P/QVRO0YvE16Uf54chMDecOfzidfj/Pfe257Ly16Skzi+rUU2pKEceuO8sfYhNhd/eJWudz9ReOJh3A6LXl9RwHNTHS4ccHIR92J/ABcWlBIYTvPN9WFiN+nKpcRmhQoSB28Dt4aoLC4IwlK06RcpC0/cegTgIA9RijHEfIwLjGYF38xDSP2m9RKF1B6PSDw3rWvP2oGpyfmjYp8M0+El7iZjnr4QafJN9UfWpKhY7qSs1Ylx5OoMSNJ7eWOXfiLwsfDs1uOYjJKHfTQ3ZM5i4NGUQhSTUPgL3+fWggcKaxjQIG6wS1ki/YcwMEcwBXGtKWcOrmFYjZMDjNU1/J1FiNV0a5znW19p9mIhu+pDHRcNhEywXoIZMrSgXkh8aDT0qn8qcuVQIV6JnmhkFf6N2NVY7zPYIeu3uHiVs7g6ejuTOFu/27uZvuqwzjNjhIK8IGOfow7huNOz9vx3kiMgj92f3LZeTIZpJTWsrr3B3Wrkh2CjECY13bDcrq5NJp5fX/MrnrAbR5quFf+7bc8rtBzgVWkFuOjqL3iMvf57LFD1RpneZ20G9o384PYMUm3vehetU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(346002)(39850400004)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(38350700005)(2906002)(38100700002)(44832011)(41300700001)(36756003)(86362001)(83380400001)(26005)(6512007)(1076003)(52116002)(6506007)(2616005)(107886003)(30864003)(5660300002)(4326008)(6666004)(478600001)(8676002)(6486002)(66476007)(54906003)(66946007)(6916009)(966005)(8976002)(316002)(8936002)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dElkcHcvK2JmdWt2bm1QR1hxT0JYbWVrNVh3d3hHSGVwdk1OZWhLY3RiUEk0?=
 =?utf-8?B?N1JPbDRvMHhxdkNBdzdFdnEwVXBjY0RmTmNPZ1lzbFhwY3FsMHNOZStDRUR2?=
 =?utf-8?B?dnRUdFdDT2c2dnFXUGQzcVJ0MzVPZTB4WnlCdHpUM2hBekN5TnpCd09QUUxm?=
 =?utf-8?B?VUUrcWNpNkY1dWNoVXNGSyttU0k4ekxrZkhJU2dEajRwQlZoR28zMktBS1VH?=
 =?utf-8?B?dUlYQlM0SUR0dGpWZ3ZrVW5LZ3hSQ3hJdytiL0dZZVFKRzVxRUltL2JhcVo1?=
 =?utf-8?B?WXRsbWhHWmJRTFNHV1NnM29kVVBVc2NZQUdSOHVDa0Vna2RXVUdNREFyYkVV?=
 =?utf-8?B?S0ViSDM5MWhOb3hXQTByOVFhV1BSSUlSS3c5ZVBxV2ZlaWJYQnFEUDQ4bmdt?=
 =?utf-8?B?VWcvVWFvT0M2Yks4by80UDI2V3pEaDlvRWZPM3NyWWh6Ymp3WUxkcTVZd2o0?=
 =?utf-8?B?dDRVMDZ2VDVpUElUcUxRZ2dFMkRSd1BLcFVoQmpvZDNvdFZyYURNQlpJaHBI?=
 =?utf-8?B?bEoxd1dpYTJ2TWltWWVvL1RUT1FjdzR5OFRFREY2ckFvOFY1RFhneWwxQUF1?=
 =?utf-8?B?RjV4U3dSNTkwZkxIM2pDYUlvaVZpbWlndFdSRkxMT1h4MEpKV1RUN2dPTHll?=
 =?utf-8?B?SGdkZmdPVU1tNkJ3bHpKNXRJWmJueStwYUJKcG5SUFl1NVNvdEZ5aEpxRFl6?=
 =?utf-8?B?bS9hZWY3MXExRHBiQWxmaDZzbTgrV1NiN25sU0Z1dFdIL0F3N0ZpcFpYcmt4?=
 =?utf-8?B?eC9zZGR1SlRsNVdjc0xmbmFva2ozaWJOOG5oZkJFODJTMXZCVW84ZEpVdHgv?=
 =?utf-8?B?NGxKN3dab01lMS80Y0hQaUU1VTlMc1pmSFNUS080MmhQaDJFQ0pMV0RubGN3?=
 =?utf-8?B?b1REbWFUa05tWlVPZ2svMVFicjVjMHZtTEFDS3h6amsyWDc3citJVGNKVkto?=
 =?utf-8?B?eTRnVlp1VmFLWEV2SnR0TjllRFhwRVV2WFl4dmJJR3d4SVdMMkxkdXBabEdm?=
 =?utf-8?B?eldqemZnV2czWUZrNjlIVjF3bG9Mc3RsbndXMjFrVjQyS3FELzE5OXE1amkv?=
 =?utf-8?B?S1FBclJ5RjF5LytVREh4NFBtSCtuR2pyellQOFdNQytCYjlsejlrUGhrQ3FC?=
 =?utf-8?B?SFpFMk9pY0l2YjZxLzk0N3BITWNYRDltTmdnNFpJUnUwdjZJV2xIWVNKZ3Nw?=
 =?utf-8?B?aFA0QWROcHdkdWQ2aG9menNhay9iQWlMdXlYUDQ2cElRam1UVUJTLzQ1TFlV?=
 =?utf-8?B?cys0d01rTUl5U3N3ZWZVVm5qNXFReXZmNU9OQnd4UDZ4czdLOEI5eCttZG4y?=
 =?utf-8?B?WWNjeW5kbTVLZndndU45bU11RmNMbVNIQk5hVWoraFFVM2U4a1dlK3NRRUUy?=
 =?utf-8?B?cWpNeVUxQUkyRjcvTDVGNmJINHZ0QzgzUVhvVzlibEtuVlJBN2FUN2tiYVBL?=
 =?utf-8?B?cFYwelJTUVhKdm5WZ0hJUnJ2c1ZnQVJLbW8wQTY4ck1vVnZQSnRGalhrL243?=
 =?utf-8?B?bE5ObTMxU04vSzYwTTUxNmlrZHhHNGVPMzhtNkwzS29jZmxXSzdpV2hqYnZB?=
 =?utf-8?B?eEpjek1DMmlDTWZuaHIrd2gxdVpPamF6QkI1RnlXSEU4ckRMRmJKR2xEZXJX?=
 =?utf-8?B?UndLa1ZubmpxRytLRkxkT3FhZFU4QlBUekRBclUyMGMvMytNWHA0TmpEV3Jx?=
 =?utf-8?B?Ym1JL0tialpsZWJMWXZQSVVCcm9nRkJPb2t5WWZ4Y25WLy8xcEprVjAxb05l?=
 =?utf-8?B?S3ZYaWtnU1dSSEU0eUphdXduU0c3R0U5RDVVSDhZYUpLdlZZbkVpNGJiVktO?=
 =?utf-8?B?VHdCYVRRanI2MmFhajJMMTg2U1pDa0x5Znc1Y0dmUEdIM3pBQU1tTm1xSmpV?=
 =?utf-8?B?Q2VBMWhXWGlERjkyM05aOEc0Y293ZjJ1cTFOK3EremJQSkhYS054bzFwc0JM?=
 =?utf-8?B?SHRmWUNuanJ0ZHlYTGlKNTRiblZtaytpV2tkVGQ3a0VvZ1R4aXZVOXczRkFY?=
 =?utf-8?B?Yyt1cFVML0pmMnZuYkxYOEJESVd2SzVCaUJ0d1FMQStrQytEc0lzc1VhU0Jw?=
 =?utf-8?B?eXFjNGc5UnNCTUhaeTAwZElDdUhyN01YNmJiMHI4K1oyU09JZldsUzgxWkxa?=
 =?utf-8?B?Q3R0NlZscWNzdUFmSUx5VXh5NE8rTWExUUh5WHJYUFB3aVlDSDN0UXh4NC9i?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fb35c9-3c5f-42a7-c831-08dbd089fe9e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 09:58:50.5572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2x1D8FcFNVGmlsZIIfXsz5ev2YNXUbfeZhaIOMYLpXnvK6pDtzEu8KuMrAHyox7c6WQq2a6Q8Ei7knjhSuElEaSDbJqD5ziTK9QnarSRLkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7481
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

From: Doug Zobel <douglas.zobel@climate.com>

Driver for the TI LP5562 4 channel LED controller. Supports
independent on/off control of all 4 channels. Supports LED_BLINK on 3
independent channels: blue/green/red. The white channel can blink, but
shares the blue channel blink rate.

Heavily based on patch originally from Doug Zobel [1].

I have modified it so it matches the DT bindings in the linux tree,
and also follows the linux driver implementation more closely. This
should address Tom's concerns, and also matches my goal of making the
U-Boot driver work with our existing .dts which is known to work in
linux.

As our boards only have the R,G,B outputs connected, I have not
actually tested how the white channel behaves, but the R,G,B work
exactly as expected.

[1] https://lore.kernel.org/u-boot/1547150757-1561-1-git-send-email-douglas.zobel@climate.com/

Cc: Doug Zobel <douglas.zobel@climate.com>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 doc/device-tree-bindings/leds/leds-lp5562.txt |  63 ++
 drivers/led/Kconfig                           |   8 +
 drivers/led/Makefile                          |   1 +
 drivers/led/led_lp5562.c                      | 578 ++++++++++++++++++
 4 files changed, 650 insertions(+)
 create mode 100644 doc/device-tree-bindings/leds/leds-lp5562.txt
 create mode 100644 drivers/led/led_lp5562.c

diff --git a/doc/device-tree-bindings/leds/leds-lp5562.txt b/doc/device-tree-bindings/leds/leds-lp5562.txt
new file mode 100644
index 0000000000..4e0c742959
--- /dev/null
+++ b/doc/device-tree-bindings/leds/leds-lp5562.txt
@@ -0,0 +1,63 @@
+LEDs connected to TI LP5562 controller
+
+This driver works with a TI LP5562 4-channel LED controller.
+CONFIG_LED_BLINK is supported using the controller engines.  However
+there are only 3 engines available for the 4 channels.  This means
+that the blue and white channels share the same engine.  When both
+blue and white LEDs are set to blink, they will share the same blink
+rate.  Changing the blink rate of the blue LED will affect the white
+LED and vice-versa.  Manual on/off is handled independently for all 4
+channels.
+
+Required properties:
+  - compatible : should be "ti,lp5562".
+  - #address-cells : must be 1.
+  - #size-cells : must be 0.
+  - reg : LP5562 LED controller I2C address.
+
+Optional properties:
+  - enable-gpios : Enable GPIO
+  - clock-mode : u8, configures the clock mode:
+      - 0 # automode
+      - 1 # internal
+      - 2 # external
+
+Each LED is represented as a sub-node of the ti,lp5562 device.
+
+LED sub-node required properties:
+  - reg : Zero-based channel identifier:
+    - 0 red
+    - 1 green
+    - 2 blue
+    - 3 white
+
+LED sub-node optional properties:
+  - chan-name : name of LED
+  - max-cur : LED current at max brightness in 100uA steps (0x00 - 0xFF)
+    Default : 100 (10 mA)
+
+Example:
+        leds0: lp5562@30 {
+                compatible = "ti,lp5562";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                enable-gpios = <&gpio3 9 GPIO_ACTIVE_HIGH>;
+                reg = <0x30>;
+		clock-mode = /bits/8 <1>;
+
+                led@0 {
+                        reg = <0>;
+                        chan-name = "red";
+                        max-cur = /bits/ 8 <200>; /* 20mA */
+                };
+                led@1 {
+                        reg = <1>;
+                        chan-name = "green";
+                        max-cur = /bits/ 8 <200>; /* 20mA */
+                };
+                led@2 {
+                        reg = <2>;
+                        chan-name = "blue";
+                        max-cur = /bits/ 8 <200>; /* 20mA */
+                };
+        };
diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index 996b757e6d..9837960198 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -49,6 +49,14 @@ config LED_CORTINA
 	  This option enables support for LEDs connected to the Cortina
 	  Access CAxxxx SOCs.
 
+config LED_LP5562
+	bool "LED Support for LP5562"
+	depends on LED && DM_I2C
+	help
+	  This option enables support for LEDs connected to the TI LP5562
+	  4 channel I2C LED controller.  Driver fully supports blink on the
+	  B/G/R LEDs.  White LED can blink, but re-uses the period from blue.
+
 config LED_PWM
 	bool "LED PWM"
 	depends on LED && DM_PWM
diff --git a/drivers/led/Makefile b/drivers/led/Makefile
index 49ae91961d..2bcb858908 100644
--- a/drivers/led/Makefile
+++ b/drivers/led/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_LED_BCM6858) += led_bcm6858.o
 obj-$(CONFIG_LED_PWM) += led_pwm.o
 obj-$(CONFIG_$(SPL_)LED_GPIO) += led_gpio.o
 obj-$(CONFIG_LED_CORTINA) += led_cortina.o
+obj-$(CONFIG_LED_LP5562) += led_lp5562.o
diff --git a/drivers/led/led_lp5562.c b/drivers/led/led_lp5562.c
new file mode 100644
index 0000000000..87479ec551
--- /dev/null
+++ b/drivers/led/led_lp5562.c
@@ -0,0 +1,578 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Doug Zobel <douglas.zobel@climate.com>
+ *
+ * Driver for TI lp5562 4 channel LED driver.  There are only 3
+ * engines available for the 4 LEDs, so white and blue LEDs share
+ * the same engine.  This means that the blink period is shared
+ * between them.  Changing the period of blue blink will affect
+ * the white period (and vice-versa).  Blue and white On/Off
+ * states remain independent (as would PWM brightness if that's
+ * ever added to the LED core).
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <errno.h>
+#include <led.h>
+#include <i2c.h>
+#include <asm/gpio.h>
+#include <linux/delay.h>
+
+#define DEFAULT_CURRENT			100  /* 10 mA */
+#define MIN_BLINK_PERIOD		32   /* ms */
+#define MAX_BLINK_PERIOD		2248 /* ms */
+
+/* Register Map */
+#define REG_ENABLE			0x00
+#define REG_OP_MODE			0x01
+#define REG_B_PWM			0x02
+#define REG_G_PWM			0x03
+#define REG_R_PWM			0x04
+#define REG_B_CUR			0x05
+#define REG_G_CUR			0x06
+#define REG_R_CUR			0x07
+#define REG_CONFIG			0x08
+#define REG_ENG1_PC			0x09
+#define REG_ENG2_PC			0x0A
+#define REG_ENG3_PC			0x0B
+#define REG_STATUS			0x0C
+#define REG_RESET			0x0D
+#define REG_W_PWM			0x0E
+#define REG_W_CUR			0x0F
+#define REG_ENG1_MEM_BEGIN		0x10
+#define REG_ENG2_MEM_BEGIN		0x30
+#define REG_ENG3_MEM_BEGIN		0x50
+#define REG_LED_MAP			0x70
+
+/* LED Register Values */
+/* 0x00  ENABLE */
+#define REG_ENABLE_CHIP_ENABLE		(0x1 << 6)
+#define REG_ENABLE_ENG_EXEC_HOLD	0x0
+#define REG_ENABLE_ENG_EXEC_RUN		0x2
+#define REG_ENABLE_ENG_EXEC_MASK	0x3
+
+/* 0x01  OP MODE */
+#define REG_OP_MODE_DISABLED		0x0
+#define REG_OP_MODE_LOAD_SRAM		0x1
+#define REG_OP_MODE_RUN			0x2
+#define REG_OP_MODE_MASK		0x3
+
+/* 0x02, 0x03, 0x04, 0x0E  PWM */
+#define REG_PWM_MIN_VALUE		0
+#define REG_PWM_MAX_VALUE		0xFF
+
+/* 0x08  CONFIG */
+#define REG_CONFIG_EXT_CLK		0x0
+#define REG_CONFIG_INT_CLK		0x1
+#define REG_CONFIG_AUTO_CLK		0x2
+#define REG_CONFIG_CLK_MASK		0x3
+
+/* 0x0D  RESET */
+#define REG_RESET_RESET			0xFF
+
+/* 0x70  LED MAP */
+#define REG_LED_MAP_ENG_MASK		0x03
+#define REG_LED_MAP_W_ENG_SHIFT		6
+#define REG_LED_MAP_R_ENG_SHIFT		4
+#define REG_LED_MAP_G_ENG_SHIFT		2
+#define REG_LED_MAP_B_ENG_SHIFT		0
+
+/* Engine program related */
+#define REG_ENGINE_MEM_SIZE		0x20
+#define LED_PGRM_RAMP_INCREMENT_SHIFT	0
+#define LED_PGRM_RAMP_SIGN_SHIFT	7
+#define LED_PGRM_RAMP_STEP_SHIFT	8
+#define LED_PGRM_RAMP_PRESCALE_SHIFT	14
+
+struct lp5562_led_wrap_priv {
+	struct gpio_desc enable_gpio;
+};
+
+struct lp5562_led_priv {
+	u8 reg_pwm;
+	u8 reg_current;
+	u8 map_shift;
+	u8 enginenum;
+};
+
+/* enum values map to LED_MAP (0x70) values */
+enum lp5562_led_ctl_mode {
+	I2C = 0x0,
+#ifdef CONFIG_LED_BLINK
+	ENGINE1 = 0x1,
+	ENGINE2 = 0x2,
+	ENGINE3 = 0x3
+#endif
+};
+
+/*
+ * Update a register value
+ *  dev     - I2C udevice (parent of led)
+ *  regnum  - register number to update
+ *  value   - value to write to register
+ *  mask    - mask of bits that should be changed
+ */
+static int lp5562_led_reg_update(struct udevice *dev, int regnum,
+				 u8 value, u8 mask)
+{
+	int ret;
+
+	if (mask == 0xFF)
+		ret = dm_i2c_reg_write(dev, regnum, value);
+	else
+		ret = dm_i2c_reg_clrset(dev, regnum, mask, value);
+
+
+	/*
+	 * Data sheet says "Delay between consecutive I2C writes to
+	 * ENABLE register (00h) need to be longer than 488 μs
+	 * (typical)." and "Delay between consecutive I2C writes to
+	 * OP_MODE register need to be longer than 153 μs (typ)."
+	 *
+	 * The linux driver does usleep_range(500, 600) and
+	 * usleep_range(200, 300), respectively.
+	 */
+	switch (regnum) {
+	case REG_ENABLE:
+		udelay(600);
+		break;
+	case REG_OP_MODE:
+		udelay(300);
+		break;
+	}
+
+	return ret;
+}
+
+#ifdef CONFIG_LED_BLINK
+/*
+ * Program the lp5562 engine
+ *  dev     - I2C udevice (parent of led)
+ *  program - array of commands
+ *  size    - number of commands in program array (1-16)
+ *  engine  - engine number (1-3)
+ */
+static int lp5562_led_program_engine(struct udevice *dev, u16 *program,
+				     u8 size, u8 engine)
+{
+	int ret, cmd;
+	u8 engine_reg = REG_ENG1_MEM_BEGIN +
+			     ((engine - 1) * REG_ENGINE_MEM_SIZE);
+	u8 shift = (3 - engine) * 2;
+	__be16 prog_be[16];
+
+	if (size < 1 || size > 16 || engine < 1 || engine > 3)
+		return -EINVAL;
+
+	for (cmd = 0; cmd < size; cmd++)
+		prog_be[cmd] = cpu_to_be16(program[cmd]);
+
+	/* set engine mode to 'disabled' */
+	ret = lp5562_led_reg_update(dev, REG_OP_MODE,
+				    REG_OP_MODE_DISABLED << shift,
+				    REG_OP_MODE_MASK << shift);
+	if (ret != 0)
+		goto done;
+
+	/* set exec mode to 'hold' */
+	ret = lp5562_led_reg_update(dev, REG_ENABLE,
+				    REG_ENABLE_ENG_EXEC_HOLD << shift,
+				    REG_ENABLE_ENG_EXEC_MASK << shift);
+	if (ret != 0)
+		goto done;
+
+	/* set engine mode to 'load SRAM' */
+	ret = lp5562_led_reg_update(dev, REG_OP_MODE,
+				    REG_OP_MODE_LOAD_SRAM << shift,
+				    REG_OP_MODE_MASK << shift);
+	if (ret != 0)
+		goto done;
+
+	/* send the re-ordered program sequence */
+	ret = dm_i2c_write(dev, engine_reg, (uchar *)prog_be, sizeof(u16) * size);
+	if (ret != 0)
+		goto done;
+
+	/* set engine mode to 'run' */
+	ret = lp5562_led_reg_update(dev, REG_OP_MODE,
+				    REG_OP_MODE_RUN << shift,
+				    REG_OP_MODE_MASK << shift);
+	if (ret != 0)
+		goto done;
+
+	/* set engine exec to 'run' */
+	ret = lp5562_led_reg_update(dev, REG_ENABLE,
+				    REG_ENABLE_ENG_EXEC_RUN << shift,
+				    REG_ENABLE_ENG_EXEC_MASK << shift);
+
+done:
+	return ret;
+}
+
+/*
+ * Get the LED's current control mode (I2C or ENGINE[1-3])
+ *  dev       - led udevice (child udevice)
+ */
+static enum lp5562_led_ctl_mode lp5562_led_get_control_mode(struct udevice *dev)
+{
+	struct lp5562_led_priv *priv = dev_get_priv(dev);
+	u8 data;
+	enum lp5562_led_ctl_mode mode = I2C;
+
+	if (dm_i2c_read(dev_get_parent(dev), REG_LED_MAP, &data, 1) == 0)
+		mode = (data & (REG_LED_MAP_ENG_MASK << priv->map_shift))
+			>> priv->map_shift;
+
+	return mode;
+}
+#endif
+
+/*
+ * Set the LED's control mode to I2C or ENGINE[1-3]
+ *  dev       - led udevice (child udevice)
+ *  mode      - mode to change to
+ */
+static int lp5562_led_set_control_mode(struct udevice *dev,
+				       enum lp5562_led_ctl_mode mode)
+{
+	struct lp5562_led_priv *priv = dev_get_priv(dev);
+
+	return (lp5562_led_reg_update(dev_get_parent(dev), REG_LED_MAP,
+				      mode << priv->map_shift,
+				      REG_LED_MAP_ENG_MASK << priv->map_shift));
+}
+
+/*
+ * Return the LED's PWM value;  If LED is in BLINK state, then it is
+ * under engine control mode which doesn't use this PWM value.
+ *  dev       - led udevice (child udevice)
+ */
+static int lp5562_led_get_pwm(struct udevice *dev)
+{
+	struct lp5562_led_priv *priv = dev_get_priv(dev);
+	u8 data;
+
+	if (dm_i2c_read(dev_get_parent(dev), priv->reg_pwm, &data, 1) != 0)
+		return -EINVAL;
+
+	return data;
+}
+
+/*
+ * Set the LED's PWM value and configure it to use this (I2C mode).
+ *  dev       - led udevice (child udevice)
+ *  value     - PWM value (0 - 255)
+ */
+static int lp5562_led_set_pwm(struct udevice *dev, u8 value)
+{
+	struct lp5562_led_priv *priv = dev_get_priv(dev);
+
+	if (lp5562_led_reg_update(dev_get_parent(dev), priv->reg_pwm,
+				  value, 0xff) != 0)
+		return -EINVAL;
+
+	/* set LED to I2C register mode */
+	return lp5562_led_set_control_mode(dev, I2C);
+}
+
+/*
+ * Return the led's current state
+ *  dev     - led udevice (child udevice)
+ *
+ */
+static enum led_state_t lp5562_led_get_state(struct udevice *dev)
+{
+	enum led_state_t state = LEDST_ON;
+
+	if (lp5562_led_get_pwm(dev) == REG_PWM_MIN_VALUE)
+		state = LEDST_OFF;
+
+#ifdef CONFIG_LED_BLINK
+	if (lp5562_led_get_control_mode(dev) != I2C)
+		state = LEDST_BLINK;
+#endif
+
+	return state;
+}
+
+/*
+ * Set the led state
+ *  dev     - led udevice (child udevice)
+ *  state   - State to set the LED to
+ */
+static int lp5562_led_set_state(struct udevice *dev, enum led_state_t state)
+{
+#ifdef CONFIG_LED_BLINK
+	struct lp5562_led_priv *priv = dev_get_priv(dev);
+#endif
+
+	switch (state) {
+	case LEDST_OFF:
+		return lp5562_led_set_pwm(dev, REG_PWM_MIN_VALUE);
+	case LEDST_ON:
+		return lp5562_led_set_pwm(dev, REG_PWM_MAX_VALUE);
+#ifdef CONFIG_LED_BLINK
+	case LEDST_BLINK:
+		return lp5562_led_set_control_mode(dev, priv->enginenum);
+#endif
+	case LEDST_TOGGLE:
+		if (lp5562_led_get_state(dev) == LEDST_OFF)
+			return lp5562_led_set_state(dev, LEDST_ON);
+		else
+			return lp5562_led_set_state(dev, LEDST_OFF);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_LED_BLINK
+/*
+ * Set the blink period of an LED; note blue and white share the same
+ * engine so changing the period of one affects the other.
+ *  dev       - led udevice (child udevice)
+ *  period_ms - blink period in ms
+ */
+static int lp5562_led_set_period(struct udevice *dev, int period_ms)
+{
+	struct lp5562_led_priv *priv = dev_get_priv(dev);
+	u8 opcode = 0;
+	u16 program[7];
+	u16 wait_time;
+
+	/* Blink is implemented as an engine program.  Simple on/off
+	 * for short periods, or fade in/fade out for longer periods:
+	 *
+	 *  if (period_ms < 500):
+	 *    set PWM to 100%
+	 *    pause for period / 2
+	 *    set PWM to 0%
+	 *    pause for period / 2
+	 *    goto start
+	 *
+	 *  else
+	 *    raise PWM 0% -> 50% in 62.7 ms
+	 *    raise PWM 50% -> 100% in 62.7 ms
+	 *    pause for (period - 4 * 62.7) / 2
+	 *    lower PWM 100% -> 50% in 62.7 ms
+	 *    lower PWM 50% -> 0% in 62.7 ms
+	 *    pause for (period - 4 * 62.7) / 2
+	 *    goto start
+	 */
+
+	if (period_ms < MIN_BLINK_PERIOD)
+		period_ms = MIN_BLINK_PERIOD;
+	else if (period_ms > MAX_BLINK_PERIOD)
+		period_ms = MAX_BLINK_PERIOD;
+
+	if (period_ms < 500) {
+		/* Simple on/off blink */
+		wait_time = period_ms / 2;
+
+		/* 1st command is full brightness */
+		program[opcode++] =
+			(1 << LED_PGRM_RAMP_PRESCALE_SHIFT) |
+			REG_PWM_MAX_VALUE;
+
+		/* 2nd command is wait (period / 2) using 15.6ms steps */
+		program[opcode++] =
+			(1 << LED_PGRM_RAMP_PRESCALE_SHIFT) |
+			(((wait_time * 10) / 156) << LED_PGRM_RAMP_STEP_SHIFT) |
+			(0 << LED_PGRM_RAMP_INCREMENT_SHIFT);
+
+		/* 3rd command is 0% brightness */
+		program[opcode++] =
+			(1 << LED_PGRM_RAMP_PRESCALE_SHIFT);
+
+		/* 4th command is wait (period / 2) using 15.6ms steps */
+		program[opcode++] =
+			(1 << LED_PGRM_RAMP_PRESCALE_SHIFT) |
+			(((wait_time * 10) / 156) << LED_PGRM_RAMP_STEP_SHIFT) |
+			(0 << LED_PGRM_RAMP_INCREMENT_SHIFT);
+
+		/* 5th command: repeat */
+		program[opcode++] = 0x00;
+	} else {
+		/* fade-in / fade-out blink */
+		wait_time = ((period_ms - 251) / 2);
+
+		/* ramp up time is 256 * 0.49ms (125.4ms) done in 2 steps */
+		/* 1st command is ramp up 1/2 way */
+		program[opcode++] =
+			(0 << LED_PGRM_RAMP_PRESCALE_SHIFT) |
+			(1 << LED_PGRM_RAMP_STEP_SHIFT) |
+			(127 << LED_PGRM_RAMP_INCREMENT_SHIFT);
+
+		/* 2nd command is ramp up rest of the way */
+		program[opcode++] =
+			(0 << LED_PGRM_RAMP_PRESCALE_SHIFT) |
+			(1 << LED_PGRM_RAMP_STEP_SHIFT) |
+			(127 << LED_PGRM_RAMP_INCREMENT_SHIFT);
+
+		/* 3rd: wait ((period - 2 * ramp_time) / 2) (15.6ms steps) */
+		program[opcode++] =
+			(1 << LED_PGRM_RAMP_PRESCALE_SHIFT) |
+			(((wait_time * 10) / 156) << LED_PGRM_RAMP_STEP_SHIFT) |
+			(0 << LED_PGRM_RAMP_INCREMENT_SHIFT);
+
+		/* ramp down is same as ramp up with sign bit set */
+		/* 4th command is ramp down 1/2 way */
+		program[opcode++] =
+			(0 << LED_PGRM_RAMP_PRESCALE_SHIFT) |
+			(1 << LED_PGRM_RAMP_STEP_SHIFT) |
+			(1 << LED_PGRM_RAMP_SIGN_SHIFT) |
+			(127 << LED_PGRM_RAMP_INCREMENT_SHIFT);
+
+		/* 5th command is ramp down rest of the way */
+		program[opcode++] =
+			(0 << LED_PGRM_RAMP_PRESCALE_SHIFT) |
+			(1 << LED_PGRM_RAMP_STEP_SHIFT) |
+			(1 << LED_PGRM_RAMP_SIGN_SHIFT) |
+			(127 << LED_PGRM_RAMP_INCREMENT_SHIFT);
+
+		/* 6th: wait ((period - 2 * ramp_time) / 2) (15.6ms steps) */
+		program[opcode++] =
+			(1 << LED_PGRM_RAMP_PRESCALE_SHIFT) |
+			(((wait_time * 10) / 156) << LED_PGRM_RAMP_STEP_SHIFT) |
+			(0 << LED_PGRM_RAMP_INCREMENT_SHIFT);
+
+		/* 7th command: repeat */
+		program[opcode++] = 0x00;
+	}
+
+	return lp5562_led_program_engine(dev_get_parent(dev), program,
+					 opcode, priv->enginenum);
+}
+#endif
+
+static const struct led_ops lp5562_led_ops = {
+	.get_state = lp5562_led_get_state,
+	.set_state = lp5562_led_set_state,
+#ifdef CONFIG_LED_BLINK
+	.set_period = lp5562_led_set_period,
+#endif
+};
+
+static int lp5562_led_probe(struct udevice *dev)
+{
+	struct lp5562_led_priv *priv = dev_get_priv(dev);
+	u8 current;
+	int ret = 0;
+
+	/* Child LED nodes */
+	switch (dev_read_addr(dev)) {
+	case 0:
+		priv->reg_current = REG_R_CUR;
+		priv->reg_pwm = REG_R_PWM;
+		priv->map_shift = REG_LED_MAP_R_ENG_SHIFT;
+		priv->enginenum = 1;
+		break;
+	case 1:
+		priv->reg_current = REG_G_CUR;
+		priv->reg_pwm = REG_G_PWM;
+		priv->map_shift = REG_LED_MAP_G_ENG_SHIFT;
+		priv->enginenum = 2;
+		break;
+	case 2:
+		priv->reg_current = REG_B_CUR;
+		priv->reg_pwm = REG_B_PWM;
+		priv->map_shift = REG_LED_MAP_B_ENG_SHIFT;
+		priv->enginenum = 3; /* shared with white */
+		break;
+	case 3:
+		priv->reg_current = REG_W_CUR;
+		priv->map_shift = REG_LED_MAP_W_ENG_SHIFT;
+		priv->enginenum = 3; /* shared with blue */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	current = dev_read_u8_default(dev, "max-cur", DEFAULT_CURRENT);
+
+	ret = lp5562_led_reg_update(dev_get_parent(dev), priv->reg_current,
+				    current, 0xff);
+
+	return ret;
+}
+
+static int lp5562_led_bind(struct udevice *dev)
+{
+	struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+
+	/*
+	 * For the child nodes, parse a "chan-name" property, since
+	 * the DT bindings for this device use that instead of
+	 * "label".
+	 */
+	uc_plat->label = dev_read_string(dev, "chan-name");
+
+	return 0;
+}
+
+U_BOOT_DRIVER(lp5562_led) = {
+	.name = "lp5562-led",
+	.id = UCLASS_LED,
+	.bind = lp5562_led_bind,
+	.probe = lp5562_led_probe,
+	.priv_auto = sizeof(struct lp5562_led_priv),
+	.ops = &lp5562_led_ops,
+};
+
+
+static int lp5562_led_wrap_probe(struct udevice *dev)
+{
+	struct lp5562_led_wrap_priv *priv = dev_get_priv(dev);
+	u8 clock_mode;
+	int ret;
+
+	/* Enable gpio if needed */
+	if (gpio_request_by_name(dev, "enabled-gpios", 0,
+				 &priv->enable_gpio, GPIOD_IS_OUT) == 0) {
+		dm_gpio_set_value(&priv->enable_gpio, 1);
+		udelay(1000);
+	}
+
+	/* Ensure all registers have default values. */
+	ret = lp5562_led_reg_update(dev, REG_RESET, REG_RESET_RESET, 0xff);
+	if (ret)
+		return ret;
+	udelay(10000);
+
+	/* Enable the chip */
+	ret = lp5562_led_reg_update(dev, REG_ENABLE, REG_ENABLE_CHIP_ENABLE, 0xff);
+	if (ret)
+		return ret;
+
+	/*
+	 * The DT bindings say 0=auto, 1=internal, 2=external, while
+	 * the register[0:1] values are 0=external, 1=internal,
+	 * 2=auto.
+	 */
+	clock_mode = dev_read_u8_default(dev, "clock-mode", 0);
+	ret = lp5562_led_reg_update(dev, REG_CONFIG, 2 - clock_mode, REG_CONFIG_CLK_MASK);
+
+	return ret;
+}
+
+static int lp5562_led_wrap_bind(struct udevice *dev)
+{
+	return led_bind_generic(dev, "lp5562-led");
+}
+
+static const struct udevice_id lp5562_led_ids[] = {
+	{ .compatible = "ti,lp5562" },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(lp5562_led_wrap) = {
+	.name = "lp5562-led-wrap",
+	.id = UCLASS_NOP,
+	.of_match = lp5562_led_ids,
+	.bind = lp5562_led_wrap_bind,
+	.probe = lp5562_led_wrap_probe,
+	.priv_auto = sizeof(struct lp5562_led_wrap_priv),
+};
-- 
2.40.1.1.g1c60b9335d

