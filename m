Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABFAFD2D79
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A490D840A9;
	Tue, 10 Mar 2026 14:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qMQEX/mO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2623083F9B; Tue, 10 Mar 2026 10:14:51 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4980C83981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 10:14:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lg2ZbTWkuwf3ZN4Y5ZEqO33LLZRhsbWHcAJQALMS2zb0u6tJcWiACKIAlrFi5TlfqkS1+yi21QhALwSpQ1oboJXG67a5SF73QkMuFnZ5BRDxkopCi9fofvtzUNS87nkExIfXQ1WgKxMURQvtFqqAtZlC/VZCejSCjXPtkVIRd8dv+Nc5vDlwzCAh5yt5oVzDosaG+366QYOd4JG9NMcT4HBFUa6liXOMgd/yHELyf3rBhRJULYulQWGQYO6hCJB49U3EDXG6k4V31Jos5gjfKZY8TSI4ZelijNVdcuS/FIja5T3nrtbp/BLpT+O8YuNpPPMsU9s21z5+/1dvhRGrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/puTlna/IISIVNthUcXZVlPUk1iOF1UMUddWuFDTr8=;
 b=dn6XZFOrWpNL6rmKfOxjG0EImx3/ypTX+CHK4tZJh0h6qc8cfFyCTKNMj4EpACLUZypLKcmjgySxZcJ8A0dzzcMtDhq25m87bdhUi31nU4X/oAV9PewsIyjf0YqhLCvi3O6L78mtvf2OMCHo4bwmqxPEtJH/xUeVbtKI9WAhFRJqf1LcyRdo25iuI1jFooa+3sazFgdqJl0i/i/hP/pyTeiKhN5nhyf+Q31DZUNs89lVGs17YRGEoIjd2x7LbZWaT0ky5sXH5D18TYmU8QDDed67baTIfAFjjclLy+SqLciQwNXzf90uHg5C0W2sEh6yQwf71DoNv7TUNnRzg+WY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/puTlna/IISIVNthUcXZVlPUk1iOF1UMUddWuFDTr8=;
 b=qMQEX/mOqyU2lNi4SF7vqBurmFDrhp9ZqyrqfAiW5I4KxwywGK5PPcwBC+epwNnF4tyuHlqWcoZh6Eo3usEIfLre+SfxtqwCx9SuNYEmYvDvJTBUqnh4J6Nl7VDjw0cBOXC1XxU6HRWxEwLQh4H9SjRW7wg4qkw9J1G6p8nNuuZOv1NHGXHZzBV5nmpni9FxYJ6PqY0DKenrBzxsQYiunomQm2DbkSR0ZJerdOy8UJc6vlffWUDzwNEPUN6KFLoWkEF1B9iu0RJqnA8CJOCwLERf/4+o22/ageFGb+iJSaHAxdmr2MhjQFxZveIrJ9Pa+RJlfeXg53rZpMhmPNI3dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV2PR04MB11192.eurprd04.prod.outlook.com (2603:10a6:150:279::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 09:14:45 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 09:14:45 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 10 Mar 2026 15:53:41 +0800
Subject: [PATCH v1 07/10] imx91: dtsi: Add wdog3/wdog4/wdog5 alias and
 bootph-all property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-wdog-v1-7-2ee21e890634@nxp.com>
References: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
In-Reply-To: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Joseph Guo <qijian.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Jacky Bai <ping.bai@nxp.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Primoz Fiser <primoz.fiser@norik.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Mathieu Othacehe <m.othacehe@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Jindong Yue <jindong.yue@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR02CA0071.apcprd02.prod.outlook.com
 (2603:1096:4:54::35) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV2PR04MB11192:EE_
X-MS-Office365-Filtering-Correlation-Id: 51cd251a-f30e-4755-979c-08de7e857841
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 0xIZcA3QJh0hnrv4FWtOeseLjd76BOF/4Zhls0jtdNDlfctzqD5gvF4fjJORarbBkb4DbGZ5DuPaLsIbZ/5qn2TOFY6wSLb+VKuYYa/WdcKJ/CuhBxxSRoicWwaIW2rYj3K+gFiNIECDTeRXDew+vM+VZ1VUiqPy50d0VWuAGfk8apXq1W0N4GtdmZV3jspDN/MJlv0ivQ2fm9PRu4i4W48AwEnVy7fewEQp+5XjSn6ItG+Nw7ChsdAWxiPFCKMbe4onezYsO+0C1rJ3NQe9W/c6M8NR3idTvCyn+JneURSA7nT0921kxr/nDymeStlmvRV7qrokpQg1MTTg2491Y2y5kEJyOU5ITq7YEOwxOCn/z+p5QUWV6dlrCv2LYnQ5FrxfJXGBkIl9cR/z14S+8c3gVsNw3FQtz/Rh04KNWIMIrdHe1oqloj4wavUVtvTVDWebrZLIQBCYUoRHT6OxNm95zc3Rb3X25MuGa2mQ16nYzMQGepHuADR1RZHoU/U7N5Dt44Sao3yGPjV+Z2pAMLcGokukDOAQCLtz1eNWs4kg15IXNVeVZDDPuxYlbQS23H0xN7YaQs9pnqqHhkqXIm+IUAIZ7unVBWbZZrapcy5c94Iu0+L1hiaGnQfxChJduhlHutl8AoJFk5fVXVKnj/+7T0DD/f5uxZzrYWKOf9ev3TJUQ4wJ59t+rapctwhU1AHt8dCHsYLyZ1NUIwBBI5OyM1k2McDVGAYu2FZvqIgkByEjkj7H1W2cV/B+2WiSBNefK+625EOKZ7eYKO2WZz71xHFzoJx74wzwSomE0pc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUlwRnpZM3g1dGZoenNxK0dTdjZ4MTFkTGYvQ2xaUzEveG9qN2VEZTFEbkll?=
 =?utf-8?B?eEY0RWk1RXRRZjlsNHYzVGdHNDB1OXNsSm5UNmJMUGlKZnAwZk5uWGlrSlo0?=
 =?utf-8?B?YzRVZWkzVlUyV3ZlR2tIOWFlM0RodVpURkRDTU1UK1NQMDlidklmcUNsaWdN?=
 =?utf-8?B?UDJrSWdmbmVOeVRaWU4rMTJ0SEJmOVh5RXhxS0pGRHpkWnJOdHRoWGs5Q21O?=
 =?utf-8?B?b05JWWMyYnNYVGVVR1FsUjVYZGRva1ZwWkxJNGVLa3UyMUpmRUlFcEJQREY2?=
 =?utf-8?B?NHNJblFiczZKSWVjN3dJTHlxZjArb1ZOVjgydTlreUtuTlNVZWJYUXNXcTBB?=
 =?utf-8?B?R1dIclI5dGtrYWdJVHRhRGFHTXBuUExKamRsMHpyRDkxV1dMNHdtZlQ0OEN3?=
 =?utf-8?B?RTYxbG9KM0xnOTFtNWtXRkEra0FTVG51anIrajVvNTVCUzA0c040Wko1UVY2?=
 =?utf-8?B?dzlPSkJOQzFMUW0zM3UzMHQwcUhFUGk5b0V1WGtjZC9pYjdqYzRReDIwc2R4?=
 =?utf-8?B?QlJ5ZHVRTTV4bGlucWlxRjFnWENkZCthWlFwSk10WEJuckVjYml3UEZ2cnY5?=
 =?utf-8?B?WkVrdzllOHVSYTV5aE9kRTlmK0FtQXV6R0ZQdHg3NmxtMzZZaGtsUy9kVkZo?=
 =?utf-8?B?bTA0QzdnQmpYQUh5SGE4aThnUGVKNnhJbklPeHJqV0ZyZGFiM09qSVdlL3NK?=
 =?utf-8?B?M3E1OXh1cW96Z3MzOVBXZHg4aU9xVERoUVBQb3VCNzNlUUxZZzhzd0pFcUpy?=
 =?utf-8?B?ZzA3Ly9TVVp1b2c3VjJNaEZzZzcyclpZdUNPZ09zQXRQK0ttckhsbUdEUkVw?=
 =?utf-8?B?K1JPQTFEcmkyaHdpN3hjc3MzckxKYlkwejh1V0JlRlFTY0NDT1dtS3JhSS9z?=
 =?utf-8?B?bVVuVDRoZHUwSWwxazFXUVpZTC9pZkVvR3RtcHdDZ0VYZGpTU0puTW1hNmZX?=
 =?utf-8?B?ZjBBM1pwQnRjRjJOUWRLVEZLVUlySWVuUWwxRER1bDZCbjNMUlVQcHlIL2tJ?=
 =?utf-8?B?VE9MYWhrMUo0VWM3Y3BPRjYwZTVXYXAvSFpWYWpmWGVQODdueEpqek5ZYXgv?=
 =?utf-8?B?UFpQc2F0VDZ2NTFJT2lQZVkvM3JOY2xod21iV0xKZlExODQ1RlVYV3N0NEZ5?=
 =?utf-8?B?VzYzRTZlam5sRGVVOHdsZUhJYVBxdFpRRFd5WXR0M0RodittOFBRbGZ6UjVy?=
 =?utf-8?B?ekEzWnQrZERMT0hxNG5pUGJFQTd5d1hHQUM3K3NxWjFHcHFWOUpzVjhpeUo2?=
 =?utf-8?B?RG4xQWhxOHFsWkRVeDJaemJUYk9YUEFjbi9XdzFiVE9Tcmp2TFZHbnZzQVRT?=
 =?utf-8?B?b2VkcHU3OVAvc0NsQlVua1UranZTMU9yM2I2U1o1MnJuQitIYnZ4REhscEVs?=
 =?utf-8?B?WWNvZnRMY2gwZTdYdmdHUU8zNXBIWmorbjJZQ1l1TzhHWkxEZ2dlUThLWUY1?=
 =?utf-8?B?bzNHYnJjOE9NcVF3RE5PRElTRVN2OW9IaDhUTlY1K3JETGdsS1FUcXg1Sy83?=
 =?utf-8?B?dzdwOVN2RFJWdStXV2VtcWJEWjhjRUgvZ3dEdG1rWWVZU2lHYktZUTlManhk?=
 =?utf-8?B?UFpGbnJ0RG5QRWNqZ0lEUXZ3VGpQdkhFZVFoZGEvZUF3UmpiRWYxSTNiWWhk?=
 =?utf-8?B?NmxtdFp6aDE3dHduQVpYaVkzVXNkMHBaUnNOb0JKVmtnVWZIWmZpeFpiQ0Q2?=
 =?utf-8?B?aVMxR1NDVTQ3TjhubnZDODNhbi9aSUV2SUcwZUlMQ0tjN3JuekZCVjVRQTdv?=
 =?utf-8?B?ejBwSEI4RHVlZkFnSkZsR2xpa2l5K0dJRUFUZjF5Y0Foa1dCWGZOWGVwR3ZZ?=
 =?utf-8?B?NEJ4NU9iNzZ4K2lCY3JDWHdRWTNHRUhUQUFKM01rbFk4ZmRmN3ZzMURvSW5U?=
 =?utf-8?B?bGxJc0F6aUtaaFVPKzZEWjJvSTYyOXB2YnhKWGFOOXpBVmVVajJvWjB5aE5U?=
 =?utf-8?B?a3RZbW9KZ28ybUl6OVFLUFFtYzdtcSt2ekZSV2YxcUUvb01nVFFUNU5xeGJ0?=
 =?utf-8?B?SFpDSkgyVVJ3Q3pYZElLUFNKWGsycEFXM3J2M1ZWbXp0YTRGbjU1MWxpUEsr?=
 =?utf-8?B?MTJrMkp3Z1AyQ3EyYmZCUlB1VWhmU1UyUzFZYnBqamVSM1pmMUJNTlpZSFZx?=
 =?utf-8?B?VHgxekZpbDg0QkFmSEtQekhMQzh3UGpia1RmM0FtVzR2cUZ0ZUMwN2o5TlJX?=
 =?utf-8?B?TVdNcGRzSTJhdzlBWENENGQ0ZmVFNjJqSzNTRE40djJ6cFEyMEpoNXFlQ21t?=
 =?utf-8?B?bWJiNUVESlBoTjJGc1o1a1dTODg1SzJBbm5JZmtUbmcyMXozemFNQ01OZzh1?=
 =?utf-8?B?Y2FlNmxzWTkzS2dtMGpQbUdQeGNVbVYyQ1ZDN3B1WnU0VmtUTWhVQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cd251a-f30e-4755-979c-08de7e857841
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:14:44.9071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29E4A2qcWiWDR9S5XLJTHb0ivWgn5rOSHgW3TP0XOH4g2Zbm6j2pn/qyieVDbN0jGyEAOJbr+Ifbo7UXOGhh1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11192
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:11 +0100
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

From: Alice Guo <alice.guo@nxp.com>

Add wdog3/wdog4/wdog5 alias and mark it with bootph-all to allow the
watchdog base address to be retrieved via imx_wdog_alias_to_addr().

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx91-u-boot.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/dts/imx91-u-boot.dtsi b/arch/arm/dts/imx91-u-boot.dtsi
index 5b639c965d6..c3df0e9e4fb 100644
--- a/arch/arm/dts/imx91-u-boot.dtsi
+++ b/arch/arm/dts/imx91-u-boot.dtsi
@@ -4,6 +4,12 @@
  */
 
 / {
+	aliases {
+		wdog3 = &wdog3;
+		wdog4 = &wdog4;
+		wdog5 = &wdog5;
+	};
+
 	binman: binman {
 		multiple-images;
 	};
@@ -90,3 +96,15 @@
 		};
 	};
 };
+
+&wdog3 {
+	bootph-all;
+};
+
+&wdog4 {
+	bootph-all;
+};
+
+&wdog5 {
+	bootph-all;
+};

-- 
2.43.0

