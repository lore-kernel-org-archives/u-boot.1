Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B44606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=taNT5eT9;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VVMHjfUW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8C436068B;
	Mon, 23 Nov 2026 22:13:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vUMqkRrS675C; Mon, 23 Nov 2026 22:13:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9D84B606BA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795472024;
	b=rkBNMV2uEIsrbYKGHU3FtjosAGzs6rFSPChLpnnEgR50Qby4qBBxyy8zTRBoPK6+EsDV
	 zKaYBplNO4cwZg3C3OIBCY6AL3O3c23O+Wa48qxDaS8Z2ng94lci2+iDjTiPj+L3hyVDC
	 P4mfQDmPWIfsgCp2m+9TJsNXEdpdBuS1nP5cQ+W5BW4d8iM9UhWsVUWs3qCUFzQf18vIp
	 R5YYeAjGBOptBDz3+VhgTNaLRdx4iDRpux1FM7Tn4nJV2YYo8DiyVHrfPe7+GLAglygEA
	 cIN5y5T9XPwSAeFx6hoCU3nAOEOaplWILIsA/EtSgY9YNEGKa5OST2AWIVPOlgUWWTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795472024;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=N4vmUrTgB8OAQBsEsr0jT3frAohWJ0qxgkQBfJTJb5w=;
	b=Xkxz06IiTznpvJFtIcd6lQ87BaeVoG+k1RmVs4ygUWlAi6lAAIY9qhjfhqr60h6p/4/6
	 B35bxgwWiNf/KRkSK6/nOpfzY4vY9AEt+zXntboz2Xdsqfk6JarItElIR7CFnobpC300O
	 Eb0zZC07KQzBwvVIYZCGCEhUVrY1ICxNZ+8iroZJy5MeXhWAf8H7awv3NkZqNYDm6N78z
	 CN4XPfskLrguzQZKyT+FJ8YToUzKfKxG24ba0uYDXOtBH+NTvy6dlS+nGKwp5HfKDv4+y
	 xdO6VcdEJiHzVxde/DIP/Ew77ERY9v+H2BByEnjwglub2k4MOy6iQXnNGYwBWgz14NA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795472024;
	bh=N4vmUrTgB8OAQBsEsr0jT3frAohWJ0qxgkQBfJTJb5w=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=taNT5eT9CnQtozIlTGhGIGRsKRPoqvuRJlCdbMr0udOMErNfuJF97Abp/uqIBLe3g
	 IBgNmsbgnV+FIXybPJv0udkoltQdJ0wpscZo/zkWSIVjEeS+v5mGuX66Jvy8uwJskT
	 PNjiALFCKC6rxDiv4cioDyjqk0guvERiud+ZTPGXY0D9M5DXrR/Y+XS7ueiCsEbIZy
	 K9zdrKcMP3BAhme5GIXyNPIlt/2sStOkL3xRjID03Tp5JtnzBFUsrwhOy0C2021D30
	 he1nVurluptUqsOzjwWewaIxdJUiKM2eZSrHhZc7v7LYoM+yTn/Eoov5BqCw90rKrT
	 eAoJ42frjYyqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D84B606BA;
	Mon, 23 Nov 2026 22:13:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1983C499
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 22:13:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 169464076C
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 22:13:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ph7-BfoysFRX for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 22:13:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DB20C4075C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=VVMHjfUW
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB20C4075C
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 22:13:41 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6ddef424972so3292486eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795472020; x=1796076820;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=N4vmUrTgB8OAQBsEsr0jT3frAohWJ0qxgkQBfJTJb5w=;
 b=VVMHjfUWFVeQ6VWsoVBtdel0DuC+8UY7SvSW/3+u2zeBOHLswT8tXzAeria4L38PBJ
 PZgCzqck4cG3rGZH2u2lY/Ot0nNTkL/Ca7MhV586sM9BSVnnpVHhGiXTSwsHAj21KdK5
 eQmH4oxlrcpaTHB54OIh8Lrnlb9ocPvpjAQcxSMJPn7zWKEAShxRQqEQPU9aOJ90t5dj
 rG6wgdNI9Ol1+RAOm5gUbniTcMbH8j8Jk9NCO3kCw1G4WCq61eqV8wEaXnwZzTA+AHUe
 QLC3/Lr6Ko5uv+zommiAFGh4XbGdKA9mOVDdxsBABcsp/Sd4tQCmYH6orcDsfnvVGR7S
 i1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795472020; x=1796076820;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=N4vmUrTgB8OAQBsEsr0jT3frAohWJ0qxgkQBfJTJb5w=;
 b=aBsbigf87CuD0RMMQBZMqB5Z7gzeL2pE1YBdHAhQBdw0KxFNzLSzRZ+Vm3ZWGL0ggL
 z74ZYLholOJZaaZi/c5H07m8Yw5WRNFUuqr8SI5Y8EVmHc/NIPXt8VhxyFs+swQM3cII
 h9Qk7o76xh4cac6zHPzdZwGp5RejNSoov/NqfnBrljokyWFsg7AJr4mFXxKaztBijAs9
 K2QTtS3qvOc08by3tuhh/P9JxuF9tTnIWWymtWEnHv/yV+/SsSP4KQFICFx4WOroKw6E
 Z8YgA0u4jAtM4mDwWXgfsq9mP8iSHa0oiknYdzQibVw/6XE9O86QM4vF0Il4PRWmT1b6
 gL6Q==
