Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CF6D3EE6A
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 14:09:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3FB183AC5;
	Thu, 22 Jan 2026 15:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SZ4AZIiA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C8A983A6A; Thu, 22 Jan 2026 15:09:17 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2ABE839DF
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 15:09:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ochKgkDba1Khvf1NAICa+uMcdzp14YHehGDwut+lfopXad0m4EoxkNcxuzjJLKymkS56hrvz20Ii/CbwpCq65EmnTcTWzlTM/83VCTDapmM5noHRqZLegeG+yS5/4I7MCI71oA1X1dOnalfJY9QNQUti7i65S779SRtNhRcjOnx7zAeaKT6TdidjN62mZ91l5CVxjB2t+klyLAmy9f9YBs2XUef1/mOhwrsqm+b7RTXyCFAbGGrNFV1GtjqRB8KfANgXG1eEBHPdyLniwmcIr4U9AHok976ipRM23voPXuzUV6PP+j+KWERgnOfh35FrA1/gHFfNwHVldwP2ul8lAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=os73NGI746C0KwC3gq63W4OqnOA8QTNMzAc1/a4ydWo=;
 b=Le7xDkXtUFE0uSSb95uIrtP24DXLR5OKZI3U32PYAhsPu9I90Wb4MEUeHXmDAkmC9VhZb/2b8iVjAlvgcS8567/rkWrpoZLIagX0e98a6plCghbg/Ue4t2LpSrBb62z1c4YtP62mOJhP96/91HgvYvpCCICwfoPX6I2uOG1vvaqp8i+tzh6s1Fc6Tf6HdcGrKAXTlrffuziNjYiHplTbWo50OidL2n9/FN+m6JD7yBY8D5hlz+mke8YPaWtc4kFqp4sSw5yvL23AHjbPKlo/UCbnxHcoZ8L/PTgiektTnI+j7+IETeOHX1vrUhhi2ERphfL7pmOXMF+CodlLBwCMIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=os73NGI746C0KwC3gq63W4OqnOA8QTNMzAc1/a4ydWo=;
 b=SZ4AZIiAmslIRhMNSmEuPAoiWTyLDmkuFNTK2vvHmsSZLCMAfOL4LtmEdLXYTTjnLCEGPBEHRiZorYfhFzTfAeffc0l1POmQ8Qrt/H7JMu4yr4w3AnP71tqS6SkpWKToLgosDcJYJeQf5/BFf7F2sRUcbzupHzSagGIgSanHT8Y=
Received: from PH5P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::12)
 by SA6PR10MB8109.namprd10.prod.outlook.com (2603:10b6:806:436::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 14:09:06 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::7f) by PH5P220CA0007.outlook.office365.com
 (2603:10b6:510:34a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 14:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 14:09:05 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 08:09:05 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 08:09:04 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 22 Jan 2026 08:09:04 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60ME92Ux665669;
 Thu, 22 Jan 2026 08:09:03 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 22 Jan 2026 19:38:38 +0530
Subject: [PATCH master] arch: arm: dts: k3: refactor common nodes to
 k3-*-r5.dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260122-r5_dt_refactor-v1-1-5442a4321756@ti.com>
X-B4-Tracking: v=1; b=H4sIAGUvcmkC/x2MWwqAIBAArxL7nZDWFnWVCJHcaj96sEoE0t2TP
 odhJkEgYQowFAmEbg58Hhl0WcC8uWMlxT4zmMq0lTZGCVofrdDi5niKarDGBXXXYV9Djq5s+Pm
 HI+wuRBKY3vcDDeCTTWgAAAA=
X-Change-ID: 20260122-r5_dt_refactor-4535f5177593
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>, "Francesco
 Dolcini" <francesco.dolcini@toradex.com>, Garrett Giordano
 <ggiordano@phytec.com>, Anshul Dalal <anshuld@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Vitor Soares <vitor.soares@toradex.com>, Parth Pancholi
 <parth.pancholi@toradex.com>, Andrew Davis <afd@ti.com>, Gowtham Tammana
 <g-tammana@ti.com>, Vignesh R <vigneshr@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769090942; l=68776;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=ukWkOMRC2Uh0w+CLesd5ld5vrZPk9VafVMeOXwOKGmE=;
 b=RvlAvNS7HAa+dDrxwJWa35aTDherNyxaY34Iu1sU6NBE5Mvjoekl3wdizf1rGsorqu6IriuAQ
 v0M7qgpq7w3CpTG3IykDXtLs3XpC/bC3BSQJA7SktvxyNcpz1IOZ6tL
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SA6PR10MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: 1019bc42-209e-454f-7db4-08de59bfcdb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXRHOW9tZFltdWtIVFhyVkVaTm96K1lESlNkVFo1U2ZTeVYvQzl2bkFUN1Nr?=
 =?utf-8?B?cjRTa1dWRWdUQkhrM2dpdG1sY3RqOGozMU9nZ01BaXF6SEZwRE9ka1VuRnpI?=
 =?utf-8?B?cERVUFd3aDBJSWRrMkdKQzFkQXJ6Yy8rZWVmdzRCd0NIMHROWkczM2UwRVh0?=
 =?utf-8?B?YXljQ2hkdUkyc1NoOFY3MUZlRUJ4UnhubmZ4N1lTU2U0OG1jZ2tPS3pJc1Zv?=
 =?utf-8?B?YlFkTUIveHBrR0RYRGd6dXJwSi9ORVBVNUIwTDhVakZVYTB5c0JXaTJKWGdT?=
 =?utf-8?B?ZzNHc1hMeTdua1EvVnZFV0JmSVZ4d2N4UDVNSkVTZzJoeUtEMC9jenNQRmdV?=
 =?utf-8?B?N3VUMlhTNkd6enRYdjA2WmNlV0dHV2czY3RwcFUzd01oUU9hY21OaC9CUm4y?=
 =?utf-8?B?YVlNVEJBTHRuYi9xdC9xVkhsNGQ2MVFwV1Y3YmxZcU1kRXhqdzZkbG8wVUd2?=
 =?utf-8?B?SzRaRFFBR242SzBLb1cyN1NuOWdhdjBLVEo5Nk5wcVRwTWNCT0dodXB0VHAr?=
 =?utf-8?B?ZHBEektJalZFZUhIbldxUlI1UFlOTVBWYkRmRkpWdERBaWFOV3c2bklxaVJq?=
 =?utf-8?B?Ylh6d3pQYkdqamR4UW80NC9vRHVwaHh6S2ZLUlU4Z2E5aG1YWitTbk1LQWdL?=
 =?utf-8?B?OEo0WXdxQy9NMlhmajB6VGdsbmNxWW9ydGRYK1R2ZUJ5YXBXdXd0VzlEV2xJ?=
 =?utf-8?B?NXQvUERoZUIxcTJNNzVOeW13WFBNcFJYQWN3cm5FNnUrOW0vNURPUUpmaEdm?=
 =?utf-8?B?NTJsNmlQVmhmbndLbkpHa01OSk1wWW9aNS9HYXJ2TUNSWUUxdi9zT1hRazRx?=
 =?utf-8?B?M2Y5QnZPdDBUUjY1elF0eXZPQ2piNEtXY2xoQm90UVlDZnEzei94eWJGN3Zj?=
 =?utf-8?B?d21jeUVHUEpWYmxwRzJkdkNSN1lUQk1pZjh6Z3FwWWdqNE1ickcxMXVSTHA4?=
 =?utf-8?B?NU15NGNtemloWEs0K25PY0doZlh6TDcyQklSZTNNdlpVbmtaWkpHeWdtazdV?=
 =?utf-8?B?c0xXNkZXYTJ0VmJiSjIyUldBMDVlcnpKQTRoanMycjJkbEZnSDJpZTFzbnBR?=
 =?utf-8?B?RFdpeithN1RKSG03cHA0QUIwOTN0ZEo0YkIxV0x5OWdQZkVkTnpMVEJFVStu?=
 =?utf-8?B?aUZnTkxaZ1V3T2VlbmVIV1N3YmpuTkI2SmFFMFZiWVM5TkdIVzNib0t0anNX?=
 =?utf-8?B?OFYyN210UTRLa3dsdnhWSWF2Mlk4YlEyTHR3VllYUGZDeWk3MjRjMGFVd3Y4?=
 =?utf-8?B?MHQ5aEZKck1hTkN6MTg4Zmsrd0lmUEdwQWVDSnFaWXFNVkVqUWZjNU5PTFdQ?=
 =?utf-8?B?K2tyMlI0NFlQNnB2UXRVYk9TbnZoRlhuazlVdnZxZlpPYkk1QTdYRi9kNkZL?=
 =?utf-8?B?OHJoM2JoNWRkYUNqbTRMK1dVTTFCUktSeURUTExZQStSVnc0SmpNSmZCWjI1?=
 =?utf-8?B?QW5YTWdJU0FrdTF1Y1NLVFl4c1ZPZmNqbXd4V1QveWhuS3NtRmdRMm1lRXFn?=
 =?utf-8?B?MThVYWlQMXlkWXdhZ2M2MzluaDJueWZYOTUvTmk1VkV3MFB4dzJhekhWQURB?=
 =?utf-8?B?bkIrM1JJRVFjYXRadW9EZlNUU0tGN1pja0ZyaVF2RTl2WW12YWZwSlJrQVlS?=
 =?utf-8?B?OHBraDgrZUJPb1pxSVZ5ZEdpeVkzVzBQR2pYMXQ5VDFXVk1ablpYSjduTFh2?=
 =?utf-8?B?NlBreFF5cXdnTlk2dmpGQlFndTUvOUxuMm9IQUtYeUx2ZmVXK1Q5NTZnRkNS?=
 =?utf-8?B?TDNWRXJhbndaZUl3QlN0YjdmOXdyM2ZwbmZoYjdjdTJwWVN1dUV3Z0UwZjdt?=
 =?utf-8?B?MDFteENMVjBtTjUrKzNxdTRDcFlpcWRmZWV1OUJrNGJmVU5EK29Pd2t5ZTZO?=
 =?utf-8?B?TFh4RlpjbWlLenRhU2dCaStxSzhsNCtRb3NDQTUvWGlNRDM0ODRwWVRSendQ?=
 =?utf-8?B?RXh1NVYrazZlM3FpR3dHTWtVYnFxSFIxcUJHeHlmUFM2ME5KeWVCQnhjbFdy?=
 =?utf-8?B?NEUrSSt0YkFvOStPd1djSUJVenQzb2JJd045ZFhDMzNwTVFKZmhCUSsrZ0pR?=
 =?utf-8?B?N1RYS29qM0dkUEZwUW9mOVZPTUNIa0E5dWdSaFhYUkZpMG83UXJrZU16SDhn?=
 =?utf-8?B?aXdQREQ4VW5jK1FNcVhwNGgzY3lLUHJJcGd2K1ErWVpnOFlmbEROKzZLZVBG?=
 =?utf-8?B?dXc9PQ==?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 14:09:05.7251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1019bc42-209e-454f-7db4-08de59bfcdb9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8109
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

This patch refactors the nodes in each board's R5 device-tree to common
SoC level dtsi. No functional change is intended from this patch.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
I have verified the DT delta before and after the patch and there is
no difference except for the addition of "tick-timer" under /aliases and
"clock-names" under the a53/a72 cores on some platforms which should
cause no functional change. An exhaustive diff for all DTs is provided
below[1].

The following affected platforms have not been boot tested:
 - k3-am625-r5-beagleplay
 - k3-am67a-r5-beagley-ai
 - k3-am642-r5-phycore-som-2gb
 - k3-am625-r5-phycore-som-2gb
 - k3-am62a7-r5-phycore-som-2gb
 - k3-am625-verdin-r5
 - k3-am62p5-verdin-r5

Though I'm not sure if the patch should be split per SoC for ease of
review?

[1]:

  k3-am625-r5-beagleplay:
   --- build/before/spl/u-boot-spl.dtb
   +++ build/after/spl/u-boot-spl.dtb
   @@ -31,6 +31,7 @@
    		remoteproc0 = "/bus@f0000/sysctrler";
    		remoteproc1 = "/a53@0";
    		serial2 = "/bus@f0000/serial@2800000";
   +		tick-timer = "/bus@f0000/timer@2400000";
    		usb0 = "/bus@f0000/dwc3-usb@f900000/usb@31000000";
    	};

  k3-am625-r5-phycore-som-2gb:
   --- build/before/spl/u-boot-spl.dtb
   +++ build/after/spl/u-boot-spl.dtb
   @@ -10,6 +10,7 @@
    		assigned-clock-parents = <0x02 0x3d 0x02>;
    		assigned-clock-rates = <0xbebc200 0x47868c00>;
    		assigned-clocks = <0x02 0x3d 0x00 0x02 0x87 0x00>;
   +		clock-names = "gtc";
    		clocks = <0x02 0x3d 0x00>;
    		compatible = "ti,am654-rproc";
    		power-domains = <0x03 0x3d 0x01 0x03 0x87 0x01 0x03 0xa6 0x01>;
   @@ -31,6 +32,7 @@
    		serial2 = "/bus@f0000/serial@2800000";
    		serial3 = "/bus@f0000/serial@2810000";
    		spi0 = "/bus@f0000/bus@fc00000/spi@fc40000";
   +		tick-timer = "/bus@f0000/timer@2400000";
    		usb0 = "/bus@f0000/dwc3-usb@f900000/usb@31000000";
    	};

  k3-am625-verdin-r5:
   --- build/before/spl/u-boot-spl.dtb
   +++ build/after/spl/u-boot-spl.dtb
   @@ -10,6 +10,7 @@
    		assigned-clock-parents = <0x02 0x3d 0x02 0x00 0x02 0x9d 0x16>;
    		assigned-clock-rates = <0xbebc200 0x2faf0800 0x17d7840>;
    		assigned-clocks = <0x02 0x3d 0x00 0x02 0x87 0x00 0x02 0x9d 0x14>;
   +		clock-names = "gtc", "core";
    		clocks = <0x02 0x3d 0x00>;
    		compatible = "ti,am654-rproc";
    		power-domains = <0x03 0x3d 0x01 0x03 0x87 0x01 0x03 0xa6 0x01>;
   @@ -29,6 +30,7 @@
    		serial0 = "/bus@f0000/serial@2810000";
    		serial1 = "/bus@f0000/bus@b00000/target-module@2b300050/serial@0";
    		serial2 = "/bus@f0000/serial@2800000";
   +		tick-timer = "/bus@f0000/timer@2400000";
    		usb0 = "/bus@f0000/dwc3-usb@f900000/usb@31000000";
    	};

  k3-am62a7-r5-phycore-som-2gb:
   --- build/before/spl/u-boot-spl.dtb
   +++ build/after/spl/u-boot-spl.dtb
   @@ -10,6 +10,7 @@
    		assigned-clock-parents = <0x02 0x3d 0x02>;
    		assigned-clock-rates = <0xbebc200 0x47868c00>;
    		assigned-clocks = <0x02 0x3d 0x00 0x02 0x87 0x00>;
   +		clock-names = "gtc";
    		clocks = <0x02 0x3d 0x00>;
    		compatible = "ti,am654-rproc";

