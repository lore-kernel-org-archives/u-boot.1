Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA92C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 15:55:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 944BF60863;
	Tue, 21 Jul 2026 15:55:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TYEoS17xslct; Tue, 21 Jul 2026 15:55:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 042876084A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784649339;
	bh=wYUaTPFopoy5UgVVNeSVJsW+15Bnnd0VrZt+Lj0AG7M=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=y1c1p3/u+YbFLTBtmaZ2h8Niz+V65m6eR4h934+8JiNQfH322FVU3UW40L6gCxOFk
	 qmMjcqgsL+A7BOc4b0nKfLOC9EDrjudbZw2oVqeZH4QuqKXIpX0U+woF5Q/XqgXJB/
	 haRjgyhEttWqN6KEU9R7ik0NQ4s7M44Nl1seESJortCLXdLiRxHwWBbKkVwjDnYEAZ
	 Ci1ka5fA6xQ8ZHGWHxiySO02xWrY8/x4+kUSJIrnMHjMyuT4F8fQgdY5dBUVimZ8aV
	 D32AJTDyo1uFnGDZmx3grpeK6nroPAj4xOPf+9QMDlMsbvd7YQaHo1kXN1wz8sSSyr
	 mI7lInafbT2+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 042876084A;
	Tue, 21 Jul 2026 15:55:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 569DE109F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:21:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4864F80DFB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:21:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hD323RAf1v6D for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 15:21:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E330180D91
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E330180D91
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E330180D91
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:21:42 +0000 (UTC)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 449983F982
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:21:41 +0000 (UTC)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cea6a46766so176721945ad.0
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784647300; x=1785252100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wYUaTPFopoy5UgVVNeSVJsW+15Bnnd0VrZt+Lj0AG7M=;
 b=Pzb50wl/f+ox8qjXVO5LNxD+2JlIIyrOU9z8N5NhgI+ISP3VLWoaVB1ljJF9vo/+aG
 HPTBiLkg5rnGMan5q/xG4x9yYOkO52dXNpJffNDwjDlo4lrWa3QStiDJr6zUiVE7m3yu
 n6S3jlb5FuBZ5AFAJbFUWR14IlRhfQmcFT0xUr67jB8xj986HSw0AsFS2f9a69PL06A3
 xR6GGIbVy189+E8kRh6KxnZTgwB84GR72GIar/YXXhC1XdQIntmig2X3wDFyOWpE9LZD
 pE1mCB8SYCDdbAUBYFKXQME66VlaIN1O0nM3vO6ztq2eTEMG3QAxhcqSV6igeYs8gKfX
 renA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOk5BNiC0IE9n2Vcc6fH/KUbZ+igJtw6Ucmh3oM6P5M96j69SUI9l3p1iUXo5YpVDu1LPUMso=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw1OFUAJbPaXX2iwKYbLJSKrvUuZly4dZWR2uda7xOaykzmqCtU
 Xh7v77WasHcNk7BNFsWQWRcjxmWPHXkfxNV6schbc9UBBhFNNK4xuP99vyMFI2JTgAFnNX2ev2J
 rY+PZ2vjs0jH7TX9cdOWwchdxIiKUawvTtiJ6oPFe4m39uIivN3QC/Y7gKPycvHpirRQCHLbgTA
 WsBBgopzPTfyMngUMO6g==
X-Gm-Gg: AR+sD10xbLUmfYuaWtrNu3Djqv2psQFeisBxh/bdV36U2R+IoNxykVPxcWDjmKpVc+s
 fexBnl/MS/pah9YGkTZXfSqj4IX2kxSXrVyS5VRI3y8WtsOpMxghUGOm4URYoKKVPLHNdYTU7K5
 GZYbYkoQ6Ku4YN1AXofoyOKhvtnh45mDvSefpvi9N+peQkeT4dY2TxSbbmSNcAogH/L14/4v7Dk
 l/ca7Addlj9XOwspadfvfK0T374hYxKI8jHHBPIQbsneaYIcNCMCgZ1BLfj93nNMAXrAzEsNGvF
 ax2w3ter4Z6DbZGYYmG/fP9ky3E16mV+pXx/RK1ZIk8V0jnSE0AEVigsshgymuR13uttBongm9v
 1ksybSpJWLLjN/ktxnp6alo7INMgXYfEixichB2Xufer6a8XceElon0Alo0zTAC9k8nA=
X-Received: by 2002:a17:903:18d:b0:2ca:619f:9733 with SMTP id
 d9443c01a7336-2cf348f9f5amr213112665ad.17.1784647299529; 
 Tue, 21 Jul 2026 08:21:39 -0700 (PDT)
