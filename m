Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F84CA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 09:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5889586E37;
	Tue, 12 Sep 2023 11:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZMA/ab6D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EDB586E46; Tue, 12 Sep 2023 11:47:41 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id A608B86E4B
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 11:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 2F8FE212BC20;
 Tue, 12 Sep 2023 02:47:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2F8FE212BC20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1694512053;
 bh=rR6SdGuKgv1k/SLKYowO/1JsxJPlosHuwOmA549Vr8I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZMA/ab6DVL9Sm4YVA+jKDl84vejVytt/CC4skka9chRaGP5E3G6VetpiOu0hOWa+I
 xyILoO4Z85AqkBJtjcyHaQQUsGTg0UIE7xxjzRtRCS4ynaKEsU4/mEWTAxu3rQTnMM
 GJ0DP/leeKMJ+O9XjFjLD7ampJWATwW4+qxoZiZg=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, stcarlso@linux.microsoft.com, ilias.apalodimas@linaro.org
Subject: [PATCH 8/8] doc: rollback: anti-rollback verification
Date: Tue, 12 Sep 2023 02:47:31 -0700
Message-Id: <20230912094731.51413-9-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
References: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
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

From: Sean Edmond <seanedmond@microsoft.com>

Add documentation for anti-rollback verification, optional properties in
FIT image, and UCLASS_ROLLBACK device.

Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---
 doc/develop/driver-model/index.rst         |  1 +
 doc/develop/driver-model/rollback-info.rst | 42 +++++++++++++++++
 doc/usage/fit/signature.rst                | 53 +++++++++++++++++++---
 doc/usage/fit/source_file_format.rst       | 21 ++++++++-
 4 files changed, 108 insertions(+), 9 deletions(-)
 create mode 100644 doc/develop/driver-model/rollback-info.rst

diff --git a/doc/develop/driver-model/index.rst b/doc/develop/driver-model/index.rst
index 8e12bbd936..bb2d2e8a5d 100644
--- a/doc/develop/driver-model/index.rst
+++ b/doc/develop/driver-model/index.rst
@@ -25,6 +25,7 @@ subsystems
    pci-info
    pmic-framework
    remoteproc-framework
+   rollback-info
    serial-howto
    soc-framework
    spi-howto
diff --git a/doc/develop/driver-model/rollback-info.rst b/doc/develop/driver-model/rollback-info.rst
new file mode 100644
index 0000000000..06ba4584a9
--- /dev/null
+++ b/doc/develop/driver-model/rollback-info.rst
@@ -0,0 +1,42 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Rollback Driver Guide
+=====================
+
+Rollback protection is required when there is a need to retire
+previous versions of FIT images due to security flaws in them.
+See :doc:`../../usage/fit/signature` for details on rollback protection.
+
+The rollback driver is intended to provide tamper-evident storage using
+a UCLASS_ROLLBACK device.  It exposes the following APIs which are
+used in the FIT verification process (if FIT_ROLLBACK_CHECK is set):
+- rollback_idx_get()
+- rollback_idx_set()
+
+A TPM based rollback device has been provided as an example.  Users could
+create their own UCLASS_ROLLBACK device to access proprietary secure storage.
+
+TPM 2.0 based rollback devices
+------------
+
+A TPM-based rollback device has been provided as a reference.  It can be
+enabled with:
+- DM_ROLLBACK
+- ROLLBACK_TPM
+
+The tpm based rollback device should be added as a child node of the TPM in
+the u-boot device tree.  You should provide the property "rollback-nv-index"
+to set the TPM's NV index (if no "rollback-nv-index" is provided, an NV index
+of 0 is assumed).  For example:
+
+	tpm2 {
+		compatible = "sandbox,tpm2";
+
+		rollback@1 {
+			compatible = "tpm,rollback";
+			rollback-nv-index = <0x1001007>;
+		};
+	};
+
+Note, the ROLLBACK_TPM device does not set any policy.  Consumers of this
+driver should add a policy to make it more secure.
\ No newline at end of file
diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
index 0804bffd1e..30dd529c29 100644
--- a/doc/usage/fit/signature.rst
+++ b/doc/usage/fit/signature.rst
@@ -674,14 +674,53 @@ Sign the fitImage with the hardware key::
     "model=PKCS%2315%20emulated;manufacturer=ZeitControl;serial=000xxxxxxxxx;token=OpenPGP%20card%20%28User%20PIN%20%28sig%29%29" \
     -K u-boot.dtb -N pkcs11 -r fitImage
 
