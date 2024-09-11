Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F47AEE4987
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 10:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 617BE89256;
	Wed, 11 Sep 2024 11:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PlLyJ0cw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1204689243; Wed, 11 Sep 2024 11:59:05 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2CDD89270
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cae6bb895so41599685e9.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726048739; x=1726653539; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3bGIbCSvTZOUrrfzEdG3CRsey8qYbjuB8FdRv1iwMkY=;
 b=PlLyJ0cw6Pe60ovfWrS4QNX+KKOBro7EKcXySdTAFeHLrSgH3yHrbEHHW+JOiDwhWm
 sCQ+hj0EegJx0vYvN7ePVWBUh+2I3j+iyFFio0xFyhiXVmOmMpWMNkKqalDpNuEf/ZHI
 8riqQ/YlB1OcW7G8WU3svyq2tb5RZ2E5ashSEgWdHEobrnym3+1klf8obUei9IxtqkeR
 cbeZcKDDv7IQyxxu+M6BeZJqz4+GYegOStZNDIMJD2g/uBJBMo8a1MQ8Lu8tj8VMsjjN
 WMPLs7Mfygt+9yLI5s9brUbdSK3ulw1f5we1DOdP+a4frFSUNcnrhdIQVI46ZUt5M9pB
 OQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726048739; x=1726653539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3bGIbCSvTZOUrrfzEdG3CRsey8qYbjuB8FdRv1iwMkY=;
 b=Axc2RHOoSGMm1GADbd4Ma2pZa3IbnOrDj+z0PZ4fo7wgOee+XH6hKGWmSUG5P9U2bQ
 hgPdZTUWYsLCNaV36wNq5673LKZW+036Cz7MptrsPD2g5MFlzJ+A9kzfU8YvDEc3GBC8
 cqHJJG/VNkguIFKlrb1TpjaaCJAZxWN2bnKfy4RGlIKdZ82kEOkX7afqDF9uFaeX69Gy
 zm9us9aBvdGVK7EnsACjRz+mt314k+gAJc4tw0aS0t4Ao8PqCvVCkvATjnT1gnWoZTpl
 IEqECyQzwhv7IhKbAIF9hHBbk7SaHQjQ/eDARpyQhsel3NvP1NKdPs1Q+1xsJzUMmrkH
 Zb1A==
X-Gm-Message-State: AOJu0Yx4baJSTeyzPcVMsmj4CMIjGrXvXHlTWxhOuCJi3JwqP+fUZET+
 rO9rsycHaLqJ1n5ajc3icY4v8MhRvdcQz7JTN0oPSeVF2EXxZWYwgE5c4hqvj5RLnOviKxZ+mNZ
 +NE+Dyw==
X-Google-Smtp-Source: AGHT+IGKZ1dJ0M21KCvhMhnEZqmsMh1uDl3YTYzJRCFpqffdgJ0b3WuiXA30qgK0MQhndp1qe7xlUA==
X-Received: by 2002:a05:600c:4592:b0:426:627e:37af with SMTP id
 5b1f17b1804b1-42c9f9744cbmr131267525e9.3.1726048739085; 
 Wed, 11 Sep 2024 02:58:59 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7d92:535d:cd3d:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649bafsm11300507f8f.7.2024.09.11.02.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 02:58:58 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v4 12/15] test/py: test_efi_loader: add missing dependency on
 cmd_tftpboot
Date: Wed, 11 Sep 2024 11:58:25 +0200
Message-Id: <6f3df763dd4e2bf01aab7b5c38f1ebcf161db6f9.1726048404.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1726048404.git.jerome.forissier@linaro.org>
References: <cover.1726048404.git.jerome.forissier@linaro.org>
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

test_efi_helloworld_net() and test_efi_grub_net() depend on
cmd_tftpboot so add the missing annotations.

Reported-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 test/py/tests/test_efi_loader.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
index 85473a9049b..7c1e0ffa594 100644
--- a/test/py/tests/test_efi_loader.py
+++ b/test/py/tests/test_efi_loader.py
@@ -149,6 +149,7 @@ def fetch_tftp_file(u_boot_console, env_conf):
 
 @pytest.mark.buildconfigspec('of_control')
 @pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
+@pytest.mark.buildconfigspec('cmd_tftpboot')
 def test_efi_helloworld_net(u_boot_console):
     """Run the helloworld.efi binary via TFTP.
 
@@ -178,6 +179,7 @@ def test_efi_helloworld_builtin(u_boot_console):
 
 @pytest.mark.buildconfigspec('of_control')
 @pytest.mark.buildconfigspec('cmd_bootefi')
+@pytest.mark.buildconfigspec('cmd_tftpboot')
 def test_efi_grub_net(u_boot_console):
     """Run the grub.efi binary via TFTP.
 
-- 
2.40.1

