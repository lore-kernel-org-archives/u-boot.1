Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58062C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 13:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2138788C01;
	Fri,  2 Aug 2024 15:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nNjO5Yvp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBC0F88BDB; Fri,  2 Aug 2024 15:15:14 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1132C88BE8
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 15:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3683329f787so4391171f8f.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 06:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722604511; x=1723209311; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7TWzcWquaQI7xooWzlskMPHnuATZZ70zkpWtFzdSzOE=;
 b=nNjO5Yvpy6hJp2ZLZxLu/Oz2yrVlMCxbm0hce4hqY+wHlggWyotDvQiAGy94XF/IQy
 NhQ+l0xpFsSFDD+J31DCyt8m+xmFIK9P/s5/ObNWuNUIwFNDgIfe35VHfQf+gAJzkxWH
 DfNCRkgnqOt0+ua8fPR6EU6L94mR+O2wJGI8NWRCKKPFfX8qJ3KuR2xz0wlwjkidsOaH
 G73gGJRgpyte+sUGzi0bQBJsUil/diy6traJCVk8d6mns2jw+pmEWKZIlAqt8ar4fKHG
 0hSUlq9EgY/DvA4SmVdEYJHWdauM2L8JwqoVv5ObM1NUDL9QKoeQ7hjviVNairEdq7OK
 dZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604511; x=1723209311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7TWzcWquaQI7xooWzlskMPHnuATZZ70zkpWtFzdSzOE=;
 b=eK6vMofx4+JLPdd6SThPl2tW0E1R8HPZ4T3cOqv/rlf3+eW9SFbWJi1ELfxVgyjdaV
 9LIqPiy7zG9Rexx/4lXmJwf9+YoJVW3EH6jFZa1aoHWn5kIpK+8JAfPlP6m9S9AnZ6D5
 56L/KdgGXGwKdlCZPfBmfIqs1Tiob3fxZ/l4J5EbHC7fxUo2oHLbZLA9klI2jixe+4N2
 PyPXzBh30Ug2H8apFoYrFY3WIGSBl6558z/ghMn8UKo5IR0EbJ1dSVDGfbKqPfH4s70a
 DtRvk0W/5K2hyabhjDT5xLD+kWSPMN7STdKg0G8IouugU43V2jYb3cicoMy0rfUznANP
 V9FA==
X-Gm-Message-State: AOJu0YwnX7vdd6AfdhKMm4SXD0NuF97oE2hYDxLtTyAiN4x1selFu8DX
 8vC6eurkOrvQB43O2dGyzAat/SnyYExhSSXQpgdHnUfe5H1aGp4wtq1xu+dYxGjAjmVAjJIciFx
 7pBjJH/j2
X-Google-Smtp-Source: AGHT+IHMTPVEVyuYeUJhs1ZCzopYVBjCvX+DoXvniUWzp5ASwgrXD7b/6IHY9rcy/mqXFYu3rqqUog==
X-Received: by 2002:a5d:62c8:0:b0:366:ef25:de51 with SMTP id
 ffacd0b85a97d-36bbc1bd492mr2155018f8f.49.1722604511294; 
 Fri, 02 Aug 2024 06:15:11 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cc58sm1970304f8f.2.2024.08.02.06.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 06:15:11 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 19/20] CI: add qemu_arm64_lwip to the test matrix
Date: Fri,  2 Aug 2024 15:14:06 +0200
Message-Id: <bfdc3b3e7105d750b3e3cc5e25fd32de6e70da7e.1722601509.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722601509.git.jerome.forissier@linaro.org>
References: <cover.1722601509.git.jerome.forissier@linaro.org>
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
index c43bb51066a..7f91f204676 100644
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
@@ -410,6 +414,9 @@ stages:
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

