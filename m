Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC7A606A330
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MgqLwKGO;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kSRo/qqT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 193D0810F4;
	Mon,  9 Nov 2026 21:49:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0eRd3EQ2KIce; Mon,  9 Nov 2026 21:49:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2D09081090
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794260947;
	b=HbrdLVMWgss/NG3y7rKwT4kXSImA0u8NU23EQ2iiyYpNSCNM2/slEe9K8AkZiReOTkbD
	 cxhGlrT1Y7SWz8V2lrPqphlXeOgl0QGw8jfe8x7JodMdh8UCIGWO0Lux286I0Rfjbb2yb
	 7/0SU39TnTLvCO25yLszcxNOmR9SgeRM7wKEMX/cLaUDPKsHdsqhbXHeW5hWLPCyEo7Fx
	 0pYPyCqDeHW9i5c6Xbz/mLnxULFRNH3CtRyk24puBx3bVrLGfkk/UFllwmTS7ybyhift+
	 N5ahyKVRXT0vDskmHLBnTLDI5+uxY7BhaGSaPJTqbqbIWXEDrIgbgej9ev25/D48nUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794260947;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=usERRWjOvoVZREsspUrvDdqmtcGmEIBsJCdg88ejgnA=;
	b=Rhseu81BWO3dLQgnZ+tkLeTxx9Ap3naWyfbiL/kUtpTJjXjUqrfb8bZkqhDVoZoBPfss
	 HeI/QlZFkOv2llo1VpknbE5PnTeYFSYcubyowWP23TZ6CrN1Wtjxur/MMKe41RxjQyNeg
	 lQ1DR/bBURSUvwjtVEXXYT5ZeC4yrpc8u1A20M7X3NqRE6tfWGSCjbrgfiUAd5wuIhe8a
	 a3lkSooXiHqtMU1vb5IM5/0hr/2pi4sPJS6fLDEMlw0X39kDWfnwPlq5CQcS7eibsZ6Hs
	 5C7b7bG5LhgVqVKybbz7aZlhh2Avgt0oHilHzbMwe/I/Kd0zp96D0aJ0aWuWx4o8vRA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794260947;
	bh=usERRWjOvoVZREsspUrvDdqmtcGmEIBsJCdg88ejgnA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MgqLwKGOuvybr1s/LM8IOyANIhnnrBaL3FDQWHQ2+6a0RLi6MOOK5jM4r8PYuqGV5
	 5MsFDVQ7K7KfEZXEndJDqFjGl13pVecjawACB4dDQwASRDGc5ZXvWr78w9KQUhzqcW
	 xzgFdlS3xnoJQHakX/7KeRKLVmUvYsLqXm+4IXxKdQ2Aos0P1rAVewJlhZmFyTinwJ
	 7RCuSubU8bqe9PBGnCS2pFn9fxZEYJLKGniCheqFEaanTKW/sl/NTwvlxxBYs1l87q
	 FvLtTCSAA5nahjOUZxJQw+1rPmiOAkE27n3Bdwzkk4Gea4xmshqWyArVxx3zt6IH1A
	 FnWsdZH5XnCNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D09081090;
	Mon,  9 Nov 2026 21:49:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 007F2CC4
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:49:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F23AC6070F
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:49:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FWZpuQvJdCId for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 21:49:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7573D606F2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kSRo/qqT
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7573D606F2
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:49:03 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so882823f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 13:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794260941; x=1794865741;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=usERRWjOvoVZREsspUrvDdqmtcGmEIBsJCdg88ejgnA=;
 b=kSRo/qqTzfN9F2Xv/hjYWRwbNNUyVDVVovskawLgf/3H1O93a0WV/ujcBIyLpYyPxr
 idHDld8bQIpKTCeU4Dd+vI0xn0WalFctkOy3SfesyFmgiOnF1GvvLfz3JWrWIhdbN6xK
 VWSZtzJchRqBj273DaJaW3UtkKQSZGxVCxfWh8ucGMr3ERoyDUP9BbXZ/ScIufm7MYdJ
 nDrpDm2c39XizXUpyYP/L9sm9xbQ+t4jkoJWXkUX+9VPvpHCsaa+nZK99cseMl5kuYNq
 mZ3VtX1g6leGCmYm+xJg7lB60E4xjDJQijveT1gtoR53+G9RAkrOdv6ZSj13SRXE3cDD
 wanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794260941; x=1794865741;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=usERRWjOvoVZREsspUrvDdqmtcGmEIBsJCdg88ejgnA=;
 b=uqP+U7cWyGLY4ZkdMfOyXfHBMJ+NqBbKl6OzOokTOGzfsKbcveAi9RdeV7FeO9UQt+
 Ro18/CvScsDjs/CZ0qSdjsGn2c9oIJBcDY4Go2G5LJLLnG9we6xD7YjGJp4H6Thr56Xi
 YEylWpxbjkR2gq+NQjSc5n//i0FYZRsXRqMDL6mB6jGeUOA1j2oeS6c435Ie4NjXURRR
 /c+I/wqzN1unIrq1zHKwr7LfZZKTZ3nb8kuTqmGOWw6cXBYLyyzoVgPyieqf6N41wgLa
 4K8yrG7Wr6T8G7ldoS08H9CkSSPYEpCp7ZEAQDACbXBUC7SdPdLZ/12I8AgtkSH6emGk
 RjWA==
