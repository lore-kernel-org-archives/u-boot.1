Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE148CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FEEA80BF4;
	Mon, 28 Sep 2026 22:36:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NQ-dminRoeOO; Mon, 28 Sep 2026 22:36:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7788C80BD3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634959;
	b=HcU58JDOwQW/+sOOzzSNH4YmS6T8JqhbYSlM8EvH83ULVLcqlxgK2VbV4Onbe2X7oUxv
	 aYhT+gIaIhf0zqI1CooW+9RYRYIdacvJmAwzuo7pIHcteBz7iZ6go2bfTOOxK1DBYSWAi
	 5oTpE83Nr/GI0nWhncUJL9fEuM9f2hkdy/2BqdvUnhhEwteXY5pGvJX+AFO1yPSyrj9Xi
	 73RgX3lBNYQpRIB2mWWS33N91sBGY+teI7NDQHGKjJTR3ZROrDOFeoNJVw7ToZumEJF+Q
	 03LcEL7qOKfb+itkszImGAQg71dJ0wUz0Fr37JpfOV5ASUdYiXbbNUYJpQMSWjWeZdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790634959;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Osh0Gagm0uRzjOniMUHZd9WfF0X3JAqTwkwSms3hA1U=;
	b=qeBxEyX3MAteYQkOEFFasCxeuNHqL+hr4jFkVeexSCbCMWw2h01iAK5Y79gOom0cYbZZ
	 gidCqIBGwGFp/TH4LRDHukOA63N//FYnXKF8+rGLDiW2OmJvL+IlHrVOT1x5WqvYm3CgE
	 EnKl66ElVkcySPWl52RJAzOm/exAyigiKcJX9Nlt9RDy9vqpfKJok81B/TZarw0b/xKau
	 9LCHlk6GT4of0Eq8fS3UtggnZuX8urwQeURCQpZfMofbzJmI+rDwMIBCUUfM4Xh/Qb6oe
	 6X8WYsvnowKlGSkHslE9GfIYFMuQDuFz866/7jpAa1bYlmESQxCeatpKylrKSDwV5CQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790634959;
	bh=Osh0Gagm0uRzjOniMUHZd9WfF0X3JAqTwkwSms3hA1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l0AWIFwAIUkszzp8rovHQxV3MgOgo3D4Q5ig7gg0ek4EPWhwV5nC/Bd5ZveEAwCs8
	 wN9mzbrJYfbHzdBAZCVx3sr2/KBhisiVnGLl4iJLPhn/vpfu0DkDcZTxhvbzd0BqFN
	 S2U2caP8PkkbVENjjApdtwt+tG3EW8XVqOSd3FLQGF4sS0Y6ONDNlZChglJxl/oADn
	 /gDDP318jSMECL2f/V2snC0Tmh3XEvvx5Wf/h+YCoiWhf6Qos44EAhkshSp1778gIx
	 xr4z5vKOKm95rzQAYYo7VrDG8/cErtNr7J+8MrJP5cvfVVqANVaRRtcNZSQK8Eq4eT
	 U2EJoVpx7bmMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7788C80BD3;
	Mon, 28 Sep 2026 22:35:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C5F17335
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ABE4B40090
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:35:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OgJPLtYeViqK for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:35:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 83F6C4008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:38::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790634955;
 b=h43VimigOWjixO2lxyNN8L8xyFeu54QPp0gzEZi3ZvF6mmqlQF36QXIvc9jr7JSSfIgE
 N//nIaHh+5hvJsfsWHpSvEFZS6l+y/pEuXFAh9E279rLeNKXpdlGQ1IG1UCE6z0uNM5Et
 15KiT8VLRSgGL+jmU4nnjTyemOZQiqNdh7OWpIvljZLyRaNsVAPqXbnELLDWLVjTt4TM8
 d9i1HDJvGqUo5fbNm2lKlCZkaCBnEeowj3maz68llZMnNpGUQzSdKGAHnAeuNsknjkHGy
 zDxu7RsVZMR738EmCn1+o27UAoBvHq3nSuK+m76JEEK2gOSsHBGJVnOktiEUTlsYJug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790634955;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Osh0Gagm0uRzjOniMUHZd9WfF0X3JAqTwkwSms3hA1U=;
 b=N/uF8aHeqHmKdgTc6XI3Cqp1d2+d1s7wLNDLq7xQ4ZK5R5Od+mKY2OjoX1/B7VrAviJF
 MY+wHEW7lLxRmxyLSOTuWsgd9rKEU0sXufaQcZCbTa6discPMl4Z6pvKGOkZx/dhkKVLN
 Sp9TCf+LmKg6UphMMDvaSV4zYPzH6Qwwtf3566Ld6B6LaRc5EJnAt5+7+4BHB8fjhrBgG
 I1QnWrZMyD+AiG+TQ7JFmh5RkH2RgEExiFYDFmcf9KbjtQPD3aw3xjcYKdpR+/jbxo8xs
 gQhEpvlbiop2R6bAEXZSnaSTYBT/EDVgv/uOWevo/G2hlNjSTo3npcYdAgo4HZD3WCw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nr4NyD8l; 
 arc=none smtp.remote-ip="2a00:1450:4864:38::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:38::d;
 helo=mail-lr2-x0d.google.com; envelope-from=sochnev.v.74@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nr4NyD8l
