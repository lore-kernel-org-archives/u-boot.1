Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D80EE936F9
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 04:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A90F86CC5;
	Thu,  5 Oct 2023 06:37:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="JQmCdePZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F0DF86D20; Thu,  5 Oct 2023 06:37:24 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A39886B6B
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 06:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYTZX3Z/4DUGxnkjM4moXAqf0XlarJ07I4TSnxPuKTtuHHOQSC2xzDtjXKWShh4ShjADYQZNbkFkTfhGKTJYvxYYBkY5T5l/+qmOv655VLFBHNrnxPuULMD/28GkyjaV5VbSUNRfAsm1emZLimMs2kB/7BekVoe4Cdd8E29axAE64U3blON+6pgS/OQzdhJQZe0lNc3Fn03BJ6cJG3ZGJrTU20aeeE3k6CgRKEqsyISN/fjV4REOisZFxdR3GkNYrdTUjZnbLgt5+Q/saOidgSDSt7A/iKICx7g98ThyWP80y8tHd7hTPMQ+BAC6LsIHOaJyHeXHDk79KX5fniVFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8cN6oF1lRU1+B/hAJzjJ3s3ouCMuGBnUkaMAiLkZmY=;
 b=GVs88ZtRBDnyxPqmfSDpvo2m3UG22/kQSiCPdbq+RsOjAzhV0t6xJZoGNShJjNMCY5wJUQQXZ/uvhy/IW8SUVFERvtJrBtAXg7Qiee52YbSF8m55PuTb/layygyO8XwT9n3uelrd0Y4LyaFYfN3wuxPAlNv9c+ufrsMMdFdBMpPuyFrEClmh+KpFDT3qk5TnG2AvMgaMIy2bFIInGNeKKkewe2t2j38aKLikyq3e5mZjPKnZkPldkBHEyvkMEC2Vmyw98BQIlVTm5zdkbuoqQAKsnu7okV5yDQpvFxEnJ3xMJYbkqWjmEM8rDZ/4CBDM1GuuOc1OjOkUamv22ORwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8cN6oF1lRU1+B/hAJzjJ3s3ouCMuGBnUkaMAiLkZmY=;
 b=JQmCdePZG4gZAiZscUXUokzuCxKd/POvHA0jULe46GcoAKmtr/AYbkFwpTvkHqp7k6k3IPuxH7TARCBE06AnnBvqeMWgifKhwVHWbGwJSfvshcMob1GVFom/58QvrGOTsFZTzXYTNMDM/CuErfx4pUnpJY8adaPwfPdiGJDK4Bq3+L8dYkd3gMGrIolqKqGIw1YiVHMGADqvibe4/AkzPwWEPBXVqVLWLaVzLvLqSqLZposG8T4/Zr3q6paSANFptQ8boCrPU1qwhY8AA3d6oZZRuGMaw5IqxiJrUfTv4fCAwg8XWO4RJJVxomsp67y6BLVhFixiGG3xCy0u442Cyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5614.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:244::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Thu, 5 Oct
 2023 04:37:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 04:37:20 +0000
