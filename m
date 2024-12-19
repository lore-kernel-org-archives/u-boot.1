Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81053E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 13:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F97580316;
	Thu, 19 Dec 2024 14:06:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="BINkGchb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E06B80316; Thu, 19 Dec 2024 14:06:06 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20EAF80328
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 19 Dec 2024 14:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFAmzT41xpwT08cygCMuqpF2PndfSDsC7XSFFajOjWq63WH82qNxj4Xsd5+t+zj4RyVmvBZhIUFJ2xSPhQ67u8LOwQyvo4xDff2Hdtzp7PjXp9LiBvYLdHh9WdoCcDcmvn5w6S1B8h2RmjD641ppB5CQRGT62DyRkwAnlYPnwac1t5Luvgnf2bBce0GTTeYeWHl+qBARV4m85KELiBnyItD6jb3/3jTST1+cPMHNA++e0dZu5HhtFs7QJ9BT8DW7s5ZhlNIjzQyhGWM2RVbmsUzV9Ts9OdMt1TiwPDQKiKNcKeBeUV+hFqyRaH5jojfODIA/Ow6xMef98rJdFNzt5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L4iJf2np20a2cByJImK7Z6rFUF4k1JGOsR2dvb9yNo=;
 b=FalPMYaQBl6P8oxHOfIuemydHHUk/DXit36gL7Sn/tP85Nn75A4Uh1DTHOo6i/mU7w1NX28fSfRiUhf3o6cdM/4tSZ952tEMfnPEc1U9qRAiT81glyL75ppKC1WrlG24IzVvAPJ4v5HF/ZYzNuvV+yh0aowkwgGglvcQ3dVUd5Ow1rNsvsXayDx7TlNDEjPPo+H/15frsd1yWwVMkabfiTigGwEJB8RPiMQE5wnDamB1VOVKnliBtPIZdfh27mXgukM/uEmPyfqlmDnqqFQIto44vGY4iD5nr11hqTWQb0F0m0X5ay9U7nvG/ALJoH9xz127OXBGlYvBi18QsJGn/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L4iJf2np20a2cByJImK7Z6rFUF4k1JGOsR2dvb9yNo=;
 b=BINkGchb13Ld0lWqKaNTWSLNS/Dgl3A7k7gjzMD1zxAsPWP141aY+WyXD3N9HHCnqWpTiZ2qV/TRu7L39ZbofHLefG0VO9dT0iMzj5Mx6kUos0WGsANfg1PN3oqO0xJvBoUg0/wiZgq4M6iC/qbi38L9JMS9Q0Uvse/HJUmRHLFPBEPDteymxHpdp9PtH72l+lrgumtWiNJfVw3P1iv31y5LpOVoXNmkM3G9LO7yHoqNVrfT500Zn9Sn1Z04JgW5hMeX3JKBfqEfHp8cCvhV8GFV/QuqwxIb2V9UA695NslRQxvtlX2DBeTM0mihsVLqGz5aHe3KrN23y3a+cjvWxQ==
Received: from MR1P264CA0133.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:51::18)
 by MR1P264MB2833.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:36::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Thu, 19 Dec
 2024 13:05:57 +0000
Received: from MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51:cafe::c) by MR1P264CA0133.outlook.office365.com
 (2603:10a6:501:51::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.24 via Frontend Transport; Thu,
 19 Dec 2024 13:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D58.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 19 Dec 2024 13:05:56 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 9D77D202A1;
 Thu, 19 Dec 2024 14:05:56 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v7 5/9] lib: sha256: add feature sha256_hmac
