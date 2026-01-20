Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECCBCCF2DD
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 15:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00EF483A6A;
	Tue, 20 Jan 2026 16:47:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BFuQeDs7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 373E083A9F; Tue, 20 Jan 2026 16:47:55 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E00483A2B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 16:47:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7cfcbf34124so3597399a34.0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 07:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768924072; x=1769528872; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otUF59q6Q+BrvmPiBwg1LVZPpYpQEqaPFs7mldA+seY=;
 b=BFuQeDs7FMbYycX9JCdTWJWNTw05EB2x3WwJegEkG83Yci1JQCCfWbn+SEl8WP5JuS
 bkqyDgMtoRYz77yGIKhiuZvtMtcWpeaTENmo0Et3SP8kUJXASOPXqatW7IloYv7NwthI
 MlnmY027rEd1eSd/jfoF//cjzpbGjzcPprIMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768924072; x=1769528872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=otUF59q6Q+BrvmPiBwg1LVZPpYpQEqaPFs7mldA+seY=;
 b=c+4RGpVFpacWM+9fhr6I7NpXD8IVHdHjuAKnjV47xGaejz5IrLEB2VOGHxKmjceRp5
 3Hnhbs4QnM8P/oMYK0dhcO1eaFC+RBXNvxHfNVZadHr1YEIu5kfBI+Cu76Z678a5FR7k
 LlEyTm9PnLd1pMtgc430u1J2ERYAoeukQVatmr5pp/q+VId6bRYbdg0Nhj46rdX+G0G5
 33T3xdM2ox3T8kKNpmBD52RbB5iueX9qBtDxkMm7hLdVxkAQBIGtu6/iUaGuTmXWC0jz
 xTuD76S4ZedNw8oPuphPq1nj5eJGaxX+NkV5cXCWgB//3IuwnKV15wm8sE9c0RlqmN+C
 BLsw==
X-Gm-Message-State: AOJu0YzAjneo1oFlKtWP2qgmK5OSfZmWnvFxQU58msSKG9pKUE2sRLp3
 +OHZHYTWXh2eT0U4Y1U6IHWZZSBSdJneunXLg1Qe2ojyfI4la5lf/TmPTl1Gz6W7PzSqhN8FrUF
 zJiqHqdY=
X-Gm-Gg: AY/fxX7zcxZqZ6L83OQa/v9U6j2ubDR0JObuWLSyh23UIpX0VOZWFoH3L33GlotFxAd
 aSWIB4znNv4LuvaBdMSpFoyRfRqWoFQ0j7mpHP6lbqrOIjIU6lu4ZLBYOxV1xNC+zbTcJvUzEMA
 Ou7QhgiCkp57/1DKPtXP5M+1EXWYBtElAKk7ssVghgDnU40MZd3tRcp115g0dj7xWoxKWTH0jQW
 L8aDZvG+OEuixghGSjqD2gHvnV8P9FLPcvAV5UNZtSj7CmrTw1B3mMPgkADTq1/FzwNjf+OoT1P
 qpcidIwtxJYGQ80tPghtHtf3OwBM4lL+F2a/1KSv2HYiC7tu1LuqH4jGV/e9dwyf8AFkeJJVEAM
 y5OV+rXgc+M8N483s3hygZUCOsqjDgfANpeWkL/K8bmpBR3EI4g87JLkDEZw/OqeD1wefduVPIv
 ethqmGWcZbk0DbzovA7mDzmDloTPILXWiIeW/BDPxuySiA4ZDwzM3EPMlo14j3fLDKkjnCNYruB
 ivw231mQXwpUStXUnLkulP8DBUOzz+RL2fr/ZcrlA==
X-Received: by 2002:a05:6830:2a93:b0:7c9:5934:85f0 with SMTP id
 46e09a7af769-7cfdee0cd13mr8120059a34.23.1768924071749; 
 Tue, 20 Jan 2026 07:47:51 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf0db2c1sm8852578a34.5.2026.01.20.07.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 07:47:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Dmitrii Sharshakov <d3dx12.xx@gmail.com>,
 Andrew Soknacki <asoknacki@gmail.com>
Subject: [PATCH v3] binman: elf: Check for ELF_TOOLS availability in is_valid
Date: Tue, 20 Jan 2026 09:47:50 -0600
Message-ID: <20260120154750.420179-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109-pyelftools-warning-v2-1-e27784f14c56@gmail.com>
References: <20260109-pyelftools-warning-v2-1-e27784f14c56@gmail.com>
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

From: Dmitrii Sharshakov <d3dx12.xx@gmail.com>

Check if elftools package is available before running DecodeElf().

This clarifies the error message and adds the required test for
coverage.

Signed-off-by: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Signed-off-by: Andrew Soknacki <asoknacki@gmail.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
[trini: Add the test provided by Andrew on IRC, to fix coverage]
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v3:
- Add the test, provided by Andrew, to address the coverage failure in
  CI
---
 tools/binman/elf.py      |  2 ++
 tools/binman/elf_test.py | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/binman/elf.py b/tools/binman/elf.py
index 6ac960e04196..899c84ad36d6 100644
--- a/tools/binman/elf.py
+++ b/tools/binman/elf.py
@@ -570,6 +570,8 @@ def is_valid(data):
     Returns:
         bool: True if a valid Elf file, False if not
     """
+    if not ELF_TOOLS:
+        raise ValueError("Python: No module named 'elftools'")
     try:
         DecodeElf(data, 0)
         return True
diff --git a/tools/binman/elf_test.py b/tools/binman/elf_test.py
index 5b1733928986..3ad0bf4c4b09 100644
--- a/tools/binman/elf_test.py
+++ b/tools/binman/elf_test.py
@@ -373,6 +373,18 @@ class TestElf(unittest.TestCase):
         self.assertEqual(True, elf.is_valid(data))
         self.assertEqual(False, elf.is_valid(data[4:]))
 
+    def test_is_valid_fail(self):
+        """Test calling is_valid() without elftools"""
+        old_val = elf.ELF_TOOLS
+        try:
+            elf.ELF_TOOLS = False
+            with self.assertRaises(ValueError) as e:
+                elf.is_valid(b'')
+            self.assertIn("Python: No module named 'elftools'",
+                      str(e.exception))
+        finally:
+            elf.ELF_TOOLS = old_val
+
     def test_get_symbol_offset(self):
         fname = self.ElfTestFile('embed_data')
         syms = elf.GetSymbols(fname, ['embed_start', 'embed'])
-- 
2.43.0

