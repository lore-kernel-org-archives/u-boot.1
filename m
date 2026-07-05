Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B089BC43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 10:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99820846F8;
	Sun,  5 Jul 2026 12:42:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JwDorqIq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1A1C846F8; Sun,  5 Jul 2026 12:42:58 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B72ED84867
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 12:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e9f6b94a49so1085572a34.3
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 03:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783248175; x=1783852975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sqybd34VJJa8WanloM140fTsPhM+Xfp9q3hiqMfiY8w=;
 b=JwDorqIqXri8KWh4VDo5jgT5GWZtuxBnGfYRMoQgE5eu5a3hORbtZDZl5HPWXZNj1S
 WZWGtrNbUFz3lHnj7QA23PxWArjOg/jRln1lxfpjpdLKGVXz9M/JacsSrUzsimN5Y0Ua
 C9CAu5jknQHbW7/WwjnLcMB7zyetjCpC/7Oqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783248175; x=1783852975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sqybd34VJJa8WanloM140fTsPhM+Xfp9q3hiqMfiY8w=;
 b=BOD2NW5T++ij2Mk05MtR7cMhaM8gBCgvihJ/IgcxlpYe7LAqIeq8YBvXCwTWmumi1h
 6NAMPuGaBARouKX6DWtbCQhYlgALT+n+q9Tq4rpuxa+W7prf19OeVRMtNriAKZ6ia/57
 vWiZW2Kmi90XKmYxgLEBQov4/fUbfzvy646cylNLi4+ncJuR1TmN434PPL7SIFivqgCd
 qg9BRc7J5+Dev0WqLlfdd/rHfmTfSf5n5pBNQAP3t6qWYG0QxEDTgGwVA7iOLOi/8VVP
 gRmObPfiBoMDT0QfyRDN932rC+StXtVI4jO5r3tad6GxSy1gJ08EiXNh4J4CaGREyIBM
 w8gw==
X-Gm-Message-State: AOJu0Yy7PLZqb2VyrWeONkITC1AawE4py3duAubJMS9VozXwwF+yOTkv
 BLRkLKSQL8zVasjsOQeUb19daXFzC2WTmMmSiq6VBo2jYzAD6Fn1KGhymEEJSqzU0e99miltu8t
 NVnDgxQ==
X-Gm-Gg: AfdE7cmgWVIvG/FxEEFaJ8xx2uO3xZMqclpHAOZlHsIGp2/MER0zKq/UeqqXVjl8KFQ
 2l3pz2DUsODCCMIvb+VNf8csPbD806phVHck1qUWz10c2CdzCBWOlbwhf0GP4IyNpjR7MQ1lZkP
 X6nMM2foAzTBM1Me0mHxzPsAVademvD8C9LddW0w5rwTYH3beXlDUo8A0uHS/JA37XJgNY4AUNP
 G6kHjqF9aR7OfsduiUZ0bsquIcXh4750ZuTt29nNncjV/VRBsahs1ws8zga1T1t9ULqjTd42PdU
 swMwFGHid9gsxv7qHJM0YS/uQHwdJQibqt5Dvf1vTP3YyOeWb3mZ1YL6D7TpnhMWCNKepht8scw
 ZGM2Lm7klP895UHMo3VqG+/BPQsOOZqzXo7M/CwfFjS4dzQVstb1SiSk8L4tRrbnX2t2/V1p6dP
 Pok34L46A=
X-Received: by 2002:a05:6830:6a12:b0:7e9:e342:3e0 with SMTP id
 46e09a7af769-7eb7fee52eamr4061168a34.18.1783248175452; 
 Sun, 05 Jul 2026 03:42:55 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb54291227sm9136961a34.3.2026.07.05.03.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 03:42:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 4/5] CI: Add an sjg-lab job for the Intel Edison
Date: Sun,  5 Jul 2026 04:42:15 -0600
Message-ID: <20260705104231.3846672-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705104231.3846672-1-sjg@chromium.org>
References: <20260705104231.3846672-1-sjg@chromium.org>
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

Add the Intel Edison (Merrifield/Tangier) to the sjg-lab CI matrix.
U-Boot is sent over DFU into the board's eMMC u-boot0 partition during
U-Boot's brief do_probe_dfu window, and a reset then boots it from
there. The lab environment handles the build and the DFU send, so the
job only has to name the role.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---

(no changes since v1)

 .gitlab-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 245e422d72f..b207a113383 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -797,3 +797,9 @@ qemu-x86_64:
     ROLE: qemu-x86_64
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *sjg_lab_dfn
+
+# Intel Edison (Merrifield/Tangier); U-Boot sent over DFU into eMMC u-boot0
+edison:
+  variables:
+    ROLE: edison
+  <<: *sjg_lab_dfn
-- 
2.43.0