power-domains = <0x03 0x3d 0x01 0x03 0x87 0x01 0x03 0k3-am642-r5-phycore-som-2gbxa6 0x01>;:
   --- build/before/spl/u-boot-spl.dtb
   +++ build/after/spl/u-boot-spl.dtb
   @@ -10,6 +10,7 @@
    		assigned-clock-parents = <0x02 0x3d 0x02>;
    		assigned-clock-rates = <0xbebc200 0x3b9aca00>;
    		assigned-clocks = <0x02 0x3d 0x00 0x02 0x87 0x00>;
   +		clock-names = "gtc";
    		clocks = <0x02 0x3d 0x00>;
    		compatible = "ti,am654-rproc";
    		power-domains = <0x03 0x3d 0x01 0x03 0x87 0x01 0x03 0x89 0x01>;
---
 arch/arm/dts/k3-am62-r5-lp-sk.dts              | 82 +-----------------------
 arch/arm/dts/k3-am625-r5-beagleplay.dts        | 72 +++------------------
 arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts   | 76 ++--------------------
 arch/arm/dts/k3-am625-r5-sk.dts                | 86 +------------------------
 arch/arm/dts/k3-am625-r5.dtsi                  | 88 ++++++++++++++++++++++++++
 arch/arm/dts/k3-am625-verdin-r5.dts            | 81 ++++++------------------
 arch/arm/dts/k3-am6254atl-r5-sk.dts            | 86 +------------------------
 arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts  | 58 ++---------------
 arch/arm/dts/k3-am62a7-r5-sk.dts               | 60 +-----------------
 arch/arm/dts/k3-am62a7-r5.dtsi                 | 69 ++++++++++++++++++++
 arch/arm/dts/k3-am62d2-r5-evm.dts              | 72 +--------------------
 arch/arm/dts/k3-am62d2-r5.dtsi                 | 75 ++++++++++++++++++++++
 arch/arm/dts/k3-am62p5-r5-sk.dts               | 69 +-------------------
 arch/arm/dts/k3-am62p5-r5.dtsi                 | 77 ++++++++++++++++++++++
 arch/arm/dts/k3-am62p5-verdin-r5.dts           | 76 ++--------------------
 arch/arm/dts/k3-am642-r5-evm.dts               | 81 +-----------------------
 arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts   | 76 ++--------------------
 arch/arm/dts/k3-am642-r5-sk.dts                | 81 +-----------------------
 arch/arm/dts/k3-am642-r5.dtsi                  | 84 ++++++++++++++++++++++++
 arch/arm/dts/k3-am654-r5-base-board.dts        | 74 +---------------------
 arch/arm/dts/k3-am654-r5.dtsi                  | 77 ++++++++++++++++++++++
 arch/arm/dts/k3-am67a-r5-beagley-ai.dts        | 67 +-------------------
 arch/arm/dts/k3-am67a-r5.dtsi                  | 70 ++++++++++++++++++++
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 82 +-----------------------
 arch/arm/dts/k3-j7200-r5.dtsi                  | 86 +++++++++++++++++++++++++
 arch/arm/dts/k3-j722s-r5-evm.dts               | 81 +-----------------------
 arch/arm/dts/k3-j722s-r5.dtsi                  | 84 ++++++++++++++++++++++++
 27 files changed, 768 insertions(+), 1302 deletions(-)

diff --git a/arch/arm/dts/k3-am62-r5-lp-sk.dts b/arch/arm/dts/k3-am62-r5-lp-sk.dts
index 95cd9b707c7..2d89c204981 100644
--- a/arch/arm/dts/k3-am62-r5-lp-sk.dts
+++ b/arch/arm/dts/k3-am62-r5-lp-sk.dts
@@ -9,84 +9,4 @@
 #include "k3-am62-ddr.dtsi"
 
 #include "k3-am62-lp-sk-u-boot.dtsi"
-
-/ {
-	aliases {
-		tick-timer = &main_timer0;
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a53_0;
-		serial0 = &wkup_uart0;
-		serial3 = &main_uart1;
-	};
-
-	a53_0: a53@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x00 0x00a90000 0x00 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		clock-names = "gtc", "core";
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		assigned-clock-parents = <&k3_clks 61 2>;
-		assigned-clock-rates = <200000000>, <1200000000>;
-		ti,sci = <&dmsc>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-pre-ram;
-	};
-
-	dm_tifs: dm-tifs {
-		compatible = "ti,j721e-dm-sci";
-		ti,host-id = <36>;
-		ti,secure-host;
-		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 22>,
-			<&secure_proxy_main 23>;
-		bootph-pre-ram;
-	};
-};
-
-&dmsc {
-	mboxes= <&secure_proxy_main 0>,
-		<&secure_proxy_main 1>,
-		<&secure_proxy_main 0>;
-	mbox-names = "rx", "tx", "notify";
-	ti,host-id = <35>;
-	ti,secure-host;
-};
-
-&secure_proxy_sa3 {
-	/* We require this for boot handshake */
-	status = "okay";
-};
-
-&cbass_main {
-	sysctrler: sysctrler {
-		compatible = "ti,am654-tisci-rproc-r5";
-		mboxes= <&secure_proxy_main 1>,
-			<&secure_proxy_main 0>,
-			<&secure_proxy_sa3 0>;
-		mbox-names = "tx", "rx", "boot_notify";
-		bootph-pre-ram;
-	};
-};
-
-&main_timer0 {
-	/delete-property/ clocks;
-	/delete-property/ clocks-names;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	clock-frequency = <25000000>;
-};
-
-/* WKUP UART0 is used for DM firmware logs */
-&wkup_uart0 {
-	status = "okay";
-};
-
-/* Main UART1 is used for TIFS firmware logs */
-&main_uart1 {
-	status = "okay";
-};
+#include "k3-am625-r5.dtsi"
diff --git a/arch/arm/dts/k3-am625-r5-beagleplay.dts b/arch/arm/dts/k3-am625-r5-beagleplay.dts
index bba69871fd2..fb0b83b83f1 100644
--- a/arch/arm/dts/k3-am625-r5-beagleplay.dts
+++ b/arch/arm/dts/k3-am625-r5-beagleplay.dts
@@ -11,70 +11,14 @@
 #include "k3-am62-ddr.dtsi"
 
 #include "k3-am625-beagleplay-u-boot.dtsi"
