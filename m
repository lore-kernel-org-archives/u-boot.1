Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D0FC3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 094B48056A;
	Tue,  6 May 2025 16:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QZhmkVFt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8DCC82076; Tue,  6 May 2025 16:04:24 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0428B800C1
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72c09f8369cso1820517a34.3
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 07:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746540258; x=1747145058; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2qlTYqBEAb2lVcxsCdk1wLyJqEem33Mi12ynGaExz/k=;
 b=QZhmkVFt2u6e23tqVGsLtLTZmcbXXMvZxSUC4O++IwUTUIjKJPBe+GgIHitMNWsiWv
 oDend+RJl/FHiMWK3PXbaUqP0zmyVsWJ+s+WZCyOgcaSijoGt71Oix8RuAmLCB6ehaDQ
 R203Ol64arEIX0udXF3avhIUE/tcrqaRqYn8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746540258; x=1747145058;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2qlTYqBEAb2lVcxsCdk1wLyJqEem33Mi12ynGaExz/k=;
 b=O7mH0N8LbPXYSJwWeKPOJo98VzyAwDfngUwEji26838IfE71Yz25oQnrjxCIMdP0Jc
 3inS47wV0gesIKOSppnlnF3Pcc50iltu5lEVO2gUPB0tiem8uSa11jNAkz5YWA1i3pKY
 CLF9lYANkCnZqO8gWBYse9kxJPm+kYHcY0MPM53O8+P0NY88aJwW9t9/mPq3aF+U5AIb
 bLWCROwkXTBDe0eQcZ9nsAV8/MQtWvJfcZZHi+xtMHc9SKTcJPUlzo5JJXFnZ08YB1I2
 2Yz3nUATQVagGmFX6W7+W7GAieZFT0q/mPMabp6ciHJiMziHcuxKRa0l1Ka0OT1QVuwn
 LBEA==
X-Gm-Message-State: AOJu0YzyKNPCpauMqTSiZEVN3smoLHmJBfopdqi/S3Iz55isFENHyxbu
 lGa4xnPiN2X9twsCIEsz6nuJ+y6uqCCTgy38NZIywzjBQ0q4SzuVM7PdTIfvD/VA3wUIwWUEX71
 A
X-Gm-Gg: ASbGncsBH9TuINy7R/Zudi5tpoVljm0XMM246aKARM0iYwj7AkHBj6Qks7xIyonSZC1
 TlysBOBi0hCJXa+rS6VJ+vCDa3dfDmsuwE4C5yUT+Vz3B2TBZNfSwrexqgxko02cLMJdbV5ZEWO
 7+rULuKigw1T5CMnZ9VJc3PMeydEljsR4nLTaOFOSsdmTAiuyOhd7jeBOX/PTrNhuoB4XNPWFxH
 3J4GTR5zYcaJUpqQ83Qc71gi+xOOi+KxfNiwvV1kydeflG5Bm4Ee96cNxj95RQTrezdUKRAPeYq
 yG13g1b0/dLPe5Vahk/cxfrj+TKHsYNyuRZ6LIahGjgW4xU+2ei9xOmhiV0J69cAzUwkilIzR+U
 O38bXUOf6+mrJR4I=
X-Google-Smtp-Source: AGHT+IH8hYJkbgmDA4/9Thtgot6KjSkmGgyGAvyDbsreYbSTwu+RNzb4Hy3QBkJWmPVajBvlj2TmiA==
X-Received: by 2002:a05:6830:3704:b0:731:cac7:364e with SMTP id
 46e09a7af769-73206e8581emr1900928a34.22.1746540257685; 
 Tue, 06 May 2025 07:04:17 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d31dc4e1sm2092690a34.33.2025.05.06.07.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:04:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] Gitlab: Rework sjg-lab calling test.py to be closer to
 test.py stage
Date: Tue,  6 May 2025 08:04:12 -0600
Message-ID: <20250506140412.190005-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

There are a few differences between how the test.py stage invokes
test.py and how the sjg-lab stage invokes test.py. As a start of making
both the code and the output and artifacts similar, this updates the
sjg-lab stage with the following:
- Pass "-ra" so that we get the summary information in the job
- Make use of TEST_PY_EXTRA for passing "--capture=tee-sys"
- Re-order some of the arguments to be the same order when possible.

And most importantly:
- Create and save as an artifact the junitxml output.

The last part here is the kind of test result information that in the
future we should determine how to archive for future reference.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>

The JUnit part can be seen for example at:
https://source.denx.de/u-boot/u-boot/-/pipelines/26106/test_report?job_name=jerry
---
 .gitlab-ci.yml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ca3e87682e89..4ae2b16eb283 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -590,8 +590,10 @@ coreboot test.py:
     - export strategy="-s uboot -e off"
     - export USE_LABGRID_SJG=1
     # export verbose="-v"
-    - ${SRC}/test/py/test.py --role ${ROLE} --build-dir "${OUT}"
-        --capture=tee-sys -k "not bootstd ${TEST_PY_TEST_SPEC}" || ret=$?
+    - ${SRC}/test/py/test.py -ra --role ${ROLE} ${TEST_PY_EXTRA:-"--capture=tee-sys"}
+        --build-dir "${OUT}"
+        ${TEST_PY_TEST_SPEC:+"-k ${TEST_PY_TEST_SPEC}"}
+        --junitxml=${OUT}/results.xml || ret=$?
     - U_BOOT_BOARD_IDENTITY="${ROLE}" u-boot-test-release || true
     - if [[ $ret -ne 0 ]]; then
         exit $ret;
@@ -601,6 +603,9 @@ coreboot test.py:
     paths:
       - "build/${BOARD}/test-log.html"
       - "build/${BOARD}/multiplexed_log.css"
+      - "build/${BOARD}/results.xml"
+    reports:
+      junit: "build/${BOARD}/results.xml"
     expire_in: 1 week
 
 rpi3:
-- 
2.43.0

