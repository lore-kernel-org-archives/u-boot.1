Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D11BE677EE
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 07:08:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85E138899C;
	Sat,  2 Nov 2024 08:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cJy6V9RJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D52988A4C; Sat,  2 Nov 2024 08:07:59 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AC30888EB
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 08:07:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8C369408DA; 
 Sat,  2 Nov 2024 07:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730531276;
 bh=Xdy3h1gZG/dm/HB4EJIPf/VlvUmD/nZjmZN/PcM4Gzo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=cJy6V9RJTqlcvRNjXmhw9kEqR0jsmNi7wf5lhiEN8auSYiRuXl4HL/WYNIT22zxeu
 rkMVPFUWUUcLZ8lenpFPpCLyELPE1Z1z6tdCu4qj2xvRTEkJQxqvN8xqSjWoMCMwu5
 C1oC+GHdRXiH3p0I1YY5quVmUnimL1pO7MEcw7bD0wytpLZkP9eyLaaJKT443PzYp5
 wRi/HxFMkvVvfDyUXLcgDlgKJ1GLQXqP99wOI6e9L/5rB2A+VIbU6iCnvGNhRe9HmE
 D5x+28IiggM4WKrHKug0YQHUJInmxUpw7BlaTSfGY5k8QJRlpRI0kHI5uvVGeQJEh3
 6T25BfgtxNQAQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: use '%#x' instead of '0x%x'
Date: Sat,  2 Nov 2024 08:07:02 +0100
Message-ID: <20241102070702.50099-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

