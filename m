Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D977C5DF8C
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 20:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B61D81315;
	Fri, 21 Aug 2026 20:37:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DAQVUWb9he-s; Fri, 21 Aug 2026 20:37:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787344623;
	bh=73pQLLRm1+UHwI9GPaMCRGzJD/6L8o5Y1jkrGT10PU4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=y7lw0CTU+0qdZobi6JuSEs7orHT60dwOS6L+wATDQwXlArAn1x4tA8RO08H52OJTv
	 1WOqVE4J1Pi/KtXedASqJa60+rSPeGVTG2TSv+yzxIhFyzi4xV0b0quBCdr6MWFAfw
	 +t4/dOt2VaZSQc/0f72sUf1ZVm5mX1OjS/f7bbnSqt/I5Dkvmm0/9DrN1Z0fiKoRmy
	 JpgqYeF1XM7ZyIobEAcoUWg6OqN5g5RfKO0Hfi1faMdZ0USFAK74mE2rvYrI0stkaU
	 PHpBZxuxYAzJRQpNUFCdBMZO9tuOwXvmNj/GO82Nj4bWzl0Ii4PAcS7apjVn7V6Aot
	 RIV7G6Xxg7veA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE74E812EB;
	Fri, 21 Aug 2026 20:37:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 17359EA3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 20:37:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 08CA140C2D
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 20:37:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 12l5GiIOZNDE for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 20:37:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::29; helo=mail-oa1-x29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=s9m3rjMW
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5BE5B409E2
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 20:36:59 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-451fd21113cso2210786fac.1
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 13:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787344619; x=1787949419;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=73pQLLRm1+UHwI9GPaMCRGzJD/6L8o5Y1jkrGT10PU4=;
 b=s9m3rjMW1zuh/fx5PazUynH89cyXMV0tuH/lagls79WCzLIpFLyvSw1ihFCEs9z9Cz
 Od8NQLP750yyPN324tNUDy+KgBOlME4m6VQZkbHyeqYmkv6JQo1hIY4FnuDZ4i2FOK23
 2WI4UMg/4f4f7RF02Ph1bPLO4aIX9/Q+T1J+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787344619; x=1787949419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=73pQLLRm1+UHwI9GPaMCRGzJD/6L8o5Y1jkrGT10PU4=;
 b=WKhudDhYjtDYRLd3xh/PB+ge5MNoa1vpFXnSYdhNdqOwvtcGg084rqV7D/MOnf/qpE
 UNmopev4GtbGCNEZUojeByGbD8IPf8A5LuMUV1Ke9kjAxA6VBTz4xAgAgS5r8gkc+Wfp
 HZuOiJQXAarXQJRAW31y+mSBF0LGiRpy7BZgMGRGezO9LUoetxYcn47DlT7ImSfqx4ld
 sbvnYMsgsjMbthWlFNqYpA4m6eTAjkkItsX6uluPgjLK3Xox7knUBzYmzJG/xK4KGxOy
 hG4iqV1itY6HabcgGPzdj7sxc6qb0l5TYenwTkX+e2cHnk2dW31oqp1r/WF6zqk+Ql49
 NGhg==
X-Gm-Message-State: AOJu0Yy6SWhS58+TKIlDvVEWYRwyxbEUQjJK1FElytoQlYbz5ti/5fE5
 fTMV1gdjyfEcX/PHC6KsrGb0l8/MShmk9kFZa3QsUIbDOejjtdFpgqoNaAbuVtYhVThorylKXwb
 j3dmRZXe9sQUq
X-Gm-Gg: AR+sD12JbunN9wHy7wvL9zYI3ZkOvzo7xUyhpMkeAK4LQiB40D7mONV7Ci0Nwa4Fe26
 fYt1B5NN7zbLBhtuH2c8pu3ccBcL6+hmDR4ld9qATvWnlhqGnUKqsWbmjwWBtGPZKkeqJvfPFB9
 VtmlC1zpGKWz7/lM7+P4isXJfSHjQHlPFC4ZXxYzuvv3JDPRHzoodSA3xJH+ASSvQJBxI6S9GbE
 SDDH9DOUnzHzqByvADSZRswH2zR23Lckn/QwlnW5Q7B7PDQjzq1sGAuEvkALpUlJy1WnfxBT/Mi
 WRXBNPXRyVObIFjJiinjLkVqXyZWmVf6fr4sO3Q3ZPWUppqqTE9oJRo5J7m5jcwgkBG8EFfrxIA
 6gvw/WMoQu0OKQx71qQCy+n6/dfTsu46xLwZMhD60GPBYdhQ2tjpPN3X90aFnUc0G2knZfeR64w
 1DkYKrYYiZ9XxkrZ3dUMgke7Vn3p1mraD3t8asIGQwrWHyzo5uNdxhSLLYX18aojhku4JKVMAgx
 erbAiqEthYd5uWXTi2c7A9CpVhG2NRdC/dCfAesy/f8fhIhUC1W0DYFqvikdyBhGhwRw72n4rJi
 jVKv1heHRrI4sLVvPKYONpZJ3hq/OQl2mw==
X-Received: by 2002:a05:6870:568f:b0:45f:10:f963 with SMTP id
 586e51a60fabf-4631b2bfb5bmr15852305fac.12.1787344618950; 
 Fri, 21 Aug 2026 13:36:58 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4638354650dsm285433fac.16.2026.08.21.13.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 13:36:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH] CI: Run scripts/check_maintainers_files.sh in the existing
 MAINTAINERS job
Date: Fri, 21 Aug 2026 14:36:57 -0600
Message-ID: <20260821203657.3946004-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Rename the existing job that does some checking of MAINTAINERS file
contents already to be a little clearer that it's doing two things now,
and then also run scripts/check_maintainers_files.sh in this job.

Suggested-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
The overhead any CI system has on spinning up another worker means that
it's noticeably more time consuming to make this job standalone than it
is to repurpose an existing job.
---
 .azure-pipelines.yml | 3 ++-
 .gitlab-ci.yml       | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 015fc15d5c29..5130058925d5 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -90,7 +90,7 @@ stages:
           make infodocs
 
   - job: maintainers
-    displayName: 'Ensure all configs have MAINTAINERS entries'
+    displayName: 'Check all configs are in MAINTAINERS and validate MAINTAINERS'
     pool:
       vmImage: $(ubuntu_vm)
     container:
@@ -99,6 +99,7 @@ stages:
     steps:
       - script: |
           ./tools/buildman/buildman --maintainer-check
+          ./scripts/check_maintainers_files.sh
 
   - job: allyesconfig_and_tools
     displayName: 'Ensure allyesconfig, tools-only and envtools build'
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9831dd61bc18..e08068f1cbf5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -189,11 +189,11 @@ docs:
     - make htmldocs KDOC_WERROR=1
     - make infodocs
 
-# ensure all configs have MAINTAINERS entries
-Check for configs without MAINTAINERS entry:
+Check all configs are in MAINTAINERS and validate MAINTAINERS:
   extends: .testsuites
   script:
     - ./tools/buildman/buildman --maintainer-check
+    - ./scripts/check_maintainers_files.sh
 
 # Ensure host tools build
 Build allyesconfig, tools-only and envtools:
-- 
2.43.0

