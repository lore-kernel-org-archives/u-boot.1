Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87776C5CFC1
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 23:05:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DED7608BF;
	Tue, 11 Aug 2026 23:05:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3B02DE7PT_yN; Tue, 11 Aug 2026 23:05:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 73746608B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786489502;
	bh=ZpLVsGiHpstsjvN8VcAep8q4kjM1KBZfmedJ0Wf3N3I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q504j/vZYUsU8Ia7vbYEkduL0q/LSALX++HXPK2tY5kocFaF2F9NaHcw9UPn6ePnm
	 JeuVQEPq7ax3YstdD+raVROEUHPsgAIe2IaWwJMyvyymgjR9kFge7oa4YTjOXxJyDx
	 t21clyHoT686vJ0TFzRLsgZCDH+KUkV5C384itu1aSFnCEgaaBB4FVzlOeqHSRYmZN
	 NYj/zVOJjrveD0BrKR+r+0F0n0qMtlMrJB/bkEAaEOGanT566aP6cempN48Liwy3z3
	 6ptCoWbQF2u7Sh5HxqaB1c9D1LGG/obAw1x+Z1X5EKw7JA11Fr2oubj0tDITgs0ej0
	 oNmZY3yg9KMXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73746608B9;
	Tue, 11 Aug 2026 23:05:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CDD852E0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 19:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D59D7810FC
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 18:55:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TXXfajaQ7PsF for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 18:55:33 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22c; helo=mail-lj1-x22c.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C603F810F4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C603F810F4
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C603F810F4
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 18:55:32 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-39fa5e3a428so1766911fa.1
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 11:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786474530; x=1787079330;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZpLVsGiHpstsjvN8VcAep8q4kjM1KBZfmedJ0Wf3N3I=;
 b=NxiXiAZ0H3JVaEN0Z6ck9y9pG2pydoCfbU3BtCV8MLQ/ZdrHeB4IdQGfa8+zC4P9AR
 dXPOcCqHvNmibOgJuQuH3lnKXl97YGKZKBtR9gOp1daOyxPksfro08yf+jBHqwxraTDu
 VEJ9NMbEsqiCODTp6QzEfXPeZB5Sbqt2lbiaFFkEoBvFLXMM579gmFjEQzbIwR+qfIxe
 1tFmg1lNFV0Wq7NTL3QIWKV/HM0PFyPw/JNXEUvwKEoPQY76pFoAtxJo0iSUb6P4T+kt
 KX4eA1SQzW8mfupXFrKtLZrmTeJV+NhBNnMfPnk6jDPePk9yraIuybluMLOyXnXMUvlf
 JtTQ==
X-Gm-Message-State: AOJu0YzCF5jkn1QS69GPVkeaHVzZg2pJEQGD+lw6wVD2HR+4mUI1H4h/
 axhUiltAvlt9rPTPTfF0IawjZaqsu/nE8llNkh0fP2E00ti+DrhxJU4QPhRAJTib6Uw8ziHwyj2
 lkumRcQQ=
X-Gm-Gg: AR+sD11RF3x1MnMc47+DOlutLAN56XaH36W8uZSP9oS4/20R5Lzmvd0UggZN32le7VR
 i61LgrLQH75cqLhVretZdb1jTPKZlyWB8iVoiF2D+OhSRWW41m0ItfBNF8uAsLBKysFTc8qEK1F
 /bk03KTAQUTEx5tmqOjj5GMeoal5h/gc4CDvzMXzNepjXKceiLXquALWkjAf7W/7czTt6qpYAt0
 +dEqbsqI1XnAaLo11l3wup2STnk7BsBeh+xwyp9YeXk57p1uk7UZDuMHkYQIAqeF5AKxwfRQ00O
 ED2aF8sUfZMn7Il4Q+iTwK4cwOhUf9u0ODn9b5fXxs/59shL/O4AqPhqxS29T1oJy8VNLqwS6LB
 w2KWRWCa5zyTG5VbJjOTFtY3xM77//QJO1c9BeGgdGIAM1ToXN6GUzhFEn4NIZvk+E0M/JspLgw
 NYEZW+HooTDTlX20SCTbo76wo85AYR5/6uyrWEHF54OdwvArwguQYajZK8ZynelXj2CpIQbjPtB
 qZLwDvix7dt6gMwl4u5uaIicY+RrfTlVfMJotWON8kbQ0k4R2XYB+gIBHwhT3PO
X-Received: by 2002:a05:6402:5047:b0:698:4501:3a8e with SMTP id
 4fb4d7f45d1cf-6a36d7c7046mr940093a12.9.1786474113735; 
 Tue, 11 Aug 2026 11:48:33 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f001cf8ed71865ce089.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:1cf8:ed71:865c:e089])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a362ec88f5sm950529a12.19.2026.08.11.11.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 11:48:33 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Tue, 11 Aug 2026 20:48:14 +0200
Subject: [PATCH 3/3] net: lwip: dns: free the callback context after an
 aborted lookup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-lwip-httpc-uaf-v1-3-9f0ba7331dea@byteray.co.uk>
