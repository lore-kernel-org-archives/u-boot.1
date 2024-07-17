Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7F1C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 16:00:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E781788ABD;
	Wed, 17 Jul 2024 17:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L2UIKx0c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0133588AC0; Wed, 17 Jul 2024 17:57:32 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EBC588AAD
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4266f535e82so48156175e9.1
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231849; x=1721836649; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6viEB7RYB2IPbXMlPB2/pqdCRz6zfyAX/zk+IZ9VYvc=;
 b=L2UIKx0ck6NollkYn/ibuK58bwFDNWo5pNJBSIaSSjII7sPodsdNNLiLjDkrDAM23H
 gUuTkHnRB544O/I5rYNmFsrF3NOxGrOZFUrW6/7kPt1JvKVtHatvgqh+WXwur5kMO+6i
 Qn/gkuid4qGClCnd6U4gAPhR48PRlwjJmpfE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231849; x=1721836649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6viEB7RYB2IPbXMlPB2/pqdCRz6zfyAX/zk+IZ9VYvc=;
 b=kpz2eVVgwD7AGK8tX7wRuK21Z49nLNTZKiVmfRr6dRyJDG3Mou0jMhl5gkuuq48i3R
 bJJMgwM+ak10us+jv5RX8+np+NF8+5vymX9a8TeqcFdIfyBKtj0SN1r++b+ixO2ztjjf
 XQk1poumhQOzlOyhKE7ZHksYv3ujixebpO3rGKT3WcmvOt9NJRJd/jlaESZyO5z4X/dO
 VXl7TIZVQ5WPB7tG9QfwNI0BOU5RweXhTXNi+vulLN+xKZ8V567cN+NRsYF/elVf/lp9
 yF1xMbGZTsiUBsLjZojVU4lR1scgga3SnoxHy4yN55tUcTykSj9lKXowLLITOfStioFC
 PkIA==
X-Gm-Message-State: AOJu0YyBMdMIjQF8LAjx64TPZHautdIwjU+GQPmzAQUWsPCdPgnlt2Mm
 nHQEURRXrkZbx1GeMqfeYTFEJFT9+fJijdaHzmlHYiTdjTD1PHAAnGNydxFdC98d/M7GfiyoS4Y
 =
X-Google-Smtp-Source: AGHT+IFqTrdmpaWuRVciACvvWx1l+OWuv1CDd9N23g4zRd88wVKpOiae9QMqtffdJRuy2vQvW9f6Uw==
X-Received: by 2002:a05:600c:45d2:b0:426:6a84:2087 with SMTP id
 5b1f17b1804b1-427c2d07326mr18131765e9.34.1721231849438; 
 Wed, 17 Jul 2024 08:57:29 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 14/24] qconfig: Add a return value to do_scan_source()
Date: Wed, 17 Jul 2024 16:57:02 +0100
Message-Id: <20240717155712.2913651-15-sjg@chromium.org>
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

Return an exit code so we can use this function like do_tests().
Refactor the caller to handle this.

Reduce the size of main() by putting this code into its own function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 0bdabccba07..4365d8d75db 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1451,6 +1451,7 @@ def do_scan_source(path, do_update):
                   file=out)
             for item in sorted(proper_not_found):
                 print(item, file=out)
+    return 0
 
 
 def parse_args():
@@ -1546,10 +1547,8 @@ def main():
 
     if args.test:
         return do_tests()
-
     if args.scan_source:
-        do_scan_source(os.getcwd(), args.update)
-        return 0
+        return do_scan_source(os.getcwd(), args.update)
 
     if args.imply:
         imply_flags = 0
-- 
2.34.1

