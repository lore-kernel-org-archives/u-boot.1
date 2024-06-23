Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72245C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FF408858B;
	Sun, 23 Jun 2024 19:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bf5lLX23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 726F78857E; Sun, 23 Jun 2024 19:55:24 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A4F88855B
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7ebdb5d9915so135559139f.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165320; x=1719770120; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1MNIMhO/Ndz6W2tKEOG699I123CEzO9+iNidV5hkSFM=;
 b=Bf5lLX23atHo6Vekdplg126pG2diIlAFFO6dWoAL+QPPGJ8J1lRVslXBxRRuV0TrBk
 zrSyD4f5/KTXzO8DNQxbJHh2dcmiFkWLtdayZKC/irb1ZsZpoFvnRNmId1xyFrt9lBLe
 jtAKC83zyKftAY8Lbp5+aLGADYUkqbAdvH3sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165320; x=1719770120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1MNIMhO/Ndz6W2tKEOG699I123CEzO9+iNidV5hkSFM=;
 b=mNzLNboufdYQROY8XmoZrvxVJ0VnFtLSQ5+RqZ8kbN/9qi8o8qEYX9mRGDUEmyOoCG
 52lv0oWSezUdiMMtz61WgPgcaY7ds11l+kwmrSMXR6ZKtWCUUkfucdr4zKSfdhmnyAoy
 n9cqZjtVnp6jSQ5aHuqIU1UJD8LfCxBAlh4JIoUX2jo2yBHBcvngU4Gmy2Nm5dZjs2Xx
 aokZWHC60CYlKXczOZOBVrWIkyV6Q6md2Yq0xJMTooioeaTmyP54b5Kd1v1fn4XqEq0/
 4mHkvpVuE9HgV/wv0vTCt3wqwGnXQme4K2tvCXycLXRyfLzf2jOx7uqbo4WErtUgY/Zh
 5Wvw==
X-Gm-Message-State: AOJu0Yxk24jPnC81sSlsy4zOm7NSWQzMySeoTZoRPOwiLFTrkpQf6w2F
 Lyk48eCmqlEXM/+0jkw37QELokCElgOzWBlDZWluRCS6fk+kFxiKlhEMi37APKmYjkCWr1LB8uj
 E2A==
X-Google-Smtp-Source: AGHT+IFPVnz96UbHaSkI+UdTvdxJz3iqS/KYBcBm2sRtcwLXjlhIqTwBh4OPw3WCTV9bPnJYjEfh4g==
X-Received: by 2002:a05:6602:2d8b:b0:7f3:a9d4:105f with SMTP id
 ca18e2360f4ac-7f3a9d412dfmr195850139f.5.1719165319699; 
 Sun, 23 Jun 2024 10:55:19 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f391fc9b12sm134472239f.5.2024.06.23.10.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:55:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 01/14] binman: efi: Correct entry docs
Date: Sun, 23 Jun 2024 11:55:02 -0600
Message-Id: <20240623175515.1466908-2-sjg@chromium.org>
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

Somehow the class documentation has got out of sync with the generated
entries.rst file. Regenerating it causes errors, so correct these and
regenerate the entries.rst file.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 809f28e7213 ("binman: capsule: Use dumped capsule header...")
---

(no changes since v1)

 tools/binman/entries.rst                | 58 ++++++++++++-------------
 tools/binman/etype/efi_capsule.py       | 40 ++++++++---------
 tools/binman/etype/efi_empty_capsule.py | 22 +++++-----
 3 files changed, 61 insertions(+), 59 deletions(-)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 254afe76074..dc42a9cb97d 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -470,11 +470,11 @@ updating the EC on startup via software sync.
 
 .. _etype_efi_capsule:
 
-Entry: capsule: Entry for generating EFI Capsule files
-------------------------------------------------------
+Entry: efi-capsule: Generate EFI capsules
+-----------------------------------------
 
-The parameters needed for generation of the capsules can be provided
-as properties in the entry.
+The parameters needed for generation of the capsules can
+be provided as properties in the entry.
 
 Properties / Entry arguments:
     - image-index: Unique number for identifying corresponding
