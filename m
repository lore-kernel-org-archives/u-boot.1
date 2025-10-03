Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC26CCAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 19:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27259838EC;
	Fri,  3 Oct 2025 21:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dl23p8Zw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B493838EF; Fri,  3 Oct 2025 21:23:07 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF579838C2
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 21:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-887764c2868so248939539f.1
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 12:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759519383; x=1760124183; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=koiFUdA5JkNwpp3IOzmsZD+z21BOPXfiIr7fr0M7ie4=;
 b=Dl23p8ZwaE7TALKEhRuOaljTjaX7pLzBxI1Aqd62sEUqnQJOEnSkoB2y94J0FVqazh
 DmiY5YHksKBSYfvofu5ReRuKxVVlY/d2++T/HXjatco0FpVuCCkOE/O8Q6sl+mQUlzd3
 8l/u+H76fJYRV38LVZrnFRehHH4Mfs1eiB6hQZndE/g2W1X+zraCSrIjiv4AXuR69FMj
 OUjbQOgN5KYYDy2/1o6sTXW6F0PrvKnIJs+NMnBNpEE0R8GL4TDMRYXyoTsc1xoCxSbT
 lijGW6v4fuiox6FFChN11u+xwuYkDz92ecObRY7hhI45OKArES41Rj5hvhkVJODFSOc+
 fE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759519383; x=1760124183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=koiFUdA5JkNwpp3IOzmsZD+z21BOPXfiIr7fr0M7ie4=;
 b=eZ0Llc8WOQ3q84BHewypQPV+Ys1pPHDdSgt7qoz8AtjzRxAV0A5Og8wPltMKK54f6c
 qKtQLLePpmfjR+VcuOGHx/jA8ye7BHlSWw2RsyXXLYtlu6S8lMjYxLwlmUolVk110GPj
 T7ldpzAIQT+SFB/le6+7poEopIQO0yCiobN5vmNMqXPbUB4nQatPVJY//A2UG91fve13
 zqLQVxtCCXT0RLJk7g/ZRbLLnrX4drSbw8lNAO/8aVYaZ9JTZV9lxIHRGBwJXNOxAfJ5
 LrDLhyoMO70D6gsklgyKTIOgyjKT3xXovbfhWq5SaMKMOotzs/tyv9wmXLqPvkeIQDrU
 +tHQ==
X-Gm-Message-State: AOJu0YzkY0LAMwdzFT+bwwnNuRWcvVVl9MnoGiCIv4sDt9F63NkI+Qjc
 vTwVrkBp3d5kXs/3t2ZvZ3JWe9vipTAvI/Nscjx+uMJEOcgjJ4RvvEha3B04GsprmgM0uxDmNHp
 jwCBt
X-Gm-Gg: ASbGncsbd0C/p2ZCIkqCj5bt9oCONEQP7I3Lq2+PjoCstpv7gWXUP+4UOW0EU87fwRu
 /B065ssg/WeF/bGX7RmtWE1i2CWE/997Kt/9gB4jO4ypiLb794WIXkvTVHOAQLcD0o8GiSNoj80
 YTvwbG0MpkZ4Obg7nx5An6rMpf0sijkh9bgkViDsf35n2I3dINxPYgYseuCfPGH6xVvC29kFaqf
 9tQ4le0gcb9IRttKCbRV9ywIMAd1NeuBghX1/U/qrE5DlGtSDwJ/9JjRbvvkVcKk3euB8y04TcP
 qCbmnRmZwL73JzLg8+u73kkPr/0y6P9f9ycnDTIXGNj64k5OCMuNUvsmrKQF6eR987zLihHQAPP
 uDIqQef/9OK8fF5En4TDB+JNtCuSHfWXzlN1jdDtoYgb9D/OFrFwPL0txPNR3c+6QBynngO691Z
 iVceLaNaFc
