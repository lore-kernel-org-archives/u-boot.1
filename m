Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D12C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 15:59:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D90988AAD;
	Wed, 17 Jul 2024 17:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O+69CxR7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0851E88A69; Wed, 17 Jul 2024 17:57:29 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96DFA88A91
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so6087805e9.1
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231846; x=1721836646; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KPSLonInHnTJHnjBxAP1s8+4jGBtHhxsanjQ7+JYB4k=;
 b=O+69CxR7ylWGlBlmqKF/0k5au4b1E9Puri4IJiDsUaWh+9GuWsxsrGHHh4+Xn0q/Tu
 sUjSzIhrh/4dX6is3szc3Lz0/hGZg5iD+/rvqNSDIBjlixAr088NEQxVSsZAzPzSrPlw
 B0yQIC5mM2YTrxgHPT45XKjOJBNs6mrHDMiM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231846; x=1721836646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KPSLonInHnTJHnjBxAP1s8+4jGBtHhxsanjQ7+JYB4k=;
 b=BtRSwR20EtYAUHUtlE84ZfLJSvV+XkpJ+j1am3r9Mcvl7+yUOkZhv6II1oB18xzvqp
 DZhYJ4pEVZBSAAleoRolUCs3duKcPXrlAXIPvwuOQLPcp5Oz/HmsTSTyZpQDh5CvSO5I
 kqALcDE/Ax1lTN/eordzXVZDKa1iQWoKoNjGmGTw6FJrwW79ydiRH7oLGQLDlQGY3zra
 ITSbxN/kovBTbg4J+/XcVeVVCEhn0kZq0W2lQwU5uR/XFrHP3bjwVSFuIbLXQhsRvjvy
 eIEgRvYFIgJYhZx1hJiR7Oz9K4qwtXpXGoKZHsKK5aUOX6KMZCdP10AyKzYRsBwyYWaY
 ZC9A==
X-Gm-Message-State: AOJu0YzF6nSHdfurFYRR0kGJiGWPlr7myogfhegKEq8/+PdGHTtMTnVv
 UF8TEgwN/SaCNU5Jo6G8n48LhwhziFXL4PHy8W/OpG9VOEHB97TXHnbCrEZrvrQQflxhOMvGWDs
 =
X-Google-Smtp-Source: AGHT+IHX+ltSJ4RoT3AIYwre49xOR/oVO2KxVNBlPTOnIIHSI+5E04QvUlawIMq63pUZ8bBYta9XNQ==
X-Received: by 2002:a05:600c:4ed4:b0:426:5b17:8458 with SMTP id
 5b1f17b1804b1-427c837d05cmr626575e9.12.1721231845810; 
 Wed, 17 Jul 2024 08:57:25 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 10/24] qconfig: Move getting the colour to where it is needed
Date: Wed, 17 Jul 2024 16:56:58 +0100
Message-Id: <20240717155712.2913651-11-sjg@chromium.org>
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

Move this assignment down to just above where it is needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 9052aedf57d..5d6e468d1d8 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1535,9 +1535,6 @@ def main():
             return 1
         unittest.main()
 
-    col = terminal.Color(terminal.COLOR_NEVER if args.nocolour
-                         else terminal.COLOR_IF_TERMINAL)
-
     if args.scan_source:
         do_scan_source(os.getcwd(), args.update)
         return 0
@@ -1584,6 +1581,9 @@ def main():
     toolchains = toolchain.Toolchains()
     toolchains.GetSettings()
     toolchains.Scan(verbose=False)
+
+    col = terminal.Color(terminal.COLOR_NEVER if args.nocolour
+                         else terminal.COLOR_IF_TERMINAL)
     progress = move_config(toolchains, args, db_queue, col)
     db_queue.join()
 
-- 
2.34.1

