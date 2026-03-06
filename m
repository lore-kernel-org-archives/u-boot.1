Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD00FCC066
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 19:53:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6EF7838BB;
	Fri,  6 Mar 2026 20:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cy5Vf+QS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6950383F75; Fri,  6 Mar 2026 20:53:15 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7F108003E
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 20:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-676815e147dso5080434eaf.3
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 11:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772826791; x=1773431591;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7ifYr9MU+XxeY0y3sLX9fUdd7fSLWL6ipn+ukZIPXRk=;
 b=Cy5Vf+QSNqW6VlvHsOxPzubmvQrCBKv/nUC7MypNlmlqUkAttmKOz0C7bP+RYAmotp
 Gg3BOuF4L0GJHKZnYSKyZ7gO6eSTSwAv8J4JX7B6mpoV1KnoX+3UOPo1Ig98z+s6PgYF
 0pjOerzqegbp7U8lJdAiapfxU8EUAMiF6+CZVpaxnYWlc10xbVbT2JOtQOJDHPyOf+84
 qlGwCyGyJ6bD6YxOILUL1O0QVNkrvhRKt1GccJqgjseqxyukom0KlnaI0B6P90KAaUPP
 XRxjGJECFHmTW1BfuNvk/jXuK+sNJp7tITBGeIOSYG1yfWTVOvZXFpcwAtC+c0jaiMGD
 YlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772826791; x=1773431591;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ifYr9MU+XxeY0y3sLX9fUdd7fSLWL6ipn+ukZIPXRk=;
 b=riZhsVCSuQ/jR9YzrlCfIrTBV10soT3Hyj51eq6BGB9NNYL0ohIyVloaFmJWtIaC6Z
 OjbaBEE7M/Fd7yFNuXAEte1CWy/MT9kl99HeEVwyDmmu7zfkiNPlDsdnAFDK1Z19ih4G
 rmFRJUcKBzJqNc4lCKKG72/R0s6l9YtMQCkmfsMXGQX1/xk6H6pBCqF5y45leBVtC38E
 JW749vz1P5aa3w0Khi+3rvHOmD6+TPj1CMb4UdHr2HouFSou+1HcRKjIrQqRDoSSd6Mk
 HIlXXGmfd5442nNpPOE+344uu6l86ObX6qz28RRVDZbIIjYdegxzFNAZRRWfTNAvx/Or
 Zn6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhtj9CloU7lXjhjHqcNnJ/1MAbVuWpwi9BCgzDAjnQZKN2Ds5gjbaDxgcjTmZHs0ZjlUbW/H8=@lists.denx.de
X-Gm-Message-State: AOJu0YzWxXdhlfj6jLnWcYzJgbZwkTLIumXXFobJhBh0d/NZXBfAfRdf
 8wJt1iJ49+SAWqWyeLN+RjdXMwMGy5KI0JI5b6KkT12Znv63fZmi9DtSznvjb/JJdXU=
X-Gm-Gg: ATEYQzwMD+x2viHdl0CwiCI2q1MS3Vk94UyBHf1pEBNS1qGg0IyIj3wC5a5Raa1vDxY
 ZBqWwTArRUKLeHk/yLmzZQ1RlJ4lFXONsfdbrY/HzWYwCWN8BbanFIH9IU9F4lF2zTxN+DpGrp1
 7ahEyscYpF4F8d5dwOqB99pIKy0KE/3HvvviSe5QmWp9DDC7/Tu+On6F33CHVma0tiknxG2U7kT
 ZwGysQaiwqpbrInIzVMYyoNz99RkDy5fNcLyTaMTyn6xY1Ka04VxZPPCGkoMWkdEkgaZfhICf++
 hbuQ7CBxxgxQ4LclPeOqONZmUaQGiz2jOH+B2M7VYdJK9DYcbhahQJTzzKsrbzxEDNRwV5EJ+ov
 H3mcX9K+wVPIdEl/O22G1tmKe7YMnWId8UOxr+UK+9KStZI+jyzpEe6608W48KN5CL13+bas26Y
 qqxft0JOqaktl72JoD6jkU+Tk1ljiv
