Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD00C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 03:03:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 206B88654E;
	Thu, 24 Aug 2023 05:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OErc10rT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 711A686546; Thu, 24 Aug 2023 05:03:26 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 745108652D
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 05:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-34ca1bcb48fso14285055ab.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692846202; x=1693451002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HGjjRmImgk1uPg6SMu8V5vtk1P4YBnYrenaRJJUBPCw=;
 b=OErc10rTJructzcSDOcDwpy2vkNdlILszm5nrZzHOwyHg3bc+lbZGXm5Mndo5WzvmP
 GFWyRBKiVl1mCbiwzyDfzkUEMdvzCe3JSsCjB0l7AodYQlt8wgGHIGgwtxGdfTbJPCEE
 dk+ceoTjossv1VJc5NQkUt69VN+1/7KMuSEGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692846202; x=1693451002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HGjjRmImgk1uPg6SMu8V5vtk1P4YBnYrenaRJJUBPCw=;
 b=bv6CblyJaiEi8WU/GujmSF4DYUO9Oevl6uO0Y/oxhLdWYTZrC73UeVqHBxeb2/d7/r
 j7YNa+BIX4yznvwDtj7mSziMcsz5OjiNBMOFAZhNYVNHMqEUEfNdXuZYXe9svAdruk1q
 tIMjCAurlAux01esI8qaftyL1uskIuOcfZqI565duAogbi/+qhKzOfOku9RDPeAInZNw
 hqPLXXKyRvThPEb/g7nU+Yu0tapFlnMirvOC+YVmMMAuyTqEJ52CvFbvZ7KIh4UOGSyw
 6pUaoN63b3ujJ/DV1PLnSNHqkroFkIqHRqFbjAPMyU+KU13mXgxgQdZT8XrcbXTJKqQs
 1JJg==
X-Gm-Message-State: AOJu0YyBUtkdOuhUIKlgMqdnkallVj5u+GlNSML5Jr2nuSHqmA0maI2f
 +ImRNhHPT4rLxsUAjHIhCf2pmH1rRmm0oBMO1BI=
X-Google-Smtp-Source: AGHT+IFYcyIK4fJjW1jf9BVrxycSjHesTLWUCZiqvLFv6Fw/kBp9Q6tty2eHSb1IDzq/5bKX7I2v3A==
X-Received: by 2002:a92:1a0d:0:b0:34b:f3b:77b5 with SMTP id
 a13-20020a921a0d000000b0034b0f3b77b5mr4457620ila.30.1692846202058; 
 Wed, 23 Aug 2023 20:03:22 -0700 (PDT)
Received: from localhost.localdomain (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 u4-20020a92ccc4000000b00345fcbce508sm4274117ilq.39.2023.08.23.20.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 20:03:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/6] buildman: Keep all permitted output files
Date: Wed, 23 Aug 2023 21:02:55 -0600
Message-ID: <20230824030304.1555547-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824030304.1555547-1-sjg@chromium.org>
References: <20230824030304.1555547-1-sjg@chromium.org>
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

Now that we have a list of permitted output extensions, use it to ensure
that the -k option preserves all of these.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Tom Rini <trini@konsulko.com>
---

 tools/buildman/builderthread.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index 25f460c207db..d8374e68eb7f 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -23,6 +23,9 @@ from u_boot_pylib import command
 RETURN_CODE_RETRY = -1
 BASE_ELF_FILENAMES = ['u-boot', 'spl/u-boot-spl', 'tpl/u-boot-tpl']
 
+# Extensions allowed for images (keep in sync with binman/image.py, README.md)
+ALLOWED_EXTS = ['.bin', '.rom', '.itb', '.img']
+
 def mkdir(dirname, parents=False):
     """Make a directory if it doesn't already exist.
 
@@ -636,10 +639,10 @@ class BuilderThread(threading.Thread):
 
             # Now write the actual build output
             if keep_outputs:
-                copy_files(
-                    result.out_dir, build_dir, '',
-                    ['u-boot*', '*.bin', '*.map', '*.img', 'MLO', 'SPL',
-                     'include/autoconf.mk', 'spl/u-boot-spl*'])
+                to_copy = ['u-boot*', '*.map', 'MLO', 'SPL',
+                           'include/autoconf.mk', 'spl/u-boot-spl*']
+                to_copy += [f'*{ext}' for ext in ALLOWED_EXTS]
+                copy_files(result.out_dir, build_dir, '', to_copy)
 
     def _send_result(self, result):
         """Send a result to the builder for processing
-- 
2.42.0.rc1.204.g551eb34607-goog

