Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631C4CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 19:20:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 680108387E;
	Fri,  3 Oct 2025 21:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gb3DeZ/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 876D28387E; Fri,  3 Oct 2025 21:19:59 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 655618386F
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 21:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-911afafcc20so98625739f.3
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 12:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759519196; x=1760123996; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HbC+lSXDkTXc4OUATPFJSKMxs1NKYSHVq8OyiPM97YQ=;
 b=gb3DeZ/FLXKBjZvUH8pkeqfCmolWDFaVUr5X8LkJXZn7K9SeF73KiXg21h2t86QzJK
 nisk5pibooLBtguOz3vK/ZKmuSdm9cnMVMzp6xB4K6dqlTJdDXjyGHFIIhcSGAEN+PR1
 kGt8zGlu6gg/UzXH2dPQo7lhZElMMSuFqFMJr4Hh/4vyK6R3vI6YiA0vJyJJTf4bE8DR
 7aWc8BNwiv9OMalQo6gJDx8XViPdxb2+31g1iYPUMVEFK9sckGLwWez1+fZ376HmTDE/
 uMNcib0czLcdrMfkgq2Cfqpk89u16Rkw0F7WT5SGidhcPUGGjorYXar4H1Xkg986b5R9
 OZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759519196; x=1760123996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HbC+lSXDkTXc4OUATPFJSKMxs1NKYSHVq8OyiPM97YQ=;
 b=U2zaQNvuje4+bsnU07I58A5mK4JV4ayXS+i+TgAYMhlK/cJUfTrFXKNMy4s4dowlEK
 rkHT3a4VwDIT9UE1NjjrWNKT3NIEW+FwfKpHSbK9c55S+3Wc1daFrz2QIkk+tf5FyAVC
 Gs0Y0CLUy3uqfq98VJo4S31H7QogCpreVf9ItkJhA9gcgoC/NN4Fc0HBmdPhp88EQNus
 +jtmca/Z1jdudsL/GVECrAEbHUUCb66THixCPfgk7cY6at2CXPevFW31FoLwTdTai/NT
 eWbG/E84QKnIEQDUZwVPun4YOAsnFpjatqARVO/736FnWWPEo3PMbNvR2GFLOXiipfE0
 I+xg==
X-Gm-Message-State: AOJu0Yw3mE86OZ3fu4/2fjxLG3oRj1ATCJ1ETKLHPd74bdCSFhDyXYud
 XDGDpYKUOmiG876WMXxf+nBA/MGofTTakrNdez0RDqF0A7Mwb2LZ1PcGX2CNpXnFikeH5kiZ+Gl
 +xz4X
X-Gm-Gg: ASbGncvGrSNRr8zQeBl8LXtmbLHFz/ETEIksKdgoJR4lJ/ryh1IHS7qiS/CelSPsj+0
 HoLMrKmR4SUMCtq51GoM4Vqq/zFa1rd8TQYN0hCFUvmq8r0s+cH1C4MhfY+NiTr44Q9popCZusH
 JVovI/fIWYiJb2pE19JrpzIR1SFGgFLGx+xsOUREkA0U1KIsHG0fNtu+TGMfeIieJsncUztLi63
 2/fCsb4Jc2CvIc+l6d+oF06xj+kk7wEhk62t2u7xiSb9EvKFQqHR2+sKQDH5Cw+uO5+RKR0jjWz
 oKVkykri96usH8fZbWrL1pQGgyRtgktr1RMyM0feslivCD33Ad2J4W4Xbfd0wL59SqA6RcUFWSo
 AGy8y9D3Ls702o14CDi1AkRqciJncWTR+yrHsATXKMevTs1aer9YUTmRcoYr5vvm53OafziaRKw
 ==
