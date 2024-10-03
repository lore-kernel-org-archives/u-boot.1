Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94F9CF34B6
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26B5188F4E;
	Thu,  3 Oct 2024 17:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V76QXAWt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6DEF88EBA; Thu,  3 Oct 2024 17:47:33 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 926CD88F62
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37cce5b140bso808032f8f.3
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970448; x=1728575248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wz69cklJBmi/gyynP/MNmECb+F1rpo4+jC/BQdSi/0=;
 b=V76QXAWtz4jMp4+YbvPDripMJrc5kHLEdEqVFeO44GN156atB0CrxCSacwcWNkAZj8
 eCQO/wXFjtgTNnyAWK+SNmDoDV4m5KombzvKzsUJhbADT97VdnpafQtnmoqDNoknuFFb
 hh/fd/iOkWsEzyBkEIkv5yssYaK+jL0dSqCtYXt6XatlD1fn+sxCu2kffq+nq0YkIZI4
 xQAulV1Qb8ZPhjzSyvYKJVyG3KZpjgqXe93DtweLvTN7uF44tSbgd51Ha/+fez1/STNy
 qsO9XkXJswxW7AKhnpQ/egvTSHXT3zE5N4xTAb0B5eVIle4Zd6n33kYAUy9O7E9eiO/Y
 PYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970448; x=1728575248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3wz69cklJBmi/gyynP/MNmECb+F1rpo4+jC/BQdSi/0=;
 b=pJ8W1PnYqrtpmb6Ki7piypmxPvYQl9WiEDfjDzrCHDkbc7iLm4Z8el+aTLWZBnIkGD
 87JwFnU/QbwNNaDX4+23vTMqsi95nxr7He9HFK/N4+NBIpoclYB5PpYaF5bKbHHODHuu
 EA+c1zygk3dcKtlFvgEIhcSuDApK7nkc8+zs9hPyIo8RuUTATzQ+rT0AO3oDBZi+zfOo
 VxxpKncqrWxNPIKEYiaW1eeYPlYO1WnnHv1ngc1ZdI+RgZ1zBI585L5FQmZRfvzruRJY
 F9OU581oF2nW6jg9Aj2+sFnIUrJcEnpW2UD88G77Nx6KIldxT8h4BzieZlsKXHScbNlW
 tPuQ==
X-Gm-Message-State: AOJu0YxP0q3xOoxSHu/M95QNxveJaUQMwGRI6XYW9lLr5YNiE4rw+Mji
 fOhNZXZCPusiHretVpx+uhtqx+Gmw+eh/Wo73WRXem5HWSzGi4vZh/fABhXmF116Djrr51hFASL
 2o6vUxgna
X-Google-Smtp-Source: AGHT+IEDE4sR0bme+k5ol7WZVeUX8W27j2oXf41wBe2e1JnxEux8XskdjCRtobPq1XzSAky+ZA4DDw==
X-Received: by 2002:adf:e3ca:0:b0:37c:cd1d:b87e with SMTP id
 ffacd0b85a97d-37cfb8cb7a9mr4177972f8f.18.1727970448065; 
 Thu, 03 Oct 2024 08:47:28 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d08245059sm1541748f8f.55.2024.10.03.08.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:47:27 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v11 23/29] lwip: tftp: add support of blksize option to client
Date: Thu,  3 Oct 2024 17:46:27 +0200
Message-Id: <4fd1d5e3848d3e433664165d427dde5e30a99597.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
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

The TFTP protocol uses a default block size of 512 bytes. This value is
sub-optimal for ethernet devices, which have a MTU (Maximum Transmission
Unit) of 1500 bytes. When taking into acount the overhead of the IP and
UDP layers, this leaves 1468 bytes for the TFTP payload.

This patch introduces a new function: tftp_client_set_blksize() which
may be used to change the block size from the default. It has to be
called after tftp_client_init() and before tftp_get(). If the server
does not support the option, the client will still accept to receive
512-byte blocks.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 lib/lwip/lwip/src/apps/tftp/tftp.c            | 94 +++++++++++++++++--
 .../lwip/src/include/lwip/apps/tftp_client.h  |  1 +
 2 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
