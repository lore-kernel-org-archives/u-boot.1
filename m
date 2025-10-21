Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCA7CCD184
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 18:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF0ED835C6;
	Tue, 21 Oct 2025 20:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aNRmt28F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EF1D835C6; Tue, 21 Oct 2025 20:17:51 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 428E480107
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 20:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-78e4056623fso75889106d6.2
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 11:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761070668; x=1761675468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0A2JVx2QXxeKvA57b0/itTd7vt5WnxQ67/p0rjRR19c=;
 b=aNRmt28FBnly4inn0qJuOTH6UfqRBwKZDzDoXEw4Wsrxn2GvfVx+f+kTCUWUz0EckE
 /uRwxkDAKNgAU06jRCjD7z4iWVUJpeFE3F/F8NOrEu1n9yS0MDY2/W72ZiEjCh26JnJ+
 rRG5xO+0pg/GRvu/NtdN++UJ+qUtOuN+rM38A9hiNnwa8LqxeQMg0LUTmln6STAfSxfz
 qiWbDCl3yvnucnN+xiN/hVpk9J7O4qeYcPhTa3J+8hSZPcvpWzee/wXkVN3dpMdLeBHp
 HTpbQMql1JAYyiIODBGGQLu6jlPKzhTrNrCEVm5m/a8AW+mW/NBoWsIAyzNTCym6dJEm
 GdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761070668; x=1761675468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0A2JVx2QXxeKvA57b0/itTd7vt5WnxQ67/p0rjRR19c=;
 b=fXtqYU4ZFv1h7SdUW5C7YTR3ZlYpMi/+2XdaodOCb2R2oELrOmwkTadPOWm8e7WFUN
 UzXW/UbSVD9OSS7dTCXIItEuUvfjIWgfU+PVm+hGT0uy+10kF5MKyqPj7h8dBancc4oU
 Z4L23WbUWJN1TIgTacE+zUcbKrxywL3Xg8ZADTkMWI+ZgvNSwjhVAzVQdCPQ28Q8UOpI
 F2OsZeykeuqGtNOM74hkY17TFdPH/9WjugYRmUWcRQSVg6VeAJI1WKUnMjwsnZS/jQL7
 L1+EH8UCQNinovwPoaAv7xNkGzomjLIL6IZ7SgpSl2DN+bn7CqFLjZEVQs8ckCTt6nmI
 uV1g==
X-Gm-Message-State: AOJu0YwT+lbxByTZcP339NPKN5+F+FkSVSPVE+zUZgK1JUok0edWk5vj
 Z/hyKOxGtTp/61RZr7yUBuLoLGREEF7mp64N83jqBuB9TyFbpXWBIPqfFyc0sqrG23YDwRnkfDR
 ywWgR
X-Gm-Gg: ASbGncs0vzy/30DMADoNhjyhf+8qOG3vQnmlcMRDj1+OXhoU0Q6xtRoALirLWug7IXS
 cs1Atelz8qvqBvS0qY9VIYeZHSYlZWH5MKhWrdoA7n+pgo4kPpX8sDzRK42NL+pHtk6M6gpJzL6
 8v0dfZZLpsXM2XSra+Wlc6miqi6s37glpdT0bUi/AxMxK0Wx+sbmnvtyYY7eYLj1DkpEESGWGcg
 HI0ORgiD5C8zx+TH3L0nbgigUQRCADqixi6J01OELSYiPcU4mUu+yFVMWqnJjx0NbU8Qy3oLYb9
 LxqOKEW70nDKfdgFPrvkdcBP2Ar63qW1+3kwaYvgqSzAz7r2Sufx9HCwy80x1wEI0VAaxFhzyEE
 hXe3JKKdEA2KRRmotjVK9ivVZdbiXO8qq0LOwUYyJNCLCyrCxwmfq2l668Sa0suFW9zHqWodh60
 YYoDCKo/TW7OTiCyK+km/5bq2NlXA=
X-Google-Smtp-Source: AGHT+IECUGgUj6/zV35+k5cReVm/F8Qjsh/hMnUJcMGr842vm7cFjA+iZMfjXkNkfD61ZDUlG78rbw==
X-Received: by 2002:a05:6214:2581:b0:87d:c996:1bec with SMTP id
 6a1803df08f44-87dc9961f36mr140702306d6.49.1761070667689; 
 Tue, 21 Oct 2025 11:17:47 -0700 (PDT)
Received: from localhost.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87d02884878sm72831526d6.31.2025.10.21.11.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 11:17:46 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [RESEND PATCH v5 4/5] ci: check existence of bl1 and fip in the test
 script
Date: Tue, 21 Oct 2025 11:16:57 -0700
Message-Id: <20251021181703.598342-5-raymond.mao@linaro.org>
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

