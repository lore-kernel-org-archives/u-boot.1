Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6C5C07D5A
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 093F287813;
	Mon, 27 Nov 2023 20:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GebQ1cST";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C73DE8781B; Mon, 27 Nov 2023 20:53:42 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4033877B0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6d7fc4661faso2592563a34.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701114819; x=1701719619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6RFMlShZeFgOHgdxCZA1nfAyopulPDAlKxhV4gGxkA=;
 b=GebQ1cSTPkpBT07aB11JRn63lL+puat1pOdVumtT6kfnO78M2F3/xZOS2DgWziHfjb
 nzCIXdOuhe4UXPR3iaUnFQ1rOkZUC6P5MbeRgAeJLPG+uX7j2EJU1nnm1HZ64eEfcUWd
 m4vRjgBX2k9T5H2xnGV9KJECKQHB6WhpmBraPb8qBcc2Pmty5kWluXyYBCDWoeRmgU/a
 uzl9DyILv0KBcllmLL2+HaqHkttoLjtLo90+NPDV1P4mIlI5ptluomM1xn4ZN74gyQvy
 MKctOHOQu/WwpOUiFg39AkGRlsJnN9S+h1tS6RSJtJT7mlMiUDKfJPZmPvA0PxCMlbv8
 Sz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701114819; x=1701719619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r6RFMlShZeFgOHgdxCZA1nfAyopulPDAlKxhV4gGxkA=;
 b=vHOK1ShrnEO+JTUzK1jauAo3hAtaLVoNkMbpYLIaA+Q1hIu82kj91f8dC6op9MGj2G
 5jWNd/Ekpk3ISQs0YL81hu4ZUMjQF+TFvbtqGI4Nuqed1HRbD0iHUD4UwvKK359Iw2Ew
 udV22J7llO5x9PxAy2uNp1rba8OZLKfr3B4nPPhc85YEoaoZB4TDiJ/9b1r59KVxUZK5
 82BoFhk2pDPDz2RlGHYXkdxVae1+jiFtUUbHUZvA9IzNpQeG/1l70YJBojWYzzQ+aZAn
 3vvVF8yFro/3g1h1S0goXrVGrNWi0RA/LVKmI04d7xvkDKvUj8R53SLfLdoz4oY7o0EG
 Lm5A==
X-Gm-Message-State: AOJu0Yz0pi7+aoJlxfHTuBlvUpO+AeS0Byq+wPa2sinj7+yXpsltCLRv
 4GCyiHekSXEXRk96vAP3eq5nGzwiVGyaJHWrVPE=
X-Google-Smtp-Source: AGHT+IEOeZ7qYqS5Y7+BjBN+nS86+R8hkzuQsHtV6r9x/zM9q59Mwms3ClP/YAipsOuauMatJ2xShw==
X-Received: by 2002:a05:6830:1d63:b0:6d8:1a9d:9a6f with SMTP id
 l3-20020a0568301d6300b006d81a9d9a6fmr7090624oti.36.1701114818976; 
 Mon, 27 Nov 2023 11:53:38 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ad45106000000b0067a2061fc21sm3087047qvp.101.2023.11.27.11.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 11:53:38 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 18/18] bloblist: Load the bloblist from the previous loader
Date: Mon, 27 Nov 2023 11:50:29 -0800
Message-Id: <20231127195029.90951-19-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127195029.90951-1-raymond.mao@linaro.org>
References: <20231127195029.90951-1-raymond.mao@linaro.org>
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

During bloblist initialization, when CONFIG_OF_BOARD is defined,
invoke the platform custom function to load the bloblist via boot
arguments from the previous loader.
If the bloblist exists, copy it into the fixed bloblist memory region.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- New patch file created for v2.

 common/bloblist.c  | 29 +++++++++++++----------------
 include/bloblist.h | 14 ++++++++++++++
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 91d69e9439..251093ecfa 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -477,15 +477,8 @@ int bloblist_init(void)
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
 	int ret = -ENOENT;
 	ulong addr, size;
-	bool expected;
-
-	/**
-	 * We don't expect to find an existing bloblist in the first phase of
-	 * U-Boot that runs. Also we have no way to receive the address of an
-	 * allocated bloblist from a previous stage, so it must be at a fixed
-	 * address.
-	 */
-	expected = fixed && !u_boot_first_phase();
+	bool expected = fixed;
+
 	if (spl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
 		expected = false;
 	if (fixed)
@@ -493,14 +486,17 @@ int bloblist_init(void)
 				      CONFIG_BLOBLIST_ADDR);
 	size = CONFIG_BLOBLIST_SIZE;
 	if (expected) {
-		ret = bloblist_check(addr, size);
-		if (ret) {
-			log_warning("Expected bloblist at %lx not found (err=%d)\n",
+		if (IS_ENABLED(CONFIG_OF_BOARD))
+			/* Get the bloblist from previous loader */
+			ret = board_bloblist_from_boot_arg(addr, size);
+		else
+			ret = bloblist_check(addr, size);
+
+		if (ret)
+			log_warning("Bloblist at %lx not found, err=%d\n",
 				    addr, ret);
-		} else {
-			/* Get the real size, if it is not what we expected */
+		else
 			size = gd->bloblist->total_size;
-		}
 	}
 	if (ret) {
 		if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
@@ -510,7 +506,8 @@ int bloblist_init(void)
 				return log_msg_ret("alloc", -ENOMEM);
 			addr = map_to_sysmem(ptr);
 		} else if (!fixed) {
-			return log_msg_ret("!fixed", ret);
+			return log_msg_ret("BLOBLIST_FIXED is not enabled",
+					   ret);
 		}
 		log_debug("Creating new bloblist size %lx at %lx\n", size,
 			  addr);
diff --git a/include/bloblist.h b/include/bloblist.h
index 0f5afec9f4..e65cd27b90 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -438,6 +438,20 @@ void bloblist_reloc(void *to, uint to_size, void *from, uint from_size);
  */
 int bloblist_init(void);
 
+#if CONFIG_IS_ENABLED(ARCH_QEMU)
+int board_bloblist_from_boot_arg(unsigned long addr, unsigned long size);
+#else
+/*
+ * A board need to implement this custom function if it needs to retrieve
+ * bloblist from a previous loader
+ */
+static inline int board_bloblist_from_boot_arg(unsigned long __always_unused addr,
+					       unsigned long __always_unused size)
+{
+	return -1;
+}
+#endif
+
 #if CONFIG_IS_ENABLED(BLOBLIST)
 /**
  * bloblist_maybe_init() - Init the bloblist system if not already done
-- 
2.25.1

