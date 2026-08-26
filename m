Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF5EC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 05:30:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35AF780C84;
	Wed, 26 Aug 2026 05:30:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cWjr86mlT8lp; Wed, 26 Aug 2026 05:30:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787722243;
	bh=8E2mRdmavLoQo26QKJCcQwyIQOHXXd3cmOULwif2dVY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H1sIim0GR+NUGmaO5gLOHwmxoEekOW43tzxOetgZskspAjA2QpTmfo7pUu7+HCTr6
	 yIIPdNX/O+oqwYMJ8TucSSR63RcATuL6xDgppJ50PYBgkOe1zPTjrPvjqesSxyCfoM
	 3DbnAo1BFnlBAXkHIs805YUpkscuwA+VrC6Kni+ygFKHdQemfn85at5/HXr0CNid3z
	 D7ctVSSeqKZSKAbp71xAbmCTDKlWBIq8KJiXzcqpEQm+o5ZhwWW9lYGZAg1yrN50MV
	 laAJbzsuoOs4J51bU6WMkDRanaOHZ6F4z/KKx39zb1CO/hOeXrC/zrZrzFrFu/8Fwq
	 KfDcr9LlKqYvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E65C580CA8;
	Wed, 26 Aug 2026 05:30:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D66FC2FD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC5264054C
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Xh94strj5z8 for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 05:30:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ddb+Fr2I
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 14A514054B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 05:30:32 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4b28db31b89so570677b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787722231; x=1788327031;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8E2mRdmavLoQo26QKJCcQwyIQOHXXd3cmOULwif2dVY=;
 b=ddb+Fr2IziiCEhgPLtr2hRJuUZFQxKf4SlwcdX6L4Qz8ltRYwQtnTgG+HazHnbirk3
 5ncVsZZZsAIemsH9IyaDOGJG7IGvdOhgu4JGOYctxv/Dm/5LjUFlTv0gNn30uGsSgnVf
 cUcO2XuWBU9L9LUOZDUtsAe8FDYJATF1Q26pakmoxxhn7YFPJKpI4dAIzJFXQ7QEcsQG
 qAAarppXyDkIpBF1RP8l03xm9hzuASmNXm8pxUL71HP4L3W6wflibZ9bRapRbuFyMKNx
 2J/kulT7uVhS4ws0oQNtnA/pNMMiSLKCPzPtwQWVkU0E8/+mHE4r0A4oXfhWS3dKBWWR
 RpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787722231; x=1788327031;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8E2mRdmavLoQo26QKJCcQwyIQOHXXd3cmOULwif2dVY=;
 b=QKZKupDo1TXfaZw/SofCn7eyh/SGEnW1Obl272iFUFVKiKBs3q3MxC30sGFeVV5n3z
 uqz1TugVYkKdAAusMaFh+bso2giSFTBINpsbzN/oJEMxEoJI9efLCu5QemI14Gk1XhLX
 vMVl8R2sAfEb/9EHDUopEKLxOEB/7HLQLk53FwG5EhJNj9AvMX+GthKFpOGMKN1Y2AP0
 ox5aIp9X6FPprS3CwMaSK0KYvQs/wuslsmvigDKVEi7A1Hjq4fOIiggsSjLAK5+kWKdI
 jbMzH2KMRCazdSLIlVDN9WT2nn6XAodvESirNVBEvroe2pa9ABZA7d4NI33GUC7VeGrZ
 D7Fg==
X-Gm-Message-State: AFuF++lYzyMc04eB1rEYjWFKBEkstajUr3rC4AxAz2TMleVIuMHa3XtY
 ugu+EOS8w7ZEyzohtDHZ6px4RImYVwqIH0lZ30PxI9WGwiaVzKdBVYdV
X-Gm-Gg: AR+sD112YhY1DhVqd86C94A+X8qzy+PGEXGi3EU4FhqmhZGNJ2JcUDFPoj0B76QBdVi
 YqX+ZqisBWO9/HaDtBMxSCtE3t1tAyhxXUhB235dhoEW8L7Hu7sdT/VikYpEPFlB9wCUHvhju3G
 mrWBuT62WkAS/3k/kRSrL5H+jjeHe8qRjGId96+IUb7Qq35JZ9+soWrFmaq3kNwQBm1CKmcoF2V
 dObbS+YV3bptT0mmkMPWiQnKxpVTpechxDPPtRvxustVzHouKXhKFgqXZXeQuBK9jjgGZSWvfgt
 k0OonCCSV+cxWktcnWhdNNFvTVrDchgfRFGtanmR+WnLx2Ut+N8Vw7mP7ZlN5SNrZ1txHjsiMGE
 e+PB+xbp03ZnGwA1QCKb2VThy1Jtq8Achy9agJaYpsptmyHOx9Ut/T61uInvmM5IeufM3DTP/RJ
 k1OvaRktG+mE6SrM/CCATskH27hNbr+UCRyma1oo9paSnu5kNuWTmaAi087wGNN2USg1ZNOw3hH
 7FWBrEAhCY6fD9Ek4MUi38wulhg3zVRiheHwjTu37XK7RY5yVC7WHgvrO55Y52zbg8IE8TzwtJU
 16Ug+DOX8vYraMUSUZCmIkzxMUjZlfSjmivaOFIameYWTwmmDum0uweNrKIipEZSvcQxvlbU4RQ
 8IcaO9CvAfUfBAFP77jD3l8Eg
X-Received: by 2002:a05:6820:f02f:b0:6aa:d13c:a709 with SMTP id
 006d021491bc7-6b1a051cd62mr3582704eaf.31.1787722226584; 
 Tue, 25 Aug 2026 22:30:26 -0700 (PDT)
Received: from [127.0.1.1] (71-218-10-81.hlrn.qwest.net. [71.218.10.81])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-465b0243574sm1346401fac.15.2026.08.25.22.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 22:30:26 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 25 Aug 2026 23:29:44 -0600
Subject: [PATCH 05/10] net: lwip: allow DNS callbacks to be canceled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-submit-lwip-runtime-netconsole-v1-v1-5-0892966aa758@gmail.com>
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

