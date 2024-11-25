Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8120FD3B7CA
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50AF889644;
	Mon, 25 Nov 2024 01:58:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gTOwfsdO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7234E89640; Mon, 25 Nov 2024 01:58:52 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BDBA89390
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7251331e756so35679b3a.3
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 16:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732496328; x=1733101128; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3NLg6PNQFN+NY6aP7UQlI+YffNG7iSig7k84z6j5xo=;
 b=gTOwfsdOoBTyyZ2EAo4sZRxXexycEM4dM5Mhx6gRUlZJ+3Xg0PWKXquRp5Ch+V6LxD
 nenWI5ZnU78GdDJIbMVlaLr+bMWLsR8lcRpshiCTL1zHf3wMIMeuCbqb2iA1XvsqDp3j
 09U2GT6cDOY6YolfHLnHrV51Wu67JUgcgGPelHLTm03RceCimZoSfsppTC3GGuQY743z
 70wq6Lwbmpd1qorh835tw7aDwX78iTFzU0DXR7lR39tENIQDNofyRXPjx46g+4RsLXEg
 hL2N6V7LLpMNlar4pEFdOeTodkX+H6aS6JFdXiSBXnMqDX82gETrakXwwMFXyqBvQLTh
 aH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732496328; x=1733101128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X3NLg6PNQFN+NY6aP7UQlI+YffNG7iSig7k84z6j5xo=;
 b=HUGggNnjmfuJzA3OjNnKQl41ptbvHNjHboKS0OjUAc+bGF8GfothH8jzHkWsf3+oN4
 9BITNIUM4wwMoDkqV8kMvsxBOsC2MP5CRwAas42OXlfchDkx7EwEl1msIDkXwWo+N0j0
 fRe0c1BN9niZxM/3dpx5M4NmNrTKkDcoBXyGk9s+r9gf2T4wFZ80WGbgMeOPoIbEo4mC
 8k9Sps+zvRrYm6UWO48AdIL6FYosgM+ukLCYXxpdqGO0kVgChforueN2Ryq9kzyhRrC4
 p3daR9Z1KKcT4kWQnsqNJ5xu6/7h3vafqhYrAAzZa8z3B3otJeKg9IiXum+1ZW7B7vPN
 rIeQ==
X-Gm-Message-State: AOJu0YzrvdsJhYe4rbeS6v9EH9AVC/4r2BaKf2Outi5EzoOdnhUBH8cA
 gKWmmLBJVmxRigX/8MpjO+TtOk1zyOwv6cTNyJo12VcCZ9UFCnFXP6Jrwq1S5XA=
X-Gm-Gg: ASbGnctJoojGruyNoopOqWKk/pzmRZIFuA7XuprAhqvojwHD55X3DTUrCf6ij0woR02
 tcNSmadtAUEcl4s2QW7UMHpVl8NC9c7D+5A1q7Ow4TGU9mediwO8BG7csVxlSU0F4q7Y/PMMJ8l
 fVwsz+iDRsLJhBDpoKkGtYOodVYvg/CgIk+0gx4vI5LsGRbY+qUGiT7F12aoYEFMBZbcxkGI7tg
 VchXRtEo8oalRyr6UM7soVsLAAcCJdn1v3YlC0Khu1A
X-Google-Smtp-Source: AGHT+IHfB4LuM0atqvu2a7jQpQhbRgl3uMJo5lC+dVWHypjzM/ZKcptVDMD4N3hf+4xAKPWKBi9E7Q==
X-Received: by 2002:a05:6a00:1a87:b0:71e:4655:59ce with SMTP id
 d2e1a72fcca58-724ded2e369mr14449793b3a.0.1732496328481; 
 Sun, 24 Nov 2024 16:58:48 -0800 (PST)
Received: from adriano.. ([186.11.57.125]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de47955asm5377793b3a.65.2024.11.24.16.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 16:58:48 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v5 09/14] efi_loader: net: add support to send http requests
 and parse http headers
Date: Sun, 24 Nov 2024 21:58:09 -0300
Message-ID: <20241125005814.236669-10-adrianox@gmail.com>
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

Add network-stack agnostic way to send an http request and
parse http headers from efi drivers. This uses wget as a
backend and communicates with it via efi_wget_info.

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

(no changes since v4)

Changes in v4:
- Remove void* casts
- Add documentation

Changes in v3:
- Add a struct wget_http_info efi_wget_info for efi_net to pass to wget
  when issuing wget requests, instead of using the old wget_info (see v2
  of the series 'wget: Expose wget to applications').
