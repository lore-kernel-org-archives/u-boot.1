Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0E4C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 19:34:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19D5884A06;
	Sun,  5 Jul 2026 21:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EjdWncsm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8503F84832; Sun,  5 Jul 2026 21:33:54 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69ED184A06
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 21:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4472500e25fso917078fac.1
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 12:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783280031; x=1783884831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOccMyhIGwhtKNxipFUd2BiSYd/WP+w6RweOier42o8=;
 b=EjdWncsmkFMw2b4QidQFDKAJAH0JOc1n+x1IlUhDR6XSWPhJX+sE3BB0vnwx3eqRAo
 Pbo0Loy2r4lGEstnzJenP+/8HTn6P9FXuDhjRgkxR/C4Q3bTAsD9fOa722IWAftvnU4D
 bjwid850xJWCQb58lNkB8DUlpDzut1JcuQQrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783280031; x=1783884831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gOccMyhIGwhtKNxipFUd2BiSYd/WP+w6RweOier42o8=;
 b=E2QNitrsujrQYIeCqMTqD9Z/FfG6MgoTxTK/DLTlnQgCd4kvHJknRW7kpUsWmx0s5h
 dwNvFzRxCSbPFTMh9aGbJngwFFkbs7+yD/KE0OHNadQXwqPZ7WUjg8phe9H71sinulY8
 9AYmYzVXvB2hvdUA8i0kfphSX4FNtn7P9YrEghBvq26nVD7++Ki60CBSjF7/qrLbRtRO
 ESsQBztq2IHEvlHX4lCJEBnfgIevv+tgTQRJnB+6VFR22YZlVpYzCQWppd5FeDdDU80F
 bXad3HYn1l5ixWdIhggCqWw2QsWDHH4i3LIEH1DeGNScQ+qqkmp0jBXyjUxAy2NCDqMR
 pw5A==
X-Gm-Message-State: AOJu0YyWa0CG+yjcVqah7U4OnZAY5bk7Io1Tm3X00j/rddjFhNy8Ysic
 2N2vy0peDjlT5BvFX4QJTEaeiOsDnhrHHlYRvjU94UP5uYcRzKYz1P6PWctM457qfgMPiTOGdEe
 zYQMvjQ==
X-Gm-Gg: AfdE7cll5hb21sTSmHgFN2GDLr9MRd+RYJR/epuy9Xrxybd+2D9K8mcpAjbJF1yACy3
 VN+lwLnpbP3QBH7Skr9wVbaaPoJW5y4MANMhkPhUoB/YpGjKxUJ7bB0V+kn/RGKi8uPwgwcPCwt
 Io238tKm/yd3LSwJmQvdOg8GaQ7ooafp7uCHgFUsAKr9lXaYa3Klpdpzy9lX96UybhwvOSnEMQI
 vPfsm0qfxwAGqcKZC5MUkvb0nca2JifJo5fUhfgDFYI5pQyo3nkSk3Gmx8wTNCAzX6C30KrsOTp
 6dMH1q6s7NEsRXNtZ2VY5vBbpRL2kfzoyAPKNBo0ie/TUICFmdwGWqjaJNvmcSrFfVCdfTLqYqF
 upAZzn6AfYj4yS53egU8eXX9x0fhTOQgQ4fWDiC/L//3jvy72cw5EsZwlHzqrRAnMwt+pTpIX1Z
 jZIdm8t18=
X-Received: by 2002:a05:6820:206:b0:6a0:db91:ad3f with SMTP id
 006d021491bc7-6a32f5412b2mr5223730eaf.37.1783280031142; 
 Sun, 05 Jul 2026 12:33:51 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a3103e064esm7513448eaf.14.2026.07.05.12.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:33:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, E Shattow <e@freeshell.de>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: [PATCH v2 11/11] test: Stop running the patman tests
Date: Sun,  5 Jul 2026 13:32:22 -0600
Message-ID: <20260705193251.2190705-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705193251.2190705-1-sjg@chromium.org>
References: <20260705193251.2190705-1-sjg@chromium.org>
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

The patman tests no longer exist in the tree, so drop them from the
test/run script (used by 'make tcheck' and friends) and from the
tools-testing example in the documentation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/develop/testing.rst | 2 +-
 test/run                | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/doc/develop/testing.rst b/doc/develop/testing.rst
index 3a2b496fa00..1d19b49e82c 100644
--- a/doc/develop/testing.rst
+++ b/doc/develop/testing.rst
@@ -22,7 +22,7 @@ the quick ones, type this::
 
     make qcheck
 
-It is also possible to run just the tests for tools (patman, binman, etc.).
+It is also possible to run just the tests for tools (binman, buildman, etc.).
 Such tests are included with those tools, i.e. no actual U-Boot unit tests are
 run. Type this::
 
diff --git a/test/run b/test/run
index 768b22577c4..7c0263713c6 100755
--- a/test/run
+++ b/test/run
@@ -80,7 +80,6 @@ export DTC=${DTC_DIR}/dtc
 TOOLS_DIR=build-sandbox_spl/tools
 
 run_test "binman" ./tools/binman/binman --toolpath ${TOOLS_DIR} test
-run_test "patman" ./tools/patman/patman test
 run_test "u_boot_pylib" ./tools/u_boot_pylib/u_boot_pylib
 
 run_test "buildman" ./tools/buildman/buildman -t ${skip}
-- 
2.43.0

