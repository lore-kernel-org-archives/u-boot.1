Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A65D41D46
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B374893F6;
	Tue, 12 Nov 2024 03:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dxXopNTV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0B5689395; Mon, 11 Nov 2024 22:10:29 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FC3089308
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 22:10:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21116b187c4so38712345ad.3
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731359426; x=1731964226; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ko/2Ld+h/teJrs3/PtfwUucRVduGfKCNZub/Tl54CBc=;
 b=dxXopNTVClp9yb8Ypqfk7BAKEFWyzLvVBr8G1R7Y0NcPAQHY5d/LssSyzhj+1R8DAJ
 yoYJbas3OWWflMnfQ59iEhDX8wNfJypOPFNbx2qm+Itn1D5HEDRzLo1ujWw2mWuxc1pE
 4vqr/+IqfuGNOPpjzL9WbqKVf3o/DXv5/nsdJ/KY5ITDBJRiFoSflg307HrjRzXKpSZx
 MaC3qzP/KNBXa3aoaeSaR/z9VevwOsdbOzGehK5VBn6SgMzx9lmNYdbyPZ5dRnR/vwcK
 iVYApj790CUsdblVs/Jn8WyTqg13blGIwZ1VkcR1sStFZ8Ou5LMNQ9I7WnSkcBnuTXAi
 Qa3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731359426; x=1731964226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ko/2Ld+h/teJrs3/PtfwUucRVduGfKCNZub/Tl54CBc=;
 b=T6BZqW2QXmkJsi/sYiA3rRGoJPH0SovpaaMzshekfcX7KsogG4bD+oO4tU/oXM//Dk
 ++18hUj3CbDwgKalwHPjDX/9Yu6QzGh2XnhEWitMt4HUO8IbrEZ808M0wDykBzKRYf23
 DKAqjd+8ikdhes0nNf3mTCxDep7y/CgkLwZGgAqJzN5Fh0h+AVNn/pnNKHoSjVmCoGlo
 5xGdf71ZjJnDz3pp1AJSbX/pp17uvaso4wWxH7BN1uyPNMxIA1yRbStJ6cPal+b/pbR5
 jUT7/xXASJ/bc4F83Li4MU4VVzxFakE5D54UfwXeMgu/pUPGuhdbXGiJRwntiFVFK3bG
 aIRw==
X-Gm-Message-State: AOJu0YzFkYMPl015pkfKMD3uxi9RAoSetb0yMU4z/jOlIVQk67hkeweZ
 XQFrymcw+SFqNqJuI1EVXTPf7ITDtiApSLyJky2Y2NGmEE3jFkO0xmk5YnhC
X-Google-Smtp-Source: AGHT+IGbwQ+QLOTC9YgyMIQcIXbThxC77eKxK7Lfa8AeAkL8KxIBP33B3u3HgTFBq/OTPQ0FRgdzwg==
X-Received: by 2002:a17:903:244c:b0:20c:89b1:e76c with SMTP id
 d9443c01a7336-21183da4ddamr200213985ad.30.1731359425875; 
 Mon, 11 Nov 2024 13:10:25 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9e25sm80031165ad.27.2024.11.11.13.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 13:10:25 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v3 10/15] efi_loader: net: add support to send http requests
 and parse http headers
Date: Mon, 11 Nov 2024 18:09:54 -0300
Message-ID: <20241111210959.560738-11-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111210959.560738-1-adrianox@gmail.com>
References: <20241111210959.560738-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Nov 2024 03:47:02 +0100
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

Changes in v3:
- Add a struct wget_http_info efi_wget_info for efi_net to pass to wget
  when issuing wget requests, instead of using the old wget_info (see v2
  of the series 'wget: Expose wget to applications').
- Let a pointer to the http status code be passed to efi_net_do_request
  for it to fill it for the client after a request.

 include/efi_loader.h     |  13 ++++
 lib/efi_loader/efi_net.c | 158 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 171 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index f49f8e6be0..4d05c08441 100644
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
+efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, ulong *buffer,
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
 static inline void efi_net_get_dp(void **dp) { }
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index d4570d4d7c..30234ae1c7 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -17,6 +17,7 @@
 
 #include <efi_loader.h>
 #include <dm.h>
+#include <linux/sizes.h>
 #include <malloc.h>
 #include <vsprintf.h>
 #include <net.h>
@@ -34,6 +35,12 @@ static int rx_packet_num;
 static struct efi_net_obj *netobj;
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
@@ -1003,6 +1010,10 @@ out_of_resources:
 	return EFI_OUT_OF_RESOURCES;
 }
 
+/**
+ * efi_net_set_dp() - set device path of efi net device
+ *
+ */
 void efi_net_set_dp(const char *dev, const char *server)
 {
 	if (!strcmp(dev, "Net"))
@@ -1011,6 +1022,10 @@ void efi_net_set_dp(const char *dev, const char *server)
 		net_dp = efi_dp_from_http(server);
 }
 
+/**
+ * efi_net_set_dp() - get device path of efi net device
+ *
+ */
 void efi_net_get_dp(void **dp)
 {
 	if (!net_dp)
@@ -1019,6 +1034,10 @@ void efi_net_get_dp(void **dp)
 		*dp = efi_dp_dup(net_dp);
 }
 
+/**
+ * efi_net_get_addr() - get IP address information
+ *
+ */
 void efi_net_get_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
 		      struct efi_ipv4_address *gw)
@@ -1068,6 +1087,10 @@ void efi_net_get_addr(struct efi_ipv4_address *ip,
 #endif
 }
 
+/**
+ * efi_net_set_addr() - set IP address information
+ *
+ */
 void efi_net_set_addr(struct efi_ipv4_address *ip,
 		      struct efi_ipv4_address *mask,
 		      struct efi_ipv4_address *gw)
@@ -1117,3 +1140,138 @@ void efi_net_set_addr(struct efi_ipv4_address *ip,
 		memcpy((void *)&net_netmask, (void *)mask, 4);
 #endif
 }
+
+/**
+ * efi_net_set_buffer() - allocate a buffer of min 64K
+ *
+ */
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
+	efi_wget_info.buffer_size = size;
+	//debug("efi_net: set buffer of size %lu at %lu\n", size, *buffer);
+	return ret;
+}
+
+/**
+ * efi_net_parse_headers() - parse HTTP headers
+ *
+ * Parses the raw buffer efi_wget_info.headers into an array headers
+ * of efi structs http_headers. The array should be at least
+ * MAX_HTTP_HEADERS long.
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
+ */
+efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, ulong *buffer,
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
+		ret = efi_net_set_buffer(buffer, last_head ? efi_wget_info.hdr_cont_len : 0);
+		if (ret != EFI_SUCCESS)
+			goto out;
+		wget_ret = wget_request((ulong)*buffer, url, &efi_wget_info);
+		if ((ulong)efi_wget_info.hdr_cont_len > efi_wget_info.buffer_size) {
+			// Try again with updated buffer size
+			ret = efi_net_set_buffer(buffer, (ulong)efi_wget_info.hdr_cont_len);
+			if (ret != EFI_SUCCESS)
+				goto out;
+			if (wget_request((ulong)*buffer, url, &efi_wget_info)) {
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

