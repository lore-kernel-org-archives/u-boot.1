Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8446C606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ny0yVkQl;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xDpqvNeV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F09860E50;
	Wed, 11 Nov 2026 20:12:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YUihcSDtD-ek; Wed, 11 Nov 2026 20:12:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B8F6460DA7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427911;
	b=O34u1k16hwEpFz1FRbSu42+XomhRKt88GYIMVhBHWeZY/eFV/6WgjdKy0P+qO6mnoHl+
	 kuxmqwDxjBnQGmMIW7q0yazCy3Dmr3gAV4Mp8jebKNE7PLrzxxmWrz3NZjM5ZU5iBym72
	 QKYWhCZhSCi/wRq4mCeTP5AskJhxJucNbRe7HRJgLv/0jnIdWUXps8AmiVEgOxEh1EPNu
	 /TGOPXnBOEzo6ErC9oDddVY+KjqKcnw0zE23uNTi/Kzu7dheT/fpa8aei9+Ybx9oZe+uQ
	 LljJGsRdy9S7xaoKKzioPbbTzwhE/uUgyFfOVX5ksXyPeoEyLLW2jmbQKG/SjY4AtIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427911;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xMGSe4BuTId6WRjLeEj8c9x8YZqQSvqOSv6vWmCk1jE=;
	b=VHJwDOueDOuZFIY5ySN7MkKYX7lSleujFr9kczR/JYY48ykVAPfsL0QBq7MVQ+NeWsK+
	 p+zLOHrFrVu70n7kkQconalVRjobrnHR2ELT7HMqKPIPYVc44nUHFJ/zfSUGKblaFhCxR
	 JYKl68mTMJFiV3icrxJoq6rdi+Q9shP2vD6xWJhDdmEfzteVNQXaRVBrmzutmLhKXqqzg
	 aWUoyeUgkP8x7W6J6SQdmMsxLdd+JwFcPdnzGc8ylB6EabIkBgqJzrZ6LkY2otndqvLHc
	 dh0y+9nxpMI4F8CyLyQHi76i+aS5ChLjWdySS4Tz5ejs65nHwlNkwrawgRqpxtOWm6A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427911;
	bh=xMGSe4BuTId6WRjLeEj8c9x8YZqQSvqOSv6vWmCk1jE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ny0yVkQl++uXMA7n9CWYff7w1JD3PvDzYTYnCZr2uGWBZM9uyNBQUCPOh3ALyq+Gb
	 ZR3ELHi+8k3VcyHwRD/Ru2T81IZXy/FEKAL/yGAAcvq1i6N/VDCXp/3GlVt9EAYGIg
	 FmKs8ncjXs09YzAfGObutia8QVVrpM8ZO6g1DuN6jU0pVrnHi4jzmuIM8WHd8Th9j5
	 MwTxYKPZIVH8i70XydvqpLMJFU+v2VIN6c1l9pgUQJJdYMTCrBTFmw3JIW4Ta2Lrh3
	 NVqv9gcctEKHIdbYJWX11Nc2UjAWm+TqCl6gc7ahK1LjLLHodgElngeDRJlj1bpizf
	 MI0aD4YfXOgAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8F6460DA7;
	Wed, 11 Nov 2026 20:11:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 19ACAEC3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F3909403C9
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hlb-u8bobxXk for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:11:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0BBAF40336
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=xDpqvNeV
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0BBAF40336
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:36 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-4adaa0f72abso167425fac.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794427895; x=1795032695;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xMGSe4BuTId6WRjLeEj8c9x8YZqQSvqOSv6vWmCk1jE=;
 b=xDpqvNeVzXebKIMGHBe8BgYp1wke2Imak3b1fE9R9X314iLYTvVemVqlci5ntF3Oh4
 pv3TJJ4gQA58IGVsiu/deTIXXMVxUjgBm6P7JS3VtkqLhbbhjVYnAq86P6Ctz9zWksKx
 I5d/9wJpw++zQ//2swcBcKZ5k5zshAEchZT3n0v/8+H/6fbjZ9juYhearKVa8CQWKuxt
 kYyrOaga2uo67BO9fW5UAgZXDoPrWbr9NjoMfgTYP7TyY7wzQJvUKWGFY5GhAGsZZ2Ck
 A1V/7QRJ3vcCLjyRsh/1eEhwoEFE7vuC22fwH+nZkbz07vnYB7DwpL69cLIARWNyTJTQ
 PuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427895; x=1795032695;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xMGSe4BuTId6WRjLeEj8c9x8YZqQSvqOSv6vWmCk1jE=;
 b=URrCZwefIu+nM22pkePqeQqDFE/SoV/i3K+fVghnNakI5O/x5jzj0Vo1HllFTFnXRM
 jmYm+4sQdpwCsZPbcAg9q6N1JthgB7qn5rpnEb/baCtAT27tX7vR4Ayc1eARgQtjzYWk
 gWMacxG8vpLykiOuMr0/8bf5Cg8M0t7lwmiCTzmeazO6nk+KX3Glp6yX7BqF4nlMVqr6
 zz0hyUF9Ifup3jEepK324z0U0m3f6ZZFEZnx+L515HJOVYMFSi6MRLpAhxal2xpW/TH7
 0tfuqyyVh1Ww5T5oyKH/zh4Kg0XWTV57Nq9eq/szVKLhXQY0O0NfLd7xKmvPvO/aKkyh
 /BKA==
