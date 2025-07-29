Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487C6C87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:11:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E80E38313F;
	Wed, 30 Jul 2025 07:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ux81v9jl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E8A482BCD; Tue, 29 Jul 2025 14:51:33 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4387982063
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 14:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aec5a714ae9so809392866b.3
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 05:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753793490; x=1754398290; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJMieX5OQv7o0ma5M4ETmr16p62GTM3QAVrJPgdsSKE=;
 b=Ux81v9jlYCxSkQsPoYNO+5cFcKGubtCyBBgFwKcfQgAyj2bjh9J61Cv27B3lVEQogN
 83J7aVx8bFw19CzGv5KizbaqjlYAihPQfAlIr5JjdFAuPEwHe6Uc+Wfzo/qF/2hcpPlh
 g9qQrI0qbREBWPgPUYbxFpiWyZA9x/d+Qh5CRN4/wJeSJVyVCUtPuOodfS2260t8TuIZ
 CqgGhIuqeugwJXrqKMI33xBawkWANVc4iAJ9RUSAvWynh4hWQNFlixpSp0cfdJy6UQRf
 2ceehvXtibZfYGYI+rR8iRla4z5JuOQaUjm4wUb7gOqokU96lKXiBh6Dq0d361f+rfjO
 sCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753793490; x=1754398290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TJMieX5OQv7o0ma5M4ETmr16p62GTM3QAVrJPgdsSKE=;
 b=HfQ2MoKoK30r/EU6IBD5tVW1BAvFqSF3x127F7YjxbQx/vWjy0IEnXceex11UIwlZL
 992j58v8Jjud6MC986nfNhmob+IAJ6a9CSSrL4SusUArj4XYMsK4BlNxEvh4KxqZVMyj
 gpjWJAmTclN4pfww41dsOEsjhVIEBVBhikQlip+pfmrk/7/4aYjT5foCtR4vWTRIiTvN
 N3TNZrGaNNd0nSN46mEXxqsAX2Vh4MR5OMsZz1lNAtk5neQeIHD2hMFx2qwkjiwZZJSj
 LX6dFKlZynRoAvGbX/twMEBgGQtCCu4lCGpbARkEdJV7TGIvZ2aXofU54ijooQOd+DOs
 a8ow==
X-Gm-Message-State: AOJu0YzAi+D4l5ZIozMMYWFD5S3jDnB6W1mnhTufvoY8Iy8TQ+9bW1zp
 qhmFJiQpEh3OxvfsVu9pggmaWhnUyuOSerqcUJsYQXcdgp+8QlQxjATLdIJtU0Z1
X-Gm-Gg: ASbGncsR93p8tUn/e4uMb9V+QUk8eYzqsmO1lajr7Q0gC2Vh9DQwFAfgoeDtRqWHA8O
 P23S2skWZrRcR6DvxQuYgqtHQsfa/rxg2DQLORJqBMXzJdqmJPM5RksqRMKAnhln+IFjzpzgO2t
 Ox5JLJM7RUYin91Wc58UGH6wGqcKeLT+9aesG6GlkwVUA9jnCuhX70Xm4xGR/L15SV9BuqzO91D
 BRJffC7vhFVJF3VQStNi0ROuP28HX6yXKGEIlA013JeMRq1GPrQKGglTE7Pc7Q6TgYGzq/Q1NmF
 sD+11oxOmPx1+wxUHl8GgZ3i+jRLvCLNBLLCbSIHBgtntYPzqG4Qbh0SepPNKrANOeakrvYD6XQ
 R2+OcgEHJ6I33S0K8UPzMx6UrcvsdAWzYByC1JKIK5hGlO5v0qwNddmzblvdYINUqUOYS4FM=
X-Google-Smtp-Source: AGHT+IHJDfHnWPn0n4op+E4gVybpckOvTInM6aB4Bn9LvGM7PQAzc1JuJ6ee6fmtjNK8eeAi+hX9LA==
X-Received: by 2002:a17:907:8691:b0:ae3:7113:d6f1 with SMTP id
 a640c23a62f3a-af61cf9830fmr1836084466b.25.1753793490354; 
 Tue, 29 Jul 2025 05:51:30 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635acc99esm572223366b.115.2025.07.29.05.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 05:51:30 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 al.kochet@gmail.com, paul.henrys_ext@softathome.com, bb@ti.com,
 y.moog@phytec.de, w.egorov@phytec.de, francesco.dolcini@toradex.com,
 ggiordano@phytec.com, n-francis@ti.com, afd@ti.com, d.schultz@phytec.de,
 d-gole@ti.com, ravi@prevas.dk, carlos.lopezr4096@gmail.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 5/5] test: Add test case for FIT image load address overlap
 detection
Date: Tue, 29 Jul 2025 12:48:56 +0000
Message-ID: <20250729125022.4220-6-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729125022.4220-1-aristo.chen@canonical.com>
References: <20250729125022.4220-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Jul 2025 07:10:08 +0200
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
index ef974c8c762..51f7f64b257 100644
--- a/test/py/tests/test_fit_mkimage_validate.py
+++ b/test/py/tests/test_fit_mkimage_validate.py
@@ -101,3 +101,68 @@ def test_fit_invalid_default_config(ubman):
 
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

