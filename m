Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E18C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE07284B20;
	Fri, 10 Jul 2026 20:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Y4V31Ey0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E97D884B06; Fri, 10 Jul 2026 17:34:03 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C93984A3C
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 314413FA67
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1783697641;
 bh=IKborHNqFix0+a6ubvZB0IxG00PSIiEthJRZ2Na2rv4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Y4V31Ey0P13WXxuIZkYrjbF9/4mtk/zfOUUw2Kbvky5s2Y/RdRvO1iyjV7AI1Rjcn
 Z0Z5cPfvNwfrQ5fSWM/dRSNSlGZ0+z2L0A4egjwPXAh30CFtQtmngzQR29zUeTMEEx
 gZjF+qcJo80WTZmP0c32Y7s+RtJjQ5OVfSMFDMjC5Y6f1LMAadvEYZYxaZYE9tC/N2
 hl3+SMvsXisoNkrQauoU+5d/1MdrBl7e9/9UPZeF0WgXSOMVyh8KGwYaoUnwBFQg2a
 onkK8CYh18ZKdrIxrW7D+DRU20EyGycqk4Cc2Q9MpFR21B11qKFpdmSugQhMIZxpkR
 n/zGB/tyINRUDN3jakS9qOpFvQmFWlfL7P7SdXTR/lSF046hXhZjshZw0HwlLHYqBx
 SfPKUSe4LnKoTvaIgjtXA3cpOH9x+R59zKyer68ooO/3jltGx/mzMtpwtAgtXk7cMA
 geY6J/1SD+843HTiWO1UK6yMBZ717d4kGPJ1taPaNLisgtJw01fE2fDqyi7qi37ilh
 f8UGjYKa6WcUmtPDOZhHInl4cuacDtzLEt7oGr/tuuNYQk1rONnHmYQx+tQYOmRJUp
 aDCanz/9sM+2qZK729VeuAjLsFsQ6RJXr3K2WbLA/VomN8pEH2cgkFy3r6hQnSiOho
 YREQDtGXSkTB4DfQ36A2489c=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cca5e0a0c9so18776175ad.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 08:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783697639; x=1784302439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IKborHNqFix0+a6ubvZB0IxG00PSIiEthJRZ2Na2rv4=;
 b=TAp5wBD+fEWhibw6RCb7K1iKSRVMwNs+xfkGKByQwwsIA28CoSzrrdvus6x2MpqdZ5
 HByHB6fUhqrPeHwsBIcdNJdBzbUfdRoT9tMcudWFbKhCydoJnuudVt+nBGcYh1jx9J3R
 HcGcogsYTNBeKwRwsbUARqvqMGzm8JMuurmVh4tG52Yql0PCnzfn6cWmVIwFdpkYt5dn
 y2o21E4U1Uu1TWYU757QDkx/0rTWnm6SucMj1PuRYgVrQ6s5NtWUVm1T4X48QWwHu2Ph
 GeJevH6RZsWIkiWRDIT1LZz9yeJWbrkdkCmSlbuIDpInkbQlkeSl5XJ5+FhhjUj3Ut7P
 9jyw==
X-Gm-Message-State: AOJu0YwmQRm2pD7Dvg080iFwmjAxLQDWotT+jwBj75utEnRaCpSwOYCo
 QJXEyLvO4HEPZOUm2iunZRLjSthf0hC+fN4inNmyP4/tsRmp0l8vudF+8fTpjynXhLBuKg2i3L5
 yb86hBnoVezkYcf6B8bOEZ5DB5RHW3j8iYx8OrAU55QpCkuACGj8mkLdb6+dtTMZjA0VvIZ7tFI
 IFKAU=
X-Gm-Gg: AfdE7clOuoh34TzO1tE0dOFnpa/ff6oLxIel8LKCp2x/M4ec/hBdrTA9i3qeKM06Puz
 MngPRhGjnA5JhHiwyHZmoI0IDAHm1gic+gKCr4yNaom3vjTWI7yM50P5qhNqDAem+epd52xWokm
 LV3EJRLHJMKT6wOcZpfwAGOv/isa5+SVVrJ5U8+pV6xkJdPCvmsQ34igV+2tblOESomOZ1BOx75
 zLEKxNdCUd1ovpcm4PWTDZtZnnJ6eI+MIRmuTdscSupZPr66MVKxDBZCJdn4S8rX71cCKxny2nz
 QjJT6OzMhw7YPd6mRFfrfqRt6lGjTY0A1DgtyEVR4CuwuF11unG1IvF7SI58Z/e1RS2KsfLW5Q+
 2R2a4FqXykJe7/+SNkU8HFbvcSNOnTPHA0OwDztZTXiadzIcVG92E0YJUt6069A9zjeKk2ZuiJ7
 0D5GBE
