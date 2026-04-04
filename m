Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC72E88D9D
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 14:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA73D841BC;
	Sat,  4 Apr 2026 16:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V71nIZ6C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCEDB841B9; Sat,  4 Apr 2026 16:04:23 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B54CB8419C
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 16:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d91f82d819so2578155a34.1
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 07:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775311460; x=1775916260; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6B4yq9xnv3WRjcpD046dzaCjmel6C6PtA391PIoNSkI=;
 b=V71nIZ6C2cjzkWO8Yy7D8vxZjBbsLDMywL5ZEdcYAC+b6cPv1RN/Plbw6pVCA5UGiz
 8P6F08wJD4VpdRO3pmNoY+k4qohOGbjKHMxmsApPqYlwB+bCu+FTxsuJ9fy673lPCWU0
 6y8+DiXMQg1yQX7HGEu4S2/BnHXzFU+o40KIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775311460; x=1775916260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6B4yq9xnv3WRjcpD046dzaCjmel6C6PtA391PIoNSkI=;
 b=bC2V0y27NER21aNHnofCPbOS4Wo1aLi6g76hxRv4ZyE+lhmXW4TjwYOMMgFfm71xgU
 q2i3GBjxXShcb1ZiC6Q2dhaGuO8fyqmZ0CeSKO/7RzumyctUv2U0WP+nJIWYftSzOaka
 axIx5EVTVmJGezFTPbJYdTIK9IueM+RQWzZVp/F5d2KJZJoeMZ129Bm+0EnR4iYTc2LT
 xHvSq6qc5nFXqlbtMCDT636EXm1uiPS7d92268mHvNphWfwOgDXwh67mqYzFyVBsH3hc
 gperq0/MWmOV10BgYfT1rQebCDSTiXic3/1wGzkK3UzVMG8udLbrRo/vnfMDUU1AIto+
 gjOg==
X-Gm-Message-State: AOJu0YwasoYxI0hPu9hXlgFEPCOd7tn1SycQhj+UosQOtCOPkLrKpWSk
 poZakKhDRns5ye+yxbsiBPgeU9WZs5JoiC0HHdEbjh7PXbUEOx9dTpZO9QGxZtc13kOapOpGS3c
 bWQ4=
X-Gm-Gg: AeBDietRdZw9wWZsCMFSlLzfBXPMPPgkKlcT6bFNkqhI7M4TLoSSqe+A6u2g0V7mQFN
 mOoiGZwoljqaSxK9RkyTZdzZC/+OmxoAOescxqDe/liB/diDLMJW/ywfEoO6oHz0x4KRmmHQTjZ
 IsnPlfAhjvToM8zGlnd8zWkdfhYgCj+yBcan12i1BM3pZ+SBdes3HxpkJHdnnN6bk9O0SMNo3vi
 xqpRlc6DjShWSrq11+9lDyMHheNF6hTdfbMeqfXhyzU76m4hpa/rnDM8e+kxkkGfpSM7jzVb043
 8mQUk4RoI82E+nIm8LfIJSDpcY3HmThXXQd86H+iEUrWcmaAztZ74pWeEB0rE6ZHmI7WHj4kYCc
 4TvFNG2JtEne1n1VddmJr5/gQvJOnBepeIIbNvXyKTdCqvoBJ/ebXRi2IG8h2xBhZY/T86GptcL
 Jro0Dz2gbmrcLZl/CN5A==
X-Received: by 2002:a05:6871:289b:b0:41b:f608:177f with SMTP id
 586e51a60fabf-4230fd5bf56mr3665606fac.17.1775311459885; 
 Sat, 04 Apr 2026 07:04:19 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4232eb3d0e4sm2348235fac.6.2026.04.04.07.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 07:04:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/14] test: Rename setup_bootflow_image()
Date: Sat,  4 Apr 2026 08:03:16 -0600
Message-ID: <20260404140328.3724864-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404140328.3724864-1-sjg@chromium.org>
References: <20260404140328.3724864-1-sjg@chromium.org>
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

The name of this is fairly vague. Use 'extlinux' so that it is clear
that it relates to that format.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_ut.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 9b7f1c6f3fc..a858f2c2d13 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -159,7 +159,7 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
     fsh.cleanup()
 
 
-def setup_bootflow_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
+def setup_extlinux_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
                          script):
     """Create a 20MB disk image with a single FAT partition
 
@@ -236,7 +236,7 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
         append ro root=UUID=9732b35b-4cd5-458b-9b91-80f7047e0b8a rhgb quiet LANG=en_US.UTF-8 cma=192MB cma=256MB
         fdtdir /%s/
         initrd /%s''' % (vmlinux, dtbdir, initrd)
-    setup_bootflow_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
+    setup_extlinux_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
                          script)
 
 def setup_cros_image(ubman):
-- 
2.43.0

