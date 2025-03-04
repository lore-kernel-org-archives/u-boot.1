Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F7EC282D0
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C49581429;
	Tue,  4 Mar 2025 14:10:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fDQFMhlR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CE18817E6; Tue,  4 Mar 2025 14:10:02 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71FCF81426
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-8553e7d9459so148038639f.2
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741093798; x=1741698598; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8BXo26xR/4bNcij/9ueR0A5BFhzz72UuPU5ifwWIsM=;
 b=fDQFMhlR1G7sj3BB9byfQTvjizOMRNk6/aHbTw4BTtl85lKEjgIoLcMaCp871DSLpN
 nUNy2nztOZ+R6gtjhVJL9EhkYXVFTRHObhUI/IGC9qRJ3icbplNbu4BGGe75kpUuqtJT
 yoSvxJ6NyBer23eTr461FF2oZ8UmdBjV3NEEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741093798; x=1741698598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y8BXo26xR/4bNcij/9ueR0A5BFhzz72UuPU5ifwWIsM=;
 b=fQ1kWOmJpu7zW9IYtvRJaVQ5GF3uUng304Zi/KQVNzLh3eHG8J4N3sEMv2DdtsI7oE
 ZLtslHmtL2VBth0riJ8KywdrksDpszdwhjW6mlKBGuPKL75oJZPNekWp6WOtGasRQ5un
 n7bRZylop1rTem0eLZqOZdXMZs0I/Sh/d59OUnry5TAJgUETnM66YlEnFkxIpRN5fBTW
 vmOGSB/uhpZmlzKxVaBmvOIq4n3sCfPC0Awz4QC3AgnRlNHGPgE+rVAB8sV5f0EuqDHf
 8lEp2l9N7BGwg981W2oIcVg9TpYyw8uVmc9kBBNea7ZJpkPVfuZRnZXxHKBDDQ4UsQnE
 pTOg==
X-Gm-Message-State: AOJu0YyMNo21I6yuTvdmL6ofDaX5HAcDGWfgGgOsEbuqXHqjoqlQodTH
 D7jsH1TIp3vnSGf9V/6HunVgeVMqKBJVyFo5I/xPrDWX8Fv6o6MCvMlfyOFSYiAXoJGXGMtF/BU
 =
X-Gm-Gg: ASbGncvPZ2MePua8+By+974fcki1Vm/CHBCr+Vyz6SIiqEGEk/Al16i2y7xHLJ67CD9
 hIEiz2ePr1tDU+J+cxP2g5JhBHKm4R1JN8LzWohDEKoDZ0OfswIqXp5UTIvaR34UzB+POpJ/SC1
 BTJhbKPWif/UqiURT/JpDGYV8lANVp4FE+Ef82zLfRSoqaCWJVy5vEka7JdMOC6mn8bmB3z15jw
 Zb/QnzF7qazyAXv7Ly+6Pm1YDz+9LgW9TfujnsP/17hGZMx7z6QxMrkzdkw/iSMyqQm0z1vQS7X
 CaNWqWgP5Bv5gmVCIDCMgAL5WTqCVE9DWzs12mvuQzuKVcg+zDqAQ9NnwklnrSBYFhNnCtpCzC4
 E+PBPcw==
X-Google-Smtp-Source: AGHT+IGmlRdD21p0Esqnp4JhtwKxPFCnb8//QjKjXpDpsrJY/ZDZgdAauz40BxDxjFUvmTLWU1oKeQ==
X-Received: by 2002:a05:6602:3415:b0:855:683d:d45a with SMTP id
 ca18e2360f4ac-85881f6e75bmr1935492539f.9.1741093798587; 
 Tue, 04 Mar 2025 05:09:58 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-858753cd304sm287383839f.33.2025.03.04.05.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 05:09:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/7] binman: Drop GetRootSkipAtStart()
Date: Tue,  4 Mar 2025 06:09:39 -0700
Message-ID: <20250304130947.109799-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304130947.109799-1-sjg@chromium.org>
References: <20250304130947.109799-1-sjg@chromium.org>
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

 tools/binman/etype/section.py | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index 5c371397ffb..1d50bb47753 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -666,23 +666,6 @@ class Entry_section(Entry):
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

