Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCBBE7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 00:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14A1A80137;
	Fri, 13 Dec 2024 01:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cZlDBVUr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8115780192; Fri, 13 Dec 2024 01:59:13 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1270C800D7
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 01:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-844e1eb50e2so36527339f.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 16:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734051549; x=1734656349; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UWRG0Vu9JwPKlRt3ksh/HkbRktJbqc/tm12IqlecLfc=;
 b=cZlDBVUrkGPE3jbTeKDgKQa7OLyvnSa0ox0+ng4rJTWz40l/tuUVXKNQYJ/Om3ON8/
 zHJGxOu5MTP9WkFT/eenf2mF2prZcrrRSS73qKs67H4mGZzChlKNNL0quk7SRnCmNRfx
 +ugrl/hW6Y7zH2XB76xZu9xGhiUlCDtaGXoYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734051549; x=1734656349;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UWRG0Vu9JwPKlRt3ksh/HkbRktJbqc/tm12IqlecLfc=;
 b=SlnQqn0YP84lek0ULzvT9W5ds/asPyUK7B9EhirlOKPk86yoWDr0zj5kdbH/A9aC9H
 nUlxAaUDgHeqSdvBowDgWj6/gop1IPBhjQnCmIRLs/UCBBV1Qh8sraJmG2gliAhdc36F
 1HbkJHuwIjqMa1sDjUDDH9sivIVqohWWrHUtiOuVbTUyYMutz6hbc/bl60wtFI9nRiq1
 M1S4Yf7spQ+aYZw3/pCaRNAnw/lrs5kE117GYy498Cjl7GEmIfsGO2ntTuacCpvtJDk6
 GcI8wO/fku8PcLjIH3sXI4ahBrvHhsD548zX7hGPPA5/xOBnj04AsptE4l9ZvZDYRi7S
 BCLA==
X-Gm-Message-State: AOJu0YxPCoiZUw+OwXmJOD/oAIJEJjw3pmLQv42FNMCs7jmdSPt95gnm
 g7COYy58jxmumDOXU607olgWZi2zflpiKj6Jg/PkmhrHK5IJvPPSbM77bX9X3zkE3H3Zy8y04K4
 =
X-Gm-Gg: ASbGncvAwufyIYpy+v2g1OJelfnqJHF+R7AgScXr7hxXw45kt5FTLGQTNNBUeB4jGGs
 MfXgaZ9PT83mCJS+8Qe0id3NVs/8uMwOE0Z3KvrOfClpMfdvkvALvAPAnOO7a+KsLaqqMk26TZI
 aRmAWY3Jx4TQ1euI62kt8ddzYAuEKc2Re7Uxe+msOat+JsRwheOlugwhm+YOphDcGHIP/XXER5R
 1rVqx5nXNHfGWWVJLdYuyhV7gDicm8LKsu2KPFGwnfUfqM6D0qVsIO/w2Jfk0Kab5do6pdXqRhn
 rl+oMso3dzcYsE0n7Q==
X-Google-Smtp-Source: AGHT+IFET9FarTSLtR2E3AZHvWV++TBkN/5aoHRYJGyeHwMx3YtiGRWCAIQfQ4agU6vMuyI5sMMH3g==
X-Received: by 2002:a05:6602:6b8b:b0:83e:5860:5189 with SMTP id
 ca18e2360f4ac-844e88a1dd9mr71500339f.10.1734051548733; 
 Thu, 12 Dec 2024 16:59:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2cd7e472fsm1764502173.1.2024.12.12.16.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 16:59:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] gitlab: Add an rpi to the sjg lab
Date: Thu, 12 Dec 2024 17:59:03 -0700
Message-Id: <20241213005903.73919-1-sjg@chromium.org>
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

I have an original rpi installed now, loaded with OS Lite (32-bit)
Add an entry for it so that it can be used for testing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f379c11a1ba..ffcf8532944 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -691,3 +691,8 @@ nyan-big:
   variables:
     ROLE: nyan-big
   <<: *lab_dfn
+
+rpi:
+  variables:
+    ROLE: rpi
+  <<: *lab_dfn
-- 
2.34.1

