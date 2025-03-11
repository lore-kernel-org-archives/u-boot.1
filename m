Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D61C28B2F
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 16:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 272EE81760;
	Tue, 11 Mar 2025 17:48:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jnGu9sML";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AF5B81CA4; Tue, 11 Mar 2025 17:48:31 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B593819FC
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:48:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22359001f1aso136089525ad.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 09:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741711707; x=1742316507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzSHfj5WnvscYABAlhA3I7brDqpWGCiYI/uWIzlL25k=;
 b=jnGu9sMLz0PJHqPZHb6puU9LFfy6cUXE2BOEzPMcyRz1m/J454jSyBk1+kp3UbJal+
 Yp9H5VX8PbxdgUajzFkQYh1YU5CU2/VvRdNWLwAv3s3caIHUXe68kuySE2aDu/fOduTT
 Tz6hGEMrZsJrY4gEMYQyfjio7WUHuTk892fQDdDg2IHsOPtiAmFRhUNbneeX8aBCWOlJ
 EvyOHAwwKygqRdY3ikMPHQ4bv/kInqt+lvhF4qGNT6AumBSPXNl6a54rJC7FVzscuxZt
 lRt2U80gKodkLE1C+YgiGmIce2+Pi/CKICWSU+m9+StVO3sZglCluTgc5JpWXNUFTr5p
 3agA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741711707; x=1742316507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hzSHfj5WnvscYABAlhA3I7brDqpWGCiYI/uWIzlL25k=;
 b=AlWGqzlaAA5BOi6YDVlHxWzhZOlQwk54UQpAL5Ac7+QxNHNEz587XMhGKp1K5oUcM0
 0Lho7P6VzOFqDqHPR8Y6bAbSpNboIV5zXUWlpPxfPcG08IlTMTbXLwHLbeBubF8ECI9y
 h2/YR8BiSq6C7EiarAtyN5+KKeRT/pXv695ltjk8+ybXmi+xcTZtvtEbU0bNvCsU9Koh
 yBuyqiv+cHzljC81lskxnKxVcjuHcCHAJtLstEqPIdjjwviR59IdSjTl2CQSlUaGQAur
 qHs76ukZ0ql0oWJLIu/6m/c/lrICY5LmIb6vx3AEfhl41m+fq+jJLcRxzpkQLki+TQri
 Vbqg==
X-Gm-Message-State: AOJu0YyOVinTqndBwaGsl47bJlgPZgQI3m36dmCc9RRRhH9SXLAxJzjk
 Jbye0IP818HeVcNeA7y/UzJ25MzbY6YvNzzFWhl43e+TbMMHLcgcWQdXORDaYns=
X-Gm-Gg: ASbGncssqx8ycCREwysg5WfJUxN48Um436PrEZ2Q/EQEiFMWpiIZOv0dr+s+yUIsE7Z
 a/y6HLheP7XJJSDnrmBPI5GKVkH1GmzsrICiGVgFB6jvSGaMO6dqa7902o+EfRLOFaqnmDRMyRp
 5CBaeCP1DEM5phwypg10PVOIBMOAZoWvH8bpaTclXzH6f13IOFvBeB57mlCMqZasn8jIlP13SzO
 tv4eXCSn/Y3bYKiVt+5JjBgHrVOqCTPBFW1S0JxlnJ/f5tUZTtQvsG6kb/mrnYm0ks65ocdVQPg
 rx1ot6ioKdD4PMJN2uYsTTwqfgWtsu4GT70WjCxBMu3B9XCW+0ozGJY=
X-Google-Smtp-Source: AGHT+IGKMBtTVIMsZ67Mufi29nz3K9alroezgcq6tHd2sCePQm4BmhYOeFqr6iUTXz9ux/I4hqdzjg==
X-Received: by 2002:a05:6a00:3981:b0:730:8a5b:6e61 with SMTP id
 d2e1a72fcca58-736aa9b36f6mr25178652b3a.2.1741711707039; 
 Tue, 11 Mar 2025 09:48:27 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bf09ae2bsm6941749b3a.74.2025.03.11.09.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 09:48:26 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, =trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 16/16] efi_selftest: Add test for efi_netdev driver
Date: Tue, 11 Mar 2025 13:47:58 -0300
Message-ID: <20250311164758.421900-17-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311164758.421900-1-adriano.cordova@canonical.com>
References: <20250311164758.421900-1-adriano.cordova@canonical.com>
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

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_selftest/Makefile                  |   2 +-
 lib/efi_selftest/efi_selftest_net_driver.c | 310 +++++++++++++++++++++
 2 files changed, 311 insertions(+), 1 deletion(-)
 create mode 100644 lib/efi_selftest/efi_selftest_net_driver.c

diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index f7e8f02cb20..df51e0cfd1b 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -51,7 +51,7 @@ efi_selftest_variables_runtime.o \
 efi_selftest_watchdog.o
 
 obj-$(CONFIG_EFI_ECPT) += efi_selftest_ecpt.o