index 74fc1fbe586..8e0c071772a 100644
--- a/lib/lwip/lwip/src/apps/tftp/tftp.c
+++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
@@ -57,7 +57,7 @@
 #include "lwip/timeouts.h"
 #include "lwip/debug.h"
 
-#define TFTP_MAX_PAYLOAD_SIZE 512
+#define TFTP_DEFAULT_BLOCK_SIZE 512
 #define TFTP_HEADER_LENGTH    4
 
 #define TFTP_RRQ   1
@@ -65,6 +65,7 @@
 #define TFTP_DATA  3
 #define TFTP_ACK   4
 #define TFTP_ERROR 5
+#define TFTP_OACK  6
 
 enum tftp_error {
   TFTP_ERROR_FILE_NOT_FOUND    = 1,
@@ -88,9 +89,11 @@ struct tftp_state {
   int timer;
   int last_pkt;
   u16_t blknum;
+  u16_t blksize;
   u8_t retries;
   u8_t mode_write;
   u8_t tftp_mode;
+  bool wait_oack;
 };
 
 static struct tftp_state tftp_state;
@@ -137,10 +140,24 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
 {
   size_t fname_length = strlen(fname)+1;
   size_t mode_length = strlen(mode)+1;
-  struct pbuf* p = init_packet(opcode, 0, fname_length + mode_length - 2);
+  size_t blksize_length = 0;
+  struct pbuf* p;
   char* payload;
   err_t ret;
 
+  if (tftp_state.blksize) {
+    blksize_length = 14; /* maximum (blksize is a u16_t): 'blksize\0XXXXX\0' */
+    if (tftp_state.blksize < 10000)
+	    blksize_length--;
+    if (tftp_state.blksize < 1000)
+	    blksize_length--;
+    if (tftp_state.blksize < 100)
+	    blksize_length--;
+    if (tftp_state.blksize < 10)
+	    blksize_length--;
+  }
+
+  p = init_packet(opcode, 0, fname_length + mode_length + blksize_length - 2);
   if (p == NULL) {
     return ERR_MEM;
   }
@@ -148,7 +165,10 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
   payload = (char*) p->payload;
   MEMCPY(payload+2,              fname, fname_length);
   MEMCPY(payload+2+fname_length, mode,  mode_length);
+  if (tftp_state.blksize)
+    sprintf(payload+2+fname_length+mode_length, "blksize%c%d%c", 0, tftp_state.blksize, 0);
 
+  tftp_state.wait_oack = true;
   ret = udp_sendto(tftp_state.upcb, p, addr, port);
   pbuf_free(p);
   return ret;
@@ -221,14 +241,14 @@ send_data(const ip_addr_t *addr, u16_t port)
     pbuf_free(tftp_state.last_data);
   }
 
-  tftp_state.last_data = init_packet(TFTP_DATA, tftp_state.blknum, TFTP_MAX_PAYLOAD_SIZE);
+  tftp_state.last_data = init_packet(TFTP_DATA, tftp_state.blknum, TFTP_DEFAULT_BLOCK_SIZE);
   if (tftp_state.last_data == NULL) {
     return;
   }
 
   payload = (u16_t *) tftp_state.last_data->payload;
 
-  ret = tftp_state.ctx->read(tftp_state.handle, &payload[2], TFTP_MAX_PAYLOAD_SIZE);
+  ret = tftp_state.ctx->read(tftp_state.handle, &payload[2], TFTP_DEFAULT_BLOCK_SIZE);
   if (ret < 0) {
     send_error(addr, port, TFTP_ERROR_ACCESS_VIOLATION, "Error occurred while reading the file.");
     close_handle();
@@ -239,6 +259,28 @@ send_data(const ip_addr_t *addr, u16_t port)
   resend_data(addr, port);
 }
 
+static u16_t payload_size(void)
+{
+  if (tftp_state.blksize)
+    return tftp_state.blksize;
+  return TFTP_DEFAULT_BLOCK_SIZE;
+}
+
+static const char *
+find_option(struct pbuf *p, const char *option)
+{
+  int i;
+  u16_t optlen = strlen(option);
+  const char *b = p->payload;
+
+  for (i = 0; i + optlen + 1 < p->len; i++) {
+    if (lwip_strnstr(b + i, option, optlen))
+      return b + i + optlen + 2;
+  }
+
+  return NULL;
+}
+
 static void
 tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr, u16_t port)
 {
@@ -338,6 +380,15 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
       }
 
       blknum = lwip_ntohs(sbuf[1]);
