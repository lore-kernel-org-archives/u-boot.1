Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55301CCD1A7
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 18:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8C008323A;
	Tue, 21 Oct 2025 20:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MHIxi4+G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19ADB8323A; Tue, 21 Oct 2025 20:17:28 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95A0480107
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 20:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-791fd6bffbaso94315706d6.3
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761070644; x=1761675444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G6tsADtO4pcBLw8LeIdE+xD7hbT3Ym+6+yZAJ8rFdYQ=;
 b=MHIxi4+GbvvhP11lg94U3Cky/aB//mk8B7tBQ540MiHTgq7ECvcGQj9EyUqwB5g736
 TgXKdbdAYNPaJs/BVJaVxqOJZCyPIW/SH9lMU2KyzHIK3QugCVyPq31RKWuMqGdcb8WU
 vfQM7y9loe+GPxpXAmS+gXiKviQN9yzlEuTfTKmDNlc2FT5yhUV3TG//LYFbqazZxIp0
 VJ72vHl8GBBVvuyZGEDbZcVFVbPUgidNkLNIbJWmiE2CAHCpI+4N0fC8Mv3K6keiriyK
 JGsBNrE7JpDHIeRDraVmLMBPa/0izw6JlIxelPj3BloeTJEenIXoi4zhHQz1Ov5C1I4A
 THig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761070644; x=1761675444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G6tsADtO4pcBLw8LeIdE+xD7hbT3Ym+6+yZAJ8rFdYQ=;
 b=lQ525VDS1SmQuYFP9SlmxfgGm42nkgauattiEMn6NVPTpmR2SDP7gh/qEb25Vl6Zt7
 QIaZS10p/yoOYtphgZcd7Q9TiVHrdR3UVqnAGiZIOeV28lJtQ/4CId1MKBmiVlFGdb1S
 J07VKgvT8uVfTfAs0NpKrgVt3IFc93g7GQp9wceOAiHNxA11WwdqIGRb/ZKtE3oIQsPR
 UjmGWKbYEKMElBMJe1yGUV02V3YSgHOsj7yesfNv7KTuDL6Wgj7mRXc62+6qpS0t+aEo
 Kd/39K2+Oi4pl5w4/vbfsLYerFo/d3FxQUgFLO00xJRsixKF58btzRqLUxwUb2rpVU5X
 +BAQ==
X-Gm-Message-State: AOJu0Yzbd0FmMsZLnJTJX+NiA03N+H4DNGgzjGfxunlNNO45YYii8TW4
 fm1s6oyX/AS04o37T4qDby3AN1LefifUZvojRzwvwfr+6xWt06Omc8BDYrtJH7PYgcyQVEhm3DL
 bbDdw
X-Gm-Gg: ASbGncvs8G9w+zpm7GOoP89NfGRxWhZ8FzFXasJucjkki3qEksfM+BDSbhUJdpz2aDU
 I133vpI96FN7yBW/sSq2gsf3WGnnS/7sM8gFH1JtwXhOwBXYdQymWF0EOSob0mXAvWPTJ5RILbB
 aAkbmJC5j4eYSIcZw44wr320CKEXdxiFFZSrCF1TGsQjD3CVPnK2T1y9Xt8PwvNSX6rAYW3KBjy
 0lJ0HXx97Vf9f/4s/T3EHHkykMrP6Iff5l8hFfjAR28yex9AHIqk281o3maK7a8zLwYue59T6PV
 RjCu6jr7bsIkxpQaclO/mnUOayShknD+NZcBVGmiYxF/lVs2xVFvMU5G8vj+++1LUiQMUzEB2ji
 AmZg5gxbxhOqtTl/iIRn1j5OT9dhLyIYbdInoVvEWjWXKkeNkNpGfBF5CY7BQ6yWXNdefFEJ/3b
 eg+oW6QtpNhc/YugL4oD3aYnVtgn7OTE/+KRdNog==
X-Google-Smtp-Source: AGHT+IGcIPYE3VNRL00cVm5Kl7/FfgXdw6+k+AbcmF7AV9Dk5nRxw1Tze6oNKNElklIDkWMEe5gBww==
X-Received: by 2002:a05:6214:3010:b0:78f:4d53:7cd5 with SMTP id
 6a1803df08f44-87c2055e412mr241786426d6.5.1761070643924; 
 Tue, 21 Oct 2025 11:17:23 -0700 (PDT)
Received: from localhost.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87d02884878sm72831526d6.31.2025.10.21.11.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 11:17:23 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [RESEND PATCH v5 1/5] docker: add OP-TEE and TF-A build for testing
 Firmware Handoff
