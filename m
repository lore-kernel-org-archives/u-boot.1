Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703F6606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gXG+8K8b;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q94N9BE1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47D2960DA5;
	Wed, 11 Nov 2026 20:11:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id maXCNQE_HBeC; Wed, 11 Nov 2026 20:11:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B288B60DE9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427901;
	b=SlYghw5PCZJmHga9qjehLe7TI56iv+a9wyiiMWtmcIA6valtrzMFXQAfYGtg+r1hFYXh
	 TjjiHeUeLgveBBudbjgJMHIFviDpCOkZeTwsP9x5M5f/ms9b1PILAzJh0rmYMOrsORXAC
	 AHQ07IzsFxA7r56Ro6NGie07J17LHWew47nVIUFtumzkpP6YAblU+rd0fv9rML2wgEdpN
	 YYBszwfmR9DIcm3/u5RNPEnBPY0pvG80Om/8FzuFQSAZJQGouXRSOJMP6wOwwhXWuxsmL
	 HaSTL3Iw99djWCD71g+VqjuugkblrTcTSTyfrlhr4Eu1GsD3gcPTRLBO0I5ljMIftZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427901;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=L/N7dw5ZS1G0c8w0EMkdcLbweuIHwTjvEu4mWp45V1g=;
	b=SE18IGESTJ2/0dYITEzW7hgFXdvz8Mq1/s17LkkaTFfY7PNCiNg5dbS7dAHHHYzq4IMQ
	 nfc2UgmgxUPm59oIoD4JJXPe/rq1SSNBwQsYwRfj78d7Dq7ZDdYSdvtyWISGlCiGh1K3k
	 PYSPo4rX7VyDIC8DoVXhEpCMFn6vrAugRHutKlSdoWy6B9D+ubm3niVDm4C0eSj6HbWrA
	 Rc5aD3Hu+VWjiw3DnWHu47a8v5qnEBFIUQ4lcg6XbXL9qDmcfdQMLTQ4CG7Hl5oqgck6D
	 oMZ8L1ByEaZOf2MlxMBMwT3Qb8rO12bt0/s4xBjruBbKjFFqMPxiUJAziP2gGQQ+7Ww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427901;
	bh=L/N7dw5ZS1G0c8w0EMkdcLbweuIHwTjvEu4mWp45V1g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gXG+8K8bK+dHWuPwa41ZYAa36Y4WYb9L/Ad6vXTY4kA/2XaZP6gJpEvNveKwbmVZm
	 BSXyGl2XNTF2ACEjSnUECFoektqQ6fs46VcCIqR0AIuVetYX3U5kNZ5fGdMqczBjXt
	 9l6LwRQ7FtKfvaRxs8/oHfnDuX39PYRxMTDK8ndEpiUYriJQDWhwrKuxk48sjU0nVh
	 0UlGLOtZ71yQyKe9ZWk8iFKejM4dAg15Av3shk6zVTGhCcLHiAJP3wR6tAqwJxPMVC
	 H+fEHz5idIhmybZK+0wU9Xwnefsx8DEQh48+mbiUU+/hRFB41RLyBLxwecL+98Mx+e
	 kU6DBzRA6Evvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B288B60DE9;
	Wed, 11 Nov 2026 20:11:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 10643E09
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0229F40920
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j4R5eo-EVZ-L for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:11:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 399A9408F9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Q94N9BE1
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 399A9408F9
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:31 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-843b6f8e2c7so3678477a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794427891; x=1795032691;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L/N7dw5ZS1G0c8w0EMkdcLbweuIHwTjvEu4mWp45V1g=;
 b=Q94N9BE1VFCDnhZ9cHX4b/5PXq/y1i4yv0J/wLzWUHORiC6FJaqpc5IIwvt+UkDxu2
 oa7lC4zkGHn7Y5pcYa2dzU9ydIr/Lbw6TbwihjUTm7+A3PkibseQaEOqu24iIcGN1Gqw
 RS+FQWHS0yaSLHA7WB2laVKFC7X8On36eK1muW8mIZOusGaRtnCrCKr3BYB0eN4lGvrL
 WUUI5rjvBBPgZmzmNd6/u/MBAAnRrTasccHJa5ni5uoMqosvJpBZl3pZZFXqtBH3/6om
 3To6GyxL1rCmtmqj0FXoV9nEYg29RZZb9lzXM637aldziRbVDsAkXcqDcnXVQh1gz3tV
 ixEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427891; x=1795032691;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L/N7dw5ZS1G0c8w0EMkdcLbweuIHwTjvEu4mWp45V1g=;
 b=KI9+H7SSXUJvfxXxeKE0R2WGKW/I9aqEMAOTTus/4GIPPU0GTg80ObfkAs0DENdmDG
 9KkAlqgW2e0qPeDcCdCC8QzORZwwgrmsUuasgzgBQVl9n/+SUlHElbUZ/NaylR9P8QZk
 QD6S9xE5LUueWuyoSo1NhS2WqHSwkYQOdDRJda//Vr0SJNeKCQSz/kpKdjVbjaYcPwC6
 BWmKceueB6kyGPv12Y8Ax+gnjylcQefpHH3ICqLRLeDn7uKkC0LHaZFmPNE06Gjf6LP4
 5gwgCEUFByWtYP6S8yujyQguWEwAxb6VeydkI/32fDnEY7jIlXblul3dctU62WYTcaTy
 gH5g==
