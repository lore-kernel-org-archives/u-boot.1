Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1375DC27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 09:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F21C08842A;
	Wed, 19 Jun 2024 11:56:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD5ED88431; Wed, 19 Jun 2024 11:56:08 +0200 (CEST)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [185.125.25.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4A1988416
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 11:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4W3zXQ2qsKzMJF;
 Wed, 19 Jun 2024 11:56:06 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4W3zXP64YqzJf1; Wed, 19 Jun 2024 11:56:05 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 19 Jun 2024 11:55:52 +0200
Subject: [PATCH] rockchip: puma-rk3399: increase Ethernet PHY timeout to
 30s
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-puma-eth-timeout-v1-1-db5c17153f82@cherry.de>
X-B4-Tracking: v=1; b=H4sIACercmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0NL3YLS3ETd1JIM3ZLM3NT80hJdE8OkVMtkIxPj1BRzJaC2gqLUtMw
 KsJHRsbW1AKTs0ZJiAAAA
To: Klaus Goger <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.0
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

On Puma v2.1 with a KSZ9031, the Ethernet PHY often doesn't detect the
link in the 4-second default timeout.

After some boot-loop test for about a thousand boots, 70% were below
10s, 90% below 15s and 100% below 30s. Let's play it safe and make it
30s so that hopefully all links that should be detected are.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 include/configs/puma_rk3399.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/configs/puma_rk3399.h b/include/configs/puma_rk3399.h
index 969acc89b93..2056a5eb2e4 100644
--- a/include/configs/puma_rk3399.h
+++ b/include/configs/puma_rk3399.h
@@ -6,6 +6,9 @@
 #ifndef __PUMA_RK3399_H
 #define __PUMA_RK3399_H
 
+/* Highly variable timeout in getting a link on Puma v2.1 with KSZ9031 */
+#define PHY_ANEG_TIMEOUT                30000
+
 #include <configs/rk3399_common.h>
 
 #endif

---
base-commit: fe2ce09a0753634543c32cafe85eb87a625f76ca
change-id: 20240619-puma-eth-timeout-41be9c243ed7

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

