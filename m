Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FDFC3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 08:19:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCFAC82B0E;
	Fri, 16 May 2025 10:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WAmuVhTR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C38E880079; Fri, 16 May 2025 10:17:57 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BADD782AB2
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 10:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a1fb17bb8cso1335824f8f.0
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747383473; x=1747988273; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5/uSxO6+TX1VzsVkoE05qNe5Sp7KpZP40Rt/2zeC8A=;
 b=WAmuVhTRcz5UL7C2wIaIw2Z7AJZtp6A91GMviaGZ6Dd4mmF0ld3MX/ItTpiU84um+S
 RDMjTibvlGwA5i0YT8rvArXryWP44d8OsHX1QbUaKI9ihKtN2ofJJkwHsiUCJet+tpAO
 jCQxPMdNhLw149W4F/lzXhcQx2dTFVBlJZE/Vm8A1VYJCTGsIoLXnXTqP9RLQRotVzXR
 u0qe8ssnyBA2rIzty+DJzDWOvApGtez+mzjornF3ZZ8Dv6tEU+suLg3ByMeGLxsjMj68
 sQVd41PXHdDs07fDdJNpxQOPTzDlGfdVrYCbfjzwRtOaVji/gfKxPx6EVEUmlPzwbzBE
 CYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747383473; x=1747988273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5/uSxO6+TX1VzsVkoE05qNe5Sp7KpZP40Rt/2zeC8A=;
 b=CEnZcpKuJYp/N8LyPyc66LvHzNmkqF2N9AY5GzqlBAkFaKUqwm22tNJeESuyfNykOU
 lUZecNwwhLdLft//ZdZcrxqofQt1ez8qAVM84VYEYssYhlr6s6UuvjqhqiQ/KqfAAFaS
 H0wgZV+rALGq2PMfUJ34xSt6AftRK8x0s1zWmECqIhdufT4YjdagvTufzgvG4ksqbpe1
 k+6PjqluBx86LUlqzVC5ZsbGglx02SplCRmIrckIZHbu4t4ogvkOzlKHHObQJx67tHQA
 SFYI2P0uRkEcNS+6e5gPPWF2XNctEroKY6ilV89CZbU0Hw1DoFz0bFT30343YVjdAy5I
 KH3w==
X-Gm-Message-State: AOJu0YwejTqxUDflBpysJ/epf1UgLytylnOFSURkz8L6w2Pl+BaA/+zl
 l1UwQizDFLPuVp+X+Y+twMOW2mq806CngxAyQZUaIMKt8KVCMe9yiwDKe+kEdUr7D0Q=
X-Gm-Gg: ASbGncud2hmC+ATP3rvk/187YdztuucdhFSfUpfxiVUOgoGGZW1sCHh8Cc4Yns9E7iw
 9/WM7DwXsERjznXLbJk5/Y3FxquuAoSMh7j5j0uWnEr9n7RELkbOUpZ4WmFIkd/emtTK6NhnIQf
 Pfgc9qu/KvKbF6UdFezHgNm9iOVSe5p1xTKWS1QYKYCuNCNAGfhcuzs9WpEIMhbmRaaNpgi7kf1
 Re5v8x9GTllzgJiQ7hbHejJvC7Os32+AEA5GpSbjQX94W+e6sFel1FyBHYHlec4w3Vpw84OnviJ
 8qsCGiaYiQDJRKOwaq+kTPYCDzksc35ytDbXS3MnJjgPVYuhlWPVLU3k/DT9Vw==
X-Google-Smtp-Source: AGHT+IF78KIe391W4flATzeN9hw3jTKyYHtgF6RJVcCfEME93zrewtmSIQvusTJDY94ObsOsvSKDlw==
X-Received: by 2002:a05:6000:2012:b0:3a3:5933:a0f9 with SMTP id
 ffacd0b85a97d-3a35c821e4fmr2360819f8f.8.1747383472548; 
 Fri, 16 May 2025 01:17:52 -0700 (PDT)
Received: from adriano.. ([213.157.19.150]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca8ce9asm2010159f8f.86.2025.05.16.01.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 01:17:52 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 4/9] efi_loader/net: Remove simple network and pxe protocols
 from efi_net.c
Date: Fri, 16 May 2025 04:18:34 -0400
Message-ID: <20250516081839.28587-5-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516081839.28587-1-adriano.cordova@canonical.com>
References: <20250516081839.28587-1-adriano.cordova@canonical.com>
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

efi_net.c should only [un]install protocols, leaving the
actual implementation to efi_simple_network.c and efi_pxe.c.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_api.h                       |   28 +-
 include/efi_loader.h                    |   10 +-
 lib/efi_loader/net/Makefile             |    2 +
 lib/efi_loader/net/efi_net.c            | 1038 +----------------------
 lib/efi_loader/net/efi_pxe.c            |  190 +++++
 lib/efi_loader/net/efi_simple_network.c |  880 +++++++++++++++++++
 lib/efi_selftest/efi_selftest_snp.c     |    4 +-
 7 files changed, 1142 insertions(+), 1010 deletions(-)
 create mode 100644 lib/efi_loader/net/efi_pxe.c
 create mode 100644 lib/efi_loader/net/efi_simple_network.c

