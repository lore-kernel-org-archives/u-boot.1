Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1CFCCD1A7
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 15:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77376831D6;
	Tue, 21 Oct 2025 17:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xDA/kwZt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6421880107; Tue, 21 Oct 2025 17:35:22 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47012831D6
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 17:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-88fa5974432so788012585a.2
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 08:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761060918; x=1761665718; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0A2JVx2QXxeKvA57b0/itTd7vt5WnxQ67/p0rjRR19c=;
 b=xDA/kwZt2q8ys30WxwPtKamYXRoV+ha+TTVJ2PbYQ9g1Yy8dzXo6NzlN9Ox+4tXqFt
 9iJZVU9xK53hbvxPtWnbLHYV5DulwlkqUuNgT0V5AY8lN2nq7+CQAbIqePjb8d20Z7ux
 yWuMHI/85XiZQamm/7aU4aBeMqgiX2qOuXfCRDKjqI/I62xZfgdsJI3RLDYSs8ar+LLK
 lIUS6AMio+OXlwx10fKcE0NnGqCxj1SwfzwbLygysoYGPJmiqfATixoSvrW6ER5wX2fo
 ycJp0r9WoXlBb9/T9GkzVsPs/jajqd98NEDHp/k1Edp4I7MshHwc/TtNMJ5vpSrFXvfl
 l8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761060918; x=1761665718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0A2JVx2QXxeKvA57b0/itTd7vt5WnxQ67/p0rjRR19c=;
 b=jlrpOruXqmKpa11gp3TkYLPTRIZ+SE7Aulmha+vvEcjZP6ff6qHGq/rPB3s48w3Qm9
 REd3wkotwwcE6Xy4L54CmVHK6QsSPju46W8XRHaz/ZNa64byxoXFBq9+HQGzcQ7Xhyyf
 gYq5oCEtzoVRaez5DATivhFdbMyf7Jdf3gehsuvfDLeWxyTyNz2eVRj0e9wATZaeSz+t
 +HHH85SfSu18b2V9QOHewLbUfvS383FftIGbneR4CwnnTZHmSkTFEZGUjYt8Dh0pAzgB
 ZVRUWepiJM/AgNZbb9ou+clCLdczk/P8VGNqjAKDZPV0pPm85+TfxVK//moUvN725g1z
 hEQQ==
X-Gm-Message-State: AOJu0YzcZAQkuLPRPfYrPMJPlkEfIQaJzTz+4k06KXSVTBLbvCxDjPe6
 t5JB0EOfkDrEqUpz16mhaVuW9tgEqoDKp1zINgrAYnlscXSxL8gYFyKMwS6mpJhv1oG7EBDfSQ8
 uxtiG
X-Gm-Gg: ASbGncuSdoH78H2mC0bN63CqOvGJqwtckba0TbzegBUPAwmy6VkzKZxS0Dq11bPt4tt
 FoNgg0A++u0NanoxtVcuJF8eREsFIhmf9HPHm8xt9mZ6zWipQb9HIW3GZxDRAckznzXHco5d++P
 4sgnmOM3AkrLgf4ElpJiRNyYJAYfYlrz0FBSCesJ7PH7ySDePN41Ohx+XFxYObaAvFcxQuvyTHq
 0oAShgNIB7GZkZ0ThznkgpwZui7mC4OnuB6uqivoXqb0eE8VCcynzg/asTxh5+4oYqPqX1kELL5
 OwTUsvzp6H+ZWNc3nUX7BHuu1L+bz9XnumZJ63KZSMHR+yvXQpDOfhlKnrNPKYSR55LmBe0eOGI
 BNWtvilgRZar39ovhxR3Mj2VWj0c9KgwwbpF/gRBMwmsUTAKGXlq34HwWBeaSndN20hA7za6z/m
 LH94PDmdk873ui9Yj4NKe3WD0uuts=
X-Google-Smtp-Source: AGHT+IFIJcFQy6B2f/0hACR0evZks4C3fSYI/6A6kHfVZ+0z4UBDdI2FxbfwJrH2hcGayMjj/np4Bg==
X-Received: by 2002:a05:620a:319f:b0:82c:c838:d5a2 with SMTP id
 af79cd13be357-8906e4c868bmr2275311885a.22.1761060918550; 
 Tue, 21 Oct 2025 08:35:18 -0700 (PDT)
Received: from localhost.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cf58e7bfsm777910085a.50.2025.10.21.08.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 08:35:17 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v5 4/5] ci: check existence of bl1 and fip in the test script
Date: Tue, 21 Oct 2025 08:34:36 -0700
Message-Id: <20251021153443.219326-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021153443.219326-1-raymond.mao@linaro.org>
References: <20251021153443.219326-1-raymond.mao@linaro.org>
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
Changes in v3:
- None.
Changes in V4:
- None.
Changes in V5:
- None.

 .azure-pipelines.yml | 14 ++++++++++++--
 .gitlab-ci.yml       | 14 ++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index fc55c8b2100..093596ee378 100644
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
index 73ff975e574..9151d251856 100644
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

