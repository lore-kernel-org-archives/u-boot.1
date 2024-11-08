Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF978D5C0F5
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:58:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BC04892FD;
	Fri,  8 Nov 2024 16:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b/F4SrvR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6064F88DF5; Fri,  8 Nov 2024 14:40:21 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 967CE8900E
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 14:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20c70abba48so22226135ad.0
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 05:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731073217; x=1731678017; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CrtuE+Nh/wUSPmcOezioGpjywkYEZQxR986U/FVFmuE=;
 b=b/F4SrvRJZnBio3CSbJTE3ueLwRtEWiM/fuShxO/V8vfinthZvpMoPR7t028vdrq4j
 9zQ36e1CG0e+JmoP0h4oOYH9FE5rGEf7iLaLBxWZSAqQDILrOQDhg+qvKnItkp0l03C5
 7mvRJLbD3rxZnjMLiWVmBnX9lS31E7JwmXW5z+hgPaffuaOaqKWc9O16yd9ltg3WQk95
 5ouhBtrooQ6YMII6Racyo06WRlZutd8Hokdo2vQbVIeVmrdb6Z9Y5BpNw8z9QKOZvtZI
 JgR43leQ9zBV8/7+naTvcP2C7TPuVWk8XLKlkUKdq0YT/KwzlDYIDmEPSrP8AxLeA+kS
 XueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731073217; x=1731678017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CrtuE+Nh/wUSPmcOezioGpjywkYEZQxR986U/FVFmuE=;
 b=qJpwMPkQmoFBU1jL93sCtpbtUEnpRaKLBxoASnLSNL2QpYDLzqeSazhHqrojx1q2VI
 f2OfUFWEuc0jjDQG+rLNSqIvSnQo9IOEB8biNFZbMCa5BmgREN8+fcCDycpqce+MeY9h
 qTKzR5ksx7nTHOyN1YzrcAJg1TGthbYnq9Rk/kWKqXvWWC/IvX4jn1TcfD3pq4shWaTW
 tD/1KJf4xzGMDx91ebRiMl2DzsS0HXBYmigUrZB/dR2EYLV2imREjuhGUaDMHcFE6T4E
 0nsfSlQp5mRVG5BRWufnLga6c6x3Bp1HxEH5B0cW3yxVsEtHjEsYnfaGPCk9Fb/OMi7G
 dMBQ==
X-Gm-Message-State: AOJu0YwKjMI/hYAD4sM2Az93RRBO3aKFusB2c2Oj9v9eD+H4NcEAcAHo
 1aZH8DyflVekQy1MPkAljNmvPasLHRjWSnkOHl9WjNNmpCjirUJD9/cUXK4al8s=
X-Google-Smtp-Source: AGHT+IHXlN4k4p32gDpD04ynLLhOd/fR4PzIeWbLEIH6iP4MMon7CmbdmpSnLyQfuRL1fXqrN5MMUg==
X-Received: by 2002:a17:902:ecc3:b0:20f:5443:9ec1 with SMTP id
 d9443c01a7336-21183d261bcmr25810705ad.33.1731073216933; 
 Fri, 08 Nov 2024 05:40:16 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc8376sm30296295ad.44.2024.11.08.05.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 05:40:16 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 12/15] efi_loader: efi_net: add EFI_HTTP_PROTOCOL
Date: Fri,  8 Nov 2024 10:38:47 -0300
Message-ID: <20241108133850.431075-13-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108133850.431075-1-adrianox@gmail.com>
References: <20241108133850.431075-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 16:56:12 +0100
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
 include/efi_loader.h      |   3 +
 lib/efi_loader/Kconfig    |   8 +
 lib/efi_loader/Makefile   |   1 +
 lib/efi_loader/efi_http.c | 537 ++++++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_net.c  |  17 ++
 5 files changed, 566 insertions(+)
 create mode 100644 lib/efi_loader/efi_http.c

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 216b2a9d00..b6c780757a 100644
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
index 36377487f3..6f9bc80883 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -485,6 +485,14 @@ config EFI_IP4_CONFIG2_PROTOCOL
 	  protocol can be used to set and get the current ip address and
 	  other network information.
 
