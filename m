Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCACBC54F32
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 12:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35B9288B6A;
	Wed, 28 Aug 2024 14:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="trmFF7eK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 446FA88B55; Wed, 28 Aug 2024 14:10:56 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6216888AD2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 14:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4281c164408so57193285e9.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 05:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724847053; x=1725451853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uOvm+usFf/OfMNJfit/RQ0Rx+oQkfNfrdGJgctlqbYk=;
 b=trmFF7eK+waUtCqcODGbwbdMJdreP1EdnPPCoiqs4RnJR9V8xEcTNG6wQumkEhMdEP
 HTad4+QMstczZRxVPPwwudBauXej2lJ+RB3fJe5esdPfdYqCfW0D3lZYnSYW6ScTUG5+
 +2D/ab7+2j3Id6YobycPsQ6Uwhx0jWnhZQ2/wvcG6HfX+myAtx4tYh3RwE7rJHKbxYtN
 9ApNokRzuvIqShWna0krxViOMxFpyFxZYS6kteLPM3T21O3sOzjM3bptEKDCYMoZqpEJ
 yQKOwVtJKvsj4pQIJpYU4GUq6Nm0k6sO4vShGYi2xqx50fPZ25OuQmxaTDEp3TrV9ByN
 RPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724847053; x=1725451853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uOvm+usFf/OfMNJfit/RQ0Rx+oQkfNfrdGJgctlqbYk=;
 b=O73JAceRhaafxH70j7RAkTnDSrmwRu6f1662fa+zCRrAoLpd8RomMylh/1KI70swJL
 KfGU/cNM9dKsDhJMkZAF4I0NHg0JUuMuYktMEmccQ+9eLoh6rjtKC/9A53ZEh6K0Z/e7
 BQXDJauaH2aF8rdz5gTInlXmcYGR/tUkkecKlh9yZKnlojlL8O12HWvkbHHQVQCrCsNm
 TN3sz6VnxthTaDQeh2V2ZzHrVi87Ese1YEW2sYaoFUqX1J6pxtOhWVfS+/cmYaTvHyKl
 OlE88QzqyyTgM12tfkbDvPmggdR5Cgeg7jjK6Hp7p+HB7gOifK2qm2+nMQgp0cckoVde
 6brA==
X-Gm-Message-State: AOJu0Yz2h4wSKzZ1DXLe3NDAiRL9yTRTGV6r+db7wUZeI7+ndZHSRHuG
 HuLgHvnqRl662/AsPjyAf7aOEog6YKo0hS10Q7RplUwg8uMCUBV90YGrxGXm8mTzesvCfKCJ7Yr
 SavccgAMA
X-Google-Smtp-Source: AGHT+IF+RKZw+841g6OckxKyD4tBNYujn2qHWMN69RcLQW6JZt2WXxbN1UO63rz8nb3Lpubib7ajJQ==
X-Received: by 2002:a05:600c:a0b:b0:42b:8a35:1acf with SMTP id
 5b1f17b1804b1-42ba66a8dd7mr12594775e9.25.1724847053536; 
 Wed, 28 Aug 2024 05:10:53 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:8ac3:aada:f033:985a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639687csm19470365e9.8.2024.08.28.05.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 05:10:53 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 12/13] test/py: test_efi_loader: add missing dependency on
 cmd_tftpboot
Date: Wed, 28 Aug 2024 14:10:35 +0200
Message-Id: <f58fb904ed74d2f458d58fa3dc42a6c0914627fe.1724846454.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724846454.git.jerome.forissier@linaro.org>
References: <cover.1724846454.git.jerome.forissier@linaro.org>
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
---
 test/py/tests/test_efi_loader.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
index 85473a9049..7c1e0ffa59 100644
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

