Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3F0C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 02:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFA2088698;
	Fri, 19 Apr 2024 04:36:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eOvT059f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A7D886A7; Fri, 19 Apr 2024 04:36:42 +0200 (CEST)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC429885BD
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 04:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4dceafca40bso402083e0c.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713494198; x=1714098998; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6EKQC9aqRDjEPAvaX2hekp62S+g22vQmQRfbZd12qZg=;
 b=eOvT059fYzOQraZKU99DaVXEHMY9l2QXpF7WdhR/VZHSLsiCM1Slb7i5s48GhTv0nx
 AL3AmqATZmuMIkRiwo/oexC7Cst4Z03bkGEZVXYuS3drQB6Z44fosD5Q4GqCiW6yYG0l
 oXAMW2iiqPT1SIPcSODdhOaDrop1asDDmrN6jBYriKFuBwmsHB3niRro8AVtiy33STHL
 vqeUQr/u6PaHuG4iCFQT/rr8ajF1NVoMmBgrLyZI4fuBcoOZSBBOTItD87cIos+VEgCu
 Sfc9p/7eUo6+OYZ0wKw+3TuHyu1PdSZWznGpgTwHp1+KX/Yy+H8P47DAAK3jr4JC3TVa
 W2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713494198; x=1714098998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6EKQC9aqRDjEPAvaX2hekp62S+g22vQmQRfbZd12qZg=;
 b=OMTXQF3KYhHJ52fToe2f54j4fgp/uIqx6vebdP3angWhfd2/SECYLx1wuDKawPEW0x
 xPyZQ2hd3XAnp+QNQsL0L5aWG7Y8Ne7UZeY14bzmsjz+2jFj7MgA7ZLyEtLDZSr8hRA+
 4RR3vas4a47zz7x4t8xrnlUkOp/eDR7n70UbzHz+3gN+RElaH+4xnrBbCLuuhoPO6CUF
 WsuprMQ/rvMVelzpO3HyA0aWqo9h+nvm+wdLXWbVC/vjKohjnG7SeR5qgnoWwUweueOC
 fOdtV/QbkjQWn6KEI8Y8ZJUr+k6oCWOByil50COppGu62ItGUQam3F9uAOd24nSstuuY
 3swA==
X-Gm-Message-State: AOJu0Yx+yitTvg0Ia+RP7yQ1JMIdWxwwbPHBVNLdxHY+VKBvwj07uPDY
 RIZUoy+oyDxCV2+TjeCfq9f5Z2Wpl9D/BH/ydyolI9kTKFaCDsEyrqQ6xw==
X-Google-Smtp-Source: AGHT+IG8F73HF+ZL4lL0Om15XXz/IrSfQnltcJgPuGJWrpl3JkwJ3+gNCYCKX0ROvcCNEBwbKg2e6w==
X-Received: by 2002:a05:6122:1d0a:b0:4d3:3446:6bc9 with SMTP id
 gc10-20020a0561221d0a00b004d334466bc9mr750937vkb.14.1713494198097; 
 Thu, 18 Apr 2024 19:36:38 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 d3-20020a05620a166300b0078ecc54b1b9sm1201973qko.71.2024.04.18.19.36.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 19:36:37 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>, Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 3/3] patman: Add a tag for when a patch gets added to a series
Date: Thu, 18 Apr 2024 22:36:32 -0400
Message-Id: <20240419023632.29078-4-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240419023632.29078-1-seanga2@gmail.com>
References: <20240419023632.29078-1-seanga2@gmail.com>
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

When a patch is added to a series after the initial version, there are no
changes to note except that it is new. This is typically done to suppress
the "(no changes in vN)" message. It's also nice to add a change to the
cover letter so reviewers know there is an additional patch. Add a tag to
automate this process a bit.

There are two nits with the current approach:

- It favors '-' as a bullet point, but some people may prefer '*' (or
  something else)