-
-/ {
-	aliases {
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a53_0;
-	};
-
-	a53_0: a53@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x00 0x00a90000 0x00 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		clock-names = "gtc", "core";
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		assigned-clock-parents = <&k3_clks 61 2>;
-		assigned-clock-rates = <200000000>, <1250000000>;
-		ti,sci = <&dmsc>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-pre-ram;
-	};
-
-	dm_tifs: dm-tifs {
-		compatible = "ti,j721e-dm-sci";
-		ti,host-id = <36>;
-		ti,secure-host;
-		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 22>,
-			<&secure_proxy_main 23>;
-		bootph-pre-ram;
-	};
-};
-
-&main_timer0 {
-	/delete-property/ clocks;
-	/delete-property/ clocks-names;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	clock-frequency = <25000000>;
-};
-
-&dmsc {
-	mboxes= <&secure_proxy_main 0>,
-		<&secure_proxy_main 1>,
-		<&secure_proxy_main 0>;
-	mbox-names = "rx", "tx", "notify";
-	ti,host-id = <35>;
-	ti,secure-host;
-};
-
-&secure_proxy_sa3 {
-	/* We require this for boot handshake */
-	status = "okay";
-};
-
-&cbass_main {
-	sysctrler: sysctrler {
-		compatible = "ti,am654-tisci-rproc-r5";
-		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
-		mbox-names = "tx", "rx", "boot_notify";
-		bootph-pre-ram;
-	};
+#include "k3-am625-r5.dtsi"
+
+&a53_0 {
+	power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
+			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>;
+	assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+	assigned-clock-parents = <&k3_clks 61 2>;
+	assigned-clock-rates = <200000000>, <1250000000>;
 };
 
 &main_pktdma {
diff --git a/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
index 0f2c592593e..46b621242b5 100644
--- a/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
+++ b/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
@@ -10,42 +10,9 @@
 #include "k3-am62-ddr.dtsi"
 
 #include "k3-am625-phyboard-lyra-rdk-u-boot.dtsi"
+#include "k3-am625-r5.dtsi"
 
 / {
-	aliases {
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a53_0;
-		serial0 = &wkup_uart0;
-		serial3 = &main_uart1;
-	};
-
-	a53_0: a53@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x00 0x00a90000 0x00 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>;
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		assigned-clock-parents = <&k3_clks 61 2>;
-		assigned-clock-rates = <200000000>, <1200000000>;
-		ti,sci = <&dmsc>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-pre-ram;
-	};
-
-	dm_tifs: dm-tifs {
-		compatible = "ti,j721e-dm-sci";
-		ti,host-id = <36>;
-		ti,secure-host;
-		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 22>,
-			<&secure_proxy_main 23>;
-		bootph-pre-ram;
-	};
-
 	memory@80000000 {
 		device_type = "memory";
 		/* 2G RAM */
@@ -54,42 +21,16 @@
 	};
 };
 
-&main_timer0 {
-	/delete-property/ clocks;
-	/delete-property/ clocks-names;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	clock-frequency = <25000000>;
-};
-
-&secure_proxy_sa3 {
-	/* We require this for boot handshake */
-	status = "okay";
+&a53_0 {
+	clock-names = "gtc";
+	clocks = <&k3_clks 61 0>;
 };
 
-&cbass_main {
-	sysctrler: sysctrler {
-		compatible = "ti,am654-tisci-rproc-r5";
-		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
-		mbox-names = "tx", "rx", "boot_notify";
-		bootph-pre-ram;
-	};
-};
-
-&dmsc {
-	mboxes= <&secure_proxy_main 0>,
-		<&secure_proxy_main 1>,
-		<&secure_proxy_main 0>;
-	mbox-names = "rx", "tx", "notify";
-	ti,host-id = <35>;
-	ti,secure-host;
-};
-
-&main_bcdma {
+&main_pktdma {
 	ti,sci = <&dm_tifs>;
 };
 
-&main_pktdma {
+&main_bcdma {
 	ti,sci = <&dm_tifs>;
 };
 
@@ -105,11 +46,6 @@
 	};
 };
 
-&ospi0 {
-	reg = <0x00 0x0fc40000 0x00 0x100>,
-	      <0x00 0x60000000 0x00 0x08000000>;
-};
-
 /* WKUP UART0 is used for DM firmware logs */
 &wkup_uart0 {
 	pinctrl-names = "default";
diff --git a/arch/arm/dts/k3-am625-r5-sk.dts b/arch/arm/dts/k3-am625-r5-sk.dts
index 67589f941ba..9dbcd36e002 100644
--- a/arch/arm/dts/k3-am625-r5-sk.dts
+++ b/arch/arm/dts/k3-am625-r5-sk.dts
@@ -9,92 +9,8 @@
 #include "k3-am62-ddr.dtsi"
 
 #include "k3-am625-sk-u-boot.dtsi"
-
-/ {
-	aliases {
-		tick-timer = &main_timer0;
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a53_0;
-		serial0 = &wkup_uart0;
-		serial3 = &main_uart1;
-	};
-
-	a53_0: a53@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x00 0x00a90000 0x00 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		clock-names = "gtc", "core";
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		assigned-clock-parents = <&k3_clks 61 2>;
-		assigned-clock-rates = <200000000>, <1200000000>;
-		ti,sci = <&dmsc>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-pre-ram;
-	};
-
-	dm_tifs: dm-tifs {
-		compatible = "ti,j721e-dm-sci";
-		ti,host-id = <36>;
-		ti,secure-host;
-		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 22>,
-			<&secure_proxy_main 23>;
-		bootph-pre-ram;
-	};
-};
-
-&dmsc {
-	mboxes= <&secure_proxy_main 0>,
-		<&secure_proxy_main 1>,
-		<&secure_proxy_main 0>;
-	mbox-names = "rx", "tx", "notify";
-	ti,host-id = <35>;
-	ti,secure-host;
-};
-
-&secure_proxy_sa3 {
-	/* We require this for boot handshake */
-	status = "okay";
-};
-
-&cbass_main {
-	sysctrler: sysctrler {
-		compatible = "ti,am654-tisci-rproc-r5";
-		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
-		mbox-names = "tx", "rx", "boot_notify";
-		bootph-pre-ram;
-	};
-};
-
-&main_timer0 {
-	/delete-property/ clocks;
-	/delete-property/ clocks-names;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	clock-frequency = <25000000>;
-};
-
-/* WKUP UART0 is used for DM firmware logs */
-&wkup_uart0 {
-	status = "okay";
-};
-
-/* Main UART1 is used for TIFS firmware logs */
-&main_uart1 {
-	status = "okay";
-};
-
-&ospi0 {
-	reg = <0x00 0x0fc40000 0x00 0x100>,
-	      <0x00 0x60000000 0x00 0x08000000>;
-};
+#include "k3-am625-r5.dtsi"
 
 &main_pktdma {
 	ti,sci = <&dm_tifs>;
-	bootph-all;
 };
diff --git a/arch/arm/dts/k3-am625-r5.dtsi b/arch/arm/dts/k3-am625-r5.dtsi
new file mode 100644
index 00000000000..c509857ac5d
--- /dev/null
+++ b/arch/arm/dts/k3-am625-r5.dtsi
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/ {
+	aliases {
+		tick-timer = &main_timer0;
+		remoteproc0 = &sysctrler;
+		remoteproc1 = &a53_0;
+		serial0 = &wkup_uart0;
+		serial3 = &main_uart1;
+	};
+
+	a53_0: a53@0 {
+		compatible = "ti,am654-rproc";
+		reg = <0x00 0x00a90000 0x00 0x10>;
+		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
+		resets = <&k3_reset 135 0>;
+		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		clock-names = "gtc", "core";
+		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		assigned-clock-parents = <&k3_clks 61 2>;
+		assigned-clock-rates = <200000000>, <1200000000>;
+		ti,sci = <&dmsc>;
+		ti,sci-proc-id = <32>;
+		ti,sci-host-id = <10>;
+		bootph-pre-ram;
+	};
+
+	dm_tifs: dm-tifs {
+		compatible = "ti,j721e-dm-sci";
+		ti,host-id = <36>;
+		ti,secure-host;
+		mbox-names = "rx", "tx";
+		mboxes= <&secure_proxy_main 22>,
+			<&secure_proxy_main 23>;
+		bootph-pre-ram;
+	};
+};
+
+&dmsc {
+	mboxes= <&secure_proxy_main 0>,
+		<&secure_proxy_main 1>,
+		<&secure_proxy_main 0>;
+	mbox-names = "rx", "tx", "notify";
+	ti,host-id = <35>;
+	ti,secure-host;
+};
+
+&secure_proxy_sa3 {
+	/* We require this for boot handshake */
+	status = "okay";
+};
+
+&cbass_main {
+	sysctrler: sysctrler {
+		compatible = "ti,am654-tisci-rproc-r5";
+		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
+		mbox-names = "tx", "rx", "boot_notify";
+		bootph-pre-ram;
+	};
+};
+
+&main_timer0 {
+	/delete-property/ clocks;
+	/delete-property/ clocks-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	clock-frequency = <25000000>;
+};
+
+/* WKUP UART0 is used for DM firmware logs */
+&wkup_uart0 {
+	status = "okay";
+};
+
+/* Main UART1 is used for TIFS firmware logs */
+&main_uart1 {
+	status = "okay";
+};
+
+&ospi0 {
+	reg = <0x00 0x0fc40000 0x00 0x100>,
+	      <0x00 0x60000000 0x00 0x08000000>;
+};
diff --git a/arch/arm/dts/k3-am625-verdin-r5.dts b/arch/arm/dts/k3-am625-verdin-r5.dts
index fb431c96337..dfd960aaf3c 100644
--- a/arch/arm/dts/k3-am625-verdin-r5.dts
+++ b/arch/arm/dts/k3-am625-verdin-r5.dts
@@ -9,75 +9,30 @@
 #include "k3-am62-ddr.dtsi"
 
 #include "k3-am625-verdin-wifi-dev-u-boot.dtsi"
+#include "k3-am625-r5.dtsi"
 
 / {
-	a53_0: a53@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x00 0x00a90000 0x00 0x10>;
-		/*
-		 * FIXME: Currently only the SPL running on the R5 has a clock
-		 * driver. As a workaround therefore move the assigned-clock
-		 * stuff required for our ETH_25MHz_CLK from the cpsw3g_mdio
-		 * node of the regular device tree to here (last one each in
-		 * below three lines, adding a <0> as spacing for parents).
-		 */
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>, <&k3_clks 157 20>;
-		assigned-clock-parents = <&k3_clks 61 2>, <0>, <&k3_clks 157 22>;
-		assigned-clock-rates = <200000000>, <800000000>, <25000000>;
-		clocks = <&k3_clks 61 0>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 135 0>;
-		ti,sci = <&dmsc>;
-		ti,sci-host-id = <10>;
-		ti,sci-proc-id = <32>;
-		bootph-pre-ram;
-	};
-
 	aliases {
+		serial0 = &main_uart1;
+		serial1 = &wkup_uart0;
+		serial2 = &main_uart0;
+		serial3 = &mcu_uart0;
+		serial4 = &main_uart5;
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
 	};
-
-	dm_tifs: dm-tifs {
-		compatible = "ti,j721e-dm-sci";
-		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 22>,
-			<&secure_proxy_main 23>;
-		ti,host-id = <36>;
-		ti,secure-host;
-		bootph-pre-ram;
-	};
-};
-
-&cbass_main {
-	sysctrler: sysctrler {
-		compatible = "ti,am654-tisci-rproc-r5";
-		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
-		mbox-names = "tx", "rx", "boot_notify";
-		bootph-pre-ram;
-	};
-};
-
-&dmsc {
-	mboxes= <&secure_proxy_main 0>,
-		<&secure_proxy_main 1>,
-		<&secure_proxy_main 0>;
-	mbox-names = "rx", "tx", "notify";
-	ti,host-id = <35>;
-	ti,secure-host;
-};
-
-&main_timer0 {
-	/delete-property/ clocks;
-	/delete-property/ clocks-names;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	clock-frequency = <25000000>;
 };
 
-&secure_proxy_sa3 {
-	/* We require this for boot handshake */
-	status = "okay";
+&a53_0 {
+	clocks = <&k3_clks 61 0>;
+	/*
+	 * FIXME: Currently only the SPL running on the R5 has a clock
+	 * driver. As a workaround therefore move the assigned-clock
+	 * stuff required for our ETH_25MHz_CLK from the cpsw3g_mdio
+	 * node of the regular device tree to here (last one each in
+	 * below three lines, adding a <0> as spacing for parents).
+	 */
+	assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>, <&k3_clks 157 20>;
+	assigned-clock-parents = <&k3_clks 61 2>, <0>, <&k3_clks 157 22>;
+	assigned-clock-rates = <200000000>, <800000000>, <25000000>;
 };
diff --git a/arch/arm/dts/k3-am6254atl-r5-sk.dts b/arch/arm/dts/k3-am6254atl-r5-sk.dts
index 225ad44e722..02a950a9a07 100644
--- a/arch/arm/dts/k3-am6254atl-r5-sk.dts
+++ b/arch/arm/dts/k3-am6254atl-r5-sk.dts
@@ -11,92 +11,8 @@
 #include "k3-am62-ddr.dtsi"
 
 #include "k3-am6254atl-sk-u-boot.dtsi"
-
-/ {
-	aliases {
-		tick-timer = &main_timer0;
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a53_0;
-		serial0 = &wkup_uart0;
-		serial3 = &main_uart1;
-	};
-
-	a53_0: a53@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x00 0x00a90000 0x00 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		clock-names = "gtc", "core";
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		assigned-clock-parents = <&k3_clks 61 2>;
-		assigned-clock-rates = <200000000>, <1200000000>;
-		ti,sci = <&dmsc>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-pre-ram;
-	};
-
-	dm_tifs: dm-tifs {
-		compatible = "ti,j721e-dm-sci";
-		ti,host-id = <36>;
-		ti,secure-host;
-		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 22>,
-			<&secure_proxy_main 23>;
-		bootph-pre-ram;
-	};
-};
-
-&dmsc {
-	mboxes= <&secure_proxy_main 0>,
-		<&secure_proxy_main 1>,
-		<&secure_proxy_main 0>;
-	mbox-names = "rx", "tx", "notify";
-	ti,host-id = <35>;
-	ti,secure-host;
-};
-
-&secure_proxy_sa3 {
-	/* We require this for boot handshake */
-	status = "okay";
-};
-
-&cbass_main {
-	sysctrler: sysctrler {
-		compatible = "ti,am654-tisci-rproc-r5";
-		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
-		mbox-names = "tx", "rx", "boot_notify";
-		bootph-pre-ram;
-	};
-};
-
-&main_timer0 {
-	/delete-property/ clocks;
-	/delete-property/ clocks-names;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	clock-frequency = <25000000>;
-};
-
-/* WKUP UART0 is used for DM firmware logs */
-&wkup_uart0 {
-	status = "okay";
-};
-
-/* Main UART1 is used for TIFS firmware logs */
-&main_uart1 {
-	status = "okay";
-};
-
-&ospi0 {
-	reg = <0x00 0x0fc40000 0x00 0x100>,
-	      <0x00 0x60000000 0x00 0x08000000>;
-};
+#include "k3-am625-r5.dtsi"
 
 &main_pktdma {
 	ti,sci = <&dm_tifs>;
-	bootph-all;
 };
diff --git a/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
index 96860e80e9a..b54cd9d48a4 100644
--- a/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
+++ b/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
@@ -13,48 +13,18 @@
 #include "k3-am62a-ddr.dtsi"
 
 #include "k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi"
+#include "k3-am62a7-r5.dtsi"
 
 / {
 	aliases {
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a53_0;
 		serial0 = &wkup_uart0;
 		serial3 = &main_uart1;
 	};
+};
 
-	a53_0: a53@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x00 0x00a90000 0x00 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>;
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		assigned-clock-parents = <&k3_clks 61 2>;
-		assigned-clock-rates = <200000000>, <1200000000>;
-		ti,sci = <&dmsc>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-pre-ram;
-	};
-
-	dm_tifs: dm-tifs {
-		compatible = "ti,j721e-dm-sci";
-		ti,host-id = <36>;
-		ti,secure-host;
-		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 22>,
-			<&secure_proxy_main 23>;
-		bootph-pre-ram;
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		/* 2G RAM */
-		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
-		bootph-pre-ram;
-	};
+&a53_0 {
+	clocks = <&k3_clks 61 0>;
+	clock-names = "gtc";
 };
 
 &cbass_main {
@@ -79,24 +49,6 @@
 	};
 };
 
