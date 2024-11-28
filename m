Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17003D69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BB69897F9;
	Thu, 28 Nov 2024 15:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="En+jQVuv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 435C1887D1; Thu, 28 Nov 2024 15:44:51 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C9B489634
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:44:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2eade1cad26so686408a91.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 06:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732805087; x=1733409887; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jMhCOsvZ/Vsd0qBwAszvc3HGBeZwmg1EfhlKtXeGHzg=;
 b=En+jQVuvvTNGDlgEQlYqTe1b1hh6qlK3FkkX4w1oJKDpfL0O1MVZ0D33ZpvBAwbMRR
 q0J9gJMrN6kNRSLp/N7NJ+d3kxQSqGOzTQiWE/wibJlKTNvO3QsR+NITN4lR3gz60dpz
 tDhyyKIsiDKnwEv2dtoVBkIBD9pt1IryuGeKRKbCz1eh2D28DpkKl4QHdyD71G6XPhyI
 st5ISXmww73XIHlKS+641InF1f7WuFfh8u+qWK20b09KgWh3R5lQ1JXedqNRxPxhX3cr
 URZBxFcZYQSGz8puw7YTERLqdzwmnR2XFKIJaRiMUVkHIyMkjYOVipNrv/K+9LPza8+S
 +59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732805087; x=1733409887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jMhCOsvZ/Vsd0qBwAszvc3HGBeZwmg1EfhlKtXeGHzg=;
 b=WQ/yWXS6bOz2INvK7v4KvmwGyoZyChVJ8VisaQoVdUDJ0rV7Bdp3WvGRdf8QQgn+dP
 +ts2SK4OamQdQgH0sqNvL5DQPrrcUKTevdA1om8GSA7tAolFDX7AlfnTeVzQ+rPb9Zpg
 EE23Lv7E+GpytUjuy8ansvOyecDOcoBV5vV1fYrtDTbHl8pA0spFVttqeFdMBe7gSdUM
 yuA1I6HMFpndVcyB45Od/Ugva1PHdwSHxKFvCA9UDjo8/tXGQEix76JHjKhUh+emBPmM
 D7O3rIFhTnBPICqq9BW4oBeFsiMdBHlaRLK2tSq7sx+yMnu7jTxDhLvyfwF9phHNjKlW
 RKKw==
X-Gm-Message-State: AOJu0YxU/mqzgb9NJ8KI2YaWT42JgH7XU0kZPULufQfht9vgCMgHfIEH
 F8BEG/4bQQtJSUqMHEARlvH43mWenf6ohylicbiv0CGCXeoP24Q6O6a1OIn0FTY=
X-Gm-Gg: ASbGnctrnorFXSRGbyIXvBgkefH1v3YQd3wR48m1T172DzzozjgMjVxNzG0EnxWku0l
 cToTMhiv0k4D31msLc0lXlQtHjSIaCNmsFp/CdhZeO+LY7niWk76dU3mbb54W+8SChsGIswB1Co
 nNg6qQNHzUsr7vEvyn925dQeL6P8dnGDhB3i180v7x2Cel/+YYi7ukujcRVTTs7EBl1aazGAcv5
 V0R4EWIPk8/pKJstjDzhyNDtk5WPlkPVXuCO9FREWU=
X-Google-Smtp-Source: AGHT+IEPKb8ei+cNmJdimVo1HDMR1v5F/gZZhvFNJUWS7OwubOUyZPu1c6X3pfDpjRUkKs+ePSQxGA==
X-Received: by 2002:a17:90b:540e:b0:2ee:4b8f:a5ac with SMTP id
 98e67ed59e1d1-2ee4b8fc3acmr408037a91.26.1732805086423; 
 Thu, 28 Nov 2024 06:44:46 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee2aff1b77sm1532202a91.11.2024.11.28.06.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:44:46 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v6 11/14] efi_loader: efi_net: add EFI_HTTP_PROTOCOL
Date: Thu, 28 Nov 2024 11:44:13 -0300
Message-ID: <20241128144416.604126-12-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128144416.604126-1-adrianox@gmail.com>
References: <20241128144416.604126-1-adrianox@gmail.com>
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
index 9be09a799b..9afbec35eb 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -629,6 +629,9 @@ efi_status_t efi_net_register(void);
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
index 0b932df85c..5c73457d9b 100644
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
index d3a8deecd0..70f8480b87 100644
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
@@ -1207,8 +1224,6 @@ static efi_status_t efi_net_set_buffer(void **buffer, size_t size)
 	if (size < SZ_64K)
 		size = SZ_64K;
 
-	efi_free_pool(*buffer);
-
 	*buffer = efi_alloc(size);
 	if (!*buffer)
 		ret = EFI_OUT_OF_RESOURCES;
@@ -1305,6 +1320,7 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buf
 		wget_ret = wget_request((ulong)*buffer, url, &efi_wget_info);
 		if ((ulong)efi_wget_info.hdr_cont_len > efi_wget_info.buffer_size) {
 			// Try again with updated buffer size
+			efi_free_pool(*buffer);
 			ret = efi_net_set_buffer(buffer, (size_t)efi_wget_info.hdr_cont_len);
 			if (ret != EFI_SUCCESS)
 				goto out;
-- 
2.43.0

