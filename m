Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B6BC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 09:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5454F80BAD;
	Tue, 29 Apr 2025 11:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V2FN19zw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DECAE80F03; Tue, 29 Apr 2025 11:58:04 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4B70809A5
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 11:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so59401315e9.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 02:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745920682; x=1746525482; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0/z4Y/R/KQCEDvxoLHcyllV3vfJ/KcFBw3AcCvdqpq8=;
 b=V2FN19zwFjls8cvyqoC0D/IqpauRhzHIso/iDiR8m5NppHb2143xT5pxkfTVrtlxm3
 a8c2c4yjfGPfwRF+9vZdFJ+9ynFtTIdcuTqCB7rRcviETFP6ZucL/cTqqW5qIPxErh+k
 +rT6k7E/ADdbtnGi0ngkt2gzmTpkFtuNtcvpSa4cop50R5Bwkwq15TSnAqh0XxWh4ZAl
 v8Pa6RHy21LVn+FW+HsNPBYamAv+zdG7w+4mfm6xISPxKktEloQTPUSHL21s6heW6kOz
 JPCJOEkjB5yldil0JE1bT2vYEUVElDndwdFbUalHwQkyFcTXbeZ4bGZpYAArr+tv1lXw
 r2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745920682; x=1746525482;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0/z4Y/R/KQCEDvxoLHcyllV3vfJ/KcFBw3AcCvdqpq8=;
 b=Sks9y7REY+2ZQLQssRvW+lQ+Eun0pIFpNqTMDalHBsY7I4SgXCbZNaN/yTAmcdRTfL
 ctEBRPGVLKJtJhbjjO4h3D/vNOyADLuDzEIiYuabZGN3a7zfGEhO01nLfPBAtO1sfgNl
 GdVUyBjM7YBtkfNDRYxOeL2BsgNwnDubRXOFJBrrvmUovVxRRMOrdlFZb1C0Cy3QlqjF
 VYxJt9JV7b7KNc+7FZW8AJ3jOCPOXKR108E+ByI0mDInGm/c8+kEaTJHSPDE2jYMpsTC
 UE2iwYyWkF49uRaE4VTgaqTevfDvkS0Sa86Qs6M4b6UINnpJgl+HYfz4QWwKlwVt8EWG
 HwiA==
X-Gm-Message-State: AOJu0YwcKcsWv+s8ycftUiF3nGGFwZXH9wpxYikZI2653sUMmfXV4qfn
 /xSVA5bs6PtlJMykxAJ4kmg1nNFjICr6u1PhqIzJP1WgshNo1lE9mVAfPn0VY2m7rsc6XtSLw07
 PbqM=
X-Gm-Gg: ASbGncve7c74eniJQhcaCYZ1QEO8NtM/RKrBp6uSZEUDLUGHkUreQBKkmRhCpXTsy2u
 0zeD29ZrVeSiaABS4ogl7czV0r8kPNx2qK2k8d1ozKdiNB6Jjkwp1xsxmKkVmlHzj13Fdp6WYvh
 gKs32Q4yPDqu5jmxlCz29gxJx2hTS3eoxY9ZEhRwMRtWQhK3wxNYH3OOEJVy/qUL01MSJANnlco
 I70hfSIkzNXeHa4I+81ARCvJ1o1/ZQ0G1gIviOx484kiXRwvJin2uC8tYuAF3uQ+cuAEABL4wW/
 8ZbAvqXH6YwupDPYWMMb61MSQrtsZ2Jhp0/GhOat6lfFSP7tcw==
X-Google-Smtp-Source: AGHT+IGIWDxvt/057AvhjLw9hiVwzMGDfZCf8SUilOok5gIhIv2+3TiOXEY0j3VRPv9KnJXmTzhr0g==
X-Received: by 2002:a05:600c:5247:b0:43c:ef55:f1e8 with SMTP id
 5b1f17b1804b1-441ac856c92mr22357445e9.13.1745920682064; 
 Tue, 29 Apr 2025 02:58:02 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a5a74314sm155792445e9.4.2025.04.29.02.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 02:58:01 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] uthread: doc: fix inline documentation
Date: Tue, 29 Apr 2025 11:57:34 +0200
Message-ID: <20250429095747.3867260-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Fix Sphinx warnings:

 $ make htmldocs
 [...]
 ./include/uthread.h:56: warning: cannot understand function prototype: 'enum uthread_mutex_state '
 ./include/uthread.h:64: warning: cannot understand function prototype: 'struct uthread_mutex '
 ./include/uthread.h:56: warning: cannot understand function prototype: 'enum uthread_mutex_state '
 ./include/uthread.h:64: warning: cannot understand function prototype: 'struct uthread_mutex '

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reported-by: Tom Rini <trini@konsulko.com>
---

 include/uthread.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/uthread.h b/include/uthread.h
index 89fa552a6f6..11a19aa9488 100644
--- a/include/uthread.h
+++ b/include/uthread.h
@@ -51,7 +51,10 @@ struct uthread {
 };
 
 /**
- * Internal state of a struct uthread_mutex
+ * enum uthread_mutex_state - internal state of a struct uthread_mutex
+ *
+ * @UTHREAD_MUTEX_UNLOCKED: mutex has no owner
+ * @UTHREAD_MUTEX_LOCKED: mutex has one owner
  */
 enum uthread_mutex_state {
 	UTHREAD_MUTEX_UNLOCKED = 0,
@@ -59,7 +62,9 @@ enum uthread_mutex_state {
 };
 
 /**
- * Uthread mutex
+ * struct uthread_mutex - a mutex object
+ *
+ * @state: the internal state of the mutex
  */
 struct uthread_mutex {
 	enum uthread_mutex_state state;
-- 
2.43.0

base-commit: b249e08ec9b71f9d0b4eb48e3e63f63e8366b7e6
branch: uthread-doc-fix
