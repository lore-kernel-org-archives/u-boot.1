Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989F5C61DD6
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 01:50:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BB0580FB4;
	Sat, 29 Aug 2026 01:50:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IzeIV9E_GmmA; Sat, 29 Aug 2026 01:50:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787968244;
	bh=VAW+O1J+pNK0ywvy946gJkHqCM/dwkXjpUDf8ODpQo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oi+7c0u3Auq3q/8Y9dS6SP13vC+HstEA1Uf5pe4EiQNIObx4g8CfZrMPlnlUD5R5r
	 4XJHqxSPlmZ4LMqWvoxp+lhLCm+QIsiW7bNhLB0G3+bY0MdcV8obl86aLF3VTKYg9C
	 0jRQcaXTQShix56E6Qu7SjdDkhJRFSXeJi20E6WQJdiEtKeb4nbLBmLEQ1GxYx7aU4
	 8Ct+h2ANyZCC887zD0lUY8oxPRwZeemP3VjF5YEYmtjoaErKoBAJbTKbvrKacpR95e
	 MNNFB3UStwxe5SA+MYEaUQat7WlXXv9XPKOI0KUVeasA+BJePpUY1iX4fQo0XM5N6m
	 nJh7+i5LQ4O1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9A1180FAA;
	Sat, 29 Aug 2026 01:50:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9515D1DE
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8712040068
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jrbr9PXlaBj8 for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 01:50:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=NoCS8sNV
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B769D40056
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:35 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7eb5bdb50fcso1701814a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787968234; x=1788573034;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VAW+O1J+pNK0ywvy946gJkHqCM/dwkXjpUDf8ODpQo4=;
 b=NoCS8sNVvXl0uLgzBILREZ17MmM5soR7anP/A1T0Jad1cTzomWbtMMh3wfRpUEx31f
 Q5rfctvnDXlACwMPLBBqm6oknncq72afZSvyDlXRPS8KhegAQ4GEfcIX4nn3vHscMHrc
 6tBsPp2Y3wEgbX2sViCeEyjcJWZQO5vTT7Ofw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787968234; x=1788573034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VAW+O1J+pNK0ywvy946gJkHqCM/dwkXjpUDf8ODpQo4=;
 b=emVao4xvECqFjrxW8wX9W8ffxeCQTBQXQBzyjIgt6XKGzHtIkwdnSXn0j0vkb8SRzs
 9QkjMDSqRDyS+Z9FJGaMDuBp7JVwpmASytR/FUbPwjoFWSOubqvxh9B0CYBAH62wn0oN
 TMS8rsgNU5z6aLqcKf9pZCPuR5Txw07ASzUET3yw8Ufcl0hc4C3jGdrIh1rEznI1gZPE
 bvlTeWoWeQDaKhZh5D4QFWmm3PeW8Q7NevlpyWjo6dCEbb3nKCHY2yYHeaVXwlItXwGN
 c7nULQm/hfd2H1ln6jw0NXfDE9ORy3fijWV/WG39rQlBw64bea3+149pLM5fNmm6W0ki
 WtZw==
X-Gm-Message-State: AFuF++kl1nvSeAnN7OqdtD3YI3yY7H3th2hs3VZ+sYpAltkIW/GhWTay
 TuuvDg6UhTpy6hKJgHeAAqB/aqhUZqmFVvBF71C0DLLOkYo3LM54a1hp7UFsYBmGGXbJ5/aeBkU
 4cxut7AW+qJGA
X-Gm-Gg: AR+sD10dPcgbnBwxFAc/IMQFDYnRWitqTGzKTgGU9FfluKGcMeSt5ZrG/os6o7b4f89
 iJdDHvw4QdLi5+D3Hikk71cwEozWxp4kNhFqs6Q+Q1Z+SG8DKfwbzGHj0h93aiKof+eThq5gNWn
 doRzb4ovn9LqSs2iJLP/OaAJfYR+ppwEHULhp8C8iAg6L+XVmstXvwDn5wXCtd5PXOBS/JThgeR
 8hH7lYQ5BclgWbSk2Erg2bZzWY9OM22la3u6tacg7avenQaN3Pb65muUfMbl02dE2fRLQJiHzNZ
 tsQD1HXvz5jd2breiILV66SPASvcR24H3Ak8xduizL6jM6max2Nxl3myMO1v4Ulof16DeqLdEmy
 Us48yI+Fw9mdq4q1TrJ+Vv418FMWRwMv/Y9vyvCJR7oLTHuFJ2rxuLm63VHJKDyXo9yJWsbtMxb
 4mawJkN6ou+bZwnVnQ34FuiS6M/cTc6Ad0EYDmV95z0RVhVfPU8miL9cbylQBP87wvFhxBw/od2
 kOZBO2PIqOjDzLAZ1gBc6N41QW7oWg2pmhw+SzOqGy14TAHiGYvUQjY/MMeAGELLtq9Tk9+r1qh
 ACCH+3XymVmIVOOVOGqpANbvXVLX2aF7fQ==
X-Received: by 2002:a05:6820:f1ab:b0:6b1:5c8b:c0b9 with SMTP id
 006d021491bc7-6b1c661fbc2mr9068011eaf.3.1787968234491; 
 Fri, 28 Aug 2026 18:50:34 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a353d45asm3070190fac.7.2026.08.28.18.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 18:50:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 7/7] CI: Run scripts/check_maintainers_files.sh in the
 existing MAINTAINERS job
Date: Fri, 28 Aug 2026 19:50:25 -0600
Message-ID: <20260829015026.473134-8-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260829015026.473134-1-trini@konsulko.com>
References: <20260829015026.473134-1-trini@konsulko.com>
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

