Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1754C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 12:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC88983C60;
	Thu, 10 Apr 2025 14:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RhUroYlI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40B6383C39; Thu, 10 Apr 2025 14:43:51 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FAA683C30
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 14:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3d442a77a03so2386045ab.1
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 05:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744289027; x=1744893827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+tWC8CvBKNGGqO9SyD2k3Pa0SwUoHTPj1cUXWGradY=;
 b=RhUroYlIB//LE1HDAAiqHEI15J3zxeLuhZ+9w0QClxj9PJgTU1DsTRatPEc634yL/N
 oBCraKZw99z6hSXAzaVY1KhbvzaxOU7lXBOut502PDuMJ06mMjVR6DqzccJFRPZ7lOX/
 8e4yl/dA/RK3I81CbJ+YaUYcp1EryZX7JtR0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744289027; x=1744893827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s+tWC8CvBKNGGqO9SyD2k3Pa0SwUoHTPj1cUXWGradY=;
 b=ehyv4Id+2EOPD4fjM01Lc/+5qhPKv8P9qMjxceRKnks49BRDC+gHebv2D2/4MLQBqm
 qYSbdkIZdbwSHfgSPD5OXaDvBm3tR6lcGaG3uS0Hac0n4rze7ZUPKf+dNCnH6X7NBm7t
 +lE0KhiO8mLu/1yUqdHHOx+MC7T++iiAdpRALlSxlVw3PPUqFyHGl1ztu1Fi7b/uia8B
 L6E6FnA5sJr4I4Woa2kFybe9FUDMzZP5HB/HYZ4UAwWN82H3c3/wHzEdLX4GcdW8tdSB
 /LLeog6iGBl1g3osU0ZJTWPLMvcscOXKSK07T5OasnRuPHw9equ1rjvQnMEf4fu/0gjb
 aucQ==
X-Gm-Message-State: AOJu0YzlKTGuDKsr7tPFIOCH+s931IMsiLP591/t9p8Oqh5T6FIcEi0Z
 8wZ1RnOT4ScW+NRK3hbS7MuALd6iGJK+stSxyLkXEtROS+wT/4salzWYqJz9C4XuMLoe4GptptY
 =
X-Gm-Gg: ASbGncsJ+MLAM7lbx66c7qDcdF1B+0SOCm9ROrFRkjwffQmllrkG1+mf/GbS5jiaT2r
 9NTSpXXdFBnJuQS/tDELAmPd10kHW/Tsc2zQ6DUIUCedELGpx6Rp39gsy7UthsLpXYeP+upRMqt
 GO9Jb/G0u38h6dPwJe7U9YN1cUhPcFqrJcLN/5FqcHGRkrQUwj51jXa4IkRRlXCkstTIMS30ck/
 e98RNtu035yMOooeWKWyUwnK7uk6Yky1yx44RdTzOD0LDursRbNNcVRUOVjOZs/ty7qaJX7mkQm
 2sAYbipRzYlljxsYIOJtiVCKdVPmVrRYa/U67C9u/zIXiyI4Y5/Rv9NbH7tADFbge1e9b+QIyBh
 9DQ==
X-Google-Smtp-Source: AGHT+IHwOA1rw29rb/sa6q8JNfJ4HfJuofV/yV+tUi4IfzTLOIJItrjzMbpOZ0SEQ1Nuu8IVddLu3g==
X-Received: by 2002:a05:6e02:3e8e:b0:3d3:f520:b7e0 with SMTP id
 e9e14a558f8ab-3d7e5f69f76mr16120075ab.6.1744289027172; 
 Thu, 10 Apr 2025 05:43:47 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f505d170e7sm729471173.32.2025.04.10.05.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 05:43:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/8] binman: Drop GetRootSkipAtStart()
Date: Thu, 10 Apr 2025 06:43:00 -0600
Message-ID: <20250410124333.843527-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410124333.843527-1-sjg@chromium.org>
References: <20250410124333.843527-1-sjg@chromium.org>
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

This method is not called anymore, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/etype/section.py | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index 5e11cf58d28..4c4c8c417f8 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -662,23 +662,6 @@ class Entry_section(Entry):
         else:
             raise ValueError("%s: No such property '%s'" % (msg, prop_name))
 
-    def GetRootSkipAtStart(self):
-        """Get the skip-at-start value for the top-level section
-
-        This is used to find out the starting offset for root section that
-        contains this section. If this is a top-level section then it returns
-        the skip-at-start offset for this section.
-
-        This is used to get the absolute position of section within the image.
-
-        Returns:
-            Integer skip-at-start value for the root section containing this
-                section
-        """
-        if self.section:
-            return self.section.GetRootSkipAtStart()
-        return self._skip_at_start
-
     def GetStartOffset(self):
         """Get the start offset for this section
 
-- 
2.43.0

