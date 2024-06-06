Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3394AC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 13:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69D4588499;
	Thu,  6 Jun 2024 15:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CKFtcCbf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CDF888464; Thu,  6 Jun 2024 15:37:19 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D78FD88428
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 15:37:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42158db03a7so10147685e9.2
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 06:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717681036; x=1718285836; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fzw6cP1XwfYMFz7w3gkwzemqCEoUwHZFS1rmul+vcRs=;
 b=CKFtcCbf0jmvruJb1ICGJIC9K/+czmcfFSTy1nuqUb7LKIs+hztfG87PMMcG+2pwHi
 ki/U+5Yh0BnUl0nY0pIeG4zDHKLIasTj+Uh7odK9EftigVeKIVCDNpjNkF5kcPLvIobN
 j5N4krF3jHwMGQgGAPDzQD4VIs042ZoOwhwiQTDJWKXi0ERLmjHaqfz0Hmf4WBgbOey1
 +odARIQjMW27ndVD09H9Z9RIPZEeirSVpCNnFRUUkghIQNHfFwmJ8gnSyfnJs3SBAUF2
 vT1Eto3xAPJJramdJXP+0cY65MpZWLZmAx2w4q/IIM67OF7yCNPKblHq4WY7z+ZRv6nm
 wTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681036; x=1718285836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fzw6cP1XwfYMFz7w3gkwzemqCEoUwHZFS1rmul+vcRs=;
 b=ArrmpISJk1zyeXmfyXw/oAW27oiqbOLeZgAN927xcMeFMJoqJT5kcFgmWWa3k6bapT
 jhGCjC78qepL8Oc6paNqhUK3sf8oP23O8uwVsB7M8SQA7FT1rH0sCaK6rJy6BsRRg1eQ
 8m8LK1/hZf73fFhT6YKrkg2KuPVEAvYAHCznrTtddKU49FVla8Gc9QwN7ITLFU18cYrr
 u0k3CJH1+qmsehf1hcL3Edv/0rExG5M+Yotkec/brsVGGwiV5YNZNrHWbnl3kXNNkN+I
 sQe/Mzfux4b/2v9tB92K5i52NX77V6uzxRICUtKJ28KGkT5Y/fymfLSHCpVx/B9sdm3X
 OheA==
X-Gm-Message-State: AOJu0YxOX3j4eRnjvgGDP24uJKn5RJVa9gG9JZfEhuqArGkUftkZtVPe
 S0qm79Fytb5lSIFPMXIU0TemCbjQrw4UFQhSawbSUdqpOim9VbYKn9qfJrtlP+MB40CGszr3rXL
 L+eT/5q+M
X-Google-Smtp-Source: AGHT+IHSiNdaYXEYavG48vHaak7IUMisCw8xIbabNIMloo78cAE/KUB6LGUmZRQrDLIA6Ya2Z1M1yA==
X-Received: by 2002:a05:600c:1908:b0:421:29c6:e2ce with SMTP id
 5b1f17b1804b1-421562d46b7mr51068015e9.7.1717681036191; 
 Thu, 06 Jun 2024 06:37:16 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c19d52dsm23111955e9.8.2024.06.06.06.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 06:37:16 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Subject: [PATCH v3 12/12] CI: add qemu_arm64_lwip to the test matrix
Date: Thu,  6 Jun 2024 15:36:07 +0200
Message-Id: <8c875c0aa6c3a137478526e77cdc192d14116542.1717680809.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1717680809.git.jerome.forissier@linaro.org>
References: <cover.1717680809.git.jerome.forissier@linaro.org>
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
index 27f69583c65..4da1bb12fab 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -199,6 +199,10 @@ stages:
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
@@ -371,6 +375,9 @@ stages:
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

