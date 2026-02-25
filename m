Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D130CFD45F1
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 22:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF07B83E85;
	Wed, 25 Feb 2026 23:51:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P1NUP/0z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48E8582A9E; Wed, 25 Feb 2026 23:51:26 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DEAD82A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 23:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-899aede64e8so655066d6.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772059881; x=1772664681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nM0JQ5SRy777m6ozsFUthCSpwf8ButlTKkUS0BgJcmI=;
 b=P1NUP/0zGFaDHBqBO6vpI40LEImzxeF1Bkto8yIMzc76WbTqtjiZS/8V7QVEJc0Kof
 6jrV50C0yz3hIqNBCiZCi+t9kYVMPbb1Ti39Q1kO2kN051+xg2xFpbgSUyNOMaatAPCW
 S4pkZ3bueyNu4H9NDENzRjw1TCoDLSuQzDjV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772059881; x=1772664681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nM0JQ5SRy777m6ozsFUthCSpwf8ButlTKkUS0BgJcmI=;
 b=R0ZT7aAVNIeVSG43uA5GMNoHfDfWASvIu3U0cZMMKM6k13O596LOldN4RceIEhFUcb
 hpVPNqNOorsBJLY0xz9u+UMfAngv4gqGKsNwY/4I1aJtPgYfBgZ0ZNGw8QrEZgrw5feB
 l7WHrWycbga7I009PnF6DA7cdx4cMgpxOoM8JLAVOVX4JRnooPZOHYuDbIjKDUsKclNG
 UIA2v8HY0qhyy3YrH620pKaG0Rkrl7WgRFx8TDCnFjlJq58NsgKmNG3rg7bVHMKeYtB5
 i7jLJ5PrO3L4zWJMYv1wTkEISXz0G5xwLBItrqEbhtBKVGDmsAcuSU6mTxlrHmpMc1R8
 k6jQ==
X-Gm-Message-State: AOJu0YwLz5BsBl6shtW4nV78PxZLkVOjnuu95+/SKZAI3icOVuoXohq+
 c3qPP3I6bcRvqLob8keUNYvXt57ZybnnkP8njDWDYixnERymBEC2cp4Yq7IcrnQPYNo+Lg76oul
 9Yu4=
X-Gm-Gg: ATEYQzzTsmjJOZvHKdtaDo+cuIQQoUq7G4J2N08eEw+8RonxcewYeu+Iv6k/m8haJER
 BJlCQBq2m+CkSqjF1hdlYwW18Kk9s6DlCvR9YGx2SyNmEuh7LAH9Tywh1OJ8c4zqpty42JOVRXh
 WqsnkXcjczk9OyVOl78ow1GXT5t+VyKAXPlB3ichgv/X77CCA2J+q67e9ijGPnVlGxbypupSZDe
 0+hwMGZ22HXKH2gj0V8Zl0pneHUwva2Rj7hSVx9Q+dM2ePlfabiu7MKb5EiQJJTQan5ns8ZA4C+
 SMZZgh/2YB2RwjzyVsImsOqGk13grnf7oN5aGzdwUDLvUtnGtfZiFXQ9kGlzQO/5KVCwprtcB8S
 B+aYQ+lQxD8zRop6vorqzXWvBxWSYKICgXtOBd6rPG38BSDdgKvjfj+kDkOAj80dUTBeZYpRI67
 Xrff8ArPVxU5RL70JmoQ==
X-Received: by 2002:ad4:5c65:0:b0:894:5b77:ca26 with SMTP id
 6a1803df08f44-899c67bca6fmr11515116d6.14.1772059881459; 
 Wed, 25 Feb 2026 14:51:21 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf72e21bsm43730985a.44.2026.02.25.14.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:51:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <simon.glass@canonical.com>, Alice Guo <alice.guo@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>
Subject: [PATCH 3/6] binman: test: Capture output from tests with warnings
Date: Wed, 25 Feb 2026 15:50:32 -0700
Message-ID: <20260225225040.2568118-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225225040.2568118-1-sjg@chromium.org>
References: <20260225225040.2568118-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Tests are supposed to run silently and capture any output produced.

Fix testRemoveTemplate() so that the message about the missing openssl
is captured, along with the invalid-images message.

Fix testNxpImx9Image() as well, since it is expected that container.img
and bl31.bin are missing.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 tools/binman/ftest.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 202c2adf58d..276b0dd77fd 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7915,7 +7915,8 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         container_path = os.path.join(testdir, 'mx95b0-ahab-container.img')
         with open(container_path, 'w') as f:
             f.write(bytes([0x87]).decode('latin1') * 32768)
-        self._DoTestFile('359_nxp_imx95.dts', output_dir=testdir)
+        with terminal.capture():
+            self._DoTestFile('359_nxp_imx95.dts', output_dir=testdir)
 
     def testFitSignSimple(self):
         """Test that image with FIT and signature nodes can be signed"""
@@ -8307,8 +8308,11 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test whether template is removed"""
         TestFunctional._MakeInputFile('my-blob.bin', b'blob')
         TestFunctional._MakeInputFile('my-blob2.bin', b'other')
-        self._DoTestFile('346_remove_template.dts',
-                         force_missing_bintools='openssl',)
+        with terminal.capture() as (_, stderr):
+            self._DoTestFile('346_remove_template.dts',
+                             force_missing_bintools='openssl',)
+        err = stderr.getvalue()
+        self.assertRegex(err, "Image 'file2'.*missing bintools.*: openssl")
 
     def testBootphPropagation(self):
         """Test that bootph-* properties are propagated correctly to supernodes"""
-- 
2.43.0

