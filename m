Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B722BCEE35A
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 21:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B89F783A48;
	Tue, 18 Nov 2025 22:00:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JoLbh5DS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BD2583A41; Tue, 18 Nov 2025 22:00:23 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D996F83A1E
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 22:00:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c6dbdaced8so3979933a34.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 13:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763499618; x=1764104418; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3NGGc+VknJCzqx/gNTf6W0qj/VytMdPZxE5bmTifVk=;
 b=JoLbh5DSJ/qluaFr1sbvoG15clIIYE3B7c2fu7ZNgNJXLLuWauvOFvtgV1EUYXsfIX
 fX43JuZrMW17OYf1vOVMKvVSCUlmnf3rIFWcGDVQlfmFSr2wJYde46lY9s+vJ7QAdqnd
 DrpUWtWUqyI2OGSgzr4T2ES3My5P1DvOVt0z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763499618; x=1764104418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j3NGGc+VknJCzqx/gNTf6W0qj/VytMdPZxE5bmTifVk=;
 b=aXg/8VY7/96afvwlBXJAdjXxlZI4X3iLHKaIKuTi7qqTijHYpnWe4N5XFGK3NU5Waf
 DTF5bi9JOdyzG+R1sswjCYMLlzqCuPTWUuD8xGODWSXgU9F3wZEogc9WCjAvLKjmWoa1
 +LGZ1tZTTeNdcC1tk9+UYtY09m2W4H8P2TtZ2v7NUiNhVcdFmb12eijgv0QzZlqdCBIW
 HUVpE6zcq7wU8joqNGFjsGUIh2pMIuXhReVvQIl1CtHuHvVZhcgCRqVzEeSNGjJt1xYE
 T5mEhs4P8nX7pTJFopMBjUdTTR2acl+LWK8/MIXjy1W7hVJFLP9PgKSk26SM+cSvlm3s
 +A5w==
X-Gm-Message-State: AOJu0YyvbDb5Lhb5EPoCowI/U0s/Js2QtbFSOijaz1USaC+nf36+L+P5
 z8PH8b8XRLlHTEwCIEPWPSEvv8dVEx5VhBqXz1F1HT3qrTsEmXyLIRUxJqMBFgoAboSI2NrBcqf
 loyNdYdsHqQ==
X-Gm-Gg: ASbGncshNzDnYOnlzhTcZCJWLLByW/sYnl/BXckoHuAoOVFkZnf/D2mlIvMuWHkvG5S
 Za7dW6DsZPvIERkj7n0Voi6C4k8VDYM/z+X5/sZiZjfIycdvftd6J+B6FuLZJHScG10PR7OLybl
 Grc0pwaWdST/ZpuX37DYUCun6+zGPWNDqBHs80rdaAf+JosdZkPsyhVJa7/dg+sGCpSTVMyQNHM
 McWNw8JNMkU3A2ItWfg5IECXX+/UZqP8Ib45OWxbpbssnvem/HTTx5+xGdtfb6z5TnNb22D3DXA
 sU8v1apnDaUKpVmPn5CIocAJZZ7REe1jjlpNfF27K0LEf+ZQoVthvorBFXrO49Ph+/OhYIVBuAp
 7vU9f1xiPLecN6Ux0ANRr3wvtG4QKN10/DKc3W+tjvmpZnM98zsVn4MpKNQyyf1F8Uy2l95igqr
 8V7EyFZI56Go7JOJtJ7WU6Be0Bj8ZP0PfNCFGC8M0C89hV/g0PCG00mQF4FSSFoZw=
X-Google-Smtp-Source: AGHT+IGemn/aFF9R1IsVcC0KpYtgd/HMpgkLJSMqUyXGqOBbQUPrWRFCbmDL8qYpJARWk28RZGZXyg==
X-Received: by 2002:a05:6830:486f:b0:7bc:6cc3:a624 with SMTP id
 46e09a7af769-7c7445b01bfmr7555116a34.32.1763499618130; 
 Tue, 18 Nov 2025 13:00:18 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c75610f638sm3583110a34.21.2025.11.18.13.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 13:00:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v2 3/4] Gitlab: sage: Add Pine64+ platform