We can save a few bytes by using '%#x' instead of '0x%x' in printf
statements.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_boottime.c            | 20 ++++++++++----------
 lib/efi_loader/efi_device_path_to_text.c | 20 ++++++++++----------
 lib/efi_loader/efi_hii_config.c          |  2 +-
 lib/efi_loader/efi_image_loader.c        | 10 +++++-----
 lib/efi_loader/efi_memory.c              |  4 ++--
 lib/efi_loader/efi_signature.c           |  2 +-
 lib/efi_loader/efi_variable_tee.c        |  2 +-
 7 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 4f52284b4c6..01a5182b417 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -372,7 +372,7 @@ static unsigned long EFIAPI efi_raise_tpl(efi_uintn_t new_tpl)
 {
 	efi_uintn_t old_tpl = efi_tpl;
 
-	EFI_ENTRY("0x%zx", new_tpl);
+	EFI_ENTRY("%#zx", new_tpl);
 
 	if (new_tpl < efi_tpl)
 		EFI_PRINT("WARNING: new_tpl < current_tpl in %s\n", __func__);
@@ -395,7 +395,7 @@ static unsigned long EFIAPI efi_raise_tpl(efi_uintn_t new_tpl)
  */
 static void EFIAPI efi_restore_tpl(efi_uintn_t old_tpl)
 {
-	EFI_ENTRY("0x%zx", old_tpl);
+	EFI_ENTRY("%#zx", old_tpl);
 
 	if (old_tpl > efi_tpl)
 		EFI_PRINT("WARNING: old_tpl > current_tpl in %s\n", __func__);
@@ -431,7 +431,7 @@ static efi_status_t EFIAPI efi_allocate_pages_ext(int type, int memory_type,
 {
 	efi_status_t r;
 
-	EFI_ENTRY("%d, %d, 0x%zx, %p", type, memory_type, pages, memory);
+	EFI_ENTRY("%d, %d, %#zx, %p", type, memory_type, pages, memory);
 	r = efi_allocate_pages(type, memory_type, pages, memory);
 	return EFI_EXIT(r);
 }
@@ -453,7 +453,7 @@ static efi_status_t EFIAPI efi_free_pages_ext(uint64_t memory,
 {
 	efi_status_t r;
 
-	EFI_ENTRY("%llx, 0x%zx", memory, pages);
+	EFI_ENTRY("%llx, %#zx", memory, pages);
 	r = efi_free_pages(memory, pages);
 	return EFI_EXIT(r);
 }
@@ -797,7 +797,7 @@ efi_status_t EFIAPI efi_create_event_ex(uint32_t type, efi_uintn_t notify_tpl,
 {
 	efi_status_t ret;
 
-	EFI_ENTRY("%d, 0x%zx, %p, %p, %pUs", type, notify_tpl, notify_function,
+	EFI_ENTRY("%d, %#zx, %p, %p, %pUs", type, notify_tpl, notify_function,
 		  notify_context, event_group);
 
 	/*
@@ -839,7 +839,7 @@ static efi_status_t EFIAPI efi_create_event_ext(
 					void *context),
 			void *notify_context, struct efi_event **event)
 {
-	EFI_ENTRY("%d, 0x%zx, %p, %p", type, notify_tpl, notify_function,
+	EFI_ENTRY("%d, %#zx, %p, %p", type, notify_tpl, notify_function,
 		  notify_context);
 	return EFI_EXIT(efi_create_event(type, notify_tpl, notify_function,
 					 notify_context, NULL, event));
@@ -2337,7 +2337,7 @@ static efi_status_t EFIAPI efi_set_watchdog_timer(unsigned long timeout,
 						  unsigned long data_size,
 						  uint16_t *watchdog_data)
 {
-	EFI_ENTRY("%ld, 0x%llx, %ld, %p", timeout, watchdog_code,
+	EFI_ENTRY("%ld, %#llx, %ld, %p", timeout, watchdog_code,
 		  data_size, watchdog_data);
 	return EFI_EXIT(efi_set_watchdog(timeout));
 }
@@ -2982,7 +2982,7 @@ static void EFIAPI efi_copy_mem(void *destination, const void *source,
  */
 static void EFIAPI efi_set_mem(void *buffer, size_t size, uint8_t value)
 {
-	EFI_ENTRY("%p, %ld, 0x%x", buffer, (unsigned long)size, value);
+	EFI_ENTRY("%p, %ld, %#x", buffer, (unsigned long)size, value);
 	memset(buffer, value, size);
 	EFI_EXIT(EFI_SUCCESS);
 }
@@ -3123,7 +3123,7 @@ static efi_status_t EFIAPI efi_open_protocol
 	struct efi_handler *handler;
 	efi_status_t r = EFI_INVALID_PARAMETER;
 
-	EFI_ENTRY("%p, %pUs, %p, %p, %p, 0x%x", handle, protocol,
+	EFI_ENTRY("%p, %pUs, %p, %p, %p, %#x", handle, protocol,
 		  protocol_interface, agent_handle, controller_handle,
 		  attributes);
 
@@ -3496,7 +3496,7 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t image_handle,
 		if (image_obj->image_type == IMAGE_SUBSYSTEM_EFI_APPLICATION) {
 			ret = efi_tcg2_measure_efi_app_exit();
 			if (ret != EFI_SUCCESS) {
-				log_warning("tcg2 measurement fails(0x%lx)\n",
+				log_warning("tcg2 measurement fails (%#lx)\n",
 					    ret);
 			}
 		}
diff --git a/lib/efi_loader/efi_device_path_to_text.c b/lib/efi_loader/efi_device_path_to_text.c
index 0c7b30a26e7..51732cc0a48 100644
--- a/lib/efi_loader/efi_device_path_to_text.c
+++ b/lib/efi_loader/efi_device_path_to_text.c
@@ -53,7 +53,7 @@ static char *dp_hardware(char *s, struct efi_device_path *dp)
 	case DEVICE_PATH_SUB_TYPE_MEMORY: {
 		struct efi_device_path_memory *mdp =
 			(struct efi_device_path_memory *)dp;
-		s += sprintf(s, "MemoryMapped(0x%x,0x%llx,0x%llx)",
+		s += sprintf(s, "MemoryMapped(%#x,%#llx,%#llx)",
 			     mdp->memory_type,
 			     mdp->start_address,
 			     mdp->end_address);
@@ -79,7 +79,7 @@ static char *dp_hardware(char *s, struct efi_device_path *dp)
 		struct efi_device_path_controller *cdp =
 			(struct efi_device_path_controller *)dp;
 
-		s += sprintf(s, "Ctrl(0x%0x)", cdp->controller_number);
+		s += sprintf(s, "Ctrl(%#0x)", cdp->controller_number);
 		break;
 	}
 	default:
@@ -152,7 +152,7 @@ static char *dp_msging(char *s, struct efi_device_path *dp)
 	case DEVICE_PATH_SUB_TYPE_MSG_USB: {
 		struct efi_device_path_usb *udp =
 			(struct efi_device_path_usb *)dp;
-		s += sprintf(s, "USB(0x%x,0x%x)", udp->parent_port_number,
+		s += sprintf(s, "USB(%#x,%#x)", udp->parent_port_number,
 			     udp->usb_interface);
 		break;
 	}
@@ -174,7 +174,7 @@ static char *dp_msging(char *s, struct efi_device_path *dp)
 		struct efi_device_path_usb_class *ucdp =
 			(struct efi_device_path_usb_class *)dp;
 
-		s += sprintf(s, "UsbClass(0x%x,0x%x,0x%x,0x%x,0x%x)",
+		s += sprintf(s, "UsbClass(%#x,%#x,%#x,%#x,%#x)",
 			ucdp->vendor_id, ucdp->product_id,
 			ucdp->device_class, ucdp->device_subclass,
 			ucdp->device_protocol);
@@ -185,7 +185,7 @@ static char *dp_msging(char *s, struct efi_device_path *dp)
 		struct efi_device_path_sata *sdp =
 			(struct efi_device_path_sata *) dp;
 
-		s += sprintf(s, "Sata(0x%x,0x%x,0x%x)",
+		s += sprintf(s, "Sata(%#x,%#x,%#x)",
 			     sdp->hba_port,
 			     sdp->port_multiplier_port,
 			     sdp->logical_unit_number);
@@ -197,7 +197,7 @@ static char *dp_msging(char *s, struct efi_device_path *dp)
 		u32 ns_id;
 
 		memcpy(&ns_id, &ndp->ns_id, sizeof(ns_id));
-		s += sprintf(s, "NVMe(0x%x,", ns_id);
+		s += sprintf(s, "NVMe(%#x,", ns_id);
 
 		/* Display byte 7 first, byte 0 last */
 		for (int i = 0; i < 8; ++i)
@@ -264,18 +264,18 @@ static char *dp_media(char *s, struct efi_device_path *dp)
 
 			memcpy(&signature, sig, sizeof(signature));
 			s += sprintf(
-				s, "HD(%d,MBR,0x%08x,0x%llx,0x%llx)",
+				s, "HD(%d,MBR,%#08x,%#llx,%#llx)",
 				hddp->partition_number, signature, start, end);
 			break;
 			}
 		case SIG_TYPE_GUID:
 			s += sprintf(
-				s, "HD(%d,GPT,%pUl,0x%llx,0x%llx)",
+				s, "HD(%d,GPT,%pUl,%#llx,%#llx)",
 				hddp->partition_number, sig, start, end);
 			break;
 		default:
 			s += sprintf(
-				s, "HD(%d,0x%02x,0,0x%llx,0x%llx)",
+				s, "HD(%d,%#02x,0,%#llx,%#llx)",
 				hddp->partition_number, hddp->partmap_type,
 				start, end);
 			break;
@@ -286,7 +286,7 @@ static char *dp_media(char *s, struct efi_device_path *dp)
 	case DEVICE_PATH_SUB_TYPE_CDROM_PATH: {
 		struct efi_device_path_cdrom_path *cddp =
 			(struct efi_device_path_cdrom_path *)dp;
-		s += sprintf(s, "CDROM(%u,0x%llx,0x%llx)", cddp->boot_entry,
+		s += sprintf(s, "CDROM(%u,%#llx,%#llx)", cddp->boot_entry,
 			     cddp->partition_start, cddp->partition_size);
 		break;
 	}
diff --git a/lib/efi_loader/efi_hii_config.c b/lib/efi_loader/efi_hii_config.c
index ae0f3ecd3b1..0c8e2445d7a 100644
--- a/lib/efi_loader/efi_hii_config.c
+++ b/lib/efi_loader/efi_hii_config.c
@@ -127,7 +127,7 @@ form_callback(const struct efi_hii_config_access_protocol *this,
 	      union efi_ifr_type_value *value,
 	      efi_browser_action_request_t *action_request)
 {
-	EFI_ENTRY("%p, 0x%zx, 0x%x, 0x%x, %p, %p", this, action,
+	EFI_ENTRY("%p, %#zx, %#x, %#x, %p, %p", this, action,
 		  question_id, type, value, action_request);
 
 	return EFI_EXIT(EFI_DEVICE_ERROR);
diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 0ddf69a0918..2cea7a81849 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -72,7 +72,7 @@ static efi_status_t efi_print_image_info(struct efi_loaded_image_obj *obj,
 	       image->image_base, image->image_base + image->image_size - 1);
 	if (pc && pc >= image->image_base &&
 	    pc < image->image_base + image->image_size)
-		printf(" pc=0x%zx", pc - image->image_base);
+		printf(" pc=%#zx", pc - image->image_base);
 	if (image->file_path)
 		printf(" '%pD'", image->file_path);
 	printf("\n");
@@ -459,7 +459,7 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
 		efi_image_region_add(regs, efi + sorted[i]->PointerToRawData,
 				     efi + sorted[i]->PointerToRawData + size,
 				     0);
-		log_debug("section[%d](%s): raw: 0x%x-0x%x, virt: %x-%x\n",
+		log_debug("section[%d](%s): raw: %#x-%#x, virt: %x-%x\n",
 			  i, sorted[i]->Name,
 			  sorted[i]->PointerToRawData,
 			  sorted[i]->PointerToRawData + size,
@@ -493,7 +493,7 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
 		}
 		*auth = efi + authoff;
 		*auth_len = authsz;
-		log_debug("WIN_CERTIFICATE: 0x%x, size: 0x%x\n", authoff,
+		log_debug("WIN_CERTIFICATE: %#x, size: %#x\n", authoff,
 			  authsz);
 	} else {
 		*auth = NULL;
@@ -648,7 +648,7 @@ static bool efi_image_authenticate(void *efi, size_t efi_size)
 			continue;
 		}
 
-		log_debug("WIN_CERTIFICATE_TYPE: 0x%x\n",
+		log_debug("WIN_CERTIFICATE_TYPE: %#x\n",
 			  wincert->wCertificateType);
 
 		auth = (u8 *)wincert + sizeof(*wincert);
@@ -859,7 +859,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 		}
 
 	if (!supported) {
-		log_err("Machine type 0x%04x is not supported\n",
+		log_err("Machine type %#04x is not supported\n",
 			nt->FileHeader.Machine);
 		return EFI_LOAD_ERROR;
 	}
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index d2f5d563f2a..c42c9cccd79 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -278,7 +278,7 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 	uint64_t carved_pages = 0;
 	struct efi_event *evt;
 
-	EFI_PRINT("%s: 0x%llx 0x%llx %d %s\n", __func__,
+	EFI_PRINT("%s: %#llx %#llx %d %s\n", __func__,
 		  start, pages, memory_type, overlap_conventional ?
 		  "yes" : "no");
 
@@ -530,7 +530,7 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
 
 	/* Sanity check */
 	if (!memory || (memory & EFI_PAGE_MASK) || !pages) {
-		printf("%s: illegal free 0x%llx, 0x%zx\n", __func__,
+		printf("%s: illegal free %#llx, %#zx\n", __func__,
 		       memory, pages);
 		return EFI_INVALID_PARAMETER;
 	}
diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
index 184eac8cddb..29ef2681c06 100644
--- a/lib/efi_loader/efi_signature.c
+++ b/lib/efi_loader/efi_signature.c
@@ -468,7 +468,7 @@ static bool efi_signature_check_revocation(struct pkcs7_signed_info *sinfo,
 
 			memcpy(&revoc_time, sig_data->data + len,
 			       sizeof(revoc_time));
-			EFI_PRINT("revocation time: 0x%llx\n", revoc_time);
+			EFI_PRINT("revocation time: %#llx\n", revoc_time);
 			/*
 			 * TODO: compare signing timestamp in sinfo
 			 * with revocation time
diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 8b6b0a39086..c5069186f99 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -257,7 +257,7 @@ static int ffa_discover_mm_sp_id(void)
 
 	mm_sp_id = descs[0].info.id;
 
-	log_info("EFI: MM partition ID 0x%x\n", mm_sp_id);
+	log_info("EFI: MM partition ID %#x\n", mm_sp_id);
 
 	return 0;
 }
-- 
2.45.2

