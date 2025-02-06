Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A31CC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 17:40:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 224F980C93;
	Thu,  6 Feb 2025 18:40:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BvLg6q47";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44D4B80C93; Thu,  6 Feb 2025 18:40:37 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA97A80A55
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 18:40:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21f4a4fbb35so6606895ad.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 09:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738863633; x=1739468433; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcPX9Cvj3xlewpEIDA1EtI5VXHW88nZzQL4TrX27Sco=;
 b=BvLg6q47SRPh7JA9nIp2w7VKMjPu8jNJQl+HvvlDtJL5CvSCHV0Kb1IzSmP/N/fspP
 MJ8svTse9I6KYrh7Vv1IBsw/tHnYD/5Znh8XBD6zvGFmBYXGs+x8eGzzOJ7rYmCNhgGG
 pbBuh44fLNZYGQwXQ5GsTlhDdPoRNB1ONnZ4PmkC6MXMjYUHvGLGkvSmjHvwYLjd7rzm
 G87o8gcIFplN1yOZ9hW41aovb4byrwZHjZGd7o/VQrSlPPi3BnSFSpiCpECTl6ZADmab
 CMQ57Q076ZVIr6D1401M4GWrp+WJHGGHMxme8xEiOQnbLR/y0bCo9QEjN7f3u54NVUTB
 I5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738863633; x=1739468433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dcPX9Cvj3xlewpEIDA1EtI5VXHW88nZzQL4TrX27Sco=;
 b=SmSyDNSXDOQHppBehpIBgsDDKicSAAh3cdsCVWxu16aF5oCKsMJuosFeIQIy6nM1/N
 lbmGzxqk5YYEtYsbEDVAh9OO6G1WFuGN1d4T96cIpoehNllwB/n2TjHzioaQBI9BYLcj
 qCrg3HdAT7E5BK6/y+8TkD1r1hFR0kS6Q3KtxgBSCidU8+Lwt2PbcXkcR5uGXgXaQOzA
 SLmulEdinjouvqyDHDGyYBDK6fubAzic8en2qQQHmkdPVzoQuqI+IJ4pjfrM6PLse76l
 G7K+B42zkjAa1ZAlwjqzRiUmNe8CYFflZzWF3dGr3j5AwkKTu1I3iO9LedshoCvTZWKv
 7zRw==
X-Gm-Message-State: AOJu0YzNM4CVvuxUsDvv6VtG3uAFyXVXPXfq40U+bgGi3qe5dYwq4880
 tnrZM5O569qsLkVdM7sJB2z1pNv3yd5Oa0U3zpfukkiNuvY7uJH/qvgNwtsqjkQybw==
X-Gm-Gg: ASbGnctaTa4Pho1GO6IxfSpmdQt6+/6JZRwsJz11eC3kOqfWvXwyVkx1be/dkGbJZI3
 H7KvtsifIsqjm2/ZgRSa8H2k3ODhtMKipE2srUW4mddpn9oIb/lHJL03FMj7MPzojCfZrE6InzV
 h781jGT7QPnpAgLNadMbd+RZYqTYReiJf28AOoDZmxVJz+Z8UCTogrk9PVvr9GeSaFNwIUYatl5
 kf0AkluXvrE0UJ31QdAwdJQAJOaknVsyBkNQJrBACyVsh48cQyG7kxZcGZ17smoe40BixuYweYB
 ZAgUT5v7EL5RgJcesaTB5nnb
X-Google-Smtp-Source: AGHT+IHCifKsX1pNdnNywr4qSlhn/p9ml/p2bjbagGzlPx6hjxAkpifzC6dgeZX/o1bw87zaMUEHdg==
X-Received: by 2002:a17:902:d58d:b0:215:58be:334e with SMTP id
 d9443c01a7336-21f2f168325mr74968895ad.10.1738863633206; 
 Thu, 06 Feb 2025 09:40:33 -0800 (PST)
