Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50FECDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 16:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA73C874A9;
	Thu, 19 Oct 2023 18:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="Y6PqGLOX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C5D9874B6; Thu, 19 Oct 2023 18:22:06 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CC42874A1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 18:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JGJWS1009136; Thu, 19 Oct 2023 16:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BZ/HXtcrRnXpeUtTltFftTbCzDlMFFaSeA3ZtLv8HHs=;
 b=Y6PqGLOXZoJA7yy2KltJVobIt4vZ8QaqlJiWG5iaA9RMCmWD+9kqUbxX6/ahAjer414V
 nyxu8edOXqwLLdOcEZK79rszhzNjzFZxQS0gwZekem9jtXYB9pn7tAERWaV4g0xZ4+kS
 i0hhcCGrCIyWz3KaBqAjxupu0ODmivlGctSTHX2X1p3ZOX8f7bZBHODmkFF4TjU/GSzX
 dsboT7tk97F2L3v5MOgC1MRj8thgyl9wBwb39Nj9LF/Z9U0xLdmjjCpoe0lgrRqN8SEc
 Wp7nlyDGvtSkDucrQRVVp+SV5UlL6jdLVYyEvAkabWBeWaxdEvJegtggQrtjVFJZgSCS PA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu7vgg6k9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 16:21:59 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JGKN1K012664;
 Thu, 19 Oct 2023 16:21:58 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu7vgg6jn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 16:21:58 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JG2mix012858; Thu, 19 Oct 2023 16:21:58 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr5pyt669-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 16:21:58 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39JGLv9q24773132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 16:21:57 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3709058063;
 Thu, 19 Oct 2023 16:21:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 004C158052;
 Thu, 19 Oct 2023 16:21:57 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.89.2])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Oct 2023 16:21:56 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: u-boot@lists.denx.de
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de,
 eajames@linux.ibm.com
Subject: [PATCH v13 3/8] tpm: Support boot measurements
Date: Thu, 19 Oct 2023 11:21:51 -0500
Message-Id: <20231019162156.80982-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231019162156.80982-1-eajames@linux.ibm.com>
References: <20231019162156.80982-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EDS_E_PKbq8qRkouRaF4RIe-_RlMB8Dm
X-Proofpoint-ORIG-GUID: SajzZnvn8bH_yoP7gmCACjhkQMhFIwUq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_15,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190138
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

Add TPM2 functions to support boot measurement. This includes
starting up the TPM, initializing/appending the event log, and
measuring the U-Boot version. Much of the code was used in the
EFI subsystem, so remove it there and use the common functions.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v10:
 - Fix compile warning for armv7 (thanks Ilias)

Changes since v8:
 - Fix log parsing again - any data corruption seen while replaying the
   event log was failing the entire measurement.
 - Added an option to ignore the existing log. This should only be used
   for systems that know that U-Boot is the first stage bootloader. This
   is necessary because the reserved memory region may persist through
   resets and so U-Boot attempts to append to the previous boot's log.

Changes since v7:
 - Change name of tcg2_init_log and add more documentation
 - Add a check, when parsing the event log header, to ensure that the
   previous stage bootloader used all the active PCRs.
 - Change name of tcg2_log_find_end
 - Fix the greater than or equal to check to exit the log parsing
 - Make sure log_position is 0 if there is any error discovering the log
 - Return errors parsing the log if the data is corrupt so that we don't
   end up with half a log

Changes since v6:
 - Added Linaro copyright for all the EFI moved code
 - Changed tcg2_init_log (and by extension, tcg2_measurement_init) to
   copy any discovered event log to the user's log if passed in.

Changes since v5:
 - Remove unused platform_get_eventlog in efi_tcg2.c
 - First look for tpm_event_log_* properties instead of linux,sml-*
 - Fix efi_tcg2.c compilation
 - Select SHA* configs

Changes since v4:
 - Remove tcg2_measure_event function and check for NULL data in
   tcg2_measure_data
 - Use tpm_auto_startup
 - Fix efi_tcg2.c compilation for removing tcg2_pcr_read function

Changes since v3:
 - Reordered headers
 - Refactored more of EFI code into common code
    Removed digest_info structure and instead used the common alg_to_mask
      and alg_to_len
    Improved event log parsing in common code to get it equivalent to EFI
      Common code now extends PCR if previous bootloader stage couldn't
      No need to allocate memory in the common code, so EFI copies the
      discovered buffer like it did before
    Rename efi measure_event function

Changes since v1:
 - Refactor TPM layer functions to allow EFI system to use them, and
   remove duplicate EFI functions

 include/efi_tcg2.h        |  44 --
 include/tpm-v2.h          | 259 ++++++++++++
 lib/Kconfig               |   4 +
 lib/efi_loader/efi_tcg2.c | 821 ++++----------------------------------
 lib/tpm-v2.c              | 814 +++++++++++++++++++++++++++++++++++++
 5 files changed, 1154 insertions(+), 788 deletions(-)

