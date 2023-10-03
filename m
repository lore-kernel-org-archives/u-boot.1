Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9CDE8FDB4
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 20:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE9F886DD9;
	Tue,  3 Oct 2023 22:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="yFgzWvmj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C142286E47; Tue,  3 Oct 2023 22:27:03 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65A2886DD5
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 22:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UW1KJ4BbbGcwkjy7iypx5IAHLRVDPRAE74ZDj0L20TZB+KsP6yd6TeUJ0okuM7WjgnJ2f3YWJPTgHk34Kx1dx0o5qEsRw6SQRUuqDehD2lIXGB2dsg06+5fpJdVvWLNHz9o7/clP4NcrmSiRJfrGkhF/ixnKP2GVDuoX2whJOTDdVddSl0s6BswMaCm6MSJJjSB3ljqTdK/8P1IJhmw0ZBk63tCoSiNDrTwubnVWXDWGDmfoe0RO8RJD+l+l/QOl2xlqeXeOGLDFb2xiA0mcX0VtnhfBJ6lWe75QWwstGXFkVCjUammR+nU9/6KmUv4dCGVhk9Nzhuuyy+Ouf2mb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRtc3PuYnGfXOxCaSwAmQFp2qwBVrbO6iiS5C8alFLo=;
 b=ek+RVFDZM2PJW7gjEXAcnQiyQgVgEZ7+h9k+qLmp+h1MP1zy5HnYiq//MgCBcmguEVrlQceS3A9RDcDBLSiUy44USDH2PVjEESjNtjTlJtYm2wItgejj0Dw+r7k7UeAaZTp/YbTcpHgBlHclmi/5ujbxYzgBKXKEQqBKoNJRiXl9q5+4An++9imH0Z6fclzQIRdMCHTSPkxIRj9LalintJ42UXKIq5YhOTqjY2RVsSkJxmd6KaHAVf7FmGXqpW5VKt60KHznXGi3KKa54BXdmb/aUXDffvEXl8Ms58Ph1V1bzmxKFZyEyQX9x/+GzjBKqy/vloydhbwv8hhacdvKFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRtc3PuYnGfXOxCaSwAmQFp2qwBVrbO6iiS5C8alFLo=;
 b=yFgzWvmjvDIG0oSv3+Cnv7VrXrbjFvRLQyIo1Ucrw1ZGRKkF0fS80OhKc15e57UQa/9T4s/oX8bLW5okp6vSDaXzcfkEAbir6MGO6Pz5olLzGgxQnBIqwZSbA/vc3moXuNQvZq5p0XsUcs3V7ShhywBG9sNLLl5/B72hOnAGWUJIJsk2ydHY79N//VcP0v44t5PNY14ht9ejGbX5CuT3ePYvXeN17bQb4e/1X4/EO+h0y+ViEtt2T/HEwSMxUiJqxPrlGwJPR+xVWZh1AoIo9ph/oHyIP8rX7u1IH532xretz2fnyeoRN4+1RsZbmsYP4KvLGKDBLKGmVOoTTt5JJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3671.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:131::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 20:26:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 20:26:59 +0000
