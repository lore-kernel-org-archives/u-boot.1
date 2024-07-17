Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8066C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 15:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6015288A77;
	Wed, 17 Jul 2024 17:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ISmbxQjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 330B088A81; Wed, 17 Jul 2024 17:57:24 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 544C588777
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so56585095e9.2
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231841; x=1721836641; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mtl3BCDafyY/nWfMOROKbY/QAzFbrSMxIz+Xu7lU1s=;
 b=ISmbxQjN9z7uMjqxWCpZndyoPMtKRe1bP9Uzte6lv5To3IKLDhA/jwXYMtENdNrvWp
 JEWYte6afikBszW7RZ0e5y4RHzhgwPU47KSGqwPLNnzAB811NLwYrJyORfAsjYcCwC09
 YRDhOQJskxqF/Kc9sOzJ0Cxawy3NSHR5Bszeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231841; x=1721836641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8mtl3BCDafyY/nWfMOROKbY/QAzFbrSMxIz+Xu7lU1s=;
 b=QcYmq+R8PoqhepFRZwZF9jYg/yvH7TbR8QvjFdolG4m8k71LjUZ/kFgvkhz1rfKpPZ
 GDLGv+DOO+iuJM39rGaKnxeWpdl9zc0LDZq1Osnpz1UXS9EXgVqmrEkhRtXV403eH4Mn
 /IMoZy6csXvj3S/Y808++rBvHcNuKAPWutBv4tg0DVtcPoxure97V7OI5llCSYfWbZVl
 ePZMS8eyiPGQLMzKJTzD8FR0tbGwXtqC2PSHGUVm1dU/WGuHbK2ERh5YhAwKUbL46PvK
 UvsfpTJU0AOCDEsiJlNGfdHqH+dXi0daqPCK8VqfZ6K3S8hn8tjA1Ug5t4wP1SXmm73F
 5MhA==
X-Gm-Message-State: AOJu0Ywu66OayiA3S/V3c37WlqeVHkJ1hUpW7kW6fx4P0ppulM/wdBMV
 vgGqohUEFWDbfQPIqlZEVMZHvFUgR1NsG7+i+1N2yT5cBArh+h5b+4DFxjHvtx0gP7INApSVktc
 =
X-Google-Smtp-Source: AGHT+IFOZkKXd1OE+1FoNlcSy27NktTtF/3RUYlpeUdKAKkETK881ShK3nNqqBVChk5NAPXQWVWBCA==
X-Received: by 2002:a5d:5009:0:b0:368:319c:9a70 with SMTP id
 ffacd0b85a97d-368319c9b62mr1575351f8f.5.1721231841682; 
 Wed, 17 Jul 2024 08:57:21 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 05/24] qconfig: Correct format string in do_imply_config()
Date: Wed, 17 Jul 2024 16:56:53 +0100
Message-Id: <20240717155712.2913651-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717155712.2913651-1-sjg@chromium.org>
References: <20240717155712.2913651-1-sjg@chromium.org>
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

One of the strings was converted incorrectly. Fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 1bd43060b3e ("moveconfig: Use f strings where possible")
---

 tools/qconfig.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 4f1ad2703c7..8a2384d895b 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1038,8 +1038,8 @@ def do_imply_config(config_list, add_imply, imply_flags, skip_added,
                             add_list[fname].append(linenum)
 
             if show and kconfig_info != 'skip':
-                print(f'{num_common:5d} : '
-                      f'{iconfig.ljust(30):-30s}{kconfig_info:-25s} {missing_str}')
+                print(f'{num_common:5} : '
+                      f'{iconfig.ljust(30)}{kconfig_info.ljust(25)} {missing_str}')
 
         # Having collected a list of things to add, now we add them. We process
         # each file from the largest line number to the smallest so that
-- 
2.34.1

