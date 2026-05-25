Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C01FCD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 13:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20C02846CA;
	Mon, 25 May 2026 15:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="hfWbGHZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E7E284839; Mon, 25 May 2026 15:52:52 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3DA9846D3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5MF1gIvYma3bnF1BXHjE3I1ZtLQfpTCiTJVCt3CH0n9A7izpx1wt+oqmNzaeHXtK5VwkYyLiiUXRQajA2NOTt1ILvtmbOCy3lNrGoYPlh28XGajUJ96dhAJB+qizio5IGR+zQdiTq38kQxdzQSFQNgcIo0f1446Q4whqzTJR0xowFBbUd/nvzMHW1tprp7NE8TfbhkXfqwzNIYfVxry6o4AEd19S61lKOibf8zz49rXY/KuQl+d5mTXpEWLDSVQwpDnRKNAXXXDp7shxaVbRBTAC/RRX9148qoktSaYXrtiSkjfu3BFkxhNlKHJRime5gxCDaw1gSlRuR98dZyCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/pZAFsBJX+KylLS/Jtfe7qhUFVoRA2t5iBuV0urBNM=;
 b=W/ycVY1HiBBjlVmINy7OVpbJq2tZDmhDZW1B2Y+yt0j2Ppo2UfTRe53Tga6fccza3HGoXmrb7p4zbTsWVuzQyXV0qnMt4iRXb4RC3tWdImPQxH4TmSck9Oumo3FPzk2QMs/bU6J93W510h0ah+mKdLEervsY/bCmwhv7cSvYygK0gYD2ecN+IwoG0sbHugbr4tOYLbu+VBG3eZek0BMirj1SIqJi9MbIj4ylHher766avRTs6POg2QMKYHLX4lPxBpcULlQmUsFRpeBsoQ4j2Ftuejp36sW7aiG018d2D9CruMjWBIbblBJPKosyjfKqI5NmIoq2xU44CHYyqexmPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/pZAFsBJX+KylLS/Jtfe7qhUFVoRA2t5iBuV0urBNM=;
 b=hfWbGHZQGq/gh7QKkhfNCGzDZWa8i480siGl15212PMo+kcPgxlGpxRoB112rLA1uYJdb5hZV6NAzW46v2MGIQhhNCqfM1YXbIworLVZb2e2XMw6EDHEaX/YWI4vFbPrSmQ3T2P5gP2lav3v0+RqO6rUxbpW4h36iDh56ssv4xx4H74zNawL0CfStHjEj2oMlItQsmoPAuxBHtmapc7rLRZUnv9FcNWiyush2+3ebGa0DspRbAgwemY2LmbBwO0K/FXcmbYu+QTUv1xJwojWLagB5nZKmKh/tFLZPf+eBJeKkp6Rv8XQmtGLMFpKW5RLC0d4W7AerFMyeHVflxjTXA==
Received: from PA7P264CA0317.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:395::21)
 by PATP264MB5304.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 13:52:46 +0000
Received: from PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:395:cafe::27) by PA7P264CA0317.outlook.office365.com
 (2603:10a6:102:395::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 13:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019231.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Mon, 25 May 2026 13:52:46 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 03AF220E7E;
 Mon, 25 May 2026 15:52:46 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 13/15] tools: preload_check_sign: add support of ecdsa
