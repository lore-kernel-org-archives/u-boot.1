Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E551C44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 15:19:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96EEB83015;
	Wed, 21 Jan 2026 16:19:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mw4eL3q0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43F8E8341A; Wed, 21 Jan 2026 16:19:35 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA78680077
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 16:19:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-45c7c841904so3833580b6e.3
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 07:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769008771; x=1769613571; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iHV1fHhP+GLZkvUTpcHywH97pKqoMPcUeZF4Hpg265I=;
 b=mw4eL3q0ym3fmqa0LCtk6paS6f4WEriUW3xRfZoe+rHORzngh0HHCPV8oco+MNp5LI
 FMuraSlJu/YSqHKPeeoDNy6hgk/Qo7QFOHLtjxLXhvnHKTRcfe4oonYK5TcvZE9K/g/l
 oDbvE45BpWgMMyLEBcq/2MMY1VqXmFRbfhtlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769008771; x=1769613571;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iHV1fHhP+GLZkvUTpcHywH97pKqoMPcUeZF4Hpg265I=;
 b=bRi5ENbhijYsHl89Y+W3tfYo1ndevs+jY0YOytbSY6tn3W63t/BtwH3M3P623X/V3+
 zBHGJJv1r6Vn8U2WWlSKqYSuvf173yIlEWnbzezKX2lBlnmE4ye65g7OGLR87hay5XFo
 xHuxM2UNHuUMnqNU8HHFEmktrjNKVsnckL4ceUVz1VFpO7krd1ppKeE8+udSSwMBV7i2
 2xxPyhLhBghnIjniyTYlfv8lBBk0RTbNTl8pYYCS6dk2yufvoj7Va9tE+Rn88uQljB8F
 7h5sMynrBJuh5ZWPdDx4hjl3uOJREEH10iX9bRA/L19odynLdB+JO/OTfTBx/qHlzaJV
 WzlQ==
X-Gm-Message-State: AOJu0Ywpah9wf0srLrW8BED8xqPoxolRXZRKWp+zHMi+LLX9isS4WIef
 1OeptaZwClDaySnomDOHw6GqjrNScg0xjZVZmuCFZn8tpwvBerL3XaNXW5s7DoNWhG/4eHVLpOl
 cX9lMIiU=
X-Gm-Gg: AZuq6aLR2NuhjTHyqQHwWMtEJA3mS5B4OD6vTiXe83JkauB+crZD2EbeQ5yo4vGy77W
 JtaWnBfkRc1s6Vu+OeCPyMLt4OlkipxRh+7XE4bxDw0xMAd2wo6u2OGaV9laq2NMqQ+eARQXF3T
 io4DCNJoNwUNb5QjjE3WVVWQoYA7zPxQkzs7wamgBbFMozEfhXhRn8R5OCw6gDkukNCLi4c2MmA
 n6yKfWxSPYVS9g/9KR2DpLjnZP3VXHuFIMpmFRqoAAmpoExKrDHL3ipLSOIXiBlGwd5OTWFRTK7
 ehUOyyd45dINWQNzh/vw3bIG7BQi1p3nFtJ6zQW9qQ7RO5vdD8YHTke1a+geVTV4EHbcBPDlrRS
 qBWcIW1JSMNfeVB9J0hNLy1KJOL9e0ahvKYNAAbs/zMZ+Yws2wVOblUqwzJdZxjWcIOkA51sYnM
 rY9f2HUfL8tbqY/93K6bK75P+Zk3H1Q5kHIrgoXw4EzJ9D8l51wTFHRfbF8kKkXaFWerdVi0Lec
 BWbUw9cMuMPDmkpMwiaBRuPSZDcnB/wAu26FVfRgg==
X-Received: by 2002:a05:6808:1813:b0:450:f45e:f4a9 with SMTP id
 5614622812f47-45c9d73cd1dmr7674254b6e.19.1769008771460; 
 Wed, 21 Jan 2026 07:19:31 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9dbcdcd3sm8601191b6e.0.2026.01.21.07.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 07:19:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH] .b4-config: Add some patchwork related settings
Date: Wed, 21 Jan 2026 09:19:30 -0600
Message-ID: <20260121151930.566075-1-trini@konsulko.com>
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

To make it easier for custodians to use b4 with patchwork, add some
defaults to the in-tree .b4-config. The API key will still have to be
configured.

Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .b4-config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.b4-config b/.b4-config
index 1f9ada793e65..dd9041c435c9 100644
--- a/.b4-config
+++ b/.b4-config
@@ -4,3 +4,8 @@
 [b4]
     send-auto-to-cmd = scripts/get_maintainer.pl --nogit --nogit-fallback --nogit-chief-penguins --norolestats --nom
     send-auto-cc-cmd = scripts/get_maintainer.pl --nogit-fallback --nogit-chief-penguins --norolestats --nol
+    # Patchwork integration. You still need to set pw-key to your API key
+    pw-url = https://patchwork.ozlabs.org/
+    pw-project = uboot
+    pw-review-state = under-review
+    pw-accept-state = accepted
-- 
2.43.0

