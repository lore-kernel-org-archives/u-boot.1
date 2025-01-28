Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCFBC0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 23:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4D7680EF4;
	Wed, 29 Jan 2025 00:29:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lYACdObB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64AF380F98; Wed, 29 Jan 2025 00:29:54 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28D10808B6
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 00:29:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b98a2e3b3eso335837685a.2
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 15:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738106991; x=1738711791; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=efO2tj+kddzaFHCvDsS6tYbaqISIP9h2C926I+Jm5+w=;
 b=lYACdObB1wVaWI1v6aw9ZJGop7mvcTzlSJwSMr8rtSPgcQE1lulLeudEWdqk4sQmWJ
 15k2wgfo0lg+kbxXhj3vjhMm1aHJ2T4amKta/F+WVHYJz1b9ymeQGcto8iFhxWCJHvk0
 4nzAKE8Ug95m6Gb1cMjVMyKMVDIgIBGP9kGPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738106991; x=1738711791;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=efO2tj+kddzaFHCvDsS6tYbaqISIP9h2C926I+Jm5+w=;
 b=mpkV2KlxFH4RGVYdLY9GfxAfKpfDNRuczV0cQ9pSg65rdlzK7bEtoAvY74okC4zKfu
 XIj3KIy3B+HZNhk819T9nIFK0biC5RXWB6ceKUVTcHbs0W9R0PKzj+KTYo22mS1DDZC0
 8s6r9ajnA6dxblv/Lb5jsRrJmCGp0EN4e9cX97k2KekKIvsED1RZGEMZEi0YP1cdJ0KO
 PjB0MX4tlYoUx4rXWQjMs6eDAW4+WmPdGl1srCFTzTFkpGTJmuVnfCsAqlawiT2tGzNX
 ZPRZJ5vx5acgSyoPtZEITtKLA5xmXwe0Y/PB9jg+M+G/AxDH/ut/9//tWJ6pL2zdRHaD
 KHgQ==
X-Gm-Message-State: AOJu0Yw6tnL7JOk2pAZNVlS8mE6FwvgO8SyStQfHTZTKb9gb2Tc3Qq8I
 fYuX8YfhG/I0r8w/KQzM/1nZi3ZwbVjxKmRCzD1S6x7E87kC+HaV0sqG2B3jgpenCgWt8YyKOpQ
 V
X-Gm-Gg: ASbGncscDZOAmGMxTf2voig1jsEO9sv+pscea82bZABx6RV3+qDvYHXS22vvE+ZpoVF
 S07RmTskvLeIhf3HS7+TpZMErAeXBb8uCufKA5fGFhScysj7cGh51y5j5HPQJY5satmmwyO95VC
 2bmTtO3GqF7n/2IjNsBdgN18lPxKOFr9AJ5xRJhVm63V2skXQWLdu3f4LEGTG7AoyUi9aig8Ll1
 T624jT4AzcdAL/XqVOo7bI0iFZrdHXCX4mHtYe7OXpPpsvGvjLlFivNsXAeL9RW1d4KlT2wxwFv
 SX5NWRHck9v24L0XtQ==
X-Google-Smtp-Source: AGHT+IF5tShsH5JJCgPz/CEv3y6Ki6mBXzcDxK71HD98ZI+b7eqyWWAwxMa7W7aeO2Og9vw03wguRQ==
X-Received: by 2002:a05:620a:d85:b0:7b6:dddb:b88 with SMTP id
 af79cd13be357-7bffcd906a3mr114387985a.38.1738106991014; 
 Tue, 28 Jan 2025 15:29:51 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9af0d39csm561813785a.102.2025.01.28.15.29.50
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 15:29:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] GitLab: Run sandbox on fast amd64 and fast arm64 hosts
Date: Tue, 28 Jan 2025 17:29:48 -0600
Message-ID: <20250128232948.2064724-1-trini@konsulko.com>
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

Now that we can run sandbox on arm64 hosts, have these jobs run on both
the fast arm64 and amd64 hosts to catch any issues.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .gitlab-ci.yml | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 74dc05d58a70..f5f466f129b3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -230,30 +230,46 @@ Check packing of Python tools:
 
 # Test sandbox with test.py
 sandbox test.py:
+  parallel:
+    matrix:
+      - HOST: "fast arm64"
+      - HOST: "fast amd64"
   tags:
-    - ${DEFAULT_AMD64_TAG}
+    - ${HOST}
   variables:
     TEST_PY_BD: "sandbox"
   <<: *buildman_and_testpy_dfn
 
 sandbox with clang test.py:
+  parallel:
+    matrix:
+      - HOST: "fast arm64"
+      - HOST: "fast amd64"
   tags:
-    - ${DEFAULT_AMD64_TAG}
+    - ${HOST}
   variables:
     TEST_PY_BD: "sandbox"
     OVERRIDE: "-O clang-17"
   <<: *buildman_and_testpy_dfn
 
 sandbox64 test.py:
+  parallel:
+    matrix:
+      - HOST: "fast arm64"
+      - HOST: "fast amd64"
   tags:
-    - ${DEFAULT_AMD64_TAG}
+    - ${HOST}
   variables:
     TEST_PY_BD: "sandbox64"
   <<: *buildman_and_testpy_dfn
 
 sandbox64 with clang test.py:
+  parallel:
+    matrix:
+      - HOST: "fast arm64"
+      - HOST: "fast amd64"
   tags:
-    - ${DEFAULT_AMD64_TAG}
+    - ${HOST}
   variables:
     TEST_PY_BD: "sandbox64"
     OVERRIDE: "-O clang-17"
-- 
2.43.0