X-Forwarded-Encrypted: i=1;
 AL+hErGByJiUBPwrH8ND0j06QOnlaCqezUhWovuhGN3MVtYkThd5ToYsQfQL/mcO1aV3L0y4azIxERw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8rwZxTHWh+YWmAyTEWLtYpYYpOMgNiwpIIMEftxngHYmRgUwgH
 syjuB2k2JQMFZYgCTo4WCZxrMCMDFvYBj/urjhuoCfz3VXwoG/lMd6jb
X-Gm-Gg: AYBFou3C/rqSHFA+PCQiiCv3S31dV3+GcAW0yG1w1kvs3c28xpthexnj/uyi9NecZXb
 neV8ynlyTzvV/0iKNfwO1JTHA6aNZ7BZ+O5Vztdqqdcg+8mqjba6TVLhJvJ+Pn3cuzVslG+ucTe
 LVQJLC+9/gdQ4im0yns+YQMrKKkQgyX7eZoDbvTjH9Q8ZvQmYtyoXnvr/zI1Z44yYOxlKPp/D5K
 8hosFL52MpqlzWJAjqYIllBOlH9x/zijPBHjFSkOf0Ca+iru4YxXi0x/gFX2Jd+clpJ1N3mb/s1
 W6qdsWQ1QCc/S00drZarShFTrB4II6OGlS+A4hkAQMY04HTwiTfo1FXLcMZRHmyDYdwLRtcKgQ0
 pLDao1ftu7fo+jovD3xJTcB8q3HnTRzjqnAPj5WQFd0SvH/RM2NPJTlnvDgW/J0joytN60pRWQ0
 /EbySCsLrIuAzdw3+BPODQ5u7X+xg6VtMEWTjoleDUbHIOgUpdeK4CqrXrIZ5pV0waITHyJQiTs
 bCD3nxHqK/JNTZArAln6Ovezq1LBACEgU9KkY+8esu/EBWrWhZ7f86KHOpA7HR0jwburGuvExOE
 jgbcP2bvFoKbYDra14qlxJgqEA9AR2JN1H9dvrBwZ4Yq8scbC7QQpVytQiFkcAyF81owE3eM41q
 ibQzKq18y3Nf49VnIzAp9gDT0k3FN1LG56mDLE0RrOTlb8LTj68apGh6JZywz0/0i8zn3Dr7Mpz
 U9nQ7BxWF57AuUDP794fE34tPXnLY8kvwIszamaF+gikgbXmra9oU=
X-Received: by 2002:a05:6808:c226:b0:4f0:a3f9:9f89 with SMTP id
 5614622812f47-56b96ad0741mr3295531b6e.18.1794427890519; 
 Wed, 11 Nov 2026 12:11:30 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905d3bab2sm5863446b6e.12.2026.11.11.12.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:11:29 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 13:11:17 -0700
Subject: [PATCH 10/19] net: lwip: support IPv6 TFTP listeners and server names
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-submit-lwip-ipv6-v1-v1-10-eb0ee8f8da1a@gmail.com>
References: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
In-Reply-To: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Igor Velkov <iav@iav.lv>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Murtaza Munaim <murtaza@saramena.us>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Drew Kluemke <ankluemk@microsoft.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allow TFTP clients to resolve the server on their active interface,
retaining the filename colon rules. Add tftpsrv -ipv6 to initialize a
link-local listener without IPv4 configuration.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/lwip/tftpsrv.c |  4 ++--
 net/lwip/tftp.c    | 56 +++++++++++++++++++++++++++++++++---------------------
 2 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/cmd/lwip/tftpsrv.c b/cmd/lwip/tftpsrv.c
index 6370c900489..e474f5fa1e4 100644
--- a/cmd/lwip/tftpsrv.c
+++ b/cmd/lwip/tftpsrv.c
@@ -3,9 +3,9 @@
 #include <command.h>
 #include <net.h>
 
-U_BOOT_CMD(tftpsrv, 2, 1, do_tftpsrv,
+U_BOOT_CMD(tftpsrv, 2 + IS_ENABLED(CONFIG_IPV6), 1, do_tftpsrv,
 	   "act as a TFTP server and receive the first file",
-	   "[loadAddress]\n"
+	   "[loadAddress] [-ipv6]\n"
 	   "Listen for an incoming TFTP transfer and receive a file into memory.\n"
 	   "The transfer is aborted if a transfer has not been started after\n"
 	   "about 50 seconds or if Ctrl-C is pressed.");
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 9921fad3c0e..b80f492afc4 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -508,13 +508,20 @@ static void no_request(void *arg)
 	ctx->retry = true;
 }
 