-&dmsc {
-	mboxes= <&secure_proxy_main 0>,
-		<&secure_proxy_main 1>,
-		<&secure_proxy_main 0>;
-	mbox-names = "rx", "tx", "notify";
-	ti,host-id = <35>;
-	ti,secure-host;
-};
-
-&main_timer0 {
-	/delete-property/ clocks;
-	/delete-property/ clocks-names;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	clock-frequency = <25000000>;
-	bootph-pre-ram;
-};
-
 &main_bcdma {
 	ti,sci = <&dm_tifs>;
 };
diff --git a/arch/arm/dts/k3-am62a7-r5-sk.dts b/arch/arm/dts/k3-am62a7-r5-sk.dts
index 64923c2c710..4570ff6edbf 100644
--- a/arch/arm/dts/k3-am62a7-r5-sk.dts
+++ b/arch/arm/dts/k3-am62a7-r5-sk.dts
@@ -9,50 +9,12 @@
 #include "k3-am62a-ddr.dtsi"
 
 #include "k3-am62a7-sk-u-boot.dtsi"
+#include "k3-am62a7-r5.dtsi"
 
 / {
 	aliases {
 		tick-timer = &main_timer0;
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a53_0;
 	};
-
-	a53_0: a53@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x00 0x00a90000 0x00 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		clock-names = "gtc", "core";
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		assigned-clock-parents = <&k3_clks 61 2>;
-		assigned-clock-rates = <200000000>, <1200000000>;
-		ti,sci = <&dmsc>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-pre-ram;
-	};
-
-	dm_tifs: dm-tifs {
-		compatible = "ti,j721e-dm-sci";
-		ti,host-id = <36>;
-		ti,secure-host;
-		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 22>,
-			<&secure_proxy_main 23>;
-		bootph-pre-ram;
-	};
-};
-
-&dmsc {
-	mboxes= <&secure_proxy_main 0>,
-		<&secure_proxy_main 1>,
-		<&secure_proxy_main 0>;
-	mbox-names = "rx", "tx", "notify";
-	ti,host-id = <35>;
-	ti,secure-host;
 };
 
 &secure_proxy_sa3 {
@@ -61,26 +23,6 @@
 	bootph-pre-ram;
 };
 