X-Gm-Message-State: APuU4Z/dU68FV31hGowKTW8u0arYUPNyDY9bFtP8xilA8wgGeX83T+/I
 ozCUVWMP4GHj0JZFU0dRpAWGPxOZtDaDoz9zdMIvsMGvf6ayv0V7l0Ze5ZGTfT+3
X-Gm-Gg: AZFdTZdGdw1JhaMe+vw6ykUaEV3lVAZLJ2h8Pc5ZzZuv+1gQ8lTMSxn4oN+VzsPq2AY
 j3K0JPSGldUHCtP9Ca+zA8QNupryuMkDK8RYiFR+WMCTRniBvdSxoKZlE/9iKXRNb1ipTYAbWOZ
 jUQiLbkJnNVUmPKhVznBT40JQWQgY5MKefD9YdmISGxTACdzJiBbCw2LPIYgy5gbSOrHKPxBnjN
 X0UM7V1orxAsfO8LJsMyiPN2Zkhx7F7vBLqJA84HwER6PRjPTa7kLhVOwTMh+ziy0Xf+JAbgf5k
 HxlakCfgBcftx7rZ452BQCuF7YwBIZmJtA+MEcHYraExeAJBeLk4e3V3XS7lGLqA6t1rEQN+V5B
 aPj7Z4LVsIgoQ0v98ekyHDaHkRkvXixlP6hlQ4gCY9hEicbLabH6lsadMDzP4vVtwNnCej74NYt
 Obb7FZ7DnmGQG5EWuZGq/XiXOq6f1HDWlZcKuiDXrjkSezB0iCdJsy72aodYc1z6xGsrovyp0No
 YIyvyvichMR4j0Fk/peclyZe49+YBPiK3/NIxizYXXHHdw8pBQk/O0yb3cL46x07XO1RIt9nKvd
 KpB2YvSgKdAG6HoGQwFAStuq4jSzbpxMuXQ58ml5VgnTm0Q3+IcceQBwmUsseYZsFVYlIr5lQpG
 fM7sKrUCnPaKOTD0a1UtxdU0E1L/+rrVXN1ZcFwi2vt71AQRfh+F5xB8yEUOEwYGzxUcDLMxIHy
 X6EWutbArOP6p3oa3cpG21/Dk+9sT+BjT3hSkqGL/MPP/dKeBqL5qpZ1nITHzgX4kIPeQqvb4Q
X-Received: by 2002:a05:6820:5707:20b0:709:529a:478f with SMTP id
 006d021491bc7-71b395332femr7162755eaf.60.1795472020075; 
 Mon, 23 Nov 2026 14:13:40 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b380c6815sm7984189eaf.12.2026.11.23.14.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 14:13:39 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 23 Nov 2026 15:13:37 -0700
Subject: [PATCH] cmd: wget: honor httpdstp for legacy arguments with lwIP
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-submit-lwip-wget-httpdstp-v1-v1-1-e1759174ab9a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBBA4auQWTsJbaVEr2Jc8DPAEMSmM4IJ4
 e5WWH6L9zYQikwC92yDSAsLv+cEc8mgGaq5J+Q2GWxuvTHWoXzqFytOKwdce1IcVEMrGnAx6Er
 ry1t+9b5wkBYhUsffY/94nk79SI3+n7DvP37PR7WAAAAA
