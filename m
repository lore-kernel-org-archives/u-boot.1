Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5E5C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 11:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D443D87CBA;
	Mon, 22 Jan 2024 12:56:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BC5687BB3; Mon, 22 Jan 2024 12:56:12 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4A40F879C3
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 12:56:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C16271FB;
 Mon, 22 Jan 2024 03:56:54 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BDFA3F73F;
 Mon, 22 Jan 2024 03:56:05 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 18/18] doc: fwu: Make changes for supporting FWU Metadata
 version 2
Date: Mon, 22 Jan 2024 17:24:39 +0530
Message-Id: <20240122115439.653871-19-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122115439.653871-1-sughosh.ganu@linaro.org>
References: <20240122115439.653871-1-sughosh.ganu@linaro.org>
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

Make changes to the FWU documentation to reflect the changes made with
migration of the FWU metadata to version 2.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 doc/board/socionext/developerbox.rst |  9 +++------
 doc/develop/uefi/fwu_updates.rst     | 12 +++++-------
 doc/usage/cmd/fwu_mdata.rst          | 12 ++++++++----
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/doc/board/socionext/developerbox.rst b/doc/board/socionext/developerbox.rst
index 46712c379b..d8c1bb4986 100644
--- a/doc/board/socionext/developerbox.rst
+++ b/doc/board/socionext/developerbox.rst
@@ -113,8 +113,6 @@ configs/synquacer_developerbox_defconfig enables default FWU configuration ::
  CONFIG_FWU_MULTI_BANK_UPDATE=y
  CONFIG_FWU_MDATA=y
  CONFIG_FWU_MDATA_MTD=y
- CONFIG_FWU_NUM_BANKS=2
- CONFIG_FWU_NUM_IMAGES_PER_BANK=1
  CONFIG_CMD_FWU_METADATA=y
 
 And build it::
@@ -126,10 +124,9 @@ And build it::
   make -j `noproc`
   cd ../
 
-By default, the CONFIG_FWU_NUM_BANKS and CONFIG_FWU_NUM_IMAGES_PER_BANKS are
-set to 2 and 1 respectively. This uses FIP (Firmware Image Package) type image
-which contains TF-A, U-Boot and OP-TEE (the OP-TEE is optional).
-You can use fiptool to compose the FIP image from those firmware images.
+This uses FIP (Firmware Image Package) type image which contains TF-A,
+U-Boot and OP-TEE (the OP-TEE is optional). You can use fiptool to
+compose the FIP image from those firmware images.
 
 Rebuild SCP firmware
 --------------------
diff --git a/doc/develop/uefi/fwu_updates.rst b/doc/develop/uefi/fwu_updates.rst
index e4709d82b4..7911c954d9 100644
--- a/doc/develop/uefi/fwu_updates.rst
+++ b/doc/develop/uefi/fwu_updates.rst
@@ -43,8 +43,6 @@ The feature can be enabled by specifying the following configs::
     CONFIG_FWU_MULTI_BANK_UPDATE=y
     CONFIG_FWU_MDATA=y
     CONFIG_FWU_MDATA_GPT_BLK=y
-    CONFIG_FWU_NUM_BANKS=<val>
-    CONFIG_FWU_NUM_IMAGES_PER_BANK=<val>
 
 in the .config file
 
@@ -94,12 +92,12 @@ of. Each GPT partition entry in the GPT header has two GUIDs::
 * UniquePartitionGUID
 
 The PartitionTypeGUID value should correspond to the
-``image_type_uuid`` field of the FWU metadata. This field is used to
+``image_type_guid`` field of the FWU metadata. This field is used to
 identify a given type of updatable firmware image, e.g. U-Boot,
 OP-TEE, FIP etc. This GUID should also be used for specifying the
 `--guid` parameter when generating the capsule.
 
-The UniquePartitionGUID value should correspond to the ``image_uuid``
+The UniquePartitionGUID value should correspond to the ``image_guid``
 field in the FWU metadata. This GUID is used to identify images of a
 given image type in different banks.
 
@@ -108,8 +106,8 @@ metadata partitions. This would be the PartitionTypeGUID for the
 metadata partitions. Similarly, the UEFI specification defines the ESP
 GUID to be be used.
 
-When generating the metadata, the ``image_type_uuid`` and the
-``image_uuid`` values should match the *PartitionTypeGUID* and the
+When generating the metadata, the ``image_type_guid`` and the
+``image_guid`` values should match the *PartitionTypeGUID* and the
 *UniquePartitionGUID* values respectively.
 
 Performing the Update
@@ -181,5 +179,5 @@ empty capsule would be::
 Links
 -----
 
-* [1] https://developer.arm.com/documentation/den0118/a/ - FWU Specification
+* [1] https://developer.arm.com/documentation/den0118/ - FWU Specification
 * [2] https://git.codelinaro.org/linaro/dependable-boot/mbfw/uploads/6f7ddfe3be24e18d4319e108a758d02e/mbfw.pdf - Dependable Boot Specification
diff --git a/doc/usage/cmd/fwu_mdata.rst b/doc/usage/cmd/fwu_mdata.rst
index f1bf08fde1..1804422b33 100644
--- a/doc/usage/cmd/fwu_mdata.rst
+++ b/doc/usage/cmd/fwu_mdata.rst
@@ -26,10 +26,14 @@ The output may look like:
 
     => fwu_mdata_read
             FWU Metadata
-    crc32: 0xec4fb997
-    version: 0x1
-    active_index: 0x0
-    previous_active_index: 0x1
+    crc32: 0x13c330
+    version: 0x2
+    active_index: 0x1
+    previous_active_index: 0x0
+    bank_state[0]: 0xfc
+    bank_state[1]: 0xfc
+    bank_state[2]: 0xff
+    bank_state[3]: 0xff
             Image Info
 
     Image Type Guid: 19D5DF83-11B0-457B-BE2C-7559C13142A5
-- 
2.34.1

