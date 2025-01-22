Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6CEC02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 607BB80B9B;
	Wed, 22 Jan 2025 18:09:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yyf0xHRr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF03880977; Wed, 22 Jan 2025 18:09:19 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77F2280977
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:09:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2166f1e589cso173908795ad.3
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565756; x=1738170556; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YrGFiZb2yoocoB5jyLr/GoQvX8WbdUQU8PKCt4CTJNI=;
 b=Yyf0xHRrQ7YKFwm2O80j1zyoIo9+vfZ3309K9ICfLqlz3YJ1VBVGfp76Ja2rxsuvHp
 ZF2tlwlle8xMI48005oJdxeFi3iHUrNTvzzq0kjK3a8mp3YdsdwP3Cd5mdoe+BlwOVuw
 IVg8MIKhWVVKisIuFfo0asw9iEfiXZJYq7Ky9ebjbve5p2UCEPILLragMQdtRi3Knwwm
 gKdkBSJ7rbtVxYX/tS8ah84FKx8r3jV5YZjZR/77n+KTbDnkvzgMdri/alhaQQHTzorg
 LjalVTxyuMKGz6Np6xExsZUMNtP5ca6LaKKLvuYFVCB59+sM0FeBHqAemiDdR6qYcQM4
 WXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565756; x=1738170556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YrGFiZb2yoocoB5jyLr/GoQvX8WbdUQU8PKCt4CTJNI=;
 b=W1yXQnvfEWRl0jFnuVU2GmBflg1xlM1mcllsQ0CrXFr9rWIS4dDzj8RjHHLImyIxFC
 bWVtgpSENgN0Yp3yTt592q7n273iSIGyBMAIdhdjstVHY7phrMPXJCDddEA5+SNT/QpS
 gp5927SH0A7hYQA8QThi+Ldbip4UNj2C1bX+gjetXKJbn9z/M9Z+Y/8n5IY0YEh3N/Dp
 OBNfFM4VMycIr9yLP+ObThFaqs7k46lVRUoq1TfU2W/64A5xS8Xvg7G3IKJK+zyMeVhX
 ktL03Blyfke8ioJEZn/IHBjGZO3CnrnFJmMeAPJZmwAomOyAinWiXcO0O+l1uuehAkXf
 JV+w==
X-Gm-Message-State: AOJu0YyL8nfQvdf7z4WXG/a+uD7ICnYiOLhf6HwC3Pxb8f72FIZk6+05
 m9+Hdgn/Q7tfQYk0uzkzR79qavKGoW/Gh3Rnue6Z8433p2CZwoNA/Prk/Ikj
X-Gm-Gg: ASbGncsISlNL7llIil4s+Mz0jpz16ORNIWQCaN5Qh18PxBlGC7Gy2CR/N3Xt1hWnITr
 +1zhHyM/qzhasV1Gt30mfGGJpSEkLDK3rL6oToRYGaQ+YBWhQ080s/Rr2Pn/SZY++MJpmLeJp9y
 ha1kDUdD0o3HCIKQ6jKzpP5/r8oofwQV4cC2SORJ2c2jSxL4X0SF/267eGQArRxhh2ncgo9U57d
 HiBwileXB36P7GqIISx+WTFWSR7jWBKZI4F99W53OihiyzjvnKcExTmTiDO4Qq/IFG72nbRYSb9
 TQ==
X-Google-Smtp-Source: AGHT+IFTYN6JcFhjCMDtrhGk7RNMlk/ABuB0pNTvvHkblvs8c+gjNEt8JFTk9JTJ0QkFCRK/OLRXjg==
X-Received: by 2002:a17:903:2344:b0:216:32c4:f807 with SMTP id
 d9443c01a7336-21c3564e7b4mr277260155ad.45.1737565755924; 
 Wed, 22 Jan 2025 09:09:15 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:09:15 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 02/21] efi_loader: expose symbols to be used by the EFI
 network stack
Date: Wed, 22 Jan 2025 14:08:39 -0300
Message-ID: <20250122170858.961359-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122170858.961359-1-adriano.cordova@canonical.com>
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
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