Date: Tue, 21 Oct 2025 11:16:54 -0700
Message-Id: <20251021181703.598342-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021181703.598342-1-raymond.mao@linaro.org>
References: <20251021181703.598342-1-raymond.mao@linaro.org>
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

Fetch OP-TEE (4.7.0), TF-A (v2.13.0), MbedTLS (v3.6) and build
bl1 and fip with both Firmware Handoff and Measured Boot enabled.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
---
Changes in V2:
- Move OP-TEE dependencies into the common group.
- Fetch MbedTLS/TF-A and build bl1/fip in dockerfile instead of
  post-buildman script.
- Remove Trust Boot related build options.
Changes in V3:
- Clean-up of OP-TEE deps.
Changes in V4:
- Minimize OP-TEE build options.
Changes in V5:
- Add '--depth=1' and '--branch' when cloning OP-TEE, MbedTLS and TF-A.

 tools/docker/Dockerfile | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 5b4c75f8400..a952df86372 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -122,8 +122,10 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	python-is-python3 \
 	python2.7 \
 	python3 \
+	python3-cryptography \
 	python3-dev \
 	python3-pip \
+	python3-pyelftools \
 	python3-sphinx \
 	python3-tomli \
 	python3-venv \
@@ -227,10 +229,24 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
 
-# Build fiptool
-RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a && \
+# Build OP-TEE for qemu_arm64
+RUN git clone --depth=1 https://github.com/OP-TEE/optee_os.git /tmp/optee_os \
+	-b 4.7.0 && \
+	cd /tmp/optee_os/ && \
+	make CROSS_COMPILE32=/opt/gcc-${TCVER}-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi- \
+		CROSS_COMPILE64=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
+		CFG_TRANSFER_LIST=y CFG_MAP_EXT_DT_SECURE=y \
+		PLATFORM=vexpress-qemu_armv8a CFG_RPMB_FS=y \
+		CFG_RPMB_WRITE_KEY=y CFG_RPMB_TESTKEY=y \
+		CFG_CORE_HEAP_SIZE=524288 \
+		CFG_REE_FS=n CFG_CORE_ARM64_PA_BITS=48  \
+		CFG_TEE_CORE_LOG_LEVEL=2
+
+# Build fiptool, bl1 and fip for fvp and qemu_arm64
+RUN git clone --depth=1 -b mbedtls-3.6 https://github.com/ARMmbed/mbedtls.git /tmp/mbedtls
+RUN git clone --depth=1 https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a \
+	-b v2.13.0 && \
 	cd /tmp/tf-a/ && \
-	git checkout v2.12.0 && \
 	make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
 		PLAT=fvp BL33=/dev/null -j$(nproc) all fip && \
 	mkdir -p /usr/local/bin /opt/tf-a/vexpress_fvp && \
@@ -243,6 +259,24 @@ RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/t
 	mkdir -p /opt/tf-a/vexpress_fvp_bloblist && \
 	cp build/fvp/release/fip.bin build/fvp/release/bl1.bin \
 		/opt/tf-a/vexpress_fvp_bloblist/ && \
+	make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
+		PLAT=qemu \
+		BL33=/dev/null \
+		BL32=/tmp/optee_os/out/arm-plat-vexpress/core/tee-header_v2.bin \
+		BL32_EXTRA1=/tmp/optee_os/out/arm-plat-vexpress/core/tee-pager_v2.bin \
+		BL32_EXTRA2=/tmp/optee_os/out/arm-plat-vexpress/core/tee-pageable_v2.bin \
+		BL32_RAM_LOCATION=tdram SPD=opteed \
+		TRANSFER_LIST=1 E=0 \
+		MEASURED_BOOT=1 \
+		EVENT_LOG_LEVEL=10 \
+		MBOOT_EL_HASH_ALG=sha256 \
+		MBEDTLS_DIR=/tmp/mbedtls \
+		-j$(nproc) all fip && \
+	mkdir -p /opt/tf-a/qemu_arm64_fw_handoff_tfa_optee && \
+	cp build/qemu/release/fip.bin build/qemu/release/bl1.bin \
+		/opt/tf-a/qemu_arm64_fw_handoff_tfa_optee/ && \
+	rm -rf /tmp/optee_os && \
+	rm -rf /tmp/mbedtls && \
 	rm -rf /tmp/tf-a
 
 # Download the Arm Architecture FVP platform. This file is double compressed.
-- 
2.25.1

