Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D10AC52D6F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 16:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D53A388BEF;
	Fri,  2 Aug 2024 18:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zwOz45PX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BFF488C1D; Fri,  2 Aug 2024 18:28:38 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D74C688C19
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 18:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-367ab76d5e1so3480758f8f.3
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722616115; x=1723220915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JO6QDMARiBGP733sS5JXF8LmB5ZyYuzey+MxW/9peVk=;
 b=zwOz45PX55HjoD80ZS5FPmBNOtqHpQAFZ5nDqZx+bKy4uLB1GqvJIKRfWqnmtOMbNE
 jBQ3xyQuZZRSGyjCVDSkLC6kCxu/dRT2HWiwR7MFlYNhsYrTPdYnR7sKPtSigVozwmHh
 fASnKME1wXp6dzTOWL/lHKwDdEFxFipHlpI9VXzIk+Pj+Sig52UiRE3gYiYeK3nsya6F
 PC3sRS2Kk8r/8Iu7ACMAA6Y+MNNv70Enyj2frZ2F+Aply46CVMYEnrLD8c6HismmlLle
 SdmaBA/O4El3fMR8+l0VsnuVCTPzye0tZRuLcdaJT4hrh4o4ynQ/jJgELbj4lnmsAknm
 FQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722616115; x=1723220915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JO6QDMARiBGP733sS5JXF8LmB5ZyYuzey+MxW/9peVk=;
 b=nXRWE9g0BLKVqiDszgIyVBukjTDyXofQUPDIZJJdUEhFS5ImZjK+m10x/ieBGC5h9r
 kEmKEM9bllSpfNJ3Z7rRxtOH1Qv5yBm6sSBtiCwbfPTLfvxj3Q4z69NspjrhraloI7ul
 xXlf2ucChqkVKiDZ2NJntiOBqrKaH1+ocfx1OAgpM36v4Xk9kmMxtvoCXqVqWWBwbwbR
 WJ7EESucCb+H1Oufolm2dxpSUGVmIoarkT3lH+6gG1xg+7URH4xqr2QLQNFFIDOUvai8
 7MWrFH4en3/pg9rmeL1SBkxzR8uxMTPnFNoUAn0+jtA8A2N1J/Wgje+ThTwfmnCe5y42
 E/Aw==
X-Gm-Message-State: AOJu0YxmCeDliKNd5Hx/Am1mh1nHlgs5bcl8Z5eXTzuSKRz7w0IgUegH
 O+ek9yuiAGItZ6QSIEKhoiw12UVrfXQnKYP+L7fksDaLpG4QPkY60x6ne7Gqkpa349w6drKmBpB
 ajqyGuKGT
X-Google-Smtp-Source: AGHT+IGokd/A/Ui/BGMSBwrC3iXT6aNkur1dh3g/MOtWs68P+AHODcQJeAvarlBg/2BspjUry00l+g==
X-Received: by 2002:a5d:6d49:0:b0:368:557a:c64d with SMTP id
 ffacd0b85a97d-36bbc0cda74mr2678486f8f.9.1722616115116; 
 Fri, 02 Aug 2024 09:28:35 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01b5c4sm2297783f8f.42.2024.08.02.09.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 09:28:34 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v7 19/20] CI: add qemu_arm64_lwip to the test matrix
Date: Fri,  2 Aug 2024 18:26:46 +0200
Message-Id: <1d562cb07c93bfdd0998e48e4bab6721f41ccc97.1722615735.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722615735.git.jerome.forissier@linaro.org>
References: <cover.1722615735.git.jerome.forissier@linaro.org>
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