The following symbols are exposed:
	- efi_reinstall_protocol_interface
		This is done so that the device path protocol interface
		of the network device can be changed internally by u-boot
		when a new bootfile gets downloaded.
	- eth_set_dev
		To support multiple network udevices
	- efi_close_event
		This comes in preparation to support unregistering
		an EFI network device from the EFI network stack when
		the underlying U-boot device gets removed
	- efi_[dis]connect_controller
		The EFI network driver uses ConnectController to add a
		NIC to the EFI network stack.
	- efi_uninstall_protocol_interface
		connect_controler for the efi network driver can install
		protocols, which need to be uninstalled in disconnect_controller
	- EFI_SIMPLE_NETWORK_PROTOCOL_GUID

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_loader.h                | 22 ++++++++++++++++++++++
 include/net-common.h                |  1 +
 lib/efi_loader/efi_boottime.c       | 23 +++++++++++------------
 lib/efi_loader/efi_net.c            |  2 +-
 lib/efi_selftest/efi_selftest_snp.c |  1 -
 5 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 9afbec35eb..626d2bbb1a 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -308,6 +308,8 @@ extern const efi_guid_t efi_guid_host_dev;
 #endif
 /* GUID of the EFI_BLOCK_IO_PROTOCOL */
 extern const efi_guid_t efi_block_io_guid;
+/* GUID of the EFI_SIMPLE_NETWORK_PROTOCOL */
+extern const efi_guid_t efi_net_guid;
 extern const efi_guid_t efi_global_variable_guid;
 extern const efi_guid_t efi_guid_console_control;
 extern const efi_guid_t efi_guid_device_path;
