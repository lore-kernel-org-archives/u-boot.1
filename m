Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D10BD5C0C3
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8826E89255;
	Fri,  8 Nov 2024 14:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Slbmicvv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62D2B88C86; Fri,  8 Nov 2024 04:47:25 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10A0488B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 04:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7ea76a12c32so1265395a12.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 19:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731037641; x=1731642441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PgwiO7irDl66DWWMCoCogbeJwVRrik4L2zn5CptGwO0=;
 b=SlbmicvvJBSWIHH5CGBqb5y8QH/U8MpXiskBO0ArkwbefTnpI/PSlwHGY2jJyJKcUo
 YHrthWiYTVMHiBsVPBULnR2rEffDAqw+SBh45nSqkeSeoFG2UK+xrlGauRZ3/Y9QMxxc
 HK8VIhRaTWq54g54+vxItSuxgtnDEmipYG0r2+Ryppxt6U/QOozZefhw4Fu6xls1M5kU
 U7J8d4ZFQHEKibzQACCXA6WYT9QuHLT5DYkwVRjjPS7m97O7TxTaPg7TpIHjh3InXxxf
 K73CzYS9rgARxdgd72kj7ECA5KSvU2/fXSWLm2J1nc4uwLhPOYkYqAL3uc5E+GPfmVns
 tDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731037641; x=1731642441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PgwiO7irDl66DWWMCoCogbeJwVRrik4L2zn5CptGwO0=;
 b=fvsTWqTEA98rFzJwwCXepbxq9LXRI6c09Xuw41dpnKn/4Rx23lGZzoxuF8isXshvI7
 Dxkl7dZ+K2EKVhr8xnXbLMdno6qSZra9Brqg+34RFZlptAuO7HS7ATnw6jpsx/V/Xv6Q
 UXS1aC0iYrfhd/v2WvQPXD3wkRWLpf3TYQO9YRF6H32Y4FarRyfLKshFRMA5D8TqgBpG
 nogCIFIRF60U4/QbPlBudm4tlMURXvtzAiPaH7qduiNmEaO38QKTEi3YNHjHGvz1+OJv
 tHZjcfCpjk0jIQ9F7OoceDjkcXRlv56fPyafA8KhJMsvhBxPsNhmQAuuh1CK4d2S6Ozs
 gLhw==
X-Gm-Message-State: AOJu0YzRAjlVQwxIQt745oUPhQIQcjJx9rlVRgKMgAIr/VGbzo62C1dB
 +5W/7HuIc/rnqHu64LEACoXQoenm7h3eMLFisN+H/Y7AY3fnnp/PWhn/RYZIF3g=
X-Google-Smtp-Source: AGHT+IFIerLD/AUIUBiaWnvi9AtfudMhnget9QMwyy6AEVC6C8S7NMZZhc63oGGw5GWenqHPR5Sygg==
X-Received: by 2002:a05:6a20:a12a:b0:1db:e4c3:99f0 with SMTP id
 adf61e73a8af0-1dc22b597c2mr2009783637.32.1731037641550; 
 Thu, 07 Nov 2024 19:47:21 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724079aa83fsm2548614b3a.98.2024.11.07.19.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:47:21 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 10/15] efi_loader: net: add support to send http requests and
 parse http headers
Date: Fri,  8 Nov 2024 00:47:12 -0300
Message-ID: <20241108034712.346436-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 14:06:21 +0100
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

Add network-stack agnostic way to send an http request and
parse http headers from efi drivers. This uses wget as a
backend and communicates with it via the struct wget_http_info
'wget_info'.

The function efi_net_do_request allocates a buffer on behalf of an
efi application using efi_alloc and passes it to wget to receive
the data. If the method is GET and the buffer is too small, it
re-allocates the buffer based on the last received Content-Length
header and tries again. If the method is HEAD it just issues one
request. So issuing a HEAD request (to update Content-Length) and
then a GET request is preferred but not required.

The function efi_net_parse_headers parses a raw buffer containing
an http header into an array of EFI specific 'http_header' structs.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 include/efi_loader.h     |  13 ++++
 lib/efi_loader/efi_net.c | 128 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index c37c1a4660..a19505d4cc 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -16,6 +16,7 @@
 #include <image.h>
 #include <pe.h>
 #include <linux/list.h>
+#include <linux/sizes.h>
 #include <linux/oid_registry.h>
 
 struct blk_desc;
@@ -136,6 +137,18 @@ void efi_net_get_addr(struct efi_ipv4_address *ip,
 void efi_net_set_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
 		      struct efi_ipv4_address *gw);
+efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method,
+				ulong *buffer, ulong *file_size, char *headers_buffer);
+#define MAX_HTTP_HEADERS_SIZE SZ_64K
+#define MAX_HTTP_HEADERS 100
+#define MAX_HTTP_HEADER_NAME 128
+#define MAX_HTTP_HEADER_VALUE 512
+struct http_header {
+	uchar name[MAX_HTTP_HEADER_NAME];
+	uchar value[MAX_HTTP_HEADER_VALUE];
+};
+
+void efi_net_parse_headers(ulong *num_headers, struct http_header *headers);
 #else
 static inline void efi_net_set_dp(const char *dev, const char *server) { }
 static inline void efi_net_get_dp(void **dp) { }
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index d4570d4d7c..43b57b63d5 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -17,6 +17,7 @@
 
 #include <efi_loader.h>
 #include <dm.h>