Message-ID: <c430c549-6c6d-4d32-a51b-e2bfa597bd4a@siemens.com>
Date: Tue, 3 Oct 2023 22:26:59 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] arm: dts: k3-am625-beagleplay: Fix boot
To: Roger Quadros <rogerq@kernel.org>, trini@konsulko.com, nm@ti.com
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de
References: <20230929134646.214781-1-rogerq@kernel.org>
Content-Language: en-US
In-Reply-To: <20230929134646.214781-1-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3671:EE_
X-MS-Office365-Filtering-Correlation-Id: c2153cd0-9715-41c4-79d4-08dbc44f1898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8wlUK+GVN1rdcMqrLUDa8gl9zovRcovTbybK6lkQLFpjjKQ7zSZaFzw4MaeBJQ27uHJ3NjS+OAa9xMfDrZ8M0xlwlDz61ZuQTT1WWhkRj2S20DYPM2T87+9OipSTKsdXly0Ch23sHz4mZP9nmJHMindFjqTQl8xhomE9jklV1ToljJ9Lwix9EMvhOOFOAgDGYJLtI/+kvIG+u0iCA5fjsA1VxKU9AkI8nrgIph/xZZrBlLgEQPkZQ6POHKD9jMV47ZJlBeyMLegcazn6uAwuztwjiLxVk4f0E0IpE1Q4OJnktlw3oXTqEUA2KfAP9XIV6VTRzGzj2HgNAsipsPbbSyd6T7rQua6zsOrTq/in7g0Kqn/VR7s9EVNz+BwU/jiJxq2QRVveF133UWlKAcnPRkzB+oSLedqvw35HjVRosGUAY2mqqEzzC1Jcb0RIzrCL0ASjsZTmzXudd9YpDxHM2Vn1B/YijslyLmZqTPxQaFvtBoZ9rvpassjYq4975E9Wrbv6EbPxwiDJb84QPbKp9UGe8Tl888zIGmd7mCYErJf/Oumqcx8cpng6DocuZ9zn7VKMqHzQEhFWptZpNdOvXqtUZDimTLeRC2cr9NWEMnlfsH8JxFlnK1C/dvwNdEFuBGfFTIyK4Sf2WTjgs9Zvxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(83380400001)(7416002)(38100700002)(31696002)(86362001)(36756003)(82960400001)(66946007)(66476007)(66556008)(6512007)(6506007)(316002)(41300700001)(6486002)(2616005)(478600001)(31686004)(4326008)(8676002)(44832011)(5660300002)(26005)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDdJZkV1Ti9Ga3FTdEpiRXpteWRXbEtXSU53dHdqcGxxSk1aYmNIV05hd3Fn?=
 =?utf-8?B?Wk1aSnpDbDZoNTFLY3pFV3I2NTVTVG82QWpFT1laRGxWdHFkTDlXbzFubHVS?=
 =?utf-8?B?UXJPQ3Jic2tqSWg1eVlmOUducHAyMFVXTVJ4anNNRGlNWkt1cUtnMCt1YzJX?=
 =?utf-8?B?R2dZT0JNUW90VTVkMEVkY2tXcG1CMm90eTZpK3hubVZ3bzUweTlZQjR2Z1lC?=
 =?utf-8?B?MFJzOTJZMkNTZ25Wa0pPb3lqVUNUVXpyUzFtR05WaFkxTW4rakdwRHBndUJC?=
 =?utf-8?B?WFhvRGM1cktNUHdnUXgwWFYybHQ0OTVwRUlORjh3U0NDNWVkbFpPdGlTQUQ2?=
 =?utf-8?B?cEljK3RnZ1hLSTVNK1lMdDRNZUJkK0NxY1ZyTUVQRStKaGNLaTVFL1hCWDlI?=
 =?utf-8?B?ZnBhWGE4MTh1U2EyQ3NyajIvOHFlREcxUnpxSFJyYU1SaSthQStKSEIvWG1p?=
 =?utf-8?B?dlNQNWx2Qk9mdkZuYlpzU3hDdDgrUVI0VTZsdWoyTmE4VU5pdmx3aTlFZFNy?=
 =?utf-8?B?TG9YSHBGVWQrOFIvSU5LTStmQWdJNWNjbkZJMmZZMTVuMDdqd1pIckUzWnQx?=
 =?utf-8?B?TFluci95VnF6L21lc0NiVHV4eXNTR1g3dHRzTTdYUi9pbmRWclg2dkt6aGRr?=
 =?utf-8?B?WWFOYTVQWThBRGdSYVJpVXhMZ3kxaS9RWTlEdEdCbTQxY3BMNVZZcnllcWlG?=
 =?utf-8?B?VUJYMldyMDhqM1JjNnY0djZMYXZhT1hOZ3N1Zlo3SEJGYkt6a1lhZHZ5V2gz?=
 =?utf-8?B?VkJLOUwwZWZoSk9FTk5ISStmMzJ1RFBsYnAvcVNGQVl2bGtMcTJGTGFSUDNG?=
 =?utf-8?B?Wmk2SGVSM2VTNlZSUEdGV2JNQll6MHZoR2h0cXRJSUJZNjlvZ1lDZjNuSUM3?=
 =?utf-8?B?bGdOdURUZ3FEK2RhVmk1b21VZDBDSUtTZTVEMWd5REFCWTV1NW5GUGMxOUcw?=
 =?utf-8?B?WWRVeHRjK2t5SmsxU082QWR2WStUSjR2Ukc5VE42K3F3T3QyTVNnZmNnZ2Z0?=
 =?utf-8?B?aE9waUlmQXhNTGU2MWVnZ1d5c2l1VHhidGVCemtyZ01kbERXY2lGbkNYRzBN?=
 =?utf-8?B?cUFVY2h6MDZQemVTQ0l6aGl3N0N1K0k1TXpHaGNTYnFuWnEzVS82Umc5YmRG?=
 =?utf-8?B?NjN6cDRxbjJyY0s5WmMyTXJTYVBRcGt6R0hHdmZsK0x4cVcvQ3NrUzloRkVV?=
 =?utf-8?B?Zk52OFV6aFFIb2JLQkdrTksxOVdqVjBWdHNyWWozTlp3ZHNLZVV1TGpNUGpB?=
 =?utf-8?B?bjQ5K0hrTU8wTFBaMDdmaXVPNW1FWjl2MUdoSWhKYUttWlUvcU4zK1dPNkhh?=
 =?utf-8?B?TWNOMUdqdExaalh1VitWVFJSYkdYK0JTYzJsMS84NGsxeUNCK1ZuZWYyVzdF?=
 =?utf-8?B?VFVITnYvUE1HQnBhK3laQ2dScjRrZTJ2d2VFNzNWZWJEa1pzb2Fmek52RGFK?=
 =?utf-8?B?VUdTd092S3J3VFdyMGc3OHhsVjVaRDdYZzNBZUw1WjF2VTUvWktZKzV1TGds?=
 =?utf-8?B?YVNBZDNqR0lPSDRiUEZMVjY2N0MrWXlRS0MyOVBPb2JlSzVaVjc1Um43ODhk?=
 =?utf-8?B?cGZGdFpid1I0SjJBalAyVmFBVmllN2xMYjNMOS9JYkl5dkZBUEs4K0FxVnpw?=
 =?utf-8?B?M1ZxL2s5eWF1UmlrSUdZcUJsbUlJUnZmRE52VmFQREdzK21ZVGpaWGp3c29U?=
 =?utf-8?B?Z2E1VENNYlFVTTY5VEFRdFhMM0czdlc2SUdmZkkwdVZiRmE1NU4xd1dsOXAx?=
 =?utf-8?B?eVd2TVhlVjhVMDZyOGsvMFZ6WlRXZWIxT0NOa3pVVkVsU2dGUEh2clFNRjNF?=
 =?utf-8?B?WTAzUW5ldnQ3anBBWDhXckZiS2tCSXNmQkhZZE52ek1SMFpobGhrUVhmbE55?=
 =?utf-8?B?WE9pNlBDNWt4VmtMNEhBMHRrSmhLdDBoVHV3MXZpOVhISzVPVDVKQWp2TXAy?=
 =?utf-8?B?VG95V09VVjhEY3lsQ1RyRVZ4OE80UXAxOGdDb05zejF3elJMNTZuSDhtTFdE?=
 =?utf-8?B?M29WQlRZa01tc0l0VU1KN1JseFRDeE5QZU96akdCM0xPZnRFOE9mWGZPejFR?=
 =?utf-8?B?SEk3WHYrTjYrRTNJUldQU1oyNzR5aUVQQkF0MEptZC9JRk1pL1JRK0ZDR1dh?=
 =?utf-8?Q?QsNoWBFceVbEnphRkcaMamASE?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2153cd0-9715-41c4-79d4-08dbc44f1898
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 20:26:59.8130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+W19ByKkzZPYrfU3XsJSJAD7xs/UbsvY0eI/eiUyThHHe3SR6N96j64Xm915nr165/bQsOIzgBgWYmdkjlMaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3671
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

