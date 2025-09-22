Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD22ACAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 12:30:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2A3983280;
	Mon, 22 Sep 2025 14:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="p7Noc4K7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="w80aHpoB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AF05832F9; Mon, 22 Sep 2025 14:30:09 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CF9E83211
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 14:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cVj9n2q0Pz9tMQ;
 Mon, 22 Sep 2025 14:30:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758544205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8okz44p8YvCJb3ASFokOmaZhC37QCQurHkDRCyFt/aw=;
 b=p7Noc4K7u40S0hA3scYD/HZdZGhQmojLwQKUtAm+tKu8JiyTBFaE8p+RJVGHEC6ZDsXi7c
 qzf5M+RKQ0bKf4X7oSpBqH5tIUESo0UpqY2T87FINJgtoXR/2W66zFLWrTqaSbPSKEYVGt
 WSrAgpZgVAOZBzLvEznHzhP6pV3dhhSPqr+NnXQK3RnP5JWFYEcuFE7dNLiIr4xmKa8vZ4
 YsUD7bthXxDGqMtXqMmDM2Fvj5eYqlf731bd5PnVFw+mYOhbRqa42hLiuAYDCYMGZh+yx7
 1JYTfH8308T4HujHJRK54yfrh2Xxy+nLmIAM5Hbs94UUwdRR270895zrWta8mg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=w80aHpoB;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758544203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8okz44p8YvCJb3ASFokOmaZhC37QCQurHkDRCyFt/aw=;
 b=w80aHpoBt2o9Qzol85lj0PD66ogU3Pcj8dodsAUXqfx+gP4xI07ziaTqjoPhCX92v5gcpm
 kHgp8N6bl3CUrOUZmKhnPtXqJgUcdhibnC2H/DO96mjftXsPYezQqDjIBOhoVmqFDsEc2O
 nB9GO3xYNlS/b3wjWBi7eNh6oKAIcc6lVkwlpmdrWo+IyQl/MQ83C5lyaMbvTH3JNgvao8
 clKLpUv+ZfBONTN6b3ZQuE6welEVU5M7i6LGsIThbvWTmOc+BAOR/a0ibiRPe/uBk6Rb6g
 g9x/imYb2OrfmWH4dYGQTro5GJNcJG1SkHthns1X8B57H8PIzZyHaj5kr2YqYA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] linux/kernel.h: Update upper_NN_bits() and lower_NN_bits()
 macros
Date: Mon, 22 Sep 2025 14:29:22 +0200
Message-ID: <20250922122948.56748-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: j86bcyumh544dmnpdmof565r1c7p4r3p
X-MBO-RS-ID: 65d29b2c8150a79db08
X-Rspamd-Queue-Id: 4cVj9n2q0Pz9tMQ
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

Synchronize upper_NN_bits() and lower_NN_bits() macros with Linux 6.16.7
commit 118d777c4cb4 ("wordpart.h: Add REPEAT_BYTE_U32()"). This fixes the
lower_32_bits() macros and assures it works with 64bit systems correctly.
This also adds 16bit variants of these macros, which will be used by the
Airoha PHY driver.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>
Cc: Raymond Mao <raymond.mao@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 include/linux/kernel.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index e0443ecac84..44a639a5e4e 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -111,7 +111,19 @@
  * lower_32_bits - return bits 0-31 of a number
  * @n: the number we're accessing
  */
-#define lower_32_bits(n) ((u32)(n))
+#define lower_32_bits(n) ((u32)((n) & 0xffffffff))
+
+/**
+ * upper_16_bits - return bits 16-31 of a number
+ * @n: the number we're accessing
+ */
+#define upper_16_bits(n) ((u16)((n) >> 16))
+
+/**
+ * lower_16_bits - return bits 0-15 of a number
+ * @n: the number we're accessing
+ */
+#define lower_16_bits(n) ((u16)((n) & 0xffff))
 
 /*
  * abs() handles unsigned and signed longs, ints, shorts and chars.  For all
-- 
2.51.0

