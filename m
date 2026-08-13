Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9509DC5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 17:59:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5945140C42;
	Thu, 13 Aug 2026 17:59:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kv5zoxvUQYwB; Thu, 13 Aug 2026 17:59:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CBD9D40C28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786643974;
	bh=ZpLVsGiHpstsjvN8VcAep8q4kjM1KBZfmedJ0Wf3N3I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g/j608XtezLPU4/H+EznPy6v+6lk/b3xcyIBHaoNaPygvczqtI0sGQa63tnzTs5I7
	 /d6qvH3mS2fqFr7b0CTBWVcJioQkRSbR7302M0Fr7ayj9bYmC8su1hK9AnabFnnQrT
	 qsfXq+j1XT398lC8fd3BvBK/63AVrBQcFygauxnsg3WX2f12xIViHPjiIbQXGB9Rwb
	 AHVxn1OiXrHaAFzbBjYD+RRO5ccluhdiUEY8cUj6QHde7TF4/2NyhPlpzATh5IR5g7
	 BSkTD5bfzwh3/TasjCR3Vv2IGknAlbpHAsKk4U/l0LftI37yGXBo+5OvuVI+zNTnwQ
	 4TpuNPgQiEsqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBD9D40C28;
	Thu, 13 Aug 2026 17:59:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 43885357
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:28:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2A44240158
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:28:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2mOG3XU2rlg9 for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 16:28:41 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4432C4016A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4432C4016A
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4432C4016A
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:28:41 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a18840e2abso1778158a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 09:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786638519; x=1787243319;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZpLVsGiHpstsjvN8VcAep8q4kjM1KBZfmedJ0Wf3N3I=;
 b=YqQrr7BTGjoiaKE/zW7R9dHnIPNIFS8M97tPLsxr/idjZT4LSpkzjMB2olSfkAACt1
 Gz3fHhnWFgEPXSpx8z254M4Vol5+xww9EnEEb7CKaz+oH1TVnUEEyCMH7QWo4t6aSH3A
 qmvMBjvvOL94gXLs0lmGs9YLtjWCbQFG+kBxAB89OR02g4Rdx15tj6h93wWJC3lNoT+3
 SjtRozqn1bnvIeZ3Ns7vrWAgG2y8U11byxuHFF9opMZDKCn7X85azMT7p2jHVU31Jc/P
 CyXko6ZbzCq16/3oIN4EDDqibvTIggSroC49Yttg0rNJi1OmA3RWvpkY6PdKHZNTqz0d
 OzrQ==
X-Gm-Message-State: AOJu0Ywh3ffpcc6zeAKzqWtLPYVFYpsIK9nqC9uiPkX54uWXsj2DJjfQ
 Tl6rI8a75FdazSIO3IKm7iBbqSLOVgW3sRinEWUKVOwZilBG5Mbq7hMNWpm7kHgpVYQ=
X-Gm-Gg: AR+sD13CdX2u7AhrfRU0eNz/Si7JGJd7dMVnuWO5w0zg8I7zpT+mNs4Sf6z77DVf0do
 /fx6wJL5rwnj3DcFuiPWYTjmvbyaN9qZGCsfajnlTsQHS2Z0O3zylEExKmg3v1ZkU7bVB0tL44U
 lf59MFih42rpLZWSxJhff1ka5yGYpFiM6N+oiNC3I/7Rp3+XidP/NMKw6f44/eRi4Upi1ULgll1
 rh6OsdVcCH4wolNH/mgKm3n0r+P//vObcQV0HBhu+FjxDxWwqXUhK2NLgoM3mi1fa+Ydz9GWAMU
 8eGHV6VfE02Nea1wtqN7s6nkgjCWmX7luzXNM9PyDgThhVYzLqJ+RtHCYWmgb4A5qb7UQTcdWb2
 ZgZ40+sLgxn3m0LkAtGd09BOY8s81r6XroSX60r1ZXwFimMWfvvcVkd8D9fyCedoBwKUVnU5/Fs
 4nkt5yWV+2hU6VINpAlnF2EO379qq3VXy3nmx02a40h0Cy2qrUTrkq33DzCBHN+9/04Xhxoa2wI
 ykFMIYYTOzTXvTu37uQ8kLKp8mLgIpgUsIDkGnTAIWKoBynwMks
X-Received: by 2002:a05:6402:e0b:b0:698:8847:e2f8 with SMTP id
 4fb4d7f45d1cf-6a38060c289mr3721576a12.15.1786638519196; 
 Thu, 13 Aug 2026 09:28:39 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00b49b9d175e416b42.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:b49b:9d17:5e41:6b42])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a37f7f59afsm1139188a12.11.2026.08.13.09.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:28:38 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Thu, 13 Aug 2026 18:28:19 +0200
Subject: [PATCH v2 3/3] net: lwip: dns: free the callback context after an
 aborted lookup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-lwip-httpc-uaf-v2-3-1c3f0b3aa1eb@byteray.co.uk>
References: <20260813-lwip-httpc-uaf-v2-0-1c3f0b3aa1eb@byteray.co.uk>
In-Reply-To: <20260813-lwip-httpc-uaf-v2-0-1c3f0b3aa1eb@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 17:59:28 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786638519; x=1787243319;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZpLVsGiHpstsjvN8VcAep8q4kjM1KBZfmedJ0Wf3N3I=;
 b=AwZTRnfSYz5hh9g9V3GHCwg4p4eca8lqHV78XHANEXTglBXgunZxWQkOD6n38p/cF/
 r4HVA3dYd3E5oc/C3aK+zjDeeEMfsOgJfv74ZzTZCY4442CaC2VtQjnCY0/M0wbQd02a
 2rza7JZgGAfYV2CWcm79BxWyD2odpRSpTDikZlNG4ysSDSwDa96ep6Tg8Rd1y+y2Nw0t
 kBjvnBo/gVc2nYJxv4xfCwI07QbeScdMwixjUD5Gnm6xtw01SZ9EgOEpODWmqDvnykM7
 78K/AZavNhj2gM6NBi5s8bfmMwtJLaJFgxbP8cQvpFDO5oRmpdBghC7HVeEnT+E0rwUB
 or4Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=AwZTRnfS
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