X-Forwarded-Encrypted: i=1;
 AL+hErHXFYwKmmUWJfIOGmCXie+FKOeYCOVLX3TxxkioO9km6qvzlg6GR7w3sK72QLaWmDlVN7rWZyI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+Z6BjQKs5iDL2K8bcr5vqnjq2qzIrAINH4LT6n7b9TCoE2BT4S
 GAKuAjAJjVPFPZS1ulOt5YU8QlOa+tmsuZ4PQVKY2HKcSU/QxaW3izVp6xQo7w==
X-Gm-Gg: AYBFou3PrsSgZ6G67fmo8WEx8TrcPpZf4UEdahWVUAo1EhhbsMmsLoUsMTvpMsZC0jP
 KPU9RO9sXjgtfDjMdlz4lDN0t2+nsJrPjYy80eDm3GZ0A5V0rd5WYyHNovjjfvjwPZbvmsCfXfe
 CF1vi4LqZGiMto2RYk3IRxFecBrYi7ABsuG1Y+FE8evx6wn/OfIetBE3dTnOI+sem6tv5uiQNJE
 NsISzPc4SaOTHXfPPPyLTi3Z3FdjYZ47+8hbH8cs9BLW4uAB8ug/YVIC/+AR7riniHlLA4Wipq6
 PSTbalbICjycyqjKIYLGM+WW2gK8nkiK5SLG9mA7BTKR1LwNndtvthzWND+YCbyzR2wxlZVklL6
 PeolCTK32WN/Yv4rPRrxO++WWW8OPrisPx+JiIteQHQrkB7q2JKDsYASnjNqrIakfmAl6Lc0rsL
 qL4O4V7dLaN/wZFm37G1qMp+g9vYnA8Y0lI51o3+RzccUCmItmBvVKD1LG3vDVnviwBAxOpgpBQ
 dxlfbOmI7Z4WHfgvAhzzMQc4I8b8N8wPk20iQCMEB7SZUKnl4biFTZFZkuozlhZn+UEG8uWt+nO
 W+Ic2E/ecrWELi7sq6jwdw4hESGkpc90X5L7wiTSLKGbjaU14/H5gHNPZdXAsWOYxdhdDc6K+iU
 FkM0cBUy4AKzqJ27C/tyKF2C/ETm632J+AgwHk4xGCzI+ThRK4z9FJIVcDk7Or4lIKyudx5yTIT
 yK96zu9l2SFokrTC7HMGFbWMRruAoc5LfV/jjfIRRVCftWRIXZmew=
X-Received: by 2002:a05:6808:508f:b0:4d6:9133:cff1 with SMTP id
 5614622812f47-56cd673ea55mr483142b6e.24.1794427895467; 
 Wed, 11 Nov 2026 12:11:35 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905d3bab2sm5863446b6e.12.2026.11.11.12.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:11:35 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 13:11:21 -0700
Subject: [PATCH 14/19] net: lwip: support IPv6 netconsole peers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-submit-lwip-ipv6-v1-v1-14-eb0ee8f8da1a@gmail.com>
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

Use ncip6 to select an IPv6 peer with the existing ncinport and
ncoutport settings. Prepare the address on the shared interface, bind a
dual-stack UDP endpoint and validate the sender in its native address
family before passing input to the common console buffer.

Poll IPv6 maintenance and check source and route readiness before each
send, including when the environment and resolved neighbor are unchanged.
This keeps output-only consoles from using expired configuration and
lets them receive advertisements and renew leases. Keep regular refresh
nonblocking after environment changes, such as a renewal updating DNS;
only console startup waits for address preparation.

Scope the configured IPv6 peer to the interface on each environment
refresh, so input-only consoles continue accepting link-local packets
after unrelated environment updates or a change of peer.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/netconsole-lwip.c | 86 +++++++++++++++++++++++++++++++++----------
 drivers/net/netconsole.c      | 18 ++++++++-
 drivers/net/netconsole.h      |  8 ++++
 3 files changed, 91 insertions(+), 21 deletions(-)