Date: Thu, 19 Dec 2024 14:05:50 +0100
Message-Id: <20241219130554.49825-6-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241219130554.49825-1-philippe.reynes@softathome.com>
References: <20241219130554.49825-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D58:EE_|MR1P264MB2833:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8841701a-dfb8-469c-947b-08dd202de091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OhvjBj4k+6gOK9q6Ku7wMr8hbVHj0yRlR80HISr+C5LuHp+eXpBPLq9n0GKl?=
 =?us-ascii?Q?1nL/AYy/OtuUgbGShYDrAZGZ6/DNQpXoxlEHy/cQbbYmwY4frQfeju4kIFpF?=
 =?us-ascii?Q?MjRqU5wFrWj7mU42LebG3Z0PQ/+udlO47lGxiMGio5sodZI4eXLsM2wCh2bz?=
 =?us-ascii?Q?2b4pg+Qf8gviIIY4n9H5Gxk8iggTOZnHxcD9PnbBZr5Higge6vHu3LiD2Tih?=
 =?us-ascii?Q?AGq6gxBw06+hb8tslCAboutZnwgLLhECYdlS11GVUgPtzg76A487B4D8+sNW?=
 =?us-ascii?Q?vguLqkQcxFkRJsl1WYLfizIEnCN9MpmUdckrzCDfdpzsKHMQnja5jTa94N9g?=
 =?us-ascii?Q?ySzT66ZNbSQpqbLWjLnyCP3jUWkgt8KkcCA9l7C7MiZoc59n7gqNfepHh2hm?=
 =?us-ascii?Q?4gDrAxH/zDMWv6mrBPvhVoiz4NxuPG5LO/nMH7dleWf9uxLV9x2o9O+VbBHb?=
 =?us-ascii?Q?MHLRv7Kan7keIbiyNYTKEiLHgzVUZAHwO9reGgE3ZxQY+7LZVCX0hYz1+9ew?=
 =?us-ascii?Q?uxC5Ygzta1xHXqIXByf2ZGuIYip7EtPMCuSRkF2b4N3hJSDhk+XHzu6MP14l?=
 =?us-ascii?Q?FT2sSqRcQjFzszCi9aCkZDDdPvytPupgkodQY9TFhaqzQr1tHSK0ZLjVuV8w?=
 =?us-ascii?Q?2hwhstNDJI+koiZjmFQ1Id+e4PSiiALoxPLuZmyT8l+c9j12cVoz/68HhXKI?=
 =?us-ascii?Q?5TsbYRWrKozg3IevcHpJaINNfDBY94fKpxREHTAJOZa+QVHBoRIoDWiO6pDr?=
 =?us-ascii?Q?M75h3NvfZVBmsOjD/0kCFRhK/YcuIqUxbdHT4rZnryH19cNeDrx21QY2IsWQ?=
 =?us-ascii?Q?x6kbm2gv+eKKaXhmjqcwDO0jFp2yqfbxBw99DHm6dQWPw7+dHYb2rNq4lrYW?=
 =?us-ascii?Q?3hxcjCeLGs/YmgPlJw+riCG+C9Wn4g7NAdPI1ogObyvaaaKHdF+lW5CDAjdT?=
 =?us-ascii?Q?0yttMxiOoiOxWYWtpZ12B2GCJxz+x51jHA/FEPjA4mFXht9eR5DmH9ANejCL?=
 =?us-ascii?Q?gRFZTAncZs2CVJU+qpm36VldwKQN6OK6TMpnGHy/CpwuFdmYsnP77olqE98I?=
 =?us-ascii?Q?LxjlDZt31hDGFICxd9g+vQ+Ne0DnL4cQmzFOZ5jOvTMyfxfruQFOq1Avr1sM?=
 =?us-ascii?Q?AG4uA0u2ME4vZWzdLGCwhOTtEaD1b0OpmwpuW3VrvdEv0XzyXdnfwUXDMDk0?=
 =?us-ascii?Q?q4kJBlOuwTAceGXDcQUWMnJFeNZUGSC3zvQb/44NAavgCvoxmwM+hhGFXued?=
 =?us-ascii?Q?RMq5UWXldLknuVMCl2qUseDqdHbOYwjBiI3WOToTkAnuaRAywgFz+iCMhH1W?=
 =?us-ascii?Q?g2MmosU0qN4XtrIuVqejN2elkwAPyfhDG3xpE2FqJ++AS3ICPPHNExmypaq1?=
 =?us-ascii?Q?RB2faBXUpiFqlCBMgP1IYQ1eLUvda0oWlD3SzWYXeecE9IGAAi+WdoG1pqqd?=
 =?us-ascii?Q?0Fmro94/d7EFEWpiSE9NtsxFUgnXEv4BwIZg1kCHQrSuhimu6VVwAOgUoBL/?=
 =?us-ascii?Q?mTCraQdqNaLbKd4=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 13:05:56.8951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8841701a-dfb8-469c-947b-08dd202de091
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2833
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
 lib/mbedtls/sha256.c    | 15 ++++++++++++
 lib/sha256.c            | 51 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
index 44a9b528b48..99cf78e204c 100644
--- a/include/u-boot/sha256.h
+++ b/include/u-boot/sha256.h
@@ -45,4 +45,8 @@ void sha256_finish(sha256_context * ctx, uint8_t digest[SHA256_SUM_LEN]);
 void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
 		unsigned char *output, unsigned int chunk_sz);
 
+int sha256_hmac(const unsigned char *key, int keylen,
+		const unsigned char *input, unsigned int ilen,
+		unsigned char *output);
+
 #endif /* _SHA256_H */
diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
index 2128e598834..7d456a82017 100644
--- a/lib/mbedtls/sha256.c
+++ b/lib/mbedtls/sha256.c
@@ -10,6 +10,8 @@
 #endif /* USE_HOSTCC */
 #include <u-boot/sha256.h>
 
+#include <mbedtls/md.h>
+
 const u8 sha256_der_prefix[SHA256_DER_LEN] = {
 	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
 	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
@@ -33,3 +35,16 @@ void sha256_finish(sha256_context *ctx, uint8_t digest[SHA256_SUM_LEN])
 	mbedtls_sha256_finish(ctx, digest);
 	mbedtls_sha256_free(ctx);
 }
+
+int sha256_hmac(const unsigned char *key, int keylen,
+		const unsigned char *input, unsigned int ilen,
+		unsigned char *output)
+{
+	const mbedtls_md_info_t *md;
+
+	md = mbedtls_md_info_from_type(MBEDTLS_MD_SHA256);
+	if (!md)
+		return MBEDTLS_ERR_MD_FEATURE_UNAVAILABLE;
+
+	return mbedtls_md_hmac(md, key, keylen, input, ilen, output);
+}
diff --git a/lib/sha256.c b/lib/sha256.c
index 827bd9a872b..c2e77c854b9 100644
--- a/lib/sha256.c
+++ b/lib/sha256.c
@@ -264,3 +264,54 @@ void sha256_finish(sha256_context * ctx, uint8_t digest[32])
 	PUT_UINT32_BE(ctx->state[6], digest, 24);
 	PUT_UINT32_BE(ctx->state[7], digest, 28);
 }
+
+int sha256_hmac(const unsigned char *key, int keylen,
+		const unsigned char *input, unsigned int ilen,
+		unsigned char *output)
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
+		memset(keybuf, 0, sizeof(keybuf));
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
+
+	return 0;
+}
-- 
2.25.1