-static int tftpsrv_loop(struct net_lwip_ctx *net, ulong addr)
+static int tftpsrv_loop(struct net_lwip_ctx *net, ulong addr, bool ipv6)
 {
 	struct tftp_ctx ctx;
 	int ret = -1;
 	err_t err;
 
-	if (tftp_check_ip(net))
+#if CONFIG_IS_ENABLED(IPV6)
+	if (ipv6) {
+		ret = net_lwip_ip6_start(net);
+		if (ret)
+			return ret;
+	}
+#endif
+	if (!ipv6 && tftp_check_ip(net))
 		return -1;
 
 	memset(&ctx, 0, sizeof(ctx));
@@ -524,8 +531,14 @@ static int tftpsrv_loop(struct net_lwip_ctx *net, ulong addr)
 	net_boot_file_size = 0;
 
 	printf("Using %s device\n", net->dev->name);
-	printf("Listening for TFTP transfer on %pI4\n",
-	       &netif_ip4_addr(net->netif)->addr);
+#if CONFIG_IS_ENABLED(IPV6)
+	if (ipv6)
+		printf("Listening for TFTP transfer on %s\n",
+		       ip6addr_ntoa(netif_ip6_addr(net->netif, 0)));
+	else
+#endif
+		printf("Listening for TFTP transfer on %pI4\n",
+		       &netif_ip4_addr(net->netif)->addr);
 	printf("Load address: 0x%lx\n", ctx.daddr);
 
 	tftpsrv_active_ctx = &ctx;
@@ -570,6 +583,12 @@ int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	char *end;
 	ulong laddr;
 	ulong addr;
+	bool ipv6 = false;
+
+	if (IS_ENABLED(CONFIG_IPV6) && argc > 1 && !strcmp(argv[argc - 1], "-ipv6")) {
+		ipv6 = true;
+		argc--;
+	}
 
 	net_boot_file_size = 0;
 	if (!IS_ENABLED(CONFIG_CMD_TFTPSRV))
@@ -601,7 +620,7 @@ int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	net_try_count = 1;
 	net_restart_wrap = 0;
 	for (;;) {
-		ret = tftpsrv_loop(&net, laddr);
+		ret = tftpsrv_loop(&net, laddr, ipv6);
 		if (ret != -EAGAIN)
 			break;
 		puts("Starting again\n\n");
@@ -807,22 +826,6 @@ static int do_tftp(int argc, char *const argv[], enum tftp_operation operation,
 		}
 	}
 
-	if (!ipaddr_aton(server_ip, &srvip) || (ipv6 && !IP_IS_V6(&srvip))) {
-		log_err("error: invalid TFTP server address\n");
-		ret = CMD_RET_FAILURE;
-		goto out;
-	}
-#if CONFIG_IS_ENABLED(IPV6)
-	if (IP_IS_V6(&srvip)) {
-		ret = net_lwip_ip6_aton(server_ip, ip_2_ip6(&srvip));
-		if (ret || !fname || !*fname) {
-			log_err("error: IPv6 TFTP requires a unicast server address and filename\n");
-			ret = CMD_RET_FAILURE;
-			goto out;
-		}
-	}
-#endif
-
 	if (fname && strlen(fname) > TFTP_MAX_FILENAME_LEN) {
 		log_err("error: TFTP file name is too long\n");
 		ret = CMD_RET_FAILURE;
@@ -837,7 +840,7 @@ static int do_tftp(int argc, char *const argv[], enum tftp_operation operation,
 	}
 
 	if (!parent) {
-		if (net_lwip_start(net, IP_IS_V6(&srvip) ? NET_LWIP_ADDR_ENV_FLEXIBLE :
+		if (net_lwip_start(net, ipv6 ? NET_LWIP_ADDR_ENV_FLEXIBLE :
 				   NET_LWIP_ADDR_ENV_STRICT)) {
 			ret = CMD_RET_FAILURE;
 			goto out;
@@ -847,6 +850,15 @@ static int do_tftp(int argc, char *const argv[], enum tftp_operation operation,
 	}
 
 	for (;;) {
+		ret = net_lwip_resolve(net, server_ip, &srvip,
+				     ipv6 ? IPADDR_TYPE_V6 : IPADDR_TYPE_ANY);
+		if (ret)
+			break;
+		if (IP_IS_V6(&srvip) && (!fname || !*fname)) {
+			log_err("error: IPv6 TFTP requires a filename\n");
+			ret = -EINVAL;
+			break;
+		}
 #if CONFIG_IS_ENABLED(IPV6)
 		if (IP_IS_V6(&srvip))
 			ret = net_lwip_ip6_prepare(net, &srvip);

-- 
2.53.0