diff --git a/drivers/net/netconsole-lwip.c b/drivers/net/netconsole-lwip.c
index 87a42e5dfaa..a37c55afd3e 100644
--- a/drivers/net/netconsole-lwip.c
+++ b/drivers/net/netconsole-lwip.c
@@ -18,23 +18,31 @@ static struct net_lwip_ctx nc_net;
 static struct udp_pcb *nc_pcb;
 static unsigned int nc_users;
 static int nc_env_id = -1;
+static ip_addr_t nc_dest;
 
 static void nc_lwip_recv(void *arg, struct udp_pcb *pcb, struct pbuf *p,
 			 const ip_addr_t *addr, u16_t port)
 {
-	struct in_addr src_ip = {
-		.s_addr = ip_addr_get_ip4_u32(addr),
-	};
 	struct pbuf *q;
 
+	if (IP_GET_TYPE(addr) != IP_GET_TYPE(&nc_dest))
+		goto out;
+	if (IP_IS_V6(addr)) {
+		if (!ip_addr_cmp(addr, &nc_dest))
+			goto out;
+	} else {
+		struct in_addr peer = { .s_addr = ip4_addr_get_u32(ip_2_ip4(&nc_dest)) };
+
+		if (!ip_addr_cmp(addr, &nc_dest) && !nc_is_broadcast(peer))
+			goto out;
+	}
 	for (q = p; q; q = q->next)
-		nc_input_packet(q->payload, src_ip, pcb->local_port, port,
-				q->len);
-
+		nc_input_data(q->payload, q->len);
+out:
 	pbuf_free(p);
 }
 
-static int nc_lwip_refresh(void)
+static int nc_lwip_refresh(bool prepare)
 {
 	struct udp_pcb *pcb;
 	int env_id;
@@ -50,23 +58,40 @@ static int nc_lwip_refresh(void)
 		ret = net_lwip_refresh(&nc_net);
 		if (ret)
 			return ret;
+		ip_addr_set_ip4_u32_val(nc_dest, nc_settings.ip.s_addr);
+#if CONFIG_IS_ENABLED(IPV6)
+		if (nc_settings.ipv6) {
+			ip_addr_copy_from_ip6(nc_dest, nc_settings.ip6);
+			ip6_addr_assign_zone(ip_2_ip6(&nc_dest), IP6_UNICAST, nc_net.netif);
+			ret = net_lwip_ip6_init(&nc_net);
+			if (ret)
+				return ret;
+		}
+#endif
 		nc_env_id = env_id;
 	}
 
+	if (prepare) {
+		ret = net_lwip_prepare_addr(&nc_net, &nc_dest);
+		if (ret)
+			return ret;
+	}
+
 	if (nc_pcb && nc_pcb->local_port == nc_settings.in_port)
 		return 0;
 
-	pcb = udp_new();
+	pcb = udp_new_ip_type(IPADDR_TYPE_ANY);
 	if (!pcb)
 		return -ENOMEM;
 
-	err = udp_bind(pcb, IP_ADDR_ANY, nc_settings.in_port);
+	err = udp_bind(pcb, IP_ANY_TYPE, nc_settings.in_port);
 	if (err != ERR_OK) {
 		udp_remove(pcb);
 		return err;
 	}
 
 	ip_set_option(pcb, SOF_BROADCAST);
+	udp_bind_netif(pcb, nc_net.netif);
 	udp_recv(pcb, nc_lwip_recv, NULL);
 	if (nc_pcb)
 		udp_remove(nc_pcb);
