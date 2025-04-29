Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5740C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBFAD82A46;
	Tue, 29 Apr 2025 15:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oeQoPZ3U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3B6782A8D; Tue, 29 Apr 2025 15:24:52 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B58382A7B
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6065796762fso1055674eaf.3
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933088; x=1746537888; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4Mftz8fQ7gewe/Tx1EyAnzbYyG5uC/K5Ko8+yOAKEo=;
 b=oeQoPZ3UH7W7qosFET05s6/QDTZveAPnY7QtKWs06dNh7Ck/3xLO8I6+l5LAZHWphL
 wXnmDbu5dcxSN5Rnrm14EPMoPFleaXcmT/a5wGLHUgmUKu0jdEjinUP5PM8C5bRIrF9K
 zq18hNUXAaUUl1M2u+d1WSr1opJ4i7jGTIkl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933088; x=1746537888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/4Mftz8fQ7gewe/Tx1EyAnzbYyG5uC/K5Ko8+yOAKEo=;
 b=J6fvyjbKt+hiQNEVff+4cj8O59qjN/YaEOgE9LhF3Gugu/DqTPmwCd3hcYlQ9AC6pT
 Nsi5uk3mGPRfcoCMu84HzA3FbI2R0oMKSUD3aMppi9JyH2q6yxifMgPpTCLMTHfnE9TD
 Xu/NxhPlB7I3LuM9XxyVt7WKbHVXrnT5wN+8jGi5otTeIQSg6a2aOjo1OEdVWTUcyF3H
 PSFNoBqVPMHFmFlPWVPa+JPI/h8BFibMvumrjsmFUcXYKv5+r/REoxE5zS6bGDMWTMrz
 e63nea8wEFln/JBTOG9og3t9nNFGo037i+aG0dxjHQ7qQgPTCefQbLj4bARP7JrADlLJ
 j1mg==
X-Gm-Message-State: AOJu0YxRY5m3yjeMqgWFFPaZjhNY16CK1XvAVSqNVaa4uFgmojS0aXWm
 cuCuFg06cg9/zNatxA5cZtqEiJ6v1WJVp+ispC9ytYyy9zTP/Yu3TWQGYPTPl8CxstVChkViESQ
 =
X-Gm-Gg: ASbGncuZZgHv4giYjnETnAvmrjpAHKi9Tbe4QIPet8N/Bw8k65ZWxKH3W5EQX0TAR3h
 EiKBkH3To5L3ktATB5r5tR+16Yy3FR1SfmvJJAhDA8e/pLig2mv9UaS1o6cq9Bi5+bebCEp9n0B
 Nf4lyVSIzh+rz0ntnzczX2gj3oaRQMpCp2JlYzXyH2Z/8VCXWck3A2SBOtDVpfMngEMr/LB5J9M
 tbIqo/BljK9i2hsbgSInsWA+vPntMhJ3t7CKU/4hxyOLv+AdCP9A39V7OIU6RCGawOWC5cTxlUB
 UwGVC2MJzttRywJVbiW6h9qAKxRUmTYDZ3Vk7MKEkbUCmICJsAQh0rS3+D21aLvDmbHXvoaqi4d
 i1w==
X-Google-Smtp-Source: AGHT+IF9PraVuTPGQVNxfLoRsl7lwcIUhGNHc0jDpd5ZEr1uUXaHxE5bEzjW8fxf39IAkm8ByuAgWw==
X-Received: by 2002:a4a:a50f:0:b0:607:6268:c0a5 with SMTP id
 006d021491bc7-6076268c18bmr425161eaf.0.1745933088088; 
 Tue, 29 Apr 2025 06:24:48 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:24:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 23/30] patman: Simplify test_find_new_responses()
Date: Tue, 29 Apr 2025 07:22:20 -0600
Message-ID: <20250429132239.251756-24-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132239.251756-1-sjg@chromium.org>
References: <20250429132239.251756-1-sjg@chromium.org>
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

This test uses the find_new_responses() function which combines
accessing patchwork and processing the results.

Since the test is aimed at testing processing, adjust it to call
process_reviews() instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 9c5e7d7dd51..3f7573a41a8 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -998,37 +998,33 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         self.commits = [commit1, commit2]
         self.patches = [patch1, patch2]
         count = 2
-        new_rtag_list = [None] * count
-        review_list = [None, None]
 
         # Check that the tags are picked up on the first patch
-        pwork = patchwork.Patchwork.for_testing(self._fake_patchwork2)
-        status.find_new_responses(new_rtag_list, review_list, 0, commit1,
-                                  patch1, pwork)
-        self.assertEqual(new_rtag_list[0], {'Reviewed-by': {self.joe}})
+        new_rtags, _ = status.process_reviews(patch1.content, patch1.comments,
+                                              commit1.rtags)
+        self.assertEqual(new_rtags, {'Reviewed-by': {self.joe}})
 
         # Now the second patch
-        status.find_new_responses(new_rtag_list, review_list, 1, commit2,
-                                  patch2, pwork)
-        self.assertEqual(new_rtag_list[1], {
+        new_rtags, _ = status.process_reviews(patch2.content, patch2.comments,
+                                              commit2.rtags)
+        self.assertEqual(new_rtags, {
             'Reviewed-by': {self.mary, self.fred},
             'Tested-by': {self.leb}})
 
         # Now add some tags to the commit, which means they should not appear as
         # 'new' tags when scanning comments
-        new_rtag_list = [None] * count
         commit1.rtags = {'Reviewed-by': {self.joe}}
-        status.find_new_responses(new_rtag_list, review_list, 0, commit1,
-                                  patch1, pwork)
-        self.assertEqual(new_rtag_list[0], {})
+        new_rtags, _ = status.process_reviews(patch1.content, patch1.comments,
+                                              commit1.rtags)
+        self.assertEqual(new_rtags, {})
 
         # For the second commit, add Ed and Fred, so only Mary should be left
         commit2.rtags = {
             'Tested-by': {self.leb},
             'Reviewed-by': {self.fred}}
-        status.find_new_responses(new_rtag_list, review_list, 1, commit2,
-                                  patch2, pwork)
-        self.assertEqual(new_rtag_list[1], {'Reviewed-by': {self.mary}})
+        new_rtags, _ = status.process_reviews(patch2.content, patch2.comments,
+                                              commit2.rtags)
+        self.assertEqual(new_rtags, {'Reviewed-by': {self.mary}})
 
         # Check that the output patches expectations:
         #   1 Subject 1
-- 
2.43.0

