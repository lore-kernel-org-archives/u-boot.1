Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A4E606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Jafs106c;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bs5iAU8D
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C390060DC1;
	Wed, 11 Nov 2026 20:12:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QUHOA6991sQY; Wed, 11 Nov 2026 20:12:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3366360DFB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427910;
	b=J2Uy6JTHm8FnhAXaqrknDzdSO7JHW94wxuQHj863/tgWNoLR/LcTPgM9kSZ8+s5ydxa+
	 CTNbOcy7jUmtcWj/QWTmeFTcRvpVGBN17mZB/I+TacaOmj78K+7PjzpZ3Oba1Rmd9iyaN
	 1CniCDxcI2gD6OQBT7vqxcCgYH5f7oKKx9IjBIRrwVUP3wjBK1uczYAiL9nCm8/gBTm0n
	 LwxuAmQrfezx7mby6nYq/FLfjulKRhpi4vmXfDje6Dor9xqJQr/jyzsXuPhPb/fbOfm8V
	 YmtmwNcEXI3cNm9eC5YmQr7VnTP4FDIAvksrESkHXwTm2HlAu0AOJ6kdKyHkiS3IyBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427910;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Nuk9iIZIMT0n9oC7CWVmAtrlrBznt78qqucdJDHUXW8=;
	b=SWvVvMrQIuuwLjNjVZZYtueCSkXLdtN0qYIhNSwnvMpXQcbtqrZZCLOMO+XbJDdsRzkh
	 PhyaCZkxGeCZQ2n+OekO7l9SuZetdnk8AyD56rNgBBbyoC4D1Tk7YXk/0IVrs0mqVHEQG
	 G18KiIuOTKGkknTVb7P+Ph/lVDFx7tgJRzayJuunC/EdL37qRt3Z+4e4d98Dpv/G41mx/
	 vfxqklT7d9POblFJpVnr4H2iRQskC/f95zJi/e1NyD7q9bBGQcxgvNqkci2bMBRqsKLP0
	 nuwqPSa2CGN+LRYXI5O5m2Eh/OJ0oSDL3LOILQDyu/w8V+8RY4u+EaB+HjNSh0BC0xw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427910;
	bh=Nuk9iIZIMT0n9oC7CWVmAtrlrBznt78qqucdJDHUXW8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jafs106ct6E3/KezCf5vtzgroFQz58GOjVMhtENTDzLfITLUSSCKwHpTAotURm7bL
	 GYDOVmw9k2LBxHmN81YbUASc68LBzCdiJkrfXQQdNt9SLKkvQX+mruo5v6XqZ0YK68
	 30eD7LrL6kf6ESrpt6FoojSlnxkUJXnAlvlzxbBRW4JAVBxa32RxNyF1qYQXd+o2ic
	 0D5/Erq3htKEqtr4cj1Dx7CVMOHgVteFvmDfH9kgeb82Z/CIHR+/FZmDU/1B1KKWIY
	 SWOdKajls8pIVg2OCaUsfJ/hdsCPo5G86g3xVw1mVGOD5HCN4rr85/i3pplUDxG87r
	 gltGIdvoORrUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3366360DFB;
	Wed, 11 Nov 2026 20:11:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C39B178C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0610E403C9
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Gy6THP_Xd-K for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:11:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F2BD840336
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::234"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::234; helo=mail-oi1-x234.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=bs5iAU8D
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2BD840336
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:35 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-563a0462094so1778590b6e.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794427894; x=1795032694;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nuk9iIZIMT0n9oC7CWVmAtrlrBznt78qqucdJDHUXW8=;
 b=bs5iAU8DmSGAmIhAH7OHBwSTu+9Eav9elCYq+iYF39DFetZfOuow9+3io7UgygxyAp
 tK2ULiWWgyLmYdXkjZQ0l6LuKCq9uUuNtvYpu1b/bFcwX0lPiCn0UBhxPnw7uMtLWPnJ
 M/GSDCL/qkrY07zXKt1CbjAN1du4x/ysB8Te+znXQzutoSYQt13BQZBfpQk4jBRROgDr
 iy7Pt8dYxoPfCgGJneHwJzk7CXnstkmN3bRZRjmNPqcPEJ6b7bY+daRatUAbOZaj3Hw9
 bYiPjvUDFV21eMLiQmTbJEuk3BE3o+z4So8NcAgDjnTkE0zsv930/itJLIfNk/ulJpSR
 7brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427894; x=1795032694;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nuk9iIZIMT0n9oC7CWVmAtrlrBznt78qqucdJDHUXW8=;
 b=Zoony1KjAZ9Jk5Zf59ZUDfAK+Z0PcVnyG25idpQo30At7lvbQAKPCYqLbEANVK+jcZ
 l2qvPjY8AQAb2L9aUZZxoLg00jeKNbmp7Ty+jqj7sRGrBiZjh1Tazx4LmyIgUK5xYQHU
 /I4CAZFlU83URdKNmG2BcfBqdHMF905DJ0Dcoja9sWrk9D4+Q/bcqa2Zb6BJB+7VNUJw
 KtWNJasMbIJTJoDcY6Rth0jF9P25k89ZPQxOmO1urjcN6YmDQq5fb0ONYO2ap96sfAgh
 AcmjR6tlEJqNeEhhUsYTptIQdELLSt/ka+W6/lU+8KwmH5cLAd+daRc1ccPxhESKlhLU
 n6JQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG71Nst6hKsen4XQ4TWw0YFd/Hs2F7hp6MoqB4QhiTQttoXn5y633MS4BFicUcspIk+tZicSUs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z939qAoXY+zoYv1Edub4pQ8lVNJusWk7lZ7R2NLQbrk7fR5yayD
 BmB6gKJU8V9z+/8GDM+S5ufG+yqzhzBkr8PjYhxkp4DB/XvjZEt+NAkQ
