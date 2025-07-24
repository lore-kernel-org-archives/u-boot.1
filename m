Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31BCC87FC5
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 16:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32D24838C5;
	Thu, 24 Jul 2025 18:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GDZCtVBo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7BBC838C7; Thu, 24 Jul 2025 18:09:27 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5473083844
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 18:09:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so1234892f8f.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753373364; x=1753978164; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g1Kv1rzX24QBvW0lBpP3H15NIer5VnrkMgxkEJ7MMqI=;
 b=GDZCtVBoCZDRnMpOcqjS4nJ2mYaBUaq3cJZZKdmt3Zq+h6DurCHU5r+c80YmeZYwoT
 numMCl3Gy9M3/2Dwc5OKkj+4kyRfn20Vy89LNQ8C2OxjPKr5AZGP1iZC8wrjKd1d0O+k
 PQsq404fTj6bYBp1r/Yc9uTCChpeHuNqbkfHmwXn6+POVeS5nrDEpVAAeS0kljLaINeh
 bvxOOUsSwwCvyFJUlty3aYPlHGn2RaK4hXS9J21sEoQpHZbdD44M34gDuB0kJv52qhqO
 tIJgoPsqxjsGJ4vEN9BUBsNjedALa7YaT72YAMeptx0SktzEmZq+YhezllSb0rGmpSPC
 k8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753373364; x=1753978164;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g1Kv1rzX24QBvW0lBpP3H15NIer5VnrkMgxkEJ7MMqI=;
 b=VBT5llTu4mqDe++e5rkfIo+ttlG8FcxaMyy7/360uEW/Ny+xsn0ugKeQRkypoP94g4
 kLoHvQn5t5ixzxZOKvBvq5Jqok/q+mB/YnqVUlFYT3rTTkuqvV/Ka0j+pVgFVXZE+760
 oVhko+RZKZC74+KLix6tkV9ovNMY4jdiqJKZOrFalt4M8iYNcxsfExjlwzE5mOQYMxKo
 FzAeZ0LNcamm0Tnn40tvmVUKujaNzQT18F5izLg0DSu19pOuI0PQkVGAhgPdlFOh/j4v
 FvMmV8RCk34VMl6AJFiEFvTVQ56F0mFfbfI31DMsIHUZwxNpmRQY1WmJvAg4KUbBGs+f
 MeaA==
X-Gm-Message-State: AOJu0YwgiPHY5OMu5Z4wXK2VTKzECNHsCrvxm0BXTuPp9YjNSoYisX8H
 S+cduYl2WALzWlDrAW3dDtAqSUJJKI73Krrc0FYeeQ1uSJ58JtfMlE6hFOZ2Ey4gDfy+BwplJxH
 CoF/Lufw=
X-Gm-Gg: ASbGncsXfahvmSzYvZxlw00mQQo8qoHaj7T2AXI0an7YX+Zj5VdxrTAFWzNZ5/ire2m
 TVHMxwUT/AeR1TqwEjnH9mXWhDNmulFCkqwMUG1fZTUs+/sKkwFjvbsN+yx+IdaRHftScNlrds8
 OOXVrl0raLfiIwSFb8olW22R66dffLNfimKiTyoTC/AbIyPJMaEtgSjxzSEEPsW7Bx6S6YoWfOU
 T6YAozgHvhprapuJ5IDw6JswVMb9b37uEe2Y2GpD68RmL+cRL7rw2xfV40ha3ng/zRsCYDibcKW
 XRrY+vPmAjvpepcFUPG2AC0LhJh3e62nkJH5S5JMfB1TfLNewan9lvGGdSIu4cMA8cnN98Us7wJ
 bM3bIu8z9HJbx+A9Bd/KJ0HtNRMhJMvk=
X-Google-Smtp-Source: AGHT+IEXtUXvDGRjHk971aZILQ+PvlMZnLwPB8K4EU6P4+UPDEXsw/K+DE4U4XGpbopOiFH4kWqQ/A==
X-Received: by 2002:a5d:6886:0:b0:3a3:6478:e08 with SMTP id
 ffacd0b85a97d-3b771374ee2mr2030041f8f.23.1753373364382; 
 Thu, 24 Jul 2025 09:09:24 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1615:f41c:6665:df29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fc6d07asm2620466f8f.19.2025.07.24.09.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 09:09:24 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Venkatesh Abbarapu <venkatesh.abbarapu@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] lwip: tftp: resend initial request
Date: Thu, 24 Jul 2025 18:08:24 +0200
Message-ID: <20250724160903.151997-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

The TFTP implementation does not resend the initial request if there is
no response from the server. Since TFTP is based on UDP, there should be
a mechanism to deal with unreliable transmissions at this point, similar
to what we have for data packets. Therefore, introduce request
retransmission.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
CC: Venkatesh Abbarapu <venkatesh.abbarapu@amd.com>
CC: Michal Simek <michal.simek@amd.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

 lib/lwip/lwip/src/apps/tftp/tftp.c | 74 +++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
