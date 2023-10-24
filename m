Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79A9C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 15:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 637288798B;
	Tue, 24 Oct 2023 17:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="skrKQ9Fj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3534F87986; Tue, 24 Oct 2023 17:44:31 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71E7987984
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 17:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OFek3G029709; Tue, 24 Oct 2023 15:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=08zYGNljYFBqtManTizdkenssjWEzan0faRe7YZ5loQ=;
 b=skrKQ9Fj5+Xkesxy+E9PlldbfObcN2lD/ouHzzd+0woTF+itz10BDWl1RU+lmkxwXdAJ
 74RcnHrRsdzgd6A5WvBPJ+9bxXJ5XVeGITAQZYcmqfB6sAu41WZpntRh9aX2Kyms20Na
 ao6aZS1D2H/a25PSZ1Wx6l6k65h9VPm58q1RwdTCEbUup//PyMaDAm1kKCYwSCxa/AuG
 bRTBeltndFv6UhC+5YDiL4uUtpyyfqeYSvMt348kkhXdlRujaTK+GZwasGSYFBYa88iQ
 7raQML8/sUw5juL6HFup7mFmZwLBhkGDIb1WfnTAxzQZLxLh6eGNW+yn8hwYLCaoUzFV 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txgs6r3y7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:44:24 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39OFfAXM030562;
 Tue, 24 Oct 2023 15:44:12 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txgs6r3bj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:44:12 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OFDtXh024392; Tue, 24 Oct 2023 15:43:55 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvu6k02ed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:43:55 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39OFhteH33554912
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 15:43:55 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AF3758043;
 Tue, 24 Oct 2023 15:43:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53F9958055;
 Tue, 24 Oct 2023 15:43:55 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.72.218])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Oct 2023 15:43:55 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: u-boot@lists.denx.de
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de,
 eajames@linux.ibm.com
Subject: [PATCH v14 2/8] tpm: sandbox: Update for needed TPM2 capabilities
Date: Tue, 24 Oct 2023 10:43:48 -0500
Message-Id: <20231024154354.197524-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231024154354.197524-1-eajames@linux.ibm.com>
References: <20231024154354.197524-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vOIuTgM6P2H2m9rySL5RxsLwrZnBLGWO
X-Proofpoint-GUID: _mKZfcopnRSoHvaJnmZctSeHh2Kv8y_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240135
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

The driver needs to support getting the PCRs in the capabilities
command. Fix various other things and support the max number
of PCRs for TPM2.
Remove the !SANDBOX dependency for EFI TCG2 as well.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since v8:
 - Use >= for checking the property against TPM2_PROPERTIES_OFFSET

Changes since v5:
 - Remove the !SANDBOX dependency for EFI TCG2

 drivers/tpm/tpm2_tis_sandbox.c | 100 ++++++++++++++++++++++++---------
 lib/efi_loader/Kconfig         |   2 -
 2 files changed, 72 insertions(+), 30 deletions(-)

diff --git a/drivers/tpm/tpm2_tis_sandbox.c b/drivers/tpm/tpm2_tis_sandbox.c
index e4004cfcca..d15a28d9fc 100644
--- a/drivers/tpm/tpm2_tis_sandbox.c
+++ b/drivers/tpm/tpm2_tis_sandbox.c
@@ -22,11 +22,6 @@ enum tpm2_hierarchy {
 	TPM2_HIERARCHY_NB,
 };
 
-/* Subset of supported capabilities */
-enum tpm2_capability {
-	TPM_CAP_TPM_PROPERTIES = 0x6,
-};
-
 /* Subset of supported properties */
 #define TPM2_PROPERTIES_OFFSET 0x0000020E
 
@@ -38,7 +33,8 @@ enum tpm2_cap_tpm_property {
 	TPM2_PROPERTY_NB,
 };
 
-#define SANDBOX_TPM_PCR_NB 1
+#define SANDBOX_TPM_PCR_NB TPM2_MAX_PCRS
+#define SANDBOX_TPM_PCR_SELECT_MAX	((SANDBOX_TPM_PCR_NB + 7) / 8)
 
 /*
  * Information about our TPM emulation. This is preserved in the sandbox
@@ -433,7 +429,7 @@ static int sandbox_tpm2_xfer(struct udevice *dev, const u8 *sendbuf,
 	int i, j;
 
 	/* TPM2_GetProperty */
-	u32 capability, property, property_count;
+	u32 capability, property, property_count, val;
 
 	/* TPM2_PCR_Read/Extend variables */
 	int pcr_index = 0;