@@ -495,9 +495,9 @@ Properties / Entry arguments:
       file. Mandatory property for generating signed capsules.
     - oem-flags - OEM flags to be passed through capsule header.
 
-    Since this is a subclass of Entry_section, all properties of the parent
-    class also apply here. Except for the properties stated as mandatory, the
-    rest of the properties are optional.
+Since this is a subclass of Entry_section, all properties of the parent
+class also apply here. Except for the properties stated as mandatory, the
+rest of the properties are optional.
 
 For more details on the description of the capsule format, and the capsule
 update functionality, refer Section 8.5 and Chapter 23 in the `UEFI
@@ -510,17 +510,17 @@ provided as a subnode of the capsule entry.
 A typical capsule entry node would then look something like this::
 
     capsule {
-            type = "efi-capsule";
-            image-index = <0x1>;
-            /* Image GUID for testing capsule update */
-            image-guid = SANDBOX_UBOOT_IMAGE_GUID;
-            hardware-instance = <0x0>;
-            private-key = "path/to/the/private/key";
-            public-key-cert = "path/to/the/public-key-cert";
-            oem-flags = <0x8000>;
+        type = "efi-capsule";
+        image-index = <0x1>;
+        /* Image GUID for testing capsule update */
+        image-guid = SANDBOX_UBOOT_IMAGE_GUID;
+        hardware-instance = <0x0>;
+        private-key = "path/to/the/private/key";
+        public-key-cert = "path/to/the/public-key-cert";
+        oem-flags = <0x8000>;
 
-            u-boot {
-            };
+        u-boot {
+        };
     };
 
 In the above example, the capsule payload is the U-Boot image. The
@@ -534,8 +534,8 @@ payload using the blob-ext subnode.
 
 .. _etype_efi_empty_capsule:
 
-Entry: efi-empty-capsule: Entry for generating EFI Empty Capsule files
-----------------------------------------------------------------------
+Entry: efi-empty-capsule: Generate EFI empty capsules
+-----------------------------------------------------
 
 The parameters needed for generation of the empty capsules can
 be provided as properties in the entry.
@@ -551,22 +551,22 @@ update functionality, refer Section 8.5 and Chapter 23 in the `UEFI
 specification`_. For more information on the empty capsule, refer the
 sections 2.3.2 and 2.3.3 in the `Dependable Boot specification`_.
 
-A typical accept empty capsule entry node would then look something
-like this::
+A typical accept empty capsule entry node would then look something like
+this::
 
     empty-capsule {
-            type = "efi-empty-capsule";
-            /* GUID of the image being accepted */
-            image-type-id = SANDBOX_UBOOT_IMAGE_GUID;
-            capsule-type = "accept";
+        type = "efi-empty-capsule";
+        /* GUID of image being accepted */
+        image-type-id = SANDBOX_UBOOT_IMAGE_GUID;
+        capsule-type = "accept";
     };
 
-A typical revert empty capsule entry node would then look something
-like this::
+A typical revert empty capsule entry node would then look something like
+this::
 
     empty-capsule {
-            type = "efi-empty-capsule";
-            capsule-type = "revert";
+        type = "efi-empty-capsule";
+        capsule-type = "revert";
     };
 
 The empty capsules do not have any input payload image.
diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index e3203717822..751f654bf31 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -36,23 +36,23 @@ class Entry_efi_capsule(Entry_section):
     be provided as properties in the entry.
 
     Properties / Entry arguments:
-    - image-index: Unique number for identifying corresponding
-      payload image. Number between 1 and descriptor count, i.e.
-      the total number of firmware images that can be updated. Mandatory
-      property.
-    - image-guid: Image GUID which will be used for identifying the
-      updatable image on the board. Mandatory property.
-    - hardware-instance: Optional number for identifying unique
-      hardware instance of a device in the system. Default value of 0
-      for images where value is not to be used.
-    - fw-version: Value of image version that can be put on the capsule
-      through the Firmware Management Protocol(FMP) header.
-    - monotonic-count: Count used when signing an image.
-    - private-key: Path to PEM formatted .key private key file. Mandatory
-      property for generating signed capsules.
-    - public-key-cert: Path to PEM formatted .crt public key certificate
-      file. Mandatory property for generating signed capsules.
-    - oem-flags - OEM flags to be passed through capsule header.
+        - image-index: Unique number for identifying corresponding
+          payload image. Number between 1 and descriptor count, i.e.
+          the total number of firmware images that can be updated. Mandatory
+          property.
+        - image-guid: Image GUID which will be used for identifying the
+          updatable image on the board. Mandatory property.
+        - hardware-instance: Optional number for identifying unique
+          hardware instance of a device in the system. Default value of 0
+          for images where value is not to be used.
+        - fw-version: Value of image version that can be put on the capsule
+          through the Firmware Management Protocol(FMP) header.
+        - monotonic-count: Count used when signing an image.
+        - private-key: Path to PEM formatted .key private key file. Mandatory
+          property for generating signed capsules.
+        - public-key-cert: Path to PEM formatted .crt public key certificate
+          file. Mandatory property for generating signed capsules.
+        - oem-flags - OEM flags to be passed through capsule header.
 
     Since this is a subclass of Entry_section, all properties of the parent
     class also apply here. Except for the properties stated as mandatory, the
@@ -66,9 +66,9 @@ class Entry_efi_capsule(Entry_section):
     properties in the entry. The payload to be used in the capsule is to be
     provided as a subnode of the capsule entry.
 
-    A typical capsule entry node would then look something like this
+    A typical capsule entry node would then look something like this::
 
-    capsule {
+        capsule {
             type = "efi-capsule";
             image-index = <0x1>;
             /* Image GUID for testing capsule update */
@@ -80,7 +80,7 @@ class Entry_efi_capsule(Entry_section):
 
             u-boot {
             };
-    };
+        };
 
     In the above example, the capsule payload is the U-Boot image. The
     capsule entry would read the contents of the payload and put them
diff --git a/tools/binman/etype/efi_empty_capsule.py b/tools/binman/etype/efi_empty_capsule.py
index 064bf9a77f0..1d99fbfb3bb 100644
--- a/tools/binman/etype/efi_empty_capsule.py
+++ b/tools/binman/etype/efi_empty_capsule.py
@@ -19,31 +19,33 @@ class Entry_efi_empty_capsule(Entry_section):
     be provided as properties in the entry.
 
     Properties / Entry arguments:
-    - image-guid: Image GUID which will be used for identifying the
-      updatable image on the board. Mandatory for accept capsule.
-    - capsule-type - String to indicate type of capsule to generate. Valid
-      values are 'accept' and 'revert'.
+        - image-guid: Image GUID which will be used for identifying the
+          updatable image on the board. Mandatory for accept capsule.
+        - capsule-type - String to indicate type of capsule to generate. Valid
+          values are 'accept' and 'revert'.
 
     For more details on the description of the capsule format, and the capsule
     update functionality, refer Section 8.5 and Chapter 23 in the `UEFI
     specification`_. For more information on the empty capsule, refer the
     sections 2.3.2 and 2.3.3 in the `Dependable Boot specification`_.
 
-    A typical accept empty capsule entry node would then look something like this
+    A typical accept empty capsule entry node would then look something like
+    this::
 
-    empty-capsule {
+        empty-capsule {
             type = "efi-empty-capsule";
             /* GUID of image being accepted */
             image-type-id = SANDBOX_UBOOT_IMAGE_GUID;
             capsule-type = "accept";
-    };
+        };
 
-    A typical revert empty capsule entry node would then look something like this
+    A typical revert empty capsule entry node would then look something like
+    this::
 
-    empty-capsule {
+        empty-capsule {
             type = "efi-empty-capsule";
             capsule-type = "revert";
-    };
+        };
 
     The empty capsules do not have any input payload image.
 
-- 
2.34.1