X-Forwarded-Encrypted: i=1;
 AL+hErEiX62TqhFwTEOv9wAKiln59DRPcAeykYVZQQEou/h55YI+w2qqqms6hUp4djAKcDyMJVzt1L0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8JMkuBO0ui3M9sRKbnmEnLxOKdnx0OEVlKw8m9OL30dB98sDcK
 acduZeeu4gXam+9yy6SEX1YKE38nU5xWra5qXlI+bT4vdubiLnx5EOBqbUFM5EsctVg=
X-Gm-Gg: AYBFou2V6IMCqQfIEnt0fxV8cMCrV8lBSW7Iw9VwsJXaEBdAOh/JRu4GQN+opW4TrQR
 WJs3Kh8hCAPupO055PWHXuPvPiDliatTws6I152NErMTJ3Oq9ZFfH7xzlHSu6v7FsBMSb7Rs0+G
 rp45jKSBvceJLwAGUi7eDj5kqWfLcEXvF4Vd5U3Pdv2GrxbcMV64nXyf7wO4hTHEx11e1iBGRHE
 bw6V1ukgIy/SP0EgxGn9NCQodXnK9ZLPTRhBH5PvIZpOu4B/Th3ioH3Y7cMM8Qq7qzJX9qAqkwr
 Q0PO5ks/dE19uS+LqMUEiyR/ecIAAhNFZV9HFKbcHsONIU+MhTcecRpOL+yEldW4swLH+O6gTcA
 KFvyyz8mJ8So7kHsDOAU9yVsDCJKDZU+fCjgCdD/QzkzPC9B2jDG0nUoaUiH8cdFBB7xQosTxlh
 3OmU7/MVWqfsHNx02cPIAXR3LmhwvJW77hLtVIgwwivcjKYAwuX9XzLzuonvBBjlNhdu5Rxxepi
 foFtbB0jrbWuBCOj8b+80jYEPOhsydntE3SIVL7ZIgZ4aQaok+iaukbTa2qfCW0E4IeangYr+F0
 FbIWXd2i3ZWk4pmh+dOlaKFoABXBgH1pFv6JvDXFYCX4RPeb27yHUOVJLnA2DnmXxuUugE/Vgtl
 8j5OCYCJD4F5Yqfn596UbsGMuhGrAku3rHD2HN4A=
X-Received: by 2002:a05:6000:240b:b0:48e:2bdc:5e5e with SMTP id
 ffacd0b85a97d-4982f1befc5mr1219882f8f.29.1794260941178; 
 Mon, 09 Nov 2026 13:49:01 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835f1772dsm1169903f8f.31.2026.11.09.13.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:49:00 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 09 Nov 2026 22:48:24 +0100
Subject: [PATCH v4 7/7] test: py: cover fdt fit preparation and failure
 handling
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-ccaione-upstream-fdt-fit-v4-7-5323cbfcc9f3@baylibre.com>
References: <20261109-ccaione-upstream-fdt-fit-v4-0-5323cbfcc9f3@baylibre.com>
In-Reply-To: <20261109-ccaione-upstream-fdt-fit-v4-0-5323cbfcc9f3@baylibre.com>
To: Julius Werner <jwerner@chromium.org>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Boot scripts rely on fdt fit either returning a complete, verified
devicetree or failing without touching the destination. Regressions
could otherwise leave a script with an incomplete tree or overwrite
memory before an error is reported.

Add sandbox coverage for successful preparation and failure cases,
including overlay order, compression and FIT load addresses. Check
that verify=no cannot bypass required signatures and that
individually signed configurations cannot be chained into a new
combination.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 configs/sandbox_defconfig     |   1 +
 test/py/tests/test_fdt_fit.py | 371 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 372 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index f307972a762..cd44c42d954 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -65,6 +65,7 @@ CONFIG_CMD_BOOTZ=y
 CONFIG_BOOTM_OPENRTOS=y
 CONFIG_BOOTM_OSE=y
 CONFIG_CMD_BOOTMENU=y
