Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413D1E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5A0680214;
	Thu, 12 Dec 2024 14:37:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="g/f6pjyf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7A548027E; Thu, 12 Dec 2024 14:37:19 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2B9F80212
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 12 Dec 2024 14:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnUzqyPZxsughpgM9k78QOld17zfypj3BLV0RvUrMBeLkcS8xozRtzrwGdcJE5PWkRL/F9WxJ4QKkhbS+K/seXXNtk82z9yHqItu+rxhHB/mxz+lzIW9rMtfZT3p5roqMfCB8hG2cDol3nYso44f9NxCkFt+18ZE3jTF/OTo9Opz0/l1m36pGO8HjDfVPQocybR+rF3nM1nuhvO0KQlVwe/HQbT7AwfbK5/yZH5YbJogFw4qduXYgoJplODF9LqW1Wj1slv4pXwMXNMlxHbqCh7nUkXwwKiAIYW++d/jUq654PGpOJqaMUby5shghQJI2ByyQ0UhScltlsMzAsAStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsl01PiwG3QVmDecj0CIOA0MrHmvon1wbejcCpsogCs=;
 b=Pla81eZcC+CQyFjbPq7SqA7wOOOs0T+BoH/BnDJNgVKTxSn61KYvCrpHYQXPsjUdBqUIE14RQqsJNqknSQDiRDNmJ8+p/YxflfczzncyeHaJzgYU4YkxFhCd0b6EkFzmttHF4TzQN60WYo0Xlryn22MiUCLtWLgTUEQbUJ31Rn/AB2X3GVn6pb3oeECEDB/3ITDezmKaQb4YE35V2HJkZOfMIsblJfrd1CMX/sT4J8GOPF/mguMz0yVNFAY/3nSyiMIpXD5XUodaP9419A/m3ZVRZfO5REuQv/blNgzWoTv9EvrhPYzdsHi5Lbe5Xle/tZHzAcz98klK8Rv10ea3cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsl01PiwG3QVmDecj0CIOA0MrHmvon1wbejcCpsogCs=;
 b=g/f6pjyfa7ebGDSvK0Ss+SnyWwMoN/3UrEuxnFQahxTwYFPXGVinHvtXB+bhhFTypvX523CqkKOw20NqdgXcja+JVbzQb9htgr6vYbRdRmqG6WRju/a/+yPFRZo6KnoGRh5aRU5Kh8iUD5MLi5dRmR2r+Jf+wfCcf85yzZzlR8mDGlJUnhL4xa4c2CytpTzPnOY/vIZNGnTJyFC95wmgoHXJN+fns9IBNZxL+3yzGHbuPtTUr2koJopAqWvYBhR4p6J60eU9dUuxIk+UMv26E/yEaI/hngcwqI4Je3nyVro7sLFOpsvSGBstKyCSyOIGXRU8B+VJM5jyGt3TvKaEcw==
Received: from MR2P264CA0036.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::24) by
 PATP264MB4630.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:42a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.16; Thu, 12 Dec 2024 13:37:13 +0000
Received: from MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:0:cafe::d8) by MR2P264CA0036.outlook.office365.com
 (2603:10a6:500::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 13:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D5A.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 12 Dec 2024 13:37:13 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 66CCE1FE96;
 Thu, 12 Dec 2024 14:37:13 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 5/8] lib: sha256: add feature sha256_hmac
