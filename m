Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D82BCCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 12:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84E3783A84;
	Mon, 10 Nov 2025 13:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kRMZLk5G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 913BA83A1A; Mon, 10 Nov 2025 13:58:46 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0516F83A84
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 13:58:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b98a619f020so2635441a12.2
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 04:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762779522; x=1763384322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYCzIuO1ci+kjeR0NX93fLOGPIEpLf3kuNnO0oSp/OA=;
 b=kRMZLk5Gx4tq9qeIFvHbuy7kPzt4e6EROEZmVFPcvZIyqm/5Jajq0pQciDsbfhLAkV
 gSFzlGKUA5mRiIURuVtuY4RNC7D4skEDj54aSl9J6bzXwx9QqRKYHKZGI843NBN+58cb
 IW5s8JZNNhBkOFVwOJODBrjcj9HPeaJgaGcD7zVkrHWpvA8Lc5F33UGzE/cToVfnGvEk
 8+wHRhO0Q/uJPjmetm8yz4S1APt0IIJVf4mYxrWZqMP+Bgu/iHc7Q08wYLcQTmDJ0h6G
 dyCZTqnzZzJIOpwSzoKMCgHcg9m/Lz5W/Ayrb6RXig8n8PY25MA9mqLR+ZS2m1Lfar6v
 bI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762779522; x=1763384322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yYCzIuO1ci+kjeR0NX93fLOGPIEpLf3kuNnO0oSp/OA=;
 b=OVIxoGmVuO2aS0RRga5Qj4FfUc3NQc3MjV8hi/zpBrnWXmOgNv3yMKYj8pv+JknMAv
 H4hkJgrAeSdYgwnTGy1K5HpAOhlSmPsITy5cc01VrTewpWzUhfSiPU/PT71y/6ultFNJ
 Xfhxj77G5+j51WTr9VdVQKwpswOAVljfzbbGkTBIo9Gj2YBreWWoQiNHR1/2gKiK2l//
 kO35X+qXPJCnaWWZSajNUcC74cymaBoYej2LWFxUiCD5qTfcHwarWTJNKoenBT/24N0j
 DtCDoioU7BGgKA2I07hRI++e5E9zmzqkvTed5noT41ZpnaXx4WddQ9tfaQ1W8PZI9E+N
 B/cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpi+E5DeyhRWVZksFPJEa7A6YBzYtpCe73qQeYCEj1zFuLGkcGvZ6UCRrrMMPGJk/6HCLMR4I=@lists.denx.de
X-Gm-Message-State: AOJu0YzS+Di6NrvvkUYsxyh+Sk2ALBngUm0i37Z2OTLLh3FJOTvRT2Uq
 ucPejXC/Zl4a2dsVRUPRCeu0zcmxAz3XDY9mlhoc+JhcZqq5MEgFEJJd
X-Gm-Gg: ASbGncsOlLZlR8eNXpBO9Ua71oI9TlsgpiZObLNyL7bLo4S5GUag7d+VLG2nMG6paES
 +foN2q22o89gYXyLXIf1B3JyX0Tb3+f7HERfZmJ1uBD3g9OGIsH/tBz5eGrfuZU/zjePRBoYpCT
 dg4YOIbs/E3/ZGB9hvXJYRkXNCPcCorV080HvSoesPR6QKD7B8+K6CXwxCK4C+ATDOqCbEHz6ce
 DG9AC7l40WW9vv6cH3Zi0s59lJ16zzXbIZ85atS3zLPqDmv0xk3ZED89WvjDWp52m383N5b72+E
 79p84YMpG/CFHBYtTfGGkSVxbj64LUjJSuAwfppDzN690OCXD59l1Gn0LArO4RP3pnD5jAV/BQ5
 P51d1R1kK87ry3WGAYFs9NOgLLx5kaHcCcjL/Kt0+T0Zv+KfoOton3IINxYS7e/H2V+9+y1xF+/
 EdGV+9eQ==
X-Google-Smtp-Source: AGHT+IH7+/L0SeI76FPJ211k/h6pF8Djf/ufk7O5nH21t5wyDkbNZOMDDClg7zJORQ2CSMqE9g0OFg==
X-Received: by 2002:a17:902:ce10:b0:295:57f6:76b with SMTP id
 d9443c01a7336-297e53e7b0bmr113895055ad.7.1762779522422; 
 Mon, 10 Nov 2025 04:58:42 -0800 (PST)
