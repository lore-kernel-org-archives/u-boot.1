Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987D6C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 20:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D89E780762;
	Wed,  5 Feb 2025 21:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CHmSVvz3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6E02800CF; Wed,  5 Feb 2025 21:29:11 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6776807E1
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 21:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-84ceaf2667aso13791839f.3
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 12:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738787343; x=1739392143; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Epdm7UOY89PDi5UVql07KJpwefYWGnVg1matScoqj+U=;
 b=CHmSVvz34yA9DqdQ3wXgnIkMnPBQoEFxp0c/OLnRwf7EWnkXj/y+lYNh6ILGeJLaCS
 wlFSQu7Ryb5AgUG1MxOiXgRyxdS4XVGRqIrCQI7wHIgI2Wd8DGIe/b/EIQh5WR+myJko
 OMW3nwRrXQ6Xyv0CArpkgJ5bAccuPSd7Ge3fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738787343; x=1739392143;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Epdm7UOY89PDi5UVql07KJpwefYWGnVg1matScoqj+U=;
 b=ULsA93wqWoULr/SNL6oA++6Yng1uQOFOnUftdCermltSzbh/zAncaPJvTzYymI/DCD
 wSZYUlobatsNFYOJqHDD8qW7i2+TU4XKeOt51/bs0+TTrxNme1qAcRB++VcXEnXd63Bs
 0G8Kma0+Wsh+cUbld89cX069692AFKfMrbFOSlocGNg/tkJgQWlN13pISr8J2A/WTOMg
 r+N1UNQ1UFc9YvG2HXj3uKqw/o6tczfMBa5XAy2GOdVU5djxawJMRrABG+ApTgF6NqPH
 HpEGgzYgI3l9iqZ8eqoNOlYxDWSmrsJwNHWEa2cxon9INQuotRHAWYOxRjWy59rYFgqn
 CyNw==
X-Gm-Message-State: AOJu0Yzyt1sG24bbnkWaEWjqWHZ51D5AzL+HILG7H1kpkCp/2jGSaxpp
 iaicXOaAZsPAxxdEp2n/rhg7jEwAw8NE2HTQJIXeoeFwsSl79wW+0JTE9jHBLC+zFhHdekNFPoB
 pow==
X-Gm-Gg: ASbGnctTbCemxN+H8It4bM5tZOynXjD9SANyP/iepKcKZ7mrLd36ud8bHjikUr+hLF2
 W+QtL4PPJxLiGb90mlLHECJ7+qi9r8Hau/GXTOj8UNBXDiWNdC8HNaP6BbMJgm3ofSUK8zdmzzK
 DQlWymqt373lhGBuJWPKT6kCdkwf9I9iVlvjatn0eZHbiKnFpoLtPU+RTtoAN8m4PcZTt2q3IKC
 EY2LWaays3C5Qnng8Li8zbxkx5rqSm0Yvg6ixdoM+Z7dVqbdvhkxnadPGj1pDAHeZ23Sw7nl167
 X1Yrq06xUdkuudM1kemTd9OVEObwgg8EZZZWz2pJJeyv8wPsVjnO
X-Google-Smtp-Source: AGHT+IGIVV/cBN1wb9IyL+NOLy2IwaTwK0FWXU0zkLFQd06HZV6CSpCUgW3e1IgC0PaWA1Zyg85J/A==
X-Received: by 2002:a05:6602:6cc2:b0:843:e8d0:a728 with SMTP id
 ca18e2360f4ac-854ea4401ebmr588971439f.4.1738787342784; 
 Wed, 05 Feb 2025 12:29:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec745cccdasm3401229173.71.2025.02.05.12.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 12:29:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH] gitlab: Add a Zynq Zybo to the sjg lab
Date: Wed,  5 Feb 2025 13:28:53 -0700
Message-ID: <20250205202857.1853673-1-sjg@chromium.org>
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

With help from Michal Simek I have this running with Labgrid now, so
add it to the lab.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 1d4d3a85741..a55b0c9ee7a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -736,3 +736,8 @@ rpi5:
   variables:
     ROLE: rpi5
   <<: *lab_dfn
+
+zybo:
+  variables:
+    ROLE: zybo
+  <<: *lab_dfn
-- 
2.43.0

