Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10775C52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44F4088C61;
	Fri, 23 Aug 2024 15:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jp6NflvK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E131889ED; Fri, 23 Aug 2024 15:50:14 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D55AF88C08
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-371a9bea8d4so985612f8f.2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724421011; x=1725025811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YReqvMd/BxfFFS2kjHJgaJSXZI3pm+qMN/lkAT63YpM=;
 b=Jp6NflvKcaQtrmU2bUTRx3ovxeQ7p1KtMCn6OtsKm7LyxVe5l0DNIJPG/gb9soc6p0
 f9GQh3TWIsvj89uuWeC0ZgN+GbVAZ7foo3DI69BMg0PUau62mSK8WmZJjcgMAOAXgwXI
 0m3kLYDUQavh024hdUH4dZLdm+QB5CgQHSUxXU/gZ/nyv8ugvMxSr1Q8L2lAraDNJNwf
 F1EmGZJT5HoFmzQcnPLOGzBdiJLsvFCErGhEfFRwx6mKwXPEstgE75vYwvgohWH19jp1
 ken9tNEblPzKA77pq4OcmRtFAas1x+PD2pCl2oZL5cIEUf4xQRDNQyxjbSnBo2F1eNoz
 4tFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724421011; x=1725025811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YReqvMd/BxfFFS2kjHJgaJSXZI3pm+qMN/lkAT63YpM=;
 b=X7eo8o1yitJS5otD2Lpin9qAWJIRuWjGdb3UrZW2f1vwmySZcZSdSuwL870vYOZZxv
 HZZnfdYy4sDfzWLj+Mtpj+9ojlM+r4JdXAbcHztuWdFLKMkKEOaHUOWZ8+fzZaNtdSmt
 MQEV/RxTnBezeK094ZVXvRud83uQFp70lNsKBthnUO084PtqNvQyJ7iD1TtD4VIhj+6Z
 E7Z0V1wHc0YqDp5oypgVLq7lJ4fLGjAWCsDEIxFvHjfDPuTnDwhtvWZ5ScnRrEtE40b+
 yzzGj75c0uCn1hKgF5CjS3xuRE/1/f5btkTP90kQBu2JKV+veVRZiW8hKWYz+I5KDzr0
 8QRg==
X-Gm-Message-State: AOJu0Ywsb932teUxh/1AqYCs/DzTkVLsoZ0KBjByyaFPoPOl+IA+DLGM
 2ZlDTHB1Du/9x7HrXh2qxKdv0ireq8D3/EnJQB2XwPnrpYg/WiF60Bw1XuVG257WDRx+HH5k23Y
 fIJxAJgyp
X-Google-Smtp-Source: AGHT+IFN7Evm+qyMyVtEA4TgDri5Vejyt+XDwVhSJMJPtNpHK0jrGy3ATcAar7x0scKU1zy4bUkWoQ==
X-Received: by 2002:a5d:66c1:0:b0:368:74e0:2068 with SMTP id
 ffacd0b85a97d-37311865155mr1536883f8f.33.1724421011079; 
 Fri, 23 Aug 2024 06:50:11 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:50:10 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v9 31/37] CI: add qemu_arm64_lwip to the test matrix
Date: Fri, 23 Aug 2024 15:48:35 +0200
Message-Id: <3aad66cbc5eb380993fd4f9409167d91e9746f06.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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
index 93111eb6127..59fddb96a48 100644
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