+Roll-back Protection
+-----------------------------------------
 
-Future Work
------------
-
-- Roll-back protection using a TPM is done using the tpm command. This can
-  be scripted, but we might consider a default way of doing this, built into
-  bootm.
-
+Rollback protection is required when there is a need to retire
+previous versions of FIT images due to security flaws in them.
+
+This feature is realized by adding a rollback index as a property
+in the FIT image.  Every time a security flaw is discovered, the
+rollback index is incremented.  For example:
+
++-------------+----------------+
+| FIT version | Rollback index |
++=============+================+
+| 1.0         | 0              |
++-------------+----------------+
+| 1.1         | 0              |
++-------------+----------------+
+| 2.0         | 0              |
++-------------+----------------+
+| Security issue found!        |
++-------------+----------------+
+| 1.2         | 1              |
++-------------+----------------+
+| 2.1         | 1              |
++-------------+----------------+
+
+Each sub-image node inside /images node has an optional rollback rollback_index
+("rollback"). This version number is part of signed data and is incremented as
+security flaws are discovered and fixed. If no "rollback" property is present
+in the FIT image, a rollback index of 0 is assumed.
+
+U-Boot stores the last seen "rollback" for a given image type in platform
+specific tamper-evident storage (using a UCLASS_ROLLBACK device).
+See :doc:`../../develop/driver-model/rollback-info` for more information on
+rollback devices.
+
+As part of signature verification, U-Boot enforces rollback
+protection if enabled (with FIT_ROLLBACK_CHECK). The rollback index stored in secure
+storage is validated with "rollback" in the sub-image node. If the counter
+in the FIT image is lower than the counter in platform secure storage, image
+validation has failed. If both counters match or the image counter is
+higher than that in the platform secure storage, the image validation is
+successful. If the rollback index has increased, U-Boot stores the new
+value in secure storage.
+
+A grace version can be enabled with FIT_ROLLBACK_CHECK_GRACE, which will accept
+a FIT image with an anti-rollback version one less than number in secure storage.
 
 Possible Future Work
 --------------------
diff --git a/doc/usage/fit/source_file_format.rst b/doc/usage/fit/source_file_format.rst
index b2b1e42bd7..149447b856 100644
--- a/doc/usage/fit/source_file_format.rst
+++ b/doc/usage/fit/source_file_format.rst
@@ -389,6 +389,16 @@ signature-1
     Each signature sub-node represents separate signature
     calculated for node's data according to specified algorithm.
 
+Optional properties
+~~~~~~~~~~~~~~~~~~~~
+
+rollback
+    The rollback index (used for anti rollback protection) specified
+    as a 64-bit value.  For example a rollback index of 1 is sepcified as:
+
+    rollback = <0 1>
+
+    If no "rollback" property is present, a rollback index of 0 is assumed.
 
 Hash nodes
 ----------
@@ -507,7 +517,6 @@ padding
     The padding algorithm, it may be pkcs-1.5 or pss,
     if no value is provided we assume pkcs-1.5
 
-
 '/configurations' node
 ----------------------
 
@@ -524,12 +533,20 @@ The 'configurations' node has the following structure::
         ...
 
 
-Optional property
+Optional properties
 ~~~~~~~~~~~~~~~~~
 
 default
     Selects one of the configuration sub-nodes as a default configuration.
 
+rollback
+    The rollback index (used for anti rollback protection) specified
+    as a 64-bit value.  For example a rollback index of 1 is sepcified as:
+
+    rollback = <0 1>
+
+    If no "rollback" property is present, a rollback index of 0 is assumed.
+
 Mandatory nodes
 ~~~~~~~~~~~~~~~
 
-- 
2.40.0