Date: Thu, 12 Dec 2024 14:37:07 +0100
Message-Id: <20241212133710.172404-6-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212133710.172404-1-philippe.reynes@softathome.com>
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D5A:EE_|PATP264MB4630:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 414c9147-9739-4bf6-8f00-08dd1ab21648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?34svXYOl3Rm4t6Tcq0fOpFCOOjs7Al9YHJ9Ed6e0Q2mCHPRsuKPBBaUsBfhm?=
 =?us-ascii?Q?sds83efQy1rTwjPYCoXbLB3mQpW6SMUx3NzpIwzMZVTPxX6aI4nqW2gdTXX0?=
 =?us-ascii?Q?vo/N1oIAZtNPeIRhbqb4ShyBVQOkxkRDdq0/6KT/h0OvAIHvqJIDa85ieKj6?=
 =?us-ascii?Q?U/7HgfIEI4u3c0gAv9UV55gkgN5nEjTwZv5GOtF3iCk+lrT0vKtknBomQJvX?=
 =?us-ascii?Q?SvDRmm3MFR0F63DJaO4fA/9SODTyeBqBPIqpeGT3fjIw0zJwZCsp3jnYUbA+?=
 =?us-ascii?Q?5WxE5j3e4ZnJO7xEmpedlr3AlWq/H5GoFe3EB0R1MH2BXAUSVA7G31KYLgBn?=
 =?us-ascii?Q?o2qYfVkqywdXo4A7PUesjmF5RA40CpJ0NsxOFQxgYn3d9wZLj/ahv9Qo0Bp5?=
 =?us-ascii?Q?kv1WXqTkHLROFaNFMunhU9ARoYOP4mda63tziDg670sFcuEirxUqyVI7DHwF?=
 =?us-ascii?Q?7/OO5riCsT1EzUAVogjb2qMIdhOOYPYjx/Ye8bh7XrtW12AAdT3gdNVPG52F?=
 =?us-ascii?Q?HknVBehNHUdS1qZBF48MqCDCxAIw/+nKkollBBS7/uOSAujce2+WkkUUgVo7?=
 =?us-ascii?Q?Ha7p4bld849Z6HgTPEua2kkfxjp5QwpZZ+NY3XDYy7DevD3c/o7Ex6xDQ10F?=
 =?us-ascii?Q?w0IJFUVTsVLB1qM4Ns3hEidDAlgywAU6hA4mzSsjn+P2pSOyNBv7Tx8gfxj8?=
 =?us-ascii?Q?ONZYdp5fU3wlXtqhq50iOwIH+hNBUNF5mOotYcHhlLGHY/yiWeK9sT2lVw1x?=
 =?us-ascii?Q?TvQcnAzqKdCkvpzgGH0goSo1OFcB70WnR6aeRSjycPmKwPzcpTxZzBT21ZmA?=
 =?us-ascii?Q?XpFwCbgJW0+dQgCtaVcj0jVdiUco/1I36lXcs28pjmw1tIcqk6W0DgqPrUOx?=
 =?us-ascii?Q?IH2IhCcA8swmmJhPTGbTv/maxzwuTKoRt5kYM/Pwx3heVQpjQGtIC65Qfeg8?=
 =?us-ascii?Q?rRiW2Rkow1B1ENfPN8NxcpnkuidZjUIgUMzDHlJUGZXegHAIbd4A3OqH6iil?=
 =?us-ascii?Q?MbKE7LCNxxP/ebHx6oMhAUgC2EoQWcESdiP2A1YP0PrapAgHJrQ2Klsmz5t2?=
 =?us-ascii?Q?I3iBrbkJLV4KYXCSOEaLleAIKPeZP8bmkJet0xZ4lvcvchLIT1t1AwzKvecs?=
 =?us-ascii?Q?Kb17HX5lwLofDeHirY+82BGdMt9ycDDdrPzD3MT6J5n88J1ZqrTJkk1l8ZHw?=
 =?us-ascii?Q?GRsmg7k9k3soX18Ijv59PaEvaFV15ml/YnLn8mCD2uy03qJOPDiI1ODu7SQo?=
 =?us-ascii?Q?0n8mKCyzDE3Lbg6CgH+qviviv0ej+9TKGpCJdXv3ZFBnb2W2ZLIPPaOmKio2?=
 =?us-ascii?Q?U0q1kopnxWUvTqNNF/Ebvp9zu5zZI9CXcORIPfH4WdjvpqNHV3J3Y7jJpLb3?=
 =?us-ascii?Q?8Ujt4yRLmDGdMGGbpJtQrf1Z6CYU6Ctx5OekS2QxKtOQATRHwgnsfaxWrvlD?=
 =?us-ascii?Q?xmjj9OfmyjjDd5KJq7Hj0sdvgxYZyKp2?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 13:37:13.6208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 414c9147-9739-4bf6-8f00-08dd1ab21648
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB4630
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

Adds the support of the hmac based on sha256.
This implementation is based on rfc2104.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 include/u-boot/sha256.h |  4 ++++
 lib/sha256_common.c     | 48 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
index 44a9b528b48..2f12275b703 100644
--- a/include/u-boot/sha256.h
+++ b/include/u-boot/sha256.h
@@ -45,4 +45,8 @@ void sha256_finish(sha256_context * ctx, uint8_t digest[SHA256_SUM_LEN]);
 void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
 		unsigned char *output, unsigned int chunk_sz);
 
+void sha256_hmac(const unsigned char *key, int keylen,
+		 const unsigned char *input, unsigned int ilen,
+		 unsigned char *output);
+
 #endif /* _SHA256_H */
diff --git a/lib/sha256_common.c b/lib/sha256_common.c
index 7041abd26d9..46262ea99a2 100644
--- a/lib/sha256_common.c
+++ b/lib/sha256_common.c
@@ -48,3 +48,51 @@ void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
 
 	sha256_finish(&ctx, output);
 }
+
+void sha256_hmac(const unsigned char *key, int keylen,
+		 const unsigned char *input, unsigned int ilen,
+		 unsigned char *output)
+{
+	int i;
+	sha256_context ctx;
+	unsigned char keybuf[64];
+	unsigned char k_ipad[64];
+	unsigned char k_opad[64];
+	unsigned char tmpbuf[32];
+	int keybuf_len;
+
+	if (keylen > 64) {
+		sha256_starts(&ctx);
+		sha256_update(&ctx, key, keylen);
+		sha256_finish(&ctx, keybuf);
+
+		keybuf_len = 32;
+	} else {
+		memcpy(keybuf, key, keylen);
+		keybuf_len = keylen;
+	}
+
+	memset(k_ipad, 0x36, 64);
+	memset(k_opad, 0x5C, 64);
+
+	for (i = 0; i < keybuf_len; i++) {
+		k_ipad[i] ^= keybuf[i];
+		k_opad[i] ^= keybuf[i];
+	}
+
+	sha256_starts(&ctx);
+	sha256_update(&ctx, k_ipad, sizeof(k_ipad));
+	sha256_update(&ctx, input, ilen);
+	sha256_finish(&ctx, tmpbuf);
+
+	sha256_starts(&ctx);
+	sha256_update(&ctx, k_opad, sizeof(k_opad));
+	sha256_update(&ctx, tmpbuf, sizeof(tmpbuf));
+	sha256_finish(&ctx, output);
+
+	memset(k_ipad, 0, sizeof(k_ipad));
+	memset(k_opad, 0, sizeof(k_opad));
+	memset(tmpbuf, 0, sizeof(tmpbuf));
+	memset(keybuf, 0, sizeof(keybuf));
+	memset(&ctx, 0, sizeof(sha256_context));
+}
-- 
2.25.1