index 63b1e0e0e20..ecb6c55ae11 100644
--- a/lib/lwip/lwip/src/apps/tftp/tftp.c
+++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
@@ -79,6 +79,14 @@ enum tftp_error {
 
 #include <string.h>
 
+struct tftp_req {
+  ip_addr_t addr;
+  u16_t port;
+  u16_t opcode;
+  enum tftp_transfer_mode mode;
+  char* fname;
+};
+
 struct tftp_state {
   const struct tftp_context *ctx;
   void *handle;
@@ -97,14 +105,33 @@ struct tftp_state {
 };
 
 static struct tftp_state tftp_state;
+static struct tftp_req tftp_req;
 
 static void tftp_tmr(void *arg);
+static void tftp_req_tmr(void *arg);
+static const char *mode_to_string(enum tftp_transfer_mode mode);
+
+static void
+clear_req(void)
+{
+  ip_addr_set_any(0, &tftp_req.addr);
+  tftp_req.port = 0;
+  tftp_req.opcode = 0;
+  free(tftp_req.fname);
+  tftp_req.fname = NULL;
+  tftp_req.mode = 0;
+
+  sys_untimeout(tftp_req_tmr, NULL);
+}
 
 static void
 close_handle(void)
 {
+  clear_req();
+
   tftp_state.port = 0;
   ip_addr_set_any(0, &tftp_state.addr);
+  tftp_state.retries = 0;
 
   if (tftp_state.last_data != NULL) {
     pbuf_free(tftp_state.last_data);
@@ -209,6 +236,12 @@ send_ack(const ip_addr_t *addr, u16_t port, u16_t blknum)
   return ret;
 }
 
+static err_t
+resend_request(void)
+{
+  return send_request(&tftp_req.addr, tftp_req.port, tftp_req.opcode, tftp_req.fname, mode_to_string(tftp_req.mode));
+}
+
 static err_t
 resend_data(const ip_addr_t *addr, u16_t port)
 {
@@ -336,6 +369,9 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
   tftp_state.last_pkt = tftp_state.timer;
   tftp_state.retries = 0;
 
+  if (tftp_req.fname)
+    clear_req();
+
   switch (opcode) {
     case PP_HTONS(TFTP_RRQ): /* fall through */
     case PP_HTONS(TFTP_WRQ): {
@@ -542,6 +578,26 @@ tftp_tmr(void *arg)
   }
 }
 
+static void
+tftp_req_tmr(void *arg)
+{
+  if (tftp_state.handle == NULL) {
+    return;
+  }
+
+  sys_timeout(TFTP_TIMER_MSECS, tftp_req_tmr, NULL);
+
+  if (tftp_state.retries < TFTP_MAX_RETRIES) {
+    LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: req timeout, retrying\n"));
+    resend_request();
+    tftp_state.retries++;
+  } else {
+    LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: req timeout\n"));
+    tftp_state.ctx->error(tftp_state.handle, -1, "Request timeout", strlen("Request timeout"));
+    close_handle();
+  }
+}
+
 /**
  * Initialize TFTP client/server.
  * @param mode TFTP mode (client/server)
@@ -637,6 +693,20 @@ mode_to_string(enum tftp_transfer_mode mode)
   return NULL;
 }
 
+err_t
+start_send_requests(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname, enum tftp_transfer_mode mode)
+{
+  tftp_req.addr = *addr;
+  tftp_req.port = port;
+  tftp_req.opcode = opcode;
+  tftp_req.fname = strdup(fname);
+  tftp_req.mode = mode;
+  if (!tftp_req.fname)
+    return ERR_MEM;
+  sys_timeout(TFTP_TIMER_MSECS, tftp_req_tmr, NULL);
+  return resend_request();
+}
+
 err_t
 tftp_get(void* handle, const ip_addr_t *addr, u16_t port, const char* fname, enum tftp_transfer_mode mode)
 {
@@ -647,7 +717,7 @@ tftp_get(void* handle, const ip_addr_t *addr, u16_t port, const char* fname, enu
   tftp_state.handle = handle;
   tftp_state.blknum = 1;
   tftp_state.mode_write = 1; /* We want to receive data */
-  return send_request(addr, port, TFTP_RRQ, fname, mode_to_string(mode));
+  return start_send_requests(addr, port, TFTP_RRQ, fname, mode);
 }
 
 err_t
@@ -660,7 +730,7 @@ tftp_put(void* handle, const ip_addr_t *addr, u16_t port, const char* fname, enu
   tftp_state.handle = handle;
   tftp_state.blknum = 1;
   tftp_state.mode_write = 0; /* We want to send data */
-  return send_request(addr, port, TFTP_WRQ, fname, mode_to_string(mode));
+  return start_send_requests(addr, port, TFTP_WRQ, fname, mode);
 }
 
 #endif /* LWIP_UDP */
-- 
2.43.0

base-commit: 230fc9172aec182197b9125a93069a036e7fae13
branch: tftp-req-resend
