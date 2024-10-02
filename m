Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0E2CF31A9
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 105C689095;
	Wed,  2 Oct 2024 11:53:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="dhF6dPEv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 283E089312; Wed,  2 Oct 2024 11:53:12 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D57D088F64
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:53:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cb57f8b41so79803045e9.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862789; x=1728467589; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6SuZgJQToOkX1MPx11/dn8nD3cD4nxG78oM3rH6YIg=;
 b=dhF6dPEv5xSewjl9JOPZ6t1AYkXwri7Uk3cGa+9875ejHLIFqTgZakCrBX+X5tVLsq
 DTxq3l2UAc50UU5A19TWz8Y/l+TOG+DNA7roIW0qZEt6Gw4rLsGKX9797a+FYUPjj5On
 qoNYV33A0S1o8DHf5LzvyT/W2VbxmuJN+/JwnZ16QTBxR7IqcSjgnYjGEhXRp9YsZn8N
 zJJYo+Lh0i5bofiiOjKwNMAlvdQw26pUwUasKPZFu412X+o0xcXf3AsuC9T6ujoV6/OU
 5UrrjUy7iCTcaCiyyJNgHQ9ueiIja9VCXf3BFQgCQ7jdzIU0Bl7lyb53OrgcHGu9R6GY
 9yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862789; x=1728467589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I6SuZgJQToOkX1MPx11/dn8nD3cD4nxG78oM3rH6YIg=;
 b=nqjUMi+LppfY3PnKgizrA+gYMewG6qGpX8zbgvDJBicxb8hHzJQCDpTSpy9OvaqKqH
 SWvXz3ENvOeuFxzsCrS1ZiInVV2uHEjFXb0oE5AYZ5+Pf5g8ayNg1C01oXL2fQq7/Tiu
 EhR5RrDIr9zGNWGuBZ8LF/YaQPIAiOGFVIZucml0ybm/Yl0m/QmbYyOpQf3vefHqQX0D
 QnVF9byTxDHQ43J7332sWWXu1maZLHvWuSj3PADsAoM1ca1gat9ULLXCUrTLc9Oz+xgo
 o0knaxjXVTqa6ZngvJFuxZivDvNjLM5/qzPjXdAFDy+ZG58YPlj5xrfN+OJ8x1cxxm5B
 KxDg==
X-Gm-Message-State: AOJu0YxXcz+Kq56FfcWnRsbrip4PUW85lQu7EUXfbt9c5cfTX9R9e7Lm
 StTV6cNZ600pNLoHblCOZ5kPxL982SEOPSGZ98lugTKIK11tkSWhl8jh7YYJaK6kAUTr7QZxttl
 b
X-Google-Smtp-Source: AGHT+IET+0vELyEm7KsW9oEmuDW7zPdDf6jf3TBlkF/kr9cPCUkc+CwdRGdOhWWEp64VoteqqcYzgQ==
X-Received: by 2002:a05:6000:156b:b0:368:3f6a:1dea with SMTP id
 ffacd0b85a97d-37cfb8b5451mr2894809f8f.6.1727862789251; 
 Wed, 02 Oct 2024 02:53:09 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:53:08 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 37/37] CI: Enable qemu_sbsa
Date: Wed,  2 Oct 2024 11:47:28 +0200
Message-ID: <20241002094832.24933-38-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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

Add QEMU's SBSA ref board to azure pipelines and gitlab CI to run tests on it.
TEST: Run on Azure pipelines and confirmed that tests succeed.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
Changelog v6:
- Add gitlab CI support
---
 .azure-pipelines.yml |  8 ++++++++
 .gitlab-ci.yml       | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 93111eb612..2881851ecf 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -250,6 +250,11 @@ stages:
               wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
               export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
           fi
+          if [[ "\${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
+              wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
+              wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
+              export BINMAN_INDIRS=/tmp
+          fi
           # the below corresponds to .gitlab-ci.yml "script"
           cd \${WORK_DIR}
           export UBOOT_TRAVIS_BUILD_DIR=/tmp/\${TEST_PY_BD}
@@ -415,6 +420,9 @@ stages:
         qemu_arm64:
           TEST_PY_BD: "qemu_arm64"
           TEST_PY_TEST_SPEC: "not sleep"
+        qemu_arm_sbsa_ref:
+          TEST_PY_BD: "qemu-arm-sbsa"
+          TEST_PY_TEST_SPEC: "not sleep"
         qemu_m68k:
           TEST_PY_BD: "M5208EVBE"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7d621031b8..3f02a492d5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -39,6 +39,11 @@ stages:
         wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
         export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
       fi
+    - if [[ "${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
+        wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
+        wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
+        export BINMAN_INDIRS=/tmp
+      fi
 
   after_script:
     - cp -v /tmp/${TEST_PY_BD}/*.{html,css,xml} .
@@ -344,6 +349,12 @@ qemu_arm64 test.py:
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *buildman_and_testpy_dfn
 
+qemu_arm_sbsa test.py:
+  variables:
+    TEST_PY_BD: "qemu-arm-sbsa"
+    TEST_PY_TEST_SPEC: "not sleep"
+  <<: *buildman_and_testpy_dfn
+
 qemu_m68k test.py:
   variables:
     TEST_PY_BD: "M5208EVBE"
-- 
2.46.2

