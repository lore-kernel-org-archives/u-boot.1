Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C14BC2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76373885C7;
	Sun, 23 Jun 2024 19:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UBzewZ3L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02AFA882E2; Sun, 23 Jun 2024 19:55:27 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABA398854A
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7eb01106015so140460239f.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165323; x=1719770123; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=reRO+PWnAbQoRezpZ6uNVJqdGMz4XgJ+cqxJGVBudhw=;
 b=UBzewZ3LQi8ZpKGW65QaYFboqQJQpyQQUi1eDNBweVrhXDsvD0q7LGdKFvSw4t5JVB
 w9hr7HBkD+LQtc5tKzivMrCeDSBFIvct1TV8b0GMDuevuo0Bcz8E0Xj/lapPquzf+HuW
 kno96ICDBaqdX4zxmDvS22RWy9q6LujhMBRk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165323; x=1719770123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=reRO+PWnAbQoRezpZ6uNVJqdGMz4XgJ+cqxJGVBudhw=;
 b=OoHyRxM1ZTGgUW4RCeFkRHnOwV6yGVz7eogUOqd/b9ZiKMKm/ROklC3dJ0ENgJhwSy
 +6RZ5towqQepS4h6q8YsL1S0eD2M/plEXrMUMX/JFc8vhku4GMtg1Ihzlf7e/r2sMFtg
 A4gUQMsSzni47SJyU1RwLXjB3ZZ43PM1O2LMp02oFyD0+j8uUQ9+n9SiKvdZO3DPDqvw
 T/d9wHVyk/Z2RUAOLFWcseiV/Cv/ZXwxX1RoGqBa3jVrw7SdfewwRXBpWOsRF8qmDpOU
 JWzowNxKhSIL5Q/rypMeray9XfZzZgsWuAR+WuxoEkhBk7QBLorE3u2TgrsKOa5EPSAF
 BGkg==
X-Gm-Message-State: AOJu0YyQjrqAlCxhNJZrYEMHrvMc0ZVn37jvtyjICGQ9jrFTVaA/nn4f
 pK4LJY9Z1zmzcr4acwG2vZTQIQ6pVB168pM4uyEqqxY3eCnbEALP0GePGAPguBLN4e+lLAnppfY
 66w==
X-Google-Smtp-Source: AGHT+IF2Ecz08inQurnUtTJTEWcMJQKhZ54vnw0r8mejInY4MzGj0pDY4a5gvp1q9RdxYT6Se/yE2A==
X-Received: by 2002:a05:6602:158d:b0:7eb:8320:3662 with SMTP id
 ca18e2360f4ac-7f3a75fa6d3mr318294539f.19.1719165323207; 
 Sun, 23 Jun 2024 10:55:23 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f391fc9b12sm134472239f.5.2024.06.23.10.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:55:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 05/14] binman: Support an assumed size for missing binaries
Date: Sun, 23 Jun 2024 11:55:06 -0600
Message-Id: <20240623175515.1466908-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175515.1466908-1-sjg@chromium.org>
References: <20240623175515.1466908-1-sjg@chromium.org>
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

Binman has a the useful feature of handling missing external blobs
gracefully, including allowing them to be missing, deciding whether the
resulting image is functional or not and faking blobs when this is
necessary for particular tools (e.g. mkimage).

This feature is widely used in CI. One drawback is that if U-Boot grows
too large to fit along with the required blobs, then this is not
discovered until someone does a 'real' build which includes the blobs.

Add a 'assume-size' property to entries to allow Binman to reserve a
given size for missing external blobs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/binman.rst                  |  7 ++++++
 tools/binman/entry.py                    |  1 +
 tools/binman/etype/blob.py               |  7 +++++-
 tools/binman/ftest.py                    | 28 ++++++++++++++++++++++++
 tools/binman/test/326_assume_size.dts    | 16 ++++++++++++++
 tools/binman/test/327_assume_size_ok.dts | 16 ++++++++++++++
 6 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 tools/binman/test/326_assume_size.dts
 create mode 100644 tools/binman/test/327_assume_size_ok.dts

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 230e055667f..872e9746c8c 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -711,6 +711,13 @@ missing-msg:
     information about what needs to be fixed. See missing-blob-help for the
     message for each tag.
 