To fix this we mark all nodes as 'bootph-all'.

[1] 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This may overshoot, but at least the board boots again. Could it be that 
[1] broke even more boards?

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 70 ++++++++++----------
 arch/arm/dts/k3-am625-r5-beagleplay.dts      | 12 ++--
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index f8c04e8a300..d6c6baa5518 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -14,143 +14,143 @@
 	};
  	memory@80000000 {
-		bootph-pre-ram;
+		bootph-all;
 	};
  	/* Keep the LEDs on by default to indicate life */
 	leds {
-		bootph-pre-ram;
+		bootph-all;
 		led-0 {
 			default-state = "on";
-			bootph-pre-ram;
+			bootph-all;
 		};
  		led-1 {
 			default-state = "on";
-			bootph-pre-ram;
+			bootph-all;
 		};
  		led-2 {
 			default-state = "on";
-			bootph-pre-ram;
+			bootph-all;
 		};
  		led-3 {
 			default-state = "on";
-			bootph-pre-ram;
+			bootph-all;
 		};
  		led-4 {
 			default-state = "on";
-			bootph-pre-ram;
+			bootph-all;
 		};
 	};
 };
  &cbass_main {
-	bootph-pre-ram;
+	bootph-all;
 };
  &main_timer0 {
 	clock-frequency = <25000000>;
-	bootph-pre-ram;
+	bootph-all;
 };
  &dmss {
-	bootph-pre-ram;
+	bootph-all;
 };
  &secure_proxy_main {
-	bootph-pre-ram;
+	bootph-all;
 };
  &dmsc {
-	bootph-pre-ram;
+	bootph-all;
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
  &dmsc {
-	bootph-pre-ram;
+	bootph-all;
 	k3_sysreset: sysreset-controller {
 		compatible = "ti,sci-sysreset";
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
  &wkup_conf {
-	bootph-pre-ram;
+	bootph-all;
 };
  &chipid {
-	bootph-pre-ram;
+	bootph-all;
 };
  &main_pmx0 {
-	bootph-pre-ram;
+	bootph-all;
 };
  &main_uart0 {
-	bootph-pre-ram;
+	bootph-all;
 };
  &console_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
  &cbass_mcu {
-	bootph-pre-ram;
+	bootph-all;
 };
  &cbass_wakeup {
-	bootph-pre-ram;
+	bootph-all;
 };
  &mcu_pmx0 {
-	bootph-pre-ram;
+	bootph-all;
 };
  &main_i2c0 {
-	bootph-pre-ram;
+	bootph-all;
 };
  &local_i2c_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
  &gpio0_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
  &main_gpio0 {
-	bootph-pre-ram;
+	bootph-all;
 };
  &main_gpio1 {
-	bootph-pre-ram;
+	bootph-all;
 };
  &sdhci0 {
 	/* EMMC */
-	bootph-pre-ram;
+	bootph-all;
 };
  &emmc_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 };
  &sd_pins_default {
-	bootph-pre-ram;
+	bootph-all;
 	/* Force to use SDCD card detect pin */
 	pinctrl-single,pins = <
 		AM62X_IOPAD(0x023c, PIN_INPUT, 0) /* (A21) MMC1_CMD */
@@ -164,11 +164,11 @@
 };
  &tps65219 {
-	bootph-pre-ram;
+	bootph-all;
 };
  &sdhci1 {
-	bootph-pre-ram;
+	bootph-all;
 };
  #ifdef CONFIG_TARGET_AM625_A53_EVM
diff --git a/arch/arm/dts/k3-am625-r5-beagleplay.dts b/arch/arm/dts/k3-am625-r5-beagleplay.dts
index 9c9d0570592..ac5461a32c0 100644
--- a/arch/arm/dts/k3-am625-r5-beagleplay.dts
+++ b/arch/arm/dts/k3-am625-r5-beagleplay.dts
@@ -31,7 +31,7 @@
 		ti,sci = <&dmsc>;
 		ti,sci-proc-id = <32>;
 		ti,sci-host-id = <10>;
-		bootph-pre-ram;
+		bootph-all;
 	};
  	dm_tifs: dm-tifs {
@@ -41,7 +41,7 @@
 		mbox-names = "rx", "tx";
 		mboxes= <&secure_proxy_main 22>,
 			<&secure_proxy_main 23>;
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 @@ -55,11 +55,11 @@
 };
  &mcu_esm {
-	bootph-pre-ram;
+	bootph-all;
 };
  &secure_proxy_sa3 {
-	bootph-pre-ram;
+	bootph-all;
 	/* We require this for boot handshake */
 	status = "okay";
 };
@@ -69,12 +69,12 @@
 		compatible = "ti,am654-system-controller";
 		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
 		mbox-names = "tx", "rx", "boot_notify";
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
  &main_esm {
-	bootph-pre-ram;
+	bootph-all;
 };
  &main_pktdma {
-- 
2.35.3
