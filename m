Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A927CAC594
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 13:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED600835BF;
	Sun, 14 Sep 2025 15:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gedfpf1b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 331FD82A9E; Sun, 14 Sep 2025 13:01:29 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15B1780B9B
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 13:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6234995098eso234410eaf.3
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 04:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757847685; x=1758452485; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YFiDEa041V/uy9nSHfL0Xa3pbLTCCBq3CtZQuw3cD/Q=;
 b=gedfpf1bReY8dPZsnWp2c4vo0Qw8WrV8xiX6tOL2CnP0Ov6gKWf06qSJObRBWPKa4X
 /5+gLAnkNNF6Hg2u1+czzvy9ttPnP7RlN6NutXKwlXBHg8wq1U7i5RfSrx44PaIuLKHD
 v3siBBlS/PWni53wukOcJolpaGkTP66Z9kjoNwBMPpch6bCY2eNuqu9bY0ce1zjzmngM
 z9tMzHy/mEQv3uoyNYrKtuJBnlh3kZg+pyrqySwZBvXps83c9ix0HamQ3JGxmDhKtbrL
 AhdfnUHWMHTx3iI0NiDelU1/wcW27eFIKLaDJPmXBaFXkFqtvUur7HlfgQlGwqO84gZI
 aJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757847685; x=1758452485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YFiDEa041V/uy9nSHfL0Xa3pbLTCCBq3CtZQuw3cD/Q=;
 b=s7UwAqF4LUg65DZZr4phgUkhYQ5N0wMUHf8NfWIaUzHOtKJdZlAD8NCTgaewHVvPfK
 P9mVdWP/5uGk+BWd/+MhiRaqcPju6VR1fijRprhsXJNMK+3TsAIWERfEc+6Hs7UjE4vQ
 vdGycbrYCvjBXK02j2/lECE/uBY3e7GMuxPUXT4qvC6Rqk/xF7QlC0dDiTnkglftiWmU
 3xbajKpTDMHE2arQD9AGk+cvDjxUbkY1qjOKeESR9rOGIcU6l0pX6Sgi72gZdhRsNG0+
 QmwXdz/OBdyIjc53O3Vh3DesAEjWw5EM46gqTBs7PeL0qMk2ER2609oe8rEtUmmA/bKq
 ouGw==
X-Gm-Message-State: AOJu0YyZ9oN4h1dhyDRK/bPLjb2YRsNVu5jOOHw+QuPoB18QVsbhMIIX
 7BgELdndkkXAobfO9wpBYTNzBn9GwOxl28rlecrw9PIJxKe837DSYl+Mnx5/vQHw
X-Gm-Gg: ASbGncv5hVepxQ9mWPybeAGV3Nq5eeOPWb7i5uBMHo6GO7CB3TPEjnTrZZSGQtY5YlV
 y6sqkZBKXMaUUBf0cvNrjiYdvYMkB9937+5jFfu/JD7t3i2xJVMbTmTH/yRosrKdN3dEdJNO2l8
 0YbwMwR68+y31Giji3lbrYjtX2hUImw3MOI768Zv4hrUtWeK6yAhgySVxlsZw4nqXrgjON4VWJT
 gYh7OF0kgfEqHxQwfqWvjiM7p7UC0evjs6DvxZDCYoMwnPZSQB9kK+b5gCvWsCwSKx1I7RZUjQ0
 RlVjycNbb3UaYldz5cP+95YkkONCyLsl/IeDPfniZ2EeFuIxE6aQB+kJ+hR8+ZCBZMqYGRdSOA/
 wKqb93si8V6E0y8oN69MU2ELjk1/iDYgWWSeBDT7cjPa+VzLZ2aK5JengnCfD5qkJUN9k/FlXPX
 aPetKz1Q==