diff --git a/include/efi_tcg2.h b/include/efi_tcg2.h
index b1c3abd097..b21c5cb3dd 100644
--- a/include/efi_tcg2.h
+++ b/include/efi_tcg2.h
@@ -129,50 +129,6 @@ struct efi_tcg2_boot_service_capability {
 #define BOOT_SERVICE_CAPABILITY_MIN \
 	offsetof(struct efi_tcg2_boot_service_capability, number_of_pcr_banks)
 
-#define TCG_EFI_SPEC_ID_EVENT_SIGNATURE_03 "Spec ID Event03"
-#define TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MAJOR_TPM2 2
-#define TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MINOR_TPM2 0
-#define TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_ERRATA_TPM2 2
-
-/**
- *  struct TCG_EfiSpecIdEventAlgorithmSize - hashing algorithm information
- *
- *  @algorithm_id:	algorithm defined in enum tpm2_algorithms
- *  @digest_size:	size of the algorithm
- */
-struct tcg_efi_spec_id_event_algorithm_size {
-	u16      algorithm_id;
-	u16      digest_size;
-} __packed;
-
-/**
- * struct TCG_EfiSpecIDEventStruct - content of the event log header
- *
- * @signature:			signature, set to Spec ID Event03
- * @platform_class:		class defined in TCG ACPI Specification
- *				Client  Common Header.
- * @spec_version_minor:		minor version
- * @spec_version_major:		major version
- * @spec_version_errata:	major version
- * @uintn_size:			size of the efi_uintn_t fields used in various
- *				data structures used in this specification.
- *				0x01 indicates u32  and 0x02  indicates u64
- * @number_of_algorithms:	hashing algorithms used in this event log
- * @digest_sizes:		array of number_of_algorithms pairs
- *				1st member defines the algorithm id
- *				2nd member defines the algorithm size
- */
-struct tcg_efi_spec_id_event {
-	u8 signature[16];
-	u32 platform_class;
-	u8 spec_version_minor;
-	u8 spec_version_major;
-	u8 spec_errata;
-	u8 uintn_size;
-	u32 number_of_algorithms;
-	struct tcg_efi_spec_id_event_algorithm_size digest_sizes[];
-} __packed;
-
 /**
  * struct tdEFI_TCG2_FINAL_EVENTS_TABLE - log entries after Get Event Log
  * @version:		version number for this structure
diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index 6684033deb..33dd103767 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -216,6 +216,50 @@ struct tcg_pcr_event2 {
 	u8 event[];
 } __packed;
 
+/**
+ *  struct TCG_EfiSpecIdEventAlgorithmSize - hashing algorithm information
+ *
+ *  @algorithm_id:	algorithm defined in enum tpm2_algorithms
+ *  @digest_size:	size of the algorithm
+ */
+struct tcg_efi_spec_id_event_algorithm_size {
+	u16      algorithm_id;
+	u16      digest_size;
+} __packed;
+
+#define TCG_EFI_SPEC_ID_EVENT_SIGNATURE_03 "Spec ID Event03"
+#define TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MAJOR_TPM2 2
+#define TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MINOR_TPM2 0
+#define TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_ERRATA_TPM2 2
+
+/**
+ * struct TCG_EfiSpecIDEventStruct - content of the event log header
+ *
+ * @signature:			signature, set to Spec ID Event03
+ * @platform_class:		class defined in TCG ACPI Specification
+ *				Client  Common Header.
+ * @spec_version_minor:		minor version
+ * @spec_version_major:		major version
+ * @spec_version_errata:	major version
+ * @uintn_size:			size of the efi_uintn_t fields used in various
+ *				data structures used in this specification.
+ *				0x01 indicates u32  and 0x02  indicates u64
+ * @number_of_algorithms:	hashing algorithms used in this event log
+ * @digest_sizes:		array of number_of_algorithms pairs
+ *				1st member defines the algorithm id
+ *				2nd member defines the algorithm size
+ */
+struct tcg_efi_spec_id_event {
+	u8 signature[16];
+	u32 platform_class;
+	u8 spec_version_minor;
+	u8 spec_version_major;
+	u8 spec_errata;
+	u8 uintn_size;
+	u32 number_of_algorithms;
+	struct tcg_efi_spec_id_event_algorithm_size digest_sizes[];
+} __packed;
+
 /**
  * TPM2 Structure Tags for command/response buffers.
  *
@@ -342,6 +386,26 @@ enum tpm2_algorithms {
 	TPM2_ALG_SM3_256	= 0x12,
 };
 
+extern const enum tpm2_algorithms tpm2_supported_algorithms[4];
+
+static inline u16 tpm2_algorithm_to_len(enum tpm2_algorithms a)
+{
+	switch (a) {
+	case TPM2_ALG_SHA1:
+		return TPM2_SHA1_DIGEST_SIZE;
+	case TPM2_ALG_SHA256:
+		return TPM2_SHA256_DIGEST_SIZE;
+	case TPM2_ALG_SHA384:
+		return TPM2_SHA384_DIGEST_SIZE;
+	case TPM2_ALG_SHA512:
+		return TPM2_SHA512_DIGEST_SIZE;
+	default:
+		return 0;
+	}
+}
+
+#define tpm2_algorithm_to_mask(a)	(1 << (a))
+
 /* NV index attributes */
 enum tpm_index_attrs {
 	TPMA_NV_PPWRITE		= 1UL << 0,
@@ -421,6 +485,188 @@ enum {
 	HR_NV_INDEX		= TPM_HT_NV_INDEX << HR_SHIFT,
 };
 
+/**
+ * struct tcg2_event_log - Container for managing the platform event log
+ *
+ * @log:		Address of the log
+ * @log_position:	Current entry position
+ * @log_size:		Log space available
+ * @found:		Boolean indicating if an existing log was discovered
+ */
+struct tcg2_event_log {
+	u8 *log;
+	u32 log_position;
+	u32 log_size;
+	bool found;
+};
+
+/**
+ * Create a list of digests of the supported PCR banks for a given input data
+ *
+ * @dev		TPM device
+ * @input	Data
+ * @length	Length of the data to calculate the digest
+ * @digest_list	List of digests to fill in
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
+		       struct tpml_digest_values *digest_list);
+
+/**
+ * Get the event size of the specified digests
+ *
+ * @digest_list	List of digests for the event
+ *
+ * Return: Size in bytes of the event
+ */
+u32 tcg2_event_get_size(struct tpml_digest_values *digest_list);
+
+/**
+ * tcg2_get_active_pcr_banks
+ *
+ * @dev			TPM device
+ * @active_pcr_banks	Bitmask of PCR algorithms supported
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tcg2_get_active_pcr_banks(struct udevice *dev, u32 *active_pcr_banks);
+
+/**
+ * tcg2_log_append - Append an event to an event log
+ *
+ * @pcr_index	Index of the PCR
+ * @event_type	Type of event
+ * @digest_list List of digests to add
+ * @size	Size of event
+ * @event	Event data
+ * @log		Log buffer to append the event to
+ */
+void tcg2_log_append(u32 pcr_index, u32 event_type,
+		     struct tpml_digest_values *digest_list, u32 size,
+		     const u8 *event, u8 *log);
+
+/**
+ * Extend the PCR with specified digests
+ *
+ * @dev		TPM device
+ * @pcr_index	Index of the PCR
+ * @digest_list	List of digests to extend
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tcg2_pcr_extend(struct udevice *dev, u32 pcr_index,
+		    struct tpml_digest_values *digest_list);
+
+/**
+ * Read the PCR into a list of digests
+ *
+ * @dev		TPM device
+ * @pcr_index	Index of the PCR
+ * @digest_list	List of digests to extend
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tcg2_pcr_read(struct udevice *dev, u32 pcr_index,
+		  struct tpml_digest_values *digest_list);
+
+/**
+ * Measure data into the TPM PCRs and the platform event log.
+ *
+ * @dev		TPM device
+ * @log		Platform event log
+ * @pcr_index	Index of the PCR
+ * @size	Size of the data or 0 for event only
+ * @data	Pointer to the data or NULL for event only
+ * @event_type	Event log type
+ * @event_size	Size of the event
+ * @event	Pointer to the event
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tcg2_measure_data(struct udevice *dev, struct tcg2_event_log *elog,
+		      u32 pcr_index, u32 size, const u8 *data, u32 event_type,
+		      u32 event_size, const u8 *event);
+
+#define tcg2_measure_event(dev, elog, pcr_index, event_type, size, event) \
+	tcg2_measure_data(dev, elog, pcr_index, 0, NULL, event_type, size, \
+			  event)
+
+/**
+ * Prepare the event log buffer. This function tries to discover an existing
+ * event log in memory from a previous bootloader stage. If such a log exists
+ * and the PCRs are not extended, the log is "replayed" to extend the PCRs.
+ * If no log is discovered, create the log header.
+ *
+ * @dev			TPM device
+ * @elog		Platform event log. The log pointer and log_size
+ *			members must be initialized to either 0 or to a valid
+ *			memory region, in which case any existing log
+ *			discovered will be copied to the specified memory
+ *			region.
+ * @ignore_existing_log	Boolean to indicate whether or not to ignore an
+ *			existing platform log in memory
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
+			    bool ignore_existing_log);
+
+/**
+ * Begin measurements.
+ *
+ * @dev			TPM device
+ * @elog		Platform event log. The log pointer and log_size
+ *			members must be initialized to either 0 or to a valid
+ *			memory region, in which case any existing log
+ *			discovered will be copied to the specified memory
+ *			region.
+ * @ignore_existing_log Boolean to indicate whether or not to ignore an
+ *			existing platform log in memory
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog,
+			  bool ignore_existing_log);
+
+/**
+ * Stop measurements and record separator events.
+ *
+ * @dev		TPM device
+ * @elog	Platform event log
+ * @error	Boolean to indicate whether an error ocurred or not
+ */
+void tcg2_measurement_term(struct udevice *dev, struct tcg2_event_log *elog,
+			   bool error);
+
+/**
+ * Get the platform event log address and size.
+ *
+ * @dev		TPM device
+ * @addr	Address of the log
+ * @size	Size of the log
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size);
+
+/**
+ * Get the first TPM2 device found.
+ *
+ * @dev		TPM device
+ *
+ * Return: zero on success, negative errno otherwise
+ */
+int tcg2_platform_get_tpm2(struct udevice **dev);
+
+/**
+ * Platform-specific function for handling TPM startup errors
+ *
+ * @dev		TPM device
+ * @rc		The TPM response code
+ */
+void tcg2_platform_startup_error(struct udevice *dev, int rc);
+
 /**
  * Issue a TPM2_Startup command.
  *
@@ -540,6 +786,19 @@ u32 tpm2_pcr_read(struct udevice *dev, u32 idx, unsigned int idx_min_sz,
 u32 tpm2_get_capability(struct udevice *dev, u32 capability, u32 property,
 			void *buf, size_t prop_count);
 
+/**
+ * tpm2_get_pcr_info() - get the supported, active PCRs and number of banks
+ *
+ * @dev:		TPM device
+ * @supported_pcr:	bitmask with the algorithms supported
+ * @active_pcr:		bitmask with the active algorithms
+ * @pcr_banks:		number of PCR banks
+ *
+ * @return 0 on success, code of operation or negative errno on failure
+ */
+int tpm2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
+		      u32 *pcr_banks);
+
 /**
  * Issue a TPM2_DictionaryAttackLockReset command.
  *
diff --git a/lib/Kconfig b/lib/Kconfig
index f6ca559897..19649517a3 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -431,6 +431,10 @@ config TPM
 	bool "Trusted Platform Module (TPM) Support"
 	depends on DM
 	imply DM_RNG
+	select SHA1
+	select SHA256
+	select SHA384
+	select SHA512
 	help
 	  This enables support for TPMs which can be used to provide security
 	  features for your board. The TPM can be connected via LPC or I2C
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 7b7926a0d4..7ada536568 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -66,35 +66,6 @@ static bool tcg2_efi_app_invoked;
 static const efi_guid_t efi_guid_tcg2_protocol = EFI_TCG2_PROTOCOL_GUID;
 static const efi_guid_t efi_guid_final_events = EFI_TCG2_FINAL_EVENTS_TABLE_GUID;
 
-struct digest_info {
-	u16 hash_alg;
-	u32 hash_mask;
-	u16 hash_len;
-};
-
-static const struct digest_info hash_algo_list[] = {
-	{
-		TPM2_ALG_SHA1,
-		EFI_TCG2_BOOT_HASH_ALG_SHA1,
-		TPM2_SHA1_DIGEST_SIZE,
-	},
-	{
-		TPM2_ALG_SHA256,
-		EFI_TCG2_BOOT_HASH_ALG_SHA256,
-		TPM2_SHA256_DIGEST_SIZE,
-	},
-	{
-		TPM2_ALG_SHA384,
-		EFI_TCG2_BOOT_HASH_ALG_SHA384,
-		TPM2_SHA384_DIGEST_SIZE,
-	},
-	{
-		TPM2_ALG_SHA512,
-		EFI_TCG2_BOOT_HASH_ALG_SHA512,
-		TPM2_SHA512_DIGEST_SIZE,
-	},
-};
-
 struct variable_info {
 	const u16	*name;
 	bool		accept_empty;
@@ -113,46 +84,6 @@ static struct variable_info secure_variables[] = {
 	{u"AuditMode",		false,	1},
 };
 
-#define MAX_HASH_COUNT ARRAY_SIZE(hash_algo_list)
-
-/**
- * alg_to_mask - Get a TCG hash mask for algorithms
- *
- * @hash_alg: TCG defined algorithm
- *
- * @Return: TCG hashing algorithm bitmaps, 0 if the algorithm is not supported
- */
-static u32 alg_to_mask(u16 hash_alg)
-{
-	size_t i;
-
-	for (i = 0; i < MAX_HASH_COUNT; i++) {
-		if (hash_algo_list[i].hash_alg == hash_alg)
-			return hash_algo_list[i].hash_mask;
-	}
-
-	return 0;
-}
-
-/**
- * alg_to_len - Get a TCG hash len for algorithms
- *
- * @hash_alg: TCG defined algorithm
- *
- * @Return: len of chosen algorithm, 0 if the algorithm is not supported
- */
-static u16 alg_to_len(u16 hash_alg)
-{
-	size_t i;
-
-	for (i = 0; i < MAX_HASH_COUNT; i++) {
-		if (hash_algo_list[i].hash_alg == hash_alg)
-			return hash_algo_list[i].hash_len;
-	}
-
-	return 0;
-}
-
 static bool is_tcg2_protocol_installed(void)
 {
 	struct efi_handler *handler;
@@ -162,145 +93,6 @@ static bool is_tcg2_protocol_installed(void)
 	return ret == EFI_SUCCESS;
 }
 
-static u32 tcg_event_final_size(struct tpml_digest_values *digest_list)
-{
-	u32 len;
-	size_t i;
-
-	len = offsetof(struct tcg_pcr_event2, digests);
-	len += offsetof(struct tpml_digest_values, digests);
-	for (i = 0; i < digest_list->count; i++) {
-		u16 hash_alg = digest_list->digests[i].hash_alg;
-
-		len += offsetof(struct tpmt_ha, digest);
-		len += alg_to_len(hash_alg);
-	}
-	len += sizeof(u32); /* tcg_pcr_event2 event_size*/
-
-	return len;
-}
-
-/* tcg2_pcr_extend - Extend PCRs for a TPM2 device for a given tpml_digest_values
- *
- * @dev:		device
- * @digest_list:	list of digest algorithms to extend
- *
- * @Return: status code
- */
-static efi_status_t tcg2_pcr_extend(struct udevice *dev, u32 pcr_index,
-				    struct tpml_digest_values *digest_list)
-{
-	u32 rc;
-	size_t i;
-
-	for (i = 0; i < digest_list->count; i++) {
-		u32 alg = digest_list->digests[i].hash_alg;
-
-		rc = tpm2_pcr_extend(dev, pcr_index, alg,
-				     (u8 *)&digest_list->digests[i].digest,
-				     alg_to_len(alg));
-		if (rc) {
-			EFI_PRINT("Failed to extend PCR\n");
-			return EFI_DEVICE_ERROR;
-		}
-	}
-
-	return EFI_SUCCESS;
-}
-
-/* tcg2_pcr_read - Read PCRs for a TPM2 device for a given tpml_digest_values
- *
- * @dev:		device
- * @pcr_index:		PCR index
- * @digest_list:	list of digest algorithms to extend
- *
- * @Return: status code
- */
-static efi_status_t tcg2_pcr_read(struct udevice *dev, u32 pcr_index,
-				  struct tpml_digest_values *digest_list)
-{
-	struct tpm_chip_priv *priv;
-	unsigned int updates, pcr_select_min;
-	u32 rc;
-	size_t i;
-
-	priv = dev_get_uclass_priv(dev);
-	if (!priv)
-		return EFI_DEVICE_ERROR;
-
-	pcr_select_min = priv->pcr_select_min;
-
-	for (i = 0; i < digest_list->count; i++) {
-		u16 hash_alg = digest_list->digests[i].hash_alg;
-		u8 *digest = (u8 *)&digest_list->digests[i].digest;
-
-		rc = tpm2_pcr_read(dev, pcr_index, pcr_select_min,
-				   hash_alg, digest, alg_to_len(hash_alg),
-				   &updates);
-		if (rc) {
-			EFI_PRINT("Failed to read PCR\n");
-			return EFI_DEVICE_ERROR;
-		}
-	}
-
-	return EFI_SUCCESS;
-}
-
-/* put_event - Append an agile event to an eventlog
- *
- * @pcr_index:		PCR index
- * @event_type:		type of event added
- * @digest_list:	list of digest algorithms to add
- * @size:		size of event
- * @event:		event to add
- * @log:		log buffer to append the event
- *
- */
-static void put_event(u32 pcr_index, u32 event_type,
-		      struct tpml_digest_values *digest_list, u32 size,
-		      u8 event[], void *log)
-{
-	size_t pos;
-	size_t i;
-	u32 event_size;
-
-	/*
-	 * size refers to the length of event[] only, we need to check against
-	 * the final tcg_pcr_event2 size
-	 */
-	event_size = size + tcg_event_final_size(digest_list);
-
-	put_unaligned_le32(pcr_index, log);
-	pos = offsetof(struct tcg_pcr_event2, event_type);
-	put_unaligned_le32(event_type, (void *)((uintptr_t)log + pos));
-	pos = offsetof(struct tcg_pcr_event2, digests); /* count */
-	put_unaligned_le32(digest_list->count, (void *)((uintptr_t)log + pos));
-
-	pos += offsetof(struct tpml_digest_values, digests);
-	for (i = 0; i < digest_list->count; i++) {
-		u16 hash_alg = digest_list->digests[i].hash_alg;
-		u8 *digest = (u8 *)&digest_list->digests[i].digest;
-
-		put_unaligned_le16(hash_alg, (void *)((uintptr_t)log + pos));
-		pos += offsetof(struct tpmt_ha, digest);
-		memcpy((void *)((uintptr_t)log + pos), digest, alg_to_len(hash_alg));
-		pos += alg_to_len(hash_alg);
-	}
-
-	put_unaligned_le32(size, (void *)((uintptr_t)log + pos));
-	pos += sizeof(u32); /* tcg_pcr_event2 event_size*/
-	memcpy((void *)((uintptr_t)log + pos), event, size);
-	pos += size;
-
-	/*
-	 * make sure the calculated buffer is what we checked against
-	 * This check should never fail.  It checks the code above is
-	 * calculating the right length for the event we are adding
-	 */
-	if (pos != event_size)
-		log_err("Appending to the EventLog failed\n");
-}
-
 /* tcg2_agile_log_append - Append an agile event to an eventlog
  *
  * @pcr_index:		PCR index
@@ -317,7 +109,7 @@ static efi_status_t tcg2_agile_log_append(u32 pcr_index, u32 event_type,
 					  u32 size, u8 event[])
 {
 	void *log = (void *)((uintptr_t)event_log.buffer + event_log.pos);
-	u32 event_size = size + tcg_event_final_size(digest_list);
+	u32 event_size = size + tcg2_event_get_size(digest_list);
 	struct efi_tcg2_final_events_table *final_event;
 	efi_status_t ret = EFI_SUCCESS;
 
@@ -328,7 +120,7 @@ static efi_status_t tcg2_agile_log_append(u32 pcr_index, u32 event_type,
 			event_log.truncated = true;
 			return EFI_VOLUME_FULL;
 		}
-		put_event(pcr_index, event_type, digest_list, size, event, log);
+		tcg2_log_append(pcr_index, event_type, digest_list, size, event, log);
 		event_log.pos += event_size;
 		event_log.last_event_size = event_size;
 	}
@@ -341,7 +133,7 @@ static efi_status_t tcg2_agile_log_append(u32 pcr_index, u32 event_type,
 		return EFI_VOLUME_FULL;
 
 	log = (void *)((uintptr_t)event_log.final_buffer + event_log.final_pos);
-	put_event(pcr_index, event_type, digest_list, size, event, log);
+	tcg2_log_append(pcr_index, event_type, digest_list, size, event, log);
 
 	final_event = event_log.final_buffer;
 	final_event->number_of_events++;
@@ -350,66 +142,6 @@ static efi_status_t tcg2_agile_log_append(u32 pcr_index, u32 event_type,
 	return ret;
 }
 
-/**
- * platform_get_tpm_device() - retrieve TPM device
- *
- * This function retrieves the udevice implementing a TPM
- *
- * This function may be overridden if special initialization is needed.
- *
- * @dev:	udevice
- * Return:	status code
- */
-__weak efi_status_t platform_get_tpm2_device(struct udevice **dev)
-{
-	for_each_tpm_device(*dev) {
-		/* Only support TPMv2 devices */
-		if (tpm_get_version(*dev) == TPM_V2)
-			return EFI_SUCCESS;
-	}
-
-	return EFI_NOT_FOUND;
-}
-
-/**
- * platform_get_eventlog() - retrieve the eventlog address and size
- *
- * This function retrieves the eventlog address and size if the underlying
- * firmware has done some measurements and passed them.
- *
- * This function may be overridden based on platform specific method of
- * passing the eventlog address and size.
- *
- * @dev:	udevice
- * @addr:	eventlog address
- * @sz:		eventlog size
- * Return:	status code
- */
-__weak efi_status_t platform_get_eventlog(struct udevice *dev, u64 *addr,
-					  u32 *sz)
-{
-	const u64 *basep;
-	const u32 *sizep;
-
-	basep = dev_read_prop(dev, "tpm_event_log_addr", NULL);
-	if (!basep)
-		return EFI_NOT_FOUND;
-
-	*addr = be64_to_cpup((__force __be64 *)basep);
-
-	sizep = dev_read_prop(dev, "tpm_event_log_size", NULL);
-	if (!sizep)
-		return EFI_NOT_FOUND;
-
-	*sz = be32_to_cpup((__force __be32 *)sizep);
-	if (*sz == 0) {
-		log_debug("event log empty\n");
-		return EFI_NOT_FOUND;
-	}
-
-	return EFI_SUCCESS;
-}
-
 /**
  * tpm2_get_max_command_size() - get the supported max command size
  *
@@ -758,7 +490,7 @@ efi_tcg2_get_capability(struct efi_tcg2_protocol *this,
 	capability->protocol_version.major = 1;
 	capability->protocol_version.minor = 1;
 
-	efi_ret = platform_get_tpm2_device(&dev);
+	efi_ret = tcg2_platform_get_tpm2(&dev);
 	if (efi_ret != EFI_SUCCESS) {
 		capability->supported_event_logs = 0;
 		capability->hash_algorithm_bitmap = 0;
@@ -854,7 +586,7 @@ efi_tcg2_get_eventlog(struct efi_tcg2_protocol *this,
 		goto out;
 	}
 
-	ret = platform_get_tpm2_device(&dev);
+	ret = tcg2_platform_get_tpm2(&dev);
 	if (ret != EFI_SUCCESS) {
 		event_log_location = NULL;
 		event_log_last_entry = NULL;
@@ -889,6 +621,7 @@ static efi_status_t tcg2_hash_pe_image(void *efi, u64 efi_size,
 	struct efi_image_regions *regs = NULL;
 	void *new_efi = NULL;
 	u8 hash[TPM2_SHA512_DIGEST_SIZE];
+	struct udevice *dev;
 	efi_status_t ret;
 	u32 active;
 	int i;
@@ -904,16 +637,20 @@ static efi_status_t tcg2_hash_pe_image(void *efi, u64 efi_size,
 		goto out;
 	}
 
-	ret = __get_active_pcr_banks(&active);
+	ret = tcg2_platform_get_tpm2(&dev);
+	if (ret != EFI_SUCCESS)
+		goto out;
+
+	ret = tcg2_get_active_pcr_banks(dev, &active);
 	if (ret != EFI_SUCCESS) {
 		goto out;
 	}
 
 	digest_list->count = 0;
-	for (i = 0; i < MAX_HASH_COUNT; i++) {
-		u16 hash_alg = hash_algo_list[i].hash_alg;
+	for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); i++) {
+		u16 hash_alg = tpm2_supported_algorithms[i];
 
-		if (!(active & alg_to_mask(hash_alg)))
+		if (!(active & tpm2_algorithm_to_mask(hash_alg)))
 			continue;
 		switch (hash_alg) {
 		case TPM2_ALG_SHA1:
@@ -933,7 +670,7 @@ static efi_status_t tcg2_hash_pe_image(void *efi, u64 efi_size,
 		}
 		digest_list->digests[digest_list->count].hash_alg = hash_alg;
 		memcpy(&digest_list->digests[digest_list->count].digest, hash,
-		       (u32)alg_to_len(hash_alg));
+		       (u32)tpm2_algorithm_to_len(hash_alg));
 		digest_list->count++;
 	}
 
@@ -973,7 +710,7 @@ efi_status_t tcg2_measure_pe_image(void *efi, u64 efi_size,
 	if (!is_tcg2_protocol_installed())
 		return EFI_SUCCESS;
 
-	ret = platform_get_tpm2_device(&dev);
+	ret = tcg2_platform_get_tpm2(&dev);
 	if (ret != EFI_SUCCESS)
 		return EFI_SECURITY_VIOLATION;
 
@@ -1082,7 +819,7 @@ efi_tcg2_hash_log_extend_event(struct efi_tcg2_protocol *this, u64 flags,
 		goto out;
 	}
 
-	ret = platform_get_tpm2_device(&dev);
+	ret = tcg2_platform_get_tpm2(&dev);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
@@ -1117,7 +854,7 @@ efi_tcg2_hash_log_extend_event(struct efi_tcg2_protocol *this, u64 flags,
 		ret = tcg2_hash_pe_image((void *)(uintptr_t)data_to_hash,
 					 data_to_hash_len, &digest_list);
 	} else {
-		ret = tcg2_create_digest((u8 *)(uintptr_t)data_to_hash,
+		ret = tcg2_create_digest(dev, (u8 *)(uintptr_t)data_to_hash,
 					 data_to_hash_len, &digest_list);
 	}
 
@@ -1180,7 +917,7 @@ efi_tcg2_submit_command(struct efi_tcg2_protocol *this,
 		goto out;
 	}
 
-	ret = platform_get_tpm2_device(&dev);
+	ret = tcg2_platform_get_tpm2(&dev);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
@@ -1209,6 +946,7 @@ static efi_status_t EFIAPI
 efi_tcg2_get_active_pcr_banks(struct efi_tcg2_protocol *this,
 			      u32 *active_pcr_banks)
 {
+	struct udevice *dev;
 	efi_status_t ret;
 
 	if (!this || !active_pcr_banks) {
@@ -1216,8 +954,12 @@ efi_tcg2_get_active_pcr_banks(struct efi_tcg2_protocol *this,
 		goto out;
 	}
 
+	ret = tcg2_platform_get_tpm2(&dev);
+	if (ret != EFI_SUCCESS)
+		goto out;
+
 	EFI_ENTRY("%p, %p", this, active_pcr_banks);
-	ret = __get_active_pcr_banks(active_pcr_banks);
+	ret = tcg2_get_active_pcr_banks(dev, active_pcr_banks);
 
 out:
 	return EFI_EXIT(ret);
@@ -1268,397 +1010,6 @@ static const struct efi_tcg2_protocol efi_tcg2_protocol = {
 	.get_result_of_set_active_pcr_banks = efi_tcg2_get_result_of_set_active_pcr_banks,
 };
 
-/**
- * parse_event_log_header() -  Parse and verify the event log header fields
- *
- * @buffer:			Pointer to the start of the eventlog
- * @size:			Size of the eventlog
- * @pos:			Return offset of the next event in buffer right
- *				after the event header i.e specID
- *
- * Return:	status code
- */
-static efi_status_t parse_event_log_header(void *buffer, u32 size, u32 *pos)
-{
-	struct tcg_pcr_event *event_header = (struct tcg_pcr_event *)buffer;
-	int i = 0;
-
-	if (size < sizeof(*event_header))
-		return EFI_COMPROMISED_DATA;
-
-	if (get_unaligned_le32(&event_header->pcr_index) != 0 ||
-	    get_unaligned_le32(&event_header->event_type) != EV_NO_ACTION)
-		return EFI_COMPROMISED_DATA;
-
-	for (i = 0; i < sizeof(event_header->digest); i++) {
-		if (event_header->digest[i])
-			return EFI_COMPROMISED_DATA;
-	}
-
-	*pos += sizeof(*event_header);
-
-	return EFI_SUCCESS;
-}
-
-/**
- * parse_specid_event() -  Parse and verify the specID Event in the eventlog
- *
- * @dev:		udevice
- * @buffer:		Pointer to the start of the eventlog
- * @log_size:		Size of the eventlog
- * @pos:		[in] Offset of specID event in the eventlog buffer
- *			[out] Return offset of the next event in the buffer
- *			after the specID
- * @digest_list:	list of digests in the event
- *
- * Return:		status code
- * @pos			Offset in the eventlog where the specID event ends
- * @digest_list:	list of digests in the event
- */
-static efi_status_t parse_specid_event(struct udevice *dev, void *buffer,
-				       u32 log_size, u32 *pos,
-				       struct tpml_digest_values *digest_list)
-{
-	struct tcg_efi_spec_id_event *spec_event;
-	struct tcg_pcr_event *event_header = (struct tcg_pcr_event *)buffer;
-	size_t spec_event_size;
-	u32 active = 0, supported = 0, pcr_count = 0, alg_count = 0;
-	u32 spec_active = 0;
-	u16 hash_alg;
-	u8 vendor_sz;
-	int err, i;
-
-	if (*pos >= log_size || (*pos + sizeof(*spec_event)) > log_size)
-		return EFI_COMPROMISED_DATA;
-
-	/* Check specID event data */
-	spec_event = (struct tcg_efi_spec_id_event *)((uintptr_t)buffer + *pos);
-	/* Check for signature */
-	if (memcmp(spec_event->signature, TCG_EFI_SPEC_ID_EVENT_SIGNATURE_03,
-		   sizeof(TCG_EFI_SPEC_ID_EVENT_SIGNATURE_03))) {
-		log_err("specID Event: Signature mismatch\n");
-		return EFI_COMPROMISED_DATA;
-	}
-
-	if (spec_event->spec_version_minor !=
-			TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MINOR_TPM2 ||
-	    spec_event->spec_version_major !=
-			TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MAJOR_TPM2)
-		return EFI_COMPROMISED_DATA;
-
-	if (spec_event->number_of_algorithms > MAX_HASH_COUNT ||
-	    spec_event->number_of_algorithms < 1) {
-		log_err("specID Event: Number of algorithms incorrect\n");
-		return EFI_COMPROMISED_DATA;
-	}
-
-	alg_count = spec_event->number_of_algorithms;
-
-	err = tpm2_get_pcr_info(dev, &supported, &active, &pcr_count);
-	if (err)
-		return EFI_DEVICE_ERROR;
-
-	digest_list->count = 0;
-	/*
-	 * We have to take care that the sequence of algorithms that we record
-	 * in digest_list matches the sequence in eventlog.
-	 */
-	for (i = 0; i < alg_count; i++) {
-		hash_alg =
-		  get_unaligned_le16(&spec_event->digest_sizes[i].algorithm_id);
-
-		if (!(supported & alg_to_mask(hash_alg))) {
-			log_err("specID Event: Unsupported algorithm\n");
-			return EFI_COMPROMISED_DATA;
-		}
-		digest_list->digests[digest_list->count++].hash_alg = hash_alg;
-
-		spec_active |= alg_to_mask(hash_alg);
-	}
-
-	/*
-	 * TCG specification expects the event log to have hashes for all
-	 * active PCR's
-	 */
-	if (spec_active != active) {
-		/*
-		 * Previous stage bootloader should know all the active PCR's
-		 * and use them in the Eventlog.
-		 */
-		log_err("specID Event: All active hash alg not present\n");
-		return EFI_COMPROMISED_DATA;
-	}
-
-	/*
-	 * the size of the spec event and placement of vendor_info_size
-	 * depends on supported algoriths
-	 */
-	spec_event_size =
-		offsetof(struct tcg_efi_spec_id_event, digest_sizes) +
-		alg_count * sizeof(spec_event->digest_sizes[0]);
-
-	if (*pos + spec_event_size >= log_size)
-		return EFI_COMPROMISED_DATA;
-
-	vendor_sz = *(uint8_t *)((uintptr_t)buffer + *pos + spec_event_size);
-
-	spec_event_size += sizeof(vendor_sz) + vendor_sz;
-	*pos += spec_event_size;
-
-	if (get_unaligned_le32(&event_header->event_size) != spec_event_size) {
-		log_err("specID event: header event size mismatch\n");
-		/* Right way to handle this can be to call SetActive PCR's */
-		return EFI_COMPROMISED_DATA;
-	}
-
-	return EFI_SUCCESS;
-}
-
-/**
- * tcg2_parse_event() -  Parse the event in the eventlog
- *
- * @dev:		udevice
- * @buffer:		Pointer to the start of the eventlog
- * @log_size:		Size of the eventlog
- * @offset:		[in] Offset of the event in the eventlog buffer
- *			[out] Return offset of the next event in the buffer
- * @digest_list:	list of digests in the event
- * @pcr			Index of the PCR in the event
- *
- * Return:		status code
- */
-static efi_status_t tcg2_parse_event(struct udevice *dev, void *buffer,
-				     u32 log_size, u32 *offset,
-				     struct tpml_digest_values *digest_list,
-				     u32 *pcr)
-{
-	struct tcg_pcr_event2 *event = NULL;
-	u32 count, size, event_size;
-	size_t pos;
-
-	event_size = tcg_event_final_size(digest_list);
-	if (*offset >= log_size || *offset + event_size > log_size) {
-		log_err("Event exceeds log size\n");
-		return EFI_COMPROMISED_DATA;
-	}
-
-	event = (struct tcg_pcr_event2 *)((uintptr_t)buffer + *offset);
-	*pcr = get_unaligned_le32(&event->pcr_index);
-
-	/* get the count */
-	count = get_unaligned_le32(&event->digests.count);
-	if (count != digest_list->count)
-		return EFI_COMPROMISED_DATA;
-
-	pos = offsetof(struct tcg_pcr_event2, digests);
-	pos += offsetof(struct tpml_digest_values, digests);
-
-	for (int i = 0; i < digest_list->count; i++) {
-		u16 alg;
-		u16 hash_alg = digest_list->digests[i].hash_alg;
-		u8 *digest = (u8 *)&digest_list->digests[i].digest;
-
-		alg = get_unaligned_le16((void *)((uintptr_t)event + pos));
-
-		if (alg != hash_alg)
-			return EFI_COMPROMISED_DATA;
-
-		pos += offsetof(struct tpmt_ha, digest);
-		memcpy(digest, (void *)((uintptr_t)event + pos), alg_to_len(hash_alg));
-		pos += alg_to_len(hash_alg);
-	}
-
-	size = get_unaligned_le32((void *)((uintptr_t)event + pos));
-	event_size += size;
-	pos += sizeof(u32); /* tcg_pcr_event2 event_size*/
-	pos += size;
-
-	/* make sure the calculated buffer is what we checked against */
-	if (pos != event_size)
-		return EFI_COMPROMISED_DATA;
-
-	if (pos > log_size)
-		return EFI_COMPROMISED_DATA;
-
-	*offset += pos;
-
-	return EFI_SUCCESS;
-}
-
-/**
- * tcg2_get_fw_eventlog() -  Get the eventlog address and size
- *
- * If the previous firmware has passed some eventlog, this function get it's
- * location and check for it's validity.
- *
- * @dev:		udevice
- * @log_buffer:		eventlog address
- * @log_sz:		eventlog size
- *
- * Return:	status code
- */
-static efi_status_t tcg2_get_fw_eventlog(struct udevice *dev, void *log_buffer,
-					 size_t *log_sz)
-{
-	struct tpml_digest_values digest_list;
-	void *buffer;
-	efi_status_t ret;
-	u32 pcr, pos;
-	u64 base;
-	u32 sz;
-	bool extend_pcr = false;
-	int i;
-
-	ret = platform_get_eventlog(dev, &base, &sz);
-	if (ret != EFI_SUCCESS)
-		return ret;
-
-	if (sz > TPM2_EVENT_LOG_SIZE)
-		return EFI_VOLUME_FULL;
-
-	buffer = (void *)(uintptr_t)base;
-	pos = 0;
-	/* Parse the eventlog to check for its validity */
-	ret = parse_event_log_header(buffer, sz, &pos);
-	if (ret)
-		return ret;
-
-	ret = parse_specid_event(dev, buffer, sz, &pos, &digest_list);
-	if (ret) {
-		log_err("Error parsing SPEC ID Event\n");
-		return ret;
-	}
-
-	ret = tcg2_pcr_read(dev, 0, &digest_list);
-	if (ret) {
-		log_err("Error reading PCR 0\n");
-		return ret;
-	}
-
-	/*
-	 * If PCR0 is 0, previous firmware didn't have the capability
-	 * to extend the PCR. In this scenario, extend the PCR as
-	 * the eventlog is parsed.
-	 */
-	for (i = 0; i < digest_list.count; i++) {
-		u8 hash_buf[TPM2_SHA512_DIGEST_SIZE] = { 0 };
-		u16 hash_alg = digest_list.digests[i].hash_alg;
-
-		if (!memcmp((u8 *)&digest_list.digests[i].digest, hash_buf,
-			    alg_to_len(hash_alg)))
-			extend_pcr = true;
-	}
-
-	while (pos < sz) {
-		ret = tcg2_parse_event(dev, buffer, sz, &pos, &digest_list,
-				       &pcr);
-		if (ret) {
-			log_err("Error parsing event\n");
-			return ret;
-		}
-		if (extend_pcr) {
-			ret = tcg2_pcr_extend(dev, pcr, &digest_list);
-			if (ret != EFI_SUCCESS) {
-				log_err("Error in extending PCR\n");
-				return ret;
-			}
-
-			/* Clear the digest for next event */
-			for (i = 0; i < digest_list.count; i++) {
-				u16 hash_alg = digest_list.digests[i].hash_alg;
-				u8 *digest =
-				   (u8 *)&digest_list.digests[i].digest;
-
-				memset(digest, 0, alg_to_len(hash_alg));
-			}
-		}
-	}
-
-	memcpy(log_buffer, buffer, sz);
-	*log_sz = sz;
-
-	return ret;
-}
-
-/**
- * create_specid_event() - Create the first event in the eventlog
- *
- * @dev:			tpm device
- * @event_header:		Pointer to the final event header
- * @event_size:			final spec event size
- *
- * Return:	status code
- */
-static efi_status_t create_specid_event(struct udevice *dev, void *buffer,
-					size_t *event_size)
-{
-	struct tcg_efi_spec_id_event *spec_event;
-	size_t spec_event_size;
-	efi_status_t ret = EFI_DEVICE_ERROR;
-	u32 active = 0, supported = 0, pcr_count = 0, alg_count = 0;
-	int err;
-	size_t i;
-
-	/*
-	 * Create Spec event. This needs to be the first event in the log
-	 * according to the TCG EFI protocol spec
-	 */
-
-	/* Setup specID event data */
-	spec_event = (struct tcg_efi_spec_id_event *)buffer;
-	memcpy(spec_event->signature, TCG_EFI_SPEC_ID_EVENT_SIGNATURE_03,
-	       sizeof(spec_event->signature));
-	put_unaligned_le32(0, &spec_event->platform_class); /* type client */
-	spec_event->spec_version_minor =
-		TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MINOR_TPM2;
-	spec_event->spec_version_major =
-		TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MAJOR_TPM2;
-	spec_event->spec_errata =
-		TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_ERRATA_TPM2;
-	spec_event->uintn_size = sizeof(efi_uintn_t) / sizeof(u32);
-
-	err = tpm2_get_pcr_info(dev, &supported, &active, &pcr_count);
-
-	if (err)
-		goto out;
-
-	for (i = 0; i < pcr_count; i++) {
-		u16 hash_alg = hash_algo_list[i].hash_alg;
-		u16 hash_len = hash_algo_list[i].hash_len;
-
-		if (active & alg_to_mask(hash_alg)) {
-			put_unaligned_le16(hash_alg,
-					   &spec_event->digest_sizes[alg_count].algorithm_id);
-			put_unaligned_le16(hash_len,
-					   &spec_event->digest_sizes[alg_count].digest_size);
-			alg_count++;
-		}
-	}
-
-	spec_event->number_of_algorithms = alg_count;
-	if (spec_event->number_of_algorithms > MAX_HASH_COUNT ||
-	    spec_event->number_of_algorithms < 1)
-		goto out;
-
-	/*
-	 * the size of the spec event and placement of vendor_info_size
-	 * depends on supported algoriths
-	 */
-	spec_event_size =
-		offsetof(struct tcg_efi_spec_id_event, digest_sizes) +
-		spec_event->number_of_algorithms * sizeof(spec_event->digest_sizes[0]);
-	/* no vendor info for us */
-	memset(buffer + spec_event_size, 0, 1);
-	/* add a byte for vendor_info_size in the spec event */
-	spec_event_size += 1;
-	*event_size = spec_event_size;
-
-	return EFI_SUCCESS;
-
-out:
-	return ret;
-}
-
 /**
  * tcg2_uninit - remove the final event table and free efi memory on failures
  */
@@ -1720,7 +1071,7 @@ out:
 }
 
 /**
- * tcg2_measure_event() - common function to add event log and extend PCR
+ * measure_event() - common function to add event log and extend PCR
  *
  * @dev:		TPM device
  * @pcr_index:		PCR index
@@ -1730,14 +1081,13 @@ out:
  *
  * Return:	status code
  */
