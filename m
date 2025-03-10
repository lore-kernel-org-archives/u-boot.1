Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE16EC282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 12:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15ED381428;
	Mon, 10 Mar 2025 13:06:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AKQg2UbX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AE3381430; Mon, 10 Mar 2025 13:06:10 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF625811DF
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 13:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so3505155ad.2
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 05:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741608363; x=1742213163; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgzRglZe+WEvx4snOm2o837bxMQJqq2MtbTBB7qn9BY=;
 b=AKQg2UbXvGjBuBHuXn+DVEmtSUbyW2lwF/nQDxX5URIoitdFtEZXqHEXmZVi8OuPJ5
 gmLsj1j/asumy2MF4oOROFyig48ghuXqaogEnSKCPW4YDj+40FHb/kFT3GDeEfdStJj8
 TFzUUdCgGhhqd/hWiaXpSNp4BUM7LZ48/L+XiJn1R9yH/j1DzwQwKq8ayNe6F9Ipi9zt
 2A3yl3Y2dNJDrZ4t2RDR7VFutmssBvAQY/WBt/M8B49GIjwwI+9zT9UhVfQQ1N2uE9Pz
 24VRqlK5aOEakxs0jeaGJQIejtAsdqSpFbSo+2BjFd6E2DMYnvP5K22meRPTgEj+8M/G
 1uzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741608363; x=1742213163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgzRglZe+WEvx4snOm2o837bxMQJqq2MtbTBB7qn9BY=;
 b=cvkPFHoRCWhsy5C6dlsBO57t0s9rM+xdZg3P0rdD9QZunEK++5AlW96Z8smjMaXLf2
 /Oq6GVecp5KRpwqbBrpySzpB4mVeGOUGoo7SKHn3/aBt/0vxmX43b1arsNHMUFw6oAWN
 ucvRHjHLddrSo9uOc6MNtkkfaFjOoE3mBy2FusXbMC0T0TGpuqozxguQBTTzRSb+VlSe
 vn1tr7WUW4vetqqJTpqBnK+hJxlOmeU/Jmagz2CcJt556sTojCM8/ueBiRwzpJzITdpo
 iHb49rc6Fom6bVDFJIbQbii2QAGjnNSBD3ZZjj7A3VWrDWjZzxmdxGUlX+K7lF45AdgT
 Hofg==
X-Gm-Message-State: AOJu0YyEC05uc7jt/IUwAgYV8+vQ4S27goyTZOkncLyOPbazoZYt+8eR
 BaDrAZ3uvYMdK9ZlT5WAB68c6mF5GXCeL94zQajRnYQN7jqQAMU+Ol+GOlR/0P0=
X-Gm-Gg: ASbGnctb0Bo1bxv3+x2i3oYxzZJ1F4q8gDwkarotRB0vjrXscEdpDDLWZm7lK7Q6na/
 DJ2PXR0oIORt3g6wwkfgXK6RYSQ4VNTHYal6dPWfO0hSOIGgcoW3m2JXba6qBT7lFYbrMhTMIIM
 PNRR7Y1sIW+946YNqyxCPpW+12WEFeP6Qs+TLWwVUucWS9AGn/vFhho8v/B78CgdSBcA+IMXsIo
 9QXbnisUM/52Hmu60x7KMKWqwVOhzjFRGuR6slcrQWrV0tOKSTrNHqTOx5ISeNGevdlxylA2h8k
 38UvUzwjBZ+z0bqTUfhqnuAQcxIk9yf6Va6wHq3iTZ2WAnMnoPB35RI=
X-Google-Smtp-Source: AGHT+IHBZ+rXnBdClRdMgnG0NZ761Bz1I+HmeqQa6LtNha6EyIwOCaEYDwKTgux4/F5g8VVfFh/xHQ==
X-Received: by 2002:a17:902:ce89:b0:21f:164d:93fe with SMTP id
 d9443c01a7336-22428c0d524mr209012235ad.53.1741608363236; 
 Mon, 10 Mar 2025 05:06:03 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a8b61f76sm6968899b3a.103.2025.03.10.05.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 05:06:02 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v3 2/8] efi_loader: expose symbols to be used by the EFI
 network stack
Date: Mon, 10 Mar 2025 09:06:01 -0300
Message-ID: <20250310120607.186999-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310120607.186999-1-adriano.cordova@canonical.com>
References: <20250310120607.186999-1-adriano.cordova@canonical.com>
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

(no changes since v1)

 include/efi_loader.h                | 17 +++++++++++++++++
 include/net-common.h                |  1 +
 lib/efi_loader/efi_boottime.c       | 21 ++++++++++-----------
 lib/efi_loader/efi_net.c            |  2 +-
 lib/efi_selftest/efi_selftest_snp.c |  1 -
 5 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 1d75d97ebbc..6a17a41dbad 100644
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
2.48.1