X-Received: by 2002:a17:902:fda5:b0:2c9:cb1b:64d6 with SMTP id
 d9443c01a7336-2ccea3a8001mr119180415ad.19.1783697639690; 
 Fri, 10 Jul 2026 08:33:59 -0700 (PDT)
X-Received: by 2002:a17:902:fda5:b0:2c9:cb1b:64d6 with SMTP id
 d9443c01a7336-2ccea3a8001mr119179855ad.19.1783697639181; 
 Fri, 10 Jul 2026 08:33:59 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb882sm61390895ad.16.2026.07.10.08.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 08:33:58 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/2] test: py: add regression test for fit_import_data()
 stale state
Date: Fri, 10 Jul 2026 15:33:40 +0000
Message-ID: <20260710153343.1839357-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710153343.1839357-1-aristo.chen@canonical.com>
References: <20260710153343.1839357-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Jul 2026 20:11:14 +0200
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

Build an external-data FIT, remove the data-offset property from the
second image so that only its data-size remains, and re-process the
result with mkimage -F. mkimage must reject the malformed FIT with a
clear diagnostic from the hashing stage. Previously the stale per-image
state in fit_import_data() made the import copy the first image's data
into the second image and abort without printing anything.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit_import_data.py | 89 +++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 test/py/tests/test_fit_import_data.py

diff --git a/test/py/tests/test_fit_import_data.py b/test/py/tests/test_fit_import_data.py
new file mode 100644
index 00000000000..efbbad14262
--- /dev/null
+++ b/test/py/tests/test_fit_import_data.py
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2026 Canonical Ltd.
+#
+# Test mkimage import of external data in fit_import_data()
+
+"""Regression test for stale per-image state in fit_import_data().
+
+The import loop used to keep the data pointer and external property name
+of the previous image, so an image node carrying data-size but neither
+data-offset nor data-position imported the previous image's data and
+then made mkimage abort without printing any diagnostic. Such a node
+must be skipped by the import and reported by the later processing
+stages instead.
+"""
+
+import os
+import subprocess
+
+import pytest
+
+import fit_util
+
+BASE_ITS = '''
+/dts-v1/;
+
+/ {
+    description = "import-data test";
+
+    images {
+        kernel-1 {
+            description = "first kernel";
+            data = /incbin/("%(kernel1)s");
+            type = "kernel";
+            arch = "sandbox";
+            os = "linux";
+            compression = "none";
+            load = <0x40000>;
+            entry = <0x40000>;
+        };
+        kernel-2 {
+            description = "second kernel";
+            data = /incbin/("%(kernel2)s");
+            type = "kernel";
+            arch = "sandbox";
+            os = "linux";
+            compression = "none";
+            load = <0x80000>;
+            entry = <0x80000>;
+        };
+    };
+
+    configurations {
+        default = "conf-1";
+        conf-1 {
+            kernel = "kernel-1";
+        };
+    };
+};
+'''
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtput')
+def test_fit_import_data_missing_offset(ubman):
+    """An image with data-size but no data-offset must not inherit data"""
+    mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+    params = {
+        'kernel1': fit_util.make_kernel(ubman, 'imp-kernel1.bin', 'first'),
+        'kernel2': fit_util.make_kernel(ubman, 'imp-kernel2.bin', 'second'),
+    }
+    its = fit_util.make_its(ubman, BASE_ITS, params, 'imp.its')
+    itb = fit_util.make_fname(ubman, 'imp.itb')
+
+    result = subprocess.run([mkimage, '-E', '-f', its, itb],
+                            capture_output=True, text=True)
+    assert result.returncode == 0, result.stderr
+
+    # Remove the offset so that only data-size is left on kernel-2
+    subprocess.run(['fdtput', '-d', itb, '/images/kernel-2', 'data-offset'],
+                   check=True)
+
+    # Re-processing must skip the malformed image in the import, so that
+    # the hashing stage reports it; previously the stale pointer made the
+    # import write kernel-1's data into kernel-2 and abort silently
+    result = subprocess.run([mkimage, '-F', itb],
+                            capture_output=True, text=True)
+    assert result.returncode != 0
+    assert "Can't get image data/size" in result.stderr
-- 
2.43.0

