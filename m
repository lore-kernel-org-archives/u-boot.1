Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11480C55165
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 00:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC2CD40ED6;
	Fri, 31 Jul 2026 00:15:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FdtufjW80niW; Fri, 31 Jul 2026 00:15:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12E5540E9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785456956;
	bh=/oNxMMs5Dzp9v8jqRiuXpPw37nkuavBimaEU1+qciJE=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=g4Cgt1OhQ1n72XAWtcCWaBu6Z0zW7CBFrmpN3OQUZhvc2o5oi5Nlf9InHhYFpBanm
	 7G0dQLw/gvLY6eewUSsZCjGky9PKrn9oCOmfjIXcmJDpeXT/hglxAzcV7MGTm/0TCD
	 IRaXA73A2FPNFFlaS66ohgZ9J1Px3FUBsY4xyMz1nG07846971Lli5vuDcHNYsTOnD
	 48I/rkoUHI6ZVSC52SbuIbKKXR32mmXn9DKvA0tQokI8rgFrIYDnUPEvWPEb9R5lo0
	 yymtCVke/DWMJGkPvsd7oYIeCv8SZgbzM9VuX1DG5PJlbok6ImCFcbE6JM4Mal6TFW
	 PL4+GRn0ezAHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12E5540E9E;
	Fri, 31 Jul 2026 00:15:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 73A6B218
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:15:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6515A80D06
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:15:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A4DFTRWnHZmq for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 00:15:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 22A0880CF1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22A0880CF1
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 22A0880CF1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:59 +0000 (UTC)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4BB593FBFD
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:58 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84865f326efso377741b3a.0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 17:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785456897; x=1786061697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/oNxMMs5Dzp9v8jqRiuXpPw37nkuavBimaEU1+qciJE=;
 b=Z+tCLJ3KVjLqtiU3VDiXyauLzhCXcDiyxTN9i5MdPgY6kjEuh0qX0j0rWq7Az7Kx7O
 h+a064ni3J5HsrGyV/DEBRld8GGwyERXJEeBSf5rnVGAVxTuBEI4nUe3TV7NP/WYn8d+
 2NDj3OUI3s+6emeBmMymmtwx1ROwrQ1DAHMp8t1cQ8Come59nJNm6mkOY5n9KFUy8PcM
 lAXGPKzfoI5EPZ37vdERtcca/ZI5OA/oGB1NC4a2VYh3nR8BTB7rlAQQNnc3kjJz9j8l
 l9+XodObAOWGarEWfv+SSHgRpoHzOarvzaUm+xltfVLko5BgeSJ8e5FQiTQ/TJTxAmIF
 eFdg==
X-Gm-Message-State: AOJu0YwkyS3TFeCLL4ZZAcddYIUt0RftppvKAxVO1oVzGrX7s164wICF
 zg8wLTsWytbQ2ME+Na9lkcUtZfaYTXbyQ5XQEkzzfRY3a/xKoIDRxvUbL8bg98gHonPDE5rjrf/
 MHw9KUU0Qv5+hZZyeTDGPrZvgdOP+2I343cBapyyd8/qfjAryKcJkG6GTw+q3ZujAEzgaQ64ZBB
 NBkE4p4Jj9hA==
X-Gm-Gg: AR+sD13Y2xm836/8oQvPmhZsFd6AhxL6PIyXoTts44naPBhoAwp3zHCMvhC+Qtial4J
 j2EwsTEzfvK0r44PzA/LNv8KlsacyhnXh1q5I+l6fx4h+KwEsZ+7E3ZxCz7/baVq/tQMFots8hu
 Y1weGY2JyU1KzSR63FVIndPBvPCU5YwTnIk/d5na9J5i6jx5sYnrZkli3qGmddNwSUYRV3Cj9Ii
 VTaFMrr2/xOKrcDTQCR9XAYWJcxH/z3+ZoGBiK7yAFF/lr4Hoaz46DMKiURYVMjnmoyJSrCFSww
 52RJsN7qn/H7rGbuRS8WE2xWd09QxIUy6lwtX0bKNgfFFzDpyARahpDRtRBlI/7QaJHBT5ax8L6
 ACmvzj38ZXg67fLDtfqYn94YCjdR8xYSX+q5Q6DRJjX2URttv4miL1wSBTGJV1/wDKYLZCA==
