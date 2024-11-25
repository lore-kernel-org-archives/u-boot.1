Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D5BD3B7CA
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 01:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F236C89939;
	Mon, 25 Nov 2024 01:59:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RhFShyoN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4C58895F8; Mon, 25 Nov 2024 01:59:00 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7531894CF
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-724f1ce1732so1027829b3a.1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 16:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732496334; x=1733101134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDEHpcWvyFxjRrKGUXDn8wswa252jd5CrebR44tpCJA=;
 b=RhFShyoNITAQ4raPm9tGw0ifBU1DD/HBTm75Bnp7Z4z9peyZXDOQDhK5BEPxTUvW2c
 RR6MkGlEZBVpMiNOP4kEk8j/MNIwgb7RXNKrwWe3sq/Mrjgt/adkkfsKIxyyAis0Lk8r
 PYdLUKsaC/fJEegr5SOUxzo+ru4h8lJ6tczTtDSv7SxPeNpvk9Kb+MQer5oaSXMIA2EE
 CkriQMGLae0fVcS6k+qWAxZyxPq7DwxUtq1jCut/819BlY69OhynDfSwOQHAWFOZrQpQ
 hjdMc45xfZwnRa5q2J/kVGpfidynGah+Jc6xNpUbXkdRNXHwb2MuMuEjLcMdE15/YHhS
 hhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732496334; x=1733101134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LDEHpcWvyFxjRrKGUXDn8wswa252jd5CrebR44tpCJA=;
 b=SnhkMbe5trAmPu3ErF1suj3Vg5Uh/Ac3nJpm9th2oygWa1QVea5gGqesPDxoNHAiq3
 bLeUWBhSlCk6KYDGiKxCEK9Z0ryr09sF1McrTPDeC5yc2lyRvZcBcKvd9KaDXnFjLx1T
 Cd6sX4keIU6cvC36aW7xvEY/OCqLQsO7hIt7dVmHzA/wdeE1AFbfNigj/wrWwxjnyhi6
 pFgc/kkCotwO/noh16RXvO0ujfhuzqPiiXajdKsx1ZDQkyQJULJdt8OanVa74muT2f0D
 HH2Xqy+9X+BJPxvq0zBG2ZCO0v+ZjP0iIJd9JpDT8qZhUYDchm+wiXj1ix7QCuTKnrAt
 pe6g==
X-Gm-Message-State: AOJu0Yx9+daiihI1muB/nXxxZqCIPnCj799mOzIu+sU23Mr1i9BtPvTk
 el/HV+Wh7s+igXNYildJjv8sVfN2Vp7vZR/PljZNtviX5PaWd/EzYPKTpgCkfyg=
X-Gm-Gg: ASbGncsdG4fqAXHu9DdHNEk+YtSMoWWzqTc5hI7qFVt4M2Vab4X6hgyvIsRmhD0bA3m
 GeBzxJbe28TLB+ypv/YV3XuwrYZSvZch96zGdXdHr61s/M/onr2kPaxcTvJWFpzREN1Uje79b0C
 glhTAP7ybdyTIOYkQBaXhiV1dOzTx1Ye5iaVs7w4bQUdQUGvYrWRK40V/XhOz66IpodW3qvW9GD
 Ar6YSlKNr0SfFjGi1tL3H5PKnER1mlx0Czx+O9vo7Of
X-Google-Smtp-Source: AGHT+IHzqFqAVqRDcziVftuZhR6nXfnz7eNC8zS4h9UoYav4+DKnFBj3Ox8nvJS1krRprk7aps5K+A==
X-Received: by 2002:a05:6a00:9298:b0:71e:4930:162c with SMTP id
 d2e1a72fcca58-724df5d5e35mr14141025b3a.6.1732496334164; 
 Sun, 24 Nov 2024 16:58:54 -0800 (PST)
Received: from adriano.. ([186.11.57.125]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de47955asm5377793b3a.65.2024.11.24.16.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 16:58:53 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v5 11/14] efi_loader: efi_net: add EFI_HTTP_PROTOCOL
Date: Sun, 24 Nov 2024 21:58:11 -0300
Message-ID: <20241125005814.236669-12-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125005814.236669-1-adrianox@gmail.com>
References: <20241125005814.236669-1-adrianox@gmail.com>
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

