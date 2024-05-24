Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EC9C25B7A
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80987888BB;
	Fri, 24 May 2024 18:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="acJg/H8m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06C0788552; Fri, 24 May 2024 18:22:33 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADADB888CF
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-351da5838fcso7124669f8f.1
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716567747; x=1717172547; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g5LQ34e0u0fQ4V1UZEMkRab/H5C2HjlEu6IA+JOTL3U=;
 b=acJg/H8mamvnwALPzhpVB/UHqYU6CX99xFuMZjFWDU7WN0ca7g3plMTIvOO9gFmSlI
 H54bSToNse2E81UsRLQltL8F+1I9nEYuVGMb83HK//u5jHu8kqinu9GIUL9sRZaLq2QS
 IUiBC6kZrBx5LGHG3njZFSCo+Innh+zfh1hD9IYAv/Ce8DZO/M2+Q5L2d+ahVjwKIDiM
 aOrIbPak02WmaG1D8roZjMmb/m89zYSoKTvvodwnau55AFVPNjY+0N6HUvoPdrtTTwFw
 p3fI+RbsZ9p2vH1LCVzGUp1b23SoOauTsubgx/CW7GtFIXl6UGqKndJf6cDO/OTz2xor
 JPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716567747; x=1717172547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g5LQ34e0u0fQ4V1UZEMkRab/H5C2HjlEu6IA+JOTL3U=;
 b=vNOZO1QgMqYWHlc/J4R9V57W5jzuscY7W4lJ5ggMuxlB3mjvyL3lIHmlSc2+r+NdkU
 LnrWaXCzJkGm/6R365nc4mh3bQgb/ej+VwRs+YcpK3C1hl7eziTkmHrDGjYjRbE/YCWj
 OFDbrc7lxiS/M6vtLe76do/PmlCjQDR5t2Iei7apno3RdxsSJbof4WhyuaRy1neageOE
 mo4FIpIZNEixdDWFnRWWwTINAZp+Iy/AeTh8XEC/w3DQCS7Tnx4d7/b45Hq3TL1C7/E+
 U0uUrrkympVT891HDMdDdmurNgixSBWFbcF+yJchw4VmTlU+Uz3j7ZVZCh9x35hLuht1
 RQ/g==
X-Gm-Message-State: AOJu0YxQIhoG9MwpDh/OSK+bHzCggHSZotPdepSk8l3yc7g3u3kIEcxf
 8rTbWtD9YapDxeAYuY/afEJiuA6B4TBkJqKCPg9WNUD1xLnMgrQYvwGGiRvJPJGGT6uFz0GtBbC
 RtrLp430z
X-Google-Smtp-Source: AGHT+IHHxFawf3JHDXOQcnUvNDv8V4ApHm3jj4F2vEsfaHc88DzQJuGUSt0O2vPiqfBHbhT15dq9KQ==
X-Received: by 2002:adf:f38f:0:b0:352:9e0c:f9d3 with SMTP id
 ffacd0b85a97d-3552219d081mr1789472f8f.31.1716567747100; 
 Fri, 24 May 2024 09:22:27 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:80fe:af01:c137:b43b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c918csm1928465f8f.77.2024.05.24.09.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:22:26 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Subject: [PATCH v2 14/14] CI: add qemu_arm64_lwip to the test matrix
Date: Fri, 24 May 2024 18:20:08 +0200
Message-Id: <d6ccd2f98ab4334b046bf1471008ad192a77f003.1716566960.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716566960.git.jerome.forissier@linaro.org>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
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
index 27f69583c65..b036999210f 100644
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

