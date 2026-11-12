Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2775606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=u00VPvTI;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=euVLoZ3v
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0DEA40AC8;
	Thu, 12 Nov 2026 15:05:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y2xW1VCUYF-F; Thu, 12 Nov 2026 15:05:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A8BC740D01
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794495930;
	b=ZSMfhDkIMskzYEJKH/WGYq4rLb6n0vErU9VpUJ/uf4yvTsWtepyASdg3ffrfqAJT2dlh
	 u8VP7fWFQdUc204vRVSTB8WFAG7LDVoN3PyR6RFc9YRFldN+2GKknQsqdr6AWTJiFauWJ
	 lh5ajw2o8wJmc57ZjZB+a6a0TmsBBYKZmghkMJYlM3KFi15kfxlaw8r5759WpLvr9Zqaa
	 mfORpke/59cWDrHAFEBqY0vOfFWhDoHdO/I6en4twQ20qLMW/9TlgXTbFyuDftELVE174
	 yNdFExjpwo5NOhBrXpinRKZCw9JeHPMlXta2MSGKms/Hz/cjH+JFgnqg4nRCMI7/cGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794495930;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=k4rEko7/46xche7qgWVnTParhOinp9XMBKgnjX0ocv0=;
	b=OHU0Rinqd6ITn4i1f/PsHT65WibGSltCt/HBN1qHCEv0bPHCSFTHuaodQlIR1m5boCin
	 yydBobYMSFf41bqq2YkudpC0rEcns5x+x3RWB5EhaKIrXR/NcvzjsSbphiLQ2ZJHTb6m3
	 FY5b9h7+PrZjcgiyocmGmpFWSSsGh4b72ZW9fv2SWjg7JZTWLc2HcOhQWLQdy6IOY7Nwk
	 hlm53gEfaFelu5ltcbHOP65k7kfeS5MIxVAbdM38Adp8jFEN5olTI+4n5fmtEAoPIo/uv
	 VOUryUrxGuRwoxoCbqyuL4m1Y8V/Zz/ps0Ou7c6/GA2WkcQpuQYxZrKw3KesHqo+h1A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794495930;
	bh=k4rEko7/46xche7qgWVnTParhOinp9XMBKgnjX0ocv0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u00VPvTI1vhVLMVtcPx8+6oWDt4utfLJ519lXnTYezHk8IyJRL6Sdq+pE+Pk0Un/r
	 4Bhmj5XrK8HceMVIMbKrRwfB7OtXBzC7XEAd3K+u36RzAEfu6Z0wi/fj7yefTVbVMn
	 z4knhyur/bN603QbG0m2dkbG8yKwlNbefGTqdEcxAaSWwc0yIhQHghasinxBgQDO/R
	 nulPzo/z4mK6UBAUHmfGoF7YmlnK6kfYi59KA9AhVWSI3+7tLzuyrTJPcU65lJV5YG
	 ktZ+/bgS1BXtJR435NAboPvztqFTEtzUt4x5F/MmfQMRh9IS/4DC+NwA0Z2mcCBq10
	 0pFv3upRZRvHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8BC740D01;
	Thu, 12 Nov 2026 15:05:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8ABE7E09
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 15:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D1548107F
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 15:05:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id saBnpiKSSI7I for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 15:05:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7B8EF81066
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.125.25.13
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.13;
 helo=smtp-190d.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=euVLoZ3v
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch
 [185.125.25.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B8EF81066
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 15:05:25 +0000 (UTC)
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jQNwv4QzHzHvt;
 Thu, 12 Nov 2026 16:05:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794495919;
 bh=k4rEko7/46xche7qgWVnTParhOinp9XMBKgnjX0ocv0=;
 h=From:Date:Subject:To:Cc:From;
 b=euVLoZ3vqf4uUxpDy24y8RwrQZPbHwM6+Oa1sMq5X4T8ecccXoypc79dkfYQJGbQP
 S1G2fYCoGwbKq/hHZwG4q7WVUqLs9YdqJQvubmixCQB0p3f8NRF0sDKiRwiX/idU0a
 ue5svWlCYOkbTf12cTSptx7xyq0dSEIoPjHLtmIuECroPAQH3nTYUyLtnO8tUhH4bF
 ktjnlaNcnfAzwSOCeJF4b/2RuVXoG0GevKL96jSqx6OtOMHfF1cSvMXh4JafWkmd5o
 EPMR/aY84WHubdqX3/Iu6wHbJnsP6qUMDkrLSFIl+HbVMRLQuFK7EPifDEu3zmiudn
 0ZN5ha6scURJg==
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jQNwt4nhpzpCm; 
 Thu, 12 Nov 2026 16:05:18 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 12 Nov 2026 16:05:04 +0100
Subject: [PATCH] .gitlab-ci.yml: remove Simon's lab from CI
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-sjg-lab-removal-v1-1-4473fe34c2cb@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMwQqCQBAG4FcZ/rMD7Uqx7KtEh1FHGzGNnRJBf
 Peojt/l2+FaTB2ZdhRdzW2ZkSlUhPYu86BsHTIhnuIlhBDZx4EnabjoY1llYqm7qCmls0qPivA
 s2tv2G6+3v/3djNq+vg2O4wOyXZ/TcwAAAA==
X-Change-ID: 20261112-sjg-lab-removal-a3d2e8885eaf
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

It wasn't migrated to the new GitLab infra, and won't due to Simon's
departure.

Stop creating manual jobs that can never work.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
There are still a few leftovers in the tree related to his
labgrid-specific changes (that have never been merged in labgrid as far
as I know) but this will at least be less confusing to custodians when
looking at the GitLab pipeline.

This was not tested.
---
 .gitlab-ci.yml | 178 ---------------------------------------------------------
 1 file changed, 178 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0338f20b8a2e..b78f7a9775ad 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -6,7 +6,6 @@ variables:
   DEFAULT_FAST_TAG: "fast"
   MIRROR_DOCKER: docker.io
   SAGE_LAB: ""
-  SJG_LAB: ""
   PLATFORM: linux/amd64,linux/arm64
 
 default:
@@ -26,7 +25,6 @@ stages:
   - testsuites
   - test.py
   - sage-lab
-  - sjg-lab
   - world build
 
 .buildman_and_testpy_template: &buildman_and_testpy_dfn
@@ -626,179 +624,3 @@ coreboot test.py:
 
 # Add sage-lab stage
 include: .gitlab-ci-sage-lab.yml
-
-.sjg_lab_template: &sjg_lab_dfn
-  stage: sjg-lab
-  rules:
-    - if: $SJG_LAB == "1"
-      when: always
-    - if: $SJG_LAB != "1"
-      when: manual
-      allow_failure: true
-  dependencies: []
-  needs: [ "sandbox test.py" ]
-  tags: [ 'lab' ]
-  script:
-    # Environment:
-    #   SRC  - source tree
-    #   OUT  - output directory for builds
-    - export SRC="$(pwd)"
-    - export OUT="${SRC}/build/${BOARD}"
-    - export PATH=$PATH:~/bin
-    - export PATH=$PATH:/vid/software/devel/ubtest/u-boot-test-hooks/bin
-
-    # Load it on the device
-    - ret=0
-    - echo "role ${ROLE}"
-    - export strategy="-s uboot -e off"
-    - export USE_LABGRID_SJG=1
-    # export verbose="-v"
-    - ${SRC}/test/py/test.py -ra --role ${ROLE} ${TEST_PY_EXTRA:-"--capture=tee-sys"}
-        --build-dir "${OUT}"
-        ${TEST_PY_TEST_SPEC:+"-k ${TEST_PY_TEST_SPEC}"}
-        --junitxml=${OUT}/results.xml || ret=$?
-    - U_BOOT_BOARD_IDENTITY="${ROLE}" u-boot-test-release || true
-    - if [[ $ret -ne 0 ]]; then
-        exit $ret;
-      fi
-  artifacts:
-    when: always
-    paths:
-      - "build/${BOARD}/test-log.html"
-      - "build/${BOARD}/multiplexed_log.css"
-      - "build/${BOARD}/results.xml"
-    reports:
-      junit: "build/${BOARD}/results.xml"
-    expire_in: 1 week
-
-rpi3:
-  variables:
-    ROLE: rpi3
-  <<: *sjg_lab_dfn
-
-opi_pc:
-  variables:
-    ROLE: opi_pc
-  <<: *sjg_lab_dfn
-
-pcduino3_nano:
-  variables:
-    ROLE: pcduino3_nano
-  <<: *sjg_lab_dfn
-
-samus:
-  variables:
-    ROLE: samus
-  <<: *sjg_lab_dfn
-
-link:
-  variables:
-    ROLE: link
-  <<: *sjg_lab_dfn
-
-jerry:
-  variables:
-    ROLE: jerry
-  <<: *sjg_lab_dfn
-
-minnowmax:
-  variables:
-    ROLE: minnowmax
-  <<: *sjg_lab_dfn
-
-opi_pc2:
-  variables:
-    ROLE: opi_pc2
-  <<: *sjg_lab_dfn
-
-bpi:
-  variables:
-    ROLE: bpi
-  <<: *sjg_lab_dfn
-
-rpi2:
-  variables:
-    ROLE: rpi2
-  <<: *sjg_lab_dfn
-
-bob:
-  variables:
-    ROLE: bob
-  <<: *sjg_lab_dfn
-
-ff3399:
-  variables:
-    ROLE: ff3399
-  <<: *sjg_lab_dfn
-
-coral:
-  variables:
-    ROLE: coral
-  <<: *sjg_lab_dfn
-
-rpi3z:
-  variables:
-    ROLE: rpi3z
-  <<: *sjg_lab_dfn
-
-bbb:
-  variables:
-    ROLE: bbb
-  <<: *sjg_lab_dfn
-
-kevin:
-  variables:
-    ROLE: kevin
-  <<: *sjg_lab_dfn
-
-pine64:
-  variables:
-    ROLE: pine64
-  <<: *sjg_lab_dfn
-
-c4:
-  variables:
-    ROLE: c4
-  <<: *sjg_lab_dfn
-
-rpi4:
-  variables:
-    ROLE: rpi4
-  <<: *sjg_lab_dfn
-
-rpi0:
-  variables:
-    ROLE: rpi0
-  <<: *sjg_lab_dfn
-
-snow:
-  variables:
-    ROLE: snow
-  <<: *sjg_lab_dfn
-
-pcduino3:
-  variables:
-    ROLE: pcduino3
-  <<: *sjg_lab_dfn
-
-nyan-big:
-  variables:
-    ROLE: nyan-big
-  <<: *sjg_lab_dfn
-
-rpi:
-  variables:
-    ROLE: rpi
-  <<: *sjg_lab_dfn
-
-# StarFive VisionFive 2
-vf2:
-  variables:
-    ROLE: vf2
-  <<: *sjg_lab_dfn
-
-qemu-x86_64:
-  variables:
-    ROLE: qemu-x86_64
-    TEST_PY_TEST_SPEC: "not sleep"
-  <<: *sjg_lab_dfn

---
base-commit: 3cb2cbbc75aa7fe2391f662607d6b2f46c1292a7
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git main
change-id: 20261112-sjg-lab-removal-a3d2e8885eaf

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

