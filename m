Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7FEC4706C
	for <u-boot@archiver.kernel.org>; Sat, 13 Jan 2024 16:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FEC787930;
	Sat, 13 Jan 2024 17:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="YzxRvqFz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEE2A8795E; Sat, 13 Jan 2024 17:37:17 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E757187883
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 17:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+9f9sZTJnaK+TZLfe456BC07c2llVWADR+1hhZzGxduPekdMV52TEWiP8RZRWc9C2K2DrfuVCcCIabwFRyUbBTVWu7Ct3YZFmLKcvkfRTwvY6zP2F5q9IKZZmzMX6vXwzqjozsc/psFs5DbPp8Ixoe45jBpsoZS3Qe8Eut+iVRjwOEXoHhgvlvpwZpm3Cef6mx2eAnv+tYxRfAKYNKfv+SFQILzI/fHXs1bRfXeQ/jsCBT4IBD0tZsdX6IFyQxs0IelldTpLMPViBagjNS++60H89g7VBIGXXj8YdnxR5zfiaw9+MTOMKrY794nwRsgT9Z2peMkE1s3ciAJkV1zpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZwN3kPi3qR5N7WheKRXqeYxC2J82C8zGyvtO4tHnLM=;
 b=YhX5M3yMjONqdceLnxTuobwSSdr97A8kj5tnjW78zRu4wlCx/TdDBojaSwFEQuJ8HT3sDdNMORpqyGQogm8shWPhBtET56HOItM+Sciz5ua6B4MpimIttvkUwnF8QXCOZT7uF/7RNz7Rbs/LNH7i4+69H9Oy2xi2G89ol/3dv++obDbcOCE2OkOLv9tX+QxsDVDSbrztyVD0JtPz4Pv9vB33Eur61FgaJtuyfA1GBDY1cruP4ljHCnma6gddsZ8dK2FbbA/QcirCLYMNF6uAgd4U/AHa4tBUVQMNU3LvPHTLyz/zGg2QojI0lWtACu7Qw7D6viDWhm2PSq5L9e9RFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZwN3kPi3qR5N7WheKRXqeYxC2J82C8zGyvtO4tHnLM=;
 b=YzxRvqFzPoqOe1mRTYGqBN1E85IUmAbPiV17tldoV9nCfe+732z84maMOYlSd1iYraoBjQ/xb0yNhJZPHo/WoOeTUFdfVQ6iQeTUAXzhqsqBvY2F/Gi3yNXjkdEkKwPUvFQ0KjF0LRbU9p7zuxvAJHjb4YoLDTCHY+jIYi3SevY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PA4PR04MB7567.eurprd04.prod.outlook.com (2603:10a6:102:e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Sat, 13 Jan
 2024 16:37:14 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Sat, 13 Jan 2024
 16:37:14 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 13 Jan 2024 17:36:55 +0100
Subject: [PATCH 1/3] arm: dts: armada-38x-solidrun-microsom: configure i2c0 bus
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240113-helios4-spi-v1-1-2a5663a10e6a@solid-run.com>
References: <20240113-helios4-spi-v1-0-2a5663a10e6a@solid-run.com>
In-Reply-To: <20240113-helios4-spi-v1-0-2a5663a10e6a@solid-run.com>
To: Dennis Gilmore <dgilmore@redhat.com>
Cc: u-boot@lists.denx.de, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::10) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|PA4PR04MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: b923d02a-d576-490f-0ba9-08dc1455e56a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n0lsH0UjQlfTb0I0R6hZacZ3jIZca+DBdsUlafjrHhNJIEF9nDg5mOr7CffzoC4KAIzHK8AvYn5os51KJcmxzIfncwqiVkrG+sOldyOvcE9RKCO0104SVJRj/xSfvSZ9hJIj3pBU339mrAzB9kWz3PrAuQkEL45BILfkB1pJ6FvvP1dfNNB2CM19kQ0IT8sgAQNojRT2egvlINyU6Mo3c1PR1EtIleQupV9dk6+eIKXr3Rx58hv0vhNzDXvV7PD+u7OAEzBPxqBGX6Ps8GV/BhZwK/zs25X9sg43jS3xSz/KQUHRRakhQAU5eQ5EhtaCA/sg5fPmZzoEuFKr9+cKjcbFtk7yegsJD2efZQ5XmmdJuh7hSvFyOI0U73SlqSkGXEcp1K/A0m/YWnGEosGxbTk5bYsdy2zaYTPTyKaCq57IkW6/wBeHS7SUxXLN2K5W6qQMJP5thzQ8LhYRfZ3jk87bE2cVyQq7+NBNu7dzJlpSNUiERRaqiZWcVOTLPWW/KI8ocore/KGvV99eXdqRRxcfJKLcIpTqva6Y4eZ8tV0XbtCRL49jzlqqUaNUcEEmlrOR24H0yTDarkHrWlMT1vL/ztrQ+qlioUQeF9dGYiD/GhZp0cI9vBUx4ubi2Qia
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39830400003)(366004)(376002)(396003)(136003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4744005)(2906002)(5660300002)(52116002)(4326008)(8676002)(8936002)(66476007)(6916009)(316002)(6512007)(41300700001)(38100700002)(6506007)(6486002)(66556008)(66946007)(6666004)(2616005)(36756003)(86362001)(83380400001)(107886003)(26005)(478600001)(38350700005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW8xVFNVdGt5UWZJSHM4WkJqOEJENk02dkV4Z1dOQnprU3lVWGhISllwMmdl?=
 =?utf-8?B?dVFxZDFQZlNnYmtVMmluejV5RVowN1ovUUZrUzNJYUc0T2FmTE00czZUUjdI?=
 =?utf-8?B?YzUzekpESDJQVTVrbTBzRHhKelBzR3RPYmI5YitXMTFyNmd1MTA2QjZLMXUy?=
 =?utf-8?B?bGsyWjJGOWg0MzhUYkpFL0FXYUdOeFVtOHdqK2lUeEFrOGxPU2UxMWEvYnN3?=
 =?utf-8?B?OHJzMUtCYmg3Q3JQMFllTzlORFk5ekdvT1hEUENtQlJZcGVIeFExbkxRc0Jz?=
 =?utf-8?B?UWhaQURycTdrUUhMeHFqRDZiZUpldG9FWFgxeUM2cU1GMXBUMjFnTjFRUlVh?=
 =?utf-8?B?UVZnRFlSdDI0SzVsMWNJRzAzS21JZXMyWHBwYXdHYWxyUlViRUdnS1NlNlQz?=
 =?utf-8?B?UTE5VUJXZnpRSkhZMEszSlhrakxodlczdVZUTFVzUG1vTXhPdVVrVnpyYnFF?=
 =?utf-8?B?WVlkZnJNbXp5UlV0NUtKeEhnVnRTbnNKa1c0ZERRV0FFeVJPWGIxdjlqTWRL?=
 =?utf-8?B?SDMxSTdwTlkxZW5xVGQyOHV4ajgzU3BLdEd6WlNueGoyZXVLeVFUeE1oWlFq?=
 =?utf-8?B?ZnRIOXZPNVlycW41dXcxRDhHMVFEZURiVzRpeHJ4Y2hYRHE2WDBpdFRvcG9X?=
 =?utf-8?B?OVZ0dENaeHVxMW5tcjlWNHNRa1l0cEpLUjhFRUdJdG54N3YvTHJGemtGRGJq?=
 =?utf-8?B?YkR3S1J0SlRJMTVaVkZYeFQ1QzBKQlgyYmRrdDdTYUgvWXMvTHQ3V0RSVUNo?=
 =?utf-8?B?eTB6bVZSK20vYVdXMmFGZ09TdEVBUU8wem0raGVQREt6SWdwZzNRVHRyRVV4?=
 =?utf-8?B?a0phNXRBZGN5c1ova0ZSUnc2b0RZQkZQQm4vSE1uek1waGRUS0QxNm4wZUpp?=
 =?utf-8?B?RjRibWpGYWFTeGpldFRVWnVzNVhIbHpVTjhadTN4MDNScy9WU3h2aEJuYk92?=
 =?utf-8?B?aGZCL1ovZjkvNlVJRFljUklBUUZYT1ZhQ0xBZjIzVGkzUTdwaDcvOFVjY2po?=
 =?utf-8?B?Tm1FRFByRmRlR3Vpd1BJVkxYQ0hNRzFqcGMrd1BidFkvZE5EMlN5dnRGeDM4?=
 =?utf-8?B?NC9MWGt3YVM1K2NpNytjaFZQYm5OQmNGdTdsWWVjamxEaDR2ZzdaTVpGRm5u?=
 =?utf-8?B?TitUWjVtaUhoRnUwbDdhVGFYWkxpVE41ZFVZNXA5MjZWbzEyRE1oL2lYaGYr?=
 =?utf-8?B?TnJhNHlrOTBETGdIYUNLcTIyemNGTXR5d09qQVNIY3RqaEpoK3F2RGZWVloy?=
 =?utf-8?B?QlZZY0ZhZ3lCaERMeVE5SitkMkVicnh0UlBoSjdrV2s4b0FCNG1uWUVYcFBS?=
 =?utf-8?B?N0dJRC9BOFNKTy9yWE9wUTFUWTNReEs0dDVKK1JNckpsUmhwSVROUGlnc2VC?=
 =?utf-8?B?bU5FVEpaS01td0t3dUhMdkxIbTBuQnZTY0RUczJMNjlYQk5xRWp0eDFJb1FG?=
 =?utf-8?B?cHpNWlNaamRDUGZpUHlHay9MZ1k0d0xSckE3MWp0WDE3Y0ZWdmVWelk5QVJ1?=
 =?utf-8?B?eWFnRVR3WW9pY2JmdWU4TVFtUkZQaWxLNzhFZDZFaXdaemhCRE8wT1FzaHN4?=
 =?utf-8?B?VEFLRHArWmIrL05OeFNLcng5SDhsbVdxRVJjL2tSb2pQamN6dmp2NFowL3po?=
 =?utf-8?B?NHhIQ1hFRXhreW5MMUtYYlo5ampUVytzNXVDK1VISGk1RlNIeHloMmxnTWpM?=
 =?utf-8?B?QzhZdFhVMzFtTWJUVGRDbUdjUWh0U3pEMERNOW5EVGxYT2xrZ0RzWVVsTkZn?=
 =?utf-8?B?dndaM2dLTWcxQ0dla3ZiZXozNWhHMzBNVEREcGxjRmx6Vis1MU1FR2FqM3Ir?=
 =?utf-8?B?T0FTZTFsbUtGWHBkTldWbU10L2hWTTJKK3VXU2owNnRaYzlZRFZoN0FtNkUy?=
 =?utf-8?B?Z3hDaXd3SU02Uk5Pa1dWZlB0aWFYYVBNT1ViOGRSRm9uUWZRYStYZmx3VzYy?=
 =?utf-8?B?YVBDTFNCQjJLb3V2TTd0S1NpRnFGQkJCd3pIeWpQMWY3c0ljM3JtU0VJcnB1?=
 =?utf-8?B?L0t3a21pbU8xeDZ6VTZVK3lBZXcyMVFYcXFTVVgxSzE5Um1rakc1b0lnUExq?=
 =?utf-8?B?UVl0T3pUc3JncFBjTUZ2RTNXUmIrazVzaEQ5aTYyZysrUlIyWUh5REF5cEYv?=
 =?utf-8?Q?8NM2+wusf6weFNYWP+T1Gi4th?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b923d02a-d576-490f-0ba9-08dc1455e56a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2024 16:37:13.4696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBZBxV9u34AnU+spR//01S20Nwi8LEaxpQbNY/+6KzPx5YNeAatQr9nXfVV3/9n+7rgiSuk241swakdH2woHPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7567
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

SolidRun Armada-388 SoM has an i2c bus supporting on-som eeprom, and
peripherals on a carrier.
armada-38x.dtsi disables this bus by default, it should be enabled by
som or carrier dts.

Linux has moved i2c0 from helios-4 board dts to som dtsi, including
status, pinctrl and clock speed.
Copy these settings from mainline.

This fixes accessing i2c bus from u-boot commandline.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm/dts/armada-38x-solidrun-microsom.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/armada-38x-solidrun-microsom.dtsi b/arch/arm/dts/armada-38x-solidrun-microsom.dtsi
index f6ae784bed..1540162e03 100644
--- a/arch/arm/dts/armada-38x-solidrun-microsom.dtsi
+++ b/arch/arm/dts/armada-38x-solidrun-microsom.dtsi
@@ -99,6 +99,11 @@
 };
 
 &i2c0 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
 	eeprom@53 {
 		compatible = "atmel,24c02";
 		reg = <0x53>;

-- 
2.35.3

