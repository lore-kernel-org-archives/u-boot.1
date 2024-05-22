Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EE2C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 259BE88867;
	Wed, 22 May 2024 18:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MYgp+Nyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FADC87E06; Wed, 22 May 2024 18:04:51 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 664E388836
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a59cdd185b9so229844866b.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716393889; x=1716998689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEAs2aZLrkt9lcF9nUZb8UL2Rg8wMiLGKfGqDIgcbLc=;
 b=MYgp+NyuhBUyxEJwTTWUPr0WUmsVvD5XLqNec9psQLqa0Cuc9eDYzhaOhVd2uEqSiN
 RESVyUwYlFACKwH4Bd+7IFrKqEZW82fohUdJ7gkSvPQS3itu/wqECVasuJ0VkyT2ccxU
 bZIATv+6dzG37A0jWqiYLFdmjUvg9qpzJYG2bV+Pmpsi9wV5APamQm8ybImV2IIMuCuV
 dxW0cWzEu9TwjqBQH/M2VwzJYo/eURcuNspoOBX4rZL45vn5HGmhe6A4artvvLgFQnDp
 +udt0o5P2x+jolpr+Obsj7pJK8bmeUFbBNOcccBrO0OSh56dlqsl4wUpwxvkANOlN45k
 AZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716393889; x=1716998689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZEAs2aZLrkt9lcF9nUZb8UL2Rg8wMiLGKfGqDIgcbLc=;
 b=ZR08Wg5OigzZMJFjrc/+wa4+cL9GZPLbk+UbdRoQmvknbyVDsIM/c7WNq31ujL7U7g
 VGyqyJwlgqAX2iI+umThDWlN5ZDES5kbuRVbx1RGuCo22MHmqCR+V0nWeZYj7W+BC4ll
 T6auvq9Hf6ONDNyq50v/SjUCq5DSREiCm42tL4szZZctu2/dn2iBlXswNwroAhIOz1vq
 j4sh4HKRhxykwKeJD4cKRObGxCPMlzaZ8VaqyrnxkERe1XrGLezKxtNgeMDaQSzoqWGq
 YALnojqFjsvfrDoKULuoHKhG49tUzeWr0Jsc5jCopCMUMQIuc74SkMD+nS0e5HIzvgmt
 ldAg==
X-Gm-Message-State: AOJu0Yx0SALsRLxcoMsie4Rw6vZU/uz4Fnm8JyFSbYbiPfKBvuOFiR49
 hBYVVE+Rd2SBwNWdl6GEcGR5GTgnxz1cOGJFGgW6vBsCxUcdKKpx3bfo82+excsb/cM+Hy9+oBH
 LtES7dPj8
X-Google-Smtp-Source: AGHT+IH5luKlCLTXSMlqc2iC9F+PJXJ57d/aOg+sSPS//LFgyPHSZ5IOXaqQw3TARA6/q3EZmLpCYQ==
X-Received: by 2002:a17:906:698e:b0:a5a:5bc8:9fcf with SMTP id
 a640c23a62f3a-a6223320e03mr176845966b.36.1716393888747; 
 Wed, 22 May 2024 09:04:48 -0700 (PDT)
Received: from jerome-XPS-13-9310.. ([2a01:e0a:3cb:7bb0:d6a3:fbd6:c45b:172c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6209f64ba8sm367670266b.210.2024.05.22.09.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 09:04:48 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Subject: [PATCH 15/15] CI: add qemu_arm64_lwip to the test matrix
Date: Wed, 22 May 2024 18:00:15 +0200
Message-Id: <321b32baf8961a43356b8558f30770bfc82db6f7.1716393035.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716393035.git.jerome.forissier@linaro.org>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
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
index 27f69583c6..b036999210 100644
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
+          TEST_PY_TEST_SPEC: "test_net_dhcp_lwip or test_net_ping_lwip or test_net_tftpboot_lwip"
         qemu_m68k:
           TEST_PY_BD: "M5208EVBE"
           TEST_PY_ID: "--id qemu"
-- 
2.40.1