+#include <linux/sizes.h>
 #include <malloc.h>
 #include <vsprintf.h>
 #include <net.h>
@@ -1117,3 +1118,130 @@ void efi_net_set_addr(struct efi_ipv4_address *ip,
 		memcpy((void *)&net_netmask, (void *)mask, 4);
 #endif
 }
+
+static efi_status_t efi_net_set_buffer(ulong *buffer, ulong size)
+{
+	efi_status_t ret = EFI_SUCCESS;
+
+	if (size < SZ_64K)
+		size = SZ_64K;
+
+	efi_free_pool((void *)*buffer);
+
+	*buffer = (ulong)efi_alloc(size);
+	if (!*buffer)
+		ret = EFI_OUT_OF_RESOURCES;
+
+	wget_info.buffer_size = size;
+	//debug("efi_net: set buffer of size %lu at %lu\n", size, *buffer);
+	return ret;
+}
+
+void efi_net_parse_headers(ulong *num_headers, struct http_header *headers)
+{
+	if (!num_headers || !headers)
+		return;
+
+	// Populate info with http headers.
+	*num_headers = 0;
+	const uchar *line_start = wget_info.headers;
+	const uchar *line_end;
+	ulong count;
+	struct http_header *current_header;
+	const uchar *separator;
+	size_t name_length, value_length;
+
+	// Skip the first line (request or status line)
+	line_end = strstr(line_start, "\r\n");
+
+	if (line_end)
+		line_start = line_end + 2;
+
+	while ((line_end = strstr(line_start, "\r\n")) != NULL) {
+		count = *num_headers;
+		if (line_start == line_end || count >= MAX_HTTP_HEADERS)
+			break;
+		current_header = headers + count;
+		separator = strchr(line_start, ':');
+		if (separator) {
+			name_length = separator - line_start;
+			++separator;
+			while (*separator == ' ')
+				++separator;
+			value_length = line_end - separator;
+			if (name_length < MAX_HTTP_HEADER_NAME &&
+			    value_length < MAX_HTTP_HEADER_VALUE) {
+				strncpy(current_header->name, line_start, name_length);
+				current_header->name[name_length] = '\0';
+				strncpy(current_header->value, separator, value_length);
+				current_header->value[value_length] = '\0';
+				(*num_headers)++;
+			}
+		}
+		line_start = line_end + 2;
+	}
+}
+
+efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method,
+				ulong *buffer, ulong *file_size,
+				char *headers_buffer)
+{
+	efi_status_t ret = EFI_SUCCESS;
+	int wget_ret;
+	static bool last_head;
+	bool old_setbootdev, old_bufsize;
+
+	if (!buffer || !file_size)
+		return EFI_ABORTED;
+
+	wget_info.method = (enum wget_http_method)method;
+	wget_info.headers = headers_buffer;
+	// Do not set u-boot bootdevice when using wget from efi
+	old_setbootdev = wget_info.set_bootdev;
+	old_bufsize = wget_info.check_buffer_size;
+	wget_info.set_bootdev = false;
+	wget_info.check_buffer_size = true;
+
+	switch (method) {
+	case HTTP_METHOD_GET:
+		ret = efi_net_set_buffer(buffer, last_head ? wget_info.hdr_cont_len : 0);
+		if (ret != EFI_SUCCESS)
+			goto out;
+		wget_ret = wget_with_dns((ulong)*buffer, url);
+		if ((ulong)wget_info.hdr_cont_len > wget_info.buffer_size) {
+			// Try again with updated buffer size
+			ret = efi_net_set_buffer(buffer, (ulong)wget_info.hdr_cont_len);
+			if (ret != EFI_SUCCESS)
+				goto out;
+			if (wget_with_dns((ulong)*buffer, url)) {
+				efi_free_pool((void *)*buffer);
+				ret = EFI_DEVICE_ERROR;
+				goto out;
+			}
+		} else if (wget_ret) {
+			efi_free_pool((void *)*buffer);
+			ret = EFI_DEVICE_ERROR;
+			goto out;
+		}
+		// Pass the actual number of received bytes to the application
+		*file_size = wget_info.file_size;
+		last_head = false;
+		break;
+	case HTTP_METHOD_HEAD:
+		ret = efi_net_set_buffer(buffer, 0);
+		if (ret != EFI_SUCCESS)
+			goto out;
+		wget_with_dns((ulong)*buffer, url);
+		*file_size = 0;
+		last_head = true;
+		break;
+	default:
+		ret = EFI_UNSUPPORTED;
+		break;
+	}
+
+out:
+	wget_info.set_bootdev = old_setbootdev;
+	wget_info.check_buffer_size = old_bufsize;
+	return ret;
+}
-- 
2.43.0

