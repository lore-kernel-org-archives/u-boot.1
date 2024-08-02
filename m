Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7AEC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 13:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E097388BE8;
	Fri,  2 Aug 2024 15:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QibFZbdu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAE6988BCD; Fri,  2 Aug 2024 15:15:12 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D22088BF2
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 15:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-368380828d6so5245714f8f.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722604509; x=1723209309; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cPzj+kahbIDUn0aO8ocEV3Gnoxfu0K4hRIlupOD9QjQ=;
 b=QibFZbduYI7qGrOVD84lrPRV5kI3k8PZWCwH9ByxdgamHW1XbI9+TwdBj/mH0r87Q1
 NV+dJH4VrtwUYqFBgu4cUgSyjvXfFjGfzwrgGtKjCp9OybJDmQnBbVEm7Sbpo4aipOTX
 jLIZ6O8uPrVLlk1DTlfDfemh9dtLUtyTRbV6ic1SZKcdXvYF+PLl817rh4EFnjMuy7JI
 1aKQuNo/nKS+QFR1PzZlcRkVNI2rB9tqr18B5MTqH74J00TxSYiKrPMJimpf5jieH+1Y
 B4Mgd6C0bRB0vv7GkRxWxsWW7HDcM0W2MW8lwy+ht83kyQN3Ro72hBMHT4zD3zCzRez8
 EZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604509; x=1723209309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cPzj+kahbIDUn0aO8ocEV3Gnoxfu0K4hRIlupOD9QjQ=;
 b=hPiFRPBM4sgDNalGfkG81wylGMGytLm8YK1thbOB7Z+TuyllBBELHV0PhPZK8+oKUh
 ZbSLb7CMq6RMd5sx18MlF8dq6Ag4XY4I/wjie/O5BP5CnsxrRIWy/Gr2LKre4Erlk7vP
 phur6JyJTrPZgwW20qyXogl2ZE1wad66ryuBwBXkxW9nBLNF52727e9S4rgXYo7GkUU+
 jRRNjQp7haCpXC/r2cvT6TqS3jFnfQCbJI1ZHBT3ZsjdtpIBN4XsLcy7DpxymkeTXfGW
 crBtF1Q6FxRUh2QNa7fa1KNcfwExlslcCP1MxWOftr1BEpP3yAZnIYA4b8QmlueY+hkW
 +FHQ==
X-Gm-Message-State: AOJu0YwKIWfyN7niE7zI57HgeY5JWG3BeV4BJWv8hzcBrujNuJ02ltG1
 BwlvR1Ocy3BMOKHl4FmGpC7yWghksjGdg9Nz45qKSPQRN+Kp8QCcAFNLsQHtbNzNd5+GIZmjuiG
 rP/tTxKPx
X-Google-Smtp-Source: AGHT+IG+XArryGNVCYQu37FQz2Aa/oXoCOhyrX8cXDn1tZY2jeqbYVe0cpg8cvtNn+SNWUmu/XMGGw==
X-Received: by 2002:a5d:690d:0:b0:367:9803:bfe7 with SMTP id
 ffacd0b85a97d-36bbc17ed3cmr1991559f8f.53.1722604509533; 
 Fri, 02 Aug 2024 06:15:09 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cc58sm1970304f8f.2.2024.08.02.06.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 06:15:09 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 17/20] lwip: tftp: add support of blksize option to client
Date: Fri,  2 Aug 2024 15:14:04 +0200
Message-Id: <f0c0ad22b77a36df2d93e48cd430b0a4513139f4.1722601509.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722601509.git.jerome.forissier@linaro.org>
References: <cover.1722601509.git.jerome.forissier@linaro.org>
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
index ddfdbfc0c1b..e08e9665124 100644
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
@@ -493,6 +563,18 @@ tftp_init_client(const struct tftp_context *ctx)
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