-&cbass_main {
-	sysctrler: sysctrler {
-		compatible = "ti,am654-tisci-rproc-r5";
-		mboxes= <&secure_proxy_main 1>,
-			<&secure_proxy_main 0>,
-			<&secure_proxy_sa3 0>;
-		mbox-names = "tx", "rx", "boot_notify";
-		bootph-pre-ram;
-	};
-};
-
-&main_timer0 {
-	/delete-property/ clocks;
-	/delete-property/ clocks-names;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	clock-frequency = <25000000>;
-	bootph-pre-ram;
-};
-
 &wkup_uart0_pins_default {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/k3-am62a7-r5.dtsi b/arch/arm/dts/k3-am62a7-r5.dtsi
new file mode 100644
index 00000000000..1cb8bdbb78d
--- /dev/null
+++ b/arch/arm/dts/k3-am62a7-r5.dtsi
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/ {
+	aliases {
+		remoteproc0 = &sysctrler;
+		remoteproc1 = &a53_0;
+	};
+
+	a53_0: a53@0 {
+		compatible = "ti,am654-rproc";
+		reg = <0x00 0x00a90000 0x00 0x10>;
+		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
+		resets = <&k3_reset 135 0>;
+		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		clock-names = "gtc", "core";
+		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		assigned-clock-parents = <&k3_clks 61 2>;
+		assigned-clock-rates = <200000000>, <1200000000>;
+		ti,sci = <&dmsc>;
+		ti,sci-proc-id = <32>;
+		ti,sci-host-id = <10>;
+		bootph-pre-ram;
+	};
+
+	dm_tifs: dm-tifs {
+		compatible = "ti,j721e-dm-sci";
+		ti,host-id = <36>;
+		ti,secure-host;
+		mbox-names = "rx", "tx";
+		mboxes= <&secure_proxy_main 22>,
+			<&secure_proxy_main 23>;
+		bootph-pre-ram;
+	};
+
+};
+
+&dmsc {
+	mboxes= <&secure_proxy_main 0>,
+		<&secure_proxy_main 1>,
+		<&secure_proxy_main 0>;
+	mbox-names = "rx", "tx", "notify";
+	ti,host-id = <35>;
+	ti,secure-host;
+};
+
+&cbass_main {
+	sysctrler: sysctrler {
+		compatible = "ti,am654-tisci-rproc-r5";
+		mboxes= <&secure_proxy_main 1>,
+			<&secure_proxy_main 0>,
+			<&secure_proxy_sa3 0>;
+		mbox-names = "tx", "rx", "boot_notify";
+		bootph-pre-ram;
+	};
+};
+
+&main_timer0 {
+	/delete-property/ clocks;
+	/delete-property/ clocks-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	clock-frequency = <25000000>;
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/k3-am62d2-r5-evm.dts b/arch/arm/dts/k3-am62d2-r5-evm.dts
index a3213d00145..62f337e0131 100644
--- a/arch/arm/dts/k3-am62d2-r5-evm.dts
+++ b/arch/arm/dts/k3-am62d2-r5-evm.dts
@@ -9,74 +9,4 @@
 #include "k3-am62a-ddr.dtsi"
 
 #include "k3-am62d2-evm-u-boot.dtsi"
-
-/ {
-	aliases {
-		tick-timer = &main_timer0;
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a53_0;
-	};
-
-	a53_0: a53@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x00 0x00a90000 0x00 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		clock-names = "gtc", "core";
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		assigned-clock-parents = <&k3_clks 61 2>;
-		assigned-clock-rates = <200000000>, <1200000000>;
-		ti,sci = <&dmsc>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-pre-ram;
-	};
-
-	dm_tifs: dm-tifs {
-		compatible = "ti,j721e-dm-sci";
-		ti,host-id = <36>;
-		ti,secure-host;
-		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 22>,
-			<&secure_proxy_main 23>;
-		bootph-pre-ram;
-	};
-};
-
-&dmsc {
-	mboxes= <&secure_proxy_main 0>,
-		<&secure_proxy_main 1>,
-		<&secure_proxy_main 0>;
-	mbox-names = "rx", "tx", "notify";
-	ti,host-id = <35>;
-	ti,secure-host;
-};
-
-&secure_proxy_sa3 {
-	/* Needed for initial handshake with ROM */
-	status = "okay";
-	bootph-pre-ram;
-};
-
-&cbass_main {
-	sysctrler: sysctrler {
-		compatible = "ti,am654-tisci-rproc-r5";
-		mboxes= <&secure_proxy_main 1>,
-			<&secure_proxy_main 0>,
-			<&secure_proxy_sa3 0>;
-		mbox-names = "tx", "rx", "boot_notify";
-		bootph-pre-ram;
-	};
-};
-
-&main_timer0 {
-	/delete-property/ clocks;
-	/delete-property/ clocks-names;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	clock-frequency = <25000000>;
-	bootph-pre-ram;
-};
+#include "k3-am62d2-r5.dtsi"
diff --git a/arch/arm/dts/k3-am62d2-r5.dtsi b/arch/arm/dts/k3-am62d2-r5.dtsi
new file mode 100644
index 00000000000..23dfc49c2ea
--- /dev/null
+++ b/arch/arm/dts/k3-am62d2-r5.dtsi
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/ {
+	aliases {
+		tick-timer = &main_timer0;
+		remoteproc0 = &sysctrler;
+		remoteproc1 = &a53_0;
+	};
+
+	a53_0: a53@0 {
+		compatible = "ti,am654-rproc";
+		reg = <0x00 0x00a90000 0x00 0x10>;
+		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
+		resets = <&k3_reset 135 0>;
+		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		clock-names = "gtc", "core";
+		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		assigned-clock-parents = <&k3_clks 61 2>;
+		assigned-clock-rates = <200000000>, <1200000000>;
+		ti,sci = <&dmsc>;
+		ti,sci-proc-id = <32>;
+		ti,sci-host-id = <10>;
+		bootph-pre-ram;
+	};
+
+	dm_tifs: dm-tifs {
+		compatible = "ti,j721e-dm-sci";
+		ti,host-id = <36>;
+		ti,secure-host;
+		mbox-names = "rx", "tx";
+		mboxes= <&secure_proxy_main 22>,
+			<&secure_proxy_main 23>;
+		bootph-pre-ram;
+	};
+};
+
+&dmsc {
+	mboxes= <&secure_proxy_main 0>,
+		<&secure_proxy_main 1>,
+		<&secure_proxy_main 0>;
+	mbox-names = "rx", "tx", "notify";
+	ti,host-id = <35>;
+	ti,secure-host;
+};
+
+&secure_proxy_sa3 {
+	/* Needed for initial handshake with ROM */
+	status = "okay";
+	bootph-pre-ram;
+};
+
+&cbass_main {
+	sysctrler: sysctrler {
+		compatible = "ti,am654-tisci-rproc-r5";
+		mboxes= <&secure_proxy_main 1>,
+			<&secure_proxy_main 0>,
+			<&secure_proxy_sa3 0>;
+		mbox-names = "tx", "rx", "boot_notify";
+		bootph-pre-ram;
+	};
+};
+
+&main_timer0 {
+	/delete-property/ clocks;
+	/delete-property/ clocks-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	clock-frequency = <25000000>;
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/k3-am62p5-r5-sk.dts b/arch/arm/dts/k3-am62p5-r5-sk.dts
index e45d2bf6a0b..9a09360c242 100644
--- a/arch/arm/dts/k3-am62p5-r5-sk.dts
+++ b/arch/arm/dts/k3-am62p5-r5-sk.dts
@@ -9,81 +9,14 @@
 
 #include "k3-am62p-ddr-lp4-50-1600.dtsi"
 #include "k3-am62a-ddr.dtsi"
+#include "k3-am62p5-r5.dtsi"
 
 / {
 	aliases {
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a53_0;
 		serial0 = &wkup_uart0;
 		serial2 = &main_uart0;
 		serial3 = &main_uart1;
 	};
-
-	a53_0: a53@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x00 0x00a90000 0x00 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
-			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		clock-names = "gtc", "core";
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		assigned-clock-parents = <&k3_clks 61 2>;
-		assigned-clock-rates = <200000000>, <1200000000>;
-		ti,sci = <&dmsc>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-all;
-	};
-
-	dm_tifs: dm-tifs {
-		compatible = "ti,j721e-dm-sci";
-		ti,host-id = <36>;
-		ti,secure-host;
-		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 20>,
-			<&secure_proxy_main 21>;
-		bootph-all;
-	};
-};
-
-&dmsc {
-	mboxes= <&secure_proxy_main 0>,
-		<&secure_proxy_main 1>,
-		<&secure_proxy_main 0>;
-	mbox-names = "rx", "tx", "notify";
-	ti,host-id = <35>;
-	ti,secure-host;
-};
-
-&cbass_main {
-	sa3_secproxy: secproxy@44880000 {
-		compatible = "ti,am654-secure-proxy";
-		#mbox-cells = <1>;
-		reg = <0x00 0x44880000 0x00 0x20000>,
-		      <0x00 0x44860000 0x00 0x20000>,
-		      <0x00 0x43600000 0x00 0x10000>;
-		reg-names = "rt", "scfg", "target_data";
-		bootph-all;
-	};
-
-	sysctrler: sysctrler {
-		compatible = "ti,am654-tisci-rproc-r5";
-		mboxes= <&secure_proxy_main 1>,
-			<&secure_proxy_main 0>,
-			<&sa3_secproxy 0>;
-		mbox-names = "tx", "rx", "boot_notify";
-		bootph-all;
-	};
-};
-
-&main_timer0 {
-	/delete-property/ clocks;
-	/delete-property/ clocks-names;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	clock-frequency = <25000000>;
 };
 
 /* WKUP UART0 is used for DM firmware logs */
diff --git a/arch/arm/dts/k3-am62p5-r5.dtsi b/arch/arm/dts/k3-am62p5-r5.dtsi
new file mode 100644
index 00000000000..338bd73e1c0
--- /dev/null
+++ b/arch/arm/dts/k3-am62p5-r5.dtsi
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/ {
+	aliases {
+		remoteproc0 = &sysctrler;
+		remoteproc1 = &a53_0;
+	};
+
+	a53_0: a53@0 {
+		compatible = "ti,am654-rproc";
+		reg = <0x00 0x00a90000 0x00 0x10>;
+		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
+			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
+			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
+		resets = <&k3_reset 135 0>;
+		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		clock-names = "gtc", "core";
+		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		assigned-clock-parents = <&k3_clks 61 2>;
+		assigned-clock-rates = <200000000>, <1200000000>;
+		ti,sci = <&dmsc>;
+		ti,sci-proc-id = <32>;
+		ti,sci-host-id = <10>;
+		bootph-all;
+	};
+
+	dm_tifs: dm-tifs {
+		compatible = "ti,j721e-dm-sci";
+		ti,host-id = <36>;
+		ti,secure-host;
+		mbox-names = "rx", "tx";
+		mboxes= <&secure_proxy_main 20>,
+			<&secure_proxy_main 21>;
+		bootph-all;
+	};
+};
+
+&cbass_main {
+	sa3_secproxy: secproxy@44880000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg = <0x00 0x44880000 0x00 0x20000>,
+		      <0x00 0x44860000 0x00 0x20000>,
+		      <0x00 0x43600000 0x00 0x10000>;
+		reg-names = "rt", "scfg", "target_data";
+		bootph-all;
+	};
+
+	sysctrler: sysctrler {
+		compatible = "ti,am654-tisci-rproc-r5";
+		mboxes= <&secure_proxy_main 1>,
+			<&secure_proxy_main 0>,
+			<&sa3_secproxy 0>;
+		mbox-names = "tx", "rx", "boot_notify";
+		bootph-all;
+	};
+};
+
+&dmsc {
+	mboxes= <&secure_proxy_main 0>,
+		<&secure_proxy_main 1>,
+		<&secure_proxy_main 0>;
+	mbox-names = "rx", "tx", "notify";
+	ti,host-id = <35>;
+	ti,secure-host;
+};
+
+&main_timer0 {
+	/delete-property/ clocks;
+	/delete-property/ clocks-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	clock-frequency = <25000000>;
+};
diff --git a/arch/arm/dts/k3-am62p5-verdin-r5.dts b/arch/arm/dts/k3-am62p5-verdin-r5.dts
index 17739086935..b1735b363ba 100644
--- a/arch/arm/dts/k3-am62p5-verdin-r5.dts
+++ b/arch/arm/dts/k3-am62p5-verdin-r5.dts
@@ -9,76 +9,10 @@
 #include "k3-am62a-ddr.dtsi"
 
 #include "k3-am62p5-verdin-wifi-dev-u-boot.dtsi"
+#include "k3-am62p5-r5.dtsi"
 