X-Google-Smtp-Source: AGHT+IEug3mvC3XU2+Tz/pgKKF/Llhg8BwQFCZke+qx8HoipGGp3dec35LZuGHq4ZDp++DKj0B8pgQ==
X-Received: by 2002:a05:6870:c69a:b0:321:7bd4:963d with SMTP id
 586e51a60fabf-32e54774d69mr4906171fac.14.1757847685535; 
 Sun, 14 Sep 2025 04:01:25 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d32d56557sm2612720fac.1.2025.09.14.04.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Sep 2025 04:01:25 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 al.kochet@gmail.com, paul.henrys_ext@softathome.com, bb@ti.com,
 y.moog@phytec.de, w.egorov@phytec.de, francesco.dolcini@toradex.com,
 ggiordano@phytec.com, n-francis@ti.com, afd@ti.com, d.schultz@phytec.de,
 d-gole@ti.com, ravi@prevas.dk, carlos.lopezr4096@gmail.com,
 quentin.schulz@cherry.de, alice.guo@nxp.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 6/7] test: Add test case for FIT image load address overlap
 detection
Date: Sun, 14 Sep 2025 10:59:31 +0000
Message-ID: <20250914110021.4103-7-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914110021.4103-1-aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Sep 2025 15:13:36 +0200
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

Add a new test case to verify that mkimage properly detects and reports
memory region overlaps in FIT image configurations.

The test creates a FIT image with kernel and FDT components that have
the same load address (0x40000), which should trigger the overlap
detection logic and cause mkimage to fail with an appropriate error
message.

Test verifies:
- mkimage returns non-zero exit code when overlap is detected
- Error message contains "Error: Overlap detected:"
- Error message identifies the specific overlapping components
  (kernel@1 and fdt@1)

This test ensures the overlap detection feature works correctly and
prevents deployment of FIT images with conflicting memory layouts
that could cause runtime failures.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit_mkimage_validate.py | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/test/py/tests/test_fit_mkimage_validate.py b/test/py/tests/test_fit_mkimage_validate.py
index 170b2a8cbbb..27299a58f33 100644
--- a/test/py/tests/test_fit_mkimage_validate.py
+++ b/test/py/tests/test_fit_mkimage_validate.py
@@ -103,3 +103,68 @@ def test_fit_invalid_default_config(ubman):
 
     assert result.returncode != 0, "mkimage should fail due to missing default config"
     assert re.search(r"Default configuration '.*' not found under /configurations", result.stderr)
+
+def test_fit_load_addr_overlap(ubman):
+    """Test that mkimage fails when load address overlap"""
+
+    its_fname = fit_util.make_fname(ubman, "invalid.its")
+    itb_fname = fit_util.make_fname(ubman, "invalid.itb")
+    kernel = fit_util.make_kernel(ubman, 'kernel.bin', 'kernel')
+    fdt = fit_util.make_dtb(ubman, '''
+/dts-v1/;
+/ {
+    model = "Test FDT";
+    compatible = "test";
+};
+''', 'test')
+
+    # Write ITS with an invalid reference to a nonexistent default config
+    its_text = '''
+/dts-v1/;
+
+/ {
+    images {
+        kernel@1 {
+            description = "Test Kernel";
+            data = /incbin/("kernel.bin");
+            type = "kernel";
+            arch = "sandbox";
+            os = "linux";
+            compression = "none";
+            load = <0x40000>;
+            entry = <0x40000>;
+        };
+        fdt@1 {
+            description = "Test FDT";
+            data = /incbin/("test.dtb");
+            type = "flat_dt";
+            arch = "sandbox";
+            os = "linux";
+            compression = "none";
+            load = <0x40000>;
+            entry = <0x40000>;
+        };
+    };
+
+    configurations {
+        default = "conf@1";
+        conf@1 {
+            kernel = "kernel@1";
+            fdt = "fdt@1";
+        };
+    };
+};
+'''
+
+    with open(its_fname, 'w') as f:
+        f.write(its_text)
+
+    mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+    cmd = [mkimage, '-f', its_fname, itb_fname]
+
+    result = subprocess.run(cmd, capture_output=True, text=True)
+
+    assert result.returncode != 0, "mkimage should fail due to memory overlap"
+    assert "Error: Overlap detected:" in result.stderr
+    # Check that it identifies the specific overlapping components
+    assert "kernel@1" in result.stderr and "fdt@1" in result.stderr
-- 
2.43.0