X-Received: by 2002:a17:903:18d:b0:2ca:619f:9733 with SMTP id
 d9443c01a7336-2cf348f9f5amr213112305ad.17.1784647298982; 
 Tue, 21 Jul 2026 08:21:38 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf347119dfsm77733775ad.56.2026.07.21.08.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 08:21:38 -0700 (PDT)
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 6/7] test: fit: cover mkimage load address overlap detection
Date: Tue, 21 Jul 2026 15:21:05 +0000
Message-ID: <20260721152110.283998-7-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721152110.283998-1-aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20260721152110.283998-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 15:55:37 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1784647301;
 bh=wYUaTPFopoy5UgVVNeSVJsW+15Bnnd0VrZt+Lj0AG7M=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=LIEEcCEd5/dweB1Qt5YvUsXY5kwGUm7OT3vE7JgohAbsE5OvnbjfzzxWv9VEnXNT4
 ygT1+eXPxU6025xYadqM2UqHAy2qNumaen4iJglqVMkyJ592tnaynPkJf0vZ5OJL/S
 7WCsExZOq64ncqzh/tUCpbzfE2xY7+BPXi5d0Q2OjoobK2Dwj5GZFN7/rrA6pw1yKJ
 +N995YFD17FcDew4knFgwE+bMx6oO6ao/j40mzhXJkqYAn5t5kuBWc6x55PauSLGQW
 3YENcPVqXnVEC5H0uQtc5yrZ/V6P5FPRQhykA9da+ixUSyKL12UJ3PIbwj/B+WUgrk
 PovdzGHHjm1vIU0+LjFr0JARI2h4bo7NZva5CSwIEGA+30z5ZkaSjuPZ/SnIqjhPje
 aT/9V41C8+kDsuhFyHce/TwclUW1g9lYBgtMbBQv4DUv6z3Fca0JI6rQb+1B5XYGyT
 7QfKeQnyiLo1UZ29HBCmHP2pB/3vN5AQ6CKriH12aG5e3rIY+SCFNDf5K9waVxTLDW
 lDGuyuGtcN7NwlrjBXmMQAvqGmJIIHhfjeY2dojh+yM4PZoV7UIUAITD8gr1z7oZcx
 BcIRJx02Z7N41IZscDkB6wA8qggxCFr8H0BQEGx1EeP+XM9ZLmU3l06KXxCQ5yobHj
 jFhyzyhT0MjSiMXoIHtXbua8=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=LIEEcCEd
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a test that mkimage rejects a FIT image whose configuration
references a kernel and an FDT with the same load address, and that
the error message names the offending configuration and images.

Also add a companion test for the intended escape hatch: two images
may use the same load address as long as no single configuration
references both of them. Only one configuration is selected at
runtime, so such images never coexist in memory. This mirrors the TI
K3 tispl layout after commit c85bf61b14f9 ("arm: k3: select tifsstub
via board_fit_config_name_match"), where each security state has its
own configuration and all tifsstub variants share one load address.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit_mkimage_validate.py | 134 +++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/test/py/tests/test_fit_mkimage_validate.py b/test/py/tests/test_fit_mkimage_validate.py
index 5922f071dd8..0475e89827b 100644
--- a/test/py/tests/test_fit_mkimage_validate.py
+++ b/test/py/tests/test_fit_mkimage_validate.py
@@ -160,3 +160,137 @@ def test_fit_auto_basename_dotted_directory(ubman, dtb_relpath, expected_desc):
     assert desc == expected_desc, (
         f"Expected /images/fdt-1 description {expected_desc!r}, got {desc!r}"
     )
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.requiredtool('dtc')
+def test_fit_load_addr_overlap(ubman):
+    """Test that mkimage fails when images in one config overlap in memory"""
+
+    its_fname = fit_util.make_fname(ubman, "overlap.its")
+    itb_fname = fit_util.make_fname(ubman, "overlap.itb")
+    kernel = fit_util.make_kernel(ubman, 'kernel.bin', 'kernel')
+    fdt = fit_util.make_dtb(ubman, '''
+/dts-v1/;
+/ {
+    model = "Test FDT";
+    compatible = "test";
+};
+''', 'test')
+
+    # Write ITS with kernel and FDT sharing the same load address
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
+    assert "has overlapping load regions" in result.stderr
+    # Check that it identifies the specific overlapping components
+    assert "kernel@1" in result.stderr and "fdt@1" in result.stderr
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.requiredtool('dtc')
+def test_fit_same_load_addr_different_configs(ubman):
+    """Test that images may share a load address across configurations
+
+    Only one configuration is selected at runtime, so images that are
+    referenced by different configurations never coexist in memory. This
+    mirrors the TI K3 tispl layout, where each security state has its own
+    configuration and all tifsstub variants use the same load address.
+    """
+
+    its_fname = fit_util.make_fname(ubman, "exclusive.its")
+    itb_fname = fit_util.make_fname(ubman, "exclusive.itb")
+    kernel = fit_util.make_kernel(ubman, 'kernel.bin', 'kernel')
+
+    its_text = '''
+/dts-v1/;
+
+/ {
+    images {
+        kernel@1 {
+            description = "Test Kernel HS";
+            data = /incbin/("kernel.bin");
+            type = "kernel";
+            arch = "sandbox";
+            os = "linux";
+            compression = "none";
+            load = <0x40000>;
+            entry = <0x40000>;
+        };
+        kernel@2 {
+            description = "Test Kernel GP";
+            data = /incbin/("kernel.bin");
+            type = "kernel";
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
+        };
+        conf@2 {
+            kernel = "kernel@2";
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
+    assert result.returncode == 0, (
+        f"mkimage should accept same load address in different configs:\n"
+        f"stderr:\n{result.stderr}"
+    )
-- 
2.43.0

