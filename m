Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DFAC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 05:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37CCF80C38;
	Wed, 26 Aug 2026 05:30:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S3pMXMeOxTr3; Wed, 26 Aug 2026 05:30:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787722237;
	bh=GG91exDkbJxW3sE81/CLe3y18QtiSmy5LYzVyP8TeHU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CWTzhxOM6f66hi7G1XXvjYxtSmyrz4mjZ2r9tPO2a7uymQNIvSKLMb2fm9adyFWK6
	 VpUM92fb3LDlPoPLcOOl7U95K4+whXJiRZBcHu1Sh+UTPgJYdGdW5B2DmQ5o3oEIzC
	 dwEca6+aM8v0aTAADIyoXQ6sucYnfGAxabEePnBGY9rWOLjoB6NHqOttriM7JrCuBy
	 1J1X1cAY0omTaoF+ORBtCEyhud2vVNPG6xHji1F/4d7sNtxWIdIezB246NJIbnOc4e
	 8fdDyUwY/sYpSxxbWBUVFPtz3ANUhCdJ8/ejVp/Ap5uqAs16Sfhnts45/hvYYDFFyV
	 UdKz0iQcE9onQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F14A080C44;
	Wed, 26 Aug 2026 05:30:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 043D439E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE9564054C
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eBqi2BSIPKMC for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 05:30:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=U8NoIGjb
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 164634054B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:29 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-44856d185bcso638233fac.3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787722228; x=1788327028;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GG91exDkbJxW3sE81/CLe3y18QtiSmy5LYzVyP8TeHU=;
 b=U8NoIGjbHhRhbQxd0Ub/zbsbYSOo5YTXlz+jfxwbiVb8EQCK1JU5ckY5LZ+HjnuGIR
 vabAruNab3QlnuNeuC1WIUtFVwW8D5+eLziMFKdzaZvCRRiQHTcuau4dBHN6mCqZ4GO5
 OWkf61iTSZDYimw5W6/y1x7RHHTk76SuHsNit3SSVxTf6p57289i0+Yz0dNeqsvJYeU5
 YAlqZlCfQ6BPHiPKNhiwRPBglm7q4uQq3d3SHBTS2YoAGJF0whXc5X7jcSMtiBAQCnYp
 6yQlH1rPg4RODssJA6S6C2zpNgJmUUSYMWvz1TBXTktiPMPvSNwWA2CkWzdUKdDkdNym
 cptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787722228; x=1788327028;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GG91exDkbJxW3sE81/CLe3y18QtiSmy5LYzVyP8TeHU=;
 b=VvjrgU+NK4enHhhjNNGKa1bAjINIyUp/8yYvqkGgJD9qQilHpn2aQSwnDimcMhOSJz
 ddlwQjWFs229HA8N8QfZXf68xsvdTOWmGJUHeRjUICcJde5nDWLNNEhU7/FPxlQOGW9i
 1qknucV40nSY3EqsU/XhtC2aobZ/alwLHvYVXuXI6RTug5pIVH5+DzRT30T9nJyqfhCC
 Um8MhRhxtMRo9W687xQWe5M/BwHDXErTYun2kfl2QE3BhpgVjml+o1YIpTl/zr3CiRQc
 +mxgpPKHhGGf8OZOqvFJtYYADxd/3r/1IBOVKzlElN1D2p9cDg7X7GzhzNwkqFMmt4w6
 av6g==
X-Gm-Message-State: AFuF++lstm9G6/3Cj8YMLYJ/qeFOw/4tdlZZYb2Ct2p4UiCqQmGY56W4
 hzXcc8tiI3uJdqULt8voNSmibRJK4KZ5Lf53w/QO+ZU+tQgEqMorMhZ1
X-Gm-Gg: AR+sD11Lcwxo780aZ+XmhcJmWy414YXAll4SurRPuZsP9i4F8Arc439DWDXq7MU1PCn
 eRfoqGarVNW7tp4wh/7waDx9n88hMsUmFZdjWz5TktLoaclScQlp20QtZHXMfXcYwTyVZBiPfo4
 gUP1HY7oVw8nkhex16cER4QL9rzbojywYZjGRHsBuJhd7FIP6JONzNAPjRqAc5VhnA32bUjP22n
 J30Nzv/bJ1fE/kvuvd9yoxsROFsMDCIhn3zuEjGWhl3TVYam0Na+9/SK8ZT6LJoM+oZ0IBX2LhG
 746z2fm5aXYs7W5O9+b9Z7Wu3FZgPBrQrjHoPRtq5yV7xwRJpKaRc0EzQI6dHe2dNaSk0SZ/AeB
 IYtOAOhgEo3WP4i9shroJ+AiIsv/AW1ZB4whvD7Ur4oQdJFoNVjbp0LjJMMNliOEyl+HRnqmdmm
 /QVc38kj/NDCinwdhYnP19o7Evcox2zhUuNfucvtwFd/grVvfJWr3uDmYm2bAr7+Iyc+TQRBvHC
 dFa6cN2WwQ+jfyG9mtmAZsemj+V+4J7M/0VWP3orst/kHc9SN73iHZrf/NVu5oohMfnyRSz8yJI
 fYPpfiYcVaCUxlNqNOok3VlgwsOF0xceDLfHZCYcHPIOfHMEPEBQZYZYBH9nua6WWkZv0ta2xZc
 DcsL4IaytpZRM/w==
X-Received: by 2002:a05:6871:4b17:b0:456:44dc:76a3 with SMTP id
 586e51a60fabf-46597c39ae4mr5021652fac.2.1787722227870; 
 Tue, 25 Aug 2026 22:30:27 -0700 (PDT)
Received: from [127.0.1.1] (71-218-10-81.hlrn.qwest.net. [71.218.10.81])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-465b0243574sm1346401fac.15.2026.08.25.22.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 22:30:27 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 25 Aug 2026 23:29:45 -0600
Subject: [PATCH 06/10] net: lwip: add an HTTP client abort operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-submit-lwip-runtime-netconsole-v1-v1-6-0892966aa758@gmail.com>
References: <20260825-submit-lwip-runtime-netconsole-v1-v1-0-0892966aa758@gmail.com>
In-Reply-To: <20260825-submit-lwip-runtime-netconsole-v1-v1-0-0892966aa758@gmail.com>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 Luca Jones <ljones@t0.technology>, Weijie Gao <weijie.gao@mediatek.com>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, Simon Glass <sjg@chromium.org>, 
 Vincent Jardin <vjardin@free.fr>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>
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