+CONFIG_CMD_FDT_FIT=y
 CONFIG_CMD_ASKENV=y
 CONFIG_CMD_GREPENV=y
 CONFIG_CMD_ERASEENV=y
diff --git a/test/py/tests/test_fdt_fit.py b/test/py/tests/test_fdt_fit.py
new file mode 100644
index 00000000000..3fe358f6abf
--- /dev/null
+++ b/test/py/tests/test_fdt_fit.py
@@ -0,0 +1,371 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 BayLibre SAS
+
+"""Test the 'fdt fit' command
+
+Build a FIT holding a base devicetree and two overlays, with configurations
+which combine them, then check the devicetree produced for each
+configuration and that images failing to load or verify are rejected.
+"""
+
+import gzip
+import os
+import shutil
+
+import pytest
+import fit_util
+import utils
+
+FIT_ADDR = 0x1000000
+DEST_ADDR = 0x2000000
+
+BASE_DTS = '''
+/dts-v1/;
+
+/ {
+	model = "fdt fit test";
+
+	test-node {
+		base-prop = "base-value";
+		order = "base";
+	};
+};
+'''
+
+OVERLAY_DTS = '''
+/dts-v1/;
+/plugin/;
+
+&{/test-node} {
+	%(name)s-prop = "%(name)s-value";
+	order = "%(name)s";
+};
+'''
+
+FDT_IMAGE = '''
+		%(name)s {
+			data = /incbin/("%(fname)s");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "%(compression)s";
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+'''
+
+CONFIG = '''
+		%(name)s {
+			fdt = %(fdt)s;
+			%(sig)s
+		};
+'''
+
+SIGNATURE = '''signature {
+				algo = "sha256,rsa2048";
+				key-name-hint = "dev";
+			};'''
+
+def make_test_fit(ubman, basename, sig, compress_base=False):
+    """Create a FIT with a base devicetree, two overlays and configurations
+
+    Args:
+        ubman (ConsoleBase): U-Boot console
+        basename (str): Base name of the FIT to create
+        sig (str): Signature node to add to each configuration, or ''
+        compress_base (bool): Compress the base devicetree with gzip
+
+    Returns:
+        str: Filename of the FIT
+    """
+    images = {'base': fit_util.make_dtb(ubman, BASE_DTS, 'fdt-fit-base')}
+    if compress_base:
+        compressed = images['base'] + '.gz'
+        with open(images['base'], 'rb') as inf, gzip.open(compressed, 'wb') as outf:
+            shutil.copyfileobj(inf, outf)
+        images['base'] = compressed
+    for name in ('ov-a', 'ov-b'):
+        images[name] = fit_util.make_dtb(ubman, OVERLAY_DTS % {'name': name},
+                                         f'fdt-fit-{name}')
+
+    configs = {
+        'conf-base': '"base"',
+        'conf-a': '"base", "ov-a"',
+        'conf-ab': '"base", "ov-a", "ov-b"',
+        'conf-b': '"ov-b"',
+    }
+
+    its = '/dts-v1/;\n\n/ {\n\tdescription = "fdt fit test";\n'
+    its += '\t#address-cells = <1>;\n\n\timages {'
+    for name, fname in images.items():
+        compression = 'gzip' if name == 'base' and compress_base else 'none'
+        its += FDT_IMAGE % {'name': name, 'fname': fname,
+                           'compression': compression}
+    its += '\t};\n\n\tconfigurations {\n\t\tdefault = "conf-base";\n'
+    for name, fdt in configs.items():
+        its += CONFIG % {'name': name, 'fdt': fdt, 'sig': sig}
+    its += '\t};\n};\n'
+
+    its_fname = fit_util.make_its(ubman, its, {}, f'{basename}.its')
+    fit = fit_util.make_fname(ubman, f'{basename}.fit')
+    mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+    utils.run_and_log(ubman, [mkimage, '-f', its_fname, fit])
+
+    return fit
+
+def corrupt_overlay(ubman, fit, basename):
+    """Copy a FIT, changing the data of the ov-b image but not its hash
+
+    Args:
+        ubman (ConsoleBase): U-Boot console
+        fit (str): Filename of the FIT to copy
+        basename (str): Base name of the copy
+
+    Returns:
+        str: Filename of the copy
+    """
+    with open(fit, 'rb') as inf:
+        data = inf.read()
+    assert data.count(b'ov-b-value') == 1
+    out = fit_util.make_fname(ubman, basename)
+    with open(out, 'wb') as outf:
+        outf.write(data.replace(b'ov-b-value', b'ov-b-evil!'))
+
+    return out
+
+def load_fit(ubman, fit):
+    """Load a file into memory at FIT_ADDR and clear the destination"""
+    output = ubman.run_command(f'host load hostfs - {FIT_ADDR:x} {fit}')
+    assert 'bytes read' in output
+    ubman.run_command(f'mw.l {DEST_ADDR:x} 0 400')
+
+def fdt_fit(ubman, args):
+    """Run 'fdt fit' and report whether it succeeded
+
+    Args:
+        ubman (ConsoleBase): U-Boot console
+        args (str): Arguments for the command
+
+    Returns:
+        tuple:
+            bool: True if the command succeeded
+            str: Command output
+    """
+    output = ubman.run_command(f'fdt fit {args}; echo rc=$?')
+    return output.rstrip().endswith('rc=0'), output
+
+def get_test_node(ubman):
+    """Return the test node of the devicetree at DEST_ADDR"""
+    ubman.run_command(f'fdt addr {DEST_ADDR:x}')
+    return ubman.run_command('fdt print /test-node')
+
+def check_dest_untouched(ubman, addr=DEST_ADDR):
+    """Check that nothing was written to a cleared destination"""
+    output = ubman.run_command(f'md.l {addr:x} 4')
+    assert '00000000 00000000 00000000 00000000' in output
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_fdt_fit')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtput')
+def test_fdt_fit(ubman):
+    """Test loading the devicetree of a FIT configuration"""
+    fit = make_test_fit(ubman, 'fdt-fit', '')
+
+    with ubman.log.section('Default configuration'):
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x} {DEST_ADDR:x}')
+        assert ok, output
+        assert "Using 'conf-base' configuration" in output
+        node = get_test_node(ubman)
+        assert 'base-prop = "base-value"' in node
+        assert 'ov-a-prop' not in node
+
+    with ubman.log.section('Overlays applied in order'):
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-ab {DEST_ADDR:x}')
+        assert ok, output
+        node = get_test_node(ubman)
+        assert 'base-prop = "base-value"' in node
+        assert 'ov-a-prop = "ov-a-value"' in node
+        assert 'ov-b-prop = "ov-b-value"' in node
+        assert 'order = "ov-b"' in node
+
+    with ubman.log.section('Chained configuration'):
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman,
+                             f'{FIT_ADDR:x}#conf-a#conf-b {DEST_ADDR:x}')
+        assert not ok
+        assert 'Chained configurations are not supported' in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Length'):
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-a {DEST_ADDR:x} 4000')
+        assert ok, output
+        ubman.run_command(f'fdt addr {DEST_ADDR:x}')
+        output = ubman.run_command('fdt header get size totalsize; echo $size')
+        assert output.splitlines()[-1] == '4000'
+
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-a {DEST_ADDR:x} 10')
+        assert not ok
+        assert 'aborting' in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Missing configuration'):
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-none {DEST_ADDR:x}')
+        assert not ok
+        assert "Could not find configuration node 'conf-none'" in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Corrupted overlay'):
+        bad_fit = corrupt_overlay(ubman, fit, 'fdt-fit-bad-overlay.fit')
+        load_fit(ubman, bad_fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-ab {DEST_ADDR:x}')
+        assert not ok
+        assert 'Bad hash value' in output
+        assert 'load of ov-b failed' in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Missing overlay'):
+        missing_fit = fit_util.make_fname(ubman, 'fdt-fit-missing.fit')
+        shutil.copyfile(fit, missing_fit)
+        utils.run_and_log(ubman, ['fdtput', '-t', 's', missing_fit,
+                                  '/configurations/conf-a', 'fdt', 'base',
+                                  'ov-missing'])
+        load_fit(ubman, missing_fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-a {DEST_ADDR:x}')
+        assert not ok
+        assert 'load of ov-missing failed' in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Not a FIT'):
+        load_fit(ubman, fit_util.make_fname(ubman, 'fdt-fit-base.dtb'))
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x} {DEST_ADDR:x}')
+        assert not ok
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Usage'):
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}')
+        assert not ok
+        assert 'Usage:' in output
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_fdt_fit')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtput')
+@pytest.mark.parametrize('compress_base', [False, True])
+def test_fdt_fit_load_addr(ubman, compress_base):
+    """Ignore FIT load addresses, including before an overlay failure"""
+    if compress_base and not ubman.config.buildconfig.get('config_gzip'):
+        pytest.skip('gzip support not enabled')
+
+    fit = make_test_fit(ubman, 'fdt-fit-load', '', compress_base)
+    utils.run_and_log(ubman, ['fdtput', '-t', 'x', fit, '/images/base',
+                              'load', f'{DEST_ADDR:x}'])
+
+    with ubman.log.section('Load address equals destination, bad overlay'):
+        bad_fit = corrupt_overlay(ubman, fit, 'fdt-fit-load-bad.fit')
+        load_fit(ubman, bad_fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-ab {DEST_ADDR:x}')
+        assert not ok
+        assert 'load of ov-b failed' in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Load address equals destination, short length'):
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-base {DEST_ADDR:x} 10')
+        assert not ok
+        assert 'aborting' in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Only the requested destination is written'):
+        load_addr = 0x3000000
+        utils.run_and_log(ubman, ['fdtput', '-t', 'x', fit, '/images/base',
+                                  'load', f'{load_addr:x}'])
+        for conf in ('conf-base', 'conf-ab'):
+            load_fit(ubman, fit)
+            ubman.run_command(f'mw.l {load_addr:x} 0 400')
+            ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#{conf} {DEST_ADDR:x}')
+            assert ok, output
+            node = get_test_node(ubman)
+            assert 'base-prop = "base-value"' in node
+            order = 'base' if conf == 'conf-base' else 'ov-b'
+            assert f'order = "{order}"' in node
+            check_dest_untouched(ubman, load_addr)
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_fdt_fit')
+@pytest.mark.buildconfigspec('fit_signature')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('openssl')
+def test_fdt_fit_signed(ubman):
+    """Test 'fdt fit' with a required configuration signature
+
+    This restarts U-Boot with a control devicetree holding the public key,
+    so it must run on sandbox.
+    """
+    keydir = fit_util.make_fname(ubman, 'fdt-fit-keys')
+    os.makedirs(keydir, exist_ok=True)
+    key = os.path.join(keydir, 'dev')
+    utils.run_and_log(ubman, f'openssl genpkey -algorithm RSA -out {key}.key '
+                      '-pkeyopt rsa_keygen_bits:2048 '
+                      '-pkeyopt rsa_keygen_pubexp:65537')
+    utils.run_and_log(ubman, f'openssl req -batch -new -x509 -key {key}.key '
+                      f'-out {key}.crt')
+
+    vboot_dts = os.path.join(ubman.config.source_dir,
+                             'test/py/tests/vboot/sandbox-u-boot.dts')
+    dtb = fit_util.make_fname(ubman, 'fdt-fit-u-boot.dtb')
+    utils.run_and_log(ubman, ['dtc', vboot_dts, '-O', 'dtb', '-o', dtb])
+
+    unsigned_fit = make_test_fit(ubman, 'fdt-fit-unsigned', '')
+    fit = make_test_fit(ubman, 'fdt-fit-signed', SIGNATURE)
+    mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+    utils.run_and_log(ubman, [mkimage, '-F', '-k', keydir, '-K', dtb, '-r',
+                              fit])
+    bad_fit = corrupt_overlay(ubman, fit, 'fdt-fit-signed-bad-overlay.fit')
+
+    old_dtb = ubman.config.dtb
+    try:
+        ubman.config.dtb = dtb
+        ubman.restart_uboot()
+        ubman.run_command('setenv verify no')
+
+        with ubman.log.section('Signed configuration'):
+            load_fit(ubman, fit)
+            ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-ab {DEST_ADDR:x}')
+            assert ok, output
+            assert 'sha256,rsa2048:dev+' in output
+            node = get_test_node(ubman)
+            assert 'order = "ov-b"' in node
+
+        with ubman.log.section('Chained signed configurations'):
+            # Each is signed, but no configuration lists base plus only ov-b
+            for first in ('conf-a', 'conf-base'):
+                load_fit(ubman, fit)
+                ok, output = fdt_fit(ubman,
+                                     f'{FIT_ADDR:x}#{first}#conf-b {DEST_ADDR:x}')
+                assert not ok
+                assert 'Chained configurations are not supported' in output
+                assert 'dev+' not in output
+                check_dest_untouched(ubman)
+
+        with ubman.log.section('Unsigned configuration'):
+            load_fit(ubman, unsigned_fit)
+            ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-ab {DEST_ADDR:x}')
+            assert not ok
+            check_dest_untouched(ubman)
+
+        with ubman.log.section('Signed configuration, corrupted overlay'):
+            load_fit(ubman, bad_fit)
+            ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-ab {DEST_ADDR:x}')
+            assert not ok
+            assert 'sha256,rsa2048:dev+' in output
+            assert 'load of ov-b failed' in output
+            check_dest_untouched(ubman)
+    finally:
+        ubman.config.dtb = old_dtb
+        ubman.restart_uboot()

-- 
2.56.0

