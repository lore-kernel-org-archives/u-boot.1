Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032EFD46C01
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 23:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FEB283BDD;
	Thu, 29 Jan 2026 00:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ai14WP9r";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cPewDd66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25AB183BE1; Thu, 29 Jan 2026 00:44:14 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFD0D83B5E
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 00:43:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f1f4F2Mxdz9sdB;
 Thu, 29 Jan 2026 00:43:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769643837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0i67h6JpcZAkCSIAoq7C2wLGRJpFsFlz1qjctMesaZs=;
 b=ai14WP9rOJua8nOZfdMWmHsaR3ON5OoTE0mvGa27Lqy2ZHsxRg8PNgDPp974BJKwxbFij3
 Jqg5axlWc7DLJrU67riI+3twN7Lq2gQeKnniZWlF0085043WfSZY8X4gB4jUiYkL+qdvSA
 Degfx8H2QmYDZc5kr+zA1wArG6rkLMGluHHotURJaEHWS7/6j+moo8cq+QHaIw0gedAOBn
 +X2DYJv/D+g84FAAKO0Mcr4VaZW8kUjfkWshlAb5WOB58lQWtxo6JoZIk3NRkyn+p7xGi3
 50b0g7YyswBlzkZ0fkXBwIgzaiywTfxsSZXdhDIig+X3VMFkcKYdHziYfKxs5g==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=cPewDd66;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769643835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0i67h6JpcZAkCSIAoq7C2wLGRJpFsFlz1qjctMesaZs=;
 b=cPewDd66ci8mD76EeBamFxoxXTGUDqNbQdcm3aDnyYTHb6yI7bE6PuLOoR0GzDKr4xPub6
 3QW6nLAFmtAe1sxNmqNC6RyV+UEQzYsNHSvV2G4v7KCjPvZ4p4mQvnctIciqkNRPz9SjHE
 nvkss0ut6aS0HUxjccXly3rlk3HqQ+AcR0MBhcWemhqnuJ5zcPdvmrkQ4jUegemXMx5Ok5
 uPxr9fPBK33p/orr4ESXkeLrtRDzaW7ZqUSSViTcUd+TmFmL4m/aoG29O0QDVL8uxhZksr
 6w+pKy/CuZ8UmLt4/XWkYW2ND9SZ0qdwkWN7rCJM5Voo4IokCZPpdOpAdS7EMg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: [PATCH] net: lwip: tftp: add support of tsize option to client
Date: Thu, 29 Jan 2026 00:43:45 +0100
Message-ID: <20260128234351.405945-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 39529374c0fe95994c6
X-MBO-RS-META: zwzdyybdzqkmyk7mwnun4t57tp6jd9si
X-Rspamd-Queue-Id: 4f1f4F2Mxdz9sdB
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

The TFTP server can report the size of the entire file that is about to
be received in the Transfer Size Option, this is described in RFC 2349.
This functionality is optional and the server may not report tsize in
case it is not supported.

Always send tsize request to the server to query the transfer size,
and in case the server does respond, cache that information locally
in tftp_state.tsize, otherwise cache size 0. Introduce new function
tftp_client_get_tsize() which returns the cached tftp_state.tsize so
clients can determine the transfer size and use it.

Update net/lwip/tftp.c to make use of tftp_client_get_tsize() and
avoid excessive printing of '#' during TFTP transfers in case the
transfer size is reported by the server.

Submitted upstream: https://savannah.nongnu.org/patch/index.php?item_id=10557

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome@forissier.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Cc: u-boot@lists.denx.de
---
 lib/lwip/lwip/src/apps/tftp/tftp.c            | 51 +++++++++++++++----
 .../lwip/src/include/lwip/apps/tftp_client.h  |  1 +
 net/lwip/tftp.c                               | 35 +++++++++++--
 3 files changed, 74 insertions(+), 13 deletions(-)

diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
index ecb6c55ae11..5061446b1cf 100644
--- a/lib/lwip/lwip/src/apps/tftp/tftp.c
+++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
@@ -98,6 +98,7 @@ struct tftp_state {
   int last_pkt;
   u16_t blknum;
   u16_t blksize;
+  u32_t tsize;
   u8_t retries;
   u8_t mode_write;
   u8_t tftp_mode;
@@ -167,6 +168,7 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
 {
   size_t fname_length = strlen(fname)+1;
   size_t mode_length = strlen(mode)+1;
+  size_t tsize_length = strlen("tsize")+3; /* "tsize\0\0\0" */
   size_t blksize_length = 0;
   int blksize = tftp_state.blksize;
   struct pbuf* p;
@@ -182,7 +184,7 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
     }
   }
 
-  p = init_packet(opcode, 0, fname_length + mode_length + blksize_length - 2);
+  p = init_packet(opcode, 0, fname_length + mode_length + blksize_length + tsize_length - 2);
   if (p == NULL) {
     return ERR_MEM;
   }
@@ -190,8 +192,9 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
   payload = (char*) p->payload;
   MEMCPY(payload+2,              fname, fname_length);
   MEMCPY(payload+2+fname_length, mode,  mode_length);
+  sprintf(payload+2+fname_length+mode_length, "tsize%c%u%c", 0, 0, 0);
   if (tftp_state.blksize)
-    sprintf(payload+2+fname_length+mode_length, "blksize%c%d%c", 0, tftp_state.blksize, 0);
+    sprintf(payload+2+fname_length+mode_length+tsize_length, "blksize%c%d%c", 0, tftp_state.blksize, 0);
 
   tftp_state.wait_oack = true;
   ret = udp_sendto(tftp_state.upcb, p, addr, port);
@@ -450,14 +453,24 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
       }
 
       blknum = lwip_ntohs(sbuf[1]);