@@ -119,7 +144,7 @@ int nc_transport_start(void)
 	int ret;
 
 	if (nc_users) {
-		ret = nc_lwip_refresh();
+		ret = nc_lwip_refresh(true);
 		if (!ret)
 			nc_users++;
 
@@ -130,7 +155,7 @@ int nc_transport_start(void)
 	if (ret)
 		return ret;
 
-	ret = nc_lwip_refresh();
+	ret = nc_lwip_refresh(true);
 	if (ret) {
 		net_lwip_stop(&nc_net);
 		return ret;
@@ -162,13 +187,24 @@ int nc_transport_stop(void)
 void nc_transport_send(const char *buf, int len)
 {
 	ip4_addr_t arp_target;
-	ip_addr_t dest;
 	struct pbuf *p;
 	err_t err;
 
-	if (!nc_users || nc_lwip_refresh())
+	if (!nc_users || nc_lwip_refresh(false))
 		return;
 
+#if CONFIG_IS_ENABLED(IPV6)
+	if (IP_IS_V6(&nc_dest)) {
+		/* Output-only consoles also need lifetime and lease maintenance. */
+		int ret = net_lwip_poll();
+
+		if (ret < 0 && ret != -EBUSY)
+			return;
+		if (net_lwip_ip6_ready(&nc_net, &nc_dest))
+			return;
+	}
+#endif
+
 	p = pbuf_alloc(PBUF_TRANSPORT, len, PBUF_RAM);
 	if (!p)
 		return;
@@ -177,12 +213,24 @@ void nc_transport_send(const char *buf, int len)
 	if (err != ERR_OK)
 		goto out;
 
-	ip_addr_set_ip4_u32_val(dest, nc_settings.ip.s_addr);
-	err = udp_sendto_if(nc_pcb, p, &dest, nc_settings.out_port,
+	err = udp_sendto_if(nc_pcb, p, &nc_dest, nc_settings.out_port,
 			    nc_net.netif);
-	if (err == ERR_OK &&
-	    nc_lwip_arp_target(ip_2_ip4(&dest), &arp_target))
-		nc_lwip_wait_for_arp(&arp_target);
+	if (err == ERR_OK) {
+		if (IP_IS_V4(&nc_dest) &&
+		    nc_lwip_arp_target(ip_2_ip4(&nc_dest), &arp_target))
+			nc_lwip_wait_for_arp(&arp_target);
+#if CONFIG_IS_ENABLED(IPV6)
+		/* ND retains this RAM pbuf while the neighbor is unresolved. */
+		if (IP_IS_V6(&nc_dest)) {
+			ulong start = get_timer(0);
+
+			while (p->ref > 1 && get_timer(start) < NC_ARP_TIMEOUT_MS) {
+				if (net_lwip_poll() < 0)
+					break;
+			}
+		}
+#endif
+	}
 
 out:
 	pbuf_free(p);
@@ -190,7 +238,7 @@ out:
 
 void nc_transport_poll(bool block)
 {
-	if (!nc_users || nc_lwip_refresh())
+	if (!nc_users || nc_lwip_refresh(false))
 		return;
 
 	do {
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 0a9ca1400a6..50a83004ecd 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -9,6 +9,7 @@
 #include <stdio_dev.h>
 #include <net.h>
 #include <vsprintf.h>
+#include <linux/errno.h>
 
 #include "netconsole.h"
 
@@ -75,6 +76,14 @@ int nc_refresh_settings_from_env(void)
 				settings.in_port = settings.out_port;
 			}
 		}
+#if CONFIG_IS_ENABLED(NET_LWIP) && CONFIG_IS_ENABLED(IPV6)
+		tmp = env_get("ncip6");
+		if (tmp && *tmp) {
+			if (net_lwip_ip6_aton(tmp, &settings.ip6))
+				return -EINVAL;
+			settings.ipv6 = true;
+		}
+#endif
 
 		p = env_get("ncoutport");
 		if (p != NULL)
@@ -104,8 +113,6 @@ void nc_set_input_recursion(bool enable)
 int nc_input_packet(uchar *pkt, struct in_addr src_ip, unsigned dest_port,
 	unsigned src_port, unsigned len)
 {
-	int end, chunk;
-
 	if (dest_port != nc_settings.in_port || !len)
 		return 0; /* not for us */
 
@@ -113,6 +120,13 @@ int nc_input_packet(uchar *pkt, struct in_addr src_ip, unsigned dest_port,
 	    !nc_is_broadcast(nc_settings.ip))
 		return 0; /* not from our client */
 
+	return nc_input_data(pkt, len);
+}
+
+int nc_input_data(const uchar *pkt, unsigned int len)
+{
+	int end, chunk;
+
 	debug_cond(DEBUG_NET_PKT_TRACE, "input: \"%*.*s\"\n", len, len,
 		   pkt);
 
diff --git a/drivers/net/netconsole.h b/drivers/net/netconsole.h
index 11c2d1e0f48..ee7f5dfddd2 100644
--- a/drivers/net/netconsole.h
+++ b/drivers/net/netconsole.h
@@ -5,9 +5,16 @@
 
 #include <linux/types.h>
 #include <net-common.h>
+#if CONFIG_IS_ENABLED(NET_LWIP) && CONFIG_IS_ENABLED(IPV6)
+#include <lwip/ip6_addr.h>
+#endif
 
 struct nc_settings {
 	struct in_addr ip;
+#if CONFIG_IS_ENABLED(NET_LWIP) && CONFIG_IS_ENABLED(IPV6)
+	ip6_addr_t ip6;
+	bool ipv6;
+#endif
 	u16 out_port;
 	u16 in_port;
 };
@@ -15,6 +22,7 @@ struct nc_settings {
 extern struct nc_settings nc_settings;
 
 bool nc_has_input(void);
+int nc_input_data(const uchar *pkt, unsigned int len);
 bool nc_is_broadcast(struct in_addr ip);
 int nc_refresh_settings_from_env(void);
 int nc_input_packet(uchar *pkt, struct in_addr src_ip, unsigned int dest_port,

-- 
2.53.0