-static efi_status_t
-tcg2_measure_event(struct udevice *dev, u32 pcr_index, u32 event_type,
-		   u32 size, u8 event[])
+static efi_status_t measure_event(struct udevice *dev, u32 pcr_index,
+				  u32 event_type, u32 size, u8 event[])
 {
 	struct tpml_digest_values digest_list;
 	efi_status_t ret;
 
-	ret = tcg2_create_digest(event, size, &digest_list);
+	ret = tcg2_create_digest(dev, event, size, &digest_list);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
@@ -1764,9 +1114,8 @@ static efi_status_t efi_append_scrtm_version(struct udevice *dev)
 {
 	efi_status_t ret;
 
-	ret = tcg2_measure_event(dev, 0, EV_S_CRTM_VERSION,
-				 strlen(version_string) + 1,
-				 (u8 *)version_string);
+	ret = measure_event(dev, 0, EV_S_CRTM_VERSION,
+			    strlen(version_string) + 1, (u8 *)version_string);
 
 	return ret;
 }
@@ -1782,12 +1131,11 @@ static efi_status_t efi_init_event_log(void)
 	 * vendor_info_size is currently set to 0, we need to change the length
 	 * and allocate the flexible array member if this changes
 	 */
-	struct tcg_pcr_event *event_header = NULL;
+	struct tcg2_event_log elog;
 	struct udevice *dev;
-	size_t spec_event_size;
 	efi_status_t ret;
 
-	ret = platform_get_tpm2_device(&dev);
+	ret = tcg2_platform_get_tpm2(&dev);
 	if (ret != EFI_SUCCESS)
 		return ret;
 
@@ -1806,7 +1154,6 @@ static efi_status_t efi_init_event_log(void)
 	 * The log header is defined to be in SHA1 event log entry format.
 	 * Setup event header
 	 */
-	event_header =  (struct tcg_pcr_event *)event_log.buffer;
 	event_log.pos = 0;
 	event_log.last_event_size = 0;
 	event_log.get_event_called = false;
@@ -1817,34 +1164,20 @@ static efi_status_t efi_init_event_log(void)
 	 * Check if earlier firmware have passed any eventlog. Different
 	 * platforms can use different ways to do so.
 	 */
-	ret = tcg2_get_fw_eventlog(dev, event_log.buffer, &event_log.pos);
+	elog.log = event_log.buffer;
+	elog.log_size = TPM2_EVENT_LOG_SIZE;
+	ret = tcg2_log_prepare_buffer(dev, &elog, false);
+	if (ret != EFI_SUCCESS)
+		goto free_pool;
+
+	event_log.pos = elog.log_position;
+
 	/*
-	 * If earlier firmware hasn't passed any eventlog, go ahead and
-	 * create the eventlog header.
+	 * Add SCRTM version to the log if previous firmmware
+	 * doesn't pass an eventlog.
 	 */
-	if (ret == EFI_NOT_FOUND) {
-		put_unaligned_le32(0, &event_header->pcr_index);
-		put_unaligned_le32(EV_NO_ACTION, &event_header->event_type);
-		memset(&event_header->digest, 0, sizeof(event_header->digest));
-		ret = create_specid_event(dev,
-					  (void *)((uintptr_t)event_log.buffer +
-						   sizeof(*event_header)),
-					  &spec_event_size);
-		if (ret != EFI_SUCCESS)
-			goto free_pool;
-		put_unaligned_le32(spec_event_size, &event_header->event_size);
-		event_log.pos = spec_event_size + sizeof(*event_header);
-		event_log.last_event_size = event_log.pos;
-
-		/*
-		 * Add SCRTM version to the log if previous firmmware
-		 * doesn't pass an eventlog.
-		 */
+	if (!elog.found)
 		ret = efi_append_scrtm_version(dev);
-	}
-
-	if (ret != EFI_SUCCESS)
-		goto free_pool;
 
 	ret = create_final_event();
 	if (ret != EFI_SUCCESS)
@@ -1897,8 +1230,8 @@ static efi_status_t tcg2_measure_variable(struct udevice *dev, u32 pcr_index,
 		memcpy((u16 *)event->unicode_name + event->unicode_name_length,
 		       data, data_size);
 	}
-	ret = tcg2_measure_event(dev, pcr_index, event_type, event_size,
-				 (u8 *)event);
+	ret = measure_event(dev, pcr_index, event_type, event_size,
+			    (u8 *)event);
 	free(event);
 	return ret;
 }
