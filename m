Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53961C3ABAC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 489B582B26;
	Sun,  4 May 2025 15:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZFHNIS4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B48FD82B19; Sun,  4 May 2025 15:24:47 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD72082AF4
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac29fd22163so599096666b.3
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365084; x=1746969884; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6y3z8uW6k6n3Rbtq2uDOOOKVANZEDtQQ+rn8UaTPaco=;
 b=ZFHNIS4iRQWGrhbmpHoVUNWePNAsRufQrLJXJA7MsDn7T9PUYwQ+AN+OyHR1N2JmFJ
 UVX/z56wty2rJozJX6CQCpHJhlsymtgXWfFnmFlfpZFoaIyZeGu8ORNzan2A33WwP+zH
 aAVrxO6tSM0QozROGP4CSKYyh/4a2W4o6/h+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365084; x=1746969884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6y3z8uW6k6n3Rbtq2uDOOOKVANZEDtQQ+rn8UaTPaco=;
 b=uOTGNPdjaICnsANQbjnoEuNoKAvbAsoazuS2sPEu47uj428i+QgkdrG5ctWFaKXdwa
 q8yz3qXYvs2vSXq3t/qSnGbmHMwLRpy+2JtfJVBnM7RhTnArQk1V5rtfm7wkLVk41lQq
 TVoa4Z+UYGrpfq3SuArmLlb9kwkBHXy0LUHKTZxVvY8zexqNRZhBrJNdS7XF2FBMSTaA
 xGvxduPIPdmzHeSRvXFSdOuv+Pir2SHXsDW+AoUzKCfQHCZy7+lF1g0mDVC+Y+wEsqjU
 s1D7cTqzPdvvChKGunXlCv9oif1k6matkiP3Z/8/wXqc0pDCk8MdXOZnrjsI3F2ScHft
 bt8w==
X-Gm-Message-State: AOJu0Yw43jnvtUXYRoOTVg1QmgedtcMMec673I5mg/04wpXG+0cMNZ5t
 Eao4vBA+XMGZnXb7MsagIMQZtatlEYaoigvtOuB5eM9+WEHuzJV/Rf8oSYCerOacSm9DKCCdz82
 XtwtmqKU=
X-Gm-Gg: ASbGncs7avuKE3Qrws1y/ZjWn5Ndi0bFPRS12ApyXsnOZh2Msc8PHDFFFKOHSaBMXUd
 MD1sgQFkLNZFm4VxWfE+9TosNZHsrXb/SUgTVOZQr5UNN13dFqTUWV+c4kacRtvNcSg89ngu915
 vFgWjaPTKS7dwmL5bIAF0s2M7HGq+okfNeil1xkvAqStC1osGdATTkOztPTudVn0rCGQKeUVwA6
 Eow7J4LDrP2EkeyQCDqoWUJn7AvPE8Y/PJzqPzUvWP7Deuu+xEFTdv+74G1YSZCUudj21fwagCH
 LXXA7aClSkP8iDQxNDJUJVOC6ntaBZAP1F835T9b2Sw09vA=
X-Google-Smtp-Source: AGHT+IE2+XvWB8oR8RY9XgYv7OlSSh99tGtFoK3wwC6Tu3LN6iibOPhq17PXum9EgBP1iLDgWhH3ig==
X-Received: by 2002:a17:907:c285:b0:acb:9769:364c with SMTP id
 a640c23a62f3a-ad1a4958855mr252360666b.21.1746365083709; 
 Sun, 04 May 2025 06:24:43 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 23/30] patman: Simplify test_find_new_responses()
Date: Sun,  4 May 2025 15:23:39 +0200
Message-ID: <20250504132356.2317305-24-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504132356.2317305-1-sjg@chromium.org>
References: <20250504132356.2317305-1-sjg@chromium.org>
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

(no changes since v1)

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

