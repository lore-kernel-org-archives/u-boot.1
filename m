Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18082C71159
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 18:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62FCC81E18;
	Mon, 16 Jun 2025 20:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QoDg+8C8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90D7E82B18; Mon, 16 Jun 2025 20:54:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD6FD81760
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 20:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750100039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ibVALcQjl0KPX4HiBt0Ml1RorgqKAsfGpjDGO2rFssQ=;
 b=QoDg+8C89khRhJ12MxXpLS7n71gnu1b1LxR96BXhkHuN3IuX1M7GlOn8GCjj6papvoWv/F
 iEaH5ImQ/rkzH1f8qz9dru++tV47+qqeoZiReYpkOEcH5Dox82ZjtknaowvVxYpB3n3m4Y
 9er/fUpcEO83gevIGiKzeisOMbRY+ec=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-Yb5GGnvaMtuvQT00JhgNlA-1; Mon, 16 Jun 2025 14:53:58 -0400
X-MC-Unique: Yb5GGnvaMtuvQT00JhgNlA-1
X-Mimecast-MFC-AGG-ID: Yb5GGnvaMtuvQT00JhgNlA_1750100037
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-453018b4ddeso29600935e9.3
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 11:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750100037; x=1750704837;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ibVALcQjl0KPX4HiBt0Ml1RorgqKAsfGpjDGO2rFssQ=;
 b=sxKpJcuHmVg1AaPQv41rRCSjWcMoLFQb+ivjWGiaNGwD/4CsaNqDOHqswJdjdijOs7
 n9WBNVTOFY1P1eTTK1wugyTsYc0vkdkfc4gJa3mC058XD7X1NNFv9ASgAaXlhDZij5Ta
 FNGfrGop2ZNLLZGSjJv39zlVONpNeC4cUcJAfZTdfEvqrrbGFd5Hnrsz18dz56fUAqlm
 dyI5JtaCu9gVPnLt3U5LzzZIZzkhqZW1NOVmbOSsHPvuR2gCI+LF/ZI43QI+YbZh9aWK
 ClGeZbiS2I6jpzT/KyMXLe7CNT/XtBdfdWzsyU2y0vSfAPY65HCLicHZyrGtNdGHCY7U
 rJQg==
X-Gm-Message-State: AOJu0YxSliTwgBN8e/fuwZBcwHbr4ylUxDXI7p0Mgp1W3Fbh9gqmqT7I
 /I0o0FH0tmFpCfHowWnG9NUx83/GbHPfWKpnK0XAZMgKN2W4ehhJtyhfifC0CHgBb/q+g29GSij
 9GWXoYWuzt5WiN2OrZtUtzjfuT/aAsxCLD8gOhFGvJW2+xzFK0gW9ec9vZdQ3OVReRpLJu1gYgM
 yy56+/5I0cN7qNeLaMS1r5Kr4UtM2PVO/jiN+w2w==
X-Gm-Gg: ASbGnct8vUxI0U061tXnOLY6IiQQWV1zZVF9rnSK/llSS+5nOI1ZxPzFjpKBmrSzpjr
 fckblhTQ1ztfl32P8cQuCVzvR1aQgCMjy9Y25DjU77p43SUhQO0w8+UbDoKuQ6jzILBZjoPzzHf
 sNq23yznZ/LGyPYhVJ+sQXDwVaxhP9KTxHoGKPMy2mJaBDLUZADQsYMT51KMVweGrObRkB0EyoA
 wymOEi7SKQsuh5kCcyPX6Om7aOvS9bLpUJbT8dYmN9DMajuza1VvJ3bvHwEYei5LKRn3pkTAWeC
 NoQJJDwZO4B+IMweJOIzChLHHOQUWtOcocftBgbOwTCQv/8=
X-Received: by 2002:a05:600c:4ed1:b0:453:78f:fa9f with SMTP id
 5b1f17b1804b1-4533ca510afmr94579285e9.11.1750100036725; 
 Mon, 16 Jun 2025 11:53:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh1LtF9Xi9MnubQd/5ph80o99djLr8iofV3fjCTiWvKUGIuF7uCeVi5hP1Qtv1wxN5ibYWdA==
X-Received: by 2002:a05:600c:4ed1:b0:453:78f:fa9f with SMTP id
 5b1f17b1804b1-4533ca510afmr94579155e9.11.1750100036285; 
 Mon, 16 Jun 2025 11:53:56 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e224617sm154385405e9.2.2025.06.16.11.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 11:53:55 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: Javier Martinez Canillas <javierm@redhat.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] test/py: Re-add setuptools to requirements.txt
Date: Mon, 16 Jun 2025 20:53:32 +0200
Message-ID: <20250616185353.1733300-1-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3_3ICyaE5CJs-5akUjxxXyZmHzaYCxhJ4aNq7FUQXuc_1750100037
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

The commit 859621b47f9e ("python: Recreate test/py and tools/buildman
requirements.txt files") recreated the python requirements but dropped
the setuptools module that is used by the test harness.

This leads to the following error when trying to run a test:

    pytest --build --bd sandbox test/py/tests/test_net.py
    +make O=/home/javier/devel/u-boot/build-sandbox -s sandbox_defconfig
    +make O=/home/javier/devel/u-boot/build-sandbox -s -j8
    Traceback (most recent call last):
      File "/home/javier/devel/u-boot/build-sandbox/../scripts/dtc/pylibfdt/setup.py", line 23, in <module>
        from setuptools import setup, Extension
    ModuleNotFoundError: No module named 'setuptools'
    make[3]: *** [../scripts/dtc/pylibfdt/Makefile:33: rebuild] Error 1
    make[2]: *** [../scripts/Makefile.build:398: scripts/dtc/pylibfdt] Error 2
    make[1]: *** [/home/javier/devel/u-boot/Makefile:2079: scripts_dtc] Error 2
    make: *** [Makefile:177: sub-make] Error 2
    Exit code: 2

Fixes: 859621b47f9e ("python: Recreate test/py and tools/buildman requirements.txt files")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 test/py/requirements.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index 804a427b3514..17ffa52f28c9 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -3,3 +3,4 @@ pycryptodomex==3.21.0
 pytest==6.2.5
 pytest-xdist==2.5.0
 FATtools==1.0.42
+setuptools==75.8.0
-- 
2.49.0

base-commit: c5afa1fef49f55146e78d6157470520391c40eca
branch: fix-test