Received: from mail-lr2-x0d.google.com (mail-lr2-x0d.google.com
 [IPv6:2a00:1450:4864:38::d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 83F6C4008A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:35:53 +0000 (UTC)
Received: by mail-lr2-x0d.google.com with SMTP id
 38308e7fff4ca-3a666ef8e49so14282301fa.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790634951; x=1791239751;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Osh0Gagm0uRzjOniMUHZd9WfF0X3JAqTwkwSms3hA1U=;
 b=nr4NyD8lRGMVMX9ZbTXtG9KMypDge+m9aMDgR4eVxCk5ln/ObuevKQsfcKcydH5cNo
 VCEBz05i9AaVFdwMUwx2qw7HZeG9BJbgTr7boNk0e8eOXIGLtJ24NIJF9Qf+xblwjyMT
 FCQsY1Gw+cpHH+shjRCQP8gNeB+XdFu/D01uIuOlMaVlRMit9nAcX2QHLSfRIwT3oDjS
 S8YNYUJYWcEYTZbPn6Y/uzYhQT2MiO2nzXUsQQ89q3PDBn7i5Pty+9pR4LZ2r0eqE9ZW
 tVN2ARzmb3yuEGdZPllZdguhilaVb6wwVbAGDv8BU43leP3/ht4PLozApCNtqycFCrmY
 Rveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790634951; x=1791239751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Osh0Gagm0uRzjOniMUHZd9WfF0X3JAqTwkwSms3hA1U=;
 b=GV4XYca3xIPyuz6kYxaQkZ1xybmRNimw956X8GuHouSts535cBLNZEegrCpfNF9ugf
 hVVjjcFDbULiV95jrLGfDE/CUgqf2y8IpbKoBXSJxkVCgDRW4zv3BwnIZteIZ/z5aVlx
 Gw6Nb+wHPUI/KmmbPcKRpAym+4XBRlEYaTSjAgFAgCIBWNCSrD25UcMvjXtX1OWZbv4O
 zPO+g9oKUPao66uyccHUMmZK/RxAfpzJwad2le8LbdzJz67WadhqtFXGV/TVTZdnwrog
 Q0WQwJ/Saa8+/63U1UGpWoJRyqR7RzxcfsAifIIGQ7kxduQgyZP559nus1F+3bi0Hr/k
 5T1A==
X-Gm-Message-State: AFq9FYIviNhFe5HjCa75ypOmpHzFDhdGuXL34JsjJhpqkLw66WLMj2da
 fdQUC4+FQV69rEAB/u5J5YVXLW1jU6EZZNVLKY9bMk4jiPeDfL76kQvpmjgMgyY=
X-Gm-Gg: AYBFou0XkKJBj3m5uap0MUB3RuK4odbGUXN12PgAvNcUYv5CXJUwMF2zSO4XyBVCzw9
 A63snwK0LAOhjVmuCuEnoLpugJHX5lVvF/P5Yss31uC3nVm5ZMG/SUUiLSCYRWLW57DwlsJn8Fv
 nqsyWPiW8LVQR2GA9dL8Quovm47TSIs2hv/9dFR0C9sr6HT2Wly6WyVRSO4lMyNWQaBjNXfEmiQ
 YchZnO7bOVRsG5kukCH9tmwUBhWArL38ykpEk4WLfipJ/294OJ7cHvrYrfu+Wa1qpkSOLRybHQP
 f7WHzH6RBBpKlIgE/V8imnXbNOqub5LARXYVQJF+XStuD/JX3+nvAKmWSbe5FnqqNbp+1IcNtkI
 OjYDiYEsaH9uWQK7E/JtedId1OWTS+/zfgq0A7ggPXEcMnoVIU7Ej7IQ4sNXBFaBZHs7KkWGZTN
 LUuJwvFvq44m9HbuG8jQcgq66g5siJ738tObWLFRT+uOswfullPFVJk3jR7ppjK5wKK6a3xKQ=
X-Received: by 2002:a05:6512:2206:b0:5b8:f614:c6f1 with SMTP id
 2adb3069b0e04-5b8f614c965mr1856964e87.49.1790634951552; 
 Mon, 28 Sep 2026 15:35:51 -0700 (PDT)
Received: from fedora ([46.8.219.5]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b9deba80c6sm863466e87.28.2026.09.28.15.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 15:35:51 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: u-boot@lists.u-boot-project.org,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [RFC PATCH 1/4] net: lwip: add an httpd stop operation
Date: Tue, 29 Sep 2026 01:35:29 +0300
Message-ID: <20260928223532.482192-2-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928223532.482192-1-sochnev.v.74@gmail.com>
References: <20260928223532.482192-1-sochnev.v.74@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The lwIP httpd has no way to stop: its listening PCB and callbacks
outlive the caller. With the shared lwIP runtime the server would keep
accepting connections while any other client polls the network.

Add httpd_deinit(), which aborts the open connections and closes the
listening PCB. Open connections are only tracked with
LWIP_HTTPD_KILL_OLD_ON_CONNECTIONS_EXCEEDED.

With SO_REUSE, set SOF_REUSEADDR on the listening PCB: connections
closed by the server stay in TIME-WAIT and would make the next bind
fail.

Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 lib/lwip/lwip/src/apps/http/httpd.c         | 51 ++++++++++++++++++++-
 lib/lwip/lwip/src/include/lwip/apps/httpd.h |  1 +
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/lib/lwip/lwip/src/apps/http/httpd.c b/lib/lwip/lwip/src/apps/http/httpd.c
index 9477e855e..745477272 100644
--- a/lib/lwip/lwip/src/apps/http/httpd.c
+++ b/lib/lwip/lwip/src/apps/http/httpd.c
@@ -98,6 +98,7 @@
 
 #include "lwip/altcp.h"
 #include "lwip/altcp_tcp.h"
+#include "lwip/tcp.h"
 #if HTTPD_ENABLE_HTTPS
 #include "lwip/altcp_tls.h"
 #endif
@@ -345,6 +346,9 @@ static char *http_cgi_params[LWIP_HTTPD_MAX_CGI_PARAMETERS]; /* Params extracted
 static char *http_cgi_param_vals[LWIP_HTTPD_MAX_CGI_PARAMETERS]; /* Values for each extracted param */
 #endif /* LWIP_HTTPD_CGI */
 
+/** listening PCB set up by httpd_init(), closed by httpd_deinit() */
+static struct altcp_pcb *httpd_listen_pcb;
+
 #if LWIP_HTTPD_KILL_OLD_ON_CONNECTIONS_EXCEEDED
 /** global list of active HTTP connections, use to kill the oldest when
     running out of memory */
@@ -2658,7 +2662,7 @@ http_accept(void *arg, struct altcp_pcb *pcb, err_t err)
   return ERR_OK;
 }
 
-static void
+static struct altcp_pcb *
 httpd_init_pcb(struct altcp_pcb *pcb, u16_t port)
 {
   err_t err;
@@ -2673,6 +2677,7 @@ httpd_init_pcb(struct altcp_pcb *pcb, u16_t port)
     LWIP_ASSERT("httpd_init: tcp_listen failed", pcb != NULL);
     altcp_accept(pcb, http_accept);
   }
+  return pcb;
 }
 
 /**
@@ -2694,9 +2699,51 @@ httpd_init(void)
 
   /* LWIP_ASSERT_CORE_LOCKED(); is checked by tcp_new() */
 
+#if SO_REUSE
+  {
+    /* rebind while connections of a previous run are in TIME-WAIT */
+    struct tcp_pcb *tpcb = tcp_new_ip_type(IPADDR_TYPE_ANY);
+    if (tpcb != NULL) {
+      ip_set_option(tpcb, SOF_REUSEADDR);
+#if LWIP_ALTCP
+      pcb = altcp_tcp_wrap(tpcb);
+      if (pcb == NULL) {
+        tcp_close(tpcb);
+      }
+#else /* LWIP_ALTCP */
+      pcb = tpcb;
+#endif /* LWIP_ALTCP */
+    } else {
+      pcb = NULL;
+    }
+  }
+#else /* SO_REUSE */
   pcb = altcp_tcp_new_ip_type(IPADDR_TYPE_ANY);
+#endif /* SO_REUSE */
   LWIP_ASSERT("httpd_init: tcp_new failed", pcb != NULL);
-  httpd_init_pcb(pcb, HTTPD_SERVER_PORT);
+  httpd_listen_pcb = httpd_init_pcb(pcb, HTTPD_SERVER_PORT);
+}
+
+/**
+ * @ingroup httpd
+ * Stop the httpd: close the listening PCB set up by httpd_init() and abort
+ * all open connections, so that no httpd callback runs afterwards.
+ * Open connections are only known with LWIP_HTTPD_KILL_OLD_ON_CONNECTIONS_EXCEEDED.
+ */
+void
+httpd_deinit(void)
+{
+#if LWIP_HTTPD_KILL_OLD_ON_CONNECTIONS_EXCEEDED
+  /* this also unlinks the http_state from the list */
+  while (http_connections != NULL) {
+    http_close_or_abort_conn(http_connections->pcb, http_connections, 1);
+  }
+#endif /* LWIP_HTTPD_KILL_OLD_ON_CONNECTIONS_EXCEEDED */
+  if (httpd_listen_pcb != NULL) {
+    altcp_accept(httpd_listen_pcb, NULL);
+    altcp_close(httpd_listen_pcb);
+    httpd_listen_pcb = NULL;
+  }
 }
 
 #if HTTPD_ENABLE_HTTPS
diff --git a/lib/lwip/lwip/src/include/lwip/apps/httpd.h b/lib/lwip/lwip/src/include/lwip/apps/httpd.h
index 1ecdd743c..e6ddd023d 100644
--- a/lib/lwip/lwip/src/include/lwip/apps/httpd.h
+++ b/lib/lwip/lwip/src/include/lwip/apps/httpd.h
@@ -243,6 +243,7 @@ void httpd_post_data_recved(void *connection, u16_t recved_len);
 #endif /* LWIP_HTTPD_SUPPORT_POST */
 
 void httpd_init(void);
+void httpd_deinit(void);
 
 #if HTTPD_ENABLE_HTTPS
 struct altcp_tls_config;
-- 
2.55.0