-      if (tftp_state.blksize && tftp_state.wait_oack) {
+      if (tftp_state.wait_oack) {
         /*
-         * Data received while we are expecting an OACK for our blksize option.
+         * Data received while we are expecting an OACK for our tsize option.
          * This means the server doesn't support it, let's switch back to the
          * default block size.
          */
-       tftp_state.blksize = 0;
-       tftp_state.wait_oack = false;
+        tftp_state.tsize = 0;
+        tftp_state.wait_oack = false;
+
+        if (tftp_state.blksize) {
+          /*
+           * Data received while we are expecting an OACK for our blksize option.
+           * This means the server doesn't support it, let's switch back to the
+           * default block size.
+           */
+          tftp_state.blksize = 0;
+          tftp_state.wait_oack = false;
+        }
       }
       if (blknum == tftp_state.blknum) {
         pbuf_remove_header(p, TFTP_HEADER_LENGTH);
@@ -527,21 +540,31 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
       }
       break;
     case PP_HTONS(TFTP_OACK): {
-      const char *optval = find_option(p, "blksize");
+      const char *blksizeoptval = find_option(p, "blksize");
+      const char *tsizeoptval = find_option(p, "tsize");
       u16_t srv_blksize = 0;
+      u32_t srv_tsize = 0;
       tftp_state.wait_oack = false;
-      if (optval) {
+      if (blksizeoptval) {
 	if (!tftp_state.blksize) {
 	  /* We did not request this option */
           send_error(addr, port, TFTP_ERROR_ILLEGAL_OPERATION, "blksize unexpected");
 	}
-	srv_blksize = atoi(optval);
+	srv_blksize = atoi(blksizeoptval);
 	if (srv_blksize <= 0 || srv_blksize > tftp_state.blksize) {
 	  send_error(addr, port, TFTP_ERROR_ILLEGAL_OPERATION, "Invalid blksize");
 	}
 	LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: accepting blksize=%d\n", srv_blksize));
 	tftp_state.blksize = srv_blksize;
       }
+      if (tsizeoptval) {
+	srv_tsize = atoi(tsizeoptval);
+	if (srv_tsize <= 0) {
+	  srv_tsize = 0; /* tsize is optional */
+	}
+	LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: accepting tsize=%d\n", srv_tsize));
+	tftp_state.tsize = srv_tsize;
+      }
       send_ack(addr, port, 0);
       break;
     }
@@ -655,6 +678,16 @@ tftp_init_client(const struct tftp_context *ctx)
   return tftp_init_common(LWIP_TFTP_MODE_CLIENT, ctx);
 }
 
+/** @ingroup tftp
+ * Get the transfer size used by the TFTP client. The server may
+ * report zero in case this is unsupported.
+ */
+u32_t
+tftp_client_get_tsize(void)
+{
+  return tftp_state.tsize;
+}
+
 /** @ingroup tftp
  * Set the block size to be used by the TFTP client. The server may choose to
  * accept a lower value.
diff --git a/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h b/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
index e1e21d06b67..78de50f4924 100644
--- a/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
+++ b/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
@@ -45,6 +45,7 @@ enum tftp_transfer_mode {
 
 err_t tftp_init_client(const struct tftp_context* ctx);
 void tftp_client_set_blksize(u16_t blksize);
+u32_t tftp_client_get_tsize(void);
 err_t tftp_get(void* handle, const ip_addr_t *addr, u16_t port, const char* fname, enum tftp_transfer_mode mode);
 err_t tftp_put(void* handle, const ip_addr_t *addr, u16_t port, const char* fname, enum tftp_transfer_mode mode);
 
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 6c7ffba661e..213c1292eb1 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -31,6 +31,7 @@ struct tftp_ctx {
 	ulong daddr;
 	ulong size;
 	ulong block_count;
+	ulong hash_count;
 	ulong start_time;
 	enum done_state done;
 };
@@ -49,6 +50,8 @@ struct tftp_ctx {
 static int store_block(struct tftp_ctx *ctx, void *src, u16_t len)
 {
 	ulong store_addr = ctx->daddr;
+	ulong tftp_tsize;
+	ulong pos;
 	void *ptr;
 
 	if (CONFIG_IS_ENABLED(LMB)) {
@@ -67,10 +70,21 @@ static int store_block(struct tftp_ctx *ctx, void *src, u16_t len)
 	ctx->daddr += len;
 	ctx->size += len;
 	ctx->block_count++;
-	if (ctx->block_count % 10 == 0) {
-		putc('#');
-		if (ctx->block_count % (65 * 10) == 0)
-			puts("\n\t ");
+
+	tftp_tsize = tftp_client_get_tsize();
+	if (tftp_tsize) {
+		pos = clamp(ctx->size, 0UL, tftp_tsize);
+
+		while (ctx->hash_count < pos * 50 / tftp_tsize) {
+			putc('#');
+			ctx->hash_count++;
+		}
+	} else {
+		if (ctx->block_count % 10 == 0) {
+			putc('#');
+			if (ctx->block_count % (65 * 10) == 0)
+				puts("\n\t ");
+		}
 	}
 
 	return 0;
@@ -84,6 +98,7 @@ static void *tftp_open(const char *fname, const char *mode, u8_t is_write)
 static void tftp_close(void *handle)
 {
 	struct tftp_ctx *ctx = handle;
+	ulong tftp_tsize;
 	ulong elapsed;
 
 	if (ctx->done == FAILURE || ctx->done == ABORTED) {
@@ -92,6 +107,17 @@ static void tftp_close(void *handle)
 	}
 	ctx->done = SUCCESS;
 
+	tftp_tsize = tftp_client_get_tsize();
+	if (tftp_tsize) {
+		/* Print hash marks for the last packet received */
+		while (ctx->hash_count < 49) {
+			putc('#');
+			ctx->hash_count++;
+		}
+		puts("  ");
+		print_size(tftp_tsize, "");
+	}
+
 	elapsed = get_timer(ctx->start_time);
 	if (elapsed > 0) {
 		puts("\n\t ");	/* Line up with "Loading: " */
@@ -176,6 +202,7 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 	ctx.done = NOT_DONE;
 	ctx.size = 0;
 	ctx.block_count = 0;
+	ctx.hash_count = 0;
 	ctx.daddr = addr;
 
 	printf("Using %s device\n", udev->name);
-- 
2.51.0