-/ {
-	aliases {
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a53_0;
-	};
-
-	a53_0: a53@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x00 0x00a90000 0x00 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
-			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		clock-names = "gtc", "core";
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>, <&k3_clks 157 36>;
-		assigned-clock-parents = <&k3_clks 61 2>, <0>, <&k3_clks 157 38>;
-		assigned-clock-rates = <200000000>, <1200000000>, <25000000>;
-		ti,sci = <&dmsc>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-all;
-	};
-
-	dm_tifs: dm-tifs {
-		compatible = "ti,j721e-dm-sci";
-		ti,host-id = <36>;
-		ti,secure-host;
-		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 20>,
-			<&secure_proxy_main 21>;
-		bootph-all;
-	};
-};
-
-&cbass_main {
-	sa3_secproxy: secproxy@44880000 {
-		compatible = "ti,am654-secure-proxy";
-		#mbox-cells = <1>;
-		reg = <0x00 0x44880000 0x00 0x20000>,
-		      <0x00 0x44860000 0x00 0x20000>,
-		      <0x00 0x43600000 0x00 0x10000>;
-		reg-names = "rt", "scfg", "target_data";
-		bootph-all;
-	};
-
-	sysctrler: sysctrler {
-		compatible = "ti,am654-tisci-rproc-r5";
-		mboxes= <&secure_proxy_main 1>,
-			<&secure_proxy_main 0>,
-			<&sa3_secproxy 0>;
-		mbox-names = "tx", "rx", "boot_notify";
-		bootph-all;
-	};
-};
-
-&dmsc {
-	mboxes= <&secure_proxy_main 0>,
-		<&secure_proxy_main 1>,
-		<&secure_proxy_main 0>;
-	mbox-names = "rx", "tx", "notify";
-	ti,host-id = <35>;
-	ti,secure-host;
-};
-
-&main_timer0 {
-	/delete-property/ clocks;
-	/delete-property/ clocks-names;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	clock-frequency = <25000000>;
+&a53_0 {
+	assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>, <&k3_clks 157 36>;
+	assigned-clock-parents = <&k3_clks 61 2>, <0>, <&k3_clks 157 38>;
+	assigned-clock-rates = <200000000>, <1200000000>, <25000000>;
 };
diff --git a/arch/arm/dts/k3-am642-r5-evm.dts b/arch/arm/dts/k3-am642-r5-evm.dts
index 67b8587d3b2..e3d363a8e39 100644
--- a/arch/arm/dts/k3-am642-r5-evm.dts
+++ b/arch/arm/dts/k3-am642-r5-evm.dts
@@ -8,56 +8,7 @@
 #include "k3-am64-ddr.dtsi"
 
 #include "k3-am642-evm-u-boot.dtsi"
-
-/ {
-	aliases {
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a53_0;
-	};
-
-	a53_0: a53@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x00 0x00a90000 0x00 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 137 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		clock-names = "gtc", "core";
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		assigned-clock-parents = <&k3_clks 61 2>;
-		assigned-clock-rates = <200000000>, <1000000000>;
-		ti,sci = <&dmsc>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-pre-ram;
-	};
-
-	clk_200mhz: dummy-clock-200mhz {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <200000000>;
-		bootph-pre-ram;
-	};
-};
-
-&cbass_main {
-	sysctrler: sysctrler {
-		compatible = "ti,am654-tisci-rproc-r5";
-		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>;
-		mbox-names = "tx", "rx";
-		bootph-pre-ram;
-	};
-};
-
-&dmsc {
-	mboxes= <&secure_proxy_main 0>,
-		<&secure_proxy_main 1>,
-		<&secure_proxy_main 0>;
-	mbox-names = "rx", "tx", "notify";
-	ti,host-id = <35>;
-	ti,secure-host;
-};
+#include "k3-am642-r5.dtsi"
 
 &memorycontroller {
 	vtt-supply = <&vtt_supply>;
@@ -72,33 +23,3 @@
 	clocks = <&clk_200mhz>;
 	clock-names = "clk_xin";
 };
-
-/* UART is initialized before SYSFW is started
- * so we can't do any power-domain/clock operations.
- * Delete clock/power-domain properties to avoid
- * UART init failure
- */
-&main_uart0 {
-	/delete-property/ power-domains;
-	/delete-property/ clocks;
-	/delete-property/ clock-names;
-};
-
-/* timer init is called as part of rproc_start() while
- * starting System Firmware, so any clock/power-domain
- * operations will fail as SYSFW is not yet up and running.
- * Delete all clock/power-domain properties to avoid
- * timer init failure.
- * This is an always on timer at 20MHz.
- */
-&main_timer0 {
-	/delete-property/ clocks;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	/delete-property/ power-domains;
-};
-
-&ospi0 {
-	reg = <0x00 0x0fc40000 0x00 0x100>,
-	      <0x00 0x60000000 0x00 0x8000000>;
-};
diff --git a/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
index d27fc7fa882..4b7a63db4ce 100644
--- a/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
+++ b/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
@@ -14,83 +14,15 @@
 #include "k3-am64-ddr.dtsi"
 
 #include "k3-am642-phyboard-electra-rdk-u-boot.dtsi"
+#include "k3-am642-r5.dtsi"
 
 / {
 	aliases {
 		ethernet0 = &cpsw3g;
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a53_0;
 	};
-
-	a53_0: a53@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x00 0x00a90000 0x00 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 137 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>;
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		assigned-clock-parents = <&k3_clks 61 2>;
-		assigned-clock-rates = <200000000>, <1000000000>;
-		ti,sci = <&dmsc>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-pre-ram;
-	};
-
-	clk_200mhz: dummy-clock-200mhz {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <200000000>;
-		bootph-pre-ram;
-	};
-};
-
-&cbass_main {
-	sysctrler: sysctrler {
-		compatible = "ti,am654-tisci-rproc-r5";
-		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>;
-		mbox-names = "tx", "rx";
-		bootph-pre-ram;
-	};
-};
-
-&dmsc {
-	mboxes= <&secure_proxy_main 0>,
-		<&secure_proxy_main 1>,
-		<&secure_proxy_main 0>;
-	mbox-names = "rx", "tx", "notify";
-	ti,host-id = <35>;
-	ti,secure-host;
-};
-
-/* timer init is called as part of rproc_start() while
- * starting System Firmware, so any clock/power-domain
- * operations will fail as SYSFW is not yet up and running.
- * Delete all clock/power-domain properties to avoid
- * timer init failure.
- * This is an always on timer at 20MHz.
- */
-&main_timer0 {
-	/delete-property/ clocks;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	/delete-property/ power-domains;
-};
-
-/* UART is initialized before SYSFW is started
- * so we can't do any power-domain/clock operations.
- * Delete clock/power-domain properties to avoid
- * UART init failure
- */
-&main_uart0 {
-	/delete-property/ power-domains;
-	/delete-property/ clocks;
-	/delete-property/ clock-names;
 };
 
-&ospi0 {
-	reg = <0x00 0x0fc40000 0x00 0x100>,
-	      <0x00 0x60000000 0x00 0x08000000>;
+&a53_0 {
+	clock-names = "gtc";
+	clocks = <&k3_clks 61 0>;
 };
diff --git a/arch/arm/dts/k3-am642-r5-sk.dts b/arch/arm/dts/k3-am642-r5-sk.dts
index cfc548a1cea..27f3e87fb90 100644
--- a/arch/arm/dts/k3-am642-r5-sk.dts
+++ b/arch/arm/dts/k3-am642-r5-sk.dts
@@ -8,56 +8,7 @@
 #include "k3-am64-ddr.dtsi"
 
 #include "k3-am642-sk-u-boot.dtsi"
-
-/ {
-	aliases {
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a53_0;
-	};
-
-	a53_0: a53@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x00 0x00a90000 0x00 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 137 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		clock-names = "gtc", "core";
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		assigned-clock-parents = <&k3_clks 61 2>;
-		assigned-clock-rates = <200000000>, <1000000000>;
-		ti,sci = <&dmsc>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-pre-ram;
-	};
-
-	clk_200mhz: dummy-clock-200mhz {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <200000000>;
-		bootph-pre-ram;
-	};
-};
-
-&cbass_main {
-	sysctrler: sysctrler {
-		compatible = "ti,am654-tisci-rproc-r5";
-		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>;
-		mbox-names = "tx", "rx";
-		bootph-pre-ram;
-	};
-};
-
-&dmsc {
-	mboxes= <&secure_proxy_main 0>,
-		<&secure_proxy_main 1>,
-		<&secure_proxy_main 0>;
-	mbox-names = "rx", "tx", "notify";
-	ti,host-id = <35>;
-	ti,secure-host;
-};
+#include "k3-am642-r5.dtsi"
 
 &sdhci1 {
 	clocks = <&clk_200mhz>;
@@ -67,33 +18,3 @@
 &serdes_wiz0 {
 	status = "okay";
 };
-
-/* UART is initialized before SYSFW is started
- * so we can't do any power-domain/clock operations.
- * Delete clock/power-domain properties to avoid
- * UART init failure
- */
-&main_uart0 {
-	/delete-property/ power-domains;
-	/delete-property/ clocks;
-	/delete-property/ clock-names;
-};
-
-/* timer init is called as part of rproc_start() while
- * starting System Firmware, so any clock/power-domain
- * operations will fail as SYSFW is not yet up and running.
- * Delete all clock/power-domain properties to avoid
- * timer init failure.
- * This is an always on timer at 20MHz.
- */
-&main_timer0 {
-	/delete-property/ clocks;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	/delete-property/ power-domains;
-};
-
-&ospi0 {
-	reg = <0x00 0x0fc40000 0x00 0x100>,
- 	      <0x00 0x60000000 0x00 0x8000000>;
-};
diff --git a/arch/arm/dts/k3-am642-r5.dtsi b/arch/arm/dts/k3-am642-r5.dtsi
new file mode 100644
index 00000000000..71e1f9d1de6
--- /dev/null
+++ b/arch/arm/dts/k3-am642-r5.dtsi
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/ {
+	aliases {
+		remoteproc0 = &sysctrler;
+		remoteproc1 = &a53_0;
+	};
+
+	a53_0: a53@0 {
+		compatible = "ti,am654-rproc";
+		reg = <0x00 0x00a90000 0x00 0x10>;
+		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 137 TI_SCI_PD_EXCLUSIVE>;
+		resets = <&k3_reset 135 0>;
+		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		clock-names = "gtc", "core";
+		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		assigned-clock-parents = <&k3_clks 61 2>;
+		assigned-clock-rates = <200000000>, <1000000000>;
+		ti,sci = <&dmsc>;
+		ti,sci-proc-id = <32>;
+		ti,sci-host-id = <10>;
+		bootph-pre-ram;
+	};
+
+	clk_200mhz: dummy-clock-200mhz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <200000000>;
+		bootph-pre-ram;
+	};
+};
+
+&cbass_main {
+	sysctrler: sysctrler {
+		compatible = "ti,am654-tisci-rproc-r5";
+		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>;
+		mbox-names = "tx", "rx";
+		bootph-pre-ram;
+	};
+};
+
+&dmsc {
+	mboxes= <&secure_proxy_main 0>,
+		<&secure_proxy_main 1>,
+		<&secure_proxy_main 0>;
+	mbox-names = "rx", "tx", "notify";
+	ti,host-id = <35>;
+	ti,secure-host;
+};
+
+/* UART is initialized before SYSFW is started
+ * so we can't do any power-domain/clock operations.
+ * Delete clock/power-domain properties to avoid
+ * UART init failure
+ */
+&main_uart0 {
+	/delete-property/ power-domains;
+	/delete-property/ clocks;
+	/delete-property/ clock-names;
+};
+
+/* timer init is called as part of rproc_start() while
+ * starting System Firmware, so any clock/power-domain
+ * operations will fail as SYSFW is not yet up and running.
+ * Delete all clock/power-domain properties to avoid
+ * timer init failure.
+ * This is an always on timer at 20MHz.
+ */
+&main_timer0 {
+	/delete-property/ clocks;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	/delete-property/ power-domains;
+};
+
+&ospi0 {
+	reg = <0x00 0x0fc40000 0x00 0x100>,
+	      <0x00 0x60000000 0x00 0x8000000>;
+};
diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 99eb8a2d442..30eb3a9ade9 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -9,74 +9,7 @@
 #include "k3-am654-base-board-u-boot.dtsi"
 #include "k3-am654-base-board-ddr4-1600MTs.dtsi"
 #include "k3-am654-ddr.dtsi"
