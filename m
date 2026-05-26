Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844D4CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 12:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65B9680433;
	Tue, 26 May 2026 14:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="alU3qM+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1C3A83FF5; Tue, 26 May 2026 12:56:37 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9E4F80433
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 12:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-516df90c167so31449201cf.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 03:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1779792995; x=1780397795; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2G03T8QyKiDOTQFIBc4rnzea5tIxwGNSxir+6fmpzE=;
 b=alU3qM+PGZ+XqCa76vfTIKnx504+kqeUgtxzg9AJ7KBbbPUrilXWhP5Wp5/xf/5qev
 HU3FUm5TNQTILp1jGmtQfmspTcMVWDdGJLGirxhgxNWMDu4Oj19qhG+xe+C5zC1uJUDC
 5rZjf3/ouq2LtJScTGG5w62vkMbTYIOY7b/5sTuJByHPCEj1KvmQa/iYTQbOeVs+T0bF
 YyOZutenARgSbDNs+B4rGO9Rc4y9POGX862ZTy5xhYHHOQ5zfvhtRwpd7x89RTULrWXv
 rYVexu+lfCk3gNZXBhtMIZLTWpVdiMdfYLe6QJOD+OxYhB+oQ/wO+vHhFZLrhsrd1KnP
 w3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779792995; x=1780397795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k2G03T8QyKiDOTQFIBc4rnzea5tIxwGNSxir+6fmpzE=;
 b=K6hHi965b5Z6MD6lNTSZisN4ZT1oAVPscv9wKXTIrpHWAAGBYwYyr5mTFmK3jAiqGW
 ofOlAEY7a2QYui1gPMYedMrM8H/GZ5WbJijrMbCuPDobYUuomTXAgMfPZpOelQyPonKn
 ugsbm6sCaXBnMth+CusIPRymyn4hMXJVCLW5QDgqD1zkHfY16XOfAW3rHVM7xh4au5C/
 wQVOrwwFBrIgE80iWswU5JAUBhaSx4kjD4052ud1emJpf+DNGYf0VquGs4BfLQmWqHa7
 ESCL2th4Fc126mVgsvWQTHesVC6g/ZTjZ0KWT64QrAXSKZMiCGgpjnsUOW3aHQkh9Qq1
 eysw==
X-Gm-Message-State: AOJu0YzsS8IcBfRsD74jGZxXEj1CfsAVHPnZTs7kyr9f2+eDIReVQ6Yb
 I6z2wqLk4H7XpIRUHZTAoTQ5aIFkaoPvhKo5RQ4gSbwvF+n6BxiHQZLtXknok3jxGsvb/cz9+bR
 ET8fyCGI=
X-Gm-Gg: Acq92OHuMDaA8ViynzFLtgyZkkSQYNBkTLhIzNP2I8CEr/ChhFYo8cPOkzRY0WABlGS
 6dHzdCB7m8SVjoYQFUs490KS4RVG7qEPSD1u7LJ3lMMA3YoKhAgd/N23mByZQMB1qEixxPkG6Ie
 lF+wojha3NliLZzF6FZaY5OdiWCb3j4G+LAjgd1eC4wsg4kv76hP5DNvSh1tr+wUdJ1Vgnx43q0
 WN42OZJ608Fef+RvhyniWOVFwTbJ6UTwvtnn9WqkWH1U4/S686tE2FAwntDl4daj/1nxbJdkQKo
 PxPxghIfW511lEKVNgyHSbwj86CQm6NJJcYJK99djnWh6uwxJ2cSwQO4zJx+OB04jjlEFyG8Zt8
 0eitpi315ighT+V0zJsjppcjMIHkUTIjmEJkotqAhV/KBri/EGQdnYVFvAH1uRbBjpSZAhwf95P
 AhEKS6WruyAxmtVGlJ/sKvZ7avgOlarp9SnIsaqUH1d2yQYB6gzCnL01aN
X-Received: by 2002:a05:622a:8c08:b0:50f:b7b3:2ebb with SMTP id
 d75a77b69052e-516c561317cmr227498981cf.33.1779792994642; 
 Tue, 26 May 2026 03:56:34 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-688b9f5056fsm4922721a12.9.2026.05.26.03.56.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 03:56:32 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	vr@binarly.io
Subject: [PATCH v2] image-fit: Limit recursion depth in fdt_check_no_at()
Date: Tue, 26 May 2026 11:56:26 +0100
Message-ID: <20260526105626.52611-1-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260522123024.6292-5-anton@binarly.io>
References: <20260522123024.6292-5-anton@binarly.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 May 2026 14:40:44 +0200
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

From: Binarly Vulnerability Research <vr@binarly.io>

fdt_check_no_at() recurses into every subnode without a depth
limit. A deeply nested FIT image can exhaust the stack and crash
U-Boot.

Add a depth check using FDT_MAX_DEPTH to bound the recursion.

Signed-off-by: Binarly Vulnerability Research <vr@binarly.io>
---
Changes in v2:
- Rewrite commit message to be concise per maintainer feedback

 boot/image-fit.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index b0fcaf6e17f..0e225ecd0c2 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -41,6 +41,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #include <bootm.h>
 #include <image.h>
 #include <bootstage.h>
+#include <fdt_region.h>
 #include <upl.h>
 #include <u-boot/crc.h>
 
@@ -1643,20 +1644,24 @@ int fit_image_check_comp(const void *fit, int noffset, uint8_t comp)
  *
  * @fit: FIT to check
  * @parent: Parent node to check
- * Return: 0 if OK, -EADDRNOTAVAIL is a node has a name containing '@'
+ * @depth: Current recursion depth
+ * Return: 0 if OK, or error value
  */
-static int fdt_check_no_at(const void *fit, int parent)
+static int fdt_check_no_at(const void *fit, int parent, int depth)
 {
 	const char *name;
 	int node;
 	int ret;
 
+	if (depth >= FDT_MAX_DEPTH)
+		return -FDT_ERR_BADSTRUCTURE;
+
 	name = fdt_get_name(fit, parent, NULL);
 	if (!name || strchr(name, '@'))
 		return -EADDRNOTAVAIL;
 
 	fdt_for_each_subnode(node, fit, parent) {
-		ret = fdt_check_no_at(fit, node);
+		ret = fdt_check_no_at(fit, node, depth + 1);
 		if (ret)
 			return ret;
 	}
@@ -1696,7 +1701,7 @@ int fit_check_format(const void *fit, ulong size)
 		 * attached. Protect against this by disallowing unit addresses.
 		 */
 		if (!ret && CONFIG_IS_ENABLED(FIT_SIGNATURE)) {
-			ret = fdt_check_no_at(fit, 0);
+			ret = fdt_check_no_at(fit, 0, 0);
 
 			if (ret) {
 				log_debug("FIT check error %d\n", ret);
-- 
2.53.0

