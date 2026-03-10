Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DE3FD4F05
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 16:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7076B8412C;
	Tue, 10 Mar 2026 17:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PD4znBBL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0307084154; Tue, 10 Mar 2026 17:26:23 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDA06840EE
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 17:26:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d73dd9cb9bso1782646a34.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773159979; x=1773764779; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=M3T8JriPGP6qC6NhLcUwiIxkkLO9bw0olV5MRiA3jIg=;
 b=PD4znBBL1KUIFsXFnagQWK4JsgFeFlGBRBvloAkQXnCSGKxC08fQhOKG6ebVMMsEud
 VKz7UKFJj3MT2LtRSXPb7vP8GHbuPDrZlU5FUzGPhcmIO0n2jN1tEtT9dKKlK0VqvWq/
 b9ixDIo/Tfd2SlOcIhJFbvjGDYrjLfhXGQUEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159979; x=1773764779;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M3T8JriPGP6qC6NhLcUwiIxkkLO9bw0olV5MRiA3jIg=;
 b=a3kYjSGeLvG1o7Zs9A7uREEmzpGp4AyMKWtdKqTuCYGmWYDxOva/8b2met7yrxN6p6
 553A8qBkr12nYPEAvihM4TuBlN+RKqCBHYe/irUf0aGZVu4U1ochWrGzLx3IP1Ls3ptd
 ZMKs6l/gjTJlAcxsPU9RydOJvcPDEW7GKbvrWcXgz9YKDLhYzathFMygIn1+FO/EpA7S
 h2MqFdWjrK4F8u/DsNAIkv/1t1v6HiwKuMrlrjJWXalEcUBnJtDNyeFxx9Vmj8Io4VNa
 ET5ApFNWK0UWF1vJdNb0y8RKShXNjAZ1HtRBhcEcG4+CDuXJIcX8xXInuD/BxK8SWM6j
 SlrA==
X-Gm-Message-State: AOJu0Ywmx3WSbm6cx9uLPwpFyENVUobJQ+LWbL5SxDhielmqPIzWvO2h
 RKwvnG6nqRtiVPapG2Q+OSL3LFg134c3myB/1vEXioR9EdSSN06+p8UGWoTDvMDdoltFnOOOtws
 qgSSEA0E=
X-Gm-Gg: ATEYQzyTn/tEiTtIaDUtLklb3hSeBA8Nup+7N/L/gkYOUwzmgAuGfNHI+L1oFpo0X9z
 WhokSvFcA48L5p0nmOrgvCvFZfNjjqFIgFBSol7dd7Wa/USjvPxiFC2QafBUuAjL+8Y2P2sR8oV
 u6IZmojE2gLKhzeAQOTjID5qayTiGXC7oKgKoKtzlNZFzYh43PkShOR5n64Sb+oCyaUCC+9QLBq
 Pq4sskdlmzYTg6BSK+sZPTYlYeIuhTIAEYZGcIdTiPOCNB3D1RcAO3Ow8wKnBVmadxq3bXlUepE
 HKx7/IhxzwKZ3fPcHKlPtKrSWoCfI2iIn35cQFF6xq7kwUhenSlHdxH1bm+dQi+06ECR3DAPJlZ
 IQmB7+n0XqU1v/yU7IJoaCfGyoAKTx0yDJHTAeLU6eKCLhQoE5+3ZbQsFoTNdr+i+o4/yB9lNNI
 TmdAsrzFXsmcMo4GRI4i/Qq5fCLCufi9KQECLWxvdddtsRGG6NAbW21Xy/lrH94G5UiN118IrX6
 Vqf7xxrJI3StLA94jvh2DJI45Ew7HsM00Ab4CPEbwoFe0Is
X-Received: by 2002:a05:6830:6ac3:b0:7c7:8113:6f6e with SMTP id
 46e09a7af769-7d726f59c34mr10399589a34.27.1773159979472; 
 Tue, 10 Mar 2026 09:26:19 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7449b9e57sm5312667a34.22.2026.03.10.09.26.18
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:26:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] FIT: Image pre-load signature support must select not depends
 on FIT_SIGNATURE
Date: Tue, 10 Mar 2026 10:26:18 -0600
Message-ID: <20260310162618.1163914-1-trini@konsulko.com>
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

The options to enable pre-load signature support (full U-Boot or in SPL)
must depend on FIT_SIGNATURE being enabled, and not select it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index e5db165424a7..42d39ff02f5f 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1810,7 +1810,7 @@ config SPL_IMAGE_PRE_LOAD
 config IMAGE_PRE_LOAD_SIG
 	bool "Image pre-load signature support"
 	depends on IMAGE_PRE_LOAD
-	select FIT_SIGNATURE
+	depends on FIT_SIGNATURE
 	select RSA
 	select RSA_VERIFY_WITH_PKEY
 	help
@@ -1827,7 +1827,7 @@ config IMAGE_PRE_LOAD_SIG
 config SPL_IMAGE_PRE_LOAD_SIG
 	bool "Image pre-load signature support within SPL"
 	depends on SPL_IMAGE_PRE_LOAD && IMAGE_PRE_LOAD_SIG
-	select SPL_FIT_SIGNATURE
+	depends on SPL_FIT_SIGNATURE
 	select SPL_RSA
 	select SPL_RSA_VERIFY_WITH_PKEY
 	help
-- 
2.43.0