-obj-$(CONFIG_NETDEVICES) += efi_selftest_snp.o efi_selftest_net_device.o
+obj-$(CONFIG_NETDEVICES) += efi_selftest_snp.o efi_selftest_net_device.o efi_selftest_net_driver.o
 obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_selftest_http.o
 obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_selftest_ipconfig.o
 
diff --git a/lib/efi_selftest/efi_selftest_net_driver.c b/lib/efi_selftest/efi_selftest_net_driver.c
new file mode 100644
index 00000000000..0bd130cb067
--- /dev/null
+++ b/lib/efi_selftest/efi_selftest_net_driver.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * efi_selftest_net_driver
+ *
+ */
+
+#include <efi_selftest.h>
+#include <net.h>
+
+static struct efi_boot_services *boottime;
+static efi_handle_t test_handle;
+static struct efi_service_binding_protocol *http_service;
+static struct efi_http_protocol *http;
+static efi_handle_t http_protocol_handle;
+static int callback_done;
+
+static const efi_guid_t efi_http_guid = EFI_HTTP_PROTOCOL_GUID;
+static const efi_guid_t efi_http_service_binding_guid = EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID;
+
+/*
+ * Setup unit test.
+ *
+ * @handle:	handle of the loaded image
+ * @systable:	system table
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int setup(const efi_handle_t handle,
+		 const struct efi_system_table *systable)
+{
+	efi_status_t ret;
+	struct efi_http_config_data http_config;
+	struct efi_httpv4_access_point ipv4_node;
+	void *snp;
+
+	boottime = systable->boottime;
+
+	ret = boottime->locate_protocol(&efi_net_guid,
+				       NULL, &snp);
+	if (ret != EFI_SUCCESS || !snp) {
+		efi_st_printf("No simple network protocol available, can't proceed with the test\n");
+		return EFI_ST_SUCCESS;
+	}
+
+	test_handle = NULL;
+	ret = boottime->install_protocol_interface(&test_handle, &efi_net_guid,
+						   EFI_NATIVE_INTERFACE, snp);
+	if (ret != EFI_SUCCESS) {
+		efi_st_printf("Can't install simple network protocol\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = boottime->connect_controller(test_handle, NULL, NULL, false);
+	if (ret != EFI_SUCCESS) {
+		efi_st_printf("Failed connecting controller\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = boottime->open_protocol(test_handle,
+					&efi_http_service_binding_guid,
+					(void **)&http_service, 0, 0,
+					EFI_OPEN_PROTOCOL_GET_PROTOCOL);
+	if (ret != EFI_SUCCESS || !http_service) {
+		efi_st_printf("Failed opening http service binding protocol\n");
+		return EFI_ST_FAILURE;
+	}
+
+	http_protocol_handle = NULL;
+	ret = http_service->create_child(http_service, &http_protocol_handle);
+	if (ret != EFI_SUCCESS || !http_protocol_handle) {
+		efi_st_error("Failed to create an http service instance\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = boottime->open_protocol(http_protocol_handle, &efi_http_guid,
+				      (void **)&http, 0, 0, EFI_OPEN_PROTOCOL_GET_PROTOCOL);
+	if (ret != EFI_SUCCESS || !http) {
+		efi_st_error("Failed to open http protocol\n");
+		return EFI_ST_FAILURE;
+	}
+	efi_st_printf("HTTP Service Binding: child created successfully\n");
+
+	http_config.http_version = HTTPVERSION11;
+	http_config.is_ipv6 = false;
+	http_config.access_point.ipv4_node = &ipv4_node;
+	ipv4_node.use_default_address = true;
+
+	ret = http->configure(http, &http_config);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Failed to configure http instance\n");
+		return EFI_ST_FAILURE;
+	}
+
+	return EFI_ST_SUCCESS;
+}
+
+static void EFIAPI efi_test_http_callback(struct efi_event *event, void *context)
+{
+	callback_done = 1;
+}
+
+/*
+ * Execute unit test.
+ *
+ *
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int execute(void)
+{
+	efi_status_t ret;
+	struct efi_http_request_data request_data;
+	struct efi_http_message request_message;
+	struct efi_http_token request_token;
+	struct efi_http_response_data response_data;
+	struct efi_http_message response_message;
+	struct efi_http_token response_token;
+	enum efi_http_status_code status_code;
+	void *response_buffer;
+	efi_uintn_t len, sum;
+	char *url = "http://example.com/";
+	u16 url_16[64];
+	u16 *tmp;
+
+	/* Setup may have failed */
+	if (!http) {
+		efi_st_error("Cannot proceed with test after setup failure\n");
+		return EFI_ST_FAILURE;
+	}
+
+	tmp = url_16;
+	utf8_utf16_strcpy(&tmp, url);
+	request_data.url = url_16;
+	request_data.method = HTTP_METHOD_GET;
+
+	request_message.data.request = &request_data;
+	request_message.header_count = 3;
+	request_message.body_length = 0;
+	request_message.body = NULL;
+
+	/* request token */
+	request_token.event = NULL;
+	request_token.status = EFI_NOT_READY;
+	request_token.message = &request_message;
+	callback_done = 0;
+	ret = boottime->create_event(EVT_NOTIFY_SIGNAL,
+			TPL_CALLBACK,
+			efi_test_http_callback,
+			NULL,
+			&request_token.event);
+
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Failed to create request event\n");
+		return EFI_ST_FAILURE;
+	}
+
+	ret = http->request(http, &request_token);
+
+	if (ret != EFI_SUCCESS) {
+		boottime->close_event(request_token.event);
+		efi_st_printf("Failed to proceed with the http request\n");
+		return EFI_ST_SUCCESS;
+	}
+
+	while (!callback_done)
+		http->poll(http);
+
+	response_data.status_code = HTTP_STATUS_UNSUPPORTED_STATUS;
+	response_message.data.response = &response_data;
+	response_message.header_count = 0;
+	response_message.headers = NULL;
+	response_message.body_length = 0;
+	response_message.body = NULL;
+	response_token.event = NULL;
+
+	ret = boottime->create_event(EVT_NOTIFY_SIGNAL,
+			TPL_CALLBACK,
+			efi_test_http_callback,
+			NULL,
+			&response_token.event);
+
+	if (ret != EFI_SUCCESS) {
+		boottime->close_event(request_token.event);
+		efi_st_error("Failed to create response event\n");
+		return EFI_ST_FAILURE;
+	}
+
+	response_token.status = EFI_SUCCESS;
+	response_token.message = &response_message;
+
+	callback_done = 0;
+	ret = http->response(http, &response_token);
+
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Failed http first response\n");
+		goto fail;
+	}
+
+	while (!callback_done)
+		http->poll(http);
+
+	if (response_message.data.response->status_code != HTTP_STATUS_200_OK) {
+		status_code = response_message.data.response->status_code;
+		if (status_code == HTTP_STATUS_404_NOT_FOUND) {
+			efi_st_error("File not found\n");
+		} else {
+			efi_st_error("Bad http status %d\n",
+				     response_message.data.response->status_code);
+		}
+		goto fail_free_hdr;
+	}
+
+	ret = boottime->allocate_pool(EFI_LOADER_CODE, response_message.body_length,
+				      &response_buffer);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Failed allocating response buffer\n");
+		goto fail_free_hdr;
+	}
+
+	len = response_message.body_length;
+	sum = 0;
+	while (len) {
+		response_message.data.response = NULL;
+		response_message.header_count = 0;
+		response_message.headers = NULL;
+		response_message.body_length = len;
+		response_message.body = response_buffer + sum;
+
+		response_token.message = &response_message;
+		response_token.status = EFI_NOT_READY;
+
+		callback_done = 0;
+		ret = http->response(http, &response_token);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("Failed http second response\n");
+			goto fail_free_buf;
+		}
+
+		while (!callback_done)
+			http->poll(http);
+
+		if (!response_message.body_length)
+			break;
+
+		len -= response_message.body_length;
+		sum += response_message.body_length;
+	}
+
+	if (len)
+		goto fail_free_buf;
+
+	boottime->free_pool(response_buffer);
+	if (response_message.headers)
+		boottime->free_pool(response_message.headers);
+	boottime->close_event(request_token.event);
+	boottime->close_event(response_token.event);
+	efi_st_printf("Efi Http request executed successfully\n");
+	return EFI_ST_SUCCESS;
+
+fail_free_buf:
+	boottime->free_pool(response_buffer);
+fail_free_hdr:
+	if (response_message.headers)
+		boottime->free_pool(response_message.headers);
+fail:
+	boottime->close_event(request_token.event);
+	boottime->close_event(response_token.event);
+	return EFI_ST_FAILURE;
+}
+
+/*
+ * Tear down unit test.
+ *
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int teardown(void)
+{
+	efi_status_t ret;
+	int exit_status = EFI_ST_SUCCESS;
+
+	if (!http_service || !http_protocol_handle) {
+		efi_st_error("No handles to destroy http instance");
+		exit_status = EFI_ST_FAILURE;
+		goto out;
+	}
+
+	ret = http_service->destroy_child(http_service, http_protocol_handle);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Failed to destroy http instance");
+		exit_status = EFI_ST_FAILURE;
+		goto out;
+	}
+	efi_st_printf("HTTP Service Binding: child destroyed successfully\n");
+
+	ret = boottime->disconnect_controller(test_handle, NULL, NULL);
+	if (ret != EFI_SUCCESS) {
+		efi_st_printf("Failed disconnecting controller\n");
+		return EFI_ST_FAILURE;
+	}
+
+out:
+	return exit_status;
+}
+
+EFI_UNIT_TEST(netdriver) = {
+	.name = "netdriver",
+	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
+	.setup = setup,
+	.execute = execute,
+	.teardown = teardown,
+	.on_request = true,
+};
-- 
2.48.1