X-Gm-Gg: AYBFou0v/Xw7JKfjcSQE4aGjqGobOtZMoULdqcZ9iwmlExi20FsRrk3HVHARqFxmud5
 EKsIs9U45JLmZ5gLvhA+ri2TJVKC9+WJCJB0TnqmQAsBbCTfA6bQVjjAQi4r0Lx//rlDxiZ9DcC
 ufJpxR1Or30UJnTC07OPL1PoIfOyfrzp/SqkK/JwRQICX1qINFGhKNMaVzG0+vsG3eL0TuXEPVd
 +vSyj0/45tSOOegji47nuplnNaNeO56l2AqsYUCiM4MG7HCs2bBruoy1DdEMgm5r2X1ZyU0OsAG
 jxEPkackTWiQ0nj/kQ4sl4OsdpDQ0BXePeunIddkT3APyYFQxzxd3r3re9ZrZ21ybM/oGv1+79X
 wxMN6pjEvE0YMmEFKy6XtbyGrcn9uvEIgM/Zz4udBOPgARXn9f5dMA3PFAgkcNLdu4WTDgYdCd8
 sygmmKwX9nrjoUvPmEYy2sPL4URPFBrWkEnKnK812YDzkhT46cFB67i0lCtxV5wy1hS9hZ49IKG
 Scm/iDWuL3tx37tXxzB4n0p9d+DQ0vX9J/dPkymyu3Ysx2JJHs5NZ7RgIFJTVF+t2Vw8w/CMZGR
 A1ga3409KuXT96LehnWyCoFebiyMIoAN1ntWx/vhxemBSabUFYtGigkbiJG2Bkuxq9Y5ziCINen
 J5EWwtRC1Ze3QvataegO0m1ppPyLgHiBesHV0JdBrnCinHeVYNRUEkIqbfvbs5yJeXUyXAG5gQv
 dspB2yijetJXV4NG53g353kOQp4PT1WKKG0SJOPoo1ulZEG4T9qLs=
X-Received: by 2002:a05:6808:c3eb:b0:55b:fcf7:61f8 with SMTP id
 5614622812f47-56b97a1505fmr2877303b6e.40.1794427894271; 
 Wed, 11 Nov 2026 12:11:34 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905d3bab2sm5863446b6e.12.2026.11.11.12.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:11:33 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 13:11:20 -0700
Subject: [PATCH 13/19] net: lwip: support IPv6 HTTP and HTTPS transfers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-submit-lwip-ipv6-v1-v1-13-eb0ee8f8da1a@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Accept bracketed IPv6 URL authorities and prepare the resolved address
before connecting. Retain the URL hostname for TLS authentication and
send a correctly bracketed Host authority, including its port. Validate
decimal port fields without allowing arithmetic overflow to bypass the
range check. Let the HTTP client allocate a dual-stack TCP endpoint and
connect using the pre-resolved address.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 lib/lwip/lwip/src/apps/http/http_client.c         | 27 +++++++-
 lib/lwip/lwip/src/include/lwip/apps/http_client.h |  3 +
 net/lwip/wget.c                                   | 79 +++++++++++++----------
 3 files changed, 75 insertions(+), 34 deletions(-)

