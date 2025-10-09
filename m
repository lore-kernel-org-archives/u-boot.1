Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6321ACCD187
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5A0884522;
	Thu,  9 Oct 2025 16:31:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZvtHwaKO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5200B84528; Thu,  9 Oct 2025 16:31:01 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CD0184112
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6477f91713aso464210eaf.2
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 07:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760020258; x=1760625058; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=iKxAb5iVpmZ+X2kSgcm6lIvkM5dDs4VzQwN+UojGLxM=;
 b=ZvtHwaKOv/cWXowa5V23itlxzl0E0SjKfR3WEJutOU1Iem8yVpIUsQdW1jcxXHMy7r
 tZON0KDcBliyOC7Ay2es6IQVm8agfRv8z7kYUmB2vcXY9Lk/FRA/EGPR/GugNfxzXyTm
 lx6A+2KGLluv++kp1s6DsU042ex6rj85ybgvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760020258; x=1760625058;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iKxAb5iVpmZ+X2kSgcm6lIvkM5dDs4VzQwN+UojGLxM=;
 b=mtOiUod/kqPvx/x8QlGpH7JkVHABDKOYuJaRd23//UMXzZqMtyC1IUftEncsfwoP0/
 3DrRLj1wVotzUuSnICl+zQZATiz0Uh+dOmJN6KiEtcWJvBzIyiLNJuCdw658X3ksVNZ2
 mZdJ6CAeEK2ajhOl1GN8Zs7Fyp/wQ1xCGJXu7shlpNm5vC6aetb3T2xTc0z0ma+TuNbW
 hiGsD0sDn5D4kInKRg/KlJfxGi1Tu4oMzZzm/br4P4OeskKjgdwisCBsGZHbQtOm4EW/
 Fi6tARGqrnQW9ghocmI8l5d70fOt14r6kozDZHU+WCdNBdok1N8tCJbPgBfGvcnWmf6I
 ppzQ==
X-Gm-Message-State: AOJu0YygGydPOvdFhRw/l4G3BowH47+moUE/JKcbggGPXWtlpAajVfGK
 5yj2UvnUXR1IGy2f3GBuPjm+o0bFZkyIbjN0hjTppryAZutZXeNRVW3Y8Ybjk/8pT44ymQiQwfX
 4eWQB3i4=
X-Gm-Gg: ASbGncuXwNpLZ685BKytWASzAYccDYRhPU+uAumvn/EOHpZmVXDYvv/iFoeGpnPL9Ls
 2nX4jVQhZLyXaCyNS3Cd+RJo8J60k7ff9LxcThVg1gLA+Z4Xfe1etUlIp9QWG56iHwmu87m5NaG
 Rks7PKER45Z9oXihi60C44xPAKyginOtTi41metNselotPvCfQf5/hyT5uYcbbieZMSAUVytng6
 36yJ9RCID/MlrmeTQjaVQeYTKUEEKmqu0qQFAS8dxzAehZmfVxM4kFmOwIYAyczt+TZCKV7HqeF
 8uTHmrgJb6v0QlE4kk7AUcQl3kM5vJZIPo7BYWaTPuKkEBtojMwShFfVWso9TP1+EA4wWXrb5da
 bwcS77xMl3U4EeJmeMBuoCLsLF9FQeLijbufoixTuJn8lfpBCI1CJUgJyASyGIWYcS2HiYHdq0b
 x5W79PYDElF979
X-Google-Smtp-Source: AGHT+IF7ASRR+0N3yR3aMiTmTO8CrASSiBXMRkUvExUpsFIU5Sx8ZNmyl3KJdscRjs1HmdynNJlKYA==
X-Received: by 2002:a05:6870:b402:b0:306:ed52:c174 with SMTP id
 586e51a60fabf-3c0f68e260dmr3370625fac.12.1760020257613; 
 Thu, 09 Oct 2025 07:30:57 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ab7ce5655dsm7005710fac.13.2025.10.09.07.30.56
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 07:30:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [u-boot-test-hooks][PATCH] labgrid-trini: Quick update for labgrid
 v25.0.x and later
Date: Thu,  9 Oct 2025 08:30:55 -0600
Message-ID: <20251009143055.3161450-1-trini@konsulko.com>
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

Starting with v25.0.0 LG_CROSSBAR has been replaced with LG_COORDINATOR
(and the whole crossbar to coordinator transition is well documented
upstream). Update our usage.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 README.md                | 2 +-
 bin/common.labgrid-trini | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/README.md b/README.md
index ecf8a46c4a58..6171669228cf 100644
--- a/README.md
+++ b/README.md
@@ -253,7 +253,7 @@ That should be all that is needed.
 An alternate implementation requires setting the following environment
 variables must be set as per your lab:
 
-- `LG_CROSSBAR` must point at the crossbar service.
+- `LG_COORDINATOR` must point at the labgrid coordinator service.
 - `LG_PLACE` must point at the device under test.
 - `LG_ENV` must point at the labgrid yaml file that describes your lab.
 
diff --git a/bin/common.labgrid-trini b/bin/common.labgrid-trini
index e07107462a5e..b3c7d07ca7f0 100644
--- a/bin/common.labgrid-trini
+++ b/bin/common.labgrid-trini
@@ -19,8 +19,8 @@
 # DEALINGS IN THE SOFTWARE.
 
 # Ensure we have all environment variables set
-if [ -z "${LG_CROSSBAR}" ]; then
-	echo "LG_CROSSBAR is unset";
+if [ -z "${LG_COORDINATOR}" ]; then
+	echo "LG_COORDINATOR is unset";
 	exit 1;
 fi
 
-- 
2.43.0

