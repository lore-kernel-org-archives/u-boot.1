Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14C6C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 12:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 481498198F;
	Mon, 10 Mar 2025 13:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kcxiJgW5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4C5B818C7; Mon, 10 Mar 2025 13:06:22 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2CB28003E
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 13:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223378e2b0dso57197235ad.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 05:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741608377; x=1742213177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BOGrQd3UtWQi6aJnXVBuq64s5B6E2Wh3Y/VQjfLZ/RM=;
 b=kcxiJgW5U/5cNU9cSeM06ArQTLirJYCOuU3EIvE5r/r5xFDFT0twVVpwGFY7G0U/XI
 EAto2IADlXm4cY01yorZKNbKT7IGAELolu2WXZ15n5cmFc2K0Y8U4ltHELWH3QZsf5Md
 VQferT6e9Pcc6GEb92OUejJCDZ7oKCp52THrar9mgvupXGfaqxJWl9sG+aoyxnfscMvu
 vuFYwAuMvbWSCHvYhihtVfJskvsV92klu+Epi/GbKeOV7pY4KCJTlCCdxiTD5gD6QsvR
 ElqokJ1Qu/S4sF6nUknrg/4ner7ZhvtNHDGg7WKmYGsd5oqBPiHcsnmjORyAmzabCH6X
 aQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741608377; x=1742213177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BOGrQd3UtWQi6aJnXVBuq64s5B6E2Wh3Y/VQjfLZ/RM=;
 b=PzLLXBgTxbr5SuvRhqC7v+o8l8KjT4kE27IkwRe7tD2O+j41OoZVDyWi84iUlJo6Mv
 YCbiLUci1213UguUrqfyahUZf1jg2EPCb2BJ0f4MvgdrbJqXxaxdLgKTtj94FCl05ho3
 vRJUJchnxMNWJh9mml27LQQ8s7BI3wjYGhgVh4HSX2XNZQpR5ut2J6N4hCpLJnYKewBx
 LWUjJJyksdUaIkhhpKX/bOudBgAsuV56xt6v0QZznBqRNvG1Bstn7KFUMiXjCseZoKvo
 A68Reh53oEFfsSPevMBa6HSfB0WBESbJcBaOvwlxAnsmJvSRq3Z0S8OXd/i0O9Ha11vf
 GNDg==
X-Gm-Message-State: AOJu0Ywlb+W5lQESmmelNvxDNJ/+pFXu9ZQSDyfQF6NlCmwR3eW9ITUs
 RGX3Gxbku6ZIuuTl7hqhV40NMjrSbv/THolt9QVoRI4dZLSPQ8Y2TJ3xk8bQo4g=
X-Gm-Gg: ASbGncuVQHermaNDMWSoRNYMbsYBghmJiSUogHQ0yXkYRgqhqIerav0OyRQSewl+DNO
 qXWYw4LJJ4WK/W/0W2RH19snt/KKUMFYU4rv9k93Ceb7pnYxzLvn/F3CvTraxCMV9YKvStXNDPA
 1ReuC0Io+1WYiDCMGcSNbsdsPS2rTlkIUDct9dVUzGu75IdSKdljvBBVTtXS9zUb3mdrYZeoh6M
 KB95B/vDQd05PDinEKHyXFmSPWBxZkgsY4ogRWD4gbr+QEyLyKNMUtoZRJksRhf7V3baD4a30nU
 NPlGEnoZwKf0VY3HD6cAjoY6XLzuRMMkkQ9OWt6yRHBIMJGKi8MUjmI=
X-Google-Smtp-Source: AGHT+IHTWfELI8Tc35/rG1JP2pP33e7drIVd9HsEU/pMXwb7A0pXnl+MnEOSEKiLqaLv44PWUR8Gxw==
X-Received: by 2002:a05:6a00:b4e:b0:736:57cb:f2b6 with SMTP id
 d2e1a72fcca58-736aaa1acf0mr19393946b3a.12.1741608377252; 
 Mon, 10 Mar 2025 05:06:17 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a8b61f76sm6968899b3a.103.2025.03.10.05.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 05:06:16 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v3 8/8] efi_loader: efi_net: Add support for multiple
 efi_net_obj
Date: Mon, 10 Mar 2025 09:06:07 -0300
Message-ID: <20250310120607.186999-8-adriano.cordova@canonical.com>
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