diff --git a/lib/lwip/lwip/src/apps/http/http_client.c b/lib/lwip/lwip/src/apps/http/http_client.c
index 6ed739e13fd..1c096a7d10c 100644
--- a/lib/lwip/lwip/src/apps/http/http_client.c
+++ b/lib/lwip/lwip/src/apps/http/http_client.c
@@ -623,7 +623,7 @@ httpc_init_connection_common(httpc_state_t **connection, const httpc_connection_
   req->uri = req->server_name + server_name_len + 1;
   memcpy(req->uri, uri, uri_len + 1);
 #endif
-  req->pcb = altcp_new(settings ? settings->altcp_allocator : NULL);
+  req->pcb = altcp_new_ip_type(settings ? settings->altcp_allocator : NULL, IPADDR_TYPE_ANY);
   if(req->pcb == NULL) {
     httpc_free_state(req);
     return ERR_MEM;
@@ -723,6 +723,31 @@ httpc_get_file(const ip_addr_t* server_addr, u16_t port, const char* uri, const
   return ERR_OK;
 }
 
+/** Connect to an already resolved address while retaining the HTTP Host authority. */
+err_t
+httpc_get_file_host(const ip_addr_t* server_addr, const char* host, u16_t port, const char* uri,
+                    const httpc_connection_t *settings, altcp_recv_fn recv_fn,
+                    void* callback_arg, httpc_state_t **connection)
+{
+  httpc_state_t *req;
+  err_t err;
+
+  LWIP_ERROR("invalid parameters", server_addr && host && uri && settings && recv_fn, return ERR_ARG;);
+  err = httpc_init_connection(&req, settings, host, port, uri, recv_fn, callback_arg);
+  if (err != ERR_OK) {
+    return err;
+  }
+  err = httpc_get_internal_addr(req, settings->use_proxy ? &settings->proxy_addr : server_addr);
+  if (err != ERR_OK) {
+    httpc_free_state(req);
+    return err;
+  }
+  if (connection != NULL) {
+    *connection = req;
+  }
+  return ERR_OK;
+}
+
 /**
  * @ingroup httpc
  * HTTP client API: get a file by passing server name as string (DNS name or IP address string)
diff --git a/lib/lwip/lwip/src/include/lwip/apps/http_client.h b/lib/lwip/lwip/src/include/lwip/apps/http_client.h
index 50403fb4cb3..94a29656041 100644
--- a/lib/lwip/lwip/src/include/lwip/apps/http_client.h
+++ b/lib/lwip/lwip/src/include/lwip/apps/http_client.h
@@ -141,6 +141,9 @@ typedef struct _httpc_connection {
 
 err_t httpc_get_file(const ip_addr_t* server_addr, u16_t port, const char* uri, const httpc_connection_t *settings,
                      altcp_recv_fn recv_fn, void* callback_arg, httpc_state_t **connection);
+err_t httpc_get_file_host(const ip_addr_t* server_addr, const char* host, u16_t port, const char* uri,
+                         const httpc_connection_t *settings, altcp_recv_fn recv_fn,
+                         void* callback_arg, httpc_state_t **connection);
 err_t httpc_get_file_dns(const char* server_name, u16_t port, const char* uri, const httpc_connection_t *settings,
                      altcp_recv_fn recv_fn, void* callback_arg, httpc_state_t **connection);
 err_t httpc_abort(httpc_state_t *connection);
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index be4a4264718..b3bb4a04198 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -86,8 +86,8 @@ int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len,
 static int parse_url(char *url, char *host, u16 *port, char **path,
 		     bool *is_https)
 {
-	char *p, *pp;
-	long lport;
+	char *p, *pp, *host_end;
+	unsigned int lport;
 	size_t prefix_len = 0;
 
 	if (!wget_validate_uri(url)) {
@@ -108,25 +108,33 @@ static int parse_url(char *url, char *host, u16 *port, char **path,
 	p += prefix_len;
 
 	/* Parse hostname */
-	pp = strchr(p, ':');
-	if (!pp)
-		pp = strchr(p, '/');
-	if (!pp)
+	pp = strchr(p, '/');
+	if (!pp || strcspn(p, "\r\n\t @#") < pp - p)
 		return -EINVAL;
-
-	if (p + SERVER_NAME_SIZE <= pp)
+	if (*p == '[') {
+		host_end = strchr(++p, ']');
+		if (!host_end || host_end >= pp ||
+		    (host_end[1] != ':' && host_end[1] != '/'))
+			return -EINVAL;
+		pp = host_end + 1;
+	} else {
+		host_end = memchr(p, ':', pp - p);
+		if (host_end)
+			pp = host_end;
+		else
+			host_end = pp;
+	}
+	if (host_end == p || host_end - p >= SERVER_NAME_SIZE)
 		return -EINVAL;
 
-	memcpy(host, p, pp - p);
-	host[pp - p] = '\0';
+	memcpy(host, p, host_end - p);
+	host[host_end - p] = '\0';
 
 	if (*pp == ':') {
 		/* Parse port number */
 		p = pp + 1;
-		lport = simple_strtol(p, &pp, 10);
-		if (pp && *pp != '/')
-			return -EINVAL;
-		if (lport > 65535)
+		pp = strchr(p, '/');
+		if (!pp || net_lwip_parse_decimal(p, pp - p, U16_MAX, &lport) || !lport)
 			return -EINVAL;
 		*port = (u16)lport;
 	}
@@ -292,10 +300,6 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
 	return ERR_OK;
 }
 
-
-#if CONFIG_IS_ENABLED(WGET_CACERT)
-#endif
-
 static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
 			       struct net_lwip_ctx *net)
 {
@@ -305,21 +309,27 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
 #endif
 	httpc_connection_t conn;
 	httpc_state_t *state;
+	ip_addr_t server;
+	char host[SERVER_NAME_SIZE + sizeof("[]:65535")];
 	err_t err;
 	int ret;
 
-	/* if URL with hostname init dns */
-	if (!ipaddr_aton(ctx->server_name, NULL)) {
-		ret = net_lwip_dns_init(net);
-		if (ret)
-			return ret;
-	}
+	ret = net_lwip_resolve(net, ctx->server_name, &server, IPADDR_TYPE_ANY);
+	if (ret)
+		return ret;
+	ret = net_lwip_prepare_addr(net, &server);
+	if (ret)
+		return ret;
+	if (strchr(ctx->server_name, ':'))
+		snprintf(host, sizeof(host), "[%s]:%u", ctx->server_name, ctx->port);
+	else
+		snprintf(host, sizeof(host), "%s:%u", ctx->server_name, ctx->port);
 
 	memset(&conn, 0, sizeof(conn));
 #if CONFIG_IS_ENABLED(WGET_HTTPS)
 	if (is_https) {
-		char *ca;
-		size_t ca_sz;
+		char *ca = NULL;
+		size_t ca_sz = 0;
 
 #if CONFIG_IS_ENABLED(WGET_CACERT) || CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
 #if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
@@ -369,8 +379,8 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
 
 	conn.result_fn = httpc_result_cb;
 	conn.headers_done_fn = httpc_headers_done_cb;
-	err = httpc_get_file_dns(ctx->server_name, ctx->port, ctx->path, &conn,
-				 httpc_recv_cb, ctx, &state);
+	err = httpc_get_file_host(&server, host, ctx->port, ctx->path, &conn,
+				  httpc_recv_cb, ctx, &state);
 	if (err) {
 		ret = -ENODEV;
 		goto out;
@@ -379,7 +389,11 @@ static int wget_handle_request(struct wget_ctx *ctx, bool is_https,
 	errno = 0;
 
 	while (!ctx->done) {
-		net_lwip_poll();
+		if (net_lwip_poll() < 0 && !ctx->done) {
+			ctx->aborted = true;
+			httpc_abort(state);
+			break;
+		}
 		if (!ctx->done && ctrlc()) {
 			ctx->aborted = true;
 			httpc_abort(state);
@@ -443,12 +457,11 @@ int wget_do_request(ulong dst_addr, char *uri)
  *
  * @uri:	uri string
  *
- * This function follows the current U-Boot wget implementation.
- * scheme: only "http:" is supported
+ * Supported schemes: HTTP and, when enabled, HTTPS.
  * authority:
  *   - user information: not supported
  *   - host: supported
- *   - port: not supported(always use the default port)
+ *   - port: optional; validated by the URL parser
  *
  * Uri is expected to be correctly percent encoded.
  * This is the minimum check, control codes(0x1-0x19, 0x7F, except '\0')
@@ -495,7 +508,7 @@ bool wget_validate_uri(char *uri)
 	if (!str_copy)
 		return false;
 
-	s = str_copy + strlen("http://");
+	s = str_copy + prefix_len;
 	authority = strsep(&s, "/");
 	if (!s) {
 		log_err("invalid uri, no file path\n");

-- 
2.53.0