Date: Mon, 25 May 2026 15:52:39 +0200
Message-ID: <20260525135241.88348-14-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525135241.88348-1-philippe.reynes@softathome.com>
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019231:EE_|PATP264MB5304:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3212d108-4684-42c8-d268-08deba64e6a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|6133799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rSR9VNK25+X2dzQt473U3Vz7uFeNo+xDgS/+9JlBGKAnJh/eDuSgjTlNXs37j8B59dyda0Xa5ABsw8X5m3fSplZUlE+6UUquQY7WAvuMeKCJMRFH9e5+L3JoN6XHiuPKk9870nkN9kRDcObiA6rcQCzkNP9Zl19nmloWKKg7s4P/3O7ONf0WEUpkeUgBgHvo3GSLbh880/TMTuwladYh/WI9R7VCozj21ZPLU8cc8dfyQ0zaua/HnTPaUYeY4tJUR6C29mhI0fWppF/9fjFYerf1C6GfQ0d9+USZ6+O1PaDzE72BUmBumYN9sec9zQfVinaqdR39Kp3xsgiAAxm9vOQt2HNIfbzS009LWVCmjZT1w40YaXu2pdwP76mZgBJdTr7zFjFIDq5mviDxN6rVDGK+yRtyOq0nuCaKTkOuYef0Dvu1MsaiOTKJ4xRzYNzI+0A5+qDXXcrdGJgAvNLY/U7+AXqgpyP/9sbS4GSBR3HNB1zOjd7gQ9faKJaa9woQIJxtHHln3fYoLPu0bYmxifcf8avMg12z/+I2FgZML83icaXP/8uen4iBEZSG9sTS9DE/5i9LekYVUHNgB+ONfSYgJqN5B5o8miMLqcdhMKnNl1tyuFnBdg1y1YGbNHHG7rbPNaFcozrYaCek3xfWjqRkWXTQ62H7gZ2uIiN3ZIwV8iAXecL+BLqvzB9xIRs5EaYWTkE7yVk868jaSjYCnKMSo7LloxcqkNPm3sO0yYo=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(6133799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XjKeK/8Iq+4aulMWYVvI9CTrwVqU+g73lJB8sCjjd+7AcnAEkwnurT+5qfGs/pBDrC4b+oOjZqMi0/uz1sPfUlqiurJh1keKomJwfXtU690YlYThYZZ2D6VD0/UFU/u7ZMP4WBi5r4RyQ+FtkLx+S/hJfRJk+zTGKkox8O1BUcYihg84IiD2UGDOWujQe0SG5vjGpn0bNwizJw0NvH6m0h3MmnQim/2m7//karJjgQl9jiMizwi96ZuAdSafz77FhAx8TZ5yCykXKApv1huMB6oaP+yaXe+x26hDalG3VhMILtSBeAl3y+ruTesaNtpiKotk3KP5AB6MtNJbCe3PHuXMVwOi9EGCBeyF5OLg9K7RAigIbSXdqvtyehLer3eMgi/YL4p/680lkGeVUELUgScJh4W89Ct4TtnKGOJjyC9a4rgyZf+Q7rXwTojNN0f8
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:52:46.1681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3212d108-4684-42c8-d268-08deba64e6a3
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB5304
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

right now, the tool preload_check_sign may only
checks an image with a pre-load header with rsa.
We add the support of pre-load header with ecdsa.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- free key to avoid mem leak
- fix error management (set ret before goto out)
v5:
- add include ec.h, evp.h, err.h and image.h
v6:
- no change

 tools/preload_check_sign.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/preload_check_sign.c b/tools/preload_check_sign.c
index ebead459273..d94f0509e74 100644
--- a/tools/preload_check_sign.c
+++ b/tools/preload_check_sign.c
@@ -8,9 +8,13 @@
  * complete file. The tool preload_check_sign allows to verify and authenticate
  * a file starting with a preload header.
  */
+
+#define OPENSSL_API_COMPAT 0x10101000L
+
 #include <stdio.h>
 #include <unistd.h>
 #include <openssl/pem.h>
+#include <openssl/ec.h>
 #include <openssl/evp.h>
 #include <openssl/err.h>
 #include <image.h>
@@ -144,6 +148,32 @@ int main(int argc, char **argv)
 	info.sig_info.key      = info.key;
 	info.sig_info.keylen   = info.key_len;
 
+	/* For ecdsa key, we have to update some values */
+	if (EVP_PKEY_id(pkey) == EVP_PKEY_EC) {
+		EC_KEY *ecdsa_key;
+		const EC_GROUP *group;
+
+		ecdsa_key = EVP_PKEY_get1_EC_KEY(pkey);
+		if (!ecdsa_key) {
+			fprintf(stderr, "Can not extract ECDSA key\n");
+			ret = EXIT_FAILURE;
+			goto out;
+		}
+
+		group = EC_KEY_get0_group(ecdsa_key);
+		if (!group) {
+			fprintf(stderr, "Can not extract ECDSA group\n");
+			EC_KEY_free(ecdsa_key);
+			ret = EXIT_FAILURE;
+			goto out;
+		}
+
+		info.sig_info.keyfile  = keyfile;
+		info.sig_size          = (EC_GROUP_order_bits(group) + 7) / 8 * 2;
+
+		EC_KEY_free(ecdsa_key);
+	}
+
 	/* Check the signature */
 	image_pre_load_sig_set_info(&info);
 	ret = image_pre_load_sig((ulong)buffer);
-- 
2.43.0