Add support for multiple efi_net_obj structs in efi_net.c. This comes
in preparation for an EFI network driver supporting multiple network
interfaces. For now the EFI network stack still registers a single ethernet
udevice as an EFI network device even if multiple are present, namely
the one that was the current device at the moment of EFI initialization.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---

changes in v3:
	- initialize receive_buffer and transnmit_buffer to NULL
	  in efi_net_register.

changes in v2:
	- fix Sphinx documentation in efi_net_obj
	- fix wait_for_package error

 include/efi_loader.h      |   5 +-
 lib/efi_loader/efi_http.c |   4 +-
 lib/efi_loader/efi_net.c  | 264 +++++++++++++++++++++++++++-----------
 3 files changed, 199 insertions(+), 74 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index d387e583f20..995ae3357ec 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -140,8 +140,11 @@ void efi_net_set_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
 		      struct efi_ipv4_address *gw,
 			  struct udevice *dev);
+#if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
 efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buffer,
-				u32 *status_code, ulong *file_size, char *headers_buffer);
+				u32 *status_code, ulong *file_size, char *headers_buffer,
+				struct efi_service_binding_protocol *parent);
+#endif
 #define MAX_HTTP_HEADERS_SIZE SZ_64K
 #define MAX_HTTP_HEADERS 100
 #define MAX_HTTP_HEADER_NAME 128
diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
index 60309ee3112..189317fe2d2 100644
--- a/lib/efi_loader/efi_http.c
+++ b/lib/efi_loader/efi_http.c
@@ -36,6 +36,7 @@ static const efi_guid_t efi_http_guid = EFI_HTTP_PROTOCOL_GUID;
 struct efi_http_instance {
 	struct efi_http_protocol http;
 	efi_handle_t handle;
+	struct efi_service_binding_protocol *parent;
 	bool configured;
 	void *http_load_addr;
 	ulong file_size;
@@ -243,7 +244,7 @@ static efi_status_t EFIAPI efi_http_request(struct efi_http_protocol *this,
 
 	ret = efi_net_do_request(url_8, current_method, &http_instance->http_load_addr,
 				 &http_instance->status_code, &http_instance->file_size,
-				 http_instance->headers_buffer);
+				 http_instance->headers_buffer, http_instance->parent);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
@@ -408,6 +409,7 @@ static efi_status_t EFIAPI efi_http_service_binding_create_child(
 		goto failure_to_add_protocol;
 	}
 
+	new_instance->parent = this;
 	efi_add_handle(new_instance->handle);
 	*child_handle = new_instance->handle;
 
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 2fac39ae513..44ba4e93f4f 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -24,19 +24,13 @@
 #include <vsprintf.h>
 #include <net.h>
 
+#define MAX_EFI_NET_OBJS 10
 #define MAX_NUM_DHCP_ENTRIES 10
 #define MAX_NUM_DP_ENTRIES 10
 
 const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
 static const efi_guid_t efi_pxe_base_code_protocol_guid =
 					EFI_PXE_BASE_CODE_PROTOCOL_GUID;
-static void *new_tx_packet;
-static void *transmit_buffer;
-static uchar **receive_buffer;
-static size_t *receive_lengths;
-static int rx_packet_idx;
-static int rx_packet_num;
-static struct efi_net_obj *netobj;
 
 struct dp_entry {
 	struct efi_device_path *net_dp;
@@ -70,16 +64,6 @@ struct dhcp_entry {
 static struct dhcp_entry dhcp_cache[MAX_NUM_DHCP_ENTRIES];
 static int next_dhcp_entry;
 
-/*
- * The notification function of this event is called in every timer cycle
- * to check if a new network packet has been received.
- */
-static struct efi_event *network_timer_event;
-/*
- * This event is signaled when a packet has been received.
- */
-static struct efi_event *wait_for_packet;
-
 /**
  * struct efi_net_obj - EFI object representing a network interface
  *
@@ -91,6 +75,15 @@ static struct efi_event *wait_for_packet;
  * @pxe_mode:			status of the PXE base code protocol
  * @ip4_config2:		IP4 Config2 protocol interface
  * @http_service_binding:	Http service binding protocol interface
+ * @new_tx_packet:		new transmit packet
+ * @transmit_buffer:	transmit buffer
+ * @receive_buffer:		array of receive buffers
+ * @receive_lengths:	array of lengths for received packets
+ * @rx_packet_idx:		index of the current receive packet
+ * @rx_packet_num:		number of received packets
+ * @wait_for_packet:	signaled when a packet has been received
+ * @network_timer_event:	event to check for new network packets.
+ * @efi_seq_num:		sequence number of the EFI net object.
  */
 struct efi_net_obj {
 	struct efi_object header;
@@ -105,13 +98,25 @@ struct efi_net_obj {
 #if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
 	struct efi_service_binding_protocol http_service_binding;
 #endif
+	void *new_tx_packet;
+	void *transmit_buffer;
+	uchar **receive_buffer;
+	size_t *receive_lengths;
+	int rx_packet_idx;
+	int rx_packet_num;
+	struct efi_event *wait_for_packet;
+	struct efi_event *network_timer_event;
+	int efi_seq_num;
 };
 
-/*
+static int curr_efi_net_obj;
+static struct efi_net_obj *net_objs[MAX_EFI_NET_OBJS];
+
+/**
  * efi_netobj_is_active() - checks if a netobj is active in the efi subsystem
  *
- * @netobj:    pointer to efi_net_obj
- * Return:     true if active
+ * @netobj:	pointer to efi_net_obj
+ * Return:	true if active
  */
 static bool efi_netobj_is_active(struct efi_net_obj *netobj)
 {
@@ -121,6 +126,25 @@ static bool efi_netobj_is_active(struct efi_net_obj *netobj)
 	return true;
 }
 
+/*
+ * efi_netobj_from_snp() - get efi_net_obj from simple network protocol
+ *
+ *
+ * @snp:	pointer to the simple network protocol
+ * Return:	pointer to efi_net_obj, NULL on error
+ */
+static struct efi_net_obj *efi_netobj_from_snp(struct efi_simple_network *snp)
+{
+	int i;
+
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i] && &net_objs[i]->net == snp) {
+			// Do not register duplicate devices
+			return net_objs[i];
+		}
+	}
+	return NULL;
+}
 
 /*
  * efi_net_start() - start the network interface
@@ -135,6 +159,7 @@ static bool efi_netobj_is_active(struct efi_net_obj *netobj)
 static efi_status_t EFIAPI efi_net_start(struct efi_simple_network *this)
 {
 	efi_status_t ret = EFI_SUCCESS;
+	struct efi_net_obj *nt;
 
 	EFI_ENTRY("%p", this);
 	/* Check parameters */
@@ -143,11 +168,13 @@ static efi_status_t EFIAPI efi_net_start(struct efi_simple_network *this)
 		goto out;
 	}
 