-
-/ {
-	aliases {
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a53_0;
-	};
-
-	a53_0: a53@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x0 0x00a90000 0x0 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 202 0>;
-		clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
-		clock-names = "gtc", "core";
-		assigned-clocks = <&k3_clks 202 0>;
-		assigned-clock-rates = <800000000>;
-		ti,sci = <&dmsc>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-pre-ram;
-	};
-
-	clk_200mhz: dummy_clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <200000000>;
-		bootph-pre-ram;
-	};
-};
-
-&secure_proxy_mcu {
-	status = "okay";
-	bootph-pre-ram;
-};
-
-&cbass_wakeup {
-	sysctrler: sysctrler {
-		compatible = "ti,am654-tisci-rproc-r5";
-		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>;
-		mbox-names = "tx", "rx";
-		bootph-pre-ram;
-	};
-};
-
-/*
- * timer init is called as part of rproc_start() while
- * starting System Firmware, so any clock/power-domain
- * operations will fail as SYSFW is not yet up and running.
- * Delete all clock/power-domain properties to avoid
- * timer init failure.
- * This is an always on timer at 20MHz.
- */
-&mcu_timer0 {
-	/delete-property/ clocks;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	/delete-property/ power-domains;
-};
-
-&dmsc {
-	mboxes = <&secure_proxy_mcu 8>,
-		 <&secure_proxy_mcu 6>,
-		 <&secure_proxy_mcu 5>;
-	mbox-names = "tx", "rx", "notify";
-	ti,host-id = <4>;
-	ti,secure-host;
-};
+#include "k3-am654-r5.dtsi"
 
 &wkup_uart0 {
 	status = "okay";
@@ -128,11 +61,6 @@
 	/delete-property/ power-domains;
 };
 
-&ospi0 {
-	reg = <0x0 0x47040000 0x0 0x100>,
-	      <0x0 0x50000000 0x0 0x8000000>;
-};
-
 &dwc3_0 {
 	status = "okay";
 	/delete-property/ clocks;
diff --git a/arch/arm/dts/k3-am654-r5.dtsi b/arch/arm/dts/k3-am654-r5.dtsi
new file mode 100644
index 00000000000..1762c1457d9
--- /dev/null
+++ b/arch/arm/dts/k3-am654-r5.dtsi
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/ {
+	aliases {
+		remoteproc0 = &sysctrler;
+		remoteproc1 = &a53_0;
+	};
+
+	a53_0: a53@0 {
+		compatible = "ti,am654-rproc";
+		reg = <0x0 0x00a90000 0x0 0x10>;
+		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
+		resets = <&k3_reset 202 0>;
+		clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
+		clock-names = "gtc", "core";
+		assigned-clocks = <&k3_clks 202 0>;
+		assigned-clock-rates = <800000000>;
+		ti,sci = <&dmsc>;
+		ti,sci-proc-id = <32>;
+		ti,sci-host-id = <10>;
+		bootph-pre-ram;
+	};
+
+	clk_200mhz: dummy_clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <200000000>;
+		bootph-pre-ram;
+	};
+};
+
+&secure_proxy_mcu {
+	status = "okay";
+	bootph-pre-ram;
+};
+
+&cbass_wakeup {
+	sysctrler: sysctrler {
+		compatible = "ti,am654-tisci-rproc-r5";
+		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>;
+		mbox-names = "tx", "rx";
+		bootph-pre-ram;
+	};
+};
+
+&dmsc {
+	mboxes = <&secure_proxy_mcu 8>,
+		 <&secure_proxy_mcu 6>,
+		 <&secure_proxy_mcu 5>;
+	mbox-names = "tx", "rx", "notify";
+	ti,host-id = <4>;
+	ti,secure-host;
+};
+
+&ospi0 {
+	reg = <0x0 0x47040000 0x0 0x100>,
+	      <0x0 0x50000000 0x0 0x8000000>;
+};
+
+/*
+ * timer init is called as part of rproc_start() while
+ * starting System Firmware, so any clock/power-domain
+ * operations will fail as SYSFW is not yet up and running.
+ * Delete all clock/power-domain properties to avoid
+ * timer init failure.
+ * This is an always on timer at 20MHz.
+ */
+&mcu_timer0 {
+	/delete-property/ clocks;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	/delete-property/ power-domains;
+};
diff --git a/arch/arm/dts/k3-am67a-r5-beagley-ai.dts b/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
index 45d104e8e3f..61ee75b7432 100644
--- a/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
+++ b/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
@@ -11,72 +11,7 @@
 
 #include "k3-am67a-beagley-ddr-lp4.dtsi"
 #include "k3-am62a-ddr.dtsi"
-
-/ {
-	aliases {
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a53_0;
-		serial0 = &wkup_uart0;
-		serial2 = &main_uart0;
-	};
-
-	a53_0: a53@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x00 0x00a90000 0x00 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
-			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>;
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		assigned-clock-parents = <&k3_clks 61 2>;
-		assigned-clock-rates = <200000000>, <1200000000>;
-		ti,sci = <&dmsc>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-all;
-	};
-
-	dm_tifs: dm-tifs {
-		compatible = "ti,j721e-dm-sci";
-		ti,host-id = <36>;
-		ti,secure-host;
-		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 22>,
-			<&secure_proxy_main 23>;
-		bootph-all;
-	};
-};
-
-&dmsc {
-	mboxes= <&secure_proxy_main 0>,
-		<&secure_proxy_main 1>,
-		<&secure_proxy_main 0>;
-	mbox-names = "rx", "tx", "notify";
-	ti,host-id = <35>;
-	ti,secure-host;
-};
-
-&cbass_main {
-	sa3_secproxy: secproxy@44880000 {
-		compatible = "ti,am654-secure-proxy";
-		#mbox-cells = <1>;
-		reg = <0x00 0x44880000 0x00 0x20000>,
-		      <0x00 0x44860000 0x00 0x20000>,
-		      <0x00 0x43600000 0x00 0x10000>;
-		reg-names = "rt", "scfg", "target_data";
-		bootph-all;
-	};
-
-	sysctrler: sysctrler {
-		compatible = "ti,am654-tisci-rproc-r5";
-		mboxes= <&secure_proxy_main 1>,
-			<&secure_proxy_main 0>,
-			<&sa3_secproxy 0>;
-		mbox-names = "tx", "rx", "boot_notify";
-		bootph-all;
-	};
-};
+#include "k3-am67a-r5.dtsi"
 
 /* WKUP UART0 is used for DM firmware logs */
 &wkup_uart0 {
diff --git a/arch/arm/dts/k3-am67a-r5.dtsi b/arch/arm/dts/k3-am67a-r5.dtsi
new file mode 100644
index 00000000000..48bd15f480f
--- /dev/null
+++ b/arch/arm/dts/k3-am67a-r5.dtsi
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/ {
+	aliases {
+		remoteproc0 = &sysctrler;
+		remoteproc1 = &a53_0;
+		serial0 = &wkup_uart0;
+		serial2 = &main_uart0;
+	};
+
+	a53_0: a53@0 {
+		compatible = "ti,am654-rproc";
+		reg = <0x00 0x00a90000 0x00 0x10>;
+		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
+			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
+			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
+		resets = <&k3_reset 135 0>;
+		clocks = <&k3_clks 61 0>;
+		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		assigned-clock-parents = <&k3_clks 61 2>;
+		assigned-clock-rates = <200000000>, <1200000000>;
+		ti,sci = <&dmsc>;
+		ti,sci-proc-id = <32>;
+		ti,sci-host-id = <10>;
+		bootph-all;
+	};
+
+	dm_tifs: dm-tifs {
+		compatible = "ti,j721e-dm-sci";
+		ti,host-id = <36>;
+		ti,secure-host;
+		mbox-names = "rx", "tx";
+		mboxes= <&secure_proxy_main 22>,
+			<&secure_proxy_main 23>;
+		bootph-all;
+	};
+};
+
+&dmsc {
+	mboxes= <&secure_proxy_main 0>,
+		<&secure_proxy_main 1>,
+		<&secure_proxy_main 0>;
+	mbox-names = "rx", "tx", "notify";
+	ti,host-id = <35>;
+	ti,secure-host;
+};
+
+&cbass_main {
+	sa3_secproxy: secproxy@44880000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg = <0x00 0x44880000 0x00 0x20000>,
+		      <0x00 0x44860000 0x00 0x20000>,
+		      <0x00 0x43600000 0x00 0x10000>;
+		reg-names = "rt", "scfg", "target_data";
+		bootph-all;
+	};
+
+	sysctrler: sysctrler {
+		compatible = "ti,am654-tisci-rproc-r5";
+		mboxes= <&secure_proxy_main 1>,
+			<&secure_proxy_main 0>,
+			<&sa3_secproxy 0>;
+		mbox-names = "tx", "rx", "boot_notify";
+		bootph-all;
+	};
+};
diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
index e35b767a7e3..b0e73fe72c4 100644
--- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
@@ -9,92 +9,12 @@
 #include "k3-j7200-ddr-evm-lp4-2666.dtsi"
 #include "k3-j721e-ddr.dtsi"
 #include "k3-j7200-common-proc-board-u-boot.dtsi"
