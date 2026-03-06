Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FFAFCC055
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 18:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F23558405F;
	Fri,  6 Mar 2026 19:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D3m5o3KX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 957878382A; Fri,  6 Mar 2026 19:14:15 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B498401A
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 19:14:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-8cb4acdacb2so1213776085a.3
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 10:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772820852; x=1773425652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khU864Kj7mP3ocF7QD3RdZIIOLugWjhsvjrUdPpM8PM=;
 b=D3m5o3KXfzzjiLKDhXhevzjFK5/EJGq5dqawdqvJ39Rdv5x1Twf4FVWjIKA9JOx4Ly
 6k46hFeSPd8wb2iIG2GZV2UsRYk7keTfjGnBIGR0bOEauMCR/7v1sYqfouc/3V47J5EH
 KuES+yKI+7XTyDrStn0InykOumuDHIkBUPNaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772820852; x=1773425652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=khU864Kj7mP3ocF7QD3RdZIIOLugWjhsvjrUdPpM8PM=;
 b=TaFqCCsXnCypmsa9JU3+jqCpVcYHH8AoHHuX/0HMOK4FZrg9+Tr3I4ly5g8k8pY4tW
 NM5DwYnKL90LQrbI3QbqJTalyZUThG7QQ82UtFBHkgUMGfvR7b9NpoyIZLVLon5Xu81S
 P74oBuKSnrmlkezVcvsxUp8828G0BStI5RoCm2WOE0nmyAmmnwdxtezaIaXPvA2J+G0+
 h/ARnx3XfR/0KEaMYYyP2HYR7M0Z3zl20xIXeoIGYM5A+I48YBjKN2IYEfr5TqGOtfJ2
 0/VnTjdFnREeK98umUJovzBKISWgx8Os1IbSYOMlXJYalgFS6yyT6uJaflsPjlhra9Ll
 u1kg==
X-Gm-Message-State: AOJu0Yx0cMVm4oT0T2lRFfVX3+zmWOvXt+PFJH4NwDcc9mmAj3vY/iG+
 mvNeoAIQsgd4EOrxLdeGWb0hTwXJyKkEy42ZUh64OvgebLGEBaS3+R6eJ65veOW4LAt1dO+b2eR
 zEYc=
X-Gm-Gg: ATEYQzyzYbi4gbG53kAMicwrCYLR09bI1e94OUaWet1gKUB99EFcWsIWx1Bku6NnHMv
 6789XygryoPFXKCuBbvsrTgodxwo+JxqqwIDm+VM2FEYmEtcfNKp7yf3TmwEXKoHvvz4223MVaT
 Gb9P0KGbGtsJjCUl0PBGVVoUHA0yq3U2EBC3FfM5sryikeNN0HhgJ7qkGRaH/StLF1QEc4oBNbY
 cXaxbKrfKgyHX2COChYudOBFJ4Mbk+2kpWP9XroDpfciA5kmFSipAgotKYJzA+Qx7AXwNKqZ0FK
 ZjxmExhMMHP0e3LOyvYNA+9ZGITd7wfP/PdXDOUaTPlaXFkNNBYlVZ9yPDIkbpCWq2bFVLVEcgK
 JxwCKrNaX7+WXsrd4FKBm184WK+L+rFbFI5VuD7nbxmTjso/gNq5iDXsS41WsuWMKQzz6smDVbU
 czBgz7XJI8nBe63SlvLA==
X-Received: by 2002:a05:620a:4046:b0:8ca:a838:1703 with SMTP id
 af79cd13be357-8cd6d279267mr405535185a.0.1772820850279; 
 Fri, 06 Mar 2026 10:14:10 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f5736c0sm155930885a.49.2026.03.06.10.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:14:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 17/23] binman: test: Move x86 binary test data to test/x86/
Date: Fri,  6 Mar 2026 11:12:45 -0700
Message-ID: <20260306181304.2426352-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306181304.2426352-1-sjg@chromium.org>
References: <20260306181304.2426352-1-sjg@chromium.org>
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

Move descriptor.bin, fitimage.bin.gz and ifwi.bin.gz into the x86/
subdirectory alongside the x86 DTS test files and update all
references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

Changes in v2:
- Add new patch to move x86 binary test data

 tools/binman/ftest.py                       |   8 ++++----
 tools/binman/test/{ => x86}/descriptor.bin  | Bin
 tools/binman/test/{ => x86}/fitimage.bin.gz | Bin
 tools/binman/test/{ => x86}/ifwi.bin.gz     | Bin
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename tools/binman/test/{ => x86}/descriptor.bin (100%)
 rename tools/binman/test/{ => x86}/fitimage.bin.gz (100%)
 rename tools/binman/test/{ => x86}/ifwi.bin.gz (100%)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 3f57ef05ead..601d1f7eb8c 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -696,7 +696,7 @@ class TestFunctional(unittest.TestCase):
 
     @classmethod
     def _SetupDescriptor(cls):
-        with open(cls.TestFile('descriptor.bin'), 'rb') as fd:
+        with open(cls.TestFile('x86/descriptor.bin'), 'rb') as fd:
             TestFunctional._MakeInputFile('descriptor.bin', fd.read())
 
     @classmethod
@@ -1237,7 +1237,7 @@ class TestFunctional(unittest.TestCase):
     def testPackX86RomMe(self):
         """Test that an x86 ROM with an ME region can be created"""
         data = self._DoReadFile('x86/rom_me.dts')
-        expected_desc = tools.read_file(self.TestFile('descriptor.bin'))
+        expected_desc = tools.read_file(self.TestFile('x86/descriptor.bin'))
         if data[:0x1000] != expected_desc:
             self.fail('Expected descriptor binary at start of image')
         self.assertEqual(ME_DATA, data[0x1000:0x1000 + len(ME_DATA)])
@@ -2530,7 +2530,7 @@ class TestFunctional(unittest.TestCase):
         self._SetupTplElf()
 
         # Intel Integrated Firmware Image (IFWI) file
-        with gzip.open(self.TestFile('%s.gz' % fname), 'rb') as fd:
+        with gzip.open(self.TestFile('x86/%s.gz' % fname), 'rb') as fd:
             data = fd.read()
         TestFunctional._MakeInputFile(fname,data)
 
@@ -2540,7 +2540,7 @@ class TestFunctional(unittest.TestCase):
         Args:
             data: Conents of output file
         """
-        expected_desc = tools.read_file(self.TestFile('descriptor.bin'))
+        expected_desc = tools.read_file(self.TestFile('x86/descriptor.bin'))
         if data[:0x1000] != expected_desc:
             self.fail('Expected descriptor binary at start of image')
 
diff --git a/tools/binman/test/descriptor.bin b/tools/binman/test/x86/descriptor.bin
similarity index 100%
rename from tools/binman/test/descriptor.bin
rename to tools/binman/test/x86/descriptor.bin
diff --git a/tools/binman/test/fitimage.bin.gz b/tools/binman/test/x86/fitimage.bin.gz
similarity index 100%
rename from tools/binman/test/fitimage.bin.gz
rename to tools/binman/test/x86/fitimage.bin.gz
diff --git a/tools/binman/test/ifwi.bin.gz b/tools/binman/test/x86/ifwi.bin.gz
similarity index 100%
rename from tools/binman/test/ifwi.bin.gz
rename to tools/binman/test/x86/ifwi.bin.gz
-- 
2.43.0

