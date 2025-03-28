Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BFCC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 130EA81DB4;
	Fri, 28 Mar 2025 16:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cNuyuA/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C9C882075; Fri, 28 Mar 2025 16:36:35 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73C2E81E6C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-855fc51bdfcso91536439f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176191; x=1743780991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srVSNAH+5NgFAPT/MuiW9exJshom0WLq7m3++PI3d+I=;
 b=cNuyuA/mHwCSxsVUIV59E7C+1KbBGID1uUclX9r++KnZLxHn7mGnBAQefjHhIgvslY
 BbpqdoHkmbhwWVLrQSM7M0KYYpv8SmiIdu8kFsMhhUe/AM/O4NtbRKRJIn652GdlELQo
 MjSTQd06djMu9I1DBPfh5kJ9jmXByBZc3jn30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176191; x=1743780991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=srVSNAH+5NgFAPT/MuiW9exJshom0WLq7m3++PI3d+I=;
 b=COrlhStlXZuxvBfius6gdWVSdQQm73TH1Heibf4+O8E0HCSZbLMJdNAkERnX0u3CRH
 6exTLRuokXHVzT0shNvbrIWAA32V/NCOomhyBv/5YFwQQnSbO7begL/ykQW2GzFayRyc
 FHrtbUkrcwLxItCIK+vNMhhrNV5hXei5PlhXlc67ZVcdRnpu1YRy7Qtlx+gAK6TTsapD
 DhPbQZTb7uWQCYATKE2w6fL2GNRXzvYj/1BHSTfmq6TuHUuYD+dfgvKZoXXNtr2kM6Di
 vPhgf664I6V1FrkObGDfsk1EYBNrfb89LoDyUOjJxyrf5NFsPKqWRcpktbt4cY49e/rm
 jhTQ==
X-Gm-Message-State: AOJu0YwSTIoHgAJ9JEHeWVFH1yYzwZ/FifbK4LZ5FZnesD0ZCAv+Uc5A
 QnIP4xWvF9pE0U3zgj9zosOMyyvcuXAtyN7+/1pvGQzKxN8wHV+LJtrMJw6bJ6c4gAMKj/Dzuwc
 =
X-Gm-Gg: ASbGncs36HPUKl2nr4MwZ+rNxL0HtZGXWx3Izta3Owy9bwlfp/Y6bCdWXknMPd1N6H+
 ureoqViUIk2ZQ0bebMtysc69aVKFh2LtdPehQ3Uk8eTNXZCSpjg+v5B4SPogu2LO3dzta0FeC8m
 HQbsLgIMejHz5BugknboGJxQNP1TP8+70fY6VfNO5tWZMHG6BtBZc/HuGhNtHHKCU2gOHftKkaQ
 8OE0byhml0dmhbo8pWrTtR/+8SZ+xJO3fZ/+g6/ROEoKrtK05QQTUFvmJZbjgx/xq4TJNoSG1AD
 MpGXRvC2/2oJlgw6pMltNqMImwS1dZuNch1m2ongdcNzTigOl8fY/21FLzWW+Q7sQzclLW0Sl1/
 1is2uQA==
X-Google-Smtp-Source: AGHT+IGlt40bIUcTSSpau0sOOxrcLHPX30rgt9pGlkHAyQTqfPPHxVpxsYVQtQ6xbLKApejlVQkF7w==
X-Received: by 2002:a5d:97c3:0:b0:85e:16e9:5e8d with SMTP id
 ca18e2360f4ac-85e91e72744mr313925239f.7.1743176190878; 
 Fri, 28 Mar 2025 08:36:30 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 25/31] gitlab: Add an VBE board to the sjg lab
Date: Fri, 28 Mar 2025 09:35:05 -0600
Message-ID: <20250328153522.3555472-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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

Add a rockchip rk3399 board which runs Verified Boot for Embedded.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 .gitlab-ci.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0a7eef0a1d7..32c7b8e4a09 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -752,4 +752,9 @@ qemu-x86_64:
   variables:
     ROLE: qemu-x86_64
     TEST_PY_TEST_SPEC: "and not sleep"
+
+# Firefly-RK3399 board running the rk3399-generic build
+vbe:
+  variables:
+    ROLE: vbe
   <<: *lab_dfn
-- 
2.43.0

