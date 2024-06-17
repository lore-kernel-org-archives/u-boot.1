Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E041EC27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 15:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2479F88403;
	Mon, 17 Jun 2024 17:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rpwhyHMx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10693883D2; Mon, 17 Jun 2024 17:33:55 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52D8688403
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 17:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-421798185f0so35083495e9.1
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 08:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718638431; x=1719243231; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fzw6cP1XwfYMFz7w3gkwzemqCEoUwHZFS1rmul+vcRs=;
 b=rpwhyHMxasn1OK+K0PakxJKJQV5x7K73882KoR5UFhH1uELN4V5NucItydUEhbtKeR
 nQs4rlH6DVtPitK7vzlDGLnPqn8cco4nS2lQXEDUM6G4RQTEktZnEj03hGA+SbypURfF
 9s0VmrlBeJSiGth8fgpPYlWom5BZByE/kweUIOVvGBV1eXSdKFHWsA0dqQzYbxKpTB4K
 +VCFrODosOsXz/70pY73CY9+EcfD+YbTT/SYvCh7eEsejgOXlaiWF9k85yWCUfKmHtWh
 z11Tply0OgcSl7OtbLkENrb3PGXB3AETll9POEIJuGW3BB1n6AYVkWmjYofmt3fRPcsw
 GWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718638431; x=1719243231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fzw6cP1XwfYMFz7w3gkwzemqCEoUwHZFS1rmul+vcRs=;
 b=JVoDxIupR+G+wHlyfkr523jjPXO1GAjtejUlBEpaHA1dCzU6hMo7l1uyIeN1fr2t0S
 HE8SPJAW9mWOMo6NfJw/g/TvKhuiufqzLYUzQA9qIiiOgxh3Xvr3fi+Ddj05dvu+GPwq
 nO6B4rEx8F3ezVteNMb2E+ky0OSGfX2L5eEd0LVvm5wq89xQX6seKZs2p7vNqnZRoaOi
 Y0k5BreVSjqmZVlZh2GRqVKayvtn+C398XhAsterdASn/lGC8Luw1E9LaZhTamjjUBUw
 FAEX6Uba6QJvz3ZOVa2EtJpeHELt6w71aGwU4F8bodPoimatsmpOeQunOEfl4HQUlFfT
 aITA==
X-Gm-Message-State: AOJu0YxlxQJlAgT9b/2rri7WDt3yfN07EbHek4xoGgvgrtZt62oUXF/4
 JbYEXct99bCyXEH+xDxIotF2axLFEh6lQF0/PcUg0LS8Fa0S7n1wfVGduJosErTWmvr7JuVe1p6
 ka0A=
X-Google-Smtp-Source: AGHT+IFIMLN2ajYR36XzoCJRLZM2QBh0eOXXESqez4xI7O4wSpJHfKKvmKbjWK4l9Lg7oELGDAA8pQ==
X-Received: by 2002:a05:600c:524f:b0:422:5953:347d with SMTP id
 5b1f17b1804b1-4230484502cmr79277285e9.27.1718638431693; 
 Mon, 17 Jun 2024 08:33:51 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6e75:be8f:56ae:2b5e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602f620sm161350895e9.19.2024.06.17.08.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 08:33:51 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Subject: [PATCH v4 14/14] CI: add qemu_arm64_lwip to the test matrix
Date: Mon, 17 Jun 2024 17:33:06 +0200
Message-Id: <a82a5fa96124109039909513c03a2e4e730136c6.1718638104.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1718638104.git.jerome.forissier@linaro.org>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
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