Received: from adriano.. ([191.119.55.28]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687c31asm15476615ad.167.2025.02.06.09.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 09:40:32 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 2/8] efi_loader: expose symbols to be used by the EFI network
 stack
Date: Thu,  6 Feb 2025 14:40:12 -0300
Message-ID: <20250206174018.465530-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206174018.465530-1-adriano.cordova@canonical.com>
References: <20250206174018.465530-1-adriano.cordova@canonical.com>
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
 include/efi_loader.h                | 17 +++++++++++++++++
 include/net-common.h                |  1 +
 lib/efi_loader/efi_boottime.c       | 21 ++++++++++-----------
 lib/efi_loader/efi_net.c            |  2 +-
 lib/efi_selftest/efi_selftest_snp.c |  1 -
 5 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index dcae6a731a0..8b4da7aa1fa 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -321,6 +321,8 @@ extern const efi_guid_t efi_guid_host_dev;
 #endif
 /* GUID of the EFI_BLOCK_IO_PROTOCOL */
 extern const efi_guid_t efi_block_io_guid;
+/* GUID of the EFI_SIMPLE_NETWORK_PROTOCOL */
+extern const efi_guid_t efi_net_guid;
 extern const efi_guid_t efi_global_variable_guid;
 extern const efi_guid_t efi_guid_console_control;
 extern const efi_guid_t efi_guid_device_path;
@@ -733,6 +735,10 @@ efi_status_t efi_search_protocol(const efi_handle_t handle,
 efi_status_t efi_add_protocol(const efi_handle_t handle,
 			      const efi_guid_t *protocol,
 			      void *protocol_interface);
+/* Uninstall new protocol on a handle */
+efi_status_t efi_uninstall_protocol
+		(efi_handle_t handle, const efi_guid_t *protocol,
+		 void *protocol_interface, bool preserve);
 /* Reinstall a protocol on a handle */
 efi_status_t EFIAPI efi_reinstall_protocol_interface(
 			efi_handle_t handle,
@@ -748,6 +754,15 @@ efi_status_t EFIAPI
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
@@ -768,6 +783,8 @@ efi_status_t efi_create_event(uint32_t type, efi_uintn_t notify_tpl,
 					void *context),
 			      void *notify_context, const efi_guid_t *group,
 			      struct efi_event **event);
+/* Call this to close an event */
+efi_status_t EFIAPI efi_close_event(struct efi_event *event);
 /* Call this to set a timer */
 efi_status_t efi_set_timer(struct efi_event *event, enum efi_timer_delay type,
 			   uint64_t trigger_time);
diff --git a/include/net-common.h b/include/net-common.h
index 29d31f37263..1d507b13b06 100644
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
index 5164cb15986..02ad9f7141f 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -60,9 +60,9 @@ static efi_handle_t current_image;
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
@@ -100,12 +100,11 @@ const efi_guid_t efi_guid_load_file2_protocol = EFI_LOAD_FILE2_PROTOCOL_GUID;
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
@@ -1039,7 +1038,7 @@ static efi_status_t EFIAPI efi_signal_event_ext(struct efi_event *event)
  *
  * Return: status code
  */
-static efi_status_t EFIAPI efi_close_event(struct efi_event *event)
+efi_status_t EFIAPI efi_close_event(struct efi_event *event)
 {
 	struct efi_register_notify_event *item, *next;
 
@@ -1380,9 +1379,9 @@ static efi_status_t efi_disconnect_all_drivers
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
index ce9272fa240..a48402d49d4 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -24,7 +24,7 @@
 #include <vsprintf.h>
 #include <net.h>
 
-static const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
+const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
 static const efi_guid_t efi_pxe_base_code_protocol_guid =
 					EFI_PXE_BASE_CODE_PROTOCOL_GUID;
 static struct efi_pxe_packet *dhcp_ack;
diff --git a/lib/efi_selftest/efi_selftest_snp.c b/lib/efi_selftest/efi_selftest_snp.c
index 15af8d3e18c..b00c76c2f17 100644
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
2.45.2