X-Google-Smtp-Source: AGHT+IGDMYtt2+x+cJolon43bqt+XCOvRS1CvVZstoR6TBHUrpeUMNF3j0vclkSpEOrsj76abgL5nA==
X-Received: by 2002:a05:6602:6422:b0:901:98a7:59b7 with SMTP id
 ca18e2360f4ac-93b9698d1ccmr546012439f.8.1759519195724; 
 Fri, 03 Oct 2025 12:19:55 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a8912bfd9sm213794139f.25.2025.10.03.12.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 12:19:54 -0700 (PDT)
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
Subject: [PATCH u-boot-test-hooks 3/4] bin: Add support for testing firmware
 handoff on qemu_arm64
Date: Fri,  3 Oct 2025 12:19:12 -0700
Message-Id: <20251003191918.767698-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251003191918.767698-1-raymond.mao@linaro.org>
References: <20251003191918.767698-1-raymond.mao@linaro.org>
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

Add support for testing firmware handoff on qemu_arm64, includes:
1. helper_setup hook and clean-up for swtpm;
2. Assembling flash image in flash.fiptool;
3. TF-A/legacy mode switch depends on the coexistence of bl1 and
   fip.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 bin/flash.fiptool             |  4 ++++
 bin/qemu.swtpm                |  7 +++++++
 bin/travis-ci/conf.qemu_arm64 | 17 ++++++++++++++---
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/bin/flash.fiptool b/bin/flash.fiptool
index 23014f2..45c644b 100644
--- a/bin/flash.fiptool
+++ b/bin/flash.fiptool
@@ -20,3 +20,7 @@
 
 # Call fiptool to update an existing fip.bin file
 fiptool update --nt-fw="${U_BOOT_BUILD_DIR}/u-boot.bin" ${fip}
+
+# Create a flash image
+dd if=${bl1} of=${U_BOOT_BUILD_DIR}/flash.bin bs=4096 conv=notrunc
+dd if=${fip} of=${U_BOOT_BUILD_DIR}/flash.bin seek=64 bs=4096 conv=notrunc
diff --git a/bin/qemu.swtpm b/bin/qemu.swtpm
index c40c537..9cf4f1a 100755
--- a/bin/qemu.swtpm
+++ b/bin/qemu.swtpm
@@ -18,6 +18,13 @@
 #
 # U-Boot must be built with CONFIG_TPM2_MMIO=y.
 
+set -e
+
+rm -rf /tmp/tpm
 mkdir -p /tmp/tpm
+
+if [ -n "${helper_setup}" ]; then
+    eval "${helper_setup}"
+fi
 swtpm socket -d -t --tpmstate dir=/tmp/tpm --tpm2 \
 --ctrl type=unixio,path=/tmp/tpm/swtpm-sock
diff --git a/bin/travis-ci/conf.qemu_arm64 b/bin/travis-ci/conf.qemu_arm64
index bd55ea8..690c2a6 100644
--- a/bin/travis-ci/conf.qemu_arm64
+++ b/bin/travis-ci/conf.qemu_arm64
@@ -20,14 +20,25 @@
 # FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 # DEALINGS IN THE SOFTWARE.
 
+set -e
+
+if [ -n "${fip}" ] && [ -n "${bl1}" ]; then
+	echo "Both fip and bl1 exist - TF-A mode"
+	helper_setup="swtpm_setup --tpmstate /tmp/tpm --tpm2 --pcr-banks sha256"
+	qemu_machine="virt,secure=on"
+	qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/flash.bin"
+	flash_impl=fiptool
+else
+	qemu_machine="virt"
+	qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot.bin"
+	flash_impl=none
+fi
+
 console_impl=qemu
-qemu_machine="virt"
 qemu_helper_script="swtpm"
 qemu_binary="qemu-system-aarch64"
 qemu_net_args="-netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0"
 qemu_host_args="-semihosting-config enable=on,target=native"
 qemu_tpm_args="-chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0"
 qemu_extra_args="-m 4G -cpu cortex-a57 -nographic -device virtio-rng-pci -d unimp ${qemu_host_args} ${qemu_net_args} ${qemu_tpm_args}"
-qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot.bin"
 reset_impl=none
-flash_impl=none
-- 
2.25.1

