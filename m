Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08CBCD68E5
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 09:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5340D86DDA;
	Tue, 10 Oct 2023 11:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 579CA8647E; Tue, 10 Oct 2023 11:12:02 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5DB2B86459
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 11:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60F951FB;
 Tue, 10 Oct 2023 02:12:39 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A8CA3F762;
 Tue, 10 Oct 2023 02:11:55 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 1/6] tools: mkeficapsule: Add support to print capsule
 headers
Date: Tue, 10 Oct 2023 14:40:54 +0530
Message-Id: <20231010091059.375036-2-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010091059.375036-1-sughosh.ganu@linaro.org>
References: <20231010091059.375036-1-sughosh.ganu@linaro.org>
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

Add support to dump the contents of capsule headers. This is useful as
a debug feature for checking the contents of the capsule headers, and
can also be used in capsule verification.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since V1:
* Get rid of the superfluous hdr_size variable in the
  dump_fmp_payload_header() function

 tools/eficapsule.h   |   2 +
 tools/mkeficapsule.c | 227 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 228 insertions(+), 1 deletion(-)

diff --git a/tools/eficapsule.h b/tools/eficapsule.h
index 2099a2e9b8..6efd07d2eb 100644
--- a/tools/eficapsule.h
+++ b/tools/eficapsule.h
@@ -22,6 +22,8 @@
 #define __aligned(x)	__attribute__((__aligned__(x)))
 #endif
 
+#define ARRAY_SIZE(x)		(sizeof(x) / sizeof((x)[0]))
+
 typedef struct {
 	uint8_t b[16];
 } efi_guid_t __aligned(8);
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index 52be1f122e..b8fc6069b5 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -29,7 +29,7 @@ static const char *tool_name = "mkeficapsule";
 efi_guid_t efi_guid_fm_capsule = EFI_FIRMWARE_MANAGEMENT_CAPSULE_ID_GUID;
 efi_guid_t efi_guid_cert_type_pkcs7 = EFI_CERT_TYPE_PKCS7_GUID;
 
-static const char *opts_short = "g:i:I:v:p:c:m:o:dhAR";
+static const char *opts_short = "g:i:I:v:p:c:m:o:dhARD";
 
 enum {
 	CAPSULE_NORMAL_BLOB = 0,
@@ -49,6 +49,7 @@ static struct option options[] = {
 	{"fw-accept", no_argument, NULL, 'A'},
 	{"fw-revert", no_argument, NULL, 'R'},
 	{"capoemflag", required_argument, NULL, 'o'},
+	{"dump-capsule", no_argument, NULL, 'D'},
 	{"help", no_argument, NULL, 'h'},
 	{NULL, 0, NULL, 0},
 };
@@ -69,6 +70,7 @@ static void print_usage(void)
 		"\t-A, --fw-accept  firmware accept capsule, requires GUID, no image blob\n"
 		"\t-R, --fw-revert  firmware revert capsule, takes no GUID, no image blob\n"
 		"\t-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff\n"
+		"\t-D, --dump-capsule          dump the contents of the capsule headers\n"
 		"\t-h, --help                  print a help message\n",
 		tool_name);
 }
@@ -647,6 +649,215 @@ err:
 	return ret;
 }
 
