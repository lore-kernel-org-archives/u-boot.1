Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB7FFF60FF
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 10:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21B5284159;
	Tue, 31 Mar 2026 12:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="FAt/s82y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6418C83DBF; Tue, 31 Mar 2026 12:01:11 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BAB3840AA
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ds4v8ez6wVTjj++GoRSphZG59CXdglKwhvGTjS5xVjRAN/2ShFJgjZF8Dc4GtWsOLxaLW67QgdTcPRIdr3mdLR1pAanyERFwaddVY/3+68yDzojeiw+kFa8t7xGJQthYGlq5K/59ooeJS/DvMSibDwBqcdi0qQn+umCf4cHO8SNsVRZwdE6VxF8L81i2doU/zun4eg8yqzlNFdOESy+kjANzbF1Qg1tnQlgViwNFCjxKYXN8bcNzjpSI1/b47hnuIgQg1TFiUIHBQfS/TLd47YURVXIbWGo1X34zHawEd4pFEcp/QXoTuTE+VboErtrtYE/VjeT6iM0wQqmEZz7HDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5f7OqhNUc3IUpW86XSRhfBWnVmY9+GufocW8WPBSjk=;
 b=EZvjKynncVy1sH3xXxNcTBmOkDMzIkSg1wj7HylVKgGEbChTYwvdj+MHnUW4kDSHgnMJWQiUR2s1CxZtYWKZ9k4rB9peFIrlLvpPxEv2LauDByg8W54hE1gKlfEV7gn6fAN4ThRWuoSMxsTPVPSa9e952pOVjFzszdyR4DCA5+NOeEsK7mdS0s2gsJ2AjBEgT3zBd6iQ2sv/ICkkUVhA/mpEGxz8tqU9B9HP2Ouwyq24/YKpoixwLF9SFRwaSRj7ZcXt2TWEPOlx09I72LqTZO0/4RldVKFyS1ucweZbFV467hUMIn0G2nPLE1IDwdlU6cQvF8Zrlx33TlAmn7UcbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5f7OqhNUc3IUpW86XSRhfBWnVmY9+GufocW8WPBSjk=;
 b=FAt/s82ya6yZrzP37pZo513a/qOT9OlsQz1Jd4MMtI55a/D12tFT8RO5dHcIKDL6h4qKbMaJ7XaGBUdGVe0S47LiN7Py3WTZLdL3b9QeeXJv1HMX7OwhwX2zV5BENXnfrIUf5S1vZLZl9eWnX//2Ar3F74iCHhsvsFjF52XIqPkd/hHsT9/O8Wpv8DtqZ+f/vp3Ix4xQ1IfjS2RM+OBd3i7fh0wKntseQbEwatE2hddVLd+AVermGNjLIMh95gUo5GBhB5hjs1ZmR4LNJnxW9HL8V04nWtJO94dlH9Y/sRbjQcHUcSdLt9Luv3L8FSrK0KcEbNkuEI9AGvhC6fr9GQ==
Received: from MR1P264CA0161.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:55::9) by
 MR1P264MB3410.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:26::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Tue, 31 Mar 2026 10:00:53 +0000
Received: from MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55:cafe::bb) by MR1P264CA0161.outlook.office365.com
 (2603:10a6:501:55::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Tue,
 31 Mar 2026 10:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D59.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 31 Mar 2026 10:00:53 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id 57D052092F;
 Tue, 31 Mar 2026 12:00:53 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 12/15] boot: pre-load: add support of ecdsa
