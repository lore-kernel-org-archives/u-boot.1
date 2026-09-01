Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2016DC61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 17:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F17480E62;
	Tue,  1 Sep 2026 17:09:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cjkSKCbdtD3q; Tue,  1 Sep 2026 17:09:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788282592;
	bh=8E2mRdmavLoQo26QKJCcQwyIQOHXXd3cmOULwif2dVY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LNSjXNu9Vc5hTudhNxPYKJrpGIJprcDWAkr+Boysrpgb53gaNPmXxr0RZEIpRz0LE
	 hm3uDbz+cGW4A0RnlAjM3lq6ddBClUdolwSRsNTSOxZH9ZiLPl95AXJKDyOdcVRQr5
	 bwZsvSj045ExAy2Z32DSGSZeSWD4CZXVTg+klxDpzj8E5Yjr3hZoQSXnPH0KaIGXje
	 /CbMqLcWbTvn3cp8XOprmyIW6mPP/8GOa/Vk1C8GI4PUrFWRsU+Y2/tlSfZ39DqjCi
	 05hIhI6SYbFqRd0HsVr03imd2+Z4KellHQ5DZwPW247vr5p6eULzchLubsKd4BfJ88
	 Xtv0nGSmUwP0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3437680E4B;
	Tue,  1 Sep 2026 17:09:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 885452FD
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7717780E2D
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r6sUMCmue-OD for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 17:09:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Te/vID5Y
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF4E080DDE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:46 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7f4f3683fbcso91155a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 10:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788282585; x=1788887385;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8E2mRdmavLoQo26QKJCcQwyIQOHXXd3cmOULwif2dVY=;
 b=Te/vID5YEwrfmO2HBYvLPLzBgzvGLv7hTsrQXRLzWmDjpJRHqxcrX+GBV+CsgDlW65
 uYW6AiDXYjjZZ3blwRgcwqsvj2heiXZ1Iy+rBSOyFMA+dUh/2jARnD0GDdTsM4gThNqw
 znzLkYkMTprknwUTAh8MGFlAFp6ts/PBwFi4wFINFG2fAGOyaWrT7h5l2VBWyLXrfobr
 lqK2czsWXozdVJaEsXvJKT0rhav0UFejo9+bSgN4b+iYDqML/K2SvYwE0WAJisfnhR22
 F8Q33LXVXoNa+gZuIWt9nrzfcUIZntFiKToi3Ohdl57YLdcPGkm3qfIKrFHsvVnBhhb8
 N0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788282585; x=1788887385;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8E2mRdmavLoQo26QKJCcQwyIQOHXXd3cmOULwif2dVY=;
 b=Y/Gc9p23WevZLAIK6KmL1GXs6jcu8bvCNt0ET1qCNZGAIT9XCcn5trvOjkec4CgHhb
 4ttAEELCSLrkSi+JHA7vKCDK7YrS0GqCqneYt1zQJk+5rCCpXWpD3i5DqG24Sxlf5UQN
 4W/22Ld3s1VjuBFz0NxHYf/8EFZ9UBNJ0CY5y/1WACIdy93jMW+CIM6DAJzwTEhNb3wV
 tN3lT+xal7AJxfXzNlZK0Z50ejwdgpdnHHh/LrzRj34egEknSX+YTAos4vY0XZwEk/SE
 BMny1XLrN/Ed9fFsgTO6REThQ083l6tsuGmeZF7qqJ0YkzHi5dCLVyyQVWF1f2vicR5P
 5vvg==
X-Gm-Message-State: AFuF++k8ORbg+3qJkIsK/QHTKkoBwVpJyY0Wz7yQ4K6E+8egZBAYWjU2
 IlTe0pTl68cou/gr2ZK8f6vENY0rsVX9TbgOuAToKQv4edGbEuMpPkLW
X-Gm-Gg: AR+sD11BruS742ftEkNlMUAhR/c4EcMSihAXmuHcenne4NhLVrMVBv0Cr1twrv+6/e2
 fEYCokHJCeriGp97Ns1vTLUlFYVW7b1lTbyEhdz6wJk9KnpXRCCjtyGgGitt/wq7pAei0URU1Dw
 efXSqivNMsCqh0efXJI7yeHh5LOaoKjJYpbk1O4sTCIn145yuAiDN96eM9oa279+mm22ZMvB22r
 FO9T05rQ9FPIubvUC00o0fEKW5d/ejlv8bgiAknGqAGzHd+fTzHTwpPu2FIjD9a6YcL6cgZAFot
 BajY9NtWn0HWo5sSlzmoIbr1W+UUnnibKQ4xRAkD0BX8KKTWi+j3oWvvvhXHwuHue4O8UnUt+pp
 NORHERs9QCzh6zn5a3zcCtSdcwN/eEQd20OerPoYm9Rs4r2OhG/cu7NPEPJzBbu71SOk7r5b/FU
 FSOQuQloGezxLiqT/8Sumr2IoXbTscUKg9xQ85J/oskH9MlusuZ6rfPfWVzwCpga6cMmLRkORog
 n9ROKUfIC/Rp7DL7fM7eQz/EssgfGO6V9KN0krEyp0ZmvJidG6/SLZn0CNDXu50u+0iR7WFen8I
 3s5pJoE4WZyHTkvWqQUv5YdIMUrNxxLslUtDyEDF8u8cBhP+4xsyU0zHBBS2/cblUY+g9pNJo+B
 qNRkjPHCWKDQeE5mj130=