@@ -711,6 +713,15 @@ efi_status_t efi_search_protocol(const efi_handle_t handle,
 efi_status_t efi_add_protocol(const efi_handle_t handle,
 			      const efi_guid_t *protocol,
 			      void *protocol_interface);
+/* Uninstall new protocol on a handle */
+efi_status_t efi_uninstall_protocol
+		(efi_handle_t handle, const efi_guid_t *protocol,
+		 void *protocol_interface, bool preserve);
+/* Reinstall a protocol on a handle */
+efi_status_t EFIAPI efi_reinstall_protocol_interface(
+			efi_handle_t handle,
+			const efi_guid_t *protocol,
+			void *old_interface, void *new_interface);
 /* Open protocol */
 efi_status_t efi_protocol_open(struct efi_handler *handler,
 			       void **protocol_interface, void *agent_handle,
@@ -721,6 +732,15 @@ efi_status_t EFIAPI
 efi_install_multiple_protocol_interfaces(efi_handle_t *handle, ...);
 efi_status_t EFIAPI
 efi_uninstall_multiple_protocol_interfaces(efi_handle_t handle, ...);
+/* Connect and disconnect controller */
+efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_handle,
+					   efi_handle_t *driver_image_handle,
+					   struct efi_device_path *remain_device_path,
+					   bool recursive);
+efi_status_t EFIAPI efi_disconnect_controller(
+					efi_handle_t controller_handle,
+					efi_handle_t driver_image_handle,
+					efi_handle_t child_handle);
 /* Get handles that support a given protocol */
 efi_status_t EFIAPI efi_locate_handle_buffer(
 			enum efi_locate_search_type search_type,
@@ -741,6 +761,8 @@ efi_status_t efi_create_event(uint32_t type, efi_uintn_t notify_tpl,
 					void *context),
 			      void *notify_context, const efi_guid_t *group,
 			      struct efi_event **event);
+/* Call this to close an event */
+efi_status_t EFIAPI efi_close_event(struct efi_event *event);
 /* Call this to set a timer */
 efi_status_t efi_set_timer(struct efi_event *event, enum efi_timer_delay type,
 			   uint64_t trigger_time);
diff --git a/include/net-common.h b/include/net-common.h
index 29d31f3726..1d507b13b0 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -291,6 +291,7 @@ struct eth_ops {
 #define eth_get_ops(dev) ((struct eth_ops *)(dev)->driver->ops)
 
 struct udevice *eth_get_dev(void); /* get the current device */
+void eth_set_dev(struct udevice *dev); /* set a device */
 unsigned char *eth_get_ethaddr(void); /* get the current device MAC */
 int eth_rx(void);                      /* Check for received packets */
 void eth_halt(void);			/* stop SCC */
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 080e7f78ae..79ebe94889 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -58,9 +58,9 @@ static efi_handle_t current_image;
 static volatile gd_t *efi_gd, *app_gd;
 #endif
 
-static efi_status_t efi_uninstall_protocol
-			(efi_handle_t handle, const efi_guid_t *protocol,
-			 void *protocol_interface, bool preserve);
+efi_status_t efi_uninstall_protocol
+		(efi_handle_t handle, const efi_guid_t *protocol,
+		 void *protocol_interface, bool preserve);
 
 /* 1 if inside U-Boot code, 0 if inside EFI payload code */
 static int entry_count = 1;
@@ -98,12 +98,11 @@ const efi_guid_t efi_guid_load_file2_protocol = EFI_LOAD_FILE2_PROTOCOL_GUID;
 /* GUID of the SMBIOS table */
 const efi_guid_t smbios_guid = SMBIOS_TABLE_GUID;
 
-static efi_status_t EFIAPI efi_disconnect_controller(
+efi_status_t EFIAPI efi_disconnect_controller(
 					efi_handle_t controller_handle,
 					efi_handle_t driver_image_handle,
 					efi_handle_t child_handle);
 
-static
 efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_handle,
 					   efi_handle_t *driver_image_handle,
 					   struct efi_device_path *remain_device_path,
@@ -1037,7 +1036,7 @@ static efi_status_t EFIAPI efi_signal_event_ext(struct efi_event *event)
  *
  * Return: status code
  */
-static efi_status_t EFIAPI efi_close_event(struct efi_event *event)
+efi_status_t EFIAPI efi_close_event(struct efi_event *event)
 {
 	struct efi_register_notify_event *item, *next;
 
@@ -1378,9 +1377,9 @@ static efi_status_t efi_disconnect_all_drivers
  *
  * Return: status code
  */
-static efi_status_t efi_uninstall_protocol
-			(efi_handle_t handle, const efi_guid_t *protocol,
-			 void *protocol_interface, bool preserve)
+efi_status_t efi_uninstall_protocol
+		(efi_handle_t handle, const efi_guid_t *protocol,
+			void *protocol_interface, bool preserve)
 {
 	struct efi_handler *handler;
 	struct efi_open_protocol_info_item *item;
@@ -3665,7 +3664,7 @@ static efi_status_t efi_connect_single_controller(
  *
  * Return: status code
  */
-static efi_status_t EFIAPI efi_connect_controller(
+efi_status_t EFIAPI efi_connect_controller(
 			efi_handle_t controller_handle,
 			efi_handle_t *driver_image_handle,
 			struct efi_device_path *remain_device_path,
@@ -3733,7 +3732,7 @@ out:
  *
  * Return: status code
  */
-static efi_status_t EFIAPI efi_reinstall_protocol_interface(
+efi_status_t EFIAPI efi_reinstall_protocol_interface(
 			efi_handle_t handle, const efi_guid_t *protocol,
 			void *old_interface, void *new_interface)
 {
@@ -3844,7 +3843,7 @@ static efi_status_t efi_get_child_controllers(
  *
  * Return: status code
  */
-static efi_status_t EFIAPI efi_disconnect_controller(
+efi_status_t EFIAPI efi_disconnect_controller(
 				efi_handle_t controller_handle,
 				efi_handle_t driver_image_handle,
 				efi_handle_t child_handle)
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 67593ef50c..918d43c70f 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -22,7 +22,7 @@
 #include <vsprintf.h>
 #include <net.h>
 
-static const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
+const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
 static const efi_guid_t efi_pxe_base_code_protocol_guid =
 					EFI_PXE_BASE_CODE_PROTOCOL_GUID;
 static struct efi_pxe_packet *dhcp_ack;
diff --git a/lib/efi_selftest/efi_selftest_snp.c b/lib/efi_selftest/efi_selftest_snp.c
index 15af8d3e18..b00c76c2f1 100644
--- a/lib/efi_selftest/efi_selftest_snp.c
+++ b/lib/efi_selftest/efi_selftest_snp.c
@@ -67,7 +67,6 @@ struct dhcp {
 static struct efi_boot_services *boottime;
 static struct efi_simple_network *net;
 static struct efi_event *timer;
-static const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
 /* IP packet ID */
 static unsigned int net_ip_id;
 
-- 
2.43.0

