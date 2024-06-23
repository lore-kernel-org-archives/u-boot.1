Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60322C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B8C188619;
	Sun, 23 Jun 2024 19:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nshkImtt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5538885F1; Sun, 23 Jun 2024 19:56:30 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B9B87DC7
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:56:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-375daa47685so16185935ab.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165387; x=1719770187; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78n6NaostwtHDALqaZ8jnFOmgsLmPHglijamkfXUTWE=;
 b=nshkImttbMeQIkY9yXJraKVrYI19LEAnuoTGTLqoVimK38kIU3lwuGkr91tSQji3tZ
 YByHJNJ04xLH2DkbzbhhV1QBiUOCGgWCDuP3I1QNmYjh1p9oRaNAEy0oMBfspLTVgQMQ
 f3gLttmnHFhyf0hEicSwvmdRkbTal2hPFCttI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165387; x=1719770187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=78n6NaostwtHDALqaZ8jnFOmgsLmPHglijamkfXUTWE=;
 b=qzRF6p7oZ56jCSefCEvi5EIcgA9YmCzP8Lo65HW8305XAtrfZFE/2MTsyOV+MZ99Vs
 rBe+qT2dKccJ0h5c9bbWugXffnj0bReuXPEcPHSB14ij5B8g/U1G3XPnjcz87uJopdUo
 9kem5tgkj9H7+YzRn7gBzaaLKcyNkzojBImvUZZE3kijmdaSyFO5+aRd0h7saRKb4N0o
 5gZc46QPTILJlh+Q2OdSzMx6IsX9cgf/i8hqS5KcpxWjBm0R9bCNlm0Y8s8b0Pruccck
 IffX4smsLrXgV4xOP7XppRWto7kvMvBtmkzWv+lSZHwt9JV13AkZxUD1WDDgI0Q0A2Wj
 XV1Q==
X-Gm-Message-State: AOJu0YzDt/OjIiY8dl5ck+6eGItYkfVySoIIr5AesIUNnelBGkhiL1yl
 TiVDoQ1+ueD2T9Mnge719U2S+dS7D5puU/1GcWVGFvDR9Gm28AJtHG7at4FpbhupmXpcJjbfL+7
 hbg==
X-Google-Smtp-Source: AGHT+IFbRbqaBrY7d4/KtZu0P0lzYHLGSRadSQz6yWVCTaGeoEW5JB7BZVzyBe4cW4XcHY+22agvdg==
X-Received: by 2002:a05:6e02:156a:b0:375:a6a4:5dde with SMTP id
 e9e14a558f8ab-3763f6c7560mr27235525ab.30.1719165387225; 
 Sun, 23 Jun 2024 10:56:27 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3762f2fb1bbsm13551465ab.12.2024.06.23.10.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:56:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexey Brodkin <abrodkin@synopsys.com>
Subject: [PATCH v3 3/6] buildman: Fix a few typos in toolchain code
Date: Sun, 23 Jun 2024 11:56:19 -0600
Message-Id: <20240623175622.1468600-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175622.1468600-1-sjg@chromium.org>
References: <20240623175622.1468600-1-sjg@chromium.org>
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

Fix 'Thie' and capitalise 'unicode'.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v2)

Changes in v2:
- Add new patch to fix a few typos in toolchain code

 tools/buildman/toolchain.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
index 79c7c11a110..324ad0e0821 100644
--- a/tools/buildman/toolchain.py
+++ b/tools/buildman/toolchain.py
@@ -175,9 +175,9 @@ class Toolchain:
     def MakeEnvironment(self, full_path):
         """Returns an environment for using the toolchain.
 
-        Thie takes the current environment and adds CROSS_COMPILE so that
+        This takes the current environment and adds CROSS_COMPILE so that
         the tool chain will operate correctly. This also disables localized
-        output and possibly unicode encoded output of all build tools by
+        output and possibly Unicode encoded output of all build tools by
         adding LC_ALL=C.
 
         Note that os.environb is used to obtain the environment, since in some
-- 
2.34.1

