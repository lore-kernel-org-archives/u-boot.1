Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44CFC3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 300D182A1C;
	Sat, 10 May 2025 13:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PPiHY7Wp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B1D3828BC; Sat, 10 May 2025 13:06:03 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 600878294C
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ace94273f0dso563916966b.3
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875160; x=1747479960; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgy72n0BJXmHZ3gkhsm31Ze6nMm3+RFvk82N+sgts8Q=;
 b=PPiHY7WpGOPtm0f6uknvnR+V/2fQHOwGc+pxk0HZBCr1epgxRiEO3gFgzxKMjmbZHu
 0z1S93bZSu8ym60TrQOayLjiqjYUqhocHI4mtQYFXmMF9NqnW+ouQh+U1/C884JlnPpW
 IhVFhTwb063843th2XbQfc6w/KcKLb3Vc9StM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875160; x=1747479960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgy72n0BJXmHZ3gkhsm31Ze6nMm3+RFvk82N+sgts8Q=;
 b=w3/ck4AjCa6LeZbEDUxo6Q5eCOHIMoGS9rU7me0YdwthCDMqThbBOrQl3r685C413f
 lsAEGMSBvSKj9PrQ9rF0aYfQcuUGDW2tULULjDN0ylUVaXPATV4OElPCEA6INYE3Vs56
 ZO72d+IFpIbPeogu1PPzDAhyoCJfiErGDzKkcPFU8t5RgHtG99hCCTkg9kQN3oLuKoYg
 7vvfbvWSU9x/ZzUzIHiuKJtRrKQtxJtoPQKLe+90GhV2VoYeSU2X5+uuQ4xxpGwGXV1i
 ZizXuJLBVjrIJHhm8jWUEmpMOl5GTmjNLKUkgujQY1e/xqg1RqKhzduUmgZ7Yw/nC/j/
 C+uQ==
X-Gm-Message-State: AOJu0YzQyxwxrp+UWJl9YXfUDPJbIN7Zw4wn7pXS65sXcAnUIZf1CPUg
 8sI/N7RG3u89EYySLtjI+LYubvdy6Un3N/M/Qk3vKBQ1kItd2FItiwrY4Ex3GAxFAuizAvFL+m4
 OmXIDmRB6sw==
X-Gm-Gg: ASbGncv1MpvatzTkB5mXT3ye8pfdB+ljqHND+ffeoMSvwBVmBh20NA0eZuXy6xbsD2F
 5NZhSFm1d7H8qf93WZCHCQVn4LEXIP/zmmnDi6QO84dF5dKb0HB0vqyqkpQgtBE7FlEvMOXcOid
 D5xInygnn0/XXmHiQymRVFNC1NesXZ4xcJBdeesd/ow2CXE/cGfVTsPphdNiUeYsicWoqwE7Km0
 sHIV8wRVf5yFTzHlIqHBcox2CKCxDRbxWaetouMAjA1ifOY2Dihpw+1oEHEIv3cNVu/xbiXbPu2
 fNTkVmfjYCuuDLbhSXPMRdY+HKTbrgFDmsD/OJ+eAPUQyK4=
X-Google-Smtp-Source: AGHT+IF8VwAZTEf9OhCHFR568vIdTYpP0PZiXedHZb2knv6Wq62HV5I9m3XlldyN+KRws2AFO9fNrw==
X-Received: by 2002:a17:906:6a06:b0:ace:3a72:25e8 with SMTP id
 a640c23a62f3a-ad219288a2bmr676714466b.51.1746875160148; 
 Sat, 10 May 2025 04:06:00 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:05:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/25] patman: Add a fourth series for testing
Date: Sat, 10 May 2025 13:05:00 +0200
Message-ID: <20250510110535.1453745-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510110535.1453745-1-sjg@chromium.org>
References: <20250510110535.1453745-1-sjg@chromium.org>
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

Create one more series to use for testing. This one has four separate
patches.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/test_common.py | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/patman/test_common.py b/tools/patman/test_common.py
index fda62472320..bc27b2d3cef 100644
--- a/tools/patman/test_common.py
+++ b/tools/patman/test_common.py
@@ -100,10 +100,11 @@ class TestCommon:
     def make_git_tree(self):
         """Make a simple git tree suitable for testing
 
-        It has three branches:
+        It has four branches:
             'base' has two commits: PCI, main
             'first' has base as upstream and two more commits: I2C, SPI
             'second' has base as upstream and three more: video, serial, bootm
+            'third4' has second as upstream and four more: usb, main, test, lib
 
         Returns:
             pygit2.Repository: repository
@@ -203,6 +204,29 @@ command to make the code as
 complicated as possible''')
         second_target = repo.revparse_single('HEAD')
 
+        self.make_commit_with_file('usb: Try out the new DMA feature', '''
+This is just a fix that
+ensures that DMA is enabled
+''', 'usb-uclass.c', '''Here is the USB
+implementation and as you can see it
+it very nice''')
+        self.make_commit_with_file('main: Change to the main program', '''
+Here we adjust the main
+program just a little bit
+''', 'main.c', '''This is the text of the main program''')
+        self.make_commit_with_file('test: Check that everything works', '''
+This checks that all the
+various things we've been
+adding actually work.
+''', 'test.c', '''Here is the test code and it seems OK''')
+        self.make_commit_with_file('lib: Sort out the extra library', '''
+The extra library is currently
+broken. Fix it so that we can
+use it in various place.
+''', 'lib.c', '''Some library code is here
+and a little more''')
+        third_target = repo.revparse_single('HEAD')
+
         repo.branches.local.create('first', first_target)
         repo.config.set_multivar('branch.first.remote', '', '.')
         repo.config.set_multivar('branch.first.merge', '', 'refs/heads/base')
@@ -213,6 +237,11 @@ complicated as possible''')
 
         repo.branches.local.create('base', base_target)
 
+        repo.branches.local.create('third4', third_target)
+        repo.config.set_multivar('branch.third4.remote', '', '.')
+        repo.config.set_multivar('branch.third4.merge', '',
+                                 'refs/heads/second')
+
         target = repo.lookup_reference('refs/heads/first')
         repo.checkout(target, strategy=pygit2.GIT_CHECKOUT_FORCE)
         target = repo.revparse_single('HEAD')
-- 
2.43.0