+      if (tftp_state.blksize && tftp_state.wait_oack) {
+        /*
+         * Data received while we are expecting an OACK for our blksize option.
+         * This means the server doesn't support it, let's switch back to the
+         * default block size.
+         */
+       tftp_state.blksize = 0;
+       tftp_state.wait_oack = false;
+      }
       if (blknum == tftp_state.blknum) {
         pbuf_remove_header(p, TFTP_HEADER_LENGTH);
 
@@ -349,7 +400,7 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
           send_ack(addr, port, blknum);
         }
 
-        if (p->tot_len < TFTP_MAX_PAYLOAD_SIZE) {
+        if (p->tot_len < payload_size()) {
           close_handle();
         } else {
           tftp_state.blknum++;
@@ -386,7 +437,7 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
       lastpkt = 0;
 
       if (tftp_state.last_data != NULL) {
-        lastpkt = tftp_state.last_data->tot_len != (TFTP_MAX_PAYLOAD_SIZE + TFTP_HEADER_LENGTH);
+        lastpkt = tftp_state.last_data->tot_len != (TFTP_DEFAULT_BLOCK_SIZE + TFTP_HEADER_LENGTH);
       }
 
       if (!lastpkt) {
@@ -405,6 +456,25 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
         close_handle();
       }
       break;
+    case PP_HTONS(TFTP_OACK): {
+      const char *optval = find_option(p, "blksize");
+      u16_t srv_blksize = 0;
+      tftp_state.wait_oack = false;
+      if (optval) {
+	if (!tftp_state.blksize) {
+	  /* We did not request this option */
+          send_error(addr, port, TFTP_ERROR_ILLEGAL_OPERATION, "blksize unexpected");
+	}
+	srv_blksize = atoi(optval);
+	if (srv_blksize <= 0 || srv_blksize > tftp_state.blksize) {
+	  send_error(addr, port, TFTP_ERROR_ILLEGAL_OPERATION, "Invalid blksize");
+	}
+	LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: accepting blksize=%d\n", srv_blksize));
+	tftp_state.blksize = srv_blksize;
+      }
+      send_ack(addr, port, 0);
+      break;
+    }
     default:
       send_error(addr, port, TFTP_ERROR_ILLEGAL_OPERATION, "Unknown operation");
       break;
@@ -495,6 +565,18 @@ tftp_init_client(const struct tftp_context *ctx)
   return tftp_init_common(LWIP_TFTP_MODE_CLIENT, ctx);
 }
 
+/** @ingroup tftp
+ * Set the block size to be used by the TFTP client. The server may choose to
+ * accept a lower value.
+ * @param blksize Block size in bytes
+ */
+void
+tftp_client_set_blksize(u16_t blksize)
+{
+  if (blksize != TFTP_DEFAULT_BLOCK_SIZE)
+    tftp_state.blksize = blksize;
+}
+
 /** @ingroup tftp
  * Deinitialize ("turn off") TFTP client/server.
  */
diff --git a/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h b/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
index 24dbda6a8c9..e1e21d06b67 100644
--- a/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
+++ b/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
@@ -44,6 +44,7 @@ enum tftp_transfer_mode {
 };
 
 err_t tftp_init_client(const struct tftp_context* ctx);
+void tftp_client_set_blksize(u16_t blksize);
 err_t tftp_get(void* handle, const ip_addr_t *addr, u16_t port, const char* fname, enum tftp_transfer_mode mode);
 err_t tftp_put(void* handle, const ip_addr_t *addr, u16_t port, const char* fname, enum tftp_transfer_mode mode);
 
-- 
2.40.1