+	nt = efi_netobj_from_snp(this);
+
 	if (this->mode->state != EFI_NETWORK_STOPPED) {
 		ret = EFI_ALREADY_STARTED;
 	} else {
 		this->int_status = 0;
-		wait_for_packet->is_signaled = false;
+		nt->wait_for_packet->is_signaled = false;
 		this->mode->state = EFI_NETWORK_STARTED;
 	}
 out:
@@ -167,6 +194,7 @@ out:
 static efi_status_t EFIAPI efi_net_stop(struct efi_simple_network *this)
 {
 	efi_status_t ret = EFI_SUCCESS;
+	struct efi_net_obj *nt;
 
 	EFI_ENTRY("%p", this);
 
@@ -176,15 +204,17 @@ static efi_status_t EFIAPI efi_net_stop(struct efi_simple_network *this)
 		goto out;
 	}
 
+	nt = efi_netobj_from_snp(this);
+
 	if (this->mode->state == EFI_NETWORK_STOPPED) {
 		ret = EFI_NOT_STARTED;
 	} else {
 		/* Disable hardware and put it into the reset state */
-		eth_set_dev(netobj->dev);
+		eth_set_dev(nt->dev);
 		env_set("ethact", eth_get_name());
 		eth_halt();
 		/* Clear cache of packets */
-		rx_packet_num = 0;
+		nt->rx_packet_num = 0;
 		this->mode->state = EFI_NETWORK_STOPPED;
 	}
 out:
@@ -208,6 +238,7 @@ static efi_status_t EFIAPI efi_net_initialize(struct efi_simple_network *this,
 {
 	int ret;
 	efi_status_t r = EFI_SUCCESS;
+	struct efi_net_obj *nt;
 
 	EFI_ENTRY("%p, %lx, %lx", this, extra_rx, extra_tx);
 
@@ -216,6 +247,7 @@ static efi_status_t EFIAPI efi_net_initialize(struct efi_simple_network *this,
 		r = EFI_INVALID_PARAMETER;
 		goto out;
 	}
+	nt = efi_netobj_from_snp(this);
 
 	switch (this->mode->state) {
 	case EFI_NETWORK_INITIALIZED:
@@ -229,12 +261,12 @@ static efi_status_t EFIAPI efi_net_initialize(struct efi_simple_network *this,
 	/* Setup packet buffers */
 	net_init();
 	/* Clear cache of packets */
-	rx_packet_num = 0;
+	nt->rx_packet_num = 0;
 	/* Set the net device corresponding to the efi net object */
-	eth_set_dev(netobj->dev);
+	eth_set_dev(nt->dev);
 	env_set("ethact", eth_get_name());
 	/* Get hardware ready for send and receive operations */
-	ret = eth_start_udev(netobj->dev);
+	ret = eth_start_udev(nt->dev);
 	if (ret < 0) {
 		eth_halt();
 		this->mode->state = EFI_NETWORK_STOPPED;
@@ -242,7 +274,7 @@ static efi_status_t EFIAPI efi_net_initialize(struct efi_simple_network *this,
 		goto out;
 	} else {
 		this->int_status = 0;
-		wait_for_packet->is_signaled = false;
+		nt->wait_for_packet->is_signaled = false;
 		this->mode->state = EFI_NETWORK_INITIALIZED;
 	}
 out:
@@ -303,6 +335,7 @@ out:
 static efi_status_t EFIAPI efi_net_shutdown(struct efi_simple_network *this)
 {
 	efi_status_t ret = EFI_SUCCESS;
+	struct efi_net_obj *nt;
 
 	EFI_ENTRY("%p", this);
 
@@ -311,6 +344,7 @@ static efi_status_t EFIAPI efi_net_shutdown(struct efi_simple_network *this)
 		ret = EFI_INVALID_PARAMETER;
 		goto out;
 	}
+	nt = efi_netobj_from_snp(this);
 
 	switch (this->mode->state) {
 	case EFI_NETWORK_INITIALIZED:
@@ -323,12 +357,12 @@ static efi_status_t EFIAPI efi_net_shutdown(struct efi_simple_network *this)
 		goto out;
 	}
 
-	eth_set_dev(netobj->dev);
+	eth_set_dev(nt->dev);
 	env_set("ethact", eth_get_name());
 	eth_halt();
 
 	this->int_status = 0;
-	wait_for_packet->is_signaled = false;
+	nt->wait_for_packet->is_signaled = false;
 	this->mode->state = EFI_NETWORK_STARTED;
 
 out:
@@ -504,6 +538,7 @@ static efi_status_t EFIAPI efi_net_get_status(struct efi_simple_network *this,
 					      u32 *int_status, void **txbuf)
 {
 	efi_status_t ret = EFI_SUCCESS;
+	struct efi_net_obj *nt;
 
 	EFI_ENTRY("%p, %p, %p", this, int_status, txbuf);
 
@@ -515,6 +550,8 @@ static efi_status_t EFIAPI efi_net_get_status(struct efi_simple_network *this,
 		goto out;
 	}
 
+	nt = efi_netobj_from_snp(this);
+
 	switch (this->mode->state) {
 	case EFI_NETWORK_STOPPED:
 		ret = EFI_NOT_STARTED;
@@ -531,9 +568,9 @@ static efi_status_t EFIAPI efi_net_get_status(struct efi_simple_network *this,
 		this->int_status = 0;
 	}
 	if (txbuf)
-		*txbuf = new_tx_packet;
+		*txbuf = nt->new_tx_packet;
 
-	new_tx_packet = NULL;
+	nt->new_tx_packet = NULL;
 out:
 	return EFI_EXIT(ret);
 }
@@ -560,6 +597,7 @@ static efi_status_t EFIAPI efi_net_transmit
 		 struct efi_mac_address *dest_addr, u16 *protocol)
 {
 	efi_status_t ret = EFI_SUCCESS;
+	struct efi_net_obj *nt;
 
 	EFI_ENTRY("%p, %lu, %lu, %p, %p, %p, %p", this,
 		  (unsigned long)header_size, (unsigned long)buffer_size,
@@ -573,6 +611,8 @@ static efi_status_t EFIAPI efi_net_transmit
 		goto out;
 	}
 
+	nt = efi_netobj_from_snp(this);
+
 	/* We do not support jumbo packets */
 	if (buffer_size > PKTSIZE_ALIGN) {
 		ret = EFI_INVALID_PARAMETER;
@@ -617,14 +657,14 @@ static efi_status_t EFIAPI efi_net_transmit
 		break;
 	}
 
-	eth_set_dev(netobj->dev);
+	eth_set_dev(nt->dev);
 	env_set("ethact", eth_get_name());
 
 	/* Ethernet packets always fit, just bounce */
-	memcpy(transmit_buffer, buffer, buffer_size);
-	net_send_packet(transmit_buffer, buffer_size);
+	memcpy(nt->transmit_buffer, buffer, buffer_size);
+	net_send_packet(nt->transmit_buffer, buffer_size);
 
-	new_tx_packet = buffer;
+	nt->new_tx_packet = buffer;
 	this->int_status |= EFI_SIMPLE_NETWORK_TRANSMIT_INTERRUPT;
 out:
 	return EFI_EXIT(ret);
@@ -655,6 +695,7 @@ static efi_status_t EFIAPI efi_net_receive
 	struct ethernet_hdr *eth_hdr;
 	size_t hdr_size = sizeof(struct ethernet_hdr);
 	u16 protlen;
+	struct efi_net_obj *nt;
 
 	EFI_ENTRY("%p, %p, %p, %p, %p, %p, %p", this, header_size,
 		  buffer_size, buffer, src_addr, dest_addr, protocol);
@@ -668,6 +709,8 @@ static efi_status_t EFIAPI efi_net_receive
 		goto out;
 	}
 
+	nt = efi_netobj_from_snp(this);
+
 	switch (this->mode->state) {
 	case EFI_NETWORK_STOPPED:
 		ret = EFI_NOT_STARTED;
@@ -679,16 +722,16 @@ static efi_status_t EFIAPI efi_net_receive
 		break;
 	}
 
-	if (!rx_packet_num) {
+	if (!nt->rx_packet_num) {
 		ret = EFI_NOT_READY;
 		goto out;
 	}
 	/* Fill export parameters */
-	eth_hdr = (struct ethernet_hdr *)receive_buffer[rx_packet_idx];
+	eth_hdr = (struct ethernet_hdr *)nt->receive_buffer[nt->rx_packet_idx];
 	protlen = ntohs(eth_hdr->et_protlen);
 	if (protlen == 0x8100) {
 		hdr_size += 4;
-		protlen = ntohs(*(u16 *)&receive_buffer[rx_packet_idx][hdr_size - 2]);
+		protlen = ntohs(*(u16 *)&nt->receive_buffer[nt->rx_packet_idx][hdr_size - 2]);
 	}
 	if (header_size)
 		*header_size = hdr_size;
@@ -698,20 +741,20 @@ static efi_status_t EFIAPI efi_net_receive
 		memcpy(src_addr, eth_hdr->et_src, ARP_HLEN);
 	if (protocol)
 		*protocol = protlen;
-	if (*buffer_size < receive_lengths[rx_packet_idx]) {
+	if (*buffer_size < nt->receive_lengths[nt->rx_packet_idx]) {
 		/* Packet doesn't fit, try again with bigger buffer */
-		*buffer_size = receive_lengths[rx_packet_idx];
+		*buffer_size = nt->receive_lengths[nt->rx_packet_idx];
 		ret = EFI_BUFFER_TOO_SMALL;
 		goto out;
 	}
 	/* Copy packet */
-	memcpy(buffer, receive_buffer[rx_packet_idx],
-	       receive_lengths[rx_packet_idx]);
-	*buffer_size = receive_lengths[rx_packet_idx];
-	rx_packet_idx = (rx_packet_idx + 1) % ETH_PACKETS_BATCH_RECV;
-	rx_packet_num--;
-	if (rx_packet_num)
-		wait_for_packet->is_signaled = true;
+	memcpy(buffer, nt->receive_buffer[nt->rx_packet_idx],
+	       nt->receive_lengths[nt->rx_packet_idx]);
+	*buffer_size = nt->receive_lengths[nt->rx_packet_idx];
+	nt->rx_packet_idx = (nt->rx_packet_idx + 1) % ETH_PACKETS_BATCH_RECV;
+	nt->rx_packet_num--;
+	if (nt->rx_packet_num)
+		nt->wait_for_packet->is_signaled = true;
 	else
 		this->int_status &= ~EFI_SIMPLE_NETWORK_RECEIVE_INTERRUPT;
 out:
@@ -730,6 +773,7 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
 {
 	struct efi_pxe_packet **dhcp_ack;
 	struct udevice *dev;
+	int i;
 
 	dhcp_ack = &dhcp_cache[next_dhcp_entry].dhcp_ack;
 
@@ -750,6 +794,12 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
 	dhcp_cache[next_dhcp_entry].dev = dev;
 	next_dhcp_entry++;
 	next_dhcp_entry %= MAX_NUM_DHCP_ENTRIES;
+
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i] && net_objs[i]->dev == dev) {
+			net_objs[i]->pxe_mode.dhcp_ack = **dhcp_ack;
+		}
+	}
 }
 
 /**
@@ -763,6 +813,11 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
 static void efi_net_push(void *pkt, int len)
 {
 	int rx_packet_next;
+	struct efi_net_obj *nt;
+
+	nt = net_objs[curr_efi_net_obj];
+	if (!nt)
+		return;
 
 	/* Check that we at least received an Ethernet header */
 	if (len < sizeof(struct ethernet_hdr))
@@ -773,15 +828,15 @@ static void efi_net_push(void *pkt, int len)
 		return;
 
 	/* Can't store more than pre-alloced buffer */
-	if (rx_packet_num >= ETH_PACKETS_BATCH_RECV)
+	if (nt->rx_packet_num >= ETH_PACKETS_BATCH_RECV)
 		return;
 
-	rx_packet_next = (rx_packet_idx + rx_packet_num) %
+	rx_packet_next = (nt->rx_packet_idx + nt->rx_packet_num) %
 	    ETH_PACKETS_BATCH_RECV;
-	memcpy(receive_buffer[rx_packet_next], pkt, len);
-	receive_lengths[rx_packet_next] = len;
+	memcpy(nt->receive_buffer[rx_packet_next], pkt, len);
+	nt->receive_lengths[rx_packet_next] = len;
 
-	rx_packet_num++;
+	nt->rx_packet_num++;
 }
 
 /**
@@ -796,6 +851,7 @@ static void EFIAPI efi_network_timer_notify(struct efi_event *event,
 					    void *context)
 {
 	struct efi_simple_network *this = (struct efi_simple_network *)context;
+	struct efi_net_obj *nt;
 
 	EFI_ENTRY("%p, %p", event, context);
 
@@ -806,16 +862,19 @@ static void EFIAPI efi_network_timer_notify(struct efi_event *event,
 	if (!this || this->mode->state != EFI_NETWORK_INITIALIZED)
 		goto out;
 
-	if (!rx_packet_num) {
-		eth_set_dev(netobj->dev);
+	nt = efi_netobj_from_snp(this);
+	curr_efi_net_obj = nt->efi_seq_num;
+
+	if (!nt->rx_packet_num) {
+		eth_set_dev(nt->dev);
 		env_set("ethact", eth_get_name());
 		push_packet = efi_net_push;
 		eth_rx();
 		push_packet = NULL;
-		if (rx_packet_num) {
+		if (nt->rx_packet_num) {
 			this->int_status |=
 				EFI_SIMPLE_NETWORK_RECEIVE_INTERRUPT;
-			wait_for_packet->is_signaled = true;
+			nt->wait_for_packet->is_signaled = true;
 		}
 	}
 out:
@@ -1011,9 +1070,19 @@ static struct efi_device_path *efi_netobj_get_dp(struct efi_net_obj *netobj)
 efi_status_t efi_net_do_start(struct udevice *dev)
 {
 	efi_status_t r = EFI_SUCCESS;
+	struct efi_net_obj *netobj;
 	struct efi_device_path *net_dp;
+	int i;
 
-	if (dev != netobj->dev )
+	netobj = NULL;
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i] && net_objs[i]->dev == dev) {
+			netobj = net_objs[i];
+			break;
+		}
+	}
+
+	if (!efi_netobj_is_active(netobj))
 		return r;
 
 	efi_net_dp_from_dev(&net_dp, netobj->dev, true);
@@ -1056,6 +1125,11 @@ set_addr:
 efi_status_t efi_net_register(struct udevice *dev)
 {
 	efi_status_t r;
+	int seq_num;
+	struct efi_net_obj *netobj;
+	void *transmit_buffer;
+	uchar **receive_buffer = NULL;
+	size_t *receive_lengths = NULL;
 	int i, j;
 
 	if (!dev) {
@@ -1063,6 +1137,23 @@ efi_status_t efi_net_register(struct udevice *dev)
 		return EFI_SUCCESS;
 	}
 
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i] && net_objs[i]->dev == dev) {
+			// Do not register duplicate devices
+			return EFI_SUCCESS;
+		}
+	}
+
+	seq_num = -1;
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (!net_objs[i]) {
+			seq_num = i;
+			break;
+		}
+	}
+	if (seq_num < 0)
+		return EFI_OUT_OF_RESOURCES;
+
 	/* We only expose the "active" network device, so one is enough */
 	netobj = calloc(1, sizeof(*netobj));
 	if (!netobj)
@@ -1075,6 +1166,7 @@ efi_status_t efi_net_register(struct udevice *dev)
 	if (!transmit_buffer)
 		goto out_of_resources;
 	transmit_buffer = (void *)ALIGN((uintptr_t)transmit_buffer, PKTALIGN);
+	netobj->transmit_buffer = transmit_buffer;
 
 	/* Allocate a number of receive buffers */
 	receive_buffer = calloc(ETH_PACKETS_BATCH_RECV,
@@ -1086,11 +1178,13 @@ efi_status_t efi_net_register(struct udevice *dev)
 		if (!receive_buffer[i])
 			goto out_of_resources;
 	}
+	netobj->receive_buffer = receive_buffer;
 
 	receive_lengths = calloc(ETH_PACKETS_BATCH_RECV,
 				 sizeof(*receive_lengths));
 	if (!receive_lengths)
 		goto out_of_resources;
+	netobj->receive_lengths = receive_lengths;
 
 	/* Hook net up to the device list */
 	efi_add_handle(&netobj->header);
@@ -1162,13 +1256,12 @@ efi_status_t efi_net_register(struct udevice *dev)
 	 */
 	r = efi_create_event(EVT_NOTIFY_WAIT, TPL_CALLBACK,
 			     efi_network_timer_notify, NULL, NULL,
-			     &wait_for_packet);
+			     &netobj->wait_for_packet);
 	if (r != EFI_SUCCESS) {
 		printf("ERROR: Failed to register network event\n");
 		return r;
 	}
-	netobj->net.wait_for_packet = wait_for_packet;
-
+	netobj->net.wait_for_packet = netobj->wait_for_packet;
 	/*
 	 * Create a timer event.
 	 *
@@ -1179,13 +1272,13 @@ efi_status_t efi_net_register(struct udevice *dev)
 	 */
 	r = efi_create_event(EVT_TIMER | EVT_NOTIFY_SIGNAL, TPL_NOTIFY,
 			     efi_network_timer_notify, &netobj->net, NULL,
-			     &network_timer_event);
+			     &netobj->network_timer_event);
 	if (r != EFI_SUCCESS) {
 		printf("ERROR: Failed to register network event\n");
 		return r;
 	}
 	/* Network is time critical, create event in every timer cycle */
-	r = efi_set_timer(network_timer_event, EFI_TIMER_PERIODIC, 0);
+	r = efi_set_timer(netobj->network_timer_event, EFI_TIMER_PERIODIC, 0);
 	if (r != EFI_SUCCESS) {
 		printf("ERROR: Failed to set network timer\n");
 		return r;
@@ -1202,6 +1295,8 @@ efi_status_t efi_net_register(struct udevice *dev)
 	if (r != EFI_SUCCESS)
 		goto failure_to_add_protocol;
 #endif
+	netobj->efi_seq_num = seq_num;
+	net_objs[seq_num] = netobj;
 	return EFI_SUCCESS;
 failure_to_add_protocol:
 	printf("ERROR: Failure to add protocol\n");
@@ -1233,8 +1328,10 @@ out_of_resources:
 efi_status_t efi_net_new_dp(const char *dev, const char *server, struct udevice *udev)
 {
 	efi_status_t ret;
+	struct efi_net_obj *netobj;
 	struct efi_device_path *old_net_dp, *new_net_dp;
 	struct efi_device_path **dp;
+	int i;
 
 	dp = &dp_cache[next_dp_entry].net_dp;
 
@@ -1256,7 +1353,14 @@ efi_status_t efi_net_new_dp(const char *dev, const char *server, struct udevice
 	// Free the old cache entry
 	efi_free_pool(old_net_dp);
 
-	if (!netobj || netobj->dev != udev)
+	netobj = NULL;
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i] && net_objs[i]->dev == udev) {
+			netobj = net_objs[i];
+			break;
+		}
+	}
+	if (!netobj)
 		return EFI_SUCCESS;
 
 	new_net_dp = efi_dp_dup(*dp);
@@ -1290,10 +1394,13 @@ void efi_net_dp_from_dev(struct efi_device_path **dp, struct udevice *udev, bool
 	if (cache_only)
 		goto cache;
 
-	if (netobj && netobj->dev == udev) {
-		*dp = efi_netobj_get_dp(netobj);
-		if (*dp)
-			return;
+	// If a netobj matches:
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i] && net_objs[i]->dev == udev) {
+			*dp = efi_netobj_get_dp(net_objs[i]);
+			if (*dp)
+				return;
+		}
 	}
 cache:
 	// Search in the cache
