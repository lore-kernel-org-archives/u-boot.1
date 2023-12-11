Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3E3C10F09
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 18:08:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3947987792;
	Mon, 11 Dec 2023 19:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="IBo5PDMM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66D8486308; Mon, 11 Dec 2023 19:08:26 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FB8A83CF3
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 19:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2DAA741518
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 18:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702318103;
 bh=dKR0ZDcZ04yerS5CAwt4tqfFAMCd1jbUHIYYnnvQoc8=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=IBo5PDMMgw8W9Qos96nuPznJ02ocOZtk4z3UqSG6jmR+uoKvDSpX7tduxzDtsv2eZ
 InFDTaU92u5OYgMyxx7t9wT/EKt9xEc66aK5cmezNmtInXKHDTxM5qUuSj47oFcego
 AJJd7ivDa1hKKCsjFgR5zP9cuQ0KBPc7X26zleGWR0rsUJWzwcLQXXSWb25gfuCDXG
 TqIvxa1egDj/ufk9m8NWiVIsJ217NQ9/jGbQVOmIiB06IBzDrQb7QMhVgS4bHozEAI
 tQxmsjrwWE9CSTI4lBHr41h2S3VKQw53oJqYrwI6dfIXe7gzuW88ezFSEN9fq2llI1
 yZtln3Ry1dxMw==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40c1257782fso32306415e9.1
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702318101; x=1702922901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dKR0ZDcZ04yerS5CAwt4tqfFAMCd1jbUHIYYnnvQoc8=;
 b=bEauAU5iGXkifU8e7ej6kg+p/gxLrwCbFnfobRXOG25Mi4JsqtJiKMGfAFu0Bez6WU
 4d7nIGQR2iMI+VkUiHwl3tRsaxcRHS6tN5kher9JIBdZaRBI2qkqv1yL/9c4Z5Rt3Wzb
 mwUVoZftvhKKmtk7xHSWUIYtuy3M5LOwuqfEa7nFPU1nKJWvHvBz8LuMFKs75vsU2XpG
 l0UcfxwiUniG9mYkTrBlnR9QZ//qA2SpQ+TqSSzCiDJduX1QWT1ZAOL4k5Vvzy1KjmA9
 ZGy5Abo3ER7Gtpls8WdCcnMBesjIrsFNCSevKsTNBe0HfA9FVHx5wC7ljLks+ZLIky5t
 2PGA==
X-Gm-Message-State: AOJu0YysMvkntw8CNTLtjtdo4MQ5Dgtf1TuZcGJfDBUIPzh0PDGYQmhn
 mv6K4OMCJeHymxG8Frrjph6jdsWrVA5dN+WgfRn8yAdMGW6ZUZ9frbRVVdLsepP6HVTGIreBayk
 dLCmEixdFxYb+Y1iPiC2WidjMeH8uWPU=
X-Received: by 2002:a05:600c:4897:b0:40c:a9d:fa1d with SMTP id
 j23-20020a05600c489700b0040c0a9dfa1dmr2553120wmp.142.1702318101288; 
 Mon, 11 Dec 2023 10:08:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWBnziTjRV/q1XNBzCrxAQdbjp829dFZK/14Nte3+xE5fezAnatwjYgMN29WM2lmQO4FtD6A==
X-Received: by 2002:a05:600c:4897:b0:40c:a9d:fa1d with SMTP id
 j23-20020a05600c489700b0040c0a9dfa1dmr2553112wmp.142.1702318101023; 
 Mon, 11 Dec 2023 10:08:21 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 g20-20020a05600c4ed400b0040c31bb66dcsm13461321wmq.20.2023.12.11.10.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 10:08:20 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Roman Kopytin <Roman.Kopytin@kaspersky.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/2] test: vboot: Using variable 'old_dtb' before assignment
Date: Mon, 11 Dec 2023 19:07:33 +0100
Message-Id: <20231211180733.86629-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231211180733.86629-1-heinrich.schuchardt@canonical.com>
References: <20231211180733.86629-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

old_dtb can only be assumed initialized in the finally block
if it is assigned a value before the try statement.

Avoid a pylint error reported by current pylint.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2:
	mention pylint in commit message
---
 test/py/tests/test_vboot.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 04fa59f98b..7e0e8e4475 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -533,10 +533,10 @@ def test_vboot(u_boot_console, name, sha_algo, padding, sign_options, required,
     with open(evil_kernel, 'wb') as fd:
         fd.write(500 * b'\x01')
 
+    # We need to use our own device tree file. Remember to restore it
+    # afterwards.
+    old_dtb = cons.config.dtb
     try:
-        # We need to use our own device tree file. Remember to restore it
-        # afterwards.
-        old_dtb = cons.config.dtb
         cons.config.dtb = dtb
         if global_sign:
             test_global_sign(sha_algo, padding, sign_options)
-- 
2.40.1

