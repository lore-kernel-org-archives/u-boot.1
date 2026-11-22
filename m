Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC740606A330
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w6MGJwPp;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=qI1J6xLI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BD72808D9;
	Sun, 22 Nov 2026 13:42:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z0INdMFp-qUF; Sun, 22 Nov 2026 13:41:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B53E980DCA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795354918;
	b=nWZ8ZBcrU+AP2yjQKv6p7XePLPNlam48GSUdIY3QHzpdobpiRZ1xpcwX/oOAioGd6+rc
	 ZQGnHdDaVyU2PR7D8r1HbhAEy5QIBhXhLLMGUW2U3QDJCVqgHPMleGsrPRv5uwj0uwwm/
	 f0lUuFuK7lCS9559rlIXtwkF5gpIhr0CWzii4swvE6n/ngK8RJTJ5/YYbdz/Un08zhHvO
	 1jr41gidJH45C908iGkReVlHNeH9FbYs/jMTP23qei+2WJZtwaE8zUd9hduF9wRzMAwna
	 F3Zx9/rNIUq5a24hXP/zhqemR/jpw8g6PSuj75Ik//ueDmmB9mq4gqjVz8yoaj/OhpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795354918;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=O5ZaWcxNQfGXsEZEdPLvgDpYcir2LlWvOgqLkNAvj+s=;
	b=qlVII5/I3wdZly03wSFaL3O2v5mt6DqSeSMGAX6fbQkqLmO5u8GQVRvo9+AQ33BeMSwd
	 ImtFJXuVWb9gv0aKm3WtxpuvZyKBa3iMXNIoA2cn/tDihOHR+0a7hNCJQN+93c+V/+EIH
	 vhDvG40+uqU0IYHaXDTUgfMGxpXsjYoN6xrXiyUU6A/GPR5dqV2hxT62RHWVsd0Q/oWWi
	 +k+uhv5/TpW4+NWPOrAAfqa4Nh/r4Z1xdL+PZ6z3lIAlnOWXi+oGj/gEuutEKJDPFYg23
	 Ibm8e7VF2BXUUrah+WUPFNyUlVPJqNKT7WxJnAROmVIgsHdaUEn8bwuwrpqXKVVOagg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795354918;
	bh=O5ZaWcxNQfGXsEZEdPLvgDpYcir2LlWvOgqLkNAvj+s=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=w6MGJwPprpJn+nJjtyyIex8Ue/p233wE+3sXWIkjSBFB8pO9icbT1dH6g7M5DuMyP
	 WIGGV0Eo3aPjtciRH6rT4AgJqhQKbda3mshEdEiQiNHVpDGwD1Qcz7NjcaI7ScxjEb
	 vvOayq2j30tGGer8mtidysBuqN0jJjiQ1tiwGJ2SIX/NK+/v2/KZ8p9b300+aOV0kD
	 /lp8jF2GDGfZqv9tYFMx1Fx8fnNeuLDKsahIrE/kW7ylNt1RSKJKHDncJz/pZG+ng9
	 Rz8NgGbh7eGYibhC+/JnGeF3jI8W/XLrvbsXYQC/6jaF6zIxjIoDbofs5Oa3jT0VVB
	 +nzOevj72inZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B53E980DCA;
	Sun, 22 Nov 2026 13:41:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 11361371
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 13:41:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0335F40561
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 13:41:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ltrU6MNGBqvV for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 13:41:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7C6EF40540
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.120
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=qI1J6xLI
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C6EF40540
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 13:41:54 +0000 (UTC)
Received: from LT03.fritz.box (ip-084-119-040-110.um24.pools.vodafone-ip.de
 [84.119.40.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B328F3F23C; 
 Sun, 22 Nov 2026 13:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795354911;
 bh=O5ZaWcxNQfGXsEZEdPLvgDpYcir2LlWvOgqLkNAvj+s=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=qI1J6xLIs+xdf+EtJT8ZbzX0HcxMhOK+v9EIfUaEqC2bVOkNNvm4DKEto8ZuxQ2np
 MPN4akIw1odAsU7adwHK1PTmHhckkJgHcNZSTPZjRTNncdOj8kAzEn7QIGe6iL2CW+
 VjuS3Gk5AXAst9EMpPnMymehzT5J6vZjMjJAM8dxCBp7/7J5fGDi/E1PT6OkyCe9bD
 lSUuOUV5mhuWZOSDDcn7Z3hPuh+y0+jewh3llod2pWW/leok9Ebu9ezxnblaFfLnPF
 sOwe3stw1NBcYX0bUK3WFPiKudJA9U7RReDLAwgqIiGvfGsNJoBQRi4Dy4XFK4hMWu
 5D5QekJdMAfVrnZScW0xqolXkPmjnrtkYYajAd0hQcp2BMnLMfkz+sm+cDjHmugT5k
 GaFGM93zqyHluS2cRrwalNvDlsYURY3HVDmgkE3Xyn2XQIHfppaxJP6+lPtWbbB8uz
 hIisyVZYpPQTfoLYBUuq24kWr2aE1Yts4iywoKDMEW/jj0z8DQPwbAItvTz1ribkcn
 MGJpzQ7yQ4b+tgI5ZCo+iGSRY9onhyCYOZvVXsBbySBBJz5b4vEvEh4uhvC4NTg0cG
 dnN6aqMagEFgx7CCPuadx8m5FzZkIdPLx2v1A3svjX9oJZHebd2TIg8J0h2WJUnSBD
 HxolQ8NX29tnOnXFvyNj7lQs=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] efi_loader: use EFI_PRINT() in efi_image_loader.c
Date: Sun, 22 Nov 2026 14:41:47 +0100
Message-ID: <20261122134147.237839-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The functions in efi_image_loader.c run inside the UEFI boot service
LoadImage() and in other API calls like SetVariable() and
UpdateCapsule(). Writing errors with log_err() there can mess up the
console output of the running UEFI application.

Use EFI_PRINT() instead. It writes an indented message with the EFI
prefix and is only active if DEBUG is defined.

Do not print __func__ in the messages. Depending on CONFIG_LOGF_FUNC the
log system already adds the function name.

The messages are no longer shown in a default build. The status codes
returned by the services already tell the caller what went wrong.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_image_loader.c | 54 +++++++++++++++----------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index a03866c2907..cb5af68e49f 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -220,14 +220,14 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
 			case IMAGE_REL_BASED_RISCV_LOW12S:
 				/* We know that we're 4k aligned */
 				if (delta & 0xfff) {
-					log_err("Unsupported reloc offset\n");
+					EFI_PRINT("Unsupported reloc offset\n");
 					return EFI_LOAD_ERROR;
 				}
 				break;
 #endif
 			default:
-				log_err("Unknown Relocation off %lx type %x\n",
-					offset, type);
+				EFI_PRINT("Unknown Relocation off %lx type %x\n",
+					  offset, type);
 				return EFI_LOAD_ERROR;
 			}
 			relocs++;