@@ -1527,27 +1634,40 @@ void efi_net_parse_headers(ulong *num_headers, struct http_header *headers)
  * @status_code:	HTTP status code
  * @file_size:		file size in bytes
  * @headers_buffer:	headers buffer
+ * @parent:		service binding protocol
  * Return:		status code
  */
 efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buffer,
-				u32 *status_code, ulong *file_size, char *headers_buffer)
+				u32 *status_code, ulong *file_size, char *headers_buffer,
+				struct efi_service_binding_protocol *parent)
 {
 	efi_status_t ret = EFI_SUCCESS;
 	int wget_ret;
 	static bool last_head;
+	struct udevice *dev;
+	int i;
 
-	if (!buffer || !file_size)
+	if (!buffer || !file_size || !parent)
 		return EFI_ABORTED;
 
 	efi_wget_info.method = (enum wget_http_method)method;
 	efi_wget_info.headers = headers_buffer;
 
+	// Set corresponding udevice
+	dev = NULL;
+	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
+		if (net_objs[i] && &net_objs[i]->http_service_binding == parent)
+			dev = net_objs[i]->dev;
+	}
+	if (!dev)
+		return EFI_ABORTED;
+
 	switch (method) {
 	case HTTP_METHOD_GET:
 		ret = efi_net_set_buffer(buffer, last_head ? (size_t)efi_wget_info.hdr_cont_len : 0);
 		if (ret != EFI_SUCCESS)
 			goto out;
-		eth_set_dev(netobj->dev);
+		eth_set_dev(dev);
 		env_set("ethact", eth_get_name());
 		wget_ret = wget_request((ulong)*buffer, url, &efi_wget_info);
 		if ((ulong)efi_wget_info.hdr_cont_len > efi_wget_info.buffer_size) {
@@ -1556,7 +1676,7 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buf
 			ret = efi_net_set_buffer(buffer, (size_t)efi_wget_info.hdr_cont_len);
 			if (ret != EFI_SUCCESS)
 				goto out;
-			eth_set_dev(netobj->dev);
+			eth_set_dev(dev);
 			env_set("ethact", eth_get_name());
 			if (wget_request((ulong)*buffer, url, &efi_wget_info)) {
 				efi_free_pool(*buffer);
@@ -1577,7 +1697,7 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buf
 		ret = efi_net_set_buffer(buffer, 0);
 		if (ret != EFI_SUCCESS)
 			goto out;
-		eth_set_dev(netobj->dev);
+		eth_set_dev(dev);
 		env_set("ethact", eth_get_name());
 		wget_request((ulong)*buffer, url, &efi_wget_info);
 		*file_size = 0;
-- 
2.48.1