@@ -2009,8 +1342,8 @@ tcg2_measure_smbios(struct udevice *dev,
 
 	smbios_prepare_measurement(entry, smbios_copy);
 
-	ret = tcg2_measure_event(dev, 1, EV_EFI_HANDOFF_TABLES2, event_size,
-				 (u8 *)event);
+	ret = measure_event(dev, 1, EV_EFI_HANDOFF_TABLES2, event_size,
+			    (u8 *)event);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
@@ -2161,7 +1494,7 @@ tcg2_measure_gpt_data(struct udevice *dev,
 		gpt_e = (gpt_entry *)((u8 *)gpt_e + gpt_h->sizeof_partition_entry);
 	}
 
-	ret = tcg2_measure_event(dev, 5, EV_EFI_GPT_EVENT, event_size, (u8 *)event);
+	ret = measure_event(dev, 5, EV_EFI_GPT_EVENT, event_size, (u8 *)event);
 
 out2:
 	free(gpt_h);
@@ -2215,7 +1548,7 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb)
 	if (!is_tcg2_protocol_installed())
 		return EFI_SUCCESS;
 
-	ret = platform_get_tpm2_device(&dev);
+	ret = tcg2_platform_get_tpm2(&dev);
 	if (ret != EFI_SUCCESS)
 		return EFI_SECURITY_VIOLATION;
 