X-Change-ID: 20261123-submit-lwip-wget-httpdstp-v1-372679046653
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ADI boot scripts set httpdstp to 8000 and use wget to fetch
${serverip}:/fitImage. With lwIP, wget still connects to port 80
because it omits the configured port when building the URL.

Use httpdstp as the default port for [host:]path. Preserve a port
already present in the configured server address. Pass HTTP and HTTPS
arguments unchanged to the URL parser so an unsupported spelling is not
reinterpreted as an HTTP request to a different host.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/lwip/wget.c     | 87 +++++++++++++++++++++++------------------------------
 test/dm/lwip_ipv6.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 115 insertions(+), 50 deletions(-)

diff --git a/cmd/lwip/wget.c b/cmd/lwip/wget.c
index c29b30ebe59..b1eeb235677 100644
--- a/cmd/lwip/wget.c
+++ b/cmd/lwip/wget.c
@@ -117,70 +117,59 @@ static int set_cacert(char * const saddr, char * const ssz)
 }
 #endif
 
+static bool server_has_port(const char *server)
+{
+	if (*server == '[') {
+		const char *end = strchr(server, ']');
+
+		return end && end[1] == ':';
+	}
+
+	return strchr(server, ':');
+}
+
 /*
  * Legacy syntax support
  * Convert [<server_name_or_ip>:]filename into a URL if needed
  */
