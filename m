Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F397C624D5
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 17:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37B27407BA;
	Tue,  1 Sep 2026 17:09:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5cs1OAqMl2z4; Tue,  1 Sep 2026 17:09:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788282597;
	bh=GG91exDkbJxW3sE81/CLe3y18QtiSmy5LYzVyP8TeHU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=arJ1JaztfRDI5HBpnBE9gShRE4jRHVP3OvFnZNxGE+Fk9Jd1KcKTAbuD3dl3q0RjV
	 1gEEu3fCTkjArhoGT6gzd9vFrY0S/KVOwahD+0C4wrh3Z+WqZbEDgSgBio7+rPyijx
	 PgFC1wCbtPUdjdEcq0Z9ziqKmbM6dzBI4Alkn2c+UENA2EMOppARsFnLdqdF7Oomi/
	 wsu5+rZGwpBIBVw8aJ6THCfPHEgRrn7/tcxdLr8Gu66sMqn/KKXRFRKWdzWoQE2Ngi
	 OKAkSsDEjd7rO2k3RZyJcpOdqh2bZswbto+/Lft+7v8VUakTOmy6m5LfAByBhcoey8
	 cqm2LD1QXewfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49FE140795;
	Tue,  1 Sep 2026 17:09:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B0BB5279
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9690740791
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jaTKbF8oABpj for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 17:09:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=jgOJUnhm
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D6D740743
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:48 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7f6617c7536so1605031a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788282587; x=1788887387;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GG91exDkbJxW3sE81/CLe3y18QtiSmy5LYzVyP8TeHU=;
 b=jgOJUnhmc6hKDMMIX25G/Tn4UcW5yT9fZ5EJBz2lN1bT56P2sGHQ1FpjrrL5G92n7z
 AXl5e/Db0eDjAXxSkCQyfbv8b+f6ULpIGKHtZDUNGvJwCl67pUVGzzgdiywFqn4s4q64
 FnogLROUpOq4QW2bPAaj+3h5NAqVN8ibSRsdQp6GuCwnvriEVrZ0rUD41guI7gTfj2df
 zCIQIPs0cu5BZPdBqKvAjL3RlwtY/ENjvvi1GuTscdKPWQzPS7X32vyg8FMxKyMwmPxK
 Ce7M9NvqxsACimMovKC8pfhpReIxgpAwZ22pqLOnGEMYK7lglbjlEUf0b6FNzesEU9zA
 7EXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788282587; x=1788887387;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GG91exDkbJxW3sE81/CLe3y18QtiSmy5LYzVyP8TeHU=;
 b=AT2YHaMfESXSi75zLinLsH8g3osK+42Dnbxq0EEXrWBcV3m0xPRoiNLKkFg9akjidX
 4x0UwYRsthS4hnNI3djl6vui3l/hNPsf4uDiGFWZiaNmFtiSg9EdQIhBnRAuTXa/ZNDx
 s2VUxaBe3vS0YM2BItsNIwANpiefQidW745178sKcsSPGl4t9IGTHHhsombCdLYZKMJD
 JEP6xZWzDCfIMD9aZFzaBG8dLsn0WQ+CA8QyjchXASuwjb5E0xrvOCPl+zTZXYcQEqyx
 p+2RxfAVN52RYGJW3vCFLvCa126jCrrM4Mhx06bxhAzOuoLM0AnYN6HYVd7yDQUCJ8Of
 92Ew==
X-Gm-Message-State: AFuF++mdGPIvUpdVSWmowU1YYukUwGBmYmPMhdYcTHHB8+oB0whVCjte
 lPf4n3l8T3l6Eetdud+e0AEAW5weA3dOsaUXqQbiivzJbDYGJn+v8xum