References: <20260811-lwip-httpc-uaf-v1-0-9f0ba7331dea@byteray.co.uk>
In-Reply-To: <20260811-lwip-httpc-uaf-v1-0-9f0ba7331dea@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 11 Aug 2026 23:05:00 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786474530; x=1787079330;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZpLVsGiHpstsjvN8VcAep8q4kjM1KBZfmedJ0Wf3N3I=;
 b=mrkXi3oaOnby27xX28pTqPbM7p3omwdn8OeFBAv8jHi6rlbCQLRVbR/dfZdpF059Nr
 k/Obz6+l6SLCpSE0YRuIXTYd7S/SnsV2GSYY4s9vJH1MTiuDtS8ydfhJv5kYAk1TlXyW
 ZVQ3QPfOGCSpNGM65ULLJfy+nJw0cp63JEadc5TgJvl1v4pLpWJVpbLuvzZJ1NlJ41IG
 ZVT8kFicwKAKhBZ4d0OQVqdK/Gu5m2EL2lg+8hznGQKlgtrry5B9+0nBmBuVTcCxIQrg
 fcV40DAlOaNLCq0SNRWtg0RAUpv4cnso/7VFa/+iOpAMVT+7G2nlsnVgTdF3iL2ikykf
 Hpeg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=mrkXi3oa
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

do_dns() keeps its dns_cb_arg on the stack and registers its address as
the dns_gethostbyname() callback argument. lwIP has no way to cancel a
pending lookup, so if the command is interrupted or times out while the
name is still resolving, dns_cb() fires later and writes the result into
the stack frame that has since been reused.

Allocate dns_cb_arg on the heap and add an 'abandoned' flag. If the
lookup did not complete, hand ownership to dns_cb(), which frees the
context when it eventually fires; otherwise free it before returning.

Fixes: aedcfec9ed78 ("net: lwip: add dns command")
Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 net/lwip/dns.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/net/lwip/dns.c b/net/lwip/dns.c
index b620b0611d6..e93720963b8 100644
--- a/net/lwip/dns.c
+++ b/net/lwip/dns.c
@@ -4,6 +4,7 @@
 #include <command.h>
 #include <console.h>
 #include <env.h>
+#include <malloc.h>
 #include <lwip/dns.h>
 #include <lwip/timeouts.h>
 #include <net.h>
@@ -15,6 +16,7 @@
 struct dns_cb_arg {
 	ip_addr_t host_ipaddr;
 	bool done;
+	bool abandoned;
 };
 
 static void do_dns_tmr(void *arg)
@@ -26,6 +28,12 @@ static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
 {
 	struct dns_cb_arg *dns_cb_arg = arg;
 
+	/* Late callback for an abandoned lookup: reclaim and stop. */
+	if (dns_cb_arg->abandoned) {
+		free(dns_cb_arg);
+		return;
+	}
+
 	dns_cb_arg->done = true;
 
 	if (!ipaddr)
@@ -36,7 +44,7 @@ static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
 
 static int dns_loop(struct udevice *udev, const char *name, const char *var)
 {
-	struct dns_cb_arg dns_cb_arg = { };
+	struct dns_cb_arg *dns_cb_arg;
 	struct netif *netif;
 	const char *ipstr;
 	ip_addr_t ipaddr;
@@ -52,18 +60,22 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
 		return CMD_RET_FAILURE;
 	}
 
-	dns_cb_arg.done = false;
+	dns_cb_arg = calloc(1, sizeof(*dns_cb_arg));
+	if (!dns_cb_arg) {
+		net_lwip_remove_netif(netif);
+		return CMD_RET_FAILURE;
+	}
 
-	ret = dns_gethostbyname(name, &ipaddr, dns_cb, &dns_cb_arg);
+	ret = dns_gethostbyname(name, &ipaddr, dns_cb, dns_cb_arg);
 
 	if (ret == ERR_OK) {
-		dns_cb(name, &ipaddr, &dns_cb_arg);
+		dns_cb(name, &ipaddr, dns_cb_arg);
 	} else if (ret == ERR_INPROGRESS) {
 		start = get_timer(0);
 		sys_timeout(DNS_RESEND_MS, do_dns_tmr, NULL);
 		do {
 			net_lwip_rx(udev, netif);
-			if (dns_cb_arg.done)
+			if (dns_cb_arg->done)
 				break;
 			if (ctrlc()) {
 				printf("\nAbort\n");
@@ -75,15 +87,27 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
 
 	net_lwip_remove_netif(netif);
 
-	if (dns_cb_arg.done && !ip_addr_isany(&dns_cb_arg.host_ipaddr)) {
-		ipstr = ipaddr_ntoa(&dns_cb_arg.host_ipaddr);
+	/*
+	 * A started lookup that never completed may still be pending in lwIP
+	 * and reference dns_cb_arg. Hand ownership to dns_cb, which frees it
+	 * when it eventually fires, instead of freeing it here.
+	 */
+	if (ret == ERR_INPROGRESS && !dns_cb_arg->done) {
+		dns_cb_arg->abandoned = true;
+		return CMD_RET_FAILURE;
+	}
+
+	if (dns_cb_arg->done && !ip_addr_isany(&dns_cb_arg->host_ipaddr)) {
+		ipstr = ipaddr_ntoa(&dns_cb_arg->host_ipaddr);
 		if (var)
 			env_set(var, ipstr);
 		else
 			printf("%s\n", ipstr);
+		free(dns_cb_arg);
 		return CMD_RET_SUCCESS;
 	}
 
+	free(dns_cb_arg);
 	return CMD_RET_FAILURE;
 }
 

-- 
2.43.0