@@ -542,19 +538,32 @@ static int sandbox_tpm2_xfer(struct udevice *dev, const u8 *sendbuf,
 	case TPM2_CC_GET_CAPABILITY:
 		capability = get_unaligned_be32(sent);
 		sent += sizeof(capability);
-		if (capability != TPM_CAP_TPM_PROPERTIES) {
-			printf("Sandbox TPM only support TPM_CAPABILITIES\n");
-			return TPM2_RC_HANDLE;
-		}
-
 		property = get_unaligned_be32(sent);
 		sent += sizeof(property);
-		property -= TPM2_PROPERTIES_OFFSET;
-
 		property_count = get_unaligned_be32(sent);
 		sent += sizeof(property_count);
-		if (!property_count ||
-		    property + property_count > TPM2_PROPERTY_NB) {
+
+		switch (capability) {
+		case TPM2_CAP_PCRS:
+			break;
+		case TPM2_CAP_TPM_PROPERTIES:
+			if (!property_count) {
+				rc = TPM2_RC_HANDLE;
+				return sandbox_tpm2_fill_buf(recv, recv_len,
+							     tag, rc);
+			}
+
+			if (property >= TPM2_PROPERTIES_OFFSET &&
+			    ((property - TPM2_PROPERTIES_OFFSET) +
+			     property_count > TPM2_PROPERTY_NB)) {
+				rc = TPM2_RC_HANDLE;
+				return sandbox_tpm2_fill_buf(recv, recv_len,
+							     tag, rc);
+			}
+			break;
+		default:
+			printf("Sandbox TPM2 only supports TPM2_CAP_PCRS or "
+			       "TPM2_CAP_TPM_PROPERTIES\n");
 			rc = TPM2_RC_HANDLE;
 			return sandbox_tpm2_fill_buf(recv, recv_len, tag, rc);
 		}
@@ -578,18 +587,53 @@ static int sandbox_tpm2_xfer(struct udevice *dev, const u8 *sendbuf,
 		put_unaligned_be32(capability, recv);
 		recv += sizeof(capability);
 
-		/* Give the number of properties that follow */
-		put_unaligned_be32(property_count, recv);
-		recv += sizeof(property_count);
-
-		/* Fill with the properties */
-		for (i = 0; i < property_count; i++) {
-			put_unaligned_be32(TPM2_PROPERTIES_OFFSET + property +
-					   i, recv);
-			recv += sizeof(property);
-			put_unaligned_be32(tpm->properties[property + i],
-					   recv);
-			recv += sizeof(property);
+		switch (capability) {
+		case TPM2_CAP_PCRS:
+			/* Give the number of algorithms supported - just SHA256 */
+			put_unaligned_be32(1, recv);
+			recv += sizeof(u32);
+
+			/* Give SHA256 algorithm */
+			put_unaligned_be16(TPM2_ALG_SHA256, recv);
+			recv += sizeof(u16);
+
+			/* Select the PCRs supported */
+			*recv = SANDBOX_TPM_PCR_SELECT_MAX;
+			recv++;
+
+			/* Activate all the PCR bits */
+			for (i = 0; i < SANDBOX_TPM_PCR_SELECT_MAX; ++i) {
+				*recv = 0xff;
+				recv++;
+			}
+			break;
+		case TPM2_CAP_TPM_PROPERTIES:
+			/* Give the number of properties that follow */
+			put_unaligned_be32(property_count, recv);
+			recv += sizeof(property_count);
+
+			/* Fill with the properties */
+			for (i = 0; i < property_count; i++) {
+				put_unaligned_be32(property + i, recv);
+				recv += sizeof(property);
+				if (property >= TPM2_PROPERTIES_OFFSET) {
+					val = tpm->properties[(property -
+						TPM2_PROPERTIES_OFFSET) + i];
+				} else {
+					switch (property) {
+					case TPM2_PT_PCR_COUNT:
+						val = SANDBOX_TPM_PCR_NB;
+						break;
+					default:
+						val = 0xffffffff;
+						break;
+					}
+				}
+
+				put_unaligned_be32(val, recv);
+				recv += sizeof(property);
+			}
+			break;
 		}
 
 		/* Add trailing \0 */
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index d20aaab6db..4ccd26f94a 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -379,8 +379,6 @@ config EFI_TCG2_PROTOCOL
 	bool "EFI_TCG2_PROTOCOL support"
 	default y
 	depends on TPM_V2
-	# Sandbox TPM currently fails on GetCapabilities needed for TCG2
-	depends on !SANDBOX
 	select SHA1
 	select SHA256
 	select SHA384
-- 
2.39.3