@@ -264,7 +264,7 @@ static void efi_set_code_and_data_type(
 		loaded_image_info->image_data_type = EFI_RUNTIME_SERVICES_DATA;
 		break;
 	default:
-		log_err("invalid image type: %u\n", image_type);
+		EFI_PRINT("invalid image type: %u\n", image_type);
 		/* Let's assume it is an application */
 		loaded_image_info->image_code_type = EFI_LOADER_CODE;
 		loaded_image_info->image_data_type = EFI_LOADER_DATA;
@@ -297,7 +297,7 @@ efi_status_t efi_image_region_add(struct efi_image_regions *regs,
 	int i, j;
 
 	if (regs->num >= regs->max) {
-		log_err("%s: no more room for regions\n", __func__);
+		EFI_PRINT("no more room for regions\n");
 		return EFI_OUT_OF_RESOURCES;
 	}
 
@@ -322,7 +322,7 @@ efi_status_t efi_image_region_add(struct efi_image_regions *regs,
 		}
 
 		/* new data overlapping registered region */
-		log_err("%s: new region already part of another\n", __func__);
+		EFI_PRINT("new region already part of another\n");
 		return EFI_INVALID_PARAMETER;
 	}
 
@@ -493,8 +493,8 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
 		bytes_hashed = opt->SizeOfHeaders;
 		align = opt->FileAlignment;
 	} else {
-		log_err("%s: Invalid optional header magic %x\n", __func__,
-			nt->OptionalHeader.Magic);
+		EFI_PRINT("Invalid optional header magic %x\n",
+			  nt->OptionalHeader.Magic);
 		goto err;
 	}
 
@@ -504,7 +504,7 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
 			    nt->FileHeader.SizeOfOptionalHeader);
 	sorted = calloc(sizeof(IMAGE_SECTION_HEADER *), num_sections);
 	if (!sorted) {
-		log_err("%s: Out of memory\n", __func__);
+		EFI_PRINT("Out of memory\n");
 		goto err;
 	}
 