X-Gm-Gg: AR+sD11c3JjjqDS4VYDknjsX2RWUtrv8dZ9s3irkbQYMaQPIYY7ei9QCwum+n6fz7f6
 f//niN72XgdXtdXplINCWFi6ArdzXSnGIipXQeFGA8otsBlr9xZfahuOqqQLpXUNTWM663F4yVP
 YgM6Z8rAzDhrVW57zigNKwoKgyTmYto5FtLSUWUo53uywcaKtNphuZIOx89H0F/VZlO7QM5x2G+
 Dw9ehhqjoDExGuEjPeYoqUfOlZ1TH1WaIUDtcDStSPQa77l7uxzyJ0FHEmG7BlSgwinbFCCwiBm
 fzy3yk3T399Y02M+GnLOseh8baEbIzKGisDUZAcNfOV8Q1exB7KcpyYQfFHQonNrieNcNGus+Zs
 pqTjS7Ryeyo0MWTItsYGgz6kGYKrb5vw8qjt+YD/t3jGljIZ79FJD5TjlTQmkqIYhFJYVvPK8fh
 AEQWpi/vXXcYsHglQ7Kyx/MnRm9wBkNXymkI6i57w4biCMl/DohgZ1+2OBt0SXx2t0+GM4Pw99X
 W+eJCHDjX++rzwHZxqLCo+p+/VOZXbwtD4M5qn6XhxdmTTRfjUoCyLeFuoCDHQ8qAUzefu4wYm5
 IM0dj5x+AKkA2l+1kWcGsa5xtsAFzuuESycb3Z1KDx5lHgFN58wrCEsm5v2HYxJIzrWOBu3T44/
 3EPpdi+XpzgQrA9b6D5o=
X-Received: by 2002:a05:6830:3745:b0:7e9:e488:3bce with SMTP id
 46e09a7af769-7f4f22bd9c3mr37988985a34.6.1788282585777; 
 Tue, 01 Sep 2026 10:09:45 -0700 (PDT)
Received: from [127.0.1.1] (184-96-151-165.hlrn.qwest.net. [184.96.151.165])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa99d927sm10892218a34.19.2026.09.01.10.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:09:45 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 01 Sep 2026 11:09:00 -0600
Subject: [PATCH v2 06/10] net: lwip: add an HTTP client abort operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-submit-lwip-runtime-netconsole-v1-v2-6-3e3d95627cf9@gmail.com>
References: <20260901-submit-lwip-runtime-netconsole-v1-v2-0-3e3d95627cf9@gmail.com>
In-Reply-To: <20260901-submit-lwip-runtime-netconsole-v1-v2-0-3e3d95627cf9@gmail.com>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 Luca Jones <ljones@t0.technology>, Weijie Gao <weijie.gao@mediatek.com>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, Simon Glass <sjg@chromium.org>, 
 Vincent Jardin <vjardin@free.fr>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The HTTP client has no public way to cancel a request. Returning from
wget while DNS or TCP work remains pending can therefore leave callbacks
referencing its released command state.

Track pending DNS resolution and add httpc_abort(). The operation removes
a pending DNS callback, detaches the HTTP callbacks and immediately
aborts the altcp connection. Report a local abort through the normal
result callback.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 lib/lwip/lwip/src/apps/http/http_client.c         | 71 ++++++++++++++++++++---
 lib/lwip/lwip/src/include/lwip/apps/http_client.h |  1 +
 2 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/lib/lwip/lwip/src/apps/http/http_client.c b/lib/lwip/lwip/src/apps/http/http_client.c
index 1973e79e723..2bc2a0db97e 100644
--- a/lib/lwip/lwip/src/apps/http/http_client.c
+++ b/lib/lwip/lwip/src/apps/http/http_client.c
@@ -146,15 +146,23 @@ typedef struct _httpc_state
   u32_t rx_content_len;
   u32_t hdr_content_len;
   httpc_parse_state_t parse_state;
+#if LWIP_DNS
+  u8_t dns_pending;
+#endif
 #if HTTPC_DEBUG_REQUEST
   char* server_name;
   char* uri;
 #endif
 } httpc_state_t;
 
-/** Free http client state and deallocate all resources within */
-static err_t
-httpc_free_state(httpc_state_t* req)
+#if LWIP_DNS
+static void httpc_dns_found(const char* hostname, const ip_addr_t *ipaddr,
+                            void *arg);
+#endif
+
+/** Free http client state and detach its connection callbacks */
+static struct altcp_pcb *
+httpc_detach_state(httpc_state_t* req)
 {
   struct altcp_pcb* tpcb;
 
@@ -168,16 +176,26 @@ httpc_free_state(httpc_state_t* req)
   }
 
   tpcb = req->pcb;
