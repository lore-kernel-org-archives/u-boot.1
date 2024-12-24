Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DFEE77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 22:01:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57A1B8074B;
	Tue, 24 Dec 2024 23:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ERyZk8a0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4CE180780; Tue, 24 Dec 2024 23:00:57 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5112B80730
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 23:00:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8182B3F387; 
 Tue, 24 Dec 2024 22:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1735077654;
 bh=9rx1Tshs7BJwclPZp/Rh9CwiNuvVmptIW0Lwr7/mXew=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ERyZk8a0cLu2CsCHwE2aV3x6jmiz65t61FfURy8G7+f1AC4ugNbvb2egvB7tTkbcX
 oIcq39egetE5PSPpQPju5JRLfSqTv8U8jSm+QoDDWFYJT8Tsn8zRoMQuceh4jtRI/T
 zLUb6ITKuQ1m3bxB+vF/g1xxT6RchAm7h7N7TEKNCLKvDVlJArCJsBmnqT7M1ZQJCz
 yl1ZnkTebLrktrjeZTLGdSVTKWP26RrKXcRZRZAmYkAPXlApDCDGK/P/8e7f87HYcQ
 HHiVY+afzpx96O5kaFHNEAdG2SlpKYOts90H7fv99nhVHx0DjaHauSa/Gp/jCoj+NZ
 Ig/WMPBMFxnGQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] tpm: update descriptions in tpm-v2.h header
Date: Tue, 24 Dec 2024 23:00:49 +0100
Message-ID: <20241224220049.26629-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

* Provide a link to 'TPM 2.0 Library Specification'
* Remove outdated comment for TPM2_NUM_PCR_BANKS.
  The value 16 can be found in the current standard
  TCG TSS 2.0 Overview and Common Structures Specification 1.0, rev 10
* Describe some of the structures in Sphinx style.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/tpm-v2.h | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index 4fd19c52fd7..0f388b26496 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -6,6 +6,11 @@
  * Copyright (c) 2020 Linaro
  * Copyright (c) 2018 Bootlin
  *
+ * The structures are described in
+ * Trusted Platform Module Library Part 2: Structures
+ * http://tcg.tjn.chef.causewaynow.com/resource/tpm-library-specification/
+ *
+ * C header files are listed in
  * https://trustedcomputinggroup.org/resource/tss-overview-common-structures-specification/
  *
  * Author: Miquel Raynal <miquel.raynal@bootlin.com>
@@ -34,12 +39,8 @@ struct udevice;
 
 #define TPM2_HDR_LEN		10
 
-/*
- *  We deviate from this draft of the specification by increasing the value of
- *  TPM2_NUM_PCR_BANKS from 3 to 16 to ensure compatibility with TPM2
- *  implementations that have enabled a larger than typical number of PCR
- *  banks. This larger value for TPM2_NUM_PCR_BANKS is expected to be included
- *  in a future revision of the specification.
+/**
+ * define TPM2_NUM_PCR_BANKS - number of PCR banks
  */
 #define TPM2_NUM_PCR_BANKS 16
 
@@ -55,20 +56,43 @@ struct udevice;
 #define TPM2_PT_MAX_COMMAND_SIZE	(u32)(TPM2_PT_FIXED + 30)
 #define TPM2_PT_MAX_RESPONSE_SIZE	(u32)(TPM2_PT_FIXED + 31)
 
-/* TPMS_TAGGED_PROPERTY Structure */
+/**
+ * struct tpms_tagged_property - TPMS_TAGGED_PROPERTY structure
+ *
+ * This structure is returned by TPM2_GetCapability() to report
+ * a u32 property value.
+ *
+ * @property:	property identifier
+ * @value:	value of the property
+ */
 struct tpms_tagged_property {
 	u32 property;
 	u32 value;
 } __packed;
 
-/* TPMS_PCR_SELECTION Structure */
+/**
+ * struct tpms_pcr_selection - TPMS_PCR_SELECTION structure
+ *
+ * This structure allows to specify a hash algorithm and a list of
+ * selected PCRs. A PCR is selected by setting the related bit in
+ * @pcr_select to 1.
+ *
+ * @hash:		hash algorithm associated with the selection
+ * @size_of_select:	size in bytes of the @pcr_select array
+ * @pcr_select:		bit map of selected PCRs
+ */
 struct tpms_pcr_selection {
 	u16 hash;
 	u8 size_of_select;
 	u8 pcr_select[TPM2_PCR_SELECT_MAX];
 } __packed;
 
-/* TPML_PCR_SELECTION Structure */
+/**
+ * struct tpml_pcr_selection - TPML_PCR_SELECTION structure
+ *
+ * @count:	number of selection structures, may be zero
+ * @selection:	list of selections
+ */
 struct tpml_pcr_selection {
 	u32 count;
 	struct tpms_pcr_selection selection[TPM2_NUM_PCR_BANKS];
-- 
2.47.1