X-Google-Smtp-Source: AGHT+IHRs9iHqa1fDvdUHrh0w7RBcs1RUbcgHXHXCJz9dEpBfhuAkSpHt3fo5QV1MXhYKbZijrU+LA==
X-Received: by 2002:a05:6602:6519:b0:936:dfca:f79 with SMTP id
 ca18e2360f4ac-93b969648f7mr429076539f.5.1759519383215; 
 Fri, 03 Oct 2025 12:23:03 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a7d81bf16sm208975239f.4.2025.10.03.12.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 12:23:02 -0700 (PDT)
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
Subject: [PATCH v2 4/5] ci: check existence of bl1 and fip in the test script
Date: Fri,  3 Oct 2025 12:22:18 -0700
Message-Id: <20251003192222.767882-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251003192222.767882-1-raymond.mao@linaro.org>
References: <20251003192222.767882-1-raymond.mao@linaro.org>
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

Check the existence of bl1 and fip from:
1. /opt/tf-a/${board_type}_${board_ident}, if not exist, then;
2. /opt/tf-a/${board_type}

This change allows to test with TF-A with specified board ID only.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2:
- Initial patch.

 .azure-pipelines.yml | 14 ++++++++++++--
 .gitlab-ci.yml       | 14 ++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 8209d2b329c..1382e4f6475 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -308,8 +308,18 @@ stages:
               /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f \${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
           fi
           # If we have TF-A binaries, we need to use them.
-          if [[ -d /opt/tf-a/"\${TEST_PY_BD}" ]]; then
-            cp /opt/tf-a/"\${TEST_PY_BD}"/fip.bin /opt/tf-a/"\${TEST_PY_BD}"/bl1.bin /tmp;
+          tfa_dir=""
+          rm -f /tmp/fip.bin
+          rm -f /tmp/bl1.bin
+          if [[ -d /opt/tf-a/"\${TEST_PY_BD}\${TEST_PY_ID//--id /_}" ]]; then
+            tfa_dir="/opt/tf-a/\${TEST_PY_BD}\${TEST_PY_ID//--id /_}";
+          elif [[ -d /opt/tf-a/"\${TEST_PY_BD}" ]]; then
+            tfa_dir="/opt/tf-a/\${TEST_PY_BD}";
+          fi
+          if [[ -n "\$tfa_dir" ]]; then
+            cp "\$tfa_dir"/fip.bin "\$tfa_dir"/bl1.bin /tmp/;
+          fi
+          if [ -f /tmp/fip.bin ] && [ -f /tmp/bl1.bin ]; then
             export fip=/tmp/fip.bin;
             export bl1=/tmp/bl1.bin;
             export PATH=/opt/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9.3:\${PATH};
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 85401d3e09b..224485a2e64 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -97,8 +97,18 @@ stages:
         /opt/coreboot/cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f ${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
       fi
     # If we have TF-A binaries, we need to use them.
-    - if [[ -d /opt/tf-a/"${TEST_PY_BD}" ]]; then
-        cp /opt/tf-a/"${TEST_PY_BD}"/fip.bin /opt/tf-a/"${TEST_PY_BD}"/bl1.bin /tmp/;
+    - tfa_dir=""
+    - rm -f /tmp/fip.bin
+    - rm -f /tmp/bl1.bin
+    - if [[ -d /opt/tf-a/"${TEST_PY_BD}${TEST_PY_ID//--id /_}" ]]; then
+        tfa_dir="/opt/tf-a/${TEST_PY_BD}${TEST_PY_ID//--id /_}";
+      elif [[ -d /opt/tf-a/"${TEST_PY_BD}" ]]; then
+        tfa_dir="/opt/tf-a/${TEST_PY_BD}";
+      fi
+    - if [[ -n "$tfa_dir" ]]; then
+        cp "$tfa_dir"/fip.bin "$tfa_dir"/bl1.bin /tmp/;
+      fi
+    - if [ -f /tmp/fip.bin ] && [ -f /tmp/bl1.bin ]; then
         export fip=/tmp/fip.bin;
         export bl1=/tmp/bl1.bin;
         export PATH=/opt/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9.3:${PATH};
-- 
2.25.1