X-Received: by 2002:a05:6830:3c81:b0:7e9:dc11:5920 with SMTP id
 46e09a7af769-7f68f756e5amr6032066a34.8.1788282584562; 
 Tue, 01 Sep 2026 10:09:44 -0700 (PDT)
Received: from [127.0.1.1] (184-96-151-165.hlrn.qwest.net. [184.96.151.165])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa99d927sm10892218a34.19.2026.09.01.10.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:09:44 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 01 Sep 2026 11:08:59 -0600
Subject: [PATCH v2 05/10] net: lwip: allow DNS callbacks to be canceled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-submit-lwip-runtime-netconsole-v1-v2-5-3e3d95627cf9@gmail.com>
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

A caller can stop waiting for a DNS result while the resolver keeps
the request and callback. If another lwIP client continues polling, that
callback can later use state which its owner has already released.

Add dns_cancel() to remove matching callbacks without canceling a
query shared by other callers. Use it when stopping SNTP so a pending
name lookup cannot outlive the client.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 lib/lwip/lwip/src/apps/sntp/sntp.c   |  3 +++
 lib/lwip/lwip/src/core/dns.c         | 26 ++++++++++++++++++++++++++
 lib/lwip/lwip/src/include/lwip/dns.h |  1 +
 3 files changed, 30 insertions(+)

diff --git a/lib/lwip/lwip/src/apps/sntp/sntp.c b/lib/lwip/lwip/src/apps/sntp/sntp.c
index 0e7f36520fa..a37699f65b7 100644
--- a/lib/lwip/lwip/src/apps/sntp/sntp.c
+++ b/lib/lwip/lwip/src/apps/sntp/sntp.c
@@ -711,6 +711,9 @@ void
 sntp_stop(void)
 {
   LWIP_ASSERT_CORE_LOCKED();
+#if SNTP_SERVER_DNS
+  dns_cancel(sntp_dns_found, NULL);
+#endif
   if (sntp_pcb != NULL) {
 #if SNTP_MONITOR_SERVER_REACHABILITY
     u8_t i;
diff --git a/lib/lwip/lwip/src/core/dns.c b/lib/lwip/lwip/src/core/dns.c
index 6540f143bac..5762647ee27 100644
--- a/lib/lwip/lwip/src/core/dns.c
+++ b/lib/lwip/lwip/src/core/dns.c
@@ -387,6 +387,32 @@ dns_getserver(u8_t numdns)
   }
 }
 
+/**
+ * @ingroup dns
+ * Cancel pending callbacks registered by dns_gethostbyname().
+ *
+ * DNS queries shared with other callers continue so their result can still be
+ * cached and delivered. Only callbacks matching both arguments are removed.
+ *
+ * @param found callback passed to dns_gethostbyname()
+ * @param callback_arg callback argument passed to dns_gethostbyname()
+ */
+void
+dns_cancel(dns_found_callback found, void *callback_arg)
+{
+  u8_t i;
+
+  LWIP_ASSERT_CORE_LOCKED();
+
+  for (i = 0; i < DNS_MAX_REQUESTS; i++) {
+    if ((dns_requests[i].found == found) &&
+        (dns_requests[i].arg == callback_arg)) {
+      dns_requests[i].found = NULL;
+      dns_requests[i].arg = NULL;
+    }
+  }
+}
+
 /**
  * The DNS resolver client timer - handle retries and timeouts and should
  * be called every DNS_TMR_INTERVAL milliseconds (every second by default).
diff --git a/lib/lwip/lwip/src/include/lwip/dns.h b/lib/lwip/lwip/src/include/lwip/dns.h
index 091341544f3..82579f09f35 100644
--- a/lib/lwip/lwip/src/include/lwip/dns.h
+++ b/lib/lwip/lwip/src/include/lwip/dns.h
@@ -111,6 +111,7 @@ err_t            dns_gethostbyname(const char *hostname, ip_addr_t *addr,
 err_t            dns_gethostbyname_addrtype(const char *hostname, ip_addr_t *addr,
                                    dns_found_callback found, void *callback_arg,
                                    u8_t dns_addrtype);
+void             dns_cancel(dns_found_callback found, void *callback_arg);
 
 
 #if DNS_LOCAL_HOSTLIST

-- 
2.53.0