+assume-size:
+    Sets the assumed size of a blob entry if it is missing. This allows for a
+    check that the rest of the image fits into the available space, even when
+    the contents are not available. If the entry is missing, Binman will use
+    this assumed size for the entry size, including creating a fake file of that
+    size if requested.
+
 no-expanded:
     By default binman substitutes entries with expanded versions if available,
     so that a `u-boot` entry type turns into `u-boot-expanded`, for example. The
diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index 2ed65800d22..219d5dcecab 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -315,6 +315,7 @@ class Entry(object):
         self.overlap = fdt_util.GetBool(self._node, 'overlap')
         if self.overlap:
             self.required_props += ['offset', 'size']
+        self.assume_size = fdt_util.GetInt(self._node, 'assume-size', 0)
 
         # This is only supported by blobs and sections at present
         self.compress = fdt_util.GetString(self._node, 'compress', 'none')
diff --git a/tools/binman/etype/blob.py b/tools/binman/etype/blob.py
index 064fae50365..041e1122953 100644
--- a/tools/binman/etype/blob.py
+++ b/tools/binman/etype/blob.py
@@ -48,11 +48,16 @@ class Entry_blob(Entry):
             self.external and (self.optional or self.section.GetAllowMissing()))
         # Allow the file to be missing
         if not self._pathname:
+            if not fake_size and self.assume_size:
+                fake_size = self.assume_size
             self._pathname, faked = self.check_fake_fname(self._filename,
                                                           fake_size)
             self.missing = True
             if not faked:
-                self.SetContents(b'')
+                content_size = 0
+                if self.assume_size: # Ensure we get test coverage on next line
+                    content_size = self.assume_size
+                self.SetContents(tools.get_bytes(0, content_size))
                 return True
 
         self.ReadBlobContents()
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 8a44bc051b3..bd0a10ff885 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7460,5 +7460,33 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         with self.assertRaises(ValueError) as e:
             self._DoReadFile('323_capsule_accept_revert_missing.dts')
 
+    def test_assume_size(self):
+        """Test handling of the assume-size property for external blob"""
+        with self.assertRaises(ValueError) as e:
+            self._DoTestFile('326_assume_size.dts', allow_missing=True,
+                             allow_fake_blobs=True)
+        self.assertIn("contents size 0xa (10) exceeds section size 0x9 (9)",
+                      str(e.exception))
+
+    def test_assume_size_ok(self):
+        """Test handling of the assume-size where it fits OK"""
+        with test_util.capture_sys_output() as (stdout, stderr):
+            self._DoTestFile('327_assume_size_ok.dts', allow_missing=True,
+                             allow_fake_blobs=True)
+        err = stderr.getvalue()
+        self.assertRegex(
+            err,
+            "Image '.*' has faked external blobs and is non-functional: .*")
+
+    def test_assume_size_no_fake(self):
+        """Test handling of the assume-size where it fits OK"""
+        with test_util.capture_sys_output() as (stdout, stderr):
+            self._DoTestFile('327_assume_size_ok.dts', allow_missing=True)
+        err = stderr.getvalue()
+        self.assertRegex(
+            err,
+            "Image '.*' is missing external blobs and is non-functional: .*")
+
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/326_assume_size.dts b/tools/binman/test/326_assume_size.dts
new file mode 100644
index 00000000000..4c5f8b418d8
--- /dev/null
+++ b/tools/binman/test/326_assume_size.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		size = <9>;
+		blob-ext {
+			filename = "assume_blob";
+			assume-size = <10>;
+		};
+	};
+};
diff --git a/tools/binman/test/327_assume_size_ok.dts b/tools/binman/test/327_assume_size_ok.dts
new file mode 100644
index 00000000000..00ed726f872
--- /dev/null
+++ b/tools/binman/test/327_assume_size_ok.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		size = <10>;
+		blob-ext {
+			filename = "assume_blob";
+			assume-size = <10>;
+		};
+	};
+};
-- 
2.34.1