-  mem_free(req);
-  req = NULL;
-
   if (tpcb != NULL) {
-    err_t r;
     altcp_arg(tpcb, NULL);
     altcp_recv(tpcb, NULL);
     altcp_err(tpcb, NULL);
     altcp_poll(tpcb, NULL, 0);
     altcp_sent(tpcb, NULL);
+  }
+  mem_free(req);
+  return tpcb;
+}
+
+/** Free http client state and deallocate all resources within */
+static err_t
+httpc_free_state(httpc_state_t* req)
+{
+  struct altcp_pcb* tpcb;
+
+  tpcb = httpc_detach_state(req);
+  if (tpcb != NULL) {
+    err_t r;
     r = altcp_close(tpcb);
     if (r != ERR_OK) {
       altcp_abort(tpcb);
@@ -202,6 +220,38 @@ httpc_close(httpc_state_t* req, httpc_result_t result, u32_t server_response, er
   return ERR_OK;
 }
 
+/** Abort an HTTP client request. */
+err_t
+httpc_abort(httpc_state_t *req)
+{
+  struct altcp_pcb *tpcb;
+
+  if (req == NULL) {
+    return ERR_ARG;
+  }
+
+#if LWIP_DNS
+  if (req->dns_pending) {
+    dns_cancel(httpc_dns_found, req);
+    req->dns_pending = 0;
+  }
+#endif
+
+  if (req->conn_settings != NULL) {
+    if (req->conn_settings->result_fn != NULL) {
+      req->conn_settings->result_fn(req->callback_arg,
+        HTTPC_RESULT_LOCAL_ABORT, req->rx_content_len, 0, ERR_ABRT);
+    }
+  }
+
+  tpcb = httpc_detach_state(req);
+  if (tpcb != NULL) {
+    altcp_abort(tpcb);
+  }
+
+  return ERR_OK;
+}
+
 /** Parse http header response line 1 */
 static err_t
 http_parse_response_status(struct pbuf *p, u16_t *http_version, u16_t *http_status, u16_t *http_status_str_offset)
@@ -447,6 +497,7 @@ httpc_dns_found(const char* hostname, const ip_addr_t *ipaddr, void *arg)
 
   LWIP_UNUSED_ARG(hostname);
 
+  req->dns_pending = 0;
   if (ipaddr != NULL) {
     err = httpc_get_internal_addr(req, ipaddr);
     if (err == ERR_OK) {
@@ -479,9 +530,13 @@ httpc_get_internal_dns(httpc_state_t* req, const char* server_name)
   if (err == ERR_OK) {
     /* cached or IP-string */
     err = httpc_get_internal_addr(req, &req->remote_addr);
-  } else if (err == ERR_INPROGRESS) {
+  }
+#if LWIP_DNS
+  else if (err == ERR_INPROGRESS) {
+    req->dns_pending = 1;
     return ERR_OK;
   }
+#endif
   return err;
 }
 
diff --git a/lib/lwip/lwip/src/include/lwip/apps/http_client.h b/lib/lwip/lwip/src/include/lwip/apps/http_client.h
index d39e1bf829a..3f62150dca1 100644
--- a/lib/lwip/lwip/src/include/lwip/apps/http_client.h
+++ b/lib/lwip/lwip/src/include/lwip/apps/http_client.h
@@ -143,6 +143,7 @@ err_t httpc_get_file(const ip_addr_t* server_addr, u16_t port, const char* uri,
                      altcp_recv_fn recv_fn, void* callback_arg, httpc_state_t **connection);
 err_t httpc_get_file_dns(const char* server_name, u16_t port, const char* uri, const httpc_connection_t *settings,
                      altcp_recv_fn recv_fn, void* callback_arg, httpc_state_t **connection);
+err_t httpc_abort(httpc_state_t *connection);
 
 #if LWIP_HTTPC_HAVE_FILE_IO
 err_t httpc_get_file_to_disk(const ip_addr_t* server_addr, u16_t port, const char* uri, const httpc_connection_t *settings,

-- 
2.53.0