-
-/ {
-	aliases {
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a72_0;
-	};
-
-	a72_0: a72@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x0 0x00a90000 0x0 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 202 0>;
-		clocks = <&k3_clks 61 1>, <&k3_clks 202 2>, <&k3_clks 4 1> ;
-		clock-names = "gtc", "core", "msmc";
-		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 4 1>,
-						  <&k3_clks 323 0>;
-		assigned-clock-parents= <0>, <0>, <0>, <&k3_clks 323 2>;
-		assigned-clock-rates = <2000000000>, <200000000>, <1000000000>;
-		ti,sci = <&dmsc>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-pre-ram;
-	};
-
-	dm_tifs: dm-tifs {
-		compatible = "ti,j721e-dm-sci";
-		ti,host-id = <3>;
-		ti,secure-host;
-		mbox-names = "rx", "tx";
-		mboxes = <&secure_proxy_mcu 21>,
-			<&secure_proxy_mcu 23>;
-		bootph-pre-ram;
-	};
-};
-
-&memorycontroller {
-	power-domains = <&k3_pds 8 TI_SCI_PD_SHARED>,
-			<&k3_pds 90 TI_SCI_PD_SHARED>;
-	clocks = <&k3_clks 8 5>, <&k3_clks 30 9>;
-	bootph-pre-ram;
-};
-
-&mcu_timer0 {
-	/delete-property/ clocks;
-	/delete-property/ clocks-names;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	clock-frequency = <250000000>;
-	bootph-pre-ram;
-};
-
-&secure_proxy_mcu {
-	bootph-pre-ram;
-	status = "okay";
-};
-
-&cbass_mcu_wakeup {
-	sysctrler: sysctrler {
-		compatible = "ti,am654-tisci-rproc-r5";
-		mboxes= <&secure_proxy_mcu 4>,
-			<&secure_proxy_mcu 5>;
-		mbox-names = "tx", "rx";
-		bootph-pre-ram;
-	};
-};
-
-&dmsc {
-	mboxes = <&secure_proxy_mcu 8>,
-		<&secure_proxy_mcu 6>, <&secure_proxy_mcu 5>;
-	mbox-names = "tx", "rx", "notify";
-	ti,host-id = <4>;
-	ti,secure-host;
-	bootph-pre-ram;
-};
+#include "k3-j7200-r5.dtsi"
 
 &wkup_vtm0 {
 	bootph-pre-ram;
 };
 
-&ospi0 {
-    reg = <0x0 0x47040000 0x0 0x100>,
-          <0x0 0x50000000 0x0 0x8000000>;
-};
-
 &fss {
 	/* enable ranges missing from the FSS node */
 	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
diff --git a/arch/arm/dts/k3-j7200-r5.dtsi b/arch/arm/dts/k3-j7200-r5.dtsi
new file mode 100644
index 00000000000..6c61ba5faec
--- /dev/null
+++ b/arch/arm/dts/k3-j7200-r5.dtsi
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/ {
+	aliases {
+		remoteproc0 = &sysctrler;
+		remoteproc1 = &a72_0;
+	};
+
+	a72_0: a72@0 {
+		compatible = "ti,am654-rproc";
+		reg = <0x0 0x00a90000 0x0 0x10>;
+		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
+		resets = <&k3_reset 202 0>;
+		clocks = <&k3_clks 61 1>, <&k3_clks 202 2>, <&k3_clks 4 1> ;
+		clock-names = "gtc", "core", "msmc";
+		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 4 1>,
+						  <&k3_clks 323 0>;
+		assigned-clock-parents= <0>, <0>, <0>, <&k3_clks 323 2>;
+		assigned-clock-rates = <2000000000>, <200000000>, <1000000000>;
+		ti,sci = <&dmsc>;
+		ti,sci-proc-id = <32>;
+		ti,sci-host-id = <10>;
+		bootph-pre-ram;
+	};
+
+	dm_tifs: dm-tifs {
+		compatible = "ti,j721e-dm-sci";
+		ti,host-id = <3>;
+		ti,secure-host;
+		mbox-names = "rx", "tx";
+		mboxes = <&secure_proxy_mcu 21>,
+			<&secure_proxy_mcu 23>;
+		bootph-pre-ram;
+	};
+};
+
+&memorycontroller {
+	power-domains = <&k3_pds 8 TI_SCI_PD_SHARED>,
+			<&k3_pds 90 TI_SCI_PD_SHARED>;
+	clocks = <&k3_clks 8 5>, <&k3_clks 30 9>;
+	bootph-pre-ram;
+};
+
+&mcu_timer0 {
+	/delete-property/ clocks;
+	/delete-property/ clocks-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	clock-frequency = <250000000>;
+	bootph-pre-ram;
+};
+
+&secure_proxy_mcu {
+	bootph-pre-ram;
+	status = "okay";
+};
+
+&cbass_mcu_wakeup {
+	sysctrler: sysctrler {
+		compatible = "ti,am654-tisci-rproc-r5";
+		mboxes= <&secure_proxy_mcu 4>,
+			<&secure_proxy_mcu 5>;
+		mbox-names = "tx", "rx";
+		bootph-pre-ram;
+	};
+};
+
+&dmsc {
+	mboxes = <&secure_proxy_mcu 8>,
+		<&secure_proxy_mcu 6>, <&secure_proxy_mcu 5>;
+	mbox-names = "tx", "rx", "notify";
+	ti,host-id = <4>;
+	ti,secure-host;
+	bootph-pre-ram;
+};
+
+&ospi0 {
+	reg = <0x0 0x47040000 0x0 0x100>,
+	      <0x0 0x50000000 0x0 0x8000000>;
+};
+
diff --git a/arch/arm/dts/k3-j722s-r5-evm.dts b/arch/arm/dts/k3-j722s-r5-evm.dts
index 02a3494a877..e1ef5d181ed 100644
--- a/arch/arm/dts/k3-j722s-r5-evm.dts
+++ b/arch/arm/dts/k3-j722s-r5-evm.dts
@@ -9,92 +9,13 @@
 
 #include "k3-j722s-ddr-lp4-50-4000.dtsi"
 #include "k3-am62a-ddr.dtsi"
-
-/ {
-	aliases {
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a53_0;
-		serial0 = &wkup_uart0;
-		serial2 = &main_uart0;
-	};
-
-	a53_0: a53@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x00 0x00a90000 0x00 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
-			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		clock-names = "gtc", "core";
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		assigned-clock-parents = <&k3_clks 61 2>;
-		assigned-clock-rates = <200000000>, <1400000000>;
-		ti,sci = <&dmsc>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-all;
-	};
-
-	dm_tifs: dm-tifs {
-		compatible = "ti,j721e-dm-sci";
-		ti,host-id = <36>;
-		ti,secure-host;
-		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 28>,
-			<&secure_proxy_main 29>;
-		bootph-all;
-	};
-};
-
-&dmsc {
-	mboxes= <&secure_proxy_main 0>,
-		<&secure_proxy_main 1>,
-		<&secure_proxy_main 0>;
-	mbox-names = "rx", "tx", "notify";
-	ti,host-id = <35>;
-	ti,secure-host;
-};
-
-&cbass_main {
-	sa3_secproxy: secproxy@44880000 {
-		compatible = "ti,am654-secure-proxy";
-		#mbox-cells = <1>;
-		reg = <0x00 0x44880000 0x00 0x20000>,
-		      <0x00 0x44860000 0x00 0x20000>,
-		      <0x00 0x43600000 0x00 0x10000>;
-		reg-names = "rt", "scfg", "target_data";
-		bootph-all;
-	};
-
-	sysctrler: sysctrler {
-		compatible = "ti,am654-tisci-rproc-r5";
-		mboxes= <&secure_proxy_main 1>,
-			<&secure_proxy_main 0>,
-			<&sa3_secproxy 0>;
-		mbox-names = "tx", "rx", "boot_notify";
-		bootph-all;
-	};
-};
-
-&main_timer0 {
-	/delete-property/ clocks;
-	/delete-property/ clocks-names;
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	clock-frequency = <25000000>;
-};
+#include "k3-j722s-r5.dtsi"
 
 /* WKUP UART0 is used for DM firmware logs */
 &wkup_uart0 {
 	status = "okay";
 };
 
-&ospi0 {
-	reg = <0x00 0x0fc40000 0x00 0x100>,
-	      <0x00 0x60000000 0x00 0x08000000>;
-};
-
 &main_bcdma {
 	ti,sci = <&dm_tifs>;
 };
diff --git a/arch/arm/dts/k3-j722s-r5.dtsi b/arch/arm/dts/k3-j722s-r5.dtsi
new file mode 100644
index 00000000000..06a63fb83ba
--- /dev/null
+++ b/arch/arm/dts/k3-j722s-r5.dtsi
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/ {
+	aliases {
+		remoteproc0 = &sysctrler;
+		remoteproc1 = &a53_0;
+		serial0 = &wkup_uart0;
+		serial2 = &main_uart0;
+	};
+
+	a53_0: a53@0 {
+		compatible = "ti,am654-rproc";
+		reg = <0x00 0x00a90000 0x00 0x10>;
+		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
+			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
+			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
+		resets = <&k3_reset 135 0>;
+		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		clock-names = "gtc", "core";
+		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		assigned-clock-parents = <&k3_clks 61 2>;
+		assigned-clock-rates = <200000000>, <1400000000>;
+		ti,sci = <&dmsc>;
+		ti,sci-proc-id = <32>;
+		ti,sci-host-id = <10>;
+		bootph-all;
+	};
+
+	dm_tifs: dm-tifs {
+		compatible = "ti,j721e-dm-sci";
+		ti,host-id = <36>;
+		ti,secure-host;
+		mbox-names = "rx", "tx";
+		mboxes= <&secure_proxy_main 28>,
+			<&secure_proxy_main 29>;
+		bootph-all;
+	};
+};
+
+&dmsc {
+	mboxes= <&secure_proxy_main 0>,
+		<&secure_proxy_main 1>,
+		<&secure_proxy_main 0>;
+	mbox-names = "rx", "tx", "notify";
+	ti,host-id = <35>;
+	ti,secure-host;
+};
+
+&cbass_main {
+	sa3_secproxy: secproxy@44880000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg = <0x00 0x44880000 0x00 0x20000>,
+		      <0x00 0x44860000 0x00 0x20000>,
+		      <0x00 0x43600000 0x00 0x10000>;
+		reg-names = "rt", "scfg", "target_data";
+		bootph-all;
+	};
+
+	sysctrler: sysctrler {
+		compatible = "ti,am654-tisci-rproc-r5";
+		mboxes= <&secure_proxy_main 1>,
+			<&secure_proxy_main 0>,
+			<&sa3_secproxy 0>;
+		mbox-names = "tx", "rx", "boot_notify";
+		bootph-all;
+	};
+};
+
+&main_timer0 {
+	/delete-property/ clocks;
+	/delete-property/ clocks-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	clock-frequency = <25000000>;
+};
+
+&ospi0 {
+	reg = <0x00 0x0fc40000 0x00 0x100>,
+	      <0x00 0x60000000 0x00 0x08000000>;
+};

---
base-commit: fd871fc6bb497c6ddd7b39622480b89add78f57b
change-id: 20260122-r5_dt_refactor-4535f5177593

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