Date: Tue, 31 Mar 2026 12:00:44 +0200
Message-ID: <20260331100047.34618-13-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331100047.34618-1-philippe.reynes@softathome.com>
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D59:EE_|MR1P264MB3410:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4d718cf2-013a-4b51-02e0-08de8f0c6562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: GAQ9rdpp5SZbLKruxOjV56Fc0mZC4kr/ag0JpRRIPyTkbVaiiV28ToDzM2CMU+OG2Mc2H81APY3V44NsOpHCGh0SV6d4a0PlICNljYPHyVoHgcZ54/sv8uWf5hH8bEwL0VQi95rxl/GFYdjHqt34anvUSJjR+naqmD9CC+VMDhsFVMUnNO/++aDGRzqWK6S92ujIFp+I+rgDRVDGml1XpJbI+C1OW9H6HoxpabTvVbvWJkrJ081dBu+EYClVvzXlV031QUZWiLPWPPKl37pH8cPMBxNeH4XnskbEbJXQEGscLnDCPBj2cGi16yZ28kKGQ+VS99m1KJAu8LXozsXkYXqpF0ipsAaSDA9Knn8kDubOcMxFhYsBFBjdYIPWmmEJ4beXE//WZ8wiq7HtQJjEv4CT5tXNSFXUYvPp6oWQgTqJsa0wZmh/guVnTD/PFiJSQFSuuaSJ+sldyH2pAXR3EgIqqQ3cYblDz4rE/JmKV+HwjSIY9XolvEo+U5tOGiMf3UZPGK49ajkQf3xcq/FMRi+/lWFEzXbKfOeZbenZM6M1O3ioniLr3iMW6avZEvXpxBqvxkVks8KVxKsfpBAqE5AHdxtYw5/DM1pB2u2R5udBmXxYGGGaRUZ+pVxtt3fxtSzQvvr9q+ODef4uDfO0SyrbwCbuvncHueZVu5KWJlcCqwZhwrT4VwofKF1XIa/QUlf/JJD7SccskrjSm8bj1vZZ8J5KDWpdSCr5Wc3mjiMI6zy7YI+jR7VBowOfCisnanNQeVwaxH4XPHa55lLPBA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: guHFnajIbywg66YazX2xRufMuVEPNrSHoicf17U1gSI1nBiW6eOJrNuhzN1xvkV8MVRDByKmdtIHJx1HnbpSZsGiwSvXuzQfdNMTxE4pmJAwWLCXdowI5gbENx8vweZK4IMotBlZZQMyOQLk72B4jKrI9Gkb2qsHy9gJg5N5vQZ/Uep5ut1a4Jxtp5HFNpCljLgM35LEMaKh/CSZqJige8QOZJtHxmcqOEmq+qrRwJ8WCqPNMyRcaRFRrlDatrqsptKLYKvZMGIZuVV/KqjsbYhk5ZMCOTI334soJQOOGgpDVykZQiDct1Ooyqx0NQ0mwnoAdUG4gGYPCjHBvaG1s9V7Ix6wcaukF/TwQOq1WUJJ+mIny/ckf7BJief7f+CDnkFInqO5mM4yvzZATdqk//ZoQhQ47ot/05GuvRFPkPpo8lPyLMvFH00G/DR8h0SW
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:00:53.5812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d718cf2-013a-4b51-02e0-08de8f0c6562
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3410
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

Right now, u-boot can only boot image with a
pre-load header with rsa. We add the support
of ecdsa.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version

 boot/image-pre-load.c | 48 +++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
index 2f851ebb28c..73d740c4cf2 100644
--- a/boot/image-pre-load.c
+++ b/boot/image-pre-load.c
@@ -70,6 +70,18 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 	return 0;
 }
 #else
+
+static int is_ecdsa(const void *algo_name)
+{
+	struct crypto_algo *crypto = image_get_crypto_algo(algo_name);
+	int ret = 0;
+
+	if (crypto && !strncmp(crypto->name, "ecdsa", strlen("ecdsa")))
+		return 1;
+
+	return ret;
+}
+
 /*
  * This function gathers information about the signature check
  * that could be done before launching the image.
@@ -114,11 +126,16 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 		goto out;
 	}
 
-	padding_name = fdt_getprop(gd_fdt_blob(), node,
-				   IMAGE_PRE_LOAD_PROP_PADDING_NAME, NULL);
-	if (!padding_name) {
-		log_info("INFO: no padding_name provided, so using pkcs-1.5\n");
-		padding_name = "pkcs-1.5";
+	if (is_ecdsa(algo_name)) {
+		padding_name = NULL;
+	} else {
+		padding_name = fdt_getprop(gd_fdt_blob(), node,
+					   IMAGE_PRE_LOAD_PROP_PADDING_NAME,
+					   NULL);
+		if (!padding_name) {
+			log_info("INFO: no padding_name provided, so using pkcs-1.5\n");
+			padding_name = "pkcs-1.5";
+		}
 	}
 
 	sig_size = fdt_getprop(gd_fdt_blob(), node,
@@ -129,12 +146,17 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 		goto out;
 	}
 
-	key = fdt_getprop(gd_fdt_blob(), node,
-			  IMAGE_PRE_LOAD_PROP_PUBLIC_KEY, &key_len);
-	if (!key) {
-		log_err("ERROR: no key for image pre-load sig check\n");
-		ret = -EINVAL;
-		goto out;
+	if (is_ecdsa(algo_name)) {
+		key = NULL;
+		key_len = 0;
+	} else {
+		key = fdt_getprop(gd_fdt_blob(), node,
+				  IMAGE_PRE_LOAD_PROP_PUBLIC_KEY, &key_len);
+		if (!key) {
+			log_err("ERROR: no key for image pre-load sig check\n");
+			ret = -EINVAL;
+			goto out;
+		}
 	}
 
 	info->algo_name		= (char *)algo_name;
@@ -155,6 +177,10 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 	info->sig_info.crypto   = image_get_crypto_algo(info->sig_info.name);
 	info->sig_info.key      = info->key;
 	info->sig_info.keylen   = info->key_len;
+	if (is_ecdsa(algo_name)) {
+		info->sig_info.required_keynode = node;
+		info->sig_info.fdt_blob = gd_fdt_blob();
+	}
 
  out:
 	return ret;
-- 
2.43.0

