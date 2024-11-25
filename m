Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E85D3B7CB
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 01:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD33F899D0;
	Mon, 25 Nov 2024 01:59:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j7A5TegG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A554689390; Mon, 25 Nov 2024 01:59:05 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9EF189623
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:59:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7ea7e250c54so2967086a12.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 16:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732496341; x=1733101141; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqJOfOadloveu5kayYJu3a9FYGUt5ql/8hqwf+nw3wY=;
 b=j7A5TegGfteJYDE/g0AbxFe6BpaAVGwaZDVEaXbtbeeFxPJGDXpzke/bTOuyG5XptY
 for9kW6iiA0pqvmH68oyDzb6Lo4W4DBugksoqY0Bo8OedVL+UZFkVKhAZHMyaDHIi/F/
 SZJP20nycHuLUdYXSA5qSWJtgMYKMW0SMYHAvmZifjW7V6HBO0qmhV+uV9KbwcpGTkl9
 tEe0dMV9gPca77u8y2xJcMiklMJTEaYY4WNl4+Ox/IpEllNocAFNFW+PaGA1Ix5O3Ps+
 Ah9phgoWgo7RzuUIgtug8WlWrPhdl8ZbJ+fOKwZVyJzifNc5319OpYXGE3E4RqXPrqPq
 Amlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732496341; x=1733101141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aqJOfOadloveu5kayYJu3a9FYGUt5ql/8hqwf+nw3wY=;
 b=WFnksUUOpn65ut/YaIsVYQqr50chjRkiFmnVOsMmFuXFT+W/9JNNqzd5cm+zApGeJC
 FzTdJMFpokifl+1ObuHIc0Wpd5vCgDnPdkLcQG8UpGjLx3aAqtTBGfZ7+Xur0tkf+0wR
 krd2O2aBGoWn2dOS8iNFIwCXxSU7jtX9mNFB6DO67yJhq7aUqf8gIbGkPopby4luQHNP
 LLIGOGrZYr3ba2cbss75yRVulD9Hc3ZOuAHEl/886xW7H7UPLZzTHHRs4fCEgsWQXW9I
 gHFQn5LIiBFa2Z6hZkQIa/iTH9Oe6xyMqFxIBOom3/wUpOTdoLVmScEPvkw8JY/smqaX
 hkUw==
X-Gm-Message-State: AOJu0YzI/0Q7sSuVQhlCZeqY7Nfn3MAfsdpjpZj9xYptlYiMvhmp/eaB
 6Mps9gbVUGhKUa1cfxo09ruGaKJcKUCgMF9RWYYBWfniVv+E7wRUfNdsAqbyIA4=
X-Gm-Gg: ASbGncuiSR5DUVQBHX6meLOW41yW2gWF9ODsnczCYrdNDgSuOHlJlk9vDAu+c6tLFs2
 2JX6U9NcW0M/O+06dH0JG43Fw+sNC4SYwk2AhKxLp3EvUcoEiOHqo1LkIYi76K3qOKKPj0O42BM
 6cs4s2pIxY6vl6PRYYH8y39iZmzi424kzCHy3WD1m7o5hkr35Vgr2Mt7vGJEAg4K/Vt15fcP6+c
 PBE9dihcTAVK88do6PylqAZ8Bcnx9zYZ8demjsjaxDf
X-Google-Smtp-Source: AGHT+IFj48ytrRBpArmVt1zgd0Bp4FL1wOMUNqWXKRSHmhAbUyeWGgPtxr+x2Ou9Gqp731PzY2v2Bw==
X-Received: by 2002:a05:6a20:9d94:b0:1db:e90a:6b24 with SMTP id
 adf61e73a8af0-1e09e45a0b1mr17423196637.25.1732496339797; 
 Sun, 24 Nov 2024 16:58:59 -0800 (PST)
Received: from adriano.. ([186.11.57.125]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de47955asm5377793b3a.65.2024.11.24.16.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 16:58:59 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v5 13/14] efi_selftest: add test for HTTP protocol
Date: Sun, 24 Nov 2024 21:58:13 -0300
Message-ID: <20241125005814.236669-14-adrianox@gmail.com>
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

Add a test for the EFI_HTTP_PROTOCOL and
EFI_SEVICE_BINDING_PROTOCOL.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---

(no changes since v2)
 lib/efi_selftest/Makefile            |   2 +-
 lib/efi_selftest/efi_selftest_http.c | 315 +++++++++++++++++++++++++++
 2 files changed, 316 insertions(+), 1 deletion(-)
 create mode 100644 lib/efi_selftest/efi_selftest_http.c

diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index 414701893f..140c08effc 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -52,7 +52,7 @@ efi_selftest_watchdog.o
 
 obj-$(CONFIG_EFI_ECPT) += efi_selftest_ecpt.o
 obj-$(CONFIG_NETDEVICES) += efi_selftest_snp.o
-
+obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_selftest_http.o
 obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) += efi_selftest_devicepath.o
 obj-$(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2) += \
 efi_selftest_unicode_collation.o
diff --git a/lib/efi_selftest/efi_selftest_http.c b/lib/efi_selftest/efi_selftest_http.c
new file mode 100644
index 0000000000..ce3cf33887
--- /dev/null
+++ b/lib/efi_selftest/efi_selftest_http.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * efi_selftest_http
+ *
+ * This unit test covers the IPv4 Config2 Protocol, Http Service Binding Protocol,
+ * and Http Protocol.
+ *
+ * An Http HEAD and an Http GET request are sent to the same destination. The test
+ * is successful if the HEAD request gets a response with a valid Content-Length header
+ * and the subsequent GET request receives the amount of bytes informed by the previous
+ * Content-Length header.
+ *
+ */
+
+#include <efi_selftest.h>
+#include <charset.h>
+#include <net.h>
+
+static struct efi_boot_services *boottime;
+
+static struct efi_http_protocol *http;
+static struct efi_service_binding_protocol *http_service;
+static struct efi_ip4_config2_protocol *ip4_config2;
+static efi_handle_t http_protocol_handle;
+
+static const efi_guid_t efi_http_guid = EFI_HTTP_PROTOCOL_GUID;
+static const efi_guid_t efi_http_service_binding_guid = EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID;
+static const efi_guid_t efi_ip4_config2_guid = EFI_IP4_CONFIG2_PROTOCOL_GUID;
+static int callback_done;
+
+/*
+ * Setup unit test.
+ *
+ *
+ * @handle:	handle of the loaded image
+ * @systable:	system table
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int setup(const efi_handle_t handle,
+		 const struct efi_system_table *systable)
+{
+	efi_status_t ret;
+	efi_handle_t *net_handle;
+	efi_uintn_t num_handles;
+	efi_handle_t *handles;
+	struct efi_http_config_data http_config;
+	struct efi_httpv4_access_point ipv4_node;
+
+	boottime = systable->boottime;
+
+	boottime->locate_handle_buffer(BY_PROTOCOL, &efi_ip4_config2_guid,
+				       NULL, &num_handles, &handles);
+
+	for (net_handle = handles; num_handles--; net_handle++) {
+		ret = boottime->open_protocol(*net_handle, &efi_ip4_config2_guid,
+					      (void **)&ip4_config2, 0, 0,
+					      EFI_OPEN_PROTOCOL_GET_PROTOCOL);
+		if (ret != EFI_SUCCESS || !ip4_config2)
+			continue;
+		ret = boottime->open_protocol(*net_handle,
+					      &efi_http_service_binding_guid,
+					      (void **)&http_service, 0, 0,
+					      EFI_OPEN_PROTOCOL_GET_PROTOCOL);
+		if (ret != EFI_SUCCESS || !http_service)
+			continue;
+		break; // Get first handle that supports both protocols
+	}
+
+	if (!ip4_config2 || !http_service) {
+		efi_st_error("Failed to locate ipv4 config2 or http service binding protocol\n");
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
+void EFIAPI efi_test_http_callback(struct efi_event *event, void *context)
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
+	if (!ip4_config2 || !http) {
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
+	} else {
+		ret = http_service->destroy_child(http_service, http_protocol_handle);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("Failed to destroy http instance");
+			exit_status = EFI_ST_FAILURE;
+		}
+		efi_st_printf("HTTP Service Binding: child destroyed successfully\n");
+	}
+
+	return exit_status;
+}
+
+EFI_UNIT_TEST(http) = {
+	.name = "http protocol",
+	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
+	.setup = setup,
+	.execute = execute,
+	.teardown = teardown,
+#ifdef CONFIG_SANDBOX
+	/*
+	 * Running this test on the sandbox requires setting environment
+	 * variable ethact to a network interface connected to a DHCP server and
+	 * ethrotate to 'no'.
+	 */
+	.on_request = true,
+#endif
+};
-- 
2.43.0