diff --git a/include/efi_api.h b/include/efi_api.h
index eb61eafa028..b20d639fbea 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -1519,36 +1519,36 @@ struct efi_simple_network_mode {
 /* revision of the simple network protocol */
 #define EFI_SIMPLE_NETWORK_PROTOCOL_REVISION	0x00010000
 
-struct efi_simple_network {
+struct efi_simple_network_protocol {
 	u64 revision;
-	efi_status_t (EFIAPI *start)(struct efi_simple_network *this);
-	efi_status_t (EFIAPI *stop)(struct efi_simple_network *this);
-	efi_status_t (EFIAPI *initialize)(struct efi_simple_network *this,
+	efi_status_t (EFIAPI *start)(struct efi_simple_network_protocol *this);
+	efi_status_t (EFIAPI *stop)(struct efi_simple_network_protocol *this);
+	efi_status_t (EFIAPI *initialize)(struct efi_simple_network_protocol *this,
 			ulong extra_rx, ulong extra_tx);
-	efi_status_t (EFIAPI *reset)(struct efi_simple_network *this,
+	efi_status_t (EFIAPI *reset)(struct efi_simple_network_protocol *this,
 			int extended_verification);
-	efi_status_t (EFIAPI *shutdown)(struct efi_simple_network *this);
-	efi_status_t (EFIAPI *receive_filters)(struct efi_simple_network *this,
+	efi_status_t (EFIAPI *shutdown)(struct efi_simple_network_protocol *this);
+	efi_status_t (EFIAPI *receive_filters)(struct efi_simple_network_protocol *this,
 			u32 enable, u32 disable, int reset_mcast_filter,
 			ulong mcast_filter_count,
 			struct efi_mac_address *mcast_filter);
-	efi_status_t (EFIAPI *station_address)(struct efi_simple_network *this,
+	efi_status_t (EFIAPI *station_address)(struct efi_simple_network_protocol *this,
 			int reset, struct efi_mac_address *new_mac);
-	efi_status_t (EFIAPI *statistics)(struct efi_simple_network *this,
+	efi_status_t (EFIAPI *statistics)(struct efi_simple_network_protocol *this,
 			int reset, ulong *stat_size, void *stat_table);
-	efi_status_t (EFIAPI *mcastiptomac)(struct efi_simple_network *this,
+	efi_status_t (EFIAPI *mcastiptomac)(struct efi_simple_network_protocol *this,
 			int ipv6, struct efi_ip_address *ip,
 			struct efi_mac_address *mac);
-	efi_status_t (EFIAPI *nvdata)(struct efi_simple_network *this,
+	efi_status_t (EFIAPI *nvdata)(struct efi_simple_network_protocol *this,
 			int read_write, ulong offset, ulong buffer_size,
 			char *buffer);
-	efi_status_t (EFIAPI *get_status)(struct efi_simple_network *this,
+	efi_status_t (EFIAPI *get_status)(struct efi_simple_network_protocol *this,
 			u32 *int_status, void **txbuf);
-	efi_status_t (EFIAPI *transmit)(struct efi_simple_network *this,
+	efi_status_t (EFIAPI *transmit)(struct efi_simple_network_protocol *this,
 			size_t header_size, size_t buffer_size, void *buffer,
 			struct efi_mac_address *src_addr,
 			struct efi_mac_address *dest_addr, u16 *protocol);
-	efi_status_t (EFIAPI *receive)(struct efi_simple_network *this,
+	efi_status_t (EFIAPI *receive)(struct efi_simple_network_protocol *this,
 			size_t *header_size, size_t *buffer_size, void *buffer,
 			struct efi_mac_address *src_addr,
 			struct efi_mac_address *dest_addr, u16 *protocol);
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 5c1244824f3..cc90bdf6a3a 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -329,8 +329,6 @@ extern const efi_guid_t efi_guid_host_dev;
 #endif
 /* GUID of the EFI_BLOCK_IO_PROTOCOL */
 extern const efi_guid_t efi_block_io_guid;
-/* GUID of the EFI_SIMPLE_NETWORK_PROTOCOL */
-extern const efi_guid_t efi_net_guid;
 extern const efi_guid_t efi_global_variable_guid;
 extern const efi_guid_t efi_guid_console_control;
 extern const efi_guid_t efi_guid_device_path;
@@ -661,9 +659,13 @@ efi_status_t efi_gop_register(void);
 /* Called by bootefi to make the network interface available */
 efi_status_t efi_net_register(struct udevice *dev);
 efi_status_t efi_net_do_start(struct udevice *dev);
-/* Called by efi_net_register to make the ip4 config2 protocol available */
+/* Called by efi_net_register to install EFI_SIMPLE_NETWORK_PROTOCOL */
+efi_status_t efi_simple_network_install(const efi_handle_t handle, struct udevice *dev);
+/* Called by efi_net_register to install EFI_PXE_BASE_CODE_PROTOCOL */
+efi_status_t efi_pxe_install(const efi_handle_t handle, struct efi_pxe_packet *dhcp_ack);
+/* Called by efi_net_register to install EFI_IP4_CONFIG2_PROTOCOL */
 efi_status_t efi_ip4_config2_install(const efi_handle_t handle);
-/* Called by efi_net_register to make the http protocol available */
+/* Called by efi_net_register to install EFI_HTTP_SERVICE_BINDING_PROTOCOL */
 efi_status_t efi_http_install(const efi_handle_t handle);
 /* Called by bootefi to make the watchdog available */
 efi_status_t efi_watchdog_register(void);
diff --git a/lib/efi_loader/net/Makefile b/lib/efi_loader/net/Makefile
index 75131877e30..d024f1818d9 100644
--- a/lib/efi_loader/net/Makefile
+++ b/lib/efi_loader/net/Makefile
@@ -1,3 +1,5 @@
 obj-y += efi_net.o
+obj-y += efi_simple_network.o
+obj-y += efi_pxe.o
 obj-$(CONFIG_EFI_IP4_CONFIG2_PROTOCOL) += efi_ip4_config2.o
 obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_http.o
\ No newline at end of file
diff --git a/lib/efi_loader/net/efi_net.c b/lib/efi_loader/net/efi_net.c
index 40db80f4726..a7ceef4cbba 100644
--- a/lib/efi_loader/net/efi_net.c
+++ b/lib/efi_loader/net/efi_net.c
@@ -1,18 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Simple network protocol
- * PXE base code protocol
  *
  * Copyright (c) 2016 Alexander Graf
  *
- * The simple network protocol has the following statuses and services
- * to move between them:
- *
- * Start():	 EfiSimpleNetworkStopped     -> EfiSimpleNetworkStarted
- * Initialize(): EfiSimpleNetworkStarted     -> EfiSimpleNetworkInitialized
- * Shutdown():	 EfiSimpleNetworkInitialized -> EfiSimpleNetworkStarted
- * Stop():	 EfiSimpleNetworkStarted     -> EfiSimpleNetworkStopped
- * Reset():	 EfiSimpleNetworkInitialized -> EfiSimpleNetworkInitialized
  */
 
 #define LOG_CATEGORY LOGC_EFI
@@ -28,11 +18,12 @@
 #define MAX_NUM_DHCP_ENTRIES 10
 #define MAX_NUM_DP_ENTRIES 10
 
-const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
 static const efi_guid_t efi_pxe_base_code_protocol_guid =
 					EFI_PXE_BASE_CODE_PROTOCOL_GUID;
+#if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
 static const efi_guid_t efi_http_service_binding_guid =
 					EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID;
+#endif
 
 struct dp_entry {
 	struct efi_device_path *net_dp;
@@ -71,39 +62,12 @@ static int next_dhcp_entry;
  *
  * @header:			EFI object header
  * @dev:			net udevice
- * @net:			simple network protocol interface
- * @net_mode:			status of the network interface
- * @pxe:			PXE base code protocol interface
- * @pxe_mode:			status of the PXE base code protocol
- * @new_tx_packet:		new transmit packet
- * @transmit_buffer:	transmit buffer
- * @receive_buffer:		array of receive buffers
- * @receive_lengths:	array of lengths for received packets
- * @rx_packet_idx:		index of the current receive packet
- * @rx_packet_num:		number of received packets
- * @wait_for_packet:	signaled when a packet has been received
- * @network_timer_event:	event to check for new network packets.
- * @efi_seq_num:		sequence number of the EFI net object.
  */
 struct efi_net_obj {
 	struct efi_object header;
 	struct udevice *dev;
-	struct efi_simple_network net;
-	struct efi_simple_network_mode net_mode;
-	struct efi_pxe_base_code_protocol pxe;
-	struct efi_pxe_mode pxe_mode;
-	void *new_tx_packet;
-	void *transmit_buffer;
-	uchar **receive_buffer;
-	size_t *receive_lengths;
-	int rx_packet_idx;
-	int rx_packet_num;
-	struct efi_event *wait_for_packet;
-	struct efi_event *network_timer_event;
-	int efi_seq_num;
 };
 
-static int curr_efi_net_obj;
 static struct efi_net_obj *net_objs[MAX_EFI_NET_OBJS];
 
 /**
@@ -120,641 +84,6 @@ static bool efi_netobj_is_active(struct efi_net_obj *netobj)
 	return true;
 }
 
-/*
- * efi_netobj_from_snp() - get efi_net_obj from simple network protocol
- *
- *
- * @snp:	pointer to the simple network protocol
- * Return:	pointer to efi_net_obj, NULL on error
- */
-static struct efi_net_obj *efi_netobj_from_snp(struct efi_simple_network *snp)
-{
-	int i;
-
-	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
-		if (net_objs[i] && &net_objs[i]->net == snp) {
-			// Do not register duplicate devices
-			return net_objs[i];
-		}
-	}
-	return NULL;
-}
-
-/*
- * efi_net_start() - start the network interface
- *
- * This function implements the Start service of the
- * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
- * (UEFI) specification for details.
- *
- * @this:	pointer to the protocol instance
- * Return:	status code
- */
-static efi_status_t EFIAPI efi_net_start(struct efi_simple_network *this)
-{
-	efi_status_t ret = EFI_SUCCESS;
-	struct efi_net_obj *nt;
-
-	EFI_ENTRY("%p", this);
-	/* Check parameters */
-	if (!this) {
-		ret = EFI_INVALID_PARAMETER;
-		goto out;
-	}
-
-	nt = efi_netobj_from_snp(this);
-
-	if (this->mode->state != EFI_NETWORK_STOPPED) {
-		ret = EFI_ALREADY_STARTED;
-	} else {
-		this->int_status = 0;
-		nt->wait_for_packet->is_signaled = false;
-		this->mode->state = EFI_NETWORK_STARTED;
-	}
-out:
-	return EFI_EXIT(ret);
-}
-
-/*
- * efi_net_stop() - stop the network interface
- *
- * This function implements the Stop service of the
- * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
- * (UEFI) specification for details.
- *
- * @this:	pointer to the protocol instance
- * Return:	status code
- */
-static efi_status_t EFIAPI efi_net_stop(struct efi_simple_network *this)
-{
-	efi_status_t ret = EFI_SUCCESS;
-	struct efi_net_obj *nt;
-
-	EFI_ENTRY("%p", this);
-
-	/* Check parameters */
-	if (!this) {
-		ret = EFI_INVALID_PARAMETER;
-		goto out;
-	}
-
-	nt = efi_netobj_from_snp(this);
-
-	if (this->mode->state == EFI_NETWORK_STOPPED) {
-		ret = EFI_NOT_STARTED;
-	} else {
-		/* Disable hardware and put it into the reset state */
-		eth_set_dev(nt->dev);
-		env_set("ethact", eth_get_name());
-		eth_halt();
-		/* Clear cache of packets */
-		nt->rx_packet_num = 0;
-		this->mode->state = EFI_NETWORK_STOPPED;
-	}
-out:
-	return EFI_EXIT(ret);
-}
-
-/*
- * efi_net_initialize() - initialize the network interface
- *
- * This function implements the Initialize service of the
- * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
- * (UEFI) specification for details.
- *
- * @this:	pointer to the protocol instance
- * @extra_rx:	extra receive buffer to be allocated
- * @extra_tx:	extra transmit buffer to be allocated
- * Return:	status code
- */
-static efi_status_t EFIAPI efi_net_initialize(struct efi_simple_network *this,
-					      ulong extra_rx, ulong extra_tx)
-{
-	int ret;
-	efi_status_t r = EFI_SUCCESS;
-	struct efi_net_obj *nt;
-
-	EFI_ENTRY("%p, %lx, %lx", this, extra_rx, extra_tx);
-
-	/* Check parameters */
-	if (!this) {
-		r = EFI_INVALID_PARAMETER;
-		goto out;
-	}
-	nt = efi_netobj_from_snp(this);
-
-	switch (this->mode->state) {
-	case EFI_NETWORK_INITIALIZED:
-	case EFI_NETWORK_STARTED:
-		break;
-	default:
-		r = EFI_NOT_STARTED;
-		goto out;
-	}
-
-	/* Setup packet buffers */
-	net_init();
-	/* Clear cache of packets */
-	nt->rx_packet_num = 0;
-	/* Set the net device corresponding to the efi net object */
-	eth_set_dev(nt->dev);
-	env_set("ethact", eth_get_name());
-	/* Get hardware ready for send and receive operations */
-	ret = eth_start_udev(nt->dev);
-	if (ret < 0) {
-		eth_halt();
-		this->mode->state = EFI_NETWORK_STOPPED;
-		r = EFI_DEVICE_ERROR;
-		goto out;
-	} else {
-		this->int_status = 0;
-		nt->wait_for_packet->is_signaled = false;
-		this->mode->state = EFI_NETWORK_INITIALIZED;
-	}
-out:
-	return EFI_EXIT(r);
-}
-
-/*
- * efi_net_reset() - reinitialize the network interface
- *
- * This function implements the Reset service of the
- * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
- * (UEFI) specification for details.
- *
- * @this:			pointer to the protocol instance
- * @extended_verification:	execute exhaustive verification
- * Return:			status code
- */
-static efi_status_t EFIAPI efi_net_reset(struct efi_simple_network *this,
-					 int extended_verification)
-{
-	efi_status_t ret;
-
-	EFI_ENTRY("%p, %x", this, extended_verification);
-
-	/* Check parameters */
-	if (!this) {
-		ret = EFI_INVALID_PARAMETER;
-		goto out;
-	}
-
-	switch (this->mode->state) {
-	case EFI_NETWORK_INITIALIZED:
-		break;
-	case EFI_NETWORK_STOPPED:
-		ret = EFI_NOT_STARTED;
-		goto out;
-	default:
-		ret = EFI_DEVICE_ERROR;
-		goto out;
-	}
-
-	this->mode->state = EFI_NETWORK_STARTED;
-	ret = EFI_CALL(efi_net_initialize(this, 0, 0));
-out:
-	return EFI_EXIT(ret);
-}
-
-/*
- * efi_net_shutdown() - shut down the network interface
- *
- * This function implements the Shutdown service of the
- * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
- * (UEFI) specification for details.
- *
- * @this:	pointer to the protocol instance
- * Return:	status code
- */
-static efi_status_t EFIAPI efi_net_shutdown(struct efi_simple_network *this)
-{
-	efi_status_t ret = EFI_SUCCESS;
-	struct efi_net_obj *nt;
-
-	EFI_ENTRY("%p", this);
-
-	/* Check parameters */
-	if (!this) {
-		ret = EFI_INVALID_PARAMETER;
-		goto out;
-	}
-	nt = efi_netobj_from_snp(this);
-
-	switch (this->mode->state) {
-	case EFI_NETWORK_INITIALIZED:
-		break;
-	case EFI_NETWORK_STOPPED:
-		ret = EFI_NOT_STARTED;
-		goto out;
-	default:
-		ret = EFI_DEVICE_ERROR;
-		goto out;
-	}
-
-	eth_set_dev(nt->dev);
-	env_set("ethact", eth_get_name());
-	eth_halt();
-
-	this->int_status = 0;
-	nt->wait_for_packet->is_signaled = false;
-	this->mode->state = EFI_NETWORK_STARTED;
-
-out:
-	return EFI_EXIT(ret);
-}
-
-/*
- * efi_net_receive_filters() - mange multicast receive filters
- *
- * This function implements the ReceiveFilters service of the
- * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
- * (UEFI) specification for details.
- *
- * @this:		pointer to the protocol instance
- * @enable:		bit mask of receive filters to enable
- * @disable:		bit mask of receive filters to disable
- * @reset_mcast_filter:	true resets contents of the filters
- * @mcast_filter_count:	number of hardware MAC addresses in the new filters list
- * @mcast_filter:	list of new filters
- * Return:		status code
- */
-static efi_status_t EFIAPI efi_net_receive_filters
-		(struct efi_simple_network *this, u32 enable, u32 disable,
-		 int reset_mcast_filter, ulong mcast_filter_count,
-		 struct efi_mac_address *mcast_filter)
-{
-	EFI_ENTRY("%p, %x, %x, %x, %lx, %p", this, enable, disable,
-		  reset_mcast_filter, mcast_filter_count, mcast_filter);
-
-	return EFI_EXIT(EFI_UNSUPPORTED);
-}
-
-/*
- * efi_net_station_address() - set the hardware MAC address
- *
- * This function implements the StationAddress service of the
- * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
- * (UEFI) specification for details.
- *
- * @this:	pointer to the protocol instance
- * @reset:	if true reset the address to default
- * @new_mac:	new MAC address
- * Return:	status code
- */
-static efi_status_t EFIAPI efi_net_station_address
-		(struct efi_simple_network *this, int reset,
-		 struct efi_mac_address *new_mac)
-{
-	EFI_ENTRY("%p, %x, %p", this, reset, new_mac);
-
-	return EFI_EXIT(EFI_UNSUPPORTED);
-}
-
-/*
- * efi_net_statistics() - reset or collect statistics of the network interface
- *
- * This function implements the Statistics service of the
- * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
- * (UEFI) specification for details.
- *
- * @this:	pointer to the protocol instance
- * @reset:	if true, the statistics are reset
- * @stat_size:	size of the statistics table
- * @stat_table:	table to receive the statistics
- * Return:	status code
- */
-static efi_status_t EFIAPI efi_net_statistics(struct efi_simple_network *this,
-					      int reset, ulong *stat_size,
-					      void *stat_table)
-{
-	EFI_ENTRY("%p, %x, %p, %p", this, reset, stat_size, stat_table);
-
-	return EFI_EXIT(EFI_UNSUPPORTED);
-}
-
-/*
- * efi_net_mcastiptomac() - translate multicast IP address to MAC address
- *
- * This function implements the MCastIPtoMAC service of the
- * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
- * (UEFI) specification for details.
- *
- * @this:	pointer to the protocol instance
- * @ipv6:	true if the IP address is an IPv6 address
- * @ip:		IP address
- * @mac:	MAC address
- * Return:	status code
- */
-static efi_status_t EFIAPI efi_net_mcastiptomac(struct efi_simple_network *this,
-						int ipv6,
-						struct efi_ip_address *ip,
-						struct efi_mac_address *mac)
-{
-	efi_status_t ret = EFI_SUCCESS;
-
-	EFI_ENTRY("%p, %x, %p, %p", this, ipv6, ip, mac);
-
-	if (!this || !ip || !mac) {
-		ret = EFI_INVALID_PARAMETER;
-		goto out;
-	}
-
-	if (ipv6) {
-		ret = EFI_UNSUPPORTED;
-		goto out;
-	}
-
-	/* Multi-cast addresses are in the range 224.0.0.0 - 239.255.255.255 */
-	if ((ip->ip_addr[0] & 0xf0) != 0xe0) {
-		ret = EFI_INVALID_PARAMETER;
-		goto out;
-	};
-
-	switch (this->mode->state) {
-	case EFI_NETWORK_INITIALIZED:
-	case EFI_NETWORK_STARTED:
-		break;
-	default:
-		ret = EFI_NOT_STARTED;
-		goto out;
-	}
-
-	memset(mac, 0, sizeof(struct efi_mac_address));
-
-	/*
-	 * Copy lower 23 bits of IPv4 multi-cast address
-	 * RFC 1112, RFC 7042 2.1.1.
-	 */
-	mac->mac_addr[0] = 0x01;
-	mac->mac_addr[1] = 0x00;
-	mac->mac_addr[2] = 0x5E;
-	mac->mac_addr[3] = ip->ip_addr[1] & 0x7F;
-	mac->mac_addr[4] = ip->ip_addr[2];
-	mac->mac_addr[5] = ip->ip_addr[3];
-out:
-	return EFI_EXIT(ret);
-}
-
-/**
- * efi_net_nvdata() - read or write NVRAM
- *
- * This function implements the GetStatus service of the Simple Network
- * Protocol. See the UEFI spec for details.
- *
- * @this:		the instance of the Simple Network Protocol
- * @read_write:		true for read, false for write
- * @offset:		offset in NVRAM
- * @buffer_size:	size of buffer
- * @buffer:		buffer
- * Return:		status code
- */
-static efi_status_t EFIAPI efi_net_nvdata(struct efi_simple_network *this,
-					  int read_write, ulong offset,
-					  ulong buffer_size, char *buffer)
-{
-	EFI_ENTRY("%p, %x, %lx, %lx, %p", this, read_write, offset, buffer_size,
-		  buffer);
-
-	return EFI_EXIT(EFI_UNSUPPORTED);
-}
-
-/**
- * efi_net_get_status() - get interrupt status
- *
- * This function implements the GetStatus service of the Simple Network
- * Protocol. See the UEFI spec for details.
- *
- * @this:		the instance of the Simple Network Protocol
- * @int_status:		interface status
- * @txbuf:		transmission buffer
- */
-static efi_status_t EFIAPI efi_net_get_status(struct efi_simple_network *this,
-					      u32 *int_status, void **txbuf)
-{
-	efi_status_t ret = EFI_SUCCESS;
-	struct efi_net_obj *nt;
-
-	EFI_ENTRY("%p, %p, %p", this, int_status, txbuf);
-
-	efi_timer_check();
-
-	/* Check parameters */
-	if (!this) {
-		ret = EFI_INVALID_PARAMETER;
-		goto out;
-	}
-
-	nt = efi_netobj_from_snp(this);
-
-	switch (this->mode->state) {
-	case EFI_NETWORK_STOPPED:
-		ret = EFI_NOT_STARTED;
-		goto out;
-	case EFI_NETWORK_STARTED:
-		ret = EFI_DEVICE_ERROR;
-		goto out;
-	default:
-		break;
-	}
-
-	if (int_status) {
-		*int_status = this->int_status;
-		this->int_status = 0;
-	}
-	if (txbuf)
-		*txbuf = nt->new_tx_packet;
-
-	nt->new_tx_packet = NULL;
-out:
-	return EFI_EXIT(ret);
-}
-
-/**
- * efi_net_transmit() - transmit a packet
- *
- * This function implements the Transmit service of the Simple Network Protocol.
- * See the UEFI spec for details.
- *
- * @this:		the instance of the Simple Network Protocol
- * @header_size:	size of the media header
- * @buffer_size:	size of the buffer to receive the packet
- * @buffer:		buffer to receive the packet
- * @src_addr:		source hardware MAC address
- * @dest_addr:		destination hardware MAC address
- * @protocol:		type of header to build
- * Return:		status code
- */
-static efi_status_t EFIAPI efi_net_transmit
-		(struct efi_simple_network *this, size_t header_size,
-		 size_t buffer_size, void *buffer,
-		 struct efi_mac_address *src_addr,
-		 struct efi_mac_address *dest_addr, u16 *protocol)
-{
-	efi_status_t ret = EFI_SUCCESS;
-	struct efi_net_obj *nt;
-
-	EFI_ENTRY("%p, %lu, %lu, %p, %p, %p, %p", this,
-		  (unsigned long)header_size, (unsigned long)buffer_size,
-		  buffer, src_addr, dest_addr, protocol);
-
-	efi_timer_check();
-
-	/* Check parameters */
-	if (!this || !buffer) {
-		ret = EFI_INVALID_PARAMETER;
-		goto out;
-	}
-
-	nt = efi_netobj_from_snp(this);
-
-	/* We do not support jumbo packets */
-	if (buffer_size > PKTSIZE_ALIGN) {
-		ret = EFI_INVALID_PARAMETER;
-		goto out;
-	}
-
-	/* At least the IP header has to fit into the buffer */
-	if (buffer_size < this->mode->media_header_size) {
-		ret = EFI_BUFFER_TOO_SMALL;
-		goto out;
-	}
-
-	/*
-	 * TODO:
-	 * Support VLANs. Use net_set_ether() for copying the header. Use a
-	 * U_BOOT_ENV_CALLBACK to update the media header size.
-	 */
-	if (header_size) {
-		struct ethernet_hdr *header = buffer;
-
-		if (!dest_addr || !protocol ||
-		    header_size != this->mode->media_header_size) {
-			ret = EFI_INVALID_PARAMETER;
-			goto out;
-		}
-		if (!src_addr)
-			src_addr = &this->mode->current_address;
-
-		memcpy(header->et_dest, dest_addr, ARP_HLEN);
-		memcpy(header->et_src, src_addr, ARP_HLEN);
-		header->et_protlen = htons(*protocol);
-	}
-
-	switch (this->mode->state) {
-	case EFI_NETWORK_STOPPED:
-		ret = EFI_NOT_STARTED;
-		goto out;
-	case EFI_NETWORK_STARTED:
-		ret = EFI_DEVICE_ERROR;
-		goto out;
-	default:
-		break;
-	}
-
-	eth_set_dev(nt->dev);
-	env_set("ethact", eth_get_name());
-
-	/* Ethernet packets always fit, just bounce */
-	memcpy(nt->transmit_buffer, buffer, buffer_size);
-	net_send_packet(nt->transmit_buffer, buffer_size);
-
-	nt->new_tx_packet = buffer;
-	this->int_status |= EFI_SIMPLE_NETWORK_TRANSMIT_INTERRUPT;
-out:
-	return EFI_EXIT(ret);
-}
-
-/**
- * efi_net_receive() - receive a packet from a network interface
- *
- * This function implements the Receive service of the Simple Network Protocol.
- * See the UEFI spec for details.
- *
- * @this:		the instance of the Simple Network Protocol
- * @header_size:	size of the media header
- * @buffer_size:	size of the buffer to receive the packet
- * @buffer:		buffer to receive the packet
- * @src_addr:		source MAC address
- * @dest_addr:		destination MAC address
- * @protocol:		protocol
- * Return:		status code
- */
-static efi_status_t EFIAPI efi_net_receive
-		(struct efi_simple_network *this, size_t *header_size,
-		 size_t *buffer_size, void *buffer,
-		 struct efi_mac_address *src_addr,
-		 struct efi_mac_address *dest_addr, u16 *protocol)
-{
-	efi_status_t ret = EFI_SUCCESS;
-	struct ethernet_hdr *eth_hdr;
-	size_t hdr_size = sizeof(struct ethernet_hdr);
-	u16 protlen;
-	struct efi_net_obj *nt;
-
-	EFI_ENTRY("%p, %p, %p, %p, %p, %p, %p", this, header_size,
-		  buffer_size, buffer, src_addr, dest_addr, protocol);
-
-	/* Execute events */
-	efi_timer_check();
-
-	/* Check parameters */
-	if (!this || !buffer || !buffer_size) {
-		ret = EFI_INVALID_PARAMETER;
-		goto out;
-	}
-
-	nt = efi_netobj_from_snp(this);
-
-	switch (this->mode->state) {
-	case EFI_NETWORK_STOPPED:
-		ret = EFI_NOT_STARTED;
-		goto out;
-	case EFI_NETWORK_STARTED:
-		ret = EFI_DEVICE_ERROR;
-		goto out;
-	default:
-		break;
-	}
-
-	if (!nt->rx_packet_num) {
-		ret = EFI_NOT_READY;
-		goto out;
-	}
-	/* Fill export parameters */
-	eth_hdr = (struct ethernet_hdr *)nt->receive_buffer[nt->rx_packet_idx];
-	protlen = ntohs(eth_hdr->et_protlen);
-	if (protlen == 0x8100) {
-		hdr_size += 4;
-		protlen = ntohs(*(u16 *)&nt->receive_buffer[nt->rx_packet_idx][hdr_size - 2]);
-	}
-	if (header_size)
-		*header_size = hdr_size;
-	if (dest_addr)
-		memcpy(dest_addr, eth_hdr->et_dest, ARP_HLEN);
-	if (src_addr)
-		memcpy(src_addr, eth_hdr->et_src, ARP_HLEN);
-	if (protocol)
-		*protocol = protlen;
-	if (*buffer_size < nt->receive_lengths[nt->rx_packet_idx]) {
-		/* Packet doesn't fit, try again with bigger buffer */
-		*buffer_size = nt->receive_lengths[nt->rx_packet_idx];
-		ret = EFI_BUFFER_TOO_SMALL;
-		goto out;
-	}
-	/* Copy packet */
-	memcpy(buffer, nt->receive_buffer[nt->rx_packet_idx],
-	       nt->receive_lengths[nt->rx_packet_idx]);
-	*buffer_size = nt->receive_lengths[nt->rx_packet_idx];
-	nt->rx_packet_idx = (nt->rx_packet_idx + 1) % ETH_PACKETS_BATCH_RECV;
-	nt->rx_packet_num--;
-	if (nt->rx_packet_num)
-		nt->wait_for_packet->is_signaled = true;
-	else
-		this->int_status &= ~EFI_SIMPLE_NETWORK_RECEIVE_INTERRUPT;
-out:
-	return EFI_EXIT(ret);
-}
-
 /**
  * efi_net_set_dhcp_ack() - take note of a selected DHCP IP address
  *
@@ -765,7 +94,10 @@ out:
  */
 void efi_net_set_dhcp_ack(void *pkt, int len)
 {
+	efi_status_t r = EFI_SUCCESS;
 	struct efi_pxe_packet **dhcp_ack;
+	struct efi_handler *phandler;
+	struct efi_pxe_base_code_protocol *pxe;
 	struct udevice *dev;
 	int i;
 
@@ -791,200 +123,17 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
 
 	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
 		if (net_objs[i] && net_objs[i]->dev == dev) {
-			net_objs[i]->pxe_mode.dhcp_ack = **dhcp_ack;
-		}
-	}
-}
-
-/**
- * efi_net_push() - callback for received network packet
- *
- * This function is called when a network packet is received by eth_rx().
- *
- * @pkt:	network packet
- * @len:	length
- */
-static void efi_net_push(void *pkt, int len)
-{
-	int rx_packet_next;
-	struct efi_net_obj *nt;
-
-	nt = net_objs[curr_efi_net_obj];
-	if (!nt)
-		return;
-
-	/* Check that we at least received an Ethernet header */
-	if (len < sizeof(struct ethernet_hdr))
-		return;
-
-	/* Check that the buffer won't overflow */
-	if (len > PKTSIZE_ALIGN)
-		return;
-
-	/* Can't store more than pre-alloced buffer */
-	if (nt->rx_packet_num >= ETH_PACKETS_BATCH_RECV)
-		return;
-
-	rx_packet_next = (nt->rx_packet_idx + nt->rx_packet_num) %
-	    ETH_PACKETS_BATCH_RECV;
-	memcpy(nt->receive_buffer[rx_packet_next], pkt, len);
-	nt->receive_lengths[rx_packet_next] = len;
-
-	nt->rx_packet_num++;
-}
-
-/**
- * efi_network_timer_notify() - check if a new network packet has been received
- *
- * This notification function is called in every timer cycle.
- *
- * @event:	the event for which this notification function is registered
- * @context:	event context - not used in this function
- */
-static void EFIAPI efi_network_timer_notify(struct efi_event *event,
-					    void *context)
-{
-	struct efi_simple_network *this = (struct efi_simple_network *)context;
-	struct efi_net_obj *nt;
-
-	EFI_ENTRY("%p, %p", event, context);
-
-	/*
-	 * Some network drivers do not support calling eth_rx() before
-	 * initialization.
-	 */
-	if (!this || this->mode->state != EFI_NETWORK_INITIALIZED)
-		goto out;
-
-	nt = efi_netobj_from_snp(this);
-	curr_efi_net_obj = nt->efi_seq_num;
-
-	if (!nt->rx_packet_num) {
-		eth_set_dev(nt->dev);
-		env_set("ethact", eth_get_name());
-		push_packet = efi_net_push;
-		eth_rx();
-		push_packet = NULL;
-		if (nt->rx_packet_num) {
-			this->int_status |=
-				EFI_SIMPLE_NETWORK_RECEIVE_INTERRUPT;
-			nt->wait_for_packet->is_signaled = true;
+			phandler = NULL;
+			r = efi_search_protocol(&net_objs[i]->header,
+						&efi_pxe_base_code_protocol_guid,
+						&phandler);
+			if (r == EFI_SUCCESS && phandler) {
+				pxe = phandler->protocol_interface;
+				pxe->mode->dhcp_ack = **dhcp_ack;
+			}
+			break;
 		}
 	}
-out:
-	EFI_EXIT(EFI_SUCCESS);
-}
-
-static efi_status_t EFIAPI efi_pxe_base_code_start(
-				struct efi_pxe_base_code_protocol *this,
-				u8 use_ipv6)
-{
-	return EFI_UNSUPPORTED;
-}
-
-static efi_status_t EFIAPI efi_pxe_base_code_stop(
-				struct efi_pxe_base_code_protocol *this)
-{
-	return EFI_UNSUPPORTED;
-}
-
-static efi_status_t EFIAPI efi_pxe_base_code_dhcp(
-				struct efi_pxe_base_code_protocol *this,
-				u8 sort_offers)
-{
-	return EFI_UNSUPPORTED;
-}
-
-static efi_status_t EFIAPI efi_pxe_base_code_discover(
-				struct efi_pxe_base_code_protocol *this,
-				u16 type, u16 *layer, u8 bis,
-				struct efi_pxe_base_code_discover_info *info)
-{
-	return EFI_UNSUPPORTED;
-}
-
-static efi_status_t EFIAPI efi_pxe_base_code_mtftp(
-				struct efi_pxe_base_code_protocol *this,
-				u32 operation, void *buffer_ptr,
-				u8 overwrite, efi_uintn_t *buffer_size,
-				struct efi_ip_address server_ip, char *filename,
-				struct efi_pxe_base_code_mtftp_info *info,
-				u8 dont_use_buffer)
-{
-	return EFI_UNSUPPORTED;
-}
-
-static efi_status_t EFIAPI efi_pxe_base_code_udp_write(
-				struct efi_pxe_base_code_protocol *this,
-				u16 op_flags, struct efi_ip_address *dest_ip,
-				u16 *dest_port,
-				struct efi_ip_address *gateway_ip,
-				struct efi_ip_address *src_ip, u16 *src_port,
-				efi_uintn_t *header_size, void *header_ptr,
-				efi_uintn_t *buffer_size, void *buffer_ptr)
-{
-	return EFI_UNSUPPORTED;
-}
-
-static efi_status_t EFIAPI efi_pxe_base_code_udp_read(
-				struct efi_pxe_base_code_protocol *this,
-				u16 op_flags, struct efi_ip_address *dest_ip,
-				u16 *dest_port, struct efi_ip_address *src_ip,
-				u16 *src_port, efi_uintn_t *header_size,
-				void *header_ptr, efi_uintn_t *buffer_size,
-				void *buffer_ptr)
-{
-	return EFI_UNSUPPORTED;
-}
-
-static efi_status_t EFIAPI efi_pxe_base_code_set_ip_filter(
-				struct efi_pxe_base_code_protocol *this,
-				struct efi_pxe_base_code_filter *new_filter)
-{
-	return EFI_UNSUPPORTED;
-}
-
-static efi_status_t EFIAPI efi_pxe_base_code_arp(
-				struct efi_pxe_base_code_protocol *this,
-				struct efi_ip_address *ip_addr,
-				struct efi_mac_address *mac_addr)
-{
-	return EFI_UNSUPPORTED;
-}
-
-static efi_status_t EFIAPI efi_pxe_base_code_set_parameters(
-				struct efi_pxe_base_code_protocol *this,
-				u8 *new_auto_arp, u8 *new_send_guid,
-				u8 *new_ttl, u8 *new_tos,
-				u8 *new_make_callback)
-{
-	return EFI_UNSUPPORTED;
-}
-
-static efi_status_t EFIAPI efi_pxe_base_code_set_station_ip(
-				struct efi_pxe_base_code_protocol *this,
-				struct efi_ip_address *new_station_ip,
-				struct efi_ip_address *new_subnet_mask)
-{
-	return EFI_UNSUPPORTED;
-}
-
-static efi_status_t EFIAPI efi_pxe_base_code_set_packets(
-				struct efi_pxe_base_code_protocol *this,
-				u8 *new_dhcp_discover_valid,
-				u8 *new_dhcp_ack_received,
-				u8 *new_proxy_offer_received,
-				u8 *new_pxe_discover_valid,
-				u8 *new_pxe_reply_received,
-				u8 *new_pxe_bis_reply_received,
-				EFI_PXE_BASE_CODE_PACKET *new_dchp_discover,
-				EFI_PXE_BASE_CODE_PACKET *new_dhcp_acc,
-				EFI_PXE_BASE_CODE_PACKET *new_proxy_offer,
-				EFI_PXE_BASE_CODE_PACKET *new_pxe_discover,
-				EFI_PXE_BASE_CODE_PACKET *new_pxe_reply,
-				EFI_PXE_BASE_CODE_PACKET *new_pxe_bis_reply)
-{
-	return EFI_UNSUPPORTED;
 }
 
 /**
@@ -1066,6 +215,10 @@ efi_status_t efi_net_do_start(struct udevice *dev)
 	efi_status_t r = EFI_SUCCESS;
 	struct efi_net_obj *netobj;
 	struct efi_device_path *net_dp;
+#if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
+	struct efi_handler *phandler;
+	struct efi_pxe_base_code_protocol *pxe;
+#endif
 	int i;
 
 	netobj = NULL;
@@ -1097,17 +250,24 @@ efi_status_t efi_net_do_start(struct udevice *dev)
 	if (r != EFI_SUCCESS)
 		return r;
 set_addr:
-#ifdef CONFIG_EFI_HTTP_PROTOCOL
+#if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
 	/*
 	 * No harm on doing the following. If the PXE handle is present, the client could
 	 * find it and try to get its IP address from it. In here the PXE handle is present
 	 * but the PXE protocol is not yet implmenented, so we add this in the meantime.
 	 */
-	efi_net_get_addr((struct efi_ipv4_address *)&netobj->pxe_mode.station_ip,
-			 (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL, dev);
+	pxe = NULL;
+	r = efi_search_protocol(&netobj->header,
+				&efi_pxe_base_code_protocol_guid,
+				&phandler);
+	if (r == EFI_SUCCESS && phandler) {
+		pxe = phandler->protocol_interface;
+		efi_net_get_addr((struct efi_ipv4_address *)&pxe->mode->station_ip,
+				 (struct efi_ipv4_address *)&pxe->mode->subnet_mask, NULL, dev);
+	}
 #endif
 
-	return r;
+	return EFI_SUCCESS;
 }
 
 /**
@@ -1121,9 +281,7 @@ efi_status_t efi_net_register(struct udevice *dev)
 	efi_status_t r;
 	int seq_num;
 	struct efi_net_obj *netobj;
-	void *transmit_buffer = NULL;
-	uchar **receive_buffer = NULL;
-	size_t *receive_lengths;
+	struct efi_pxe_packet *dhcp_ack;
 	int i, j;
 
 	if (!dev) {
@@ -1150,161 +308,58 @@ efi_status_t efi_net_register(struct udevice *dev)
 
 	/* We only expose the "active" network device, so one is enough */
 	netobj = calloc(1, sizeof(*netobj));
-	if (!netobj)
-		goto out_of_resources;
-
-	netobj->dev = dev;
-
-	/* Allocate an aligned transmit buffer */
-	transmit_buffer = calloc(1, PKTSIZE_ALIGN + PKTALIGN);
-	if (!transmit_buffer)
-		goto out_of_resources;
-	transmit_buffer = (void *)ALIGN((uintptr_t)transmit_buffer, PKTALIGN);
-	netobj->transmit_buffer = transmit_buffer;
-
-	/* Allocate a number of receive buffers */
-	receive_buffer = calloc(ETH_PACKETS_BATCH_RECV,
-				sizeof(*receive_buffer));
-	if (!receive_buffer)
-		goto out_of_resources;
-	for (i = 0; i < ETH_PACKETS_BATCH_RECV; i++) {
-		receive_buffer[i] = malloc(PKTSIZE_ALIGN);
-		if (!receive_buffer[i])
-			goto out_of_resources;
+	if (!netobj) {
+		printf("ERROR: Out of memory\n");
+		return EFI_OUT_OF_RESOURCES;
 	}
-	netobj->receive_buffer = receive_buffer;
 
-	receive_lengths = calloc(ETH_PACKETS_BATCH_RECV,
-				 sizeof(*receive_lengths));
-	if (!receive_lengths)
-		goto out_of_resources;
-	netobj->receive_lengths = receive_lengths;
+	netobj->dev = dev;
 
 	/* Hook net up to the device list */
 	efi_add_handle(&netobj->header);
 
-	/* Fill in object data */
-	r = efi_add_protocol(&netobj->header, &efi_net_guid,
-			     &netobj->net);
+	/* Install EFI_SIMPLE_NETWORK_PROTOCOL */
+	r = efi_simple_network_install(&netobj->header, dev);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 
-	r = efi_add_protocol(&netobj->header, &efi_pxe_base_code_protocol_guid,
-			     &netobj->pxe);
-	if (r != EFI_SUCCESS)
-		goto failure_to_add_protocol;
-	netobj->net.revision = EFI_SIMPLE_NETWORK_PROTOCOL_REVISION;
-	netobj->net.start = efi_net_start;
-	netobj->net.stop = efi_net_stop;
-	netobj->net.initialize = efi_net_initialize;
-	netobj->net.reset = efi_net_reset;
-	netobj->net.shutdown = efi_net_shutdown;
-	netobj->net.receive_filters = efi_net_receive_filters;
-	netobj->net.station_address = efi_net_station_address;
-	netobj->net.statistics = efi_net_statistics;
-	netobj->net.mcastiptomac = efi_net_mcastiptomac;
-	netobj->net.nvdata = efi_net_nvdata;
-	netobj->net.get_status = efi_net_get_status;
-	netobj->net.transmit = efi_net_transmit;
-	netobj->net.receive = efi_net_receive;
-	netobj->net.mode = &netobj->net_mode;
-	netobj->net_mode.state = EFI_NETWORK_STOPPED;
-	if (dev_get_plat(dev))
-		memcpy(netobj->net_mode.current_address.mac_addr,
-		       ((struct eth_pdata *)dev_get_plat(dev))->enetaddr, 6);
-	netobj->net_mode.hwaddr_size = ARP_HLEN;
-	netobj->net_mode.media_header_size = ETHER_HDR_SIZE;
-	netobj->net_mode.max_packet_size = PKTSIZE;
-	netobj->net_mode.if_type = ARP_ETHER;
-
-	netobj->pxe.revision = EFI_PXE_BASE_CODE_PROTOCOL_REVISION;
-	netobj->pxe.start = efi_pxe_base_code_start;
-	netobj->pxe.stop = efi_pxe_base_code_stop;
-	netobj->pxe.dhcp = efi_pxe_base_code_dhcp;
-	netobj->pxe.discover = efi_pxe_base_code_discover;
-	netobj->pxe.mtftp = efi_pxe_base_code_mtftp;
-	netobj->pxe.udp_write = efi_pxe_base_code_udp_write;
-	netobj->pxe.udp_read = efi_pxe_base_code_udp_read;
-	netobj->pxe.set_ip_filter = efi_pxe_base_code_set_ip_filter;
-	netobj->pxe.arp = efi_pxe_base_code_arp;
-	netobj->pxe.set_parameters = efi_pxe_base_code_set_parameters;
-	netobj->pxe.set_station_ip = efi_pxe_base_code_set_station_ip;
-	netobj->pxe.set_packets = efi_pxe_base_code_set_packets;
-	netobj->pxe.mode = &netobj->pxe_mode;
-
 	/*
 	 * Scan dhcp entries for one corresponding
 	 * to this udevice, from newest to oldest
 	 */
+	dhcp_ack = NULL;
 	i = (next_dhcp_entry + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES;
 	for (j = 0; dhcp_cache[i].is_valid && j < MAX_NUM_DHCP_ENTRIES;
 	     i = (i + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES, j++) {
 		if (dev == dhcp_cache[i].dev) {
-			netobj->pxe_mode.dhcp_ack = *dhcp_cache[i].dhcp_ack;
+			dhcp_ack = dhcp_cache[i].dhcp_ack;
 			break;
 		}
 	}
 
-	/*
-	 * Create WaitForPacket event.
-	 */
-	r = efi_create_event(EVT_NOTIFY_WAIT, TPL_CALLBACK,
-			     efi_network_timer_notify, NULL, NULL,
-			     &netobj->wait_for_packet);
-	if (r != EFI_SUCCESS) {
-		printf("ERROR: Failed to register network event\n");
-		return r;
-	}
-	netobj->net.wait_for_packet = netobj->wait_for_packet;
-	/*
-	 * Create a timer event.
-	 *
-	 * The notification function is used to check if a new network packet
-	 * has been received.
-	 *
-	 * iPXE is running at TPL_CALLBACK most of the time. Use a higher TPL.
-	 */
-	r = efi_create_event(EVT_TIMER | EVT_NOTIFY_SIGNAL, TPL_NOTIFY,
-			     efi_network_timer_notify, &netobj->net, NULL,
-			     &netobj->network_timer_event);
-	if (r != EFI_SUCCESS) {
-		printf("ERROR: Failed to register network event\n");
-		return r;
-	}
-	/* Network is time critical, create event in every timer cycle */
-	r = efi_set_timer(netobj->network_timer_event, EFI_TIMER_PERIODIC, 0);
-	if (r != EFI_SUCCESS) {
-		printf("ERROR: Failed to set network timer\n");
-		return r;
-	}
+	/* Install EFI_PXE_BASE_CODE_PROTOCOL */
+	r = efi_pxe_install(&netobj->header, dhcp_ack);
+	if (r != EFI_SUCCESS)
+		goto failure_to_add_protocol;
 
 #if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
+	/* Install EFI_IP4_CONFIG2_PROTOCOL */
 	r = efi_ip4_config2_install(&netobj->header);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 #endif
 #ifdef CONFIG_EFI_HTTP_PROTOCOL
+	/* Install EFI_HTTP_PROTOCOL */
 	r = efi_http_install(&netobj->header);
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 #endif
-	netobj->efi_seq_num = seq_num;
+
 	net_objs[seq_num] = netobj;
 	return EFI_SUCCESS;
 failure_to_add_protocol:
 	printf("ERROR: Failure to add protocol\n");
 	return r;
-out_of_resources:
-	free(netobj);
-	netobj = NULL;
-	free(transmit_buffer);
-	if (receive_buffer)
-		for (i = 0; i < ETH_PACKETS_BATCH_RECV; i++)
-			free(receive_buffer[i]);
-	free(receive_buffer);
-	free(receive_lengths);
-	printf("ERROR: Out of memory\n");
-	return EFI_OUT_OF_RESOURCES;
 }
 
 /**
@@ -1656,7 +711,8 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buf
 		ret = efi_search_protocol(&net_objs[i]->header,
 					  &efi_http_service_binding_guid,
 					  &phandler);
-		if (ret == EFI_SUCCESS && phandler == (void *)parent) {
+		if (ret == EFI_SUCCESS && phandler &&
+		    phandler->protocol_interface == (void *)parent) {
 			dev = net_objs[i]->dev;
 			break;
 		}
diff --git a/lib/efi_loader/net/efi_pxe.c b/lib/efi_loader/net/efi_pxe.c
new file mode 100644
index 00000000000..69cc5f22f6d
--- /dev/null
+++ b/lib/efi_loader/net/efi_pxe.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PXE base code protocol
+ *
+ * Copyright (c) 2016 Alexander Graf
+ *
+ */
+
+#define LOG_CATEGORY LOGC_EFI
+
+#include <efi_loader.h>
+#include <dm.h>
+#include <linux/sizes.h>
+#include <malloc.h>
+#include <vsprintf.h>
+#include <net.h>
+
+static const efi_guid_t efi_pxe_base_code_protocol_guid =
+					EFI_PXE_BASE_CODE_PROTOCOL_GUID;
+
+/**
+ * struct efi_pxe_base_code_extended_protocol - EFI object representing a
+ *												EFI_PXE_BASE_CODE_PROTOCOL
+ *												interface
+ *
+ * @pxe:			PXE base code protocol interface
+ * @pxe_mode:			status of the PXE base code protocol
+
+ */
+struct efi_pxe_base_code_extended_protocol {
+	struct efi_pxe_base_code_protocol pxe;
+	struct efi_pxe_mode pxe_mode;
+};
+
+static efi_status_t EFIAPI efi_pxe_base_code_start(
+				struct efi_pxe_base_code_protocol *this,
+				u8 use_ipv6)
+{
+	return EFI_UNSUPPORTED;
+}
+
+static efi_status_t EFIAPI efi_pxe_base_code_stop(
+				struct efi_pxe_base_code_protocol *this)
+{
+	return EFI_UNSUPPORTED;
+}
+
+static efi_status_t EFIAPI efi_pxe_base_code_dhcp(
+				struct efi_pxe_base_code_protocol *this,
+				u8 sort_offers)
+{
+	return EFI_UNSUPPORTED;
+}
+
+static efi_status_t EFIAPI efi_pxe_base_code_discover(
+				struct efi_pxe_base_code_protocol *this,
+				u16 type, u16 *layer, u8 bis,
+				struct efi_pxe_base_code_discover_info *info)
+{
+	return EFI_UNSUPPORTED;
+}
+
+static efi_status_t EFIAPI efi_pxe_base_code_mtftp(
+				struct efi_pxe_base_code_protocol *this,
+				u32 operation, void *buffer_ptr,
+				u8 overwrite, efi_uintn_t *buffer_size,
+				struct efi_ip_address server_ip, char *filename,
+				struct efi_pxe_base_code_mtftp_info *info,
+				u8 dont_use_buffer)
+{
+	return EFI_UNSUPPORTED;
+}
+
+static efi_status_t EFIAPI efi_pxe_base_code_udp_write(
+				struct efi_pxe_base_code_protocol *this,
+				u16 op_flags, struct efi_ip_address *dest_ip,
+				u16 *dest_port,
+				struct efi_ip_address *gateway_ip,
+				struct efi_ip_address *src_ip, u16 *src_port,
+				efi_uintn_t *header_size, void *header_ptr,
+				efi_uintn_t *buffer_size, void *buffer_ptr)
+{
+	return EFI_UNSUPPORTED;
+}
+
+static efi_status_t EFIAPI efi_pxe_base_code_udp_read(
+				struct efi_pxe_base_code_protocol *this,
+				u16 op_flags, struct efi_ip_address *dest_ip,
+				u16 *dest_port, struct efi_ip_address *src_ip,
+				u16 *src_port, efi_uintn_t *header_size,
+				void *header_ptr, efi_uintn_t *buffer_size,
+				void *buffer_ptr)
+{
+	return EFI_UNSUPPORTED;
+}
+
+static efi_status_t EFIAPI efi_pxe_base_code_set_ip_filter(
+				struct efi_pxe_base_code_protocol *this,
+				struct efi_pxe_base_code_filter *new_filter)
+{
+	return EFI_UNSUPPORTED;
+}
+
+static efi_status_t EFIAPI efi_pxe_base_code_arp(
+				struct efi_pxe_base_code_protocol *this,
+				struct efi_ip_address *ip_addr,
+				struct efi_mac_address *mac_addr)
+{
+	return EFI_UNSUPPORTED;
+}
+
+static efi_status_t EFIAPI efi_pxe_base_code_set_parameters(
+				struct efi_pxe_base_code_protocol *this,
+				u8 *new_auto_arp, u8 *new_send_guid,
+				u8 *new_ttl, u8 *new_tos,
+				u8 *new_make_callback)
+{
+	return EFI_UNSUPPORTED;
+}
+
+static efi_status_t EFIAPI efi_pxe_base_code_set_station_ip(
+				struct efi_pxe_base_code_protocol *this,
+				struct efi_ip_address *new_station_ip,
+				struct efi_ip_address *new_subnet_mask)
+{
+	return EFI_UNSUPPORTED;
+}
+
+static efi_status_t EFIAPI efi_pxe_base_code_set_packets(
+				struct efi_pxe_base_code_protocol *this,
+				u8 *new_dhcp_discover_valid,
+				u8 *new_dhcp_ack_received,
+				u8 *new_proxy_offer_received,
+				u8 *new_pxe_discover_valid,
+				u8 *new_pxe_reply_received,
+				u8 *new_pxe_bis_reply_received,
+				EFI_PXE_BASE_CODE_PACKET *new_dchp_discover,
+				EFI_PXE_BASE_CODE_PACKET *new_dhcp_acc,
+				EFI_PXE_BASE_CODE_PACKET *new_proxy_offer,
+				EFI_PXE_BASE_CODE_PACKET *new_pxe_discover,
+				EFI_PXE_BASE_CODE_PACKET *new_pxe_reply,
+				EFI_PXE_BASE_CODE_PACKET *new_pxe_bis_reply)
+{
+	return EFI_UNSUPPORTED;
+}
+
+
+/**
+ * efi_pxe_install() - install the EFI_PXE_BASE_CODE_PROTOCOL
+ *
+ * @handle:	handle to install the protocol
+ */
+efi_status_t efi_pxe_install(const efi_handle_t handle,
+			     struct efi_pxe_packet *dhcp_ack)
+{
+	efi_status_t r;
+	struct efi_pxe_base_code_extended_protocol *pxe;
+
+	/* We only expose the "active" network device, so one is enough */
+	pxe = calloc(1, sizeof(*pxe));
+	if (!pxe) {
+		printf("ERROR: Out of memory\n");
+		return EFI_OUT_OF_RESOURCES;
+	}
+
+	pxe->pxe.revision = EFI_PXE_BASE_CODE_PROTOCOL_REVISION;
+	pxe->pxe.start = efi_pxe_base_code_start;
+	pxe->pxe.stop = efi_pxe_base_code_stop;
+	pxe->pxe.dhcp = efi_pxe_base_code_dhcp;
+	pxe->pxe.discover = efi_pxe_base_code_discover;
+	pxe->pxe.mtftp = efi_pxe_base_code_mtftp;
+	pxe->pxe.udp_write = efi_pxe_base_code_udp_write;
+	pxe->pxe.udp_read = efi_pxe_base_code_udp_read;
+	pxe->pxe.set_ip_filter = efi_pxe_base_code_set_ip_filter;
+	pxe->pxe.arp = efi_pxe_base_code_arp;
+	pxe->pxe.set_parameters = efi_pxe_base_code_set_parameters;
+	pxe->pxe.set_station_ip = efi_pxe_base_code_set_station_ip;
+	pxe->pxe.set_packets = efi_pxe_base_code_set_packets;
+	pxe->pxe.mode = &pxe->pxe_mode;
+
+	if (dhcp_ack)
+		pxe->pxe_mode.dhcp_ack = *dhcp_ack;
+
+	r = efi_add_protocol(handle, &efi_pxe_base_code_protocol_guid,
+			     &pxe->pxe);
+	if (r != EFI_SUCCESS)
+		return r;
+
+	return EFI_SUCCESS;
+}
diff --git a/lib/efi_loader/net/efi_simple_network.c b/lib/efi_loader/net/efi_simple_network.c
new file mode 100644
index 00000000000..c7c03062b11
--- /dev/null
+++ b/lib/efi_loader/net/efi_simple_network.c
@@ -0,0 +1,880 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Simple network protocol
+ *
+ * Copyright (c) 2016 Alexander Graf
+ *
+ * The simple network protocol has the following statuses and services
+ * to move between them:
+ *
+ * Start():	 EfiSimpleNetworkStopped     -> EfiSimpleNetworkStarted
+ * Initialize(): EfiSimpleNetworkStarted     -> EfiSimpleNetworkInitialized
+ * Shutdown():	 EfiSimpleNetworkInitialized -> EfiSimpleNetworkStarted
+ * Stop():	 EfiSimpleNetworkStarted     -> EfiSimpleNetworkStopped
+ * Reset():	 EfiSimpleNetworkInitialized -> EfiSimpleNetworkInitialized
+ */
+
+#define LOG_CATEGORY LOGC_EFI
+
+#include <efi_loader.h>
+#include <dm.h>
+#include <linux/sizes.h>
+#include <malloc.h>
+#include <vsprintf.h>
+#include <net.h>
+
+static const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
+
+/**
+ * struct efi_simple_network_extended_protocol - EFI object representing an
+ *						 EFI_SIMPLE_NETWORK_PROTOCOL
+ *						 interface
+ *
+ * @net:			simple network protocol interface
+ * @net_mode:			status of the network interface
+ * @dev:			net udevice
+ * @new_tx_packet:		new transmit packet
+ * @transmit_buffer:	transmit buffer
+ * @receive_buffer:		array of receive buffers
+ * @receive_lengths:	array of lengths for received packets
+ * @rx_packet_idx:		index of the current receive packet
+ * @rx_packet_num:		number of received packets
+ * @wait_for_packet:	signaled when a packet has been received
+ * @network_timer_event:	event to check for new network packets.
+ */
+struct efi_simple_network_extended_protocol {
+	struct efi_simple_network_protocol net;
+	struct efi_simple_network_mode net_mode;
+	struct udevice *dev;
+	void *new_tx_packet;
+	void *transmit_buffer;
+	uchar **receive_buffer;
+	size_t *receive_lengths;
+	int rx_packet_idx;
+	int rx_packet_num;
+	struct efi_event *wait_for_packet;
+	struct efi_event *network_timer_event;
+};
+
+static struct efi_simple_network_extended_protocol *current_network;
+
+/*
+ * efi_net_start() - start the network interface
+ *
+ * This function implements the Start service of the
+ * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:	pointer to the protocol instance
+ * Return:	status code
+ */
+static efi_status_t EFIAPI efi_net_start(struct efi_simple_network_protocol *this)
+{
+	efi_status_t ret = EFI_SUCCESS;
+	struct efi_simple_network_extended_protocol *nt;
+
+	EFI_ENTRY("%p", this);
+	/* Check parameters */
+	if (!this) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	nt = (struct efi_simple_network_extended_protocol *)this;
+
+	if (this->mode->state != EFI_NETWORK_STOPPED) {
+		ret = EFI_ALREADY_STARTED;
+	} else {
+		this->int_status = 0;
+		nt->wait_for_packet->is_signaled = false;
+		this->mode->state = EFI_NETWORK_STARTED;
+	}
+out:
+	return EFI_EXIT(ret);
+}
+
+/*
+ * efi_net_stop() - stop the network interface
+ *
+ * This function implements the Stop service of the
+ * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:	pointer to the protocol instance
+ * Return:	status code
+ */
+static efi_status_t EFIAPI efi_net_stop(struct efi_simple_network_protocol *this)
+{
+	efi_status_t ret = EFI_SUCCESS;
+	struct efi_simple_network_extended_protocol *nt;
+
+	EFI_ENTRY("%p", this);
+
+	/* Check parameters */
+	if (!this) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	nt = (struct efi_simple_network_extended_protocol *)this;
+
+	if (this->mode->state == EFI_NETWORK_STOPPED) {
+		ret = EFI_NOT_STARTED;
+	} else {
+		/* Disable hardware and put it into the reset state */
+		eth_set_dev(nt->dev);
+		env_set("ethact", eth_get_name());
+		eth_halt();
+		/* Clear cache of packets */
+		nt->rx_packet_num = 0;
+		this->mode->state = EFI_NETWORK_STOPPED;
+	}
+out:
+	return EFI_EXIT(ret);
+}
+
+/*
+ * efi_net_initialize() - initialize the network interface
+ *
+ * This function implements the Initialize service of the
+ * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:	pointer to the protocol instance
+ * @extra_rx:	extra receive buffer to be allocated
+ * @extra_tx:	extra transmit buffer to be allocated
+ * Return:	status code
+ */
+static efi_status_t EFIAPI efi_net_initialize(struct efi_simple_network_protocol *this,
+					      ulong extra_rx, ulong extra_tx)
+{
+	int ret;
+	efi_status_t r = EFI_SUCCESS;
+	struct efi_simple_network_extended_protocol *nt;
+
+	EFI_ENTRY("%p, %lx, %lx", this, extra_rx, extra_tx);
+
+	/* Check parameters */
+	if (!this) {
+		r = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+	nt = (struct efi_simple_network_extended_protocol *)this;
+
+	switch (this->mode->state) {
+	case EFI_NETWORK_INITIALIZED:
+	case EFI_NETWORK_STARTED:
+		break;
+	default:
+		r = EFI_NOT_STARTED;
+		goto out;
+	}
+
+	/* Setup packet buffers */
+	net_init();
+	/* Clear cache of packets */
+	nt->rx_packet_num = 0;
+	/* Set the net device corresponding to the efi net object */
+	eth_set_dev(nt->dev);
+	env_set("ethact", eth_get_name());
+	/* Get hardware ready for send and receive operations */
+	ret = eth_start_udev(nt->dev);
+	if (ret < 0) {
+		eth_halt();
+		this->mode->state = EFI_NETWORK_STOPPED;
+		r = EFI_DEVICE_ERROR;
+		goto out;
+	} else {
+		this->int_status = 0;
+		nt->wait_for_packet->is_signaled = false;
+		this->mode->state = EFI_NETWORK_INITIALIZED;
+	}
+out:
+	return EFI_EXIT(r);
+}
+
+/*
+ * efi_net_reset() - reinitialize the network interface
+ *
+ * This function implements the Reset service of the
+ * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:			pointer to the protocol instance
+ * @extended_verification:	execute exhaustive verification
+ * Return:			status code
+ */
+static efi_status_t EFIAPI efi_net_reset(struct efi_simple_network_protocol *this,
+					 int extended_verification)
+{
+	efi_status_t ret;
+
+	EFI_ENTRY("%p, %x", this, extended_verification);
+
+	/* Check parameters */
+	if (!this) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	switch (this->mode->state) {
+	case EFI_NETWORK_INITIALIZED:
+		break;
+	case EFI_NETWORK_STOPPED:
+		ret = EFI_NOT_STARTED;
+		goto out;
+	default:
+		ret = EFI_DEVICE_ERROR;
+		goto out;
+	}
+
+	this->mode->state = EFI_NETWORK_STARTED;
+	ret = EFI_CALL(efi_net_initialize(this, 0, 0));
+out:
+	return EFI_EXIT(ret);
+}
+
+/*
+ * efi_net_shutdown() - shut down the network interface
+ *
+ * This function implements the Shutdown service of the
+ * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:	pointer to the protocol instance
+ * Return:	status code
+ */
+static efi_status_t EFIAPI efi_net_shutdown(struct efi_simple_network_protocol *this)
+{
+	efi_status_t ret = EFI_SUCCESS;
+	struct efi_simple_network_extended_protocol *nt;
+
+	EFI_ENTRY("%p", this);
+
+	/* Check parameters */
+	if (!this) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+	nt = (struct efi_simple_network_extended_protocol *)this;
+
+	switch (this->mode->state) {
+	case EFI_NETWORK_INITIALIZED:
+		break;
+	case EFI_NETWORK_STOPPED:
+		ret = EFI_NOT_STARTED;
+		goto out;
+	default:
+		ret = EFI_DEVICE_ERROR;
+		goto out;
+	}
+
+	eth_set_dev(nt->dev);
+	env_set("ethact", eth_get_name());
+	eth_halt();
+
+	this->int_status = 0;
+	nt->wait_for_packet->is_signaled = false;
+	this->mode->state = EFI_NETWORK_STARTED;
+
+out:
+	return EFI_EXIT(ret);
+}
+
+/*
+ * efi_net_receive_filters() - mange multicast receive filters
+ *
+ * This function implements the ReceiveFilters service of the
+ * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:		pointer to the protocol instance
+ * @enable:		bit mask of receive filters to enable
+ * @disable:		bit mask of receive filters to disable
+ * @reset_mcast_filter:	true resets contents of the filters
+ * @mcast_filter_count:	number of hardware MAC addresses in the new filters list
+ * @mcast_filter:	list of new filters
+ * Return:		status code
+ */
+static efi_status_t EFIAPI efi_net_receive_filters
+		(struct efi_simple_network_protocol *this, u32 enable, u32 disable,
+		 int reset_mcast_filter, ulong mcast_filter_count,
+		 struct efi_mac_address *mcast_filter)
+{
+	EFI_ENTRY("%p, %x, %x, %x, %lx, %p", this, enable, disable,
+		  reset_mcast_filter, mcast_filter_count, mcast_filter);
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+/*
+ * efi_net_station_address() - set the hardware MAC address
+ *
+ * This function implements the StationAddress service of the
+ * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:	pointer to the protocol instance
+ * @reset:	if true reset the address to default
+ * @new_mac:	new MAC address
+ * Return:	status code
+ */
+static efi_status_t EFIAPI efi_net_station_address
+		(struct efi_simple_network_protocol *this, int reset,
+		 struct efi_mac_address *new_mac)
+{
+	EFI_ENTRY("%p, %x, %p", this, reset, new_mac);
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+/*
+ * efi_net_statistics() - reset or collect statistics of the network interface
+ *
+ * This function implements the Statistics service of the
+ * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:	pointer to the protocol instance
+ * @reset:	if true, the statistics are reset
+ * @stat_size:	size of the statistics table
+ * @stat_table:	table to receive the statistics
+ * Return:	status code
+ */
+static efi_status_t EFIAPI efi_net_statistics(struct efi_simple_network_protocol *this,
+					      int reset, ulong *stat_size,
+					      void *stat_table)
+{
+	EFI_ENTRY("%p, %x, %p, %p", this, reset, stat_size, stat_table);
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+/*
+ * efi_net_mcastiptomac() - translate multicast IP address to MAC address
+ *
+ * This function implements the MCastIPtoMAC service of the
+ * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:	pointer to the protocol instance
+ * @ipv6:	true if the IP address is an IPv6 address
+ * @ip:		IP address
+ * @mac:	MAC address
+ * Return:	status code
+ */
+static efi_status_t EFIAPI efi_net_mcastiptomac(struct efi_simple_network_protocol *this,
+						int ipv6,
+						struct efi_ip_address *ip,
+						struct efi_mac_address *mac)
+{
+	efi_status_t ret = EFI_SUCCESS;
+
+	EFI_ENTRY("%p, %x, %p, %p", this, ipv6, ip, mac);
+
+	if (!this || !ip || !mac) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	if (ipv6) {
+		ret = EFI_UNSUPPORTED;
+		goto out;
+	}
+
+	/* Multi-cast addresses are in the range 224.0.0.0 - 239.255.255.255 */
+	if ((ip->ip_addr[0] & 0xf0) != 0xe0) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	};
+
+	switch (this->mode->state) {
+	case EFI_NETWORK_INITIALIZED:
+	case EFI_NETWORK_STARTED:
+		break;
+	default:
+		ret = EFI_NOT_STARTED;
+		goto out;
+	}
+
+	memset(mac, 0, sizeof(struct efi_mac_address));
+
+	/*
+	 * Copy lower 23 bits of IPv4 multi-cast address
+	 * RFC 1112, RFC 7042 2.1.1.
+	 */
+	mac->mac_addr[0] = 0x01;
+	mac->mac_addr[1] = 0x00;
+	mac->mac_addr[2] = 0x5E;
+	mac->mac_addr[3] = ip->ip_addr[1] & 0x7F;
+	mac->mac_addr[4] = ip->ip_addr[2];
+	mac->mac_addr[5] = ip->ip_addr[3];
+out:
+	return EFI_EXIT(ret);
+}
+
+/**
+ * efi_net_nvdata() - read or write NVRAM
+ *
+ * This function implements the GetStatus service of the Simple Network
+ * Protocol. See the UEFI spec for details.
+ *
+ * @this:		the instance of the Simple Network Protocol
+ * @read_write:		true for read, false for write
+ * @offset:		offset in NVRAM
+ * @buffer_size:	size of buffer
+ * @buffer:		buffer
+ * Return:		status code
+ */
+static efi_status_t EFIAPI efi_net_nvdata(struct efi_simple_network_protocol *this,
+					  int read_write, ulong offset,
+					  ulong buffer_size, char *buffer)
+{
+	EFI_ENTRY("%p, %x, %lx, %lx, %p", this, read_write, offset, buffer_size,
+		  buffer);
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+/**
+ * efi_net_get_status() - get interrupt status
+ *
+ * This function implements the GetStatus service of the Simple Network
+ * Protocol. See the UEFI spec for details.
+ *
+ * @this:		the instance of the Simple Network Protocol
+ * @int_status:		interface status
+ * @txbuf:		transmission buffer
+ */
+static efi_status_t EFIAPI efi_net_get_status(struct efi_simple_network_protocol *this,
+					      u32 *int_status, void **txbuf)
+{
+	efi_status_t ret = EFI_SUCCESS;
+	struct efi_simple_network_extended_protocol *nt;
+
+	EFI_ENTRY("%p, %p, %p", this, int_status, txbuf);
+
+	efi_timer_check();
+
+	/* Check parameters */
+	if (!this) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	nt = (struct efi_simple_network_extended_protocol *)this;
+
+	switch (this->mode->state) {
+	case EFI_NETWORK_STOPPED:
+		ret = EFI_NOT_STARTED;
+		goto out;
+	case EFI_NETWORK_STARTED:
+		ret = EFI_DEVICE_ERROR;
+		goto out;
+	default:
+		break;
+	}
+
+	if (int_status) {
+		*int_status = this->int_status;
+		this->int_status = 0;
+	}
+	if (txbuf)
+		*txbuf = nt->new_tx_packet;
+
+	nt->new_tx_packet = NULL;
+out:
+	return EFI_EXIT(ret);
+}
+
+/**
+ * efi_net_transmit() - transmit a packet
+ *
+ * This function implements the Transmit service of the Simple Network Protocol.
+ * See the UEFI spec for details.
+ *
+ * @this:		the instance of the Simple Network Protocol
+ * @header_size:	size of the media header
+ * @buffer_size:	size of the buffer to receive the packet
+ * @buffer:		buffer to receive the packet
+ * @src_addr:		source hardware MAC address
+ * @dest_addr:		destination hardware MAC address
+ * @protocol:		type of header to build
+ * Return:		status code
+ */
+static efi_status_t EFIAPI efi_net_transmit
+		(struct efi_simple_network_protocol *this, size_t header_size,
+		 size_t buffer_size, void *buffer,
+		 struct efi_mac_address *src_addr,
+		 struct efi_mac_address *dest_addr, u16 *protocol)
+{
+	efi_status_t ret = EFI_SUCCESS;
+	struct efi_simple_network_extended_protocol *nt;
+
+	EFI_ENTRY("%p, %lu, %lu, %p, %p, %p, %p", this,
+		  (unsigned long)header_size, (unsigned long)buffer_size,
+		  buffer, src_addr, dest_addr, protocol);
+
+	efi_timer_check();
+
+	/* Check parameters */
+	if (!this || !buffer) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	nt = (struct efi_simple_network_extended_protocol *)this;
+
+	/* We do not support jumbo packets */
+	if (buffer_size > PKTSIZE_ALIGN) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	/* At least the IP header has to fit into the buffer */
+	if (buffer_size < this->mode->media_header_size) {
+		ret = EFI_BUFFER_TOO_SMALL;
+		goto out;
+	}
+
+	/*
+	 * TODO:
+	 * Support VLANs. Use net_set_ether() for copying the header. Use a
+	 * U_BOOT_ENV_CALLBACK to update the media header size.
+	 */
+	if (header_size) {
+		struct ethernet_hdr *header = buffer;
+
+		if (!dest_addr || !protocol ||
+		    header_size != this->mode->media_header_size) {
+			ret = EFI_INVALID_PARAMETER;
+			goto out;
+		}
+		if (!src_addr)
+			src_addr = &this->mode->current_address;
+
+		memcpy(header->et_dest, dest_addr, ARP_HLEN);
+		memcpy(header->et_src, src_addr, ARP_HLEN);
+		header->et_protlen = htons(*protocol);
+	}
+
+	switch (this->mode->state) {
+	case EFI_NETWORK_STOPPED:
+		ret = EFI_NOT_STARTED;
+		goto out;
+	case EFI_NETWORK_STARTED:
+		ret = EFI_DEVICE_ERROR;
+		goto out;
+	default:
+		break;
+	}
+
+	eth_set_dev(nt->dev);
+	env_set("ethact", eth_get_name());
+
+	/* Ethernet packets always fit, just bounce */
+	memcpy(nt->transmit_buffer, buffer, buffer_size);
+	net_send_packet(nt->transmit_buffer, buffer_size);
+
+	nt->new_tx_packet = buffer;
+	this->int_status |= EFI_SIMPLE_NETWORK_TRANSMIT_INTERRUPT;
+out:
+	return EFI_EXIT(ret);
+}
+
+/**
+ * efi_net_receive() - receive a packet from a network interface
+ *
+ * This function implements the Receive service of the Simple Network Protocol.
+ * See the UEFI spec for details.
+ *
+ * @this:		the instance of the Simple Network Protocol
+ * @header_size:	size of the media header
+ * @buffer_size:	size of the buffer to receive the packet
+ * @buffer:		buffer to receive the packet
+ * @src_addr:		source MAC address
+ * @dest_addr:		destination MAC address
+ * @protocol:		protocol
+ * Return:		status code
+ */
+static efi_status_t EFIAPI efi_net_receive
+		(struct efi_simple_network_protocol *this, size_t *header_size,
+		 size_t *buffer_size, void *buffer,
+		 struct efi_mac_address *src_addr,
+		 struct efi_mac_address *dest_addr, u16 *protocol)
+{
+	efi_status_t ret = EFI_SUCCESS;
+	struct ethernet_hdr *eth_hdr;
+	size_t hdr_size = sizeof(struct ethernet_hdr);
+	u16 protlen;
+	struct efi_simple_network_extended_protocol *nt;
+
+	EFI_ENTRY("%p, %p, %p, %p, %p, %p, %p", this, header_size,
+		  buffer_size, buffer, src_addr, dest_addr, protocol);
+
+	/* Execute events */
+	efi_timer_check();
+
+	/* Check parameters */
+	if (!this || !buffer || !buffer_size) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	nt = (struct efi_simple_network_extended_protocol *)this;
+
+	switch (this->mode->state) {
+	case EFI_NETWORK_STOPPED:
+		ret = EFI_NOT_STARTED;
+		goto out;
+	case EFI_NETWORK_STARTED:
+		ret = EFI_DEVICE_ERROR;
+		goto out;
+	default:
+		break;
+	}
+
+	if (!nt->rx_packet_num) {
+		ret = EFI_NOT_READY;
+		goto out;
+	}
+	/* Fill export parameters */
+	eth_hdr = (struct ethernet_hdr *)nt->receive_buffer[nt->rx_packet_idx];
+	protlen = ntohs(eth_hdr->et_protlen);
+	if (protlen == 0x8100) {
+		hdr_size += 4;
+		protlen = ntohs(*(u16 *)&nt->receive_buffer[nt->rx_packet_idx][hdr_size - 2]);
+	}
+	if (header_size)
+		*header_size = hdr_size;
+	if (dest_addr)
+		memcpy(dest_addr, eth_hdr->et_dest, ARP_HLEN);
+	if (src_addr)
+		memcpy(src_addr, eth_hdr->et_src, ARP_HLEN);
+	if (protocol)
+		*protocol = protlen;
+	if (*buffer_size < nt->receive_lengths[nt->rx_packet_idx]) {
+		/* Packet doesn't fit, try again with bigger buffer */
+		*buffer_size = nt->receive_lengths[nt->rx_packet_idx];
+		ret = EFI_BUFFER_TOO_SMALL;
+		goto out;
+	}
+	/* Copy packet */
+	memcpy(buffer, nt->receive_buffer[nt->rx_packet_idx],
+	       nt->receive_lengths[nt->rx_packet_idx]);
+	*buffer_size = nt->receive_lengths[nt->rx_packet_idx];
+	nt->rx_packet_idx = (nt->rx_packet_idx + 1) % ETH_PACKETS_BATCH_RECV;
+	nt->rx_packet_num--;
+	if (nt->rx_packet_num)
+		nt->wait_for_packet->is_signaled = true;
+	else
+		this->int_status &= ~EFI_SIMPLE_NETWORK_RECEIVE_INTERRUPT;
+out:
+	return EFI_EXIT(ret);
+}
+
+/**
+ * efi_net_push() - callback for received network packet
+ *
+ * This function is called when a network packet is received by eth_rx().
+ *
+ * @pkt:	network packet
+ * @len:	length
+ */
+static void efi_net_push(void *pkt, int len)
+{
+	int rx_packet_next;
+	struct efi_simple_network_extended_protocol *nt;
+
+	nt = current_network;
+	if (!nt)
+		return;
+
+	/* Check that we at least received an Ethernet header */
+	if (len < sizeof(struct ethernet_hdr))
+		return;
+
+	/* Check that the buffer won't overflow */
+	if (len > PKTSIZE_ALIGN)
+		return;
+
+	/* Can't store more than pre-alloced buffer */
+	if (nt->rx_packet_num >= ETH_PACKETS_BATCH_RECV)
+		return;
+
+	rx_packet_next = (nt->rx_packet_idx + nt->rx_packet_num) %
+	    ETH_PACKETS_BATCH_RECV;
+	memcpy(nt->receive_buffer[rx_packet_next], pkt, len);
+	nt->receive_lengths[rx_packet_next] = len;
+
+	nt->rx_packet_num++;
+}
+
+/**
+ * efi_network_timer_notify() - check if a new network packet has been received
+ *
+ * This notification function is called in every timer cycle.
+ *
+ * @event:	the event for which this notification function is registered
+ * @context:	event context - not used in this function
+ */
+static void EFIAPI efi_network_timer_notify(struct efi_event *event,
+					    void *context)
+{
+	struct efi_simple_network_extended_protocol *nt;
+
+	EFI_ENTRY("%p, %p", event, context);
+
+	nt = (struct efi_simple_network_extended_protocol *)context;
+
+	/*
+	 * Some network drivers do not support calling eth_rx() before
+	 * initialization.
+	 */
+	if (!nt || nt->net.mode->state != EFI_NETWORK_INITIALIZED)
+		goto out;
+
+	current_network = nt;
+
+	if (!nt->rx_packet_num) {
+		eth_set_dev(nt->dev);
+		env_set("ethact", eth_get_name());
+		push_packet = efi_net_push;
+		eth_rx();
+		push_packet = NULL;
+		if (nt->rx_packet_num) {
+			nt->net.int_status |=
+				EFI_SIMPLE_NETWORK_RECEIVE_INTERRUPT;
+			nt->wait_for_packet->is_signaled = true;
+		}
+	}
+out:
+	EFI_EXIT(EFI_SUCCESS);
+}
+
+/**
+ * efi_simple_network_install() - install the EFI_SIMPLE_NETWORK_PROTOCOL
+ *
+ * @handle:	handle to install the protocol
+ * @dev:	net udevice
+ */
+efi_status_t efi_simple_network_install(const efi_handle_t handle, struct udevice *dev)
+{
+	efi_status_t r;
+	struct efi_simple_network_extended_protocol *simple_network;
+	void *transmit_buffer = NULL;
+	uchar **receive_buffer = NULL;
+	size_t *receive_lengths;
+	int i;
+
+	if (!dev) {
+		/* No network device active, don't expose any */
+		return EFI_SUCCESS;
+	}
+
+	/* We only expose the "active" network device, so one is enough */
+	simple_network = calloc(1, sizeof(*simple_network));
+	if (!simple_network)
+		goto out_of_resources;
+
+	simple_network->dev = dev;
+
+	/* Allocate an aligned transmit buffer */
+	transmit_buffer = calloc(1, PKTSIZE_ALIGN + PKTALIGN);
+	if (!transmit_buffer)
+		goto out_of_resources;
+	transmit_buffer = (void *)ALIGN((uintptr_t)transmit_buffer, PKTALIGN);
+	simple_network->transmit_buffer = transmit_buffer;
+
+	/* Allocate a number of receive buffers */
+	receive_buffer = calloc(ETH_PACKETS_BATCH_RECV,
+				sizeof(*receive_buffer));
+	if (!receive_buffer)
+		goto out_of_resources;
+	for (i = 0; i < ETH_PACKETS_BATCH_RECV; i++) {
+		receive_buffer[i] = malloc(PKTSIZE_ALIGN);
+		if (!receive_buffer[i])
+			goto out_of_resources;
+	}
+	simple_network->receive_buffer = receive_buffer;
+
+	receive_lengths = calloc(ETH_PACKETS_BATCH_RECV,
+				 sizeof(*receive_lengths));
+	if (!receive_lengths)
+		goto out_of_resources;
+	simple_network->receive_lengths = receive_lengths;
+
+	simple_network->net.revision = EFI_SIMPLE_NETWORK_PROTOCOL_REVISION;
+	simple_network->net.start = efi_net_start;
+	simple_network->net.stop = efi_net_stop;
+	simple_network->net.initialize = efi_net_initialize;
+	simple_network->net.reset = efi_net_reset;
+	simple_network->net.shutdown = efi_net_shutdown;
+	simple_network->net.receive_filters = efi_net_receive_filters;
+	simple_network->net.station_address = efi_net_station_address;
+	simple_network->net.statistics = efi_net_statistics;
+	simple_network->net.mcastiptomac = efi_net_mcastiptomac;
+	simple_network->net.nvdata = efi_net_nvdata;
+	simple_network->net.get_status = efi_net_get_status;
+	simple_network->net.transmit = efi_net_transmit;
+	simple_network->net.receive = efi_net_receive;
+	simple_network->net.mode = &simple_network->net_mode;
+	simple_network->net_mode.state = EFI_NETWORK_STOPPED;
+	if (dev_get_plat(dev))
+		memcpy(simple_network->net_mode.current_address.mac_addr,
+		       ((struct eth_pdata *)dev_get_plat(dev))->enetaddr, 6);
+	simple_network->net_mode.hwaddr_size = ARP_HLEN;
+	simple_network->net_mode.media_header_size = ETHER_HDR_SIZE;
+	simple_network->net_mode.max_packet_size = PKTSIZE;
+	simple_network->net_mode.if_type = ARP_ETHER;
+
+	/*
+	 * Create WaitForPacket event.
+	 */
+	r = efi_create_event(EVT_NOTIFY_WAIT, TPL_CALLBACK,
+			     efi_network_timer_notify, NULL, NULL,
+			     &simple_network->wait_for_packet);
+	if (r != EFI_SUCCESS) {
+		printf("ERROR: Failed to register network event\n");
+		return r;
+	}
+	simple_network->net.wait_for_packet = simple_network->wait_for_packet;
+	/*
+	 * Create a timer event.
+	 *
+	 * The notification function is used to check if a new network packet
+	 * has been received.
+	 *
+	 * iPXE is running at TPL_CALLBACK most of the time. Use a higher TPL.
+	 */
+	r = efi_create_event(EVT_TIMER | EVT_NOTIFY_SIGNAL, TPL_NOTIFY,
+			     efi_network_timer_notify, simple_network, NULL,
+			     &simple_network->network_timer_event);
+	if (r != EFI_SUCCESS) {
+		printf("ERROR: Failed to register network event\n");
+		return r;
+	}
+	/* Network is time critical, create event in every timer cycle */
+	r = efi_set_timer(simple_network->network_timer_event, EFI_TIMER_PERIODIC, 0);
+	if (r != EFI_SUCCESS) {
+		printf("ERROR: Failed to set network timer\n");
+		return r;
+	}
+
+	r = efi_add_protocol(handle, &efi_net_guid,
+			     &simple_network->net);
+	if (r != EFI_SUCCESS)
+		return r;
+
+	return EFI_SUCCESS;
+out_of_resources:
+	free(simple_network);
+	free(transmit_buffer);
+	if (receive_buffer)
+		for (i = 0; i < ETH_PACKETS_BATCH_RECV; i++)
+			free(receive_buffer[i]);
+	free(receive_buffer);
+	free(receive_lengths);
+	printf("ERROR: Out of memory\n");
+	return EFI_OUT_OF_RESOURCES;
+}
diff --git a/lib/efi_selftest/efi_selftest_snp.c b/lib/efi_selftest/efi_selftest_snp.c
index b00c76c2f17..82ed3587d6f 100644
--- a/lib/efi_selftest/efi_selftest_snp.c
+++ b/lib/efi_selftest/efi_selftest_snp.c
@@ -17,6 +17,8 @@
 #include <efi_selftest.h>
 #include <net.h>
 
+static const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
+
 /*
  * MAC address for broadcasts
  */
@@ -65,7 +67,7 @@ struct dhcp {
 } __packed;
 
 static struct efi_boot_services *boottime;
-static struct efi_simple_network *net;
+static struct efi_simple_network_protocol *net;
 static struct efi_event *timer;
 /* IP packet ID */
 static unsigned int net_ip_id;
-- 
2.48.1

