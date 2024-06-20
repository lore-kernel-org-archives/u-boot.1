Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0E8C2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D77F5884AC;
	Fri, 21 Jun 2024 01:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ebeP0gYP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C38F8834D; Fri, 21 Jun 2024 01:06:43 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0B3E87B77
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7eee7728b00so54503439f.3
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924799; x=1719529599; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+oOlZ3xjHaF1cpgRNdg6rKrqmBgPxk0dwBXY0MO1Dis=;
 b=ebeP0gYP3JItFuSEGwTf4HGDLsaco7txnUpFKcZpT/+dT3dZaCZtRbkeQyGVkCS5Mb
 9xMNmwNJB9UMMcW3xHQcTDc8SQVL2X+XnrEZYvYGNOS1TA0TIJQ6HTPisab8Ij+5RE/G
 os366EM+j/5BMTo/acyPWxmTBo4YjkCI1y+sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924799; x=1719529599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+oOlZ3xjHaF1cpgRNdg6rKrqmBgPxk0dwBXY0MO1Dis=;
 b=CGfVpUv8UcCdaQui0favDUYvTQ2GKQhu1uoa9sQP1VArbEO7pqCmjILoOxFqCYi0am
 z7s/ni5T/UQjTC1+OpwJnS7YcbrvVKLgPmdAXER2hfAPjmRiFO8Ft8VwV7K1jX8v/PeS
 dpip4QuffkYv8FUSwJc0U8Y8k2OKB8kpBxUtPyqd4T6pcrKbEzy/GCKob2MHnja7M/WB
 ifIdKE5QOqVV+mj+dj/njI42NVT/L8AbE5U7Jy+nBkytrTf7RbzWGxt4R6IW2zmkc36L
 AzmvBBDCfLbMtVVXKBt7xm0qZnsVT7ajO6GPzEhELF6uVyA7wXhDf7ai4RPZp4z0j4bV
 bWbQ==
X-Gm-Message-State: AOJu0Yz4AC8GWfOFZ1EMeENtLYIihN5Og6ZmLTXlf/G3LjEn8TN0r1u4
 grwI/UAOhnJlXekZdHIJwZ2UyZZV4qOdpxF1/GHP5W0BoJxoXpgGLzNNTlx7j3uwPxanSs8aVn2
 BWg==
X-Google-Smtp-Source: AGHT+IHxSV7fMOYZkSILKflVqnJVTUSMoQx8+jD2GBH6Px0/Rpg38MFhtkqKNLxjKp8YLqPPyqiIUw==
X-Received: by 2002:a05:6602:1493:b0:7eb:6d0a:613a with SMTP id
 ca18e2360f4ac-7f13edafa38mr801673039f.2.1718924799321; 
 Thu, 20 Jun 2024 16:06:39 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110f566sm53269173.44.2024.06.20.16.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:06:39 -0700 (PDT)
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
Subject: [PATCH v3 01/18] binman: Support an assumed size for missing binaries
Date: Thu, 20 Jun 2024 17:06:08 -0600
Message-Id: <20240620230625.1797397-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620230625.1797397-1-sjg@chromium.org>
References: <20240620230625.1797397-1-sjg@chromium.org>
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
index 42e0b7b9145..c1904f8ae69 100644
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