-static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
+static int parse_legacy_arg(const char *arg, char *nurl, size_t size)
 {
-	char *p = nurl;
-	size_t n;
-	char *col = strchr(arg, ':');
-	char *env;
-	char *server;
-	char *path;
-
-	if (strstr(arg, "http") == arg) {
-		n = snprintf(nurl, rem, "%s", arg);
-		if (n < 0 || n > rem)
-			return -1;
-		return 0;
-	}
+	const char *col = strchr(arg, ':');
+	const char *port, *server, *path;
+	size_t hostlen;
+	unsigned int value;
+	int n;
 
-	n = snprintf(p, rem, "%s", "http://");
-	if (n < 0 || n > rem)
-		return -1;
-	p += n;
-	rem -= n;
+	if (!strncasecmp(arg, "http:", 5) || !strncasecmp(arg, "https:", 6))
+		return strlcpy(nurl, arg, size) >= size ? -ENOSPC : 0;
 
+	port = env_get("httpdstp");
 	if (col) {
-		n = col - arg;
+		hostlen = col - arg;
 		server = arg;
 		path = col + 1;
 	} else {
-		env = env_get("httpserverip");
-		if (!env)
-			env = env_get("serverip");
-		if (!env) {
-			log_err("error: httpserver/serverip has to be set\n");
-			return -1;
+		server = env_get("httpserverip");
+		if (!server)
+			server = env_get("serverip");
+		if (!server) {
+			log_err("error: httpserverip/serverip has to be set\n");
+			return -EINVAL;
 		}
-		n = strlen(env);
-		server = env;
+		hostlen = strlen(server);
 		path = arg;
+		if (server_has_port(server))
+			port = NULL;
+	}
+
+	if (port && (net_lwip_parse_decimal(port, strlen(port), U16_MAX, &value) || !value)) {
+		log_err("Invalid httpdstp\n");
+		return -EINVAL;
 	}
 
-	if (rem < n)
-		return -1;
-	strncpy(p, server, n);
-	p += n;
-	rem -= n;
-	if (rem < 1)
-		return -1;
-	*p = '/';
-	p++;
-	rem--;
-	n = strlen(path);
-	if (rem < n)
-		return -1;
-	strncpy(p, path, n);
-	p += n;
-	rem -= n;
-	if (rem < 1)
-		return -1;
-	*p = '\0';
-
-	return 0;
+	n = snprintf(nurl, size, "http://%.*s%s%s%s%s", (int)hostlen, server,
+		     port ? ":" : "", port ?: "", *path == '/' ? "" : "/", path);
+	return n < 0 || n >= size ? -ENOSPC : 0;
 }
 
 int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
diff --git a/test/dm/lwip_ipv6.c b/test/dm/lwip_ipv6.c
index bd68ac0e356..d5e4afb52d3 100644
--- a/test/dm/lwip_ipv6.c
+++ b/test/dm/lwip_ipv6.c
@@ -19,6 +19,7 @@
 #include <lwip/priv/nd6_priv.h>
 #include <lwip/prot/icmp6.h>
 #include <lwip/prot/nd6.h>
+#include <lwip/prot/tcp.h>
 #include <lwip/prot/udp.h>
 #include <mapmem.h>
 #include <net.h>
@@ -47,6 +48,7 @@ enum ip6_solmax_test {
 
 struct ip6_test {
 	struct net_lwip_ctx net;
+	unsigned int tx_packets;
 	unsigned int dad;
 	unsigned int neighbors;
 	ip6_addr_t last_neighbor;
@@ -81,6 +83,9 @@ struct ip6_test {
 	u32 lease_valid;
 	unsigned int dhcp_bad;
 	unsigned int http_requests;
+	u16 http_syn_port;
+	struct in_addr http_syn_ip;
+	bool stop_at_http_syn;
 	unsigned int rpc_requests;
 	unsigned int sntp_requests;
 	unsigned int console_packets;
@@ -400,6 +405,18 @@ static int ip6_test_ipv4(struct udevice *dev, void *packet, unsigned int len)
 	if (!sandbox_eth_arp_req_to_reply(dev, packet, len) ||
 	    !sandbox_eth_ping_req_to_reply(dev, packet, len))
 		return 0;
+	if (test->stop_at_http_syn && ntohs(eth->et_protlen) == PROT_IP &&
+	    len >= ETHER_HDR_SIZE + IP_HDR_SIZE + TCP_HLEN &&
+	    ip->ip_hl_v == 0x45 && ip->ip_p == IPPROTO_TCP) {
+		struct tcp_hdr *tcp = packet + ETHER_HDR_SIZE + IP_HDR_SIZE;
+
+		if (TCPH_FLAGS(tcp) & TCP_SYN) {
+			test->http_syn_ip = ip->ip_dst;
+			test->http_syn_port = ntohs(tcp->dest);
+			console_in_puts("\x03");
+		}
+		return 0;
+	}
 	if (ntohs(eth->et_protlen) != PROT_IP || len < ETHER_HDR_SIZE + IP_UDP_HDR_SIZE ||
 	    ip->ip_hl_v != 0x45 || ip->ip_p != IPPROTO_UDP || ntohs(ip->udp_dst) != 53)
 		return 0;
@@ -629,6 +646,7 @@ static int ip6_test_http_reply(struct udevice *dev, struct ip6_hdr *ip)
 	packet[12] = 5 << 4;
 	put_unaligned_be16(32768, packet + 14);
 	if (tcp[13] & 2) {
+		test->http_syn_port = get_unaligned_be16(tcp + 2);
 		put_unaligned_be32(1000, packet + 4);
 		put_unaligned_be32(seq + 1, packet + 8);
 		packet[13] = 0x12;
@@ -727,6 +745,7 @@ static int ip6_test_tx(struct udevice *dev, void *packet, unsigned int len)
 	unsigned int plen;
 	u8 *icmp = (void *)(ip + 1);
 
+	test->tx_packets++;
 	if (len < ETHER_HDR_SIZE)
 		return 0;
 	if (ntohs(eth->et_protlen) != 0x86dd)
@@ -1152,6 +1171,7 @@ static int ip6_test_run(struct unit_test_state *uts,
 		"ncip", "ncip6", "ncinport", "ncoutport", "ntpserverip",
 		"tftpsrcp", "tftpblocksize", "tftpwindowsize", "tftptimeout",
 		"tftptimeoutcountmax",
+		"httpdstp", "httpserverip", "serverip",
 	};
 	struct ip6_test test = {};
 #if CONFIG_IS_ENABLED(WGET)
@@ -1222,8 +1242,21 @@ static int ip6_test_http_ports(struct unit_test_state *uts, struct ip6_test *tes
 		"", "0", "65536", "+8080", "8080junk", "4294975376",
 		"18446744073709559696", "99999999999999999999999999999999",
 	};
+	static const struct {
+		const char *server, *httpdstp, *arg, *host;
+		u16 port;
+		bool dns;
+	} cases[] = {
+		{ "[fe80::2]", NULL, "ipv6.bin", "[fe80::2]", 80, false },
+		{ "[fe80::2]", "8080", "/ipv6.bin", "[fe80::2]", 8080, false },
+		{ "[fe80::2]:8081", "8080", "ipv6.bin", "[fe80::2]", 8081, false },
+		{ "[fe80::3]", "8080", "boot.test:/ipv6.bin", "boot.test", 8080, true },
+		{ "boot.test:8081", "8080", "ipv6.bin", "boot.test", 8081, true },
+		{ "[fe80::3]", "65536", "http://[fe80::2]:8082/ipv6.bin", "[fe80::2]", 8082, false },
+	};
 	struct wget_http_info info = { .method = WGET_HTTP_METHOD_GET };
-	char url[128];
+	char url[128], host[64];
+	unsigned int sent, requests = 1;
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(ports); i++) {
 		snprintf(url, sizeof(url), "http://[fe80::2]:%s/ipv6.bin", ports[i]);
@@ -1234,6 +1267,49 @@ static int ip6_test_http_ports(struct unit_test_state *uts, struct ip6_test *tes
 	test->http_host = "Host: [fe80::2]:8080\r\n";
 	ut_assertok(wget_request(0x2100000, "http://[fe80::2]:0008080/ipv6.bin", &info));
 	ut_asserteq(1, test->http_requests);
+	ut_asserteq(8080, test->http_syn_port);
+	if (!CONFIG_IS_ENABLED(CMD_WGET))
+		return 0;
+
+	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(env_set("ipaddr", NULL));
+	ut_assertok(env_set("dnsip6", "fe80::2"));
+	test->http_target = "GET /ipv6.bin HTTP/";
+	for (unsigned int i = 0; i < ARRAY_SIZE(cases); i++) {
+		if (cases[i].dns && !IS_ENABLED(CONFIG_DNS))
+			continue;
+		ut_assertok(env_set("httpserverip", cases[i].server));
+		ut_assertok(env_set("httpdstp", cases[i].httpdstp));
+		snprintf(host, sizeof(host), "Host: %s:%u\r\n", cases[i].host,
+			 cases[i].port);
+		test->http_host = host;
+		test->http_syn_port = 0;
+		ut_assertok(run_commandf("wget 2100000 %s", cases[i].arg));
+		ut_asserteq(cases[i].port, test->http_syn_port);
+		ut_asserteq(++requests, test->http_requests);
+	}
+	sent = test->tx_packets;
+	ut_assertok(env_set("httpdstp", "65536"));
+	ut_asserteq(CMD_RET_FAILURE, run_command("wget 2100000 /ipv6.bin", 0));
+	ut_asserteq(sent, test->tx_packets);
+	ut_assertok(env_set("httpdstp", "8080"));
+	test->http_host = "Host: https:8080\r\n";
+	ut_asserteq(CMD_RET_FAILURE, run_command("wget 2100000 https:/ipv6.bin", 0));
+	ut_asserteq(sent, test->tx_packets);
+	ut_asserteq(CMD_RET_FAILURE, run_command("wget 2100000 httpS://boot.test/ipv6.bin", 0));
+	ut_asserteq(sent, test->tx_packets);
+
+	/* Stop at the IPv4 SYN once we know which server and port wget used. */
+	ut_assertok(env_set("httpserverip", NULL));
+	ut_assertok(env_set("httpdstp", NULL));
+	ut_assertok(env_set("ipaddr", "192.0.2.1"));
+	ut_assertok(env_set("netmask", "255.255.255.0"));
+	ut_assertok(env_set("serverip", "192.0.2.2"));
+	test->stop_at_http_syn = true;
+	test->http_syn_port = 0;
+	ut_asserteq(CMD_RET_FAILURE, run_command("wget 2100000 /ipv6.bin", 0));
+	ut_asserteq(string_to_ip("192.0.2.2").s_addr, test->http_syn_ip.s_addr);
+	ut_asserteq(80, test->http_syn_port);
 	return 0;
 }
 

---
base-commit: d778970a189b977c14f93961d7009f404d895b5b
base-tree: https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git for-next
change-id: 20261123-submit-lwip-wget-httpdstp-v1-372679046653

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

