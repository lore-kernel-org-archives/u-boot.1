Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6F0C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5982488315;
	Tue, 18 Jun 2024 16:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O7exKGax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 174BD88356; Tue, 18 Jun 2024 16:18:56 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB50F8839C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6f855b2499cso3025536a34.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718720332; x=1719325132; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mCs3UThhKT7zVvO8QZopGlP21s6srKizjKNVIUot+/M=;
 b=O7exKGaxN+OJ6QADyhbbVQh4wxo3dapIh5KGkkM9qNo6jqQfczNn8sk38qT/bie9Ut
 XfQSPeMr8f6TiPsnUKt3ns4WTIwhtO8ne+x7s/6zqWBzOjkrCRc6LtO5pKig9Mz/wD1g
 V2W/51nV9w+5m88Btu2TOqPpRRAIuIlNISyYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718720332; x=1719325132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mCs3UThhKT7zVvO8QZopGlP21s6srKizjKNVIUot+/M=;
 b=Hp2RPFtzAL16R5wW9Xrvd7bW9p1+/LFwSFTufyIW6pHpJw7EgXacIA0KjmilmBBI98
 bjAbM6KS9Phoz6YHydpHXghkb0zQiiyvM+D4L7sLEIeggd7UiR84JMVvgtce+vPTWOzL
 cwoJMpE6VXSoFibAodscBx3kPwE3lPscRPPRHpAikLo9WUkUeU3oDzQdDp9wpZ0UCwp/
 aKfOL/xKjJhArPvIHPLI3jjrKKhE0v2K+HyQKs3OVqDZj9WHbBHhM6Wz0uXfsy7ipWux
 3FRE5FCq7XkWjcBjh5odHrebehBUVwNmCpfhaPR8q7JmXTQzQ5e3G17CyF37StCjJ082
 8IQA==
X-Gm-Message-State: AOJu0Yz+fJXTegjFwqWD06gDftmCiVpuijM1C6Z5OXgFEUMG/4z9u9Y+
 zwo0Nc5IB4C1PCbK8/sM8OrCgNU7ad85My4GirfjW8QyJllNu/aKV+wJPx0+2zw4a6RI66yeHI1
 RN9yDUg==
X-Google-Smtp-Source: AGHT+IH0p8R+yJ9EKOJRWZNmMshYfNEfH/8Mx9QT6qXmSuW+ZLtesFmf1Hn3CU28v4pWvcPrFRQ+pg==
X-Received: by 2002:a05:6830:a:b0:6f9:a91e:f0fd with SMTP id
 46e09a7af769-6fb932992e8mr14808263a34.2.1718720332518; 
 Tue, 18 Jun 2024 07:18:52 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-187-190-205-45.totalplay.net. [187.190.205.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb5b1b0bd9sm1844183a34.27.2024.06.18.07.18.52
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:18:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/5] Azure: Correct comment about the strategy in the world
 matrix build
Date: Tue, 18 Jun 2024 08:18:47 -0600
Message-Id: <20240618141851.3303112-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

At this point noting that we have a split in our job similar to TravisCI
(which we have not used in years) isn't helpful, and is also not true
anymore either. Instead, explain that we split the world up in to 10
jobs as that's the maximum we can have going in parallel on the free
tier of Azure.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 27f69583c655..f662f41872fd 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -473,8 +473,8 @@ stages:
     pool:
       vmImage: $(ubuntu_vm)
     strategy:
-      # Use almost the same target division in .travis.yml, only merged
-      # 3 small build jobs (arc/microblaze/xtensa) into one.
+      # We split the world up in to 10 jobs as we can have at most 10
+      # parallel jobs going on the free tier of Azure.
       matrix:
         am33xx_at91_kirkwood_mvebu_omap:
           BUILDMAN: "am33xx at91_kirkwood mvebu omap -x siemens"
-- 
2.34.1