- Let a pointer to the http status code be passed to efi_net_do_request
  for it to fill it for the client after a request.
 include/efi_loader.h     |  13 ++++
 lib/efi_loader/efi_net.c | 155 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 168 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 8e7f5becbb..64c22737e7 100644
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
+efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buffer,
+				u32 *status_code, ulong *file_size, char *headers_buffer);
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
 static inline void efi_net_get_dp(struct efi_device_path **dp) { }
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index b448dcee51..0b8163b148 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -17,6 +17,7 @@
 
 #include <efi_loader.h>
 #include <dm.h>
+#include <linux/sizes.h>
 #include <malloc.h>
 #include <vsprintf.h>
 #include <net.h>
@@ -40,6 +41,12 @@ static struct efi_net_obj *netobj;
  */
 static struct efi_device_path *net_dp;
 
+static struct wget_http_info efi_wget_info = {
+	.set_bootdev = false,
+	.check_buffer_size = true,
+
+};
+
 /*
  * The notification function of this event is called in every timer cycle
  * to check if a new network packet has been received.
@@ -1164,3 +1171,151 @@ void efi_net_set_addr(struct efi_ipv4_address *ip,
 		memcpy(&net_netmask, mask, sizeof(*mask));
 #endif
 }
+
+/**
+ * efi_net_set_buffer() - allocate a buffer of min 64K
+ *
+ * @buffer:	allocated buffer
+ * @size:	desired buffer size
+ * Return:	status code
+ */
+static efi_status_t efi_net_set_buffer(void **buffer, size_t size)
+{
+	efi_status_t ret = EFI_SUCCESS;
+
+	if (size < SZ_64K)
+		size = SZ_64K;
+
+	efi_free_pool(*buffer);
+
+	*buffer = efi_alloc(size);
+	if (!*buffer)
+		ret = EFI_OUT_OF_RESOURCES;
+
+	efi_wget_info.buffer_size = (ulong)size;
+
+	return ret;
+}
+
+/**
+ * efi_net_parse_headers() - parse HTTP headers
+ *
+ * Parses the raw buffer efi_wget_info.headers into an array headers
+ * of efi structs http_headers. The array should be at least
+ * MAX_HTTP_HEADERS long.
+ *
+ * @num_headers:	number of headers
+ * @headers:		caller provided array of struct http_headers
+ */
+void efi_net_parse_headers(ulong *num_headers, struct http_header *headers)
+{
+	if (!num_headers || !headers)
+		return;
+
+	// Populate info with http headers.
+	*num_headers = 0;
+	const uchar *line_start = efi_wget_info.headers;
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
+/**
+ * efi_net_do_request() - issue an HTTP request using wget
+ *
+ * @url:		url
+ * @method:		HTTP method
+ * @buffer:		data buffer
+ * @status_code:	HTTP status code
+ * @file_size:		file size in bytes
+ * @headers_buffer:	headers buffer
+ * Return:		status code
+ */
+efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, void **buffer,
+				u32 *status_code, ulong *file_size, char *headers_buffer)
+{
+	efi_status_t ret = EFI_SUCCESS;
+	int wget_ret;
+	static bool last_head;
+
+	if (!buffer || !file_size)
+		return EFI_ABORTED;
+
+	efi_wget_info.method = (enum wget_http_method)method;
+	efi_wget_info.headers = headers_buffer;
+
+	switch (method) {
+	case HTTP_METHOD_GET:
+		ret = efi_net_set_buffer(buffer, last_head ? (size_t)efi_wget_info.hdr_cont_len : 0);
+		if (ret != EFI_SUCCESS)
+			goto out;
+		wget_ret = wget_request((ulong)*buffer, url, &efi_wget_info);
+		if ((ulong)efi_wget_info.hdr_cont_len > efi_wget_info.buffer_size) {
+			// Try again with updated buffer size
+			ret = efi_net_set_buffer(buffer, (size_t)efi_wget_info.hdr_cont_len);
+			if (ret != EFI_SUCCESS)
+				goto out;
+			if (wget_request((ulong)*buffer, url, &efi_wget_info)) {
+				efi_free_pool(*buffer);
+				ret = EFI_DEVICE_ERROR;
+				goto out;
+			}
+		} else if (wget_ret) {
+			efi_free_pool(*buffer);
+			ret = EFI_DEVICE_ERROR;
+			goto out;
+		}
+		// Pass the actual number of received bytes to the application
+		*file_size = efi_wget_info.file_size;
+		*status_code = efi_wget_info.status_code;
+		last_head = false;
+		break;
+	case HTTP_METHOD_HEAD:
+		ret = efi_net_set_buffer(buffer, 0);
+		if (ret != EFI_SUCCESS)
+			goto out;
+		wget_request((ulong)*buffer, url, &efi_wget_info);
+		*file_size = 0;
+		*status_code = efi_wget_info.status_code;
+		last_head = true;
+		break;
+	default:
+		ret = EFI_UNSUPPORTED;
+		break;
+	}
+
+out:
+	return ret;
+}
-- 
2.43.0

