Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0BDE7AD44
	for <u-boot@archiver.kernel.org>; Thu, 25 Dec 2025 16:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37D278424E;
	Thu, 25 Dec 2025 17:14:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QMZPp4QI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C65D84261; Thu, 25 Dec 2025 17:14:37 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E538C84212
 for <u-boot@lists.denx.de>; Thu, 25 Dec 2025 17:14:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-3fe3cc80bc3so998299fac.0
 for <u-boot@lists.denx.de>; Thu, 25 Dec 2025 08:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766679273; x=1767284073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=dY5yg/IQpIy2/i9j2NvBrpv/s2RjfyCjPljfAFWtDkg=;
 b=QMZPp4QItC5fvkRknX+kEkzfVAWHKxZ6PFPPm/ndJSvx9q50DJN81ShoH8thtRgn+D
 7Pnqh1Jd9xc+pzJJk7qAYkGZRqGRVC77jueUQzeImkGNX8dgXBKX+hNhF3cHl8DXZo5X
 6RUCKS45GrRPOtHfwz+0/+IwV/b/NqHUT2QpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766679273; x=1767284073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dY5yg/IQpIy2/i9j2NvBrpv/s2RjfyCjPljfAFWtDkg=;
 b=CQlJ8oZlc+29g2n5nJzLamuDiPyAk929Z7JppdB6dxBfEddOha6o8ZKZrxgzmH0alh
 FPVhxMroZ0wv8F95HKPYCDF5nToy5booBwLBL6L8n3MMBToYm4d65bLiMwvtobnkfV5x
 /SSw7Hpli6AneT9ZT6cO+nWhLmcJH+Vf/ZaxXjNOwdgVzA3yDklL6IjVyebnZVwv5NeC
 OM9VA5/3MuZsEmikQXbuzVuKa670YuvuesTl/IkmZPjcPIDtDWy2S1/9G6FXTslqxHnf
 sGlB8US+OU7LKEN0E7xsZhp8pcsdfO+MuAHICXzYPJROP+UX7K+qc/BI81Z7gGCtJRrD
 6b2g==
X-Gm-Message-State: AOJu0YxepshoNGUZo3TSdpsaommSfaPPS9Sp2c8d49Z7IqphN/jjGuPs
 BEEWVAh6QjK+/p96vG57AJfrSY8wi/05oIsYdy0zHSeqGVDAY21eziD61NuVTir05DtQVsCERqo
 racRL07k=
X-Gm-Gg: AY/fxX49Hg6hTWkyJMdf9n4eikSiJ5Tc4UuzNeHsBmHbuavbZIqMibDniEVbgv+H7T1
 7gptAD7Y1Lj4Qwl6KjYBemhpq6n/LIEMLRn/O1Sh6tnNbh8CxuzWftn/nZj2Op/+AKQNfya5uOg
 QUdmPbMIsmwT4QrFlozH6qsv/9J9kAYal+MdkKKng4oh+1M3Uk9bj68x+CmTC71RMtMLW3Wfy4r
 zN+/kgstrwiEw8v1v4Rui8GyyXChaExYXau2qiEdMhu14obDzDdyM831Ps7gVZixTR8GIw3OsNx
 30WtPm6YlsMP/hF4/XlsMBTjXAf0Tg5LI5aw2AcanqZxMSXb6MIdonwsqcdAWjWB8j1fh1RCCNT
 dmaPwWN5ROHTR+RG/nHUy6xpITWlYozO7uO+SB8YfKjUC1JUuaWYq+665k6Di3o2B4b/36mUnLu
 AFTNl32ifEFp9Yl+Z0yGQAo8cFI0qOEFpwdBNdIfWrXcKA99zBHiRq
X-Google-Smtp-Source: AGHT+IE+KJkpdyduCFXKzWjbVWt9Z8oo601JV54tfZunnDRdR9BYo9pBfiSdOA7a8/bCfBJx9EKRfA==
X-Received: by 2002:a05:6820:1519:b0:65d:1336:f673 with SMTP id
 006d021491bc7-65d13372053mr7573583eaf.74.1766679273562; 
 Thu, 25 Dec 2025 08:14:33 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f3f8812sm12343652eaf.1.2025.12.25.08.14.32
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Dec 2025 08:14:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Gitlab CI: Add BeagleBone Black to sage lab
Date: Thu, 25 Dec 2025 10:14:31 -0600
Message-ID: <20251225161431.1224448-1-trini@konsulko.com>
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

This adds support for a BeagleBone Black platform to the sage lab. We
test with both the legacy network stack and lwIP.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .gitlab-ci-sage-lab.yml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/.gitlab-ci-sage-lab.yml b/.gitlab-ci-sage-lab.yml
index f2fa0e3e7719..e9fa3e5f6f38 100644
--- a/.gitlab-ci-sage-lab.yml
+++ b/.gitlab-ci-sage-lab.yml
@@ -85,6 +85,23 @@
       junit: results.xml
     expire_in: 1 week
 
+BeagleBone Black:
+  <<: *sage_lab_dfn
+  variables:
+    LABGRID_EXPORTER: "sage-exporter-bbb-1"
+    LG_PLACE: "bbb-1"
+    TEST_PY_BD: "am335x_evm"
+    OVERRIDE: "-a CMD_BOOTMENU -a CMD_LOG -a CMD_BOOTEFI_HELLO -a CMD_BOOTEFI_SELFTEST"
+
+BeagleBone Black (lwIP):
+  <<: *sage_lab_dfn
+  needs: [ "BeagleBone Black" ]
+  variables:
+    LABGRID_EXPORTER: "sage-exporter-bbb-1"
+    LG_PLACE: "bbb-1"
+    TEST_PY_BD: "am335x_evm"
+    OVERRIDE: "-a CMD_BOOTMENU -a CMD_LOG -a CMD_BOOTEFI_HELLO -a CMD_BOOTEFI_SELFTEST -a NET_LWIP"
+
 Pine64+:
   <<: *sage_lab_dfn
   variables:
-- 
2.43.0

