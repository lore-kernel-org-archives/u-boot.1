Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8553CAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 16:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FCCB832AD;
	Tue, 16 Sep 2025 18:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nIkBzBW7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2BDE8329B; Tue, 16 Sep 2025 18:13:07 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8FC1803CC
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 18:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-423fe622487so39082435ab.0
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 09:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758039184; x=1758643984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fw+saVB6nXE7TZ4CcC9Sfl+NVIoOfB5NVnPMAPBR3kc=;
 b=nIkBzBW7TBfeL5sDv+UGTa17HRb9Yw6vwjHlfO0E7h9K9ut9nSFCLqjIQnLmvRjvsB
 W0rpUS/1TSx8tHl7OSn1t1qLqk4hrXhqA2t2/vxAZ/ksoRpJGpAll9Gl58uXFOB8LgWF
 T6i7JPNvLO4S9fe2KuG7YarmKBUk4VjEdECR+RV1I9nqRGOKwcRl4Gp87Qz6dxE95HOT
 3ilmP40Jdyg5et2H0zb4LcMzHSdmlEsyCf0wOrASNv8rwmIVn+96livOxWb41VgPqXl8
 mKxRq/fSMFiLCl6YeiGW9DxKdG9R4skFMhYbPLnKMXNnwUo71xFHKDWyNmAmXOQgRnX0
 0lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758039184; x=1758643984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fw+saVB6nXE7TZ4CcC9Sfl+NVIoOfB5NVnPMAPBR3kc=;
 b=uwJMOSYuYIGPcsOoZ3TgUx3KbbrWZPo3O+Q+xtd7T8RGDXGe8H+a81bM40HbAzeUW8
 zJevLFGdqMJPbJ9rvm97eG+8wLmu4G/MZUzyX7sNJ5unt1GRPcOS9eKl3IDC9NBG2wBc
 uVCYFYSMDDxQz3m4Bk9mQf3s7Dam/W6aXRU+JvpKJBVP1maE9R1+V2XXxdSy4ADrbTSd
 klSau2RFjdvs4jkq5lBktdQkwlKW3oWQb9NVhmtuJfbvZbh22EFOj38p+9HlRsxqbr8p
 SRvUe4l/yx9raroh/sLQgzExhz9jQe00tpTiXoy9XvNe8+rL3pe4Rrq8S7Cp+vruMhzg
 vSnA==
X-Gm-Message-State: AOJu0YwM1PTy2AHKmKAxQXLob1KYP9klg+XUhMfozbgcT7Z8ao6WefCi
 xjSmbKbP5uCt1G64wlnHffgA9Pg+Clmac9p6f3ROtIVqi6aAbPkDs23GUW0GRS1qNy5FmnwWFJC
 F1v2P
X-Gm-Gg: ASbGncsSoADCY63Pnea68lVaPxHdgLmX3DZO7MTDIGXQsBUandeHyQtnrNdyL2CTZ/T
 yZajfP9kwXIXwaiTiqgxmHrT3kyeUwRCPoYVbHyXg/+602ZAZa3JLdQ4grC6ERxSjLYGgkSndWO
 T5zoZNflcxiG+W+ARXMyxSiEt1yuTsBoqZEJJL+erC9Vt3/PLhhO0ae4b8xNws4mpyT4dkrDU1z
 oEiYboUJrRIQ8i01IkNrV3gcFDqfsz0M5C/j/f6+8GuwhCHEciPkFXmmypXeyFxtp1qTZCJnYNf
 0MDW3plk22mQGXYEQ+LqT1tveHDuP4CTFGtylL7gsi9s+7cnIQAN9UScIoZ9VqHdel7UARxu1HM
 qI0qJ62Ns+fFOtbbo+T0fwymFW8T/I7gPVk6/F15YIKfHKXBmjyBAyRAa9dgGjwJtWxks15xKNF
 vaR0wTx8aUMw==
X-Google-Smtp-Source: AGHT+IHOPdEFSWykv8ifiHQPuUD/oYWNXL7+nIHsFHyGPfGvlC4VnJwaroaagNqLF8U2l+RZr13Qjg==
X-Received: by 2002:a05:6e02:17c8:b0:3f0:d2df:633d with SMTP id
 e9e14a558f8ab-4209f2bca63mr160024345ab.8.1758039184001; 
 Tue, 16 Sep 2025 09:13:04 -0700 (PDT)
Received: from ubuntu.localdomain (209-227-169-220.cpe.distributel.net.
 [209.227.169.220]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-515151af149sm2771334173.81.2025.09.16.09.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 09:13:03 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH u-boot-test-hooks 2/2] travis-ci: add config file for testing
 firmware handoff on qemu_arm64
Date: Tue, 16 Sep 2025 09:12:25 -0700
Message-Id: <20250916161230.32140-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250916161230.32140-1-raymond.mao@linaro.org>
References: <20250916161230.32140-1-raymond.mao@linaro.org>
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

The existing 'conf.qemu_arm64_na' uses 'u-boot.bin' as bios, but for
the case of TF-A, 'u-boot.bin' is BL33 and the assembled 'flash.bin'
is the bios instead, which will be built and assembled at run-time
via a post-buildman script and copied to '/tmp'.

Moreover, for running TF-A and OP-TEE on qemu, '-m 4G' and
'virtualization=false,secure=on' are required, and '-semihosting'
should be replaced with its modern alias
'-semihosting-config enable=on,target=native'.

Last, point to the new helper script 'swtpm-tfa'.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 .../conf.qemu_arm64_fw_handoff_tfa_optee      | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee

diff --git a/bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee b/bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee
new file mode 100644
index 0000000..9aa6d3b
--- /dev/null
+++ b/bin/travis-ci/conf.qemu_arm64_fw_handoff_tfa_optee
@@ -0,0 +1,31 @@
+# Copyright (c) 2025 Linaro Limited
+# Author: Raymond Mao <raymond.mao@linaro.org>
+# Based on conf.qemu_arm64 which is
+# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="virt,virtualization=false,secure=on"
+qemu_helper_script="swtpm-tfa"
+qemu_binary="qemu-system-aarch64"
+qemu_extra_args="-m 4G -cpu cortex-a57 -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci -d unimp -semihosting-config enable=on,target=native -chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0"
+qemu_kernel_args="-bios /tmp/flash.bin"
+reset_impl=none
+flash_impl=none
-- 
2.25.1