- Tags (e.g. 'patman: ' in 'patman: foo bar') are not stripped. They are
  probably just noise in most series, but they may be useful for treewide
  series to distinguish 'gpio: frobnicate' from 'reset: frobnicate', so
  I've left them in.

Suggestions for the above appreciated.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 tools/patman/func_test.py                           |  2 ++
 tools/patman/patchstream.py                         |  5 +++++
 tools/patman/patman.rst                             | 13 +++++++++++++
 ...t-cast-for-sandbox-in-fdtdec_setup_mem_siz.patch |  1 +
 tools/patman/test/test01.txt                        |  1 +
 5 files changed, 22 insertions(+)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 3b4c9448882..af6c025a441 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -293,6 +293,7 @@ Changes in v4:
   change
 - Some changes
 - Some notes for the cover letter
+- fdt: Correct cast for sandbox in fdtdec_setup_mem_size_base()
 
 Simon Glass (2):
   pci: Correct cast for sandbox
@@ -342,6 +343,7 @@ Changes in v4:
 - Multi
   line
   change
+- New
 - Some changes
 
 Changes in v2:
diff --git a/tools/patman/patchstream.py b/tools/patman/patchstream.py
index ec1ca874fb2..a09ae9c7371 100644
--- a/tools/patman/patchstream.py
+++ b/tools/patman/patchstream.py
@@ -477,6 +477,11 @@ class PatchStream:
                 self.change_version = self._parse_version(value, line)
             elif name == 'cc':
                 self.commit.add_cc(value.split(','))
+            elif name == 'added-in':
+                version = self._parse_version(value, line)
+                self.commit.add_change(version, '- New')
+                self.series.AddChange(version, None, '- %s' %
+                                      self.commit.subject)
             else:
                 self._add_warn('Line %d: Ignoring Commit-%s' %
                                (self.linenum, name))
diff --git a/tools/patman/patman.rst b/tools/patman/patman.rst
index 9971fa8c0fd..63b95a6b161 100644
--- a/tools/patman/patman.rst
+++ b/tools/patman/patman.rst
@@ -350,6 +350,19 @@ Cover-changes: n
         - This line will only appear in the cover letter
         <blank line>
 
+Commit-added-in: n
+    Add a change noting the version this commit was added in. This is
+    equivalent to::
+
+        Commit-changes: n
+        - New
+
+        Cover-changes: n
+        - <commit subject>
+
+    It is a convenient shorthand for suppressing the '(no changes in vN)'
+    message.
+
 Patch-cc / Commit-cc: Their Name <email>
     This copies a single patch to another email address. Note that the
     Cc: used by git send-email is ignored by patman, but will be
diff --git a/tools/patman/test/0002-fdt-Correct-cast-for-sandbox-in-fdtdec_setup_mem_siz.patch b/tools/patman/test/0002-fdt-Correct-cast-for-sandbox-in-fdtdec_setup_mem_siz.patch
index 55a0d6756aa..48ea1793b47 100644
--- a/tools/patman/test/0002-fdt-Correct-cast-for-sandbox-in-fdtdec_setup_mem_siz.patch
+++ b/tools/patman/test/0002-fdt-Correct-cast-for-sandbox-in-fdtdec_setup_mem_siz.patch
@@ -23,6 +23,7 @@ Series-version: 3
 Patch-cc: fred
 Commit-cc: joe
 Series-process-log: sort, uniq
+Commit-added-in: 4
 Series-changes: 4
 - Some changes
 - Multi
diff --git a/tools/patman/test/test01.txt b/tools/patman/test/test01.txt
index 271d9bf043f..b2d73c5972c 100644
--- a/tools/patman/test/test01.txt
+++ b/tools/patman/test/test01.txt
@@ -51,6 +51,7 @@ Date:   Sat Apr 15 15:39:08 2017 -0600
     Patch-cc: fred
     Commit-cc: joe
     Series-process-log: sort, uniq
+    Commit-added-in: 4
     Series-changes: 4
     - Some changes
     - Multi
-- 
2.37.1

