Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800FCC36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A754381DB4;
	Fri, 28 Mar 2025 16:44:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CWdl195E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C00F981E47; Fri, 28 Mar 2025 16:44:22 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D8CB81A0C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-85e1b1f08a5so58310139f.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176659; x=1743781459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aDArKSdIdLLZb/Cr9/TgTp+Fnpw65D1V9l+fVIn7L38=;
 b=CWdl195EWTcdcimJT60ZAocMDkZIBAMhIp9HYHCCJv3w9igAnXIBmjLIBX1xIBUhX+
 5F933HbKPgry6bEqID8P1nSKx+nAz4kG+HuhUa68rtUDmFxLJBDLk7RrRuaHY5QxTXUn
 ifg5JbFKPVTDtBV+SHMdyeazKWc4fFxrbKZEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176659; x=1743781459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aDArKSdIdLLZb/Cr9/TgTp+Fnpw65D1V9l+fVIn7L38=;
 b=fu3KoB4ixbqOW9LbbA3kCbFXUvPEXayyxXHeBtXNjcYdN5MXXZ6RE7rqXcJyb7HVkw
 LEA/0aAkmIOAo1vuq10I+TyUb2FufqdJlwy4BM1m5pwO017GnB5Y6RrH8PUXLvymnzls
 d9Ed2+jVZBJ6hhmSJsTScD5Gp0Mgc58TLRZt40HLSZHPWWge7QKgsDA0//jLOxYsQMC1
 eo+fe1jsdYEPPw5XCYkis3xLK8UhmB8pJGwqfiEuIXR7CG1ln0k24TDgK/HEgea7byyg
 buKXltGyyYFRXNcnnfN/QcxFASdHMZZ1THO2M1iVVwTJ0Uejsqn+akzOLqJporoiwBu/
 25Gg==
X-Gm-Message-State: AOJu0YzO6viVg1BA/zJH/Uia7EfNn+QKKZbF4w48zRDHxaz3noLpThWd
 pfqi3iPbNLhoIS/D9l0il8SOIGJ4sDQ/7aB4VPJZmBVXDtuQs3Y0O+gxpUAhiJKWzLfewPZs0aQ
 =
X-Gm-Gg: ASbGncvxiXuDX1tiK2GGdRADeFa2AT0VeJv9qJGqoKEGk7P2+xu9AfTLnotH13sbptu
 r4JPoANLd8LovOLq9cOTNK+fjbQ2Xs1MXKZLM+3c2rVw35HuRCiSk2VHGz9onz2yT5wZbeC4WoX
 2zXV5hQXdMLMs/NVcLxeBskVBEYdYtocdVlxpN6qKFG+inEm+rvUtRAj9/cFDcYaDVeWP2Rpu6k
 efk7CdBKs739Qp3wnQ9oc7iIEonVloAnNOjzPCYHdEjDbXmU1ZgYQ5ZdVcTKuWM82wouOy8iMnQ
 So7bWsk5IWIggylCpifkww3F4cZf7hESgCLY6ZvRGSwDbs+pyn3BiBOBmKjpx1NqmOZoHAorwsN
 1JQoG7g==
X-Google-Smtp-Source: AGHT+IHHeQ63SzH6abnAoGp1hHqyZE2AI4Edf5gHOxveXglSW/MceYNbOVJfMw+CEGzew1Eza/8sfQ==
X-Received: by 2002:a05:6602:1356:b0:85e:2e83:52a5 with SMTP id
 ca18e2360f4ac-85e82081c13mr982204239f.4.1743176658513; 
 Fri, 28 Mar 2025 08:44:18 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85e8ffd6b56sm42174439f.17.2025.03.28.08.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:44:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] bloblist: Simplify bloblist init
Date: Fri, 28 Mar 2025 09:43:55 -0600
Message-ID: <20250328154401.3563921-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328154401.3563921-1-sjg@chromium.org>
References: <20250328154401.3563921-1-sjg@chromium.org>
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

This has become quite complicated now, with much of the code indented,
gd->bloblist set in multiple places, multiple error paths and ret set to
different things in different places.

Make an attempt to simplify it, without changing functionality.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/bloblist.c | 67 ++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 6e4f020d7c4..135fb149626 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -513,48 +513,43 @@ int __weak xferlist_from_boot_arg(ulong __always_unused *addr)
 int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
-	int ret = 0;
+	int ret = -ENOENT;
 	ulong addr = 0, size;
 
-	/* Check if a valid transfer list passed in */
-	if (!xferlist_from_boot_arg(&addr)) {
-		size = bloblist_get_total_size();
-	} else {
-		/*
-		 * If U-Boot is not in the first phase, an existing bloblist must
-		 * be at a fixed address.
-		 */
-		bool from_addr = fixed && !xpl_is_first_phase();
+	/*
+	 * If U-Boot is not in the first phase, an existing bloblist must be
+	 * at a fixed address.
+	 */
+	bool from_addr = fixed && !xpl_is_first_phase();
+	/*
+	 * If U-Boot is in the first phase then an arch custom routine should
+	 * install the bloblist passed from previous loader to this fixed
+	 * address.
+	 */
+	bool from_boot_arg = fixed && xpl_is_first_phase();
 
+	if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
+		from_addr = false;
+	if (fixed)
+		addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
+				      CONFIG_BLOBLIST_ADDR);
+	size = CONFIG_BLOBLIST_SIZE;
+
+	if (from_boot_arg) {
+		ret = xferlist_from_boot_arg(&addr);
 		/*
 		 * If Firmware Handoff is mandatory but no transfer list is
 		 * observed, report it as an error.
 		 */
-		if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
+		if (ret && IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
 			return -ENOENT;
-
-		ret = -ENOENT;
-
-		if (xpl_prev_phase() == PHASE_TPL &&
-		    !IS_ENABLED(CONFIG_TPL_BLOBLIST))
-			from_addr = false;
-		if (fixed)
-			addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
-					      CONFIG_BLOBLIST_ADDR);
-		size = CONFIG_BLOBLIST_SIZE;
-
-		if (from_addr)
-			ret = bloblist_check(addr, size);
-
-		if (ret)
-			log_warning("Bloblist at %lx not found (err=%d)\n",
-				    addr, ret);
-		else
-			/* Get the real size */
-			size = gd->bloblist->total_size;
+	} else if (from_addr) {
+		ret = bloblist_check(addr, size);
 	}
 
 	if (ret) {
+		log_warning("Bloblist at %lx not found (err=%d)\n", addr, ret);
+
 		/*
 		 * If we don't have a bloblist from a fixed address, or the one
 		 * in the fixed address is not valid. we must allocate the
@@ -573,13 +568,15 @@ int bloblist_init(void)
 		log_debug("Creating new bloblist size %lx at %lx\n", size,
 			  addr);
 		ret = bloblist_new(addr, size, 0, 0);
+		if (ret)
+			return log_msg_ret("ini", ret);
 	} else {
+		/* Get the real size */
+		size = gd->bloblist->total_size;
 		log_debug("Found existing bloblist size %lx at %lx\n", size,
 			  addr);
 	}
 
-	if (ret)
-		return log_msg_ret("ini", ret);
 	gd->flags |= GD_FLG_BLOBLIST_READY;
 
 #ifdef DEBUG
@@ -620,10 +617,8 @@ int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist)
 	if (ret)
 		return ret;
 
-	if (rfdt != (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
-		gd->bloblist = NULL;  /* Reset the gd bloblist pointer */
+	if (rfdt != (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0))
 		return -EIO;
-	}
 
 	return 0;
 }
-- 
2.43.0