+config EFI_HTTP_PROTOCOL
+	bool "EFI_HTTP_PROTOCOL support"
+	default y
+	depends on WGET
+	help
+	  Provides an EFI HTTP driver implementing the EFI_HTTP_PROTOCOL. and
+	  EFI_HTTP_SERVICE_BINDING_PROTOCOL.
+
 endmenu
 
 menu "Misc options"
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 0c7e8cfeb8..39df872369 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_VIDEO) += efi_gop.o
 obj-$(CONFIG_BLK) += efi_disk.o
 obj-$(CONFIG_NETDEVICES) += efi_net.o
 obj-$(CONFIG_EFI_IP4_CONFIG2_PROTOCOL) += efi_ipconfig.o
+obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_http.o
 obj-$(CONFIG_ACPI) += efi_acpi.o
 obj-$(CONFIG_SMBIOS) += efi_smbios.o
 obj-$(CONFIG_EFI_RNG_PROTOCOL) += efi_rng.o
diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
new file mode 100644
index 0000000000..41a40a7e64
--- /dev/null
+++ b/lib/efi_loader/efi_http.c
@@ -0,0 +1,537 @@
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
+struct efi_http_instance {
+	struct efi_http_protocol http;	// EFI_HTTP_PROTOCOL
+	efi_handle_t handle;		// Pointer to efi object
+	bool configured;
+	ulong http_load_addr;
+	ulong file_size;
+	ulong current_offset;
+	ulong num_headers;
+	struct http_header headers[MAX_HTTP_HEADERS];
+	char headers_buffer[MAX_HTTP_HEADERS_SIZE];
+};
+
+static int num_instances;
+
+enum efi_http_status_code efi_ul_to_httpstatus(ulong status);
+
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
+	ptr = map_sysmem(inst->http_load_addr + inst->current_offset, transfer_size);
+	memcpy(client_buffer, ptr, transfer_size);
+	unmap_sysmem(ptr);
+
+	inst->current_offset += transfer_size;
+
+	// Whole file served, clean the buffer:
+	if (inst->current_offset == inst->file_size) {
+		efi_free_pool((void *)inst->http_load_addr);
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
+ * This function implements EFI_HTTP_PROTOCOL.GetModeData()
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
+	/* Only support ipv4 */
+	if (!this || !data || !data->access_point.ipv4_node) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+out:
+	return EFI_EXIT(ret);
+}
+
+/*
+ * efi_http_configure() - Initializes operational status for this
+ * EFI HTTP instance.
+ *
+ * This function implements EFI_HTTP_PROTOCOL.Configure()
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
+		efi_free_pool((void *)http_instance->http_load_addr);
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
+ * This function implements EFI_HTTP_PROTOCOL.Request()
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
+	if (!token || !this) {
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
+	if (!token->message || !token->message->data.request)
+		goto out_invalid;
+
+	current_method = token->message->data.request->method;
+	url_16 = token->message->data.request->url;
+
+	/* Parse URL. It comes in UCS-2 encoding and follows RFC3986 */
+	tmp = url_8;
+	utf16_utf8_strcpy((char **)&tmp, url_16);
+
+	ret = efi_net_do_request(url_8, current_method, &http_instance->http_load_addr,
+				 &http_instance->file_size, http_instance->headers_buffer);
+	if (ret != EFI_SUCCESS)
+		goto out;
+
+	// We have a new file
+	efi_net_parse_headers(&http_instance->num_headers, http_instance->headers);
+	http_instance->current_offset = 0;
+	token->status = EFI_SUCCESS;
+	goto out_signal;
+
+out_invalid:
+	ret = EFI_INVALID_PARAMETER;
+	token->status = EFI_ABORTED;
+out_signal:
+	efi_signal_event(token->event);
+out:
+	return EFI_EXIT(ret);
+}
+
+/*
+ * efi_http_cancel() - Abort an asynchronous HTTP request or response token
+ *
+ * This function implements EFI_HTTP_PROTOCOL.Cancel()
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
+ * This function implements EFI_HTTP_PROTOCOL.Response()
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
+	if (!token) {
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
+	if (!this || !token->message)
+		goto out_invalid;
+
+	http_instance = (struct efi_http_instance *)this;
+
+	// Set HTTP status code
+	if (token->message->data.response) { // TODO extra check, see spec.
+		response = token->message->data.response;
+		response->status_code = efi_ul_to_httpstatus(wget_info.status_code);
+	}
+	client_headers = &token->message->headers;
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
+	if (ret != EFI_SUCCESS)
+		goto out_bad_signal;
+
+	ret = efi_http_send_data(token->message->body, &token->message->body_length, http_instance);
+	if (ret != EFI_SUCCESS)
+		goto out_bad_signal;
+
+	token->status = EFI_SUCCESS;
+	goto out_signal;
+
+out_invalid:
+	ret = EFI_INVALID_PARAMETER;
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
+ * This function implements EFI_HTTP_PROTOCOL.Poll()
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
+ * This function implements EFI_HTTP_SERVICE_BINDING.CreateChild()
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
+	new_instance->handle = NULL;
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
+failure_to_add_protocol:
+	printf("ERROR: Failure to add protocol\n");
+	return EFI_EXIT(ret);
+}
+
+/*
+ * efi_http_service_binding_destroy_child() -  Destroys a child handle with
+ * a protocol installed on it
+ *
+ * This function implements EFI_HTTP_SERVICE_BINDING.DestroyChild()
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
+	if (ret != EFI_SUCCESS) {
+		printf("ERROR: Failure to remove protocol\n");
+		return EFI_EXIT(ret);
+	}
+
+	http_instance = (struct efi_http_instance *)protocol_interface;
+	efi_free_pool((void *)http_instance->http_load_addr);
+
+	free(protocol_interface);
+
+	num_instances--;
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
+	printf("ERROR: Failure to add protocol\n");
+	return r;
+}
+
+enum efi_http_status_code efi_ul_to_httpstatus(ulong status)
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
index 015b6a7cc1..2c9fc17795 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -54,6 +54,7 @@ static struct efi_event *wait_for_packet;
  * @pxe:			PXE base code protocol interface
  * @pxe_mode:			status of the PXE base code protocol
  * @ip4_config2:		IP4 Config2 protocol interface
+ * @http_service_binding:	Http service binding protocol interface
  */
 struct efi_net_obj {
 	struct efi_object header;
@@ -64,6 +65,9 @@ struct efi_net_obj {
 #ifdef CONFIG_EFI_IP4_CONFIG2_PROTOCOL
 	struct efi_ip4_config2_protocol ip4_config2;
 #endif
+#ifdef CONFIG_EFI_HTTP_PROTOCOL
+	struct efi_service_binding_protocol http_service_binding;
+#endif
 };
 
 /*
@@ -997,6 +1001,19 @@ efi_status_t efi_net_register(void)
 		goto failure_to_add_protocol;
 #endif
 
+#ifdef CONFIG_EFI_HTTP_PROTOCOL
+	r = efi_http_register(&netobj->header, &netobj->http_service_binding);
+	if (r != EFI_SUCCESS)
+		goto failure_to_add_protocol;
+	/*
+	 * No harm on doing the following. If the pxe handle is present the client could
+	 * find it and try to get its IP from it. In here the pxe handle is present but the
+	 * pxe protocol is not yet implmenented, so we add this on the meantime.
+	 */
+	efi_net_get_addr((struct efi_ipv4_address *)&netobj->pxe_mode.station_ip,
+			 (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL);
+#endif
+
 	return EFI_SUCCESS;
 failure_to_add_protocol:
 	printf("ERROR: Failure to add protocol\n");
-- 
2.43.0

