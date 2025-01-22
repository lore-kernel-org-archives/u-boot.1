Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F416DC02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 349C980BA9;
	Wed, 22 Jan 2025 18:10:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GN+wtZMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2B1D80AE1; Wed, 22 Jan 2025 18:10:09 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E58080A4F
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:10:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2156e078563so95983265ad.2
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565805; x=1738170605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhzHDu9HC1vkjmdI4L3ScqZVyA3WNK37qQDddITX2XY=;
 b=GN+wtZMZhx4WeJXYPwgpxYcGUdEqogLmdIx6ZsdoFvQ2w5rqO2QvFqypmMBK1QHolE
 5e3QB1KuSygwFxit+lN343tgX7t9djZY8wK+xlWzGXKjpo9NwJOqAuXiIt/MSkMkHH+M
 2cXAJfYpJHvTsEjmaUXrwV7vSPBYLsnCaReKKOCavcdBepPlJ2vpgvHGWN+eJf+bMx31
 s8BZrUw6FaPsakdkPpk8JPx+Op7Gy8txsn/R+0yjovcc13TAV3YME37nKrots7w5Xymt
 PEjuPOdP317bCVByB5Xdp8ZQp+l9vJyXFsDh/s/jNihBgok/kZu6nT0zDb4INE9mUnGf
 dpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565805; x=1738170605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhzHDu9HC1vkjmdI4L3ScqZVyA3WNK37qQDddITX2XY=;
 b=c+p4T0a/DXw5w4Nal8j7zu/7QWAK1fw2fWh3dFW9Vhe1EcxTpWY8tchrklQmW18aH9
 WbEc/iEdfPC51bX5OP1PEGG7Z0uRXPB/UQZvIYND+EBPSSpP4QQBiDPn9nrmEvLOBkVI
 J/kfhrQwA61386TSmoi8oQBsV7sKW3sCsIteXRfT7iffegyaEHhc6kYkMfOGxcqUZLu2
 TcZNWessLi3O4wvOmMnGw3YRwraNjnqFK6eBISiClaWBwDF+taiTFShOrIACmCSfdPhv
 3RcIczhrBCG9rWFaNXa3+vMFAbVwA2XEw839O7wGpiaNTeV316V3ACeMYcFSos9Kdbrh
 urpg==
X-Gm-Message-State: AOJu0Yz9LfkDumFyofXYBzYQR4oYFYEAJPy95dCDg+Xonncc8yf4m7la
 qpyc854mSEgA1tuGsddSqubPueg/MU0YhWYdP9kxUvaakmLFNnboXlK0l4JD
X-Gm-Gg: ASbGncvzOo0shmERgDD+IszeIInAJ5sfi8rZGEOoEaUJNxZlq6NRAyG6jYAYUk+snaU
 aYnKhKaE03gfXwdIovC6E8Q8Ilt17J5UpRH6uZ+LCYsgrSqBb2QD1XX23Ly8KK09Ac3jWA7BtXi
 pT2EXGRaKE20ZRLHzp2Mby/uhPAzo39eUIL9itfQ7o7EAbiKzR6GURQdsLTjh2IKOS1RI8wbY9F
 2xoc14C2RJli8Ane/k1cjS+smtazmaSvoOUZ1/8LTctsgg3qS8UaCKXK867WQWSb9wJWedJNgdN
 vQ==
X-Google-Smtp-Source: AGHT+IEuZXAGs47UDDYMQbp8X7EkgNxpdzKrbaQEVId1MEDS+k4pvCLM0fuXRzZNB9o3nolkyeDP6Q==
X-Received: by 2002:a17:902:d48a:b0:216:2f9d:32c with SMTP id
 d9443c01a7336-21c35619612mr378351705ad.53.1737565805488; 
 Wed, 22 Jan 2025 09:10:05 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:10:05 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 21/21] efi_selftest: Add test for efi_netdev driver
Date: Wed, 22 Jan 2025 14:08:58 -0300
Message-ID: <20250122170858.961359-22-adriano.cordova@canonical.com>
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

Test the 'efi_netdev' driver. Take an existing and working snp protocol,
create a handle and install the interface in the handle, and call
connect_controller.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_selftest/Makefile                  |   2 +-
 lib/efi_selftest/efi_selftest_net_driver.c | 310 +++++++++++++++++++++
 2 files changed, 311 insertions(+), 1 deletion(-)
 create mode 100644 lib/efi_selftest/efi_selftest_net_driver.c

diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index f7e8f02cb2..df51e0cfd1 100644
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
index 0000000000..0bd130cb06
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
2.43.0