Date: Tue, 18 Nov 2025 15:00:14 -0600
Message-ID: <20251118210015.624758-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118210015.624758-1-trini@konsulko.com>
References: <20251118210015.624758-1-trini@konsulko.com>
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

This adds the Pine64+ platform to the sage lab, for both legacy and lwIP
networking stacks. In order to build this platform we need to copy
certain files that were built in the container to /tmp and then set
BINMAN_INDIRS to /tmp in order to find them when building.

For now, we disable the test_net_pxe_boot_config test on lwIP as it
leads to a crash that needs to be investigated.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>

Andre, Jerome, how would you like to handle looking in to this issue?
https://source.denx.de/u-boot/u-boot/-/jobs/1303375#L2235 shows the
crash and I don't have enough sunxi targets to know if this is more
broadly breakable or not. But it doesn't happen on lwIP + Pi for
example, nor lwIP + Hummingboard (mx6cuboxi defconfig). I can't at this
point give remote access to the lab directly, but I can help come up
with a gitlab job that'll acquire the board, build and try and boot
whatever you have.
---
 .gitlab-ci-sage-lab.yml | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci-sage-lab.yml b/.gitlab-ci-sage-lab.yml
index fa7d79668b2c..815c93087f4f 100644
--- a/.gitlab-ci-sage-lab.yml
+++ b/.gitlab-ci-sage-lab.yml
@@ -35,14 +35,21 @@
     # Prepare ssh
     - mkdir --mode=0700 ~/.ssh;
       printf 'Host sage-exporter-*\n\tUser labgrid\n' > ~/.ssh/config
+    # If we have TF-A binaries, we need to use them.
+    - if [[ -d /opt/tf-a/${TEST_PY_BD}${TEST_PY_ID//--id /_} ]]; then
+        cp /opt/tf-a/${TEST_PY_BD}${TEST_PY_ID//--id /_}/* /tmp/;
+      elif [[ -d /opt/tf-a/${TEST_PY_BD} ]]; then
+        cp /opt/tf-a/${TEST_PY_BD}/* /tmp/;
+      fi;
+      export BINMAN_INDIRS=/tmp;
   script:
     - export UBOOT_TRAVIS_BUILD_DIR=/tmp/${TEST_PY_BD}
     # Don't stop on non-zero exit codes now, to provide as much chance as
     # possible to ensure we don't leave lab resources acquired.
     - set +e;
-    # Sage is 16 threads and has 3 devices attached, so 6 builder threads.
+    # Sage is 16 threads and has 4 devices attached, so 4 builder threads.
     - tools/buildman/buildman -o ${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e
-        --board ${TEST_PY_BD} ${OVERRIDE} -T 6;
+        --board ${TEST_PY_BD} ${OVERRIDE} -T 4;
       RC=`echo $?`;
     # Wait for the exporter to have the device ready
     - while test `labgrid-client resources |
@@ -79,6 +86,25 @@
       junit: results.xml
     expire_in: 1 week
 
+Pine64+:
+  <<: *sage_lab_dfn
+  variables:
+    LABGRID_EXPORTER: "sage-exporter-pine64-1"
+    LG_PLACE: "pine64-1"
+    TEST_PY_BD: "pine64_plus"
+    OVERRIDE: "-a CMD_BOOTMENU -a CMD_LOG"
+
+Pine64+ (lwIP):
+  <<: *sage_lab_dfn
+  needs: [ "Pine64+" ]
+  variables:
+    LABGRID_EXPORTER: "sage-exporter-pine64-1"
+    LG_PLACE: "pine64-1"
+    TEST_PY_BD: "pine64_plus"
+    # Leads to crash on lwIP, needs investigation.
+    TEST_PY_TEST_SPEC: "not test_net_pxe_boot_config"
+    OVERRIDE: "-a CMD_BOOTMENU -a CMD_LOG -a NET_LWIP"
+
 SolidRun Hummingboard 2:
   <<: *sage_lab_dfn
   variables:
-- 
2.43.0

