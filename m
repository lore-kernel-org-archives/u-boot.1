Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB83C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECFAE88210;
	Fri, 22 Mar 2024 11:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5FD488209; Fri, 22 Mar 2024 11:59:13 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 35F8088201
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8FFC1691;
 Fri, 22 Mar 2024 03:59:44 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEAD23F64C;
 Fri, 22 Mar 2024 03:59:07 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Yann GAUTIER <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Patrick DELAUNAY - foss <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <monstr@monstr.eu>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 18/20] doc: fwu: make changes to reflect support for FWU
 metadata v2
Date: Fri, 22 Mar 2024 16:27:31 +0530
Message-Id: <20240322105733.203888-19-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322105733.203888-1-sughosh.ganu@linaro.org>
References: <20240322105733.203888-1-sughosh.ganu@linaro.org>
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

The FWU Update Agent in U-Boot supports both versions of the FWU
metadata. Make changes in the documentation to reflect this.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2:
* Changes to indicate support for both v1 and v2 instead of only v2.

 doc/board/socionext/developerbox.rst |  7 +++++--
 doc/develop/uefi/fwu_updates.rst     | 20 +++++++++++++++-----
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/doc/board/socionext/developerbox.rst b/doc/board/socionext/developerbox.rst
index 46712c379b..863761c6e2 100644
--- a/doc/board/socionext/developerbox.rst
+++ b/doc/board/socionext/developerbox.rst
@@ -116,6 +116,7 @@ configs/synquacer_developerbox_defconfig enables default FWU configuration ::
  CONFIG_FWU_NUM_BANKS=2
  CONFIG_FWU_NUM_IMAGES_PER_BANK=1
  CONFIG_CMD_FWU_METADATA=y
+ CONFIG_FWU_MDATA_V2=y
 
 And build it::
 
@@ -129,7 +130,9 @@ And build it::
 By default, the CONFIG_FWU_NUM_BANKS and CONFIG_FWU_NUM_IMAGES_PER_BANKS are
 set to 2 and 1 respectively. This uses FIP (Firmware Image Package) type image
 which contains TF-A, U-Boot and OP-TEE (the OP-TEE is optional).
-You can use fiptool to compose the FIP image from those firmware images.
+You can use fiptool to compose the FIP image from those firmware
+images. There are two versions of the FWU metadata, of which the
+platform enables version 2 by default.
 
 Rebuild SCP firmware
 --------------------
@@ -194,7 +197,7 @@ following UUIDs.
 
 These UUIDs are used for making a FWU metadata image.
 
-u-boot$ ./tools/mkfwumdata -i 1 -b 2 \
+u-boot$ ./tools/mkfwumdata -v 2 -i 1 -b 2 \
 	17e86d77-41f9-4fd7-87ec-a55df9842de5,10c36d7d-ca52-b843-b7b9-f9d6c501d108,5a66a702-99fd-4fef-a392-c26e261a2828,a8f868a1-6e5c-4757-878d-ce63375ef2c0 \
 	../devbox-fwu-mdata.img
 
diff --git a/doc/develop/uefi/fwu_updates.rst b/doc/develop/uefi/fwu_updates.rst
index e4709d82b4..51e8a28efe 100644
--- a/doc/develop/uefi/fwu_updates.rst
+++ b/doc/develop/uefi/fwu_updates.rst
@@ -46,6 +46,8 @@ The feature can be enabled by specifying the following configs::
     CONFIG_FWU_NUM_BANKS=<val>
     CONFIG_FWU_NUM_IMAGES_PER_BANK=<val>
 
+    CONFIG_FWU_MDATA_V1=y or CONFIG_FWU_MDATA_V2=y
+
 in the .config file
 
 By enabling the CONFIG_CMD_FWU_METADATA config option, the
@@ -58,6 +60,14 @@ enable the FWU Multi Bank Update functionality. Please refer to the
 section :ref:`uefi_capsule_update_ref` for more details on generation
 of the UEFI capsule.
 
+FWU Metadata
+------------
+
+U-Boot supports both versions(1 and 2) of the FWU metadata defined in
+the two revisions of the specification. Support can be enabled for
+either of the two versions through a config flag. The mkfwumdata tool
+can generate metadata for both the supported versions.
+
 Setting up the device for GPT partitioned storage
 -------------------------------------------------
 
@@ -94,12 +104,12 @@ of. Each GPT partition entry in the GPT header has two GUIDs::
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
 
@@ -108,8 +118,8 @@ metadata partitions. This would be the PartitionTypeGUID for the
 metadata partitions. Similarly, the UEFI specification defines the ESP
 GUID to be be used.
 
-When generating the metadata, the ``image_type_uuid`` and the
-``image_uuid`` values should match the *PartitionTypeGUID* and the
+When generating the metadata, the ``image_type_guid`` and the
+``image_guid`` values should match the *PartitionTypeGUID* and the
 *UniquePartitionGUID* values respectively.
 
 Performing the Update
@@ -181,5 +191,5 @@ empty capsule would be::
 Links
 -----
 
-* [1] https://developer.arm.com/documentation/den0118/a/ - FWU Specification
+* [1] https://developer.arm.com/documentation/den0118/ - FWU Specification
 * [2] https://git.codelinaro.org/linaro/dependable-boot/mbfw/uploads/6f7ddfe3be24e18d4319e108a758d02e/mbfw.pdf - Dependable Boot Specification
-- 
2.34.1