X-Received: by 2002:a05:6820:1c97:b0:679:406f:edc1 with SMTP id
 006d021491bc7-67b9bc9ffecmr2092162eaf.26.1772826791232; 
 Fri, 06 Mar 2026 11:53:11 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6d78:b98b:fc05:ddbe])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67b9d4e9666sm1291140eaf.9.2026.03.06.11.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:53:10 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 06 Mar 2026 13:52:49 -0600
Subject: [PATCH] doc/buildman: fix missing :: on examples
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-doc-buildman-fix-example-format-v1-1-fbf955d39a2d@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQqDMBQFryJ/3Q+pQkSvIl3E5EU/mESSWgTx7
 g0uB4aZiwqyoNDYXJTxkyIpVni/GrKriQtYXGVqVatVpzS7ZHk+ZHPBRPZyMk4T9g3sUw7my9p
 r64auB4aZamXPqNZzmD73/QdrPF+UcQAAAA==
X-Change-ID: 20260306-doc-buildman-fix-example-format-6f6cd937ee9b
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2359; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=J6dvZ1GBJHTkURijlUI1g/FVMULRIO10GwEqTrr53xM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpqzCemULbaVgEjfn2vgcEQGLlc2Xx3Y3ZRMXPW
 vbOYVNjlpOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaswnhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ANowH/AvQLRQCvToXZ39gFw/r6JtXPVfe3ra/ZlwYSsw
 v4VER8UI3mZHtjbf10z7hd5DfqaTfQWouduCdByDpYiCG1lSW/g2lfBqGb5NqCgVlY/GHW1cB27
 XWTIN3QBmNfqzSGKsb2n3LKztQI6GBJ44uOo5mISuteP0MS8p++wLbE0xi8J7RX1JG+y0iH4reg
 08E+4qJ/5guqptpBal/GWi7671b0lXw0aHGyt1DOeGhdLJhEkQPeoYA/HKLXplk+ygvhF+eO5TS
 30ZLKlOlXFgfWttY8+Ditl3oR4FdgvwZ+V/sdLUyC2nPMyF+nIdUgevAsVDV2Y4zVzf3UoW2UU0
 x8MM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Fix 4 instances in buildman.rst where examples were missing :: for
proper formatting. Three cases just had a single : and in one case,
: didn't make grammatical sense, so it gets a stand-alone :: along
with fixing the indent.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 tools/buildman/buildman.rst | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 9e850b26ec0..a2061715788 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -146,7 +146,7 @@ the '&' operator to limit the selection:
 - 'freescale & arm sandbox' - all Freescale boards with ARM architecture, plus
   sandbox
 
-You can also use -x to specifically exclude some boards. For example:
+You can also use -x to specifically exclude some boards. For example::
 
   buildman arm -x nvidia,freescale,.*ball$
 
@@ -970,10 +970,12 @@ a set of (tag, value) pairs.
     settings file. They can also be useful when building U-Boot against other
     open source software.
 
-    [make-flags]
-    at91-boards=ENABLE_AT91_TEST=1
-    snapper9260=${at91-boards} BUILD_TAG=442
-    snapper9g45=${at91-boards} BUILD_TAG=443
+    ::
+
+        [make-flags]
+        at91-boards=ENABLE_AT91_TEST=1
+        snapper9260=${at91-boards} BUILD_TAG=442
+        snapper9g45=${at91-boards} BUILD_TAG=443
 
     This will use 'make ENABLE_AT91_TEST=1 BUILD_TAG=442' for snapper9260
     and 'make ENABLE_AT91_TEST=1 BUILD_TAG=443' for snapper9g45. A special
@@ -986,7 +988,7 @@ a set of (tag, value) pairs.
     config.mk file and documented in the README.
 
     Note that you can pass ad-hoc options to the build using environment
-    variables, for example:
+    variables, for example::
 
        SOME_OPTION=1234 ./tools/buildman/buildman my_board
 
@@ -1357,7 +1359,7 @@ directory.
 Build summary
 -------------
 
-When Buildman finishes, it displays a summary, similar to the following:
+When Buildman finishes, it displays a summary, similar to the following::
 
     Completed: 5 total built, duration 0:00:21, rate 0.24
 

---
base-commit: c0ca147ac6228949a6d6497531c9f2f4a0dc6c67
change-id: 20260306-doc-buildman-fix-example-format-6f6cd937ee9b

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

