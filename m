Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEC8E63FE8
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 11:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C912A83D17;
	Sun,  5 Apr 2026 13:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lg4Ps7QL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D274383D17; Sun,  5 Apr 2026 13:12:24 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02B3B83C5E
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 13:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-463a0e14abfso1773171b6e.2
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 04:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775387540; x=1775992340; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eY4f2OVMBsEq3II0CxgNsIflLhjFFekoCas/zpOE3mM=;
 b=Lg4Ps7QLi2QXnhHVMNGRCyNvQ5LXqiYfcHwYoth/h7cEc9IvCdFCfKNzE69wyyu+3X
 Cy7SlIJkZudLSrnNKmqfVY4n4OgbFUXjSsmyX4skwz1AvX6X6U2cE3V3srhwsR2FXzAt
 wlSa9M6bd/4mh1hC3VF69YW520Cilj/JTzwU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775387540; x=1775992340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eY4f2OVMBsEq3II0CxgNsIflLhjFFekoCas/zpOE3mM=;
 b=ojw+IODH+ITk20xdR1E2WQ437tArDNcxuvax4NNRjVMdJwJ2xPuJ45x2wP5H0dXviB
 xdHdT8xsWEF2vf9mE5QEuuBy7vWQtqKUuV55cqSDlefKQoX0ojYcXYm3C9D4o734idY/
 cDdBIJce1lj+E+jNWVzKhz24zEqUbWt7jGRM5Nyjf+g/Y9sONgBAlbKDMDh1SM7NOLrp
 B5lli0BZBsgn/EBwr95+zoGt7MHu9ewY7pFl4j3yvb3mlJBfQXZqfYr777K7YOzjFA3Q
 ZUApV8cJAZVCjsc1TQKytNOUhXPOxKGE8Jnkcjtpr75esPiGcS2l4Ny05pCp4J74vzu5
 uUSQ==
X-Gm-Message-State: AOJu0YxCT3HspNlSvZl7ItP5eK20RpJvvFMr2keRk1HJ46x4A8zRE+Qw
 6pHf6dYTG6YHcAoRSa3Pa+df5ljZxKq6nJyn4EmDBMdR5T7Q9nwre5lmMaPMgFSaHjY7pKhbsD+
 7EIm0IA==
X-Gm-Gg: AeBDieuOBloXTrkD8yLDJEAD/YW+ent09BBLerVcAsvnyzu7LLZXt/3QP0TFnBlty49
 5CbA6qAUmE1DLetLFw9Fhn7elWlGm8xiCwe6R7z2TMFy6mpvVAwiFPLw6VcdNBgZStn6uBDovus
 kfk0rZ/kMoxTrHQUGd0aYGsLZSxePHohv1mTnIyrSyFv91LE1lg2STrtGq/XzV4MKLcDoolUGlh
 vdYi7EbSSN2TQopSYNzSwb/SDpWr61nxPbVvBOY8+EwsVrjSIqO8GKzJGs5vX51fCIS/qQjtVYG
 YbOuEve2Tws+3+RX6nuxMHC2YYX5pQIXnOvovHWBnhDC1uiFFBJB5nWwmJt3Q8L2mcqHgCJkfUj
 uCdKGA3nf5+ZJRWdbWg1PuYepjywIWhjCgqIFlzciWLgLbKPIXDU18AhLQFdzyF72RS5tfscHmE
 1UhyDO/SFp3tUzNyM1zA==
X-Received: by 2002:a05:6808:1b90:b0:467:de9:3eaf with SMTP id
 5614622812f47-46ef56fb08fmr4104652b6e.10.1775387540202; 
 Sun, 05 Apr 2026 04:12:20 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d8d109b69sm6414382b6e.0.2026.04.05.04.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 04:12:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/8] test: fit: Drop the fit_signature buildconfigspec
Date: Sun,  5 Apr 2026 05:11:46 -0600
Message-ID: <20260405111206.945185-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405111206.945185-1-sjg@chromium.org>
References: <20260405111206.945185-1-sjg@chromium.org>
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

The test_fit test requires buildconfigspec('fit_signature') but does
not exercise signature verification. The ITS template includes a
signature-1 node, but mkimage only needs TOOLS_FIT_SIGNATURE (a host
tool option) to handle it, not CONFIG_FIT_SIGNATURE in the U-Boot
binary.

Since sandbox does not enable CONFIG_FIT_SIGNATURE, the test is silently
skipped on every run. Change the marker to buildconfigspec('fit') which
is all the test actually needs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to fix the buildconfigspec marker

 test/py/tests/test_fit.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 619f73153a0..71c98be27cf 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -116,7 +116,7 @@ host save hostfs 0 %(loadables2_addr)x %(loadables2_out)s %(loadables2_size)x
 '''
 
 @pytest.mark.boardspec('sandbox')
-@pytest.mark.buildconfigspec('fit_signature')
+@pytest.mark.buildconfigspec('fit')
 @pytest.mark.requiredtool('dtc')
 def test_fit(ubman):
     def make_fname(leaf):
-- 
2.43.0

