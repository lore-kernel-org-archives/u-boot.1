Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AE9C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 21:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE370879F5;
	Wed, 27 Dec 2023 22:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mrM2N41w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52A2B87945; Wed, 27 Dec 2023 22:08:33 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3905879FE
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 22:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-781706de787so12554385a.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 13:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703711309; x=1704316109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f8mnvgMIPbBqtPqsaKBYOas7zhMJRw1OhTKM8fnQMPY=;
 b=mrM2N41wA7dyutTWZTcUNLJQpgnjRVA3FYPysAxTNYR9O6LWT7a9pSAl2nbsZQmCdz
 vNVV0nxmmf7kG0lBHKRT7lv9vOC5DlvAuiQ+6DgDWFUImpOReq18KP/pnw6AEcdYGNna
 kdnBgZ5oggd1BBVMB8loUi1a67AosbnDfXrelqNBqOD1/uRPBoy8e7blW59twAwfz3Vl
 s5djqw4ywCG4ufVf4BQJwqKhCXIgBZlY7WqA9o/lMPZIx1Pw0lOtQJfPZXPkN6EgikV8
 ZRAugR0Zi5Ie4KnO/cK+oa4prH4oM1SrHkxKcIAe45RbQn/l8Zc7JLMLHWDZuSNc785Q
 eZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703711309; x=1704316109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f8mnvgMIPbBqtPqsaKBYOas7zhMJRw1OhTKM8fnQMPY=;
 b=KxFfH/3P3tIUWdPY5IMIu3fyHy9SpUSWA0n7qpFKkXyOYCQGjKURrrCZOCcgvXLbyi
 aCfwTPcdL6CDHxqRx8EMuj3zq/uuTrIUEErsaRY6bXacPPGNWLa26asFT32nQmTOJxxU
 ASy77yuQo9TtLHUwsnVhNYdJ19Ld5NHJXfDMnQNSZEB6cHMa5ZIHMvsGR4l4UVCULf0X
 S+UpaowA4oTvyfdNslDm4lcWBgw3z3KGGPJbKUt5jZjv942kMnLOObKSE9f6OB2to4Kk
 vFPH9C4RSjKk+4cZwCwpbncI3A6FdHicfo0qeRvayg9i5aQpsc3b/29bilsNkjkZBiFB
 pFIQ==
X-Gm-Message-State: AOJu0YyHD6rgQcKd3VSaNbEJRbCcDl4nFGyOr5moX2L3aegcvR1GFEQi
 wCsf/MxPefCemOYA9whkLy2ti0MPOmUp7H8SYkB8z8idOug=
X-Google-Smtp-Source: AGHT+IFpTsz7mYyNFDNFk3H96OpcL8sqHjFpuJFKMyb1c7BO3qsoXWLzllCf+7ttPJTdclrRommijA==
X-Received: by 2002:a05:620a:880c:b0:781:2db2:49c9 with SMTP id
 qj12-20020a05620a880c00b007812db249c9mr10500657qkn.43.1703711309659; 
 Wed, 27 Dec 2023 13:08:29 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 c27-20020a05620a11bb00b0078161897afcsm637107qkk.109.2023.12.27.13.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 13:08:29 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v4 12/12] bloblist: Update documentation and header comment
Date: Wed, 27 Dec 2023 13:07:10 -0800
Message-Id: <20231227210712.712937-13-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231227210712.712937-1-raymond.mao@linaro.org>
References: <20231227210712.712937-1-raymond.mao@linaro.org>
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

From: Simon Glass <sjg@chromium.org>

Align the documentation with the v0.9 spec.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/develop/bloblist.rst | 4 +++-
 include/bloblist.h       | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/develop/bloblist.rst b/doc/develop/bloblist.rst
index 81643c7674..28431039ad 100644
--- a/doc/develop/bloblist.rst
+++ b/doc/develop/bloblist.rst
@@ -14,6 +14,8 @@ structure defined by the code that owns it.
 For the design goals of bloblist, please see the comments at the top of the
 `bloblist.h` header file.
 
+Bloblist is an implementation with the `Firmware Handoff`_ protocol.
+
 Passing state through the boot process
 --------------------------------------
 
@@ -99,7 +101,7 @@ API documentation
 -----------------
 
 .. kernel-doc:: include/bloblist.h
-
+.. _`Firmware Handoff`: https://github.com/FirmwareHandoff/firmware_handoff
 
 Simon Glass
 sjg@chromium.org
diff --git a/include/bloblist.h b/include/bloblist.h
index 145e5c0242..84fc943819 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -66,6 +66,7 @@
  *
  * Copyright 2018 Google, Inc
  * Written by Simon Glass <sjg@chromium.org>
+ * Adjusted July 2023 to match Firmware handoff specification, Release 0.9
  */
 
 #ifndef __BLOBLIST_H
-- 
2.25.1