+static void print_guid(void *ptr)
+{
+	int i;
+	efi_guid_t *guid = ptr;
+	const uint8_t seq[] = {
+		3, 2, 1, 0, '-', 5, 4, '-', 7, 6,
+		'-', 8, 9, '-', 10, 11, 12, 13, 14, 15 };
+
+	for (i = 0; i < ARRAY_SIZE(seq); i++) {
+		if (seq[i] == '-')
+			putchar(seq[i]);
+		else
+			printf("%02X", guid->b[seq[i]]);
+	}
+
+	printf("\n");
+}
+
+static uint32_t dump_fmp_payload_header(
+	struct fmp_payload_header *fmp_payload_hdr)
+{
+	if (fmp_payload_hdr->signature == FMP_PAYLOAD_HDR_SIGNATURE) {
+		printf("--------\n");
+		printf("FMP_PAYLOAD_HDR.SIGNATURE\t\t\t: %08X\n",
+		       FMP_PAYLOAD_HDR_SIGNATURE);
+		printf("FMP_PAYLOAD_HDR.HEADER_SIZE\t\t\t: %08X\n",
+		       fmp_payload_hdr->header_size);
+		printf("FMP_PAYLOAD_HDR.FW_VERSION\t\t\t: %08X\n",
+		       fmp_payload_hdr->fw_version);
+		printf("FMP_PAYLOAD_HDR.LOWEST_SUPPORTED_VERSION\t: %08X\n",
+		       fmp_payload_hdr->lowest_supported_version);
+		return fmp_payload_hdr->header_size;
+	}
+
+	return 0;
+}
+
+static void dump_capsule_auth_header(
+	struct efi_firmware_image_authentication *capsule_auth_hdr)
+{
+	printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08lX\n",
+	       capsule_auth_hdr->monotonic_count);
+	printf("EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.dwLENGTH\t: %08X\n",
+	       capsule_auth_hdr->auth_info.hdr.dwLength);
+	printf("EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.wREVISION\t: %08X\n",
+	       capsule_auth_hdr->auth_info.hdr.wRevision);
+	printf("EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.wCERTTYPE\t: %08X\n",
+	       capsule_auth_hdr->auth_info.hdr.wCertificateType);
+	printf("EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.CERT_TYPE\t: ");
+	print_guid(&capsule_auth_hdr->auth_info.cert_type);
+}
+
+static void dump_fmp_capsule_image_header(
+	struct efi_firmware_management_capsule_image_header *image_hdr)
+{
+	void *capsule_auth_hdr;
+	void *fmp_payload_hdr;
+	uint64_t signature_size = 0;
+	uint32_t payload_size = 0;
+	uint32_t fmp_payload_hdr_size = 0;
+	struct efi_firmware_image_authentication *auth_hdr;
+
+	printf("--------\n");
+	printf("FMP_CAPSULE_IMAGE_HDR.VERSION\t\t\t: %08X\n",
+	       image_hdr->version);
+	printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_IMAGE_TYPE_ID\t: ");
+	print_guid(&image_hdr->update_image_type_id);
+	printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_IMAGE_INDEX\t: %08X\n",
+	       image_hdr->update_image_index);
+	printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_IMAGE_SIZE\t\t: %08X\n",
+	       image_hdr->update_image_size);
+	printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_VENDOR_CODE_SIZE\t: %08X\n",
+	       image_hdr->update_vendor_code_size);
+	printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_HARDWARE_INSTANCE\t: %08lX\n",
+	       image_hdr->update_hardware_instance);
+	printf("FMP_CAPSULE_IMAGE_HDR.IMAGE_CAPSULE_SUPPORT\t: %08lX\n",
+	       image_hdr->image_capsule_support);
+
+	printf("--------\n");
+	if (image_hdr->image_capsule_support & CAPSULE_SUPPORT_AUTHENTICATION) {
+		capsule_auth_hdr = (char *)image_hdr + sizeof(*image_hdr);
+		dump_capsule_auth_header(capsule_auth_hdr);
+
+		auth_hdr = capsule_auth_hdr;
+		signature_size = sizeof(auth_hdr->monotonic_count) +
+			auth_hdr->auth_info.hdr.dwLength;
+		fmp_payload_hdr = (char *)capsule_auth_hdr + signature_size;
+	} else {
+		printf("Capsule Authentication Not Enabled\n");
+		fmp_payload_hdr = (char *)image_hdr + sizeof(*image_hdr);
+	}
+
+	fmp_payload_hdr_size = dump_fmp_payload_header(fmp_payload_hdr);
+
+	payload_size = image_hdr->update_image_size - signature_size -
+		fmp_payload_hdr_size;
+	printf("--------\n");
+	printf("Payload Image Size\t\t\t\t: %08X\n", payload_size);
+}
+
+static void dump_fmp_header(
+	struct efi_firmware_management_capsule_header *fmp_hdr)
+{
+	int i;
+	void *capsule_image_hdr;
+
+	printf("EFI_FMP_HDR.VERSION\t\t\t\t: %08X\n", fmp_hdr->version);
+	printf("EFI_FMP_HDR.EMBEDDED_DRIVER_COUNT\t\t: %08X\n",
+	       fmp_hdr->embedded_driver_count);
+	printf("EFI_FMP_HDR.PAYLOAD_ITEM_COUNT\t\t\t: %08X\n",
+	       fmp_hdr->payload_item_count);
+
+	/*
+	 * We currently don't support Embedded Drivers.
+	 * Only worry about the payload items.
+	 */
+	for (i = 0; i < fmp_hdr->payload_item_count; i++) {
+		capsule_image_hdr = (char *)fmp_hdr +
+			fmp_hdr->item_offset_list[i];
+		dump_fmp_capsule_image_header(capsule_image_hdr);
+	}
+}
+
+static void dump_capsule_header(struct efi_capsule_header *capsule_hdr)
+{
+	printf("EFI_CAPSULE_HDR.CAPSULE_GUID\t\t\t: ");
+	print_guid((void *)&capsule_hdr->capsule_guid);
+	printf("EFI_CAPSULE_HDR.HEADER_SIZE\t\t\t: %08X\n",
+	       capsule_hdr->header_size);
+	printf("EFI_CAPSULE_HDR.FLAGS\t\t\t\t: %08X\n", capsule_hdr->flags);
+	printf("EFI_CAPSULE_HDR.CAPSULE_IMAGE_SIZE\t\t: %08X\n",
+	       capsule_hdr->capsule_image_size);
+}
+
+static void normal_capsule_dump(void *capsule_buf)
+{
+	void *fmp_hdr;
+	struct efi_capsule_header *hdr = capsule_buf;
+
+	dump_capsule_header(hdr);
+	printf("--------\n");
+
+	fmp_hdr = (char *)capsule_buf + sizeof(*hdr);
+	dump_fmp_header(fmp_hdr);
+}
+
+static void empty_capsule_dump(void *capsule_buf)
+{
+	efi_guid_t *accept_image_guid;
+	struct efi_capsule_header *hdr = capsule_buf;
+	efi_guid_t efi_empty_accept_capsule = FW_ACCEPT_OS_GUID;
+
+	dump_capsule_header(hdr);
+
+	if (!memcmp(&efi_empty_accept_capsule, &hdr->capsule_guid,
+		    sizeof(efi_guid_t))) {
+		accept_image_guid = (void *)(char *)capsule_buf +
+			sizeof(struct efi_capsule_header);
+		printf("--------\n");
+		printf("ACCEPT_IMAGE_GUID\t\t\t\t: ");
+		print_guid(accept_image_guid);
+	}
+}
+
+static void dump_capsule_contents(char *capsule_file)
+{
+	int fd;
+	char *ptr;
+	efi_guid_t efi_fmp_guid = EFI_FIRMWARE_MANAGEMENT_CAPSULE_ID_GUID;
+	efi_guid_t efi_empty_accept_capsule = FW_ACCEPT_OS_GUID;
+	efi_guid_t efi_empty_revert_capsule = FW_REVERT_OS_GUID;
+	struct stat sbuf;
+
+	if (!capsule_file) {
+		fprintf(stderr, "No capsule file provided\n");
+		exit(EXIT_FAILURE);
+	}
+
+	if ((fd = open(capsule_file, O_RDONLY)) < 0) {
+		fprintf(stderr, "Error opening capsule file: %s\n",
+			capsule_file);
+		exit(EXIT_FAILURE);
+	}
+
+	if (fstat(fd, &sbuf) < 0) {
+		fprintf(stderr, "Can't stat capsule file: %s\n", capsule_file);
+		exit(EXIT_FAILURE);
+	}
+
+	if ((ptr = mmap(0, sbuf.st_size, PROT_READ, MAP_SHARED, fd, 0))
+	    == MAP_FAILED) {
+		fprintf(stderr, "Can't mmap capsule file: %s\n", capsule_file);
+		exit(EXIT_FAILURE);
+	}
+
+	if (!memcmp(&efi_fmp_guid, ptr, sizeof(efi_guid_t))) {
+		normal_capsule_dump(ptr);
+	} else if (!memcmp(&efi_empty_accept_capsule, ptr,
+		   sizeof(efi_guid_t)) ||
+		   !memcmp(&efi_empty_revert_capsule, ptr,
+			   sizeof(efi_guid_t))) {
+		empty_capsule_dump(ptr);
+	} else {
+		fprintf(stderr, "Unable to decode the capsule file: %s\n",
+			capsule_file);
+		exit(EXIT_FAILURE);
+	}
+}
+
 /**
  * main - main entry function of mkeficapsule
  * @argc:	Number of arguments
@@ -666,6 +877,7 @@ int main(int argc, char **argv)
 	unsigned long index, instance;
 	uint64_t mcount;
 	unsigned long oemflags;
+	bool capsule_dump;
 	char *privkey_file, *cert_file;
 	int c, idx;
 	struct fmp_payload_header_params fmp_ph_params = { 0 };
@@ -676,6 +888,7 @@ int main(int argc, char **argv)
 	mcount = 0;
 	privkey_file = NULL;
 	cert_file = NULL;
+	capsule_dump = false;
 	dump_sig = 0;
 	capsule_type = CAPSULE_NORMAL_BLOB;
 	oemflags = 0;
@@ -754,12 +967,24 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 			break;
+		case 'D':
+			capsule_dump = true;
+			break;
 		default:
 			print_usage();
 			exit(EXIT_SUCCESS);
 		}
 	}
 
+	if (capsule_dump) {
+		if (argc != optind + 1) {
+			fprintf(stderr, "Must provide the capsule file to parse\n");
+			exit(EXIT_FAILURE);
+		}
+		dump_capsule_contents(argv[argc - 1]);
+		exit(EXIT_SUCCESS);
+	}
+
 	/* check necessary parameters */
 	if ((capsule_type == CAPSULE_NORMAL_BLOB &&
 	    ((argc != optind + 2) || !guid ||
-- 
2.34.1