Message-ID: <3376a0eb-57f4-416a-b4b8-86cee769d6eb@siemens.com>
Date: Thu, 5 Oct 2023 06:37:17 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] arm: dts: k3-am65-iot2050: Fix boot
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 afd@ti.com, bb@ti.com, praneeth@ti.com, Roger Quadros <rogerq@kernel.org>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 64fd5e0b-3484-4669-0452-08dbc55cc338
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MGwiGXAfUnFzoFNq3zS5qrJT9oLO1mzLkIgUTrfB20FZAVyREYeVMJvKCx8jE+ira1SJrUvYFHn+7xp0IsADF9MxY7aszyDcXw+I7Q06fuXVWxspfZVb1o+kKpG+LilDOYsjOLVhyc+PDi3XWwJBtgM19+aZ65ZLDq2XqRh0EA3nOEGViMDY8PAJ7Fl3Vxid2wL9ME3PJEGdVGVu59kTycbU2+BRmVxNXvDgRAdztJD4MLdapiiWJ+krmTfKSSRS0buBTOpe7QKOdTLt9c1rEg2/d9zCzfp6/fH9VbL8RbIxPmgcnLN3Ik4nWXH8bBg/bAAAGlorLfh0+bBPPtkPyjRz7v+PtiMcvB6buGw5qdU2GNEaiytE1Fy2PobUFt88Jeu/eG2+uw1/K7uAr/1imvOeAEcLbkYIH9zUvIfMkKeHGRKI4olAQdRGT++/8p84e2BMB6szQXLWTAnEFt2Yp4bc2/NXWNzhX7e3+PpEKVU6m9ZEKpUug+B5ghz72jbRc+gPs2WKQCqB/ODJljXwpkarth99u/36e2eFdUI9kyEa2EeSfUZ55C1gg1ia3UZv7cpZ1ZrXNdgcM6q+O0s5cHoYW40CH7PbmtlxJOK2e2FfoIKQt9Y8UKDDuVxzarKhcLExtj6Uhav/lIp0u8LdzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(31686004)(7416002)(44832011)(5660300002)(8676002)(2906002)(4326008)(8936002)(41300700001)(2616005)(316002)(66946007)(66556008)(66476007)(54906003)(26005)(6666004)(6506007)(36756003)(107886003)(6512007)(82960400001)(38100700002)(83380400001)(31696002)(86362001)(478600001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDRZSTdqeGRJVG92VkZyMzkvbE5uZnUyUjBiU3NOSld5ZkdLUGgxNnFzd0Fa?=
 =?utf-8?B?V05hT0VGSkcyREIra2szbEYxVXZ4YTVXR2lvWjRoL2dTNmk2YWtsY2lKdmN1?=
 =?utf-8?B?MzQrZVRCMzNVclovdGpSRFdUaEwyODdpNlNKUThLYndOVE5GVXpSTUxmbkQ5?=
 =?utf-8?B?RHF4SXBIMHJWdVJxM3dQd1dUWlFjeTJmd3BHRElyZFpKOW14eTJjT21pNFZM?=
 =?utf-8?B?RnBjdGJleXBtQ0xUMjgydllheXFOcUlQL0k2bGZqVW1Ma3JTQUZPVERuLzFV?=
 =?utf-8?B?ckgvWDFKNFAyaS9BM09SeTdURm5ReXZYc2I3WnpnQUhPT1BzOVROZ0wwTzZD?=
 =?utf-8?B?RDRXNjJSVEZxNngxaUsxK2JqcTVPZnZXa1ZIVmdEaVpKZW1jR2x2SExML3pi?=
 =?utf-8?B?WVlJTFdWWmkyVWZlUVQrY0J3c1lEY1hibi8wVjZkZFpTdG1PNVBuTDMyTXJX?=
 =?utf-8?B?MTlQdkZpWnBkZ0krZ1hLUVNLZWpOU1ZBbys2UVM4WmdzUXdUUGM2VmV0Vjcz?=
 =?utf-8?B?T3pHRU5iL1B2RER4YzZxd0dKakFQV2JjeUhVS3pHakRQQnQ5Y3B4N2plRlBy?=
 =?utf-8?B?SitwcFErdWZsZEl3MW9lbEgveFZDd2w1YkFlblNPc2R3RTN2bXZHT3N0VXdm?=
 =?utf-8?B?NkZMdXFrdGp0Qk9wRitWMDgwR2l3eTQ0RGRKMTN5WjRBU2JOMmRJbm9ROFJi?=
 =?utf-8?B?NW1LaE5MZ3FmOUpOYndmNE5PSUZCUUJEeVR0Q1VTd05iaFB2OHpPYUlGbTBs?=
 =?utf-8?B?aFMyaUtXK0ZYa0hhdHZNQzNIVVQzRFl6YzRtNS9QTjhiTWVkbzdpTWpWV1Nt?=
 =?utf-8?B?WmNnVVdkZE43cTBCMWZOb0FkVHdRQXFHZ1NsNWd6K2g4b1JnQkp0SCtjUXVB?=
 =?utf-8?B?QTRhemNyZ3BkRmlTanQ3c3BqK3UvN0VqTkFRb2lFdXRIZkVMWldPZVJSL1Vi?=
 =?utf-8?B?UEo1Zll0OS93YzVNeDVuelJ3blJvczE5aGQrVmhNbXRtSkE1aGNIRGtpSUJG?=
 =?utf-8?B?RlNGcGhvZlRrZGtVMGFpanllcUVZa2dVWnU1SW9kWHZ0YXJpdU9YZUtRd2hZ?=
 =?utf-8?B?dktjM2c1MkNFMGgycmFETnFDbFZPbGpqV2xIYkVlQytLVXZyQmRjODF1Wk0x?=
 =?utf-8?B?Y21GOVkyWkZGUlYrL0hkM0VkdVFwNWZlekUxaUxXTUZQMTVDVmJCVHRsMkdH?=
 =?utf-8?B?UEg2Rm50d1RTVkd4QXdCTWhWV1ZaMmM5c1B6cXFDcUwzR1dYbWErRDFNa1Z2?=
 =?utf-8?B?M1UwMmpxQWNJcFViemFKd3g2dStHcURIREdXb2VkNXpEU1Y3b29jTnpDUm5U?=
 =?utf-8?B?UVVvTHpFWGYzS2o2YUE0TDZzUDBwNWxiUUFQbHhqcTJGSW0xRjMyWG95KzNB?=
 =?utf-8?B?dHhabENnKzBoN0hkMVpIa2FIREY1K2ZNa29VOFozaGg2L1VVb283aWMwV0E4?=
 =?utf-8?B?dWcrNTZ4NXVnUElWVktxVG9XREtoVmNXN2krTk9ETEtzRUpkbEpuOE1JYjYy?=
 =?utf-8?B?Wm8xZlNnb2tDT254TUdMaUNSZ1d4ajN5c1ByRUVmQ1RYWWhPUFI4c3BUQVIv?=
 =?utf-8?B?WlhrOGEwbnhlTS9LY2hwVEVEclVEVnhJOHNlV0VSVUwwaHByMFowcXRBRitF?=
 =?utf-8?B?Y2RsckxJSllURWhkemhuQ1p3RmU4RFpxTzcrM2VDZDQxMFh6ajh1TWlwTVJO?=
 =?utf-8?B?bEpzRnB0WnQrcjZTTDdYRlI2ekRYRms1dFNWMGlaMnlrUFVDTUFjVjB1Uy9N?=
 =?utf-8?B?blFlR2ljdXZPRFlhWjhIOEhEYnRjK3FHSHh0cFpqQ3FiVnlIZXJTQlZmRyt6?=
 =?utf-8?B?Zjh2QVY5UDhDc2NXMmlvKzQ5UDM2TkZwZURXcThFMGRtSnI0MEJtMEFFTmMy?=
 =?utf-8?B?elEzRVFBTkdkazF1VWo1QWpvbVJja1VDa0M2WE11N2JLd2ZWcjQramVzOUZm?=
 =?utf-8?B?WXVqT0RoZlkvM1EyQjkzbXc4WVk3ZHlhQzA3bENWR3B0MU1WeVlheGNUOFNa?=
 =?utf-8?B?RThJckVGcC9XK0RrZ2FaeGttZGl5WndwU1ZxdDJaTDlMc1ZrU0dLOWJ5NTZR?=
 =?utf-8?B?SCtDa0FtUHNpc0llajhCb09MUEtGTlJXbHJJMnB1a3VtVDB1ZThRZThBQnl1?=
 =?utf-8?B?blZ0dXduT0I1WFFMYSs4QjZ4blZSN2oxZFBib1VFNTYvMVM2a2xrd0YxSC9J?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fd5e0b-3484-4669-0452-08dbc55cc338
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 04:37:20.7744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97IPFOUsuIpfbP4toaHi19HtTBphIMIgTqJDCcLwVlOakr+RCaU5a4Dg1E9wxGLQFe1yrqSFUt3nlsgaivkilg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5614
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Since commit [1] A53 u-boot proper is broken. This is because nodes
marked as 'bootph-pre-ram' are not available at u-boot proper before
relocation.

To fix this we mark all nodes in u-boot.dtsi as 'bootph-all'.

[1] 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../dts/k3-am65-iot2050-common-u-boot.dtsi    | 44 +++++++++----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi b/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
index 9fd64809a63..30fc7a78d89 100644
--- a/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
+++ b/arch/arm/dts/k3-am65-iot2050-common-u-boot.dtsi
@@ -37,18 +37,18 @@
 	};
 
 	leds {
-		bootph-pre-ram;
+		bootph-all;
 		status-led-red {
-			bootph-pre-ram;
+			bootph-all;
 		};
 		status-led-green {
-			bootph-pre-ram;
+			bootph-all;
 		};
 	};
 };
 
 &cbass_mcu {
-	bootph-pre-ram;
+	bootph-all;
 
 	mcu_navss: bus@28380000 {
 		ringacc@2b800000 {
@@ -75,70 +75,70 @@
 };
 
 &cbass_wakeup {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cbass_main {
-	bootph-pre-ram;
+	bootph-all;
 	main_navss: bus@30800000 {
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
 &wkup_pmx0 {
-	bootph-pre-ram;
+	bootph-all;
 	mcu-fss0-ospi0-pins-default {
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
 &main_pmx0 {
-	bootph-pre-ram;
+	bootph-all;
 	main-uart1-pins-default {
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
 &main_uart1 {
-	bootph-pre-ram;
+	bootph-all;
 	current-speed = <115200>;
 };
 
 &wkup_gpio0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &ospi0 {
-	bootph-pre-ram;
+	bootph-all;
 	flash@0 {
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
 &secure_proxy_main {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &dmsc {
-	bootph-pre-ram;
+	bootph-all;
 	k3_sysreset: sysreset-controller {
 		compatible = "ti,sci-sysreset";
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
 &k3_pds {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &k3_clks {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &k3_reset {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &fss {
-	bootph-pre-ram;
+	bootph-all;
 };
-- 
2.35.3