@@ -546,13 +546,13 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
 	/* Return Certificates Table */
 	if (authsz) {
 		if (len < authoff + authsz) {
-			log_err("%s: Size for auth too large: %u >= %zu\n",
-				__func__, authsz, len - authoff);
+			EFI_PRINT("Size for auth too large: %u >= %zu\n",
+				  authsz, len - authoff);
 			goto err;
 		}
 		if (authsz < sizeof(*auth)) {
-			log_err("%s: Size for auth too small: %u < %zu\n",
-				__func__, authsz, sizeof(*auth));
+			EFI_PRINT("Size for auth too small: %u < %zu\n",
+				  authsz, sizeof(*auth));
 			goto err;
 		}
 		*auth = efi + authoff;
@@ -665,7 +665,7 @@ static bool efi_image_authenticate(void *efi, size_t efi_size)
 
 	if (!efi_image_parse(new_efi, new_efi_size, &regs, &wincerts,
 			     &wincerts_len)) {
-		log_err("Parsing PE executable image failed\n");
+		EFI_PRINT("Parsing PE executable image failed\n");
 		goto out;
 	}
 
@@ -674,13 +674,13 @@ static bool efi_image_authenticate(void *efi, size_t efi_size)
 	 */
 	db = efi_sigstore_parse_sigdb(u"db");
 	if (!db) {
-		log_err("Getting signature database(db) failed\n");
+		EFI_PRINT("Getting signature database(db) failed\n");
 		goto out;
 	}
 
 	dbx = efi_sigstore_parse_sigdb(u"dbx");
 	if (!dbx) {
-		log_err("Getting signature database(dbx) failed\n");
+		EFI_PRINT("Getting signature database(dbx) failed\n");
 		goto out;
 	}
 
@@ -744,7 +744,7 @@ static bool efi_image_authenticate(void *efi, size_t efi_size)
 
 		msg = pkcs7_parse_message(auth, auth_size);
 		if (IS_ERR(msg)) {
-			log_err("Parsing image's signature failed\n");
+			EFI_PRINT("Parsing image's signature failed\n");
 			msg = NULL;
 			continue;
 		}
@@ -912,7 +912,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 
 	ret = efi_check_pe(efi, efi_size, (void **)&nt);
 	if (ret != EFI_SUCCESS) {
-		log_err("Not a PE-COFF file\n");
+		EFI_PRINT("Not a PE-COFF file\n");
 		return EFI_LOAD_ERROR;
 	}
 
@@ -923,8 +923,8 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 		}
 
 	if (!supported) {
-		log_err("Machine type 0x%04x is not supported\n",
-			nt->FileHeader.Machine);
+		EFI_PRINT("Machine type 0x%04x is not supported\n",
+			  nt->FileHeader.Machine);
 		return EFI_LOAD_ERROR;
 	}
 
@@ -934,7 +934,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 
 	if (efi_size < ((void *)sections + sizeof(sections[0]) * num_sections
 			- efi)) {
-		log_err("Invalid number of sections: %d\n", num_sections);
+		EFI_PRINT("Invalid number of sections: %d\n", num_sections);
 		return EFI_LOAD_ERROR;
 	}
 
@@ -943,7 +943,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 		handle->auth_status = EFI_IMAGE_AUTH_PASSED;
 	} else {
 		handle->auth_status = EFI_IMAGE_AUTH_FAILED;
-		log_err("Image not authenticated\n");
+		EFI_PRINT("Image not authenticated\n");
 	}
 
 	/* Calculate upper virtual address boundary */
@@ -965,7 +965,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 						    loaded_image_info->image_code_type,
 						    opt->SectionAlignment);
 		if (!efi_reloc) {
-			log_err("Out of memory\n");
+			EFI_PRINT("Out of memory\n");
 			ret = EFI_OUT_OF_RESOURCES;
 			goto err;
 		}
@@ -981,7 +981,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 						    loaded_image_info->image_code_type,
 						    opt->SectionAlignment);
 		if (!efi_reloc) {
-			log_err("Out of memory\n");
+			EFI_PRINT("Out of memory\n");
 			ret = EFI_OUT_OF_RESOURCES;
 			goto err;
 		}
@@ -989,8 +989,8 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 		rel_size = opt->DataDirectory[rel_idx].Size;
 		rel = efi_reloc + opt->DataDirectory[rel_idx].VirtualAddress;
 	} else {
-		log_err("Invalid optional header magic %x\n",
-			nt->OptionalHeader.Magic);
+		EFI_PRINT("Invalid optional header magic %x\n",
+			  nt->OptionalHeader.Magic);
 		ret = EFI_LOAD_ERROR;
 		goto err;
 	}
@@ -1003,7 +1003,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 		 * TCG2 Protocol is installed but no TPM device found,
 		 * this is not expected.
 		 */
-		log_err("PE image measurement failed, no tpm device found\n");
+		EFI_PRINT("PE image measurement failed, no tpm device found\n");
 		handle->auth_status = EFI_IMAGE_AUTH_FAILED;
 	}
 #endif
-- 
2.53.0