@@ -2240,7 +1573,7 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb)
 	sha256_update(&hash_ctx, (u8 *)dtb + fdt_off_mem_rsvmap(dtb), rsvmap_size);
 	sha256_finish(&hash_ctx, blob->data + blob->blob_description_size);
 
-	ret = tcg2_measure_event(dev, 0, EV_POST_CODE, event_size, (u8 *)blob);
+	ret = measure_event(dev, 0, EV_POST_CODE, event_size, (u8 *)blob);
 
 	free(blob);
 	return ret;
@@ -2265,7 +1598,7 @@ efi_status_t efi_tcg2_measure_efi_app_invocation(struct efi_loaded_image_obj *ha
 	if (tcg2_efi_app_invoked)
 		return EFI_SUCCESS;
 
-	ret = platform_get_tpm2_device(&dev);
+	ret = tcg2_platform_get_tpm2(&dev);
 	if (ret != EFI_SUCCESS)
 		return EFI_SECURITY_VIOLATION;
 
@@ -2273,9 +1606,9 @@ efi_status_t efi_tcg2_measure_efi_app_invocation(struct efi_loaded_image_obj *ha
 	if (ret != EFI_SUCCESS)
 		goto out;
 
-	ret = tcg2_measure_event(dev, 4, EV_EFI_ACTION,
-				 strlen(EFI_CALLING_EFI_APPLICATION),
-				 (u8 *)EFI_CALLING_EFI_APPLICATION);
+	ret = measure_event(dev, 4, EV_EFI_ACTION,
+			    strlen(EFI_CALLING_EFI_APPLICATION),
+			    (u8 *)EFI_CALLING_EFI_APPLICATION);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
@@ -2291,8 +1624,8 @@ efi_status_t efi_tcg2_measure_efi_app_invocation(struct efi_loaded_image_obj *ha
 		goto out;
 
 	for (pcr_index = 0; pcr_index <= 7; pcr_index++) {
-		ret = tcg2_measure_event(dev, pcr_index, EV_SEPARATOR,
-					 sizeof(event), (u8 *)&event);
+		ret = measure_event(dev, pcr_index, EV_SEPARATOR,
+				    sizeof(event), (u8 *)&event);
 		if (ret != EFI_SUCCESS)
 			goto out;
 	}
@@ -2315,13 +1648,13 @@ efi_status_t efi_tcg2_measure_efi_app_exit(void)
 	if (!is_tcg2_protocol_installed())
 		return EFI_SUCCESS;
 
-	ret = platform_get_tpm2_device(&dev);
+	ret = tcg2_platform_get_tpm2(&dev);
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	ret = tcg2_measure_event(dev, 4, EV_EFI_ACTION,
-				 strlen(EFI_RETURNING_FROM_EFI_APPLICATION),
-				 (u8 *)EFI_RETURNING_FROM_EFI_APPLICATION);
+	ret = measure_event(dev, 4, EV_EFI_ACTION,
+			    strlen(EFI_RETURNING_FROM_EFI_APPLICATION),
+			    (u8 *)EFI_RETURNING_FROM_EFI_APPLICATION);
 	return ret;
 }
 
@@ -2346,19 +1679,19 @@ efi_tcg2_notify_exit_boot_services(struct efi_event *event, void *context)
 		goto out;
 	}
 
-	ret = platform_get_tpm2_device(&dev);
+	ret = tcg2_platform_get_tpm2(&dev);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
-	ret = tcg2_measure_event(dev, 5, EV_EFI_ACTION,
-				 strlen(EFI_EXIT_BOOT_SERVICES_INVOCATION),
-				 (u8 *)EFI_EXIT_BOOT_SERVICES_INVOCATION);
+	ret = measure_event(dev, 5, EV_EFI_ACTION,
+			    strlen(EFI_EXIT_BOOT_SERVICES_INVOCATION),
+			    (u8 *)EFI_EXIT_BOOT_SERVICES_INVOCATION);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
-	ret = tcg2_measure_event(dev, 5, EV_EFI_ACTION,
-				 strlen(EFI_EXIT_BOOT_SERVICES_SUCCEEDED),
-				 (u8 *)EFI_EXIT_BOOT_SERVICES_SUCCEEDED);
+	ret = measure_event(dev, 5, EV_EFI_ACTION,
+			    strlen(EFI_EXIT_BOOT_SERVICES_SUCCEEDED),
+			    (u8 *)EFI_EXIT_BOOT_SERVICES_SUCCEEDED);
 
 out:
 	EFI_EXIT(ret);
@@ -2378,19 +1711,19 @@ efi_status_t efi_tcg2_notify_exit_boot_services_failed(void)
 	if (!is_tcg2_protocol_installed())
 		return EFI_SUCCESS;
 
-	ret = platform_get_tpm2_device(&dev);
+	ret = tcg2_platform_get_tpm2(&dev);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
-	ret = tcg2_measure_event(dev, 5, EV_EFI_ACTION,
-				 strlen(EFI_EXIT_BOOT_SERVICES_INVOCATION),
-				 (u8 *)EFI_EXIT_BOOT_SERVICES_INVOCATION);
+	ret = measure_event(dev, 5, EV_EFI_ACTION,
+			    strlen(EFI_EXIT_BOOT_SERVICES_INVOCATION),
+			    (u8 *)EFI_EXIT_BOOT_SERVICES_INVOCATION);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
-	ret = tcg2_measure_event(dev, 5, EV_EFI_ACTION,
-				 strlen(EFI_EXIT_BOOT_SERVICES_FAILED),
-				 (u8 *)EFI_EXIT_BOOT_SERVICES_FAILED);
+	ret = measure_event(dev, 5, EV_EFI_ACTION,
+			    strlen(EFI_EXIT_BOOT_SERVICES_FAILED),
+			    (u8 *)EFI_EXIT_BOOT_SERVICES_FAILED);
 
 out:
 	return ret;
@@ -2460,7 +1793,7 @@ efi_status_t efi_tcg2_do_initial_measurement(void)
 	if (!is_tcg2_protocol_installed())
 		return EFI_SUCCESS;
 
-	ret = platform_get_tpm2_device(&dev);
+	ret = tcg2_platform_get_tpm2(&dev);
 	if (ret != EFI_SUCCESS)
 		return EFI_SECURITY_VIOLATION;
 
@@ -2486,7 +1819,7 @@ efi_status_t efi_tcg2_register(void)
 	struct efi_event *event;
 	u32 err;
 
-	ret = platform_get_tpm2_device(&dev);
+	ret = tcg2_platform_get_tpm2(&dev);
 	if (ret != EFI_SUCCESS) {
 		log_warning("Missing TPMv2 device for EFI_TCG_PROTOCOL\n");
 		return EFI_SUCCESS;
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 9ab5b46df1..bd0fb078dc 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -1,16 +1,705 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
+ * Copyright (c) 2023 Linaro Limited
  * Copyright (c) 2018 Bootlin
  * Author: Miquel Raynal <miquel.raynal@bootlin.com>
  */
 
 #include <common.h>
 #include <dm.h>
+#include <dm/of_access.h>
+#include <tpm_api.h>
 #include <tpm-common.h>
 #include <tpm-v2.h>
+#include <u-boot/sha1.h>
+#include <u-boot/sha256.h>
+#include <u-boot/sha512.h>
+#include <version_string.h>
+#include <asm/io.h>
 #include <linux/bitops.h>
+#include <linux/unaligned/be_byteshift.h>
+#include <linux/unaligned/generic.h>
+#include <linux/unaligned/le_byteshift.h>
+
 #include "tpm-utils.h"
 
+const enum tpm2_algorithms tpm2_supported_algorithms[4] = {
+	TPM2_ALG_SHA1,
+	TPM2_ALG_SHA256,
+	TPM2_ALG_SHA384,
+	TPM2_ALG_SHA512,
+};
+
+int tcg2_get_active_pcr_banks(struct udevice *dev, u32 *active_pcr_banks)
+{
+	u32 supported = 0;
+	u32 pcr_banks = 0;
+	u32 active = 0;
+	int rc;
+
+	rc = tpm2_get_pcr_info(dev, &supported, &active, &pcr_banks);
+	if (rc)
+		return rc;
+
+	*active_pcr_banks = active;
+
+	return 0;
+}
+
+u32 tcg2_event_get_size(struct tpml_digest_values *digest_list)
+{
+	u32 len;
+	size_t i;
+
+	len = offsetof(struct tcg_pcr_event2, digests);
+	len += offsetof(struct tpml_digest_values, digests);
+	for (i = 0; i < digest_list->count; ++i) {
+		u16 l = tpm2_algorithm_to_len(digest_list->digests[i].hash_alg);
+
+		if (!l)
+			continue;
+
+		len += l + offsetof(struct tpmt_ha, digest);
+	}
+	len += sizeof(u32);
+
+	return len;
+}
+
+int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
+		       struct tpml_digest_values *digest_list)
+{
+	u8 final[sizeof(union tpmu_ha)];
+	sha256_context ctx_256;
+	sha512_context ctx_512;
+	sha1_context ctx;
+	u32 active;
+	size_t i;
+	u32 len;
+	int rc;
+
+	rc = tcg2_get_active_pcr_banks(dev, &active);
+	if (rc)
+		return rc;
+
+	digest_list->count = 0;
+	for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
+		u32 mask =
+			tpm2_algorithm_to_mask(tpm2_supported_algorithms[i]);
+
+		if (!(active & mask))
+			continue;
+
+		switch (tpm2_supported_algorithms[i]) {
+		case TPM2_ALG_SHA1:
+			sha1_starts(&ctx);
+			sha1_update(&ctx, input, length);
+			sha1_finish(&ctx, final);
+			len = TPM2_SHA1_DIGEST_SIZE;
+			break;
+		case TPM2_ALG_SHA256:
+			sha256_starts(&ctx_256);
+			sha256_update(&ctx_256, input, length);
+			sha256_finish(&ctx_256, final);
+			len = TPM2_SHA256_DIGEST_SIZE;
+			break;
+		case TPM2_ALG_SHA384:
+			sha384_starts(&ctx_512);
+			sha384_update(&ctx_512, input, length);
+			sha384_finish(&ctx_512, final);
+			len = TPM2_SHA384_DIGEST_SIZE;
+			break;
+		case TPM2_ALG_SHA512:
+			sha512_starts(&ctx_512);
+			sha512_update(&ctx_512, input, length);
+			sha512_finish(&ctx_512, final);
+			len = TPM2_SHA512_DIGEST_SIZE;
+			break;
+		default:
+			printf("%s: unsupported algorithm %x\n", __func__,
+			       tpm2_supported_algorithms[i]);
+			continue;
+		}
+
+		digest_list->digests[digest_list->count].hash_alg =
+			tpm2_supported_algorithms[i];
+		memcpy(&digest_list->digests[digest_list->count].digest, final,
+		       len);
+		digest_list->count++;
+	}
+
+	return 0;
+}
+
+void tcg2_log_append(u32 pcr_index, u32 event_type,
+		     struct tpml_digest_values *digest_list, u32 size,
+		     const u8 *event, u8 *log)
+{
+	size_t len;
+	size_t pos;
+	u32 i;
+
+	pos = offsetof(struct tcg_pcr_event2, pcr_index);
+	put_unaligned_le32(pcr_index, log);
+	pos = offsetof(struct tcg_pcr_event2, event_type);
+	put_unaligned_le32(event_type, log + pos);
+	pos = offsetof(struct tcg_pcr_event2, digests) +
+		offsetof(struct tpml_digest_values, count);
+	put_unaligned_le32(digest_list->count, log + pos);
+
+	pos = offsetof(struct tcg_pcr_event2, digests) +
+		offsetof(struct tpml_digest_values, digests);
+	for (i = 0; i < digest_list->count; ++i) {
+		u16 hash_alg = digest_list->digests[i].hash_alg;
+
+		len = tpm2_algorithm_to_len(hash_alg);
+		if (!len)
+			continue;
+
+		pos += offsetof(struct tpmt_ha, hash_alg);
+		put_unaligned_le16(hash_alg, log + pos);
+		pos += offsetof(struct tpmt_ha, digest);
+		memcpy(log + pos, (u8 *)&digest_list->digests[i].digest, len);
+		pos += len;
+	}
+
+	put_unaligned_le32(size, log + pos);
+	pos += sizeof(u32);
+	memcpy(log + pos, event, size);
+}
+
+static int tcg2_log_append_check(struct tcg2_event_log *elog, u32 pcr_index,
+				 u32 event_type,
+				 struct tpml_digest_values *digest_list,
+				 u32 size, const u8 *event)
+{
+	u32 event_size;
+	u8 *log;
+
+	event_size = size + tcg2_event_get_size(digest_list);
+	if (elog->log_position + event_size > elog->log_size) {
+		printf("%s: log too large: %u + %u > %u\n", __func__,
+		       elog->log_position, event_size, elog->log_size);
+		return -ENOBUFS;
+	}
+
+	log = elog->log + elog->log_position;
+	elog->log_position += event_size;
+
+	tcg2_log_append(pcr_index, event_type, digest_list, size, event, log);
+
+	return 0;
+}
+
+static int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
+{
+	struct tcg_efi_spec_id_event *ev;
+	struct tcg_pcr_event *log;
+	u32 event_size;
+	u32 count = 0;
+	u32 log_size;
+	u32 active;
+	u32 mask;
+	size_t i;
+	u16 len;
+	int rc;
+
+	rc = tcg2_get_active_pcr_banks(dev, &active);
+	if (rc)
+		return rc;
+
+	event_size = offsetof(struct tcg_efi_spec_id_event, digest_sizes);
+	for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
+		mask = tpm2_algorithm_to_mask(tpm2_supported_algorithms[i]);
+
+		if (!(active & mask))
+			continue;
+
+		switch (tpm2_supported_algorithms[i]) {
+		case TPM2_ALG_SHA1:
+		case TPM2_ALG_SHA256:
+		case TPM2_ALG_SHA384:
+		case TPM2_ALG_SHA512:
+			count++;
+			break;
+		default:
+			continue;
+		}
+	}
+
+	event_size += 1 +
+		(sizeof(struct tcg_efi_spec_id_event_algorithm_size) * count);
+	log_size = offsetof(struct tcg_pcr_event, event) + event_size;
+
+	if (log_size > elog->log_size) {
+		printf("%s: log too large: %u > %u\n", __func__, log_size,
+		       elog->log_size);
+		return -ENOBUFS;
+	}
+
+	log = (struct tcg_pcr_event *)elog->log;
+	put_unaligned_le32(0, &log->pcr_index);
+	put_unaligned_le32(EV_NO_ACTION, &log->event_type);
+	memset(&log->digest, 0, sizeof(log->digest));
+	put_unaligned_le32(event_size, &log->event_size);
+
+	ev = (struct tcg_efi_spec_id_event *)log->event;
+	strlcpy((char *)ev->signature, TCG_EFI_SPEC_ID_EVENT_SIGNATURE_03,
+		sizeof(ev->signature));
+	put_unaligned_le32(0, &ev->platform_class);
+	ev->spec_version_minor = TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MINOR_TPM2;
+	ev->spec_version_major = TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MAJOR_TPM2;
+	ev->spec_errata = TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_ERRATA_TPM2;
+	ev->uintn_size = sizeof(size_t) / sizeof(u32);
+	put_unaligned_le32(count, &ev->number_of_algorithms);
+
+	count = 0;
+	for (i = 0; i < ARRAY_SIZE(tpm2_supported_algorithms); ++i) {
+		mask = tpm2_algorithm_to_mask(tpm2_supported_algorithms[i]);
+
+		if (!(active & mask))
+			continue;
+
+		len = tpm2_algorithm_to_len(tpm2_supported_algorithms[i]);
+		if (!len)
+			continue;
+
+		put_unaligned_le16(tpm2_supported_algorithms[i],
+				   &ev->digest_sizes[count].algorithm_id);
+		put_unaligned_le16(len, &ev->digest_sizes[count].digest_size);
+		count++;
+	}
+
+	*((u8 *)ev + (event_size - 1)) = 0;
+	elog->log_position = log_size;
+
+	return 0;
+}
+
+static int tcg2_replay_eventlog(struct tcg2_event_log *elog,
+				struct udevice *dev,
+				struct tpml_digest_values *digest_list,
+				u32 log_position)
+{
+	const u32 offset = offsetof(struct tcg_pcr_event2, digests) +
+		offsetof(struct tpml_digest_values, digests);
+	u32 event_size;
+	u32 count;
+	u16 algo;
+	u32 pcr;
+	u32 pos;
+	u16 len;
+	u8 *log;
+	int rc;
+	u32 i;
+
+	while (log_position + offset < elog->log_size) {
+		log = elog->log + log_position;
+
+		pos = offsetof(struct tcg_pcr_event2, pcr_index);
+		pcr = get_unaligned_le32(log + pos);
+		pos = offsetof(struct tcg_pcr_event2, event_type);
+		if (!get_unaligned_le32(log + pos))
+			return 0;
+
+		pos = offsetof(struct tcg_pcr_event2, digests) +
+			offsetof(struct tpml_digest_values, count);
+		count = get_unaligned_le32(log + pos);
+		if (count > ARRAY_SIZE(tpm2_supported_algorithms) ||
+		    (digest_list->count && digest_list->count != count))
+			return 0;
+
+		pos = offsetof(struct tcg_pcr_event2, digests) +
+			offsetof(struct tpml_digest_values, digests);
+		for (i = 0; i < count; ++i) {
+			pos += offsetof(struct tpmt_ha, hash_alg);
+			if (log_position + pos + sizeof(u16) >= elog->log_size)
+				return 0;
+
+			algo = get_unaligned_le16(log + pos);
+			pos += offsetof(struct tpmt_ha, digest);
+			switch (algo) {
+			case TPM2_ALG_SHA1:
+			case TPM2_ALG_SHA256:
+			case TPM2_ALG_SHA384:
+			case TPM2_ALG_SHA512:
+				len = tpm2_algorithm_to_len(algo);
+				break;
+			default:
+				return 0;
+			}
+
+			if (digest_list->count) {
+				if (algo != digest_list->digests[i].hash_alg ||
+				    log_position + pos + len >= elog->log_size)
+					return 0;
+
+				memcpy(digest_list->digests[i].digest.sha512,
+				       log + pos, len);
+			}
+
+			pos += len;
+		}
+
+		if (log_position + pos + sizeof(u32) >= elog->log_size)
+			return 0;
+
+		event_size = get_unaligned_le32(log + pos);
+		pos += event_size + sizeof(u32);
+		if (log_position + pos > elog->log_size)
+			return 0;
+
+		if (digest_list->count) {
+			rc = tcg2_pcr_extend(dev, pcr, digest_list);
+			if (rc)
+				return rc;
+		}
+
+		log_position += pos;
+	}
+
+	elog->log_position = log_position;
+	elog->found = true;
+	return 0;
+}
+
+static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
+{
+	struct tpml_digest_values digest_list;
+	struct tcg_efi_spec_id_event *event;
+	struct tcg_pcr_event *log;
+	u32 log_active;
+	u32 calc_size;
+	u32 active;
+	u32 count;
+	u32 evsz;
+	u32 mask;
+	u16 algo;
+	u16 len;
+	int rc;
+	u32 i;
+	u16 j;
+
+	if (elog->log_size <= offsetof(struct tcg_pcr_event, event))
+		return 0;
+
+	log = (struct tcg_pcr_event *)elog->log;
+	if (get_unaligned_le32(&log->pcr_index) != 0 ||
+	    get_unaligned_le32(&log->event_type) != EV_NO_ACTION)
+		return 0;
+
+	for (i = 0; i < sizeof(log->digest); i++) {
+		if (log->digest[i])
+			return 0;
+	}
+
+	evsz = get_unaligned_le32(&log->event_size);
+	if (evsz < offsetof(struct tcg_efi_spec_id_event, digest_sizes) ||
+	    evsz + offsetof(struct tcg_pcr_event, event) > elog->log_size)
+		return 0;
+
+	event = (struct tcg_efi_spec_id_event *)log->event;
+	if (memcmp(event->signature, TCG_EFI_SPEC_ID_EVENT_SIGNATURE_03,
+		   sizeof(TCG_EFI_SPEC_ID_EVENT_SIGNATURE_03)))
+		return 0;
+
+	if (event->spec_version_minor != TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MINOR_TPM2 ||
+	    event->spec_version_major != TCG_EFI_SPEC_ID_EVENT_SPEC_VERSION_MAJOR_TPM2)
+		return 0;
+
+	count = get_unaligned_le32(&event->number_of_algorithms);
+	if (count > ARRAY_SIZE(tpm2_supported_algorithms))
+		return 0;
+
+	calc_size = offsetof(struct tcg_efi_spec_id_event, digest_sizes) +
+		(sizeof(struct tcg_efi_spec_id_event_algorithm_size) * count) +
+		1;
+	if (evsz != calc_size)
+		return 0;
+
+	rc = tcg2_get_active_pcr_banks(dev, &active);
+	if (rc)
+		return rc;
+
+	digest_list.count = 0;
+	log_active = 0;
+
+	for (i = 0; i < count; ++i) {
+		algo = get_unaligned_le16(&event->digest_sizes[i].algorithm_id);
+		mask = tpm2_algorithm_to_mask(algo);
+
+		if (!(active & mask))
+			return 0;
+
+		switch (algo) {
+		case TPM2_ALG_SHA1:
+		case TPM2_ALG_SHA256:
+		case TPM2_ALG_SHA384:
+		case TPM2_ALG_SHA512:
+			len = get_unaligned_le16(&event->digest_sizes[i].digest_size);
+			if (tpm2_algorithm_to_len(algo) != len)
+				return 0;
+			digest_list.digests[digest_list.count++].hash_alg = algo;
+			break;
+		default:
+			return 0;
+		}
+
+		log_active |= mask;
+	}
+
+	/* Ensure the previous firmware extended all the PCRs. */
+	if (log_active != active)
+		return 0;
+
+	/* Read PCR0 to check if previous firmware extended the PCRs or not. */
+	rc = tcg2_pcr_read(dev, 0, &digest_list);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < digest_list.count; ++i) {
+		len = tpm2_algorithm_to_len(digest_list.digests[i].hash_alg);
+		for (j = 0; j < len; ++j) {
+			if (digest_list.digests[i].digest.sha512[j])
+				break;
+		}
+
+		/* PCR is non-zero; it has been extended, so skip extending. */
+		if (j != len) {
+			digest_list.count = 0;
+			break;
+		}
+	}
+
+	return tcg2_replay_eventlog(elog, dev, &digest_list,
+				    offsetof(struct tcg_pcr_event, event) +
+				    evsz);
+}
+
+int tcg2_pcr_extend(struct udevice *dev, u32 pcr_index,
+		    struct tpml_digest_values *digest_list)
+{
+	u32 rc;
+	u32 i;
+
+	for (i = 0; i < digest_list->count; i++) {
+		u32 alg = digest_list->digests[i].hash_alg;
+
+		rc = tpm2_pcr_extend(dev, pcr_index, alg,
+				     (u8 *)&digest_list->digests[i].digest,
+				     tpm2_algorithm_to_len(alg));
+		if (rc) {
+			printf("%s: error pcr:%u alg:%08x\n", __func__,
+			       pcr_index, alg);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+int tcg2_pcr_read(struct udevice *dev, u32 pcr_index,
+		  struct tpml_digest_values *digest_list)
+{
+	struct tpm_chip_priv *priv;
+	u32 rc;
+	u32 i;
+
+	priv = dev_get_uclass_priv(dev);
+	if (!priv)
+		return -ENODEV;
+
+	for (i = 0; i < digest_list->count; i++) {
+		u32 alg = digest_list->digests[i].hash_alg;
+		u8 *digest = (u8 *)&digest_list->digests[i].digest;
+
+		rc = tpm2_pcr_read(dev, pcr_index, priv->pcr_select_min, alg,
+				   digest, tpm2_algorithm_to_len(alg), NULL);
+		if (rc) {
+			printf("%s: error pcr:%u alg:%08x\n", __func__,
+			       pcr_index, alg);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+int tcg2_measure_data(struct udevice *dev, struct tcg2_event_log *elog,
+		      u32 pcr_index, u32 size, const u8 *data, u32 event_type,
+		      u32 event_size, const u8 *event)
+{
+	struct tpml_digest_values digest_list;
+	int rc;
+
+	if (data)
+		rc = tcg2_create_digest(dev, data, size, &digest_list);
+	else
+		rc = tcg2_create_digest(dev, event, event_size, &digest_list);
+	if (rc)
+		return rc;
+
+	rc = tcg2_pcr_extend(dev, pcr_index, &digest_list);
+	if (rc)
+		return rc;
+
+	return tcg2_log_append_check(elog, pcr_index, event_type, &digest_list,
+				     event_size, event);
+}
+
+int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
+			    bool ignore_existing_log)
+{
+	struct tcg2_event_log log;
+	int rc;
+
+	elog->log_position = 0;
+	elog->found = false;
+
+	rc = tcg2_platform_get_log(dev, (void **)&log.log, &log.log_size);
+	if (!rc) {
+		log.log_position = 0;
+		log.found = false;
+
+		if (!ignore_existing_log) {
+			rc = tcg2_log_parse(dev, &log);
+			if (rc)
+				return rc;
+		}
+
+		if (elog->log_size) {
+			if (log.found) {
+				if (elog->log_size < log.log_position)
+					return -ENOSPC;
+
+				/*
+				 * Copy the discovered log into the user buffer
+				 * if there's enough space.
+				 */
+				memcpy(elog->log, log.log, log.log_position);
+			}
+
+			unmap_physmem(log.log, MAP_NOCACHE);
+		} else {
+			elog->log = log.log;
+			elog->log_size = log.log_size;
+		}
+
+		elog->log_position = log.log_position;
+		elog->found = log.found;
+	}
+
+	/*
+	 * Initialize the log buffer if no log was discovered and the buffer is
+	 * valid. User's can pass in their own buffer as a fallback if no
+	 * memory region is found.
+	 */
+	if (!elog->found && elog->log_size)
+		rc = tcg2_log_init(dev, elog);
+
+	return rc;
+}
+
+int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog,
+			  bool ignore_existing_log)
+{
+	int rc;
+
+	rc = tcg2_platform_get_tpm2(dev);
+	if (rc)
+		return rc;
+
+	rc = tpm_auto_start(*dev);
+	if (rc)
+		return rc;
+
+	rc = tcg2_log_prepare_buffer(*dev, elog, ignore_existing_log);
+	if (rc) {
+		tcg2_measurement_term(*dev, elog, true);
+		return rc;
+	}
+
+	rc = tcg2_measure_event(*dev, elog, 0, EV_S_CRTM_VERSION,
+				strlen(version_string) + 1,
+				(u8 *)version_string);
+	if (rc) {
+		tcg2_measurement_term(*dev, elog, true);
+		return rc;
+	}
+
+	return 0;
+}
+
+void tcg2_measurement_term(struct udevice *dev, struct tcg2_event_log *elog,
+			   bool error)
+{
+	u32 event = error ? 0x1 : 0xffffffff;
+	int i;
+
+	for (i = 0; i < 8; ++i)
+		tcg2_measure_event(dev, elog, i, EV_SEPARATOR, sizeof(event),
+				   (const u8 *)&event);
+
+	if (elog->log)
+		unmap_physmem(elog->log, MAP_NOCACHE);
+}
+
+__weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
+{
+	const __be32 *addr_prop;
+	const __be32 *size_prop;
+	int asize;
+	int ssize;
+
+	*addr = NULL;
+	*size = 0;
+
+	addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
+	if (!addr_prop)
+		addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
+
+	size_prop = dev_read_prop(dev, "tpm_event_log_size", &ssize);
+	if (!size_prop)
+		size_prop = dev_read_prop(dev, "linux,sml-size", &ssize);
+
+	if (addr_prop && size_prop) {
+		u64 a = of_read_number(addr_prop, asize / sizeof(__be32));
+		u64 s = of_read_number(size_prop, ssize / sizeof(__be32));
+
+		*addr = map_physmem(a, s, MAP_NOCACHE);
+		*size = (u32)s;
+	} else {
+		struct ofnode_phandle_args args;
+		phys_addr_t a;
+		fdt_size_t s;
+
+		if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0,
+					       0, &args))
+			return -ENODEV;
+
+		a = ofnode_get_addr_size(args.node, "reg", &s);
+		if (a == FDT_ADDR_T_NONE)
+			return -ENOMEM;
+
+		*addr = map_physmem(a, s, MAP_NOCACHE);
+		*size = (u32)s;
+	}
+
+	return 0;
+}
+
+__weak int tcg2_platform_get_tpm2(struct udevice **dev)
+{
+	for_each_tpm_device(*dev) {
+		if (tpm_get_version(*dev) == TPM_V2)
+			return 0;
+	}
+
+	return -ENODEV;
+}
+
+__weak void tcg2_platform_startup_error(struct udevice *dev, int rc) {}
+
 u32 tpm2_startup(struct udevice *dev, enum tpm2_startup_types mode)
 {
 	const u8 command_v2[12] = {
@@ -359,6 +1048,131 @@ u32 tpm2_get_capability(struct udevice *dev, u32 capability, u32 property,
 	return 0;
 }
 
+static int tpm2_get_num_pcr(struct udevice *dev, u32 *num_pcr)
+{
+	u8 response[(sizeof(struct tpms_capability_data) -
+		offsetof(struct tpms_capability_data, data))];
+	u32 properties_offset =
+		offsetof(struct tpml_tagged_tpm_property, tpm_property) +
+		offsetof(struct tpms_tagged_property, value);
+	u32 ret;
+
+	memset(response, 0, sizeof(response));
+	ret = tpm2_get_capability(dev, TPM2_CAP_TPM_PROPERTIES,
+				  TPM2_PT_PCR_COUNT, response, 1);
+	if (ret)
+		return ret;
+
+	*num_pcr = get_unaligned_be32(response + properties_offset);
+	if (*num_pcr > TPM2_MAX_PCRS) {
+		printf("%s: too many pcrs: %u\n", __func__, *num_pcr);
+		return -E2BIG;
+	}
+
+	return 0;
+}
+
+static bool tpm2_is_active_pcr(struct tpms_pcr_selection *selection)
+{
+	int i;
+
+	/*
+	 * check the pcr_select. If at least one of the PCRs supports the
+	 * algorithm add it on the active ones
+	 */
+	for (i = 0; i < selection->size_of_select; i++) {
+		if (selection->pcr_select[i])
+			return true;
+	}
+
+	return false;
+}
+
+int tpm2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
+		      u32 *pcr_banks)
+{
+	u8 response[(sizeof(struct tpms_capability_data) -
+		offsetof(struct tpms_capability_data, data))];
+	struct tpml_pcr_selection pcrs;
+	u32 num_pcr;
+	size_t i;
+	u32 ret;
+
+	*supported_pcr = 0;
+	*active_pcr = 0;
+	*pcr_banks = 0;
+	memset(response, 0, sizeof(response));
+	ret = tpm2_get_capability(dev, TPM2_CAP_PCRS, 0, response, 1);
+	if (ret)
+		return ret;
+
+	pcrs.count = get_unaligned_be32(response);
+	/*
+	 * We only support 5 algorithms for now so check against that
+	 * instead of TPM2_NUM_PCR_BANKS
+	 */
+	if (pcrs.count > ARRAY_SIZE(tpm2_supported_algorithms) ||
+	    pcrs.count < 1) {
+		printf("%s: too many pcrs: %u\n", __func__, pcrs.count);
+		return -EMSGSIZE;
+	}
+
+	ret = tpm2_get_num_pcr(dev, &num_pcr);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < pcrs.count; i++) {
+		/*
+		 * Definition of TPMS_PCR_SELECTION Structure
+		 * hash: u16
+		 * size_of_select: u8
+		 * pcr_select: u8 array
+		 *
+		 * The offsets depend on the number of the device PCRs
+		 * so we have to calculate them based on that
+		 */
+		u32 hash_offset = offsetof(struct tpml_pcr_selection, selection) +
+			i * offsetof(struct tpms_pcr_selection, pcr_select) +
+			i * ((num_pcr + 7) / 8);
+		u32 size_select_offset =
+			hash_offset + offsetof(struct tpms_pcr_selection,
+					       size_of_select);
+		u32 pcr_select_offset =
+			hash_offset + offsetof(struct tpms_pcr_selection,
+					       pcr_select);
+
+		pcrs.selection[i].hash =
+			get_unaligned_be16(response + hash_offset);
+		pcrs.selection[i].size_of_select =
+			__get_unaligned_be(response + size_select_offset);
+		if (pcrs.selection[i].size_of_select > TPM2_PCR_SELECT_MAX) {
+			printf("%s: pcrs selection too large: %u\n", __func__,
+			       pcrs.selection[i].size_of_select);
+			return -ENOBUFS;
+		}
+		/* copy the array of pcr_select */
+		memcpy(pcrs.selection[i].pcr_select, response + pcr_select_offset,
+		       pcrs.selection[i].size_of_select);
+	}
+
+	for (i = 0; i < pcrs.count; i++) {
+		u32 hash_mask = tpm2_algorithm_to_mask(pcrs.selection[i].hash);
+
+		if (hash_mask) {
+			*supported_pcr |= hash_mask;
+			if (tpm2_is_active_pcr(&pcrs.selection[i]))
+				*active_pcr |= hash_mask;
+		} else {
+			printf("%s: unknown algorithm %x\n", __func__,
+			       pcrs.selection[i].hash);
+		}
+	}
+
+	*pcr_banks = pcrs.count;
+
+	return 0;
+}
+
 u32 tpm2_dam_reset(struct udevice *dev, const char *pw, const ssize_t pw_sz)
 {
 	u8 command_v2[COMMAND_BUFFER_SIZE] = {
-- 
2.39.3

