Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DBBC52D73
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 17:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43A8E88D5E;
	Wed,  7 Aug 2024 19:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AQyPbpHv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58ABF88D75; Wed,  7 Aug 2024 19:13:29 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2031E88D5F
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 19:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0481so423641fa.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 10:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723050806; x=1723655606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JO6QDMARiBGP733sS5JXF8LmB5ZyYuzey+MxW/9peVk=;
 b=AQyPbpHvEjueuRDYyUMiyYef6qFBwXKRGTyXEj9w9wc0mPb2EI9ixnbOg/QQJXNu3w
 htRDlDgvu0pUha+Qf3CBnZfJsK5oui7ybQzsKQpPjjzBfJpWo+PMR+jDbSIosCAC/cEc
 YBRM4uNtiUED+qX+i95xlEX5UYEwZLouJyyxATqvyFLqIh36vvkta9dJhM8AZt2xBMJc
 jVF+Bzl3CcpLMvL/1/g/FX6d8MqIcHayYpZ+I3NxYQAppsXhGNP2702n51wQYnn1Z1wV
 KDUswnShqKOYXqy+Q0bxqo+F1z9awUeRZQtOnhdhxAb3e+6jN8yR3HnOwdLDfo/58x00
 baKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723050806; x=1723655606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JO6QDMARiBGP733sS5JXF8LmB5ZyYuzey+MxW/9peVk=;
 b=TXBD+ISfhQhA07Ebx0EGDwPi51/TqJ0DRNvSYjSFLB7GPaEt8enr1rmUh6k9u2Ch3p
 HifloTlVaeKpRCHLqj+RAfr/JFiI6cFDhdTd2cUe9BAlTzrWajmRPJx2ZaohiHzSKfu9
 /347aoK6oR8FZ3UFNp7f1tH2eTw1nZElyuxWYxBbnWF5KmYKQq3SeUW+8ZeIKr/0U1iZ
 HfJqkPalQ19fLOisO3+KtCAXri58JuSo5OJqAwBHI0wakxkiJxoqdwb0aYRqxnAlBCCy
 zmy5NNUMMyO/LFA7azRnfQnHbTuvWPUNIgf/pRz6I1xrf0MahWTm2NATcCsQ1pinKjs7
 N1kg==
X-Gm-Message-State: AOJu0YzXezXZZbWZuEjwuYOl+Kj4H5MZzMJfCnGEwY61Jw6ZxV7XnsLa
 mwYqttXZRRks6W4JgxANjia9mnwQN3EoDEALBEl+VhPsspT/gL7dHUYo/kwYFwN06O5REFbf2Jk
 88ucSojyA
X-Google-Smtp-Source: AGHT+IHCRlAVqTHjie565iW3adiDQR1UfF8CsbwKMalG/oDnPQXTkwaj2LkCvMyrdiDhgaZs0elIHw==
X-Received: by 2002:a2e:7412:0:b0:2ef:1c03:73e9 with SMTP id
 38308e7fff4ca-2f15ab37fd4mr117141531fa.42.1723050805962; 
 Wed, 07 Aug 2024 10:13:25 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bb3d:43b8:4780:757c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd0597b2sm16623781f8f.81.2024.08.07.10.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 10:13:25 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v8 21/23] CI: add qemu_arm64_lwip to the test matrix
Date: Wed,  7 Aug 2024 19:12:05 +0200
Message-Id: <05cf9de8e62f69a7ea4fb580256321b949218812.1723050310.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1723050310.git.jerome.forissier@linaro.org>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
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

Build and run qemu_arm64_lwip_defconfig in CI. This tests the lightweight
IP (lwIP) implementation of the dhcp, tftpboot and ping commands.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 .azure-pipelines.yml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index e1b2f87b974..b61fcd2ef47 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -238,6 +238,10 @@ stages:
           cd \${WORK_DIR}
           git config --global --add safe.directory \${WORK_DIR}
           git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
+          # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
+          # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
+          ln -s conf.qemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
+          ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
           ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
           ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
           grub-mkimage --prefix=\"\" -o ~/grub_x86.efi -O i386-efi normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd
@@ -415,6 +419,9 @@ stages:
         qemu_arm64:
           TEST_PY_BD: "qemu_arm64"
           TEST_PY_TEST_SPEC: "not sleep"
+        qemu_arm64_lwip:
+          TEST_PY_BD: "qemu_arm64_lwip"
+          TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
         qemu_m68k:
           TEST_PY_BD: "M5208EVBE"
           TEST_PY_ID: "--id qemu"
-- 
2.40.1