Received: from ubuntu.. ([111.196.133.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343abec3836sm1865850a91.18.2025.11.10.04.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 04:58:41 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Subject: [PATCH v2 2/2] qemu: arm: sbsa: Rename sbsa defconfig to arm64
Date: Mon, 10 Nov 2025 20:58:28 +0800
Message-Id: <20251110125828.1643327-2-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110125828.1643327-1-bmeng.cn@gmail.com>
References: <20251110125828.1643327-1-bmeng.cn@gmail.com>
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

The QEMU ARM SBSA virtual platform is 64-bit, so rename its defconfig
to include 'arm64' for clarity.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

Changes in v2:
- Add missing azure and gitlab ci changes

 .azure-pipelines.yml                                        | 6 +++---
 .gitlab-ci.yml                                              | 6 +++---
 board/emulation/qemu-arm/MAINTAINERS                        | 2 +-
 .../{qemu-arm-sbsa_defconfig => qemu-arm64-sbsa_defconfig}  | 0
 doc/develop/driver-model/virtio.rst                         | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)
 rename configs/{qemu-arm-sbsa_defconfig => qemu-arm64-sbsa_defconfig} (100%)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 1009938f332..9216df16f70 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -268,7 +268,7 @@ stages:
               wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
               export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
           fi
-          if [[ "\${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
+          if [[ "\${TEST_PY_BD}" == "qemu-arm64-sbsa" ]]; then
               wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
               wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
               export BINMAN_INDIRS=/tmp
@@ -483,8 +483,8 @@ stages:
           TEST_PY_BD: "qemu-arm64"
           TEST_PY_ID: "--id fw_handoff_tfa_optee"
           TEST_PY_TEST_SPEC: "test_fw_handoff"
-        qemu-arm_sbsa_ref:
-          TEST_PY_BD: "qemu-arm-sbsa"
+        qemu-arm64-sbsa_ref:
+          TEST_PY_BD: "qemu-arm64-sbsa"
           TEST_PY_TEST_SPEC: "not sleep"
         qemu_m68k:
           TEST_PY_BD: "M5208EVBE"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5f91780c764..19ab1ad53a0 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -49,7 +49,7 @@ stages:
         wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
         export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
       fi
-    - if [[ "${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
+    - if [[ "${TEST_PY_BD}" == "qemu-arm64-sbsa" ]]; then
         wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
         wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
         export BINMAN_INDIRS=/tmp;
@@ -402,9 +402,9 @@ qemu-arm64_tfa_fw_handoff test.py:
     TEST_PY_TEST_SPEC: "test_fw_handoff"
   <<: *buildman_and_testpy_dfn
 
-qemu-arm_sbsa test.py:
+qemu-arm64-sbsa test.py:
   variables:
-    TEST_PY_BD: "qemu-arm-sbsa"
+    TEST_PY_BD: "qemu-arm64-sbsa"
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *buildman_and_testpy_dfn
 
diff --git a/board/emulation/qemu-arm/MAINTAINERS b/board/emulation/qemu-arm/MAINTAINERS
index b2b1fce75cf..fea9e97f868 100644
--- a/board/emulation/qemu-arm/MAINTAINERS
+++ b/board/emulation/qemu-arm/MAINTAINERS
@@ -6,4 +6,4 @@ F:	board/emulation/common/
 F:	include/configs/qemu-arm.h
 F:	include/configs/qemu-sbsa.h
 F:	configs/qemu-arm*
-F:	configs/qemu-arm-sbsa_defconfig
+F:	configs/qemu-arm64-sbsa_defconfig
diff --git a/configs/qemu-arm-sbsa_defconfig b/configs/qemu-arm64-sbsa_defconfig
similarity index 100%
rename from configs/qemu-arm-sbsa_defconfig
rename to configs/qemu-arm64-sbsa_defconfig
diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index 8750228693b..df07a0658b2 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -34,7 +34,7 @@ The following QEMU targets are supported.
 
   - qemu-arm_defconfig
   - qemu-arm64_defconfig
-  - qemu-arm-sbsa_defconfig
+  - qemu-arm64-sbsa_defconfig
   - qemu-riscv32_defconfig
   - qemu-riscv64_defconfig
   - qemu-x86_defconfig
-- 
2.34.1