Add an EFI HTTP driver. This commit implements the
EFI_HTTP_PROTOCOL and the EFI_HTTP_SERVICE_BINDING_PROTOCOL.
The latter is attached to the handle of th efi network
device. This is the same handle where snp, pxe, and ipconfig
are attached to.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
(no changes since v4)
Changes in v4:
- Reworked pointers to be void * instead of ulong.
- Removed some console output
- Check invalid parameters at the beginning, and do not signal an event
  in case parameters are invalid.

Changes in v3:
- Add documentation
- Clean up the way the buffer pointed to http_load_addr in the current
  http instance was being freed.
- Remove unnecessary initialization new_instance->handle = NULL in
  efi_http_service_binding_create_child.
 include/efi_loader.h      |   3 +
 lib/efi_loader/Kconfig    |   8 +
 lib/efi_loader/Makefile   |   1 +
 lib/efi_loader/efi_http.c | 548 ++++++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_net.c  |  20 +-
 5 files changed, 578 insertions(+), 2 deletions(-)
 create mode 100644 lib/efi_loader/efi_http.c

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 5891495a9f..bf6b56020c 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -630,6 +630,9 @@ efi_status_t efi_net_register(void);
 /* Called by efi_net_register to make the ip4 config2 protocol available */
 efi_status_t efi_ipconfig_register(const efi_handle_t handle,
 				   struct efi_ip4_config2_protocol *ip4config);
+/* Called by efi_net_register to make the http protocol available */
+efi_status_t efi_http_register(const efi_handle_t handle,
+			       struct efi_service_binding_protocol *http_service_binding);
 /* Called by bootefi to make the watchdog available */
 efi_status_t efi_watchdog_register(void);
 efi_status_t efi_initrd_register(void);
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index b8c8d2ba4a..2084cb5773 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -485,6 +485,14 @@ config EFI_IP4_CONFIG2_PROTOCOL
 	  protocol can be used to set and get the current ip address and
 	  other network information.
 
+config EFI_HTTP_PROTOCOL
+	bool "EFI_HTTP_PROTOCOL support"
+	default y if ARCH_QEMU || SANDBOX
+	depends on WGET
+	help
+	  Provides an EFI HTTP driver implementing the EFI_HTTP_PROTOCOL. and
+	  EFI_HTTP_SERVICE_BINDING_PROTOCOL.
+
 endmenu
 
 menu "Misc options"
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 30cd1de9d6..2a0b4172bd 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_VIDEO) += efi_gop.o
 obj-$(CONFIG_BLK) += efi_disk.o
 obj-$(CONFIG_NETDEVICES) += efi_net.o
 obj-$(CONFIG_EFI_IP4_CONFIG2_PROTOCOL) += efi_ipconfig.o
+obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_http.o
 obj-$(CONFIG_ACPI) += efi_acpi.o
 obj-$(CONFIG_SMBIOS) += efi_smbios.o
 obj-$(CONFIG_EFI_RNG_PROTOCOL) += efi_rng.o
diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
new file mode 100644
index 0000000000..694e199341
--- /dev/null
+++ b/lib/efi_loader/efi_http.c
@@ -0,0 +1,548 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * An HTTP driver
+ *
+ * HTTP_PROTOCOL
+ * HTTP_SERVICE_BINDING_PROTOCOL
+ * IP4_CONFIG2_PROTOCOL
+ */
+
+#include <charset.h>
+#include <efi_loader.h>
+#include <image.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <net.h>
+
+static const efi_guid_t efi_http_service_binding_guid = EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID;
+static const efi_guid_t efi_http_guid = EFI_HTTP_PROTOCOL_GUID;
+
+/**
+ * struct efi_http_instance - EFI object representing an HTTP protocol instance
+ *
+ * @http:			EFI_HTTP_PROTOCOL interface
+ * @handle:			handle to efi object
+ * @configured:			configuration status
+ * @http_load_addr:		data buffer
+ * @file_size:			size of data
+ * @current_offset:		offset in data buffer
+ * @status_code:		HTTP status code
+ * @num_headers:		number of received headers
+ * @headers:			array of headers
+ * @headers_buffer:		raw buffer with headers
+ */
+struct efi_http_instance {
+	struct efi_http_protocol http;
+	efi_handle_t handle;
+	bool configured;
+	void *http_load_addr;
+	ulong file_size;
+	ulong current_offset;
+	u32 status_code;
+	ulong num_headers;
+	struct http_header headers[MAX_HTTP_HEADERS];
+	char headers_buffer[MAX_HTTP_HEADERS_SIZE];
+};
+
+static int num_instances;
+
+/*
+ * efi_u32_to_httpstatus() - convert u32 to status
+ *
+ */
+enum efi_http_status_code efi_u32_to_httpstatus(u32 status);
+
+/*
+ * efi_http_send_data() - sends data to client
+ *
+ *
+ * @client_buffer:		client buffer to send data to
+ * @client_buffer_size:		size of the client buffer
+ * @inst:			HTTP instance for which to send data
+ *
+ * Return:	status code
+ */
+static efi_status_t efi_http_send_data(void *client_buffer,
+				       efi_uintn_t *client_buffer_size,
+				       struct efi_http_instance *inst)
+{
+	efi_status_t ret = EFI_SUCCESS;
+	ulong total_size, transfer_size;
+	uchar *ptr;
+
+	// Amount of data left;
+	total_size = inst->file_size;
+	transfer_size = total_size - inst->current_offset;
+	debug("efi_http: sending data to client, total size %lu\n", total_size);
+	// Amount of data the client is willing to receive
+	if (transfer_size > *client_buffer_size)
+		transfer_size = *client_buffer_size;
+	else
+		*client_buffer_size = transfer_size;
+	debug("efi_http: transfer size %lu\n", transfer_size);
+	if (!transfer_size) // Ok, only headers
+		goto out;
+
+	if (!client_buffer) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	// Send data
+	ptr = (uchar *)inst->http_load_addr + inst->current_offset;
+	memcpy(client_buffer, ptr, transfer_size);
+
+	inst->current_offset += transfer_size;
+
+	// Whole file served, clean the buffer:
+	if (inst->current_offset == inst->file_size) {
+		efi_free_pool(inst->http_load_addr);
+		inst->http_load_addr = NULL;
+		inst->current_offset = 0;
+		inst->file_size = 0;
+	}
+
+out:
+	return ret;
+}
+
+/* EFI_HTTP_PROTOCOL */
+
+/*
+ * efi_http_get_mode_data() - Gets the current operational status.
+ *
+ * This function implements EFI_HTTP_PROTOCOL.GetModeData().
+ * See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:	pointer to the protocol instance
+ * @data:	pointer to the buffer for operational parameters
+ *		of this HTTP instance
+ * Return:	status code
+ */
+static efi_status_t EFIAPI efi_http_get_mode_data(struct efi_http_protocol *this,
+						  struct efi_http_config_data *data)
+{
+	EFI_ENTRY("%p, %p", this, data);
+
+	efi_status_t ret = EFI_UNSUPPORTED;
+
+	return EFI_EXIT(ret);
+}
+
+/*
+ * efi_http_configure() - Initializes operational status for this
+ * EFI HTTP instance.
+ *
+ * This function implements EFI_HTTP_PROTOCOL.Configure().
+ * See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:	pointer to the protocol instance
+ * @data:	pointer to the buffer for operational parameters of
+ *		this HTTP instance
+ * Return:	status code
+ */
+static efi_status_t EFIAPI efi_http_configure(struct efi_http_protocol *this,
+					      struct efi_http_config_data *data)
+{
+	EFI_ENTRY("%p, %p", this, data);
+
+	efi_status_t ret = EFI_SUCCESS;
+	enum efi_http_version http_version;
+	struct efi_httpv4_access_point *ipv4_node;
+	struct efi_http_instance *http_instance;
+
+	if (!this) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	http_instance = (struct efi_http_instance *)this;
+
+	if (!data) {
+		efi_free_pool(http_instance->http_load_addr);
+		http_instance->http_load_addr = NULL;
+		http_instance->current_offset = 0;
+		http_instance->configured = false;
+
+		goto out;
+	}
+
+	if (http_instance->configured) {
+		ret = EFI_ALREADY_STARTED;
+		goto out;
+	}
+
+	http_version = data->http_version;
+	ipv4_node = data->access_point.ipv4_node;
+
+	if ((http_version != HTTPVERSION10 &&
+	    http_version != HTTPVERSION11) ||
+	    data->is_ipv6 || !ipv4_node) { /* Only support ipv4 */
+		ret = EFI_UNSUPPORTED;
+		goto out;
+	}
+
+	if (!ipv4_node->use_default_address) {
+		efi_net_set_addr((struct efi_ipv4_address *)&ipv4_node->local_address,
+				 (struct efi_ipv4_address *)&ipv4_node->local_subnet, NULL);
+	}
+
+	http_instance->current_offset = 0;
+	http_instance->configured = true;
+
+out:
+	return EFI_EXIT(ret);
+}
+
+/*
+ * efi_http_request() - Queues an HTTP request to this HTTP instance
+ *
+ * This function implements EFI_HTTP_PROTOCOL.Request().
+ * See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:	pointer to the protocol instance
+ * @token:	pointer to storage containing HTTP request token
+ * Return:	status code
+ */
+static efi_status_t EFIAPI efi_http_request(struct efi_http_protocol *this,
+					    struct efi_http_token *token)
+{
+	EFI_ENTRY("%p, %p", this, token);
+
+	efi_status_t ret = EFI_SUCCESS;
+	u8 *tmp;
+	u8 url_8[1024];
+	u16 *url_16;
+	enum efi_http_method current_method;
+	struct efi_http_instance *http_instance;
+
+	if (!token || !this || !token->message ||
+	    !token->message->data.request) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	http_instance = (struct efi_http_instance *)this;
+
+	if (!http_instance->configured) {
+		ret = EFI_NOT_STARTED;
+		goto out;
+	}
+
+	current_method = token->message->data.request->method;
+	url_16 = token->message->data.request->url;
+
+	/* Parse URL. It comes in UCS-2 encoding and follows RFC3986 */
+	tmp = url_8;
+	utf16_utf8_strncpy((char **)&tmp, url_16, 1024);
+
+	ret = efi_net_do_request(url_8, current_method, &http_instance->http_load_addr,
+				 &http_instance->status_code, &http_instance->file_size,
+				 http_instance->headers_buffer);
+	if (ret != EFI_SUCCESS)
+		goto out;
+
+	// We have a successful request
+	efi_net_parse_headers(&http_instance->num_headers, http_instance->headers);
+	http_instance->current_offset = 0;
+	token->status = EFI_SUCCESS;
+	goto out_signal;
+
+out_signal:
+	efi_signal_event(token->event);
+out:
+	return EFI_EXIT(ret);
+}
+
+/*
+ * efi_http_cancel() - Abort an asynchronous HTTP request or response token
+ *
+ * This function implements EFI_HTTP_PROTOCOL.Cancel().
+ * See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:	pointer to the protocol instance
+ * @token:	pointer to storage containing HTTP request token
+ * Return:	status code
+ */
+static efi_status_t EFIAPI efi_http_cancel(struct efi_http_protocol *this,
+					   struct efi_http_token *token)
+{
+	EFI_ENTRY("%p, %p", this, token);
+
+	efi_status_t ret = EFI_UNSUPPORTED;
+
+	return EFI_EXIT(ret);
+}
+
+/*
+ * efi_http_response() -  Queues an HTTP response to this HTTP instance
+ *
+ * This function implements EFI_HTTP_PROTOCOL.Response().
+ * See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:	pointer to the protocol instance
+ * @token:	pointer to storage containing HTTP request token
+ * Return:	status code
+ */
+static efi_status_t EFIAPI efi_http_response(struct efi_http_protocol *this,
+					     struct efi_http_token *token)
+{
+	EFI_ENTRY("%p, %p", this, token);
+
+	efi_status_t ret = EFI_SUCCESS;
+	struct efi_http_instance *http_instance;
+	struct efi_http_header **client_headers;
+	struct efi_http_response_data *response;
+
+	if (!token || !this || !token->message) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	http_instance = (struct efi_http_instance *)this;
+
+	// Set HTTP status code
+	if (token->message->data.response) { // TODO extra check, see spec.
+		response = token->message->data.response;
+		response->status_code = efi_u32_to_httpstatus(http_instance->status_code);
+	}
+
+	client_headers = &token->message->headers;
+
+	ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA,
+				(http_instance->num_headers) * sizeof(struct efi_http_header),
+				(void **)client_headers); // This is deallocated by the client.
+	if (ret != EFI_SUCCESS)
+		goto out_bad_signal;
+
+	// Send headers
+	token->message->header_count = http_instance->num_headers;
+	for (int i = 0; i < http_instance->num_headers; i++) {
+		(*client_headers)[i].field_name = http_instance->headers[i].name;
+		(*client_headers)[i].field_value = http_instance->headers[i].value;
+	}
+
+	ret = efi_http_send_data(token->message->body, &token->message->body_length, http_instance);
+	if (ret != EFI_SUCCESS)
+		goto out_bad_signal;
+
+	token->status = EFI_SUCCESS;
+	goto out_signal;
+
+out_bad_signal:
+	token->status = EFI_ABORTED;
+out_signal:
+	efi_signal_event(token->event);
+out:
+	return EFI_EXIT(ret);
+}
+
+/*
+ * efi_http_poll() -  Polls for incoming data packets and processes outgoing data packets
+ *
+ * This function implements EFI_HTTP_PROTOCOL.Poll().
+ * See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:	pointer to the protocol instance
+ * @token:	pointer to storage containing HTTP request token
+ * Return:	status code
+ */
+static efi_status_t EFIAPI efi_http_poll(struct efi_http_protocol *this)
+{
+	EFI_ENTRY("%p", this);
+
+	efi_status_t ret = EFI_UNSUPPORTED;
+
+	return EFI_EXIT(ret);
+}
+
+/* EFI_HTTP_SERVICE_BINDING_PROTOCOL */
+
+/*
+ * efi_http_service_binding_create_child() -  Creates a child handle
+ * and installs a protocol
+ *
+ * This function implements EFI_HTTP_SERVICE_BINDING.CreateChild().
+ * See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:		pointer to the protocol instance
+ * @child_handle:	pointer to child handle
+ * Return:		status code
+ */
+static efi_status_t EFIAPI efi_http_service_binding_create_child(
+			struct efi_service_binding_protocol *this,
+			efi_handle_t *child_handle)
+{
+	EFI_ENTRY("%p, %p", this, child_handle);
+
+	efi_status_t ret = EFI_SUCCESS;
+	struct efi_http_instance *new_instance;
+
+	if (!child_handle)
+		return EFI_EXIT(EFI_INVALID_PARAMETER);
+
+	new_instance = calloc(1, sizeof(struct efi_http_instance));
+	if (!new_instance) {
+		ret = EFI_OUT_OF_RESOURCES;
+		goto failure_to_add_protocol;
+	}
+
+	if (*child_handle) {
+		new_instance->handle = *child_handle;
+		goto install;
+	}
+
+	new_instance->handle = calloc(1, sizeof(struct efi_object));
+	if (!new_instance->handle) {
+		efi_free_pool((void *)new_instance);
+		ret = EFI_OUT_OF_RESOURCES;
+		goto failure_to_add_protocol;
+	}
+
+	efi_add_handle(new_instance->handle);
+	*child_handle = new_instance->handle;
+
+install:
+	ret = efi_add_protocol(new_instance->handle, &efi_http_guid,
+			       &new_instance->http);
+	if (ret != EFI_SUCCESS)
+		goto failure_to_add_protocol;
+
+	new_instance->http.get_mode_data = efi_http_get_mode_data;
+	new_instance->http.configure = efi_http_configure;
+	new_instance->http.request = efi_http_request;
+	new_instance->http.cancel = efi_http_cancel;
+	new_instance->http.response = efi_http_response;
+	new_instance->http.poll = efi_http_poll;
+	++num_instances;
+
+	return EFI_EXIT(EFI_SUCCESS);
+
+failure_to_add_protocol:
+	return EFI_EXIT(ret);
+}
+
+/*
+ * efi_http_service_binding_destroy_child() -  Destroys a child handle with
+ * a protocol installed on it
+ *
+ * This function implements EFI_HTTP_SERVICE_BINDING.DestroyChild().
+ * See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:		pointer to the protocol instance
+ * @child_handle:	child handle
+ * Return:		status code
+ */
+static efi_status_t EFIAPI efi_http_service_binding_destroy_child(
+			struct efi_service_binding_protocol *this,
+			efi_handle_t child_handle)
+{
+	EFI_ENTRY("%p, %p", this, child_handle);
+	efi_status_t ret = EFI_SUCCESS;
+	struct efi_http_instance *http_instance;
+	struct efi_handler *phandler;
+	void *protocol_interface;
+
+	if (num_instances == 0)
+		return EFI_EXIT(EFI_NOT_FOUND);
+
+	if (!child_handle)
+		return EFI_EXIT(EFI_INVALID_PARAMETER);
+
+	efi_search_protocol(child_handle, &efi_http_guid, &phandler);
+
+	if (phandler)
+		protocol_interface = phandler->protocol_interface;
+
+	ret = efi_delete_handle(child_handle);
+	if (ret != EFI_SUCCESS)
+		return EFI_EXIT(ret);
+
+	http_instance = (struct efi_http_instance *)protocol_interface;
+	efi_free_pool(http_instance->http_load_addr);
+	http_instance->http_load_addr = NULL;
+
+	free(protocol_interface);
+
+	num_instances--;
+
+	return EFI_EXIT(EFI_SUCCESS);
+}
+
+/**
+ * efi_http_register() - register the http protocol
+ *
+ */
+efi_status_t efi_http_register(const efi_handle_t handle,
+			       struct efi_service_binding_protocol *http_service_binding)
+{
+	efi_status_t r = EFI_SUCCESS;
+
+	r = efi_add_protocol(handle, &efi_http_service_binding_guid,
+			     http_service_binding);
+	if (r != EFI_SUCCESS)
+		goto failure_to_add_protocol;
+
+	http_service_binding->create_child = efi_http_service_binding_create_child;
+	http_service_binding->destroy_child = efi_http_service_binding_destroy_child;
+
+	return EFI_SUCCESS;
+failure_to_add_protocol:
+	return r;
+}
+
+enum efi_http_status_code efi_u32_to_httpstatus(u32 status)
+{
+	switch (status) {
+	case 100: return HTTP_STATUS_100_CONTINUE;
+	case 101: return HTTP_STATUS_101_SWITCHING_PROTOCOLS;
+	case 200: return HTTP_STATUS_200_OK;
+	case 201: return HTTP_STATUS_201_CREATED;
+	case 202: return HTTP_STATUS_202_ACCEPTED;
+	case 203: return HTTP_STATUS_203_NON_AUTHORITATIVE_INFORMATION;
+	case 204: return HTTP_STATUS_204_NO_CONTENT;
+	case 205: return HTTP_STATUS_205_RESET_CONTENT;
+	case 206: return HTTP_STATUS_206_PARTIAL_CONTENT;
+	case 300: return HTTP_STATUS_300_MULTIPLE_CHOICES;
+	case 301: return HTTP_STATUS_301_MOVED_PERMANENTLY;
+	case 302: return HTTP_STATUS_302_FOUND;
+	case 303: return HTTP_STATUS_303_SEE_OTHER;
+	case 304: return HTTP_STATUS_304_NOT_MODIFIED;
+	case 305: return HTTP_STATUS_305_USE_PROXY;
+	case 307: return HTTP_STATUS_307_TEMPORARY_REDIRECT;
+	case 400: return HTTP_STATUS_400_BAD_REQUEST;
+	case 401: return HTTP_STATUS_401_UNAUTHORIZED;
+	case 402: return HTTP_STATUS_402_PAYMENT_REQUIRED;
+	case 403: return HTTP_STATUS_403_FORBIDDEN;
+	case 404: return HTTP_STATUS_404_NOT_FOUND;
+	case 405: return HTTP_STATUS_405_METHOD_NOT_ALLOWED;
+	case 406: return HTTP_STATUS_406_NOT_ACCEPTABLE;
+	case 407: return HTTP_STATUS_407_PROXY_AUTHENTICATION_REQUIRED;
+	case 408: return HTTP_STATUS_408_REQUEST_TIME_OUT;
+	case 409: return HTTP_STATUS_409_CONFLICT;
+	case 410: return HTTP_STATUS_410_GONE;
+	case 411: return HTTP_STATUS_411_LENGTH_REQUIRED;
+	case 412: return HTTP_STATUS_412_PRECONDITION_FAILED;
+	case 413: return HTTP_STATUS_413_REQUEST_ENTITY_TOO_LARGE;
+	case 414: return HTTP_STATUS_414_REQUEST_URI_TOO_LARGE;
+	case 415: return HTTP_STATUS_415_UNSUPPORTED_MEDIA_TYPE;
+	case 416: return HTTP_STATUS_416_REQUESTED_RANGE_NOT_SATISFIED;
+	case 417: return HTTP_STATUS_417_EXPECTATION_FAILED;
+	case 500: return HTTP_STATUS_500_INTERNAL_SERVER_ERROR;
+	case 501: return HTTP_STATUS_501_NOT_IMPLEMENTED;
+	case 502: return HTTP_STATUS_502_BAD_GATEWAY;
+	case 503: return HTTP_STATUS_503_SERVICE_UNAVAILABLE;
+	case 504: return HTTP_STATUS_504_GATEWAY_TIME_OUT;
+	case 505: return HTTP_STATUS_505_HTTP_VERSION_NOT_SUPPORTED;
+	case 308: return HTTP_STATUS_308_PERMANENT_REDIRECT;
+	default: return HTTP_STATUS_UNSUPPORTED_STATUS;
+	}
+}
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index bed19f6b82..bdf77b155d 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -66,6 +66,7 @@ static struct efi_event *wait_for_packet;
  * @pxe:			PXE base code protocol interface
  * @pxe_mode:			status of the PXE base code protocol
  * @ip4_config2:		IP4 Config2 protocol interface