X-Received: by 2002:a05:6a00:2182:b0:847:9188:e492 with SMTP id
 d2e1a72fcca58-84ebc213820mr4267549b3a.22.1785456896644; 
 Thu, 30 Jul 2026 17:14:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:2182:b0:847:9188:e492 with SMTP id
 d2e1a72fcca58-84ebc213820mr4267535b3a.22.1785456896200; 
 Thu, 30 Jul 2026 17:14:56 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea02f8461sm3695718b3a.28.2026.07.30.17.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:14:55 -0700 (PDT)
To: u-boot@lists.denx.de
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org,
 nm@ti.com, bb@ti.com, n-francis@ti.com, d-gole@ti.com, e@freeshell.de,
 jonas@kwiboo.se, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v4 6/7] test: fit: cover mkimage load address overlap detection
Date: Fri, 31 Jul 2026 00:13:40 +0000
Message-ID: <20260731001347.35624-7-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731001347.35624-1-aristo.chen@canonical.com>
References: <20260731001347.35624-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jul 2026 00:15:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785456898;
 bh=/oNxMMs5Dzp9v8jqRiuXpPw37nkuavBimaEU1+qciJE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=WaFOgsF5UmZP0Ok4Q/LLd0v0N5PIiCiPQxhFgz2LRml0Y9WCQMT5TQGb6nvyd07ml
 sVHk9wjcdjh3uBOPJEyLf0f5+x1Hy7+Ycs7Sfw/Mc5vR92U1OgOj5hRxwo2RsiGccx
 HWMQhZDpRgobX5gxxWpGmjUGs9m6ZfPUl2D2gettOHA/hEkhx19l6pn9Tg8PvCD1Uo
 1CgDPzDJKUhcjJpcaGc38PxjvfRQt/MTlWXVxXtx3RRSypH959DKV1VEKzwe2XlqlW
 xlQJc9Aznf7h+sllnnB5hokFFYTXwrFimAcHOFBAvNG1Ea8zlhr+VVSz3vE599Jxef
 YQ0HQhdughvmQ1e7GKA5zfDCrVy7KmeMNNMXxO4DuQDrafu3JSBqcHrKqOWZxQe/wz
 wM7PkKRUtK5j7aaAMd0ZTdPduuf37ucdKGN5h59v4npbIRIkz9io8PJnYjg2mITElU
 oqWanFD+axemcd8g9G46icArUfEGMzPr8Udg2ZlHJuQYwCYnPBtpPlEw429/dawbJe
 bliTes/Wkh5juln0ijNorl5dwa1u0u9ivl5b2KTEQ9+1tr6KmHHP7QjTh0E8tcdCTi
 2iIBX+v6oMqPZBDWEprRdsxWfnlX3shsb9W6IF520CpzPf1FJ2jOgSmzQYqlpOSUPF
 j6PX7NDqqdEybgbpruMXifmQ=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=WaFOgsF5
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
 test/py/tests/test_fit_mkimage_validate.py | 136 +++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/test/py/tests/test_fit_mkimage_validate.py b/test/py/tests/test_fit_mkimage_validate.py
index 5922f071dd8..7c9213b2796 100644
--- a/test/py/tests/test_fit_mkimage_validate.py
+++ b/test/py/tests/test_fit_mkimage_validate.py
@@ -160,3 +160,139 @@ def test_fit_auto_basename_dotted_directory(ubman, dtb_relpath, expected_desc):
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
+    # Check that it identifies the configuration and the specific
+    # overlapping components
+    assert "conf@1" in result.stderr
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