+ * @http_service_binding:	Http service binding protocol interface
  */
 struct efi_net_obj {
 	struct efi_object header;
@@ -76,6 +77,9 @@ struct efi_net_obj {
 #if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
 	struct efi_ip4_config2_protocol ip4_config2;
 #endif
+#if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
+	struct efi_service_binding_protocol http_service_binding;
+#endif
 };
 
 /*
@@ -1009,6 +1013,19 @@ efi_status_t efi_net_register(void)
 		goto failure_to_add_protocol;
 #endif
 
+#ifdef CONFIG_EFI_HTTP_PROTOCOL
+	r = efi_http_register(&netobj->header, &netobj->http_service_binding);
+	if (r != EFI_SUCCESS)
+		goto failure_to_add_protocol;
+	/*
+	 * No harm on doing the following. If the PXE handle is present, the client could
+	 * find it and try to get its IP address from it. In here the PXE handle is present
+	 * but the PXE protocol is not yet implmenented, so we add this in the meantime.
+	 */
+	efi_net_get_addr((struct efi_ipv4_address *)&netobj->pxe_mode.station_ip,
+			 (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL);
+#endif
+
 	return EFI_SUCCESS;
 failure_to_add_protocol:
 	printf("ERROR: Failure to add protocol\n");
@@ -1196,8 +1213,6 @@ static efi_status_t efi_net_set_buffer(void **buffer, size_t size)
 	if (size < SZ_64K)
 		size = SZ_64K;
 
-	efi_free_pool(*buffer);
-
 	*buffer = efi_alloc(size);
 	if (!*buffer)
 		ret = EFI_OUT_OF_RESOURCES;
@@ -1294,6 +1309,7 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buf
 		wget_ret = wget_request((ulong)*buffer, url, &efi_wget_info);
 		if ((ulong)efi_wget_info.hdr_cont_len > efi_wget_info.buffer_size) {
 			// Try again with updated buffer size
+			efi_free_pool(*buffer);
 			ret = efi_net_set_buffer(buffer, (size_t)efi_wget_info.hdr_cont_len);
 			if (ret != EFI_SUCCESS)
 				goto out;
-- 
2.43.0

